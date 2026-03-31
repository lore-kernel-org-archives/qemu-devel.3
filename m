Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037DE1061B2B
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 11:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7XI6-00074y-8I; Tue, 31 Mar 2026 07:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1w7XHk-0006vy-Tb
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 07:29:29 -0400
Received: from mail-japanwestazlp170110001.outbound.protection.outlook.com
 ([2a01:111:f403:c407::1] helo=OS0P286CU010.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1w7XHi-0004v8-U0
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 07:29:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qK2RmRMNZZGm6PUTAMeXVSKGxb4vzS7a1V8df5vAHxLd2xEADCiCmuQwluTgdNfFpOpOAsQIYL+porArUbSpOzEwDZIxPcwR24ws9ohmKOxbcL7Fyy+KfHrpTn0uquyiqSb+tRRsEyYauo/rowDbjETiimwbhVpTKPc2Ikpz1RZ4GUmPt+yadzx9hCcLRIlcUQjG9CXvOR1Ttj/atSGvaq5uRuKL+Kr5C1iXUEvKFYft/FJSckKs9ngwYw1N31+A9/z3+T3xhWPP6tQETeSBp6U45oRrjM39UyOFRCOU3cHNG0w5Q12moasyMpR32tTA+uB6RKGiwkOd0PjD965Xkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFfNmOR+B3EHAkfxOKt/eRvKVRjQhX4BT8E/FgBaXIE=;
 b=d/b/LJvNmON8KKVaOQAHsB7tSl6+fTlbH+xizKWpyk7DxcKjAp9xLOGnkxera/0hQVD+Icdct8fMff62df6BIt7rjVxs7diz9KRcNCHc6u3TW2jOqD/xKjDCUMvkuIm1Nz0xU+5g/BdFrl45rfN9kHojsPOY6uzJG0Hsr5osnQBQ+17RaTZDYF4MrJeK5z9wNmCQbilvmJMssSk6PLollZF1RwQmHiYWoVgyOFuUvGNtWcM/nNFjeWZMLBmFbaVQisvNkVQWREjZLL/XvMIIt7ZCfdhGVnkJycrJj6bc33xgMkCRikVm4+IhNYuPamchz/pHtBd5KbK00W0x9k6PJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFfNmOR+B3EHAkfxOKt/eRvKVRjQhX4BT8E/FgBaXIE=;
 b=iwKeQ8fRubUeSpUDXqPlEdmhkyLdcSOYR+75hEZ5E8AKYGdwcyCKwYqiJmiImCtYQzXVAZTqm2jPaGbzthLoLS8Ao3N/uiazmT54Z7L/yqyYCf/dGed8jONIPwm7lVPK452OTSiI7CKE3Wo1uEgj38LV07LjRvQLILU77R1Ux6YJO/umrRB7q2gIqBQ/q9yuJvow3CRvpGFWM1LLsZIocGbarkcG1p7/2Hz+5K2FO2M7INTOLClGM1y3UBiyK05Nialkpndjre78yEh6y7hGrdIif1ye9Jbhf5Mv6tL4GazdgWl4kGlpY2hrZi0oG72wMPwnCMr0+ChAXFvo3z4c7Q==
Received: from TY7PR01MB16837.jpnprd01.prod.outlook.com
 (2603:1096:405:32e::20) by TY4PR01MB17260.jpnprd01.prod.outlook.com
 (2603:1096:405:339::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 11:29:22 +0000
Received: from TY7PR01MB16837.jpnprd01.prod.outlook.com
 ([fe80::5812:babf:b430:670f]) by TY7PR01MB16837.jpnprd01.prod.outlook.com
 ([fe80::5812:babf:b430:670f%4]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 11:29:22 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "Zhang, GuoQing (Sam)" <guoqzhan@amd.com>, Peter Xu <peterx@redhat.com>,
 Samuel Zhang <guoqing.zhang@amd.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "farosas@suse.de"
 <farosas@suse.de>, "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, "Emily.Deng@amd.com"
 <Emily.Deng@amd.com>, "Victor.Zhao@amd.com" <Victor.Zhao@amd.com>,
 "PengJu.Zhou@amd.com" <PengJu.Zhou@amd.com>, "Qing.Ma@amd.com"
 <Qing.Ma@amd.com>
Subject: Re: [PATCH v3] migration/rdma: add x-rdma-chunk-size parameter
Thread-Topic: [PATCH v3] migration/rdma: add x-rdma-chunk-size parameter
Thread-Index: AQHcvbYDFS/bHmyF/0mRIclEy2/9xLXHQ/SAgAC98QCAAHZIgIAAD6OA
Date: Tue, 31 Mar 2026 11:29:22 +0000
Message-ID: <a016361c-01ca-4617-b3ac-4cdf6bbdd2ac@fujitsu.com>
References: <20260327065006.2567463-1-guoqing.zhang@amd.com>
 <acqgZShXRkqzBU1C@x1.local>
 <e3b261a3-25fa-42f9-a926-306e5a19cf75@fujitsu.com>
 <02a44178-eebc-4fef-a8fb-802dac76c11f@amd.com>
In-Reply-To: <02a44178-eebc-4fef-a8fb-802dac76c11f@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB16837:EE_|TY4PR01MB17260:EE_
x-ms-office365-filtering-correlation-id: 58d1e97d-b069-473a-4ffe-08de8f18c187
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003|1580799027;
x-microsoft-antispam-message-info: e1l807AsmFW5S1xRbxj59Z1cOYbylew35P+JSKX24LNNn6RtzrhECHO+EOAqcJ5CAZppoe0qo82X/o5FDsX+ct90qUgNOVnJBJxDEdCww1ykLUWCoFAG2I1VVaOYimOzvxsdFs4IS1VfQImqoXLP9RUSO4IeSiaOaA/SsoAVmPKEYf5T9qPL5adEykDc2P7zVwJw8xObm5qdpczl9RjZn72paZ+p6QxWttpkYqefYuZz4Hi7K6z4LwuO+uli6ePRbQ4tiJIJzihqbJb3bQx/wKjGjmKWSBLqg7IA5201W7QDFiBA98PprwbRLagxbnCwF9PTUbLtgcqum6qnPBQCGLvmikbfXKDM7NbfRayMv9UpxT/wJ2JZko4Sff15Xxi2sP4B9pFM8LUkWy0GjbcqN0tgRQhjeYmW3NIc8n7ipEYPZTGG9cUeKzCORZoZeDtKNQOsJcpxFmjjXJOWp7JsUeHLTDuWeA1GXb6Yt0GQihWSvDwo0rVXhd5NvYkn/9ercJA731yNYLOxe9uPWaWxPJuLnWWZjymfql8WxqmyCsKNUw55o/KkuE9Smx2Le1d5F3ckKHXQVWEn/sIKSszrkfg+F/MYyvQITbDv7RR5yXW0RIPFZFk0X6B0lNFk56PvvtO+5SIPHMy+wr5Yf0V01BCt+HZuvRLCih1nffXE0xeWOtut40W6VZojnqVCZhuBEFz/wfrgh1mEL3itpUsjWF+0wb8HaCPnh1OI43KnvLc8lt8QnvTcYS2VnPzIY6QuUOKjqIlezd1LfUAQGOU5l2yU6v3qr/lzsAABjP5zcNSYn4vFji4l0zegNtwZ6470
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY7PR01MB16837.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003)(1580799027);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0JZdVIxZGdnaXJ4Y1l0dW9BVUxHbzkwQmxVUjNGWWw2d1VQTC9HdnUyVTIz?=
 =?utf-8?B?VGwrbkJtZjFudHlJOUhDYWRLSGh2MWtxWEswZXZoekI1aFJmdzFqSlNiR092?=
 =?utf-8?B?aWcvd3BqRkV6R0w1cCsvK21aV1NuT3pSTG1idkdaOTE3T0FkZkVWUUxEOE43?=
 =?utf-8?B?TUw5b2J4ZWEveTdFYnE3UmhWRzdmcE9XRzNhc1ZXR1Q1TmJac21LTFFhNWRL?=
 =?utf-8?B?WHFmS1c0Y3E5cnBOSy8zK3VQU2hZamorVUlZZHRJSVBUakQ0dXZPazlvUDJn?=
 =?utf-8?B?RFQ3ZmYxY2M3RU02dGVjREJlVE1ML2pDdWpDQjIwNWkwZ2p1M0VqSC9XZjRH?=
 =?utf-8?B?WUhIdXNDYk10SE93RldaLzFOa0Rlc1ZtUm9qbzdtMmRmMjdjU3FjaEtNQWww?=
 =?utf-8?B?ckp1S3ppYllHT2pvWTREdWlnNXNPVG1PVGU5R3ZTNEZpUTJXVzQzUktZWjQy?=
 =?utf-8?B?MVkxbk5US2s5OE9qS0Y1Z2VHaVFlZktDbU1rQ0djNmtSK0MvNU8zRDZiL1JC?=
 =?utf-8?B?VHdiT3BsWDVMUXlGK29aL0Z6NHdEclo2WUppREpGTVdHTEZWVE4zMTh4NkJX?=
 =?utf-8?B?WXFmR3Z2NEFoY3AxUVhvNUR6elpVVHdEWjEyNHA1ekJZenF2Q0ZocHVuc0ho?=
 =?utf-8?B?WmRuUGx6SVloL2ZoUSs1ZzNCWHpBekM5UWlhbml2SmNmVGlmb1pqR2Z1UmJU?=
 =?utf-8?B?VVNvRytwZjhhRitRZEE5d3B3SzIvelloaHAyU1FWemJGV1NkczFsbWpZS0xM?=
 =?utf-8?B?RVZjZmt4Rng0eHdBYjhtTDJhb3NCREg2SjR6dm5Jc0NlVWZoUFI1aXhKajgv?=
 =?utf-8?B?NXlaZ1ZzSUxIUzVtZGVZc3R6TFhhV3FCL3U4aitqOFpQOC9mdXNLQ2kvWHlP?=
 =?utf-8?B?RXNCV20yY3lzcUhNdzFmUUJFK1UxMUg2M08vSU0wK3B6dGZjL3ZEWWltaFRv?=
 =?utf-8?B?bk8wa0ZqbGdnUkQxUUEzQUcvaFo4QndMOUd2azQraGZBbDJmK2VhTUExa2xU?=
 =?utf-8?B?L2FwU3cvczhDUWNSa1VvQzRBZVF0Y3ZjOE5Md3V5UXcvYjRRbGVnaGdFWlkz?=
 =?utf-8?B?SUluSjFjZ1pIU2txMFhTNzZGZmFDQmZJSVNOTXlBTmVDQkIwb1UrdWpDMEQx?=
 =?utf-8?B?cDJSWWcrN3hkQ0pWa2pMYzM1SXZmTUhzd3BhNjUrOXRCdDRZTmlXTTJ5ZnA3?=
 =?utf-8?B?eWlFU3BLNVh3Q0RqTThJY1g0M0tMb2JSS0RsZEU0U0p0Z2xLMEN0S01jZTFQ?=
 =?utf-8?B?a0hZQ3UrYVlXY2xjVmpadGpEQm05TTB2VHB4U0R6Z3V4M3ludExWNmx0NTdV?=
 =?utf-8?B?RnAzYURSdmYram5TNGsralpDbUJGNmtMZVlIS0lxWUxrMTBIQmFURDlWb0pm?=
 =?utf-8?B?WDJlSkt1aU9jVzdOd3FramtKaGFWWU1kL1UrMEM0Yzk1eVVRS2tjbGdldDQ2?=
 =?utf-8?B?Wk5TcnZmSzA4UWMzOTFOdUFPM1FZSTRiTmpsM2RaTEpFcTRNOGRZSnJSVG4y?=
 =?utf-8?B?eWN1WXAzNmw1UHNNY09VeFVLUGo2TVNYZXloTklDT0c4RlMwVmhNUnFwUnNq?=
 =?utf-8?B?SzJBS1lVVW5jVkR4R2haN2hxSTJKZDl3c1p1OG5BNXlVMWZzSjY3SWlycEMw?=
 =?utf-8?B?aVVzY3lLWGw1bnB3WkMyTjhGR1ZDYjRCeHJCU2xXVEVjY0NDUXhHbnczc1BE?=
 =?utf-8?B?UW9ienBiM0tadit4T29MK0xCQTVmTitrT1N5UlRybUcycTJ6NisraEhSTnlo?=
 =?utf-8?B?Nmx0b2dwOFo2aU8wY0tGN21RYURxa2NXbFNtbHNzOGErVGZJS3pnNHlIOVow?=
 =?utf-8?B?NUswNkVHa0VVeXhISGhQU1llaTR3REVvQjdIMVJndm1ZOG45T2FnMmRrQ1Z3?=
 =?utf-8?B?R3pjNnM1eWNwYU03aHlLOEF5SXNBVlRoZXVGRExtaEltNy85UUFEUzRUVGhm?=
 =?utf-8?B?NUVsWTFmVFpqQVJDRGV0Q28rYXRvajU0RG9xbmo2TTl6NmNsaE9qV0UwRE90?=
 =?utf-8?B?ekQ2WTRHSFlKbGdUd3kray9VS2Z4SGxkNmQxZ2JDZFNLUXI0WWF2WVNMRjdD?=
 =?utf-8?B?YVpzd1NteXJLZjR1cnVqM3dYM3lLTFg1cS9CUHdPSzg2WEpHa1pxVEVPQWpy?=
 =?utf-8?B?R0kvTGo0ZWtKTHViUDkwK0c0V3VHa0xQbndFK2JYY21pKzVsZng1NEtEblJU?=
 =?utf-8?B?MUZMeTA3VTZQZWZtV3NEWFE0YkJ1d3Z6ZEo0M0pXcGJkdGJlR0ZiMzlCc09M?=
 =?utf-8?B?cTE5b3BBYVA0WmV2MFk2SEhtVUo3bmtCZHp5eFZ1a1Z1c3grN1BJc0RJcEFh?=
 =?utf-8?B?OEFoalNCd0laZE9lUlVPZ2V6UWpqMXdhcUc1VEd3RzNiMnR2OVR1RjIyU0Q1?=
 =?utf-8?Q?rZsudtVO6Rri2/Ik=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5EC5B079B444B5419FF6D2A8BC151E09@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: brv8UUCmjAEaj9l+JOvUG2sfjkcD4lnHQbAvBjtkt0HvZOwj3yjSpGukHz+xre+js31c0SsBF2PPYYNuDXKVj60fw9Cc7J3NGwJhy/m1QlayffNIgo7KfZbjhd4aoNkXN+zVHYPonT0x0ru7bYpaQCRmwaP8SRpJV53ixdpbzWEz7TNn/7pSkBXfA7ORuxD72rxpZNvRTXe5pKgIS56J/0VO2uVZO/U0SSz/MhOrGddNNbXUgOBpQVzgCFvDyWj+0X+7hPPMiBhTqnUmQ4J3Vk/jdwAOfpkcC0gLhvROnUN3I/y6AWQebSjp/FVZjn4vTOSeKLTMqtDEyhOKz2qctw==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB16837.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d1e97d-b069-473a-4ffe-08de8f18c187
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 11:29:22.1466 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ubrRWgWVMkyMWkhkIeWnTGpIjVeJyVqjltawzd37OhkTGn3ff3dA1ayCupuxRDAqYErPqqeL599mgrVlAXncGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB17260
Received-SPF: pass client-ip=2a01:111:f403:c407::1;
 envelope-from=lizhijian@fujitsu.com;
 helo=OS0P286CU010.outbound.protection.outlook.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCk9uIDMxLzAzLzIwMjYgMTg6MzMsIFpoYW5nLCBHdW9RaW5nIChTYW0pIHdyb3RlOg0KPj4N
Cj4+Pj4gU2lnbmVkLW9mZi1ieTrCoFNhbXVlbMKgWmhhbmcgPGd1b3FpbmcuemhhbmdAYW1kLmNv
bT4NCj4+PiBPbmXCoHRoaW5nwqB0b8KgbWVudGlvbsKgaXPCoFJETUHCoG1pZ3JhdGlvbsKgaXPC
oGluwqBvZGQtZml4ZXPCoHN0YWdlLMKgYWN0dWFsbHnCoGl0DQo+Pj4gZG9lc24ndMKgaGF2ZcKg
YcKgcmVhbMKgbWFpbnRhaW5lcsKgc2/CoGl0wqBpc8Kga2luZMKgb2bCoCJvcnBoYW5lZCIuwqDC
oEluwqB0aGlzwqBjYXNlLA0KPj4+IEnCoGFjdHVhbGx5wqB3b24ndMKgc3VnZ2VzdMKgd2XCoGFk
ZMKgYW55wqBuZXfCoGtub2JzwqBmb3LCoHBlcmZvcm1hbmNlwqByZWFzb25zLg0KPj4+DQo+Pj4g
RG/CoHlvdcKgaGF2ZcKgYcKgc3Ryb25nwqByZWFzb27CoHRvwqBwcm9wb3NlwqB0aGlzwqBwYXRj
aMKgdG/CoGxhbmTCoHVwc3RyZWFtP8KgwqBJc8KgaXQNCj4+PiB1c2VkwqBpbsKgcHJvZHVjdGlv
bsKgc3lzdGVtc8KgYW5kwqBpdMKgc29sdmVzwqBzb21lwqByZWFswqBwcm9ibGVtc8KgZm9ywqB5
b3U/DQo+IA0KPiANCj4gV2XCoGhhdmXCoFZNc8Kgd2l0aMKgbGFyZ2XCoFJBTcKgYW5kwqBmaW5k
wqBUQ1DCoGxpdmUtbWlncmF0aW9uwqBpc8Kgbm90wqBmYXN0DQo+IGVub3VnaMKgYW5kwqBleHBl
Y3TCoFJETUHCoG1pZ3JhdGlvbsKgY2FuwqBiZcKgZmFzdGVyLg0KPiANCj4gQnV0wqB3ZcKgZm91
bmTCoHRoZcKgcmRtYcKgbW9kZcKgbWlncmF0aW9uwqBzcGVlZMKgaXPCoHNsb3dlcsKgdGhhbsKg
dGNwwqBtb2RlLsKgU2VlDQo+IGZvbGxvd2luZ8KgZGF0YS4NCj4gDQo+IA0KPiA4R0LCoFJBTcKg
aWRsZcKgVk3CoGxpdmUtbWlncmF0aW9uwqBwZXJmb3JtYW5jZToNCj4gfMKgdHJhbnNwb3J0wqBt
b2RlwqDCoMKgwqDCoMKgwqB8wqB0aW1lwqAocynCoHzCoHRocm91Z2hwdXTCoChNQi9zKcKgfA0K
PiB8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwtLS0tLS0tLS0tfC0tLS0tLS0tLS0tLS0tLS0tLS18
DQo+IHzCoFRDUMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHzCoDM2Ljg5wqDC
oMKgwqB8wqDCoDEsMDgxwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfA0KPiB8wqBSRE1BLMKgMU1C
wqBjaHVua8Kgc2l6ZcKgfMKgMzcuOTE1wqDCoMKgfMKgwqAxLDAwN8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHwNCj4gfMKgUkRNQSzCoDFHQsKgY2h1bmvCoHNpemXCoHzCoMKgNC4zNjjCoMKgwqB8
wqAxNyw1MjnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB8DQo+IA0KPiBUaGlzwqBwYXRjaMKgYWxs
b3dzwqB1c8KgdG/CoHVzZcKgbGFyZ2VywqBjaHVua8Kgc2l6ZcKgZm9ywqBmYXN0ZXLCoFJETUHC
oG1pZ3JhdGlvbi4NCg0KDQpIaSBTYW11ZWwsDQoNClRoYW5rcyBmb3Igc2hhcmluZyB0aGlzIGNv
bXBhcmlzb24gZGF0YS4NCg0KIEZyb20gdGhlIGZhc3QgY29tcGxldGlvbiB0aW1lIGluIHlvdXIg
dGVzdCAoNC4zcyBmb3IgOEdCKSwgaXQgbG9va3MgbGlrZSB0aGUgVk0gd2FzDQptb3N0bHkgaWRs
ZS4gVGhpcyBtZWFucyBhZnRlciB0aGUgZmlyc3QgZnVsbCBtZW1vcnkgcGFzcywgdmVyeSBmZXcg
bmV3IGRpcnR5IHBhZ2VzIHdlcmUNCmdlbmVyYXRlZCwgYWxsb3dpbmcgdGhlIG1pZ3JhdGlvbiB0
byBjb21wbGV0ZSBxdWlja2x5LiBUaGlzIHNjZW5hcmlvIGlzIHBlcmZlY3QgZm9yIGhpZ2hsaWdo
dGluZw0KdGhlIGJlbmVmaXQgb2YgbGFyZ2UgY2h1bmtzIHdoZW4gbWVtb3J5IGlzIGRpcnRpZWQg
aW4gbGFyZ2UsIGNvbnRpZ3VvdXMgYmxvY2tzIChhcyBpdCBpcw0KZHVyaW5nIHRoZSBpbml0aWFs
IGZ1bGwgc2NhbikuDQoNClRvIG1ha2UgdGhlIGNhc2UgZm9yIHRoaXMgbmV3IGtub2IgZXZlbiBz
dHJvbmdlciwgaXQgd291bGQgYmUgdmVyeSBoZWxwZnVsIHRvIGFsc28gc2VlIGRhdGENCmZyb20g
YSBtb3JlIHJlYWxpc3RpYyB3b3JrbG9hZCBzY2VuYXJpbywgZXNwZWNpYWxseSBvbmUgdGhhdCBn
ZW5lcmF0ZXMgcmFuZG9tbHkgZGlydHkgcGFnZXMuDQoNCkluIHN1Y2ggYSBjYXNlLCBldmVuIHdp
dGggYSBsYXJnZSBjaHVuayBzaXplLCBgcWVtdV9yZG1hX3dyaXRlKClgIHdvdWxkIG9ubHkgYmUg
YWJsZSB0byBzZW5kDQpzbWFsbCwgZGlzY29udGlndW91cyBibG9ja3Mgb2YgZGlydHkgcGFnZXMg
aW4gZWFjaCBpdGVyYXRpb24uDQoNCkkgc3VzcGVjdCB0aGUgdGhyb3VnaHB1dCBnYWluIHdpbGwg
c3RpbGwgYmUgc2lnbmlmaWNhbnQsIGJ1dCBsaWtlbHkgZGlmZmVyZW50IGZyb20gdGhlIGlkbGUg
Y2FzZS4NCkhhdmluZyBkYXRhIGZyb20gYSB3b3JrbG9hZCB0aGF0IHNpbXVsYXRlcyByYW5kb20g
d3JpdGVzIChlLmcuLCB1c2luZyBgc3RyZXNzLW5nYCwgbWVtaG9nIGV0Yykgd291bGQNCnByb3Zp
ZGUgYSBtb3JlIGNvbXBsZXRlIHBpY3R1cmUgYW5kIGhlbHAgdXMgdW5kZXJzdGFuZCB0aGUgYmVu
ZWZpdHMgaW4gYSB3b3JzdC1jYXNlIHNjZW5hcmlvLg0KDQoNClRoYW5rcywNClpoaWppYW4NCg0K
DQoNCg==

