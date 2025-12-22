Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8A2E6748D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 09:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXcWN-0006Ch-9G; Mon, 22 Dec 2025 04:48:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vXcWK-0006Bd-S3; Mon, 22 Dec 2025 04:48:04 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vXcWI-0000EK-Nr; Mon, 22 Dec 2025 04:48:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yc3G+L8Ufm8r1huu62FyO8P4X8hE5DhtKdCnfXthfWvzK88KCMe7clK4X/6DcWApNMaQgQX7arrQ1dvh/X8d52UvUHhXM06HHkJg9ZNtUOdo35cmm7L3pDN9C7dnZ13HoWp/vaGMe3pWTlIv4L2LGUDUBiaIj/cnz1IY84plmrtfMiAQuJ+uL+drHOQB+GXgx6hjN8Y5RdANmMluQ+Ab8m9CCETbR+4hZhAfeP6loBNeM1SdTGWT0oSS3IWcLhzfLEVD1YNnThgGxNGRegkQ3K6R/YCgiqCjc3g4uRWXKybNADTzM/iOdLLsRqHc+UIlkC3pazKmExgAy4CrLA9PWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=henAuUAFamMCGmYtJp0VbW0AkfO34BsYFM9Vm1CtwYE=;
 b=AbZPKmKjMYtrtTk/wq9dlILUJ1Zgd38sOqu5F48PFuNTeCJT51SmNm/gKm3u3xsx0mVadJb3LldktosvwhaU0u1S1AIKXPL6k9kYEI2tqeyL3ybZxrs/uBitNFVsiJH6WBo7mLcGTbh0fmF83aAzlYUw7Ox+IigYfpZdOLszGb0nt3UAcGNN5PZ1G/ILQm4NoED1sH2ptiX6fdY+WEktNG7PyctFXqxmQRqLi4bHYqcnZdfEwl+Y/LUIgvAqhJudL0Q7N4/BSRO/gE//CC8w7by/4jqObCSpWxMVXmKEkH3ScbZJr0QLsLkYFI6zG7EhGqwH7+jvo/iilNbvy3xxfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=henAuUAFamMCGmYtJp0VbW0AkfO34BsYFM9Vm1CtwYE=;
 b=Sfn3K5beID+8CUukTq3BX5y6Bh9pmDWWbFRJfMAZgrGvgBw2ZYUsNqA6D3DqrmqEH95Ndvn/wMr6vGWgjTCZ/fyNn6nWGkJk7ZIbT1h0YMaLyNNEKKwm/1pjiBvshCM4YL6aAX3tXU56Q+uelyI6UN3Pmksdbrk6Xxs6j0+N/5LvYjx+3qy4KyPMZ6Dpl/HAsBPVKp8RVwEf0QwzN93d4iAEqKIgzpnrH2UxHxzls0s7QQaLebCWZJdZwBIAPdRaQXnDFJtSmyg2e5FMnc9mMg1x/wGId7dn5fvCEzEwIlBV8NGFCxxtxQXIBKx9rdRSlnGO+uZGcsxFYMW4vl8nug==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TY1PPFF90486440.apcprd06.prod.outlook.com (2603:1096:408::932) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Mon, 22 Dec
 2025 09:47:52 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%6]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 09:47:52 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [SPAM] [PATCH v3 04/18] hw/arm/aspeed: Add AST1700 LTPI expander
 device model
Thread-Topic: [SPAM] [PATCH v3 04/18] hw/arm/aspeed: Add AST1700 LTPI expander
 device model
Thread-Index: AQHcaBaFY6ZnQvn4j0uGeFVa1iPi2LUpQcOAgAQ89NA=
Date: Mon, 22 Dec 2025 09:47:52 +0000
Message-ID: <SI6PR06MB7631D30E51FB13698E828ECCF7B4A@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20251208074436.1871180-1-kane_chen@aspeedtech.com>
 <20251208074436.1871180-5-kane_chen@aspeedtech.com>
 <d21521e6-3480-47bf-8f42-94263a2bb778@kaod.org>
