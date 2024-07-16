using { BusinessPartnerA2X } from './external/BusinessPartnerA2X.cds';

using { riskmanagement as my } from '../db/schema.cds';

@path : '/service/riskmanagementService'
service riskmanagementService
{
    annotate Mitigation with @restrict :
    [
        { grant : [ 'READ' ], to : [ 'RiskViewer' ] },
        { grant : [ '*' ], to : [ 'RiskManager' ] }
    ];

    annotate Risks with @restrict :
    [
        { grant : [ 'READ' ], to : [ 'RiskViewer' ] },
        { grant : [ '*' ], to : [ 'RiskManager' ] }
    ];

    @odata.draft.enabled
    entity Risks as
        projection on my.Risks;

    @odata.draft.enabled
    entity Mitigation as
        projection on my.Mitigation;

    entity A_BusinessPartner as projection on BusinessPartnerA2X.A_BusinessPartner
    {
        BusinessPartner,
        Customer,
        Supplier,
        BusinessPartnerCategory,
        BusinessPartnerFullName,
        BusinessPartnerIsBlocked
    };
}

annotate riskmanagementService with @requires :
[
    'authenticated-user',
    'RiskViewer',
    'RiskManager'
];
