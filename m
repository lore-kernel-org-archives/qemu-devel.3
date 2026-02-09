Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1243EF06EF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 02:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpH3y-0006zT-3h; Sun, 08 Feb 2026 21:31:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpH3U-0006x8-BR; Sun, 08 Feb 2026 21:31:28 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpH3R-00016h-G6; Sun, 08 Feb 2026 21:31:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N1tzGpikaOrlux7xNtPifqQyT+5KsU9FX5IciUMWw3h4187ZNuvdB/M3ATARPxXZt5U8X9Ip3/GZhYFEMVRhVl6ozjjSyLUKTBd6JhxAtJ7X44uYnodFnjOgKgUMQYQfL671A9BZiUi5CYDSUQHBnJs9fat1UAFTkNa5xNkBnMincrRdhWsnkNfn7aOgR7xrLy7lFmKQc4cyywKvaxRYdbIl8hzfc35L0vycvprIRDfF+b9wjO+sXwUCXHlLwhC6WGUIohNyisAILlR/f5+F6fZfSLw2/d9w10ck3AKryqQQ8VIS6uW3REIAtcH5Tu0+BUysx1frdOt5y4wYxpMsuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzigvargTL/xn6LZZOBZfabY0F7NcEahfqrRfhvdYLU=;
 b=U6HS+CtXvg9orkXbE+q1ai8G6OyLHx7G5LpV0nqEJJNFeoWW0ajpy+z9y7Bp1D+1WjzwWFNKiGD/CkShJ5hj0JrzRV/a79s1sYVsGDLntxXBf5syEhqCQs1qbfStA3s/D3nlSmBmNM9JgE5TRCcoWZEmH/9YFZJ91i1r3CXk0XH4rY1n5wFeh0e+Fl6B/64D2h4pB4WFmhrfi0OdLfa0PAm7+ULMdOthF86eznHUIRySBosO1itO1g5Vx0qr0JgxLknwU8U6vKSuZ3ELQrqJwSNkaiSHcwBGug4n5ly/c7nv5XdEuzwvUr3AjdlV2sQlWnChDI5If1TsGAUvEWjkhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzigvargTL/xn6LZZOBZfabY0F7NcEahfqrRfhvdYLU=;
 b=eMZVte/JtdHxTZb2VEP4cVRjL3FfWX5cCnHM6ndHOv00e4yhRU2Iy7JJrmVjugDAUhnohUM00QcnThNOguOU4KaHv6UwDBUeaOBQA+p9GTCpc0BX4E9jruySU5PyvWdX9kxdUixAl2bwOehRphxlI4DGk1hjODmOYrKC3gbPReri87zdCFpajH+17GlJ4LEgDlJwt+jNvyL1Ju5r15yIJsHMUMrC443eptdm9SIgOYT+om3XDp43Jp89khZLOQLaHg0hEHby2DTyqQRiLDl6F1KyR1RIGQZh13B0TWmfKEE81/B3xB+8toas2ZU6/FjWzxAtwWzNBMEWftC+bsGcww==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KU2PPF02E3DE66D.apcprd06.prod.outlook.com (2603:1096:d18::485)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 02:31:05 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 02:31:05 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: RE: [PATCH v1 09/10] hw/arm/aspeed_ast27x0-fc: Switch AST2700 FC
 machine to A2 SoC
Thread-Topic: [PATCH v1 09/10] hw/arm/aspeed_ast27x0-fc: Switch AST2700 FC
 machine to A2 SoC
Thread-Index: AQHclyouwD6aanSPIEaw828nuwlkK7V1cG0AgAQ41JA=
Date: Mon, 9 Feb 2026 02:31:04 +0000
Message-ID: <TYPPR06MB8206C31A5D92AD88CBD53950FC65A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
 <20260206053340.3716041-11-jamin_lin@aspeedtech.com>
 <4be69752-9494-4af2-a9a9-3af59f2a577c@kaod.org>
