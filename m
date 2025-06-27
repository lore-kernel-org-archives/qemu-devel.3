Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 795C8C7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 09:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV5Co-0008My-RH; Fri, 27 Jun 2025 05:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uV5C4-0008HX-EG; Fri, 27 Jun 2025 05:16:30 -0400
Received: from mail-japanwestazon11022123.outbound.protection.outlook.com
 ([40.107.75.123] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uV5Bv-0000rf-05; Fri, 27 Jun 2025 05:16:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AuIUt9Y9MRNoLu+Y0CDO2yXkEzsDYHfnI6FeH8v/WdxEIXI8pb+PMWNJka4as7YABkLGjaD07WtoUr+V8PH1Lj0SUKpV98dIfRLnesdo3rlbRdJUJNqY16UAvrx9Y3vCGzT3qRWtjrceZPq+Loppw05/jNpCCOnGJIVbRkWzrEo/5BY/Wl0gudA3svh3OUdBEEZGMSxjT4HlWwT3Uu1qHkkI6nTiP4jatuvEkxUqOia1nxIc4unCxsRyNHI4Q2OhoDRPKPK+EL2Z2rhWEq6UZ0wkMsvjNCWqLKMiWgFqEqKx9A0xnjxeB/iifmVwOduLl6ulcm24NYsqhLMshfOGTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZdNgcKurjhCeSpTbXLgZ4zqTbT+m7RpDIRw7+ljg9c=;
 b=zDbyHQziTB2V+XPu76gu7WmMEy/6FCwHaEgTroFttHYMd7RxzGjh3HCq2K3Fjv0YrsDqa77JNdzRLuUIcreAwsJS5bUVDrvc6NEfmela6kqCLMlEm/birug71/SU5ZcripeB6dyjB38SxmMcoX/9pPzZ4Baql8muTl+V1u85taShKvNf4EX/mmW501/GGnklFgrcWNml/L+A2dztGdBzwQytzJaILL2HxAz31n1bQwS/BhfmHItcTq54RBq9S5I+7oVTlkhCmdPqqFPUgE89383dYPsP1eGQg3Sn6ZWQbzDoEgtM8fzdPjgHvCQPdio4HKtarsq97XNNEE3wzwWJvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZdNgcKurjhCeSpTbXLgZ4zqTbT+m7RpDIRw7+ljg9c=;
 b=UcMqnNwWuT1K3ngsDs6XJS7wlri6WCKaZOd0TL/ejoeIsHdXLeqhDmwAhXiTRzOV03cC3awIA9cgklxquoOb1VsYxJkRVugrC8r50W4IDapgsUqqwGVamBn8HkltE2zmaDKkXcijI51AEyrLh8tRbq0905HFzZbdAaUCnAwR804hyIWg+Apdht7OgS+YjHwJTiAC0O+P5OXSNk8egTJdH4gQKwMnxaCpjldLC+LaxzM39n6s/AWNufkGNNQOl5UCQro22UvW/0jkbA4vInzbvu9CAG4ACVZisKWo5684d43slLsICPfzeGcewmjE7BGL7lth0xOsEG8xIVHoV1jkZA==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by KL1PR06MB6109.apcprd06.prod.outlook.com (2603:1096:820:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Fri, 27 Jun
 2025 09:09:17 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%7]) with mapi id 15.20.8857.026; Fri, 27 Jun 2025
 09:09:16 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v2 0/3] Add QEMU model for ASPEED OTP memory and integrate
 with SoC
Thread-Topic: [PATCH v2 0/3] Add QEMU model for ASPEED OTP memory and
 integrate with SoC
Thread-Index: AQHb5w8KWgEuqTGqFk+AltmPPmaaibQWkd6AgAAb8AA=
Date: Fri, 27 Jun 2025 09:09:16 +0000
Message-ID: <SI6PR06MB76312CBD36E8204DA851E454F745A@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20250627025606.631167-1-kane_chen@aspeedtech.com>
 <673b668f-b374-432c-b1e0-19a9977f6f14@kaod.org>
