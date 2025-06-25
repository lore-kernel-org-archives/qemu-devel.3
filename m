Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF712C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 07:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUKCk-0004kt-PJ; Wed, 25 Jun 2025 03:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uUKCK-0004hY-Pj; Wed, 25 Jun 2025 03:05:39 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uUKCE-0004t2-Qr; Wed, 25 Jun 2025 03:05:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MlL3kXNAZ9tawixDkywx4NxlmIjN1C9yrr6DjewiRc9fxKfySqaWopCoa2dHojBwgyBISJDm+X84a9bUNImBYVlP7AAEUcSytV21QjDR9GQ9soZPh5HXeE14izXHotML1S4Pyn7Jb9coyHhglRqXyFAq/dOmv63RJW67WLDk8G9pSPqKxgmvNQRWYX9isWcKALonY6Ce2TFAMt5i/7cKOPKB+SxB6PC9XHo7cCvsrKfOJxn9vBXDu2K/wTAz60bo1GC4UYIsqbefo5G7VzdPf7eo0gCPuBBsXvymuFQO2s6qOrWj41FiEg+BPyW+G/Pr3mHH4NMnJdr72MJuEWzt8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCv39eWEFw/3V5z1AH3NMcYRWlpyGhLn9zJcJIkrU0g=;
 b=IOtzA/yBMmD23EUjyPsCpze+mBTrfWQXes7Pm+BxP80BnKUU54UgDX+zLr3aAL/vht18kykQ0WUok7p9o6udMRlCsu/hq3PuptBxVOEu31IjDd4PKCX++zx02sowGveHksuhpo2linKSJQYsDdEFtvPS7k8LJLpotiV7TrCNQme5aiTsjoL9hr/C2K3JCvZNaRXWN43Up0jk++5W5lxmf8+OrCLjlvjeMZd9nZCi9FCsXxP7A0EyCRMK10CrMcunJMTnbMytlqWnZ+BVw+90neTNz+rbE9HbZHZu/gskDRRxHQT2k6twwerGgor+YwGgqFVtWE8fNwLQ0hZj+FINUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCv39eWEFw/3V5z1AH3NMcYRWlpyGhLn9zJcJIkrU0g=;
 b=a+G5YNOLgh02661Nagog21L+VFkcKyFp0xz4ND8Ts8PcrzNaUgrXYBMG12t59YFrl0maXn6rlSDgC/+eyQGwotc3UBKiCkF6J134yvruNtK0dS+oc4iKDyB+BrKgD56NED7jymhvey6EaE3HdOwzcwjkb8p8JelA7w1pjqaFjzAUMkPVzOJANzo810SJHrIz2utbajifsJXwqsGdQSlttkaCWmkARb4N4cAXw8PwUI/KORHAyg+6NcJih06GsKZcGRmdjuTVeNy581WBx6RhUlXR+B8BAt/pqtZYGg6qoQNBmP8Qn4bZeUIWaD5HQu1TdYGzY5IgKL5BxYpyv83cTQ==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by JH0PR06MB6341.apcprd06.prod.outlook.com (2603:1096:990:15::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 07:05:17 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%7]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 07:05:17 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [RFC v6 1/3] hw/misc/aspeed_otp: Add ASPEED OTP memory device
 model
Thread-Topic: [RFC v6 1/3] hw/misc/aspeed_otp: Add ASPEED OTP memory device
 model
Thread-Index: AQHb5K7TOApg+TuBvUGRhcDupkjJHLQR2OUAgAFm9eCAACWFgIAAC95A
Date: Wed, 25 Jun 2025 07:05:16 +0000
Message-ID: <SI6PR06MB763173450FFE847F1726E304F77BA@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20250624022219.3704712-1-kane_chen@aspeedtech.com>
 <20250624022219.3704712-2-kane_chen@aspeedtech.com>
 <601cae7f-8203-4068-a7ec-7cd3e11519d8@kaod.org>
 <SI6PR06MB76316F7B660439BFEB5698FDF77BA@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <cacdd727-c1e6-4c57-8266-6b369579de72@kaod.org>
