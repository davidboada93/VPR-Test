import { LightningElement, api, wire, track } from 'lwc';
import getContactsByAccount from '@salesforce/apex/AccountContactController.getContactsByAccount';
import getContactCountByAccount from '@salesforce/apex/AccountContactController.getContactCountByAccount';

const PAGE_SIZE = 5;

export default class ShowContactsComponent extends LightningElement {
    @api accountId; 
    @track contacts = [];
    @track error;
    @track totalContacts = 0;
    @track currentPage = 1;
    @track totalPages = 0;

    @wire(getContactCountByAccount, { accountId: '$accountId' })
    wiredContactCount({ error, data }) {
        if (data) {
            this.totalContacts = data;
            this.totalPages = Math.ceil(this.totalContacts / PAGE_SIZE);
        } else if (error) {
            this.error = error;
            this.contacts = [];
        }
    }

    @wire(getContactsByAccount, { accountId: '$accountId', pageNumber: '$currentPage', pageSize: PAGE_SIZE })
    wiredContacts({ error, data }) {
        if (data) {
            this.contacts = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.contacts = [];
        }
    }

    nextPage() {
        if (this.currentPage < this.totalPages) {
            this.currentPage++;
        }
    }

    previousPage() {
        if (this.currentPage > 1) {
            this.currentPage--;
        }
    }

    get isPreviousDisabled() {
        return this.currentPage <= 1;
    }

    get isNextDisabled() {
        return this.currentPage >= this.totalPages;
    }
}
