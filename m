Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C328E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 01:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQytI-0007ND-AN; Thu, 26 Dec 2024 20:11:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1tQytF-0007Mn-Co; Thu, 26 Dec 2024 20:11:45 -0500
Received: from mail-eastasiaazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c400::] helo=HK2PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1tQytD-00084Q-3w; Thu, 26 Dec 2024 20:11:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXoPmoT48TzHq0afUyVwaovEZ8AzZPLalcYFprPPIqYh5Q5kx67rdy3hRb7fgb/q13x0nEsn8/GOFM52sgrJfo2aJ3i5oZ/Wp3bzTNNC1NnIAn2nVlF0MnryFRnwwj3gnX+XU9bPvd6oF9b7w0W03iiZoEvl8CTim9uWuxMlxAXy5Z9+pL/KCUczVmeftHpP8l5mxQF47dygyJJJgqmRanElzOsDRpYd8FH3eZiYsulirXXGVHJ8O6Iz4+sQotgKtF5WTntK5OuetAo+fIyGWLKvtEpzlJBzQUQnkREgElZxkYLmToMGT7WRnS+99M++j5qNYYNpsXfY02hn7lAYQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cep9pj0ZxIF8pYE+0tdSpZaCzdKSbWivaBRycPOPgsI=;
 b=XKN+eSNNPU4ASvY8Xl3E9M7tB22UqB7Xz7vdrPBKXxmq2VdX0EFKaMwrxAob5QKLu/dK4ABG+3p3ztj/75d8TxzloWGN8uUqy1TNwFZdGflqygsQ+OczQCcIwHZBjnBZyatYl9LV4OAGcpUxMUapHrkXRuOpVWl1w/CrUK4muA2oJzq5ZWadc3HyLpa5UnwesnLb7yuLKLBUpuuNAhEOVw4+QWVZ3AdCuU9Y5ckViw7i5kFow1qdmbZ6Ohslc4jQ/I6OZtjAezqqiSGcRoDt2iG7moSVYYtVwi5Hj9pjCM7ciNeCyluHTGwAmdRxymaEeOLUjnMuNcFa4nMks3Xsdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cep9pj0ZxIF8pYE+0tdSpZaCzdKSbWivaBRycPOPgsI=;
 b=NVIfaQlBzLPWxaUDlTIy4mpI4HgZjAI8SeO6NPtCMgrzhH3t1hBYjcbXBmZPFX9+Aej7Mv5mDwVAr2X35wKHP++pFPzDwaGEgJNtCzbESxd+b7niw2QhFniGzE21ODaXDkdtsF012CHc7VrZTT33W3+WUrXSjeK/rDulCwNXuYzJlzAj38LQbwCz38xLPcTn4IWiR65rTHP1xpozrwRm/hqJLfWZw733ydi5Y5TKsrL5yBINtjBcXhV+tvyLGbf+dWDAtIgCn0CY957fnVNMnVrrqBbOQAXnevl6e+qRX7s+SG8x4gmqwD6GbM6r93K98SXFwAvIs7Mrd/mppsLmFQ==
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 (2603:1096:820:29::12) by TYSPR06MB6605.apcprd06.prod.outlook.com
 (2603:1096:400:47d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.9; Fri, 27 Dec
 2024 01:11:30 +0000
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a]) by KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a%5]) with mapi id 15.20.8293.000; Fri, 27 Dec 2024
 01:11:30 +0000
From: Steven Lee <steven_lee@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH 1/5] aspeed: Make sdhci_attach_drive and write_boot_rom
 public
Thread-Topic: [PATCH 1/5] aspeed: Make sdhci_attach_drive and write_boot_rom
 public
Thread-Index: AQHbVnErcGV/Sv8L9kaZNX1hkFxSKrL200AAgAJ3fmA=
Date: Fri, 27 Dec 2024 01:11:30 +0000
Message-ID: <KL1PR0601MB4180DD765BD3ED1C29361CE6850E2@KL1PR0601MB4180.apcprd06.prod.outlook.com>
References: <20241225020311.3718080-1-steven_lee@aspeedtech.com>
 <20241225020311.3718080-2-steven_lee@aspeedtech.com>
 <6ac5dae8-db32-4275-9570-da1696a8764b@linaro.org>
