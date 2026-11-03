Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F33606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=kXLwPQg9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO8jM-0004hx-Lw; Tue, 03 Nov 2026 02:14:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xO8j1-0004UU-NM; Tue, 03 Nov 2026 02:14:38 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xO8iu-0003yl-PC; Tue, 03 Nov 2026 02:14:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xtALvLMYw8/9yvbzCPp6jgyGFvvDfma2govi/kc8Tcpp7+hTxWXZHZR7NqwAWnNZKAHzrr72e/WEJ2oKr2DGXk31x707tGL6s+z9X4uCYlAY7Sw9XFs+pHXHJTN3V+u/vozsU8mLCm7BX0LMp3bcCgcBO2g++IkIbp2e5MSQBsxlJ/DGAlCTB+lj8jaCLsS6wL7vxFb4LRVPXTw6rBYoKkYO1zMPNHZ6BapTEsCILSxkHCESOJGMsP7AaWTVT3f4t6GkCdu+E73hG1AZJKsUGdp23bRl3srQzstcb6UG+hTYdmD/qNrE9yKtJNnqYo0TXpRTvZDHI630QWfzyXaWew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITg0zpWtqw67dO/HL30blrN/GXLvdv9ic/n/2a8we2M=;
 b=ewHObis4WlPNhOPRxHG0bWwwHW9lyDWtgrQcBnRWI04h6jOMQAAhA7nNRudoyscjBnw7+Bzv/2N+cpZJ5nmrGJNAWhRU9UnSj7TBwzUV991waDBcEsiEeT4a4d90dCNMIRctWSYKHmpbCNHGO5t7A4k8U6hwA/ecqVeJhD6cEIRgdT0QAsoFXav2RcXPHp90YUlse10nroTi3YEYDIrCqe5WEgwck02D7HILKF2gJML9dExt5m9ZMig5hpXNWOlHVkBBdpd3az3jcYFXtnQh2uf9IOydZOU4gFrGU1jLrKpwSO+mPT0ki+zUQAIZ+HvulHPb4yorgTvs8S1O12xRpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITg0zpWtqw67dO/HL30blrN/GXLvdv9ic/n/2a8we2M=;
 b=kXLwPQg9z0SqER0IV1Ll+jpXe/fmL+txJ3FVuodpKLOaXlaZZLBdQ/F35q7mTXLp3gVWLlz7QQDgM+ZUCe0fVql22GCm4Go2/7pDGAmG1gzsjhFeBwFnl0PE9pInycoZiwu9gI5xVi8/SK9/fQU7kbSCuGAVOpWoyc+QszVTGMN44czKwDsIHQNx1EAeXQodL4/mPG7mU+zLMH7bvb91CWVvCff4n3jDPPL449nNKd3JU+BikfCndANIZi8hVkaxy6Tsl2BLVXCVnOB6XanFhNFZav/ILh5A/Tg2z8LaFNju6bLzYfYK+2cZXJPsZH/bpz74fImZoB0LPl8VBpK3Mw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYZPR06MB6618.apcprd06.prod.outlook.com (2603:1096:400:462::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 07:14:15 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 07:14:13 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>
CC: "kraxel@redhat.com" <kraxel@redhat.com>, "junjie.cao@intel.com"
 <junjie.cao@intel.com>, "junjie.cao@linux.dev" <junjie.cao@linux.dev>,
 "clg@kaod.org" <clg@kaod.org>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, Zhao Liu
 <zhao1.liu@intel.com>, Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>, Troy Lee
 <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v8 13/18] hw/usb/redirect-server: Announce the exported
 device
Thread-Topic: [PATCH v8 13/18] hw/usb/redirect-server: Announce the exported
 device
Thread-Index: AQHdaqupvmzo6sFN+0K1iqt887RtJLca0acAgAEdGdA=
Date: Tue, 3 Nov 2026 07:14:13 +0000
Message-ID: <SEZPR06MB7362D2A0D7F08E9D1575CA80FC692@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
 <20261102092201.1729245-14-jamin_lin@aspeedtech.com>
 <179362845017.3960472.17221122285900334594.b4-review@b4>
