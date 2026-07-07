Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF57C43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgyzz-00033J-BY; Tue, 07 Jul 2026 02:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgyzx-00031D-Uo; Tue, 07 Jul 2026 02:09:37 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgyzw-00083P-8H; Tue, 07 Jul 2026 02:09:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHRGBTN5xDYh+TcQM5NyWx2tVUUDHZeE54XicUKDwm5wd21z4XqpWpgGECE0lMi0pJG7Wm3ES7T1CsgpMMrIZ98iDKnGhCkuvVSNNs0BEWrXKpqk4w7BizPGlvKsrKFeei4NrRH6Ywm68Eo+FulKfpWUXGsdQKmKapxtZ96vNku7HFm0Q5tACl+D6/XGhvcjcQzb4P4RIF8zt9DTtRSIFB5FshXAsXA4QSVLNLVBErkDV1c7DBEP3p01j0JuQkWAq5stL64/GgB+F+GAoVVs/04LyZ8qmW5WeD7E2m8t09tPy72RrQrmvLDXOlWtrc8zfmDye6k/tzvkQANhhNmIJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgnD/CP9g3WHv5qs+77hjMirb6bsj0ho1nNhWfDTMn0=;
 b=x2I7YNyyGjkyE6LPkrxZQ+Lc+kZJgTYeYD4NPKYN4XTo/Vm0tFfbZ/gEp/wkDnlBpB8kwXz0X2YaDKBdLAD8nLz5gL+8PDL8I/GqM0/Axlv6GgYc8pKxdP3Fguty7XmfXOLsPM9Ct3ZvChaQJUKSG41A3+6QBIxeHUIyg7MzMvW/H6OfbrfOZ0GQj/9t/C7UsDGF4HWXEsHu93d6+xqocClu743986EZefJS4Y4BtFiIfQzjkC43Ojr8NMNunB414ibhvl/SWs1FxfnxaibJvaLjK091dnqbHU5RGfF5uUtGunF74yVY8S4p8hG5InlBqHHnzz6hAXwvZNAwDFSGsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgnD/CP9g3WHv5qs+77hjMirb6bsj0ho1nNhWfDTMn0=;
 b=KjABbMszk3Mt4RjD9ZxcJ5oWHjctawMGn2mAITrXCMAMUKnYrSoOq0LifEsChM7ONRnlwGYVLuYll6fxhq2UhlNX3iZVMQ/TxZYYzNu7Bc//6LYzaWow+MtipX6WSkLVJo0s6zh2riXtrygbVLdpXogAXJ4p3bazXqOMau4oC14dh+m901veBwsPPpoGGxWHw873Kt+VothJDyJ5OtJWyzXGeLLKbr1BRwuPo/vjfLTmMIva1O5oc6mV7/YrYCze6teAQ2zLt7EgedvwOpup7ijjqgDctUiaXCUjZvVougG2NYddU8qdRcRNXsr+zVBim5pgZENrSnJNZg9fr4euwg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SI3PR06MB8706.apcprd06.prod.outlook.com (2603:1096:4:2a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 06:09:23 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Tue, 7 Jul 2026
 06:09:23 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 2/8] hw/arm/aspeed: Use Aspeed2700SCUState for AST2700 users
Thread-Topic: [PATCH v2 2/8] hw/arm/aspeed: Use Aspeed2700SCUState for AST2700
 users
