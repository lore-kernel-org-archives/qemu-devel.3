Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B102BC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 07:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugHtL-00082z-7I; Mon, 28 Jul 2025 03:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ugHsk-0007mD-Ml; Mon, 28 Jul 2025 03:02:50 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ugHsh-0008Dt-Sx; Mon, 28 Jul 2025 03:02:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=manK2riDzuNp6WO6v19PDYOvuiBQroRPyYxD9MPBd6+7ePkXbDF6c0K/IozVFR89W0PxCL2FTv0/T2fFB/HV6wOfFf/PIR8Ub+rYGpLYFJ73MDtz6G7OH+hFPUG2PLQt6ooxQ01biN2YvsgA/I7H/MSILEB7JyXpJGOYY4Rc57+QzGcAVNT4FXqtaooiHanoWmw4mjgi/YjP9xcDUDXsiI04p9dAJfNs2zDMuec7/oEB3aSxI587RYoCcWc0fuw5U3im6GjOlTWRdRT5hU6TdBAzZdKNyuJFWkl+oO4ZtvDEPdxJXz7/oeEB3Qp12zgAoN8stWtxZ/FBhEHouaKlLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOHmac4cs9SLU9hYcyjswGzesohq5xm2Dc0qacvjBh4=;
 b=t98T+t1CtENJmSQL3DILovhFfllC2QsZi740Cp3ubSX7uYc22Lo+PEQ93+40bwIFXMRvxZJ8K3fRaeUcxblQYtC98DCf/rGbjPidHyJLfaDX1+S4v2MoYBO9GaiNMNjwvLND14IacRu4wrFghuEtRV7EJZXeuncqVL47cpv0w4QrOIuyHcNsq8J73A9TtBhHkewzfgrSCCBVbJpzH+of/pz54O0Xzwl2ZJpd/0P3/mdxDxjCyR8BMRFYIv/nVepVIIAeFxvKvwXfrskugjJaKJPbL9beQYCnWXr2tlXIsj4Z89SVZKd/Bv3zNLE/SuqCdIa+uRHZb+JimLY6jcPXgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOHmac4cs9SLU9hYcyjswGzesohq5xm2Dc0qacvjBh4=;
 b=qYoVpiG1bYHELxdtx+wt5Q9wTAki3s5HiZLx+2Irs0zyH1yCOo4lsZg2GY8+wT9gWruHEaNuIuf1tZ8JrXZQS4V1izCJTggRdgtvyjrLAIJl+520zOeK9OjDASLiO0rZtphe6srN0eyjXc1JjohSBuQ1th4+ribNMqrv1/Dnt3yfiqmBez0zMkZDW9HuzdJEqTacmSwgVENJt31e/NUClxMPOLkpYQhXDRap8AmcYzDz3ZgEZ9/ecMOaBYpT7/H2HMHVmf+hTgzZi+yyfuaGWcG+BnxB+28fStf1I9WuYdZdAWyXXjPHkTnUaAoss7HZHgSneQEj8fZ7QuPZQCFWDg==
