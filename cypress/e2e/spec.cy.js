/// <reference types="cypress" />

describe("My First Test", () => {
    it("Visits website", () => {
        cy.visit("http://localhost:3333");

        cy.contains("Hello!");
    })
});
