Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD7C2EA3F28
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 09:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpjm2-00026Y-V8; Tue, 10 Feb 2026 04:11:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjly-0001nt-RX; Tue, 10 Feb 2026 04:11:06 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjlx-0004jF-Bb; Tue, 10 Feb 2026 04:11:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zRkHHGeICCfHMMOV517+aA5VTN3CJ6BqNIsd9fia6dJLB9fun6joGIyexNYwxdgRLaGaFKFsNIJKE4th7ffRJVoB0/vRD3N3D8QbEVKC9NNJoD81mAB1IhCORTwxysZdENWnPKepdOErIXi05zLQrjqxmnwgXBgPg/uvmVH/OOO2ShMh6V8xESTjAxdwvqCnPzN4pHavytoDEVibOLMOIUzFpSzRPNX0+HM5fZKKePoJQmvSsP3mTugbWq6gok66XQHUgJy5Sc1KGlLQjAirL0bsgwjvj5owrWMZ3nBUZfjYDNHrCMlHm+hsXMl2dBzV4BsQ4OBCyIpY/ao3TP8dyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgEJQN7A3LetzcY4YoTnwpWTyIH0rOx/JzL8j2HLGNA=;
 b=s/cgU7+Xs2pwTxb8tTwVCKrGfzO5daLIZcq7MUnsKMQjbO3mMRteBG8R2NSlym+smJvoytE9oVOT8Qex65Tn/bQCyTN0167cDp7sXqgtiYcb4mmNq6jDJnHgypvser0D7ec//txWHsRY+lr/Ao5OLzgSBbAqN38msd/mffyyYlPN22DLHhVIP3zqn7sgHm3DHVpVZfi0uQwo7zZ+WMb+V7tXHmorf0hOvFaAr23i48dvGxSw+w+NawKqZjmHFotFNgBYBtb2lMz94Zm7LrCK11sEi+ClbB/vONIvXVBg4WTFGUwyQJwLsKcG8i2e6lTInpkLDrLWC7QeXxIX/GcG/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgEJQN7A3LetzcY4YoTnwpWTyIH0rOx/JzL8j2HLGNA=;
 b=LwuT/WQOyXCO9QTc2we+vhSCdyGfOWA44LU96a3B1gkNhInOsEbXhH2ZxMOlLaiCaAmW7KWAxg20Esf9VEXTPf9IoNu4H8J/TEQFzzurHHiVM3ybyAy5nYvNoT1KB4FrsWv8ClpG3n0Y2JFZ4UlzOilcsiZgtSGmeIKX5FuVvOe9kRgBHCbpfqvdFDZK1BTqvKz24E/RuzctXH6jQT3381Lfq+rSctvDduGTx1zg87UjaPKwbcV+bMgqgtpCNTodZh+AsawCRO5i/z4W4P7sQd+g9L+vcvSG4H4FQsqt27qddD+pxuxiKFaYGkexja80IVDVVDstVX7cTaQvr/Swbw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUZPR06MB8268.apcprd06.prod.outlook.com (2603:1096:d10:62::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 09:10:48 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 09:10:48 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, Joe Komlodi <komlodi@google.com>, Patrick Venture
 <venture@google.com>
Subject: [PATCH v5 20/21] hw/i3c: Add hotplug support
Thread-Topic: [PATCH v5 20/21] hw/i3c: Add hotplug support
Thread-Index: AQHcmm0l78znil3duUCSKUHnLxRD7Q==
Date: Tue, 10 Feb 2026 09:10:48 +0000
Message-ID: <20260210091018.1553489-21-jamin_lin@aspeedtech.com>
References: <20260210091018.1553489-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260210091018.1553489-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KUZPR06MB8268:EE_
x-ms-office365-filtering-correlation-id: 700cb982-1295-4b0e-b069-08de6884481b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Vgnqrxvayz8EGTGF0fgFC9HVMfbofOw/yLJEL+zftfAHyZjtsK2igxMlec?=
 =?iso-8859-1?Q?vYD7QTm1Wg/jWfUK6s7JkM/vVOW3TdZMwDHbc6Vzemwazx8UUuB40fmNvu?=
 =?iso-8859-1?Q?HSp0uknof5eDiZyTTohqxXo6ZREMgOwbcwuyPWWQdKli23c+dyq58WTJvk?=
 =?iso-8859-1?Q?5urj4EbidJd73uKApo7kBjteOYadBoPYzV5x/Vy5wYrmZdp0QO6OjaJwgO?=
 =?iso-8859-1?Q?DNvKYBeW6sSMTF+A+KwH/sGCYlc3Li+0tytG/paM4Tam6AiwesjWQzzUrd?=
 =?iso-8859-1?Q?Jgv3qrznDh8kp3syXOTsR8dF79H3Jl0iE+hQ53HlFNXB6zYURV6fiatGIz?=
 =?iso-8859-1?Q?7h2tvS6+/8Zu1yXTL/Jo3k+3wjaF4nSjaG5IVS1bIHW30YkMsNZR8r/rPa?=
 =?iso-8859-1?Q?pBPYx5Lf04B+rWCPxyqYQIzTf8hQ7+YqjfiyR6VEPuxxPiB4MUkQcn2zKl?=
 =?iso-8859-1?Q?sxBXMOVyEr0+YOteH5lZvg6vce8zp6oazR7JQimA0yEun5sjjRARXI11rH?=
 =?iso-8859-1?Q?N4f4mf9WDpeeebqojbdqJPYf35JeHi22IKiRo19YZ3L6SX9uQ+iP3o0+aT?=
 =?iso-8859-1?Q?uEUSSkv1uZBQoLXCF1HhNgvAf0i8yYpZoy2XkcH3An0CRxe/gKU/f83paZ?=
 =?iso-8859-1?Q?h8Z9L5eL6cVTndQ4mmP38zJSMY7Nb9Om3KGTKxn9O0DV3m04ep6iz7M2n4?=
 =?iso-8859-1?Q?MD66h01j1kzaDtqZMuUixjmsYs3hDEbXdl+aY6sZgeAwl9qsO66NocH0hc?=
 =?iso-8859-1?Q?anZ5yFQoas3tOvHKWre0ujsVWMOSOar4eTPua0xgjauaMfkhAr2Dmd2Uup?=
 =?iso-8859-1?Q?k91+G6OTokyXBWau9yzBPJlAcRh4X8q5RRLmxvDYawAV4mmOA0TYVB1HvT?=
 =?iso-8859-1?Q?zqORR8NU6CnZTO7D6m/0lI1YcRvrj40se1RY2kvZ5864BJvUdUu2k691Rl?=
 =?iso-8859-1?Q?PDrBEPJFCUipWkpwI8/DBLBULWPdY+wulEHuhiZ1nVCap4R4J6E0Y9o1Ts?=
 =?iso-8859-1?Q?Hgpw2lhNfNXrHw8mKERhoTQa+lkEJ8jXyTSjgYdJeiciUT9h64gG48A1QL?=
 =?iso-8859-1?Q?tub441ai+MnQV3HTepvYjGlDBKTme7mQoK5f5ohdc4cJxSb4G2nuoIpMy8?=
 =?iso-8859-1?Q?rBqcBP0NBkgR/6uRA1WrrWp+C3zkd7vAleW7Up3Bze6ZQZ8/dJYEOyVGAO?=
 =?iso-8859-1?Q?V8Y5x1clhQoN1SHkYHGw18pINgukIi0cQFGx91ZsaRSJm3h025EviteltD?=
 =?iso-8859-1?Q?kGD6yi23wqfCTBCuFvKYGeAOsC29yUmFns7y9TJ+W9HcBS6kyS+MSHUlMf?=
 =?iso-8859-1?Q?0qW6DML/71IPhFQuxXQ9Ud9ECC7DVcfi7ckoEuQx5ngxunwN6IxcTLr9fd?=
 =?iso-8859-1?Q?UHuONwq3J6RFNFMLEWBw6jbYA/6/jGDhlSkIPq7TvWcZas7YBbM/tfEizl?=
 =?iso-8859-1?Q?hJY7hL1IvjvCfjsPjQwM/aO4VCCWn/iWyAyd+CfiCzR1819aFbuY3HWgQf?=
 =?iso-8859-1?Q?vtLckBNLRwcEkJ0UwnZcnZ4DH3+wlrODMNIsOVG9OVANfXNVYPKwd+7ftj?=
 =?iso-8859-1?Q?a3l8mCHUpW4z2fdVpXHuxe7GCmUMCgJYt6BqxXGbB3tFaGkd8Ar1JoedIr?=
 =?iso-8859-1?Q?mawX0gEx8ayoHPk7JBo+tgPadvBv/C8I87l8TJOerqriaeAKiQSAjSPQgH?=
 =?iso-8859-1?Q?i9GWk7CTIdIzl7V+xbzV9mDryQ69JYaQYPoNEABx?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jnFTNaKs/UNM5isJZJJFVJKYCk3h087G17k/ryz+ia1SrRyLDeZky+BwRv?=
 =?iso-8859-1?Q?PAAhaG7XZto4s4If2FzUxDE8p6zyPCNMoIbmdrnfqGWkyCeVO2ZWNpd/EF?=
 =?iso-8859-1?Q?8IRGHJZirDxindD2taLy8HZjjmwJOFboZxLYvlaI5tNTvqVMoVXw93FgDk?=
 =?iso-8859-1?Q?4huZrBfAQqLf5tJq2vQOdLRyUPwbb/tCR7KePMwVQjPq1BRdwj+n073U7x?=
 =?iso-8859-1?Q?KjN97cav2FzllcNEwC/D2iPocHM+NPxANg0RdFENDTM56YWyp9wFo7bhE0?=
 =?iso-8859-1?Q?QTG8fuqzr1/0Qg6vebKy5RLGwjo1Qgfv4a+tDbJNlpUGmfXU2SliYp01kU?=
 =?iso-8859-1?Q?BWxQaMEG9QiUU/QoS6yIM5sLcopSmoEj0k2fgxIbQLv2DKjhcDfAd0Psuk?=
 =?iso-8859-1?Q?nOLLomFjYtE1NFkMM2+qpxhw0gmSiOtH5CPM/VNoOq95BxeZPN+fHSGX0c?=
 =?iso-8859-1?Q?SNxUpZl6gwTlwdnYj8DOGTNvp9sdyE9JgZSwhZ5MIhhwB85V2M1TTkFbEi?=
 =?iso-8859-1?Q?0516IDcFli8wk/7MK55ULrBc7BL5gPAT0s3zjG/JQDr2GnG7jQZeICYA70?=
 =?iso-8859-1?Q?qzlRuNgE0j/2PaEibPivmugczYJMhr2kxFWFXFqWHwS1TW5D80OVqhTO01?=
 =?iso-8859-1?Q?nFdfEUBdM7/AlGYxrhJN52Rp2O2eV7/gQd8MMiiAcI+I9T2RRUXO1oLzo7?=
 =?iso-8859-1?Q?xqMwt3DT3BluC/32x8wwKULARTonZ5iLLVEfeUNJNgbuC5l5vdDu0wn2Mg?=
 =?iso-8859-1?Q?qLbvIwt3N3395BOESzvBv8dLDmQVDLdfV6ygjWkvy9ow6dp5OoJlNu+SGt?=
 =?iso-8859-1?Q?uksx2MYnQkZiaF7+AhIk2/IMaTkf5/H/LgxlHXCGJtmgq3CayggDo6H2Lo?=
 =?iso-8859-1?Q?Fo0ZoStXU8m9DMgKNqoEgutMg1wrQYN2qTzPulFeU0ZhaoSxu1mOdQW/i8?=
 =?iso-8859-1?Q?/eUO3GZZeL3jUDF/2WQjumVc2+9DCJ6+344oXiU2ymlXnudRlPHxIdq0sb?=
 =?iso-8859-1?Q?hDC8RDE9/O5hU7vxfdBYvPm4N9RS8njEBYQXNQZathk4/Ig+CH37EJrfOF?=
 =?iso-8859-1?Q?GHp2Em7fUqqEr/rb4OYz4LT9fgu3we3ykdmUKhQYP28WLX+zAKNULpnyAy?=
 =?iso-8859-1?Q?wtNdDL4fShOaPQCbNbNETpOZ7AOBDx9hj05gQ//xOk3w0hHZpmYL4SgIza?=
 =?iso-8859-1?Q?bwsI8sbpoiN5TfzIAEe1qsl1Mcc1eLBR6yzzrmcSBigwTFCqz6iswuoV28?=
 =?iso-8859-1?Q?ti0fJf3VHOA3YqsDGYpIWQe6GPluhS1U21T6IlFJezO1vofWbT+0xIbBwR?=
 =?iso-8859-1?Q?A4EufQGk7teSB2BrxTrH8lgiYuiWlyi614A8Gb08Tu+VoUA9wQbMPiziOB?=
 =?iso-8859-1?Q?4R2H1czqHj3UBxYhz9mCy79sIinmC/ExCNvDMY6ln0ILWtLt0wygKpN4l9?=
 =?iso-8859-1?Q?oRUaMjJ2IdPJrLEAwSmJbMz9wBrUAkBc+MUWS5/3rJnecsV99K0gCFNFQR?=
 =?iso-8859-1?Q?ig2mQX40vmkMDDLHr2nhA7+GAD1pubrrNaS4S7t/7L2GBDU30SfhRUGyKA?=
 =?iso-8859-1?Q?aF8oa9UJIFftTduv0H6zLuj0peHuC/y6x1sHcUvigMPQgqQ5nRF9dxLgsS?=
 =?iso-8859-1?Q?cAdA2x+Eurarq+0FPp+zu2eFUdMuHwMVSoUdddKlo21HdYYVCSjjBowlal?=
 =?iso-8859-1?Q?YIzBWhl3TXcR9VmwFs3rHr+Fn58fbXC9LYAC9pabUjupCWwmJzhixBBTeQ?=
 =?iso-8859-1?Q?BiKFf+cgCx2Gtlxd2ga04Weea5AGIKW6lTBid60G/vBOxP6mTmpZov0BW5?=
 =?iso-8859-1?Q?OEu50bwBYQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700cb982-1295-4b0e-b069-08de6884481b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 09:10:48.7916 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CioMghyi02T9KKywL/RW28XGGFsvTau2qxzJPGV/n/NTLCUgRedFVef44FfWprewUUIMQH1pmiS7HYarkFC+1xIZGNShdmLnTIQD/iLLZlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8268
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

This adds support for hotplugging in I3C.=0A=
Conceptually this can be thought of as an I3C target being physically=0A=
socketed onto a board.=0A=
It is then the target's responsibility to go through the hot-join and=0A=
DAA process so it can participate on the bus.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/core.c | 17 +++++++++++++++++=0A=
 1 file changed, 17 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/core.c b/hw/i3c/core.c=0A=
index 22e6e226a7..8a37099ce3 100644=0A=
--- a/hw/i3c/core.c=0A=
+++ b/hw/i3c/core.c=0A=
@@ -11,6 +11,7 @@=0A=
 #include "qapi/error.h"=0A=
 #include "trace.h"=0A=
 #include "hw/i3c/i3c.h"=0A=
+#include "hw/core/hotplug.h"=0A=
 #include "hw/core/qdev-properties.h"=0A=
 =0A=
 /*=0A=
@@ -26,6 +27,17 @@ static const Property i3c_props[] =3D {=0A=
     DEFINE_PROP_UINT64("pid", struct I3CTarget, pid, 0),=0A=
 };=0A=
 =0A=
+static void i3c_realize(BusState *bus, Error **errp)=0A=
+{=0A=
+    qbus_set_bus_hotplug_handler(bus);=0A=
+}=0A=
+=0A=
+static void i3c_class_init(ObjectClass *klass, const void *data)=0A=
+{=0A=
+    BusClass *k =3D BUS_CLASS(klass);=0A=
+    k->realize =3D i3c_realize;=0A=
+}=0A=
+=0A=
 I3CBus *i3c_init_bus(DeviceState *parent, const char *name)=0A=
 {=0A=
     return i3c_init_bus_type(TYPE_I3C_BUS, parent, name);=0A=
@@ -633,6 +645,11 @@ static const TypeInfo i3c_types[] =3D {=0A=
         .parent =3D TYPE_BUS,=0A=
         .instance_size =3D sizeof(I3CBus),=0A=
         .class_size =3D sizeof(I3CBusClass),=0A=
+        .class_init =3D i3c_class_init,=0A=
+        .interfaces =3D (InterfaceInfo[]) {=0A=
+            { TYPE_HOTPLUG_HANDLER },=0A=
+            { }=0A=
+        }=0A=
     },=0A=
     {=0A=
         .name =3D TYPE_I3C_TARGET,=0A=
-- =0A=
2.43.0=0A=