In-Reply-To: <673b668f-b374-432c-b1e0-19a9977f6f14@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|KL1PR06MB6109:EE_
x-ms-office365-filtering-correlation-id: 8744dc6c-523b-491b-478a-08ddb55a4b26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QmJvT0VEdmZQS2ZGSTJTbUpvNGgreDZFNHpPRTgrNkNKVnJjcHhlaFFuUDNq?=
 =?utf-8?B?WmpVaUY2LzVnSHIrd3lnZ1czUTJMWStGdUFzNjUvTzk0U1dKaHA3MVZ1bm9S?=
 =?utf-8?B?SlZ3clRUY2dySFdoa1ROM3hCOHFKY1dFQWdwQ25JQThvUy9RVWo5RlU0RlNt?=
 =?utf-8?B?aGZxQUdaZDBqRVF2bVA2cSt0U0JUb2NHdk1ZRW9jd1ZYSGM2S2d2Z3dZTEE2?=
 =?utf-8?B?UHFwWkVMcjU2N2RNdVZRMFlSSmFyNTYwcVdXOXBXRElFY0p4L0p5c1JDMkdE?=
 =?utf-8?B?cldjNCtDWFZqNTFKSGhkaUo3enM3U0trSXVDTTdCNTgrL1J4bWdhSGJKaFdB?=
 =?utf-8?B?djFoYzVHY28yTnI2L2tseEIrci9yWUlWcEJaVVFBeVpkVDY2VXQzYTFhN2xu?=
 =?utf-8?B?Vkx6N1lxUkdJeldOQWU5UThmMWkwQUFTU0VyVTNRb2NQbzhRVGFvQ2RmWmIz?=
 =?utf-8?B?TENQKzlSdXhkOHhPbjFCSkhROXZ3SGpKVVBRdEN4aFRhSFRCY09DMmQ3amEr?=
 =?utf-8?B?WDJQMkIxaWUvS1puU1NWdkllMFVUVW1jTXdnbWNUTHVnS2pVMnRiS0plYkNH?=
 =?utf-8?B?NG42VURLY1lOSW9HQjNOM3BObUdRZEMrdHU1eGV5a2pER2RJSVg3aWYyaHV5?=
 =?utf-8?B?dXNRVXhnazFJbmEwdng0UGxDMVpZcDEyeVM4RUw1VmRtTldoOUhYMCtIYXhv?=
 =?utf-8?B?bDM4ZWtZYTVId3BHamlkb00vSGorMWt1TmF1Q1BBODlRVFF4RHFkcHpHVWE5?=
 =?utf-8?B?amlzeFgrY1YyempObVlkdnVLVGtUY3FkOVRXVFhRSDFLRDJNdU05cTFoWXpO?=
 =?utf-8?B?TzFHWmUwUWZHTndmUkpGMXpHSG9TRFhIaTUxYTNzWWNLY3N0dHhKUTE1M0hD?=
 =?utf-8?B?eFVzUzhFeUprNlJPU2FMUDh0enZGUWZCVXFseXd1SitZc09iQTNHVjVab24w?=
 =?utf-8?B?UXJvUkNiSUpCYndLVHFrdFVzNHdoMHd6TTY4OTFGc1NqVWlocE5OZDZndnNa?=
 =?utf-8?B?TllPQzREQkRxTk15Z3RERnNKUXUyRVlnMmVDRFVBanMzZkxnZU5jSzZ6SWZH?=
 =?utf-8?B?aXFRb08xQ1RNMWUyM0hveUhhQlhYVGwzQUI4RVlCK2d4V0FQQmtXRlQxTG5x?=
 =?utf-8?B?dS9FNU4wUGJmbnBWaGZ0VjBla2k0M1hub1QyNlAvcTZXSng0aHZUUkMzRzJh?=
 =?utf-8?B?a1JhemRseGJEWWwxbUVyZHJHb3daQmJIS09veXY0ZkdOS3F0UUM2WmkxOUZ3?=
 =?utf-8?B?MzBzckpLanNabnVJU2I5cVU5SFlOZGJ5MFJTdkcvc1J4S2F6eXJwYldMT2Vi?=
 =?utf-8?B?RlVRaGZQUGJzUUNOVlJhWnNKaFprUVNxM2NyU0hhQWdMdU9UdGZqaDVpVVRj?=
 =?utf-8?B?L2tDRzljN3BjR0ZiakllS3ZSa3F2NzM3VFVQdEZBWTlVL002RjdOSmdYcTlO?=
 =?utf-8?B?MzllTkRGV3NDZWxhQjlFUzVLMXgvaldtaVd2QzM2d3AxRXJ0eGk5eksvaDFE?=
 =?utf-8?B?UEo3MkdVd0VtUFNSMFU3dTFEMlQ4aUJLQit3Umhrbk5kODdTRDBvaUcyN2NS?=
 =?utf-8?B?ZlhHQWlQbDNkRERKWURQbktsRGFOR0ovZ1A2Q2g2WXFqWXdHak5uVmt6dGVn?=
 =?utf-8?B?K3Z1VTFzSUh0Ujg2SkU2Nk8vdmRDS1UvWFgrb05nTkhXa3FJUms4bXBDMlJy?=
 =?utf-8?B?ZTVGcDJTMFZPYXhQc0I2L3pOV1ZGVnpVSU5JNjFieWFrRHg0WjR4VS93ckdE?=
 =?utf-8?B?dndGLzF0RU5JL1YrSWFEQjhDNGdlL2dGL0pBL0FKWGJ3TkNaeElSc1VrK0ZJ?=
 =?utf-8?B?Q09DVjIvUHVoaDFtemtXNU02Z0EvQkc4MGxQVEwvWWgveDZhbVY2ZzdFdGtT?=
 =?utf-8?B?RFZ1ZjJpMURFWmxYZTJRQnE2cDlyUnVWR01mWk9sS1BWbEg3U2l6MVI1eGtw?=
 =?utf-8?B?Tm02WTVxRlI5UG8rcGdtZU9FMFdlK2p2VkRLWXhtSVdFeGhGSlZ2TWFLMWNn?=
 =?utf-8?Q?D/KvBkdaptHtptP8UbHGnUZXfONVD4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OSs0VWZoeHVXR1lHMzlkWEdoLzgwOFFrZjBZR0kxaWxpbVpqZ3JING5aVlFS?=
 =?utf-8?B?dDE5YmF3d1YzcUhia3pPQWZJZHQ4OXA1TnRHVEw5OTlNcU9KT2p1UERqVDFl?=
 =?utf-8?B?NHRKcnJTanZMaUgwZ3FrM3Q0d090UjZSSHFWdFVwWmpia1piK1dWZjl4UVdr?=
 =?utf-8?B?SFg1WTl5U00zTHJIaEZPNXVIYzl5NHllbkJTSkRIbm9zRURpQ0gwcEpSbVVL?=
 =?utf-8?B?VUlGWGpkbTRzTDArdjExNFBHbU1wTktYNHptZmZZcEtiY0NYTHBJZFAwREFY?=
 =?utf-8?B?Y2dMMVdiMlErS3RrOCtGWktMeW9qNFJrNFMvN0RTTndMQ3laR2Nwa2xnMHRK?=
 =?utf-8?B?RnhHbnU2V2xhOFVZSWdRaHVDTWpPdys3NEtmUWJqUVFSS2c5MzNYTkRER3h3?=
 =?utf-8?B?eldKc2gvVjB0aVdORnhQSUZDcmpzRHYrcmZrWXlGa2Nabm5VYW1Zc3MrbTdy?=
 =?utf-8?B?dWJza3hVK2RENldUaWx1SEpMYTQ2cEQ4ZVQvQzhIcm41VTl1THFHSFBZalVT?=
 =?utf-8?B?blY4eEppMlQ1Ym5wRWRVYnpJeHBkM29QZ00vQUJpVHBMSnZ5ZUJuSEI3SWZL?=
 =?utf-8?B?bURNMnFzdlV4SCtySG9xY05raU5VUlU4dUhOcXBCRHVkaGFkWFlTVUNkaU43?=
 =?utf-8?B?dFNnbjhjaVlQNXVjWi95a3pOemQvT0JIa1BMcDliVzhLSk9zKzlsc0o0QVRE?=
 =?utf-8?B?aVcvVzRWVkY4TnNpNjBkSmt3KzN6Q2ZKdllTRlE0Y2NlUlQzaDJhaHFWbjll?=
 =?utf-8?B?UGVqUG1tUE9aWmc4b21Lb1lFL0M5aU5oSHpneDJUQ2RNQUxBMSt6SGFNYTNs?=
 =?utf-8?B?UUprbDF1U3lqQ2N4V0FMRUs1Ly9hRng1RUprd0VnbkpnWkZkM3J2Q0paWkhL?=
 =?utf-8?B?Z1Nyd3dWQTBaUnNlcENKek9ibi9RcVRhSHlLVHlvQjB2enRvV0N1N3A2SHND?=
 =?utf-8?B?eXhLU0hQN3B5ZEI0NzBnQUpRU3YzV3lwT2dNYytsQytVQURCSk1EaU9BUzhU?=
 =?utf-8?B?WVNsQS9TWGhOWndCTUtFWDd0S25abGFoRFozR3dxN0ZjU0syTGw5Q0JlOERH?=
 =?utf-8?B?clN0cGhvM2ovVThkcng1eUhWMzJkV2pGa1pBaWFKNUpBMUNrcjVOVkFtVlBL?=
 =?utf-8?B?dVV3NG9ZYTVoSlFuNks5NWtCUllWaFNCS3RQSExaL2VZTW1rTE1UYlNvSDV0?=
 =?utf-8?B?a1NUSnI3MStuQTBPeVFaT1FDdndZQXFhaE5hbjJWV1lMdFdiOVR5R0xIMDJu?=
 =?utf-8?B?cXFQam1SVEtMK3YzaW82SCtTMWFJSmZKRS9zYzR6Sk1pN2VoTnF6anYzeEpT?=
 =?utf-8?B?MzU5RFZBcGgwZU1zOThwU0UzNmN1MDh6ODNuOWVJU1JEYk4wQ1YySGhPQjJF?=
 =?utf-8?B?V3RUMHU0NDFEdTcxZkVUWmo2cW0ydDV3SDhUR3pzbGNuL1VPbXQ5N21Jbjhz?=
 =?utf-8?B?cDkwUzhzMW4wSGd3cngzVVRSSURIK3pkOEh2SFJzY0JxYW9nbHdXRXNTZFZp?=
 =?utf-8?B?R2RpUE9LcGhobGk4ZTBTSTRucUlxS0JadHdlcUVCOEh0NmxNU3NLaWt0dXdm?=
 =?utf-8?B?WWpHYTliaXo5NlU2NURZTkMxaUp0dTMzT0ZQdzVQZ1hnazRaaXU3Y01yNmF5?=
 =?utf-8?B?SmhxcklhZE5yd1BjZnI3c3J6OWExV0xGMzlORFQ3VTh5dkFmb2ZNUVZjKzNo?=
 =?utf-8?B?R3dlN1RWODJYMVZuMVdKTzkyOEtJMjBnZVBXckVGQzk3VGdWSkFFbWc2NlNn?=
 =?utf-8?B?MXRnTHYvZVhaZ280RDlNN1A2UjhVSHVkaVF2amZxeDFuY2xvcHJ0MU1aSmZN?=
 =?utf-8?B?cjcrRFVwcUx6R3JndWFQOXVLNGJJY3IxbWRuMFd3d2xmNDVtMkZHclNRejY5?=
 =?utf-8?B?N0Z3MEpMZkhRWVZldUxJeDRGbWQ2cnA3anZRMW9GLzA5ejdUNUxvMWFWL3FL?=
 =?utf-8?B?cXluQkJiZEJjbnVnUFhoekhvL2FOMVBJWEkyVTlqZHJHMlZERzhReU0vSU5j?=
 =?utf-8?B?VjVLUjhZcE4yQWIwZVlsZmNkWXkvdEgxTVNQMEd6N2cwM3oyNWE3NXoxMXdw?=
 =?utf-8?B?Um5qMkRRc2N4NTYvN1hnbWRKU0p0R0t1KzlIRzJ1QzNSTjB5Sm0xNnBZMWV3?=
 =?utf-8?Q?EeBHJKouZr/h26EZErE2GdJLm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8744dc6c-523b-491b-478a-08ddb55a4b26
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2025 09:09:16.8711 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qyQ+bsisuVezF1dIo0fWqlnJdkrES/GONa6V1M7+HEm2VP3du/14ybrXHn7DGco2Fagvpg+l925tZ3t4fr6HbDDaj5HVPV93hNcaCfFTgXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6109
Received-SPF: pass client-ip=40.107.75.123;
 envelope-from=kane_chen@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

