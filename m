Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4369FED2EF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 08:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0bTs-0002bK-5G; Thu, 12 Mar 2026 04:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w0bTo-0002b6-Rw; Thu, 12 Mar 2026 04:33:16 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w0bTl-00026r-AN; Thu, 12 Mar 2026 04:33:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MrAtbWelgrT62sD1PbfOOS9en4hN1z98nKx65IPhxASwAaeg7PBiN88Xrr6altVuL2DMEd3iEF3ESvjNbL2Qia+lH+iM5tk0uYzv3COjmEkS480mcgV00WA4tB+wOInLlZZvWiFtsPw2pIbnx690/hpAMpjZOzfgbnLwMSSRbSEurFCoHW8LTM4rwKLvc15LqdDnokB6hs8jeelD9GC3kXEEY6v5r1MgvMMhvtB/zASjosHgAzt6jJJkySoJdndeVMMM4QYx3voPO4eHTGVBd/SOCaZ9QznPxM8F+fsFkLTqkL5dIdGXAOnrAV351s5zfVLADf18IsYc5Tx7w8aqCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1XE0eF2pdPvdJDY7V7sqFYX5ELtA4wLUeWZO2MYC90=;
 b=WepONrOzHQngqqgI1sB3ke2yNf3ablKyYpUSyxFECHC3Yi0LYz+9gSz7mWcswQ9pG/I4DxufLe5hbzmSxChQvyQjnO3LjcCg8ggqHTZ+g2xwJOsvKiFe2Ku/qNHkg7glkpwxiSPa3/NPgqrLago6x2kRtWGVOSi5pM0Yz/soHxywS2k3IGqCQYNblr1lHeTKw3rgwXfvoHKMr5cmwfg6vPsL6Mi0qK7DgaS43zNlr5bf0zv7+g4aWP32mSxwzhwyrPphf0CKqjylh9hQcIjvqiKJw8D/BLHHogMLwztqtjc+685Jl352h3m8wYNlNT2dN3TlBLfkKaC7C26OYffYYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1XE0eF2pdPvdJDY7V7sqFYX5ELtA4wLUeWZO2MYC90=;
 b=OO99Z7noMcfaoaiLVcKEo5vP3gqmuaZdfZ0UYTySiCB4mrp8TTdf3uG6TjYQzOUKWCDBrwWUFlyErSO5UyxEEg2xfTZ1sI//pXfjAyQ0R8PsY6FJpJnarUrpPt6OCD8r85iQDJ3fiF2WYDq+lpokz7w9pHC2YGzFERDIKPtgwGjOARTjaFD5dLIUxfEK8DH0bgvUeY59JZSWS6VLayXaEyndt6kw4+e6Wvc707+BlBS1uavS8ARBReDTKwPhsisdBmDHaHNFpmpcn0PDV0xSYGPi6ELfrfAO4NPbm7gY+EMB5o485ZfeIdl2RyIF/43sVjnALhPxxD2ofyuMmMsGHA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SN7PR12MB8148.namprd12.prod.outlook.com (2603:10b6:806:351::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 08:33:05 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 08:33:05 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Markus Armbruster <armbru@redhat.com>
CC: Nathan Chen <nathanc@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Peter Maydell <peter.maydell@linaro.org>, Shannon
 Zhao <shannon.zhaosl@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor
 Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, =?utf-8?B?RGFuaWVsIFAuQmVycmFuZ8Op?=
 <berrange@redhat.com>, Alex Williamson <alex@shazbot.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Eric Blake
 <eblake@redhat.com>
Subject: RE: [RFC PATCH 1/8] hw/arm/smmuv3-accel: Add helper for resolving
 auto parameters
Thread-Topic: [RFC PATCH 1/8] hw/arm/smmuv3-accel: Add helper for resolving
 auto parameters
Thread-Index: AQHcr/oMB52/+UCqJ0eb9yphs6lsLbWnV1XEgAAb7VCAAx8LbIAAAN/Q
Date: Thu, 12 Mar 2026 08:33:05 +0000
Message-ID: <CH3PR12MB75485C39AB4ECE0B594C8C92AB44A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260309192119.870186-1-nathanc@nvidia.com>
 <20260309192119.870186-2-nathanc@nvidia.com>	<87tsuonp7r.fsf@pond.sub.org>
 <CH3PR12MB754899F3426FCB494EA7154FAB46A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <87v7f1xxv3.fsf@pond.sub.org>
