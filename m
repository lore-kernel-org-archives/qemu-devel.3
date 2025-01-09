Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8263BE77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 06:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVlkM-0006Hs-GQ; Thu, 09 Jan 2025 01:10:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tVlkK-0006HK-JC
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 01:10:20 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tVlkH-0007FH-OM
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 01:10:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1736403017; x=1767939017;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Hcr9Of4wJpVEfu6ci4YAMQyic2zQ9wykJ8et3qOfdko=;
 b=Z/Tg+pcqsQc2aeOmFeh1KNtkMooMRS8Rs/S6sFdTOUk/ge62e0MXFaqD
 CpZh97KRUlFOrGEOdIi/cYIu/Xaxy57bYezeJWH+mb6Vkof6WnZjSIyBK
 9MMfwDPXMvZcZQG6KXWUasJjnvXr4D5XoDYIFlcClS5a56Lfk13L7DwL6
 fEgSFzXL7zlrVP2NuIUxr9gbff+baIu/1nZSiVjgyn33v0gME1vFngyJq
 jD73VwCVGddq4rdSUdg32uhTk2xz26q7dcJA1o0TLrG2txt/itKa8udK3
 TRx/7gy5gG7NXgQxnTzgjpu3LX9seU0ScZ0h4RDrHa/qTSDDpysPP/UeW Q==;
X-IronPort-AV: E=Sophos;i="6.12,300,1728943200"; d="scan'208";a="29383831"
X-MGA-submission: =?us-ascii?q?MDECuwsQ6zRGy6DgQ8vBzNGuQFoYD7/thcfEuR?=
 =?us-ascii?q?Tgral3/kjq+x3FlzMt7SGAaO+AtWUiYJ4sNdfyNLwCeiO9+taFrFUYHX?=
 =?us-ascii?q?cYf626H9ew5qeUIcCsKN5t4fW84qr+QQvEcuIWsWUaYAAZPlh9b/SH/3?=
 =?us-ascii?q?zkQbshKyfTGBk0vGRM/10OpQ=3D=3D?=
