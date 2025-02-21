Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1C1C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 01:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlHxi-0004xu-MP; Thu, 20 Feb 2025 20:36:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tlHxf-0004xY-9c; Thu, 20 Feb 2025 20:36:15 -0500
Received: from mail-sg2apc01on20701.outbound.protection.outlook.com
 ([2a01:111:f403:200f::701]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tlHxc-0002EE-7Q; Thu, 20 Feb 2025 20:36:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5wN8qWQPb6Zh52+MZjwyQKzTPFTieui79y9M9pzsYJstHwCzxBPpLKrdfsNGKm8qD6xMLEDVbuPLcBcWXeFCgNy8dtRY+j/aahGA/l3em38AvJB6q5mhOVonX3hHAXq0G6zYI2m5GtnjO+4mFEJ0SCN6qdoRknX7yhP40qSCvGAI77/41kWJf8siw2ATPHsFRY8xU4rSfuGdCqMgIeEb9yEE69L2xJX2bV0v9Df5BB1IX8K8G6J+eXrIj2Nq9odMnDJewERXrtf0+JgmCkc+mFwHl2g0SmvspZhCAwW3mM56MXTj4QiTyYtL4isjbsP//5t2OEkzNyMS/TigvH6KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dy4e1UnQ0fC4hyAgPh95ruFH3pVlAl1YJ1U90XWqGg8=;
 b=v/XZn6JT+95molAMlciMPBrCVPIitIzyD2s8vVGEt/wpwyvkyT2Ti3a5IE7x6bthYaHsI1FFjSeo+x90xDBaFDZCCOXu95TS4RnNqXEiTAFV+6ArODesmkqKNEvjhT0sTlRw/rNI4VY9t62EVj/udkEn8d+Z1+uYXRYvdk+UNFgXR0DA6HgLDIbHx2ZQXgGF+J6smcxVWRGsPLtcDG+Hnz4t+wEvxNdYE1yvcfZ7NqRB2wVdkTbBbgu4BeHr93RemTD5t1uWN7dxcQ48yTwLgSLFsKme16s0rBbv+GTbGrZmKlbsEuvgS+1sfGXzUMXNuGuKJi7iAUgMFk6pxBG/KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dy4e1UnQ0fC4hyAgPh95ruFH3pVlAl1YJ1U90XWqGg8=;
 b=GA5Z7yqxvcLzrBX+JAlTCS0fyq7MsKywctbQR8/IkiDiOYrA5vaQlUj/OdUQJFg1q1s4Nl3k1iMRQmbZZVK405KuHdrtk10/xSs1uUhf9oqMD7MzPKmriXQ73PuMNtQjUeSuimxq+DSGOLJQfBVJapBTamu4FKTeovD6tRy8OzZqsnfE19Cdft5IAzKXNzpzqd7YXxQvsvhsCEOfHEx6SisvN1fv9y4/VUcbFpC1UZp1+lm2HFNf0Gn9NLsCpmh+juACYm2VwXPxOzTHmEse8Ra4VQiVpArvGPnu6B8pYzOPpwLVSp8HzaosxDENQu1oWWRpVPR27nwj2eY1dtxKxQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SG2PR06MB5034.apcprd06.prod.outlook.com (2603:1096:4:1c5::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.16; Fri, 21 Feb 2025 01:35:55 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 01:35:55 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v3 23/28] test/functional/aspeed: Introduce new function
 to fetch assets
Thread-Topic: [PATCH v3 23/28] test/functional/aspeed: Introduce new function
 to fetch assets
Thread-Index: AQHbfchlrr/CQU8Vc0CDyW393KUINLNMobAAgARkU7A=
Date: Fri, 21 Feb 2025 01:35:55 +0000
Message-ID: <SI2PR06MB5041EDA394E20DCC3BE8522BFCC72@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250213033531.3367697-1-jamin_lin@aspeedtech.com>
 <20250213033531.3367697-24-jamin_lin@aspeedtech.com>
 <bb348626-7a99-4b2d-8476-38976f647ed7@kaod.org>
In-Reply-To: <bb348626-7a99-4b2d-8476-38976f647ed7@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SG2PR06MB5034:EE_
x-ms-office365-filtering-correlation-id: 7aa1b68b-36d6-4022-3171-08dd521815e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WDI3VXp4K2E1TzlZU1NPMFJYRUlXUnBvTW9yRVpGTW5NcjFXem1Rc2h4SkdF?=
 =?utf-8?B?MTlKUmgwNEtEZW9qd3FDaTRQUlR5Q3dPc1hOM0NsOHpFSXdrbVRhN2NXREpK?=
 =?utf-8?B?RkhVMFMrQnpvQkhOd3Vyc1YweEM3d3NISXFkU25XWTBpOUl5a0QvQ1R5Sk8w?=
 =?utf-8?B?bGtPZHlBMlMwUGszUHFZWmhuSlRrR0FGaWNvdTRiVVRXUFM4dHBRUXVySExm?=
 =?utf-8?B?c0ZVQUhHL3Uwa3R1b1RpWlgrUVB0enFjaGZkRGNTK2hEbjZxQjFPZU5LdXVl?=
 =?utf-8?B?Nmd3S1JwU3RTVTZIOVB4ZDh2bUN1UjdzV0ppUVFCQW42S3g2aDBWWWNwbm54?=
 =?utf-8?B?MjNDa3prWEE1Sm9yYWNBbVJ6RXp6amg0Y3VKekhzQUxlYUhoQ0M0bzRHbHpG?=
 =?utf-8?B?TkEwUmt6TG5KdWZnOTNKTU1rMkl0ZCtuL0NDYnQ4Ny9yRkFuRjhuZktCMEhI?=
 =?utf-8?B?dU1ZSUJiRU8yRTFYVm5Dc25qYWQ1RStEYy9PbGJnZ3VpQ1ZZVisxV0ljK2Vq?=
 =?utf-8?B?T09xdW9jVGcyNVVhTDdyVTZnL0JlSitISElBRlpZRVR6YkJJR05BSlNFNUxn?=
 =?utf-8?B?cTd0bjN2M1JUOGtHT3NIcllTUnJ5VUs4WTMxN2pRQlBuYm0xTkJWYXdDaTB2?=
 =?utf-8?B?bFJGOXFPdzRqaVJFaERUNXdBcVk2NGpIUTVSM2pvWTJtQ3E2QzdkWmovVWhs?=
 =?utf-8?B?RmtwelllcGlHajdUMFpERU1qeU5leUZRbG1wWEE2MGFQU0NUbFN0OUVLWnZQ?=
 =?utf-8?B?UDN3NHNNOFRHbVZPUUF3NEkzNVNpMFNVQk9mekNsT3NreGtuUFNNN2RyV1VX?=
 =?utf-8?B?YTgwaTdCWmREQzUySjBvYmJJNkRYR0JmWDVkblBpYmlrdzIvNzdOanJXRzlI?=
 =?utf-8?B?NFRpZXdpY1hnTHZWdENkWUhrdFU3aDVRQUpOVG1ObC9JZk5jNVlBK3dFcndE?=
 =?utf-8?B?NEhXSWdmRVdNb3h6L2g2NWNZRmxlWUgwT1k0Skg5UE5aME1RaU56YU5BSUts?=
 =?utf-8?B?LzM3OWRxckpWTURmMFB4b0JOdmhzY3JRYkJUc3NReEZRekFZL1c5NzBOTk10?=
 =?utf-8?B?aHRoc0lZaUMrQkxXTlpUcEI4UDhHWVVJSUltOSs0ekRQSjRMTXZFUmxxejVG?=
 =?utf-8?B?am5OcnJnajIrZWxaa3htSDJzVForN1pKWUlzU1grbGV3L25XY2pBdDc5cnJO?=
 =?utf-8?B?cGIyL0Iya0trVEhKMUVNdnB5ZXdxUkM2MUkrYzFxZG81R1J3M256RUxyQi9E?=
 =?utf-8?B?RSsrYlh2UUdSaTRkYWZreWlmNng5TXAraTZOeE9leXFRWmh0aHpEMWx2dmJ3?=
 =?utf-8?B?Mm1BU0VTSmFLVjYrekJwYVdGYWgyUjQzMUZXODRMczZHZWdYdkFZT29zQlVp?=
 =?utf-8?B?WE4vQTYwNnNhQm1xSCtDZUV6Nkp0UE9SUWNYNy9xMEk3RElqRHpBQS8vNTJT?=
 =?utf-8?B?VnpKQVlrNCs1dVAzT2cyWjVOL1R1dmo4cnJIK3M4Yk90ZzV2d2xRN1NISWdZ?=
 =?utf-8?B?bWFzN0p5VnF6MG4vdVlZYjB1cThrL1hkNTMxcWtSa1Q2UWVCNjRSZzV0aUdT?=
 =?utf-8?B?V1NjMXp6enNWSTRnM3NuQXNvemt0QUJOQmJqYVF6NEtWRVl5WUpZeXhGNFFs?=
 =?utf-8?B?c1kvcXI1bkRzSVRoR0tJVXZZTks3dXpSdzkwMlBGbnkvMncrUTNSaG91Z09K?=
 =?utf-8?B?T1pHUjlTMGVCa243alJGN1FTK1U2TzJCOGpuTjRxNWhweGNHRnUrQ04rN3FK?=
 =?utf-8?B?SUlCMmJqc0NacHA1WFhyWFo1T1k0RVZPd213QnpiTFBIUEZhNmZmVUJzOE1q?=
 =?utf-8?B?T041YTNlWGxONEFXNkpyN0lsRCtHS0hjWmR6V0hvYnRjeEJnMkRGSDhFOGNC?=
 =?utf-8?Q?fORQybF07AcZL?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2l5UFRJZ3BEQ2t5dDkycmZUVzVHczNSWlVmV2ladkMzV0syTzJUSUhhNlVa?=
 =?utf-8?B?UkZyQ2JaK0p1SEdjMVFkdVAyYWkvaUtDWmU0Ym5BWjV5dDJuU1V0RkFEeStQ?=
 =?utf-8?B?UExvdmxyU1A2V0VGZWlVdzIvejNKRHZrT1BubWIrNEdoN0xQQ0h4TnFNY3Ux?=
 =?utf-8?B?N2gxeXZmdlMzUTRaM3hPQmIxZ3JxSlpVaUNLTkYwME4xSEFBQ0E1ZVdObUEv?=
 =?utf-8?B?bUFQejZ3NU5yTHhyOUNyeUJjZnhxdkdYMkZPV2RzdWxHTTN2WFNDUE1tYVdY?=
 =?utf-8?B?Q25rNnYxTjhna2txaGwyNzdrVjhXVDlZY0p4YzJoWDF0bDEzZVgxMVZsSnFW?=
 =?utf-8?B?eDVYa1BDa0pKSmJqKzdwT2xPdmVFZXhvV0pjYmcveStJQ3hhWHNkbnd3L205?=
 =?utf-8?B?WmpXbm5PQStNWXR2WW92WVFYdGJTUGY3QWJXbHk5L3M0cDJDTlFHL2VFcGUw?=
 =?utf-8?B?Zis1VlZ0U1N1NkxnZW40VlZONjdlM20wUS9qUDQ0UzdsemViRU1YZWtFSVZC?=
 =?utf-8?B?MThxWlJYYWlLQ0xaVnQvSlo0VVQrbzI0eHBKZnViZ0hRRXRrM3JwTk5QVGV1?=
 =?utf-8?B?SnF4djN4Rit1WjBDWFNUZm5pWDRPUktzTnlhNDBiQ2plQmlIbVVISGZhZGcx?=
 =?utf-8?B?MUo5LzRXWVhndUJVbHM1RGpUb0pyZWk2cXJ0NmVUR1Y4ekwzdi9kUW9NOFBu?=
 =?utf-8?B?dndYV1pGT3RPRjJtelduSkJ3VjErMlN3TmRlajJoVEgzYUdyMHhpZDFjclZn?=
 =?utf-8?B?M2pQU3QrNUFxRDRhRzIxTnBBdmJvcGppN3Y5ODhrWm1KZnFOVXFoUVVjR3pz?=
 =?utf-8?B?VjZMRVVYNi85S1ZkSjU2STRwbWlDbDBva2dKMUNYa0lQL3NJRDZFbHhjMUNY?=
 =?utf-8?B?d2x6QUU0SWQ5TjVna0xrRVdBbnduVlJkMytOc0NlU3FOUTJRcU9GbTZnVjdF?=
 =?utf-8?B?M3Q1MHp4ZHB4eFAxUG8wcDJ2dnpodFBzcFptKzBadXpERlFYNkNsRWhWTXhw?=
 =?utf-8?B?bGdrSC9IOXpucnJNbTYxM2EySnJLZGZtOUY3MjJObFVBbjF3cEhuYWdUMDE4?=
 =?utf-8?B?NFlNdFRzRzh4UW5HVnkvbEE5Z2U5NjZGL1NGMVZQL0paN3ZtU1E0dTRzWVJM?=
 =?utf-8?B?S1BnQzlkU2I0cXFWYlk1Qkw2ck93SGhuN3RDdjRXR0JDUnZZMzRoOUVqQVV3?=
 =?utf-8?B?NFNGaE9ocVZhNUdDQWc3ZVhuUWpoazJlUUE5Y21lK21VaXN2dTBWZFNyRVZF?=
 =?utf-8?B?VEtwbUx3QWhBR0NtRWsyUTE2V0JUWXN3MGRVbUM4VWd6Wjk3dEJ4THFKTmpu?=
 =?utf-8?B?ZjlCeTRHTnZvcGd4R0dLdytXeHdIZm5rajYwM2NIc0lWZ0RhWUxxeWdzdVlp?=
 =?utf-8?B?Umh4MGMwRlczZWF2ZENNaFBDZVVhei81VmNDRE9zOCtuVEZVbHVSTjVoZUdE?=
 =?utf-8?B?TWJmOEJJT3JXNWpvZ2hRZ1o3c3UvODFXbTdpdE1KQjRFeFl1cDZrd1AwbmxF?=
 =?utf-8?B?MXBVY2Q4Y0hRYTB1SUxJS1ZuSlhkK0tCS2FMOEJnT1BtdjhBVTRLdmdFY1dZ?=
 =?utf-8?B?Tko1WWplWXFpdUxiVXloYndRaE1BRDFNdGphL3pKV1lhdlVzWFVJM1BEWkJa?=
 =?utf-8?B?R2hLMnMvb1FCaTlIUXFEZXBXMWsxYXltQTExZkZHd0tVU3RoTkFnUytlbmFw?=
 =?utf-8?B?L1JmUmxlUU1wQXpJRFFsSlJjVHp2ZjdxcHlEeEk3aytGNW50V3FRVjdXWDNT?=
 =?utf-8?B?a2VIYnB1NHBVdzdQS1djV3RITDlsSG1ucVNOc09SMmFzdHBzTzczMlREZW9H?=
 =?utf-8?B?VjUxalZsZ0dzWHpydmpyNDFEZXBDMVhTcC9mNS9vRjVPdzVDRm4xOVNMQXoz?=
 =?utf-8?B?b1FvRDF1Wlp4d1NnQTR4TGFQTUozRWxxL1M3Qnkrdm9Bb0RaOHU3dEpaM2dE?=
 =?utf-8?B?Wk95RCswQS84UlZOZ2dPMzhJcUU3VHVVRmJEdXVOUzNYbHkyeWY1SndHSFNX?=
 =?utf-8?B?eWwzSGZka0VDSnU4eE1JM1ZWNi9mczNkUml4TGpPOEdSVzcwVE9EbFE2dzdp?=
 =?utf-8?B?bFVmK2ZpVzBWR3BRc2hrUFdYcUxLdjlJczFtOG00aFVMblp5TkRZbVFtYU5s?=
 =?utf-8?Q?+wxNdHKRrQcpevUtRWXnELTN1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa1b68b-36d6-4022-3171-08dd521815e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 01:35:55.5965 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /WkNvlG/jgAn9Hp2s2HZuHCjTX11tVUDVUfjqFecWtx166owmcCJekEGr21ZdUo5uwsSgS2BXDXowaExy/uuWMrM87x/1DLdih7mEmPAoCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5034
Received-SPF: pass client-ip=2a01:111:f403:200f::701;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
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

SGkgQ2VkcmljLA0KDQo+IA0KPiBPbiAyLzEzLzI1IDA0OjM1LCBKYW1pbiBMaW4gd3JvdGU6DQo+
ID4gVGhpcyBtZXRob2Qgc2ltcGxpZmllcyB0aGUgcHJvY2VzcyBvZiBmZXRjaGluZyBhbmQgZXh0
cmFjdGluZyBhc3NldHMNCj4gPiBmcm9tIHRoZSBBc3BlZWQgR2l0SHViIHJlcG9zaXRvcnkuDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNv
bT4NCj4gPiAtLS0NCj4gPiAgIHRlc3RzL2Z1bmN0aW9uYWwvdGVzdF9hYXJjaDY0X2FzcGVlZC5w
eSB8IDkgKysrKystLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL3Rlc3RzL2Z1bmN0aW9uYWwvdGVz
dF9hYXJjaDY0X2FzcGVlZC5weQ0KPiA+IGIvdGVzdHMvZnVuY3Rpb25hbC90ZXN0X2FhcmNoNjRf
YXNwZWVkLnB5DQo+ID4gaW5kZXggOTU5NTQ5OGFjZS4uZjNkN2M4MzMxYSAxMDA3NTUNCj4gPiAt
LS0gYS90ZXN0cy9mdW5jdGlvbmFsL3Rlc3RfYWFyY2g2NF9hc3BlZWQucHkNCj4gPiArKysgYi90
ZXN0cy9mdW5jdGlvbmFsL3Rlc3RfYWFyY2g2NF9hc3BlZWQucHkNCj4gPiBAQCAtMjcsMTQgKzI3
LDE1IEBAIGRlZiBkb190ZXN0X2FhcmNoNjRfYXNwZWVkX3Nka19zdGFydChzZWxmLCBpbWFnZSk6
DQo+ID4gICAgICAgICAgIHdhaXRfZm9yX2NvbnNvbGVfcGF0dGVybihzZWxmLCAnIyMgTG9hZGlu
ZyBrZXJuZWwgZnJvbSBGSVQNCj4gSW1hZ2UnKQ0KPiA+ICAgICAgICAgICB3YWl0X2Zvcl9jb25z
b2xlX3BhdHRlcm4oc2VsZiwgJ1N0YXJ0aW5nIGtlcm5lbCAuLi4nKQ0KPiA+DQo+ID4gLSAgICBB
U1NFVF9TREtfVjkwM19BU1QyNzAwID0gQXNzZXQoDQo+ID4gLQ0KPiAnaHR0cHM6Ly9naXRodWIu
Y29tL0FzcGVlZFRlY2gtQk1DL29wZW5ibWMvcmVsZWFzZXMvZG93bmxvYWQvdjA5LjAzL2FzdA0K
PiAyNzAwLWRlZmF1bHQtb2JtYy50YXIuZ3onLA0KPiA+IC0NCj4gJzkxMjI1ZjUwZDI1NWUyOTA1
YmE4ZDhlMGM4MGI3MWI5ZDE1N2MzNjA5NzcwYzdhNzQwY2Q3ODYzNzBkODVhNzcnDQo+ICkNCj4g
DQo+IA0KPiBXZSBuZWVkIHRvIGtlZXAgdGhlIEFTU0VUX1NES19WOTAzX0FTVDI3MDAgZGVmaW5p
dGlvbiBmb3IgcHJlLWNhY2hpbmcgdGhlDQo+IGFzc2V0cy4gU2VlIDoNCj4gDQo+IGh0dHBzOi8v
cWVtdS5yZWFkdGhlZG9jcy5pby9lbi92OS4yLjAvZGV2ZWwvdGVzdGluZy9mdW5jdGlvbmFsLmh0
bWwjYXNzZXQtaGENCj4gbmRsaW5nDQo+IA0KV2lsbCByZXdvcmsgZnVuY3Rpb25hbCB0ZXN0Lg0K
VGhhbmtzIGZvciB5b3VyIHJldmlldyBhbmQgc3VnZ2VzdGlvbi4NCkphbWluDQo+IA0KPiBUaGFu
a3MsDQo+IA0KPiBDLg0KPiANCj4gDQo+ID4gKyAgICBkZWYgZXh0cmFfYXNwZWVkX2FyY2hpdmUo
c2VsZiwgdmVyc2lvbiwgZmlsZSwgY2hlY2tzdW0pOg0KPiA+ICsgICAgICAgIHVybCA9DQo+ICdo
dHRwczovL2dpdGh1Yi5jb20vQXNwZWVkVGVjaC1CTUMvb3BlbmJtYy9yZWxlYXNlcy9kb3dubG9h
ZCcNCj4gPiArICAgICAgICBzZWxmLmFyY2hpdmVfZXh0cmFjdChBc3NldChmJ3t1cmx9L3t2ZXJz
aW9ufS97ZmlsZX0nLA0KPiA+ICsgZid7Y2hlY2tzdW19JykpDQo+ID4NCj4gPiAgICAgICBkZWYg
dGVzdF9hYXJjaDY0X2FzdDI3MDBfZXZiX3Nka192MDlfMDMoc2VsZik6DQo+ID4gICAgICAgICAg
IHNlbGYuc2V0X21hY2hpbmUoJ2FzdDI3MDAtZXZiJykNCj4gPg0KPiA+IC0gICAgICAgIHNlbGYu
YXJjaGl2ZV9leHRyYWN0KHNlbGYuQVNTRVRfU0RLX1Y5MDNfQVNUMjcwMCkNCj4gPiArICAgICAg
ICBzZWxmLmV4dHJhX2FzcGVlZF9hcmNoaXZlKCd2MDkuMDMnLCAnYXN0MjcwMC1kZWZhdWx0LW9i
bWMudGFyLmd6JywNCj4gPiArDQo+ID4gKw0KPiAnOTEyMjVmNTBkMjU1ZTI5MDViYThkOGUwYzgw
YjcxYjlkMTU3YzM2MDk3NzBjN2E3NDBjZDc4NjM3MGQ4NWE3NycNCj4gKQ0KPiA+DQo+ID4gICAg
ICAgICAgIG51bV9jcHUgPSA0DQo+ID4gICAgICAgICAgIHVib290X3NpemUgPQ0KPiA+IG9zLnBh
dGguZ2V0c2l6ZShzZWxmLnNjcmF0Y2hfZmlsZSgnYXN0MjcwMC1kZWZhdWx0JywNCg0K

