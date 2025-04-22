Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5017C369D5
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 01:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u72v0-0005KG-Bq; Mon, 21 Apr 2025 21:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u72uy-0005Jv-DP; Mon, 21 Apr 2025 21:59:24 -0400
Received: from mail-eastasiaazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c400::3] helo=HK3PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u72uv-00046u-CY; Mon, 21 Apr 2025 21:59:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6SGXHcj4qzuyowRNL/Ysya/yNy00Z9yGBDFVqVPRRaCw/RsjurjpaVkGGDI1pfRmbWUMK7SnqkoIlR4vZnmoPiFxw/e5J1BNvOSded8jnPv+W0emLVuFRvNE3MNUVnkuLAkKYlq4OzHW3yGW/9TOImZt+k5Q5qOQ41eXNJl554/0Xju5ocxgVkPR+Q5A3G45oSU2t6W4fKE2cpWwl6PB7PnJi7tK16fyk2kR/Ycr0TqI1bQsEdBQNvWmohQOJclpyq6CyRfneNBzilFR7g1zo6n8rSRbWhvU4Ee2JXHgLhrqRbQyZ3f6fqcr2/tikP1gNKpYZ22i42DftSJugp3Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqQ1XQ0Xf8AUMFFfVMxzUkoG4JNYq/qNlK3c8JXMW2k=;
 b=U2CCJpTpPHFuknabTYLJ9LC0L2lcXo+ngNPsKo1VyvEaKS8sZ4hjyBjBcyrX2zZQUDhaUkHqdQLJ45D5QIxN7GYQt+Fy11W6KP5ebVF0zY3Od6/nNrTvBUaC0URgXdOdWglQKCccsWlFViy/KgLJ1eEVEbUgOQOpLFoPhsx8VSVB5YRBG2GMtZ6k82YD9a8+2x07oxU6VA4+dAwZ4ploSttE09EgPxCnxWeBv0j7VfehC+5vmHmXV2DdW7oGIvjbMPPKfHpEjY+OVKgA0sML1xWRycCWH6XlD8tOcBZ3m8fbNhkXdXN4MdHofDK/Pcv15L7ovsVBK4DSF7qULZAUSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqQ1XQ0Xf8AUMFFfVMxzUkoG4JNYq/qNlK3c8JXMW2k=;
 b=qvMjVt0HOkH6By5l/m1E6TzmobJTwEWgj2ypCA5UWIwPKm76fJfik62rx58Frny9yAaMa6nT/H9RwlaNC+dtzP4SlyXI9s6mI5hJCeKa0YMkTLBiU7q9YeW2EfiC2zRyPjwFfJ0CmcktLUI4gXZB+ttq7eBKt6xBWjgnOPEyklk3ZqGXjunS5Swqk+1erxwOTDOvRDbTlgq14YrYEkhexJpziKN6SidnD/bmaG+PI57P2E4mFVMJuAT3fHKxl11BOLlLKJNth1jC6EpE3gnOs/Coys62u6+dJsXBEDe2vnCW8AQg4C3eFgW+lVcISkQ5hgStmEcug6HQ1H0es2MvfQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEYPR06MB5963.apcprd06.prod.outlook.com (2603:1096:101:d8::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.35; Tue, 22 Apr 2025 01:59:11 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 01:59:10 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: RE: [PATCH v4 02/10] hw/arm/aspeed_ast27x0 Introduce vbootrom memory
 region
Thread-Topic: [PATCH v4 02/10] hw/arm/aspeed_ast27x0 Introduce vbootrom memory
 region
Thread-Index: AQHbr0ao2YGz73xecE2tvN8MD/lK+7OuW4KAgACXysA=
Date: Tue, 22 Apr 2025 01:59:10 +0000
Message-ID: <SI2PR06MB50411BBCDE73A9D1ABDD5CD1FCBB2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250417031209.2647703-1-jamin_lin@aspeedtech.com>
 <20250417031209.2647703-3-jamin_lin@aspeedtech.com>
 <062830ef-b6ec-42ba-be68-547d4d569802@kaod.org>
In-Reply-To: <062830ef-b6ec-42ba-be68-547d4d569802@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEYPR06MB5963:EE_
x-ms-office365-filtering-correlation-id: 40a23972-34bf-4fdf-dbb2-08dd81414644
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TklEbzRidkUwa1pEZHQxYmw5Q1l3Qnc3NElPbUpPUmxqRHorM1hmS0lWeG5M?=
 =?utf-8?B?TzV2UmJpSjlxbnE2OXlUeS8rUTlYcnFEbUM0RlNOOUFKK09sMHJUTGJFenI4?=
 =?utf-8?B?RnYzcEF2aDZQU2VlT1orVEZSbkxVWHNWSEZSTmNyZmNrUmR5bE5vMlQrMjk1?=
 =?utf-8?B?YWFNSktvZ2dXSjBTL295YW5QVnlNTmYvVnJaY3JnUW1Pc3IwZ1lxMGtQaUxJ?=
 =?utf-8?B?dXZVVjBmZTFCTWVRZ1gvK1lteHZPNVlEcmhkRzlIalBITHZvQUd0U29FY1JU?=
 =?utf-8?B?NmhpZ2JSMTUwR3RpRFAvZXRGYXFsZjlTaVdWTDFHVTBTamVna2Z5TG96Y0Zv?=
 =?utf-8?B?YjVqNjhOZmVWT1dVMW5idTA4RGlIZDh5N2Q2WEZCQTZ5ZlVUMkg4Q2VZRHAr?=
 =?utf-8?B?OXpXWmFxOWh3akxPTCtEWGlWVmVCd2x2cmk4MHpCTTFYdTZmTGdXbzZ0a1Y1?=
 =?utf-8?B?ZUQ2TnFBQUJTMC84U0h3QlZwcXpJMkwrNm9VaXdtemJpQmxYRi9VeGliejVR?=
 =?utf-8?B?Vy9Sc1Ixb3hJQ1NZbllwdHczM0MrbHRhU01aMzIrSzFCMDFWUDFjZ2Z0Wm1z?=
 =?utf-8?B?YVBtSDF1TDdqWC8vMmxvYUJLcDF1ekd3dlhWNmFMYjJwcGxrUjNERTR0dmF5?=
 =?utf-8?B?TFk5YUNMUkVmNSsxRjIwdFJnYUkxMXpZdENTaGQxZ1JSZXlzQWcyQWhpNjA5?=
 =?utf-8?B?aGdJK2tNak8yRGNDcXNMaVlsNzBtL054VFB5Rm5YNWhJL0RyNy94MjNidXFX?=
 =?utf-8?B?cytHV1JzbmpIaGxIRkVmV29QVVJuVVIxR20wak1qTEJ2bzdtcjBwTlNpbnNB?=
 =?utf-8?B?eTdFbHUzczlZU2dqUkVxK1cyOXFjYStzR2RxekRIMXI4TlJONTk3OXlIOHp4?=
 =?utf-8?B?YXlYaWpNTmM0N2xEUDN4bjFsY3RLVEQ0L1N0aXdONWNYV3REMHVONWJ2VFhZ?=
 =?utf-8?B?ZE9HRTRjaCt3RzRhSjR5SU1iMUthZ0xuVDkxdkIyZmhHWjArK1lvRUwveWxF?=
 =?utf-8?B?K1o2N2V1MUZKWk01Y1pFdjVuRFhRYmFmNDZmVDdBNkFGRlBReHdRUVVWRVNT?=
 =?utf-8?B?ZjVuWW56QXV1S2s5K3FQSUdXNlIyM0N3TGZzbjU1ekw0R0lkb1VEaXdRZGN6?=
 =?utf-8?B?SmF1eEtSZWNWZWZDOW94VHNNemhtWVZ0UXdSZUhuWnZVa2Jzc3VXdmszbEFn?=
 =?utf-8?B?VnZpcXVaR2U2L2JqaTc1dmtJVFVxeHZSTjRvbkpMRUFzU25NVXpKdVJaTnhS?=
 =?utf-8?B?a0J4SlZ5WERjQVpmQTVIRUhFMnlZaVdPSURKVVRjUkh5MFJXclJsVS9jclk3?=
 =?utf-8?B?WGlRc3hYWEI1Q29NdDRaaW1CbG5JNWxPWE1wNXdOVnk3Nk4reFFBTHk0Rmo3?=
 =?utf-8?B?d0Rnc0ZJRG13aW5OWWJra1IrblJGQTN5eUc5U09rQ1ZCdm12ZjlHVXJCU3Jh?=
 =?utf-8?B?bTBUMlcrVDhYU2h1dEg2RmRaTlRBaGN6cmx0Sm1SL3hNa3Y5YjBkSm5UMmU4?=
 =?utf-8?B?K0xUWEE5cUMxUzM2ams1OGNqVmlzQkRKMFlDWXUwZ1R2d3R4ekU3b1QyeVlq?=
 =?utf-8?B?YzZ6KzYvRjJTczRxSXIxN0o3bWZoVXJlVndUODRvZWhRQTdOcG1FangzbFhj?=
 =?utf-8?B?UG9JaGVZNEZrL1UyNThwYkZVenJ6b1hwbkFBMk9JVUwzUVJKWGtjOEZJQU9I?=
 =?utf-8?B?SEdpTlRnYzFpSEdBcStXZEFRTjdJakV2M2FZR2FWUG15NmR2WGgvZ0lXc29E?=
 =?utf-8?B?NlZ3eDRFelZwcVBXYzNUc2c4OGJ6cmhKZW1lU2NVT1d0NTdiZHBxQ0F3R0Y0?=
 =?utf-8?B?NjZFSGM5Wk5Ka1FGbitqVkYyTHBkNU1JaTFndGhHQkF0TlhzMkR5MkJsWmRL?=
 =?utf-8?B?WC9ZZlhrd0srNmh0ZmFKSHMxdTk2dnZ6a2xrYVJZRnVjTzhVTUI3d0oxbmRM?=
 =?utf-8?B?UnF1aDNvUnhuSEZ2MkFSc3hSLzlhcGtOQ2d6Y1dRaE1nbTB5THE0TkY2a1hz?=
 =?utf-8?B?bFVhVXBZMVdnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2drcjB3Zm5DTTFTa2dkaWkwUFBSQUNRaDZoWXFLaVpMdEYvUENQSlRBUzFp?=
 =?utf-8?B?djV6alFHaWpqNmxoa0kwVTBNaG1Ra1NFaEp6ZCthUEpSc0svMm5lakJqT2NO?=
 =?utf-8?B?TVJpTS9GamUwK0tPMmtKTHVFeC91N0dMRk9LLzlRRnBlSEhYeU1hNE5FOHZT?=
 =?utf-8?B?dVFKQVY5ZUt1Y0FTaVd2cDRtbFlvYTN1b0ZCV1JtTWZmd213ekNIa1lhR0hh?=
 =?utf-8?B?TjlWSFVNSng4Q1RUdnp4Q0owdHFOdjYwQTVGTWxHbEEraW9QZmJTbzVsNWl3?=
 =?utf-8?B?WHgzRmJIMGd4SmRMWWRnb0R1UG9Hek16ODd3U3kvcHhseDVGWlFwUmttWCsr?=
 =?utf-8?B?QWRIdGRvM3o2UE9DM01JTGQ2Vmc1TTlsZG1vWW1WZ2JvSUJPQmpidnVydlUz?=
 =?utf-8?B?UU5SdnRoRDAxWHNTZ0YwZjRxZXBJajRkTnFKdVJNbGhvWXJaRXlIMVd3K0dL?=
 =?utf-8?B?aVRhdEszdDdTWVBnaWpBb2k4K0szRWhQbVRZZXBlcmk1TXVqSUJpaUJSMXJt?=
 =?utf-8?B?K1ZQL1p0R3JBU2RaNm9KYWJwRVRENXRpWWpUVGpXQ21ZaFFmSFB6aE5VcDdw?=
 =?utf-8?B?Tm5EV3Zvb0FGQmNSVTJ5UjZ2YVRRamk2L2VVeEY2VlZjVkYvcTloUm9EQVB0?=
 =?utf-8?B?WDlLUGhkWGhLcGk2ZjdkdUFOUURQcDQxdHJtUkFOVGFZOG1FdmdaMG55enNW?=
 =?utf-8?B?czRsaElJZXJkMEpBNURXL1lxNHVIaElYYktaakYwTzN1d0dVUndDUmtuNzFP?=
 =?utf-8?B?K3BybEdQK1pJYVNZdEg0b1d0MEZ5Vk1Cbks5eWZWY0kreDZzTGpyckplOWlC?=
 =?utf-8?B?NE9PQ3FYYlNTYWxRK1dCZW1WSDFFQlVsYTFmdkhBeGJIVUtkYnVLTWpsRTE1?=
 =?utf-8?B?bEl1MXNrTGdIYmJKWGlpbzNRc250emJUSFRoeFYwaFVuU0M0WDRvVnNYcFNm?=
 =?utf-8?B?Qmp3U2F0c1hpY29OaGt2dG94UmpWRytrK3JGNW8wdnRYLzJ3ZkRNeThYR0NF?=
 =?utf-8?B?L0tkVC9jd0tCQmZuZWxYb3JkSTh2Y0RCM3pWVHNhZ24wc3dROXNaMks0ZVJz?=
 =?utf-8?B?VEZFbjFNSDJpaVhTc3pTd3pJcElRTGQ5OG5xM1RlQWF4VmdWYWpTRTBZZkdv?=
 =?utf-8?B?WkNsWUZwOEhWRjc1akJSYXhBRkRya0U2MnJMbFJjTVpkelNjdzFLNENXaE9Q?=
 =?utf-8?B?Q3ZpSzJNTXJ6amttODdYbis0VFpIaHordGtJcTBlNmtLamNqT3NLOU1sYWMz?=
 =?utf-8?B?WDhHcVdVczBGd3lrYXpQeU1ldmNIa09CVXZ3VE4rQStOSWVrdFcrWkVnU05B?=
 =?utf-8?B?a28rY1F3YjhFd2Z6aEExb0xxVmJXNFBVVU80bmtBY1J6eHh5dnA3TEQzUkN3?=
 =?utf-8?B?WDJKNzRWS1JhWml5ZGErRXNYN3J6WGZkV1dWb3IvTWJqSGNRUGhUZ1FLRWVx?=
 =?utf-8?B?aW5pdmVxanNxM2kxYk1kWVBPVCtHakxGeWcycmhLWUxvR1lKbXVQSDcwYisy?=
 =?utf-8?B?YjRMb3pJcnFsUHUya09vS0FCeDJVUHZUSnQwWktFYVlYUk1qbUdZbGJjUmpo?=
 =?utf-8?B?RU5UOEtGdTZHWDh2TC9DazZyMXY2b3pPWVdPS2VFSlU3VXBsdmFyV2dmUzU3?=
 =?utf-8?B?eDNIS2hmaG9nZkVVZEljSWdUbVByL2JWcUJyOTM0U2FqZDgxWjFIdUtaMEFt?=
 =?utf-8?B?UEtQTDQvcWxNNnkyc0dpWmo5d29wNlQ5R0RpNUsreTMvamp0ZVhvVDYxSi9y?=
 =?utf-8?B?amt4NHllZlRKMFhlVmtqMXlWS25sbVJYSDBKV3NEUmdWUTBXZFE4Yi81QnRx?=
 =?utf-8?B?Yjk3aG9zSW1CODJvMGNMZlBZK0tOUGY5NFh3N0pxWUltNm1QZklNeFArWW1i?=
 =?utf-8?B?eHFZQldaQ2VtclRkTFdwb1pYbXZrOGJhb1g2TXE4SEZYQlhlK01XUllzMCtt?=
 =?utf-8?B?bGVucUVzVlQyZFMzdVVGbG9udHMwamdTNFBKeE9hdUJhZ3ZXemlHYjZiVUtC?=
 =?utf-8?B?TzYrUTF4YUdKTzY0VGwyS3JnQlpML2VGM3VKVVQwU0hMM2kxYnRKa2xHZ3V6?=
 =?utf-8?B?RDNrb3pwQ2dPMzgvOGlldG9xWUVuNys0SGNNYTRkbzRNY1NndFlhWUN6NDF3?=
 =?utf-8?Q?fPTLKh9Qb9rnUv5v1SDN36Eie?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a23972-34bf-4fdf-dbb2-08dd81414644
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 01:59:10.7664 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SFN81oA876h6DUnYvuxCcLIIacvSBEIW0gfqYBpoFwX9O3i33KNbypiggY3mgCuTZpIyOBwCgT+GXQCd7GjVXMc4ffRS7rLWIzCJuFuHH7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5963
Received-SPF: pass client-ip=2a01:111:f403:c400::3;
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMDIvMTBdIGh3L2FybS9hc3Bl
ZWRfYXN0Mjd4MCBJbnRyb2R1Y2UgdmJvb3Ryb20NCj4gbWVtb3J5IHJlZ2lvbg0KPiANCj4gT24g
NC8xNy8yNSAwNToxMSwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IEludHJvZHVjZSBhIG5ldyB2Ym9v
dHJvbSBtZW1vcnkgcmVnaW9uLiBUaGUgcmVnaW9uIGlzIG1hcHBlZCBhdA0KPiA+IGFkZHJlc3Mg
IjB4MDAwMDAwMDAiIGFuZCBoYXMgYSBzaXplIG9mIDEyOEtCLCBpZGVudGljYWwgdG8gdGhlIFNS
QU0gcmVnaW9uDQo+IHNpemUuDQo+ID4gVGhpcyBtZW1vcnkgcmVnaW9uIGlzIGludGVuZGVkIGZv
ciBsb2FkaW5nIGEgdmJvb3Ryb20gaW1hZ2UgZmlsZSBhcw0KPiA+IHBhcnQgb2YgdGhlIGJvb3Qg
cHJvY2Vzcy4NCj4gPg0KPiA+IFRoZSB2Ym9vdHJvbSByZWdpc3RlcmVkIGluIHRoZSBTb0MncyBh
ZGRyZXNzIHNwYWNlIHVzaW5nIHRoZQ0KPiA+IEFTUEVFRF9ERVZfVkJPT1RST00gaW5kZXguDQo+
ID4NCj4gPiBJbnRyb2R1Y2VkIGEgInZib290cm9tX3NpemUiIGF0dHJpYnV0ZSBpbiAiQXNwZWVk
U29DQ2xhc3MiIHRvIGRlZmluZQ0KPiA+IHZpcnR1YWwgYm9vdCBST00gc2l6ZS4NCj4gDQo+IENv
dWxkIHlvdSBwbGVhc2UgZXhwbGFpbiB3aHkgd2UgbmVlZCBhIGNsYXNzIGF0dHJpYnV0ZSB0byBz
aXplIHRoZSB2Ym9vdHJvbQ0KPiByZWdpb24gPyBUaGUgcmVzdCBsb29rcyBnb29kLg0KPiANCg0K
SSd2ZSByZXZpZXdlZCB0aGUgU1JBTSBkZXNpZ24gYW5kIHVzZWQgaXQgYXMgYSByZWZlcmVuY2Ug
dG8gY3JlYXRlIGEgbmV3IGNsYXNzIGF0dHJpYnV0ZSBmb3Igc2V0dGluZyB0aGUgc2l6ZSBvZiB0
aGUgdmJvb3Ryb20gbWVtb3J5IHJlZ2lvbi4NCkN1cnJlbnRseSwgSSBkb24ndCBwbGFuIHRvIHN1
cHBvcnQgZGlmZmVyZW50IHZib290cm9tIGltYWdlcyBmb3IgdGhlIEFTVDI3eDAuIE15IHVuZGVy
c3RhbmRpbmcgaXMgdGhhdCBhIHNpbmdsZSB2Ym9vdHJvbSBpbWFnZSBzaG91bGQgYmUgc3VmZmlj
aWVudCB0byBzdXBwb3J0IGFsbCBBU1QyN3gwIHZhcmlhbnRzLg0KSWYgeW91IGFncmVlLCBJIHdp
bGwgcmVtb3ZlIHRoaXMgY2xhc3MgYXR0cmlidXRlIGFuZCBpbnN0ZWFkIGhhcmRjb2RlIHRoZSB2
Ym9vdHJvbSBzaXplIHRvIDEyOEtCLg0KDQpUaGFua3MtSmFtaW4NCj4gDQo+IFRoYW5rcywNCj4g
DQo+IEMuDQo+IA0KPiANCj4gDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGph
bWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogTmFiaWggRXN0ZWZhbiA8
bmFiaWhlc3RlZmFuQGdvb2dsZS5jb20+DQo+ID4gVGVzdGVkLWJ5OiBOYWJpaCBFc3RlZmFuIDxu
YWJpaGVzdGVmYW5AZ29vZ2xlLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGluY2x1ZGUvaHcvYXJtL2Fz
cGVlZF9zb2MuaCB8ICAzICsrKw0KPiA+ICAgaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMgICAgIHwg
MTIgKysrKysrKysrKysrDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKykN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2FybS9hc3BlZWRfc29jLmggYi9pbmNs
dWRlL2h3L2FybS9hc3BlZWRfc29jLmgNCj4gPiBpbmRleCBmMDY5ZDE3ZDE2Li45YWY4Y2ZiYzNl
IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvaHcvYXJtL2FzcGVlZF9zb2MuaA0KPiA+ICsrKyBi
L2luY2x1ZGUvaHcvYXJtL2FzcGVlZF9zb2MuaA0KPiA+IEBAIC01OSw2ICs1OSw3IEBAIHN0cnVj
dCBBc3BlZWRTb0NTdGF0ZSB7DQo+ID4gICAgICAgTWVtb3J5UmVnaW9uIHNyYW07DQo+ID4gICAg
ICAgTWVtb3J5UmVnaW9uIHNwaV9ib290X2NvbnRhaW5lcjsNCj4gPiAgICAgICBNZW1vcnlSZWdp
b24gc3BpX2Jvb3Q7DQo+ID4gKyAgICBNZW1vcnlSZWdpb24gdmJvb3Ryb207DQo+ID4gICAgICAg
QWRkcmVzc1NwYWNlIGRyYW1fYXM7DQo+ID4gICAgICAgQXNwZWVkUnRjU3RhdGUgcnRjOw0KPiA+
ICAgICAgIEFzcGVlZFRpbWVyQ3RybFN0YXRlIHRpbWVyY3RybDsNCj4gPiBAQCAtMTUyLDYgKzE1
Myw3IEBAIHN0cnVjdCBBc3BlZWRTb0NDbGFzcyB7DQo+ID4gICAgICAgY29uc3QgY2hhciAqIGNv
bnN0ICp2YWxpZF9jcHVfdHlwZXM7DQo+ID4gICAgICAgdWludDMyX3Qgc2lsaWNvbl9yZXY7DQo+
ID4gICAgICAgdWludDY0X3Qgc3JhbV9zaXplOw0KPiA+ICsgICAgdWludDY0X3QgdmJvb3Ryb21f
c2l6ZTsNCj4gPiAgICAgICB1aW50NjRfdCBzZWNzcmFtX3NpemU7DQo+ID4gICAgICAgaW50IHNw
aXNfbnVtOw0KPiA+ICAgICAgIGludCBlaGNpc19udW07DQo+ID4gQEAgLTE2OSw2ICsxNzEsNyBA
QCBzdHJ1Y3QgQXNwZWVkU29DQ2xhc3Mgew0KPiA+ICAgY29uc3QgY2hhciAqYXNwZWVkX3NvY19j
cHVfdHlwZShBc3BlZWRTb0NDbGFzcyAqc2MpOw0KPiA+DQo+ID4gICBlbnVtIHsNCj4gPiArICAg
IEFTUEVFRF9ERVZfVkJPT1RST00sDQo+ID4gICAgICAgQVNQRUVEX0RFVl9TUElfQk9PVCwNCj4g
PiAgICAgICBBU1BFRURfREVWX0lPTUVNLA0KPiA+ICAgICAgIEFTUEVFRF9ERVZfVUFSVDAsDQo+
ID4gZGlmZiAtLWdpdCBhL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC5jIGIvaHcvYXJtL2FzcGVlZF9h
c3QyN3gwLmMgaW5kZXgNCj4gPiBiMDVlZDc1ZmY0Li43ZWVjZThlMjg2IDEwMDY0NA0KPiA+IC0t
LSBhL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC5jDQo+ID4gKysrIGIvaHcvYXJtL2FzcGVlZF9hc3Qy
N3gwLmMNCj4gPiBAQCAtMjQsNiArMjQsNyBAQA0KPiA+ICAgI2luY2x1ZGUgInFlbXUvbG9nLmgi
DQo+ID4NCj4gPiAgIHN0YXRpYyBjb25zdCBod2FkZHIgYXNwZWVkX3NvY19hc3QyNzAwX21lbW1h
cFtdID0gew0KPiA+ICsgICAgW0FTUEVFRF9ERVZfVkJPT1RST01dICA9ICAweDAwMDAwMDAwLA0K
PiA+ICAgICAgIFtBU1BFRURfREVWX1NSQU1dICAgICAgPSAgMHgxMDAwMDAwMCwNCj4gPiAgICAg
ICBbQVNQRUVEX0RFVl9IQUNFXSAgICAgID0gIDB4MTIwNzAwMDAsDQo+ID4gICAgICAgW0FTUEVF
RF9ERVZfRU1NQ10gICAgICA9ICAweDEyMDkwMDAwLA0KPiA+IEBAIC02NTcsNiArNjU4LDE1IEBA
IHN0YXRpYyB2b2lkDQo+IGFzcGVlZF9zb2NfYXN0MjcwMF9yZWFsaXplKERldmljZVN0YXRlICpk
ZXYsIEVycm9yICoqZXJycCkNCj4gPiAgICAgICBtZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdpb24o
cy0+bWVtb3J5LA0KPiA+DQo+IHNjLT5tZW1tYXBbQVNQRUVEX0RFVl9TUkFNXSwNCj4gPiAmcy0+
c3JhbSk7DQo+ID4NCj4gPiArICAgIC8qIFZCT09UUk9NICovDQo+ID4gKyAgICBuYW1lID0gZ19z
dHJkdXBfcHJpbnRmKCJhc3BlZWQudmJvb3Ryb20uJWQiLA0KPiBDUFUoJmEtPmNwdVswXSktPmNw
dV9pbmRleCk7DQo+ID4gKyAgICBpZiAoIW1lbW9yeV9yZWdpb25faW5pdF9yYW0oJnMtPnZib290
cm9tLCBPQkpFQ1QocyksIG5hbWUsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgc2MtPnZib290cm9tX3NpemUsIGVycnApKSB7DQo+ID4gKyAgICAgICAgcmV0dXJuOw0KPiA+
ICsgICAgfQ0KPiA+ICsgICAgbWVtb3J5X3JlZ2lvbl9hZGRfc3VicmVnaW9uKHMtPm1lbW9yeSwN
Cj4gPiArDQo+IHNjLT5tZW1tYXBbQVNQRUVEX0RFVl9WQk9PVFJPTV0sDQo+ID4gKyAmcy0+dmJv
b3Ryb20pOw0KPiA+ICsNCj4gPiAgICAgICAvKiBTQ1UgKi8NCj4gPiAgICAgICBpZiAoIXN5c2J1
c19yZWFsaXplKFNZU19CVVNfREVWSUNFKCZzLT5zY3UpLCBlcnJwKSkgew0KPiA+ICAgICAgICAg
ICByZXR1cm47DQo+ID4gQEAgLTg5OCw2ICs5MDgsNyBAQCBzdGF0aWMgdm9pZA0KPiA+IGFzcGVl
ZF9zb2NfYXN0MjcwMGEwX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKm9jLCB2b2lkICpkYXRhKQ0K
PiA+DQo+ID4gICAgICAgc2MtPnZhbGlkX2NwdV90eXBlcyA9IHZhbGlkX2NwdV90eXBlczsNCj4g
PiAgICAgICBzYy0+c2lsaWNvbl9yZXYgID0gQVNUMjcwMF9BMF9TSUxJQ09OX1JFVjsNCj4gPiAr
ICAgIHNjLT52Ym9vdHJvbV9zaXplID0gMHgyMDAwMDsNCj4gPiAgICAgICBzYy0+c3JhbV9zaXpl
ICAgID0gMHgyMDAwMDsNCj4gPiAgICAgICBzYy0+c3Bpc19udW0gICAgID0gMzsNCj4gPiAgICAg
ICBzYy0+d2R0c19udW0gICAgID0gODsNCj4gPiBAQCAtOTI1LDYgKzkzNiw3IEBAIHN0YXRpYyB2
b2lkDQo+ID4gYXNwZWVkX3NvY19hc3QyNzAwYTFfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqb2Ms
IHZvaWQgKmRhdGEpDQo+ID4NCj4gPiAgICAgICBzYy0+dmFsaWRfY3B1X3R5cGVzID0gdmFsaWRf
Y3B1X3R5cGVzOw0KPiA+ICAgICAgIHNjLT5zaWxpY29uX3JldiAgPSBBU1QyNzAwX0ExX1NJTElD
T05fUkVWOw0KPiA+ICsgICAgc2MtPnZib290cm9tX3NpemUgPSAweDIwMDAwOw0KPiA+ICAgICAg
IHNjLT5zcmFtX3NpemUgICAgPSAweDIwMDAwOw0KPiA+ICAgICAgIHNjLT5zcGlzX251bSAgICAg
PSAzOw0KPiA+ICAgICAgIHNjLT53ZHRzX251bSAgICAgPSA4Ow0KDQo=