Thread-Index: AQHdDdcoP5pdNsKSOkWfrrtNCAPjVA==
Date: Tue, 7 Jul 2026 06:09:23 +0000
Message-ID: <20260707060919.350637-3-jamin_lin@aspeedtech.com>
References: <20260707060919.350637-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260707060919.350637-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SI3PR06MB8706:EE_
x-ms-office365-filtering-correlation-id: 8b25f9b8-15f1-46ba-c9ff-08dedbee4ac0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|56012099006|38070700021|921020;
x-microsoft-antispam-message-info: ewauuBdYZbVby0KqGNLp/M2ALOkqsWpjLB4+10Fc7nMSGfjUDGvveZJ0Nq194s/nHk3CUi7OOi3YV/tor9twwL2DtCdokieZY7rCgJgmBD64jck9TGJqo6MC9S5FHr89Y/y/s/lmm9gsmu46jH9wzJu3N1rtFG9L1xqsWckt9cHB6RmKhrehwGNjaM15WK9bi+tXuNIqAwy/t05G+zXE9vy59FnY2NtD4t6TcPBea0sbD+oYEHHvi4JTl25+ZexFFPOLI3SjixlYUU+9V3FaEs3f3SG9vLqHFmvYiwILYGaEOitSvlbd3CFKASldf+TAQsaqbumQzUokYbdlC1BlGu0+UZFcu6hgzm6kC3RQ3Ljs4hkdpI/mk9JzBchYGmqqLesGv8GPvx1M12sBidSwcoPeCoKGgeX33qvvYgHlPL/Yv3yTioitYay3ZsjaFJhZSp8Qi0HbGncL++8SsujV8prhfuBvyqbX91C2E2p7csKrcUQ9Bok9xOR1GhX/X7IHhfr2KZl/ijRwlMcPvCkUN+3jZyrkm1NN7QTBmF/KUT5e50axQgae3nxBxwWIAGkH9Cv5uJ17R05zTXd8OkrBEZBki3E0LZQhvyrtSGZOkBh9t9+9pSnnF5iKLsjlKJjaQFdCjsqgQ3S1sh+zUzEfDF60w6z+NsKa275Pz9YFTmoDmhWnVMZ+351G1FI5mNlRMI25PL3aNUc6K6ifIhrAmqRtfoT2bda4CF8HQWbEx2F2dsa8fe9CzspFVTdMOFgn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EmsxLgCh+LzOaZuRxBYTB4nwTk33M/fIYMqFVmqxn0z08aP3s7w6jjGre+?=
 =?iso-8859-1?Q?A2vMAt1qKo3pRCy1n5hbSx+4hXOcaNMhQZmGXB+8TTDZ8LO5EmA2gIxku9?=
 =?iso-8859-1?Q?i1Rfxz7xLmWtUW96g1I7tnPxGx4sji0ItrsW9u5b0OXevQojZ9ntjHmUaT?=
 =?iso-8859-1?Q?rh80HQMnnSTw1IRREDNFuITS/OdClccBwUGL1fo2j22Lbym0JwBxBN0ipI?=
 =?iso-8859-1?Q?BXkShAH0QJKRnMfON2N5e12XHO3eyLlXMta2Cqnr5ZDkkorPZj7y1518NZ?=
 =?iso-8859-1?Q?ArwoMtovby4T1AXFxfp9iB1uHr0GtkyLUJEm/sj/hhqgbJ9+kZt9fHu2Fc?=
 =?iso-8859-1?Q?tas0sXiz0Ez/iu5BRjbBhj7CdDB9ZbDkpsstsqN4cNlxdnZufN2T/2VLzM?=
 =?iso-8859-1?Q?C9h0P2lYItz199n+OOIpO6mUdJ2uJ/4ybHxe6Anw/d8wsIl/LFeM83vrrP?=
 =?iso-8859-1?Q?plXVSwKv5xIlKE50WrvLZf1mYJLh8sDtYU6qHtW2QHuDLj0woSXGZcnLvf?=
 =?iso-8859-1?Q?OgYnjdo8ygI2+VoPHkljMEY/02weQ4Ke0qxYrL11ZbH7TjJncAAgVpmp6W?=
 =?iso-8859-1?Q?bcKGyKfGUB+OjaMAze8cUfb+ntKVGJoaTo8hIUKhs8Ehl0H+urIOWCbpJy?=
 =?iso-8859-1?Q?AbHOK1r+zpzZ4BVkXiSzDgpBAcoP1jkNtillzL22AEsdwP0VTmg4QsUU19?=
 =?iso-8859-1?Q?q/D9MRy++BdWxcqWoVSzDK40/6x9GRNVcIyC20JBe8gO68DKroSYgN3r53?=
 =?iso-8859-1?Q?MHikA17zTyXRYXTFed4BQZymNQs8SszhV2ayuaHIqJNffoJ9lfHKuJ/NNN?=
 =?iso-8859-1?Q?VDMWbv2qfSKM6wZggObKy1rc6A0UZciphNEVcf4eS+ctFJXw1dWTSI3Sqn?=
 =?iso-8859-1?Q?fMYhjs4savJ7v2ylKW+IMv96R/sSwWEzEqHl+wItmEVRFW3a+MZUhvS2UX?=
 =?iso-8859-1?Q?Zdpg8s2IVHTxMIwiAyGXyi7if4JNcPbN1em27iW+kfhw7Z9Tp7kGjykImH?=
 =?iso-8859-1?Q?hVqNenKnOSBWDcrXmvbdEUt4WUv2ulABmovS9yAYpW+HTyT+QW/7RUUxGN?=
 =?iso-8859-1?Q?QiYSYsp3YBNGhe75hyLVVrRioKBze5EmFrwTpUeWmHEPRco8JI0Xlh6+g3?=
 =?iso-8859-1?Q?8jBkbdlfHrROxysM6XeDTTrf+3oAVh7hIonkQUmQmA8pVOXPMfNlKpTENd?=
 =?iso-8859-1?Q?kOyg/ZYuF4rsGayi7H7jEo4cRgs69/bp2KqWtjrOiAHCnkIebwBPj47Agb?=
 =?iso-8859-1?Q?xkhOL8hWojOwehTJduOUO1NF4jSGwasS3eYqgVzDSvu6ZTfkvIXA0V8iH4?=
 =?iso-8859-1?Q?uqJogOAxlIiYOPawpxOJp9fl4buc89+etzBLqF4SHk9d43AlqUNWvpFCsp?=
 =?iso-8859-1?Q?z4uIKznipe11nHTGXkrVaYJniYWhSQS7DvuVdS0+aUEJSC5r/Puz0e61w8?=
 =?iso-8859-1?Q?5URBar7xuyrkL+89d4NDdpC5v4XeDnqzGDwTW8yx9+fRUn8tFYtZ/vp001?=
 =?iso-8859-1?Q?BWs6mHwzYwfJl2GNlkMuFzMD2SwbEQCA2G/fAk9ATbNt/8fI4ABvNDLIMb?=
 =?iso-8859-1?Q?4OLFvkTPVUG3UPukZNkK09mt61hFzdq5TuJSZ/XtwmTaENuSRK/LMF4Yq9?=
 =?iso-8859-1?Q?yIWeha4iwb3AJChebsT1VR3LiyP9p3m/o4i8jBwzaIdHLGu8VgOrPid9U/?=
 =?iso-8859-1?Q?EXei8qcIDhZeZ+hfTmMCxqBZY+ScyRMaDA1t0i1eezpKgqp+jqVCVUSNtM?=
 =?iso-8859-1?Q?CA5cc7FzD9ALGGE3p+Ox5Z80xQE+4YX3Rb7Md0WWcQNDO3mr3Bt6v3rG/+?=
 =?iso-8859-1?Q?YYdeZQLeZw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aFt9erPt6sLNP35kAe+Fln9sG3Df9eOMgdewHUNya+jPoN8s2DUHLVX/bqeHM52mZUMHnQYyHKhX9QOGuHG80j0XqfSG9UC4epXT7kEDv3Qj2rn1e0YwbkLyWP7+W6Z9Cnqww9lUj27H8ypGaRwhuJZgx9zjYT1y81kALBkLgfK7dHrL/c9Y3IND7w/J8PXFuobY+87/pqfov9srkiaf7EpHeBxyKEtEo+CrX8qHO7VqIbZ8eDEK5L8vMgs4PfXJS6aFrjrqgJcLmNcSJbCxwE3QPspZuEdzY/JYTSiaW+SjDFCG55ky/FgsDtg2ydRvyt2mh/ht18djOmC9FtTjSA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b25f9b8-15f1-46ba-c9ff-08dedbee4ac0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 06:09:23.5793 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5XapZTz26FqM4Os2SFszQTs5goolycRot0mTkgDMLioG9S3GWI6KiGT56nuEdhP8+cFody0pdsKL8EvNoFoggaX9U1HDwcwudUakm7v5lmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR06MB8706
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

