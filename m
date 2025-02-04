Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED35EC0218F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 07:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfDHG-0006Iu-Cn; Tue, 04 Feb 2025 02:23:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tfDHB-0006IE-Tb; Tue, 04 Feb 2025 02:23:18 -0500
Received: from mail-eastasiaazlp170110002.outbound.protection.outlook.com
 ([2a01:111:f403:c400::2] helo=HK3PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tfDH8-0000rZ-Fc; Tue, 04 Feb 2025 02:23:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNYOV+9H98BFvEI7c2hABGd4zU6hAoBCr/RSPT/BX20zIidv5jZE2tklnJtEpqoDnmb8u8/rxlEQ9hIIAL++TkomCktgDwaDNqkt/8MUHWLE/YX+wAro2mXcpUFICC5T4zPc9ruK9mvEHNY7rKIgL/o6FwkWi9dol12VllVDsMQ4Q0a6KOMd1qRhWmq65egull3IOKbLz0BCWYxDoWwkRl3bE7FzUr4gOhK3EKIWps7/UI1Pv+i86UKKvJMPnQ3pW8+MF8gLfhT/GUqQsVBlEzUxzXBsSKvI9DB9bCb6o1Ke0+NjEsSKqnW5nrLFzVYuvcDu2sErXtIJxIJ8DOQLhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmRJwJeEE2d1TGVKvWilPfmu/Tk2BSqexhLfcQP9ZJ0=;
 b=jKHhsvna9q7zxSJzJiI/wp04ZgT7kjhvJqsSkRdji06zNT3FoPjK7p1RqrShiBYbYdht4FCiaEDV7yuoBkBlpfrVr0+zElXoSF4SKw2K/hlDlXIf/AF8dMeWa4WIuuJKwsXKQF9GHq/OF2PsV9xhIWbqCAIPyQL/zkA9pwrjyLC4dg0Vn1CeRoieK1yB9qmH1fDQITLJD5+X3tN1a/bPhEgJ+4NRzoJcpnFT3yc+zAKSGvRbOjOelucTDZJwKHUknkkUjhqXxFkFaq9qVzHXxFw8HwZCGPcmOJJTzGyFrpZPiX1Uwa3OENqHhLgl4gtq3S6wWgMwS550hdEddp5reQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmRJwJeEE2d1TGVKvWilPfmu/Tk2BSqexhLfcQP9ZJ0=;
 b=iDLKv//+JzS0BTtITmSghO3crwQR81lFhbx5gpUtbQFIJYLN/3bVtS7gqg/sy+FuhrWhH7TyMQI9ALysNZ1xZ2HhX0sV7mZUVILNCPPHJ/VWr6+xGAbYO7js5x6HsLbnV/A5rQJJwPPn2/Iop/BTyX83s/F3nyBQSPQrOh6t0dSpRPRsoqabr+aHQb87nKT7wdHOUprE4+QMPCLcIJa7uuVTi7PdfvilToEvcwpHLYJrntrX7uxxKcyRwRu07jMes1TXIsCadbPDDWA/L8rWrADVOI8sYp+1yqnBbiuLQRsBzyebP0kqVFcvQW8lpLApNGMlTRUY0sy1hDu2soU8Fw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB5246.apcprd06.prod.outlook.com (2603:1096:101:76::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.10; Tue, 4 Feb 2025 07:23:05 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%5]) with mapi id 15.20.8422.005; Tue, 4 Feb 2025
 07:23:04 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v1 11/18] hw/misc/aspeed_scu: Add Support for
 AST2700/AST2750 A1 Silicon Revisions
Thread-Topic: [PATCH v1 11/18] hw/misc/aspeed_scu: Add Support for
 AST2700/AST2750 A1 Silicon Revisions
Thread-Index: AQHba9LAcaRtgtPAHE+G6fSDHi4PGbMuwLuAgAgN8mA=
Date: Tue, 4 Feb 2025 07:23:04 +0000
Message-ID: <SI2PR06MB504178B509BA4944D0C274AAFCF42@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250121070424.2465942-1-jamin_lin@aspeedtech.com>
 <20250121070424.2465942-12-jamin_lin@aspeedtech.com>
 <64382a15c40b33fcfeeecee5489e0a034313b7ec.camel@codeconstruct.com.au>
