Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF843D49C66
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 07:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vljJ5-0001vl-Fx; Fri, 30 Jan 2026 02:52:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vljJ0-0001rl-Cq; Fri, 30 Jan 2026 02:52:39 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vljIx-0005xf-9B; Fri, 30 Jan 2026 02:52:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YX52AoT8nXCjBw+UzV0QHZmBYHnwWnZQCVKre9bXQ6MI/LhEORCFjLHnaEetMMYFfSIKH5QdXBcKvixM4sqQl3AmWhwD3YR7VJ8J6vhHElaXW/UkqbEK6HxWvKO4xbOYHCRQcqmhFrYPakQlOnruE5Z4bzl6VmE/kwPAll7/L2BpuPCuviyuw/FC6Ol2MlBDAqdXXk9vHLjySEJuUJPAH0xDi0Yee+PLc6iY0+nZrLm5jxlYtk9QTQzFRkrxRrvLKpnKv05Q6vnwsW74LBkEeiIUuMKSg7gnWHgkvybXDTTM7tXkUD2TidAzEBXuHFgZB+KxrAUAIHy9a4fjWrZyCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jMa+XOE2l5xYo0NsmJGf4E05hgVogfTpVsnfabbOtI=;
 b=i42ihpDzJaukYVvdqh7gUxqjNqppTzVFbBqwv6PK8dcxzmtEMqPZnh+pLdZ3BFWBjHcWXF6xpYTA3UqaiJ+RdJdyKJXagJD9vxbgGQXPc8NeIrkXzIOW2u4OsKwrw2G8jAjONdMk4XnujjncOLI8Q7LHhdnF1JUVuDV4RPpz4s0pPwNZ2q5/mav0HsjpKKimpZadmX9Pzjg3tJbpIz2DSbi9SbUFz0JFCl23JJsl977PsRgKQ29II8bfHGtywDiJ4aO+tSmnZGg0fhk1FBu2LfYNh3bJr+TF4/EPEb93u9VlYDkL8zaDcsv7o3iVap1QsU0nLF8l0zw0BDFOrZ7FZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jMa+XOE2l5xYo0NsmJGf4E05hgVogfTpVsnfabbOtI=;
 b=RCkyWA1cuDuSjctgtq/eEuLi9vcfe6bsiJeO5NHpOhuBg3j+K051+ParOc21ekcK3SC1gNbvmblGoxsxSODchxagL2Upe/driAq7xnUj0Oe4zDH8XiR4kMKsd+r+0vOby07JlXuL6YxqYfwtXibNzRgHYslcSW6kavYOQaW55JjoKz2lgEPZTGxIryzwUHObC/IhVaZ/+JbRBsz9UZNQcvVJiZMd2PJ7P4TPlhssKqyI2HxIEDkK2cU62Fzq+bnOmzoL9QkGSwWROYow9rOU3GyscVdorsWfBTR0rQmEsWiqJIh6tb0AdpGYrSM4S/Iufd+iZVsRyBSyAaaIbzRSsQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY0PR06MB5836.apcprd06.prod.outlook.com (2603:1096:400:31f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 07:52:25 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9564.006; Fri, 30 Jan 2026
 07:52:24 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Kane Chen
 <kane_chen@aspeedtech.com>, Peter Maydell <peter.maydell@linaro.org>, Steven
 Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Nabih Estefan
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>
Subject: RE: [PATCH v5 00/22] hw/arm/aspeed: AST1700 LTPI support and device
 hookups
Thread-Topic: [PATCH v5 00/22] hw/arm/aspeed: AST1700 LTPI support and device
 hookups
Thread-Index: AQHcicxLj69gtQDV7UaGII1il83Fe7VbOqAAgACSMECAA3ulgIAABE0AgAsZXoA=
Date: Fri, 30 Jan 2026 07:52:24 +0000
Message-ID: <TYPPR06MB82063D551A78C621B00F399DFC9FA@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260120051859.1920565-1-kane_chen@aspeedtech.com>
 <1433fb86-bb1b-41f7-b7ec-45560e52146a@kaod.org>
 <SE3PR06MB81997150B11579509E3B31C1FC96A@SE3PR06MB8199.apcprd06.prod.outlook.com>
 <ccf7e1e6-f7fb-483e-b69c-32ab15a9ce0a@kaod.org>
 <TYPPR06MB8206E096C66EF9C504F79146FC94A@TYPPR06MB8206.apcprd06.prod.outlook.com>
In-Reply-To: <TYPPR06MB8206E096C66EF9C504F79146FC94A@TYPPR06MB8206.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TY0PR06MB5836:EE_
x-ms-office365-filtering-correlation-id: e934c295-7f1e-4551-7d47-08de5fd481d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|13003099007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?WUdQdmJCMkMzdUYvd2greEIvTVZXSENZYjBTU1F2d1ZvMU5mS0ZCdjBhUUxG?=
 =?utf-8?B?WEw4ZTRsd2VOZ1ZoeEx1Z1ljNDdhZTBYME1pTjAyYjU3eFFtUXh0aDV2S1pP?=
 =?utf-8?B?bUFOWGNjUjFEV0pxY3llcGk0dlBLbkgvZGpYY3lQNGlyYUIxUVdQazdTV3F0?=
 =?utf-8?B?dm83SExVRDRobk5ZSVFIWmhoUWlMSjNlbWNyWlBrdGREcDlocGhwc1VjMDFD?=
 =?utf-8?B?c1lyWEI1UC9BRDV3aHVRc1ZocGc1M0FuL1FwU09nU095bDM5NXl1SEg5OWEy?=
 =?utf-8?B?djFyeGIzVXN2MUFJM1pEV1ZxNVpveXdzZHQxNTl6RDREVFViVmxhUzFEdUsy?=
 =?utf-8?B?TW5nL0w0ZjEvblBqZEh4NHVNTnJuVmUyeVgrUTRRNDJwaGhHNE5KUk9WUE9u?=
 =?utf-8?B?KzNwTmJiVmh0RDhNQW9tZlpObW9GRXFra1lsTlZnZi8wWFVaUGVuQ2FLM1B0?=
 =?utf-8?B?Q3IvL1hyaVVjRkQwNVJIbEdrYTAwSFE5SS8ySWlIaGprTXdOejM4Q1lnQkFr?=
 =?utf-8?B?NGVwTmxucjhIbG1JOGwyNFQrOHI4cjVuOSt6eElkb1hKNTN4dUgyangxSlE0?=
 =?utf-8?B?T3pzeHcvMHpuYTFCVzN5M01Eck1KOWFDNGdOczBUcU45MlBCVUkvNGZsVEZl?=
 =?utf-8?B?UGY3YnFHeVRrclRocEZEVklGOUtkVkVZNWp4bVhMYVp0WnZmSmxYclBLVVpN?=
 =?utf-8?B?bm9jT0lra2lYbXJGYmgyU3ZCWEZwY2psdERTaTg2UlRIM3IrdkNiY043MW1B?=
 =?utf-8?B?OVE5aEZ6RDN2TmNhS1Ewa2Y1RXFuWGtmdy9JbTRNQWRPdjV5UmcwNzVXc0Fi?=
 =?utf-8?B?ZHE5a01leElIK0NFd3g2TmQ2aXo0YjQ1eXpQY0ZqTU82ZHBzUERBSklXRzd2?=
 =?utf-8?B?RDdaY1l1V0pyMitBRGFvSEVmbUR2WTBMeEszS1lNbDhGV2N4NGQ4ZTZBQ3dF?=
 =?utf-8?B?WkNJNFgwRXZzTWhUazBjZlJOQ1NmZkJlcnZhV0gvRXdsZnFyeURGRmxXNith?=
 =?utf-8?B?Ylh5UE5RbmFFdXYrTGpBelE4MExVNFJnUEJqMjE5emgvM2VEZm9ocVQwZStW?=
 =?utf-8?B?emF5SC9yK0dQY29Sa01TNmZReC9ET1JXOWFSUjE2dlNZWEwxTzJhMFJzeXE0?=
 =?utf-8?B?RlU4bE5BK3VtbGVDL3hPandQTlZMMUxHTDhyN1FDNGY4d01zZmtkakVWWGtR?=
 =?utf-8?B?VkdOcHpJYUcwcXNRQTZUVjFSMXdNeEpycCtiNm1BcHdYQ2NOV0RFMGgwTjFo?=
 =?utf-8?B?ZGtBNnFCeXhscGFvWWFQc2ZnR3JlMFBnNUpwamJWYmtkQm9sa1dNK200WjNw?=
 =?utf-8?B?dmRCYjNxVlFDTFQwZm0rSG1Ta3lvNGlMekR1aTJtcnRLWkdpSWNYTHdXamRx?=
 =?utf-8?B?TllKZjFnNjVpN010Rko4ckk1RVRMYjI2QjNpcHRvWkZHTkozbWtpNHdlQURP?=
 =?utf-8?B?aG1GcUh2VjRUVFZ5Umpzc2tqMG5rMUdHOW5nSnBLT0svcDAxYWFQQ3Q4eFBN?=
 =?utf-8?B?MmVsdG5UQWVjYmJ1SDIzd2NKajluWGVqcG9JYklkSk9GQzZrbDNoS3I2Z3po?=
 =?utf-8?B?WVhodnBWM2x0K1JEWmRWZEtla0RINlRsSkZFcWxuN09mc29VVmgzMzliZWo2?=
 =?utf-8?B?aCtEYkhLQTEvbjVTRnhWMnBDaGxpREF5MmViTjVkeThvSHNsVG53R2Jld3No?=
 =?utf-8?B?ZTVrL1FETkp6NEFuT3ArL0pJMmJLU3ZxMTFJN3J2WDVOLysyRnVyc0h4cGxS?=
 =?utf-8?B?bjhUem0xaFRnbW1KNi81ZThpT3FMK0RjM1c2SVRTVkg4WmNQOElqVmJXTTNS?=
 =?utf-8?B?SmVkWlYrQ2JZNnVydDZPT2tYSm41UnRFNTcrbnRmS255WFJoSWR3ZnJ4SXcw?=
 =?utf-8?B?b2tIZjB6OUp5Z1MyMkVtUnI3bG9OUHcrbndJdC95eDRBbU9abVpNRDk1SnUv?=
 =?utf-8?B?ODI2UUsyUUhaZkExK0NZbzcxT3ppOVRtSGFDc3FZZSsrekhBVmNvdWFmVU52?=
 =?utf-8?B?MjlYcUtOSitVd2l4aDZ0bWdSZGRwdUVOZlNaem55alFHNXRzRVkrOVlqdzUx?=
 =?utf-8?B?UCsrZGd2dEE2YS9rdXBjMFBSQXJ1OThDOE1henlDN2YrOFoyUXRIcWNMTVFV?=
 =?utf-8?B?NjRETVQ2TjFuSDN2Z0R5YWdMWTlBcmFkNmMxUldGRHZzZ0ZpSXErdEJZanJM?=
 =?utf-8?Q?KS51tN+0jew/0XDt9Xp8fOY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEVTbStPOTBzVjlPT1owRHdCd0Uxd1RNZlN1VWxrZ3B4OTJxc2tVbUFCY2lB?=
 =?utf-8?B?Qk5PTkNoQWIxQmhwWDFybGlvK0J6elRyV01GMllmQmZyZlgrV3Vob2NLeHN5?=
 =?utf-8?B?M2hTUzhDclMzVDc1Vm96cWVaMXJPc211SWQ4VVN2UEhTT2RZclhqR0d6NTRE?=
 =?utf-8?B?ZUFxR1dmWm13SVlXL1RuQjM3KzQ1ZzRCTXk1K2Y3SDN6V1FzcGU0ekpqRks0?=
 =?utf-8?B?MjJMRE9ja2FWUDhhK3dBa3RZRlI5SUpyMUxyS1pnMkk1eVJhbU9GTUdvNTNn?=
 =?utf-8?B?RlVKQ0pEZm4rK1lsNGMwK0xkZW1SN2E2cGIrcXh4STNjMnA0VFV0WmJKOU1i?=
 =?utf-8?B?eGVBVTJKWVVCcmdjdGtlSUNWekIyRko5YW91bnh1L3RQT2tmUkZnMVJuZS80?=
 =?utf-8?B?Yk5qN0ZRZlNCZHJnTG9GOGdzRFFxaVFJUTFEK1dEbTlhYW16dTVQNEYvL1lU?=
 =?utf-8?B?S2JtblBkMERuR0IvMDVyWHI1SkhUbTJ6ck8xWkl3VjQ4c2t1aG9qRjRHS1Rs?=
 =?utf-8?B?NUJ3VC9EYmRReFpOajlSdmRmZFJzMFJCSytHUXpXdzRkQkl2RnE1Y25JQjN5?=
 =?utf-8?B?SXBtQWZrTWgxQmFHbkRCdXlyM25jQmZsK2g5Z0lTS2Jzbk5WRW5hVnFNQkgz?=
 =?utf-8?B?OXhGWmVhUklpaXNHandleHd0VzR2bkJJbWkxTUhtbm9kaU9ycWFlL01MUk0x?=
 =?utf-8?B?bFFVZFdsQlBFR1RzdmcwTXNsN0swMDQyd3prN3N3SkRyRFR0U296aXUweGIy?=
 =?utf-8?B?Y2ZJOGhVaG5jdmsyZlh0T1FpR2MvVmhNM0NPRE0vdkdPb3dIcXZOcExvTHZp?=
 =?utf-8?B?UTl0MGNuK25CNXkvRHNZVkdFczdPdHV5bnhBb0VpaFJ2UllodENuWWIzWGw2?=
 =?utf-8?B?dTVDSWVPeEZuYzRXYndSNXlaZ2tUOEtTMlVCQjQxS3MzNW1rZVEyZGRneElv?=
 =?utf-8?B?ZGQ1Wkl2TVRYUE56djVXUWIyblZ0cHo1UWZjUWkwcHBSQzlMZnR5Q21yNXVr?=
 =?utf-8?B?Y1BSTFVOWWlyZjU2Z2w1aXo5dFN4MlVLYk10Z2tjRmh1b1ZFTTZmOWJNM1NM?=
 =?utf-8?B?ZWpZNXRJb0JYd2pNa3RkWFFPYklHdG9WUytCNFpnY2pHV1hXY0N0S3dIdi9h?=
 =?utf-8?B?bTQ4RG5LaDBzOStOMktXWlhlNHc3dWRpQVpjTUpwREg4REd2VEdoc0VrRVJO?=
 =?utf-8?B?YUFvbWZSRTJhMk5oamRJWm4vQTh0QkdaaTVwMDFWeElLK3E3ZThSeFBvYkti?=
 =?utf-8?B?UzRDY1R2OVdkSmJkK3E3ZFAvU0RWdEVrcHZrRWltMFFrU0Z1ZytObE1Uaml3?=
 =?utf-8?B?NzZ3aCsyR1g3U054RWk0WGpUc0djU0dPYjhXeFEzTytwd1dNakxCbW5yZ2Jo?=
 =?utf-8?B?ZlBQMVZMU3FFcTZUSXZUV3dOQ1FJQjhaYnQ3WEVRN3RheEpwdXhTY1U2bFJP?=
 =?utf-8?B?Q2h6Q3MrMmw1NnhpNEE4cVFuNkN3RmdwaVZ0c0pPZHI5dkRPekEzQTU1aE5h?=
 =?utf-8?B?SitSOWdwNk56M0V1RjhsUDluME5OaGtnV0FkaStmS1Z3RFVGbHpWcGFFazh1?=
 =?utf-8?B?YzZjRDUzY1VLdzZsVkQ0NHZ1czZQVkdPOGgwSjZtc1VxcHM0R01CTnNIZ2Nv?=
 =?utf-8?B?Tjh4d2s1TUtLU1FvZitpMkp0dm9RMGtWNTVjdldaTnZScGZ4eU15YVBJTlg2?=
 =?utf-8?B?RmlDbWxMRGF0SW0zOHlsNlUrM0tFeU1IeHlyNEhLRFNIWHVvSE81WCtxN1Bz?=
 =?utf-8?B?bC9PZUV2M0RobjVzSVZZaCtrY3V6VTBQbDk4bUZ5cHFkSkltQjlsbG5vWHRv?=
 =?utf-8?B?TlNOVTJiUUJMQ2czSC9WRVkwNGQ1SUxuVTg0YzdTN3BMSVFIdDdDWU1rdGJG?=
 =?utf-8?B?WEhhMUFsMmJOV1Q1KzBkZ0U5dHIyTFYySTg4cU9PM2p6Wmdxbm1WT3BXbEo3?=
 =?utf-8?B?OUQ4VDVPcU4xWHdROWcveVZ1T0o2S2tGcmxnMC8vcWRpK3F6VVE4TW43cVBm?=
 =?utf-8?B?R0xMb0I3SDU0dytHcVVsQWZTcHVaSC8yVjlxSlF6QlpFb3pIaE9FR2FGMi9l?=
 =?utf-8?B?RTBvV0NNbXl6cEVTUXFUamttVDJaaElLanZsNjF6OWhVTHJTQVZsTlRYWkZj?=
 =?utf-8?B?MkJObC9HdzVzV0tBRWtYekZXVUlMMEZ0bmd5YUpKNEFybCtoLy8wRVgrU2kz?=
 =?utf-8?B?L1BFeGlXNDhkSlI1QllrU2JaRjA5d1ErZzhaMXR5NzN6aWxJZGV5ZnlDTkRP?=
 =?utf-8?B?eVV3N2ZXeWcrZndva0NsRHJtSnBGRk4wQlhoMW5JL0ptc09kUTBOS0ZRN1V2?=
 =?utf-8?B?RTVtRHN1cThkTExOc1dqQ1NEbEptTVJNSENBNjlRN21aQy85Qk1WQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e934c295-7f1e-4551-7d47-08de5fd481d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 07:52:24.8501 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VTG5ZI86hapVHbWMjuHXib7THFU9yZWcTcoVxlXdeLVFLROStRZ8hB1jTiV8LY/5ZEjhCqoGr1nYWQdygckhG2Dq8It27Wt5xkrEKlSN9yI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5836
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
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

SGkgQ8OpZHJpYywgDQoNCj4gU3ViamVjdDogUkU6IFtQQVRDSCB2NSAwMC8yMl0gaHcvYXJtL2Fz
cGVlZDogQVNUMTcwMCBMVFBJIHN1cHBvcnQgYW5kDQo+IGRldmljZSBob29rdXBzDQo+IA0KPiAr
IE5hYmloLCBKb2UNCj4gDQo+IEhpIEPDqWRyaWMsDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+ID4gRnJvbTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0BrYW9kLm9yZz4NCj4g
PiBTZW50OiBGcmlkYXksIEphbnVhcnkgMjMsIDIwMjYgMjowNCBQTQ0KPiA+IFRvOiBKYW1pbiBM
aW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47IEthbmUgQ2hlbg0KPiA+IDxrYW5lX2NoZW5A
YXNwZWVkdGVjaC5jb20+OyBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+
Ow0KPiA+IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5jb20+OyBUcm95IExlZSA8
bGVldHJveUBnbWFpbC5jb20+Ow0KPiA+IEFuZHJldyBKZWZmZXJ5IDxhbmRyZXdAY29kZWNvbnN0
cnVjdC5jb20uYXU+OyBKb2VsIFN0YW5sZXkNCj4gPiA8am9lbEBqbXMuaWQuYXU+OyBvcGVuIGxp
c3Q6QVNQRUVEIEJNQ3MgPHFlbXUtYXJtQG5vbmdudS5vcmc+OyBvcGVuDQo+ID4gbGlzdDpBbGwg
cGF0Y2hlcyBDQyBoZXJlIDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+ID4gQ2M6IFRyb3kgTGVl
IDx0cm95X2xlZUBhc3BlZWR0ZWNoLmNvbT4NCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDAw
LzIyXSBody9hcm0vYXNwZWVkOiBBU1QxNzAwIExUUEkgc3VwcG9ydCBhbmQNCj4gPiBkZXZpY2Ug
aG9va3Vwcw0KPiA+DQo+ID4gSGVsbG8gSmFtaW4sDQo+ID4NCj4gPiBPbiAxLzIxLzI2IDAxOjU2
LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gPiBIaSBDw6lkcmljDQo+ID4gPg0KPiA+ID4+IEZyb206
IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+DQo+ID4gPj4gU2VudDogV2VkbmVzZGF5
LCBKYW51YXJ5IDIxLCAyMDI2IDEyOjA5IEFNDQo+ID4gPj4gVG86IEthbmUgQ2hlbiA8a2FuZV9j
aGVuQGFzcGVlZHRlY2guY29tPjsgUGV0ZXIgTWF5ZGVsbA0KPiA+ID4+IDxwZXRlci5tYXlkZWxs
QGxpbmFyby5vcmc+OyBTdGV2ZW4gTGVlIDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29tPjsNCj4g
PiA+PiBUcm95IExlZSA8bGVldHJveUBnbWFpbC5jb20+OyBKYW1pbiBMaW4gPGphbWluX2xpbkBh
c3BlZWR0ZWNoLmNvbT47DQo+ID4gPj4gQW5kcmV3IEplZmZlcnkgPGFuZHJld0Bjb2RlY29uc3Ry
dWN0LmNvbS5hdT47IEpvZWwgU3RhbmxleQ0KPiA+ID4+IDxqb2VsQGptcy5pZC5hdT47IG9wZW4g
bGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47DQo+IG9wZW4NCj4gPiA+PiBs
aXN0OkFsbCBwYXRjaGVzIENDIGhlcmUgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gPiA+PiBD
YzogVHJveSBMZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2guY29tPg0KPiA+ID4+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjUgMDAvMjJdIGh3L2FybS9hc3BlZWQ6IEFTVDE3MDAgTFRQSSBzdXBwb3J0DQo+
ID4gPj4gYW5kIGRldmljZSBob29rdXBzDQo+ID4gPj4NCj4gPiA+PiBLYW5lLCBKYW1pbiwNCj4g
PiA+Pg0KPiA+ID4+IEZvciBzb21lIHJlYXNvbiwgSSBkb24ndCByZWNlaXZlIHlvdXIgcHJvcG9z
YWxzIGFueW1vcmUuIE15DQo+ID4gPj4gcHJvdmlkZXIgc2VlbXMgdG8gZHJvcCBzaWxlbnRseSB0
aGVzZSBlbWFpbHMuIEhhdmUgeW91IGNoYW5nZWQgYW55dGhpbmcNCj4gcmVjZW50bHkgPw0KPiA+
ID4+DQo+ID4NCj4gPiBUaGFua3MgZm9yIHRoZSBpbmZvLg0KPiA+DQo+ID4gPiBUaGUgZm9sbG93
aW5nIHBhdGNoIHNlcmllcyBhcmUgcmVhZHkgZm9yIHJldmlldy4NCj4gPiA+IFt2MSwwMC8xMV0g
QWRkIFNTUC9UU1AgcG93ZXIgY29udHJvbCBhbmQgRFJBTSByZW1hcCBzdXBwb3J0IGZvcg0KPiA+
ID4gQVNUMjcwMA0KPiA+ID4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L3Fl
bXUtZGV2ZWwvY292ZXIvMjAyNjAxMjAwOTI5MzkNCj4gPiA+IC4yDQo+ID4gPiA3MDgzMDItMS1q
YW1pbl9saW5AYXNwZWVkdGVjaC5jb20vDQo+ID4NCj4gPiBJIGFtIHNlZWluZyBhICdtYWtlIGNo
ZWNrJyBpc3N1ZSB3aXRoIHRoaXMgb25lLiBBICdkcmFtJyBwcm9wZXJ0eSBsaW5rDQo+ID4gaXMg
bWlzc2luZy4NCj4gPg0KPiA+ID4gW3Y1LDAwLzIyXSBody9hcm0vYXNwZWVkOiBBU1QxNzAwIExU
UEkgc3VwcG9ydCBhbmQgZGV2aWNlIGhvb2t1cHMNCj4gPiA+IGh0dHBzOi8vcGF0Y2h3b3JrLmtl
cm5lbC5vcmcvcHJvamVjdC9xZW11LWRldmVsL2NvdmVyLzIwMjYwMTIwMDUxODU5DQo+ID4gPiAu
MQ0KPiA+ID4gOTIwNTY1LTEta2FuZV9jaGVuQGFzcGVlZHRlY2guY29tLw0KPiA+DQo+ID4gVGhl
cmUgaXMgYSBkaXNjdXNzaW9uIGluIHByb2dyZXNzIGFib3V0IHRoZSBidXMgbmFtaW5nLiBOb3Qg
YSBibG9ja2VyDQo+ID4gYnV0IGl0J3Mgd29ydGggYSBiaXQgb2YgdGhpbmtpbmcuDQo+ID4NCj4g
PiA+IFtQVUxMLFNVQlNZU1RFTSx2Ym9vdHJvbSx2MywwLzFdIFVwZGF0ZSB2Ym9vdHJvbSBpbWFn
ZSB0byBjb21taXQNCj4gPiA+IDFjOGU5NTEwYjIyYw0KPiA+ID4gaHR0cHM6Ly9wYXRjaHdvcmsu
a2VybmVsLm9yZy9wcm9qZWN0L3FlbXUtZGV2ZWwvcGF0Y2gvMjAyNjAxMTYwOTMyNDkNCj4gPiA+
IC40IDQzMzA3LTEtamFtaW5fbGluQGFzcGVlZHRlY2guY29tLyBbUFVMTCwxLzFdIHBjLWJpb3M6
IFVwZGF0ZQ0KPiA+ID4gdmJvb3Ryb20gaW1hZ2UgdG8gY29tbWl0IDFjOGU5NTEwYjIyYw0KPiA+
ID4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L3FlbXUtZGV2ZWwvcGF0Y2gv
MjAyNjAxMTYwOTMyNDkNCj4gPiA+IC40DQo+ID4gPiA0MzMwNy0yLWphbWluX2xpbkBhc3BlZWR0
ZWNoLmNvbS8NCj4gPg0KPiA+IFRoZSBhYm92ZSAzIHNlcmllcyBJIHBsYW4gdG8gaW5jbHVkZSBp
biB0aGUgbmV4dCBBc3BlZWQgUFIuDQo+ID4NCj4gPiBXaGF0IGFib3V0IHRoZSBJM0Mgc2VyaWVz
ID8gQ291bGQgeW91IHRha2Ugb3duZXJzaGlwID8NCj4gPg0KPiANCj4gSSB3aWxsIGRpc2N1c3Mg
dGhpcyB3aXRoIEpvZSBhbmQgTmFiaWggZmlyc3QuDQo+IElmIHRoZXkgYWdyZWUsIEkgYW0gd2ls
bGluZyB0byB0YWtlIG93bmVyc2hpcCBvZiB0aGUgSTNDIHVwc3RyZWFtIHdvcmsgc3RhcnRpbmcN
Cj4gZnJvbSB2Mi4NCg0KSm9lIGFuZCBOYWJpaCAoR09PR0xFKSBoYXZlIGFncmVlZCB0aGF0IEkg
d2lsbCB0YWtlIG93bmVyc2hpcCBvZiB0aGUgSTNDIHVwc3RyZWFtIHdvcmsuDQoNCkkgYW0gY3Vy
cmVudGx5IHVwZGF0aW5nIHRoZSBmdW5jdGlvbiB0ZXN0cyBmb3IgQVNUMjcwMCBBMSB0byB2ZXJz
aW9uIDExLjAwLCBhbmQgd2lsbCB0aGVuIHByb2NlZWQgd2l0aCB1cHN0cmVhbSBzdXBwb3J0IGZv
ciBBU1QyNzAwIEEyLg0KQWZ0ZXIgY29tcGxldGluZyB0aGVzZSB0YXNrcywgSSBwbGFuIHRvIHJl
c2VuZCB0aGUgSTNDIHYyIHNlcmllcywgd2l0aCBhbiBlc3RpbWF0ZWQgdGltZWxpbmUgYXJvdW5k
IG1pZC1GZWJydWFyeS4NCg0KVGhhbmtzLUphbWluDQoNCj4gDQo+IFRoYW5rcywNCj4gSmFtaW4N
Cj4gDQo+ID4gVGhhbmtzLA0KPiA+DQo+ID4gQy4NCg==