Now that Aspeed2700SCUState has been introduced, update the AST1700 and=0A=
AST27x0 SoCs to instantiate the AST2700-specific SCU subclass instead of=0A=
the generic AspeedSCUState.=0A=
=0A=
Also update the AST27x0 FC board to link the SSP/TSP coprocessors to the=0A=
AST2700 SCU instance.=0A=
=0A=
This prepares the AST2700 platform for subsequent patches that move=0A=
AST2700-specific SCU functionality into the subclass.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_ast1700.h |  2 +-=0A=
 include/hw/arm/aspeed_soc.h     |  1 +=0A=
 hw/arm/aspeed_ast27x0-fc.c      |  4 ++--=0A=
 hw/arm/aspeed_ast27x0.c         | 16 ++++++++--------=0A=
 4 files changed, 12 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast170=
0.h=0A=
index f7bd4e8650..39c5977cf1 100644=0A=
--- a/include/hw/arm/aspeed_ast1700.h=0A=
+++ b/include/hw/arm/aspeed_ast1700.h=0A=
@@ -41,7 +41,7 @@ struct AspeedAST1700SoCState {=0A=
     MemoryRegion sram;=0A=
     AspeedSMCState spi;=0A=
     AspeedADCState adc;=0A=
-    AspeedSCUState scu;=0A=
+    Aspeed2700SCUState scu;=0A=
     AspeedGPIOState gpio;=0A=
     AspeedSGPIOState sgpiom[AST1700_SGPIO_NUM];=0A=
     AspeedI2CState i2c;=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index 41dc04e293..cd68c7f1ca 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -151,6 +151,7 @@ struct Aspeed27x0SoCState {=0A=
     AspeedINTCState intcioexp[ASPEED_IOEXP_NUM];=0A=
     GICv3State gic;=0A=
     MemoryRegion dram_empty;=0A=
+    Aspeed2700SCUState scu;=0A=
 };=0A=
 =0A=
 #define TYPE_ASPEED27X0_SOC "aspeed27x0-soc"=0A=
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c=0A=
index 7d9fade68d..8d49bb95d6 100644=0A=
--- a/hw/arm/aspeed_ast27x0-fc.c=0A=
+++ b/hw/arm/aspeed_ast27x0-fc.c=0A=
@@ -158,7 +158,7 @@ static bool ast2700fc_ssp_init(MachineState *machine, E=
rror **errp)=0A=
     object_property_set_link(OBJECT(&s->ssp), "sram",=0A=
                              OBJECT(&psp->sram), &error_abort);=0A=
     object_property_set_link(OBJECT(&s->ssp), "scu",=0A=
-                             OBJECT(&psp->scu), &error_abort);=0A=
+                             OBJECT(&s->ca35.scu), &error_abort);=0A=
     if (!qdev_realize(DEVICE(&s->ssp), NULL, errp)) {=0A=
         return false;=0A=
     }=0A=