In-Reply-To: <4be69752-9494-4af2-a9a9-3af59f2a577c@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KU2PPF02E3DE66D:EE_
x-ms-office365-filtering-correlation-id: 4064f32a-ce50-4751-9ed6-08de6783463c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|921020|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?bmFJemRCM0UwREJ2UjhoZWhXajhDMHR0UUZWOFBFY3ltdjBzWHdBZS8rOVc4?=
 =?utf-8?B?MVdwRUpGbGtsKytHbGtodVBPZHlEVEdwcTdBVDFwbm41cTMvMHpPQjRpU20z?=
 =?utf-8?B?RkkvMS9FdGFMSVI0QXR6dUY4dmViV1JIekJzSlR0cC9EK3dVQzlkUk1PSHlB?=
 =?utf-8?B?NlFQdTIwUDBlRHFGQjJCdTU2emRUQlEyUHdkL252L3U0YXVuSGFaVHFCLzVN?=
 =?utf-8?B?V2xRcHFvaUpmUTBNSW1mSWsxS3NWU1N6ZDM4K2RKYW8zOVdrMWd4Sk4zT00x?=
 =?utf-8?B?QzhWOTBHMWtkSU8yU29TRitMM2hpQUQ5elc4eitzcWtQRzg4YUQwYVN0K1hh?=
 =?utf-8?B?clc2OUlITWdXcjB3UjhVSnMyZmdWbkZvRDF4dFcvZ01oK01UTmR5TklINlk0?=
 =?utf-8?B?elAxbFU2VGQ1N3l6MXVJcTR6OFdRTDR1OFdTaWFGRmNtaUN3UVdnT2xEYUtQ?=
 =?utf-8?B?WE91TlRVT0xmYmpkUGJ1WGJqdHZYZXpTeGVOdGMzMWxDUmgyUnNNMFRobXRz?=
 =?utf-8?B?VUtJRjBLd0N4cUpxL25JRnlCaklrVGdMZU1PNG5QV2ZhbXNEdm1WZ1dOdngx?=
 =?utf-8?B?YnlBZTZDSkJyeDZFQmoxWDR2VzRJYW9Wd2xLOXAvZXdMK3JOL1hpZlVLV1VP?=
 =?utf-8?B?dnREZWI2U3ZTQThuOEszVjdsUlQrLzR0TUpLRm5TRU5lVXkySzk5MitVdVZ1?=
 =?utf-8?B?YnlqSVFMS2ZhRE50cXlrdzdzS1ZpWlJCN2I5Y1c0Nk1XN2JEb0hubFgyMmp0?=
 =?utf-8?B?dVRydEZQZmhxWU1Ednk5OTU3bGNVbXhuWVlqbzVMMnlXSG1Nd005YjR3NWdM?=
 =?utf-8?B?NS9LZURVSytXSkZ0UjMydTcxVnltYkowenBRZlEwdmFWUURhVkZJZkJ6cVZW?=
 =?utf-8?B?NDVRUlNvWXVldGFJWW9rYTVKVGo2em9HUmpXN09tZUJIWmtJWGtkcUQzblY4?=
 =?utf-8?B?TElXWlNyM2VsWFpDRklXek5rclExUFJsTTNEUklUbGd3UGpnWTl1YkR5b2xJ?=
 =?utf-8?B?cmptRzY0Skd5V1k0R0FOdGlnVUVvMndXVkhZZ2U5WGZKZ3JDSDJtaTEwempE?=
 =?utf-8?B?d1RZcWFVNVVqSmROREdLb1RGNXVkSTIrU3ljSm5HUHdlWmNFQVlIcGN2TnMv?=
 =?utf-8?B?OHlqdFlMU2JScEx5eFh1dmJHL2lhdy9KTTFvVEY0R0plRHpEbk90MzFDS0RO?=
 =?utf-8?B?Sjh3ZFk3Ky9vRG9pamZoWDB5STNWUUVVOTVCTFFMdERlR1JqUkk1eDJnU2hZ?=
 =?utf-8?B?VmJtbU9uR2hSME80T1N0QStUaDNtMFB6TFh5Ti8vYWY0Q2JHdHJQRmpLMHRs?=
 =?utf-8?B?dEkrWXVJYitIQW92SEludUoyRC9OYVNXYUtIQ3RyOGI4cXk1aUtWV2tCN3N3?=
 =?utf-8?B?ejE2SDVPckVweVhqUHh3aS9xVFlML2VwVXREZDV4R3RRZVM1Yld3NnN2Mmxr?=
 =?utf-8?B?NGtNbFE5UmhCeUFkbTEvdzhwRGY1Z0RPbUxiR3Yvc1JqeE16NXNyL2JYZWRo?=
 =?utf-8?B?K1RWVGx1VGhjWmFHRUNtWU1BZjl1algzVlBMd05xSzQxZFQvQms5ZTBqWnc0?=
 =?utf-8?B?ZGViVEs4MWw1UUkyWldnTGdscmtsbDk0UXBqOStrRkpCbFdwSGdZT2JidnVa?=
 =?utf-8?B?Z1UxTzlMVVZmNnlOSUFzRWd6UHhGeHJYdmNDQjRKdGRZUEtyc2ttemZHa044?=
 =?utf-8?B?Z1dvNVZYODhXV2NmeTJjU3ZnYXJycmZHUHpwOFcvQzZjSzcra0JLRFpWSmd4?=
 =?utf-8?B?YlJTaTc4QU9JaFc1enNqL0VqK01DTDJBaEcyUERaak83cmczL1cxR20rdTJn?=
 =?utf-8?B?NEl1Y25ubllVSGNMZERlZGh1RzljazBrU1Nwd0czYi80VEFxeGtqOGplRGdw?=
 =?utf-8?B?K0dQOHV6am1TR0kvdTFMK1EzdlFSOFo2ODBwRFZ1SHpIUFNSak9GYzZCcDh2?=
 =?utf-8?B?WDNhc1czV0tvbUFPWDlKUFZhUWRrMzN6N05qSGxyOHZlbE9pb29yUzRKT0l6?=
 =?utf-8?B?RFYvWkMvVkorUHZBSUVoMTB3NDNhTG50MitzR0J4blN6bzV0NFJaU1VXVWFo?=
 =?utf-8?B?NlF6eDV3aWVaTVRuU3FwSEFLMUp6aDI5b08vS0l0M21nQmJKS3JZYys4V1BX?=
 =?utf-8?B?M2dIMkhiQ0p6cnpyU2dGWXFVMXlkMFhsMko1R0xUVTNVWlNNWjdKeU11ekhN?=
 =?utf-8?Q?qbUFqMuYeKX7KvZcn78FoonbZkUN59rF7oEY8E1ys8XM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHI0YmNQMnhDMXM2MzhadlZjYzR2NGpUNjFYSVNwTUVCWFRQSVkrNjJtYnpa?=
 =?utf-8?B?cVJndllJSThVN2hPT0xuN0pxQkY2WTVMWXJCQTMzRjVZMkxMUFZvRXI3Smxp?=
 =?utf-8?B?L2N3a1Z0NXY1dTI5b05NUzBqUWJHNkQ2QkpOYzE1UjZ6OUhlSWNaS3pjcXJZ?=
 =?utf-8?B?V1A1RzFoZGZ2dUZhbWtxTmQ1d21jbEltQ1lBOG51QTBSZllCcnkyTENITWgy?=
 =?utf-8?B?V09Pb1BCbUk4MW9KbGs3aklLSmRoTmI2WXBkSnNNZzRJaWZ0b09EakNZS0tK?=
 =?utf-8?B?VDB0R1pjYUtrSWtYbUZGRjVmS1d4eE5XdVJmUzB6RFo3REZ5SlZLcXB6czNp?=
 =?utf-8?B?WWFlUXFja29qb003c0xLcjdKK0NLSHNQd1FqY3ZOc3N1SXA3Q2xuUzVRdFVn?=
 =?utf-8?B?VDR5cFJ4YzlVRUtTYllUOVoyM3JlbGFPbmU4dXdTYkk4TUZzRU9GY0FOZnFM?=
 =?utf-8?B?dE55SmprK3RuMVhFK3U2cXlaMkR0S2V5dkpOK0tqTGVSR1JCZEV2YlF4NnRj?=
 =?utf-8?B?MVZFYng2NkJZcHNFVWYvY3FkNXBWRFZKVy9WV2FJU01GMEpKTk9SWUtSL2Q0?=
 =?utf-8?B?TmNhNCtodEt4Z3l6TWJnM2N1NkM5UXpWT3FPcE5zNjJkZWhvdDA2OEdsenlH?=
 =?utf-8?B?TE15SXVvRTNFUXdhM05BSWhhTzVhZVAzdUlpdldoUS8wUGxOS0k0akl0aGdD?=
 =?utf-8?B?MCtCb2ZyaGliTld6QzhwcnJrL09JeXFJczljbkl3RmNJMWg3MThDVjU4N2hC?=
 =?utf-8?B?ZDBpOFcyT0tqQzE5b0pkRlE4d3d2WDZ6SkZ4VjZlenRKM3dVOVFYNS9Ga0Ix?=
 =?utf-8?B?Q0V3dzUwSUYvRXgwdHJwUysweDVTL1lsQm1RNUswR2YwZ0htSEVweitPdGs4?=
 =?utf-8?B?VGh0OFFaWDh4ZW5uRXVYQWxSaEdRWHBQTm5oK3NLRWZPZ09JVnlad0Y3d1Rk?=
 =?utf-8?B?WGx5clFpQUxwWS9NbmpXL1FLby9pUDV3Qmk5VDd2YTJYWTIyOTRZcFJzZnZW?=
 =?utf-8?B?ZTZEVWxjQkdDd2hxWW5jV0FwQVNrWXBSdEdVUE1kWWE0N2djYXVaNnN2VFJQ?=
 =?utf-8?B?MmpTOVcwaWhNbkFTSTk4NUlXblA1SGtTZjVFOXpjaWdwMzJZYklEc0tlbnBu?=
 =?utf-8?B?MzlUZWM2QUNQRHJpTTl1N01tNUNudkxuSkxRZmx2bWFSdjZOUjgyUmZuR3o2?=
 =?utf-8?B?SWpycUN6MFJ2T1dtbnp5Szc0WXQ1K0dSQWpHVngxWTQzTUxXZkNTaCtxVjRx?=
 =?utf-8?B?dGxHZzFzLzljWUdsbVFmTzZCcm5Nd1dvMXFhYk02VWc4c2lTbFkxa0pBOUVv?=
 =?utf-8?B?V1hTVE1jSUNsV1dNMWdIK2NKNHdjWEdUeDd1SE1OSmZiQmVpcmtNaFFwUU10?=
 =?utf-8?B?US85Uk1XREdlcTlkR0Q2cFdvNWd4WHh0WDFQMzFOWEJ2OFlEd2ZSdjQ5TTRH?=
 =?utf-8?B?dElibWFFanZBa0FPWVk4SHlzSi9wb1pxWXBsUzljRXcwWnNsUno3dGRNc2d2?=
 =?utf-8?B?cWZwcncrdDFvQVVGZXlzdjh5QURXV3VmaXdVMVlMNnZhOXUzODFYT2p6T3JX?=
 =?utf-8?B?d1hjTXZXemZKeXlkYk8wajBxRGd1MGZJNkl6TzRjQndIYis3RlFSLzdlaU5y?=
 =?utf-8?B?QkF2VjNrZ21UT3I0aEN4QkVwQVNBQ2ZpRkR0TmhwcWE0dkVMcUZVd0lGS1FS?=
 =?utf-8?B?YXVmRTlGOFlLdmFIVXcvWmdzeUtDcEJPQitOSWloK0hkUUw4TFBmV2lTUzVC?=
 =?utf-8?B?ajJYYmkwZy8vbEd5QWtZZ3lkQm1PcG9DUzV5SUNGMkl0eHh6ZUtzbGpJYldH?=
 =?utf-8?B?NUE5TmdJS3BtZG1UY2lIdU1YVmI1ZlQwckcxQ2hTOEgzY2duQUNuTXo4S3JX?=
 =?utf-8?B?YkduN3VzQTBtK0ZwUFR6c3hpcUk2Nk5mQzFka3JtRTRFN3ZQdXdrcllwZ1ps?=
 =?utf-8?B?Z3pWYjhRZ1JBK3dTODQzRGhadzhpaEtJYTBkcHZhZTQya0dyRXREY2g1cWZ6?=
 =?utf-8?B?OStnVHFSWjRVbXEwczZmcWhRdSsxNjVFSTRYSzJhbHVaWFNyVTFoSVh5bUpS?=
 =?utf-8?B?VVA4TXQyVUc5TUJRVG1ycGNxanBETFpNWFEvd0V0QnpiT2xkRjJTTGM5SUp0?=
 =?utf-8?B?cTVIUURUcFhvRi9BRFJjUk1tTENXU1IwZnp2SVVTMEdIZGt3MDNPeVhOVEtw?=
 =?utf-8?B?cy9RZTZ3ODdLZVMweUQvK3c3bENrL2xLdERPZzVmd09RanQ3aXBBcDVQL2lG?=
 =?utf-8?B?aGFKZTRNZ0ZrTS9VQ041MGQrUThnTXczRnBqNnE1ejFFa1NjMmVxOE1XL3Rj?=
 =?utf-8?B?UkxraVFlSnp4UjExaXp0S1BnaEhscHlmYTlibGk1OVh1cG5kYS9Sdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4064f32a-ce50-4751-9ed6-08de6783463c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 02:31:04.9592 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SSmjHYNRlR3CSxmL4A79gXZhyD9l8ioeinsjH+5OjB0Ip5csNMYJitFfewCOmzrzB3WoRj2oIiTTu3A9SrozIehG2aLm5i6EX13/WZA8VyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPF02E3DE66D
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDkvMTBdIGh3L2FybS9hc3Bl
ZWRfYXN0Mjd4MC1mYzogU3dpdGNoIEFTVDI3MDAgRkMNCj4gbWFjaGluZSB0byBBMiBTb0MNCj4g
DQo+IE9uIDIvNi8yNiAwNjozMywgSmFtaW4gTGluIHdyb3RlOg0KPiA+IFVwZGF0ZSB0aGUgQVNU
MjcwMCBGQyBtYWNoaW5lIHRvIHVzZSB0aGUgQVNUMjcwMCBBMiBTb0MgbW9kZWwgaW5zdGVhZA0K
PiA+IG9mIHRoZSBBMS1zcGVjaWZpYyB2YXJpYW50Lg0KPiA+DQo+ID4gVGhpcyBjaGFuZ2UgcmVt
b3ZlcyBBMS1zcGVjaWZpYyBuYW1pbmcgYW5kIGRlZmluaXRpb25zIGZyb20gdGhlIEZDDQo+ID4g
bWFjaGluZSBhbmQgYWxpZ25zIGl0IHdpdGggdGhlIG5ld2VyIEFTVDI3MDAgQTIgc2lsaWNvbi4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2gu
Y29tPg0KPiA+IC0tLQ0KPiA+ICAgaHcvYXJtL2FzcGVlZF9hc3QyN3gwLWZjLmMgfCAxNSArKysr
KysrLS0tLS0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDggZGVs
ZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLWZj
LmMgYi9ody9hcm0vYXNwZWVkX2FzdDI3eDAtZmMuYw0KPiA+IGluZGV4IDA1MDJhMTM3ZjMuLjVl
YjY2ODBkYTkgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLWZjLmMNCj4g
PiArKysgYi9ody9hcm0vYXNwZWVkX2FzdDI3eDAtZmMuYw0KPiA+IEBAIC0yNCw4ICsyNCw4IEBA
DQo+ID4gICAjaW5jbHVkZSAiaHcvYXJtL2FzcGVlZF9jb3Byb2Nlc3Nvci5oIg0KPiA+ICAgI2lu
Y2x1ZGUgImh3L2FybS9tYWNoaW5lcy1xb20uaCINCj4gPg0KPiA+IC0jZGVmaW5lIFRZUEVfQVNU
MjcwMEExRkMgTUFDSElORV9UWVBFX05BTUUoImFzdDI3MDBmYyIpDQo+ID4gLU9CSkVDVF9ERUNM
QVJFX1NJTVBMRV9UWVBFKEFzdDI3MDBGQ1N0YXRlLCBBU1QyNzAwQTFGQyk7DQo+ID4gKyNkZWZp
bmUgVFlQRV9BU1QyNzAwRkMgTUFDSElORV9UWVBFX05BTUUoImFzdDI3MDBmYyIpDQo+ID4gK09C
SkVDVF9ERUNMQVJFX1NJTVBMRV9UWVBFKEFzdDI3MDBGQ1N0YXRlLCBBU1QyNzAwRkMpOw0KPiA+
DQo+ID4gICBzdGF0aWMgc3RydWN0IGFybV9ib290X2luZm8gYXN0MjcwMGZjX2JvYXJkX2luZm8g
PSB7DQo+ID4gICAgICAgLmJvYXJkX2lkID0gLTEsIC8qIGRldmljZS10cmVlLW9ubHkgYm9hcmQg
Ki8gQEAgLTQ4LDggKzQ4LDcgQEANCj4gPiBzdHJ1Y3QgQXN0MjcwMEZDU3RhdGUgew0KPiA+ICAg
ICAgIEFzcGVlZDI3eDBDb3Byb2Nlc3NvclN0YXRlIHRzcDsNCj4gPiAgIH07DQo+ID4NCj4gPiAt
I2RlZmluZSBBU1QyNzAwRkNfQk1DX1JBTV9TSVpFICgxICogR2lCKSAtI2RlZmluZQ0KPiA+IEFT
VDI3MDBGQ19DTTRfRFJBTV9TSVpFICgzMiAqIE1pQikNCj4gPiArI2RlZmluZSBBU1QyNzAwRkNf
Qk1DX1JBTV9TSVpFICgyICogR2lCKQ0KPiANClRoZSBhc3QyNzAwYTItZXZiIG1hY2hpbmUgaXMg
bGFyZ2VseSBpZGVudGljYWwgdG8gYXN0MjcwMGExLWV2Yi4NClRoZSBvbmx5IGRpZmZlcmVuY2Ug
aXMgdGhlIGRlZmF1bHQgRFJBTSBzaXplLCB3aGljaCBpcyBpbmNyZWFzZWQNCnRvIDIgR0IuIFNv
LCBJIHVwZGF0ZWQgdGhlIERSQU0gc2l6ZSB0byAyR2lCLg0KU2hvdWxkIEkgc2VwYXJhdGUgdGhl
IHBhdGNoIHRvIHVwZGF0ZSB0aGUgRFJBTSBzaXplPw0KDQpUaGFua3MsDQpKYW1pbg0KPiANCj4g
VGhpcyBpcyBhbiB1bnJlbGF0ZWQgY2hhbmdlLg0KPiANCj4gVGhhbmtzLA0KPiANCj4gQy4NCj4g
DQo+ID4gICAjZGVmaW5lIEFTVDI3MDBGQ19IV19TVFJBUDEgMHgwMDAwMDBDMA0KPiA+ICAgI2Rl
ZmluZSBBU1QyNzAwRkNfSFdfU1RSQVAyIDB4MDAwMDAwMDMgQEAgLTU4LDcgKzU3LDcgQEAgc3Ry
dWN0DQo+ID4gQXN0MjcwMEZDU3RhdGUgew0KPiA+DQo+ID4gICBzdGF0aWMgYm9vbCBhc3QyNzAw
ZmNfY2EzNV9pbml0KE1hY2hpbmVTdGF0ZSAqbWFjaGluZSwgRXJyb3IgKiplcnJwKQ0KPiA+ICAg
ew0KPiA+IC0gICAgQXN0MjcwMEZDU3RhdGUgKnMgPSBBU1QyNzAwQTFGQyhtYWNoaW5lKTsNCj4g
PiArICAgIEFzdDI3MDBGQ1N0YXRlICpzID0gQVNUMjcwMEZDKG1hY2hpbmUpOw0KPiA+ICAgICAg
IEFzcGVlZFNvQ1N0YXRlICpzb2M7DQo+ID4gICAgICAgQXNwZWVkU29DQ2xhc3MgKnNjOw0KPiA+
ICAgICAgIGNvbnN0IGNoYXIgKmJpb3NfbmFtZSA9IE5VTEw7DQo+ID4gQEAgLTY2LDcgKzY1LDcg
QEAgc3RhdGljIGJvb2wgYXN0MjcwMGZjX2NhMzVfaW5pdChNYWNoaW5lU3RhdGUNCj4gKm1hY2hp
bmUsIEVycm9yICoqZXJycCkNCj4gPiAgICAgICBEZXZpY2VTdGF0ZSAqZGV2ID0gTlVMTDsNCj4g
PiAgICAgICB1aW50NjRfdCByb21fc2l6ZTsNCj4gPg0KPiA+IC0gICAgb2JqZWN0X2luaXRpYWxp
emVfY2hpbGQoT0JKRUNUKHMpLCAiY2EzNSIsICZzLT5jYTM1LCAiYXN0MjcwMC1hMSIpOw0KPiA+
ICsgICAgb2JqZWN0X2luaXRpYWxpemVfY2hpbGQoT0JKRUNUKHMpLCAiY2EzNSIsICZzLT5jYTM1
LA0KPiA+ICsgImFzdDI3MDAtYTIiKTsNCj4gPiAgICAgICBzb2MgPSBBU1BFRURfU09DKCZzLT5j
YTM1KTsNCj4gPiAgICAgICBzYyA9IEFTUEVFRF9TT0NfR0VUX0NMQVNTKHNvYyk7DQo+ID4NCj4g
PiBAQCAtMTM1LDcgKzEzNCw3IEBAIHN0YXRpYyBib29sIGFzdDI3MDBmY19jYTM1X2luaXQoTWFj
aGluZVN0YXRlDQo+ID4gKm1hY2hpbmUsIEVycm9yICoqZXJycCkNCj4gPg0KPiA+ICAgc3RhdGlj
IGJvb2wgYXN0MjcwMGZjX3NzcF9pbml0KE1hY2hpbmVTdGF0ZSAqbWFjaGluZSwgRXJyb3IgKipl
cnJwKQ0KPiA+ICAgew0KPiA+IC0gICAgQXN0MjcwMEZDU3RhdGUgKnMgPSBBU1QyNzAwQTFGQyht
YWNoaW5lKTsNCj4gPiArICAgIEFzdDI3MDBGQ1N0YXRlICpzID0gQVNUMjcwMEZDKG1hY2hpbmUp
Ow0KPiA+ICAgICAgIEFzcGVlZFNvQ1N0YXRlICpwc3AgPSBBU1BFRURfU09DKCZzLT5jYTM1KTsN
Cj4gPg0KPiA+ICAgICAgIHMtPnNzcF9zeXNjbGsgPSBjbG9ja19uZXcoT0JKRUNUKHMpLCAiU1NQ
X1NZU0NMSyIpOyBAQCAtMTY3LDcNCj4gPiArMTY2LDcgQEAgc3RhdGljIGJvb2wgYXN0MjcwMGZj
X3NzcF9pbml0KE1hY2hpbmVTdGF0ZSAqbWFjaGluZSwgRXJyb3INCj4gPiAqKmVycnApDQo+ID4N
Cj4gPiAgIHN0YXRpYyBib29sIGFzdDI3MDBmY190c3BfaW5pdChNYWNoaW5lU3RhdGUgKm1hY2hp
bmUsIEVycm9yICoqZXJycCkNCj4gPiAgIHsNCj4gPiAtICAgIEFzdDI3MDBGQ1N0YXRlICpzID0g
QVNUMjcwMEExRkMobWFjaGluZSk7DQo+ID4gKyAgICBBc3QyNzAwRkNTdGF0ZSAqcyA9IEFTVDI3
MDBGQyhtYWNoaW5lKTsNCj4gPiAgICAgICBBc3BlZWRTb0NTdGF0ZSAqcHNwID0gQVNQRUVEX1NP
Qygmcy0+Y2EzNSk7DQo+ID4NCj4gPiAgICAgICBzLT50c3Bfc3lzY2xrID0gY2xvY2tfbmV3KE9C
SkVDVChzKSwgIlRTUF9TWVNDTEsiKTsNCg0K

