import { LightningElement, track, wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountContactController.getAccounts';
import getAccountCount from '@salesforce/apex/AccountContactController.getAccountCount';

const PAGE_SIZE = 5;

export default class ShowAccountsComponent extends LightningElement {
    @track accounts = [];
    @track error;
    @track totalAccounts = 0;
    @track currentPage = 1;
    @track totalPages = 0;

    @wire(getAccountCount)
    wiredAccountCount({ error, data }) {
        if (data) {
            this.totalAccounts = data;
            this.totalPages = Math.ceil(this.totalAccounts / PAGE_SIZE);
        } else if (error) {
            this.error = error;
            this.accounts = [];
        }
    }

    @wire(getAccounts, { pageNumber: '$currentPage', pageSize: PAGE_SIZE })
    wiredAccounts({ error, data }) {
        if (data) {
            this.accounts = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.accounts = [];
        }
    }

    handleAccountClick(event) {
        const accountId = event.target.dataset.id;
        const accountSelectedEvent = new CustomEvent('accountselected', {
            detail: accountId
        });
        this.dispatchEvent(accountSelectedEvent);
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
