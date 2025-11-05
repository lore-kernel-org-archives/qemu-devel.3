Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C13FCCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 10:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGaqw-0001Wr-Aj; Wed, 05 Nov 2025 05:34:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vGaqr-0001Vv-SO; Wed, 05 Nov 2025 05:34:53 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vGaqo-0007kg-Lq; Wed, 05 Nov 2025 05:34:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUOCdHtYbUYG/h44gwvdKrFCCj0SouzZIJhutwfmdAAXPxQUBHzGU8Jg22Z2s0sdLLhOwrmyhkUbwcTFWnomqDONNxQACfM1Ia3RMBZWxuRGiRL1QxvlDk6ibNXYNxUaZwgGGMy8Fju+GId3gWPJ0k3U6ATvlYJRX2rtMSsLB4VZqLM01OyinTf2vgrshpmu/cWIbQhNnSCUW7+3NAWE3tpLK1Shj5Cu3lmYjfYo6Ii/vEV+QSz7Vow8bYE7wUiFqJovp+POBX3slitF+u0YBoy9KX4i6JGg5ac7KtTLKdTwGmFkYAHaFpmDZK9pBSL1WuPjmJr6zy/+fo8NcpdGLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuANzBovgZNBpRL4bn+vpyDYjzCQQmuWSTyKIXkrTmE=;
 b=i0bAP0NH37mEySRAmPx1qpJwhG3lhHzzaGhr0agSdRDWIDuCP8dxsVD1GsofLHBDdAWmDdq8M+U0ooes7wSfSbbfvR+qsRFheAhyDAj+G67hJV3aaGaKyvXZVUj+vAYGW+BTaY8GzKB07F35Q0kCvbHXpuyGOwoQFEPDpuv4UwVTkTlsdlOqYV+ItMkFgBOBB8+XACTAC2oGbJr1lo+YmfjwEwZ9PxAMlJvrF6PvMRTLmpZA+96sHuvUmzbGcx8UFfEUmGPqv0yLoLEBxrZqGYNsMSlbI3c0GE3BXwfqZrKC62In/s0WwlLkk+Mnlqi6zK+t3I9ZdzT1wnlLUoEnNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuANzBovgZNBpRL4bn+vpyDYjzCQQmuWSTyKIXkrTmE=;
 b=aZKPahlxB6JQvZOQ0y8dwiQGFFUJpcWj/VQNdsXFcYdqfiM9Eej4ajfDgVq8RbslREb7Fu3AmLQysQkENop02gdO2ct03rJejTUuv1OTsKMWfmHXoNmZTeU2sfWJt2259y2/nmc0Vs5dwqqAgE2Xt3Hh7UOs3kheT/nDKKUXdtQJjklxvPkbk9kn+867e8Se3/UHrj6rAnz5exA+CgZ3RevtXxXRljOKbQEtroSUSjSgJ6UDhHrVcAkncy38IDymXBZ8EiBaT8TzFObFHx2l5x/QSpX5Z+FXFNwF3RaQ6/GEK5hsKQgNyCfsJ29wB8f6dZ4cnT0HTSGTwjrV5n/+EQ==
