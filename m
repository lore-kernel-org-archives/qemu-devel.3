Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F77CA100B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 05:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utfzL-0003GU-KB; Wed, 03 Sep 2025 01:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1utfzJ-0003GE-QE; Wed, 03 Sep 2025 01:24:53 -0400
Received: from mail-koreacentralazon11023098.outbound.protection.outlook.com
 ([40.107.44.98] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1utfzH-0006NW-Ir; Wed, 03 Sep 2025 01:24:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNPx4bf3V6blw2Enko+AGPusIoTs1oVGMfksUSLoaP4d5ygacuYPk5W3K38HSStxSpTQjKZxtkbS8L0CVwoOFrk2kfmXoTv4JSG6SiPgcc2UBVQN1MgUd1A7V5wHqzcamSg0XFYpnD2Nwxgbrf3QCcwa1lsRXQsbAPccUSDThryfZgMVmW/yR0/HkG3xWqUYUAIefgK6YSVo2dyUmwiIV7Hro2JmzuBQX/eCbF6jmXhknSf+8AmS2nwi7V2ykaPexqf5thyyfr0nRiQ0GNV1W3jzDw6dlzvMdSAxuzZdCMGXZeHXIcSlZkH+a11/PFu4fgfk5agtuGLUZ2DjSLXMLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xC9CBfy1VCfg4+KpD2ienEcm99SH0qwq1wV1i+TltWo=;
 b=rHAqFXvJBVytbUT8OvWthMgoI8Rg/bh7I5Vt3RI7JRh2G1hDCV1D6EEbaeNBQ5CNAkuP3OwbD/pOW6ft/xSgf0ceUOj9SGm38B1YtQghFtK+k2w0Y6PwOaLqjSpJ0eW8jEgM01TrY/kbgMjv93K81zW7hSu5bDhkzI76ORY+RGo/sNv+yrTfKlEP/aO4ylPLrGmJhvYYwbb7CVMxbWNcArwMUvDqTHOFh23RbB0dJF26xKO9IkyTtO8LO6xfHx7rAXUq6BP0VoTywGKS6ioXZx6eUFMpy9Yn0kr9IoJel7ZwGUDwkhCMh2YpPq03zFeX74d0O/f9FcdP5Pn1zgYbBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xC9CBfy1VCfg4+KpD2ienEcm99SH0qwq1wV1i+TltWo=;
 b=qrBsuqpnXBE0Y7rEO1krBTN7I90IiZh4ty9UmidcoCMh8KiCBt3uokxv+YArsQoq5uavBWpWXgNtXQ+crvEEFqMz0DYWeMVlJ6d0pfps5/kI25moklo4E9EsKzrbVY4c5p32jP0qKfs6/NZV9996j048lpF4eQsvW0gnCpl0mLEu5u0lNjWPpDm+SDrqPE6WiqXyZn32flSXLd9yYJplvIJuNpFVXqHxja5sCDkCDexMwWuoDRgbzBE32lH8ooivhbIqdC/pzLu57MzWj4tK/2gnnfho2j8RgDehJdneNuZLMcxzWNrFFUcaQYIGcGWZXAKagUmJZLm+FWvJeVASmQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TY1PPF0B80138A3.apcprd06.prod.outlook.com (2603:1096:408::906) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.17; Wed, 3 Sep 2025 05:19:40 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%3]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 05:19:40 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [SPAM] [PATCH v1 01/21] hw/arm/aspeed_ast27x0-fc: Support VBootRom
Thread-Topic: [SPAM] [PATCH v1 01/21] hw/arm/aspeed_ast27x0-fc: Support
 VBootRom
Thread-Index: AQHb9sydZv8OumUorEiKpzfB6N2+/rR/sJSAgAAmBtCAAFVPAIABBzXQ
Date: Wed, 3 Sep 2025 05:19:40 +0000
Message-ID: <SI2PR06MB5041FC53142AA1F6461BB0ADFC01A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
 <20250717034054.1903991-2-jamin_lin@aspeedtech.com>
 <9e7ec38d-7bb9-4f1e-b75b-96c3eec97024@kaod.org>
 <SI2PR06MB5041202A90343458D2BE7724FC06A@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <f17784ea-80dc-4ca5-ae46-b73752e40905@kaod.org>
