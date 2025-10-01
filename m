Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0642DCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rXz-0001Zu-EN; Wed, 01 Oct 2025 03:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v3rXu-0001P4-Fn; Wed, 01 Oct 2025 03:46:43 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v3rXb-0000qr-R2; Wed, 01 Oct 2025 03:46:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XuLtzJsjAVpiSG1L1WV+2FsJ8M0raWfW6l8eRU03lrmWNDvf4EAH0df83XeAfA1nH+0xvjYGA0Hjm64GfUyVE0cg0SDIX+dZIJSrbwE+gYxq7fItjZ02Gc+dAiJPOP95HktcEHXSTMcCL+7Ek3orxlnLNnm6tjMYA7+dS+vzcKPMAJBNxmGOBT6MfuidOLLbYoSbmYsqPPW+6v0gkvHkVEZab+QTKhlmqFNq2dNwTS1FhUFp2iY7uc4r+JPfY2XdYRs/oZXk/YqAABw2ECW/0H8BCCV0D6htlB4IdD8YKfRneadkLcJty0juUzkYaDoyaJHdqfLNSSQi8tmL6/hiKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yL+Hm0FR25kFY//QT1Bo6ZxXJxnLgO5tx9i5QtM0dHg=;
 b=xJyR0DYtg60lXGgrABMRq00LbZ41yTXxWYLq+TqCJtuHXgdG36XS5M+j1VNGMTeP3g+SFdFC9MVPXvoO2CuihCR35xvacjUkXiMvLYAe/ABzcjVXnRWEjLszxkKciK515xIKrUEiok0UBb/CfHmWw/rTMaRw2AhPArZ35N/mu85jfee+3J9dJKmpHGi9epwacVNopZBkHaPki4hwi4RZl0/SD6QZPtKYOB0fxhjNwgz/HQrQ1WpOpQVFT30RTAw1UtBsR25RZNRXEV3Yf+BjB1SZUlMfZh8w3qHqGMtGXEJFnPHed5L15V90Zovd2C+BQTic8WEAAzSjWIKXv/DHug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yL+Hm0FR25kFY//QT1Bo6ZxXJxnLgO5tx9i5QtM0dHg=;
 b=G0FBBTRfS56Vv17Dn66o8uqQnEF2I5C7VaskLGbsWiZDrU1pzmH4M5iTHVNOAPZ4fcMLdHpFrSDkoJqGKLMrDXxKj65Je3rJoZshQuFmfGU9/avcRDxjcZcznV/sw85IGOirlo6pleAMQ3mReCSo84xrt7XqW5u3KvhTZqs958ohrqBqDqVtPASQspizGiFJVSekwTdrpt5lbiAsRuUAc1ZX3Omn/fIJXTV4QhnZDaMBXklGbYxhcqcq0LI9QweaiBbM42fRcXJq7QZWXGrHcfODwKUtF8Ib2E+rAGSJ2+/fJGv14p5fZiiyV22wCkiER8BLgOwt1KYhdcuzZC99Qg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEYPR06MB5062.apcprd06.prod.outlook.com (2603:1096:101:53::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.11; Wed, 1 Oct 2025 07:46:09 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%3]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 07:46:09 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v4 3/3] tests/functional/aarch64/test_aspeed_ast2700fc:
 Add vbootrom test
Thread-Topic: [PATCH v4 3/3] tests/functional/aarch64/test_aspeed_ast2700fc:
 Add vbootrom test
Thread-Index: AQHcMp8g54nINpzYqE6uaT6XYHM/HbSs5c4AgAAAZ5A=
Date: Wed, 1 Oct 2025 07:46:08 +0000
Message-ID: <SI2PR06MB504112C0F9FC1130B4C3D50EFCE6A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20251001064625.1058680-1-jamin_lin@aspeedtech.com>
 <20251001064625.1058680-4-jamin_lin@aspeedtech.com>
 <3e2c8210-9e99-438b-aa9b-13479d59f6c9@kaod.org>
