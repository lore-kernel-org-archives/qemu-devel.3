Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A19E83EE4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 07:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnX9a-0006jv-AV; Wed, 04 Feb 2026 02:18:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZE-0004aC-54; Wed, 04 Feb 2026 01:40:48 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZC-0004HR-K2; Wed, 04 Feb 2026 01:40:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vYbmt7RFCm3ELq1KuCduGJ/i2sBu9WZxhR2ukIpwz6dlWN5lLdFqxGIXYz4/3xQyZYv4GImHbSCEUnCBrxzzBXgotb4v9pAQaAQrXajFb1sOh8EN1chTL5fxS/gC3/7SQkXbif/E/VVjuE0+UUqnlPtg6oFeWVEPp21VwflGj5GnVHjoleiJKRUS7LFVvAy5oU1GuF1CNr4nJM2MkSey79a8jF8rFIRkbyj+zX0bE2fvNXt1ToHUoVHUDzstloRGYCXDwqHMiwyF0CFK/km0zLrcYrnzsU3dLXqdEYsJz0GW8i0/1cvgSMyqzq/EswpJi/huXWKIUcuuB9rt2V3BFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Um7DX4QWRH/BpAVzD8VDhMbe/MrC868IRXa9RghtQ/g=;
 b=NfCc0L+kw52dCzhjSu0L9iuNvFvH6JmzQHntXtlyqXgw7fl7ahas1qUkDUO/9b4YzDvdD6lOrZtMWzb8PMZgVVDR7RxmVpSxQV2PD2WVTpoP1iIVtty0kBbDr8US7JML5+25Ey2OcMHz79eF3r5gHqu6rebp/1KZtCbEe8UVCeigh7OX7fluidrty36EdaFmL4BjFFTRZNcNPRzN1hyX54UqzRhhE3Utf7GwfWC3UKfnzpm9Rycon0RumWO5DQ8mmqdK0i5RYH0Y6lNVhagHutfupq4hm5jliQU1ulv3g+J43gnIkCVVCel9+ywU3BOAUae+2BoZE6Q1RfanR484Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Um7DX4QWRH/BpAVzD8VDhMbe/MrC868IRXa9RghtQ/g=;
 b=p8tA7O1rIXc8m2SVoAxk/bGbzeXqObzqBjiUy7iKMBFcvcp4+jtxKb6ArtqgW5yNhincX/crwH4oNvnZbETVfaFG/gagEbIaO48oIqMbchlmI8ZbR0dqB9nhD+wtStmhLGRqEP3Vhshnrwe6M9rMOCVaYCzqugTEFEU7+P96QvxA9GxsGGKpuBd5G1kOWwQ3adP8ioTfsnuPpY/4t8yxGi2JTVki2F0WE2h5sSxOF2hj24jqJ9r/qXQaua/hMshrMk9TzO6hsMpPn9zbwZAfZecD6pan8ZsStbxv0glnz0eGTFqZERnIdRsLYaEdfM+/fxcauQPbOtyfgP1mcBlO2A==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5901.apcprd06.prod.outlook.com (2603:1096:301:110::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 4 Feb
 2026 06:40:28 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 06:40:28 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Nabih Estefan
 <nabihestefan@google.com>
Subject: [PATCH v6 08/22] hw/arm/aspeed: Attach UART device to AST1700 model
Thread-Topic: [PATCH v6 08/22] hw/arm/aspeed: Attach UART device to AST1700
 model
Thread-Index: AQHclaEmSInOSF/takavkGUfvLuFow==
Date: Wed, 4 Feb 2026 06:40:28 +0000
Message-ID: <20260204064016.3515639-9-kane_chen@aspeedtech.com>
References: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB5901:EE_
x-ms-office365-filtering-correlation-id: 4e4565e2-2142-4755-56c3-08de63b84942
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?S0UwRjYvYUREM3RxMWQzQjU1L0NHSDFLZGFxS2RCdjc2SUFmb3U3MGN2d0tT?=
 =?utf-8?B?cXJ6SnVQa0VyYlI4ZGpTMHBVeU5XalJ6N1FNSEYwZEdEY2pqdHgwdkdFVERJ?=
 =?utf-8?B?eFJUeVZDaTRHeEZzWGRxYSt5TlVXaCtTRXE1YTdFaHhQVS9XU1BVaUw5Q2NC?=
 =?utf-8?B?UW5XWFYvTXlIczRrVFRubmk2OFVJK3pZVlVaeGQ3ZTdmVjJ6aFZUakM3VWtn?=
 =?utf-8?B?Y2tpWjVpcUlrNUJqZEVQY1Fwc1NUalRhNGgzVVRkUEVDR0JuVzdjcDAxaEs3?=
 =?utf-8?B?ZWdGWFh0Z0hLTFdhdXAwaGRSVVU5TFdSQW9RbktsWXpmc1kySmUxaGlnZ1ZW?=
 =?utf-8?B?Y3hwL3h4YWxkYXF5eHFuSVB5ZCtjRU5wa2MyTzgycW5QaW5zY0FBQmlSYVUv?=
 =?utf-8?B?cENNMGdQUHZRdzUveUFDSkp3Tk93VkJBSjlPOXphaUxvd1VrL3NDajRsaGNJ?=
 =?utf-8?B?Smx5RllMbG9QMzJicGRESitXSjdSMzcrK255bzY5ZUJsZExUdjluWGZpckVH?=
 =?utf-8?B?TTRzMXBFMWtFR2dxVHhRY2IvOWo3WDZIR3o1MkEwTll0eWRlNGo1RTFvdWpu?=
 =?utf-8?B?OGVLTnR4UFpDRlNJNlROK3ZwZEFEcFhGRjBtS1JyeER1UXptbTE1SVc4d0ps?=
 =?utf-8?B?L2ltd1NablVtcmg5RlAvREJmSm1RaVpONU9hYWJwbnRKNmlHMlYycVJpcTJ3?=
 =?utf-8?B?aUdmSkNrN1JkaDk0QlhUeTduWFBveGsrZWVLUW1rd3dVaitqcERPMVRTR3Jk?=
 =?utf-8?B?WE5QVG0zWFBLVmlwUmlBWmhVcy9aTFJ5WVg1Z2VEWDE4TTVyZEFmQ3ZLWS9O?=
 =?utf-8?B?M0NzT1lTd00wSGNNRUZMeVM3aXBEMVd2OS92eGF6RFFoWDlpc0NhRFhQQS9H?=
 =?utf-8?B?c2h2UkRQV1BEdjI3eGJ2VjRRWWM4QmdteGZrR2J0WXVtaDVLWGtSNVRqeDFw?=
 =?utf-8?B?eE1wZ0xLb1BYVEwwMkFOUGVlRTlPL0JZWGRjYTI0S2ZXUmsrU2lpdzNmYmE4?=
 =?utf-8?B?UEU5dFNqd0dEUFBwREU0T2lxWVNQVXhJUElMMlgvSlNXaFBWTWd1dGhoeW5K?=
 =?utf-8?B?bllvMEE0RUlNc0NoOGxFUEwxR3k0dnBtSWticnp3TlFlWTMxU0pBa2ZnajZj?=
 =?utf-8?B?QkJpV1Bac05Uci9zVjhKdzZBSlBvTTRRRTlVanR6aE8vY3EwQWY3YkVqMk5K?=
 =?utf-8?B?Y052a2g5V284VjF0a2w2bzZOWlJ1RXJ6bHhaQnFHdHpneDV3cWZDWEE5a2FT?=
 =?utf-8?B?aUVsUlpocUR1RiszVmozZWFBT0V5Z1kvbnhBa0NnbzZDaUtkYnRxUGZPY3pi?=
 =?utf-8?B?MlE3UmUyMlJGLyt0TlFhbnRiNWsycEN6ZWx2RVlIK3J0NmcwMy9rWFE5MmJy?=
 =?utf-8?B?Y2FWS3pMc0FiRjVZZGhudzVkT01zZWJKaS85d0ZWOU0zbEpZRS9zdXFTYitM?=
 =?utf-8?B?YURoaWdpc0gxM05FV1dLY3R1aGtsbEdoenlMWGx1bTZOaTVPejJ0TVpSeGQw?=
 =?utf-8?B?TmlESG1Cek1wSlE4WHM4ekxQdXU3N1VpM1NNMUpJMlpQWUIxNkw0dWxvUCtV?=
 =?utf-8?B?aEFJVis3aXFwbkZRelRQVjg2N2pCY0hnTzZnaEZQa3RtcTBCRmNvcEMrWWRP?=
 =?utf-8?B?VG1vZkFUb2lKK3JpRHRZeUdFb2RUc1R0UHVsME1VWEpMWVBVODYybVdOSjM4?=
 =?utf-8?B?STBDVVpqbnBZWDdkeEdCVHA5Zis0SDc5MldEZ0g3ZEhUYXNXZDdHZFZlSm1v?=
 =?utf-8?B?YW5RaElEdUpEZDJqeWJ3RUpzWVhmMVQ4L2RyemptMGplT2VnWmdJaFpIVnNY?=
 =?utf-8?B?anl1cUF1cFRmT1NmaUl5WW93cHNISmVVRlRzRU16Qmh5aldMS1pBWXROVlZz?=
 =?utf-8?B?Zms1b2RjQzdRTkRZRkNFRHkwK2RXbzl2bmlNVWI0SVBvQjZyb2NRVy9DNEJs?=
 =?utf-8?B?dGxicTBmRXZ1cENnQnJyV0F6elNwN3R1TGVFeC9HY29OaXBUTnJLT1JXTXlD?=
 =?utf-8?B?Sk5Kam9IQUNrVHNzcmhXTWU2UWFOS1ZEU0FqNi83MG56SGxGQWlIVlQ3cW9B?=
 =?utf-8?B?RmpxV21YRWlxM3ZpOXQzVSs5OGhRbnFrMU51eDBBWjhjZmwwalRpMzNlaTQ5?=
 =?utf-8?B?c2llQW1vemRJamZQMThjQ0k5Z2NqNUJaS0MwUFdnVDkvUEEzbTZwU2NCWm9t?=
 =?utf-8?Q?fR3qm+PXOG3CtgjEOCqpioc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjY0ZHcrOHdHMVhJcWJlR3l1VC9kYjBxQ1FvdlpTZGpRMzE2QTRPVis0K1dr?=
 =?utf-8?B?Qy95MVVIa1g2bVlPdDRvNFJJU21QYndoZ3NYaE9VL2hVSTN3SVAwUmFmWHlI?=
 =?utf-8?B?RDhwSks3Y0ZyNlpMR280Z08xM1hEZjRhdWtUOUZkK0JXRGlzRkcvZzM2YkpH?=
 =?utf-8?B?RTVFNEN0eUNZR2FMZTZ6c1JEUzdEUTU1Q0U3b1BGOHZOSXNSRm1paHBnRGwy?=
 =?utf-8?B?OG1pZlVxMHBHUmkwbGo3RkFTUXB6ZTZXUGZ5a3NKbFZ0L1hiM3Z2TmQwVFcz?=
 =?utf-8?B?UEYvRDJVRm1FdHc2bkRyWVZ6ZW02MUNZWC9ESzQxNGJRZFRQMmZlZCsxMXR4?=
 =?utf-8?B?cGhyTllBS29KRTNVcW0xZnBOTnlnbUdkdC9naUVJejAyQWlPbGNZSmJOR09O?=
 =?utf-8?B?U3VhVWt5ZU1xL2Z2d1haTytTejRVWVBwQ0hDRHhaVDBEUWsyMW4rWWI5bitV?=
 =?utf-8?B?NEhCRmpTQjFKMHhJOEduQnFrWHMvL1hCWUxnTDhuTzNlQzJlSTc3Tm9EdHl3?=
 =?utf-8?B?MkxlQVhBdFppMjdaK0NtMFlUQ2FES1FWcmFyV0N5ZGNJQzU2UmRsU0lMM1pU?=
 =?utf-8?B?c291bGtmYjNvZVpvbnYxUmRqSkw5dDBxZUZMUjNWUG4vNEM1Z3ovRU9pcG9I?=
 =?utf-8?B?WXRETENPaDB5Z1RnMVMzZ1RWN1ZqM3FjeGsrMHExT2Z4MU5YQTJ3NER2dkhG?=
 =?utf-8?B?ZzJZT3FaTUp3alZZVmlkMHM0Q3VaSi91UjFFaTFLTWx5UlJNam43QXdMYlhM?=
 =?utf-8?B?SlA0QktHbFhFMHFncHNSWkVxRVA2NTV4dHdBSUk4T3pwcFZRVTJ6Mk5EenB0?=
 =?utf-8?B?cWhpRk9mT3pmSlM3aHU3QkpZQng2TUtwTEhLcXM4cmVveHlwbnUxN1NmY3dt?=
 =?utf-8?B?WmFReUNyNUNxZ3NCYTNKajJHNHlTSWs1cSs1ODJ4azhPRUp0bkNYNzI5bElP?=
 =?utf-8?B?TzF0dmlIQWNmS0NwaFlwemk4bmE1RHFHVEZmVkdhSnBGeVpiZFlvTlY3UVk3?=
 =?utf-8?B?QnVxK056OUxhaW1rNjNQUEF4MjB0TEZIem5IaEM0QXhJTzlzN0VkUXgzdnZY?=
 =?utf-8?B?czJWT0JvN3ZWV1cwMERxR1pJdjhQcm9KK256VzMxOWs1UjJCWDRMYUJWcU15?=
 =?utf-8?B?SktneTd6ckQrcmh6bWZDYTUxNWM2Z1hzazdjVGdoZXQzVXdnemZIWTFUMzk3?=
 =?utf-8?B?NnU4d0xpbVJsOGM5VWswTWNCWTcvTFQwSVN3blVPMXc0azN2RDAxVUdDNVZN?=
 =?utf-8?B?ZGhaMXNDWWpBVHEyTXhZT0JwVFdIQk1ycC9EaCtSZnVud0VCL1lDdzloeHVn?=
 =?utf-8?B?dEFtSzk0M1JNTmxzNVZXZlpRWFR2c1RYWC9qMEN1RmZiSFM3eHNxbzBvMElP?=
 =?utf-8?B?UVFyQVB4TndDejk0U25GM3o5UHdNYjVNMFZhK3VGTjhTUVhlTlc2Ny9iMzRw?=
 =?utf-8?B?Y3VJejVXN1paS3Y1WGtYSXpyQWg3RkpQYk4rV1hVSUsreHEwa2w4Y1M3amtG?=
 =?utf-8?B?ZDRQT0g0WHlVSmpQWUplYnZ5c3dqaVZEa3NHNWpNREl0SDl0RUt0UFdIdkgx?=
 =?utf-8?B?VmVPeURkQnFvQWIyN2Q3SnRhOE9HYW9TVmRyc2pwc28yMUR2anFQMlJ0RzBC?=
 =?utf-8?B?anVteEhZSG1EUXhCWmxHd0dZQjU5emJmcE52M1N1am9jV2RFVVA1NjlobTBH?=
 =?utf-8?B?K0pHZVpZYVA5VkdCQUlLbmRLdVBrY2hWeTNBaDFwWjhyQ1A3ajNkNnJjWWxa?=
 =?utf-8?B?Q1laY2FBdGVhQ3NtMVpnMkJJQm1UWVp6N3hheUdURHZxWVc1bUd2dUN1amNr?=
 =?utf-8?B?TTkveUNFNkc5Q0ZlM3dPN2xZZjBhNlhnNVJGS1JQZmxBNkIvMitBRWpwSWkz?=
 =?utf-8?B?SDlUUDVMRkQ3dllpc0V5VENNQXhhQ3BORVRLY2dpYnlTU21CT0RKdVJabVJ5?=
 =?utf-8?B?cUtvMWR1ZGRRT08xK1dSREJXdUVYMFhqbkNpUVZEVFdvOTUvZnkwaiswWW8x?=
 =?utf-8?B?ME5mU1pib0hUVkRHa0NQOCsrKzMwb214azIxeEwyN2ZwcXpmc0tWKzR2UnR0?=
 =?utf-8?B?bU13aUcyR1M5QzVRQVdvZ05pQUh5VGFLRDQ4ZWVuV2JhSXIvdjc4TDJoVTU5?=
 =?utf-8?B?bC8yeG9tUnBlVnBBWE9tS3J0cmlyaHhvZlVTMWpHOXNlWUkwNnkyL0lsUXF5?=
 =?utf-8?B?eGo1cW9DdXpaZjVyYmgwUzdrTFdYWFI1WUQrbGREY3ZCbjVYVFdEWjRZNVcy?=
 =?utf-8?B?NDV6U3YxMlREa2I4bys2R3BSQ1p6ZmJ3bkx5cXM3L0VEeHkvLzUwc1RWaml6?=
 =?utf-8?B?Q0FFc0JWLzg2ajlxbXFJbFI1eE5jZmp2bW9WdDcvbVdrei9rOG5HZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4565e2-2142-4755-56c3-08de63b84942
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 06:40:28.6792 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YTi5/wwHVl1JlbxT/ddqhRJmeVt+CsPv3N7fC5VN57cc0k7epXYzAumyj2PNHhUTPHcBxZIKIdjGjK/MQHjfEVKsUJLIE5HEN04wxzl6Ax4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5901
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 04 Feb 2026 02:17:20 -0500
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

Q29ubmVjdCB0aGUgVUFSVCBjb250cm9sbGVyIHRvIHRoZSBBU1QxNzAwIG1vZGVsIGJ5IG1hcHBp
bmcgaXRzIE1NSU8KcmVnaW9uLgoKU2lnbmVkLW9mZi1ieTogS2FuZS1DaGVuLUFTIDxrYW5lX2No
ZW5AYXNwZWVkdGVjaC5jb20+ClJldmlld2VkLWJ5OiBD77+9ZHJpYyBMZSBHb2F0ZXIgPGNsZ0By
ZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogTmFiaWggRXN0ZWZhbiA8bmFiaWhlc3RlZmFuQGdvb2ds
ZS5jb20+ClRlc3RlZC1ieTogTmFiaWggRXN0ZWZhbiA8bmFiaWhlc3RlZmFuQGdvb2dsZS5jb20+
Ci0tLQogaW5jbHVkZS9ody9hcm0vYXNwZWVkX2FzdDE3MDAuaCB8ICAyICsrCiBody9hcm0vYXNw
ZWVkX2FzdDE3MDAuYyAgICAgICAgIHwgMTggKysrKysrKysrKysrKysrKysrCiAyIGZpbGVzIGNo
YW5nZWQsIDIwIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2FybS9hc3Bl
ZWRfYXN0MTcwMC5oIGIvaW5jbHVkZS9ody9hcm0vYXNwZWVkX2FzdDE3MDAuaAppbmRleCBhZGRl
YTNhYjFmLi5iMTViMTNhZWRkIDEwMDY0NAotLS0gYS9pbmNsdWRlL2h3L2FybS9hc3BlZWRfYXN0
MTcwMC5oCisrKyBiL2luY2x1ZGUvaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmgKQEAgLTEwLDYgKzEw
LDcgQEAKIAogI2luY2x1ZGUgImh3L2NvcmUvc3lzYnVzLmgiCiAjaW5jbHVkZSAiaHcvbWlzYy9h
c3BlZWRfbHRwaS5oIgorI2luY2x1ZGUgImh3L2NoYXIvc2VyaWFsLW1tLmgiCiAKICNkZWZpbmUg
VFlQRV9BU1BFRURfQVNUMTcwMCAiYXNwZWVkLmFzdDE3MDAiCiAKQEAgLTIxLDYgKzIyLDcgQEAg
c3RydWN0IEFzcGVlZEFTVDE3MDBTb0NTdGF0ZSB7CiAgICAgTWVtb3J5UmVnaW9uIGlvbWVtOwog
CiAgICAgQXNwZWVkTFRQSVN0YXRlIGx0cGk7CisgICAgU2VyaWFsTU0gdWFydDsKIH07CiAKICNl
bmRpZiAvKiBBU1BFRURfQVNUMTcwMF9IICovCmRpZmYgLS1naXQgYS9ody9hcm0vYXNwZWVkX2Fz
dDE3MDAuYyBiL2h3L2FybS9hc3BlZWRfYXN0MTcwMC5jCmluZGV4IGU0Yzg1NjVkM2YuLmY2MTBm
MjU5MzIgMTAwNjQ0Ci0tLSBhL2h3L2FybS9hc3BlZWRfYXN0MTcwMC5jCisrKyBiL2h3L2FybS9h
c3BlZWRfYXN0MTcwMC5jCkBAIC05LDE1ICs5LDE4IEBACiAjaW5jbHVkZSAicWVtdS9vc2RlcC5o
IgogI2luY2x1ZGUgImh3L2NvcmUvYm9hcmRzLmgiCiAjaW5jbHVkZSAicW9tL29iamVjdC5oIgor
I2luY2x1ZGUgImh3L2NvcmUvcWRldi1wcm9wZXJ0aWVzLmgiCiAjaW5jbHVkZSAiaHcvYXJtL2Fz
cGVlZF9hc3QxNzAwLmgiCiAKICNkZWZpbmUgQVNUMjcwMF9TT0NfTFRQSV9TSVpFICAgICAgICAw
eDAxMDAwMDAwCiAKIGVudW0geworICAgIEFTUEVFRF9BU1QxNzAwX0RFVl9VQVJUMTIsCiAgICAg
QVNQRUVEX0FTVDE3MDBfREVWX0xUUElfQ1RSTCwKIH07CiAKIHN0YXRpYyBjb25zdCBod2FkZHIg
YXNwZWVkX2FzdDE3MDBfaW9fbWVtbWFwW10gPSB7CisgICAgW0FTUEVFRF9BU1QxNzAwX0RFVl9V
QVJUMTJdICAgID0gIDB4MDBDMzNCMDAsCiAgICAgW0FTUEVFRF9BU1QxNzAwX0RFVl9MVFBJX0NU
UkxdID0gIDB4MDBDMzQwMDAsCiB9OwogCkBAIC0zMSw2ICszNCwxNyBAQCBzdGF0aWMgdm9pZCBh
c3BlZWRfYXN0MTcwMF9yZWFsaXplKERldmljZVN0YXRlICpkZXYsIEVycm9yICoqZXJycCkKICAg
ICAgICAgICAgICAgICAgICAgICAgQVNUMjcwMF9TT0NfTFRQSV9TSVpFKTsKICAgICBzeXNidXNf
aW5pdF9tbWlvKHNiZCwgJnMtPmlvbWVtKTsKIAorICAgIC8qIFVBUlQgKi8KKyAgICBxZGV2X3By
b3Bfc2V0X3VpbnQ4KERFVklDRSgmcy0+dWFydCksICJyZWdzaGlmdCIsIDIpOworICAgIHFkZXZf
cHJvcF9zZXRfdWludDMyKERFVklDRSgmcy0+dWFydCksICJiYXVkYmFzZSIsIDM4NDAwKTsKKyAg
ICBxZGV2X3Byb3Bfc2V0X3VpbnQ4KERFVklDRSgmcy0+dWFydCksICJlbmRpYW5uZXNzIiwgREVW
SUNFX0xJVFRMRV9FTkRJQU4pOworICAgIGlmICghc3lzYnVzX3JlYWxpemUoU1lTX0JVU19ERVZJ
Q0UoJnMtPnVhcnQpLCBlcnJwKSkgeworICAgICAgICByZXR1cm47CisgICAgfQorICAgIG1lbW9y
eV9yZWdpb25fYWRkX3N1YnJlZ2lvbigmcy0+aW9tZW0sCisgICAgICAgICAgICAgICAgICAgICAg
ICBhc3BlZWRfYXN0MTcwMF9pb19tZW1tYXBbQVNQRUVEX0FTVDE3MDBfREVWX1VBUlQxMl0sCisg
ICAgICAgICAgICAgICAgICAgICAgICBzeXNidXNfbW1pb19nZXRfcmVnaW9uKFNZU19CVVNfREVW
SUNFKCZzLT51YXJ0KSwgMCkpOworCiAgICAgLyogTFRQSSBjb250cm9sbGVyICovCiAgICAgaWYg
KCFzeXNidXNfcmVhbGl6ZShTWVNfQlVTX0RFVklDRSgmcy0+bHRwaSksIGVycnApKSB7CiAgICAg
ICAgIHJldHVybjsKQEAgLTQ0LDYgKzU4LDEwIEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9hc3QxNzAw
X2luc3RhbmNlX2luaXQoT2JqZWN0ICpvYmopCiB7CiAgICAgQXNwZWVkQVNUMTcwMFNvQ1N0YXRl
ICpzID0gQVNQRUVEX0FTVDE3MDAob2JqKTsKIAorICAgIC8qIFVBUlQgKi8KKyAgICBvYmplY3Rf
aW5pdGlhbGl6ZV9jaGlsZChvYmosICJ1YXJ0IiwgJnMtPnVhcnQsCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgVFlQRV9TRVJJQUxfTU0pOworCiAgICAgLyogTFRQSSBjb250cm9sbGVyICov
CiAgICAgb2JqZWN0X2luaXRpYWxpemVfY2hpbGQob2JqLCAibHRwaS1jdHJsIiwKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAmcy0+bHRwaSwgVFlQRV9BU1BFRURfTFRQSSk7Ci0tIAoyLjQz
LjAK

