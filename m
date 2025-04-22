Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720B4C369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 03:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u74Qg-0007vD-V0; Mon, 21 Apr 2025 23:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u74Qb-0007uB-FR; Mon, 21 Apr 2025 23:36:09 -0400
Received: from mail-eastasiaazon11021122.outbound.protection.outlook.com
 ([52.101.129.122] helo=HK3PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u74QV-0004si-6R; Mon, 21 Apr 2025 23:36:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFKDkOo/i2A4SIGD8tMb+uVrodIMs2si3Tssr/cjLTqjuCr+pyIzxoNT6VRUFpaWhU5VaEu5SazuDxjIQyG7ON4e+FqJAAsh7lqrT6o+2AXfDartAW3Jd+C/kZmGxvQtm+uHy6n3YCgkiboGRPYNdUQR8eFPusrjc/pTtzlFQSuNvgDnHaAQKPLMjaIMA23xIMii705aJqlIl+blMCC5Aze7jQGARvg8kkF8aADQu8NETSQs6/gAH9OnzP0snfNFQ449bSOOyKimS9TG16efPXSPjdjZpFRuhZNdwCmj4A/YZAZc5MOSSDTRkhMdNFdyxFMNrRxchU6kwsKkZpt+lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rOT2YoYJbVT/TTcw9Pmaoog3QUiu1yaM++yRgwB/tY=;
 b=GHdTkf4HkwqaCP1snBmgchyqeP+XX62rnQnwtUt9CbZJPIJ1RyqgRiVqNjHZAyoacP1hbUfrHZfdjOVC75s171sPYQGTOQfo/qCowfpma8AQWmEaxOAhHPx44Y1Qq96LwKdQ+apXLLHlt9WQhhf9ka2H7Fe17P6KqyXAuicbdwzZIxT6KHji71/a/AnQKiZWRTjnfQwNQE1/LQ8b+qNseHsIDU2VNcNMLXEnDEIkoV6tMvTh8uhVeGQFM9rCoK03Seue4tbsg/6z9/djmlndYcWyQQKkePvhnZm+MS/vHgvpdqLTxMR+k7pHAudaigUINU2+8b90qiGgmcF13XEhwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rOT2YoYJbVT/TTcw9Pmaoog3QUiu1yaM++yRgwB/tY=;
 b=aR2Fm3FpDMMEITfiLu9TQ6B6Png5eaFWuKAM4aBhPx0q+V+zxPuEi+FqhshIHZymIpXo7uYqiJ06zeLScUYwW2H3798NOaLSZ5yORladV4LRBmyA3cezTFNIupGuYkAmZTTLss7Swctv1hpVjBtBoeXLAkYfX0nLxtFR4/aMDxtGCFGHw8Jm7VjTVD7IDnAatzNgWAN7cdgA0AubNK8CeOqy3b+dwIG1kxG9rcPUWfr+qN/Glf0UHE8FxV3vj+7LwNaeAqlHKNDMOFP7VYa6UopXEYSFyWGx6DHyUb6gDD5+mycELemQ/XzcokQFq0T3Y7Jf5GEFX+2amgGnBdntDw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 KL1PR06MB6685.apcprd06.prod.outlook.com (2603:1096:820:fb::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.35; Tue, 22 Apr 2025 03:30:52 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 03:30:51 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: RE: [PATCH v4 06/10] hw/arm/aspeed: Add support for loading vbootrom
 image via "-bios"
Thread-Topic: [PATCH v4 06/10] hw/arm/aspeed: Add support for loading vbootrom
 image via "-bios"
Thread-Index: AQHbr0arWgH+5S4p6UW9XfH4aQxehLOuolcAgABZe1A=
Date: Tue, 22 Apr 2025 03:30:51 +0000
Message-ID: <SI2PR06MB5041D4AD25381C7D1D6A5C1CFCBB2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250417031209.2647703-1-jamin_lin@aspeedtech.com>
 <20250417031209.2647703-7-jamin_lin@aspeedtech.com>
 <85a2947e-6909-4311-8b58-f9eb8045e76c@kaod.org>
In-Reply-To: <85a2947e-6909-4311-8b58-f9eb8045e76c@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|KL1PR06MB6685:EE_
x-ms-office365-filtering-correlation-id: a409ca0b-563b-41a0-68fc-08dd814e1504
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QjdETURSMlNHS25udFQ3RlZsckgxQXRIZ0NDb21EWWtHR1cwc1BxWGVUN2RL?=
 =?utf-8?B?S29SRmdmMUNWcmpEWWowYlZxK0l2cEx6RjNFYWwwLzNFeWt1ODlKM0JLU2da?=
 =?utf-8?B?c3B1eDdmQ0NrcFVJc29iOXlMbmxoYVJwbVJNY0JOSStwMnVVSytkSzZoN1hO?=
 =?utf-8?B?RHRVK1BwVzNsNjRoVFdFeGZCanZtNmlJMERPS2Y1TEwzWTdSSW5sV0E0Y2FE?=
 =?utf-8?B?SjM1bitNeTdPQ3VMOFkrTG9IY1BMYTIva3ZDTzh2L3JnL3djZkJJbDdMdmhm?=
 =?utf-8?B?YjdReldKV1V5djZ3UUt0UnJYNjVQL2dUSSt0VlpYbUNWZU5RNHVUbmtuTFkr?=
 =?utf-8?B?RDVBL0ZEcGh0UysrR3F0dk5wZ2xYYkcxR3E4Nyt5Z1ZUY3BReUNtQnZnYlhz?=
 =?utf-8?B?MUZaMVdJZFlEa2l3MGZ1RitCQlZ6ck9mOFFMcGY2T2RaK21uR0JjQVJhMDd2?=
 =?utf-8?B?ZDd5eUhneTJoOUluS1JXNFB2UXV1eEROUmw0ZEpybE01TXFidDdOR1huWlV6?=
 =?utf-8?B?Z1phZzNDbzBEalpJamZQNkQ2N0kwRVNpM2JkWkUyeVg1c1B0RmUwMFBVaDg2?=
 =?utf-8?B?Zy9ySHM5YkgwQ1k1Sm0rRUhjWk9QQkxZU0c1aVJXTUJGQWozaThvWDVPcjU2?=
 =?utf-8?B?cHdMSU05ZStPVTZJWWhPYnVUbDVkb1cyZFJzQzJHVzhQL0NlMURmaXR3cXQw?=
 =?utf-8?B?UVFKZU5nbVdLQ0xYQWFMbGVPWUlKemNlbEEwUVNFNEFOeG9xSGtLc0ZCdk9J?=
 =?utf-8?B?bjdtaE5ydlhHNXZrTHB5WnZpT25EQXhreU5EMzRRTlBiRzg2TG9hYU1aeEdj?=
 =?utf-8?B?dHdIdWhLT2Q5ZHQ2elJ6V2h0dU14YVMrUkxzK2l4cEdJMGs0TXNnOXNyYjJw?=
 =?utf-8?B?di81eWd5cUh3QURaVlNGdW9BNEFCb05mQlpxNlVZNms2TVNid1YybFVFVjdV?=
 =?utf-8?B?bFR0MHBHWGhaZFpkMWZrbE5IdjVmN2xRK3BhSkxoR3JxbFp2QXkzSlp0NVdT?=
 =?utf-8?B?dStTV2RwYml1ZUVkck1ONkp2Q1dzcmtRTHN2Uy9lUzdtUnowMElSWVlpaUFF?=
 =?utf-8?B?QnprSXhRMXBWeVpIaHkybjhaTHdHSWtPcUdtc1h1N0wwemRyOXNrSUZOUkxp?=
 =?utf-8?B?Q1E2aGg5RTdDY28wQjVCUHFxSjJoL2lINE0zM2djdDdjbWpNdmsxMjc0dU5v?=
 =?utf-8?B?Z1M5NFE2Zy9tTkNRbmlYOVhMSzZVVndRYlFmOEEyandhOU9QUnZwMVRWc1RU?=
 =?utf-8?B?anRCUmJoMUp3UGtyVjJYRVhRNWlYc2Iwd3lWYkdDL2FJemxQSmlZN1dLclhp?=
 =?utf-8?B?OHR5N2ViaXRZNFZVMyswL3N1dEQxT0g3OG90RWpnbEZIb3VxT2xVNjlNWnRk?=
 =?utf-8?B?ditmeXhLVFlTL1pSdUdLSERFMkRlSUwxcVMyT2FYRFNRMWJpRkgyaTQvTlVF?=
 =?utf-8?B?bXlpK1hxNmQrOE5ueWI4MHhPMWRLVG9EQUZ4UWZKa3B1REJoL2FxMEk4bnN6?=
 =?utf-8?B?Q1BIVWRJK0FqWVY2c2xjelJaUm5Tc09FNStFZVlVc3JSWjY3aSt1M2tkWGJ6?=
 =?utf-8?B?VDBMWGx3SEtJNnZWM1V3TWhBTm5La1FhTnlRR0JuSzhlT0RZU1kvNTFVNllM?=
 =?utf-8?B?dVdSVmZOazcrNXllam1FeEJIYmgrUXFyRGhoL2NpSEdHa1RRclJnNFNtM1ho?=
 =?utf-8?B?MFg3N2xPbE11Q3kyVlAwUFNoV3B2K2hxclhncmdIemFDM2J5dTFqMW1LS1RM?=
 =?utf-8?B?L0lIMjloRFRNbVNJOVpzUVZWT1BHRDY1MHlZRDJpSi9qaFB2RTA5eFVYWXUr?=
 =?utf-8?B?Z045TVRWMUNOVElzY2JwK2w0N1BQcTF5aFQxcy9CMzdqcHlJcllnSGsxUG9m?=
 =?utf-8?B?V0kwNEVYalVmUVk1WE1odjBkUFFoNmUxVURlTVYrNXZFTkdKSVVPQmZEeEVW?=
 =?utf-8?Q?oqNC3gDNvDc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVpVYW9YZGdUbEYrZzdZeGN0VkZoOWJNS0JVZ1M2UVFXeUUxVGtrcmROZWRS?=
 =?utf-8?B?Y1kvY0F5cGhCMUdIWmlGb2pwQUNaNC9mS2kyT3ZZRzJyUThlV1VCL0N3SXk0?=
 =?utf-8?B?cm54TjJRWEJBd21Jekc1MlpRMEFadS8vZXVFcVUyTUZoMlFHVWd2QmhOTDNL?=
 =?utf-8?B?NWxvdU1Ea1BhVGdiNEdpaTF2T0VKdDExVEhUMDdiVFZGdzVMYmZZNUtkNEZm?=
 =?utf-8?B?ekdMQVpUNGVSLy9zVnhFMEV4SUFuN3BmTS8xYTRkRnRjeUk2SDA0dE9TS0sv?=
 =?utf-8?B?enRWR1JMei8vdDQvRFh1OHFzVEQwL21ONXlvZHNWQ2RzcldPOVp3SitBbFEr?=
 =?utf-8?B?MGFYRHI2VXFocmh0VThPZERXbE9qbWVZVm12TEk5ZUxNUFlNbzlsZWtNeWhZ?=
 =?utf-8?B?RURCc1VzUXRyc1lGdkFYQ2JieUtZSDB3bExuN2RuTmdkSU9PRTVXWVdobzhm?=
 =?utf-8?B?UzIvMmczTWRhSFlnNFBtWWY4dTVmaHpLcTFoYkgvQXdTUnhZR3EvMkN4ZWpO?=
 =?utf-8?B?U3VOTXdaV0t1cWRaTGRrNzNHbUd6YVhjc2pzeVhQN1VOMzI0SDVFdFl4UzlR?=
 =?utf-8?B?UC9TTm5NWC9ucEliZ3RyQncxNGlrUHBnZDlJRVlrTE1aRWtCRW9jWFgxcFF6?=
 =?utf-8?B?ZXM1ZG91QUxVaTVWcjF1VHVpWldWTi9yZzJYSHUyR0w3cnExTlZsbjF3THlO?=
 =?utf-8?B?Wjd5V04rQkhLS3c3TStleGVwZDJwZzlncmxOTUpEbTRZTUxwQzQ5RW85dGV6?=
 =?utf-8?B?WStUZXBxYjBnZGFHOHNVSzFucmRSU1RzMDJDS2xpMUtUQ2FjeGVZYTRUNWRH?=
 =?utf-8?B?d0xSSUxITTZ3bFNiR0FFWFZ0UTQ0RjdoMWVrSFFEWWtLU3VYeno5Z3lmVDRR?=
 =?utf-8?B?Q20vbmRidzJXYWc0amVRU0NVV3hyOXE3cThRT1EyMVhXOW01YTRaakNGck1C?=
 =?utf-8?B?V1MxUEFFVXpWdGRnS01RWlNoNWpZVU1QNGZmbnRFQWVCQVI0bTdOOGtBSmZS?=
 =?utf-8?B?OGFSMDlpZW85QUpQd0hzckFnOXRYekI2V0VDOU9IQlNXalBKbkJwRzZZSU5Q?=
 =?utf-8?B?MzlQckladHU2eVZQUEgyL1Jmc2Qxb2h4eW1ySGcrUUNPNndkVFRtSUJVSlpy?=
 =?utf-8?B?UStnVFdubTdESzAyRkZ1UjNKb3h6bmh6VGxvdmxEcGtKa2ZBclh4TGo5VlMx?=
 =?utf-8?B?Mm96c3FoRFp4VkxVT3M1VDdPMnJNUWhIT0wra2U1TjUrTzFkUGdGdlJtSW1j?=
 =?utf-8?B?MHZrWXdDOE1NS3lGQ1V0MkFiSGxjS2Q0T2srTHhYK3lTa3d5WDlWSHdvWmxP?=
 =?utf-8?B?SnpkWHpTVGRzdHZGd1BjRDJTNGtzSU5pdEpGbWVPSkJyWTIxR1NqYnFleHh1?=
 =?utf-8?B?bGh1ZC9zNEhYUG5CRDN3bEZ0NStXVFdNUVdOaC9ReDBSNzdFT2hha1VSR05U?=
 =?utf-8?B?ajhKbkUxbTltU0U1UXowNDZtRlhZRzUrWVBjUEVJbXBjeDB5dFFxQjg0VXRG?=
 =?utf-8?B?UDNOTEVJRUljbDhHV1NHMERWOWZNT2MvRDV4T0hpVEY1RHE4SEJ2QU50SGtJ?=
 =?utf-8?B?UmRUSEZkdXU0Vml3WHlhTGVUcEFyLzZiS0toYmRJWnViZ3VHcFVYSitHTCtG?=
 =?utf-8?B?UHJOZERoUGlqWXkzRFZZZlVFb003MVFic1FZWUZtZzFsK1RycXV0V2luM251?=
 =?utf-8?B?clE2WHdHMmFHdmxBa1BjV29tMDBjVCtPNzlES2lZSzlpMkFDenlaYjdCR001?=
 =?utf-8?B?VGFwakFzN1p4eit2Ui9DRGVOTUxVUzZWWUphRG90cmZPQlJKMk80ZW9xZnRR?=
 =?utf-8?B?T3Nwb0o1VEQ4RURTQlIwS2xQMFpLQmFDTHB3c2prd0RBbFU4M05DUjZudFky?=
 =?utf-8?B?MGNpbk9sZHlmTVFBeDlYbTgwQlpiSXc4OGxveDA3cklUV0NiUHMranlIaWNx?=
 =?utf-8?B?cGpTdUpSYmF6Z0hYbkVibDFRdFJ5R01JN0srTnp6U3FwR29lNEtqb3F0WWZM?=
 =?utf-8?B?VGdWMXBFSGdkbnhzTnNoZ2Z4WkhuemttWElQdW9yVFR2VUJKTXRvMk1GQnhj?=
 =?utf-8?B?SkFZeXYvaGhvOHVBbXYzRVMyaTJWclViTnBBemFpMkM0N3MxQkdCdHdscFR3?=
 =?utf-8?Q?edkGh2PODUU4mdDq/L0IvCUzE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a409ca0b-563b-41a0-68fc-08dd814e1504
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 03:30:51.6092 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vIQ/MRjaUYlcA9mX4JwyQdpWlV37po4u7zhaTO06PXxq7KHD3U4adu6J6WASfCNbpCdTublLEz4RuRV6N56Z0fQcSV+tg1SppuoU+4y82zM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6685
Received-SPF: pass client-ip=52.101.129.122;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=HK3PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGkgQ2VkcmljLCANCg0KPiBDYzogVHJveSBMZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2guY29tPjsg
bmFiaWhlc3RlZmFuQGdvb2dsZS5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAwNi8xMF0g
aHcvYXJtL2FzcGVlZDogQWRkIHN1cHBvcnQgZm9yIGxvYWRpbmcNCj4gdmJvb3Ryb20gaW1hZ2Ug
dmlhICItYmlvcyINCj4gDQo+IE9uIDQvMTcvMjUgMDU6MTIsIEphbWluIExpbiB3cm90ZToNCj4g
PiBJbnRyb2R1Y2UgImFzcGVlZF9sb2FkX3Zib290cm9tKCkiIHRvIHN1cHBvcnQgbG9hZGluZyBh
IHZpcnR1YWwgYm9vdA0KPiA+IFJPTSBpbWFnZSBpbnRvIHRoZSB2Ym9vdHJvbSBtZW1vcnkgcmVn
aW9uLCB1c2luZyB0aGUgIi1iaW9zIg0KPiBjb21tYW5kLWxpbmUgb3B0aW9uLg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4g
UmV2aWV3ZWQtYnk6IE5hYmloIEVzdGVmYW4gPG5hYmloZXN0ZWZhbkBnb29nbGUuY29tPg0KPiA+
IFRlc3RlZC1ieTogTmFiaWggRXN0ZWZhbiA8bmFiaWhlc3RlZmFuQGdvb2dsZS5jb20+DQo+ID4g
LS0tDQo+ID4gICBpbmNsdWRlL2h3L2FybS9hc3BlZWQuaCB8ICAxICsNCj4gPiAgIGh3L2FybS9h
c3BlZWQuYyAgICAgICAgIHwgMzYNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDM3IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2h3L2FybS9hc3BlZWQuaCBiL2luY2x1ZGUvaHcvYXJtL2FzcGVl
ZC5oIGluZGV4DQo+ID4gOTczMjc3YmVhNi4uMmI4MzMyYTdkNyAxMDA2NDQNCj4gPiAtLS0gYS9p
bmNsdWRlL2h3L2FybS9hc3BlZWQuaA0KPiA+ICsrKyBiL2luY2x1ZGUvaHcvYXJtL2FzcGVlZC5o
DQo+ID4gQEAgLTQxLDYgKzQxLDcgQEAgc3RydWN0IEFzcGVlZE1hY2hpbmVDbGFzcyB7DQo+ID4g
ICAgICAgdWludDMyX3QgdWFydF9kZWZhdWx0Ow0KPiA+ICAgICAgIGJvb2wgc2RoY2lfd3BfaW52
ZXJ0ZWQ7DQo+ID4gICAgICAgYm9vbCB2Ym9vdHJvbTsNCj4gPiArICAgIGNvbnN0IGNoYXIgKnZi
b290cm9tX25hbWU7DQo+IA0KPiBJIGRvbid0IHRoaW5rIGFkZGluZyBhIGNsYXNzIGF0dHJpYnV0
ZSBmb3IgdGhlIGRlZmF1bHQgZmlybXdhcmUgaW1hZ2UgZmlsZSBpcyB0aGF0DQo+IHVzZWZ1bC4g
QSBkZWZpbmUgc2hvdWxkIGJlIGVub3VnaCA6DQo+IA0KPiAgICAgICNkZWZpbmUgVkJPT1RST01f
RklMRV9OQU1FICAiYXN0Mjd4MF9ib290cm9tLmJpbiINCj4gDQo+IGFuZCB1c2UgVkJPT1RST01f
RklMRV9OQU1FIHdoZW4gZGVmaW5pbmcgdGhlIGJpb3NfbmFtZSB2YXJpYWJsZS4NCj4gDQo+IFVu
bGVzcyB5b3UgYWxyZWFkeSBwbGFuIHRvIGhhdmUgZGlmZmVyZW50IGRlZmF1bHQgZmlybXdhcmUg
ZmlsZXMgZm9yIHRoZSBhc3QyNyoNCj4gbWFjaGluZXMgPw0KPiANCg0KSWYgd2UgcGxhbiB0byBz
dXBwb3J0IHRoZSB2Ym9vdHJvbSBmZWF0dXJlIGZvciBtdWx0aXBsZSBBU1BFRUQgU29DcyBzdWNo
IGFzIHRoZSBBU1QyOHgwIHNlcmllcywgaXQgc2VlbXMgdGhhdCB0aGUgY3VycmVudCBkZWZhdWx0
IGRlZmluZQ0KZm9yIHRoZSBpbWFnZSBuYW1lIGNhbm5vdCBiZSByZXVzZWQgZm9yIGJvdGggQVNU
Mjd4MCBhbmQgZnV0dXJlIEFTUEVFRCBTb0NzLiBUaGlzIGlzIGJlY2F1c2UgdGhlIHZib290cm9t
IGZpbGUgbmFtZXMgZGlmZmVyIGJldHdlZW4gdGhlIHR3byBzZXJpZXMuDQpUaGF04oCZcyB0aGUg
cmVhc29uIEkgaW50cm9kdWNlZCBhIG1hY2hpbmUgY2xhc3MgYXR0cmlidXRlIOKAlCB0byBhbGxv
dyBmbGV4aWJpbGl0eSBpbiBzcGVjaWZ5aW5nIHRoZSBjb3JyZWN0IHZib290cm9tIG5hbWUgZm9y
IGVhY2ggU29DIGZhbWlseS4NCkkgd2lsbCB1c2UgdGhlIERFRklORSBmb3Igbm93IGluIHRoZSB2
NSBwYXRjaC4gV2hlbiB3ZSBwbGFuIHRvIHN1cHBvcnQgdmJvb3Ryb20gZm9yIG5ldyBTb0NzIGlu
IHRoZSBmdXR1cmUsIHdlIGNhbiByZXZpc2l0IGFuZCBkaXNjdXNzIHRoZSBhcHByb3ByaWF0ZSBk
ZWZhdWx0IG5hbWluZyBjb252ZW50aW9uIGF0IHRoYXQgdGltZS4NCg0KPiANCj4gPiAgIH07DQo+
ID4NCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9hcm0vYXNwZWVkLmMgYi9ody9hcm0vYXNwZWVk
LmMgaW5kZXgNCj4gPiBiNzBhMTIwZTYyLi43ZjExMzcxZjAyIDEwMDY0NA0KPiA+IC0tLSBhL2h3
L2FybS9hc3BlZWQuYw0KPiA+ICsrKyBiL2h3L2FybS9hc3BlZWQuYw0KPiA+IEBAIC0yNyw2ICsy
Nyw3IEBADQo+ID4gICAjaW5jbHVkZSAic3lzdGVtL3Jlc2V0LmgiDQo+ID4gICAjaW5jbHVkZSAi
aHcvbG9hZGVyLmgiDQo+ID4gICAjaW5jbHVkZSAicWVtdS9lcnJvci1yZXBvcnQuaCINCj4gPiAr
I2luY2x1ZGUgInFlbXUvZGF0YWRpci5oIg0KPiA+ICAgI2luY2x1ZGUgInFlbXUvdW5pdHMuaCIN
Cj4gPiAgICNpbmNsdWRlICJody9xZGV2LWNsb2NrLmgiDQo+ID4gICAjaW5jbHVkZSAic3lzdGVt
L3N5c3RlbS5oIg0KPiA+IEBAIC0zMDUsNiArMzA2LDM0IEBAIHN0YXRpYyB2b2lkDQo+IGFzcGVl
ZF9pbnN0YWxsX2Jvb3Rfcm9tKEFzcGVlZE1hY2hpbmVTdGF0ZSAqYm1jLCBCbG9ja0JhY2tlbmQg
KmJsaywNCj4gPiAgICAgICAgICAgICAgICAgICAgICByb21fc2l6ZSwgJmVycm9yX2Fib3J0KTsN
Cj4gPiAgIH0NCj4gPg0KPiA+ICsvKg0KPiA+ICsgKiBUaGlzIGZ1bmN0aW9uIGxvY2F0ZXMgdGhl
IHZib290cm9tIGltYWdlIGZpbGUgc3BlY2lmaWVkIHZpYSB0aGUNCj4gPiArY29tbWFuZCBsaW5l
DQo+ID4gKyAqIHVzaW5nIHRoZSAtYmlvcyBvcHRpb24uIEl0IGxvYWRzIHRoZSBzcGVjaWZpZWQg
aW1hZ2UgaW50byB0aGUNCj4gPiArdmJvb3Ryb20NCj4gPiArICogbWVtb3J5IHJlZ2lvbiBhbmQg
aGFuZGxlcyBlcnJvcnMgaWYgdGhlIGZpbGUgY2Fubm90IGJlIGZvdW5kIG9yIGxvYWRlZC4NCj4g
PiArICovDQo+ID4gK3N0YXRpYyB2b2lkIGFzcGVlZF9sb2FkX3Zib290cm9tKE1hY2hpbmVTdGF0
ZSAqbWFjaGluZSwgdWludDY0X3QNCj4gcm9tX3NpemUsDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkgew0KPiA+ICsgICAgQXNwZWVkTWFjaGluZVN0
YXRlICpibWMgPSBBU1BFRURfTUFDSElORShtYWNoaW5lKTsNCj4gPiArICAgIEFzcGVlZE1hY2hp
bmVDbGFzcyAqYW1jID0NCj4gQVNQRUVEX01BQ0hJTkVfR0VUX0NMQVNTKG1hY2hpbmUpOw0KPiA+
ICsgICAgY29uc3QgY2hhciAqYmlvc19uYW1lID0gbWFjaGluZS0+ZmlybXdhcmUgPzoNCj4gYW1j
LT52Ym9vdHJvbV9uYW1lOw0KPiA+ICsgICAgZ19hdXRvZnJlZSBjaGFyICpmaWxlbmFtZSA9IE5V
TEw7DQo+ID4gKyAgICBBc3BlZWRTb0NTdGF0ZSAqc29jID0gYm1jLT5zb2M7DQo+ID4gKyAgICBp
bnQgcmV0Ow0KPiA+ICsNCj4gPiArICAgIGZpbGVuYW1lID0gcWVtdV9maW5kX2ZpbGUoUUVNVV9G
SUxFX1RZUEVfQklPUywgYmlvc19uYW1lKTsNCj4gPiArICAgIGlmICghZmlsZW5hbWUpIHsNCj4g
PiArICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJDb3VsZCBub3QgZmluZCB2Ym9vdHJvbSBpbWFn
ZSAnJXMnIiwNCj4gYmlvc19uYW1lKTsNCj4gPiArICAgICAgICByZXR1cm47DQo+ID4gKyAgICB9
DQo+ID4gKw0KPiA+ICsgICAgcmV0ID0gbG9hZF9pbWFnZV9tcihmaWxlbmFtZSwgJnNvYy0+dmJv
b3Ryb20pOw0KPiA+ICsgICAgaWYgKHJldCA8IDApIHsNCj4gPiArICAgICAgICBlcnJvcl9zZXRn
KGVycnAsICJGYWlsZWQgdG8gbG9hZCB2Ym9vdHJvbSBpbWFnZSAnJXMnIiwNCj4gYmlvc19uYW1l
KTsNCj4gPiArICAgICAgICByZXR1cm47DQo+ID4gKyAgICB9DQo+ID4gK30NCj4gPiArDQo+ID4g
ICB2b2lkIGFzcGVlZF9ib2FyZF9pbml0X2ZsYXNoZXMoQXNwZWVkU01DU3RhdGUgKnMsIGNvbnN0
IGNoYXINCj4gKmZsYXNodHlwZSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdW5zaWduZWQgaW50IGNvdW50LCBpbnQNCj4gdW5pdDApDQo+ID4gICB7DQo+ID4g
QEAgLTQ4Myw2ICs1MTIsMTEgQEAgc3RhdGljIHZvaWQgYXNwZWVkX21hY2hpbmVfaW5pdChNYWNo
aW5lU3RhdGUNCj4gKm1hY2hpbmUpDQo+ID4gICAgICAgICAgIH0NCj4gPiAgICAgICB9DQo+ID4N
Cj4gPiArICAgIGlmIChhbWMtPnZib290cm9tKSB7DQo+IA0KPiB3aGF0IGFib3V0IHRoZSAiYXNw
ZWVkLmJvb3Rfcm9tIiByZWdpb24gPyBJcyBpdCBvayB0byBoYXZlIGJvdGggPw0KPiANCkJhc2Vk
IG9uIHRoZSBkZXNpZ24gb2YgYXNwZWVkX2luc3RhbGxfYm9vdF9yb20sIHVzZXJzIGNhbiBwbGFj
ZSB0aGVpciBST00gY29kZSBhdCB0aGUgdG9wIG9mIHRoZSBpbWFnZS1ibWMsIGFuZCB0aGlzIGZ1
bmN0aW9uIHdpbGwgaW5zdGFsbCBpbWFnZS1ibWMgd2hpY2ggaW5jbHVkZWQgdGhlIHVzZXIncyBS
T00gSU1BR0UgYXQgdGhlIEFTUEVFRF9ERVZfU1BJX0JPT1QgYWRkcmVzcy4NCkZvciBBU1QyNjAw
LCB1c2VycyB0eXBpY2FsbHkgc2V0IHRoZSBib290IGFkZHJlc3MgdG8gMHgwIGFuZCBib290IGRp
cmVjdGx5IGZyb20gdGhlcmUuDQoNCkZvciBBU1QyNzAwLCB3ZSBpbnRyb2R1Y2VkIGEgdmJvb3Ry
b20gdG8gc2ltdWxhdGUgdGhlIFJPTSBjb2RlIGFuZCB0aGUgQk9PVE1DVSBTUEwgKFJJU0MtViku
DQpXZSB1c2UgYXNwZWVkX2luc3RhbGxfYm9vdF9yb20gdG8gbG9hZCB0aGUgaW1hZ2UtYm1jIGF0
IHRoZSBGTUMgQ1MwIG1lbW9yeS1tYXBwZWQgSS9PIGFkZHJlc3MsIHNvIHdlIHNldCBBU1BFRURf
REVWX1NQSV9CT09UIHRvIDB4MTAwMDAwMDAwLg0KV2UgbG9hZCB0aGUgdmJvb3Ryb20gaW1hZ2Ug
aW50byB0aGUgdmJvb3Ryb20gbWVtb3J5IHJlZ2lvbiBhdCBhZGRyZXNzIDB4MCBhbmQgc3RhcnQg
ZXhlY3V0aW9uIGZyb20gdGhlcmUuDQpUaGUgZ3Vlc3QgT1MgZmlyc3QgZW50ZXJzIHRoZSB2Ym9v
dHJvbS4gRnJvbSB0aGVyZSwgaXQgY2FuIGVhc2lseSBhY2Nlc3MgdGhlIGZsYXNoIGRhdGEgKGlt
YWdlLWJtYykgYXQgMHgxMDAwMDAwMDAsIHNpbmNlIHZib290cm9tIGl0c2VsZiBkb2VzbuKAmXQg
cmVxdWlyZSBTUEkvZmxhc2gvZW1tYyBob3N0IGRyaXZlcnMuDQpUbyBzdXBwb3J0IGZ1dHVyZSBl
TU1DIGJvb3RpbmcsIHdlIGFsc28gcGxhbiB0byBpbnN0YWxsIHRoZSBlTU1DIGltYWdlIGF0IHRo
ZSBBU1BFRURfREVWX1NQSV9CT09UIGFkZHJlc3MuDQpodHRwczovL2dpdGh1Yi5jb20vcWVtdS9x
ZW11L2Jsb2IvbWFzdGVyL2h3L2FybS9hc3BlZWQuYyNMNDc3DQoNCkl0IGlzIGZ1bGx5IHN1cHBv
cnRlZCB0byBoYXZlIGJvdGggb3B0aW9ucy4gSWYgdXNlcnMgd2FudCB0byBpbmNsdWRlIHRoZWly
IG93biBST00gY29kZSB3aXRoaW4gaW1hZ2UtYm1jLCB0aGV5IGNhbiBzZXQgdGhlIHByb2dyYW0g
Y291bnRlciAoUEMpIHRvIDB4MTAwMDAwMDAwLCBqdXN0IGxpa2UgaG93IGEgbWFudWFsIGxvYWRl
ciBzZXQgaXQgdG8gMHg0MzAwMDAwMCAoZS5nLiwgdG8ganVtcCBkaXJlY3RseSB0byBCTDMxKS4N
ClRoaXMgYWxsb3dzIHVzZXJzIHRvIGJ5cGFzcyB0aGUgdmJvb3Ryb20gaWYgZGVzaXJlZC4NCkhv
d2V2ZXIsIEkgYmVsaWV2ZSB0aGlzIHVzZSBjYXNlIHdpbGwgYmUgcmFyZSwgYXMgdGhlIHZib290
cm9tIGRlc2lnbiBzaG91bGQgYmUgYWJsZSB0byBzYXRpc2Z5IG1vc3QsIGlmIG5vdCBhbGwsIHVz
ZXIgcmVxdWlyZW1lbnRzLg0KDQpUaGFua3MtSmFtaW4NCg0KPiANCj4gVGhhbmtzLA0KPiANCj4g
Qy4NCj4gDQo+IA0KPiANCj4gPiArICAgICAgICByb21fc2l6ZSA9IG1lbW9yeV9yZWdpb25fc2l6
ZSgmYm1jLT5zb2MtPnZib290cm9tKTsNCj4gPiArICAgICAgICBhc3BlZWRfbG9hZF92Ym9vdHJv
bShtYWNoaW5lLCByb21fc2l6ZSwgJmVycm9yX2Fib3J0KTsNCj4gPiArICAgIH0NCj4gPiArDQo+
ID4gICAgICAgYXJtX2xvYWRfa2VybmVsKEFSTV9DUFUoZmlyc3RfY3B1KSwgbWFjaGluZSwNCj4g
JmFzcGVlZF9ib2FyZF9iaW5mbyk7DQo+ID4gICB9DQo+ID4NCj4gPiBAQCAtMTY5MSw2ICsxNzI1
LDcgQEAgc3RhdGljIHZvaWQNCj4gYXNwZWVkX21hY2hpbmVfYXN0MjcwMGEwX2V2Yl9jbGFzc19p
bml0KE9iamVjdENsYXNzICpvYywgdm9pZCAqZGF0YSkNCj4gPiAgICAgICBhbWMtPnVhcnRfZGVm
YXVsdCA9IEFTUEVFRF9ERVZfVUFSVDEyOw0KPiA+ICAgICAgIGFtYy0+aTJjX2luaXQgID0gYXN0
MjcwMF9ldmJfaTJjX2luaXQ7DQo+ID4gICAgICAgYW1jLT52Ym9vdHJvbSA9IHRydWU7DQo+ID4g
KyAgICBhbWMtPnZib290cm9tX25hbWUgPSAiYXN0Mjd4MF9ib290cm9tLmJpbiI7DQo+ID4gICAg
ICAgbWMtPmF1dG9fY3JlYXRlX3NkY2FyZCA9IHRydWU7DQo+ID4gICAgICAgbWMtPmRlZmF1bHRf
cmFtX3NpemUgPSAxICogR2lCOw0KPiA+ICAgICAgIGFzcGVlZF9tYWNoaW5lX2NsYXNzX2luaXRf
Y3B1c19kZWZhdWx0cyhtYyk7DQo+ID4gQEAgLTE3MTIsNiArMTc0Nyw3IEBAIHN0YXRpYyB2b2lk
DQo+IGFzcGVlZF9tYWNoaW5lX2FzdDI3MDBhMV9ldmJfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAq
b2MsIHZvaWQgKmRhdGEpDQo+ID4gICAgICAgYW1jLT51YXJ0X2RlZmF1bHQgPSBBU1BFRURfREVW
X1VBUlQxMjsNCj4gPiAgICAgICBhbWMtPmkyY19pbml0ICA9IGFzdDI3MDBfZXZiX2kyY19pbml0
Ow0KPiA+ICAgICAgIGFtYy0+dmJvb3Ryb20gPSB0cnVlOw0KPiA+ICsgICAgYW1jLT52Ym9vdHJv
bV9uYW1lID0gImFzdDI3eDBfYm9vdHJvbS5iaW4iOw0KPiA+ICAgICAgIG1jLT5hdXRvX2NyZWF0
ZV9zZGNhcmQgPSB0cnVlOw0KPiA+ICAgICAgIG1jLT5kZWZhdWx0X3JhbV9zaXplID0gMSAqIEdp
QjsNCj4gPiAgICAgICBhc3BlZWRfbWFjaGluZV9jbGFzc19pbml0X2NwdXNfZGVmYXVsdHMobWMp
Ow0KDQo=