@@ -190,7 +190,7 @@ static bool ast2700fc_tsp_init(MachineState *machine, E=
rror **errp)=0A=
     object_property_set_link(OBJECT(&s->tsp), "sram",=0A=
                              OBJECT(&psp->sram), &error_abort);=0A=
     object_property_set_link(OBJECT(&s->tsp), "scu",=0A=
-                             OBJECT(&psp->scu), &error_abort);=0A=
+                             OBJECT(&s->ca35.scu), &error_abort);=0A=
     if (!qdev_realize(DEVICE(&s->tsp), NULL, errp)) {=0A=
         return false;=0A=
     }=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index dddd7d2106..dd6dd0377c 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -435,12 +435,12 @@ static void aspeed_soc_ast2700_init(Object *obj)=0A=
 =0A=
     object_initialize_child(obj, "gic", &a->gic, gicv3_class_name());=0A=
 =0A=
-    object_initialize_child(obj, "scu", &s->scu, TYPE_ASPEED_2700_SCU);=0A=
-    qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev",=0A=
+    object_initialize_child(obj, "scu", &a->scu, TYPE_ASPEED_2700_SCU);=0A=
+    qdev_prop_set_uint32(DEVICE(&a->scu), "silicon-rev",=0A=
                          sc->silicon_rev);=0A=
-    object_property_add_alias(obj, "hw-strap1", OBJECT(&s->scu),=0A=
+    object_property_add_alias(obj, "hw-strap1", OBJECT(&a->scu),=0A=
                               "hw-strap1");=0A=
-    object_property_add_alias(obj, "hw-prot-key", OBJECT(&s->scu),=0A=
+    object_property_add_alias(obj, "hw-prot-key", OBJECT(&a->scu),=0A=
                               "hw-prot-key");=0A=
 =0A=
     object_initialize_child(obj, "scuio", &s->scuio, TYPE_ASPEED_2700_SCUI=
O);=0A=
@@ -808,10 +808,10 @@ static void aspeed_soc_ast2700_realize(DeviceState *d=
ev, Error **errp)=0A=
                                 sc->memmap[ASPEED_DEV_VBOOTROM], &s->vboot=
rom);=0A=
 =0A=
     /* SCU */=0A=
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&a->scu), errp)) {=0A=
         return;=0A=
     }=0A=
-    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->scu), 0,=0A=
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->scu), 0,=0A=
                     sc->memmap[ASPEED_DEV_SCU]);=0A=
 =0A=
     /* SCU1 */=0A=
@@ -929,7 +929,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev=
, Error **errp)=0A=
         AspeedWDTClass *awc =3D ASPEED_WDT_GET_CLASS(&s->wdt[i]);=0A=
         hwaddr wdt_offset =3D sc->memmap[ASPEED_DEV_WDT] + i * awc->iosize=
;=0A=
 =0A=
-        object_property_set_link(OBJECT(&s->wdt[i]), "scu", OBJECT(&s->scu=
),=0A=
+        object_property_set_link(OBJECT(&s->wdt[i]), "scu", OBJECT(&a->scu=
),=0A=
                                  &error_abort);=0A=
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {=0A=
             return;=0A=
@@ -1032,7 +1032,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *d=
ev, Error **errp)=0A=
                        aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_EMMC));=0A=
 =0A=
     /* Timer */=0A=
-    object_property_set_link(OBJECT(&s->timerctrl), "scu", OBJECT(&s->scu)=
,=0A=
+    object_property_set_link(OBJECT(&s->timerctrl), "scu", OBJECT(&a->scu)=
,=0A=
                              &error_abort);=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->timerctrl), errp)) {=0A=
         return;=0A=
-- =0A=
2.43.0=0A=

