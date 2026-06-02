Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2357BC5DF71
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 08:22:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUKOH-0006aE-E9; Tue, 02 Jun 2026 04:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUKOF-0006Zq-JZ; Tue, 02 Jun 2026 04:22:23 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUKOC-00061c-Ns; Tue, 02 Jun 2026 04:22:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YmWAB3zd0UZooJzQ/plBWM1vzz3us514rsVC//Grk+T5xuhgXqjBz/7D3Gcvg47fVBIctxX+EODvVoETDD/W4EFoF5akOjwFV8W52N7lcHlwEdxRuAveN3eBh21xHtGJ2ad5Rvboe4kK7n/S1wxL/dTjBWAQnnc3HSsHnLTjPVoVd0CHKRYYVC2cfvxpY5yNugnQPAW+GuSXrOqr7wzEZh+dfnV0zpJ2cJs2N98DzPlSfj9k347/r9NB10NngaRTbUt7HPOR9WuVKY/sdFa5KGS0ljxA9yeZVOI/gopbVrfw7PbHbOTCuWLci9A10a7+UiDcxWMEQny/uFP2+GIlvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zg3AQZF4f8HwVFdY3tVKmdZDlle+rwGJSC8c6PGmwt4=;
 b=AMKljisxBmp/WQYMzkcW4j77iwgMpALrcKlOhvkdHqx0mA6iEtCKN6R5rAoP8N6pinhg6Cp7hndqg6AnNqq571EO81jPrfNmghLfIVP1bGS8dJUF6vSdzkRqY5jeTNbTmmIAYjOAfAopfnxLVGjAFrVg8/yjmpiaB5VqNnJzuCpcevgbv0/GEpMJNAhD6qAhs2635UYmoer5XHMaf7KBKCRbDCvcaxET2VwdbXkB7Kpe3ioMacJlcDtIRab5zwJkTvNPicLWTWMnzOpLriJb+345bAX0VFag/+LSUrEl8ZcNCX/zJCfnl+G/IH3okzSpDg737R7U1JYIBubzX55pVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zg3AQZF4f8HwVFdY3tVKmdZDlle+rwGJSC8c6PGmwt4=;
 b=eQNtE9p5a6x1l2UGDiP+nWL/R4OnyWrSUfqu/Fu6efu8/xb8sq1bVmmDYcIsMGh52/AHU6j4owtL51taEPWCVATHdoSmwp4/d5NHv2l+ywDpAm4XjuIJgk+vRg91G9cflscfz/+NdwitVOa4/Dw/URUGeKh3EPa1NNmCZdUYCCMqpxdQayCqYPmn4k6K1tzXwdEj+DXYro4nkEMKY2j3UdaYrA2jBS8wubv0sweq0PzcBgpf5sQh1t1eqJDHGEIR2+dG9WSD6DNYAqnwndNAXTJdSoXPYDjG9J1Euyy+9x9TVHqmi6W9LwQKhy0Uw05WT1E7+qjoGyUCb8pH6TOxqw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SE1PPFA7A817EB8.apcprd06.prod.outlook.com (2603:1096:108:1::424)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 2 Jun 2026
 08:22:11 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%5]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 08:22:11 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v2 02/10] hw/i2c/aspeed_i2c: Increase AST2700 buffer mode
 size and adjust offset
Thread-Topic: [PATCH v2 02/10] hw/i2c/aspeed_i2c: Increase AST2700 buffer mode
 size and adjust offset
Thread-Index: AQHc8lClfE7j1h0c1Ei93ZJaqVx8drYqzrmAgAAeUAA=
Date: Tue, 2 Jun 2026 08:22:11 +0000
Message-ID: <TYZPR06MB4980EDA5969F29F92A5B12D7FC122@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260602052827.1535299-1-jamin_lin@aspeedtech.com>
 <20260602052827.1535299-3-jamin_lin@aspeedtech.com>
 <5ce16ff8-4b29-4e83-925b-621c8ecda57c@kaod.org>