In-Reply-To: <3e2c8210-9e99-438b-aa9b-13479d59f6c9@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEYPR06MB5062:EE_
x-ms-office365-filtering-correlation-id: 108b9e27-fe6f-444d-53e1-08de00be95d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?c1pDa0I5MHQ3Vm9rUDdyM001SXVsdk5sU0dDTHZ6Mnp0dmxzR09VSVpySWxp?=
 =?utf-8?B?SURJMHp3S3VMRjJpbkp5NzhKOU4yMjZ1ZVRBUlQycWIwc1phOVFkVzhQMFdu?=
 =?utf-8?B?N3VHUS9QVWNxbk05OHlsQStjZUVMOWlCR1hGODBnN2lHdDVTUUJUUXc2TGZR?=
 =?utf-8?B?bG5GUlJFT2xYOXNIcG5uSkZSYS85N1ZjSDhxSHV2Z0txVFVDc0FOZkR4Mm0r?=
 =?utf-8?B?SXBXVEdaWDJndlY4Q2M2L0dPbEVGbFBTK1h5UUJXL0czZGM5THVpSmRLUG5j?=
 =?utf-8?B?cU4rTUdYdFRsL3o0c0xDQmlsOHRMZ1U1aU0xc21DRjlVMXdwUDVwbVhEdENS?=
 =?utf-8?B?bVE4NU40am1rVUNZOThBcmJwZXRyeXpXdlhwMmhoSHB4RWdqYzZ1TUloYkhn?=
 =?utf-8?B?cWs1UU95TWQ3WFF5QWZtU1EzMHNIa0lHQ01pb1IzbEdzc29Rek1FOFZ3akUv?=
 =?utf-8?B?N0EyVmRiVVFkaGdjRm1xN1pWREhIb2VCUldsQ0dzTHB2SmszT3NpSmV1TVIx?=
 =?utf-8?B?czBQMHFjMURWL3RtWHVGSUJkNFNlbEptTmFKeGdnQlYzTHFnc0daVVhYZlk5?=
 =?utf-8?B?eDZoek1BUk5NRiswU1Zzd3ZwZFN3VTVqeFcyV0JJb0FTRzhSdDFMYWZPQnBs?=
 =?utf-8?B?cU4zNjZ6OW50QlQzZnJIUmpGSVI4eUhHNk13VlFOelg5NVdvSW9JZWhpY0Yx?=
 =?utf-8?B?Y1pFTzJKUjVzcS9rWWJPNzJvWkx2R0NiR1M5eTZTUzAyRjBlOXEzUHJXbVRN?=
 =?utf-8?B?ZEw1Z2poZWJTazZrbGJCK0I0T2hwMVdRN1dmS2VoQ2FMbjRrTElDL1JNdEt1?=
 =?utf-8?B?OHdmTnR1TXNvOE54bFp1aWJWSklWb1hPNHR1YmFJSVBsNkExaWo1MGhkS2ZW?=
 =?utf-8?B?OTFTdDYzNnY1a01NM2NwMUtsLzhEQlZaVUExU3A5WVh3M1ltenEyOFRSaTVI?=
 =?utf-8?B?a2paSUVpeDdZSEF1bm84aTAxTmovUGh5VHhFQW9BTHpYWmw1alZVbzZzVmpz?=
 =?utf-8?B?bzdVNlFtSTN6MmZ0WEEvVGJFUUZjYnFXK0pLYk9sR0hwQW92RUdNTS9QU1ZE?=
 =?utf-8?B?ZmF6ZXFadXB6Qjl5aFh4dXNid1Q1MFZtL1lYSzBJWDFJM1R3a25sY0lJZktF?=
 =?utf-8?B?enNSMGtMYlhYdmxRV1E0UVkxcHUvb3V5Ym10Q1hidElTZDA2YTBTeDJxSVpp?=
 =?utf-8?B?KzNNMm9QeDRCcFZsUVQvZzJFZDFoKyt2UjROdGorWE4zek9tNWZtTitiUlR4?=
 =?utf-8?B?bHFycWF2U2JXWUlZbE1zUjhROXRKRzZkb2JJVWFtaExwQytaU044TFhmeVRJ?=
 =?utf-8?B?RlBNM1p0SldKMDFkdlU1aDNIb3hpU0lZWDQ3b0hBbnFPUE9SWGlJQ1g2Vk1u?=
 =?utf-8?B?Ynp3REVPdHNUbEhjd0FZcFZhVjE2SUVTajNXV080WFNqYmp4R052ajkzbTdS?=
 =?utf-8?B?MkZiSnI1bFN4NE1sa2R1OHF3SGdyVGZjZHJSUitocVBza1Urc3Q1eERaSHV1?=
 =?utf-8?B?VkI1bG44ZkxUNFhWZFRQbldHUFBxVFZHeFF6bk1CRmVqblF4WEFyZ3hjZ1Nh?=
 =?utf-8?B?VURwZWRoeDVDd1VzeG9xbTdvNiswVGlnUU9iR2h4WW5IOEpFZ3QrYms2VWpa?=
 =?utf-8?B?TURUSCs5YTRZVllwNWhtVWRoczhhVTB3RGtoaVJlTUlKbzRDbUVabktXY0hx?=
 =?utf-8?B?S0lnYk45ZUlmR1ZNR3kxVm1QUWpRTzkvQlgzSGZ2Yml5dlpqZGFObFVmM2hJ?=
 =?utf-8?B?V1FNdTVuUFR6eDhKbUxSZlJ4QTg5c1NXUWhjUmJqZUpTN1lkalppQ3VFOEhM?=
 =?utf-8?B?MWpvZEY4NFF1N1owN01DUy9xTng0YzMvZlVCbnpPQVpZd3Jvbk9ZOVhoN3dp?=
 =?utf-8?B?M3o5RmlpK0tJZ3Z2OTN6ZWJkTG1VUmpqajBSdUNyRlRGeU1qS25YNGZNNVBG?=
 =?utf-8?B?SjErNCtNMW1xNjgxa01uUVBKalpLcnpuR3dBa001RFVOZXRlR3JmZCtlcWdR?=
 =?utf-8?B?M2tkWlYyRzBlME9NMHc4WCs5M21EeTZpMmlpZTJoZmpUdUgycC9GTHliRzRE?=
 =?utf-8?Q?3YXISv?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXBmTXpHUjYydTBxUUxCWUNDcTBEZ0F3SHJRcm1IZ200ZFZDQ2FEbFFkb0F5?=
 =?utf-8?B?Vk5RcUZKaFZCa0N5MVpiYXlBdGRPL3A1RklicHpHV01jNDVpb1B3NjhqTk1P?=
 =?utf-8?B?R3lha3pTM0QweFR1NUdrMWtzbkp5MFQxUjkzZE9jc1YwNExJaTJCRjVQRElB?=
 =?utf-8?B?K1M1NUhxKzRyay9SeHZYdEY3c09XYWUwY1lLbDBOVkI0TzNOSzRFejlsNlpM?=
 =?utf-8?B?WnJ4UVpkc2lRTEl3R3d3OTcxSVpSM3kzUmpodEZDQnNvRFRDNkdXR0tlazVH?=
 =?utf-8?B?eHR6RXNYbDU3OWFaTlY5cFFYZEs2QlJ3RGtRMmlpdFlrbmJKcVRIT1g4RlFx?=
 =?utf-8?B?NXEzdGZ6c1pFdGtHMEZ5SlFmUGxCS0tBRE9NUmNCMm01VzVoZ0VJWTZXYW5B?=
 =?utf-8?B?NmszbmJlazB4aDVpS081SWNaM0RBeS9uTjdZRWpSSFJLZU1kKzNFN3hzOFFp?=
 =?utf-8?B?enJTZ3dVdkR3RVZoYVl1QnFvVFdvSXBQcmlQZW9JWDZpbTJVWFF5K09ndXRS?=
 =?utf-8?B?RUxCNWZlRWxJWHZQQVRRWkI0TmlnSU1EbDVwUCtvOG0vRGIzQ0VqQU0rTGox?=
 =?utf-8?B?TU5RQVg5K1AwU3BBcERxMkZjWitmNCtvNDVTVmMyUjdaR25rNmFHMHo1SHFL?=
 =?utf-8?B?MnRwdkdYVEU1Z0FCc0NOUFJvODRsQkh0ZGZxUFEveFBrTG1ReGl2R21GU0FC?=
 =?utf-8?B?MTU2b2JXdFVrYVFnSDBhTFVFMVV5ZTI0Vk9HZjViekl2MkJPRUQyOG1JTUI4?=
 =?utf-8?B?WG5iTWsxMjlkR3hYeWYyMUQ3Yll1Y0FSTm9JcmlWaWZ1TlAyc3RtUklzcDJ5?=
 =?utf-8?B?eDV5OE5BaTlxeWRPWHFXKzAwRlZ6UUhxdWp6elFyRDhQNmlOWFFUdzQ4VGdv?=
 =?utf-8?B?SjRKcG9paWhYR3Axdnh4aGc1cDg0bHRvVXZheU5KV3NqZEFSTEJUVXluWFpP?=
 =?utf-8?B?dzFMM2ZJRzNEYkRnelF2Y1d5TkxIdEtjNmQxR1pXQ2RVOHZWR0VEY1VjSTVx?=
 =?utf-8?B?cjhOQjFWdThCeUhRRWk0TmhNUllaeUpsTXFyejVWTlJqa1lQVXViSHFld01L?=
 =?utf-8?B?SjJnRGVaakdpZ085OGozZ1BSb2l3SkhpMzFqK2hjZGoxRFZSRzQxaWg2RW9R?=
 =?utf-8?B?bTFvbENKV0UvbnBkaVNGOUdKS2QvcC8zOUlNcUwwSEdHczl5YUw4VDVXNW42?=
 =?utf-8?B?T05pS3JaVldqVjRueHFmWWZXME9qZm1VdzZSbWxod1R6MXFvMDBRVDkybDcr?=
 =?utf-8?B?NldZUkNVS0dWdTM1VGVlSTk4K3pGbkg5TDltSW01cnVpOW5OVFUxUU9aaG1S?=
 =?utf-8?B?MU9IREFJNkhxMHg2U0lFT0VSbWpuL2d3NWhHbS9yNDI3ZHBsWG00TGhqbjBv?=
 =?utf-8?B?dU1KeENGQWxJOWY5QVVMckJYK3RFVmZ4L0pUcmdJR0xxbmVvdDQwOGJMZFEw?=
 =?utf-8?B?dXAwUWYwdzJQT2tNVzJTV1dPbk02RUlPRWRYaUMxOFdKdEFhYjZyeDYwT1cv?=
 =?utf-8?B?dmxRYjVDQU5xZ0haT29kZ1RkVko2c2IwK0V5VkVHTG1xU3lzVTBTSlhvMGJq?=
 =?utf-8?B?MFR0UnRZNzU4YTd2RjJhVWF4Y1l3UGJNT21odGNQQjRHT2ZZLzBUeXhtUVRN?=
 =?utf-8?B?cmxjYUtLTWNodnVwMHIrYitHRkdnckZDbTlESjBjQnUxeVVOcXg1ZjF5aGxz?=
 =?utf-8?B?dDVDSzlNOCtRc1B4ZVhod29tbGdzV3Vwcm5tUVlwd0Y3WEFuSXFkbkZBYWtI?=
 =?utf-8?B?eEVKYlVxRXVXNEU2WDNCb2VDWjA1Ymx5SXRnbkhpK2NjQmFwTHRMWlAycU1m?=
 =?utf-8?B?Unc4a1dDSWNKNjd6R21mdmNULzNYR2JKYStrL0Vxb2pqKzczYllRd083QldE?=
 =?utf-8?B?MFFSdnJiVTBwYjU0emlWTWZXS29TKytYRklvd1hidFd4UHdxLy9qelBjOEVO?=
 =?utf-8?B?cm1DdVpvMTZoU1FuWUprK1NuMndOUnBST25JVHNVUWF4TkxxTlhHamRvVXlv?=
 =?utf-8?B?NTF4b1hrZi9KTktvQ3hva0lSM2YrcC9UaWMyc0lQZDdEZFZLWmlqOSt5MlNp?=
 =?utf-8?B?bUdqc0JUQ3FMOHl2THE4di85QWp0ajZneUxGTWJhMURja3VSSlVjU0d5c0ww?=
 =?utf-8?Q?ZOks8oPRyi7Enr56m1WnpXy5J?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 108b9e27-fe6f-444d-53e1-08de00be95d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 07:46:09.0336 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sIskXJREoAg4XxqXLeL4ZkZXjqyxFHdA+eWxG9UC+Ev9UCUDAM7vUzTzig9DQbl5cC2JJx4CXU2Kxj+91LZIN69b1ocKbGz+uFZYstJiM+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5062
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMy8zXSB0ZXN0cy9mdW5jdGlv
bmFsL2FhcmNoNjQvdGVzdF9hc3BlZWRfYXN0MjcwMGZjOg0KPiBBZGQgdmJvb3Ryb20gdGVzdA0K
PiANCj4gSGVsbG8sDQo+IA0KPiBPbiAxMC8xLzI1IDA4OjQ2LCBKYW1pbiBMaW4gd3JvdGU6DQo+
ID4gSW50cm9kdWNlIGxvYWRfYXN0MjcwMGZjX2NvcHJvY2Vzc29yKCkgdG8gbG9hZCB0aGUgU1NQ
L1RTUCBFTEYgaW1hZ2VzDQo+ID4gdmlhIC1kZXZpY2UgbG9hZGVyLiBVc2UgdGhpcyBoZWxwZXIg
aW4gc3RhcnRfYXN0MjcwMGZjX3Rlc3QoKSB0bw0KPiA+IHJlbW92ZSBkdXBsaWNhdGVkIGNvZGUu
DQo+IA0KPiBJZGVhbGx5LCB0aGlzIHNob3VsZCBiZSBhbiBleHRyYSBwYXRjaC4gTWlub3IuDQoN
Cg0KV2lsbCBmaXgNCg0KPiANCj4gPg0KPiA+IEFkZCBzdGFydF9hc3QyNzAwZmNfdGVzdF92Ym9v
dHJvbSgpIHdoaWNoIGJvb3RzIHRoZSBhc3QyNzAwZmMgbWFjaGluZQ0KPiA+IHdpdGggLWJpb3Mg
YXN0Mjd4MF9ib290cm9tLmJpbiBhbmQgcmV1c2VzIHRoZSBjb3Byb2Nlc3NvciBsb2FkZXIuDQo+
ID4NCj4gPiBBZGQgdGVzdF9hYXJjaDY0X2FzdDI3MDBmY19zZGtfdmJvb3Ryb21fdjA5XzA2KCkg
dG8gdGVzdCB0aGUgdmJvb3Ryb20NCj4gPiB3aXRoIGFzdDI3MDBmYyBtYWNoaW5lLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+
ID4gLS0tDQo+ID4gICAuLi4vYWFyY2g2NC90ZXN0X2FzcGVlZF9hc3QyNzAwZmMucHkgICAgICAg
ICAgfCAzNw0KPiArKysrKysrKysrKysrKy0tLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMjgg
aW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS90ZXN0
cy9mdW5jdGlvbmFsL2FhcmNoNjQvdGVzdF9hc3BlZWRfYXN0MjcwMGZjLnB5DQo+ID4gYi90ZXN0
cy9mdW5jdGlvbmFsL2FhcmNoNjQvdGVzdF9hc3BlZWRfYXN0MjcwMGZjLnB5DQo+ID4gaW5kZXgg
MjhiNjY2MTRkOS4uYzA0NThlNDdiMiAxMDA3NTUNCj4gPiAtLS0gYS90ZXN0cy9mdW5jdGlvbmFs
L2FhcmNoNjQvdGVzdF9hc3BlZWRfYXN0MjcwMGZjLnB5DQo+ID4gKysrIGIvdGVzdHMvZnVuY3Rp
b25hbC9hYXJjaDY0L3Rlc3RfYXNwZWVkX2FzdDI3MDBmYy5weQ0KPiA+IEBAIC04Myw2ICs4Mywx
NyBAQCBkZWYgZG9fYXN0MjcwMGZjX3RzcF90ZXN0KHNlbGYpOg0KPiA+ICAgICAgICAgICBleGVj
X2NvbW1hbmRfYW5kX3dhaXRfZm9yX3BhdHRlcm4oc2VsZiwgJ21kIDcyYzAyMDAwIDEnLA0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJ1s3MmMwMjAwMF0N
Cj4gMDYwMTAxMDMnKQ0KPiA+DQo+ID4gKyAgICBkZWYgbG9hZF9hc3QyNzAwZmNfY29wcm9jZXNz
b3Ioc2VsZiwgbmFtZSk6DQo+ID4gKyAgICAgICAgbG9hZF9lbGZfbGlzdCA9IHsNCj4gPiArICAg
ICAgICAgICAgJ3NzcCc6IHNlbGYuc2NyYXRjaF9maWxlKG5hbWUsICd6ZXBoeXItYXNwZWVkLXNz
cC5lbGYnKSwNCj4gPiArICAgICAgICAgICAgJ3RzcCc6IHNlbGYuc2NyYXRjaF9maWxlKG5hbWUs
ICd6ZXBoeXItYXNwZWVkLXRzcC5lbGYnKQ0KPiA+ICsgICAgICAgIH0NCj4gPiArDQo+ID4gKyAg
ICAgICAgZm9yIGNwdV9udW0sIGtleSBpbiBlbnVtZXJhdGUobG9hZF9lbGZfbGlzdCwgc3RhcnQ9
NCk6DQo+ID4gKyAgICAgICAgICAgIGZpbGUgPSBsb2FkX2VsZl9saXN0W2tleV0NCj4gPiArICAg
ICAgICAgICAgc2VsZi52bS5hZGRfYXJncygnLWRldmljZScsDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZidsb2FkZXIsZmlsZT17ZmlsZX0sY3B1LW51bT17Y3B1X251bX0nKQ0K
PiA+ICsNCj4gPiAgICAgICBkZWYgc3RhcnRfYXN0MjcwMGZjX3Rlc3Qoc2VsZiwgbmFtZSk6DQo+
ID4gICAgICAgICAgIGNhMzVfY29yZSA9IDQNCj4gPiAgICAgICAgICAgdWJvb3Rfc2l6ZSA9IG9z
LnBhdGguZ2V0c2l6ZShzZWxmLnNjcmF0Y2hfZmlsZShuYW1lLA0KPiA+IEBAIC0xMjAsMTYgKzEz
MSwxMyBAQCBkZWYgc3RhcnRfYXN0MjcwMGZjX3Rlc3Qoc2VsZiwgbmFtZSk6DQo+ID4gICAgICAg
ICAgICAgICBzZWxmLnZtLmFkZF9hcmdzKCctZGV2aWNlJywNCj4gPg0KPiBmJ2xvYWRlcixhZGRy
PTB4NDMwMDAwMDAwLGNwdS1udW09e2l9JykNCj4gPg0KPiA+IC0gICAgICAgIGxvYWRfZWxmX2xp
c3QgPSB7DQo+ID4gLSAgICAgICAgICAgICdzc3AnOiBzZWxmLnNjcmF0Y2hfZmlsZShuYW1lLCAn
emVwaHlyLWFzcGVlZC1zc3AuZWxmJyksDQo+ID4gLSAgICAgICAgICAgICd0c3AnOiBzZWxmLnNj
cmF0Y2hfZmlsZShuYW1lLCAnemVwaHlyLWFzcGVlZC10c3AuZWxmJykNCj4gPiAtICAgICAgICB9
DQo+ID4gLQ0KPiA+IC0gICAgICAgIGZvciBjcHVfbnVtLCBrZXkgaW4gZW51bWVyYXRlKGxvYWRf
ZWxmX2xpc3QsIHN0YXJ0PTQpOg0KPiA+IC0gICAgICAgICAgICBmaWxlID0gbG9hZF9lbGZfbGlz
dFtrZXldDQo+ID4gLSAgICAgICAgICAgIHNlbGYudm0uYWRkX2FyZ3MoJy1kZXZpY2UnLA0KPiA+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIGYnbG9hZGVyLGZpbGU9e2ZpbGV9LGNwdS1u
dW09e2NwdV9udW19JykNCj4gPiArICAgICAgICBzZWxmLmxvYWRfYXN0MjcwMGZjX2NvcHJvY2Vz
c29yKG5hbWUpDQo+ID4gKyAgICAgICAgc2VsZi5kb190ZXN0X2FhcmNoNjRfYXNwZWVkX3Nka19z
dGFydCgNCj4gPiArICAgICAgICAgICAgICAgIHNlbGYuc2NyYXRjaF9maWxlKG5hbWUsICdpbWFn
ZS1ibWMnKSkNCj4gPg0KPiA+ICsgICAgZGVmIHN0YXJ0X2FzdDI3MDBmY190ZXN0X3Zib290cm9t
KHNlbGYsIG5hbWUpOg0KPiA+ICsgICAgICAgIHNlbGYudm0uYWRkX2FyZ3MoJy1iaW9zJywgJ2Fz
dDI3eDBfYm9vdHJvbS5iaW4nKQ0KPiA+ICsgICAgICAgIHNlbGYubG9hZF9hc3QyNzAwZmNfY29w
cm9jZXNzb3IobmFtZSkNCj4gPiAgICAgICAgICAgc2VsZi5kb190ZXN0X2FhcmNoNjRfYXNwZWVk
X3Nka19zdGFydCgNCj4gPiAgICAgICAgICAgICAgICAgICBzZWxmLnNjcmF0Y2hfZmlsZShuYW1l
LCAnaW1hZ2UtYm1jJykpDQo+ID4NCj4gPiBAQCAtMTQ0LDUgKzE1MiwxNiBAQCBkZWYgdGVzdF9h
YXJjaDY0X2FzdDI3MDBmY19zZGtfdjA5XzA2KHNlbGYpOg0KPiA+ICAgICAgICAgICBzZWxmLmRv
X2FzdDI3MDBmY19zc3BfdGVzdCgpDQo+ID4gICAgICAgICAgIHNlbGYuZG9fYXN0MjcwMGZjX3Rz
cF90ZXN0KCkNCj4gPg0KPiA+ICsgICAgZGVmIHRlc3RfYWFyY2g2NF9hc3QyNzAwZmNfc2RrX3Zi
b290cm9tX3YwOV8wNihzZWxmKToNCj4gPiArICAgICAgICBzZWxmLnNldF9tYWNoaW5lKCdhc3Qy
NzAwZmMnKQ0KPiA+ICsNCj4gPiArICAgICAgICBzZWxmLmFyY2hpdmVfZXh0cmFjdChzZWxmLkFT
U0VUX1NES19WOTA2X0FTVDI3MDApDQo+IA0KPiBDb3VsZCB3ZSB1cGRhdGUgYWxsIHRlc3RzIHRv
IHVzZSB0aGUgbGF0ZXN0IFNESyB2MDkuMDggWzFdIHdoaWNoIHdhcyByZWxlYXNlZCA/DQo+IA0K
DQpJ4oCZbGwgdXBkYXRlIEFTVDI1MDAgYW5kIEFTVDI2MDAgdG8gU0RLIHYwOS4wOCBhZnRlciB0
aGUgcmVsZWFzZS4NCg0KRm9yIEFTVDI3MDAsIHRoZXJlIGFyZSBhIGZldyBpc3N1ZXMgd2Ugc2hv
dWxkIGRpc2N1c3MuDQoxLiBBU1QyNzAwIChhc3QyNzAwZmMpIOKAkyBTREsgdjA5LjA4IHN1cHBv
cnQNClRoZSBhc3QyNzAwZmMgbWFjaGluZSBjdXJyZW50bHkgd29ya3Mgb25seSB3aXRoIFNESyB2
MDkuMDYuICB2MDkuMDcgYW5kIHYwOS4wOCAtLT4gV2lsbCBlbmNvdW50ZXIgYm9vdCBjcmFzaC4N
ClRvIG1vdmUgdG8gdjA5LjA4LCBJIG5lZWQgdGhlIHBhdGNoIHNlcmllcyhDb250cm9sIENvcHJv
Y2Vzc29yIFJlc2V0Li4uLikuIEnigJltIHJld29ya2luZyBpdCBzbyBpdCBjYW4gYmUgYWNjZXB0
ZWQgdXBzdHJlYW0uDQpUaGlzIHJlZmFjdG9yIGludHJvZHVjZXMgQXNwZWVkQmFzZSBhbmQgQXNw
ZWVkQ29wcm9jZXNzb3IgY2xhc3NlcyBhbmQgd2lsbCByZXF1aXJlIHN1YnN0YW50aWFsIGNoYW5n
ZXMgYWNyb3NzIHRoZSBjb2RlYmFzZShJdCB3aWxsIG5lZWQgYSBsb3Qgb2YgY2hhbmdlcykuDQoN
CjIuIFN0YXJ0aW5nIHdpdGggU0RLIHYwOS4wNywgb3VyIFNESyBubyBsb25nZXIgcHJvZHVjZXMg
InUtYm9vdC1ub2R0Yi5iaW4iLg0KQXMgYSByZXN1bHQsIHRoZSBtYW51YWwgZGV2aWNlIGxvYWRl
ciB0ZXN0cyBvbmx5IHdvcmsgd2l0aCB2MDkuMDYgKC1kZXZpY2UgbG9hZGVyLGFkZHI9MHg0MDAw
MDAwMDAsZmlsZT11LWJvb3Qtbm9kdGIuYmluLGZvcmNlLXJhdz1vbikgLg0KUHJvcG9zYWw6IGRy
b3AgdGhlIG1hbnVhbCBkZXZpY2UgbG9hZGVyIHRlc3RzIGFuZCBrZWVwIG9ubHkgdGhlIHZib290
cm9tLWJhc2VkIHRlc3QgY2FzZXMgZ29pbmcgZm9yd2FyZC4NCg0KQ291bGQgeW91IHBsZWFzZSBn
aXZlIG1lIGFueSBzdWdnZXN0aW9uPw0KVGhhbmtzLUphbWluDQoNCj4gVGhhbmtzLA0KPiANCj4g
Qy4NCj4gDQo+IFsxXSAgaHR0cHM6Ly9naXRodWIuY29tL0FzcGVlZFRlY2gtQk1DL29wZW5ibWMv
cmVsZWFzZXMvdGFnL3YwOS4wOGVkDQo+IA0KPiA+ICsgICAgICAgIHNlbGYuc3RhcnRfYXN0Mjcw
MGZjX3Rlc3RfdmJvb3Ryb20oJ2FzdDI3MDAtZGVmYXVsdCcpDQo+ID4gKyAgICAgICAgc2VsZi52
ZXJpZnlfb3BlbmJtY19ib290X2FuZF9sb2dpbignYXN0MjcwMC1kZWZhdWx0JykNCj4gPiArICAg
ICAgICBzZWxmLmRvX2FzdDI3MDBfaTJjX3Rlc3QoKQ0KPiA+ICsgICAgICAgIHNlbGYuZG9fYXN0
MjcwMF9wY2llX3Rlc3QoKQ0KPiA+ICsgICAgICAgIHNlbGYuZG9fYXN0MjcwMGZjX3NzcF90ZXN0
KCkNCj4gPiArICAgICAgICBzZWxmLmRvX2FzdDI3MDBmY190c3BfdGVzdCgpDQo+ID4gKw0KPiA+
ICAgaWYgX19uYW1lX18gPT0gJ19fbWFpbl9fJzoNCj4gPiAgICAgICBRZW11U3lzdGVtVGVzdC5t
YWluKCkNCg0K