In-Reply-To: <179362845017.3960472.17221122285900334594.b4-review@b4>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYZPR06MB6618:EE_
x-ms-office365-filtering-correlation-id: a67f4baf-fac6-4cb4-acaa-08df397a107d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|38070700021|261021123027099003|4143699003|56012099006|261009223027099003|261028144727099003|261022075727099003|261026121527099003|261021121427099003|261026140227099003|261022105027099003|10067099003|18002099003|22082099003|261102123227099003|6133799003|3023799007|261102130727099003;
x-microsoft-antispam-message-info: F+xXHUn7bcwQgnOK3WnWsB7nZsSwIg7LWv698cU+uD+qTBmm08Df3Sv+Z49pALP5689QRSG0iQHHICha5ltP3/YqfpH5xEBEhy/ZjH/6CEqLWRAQiGQv2HOaCJNqpPrU7yDRiOrohvzNRMjUwDwq5TZfn1qeURCU0Nt/tKsJ2Fp+wXWp+xqqHWgfsGrEh0f09AA4lm23073Ze41YanxKhGxbRiQaO2nQw1TAQfmfn18rpAV178zBea33xBVJoZ2a+nXUvLVgQTDMrAqvbQeNOIPnDOOmKgralssAmyZm4Elbl6mh9t8ayddt5ob5yTFPg4kttozEsI2tEaZsrLlcZ+ebKmqHXgM1yBHAcTtc1vYZWqUDQZ2IB9ieirKTl8Nz6E1I2Y4p90oDViRNZJCdOlDiqsizx17bVLCchna1svEK4adg/XJ7kMO4WFG53CaGArq4U4w3MKcnnI9FgHjzLqexF93WhkLnJ35lvmOxV01tchZKw8k+NrysXVQmPaPG8Nt0/K1slZO/octJRHCHD32/4VRaKuvA6NGAot0JZcBi72/qbZtiB2l9TAnX5uEQztws1iaVifsvHisvZ9u4G82FjI2/1fkTJ2SVzHWNp2muKXOikYjHq03JWwFdp8ppvWS0aCjyAJLSuENxOW+b3Vv+E2l8xUnoNsiDW9HUmoqlCeZc+T+NDBhwIOoMd4QQX5hZZH8VYnidUtNRaF78EamtNGd0SgfEe1+sx7GqN4A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(38070700021)(261021123027099003)(4143699003)(56012099006)(261009223027099003)(261028144727099003)(261022075727099003)(261026121527099003)(261021121427099003)(261026140227099003)(261022105027099003)(10067099003)(18002099003)(22082099003)(261102123227099003)(6133799003)(3023799007)(261102130727099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TW0yczhpRUpNMjdEdFRxc3A5RGQ5VkhVMHJSZXJ0RHgycHdKSm53dG9QWUVT?=
 =?utf-8?B?Z1hWZDZCdE5GZlBFZzQ2ZVlLUFRZdkFwUUZrekNBajhvcmNtNDE2TkFrS0M4?=
 =?utf-8?B?aGVlbDZGWS9WMEdoaDBXMUhzNjE4b25Pd29EQ1NNWXJGZlhac1Noc3o5YWtS?=
 =?utf-8?B?WVNOWWNzdzZqNWFEMnduckVleHRKVDlnL291Y1FqUEtnMW95WmdLVE0yNk1T?=
 =?utf-8?B?VDN4WUVqakZFbHBRT2dQaElacVBsRnlRRzVSUnVPN1B6SnRxQXA0eThvbHVj?=
 =?utf-8?B?d2VuTVNic01zZ2xUaWUzbFFnV3pSMkxzYW5RV1Zpa215WXAvTEdnVU15OGp6?=
 =?utf-8?B?U0VwdUMrcjJKT1pKOGdtQ2Rla3NUQXUzYUx2djd6MmxFdEUxWEUvSGFvK0pV?=
 =?utf-8?B?VlpwSUxocDE4K094UWZsVUdmV0t3NGZoM2xMYzI4N3NTQ09HYUIxNFRaOEJL?=
 =?utf-8?B?SVVRbWNzT1hFUnFDRi9pVDdCWjU4RitBZXdwYnpmMVlzTU5tYUdsZXV3T0Fz?=
 =?utf-8?B?RXNMS0pNQnpvV09vVmljZHllZUZjQ05oRUpNMlhXa05WUkpZTHJhTU92clpr?=
 =?utf-8?B?MkZSeDhTcDNjYjNxNGNtb0Y5bFR3TDNqa0tYSUQxZG9MSDZwdVF3UjZjSHIx?=
 =?utf-8?B?NDkxUGVZR1ZITHVvMjh1SXBKcEJpWGd6RktlT0dPQllIT3N6ZC8xeE5EVnN0?=
 =?utf-8?B?NjVCUHdjd1FVMm1jVlZ5MzMxOEswTWw1b1hmMkFISjBjYmJYL2h1VnVvZEJt?=
 =?utf-8?B?Yi9PdWRXRzI4RzRXOVNsR2JYRERXV2UrUDByZlhMNlhmZi8rU0U3K2YrRW4y?=
 =?utf-8?B?azlOQUR4YkJjU2t0TVZCV0E5RG1haDlDbkRvNlc1ckhsY1d4YWZOWFIrSkd6?=
 =?utf-8?B?WU1oNWhTOUpTL0doUitkL0hGUUcvN0NtdmlMbjVqbmxORlVBblBrd2p6UWRx?=
 =?utf-8?B?UUV0Y05ObndhY3lmL3hHZkgwa2dXck02NHdqRGlENFU2SEFYVHFDSjFmQzVS?=
 =?utf-8?B?bmQ5VGtZcGhZM1JNaWtkSkZ4MDhELzQ2YWNhbmZXeWo4eGIyZTZYTWpJMGJS?=
 =?utf-8?B?OWtyTkZHQjhOS05aOGYvbTA1Q0s1cDlETVR0THg0dG5IVmdSMmdiQUllb3pw?=
 =?utf-8?B?U2pmNjFqVnN3NjN3RHdidXZvYm9nSDB2Rkltdzdna1lNd0pCR2YzWXhJVmZv?=
 =?utf-8?B?WGRjdU1vbU13cXBHOHpsZGZpYUpLT3g2RG5aSHNhaERFZVcrTGNIc3FnanQv?=
 =?utf-8?B?ZFZKbC94SlBQMktQWTZCYWdYWU9MQTMzMmYzUEdtZHA2Rm8wZmlnMC9SNVI3?=
 =?utf-8?B?VUNqcGdwZHhKdFd4cVhjNHo0M2Z1YjFSWUxKaU5lUFZub09PT2FJNXlXL2ZC?=
 =?utf-8?B?dS9rOCt5U0gyclczMVhzZU1PMmNCZUF5UytzUGJMZmFkV3EwNmRSVWQvRmUr?=
 =?utf-8?B?OS9MYlJ2UVdwWVdPdFRkSFBqNGpWa2NTVTR3Y3ZLWkNqSmtwY3lMcjJiZS9v?=
 =?utf-8?B?NjhMSlY0aTYybVQxMlBTTlh3ckk2dGlSQ2hPVC9HTTNZWVFERGVXOC9IMS9o?=
 =?utf-8?B?WjJGMlV1MVlyVmRYTGdmeGdzTzBoU1FmQ25uM2F5STQ4VlB3OFZxTWRXQUxl?=
 =?utf-8?B?SjZaMGtrampZYUhHZi9GaHpIWUx1VHJUS3J1RHdsMVJyNk1FWTVkRTdnYWtR?=
 =?utf-8?B?VkxCTUt5YWRyQ2pvQWtyRWRkdTg0SjRWcVpyb3VJeVI1WVdXZE53cmpMOG5I?=
 =?utf-8?B?ZW1CT09SajhNbVc2QmpjSUg2MjVpYS9RMmZSUk1IckZMRHBqbThXNEN1UzJD?=
 =?utf-8?B?bDJWaXVKSXducDRKK3hFaE04Y25Wci9OMUdEb0lHanZHTjNreEt5VjZwckNO?=
 =?utf-8?B?cUNGcnJ4RWMyY3lVQ00yd09Xc3ZuNW1mMHZnNU12YmxLc3d3S2ZqZUFBOVcv?=
 =?utf-8?B?MkgreFFaNjMyYXgvY2J5bTUwVzhrdWhjcWhFQ08vM3FkZmRuT1RxR3RGbmQ0?=
 =?utf-8?B?VmQvUnhrYkJOWkI0R1BESmVJc0tBV0FrUy9nck1WSzQ0NTFTMUg3dWFtY3RK?=
 =?utf-8?B?S2I5Rm51NFZEbkQ5cStkWHB2THhPRnN0aVpIR3hpSFZXL3VhNmwveXY0WDhN?=
 =?utf-8?B?bVViVnREZjR5Rm9PSEVzREpwV1lYenhHbVMwMUxVRGVxL1pHY3YxdFlIL1lD?=
 =?utf-8?B?OHhWaER3WDIrTEdhSHFiZDNOTXcvMzdXR2tFNk5GNWVqMGlSYmFKSDJvdWNK?=
 =?utf-8?B?NS9SN2VQdDNwaEpKZWZISmlWWE1YaUVxRUh0OHVzcjNEQXZhMzZpeTdENTRw?=
 =?utf-8?B?eUpaQTZUejdyZlY5RWVnRlp0MllDSWFwT29xN0xyM0NpMzdTWmRKQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZHdyqFa3ZSsweMYnzqY5roqJSiO+XN3CDuW0UoO+ulquZrO0Yi6bCkv2SSVJGIHJ9LvlpSS2c3T8umdM20pvYai8M5xGtQAWAftb36akFxPo6W5oOzDYZ1Bix5ivh+DUwBAYI10pz7In5N3WWQSKVKSFqOik/+app4KskNUFmWFlqTtGjmdKJTjCQ8pYvbWOcJBRM5bx7My5lxcxABbiOgEMqDnmPJ7msNXF96TIzK0yK82lfGvVYdQ4AyjrKKZx63W/ITOYMqpf4kjjFH6+bQDJuOSwHDJIOYf7qg57IUFqw2bR92AtloYVeC1IoBa1947Osf37j7ght047kUhsnQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a67f4baf-fac6-4cb4-acaa-08df397a107d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 07:14:13.4918 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DT3aSa73cGEwJxYBRarMzuDe+XkOdPZ4IihNWjZWd4bL4usmUVm3ZkYvWlOb/Y9QyUgs4359fm3BhFhEeRKib26OuRjomFYrAzUnI3bZRac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6618
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgTWFyYy1BbmRyw6kgTHVyZWF1DQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2OCAxMy8xOF0g
aHcvdXNiL3JlZGlyZWN0LXNlcnZlcjogQW5ub3VuY2UgdGhlIGV4cG9ydGVkDQo+IGRldmljZQ0K
PiANCj4gPiBTZW5kIGRldmljZV9jb25uZWN0IHdoZW4gYSBkZXZpY2UgaXMgYXR0YWNoZWQgYW5k
IHRoZSBob3N0IGhhcyBncmVldGVkDQo+ID4gdXMsIGRldmljZV9kaXNjb25uZWN0IHdoZW4gaXQg
Z29lcyBhd2F5LCBhbmQgaGFuZGxlIHRoZSBidXMgcmVzZXQgdGhlDQo+ID4gaG9zdCBzZW5kcyBi
ZWZvcmUgZW51bWVyYXRpbmcuDQo+ID4NCj4gPiBkZXZpY2VfY29ubmVjdCBjYXJyaWVzIG5vIGlk
ZW50aXR5LiBUaGUgcGVlciBhc2tzIHRoZSBkZXZpY2UgaXRzZWxmDQo+ID4gd2l0aCBHRVRfREVT
Q1JJUFRPUiBhcyBzb29uIGFzIGl0IGVudW1lcmF0ZXMsIHNvIGFueXRoaW5nIHdlIHB1dCB0aGVy
ZQ0KPiA+IHdvdWxkIGJlIG1hZGUgdXAuIFRoZSBzcGVlZCBpcyByZWFsOiBpdCBjb21lcyBmcm9t
IHRoZSBkZXZpY2Ugb24gb3VyIHBvcnQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBM
aW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiBNZXNzYWdlLUlEOiA8MjAyNjExMDIw
OTIyMDEuMTcyOTI0NS0xNC1qYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4g
IGh3L3VzYi9yZWRpcmVjdC1zZXJ2ZXIuYyB8IDE1MA0KPiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKy0NCj4gPiAgaHcvdXNiL3RyYWNlLWV2ZW50cyAgICAgIHwgICA3ICsr
DQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTU2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody91c2IvcmVkaXJlY3Qtc2VydmVyLmMgYi9ody91c2Iv
cmVkaXJlY3Qtc2VydmVyLmMgaW5kZXgNCj4gPiBmNzgzNTFiZGU5MTkuLmUyMDdmNWE3ZWI1NiAx
MDA2NDQNCj4gPiAtLS0gYS9ody91c2IvcmVkaXJlY3Qtc2VydmVyLmMNCj4gPiArKysgYi9ody91
c2IvcmVkaXJlY3Qtc2VydmVyLmMNCj4gPiBAQCAtNTYsNiArNTYsNyBAQA0KPiA+ICAjaW5jbHVk
ZSAicWVtdS9tYWluLWxvb3AuaCINCj4gPiAgI2luY2x1ZGUgInFlbXUvbW9kdWxlLmgiDQo+ID4g
ICNpbmNsdWRlICJtaWdyYXRpb24vdm1zdGF0ZS5oIg0KPiA+ICsjaW5jbHVkZSAicWVtdS9jdXRp
bHMuaCINCj4gPiAgI2luY2x1ZGUgImh3L2NvcmUvc3lzYnVzLmgiDQo+ID4gICNpbmNsdWRlICJo
dy91c2IvdXNiLmgiDQo+ID4gICNpbmNsdWRlICJjaGFyZGV2L2NoYXItZmUuaCINCj4gPiBAQCAt
ODUsMTcgKzg2LDEwNSBAQCBzdHJ1Y3QgVVNCUmVkaXJTZXJ2ZXIgew0KPiA+ICAgICAgLyogdXNi
cmVkaXIgb3ZlciB0aGUgY2hhcmRldiAqLw0KPiA+ICAgICAgc3RydWN0IHVzYnJlZGlycGFyc2Vy
ICpwYXJzZXI7DQo+ID4gICAgICBRRU1VQkggKmNoYXJkZXZfY2xvc2VfYmg7DQo+ID4gKyAgICBR
RU1VQkggKmFubm91bmNlX2JoOw0KPiA+ICAgICAgY29uc3QgdWludDhfdCAqcmVhZF9idWY7DQo+
ID4gICAgICBpbnQgcmVhZF9idWZfc2l6ZTsNCj4gPiAgICAgIGJvb2wgaW5fd3JpdGU7DQo+ID4g
ICAgICBndWludCB3YXRjaDsNCj4gPiAgICAgIGJvb2wgaG9zdF9jb25uZWN0ZWQ7DQo+ID4gKyAg
ICBib29sIGRldmljZV9hbm5vdW5jZWQ7DQo+ID4gIH07DQo+ID4NCj4gPiArLyoNCj4gPiArICog
VGhlIGRldmljZSBpcyB3aGF0ZXZlciBVU0JEZXZpY2UgdGhlIHVzZXIgcGx1Z2dlZCBpbnRvIG91
ciBwb3J0DQo+ID4gK3dpdGgNCj4gPiArICogIi1kZXZpY2UgPGRldmljZT4sYnVzPTxpZD4uMCIu
IE5VTEwgdW50aWwgdGhlbi4NCj4gPiArICovDQo+ID4gK3N0YXRpYyBVU0JEZXZpY2UgKnVzYnJl
ZGlyX3NlcnZlcl9kZXZpY2UoVVNCUmVkaXJTZXJ2ZXIgKnMpIHsNCj4gPiArICAgIHJldHVybiBz
LT5wb3J0LmRldjsNCj4gPiArfQ0KPiA+ICsNCj4gPiArLyoNCj4gPiArICogRGV2aWNlIGFubm91
bmNlbWVudA0KPiA+ICsgKi8NCj4gPiArDQo+ID4gK3N0YXRpYyB1aW50OF90IHVzYnJlZGlyX3Nl
cnZlcl9zcGVlZChVU0JEZXZpY2UgKmRldmljZSkgew0KPiA+ICsgICAgc3dpdGNoIChkZXZpY2Ut
PnNwZWVkKSB7DQo+ID4gKyAgICBjYXNlIFVTQl9TUEVFRF9MT1c6DQo+ID4gKyAgICAgICAgcmV0
dXJuIHVzYl9yZWRpcl9zcGVlZF9sb3c7DQo+ID4gKyAgICBjYXNlIFVTQl9TUEVFRF9GVUxMOg0K
PiA+ICsgICAgICAgIHJldHVybiB1c2JfcmVkaXJfc3BlZWRfZnVsbDsNCj4gPiArICAgIGRlZmF1
bHQ6DQo+ID4gKyAgICAgICAgcmV0dXJuIHVzYl9yZWRpcl9zcGVlZF9oaWdoOw0KPiA+ICsgICAg
fQ0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCB1c2JyZWRpcl9zZXJ2ZXJfYW5ub3Vu
Y2VfZGV2aWNlKHZvaWQgKm9wYXF1ZSkgew0KPiA+ICsgICAgVVNCUmVkaXJTZXJ2ZXIgKnMgPSBv
cGFxdWU7DQo+ID4gKyAgICBVU0JEZXZpY2UgKmRldmljZSA9IHVzYnJlZGlyX3NlcnZlcl9kZXZp
Y2Uocyk7DQo+ID4gKyAgICBzdHJ1Y3QgdXNiX3JlZGlyX2ludGVyZmFjZV9pbmZvX2hlYWRlciBp
ZmFjZV9pbmZvID0gew0KPiA+ICsgICAgICAgIC5pbnRlcmZhY2VfY291bnQgPSAwLA0KPiA+ICsg
ICAgfTsNCj4gPiArICAgIHN0cnVjdCB1c2JfcmVkaXJfZGV2aWNlX2Nvbm5lY3RfaGVhZGVyIGNv
bm4gPSB7fTsNCj4gPiArDQo+ID4gKyAgICBpZiAoIXMtPmhvc3RfY29ubmVjdGVkIHx8IHMtPmRl
dmljZV9hbm5vdW5jZWQgfHwNCj4gPiArICAgICAgICAhZGV2aWNlIHx8ICFkZXZpY2UtPmF0dGFj
aGVkKSB7DQo+ID4gKyAgICAgICAgcmV0dXJuOw0KPiA+ICsgICAgfQ0KPiA+ICsgICAgcy0+ZGV2
aWNlX2Fubm91bmNlZCA9IHRydWU7DQo+ID4gKyAgICBjb25uLnNwZWVkID0gdXNicmVkaXJfc2Vy
dmVyX3NwZWVkKGRldmljZSk7DQo+ID4gKw0KPiA+ICsgICAgLyoNCj4gPiArICAgICAqIFRoZSBk
ZXZpY2UgaGFzIHRvIGJlIGluIERFRkFVTFQgc3RhdGUgYmVmb3JlIGl0IGNhbiBhbnN3ZXINCj4g
PiArICAgICAqIGFueXRoaW5nLCBzbyByZXNldCBpdCBoZXJlLg0KPiA+ICsgICAgICovDQo+ID4g
KyAgICB1c2JfZGV2aWNlX3Jlc2V0KGRldmljZSk7DQo+ID4gKw0KPiA+ICsgICAgLyogU2VuZCB0
aGlzIGJlZm9yZSBkZXZpY2VfY29ubmVjdC4gVGhlIHBlZXIgbmVlZHMgaXQgdG8gYWNjZXB0IHVz
LiAqLw0KPiA+ICsgICAgdXNicmVkaXJwYXJzZXJfc2VuZF9pbnRlcmZhY2VfaW5mbyhzLT5wYXJz
ZXIsICZpZmFjZV9pbmZvKTsNCj4gDQo+IFRoZSBwZWVyJ3MgdXNiLXJlZGlyIGNsaWVudCBldmFs
dWF0ZXMgaXRzICJmaWx0ZXIiIHByb3BlcnR5IGFnYWluc3QNCj4gZGV2aWNlX2Nvbm5lY3QgYW5k
IHRoaXMgaW50ZXJmYWNlX2luZm8uIFdpdGggaW50ZXJmYWNlX2NvdW50ID09IDAgYW5kIHRoZQ0K
PiBhbGwtemVybyBjb25uZWN0IGhlYWRlciBhYm92ZSwgYW55IG5vbi1lbXB0eSBmaWx0ZXIgKHZl
bmRvci9wcm9kdWN0LCBjbGFzcyBvcg0KPiBpbnRlcmZhY2UgcnVsZSkgcmVqZWN0cyB0aGUgZXhw
b3J0ZWQgZGV2aWNlLiBGaWxsIGludGVyZmFjZV9pbmZvIGZyb20gdGhlIHNhdmVkDQo+IGNvbmZp
Z3VyYXRpb24gZGVzY3JpcHRvciAoaW50ZXJmYWNlIG51bWJlciwgY2xhc3Mvc3ViY2xhc3MvIHBy
b3RvY29sKSBhbmQNCj4gZGV2aWNlX2Nvbm5lY3QgZnJvbSB0aGUgbG9jYWwgVVNCRGV2aWNlPw0K
PiANCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3IGFuZCBzdWdnZXN0aW9uLg0KDQpJIHdpbGwgcmV3
b3JrIHRoZSBzZXJpZXMgdG8gcmVhZCB0aGUgZGVzY3JpcHRvcnMgZnJvbSB0aGUgZGV2aWNlIGlu
c3RlYWQgb2YgaGFyZCBjb2RlIDAuIFRoZSBob3N0IGhhcyBubyBkZXZpY2UNCnVudGlsIGRldmlj
ZV9jb25uZWN0IGFycml2ZXMsIHNvIGl0IGNhbm5vdCBhc2sgZm9yIGFueXRoaW5nIGl0c2VsZi4g
VGhlIHNlcnZlciByZWFkIHRoZSBkZXNjcmlwdG9ycyBpbiB0aGUgDQphbm5vdW5jZSBwYXRoIGJl
Zm9yZSBpdCBzZW5kcyBkZXZpY2VfY29ubmVjdC4NCg0KSSB3aWxsIGFkZCBhIHBhdGNoIGZvciB0
aGlzIGFuZCB0aGUgcGF0Y2ggb3JkZXIgd2lsbCBiZSBjaGFuZ2VkLg0KDQpUaGFua3MsDQpKYW1p
bg0KPiAtLQ0KPiBNYXJjLUFuZHLDqSBMdXJlYXUgPG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNv
bT4NCg0K