In-Reply-To: <5ce16ff8-4b29-4e83-925b-621c8ecda57c@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SE1PPFA7A817EB8:EE_
x-ms-office365-filtering-correlation-id: bcc477df-44d4-437b-3fc5-08dec0800ba2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|22082099003|6133799003|18002099003|56012099006|5023799004|4143699003;
x-microsoft-antispam-message-info: IM6TvtIqn15Ch2PePnB6THCSIq4gHL3t8n4Q5JKjVJf3rsBJUiEzbOLKkwjI3Mi6VPlIgdMuytQMTKNcs44Cr68hgx6+wQpVYVqYVwL/u4XkDIejEuAYL1NVE+ih40Bl1NN/Kl3uB4fIx8IX8fhNaQ5W/jb6v9XrLDnqbScY2uLPWYAnWTEnkLs9Hi9W0fWjl+JJRe/e9n1GBFMeTEJPWKUU7NRUSMDCEp9vMzKJtcu4HllGq51l4pGI5DQiCbp4Pk9Lf3EfelZf2RYrTEft/8DmFab3Vpt0a+gNakhPJRCcRMgsJapZ/yD4QPDu5wtyL0Q31FuP9K/WkVGIjU//ZDV/8BBuH1pCutwCehWGhCkHLxVKSM09upeR6tqm+EJBQGvvURLxqSln6a9pikK1yesUIBZC8zzW6GqV1uGuyk4ALlybtloHw2q0f9f7vouitmk1rW6g9AF/BtfRjhEBLtrgFuYa/PXrrV3dUyoGHknjujyyH/BIawPnetEQ89zkbG1QwRtO/vnrTw03GSqoWqf63O5yYEQIXruqQ78qL54d7gWLiQsMxd7HZDoOZEO9RoOBJC5D0V2a7PEv4AB+xvJGNuOKo77Wrm4loTuv6/uz19CH1Ye/6pj6cS6gJMw+ZWGz9T0oO6SK94tO8bqYNJcQFOilHggILjGZc21xfAlXbIvDzkKKqmyh1WT7bMx7OdXCjeh2SxfCSLAEa8TpCf2Lh14tA18LM+8T5N1l1PxeVpOdFDtDXlLpvxdPpg+G
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(6133799003)(18002099003)(56012099006)(5023799004)(4143699003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXlocHQxYW1UYzRNQVJwaDhOQ2dpdXIwWmpRYTdvVVFqWnNpbTNQTEYyejlF?=
 =?utf-8?B?a0dHNHFZVzJ2QVNsV2dVTUtCM1k3VURYNnprRHRPcERwQ1RraEt4MlhTSmNF?=
 =?utf-8?B?NFJNanltKzdnMmZ6Z29tV2kvaTdrSEtmZFhkRy9hWE1PeDN1R3JUeGRjK2Jo?=
 =?utf-8?B?L3R5REk4dnZBbEY1L1d4N1BhN2FhRWJMMUVQZ0Rhc2MrZ1ZMbE5KUWJJNzIx?=
 =?utf-8?B?UVcxV2VXWnZ4dWxCRDFPSTNyZFdQUlJ2aU9QL1F3WVM0dHJxd296MEkxMUhN?=
 =?utf-8?B?eTRxWDRvUE1COGFCMEZGdklyUG9uWUl5cUoyWElUMS9lT2F4cjRMeTFOc2lp?=
 =?utf-8?B?eXY1QndxblFBcFkrSGJRMWNFckkrVHQ4MmViNVFjRGhZaitJY3BRRU9LQWtS?=
 =?utf-8?B?ZVBGalJIZVUwZlRGZFVWUDBVVDRnZ0tEZFZjM0ZPZkRqV2Faa1MyQ1ZLcUFN?=
 =?utf-8?B?eG81VmhNaHZiME5pRExNY1hDSGZWRXZ3cTNsbGRNb1N3WHVQZzRsdlFhWW9j?=
 =?utf-8?B?dTQ2c3hWSm1uUGhVK0JXR0pucG9MTVVrOUJlbmllTnRXTTBidEZ4T3ZQWStI?=
 =?utf-8?B?S3ZEVnphTkpiSEZZQ2RBVmpSbGNEcjBCVE5aUEN1QWtNTnpYWlRYdThLNzM2?=
 =?utf-8?B?MmlOdHpGM2hKbStQQWJtMFk3TzRjdFp5eVppRkNvY0lLeEQ5bGRXWU1ocHhX?=
 =?utf-8?B?RHpLM0NuQ0hqRFdxL0ZmMFllVzk2NFVTYTBoR1JaSjRoQitDbFhPV1VnYmdS?=
 =?utf-8?B?enpVbVdUamR0cmxhQ1RDbXJvZGUxUmxwWXdrWkNxcVBKOEpkTll4UElXaFNt?=
 =?utf-8?B?VWRlY3FycUJMeGQxZ21qY3JvQVpuUHM3WEQ5ZEIrSTg1TUdpbDZWbnFsemhY?=
 =?utf-8?B?QWkrWkczUzVwUVNOalZPclh6bDEvZm9lbG1kc2loK09RaFUrQXYrcTcrUVRJ?=
 =?utf-8?B?SDdiZjhkMllWR1ZRSkxJdEk5aWUwc1ZaaWpDYldZUENxQW9XcTdFV24raHZF?=
 =?utf-8?B?a1NHbWFRRGs5a3BKN1FKUFZsWlMwVGU0Mm0rdkR4WXFTeUVUZzg2UFRhQllj?=
 =?utf-8?B?MGxPSVBQalJRTndIT0s2TGlXNGo2RkZOcE5FSkxwWHU5NC9STTdHK2N0TlBl?=
 =?utf-8?B?NG9WM1VPWE1nY09zbm5XaDU5SXEza0Z4aElKOVdwZExxV2lNS0U1Wjgwam96?=
 =?utf-8?B?SWozVnkzY1FEN2dJTVozaXQvL1RsSzVEQm1rSStHNE5tcnRPL0p5UENtR1Aw?=
 =?utf-8?B?VFowaTU0Ukp6dStjQWZaRWRzc0lCR244bFdqajd5L2pCRUpGSDhUQVNCQzFE?=
 =?utf-8?B?RU5UWEtjOHQ4UlJvdzl3TVJrTWpXZEtqQ0E3akoxOVRYcGhhZ0lLMTdjVVpC?=
 =?utf-8?B?RVBlalRTR0pRN1NhWUt3Z0Z5WmtnVCt2NUZ0ZVBKd2IyQXlqRzd2VmdNaU12?=
 =?utf-8?B?YUpMT1NjOEx0enNXM1JUem11NFY3U29xOE0rdGV0MGEwWXh5OWdneDdEZVdQ?=
 =?utf-8?B?Zm1HaXJxSmwyamJkczkrcnluR1VnSHRTWFVacHFOZTdyN3F4VkJPK3RxOVY3?=
 =?utf-8?B?SHpWMStMTjY4NllhY3FWM0FsamdFbEJwU2ExdTZvdmFLNVBMdnNwbzBtRzZ3?=
 =?utf-8?B?T0hhaHR1cFlpMlFIT1Z5aWYyeEs0ZGlKWXR6OFQ2WDEvUThmazlRNmdFSHVm?=
 =?utf-8?B?US9McE5kdGNqajdnNDVZZ1d2NWRTbzVIY0hJRTFra2ZVODlPM0NpSWt6UkRt?=
 =?utf-8?B?WUpCcTZ2YTBmc2FSaEtVR2l2dDJrYm5tMlowclhJWWhpOG1xZFBSeDlKaTMr?=
 =?utf-8?B?YU9namxXNmZoZjh0SWpya2h2ME5pcWJaWmh5REVqZUhScnhWakh2aHU0VEhL?=
 =?utf-8?B?UjFVbUZoWDZJZVpqOGJLZTBsTXlZTFNmMS9JbTNSaDJmVDJ5aDByRTNDTC9T?=
 =?utf-8?B?bGZtdVZLb05JdWpFdEVtdytTQS9PdVFXakFENU5seW1nNFdZMG8rekRtRG12?=
 =?utf-8?B?NklJd3U1Wk0rM3ZnaVB1OUoydHpLdG52ckc4VWhwNlFPZHFTNDlMZTYwREtD?=
 =?utf-8?B?V0s5dGVvZlZzZFJJSXY2Y2tvaUtSRVRuRnRHY3lNdjFTS0lGbnd3SENmWXEy?=
 =?utf-8?B?S0ZoNFhZZjE2ZmVqZE93anZ1VHdnejZ5YUR5eVFLakxVMjk0clE3ZDlKMTAw?=
 =?utf-8?B?MVlNVUI4Z0YrMDZnRHdFRFFmVVlEaXY5YXQ2c2puMlJSUWJLNlRvVEVueDlw?=
 =?utf-8?B?UUE5S0xvWEtraVpScFAybmt5VGxpekp0V3NVY3VBK2ZNWXlLaE4wVzhMemtF?=
 =?utf-8?B?Ym5QUnRhbnE1eHhXZlN5V1RTWUZzQWwwekVwU3ZBdTdEYkRVb1ZXQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oRRaga0vwmNjd4BsWrpogfGWxkverN8w9WD8joG/A+FVifD1B3T9kP6PJcfdSTMEIEtQw1v9aNAQ8zlYQvCz/EixTate66ufkw3vU4RUIiZvHswUYbUAf4Vp1pCx0t74/roRt4s+wei/QqDRJTeOGLe1Zdtwbsf0fkE/Qq+UfhS/6FY9xKhJCA7Sma5zA5bWdJVHMPd6w3klJgr4Gj0MbGgmitR0ApeZiRIzQmcis9O9TFiUcum9F8qqW3SErMT42D2fGHXgosYcOR8/A+XzCHPqNyJ+yzHSyDXL+x0E8jxaALXjkwmTc/WcLc/2m1N7XLXbVFC8Pht5zJ8/Xc6q9A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc477df-44d4-437b-3fc5-08dec0800ba2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 08:22:11.6687 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BiFgzQ7MKXLTo8X0mR8/fZ7wJLACeRdezyeHEZFhd14IJ5DFi14Yflkg9ruuEWddJTA7AOoTs9HcflywP2+WnTxsQ773jkxHzUOktu8tlXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPFA7A817EB8
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDIvMTBdIGh3L2kyYy9hc3Bl
ZWRfaTJjOiBJbmNyZWFzZSBBU1QyNzAwIGJ1ZmZlcg0KPiBtb2RlIHNpemUgYW5kIGFkanVzdCBv
ZmZzZXQNCj4gDQo+IE9uIDYvMi8yNiAwNzoyOCwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IFVwZGF0
ZSB0aGUgQVNUMjcwMCBJMkMgYnVmZmVyIG1vZGUgY29uZmlndXJhdGlvbiB0byBtYXRjaCB0aGUg
bGF0ZXN0DQo+ID4gZmlybXdhcmUgZGVmaW5pdGlvbjoNCj4gPiAtIEluY3JlYXNlIGJ1ZmZlciBt
b2RlIHBvb2wgc2l6ZSBmcm9tIDB4MjAgdG8gMHg0MA0KPiA+IC0gQWRqdXN0IGJ1ZmZlciBtb2Rl
IGJhc2Ugb2Zmc2V0IHRvIDB4MWMwDQo+ID4NCj4gPiBTaW5jZSB0aGUgYnVmZmVyIG1vZGUgcmVn
aW9uIHNpemUgY2hhbmdlcywgdGhlIG1pZ3JhdGlvbiBzdGF0ZSBsYXlvdXQNCj4gPiBpcyBhbHNv
IG1vZGlmaWVkLiBCdW1wIHRoZSBWTVN0YXRlIHZlcnNpb24gbnVtYmVycyB0byBwcmV2ZW50DQo+
ID4gaW5jb21wYXRpYmxlIG1pZ3JhdGlvbiBiZXR3ZWVuIG9sZCBhbmQgbmV3IG1hY2hpbmUgc3Rh
dGVzLg0KPiA+DQo+ID4gRml4ZXM6IDE4MDlhYjZhNjczNTllMDg3Njk4MWNkMDVkMmE1MGIyODQz
ZWFiYWQgKCJody9pMmMvYXNwZWVkOg0KPiBBZGQNCj4gPiBBU1QyNzAwIHN1cHBvcnQiKQ0KPiA+
IFNpZ25lZC1vZmYtYnk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+
IC0tLQ0KPiA+ICAgaW5jbHVkZS9ody9pMmMvYXNwZWVkX2kyYy5oIHwgIDIgKy0NCj4gPiAgIGh3
L2kyYy9hc3BlZWRfaTJjLmMgICAgICAgICB8IDQ2ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tLS0tLS0NCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgMjQg
ZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9pMmMvYXNwZWVk
X2kyYy5oIGIvaW5jbHVkZS9ody9pMmMvYXNwZWVkX2kyYy5oDQo+ID4gaW5kZXggMWZjMjI5ZjY5
OS4uYjJlNGQyZmI5ZCAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2h3L2kyYy9hc3BlZWRfaTJj
LmgNCj4gPiArKysgYi9pbmNsdWRlL2h3L2kyYy9hc3BlZWRfaTJjLmgNCj4gPiBAQCAtMzUsNyAr
MzUsNyBAQCBPQkpFQ1RfREVDTEFSRV9UWVBFKEFzcGVlZEkyQ1N0YXRlLA0KPiBBc3BlZWRJMkND
bGFzcywNCj4gPiBBU1BFRURfSTJDKQ0KPiA+DQo+ID4gICAjZGVmaW5lIEFTUEVFRF9JMkNfTlJf
QlVTU0VTIDE2DQo+ID4gICAjZGVmaW5lIEFTUEVFRF9JMkNfU0hBUkVfUE9PTF9TSVpFIDB4ODAw
IC0jZGVmaW5lDQo+ID4gQVNQRUVEX0kyQ19CVVNfUE9PTF9TSVpFIDB4MjANCj4gPiArI2RlZmlu
ZSBBU1BFRURfSTJDX0JVU19QT09MX1NJWkUgMHg0MA0KPiA+ICAgI2RlZmluZSBBU1BFRURfSTJD
X05FV19OVU1fUkVHICgweGEwID4+IDIpDQo+ID4NCj4gPiAgICNkZWZpbmUgQV9JMkNEX01fU1RP
UF9DTUQgICAgICAgQklUKDUpDQo+ID4gZGlmZiAtLWdpdCBhL2h3L2kyYy9hc3BlZWRfaTJjLmMg
Yi9ody9pMmMvYXNwZWVkX2kyYy5jIGluZGV4DQo+ID4gYTZiNDQxNzRmNS4uNTk1YjVmY2Y1YyAx
MDA2NDQNCj4gPiAtLS0gYS9ody9pMmMvYXNwZWVkX2kyYy5jDQo+ID4gKysrIGIvaHcvaTJjL2Fz
cGVlZF9pMmMuYw0KPiA+IEBAIC0xMTMyLDggKzExMzIsOCBAQCBzdGF0aWMgY29uc3QgTWVtb3J5
UmVnaW9uT3BzDQo+ID4gYXNwZWVkX2kyY19idXNfcG9vbF9vcHMgPSB7DQo+ID4NCj4gPiAgIHN0
YXRpYyBjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gYXNwZWVkX2kyY19idXNfdm1zdGF0ZSA9IHsN
Cj4gPiAgICAgICAubmFtZSA9IFRZUEVfQVNQRUVEX0kyQywNCj4gPiAtICAgIC52ZXJzaW9uX2lk
ID0gNywNCj4gPiAtICAgIC5taW5pbXVtX3ZlcnNpb25faWQgPSA2LA0KPiA+ICsgICAgLnZlcnNp
b25faWQgPSA4LA0KPiA+ICsgICAgLm1pbmltdW1fdmVyc2lvbl9pZCA9IDcsDQo+IA0KPiANCj4g
SSB0aGluayBtaW4gc2hvdWxkIGJlICc4Jy4gUUVNVSBjYW4gbm90IGRlc2VyaWFsaXNlIGEgdjcg
Zm9ybWF0IG9mIHRoZSBwb29sDQo+IGFycmF5LiBJdCByZWFkcyBleGFjdGx5IEFTUEVFRF9JMkNf
QlVTX1BPT0xfU0laRSBieXRlcyBmcm9tIHRoZSBtaWdyYXRpb24NCj4gc3RyZWFtLiBCdXQgdGhl
IHNpemUgaGFzIGNoYW5nZWQuDQo+IA0KVGhhbmtzIGZvciB0aGUgcmV2aWV3IGFuZCBzdWdnZXN0
aW9uLg0KV2lsbCBkby4NCkphbWluDQo+IA0KPiA+ICAgICAgIC5maWVsZHMgPSAoY29uc3QgVk1T
dGF0ZUZpZWxkW10pIHsNCj4gPiAgICAgICAgICAgVk1TVEFURV9VSU5UMzJfQVJSQVkocmVncywg
QXNwZWVkSTJDQnVzLA0KPiBBU1BFRURfSTJDX05FV19OVU1fUkVHKSwNCj4gPiAgICAgICAgICAg
Vk1TVEFURV9VSU5UMzJfVihwZW5kaW5nX2ludHJfc3RzLCBBc3BlZWRJMkNCdXMsIDcpLCBAQA0K
PiA+IC0xMTQ1LDggKzExNDUsOCBAQCBzdGF0aWMgY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uDQo+
ID4gYXNwZWVkX2kyY19idXNfdm1zdGF0ZSA9IHsNCj4gPg0KPiA+ICAgc3RhdGljIGNvbnN0IFZN
U3RhdGVEZXNjcmlwdGlvbiBhc3BlZWRfaTJjX3Ztc3RhdGUgPSB7DQo+ID4gICAgICAgLm5hbWUg
PSBUWVBFX0FTUEVFRF9JMkMsDQo+ID4gLSAgICAudmVyc2lvbl9pZCA9IDMsDQo+ID4gLSAgICAu
bWluaW11bV92ZXJzaW9uX2lkID0gMywNCj4gPiArICAgIC52ZXJzaW9uX2lkID0gNCwNCj4gPiAr
ICAgIC5taW5pbXVtX3ZlcnNpb25faWQgPSA0LA0KPiA+ICAgICAgIC5maWVsZHMgPSAoY29uc3Qg
Vk1TdGF0ZUZpZWxkW10pIHsNCj4gPiAgICAgICAgICAgVk1TVEFURV9VSU5UMzIoaW50cl9zdGF0
dXMsIEFzcGVlZEkyQ1N0YXRlKSwNCj4gPiAgICAgICAgICAgVk1TVEFURV9TVFJVQ1RfQVJSQVko
YnVzc2VzLCBBc3BlZWRJMkNTdGF0ZSwgQEANCj4gLTEyNTAsMzcNCj4gPiArMTI1MCwzNyBAQCBz
dGF0aWMgdm9pZCBhc3BlZWRfaTJjX2luc3RhbmNlX2luaXQoT2JqZWN0ICpvYmopDQo+ID4gICAg
KiBBZGRyZXNzIERlZmluaXRpb25zIChBU1QyNzAwKQ0KPiA+ICAgICogICAweDAwMCAuLi4gMHgw
RkY6IEdsb2JhbCBSZWdpc3Rlcg0KPiA+ICAgICogICAweDEwMCAuLi4gMHgxOUY6IERldmljZSAw
DQo+ID4gLSAqICAgMHgxQTAgLi4uIDB4MUJGOiBEZXZpY2UgMCBidWZmZXINCj4gPiArICogICAw
eDFDMCAuLi4gMHgxRkY6IERldmljZSAwIGJ1ZmZlcg0KPiA+ICAgICogICAweDIwMCAuLi4gMHgy
OUY6IERldmljZSAxDQo+ID4gLSAqICAgMHgyQTAgLi4uIDB4MkJGOiBEZXZpY2UgMSBidWZmZXIN
Cj4gPiArICogICAweDJDMCAuLi4gMHgyRkY6IERldmljZSAxIGJ1ZmZlcg0KPiA+ICAgICogICAw
eDMwMCAuLi4gMHgzOUY6IERldmljZSAyDQo+ID4gLSAqICAgMHgzQTAgLi4uIDB4M0JGOiBEZXZp
Y2UgMiBidWZmZXINCj4gPiArICogICAweDNDMCAuLi4gMHgzRkY6IERldmljZSAyIGJ1ZmZlcg0K
PiA+ICAgICogICAweDQwMCAuLi4gMHg0OUY6IERldmljZSAzDQo+ID4gLSAqICAgMHg0QTAgLi4u
IDB4NEJGOiBEZXZpY2UgMyBidWZmZXINCj4gPiArICogICAweDRDMCAuLi4gMHg0RkY6IERldmlj
ZSAzIGJ1ZmZlcg0KPiA+ICAgICogICAweDUwMCAuLi4gMHg1OUY6IERldmljZSA0DQo+ID4gLSAq
ICAgMHg1QTAgLi4uIDB4NUJGOiBEZXZpY2UgNCBidWZmZXINCj4gPiArICogICAweDVDMCAuLi4g
MHg1RkY6IERldmljZSA0IGJ1ZmZlcg0KPiA+ICAgICogICAweDYwMCAuLi4gMHg2OUY6IERldmlj
ZSA1DQo+ID4gLSAqICAgMHg2QTAgLi4uIDB4NkJGOiBEZXZpY2UgNSBidWZmZXINCj4gPiArICog
ICAweDZDMCAuLi4gMHg2RkY6IERldmljZSA1IGJ1ZmZlcg0KPiA+ICAgICogICAweDcwMCAuLi4g
MHg3OUY6IERldmljZSA2DQo+ID4gLSAqICAgMHg3QTAgLi4uIDB4N0JGOiBEZXZpY2UgNiBidWZm
ZXINCj4gPiArICogICAweDdDMCAuLi4gMHg3RkY6IERldmljZSA2IGJ1ZmZlcg0KPiA+ICAgICog
ICAweDgwMCAuLi4gMHg4OUY6IERldmljZSA3DQo+ID4gLSAqICAgMHg4QTAgLi4uIDB4OEJGOiBE
ZXZpY2UgNyBidWZmZXINCj4gPiArICogICAweDhDMCAuLi4gMHg4RkY6IERldmljZSA3IGJ1ZmZl
cg0KPiA+ICAgICogICAweDkwMCAuLi4gMHg5OUY6IERldmljZSA4DQo+ID4gLSAqICAgMHg5QTAg
Li4uIDB4OUJGOiBEZXZpY2UgOCBidWZmZXINCj4gPiArICogICAweDlDMCAuLi4gMHg5RkY6IERl
dmljZSA4IGJ1ZmZlcg0KPiA+ICAgICogICAweEEwMCAuLi4gMHhBOUY6IERldmljZSA5DQo+ID4g
LSAqICAgMHhBQTAgLi4uIDB4QUJGOiBEZXZpY2UgOSBidWZmZXINCj4gPiArICogICAweEFDMCAu
Li4gMHhBRkY6IERldmljZSA5IGJ1ZmZlcg0KPiA+ICAgICogICAweEIwMCAuLi4gMHhCOUY6IERl
dmljZSAxMA0KPiA+IC0gKiAgIDB4QkEwIC4uLiAweEJCRjogRGV2aWNlIDEwIGJ1ZmZlcg0KPiA+
ICsgKiAgIDB4QkMwIC4uLiAweEJGRjogRGV2aWNlIDEwIGJ1ZmZlcg0KPiA+ICAgICogICAweEMw
MCAuLi4gMHhDOUY6IERldmljZSAxMQ0KPiA+IC0gKiAgIDB4Q0EwIC4uLiAweENCRjogRGV2aWNl
IDExIGJ1ZmZlcg0KPiA+ICsgKiAgIDB4Q0MwIC4uLiAweENGRjogRGV2aWNlIDExIGJ1ZmZlcg0K
PiA+ICAgICogICAweEQwMCAuLi4gMHhEOUY6IERldmljZSAxMg0KPiA+IC0gKiAgIDB4REEwIC4u
LiAweERCRjogRGV2aWNlIDEyIGJ1ZmZlcg0KPiA+ICsgKiAgIDB4REMwIC4uLiAweERGRjogRGV2
aWNlIDEyIGJ1ZmZlcg0KPiA+ICAgICogICAweEUwMCAuLi4gMHhFOUY6IERldmljZSAxMw0KPiA+
IC0gKiAgIDB4RUEwIC4uLiAweEVCRjogRGV2aWNlIDEzIGJ1ZmZlcg0KPiA+ICsgKiAgIDB4RUMw
IC4uLiAweEVGRjogRGV2aWNlIDEzIGJ1ZmZlcg0KPiA+ICAgICogICAweEYwMCAuLi4gMHhGOUY6
IERldmljZSAxNA0KPiA+IC0gKiAgIDB4RkEwIC4uLiAweEZCRjogRGV2aWNlIDE0IGJ1ZmZlcg0K
PiA+ICsgKiAgIDB4RkMwIC4uLiAweEZGRjogRGV2aWNlIDE0IGJ1ZmZlcg0KPiA+ICAgICogICAw
eDEwMDAgLi4uIDB4MTA5RjogRGV2aWNlIDE1DQo+ID4gLSAqICAgMHgxMEEwIC4uLiAweDEwQkY6
IERldmljZSAxNSBidWZmZXINCj4gPiArICogICAweDEwQzAgLi4uIDB4MTBCRjogRGV2aWNlIDE1
IGJ1ZmZlcg0KPiA+ICAgICovDQo+ID4gICBzdGF0aWMgdm9pZCBhc3BlZWRfaTJjX3JlYWxpemUo
RGV2aWNlU3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKQ0KPiA+ICAgew0KPiA+IEBAIC0xNjY2LDkg
KzE2NjYsOSBAQCBzdGF0aWMgdm9pZA0KPiBhc3BlZWRfMjcwMF9pMmNfY2xhc3NfaW5pdChPYmpl
Y3RDbGFzcyAqa2xhc3MsIGNvbnN0IHZvaWQgKmRhdGEpDQo+ID4gICAgICAgYWljLT5yZWdfZ2Fw
X3NpemUgPSAweDYwOw0KPiA+ICAgICAgIGFpYy0+Z2FwID0gLTE7IC8qIG5vIGdhcCAqLw0KPiA+
ICAgICAgIGFpYy0+YnVzX2dldF9pcnEgPSBhc3BlZWRfMjYwMF9pMmNfYnVzX2dldF9pcnE7DQo+
ID4gLSAgICBhaWMtPnBvb2xfc2l6ZSA9IDB4MjA7DQo+ID4gLSAgICBhaWMtPnBvb2xfZ2FwX3Np
emUgPSAweGUwOw0KPiA+IC0gICAgYWljLT5wb29sX2Jhc2UgPSAweDFhMDsNCj4gPiArICAgIGFp
Yy0+cG9vbF9zaXplID0gMHg0MDsNCj4gPiArICAgIGFpYy0+cG9vbF9nYXBfc2l6ZSA9IDB4YzA7
DQo+ID4gKyAgICBhaWMtPnBvb2xfYmFzZSA9IDB4MWMwOw0KPiA+ICAgICAgIGFpYy0+YnVzX3Bv
b2xfYmFzZSA9IGFzcGVlZF8yNTAwX2kyY19idXNfcG9vbF9iYXNlOw0KPiA+ICAgICAgIGFpYy0+
aGFzX2RtYSA9IHRydWU7DQo+ID4gICAgICAgYWljLT5tZW1fc2l6ZSA9IDB4MjAwMDsNCg0K

