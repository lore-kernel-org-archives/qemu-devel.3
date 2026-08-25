Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B5EC5DF9C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 02:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wygd6-0004WK-Bn; Mon, 24 Aug 2026 22:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wygd3-0004VX-5B; Mon, 24 Aug 2026 22:11:09 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wygd0-0005dJ-BS; Mon, 24 Aug 2026 22:11:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqgXEHJGuqFurnoM8CVyb5BP/Zfq94UqtDhhet35QTl+/tHWFVoUTbdZuvT9FNI5UQBqomYJPbmnGcTknHJ86rk2OuucFn6I80J3HWrZvPo2gBVc8eeUmTNesS4rieI0Wopx8OcZh2PX1Co8hWCkP/HakbL5KLdeH1+TbR0X9laOfFebxeUQcrvJ3uovnYmT7Yy6M1V7upLangozga6Bm18hljibLzG2Nl041xq1sek38mFHqzo3d7/UZPznIxLorKeti4Pop5Ru1GMKnTmHgSeU4AgezyC9KOrXNIlbS3jFHSPFr6gZDLBL2Fr9jqLw1gVnMdIpYtK6SpMA1huSTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzAGeod2JLM3FErelbUuQfTl9RQPzHCNIMbnIGvN3XQ=;
 b=WSysvPn3VNy9HgOhP+hpsrQeUYiPIWBXeCbK6bt1Y2hrRNN1Zt1ebW2f7/Hjx6MTY7AGgHakxP5PSEUpOoL79XbHSplewBizqIevtw2JD29Gg4kq7ycmXaMMtnOpBaZ2chT5oelf1Iy+X7f2wsSotuPjb8iaOZeJbPyCTtk0NdYm69zsT/EZlPPG4rceH9vAPtS9HX5y5MieYcZatURVgU8rXM0uZQ881lKUVWSlntC+3aLCMZItG0/wmFaTf0yCFF30wWKBEDlXyV4nwVQJF5fSvR3OCwXheabBbPyL6vGeWuBT6aSlb4wxG3k9aC/jvbsrunGt+6NmI6U0pAYk0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzAGeod2JLM3FErelbUuQfTl9RQPzHCNIMbnIGvN3XQ=;
 b=ULKz6b/ZAb80aU6PRZ9L7CFMLF1pu7HBLARJaXGNqjHk4cBsHd6TFUPquTXK5xXMqf9nli7DNZjnrdux+b1WvXGmwF4fb6BhvquxnMBdv5NLX3JbYdXJPLI0/1dIkxmKNJHowBIpgLuIoJgn9m0z1xgVDIODBNuzLvI68J1MOnaiEOesh7yOwHXUw44OftKh7zRj0MIT9MnvDoMbyGcWTJspPi7Hb7BezGPeIx+J+EPWS1bNET3RQZdyV139DCd5Zb4U1DZUbg6/tn+Y2d9gfOoclzxQ2aXAXSnUW0VlqDQhw83fqJI/1n1ZkNuMPVs1PYkFGzI8jnV9E+btLdYOeA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SE3PR06MB8096.apcprd06.prod.outlook.com (2603:1096:101:2e3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 02:10:57 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 02:10:57 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane
 Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open list:ARM
 TCG CPUs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 1/3] hw/usb/aspeed-udc: Add ASPEED UDC device controller
Thread-Topic: [PATCH v1 1/3] hw/usb/aspeed-udc: Add ASPEED UDC device
 controller
Thread-Index: AQHdCr+nGAvHtrLIiEy1KPuFrHkplbZlt2cAgEEVDoCAB4u/IA==
Date: Tue, 25 Aug 2026 02:10:57 +0000
Message-ID: <TYZPR06MB49801E7F05807552DEFE3838FCAF2@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260703074332.1049473-1-jamin_lin@aspeedtech.com>
 <20260703074332.1049473-2-jamin_lin@aspeedtech.com>
 <6537f5d6-4e21-4e55-8a21-2818a7d7fa28@oss.qualcomm.com>
 <7ec3eecd-9d78-4f1d-a020-9c0960e923ae@kaod.org>