Received: from mail-db5eur02lp2108.outbound.protection.outlook.com (HELO
 EUR02-DB5-obe.outbound.protection.outlook.com) ([104.47.11.108])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jan 2025 07:10:07 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTD4s56lkMozx1RWeS2wEUkMvmfZKaTK1xGGJIKRGl99fkWI/SytIywYR/D1qjKRWEuzeaQeiBGu/RcjVLgLucYtjZPeyC3CPbDps0V/gQ8A9t7DPX2x+p9tU2BelGTxN5Wr805Pw0Ivlj9feRduTm9xRQFTLqHj84ss+r3uJbri6vdz2ZZ3BGhiVtKMwdxiDRv3c8iMybslr4UaAtqw+hQCnONiQxsoCe514LVvh3PbBFWRkK/NtWGzRfO8qw2EwifiQ8kNGMWPJgysgRgbew5mAqMmSsU2f82aT7W4UwVexOsLAsQdIiLdCant3OdmLSUbRPVdpnKS5/LIsUZOjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hcr9Of4wJpVEfu6ci4YAMQyic2zQ9wykJ8et3qOfdko=;
 b=d4ByZiBAugp4tIbA/D4P7sRireE87V/9bWGZ391ReEae6zLJdiI6xqxnynF5txLwgDdW3IMqNWdxGgmMwLqdEoe7jascxT6Xmj3zI0yuWNRNGiStmxwNIg3uqKxTD8rCJ7qfi28PDScgOY9fsXHrZhYjpePBtkvzI+lWZbZ1/skbWj1yWqqhL6zXSLNXyYn3BIHoVjQfvBqPFGoWAC8IWGbt29lE3r3Z0we/88HlgeMejBJfLpagm4miMo6a7lcSxsj+Le/KqtAb5TYdF0ZU6D4PUnQOqzH/sCJGKvj3gnL4H79AazKJwJQYxqfy/4t8SCH+cUdP4Uovca3R82K2/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hcr9Of4wJpVEfu6ci4YAMQyic2zQ9wykJ8et3qOfdko=;
 b=bF7Drn7xZf8wBwlSQQZ1fij88T6luOOH/6+GIbZeIYkO2qO8MRNs4RAfGppJFaVUhX+HHrvZjg/dce1tzjFm2kzzekDj6h6iKZvLBk3wuVbgZG7+NDg9qY7O+djxqdi0k3B6x175J5roovjrPKutrb0MClUPpd0VsihpQraEYyetFfuNOqsm+DCqRUXKWjOh6fbHpp/gfClTgbChkEQWQUL5IhPX38HZGlUnFxgE5X7qP2WgOudFpmUEVR/kvJ2bXzgpBk9KT6zLlelLKC2m4e9Q21Ym72KhyrMrhCO7+yZDkEzS5Miqwl16PMra1FovHlaicjTHZv4lpEi8Zb0Hzg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DBAPR07MB6502.eurprd07.prod.outlook.com (2603:10a6:10:188::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 06:10:04 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 06:10:04 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, 
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "tjeznach@rivosinc.com" <tjeznach@rivosinc.com>, "minwoo.im@samsung.com"
 <minwoo.im@samsung.com>
Subject: Re: [PATCH v1 15/19] memory: Add an API for ATS support
Thread-Topic: [PATCH v1 15/19] memory: Add an API for ATS support
Thread-Index: AQHbQjJ0k0DlGQgy0Eihqb6cUgrbz7MNbO+AgADI2gA=
Date: Thu, 9 Jan 2025 06:10:04 +0000
Message-ID: <e6e2951c-884d-4b89-9e70-7e7802d196ce@eviden.com>
References: <20241129074332.87535-1-clement.mathieu--drif@eviden.com>
 <20241129074332.87535-16-clement.mathieu--drif@eviden.com>
 <20250108131034-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250108131034-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DBAPR07MB6502:EE_
x-ms-office365-filtering-correlation-id: a5ba72c3-c556-4178-8ccc-08dd30744282
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Tkl6aXBncGNFMHU4bXJ6Q3hxWHVBQkVDYit3OE9mWWlNMks5S0RVRllsRGJk?=
 =?utf-8?B?a0ZidENyci9PNTNUSmhYbkFWWUZra3hYZHZseTJVQW5YdzhVR1Bzd2t1Sktx?=
 =?utf-8?B?V3lIS29TTCtQV1FUQ0FUNVJldnJ4ZWh4eDZjSkw2M3Q3WHZhVkNsUE9TSDhI?=
 =?utf-8?B?djlLMVhmT2x6dkNaWWRBenNaRkV6SW4zcHNHRkZBanpjckV3NGM5d0gveElI?=
 =?utf-8?B?Q1BtMGZtc3dYSFJuRUw1dlF3RVhxZElrZm9XbXZCKzljNGxCOTB1MWthSXo2?=
 =?utf-8?B?Zk1VbUVQVE85b3NUNlRSWHcwa210OVd4OHpNeG5hODNHV3J0WDlNSUdKeGZG?=
 =?utf-8?B?UVhHQnc3ZnBGSUlySnpUSkhzYzBVQjZLc3JTMWN5UWNjM1Aya0hSdGZOeDJK?=
 =?utf-8?B?UDVZNzF1dVhpZXRSM1Z4bWxScDB3amlRcGZ3NGxLemZlb2xHRWN0ck1RK1lD?=
 =?utf-8?B?RW1xdFJFRXJrM09NSjVKZWZacXFHQkg3N1k0aFB3ZHJaOFY1RDhhRG93NE1V?=
 =?utf-8?B?WEJ4NmpNbDg4OG5lY3dLOE4xN2pPdmlYOERIcHdlN21HYk96RStIK3VNRUJs?=
 =?utf-8?B?VUlXM1dIRmZaTklSejgvck5LTXkyZGhHVHFtSDJtZ1QxcmV1cTNTZW9zWmth?=
 =?utf-8?B?Zm94ZUJzZzNqOWVuSHZyL0c5N29TN0JhRUc4bGswZ2VQSHdHdmtaTldub1hX?=
 =?utf-8?B?Y0c3N2lSUWM5UURZMFdrMTdDd2xYeCtmSWZ5VGRWRUFLQVNOd0lkVkxTNjFj?=
 =?utf-8?B?QUtyYUh3TEtDcGtxSFltM1c1U0JsUDBDSkQ4U1dSY29pTGVzSm1YeXIvVWVU?=
 =?utf-8?B?VHNHVVMwUTZVaDRBcGpTd2JWeFoyTXdURUhsMVNOZk1YcHZQWVhzaDM2WmNr?=
 =?utf-8?B?cDVIWlp5T0ZSMUVaMG9qYzVoOEdYZWxLWXFnSUk0SDd3N0paNUtpWUM4NFJR?=
 =?utf-8?B?Y2NTSm5OZmFQY0F5WGYvb2h6NldJOEFrSVdOYWlxN1dwOFBUeWVLNVlGRnVj?=
 =?utf-8?B?NURzcmRnRlRVcnFPQVU5bzlLQUtINnNZTlpPc1JMV3ZZK3hTVHFYQzVKd2hk?=
 =?utf-8?B?SlBxckVXSXZRTERWZVkrRkhzVmprc255cGtBdjVvdWlyMXo2K0tMSVdPOHlL?=
 =?utf-8?B?am5uQTJHYWhWdEY2S2ZEOFUwQVhCREFGQlp6ZjNLVU1PWlFIelBYdHdTb25Q?=
 =?utf-8?B?RmVaN2xHVWZ4VHFrck9XWmloeVBGQlBJalBqY0FVTjI4RFJJMWNKQ243M0g2?=
 =?utf-8?B?c1Fmb2U4OUNSRC9uN0xnaVdXZEpKckRsSzJrd2wxY1JFdmRlNlBXZmRlUW5R?=
 =?utf-8?B?WDhyM0tYTjNmeU5KRHN5dEZLdi92dWwxTTduSW5TRXBLRGI5UkxMcGFSMXhS?=
 =?utf-8?B?di9WL0JEQnRrNk1qbFo3ZHhnaWc1bUJ3bURyZFBSK1FRYWlaeW9weWJUWXEx?=
 =?utf-8?B?YnZENjczUmdsa1Y5N3RjOTFxQW5BWEo5RmQ4aWtQZE1rWm9MNW9hbWhza2tB?=
 =?utf-8?B?TzFyMVFsOEp0MUVWeGlsRzZPN214Z25vWEFubG5IWGRxbTNuZGlzM3BPY3VK?=
 =?utf-8?B?Q2lXaDdhRnJxbUFlL2YvWm9BbFozTlMzMmFsMU5YYVFBeWxJRWtlRHhHOU1p?=
 =?utf-8?B?SkxvUElSVG1rN2pVbkpUdS9rOXhWeGFLeWtVQnBZaG5HenU1MnB2TkJMckxH?=
 =?utf-8?B?RTlEYThJelpGSVlsSzNmQ1RDeTJnaGV5b2NPSm9jWGtZQzVUMi9sbnBFaFNw?=
 =?utf-8?B?L0hVam5PYllZZkJqUWh3Qi8xTGRmek1sZ3g3RUM4STFhMFJHUFd6NzFnWFBL?=
 =?utf-8?B?M0Vuc2tiSG5LYi9QZHRGRVFNQ3JjZ2gzbjllRUJNY0VoYXIvYk9EMnZnWlFX?=
 =?utf-8?B?Smo2alJQWkZzdXVKYnZLOG1xeWZTQ3dzTXE4alV5c1hPQnZqWm0vZDBHUTAr?=
 =?utf-8?Q?KDFn5QwmVkVzURB6ICiXRmhwKFK/SRyh?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3R0aURDU3Fzb3d3L1R1WllhRktRNE5rdmtGaWM0ZGVMMXJnZEhqL2hCRlJs?=
 =?utf-8?B?UGNTdU9tSUNvcjZ5NFcvUnp0M2FtNE1QYU5selFJWHZ3TFd2UkhTSTl1ZWZJ?=
 =?utf-8?B?UklqajQrMFVCZ1VxdnZMTnE5NXRuUE5wcVpSR2JiUEYzSWw2MWJYa0pRV1Vx?=
 =?utf-8?B?aE5hUU0vS3RKWFV1TjhJaFR6ay9VUk9CT1VoNE9WVmg3OTMwS2xya2FmY1V5?=
 =?utf-8?B?UlpYQlpCbUtwWEhTRGNvaUNZVG5qbTlNSktaU05Gc0ZRbFNaWkpSQ2ZMcG12?=
 =?utf-8?B?NUhibUNIM2NvU0tQOW00K2FvWUp5bkYvK1dYTVdZbGd3RjlJS1EwUmRqbnVU?=
 =?utf-8?B?dGQrekczblozYjBsM3AyVWJNdXJpZG8xLzVJNEFsOXprcEo3MWhPRkNlWER1?=
 =?utf-8?B?b1Q4VUtIakswTVovWVZKdEh5QjJHWEIweEtoNEgvR28zaFJMS0QzSTJ2Q0Rm?=
 =?utf-8?B?RmM1ZHppWnJTa0prdHFacDRSZE1MNEpIT0hGL0VXMURuaGJwVndJUG9qbHlR?=
 =?utf-8?B?eTM1d0xrN2h4dm5WTE5hQnNzbU81aHBRcExLT3h2Zzc3ZzV3V1hHSWpJanFx?=
 =?utf-8?B?NjF3cHRvL0MzOVVtMlJ0UUo4eXY5ZU5vaUJEWU0zb2tOYlN0WjZlOFBKei9t?=
 =?utf-8?B?OTQwbFNFWWZtcnZIZks3aDVEYjRFQUVoOUZjTVJUUmNORUl3YzR0ajhESGlE?=
 =?utf-8?B?TmZOWDB3bWVMSXNIbnNOZlRkajhkOXBsTk81MUFPVUlYM0xqdGRQcXF3d2Fr?=
 =?utf-8?B?MUlxbjdXTWZ4UXhQNnZscWJQUytwckVvSDdMUStpNTUwR3BmSGVVSnJ6ZHhP?=
 =?utf-8?B?UG5sOWFYMEdUcUlScWg5S0cwQytTU2RzOERicE4rdmN3b1RlUktxOFJlWnFu?=
 =?utf-8?B?ajNtN1Bwck13aGFETVpud0VYOVIzb0R2R1ZYSzdXejR0K0tldW4yY0lKdmQx?=
 =?utf-8?B?a2NWSk1oMTM5ZEI3Q3BTbURuT3JpdWduejBoR1VDTkljTFgxL1krM0RTQmw1?=
 =?utf-8?B?eFZubXd0eHdRZ050SlJZRHFpem8wVHkvREppOEZBcU0yUkZheDg4czhqMU1S?=
 =?utf-8?B?VFlKUTVUNSttYTg3SHdyQ3VqdnpuZEdFaEczdnlGMFFqbnZrRmZrM3I4R1dS?=
 =?utf-8?B?MFdHQ0xqV0VucXNTQ0tkK1FOeTAwUndxUDUvbENpVDl5QkdyU01tWGZSV1JV?=
 =?utf-8?B?UEg3dU9yOG1UNms1a1F3ODFJN0dVb0xtOFR1VlRrWFZsU01mYkQ1Q0ZnRENk?=
 =?utf-8?B?K2xzSzVjcEVTV3dRTWFxVnpmSEM2cDlTamdYRkRtYnNiSGpOYWc4TWQzclJO?=
 =?utf-8?B?MEtnTVdId1FuWFJObk9tbzB6Zm41WGFwMUZ3MlE4NEVsV21UZUcveWsrb3pn?=
 =?utf-8?B?MXliUERCdFJkTS9idWRvNGx2b09ETm9uNzFMWnQ1M1UzSjF2aE84MTcxMkxN?=
 =?utf-8?B?dmVaQWE2YUhsUkRMZlZvK0NlVGtvampJM0JOSjR0ZWZGNEEra0FvZEtxSTd0?=
 =?utf-8?B?RmNSM1JsVURvaSt4alpGWGZCeXNsSktwYjJxK0luemhBSXpUUFBDaDdSbUJK?=
 =?utf-8?B?OEM4QllMMVBkYnhPRE5XOTlCSG9IaTZDdGg3aVFmSE92SmlxMlFieitIcHBM?=
 =?utf-8?B?Ukk0QllSZEcxOU5pSWdBSHBCcFdEem9YT3VVaXQvVDE5V3AxczlWblJxZFNo?=
 =?utf-8?B?UlBKT0ovYlhLT09PdytIZ05GKzlxSWRFMzNpV1Boc3V6a254TlN6bWtFR1F0?=
 =?utf-8?B?U3NUQkFlY0VzckVwL3J1KzB2c1R5UlNJaGtXV1pDdEJvQ3lmdWhWQjdlaGJI?=
 =?utf-8?B?VGRwclBPNWxySWFOekpXcjN6NkY5TnJ0RWwweUpFNWkyRmlJRHFZR3AzZFRL?=
 =?utf-8?B?OGM4cEl2ejBSTHozMjJoN0FKd0l3N2E2eHRKWUNTd2FGWVB5UVJEUHZyZEFE?=
 =?utf-8?B?OWJ6c0F5Z243UmJUOUJ6VnhUVVh1UlNVM0tvdy9JZ0ZJWXNiZEl1QmtNUVlr?=
 =?utf-8?B?RGdjZmsyV2xpRjZmTXczd0tQWWRSZE1NN1pIYjB6dm5QcU1ueXIrZ282Umxa?=
 =?utf-8?B?MG1mN0FQV1VJVkFUc0xFL0RrOURmclJUdVkyd3Nmc2hQOFhNUzdUZ2t2djA4?=
 =?utf-8?B?VnBSQjZzT0xvbVAybWZkT0Y0cFlGc2g2Y0RHTFErQjVYenFpZ1ExTmc1VjR4?=
 =?utf-8?Q?/GOrxYgZfKvYZv4xd6OK0K4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3ADD51C6CF21A24E9BBC729A1038E6F4@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ba72c3-c556-4178-8ccc-08dd30744282
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 06:10:04.6376 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bmlKGSDILbmHx5nL6d7tUmyyS0uwNs9wzhOpMu5Irt0Mws87mOXZEjoV4qQQ/bgkbhSliFC6tRm2Hj1wT431iZwjBno48fYxtY1DXzddinJcT77MRIGohnhgYSvqsdYk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6502
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

DQoNCg0KT24gMDgvMDEvMjAyNSAxOToxMCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOg0KPiBD
YXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sg
bGlua3MsIHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlv
dSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+DQo+DQo+IE9uIEZyaSwgTm92IDI5LCAyMDI0
IGF0IDA3OjQ0OjAwQU0gKzAwMDAsIENMRU1FTlQgTUFUSElFVS0tRFJJRiB3cm90ZToNCj4+IEZy
b206IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4u
Y29tPg0KPj4NCj4+IElPTU1VIGhhdmUgdG8gaW1wbGVtZW50IGlvbW11X2F0c19yZXF1ZXN0X3Ry
YW5zbGF0aW9uIHRvIHN1cHBvcnQgQVRTLg0KPj4NCj4+IERldmljZXMgY2FuIHVzZSBJT01NVV9U
TEJfRU5UUllfVFJBTlNMQVRJT05fRVJST1IgdG8gY2hlY2sgdGhlIHRsYg0KPj4gZW50cmllcyBy
ZXR1cm5lZCBieSBhIHRyYW5zbGF0aW9uIHJlcXVlc3QuDQo+Pg0KPj4gV2UgZGVjaWRlZCBub3Qg
dG8gdXNlIHRoZSBleGlzdGluZyB0cmFuc2xhdGlvbiBvcGVyYXRpb24gZm9yIDIgcmVhc29ucy4N
Cj4+IEZpcnN0LCBBVFMgaXMgZGVzaWduZWQgdG8gdHJhbnNsYXRlIHJhbmdlcyBhbmQgbm90IGlz
b2xhdGVkIGFkZHJlc3Nlcy4NCj4+IFNlY29uZCwgd2UgbmVlZCBBVFMtc3BlY2lmaWMgcGFyYW1l
dGVycy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVt
ZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj4+IC0tLQ0KPj4gICBpbmNsdWRlL2V4ZWMv
bWVtb3J5LmggfCAyNiArKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICBzeXN0ZW0vbWVt
b3J5LmMgICAgICAgfCAyMCArKysrKysrKysrKysrKysrKysrKw0KPj4gICAyIGZpbGVzIGNoYW5n
ZWQsIDQ2IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9leGVjL21l
bW9yeS5oIGIvaW5jbHVkZS9leGVjL21lbW9yeS5oDQo+PiBpbmRleCBjMGQwNjRkYmQ4Li4xNDE2
NmUyODc0IDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9leGVjL21lbW9yeS5oDQo+PiArKysgYi9p
bmNsdWRlL2V4ZWMvbWVtb3J5LmgNCj4+IEBAIC0xNDgsNiArMTQ4LDEwIEBAIHN0cnVjdCBJT01N
VVRMQkVudHJ5IHsNCj4+ICAgICAgIHVpbnQzMl90ICAgICAgICAgcGFzaWQ7DQo+PiAgIH07DQo+
Pg0KPj4gKy8qIENoZWNrIGlmIGFuIElPTU1VIFRMQiBlbnRyeSBpbmRpY2F0ZXMgYSB0cmFuc2xh
dGlvbiBlcnJvciAqLw0KPj4gKyNkZWZpbmUgSU9NTVVfVExCX0VOVFJZX1RSQU5TTEFUSU9OX0VS
Uk9SKGVudHJ5KSAoKCgoZW50cnkpLT5wZXJtKSAmIElPTU1VX1JXKSBcDQo+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID09IElPTU1VX05PTkUp
DQo+PiArDQo+PiAgIC8qDQo+PiAgICAqIEJpdG1hcCBmb3IgZGlmZmVyZW50IElPTU1VTm90aWZp
ZXIgY2FwYWJpbGl0aWVzLiBFYWNoIG5vdGlmaWVyIGNhbg0KPj4gICAgKiByZWdpc3RlciB3aXRo
IG9uZSBvciBtdWx0aXBsZSBJT01NVSBOb3RpZmllciBjYXBhYmlsaXR5IGJpdChzKS4NCj4+IEBA
IC01MjUsNiArNTI5LDIwIEBAIHN0cnVjdCBJT01NVU1lbW9yeVJlZ2lvbkNsYXNzIHsNCj4+ICAg
ICAgICAqIEBpb21tdTogdGhlIElPTU1VTWVtb3J5UmVnaW9uDQo+PiAgICAgICAgKi8NCj4+ICAg
ICAgIGludCAoKm51bV9pbmRleGVzKShJT01NVU1lbW9yeVJlZ2lvbiAqaW9tbXUpOw0KPj4gKw0K
Pj4gKyAgICAvKioNCj4+ICsgICAgICogQGlvbW11X2F0c19yZXF1ZXN0X3RyYW5zbGF0aW9uOg0K
Pj4gKyAgICAgKiBUaGlzIG1ldGhvZCBtdXN0IGJlIGltcGxlbWVudGVkIGlmIHRoZSBJT01NVSBo
YXMgQVRTIGVuYWJsZWQNCj4+ICsgICAgICoNCj4+ICsgICAgICogQHNlZSBwY2lfYXRzX3JlcXVl
c3RfdHJhbnNsYXRpb25fcGFzaWQNCj4+ICsgICAgICovDQo+PiArICAgIHNzaXplX3QgKCppb21t
dV9hdHNfcmVxdWVzdF90cmFuc2xhdGlvbikoSU9NTVVNZW1vcnlSZWdpb24gKmlvbW11LA0KPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgcHJpdl9y
ZXEsIGJvb2wgZXhlY19yZXEsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgaHdhZGRyIGFkZHIsIHNpemVfdCBsZW5ndGgsDQo+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBub193cml0ZSwNCj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVVRMQkVudHJ5ICpy
ZXN1bHQsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
c2l6ZV90IHJlc3VsdF9sZW5ndGgsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdWludDMyX3QgKmVycl9jb3VudCk7DQo+PiAgIH07DQo+Pg0KPj4gICB0
eXBlZGVmIHN0cnVjdCBSYW1EaXNjYXJkTGlzdGVuZXIgUmFtRGlzY2FyZExpc3RlbmVyOw0KPj4g
QEAgLTE4ODMsNiArMTkwMSwxNCBAQCB2b2lkIG1lbW9yeV9yZWdpb25faW9tbXVfcmVwbGF5KElP
TU1VTWVtb3J5UmVnaW9uICppb21tdV9tciwgSU9NTVVOb3RpZmllciAqbik7DQo+PiAgIHZvaWQg
bWVtb3J5X3JlZ2lvbl91bnJlZ2lzdGVyX2lvbW11X25vdGlmaWVyKE1lbW9yeVJlZ2lvbiAqbXIs
DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIElPTU1V
Tm90aWZpZXIgKm4pOw0KPj4NCj4+ICtzc2l6ZV90IG1lbW9yeV9yZWdpb25faW9tbXVfYXRzX3Jl
cXVlc3RfdHJhbnNsYXRpb24oSU9NTVVNZW1vcnlSZWdpb24gKmlvbW11X21yLA0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgcHJpdl9yZXEs
IGJvb2wgZXhlY19yZXEsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgaHdhZGRyIGFkZHIsIHNpemVfdCBsZW5ndGgsDQo+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBub193cml0ZSwNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVVRMQkVu
dHJ5ICpyZXN1bHQsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgc2l6ZV90IHJlc3VsdF9sZW5ndGgsDQo+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgKmVycl9jb3VudCk7DQo+PiArDQo+
PiAgIC8qKg0KPj4gICAgKiBtZW1vcnlfcmVnaW9uX2lvbW11X2dldF9hdHRyOiByZXR1cm4gYW4g
SU9NTVUgYXR0ciBpZiBnZXRfYXR0cigpIGlzDQo+PiAgICAqIGRlZmluZWQgb24gdGhlIElPTU1V
Lg0KPj4gZGlmZiAtLWdpdCBhL3N5c3RlbS9tZW1vcnkuYyBiL3N5c3RlbS9tZW1vcnkuYw0KPj4g
aW5kZXggODVmNjgzNGNiMy4uN2Y2ZjM3OThlNiAxMDA2NDQNCj4+IC0tLSBhL3N5c3RlbS9tZW1v
cnkuYw0KPj4gKysrIGIvc3lzdGVtL21lbW9yeS5jDQo+PiBAQCAtMjAxMSw2ICsyMDExLDI2IEBA
IHZvaWQgbWVtb3J5X3JlZ2lvbl91bnJlZ2lzdGVyX2lvbW11X25vdGlmaWVyKE1lbW9yeVJlZ2lv
biAqbXIsDQo+PiAgICAgICBtZW1vcnlfcmVnaW9uX3VwZGF0ZV9pb21tdV9ub3RpZnlfZmxhZ3Mo
aW9tbXVfbXIsIE5VTEwpOw0KPj4gICB9DQo+Pg0KPj4gK3NzaXplX3QgbWVtb3J5X3JlZ2lvbl9p
b21tdV9hdHNfcmVxdWVzdF90cmFuc2xhdGlvbihJT01NVU1lbW9yeVJlZ2lvbiAqaW9tbXVfbXIs
DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGJvb2wgcHJpdl9yZXEsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGJvb2wgZXhlY19yZXEsDQo+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGh3YWRkciBhZGRyLCBzaXplX3QgbGVuZ3Ro
LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBib29sIG5vX3dyaXRlLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBJT01NVVRMQkVudHJ5ICpyZXN1bHQsDQo+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVfdCByZXN1bHRfbGVu
Z3RoLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB1aW50MzJfdCAqZXJyX2NvdW50KQ0KPj4gK3sNCj4+ICsgICAgSU9NTVVNZW1vcnlSZWdp
b25DbGFzcyAqaW1yYyA9IG1lbW9yeV9yZWdpb25fZ2V0X2lvbW11X2NsYXNzX25vY2hlY2soaW9t
bXVfbXIpOw0KPj4gKw0KPg0KPiBsaW5lIHRvbyBsb25nIC0ganVzdCBjYWxsIHRoZSB2YXJpYWJs
ZSBtci4NCg0KSXQncyBzdGlsbCB0b28gbG9uZyB3aXRoIG1yLCB3aWxsIGRvIHRoaXMgaW5zdGVh
ZDoNCg0KSU9NTVVNZW1vcnlSZWdpb25DbGFzcyAqaW1yYyA9DQogwqDCoMKgIG1lbW9yeV9yZWdp
b25fZ2V0X2lvbW11X2NsYXNzX25vY2hlY2soaW9tbXVfbXIpOw0KDQpCeSB0aGUgd2F5LCBJIHRo
aW5rIEkgZmlndXJlZCBvdXQgd2h5IHBhdGNoIGVuY29kaW5nIGlzIG5vdCBjb3JyZWN0Lg0KV2ls
bCBmaXggdGhpcyBpbiB0aGUgbmV4dCBzcGluLg0KDQo+DQo+PiArICAgIGlmICghaW1yYy0+aW9t
bXVfYXRzX3JlcXVlc3RfdHJhbnNsYXRpb24pIHsNCj4+ICsgICAgICAgIHJldHVybiAtRU5PREVW
Ow0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIHJldHVybiBpbXJjLT5pb21tdV9hdHNfcmVxdWVz
dF90cmFuc2xhdGlvbihpb21tdV9tciwgcHJpdl9yZXEsIGV4ZWNfcmVxLA0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYWRkciwgbGVuZ3RoLCBub193
cml0ZSwgcmVzdWx0LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgcmVzdWx0X2xlbmd0aCwgZXJyX2NvdW50KTsNCj4+ICt9DQo+PiArDQo+PiAgIHZv
aWQgbWVtb3J5X3JlZ2lvbl9ub3RpZnlfaW9tbXVfb25lKElPTU1VTm90aWZpZXIgKm5vdGlmaWVy
LA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBJT01NVVRM
QkV2ZW50ICpldmVudCkNCj4+ICAgew0KPj4gLS0NCj4+IDIuNDcuMA0K

