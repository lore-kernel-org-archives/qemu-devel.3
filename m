Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC3AE83EE0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 07:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnX98-00064j-3Y; Wed, 04 Feb 2026 02:17:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZN-0004hK-Vv; Wed, 04 Feb 2026 01:40:58 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZM-0004KA-EV; Wed, 04 Feb 2026 01:40:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vu4GpAgMErJAzFxExmV3+NK9x+H5H2EjvqnqMHpDfRhn3egCVEfOE+yirzNdKWX+FQZD+QnMSnLQ1W4GHGrZX4MQZU8yfGl9vZpFs2OPB1O3dlxZpGtjqY497/i9SAFzvqLB6tcwhPmGgPeUgq8vtB2aR4Wj8ZMS+u29vDFkmxbkBcL6//vaGzWhoSH4vLyS6GSVjeIII8uHULQsmF7gcd6vRnSycbA/z6pnNCvr2gMAQNtZ3TaXUUKMJldIJFkXO69Sc0xhLSXWWIts7IlK9xtAPr1pEc7DXKUGfnOAhKYw79/MVOQpCMuQuHoX6YuvWP5W5SWAToXVB9uwfOtJ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dvIlZ/kfj1XcYDEZpfs5CLDoq7C7/MFWyTk1eqo3tg=;
 b=slQ9lweVLP66Oz2kpKymq1Cme97VwqzwHpcWRrbR7kWZ1clkaqtruvaaXk/u1NE4xVm+mybLBDONDorzyRuzg3IVe2xZINpzl9wM6e3MvME1eVnbHRfnq68PXt9rDemAzIgyYWWT+UfbsJANo8nxQImeRI0J0dJSVyIfc+c/Fr3HfeoBgRYjAMEz4okirkRu478NsGSpRIg+LrhHG9xAWEGidK32lPDdK+XWtawQGpbaIPFkJ706edWCXCbrqpke79hZo9FoQjeTyQnqUtTGfuivZIoqxV766V7CcWtaxhKwa8ZW+hkqtu5UQQm8aBHe8NNQd68ivHg1czYyRTlkqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dvIlZ/kfj1XcYDEZpfs5CLDoq7C7/MFWyTk1eqo3tg=;
 b=Gmf0r+BfL3jcm5RuALhC6qbu4w1m5bmis/xFbXsm+r5koU0hgzUGZiK3pXMq8MhisXNqbEXDeozAq12ROQHaRWPW3BqrcBH6jZW359ScY9luXC74WM+1xL7HXnga9TKmWC3dcur6yoJQtYfw3/8viQ806HZtciCUbz8WqtTyvTcDGEtbvZ0jkNNLNV0PWRzi7mqluI+uVdr0yTYvl1QsOdXpgEIfxNrw3/vZB1dDZ/E65Y57639ITJyuzMiEdXpRJXQtTQmX3pvm2bvZRFLNWkEwTEyegBcOEOw8zjSNiF8BO1O5knny51zRChJPTHTbeOibkK/zWqeTSHtJD39A9Q==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5901.apcprd06.prod.outlook.com (2603:1096:301:110::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 4 Feb
 2026 06:40:41 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 06:40:41 +0000
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
Subject: [PATCH v6 17/22] hw/arm/aspeed: Attach SGPIOM device to AST1700 model
Thread-Topic: [PATCH v6 17/22] hw/arm/aspeed: Attach SGPIOM device to AST1700
 model
Thread-Index: AQHclaEuE4+gzmge/UmIhJ33qC+nLw==
Date: Wed, 4 Feb 2026 06:40:40 +0000
Message-ID: <20260204064016.3515639-18-kane_chen@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 5e3c8a9c-7d31-49d3-8a54-08de63b850e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VExaOHJOKzlEOFJUc0NjRzVJVU50dTRwclVCT0x0QlZ5bVNocFhrc2tsanZ2?=
 =?utf-8?B?M1FnNEVhUGFqcVRXNXdicFpOQy9CYXVDbll4L1RMT1NVU0dtMWpTTkxWblJs?=
 =?utf-8?B?Q1h3UjM1a3NPMktHajFObFozZ2FNem1PcW1idTh3Z0QwQmlCZnhrcEo1Zmpa?=
 =?utf-8?B?RjlWRWg3c0h6K0FUOWZaZ2xMdyt4Tldjc3pJa1Rlbzk4OEduN1REUzIzRlBX?=
 =?utf-8?B?Z0p6emc4dXFTUCtndGt6cWVMWldOU05JQzVLUkN3YmJiK3RqWGlSQVVRanNv?=
 =?utf-8?B?L1BtMGRHaVhrSDlvelhBN1JzY3pYQVQwb2N1Mk9Xd1d4TFB0R1RDOGdjemFP?=
 =?utf-8?B?ZEFoMmZBV00xeEw2aXQvZTJjRnpuSzRwZGUxdk81RHU1L3M5NVRqSmszNXpC?=
 =?utf-8?B?bGZPaEhjNjBDcDJmTUsrMFJxMmE0bDVPRkNMcFFzdjk0alI0VWhSNmdZaXBY?=
 =?utf-8?B?OC93dERlaTdsT3NqSU5IUXRjTTNGamZNaWhMUGIwR01zb2lPcWQ1dWR2M2NH?=
 =?utf-8?B?NE9XWXRxc3BvNEtCMzJPeWxMakR3WmZhU2EwK25aS2hYcnZVZWZXUTJGWFhu?=
 =?utf-8?B?RzJwL2crUDVicFpyNDhLVjVvNkN3QTJHcGFWTG9kWUhad1JEbG83YXFHcE5Y?=
 =?utf-8?B?Q3F6dTA3SVNDZVNwZHJqSjlTS2VkZ1ozeTZaRFBack05OEcxVisxbmlnVTBY?=
 =?utf-8?B?MERlWXFkci9qRllNOWZEaFcrN2JDekZTMnZLQzRrTXpxNUExZVVkekgxTnYr?=
 =?utf-8?B?WDdweVZLdHA3bWNic1MvUXZDeFJhbEd3S3lBUG1QcmZRRkhGQnNvZ2liakt0?=
 =?utf-8?B?Y0JxK05FSGFpYTZHN08ySmtmaVU4cVI0K2tKUmg1Y2VPdHp6WS81ZHN0MWU5?=
 =?utf-8?B?TGFQNk1lWHBIZ2wzT01vSXp0NVpTUFZjYjFiWXJ4T0ovUXd0dDN2RHVWZ21N?=
 =?utf-8?B?bUIzVlpTeDU5SjhYSkNPOU5SeUwxTm1wVlNMYkxSU29obzZwVlY4a3N2WE1Y?=
 =?utf-8?B?ZU9wTE54OVZiNE83ZnZMOUd6azh5ME1LOEJvVG1pUHovYmtGZHphYXliK2xo?=
 =?utf-8?B?c0ZUMVNjT3JzZ0Nza0wyYzNOdXN0Um9oN0E5QUg4WllzK3FGUkpENVdSak5y?=
 =?utf-8?B?QzdIM2NidWt3RXJYY0dvaWpuVnI0TGRxVE85ZkdkcytJVldwQXlwUDNHR1Fl?=
 =?utf-8?B?RzVaL3NLR0tGQVFXZ21OR2JlS2NFS3JPNFlkazYyMXJLTVF3M2ZJTDBxelpk?=
 =?utf-8?B?T3FxbWIwQkNqT2lCTDZJNkR0UzBDdUIwQzZaUDBHWnl6blVubmNwd2RUM2hD?=
 =?utf-8?B?WWhEbzhaSy9naUtUQTlRY01DanpHVW9nMkZkR2lPUXdTOVE0THJ4bXBEcFBI?=
 =?utf-8?B?RWdNdFQ2L1Rxajh3Ykc5K3BGQTJQaG1Ka0tCZnJlT2ZJNlhmejZZSXh1dDBY?=
 =?utf-8?B?c2NnUjBiUk5KRXBMdDJhQkM0NzdLVmk3Rkh4UklWQjFjd0ZOVkRXaUNVeUE2?=
 =?utf-8?B?aFp1VGZQWm0zanRlamozdzd5ZkpMRkNWSUpET0VhV1lVVzRqeWFzOHZPN3FB?=
 =?utf-8?B?akkvRlV6dHVSZ3hnOEFHRTlsTWR2cjJ4bnkrZnQ4Z2ZleHFua2Fzbm9MNWdG?=
 =?utf-8?B?Zmw4ZHpXeE8zQW1pZDhmd1A2YkxrNmo4Q1Z6NUNBTkliNzQ2akQxdzFDWlNU?=
 =?utf-8?B?TDdUZ0ZNQjd2dnRzRjRUTlVWS0VFYlBzTHVkTktqYXIzUFFyZGhrQ05BcytW?=
 =?utf-8?B?QUZvdUIvNkFZNHVwcVp2T25kQ0pWelBBRlZsUTlFVncxdFZtbFR5UEpiUUUr?=
 =?utf-8?B?NTdoN2k1MUhkWFRSTENzYjF0cmNyKytFekowUXlzeFFWTGxXRlBIK2pNVU5a?=
 =?utf-8?B?b1puS2JMSW9yRW15V3FkdnhUYTBKblNqZ0NuamVqd0RZOEM4ZVVhM3BIdkho?=
 =?utf-8?B?dDNmUUQ3bkdRTmVFRlhvUlU1U1pSZUZ0ZTQ1RktsSXV1T0VXVDhsV3FnVFFu?=
 =?utf-8?B?NFl3aHFwanlEa1p6VmVyMTNray94MTBmenFrZFRMRnkzd2FWMHREaks1RUpx?=
 =?utf-8?B?SUU5NjVMMmxDaTdxK1BKanZMbUpxVUh1RVdtdGxHYjVxRE9QQXVpUUtEMC9H?=
 =?utf-8?B?aUV1alptWWtHN3Ywa0NNSEd2N3IvK3V5RzI0Z2VTVkF5bGFNTVBwUmNJWmxW?=
 =?utf-8?Q?PciHhVLXUH7fu7Hwa2A0olM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elZKV1VrN2NFU3djRjlEUFJKR3dGam5Yb2cxbjJWOFg0eXk2NkdVQlhUWU05?=
 =?utf-8?B?M3BEOWNsaEhURGNsT1loMmZYMmdzT2VjRFR5YWcwQkM1dWRpU1VIUG94MG53?=
 =?utf-8?B?Zi9vRG5ua05GcUQvNG9raTZWTGsvQWQxRk82VHhqUVYxc3h3aWQrdGUyOFZ5?=
 =?utf-8?B?K0FIMGxjanBuV0t5NkRuVU45RGRyc01lWG9ZcEw4S2tDSzIwY1ZiRXJhWDJ5?=
 =?utf-8?B?cnoyTUZIMS9rQklXRDdYYW1qUG5VWnlwREp6b0ZISmNhcjZic1NicDVESnlp?=
 =?utf-8?B?YmtzQjJLV2NXY1hzdzYvNjhPK1NNV2Fud29wL1VOV3d2WjdQUzYyR2JRcU44?=
 =?utf-8?B?bzI4eEZBVk9QSGxSSnkxc2hLNGRJczJXaFZWVTczL0ZkdExQdTkvWTFmRjM1?=
 =?utf-8?B?NEh6OCtRTE1UV3ltV2xNS2NLQzRQWUIvbnRqVHlEalQxU0FzMlhjQmwzcGVR?=
 =?utf-8?B?NUFCRzFTZmc3R2szVWg2U2x3dTYzcSs2NWxIVWUvSzZEVGNFbUdxZ0RpbE9W?=
 =?utf-8?B?TmZxNkI0M2NDTi9QMXhBVEV1Zk9PNjMyZHNwQmVoUnErcVIzQlNSYmlRMUZw?=
 =?utf-8?B?MHhwREh4Tm5UbDRaQjc0MWJRdnhoZmY4ZEJqYmRLa1pucHJiaEdmRzV3eDMy?=
 =?utf-8?B?Sng1Tzl3Y2tSaUVweDdSWktydS9RRkJDcnJqV0JUOGVDRFo5bWJuUS9MK0Z0?=
 =?utf-8?B?d3oybERac1RkTWw4M2h4Q2k0bjhSNWtIYlJwaWY2U1I5R1JQckNrT25aR1ZV?=
 =?utf-8?B?OTVVa3dTZElPM0VRWkJ5TXdJWTJZdFQvYkx5QUtTbW9ubmZLdmdtMTFSQk9B?=
 =?utf-8?B?QUtXaTFSaHhKeVNkeGlVOVlNUW42R09MaHpHaEhqViszZTg1MC96U0xIVUpE?=
 =?utf-8?B?TkkwOHcxdDJpdlVTMmltdURpM250bFNhSmtUK0gyNHk5VXVHd2drWG9VSEYy?=
 =?utf-8?B?MUswSE82bTdSdVVNWmtWdUg5L1FtcjZqNSs4UitJR1BKd0ZXV3UreklhMWpJ?=
 =?utf-8?B?Y0t0cW02Uk0yM29XOHp3NkRIQWxvUXpNQVE3d3lzTzZXT3diZ2s1TDJtaGhM?=
 =?utf-8?B?dmR5TkdHMEdSRGJaWGVWMm11c3Uvci9iR3VPRk45aDlsYlhrUzBBd3JNTE1Q?=
 =?utf-8?B?cVZBK1B2dm5adFdaWHdQNlVMWnVLbXZLZ2RNelNZbzNadVJXK2VYcGJQUTFK?=
 =?utf-8?B?TGFIdnRMd3pRQjhTK1pDSzduVzdVUnd1T1paYmlpMWRROGlkdy9aTzRUUTky?=
 =?utf-8?B?SGQ0M3Z5cTdKUWI2ZHYzTlBCK2VCaEk2d2RzRUFMZWZBTnQ5WjBhcld1WCtL?=
 =?utf-8?B?WEFBYWc2WXV6c0luaDFUaitldzVSTWsvWFZuaC9hbi9iaUZhQWdQSm9PSzFQ?=
 =?utf-8?B?RWJiVm5aZHdLQmpWc1hOYVd1clFFL2FCNnpncWVZRUxyMHZITk16WDFqNHIy?=
 =?utf-8?B?anNwMXBScGgwTGR4ZWdxVkNvVWp4VkErbFFFcjRXdlhqQlhwUXBsaDhXamRt?=
 =?utf-8?B?QWpJd2FIbzIxOGtia1dSZWlDdWUyU2ZFVXhHYjZYY0Z4eENxR2JuUmlUdlRP?=
 =?utf-8?B?M3hvTG9Gc1NRTStUTlZ5Wk42VStHVTdSTnBhemsrZzdrV3VCcVhSemswaWIr?=
 =?utf-8?B?Q1l3RE9yWUF3TVNjV0VTQVNZRXhlVHF1L3BmZU1wUTdEckZwdVI0T1lIeGhn?=
 =?utf-8?B?eHdSNVJPUkJ5MHVpcjlTZWV6Sys3VFBhT3kvTDhKYTRRRFhoNzFreitOSU54?=
 =?utf-8?B?ZFF5WDAxV05KQm5oME1MbDcvdmhtZmd2cXFaTkY4dWZIK0lpeERIa3lyTGFa?=
 =?utf-8?B?TFFiQ0ZRdDhSemhpMEU5S1Zzd1dPajUzNEo4VkM5WFpsR1FmQ0VOOXhFZ0Zk?=
 =?utf-8?B?YTkwZzZEV2FkYVB5WDRSbnFWbHAyN2ovckZmdU5ObEpzcVIxZTQzU0lkVm4v?=
 =?utf-8?B?QnR6ZG1qRzU0KzJTWjIzTkgzdEFGeExzWU1hWlIvZDczNFFpTlFXSlJaMUNi?=
 =?utf-8?B?VDFVamd1MVFNOXVyZ2xMSmp0YWlGSUtadllJRDhDMmlvSVFJTUliSHVOMWNS?=
 =?utf-8?B?RjZTOE55SVJaZ0RqWjZZQkJNbjJCT2M4SExRWnhLeHhCT09iWldoRkR1a1hR?=
 =?utf-8?B?SHRQRld6ZW9HenFlVGpvUmF6a3JEcmVMSDR4TTY0dkJGZ0dZS0I2RzNMSDBU?=
 =?utf-8?B?K1hHbGJsVHNnWUNzcm1heHlqdTZpNGNmaTFlc3d4Ynk5SThidHpKNFdJNGxj?=
 =?utf-8?B?V3pHMko2ZE1MYnU2d1RZaG0zZWxjUUtPN0JrNnRyUCs3SXpXSWt4bGpQTW96?=
 =?utf-8?B?cklCNElCT2c0dHJXblNSNmdMMXN4Y2cxbit1UzlWbzVUelVwdE5XUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3c8a9c-7d31-49d3-8a54-08de63b850e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 06:40:40.9262 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nhfLq8K0EqUEDrXZoJ1fYqY5dEArljgFLguIB8bk1VjlnNf9FJCLqMwTcjHdmiStRR86Q+cTRp95Iow8zNFQFYLwfiHEyjjDRi4bUZUwX8s=
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
X-Mailman-Approved-At: Wed, 04 Feb 2026 02:17:22 -0500
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

Q29ubmVjdCB0aGUgU0dQSU9NIGRldmljZSB0byBBU1QxNzAwIG1vZGVsLgoKU2lnbmVkLW9mZi1i
eTogS2FuZS1DaGVuLUFTIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+ClJldmlld2VkLWJ5OiBD
77+9ZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogTmFiaWggRXN0
ZWZhbiA8bmFiaWhlc3RlZmFuQGdvb2dsZS5jb20+ClRlc3RlZC1ieTogTmFiaWggRXN0ZWZhbiA8
bmFiaWhlc3RlZmFuQGdvb2dsZS5jb20+Ci0tLQogaW5jbHVkZS9ody9hcm0vYXNwZWVkX2FzdDE3
MDAuaCB8ICAzICsrKwogaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmMgICAgICAgICB8IDIxICsrKysr
KysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9ody9hcm0vYXNwZWVkX2FzdDE3MDAuaCBiL2luY2x1ZGUvaHcvYXJt
L2FzcGVlZF9hc3QxNzAwLmgKaW5kZXggOGRiNTEzYTM4Yy4uYjVjYjBhOTAxMCAxMDA2NDQKLS0t
IGEvaW5jbHVkZS9ody9hcm0vYXNwZWVkX2FzdDE3MDAuaAorKysgYi9pbmNsdWRlL2h3L2FybS9h
c3BlZWRfYXN0MTcwMC5oCkBAIC0xMiw2ICsxMiw3IEBACiAjaW5jbHVkZSAiaHcvbWlzYy9hc3Bl
ZWRfc2N1LmgiCiAjaW5jbHVkZSAiaHcvYWRjL2FzcGVlZF9hZGMuaCIKICNpbmNsdWRlICJody9n
cGlvL2FzcGVlZF9ncGlvLmgiCisjaW5jbHVkZSAiaHcvZ3Bpby9hc3BlZWRfc2dwaW8uaCIKICNp
bmNsdWRlICJody9pMmMvYXNwZWVkX2kyYy5oIgogI2luY2x1ZGUgImh3L21pc2MvYXNwZWVkX2x0
cGkuaCIKICNpbmNsdWRlICJody9taXNjL2FzcGVlZF9wd20uaCIKQEAgLTE5LDYgKzIwLDcgQEAK
ICNpbmNsdWRlICJody93YXRjaGRvZy93ZHRfYXNwZWVkLmgiCiAjaW5jbHVkZSAiaHcvY2hhci9z
ZXJpYWwtbW0uaCIKIAorI2RlZmluZSBBU1QxNzAwX1NHUElPX05VTSAgICAgICAgICAgIDIKICNk
ZWZpbmUgQVNUMTcwMF9XRFRfTlVNICAgICAgICAgICAgICA5CiAKICNkZWZpbmUgVFlQRV9BU1BF
RURfQVNUMTcwMCAiYXNwZWVkLmFzdDE3MDAiCkBAIC00MCw2ICs0Miw3IEBAIHN0cnVjdCBBc3Bl
ZWRBU1QxNzAwU29DU3RhdGUgewogICAgIEFzcGVlZEFEQ1N0YXRlIGFkYzsKICAgICBBc3BlZWRT
Q1VTdGF0ZSBzY3U7CiAgICAgQXNwZWVkR1BJT1N0YXRlIGdwaW87CisgICAgQXNwZWVkU0dQSU9T
dGF0ZSBzZ3Bpb21bQVNUMTcwMF9TR1BJT19OVU1dOwogICAgIEFzcGVlZEkyQ1N0YXRlIGkyYzsK
ICAgICBBc3BlZWRQV01TdGF0ZSBwd207CiAgICAgQXNwZWVkV0RUU3RhdGUgd2R0W0FTVDE3MDBf
V0RUX05VTV07CmRpZmYgLS1naXQgYS9ody9hcm0vYXNwZWVkX2FzdDE3MDAuYyBiL2h3L2FybS9h
c3BlZWRfYXN0MTcwMC5jCmluZGV4IGMwYjI4OGEwZmMuLjE3NDE4Njk2NGUgMTAwNjQ0Ci0tLSBh
L2h3L2FybS9hc3BlZWRfYXN0MTcwMC5jCisrKyBiL2h3L2FybS9hc3BlZWRfYXN0MTcwMC5jCkBA
IC0yMyw2ICsyMyw4IEBAIGVudW0gewogICAgIEFTUEVFRF9BU1QxNzAwX0RFVl9BREMsCiAgICAg
QVNQRUVEX0FTVDE3MDBfREVWX1NDVSwKICAgICBBU1BFRURfQVNUMTcwMF9ERVZfR1BJTywKKyAg
ICBBU1BFRURfQVNUMTcwMF9ERVZfU0dQSU9NMCwKKyAgICBBU1BFRURfQVNUMTcwMF9ERVZfU0dQ
SU9NMSwKICAgICBBU1BFRURfQVNUMTcwMF9ERVZfSTJDLAogICAgIEFTUEVFRF9BU1QxNzAwX0RF
Vl9VQVJUMTIsCiAgICAgQVNQRUVEX0FTVDE3MDBfREVWX0xUUElfQ1RSTCwKQEAgLTM3LDYgKzM5
LDggQEAgc3RhdGljIGNvbnN0IGh3YWRkciBhc3BlZWRfYXN0MTcwMF9pb19tZW1tYXBbXSA9IHsK
ICAgICBbQVNQRUVEX0FTVDE3MDBfREVWX0FEQ10gICAgICAgPSAgMHgwMEMwMDAwMCwKICAgICBb
QVNQRUVEX0FTVDE3MDBfREVWX1NDVV0gICAgICAgPSAgMHgwMEMwMjAwMCwKICAgICBbQVNQRUVE
X0FTVDE3MDBfREVWX0dQSU9dICAgICAgPSAgMHgwMEMwQjAwMCwKKyAgICBbQVNQRUVEX0FTVDE3
MDBfREVWX1NHUElPTTBdICAgPSAgMHgwMEMwQzAwMCwKKyAgICBbQVNQRUVEX0FTVDE3MDBfREVW
X1NHUElPTTFdICAgPSAgMHgwMEMwRDAwMCwKICAgICBbQVNQRUVEX0FTVDE3MDBfREVWX0kyQ10g
ICAgICAgPSAgMHgwMEMwRjAwMCwKICAgICBbQVNQRUVEX0FTVDE3MDBfREVWX1VBUlQxMl0gICAg
PSAgMHgwMEMzM0IwMCwKICAgICBbQVNQRUVEX0FTVDE3MDBfREVWX0xUUElfQ1RSTF0gPSAgMHgw
MEMzNDAwMCwKQEAgLTE0Nyw2ICsxNTEsMTcgQEAgc3RhdGljIHZvaWQgYXNwZWVkX2FzdDE3MDBf
cmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApCiAgICAgbWVtb3J5X3JlZ2lv
bl9hZGRfc3VicmVnaW9uKCZzLT5pb21lbSwKICAgICAgICAgICAgICAgICAgICAgICAgIGFzcGVl
ZF9hc3QxNzAwX2lvX21lbW1hcFtBU1BFRURfQVNUMTcwMF9ERVZfTFRQSV9DVFJMXSwKICAgICAg
ICAgICAgICAgICAgICAgICAgIHN5c2J1c19tbWlvX2dldF9yZWdpb24oU1lTX0JVU19ERVZJQ0Uo
JnMtPmx0cGkpLCAwKSk7CisKKyAgICAvKiBTR1BJT00gKi8KKyAgICBmb3IgKGludCBpID0gMDsg
aSA8IEFTVDE3MDBfU0dQSU9fTlVNOyBpKyspIHsKKyAgICAgICAgaWYgKCFzeXNidXNfcmVhbGl6
ZShTWVNfQlVTX0RFVklDRSgmcy0+c2dwaW9tW2ldKSwgZXJycCkpIHsKKyAgICAgICAgICAgIHJl
dHVybjsKKyAgICAgICAgfQorICAgICAgICBtZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdpb24oJnMt
PmlvbWVtLAorICAgICAgICAgICAgICAgICAgICBhc3BlZWRfYXN0MTcwMF9pb19tZW1tYXBbQVNQ
RUVEX0FTVDE3MDBfREVWX1NHUElPTTAgKyBpXSwKKyAgICAgICAgICAgICAgICAgICAgc3lzYnVz
X21taW9fZ2V0X3JlZ2lvbihTWVNfQlVTX0RFVklDRSgmcy0+c2dwaW9tW2ldKSwgMCkpOworICAg
IH0KKwogICAgIC8qIFdEVCAqLwogICAgIGZvciAoaW50IGkgPSAwOyBpIDwgQVNUMTcwMF9XRFRf
TlVNOyBpKyspIHsKICAgICAgICAgQXNwZWVkV0RUQ2xhc3MgKmF3YyA9IEFTUEVFRF9XRFRfR0VU
X0NMQVNTKCZzLT53ZHRbaV0pOwpAQCAtMjAwLDYgKzIxNSwxMiBAQCBzdGF0aWMgdm9pZCBhc3Bl
ZWRfYXN0MTcwMF9pbnN0YW5jZV9pbml0KE9iamVjdCAqb2JqKQogICAgIG9iamVjdF9pbml0aWFs
aXplX2NoaWxkKG9iaiwgImx0cGktY3RybCIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
JnMtPmx0cGksIFRZUEVfQVNQRUVEX0xUUEkpOwogCisgICAgLyogU0dQSU9NICovCisgICAgZm9y
IChpbnQgaSA9IDA7IGkgPCBBU1QxNzAwX1NHUElPX05VTTsgaSsrKSB7CisgICAgICAgIG9iamVj
dF9pbml0aWFsaXplX2NoaWxkKG9iaiwgImlvZXhwLXNncGlvbVsqXSIsICZzLT5zZ3Bpb21baV0s
CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJhc3BlZWQuc2dwaW8tYXN0MjcwMCIp
OworICAgIH0KKwogICAgIC8qIFdEVCAqLwogICAgIGZvciAoaW50IGkgPSAwOyBpIDwgQVNUMTcw
MF9XRFRfTlVNOyBpKyspIHsKICAgICAgICAgb2JqZWN0X2luaXRpYWxpemVfY2hpbGQob2JqLCAi
aW9leHAtd2R0WypdIiwKLS0gCjIuNDMuMAo=