In-Reply-To: <f17784ea-80dc-4ca5-ae46-b73752e40905@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TY1PPF0B80138A3:EE_
x-ms-office365-filtering-correlation-id: 4e57fa01-e257-4a2e-40f3-08ddeaa97bf2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?V1RabzFmRjk5U0JUY3JYWTYvejJQN2RxN2g3UHRWbUxNQ3lTbXloQkpZeU41?=
 =?utf-8?B?L0RUeVBrVmRtY0hzblBqMzk3Zm5VbmVEOFBCNTVLWFc3M09BL2U5eU5XNzJh?=
 =?utf-8?B?OCtsQnljeFl6MGVOMEczNlZxOHZ0SlFGWVpxamVhL2srcFNpNWVlRUFCNUJw?=
 =?utf-8?B?bmVYTmpWL1Y2WjFpT1pBaXpreE1RTjB4S0JYU1RWdVNuSjNwT2xNRjQ5a3hx?=
 =?utf-8?B?Z3dHalYzeVBteXU0ekVzZTRmK1R1MXFZSVJWMG56WE9IcHFsT1lnSkZ2NEkv?=
 =?utf-8?B?RFgrcWw0LzlYbC9ETXZoVDBiWXpVL1k1TFRlaElVTzZ2ZHMvOGFma0J2OGZE?=
 =?utf-8?B?YjEzUytEVXBvYmExQXBnVm1BNG9Cdm02T3JNOXl1Ymprb2dxNlMwN1hjM3pm?=
 =?utf-8?B?QnNsR3k2dXV0aDJCa3VHYnEvYzBHaDRKZFgzbnZGR2YyUjdSaUs1S29FbHNR?=
 =?utf-8?B?bG5oOUF1QWlGUURxM0laVHB0dFlLWGhvWmF4TVNlYmZtY3VRMjdiaXVEUGxt?=
 =?utf-8?B?WmpvL0lJQmQvc282b3JML3hFWTY2NUZGQnEvLzd5ZFNoR24wODBhUU1RRkNJ?=
 =?utf-8?B?M1U2c25ZYUhoQzZpSXpsNk4zYlI4TGlsVDZyVlMyRHJIdTVpaUs3b3I2RXBz?=
 =?utf-8?B?bzFrdktkbUNZRGVYRXM2VStmUkZTaUhsc3ZqZUNDajBicGJ1U2F3ek1obUsv?=
 =?utf-8?B?QUNSbmZBZGdETkgvMzY5OWpReUdMVGVEQmhBdkxrM2NYU1R6WnZrZVNkZk9p?=
 =?utf-8?B?Um5pU0ZEamRJakV1dHhxNlpoclJzeFlNcFZwcFAzYitWdnBMSGNKTCs5THEv?=
 =?utf-8?B?S0lzemtwUEx0VFZTeG5VRnhsZWhSa3RhcHNvR1FRbUV5QmFMajMydVVkcjM0?=
 =?utf-8?B?VFdHKzBLN042MkpzaGJZTFdEd0dYYVZUR1AyNk9vYWk1RGxkaEhXSzVQdXdP?=
 =?utf-8?B?NmxkR3BZcmVNSnRCQXJiY0ptbHFDSVlqdmlKS004YjJUVVNFTXdPRDdpcm5m?=
 =?utf-8?B?a2JYOW5aRXlpd0NHa2FNanBFQVc0MnMydHVNWnBxdFJxUzkyVkhZTE91M2cr?=
 =?utf-8?B?R0R2UFhCOUJrSXZBZGNKZXpURGY3S3BzWHNMbmtMUk9wc09pQzkvdTgrODVF?=
 =?utf-8?B?VmdYZExNUmlGaXRteUEydFpJRVY3R2s4dlFsaDFlTWc0VmxSNDZIWXd5b3pH?=
 =?utf-8?B?SkVtYUw1dDJoSC9QSW5FOUx2NHhCV0NzVEZjMmNYNGNsNDQ1K2l2UElSRkxu?=
 =?utf-8?B?RVdqMzhmYXhXUmRtMk52Yi9NVjlaSGxXT2pRY3pGQjdraGtWM3ZPVEJrNUdJ?=
 =?utf-8?B?b05qODBDTmV2K01ZUjhMUkRCNHo0dmdTRm1tVVNEMzRFV3JTRWw1ZjJKWmZR?=
 =?utf-8?B?VUwwWE1qYVk0R1VvdDZUWEw0WkdRaVlKMERuS3FxRExkODRqSTlXQ2drY3RR?=
 =?utf-8?B?TmpDdjdyU0JVeVdESVB4bGJKSHZ5QnlZK2NHUkhxN1VCSnNvYjREN2JDbzRq?=
 =?utf-8?B?UzNwTmFBSGh4b2JIQjl6QytIQjVEZXV2YWxDejlUZFgvUDQzOVVtYzJaTzVS?=
 =?utf-8?B?VmhWUm45RmRRL09xU2dmZXVJZFlKeFpqeDRiQnhNVThJS1lJbndQaHluV2xH?=
 =?utf-8?B?emhYVlovNHpVdW1OQUZGZnZNazhlRDVodUFkWkdoRjFWcy9OdG5tN1MyRTZQ?=
 =?utf-8?B?MWtHV29SK1BTcXVVOFAwMGE2Rm5SamhObk5BVXgyc2JoTVhpZWdmdWdXMXln?=
 =?utf-8?B?eXFkbVIycHVCUHYxZnY3c1F1c2RCVitrS1lwOW5sVktyUUorMHNmcVpkK2dZ?=
 =?utf-8?B?TDRQUmgydDdTUjZTWml4N0NLWkIvaTU2K3FRV08vejIvaDRKWmtDVFBZdHh6?=
 =?utf-8?B?WUJIc1IxMUIvdDlaTHVlTk9HVWlnMFlTVWswZExlY2YrUWJmV1VxQU5ZMlFT?=
 =?utf-8?B?ZUJrRXhUd012Mlp4c2FwbHU5NVR5Zy9PRUJNSG1ydEdJb3NBYjJkYVNVMytQ?=
 =?utf-8?B?WEVwNEpqMVpqMmZGMlNXK3o4RTByNXNmQWpLbnhON1BqK0lZVUljd1k1U09I?=
 =?utf-8?Q?q+HWwk?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTNnZFRnL3Y1a2t4REhJZjZqdEw5Y3VrYUZ2alM5WnJ0QWk2WlVzcWpiUWVi?=
 =?utf-8?B?ZEV3UHRZbmZQL1NsS0lZUHlDNXVFVGI5MkMxdzBjcEJiV1hOYUNaakZBYzJW?=
 =?utf-8?B?Rkduank4TUxVK05mVFFoUGVNWjlRVTErUndGRW5CTDFtUFVEemdWS0hSOGox?=
 =?utf-8?B?b3UwR0JNL0JaQkdBNjU2bXpid2NCNXNhczZPQ2dxb0xUZFdOdkwxeUNhT1M2?=
 =?utf-8?B?M1p5MnRaVVk5bHJNbTBNUDdPYnhXNitWQm1NK1BGQnZjTDhPMWt4ZGN6cm5N?=
 =?utf-8?B?UjV4Tzg2RC9waFRsTWsyNW9qYkdvWlk4UE95NFhnT1QyMFE0YXUrOEduY0FK?=
 =?utf-8?B?c1lvZ1JHaFB2d3JRZUV5blp2c0xMYVFSck9RbGMwTnZLZEJxd2R2Smk5SnZY?=
 =?utf-8?B?S2VXV3BSdGNQc3pFMGxlcy9FYlpRKzBvR3VZSDB0V00vNCtxUHBtcmtwQXdr?=
 =?utf-8?B?QUgrOTMyd0Y3SWdXUkEyRFhmSEJOSmZrdnppVWtSLzZYRmVEYXI5WGVGZHdD?=
 =?utf-8?B?UlVva0kyQWhrRW4zVFpoYlhkMkV5RE45Z1lRVHdGazNQNGs1QzdPaUN3czZT?=
 =?utf-8?B?ZERlTHkweWtGZ2xWTHEvTlpDUzc0b2NpNDV6VDI3SHlDZzhxandLSmE0Qi9Y?=
 =?utf-8?B?c2FnZWRQR1QyakkzTE4wbXJSUk5ySS9XMDR5NGFFNVNyU0wrN0lxZTg0VUF2?=
 =?utf-8?B?a29Ub1hxWmNhQlZEU3NoU0x3YldDMGRmNlo4N2ozUG9SbG9jWWN0NVU1TFMv?=
 =?utf-8?B?cjRrS3lKcmVCY2lHQmdTQWVFaHJlVmdGdUZvU053NVB0KzhIQ2xYcjhsbkRO?=
 =?utf-8?B?WjZLbHViTE1heHRhREwvcUJKYkY2RXJoZXMwdnUvOXp3VkdreE1UcGNzYWxm?=
 =?utf-8?B?dGFrVVJBUGNjeEdMRnI1cjRid3c2UGlqMDE1aHVFeWhoM05NOEtQbFNTZEZN?=
 =?utf-8?B?THRXSFRQcTQ1SHE3TjgxWDlZRGhOeWdjbnVaKzZ2Rnk3NWlZc0tNRlMxY3ZF?=
 =?utf-8?B?QlVTVGphUUxxZWhUQTFIRmd5M1pVeDAwN1Fsa1I0b3p1L1RERmpudkZmd1V5?=
 =?utf-8?B?Q2t6am5scXNIUnd3V0JodThFZEZ5SlJFTSticFJjSUo5ZGJ4NWdoMExBbzhp?=
 =?utf-8?B?UGhMcVNPMTdIZlNtTUdZVHdFc3diUE03V3VmU0VlTE9NblJxWmJ1MTg0OFZ0?=
 =?utf-8?B?bFpGSXJTK1hWWFNPekVVMnlTRWhVREd0K2JtcXc1ek1XZm1ETHRZcWpwd3l4?=
 =?utf-8?B?MU9OaGFibDMxWmsxNmZJNnpFN3dHMStpazlwUTAxamFSVE9NNlVrMUQ3V3Nj?=
 =?utf-8?B?ZW81U0NVbEtOY0Q1TGZrQlNnaGtOOGRnWXhDbXU2cVRXOEx3WUNVd3FpV3B3?=
 =?utf-8?B?NjV5VlJ5V2NDUmxqejZVdnhVRUx6MTMxbzZlVHAvMzVMcyt0Kzc2VVE5TlhG?=
 =?utf-8?B?T1RndUlxWHM5YkVHM2htdkNab3FnQ2hlWWtWcWhxZnBRdHBGVTJSNXhzUm9n?=
 =?utf-8?B?M2FhYWxBbVY5Z3N5eFpFbzhLYUhZQTZnS0NWK2V2MGg2UW9CS1lPSUFIRERK?=
 =?utf-8?B?MTN3Rm9vU3VxSE1uSnBNZDF2NnBYc1o2NmkzYnkzUVhIbnVjSmxWRCtRRjJ6?=
 =?utf-8?B?N3RHMUd3bWQ1L0ZuN0NJVzNPNEZHNXlMUUlreFROK2lsbktpUUdlL2l5b0VE?=
 =?utf-8?B?UEsxdlRSSVE2MTZjWkQxTVlMUWVlSS8rYUFtUnBoRDJRV05SREQ0bStMMzYy?=
 =?utf-8?B?Wm1YSGgxQTZRZHJoQkJWOEtDMkRhRm8wT1Zjb2tBYVdJYkFqK3dwRmNJbUhO?=
 =?utf-8?B?WnljdkY5V0h6QTBmUlljMTBoR0NtMEFmWC9CT29UNTM5bnRlSnlhOW4xSkow?=
 =?utf-8?B?eHR3SDZxSmhOc0kvMG9JWU85dWlVNTRlWW9KZG5YYXMyY0ZybXQyQmg5a21o?=
 =?utf-8?B?UUY2SXJ6ZmkvNnlKYUQ5UGZYVmNYVmc1Qkp3N2dsTVpXR0RaaUpZQlhSR25F?=
 =?utf-8?B?S2RWa1VZZWRZKzR6UXEwRVUweFlHS0FhbC9aTVMxS3p3VzBMTHNBUkE1d0JW?=
 =?utf-8?B?WWo0WU93ZTI4RGVEMmQxY3F4Qm1WUlA5ODl5SXEvZWc3dWlaL1crVVcrRU9j?=
 =?utf-8?Q?OIXQUUjMjVfcK9xUZ9hr2XU2m?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e57fa01-e257-4a2e-40f3-08ddeaa97bf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 05:19:40.5718 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Ej470+lEFo5F0u5nmQ9rWH/2sgsFhxLnyxaPwhXsYk2utBRZrIcZfOdB3xMxU+UmzTxm7z3M8OJalw15QG+RBlGiSBThyy8s1OjN9OPZdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF0B80138A3
