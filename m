Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3D5C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 04:00:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7nl6-0007aW-1i; Thu, 24 Apr 2025 00:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u7nl3-0007Xq-KU; Thu, 24 Apr 2025 00:00:17 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u7nl1-0006pq-NA; Thu, 24 Apr 2025 00:00:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ScR7E0f+Yz/SD2DSnSKoiiSOlVM89QmRD9bdIBli5FfgrFBdR9qupAkQnnMGCw9ali5cUQlZhl9wAe7RbRf9f98jxBD/YPyyoWkMisK1fdR4MEpGbc6nz6w9JIHmCz5v+9lW2EX1Km9TO6+Fcnyq/UQMRVQJPp9gkWI5hRU8j8SIKyoWIA3uDgpg8Z6HuoS+YmafZeK4fxbGrZ2qrT3M9TYeiz/eC1m+RZrqBPDgx6xKLmWKLcseKoI0d8CmSP4AYdwuLZ3IUypl++Zp25uVscbNIfvCiMOt+a2/88Zz1Lmho3n9hILJbVnN0Mgm6xrm4Dt55lhNoXIHJmy9oy5YIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PId6v3A6aTuGvaQfy5uMXbikHU2HZvL1lbFdiPHlTM8=;
 b=WH0w4VEcqrJJto3JsGCyPQbUVqI8RBQNFHe8HFtFm7lP5jaNRNBqRxczFFlcEVtITFJ074K54oOeGt9or6vkedPS9BDsQfVcLi+l/1PGlifa6v6Mf59OH0sYLh3P6SVy+JWUEIKlMhKSJeRBe84qlKnRE5eqIWuNqiS2Wfx6dZmQTjQoHHyL6ARVBVuFW7nVeCB/oWYuM6Kw11pnPMR4+4gPH7hq0DQnbrfzM0FPPNG4bEoWT626PUu47YzFM1a/q10fOWywEBWISW/3mYrihkXslgq++BJ5Z+Sr1dYA41G0Ek+cCGC12X5kY+1XgqgdeO77KTsNNbZJ8xP3vT3oNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PId6v3A6aTuGvaQfy5uMXbikHU2HZvL1lbFdiPHlTM8=;
 b=ntEJvrIbpmB4cuOMxEFiY4vr+K9yPR6ycfY9R4iKkbYBtMBLK7PfEBMH7qFi+fHAX+6qk4jxQ+v8I83ByUJBpElFs14OQ0YVldGMjJpfabd2QsMVNOyxqyyidIvNrtdS9aiAyQHgD0EV+gGypfyAm5FdyPdsc2NeYmVjYHsf8UYUjonqtrFoQmpjeQ5qxyXPOc2LAA7zU7LlQfTpICmEChEdzAXYm2zWwc4wVOzjWHOmZox/z92AqbbXe/0qum9Uhv5S0zHAsf6JjJxi3RJrpzW+O1W+a5GHYngybGFtdw08QEVqzbd3iiT7WcTjMjd9v0OpKQWcYIF/NtidGZ002A==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TY0PR06MB5443.apcprd06.prod.outlook.com (2603:1096:400:32c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 04:00:07 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 04:00:07 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: RE: [PATCH v5 03/11] hw/arm/aspeed: Add vbootrom support on AST2700
 EVB machines
Thread-Topic: [PATCH v5 03/11] hw/arm/aspeed: Add vbootrom support on AST2700
 EVB machines
Thread-Index: AQHbtCCvf5kOHe0nb0eZjTKQTVqta7Ow/DmAgAE2FhA=
Date: Thu, 24 Apr 2025 04:00:06 +0000
Message-ID: <SI2PR06MB5041D11D6C467C2C5F69FEC5FC852@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250423072350.541742-1-jamin_lin@aspeedtech.com>
 <20250423072350.541742-4-jamin_lin@aspeedtech.com>
 <2623f4e1-59c9-4044-a104-ef5e78c994ed@kaod.org>
In-Reply-To: <2623f4e1-59c9-4044-a104-ef5e78c994ed@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TY0PR06MB5443:EE_
x-ms-office365-filtering-correlation-id: 0ef83934-3a14-4023-e378-08dd82e48022
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QVptbEdHVXN5aStVaWNuR1poeVJORzQ5WmJWTEtYVDBmVTNSbUw5MXRSZHhI?=
 =?utf-8?B?aWRHTkNJQ0grZmFsWDNiWkhNVlpoK1pKNGxuRFU1YmZZRitadVlkVitQei9P?=
 =?utf-8?B?U0RlRTV4Tkc3WjZpd05xVUhzUmo4U21vSkkyd09LcXhyS2lsbE9GVzJFS0hO?=
 =?utf-8?B?SlFzbFk2d083dGwwekxkYUUxQzVEdVUyc1NjMVczK3ZxOTlqM25jeTdFUi9D?=
 =?utf-8?B?THNTaktXeGJxaWRoaHpGb2JabGRKdWZaMVRnU2VYYS9ZSm5oVjdySDVhQ0Yr?=
 =?utf-8?B?MDJRQTIrQkIvSFRpaUFtQmR6YUJnV09jL25NeTVrOVpiak9KelBHd094VE9r?=
 =?utf-8?B?d0ljZmV5cC82Qmg4OStWSG1BMFJOT0Q3VmlXcDlmZW80OWx1VHR4SElaVjMv?=
 =?utf-8?B?cGRBenVkS0xJTzk4UGpRWUhZSElYV2l1elNubG8xanVBaUI3bGNRVitJMlhK?=
 =?utf-8?B?YitJZUh0OTh4RWhzNWZxZ0g0eTgwL3BtdkRFWGRra2dMZlhZbVVka0tXYVR6?=
 =?utf-8?B?VGFRQXgrQkFZamMrRjRDdjhKWDdQVEI1UUY1L0hvY2VEYTdhQkJSeGFLaENI?=
 =?utf-8?B?ZEcveUgwUUFUZkMzSDJNeEtiVXFhaGR2aTVHWGFzVWk0WU9yZGxZZStUL29T?=
 =?utf-8?B?RDczOUVyVjNKeFptOFM5dVBnaldrZDdNdmdQSGJzYVZWVUNkYjJUV0hJb0RS?=
 =?utf-8?B?UytlajdsWTdLV2xpMnJ0VDRXYjlqWERiSGxqaHVlQm1uU3RsekRwWU51K2I1?=
 =?utf-8?B?c0pHVCtsTFhhZlNldm1hbmxZaFFhckhyRmJPaS9sSG4ySGkvcUFyUlg1dG0x?=
 =?utf-8?B?Z3E1RlRIRzN2Vm0xcG5ua04wSVRvM1ZkWGd2SnJHbENqNFpVTi9xUXJVS3Er?=
 =?utf-8?B?RFgzaGdHdEFJdzVueTJMd1RjNEw2OTdjSitVaTc2M3BGQ0piVFYrQS9SUFo5?=
 =?utf-8?B?d1RuMzJoVUl1OFBJRjdyMmtjckpkOHJINC9OMFFXNHZtaEFJZW9MMHBpSDA5?=
 =?utf-8?B?bXY3cUhocTJ6MEZESlBIenhCZ0FCNXpjdnZnYUowZ2dNZjJ0bmlycFdDWUxX?=
 =?utf-8?B?VGdaalNNSEtxNEpvRXIrSUhGQURIbzB2RzVJbmpyc1FMd0RiNkd4RjJJV0lk?=
 =?utf-8?B?bU00ZnFYTHk3T3pXMjdOcVNjR0M3dVZGWW1obERQTUcwN0Q0SlhWeGZleis4?=
 =?utf-8?B?SVo0VzNieW9BNGx1OXFuMm45RzU2SmdTTGVrdHk4eEl2ZVRISFJ5NElaZ2JZ?=
 =?utf-8?B?RStiUzVRWXFPSUJlazRrbWU1TERLbVc0Vzk5RHd1SDJXRUZJcDFMTTNsWmRn?=
 =?utf-8?B?Z0tYR0VFakxzN040SVpsWFVKSFZTVzhnMDM0eFZPR0JtWFgzSU1YQmhycTlC?=
 =?utf-8?B?SU9uUTJ2UUh2TU12a1JLVUVpWTZXbzZpSW5HbmRZWDQ4TjdNS0gyM1lNaVNy?=
 =?utf-8?B?dTlCd3NyNzlwWWJINHJmcWhFOWU0TmY0Qmxyak9VUzRUK01rKzlyQ0FxNXdr?=
 =?utf-8?B?RmVxdk5TTDV1elZiajhybTUweENYTEdXeEd0blV2WjVJWWN5VjZZeGI1S1JX?=
 =?utf-8?B?YmgvWnJseUFYWXIxQ2JiSHBUdU5ZS0l6N2dxWk5VckFIbmcrdlJhYnQ0MWJO?=
 =?utf-8?B?V0dXSmVJaVlpUzVYN2dnOTNvSzBVWWEzdTU3ZlNVcE9BQWk2aUppZVVUV29U?=
 =?utf-8?B?ellzalJIb2NNWFR3UlhxaHdGSWJwSFhqYjh5NTFTV0NLTE94Q3Fhb3Y4UkxR?=
 =?utf-8?B?SDgyZnAxWENGN1hObTJPKzAvelZGS0ExRFVCTGRRNDBVQ01HYmpZYm0rc3pt?=
 =?utf-8?B?TEZSY2V0UU41YXV4UG1UNW5vYklXRVdxL1czcVJXYTdRUm5PMlBiUGhQZGY4?=
 =?utf-8?B?UFZibzNMNmJVeUpTZ29Kamc4Y2FaQ0dkN2VoeERRaVpZVXpxSDhtWTljOU0x?=
 =?utf-8?B?UVE1d1NpdS9hQUtkSW14bFNITUxBbktjQmFqZXVhaElwbUZiRWsveUdrK2k2?=
 =?utf-8?B?eWYwTWlMRHN3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Yk53MDQ5YUh6c0RLK3pNbVNJT1JDU2JXNldWakNzMzFKOVBNbTgzUGN6czd3?=
 =?utf-8?B?UjUvbnp6NnlyaFlyalZ2MVVvUUd3NkJXQndLSW9NS1BFSnhQbkxEU0RHK2o1?=
 =?utf-8?B?Vk9UWkxGc3l0QnQ0VEJPNjZSbm9nd1RKVzlBZ3JHb1FuUVMrWnQ1TTMwbzUz?=
 =?utf-8?B?cEpKTUlsQ21qWmk2Wmtua3pGSHVKSks4aE42UHQ3eGt4TTc3ellJVmhObkpt?=
 =?utf-8?B?d3hpblhzdUU5VUhHMWU1L1J4MS9HVUNKMHh5NmJDcjBtYjl3RUxMTjhLOGFN?=
 =?utf-8?B?d3VWdldwcGNHQ29POVpzY3hYRWJxZmwwMFJPa2RKU3p4Mk95WnZhK0hhUFpC?=
 =?utf-8?B?aXdtZ0Z3R1g3Y05rUEpzbXJucTBkdk90b1VLeVZIeVBlaUh6KzQzMHh1Wjky?=
 =?utf-8?B?NHpObndJWFVjRDFqRDJXbzh4Y3BqRXFDNXpNeGgxN0puaGtaaUtuc0tia2tU?=
 =?utf-8?B?K2dCMjdwaGxEbThPMVR3ZlB3eEx3ZzI4OFRmN1JIekRwaUFvSTRkallGRHJG?=
 =?utf-8?B?aEtaSXpoNnFjR3dET045SHU2R0pWSFpTVkJwRVVCS0lMQXorSnNLcG5YN1Nk?=
 =?utf-8?B?eFZ3aVFrN3dGTlpadTFadi85anRKdXBjdHJOUnlTYXJCRGU3S3F1QkhCblVu?=
 =?utf-8?B?ZUswaWN1MC9OQlI0c3lEY2J1V2lrYjA4TkZ3dFpnZzhZVDJwVG5ncXRlc2JN?=
 =?utf-8?B?NVZDQmRMSUNuUTFaa2RHUXlkNnNLVGN4TWJYelFFRW5Ud1FEZXExT05NODNi?=
 =?utf-8?B?N0ZuRjd4QzhqU3ZqcFRiUTE1c3VGNDh4bXAwbjFBOEdqTFJJSEJBZlpQNnZm?=
 =?utf-8?B?QU1ZUkU2MW1mL3BFSzJ4YUdlaFRUOWZQYTRNZnhzaE93bWlpU090UWdLUS9V?=
 =?utf-8?B?N2ljRUxTWlFjSGh5OGdzckZIWlc2ZFFhckE0UUN4MWh4VGlacFFOYXlXRzFh?=
 =?utf-8?B?clZhTStzNTFuVzRKV1Y3QjkwMHZjcjZOL25CSDlrNjNDcjg4Y0tKM0p2QmZG?=
 =?utf-8?B?eVNOSm9sQk56aW5yNkptQTA2MEJNSENHY3VLZndwRFVPcG5NMStVVHF2aXRI?=
 =?utf-8?B?VjlFMHhXaXFyQll1RUdkajBWb3RMRnFRd3JTaEJZWUh1TytpekRwdkFkNUtT?=
 =?utf-8?B?WG02cXZOWGhrMzdZNEtwbTdaYUhuZFp4bFJEWG5CSm5VNGFjZnJKK2Jpc1FM?=
 =?utf-8?B?dDE4d0pTQU5VMCtDNnlKR2RQdk5ya0VZWHY4MkwvS1ltcU9UYVR6YVlyaFcr?=
 =?utf-8?B?TUF3Sk9CM09DaDdGRnc2ZkZCemxtSk5xenQvQTBRajRWQ1hZd05nam5oelJP?=
 =?utf-8?B?MFg2SHpZUUNYOFRZSlZFQnpKbmZSNnBDL2tuc2M3Y1NGRWtGQktkNzRQbXlX?=
 =?utf-8?B?NzJvaU5PTk1KZ3RLYTJYcVFmbjdrTHgrVWJHRklZSGVjL0dpV1pQOUZ2U0tm?=
 =?utf-8?B?MlNhR2lIOEZEa25ta0huMGZLSVZWcUhPcXNKQ2Z2c2VPN1hQWEhBNVBMMFNS?=
 =?utf-8?B?MVN3N0grVGVucEptVE0rbzV4NDZzRENVbDhoVXdOWFJLbVZmNCtpUEcwcTFl?=
 =?utf-8?B?NlpORVlDa0FVUDBBMDhRT0xzcWtodzRpaEV4dnVESHgrd2k2dVpqWHRkaWU1?=
 =?utf-8?B?TWJFR3BnaklCM3U3alVwb2E5NnR5cXlSU3MrME8vT0RXcjNiWTRML0tHWkFn?=
 =?utf-8?B?UloxeTJmUHZxNlVTbFpoMEJwMWEvUG5lcVlOU2lHbG5NNllVQXRLUnFGaUMv?=
 =?utf-8?B?L0trQ3ozaUtSRkM5TWdPd2E0Y2JlNUM1YlJrQ21ocTcwRTBwSDFaWXBnQnJX?=
 =?utf-8?B?L2pqZDZ5RHQzak8rNVdhcjB5Zks5MGE3aWZUMWRHTUhkTFgxSWhXb3RtWnI3?=
 =?utf-8?B?a2ZJQjltbU40dWlVb2RUdlA1U1ovTXZ0eldWb2pMUUV1eWNOTWhPZTJVVHBU?=
 =?utf-8?B?N2tteU1sVUFZNkgvOGRWeDRTZmJ2UU81QWFDQmx1Y1djbGVnM1BKMXFDb000?=
 =?utf-8?B?eEJibTh5NnhubVVjOGlmTFZic2Z3NVk3RWo1L1FiNTc0V3ptWnBqYy9UbEJO?=
 =?utf-8?B?L3kxNkNaWDFPU3I2T2RiTHFDckFRdktBTGRpZitid1lPU211UFVjc21xME1r?=
 =?utf-8?Q?qtJTEq9mc0xMhqouL+4SMKmcM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef83934-3a14-4023-e378-08dd82e48022
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 04:00:06.9430 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b5ezS69OTTjY2es49hRXz61LkLmYy9v4JsTCw+nq+NiKX0Ok2ENcs0FHksDDHUMTTAO51jjJNMfcnWSHp6IFQzUSk+Tu1OCA+VD0BuKc42o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5443
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMDMvMTFdIGh3L2FybS9hc3Bl
ZWQ6IEFkZCB2Ym9vdHJvbSBzdXBwb3J0IG9uDQo+IEFTVDI3MDAgRVZCIG1hY2hpbmVzDQo+IA0K
PiBPbiA0LzIzLzI1IDA5OjIzLCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gSW50cm9kdWNlIGEgbmV3
ICJ2Ym9vdHJvbSIgZmllbGQgaW4gdGhlIEFzcGVlZE1hY2hpbmVDbGFzcyB0byBpbmRpY2F0ZQ0K
PiA+IHdoZXRoZXIgYSBtYWNoaW5lIHN1cHBvcnRzIHRoZSB2aXJ0dWFsIGJvb3QgUk9NIHJlZ2lv
bi4NCj4gPg0KPiA+IFNldCB0aGlzIGZpZWxkIHRvIHRydWUgYnkgZGVmYXVsdCBmb3IgdGhlIEFT
VDI3MDAtQTAgYW5kIEFTVDI3MDAtQTENCj4gPiBFVkIgbWFjaGluZXMuDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiBSZXZp
ZXdlZC1ieTogTmFiaWggRXN0ZWZhbiA8bmFiaWhlc3RlZmFuQGdvb2dsZS5jb20+DQo+ID4gVGVz
dGVkLWJ5OiBOYWJpaCBFc3RlZmFuIDxuYWJpaGVzdGVmYW5AZ29vZ2xlLmNvbT4NCj4gDQo+IA0K
PiBJIHdvdWxkIG1lcmdlIHRoaXMgcGF0Y2ggaW4gcGF0Y2ggNi4NCj4gDQpUaGFua3MgZm9yIHN1
Z2dlc3Rpb24uDQpXaWxsIG1lcmdlIHRoaXMgaW4gcGF0Y2ggNg0KSmFtaW4NCj4gDQo+IFRoYW5r
cywNCj4gDQo+IEMuDQo+IA0KPiANCj4gDQo+ID4gLS0tDQo+ID4gICBpbmNsdWRlL2h3L2FybS9h
c3BlZWQuaCB8IDEgKw0KPiA+ICAgaHcvYXJtL2FzcGVlZC5jICAgICAgICAgfCAyICsrDQo+ID4g
ICAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvaHcvYXJtL2FzcGVlZC5oIGIvaW5jbHVkZS9ody9hcm0vYXNwZWVkLmggaW5kZXgN
Cj4gPiA5Y2FlNDVhMWM5Li45NzMyNzdiZWE2IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvaHcv
YXJtL2FzcGVlZC5oDQo+ID4gKysrIGIvaW5jbHVkZS9ody9hcm0vYXNwZWVkLmgNCj4gPiBAQCAt
NDAsNiArNDAsNyBAQCBzdHJ1Y3QgQXNwZWVkTWFjaGluZUNsYXNzIHsNCj4gPiAgICAgICB2b2lk
ICgqaTJjX2luaXQpKEFzcGVlZE1hY2hpbmVTdGF0ZSAqYm1jKTsNCj4gPiAgICAgICB1aW50MzJf
dCB1YXJ0X2RlZmF1bHQ7DQo+ID4gICAgICAgYm9vbCBzZGhjaV93cF9pbnZlcnRlZDsNCj4gPiAr
ICAgIGJvb2wgdmJvb3Ryb207DQo+ID4gICB9Ow0KPiA+DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
aHcvYXJtL2FzcGVlZC5jIGIvaHcvYXJtL2FzcGVlZC5jIGluZGV4DQo+ID4gODJmNDI1ODJmYS4u
ZTg1MmJiYzRjYiAxMDA2NDQNCj4gPiAtLS0gYS9ody9hcm0vYXNwZWVkLmMNCj4gPiArKysgYi9o
dy9hcm0vYXNwZWVkLmMNCj4gPiBAQCAtMTY4OSw2ICsxNjg5LDcgQEAgc3RhdGljIHZvaWQNCj4g
YXNwZWVkX21hY2hpbmVfYXN0MjcwMGEwX2V2Yl9jbGFzc19pbml0KE9iamVjdENsYXNzICpvYywg
dm9pZCAqZGF0YSkNCj4gPiAgICAgICBhbWMtPm1hY3NfbWFzayA9IEFTUEVFRF9NQUMwX09OIHwg
QVNQRUVEX01BQzFfT04gfA0KPiBBU1BFRURfTUFDMl9PTjsNCj4gPiAgICAgICBhbWMtPnVhcnRf
ZGVmYXVsdCA9IEFTUEVFRF9ERVZfVUFSVDEyOw0KPiA+ICAgICAgIGFtYy0+aTJjX2luaXQgID0g
YXN0MjcwMF9ldmJfaTJjX2luaXQ7DQo+ID4gKyAgICBhbWMtPnZib290cm9tID0gdHJ1ZTsNCj4g
PiAgICAgICBtYy0+YXV0b19jcmVhdGVfc2RjYXJkID0gdHJ1ZTsNCj4gPiAgICAgICBtYy0+ZGVm
YXVsdF9yYW1fc2l6ZSA9IDEgKiBHaUI7DQo+ID4gICAgICAgYXNwZWVkX21hY2hpbmVfY2xhc3Nf
aW5pdF9jcHVzX2RlZmF1bHRzKG1jKTsNCj4gPiBAQCAtMTcwOSw2ICsxNzEwLDcgQEAgc3RhdGlj
IHZvaWQNCj4gYXNwZWVkX21hY2hpbmVfYXN0MjcwMGExX2V2Yl9jbGFzc19pbml0KE9iamVjdENs
YXNzICpvYywgdm9pZCAqZGF0YSkNCj4gPiAgICAgICBhbWMtPm1hY3NfbWFzayA9IEFTUEVFRF9N
QUMwX09OIHwgQVNQRUVEX01BQzFfT04gfA0KPiBBU1BFRURfTUFDMl9PTjsNCj4gPiAgICAgICBh
bWMtPnVhcnRfZGVmYXVsdCA9IEFTUEVFRF9ERVZfVUFSVDEyOw0KPiA+ICAgICAgIGFtYy0+aTJj
X2luaXQgID0gYXN0MjcwMF9ldmJfaTJjX2luaXQ7DQo+ID4gKyAgICBhbWMtPnZib290cm9tID0g
dHJ1ZTsNCj4gPiAgICAgICBtYy0+YXV0b19jcmVhdGVfc2RjYXJkID0gdHJ1ZTsNCj4gPiAgICAg
ICBtYy0+ZGVmYXVsdF9yYW1fc2l6ZSA9IDEgKiBHaUI7DQo+ID4gICAgICAgYXNwZWVkX21hY2hp
bmVfY2xhc3NfaW5pdF9jcHVzX2RlZmF1bHRzKG1jKTsNCg0K