In-Reply-To: <87v7f1xxv3.fsf@pond.sub.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SN7PR12MB8148:EE_
x-ms-office365-filtering-correlation-id: a59cc068-03de-4eb2-b86f-08de8011fb7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: W6YmwtCz7qUN6FLfNH40ZKeqF6+xfEaNdVuD6E3rWEvUNp+lPsucd18PXULW8yuI6gIR9JhwGpMYYtKWXf+/lCPljw0EGtgcQEKJfCsy5pBUpmH0ijglGhm+l4IS5+TI1SFVPprBe8MQciAF64dqir9ATLO7bgEDa6g0wuSEZzrhP3bg6eDUCScp0VUyTXF50FIfJ2zdHwuLxUzF33Hnn805oDMLmdsPS1hs/N/K26Rv/rLjb1YtreIozHzO4WfBcKfKEX1j7jc3OG47Q99Fngztv77MbSg0qJBa96t7wW5hYiRUSSycI43j3OoxI7v5m1paQtzqb/m3hA2wzEzsOHgBAeuJfpL/Fa5+TIF69UzUkk9+pOgSd19kFd1Ftia+SsM73TNWOvTEMRsknbby/KZ4Z2niNG7wtgIAXG2sH1BKhftdZ4/LaIY4CR6N2J5PF2hQopnqVON48kltz/9yR/54fjpB6keoodTOdMWio/wwAwR6ljIjM9SSsMMpcuCyD3C6JTgZk2MqqXmjZbiQtIPgnXaAs3rmbJ7jEf0DSgk16fxFI8v9urTfojszdtZcivo6IBbWI+23FdfhQzldUdvNUyN4/BuP+uEeLZQqikanz13GLqRttIGvf4Swtflc4Ebxzuusjcm7Q1AnLeueBITvFSN9s7fy2VZ+rj/HmNyZ84bhkNroJNi+TRCL0R1sbFUANjTIgn5qW6ay+fRwAu7N6Q1jeDFEQ8BJnKBmE0IBbXYgY78slZQqrjUcpQ5d
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0E0UUZIcUxTdndnVG0wT0xWK2d6Q0ZtS3JNenh4MGhtMFV4aldZbURPbE5p?=
 =?utf-8?B?VjBTd0hUQ0c4dS9heUFvNjBFTUlkcS80SlpuS3Z3OHpvcHVQeUMrVkpaZXls?=
 =?utf-8?B?aWQwNE5nVkpnbHBsTjlBSy9pVDQvN3JUdk04dVhaMWZULzJhSklSbWxuMEpO?=
 =?utf-8?B?RmtmbHIrSmdEaVNpN3pKdGtYTmJYY09TU0pHQzRGeUJ3UEdJSlZDUnpVMFVu?=
 =?utf-8?B?YjJSb3pSNG85TkxNWFNBMTI1ZmQ1bFVvU3FOTEt4dU10NGJJVmFTWUJKOGpP?=
 =?utf-8?B?YWFYb3Jkd3JPSDgzQVpZYlFqNFpiQUNRaHZreVpEaURxaTZ0dVU1MVVRZ1Z5?=
 =?utf-8?B?MU0wRUpoSkJoVitiNDg1MTBuZWc1R0kxS3ZVeWVlb1dBeGIyMDlja2tMYjBy?=
 =?utf-8?B?eEV6V0JqbXhEOTJDMjNpZlptSTF3Qm9zem5iaGNnMFdvbENsQW5QL3YwUis2?=
 =?utf-8?B?dVE3QU5ZTmNleFFPSlUzd1o1R2hIbHpyWW9IY3d3SmVrMWg2aXVZRUNIQzFm?=
 =?utf-8?B?dkY1ZHMxYWcvUG40enVoZGhIRzhWL0VHTmhPRzNPV2lvdmdxWFNnZmhQZTNK?=
 =?utf-8?B?NUlhM1ZkeStSWHY4NzN0RlVkc0cwb3JGZDJ6aGcvU1FHTFBNWTAyMzBuaGtT?=
 =?utf-8?B?Z2RlYjBJQS9pa0JxYnlaZkJYNHFmbFc2QlhqclViUDNjMkFSNm0wdVdScEtW?=
 =?utf-8?B?U2RpMzFwQ21PSE0xcnJiQ0NKNERXQjZyb08zQzdnenBPRExLVE1WMW5yMmU4?=
 =?utf-8?B?ZXNmZXpFRXJhZWZNWDNBNFB0b0g4OHBvQkx6MlFRTUlHcXl6d3JHUW1wNUx4?=
 =?utf-8?B?bm1HU2hUaThScjc2VE8rYlVhaS83N0dYMmdlYXE3WFhNenB4NWZmRE9GVWtG?=
 =?utf-8?B?akxwc0I0SnAva29VZVptZlpFUTQwV1luU1pPSHNNRStaa2k0Y0pDSFQxdmRm?=
 =?utf-8?B?Vm9LL1NhS1ZDWjUyVnhoNCs2UEhBUGovcW9yZ09KRDB0bjhFYU9vMFNoQVF1?=
 =?utf-8?B?cFZjNFVOT1o2QWN5ZVpUYmhXajdqVEU5ZzhsaFR2eW9ZTHNYK2xoT1lkZzhy?=
 =?utf-8?B?bmRxbFg1VGlNcTJzT0ZmMURjQzE4S2ZCWEQwL0QxOE1rY2ozd21obnA3Q0dB?=
 =?utf-8?B?WG5qYlZLWGVjTm1SNUk3cWJHcHFFa2JyN213aTZMT2o3bVNmSXNlYUNOa1h2?=
 =?utf-8?B?cEY5czViUzdQMll2SlBsUzVsd2pkcTdKYTIzRTUvMkFGazE0SmU4TGtMdHQr?=
 =?utf-8?B?UUgrVDlpTUpSN0ovT1hQZFJXeGErNG4xYXB1OEptaFVjSTdLMjgxMTNzNzAy?=
 =?utf-8?B?ZENKUEM5V0FqSXFzOW1jeWZLVlZOYmUrVFZtUTBDT0V0Y0ZxaXV2RXA1b0li?=
 =?utf-8?B?SjBpblV6SjBwbGY5L0RUMEtreTc1eEo2RnFTZk96eU1oc3RSSGFGaUJkaHdM?=
 =?utf-8?B?WFZEMnNnVUlrZWN6R3dqaS91KzlYOUxyZmlrY0JXaENmSlNoK1Z4T2xGOXRj?=
 =?utf-8?B?dlBmby84VUlqSmJXWTJuNWJyRTZUWXVURi9zWDNYNHpEdkFyUmV4MnVIZXBD?=
 =?utf-8?B?aHhuRjV3ZmNtTDlzcDdVem40NmpJejVlQXNRVHFoU3FqSjZvTzVLVmxGSGxZ?=
 =?utf-8?B?WkljRXd4Q0VZMi8yZXhoWU9VZUZtb2xuUVREL040ZjAzaTdub3pmc3FEcS9o?=
 =?utf-8?B?WVdRWGNvQU1YbnBoZ1VGakFWZjUzUlNaaHN3R2M5bDFFN2VsWm00MlI3Y1By?=
 =?utf-8?B?RWIyeDRoMytWeEN6SlBxcFg5b3pUQXkrMzAxYmwvK2pTR2tSZXk5Q2lVdjZi?=
 =?utf-8?B?Y2pGYkh0a253RGFieDYxUlhhdklKMzdUYUM1NEpBVkc3M3RWT2F6YTJDRzJr?=
 =?utf-8?B?VkVoUjhrVmFsWHp4YSt1NmdWWm50MkZ4VWFoblExWjU1S3JEU2grU3YwMnVE?=
 =?utf-8?B?NUhRSjRoZEU2dCtKeDlKL0Q1Vm9wQ3Ira3dWRmsyWFRVU0dyVTdwUnlIU3l1?=
 =?utf-8?B?VEtKLzJ1bkJyaGJTK1ZMMmJRdG5WWlJkVnRXdTZUc1RFVUFJMmpCMzVYUUNa?=
 =?utf-8?B?MDh0a2FhZVllWVhzbHpFNUZQUVV4QUNyM2xXclZrN0I4SXpNUTkzVmE4amVu?=
 =?utf-8?B?MU1qbDZreUtHMUYxeXF1d1VuRXpLMS85ZzJKd0JyM2wrekxWcExTejZBdmkx?=
 =?utf-8?B?eWJaMzhyZVNoQ25JdjB0bmZudjZIOWI5TnVZN251TXpGc2xLeXFnWWVTbTlX?=
 =?utf-8?B?Z240cW9pVmk5QXRTckMyL1JYVzA0ZHNDWW5UTmdrbVJrREN2cHZyeXpmMVNN?=
 =?utf-8?B?N3ExbVhHSnZWY2gyZU4xRjcvemJTZmxOS25RcEZhdi9tYmlPbjRodz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a59cc068-03de-4eb2-b86f-08de8011fb7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 08:33:05.4545 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dJ3ZENYgk6qjhQrtgvcNFQuSMWBBd1UOtaU138g31p4lbbEfdUmhLhOTloZIU+iWAwlCxZgniI8ZNiohs8Cr9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8148
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFya3VzIEFybWJydXN0
ZXIgPGFybWJydUByZWRoYXQuY29tPg0KPiBTZW50OiAxMiBNYXJjaCAyMDI2IDA4OjIxDQo+IFRv
OiBTaGFtZWVyIEtvbG90aHVtIFRob2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT4NCj4gQ2M6
IE5hdGhhbiBDaGVuIDxuYXRoYW5jQG52aWRpYS5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmc7
IHFlbXUtDQo+IGFybUBub25nbnUub3JnOyBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT47IEVy
aWMgQXVnZXINCj4gPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT47IFpoZW56aG9uZyBEdWFuIDx6aGVu
emhvbmcuZHVhbkBpbnRlbC5jb20+Ow0KPiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxp
bmFyby5vcmc+OyBTaGFubm9uIFpoYW8NCj4gPHNoYW5ub24uemhhb3NsQGdtYWlsLmNvbT47IE1p
Y2hhZWwgUyAuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPjsgSWdvcg0KPiBNYW1tZWRvdiA8aW1h
bW1lZG9AcmVkaGF0LmNvbT47IEFuaSBTaW5oYSA8YW5pc2luaGFAcmVkaGF0LmNvbT47DQo+IFBh
b2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+OyBEYW5pZWwgUC5CZXJyYW5nw6kNCj4g
PGJlcnJhbmdlQHJlZGhhdC5jb20+OyBBbGV4IFdpbGxpYW1zb24gPGFsZXhAc2hhemJvdC5vcmc+
OyBDw6lkcmljIExlDQo+IEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+OyBFcmljIEJsYWtlIDxlYmxh
a2VAcmVkaGF0LmNvbT4NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggMS84XSBody9hcm0vc21t
dXYzLWFjY2VsOiBBZGQgaGVscGVyIGZvciByZXNvbHZpbmcNCj4gYXV0byBwYXJhbWV0ZXJzDQo+
IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2ht
ZW50cw0KPiANCj4gDQo+IFNoYW1lZXIgS29sb3RodW0gVGhvZGkgPHNrb2xvdGh1bXRob0Budmlk
aWEuY29tPiB3cml0ZXM6DQo+IA0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
PiBGcm9tOiBNYXJrdXMgQXJtYnJ1c3RlciA8YXJtYnJ1QHJlZGhhdC5jb20+DQo+IA0KPiBbLi4u
XQ0KPiANCj4gPj4gTmF0aGFuIENoZW4gPG5hdGhhbmNAbnZpZGlhLmNvbT4gd3JpdGVzOg0KPiA+
Pg0KPiA+PiA+IEZyb206IE5hdGhhbiBDaGVuIDxuYXRoYW5jQG52aWRpYS5jb20+DQo+ID4+ID4N
Cj4gPj4gPiBJbnRyb2R1Y2Ugc21tdXYzX2FjY2VsX2F1dG9fZmluYWxpc2UoKSB0byByZXNvbHZl
IHByb3BlcnRpZXMgdGhhdA0KPiA+PiA+IGFyZSBzZXQgdG8gJ2F1dG8nIGZvciBhY2NlbGVyYXRl
ZCBTTU1VdjMuIFRoaXMgaGVscGVyIGZ1bmN0aW9uDQo+ID4+ID4gYWxsb3dzIHByb3BlcnRpZXMg
c3VjaCBhcyBBVFMsIFJJTCwgU1NJRFNJWkUsIGFuZCBPQVMgc3VwcG9ydCB0byBiZQ0KPiA+PiA+
IHJlc29sdmVkIGZyb20gaG9zdCBJT01NVSB2YWx1ZXMsIHdoaWxlIGF2b2lkaW5nIHRyaWdnZXJp
bmcNCj4gPj4gPiBhdXRvLXJlc29sdmVkIHZhbHVlcyBmb3IgaG90LXBsdWdnZWQgZGV2aWNlcy4N
Cj4gPj4gPg0KPiA+PiA+IEF1dG8gbW9kZSByZXF1aXJlcyBhdCBsZWFzdCBvbmUgY29sZC1wbHVn
Z2VkIGRldmljZSB0byByZXRyaWV2ZSBhbmQNCj4gPj4gPiBmaW5hbGlzZSB0aGVzZSBwcm9wZXJ0
aWVzLCBhbmQgd2UgZmFpbCBib290IGlmIHRoYXQgaXMgbm90IHRoZQ0KPiA+PiA+IGNhc2UuDQo+
ID4+ID4NCj4gPj4gPiBTdWJzZXF1ZW50IHBhdGNoZXMgd2lsbCBtYWtlIHVzZSBvZiB0aGlzIGhl
bHBlciB0byBzZXQgdGhlIHZhbHVlcw0KPiA+PiA+IHdoZW4gd2UgY29udmVydCB0aGUgdmFsdWVz
IHRvIE9uT2ZmQXV0by4gTmV3IGF1dG9fbW9kZSBhbmQNCj4gPj4gPiBhdXRvX2ZpbmFsaXNlZCBi
b29sIG1lbWJlcnMgYXJlIGFkZGVkIHRvIFNNTVV2M0FjY2VsU3RhdGUuDQo+ID4+ID4gc21tdXYz
X2FjY2VsX2luaXQoKSB3aWxsIHNldCBhdXRvX21vZGUgdG8gdHJ1ZSB3aGVuICdhdXRvJyBpcw0K
PiA+PiA+IGRldGVjdGVkIGZvciB0aGUgYWNjZWwgU01NVXYzIHByb3BlcnRpZXMuDQo+ID4+ID4g
c21tdXYzX2FjY2VsX2F1dG9fZmluYWxpc2UoKSB3aWxsIHNldCBhdXRvX2ZpbmFsaXNlZCB0byB0
cnVlIGFmdGVyDQo+ID4+ID4gYWxsICdhdXRvJyBwcm9wZXJ0aWVzIGFyZSByZXNvbHZlZCwgYW5k
IHN1YnNlcXVlbnQgY2FsbHMgdG8gdGhpcw0KPiA+PiA+IGZ1bmN0aW9uIHdpbGwgcmV0dXJuIGVh
cmx5IGlmIGF1dG9fZmluYWxpc2VkIGlzIHNldCB0byB0cnVlLg0KPiA+PiA+DQo+ID4+ID4gU3Vn
Z2VzdGVkLWJ5OiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT4NCj4g
Pj4gPiBTaWduZWQtb2ZmLWJ5OiBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEuY29tPg0KPiA+
PiA+IC0tLQ0KPiA+PiA+ICBody9hcm0vc21tdXYzLWFjY2VsLmMgfCAzOA0KPiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKystLQ0KPiA+PiAtLS0NCj4gPj4gPiAgaHcvYXJtL3NtbXV2
My1hY2NlbC5oIHwgIDIgKysNCj4gPj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAzNSBpbnNlcnRpb25z
KCspLCA1IGRlbGV0aW9ucygtKQ0KPiA+PiA+DQo+ID4+ID4gZGlmZiAtLWdpdCBhL2h3L2FybS9z
bW11djMtYWNjZWwuYyBiL2h3L2FybS9zbW11djMtYWNjZWwuYyBpbmRleA0KPiA+PiA+IDE3MzA2
Y2QwNGIuLjYxNzYyOWJhY2QgMTAwNjQ0DQo+ID4+ID4gLS0tIGEvaHcvYXJtL3NtbXV2My1hY2Nl
bC5jDQo+ID4+ID4gKysrIGIvaHcvYXJtL3NtbXV2My1hY2NlbC5jDQo+ID4+ID4gQEAgLTM1LDEx
ICszNSwzNCBAQCBzdGF0aWMgaW50IHNtbXV2M19vYXNfYml0cyh1aW50MzJfdCBvYXMpDQo+ID4+
ID4gICAgICByZXR1cm4gbWFwW29hc107DQo+ID4+ID4gIH0NCj4gPj4gPg0KPiA+PiA+ICtzdGF0
aWMgdm9pZCBzbW11djNfYWNjZWxfYXV0b19maW5hbGlzZShTTU1VdjNTdGF0ZSAqcywgUENJRGV2
aWNlDQo+ICpwZGV2LA0KPiA+PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBzdHJ1Y3QgaW9tbXVfaHdfaW5mb19hcm1fc21tdXYzICppbmZvKSB7DQo+ID4+ID4gKyAg
ICBTTU1VdjNBY2NlbFN0YXRlICphY2NlbCA9IHMtPnNfYWNjZWw7DQo+ID4+ID4gKw0KPiA+PiA+
ICsgICAgLyogUmV0dXJuIGlmIG5vIGF1dG8gZm9yIGFueSBvciBmaW5hbGlzZWQgYWxyZWFkeSAq
Lw0KPiA+PiA+ICsgICAgaWYgKCFhY2NlbC0+YXV0b19tb2RlIHx8IGFjY2VsLT5hdXRvX2ZpbmFs
aXNlZCkgew0KPiA+PiA+ICsgICAgICAgIHJldHVybjsNCj4gPj4gPiArICAgIH0NCj4gPj4gPiAr
DQo+ID4+ID4gKyAgICAvKiBXZSBjYW4ndCB1cGRhdGUgaWYgZGV2aWNlIGlzIGhvdHBsdWdnZWQg
Ki8NCj4gPj4gPiArICAgIGlmIChERVZJQ0UocGRldiktPmhvdHBsdWdnZWQpIHsNCj4gPj4gPiAr
ICAgICAgICB3YXJuX3JlcG9ydCgiYXJtLXNtbXV2MzogJ2F1dG8nIGZlYXR1cmUgcHJvcGVydHkg
ZGV0ZWN0ZWQsDQo+ID4+ID4gKyBidXQgaG9zdA0KPiA+PiAiDQo+ID4+ID4gKyAgICAgICAgICAg
ICAgICAgICAgInZhbHVlIGNhbm5vdCBiZSBhcHBsaWVkIGZvciBob3QtcGx1Z2dlZCBkZXZpY2U7
IHVzaW5nICINCj4gPj4gPiArICAgICAgICAgICAgICAgICAgICAiZXhpc3RpbmcgdmFsdWUiKTsN
Cj4gPj4NCj4gPj4gV2h5IGlzIHRoaXMgd2FybmluZyB1c2VmdWw/DQo+ID4+DQo+ID4+IERvZXMg
QGF1dG8ncyBtZWFuaW5nIGRlcGVuZCBvbiB3aGV0aGVyIHRoZSBkZXZpY2UgaXMgY29sZC0gb3IN
Cj4gPj4gaG90LXBsdWdnZWQ/DQo+ID4NCj4gPiBJZiBTTU1VdjMgYWNjZWw9b24gYW5kIHByb3Bl
cnRpZXMgYXJlIHNldCB0byAiYXV0byIsIHdlIHJlcXVpcmUgYXQNCj4gPiBsZWFzdCBvbmUgY29s
ZC1wbHVnZ2VkIHZmaW8tcGNpIGRldmljZSB0byByZXRyaWV2ZSB0aGUgYXNzb2NpYXRlZCBob3N0
DQo+ID4gU01NVXYzIGluZm9ybWF0aW9uIGFuZCBmaW5hbGlzZSB0aGUgUUVNVSBTTU1VdjMgcHJv
cGVydGllcy4NCj4gPg0KPiA+IEluIHRoaXMgc2VyaWVzLCAiYXV0b19tb2RlIiBpcyBzZXQgaWYg
YW55IGFjY2VsIHByb3BlcnR5IGlzIHNwZWNpZmllZA0KPiA+IGFzICJhdXRvIi4gVGhlIHByb3Bl
cnRpZXMgYXJlIHRoZW4gZmluYWxpc2VkIHVzaW5nIHRoZSBmaXJzdA0KPiA+IGNvbGQtcGx1Z2dl
ZCBkZXZpY2UgYW5kICJhdXRvX2ZpbmFsaXNlZCIgaXMgc2V0Lg0KPiA+DQo+ID4gU2luY2Ugd2Ug
bGF0ZXIgZmFpbCB0aGUgZ3Vlc3QgYm9vdChzZWUgYmVsb3cpIGluIHRoZSByZXNldCBwaGFzZSBp
Zg0KPiA+IGF1dG9fbW9kZSBpcyBzZXQgYnV0IGF1dG9fZmluYWxpc2VkIGlzIHN0aWxsIGZhbHNl
LCB0aGUgYWJvdmUgaG90cGx1Zw0KPiA+IGNhc2Ugc2hvdWxkIG5vdCByZWFsbHkgaGFwcGVuLiBJ
biB0aGF0IGNhc2UgdGhlIFZNIHdvdWxkIG5vdCBib290Lg0KPiANCj4gU291bmRzIGNvbXBsaWNh
dGVkLg0KPiANCj4gPiBTbyBsaWtlbHkgd2UgY2FuIGdldCByaWQgb2YgdGhlIGhvdHBsdWcgY2hl
Y2sgYWJvdmUuIE5lZWQgdG8gZG8gYSBiaXQNCj4gPiBtb3JlIHRlc3RpbmcgdG8gY29uZmlybSB3
ZSBjb3ZlciBhbGwgY29ybmVyIGNhc2VzLg0KPiA+DQo+ID4+DQo+ID4+ID4gKyAgICAgICAgcmV0
dXJuOw0KPiA+PiA+ICsgICAgfQ0KPiA+PiA+ICsNCj4gPj4gPiArICAgIGFjY2VsLT5hdXRvX2Zp
bmFsaXNlZCA9IHRydWU7DQo+ID4+ID4gK30NCj4gDQo+IFsuLi5dDQo+IA0KPiA+PiA+IEBAIC04
NjcsOCArODkxLDEyIEBAIGJvb2wNCj4gc21tdXYzX2FjY2VsX2F0dGFjaF9nYnBhX2h3cHQoU01N
VXYzU3RhdGUNCj4gPj4gPiAqcywgRXJyb3IgKiplcnJwKQ0KPiA+PiA+DQo+ID4+ID4gIHZvaWQg
c21tdXYzX2FjY2VsX3Jlc2V0KFNNTVV2M1N0YXRlICpzKSAgew0KPiA+PiA+IC0gICAgIC8qIEF0
dGFjaCBhIEhXUFQgYmFzZWQgb24gR0JQQSByZXNldCB2YWx1ZSAqLw0KPiA+PiA+IC0gICAgIHNt
bXV2M19hY2NlbF9hdHRhY2hfZ2JwYV9od3B0KHMsIE5VTEwpOw0KPiA+PiA+ICsgICAgaWYgKHMt
PnNfYWNjZWwgJiYgcy0+c19hY2NlbC0+YXV0b19tb2RlICYmDQo+ID4+ID4gKyAhcy0+c19hY2Nl
bC0+YXV0b19maW5hbGlzZWQpDQo+ID4+IHsNCj4gPj4gPiArICAgICAgICBlcnJvcl9yZXBvcnQo
IkFVVE8gbW9kZSBzcGVjaWZpZWQgYnV0IHByb3BlcnRpZXMgbm90IGZpbmFsaXNlZC4iKTsNCj4g
Pj4gPiArICAgICAgICBleGl0KDEpOw0KPiA+Pg0KPiA+PiBIb3cgY2FuIHdlIGdldCBoZXJlPw0K
PiA+DQo+ID4gVGhpcyBpcyByZWFjaGVkIGZyb20gdGhlIFNNTVV2MyByZXNldCBoYW5kbGVyIHdo
ZW4gYXV0byBtb2RlIGlzDQo+ID4gc3BlY2lmaWVkIGJ1dCBubyBjb2xkLXBsdWdnZWQgZGV2aWNl
IGhhcyBiZWVuIGF0dGFjaGVkIHRvIGZpbmFsaXNlIHRoZQ0KPiA+IGFjY2VsZXJhdGVkIFNNTVV2
MyBwcm9wZXJ0aWVzLg0KPiA+DQo+ID4gSWYgbm8gc3VjaCBkZXZpY2UgaXMgcHJlc2VudCwgImF1
dG9fZmluYWxpc2VkIiByZW1haW5zIGZhbHNlIGFuZCB3ZSBoaXQNCj4gPiB0aGlzIHBhdGggZHVy
aW5nIHJlc2V0Lg0KPiA+DQo+ID4gQ8OpZHJpYyBtZW50aW9uZWQgdGhhdCB3ZSBzaG91bGQgbm90
IGV4aXQgZHVyaW5nIHRoZSByZXNldCBwaGFzZS4gSWYgdGhhdA0KPiA+IGlzIHRoZSBjYXNlLCB3
ZSBsaWtlbHkgbmVlZCBhbm90aGVyIHdheSB0byBoYW5kbGUgdGhlIHNjZW5hcmlvIHdoZXJlDQo+
ID4gYXV0byBtb2RlIGlzIHNwZWNpZmllZCBidXQgbm8gY29sZC1wbHVnZ2VkIGRldmljZSBpcyBw
cmVzZW50Lg0KPiANCj4gV2hhdCBleGFjdGx5IGRvZXMgdGhlICJhdXRvIiBmZWF0dXJlIGJ1eSB1
cz8gIElzIGl0IHdvcnRoIHRoZQ0KPiBjb21wbGV4aXR5Pw0KDQpUaGUgcmVxdWlyZW1lbnQgY2Ft
ZSBmcm9tIHRoZSBLdWJlVmlydCBmb2xrcy4gSXQgaXMgZWFzaWVyIGZvciB0aGVtIGlmDQpRRU1V
IGNhbiBwcm9iZSB0aGUgcGxhdGZvcm0gYW5kIHNldCB0aGVzZSB2YWx1ZXMsIGluc3RlYWQgb2Yg
c3BlY2lmeWluZw0KdGhlbSBmb3IgZWFjaCBwbGF0Zm9ybS4NCg0KU2VlOg0KaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvcWVtdS1kZXZlbC9kOTE5MmFlNi1hOTRmLTQ3OWEtYjE5Zi03MzRjYzUyYTZi
ZTBAcmVkaGF0LmNvbS8NCg0KV2l0aG91dCAiYXV0byIsIHRoZSBtYW5hZ2VtZW50IGxheWVyIG5l
ZWRzIHRvIGtub3cgdGhlIHZhbHVlcyBzdXBwb3J0ZWQNCm9uIGVhY2ggcGxhdGZvcm0uDQoNCmVn
OiBvbiBhIEdCMjAwLCBpdCB3aWxsIGxvb2sgbGlrZSwNCg0KLWRldmljZSBhcm0tc21tdXYzLHBy
aW1hcnktYnVzPXBjaWUuMSxpZD1zbW11djMuMCxhY2NlbD1vbixhdHM9b24scmlsPW9mZixzc2lk
c2l6ZT0yMCxvYXM9NDgNCg0KV2l0aCAiYXV0byIgaXQgY2FuIHNpbXBseSBiZToNCg0KLWRldmlj
ZSBhcm0tc21tdXYzLHByaW1hcnktYnVzPXBjaWUuMSxpZD1zbW11djMuMCxhY2NlbD1vbg0KDQoo
cHJvdmlkZWQgYSB2ZmlvLXBjaSBkZXZpY2UgaXMgY29sZC1wbHVnZ2VkKS4NCg0KVGhhbmtzLA0K
U2hhbWVlcg0KDQoNCg0K

