Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14518CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENbK-00083r-2c; Wed, 07 Oct 2026 05:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xEM8P-00032x-JA; Wed, 07 Oct 2026 03:32:26 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xEM8M-0000SZ-R6; Wed, 07 Oct 2026 03:32:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxqY8ak/pdIqQPUbPTNJJ7OL73dU5ToH5F5X6QiFeJCRvM57UYynKNXDsl0HHJdjA89Vwmr5LyRy21hYSQ9UNVDXVrAJhOO0QT/HoCsqwLTXrdKdcMmQXQMAJOc3mpteDm2OpnFGcqHmm9GxcBhvlgPndO72TaPHXxYO85oh1MXx6zZsU8bVRecYMtMXZarbfp44XUy3CImUhLAGeq0NJ1u6w57sP07PVapUnZ032uJpKkP15NrzRTzMABK8btHm3QqtaACdrCKw/wMGs6X73B/84Vq6oPSSuDLuHdGlrFzm13x1ta2heyP0sAKT/yhzsHeU6iP0HvPVtV6WHqUabg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o81Jk1XJ6LPVaY4LDmYo+5fWnwO4Dan/AHe2q9iO/EY=;
 b=w1qFf0RGy5IimnguXwx+02DddJ2k3BO7CSOPx1fc9YISQHzIx60mW+y42WhlvfW0M5qLt5P2vmqHI9PDn8hs58cI2695k+QJlSLpNuykOc2HD0sjGCEndO25exk2sEN4iOTHGuOdno4TbJjfQlmYeDMmmC9q7sGTQZlVnEK2pg+RA+jCtyBSTzE/gxozhFBUpu0Xa+YbZBZVK+9mB2BgQsvqQrfDIIsjxTUTWxcZbzI/93KxIPDZ9EA97Nj/7bgKlA5O9Z62O+nlBbXkhsVBH8QnpMY3itGTltcHbmzXZe7Z1zYFZ/piaOI4RsnV0e+OlAtN/cUmtOAQluDnk7LP0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o81Jk1XJ6LPVaY4LDmYo+5fWnwO4Dan/AHe2q9iO/EY=;
 b=BLo3vpGfg7GZuLiChFBzFOMh6Lbgq/cduzr9VN7nxgOEsUzPnMPixqh2ZPfV3NXawrFaFc37uaEtPKqGQqxhVnSO/HDcL5gWCoDRuCfLjbTec+tRmmbRNqsKJac+TwlF+ndnb5tm7sPFABF2X2KBL0W+2mK/cjXpk8zlJ/mX1gIDXrNnDzZPcs2zNRvb98T2MGqvDlmGGeDgc55VrzksVsyn/TmtxOtF9EjZpwsmu8jQHwLCFReGNKzBMOQXBCu4AiqNUzrMxfKfpfQNUzy9G9GLgFC7LFGjsO0NTswk4a/4QawRw1r5+aSlVbJoSP5Nny/NtWfoYYReSW85IaydHQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUYPR06MB8699.apcprd06.prod.outlook.com (2603:1096:d10:94::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 07:32:07 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 07:32:07 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>
CC: "clg@kaod.org" <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane
 Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v2 4/8] hw/usb/redirect-server: Announce the exported
 device
Thread-Topic: [PATCH v2 4/8] hw/usb/redirect-server: Announce the exported
 device
Thread-Index: AQHdVHh4Oph8AUs4jEqkyS+vBeY97LbupqoAgAL9AcA=
Date: Wed, 7 Oct 2026 07:32:06 +0000
Message-ID: <SEZPR06MB736285C578C5673E2A8432BBFC942@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20261005032022.3980903-1-jamin_lin@aspeedtech.com>
 <20261005032022.3980903-5-jamin_lin@aspeedtech.com>
 <179119075847.699310.8612404871730252132.b4-review@b4>
