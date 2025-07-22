Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B676FC83F25
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 09:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ue9mN-0006jZ-Pw; Tue, 22 Jul 2025 05:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1ue9mH-0006fT-TK; Tue, 22 Jul 2025 05:59:19 -0400
Received: from mail-koreacentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::7] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1ue9mE-000368-7t; Tue, 22 Jul 2025 05:59:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SP8x/n0sge0talTm9p5qWaw0jz9vfOT4TF+AqD+90UPRtNw7iyexsMnDSxTj65Tf5+uHKXvZ9jKmfn7PV+SEmGHhzBwypa0l+a/xQOWKJr3A49iWQMh0ybDF6HdN2mu+KYRmTfM3VViymfAml1YbY8FC0uLO2VGKcDDLMHoKZX8JItJDOCruHnA1JHII3FhF/sYMJMhWIaK66De8WNjbwkzXOj/jO7IdCwCStuiOp5wbBvvTxWAgpKptlROB+GIx13k1uyXmacYQdlF+cU/XwbyFsQvRKHpFHuRuSab+Wus/fo919d8qaZqDtTAMVIN7uaN6/BEFD+nZEWJTY57WWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNXj+4qxbFesyDqLaIegqePbp9UxGz951TIgJnkmzhk=;
 b=CctOns2zIwG4uh4pNVL+MtbJ5O0uwkqdCkkzGBkqbVLOD/ecCHWFOWLOKSzL7LEMAuldswJOGyvkmiFRA4wzPtth9NNFDlofG32UmvkJjDkzGwl866u4LH/rb97v1kbfBxYMkvTbJGWNrMLA6ED4DnOPVowB1fj1Wi57pYEqlM0/BN5SW4GcQl3BSJT/PjdZdl77au/IQwVB/6FNJ691a03X+iSruvgNXsc3RpqYKbMOYXrT/nICYFci7H5KCreD4P9lxsiaWmx0yZJQ9dabVyZRfswI+TVEi82Z/8RSNf8AInERazp3FIEd208wD3A2htYb3un5IVy184Moq7YTLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNXj+4qxbFesyDqLaIegqePbp9UxGz951TIgJnkmzhk=;
 b=Czv6JbBWsanx6NeGY3oqeWMnmZo0S3R4R9WabhArBxi8yznPeMr7lbqXZtE8+HdLJMgiHsNjnKx8PZnQL6db8JpPJeLPyYPwOlhmZu8XUcR++JTGElHRA5/RrlRR+l2dzwqX5c3xt6U73ycu+wnMKDSIYcW9xnrKaymHkPoH86tGcA2fo7TIJqNSpywjjo/M0iZiR6NLJ8kpgE+SZOmJNNEDSrHmWm4HGKqDN6w59VXKm5dNp4WS+6Qe32nyhFPgEKLQgr/rHs4k1QvSjzhzNhmQK7KAHpNbV3k9ixrEFenplJTBmqeXNHDqQPT3VhY5nIdBra3mgznyHd8Up/5hug==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SEZPR06MB6973.apcprd06.prod.outlook.com (2603:1096:101:1f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 09:59:03 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 09:59:03 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [SPAM] [PATCH v4 1/5] hw/misc/aspeed_otp: Add ASPEED OTP memory
 device model
Thread-Topic: [SPAM] [PATCH v4 1/5] hw/misc/aspeed_otp: Add ASPEED OTP memory
 device model
Thread-Index: AQHb781M4fFYTbCBUEOFckAOg/xMkrQ9/ayAgAAAPEA=
Date: Tue, 22 Jul 2025 09:59:03 +0000
Message-ID: <SI6PR06MB7631B6266B8E012046560CA1F75CA@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20250708055810.2868680-1-kane_chen@aspeedtech.com>
 <20250708055810.2868680-2-kane_chen@aspeedtech.com>
 <baa4f638-5a1f-4c45-b9a1-3264d6d1cb7c@kaod.org>
In-Reply-To: <baa4f638-5a1f-4c45-b9a1-3264d6d1cb7c@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|SEZPR06MB6973:EE_
x-ms-office365-filtering-correlation-id: 3c191d80-0933-464a-e98c-08ddc906637f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?SmhLeVdzNXA4WjRrS0h2RCtra0lnQ01lU1paRXRPc2lYSnJwc0N3TDYzVGsx?=
 =?utf-8?B?dE5pcmJ0S2x1SVU2clFOUjJpS29tTWk1WUcwaGF1TmtSTTVyd3c4dFhQZVhn?=
 =?utf-8?B?SUFUNFZtT1FlbExIazFNSXFCd3RjdE1DMFQrMEk2UUtGSGU1S3FDSXVpZ0Z4?=
 =?utf-8?B?M1JyVVk4aTR2VWVLRm1INHFCMTFsdXhpQ0tMS01ocFRkTmJSbGlUUXE3SVdm?=
 =?utf-8?B?VkEyYlkvNzkydzBKMkYvYk1tSzh2N2E5cnVKd3h0dm5FNGd4b3JBRmJ1bVdP?=
 =?utf-8?B?dEt3OThpUytqZzd0NjR2UnVNY2Y3em5jYnJMZGN3WTd4ZmFhTFprL2lWOTI0?=
 =?utf-8?B?bFpMbjBHSm44UE9Dd1lVQjBvQTNPdVFFZlhhMEdPUFJVTzRua3VCNDErRFMz?=
 =?utf-8?B?THNmVmJVM3BIL3NxZHJwNWFBc3AxWjVaT1packNoM3pCeXMvNEpSZWpqZU5j?=
 =?utf-8?B?TUtYRGxyS2FpZXVoc2phMEMwVEFUdE42YmJSNWorMVZBMGRndkhtYXpQKzNY?=
 =?utf-8?B?U0RQcDFCR3pmMUhaVXoyb1ZnRmlzdisrSHF0eXI5cG5NTTJXWVRkbHBLczI5?=
 =?utf-8?B?Zi96UStyZDFINEIrMmhUblRzK1dPQjArdGxBRVNhQjJ1dmh2Z3I1elRnZDVk?=
 =?utf-8?B?MnkxTE5MMFhzUWE0S0gyMEd3NmNNUjZxRXkrUldPRTdhSGFleFljb25teW02?=
 =?utf-8?B?K3RqclBLcG5vV2h0RmxSVUp6Z2RLdXJtQmVIOG5CMWZjL1piUVRZdGN2RzNi?=
 =?utf-8?B?MjhxTjVFRFBxcHk1WTdvYUNnSUx4blhYWVdBWTM0UXdqeGNsSE96Q280U2R4?=
 =?utf-8?B?aW9OaExnRXJOc3JUWVRxUGluQTNMbWVWMjVFaldTTG40M0s3amVCK3hFYXcw?=
 =?utf-8?B?TGY3MTBCSXdTSTlQQ0pvR3ByVURGOG13bVQxTlh1eDd4eUh0TGxSMTJNVDBk?=
 =?utf-8?B?MkFHNlBmOVM0M0JJL0pTQUYzZUwxRUV3cTc5QTUwQWltTzI4RnlpSnAwWkhB?=
 =?utf-8?B?dG50Z0NQTUh5cERFeENaTml5ZllVR0NNTnoxaEdyRDhwc251bWZ4Z0ZtZkZx?=
 =?utf-8?B?empkMVhkbGdlSjBjaGIwcGZNVW5LM1N5cHdYa042cU9tTS94eE5hTWNHZE5l?=
 =?utf-8?B?RmRqSGJtdXFGc3JtUVpNbWZncE9DbklYQ0hmMnFuV3NKWmwvTVpyenBialBx?=
 =?utf-8?B?NVRyZ2tnOXk2cldVVFl1WlhDeEFGUmtsNzRiaE0xZHkxOWt1aVpqS1V5c0ZP?=
 =?utf-8?B?SXNocWZaTjZKb3JEVEFkQmlzZWVRV2lsMTFFL2JRUHpjYnVpeEFySWo0aDFp?=
 =?utf-8?B?ZFZOM3Y5dHo2U1p3dUZsZWJmUWtFSStEeXVBQ0M3ajFVdUg5ME1IbGt3cHhm?=
 =?utf-8?B?K2xSNlBCY0hCS2pSUGdSWmlmYVFzZ1VvdnVXM21ubmtLemJYWUlmUGFFUVUv?=
 =?utf-8?B?U0l3bmNFaTZ3UUpXRWRqMm8wWkcwcE5IVWFja2xyeU9taldxSzQyM0lpbDJn?=
 =?utf-8?B?Q3JNMCtoTGgrcHBXYW1SZUJHUGM3Kzh4ajVNNmE2Wmw5ZWJsUm5JZjBadDh0?=
 =?utf-8?B?a2RIZUcrZitRQnEzRXNHYVdTOVRKeXZhWUFvbnRPM1FNZjNIQ1M4blRPWGdZ?=
 =?utf-8?B?UlNkRVRqbmdTV2l3bHBoTjloUjNqcVNYVjgzZjdaTGVOdDJnZjNiSVR0alF1?=
 =?utf-8?B?b0xIQWtEMjRUdERjNC9qL2hqdXlhcnI2a0FQMHR5UFMrUHkrUTQxQ1hWMHg1?=
 =?utf-8?B?NWpnWmc0TjZEQnVrL1JmM0Vwem40TVhRYVNwQ2xSZTRrN0daV1B3VjV5SE8v?=
 =?utf-8?B?UWRPVWEzT1M3MUQ3VHNRMkhqTFhGOXV0SG13MWcrN25UWXk0cU9hUE1FZGJS?=
 =?utf-8?B?RFhLYzBKaW1kdkQvVWVoV3k1ZTFTMDN6Qk9PWXJncmdZMGJjVXlqZEEyNWdv?=
 =?utf-8?B?MXNFaFd1cTU4eHg4VmY2SER4VXBWRDVmSG1HMExPRnByWjNxYzFJV0t2SVZR?=
 =?utf-8?B?NnhhVXdFTEthM1V6ODlrY283RWJSNUpwSm1haE1SUlNISGx5N0c4R0xJVkt1?=
 =?utf-8?Q?F0DLwW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDFHSVA2bUMvM1JEZ2dXalVyZUhQNUVLZjl4NUo4VS9LWHdrMTZnQ0IzR01P?=
 =?utf-8?B?Q0dmVjhsRmNDQ0g1cXpUTk43QkJzZHFzKzlFbGsxbkMvajhiSGZiYlBsUXpz?=
 =?utf-8?B?MFczR0xmUVROd0xFRDV6VGErbGRteXE1Y3RHUmtyTGtxQnJrUkpMMlZpTlg2?=
 =?utf-8?B?WlZOUThsbGFKMzJDOFFFOCtLd0RKN09hNXQ0eE9DeEtReVkyWjRQV2JCVGd0?=
 =?utf-8?B?WVBqdkZmNitKNFJxQkY3QVp1MEFMdmRNczFSVTZXNHk2ZHp2QUxkeDBFSDQ2?=
 =?utf-8?B?NEtOVWJQR1JSVWhUVStTNXcreW9hdkVFb0s1YzdpVG1VUzJMdDlTL1UyNnhm?=
 =?utf-8?B?dFJNa2RoYUJaRzVvQUk3eDN0ZFA4NEVNcjNFWlBtZEZiMnhzRk5LUS9LS2Jx?=
 =?utf-8?B?RnZFTXVmV29iQWlaTTBsVkxXdjlCaXpTNE5iRDhTVWI1bmRsNVBMeUQ0OHV3?=
 =?utf-8?B?VkFrbW10cVdibzhMclNjYXVyUGx2dURqczQzN0dPeDBXVHZTVHlTcE5WZS9k?=
 =?utf-8?B?ckcxVEU1V2M2b0ZDNE1VaEUwdlZleU1pOXQvSHNVVldEOXpGbjE5UnlldW1O?=
 =?utf-8?B?ZFdRejg1b3Rob3p0Ulh3aXkzakVXUVVsZGVSNFZjcTZwa3JnQUk0UEc0dVlV?=
 =?utf-8?B?U3BBNDROMnVxTE9GTjhtUUFHenExL2VvdWx2cjdyRUNYMG5pMXRQUzBjL2Zr?=
 =?utf-8?B?VzZ6VDBHYlJXcmFydG1MRG82TFhCcnZibUpMUzN1UHBGZjB5WitlcElEcjFL?=
 =?utf-8?B?UXBrQ0xKamFndC92dmZhdmwvOFdkejhtTEd5enIzeWlPWU1ZT01BWXJUakZ5?=
 =?utf-8?B?K2lVZ2ZKdy9EQURYMXNVRHVWeUtrUzBvbkFXc3dxck9Ha0xrUzVhUm5kQ3B1?=
 =?utf-8?B?ZlFIR2ozdmFuT3dIZDhnKzliR2RJdTZNQzc0bklOWUo3SzR2cENJYkdJdnE4?=
 =?utf-8?B?V1lZcHRkTXhUTm1DMlRHQ0k1c2NtdHhmMFFQaU04SVV2WmtsZ1NHUEt1S09S?=
 =?utf-8?B?NWYvM1NzTVpqK09Sa0J3bTgyRVp5N3pJeXk0aVIyREd4dWN0aDhTSU1ocmV1?=
 =?utf-8?B?dkovWU1TZEpqRG94cDgrT1YrUGtibkJWY2N2VHdZVVlmaytudGFIYWNJRFRF?=
 =?utf-8?B?aDJRMGNkTkNYczQzY2VrVG5Bd3pqY0lrUzNYRE5aVExWZmZVanpQa2M0V1N4?=
 =?utf-8?B?cklmLzJCb3NnQnBVemVGZkUyZlowNVNnZXhzWXI2cnh4eTVqK3lIaVMzcGZ1?=
 =?utf-8?B?WDJVWDJaRlpXbWJXNldEd0VCWVlVbXk1K24zandGNWlmTll5dGZsODc4U0Iz?=
 =?utf-8?B?c1IxRWJnTEJ0R05jZG5ZMEJDNGFhTlhQVEk2RUg2MUViVEpiSER6ellwYWI5?=
 =?utf-8?B?U0p6Y1FsanZ3cnBKU25MUHp0b21VeHVSejNzVHloT3JJb2hDeXh5dE43eHZj?=
 =?utf-8?B?UmFiTm1CZ2hXdllxTTdUTUUvTjE4elZ6T2UvY1lOSitHeFNXOWZLbnJOKzRQ?=
 =?utf-8?B?c3E2L3VEbFhXT25hZ3Q5TjQ3M3ZRclN0eDdobU5YZ0NVS3dxRi9laE1PY1Z3?=
 =?utf-8?B?TDJkajJ6MGV5T2xJaVFoQmRhK1ZRRFY4YjFDeHlUOS9RNjJaQ2pyQ2V0blNO?=
 =?utf-8?B?ZXhMejgwNzA4TElKOFlwVHlRbTY3ZjltZHNzZVM0QWFVSzl2L3JRVG14emhG?=
 =?utf-8?B?MUxFTUg1SlNZVlBMZzBFUkw4MW5JUWV3ZDdLejVXbUxydTNOT2VRc0ZzRWxZ?=
 =?utf-8?B?aXZGVEltZmRNQitLbTZXQUR2elVnR3pRYmcvcEcyTWduVzFBSjZDOVpVMHVG?=
 =?utf-8?B?MmdvWU16TWhBRDU4T2lhN1lDMTFXS091RzhHZVA5UXdiY1ZZYlhHTFFvQnJ4?=
 =?utf-8?B?MVMwTnl4WGxNdzY1NXNxL2NDVVNkV1poaktSc0pGdUlJSFFZTDljOWlIOElE?=
 =?utf-8?B?UVNCeFI5aU56ZFFadVd1clpVdk4vMk9PVVBQZ0w0c1o2WEg5eE5FVU9LYkxm?=
 =?utf-8?B?dkpxNGprTlJLZ3gwUVFpN1o5T2hQa3MyUGlabGlTamFEVDRHdmFUQm1hRTJ2?=
 =?utf-8?B?aC8xblptUW1heEovQkpuT1RUNU9TcjNSeTdQWnNBSjBjMUp0d3Aza0J4VE5s?=
 =?utf-8?Q?e5xVmD/AJJV9gZdVK4YnkwBka?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c191d80-0933-464a-e98c-08ddc906637f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 09:59:03.2245 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4VJ52oMyOnIdFBRw/mE9mAXdM5uedtaPJIm3UzkDaJeX3qHv3DEYPguOsKe/6JWS/KC1+jgoP6DBgdBYC/+LbYKcc34Qay/OH83eWcjsLd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6973
Received-SPF: pass client-ip=2a01:111:f403:c40f::7;
 envelope-from=kane_chen@aspeedtech.com;
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

SGkgQ8OpZHJpYywNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCkkgd2lsbCB1cGRhdGUg
dGhlIGNvZGUgYWNjb3JkaW5nbHkgaW4gdGhlIG5leHQgdmVyc2lvbiBvZiB0aGUgcGF0Y2ggc2Vy
aWVzLg0KDQpCZXN0IFJlZ2FyZHMsDQpLYW5lDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+DQo+IFNlbnQ6IFR1ZXNk
YXksIEp1bHkgMjIsIDIwMjUgNTo1NSBQTQ0KPiBUbzogS2FuZSBDaGVuIDxrYW5lX2NoZW5AYXNw
ZWVkdGVjaC5jb20+OyBQZXRlciBNYXlkZWxsDQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+
OyBTdGV2ZW4gTGVlIDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29tPjsgVHJveQ0KPiBMZWUgPGxl
ZXRyb3lAZ21haWwuY29tPjsgSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBB
bmRyZXcNCj4gSmVmZmVyeSA8YW5kcmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFu
bGV5IDxqb2VsQGptcy5pZC5hdT47DQo+IG9wZW4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1A
bm9uZ251Lm9yZz47IG9wZW4gbGlzdDpBbGwgcGF0Y2hlcyBDQw0KPiBoZXJlIDxxZW11LWRldmVs
QG5vbmdudS5vcmc+DQo+IENjOiBUcm95IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbU1BBTV0gW1BBVENIIHY0IDEvNV0gaHcvbWlzYy9hc3BlZWRfb3RwOiBB
ZGQgQVNQRUVEIE9UUA0KPiBtZW1vcnkgZGV2aWNlIG1vZGVsDQo+IA0KPiBPbiA3LzgvMjUgMDc6
NTcsIEthbmUgQ2hlbiB3cm90ZToNCj4gPiBGcm9tOiBLYW5lLUNoZW4tQVMgPGthbmVfY2hlbkBh
c3BlZWR0ZWNoLmNvbT4NCj4gPg0KPiA+IEludHJvZHVjZSBhIFFFTVUgZGV2aWNlIG1vZGVsIGZv
ciBBU1BFRUQncyBPbmUtVGltZSBQcm9ncmFtbWFibGUNCj4gKE9UUCkNCj4gPiBtZW1vcnkuDQo+
ID4NCj4gPiBUaGlzIG1vZGVsIHNpbXVsYXRlcyBhIHdvcmQtYWRkcmVzc2FibGUgT1RQIHJlZ2lv
biB1c2VkIGZvciBzZWN1cmUNCj4gPiBmdXNlIHN0b3JhZ2UuIFRoZSBPVFAgbWVtb3J5IGNhbiBv
cGVyYXRlIHdpdGggYW4gaW50ZXJuYWwgbWVtb3J5DQo+ID4gYnVmZmVyLg0KPiA+DQo+ID4gVGhl
IE9UUCBtb2RlbCBwcm92aWRlcyBhIG1lbW9yeS1saWtlIGludGVyZmFjZSB0aHJvdWdoIGEgZGVk
aWNhdGVkDQo+ID4gQWRkcmVzc1NwYWNlLCBhbGxvd2luZyBvdGhlciBkZXZpY2UgbW9kZWxzIChl
LmcuLCBTQkMpIHRvIGlzc3VlDQo+ID4gdHJhbnNhY3Rpb25zIGFzIGlmIGFjY2Vzc2luZyBhIG1l
bW9yeS1tYXBwZWQgcmVnaW9uLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogS2FuZS1DaGVuLUFT
IDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gICBpbmNsdWRlL2h3L252
cmFtL2FzcGVlZF9vdHAuaCB8IDMzICsrKysrKysrKysrKw0KPiA+ICAgaHcvbnZyYW0vYXNwZWVk
X290cC5jICAgICAgICAgfCA5OQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KPiA+ICAgaHcvbnZyYW0vbWVzb24uYnVpbGQgICAgICAgICAgfCAgNCArKw0KPiA+ICAgMyBm
aWxlcyBjaGFuZ2VkLCAxMzYgaW5zZXJ0aW9ucygrKQ0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0
IGluY2x1ZGUvaHcvbnZyYW0vYXNwZWVkX290cC5oDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQg
aHcvbnZyYW0vYXNwZWVkX290cC5jDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9u
dnJhbS9hc3BlZWRfb3RwLmgNCj4gPiBiL2luY2x1ZGUvaHcvbnZyYW0vYXNwZWVkX290cC5oIG5l
dyBmaWxlIG1vZGUgMTAwNjQ0IGluZGV4DQo+ID4gMDAwMDAwMDAwMC4uMzc1MjM1Mzg2MA0KPiA+
IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9pbmNsdWRlL2h3L252cmFtL2FzcGVlZF9vdHAuaA0K
PiA+IEBAIC0wLDAgKzEsMzMgQEANCj4gPiArLyoNCj4gPiArICogIEFTUEVFRCBPVFAgKE9uZS1U
aW1lIFByb2dyYW1tYWJsZSkgbWVtb3J5DQo+ID4gKyAqDQo+ID4gKyAqICBDb3B5cmlnaHQgKEMp
IDIwMjUgQXNwZWVkDQo+ID4gKyAqDQo+ID4gKyAqICBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTIuMC1vci1sYXRlciAgKi8NCj4gPiArDQo+ID4gKyNpZm5kZWYgQVNQRUVEX09UUF9IDQo+
ID4gKyNkZWZpbmUgQVNQRUVEX09UUF9IDQo+ID4gKw0KPiA+ICsjaW5jbHVkZSAic3lzdGVtL21l
bW9yeS5oIg0KPiA+ICsjaW5jbHVkZSAiaHcvYmxvY2svYmxvY2suaCINCj4gPiArI2luY2x1ZGUg
InN5c3RlbS9hZGRyZXNzLXNwYWNlcy5oIg0KPiA+ICsNCj4gPiArI2RlZmluZSBUWVBFX0FTUEVF
RF9PVFAgImFzcGVlZC1vdHAiDQo+ID4gK09CSkVDVF9ERUNMQVJFX1NJTVBMRV9UWVBFKEFzcGVl
ZE9UUFN0YXRlLCBBU1BFRURfT1RQKQ0KPiA+ICsNCj4gPiArdHlwZWRlZiBzdHJ1Y3QgQXNwZWVk
T1RQU3RhdGUgew0KPiA+ICsgICAgRGV2aWNlU3RhdGUgcGFyZW50X29iajsNCj4gPiArDQo+ID4g
KyAgICBCbG9ja0JhY2tlbmQgKmJsazsNCj4gPiArDQo+ID4gKyAgICB1aW50NjRfdCBzaXplOw0K
PiA+ICsNCj4gPiArICAgIEFkZHJlc3NTcGFjZSBhczsNCj4gPiArDQo+ID4gKyAgICBNZW1vcnlS
ZWdpb24gbW1pbzsNCj4gPiArDQo+ID4gKyAgICB1aW50OF90ICpzdG9yYWdlOw0KPiA+ICt9IEFz
cGVlZE9UUFN0YXRlOw0KPiA+ICsNCj4gPiArI2VuZGlmIC8qIEFTUEVFRF9PVFBfSCAqLw0KPiA+
IGRpZmYgLS1naXQgYS9ody9udnJhbS9hc3BlZWRfb3RwLmMgYi9ody9udnJhbS9hc3BlZWRfb3Rw
LmMgbmV3IGZpbGUNCj4gPiBtb2RlIDEwMDY0NCBpbmRleCAwMDAwMDAwMDAwLi5lNDE0ODFkOWJi
DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2h3L252cmFtL2FzcGVlZF9vdHAuYw0KPiA+
IEBAIC0wLDAgKzEsOTkgQEANCj4gPiArLyoNCj4gPiArICogIEFTUEVFRCBPVFAgKE9uZS1UaW1l
IFByb2dyYW1tYWJsZSkgbWVtb3J5DQo+ID4gKyAqDQo+ID4gKyAqICBDb3B5cmlnaHQgKEMpIDIw
MjUgQXNwZWVkDQo+ID4gKyAqDQo+ID4gKyAqICBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BM
LTIuMC1vci1sYXRlciAgKi8NCj4gPiArDQo+ID4gKyNpbmNsdWRlICJxZW11L29zZGVwLmgiDQo+
ID4gKyNpbmNsdWRlICJxZW11L2xvZy5oIg0KPiA+ICsjaW5jbHVkZSAicWFwaS9lcnJvci5oIg0K
PiA+ICsjaW5jbHVkZSAic3lzdGVtL2Jsb2NrLWJhY2tlbmQtaW8uaCINCj4gDQo+IFBsZWFzZSBy
ZXBsYWNlIHdpdGggOg0KPiANCj4gI2luY2x1ZGUgInN5c3RlbS9ibG9jay1iYWNrZW5kLmgiDQo+
IA0KPiANCj4gVGhhbmtzLA0KPiANCj4gQy4NCj4gDQo+IA0KPiANCj4gPiArI2luY2x1ZGUgImh3
L3FkZXYtcHJvcGVydGllcy5oIg0KPiA+ICsjaW5jbHVkZSAiaHcvbnZyYW0vYXNwZWVkX290cC5o
Ig0KPiA+ICsNCj4gPiArc3RhdGljIHVpbnQ2NF90IGFzcGVlZF9vdHBfcmVhZCh2b2lkICpvcGFx
dWUsIGh3YWRkciBvZmZzZXQsIHVuc2lnbmVkDQo+ID4gK3NpemUpIHsNCj4gPiArICAgIEFzcGVl
ZE9UUFN0YXRlICpzID0gb3BhcXVlOw0KPiA+ICsgICAgdWludDY0X3QgdmFsID0gMDsNCj4gPiAr
DQo+ID4gKyAgICBtZW1jcHkoJnZhbCwgcy0+c3RvcmFnZSArIG9mZnNldCwgc2l6ZSk7DQo+ID4g
Kw0KPiA+ICsgICAgcmV0dXJuIHZhbDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQg
YXNwZWVkX290cF93cml0ZSh2b2lkICpvcGFxdWUsIGh3YWRkciBvZmZzZXQsDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3QgdmFsLCB1bnNpZ25lZCBzaXplKSB7
DQo+ID4gKyAgICBBc3BlZWRPVFBTdGF0ZSAqcyA9IG9wYXF1ZTsNCj4gPiArDQo+ID4gKyAgICBt
ZW1jcHkocy0+c3RvcmFnZSArIG9mZnNldCwgJnZhbCwgc2l6ZSk7IH0NCj4gPiArDQo+ID4gK3N0
YXRpYyBib29sIGFzcGVlZF9vdHBfaW5pdF9zdG9yYWdlKEFzcGVlZE9UUFN0YXRlICpzLCBFcnJv
ciAqKmVycnApDQo+ID4gK3sNCj4gPiArICAgIHVpbnQzMl90ICpwOw0KPiA+ICsgICAgaW50IGks
IG51bTsNCj4gPiArDQo+ID4gKyAgICAgICAgbnVtID0gcy0+c2l6ZSAvIHNpemVvZih1aW50MzJf
dCk7DQo+ID4gKyAgICAgICAgcCA9ICh1aW50MzJfdCAqKXMtPnN0b3JhZ2U7DQo+ID4gKyAgICAg
ICAgZm9yIChpID0gMDsgaSA8IG51bTsgaSsrKSB7DQo+ID4gKyAgICAgICAgICAgIHBbaV0gPSAo
aSAlIDIgPT0gMCkgPyAweDAwMDAwMDAwIDogMHhGRkZGRkZGRjsNCj4gPiArICAgICAgICB9DQo+
ID4gKw0KPiA+ICsgICAgcmV0dXJuIHRydWU7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBj
b25zdCBNZW1vcnlSZWdpb25PcHMgYXNwZWVkX290cF9vcHMgPSB7DQo+ID4gKyAgICAucmVhZCA9
IGFzcGVlZF9vdHBfcmVhZCwNCj4gPiArICAgIC53cml0ZSA9IGFzcGVlZF9vdHBfd3JpdGUsDQo+
ID4gKyAgICAuZW5kaWFubmVzcyA9IERFVklDRV9MSVRUTEVfRU5ESUFOLA0KPiA+ICsgICAgLnZh
bGlkLm1pbl9hY2Nlc3Nfc2l6ZSA9IDEsDQo+ID4gKyAgICAudmFsaWQubWF4X2FjY2Vzc19zaXpl
ID0gNCwNCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIGFzcGVlZF9vdHBfcmVhbGl6
ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApIHsNCj4gPiArICAgIEFzcGVlZE9UUFN0
YXRlICpzID0gQVNQRUVEX09UUChkZXYpOw0KPiA+ICsNCj4gPiArICAgIGlmIChzLT5zaXplID09
IDApIHsNCj4gPiArICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJhc3BlZWQub3RwOiAnc2l6ZScg
cHJvcGVydHkgbXVzdCBiZSBzZXQiKTsNCj4gPiArICAgICAgICByZXR1cm47DQo+ID4gKyAgICB9
DQo+ID4gKw0KPiA+ICsgICAgcy0+c3RvcmFnZSA9IGJsa19ibG9ja2FsaWduKHMtPmJsaywgcy0+
c2l6ZSk7DQo+ID4gKw0KPiA+ICsgICAgaWYgKCFhc3BlZWRfb3RwX2luaXRfc3RvcmFnZShzLCBl
cnJwKSkgew0KPiA+ICsgICAgICAgIHJldHVybjsNCj4gPiArICAgIH0NCj4gPiArDQo+ID4gKyAg
ICBtZW1vcnlfcmVnaW9uX2luaXRfaW8oJnMtPm1taW8sIE9CSkVDVChkZXYpLCAmYXNwZWVkX290
cF9vcHMsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgcywgImFzcGVlZC5vdHAiLCBz
LT5zaXplKTsNCj4gPiArICAgIGFkZHJlc3Nfc3BhY2VfaW5pdCgmcy0+YXMsICZzLT5tbWlvLCBO
VUxMKTsgfQ0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IFByb3BlcnR5IGFzcGVlZF9vdHBfcHJv
cGVydGllc1tdID0gew0KPiA+ICsgICAgREVGSU5FX1BST1BfVUlOVDY0KCJzaXplIiwgQXNwZWVk
T1RQU3RhdGUsIHNpemUsIDApLCB9Ow0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgYXNwZWVkX290
cF9jbGFzc19pbml0KE9iamVjdENsYXNzICprbGFzcywgY29uc3Qgdm9pZA0KPiA+ICsqZGF0YSkg
ew0KPiA+ICsgICAgRGV2aWNlQ2xhc3MgKmRjID0gREVWSUNFX0NMQVNTKGtsYXNzKTsNCj4gPiAr
ICAgIGRjLT5yZWFsaXplID0gYXNwZWVkX290cF9yZWFsaXplOw0KPiA+ICsgICAgZGV2aWNlX2Ns
YXNzX3NldF9wcm9wcyhkYywgYXNwZWVkX290cF9wcm9wZXJ0aWVzKTsgfQ0KPiA+ICsNCj4gPiAr
c3RhdGljIGNvbnN0IFR5cGVJbmZvIGFzcGVlZF9vdHBfaW5mbyA9IHsNCj4gPiArICAgIC5uYW1l
ICAgICAgICAgID0gVFlQRV9BU1BFRURfT1RQLA0KPiA+ICsgICAgLnBhcmVudCAgICAgICAgPSBU
WVBFX0RFVklDRSwNCj4gPiArICAgIC5pbnN0YW5jZV9zaXplID0gc2l6ZW9mKEFzcGVlZE9UUFN0
YXRlKSwNCj4gPiArICAgIC5jbGFzc19pbml0ICAgID0gYXNwZWVkX290cF9jbGFzc19pbml0LA0K
PiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgYXNwZWVkX290cF9yZWdpc3Rlcl90eXBl
cyh2b2lkKSB7DQo+ID4gKyAgICB0eXBlX3JlZ2lzdGVyX3N0YXRpYygmYXNwZWVkX290cF9pbmZv
KTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArdHlwZV9pbml0KGFzcGVlZF9vdHBfcmVnaXN0ZXJfdHlw
ZXMpDQo+ID4gZGlmZiAtLWdpdCBhL2h3L252cmFtL21lc29uLmJ1aWxkIGIvaHcvbnZyYW0vbWVz
b24uYnVpbGQgaW5kZXgNCj4gPiAxMGYzNjM5ZGI2Li5iNjZmMjM2MDViIDEwMDY0NA0KPiA+IC0t
LSBhL2h3L252cmFtL21lc29uLmJ1aWxkDQo+ID4gKysrIGIvaHcvbnZyYW0vbWVzb24uYnVpbGQN
Cj4gPiBAQCAtMTksMyArMTksNyBAQCBzeXN0ZW1fc3MuYWRkKHdoZW46ICdDT05GSUdfWExOWF9C
QlJBTScsDQo+IGlmX3RydWU6DQo+ID4gZmlsZXMoJ3hsbngtYmJyYW0uYycpKQ0KPiA+DQo+ID4g
ICBzcGVjaWZpY19zcy5hZGQod2hlbjogJ0NPTkZJR19QU0VSSUVTJywgaWZfdHJ1ZTogZmlsZXMo
J3NwYXByX252cmFtLmMnKSkNCj4gPiAgIHNwZWNpZmljX3NzLmFkZCh3aGVuOiAnQ09ORklHX0FD
UEknLCBpZl90cnVlOg0KPiA+IGZpbGVzKCdmd19jZmctYWNwaS5jJykpDQo+ID4gKw0KPiA+ICtz
eXN0ZW1fc3MuYWRkKHdoZW46ICdDT05GSUdfQVNQRUVEX1NPQycsIGlmX3RydWU6IGZpbGVzKA0K
PiA+ICsgICdhc3BlZWRfb3RwLmMnLA0KPiA+ICsgICkpDQo+ID4gXCBObyBuZXdsaW5lIGF0IGVu
ZCBvZiBmaWxlDQoNCg==