In-Reply-To: <64382a15c40b33fcfeeecee5489e0a034313b7ec.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB5246:EE_
x-ms-office365-filtering-correlation-id: a8db7c73-9e53-468a-9e58-08dd44ecc411
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Nkd1Tkg0U0xPSmtIMm5nKytOelFnK3ZBWUV1aFgrbElQdER1ajA1KzJDS00y?=
 =?utf-8?B?WlhTNUZ3SlBOT0NBQmxyNkFXaVJzYmdSLzlUYmhnSE10cnpVMWpUcWNic1Zu?=
 =?utf-8?B?dnA2eEtpb241NXBjWlZnYkttcUp6dUZTVlFqazFWK241NG8rem5Db1Fqb2sx?=
 =?utf-8?B?Z2lPbzYrZlBkZk5NbjVhNTF4YS9ra1pPd20zV1JaV2RpdGtYNURhQW8zNGlU?=
 =?utf-8?B?ajJnWS9lU2tQVTRhV21nU2hzRjlpWlJQalFJMUREczlMOVZIZTR4eUpvY2kw?=
 =?utf-8?B?V0JZbkhZWWlhbE12TVRTeE51U1JHVGJlLytseGdhR0gyOEtQNitqMitPcFlT?=
 =?utf-8?B?ZFU3S3IzdXc4Z3Z1Q3JXVXdnMFFUWnBiaWs5a2FKcEpsU3phSlYxNWVRSEpo?=
 =?utf-8?B?VUdKWnVwTWtPeGZMUmk1c3ROam5EVlIwRjBwMzl5a2I4MEoyZDN4Z1JBMEVI?=
 =?utf-8?B?dkFBTzNQdWJOSHIxamc2SzljV0JkK0FjRTNpeUVleVlxUzlrckRrbExCL2tX?=
 =?utf-8?B?NXR5N01sbVVmbGFOK1VUVWxXa0hNK3N6eVpWRG5PSWs0YUwxd2RCYVBTN1Zv?=
 =?utf-8?B?aVZQSDhkMVNCS3M5QUZCYmlpUU5kVnVEME9KVGlqdlRYOWdHejhHbUNYcHNG?=
 =?utf-8?B?bDN4cWJYNkt2RFo0cjRneUtXSmpuV2xVV25vK3Z5aFdkOGdxU2RUMW9mVUxE?=
 =?utf-8?B?WlRtWm1GNm1RY0VSRGdjQmorbVhEOTNSOFpnSlg4TEtZb0VYZFFwZ3RuaE55?=
 =?utf-8?B?ZWI4dGpCRERhZm5wREREcDhFakpZM29rYURHWkFIRm1lSXZNU2s0SXNrcUJS?=
 =?utf-8?B?Y3hOVkpIeXo2NExlU09teWZxZFBZbXlsS3p0a3ZmandNVVVibWpxaXdENGEw?=
 =?utf-8?B?L0pLeHZQd1BqWkZ5VjMyZXYvT2h0TzNYbjQ0b0xKQnRtbnpac3E1UXBGK3Rq?=
 =?utf-8?B?R3o4MHo2SlJFSWw1bXA1TXY5ODRXczNFQzlyWUNqaitadncxWEVzREJEeVRO?=
 =?utf-8?B?S2piR2ZhM21MR3NjYTViSUhEblFReE91ZThlOGw1SnNodi9VaGl3dGpPcEM3?=
 =?utf-8?B?RzJQNUdRTkFvYjNzUUM4QnVVMytRdjhEeExFSmtIQUF1dWp6cm5mckd3SVh3?=
 =?utf-8?B?NEJLaW1lN0ExQzkyMVJacEZMa0Q0YjZwbGFJSW11Z2MzTHN2QTMvSGplc3Qx?=
 =?utf-8?B?SEpmMmt1cjI0UjBDRFN4TEpJNzAzUXd1RlVJd1hPd0FrY0s2QituUitKSlVU?=
 =?utf-8?B?Ykg4QkJZdjVaM3lKajk3cFY5a3RpTFF5Z1l4WmdlQ1JMSWFVQzVFM0VpZ0tj?=
 =?utf-8?B?OGxVUjc2Z0F1bEYyYVNoczZma2pMT3lSNmZ4cU1XNTBXZGwyVVBkbElPTlJT?=
 =?utf-8?B?SFcvZEVhcFJtRVk0NUpHSFd3eGxwbXVHQXgwUlVrazEvL0kyaTh5ZDB0ZGI1?=
 =?utf-8?B?Z2t6NGhGbXB4cWdwKzI5NmFhdHRiSkdXVHkxOHhtMFZFcUNOVUNLUlJiMUFG?=
 =?utf-8?B?MzViVWI2VlNtdUxiZ0wyay9HV1RhV1VLU3NKVHJHTnRCMm5peE5VQkJwM3lx?=
 =?utf-8?B?eFRJYks2Z0RxYk45MFBRZ0JOeDFhRktwUEtFcVg5UjJsUEg2ZEpjVUcrOTRz?=
 =?utf-8?B?ZlBhaFpGaUlDVEFKZjFiNkIzblNzMStObGplTi9aZ2p4bGoyMzFONTFabGs1?=
 =?utf-8?B?Kzg1MTFoOWViVURlMVJpc3VsVENnZENMTkZBYXZqVTRkTGVRaGgwMUdtRkVw?=
 =?utf-8?B?bExYeitBeldXOWNHaWVOV05JalBkNGphaHUrWDloVW5CazRvMG1TaEUxblRB?=
 =?utf-8?B?eC9yTk8xaDg2bm5qdDJMcTg5TWh1S1B6cWs2TFlFbzJFemZzQjJsb29PNEdP?=
 =?utf-8?B?ZGFIUVFITkxYUlhLZ3dVNGk2R1k2Rjliby8wZ2crd0RiMVdPTVJQTUo1aWxv?=
 =?utf-8?Q?waKNSJjzVepJ9xk0P9cYDyJAmc8crbQv?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUpHenpVMTNTVnI5NHlTdTZXS0lZYmQ0YnNtY0VJUDFFU3J0YTEvZ3J0YVNz?=
 =?utf-8?B?R3k2eHBidDRsYldTRDF0THZEcFo5ZzJGd21pRzMxdTdhU0wxcFJGVkpNdWhp?=
 =?utf-8?B?U25JNzZaM0JCckV6bG0xa0JRdENRNVJGZE13cnVGM3QwZ2pyM0dWNXgyV0dq?=
 =?utf-8?B?RGx3WHZtQ294d3BZUm9vd2ZxL1NPSFNDTW1MNWQ3bjV6UVVET2srWUs1empY?=
 =?utf-8?B?RTA3UStVVml6d2xMTFFpNlRUMjZKWkZWR0UvalBpQmpZN205MlArZjRIdVNE?=
 =?utf-8?B?QWlvdiswRSt1Ny9obUJxSTJ2bFBBU3ptc3g0T2llcmZUMi8rSTV2b1JJeVFu?=
 =?utf-8?B?c2o5ZW90a0ZiK0dvbWpHUzUxNUZjMWZscUdOY2I2Q0dZc3lXdmxKU25nQjhP?=
 =?utf-8?B?RWdWVXhNNVZVdDBHZ1hFbTIxK0xXaGxkTVN4bzUxWnFhME9jZUVKZysrcm9P?=
 =?utf-8?B?cVFiOGt5Sy9ZYnJpSFFQZFNSN2JRRXdSeGdlclN1Q0FLV1VxY2MwUU1sVEVi?=
 =?utf-8?B?a3NkNjljS0hLK2l4bXNEYzBTMmlkT0JDcVFZcUN6Zis1YnVyZmtFU01oNUZW?=
 =?utf-8?B?cEJrblVDSmdNcmxLKy95UEtWS1dzYlE5Y0h1dU9PQkVsWkRlcFZQM2RCMW43?=
 =?utf-8?B?T2NERVA0KytyWmtzN1RpSDRiZ0JBcW1UYTZtZGI0bktPUTBIUjh0d0JkTER3?=
 =?utf-8?B?ekozVFU4NU5aRlN4MVZ6MXArRDkrT0Q3SkNjTm51SDh6MkxhY2VTS210NWxv?=
 =?utf-8?B?WU9XQVAwcVVMTy9pRnlGUnBVcnFmSkJmc0ZEUEtsanJjMkswbjNjT3NwNmFi?=
 =?utf-8?B?THFiYVpFMkVMNkVWWGNrcmZMT0U0WmNaTmRXT1ZySjVoU1l0ZHIxRTM4YnlH?=
 =?utf-8?B?cHBjdXdVZVR4UGhHQzVIZlVEWUE5YTBOQWczOW5vbEFKdk1xL3ZpN2xlNHBa?=
 =?utf-8?B?T0NKS3FSL0FQMk8vazY2Um85K0h1enVKcUwyS2laMFJlT2o2aUw3M043NlJK?=
 =?utf-8?B?WDNsaFAzNFBaR0M4Vk1ZMG1wNmdERS9zVGFGcm5md1VtTjJnVVVoWXYrYnVk?=
 =?utf-8?B?ajQ2djZOeEFuM09YdkZTYy9RUHRKY1VSZUxmSVBIVmdDM05PMzFDMEFxdFJ4?=
 =?utf-8?B?YzF5WGhSQWljcUtoMko5T1k3R3RGakU5RnFBMFFTakJxeUxTR1pRS1NFbWxX?=
 =?utf-8?B?R3kvMEJaQitPUkxQUWlJcHU5UUg5MlZCbUs1Smd5L1d6YXVzTmRNeWw2Q1Bi?=
 =?utf-8?B?SlQ0YlRKMEZxMG9heDdtL0R6WUNoTDkyRlpaVjRldHJWMnVycWV3SEh1UDE2?=
 =?utf-8?B?S3JTTzlqb0dHbmFvY2lCSzU4RVJFaXE2ZUhWREgwRDZYT28zRGRPdkVtNXIy?=
 =?utf-8?B?bzJaTGlodE5VWFVvTWhlZTNWalVsbUFqL0ozVmNzNVI3QU54UlRLNUdwTStI?=
 =?utf-8?B?RGdnaDY2ZndSU2lLUGJZUVlxTHp3YjIzbGhVSEQ0ZG1JdEFsLzQvWWVPQVcy?=
 =?utf-8?B?QWVDaHBEUm1LaW52U083NlFmbXNpNkVUcFV0ZjhtYzhiaUlWSTZhbVRyd1JN?=
 =?utf-8?B?dUVzS2ZYeUszc3dsL2Qwa3d1YnplNHFHS1hPRWcrY1huWCt6M2dEVk9PdDgr?=
 =?utf-8?B?NmJKS1hLMGQ2OW55bGkzcU5NanVTK3hwVHdoK2tjeW1ZdDBQaEthT1lpYlhy?=
 =?utf-8?B?aFB4amRMcXdqdkNRRGFtWDA3NnphNGZHR0hzVFRVK0tJME1GWTdQUjR5N0xz?=
 =?utf-8?B?dHB4RzNvK3hhZTlUZE1lMmR1eTl1UXBFRXFVVGRIRVBuUHRibkdGTzRsbE9C?=
 =?utf-8?B?Qjkzam5RdERlTHI2WExxaFY2TUdwZ2lyZ3pWK3VrRmREcG5tbEJQM1ZrdGx5?=
 =?utf-8?B?WTFMYVFqTFhxTVpET1hGeTVUN3plNEc1dnZqTUxEMFRnNlBVOVFOY0d4SXBw?=
 =?utf-8?B?MlpMRzNxSTNyaDVjby9NOGlJZWJvcWpiUFY5dXlJY3pDZ1ZOV0REOUlrWlhB?=
 =?utf-8?B?SVZRWmJlWWRRR2xEZnFWN0VDdVoxbFRkM0h0aStwRGNCaGw0a21FaGtGaFls?=
 =?utf-8?B?QnJKd1VDQjQxcXZMcmhZcTJidzBISksveHJVVzJHRFlkenRIMmtoL3U5aVVj?=
 =?utf-8?Q?1bh1N6cu/p6k7IgW6YGyOL9Wp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8db7c73-9e53-468a-9e58-08dd44ecc411
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2025 07:23:04.8446 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y8Nwr8nCqvjaFWbKZfs4YnPhyIRm4bOvszORN9NkTuY60dRdXcD8yp1DwpN9WwpcQY8KXq9nK/+X185TQ2sa4xv6tJ24pSm0AvKlQiihYsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5246
Received-SPF: pass client-ip=2a01:111:f403:c400::2;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=HK3PR03CU002.outbound.protection.outlook.com
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

