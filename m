Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 123D7CD5BAB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 15:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRBET-0004oI-8O; Sun, 24 May 2026 11:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wRBER-0004o5-5P
 for qemu-devel@nongnu.org; Sun, 24 May 2026 11:59:15 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wRBEP-0006jW-0K
 for qemu-devel@nongnu.org; Sun, 24 May 2026 11:59:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cnhDsoSCyz8H/kHN9UphX3FvinDepKHN/SbH/GYSFxgOSeqBey1Mhcwj49AokGhuvJfdvdictDdzrKWztGcKyWEvvJy1WnossWAMNG9vlXv5VY0Fg+CiAsxYmGLz7bPRRMufZKHr4tBUuXm436c31njTkn2uAWQXIFViz09jNXg/0fQhplKubxmHY+iK5nix/qAdYHQbIJmKtQmkPWjXPiaynDdxJavxCILXmr7MFOk1OmfCM7luSPWaadUoiyexOSbTLkw3MXkZ0OHSRpB2SV4drJLwIaQC51ovRHkrY2/FHwtbwXKA1fLzBTWYzpEDSClcwZ5wn71KvyabJ3NrRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvF4I49dEcsyAvItTlxcwEBVQKPLUBTHi2QOyTHcyDA=;
 b=CBTMee3ERhvqzfIbTjJviLY0Zz3vtrxWonIBC1Dj2qvzgAI4kWdKTv27Qj/PFJ/hY8OU+uaaKr9CuiRleyvICR6WKBVKG0Lrm2e0OcmbmFKQZR60gMZ/YlKZOd5S8yet0NHlmIfvGY13GuCAyEhroYYMaToiHhmMmL+Pu3N7JGf0o5cme42CcGFPmpHyvCu8eHI5le7c50CQlRbOoXK2J1knVJdyCo4xrLJAN/OKDvOyAt6gSdBLaJ7scd22X6kbmjz4jYRzdrihJNgq8QBYSdmCGPVmPsyywpUeyfaZpjWTfRgJbrMceK/thdzalCrvyJUN63hJxUhMqLwKNTAXPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvF4I49dEcsyAvItTlxcwEBVQKPLUBTHi2QOyTHcyDA=;
 b=cjjI7KS28IX/toC9ar6tArPDS2JySy5Qpf6cnRyvLgF/Sx7YfG9yFXwyH8ZJJRcXVRuzzC6Y6E/a8Sa4go2i5lWs7QFuPHusuMgimA1eCiQfwjxpq03wsW+VK5J2daEw0WFmT4zb8KV7N33Y/qZQVLMfnJopsbBTCKEIj6NkOCseG1LrNT/Gh0PnIOufBd/s4RUKlf9GAKHjkMGuJQhXADTGlLoDvilz+lJ/R5o/lQrGOhKLKYI80TyCvkst7/Qx8B8oAXRUt48FrU7ctJBi9fCzUnA0pqzxBYnA9gyAArVG7y/S0AgzrnbGUXqKrr/MaGxUBd3oGExIDxucpfAeMw==
