Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CD1C5DF71
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 03:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUG4D-0007pP-5f; Mon, 01 Jun 2026 23:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUG49-0007ni-Gb; Mon, 01 Jun 2026 23:45:22 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUG47-0007dQ-27; Mon, 01 Jun 2026 23:45:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rn0OyYAZDk28bvDb/w9NBrPi1vN9i6XACfgmzR21KeiTu6oWWop5PFUoALZoLQQwc20VKdLHZjF16ZPcx0zU68i2WQJLhsWRfhWdJeA3M71LSSYRh/tMpL9VbiR6BZ6eEC4U5Fl7N9bmViU9CICJw9cQRfRjMVJcrF9zv4QRKQezyAo7Ys3adzhtDKvv+RSc+M5V0mFUMxkVzUDAnUUQblZRCrrHXIvDX7B/jiDIE/GXYlMHd3s12sWkrYGD+7EbTuy7OGuASK0bSHXyPvUp8K4GgHnZ1wCEM7Xxwws+wzOlKcnayTfSMFzjawlqqtnEOoZ7vXIhxS0iwacTt1/POQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+HCmWUQNpKvoBuTmo1cO122C1c+vZ15Vb4o6rXAd1Q=;
 b=Mn9mKyG7ymlON3G58ip7EioFBGzUJ6/+1yyRpeEQiZhMJX7mXkbNX3XDkLHElRdaEDok91gHz0mu8DaZ0EQ1H8anBzk0rWfh6Jzi8GX5uuBTD/KvBxP1/2wm4/CuOC1755ZYX022HvM6fzCHzUWD6SD/uZe673N2qGuRbMV7/AXpfv1kb8YqtNItEZn6D1bnwToLL2fxfMBWBk9bbW6FTjMOJ9/aLGOmgxgVaRlsu2SNnO/pl+7qGWrtW2RGWwv5+GqqQCvrg9ovGg12PVhOLSgavVlA14hhDE6I2ClInY17hNvT5a8a8Ejtcs6bdDVF9KhHAe5/lU8qKTMmSuYrgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+HCmWUQNpKvoBuTmo1cO122C1c+vZ15Vb4o6rXAd1Q=;
 b=q3ZpsH5AjJ9t56jk6fwtVguAiDCrXzFRjdDFWhQPRC2/SZzaQ/I/O74msm07GoSYcNXlVQwYcciv0KSf25NqAf2lTZoexbyzYhA0+0Mn1wts6dWiYBCKGxfkvjFTlvfW2zCDLKP6OWeEqSbBaf5IxiO18hYr+G3UPHBvJHcG7NutLn5vtbAj9twfHuKnh2Y//EPEsJ+hmNSkw3M5aWbQu11NHgQkN4jVyxH/FM2GzaL95AIZ3hl20eNRigM83EAyY5caleP5LwolaPW58zmQxw2bMXLRDPC+Nmma+nf2ZPGbBZl8myPbmVaJj30fdSVad1/QUGngppRpoIMEH2hCAg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by OSNPR06MB8370.apcprd06.prod.outlook.com (2603:1096:604:486::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 2 Jun 2026
 03:45:11 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%5]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 03:45:11 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 08/10] hw/arm/aspeed_ast1040: Introduce I2C support
Thread-Topic: [PATCH v1 08/10] hw/arm/aspeed_ast1040: Introduce I2C support
Thread-Index: AQHc7zZgTC3y9PuZ4Uqodo/0a1fAGbYpruwAgAD25vA=
Date: Tue, 2 Jun 2026 03:45:11 +0000
Message-ID: <TYZPR06MB498021CF2F413F8E42964ADDFC122@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260529064243.2064188-1-jamin_lin@aspeedtech.com>
 <20260529064243.2064188-9-jamin_lin@aspeedtech.com>
 <b523139d-edf0-48f4-a50e-bfcd15a23f64@kaod.org>
