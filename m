Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7F3C2A072
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 07:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcejb-0003h0-KB; Mon, 05 Jan 2026 02:10:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vcej8-0003Zk-21; Mon, 05 Jan 2026 02:10:12 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vcej3-0003Ol-2N; Mon, 05 Jan 2026 02:10:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJmWIpR5ykci7byYy7IkIYeQZrhHDP0UrK7yPj433v1nHAHkgUwU7pMFd2kOS3aerQ2RDU07tN3k9d1YOwJiIc27cGfvJhVVp8sKNKV0nXuMOEprUcMfy7jH8q68W0KRsocoHIAeWJNjltH0QRLTtKqrLwIxoVzjCDFDyrc0i7p5QxTnSWIOCQzXyhmweZNam9Ke6xdsZhB5Xc2ZAauIneBQxudf2U6BMIIe+aLbOrdvs+KTAOFvqSJWqVc3tkEg+wcKgSj/KJvxLH0W8Grwo0WZ59kBQ6SB/Gbi5nyoK46r/B3KJj/PHS4DF6EfRwI/1JdfopnCWqkii165tVC7Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7MMp1HuVVfA4lJZYfwfoBs4bd0AoaLLOiC4soOYf6Y=;
 b=mw563dmGkNzMfj/thpPqzyPDGinreZcX9NsWlbU7DillCBTCFwVHHC0wBXG6wmRxuR3qX6YI3iwdLsCeNhutLVuXPptfU2V/y4kCGKTnFPbee3nqDMwY3+uFsdYQdlUimNeir4SGPJW6RHbBA6Jq4n2Vkaz087PYkW4464hZZd1Kg2DY+vvdhdR1kywbMHRmDuexBRVBAD7qH5D6BxvQgEfyvQyPOz3z168sSIp79s+PkwitODj26lDGtkXApj4A7ZjOmiT3Nix6+dT6NT0DmL5DdV1AmIT6z5pGxNDdE15D1dRYeMWXQo8Nu1tbe60RL8ts2qA67Rg6R0bIwsFsRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7MMp1HuVVfA4lJZYfwfoBs4bd0AoaLLOiC4soOYf6Y=;
 b=dnlUi11IIF75RUD+g8o4U/3eLscuFH2hmxRCP6lD8ql30jyU5pBM8ZGjzxroGK4heeLMnJ7QXuoXCxNVpU/6jGcv6fvhqpkakJKLBXPlVA+M22zT9wvur1KDe/II2sZvK1P5fk0tC0+3z4ZgWLV9G+iU2Z/if2gCyM1FmXBr3OLSKQ7hS8qOZzUrkXbyi0GHewJtRj8TczpMMM0E/Y8t6x5/PqEYYwsF5dydiSpf+yf8wHJ7toLTwRot5ru6flfjMsQaAjFY/y52WbMgPDmybSXVQYc4W8snO8k0oLnne1GXKPdHGL/9FddYYmHhTSYfzd2at1ohDqvAys/LiRW/Kw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR0601MB5727.apcprd06.prod.outlook.com (2603:1096:820:b0::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 07:09:52 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5%3]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 07:09:52 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Joe Komlodi <komlodi@google.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "venture@google.com" <venture@google.com>, "clg@kaod.org" <clg@kaod.org>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, "leetroy@gmail.com" <leetroy@gmail.com>,
 "andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>, "joel@jms.id.au"
 <joel@jms.id.au>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [PATCH 07/19] hw/i3c/aspeed_i3c: Add register RO field masks
Thread-Topic: [PATCH 07/19] hw/i3c/aspeed_i3c: Add register RO field masks
Thread-Index: AQHb2/a6qs86FrhUVEyQBjFW7a96L7VEayJA
Date: Mon, 5 Jan 2026 07:09:52 +0000
Message-ID: <TYPPR06MB8206383D752C72C8B9D96808FC86A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20250613000411.1516521-1-komlodi@google.com>
 <20250613000411.1516521-8-komlodi@google.com>