In-Reply-To: <7ec3eecd-9d78-4f1d-a020-9c0960e923ae@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SE3PR06MB8096:EE_
x-ms-office365-filtering-correlation-id: b44035cf-5569-4f6d-3e3c-08df024e19ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|38070700021|921020|6133799003|56012099006|10067099003|4143699003|3023799007|18002099003|22082099003;
x-microsoft-antispam-message-info: Pt4enG0mvwLpSxTtSrUL8LeXVzL8ziONoUyIrh4Erju5MIDg4fcdo413ljtP+eD8Zsm3ZAfN+SWiY8wQNInI9ZU+7YnlQMIf3yKNvTuffKPZI1D+ZHE4ry9b/szBDnDe4EJ/b8GRsW0zjUxKn7CCv29+fOWg+2Z7lOa1nVfxhBYcdlNQIbvGFhD5IibIm6ZtBvRoXAK4jRu53WZ+Gcl4v0HdFy7Jv7THrJFbee97arKQI+0IPTqkrmqAl/wN0uEdP9PehtBNO/MEcE2UTscmMGGrgoVR0Uym4WBQjEYk6Wx/5uAgKl8pKDynnAR0paOIueP7+LCSly7SkCHf+BU1mcmGnuEYb6inSBZCef4I0CMKCMSrsQmGkTmypxSB8xI1J0f/KhXgC04piBGLsjdVzf2PbzFIJ8ENXKcVOafFbTgaHQeZyu8IZhQCKSpKpIjkhxgxjpDZ+5gXeCGSLcBgY3ZJg+e1RuAle2+E+r4vs9kjJVKu9bDl2A2RCpYSSOpMQtyPPkTD1ZfsLHZ4uPYqWjHpLIR9W6EIRKDsStZgu3s7T1ENpSYEK4IAbL58GZ3fyJ7z5LOHZRPZZoj9TslxiDps1C9pjHNIema7yiFCX9piMrTYWUOtT4BujChuHwxFHaaDh1NyiBFr+MmcszsWWpYLyfx997SeEGcMgAeeIW67ryHznEfqe7CRaHdk1rbytraptqyu4rjxso4wbaNZcmXaDMGg0LqEq7uh5fYpyeqRqNocbmf2ta8Ycz9GDpMM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(921020)(6133799003)(56012099006)(10067099003)(4143699003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0Rpd1hCMVd4ZkVBeHg2TTZObXdnUmxjZnMyYnFaWFZFT1FRU1ZkT0JselNu?=
 =?utf-8?B?R2krMWJuTm04dHVXQ2VGUXM2clBqV3FwM2JYaUp6aG9yb1JuOTRRMy90ZmhG?=
 =?utf-8?B?RFhBYStxQXZRRWRIVzRBVlJINVBHNm9MdkNLdHFTbFplQmxQWlBlUzgxQUI0?=
 =?utf-8?B?NTNjWDNDTXpoQk5zQ2lEWE9BcjRobTFJMVBpb3FmNXVsY0xna1ZMcDdvbEZm?=
 =?utf-8?B?YW91bXlrcUNCeHVRN3JWVk1UUUxoOU94aldVYUZoWjkwTk1UWkFVVzl4d2lQ?=
 =?utf-8?B?bFF6U3FNZUc1aENiVEJyckxDckxETVgxc0xibGQ3dzgwWUZ3MUtZTnBpaHQr?=
 =?utf-8?B?cnFYWU1EL003YnZUN014Qjh2N2tUSnRKZ25pVm5ZUXE2SmJIdFVkQnNDME1S?=
 =?utf-8?B?MmEwdURwUUVXK2Vod1dHeUVpVzcvL0pReHlMeko4SWFONUFGYzNyOVZDYk9v?=
 =?utf-8?B?Ync3UE03RGNxaDhvWi8ySkhWdlQyeGlIWmlOSjJ4Y0c5bTFYdlpNUFE3ZkQ1?=
 =?utf-8?B?WVNhUWNIV0cxY2I0U2w5UFZaY2tYNXEzZlpwZzhTUktTeTMxRzE1UDZyV05u?=
 =?utf-8?B?Mlh5RENOaGgySWY1bUNDc2lGaFdCelFtZnFsSys3ZU4raEJ4aVQ1S29NWEE3?=
 =?utf-8?B?dXM4MHNwcUkrSFhJNEs0azIrTml0ZnJQbjJQbEpISU5DRDFaMUNSdTNZSDV3?=
 =?utf-8?B?ZE1pN0tuQnl2ek5oOEIzS1RHQndGZHltY0RQMHg2VXpvTmd0Y3RsT003WjVq?=
 =?utf-8?B?Ylp1aHR6K3RxSWhVb2RIVVFCUTQ4RnhUKzU3bXVGZjd3M2ZwcHRmZDVEalJU?=
 =?utf-8?B?YUdPRXRTWVphbEZHYmZIcjFJZWlJa3V2bmlqTDNJbHoydDYxTnRncTN1ZWJl?=
 =?utf-8?B?Qm1iUUU1VnFJS3c4eHlOVmg3aTZWSHlNMnFqZExYTEdkMjJYMjJPc1FvZXMr?=
 =?utf-8?B?Y0txaFBsR3NkNDFPaEhxelFoSXE3TkJXRGFKbmJXTlRkNEdQUG5ZdXRUbGt3?=
 =?utf-8?B?Sm1kRmx0VS9pbnNwZXdOZ0FCdkJtL2J4akpNWDQzaGV6MDRDenJFaUkzZnBv?=
 =?utf-8?B?K2M5M1A0MGIxZjZncDQ4SlNqdHFHaFFLK3phMHRiVndPc0pSekpGc0RyY0dO?=
 =?utf-8?B?dWU3S0ZRdXJFMXhZYVBGYTVpQU0rMHVLV29NVU0wRmNSUzk3T1RTYThFYUx6?=
 =?utf-8?B?ei9pNjJPc2IrMkVlSEROVXZBVU42QzdzaW5wS00vRnR2dUZCMDNJZGk5em9r?=
 =?utf-8?B?R0JKUWdTbXBpeHpLY3U5Z2diWFVSQ0tKR3ZoNVEvSThEN1RhdTJueHY5VGIr?=
 =?utf-8?B?a1RQTGVTQzZvZWZzTmNLdjhCdWppbHh5NmFtQmNZNk4zcnhjVW9DLy9TNzht?=
 =?utf-8?B?d3pUZndLbVB0WnhqYXg4eGwxQ1JOT1ptanVPeFBObEVwTVpNaWdKVWNQeGZJ?=
 =?utf-8?B?V2ovN1VtMHpnbENJVU8yQ2QvNXhjZ1MvaTZwK2E5UXpuNVVod0M3dC9mMHpN?=
 =?utf-8?B?OC9paFhmSHl5QmxZdGltTzlPRUNFZEJnak5jRGpEMHpEejVtdU5yRzJOR3pa?=
 =?utf-8?B?UlBFR09YZ0hRT1ovemh1SW1YV2w0MUF0Mjc4cVkzbHlnNUVQdVRZb0tQbW9J?=
 =?utf-8?B?WHhFY1VSbDMxVEhoWmRwc1lIQ1dueUhaekRPYUV2ZWJmK0NVdlF6OU1XdktW?=
 =?utf-8?B?NFZPdTFNVThxOWNOUnJ6YVI3YTdYMi9IMCtxVHl5R0tBL1VZYWI0MFRNbWlp?=
 =?utf-8?B?clFNZTBSUmdjaXRQcEFEZE4zeDVYeGIrN29oWHJLN1E4TE1UdUhkMGVZSEZL?=
 =?utf-8?B?aCt1M2NLUGZGZ0pFUC9ncERyc0I5WFg5cGI2bmdMOFd5QmYvM3F1amhUZzAx?=
 =?utf-8?B?bHdWVlJsUUgzZk53cjh3SFVGam9ibUR1a0NieWgvaVB4b3lFbWRzUm91Zy94?=
 =?utf-8?B?c3I1Vmd2ZlFEeXNNUlJqNGs5ZCtQRitDSVV2dDg0MUtYbDZkZDhSSHFUOXFq?=
 =?utf-8?B?TUZFbm5tU3JOd09tVjJiT3Q1Z3NEOW5MUG4xaWVhL1hVZTl0UDMvNFY5MU9s?=
 =?utf-8?B?My9zQmZLcWxDdVNnNkVlZDFvOENYM2VuTFVHdk1yN2hhK3VjdU9Fd29zY09h?=
 =?utf-8?B?TkZDbzcydGlISm1paHlLS1hiSWVNYzhRek1WSnE0dDdWeCt3VWUyVGl5WjBV?=
 =?utf-8?B?aldzVUx1eXRmT2pBaFNCeWdwVmtETmhhcXcvNTdCVEhMYzAwczh1UXFnRDEx?=
 =?utf-8?B?cVZjSVkzOGpqeWs1MXoxTnQ1ZG0xK0ZMYjljaDM3clorMnZBV0FXZGEwN3Vm?=
 =?utf-8?B?Snhlc2E1L3N3Yng1MCtuc1dXb1JKbytmSkk5aTZVWXBTaVBacFNEdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vKh3L0Qi4c1cpJuohnUhSzSMfHjLOxOH92HhuZQTBrWAFNiTaH5ZyuQMB0yS/vuUTnHjhqpzx7YND4/xpTNAnKI48cFsmP4EOq3v1fV+L0ZXtTH2TpRmJV0cmuwQjJhU77vsvREItzGtBJsHXeH22Vsu5FXfQaUME/nbA7MQrrTBgmrF/Hm2StGnLyDiXwt7S3wZE3lycRa3tbDKzEbOCAq3ZVuiXD5vs94mwUN017lX7XA0z16yh/G54FI04A5BuFOzBvWdwoRmDuJRO7e/gQoQYLOQb7rf+2TNptuUXXO1n6m/s3Wb6sGIGHLgG2Ih/KJMc8wm5bsRJ16vFSCseA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b44035cf-5569-4f6d-3e3c-08df024e19ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 02:10:57.0970 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CNSjF+IN+HyPmyuhyQDrfkAq8dwWUawdT9RxVQF2FL4mNXZ45SyXhSBf2fkQDm3Q0ptxcSMbbv4UbEUyRCfIwFqDKoWTIFi0gvR1yCG3fkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB8096
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

SGkgQ8OpZHJpYywgUGhpbGlwcGUNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDEvM10gaHcv
dXNiL2FzcGVlZC11ZGM6IEFkZCBBU1BFRUQgVURDIGRldmljZQ0KPiBjb250cm9sbGVyDQo+IA0K
PiBPbiA3LzkvMjYgMjM6MDMsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiA+IEhp
IEphbWluLA0KPiA+DQo+ID4gT24gMy83LzI2IDA5OjQzLCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4+
IFRoZSBBU1QyNjAwIGhhcyBhIFVTQiAyLjAgRGV2aWNlIENvbnRyb2xsZXIgKFVEQykgYXQgMHgx
ZTZhMjAwMCB3aXRoDQo+ID4+IG9uZSBjb250cm9sIGVuZHBvaW50IGFuZCBmb3VyIHByb2dyYW1t
YWJsZSBlbmRwb2ludHMsIGRyaXZlbiBieSB0aGUNCj4gPj4gTGludXggImFzcGVlZF91ZGMiIGdh
ZGdldCBkcml2ZXIuDQo+ID4+DQo+ID4+IEFkZCB0aGUgY29udHJvbGxlciBhcyBhIHN5c2J1cyAo
c3lzdGVtKSBkZXZpY2U6IHRoZSBNTUlPIHJlZ2lzdGVyIG1hcA0KPiA+PiBkZXNjcmliZWQgd2l0
aCB0aGUgcmVnaXN0ZXJmaWVsZHMgbWFjcm9zLCB0aGUgaW50ZXJydXB0IGxpbmUgYW5kIHRoZQ0K
PiA+PiBzb2Z0IHJlc2V0LiBUaGlzIGlzIG9ubHkgdGhlIHJlZ2lzdGVyL3N5c3RlbSBzaWRlLg0K
PiA+Pg0KPiA+PiBOb3RlOiB0aGlzICJkZXZpY2UgY29udHJvbGxlciIgaXMgdGhlIHN5c3RlbS1i
dXMgZGV2aWNlIChUWVBFX0FTUEVFRF9VREMpLg0KPiA+PiBJdCBpcyBub3QgdGhlIGdhZGdldCBV
U0IgZGV2aWNlIChUWVBFX0FTUEVFRF9VRENfREVWKSB0aGF0IGEgaG9zdA0KPiA+PiBjb250cm9s
bGVyIGVudW1lcmF0ZXMsIHdoaWNoIGlzIGFkZGVkIGluIHRoZSBuZXh0IHBhdGNoLg0KPiA+Pg0K
PiA+PiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4N
Cj4gPj4gLS0tDQo+ID4+IMKgIGh3L2FybS9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfMKgwqAgMSArDQo+ID4+IMKgIGh3L3VzYi9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgwqAgNCArDQo+ID4+IMKgIGh3L3VzYi9hc3BlZWQtdWRjLmPCoMKgwqDCoMKgwqDC
oMKgIHwgMjY0DQo+ID4+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+
PiDCoCBody91c2IvbWVzb24uYnVpbGTCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArDQo+ID4+
IMKgIGh3L3VzYi90cmFjZS1ldmVudHPCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDcgKw0KPiA+PiDC
oCBpbmNsdWRlL2h3L3VzYi9hc3BlZWQtdWRjLmggfMKgIDU0ICsrKysrKysrDQo+ID4+IMKgIDYg
ZmlsZXMgY2hhbmdlZCwgMzMxIGluc2VydGlvbnMoKykNCj4gPj4gwqAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGh3L3VzYi9hc3BlZWQtdWRjLmMNCj4gPj4gwqAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1
ZGUvaHcvdXNiL2FzcGVlZC11ZGMuaA0KPiA+DQo+ID4NCj4gPj4gK3N0YXRpYyB2b2lkIGFzcGVl
ZF91ZGNfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApIHsNCj4gPj4gK8Kg
wqDCoCBBc3BlZWRVRENTdGF0ZSAqcyA9IEFTUEVFRF9VREMoZGV2KTsNCj4gPj4gK8KgwqDCoCBT
eXNCdXNEZXZpY2UgKnNiZCA9IFNZU19CVVNfREVWSUNFKGRldik7DQo+ID4+ICvCoMKgwqAgaW50
IGk7DQo+ID4+ICsNCj4gPj4gK8KgwqDCoCBzLT5yZWdzID0gZ19uZXcwKHVpbnQzMl90LCBBU1BF
RURfVURDX05SX1JFR1MpOw0KPiA+PiArDQo+ID4+ICvCoMKgwqAgbWVtb3J5X3JlZ2lvbl9pbml0
KCZzLT5pb21lbSwgT0JKRUNUKHMpLCBUWVBFX0FTUEVFRF9VREMsDQo+ID4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBBU1BFRURfVURDX1JFR19TSVpFKTsN
Cj4gPj4gKw0KPiA+PiArwqDCoMKgIC8qIFJvb3QvZ2xvYmFsIHJlZ2lzdGVycyBvY2N1cHkgdGhl
IGxvdyBwYXJ0IG9mIHRoZSB3aW5kb3cgKi8NCj4gPj4gK8KgwqDCoCBtZW1vcnlfcmVnaW9uX2lu
aXRfaW8oJnMtPnJlZ19tciwgT0JKRUNUKHMpLCAmYXNwZWVkX3VkY19vcHMsDQo+IHMsDQo+ID4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBUWVBF
X0FTUEVFRF9VREMgIi5yZWdzIiwNCj4gPj4gK0FTUEVFRF9VRENfTlJfUkVHUyA8PCAyKTsNCj4g
Pj4gK8KgwqDCoCBtZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdpb24oJnMtPmlvbWVtLCAwLCAmcy0+
cmVnX21yKTsNCj4gPj4gKw0KPiA+PiArwqDCoMKgIC8qIEVhY2ggcHJvZ3JhbW1hYmxlIGVuZHBv
aW50IGhhcyBpdHMgb3duIHJlZ2lzdGVyIGJhbmsgKi8NCj4gPj4gK8KgwqDCoCBmb3IgKGkgPSAw
OyBpIDwgQVNQRUVEX1VEQ19OVU1fRVA7IGkrKykgew0KPiA+PiArwqDCoMKgwqDCoMKgwqAgZ19h
dXRvZnJlZSBjaGFyICpuYW1lID0gZ19zdHJkdXBfcHJpbnRmKFRZUEVfQVNQRUVEX1VEQw0KPiA+
PiArIi5lcCVkIiwgaSk7DQo+ID4+ICsNCj4gPj4gK8KgwqDCoMKgwqDCoMKgIHMtPmVwW2ldLmlu
ZGV4ID0gaTsNCj4gPj4gK8KgwqDCoMKgwqDCoMKgIHMtPmVwW2ldLnJlZ3MgPSBnX25ldzAodWlu
dDMyX3QsIEFTUEVFRF9VRENfRVBfTlJfUkVHUyk7DQo+ID4NCj4gPiBXaHkgYWxsb2NhdGUgYSBm
aXhlZCBzaXplPyBPdGhlcndpc2UgTEdUTS4NCj4gDQo+IEkgYWdyZWUuIFRoZSByZXN0IGxvb2tz
IGdvb2QuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCj4gDQoNClRoYW5rcyBmb3IgdGhl
IHJldmlldyBhbmQgc3VnZ2VzdGlvbi4NCldpbGwgZml4IGl0Lg0KDQpKYW1pbg0KDQo+ID4NCj4g
Pj4gK8KgwqDCoMKgwqDCoMKgIG1lbW9yeV9yZWdpb25faW5pdF9pbygmcy0+ZXBbaV0ubXIsIE9C
SkVDVChzKSwNCj4gPj4gKyZhc3BlZWRfdWRjX2VwX29wcywNCj4gPj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJnMtPmVwW2ldLCBu
YW1lLA0KPiBBU1BFRURfVURDX0VQX05SX1JFR1MNCj4gPj4gKzw8IDIpOw0KPiA+PiArwqDCoMKg
wqDCoMKgwqAgbWVtb3J5X3JlZ2lvbl9hZGRfc3VicmVnaW9uKCZzLT5pb21lbSwNCj4gPj4gK0FT
UEVFRF9VRENfRVBfUkVHX0JBU0UgKw0KPiA+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpICoNCj4gQVNQRUVE
X1VEQ19FUF9SRUdfU0laRSwNCj4gPj4gKyZzLT5lcFtpXS5tcik7DQo+ID4+ICvCoMKgwqAgfQ0K
PiA+PiArDQo+ID4+ICvCoMKgwqAgc3lzYnVzX2luaXRfbW1pbyhzYmQsICZzLT5pb21lbSk7DQo+
ID4+ICvCoMKgwqAgc3lzYnVzX2luaXRfaXJxKHNiZCwgJnMtPmlycSk7DQo+ID4+ICt9DQo+ID4N
Cj4gPj4gK3N0YXRpYyB2b2lkIGFzcGVlZF91ZGNfdW5yZWFsaXplKERldmljZVN0YXRlICpkZXYp
IHsNCj4gPj4gK8KgwqDCoCBBc3BlZWRVRENTdGF0ZSAqcyA9IEFTUEVFRF9VREMoZGV2KTsNCj4g
Pj4gK8KgwqDCoCBpbnQgaTsNCj4gPj4gKw0KPiA+PiArwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBB
U1BFRURfVURDX05VTV9FUDsgaSsrKSB7DQo+ID4+ICvCoMKgwqDCoMKgwqDCoCBnX2ZyZWUocy0+
ZXBbaV0ucmVncyk7DQo+ID4+ICvCoMKgwqAgfQ0KPiA+PiArwqDCoMKgIGdfZnJlZShzLT5yZWdz
KTsNCj4gPj4gK30NCj4gPg0KPiA+PiArLyoNCj4gPj4gKyAqIEVQMCAoY29udHJvbCkgaXMgc2Vy
dmVkIHRocm91Z2ggdGhlIHJvb3QgcmVnaXN0ZXJzIChVRENfRVAwXyopLA0KPiA+PiArc28gb25s
eQ0KPiA+PiArICogdGhlIDQgcHJvZ3JhbW1hYmxlIGVuZHBvaW50cyBnZXQgdGhlaXIgb3duIHJl
Z2lzdGVyIGJhbmsgLyBlcFtdIGVudHJ5Lg0KPiA+PiArICovDQo+ID4+ICsjZGVmaW5lIEFTUEVF
RF9VRENfTlVNX0VQwqDCoMKgwqDCoMKgIDQNCj4gPj4gKy8qIDMyLWJpdCByZWdpc3RlcnMgcGVy
IHByb2dyYW1tYWJsZSBlbmRwb2ludCAqLyAjZGVmaW5lDQo+ID4+ICtBU1BFRURfVURDX0VQX05S
X1JFR1PCoMKgIDQNCj4gPj4gKw0KPiA+PiArLyoNCj4gPj4gKyAqIFRoZSByb290L2dsb2JhbCBy
ZWdpc3RlciBibG9jayBzcGFucyAweDAwMC4uLjB4MDg3OiB0aGUgU0VUVVANCj4gPj4gK2RhdGEg
YnVmZmVyDQo+ID4+ICsgKiBlbmRzIGF0IDB4ODQuIFNpemUgdGhlIGJhY2tpbmcgYXJyYXkgdG8g
Y292ZXIgdGhlIHdob2xlIGJsb2NrLg0KPiA+PiArICovDQo+ID4+ICsjZGVmaW5lIEFTUEVFRF9V
RENfTlJfUkVHU8KgwqDCoMKgwqAgKDB4ODggPj4gMikNCj4gPj4gKw0KPiA+PiArLyogTU1JTyB3
aW5kb3c6IHJvb3QgcmVnaXN0ZXJzIGJlbG93IEVQX1JFR19CQVNFLCB0aGVuIHRoZSBwZXItRVAN
Cj4gPj4gK2JhbmtzICovICNkZWZpbmUgQVNQRUVEX1VEQ19SRUdfU0laRcKgwqDCoMKgIDB4MzAw
ICNkZWZpbmUNCj4gPj4gK0FTUEVFRF9VRENfRVBfUkVHX0JBU0XCoCAweDIwMCAjZGVmaW5lDQo+
IEFTUEVFRF9VRENfRVBfUkVHX1NJWkXCoCAweDEwDQo+ID4+ICsNCj4gPj4gK3R5cGVkZWYgc3Ry
dWN0IEFzcGVlZFVEQ0VQIHsNCj4gPj4gK8KgwqDCoCBNZW1vcnlSZWdpb24gbXI7DQo+ID4+ICvC
oMKgwqAgaW50IGluZGV4Ow0KPiA+PiArwqDCoMKgIHVpbnQzMl90ICpyZWdzOw0KPiA+PiArfSBB
c3BlZWRVRENFUDsNCj4gPj4gKw0KPiA+PiArc3RydWN0IEFzcGVlZFVEQ1N0YXRlIHsNCj4gPj4g
K8KgwqDCoCBTeXNCdXNEZXZpY2UgcGFyZW50X29iajsNCj4gPj4gKw0KPiA+PiArwqDCoMKgIC8q
IGNvbnRhaW5lcjogcm9vdCByZWdpc3RlcnMgKyBwZXItZW5kcG9pbnQgYmFua3MgKi8NCj4gPj4g
K8KgwqDCoCBNZW1vcnlSZWdpb24gaW9tZW07DQo+ID4+ICvCoMKgwqAgTWVtb3J5UmVnaW9uIHJl
Z19tcjsNCj4gPj4gK8KgwqDCoCBxZW11X2lycSBpcnE7DQo+ID4+ICvCoMKgwqAgdWludDMyX3Qg
KnJlZ3M7DQo+ID4+ICvCoMKgwqAgQXNwZWVkVURDRVAgZXBbQVNQRUVEX1VEQ19OVU1fRVBdOyB9
Ow0KPiA+PiArDQo+ID4+ICsjZW5kaWYgLyogSFdfVVNCX0FTUEVFRF9VRENfSCAqLw0KPiA+DQoN
Cg==

