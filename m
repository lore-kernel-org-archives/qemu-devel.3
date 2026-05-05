Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E77FF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 14:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKGjb-0005tz-Ru; Tue, 05 May 2026 10:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wKGjV-0005tG-Dt; Tue, 05 May 2026 10:26:45 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wKGjS-0006K2-FO; Tue, 05 May 2026 10:26:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEu76Y9Moe041Jd7aFDcgJeRaWZBFGDul+FiZuZTdX5AuancepVQq/8tvqM54goDh4XWVr4F0ziReJI2Netnf5/iIVUkkVjbehxEXH/ATl/ZTrzKtgNeemGN3jd2h1iL+Rv0Qr5pglcXSrSy9wtZhc8eCr9ZTdTO5RmehLEms5LO++78g5Ox0Y9v7CsOHZMQyvCWQAla7Ct/QNlZKM3dzI72AKbm1yPzn5N+WV0sk2eAUAFp24U3jr/sjZ4etaXqb0USYsfOJ3X3MupUAAfSzkq6ECC2HXPzVGSYy3Q6pAXEi8aP88QUTER3nc4I64m/0Ljaqgv6l6qpP3uKuR3isQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOM2Ec1nRCMH+9PFLM0ONx0D4jnPefJXv1mCqgogTu0=;
 b=SXnhEGqjlF8h1mN/RFxgS3z1hEH3QbR2yNJC2y01TY/BMGbugt5LDqEFgRbrBBrEKHwEEerX8+OA4IZGG8MU+25AJwZYugFb2AW6KLg4akqyyBsCZHiXEEy5Fu9GskrQeA1N3ngktn1+o5V/sHrPTyf1CxrqCbwGbCLhC42yTZB75qGxJRkYCrrQKsNEu34X3GA+S3tmueVR6eSO7Ja1EmufVFm2hrlzdB+XykmVtO/kZOvrSLHtSt3LJ2dJ84MByTSuI0BLvK76n2YpwhpBOOkHBd8lnG6l7RqFzjKWAWJwO656fEskNMDXoZyOlU3upQjrEYiOtZ/qbzV9F18bAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOM2Ec1nRCMH+9PFLM0ONx0D4jnPefJXv1mCqgogTu0=;
 b=l7yi+ATS/4Ulbdh9Zj2GOYjkNXdM7hVzpfTFz58BwZU+AZuiza7/Gdekp8IfAR/2bMMUiphIdSutMHzzw4SVfXHl8/qmns/iDO6QYYICjrm58HJXpRI8WdD75cD+KIzSgXMffy3RW/grHgLJNNWn/pQ6ufD47gKVt2MA8Gi2Vnce1/l4Kg6dFEcM8I/SV/QUox0J++ev3ayMazoVxUsIm8kUPLdUv0tz0JcPnTcMPmkQfEmZv9EGDfxFBk7wC8DwMxTw6iDgnAtmB0vm/Af3H6xPIidOfr4emcO7HyVnYqUHS+DQL28R5S7fT+dREL/uX68wg4RAPeFvZc13K94N3A==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DS0PR12MB8478.namprd12.prod.outlook.com (2603:10b6:8:15a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 14:26:29 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 14:26:29 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Nicolin Chen <nicolinc@nvidia.com>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>, "phrdina@redhat.com" <phrdina@redhat.com>
Subject: RE: [PATCH v4 19/31] hw/arm/tegra241-cmdqv: Allocate HW VCMDQs on
 base register programming
Thread-Topic: [PATCH v4 19/31] hw/arm/tegra241-cmdqv: Allocate HW VCMDQs on
 base register programming
Thread-Index: AQHczMa8RoKQGbMZKEKacCtQsK9v9LX/i7+AgAAIQAA=
Date: Tue, 5 May 2026 14:26:29 +0000
Message-ID: <CH3PR12MB7548F9BC9DCCE1D5899EA168AB3E2@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-20-skolothumtho@nvidia.com>
 <103d06a5-3203-4545-b617-517f695eb751@redhat.com>
In-Reply-To: <103d06a5-3203-4545-b617-517f695eb751@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DS0PR12MB8478:EE_
x-ms-office365-filtering-correlation-id: 73dd7b61-230f-4358-cd9e-08deaab24c6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info: Lnjdjk5MSRUw5jNGJkOQLdmfTPxSAhem1fL76JToXOmSr3AIFCuiXJdJeU8/EHhtjF8oM4qzN7NmHeXAWwCvD/tuPG2Oe1ypK6ealRcx151qL6x1PB2y+c5q+Z9ODDmj2GWtQERVkc8AGquhpR7U5I2QxOUukGagUjRKBeBzyfJRLs5k+iy5+R4KYj0m2qyZPMDD7hYntNxhFyPikCZPILZST5omdQe+pUornFAze85tAmorxzYLGzpqy300NHcekE4Wge9nQJgWKYdE3KxpiuSHfIFARGVXCmJM86DPbrIZtUlniieSduV1OIcFilZ6kMWuEd3FjTBj/Myh63F4L0z0OVmG5IFpu1EJTv74uqGvnydZ3m3VvpAWLKUYg8l6KiZMj3OGlylYcMTjgrECqva3bkMRH7zK3OG7Ccz5lxEZLeZzWhDGkqx/q8u86s5bKvvyVg7Sz+zy1cQxMt8kJadNkdW89cz6+OPJ1NclIbRBme1hpCApy2K7jpsw320bEXlJyKERMW9BpNLvPAncOsZ/i7O7fBlCpCbVW3r0eN/LPSpWSPYTG6/wF+bau1obzqygdATb0xr7iJttofS/KhZ+4cjaMp2Fid0X0IzGpFCGZo15JAAL+YnIOAn9U9oEDdAhu7BKo7C3sqBb6dpkp90j/vxc8u/H4PefeUOdllIxJncGRheRvq8Ie+vwoEpMqIwcw3HO1DbvoGSeU8XE3KmPrdtXp0mdoXzwrjyY+TDV2NBPMBIg8IimRJuLdxD9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDNWT0Y5TUJIbFJlWkFzdEJKZkc2Smg3aFRyVDlDMHcxeVdTRnc5TW05RWZG?=
 =?utf-8?B?eUxBS0t6RzZmaEIwYjljakJIWkVVWTMxNXBmUDB0UkNrb3NjNVoxakg2azdI?=
 =?utf-8?B?MWY1RlNJWWt0NlVCNXhpbGlPSU5nOFcveDFkRDBlK3k4QXA4RG96dVEvaHFD?=
 =?utf-8?B?V0xMOXFhSTVLS0pHQjhMKzV4NFVBRDFQa2prVGFDUVQvRDlDVjlITXdpVmkz?=
 =?utf-8?B?bkJEck80b1VFakk4SlhtWDFONmNEMkdvbDdwcGZXUFpSSzAwK0FGTmpOWDZB?=
 =?utf-8?B?WWVRU2daN1ZoRE9YWjdwZEIzaHpod1hyRGhKQ0ptSFMremVFS3owTHAyUGhT?=
 =?utf-8?B?RkFiQitTWWgvRC9SSk51b0tGZjduZUJQZU5HVGU0c2FCNTA1SVRGMzdIR1Bx?=
 =?utf-8?B?ZjlWenBzMkw4OUIzdDljR05Od1hJb1BtRDRKYVZja0h6VnNwYUxQM0FBTmk2?=
 =?utf-8?B?eFFQRzA2ME82N0VPc3dQSnFabDQ3Q0tvbldHWFB1ZVRpbG9nYm55K3krZkpq?=
 =?utf-8?B?NFlDT3kyb20vNUZ3b3o5V21EcXlLeHNnWGZybkpabEFyaGlLd0RLUGhTeCtR?=
 =?utf-8?B?bUd2aHd3UnR3eDRod0JYakc0VXhYTzhHUHRqSkEvSW1tYXA5bThDNEFHdllo?=
 =?utf-8?B?bjI4ZVR1RGFzSnIxSks2MmladW15U241RE9jTThkdnlIa0dDRXljaXM0aDRp?=
 =?utf-8?B?NDJCd1VkK1JNY2pNN21ucnh6L1A0TGExbFVpbUVIVVdzaWJ6cjErdG1MWkxX?=
 =?utf-8?B?MGJ2NGwrOFNMUmJmRnJCVnFjWW1wWHBzMFRPMGthV2xucFJxWlJMbGxyZEZV?=
 =?utf-8?B?empFSytBRGdaUG1odkZHd21CVlM0clJtblhpODJQTGo1RnB4TzJhZ29sem54?=
 =?utf-8?B?MGtXK3JLVUh1WURMMXlLQTdsbUdTVHdTUWFFTlNZVlBnanVYOVJyQ3RMSXJj?=
 =?utf-8?B?U0I1RFAzdUNXaGF1L3ZFN2o3RWRqOVB5Qm5NcDJYaXBZVXFWRzhVZ0JoSi9o?=
 =?utf-8?B?TVFjdHRkeTB1T0lObjFSY3Q1OWtDbjFxd05WZStOTit3cW9GWXFNMTBzcjYr?=
 =?utf-8?B?emFnMzZ6bjExWVJoY09QZlZESkpBZEt2SDE0clRsampGTFhGbVFrY1hvbUoz?=
 =?utf-8?B?bzN2ODc2WkVvM0M3cStaYzZGVTBpdk90OU1ETkx1TjFVUHZxNnhKS2FiRnoz?=
 =?utf-8?B?NmpWdTI3ZUl0akMwTnpBZTlOODliRWlSaGJhZENoOVpQL1kyWW1NNUdSK2xZ?=
 =?utf-8?B?TDRScThYSXRCbkgxYVJnWElhaDlaVVZydXgxUi9uNndIZmgyekNEekM1VUg1?=
 =?utf-8?B?d0t5WnMzb2ZMNXFhU2Z2SGV3R3NPQnRCSXYwRlBmQW8ydWdRdXBMcU5lVEZk?=
 =?utf-8?B?UDVRRys1SnBRdnZ6QkRGUWdhUUNFcC9Tb3pIeUE3K0JJL0huWGFzTGMySW1a?=
 =?utf-8?B?d1JvR0R2VXpHdHVsMllTNi9aSmgwSDQ1OTRVeG81eEw0WWg3bWpiaHBtbDA5?=
 =?utf-8?B?elRJa1MwbEREb1hYK0E0c3phYlo4RkcxanFWQ2FIMlgrOENlaTg1dUZKc29t?=
 =?utf-8?B?T1JDV3BTT1JabldjWGFVenQ4QmdVR1ZWTCtEVXRFQmFST1V3d1ExdXFVRy9q?=
 =?utf-8?B?WnlEdVRBUkwxTE1COWcxSGxSbXhBdzhKK0VKUmdPdUpsVGt2enRoTncxVGcz?=
 =?utf-8?B?ZWhPLzZjam5aY1FuS2QxaVZMK0JpQjJkWXJiR1hDcTZNNHJ6OHVzUTlLK1hO?=
 =?utf-8?B?ZmJnM2pKd0RXSWt6Yk4xR1g5NXlkWE83Z29laFhkaEtIWXJGY2pPc042ZDdj?=
 =?utf-8?B?eG94R2lsNFJNd05odFppU0xqM3J2VVNjdGdaL0kvc3IxTVlLQXlab09KWXYx?=
 =?utf-8?B?dklPOElrVTZ5NG5tMnBVSG1pbGt3c2pOaEpWbjZaM0V6c0tiaFQ1VVlvcjlN?=
 =?utf-8?B?TnM1WmpXd3FvRDY0clZrbnBDcml5eDBOZVVDSEU5MlJFQ3FmazYzcklGTEww?=
 =?utf-8?B?RjdHc256dEFNUzRDK0hEWUw3UlZIMW1OcUJpeW00VFFXUGMvVDh0dktaNFlp?=
 =?utf-8?B?NnpGNXFBODU3MEZKcDNGVFJpdG52cHdpbWpZS0xQZ1BHb3ZuUEJxbVNhUVdK?=
 =?utf-8?B?V3ZxWG96YW10Q2FpSnRIMng0YVgvUHRGaW95OUpXVkxzclQ3SlpDSXBWQ0RH?=
 =?utf-8?B?UyszYkU4d1FVQVc2QTgxNDgzVEFTbG12MHk0YktBQ3pXWmRvU20vUWNuR2kr?=
 =?utf-8?B?UC9oK0VxS2xJNmpIRm12UCtOSjN6S0FuQTBVK3BrY2QrZnJqM1JnN1VHeXB5?=
 =?utf-8?B?VE4rbStGQTlGcElhS0ZVbjVleEMwYnhjYkZTMnByanBEREtPQzVyUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73dd7b61-230f-4358-cd9e-08deaab24c6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 14:26:29.5785 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zc8T3GAqSt5g386VSK8ukrEOICfPXzfOzVvwZW7ZQNseJ2lcfjCuhu5L8rydr7mNzgbXvNYbCIg1YYbMwPlNNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8478
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAwNSBNYXkgMjAyNiAxNDoyNg0KPiBUbzogU2hh
bWVlciBLb2xvdGh1bSBUaG9kaSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBxZW11LQ0KPiBh
cm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwZXRlci5tYXlkZWxs
QGxpbmFyby5vcmc7IGNsZ0ByZWRoYXQuY29tOyBhbGV4QHNoYXpib3Qub3JnOyBOaWNvbGluDQo+
IENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEu
Y29tPjsgTWF0dA0KPiBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsgSmlhbmRpIEFuIDxqYW5AbnZp
ZGlhLmNvbT47IEphc29uIEd1bnRob3JwZQ0KPiA8amdnQG52aWRpYS5jb20+OyBqb25hdGhhbi5j
YW1lcm9uQGh1YXdlaS5jb207DQo+IHpoZW56aG9uZy5kdWFuQGludGVsLmNvbTsgS3Jpc2huYWth
bnQgSmFqdSA8a2phanVAbnZpZGlhLmNvbT47DQo+IHBocmRpbmFAcmVkaGF0LmNvbQ0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHY0IDE5LzMxXSBody9hcm0vdGVncmEyNDEtY21kcXY6IEFsbG9jYXRl
IEhXDQo+IFZDTURRcyBvbiBiYXNlIHJlZ2lzdGVyIHByb2dyYW1taW5nDQo+IA0KPiBFeHRlcm5h
bCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4g
DQo+IEhpLA0KPiANCj4gT24gNC8xNS8yNiAxMjo1NSBQTSwgU2hhbWVlciBLb2xvdGh1bSB3cm90
ZToNCj4gPiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+ID4NCj4g
PiBBZGQgc3VwcG9ydCBmb3IgYWxsb2NhdGluZyBJT01NVUZEIGhhcmR3YXJlIHF1ZXVlcyB3aGVu
IHRoZSBndWVzdA0KPiA+IHByb2dyYW1zIHRoZSBWQ01EUSBCQVNFIHJlZ2lzdGVycy4NCj4gPg0K
PiA+IFZDTURRX0VOIGlzIHBhcnQgb2YgdGhlIFZDTURRX0NPTkZJRyByZWdpc3Rlciwgd2hpY2gg
aXMgYWNjZXNzZWQNCj4gPiB0aHJvdWdoIHRoZSBWSU5URiBQYWdlMCByZWdpb24uIEEgc3Vic2Vx
dWVudCBwYXRjaCBtYXBzIHRoaXMgcmVnaW9uDQo+ID4gZGlyZWN0bHkgaW50byB0aGUgZ3Vlc3Qg
YWRkcmVzcyBzcGFjZSwgc28gUUVNVSBkb2VzIG5vdCB0cmFwIHdyaXRlcw0KPiA+IHRvIFZDTURR
X0NPTkZJRy4NCj4gPg0KPiA+IFNpbmNlIFZDTURRX0VOIHdyaXRlcyBhcmUgbm90IHRyYXBwZWQs
IFFFTVUgY2Fubm90IGFsbG9jYXRlIHRoZQ0KPiA+IGhhcmR3YXJlIHF1ZXVlIGJhc2VkIG9uIHRo
YXQgYml0LiBJbnN0ZWFkLCBhbGxvY2F0ZSB0aGUgSU9NTVVGRA0KPiA+IGhhcmR3YXJlIHF1ZXVl
IHdoZW4gdGhlIGd1ZXN0IHdyaXRlcyBhIFZDTURRIEJBU0UgcmVnaXN0ZXIgd2l0aCBhDQo+ID4g
dmFsaWQgUkFNLWJhY2tlZCBhZGRyZXNzIGFuZCB3aGVuIENNRFFWIGFuZCBWSU5URiBhcmUgZW5h
YmxlZC4NCj4gPiBJZiBhIGhhcmR3YXJlIHF1ZXVlIHdhcyBwcmV2aW91c2x5IGFsbG9jYXRlZCBm
b3IgdGhlIHNhbWUgVkNNRFEsDQo+ID4gZnJlZSBpdCBiZWZvcmUgcmVhbGxvY2F0aW9uLg0KPiB0
aGUgYXN5bWV0cmljIGFsbG9jL2ZyZWUgc291bmRzIHVudXN1YWwuIEFyZSB0aGVyZSBvdGhlciBh
bHRlcm5hdGl2ZXM/DQoNCk5vdGhpbmcgdGhhdCBjb21lcyB0byBteSBtaW5kIG5vdy4gVGhlcmUg
aXMgbm8gInVwZGF0ZSBod19xdWV1ZSBhZGRyZXNzIg0KaGVuY2Ugd2UgaGF2ZSB0byBmcmVlIGFu
ZCBhbGxvY2F0ZS4gTWF5IGJlIHdlIGNhbiBhZGQgYSBzbWFsbCBvcHRpbWlzYXRpb24NCmFuZCBz
a2lwIGZyZWUgKyBhbGxvYyBpZiB0aGUgdmNtZHFfYmFzZVtpbmRleF0gaGFzbid0IGNoYW5nZWQg
ZnJvbQ0KcHJldmlvdXMgYWxsb2MuDQoNCj4gPg0KPiA+IFdyaXRlcyB3aXRoIGludmFsaWQgYWRk
cmVzc2VzIGFyZSBpZ25vcmVkLg0KPiA+DQo+ID4gQWxsIGFsbG9jYXRlZCBWQ01EUXMgYXJlIGZy
ZWVkIHdoZW4gQ01EUVYgb3IgVklOVEYgaXMgZGlzYWJsZWQuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+ID4gU2lnbmVkLW9mZi1i
eTogU2hhbWVlciBLb2xvdGh1bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+DQo+ID4gLS0tDQo+
ID4gIGh3L2FybS90ZWdyYTI0MS1jbWRxdi5oIHwgMTEgKysrKysrKw0KPiA+ICBody9hcm0vdGVn
cmEyNDEtY21kcXYuYyB8IDcwDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNzggaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9hcm0vdGVncmEyNDEtY21kcXYuaCBiL2h3
L2FybS90ZWdyYTI0MS1jbWRxdi5oDQo+ID4gaW5kZXggODg1NzJhZDkzOS4uMDM5ZDg2Mzc0ZiAx
MDA2NDQNCj4gPiAtLS0gYS9ody9hcm0vdGVncmEyNDEtY21kcXYuaA0KPiA+ICsrKyBiL2h3L2Fy
bS90ZWdyYTI0MS1jbWRxdi5oDQo+ID4gQEAgLTQ0LDYgKzQ0LDcgQEAgdHlwZWRlZiBzdHJ1Y3Qg
VGVncmEyNDFDTURRViB7DQo+ID4gICAgICBNZW1vcnlSZWdpb24gbW1pb19jbWRxdjsNCj4gPiAg
ICAgIHFlbXVfaXJxIGlycTsNCj4gPiAgICAgIElPTU1VRkRWZXZlbnRxICp2ZXZlbnRxOw0KPiA+
ICsgICAgSU9NTVVGREhXcXVldWUgKnZjbWRxW1RFR1JBMjQxX0NNRFFWX01BWF9DTURRXTsNCj4g
PiAgICAgIHZvaWQgKnZpbnRmX3BhZ2UwOw0KPiA+DQo+ID4gICAgICAvKiBSZWdpc3RlciBDYWNo
ZSAqLw0KPiA+IEBAIC0zNDgsNiArMzQ5LDE2IEBAIEFfVklfVkNNRFFpX0NPTlNfSU5EWF9CQVNF
X0RSQU1fTCgxKQ0KPiA+ICBBX1ZJX1ZDTURRaV9DT05TX0lORFhfQkFTRV9EUkFNX0goMCkNCj4g
PiAgQV9WSV9WQ01EUWlfQ09OU19JTkRYX0JBU0VfRFJBTV9IKDEpDQo+ID4NCj4gPiArc3RhdGlj
IGlubGluZSBib29sIHRlZ3JhMjQxX2NtZHFfZW5hYmxlZChUZWdyYTI0MUNNRFFWICpjbWRxdikN
Cj4gPiArew0KPiA+ICsgICAgcmV0dXJuIGNtZHF2LT5zdGF0dXMgJiBSX1NUQVRVU19DTURRVl9F
TkFCTEVEX01BU0s7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbmxpbmUgYm9vbCB0ZWdy
YTI0MV92aW50Zl9lbmFibGVkKFRlZ3JhMjQxQ01EUVYgKmNtZHF2KQ0KPiA+ICt7DQo+ID4gKyAg
ICByZXR1cm4gY21kcXYtPnZpbnRmX3N0YXR1cyAmIFJfVklOVEYwX1NUQVRVU19FTkFCTEVfT0tf
TUFTSzsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgY29uc3QgU01NVXYzQWNjZWxDbWRxdk9wcyAqdGVn
cmEyNDFfY21kcXZfZ2V0X29wcyh2b2lkKTsNCj4gPg0KPiA+ICAjZW5kaWYgLyogSFdfQVJNX1RF
R1JBMjQxX0NNRFFWX0ggKi8NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL3RlZ3JhMjQxLWNtZHF2
LmMgYi9ody9hcm0vdGVncmEyNDEtY21kcXYuYw0KPiA+IGluZGV4IGNkZDk0MWNlYzkuLmI1ZjJm
NzRjZjIgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL3RlZ3JhMjQxLWNtZHF2LmMNCj4gPiArKysg
Yi9ody9hcm0vdGVncmEyNDEtY21kcXYuYw0KPiA+IEBAIC0xNSw2ICsxNSw2NiBAQA0KPiA+ICAj
aW5jbHVkZSAidGVncmEyNDEtY21kcXYuaCINCj4gPiAgI2luY2x1ZGUgInRyYWNlLmgiDQo+ID4N
Cj4gPiArc3RhdGljIHZvaWQgdGVncmEyNDFfY21kcXZfZnJlZV92Y21kcShUZWdyYTI0MUNNRFFW
ICpjbWRxdiwgaW50DQo+IGluZGV4KQ0KPiA+ICt7DQo+ID4gKyAgICBJT01NVUZEVmlvbW11ICp2
aW9tbXUgPSBjbWRxdi0+c19hY2NlbC0+dmlvbW11Ow0KPiA+ICsgICAgSU9NTVVGREhXcXVldWUg
KnZjbWRxID0gY21kcXYtPnZjbWRxW2luZGV4XTsNCj4gPiArDQo+ID4gKyAgICBpZiAoIXZjbWRx
KSB7DQo+ID4gKyAgICAgICAgcmV0dXJuOw0KPiA+ICsgICAgfQ0KPiA+ICsgICAgaW9tbXVmZF9i
YWNrZW5kX2ZyZWVfaWQodmlvbW11LT5pb21tdWZkLCB2Y21kcS0+aHdfcXVldWVfaWQpOw0KPiA+
ICsgICAgZ19mcmVlKHZjbWRxKTsNCj4gPiArICAgIGNtZHF2LT52Y21kcVtpbmRleF0gPSBOVUxM
Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCB0ZWdyYTI0MV9jbWRxdl9mcmVlX2Fs
bF92Y21kcShUZWdyYTI0MUNNRFFWICpjbWRxdikNCj4gPiArew0KPiA+ICsgICAgLyogRnJlZSBp
biByZXZlcnNlIG9yZGVyIHRvIGF2b2lkICJyZXNvdXJjZSBidXN5IiBlcnJvciAqLw0KPiBjYW4g
eW91IHByb3ZpZGUgYWRkaXRpb25hbCBkZXRhaWxzIGFib3V0IHRoZSBhYm92ZSBwcm9ibGVtYXRp
Yy4gSXMgaXQNCj4gZG9jdW1lbnRlZCBpbiB0aGUgc3BlYz8NCg0KU2VlIHAuMTc2Og0KDQpEZWFs
bG9jYXRlIGEgVkNNRFEgZnJvbSBhIFZpcnR1YWwgSW50ZXJmYWNlIA0KICAgIExvZ2ljYWwgQ01E
USBiZWluZyBkZWFsbG9jYXRlZCBmb3IgYSBHdWVzdCBtdXN0IGJlIGluIGRlY3JlYXNpbmcgb3Jk
ZXINCiAgICBzdGFydGluZyBmcm9tIHRoZSBoaWdoZXN0IG51bWJlcmVkIExWQ01EUS4NCg0KPiA+
ICsgICAgZm9yIChpbnQgaSA9IChURUdSQTI0MV9DTURRVl9NQVhfQ01EUSAtIDEpOyBpID49IDA7
IGktLSkgew0KPiA+ICsgICAgICAgIHRlZ3JhMjQxX2NtZHF2X2ZyZWVfdmNtZHEoY21kcXYsIGkp
Ow0KPiA+ICsgICAgfQ0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgYm9vbCB0ZWdyYTI0MV9j
bWRxdl9zZXR1cF92Y21kcShUZWdyYTI0MUNNRFFWICpjbWRxdiwgaW50DQo+IGluZGV4LA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApDQo+
ID4gK3sNCj4gPiArICAgIFNNTVV2M0FjY2VsU3RhdGUgKmFjY2VsID0gY21kcXYtPnNfYWNjZWw7
DQo+ID4gKyAgICB1aW50NjRfdCBiYXNlX21hc2sgPSAodWludDY0X3QpUl9WQ01EUTBfQkFTRV9M
X0FERFJfTUFTSyB8DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAodWludDY0X3QpUl9W
Q01EUTBfQkFTRV9IX0FERFJfTUFTSyA8PCAzMjsNCj4gPiArICAgIHVpbnQ2NF90IGFkZHIgPSBj
bWRxdi0+dmNtZHFfYmFzZVtpbmRleF0gJiBiYXNlX21hc2s7DQo+ID4gKyAgICB1aW50NjRfdCBs
b2cyID0gY21kcXYtPnZjbWRxX2Jhc2VbaW5kZXhdICYNCj4gUl9WQ01EUTBfQkFTRV9MX0xPRzJT
SVpFX01BU0s7DQo+ID4gKyAgICB1aW50NjRfdCBzaXplID0gMVVMTCA8PCAobG9nMiArIDQpOw0K
PiA+ICsgICAgSU9NTVVGRFZpb21tdSAqdmlvbW11ID0gYWNjZWwtPnZpb21tdTsNCj4gPiArICAg
IElPTU1VRkRIV3F1ZXVlICpod19xdWV1ZTsNCj4gPiArICAgIHVpbnQzMl90IGh3X3F1ZXVlX2lk
Ow0KPiA+ICsNCj4gPiArICAgIC8qIElnbm9yZSBhbnkgaW52YWxpZCBhZGRyZXNzLiBUaGlzIG1h
eSBjb21lIGFzIHBhcnQgb2YgcmVzZXQgZXRjLiAqLw0KPiA+ICsgICAgaWYgKCFhZGRyZXNzX3Nw
YWNlX2lzX3JhbSgmYWRkcmVzc19zcGFjZV9tZW1vcnksIGFkZHIpIHx8DQo+ID4gKyAgICAgICAg
IWFkZHJlc3Nfc3BhY2VfaXNfcmFtKCZhZGRyZXNzX3NwYWNlX21lbW9yeSwgYWRkciArIHNpemUg
LSAxKSkgew0KPiB0aGlzIGNoZWNrIGxvb2tzIGEgbGl0dGxlIGJpdCByaXNreSwgbm8/IERvbid0
IHdlIGhhdmUgYSBiZXR0ZXIgd2F5IHRvDQo+IHRlc3QgdGhlIGFkZHJlc3MgaGFzIGJlZW4gcHJv
cGVybHkgc2V0Pw0KDQpJIHRoaW5rIGV2ZW50dWFsbHkga2VybmVsIHdpbGwgaGFuZGxlIGFueSBh
dHRlbXB0IHRvIHVzZSBhbiBpbnZhbGlkIGFkZHJlc3MNCnRocm91Z2ggSU9NTVVfSFdfUVVFVUVf
QUxMT0MgSU9DVEw6DQogICAgIGlvbW11ZmRfaHdfcXVldWVfYWxsb2NfcGh5cygpL2lvbW11ZmRf
YWNjZXNzX3Bpbl9wYWdlcygpIGV0Yy4NCg0KQW55IGF0dGVtcHQgdG8gcGFzcyBhbiBpbnZhbGlk
IGFkZHJlc3Mgd2lsbCByZXR1cm4gZXJyb3IsIEkgdGhpbmsuDQoNCkBOaWNvbGluLCBpcyB0aGF0
IGEgc2FmZSBhc3N1bXB0aW9uIHRvIG1ha2U/DQoNCj4gPiArICAgICAgICByZXR1cm4gdHJ1ZTsN
Cj4gPiArICAgIH0NCj4gPiArDQo+ID4gKyAgICBpZiAoIXRlZ3JhMjQxX2NtZHFfZW5hYmxlZChj
bWRxdikgfHwNCj4gIXRlZ3JhMjQxX3ZpbnRmX2VuYWJsZWQoY21kcXYpKSB7DQo+ID4gKyAgICAg
ICAgcmV0dXJuIHRydWU7DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICsgICAgdGVncmEyNDFfY21k
cXZfZnJlZV92Y21kcShjbWRxdiwgaW5kZXgpOw0KPiB3b3VsZCBkZXNlcnZlIGEgY29tbWVudCBh
bHNvIGhlcmUuDQoNClN1cmUuDQoNClRoYW5rcywNClNoYW1lZXINCg==