Received: from SEYPR06MB5037.apcprd06.prod.outlook.com (2603:1096:101:51::5)
 by SEZPR06MB7226.apcprd06.prod.outlook.com (2603:1096:101:234::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 07:02:30 +0000
Received: from SEYPR06MB5037.apcprd06.prod.outlook.com
 ([fe80::7c38:ebde:a05c:8196]) by SEYPR06MB5037.apcprd06.prod.outlook.com
 ([fe80::7c38:ebde:a05c:8196%4]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 07:02:30 +0000
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Michael Tokarev
 <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Hao Wu <wuhaotsh@google.com>, Havard
 Skinnemoen <hskinnemoen@google.com>
Subject: RE: [PATCH v1 19/21] pc-bios: Update AST27x0 vBootrom with SSP/TSP
 SCU initialization support
Thread-Topic: [PATCH v1 19/21] pc-bios: Update AST27x0 vBootrom with SSP/TSP
 SCU initialization support
Thread-Index: AQHb9sytNnqHTsl+Uk6K5yNks8BQkLRGchMAgAC3/gCAAAHtYA==
Date: Mon, 28 Jul 2025 07:02:30 +0000
Message-ID: <SEYPR06MB50372F288CD26111DD6E0D81FC5AA@SEYPR06MB5037.apcprd06.prod.outlook.com>
References: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
 <20250717034054.1903991-20-jamin_lin@aspeedtech.com>
 <7e5dc89a-7b74-4a5e-8f51-55f587a4896b@tls.msk.ru>
 <364b86f6-6147-4e63-bcfa-932c39072130@kaod.org>
In-Reply-To: <364b86f6-6147-4e63-bcfa-932c39072130@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5037:EE_|SEZPR06MB7226:EE_
x-ms-office365-filtering-correlation-id: 46b0bfc7-5752-4e41-9c79-08ddcda4b84d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?OWhFUWJ4eis2UEdpMWkrQm95QjRKS0VmdEZLWW1OSlFvRE5ZZ3c2TXdqRnV3?=
 =?utf-8?B?T0Z5OFl3OVQxaXZaQTJuUlB0YzUrZkZubXlXazZuaWo0RkJMOW5uU2VVVGVT?=
 =?utf-8?B?bEFadmRPNkFxRDQrcnVJOWg4eWF3ZW5iYlE2ZVdnZ1Z1aFdSWmpDejNJSGJT?=
 =?utf-8?B?MjJFakxtT1VZc21VbGJwTmtpbEw2TVNQNEdMS29IWWZLaSs2aFdiYllabEQw?=
 =?utf-8?B?TnVZcW4xZ3ZaUUlyMEVWWkRRVkRhK01pVUFwOWZ4M1Q2WmVJTWtRSkVXak5Z?=
 =?utf-8?B?dlpPRWIzVnFWdUxMTldkRUJVamtET1ZYSUsreSt1WHBxeFVKNnJ4RCs0T2lS?=
 =?utf-8?B?SlhRMnczWE1meWlJZlAyWE1EemRWczhqbm5RQit0L0JEam5NWUdlTGZlUlV0?=
 =?utf-8?B?SmtaSzM4VGNWeUhGeTdEVExZaFhWL0hnS2tEV3M1S2VIblNubk04QVFuMWdr?=
 =?utf-8?B?L0N0RWFtaVlnMGRDcDErREcrdTNKZE1pUzdPMG44UEJjSDQvZU9HcXJ6cGtO?=
 =?utf-8?B?WjRWQUZsTi9CVUdQZ0hlSCszOEl2aVptaHdSdEJQNkduSkNVd1VuZ2htSnM0?=
 =?utf-8?B?azA1RktiNFJQdVhtQm9ESTMwR0kxWlN4b1FuZUtDVk5Ca3oxNjJtWkoxUy9h?=
 =?utf-8?B?SURNbnFHc1BWTndMYzQ3K2dOdVNQWldXTys3K3pXdFVrZVVodDNJcFh2OVBa?=
 =?utf-8?B?UU9KTThZMUthd1lBS0tpN1B4Q0g2TWlSOEtBeDBFTGpkTEh1b0RUdTNGYlFB?=
 =?utf-8?B?M203VEpvZzRnQldZRnBSQi9VaFkxRVUyc3VNRm1rUEtJOGVqMk9pbHJiM2Zq?=
 =?utf-8?B?T2diN2Ntazk5YTF4aTBlbUlxMkJSVklxR3Z5S2V5cHlmQUtwSzlPTTFoSWwz?=
 =?utf-8?B?TzdJSTQwbUphVUxhUUgvRDkzajd3dGE0NHdyaDZwNjR4S0R1WFNUUWlSeDNz?=
 =?utf-8?B?ZHA5c1lLZS9zTjY3QWpyNjRiYzBFdlBaV0ZxUjlKQlBxeUlpczVHZVlHb0h4?=
 =?utf-8?B?cEcxMFpnQ3U5UmZSeVBpN1pBcittMUtsdTFiY2o2TytYbkl4ZjVXSjRicjBz?=
 =?utf-8?B?Z1VRcjBoa1lnOFIxMTc3aEJMMFlyVG1adU5rdllLUFhVbnhjTk0zdndRNC9S?=
 =?utf-8?B?Mit0Y0tyaXZlRXllK1Flb3YraVUraTdvRnlNTC8zKzIzSWNTOXJ6eTJJeDBO?=
 =?utf-8?B?SVRKVkpZQlR4WVE4WVFSd2xCZlhPTnJvc2NqMzRYdlNQZm1BaUFjLzdWMU05?=
 =?utf-8?B?ZUlZZmtyQjlkdFA3THp2M2FIVWd4M2V1a25QL1c2akl1Z1Evd0dqemd4c1ZD?=
 =?utf-8?B?SFZOdjRSRVVJNStLRGFTNUt3VkdBaU4zSXpFVzBZK1JSazFDS1E3dHNMYkpB?=
 =?utf-8?B?Q0ErUFFUeFRBVTZLQXlKaHA1aStrb2RDUk5ZQ0drbmZUVnhqbEtHT3FId0c3?=
 =?utf-8?B?eWI1ckFwUlNKSDZ3YzhFK0FqdzNIdFExUnl3eXRPNEt3aDhnRGpzZllFenpP?=
 =?utf-8?B?aUkwRXhoY3hhdCtpdnRBMGF0K3FrcmVWNm1SLytCbDB1OTlHTE1kd1J5dk1y?=
 =?utf-8?B?a3o2TmNGNUNNQjdYNW5ETkdKNnRWU050cnl3NGRXekxDSERRc0Rha2lnNE81?=
 =?utf-8?B?RzNVYTdtY09kZy9zVWZKVWNFTm54RVA5WlVEYWkwMFBZSlgweW1IdmpJZ0Zp?=
 =?utf-8?B?Zm1VNnI0bnF3ZWIvWlhYZVJuSXByYUdEVjdoLzRwc2d0OUpFQXZya2plajA0?=
 =?utf-8?B?Y285Sk0xK0oyemp6V0dNOGkwM1ZuSGp6OTVSWllhd0ZLa3ZVTXBZVWY2NG9B?=
 =?utf-8?B?RXQ1ektNcWRmTHJwd0NpblZxaXB0YWt4YVFEVkxXbExXSWlvdy9RU2xEaGhU?=
 =?utf-8?B?Mzc3YmFQT0p5T2wrT2g5Umt0YjY3eWUvTDNpeG9QSkV3aHFINGF4YVNKdWdu?=
 =?utf-8?B?aWo3TXhkNXd1cHYwM096M0FuN0J6c1R6TjV1R2RYS3JRL1Q4V29Kc1V6SE56?=
 =?utf-8?Q?7kMdavCCj2gVotoh5eglP9zL+sMH9s=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEYPR06MB5037.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bm94QVpuSmRPQ05vaDBGbTgvdDJxT0xVcmhTc0FFQUtuNlZ0RmR6UVJZTU9t?=
 =?utf-8?B?SEJ5ZVJ5VEM2c3ZGR0hwZXNzYndiUXNLOFp1Q3VBQVRvNjBHb2VrSTlCV1Rq?=
 =?utf-8?B?TlREeUV1Z0xYTnVBUTVwd0EySzdYOGhFck9RTzd1dVVaQUNTREFTZkl3eWc1?=
 =?utf-8?B?UVBpWEFocVJtcURSbVNHSWcrWVhNTllmb3E4M1gwSm1XTFNwQnNiN1FxSFQy?=
 =?utf-8?B?dDNFbHdTT3pEaGV5VXdDc3VNOTA3cFN3U1E4TndkTnlLR1NPV3BpREtoYndw?=
 =?utf-8?B?ZVFjMThCdUFxa1dvNDJDMDR4RENWWE1BWWZaRDY0Y2I5Z3ZsblRFYU82RU94?=
 =?utf-8?B?QWcrY0E1aklvWmt0RklLbld1ZTF2VzJUbm1SVHVVcWNpaDJ1dld1dHAvT0c5?=
 =?utf-8?B?RUlveFNLMlZIeUdndk1wSEdjYlFERzJsZFB1OHcwaU51VXhaZk1jTlczOXAx?=
 =?utf-8?B?bm1OUjFISzZuS21IQTlMSERFNllVaXpHOGpDWTcvVzdvSEhLSkVxTEk1bXJB?=
 =?utf-8?B?cmpVMGVFOVNHTkh0WHRWeHhZeEQxYi9ra3huTXhKa3NpYmR5QVMrVTlrckNa?=
 =?utf-8?B?SFRyTHZic1pwNmZCM2Y3eTdaa2VPWmMxdlcwRjZsYlF4OHpBN0JQUGF0THJa?=
 =?utf-8?B?Y083Zm9jNyt2TlFObjZ5K1lxa1BiQy9XQ3pIamlIT3VESWlDeGMxeWRjLzFz?=
 =?utf-8?B?OE5aZTVVazBMQ2xNKzB1bTBRbDIxWCt5MXlVdDlhL2Y2S3pldGlrY1lEMHpk?=
 =?utf-8?B?MWdyV2NtZGx0Z2VEQWtZSzNtUUY5ZlFZaFlyQTFwNWJ0a3Z0UVdSWmZUcW5m?=
 =?utf-8?B?V2NvN2F2NkJGWFB3OE9nR2pocVVrc0x1UndEcmExQjRsMk42UmZHTEFZS3By?=
 =?utf-8?B?a0lyaEpZdXNkbVkweEM5a0x1cW1hakZFK2RHOHZlTG45ckhSWFFXWWJPbEk5?=
 =?utf-8?B?aDdwVWRuQkRCVk1xc08zUDNnUWtMQmlDU0JOWmk4cFd5VklkLzF5VE42RHRj?=
 =?utf-8?B?c3VjNEo1VmV6V3E3amRuMWFCVWl4NjdrQU5wTTFiQjBMV0VmZk14elNpRVZt?=
 =?utf-8?B?Q3c1eWg4NHVSbThvL2V0VEllb0NjaHdGbzFVZGtDSjJldGpoMWVGU29PdjdD?=
 =?utf-8?B?ODd2YUhKRm90VlhNelBENFE3L202Qi9qZVc5R1VJMUNuSXNTVWQrWnZHYnVZ?=
 =?utf-8?B?Y3VLa2plSnB5NExYZjJBS2VLdHovcVMyYWRKbE5LMUdkNERFN2xWTVkzZFk5?=
 =?utf-8?B?UFEyaWhiQU1YNnJPTmpoK1FyWUorY3dCa3lhdmtNa1VEQUp3d0p6U0RYWDNy?=
 =?utf-8?B?NFVSbVo2T0tyYUp4NmdWNE0xR3hMaC80dkxXV1ZZNGhVRlltcHVTeXhJVGJE?=
 =?utf-8?B?a2pkVVZKYVkrNXBqTlB0eWkwcjJGVGpwSnR4NjhXaTVEL0QwRC84dkNGa2k4?=
 =?utf-8?B?NjZlOFdDNmtvd0sxZ3dsZmZLYjBZTFg0Zm5aTkhvVlRVUEZZa042QVF6QTRk?=
 =?utf-8?B?VUZRNjVqMjB5YnpPd2pLZFlvODk2WGdPMjQvekp6YUJjSWJ5M3pkRjl2ckZY?=
 =?utf-8?B?N1dKYUlkb09vTEkyeUN0S09Yd2JvcE0vVmExZEtRU3BNcnYydnRVRHpjaFRJ?=
 =?utf-8?B?QTUvdXZEVzBUTmdvYXhuT1ZNMDBjTEhpUWZ3YlVMb1U4alZlUW5lUDhTMjZM?=
 =?utf-8?B?dTUwNS9qK3lMUjBLUHZEbTNDRmxCRkdQMUlPRW55elZlOXdITWN0ZFFQTlJI?=
 =?utf-8?B?ZitmejBkYzFjdy9WejQzaUtxSnN2SVk5eDZCbVJLVUJJcWdpUzBVZ3ArMnll?=
 =?utf-8?B?M2xOMHh1MXMyNXdHbGw3Mk5JNzN6T3p6YlNteFRpRWIyZmV5YTBOc1FGcWJC?=
 =?utf-8?B?Wkh1SjRhYmh4M0VLVmZlNFVFT0lpcmFVZXdRNVRaam1iM3hPZGJaK2xUM00y?=
 =?utf-8?B?c0JKb3lWbnN1NmM0bHlxdW52Qk9DaWVvSGxFaFE2VWhlRXNUcU5pVkJuYWx2?=
 =?utf-8?B?QVRiM0lIaXZ6VlBINTRsanp3NDkyVUNmVC9TZGNwamhGa1RPUHFRajh1UnRj?=
 =?utf-8?B?M1Q0KzV3V3l1MUNDOVZJZm1jTUVPMWZTVWxFZWdtTHlZenBINWM1eElnaGI2?=
 =?utf-8?Q?imBONsABP2Be5h1S1trtaVWDO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5037.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b0bfc7-5752-4e41-9c79-08ddcda4b84d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 07:02:30.6840 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bTj4J/2iPaxg4vkb8FS5r1mGSzOESglE1iGHy05gmKVUEXozC5Rwr6NbW9W9vLqeZNlK4aRu/h1cdHB6VeBpoaauWTnbNZXWNWAT75r35pc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7226
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgQ8OpZHJpYywNCg0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0K
PiBTZW50OiBNb25kYXksIEp1bHkgMjgsIDIwMjUgMjo1MCBQTQ0KPiBUbzogTWljaGFlbCBUb2th
cmV2IDxtanRAdGxzLm1zay5ydT47IEphbWluIExpbg0KPiA8amFtaW5fbGluQGFzcGVlZHRlY2gu
Y29tPjsgUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsNCj4gU3RldmVu
IExlZSA8c3RldmVuX2xlZUBhc3BlZWR0ZWNoLmNvbT47IFRyb3kgTGVlIDxsZWV0cm95QGdtYWls
LmNvbT47DQo+IEFuZHJldyBKZWZmZXJ5IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+OyBK
b2VsIFN0YW5sZXkNCj4gPGpvZWxAam1zLmlkLmF1Pjsgb3BlbiBsaXN0OkFTUEVFRCBCTUNzIDxx
ZW11LWFybUBub25nbnUub3JnPjsgb3Blbg0KPiBsaXN0OkFsbCBwYXRjaGVzIENDIGhlcmUgPHFl
bXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gQ2M6IFRyb3kgTGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNo
LmNvbT47IEhhbyBXdSA8d3VoYW90c2hAZ29vZ2xlLmNvbT47DQo+IEhhdmFyZCBTa2lubmVtb2Vu
IDxoc2tpbm5lbW9lbkBnb29nbGUuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDE5LzIx
XSBwYy1iaW9zOiBVcGRhdGUgQVNUMjd4MCB2Qm9vdHJvbSB3aXRoIFNTUC9UU1ANCj4gU0NVIGlu
aXRpYWxpemF0aW9uIHN1cHBvcnQNCj4gDQo+IE9uIDcvMjcvMjUgMjE6NTEsIE1pY2hhZWwgVG9r
YXJldiB3cm90ZToNCj4gPiBPbiAxNy4wNy4yMDI1IDA2OjQwLCBKYW1pbiBMaW4gdmlhIHdyb3Rl
Og0KPiA+PiBUaGUgdXBkYXRlZCBib290IFJPTSBpbmNsdWRlcyBsb2dpYyB0byBpbml0aWFsaXpl
IGFuZCBlbmFibGUgU1NQL1RTUA0KPiA+PiB1c2luZyBTQ1UgcmVnaXN0ZXJzLCBiYXNlZCBvbiBy
ZXNlcnZlZC1tZW1vcnkgcmVnaW9ucyBkZWZpbmVkIGluIHRoZQ0KPiBkZXZpY2UgdHJlZS4NCj4g
Pj4NCj4gPj4gSXRzIHNvdXJjZSBjb2RlIGlzIGF2YWlsYWJsZSBhdDoNCj4gPj4NCj4gaHR0cHM6
Ly9naXRodWIuY29tL2dvb2dsZS92Ym9vdHJvbS9jb21taXQvZjllYjBiYjU3ZGVjYmFiODYwYTgx
NzEyYzU2DQo+ID4+IDEzMmMyMTAyZmE5OGUNCj4gPg0KPiA+IEhvdyB0byAocmUpYnVpbGQgdGhp
cyBvbmU/DQo+IA0KPiBUaGlzIHNob3VsZCBiZSB0aGUgc2FtZSBhcyBucGNtKnh4X2Jvb3Ryb20u
DQo+IA0KPiA+IFBsZWFzZSBhZGQgYnVpbGQgaW5zdHJ1Y3Rpb25zIHRvIHJvbXMvTWFrZWZpbGUu
wqAgSSBkdW5ubyBob3cgdGhpcyBvbmUNCj4gPiBpcyByZWxhdGVkIHRvIHJvbXMvdmJvb3Ryb20g
d2hpY2ggaXMgYWxyZWFkeSB1c2VkIGZvcg0KPiA+IG5wY214eHhfYm9vdHJvbS5iaW4gZmlsZXMg
LSBtYXliZSBhbGwgdGhlIDMgYm9vdHJvbXMgc2hvdWxkIGJlIGtlcHQgaW4NCj4gc3luYy4NCj4g
DQo+IEkgdGhpbmsgdGhleSBhcmUgcmVsYXRpdmVseSBpbmRlcGVuZGVudC4gRWFjaCBoYXMgaXRz
IG93biBkaXJlY3RvcnkuDQo+IA0KPiA+IFJpZ2h0IG5vdywgd2l0aCBubyBpbnN0cnVjdGlvbnMg
aW4gcm9tcy9NYWtlZmlsZSwgaXQncyBwcm9ibGVtYXRpYy4NCj4gDQo+IE9oIEkgbWlzc2VkIHRo
YXQuIE15IGJhZC4NCj4gDQo+IEphbWluLA0KPiANCj4gQ2FuIHlvdSBwbGVhc2Ugc2VuZCBhbiB1
cGRhdGUgYXNhcCA/DQo+IA0KDQpJdCBzZWVtcyB0aGlzIHBhdGNoIGZpeCB0aGlzIGlzc3VlLCBo
dHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvcWVtdS1kZXZlbC9wYXRjaC82MDdh
OTQzYTU4NzI0OGZiZTBmZjA4OTdkZTgwYWVlOThhMDkzY2FhLjE3NTM2NTQ1MTUuZ2l0Lm1qdEB0
bHMubXNrLnJ1Lw0KRG8gSSBuZWVkIHRvIHVwZGF0ZSB2Ym9vdHJvbS9hc3QyN3gwL01ha2VmaWxl
Pw0KSSBzZXQgIj89IiB0byBtYWtlIHVzZXIgYWJsZSB0byBzZXQgdmFyaWFibGVzIGluIHRoZSBj
b21tYW5kIGxpbmUuDQoNCjEuDQpleHBvcnQgQ0M9YWFyY2g2NC1saW51eC1nbnUtZ2NjDQptYWtl
DQoyLiBtYWtlIENDPWFhcmNoNjQtbGludXgtZ251LWdjYw0KDQozLiBVcGRhdGUgTWFrZSBmaWxl
IGFuZCB1c2VyIG9ubHkgbmVlZCB0byBpc3N1ZSAibWFrZSINCmRpZmYgLS1naXQgYS9hc3QyN3gw
L01ha2VmaWxlIGIvYXN0Mjd4MC9NYWtlZmlsZQ0KaW5kZXggNWQxM2JhMS4uNDVjMDY5YSAxMDA2
NDQNCi0tLSBhL2FzdDI3eDAvTWFrZWZpbGUNCisrKyBiL2FzdDI3eDAvTWFrZWZpbGUNCkBAIC0x
MywxMSArMTMsMTEgQEANCiAjIFNlZSB0aGUgTGljZW5zZSBmb3IgdGhlIHNwZWNpZmljIGxhbmd1
YWdlIGdvdmVybmluZyBwZXJtaXNzaW9ucyBhbmQNCiAjIGxpbWl0YXRpb25zIHVuZGVyIHRoZSBM
aWNlbnNlLg0KDQotQ1JPU1NfQ09NUElMRSAgPz0gYWFyY2g2NC1saW51eC1nbnUtDQorQ1JPU1Nf
Q09NUElMRSAgPSBhYXJjaDY0LWxpbnV4LWdudS0NCg0KLUNDICAgICAgICAgICAgID89ICQoQ1JP
U1NfQ09NUElMRSlnY2MNCi1PQkpDT1BZICAgICAgICAgICAgICAgID89ICQoQ1JPU1NfQ09NUElM
RSlvYmpjb3B5DQotT0JKRFVNUCAgICAgICAgICAgICAgICA/PSAkKENST1NTX0NPTVBJTEUpb2Jq
ZHVtcA0KK0NDICAgICAgICAgICAgID0gJChDUk9TU19DT01QSUxFKWdjYw0KK09CSkNPUFkgICAg
ICAgICAgICAgICAgPSAkKENST1NTX0NPTVBJTEUpb2JqY29weQ0KK09CSkRVTVAgICAgICAgICAg
ICAgICAgPSAkKENST1NTX0NPTVBJTEUpb2JqZHVtcA0KDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+
IA0KDQo=

