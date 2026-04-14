Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FB9ED7B86
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 08:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCYhm-0003o9-Jr; Tue, 14 Apr 2026 04:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCYhd-0003dy-Gz; Tue, 14 Apr 2026 04:00:57 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCYhc-00060M-3V; Tue, 14 Apr 2026 04:00:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pzg0jgLY5U9xVZo4sMeBpRS56Ko9ph/cr/GmC6YM4qj/iaq/tg5VL2t9x74db5j13SD2QIwgtdsyvQCIvDHGM1nKBnxXxusmKIKPlzRmcGSF+0jf6/ZWd0ohoHzRTt8Z5GRsflAG8PzY6cxG8WDYMBhPHsFc7af8xu+5chvFY3bx53+Pe4Lh2TigEDvPronMGAb2+AImIjjTk4BPsVpp6bAUXVj3AWwNJ9xsVGFQT2B8zR4IJX8fETHTjMXKSo3a6asoG9V403raoXytTMNaZ3hMOGB+o/dufbIu/jLuYUg/95rw0Ohde4QzuRPAjyRGDSv+nlk9V2D8MeIwqUA5ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VyCwDqxis3DBBPb6bjfJ2G4AY6nV23Q9QeGiVUfq1tM=;
 b=Xs/0etOoY9Bg4XVSwKiSrupYxoMeCnDL76FEaFXj40rf7p//R/YzELWq2itsfMPxYDd6o/Oe+V06s7H/PwIc8sFZmYIm+E/6ksLM7XUPKtTR8KksR/2lkJVwWXB+QJaSrI3Qk1nkb2/tsL5aiD1P6qFkXk9m4vpn3SxhlAf1Kvfk+q8xpYVKXALZW9myQTdsGTsgRWap3wBam+7fDyPuSeqHpelaWh4uiL/vdsWiFQ6MYIhNAoZzYQHsKdogHunHufZaZ1SbGyZg/PLlK8kYsEBWqiEVfd94rMUC3BpPIhlIL+iq03Da9e6APhP/l8qsWTcfuiTP6Iimybq+YRxisQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyCwDqxis3DBBPb6bjfJ2G4AY6nV23Q9QeGiVUfq1tM=;
 b=ld+Zwp0sq6iwpZ829I9jWUtxqaW/GfR+mcaH+OFO9p30JHtdsAAHrgTvq15siaWyx3GgMAThlCsXNEGk64djFlarvGZah9NIi/sWn/WPwKVoF8MHucJh9MYw60fNZQ1j7gaJ5MuPPf/McdududyRbW0vZpXDsoq93c23eVr9kVHZfCO+JzM4JJAfsWb6DFlrCK9eDOFuTh2yVCAfJGuYyjOGqR6Qb6AjJtuRzz1bxeJg2uQJPDkbOyNsOy10/hV4JqmMKeHtNxvKyiP33JFG7lzwb4YYcQtfqdQqv55rhMRfc42HZKI0B/p7Xqud/6fow3ogMeHS0mzfx0LM3EjZRQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SI4PR06MB8423.apcprd06.prod.outlook.com (2603:1096:4:299::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 08:00:43 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 08:00:42 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>
Subject: [PATCH v2 14/17] hw/arm/aspeed_ast27x0: Enable 64-bit EHCI DMA
 addressing
Thread-Topic: [PATCH v2 14/17] hw/arm/aspeed_ast27x0: Enable 64-bit EHCI DMA
 addressing
Thread-Index: AQHcy+TKYA34hZRnakynJR36+qnNyw==
Date: Tue, 14 Apr 2026 08:00:42 +0000
Message-ID: <20260414080025.3005916-15-jamin_lin@aspeedtech.com>
References: <20260414080025.3005916-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260414080025.3005916-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SI4PR06MB8423:EE_
x-ms-office365-filtering-correlation-id: 2d58fe24-6a06-4405-6ad9-08de99fbed35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: F221E+tc5lsm/81+5b1GQIKk05Ro9nr8Sbsgb/LQl+4LjACYheUOxa/nmsZKfffU/B958VVHr85lBxANazcvp3N+M+T463m97ErDltguGKttkZ/ynZKMQL69U9mOPMIcZTDtztVKMR3Qp1EtvTW3apE/UH+GgFxfJ9DICMb6SmAETnIsZ0lp9AA+/+H7m47HmNrzIeiYXHJ1wqnOZ9KZCW60hK/yzApH8VilXlmtlJgH5hJHYiF3WUclVi6JF8nyzGPO1cyKarBm/n6kQ6lz1wL2pvGqygW997xL6AQkTLGfaLYq+YF0AzVbgHLjFpF3/XcauQ0Xn4OaujNhNOUrkAQ1D7VRUVcnXyfdcbArpSvDxKjFYs9KIU4QmkMdzBbMb7w7t3tSLzlmYrmQcfm9IIVWKwFn4e48UTV2qxIOhcghR+FuwOQ9p/J3eJ8nhkDkT2+QmtOqC/76JFR8UhHCarfHA3stw4bkoo0bV488egVaHbN6Q+RGOfasMekbTgN5WxThnXdUqFARgEttaPaEnVSAFYfrB2nCl0FD0V7F5Ij0zfSmHnkP9+L4yT5hDDjtAHFL+ulCiyoaa8zAJTvcqXg9+K/PKuDm0KXiYqoK8Te7U6f5LoYO9JHnLpJJOoIkjpeyC9tvODHDlvSfWn1DzKxrAtlr/FMo04NcyoL6YFkhAtysLhuhFTnAWzyeiBll3+oOVLH6jwqt3/Q/69ik/Mpa2d7sPo6macnwMFuS3XxSZvQE/6eKISWANAyChZA4oPrW3hT6ZAGV/pHAKQ9OM5nHHZptLMp2b21I0HFsfT0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CMPzA8VcSchlf9zaUVEbDmLeXBRF0PHhm99j2ZVaSrw7e90w9k+FVyBIy7?=
 =?iso-8859-1?Q?ti2tMw1wFk04ZKBsoa8BLccqq0bjZCTidWdpJbGy83rMzy+uy82FTJa899?=
 =?iso-8859-1?Q?NbKlDwiHlWmdOVCFOdDYgD/64H9b0hmJD61qiw6V5tzlVKD3ugyXJoMUVX?=
 =?iso-8859-1?Q?Z7chryK9RH1A+BHQF51/1zPPRDkNPSoE3FaepLeo3Om8mIgsOlDTP+sF/d?=
 =?iso-8859-1?Q?9FQx0LOz7Pr383CQb+DEeO3HrwnAfQ2aEEi7uq7ech/wnoSltF2OAmfj+i?=
 =?iso-8859-1?Q?5CxpUIiUmBAwPCVgmQ+dKUUDrh5998MBs2Lmx3SPpkJ3LCXqIEICnQSKj7?=
 =?iso-8859-1?Q?BeWptijbaoX1/u8thCG0Y9gUKozQNKPR/HZ9XhcUAcCvpjW8e7BbfxMSSi?=
 =?iso-8859-1?Q?FFgjIRxOTaPV2fsTupapK7T4NdlUK53/cZ0Etvy1HuBMuQQlZsMrnfo/pA?=
 =?iso-8859-1?Q?t4T6nzef0JtjBXu0Lqk1GCnwZzW4RXDmhkWkhTmS4kMaueWs218JwmsRmk?=
 =?iso-8859-1?Q?/4TueCh2Ys2Mgn5VXba89+jfXefEmq4dnw+HZrz7KP7IHYmLYCQ/hoDvnK?=
 =?iso-8859-1?Q?Jel4auVnVvZ9lCgw9cpHz+uh0+F82XO9VYUZEBa8Pko5kDjXKcU4D8+Qi6?=
 =?iso-8859-1?Q?bKjmLKESP8/GDMCNjvz2vme3z2XsZXsXi7aNHJrcZylulzmdid4BdBu8OM?=
 =?iso-8859-1?Q?Qw+1Jn0syU+n8U7zOZgJ3cbLwuZqrt3croQzXVTCZqU1YEP+jvG8wRnbEB?=
 =?iso-8859-1?Q?If0dXSutIMhZWKMgDCQhaFJbv/vztQ5Gf5kqTgDbcg7pGSA6MUxVDXOqwy?=
 =?iso-8859-1?Q?+HAaqelyJYs+GEAaxnOsG0z5JnjniP+WHOnP18XMLWpLqnKpS4XLrIwFZx?=
 =?iso-8859-1?Q?XBf6IM27cepToTSlhMzoL0KBvwZX3xtt3nBp1SrVrw2zjrvEqZzon5UA3C?=
 =?iso-8859-1?Q?NcNuN3U1qyxnYYRP9VEowMtDnNaYqQFWpmO3QkLOALmU0OQEPxnuvMX1fQ?=
 =?iso-8859-1?Q?Kea4zUFvAV142mhSk53hC6fSCUcqMJT84MWYDy4gKjvqlmh/VgVUTv7aLd?=
 =?iso-8859-1?Q?1My1VtST+gB14Tv+9FM/Lzq3cQmja/3KHVPNNLefj/y6bvQYN3+BnxsNxM?=
 =?iso-8859-1?Q?1NUhstCqXzEM9+OKpOYyLm0AkNiU6tS8cRtCgRbIkDwzLDQRmisQud+ogg?=
 =?iso-8859-1?Q?WjRGlSOJBQlwFmHPbsm/eYWKyBi1DxhcN5eiIsxVnVj5p79qyms5nxrjG7?=
 =?iso-8859-1?Q?18Jn8EDjkPvDz1r1O8BNuc7X0zDdkmoix1wf34GGQaJaGYU05x1YnG4vVR?=
 =?iso-8859-1?Q?Dtskj0xql7H/S+X14qaLceQTLzx7sWplqKNHQGsWscWCScqiaa3btncnA3?=
 =?iso-8859-1?Q?LbN65v/I9WS0Asz2u5SFrYTOTHwXIydNKBsF8OLP0ADUIxdmGeif9YbB8P?=
 =?iso-8859-1?Q?sv+xez/r2dDQB90ThZhNpa5vFOtb6jEByRiVKF02X9tX/8f87OyjL992E7?=
 =?iso-8859-1?Q?/eQQjNkLMXcqYpCuACB0Hx5ytd9WxQp53lwX+goi7/DHdY6UgOc31Blf6K?=
 =?iso-8859-1?Q?yQ7JYoMKxmD8a44SuCbyyviCf/xn97rBFsxJNQZuAQP/2G6Y5mpoowbJw7?=
 =?iso-8859-1?Q?TFyDskuCXWRK8YF/RtbwkxoZCezCNfcDY+GU1hYmcKPdgxmV46SleW50wv?=
 =?iso-8859-1?Q?YEe+DoFpPefe2waPxdFkT7sC72R3NUmdq9XknvO2Dk+oEW3NctqNLzSPky?=
 =?iso-8859-1?Q?pk9HxdM+K7ZZTnaoFZI36nKjAo8ori6S+mIFsHyLLwUwQQ65jkZFRCdj4B?=
 =?iso-8859-1?Q?jCjrdQaghQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TI9gWeNczUPZTlZiHyRIMlncG+hB9nh4PlNQ08Yc/23WS1bx2NSNZpBkcQ1r4h+Easm9kB72PyzI+fdK7YAbGO61cNhThVZ2KK04e+UWbb2BlSL0HVA7WBlFbhSjBqFa6tw8sfHXMKn6zSgxohuZ048ZR+6FTfQx05ElXBPaYmy/tth2dA/nl9LALXvDrh7++1wTVGbO0HQXgigKS3/cWHc7ql6tgJnx2wKPiqdMZK688tPANN55roNb3MRPc4zBTiTACkvoz2+ZPF6rOd6bo/zjsASfhAMyCsvRxJrMzV/I2alpMSq3Ejqii8+M0GpGwjqdJ6MJxV8NCVXeRrG5bA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d58fe24-6a06-4405-6ad9-08de99fbed35
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 08:00:42.7560 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RNFjEsOZFwAGwyKlQNN+0WCv/A137ZtyRyGXPxOB1UPNsBAaTZFOHIlx+mwId6Gs14o6UJYNjTJdW674hHVwz6HiQOls5XbyhK9ClXwD9tE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI4PR06MB8423
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

AST2700 supports a 64-bit DRAM address space. Therefore, DMA=0A=
transactions must be capable of accessing 64-bit addresses.=0A=
=0A=
Enable the "caps-64bit-addr" property for the EHCI controllers=0A=
on AST2700 so that USB DMA operations can correctly handle=0A=
64-bit memory addresses.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0.c | 2 ++=0A=
 1 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index 87dcb82e1b..4a1f7cad73 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -856,6 +856,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev=
, Error **errp)=0A=
 =0A=
     /* EHCI */=0A=
     for (i =3D 0; i < sc->ehcis_num; i++) {=0A=
+        object_property_set_bool(OBJECT(&s->ehci[i]), "caps-64bit-addr", t=
rue,=0A=
+                                 &error_abort);=0A=
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), errp)) {=0A=
             return;=0A=
         }=0A=
-- =0A=
2.43.0=0A=