In-Reply-To: <cacdd727-c1e6-4c57-8266-6b369579de72@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|JH0PR06MB6341:EE_
x-ms-office365-filtering-correlation-id: 59bea82d-bbe7-4bfd-b78f-08ddb3b6a3cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SHJIclZqQlVQRFlTMVRES1JqYkRxUEdGN3JWZk9KWFRBNmtxLzFuRk5Rd2VM?=
 =?utf-8?B?ZGRhMUVlZ2ZJUjZSemVnUnVJNUIzb0xQcERwU05aeVU4NG5rcWUvVGEzWFov?=
 =?utf-8?B?cFcwcVpxcEVYZnhpYnVBSEJvSVBNTXlEakVCNkNTNysraDZKZU8yeDZrN2Ix?=
 =?utf-8?B?UzNYKzljbTFkZktUSkxKVHBxRlhuU3hTTUNldEoya1MwbDR3bGNLODBSNWhu?=
 =?utf-8?B?WXdvazRuMVpDMVFWckNkZi90TkdKczRJcE4zQUdhdmlFYnhKMWZ1dHFKUDVl?=
 =?utf-8?B?eDgrUWoxbTF6UTBTdTdHSk5VTW9rVWVvaE1HY2RSRXc2NUovSkpyamtqTDRP?=
 =?utf-8?B?QzhDQ21zckwyVmdxaHZlMUdJWXRSOXI2ZG9QaE1TNkt0ZEUrNmFLcHpoY3Nr?=
 =?utf-8?B?NG1OZHBMKzVBbDZGaW1aVGVQM2xHTmduZ3FIbi94L2I2UlpleFBwRG1HRWMz?=
 =?utf-8?B?eDFGNGtraFpSQVZscVNmZ29majBydGFIaWRTOEUwUGZZOGtGT3IrbmNEcjRZ?=
 =?utf-8?B?VDltVzEvTTBiTUdWb0hGTTZSN00yQnJRRG83aVNmRXMrZVJaMHF1MWxKUVZ2?=
 =?utf-8?B?cFFMSEo1SzdLWnVUVURoSGRpSzAxYUU4eUdxRmpRSEVtblUwblhjUThoSUsz?=
 =?utf-8?B?R1FXeWFnaXpRWHBndWg0RzgwV2s5aVRVWEZLamM2Rkw3ZjlWdEEzOEF1WTBW?=
 =?utf-8?B?dGs0akszZnJyUUx6d1hLZC9tTlNZSFZxc1Q2RDVjNTUwMEZnV2ozQTBXYkw1?=
 =?utf-8?B?UFdPcTgwN2JJTHFKRW1TU1NRc2pnVTFxdENWRnAxK0RmMnNMNWg1WXVFdDZP?=
 =?utf-8?B?MndnOWhidUw1eWtJOXYvellNNTh1K29admFjWmM4QjhObXI5WkphQkJwMTkw?=
 =?utf-8?B?ZkE0cktSRzJsNWlST21rMHF4R2VEbm5rQ0djWUFHVXU2V3dTRzZuM0gxM1Ft?=
 =?utf-8?B?RWdIcHVvK3h0NCsrSmx2cFQxN2hBZ3NubVJWdHlEL3NDUHRuWDZuL1dBazdk?=
 =?utf-8?B?K2Y4ZEdmdUlWSnJsN3V5dE9EQ0kzakUyU3FDd1UyU0ZBYVY4dGdVK0ZvN1d2?=
 =?utf-8?B?c2tMc0Z4dlVNRk1RUzUxYmpOaWJxanhIVFkzZFNMRS9EUlU4RmFIVzB3QVRi?=
 =?utf-8?B?STZpM0dBbDhoWk5qeXZGQmtQNHliMVQvNDRsZG9WclVjWHBPTjZTT2llQXNw?=
 =?utf-8?B?Z2NLNnFWRWNQRTh6bXJYSDIxaUZzYm9NOHV2RE94czk5VkZlL1F2Wjd1amRy?=
 =?utf-8?B?YjFES1djVGIwcENROUpHQXNEYzJodWdLemlhM2I2TnkrenRreEc0ekMvWGZ4?=
 =?utf-8?B?UXFQRUJqMzNERHlqRC9aYldRRTJ2MWdyYjBrazZodmVHeVQ1WmZWK3FXWC9U?=
 =?utf-8?B?TnM1UkVkRDNmby9nS3J0dGNIcTFucUtvcjRKT0dFdnNVTVBrc3loQURwUzB5?=
 =?utf-8?B?RmRJWVo0MTV4VHkrdnBJZ3NpcDhaNElvZkJhK1Zqb1JZSGFJZlhrRnBxTlBp?=
 =?utf-8?B?dVVzME4xeFMySURwWm0rUlk4bm8wZnpZSTZDNTllNWNWeC94MXdDTkNBSjR1?=
 =?utf-8?B?WmhScDRnL3N1Nm1ZRzVWQlBkK2trYUtmOGNMekd2M3gzVnpnU0VPOFFaZC9n?=
 =?utf-8?B?Q3pIZkVFUnBJVEZvUEdja2tvTW5LbmQyYVRPL2RmcVZkZDZIR0pFVDNWa0Nh?=
 =?utf-8?B?L2hpa0JhdHBCM1VNVzVpMXdTQXl2UnBpN2hTbWcveGJSb3hGZjY1dXVSQzl6?=
 =?utf-8?B?UUhycDhSRDNVV29jS3A5dUZSRElMVitHbitxL2cxemZtT2cwTUpBZGtEM1ZE?=
 =?utf-8?B?bFNUcVdOVnlJV3pubXluaDdGVUlvYmVtOFpRbWZ1d1laQlpzMytmR3FSL0hZ?=
 =?utf-8?B?SGloSm9LdktZNFFISWRSYm80Rk9UZTgya1pmT2x0N2pkc0c3RlFGNXg4TnAv?=
 =?utf-8?B?NmVqSXkxRnk3L3FtTmNFeW9iOXpyTDdEbzYvL1pPdTBmK0tjbC81b1dwWkZu?=
 =?utf-8?Q?hvJcsnDb0ik/eOVUFpI0J0AAMTGMwM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2pBdkwvRkM1N0xBOU94N2VCd2dkSjVxYzBzeHJxOEVtMDJXMzdxTGI2S1Zn?=
 =?utf-8?B?dUlsbDlLZHpJRlRMRTR1Mnp4Y0JaR2RQRXpicElNRG9tUVR3RUZTTFRBVUpZ?=
 =?utf-8?B?WjBmL0U0c0FZanh5ajFQK1ZNU0FqU0VxbFkwNUpCZ05seUcrdkU5aDhwM1hQ?=
 =?utf-8?B?TjFEcEx5dnY2SFdiczZTd0UzamlHTjE2Mm1EdnNsWGdXL01pbFg4cWFvTUJF?=
 =?utf-8?B?U0tQQ21WSDZXUW5Tclp2ZmhzZisyUkIrZi9kTXY0cDJCU1g3c0c5MWNKa3JN?=
 =?utf-8?B?L1U5U1kyNTJLaG96RnBGWHh1dHgrSU4rdFJMclk2dzROWXhEM2IxWXl6Wkpu?=
 =?utf-8?B?R3FCVlhRYkFaeVlQdFpidGlYazU5bEZrVFp0LzNyNmUzMG15ZlJMMHpkYXht?=
 =?utf-8?B?cGFFaElGbWNjZ0hRUVdia0kzQlI0QUpKR3ZSZ2MrZTV3RnIxUnRlaXI5VFZQ?=
 =?utf-8?B?aEJqTE9HT1cwdGp4VWloZDVNZDRNRmU1a3IrLzdxV2xsc1BYc0x5QmpTY2FT?=
 =?utf-8?B?VmNqekwvVFlqWXNTTDA3V3lSZjdzWDdNQzVMV2JQcC9pR1I4N29pSDdmWGNL?=
 =?utf-8?B?eFQ2K0l6VHJKay93ZzFnVXFzR08wa2RFcld0U25BNVl5WThJVGZldGFRV2ZT?=
 =?utf-8?B?Qi9Zc2JTL2ViYURDWGFYTlRTaFVDNlExMTc0WklzVGRlL3VOMXY0MDE3QTBF?=
 =?utf-8?B?dU1vZjhrbjE4eE9wSnQwZjNHZ3hwTER1czdqTVVFWmM4ckRPdDA0dUM5RUQx?=
 =?utf-8?B?eDAwVG9lQ2hoelBhZXRpN0lXcWFqUlZqSnNDOWdIWHdTWUNRMTRMNHhka2VW?=
 =?utf-8?B?cEZ3Y2JheldWQjh6SVRTV0ZtWGxiUVZiNE5MM0hKWXYvMk5ieHA4RlpUQjRa?=
 =?utf-8?B?R0xXd2VrRTB1OG83RXUyMUIxN3c4OStEejY5NVVCd09PVllTYmc0bE9Dd3VV?=
 =?utf-8?B?OVUzQ1hPdDJZK0t2ell0VG5BRWpuVGYzYmpSY0dVWlVDaitySThCU0VINkln?=
 =?utf-8?B?RnZIckp0OUNreGh2SlMvWU5YVzhKelh0VklWSG9jZU8rNWdQaEhXZjZ2VHdw?=
 =?utf-8?B?U0hCcVFpVzlwaTdPbktyaEtyM2J4WWJPdGlGSzlxSFdKNE42WW5tREJQQlo1?=
 =?utf-8?B?ZnJJUkh6LzQ4WHNNZUtWYUhwazJZczJ3d1JIN2JaSVBzSkZhRy9uQ3VhUlhE?=
 =?utf-8?B?R2Iwb2dqd1M2Z2tqUWI1VUhVNDBheHdwUWxXbU1ZdTA1SFpOZFVaWnlzaG5l?=
 =?utf-8?B?T0NGc0E1YUR1WTdhbUp3VCtLSmN6L3lpS3pMQ3pqTE1nbXUvL3l1amJOaDRS?=
 =?utf-8?B?N2RFczlUUUFVN1RTRWNZOU1CMTVkS1VOVDhyZWZOSTlZSlZUY2FqdWl1T2M2?=
 =?utf-8?B?SW9WTzhnUEtpMkU5R3JaT1FBZ1l3QlVRRFROTktMVDdmWSs5eXA5UGhyb0FN?=
 =?utf-8?B?ZW1oUE54M1J2RlkxY0F6OEFVWEJ6czZObUoxelBacDRtQUVOb3h0SFUvM0k4?=
 =?utf-8?B?cnRGak5sNDU5dzhyTEVqekVGK2loZ0VVVmRyd282bmVFNnpmaHlZaXh0UDl2?=
 =?utf-8?B?dlF1U3owSmtvQUNScXY2cS9sVFZPRnBxdHpNaTh0WWdXMmZIOUsvOGswOVZC?=
 =?utf-8?B?cnlHTC9Qb3g1RGhwaGtYWk1kdHFtY2wzbkUzMGx0VUJEYXZRYlJ5S2VnWFRn?=
 =?utf-8?B?U1o4SjFvaUNsUjEwTUpiUE42WHhNM2Y4MFYxM3pIUlo1ek9zZmZVZUtiYTZQ?=
 =?utf-8?B?T3NDa1BzY1IrRlZmcUwwUGZpb3k0SHQwL1pIaStzdnlzc0xMejB6c1g2WFNy?=
 =?utf-8?B?ZnRkYkxla2hNbWt0UHpaVkxiSXp4WnV2UVFMaWR1U0NvSHNhdG1KQzFQa0N5?=
 =?utf-8?B?UDlSY254UmF2VW9VOEVOMTNTNHFCd2paR1RMYk16TWVzOTlZY01YV3RTWEF6?=
 =?utf-8?B?RnhUNVVMYjV1MFlPQkx2WFFIQWdkZnNvR0Z3cHYremVqL1htak9tSXBITkV5?=
 =?utf-8?B?azJzMFFGcktIOUlaK1FWVGZkbnJFdFBWRW04MFpONWdpajcrdkFicmJ0eTE2?=
 =?utf-8?B?bFZVUzhETHB3Sk1NcThiK1BLTE11TlI2eGNaOE44ZTB2TTBTenQwTWEzUGlo?=
 =?utf-8?Q?I89jWrg5nUlERYsQsqTLP/tRn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59bea82d-bbe7-4bfd-b78f-08ddb3b6a3cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 07:05:16.9958 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YtV527v2tLhnW3Twe0RGjav0l7MUF1hAjBtb5YrdiyNqehy6N0bC0G1s5pMwkUs/XiljOvje0o4GXCYeUZonA/t09AHfFJ1AHDDyEy4vehA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6341
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=kane_chen@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYywNCg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KDQpJIGhhdmUgb25lIG1v
cmUgcXVlc3Rpb24gcmVnYXJkaW5nIHRoZSB1c2Ugb2YgdGhlICJSRkMiIHRhZy4gSW5pdGlhbGx5
LCBJIG1hcmtlZCB0aGUgc2VyaWVzIGFzICJSRkMiIHRvIGdhdGhlciBmZWVkYmFjayBvbiB0aGUg
T1RQIG1lbW9yeSBhbmQgU0JDIGluaXRpYWxpemF0aW9uIGRlc2lnbi4gTm93IHRoYXQgd2UncmUg
bW92aW5nIGZvcndhcmQgd2l0aCBtb3JlIGNvbmNyZXRlIGNvZGUgcmV2aWV3LCBJJ20gd29uZGVy
aW5nIHdoZXRoZXIgSSBzaG91bGQgc3RpbGwgdXNlIHRoZSAiUkZDIiB0YWcgZm9yIHRoZSBuZXh0
IHZlcnNpb24gb2YgdGhlIHBhdGNoLg0KDQpXb3VsZCB5b3UgcmVjb21tZW5kIGtlZXBpbmcgdGhl
ICJSRkMiIHRhZywgb3IgaXMgaXQgYXBwcm9wcmlhdGUgdG8gZHJvcCBpdCBhdCB0aGlzIHBvaW50
Pw0KDQpCZXN0IFJlZ2FyZHMsDQpLYW5lDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+DQo+IFNlbnQ6IFdlZG5lc2Rh
eSwgSnVuZSAyNSwgMjAyNSAyOjA3IFBNDQo+IFRvOiBLYW5lIENoZW4gPGthbmVfY2hlbkBhc3Bl
ZWR0ZWNoLmNvbT47IFBldGVyIE1heWRlbGwNCj4gPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47
IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5jb20+OyBUcm95DQo+IExlZSA8bGVl
dHJveUBnbWFpbC5jb20+OyBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47IEFu
ZHJldw0KPiBKZWZmZXJ5IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+OyBKb2VsIFN0YW5s
ZXkgPGpvZWxAam1zLmlkLmF1PjsNCj4gb3BlbiBsaXN0OkFTUEVFRCBCTUNzIDxxZW11LWFybUBu
b25nbnUub3JnPjsgb3BlbiBsaXN0OkFsbCBwYXRjaGVzIENDDQo+IGhlcmUgPHFlbXUtZGV2ZWxA
bm9uZ251Lm9yZz4NCj4gQ2M6IFRyb3kgTGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNoLmNvbT4NCj4g
U3ViamVjdDogUmU6IFtSRkMgdjYgMS8zXSBody9taXNjL2FzcGVlZF9vdHA6IEFkZCBBU1BFRUQg
T1RQIG1lbW9yeQ0KPiBkZXZpY2UgbW9kZWwNCj4gDQo+IEhlbGxvIEthbmUsDQo+IA0KPiBPbiA2
LzI1LzI1IDA3OjU5LCBLYW5lIENoZW4gd3JvdGU6DQo+ID4gSGkgQ8OpZHJpYywNCj4gPg0KPiA+
IFRoYW5rcyBmb3IgeW91ciByZXZpZXcgYW5kIGhlbHBmdWwgY29tbWVudHMuIEkgd2lsbCB1cGRh
dGUgdGhlIGNvZGUNCj4gYWNjb3JkaW5nbHkuDQo+ID4NCj4gPiBJIGFsc28gaGF2ZSBhIHF1ZXN0
aW9uIHJlZ2FyZGluZyB0aGUgT1RQIG1lbW9yeSBjb250ZW50DQo+ID4gaW5pdGlhbGl6YXRpb24u
IFNpbmNlIHRoZSBPVFAgbWVtb3J5IG9ubHkgbmVlZHMgdG8gYmUgaW5pdGlhbGl6ZWQNCj4gPiBv
bmNlLCBJIHBsYW4gdG8gbW92ZSB0aGUgaW5pdGlhbGl6YXRpb24gY29kZSBpbnRvIHRoZSByZXNl
dCBmdW5jdGlvbg0KPiANCj4gSXQncyBub3QgYSByZXNldCBmdW5jdGlvbiBzaW5jZSB0aGUgY29u
dGVudHMgcGVyc2lzdCBhY3Jvc3MgcmVzZXRzLg0KPiANCj4gPiBhbmQgdXNlIGEgZmxhZyB0byBl
bnN1cmUgaXQgcnVucyBvbmx5IG9uY2UuIFRoaXMgd2F5LCB0aGUgbWVtb3J5IGNvbnRlbnRzDQo+
IHdpbGwgYmUgcmV0YWluZWQgYWNyb3NzIGRldmljZSBvciBtYWNoaW5lIHJlc2V0cy4NCj4gDQo+
IEkgd291bGQga2VlcCB0aGUgY29udGVudHMgaW5pdGlhbGl6YXRpb24gaW4gdGhlIHJlYWxpemUg
cm91dGluZSwgc2FtZSBhcw0KPiBtMjVwODBfcmVhbGl6ZSgpIGRvZXMgOg0KPiANCj4gICAgICAg
ICAgcy0+c3RvcmFnZSA9IGJsa19ibG9ja2FsaWduKE5VTEwsIHMtPnNpemUpOw0KPiAgICAgICAg
ICBtZW1zZXQocy0+c3RvcmFnZSwgMHhGRiwgcy0+c2l6ZSk7DQo+IA0KPiBUaGFua3MsDQo+IA0K
PiBDLg0KPiANCj4gDQo+IA0KPiA+DQo+ID4gUGxlYXNlIGxldCBtZSBrbm93IGlmIHlvdSBoYXZl
IGFueSBjb25jZXJucyBvciBzdWdnZXN0aW9ucyBhYm91dCB0aGlzDQo+IGFwcHJvYWNoLg0KPiA+
DQo+ID4gQmVzdCBSZWdhcmRzLA0KPiA+IEthbmUNCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gPj4gRnJvbTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0BrYW9kLm9yZz4NCj4gPj4g
U2VudDogVHVlc2RheSwgSnVuZSAyNCwgMjAyNSAyOjI4IFBNDQo+ID4+IFRvOiBLYW5lIENoZW4g
PGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT47IFBldGVyIE1heWRlbGwNCj4gPj4gPHBldGVyLm1h
eWRlbGxAbGluYXJvLm9yZz47IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5jb20+
Ow0KPiA+PiBUcm95IExlZSA8bGVldHJveUBnbWFpbC5jb20+OyBKYW1pbiBMaW4gPGphbWluX2xp
bkBhc3BlZWR0ZWNoLmNvbT47DQo+ID4+IEFuZHJldyBKZWZmZXJ5IDxhbmRyZXdAY29kZWNvbnN0
cnVjdC5jb20uYXU+OyBKb2VsIFN0YW5sZXkNCj4gPj4gPGpvZWxAam1zLmlkLmF1Pjsgb3BlbiBs
aXN0OkFTUEVFRCBCTUNzIDxxZW11LWFybUBub25nbnUub3JnPjsgb3Blbg0KPiA+PiBsaXN0OkFs
bCBwYXRjaGVzIENDIGhlcmUgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gPj4gQ2M6IFRyb3kg
TGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNoLmNvbT4NCj4gPj4gU3ViamVjdDogUmU6IFtSRkMgdjYg
MS8zXSBody9taXNjL2FzcGVlZF9vdHA6IEFkZCBBU1BFRUQgT1RQIG1lbW9yeQ0KPiA+PiBkZXZp
Y2UgbW9kZWwNCj4gPj4NCj4gPj4gT24gNi8yNC8yNSAwNDoyMiwgS2FuZSBDaGVuIHdyb3RlOg0K
PiA+Pj4gRnJvbTogS2FuZS1DaGVuLUFTIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+DQo+ID4+
Pg0KPiA+Pj4gSW50cm9kdWNlIGEgUUVNVSBkZXZpY2UgbW9kZWwgZm9yIEFTUEVFRCdzIE9uZS1U
aW1lIFByb2dyYW1tYWJsZQ0KPiA+PiAoT1RQKQ0KPiA+Pj4gbWVtb3J5Lg0KPiA+Pj4NCj4gPj4+
IFRoaXMgbW9kZWwgc2ltdWxhdGVzIGEgd29yZC1hZGRyZXNzYWJsZSBPVFAgcmVnaW9uIHVzZWQg
Zm9yIHNlY3VyZQ0KPiA+Pj4gZnVzZSBzdG9yYWdlLiBUaGUgT1RQIG1lbW9yeSBjYW4gb3BlcmF0
ZSB3aXRoIGFuIGludGVybmFsIG1lbW9yeQ0KPiA+Pj4gYnVmZmVyLg0KPiA+Pj4NCj4gPj4+IFRo
ZSBPVFAgbW9kZWwgcHJvdmlkZXMgYSBtZW1vcnktbGlrZSBpbnRlcmZhY2UgdGhyb3VnaCBhIGRl
ZGljYXRlZA0KPiA+Pj4gQWRkcmVzc1NwYWNlLCBhbGxvd2luZyBvdGhlciBkZXZpY2UgbW9kZWxz
IChlLmcuLCBTQkMpIHRvIGlzc3VlDQo+ID4+PiB0cmFuc2FjdGlvbnMgYXMgaWYgYWNjZXNzaW5n
IGEgbWVtb3J5LW1hcHBlZCByZWdpb24uDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogS2Fu
ZS1DaGVuLUFTIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+DQo+ID4+PiAtLS0NCj4gPj4+ICAg
IGh3L21pc2MvYXNwZWVkX290cG1lbS5jICAgICAgICAgfCA4NQ0KPiA+PiArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4gPj4+ICAgIGh3L21pc2MvbWVzb24uYnVpbGQgICAgICAg
ICAgICAgfCAgMSArDQo+ID4+PiAgICBpbmNsdWRlL2h3L21pc2MvYXNwZWVkX290cG1lbS5oIHwg
MzMgKysrKysrKysrKysrKw0KPiA+Pj4gICAgMyBmaWxlcyBjaGFuZ2VkLCAxMTkgaW5zZXJ0aW9u
cygrKQ0KPiA+Pj4gICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L21pc2MvYXNwZWVkX290cG1lbS5j
DQo+ID4+PiAgICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9ody9taXNjL2FzcGVlZF9vdHBt
ZW0uaA0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9ody9taXNjL2FzcGVlZF9vdHBtZW0uYyBi
L2h3L21pc2MvYXNwZWVkX290cG1lbS5jDQo+IG5ldw0KPiA+Pj4gZmlsZSBtb2RlIDEwMDY0NCBp
bmRleCAwMDAwMDAwMDAwLi5iMTNiODdmYWU4DQo+ID4+PiAtLS0gL2Rldi9udWxsDQo+ID4+PiAr
KysgYi9ody9taXNjL2FzcGVlZF9vdHBtZW0uYw0KPiA+Pj4gQEAgLTAsMCArMSw4NSBAQA0KPiA+
Pj4gKy8qDQo+ID4+PiArICogIEFTUEVFRCBPVFAgKE9uZS1UaW1lIFByb2dyYW1tYWJsZSkgbWVt
b3J5DQo+ID4+PiArICoNCj4gPj4+ICsgKiAgQ29weXJpZ2h0IChDKSAyMDI1IEFzcGVlZA0KPiA+
Pj4gKyAqDQo+ID4+PiArICogIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxh
dGVyICAqLw0KPiA+Pj4gKw0KPiA+Pj4gKyNpbmNsdWRlICJxZW11L29zZGVwLmgiDQo+ID4+PiAr
I2luY2x1ZGUgInFlbXUvbG9nLmgiDQo+ID4+PiArI2luY2x1ZGUgInFhcGkvZXJyb3IuaCINCj4g
Pj4+ICsjaW5jbHVkZSAidHJhY2UuaCINCj4gPj4+ICsjaW5jbHVkZSAic3lzdGVtL2Jsb2NrLWJh
Y2tlbmQtZ2xvYmFsLXN0YXRlLmgiDQo+ID4+PiArI2luY2x1ZGUgInN5c3RlbS9ibG9jay1iYWNr
ZW5kLWlvLmgiDQo+ID4+PiArI2luY2x1ZGUgImh3L21pc2MvYXNwZWVkX290cG1lbS5oIg0KPiA+
Pj4gKw0KPiA+Pj4gK3N0YXRpYyB1aW50NjRfdCBhc3BlZWRfb3RwbWVtX3JlYWQodm9pZCAqb3Bh
cXVlLCBod2FkZHIgb2Zmc2V0LA0KPiA+Pj4gK3Vuc2lnbmVkIHNpemUpIHsNCj4gPj4+ICsgICAg
QXNwZWVkT1RQTWVtU3RhdGUgKnMgPSBvcGFxdWU7DQo+ID4+PiArICAgIHVpbnQ2NF90IHZhbCA9
IDA7DQo+ID4+PiArDQo+ID4+PiArICAgIG1lbWNweSgmdmFsLCBzLT5zdG9yYWdlICsgb2Zmc2V0
LCBzaXplKTsNCj4gPj4+ICsNCj4gPj4+ICsgICAgcmV0dXJuIHZhbDsNCj4gPj4+ICt9DQo+ID4+
PiArDQo+ID4+PiArc3RhdGljIHZvaWQgYXNwZWVkX290cG1lbV93cml0ZSh2b2lkICpvcGFxdWUs
IGh3YWRkciBvZmZzZXQsDQo+ID4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1
aW50NjRfdCB2YWwsIHVuc2lnbmVkIHNpemUpIHsNCj4gPj4+ICsgICAgQXNwZWVkT1RQTWVtU3Rh
dGUgKnMgPSBvcGFxdWU7DQo+ID4+PiArDQo+ID4+PiArICAgIG1lbWNweShzLT5zdG9yYWdlICsg
b2Zmc2V0LCAmdmFsLCBzaXplKTsgfQ0KPiA+Pj4gKw0KPiA+Pj4gK3N0YXRpYyBjb25zdCBNZW1v
cnlSZWdpb25PcHMgYXNwZWVkX290cG1lbV9vcHMgPSB7DQo+ID4+PiArICAgIC5yZWFkID0gYXNw
ZWVkX290cG1lbV9yZWFkLA0KPiA+Pj4gKyAgICAud3JpdGUgPSBhc3BlZWRfb3RwbWVtX3dyaXRl
LA0KPiA+Pj4gKyAgICAuZW5kaWFubmVzcyA9IERFVklDRV9MSVRUTEVfRU5ESUFOLA0KPiA+Pj4g
KyAgICAudmFsaWQubWluX2FjY2Vzc19zaXplID0gMSwNCj4gPj4+ICsgICAgLnZhbGlkLm1heF9h
Y2Nlc3Nfc2l6ZSA9IDQsDQo+ID4+PiArfTsNCj4gPj4+ICsNCj4gPj4+ICtzdGF0aWMgdm9pZCBh
c3BlZWRfb3RwbWVtX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKSB7DQo+
ID4+PiArICAgIEFzcGVlZE9UUE1lbVN0YXRlICpzID0gQVNQRUVEX09UUE1FTShkZXYpOw0KPiA+
Pj4gKyAgICBjb25zdCBzaXplX3Qgc2l6ZSA9IE9UUE1FTV9TSVpFOw0KPiA+Pg0KPiA+PiBXaHkg
bm90IHVzZSBzLT5zaXplIGluc3RlYWQgPyBhbmQgYSBkZXZpY2UgcHJvcGVydHkgPw0KPiA+Pg0K
PiA+Pj4gKyAgICBpbnQgaSwgbnVtOw0KPiA+Pj4gKyAgICB1aW50MzJfdCAqcDsNCj4gPj4+ICsN
Cj4gPj4+ICsgICAgcy0+c3RvcmFnZSA9IGdfbWFsbG9jKHNpemUpOw0KPiA+Pj4gKyAgICBpZiAo
IXMtPnN0b3JhZ2UpIHsNCj4gPj4NCj4gPj4gaWYgZ19tYWxsb2MoKSBmYWlscywgdGhlIGFwcGxp
Y2F0aW9uIHdpbGwgdGVybWluYXRlLiBUaGVyZSBpcyBubyBuZWVkDQo+ID4+IHRvIHRlc3QgdGhl
IHJldHVybmVkIHBvaW50ZXIuDQo+ID4+DQo+ID4+PiArICAgICAgICBlcnJvcl9zZXRnKGVycnAs
ICJGYWlsZWQgdG8gYWxsb2NhdGUgT1RQIG1lbW9yeSBzdG9yYWdlDQo+IGJ1ZmZlciIpOw0KPiA+
Pj4gKyAgICAgICAgcmV0dXJuOw0KPiA+Pj4gKyAgICB9DQo+ID4+PiArDQo+ID4+PiArICAgIG51
bSA9IHNpemUgLyBzaXplb2YodWludDMyX3QpOw0KPiA+Pj4gKyAgICBwID0gKHVpbnQzMl90ICop
cy0+c3RvcmFnZTsNCj4gPj4+ICsgICAgZm9yIChpID0gMDsgaSA8IG51bTsgaSsrKSB7DQo+ID4+
PiArICAgICAgICBwW2ldID0gKGkgJSAyID09IDApID8gMHgwMDAwMDAwMCA6IDB4RkZGRkZGRkY7
DQo+ID4+PiArICAgIH0NCj4gPj4NCj4gPj4gVGhlIGFib3ZlIGluaXRpYWxpemF0aW9uIGNvdWxk
IGJlIGRvbmUgaW4gYQ0KPiA+PiBhc3BlZWRfb3RwbWVtX2luaXRfc3RvcmFnZSgpcm91dGluZS4N
Cj4gPj4NCj4gPj4gSSB1bmRlcnN0YW5kIHRoYXQgeW91IHdhbnQgdGhlIHZhbHVlcyBzZXQgYXQg
cnVudGltZSB0byBiZSBrZXB0IGFmdGVyDQo+ID4+IGEgbWFjaGluZS9kZXZpY2UgcmVzZXQuDQo+
ID4+DQo+ID4+PiArICAgIG1lbW9yeV9yZWdpb25faW5pdF9pbygmcy0+bW1pbywgT0JKRUNUKGRl
diksDQo+ID4+ICZhc3BlZWRfb3RwbWVtX29wcywNCj4gPj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgIHMsICJhc3BlZWQub3RwbWVtIiwgc2l6ZSk7DQo+ID4+PiArICAgIGFkZHJlc3Nfc3Bh
Y2VfaW5pdCgmcy0+YXMsICZzLT5tbWlvLCBOVUxMKTsgfQ0KPiA+Pj4gKw0KPiA+Pj4gK3N0YXRp
YyB2b2lkIGFzcGVlZF9vdHBtZW1fY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqa2xhc3MsIGNvbnN0
IHZvaWQNCj4gPj4+ICsqZGF0YSkgew0KPiA+Pj4gKyAgICBEZXZpY2VDbGFzcyAqZGMgPSBERVZJ
Q0VfQ0xBU1Moa2xhc3MpOw0KPiA+Pj4gKyAgICBkYy0+cmVhbGl6ZSA9IGFzcGVlZF9vdHBtZW1f
cmVhbGl6ZTsgfQ0KPiA+Pj4gKw0KPiA+Pj4gK3N0YXRpYyBjb25zdCBUeXBlSW5mbyBhc3BlZWRf
b3RwbWVtX2luZm8gPSB7DQo+ID4+PiArICAgIC5uYW1lICAgICAgICAgID0gVFlQRV9BU1BFRURf
T1RQTUVNLA0KPiA+Pj4gKyAgICAucGFyZW50ICAgICAgICA9IFRZUEVfREVWSUNFLA0KPiA+Pj4g
KyAgICAuaW5zdGFuY2Vfc2l6ZSA9IHNpemVvZihBc3BlZWRPVFBNZW1TdGF0ZSksDQo+ID4+PiAr
ICAgIC5jbGFzc19pbml0ICAgID0gYXNwZWVkX290cG1lbV9jbGFzc19pbml0LA0KPiA+Pj4gK307
DQo+ID4+PiArDQo+ID4+PiArc3RhdGljIHZvaWQgYXNwZWVkX290cG1lbV9yZWdpc3Rlcl90eXBl
cyh2b2lkKQ0KPiA+Pj4gK3sNCj4gPj4+ICsgICAgdHlwZV9yZWdpc3Rlcl9zdGF0aWMoJmFzcGVl
ZF9vdHBtZW1faW5mbyk7DQo+ID4+PiArfQ0KPiA+Pj4gKw0KPiA+Pj4gK3R5cGVfaW5pdChhc3Bl
ZWRfb3RwbWVtX3JlZ2lzdGVyX3R5cGVzKQ0KPiA+Pj4gZGlmZiAtLWdpdCBhL2h3L21pc2MvbWVz
b24uYnVpbGQgYi9ody9taXNjL21lc29uLmJ1aWxkIGluZGV4DQo+ID4+PiA2ZDQ3ZGU0ODJjLi5l
ZDFlYWFhMmFkIDEwMDY0NA0KPiA+Pj4gLS0tIGEvaHcvbWlzYy9tZXNvbi5idWlsZA0KPiA+Pj4g
KysrIGIvaHcvbWlzYy9tZXNvbi5idWlsZA0KPiA+Pj4gQEAgLTEzNiw2ICsxMzYsNyBAQCBzeXN0
ZW1fc3MuYWRkKHdoZW46ICdDT05GSUdfQVNQRUVEX1NPQycsDQo+ID4+IGlmX3RydWU6IGZpbGVz
KA0KPiA+Pj4gICAgICAnYXNwZWVkX3NiYy5jJywNCj4gPj4+ICAgICAgJ2FzcGVlZF9zZG1jLmMn
LA0KPiA+Pj4gICAgICAnYXNwZWVkX3hkbWEuYycsDQo+ID4+PiArICAnYXNwZWVkX290cG1lbS5j
JywNCj4gPj4+ICAgICAgJ2FzcGVlZF9wZWNpLmMnLA0KPiA+Pj4gICAgICAnYXNwZWVkX3NsaS5j
JykpDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvbWlzYy9hc3BlZWRfb3Rw
bWVtLmgNCj4gPj4+IGIvaW5jbHVkZS9ody9taXNjL2FzcGVlZF9vdHBtZW0uaCBuZXcgZmlsZSBt
b2RlIDEwMDY0NCBpbmRleA0KPiA+Pj4gMDAwMDAwMDAwMC4uYTU5OGU3MDdhOQ0KPiA+Pj4gLS0t
IC9kZXYvbnVsbA0KPiA+Pj4gKysrIGIvaW5jbHVkZS9ody9taXNjL2FzcGVlZF9vdHBtZW0uaA0K
PiA+Pg0KPiA+PiBQbGVhc2UgYWRkIHRvIHlvdXIgLmdpdC9jb25maWcgZmlsZSA6DQo+ID4+DQo+
ID4+IFtkaWZmXQ0KPiA+PiAJb3JkZXJGaWxlID0gL3BhdGgvdG8vcWVtdS9zY3JpcHRzL2dpdC5v
cmRlcmZpbGUNCj4gPj4NCj4gPj4NCj4gPj4gVGhhbmtzLA0KPiA+Pg0KPiA+PiBDLg0KPiA+Pg0K
PiA+Pg0KPiA+Pg0KPiA+Pj4gQEAgLTAsMCArMSwzMyBAQA0KPiA+Pj4gKy8qDQo+ID4+PiArICog
IEFTUEVFRCBPVFAgKE9uZS1UaW1lIFByb2dyYW1tYWJsZSkgbWVtb3J5DQo+ID4+PiArICoNCj4g
Pj4+ICsgKiAgQ29weXJpZ2h0IChDKSAyMDI1IEFzcGVlZA0KPiA+Pj4gKyAqDQo+ID4+PiArICog
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyICAqLw0KPiA+Pj4gKw0K
PiA+Pj4gKyNpZm5kZWYgQVNQRUVEX09UUE1NRU1fSA0KPiA+Pj4gKyNkZWZpbmUgQVNQRUVEX09U
UE1NRU1fSA0KPiA+Pj4gKw0KPiA+Pj4gKyNpbmNsdWRlICJzeXN0ZW0vbWVtb3J5LmgiDQo+ID4+
PiArI2luY2x1ZGUgImh3L2Jsb2NrL2Jsb2NrLmgiDQo+ID4+PiArI2luY2x1ZGUgInN5c3RlbS9t
ZW1vcnkuaCINCj4gPj4+ICsjaW5jbHVkZSAic3lzdGVtL2FkZHJlc3Mtc3BhY2VzLmgiDQo+ID4+
PiArDQo+ID4+PiArI2RlZmluZSBPVFBNRU1fU0laRSAweDQwMDANCj4gPj4+ICsjZGVmaW5lIFRZ
UEVfQVNQRUVEX09UUE1FTSAiYXNwZWVkLm90cG1lbSINCj4gPj4+ICtPQkpFQ1RfREVDTEFSRV9T
SU1QTEVfVFlQRShBc3BlZWRPVFBNZW1TdGF0ZSwNCj4gPj4gQVNQRUVEX09UUE1FTSkNCj4gPj4+
ICsNCj4gPj4+ICt0eXBlZGVmIHN0cnVjdCBBc3BlZWRPVFBNZW1TdGF0ZSB7DQo+ID4+PiArICAg
IERldmljZVN0YXRlIHBhcmVudF9vYmo7DQo+ID4+PiArDQo+ID4+PiArICAgIHVpbnQ2NF90IHNp
emU7DQo+ID4+PiArDQo+ID4+PiArICAgIEFkZHJlc3NTcGFjZSBhczsNCj4gPj4+ICsNCj4gPj4+
ICsgICAgTWVtb3J5UmVnaW9uIG1taW87DQo+ID4+PiArDQo+ID4+PiArICAgIHVpbnQ4X3QgKnN0
b3JhZ2U7DQo+ID4+PiArfSBBc3BlZWRPVFBNZW1TdGF0ZTsNCj4gPj4+ICsNCj4gPj4+ICsjZW5k
aWYgLyogQVNQRUVEX09UUE1NRU1fSCAqLw0KPiA+DQoNCg==

