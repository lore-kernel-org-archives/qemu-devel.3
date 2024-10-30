Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35557D74954
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 02:11:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5yAV-0007HU-Su; Tue, 29 Oct 2024 22:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1t5yAS-0007Fy-6b; Tue, 29 Oct 2024 22:10:40 -0400
Received: from mail-eastasiaazlp170110002.outbound.protection.outlook.com
 ([2a01:111:f403:c400::2] helo=HK3PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1t5yAN-00045W-Ht; Tue, 29 Oct 2024 22:10:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhLKHWsq7c75qzU/umul4yTMpEsOldLrDd1+Iuxd5hvhfv/wVP6HbE+OfnANW73a8aXsRCrdyFtx7jsABr4rQXV2xI32pLgrds/y+x0i/uIwHDsDLzZ6eCB6xFEfrIkjcZ/QSJ5OfLi6gPQq93tgmAdc0SQ2BFY+4n4BC6Wbcono9fW2LgH1hKQWWnSHYt1njNqmdTa3Sbdq7cJEVLPAeW+2C15tNj0RGQiJrDJR5xtP15GQKZVXoP81Zs2ohIUlVDWji8i3jXAjpzr8Ps3oA4uFPms5l3KrJF4Ww6AdEYgjbl3xj3hLwm5XvfHrIEGxYPydcd48Yb2NuUmqChuDvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9IUlYyjfjfAJONIsFIM17n/pAWXdYYiZUHIgrPvmrI=;
 b=PgIRV0fElVpXGj/uuZKxcAFK34w7Cse/QW4o18ORcoKDmIw2QnrBVLky9j9yqmqJ3hvBK01vWzIHMrGyLe4DZA7qGZ2XP+3+FNRon5Q0YbSaL6aGjkbpNCdq5912aaK35B72oGYbVMSoqbUwQDj5Jrv1ClHlxUfmUB4RlYB7+U2zeykc1g3KzVVuPORmDZW9CUF5ooqEuJ5OqAeEllI0riS0bOUH2s7MD6JXMP3HMFA9ejPIzn9NjdLS3ssnDWv3xncPnzFMV5yL8Sk6t6mu8SBKW2AAwZ4jfh2xSuuCUx4QJu6y0ddrkFMKqhUzy56dGzFwlBdY+BScB3YEmZbZNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9IUlYyjfjfAJONIsFIM17n/pAWXdYYiZUHIgrPvmrI=;
 b=a8DDQEqwTq5DYsr7zChatTbzuCX7Dq+rXQityo28lNEqA8J9zpO/97Epz9W0iwJ7Hjrm8M9UyNwjySAzauCMF/FSYuBi/fo6Xg8LwwjKK2ilIomQMyHVT4JgcQJr8rOZBczptu9gPCMvUiVeyej+HkWZ04OWZjNDZIkgrv+VaQiSnbZLFiT4vFpSUqM/8+u7qI4RONe7W+Yw9BjuSst/4TTWSarPvScNseyXHptegdK3NBhpefDfCGPDia00Q4DrLWlWYeftmT3hwpbCSK4cdBb9I/v1dt8WbeaDBDhSj+q4QXvz7OUwzatwTiEK1M47mkQo//KnFqrP6P8URuzhaQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 PUZPR06MB5474.apcprd06.prod.outlook.com (2603:1096:301:102::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.12; Wed, 30 Oct 2024 02:10:23 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%5]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 02:10:23 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Bin Meng
 <bmeng.cn@gmail.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:SD (Secure
 Card)" <qemu-block@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v1 5/8] hw/sd/sdhci: Introduce a new Write Protected pin
 inverted property
Thread-Topic: [PATCH v1 5/8] hw/sd/sdhci: Introduce a new Write Protected pin
 inverted property
Thread-Index: AQHbKeNpz/KnDT+fU0akNPgndaaF8rKeZvUAgAAmqJA=
Date: Wed, 30 Oct 2024 02:10:22 +0000
Message-ID: <SI2PR06MB5041C2A4F68C5C2C8E7B9552FC542@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20241029091729.3317512-1-jamin_lin@aspeedtech.com>
 <20241029091729.3317512-6-jamin_lin@aspeedtech.com>
 <41d563a4c0de07ad4cc363c6a3599734608454a9.camel@codeconstruct.com.au>
In-Reply-To: <41d563a4c0de07ad4cc363c6a3599734608454a9.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|PUZPR06MB5474:EE_
x-ms-office365-filtering-correlation-id: 2358ec21-4a27-4e8e-ee38-08dcf888030b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?L0YwNk9sVjlNb2Flbk5zTWloTzk0NTJWL09IQnpkVUVlNGRmVTBwYThKU0wx?=
 =?utf-8?B?cDFhNjZ3UStsZURnYjBRZDl2cXZuQzArV1hmMEgzeENNcWNYQUJFUGRIbTRL?=
 =?utf-8?B?YnlPaGVBYW9ZbXlobmdUeGRWR1BJUWR5b29LSUhhT3FpMXZZM0xSUFBBdDRB?=
 =?utf-8?B?NzFFUXI4TnluaTZESHpadmtNUVpJNDRUd3RxT21BZWZHTWRLQk5UK2ozbmxu?=
 =?utf-8?B?dlo1dmJzWTZDODFjZUVneUQxNGpqL1J6T3RJb21nNU01azhic1p6akdBNzFT?=
 =?utf-8?B?MWJlbkVJbmRiT0hPa0JRMjhQMFJzRTFEZnoraDJzb3JtV3FXQVo0MjlDVzND?=
 =?utf-8?B?WlZyM1hCV0xoaEFGVGlJMkVnNmFqNFpuOWsvMWE2NHIwdXgwenBJbUh2b2ZC?=
 =?utf-8?B?dWhRZldGZlNxcXY4ak5zelN1NytUT0tYbXhlYXA4NkNxbmpFaGdJallXUzB4?=
 =?utf-8?B?YlRIaUZZL3c1N3dDM1lXWncyUEFtRWdnaVJwRVBoQTNGNUtlQlRrYWVFNnNy?=
 =?utf-8?B?Q2M1ZkJ1QXZVaHBsVVc3MWM2aFJ0ek91ZzNFN1NIdUhrdExKNlBzeGFsMzhx?=
 =?utf-8?B?OFU5Z24zampTRW9WNno3ZzlHVVhWdGlTK01lY0tKbEwzenhsUytYOGNUL25Q?=
 =?utf-8?B?NldUNEU2NktuQzhTSXc4c1hxRFp2a2NXanM4OWVkd2hucUx5M0lDeTZwRGc4?=
 =?utf-8?B?eVRjZDZJazRTMkpxWllPVlAyWU1zRi9tTlhkSllEM3QzRHRRdVJ0OHJZSXFO?=
 =?utf-8?B?cUk2Z09ZUldjdjcwT1hoNGp6d3VYeUthUHc2eThXVGlhajZwU2w4VzZEWTk4?=
 =?utf-8?B?aE0zMFpFVlhBdERuTndIek9uUHV0RGxSK2lIbjhwNjF2MU9COVFFUTRkZk9u?=
 =?utf-8?B?YWZaWHJqQXYrdEpKdnZKNGU2WWcvL0ZXWHFlbEIrY1ArS05URUlra2Q3Uksz?=
 =?utf-8?B?VlMvTzJSWUhNZ3pqVzZyczVGVGpFTk44ZU9OcGRUblhuQU9taVJLZlVGLzJz?=
 =?utf-8?B?cEtLWjE3dDVDMThlWEZWT0RvZGdpcklMNTkyRytkOTBPcWdBeTJvNmx2OWxW?=
 =?utf-8?B?b2Q4U2l1bjlQemFEdXFyNG15QUM2NG1QZlhqclJaVWt4cFpNd0dtYUJYYU1Q?=
 =?utf-8?B?THFkWWhGQzlFWXJHd1c2Y0FaWm9TWDNjYmNoRkFMaVBIWFFjZVo5UllMYkxY?=
 =?utf-8?B?MjVCMWluNjlodmZoODU4SnhjUiszbUZsbkVIM0pxNWNoMzhTekFWUCtHY1M2?=
 =?utf-8?B?VXFCKzVCMzZIbDFjTTMvcU9oYUhlV28xUkdpSTNOK0srcmFaT2thbUFudDVW?=
 =?utf-8?B?T0U3RElVNE1JNVJkMHhUbEtHL2s5RWRDay9lbnJwMVNSbUNTU2M2dktnUTht?=
 =?utf-8?B?Qy9lRnc2SkZYNnZIK1I5cHJxc2VrS2xMV21JaVJJVUIxaDZuV3JXZFVEZHY1?=
 =?utf-8?B?UGFZYUxPa2FiMzkySHBRZCtDWXgrdVdPbGhZU29vRGpJYklMeTR2ZUg3WTBD?=
 =?utf-8?B?YnJFa3F6WTJZblF6YWoyMDZPbk9MMnFLM2xnLzQ3L0lvb0pTMSs4d254REEr?=
 =?utf-8?B?UUVzSHgwaVFCdm9TUktGOXpoRGFMbUl5Mjd4ZUdDVVQ2dWFLaTlPSGtNUlgv?=
 =?utf-8?B?Z2VXdjRJVnlKVVhBN0F5VUJweGQ2NEdtZ3VBd3ZXRzNLRW44bzgxOURGQWxv?=
 =?utf-8?B?bG1MMGJ5Q1Z1ZEJZZ1p2MXpjS3h4U092dC9XNGhUbTBCMFBvbkpYbk1RMFJw?=
 =?utf-8?B?UVlwdTYvbjhOYkJLbEV3cThhckRSRTA4OFRweFdmalNPazNHN0JxcGRQaEtS?=
 =?utf-8?B?bkw5OEF3anpYci9zTWRacXhLWFp4RFVSQUViYi93ckVhaXN5dS9mUzlDRDNk?=
 =?utf-8?B?RlRPdGxXRDV2cXNTa0E1ZlE1eDRoTEVWWDVmUllVTjJuNEE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUw2R0VrM3lnb24vMDUxT0FZY2k1cW9PemF3N21DNktBMnFLbkZoL0E4VEYz?=
 =?utf-8?B?Y0IvMkFOcnVpS3JtbnQ0UG5mWXBSQUlhdFZXSmdjNnZNY1h2WWlNeVAzYU9Y?=
 =?utf-8?B?TkxMNVpZZzQvMEhqOVVORTUvR3hEN1dXVk80QmN4UFNUMFNIS2FzU2lLWkN3?=
 =?utf-8?B?a2VUdUJscEt5YTJ6K0NneU1VVFFUWUNOek9pTlFsNXVrR1Q0QklLTE1VWm1S?=
 =?utf-8?B?cVRiZVdiQWtlNFlxVmhHbWcrWGpSWTBOM1JabElacWQ5S2VDYVNxM2JnRUNj?=
 =?utf-8?B?blJUZEFyZnFvenh5ODlGSEVBTVRhV1RYL1M2VmlzK3lROGg1YzkxYVlhVk9r?=
 =?utf-8?B?U1lsajY5WDVCalBhZ3U2TkVyb2NBdkdIbGJWY252WWJNd1dZc2ovcEhINit5?=
 =?utf-8?B?MkpYeTY1QnppRmNuM0lvMFBuZ3lMQ2IvUDhvU0pENlZ2TDZqN3NUVzVvc3JJ?=
 =?utf-8?B?cExObWsvU3pUMmJvd3BEL0tmTVllV3hCODRpS1N2T1pOSFlOZ0RSTmRzVFRH?=
 =?utf-8?B?dHVQVjl5K2MyT0JoVzdDSHVMKzlzMGdKdjB3a1I4cjlFRDZ6Y2hIbFVZYVBU?=
 =?utf-8?B?OFJhOUdXdEdCRzFkSWJhd3I1S0VTUjNZcUpJWDdGQXlYZkIyYUp4Y0xmYXJS?=
 =?utf-8?B?SDJvWDlEekJZOEtlNkZnd3R1eUNZTXJLSXU5NzNucHBSZVBuREJIc2J1MjBL?=
 =?utf-8?B?Q2VHaGNWYW0zWEwxZG96TkxMcXJoNHEzRU1vSW5sL3NUZGxmaGNDbkxPckZG?=
 =?utf-8?B?bDJKOFFiTm5JWXBHVHpsUzU4MFIwaDM3bFNNNlhxT0RGWGlPT1BOV0lNdHNG?=
 =?utf-8?B?T3pjcWdzOTNhSjlZSFpJNU4yK3pJUU5NWXdIZ2xQcTJyQmZNWU1QdFhVcGJY?=
 =?utf-8?B?Nng5T2laTGtrWURVQVNOcGpEY2VSRDdQTG9Ga1RZakROUG1sR2lZOHdUV0Zq?=
 =?utf-8?B?SktuS0J3TG1XcEtpaXpFcVYrblpXRnpDeU9sL0Jtc21FU1FBSTFGRDFXUU9U?=
 =?utf-8?B?cGFNSXZKcEF6ZTRBUXBtRGxTL1lPaDBXM1oveEF1TkpwNm5QTXJnMTY2bmpE?=
 =?utf-8?B?aEF3UzZTR0JqdjVqcVNRczlYVDFvcEtvMm10ZFd5WnNRcndGRFpIdHovV3dS?=
 =?utf-8?B?cE92YVNlT3cwWHVDNmE1N2IxN2Q0U0U0VXV4STZmc0RPWE9MeFRVS0Qxbkl2?=
 =?utf-8?B?bFlGTzNpVHFSeDU5T0hCSW1UVzVzSlVFdUt1eHNGY3U2bHFaZ05CeEdCR2Nm?=
 =?utf-8?B?VWZGSE54T0J4M2ZNLzdlWlJUUzA2ZEp1VHNKYTVHWXRrSGY3d0QxL0gwN1Vx?=
 =?utf-8?B?SlJsMGRwZDBYTGhnRzZ1YThXMmxwaUt4LzJOTmc3Z29ESGZOalVKdUtxY1dv?=
 =?utf-8?B?QllrUVJXOEFkNTNXOVhEOE1YYmFLRm42MnlMaUk1VzF1SnQvd2JBOWpqSUtt?=
 =?utf-8?B?aEVFSC9FbWtGamJtN2dUbDdoSU9YN2EyV2lSZGdEQ3RuYjFCVEYvdDhRR2Jh?=
 =?utf-8?B?MWpJL2RPQ0QwamZhSkN0Y0M0NVRVRGlhZEk0T0Y4SitmeEppT21lN1RjTkFD?=
 =?utf-8?B?UTJMS1BIRXc4dlZaU2o4Sk9rcEdYL3ZqV1k0c1VWWFBJN3AxRFJackttWVV4?=
 =?utf-8?B?UGFhRE1jREJjUG5keWFMZW0rNUVybEtxQ3VTc053TmxBMndyVmxHNjM1cW9G?=
 =?utf-8?B?M2UySmlSQzQzNWtRck04eEY1dXNVc2N0dHl1VE1PQzhSNWg0UjZLQ1hyMUhI?=
 =?utf-8?B?cVRSaHlUL3ZxR2ZEMGNqYktpTUFXcU9PRmhyTVllR09nV05DWjhnMTF6UU1s?=
 =?utf-8?B?UlFjeGg0azVzdktGZjdhZTBJamg5SWFTZFQ4cHVkNTUvUHFNOEJHRDFrMWdk?=
 =?utf-8?B?VzZCdHhGTlRkS1JnbVNLM1FPNE1Ud0pvcXlDdkhCL2ppazQrVXMrbFo0REk3?=
 =?utf-8?B?NGs0MEgrTkpsUStoM1poUEJ1b0NsRjQwbmdIZUlCMmNHbEJ2WGhPWFhxYVNm?=
 =?utf-8?B?VkJzcGFLYk1CcGhwL3lya0xMQnAxTzlzV01aYk9NYWpoYnZwUXBjSklzdUNs?=
 =?utf-8?B?MndoZlB2YldZbVBRTTB1RWswblZJdXdNcklzMmtEU2ZWSy92VTQ0elJqTVdN?=
 =?utf-8?Q?Oi13aEAfCWRvkGsvoHc6AJoqR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2358ec21-4a27-4e8e-ee38-08dcf888030b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 02:10:23.0054 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p2mK+0mo3lrY4VxkaI2RgSURbgvk14VDndTaheejyQTEHDv6RutfV1FZ1VMmdNwx0RhOh7y+TlZSEj/48muviv8xgQybeuTIYS68W8rU5es=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5474
Received-SPF: pass client-ip=2a01:111:f403:c400::2;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=HK3PR03CU002.outbound.protection.outlook.com
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

SGkgQW5kcmV3LCANCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDUvOF0gaHcvc2Qvc2RoY2k6
IEludHJvZHVjZSBhIG5ldyBXcml0ZSBQcm90ZWN0ZWQgcGluDQo+IGludmVydGVkIHByb3BlcnR5
DQo+IA0KPiBPbiBUdWUsIDIwMjQtMTAtMjkgYXQgMTc6MTcgKzA4MDAsIEphbWluIExpbiB3cm90
ZToNCj4gPiBUaGUgV3JpdGUgUHJvdGVjdCBwaW4gb2YgU0RIQ0kgbW9kZWwgaXMgZGVmYXVsdCBh
Y3RpdmUgbG93IHRvIG1hdGNoDQo+ID4gdGhlIFNESENJIHNwZWMuIFNvLCB3cml0ZSBlbmFibGUg
dGhlIGJpdCAxOSBzaG91bGQgYmUgMSBhbmQgd3JpdGUNCj4gPiBwcm90ZWN0ZWQgdGhlIGJpdCAx
OSBzaG91bGQgYmUgMCBhdCB0aGUgUHJlc2VudCBTdGF0ZSBSZWdpc3RlciAoMHgyNCkuDQo+ID4g
SG93ZXZlciwgc29tZSBib2FyZCBhcmUgZGVzaWduIFdyaXRlIFByb3RlY3RlZCBwaW4gYWN0aXZl
IGhpZ2guIEluDQo+ID4gb3RoZXIgd29yZHMsIHdyaXRlIGVuYWJsZSB0aGUgYml0IDE5IHNob3Vs
ZCBiZSAwIGFuZCB3cml0ZSBwcm90ZWN0ZWQNCj4gPiB0aGUgYml0IDE5IHNob3VsZCBiZSAxIGF0
IHRoZSBQcmVzZW50IFN0YXRlIFJlZ2lzdGVyICgweDI0KS4gVG8NCj4gPiBzdXBwb3J0IGl0LCBp
bnRyb2R1Y2VzIGEgbmV3ICJ3cF9pbnZlcnQiDQo+ID4gcHJvcGVydHkgYW5kIHNldCBpdCBmYWxz
ZSBieSBkZWZhdWx0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9s
aW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gwqBody9zZC9zZGhjaS5jwqDCoMKgwqDC
oMKgwqDCoCB8IDYgKysrKysrDQo+ID4gwqBpbmNsdWRlL2h3L3NkL3NkaGNpLmggfCA1ICsrKysr
DQo+ID4gwqAyIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9ody9zZC9zZGhjaS5jIGIvaHcvc2Qvc2RoY2kuYyBpbmRleA0KPiA+IGRiN2Q1NDcx
NTYuLmJkZjVjYmZiODAgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvc2Qvc2RoY2kuYw0KPiA+ICsrKyBi
L2h3L3NkL3NkaGNpLmMNCj4gPiBAQCAtMjc1LDYgKzI3NSwxMCBAQCBzdGF0aWMgdm9pZCBzZGhj
aV9zZXRfcmVhZG9ubHkoRGV2aWNlU3RhdGUgKmRldiwNCj4gPiBib29sIGxldmVsKQ0KPiA+IMKg
ew0KPiA+IMKgwqDCoMKgIFNESENJU3RhdGUgKnMgPSAoU0RIQ0lTdGF0ZSAqKWRldjsNCj4gPg0K
PiA+ICvCoMKgwqAgaWYgKHMtPndwX2ludmVydCkgew0KPiA+ICvCoMKgwqDCoMKgwqDCoCBsZXZl
bCA9ICFsZXZlbDsNCj4gPiArwqDCoMKgIH0NCj4gPiArDQo+ID4gwqDCoMKgwqAgaWYgKGxldmVs
KSB7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoCBzLT5wcm5zdHMgJj0gflNESENfV1JJVEVfUFJPVEVD
VDsNCj4gPiDCoMKgwqDCoCB9IGVsc2Ugew0KPiA+IEBAIC0xNTUxLDYgKzE1NTUsOCBAQCBzdGF0
aWMgUHJvcGVydHkgc2RoY2lfc3lzYnVzX3Byb3BlcnRpZXNbXSA9IHsNCj4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmFsc2UpLA0KPiA+IMKgwqDCoMKgIERF
RklORV9QUk9QX0xJTksoImRtYSIsIFNESENJU3RhdGUsDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRtYV9tciwgVFlQRV9NRU1PUllfUkVHSU9OLA0KPiBN
ZW1vcnlSZWdpb24gKiksDQo+ID4gK8KgwqDCoCBERUZJTkVfUFJPUF9CT09MKCJ3cC1pbnZlcnQi
LCBTREhDSVN0YXRlLA0KPiANCj4gQ2FuIHdlIGxpbmUgdGhlIG5hbWUgdXAgd2l0aCB0aGUgbW1j
LWNvbnRyb2xsZXIgZGV2aWNldHJlZSBiaW5kaW5nDQo+ICgid3AtaW52ZXJ0ZWQiKT8NCj4gDQpU
aGFua3MgZm9yIHN1Z2dlc3Rpb24gYW5kIHJldmlldy4NCldpbGwgdXBkYXRlIGl0Lg0KDQpKYW1p
bg0KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2
YWxkcy9saW51eC5naXQvdHJlZS9Eb2N1bWUNCj4gbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L21tYy9tbWMtY29udHJvbGxlci55YW1sI243MQ0KPiANCj4gQW5kcmV3DQo+IA0KPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHdwX2ludmVydCwgZmFsc2UpLA0K
PiA+IMKgwqDCoMKgIERFRklORV9QUk9QX0VORF9PRl9MSVNUKCksDQo+ID4gwqB9Ow0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvc2Qvc2RoY2kuaCBiL2luY2x1ZGUvaHcvc2Qvc2Ro
Y2kuaCBpbmRleA0KPiA+IDZjZDI4MjJmMWQuLmQ2OGY0Nzg4ZTcgMTAwNjQ0DQo+ID4gLS0tIGEv
aW5jbHVkZS9ody9zZC9zZGhjaS5oDQo+ID4gKysrIGIvaW5jbHVkZS9ody9zZC9zZGhjaS5oDQo+
ID4gQEAgLTEwMCw2ICsxMDAsMTEgQEAgc3RydWN0IFNESENJU3RhdGUgew0KPiA+IMKgwqDCoMKg
IHVpbnQ4X3Qgc2Rfc3BlY192ZXJzaW9uOw0KPiA+IMKgwqDCoMKgIHVpbnQ4X3QgdWhzX21vZGU7
DQo+ID4gwqDCoMKgwqAgdWludDhfdCB2ZW5kb3I7wqDCoMKgwqDCoMKgwqAgLyogRm9yIHZlbmRv
ciBzcGVjaWZpYyBmdW5jdGlvbmFsaXR5ICovDQo+ID4gK8KgwqDCoCAvKg0KPiA+ICvCoMKgwqDC
oCAqIFdyaXRlIFByb3RlY3QgcGluIGRlZmF1bHQgYWN0aXZlIGxvdyBmb3IgZGV0ZWN0aW5nIFNE
IGNhcmQNCj4gPiArwqDCoMKgwqAgKiB0byBiZSBwcm90ZWN0ZWQuIFNldCB3cF9pbnZlcnQgdG8g
dHJ1ZSBpbnZlcnRlZCB0aGUgc2lnbmFsLg0KPiA+ICvCoMKgwqDCoCAqLw0KPiA+ICvCoMKgwqAg
Ym9vbCB3cF9pbnZlcnQ7DQo+ID4gwqB9Ow0KPiA+IMKgdHlwZWRlZiBzdHJ1Y3QgU0RIQ0lTdGF0
ZSBTREhDSVN0YXRlOw0KPiA+DQoNCg==