In-Reply-To: <b523139d-edf0-48f4-a50e-bfcd15a23f64@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|OSNPR06MB8370:EE_
x-ms-office365-filtering-correlation-id: 3f96b231-98e1-4990-094d-08dec059596e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099006|4143699003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: BuQpC3niF6WO+asulqufIA2+7FvSg+pwaz1ydqQAToox2fNk4TKhsgUVMCvyClAWdRsJus+/mhN/quQWGA9fj0aQ7RNgKCTv5zb18HrsCxidRaoFHRP18xm0uBL5ukYOgWf7Tfn8A6FtS8ik3dj9hLgtODLALaJS0OgzysRy9WWZnc+PPhkMk0Am8Uz6da3wlVKlT5oSscG3r/q7Ord+mdmfEnTvR8WKGYSxYs55rNLhaBp+7FI3f/c1Kc11eetzMwzSgsOQsL9mzBc0sUYcwTQRSjHtZmVaQnMSbbiDqZGeow3buYOIMk0iEuxJjAWG6nbJDQS/FKUti1NBcWQVOCNndEMicGneOkw1AKP1lTN34SXvOU0aPdWS1j4sWTk7xgNBHbAPkCW9yNSYvLeyExxvEggRuXaSl6cUBabaXJ+lZbQ1lb0kWm9N+c4SliyOwYRDUDU0zKdapa+0OPReB3OnMccsn1XIvO3CJTQOWOgJggp3pOioKo7Dy0mWcLmFMHl/mM2WD2SCPApsPkhaC1gICueasSaW+PdwLulTMKr+4hCXJgjNB3sag7f141IjOobqWevQiR+IQiSHtcntO7GWpGMHUar6gyfbyrAx/DN9noCX73SdqgYgBJTxvF8/pd17DqYSpYKnYmCmR94tiexJlEd9lc0WV8bqmXGIjMxo0+5vAxy/TE/fnEohJUIEanKUAW5+jef6osIebjNccgzPhtFg+NJ6qLaIqwUVDo/QzJzFj/29FL6e7SXlzma5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(4143699003)(38070700021)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3hNcHBTM1lSWHlKWmRBbWNCM0k3MHNhdkNvS2N5aTUyNlg1U24yUWlteDJy?=
 =?utf-8?B?eCtRQW9ndnNmblhJdm82S2FVRDFGcmF2Y0YvTk9HcnkxQ3BUaFpabmJ5NXZC?=
 =?utf-8?B?QSsxdDVVbFowUVlzVzd6OGpHYmNHRmZDdG5zVUJ1UERXZE9jNGRGMlZnVjh3?=
 =?utf-8?B?Zk95VzZxZjRxNCsxRUNrN1ptcjNRNlpuVlRZdEs5eUhnb2ZRZXl3dkRab3lM?=
 =?utf-8?B?SkZxZ01FM0p2QnNQZlk2TnJvTC9CU3VDdHllKzdqRUNKdzZjK0ozS1djZDd1?=
 =?utf-8?B?UlZGSUVHRndpVTE4cEkvNFdUeTJMdDlhT2ZBa3lmazlIRE9UdFp0b1BoakxJ?=
 =?utf-8?B?Y3ZkbGc3MElaL1dyOUZvMi93bVpXc0xtZzUzWEdNQmcvLy9oazdUMHFMSGo5?=
 =?utf-8?B?dDBTY3hOOWdxcUJtTmc5d2lWVW1rQUllWjA2VHU2RUJidFh4M1VLUVpYbkdH?=
 =?utf-8?B?YStzNkN6VDkyekRpYzIvTEZiVG1QalNzRDI4Q2d2M2ZPZFUyY01NazJNRnhP?=
 =?utf-8?B?b1ZQL05mamljMTEyRG9aNk9kU3lLK0QxRlFZd1BMcldRcWQxWVFrQ1U2eURs?=
 =?utf-8?B?RnNQZ3pNSUg1aXpuWGlRTktYRC9lV2N4czFuWDN5RHhoYVJUZklkbk1ockxt?=
 =?utf-8?B?NDluYU1GM0RQVVhQYlNRalZlYzJINUdnTmsxZXQ5ZloweWE1NEY1czJubmRp?=
 =?utf-8?B?bXhCUUZ3d2lERnNDMjdZbTVjS1B3eXo5d3BQNHhxT0FrVEhhTDZHdFM5eUd5?=
 =?utf-8?B?RFFLUjN6NnpvQzdaWHk3R3IrRjJ0SXBSNzBhU0RVQndDNzd4SE1XcjVGRGZi?=
 =?utf-8?B?VGVzNXB6ejJIMCtSajVvcmxqYWNncEhQMUJ2MHFqTHlxYW5hSVBKT2pxclpO?=
 =?utf-8?B?N2d5TFlmVXc0NlNHRnczMTZCU2pwbTgyQWlIYWhuYVZIRXRJUGl0SXJ1OSs4?=
 =?utf-8?B?dmtudUZrb0w5MUFnZWFhQW52bGdOWlIvcjJFK3NWNzNxM0EwWVZ0cGtHdFRR?=
 =?utf-8?B?OFU0Z2svZFVIT1lXakxjSnRNRldGSGRYbnFqRkJ6WndLSk13ZkFteTVSV01k?=
 =?utf-8?B?N3lvMjFLaUtvS08weU1YcXpZTUJIMkkzQ3IyRWNjMWg4amJaRTJ4TlNiM2hJ?=
 =?utf-8?B?bWFQQ1VvYXNkSURObGowOWZUcXRBU2YrZXVjZW1sa0I5dVB4b1RUWitOM3lV?=
 =?utf-8?B?R1pydWxTcFN0QlFlbXorSXJMUThIZmdLKzB6Mmg4dm9GSWI3S1FpeHlpU2Fn?=
 =?utf-8?B?blI4clhQZ05BNDYyZE5Ea0hWYVhERC8yYVZUYmJ1MkN5UTFzaG95T0dVcXJX?=
 =?utf-8?B?V1hDZFlYell5VGVTYXJTVm9weUhxaTJLSUZBNExFSHlzbURlM05vT1N2NU9Q?=
 =?utf-8?B?UHVlc3pmR0FUOEVLeHY0U2NLYWJUb0FuVFE4VUpldGhpMUVnQkJwekxxT2Y0?=
 =?utf-8?B?emRVaFprb1p2dzVxMFJaT3JlVEt6d3dwaW5henRnU3Z3eFBXclloU3ZYT2RJ?=
 =?utf-8?B?eWdlbmdzZ294OGp3T0hvdExkRXNJNDczeXR2WmRKTS94Z0M5c0lqMjhHamx5?=
 =?utf-8?B?bjRGbnNLS2p5Q21QSkJsclllbUU5bW5YNk53RENWODVGdFJlZVRLZ1dtQmx4?=
 =?utf-8?B?eVBmTzUxd29ERVd4MUc1dXpEVHBCY0hTVmlzYndJUldqajlVS0JRaENCczNF?=
 =?utf-8?B?cEN4TUNJcTJtb3JHL2RLWW9rWnl4RUp4UGNaaGV2S3N4MFh1WmlnSUVISGQw?=
 =?utf-8?B?R1lhTlhqRDdiL3kvbzZLU1RIekVDd3J4eWMwQi9icjZucjhidzhuaEp2dmhT?=
 =?utf-8?B?VTBtcldVRUovUG9XNUdJd3dXWjlOWGQrWktPbW5yL3lEOEdrVUJ4TDQwVUM3?=
 =?utf-8?B?Szgwb0loVDVKdm50R0dQTHI0aEVTaVQ1cG5aeXR6TnAxOTVaUVI1V0xnUzBM?=
 =?utf-8?B?aEJsd2VNOEJ0S1pZQXBSZDFLTnZWTVp4WU90aUJTR0pDUkNCNnBRUmZkcGlv?=
 =?utf-8?B?NHpocmhHNVFZdTNuU29IS25UQjZ6VUord1J6R1V5SDZiZ3htUCtpamhmbkQ5?=
 =?utf-8?B?RGNNL0FjWmszS1pyT3lRRDMwMkZDcHZuMmJ2amFiaVRFMFNTWjRNNk05RExW?=
 =?utf-8?B?WDZwSkZvaEZaQVl0eERLTEtMMmxGcFFaYkg1RmFRcVZURW51NUFoMnRhdTgx?=
 =?utf-8?B?cktoYkt3RVArNWpaakgrbENoUUhPRDlDSTc1ZitXU0RCOE5SM2dIUkZLWXlo?=
 =?utf-8?B?RFVBWUJhUWRKWHQ0ck80QXN1YllwRGpCdW1UbXhEeWp0NlNPTWpUNG9lL0F3?=
 =?utf-8?B?RVRETjNRdFBkdGNVV0JURnoxUU5qVmhWT25QZ0h5ZEZ1NkM0eHJsZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RXWAZqWOPf91UNugpjY+2Lu+xzisrOzWo2x5YzTPgXQfmSGajMjD3U/Xow9+O9p/3q6wHPbvKvQxxCuWUfxDpEq3G/M91pZO314bfZwuSav0S1xhy6HGP6hqW88O/ZCl7c3giIhQjY97kHI7wPBlpl+0RiixMNsvUf3if2DJwSE5GdBbCyobVGBews9myo93oBF4tu3kEHGCxw5a4QnKVPPoRLzWfTC/JtZWIMm7ZwXmFler5oZVFMGyq7DxmWtLlxUKYQ9QFrzYpJtYwOu2MkOdAFXykFEeF8toVaMrMMbKmrKOfiQDeACsAN7zi/Fr/VM1Klp74g6Bty8kLtFpPg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f96b231-98e1-4990-094d-08dec059596e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 03:45:11.8154 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ZU3xlHNywIktzXCy3IBwKnyTsvY/K26D2/LnfRFP1zVa5/TI1jwqUmT0ybhrTR+Pip6ko+pTgJMeTu+B5NyodJ/Bn6dis/qIiCGvs8gtGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8370
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDgvMTBdIGh3L2FybS9hc3Bl
ZWRfYXN0MTA0MDogSW50cm9kdWNlIEkyQyBzdXBwb3J0DQo+IA0KPiBPbiA1LzI5LzI2IDA4OjQy
LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gSW50cm9kdWNlIEkyQyBjb250cm9sbGVyIHN1cHBvcnQg
Zm9yIHRoZSBBU1QxMDQwIFNvQyBtb2RlbC4NCj4gPg0KPiA+IFRoZSBJMkMgbW9kZWwgdHlwZSBp
cyBzZWxlY3RlZCBmcm9tIHRoZSBTb0MgdHlwZSBuYW1lLCBhbGxvd2luZyB0aGUNCj4gPiBBU1Qx
MDQwIFNvQyB0byB1c2UgdGhlIGNvcnJlc3BvbmRpbmcgYXNwZWVkLmkyYy1hc3QxMDQwIG1vZGVs
Lg0KPiA+DQo+ID4gVGhlIEkyQyBjb250cm9sbGVyIGlzIG1hcHBlZCBhdCAweDc0QzBGMDAwIGFu
ZCB1c2VzIElSUXMNCj4gPiA2NCAtIDc3LCB3aXRoIG9uZSBJUlEgYXNzaWduZWQgcGVyIEkyQyBi
dXMuDQo+ID4NCj4gPiBUaGUgY29udHJvbGxlciBEUkFNIGxpbmsgaXMgY29ubmVjdGVkIHRvIFNS
QU0xIChIeXBlclJBTSkgZm9yIERNQQ0KPiA+IHN1cHBvcnQuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAg
IGh3L2FybS9hc3BlZWRfYXN0MTA0MC5jIHwgMjQgKysrKysrKysrKysrKysrKysrKysrKysrDQo+
ID4gICAxIGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2h3L2FybS9hc3BlZWRfYXN0MTA0MC5jIGIvaHcvYXJtL2FzcGVlZF9hc3QxMDQwLmMgaW5k
ZXgNCj4gPiA3NzIxMWNlMWYzLi5hNGZlMDY1OGQ1IDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FybS9h
c3BlZWRfYXN0MTA0MC5jDQo+ID4gKysrIGIvaHcvYXJtL2FzcGVlZF9hc3QxMDQwLmMNCj4gPiBA
QCAtOTQsNyArOTQsMTQgQEAgc3RhdGljIHZvaWQgYXNwZWVkX3NvY19hc3QxMDQwX2luaXQoT2Jq
ZWN0ICpvYmopDQo+ID4gICAgICAgQXNwZWVkMTB4MFNvQ1N0YXRlICphID0gQVNQRUVEMTBYMF9T
T0Mob2JqKTsNCj4gPiAgICAgICBBc3BlZWRTb0NTdGF0ZSAqcyA9IEFTUEVFRF9TT0Mob2JqKTsN
Cj4gPiAgICAgICBBc3BlZWRTb0NDbGFzcyAqc2MgPSBBU1BFRURfU09DX0dFVF9DTEFTUyhzKTsN
Cj4gPiArICAgIGNoYXIgdHlwZW5hbWVbNjRdOw0KPiA+ICsgICAgY2hhciBzb2NuYW1lWzhdOw0K
PiA+ICAgICAgIGludCBpOw0KPiA+ICsNCj4gPiArICAgIGlmIChzc2NhbmYob2JqZWN0X2dldF90
eXBlbmFtZShvYmopLCAiJTdzIiwgc29jbmFtZSkgIT0gMSkgew0KPiA+ICsgICAgICAgIGdfYXNz
ZXJ0X25vdF9yZWFjaGVkKCk7DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICAgICAgIG9iamVjdF9p
bml0aWFsaXplX2NoaWxkKG9iaiwgImFybXY3bSIsICZhLT5hcm12N20sDQo+IFRZUEVfQVJNVjdN
KTsNCj4gPg0KPiA+ICAgICAgIHMtPnN5c2NsayA9IHFkZXZfaW5pdF9jbG9ja19pbihERVZJQ0Uo
cyksICJzeXNjbGsiLCBOVUxMLCBOVUxMLA0KPiA+IDApOyBAQCAtMTE3LDYgKzEyNCw4IEBAIHN0
YXRpYyB2b2lkIGFzcGVlZF9zb2NfYXN0MTA0MF9pbml0KE9iamVjdCAqb2JqKQ0KPiA+ICAgICAg
ICAgICBvYmplY3RfaW5pdGlhbGl6ZV9jaGlsZChvYmosICJzZ3Bpb1sqXSIsICZzLT5zZ3Bpb21b
aV0sDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJhc3BlZWQuc2dwaW8t
YXN0MjcwMCIpOw0KPiA+ICAgICAgIH0NCj4gPiArICAgIHNucHJpbnRmKHR5cGVuYW1lLCBzaXpl
b2YodHlwZW5hbWUpLCAiYXNwZWVkLmkyYy0lcyIsIHNvY25hbWUpOw0KPiA+ICsgICAgb2JqZWN0
X2luaXRpYWxpemVfY2hpbGQob2JqLCAiaTJjIiwgJnMtPmkyYywgdHlwZW5hbWUpOw0KPiANCj4g
U2luY2Ugd2UgYXJlIGluIGFzcGVlZF9zb2NfYXN0MTA0MF9pbml0KCksIGNhbid0IHdlIHVzZQ0K
PiBUWVBFX0FTUEVFRF8xMDQwX0kyQyBpbnN0ZWFkIGFuZCBhdm9pZCBzc2NhbmYvc25wcmludGYg
Pw0KPiANCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3IGFuZCBzdWdnZXN0aW9uLg0KDQpXaWxsIGRv
Lg0KDQpKYW1pbg0KDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KPiA+DQo+ID4gICAgICAgb2Jq
ZWN0X2luaXRpYWxpemVfY2hpbGQob2JqLCAicHdtIiwgJnMtPnB3bSwNCj4gVFlQRV9VTklNUExF
TUVOVEVEX0RFVklDRSk7DQo+ID4gICAgICAgb2JqZWN0X2luaXRpYWxpemVfY2hpbGQob2JqLCAi
ZXNwaSIsICZzLT5lc3BpLA0KPiA+IFRZUEVfVU5JTVBMRU1FTlRFRF9ERVZJQ0UpOyBAQCAtMjMz
LDYgKzI0MiwyMSBAQCBzdGF0aWMgdm9pZA0KPiBhc3BlZWRfc29jX2FzdDEwNDBfcmVhbGl6ZShE
ZXZpY2VTdGF0ZSAqZGV2X3NvYywgRXJyb3IgKiplcnJwKQ0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICBhc3BlZWRfc29jX2FzdDEwNDBfZ2V0X2lycShzLA0KPiBBU1BFRURfREVWX1NHUElP
TTAgKyBpKSk7DQo+ID4gICAgICAgfQ0KPiA+DQo+ID4gKyAgICAvKiBJMkMgKi8NCj4gPiArICAg
IG9iamVjdF9wcm9wZXJ0eV9zZXRfbGluayhPQkpFQ1QoJnMtPmkyYyksICJkcmFtIiwNCj4gT0JK
RUNUKCZzLT5zcmFtWzFdKSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmZXJy
b3JfYWJvcnQpOw0KPiA+ICsgICAgaWYgKCFzeXNidXNfcmVhbGl6ZShTWVNfQlVTX0RFVklDRSgm
cy0+aTJjKSwgZXJycCkpIHsNCj4gPiArICAgICAgICByZXR1cm47DQo+ID4gKyAgICB9DQo+ID4g
KyAgICBhc3BlZWRfbW1pb19tYXAocy0+bWVtb3J5LCBTWVNfQlVTX0RFVklDRSgmcy0+aTJjKSwg
MCwNCj4gPiArICAgICAgICAgICAgICAgICAgICBzYy0+bWVtbWFwW0FTUEVFRF9ERVZfSTJDXSk7
DQo+ID4gKyAgICBmb3IgKGkgPSAwOyBpIDwgQVNQRUVEX0kyQ19HRVRfQ0xBU1MoJnMtPmkyYykt
Pm51bV9idXNzZXM7IGkrKykgew0KPiA+ICsgICAgICAgIHFlbXVfaXJxIGlycSA9IHFkZXZfZ2V0
X2dwaW9faW4oREVWSUNFKCZhLT5hcm12N20pLA0KPiA+ICsNCj4gc2MtPmlycW1hcFtBU1BFRURf
REVWX0kyQ10gKyBpKTsNCj4gPiArICAgICAgICAvKiBUaGUgQVNUMTA0MCBJMkMgY29udHJvbGxl
ciBoYXMgb25lIElSUSBwZXIgYnVzLiAqLw0KPiA+ICsgICAgICAgIHN5c2J1c19jb25uZWN0X2ly
cShTWVNfQlVTX0RFVklDRSgmcy0+aTJjLmJ1c3Nlc1tpXSksIDAsIGlycSk7DQo+ID4gKyAgICB9
DQo+ID4gKw0KPiA+ICAgICAgIC8qIFVuaW1wbGVtZW50ZWQgcGVyaXBoZXJhbHMgKi8NCj4gPiAg
ICAgICBhc3BlZWRfbW1pb19tYXBfdW5pbXBsZW1lbnRlZChzLT5tZW1vcnksDQo+IFNZU19CVVNf
REVWSUNFKCZzLT5wd20pLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICJhc3BlZWQucHdtIiwNCg0K