In-Reply-To: <179119075847.699310.8612404871730252132.b4-review@b4>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KUYPR06MB8699:EE_
x-ms-office365-filtering-correlation-id: 00b04b9a-9cb2-46b7-520f-08df24451735
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|38070700021|56012099006|4143699003|10067099003|18002099003|6133799003|22082099003|3023799007;
x-microsoft-antispam-message-info: iHL6UlQGBlJyoG0p4lQoCKHO+7N947ry0Zpv7S7zTzI01Depo93G/VgiqdZ+7uO3ZqGmUyXQd7k7vqAbZR92Snd0DC10NrRomxeij8L6uJGHkd1x4QApWCDA2TXplQUrKyq0n8u52N8XqA0BOGgT+n7ifAMpH2pqw7VnHnxnuj++kSqs1lmEHrOWkJK6BPEgGZQv4KjpyTKaj1gcBgot3eUXAx8rKwq7n+WVIMTiKFJ8lyxPnfk7NcFD8mH0XgcqaPNeGOlG1tqGbCl/vEvTYUArQlE4a7cVyJ9yASJXjaYpMejC9HeHdS96YTvLwbSGOSCyiT8bkPlEFFFyUHhX8EOxpSINTB+HJzRPkKiTacIB8PaOEyWxZRo4+8zIk5a9O+EyMNQb6zsevY0hKpZU+VR5nX8TGtFAPKRlSRauuoczKovA/s7AWSNtj0gl1U38CDvWumraibUstGvoGB2SLgZ0RvuSwPLLL9AokcvuiLQ60y4A+Utj4gCEYlIfzTyJIR65cVaHp0oFzCK1/6R7EAvFgPUxRfzSqi5mq7pFHTAgslY+xNRQ6QXFXc+hOfGPfmpejnBGRvkrkAY3TOOsJ9H0rS4D+EQ3AAKgEdf49DX3KIR0FsTA9j3pqQ/kKnQMZ7+BvkXHI+WfDaaCDrDQrJj59nRTGJwbxTzABdd/QD6WekqVurdr/HCCgU62/JBUrBivgW7YVT1F6AZ7RvbMgG/RxFAtzCP34uiHVFiBhhg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(56012099006)(4143699003)(10067099003)(18002099003)(6133799003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bS95N2gxRmRtR0lvaVdFNEtGVkludzk2OFdoSUJnTVAyWTJ1U0VtN1dXMDRP?=
 =?utf-8?B?LzdKUVgrMWlGNmxGeG84U2FaUFIyZDcyZDA1bE1kenRhaFYrdzIwL2FFRlZ0?=
 =?utf-8?B?aEtTQ2wrKzlpbFhIVklWYlB1c1NhY3V2Y1kzWnZzbCtyZnV6VXFhYTk3Ujlj?=
 =?utf-8?B?SFRabHNKbnErNS9NQXV1YjBTcXMvTWYralFGWnp1eUsxWEFEWlJqWWh3aExi?=
 =?utf-8?B?R3dlR1pSYVZXT0lnTGZmUWNpUlhQVmFUeldYMlV3K0RycGJhVEhoUnlJWDdE?=
 =?utf-8?B?OTdhSlVvTlVKZlBEemJpNml5UjU1YjFGamFYWkUrS2wxQXVpV0ZzZGgxVmxG?=
 =?utf-8?B?SUxub3Y3Sk9tS3owQUtUQm9ZbVIrR0hSMzVnS0Z1NW1xNnV5ZUU0bUM3citl?=
 =?utf-8?B?ejBaQlZXNDdmeVNqWklsYXNETEJhSUoyaGJZa2kwMDlPNHZiNGhvNHh4VGFo?=
 =?utf-8?B?S3ZVaDhaZDg5TXNPVTltZGRTeHZRVG0vdWsxSVZWTGtLVVE2Tnc2blpBQ2s2?=
 =?utf-8?B?VHpFNG5NTW9OOUpKWkszRzdESXdVSVV4blN5QU9ucGkyeGlYWk9xazhNdEZ3?=
 =?utf-8?B?MTR5MytkbHg5QTlENVl1UlBVSlh6cXhJYysraFNBZTJ5MitmNEtLTFpoaHpr?=
 =?utf-8?B?c0JFU2czOGdsNGdsSUx0S2hKWkdLOWQwb1Frd2FBVW10U2hyYVFKTkJ3eUZ5?=
 =?utf-8?B?ZWhRRm1IaUtpUlhnc290REh4RlBqWThLREh5SWhVNGl1MkltYnV5OU5PSHdI?=
 =?utf-8?B?ZGMrZlh1TWtvejVtai9uSmp0aDNTeWRrTEpPcWlDWExRQU9kdlBrTWJURDVB?=
 =?utf-8?B?WU55Y0NGNmxzamNpVnB5NkhxYk9xcEIrelV2WDlyK3NxK2pDUlJsVWFJVDkx?=
 =?utf-8?B?MzM2ZjFDSUdUZGIyTHJ4WStuZGJmcXNkbTVYdTlERGpqUndaMzBKUXMraURw?=
 =?utf-8?B?UGVNeStKNEZmUTlYSUdIZlMvSytkNWJpL2hveUlRVEtMWjQ3U3VVNUVGL2lF?=
 =?utf-8?B?WlZFN0x4S0srd0xRWUxUamtiNUFjdmFLZGVyTDgvRzhBcVFvbTdMcW5HYlFk?=
 =?utf-8?B?SEFzR2svd0UwNTR5bnViWUsvMFdMUG5ZVkNEM3VmMVNHVkdvWTJqQjFlZWF1?=
 =?utf-8?B?TTZWRnhyeHNzRHJiNGJ2cnZZYUFYVldITVNzUFlJcUhpZGIwclA2ZytseXBw?=
 =?utf-8?B?d0RBL0d3VlkvSmZrU0ovQ091Z1lwN3ljQ0J3ZWhyK1EvVEsxZVBvRnFMYmdh?=
 =?utf-8?B?WkRqMW40M3lQZ25MeVdZLzFWeU1XUS9zUE5sdGZ0dWFTc2Y3U1o0MWpTNllk?=
 =?utf-8?B?TkJrUHBwdER2MU8xRGhOa2RrU2t6ckVVYTc5ZlllQWlUSTIwMi9ld0tDNXc5?=
 =?utf-8?B?R2VGcGphdXBoV2ZlMEtSaEo3Ykw3VVhkVXdwZ0dEU2FBWFVzZkxWVHlaL3cw?=
 =?utf-8?B?dzFaeU53RkZyTy9tWU5OQlNHTEs0VkFWZ1F1UDF2V2o2OW16Mm1SekhpMFdD?=
 =?utf-8?B?TkVybVlEUDErVDZSTXVJc2ZDMmpwQUgyV0RKbzI3cnhWNVpzUjlGR0NDMDhS?=
 =?utf-8?B?aDlwM0ZSajErcTF6aVQwZlRoUkcrbWZwZlF3UzFUUzBNQlU0N2xGaytZc25W?=
 =?utf-8?B?MFhHa1MvKzRKMXpmMEVRZmYwdlBTY1llMXNZd0NESVJ6THlUMFpPTlZrRFVS?=
 =?utf-8?B?clR6bW5wT3JsQk5nRHluMnJVK2ZOcHI0NUxWTURtUVhjZGQ1Y3g4TlIxZ2VW?=
 =?utf-8?B?Z0QwbFI3UXhPMDV5dWd1QnJOWlNxRHVzOUhNQUs0VGJSRUxNVXJ1ZDNwUXMv?=
 =?utf-8?B?WDNxUHlmNFEvVlNxRk9aaG9sRk8wdE9aTFhqQXlhaHV5L3RWV2NIUmFFbEt2?=
 =?utf-8?B?ZXZiTExWTXdvU1lnWGp0V3BFaFpiZDBHbEwxbHRjQ0FrMVdxcFFiMmIwSktW?=
 =?utf-8?B?VmMwUTdISXdhVG5kNWlmekhtWHlMWWVxNWgzVHNMVHZ3eEVYTU5CdHFlL2Nh?=
 =?utf-8?B?cVRGZ3p1VTFFNzBHY0tFUXhVZk1lanI5Q3c2YUp2N1gxbWI0RGFCc2ZxZ0xJ?=
 =?utf-8?B?RWZCSTR2QlA4NFFPNmxtOHMvSVZwUkN4L04zYldUWjdPaWxkS2NORXRlM1kx?=
 =?utf-8?B?OVoramNhVEVhV0wxdW52WFR2L2w4eFVxb0NLZ2p3L2FmcE1wNVgrcmFQZ3pF?=
 =?utf-8?B?cFkrVWwrVVg3Y2VReGkrUnhwbjFNc0FaTmthakxMM29DeGE1aGQrTU9iUGpk?=
 =?utf-8?B?TXMyd1RxVjkzcm5rV0FjeVl5WXhqb0NhTW9GZzV4dFhGcWUrOEptYUl3OHZ0?=
 =?utf-8?B?TThYbmZkZThyUHFkMkd1c3pzdWFxNGtuY2dIeFUxdmpHUzBxL3pidz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: z7vaiUxlaabz4QNwX/9kRYC7gchCNBKg8WjLhyT+qnNajyNFvhEP/BaiGaFYPd1qhbVobxDGgeQzFWhoMh7pgD4vf/peaLozaQUjP5yAf+0oQhKoAMFHiB+yDGW8ZMFLSAmd0U9BnYJSD6Dnl36RHSqBWlAb487ZN6CsxdQpw7wd9YwoRXkgUO4f72Bplp44N9LuAVdSOfZIK/muL1VgH8RNr2a8nRGiXHtZgFT3Fr3avazVZWLuamxLODgt8GoovTduIFg6JHOmuGdLfU1irZgoon09NrnkMNLFvu3elZTVucVUNSa/M1whRdCDg0NidrASwKY99L92mFbFPltSdA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b04b9a-9cb2-46b7-520f-08df24451735
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2026 07:32:06.9621 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lILlFFSFtEvyEcMgWeQdiW5DrDKbBrTPgAHBWlk+vgdtyd8LGAydtwqx890I+rtz+gPmN6nxMtOZqxfcUV4XGcIV6a2iIwLnp6ef0OtHlaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8699
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgTWFyYy1BbmRyw6kgTHVyZWF1DQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiA0LzhdIGh3
L3VzYi9yZWRpcmVjdC1zZXJ2ZXI6IEFubm91bmNlIHRoZSBleHBvcnRlZA0KPiBkZXZpY2UNCj4g
DQo+ID4gU2VuZCBkZXZpY2VfY29ubmVjdCB3aGVuIGEgZGV2aWNlIGlzIGF0dGFjaGVkIGFuZCB0
aGUgaG9zdCBoYXMgZ3JlZXRlZA0KPiA+IHVzLCBkZXZpY2VfZGlzY29ubmVjdCB3aGVuIGl0IGdv
ZXMgYXdheSwgYW5kIGhhbmRsZSB0aGUgYnVzIHJlc2V0IHRoZQ0KPiA+IGhvc3Qgc2VuZHMgYmVm
b3JlIGVudW1lcmF0aW5nLg0KPiA+DQo+ID4gV2FpdCBhIHNob3J0IHRpbWUgYmVmb3JlIHNlbmRp
bmcgZGV2aWNlX2Nvbm5lY3QuIEZpcm13YXJlIG9mdGVuDQo+ID4gdG9nZ2xlcyB0aGUgVVNCIHB1
bGwtdXAgYSBmZXcgdGltZXMgd2hpbGUgaXQgc3RhcnRzIGl0cyBjb250cm9sbGVyLiBJZg0KPiA+
IHRoZSBob3N0IHN0YXJ0cyB0byBlbnVtZXJhdGUgd2hpbGUgdGhlIGRldmljZSBpcyBvZmYsIHdl
IGNhbm5vdCBhbnN3ZXINCj4gPiBpdHMgZmlyc3QgcmVxdWVzdCwgYW5kIGl0IG9ubHkgcmV0cmll
cyBhZnRlciBhIGNvbnRyb2wgdGltZW91dCBvZiBzZXZlcmFsIHNlY29uZHMuDQo+IA0KPiBzaWdo
LCB0aGlzIGlzIGdvaW5nIHRvIGhpdCB1cyBhcyBtYWNoaW5lIG1heSBiZWhhdmUgZGlmZmVyZW50
bHkuIEkgdGhpbmsgd2Ugc2hvdWxkDQo+IG1ha2UgdGhlIHJlZGlyZWN0LXNlcnZlciBtYWNoaW5l
LWFnbm9zdGljIHRoZW4uDQo+IA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcgYW5kIHN1Z2dlc3Rp
b24uDQoNCkkgYWRkZWQgdGhlIDEwIG1zIHRpbWVyIHRvIGF2b2lkIGFubm91bmNpbmcgdGhlIGRl
dmljZSBiZWZvcmUgdGhlDQpmaXJtd2FyZSBoYWQgZmluaXNoZWQgaXRzIFVTQiBpbml0aWFsaXph
dGlvbi4NCg0KSSB3ZW50IGJhY2sgYW5kIG1lYXN1cmVkIGl0LiBPbiBib3RoIGdhZGdldHMgSSB0
ZXN0ZWQsIHRoZSBwb3J0IGF0dGFjaGVzDQpvbmx5IG9uY2UgYW5kIGRvZXMgbm90IGRldGFjaCBk
dXJpbmcgaW5pdGlhbGl6YXRpb246DQoNCiAgWmVwaHlyIG9uIEFTVDEwMzAsICJ1c2IgZW5hYmxl
IjogIDEgYXR0YWNoLCAwIGRldGFjaA0KICBMaW51eCBvbiBBU1QyNjAwLCBnYWRnZXQgYmluZDog
ICAgMSBhdHRhY2gsIDAgZGV0YWNoDQoNClNvIHRoZSBkZWxheSBpcyBub3QgbmVlZGVkIGZvciB0
aGVzZSBjYXNlcy4NCg0KSSB3aWxsIGRyb3AgdGhlIGFubm91bmNlIHRpbWVyLiBXaGVuIHRoZSBk
ZXZpY2UgaXMgYXR0YWNoZWQsIHRoZSByZWRpcmVjdA0Kc2VydmVyIHdpbGwgc2VuZCBkZXZpY2Vf
Y29ubmVjdCBpbW1lZGlhdGVseS4gVGhpcyBrZWVwcyB0aGUgcmVkaXJlY3QNCnNlcnZlciBpbmRl
cGVuZGVudCBvZiBtYWNoaW5lLXNwZWNpZmljIHRpbWluZy4NCg0KVGhhbmtzLA0KSmFtaW4NCg0K
PiAtLQ0KPiBNYXJjLUFuZHLDqSBMdXJlYXUgPG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbT4N
Cg0K