Received: from SEZPR06MB7619.apcprd06.prod.outlook.com (2603:1096:101:249::5)
 by SE3PR06MB7981.apcprd06.prod.outlook.com (2603:1096:101:2eb::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 10:34:43 +0000
Received: from SEZPR06MB7619.apcprd06.prod.outlook.com
 ([fe80::8ee8:6bc3:1cd7:9020]) by SEZPR06MB7619.apcprd06.prod.outlook.com
 ([fe80::8ee8:6bc3:1cd7:9020%6]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 10:34:43 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v2 00/17] hw/arm/aspeed: AST1700 LTPI support and device
 hookups
Thread-Topic: [PATCH v2 00/17] hw/arm/aspeed: AST1700 LTPI support and device
 hookups
Thread-Index: AQHcTgiII/qWo2DjcEmFwqeBHb2lu7Tj4WgAgAAAYsA=
Date: Wed, 5 Nov 2025 10:34:42 +0000
Message-ID: <SEZPR06MB7619A8B0B31C3BF642BEECDAF7C5A@SEZPR06MB7619.apcprd06.prod.outlook.com>
References: <20251105035859.3709907-1-kane_chen@aspeedtech.com>
 <5e69d550-fc52-43e0-9437-cc8600fc65c7@redhat.com>
In-Reply-To: <5e69d550-fc52-43e0-9437-cc8600fc65c7@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7619:EE_|SE3PR06MB7981:EE_
x-ms-office365-filtering-correlation-id: ef5e008a-3c13-4c79-c3d4-08de1c56eea7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|13003099007; 
x-microsoft-antispam-message-info: =?utf-8?B?UE9QdlJ3WWMzVFE0WW94Y1BNWG5vVVFKT3ZOS0pZYldkK0piTm9CZkczRWxN?=
 =?utf-8?B?VkVrYjBkUUkrWUQzT3pLbmZ2Ni9aZUN6Y0xZQkhlclY4T3REVzR6TWJJQzM0?=
 =?utf-8?B?Z0h5dVZXZmg2bXVjV3VpRWVJamVCK2ttam1VYS9WdVNTSzMvOG03TjVpd2p5?=
 =?utf-8?B?UmdFUGNlLys1T3lxT1BwV1FNcjFEZnBNcSs1WVB2Sy82aEIvRVIwTkFpVEhr?=
 =?utf-8?B?OVF6QVhtTmQ0TXNpb09YUzIwZFh2NkJ6SXQwNVJrbVovSEVmZ2FieU5ST05D?=
 =?utf-8?B?SDdKcDVCZWFvbUZSbGowNTBWSXlXWnFqT0JHUTkyMGdxZ0NUZkJObWJEMnJC?=
 =?utf-8?B?cmt4RE9keHBnaHhiMW02emRUWlJISFFSamFMcWl6L0UwR0drNG9JbGFCVExK?=
 =?utf-8?B?a1JGbmQwMWVWdDNSa0NNcU1idG9VODY0cFFKQ3BvVnZnb1lDQkMrbHMxSHBP?=
 =?utf-8?B?eVRXSVBaaFpXQ0JkTEFaa2tVTFZZajRlYUh6UU9zNUhLNFB1OUh2TngwcGll?=
 =?utf-8?B?VGlpSXBRbE5rdU55a0R2ZUxMTWRYRVF1RVQvTTJiblJqYTFzN1I3QXRlbkpZ?=
 =?utf-8?B?Y2VheE1ZaVo2aG9pMEdkMTF0M1dvbkZpR1VncUtZYktzM0pRWHJ2b3MreTBy?=
 =?utf-8?B?UWx3U1hsK1lHcVFJWFFJQzBPU2pJWitQVTExUGVrQ1Z0NjNMMjlnYWMrc1lp?=
 =?utf-8?B?NEQyZmJEalBydmN5K2Y5N1ZXaG0zbHladEU4V25SMTg1bGFQVXJUL1RkV1N6?=
 =?utf-8?B?SWRyMDFYQ2ttQmxTcDVGLzZ2MTVFamhYa0J1VTRocm54V1F4cVVSejY3Qllh?=
 =?utf-8?B?azJnbWNjcTNHOGIyc0dIRXZCci8reWtZOTMvYmFPU3hNQ0F5dTllUkMycWdo?=
 =?utf-8?B?VHl0TzNZczFkQ2MrY1E2b3F2YTZsWmFJWWlaajRaS2RGMUdGVEExTk5sVWhv?=
 =?utf-8?B?TlhUdTBtVlBWSU1aMU9OczBjbzJITzlJQUoxdDNqYkhwSnBzcEEwYk1oSmty?=
 =?utf-8?B?S2Y1U3VvME1zdlUyaEE2V3Vld1BlYmZ5eUdsS29mQjhtQlJ2MHBpNXIyMll3?=
 =?utf-8?B?c0F5VjdlYTZuMnpITFd4R2MyaXNBQ2hkWG8rUVFTc3lHSFdBbC9Oekpjam5x?=
 =?utf-8?B?NDdpN0k1YTlGRFhmVHR5aGNsRFFrdlhWQklhWHRGeS9BWGR0Zkt0eDFNWlFj?=
 =?utf-8?B?VTFjYXJMS2xjWHplVm1TMDFULyttODduNXJGQkVTTzJJd3VsNEp6RW9FVWNW?=
 =?utf-8?B?b1lEUVZlM21SSmxRdWk0OFFJVEJpSmhUQnJ3QjhvWUQ4Y3V6NTVCWGtCcDIv?=
 =?utf-8?B?c2VkL3pPVDFGbzFGUzQ3eDErRW1wanFQYzNFUTE3TW12STRLc3g1YTJkVnRo?=
 =?utf-8?B?elBGRkNHbndJZ0d4SVdjS0RseHRITTdmVWE1ekZDWm1uTEttU1RmNVROY0hh?=
 =?utf-8?B?Qi9heUpDL1lsL1ZJTlBYc29TNUZWbUM2djBXRnFsVVM2WGJnZFJ1bUYwaCtL?=
 =?utf-8?B?a01va1A0TzIwMDEwZ2d6dGtoWGhQRkhMUmpqUzNQZUJLcUV0TWRISWFiMDRQ?=
 =?utf-8?B?S1VYcHBLRVdwY2NZM2VoUGd1TmorZDZNcHk3YnpCSDRVblUxcklWNE5XcHYv?=
 =?utf-8?B?aDluNnozdzV4OE1kd0s3Sk84VDd1NDdqZG9rZ1dFMXZydGFXREMveERHZkYx?=
 =?utf-8?B?NkRBek1pWGZDWVpycjczczVHdVluYjIwQnJCcXFHOVFQSEJkVUxBNkJyUFFO?=
 =?utf-8?B?eVRHdEU1V1lBMk5FQVhOUXdkSUFFb3FIMDhRMVV1RTNkQXlkSGR6VXBQVEpJ?=
 =?utf-8?B?ZmpFMGliWHlhRGJKbDZ6VUtXWHlvNzNPenVTMUxsMWc2bVROVlY0N1R5M1Rr?=
 =?utf-8?B?T003MmN0Skx4LytxSnVGNndIUHNXMW5ZaHczR2J3STRaZzZ0eEhTQkRPZFFn?=
 =?utf-8?B?MVg5N21ySzdXVXJoVVQ5QlB4eVVXekkvRU15cUZ6KzkvY3I5QW52Y29zVXdV?=
 =?utf-8?B?N2llVDhWVVVQTTZjSmJ2dGlkUC80TlAwU0lqbTVmWVA0OG4vSDl4NzNWdVp1?=
 =?utf-8?Q?FxWvTo?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR06MB7619.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(13003099007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjQvTFp0akpkd1AwZUpTaG1OUHE3TVVVTXFoTXpSS2RmNkZZNFpDMURUQitE?=
 =?utf-8?B?UGh2bUNxbjBXbG95WFZEYlVGcUYvRXowV0VGSjB3bld5YW9pV3NqQnZTTFd1?=
 =?utf-8?B?SldhU2RDbTNaOXYxUWNBWGtaQTBYeVBsRXBEZXIrRXRsWTI2SWQ3TklZdHNp?=
 =?utf-8?B?Y1pBa2NpdVl1cWhYS1BRQThoVmZwNjBQSWN0ZFVnMGkwL2FQeGlJeThaeGw2?=
 =?utf-8?B?NXVIRENvMGp6YTgycGljUjluU1pUR0hzbHlWbDYvMnJUZUNLRWtQRVhXTUY5?=
 =?utf-8?B?dG1DWmhsd3Z3NEFDdkVLM2trMVNnZDNLZ0FrT0JDSURxTkZnZ05mWTVLODM4?=
 =?utf-8?B?T0pRcDRMa1JKRWNkMTRybVZoekM2dWsreE82MHJOd0cyc2dvTWZUbW9QeDMz?=
 =?utf-8?B?TkhyRmppaWZ2dllMVkRPNlFhVTRNNGlGV1pTUEwvS3JBcWE1K1h4aGtXck5P?=
 =?utf-8?B?b3BqT2RzdDMyQkYrOU9acHVmS0Y2WlJiZldxcm5OUkQ0ZjlsQWluTWwxcWcy?=
 =?utf-8?B?b1d6VklESU9ZcGd3cGdDYmV2VlhnK04rL2s2R1pZTEszOWVSa2tOZXJBNjRw?=
 =?utf-8?B?MTA1VHpFN0R6VTY4dTV3R2orYlI2VEdPQTJsRTc0WkpFVWNOSEMxdlIyS3JY?=
 =?utf-8?B?dmZMQWhaNzh4U2JCcVNxNzFQTVNqbVNhYTQvanlpMzloTVlMVDUybEs1S2ZF?=
 =?utf-8?B?TXNsSlI3ZzZybWZDZUcvU0QxbVZBTFd3eFlkb2NYYW9kL3VsbytvbjdsM05U?=
 =?utf-8?B?ZXd1dU51Z2lrUnJpM0lWckJmWUVwKzF4VFNaQThoQ3RiTjNrME9SS2ZJSUtn?=
 =?utf-8?B?aENjWi9CTldJUXhuREVZWW1xbUJFWWkvSFVYSXRrSWdGQ2hETTdINnZTYlZJ?=
 =?utf-8?B?MGFqMmdCZjhmN1FrL0J2TDFJWWpNQStYMjV6TlVDSi9mTUk5MkVLTmNwb2tE?=
 =?utf-8?B?a09WU1RGbTVHWm9kYVQrZFVmb3NFY3ZmbWx3K2t2UzVSdkJrUzlGL05zVU9C?=
 =?utf-8?B?dGE2OXpVcWhIUkNLWm9waVVWMUtzT3ZEZitoN0NKaFF6clAwMkhiUDU5cW16?=
 =?utf-8?B?c3lIb1hWdHpOQXIra0V5N0R1NVRQYnordGlSRUx5c0ZrTEVvK2dhaTdLR1Mz?=
 =?utf-8?B?RnlONDNZV3JCbWR5V1dFSExxZ2YzQ2tyaXdsdEk0NGN5YU8zUGE2QTgwbHY1?=
 =?utf-8?B?bHhIK2JPLzZxMVYrK0xHMDdOWDlQWm1YRURvZzBjbHF4T3BGRDE1MUFnNFEz?=
 =?utf-8?B?NTUyQXdkaVVpOWY3dGJyVE10OG1TSTVrM1MwcEJ2VEpuTGlkZE1uaFg4S2pQ?=
 =?utf-8?B?TkQ2MmpPN3gzQVhnQUo2SGRoS1I0T0xhNWlJaDhFbEw2VkFNRjRPRFNtSElC?=
 =?utf-8?B?RFdDUFh0N3Vzb0xkeUZJT2IyRmRGNm5aOUxMQkpmUTlJK2VEeFpkK3drUG5K?=
 =?utf-8?B?dldiTS9uUkgraGhrS0pTUjU0M1R2V2RieVBrWU1wemRTbWE3R3ZvOWVDYUVZ?=
 =?utf-8?B?UmVzM0tHSXdqSDJRSkxTVGVkbEtMVHlzcXJtVktJVXB1NjNqZFVJc2VKZHNO?=
 =?utf-8?B?cWd5SWl1aVFKanUycURQeE54bHdSd3U1UFRpdE14Rnh0UndtWHhaUkgxcHRZ?=
 =?utf-8?B?NFNMZ25IMGp5TDhMOHE1Vm9EWmhPK2JHNEl0dU1TMytNM3MzN2Jsa0xSRnhj?=
 =?utf-8?B?VWRjeTJ5Y2FKSkJ2ZHJJckloeGFDUDNQbW1jcytOY2k0VEl4UmsvK1ljV2VY?=
 =?utf-8?B?eXo4MFFCZS9jeWhvLzVUTm93dVBtOGNUZGhRK2V4K3E3dFRXZ2VvMTNKdUFr?=
 =?utf-8?B?cE5MQlN6NFBLa0pMZFJXZGNwQVJaNzdxWnhEOWU4T1NONEhSWWlXSmRZWjFn?=
 =?utf-8?B?RjFFQmIwRmZldVRIZTZ2QUN1TmFiRjhMSnhXeVFmY3owTHZYUTNubDA4eVVm?=
 =?utf-8?B?MmNCd3UvdGhXYWZPNEJMaDUyTE0ySzNITmpsS3diR3RVNFE0UThwNUwycVdy?=
 =?utf-8?B?WlJKckF0RGpidEpFWW5sRy9Rb0g5MWhpSmZUTkczUWdSaWlyWFpZandOd2U4?=
 =?utf-8?B?d2JCUm1EVEkxSmhGbDZEdlFMQ0NjOXBNWHJxejJnNjlhU0J0TXNqSzFZck9T?=
 =?utf-8?Q?FpxLuiWQ0tYOVKOtSCbx36vch?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7619.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5e008a-3c13-4c79-c3d4-08de1c56eea7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 10:34:42.9637 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LpUeEwvcghKy546sfr/pA1XwpJ7la23oYWIyxFT3ucGUX3t5myFAQSOEH/31JRCs1JQgIFveV6TsVtOWVbOSw11vMY/H0+YJgBcmA3G5A9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB7981
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=kane_chen@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

SGkgQ8OpZHJpYywNCg0KSSBoYXZlbid0IHJ1biB0aGUgIm1ha2UgY2hlY2siIG9yICJtYWtlIGNo
ZWNrLWZ1bmN0aW9uYWwiIHRlc3RzIHlldCwgYnV0IEkgZGlkIHZlcmlmeSB0aGF0IFFFTVUgY291
bGQgYm9vdCB0aGUgb2ZmaWNpYWwgaW1hZ2UgcHJvcGVybHkgYWZ0ZXIgYXBwbHlpbmcgZWFjaCBw
YXRjaC4NCkknbGwgcnVuIHRoZSB0ZXN0cyBzb29uLCBhbmQgaWYgSSBmaW5kIGFueXRoaW5nLCBJ
J2xsIGxldCB5b3Uga25vdy4NCg0KQmVzdCBSZWdhcmRzLA0KS2FuZQ0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+
DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgNSwgMjAyNSA2OjI3IFBNDQo+IFRvOiBLYW5l
IENoZW4gPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT47IFBldGVyIE1heWRlbGwNCj4gPHBldGVy
Lm1heWRlbGxAbGluYXJvLm9yZz47IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5j
b20+OyBUcm95DQo+IExlZSA8bGVldHJveUBnbWFpbC5jb20+OyBKYW1pbiBMaW4gPGphbWluX2xp
bkBhc3BlZWR0ZWNoLmNvbT47IEFuZHJldw0KPiBKZWZmZXJ5IDxhbmRyZXdAY29kZWNvbnN0cnVj
dC5jb20uYXU+OyBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1PjsNCj4gb3BlbiBsaXN0OkFT
UEVFRCBCTUNzIDxxZW11LWFybUBub25nbnUub3JnPjsgb3BlbiBsaXN0OkFsbCBwYXRjaGVzIEND
DQo+IGhlcmUgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gQ2M6IFRyb3kgTGVlIDx0cm95X2xl
ZUBhc3BlZWR0ZWNoLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwMC8xN10gaHcvYXJt
L2FzcGVlZDogQVNUMTcwMCBMVFBJIHN1cHBvcnQgYW5kDQo+IGRldmljZSBob29rdXBzDQo+IA0K
PiBPbiAxMS81LzI1IDA0OjU4LCBLYW5lIENoZW4gd3JvdGU6DQo+ID4gRnJvbTogS2FuZS1DaGVu
LUFTIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+DQo+ID4NCj4gPiBIaSBhbGwsDQo+ID4NCj4g
PiBMVFBJIChMVkRTIFR1bm5lbGluZyBQcm90b2NvbCAmIEludGVyZmFjZSkgaXMgZGVmaW5lZCBp
biB0aGUgT0NQDQo+ID4gREMtU0NNDQo+ID4gMi4wIHNwZWNpZmljYXRpb24gKHNlZSBGaWd1cmUg
Mik6DQo+ID4gaHR0cHM6Ly93d3cub3BlbmNvbXB1dGUub3JnL2RvY3VtZW50cy9vY3AtZGMtc2Nt
LTItMC1sdHBpLXZlci0xLTAtcGRmDQo+ID4NCj4gPiBMVFBJIHByb3ZpZGVzIGEgcHJvdG9jb2wg
YW5kIHBoeXNpY2FsIGludGVyZmFjZSBmb3IgdHVubmVsaW5nIHZhcmlvdXMNCj4gPiBsb3ctc3Bl
ZWQgc2lnbmFscyBiZXR3ZWVuIHRoZSBIb3N0IFByb2Nlc3NvciBNb2R1bGUgKEhQTSkgYW5kIHRo
ZQ0KPiA+IFNhdGVsbGl0ZSBDb250cm9sbGVyIE1vZHVsZSAoU0NNKS4gSW4gRmlndXJlIDIgb2Yg
dGhlIHNwZWNpZmljYXRpb24sDQo+ID4gdGhlIEFTVDI3eDAgU29DIChsZWZ0KSBpbnRlZ3JhdGVz
IHR3byBMVFBJIGNvbnRyb2xsZXJzLCBhbGxvd2luZyBpdCB0bw0KPiA+IGNvbm5lY3QgdG8gdXAg
dG8gdHdvIEFTVDE3MDAgYm9hcmRzLiBPbiB0aGUgb3RoZXIgc2lkZSwgdGhlIEFTVDE3MDANCj4g
PiBjb25zb2xpZGF0ZXMgSFBNIEZQR0EgZnVuY3Rpb25zIGFuZCBtdWx0aXBsZSBwZXJpcGhlcmFs
IGludGVyZmFjZXMNCj4gPiAoR1BJTywgVUFSVCwgSTJDLCBJM0MsIGV0Yy4pIG9udG8gYSBzaW5n
bGUgYm9hcmQuDQo+ID4NCj4gPiBCZWNhdXNlIHRoZSBBU1QxNzAwIGV4cG9zZXMgYWRkaXRpb25h
bCBJL08gaW50ZXJmYWNlcyAoR1BJTywgSTJDLCBJM0MsDQo+ID4gYW5kIG90aGVycyksIGl0IGFj
dHMgYXMgYW4gSS9PIGV4cGFuZGVyLiBPbmNlIGNvbm5lY3RlZCBvdmVyIExUUEksIHRoZQ0KPiA+
IEFTVDI3eDAgY2FuIGNvbnRyb2wgYWRkaXRpb25hbCBkb3duc3RyZWFtIGRldmljZXMgdGhyb3Vn
aCB0aGlzIGxpbmsuDQo+ID4NCj4gPiBUaGlzIHBhdGNoIHNlcmllcyBpbnRyb2R1Y2VzIGEgYmFz
aWMgTFRQSSBjb250cm9sbGVyIG1vZGVsIGFuZCB3aXJlcw0KPiA+IGl0IGludG8gdGhlIEFTVDI3
eDAgU29DLiBJdCBhbHNvIGFkZHMgdGhlIEFTVDE3MDAtc3BlY2lmaWMgTFRQSQ0KPiA+IGV4cGFu
ZGVyIGRldmljZSBhbmQgZ3JhZHVhbGx5IGNvbm5lY3RzIGNvbW1vbiBwZXJpcGhlcmFscyBvbiB0
aGUNCj4gQVNUMTcwMCBtb2RlbC4NCj4gPiBGb3IgYmxvY2tzIHRoYXQgYXJlIG5vdCB5ZXQgZnVu
Y3Rpb25hbGx5IGltcGxlbWVudGVkIChJM0MsIFNHUElPTSwNCj4gPiBQV00pLCB0aGVpciBNTUlP
IHJlZ2lvbnMgYXJlIG1vZGVsZWQgYXMgdW5pbXBsZW1lbnRlZCBkZXZpY2VzIHRvDQo+ID4gcmVz
ZXJ2ZSBhZGRyZXNzIHNwYWNlIGFuZCBtYWtlIHRoZSBtaXNzaW5nIGZ1bmN0aW9uYWxpdHkgZXhw
bGljaXQsDQo+ID4gZW5zdXJpbmcgdGhhdCBndWVzdCBwcm9iaW5nIHJlbWFpbnMgc3RhYmxlLg0K
PiA+DQo+ID4gSW4gdGhlIG9mZmljaWFsIHJlbGVhc2UgaW1hZ2VzLCB0aGUgQVNUMTcwMCBmdW5j
dGlvbnMgYXJlIG5vdCBpbmNsdWRlZA0KPiA+IGJ5IGRlZmF1bHQuIFRvIHRlc3QgdGhlIEFTVDE3
MDAtcmVsYXRlZCBmdW5jdGlvbmFsaXR5LCBwbGVhc2UgaW5jbHVkZQ0KPiA+IHRoZSBmb2xsb3dp
bmcgRFRTIGZpbGVzIGZvciBwcm9iaW5nOg0KPiA+DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9Bc3Bl
ZWRUZWNoLUJNQy9saW51eC9ibG9iL2FzcGVlZC1tYXN0ZXItdjYuNi9hcmNoL2ENCj4gPiBybTY0
L2Jvb3QvZHRzL2FzcGVlZC9hc3BlZWQtbHRwaTAuZHRzaQ0KPiA+DQo+IGh0dHBzOi8vZ2l0aHVi
LmNvbS9Bc3BlZWRUZWNoLUJNQy9saW51eC9ibG9iL2FzcGVlZC1tYXN0ZXItdjYuNi9hcmNoL2EN
Cj4gPiBybTY0L2Jvb3QvZHRzL2FzcGVlZC9hc3BlZWQtbHRwaTEuZHRzaQ0KPiA+DQo+ID4gQWZ0
ZXIgaW5jbHVkaW5nIHRoZXNlIERUUyBmaWxlcyBpbiB0aGUgQk1DIGltYWdlLCB5b3UgY2FuIHZl
cmlmeSBMVFBJDQo+ID4gZnVuY3Rpb25hbGl0eSB1c2luZyB0aGUgZm9sbG93aW5nIHNjZW5hcmlv
czoNCj4gPg0KPiA+IDEuIEluIFUtQm9vdDoNCj4gPiAgICAgUnVuIHRoZSBsdHBpIGNvbW1hbmQg
dG8gdHJpZ2dlciB0aGUgTFRQSSBjb25uZWN0aW9uIGFuZCBkaXNwbGF5IHRoZQ0KPiA+ICAgICBj
dXJyZW50IGNvbm5lY3Rpb24gc3RhdHVzLg0KPiA+IDIuIEluIEJNQyBMaW51eDoNCj4gPiAgICAg
UnVuIGkyY2RldGVjdCAteSA8MTYtMzg+IHRvIHNjYW4gYW5kIHRlc3QgdGhlIEkyQyBidXNlcyBl
eHBvc2VkIGJ5DQo+ID4gICAgIHRoZSBBU1QxNzAwLg0KPiA+DQo+ID4gQW55IGZlZWRiYWNrIG9y
IHN1Z2dlc3Rpb25zIGFyZSBhcHByZWNpYXRlZCENCj4gPg0KPiANCj4gVGhhbmtzIGZvciB0aGUg
dXBkYXRlLiBUaGUgbW9kZWxzIGxvb2sgYmV0dGVyLiBMZXQncyBjb25zaWRlciB0aGVtIGZvciBR
RU1VDQo+IDExLjAuDQo+IA0KPiANCj4gRGlkIHlvdSBydW4gIm1ha2UgY2hlY2siIGFuZCAibWFr
ZSBjaGVjay1mdW5jdGlvbmFsIiA/DQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KDQo=