SGkgQ8OpZHJpYywNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlld2luZyBhbmQgY29tbWVudHMuDQoN
ClJlZ2FyZGluZyB0aGUgZHJpdmUgcHJvcGVydHkgYW5kIGJsb2NrIGJhY2tlbmQsIG15IHVuZGVy
c3RhbmRpbmcgaXMgdGhhdCB0aGUgZm9sbG93aW5nIGNoYW5nZXMgd291bGQgYmUgcmVxdWlyZWQ6
DQoNCjEuIEFkZCBhIEJsb2NrQmFja2VuZCBmaWVsZCBpbiBBc3BlZWRPVFBTdGF0ZQ0KMi4gUmVn
aXN0ZXIgYSBkcml2ZSBwcm9wZXJ0eSB0byBhc3NvY2lhdGUgdGhlIGJhY2tlbmQgd2l0aCB0aGUg
ZGV2aWNlDQozLiBMYXVuY2ggUUVNVSB1c2luZyBjb21tYW5kLWxpbmUgb3B0aW9ucyBsaWtlOg0K
ICAgLWJsb2NrZGV2IGRyaXZlcj1maWxlLGZpbGVuYW1lPW90cG1lbS5pbWcsbm9kZS1uYW1lPW90
cCBcDQogICAtZGV2aWNlIGFzcGVlZC5vdHAsZHJpdmU9b3RwLGlkPW90cC1kcml2ZSxzaXplPTE2
Mzg0IFwNCg0KSSBoYXZlIGEgcXVlc3Rpb24gcmVsYXRlZCB0byB0aGlzIHNldHVwLiBXaGVuIHVz
aW5nIHRoZSAtYmxvY2tkZXYgYW5kIC1kZXZpY2Ugb3B0aW9ucyBhcyBhYm92ZSwgUUVNVSB3aWxs
IGluc3RhbnRpYXRlIGEgc3RhbmRhbG9uZSBhc3BlZWQub3RwIGRldmljZSBiYXNlZCBvbiB0aGUg
Y29tbWFuZCBsaW5lLiBBdCB0aGUgc2FtZSB0aW1lLCBvdXIgY3VycmVudCBpbXBsZW1lbnRhdGlv
biBhbHNvIGNyZWF0ZXMgYW4gYXNwZWVkLm90cCBvYmplY3QgaW50ZXJuYWxseSBhcyBhIGNoaWxk
IG9mIHRoZSBTQkMuIEFzIGEgcmVzdWx0LCB0d28gc2VwYXJhdGUgT1RQIGRldmljZXMgZXhpc3Qg
aW4gdGhlIFFPTSB0cmVlLg0KDQpGb3IgZXhhbXBsZSwgYmFzZWQgb24gaW5mbyBxb20tdHJlZSwg
dGhlIGhpZXJhcmNoeSBsb29rcyBsaWtlIHRoaXM6DQpUaGUgT1RQIGRldmljZSBpbnN0YW50aWF0
ZWQgdmlhIGNvbW1hbmQtbGluZSBvcHRpb25zOg0KL21hY2hpbmUgKGFzdDI2MDAtZXZiLW1hY2hp
bmUpDQogIC9wZXJpcGhlcmFsIChjb250YWluZXIpDQogICAgL290cC1kcml2ZSAoYXNwZWVkLm90
cCkNCiAgICAgIC9hc3BlZWQub3RwWzBdIChtZW1vcnktcmVnaW9uKQ0KDQpUaGUgT1RQIGRldmlj
ZSBpbnN0YW50aWF0ZWQgZnJvbSB3aXRoaW4gdGhlIFNCQzoNCiAgICAvc2JjIChhc3BlZWQuc2Jj
LWFzdDI2MDApDQogICAgICAvYXNwZWVkLnNiY1swXSAobWVtb3J5LXJlZ2lvbikNCiAgICAgIC9v
dHAgKGFzcGVlZC5vdHApDQogICAgICAgIC9hc3BlZWQub3RwWzBdIChtZW1vcnktcmVnaW9uKQ0K
DQpJbiBhbiBlYXJsaWVyIHJldmlzaW9uLCBJIHVzZWQgYSBwb2ludGVyIGxpa2UgQXNwZWVkT1RQ
U3RhdGUgKm90cCBhbG9uZyB3aXRoIHFlbXVfYWRkX21hY2hpbmVfaW5pdF9kb25lX25vdGlmaWVy
KCkgdG8gbG9jYXRlIGFuZCByZXVzZSB0aGUgY29tbWFuZC1saW5l4oCTaW5zdGFudGlhdGVkIG9i
amVjdCwgYmFzZWQgb24gdGhlIGFzc3VtcHRpb24gdGhhdCB0aGVyZSBzaG91bGQgYmUgb25seSBv
bmUgT1RQIGluc3RhbmNlLiBIb3dldmVyLCBJIHJlYWxpemUgdGhpcyBtYXkgbm90IGJlIGEgcmVs
aWFibGUgYXBwcm9hY2ggYW5kIGNvdWxkIGxlYWQgdG8gdW5leHBlY3RlZCBjb25mdXNpb24gb3Ig
aW5jb25zaXN0ZW5jaWVzLg0KDQpHaXZlbiB0aGlzLCBJIHdvdWxkIGFwcHJlY2lhdGUgeW91ciBh
ZHZpY2Ugb24gdGhlIHByb3BlciB3YXkgdG8gaGFuZGxlIHRoaXMgc2l0dWF0aW9uLiBTcGVjaWZp
Y2FsbHksIHNob3VsZCB3ZSBhdm9pZCBjcmVhdGluZyB0aGUgT1RQIGRldmljZSBpbnNpZGUgdGhl
IFNCQyBhbmQgcmVseSBlbnRpcmVseSBvbiB0aGUgZXh0ZXJuYWwgZGV2aWNlIGluc3RhbmNlPyBP
ciB3b3VsZCBpdCBiZSBhY2NlcHRhYmxlIHRvIGluc3RhbnRpYXRlIGl0IGludGVybmFsbHkgYW5k
IGF2b2lkIGV4cG9zaW5nIGl0IHZpYSAtZGV2aWNlPw0KDQpUaGFua3MgYWdhaW4gZm9yIHlvdXIg
dGltZSBhbmQgZmVlZGJhY2suDQoNCkJlc3QgUmVnYXJkcywNCkthbmUNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0BrYW9kLm9yZz4N
Cj4gU2VudDogRnJpZGF5LCBKdW5lIDI3LCAyMDI1IDI6NTIgUE0NCj4gVG86IEthbmUgQ2hlbiA8
a2FuZV9jaGVuQGFzcGVlZHRlY2guY29tPjsgUGV0ZXIgTWF5ZGVsbA0KPiA8cGV0ZXIubWF5ZGVs
bEBsaW5hcm8ub3JnPjsgU3RldmVuIExlZSA8c3RldmVuX2xlZUBhc3BlZWR0ZWNoLmNvbT47IFRy
b3kNCj4gTGVlIDxsZWV0cm95QGdtYWlsLmNvbT47IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVl
ZHRlY2guY29tPjsgQW5kcmV3DQo+IEplZmZlcnkgPGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5h
dT47IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+Ow0KPiBvcGVuIGxpc3Q6QVNQRUVEIEJN
Q3MgPHFlbXUtYXJtQG5vbmdudS5vcmc+OyBvcGVuIGxpc3Q6QWxsIHBhdGNoZXMgQ0MNCj4gaGVy
ZSA8cWVtdS1kZXZlbEBub25nbnUub3JnPg0KPiBDYzogVHJveSBMZWUgPHRyb3lfbGVlQGFzcGVl
ZHRlY2guY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDAvM10gQWRkIFFFTVUgbW9kZWwg
Zm9yIEFTUEVFRCBPVFAgbWVtb3J5IGFuZA0KPiBpbnRlZ3JhdGUgd2l0aCBTb0MNCj4gDQo+IE9u
IDYvMjcvMjUgMDQ6NTYsIEthbmUgQ2hlbiB3cm90ZToNCj4gPiBGcm9tOiBLYW5lLUNoZW4tQVMg
PGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggc2VyaWVzIGlu
dHJvZHVjZXMgYSBRRU1VIG1vZGVsIGZvciB0aGUgQVNQRUVEIE9UUCAoT25lLVRpbWUNCj4gPiBQ
cm9ncmFtbWFibGUpIG1lbW9yeSwgYWxvbmcgd2l0aCBpdHMgaW50ZWdyYXRpb24gaW50byB0aGUg
U2VjdXJlIEJvb3QNCj4gPiBDb250cm9sbGVyIChTQkMpIGFuZCBzdXBwb3J0ZWQgU29DIChBU1Qy
NjAwKS4NCj4gPg0KPiA+IFRoZSBPVFAgbW9kZWwgZW11bGF0ZXMgYSBzaW1wbGUgZnVzZSBhcnJh
eSB1c2VkIGZvciBzZWN1cmUgYm9vdCBvcg0KPiA+IGRldmljZSBjb25maWd1cmF0aW9uLCBpbXBs
ZW1lbnRlZCB3aXRoIGludGVybmFsIGJ1ZmZlcnM7IGV4dGVybmFsDQo+ID4gZmlsZS9kZXZpY2Ug
c3VwcG9ydCBub3QgaW5jbHVkZWQgaW4gdGhpcyB2ZXJzaW9uLiBJdCBleHBvc2VzIGFuDQo+ID4g
QWRkcmVzc1NwYWNlIHRvIHN1cHBvcnQgdHJhbnNhY3Rpb24tYmFzZWQgYWNjZXNzIGZyb20gY29u
dHJvbGxlcnMgbGlrZQ0KPiA+IHRoZSBTQkMuDQo+ID4NCj4gPiBUaGlzIHNlcmllcyBpbmNsdWRl
czoNCj4gPiAgICAtIE9UUCBtZW1vcnkgZGV2aWNlIGltcGxlbWVudGF0aW9uDQo+ID4gICAgLSBT
QkMgaW50ZWdyYXRpb24gd2l0aCBjb21tYW5kIGRlY29kaW5nIChSRUFEL1BST0cpDQo+ID4gICAg
LSBEaXJlY3QgaW50ZWdyYXRpb24gaW4gQVNUMjYwMCBTb0Mgd2l0aG91dCByZXF1aXJpbmcgdXNl
cg0KPiA+IHBhcmFtZXRlcnMNCj4gPg0KPiA+IEFueSBmZWVkYmFjayBvciBzdWdnZXN0aW9ucyBh
cmUgYXBwcmVjaWF0ZWQhDQo+ID4NCj4gPiBLYW5lDQo+ID4gLS0tDQo+ID4NCj4gPiBDaGFuZ2VM
b2cNCj4gPiAtLS0tLS0tLS0NCj4gPiB2MjoNCj4gPiAtIFJlbmFtZSBkZXZpY2UgZnJvbSAnYXNw
ZWVkX290cG1lbScgdG8gJ2FzcGVlZF9vdHAnIGFuZCBtb3ZlIGl0IHRvDQo+ID4gaHcvbnZyYW0v
DQo+ID4gLSBNb3ZlIE9UUCBkZXZpY2UgcmVhbGl6YXRpb24gZnJvbSBpbnN0YW5jZV9pbml0IHRv
IHRoZSByZWFsaXplDQo+ID4gZnVuY3Rpb24NCj4gPiAtIEltcHJvdmUgZXJyb3IgbG9nZ2luZyB3
aXRoIHFlbXVfbG9nX21hc2soKSBhbmQgcmVtb3ZlIHVudXNlZCBlcnJvcg0KPiA+IHByb3BhZ2F0
aW9uDQo+IA0KPiANCj4gdjIgbG9va3MgT0sgd2l0aCB0aGUgZml4IEkgYXNrZWQgb24gcGF0Y2gg
Mi4NCj4gDQo+IEluIHRoZSBuZXh0IHJvdW5kLCBjb3VsZCB5b3UgcGxlYXNlIGluY2x1ZGUgYSBw
YXRjaCByZS1hZGRpbmcgYSBkcml2ZSBwcm9wZXJ0eQ0KPiBhbmQgYSBibG9jayBiYWNrZW5kIGlu
IEFzcGVlZE9UUFN0YXRlID8NCj4gDQo+IExhc3QsIHdlIHNob3VsZCB3b3JrIG9uIGxpbmtpbmcg
dGhlIGRyaXZlIHRvIGEgbWFjaGluZSBvcHRpb24gYnV0IGZpcnN0LCBsZXQncw0KPiBhZGQgdGhl
IGRyaXZlLg0KPiANCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KPiANCj4gDQo+IA0KPiA+
DQo+ID4gdjE6DQo+ID4gLSBJbml0aWFsIHZlcnNpb24NCj4gPg0KPiA+IC0tLQ0KPiA+DQo+ID4g
S2FuZS1DaGVuLUFTICgzKToNCj4gPiAgICBody9taXNjL2FzcGVlZF9vdHA6IEFkZCBBU1BFRUQg
T1RQIG1lbW9yeSBkZXZpY2UgbW9kZWwNCj4gPiAgICBody9taXNjL2FzcGVlZF9zYmM6IENvbm5l
Y3QgQVNQRUVEIE9UUCBtZW1vcnkgZGV2aWNlIHRvIFNCQw0KPiA+ICAgIGh3L2FybTogSW50ZWdy
YXRlIEFTUEVFRCBPVFAgbWVtb3J5IHN1cHBvcnQgaW50byBBU1QyNjAwIFNvQ3MNCj4gPg0KPiA+
ICAgaW5jbHVkZS9ody9taXNjL2FzcGVlZF9zYmMuaCAgfCAgIDUgKysNCj4gPiAgIGluY2x1ZGUv
aHcvbnZyYW0vYXNwZWVkX290cC5oIHwgIDMwICsrKysrKysrKw0KPiA+ICAgaHcvYXJtL2FzcGVl
ZF9hc3QyNjAwLmMgICAgICAgfCAgIDIgKy0NCj4gPiAgIGh3L21pc2MvYXNwZWVkX3NiYy5jICAg
ICAgICAgIHwgMTE5DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAg
IGh3L252cmFtL2FzcGVlZF9vdHAuYyAgICAgICAgIHwgIDk0DQo+ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPiA+ICAgaHcvbWlzYy90cmFjZS1ldmVudHMgICAgICAgICAgfCAgIDUgKysN
Cj4gPiAgIGh3L252cmFtL21lc29uLmJ1aWxkICAgICAgICAgIHwgICA0ICsrDQo+ID4gICA3IGZp
bGVzIGNoYW5nZWQsIDI1OCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gICBjcmVh
dGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9ody9udnJhbS9hc3BlZWRfb3RwLmgNCj4gPiAgIGNyZWF0
ZSBtb2RlIDEwMDY0NCBody9udnJhbS9hc3BlZWRfb3RwLmMNCj4gPg0KDQo=