In-Reply-To: <6ac5dae8-db32-4275-9570-da1696a8764b@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4180:EE_|TYSPR06MB6605:EE_
x-ms-office365-filtering-correlation-id: bbafd334-1360-4511-8d6b-08dd26136552
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?d3pLMndHcTJVYWtWVWpUN0Jvci9vUmQ2anVVdk4wd29lamdSWHdnbWhOaGpG?=
 =?utf-8?B?dGNYNUpsakxqUC9DNU83azhvR2pnRlo2cHkvUEh3RlB2cjFsYnZmYjlsNkZ2?=
 =?utf-8?B?ajI1ZmJ6Nk1nd1NWWTFGRXF6U2RYNTNBZXVlM1hQYnNyZk9KWXNNNERiWkcr?=
 =?utf-8?B?ZFB0N3VFRXQ4bHhKWG0zUFRoNWdtZFdDQXlWK3FoRENZMHRCemlqcm5saXhF?=
 =?utf-8?B?K1J3MXF4bUJUdXZKemtCeW82M0p2ellaWUtNQmpRWkNWYVVRWHYzd1dGTUdi?=
 =?utf-8?B?T0ZKMXF5Y2dibHBFejRsbVJvRjZDdkdqNlpGeDZRdzlRd0JwUWZkL0lOeHRp?=
 =?utf-8?B?c2tmSnVDamZCUzc5U082cGFVQmliMlFMbWM3Qzl4MXBoWldGQ3IvSng1RUpL?=
 =?utf-8?B?MGoyU2ZKeEtnWE8wZ2ZRZjdlL3ZxNy8wZkhDeGgycnBvendobngvOUpYWEkw?=
 =?utf-8?B?dGpsSjFuZiswYzJsNEtHTWFSSGtJMDcrSjhieUNsc3BkUHFEeUlEUDdTZmYw?=
 =?utf-8?B?RzU1QVF5N3lhK25VbEtCM0R5U2ZKQTk1K3V4ZnpWR3dncU1vNnV1M0N2K0JY?=
 =?utf-8?B?WUtPUGpobGpjYkFXZEhreWR0RGhWTHZHclhCU0IzQWxicEpDR2luV0t6MC9q?=
 =?utf-8?B?QTR3aHFIUy9lTEhHWmY2WmZpeHVvd3BldzYvQlpOZGNqbURwb05JNnEyT0Rk?=
 =?utf-8?B?a241c0VYTnp6UG53STVHakxYb2ZpcC9mTXFUWGZES2JZaG5EUmJQZXp2RkI0?=
 =?utf-8?B?TjUwaDZaRTliQkJEVythUHd5UGxlTnBuMnBGMnRrbG0wNWFjL0JKWlNmaUM5?=
 =?utf-8?B?Mk94ZUNTdnB5WTExNWdaMzVHM3FFV0ZYMGZGbnJNdmxiOHUzUXU3VWxCWW5F?=
 =?utf-8?B?ZWYyZGFwNTVpUm5FeTF5NHNiak9vMjdpT2J5RGNTWS82WDcxK1ROSVI0RVM0?=
 =?utf-8?B?NERjelZaM0xQSFRhVDlzamJidHArS2tlejRmN0hxQVc3blJNNXVBSlV3TDRt?=
 =?utf-8?B?cFlvejcvSXlXVHZySDBtZmFlalJsVWVGM3lsa2JReEw1ZTNZa2licXhWMUFN?=
 =?utf-8?B?Qmc0Y2hSejYySGpwbmoyd3AvZllMYUxNaUxGQjBaaW05Y1BseUd2bTd1T1RX?=
 =?utf-8?B?QWticFFsbEFtcE40R0tneGN3NjNBT0dFUDc0WFhBT0dWMWJ4RmFMVkFEZmM4?=
 =?utf-8?B?QkcrWEx1WEpNZGpMVzVzMFNiU0NQNE1CL3cwdFpiMzVaUDlhcHhFZHkrZE1G?=
 =?utf-8?B?S1B3cVVpekMzTjNKS3pPVDlyY0lBK2Zud2ZiVmFHM2w3R3RWRVRrcVNraDV3?=
 =?utf-8?B?VXZHNmNSUXRNZGZCeHNVdXBhRFBSeUMyNUkvaEVpQnJRcDhqL25wTkppYXRH?=
 =?utf-8?B?SDlXNU5vMUZYOEE1NjM5VzloK1BNQ29rSTEzNjZBazVmM3lnUm11NURSS1lE?=
 =?utf-8?B?eHhoV3RGZjBrN01jZW5rNGNXUGQwMG1nMEVBQUxqNFFzSldpeWxNOHJQb2FR?=
 =?utf-8?B?TmExdzE5aitWYm1IQStpM1BETG9SSkhBTzVjV3crT29UaXdNOXpzNWdjNE1S?=
 =?utf-8?B?QWpVR3lHRU52SERPMTl1aVR6VENJQno0dnc2NWR3VUYrK3ZMN1hjN3JGVE95?=
 =?utf-8?B?bjhNckgzL1VpQWRvOW9UMzU5cFhkeUdQNFpTbXh3dis0TmEwNnlubm0rRDdX?=
 =?utf-8?B?b2VEVzArWTlDbkhLT1NnRk91MjNieXpYYWMvcDVXaU0vVThLVzNzdzNzY1Rn?=
 =?utf-8?B?Qjd6dHo5bjVtcUYrNEFzcDNPVERlMk9JcmphUzluOGdPZGZ6Vzl0Vzh6dGNH?=
 =?utf-8?B?b204UHlEbGJzWWltdnhKOFdDWEkwRXI1RnAxMGkyNWdUYXk4bE1CU0xkWFA3?=
 =?utf-8?B?dHphdzZYaVFhenpQeDhxbjl2M2t4M2MvbGk4RUlqbkpXWEtaZUEwU3ByQjZn?=
 =?utf-8?Q?ZodE8stFYIlIgtiVo5/Z7aT9yUX+v/t7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR0601MB4180.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmI5VWlDdThrZ000SzY2TVZYdlFNNGkvQjBoNWZUZEw3TEx0OW1BVXZEZkw4?=
 =?utf-8?B?N2c5S3c5L044bnI0TnhNZk1JemVlWGs2TFlQQ0s5b0RidzZlcVpDZ2Q4TUxS?=
 =?utf-8?B?QUVYNVhySU83WTJkWjhkTWZXRzJUZFFzK3ZyclVYN1pWcFJMK2dxQVk5SzF6?=
 =?utf-8?B?T0oybDZ2ODJxL3RJOVR1dUZEYzZhUEltVWtJcVY3dFNaYmJiNHEzeHNTRHV4?=
 =?utf-8?B?N0dHenNRelU1dHdtVHBmRGoxanVmRFh4azhTTHdNTU1PQTEzaEZtTnBVTzhW?=
 =?utf-8?B?azJjQTdsZlFia1dXSjgwQVdaZElxT1NwOVNtbFJEWmhuQnVUa0FvNUo5WEdF?=
 =?utf-8?B?VmlmeVVjMlE1WkY0WFRaK1BONTh2UnhXNXVsZHl1NEF4SkJ5VzlaT0xoSE1a?=
 =?utf-8?B?VG5ZcVkxRmdkTy9zNlhxQUljU0RlUmt1Znd3QkhxcFFTRjJXL01yWjlPZStk?=
 =?utf-8?B?VFJaV1J3YURVVHEyZnhHemx4c0ovZmFwNjRDVytGekpTRUpNTG5UZTg5N0NT?=
 =?utf-8?B?SFlWTmIwZERQdnJhckpoQzIxVkZ5S2gvYlIxNVZ2Q0tRSGJTZm5rZFNyY2lo?=
 =?utf-8?B?RmVVSjREV29mR09udFBOWktaZW91UHFwRVVQZTlkN2JzelRhNUl6RlpMM1lC?=
 =?utf-8?B?T3JWUTlPL2JOelVLRUpjd0VXN0hXOVhMNXlKVUF2OWJrdEU5akF2a3h2K0gx?=
 =?utf-8?B?TThSQ2NlcXhXUGNsL01PZjNnZ3Qwd3R4elVnV2Z5cEk1emZwT0VRVU5IKzhY?=
 =?utf-8?B?TDNDTDdncmdMUk1uWDBRdWVzajNZKzlSNmZpaVcrR25pR2krMlRKMzJyMTNx?=
 =?utf-8?B?T0NhYjNKWUZLNnROY2JNVjFHMGtUK0pEUmZCRVBwTldSNGMwYjAyeFRlL0pJ?=
 =?utf-8?B?cmhnM3NrWHY2bWRxeUtIRWdoUmk1c2RxSWppeEN5ZkdIWlY4SDhTNjl1RC9i?=
 =?utf-8?B?WFhnZzM1RmpqeVg1amF0emlIWmVOZ013Nk01bmZtc0VwOENOTU5ncDBUSzJp?=
 =?utf-8?B?T2NuSVNWcnZyMXdRblRPeGYwd3hVa29UalZOQ2ZOenJWcEl5SzUwUUM2SmJx?=
 =?utf-8?B?S0JJTkxMclJUblJjOE9Bc0ZhUlE3VFVEbG1PelJEd0ZIbFBvVXdsT093NE9J?=
 =?utf-8?B?VmMwVGRrd2RSbkR0OGFnSnc5NXUwZERURFpwcTBialJnSkxDaVJhS1N5Mno4?=
 =?utf-8?B?TEwzMnpqdHJBQWZ6T3RkK3BMcmpzck9sTTZmSmRGZkNaVTlvQk5TR2FrYWtk?=
 =?utf-8?B?OERoQ3JmemtIQWdFQ0pTMEdTN1ZOelVZVE1mSVpHN2lqZnZyRFo5bEZ0dUk1?=
 =?utf-8?B?UmZFeS9ac0RJQVVDc0ZuclBTSWNodjREQzJBU2xkeUhPN3E3ZTd4bVplUnhk?=
 =?utf-8?B?cUlUaGJJRGdsaXhJVkp5SHdHYU9BcU50MHJjbFlYUnVXRUFBZWdLV2V1Z1B3?=
 =?utf-8?B?WUduK2kzWUtOdEZ3YkV6Q3pVcFZmQXZBcjgrZStQZmduZjRFUWp1dktyYStH?=
 =?utf-8?B?Zk1MRGxXTkk1VDFSSzRmMUw2V3dkUkVCVFV4cW1YbFhzZXgvOHRSNkZseW9z?=
 =?utf-8?B?M2t5NXFmR2RaaG5MNU5vTS9sQTBhZkRiYjlzQ1lSVzN6MGNMQVVudHNMUDMz?=
 =?utf-8?B?T1JKZjFvUy9JNXBJeTJpalFNZmVhOG5CZi8xaU1ncjhYZzN1ZEtGL2tZa0ZH?=
 =?utf-8?B?czM1bDNPUUhoY2tZWFd0MU53Y3dhVWRFMlBQNmxROVBTYi9SaGtqeUd5RFZY?=
 =?utf-8?B?Z0FNcDFoWXFBcElLZ1VWRUpxK2dsd2FzL2lCU3pCZzAzOTc4Tkd2VjdYak9k?=
 =?utf-8?B?VjVUYUJvdEpsRzgvZVVtSEFlRjBKTCtqL3VhR2NMK3ZJT0ZHMERZa0NLbkVa?=
 =?utf-8?B?Z05Rc3JqMzJaV2EwTDZtc2E2S0U0MHFKVnZEbS9SMHd3bWE2dTMvZGJzTzZs?=
 =?utf-8?B?b2dsVm1WbGs0bUprMlBFUUluQUNRVEh6NEkrSzFXek5zdXhXTHBxRjFXblJr?=
 =?utf-8?B?Rmh2amtyZm5FWDUxdUczVFZsNFRHR1hpOFhOL3hIMm1KSzJFRzBNNTAyT0Js?=
 =?utf-8?B?dldWRENpUEJaVFA3SDA2QkxQa0o3N2JqejRFSll2MVpSekNoYWQxNXpmYU1T?=
 =?utf-8?B?endyQlVtaXBTTDF2OHZLazBhcHJqelNLYkpEZ3FFdFNMWDNvaXN3Q1JyaWZx?=
 =?utf-8?B?dVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4180.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbafd334-1360-4511-8d6b-08dd26136552
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2024 01:11:30.2180 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QdRQPdmBOCfttCO491JEY6OrjOKe4fNn/+6RvdYpJe4s3amUOcO0WD2qzOu/jkcULTgUy6zDrNTeAHwsPClCHYIQMs/VT+oUE9RWBzJx2IM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6605
Received-SPF: pass client-ip=2a01:111:f403:c400::;
 envelope-from=steven_lee@aspeedtech.com;
 helo=HK2PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

SGkgUGhpbGlwcGUsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhp
bGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNk
YXksIERlY2VtYmVyIDI1LCAyMDI0IDc6MjggUE0NCj4gVG86IFN0ZXZlbiBMZWUgPHN0ZXZlbl9s
ZWVAYXNwZWVkdGVjaC5jb20+OyBDw6lkcmljIExlIEdvYXRlcg0KPiA8Y2xnQGthb2Qub3JnPjsg
UGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgVHJveSBMZWUNCj4gPGxl
ZXRyb3lAZ21haWwuY29tPjsgSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBB
bmRyZXcNCj4gSmVmZmVyeSA8YW5kcmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFu
bGV5IDxqb2VsQGptcy5pZC5hdT47IG9wZW4NCj4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1A
bm9uZ251Lm9yZz47IG9wZW4gbGlzdDpBbGwgcGF0Y2hlcyBDQyBoZXJlDQo+IDxxZW11LWRldmVs
QG5vbmdudS5vcmc+DQo+IENjOiBUcm95IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+OyBZ
dW5saW4gVGFuZw0KPiA8eXVubGluLnRhbmdAYXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggMS81XSBhc3BlZWQ6IE1ha2Ugc2RoY2lfYXR0YWNoX2RyaXZlIGFuZA0KPiB3cml0
ZV9ib290X3JvbSBwdWJsaWMNCj4gDQo+IE9uIDI1LzEyLzI0IDAzOjAzLCBTdGV2ZW4gTGVlIHZp
YSB3cm90ZToNCj4gPiBzZGhjaV9hdHRhY2hfZHJpdmUgYW5kIHdyaXRlX2Jvb3Rfcm9tIGZ1bmN0
aW9ucyBtYXkgYmUgdXNlZCBieSB0aGUNCj4gPiBhc3BlZWQgbWFjaGluZSBzdXBwb3J0aW5nIGNv
LXByb2Nlc3NvcnMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTdGV2ZW4gTGVlIDxzdGV2ZW5f
bGVlQGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICAgaHcvYXJtL2FzcGVlZC5jICAgICAg
ICAgfCA0ICsrLS0NCj4gPiAgIGluY2x1ZGUvaHcvYXJtL2FzcGVlZC5oIHwgNiArKysrKysNCj4g
PiAgIDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiAN
Cj4gDQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvYXJtL2FzcGVlZC5oIGIvaW5jbHVkZS9o
dy9hcm0vYXNwZWVkLmggaW5kZXgNCj4gPiBjYmVhY2IyMTRjLi5iYmEyMjRjMzU3IDEwMDY0NA0K
PiA+IC0tLSBhL2luY2x1ZGUvaHcvYXJtL2FzcGVlZC5oDQo+ID4gKysrIGIvaW5jbHVkZS9ody9h
cm0vYXNwZWVkLmgNCj4gPiBAQCAtMTAsNyArMTAsOSBAQA0KPiA+ICAgI2RlZmluZSBBUk1fQVNQ
RUVEX0gNCj4gPg0KPiA+ICAgI2luY2x1ZGUgImh3L2JvYXJkcy5oIg0KPiA+ICsjaW5jbHVkZSAi
aHcvc2Qvc2RoY2kuaCINCj4gPiAgICNpbmNsdWRlICJxb20vb2JqZWN0LmgiDQo+ID4gKyNpbmNs
dWRlICJzeXN0ZW0vYmxvY2tkZXYuaCINCj4gPg0KPiA+ICAgdHlwZWRlZiBzdHJ1Y3QgQXNwZWVk
TWFjaGluZVN0YXRlIEFzcGVlZE1hY2hpbmVTdGF0ZTsNCj4gPg0KPiA+IEBAIC00MSw1ICs0Myw5
IEBAIHN0cnVjdCBBc3BlZWRNYWNoaW5lQ2xhc3Mgew0KPiA+ICAgICAgIHVpbnQzMl90IHVhcnRf
ZGVmYXVsdDsNCj4gPiAgIH07DQo+ID4NCj4gPiArdm9pZCBzZGhjaV9hdHRhY2hfZHJpdmUoU0RI
Q0lTdGF0ZSAqc2RoY2ksIERyaXZlSW5mbyAqZGluZm8sIGJvb2wgZW1tYywNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgYm9vdF9lbW1jKTsNCj4gDQo+IEluZGVudCBp
cyBvZmYuDQo+IA0KPiA+ICt2b2lkIHdyaXRlX2Jvb3Rfcm9tKEJsb2NrQmFja2VuZCAqYmxrLCBo
d2FkZHIgYWRkciwgc2l6ZV90IHJvbV9zaXplLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICBFcnJvciAqKmVycnApOw0KPiANCj4gRGl0dG8uDQo+IA0KPiBQcmUtZXhpc3RpbmcsIGZ1
bmN0aW9ucyB0YWtpbmcgRXJyb3IgYXMgbGFzdCBhcmd1bWVudCBzaG91bGQgcmV0dXJuIGEgYm9v
bGVhbg0KPiBpbmRpY2F0aW5nIHdoZXRoZXIgZXJyb3Igb2NjdXJyZWQgb3Igbm90Lg0KPiANCj4g
Rml4aW5nIGluZGVudGF0aW9uOg0KDQpUaGFua3MgZm9yIHJldmlldy4NCldpbGwgZml4IGl0Lg0K
DQpTdGV2ZW4NCg0KPiBSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxt
ZEBsaW5hcm8ub3JnPg0KDQo=