In-Reply-To: <d21521e6-3480-47bf-8f42-94263a2bb778@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TY1PPFF90486440:EE_
x-ms-office365-filtering-correlation-id: 814b3545-849f-4462-4ec6-08de413f2d13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?VlpnZlhHeFVuc2hRQmFzSnRPS2tZN2p6a2c3U3k1a3lFR2ZSc2NaY3lNbUl1?=
 =?utf-8?B?cnZhSXJVRTdCczJYNm93U0ZWZWl3N1A5WWFScWV1dVoyaHV2N1JQZklqQ1pu?=
 =?utf-8?B?QUo0cmkwZDVXZHlETEJUR3QwbEFIemdTc2lnZlI3dGRWWVNGWXVrU3MwVk9G?=
 =?utf-8?B?S3lyL1lPZ2Rtb3BlSlVWMExEc0FjcEdJbnRiMnNkVkh3a3JvMzBvWTVBM0kr?=
 =?utf-8?B?WTFyelZoL08vYS9SdkwxZW9ET0xKV0wxYWlWTlRCeEtXRUNPeVRZSzNMLzBT?=
 =?utf-8?B?WTQzUjRUVnFZVURiMDQyT3FjY3JmWm10UXA5Y0xIZTZiaWpZaVZ2M3FWaHAz?=
 =?utf-8?B?QWJzbk81WmUvV0l0RWt5TlNkbWg4NS9aUXVOdU5hS3ZOWWJPdXRlNTZibXhJ?=
 =?utf-8?B?bTlqb2FmWmNGODFTNnVMU090K1dKT1ZLMkw4N2p6T1RweldBclFwWWdydE9O?=
 =?utf-8?B?MnM5dHJtQTBmVTIrT04vZmJ6Z1FxczNXcUxaajJCSkhVRmZKMEc0Wm91cEgr?=
 =?utf-8?B?SWluQisvQjYwbWxoU0E3SHk1TldXdVdEKzVxWVdLR2U0TDR4NGZJUk5QbUxt?=
 =?utf-8?B?R3QwbEgvZ01mRFdzaGpIem1FK2pDZjVzbDdCMFF2cjJXZEVUOFFESFpZZU1Z?=
 =?utf-8?B?b0tSdnppTTNnbVNFK3M4WkJ1SjcxS1RMQXZ0d0VOTWtHVjVuRVN0SjdGWXR0?=
 =?utf-8?B?NndZMkNCZm1LVFJEMTBWYzhnSXcwa3pBZHZxNUdHbWE2SzJjdDhRRnZqY0o0?=
 =?utf-8?B?TVdrQXJmYUg1QnNVV2dBQ01DVGplZkYwQ0RtYmhrMWE2WU9lUmkxbHA4VjJU?=
 =?utf-8?B?MGF3SFR4ZkZYWWhVdzlFTmdUdnBwdkk4S0dVbzRDUk1udUk0MDlJbmlLNGZw?=
 =?utf-8?B?aEJyM0NpSVRFNFJaQmVlRDhyQWpObnFqZjQySFRrUnA0NnNVTk9HbTUxdE9i?=
 =?utf-8?B?YmxEdEUxMjlrRmNCbkpkNXBuWFVhSlh3SEVYbTEvTUZxYzllK0diYzYwK0M2?=
 =?utf-8?B?Sk0yblAxY2p6RE9VUWpIbkN3aGt0bVp0T2JpVGZsV0l2dWpGMXIzcGNYaEJp?=
 =?utf-8?B?azdKRkpRaUZCWjZRTlJCQWR1dnJ1S2VWZHpQU1BOZWtIenJFdXlOL1pIOUM4?=
 =?utf-8?B?WHJCb1M1MUdackxhZlM4V1p2Nmp4MkE3cVd2U3VmR1M1Z2pmSEZON0tyR3ls?=
 =?utf-8?B?b2F3MVl3UHVIQVRpTUV2WlhLRGxCbGtHNHlaRGVaQjFCVm5WMmdCa3dnVDdt?=
 =?utf-8?B?aUp0ZzRkREJ6TVA2QlJpaDVtTEV1UHY3eFBRb1lQK2huRXJCcDF3Yi81VGVp?=
 =?utf-8?B?MDMwYmM1VDh6T2M5dzM5cElJS2s1MkQ2cGdJcEo4a3RoQyttYjVBVUhCZVRh?=
 =?utf-8?B?ZUlXVlR3ZzI3UHpXSll4WWlMTGtOamMyOFZVMXRVekY5WFVoUW55dG5ndHFn?=
 =?utf-8?B?ZnJnSWNWeUptMTMrMkpaNEo2R2ttenFFQkNXMVhNa0tvRks0alJVaElPRjFx?=
 =?utf-8?B?U29lMzRRWjJJT210Skh5aFEwa2MyYVBOYXVrSVFPQjhockk0OVdqdlMvQ0FB?=
 =?utf-8?B?VnZBWTc3SHhhSGhhRFY3cE9wb0VKMHhuVUtFeFcrenRLMGpNeDBuVDNiM2J3?=
 =?utf-8?B?RS9NVy9tNTBIdkNJTXNIcm1xNk42K214RDVSYlZpa3g5QW5CcG1mQWtFOEcz?=
 =?utf-8?B?c3ZTaTM5S0dzd3A2U3pTSGZ0S2JIWktMQUJyRlZQeWhEMTljSVZLUmdOUkxz?=
 =?utf-8?B?Uk8rMmJXMWhkZDZuTU8wdFlvNUpBamRWc1FNWGFWYjNXUlNBaDBTeUxOR0h0?=
 =?utf-8?B?VXdJRmFzL252bG13MVVKRmNuWFZpMU9zVWNXWExKbjdvZnBTeUozaW9IUTJB?=
 =?utf-8?B?OWZHVi9CRE9JcWtJMEg1aURRbFBXZ3pPb3hSVUJXNHVNWGdNVHJCM212UWdZ?=
 =?utf-8?B?Y0hRWUZsM2s0aUlCQVlYRVRlMkNZb25BQ29TZlQ0Q09zY01DdXJKMU9EVWw4?=
 =?utf-8?B?QVZ0TjJnaFhkbk5PWUZsOStEbnphV204QWFjVVM3YWp4YUxXWCtWR2hKckU2?=
 =?utf-8?B?VXV0OWkrWStaamt0MDJWTllVaks4b3kyblZ5dm5vOVlSZ0tEc2MzYTVaRG5T?=
 =?utf-8?Q?4CMI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1B2Q09Ha3N4dXR5TFBWV1kveFhuekpkdUorNWRoUSsxOG9QdXAweG9aRVBw?=
 =?utf-8?B?SmFpSDNOSjErZlB0SGNQUmJMakJzaGF1MnhqUW1vNmUwcFF4OTEvdDNKWG5O?=
 =?utf-8?B?bXZ4SCtZd0phV2swNStXa3h2KzM4ZXNvUThMM0hVNDRJMmduanZncE10aEM5?=
 =?utf-8?B?LzZsQW9RYzJ6RXhUSWN1ZEg5clBGWnFjQjY4bDZ4UVU5UWdKWmFUcGlObXJX?=
 =?utf-8?B?SUVRMm1YaE9zKzlYUWVRVFRaL3JpV1BKUklsSXFlWFpuVGdUa3NUSVk4eStD?=
 =?utf-8?B?SWFocTN1aU9VNzVLR2NGNW1zSXVJNDZLaEkvMTdPRlBiV2ZOaVVyREhTSDZB?=
 =?utf-8?B?OWVVMHIzVmR2RTNHb0g3MUp2MTdXaWVEcXJJR1p5S3FrUzd3cHVWS1lzNlo4?=
 =?utf-8?B?MTYwS0NMUlBIT3ZMdlhqbmRvcGxSS2pwbDRBV1ltYm1JdUpXVkN2cnZlWHBm?=
 =?utf-8?B?UFhXRjhyQy9BOXZoUHREUXFjVTZ5MFRQZm9nRU45aTZ6UlZwaThocndDZGlI?=
 =?utf-8?B?Y3dRVGE3UE5tS0dpTU1mLzlQZzk4Q3ZudVJ6OUZYMXpSUUw5dXhvcEdzL0Z3?=
 =?utf-8?B?RGFhaXlXUXM4Q0RJcS9rdFJiQWJwa1Q1RURRT0o4QTVIMVdRVEcza3BWMXEy?=
 =?utf-8?B?MjU5ZzRaaVBadFVNU2hBZjBxQW5YdU9sZHo5WU9vc05IRk1UQWZDbzJ1VnRL?=
 =?utf-8?B?MHRtWkFkOFczRHE0WENtK1B4djUveTUwM3QzbTZZRytJNDMrd1YraTZyck01?=
 =?utf-8?B?cStSL2hWWllUSXViS0ZmWjBHSjVVUzd4SE9oNDhMK2FYSVJlNUpVYzlPQm1z?=
 =?utf-8?B?NzVpY0l2VVNmdEtNNmZxVWxhRWN6TFQ3RS9JWkdGV0Z0QXJuWkgybGZTMUJH?=
 =?utf-8?B?WklEQWVUTWwyYXlFaUJSMkk1QkFtSk9EcEZWQjVpUzdQKzBPTzlubzkrenBD?=
 =?utf-8?B?eFROZTUwaVg4NE5kTTJEL2I1NWI3aHdyQm1xL0FaZ3RFNmhhQWNPVDRhbU4w?=
 =?utf-8?B?cnNnQVVTa3dxTzhkUmxuTko2MFp2WDRNdDZPVGNuSHFhL0p2VFFEdFZVa3Iw?=
 =?utf-8?B?NGhVMmhJaXRxV2YzZlVta2hFSWp2WXNpenlRM2RSaVlDdjBuWitIaGdHQ1k0?=
 =?utf-8?B?VGttcUxZQnQ0WFh0c3kyQkZocll0U1VYalJqZ2NwMXUzZTZ1d29KWGl5RGg1?=
 =?utf-8?B?SzBiVGhkR0t1RERGTFBGemx3QVZwN1dCY1lDOXhMY1IrZkVlTFVIL09pQWZt?=
 =?utf-8?B?NFRwZU1vOVVvbExlUm5CSXdKMWVDbXMyUVRybWRJTWJ5Vm1aTlplQThMcjIy?=
 =?utf-8?B?WmZFNzhwRnE4R2dMWlRxVVFEelNldEtXQnFyQUh2aExhL1JqUmVKK0NVdXFr?=
 =?utf-8?B?YVdFRGFwcnlEMzZ1OVdpaWVlVHY5eng5S09NQlJxcDh4Tm13TzVzU3lWbklF?=
 =?utf-8?B?RlVFOHVFb2haWnovdS9BZ0Q1ZUpzdnV6WmFUZkFmNFcvYmFVWnJOdWlHeDk3?=
 =?utf-8?B?amx5UTZVZUptZU9XeWhrSVQ0RGxJY0tJSUNGME8ra2w4KzVIZXlpUVBBeXRY?=
 =?utf-8?B?TVZaYkxmSWJyK3V5TzlSUkFtR3dkcHNQcE9NWEFwVmd2TmJvbUNsdFFSUGYw?=
 =?utf-8?B?Mk5PYVNqNkdOL1ovWlJoZVRGMjhtNDBvTm5LODdiOXVMejJmbUw2ODlkT2xL?=
 =?utf-8?B?SWZYSnY2WDFCbklxSmNWMGJkbEVTaWF6ZFEyQTJmTHZvZ0xBcHF1M0NtcFBN?=
 =?utf-8?B?WXR4djBrL1p4bjdsRi96SUhlYTVacVJXUk9QTGNmQVkvV2Rod0xXME5VME01?=
 =?utf-8?B?Z1Uya004S3pRSU9FakZiV2tiY29lTWk4M1A2cmYyamJ3TTM0NDZFYWtCS1Aw?=
 =?utf-8?B?NGtwVnpRd0NQa0YwWnZhYjB2QWJ2Y01nd25LSVNFZWtkUnBPS0d0U3hFdGZ1?=
 =?utf-8?B?aDU3cVpwT043clpHNmFjR1N1UnY0T3ZrdWdUMDkxL3dVb3RTb2ZCNDRYWkh5?=
 =?utf-8?B?SGR3R3RKQjl2YmM3Z1JiSXBraWlzVzhoYm1yc0tyMVJKTGZHOU45dS83NGJN?=
 =?utf-8?B?SHBQQVk1L0ZQY2tHU2ZuNDRoR0pUbThhWERQSXZ3YXZ3Qlg4M3haWXdoMC9O?=
 =?utf-8?B?YTBiVVpCMmFuKzRCWDVQbDRQNnRWbTlLWEQrbzFNM2FFTjVLQUZQeEw3bWZM?=
 =?utf-8?B?MEp2ZSs2RTJtd0ZqQVBsN3ZmRUlrbkxpajF4YlYzc2UwWkZwejVuSVpLU0x2?=
 =?utf-8?B?aGh2L0lxMFIzUDFOcGtQaURsYXJEcHNoYUdBbDQrc25qcmhsbjlTODBOTDNF?=
 =?utf-8?B?RTlyUmNrdlM4UDQ1VktNUTlFb0J5UVhXK2hRanhLTWhJdE5BL1VRZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 814b3545-849f-4462-4ec6-08de413f2d13
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2025 09:47:52.7665 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mziuIrVgU9Wfl6yQxUAnXgXglH2745sKP4CwHAoADaPp3vrx4pULnEbuFp4oSFiFH7IM19dZJ/kNCH8HKxffKNxBOkbvz0LRGT8eqy/z0x4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFF90486440
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBTYXR1cmRheSwgRGVjZW1iZXIgMjAsIDIwMjUgMTowMCBB
TQ0KPiBUbzogS2FuZSBDaGVuIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+OyBQZXRlciBNYXlk
ZWxsDQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBTdGV2ZW4gTGVlIDxzdGV2ZW5fbGVl
QGFzcGVlZHRlY2guY29tPjsgVHJveQ0KPiBMZWUgPGxlZXRyb3lAZ21haWwuY29tPjsgSmFtaW4g
TGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBBbmRyZXcNCj4gSmVmZmVyeSA8YW5kcmV3
QGNvZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47DQo+
IG9wZW4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4gbGlzdDpB
bGwgcGF0Y2hlcyBDQw0KPiBoZXJlIDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IENjOiBUcm95
IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbU1BBTV0gW1BB
VENIIHYzIDA0LzE4XSBody9hcm0vYXNwZWVkOiBBZGQgQVNUMTcwMCBMVFBJDQo+IGV4cGFuZGVy
IGRldmljZSBtb2RlbA0KPiANCj4gT24gMTIvOC8yNSAwODo0NCwgS2FuZSBDaGVuIHdyb3RlOg0K
PiA+IEZyb206IEthbmUtQ2hlbi1BUyA8a2FuZV9jaGVuQGFzcGVlZHRlY2guY29tPg0KPiA+DQo+
ID4gSW50cm9kdWNlIGEgbWluaW1hbCBRRU1VIGRldmljZSBtb2RlbCBmb3IgdGhlIEFTUEVFRCBB
U1QxNzAwLCBhbg0KPiA+IE1DVS1sZXNzIEkvTyBleHBhbmRlciB1c2VkIGluIHRoZSBMVFBJIHRv
cG9sb2d5IGRlZmluZWQgYnkgdGhlIERDLVNDTQ0KPiA+IDIuMCBzcGVjaWZpY2F0aW9uIChzZWUg
ZmlndXJlIDIpOg0KPiA+IGh0dHBzOi8vd3d3Lm9wZW5jb21wdXRlLm9yZy9kb2N1bWVudHMvb2Nw
LWRjLXNjbS0yLTAtbHRwaS12ZXItMS0wLXBkZg0KPiA+DQo+ID4gVGhpcyBpbml0aWFsIGltcGxl
bWVudGF0aW9uIGluY2x1ZGVzOg0KPiA+DQo+ID4gKiBEZWZpbml0aW9uIG9mIGFzcGVlZC5hc3Qx
NzAwIGFzIGEgU3lzQnVzRGV2aWNlDQo+ID4NCj4gPiAqIFNldHVwIG9mIGEgYmFzaWMgbWVtb3J5
IHJlZ2lvbiB0byByZXNlcnZlIEkvTyBzcGFjZSBmb3IgZnV0dXJlDQo+ID4gICAgcGVyaXBoZXJh
bCBtb2RlbGluZw0KPiA+DQo+ID4gVGhpcyBzdHViIGVzdGFibGlzaGVzIHRoZSBmb3VuZGF0aW9u
IGZvciBMVFBJLXJlbGF0ZWQgZGV2aWNlDQo+ID4gZW11bGF0aW9uLCB3aXRob3V0IGltcGxlbWVu
dGluZyBhbnkgZnVuY3Rpb25hbCBwZXJpcGhlcmFscyBhdCB0aGlzIHN0YWdlLg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogS2FuZS1DaGVuLUFTIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+DQo+
ID4gLS0tDQo+ID4gICBpbmNsdWRlL2h3L2FybS9hc3BlZWRfYXN0MTcwMC5oIHwgMjMgKysrKysr
KysrKysrKysrKw0KPiA+ICAgaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmMgICAgICAgICB8IDQ4DQo+
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgaHcvYXJtL21lc29uLmJ1
aWxkICAgICAgICAgICAgICB8ICAxICsNCj4gPiAgIDMgZmlsZXMgY2hhbmdlZCwgNzIgaW5zZXJ0
aW9ucygrKQ0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvYXJtL2FzcGVlZF9h
c3QxNzAwLmgNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9hcm0vYXNwZWVkX2FzdDE3MDAu
Yw0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmgN
Cj4gPiBiL2luY2x1ZGUvaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmggbmV3IGZpbGUgbW9kZSAxMDA2
NDQgaW5kZXgNCj4gPiAwMDAwMDAwMDAwLi4yYTk1ZWJmZTg5DQo+ID4gLS0tIC9kZXYvbnVsbA0K
PiA+ICsrKyBiL2luY2x1ZGUvaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmgNCj4gPiBAQCAtMCwwICsx
LDIzIEBADQo+ID4gKy8qDQo+ID4gKyAqIEFTUEVFRCBBU1QxNzAwIElPIEV4cGFuZGVyDQo+ID4g
KyAqDQo+ID4gKyAqIENvcHlyaWdodCAoQykgMjAyNSBBU1BFRUQgVGVjaG5vbG9neSBJbmMuDQo+
ID4gKyAqDQo+ID4gKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVy
ICAqLyAjaWZuZGVmDQo+ID4gK0FTUEVFRF9BU1QxNzAwX0ggI2RlZmluZSBBU1BFRURfQVNUMTcw
MF9IDQo+ID4gKw0KPiA+ICsjaW5jbHVkZSAiaHcvc3lzYnVzLmgiDQo+ID4gKw0KPiA+ICsjZGVm
aW5lIFRZUEVfQVNQRUVEX0FTVDE3MDAgImFzcGVlZC5hc3QxNzAwIg0KPiA+ICsNCj4gPiArT0JK
RUNUX0RFQ0xBUkVfU0lNUExFX1RZUEUoQXNwZWVkQVNUMTcwMFNvQ1N0YXRlLA0KPiBBU1BFRURf
QVNUMTcwMCkNCj4gPiArDQo+ID4gK3N0cnVjdCBBc3BlZWRBU1QxNzAwU29DU3RhdGUgew0KPiA+
ICsgICAgU3lzQnVzRGV2aWNlIHBhcmVudF9vYmo7DQo+ID4gKw0KPiA+ICsgICAgTWVtb3J5UmVn
aW9uIGlvbWVtOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArI2VuZGlmIC8qIEFTUEVFRF9BU1QxNzAw
X0ggKi8NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmMgYi9ody9hcm0v
YXNwZWVkX2FzdDE3MDAuYyBuZXcNCj4gPiBmaWxlIG1vZGUgMTAwNjQ0IGluZGV4IDAwMDAwMDAw
MDAuLmY1NjRiOWIyNDINCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvaHcvYXJtL2FzcGVl
ZF9hc3QxNzAwLmMNCj4gPiBAQCAtMCwwICsxLDQ4IEBADQo+ID4gKy8qDQo+ID4gKyAqIEFTUEVF
RCBBU1QxNzAwIElPIEV4cGFuZGVyDQo+ID4gKyAqDQo+ID4gKyAqIENvcHlyaWdodCAoQykgMjAy
NSBBU1BFRUQgVGVjaG5vbG9neSBJbmMuDQo+ID4gKyAqDQo+ID4gKyAqIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyICAqLw0KPiA+ICsNCj4gPiArI2luY2x1ZGUgInFl
bXUvb3NkZXAuaCINCj4gPiArI2luY2x1ZGUgImh3L2JvYXJkcy5oIg0KPiA+ICsjaW5jbHVkZSAi
aHcvcWRldi1jb3JlLmgiDQo+ID4gKyNpbmNsdWRlICJxb20vb2JqZWN0LmgiDQo+ID4gKyNpbmNs
dWRlICJody9hcm0vYXNwZWVkX2FzdDE3MDAuaCINCj4gPiArDQo+ID4gKyNkZWZpbmUgQVNUMjcw
MF9TT0NfTFRQSV9TSVpFICAgICAgICAweDAxMDAwMDAwDQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9p
ZCBhc3BlZWRfYXN0MTcwMF9yZWFsaXplKERldmljZVN0YXRlICpkZXYsIEVycm9yICoqZXJycCkg
ew0KPiA+ICsgICAgQXNwZWVkQVNUMTcwMFNvQ1N0YXRlICpzID0gQVNQRUVEX0FTVDE3MDAoZGV2
KTsNCj4gPiArICAgIFN5c0J1c0RldmljZSAqc2JkID0gU1lTX0JVU19ERVZJQ0UoZGV2KTsNCj4g
PiArDQo+ID4gKyAgICAvKiBPY2N1cHkgbWVtb3J5IHNwYWNlIGZvciBhbGwgY29udHJvbGxlcnMg
aW4gQVNUMTcwMCAqLw0KPiA+ICsgICAgbWVtb3J5X3JlZ2lvbl9pbml0KCZzLT5pb21lbSwgT0JK
RUNUKHMpLCBUWVBFX0FTUEVFRF9BU1QxNzAwLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
IEFTVDI3MDBfU09DX0xUUElfU0laRSk7DQo+ID4gKyAgICBzeXNidXNfaW5pdF9tbWlvKHNiZCwg
JnMtPmlvbWVtKTsgfQ0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgYXNwZWVkX2FzdDE3MDBfY2xh
c3NfaW5pdChPYmplY3RDbGFzcyAqa2xhc3MsIGNvbnN0IHZvaWQNCj4gPiArKmRhdGEpIHsNCj4g
PiArICAgIERldmljZUNsYXNzICpkYyA9IERFVklDRV9DTEFTUyhrbGFzcyk7DQo+ID4gKw0KPiA+
ICsgICAgZGMtPnJlYWxpemUgPSBhc3BlZWRfYXN0MTcwMF9yZWFsaXplOyB9DQo+ID4gKw0KPiA+
ICtzdGF0aWMgY29uc3QgVHlwZUluZm8gYXNwZWVkX2FzdDE3MDBfaW5mbyA9IHsNCj4gPiArICAg
IC5uYW1lICAgICAgICAgID0gVFlQRV9BU1BFRURfQVNUMTcwMCwNCj4gPiArICAgIC5wYXJlbnQg
ICAgICAgID0gVFlQRV9TWVNfQlVTX0RFVklDRSwNCj4gPiArICAgIC5pbnN0YW5jZV9zaXplID0g
c2l6ZW9mKEFzcGVlZEFTVDE3MDBTb0NTdGF0ZSksDQo+ID4gKyAgICAuY2xhc3NfaW5pdCAgICA9
IGFzcGVlZF9hc3QxNzAwX2NsYXNzX2luaXQsDQo+ID4gKyAgICAuYWJzdHJhY3QgICAgICA9IGZh
bHNlLA0KPiANCj4gWW91IGNhbiBkcm9wIHRoZSAuYWJzdHJhY3QgYXNzaWdubWVudC4NCj4gDQo+
IA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgYXNwZWVkX2FzdDE3MDBfcmVnaXN0
ZXJfdHlwZXModm9pZCkNCj4gPiArew0KPiA+ICsgICAgdHlwZV9yZWdpc3Rlcl9zdGF0aWMoJmFz
cGVlZF9hc3QxNzAwX2luZm8pOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICt0eXBlX2luaXQoYXNwZWVk
X2FzdDE3MDBfcmVnaXN0ZXJfdHlwZXMpOw0KPiA+IGRpZmYgLS1naXQgYS9ody9hcm0vbWVzb24u
YnVpbGQgYi9ody9hcm0vbWVzb24uYnVpbGQgaW5kZXgNCj4gPiBhZWFmNjU0NzkwLi5lZTI2YTA1
ZGM5IDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FybS9tZXNvbi5idWlsZA0KPiA+ICsrKyBiL2h3L2Fy
bS9tZXNvbi5idWlsZA0KPiA+IEBAIC00Miw2ICs0Miw3IEBAIGFybV9jb21tb25fc3MuYWRkKHdo
ZW46ICdDT05GSUdfRlNMX0lNWDMxJywNCj4gaWZfdHJ1ZTogZmlsZXMoJ2ZzbC1pbXgzMS5jJywg
J2t6bS5jDQo+ID4gICBhcm1fY29tbW9uX3NzLmFkZCh3aGVuOiAnQ09ORklHX0ZTTF9JTVg2Jywg
aWZfdHJ1ZToNCj4gZmlsZXMoJ2ZzbC1pbXg2LmMnKSkNCj4gPiAgIGFybV9zcy5hZGQod2hlbjog
J0NPTkZJR19BU1BFRURfU09DJywgaWZfdHJ1ZTogZmlsZXMoDQo+ID4gICAgICdhc3BlZWQuYycs
DQo+ID4gKyAgJ2FzcGVlZF9hc3QxNzAwLmMnLA0KPiANCj4gVGhpcyBzaG91bGQgYmUgdW5kZXIg
VEFSR0VUX0FBUkNINjQgPyByaWdodCA/DQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KDQpIaSBD
w6lkcmljLA0KDQpZZXMsIFRBUkdFVF9BQVJDSDY0IHNob3VsZCBiZSB0aGUgY29ycmVjdCBvbmUg
Zm9yIGN1cnJlbnQgdXNhZ2UuDQpJIHdpbGwgcmVtb3ZlIHRoZSAuYWJzdHJhY3QgYXNzaWdubWVu
dCBpbiB0aGUgbmV4dCBwYXRjaC4gVGhhbmsgeW91Lg0KDQpCZXN0IFJlZ2FyZHMsDQpLYW5lDQo+
IA0KPiA+ICAgICAnYXNwZWVkX3NvY19jb21tb24uYycsDQo+ID4gICAgICdhc3BlZWRfYXN0MjQw
MC5jJywNCj4gPiAgICAgJ2FzcGVlZF9hc3QyNDAwX3BhbG1ldHRvLmMnLA0KDQo=