Received: from DB7PR04MB4378.eurprd04.prod.outlook.com (2603:10a6:5:30::33) by
 AM9PR04MB8731.eurprd04.prod.outlook.com (2603:10a6:20b:43e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 15:58:37 +0000
Received: from DB7PR04MB4378.eurprd04.prod.outlook.com
 ([fe80::309c:a565:2bac:2f49]) by DB7PR04MB4378.eurprd04.prod.outlook.com
 ([fe80::309c:a565:2bac:2f49%5]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 15:58:36 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "shentey@gmail.com" <shentey@gmail.com>
Subject: RE: [EXT] Re: [PATCHv1 4/7] hw/misc: Add MU (Messaging Unit) IP to
 i.MX8MP device model
Thread-Topic: [EXT] Re: [PATCHv1 4/7] hw/misc: Add MU (Messaging Unit) IP to
 i.MX8MP device model
Thread-Index: AQHc57ja98hidgwy30Wqah+qpCMzH7YV5IYAgAd39CA=
Date: Sun, 24 May 2026 15:58:36 +0000
Message-ID: <DB7PR04MB4378D3EDDB537E85A9724C9C870D2@DB7PR04MB4378.eurprd04.prod.outlook.com>
References: <20260519175635.3245229-1-gaurav.sharma_7@nxp.com>
 <20260519175635.3245229-5-gaurav.sharma_7@nxp.com>
 <ead30676-71ac-4c50-8414-601019ced7a1@linaro.org>
In-Reply-To: <ead30676-71ac-4c50-8414-601019ced7a1@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4378:EE_|AM9PR04MB8731:EE_
x-ms-office365-filtering-correlation-id: 63b2ab56-7190-4910-ca9a-08deb9ad50ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|1800799024|38070700021|22082099003|18002099003|56012099003|11063799006|6133799003|4143699003;
x-microsoft-antispam-message-info: iGiM4+2Zw1MxIcik6+VJ/07WvP77t1h3y06w7BPtLWy7kQLM4utFNprgTlNLlmkSUUWGHubDZmZrFwMomXt0sJOspgFTMOv6P2Lx7zpr3O1KMrGwpdoppWYju7zoVQnXdALesaz9H5esGpK/+VydhYNaDG3p+kloiZtzWFGNGJvvToCNYs+DyES1wrCj6NLRefEsfDUd1FMQiaSDsJ2pVGo7DFdo4PAJnEXkZkubwUqRci3sv6O+zJEa97qtabf238lQZvQPrbeGwYG4P8DPQczHrFuK3b65pNINMUDPxaZ2oIwDbGIz+zLliuwUaeTW2wSrtseaS5pMcrVET4PgPmyT29N2e7ThDey8We7S1J0F97fS7gwWN3Ao0dQYMfv+l3Ad3NuqZ8yA62Q6RLQP/9bc3ULliwQ6scndTFFRiehap2HEUgeILu/r/khVtV7jyn03p5CwebfiICZiPXPu6nnlbLreTi6rdl1Gsgj8mJizXWyoBSvK0W04ZKBk2TuLK+zQ/wxGhvibkEiZi/dUHJOXwefPIWIJ11Uv6StiEUvu1JDHSg1Zmd8SreM40WfQ4yP+4fWchUi0WAOluX/7hAv+fK8g+UmyfAnZ/tVoMlo8u34aYVhs2Tctw6tKy1EQ/AjysYM7em8GXjsJRAtu388Ut58Pd1JQv9AS/yuLdhtqBTqHNpuXkH0slIWjJRCujwWP3wQnlxmAuojPk44ENCgNsolI5cLwNxeZyZTljjfERiaPBFlZSB0nYHJNT/IZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR04MB4378.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003)(11063799006)(6133799003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWhCS01XRTdzZVpaVE9SRVVTRmZBRWRLRFJCNUtYRGRFakg3dVlYUWFSZzF6?=
 =?utf-8?B?RlhtTjh0U2h3c2hIaUJQUXNTVUxLZDEyazMxRFYrOXNYanp6S1puUWhWUVF4?=
 =?utf-8?B?Q09LUW43bkZldzZtaXV1aU5sa2VZNmRyU1JPSFZOcHlvWmlFR0wzQlhUQ0FQ?=
 =?utf-8?B?ZzZKMkdPVDNsaXF5cFhtUWhHQ1hGK2R3SG82NGF3KzZTWXZ3Rk92THU5bDZO?=
 =?utf-8?B?L3dKSXhobkN5VGlDb0U4aHhSMnQ1NktQODJqM3BTc3ltajFQRFY3dnhIcnFr?=
 =?utf-8?B?OW9WYURhU3g3VEJ4aFQ0cGpGODBydWhKbUQ5SGdXWC94dFdqRGxmUllzdVZZ?=
 =?utf-8?B?L3IxOE52S0ZCNkVyNWkrcXhkdFM0ZHhySHN2UlhQY3ROMHByRTBSM2o3UGxH?=
 =?utf-8?B?ZlJEcUYzaUdoTmFxdmpjbW9tYkVRckY5Smd2SUNMaHkyeE9sYlZtd3JnQnRs?=
 =?utf-8?B?ajVaZkFORlRER3hOYU9Ibm5VdHpXWmtMbUlCU3RVeUpWanFuUnlTNTBxaVNS?=
 =?utf-8?B?eVd4TjhmcjE3MWtjei9XcHRxWUFsc082cmwzellKd3YvUTBOS2xjQ3o5TmF5?=
 =?utf-8?B?bTN0S09yRmM1SEY5MFR4Y0xvZ1Rnakg1VWJrTWw5MzRQa0ZVK0g4aldnUW1o?=
 =?utf-8?B?MTltb3ArTnVmSUF0S2czVWVxWDFxSXhvMy9YM24vK0wwREZKeForVFhqNU9O?=
 =?utf-8?B?M0hjc3UyQ3F5ZWplQWlTM0ZFbitNMVlZQUVJcFBOc0tGK3NaNFNKeVV1elJH?=
 =?utf-8?B?bG5TOFlTWkltVkNRSExRYlR3cmRYRkpCTGpLNGU3bGNFbE1mZ3VKaXJ2bkFQ?=
 =?utf-8?B?ak45ZzlrdFhua0hmWGJac0VVa3Z0anVpTlZGZmJuYjZEYWVUUTBzNWZob3VK?=
 =?utf-8?B?MUFXbWZaaEQ3YVhZWUxvT1A5VDhwblp1akN0RjlxMWtWVVZnQW9va1NVc0JI?=
 =?utf-8?B?VG42VWdBRUJlc0dPRG42NkFzTGsybUFZVUV5bmtuNitrY29Ka0wrVWxLTkFC?=
 =?utf-8?B?ekM1L1JJQmtLemdvbVZ4bFgrcXh6TlQ3N1dEKzA5M01yR1ZJV2JVa0hWSFN1?=
 =?utf-8?B?ZWpZWE5jdVpOZVRLYmN6OXNKd01mbVRpa25ySTg1K0hUVENmWXp4cExGenNY?=
 =?utf-8?B?SkEwUjJzb09SaVozU3JrRDRnWDA5SWxsaEl5YmJIWGdmQWxMWWxXbVJjQjJK?=
 =?utf-8?B?dFFMajgyUnZYeWtCekdGejBvTnhtdXBmLzNXNk5VOU9VMzhvZW90cUtyM2Q4?=
 =?utf-8?B?VWNNbEdLZWw0VFg1SjhqZTJxZ0hJRkN5Qk5LRkRUMURtRE84SjIyYlRUclNw?=
 =?utf-8?B?NEN2SXFMVFhJUm1VbTZGc3FiOTZLN3h6NkY4bmdwZE84VC9od2kvQ3VzQTUz?=
 =?utf-8?B?ZUFFWHk5K0tNaGtqZDlodXhHcmpPenNmOWZZTkkrdzVJcVZINGtwWmFUVUtC?=
 =?utf-8?B?anFDZ3gwb3BxZTVGNzdDNmVZNHRJTmpJMWY5bjlwUi91NExNRS9YRWpkNXh3?=
 =?utf-8?B?amVYSUZvZ0JWUWl4WG8vT203cVlieW9GUys5SEQxOVZaM2dhd01SZDNmdEdX?=
 =?utf-8?B?UzNBNlZSK2wrWDhNTkNqZ2RKUlZwL0V0dzVqT1RHbW9NdDMyd2d0cjBWSC95?=
 =?utf-8?B?d0YrYUZHUU5yMXpoMGs3VzdRb3MvelpSYU9oT1NZUWZCVUQwcnJxUytJSk45?=
 =?utf-8?B?STJwcm1KK0s2Q09Xc3NwSllVUnhMeHJMVkMycXRYaWxpbWhFL2s0d1AySmNp?=
 =?utf-8?B?VjhrNkZqem9lRm8vNkhGUjRGYTR4bWJCUDZtNjlYOTFpakY4enMxUEN4MnVB?=
 =?utf-8?B?NldkWm5CWFliU0NPOEtuUEM5Rm9FdDIwOUVLeUsySDVvSyszWHBhOHhCNlc1?=
 =?utf-8?B?ZUI0MlYycEVRVlQrKytyN3Jkb1ZJQjlzNnZTVENXd2Zydmlzc3RqZUJ4bWdp?=
 =?utf-8?B?Z0pBbEdCeEg0dHVQNnJFSXJBdHZBd1lqcEE2R3QvNmk1d3RvVVU1RmhwYnFa?=
 =?utf-8?B?QlkvQXViQWpZbk1TeDc4T1NOMDNSUzRsMVhoVUZaSXEzRXRYRjhKR1ZvMks5?=
 =?utf-8?B?K25CaDdZY2xPd0grWFZkRFBGdk5ydXhXbmU4R1RiMXMyOXBqdDdDeGczRkxP?=
 =?utf-8?B?TnlDTlFaVzlHTmIyOE0rc2ZuZ2N3b1laa0hTNHphNjAxUlBNWGFsNVBjUXVt?=
 =?utf-8?B?REV0SWpiazVwczdBTHpyWmVLNDFJbVNZbkRuNDVySTZqdG04c09OQ2hLSHVn?=
 =?utf-8?B?dzlHelV1L1YxREhsVmdTV2RNbjZtWkVTNGExanNsblRySUQ5U0FqeDJiYmN3?=
 =?utf-8?B?UjhqSmRGM0FrYm42TEVUclQxanZVYmZJTVdHVEhOM01aOWRBYmN4Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4378.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b2ab56-7190-4910-ca9a-08deb9ad50ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2026 15:58:36.9119 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ehcQ9b/R4HrWoGkskRqcfsRMuzq23eIYlbKgMVB7kkiqzikCk+45K2kwH1RVelfTmqcXzAGvhL1X0Yn3cNER0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8731
Received-SPF: permerror client-ip=2a01:111:f403:c207::3;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhpbGlwcGUgTWF0aGll
dS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMCBNYXkgMjAyNiAwMzoyNA0K
PiBUbzogR2F1cmF2IFNoYXJtYSA8Z2F1cmF2LnNoYXJtYV83QG54cC5jb20+OyBxZW11LWRldmVs
QG5vbmdudS5vcmcNCj4gQ2M6IHBib256aW5pQHJlZGhhdC5jb207IHBldGVyLm1heWRlbGxAbGlu
YXJvLm9yZzsgc2hlbnRleUBnbWFpbC5jb20NCj4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSHYx
IDQvN10gaHcvbWlzYzogQWRkIE1VIChNZXNzYWdpbmcgVW5pdCkgSVAgdG8NCj4gaS5NWDhNUCBk
ZXZpY2UgbW9kZWwNCj4gDQo+IENhdXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBs
ZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBsaW5rcyBvcg0KPiBvcGVuaW5nIGF0dGFjaG1l
bnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQN
Cj4gdGhpcyBlbWFpbCcgYnV0dG9uDQo+IA0KPiANCj4gT24gMTkvNS8yNiAxOTo1NiwgR2F1cmF2
IFNoYXJtYSB3cm90ZToNCj4gPiBBZGQgZW11bGF0aW9uIG9mIHRoZSBNZXNzYWdpbmcgVW5pdCBh
bmQgd2lyZSBpdCBpbnRvIHRoZSBpLk1YOE1QIFNvQw0KPiA+IG1vZGVsLiBUaGUgTVUgcHJvdmlk
ZXMgaW50ZXItcHJvY2Vzc29yIGNvbW11bmljYXRpb24gYmV0d2VlbiB0aGUNCj4gPiBDb3J0ZXgt
QTUzIGFuZCBDb3J0ZXgtTTcgY29yZXMgb24gdGhlIGkuTVg4TVAgU29DLiBJdCBpcyB1c2VkIGJ5
IHRoZQ0KPiA+IExpbnV4IHJlbW90ZXByb2MgZnJhbWV3b3JrIGFzIGEgbWFpbGJveCBmb3IgbGlm
ZWN5Y2xlIG1hbmFnZW1lbnQgYW5kDQo+ID4gbWVzc2FnZSBwYXNzaW5nIHdpdGggdGhlDQo+ID4g
Q29ydGV4LU03IGluIGFuIEFNUCBjb25maWd1cmF0aW9uLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogR2F1cmF2IFNoYXJtYSA8Z2F1cmF2LnNoYXJtYV83QG54cC5jb20+DQo+ID4gLS0tDQo+ID4g
ICBkb2NzL3N5c3RlbS9hcm0vaW14OG0ucnN0ICAgfCAgIDEgKw0KPiA+ICAgaHcvYXJtL0tjb25m
aWcgICAgICAgICAgICAgIHwgICAxICsNCj4gPiAgIGh3L2FybS9mc2wtaW14OG1wLmMgICAgICAg
ICB8ICAzOSArKysrKw0KPiA+ICAgaHcvbWlzYy9LY29uZmlnICAgICAgICAgICAgIHwgICAzICsN
Cj4gPiAgIGh3L21pc2MvaW14OG1wX211LmMgICAgICAgICB8IDMwOA0KPiArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIGh3L21pc2MvbWVzb24uYnVpbGQgICAgICAg
ICB8ICAgMSArDQo+ID4gICBpbmNsdWRlL2h3L2FybS9mc2wtaW14OG1wLmggfCAgMTAgKysNCj4g
PiAgIGluY2x1ZGUvaHcvbWlzYy9pbXg4bXBfbXUuaCB8ICA1MyArKysrKysrDQo+ID4gICA4IGZp
bGVzIGNoYW5nZWQsIDQxNiBpbnNlcnRpb25zKCspDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQg
aHcvbWlzYy9pbXg4bXBfbXUuYw0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcv
bWlzYy9pbXg4bXBfbXUuaA0KPiANCj4gDQo+ID4gK3N0YXRpYyB2b2lkIGlteDhtcF9tdV9jbGFz
c19pbml0KE9iamVjdENsYXNzICpvYywgY29uc3Qgdm9pZCAqZGF0YSkgew0KPiA+ICsgICAgRGV2
aWNlQ2xhc3MgKmRjID0gREVWSUNFX0NMQVNTKG9jKTsNCj4gPiArDQo+ID4gKyAgICBkZXZpY2Vf
Y2xhc3Nfc2V0X2xlZ2FjeV9yZXNldChkYywgaW14OG1wX211X3Jlc2V0KTsNCj4gDQo+IE5vIGRl
dmljZV9jbGFzc19zZXRfbGVnYWN5X3Jlc2V0KCkgcGxlYXNlLg0KPiANCj4gKFdlIHNob3VsZCBy
ZWFsbHkgZ2F0ZSBpdCBpbiAuL2NoZWNrcGF0Y2gucGwpLg0KPiANCg0KV2lsbCByZW1vdmUgdGhp
cyBhbmQgdXNlICdyZXNldHRhYmxlIGludGVyZmFjZScgaW5zdGVhZC4gV2lsbCBkbyB0aGUgc2Ft
ZSBmb3IgR1BDIGFuZCBHUFIgaW4gdjIuDQoNCj4gPiArICAgIGRjLT52bXNkID0gJmlteDhtcF9t
dV92bXN0YXRlOw0KPiA+ICsgICAgZGMtPmRlc2MgID0gImkuTVggOE0gUGx1cyBNZXNzYWdpbmcg
VW5pdCI7IH0NCg0K