SGkgQW5kcmV3LA0KDQo+IEZyb206IEFuZHJldyBKZWZmZXJ5IDxhbmRyZXdAY29kZWNvbnN0cnVj
dC5jb20uYXU+DQo+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDMwLCAyMDI1IDEyOjA1IFBNDQo+
IFRvOiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47IEPDqWRyaWMgTGUgR29h
dGVyIDxjbGdAa2FvZC5vcmc+Ow0KPiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFy
by5vcmc+OyBTdGV2ZW4gTGVlDQo+IDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29tPjsgVHJveSBM
ZWUgPGxlZXRyb3lAZ21haWwuY29tPjsgSm9lbCBTdGFubGV5DQo+IDxqb2VsQGptcy5pZC5hdT47
IG9wZW4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4NCj4gbGlz
dDpBbGwgcGF0Y2hlcyBDQyBoZXJlIDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IENjOiBUcm95
IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+OyBZdW5saW4gVGFuZw0KPiA8eXVubGluLnRh
bmdAYXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMTEvMThdIGh3L21p
c2MvYXNwZWVkX3NjdTogQWRkIFN1cHBvcnQgZm9yDQo+IEFTVDI3MDAvQVNUMjc1MCBBMSBTaWxp
Y29uIFJldmlzaW9ucw0KPiANCj4gT24gVHVlLCAyMDI1LTAxLTIxIGF0IDE1OjA0ICswODAwLCBK
YW1pbiBMaW4gd3JvdGU6DQo+ID4gQWRkZWQgbmV3IGRlZmluaXRpb25zIGZvciBBU1QyNzAwX0Ex
X1NJTElDT05fUkVWIGFuZA0KPiA+IEFTVDI3NTBfQTFfU0lMSUNPTl9SRVYgdG8gaWRlbnRpZnkg
dGhlIEExIHNpbGljb24gcmV2aXNpb25zLg0KPiA+DQo+ID4gVXBkYXRlICJhc3BlZWRfYXN0Mjcw
MF9zY3VfcmVzZXQiIHRvIHNldCB0aGUgc2lsaWNvbl9yZXYgZmllbGQgaW4gdGhlDQo+ID4gU0NV
IHJlZ2lzdGVycy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbWluIExpbiA8amFtaW5fbGlu
QGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+IMKgaHcvbWlzYy9hc3BlZWRfc2N1LmPCoMKg
wqDCoMKgwqDCoMKgIHwgMyArKysNCj4gPiDCoGluY2x1ZGUvaHcvbWlzYy9hc3BlZWRfc2N1Lmgg
fCAyICsrDQo+ID4gwqAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2h3L21pc2MvYXNwZWVkX3NjdS5jIGIvaHcvbWlzYy9hc3BlZWRfc2N1LmMg
aW5kZXgNCj4gPiBiYWMxNDQxYjA2Li5mMDQ5YTlmZDk2IDEwMDY0NA0KPiA+IC0tLSBhL2h3L21p
c2MvYXNwZWVkX3NjdS5jDQo+ID4gKysrIGIvaHcvbWlzYy9hc3BlZWRfc2N1LmMNCj4gPiBAQCAt
NTU5LDYgKzU1OSw4IEBAIHN0YXRpYyB1aW50MzJfdCBhc3BlZWRfc2lsaWNvbl9yZXZzW10gPSB7
DQo+ID4gwqDCoMKgwqAgQVNUMjcwMF9BMF9TSUxJQ09OX1JFViwNCj4gPiDCoMKgwqDCoCBBU1Qy
NzIwX0EwX1NJTElDT05fUkVWLA0KPiA+IMKgwqDCoMKgIEFTVDI3NTBfQTBfU0lMSUNPTl9SRVYs
DQo+ID4gK8KgwqDCoCBBU1QyNzAwX0ExX1NJTElDT05fUkVWLA0KPiA+ICvCoMKgwqAgQVNUMjc1
MF9BMV9TSUxJQ09OX1JFViwNCj4gPiDCoH07DQo+ID4NCj4gPiDCoGJvb2wgaXNfc3VwcG9ydGVk
X3NpbGljb25fcmV2KHVpbnQzMl90IHNpbGljb25fcmV2KSBAQCAtOTM4LDYgKzk0MCw3DQo+ID4g
QEAgc3RhdGljIHZvaWQgYXNwZWVkX2FzdDI3MDBfc2N1X3Jlc2V0KERldmljZVN0YXRlDQo+ID4g
KmRldikNCj4gPiDCoMKgwqDCoCBBc3BlZWRTQ1VDbGFzcyAqYXNjID0gQVNQRUVEX1NDVV9HRVRf
Q0xBU1MoZGV2KTsNCj4gPg0KPiA+IMKgwqDCoMKgIG1lbWNweShzLT5yZWdzLCBhc2MtPnJlc2V0
cywgYXNjLT5ucl9yZWdzICogNCk7DQo+ID4gK8KgwqDCoCBzLT5yZWdzW0FTVDI3MDBfU0lMSUNP
Tl9SRVZdID0gcy0+c2lsaWNvbl9yZXY7DQo+IA0KPiBIYXMgcy0+c2lsaWNvbl9yZXYgYmVlbiBz
ZXQ/DQo+IA0KPiBTaG91bGQgd2Ugbm93IHJlbW92ZSB0aGUgQVNUMjcwMF9TSUxJQ09OX1JFViBl
bnRyeSBmcm9tIGFzYy0+cmVzZXRzPw0KPiANClRoZSB2YWx1ZSBvZiBzLT5zaWxpY29uX3JldiBp
cyBzZXQgYXQgdGhlIFNvQyBsYXllci4NCklmIHdlIHJlbW92ZSB0aGlzIGxpbmUsIHRoZSBzeXN0
ZW0gd2lsbCBkaXNwbGF5ICIgVW5Lbm93LVNPQyIuDQoNCj4gVGhpcyBzZWVtcyBsaWtlIGEgZml4
IHJlZ2FyZGxlc3MuIFBlcmhhcHMgc2VwYXJhdGUgaXQgZnJvbSB0aGUgYWRkaXRpb24gb2YgdGhl
DQo+IG5ldyBzaWxpY29uIElEcz8NCj4gDQpZZXMsIEkgbm90aWNlZCB0aGF0IHMtPnNpbGljb25f
cmV2IGNhbm5vdCBiZSBzZXQgYXQgdGhlIFNPQyBsYXllci4NCkZvciBleGFtcGxlOiBJIGFtIHVu
YWJsZSB0byBzZXQgc2lsaWNvbl9yZXYgZm9yIEFTVDI3MDAgQTAgYW5kIEExIGluIGh3L2FybS9h
c3BlZWRfYXN0Mjd4MC5jLg0KSSB3aWxsIHNwbGl0IHRoaXMgaW50byB0d28gc2VwYXJhdGUgcGF0
Y2hlcy4NCk9uZSBwYXRjaCB0byBmaXggc2lsaWNvbl9yZXYgYW5kIGFub3RoZXIgcGF0Y2ggZm9y
IEExIHNpbGljb24gcmV2aXNpb24gZGVmaW5pdGlvbi4NCg0KVGhhbmtzLUphbWluDQo+ID4gwqB9
DQo+ID4NCj4gPiDCoHN0YXRpYyB2b2lkIGFzcGVlZF8yNzAwX3NjdV9jbGFzc19pbml0KE9iamVj
dENsYXNzICprbGFzcywgdm9pZA0KPiA+ICpkYXRhKQ0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2h3L21pc2MvYXNwZWVkX3NjdS5oDQo+ID4gYi9pbmNsdWRlL2h3L21pc2MvYXNwZWVkX3NjdS5o
IGluZGV4IDM1NmJlOTVlNDUuLjY4NGI0OGI3MjIgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9o
dy9taXNjL2FzcGVlZF9zY3UuaA0KPiA+ICsrKyBiL2luY2x1ZGUvaHcvbWlzYy9hc3BlZWRfc2N1
LmgNCj4gPiBAQCAtNTQsNiArNTQsOCBAQCBzdHJ1Y3QgQXNwZWVkU0NVU3RhdGUgew0KPiA+IMKg
I2RlZmluZSBBU1QyNzAwX0EwX1NJTElDT05fUkVWwqDCoCAweDA2MDAwMTAzVQ0KPiA+IMKgI2Rl
ZmluZSBBU1QyNzIwX0EwX1NJTElDT05fUkVWwqDCoCAweDA2MDAwMjAzVQ0KPiA+IMKgI2RlZmlu
ZSBBU1QyNzUwX0EwX1NJTElDT05fUkVWwqDCoCAweDA2MDAwMDAzVQ0KPiA+ICsjZGVmaW5lIEFT
VDI3MDBfQTFfU0lMSUNPTl9SRVbCoMKgIDB4MDYwMTAxMDNVICNkZWZpbmUNCj4gPiArQVNUMjc1
MF9BMV9TSUxJQ09OX1JFVsKgwqAgMHgwNjAxMDAwM1UNCj4gDQo+IFRoZXNlIGxvb2sgZmluZS4N
Cj4gDQo+IEFuZHJldw0KPiANCj4gPg0KPiA+IMKgI2RlZmluZSBBU1BFRURfSVNfQVNUMjUwMChz
aV9yZXYpwqDCoMKgwqAgKCgoKHNpX3JldikgPj4gMjQpICYgMHhmZikgPT0NCj4gPiAweDA0KQ0K
PiA+DQoNCg==

