Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6744CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 09:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPzxP-0005Ye-9Q; Thu, 21 May 2026 05:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPzxB-0005XH-El; Thu, 21 May 2026 05:44:33 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPzx9-0000QQ-K1; Thu, 21 May 2026 05:44:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lGJ0pBojTqihTiWSJsKXeaui1IaFv2h11pWUgvrIWPKROEg7Kmnh5xX+dMfN/N30YEXkiaUbpJvyXOiuJ+iYvyyrJrBcmg405E0xa+1B0KZBfpOhjwBBWTAtNx0/3JjuWmX/bNqp1IcV0qJ89xNEAAkwrizwN7m9mcjUhx4baAkvriuddapWIgA/Qu5hqkKVDJpVUxCn/STnTrML3xuzGWSCB3xt7owMMySEqHavlGKWo1eblvuwxNbGOP2WnLamGaJaZlaf+6IZdtmw1SYwXQc0ggX6or3gHN7yKNmOUusXXB913Rxbc32tbY5OLXorljrBUJmLuRMgauaEWOCDng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOpI/PP5HafsjmA9OuOxENuKz2dO2jY1VDm7cvwWYQs=;
 b=cqqrjn9z7w3tlIbXA/77IdBuSNCrlNwk4lwzJhOV9Q7VYi9oKQljKleUG3seG8iGSFt0QzsHGvoekOElFmDVWsIHkA3750NJMQlAuhfnnI0+yhG1ZJWXl5dlLAsNKm8Uj5nC87/4NsD9BPMMqz7fiKXKtd4/oqFgdMT6S/jgEDZPKelx2UyxTPENUd92G3ZSwd2hvlaCe5myek+kipC2Mh5msVxAbJdyQDj45V58HtUeExuEhgc8/mwxrFMNEcuhWObJNiIWj1+1h7OxO2S5VP44YwVEBrMf9dwqdIVUjEWUVU3aL1N3Eiq+o6J8ZdMtKFI2aGDCpqhfO3j8tnQv3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOpI/PP5HafsjmA9OuOxENuKz2dO2jY1VDm7cvwWYQs=;
 b=uQJ/x7Gh4weOdefwZosxSylvW1wfGG8FpsQGU1WaU8mh3QlkFeaLRYbeymd60AD0x5+exvkbyKSOp6FgVWGaK6GuRs29JlNNzGZwfsMLVFZeL6I+yt/gEIx0yaIUnFVgVa81jWPJ0UBQd04oK8c3KMlwwe4oIdYdjnxXBQeAHwlD2EcH8vdoCHsqiUbk0wP6vij4VLKgBMCtHOutJ6k4fmu4eD8bThmF+MgoMDqpGCY/TMpflfAZBMQgYNlBoq8ARyQlAg2sfggsTEKmi6uOm4nFgF8vZimeC1M8h7JO9/KyGpbCsyo3VcfVYqDP3oZ5XScHyeeeX7RQfdbJSPXeYQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DS0PR12MB8072.namprd12.prod.outlook.com (2603:10b6:8:dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 09:44:22 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 09:44:21 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>, "phrdina@redhat.com"
 <phrdina@redhat.com>
Subject: RE: [PATCH v5 17/32] hw/arm/tegra241-cmdqv: mmap VINTF Page0 for CMDQV
Thread-Topic: [PATCH v5 17/32] hw/arm/tegra241-cmdqv: mmap VINTF Page0 for
 CMDQV
Thread-Index: AQHc53vPgzHMdzCVJUyI0UoOS0aBX7YW4H8AgAAoG0CAARgfAIAAFi4Q
Date: Thu, 21 May 2026 09:44:21 +0000
Message-ID: <CH3PR12MB754835F2AE265DC7ADC32DBCAB0E2@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
 <20260519103727.899332-18-skolothumtho@nvidia.com>
 <c0dd92b2-4ea9-45a2-afbf-b61910f71fe6@redhat.com>
 <CH3PR12MB75486D02EEBCE74D47B20834AB012@CH3PR12MB7548.namprd12.prod.outlook.com>
 <f0909a11-9bc5-47b5-a50e-b3fee4a5bdf8@redhat.com>
In-Reply-To: <f0909a11-9bc5-47b5-a50e-b3fee4a5bdf8@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DS0PR12MB8072:EE_
x-ms-office365-filtering-correlation-id: e7711911-b8ee-41f1-9b36-08deb71d8908
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|11063799006|56012099003|18002099003|22082099003|4143699003|6133799003|3023799007|38070700021;
x-microsoft-antispam-message-info: 1e/kRO0WX+42bUz07KAWeIvzwfTy18pa3AlLAuoOP/9w3+93K+Fhab+28PI38/QskxA2I0/F4yEAcd94Tg8T+GVhF/uD2ViyC779sQCRz9D6NfO7+LECr7/H0vqHvswjYDp6Psw0adVlsMTPYeez+D8DklNzIN35snIu3LANEGV95Rl13jvS+0VDoAn55axQQ8usav8PvUMXAq01el4kHArwFyl5ZJoaNVfMYw/QIhz0Fh3g+u4d4BhoxMDr67AvAtulgVMEOZrea6wAwFw3tRL6gbpoP0sylIfb21hsd2DgylgZEVa/CUmEbPAqtxUlFxBwbszotQvIkd0aBzLN6sJ8KKE1iu3AxODDKAMr9zNVli4U8m2GPrgoLAyr2qXogS4F2HoO52B4zue+hyizQOiIcffSq05Lm8D14puYelQ1lHlyeGlqLCepASg/anCrJH4+dh6lfau7ZzeLns22Fig/ipjVA0A6qdi2Tra3jGEiOAS6foO1p79whjjQeq9AI9Wob0Jhac0inJGxBvkvSwb5SjsLVKnQwld7HWhLL3CjdRcU6BYzATi+ufoGdlvGRJgXMhKUNZzn1+ntPvCaPH+3O0j1ulwJqqIRapv0YQ6+Fh5Fqs+wXfqlDv6MucdFKykYS8ozDYV4sT+uS7VmjRaAobquGB6MrUEJSmNFq8G7PHZmTpLxPDm1uDTt3C+V1gGuzguZaZnAorgJL39IPUDe5hrKFQ3lKEaR9nEtUUoEVUq+POdvIhV7RhQnLd/+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(56012099003)(18002099003)(22082099003)(4143699003)(6133799003)(3023799007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUNTcXBSQUwwbGRhYm1IWjFSeHFPWWNsN1NVQ1lHTDIxUC9zU1RRYzRkdHFa?=
 =?utf-8?B?WXVOTDRZdlpzZWgvblFTcDFSbmtGYTlLbFljNGZrVTJLb2xpWjYrczNvOWQ5?=
 =?utf-8?B?dTVPN2s4M2RXTnJoVHRYY2dXV2o3UnE4ME5yVkxwLzZwRkpoeTltVTIzR1pm?=
 =?utf-8?B?R2FUQjQxME02UHZyZ1g4d015dG5iM1BEYmM1WGI5c3V5d21kblhGdmYzMURs?=
 =?utf-8?B?ZzFSaDEwbksrNUJ2U0JjM0NkWFhxNm9QODNLZmxhbVY5SzF5VjIyMHdyTlY2?=
 =?utf-8?B?ZTlyUzVDb2Z3UnNxRThWeWFvUjdHbFF0M3lQOGQ5WWJ2S2lPTWRDWWYrck5G?=
 =?utf-8?B?Z2U3akRkTHpEaEcxV3Z5QjJLUkRsWnhFYkJjN3BCdVp4bllHN241aFlid2Vr?=
 =?utf-8?B?eHdtQTBTclAxVkRjWlZHZEc0UnJhcEdkVjBxWUJOMjcwTTJLcFkwMnJZWDND?=
 =?utf-8?B?MnA2cnh0akoxdW9yM2IwYTk0MEEwZ0RTcjEwN0wyTTdrMStxdVpsOFVGZGtm?=
 =?utf-8?B?emZKWVZJK292L21nbU5FUUtoWmNIMWdlek15Q25GdFFMam5PZ2YyRUNJbHdV?=
 =?utf-8?B?MnRFV3dlVVAwOWxtM2U0RndKR3NSblZhR3QvcDBHMStmZ3g3dFprR0NGZldv?=
 =?utf-8?B?SXpkTnZjNjg5SGcvN3FOWmkydm1lVXNFdGVBN0sxMFZJUUJ3aFFBa3Flb3pQ?=
 =?utf-8?B?Q3R4aVc1KzN3bjB5bmRFNFE3Z2puYlZOVEIxc3BJaHRXRFM4ajMzNjNIV3Bw?=
 =?utf-8?B?ejg5VVVLVEpVOGpMZlg4UUxLYmt5YmpBdldkeGs1elhHZVQvYk84cUNnOEd0?=
 =?utf-8?B?b2orOGZCMFlsUkhuVHk3WlAxK2FBTWRRR2hxaUUvVytUU2IrM3FaUXZNQTVN?=
 =?utf-8?B?djFrZ2FiQnBBSWs0TG9ldjdndTdRRzEvNkhRS1BCTlBlQUtBazl6MTdjVWMy?=
 =?utf-8?B?UFlVTEk0NERsRkI4dFdod0dZdDFUTTdtTUZZRkNlWVJHcHZEYTBDTWhZay9u?=
 =?utf-8?B?Wk4wNVBOUHBwTXJZcEoxSnllMXErdjU3QnVvVzJNQ2NQbW1wNzVqdGhLNFN1?=
 =?utf-8?B?eXR2b3p4dGwybE81N056ZUhpV2hCRGJLRnoyWW1QWklVc1JSZjhGejRFZC9x?=
 =?utf-8?B?anhsWWExU2wwMkhYdkxwOWdNS3o1TDJYck12OVBuSkxDNlN0WnNrM2U0bWNw?=
 =?utf-8?B?UjRlY055ZWZkUkFvY0lpOTFsSjRHS0Z2K3dmSWJrV25CU0JWZlNuTU80Mjh3?=
 =?utf-8?B?QUVNOXVjVWdWYThmWUpKQ0x2ekY4RmFaeURNU1JYVjg1YlQzaitJYzBiOHdv?=
 =?utf-8?B?T2Q0bXJoMFV2Y1pyQ1hnZUZMKzBmSGxIbUNrK3NteTFKcWtWWE04elM4Vnp2?=
 =?utf-8?B?VXBPamp0SXdDTkdsUFM5Rm5YTm54Vi9xSXVHOEhESHd1U3Fub3ZBZ01HZDZM?=
 =?utf-8?B?TDgwZlU4ZmNzM3VzZWdjVHRncjgyNnRzamdDRVBYRURhK0FOWm5wdGFTVHBm?=
 =?utf-8?B?K0NFWEZ6TnlieGp3ZTBvK1VlVU52QVMwTlBZWFQ0YkVKMWpiNEZYb1BQWjZU?=
 =?utf-8?B?a2NaNldWVDZuWlBtQWoramFlVEhsZk9OVnhjY01jbm5vZGtPbHFhZVBUU1Jk?=
 =?utf-8?B?THQzc3ZQMUpzUFdDNWtRMkFYckVRRCs3WU1XWnU0ak91YndnUGE0ZWJVbkVW?=
 =?utf-8?B?VzVIRVJwL21KdlVieXdkVVNhTFVCdHBQTXJrb3JBU3J3TFhwdU9kUjhzWHVK?=
 =?utf-8?B?Q0Y2NFBlaXl3ZkJLamUwVkhVaVYyNXlDU3hjRlh1NXZwb3FvREo3K3RMTThX?=
 =?utf-8?B?TVQ3STZJNXY0Y1B1eDRzTUJoeE5NUDhZMXphd05FcmFYMkxGZnFvcUxqQ0tk?=
 =?utf-8?B?QlM0ZjhjMnlTU0NvQUdMaWxySmRjREZrWU5QWGpObEdHT3FFWjVFV2tyMjlu?=
 =?utf-8?B?ZlRxRldqb1dsRDhteXdnVkU2eW00OGZGeWxTL2xKdzlhNkdjV29POGVsb2Jk?=
 =?utf-8?B?amtlVGZHTTcyTFJnSEE4S2VycDNGenlCN2JZZm1wazYrNVcvSWFXUy93dGlz?=
 =?utf-8?B?NUo3NFo0Rk5QOTFFS2M3NDBBVGE3OHBQYm4rU1h3V01BVHQ2QkJWOTJjOHZI?=
 =?utf-8?B?WlRodHJSMkJSL0xFeTcyNm90dDd4VVNoWjd4T0dxK2sxd0ZiOFlWb1gxUVl4?=
 =?utf-8?B?dXAyaXFRcmVOMVBWTlh3SE5VVHl1MW9NaG1XVTcwcUl3SkRUWU1qekZ1UUVX?=
 =?utf-8?B?WjAzc0YySEgxNXEwL0E3R0FGenlacEhBRU05Wi9FclBmdFBYNjBMcmpkc0dj?=
 =?utf-8?B?dlJ1VXRCS0dXSXpDZWRGTjZjZUQxdmJ5VkQreTE5OExYandzeFBiUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7711911-b8ee-41f1-9b36-08deb71d8908
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 09:44:21.4080 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iAsUE6sPFy3NkHMuZBzUQ++RY80uMXisGPRpaUBdW7Ukeg6PF3lCoKabdgdkBdZ0kPxIXrlr5UKl+Eu7IdUS8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8072
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAyMSBNYXkgMjAyNiAwOTowMA0KPiBUbzogU2hh
bWVlciBLb2xvdGh1bSBUaG9kaSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBxZW11LQ0KPiBh
cm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwZXRlci5tYXlkZWxs
QGxpbmFyby5vcmc7IGNsZ0ByZWRoYXQuY29tOyBhbGV4QHNoYXpib3Qub3JnOyBOaWNvbGluDQo+
IENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEu
Y29tPjsgTWF0dA0KPiBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsgSmlhbmRpIEFuIDxqYW5AbnZp
ZGlhLmNvbT47IEphc29uIEd1bnRob3JwZQ0KPiA8amdnQG52aWRpYS5jb20+OyB6aGVuemhvbmcu
ZHVhbkBpbnRlbC5jb207IEtyaXNobmFrYW50IEphanUNCj4gPGtqYWp1QG52aWRpYS5jb20+OyBw
aHJkaW5hQHJlZGhhdC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAxNy8zMl0gaHcvYXJt
L3RlZ3JhMjQxLWNtZHF2OiBtbWFwIFZJTlRGIFBhZ2UwDQo+IGZvciBDTURRVg0KPiANCj4gRXh0
ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4g
DQo+IA0KPiBIaSBTaGFtZWVyLA0KPiANCj4gT24gNS8yMC8yNiA1OjQ3IFBNLCBTaGFtZWVyIEtv
bG90aHVtIFRob2RpIHdyb3RlOg0KPiA+IEhpIEVyaWMsDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQu
Y29tPg0KPiA+PiBTZW50OiAyMCBNYXkgMjAyNiAxMzo1NA0KPiA+PiBUbzogU2hhbWVlciBLb2xv
dGh1bSBUaG9kaSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBxZW11LQ0KPiA+PiBhcm1Abm9u
Z251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+ID4+IENjOiBwZXRlci5tYXlkZWxsQGxp
bmFyby5vcmc7IGNsZ0ByZWRoYXQuY29tOyBhbGV4QHNoYXpib3Qub3JnOw0KPiA+PiBOaWNvbGlu
IENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEu
Y29tPjsNCj4gPj4gTWF0dCBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsgSmlhbmRpIEFuIDxqYW5A
bnZpZGlhLmNvbT47IEphc29uDQo+ID4+IEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+OyB6aGVu
emhvbmcuZHVhbkBpbnRlbC5jb207IEtyaXNobmFrYW50DQo+ID4+IEphanUgPGtqYWp1QG52aWRp
YS5jb20+OyBwaHJkaW5hQHJlZGhhdC5jb20NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAx
Ny8zMl0gaHcvYXJtL3RlZ3JhMjQxLWNtZHF2OiBtbWFwIFZJTlRGDQo+IFBhZ2UwDQo+ID4+IGZv
ciBDTURRVg0KPiA+Pg0KPiA+PiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBs
aW5rcyBvciBhdHRhY2htZW50cw0KPiA+Pg0KPiA+Pg0KPiA+PiBIaSBTaGFtZWVyLA0KPiA+Pg0K
PiA+PiBPbiA1LzE5LzI2IDEyOjM2IFBNLCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPiA+Pj4g
RnJvbTogTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0KPiA+Pj4NCj4gPj4+IFRo
ZSBDTURRLVYgQ01EUSBwYWdlcyBwcm92aWRlIGEgVk0gd2lkZSB2aWV3IG9mIGFsbCBWQ01EUXMs
IHdoaWxlDQo+ID4+PiB0aGUNCj4gPj4gcy9DTURRIHBhZ2VzL1ZDTURRIHBhZ2VzIC0geWVhaCB0
aGF0J3MgYWxsIHZlcnkgY29uZnVzaW5nIDstKSAtDQo+ID4+PiBWSU5URiBwYWdlcyBleHBvc2Ug
YSBsb2dpY2FsIHZpZXcgbG9jYWwgdG8gYSBnaXZlbiBWSU5URi4gQWx0aG91Z2gNCj4gPj4+IHJl
YWwgaGFyZHdhcmUgbWF5IHN1cHBvcnQgbXVsdGlwbGUgVklOVEZzLCB0aGUga2VybmVsIGN1cnJl
bnRseQ0KPiA+Pj4gZXhwb3NlcyBhIHNpbmdsZSBWSU5URiBwZXIgVk0uDQo+ID4+Pg0KPiA+Pj4g
VGhlIGtlcm5lbCBwcm92aWRlcyBhbiBtbWFwIG9mZnNldCBmb3IgdGhlIFZJTlRGIFBhZ2UwIHJl
Z2lvbiBkdXJpbmcNCj4gPj4gZm9yIHRoZSBob3N0IFZJTlRGIHBhZ2UwIGFsbG9jYXRlZCBmb3Ig
dGhlIFZNDQo+ID4+DQo+ID4+IEFjdHVhbGx5IGlzIHRoZSB3aG9sZSBob3N0IHBhc3N0aHJvdWdo
IHByaW5jaXBsZSBpcyBub3QgcmVhbGx5DQo+ID4+IGV4cGxhaW5lZCBhbnl3aGVyZS4gQXQgbGVh
c3QgdGhhdCdzIG15IGZlZWxpbmcuIEl0IHdvdWxkIGJlIG5pY2UgdG8NCj4gPj4gaGF2ZSBhIHN1
bW1hcnkgZm9yIGl0LCBpbiB0aGUgY292ZXJsZXR0ZXIgYW5kIGluIGluZGl2aWR1YWwgcGF0Y2gu
IE9yDQo+ID4+IG1heWJlIHdlIGNhbiBsaW5rIHRvIGFub3RoZXIgZG9jLiBSZWFkaW5nIHRoZSBr
ZXJuZWwgdWFwaSBkb2VzIG5vdA0KPiA+PiByZWFsbHkgcHJvdmlkZSB0aGUgZnVsbCBwaWN0dXJl
LCBhdCBsZWFzdCB0aGF0J3MgbXkgb3duIGZlZWxpbmcuDQo+ID4gRmFpciBwb2ludC4gQSBzdW1t
YXJ5IG9mIG9wZXJhdGlvbiBpcyB1c2VmdWwuIEkgYW0gdGhpbmtpbmcgb2YgYWRkaW5nDQo+ID4g
aXQgYXQgdGhlIHRvcCBvZiBody9hcm0vdGVncmEyNDEtY21kcXYuYzoNCj4gPg0KPiA+IC8qDQo+
ID4gICAgKiBUZWdyYTI0MSBDTURRViAtIG92ZXJ2aWV3DQo+ID4gICAgKiAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgICAqLi4uDQo+ID4gICAgKi8NCj4gPg0K
PiA+IEkgd2lsbCBwb3B1bGF0ZSB0aGUgZGV0YWlscyBhbmQgc2hhcmUgaXQgZm9yIHJldmlldyBi
ZWZvcmUgdjYuDQo+ID4NCj4gPj4gd2hlbiBhIFZNIGFsbG9jYXRlcyBhIFZJT01NVSBmb3IgdGhl
IENNRFFWLCB0aGUga2VybmVsIGFsbG9jYXRlcyB0aGlzDQo+ID4+IGFuZCB0aGlzIHJlc291cmNl
IHRoYXQgaXMgdGhlbiBnaXZlbiBmb3IgZXhjbHVzaXZlIHVzYWdlIG9mIHRoZSBWTSAuLi4NCj4g
Pj4gSG93IGRvZXMgaXQgZ3VhcmFudGVlIHNlY3VyaXR5IGJldHdlZW4gVk1zLCBldGMuLi4NCj4g
PiBJc29sYXRpb24gaXMgZW5mb3JjZWQgYnkgdGhlIGtlcm5lbCBhbmQgdGhlIENNRFFWIGhhcmR3
YXJlLg0KPiA+IEkgdGhpbmsgdGhlIGtleSBwb2ludHMgaGVyZSBhcmU6DQo+ID4NCj4gPiAgIC0g
RWFjaCBWTSBoYXMgaXRzIG93biBpb21tdWZkIEZELiBBbGwgaW9tbXVmZCBvYmplY3RzIChWSU5U
RiwgaHcNCj4gPiAgICAgcXVldWVzLCBtbWFwIHJlZ2lvbnMpIGJlbG9uZyB0byB0aGF0IEZEOyBv
bmUgVk0gY2Fubm90IHJlYWNoDQo+ID4gICAgIGFub3RoZXIgVk0ncyBJRHMuDQo+ID4NCj4gPiAg
IC0gRWFjaCBGRCBnZXRzIGl0cyBvd24gVklOVEYsIGFsbG9jYXRlZCBieSBJT01NVV9WSU9NTVVf
QUxMT0MuIFRoZQ0KPiA+ICAgICBrZXJuZWwgd3JpdGVzIHRoZSBWTSdzIFZNSUQgaW50byB0aGUg
VklOVEYgYW5kIHRoZSBob3N0IENNRFFWDQo+IHMvd3JpdGVzL2NvbmZpZ3VyZXMNCj4gPiAgICAg
aGFyZHdhcmUgY2hlY2tzIGl0IG9uIGV2ZXJ5IGNvbW1hbmQuDQo+ID4NCj4gPiAgIC0gVGhlIGtl
cm5lbCBhbGxvY2F0ZXMgdGhlIFZJTlRGIHdpdGggSFlQX09XTiA9IDAsIHdoaWNoIHJlc3RyaWN0
cw0KPiA+ICAgICB0aGUgZ3Vlc3QgdG8gYSBzYWZlIHN1YnNldCBvZiBjb21tYW5kcy4NCj4gPg0K
PiA+ICAgLSBQZXIgVklOVEYsIHRoZSBrZXJuZWwgcHJvZ3JhbXMgU0lEX01BVENIIGFuZCBTSURf
UkVQTEFDRSBzbyBvbmx5DQo+ID4gICAgIHRoZSBWTSdzIG93biB2ZmlvLXBjaSBkZXZpY2VzIGNh
biBpc3N1ZSBjb21tYW5kczsgb3RoZXIgU0lEcyBhcmUNCj4gPiAgICAgcmVqZWN0ZWQgYnkgdGhl
IGhhcmR3YXJlLg0KPiA+DQo+ID4gICAtIElPTU1VX0hXX1FVRVVFX0FMTE9DIGJpbmRzIGVhY2gg
VkNNRFEgdG8gb25lIHNwZWNpZmljIFZJTlRGLCBzbw0KPiBhDQo+ID4gICAgIGd1ZXN0IGNhbm5v
dCByZWFjaCBhIFZDTURRIHRoYXQgYmVsb25ncyB0byBhbm90aGVyIFZNLg0KPiBhdCB0aGUgbW9t
ZW50IGEgc2luZ2xlIFZDTURRIGlzIHVzZWQgYnkgVk0sIGlzIHRoYXQgYSBjb3JyZWN0DQo+IHVu
ZGVyc3RhbmRpbmc/DQoNCk5vdCBxdWl0ZS4gUUVNVSBleHBvc2VzIG9uZSBWSU5URiAoVklOVEYw
KSB3aXRoIHR3byBWQ01EUXMgdG8gdGhlDQpndWVzdC4gVGhlIGd1ZXN0IGRlY2lkZXMgaG93IG1h
bnkgb2YgdGhlbSB0byBlbmFibGUuIEEgTGludXggZ3Vlc3QNCmVuYWJsZXMgYm90aDoNCi4uLg0K
YXJtLXNtbXUtdjMgYXJtLXNtbXUtdjMuMC5hdXRvOiBhbGxvY2F0ZWQgNTI0Mjg4IGVudHJpZXMg
Zm9yIHZjbWRxMA0KYXJtLXNtbXUtdjMgYXJtLXNtbXUtdjMuMC5hdXRvOiBhbGxvY2F0ZWQgNTI0
Mjg4IGVudHJpZXMgZm9yIHZjbWRxMQ0KLi4uDQoNClRoYW5rcywNClNoYW1lZXINCg==