Received-SPF: pass client-ip=40.107.44.98;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGkgQ8OpZHJpYywNCg0KPiBTdWJqZWN0OiBSZTogW1NQQU1dIFtQQVRDSCB2MSAwMS8yMV0gaHcv
YXJtL2FzcGVlZF9hc3QyN3gwLWZjOiBTdXBwb3J0DQo+IFZCb290Um9tDQo+IA0KPiBPbiA5LzIv
MjUgMTA6MjgsIEphbWluIExpbiB3cm90ZToNCj4gPiBIaSBDw6lkcmljDQo+ID4NCj4gPj4gU3Vi
amVjdDogUmU6IFtTUEFNXSBbUEFUQ0ggdjEgMDEvMjFdIGh3L2FybS9hc3BlZWRfYXN0Mjd4MC1m
YzoNCj4gPj4gU3VwcG9ydCBWQm9vdFJvbQ0KPiA+Pg0KPiA+DQo+ID4gVGhhbmtzIGZvciB5b3Vy
IHJldmlldyBhbmQgc3VnZ2VzdGlvbi4NCj4gPg0KPiA+IFBlciBvdXIgZWFybGllciBkaXNjdXNz
aW9uLCB3ZSBwbGFuIHRvIHJlZmFjdG9yIGh3L2FybS9hc3BlZWQuYy4gQXMgYQ0KPiA+IGZpcnN0
IHN0ZXAsIEkgY2FuIG1vdmUgdGhlIHZib290cm9tIGhlbHBlcnMgaW50byBhIGNvbW1vbiBzb3Vy
Y2UgZmlsZQ0KPiA+IHNvIHRoZXkgY2FuIGJlIHJldXNlZCBieSBvdGhlciBib2FyZHMuDQo+ID4N
Cj4gPiBEbyB5b3UgaGF2ZSBhIHByZWZlcmVuY2UgZm9yIHRoZSBmaWxlbmFtZT8NCj4gPiBody9h
cm0vYXNwZWVkX3V0aWxzLmMgKHdpdGggYSBzbWFsbCBoZWFkZXIgaW4NCj4gPiBpbmNsdWRlL2h3
L2FybS9hc3BlZWRfdXRpbHMuaCksDQo+IA0KPiANCj4gVGhlcmUgaXMgYSBhc3BlZWRfc29jX2Nv
bW1vbi5jIGZpbGUgZm9yIHN1Y2ggaGVscGVycy4NCj4gDQpUaGFua3MgZm9yIHRoZSBzdWdnZXN0
aW9ucy4NCg0KSXQgc2VlbXMgdGhhdCBhc3BlZWRfc29jX2NvbW1vbi5jIGlzIG1lYW50IGZvciBj
b2RlIHNoYXJlZCBhY3Jvc3MgYWxsIEFTUEVFRCBTb0NzIHJhdGhlciB0aGFuIHRoZSBib2FyZC1z
cGVjaWZpYyBjb2RlLg0KSSBhbSBwbGFubmluZyB0byBtb3ZlIHRoZSBmb2xsb3dpbmcgQVBJcyBp
bnRvIGEgY29tbW9uIGZpbGUuDQoNCnN0YXRpYyB2b2lkIGFzcGVlZF9sb2FkX3Zib290cm9tKEFz
cGVlZE1hY2hpbmVTdGF0ZSAqYm1jLCBjb25zdCBjaGFyICpiaW9zX25hbWUsDQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApDQpzdGF0aWMgdm9pZCBhc3BlZWRf
aW5zdGFsbF9ib290X3JvbShBc3BlZWRNYWNoaW5lU3RhdGUgKmJtYywgQmxvY2tCYWNrZW5kICpi
bGssDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCByb21fc2l6
ZSkNCnN0YXRpYyB2b2lkIHdyaXRlX2Jvb3Rfcm9tKEJsb2NrQmFja2VuZCAqYmxrLCBod2FkZHIg
YWRkciwgc2l6ZV90IHJvbV9zaXplLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3Ig
KiplcnJwKQ0KDQpUbyBidWlsZCBzdWNjZXNzZnVsbHksIHRoZSBBc3BlZWRNYWNoaW5lU3RhdGUg
c3RydWN0IGFsc28gbmVlZHMgdG8gYmUgbW92ZWQgaW50byBhc3BlZWQuaC4NCg0Kc3RydWN0IEFz
cGVlZE1hY2hpbmVTdGF0ZSB7DQogICAgLyogUHJpdmF0ZSAqLw0KICAgIE1hY2hpbmVTdGF0ZSBw
YXJlbnRfb2JqOw0KICAgIC8qIFB1YmxpYyAqLw0KDQogICAgQXNwZWVkU29DU3RhdGUgKnNvYzsN
CiAgICBNZW1vcnlSZWdpb24gYm9vdF9yb207DQogICAgYm9vbCBtbWlvX2V4ZWM7DQogICAgdWlu
dDMyX3QgdWFydF9jaG9zZW47DQogICAgY2hhciAqZm1jX21vZGVsOw0KICAgIGNoYXIgKnNwaV9t
b2RlbDsNCiAgICB1aW50MzJfdCBod19zdHJhcDE7DQp9Ow0KDQpJZiBJIHBsYWNlIHRoZSBhYm92
ZSBBUElzIGluIGFzcGVlZF9zb2NfY29tbW9uLmggdGhhdCBoZWFkZXIgd291bGQgYWxzbyBuZWVk
IHRvIGluY2x1ZGUgYXNwZWVkLmguDQpUbyBhdm9pZCBtaXhpbmcgU09DLWxldmVsIGFuZCBib2Fy
ZC1sZXZlbCBjb2RlLCBJIHByb3Bvc2UgY3JlYXRpbmcgYSBuZXcgYy9oIGZpbGUgdG8gcGxhY2Ug
dGhlbSBzdWNoDQphcyBhc3BlZWRfYm9hcmRfY29tbW9uLmMgYW5kIGFzcGVlZF9ib2FyZF9jb21t
b24uaA0KRG8geW91IGhhdmUgYW55IGNvbmNlcm5zIG9yIGNvdWxkIHlvdSBwbGVhc2UgZ2l2ZSBt
ZSBhbnkgc3VnZ2VzdGlvbj8NCg0KVGhhbmtzLUphbWluIA0KDQo+IA0KPiBUaGFua3MsDQo+IA0K
PiBDLg0K