In-Reply-To: <20250613000411.1516521-8-komlodi@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR0601MB5727:EE_
x-ms-office365-filtering-correlation-id: 480d1cff-38f4-4254-269a-08de4c296c3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MWFYMUlSY3dHQ0xyV0MwdTIyN2pJZ1hhZ05xRWovUGRXTFZUVFpMcmk5Q2w2?=
 =?utf-8?B?ZWVoUGVqWExrdGkxblFpMEhDb0pDNWxVZjdGNGZINzlBMy9oSWpOVHlqR3hm?=
 =?utf-8?B?K3JoVFZxVVBucWhEM1Zybk5XMDk4SS9LSGVQMytGdjFXV3Q0Wm9hdHNKRS9t?=
 =?utf-8?B?OVZ3d24xRHVrWnZ6VFJyNnFlWWFNc3dFN3Mra2VhdnBMcDkrZlowZ1RhRkYy?=
 =?utf-8?B?dHdONGNYRnlsWkNxZlRvSFF6U2VoWk1jTmpWWk9WdXFJLzVCMUtpZllpZFdQ?=
 =?utf-8?B?WTkvOVBmZmtxN093N3J3WTIzN1lESnRVeDJOaFV4N0xFTTlvK2FFM05RY0lP?=
 =?utf-8?B?L0xjaDI0eGIwQVRqcjFwdmNUaXkzVHZGWFRxV0swVEhVdWFwdCtyMFVyTnRz?=
 =?utf-8?B?SGp4MWM1V3ZrdjFXRDZLNkgyWElRUXczd2w5eSt1TEFneHoyL2psQWVzMStj?=
 =?utf-8?B?dzdlb0o0NEgxM25XdkFVUmE5NWVoOWVjUTIzdFNTdzhJRHZJWitNUUd2ZFNO?=
 =?utf-8?B?Y21mNUNkdDk5L3ozWmx3VzJ2N2cyMERoZ2QxQjlvcDVkdXRBTUludTRvb1Zr?=
 =?utf-8?B?VzU4RUpFaDc2KzVTd21QaVdnREkzbGpUL2k5RmgrVXpMZ3NZdmZVa2NTWkJE?=
 =?utf-8?B?MkZMeTRFbS9YV1Q3a2t0TFg3ZjBNSzd1aURLTHY4em8rblNxdmxUWWFYY2ZR?=
 =?utf-8?B?a0lDV1lhbThvdExxNTBaTjhZNXZJZThrUjd6cmRoRDIxc2ZmUnlWTlBITUlH?=
 =?utf-8?B?OXcrOE02UURDZ3BLZXFTWlNtYTFwTE1FdVZGTzAxdXVZZ3RhQmkvc3BFYkM5?=
 =?utf-8?B?NjJxdHJlQWRnM251Tm8wWVhTMHB2WFVja3NWK0o4OHJzVU8rSWdaVS90akdC?=
 =?utf-8?B?alZVZHhReHNrdmk2cEFydW5XV2tmdkJRbWZpbXg5Z3E2dTZCWnZUa0VXNVJ6?=
 =?utf-8?B?LzQvWlZwS0lXdGltVDVqY3NSekN3K1dXejhWM2pESzU2dW9NZW94cWJPYTZh?=
 =?utf-8?B?QWoxc2NtZzhEMFZlekE1LzlUTWp1MmdEUXJoV2QzRWJGT1lFZHNTTVFkYmJP?=
 =?utf-8?B?VEtKSGMrZG5WaEVLYnlQcFdFeUZGNkQralNEMFpxcXIzRWFWeVVBVE1jNmo3?=
 =?utf-8?B?aHo5TnQwdzVrS0phYmp1aHgvb05TdVNKaXlaM3R0SEh6N0RVRlVFaWpFSDhM?=
 =?utf-8?B?KzZjNGxEbHlyQnVKcndWcG1pWUJyNUthbnBiNWIrVStEZFdnRmlpNWszQWly?=
 =?utf-8?B?Qzd2SzJaNUFxZXFtcVBjaFM1WHpmSlFSV1lUZXlHdXhZcFB5dFRoRDVkZTJM?=
 =?utf-8?B?b0hKRFdGS1pzRDdvOGw1b1hia0V2VVl6cDc2WGQ2RlcrdDdCR0QzM1RIVU5Z?=
 =?utf-8?B?WGh4TEhPRyt4NGpvNjFkVTQrR3lSN2xBak8yQko5MXdabmtEaXJZWm82L2lG?=
 =?utf-8?B?TmFLR1Z2cWI4OU94YUZMblczMmQ1eU5OSU1uRjBla3dDWitUZ3FackdzZWxL?=
 =?utf-8?B?VEdnK3JHMk1sWkJFb3RzSHlick1Ca0VOOVExaFlxOW9sY3VHMUlRS0tpNnN6?=
 =?utf-8?B?cTNiRWRJdk80NW90UXRnaFpYV0YvL2JWS3ZybHBpMHhtSmZJaGFGTVB0bXRx?=
 =?utf-8?B?MUVXSGpyMTNEc3k2Qldod0xQSEp0STdsY2YxdHkxNDl4dFllYVhtRzBOUUU3?=
 =?utf-8?B?UkM2NGdoNDlTblliK1NTRldCb1dLNFN2V2dQcjNhZEFRNFIwaGIvSy80bW1P?=
 =?utf-8?B?ajZHUUMrZno1OUovNVFkRk9UTTJ5OEVQYTYvN0s4ZVhMYzhhc3dVZkZ2VWpo?=
 =?utf-8?B?TXlYK3huenFGcU9vUEFva2FVQUFqdHA2TkdlQzgrTEpjL3BLc1RxN0FSZm5p?=
 =?utf-8?B?YmJmOG45VkFDY3Q2WTFjSlQ3S0pPcjdwdzlvMG01SHlHL0RaOHlrMVVOVWFT?=
 =?utf-8?B?TGhHOWhPWjB1QXF1UEtQaDF0SFhZWS9NcjJvODlCZlJiWlUzOVhoZklGRUwr?=
 =?utf-8?B?cE9rc29ob1g4eFoxUWhvKzhLOEl4eDc1SlNQMDhYMWFpU1BPOFoxVjBzZSty?=
 =?utf-8?Q?PFZCJe?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlZFTTcvZDFPSjlRajQrNXc0NXBNUmZ1OUNkMGdmVkI4ckJCR1FpbDk3SzFZ?=
 =?utf-8?B?L3JxcGRqb3phVi9ZRm5kWXczbm4wZE1SZmJRUzg0cjlndzUwbndublRudlF5?=
 =?utf-8?B?OTJRU05odFpER1YxQktsQ1NkWEQ3dGM3dUJMREdqemNNUlNSSnVQZXhBZ3RG?=
 =?utf-8?B?RXE4eE9tSCsyOEJhRGJtRzdhRExMWFpaQjJQaFNySEl5TmZoT2UwVUNLQ3Bs?=
 =?utf-8?B?MXJjbU5TOW5rb2RVb3Z1Wmo3TTdrKzhXZElJeGR5OUVQVHZsNUpKOWtDbXZr?=
 =?utf-8?B?V2JJK0hMVUVsd3ZvcVREd3pVblRXWDd4MmJLeHFGVFNSMCt4THpLVW5WWXND?=
 =?utf-8?B?MFQzeUdlMEZ3ejIxWk9rZHdFUzE2Z0dyeUpLVGpZR1VpY2F5TVA1SDVzTnFq?=
 =?utf-8?B?cWlpdlhxNnd2TGdaUHhTTlJOMVNqL0k5VHR3QTl2SytnYi9HMDNWU002a2Vi?=
 =?utf-8?B?S2w3bEw2LzB5ZElVcHk4SFhHOEs0Um1ZbDdaUTE5K1NZWVdGOVhmTDAyOEVv?=
 =?utf-8?B?Q2JYblpaNkpQUllzUkYxaTNWSFNyZllUai9EaVpxdXdYeGQ2YnRwT2JzalVR?=
 =?utf-8?B?RVJqMDBReWFZZjVJVE1VVEhOVU01S1JSc3pmdm9aZ05XQnRudk9mYWd5dngz?=
 =?utf-8?B?bVRxbmhra1paUlh3MDJRN1lvQzJselBVNEExNEl5UXU5aEYraGM3V3c1M2Zi?=
 =?utf-8?B?eEwzNHZKU2s5TllXbHdnZkZaVGpRK1dNMytocTNKd3lNYVd0aWI0djkwN2Fs?=
 =?utf-8?B?THFLTmYwQjMyTUpRc2Zub2YyckV6WGlad1l6bC9MM2IzSHNWalp3NjJhYm5U?=
 =?utf-8?B?cGo0eDNCWnhFQW1yYm5XaE1ZZm5qT2JibnpVM3IwdFZrQWVxWnFhSXA0dU95?=
 =?utf-8?B?d0FLV3U0T1JkZ0tTOHdqUGdBTUh6U3I1WDVBa1dJQkdxTmVhUWdlN2RVQ2dQ?=
 =?utf-8?B?QTVReUQrOUhnM25NYXJZd0QwSGdZajE2dkFrdklxSDYwZVJCQmRSdmxlR05R?=
 =?utf-8?B?N3RVMG5pZUJyS1lnRExoMWwrSGFnalZ4OHU0VHkvRkFFdTJqclVEMitkYUtu?=
 =?utf-8?B?RHQ0alJ6ODNydXJzWjVQNkZYMUEvZnd4RTR0N25RT3pMZXFtQWZYMUpJSHd6?=
 =?utf-8?B?Mk5yaVBnSU12NS9zYUpQb1Zsb0UxRCtRMWMzamVxemZXQ25Jdy9vd0RKQUc5?=
 =?utf-8?B?SWZHQ0dlM3ZqT28yZU1INE0zbTlKbldnNXg1T041UFg1MDFVQkxBSnJHRlU5?=
 =?utf-8?B?VUE4WmVKMTlEQWhvQ0g1WVpxSHFZVElna04zbVVHNE81TXJLMWIvem00Qmg2?=
 =?utf-8?B?WHU1bWR5MlhZRTJkd3RLL3RSWU1UakFOUjZuTnNxSXpMKzlCVTZPanJjSlJh?=
 =?utf-8?B?emkzNVp2K3pZbkp2VENtOEwwYmsrSCttNTFEdFlqd0ExZDNqK2cwZVRsUXRZ?=
 =?utf-8?B?ZmxBMjRaUnI0WW0zWmFDeHZRYUMvTkRzSTdtcElWUVk2dGc1SktjUHgyM25r?=
 =?utf-8?B?eENUMnRyWlJUeFQyaUVpbXluV1JGR2h3bnhibG9YalFUM2tPUGZKOW1yZThO?=
 =?utf-8?B?TXBQMm1YeVRrM0Jwb2N5RDRKd2ZVNU1mVmRlalY4SjFoblA2UUZHaHpXSWtU?=
 =?utf-8?B?b1gwSnlsei84bklZRW1uWEYzTGYwQ24yNzNVMGM3ckpEUk4xUnUwLzdJSUJL?=
 =?utf-8?B?cDFJNzlpV1oxZ1ZWemtKYlduQUF1UFZ3Tlp1N0krS1czR2RQYlFvcjc4anRS?=
 =?utf-8?B?dzRaNFVwUndiU0IrZE9Jb1RNN0RKRm91VlFJVEpQUjkza2JCb2hCN1diYk1s?=
 =?utf-8?B?R2hVTTQrdUZkNy9ycjN3LzVLSmtsK0l5b0RibEFrM1NPSzZiMUVYRFpHTU9q?=
 =?utf-8?B?eEFPQ0hEbTllVHQ1a3pHaUp2SjdCVmYwVFpxUjlraEsvRVU2cHd5eXlEZ0I4?=
 =?utf-8?B?YWdaUVdNcFk1aU11YkZDMEtCTUtiT1dmcEVVNStyYUtjOTNOZll0UkNjOVU3?=
 =?utf-8?B?Z09DLzJnS2UrWlRMdEdwR2kwci80ZHh4YXpUT0VzT2hKaEc0Mmk1cHEyZVFx?=
 =?utf-8?B?OGN4QWc3OFZYZllHcGphZVVJR3IzcnpIMnJhVStHMTJNNUdpTlJpb0lkMlZ5?=
 =?utf-8?B?RDVFb3NkL3JuYlFmeWd0Tkx0azdia0FvbE10eGErVkIxSXkyMmRlN0s4UmhM?=
 =?utf-8?B?U1ArUUg0YXdSWTRRaHJEOWdkMlErWVh3MEVRRWFRc2NIOHlYL3lKaE80Njk4?=
 =?utf-8?B?dVNueDk5ckVma25KZjhxOGVFOGh0L2x1RFpGSlFmeDFwaUpVN1BIdUFUMzVD?=
 =?utf-8?B?UHhWUis5cTVSdUxUSkFwUXZTckJ4ZWd2RWxkUVMrZmZrQzRyL3ZXUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 480d1cff-38f4-4254-269a-08de4c296c3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 07:09:52.5960 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BYMNibhRPU3URP2JL7yowXM5uZ0MopHUQT/bCjY8IydzifU0Rh2oS1dJeczmtjdYBU94TWWdM2/GlNH/ebjDYkL8nO7CVqOP9jDe/7HjF68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5727
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

