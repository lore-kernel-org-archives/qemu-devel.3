Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59927C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 07:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u77kK-0008P1-7h; Tue, 22 Apr 2025 03:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u77kD-0008Le-1t; Tue, 22 Apr 2025 03:08:38 -0400
Received: from mail-koreacentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::7] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u77k5-00028n-K4; Tue, 22 Apr 2025 03:08:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kX5nulmUNHAh+xFVNuo+mf54TKO6ztuNgkgkufsxJc3U8AEpC8r8v8+YqvyfMLmq9dnpaSooUxi776/HEnUl4I+WojDex3NCzMlonRz4EV9TL8w6oieE7ORUlrL6DRx2tJ9tVHOQ2hGZ9hH17YbjE6aYleYhqCI/3GloNUlmBPIKKEE2Kj9L3aOFvdBP3AgTV3CmpkR0F82Ol8MzisF4WVz2Ry6b8QnpSphSCMIzeXPMkqVeud8yOCmmVUJy3M7x5v3G5TVE4fQav5uWKM5Psah4RFWXZBrAYRhPZH6bxbezfQm+XYUTUjE+sKJDZhYxHyWPEaJrJlWl92P2GPOdgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buTaTXQPEUJ2ehKSsDWVAFG19hL1DIVHrvncK8xjWpY=;
 b=txXN49b7/rpFDycDo3ByoJla5T0T+2gxgnyvVOzVAJFYTV8nd+o+WeTdkR54E5TrzIkboIMeVADDIjElBJBu84oMmVRbCaXYoNsGWbnN7Gz2SwRFdyEeVpwTC9mUn+UOdvDrDQP9JAZwS4wFAfC+1z7RSSQYiyrfESn9saOI3vSdhIvPhVc7vatLIGLXZc3FMOWuYnGf9yce4wL4sXCrT56jxSDRAqa7YAaJT9jKwjtAnBHzrCge+2jPxVdsCSqofAEsBYiFxY0PDIqQijBIPWxYLVZgvw9Nso3zFnxFL1IzJ/UlOEWSxGzB4teuSFW7BF4WONe2/JuO5mljmIMGmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buTaTXQPEUJ2ehKSsDWVAFG19hL1DIVHrvncK8xjWpY=;
 b=ExpJ5RVbH4PlQEw/hXrmHRhi4JbAnb1oBX/UF1I1Dy0IPEzPMzLbcPNf6/KsRrAHo+AhPE2tnoLcJ4i7CFECy5u5QEN2liWblbCxin7TlUifkSKBCjnbI8docgoGyeqOOSnU7IYzX4q9kZPx43eE0aj6fU0LHz8zqa6bTPgvQ5qFJbLNfDlyhOtERArwUtS1DkeqAM0CeP+xRfR6yZwa2sjQ9qogJLs4ReK/WnhCd9dFwSC8ApPz/ew7wtetxvUS7Irs8spZMAZZ8xWjx9lL/WfsPe1Czjodq+u23xBwwMFeqXdq7ITSqMu2r83rwXMp09RGj+D8ziuFd/hxDMfV4Q==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEYPR06MB5014.apcprd06.prod.outlook.com (2603:1096:101:3f::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.22; Tue, 22 Apr 2025 07:08:13 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 07:08:12 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: RE: [PATCH v4 08/10] tests/functional/aspeed: Update test ASPEED SDK
 v09.06
Thread-Topic: [PATCH v4 08/10] tests/functional/aspeed: Update test ASPEED SDK
 v09.06
Thread-Index: AQHbr0a0nxnso2DzIkKD+f7yUASy47OvS2wAgAAAZPA=
Date: Tue, 22 Apr 2025 07:08:12 +0000
Message-ID: <SI2PR06MB504162FB755119E2BA33CBB9FCBB2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250417031209.2647703-1-jamin_lin@aspeedtech.com>
 <20250417031209.2647703-9-jamin_lin@aspeedtech.com>
 <865d9c82-f98a-4bab-88c0-42b7370d06a9@kaod.org>
In-Reply-To: <865d9c82-f98a-4bab-88c0-42b7370d06a9@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEYPR06MB5014:EE_
x-ms-office365-filtering-correlation-id: 6a8380aa-0c77-4df7-a53c-08dd816c7202
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?bVVDSkVzSzB2WkIvTXdiWUpiazVrd3hwL2M0UkdHWTV4VWFYbzNqUDFtaURU?=
 =?utf-8?B?K281TlJQUTdGdmRwZVNtUXI1VEFSV0RyaTM3TS81RWRSSVdvTWpLNE5CU3JO?=
 =?utf-8?B?VzYrc3loT2VCUnRtUElDakNEOTBhUWMxcGxyTm84YkRZOFp5UGIzbkl1b0ZT?=
 =?utf-8?B?WVJlazdhWGxZRU9HWTV1NXVXZDdYTzNEOS9UR2diRXdpR2RpakNLTCt1M1RT?=
 =?utf-8?B?YzN6ZS90ck1kdEp0dW9zekIzWFE3VGV6d2VZeG5uYnhkNmZIMFd2Vk14S3dC?=
 =?utf-8?B?cjJGcUw1a0ZURmNCZ0Z1MUg5NE9oRkJhSTlhWllGell0cy9la2k2ZkdoaGpv?=
 =?utf-8?B?ZDJmeHMzeFJTdDVscHN1dmUyTjBHaHRQaGl2M2hKYUI0RGNTTDNTYjdwU3p4?=
 =?utf-8?B?Y0xmSXAzZTZhR0FTQzU1MzJ3aURKQWw0ZkpQSDFQUUFIcE9hcUlRSkM0SE9r?=
 =?utf-8?B?aEJaTXFQdkJscmtudnNFT0VnVFgvS2swUGhXU084QnNIbnFUc2liQ0l0Nisv?=
 =?utf-8?B?TjlTQ1RKcTVISUh3b3RROW1rb0IwTnJvRkJrUEEranlabTZMNk4yRFBmazlH?=
 =?utf-8?B?WDZkQ2VmaG54bm5SY0VSbitlWWhOY0wybXVoQ1E0c2ttY2lManRXMU1OZVhT?=
 =?utf-8?B?aHFSQzhqQmt5QS9IaTFCeFAyM1gzR1NKWWRGNnlNaXI1cnRiMmNNTW5PN1BK?=
 =?utf-8?B?Q20yK3JDNjcrenJwQVRlcXdDcXVBUHRTbGtkOTh2bXhoZ3NQNldCaElvUDc5?=
 =?utf-8?B?WktiL0tVdzFFUytCdlZ6OTBNZjg3V2Z1MmtJRkR5Y0JOUWZ5S1EydmpuMGE2?=
 =?utf-8?B?dUNPVXlJM0lvWmdkMVpXWXlhSy82TEVZODZLWlN3YmdORGVMVUtmU2ppQUpy?=
 =?utf-8?B?T0VXR05HMWl0cnR1SlJEZUhBNTY2L2Nsd1dYMlFkQWl3a1p4VDN2NHZ3ZUlB?=
 =?utf-8?B?M2RWNmNZQW12OGVpd2pGNi95aVJuaDFtclFDbG50b2ltWS9FNEJhcm0yK1NM?=
 =?utf-8?B?aVFrNExlVnh0cFovZ00yYi9ldjFKQ2JTS2dMWjN2MHUxVnh2VjhRY0JPVnJs?=
 =?utf-8?B?S2FBVWNHUHo5anNsQzJXdnQ0UWlTdHVjSjFCUnNIUy9LQ3poMTRGSTZpM0Vq?=
 =?utf-8?B?ODhIdDhYMzZCR1FZalFWUkxJS1BCcVl6T00xYkxBNVRTbldyZGJVVXdXcTl5?=
 =?utf-8?B?elpVSGg1b3F4MlhjODVNTzFKQXZURFZmME11b1lrYmtvZFEzYmRYZHRFdFZ2?=
 =?utf-8?B?L1ZGZk5ub0R0ZEFtamUvUlpnOTk3TC9aVGRCcjVjcGNnY3J4ZWRTQ2pJOW5n?=
 =?utf-8?B?a3BZR0l5RUtRZW9mbWlyMFlmNEZoSFRwQ21IZEFBanR5Q2pLRzUrYjlQNUtM?=
 =?utf-8?B?MGJXTjZDMFF1UFBad3ZjbXRKenYvaTZJVVlTVWxkbjZxWkM3cFlJQjJ5aGgz?=
 =?utf-8?B?ZGRoZ1hTU0IxQnkyOEZzWlRIN3N2N0RxMnkwZXZzU0dYNVBTeHR3VjhPaEVB?=
 =?utf-8?B?Q00yQnprcGZTWGhhYWdyT1ZPN3l0dzBsd29mQ2E5Y3N2ZXdBajVUN0hTOGpX?=
 =?utf-8?B?dmdZSk1JcERtd1d4aW82aHEvU0tmNU9MQktqOUVVMjVoQ05xSW1BekVPUlZU?=
 =?utf-8?B?dmlXZ0t0dVJBSW1XbEUxTHJMSnZ5a2hOV0Zxc0FydkVWem5pdER4SUNObzJS?=
 =?utf-8?B?ZUc1T0ZuV3J1UTZEeGRicEg5cTh6T1Q3SFZFa0gvYTdsWjl5T29meFBMQ1Ra?=
 =?utf-8?B?M0NSaHY5d05xOWJHd0Yrck9XVk45UmFPa3RzSUw0dHZZNE81OHp0bTB2TlB2?=
 =?utf-8?B?RStKdStRMDE2OTdpTUNCUGozNldmUWVJSDJGajV1OVYrMjY3Und3eUZNVFNa?=
 =?utf-8?B?L0VFNDNNR2svVUFiNVZRMzFjN1BRbm1oZGdzWUdtWG5YT3dCZDNNQkhNMGJY?=
 =?utf-8?B?NjBYdEFjMFZwKzU4OEpNbXVzVHZLZG9YN2NwVTRnZHN0QnE2NWNtcWJ1VXNm?=
 =?utf-8?Q?TovLPJ0nynoVtxuSHzRDSwQS22L2dI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mk9yZXpDWmdtUGdzTTVieWxDUmpJam04TSthTWQ4T21HSWdBLzB2L2pSeE9S?=
 =?utf-8?B?VFZHQnQrdEJ6ZlFrMTIxOWlpTGFLaEZvLzVncEtvM0NwU3hFbnpJU2NCaDY1?=
 =?utf-8?B?aURySjhuRFhXWDdWNkRuMU1IZERkWTh6RHBJUFV4QjUvTk9NMk9lWDhyNzlP?=
 =?utf-8?B?YklpVVNpaUZ4SCs4UlI2N2NGZWdWOExMYUdWRkVNUmE0K1RXdDY4Q0FSRlhD?=
 =?utf-8?B?YnViL1BiRG5DSHNQVmZTMFZBZE1TZlFFNnJGdldkNFFjMmdZS0hvOFZDUzJM?=
 =?utf-8?B?VzNGYkwwekVNR285YlFLMXVqRWNSS292VlN3eE9DOGFYZEtZTFZFVzNWamV2?=
 =?utf-8?B?d1l6dU5ld0dybzlQd1N6YnRSdyt6OVgzenVUYkkxRmU5ZGIrM0ljL1FEMlpH?=
 =?utf-8?B?b2wyQy9abGlrMnRFWkJvUmZSYTF0T2I4VkRVMW9YZVlwa1pXOTRKRWp3Rkli?=
 =?utf-8?B?aFB0VDJ4QnlKZ2Y3MGJWTWRtKzdjaDVQNnQzM3JmdkxnOEN3VmVqQ0NFTVIy?=
 =?utf-8?B?ZkNCNllSZFN3YWJDRFRrVW4zK0VLZkY3ZHEyTzgzRHJpWU51V3ZhQ0xFUFlP?=
 =?utf-8?B?ZG5sOG5nb3ZVVjZTaDZ0NStwR1JVc0cyYkM0SDJFdkJ1RjFqYXdwY3BHU25r?=
 =?utf-8?B?eGlJVUxIcFdKTzJjMFFSZ3FsMWZ6TWhDanFmTFpMK2lvdmNpa0NUazVwM3ly?=
 =?utf-8?B?R1VsQnhaZVl6d0pvMkFPM2VsM1ZCM0QyZk1rRTJRVU1vT0dtUStJTGhiSXRm?=
 =?utf-8?B?KytndUtQSnRra29selpLTmR0VHpDS1BULytRNkpXeHNVMk9WMk5IMGxSdERV?=
 =?utf-8?B?bXFSejIyNGkxL1hkbjFuZ05ZS0dKeEVsZDJqakI4R2w3UUZYeVdhSXpTMmZZ?=
 =?utf-8?B?TUp2RlVvbTBiZXh3L1Q2S3VhZzh0cGkzQkpiRzNHeXJhT0pRcngrQjRkYldL?=
 =?utf-8?B?R1RHdW04SXF6NXdXOGxhbDByNWRxVXNZQTdkUStvVU1wdlZXZUhoMjNLWng3?=
 =?utf-8?B?R1NDZ0hRVGEwa3Ezbkt5NjM2dnZHY2NDemJIb2JQVkprWlZmMUdSSzErNnMy?=
 =?utf-8?B?aGRLNmdVZWdRY1lrSDdKWTVjdnZoMFp1Ymg0S29QQTE2TDZJTGhRNlhrZmZu?=
 =?utf-8?B?STd0RDd0WXFuQ3RRTzhtdXN0dDZsSWZTVUw5a2NoNkI5anJTSEhxTVVuVUZo?=
 =?utf-8?B?MjBicXNNYVFQTEZleE8vMnh1YVBqR0l1Zi9hZXlWbEhPUmhocW93WVBHRk9X?=
 =?utf-8?B?Z1ZWVk5rYzk0ZnUyb1RkNytSTU8rOEs4bFpNeTNTcnBDWTZhYTg4NVRMUnlU?=
 =?utf-8?B?cDFhRklYRTgvb2dnRWt0cldxRHlCNzBxWXpObDBUdEh5M2pENFlYWGZpNEk1?=
 =?utf-8?B?eFF2bXZPbUpudGNaQko0NGZkRlI5WjBCeEg2YmVCejR1LzR5d29QbnRHRVpR?=
 =?utf-8?B?eit1Mk1XREl6QWY0cjViTXpHNE1TRzUybHB3cXhCWkJtTS8xdDhSN3F4Vkk0?=
 =?utf-8?B?WFlLcDdkV2NqMVNTMnJ5YWxSTHl0K2RMNWZFc1hBTjNnWko1L1FXUTRFbmVm?=
 =?utf-8?B?NGhPdkJiVW42R0Exb0ZLeDczdm51b0xLUGxUZUNxZW9PMDJLNmd2TDRuREk1?=
 =?utf-8?B?bHYzcTZMcmxMR1hkWUN3YU9JUTZHSlBobzlneC9QRk9pNUdxMlVycXhQOEMr?=
 =?utf-8?B?WTVRT0pBbUNWVWVoQWxmOU8yU2tXZWF4c29PckJhZWsvUGU1Z2NiOHJpeGt0?=
 =?utf-8?B?TlBmemdIY2lMUERyL2tlclFYRFZlSEZrY2ZqMDU4TXF0UVlPTnFPb1RBeGlP?=
 =?utf-8?B?SktOK2hQV08vM0l0dHR3aGxnd1pjUEtsSHhBRFk3S1QrRU9qL2ozTVdDbkpI?=
 =?utf-8?B?NEpEcFRSVUs0VU1JdzRhRjgyUWNLM1crRDhvdmpZTjlRRUc5WERJWFRob3hx?=
 =?utf-8?B?bnhQNTNtcnNJMm1XbGFWS0xNaml6bFlpMXlEQk82T2kwdWR6bUpUMmNRWUdt?=
 =?utf-8?B?bXZyNGlnUnRRbU1QKzY4RGdLTlBhU1E3azZEYkhGVXlSUnluYVRvVDJSZUdy?=
 =?utf-8?B?Z0ZDSzFSOGc3WnNaK3hSbzNqaG9sMXRNTGJQMG5HL0FnM3l5aE82UWpkaVk4?=
 =?utf-8?Q?XEIeIigjpKBSarPN/55DC84/z?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8380aa-0c77-4df7-a53c-08dd816c7202
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 07:08:12.5081 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KnTQE/tkBgRiupzXvOHetxHsiNFo8wRE51w0Hj91Dlz7dzxxVlUDRBw6+V5DxCp4aynshZZNeheO+XHuOFegHwPxfUlwCkTNSIeXfcFby/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5014
Received-SPF: pass client-ip=2a01:111:f403:c40f::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

SGkgQ2VkcmljLA0KDQo+IENjOiBUcm95IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+OyBu
YWJpaGVzdGVmYW5AZ29vZ2xlLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDA4LzEwXSB0
ZXN0cy9mdW5jdGlvbmFsL2FzcGVlZDogVXBkYXRlIHRlc3QgQVNQRUVEDQo+IFNESyB2MDkuMDYN
Cj4gDQo+IEphbWluLA0KPiANCj4gT24gNC8xNy8yNSAwNToxMiwgSmFtaW4gTGluIHdyb3RlOg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0K
PiA+IC0tLQ0KPiA+ICAgdGVzdHMvZnVuY3Rpb25hbC90ZXN0X2FhcmNoNjRfYXNwZWVkLnB5IHwg
MjAgKysrKysrKysrKy0tLS0tLS0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRp
b25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS90ZXN0cy9mdW5j
dGlvbmFsL3Rlc3RfYWFyY2g2NF9hc3BlZWQucHkNCj4gPiBiL3Rlc3RzL2Z1bmN0aW9uYWwvdGVz
dF9hYXJjaDY0X2FzcGVlZC5weQ0KPiA+IGluZGV4IDQ0MWY3ZjM5MTkuLjMzN2Q3MDE5MTcgMTAw
NzU1DQo+ID4gLS0tIGEvdGVzdHMvZnVuY3Rpb25hbC90ZXN0X2FhcmNoNjRfYXNwZWVkLnB5DQo+
ID4gKysrIGIvdGVzdHMvZnVuY3Rpb25hbC90ZXN0X2FhcmNoNjRfYXNwZWVkLnB5DQo+ID4gQEAg
LTI5LDEzICsyOSwxMyBAQCBkZWYgZG9fdGVzdF9hYXJjaDY0X2FzcGVlZF9zZGtfc3RhcnQoc2Vs
ZiwgaW1hZ2UpOg0KPiA+ICAgICAgICAgICB3YWl0X2Zvcl9jb25zb2xlX3BhdHRlcm4oc2VsZiwg
JyMjIExvYWRpbmcga2VybmVsIGZyb20gRklUDQo+IEltYWdlJykNCj4gPiAgICAgICAgICAgd2Fp
dF9mb3JfY29uc29sZV9wYXR0ZXJuKHNlbGYsICdTdGFydGluZyBrZXJuZWwgLi4uJykNCj4gPg0K
PiA+IC0gICAgQVNTRVRfU0RLX1Y5MDVfQVNUMjcwMCA9IEFzc2V0KA0KPiA+IC0NCj4gJ2h0dHBz
Oi8vZ2l0aHViLmNvbS9Bc3BlZWRUZWNoLUJNQy9vcGVuYm1jL3JlbGVhc2VzL2Rvd25sb2FkL3Yw
OS4wNS9hc3QNCj4gMjcwMC1hMC1kZWZhdWx0LW9ibWMudGFyLmd6JywNCj4gPiAtDQo+ICdjZmJi
ZDFjY2U3MmYyYTNiNzNiOTA4MGM0MWVlY2RhZGViYjcwNzdmYmE0Zjc4MDZkNzJhYzk5ZjNlODRi
NzRhJykNCj4gPiArICAgIEFTU0VUX1NES19WOTA2X0FTVDI3MDAgPSBBc3NldCgNCj4gPiArDQo+
ICdodHRwczovL2dpdGh1Yi5jb20vQXNwZWVkVGVjaC1CTUMvb3BlbmJtYy9yZWxlYXNlcy9kb3du
bG9hZC92MDkuMDYvYXN0DQo+IDI3MDAtYTAtZGVmYXVsdC1vYm1jLnRhci5neicsDQo+ID4gKw0K
PiA+ICsNCj4gJzcyNDdiNmYxOWRiZmI3MDA2ODZmOGQ5ZjcyM2FjMjNmM2ViMjI5MjI2YzA1ODlj
YjliMDZiODBkMWI2MWYzY2InKQ0KPiA+DQo+ID4gLSAgICBBU1NFVF9TREtfVjkwNV9BU1QyNzAw
QTEgPSBBc3NldCgNCj4gPiAtDQo+ICdodHRwczovL2dpdGh1Yi5jb20vQXNwZWVkVGVjaC1CTUMv
b3BlbmJtYy9yZWxlYXNlcy9kb3dubG9hZC92MDkuMDUvYXN0DQo+IDI3MDAtZGVmYXVsdC1vYm1j
LnRhci5neicsDQo+ID4gLQ0KPiAnYzFmNDQ5NmFlYzA2NzQzYzgxMmE2ZTlhMWExOGQwMzJmMzRk
NjJmM2RkYjY5NTZlOTI0ZmVmNjJhYTIwNDZhNScpDQo+ID4gKyAgICBBU1NFVF9TREtfVjkwNl9B
U1QyNzAwQTEgPSBBc3NldCgNCj4gPiArDQo+ICdodHRwczovL2dpdGh1Yi5jb20vQXNwZWVkVGVj
aC1CTUMvb3BlbmJtYy9yZWxlYXNlcy9kb3dubG9hZC92MDkuMDYvYXN0DQo+IDI3MDAtZGVmYXVs
dC1vYm1jLnRhci5neicsDQo+ID4gKw0KPiA+ICsNCj4gJ2YxZDUzZTBiZThhNDA0ZWNjZTNlMTA1
ZjcyYmM1MGZhNGUwOTBhZDEzMTYwZmZhOTFiMTBhNmUwMjMzYTlkYzYnKQ0KPiA+DQo+ID4gICAg
ICAgZGVmIGRvX2FzdDI3MDBfaTJjX3Rlc3Qoc2VsZik6DQo+ID4gICAgICAgICAgIGV4ZWNfY29t
bWFuZF9hbmRfd2FpdF9mb3JfcGF0dGVybihzZWxmLA0KPiA+IEBAIC05NCwxNyArOTQsMTcgQEAg
ZGVmIHN0YXJ0X2FzdDI3MDBfdGVzdChzZWxmLCBuYW1lKToNCj4gPiAgICAgICAgICAgZXhlY19j
b21tYW5kX2FuZF93YWl0X2Zvcl9wYXR0ZXJuKHNlbGYsICdyb290JywgJ1Bhc3N3b3JkOicpDQo+
ID4gICAgICAgICAgIGV4ZWNfY29tbWFuZF9hbmRfd2FpdF9mb3JfcGF0dGVybihzZWxmLCAnMHBl
bkJtYycsDQo+ID4gZidyb290QHtuYW1lfTp+IycpDQo+ID4NCj4gPiAtICAgIGRlZiB0ZXN0X2Fh
cmNoNjRfYXN0MjcwMF9ldmJfc2RrX3YwOV8wNShzZWxmKToNCj4gPiArICAgIGRlZiB0ZXN0X2Fh
cmNoNjRfYXN0MjcwMF9ldmJfc2RrX3YwOV8wNihzZWxmKToNCj4gPiAgICAgICAgICAgc2VsZi5z
ZXRfbWFjaGluZSgnYXN0MjcwMC1ldmInKQ0KPiA+DQo+ID4gLSAgICAgICAgc2VsZi5hcmNoaXZl
X2V4dHJhY3Qoc2VsZi5BU1NFVF9TREtfVjkwNV9BU1QyNzAwKQ0KPiA+ICsgICAgICAgIHNlbGYu
YXJjaGl2ZV9leHRyYWN0KHNlbGYuQVNTRVRfU0RLX1Y5MDZfQVNUMjcwMCkNCj4gPiAgICAgICAg
ICAgc2VsZi5zdGFydF9hc3QyNzAwX3Rlc3QoJ2FzdDI3MDAtYTAtZGVmYXVsdCcpDQo+ID4gICAg
ICAgICAgIHNlbGYuZG9fYXN0MjcwMF9pMmNfdGVzdCgpDQo+ID4NCj4gPiAtICAgIGRlZiB0ZXN0
X2FhcmNoNjRfYXN0MjcwMGExX2V2Yl9zZGtfdjA5XzA1KHNlbGYpOg0KPiA+ICsgICAgZGVmIHRl
c3RfYWFyY2g2NF9hc3QyNzAwYTFfZXZiX3Nka192MDlfMDYoc2VsZik6DQo+ID4gICAgICAgICAg
IHNlbGYuc2V0X21hY2hpbmUoJ2FzdDI3MDBhMS1ldmInKQ0KPiA+DQo+ID4gLSAgICAgICAgc2Vs
Zi5hcmNoaXZlX2V4dHJhY3Qoc2VsZi5BU1NFVF9TREtfVjkwNV9BU1QyNzAwQTEpDQo+ID4gKyAg
ICAgICAgc2VsZi5hcmNoaXZlX2V4dHJhY3Qoc2VsZi5BU1NFVF9TREtfVjkwNl9BU1QyNzAwQTEp
DQo+ID4gICAgICAgICAgIHNlbGYuc3RhcnRfYXN0MjcwMF90ZXN0KCdhc3QyNzAwLWRlZmF1bHQn
KQ0KPiA+ICAgICAgICAgICBzZWxmLmRvX2FzdDI3MDBfaTJjX3Rlc3QoKQ0KPiA+DQo+IA0KPiBX
aGlsZSBhdCBpdCwgY291bGQgeW91IHBsZWFzZSB1cGRhdGUgdGhlIFNESyB2ZXJzaW9uIGZvciB0
aGUgdGVzdHMgaW4gdGhlIG90aGVyDQo+IGFzcGVlZCBmaWxlcyB0b28gPw0KPiANCkdvdCBpdC4N
CldpbGwgdXBkYXRlIHRoZW0uDQpUaGFua3MtSmFtaW4NCg0KPiAgICB0ZXN0cy9mdW5jdGlvbmFs
L3Rlc3RfYWFyY2g2NF9hc3QyNzAwZmMucHkNCj4gICAgdGVzdHMvZnVuY3Rpb25hbC90ZXN0X2Fy
bV9hc3BlZWRfYXN0MjUwMC5weQ0KPiAgICB0ZXN0cy9mdW5jdGlvbmFsL3Rlc3RfYXJtX2FzcGVl
ZF9hc3QyNjAwLnB5DQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCg0K