SGkgSm9lLA0KDQo+IFN1YmplY3Q6IFtQQVRDSCAwNy8xOV0gaHcvaTNjL2FzcGVlZF9pM2M6IEFk
ZCByZWdpc3RlciBSTyBmaWVsZCBtYXNrcw0KPiANCj4gQWRkcyByZWFkLW9ubHkgcmVnaXN0ZXIg
bWFza3MgZm9yIHRoZSBBc3BlZWQgSTNDIGNvbnRyb2xsZXIgcmVnaXN0ZXJzLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogSm9lIEtvbWxvZGkgPGtvbWxvZGlAZ29vZ2xlLmNvbT4NCj4gDQo+IFJldmll
d2VkLWJ5OiBQYXRyaWNrIFZlbnR1cmUgPHZlbnR1cmVAZ29vZ2xlLmNvbT4NCj4gLS0tDQo+ICBo
dy9pM2MvYXNwZWVkX2kzYy5jIHwgMTYgKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDE2IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9pM2MvYXNwZWVkX2kz
Yy5jIGIvaHcvaTNjL2FzcGVlZF9pM2MuYyBpbmRleA0KPiA3YTE2ZGZlYzUzLi4xYWQyNWU1YTAw
IDEwMDY0NA0KPiAtLS0gYS9ody9pM2MvYXNwZWVkX2kzYy5jDQo+ICsrKyBiL2h3L2kzYy9hc3Bl
ZWRfaTNjLmMNCj4gQEAgLTc0LDYgKzc0LDIxIEBAIFJFRzMyKEkzQzZfUkVHMSwgMHg2NCkNCj4g
ICAgICBGSUVMRChJM0M2X1JFRzEsIFNBX0VOLCAgICAgICAgIDE1LCAxKQ0KPiAgICAgIEZJRUxE
KEkzQzZfUkVHMSwgSU5TVF9JRCwgICAgICAgMTYsIDQpDQo+IA0KPiArc3RhdGljIGNvbnN0IHVp
bnQzMl90IGFzdDI2MDBfaTNjX2NvbnRyb2xsZXJfcm9bQVNQRUVEX0kzQ19OUl9SRUdTXSA9IHsN
Cj4gKyAgICBbUl9JM0MxX1JFRzBdICAgICAgICAgICAgICAgICAgID0gMHhmYzAwMDAwMCwNCg0K
DQpBY2NvcmRpbmcgdG8gdGhlIGRhdGFzaGVldCwgYml0cyBbMjk6MjhdIGFyZSBkZWZpbmVkIGFz
IFJXIChTREFfUFVMTFVQX0VOKS4NCldoeSBhcmUgdGhlc2UgYml0cyBiZWluZyBtYXNrZWQgYXMg
cmVhZC1vbmx5Pw0KDQo+ICsgICAgW1JfSTNDMV9SRUcxXSAgICAgICAgICAgICAgICAgICA9IDB4
ZmZmMDAwMDAsDQoNCkFjY29yZGluZyB0byB0aGUgZGF0YXNoZWV0LCBiaXRzIFszMTowXSBhcmUg
YWxsIFJXLg0KV2h5IGFyZSBiaXRzIFszMToyMF0gYmVpbmcgdHJlYXRlZCBhcyByZWFkLW9ubHk/
DQoNClRoZSBzYW1lIHF1ZXN0aW9ucyBhcHBseSB0byBJM0MyIHRocm91Z2ggSTNDNi4NCg0KVGhh
bmtzLUphbWluDQoNCj4gKyAgICBbUl9JM0MyX1JFRzBdICAgICAgICAgICAgICAgICAgID0gMHhm
YzAwMDAwMCwNCj4gKyAgICBbUl9JM0MyX1JFRzFdICAgICAgICAgICAgICAgICAgID0gMHhmZmYw
MDAwMCwNCj4gKyAgICBbUl9JM0MzX1JFRzBdICAgICAgICAgICAgICAgICAgID0gMHhmYzAwMDAw
MCwNCj4gKyAgICBbUl9JM0MzX1JFRzFdICAgICAgICAgICAgICAgICAgID0gMHhmZmYwMDAwMCwN
Cj4gKyAgICBbUl9JM0M0X1JFRzBdICAgICAgICAgICAgICAgICAgID0gMHhmYzAwMDAwMCwNCj4g
KyAgICBbUl9JM0M0X1JFRzFdICAgICAgICAgICAgICAgICAgID0gMHhmZmYwMDAwMCwNCj4gKyAg
ICBbUl9JM0M1X1JFRzBdICAgICAgICAgICAgICAgICAgID0gMHhmYzAwMDAwMCwNCj4gKyAgICBb
Ul9JM0M1X1JFRzFdICAgICAgICAgICAgICAgICAgID0gMHhmZmYwMDAwMCwNCj4gKyAgICBbUl9J
M0M2X1JFRzBdICAgICAgICAgICAgICAgICAgID0gMHhmYzAwMDAwMCwNCj4gKyAgICBbUl9JM0M2
X1JFRzFdICAgICAgICAgICAgICAgICAgID0gMHhmZmYwMDAwMCwNCj4gK307DQo+ICsNCj4gIHN0
YXRpYyB1aW50NjRfdCBhc3BlZWRfaTNjX3JlYWQodm9pZCAqb3BhcXVlLCBod2FkZHIgYWRkciwg
dW5zaWduZWQgaW50IHNpemUpDQo+IHsNCj4gICAgICBBc3BlZWRJM0NTdGF0ZSAqcyA9IEFTUEVF
RF9JM0Mob3BhcXVlKTsgQEAgLTk3LDYgKzExMiw3IEBAIHN0YXRpYw0KPiB2b2lkIGFzcGVlZF9p
M2Nfd3JpdGUodm9pZCAqb3BhcXVlLA0KPiANCj4gICAgICBhZGRyID4+PSAyOw0KPiANCj4gKyAg
ICBkYXRhICY9IH5hc3QyNjAwX2kzY19jb250cm9sbGVyX3JvW2FkZHJdOw0KPiAgICAgIC8qIEkz
QyBjb250cm9sbGVyIHJlZ2lzdGVyICovDQo+ICAgICAgc3dpdGNoIChhZGRyKSB7DQo+ICAgICAg
Y2FzZSBSX0kzQzFfUkVHMToNCj4gLS0NCj4gMi41MC4wLnJjMS41OTEuZzljOTVmMTdmNjQtZ29v
Zw0KDQo=

