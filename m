Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4A2CD5BBF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 04:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRN8U-0001eu-9o; Mon, 25 May 2026 00:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8Q-0001dU-UX; Mon, 25 May 2026 00:41:50 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8P-0001Dc-Gd; Mon, 25 May 2026 00:41:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/QzEHbOuvxNguLn9mf6n9Hnr4alnkg8yzoWZUYQFQTUXebISjnwjsONcATz5KiprFK7ZGmpqfpgV0c3EJ+hsijC/zCjlsP6eZp9Z0LxJekLN9/l4E3bBTfcGqvAxF+qt12taCuegHplEg4XalGVw6X0u8dCBV4rkaX8fnQyF9QXhyDgTp/Vw6tzIJU+DNtDlnPjiyizXJNM9VCcWdC5bRZCZ3mswZNA0dSvZ2Nx1ZVIBe3uuoMX4tGtL4XkyudQ/Yrl9Y2pieJv1HYGUUcKhHTKVFxfeA8J/IxHqeAjEahaeBx6aoX2882mBRAvmbp0tiDul/eRq+IOqdxMJmBpBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXkRBUp5LLwnlsirEYrsTUOMfi2bZG8xSx3T9UVnkMw=;
 b=VRyG4pF1ulMphDmP7zZLou/HnClXUv334YdcQUeec1wtC2/6Oakg4/4+dB0+Ekj+0msa9TxBjl6Et3PbGl+MhPyKzV/IOklijqNN72+wj+KYiULC1lXUBcMYTo38Vc1+3niHCi/UQoNoj/zqmB3jB6GtqTPy9DIGyBi1Logw3UlYxkvqrtMUoHlZDocFI47r0kOdjLSxC4SRQtNg4FtKfPopY1ycOLox2pLSFnCOBLyn49lJ4/OP1h+d+5GihWlaktDDSROwQEC3D3yyhKYWTkgzoZV2qnqvagoUkKT2opop6BQN6VIHHLEyYwJ5UnVAuF/WdcrSV4IQv+TM2KtADg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXkRBUp5LLwnlsirEYrsTUOMfi2bZG8xSx3T9UVnkMw=;
 b=O2axs4RqyNTsYVWeiPLycaWtSr1i+WMi1WTn/4ze143iDBJIzmfyH6YCeYLxn6htlqVlm6IhlzJYiUZOE8KYMiyidsp3dwq9uCmZTTbZKYUv30uaeWAIXeuGJCGUNXF74g2oYFnwh7yMO4U9hNpaYUuKAmlCbokCAfGiji2dUoKu8Qg8Wk8Ir+q4E/agkiP8SChgQ1LahjnphCFFDCMEW6LuB7T1foLfI/Z6diVRtoNvuaJZb7UYpgCTTtwLVKtftuwe45XCSO29+3El4Lu5C7nBTJGsNSNXZp4fbWb1p5k4xmiKJN9n7YBN3sISzpkV6Dp00fxdfsLno3hRJeHbOQ==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYQPR06MB8085.apcprd06.prod.outlook.com (2603:1096:405:2f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 04:41:39 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 04:41:39 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: Alistair Francis <alistair@alistair23.me>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Ninad Palsule
 <ninad@linux.ibm.com>, Joe Komlodi <komlodi@google.com>, Nabih Estefan
 <nabihestefan@google.com>, Jason Wang <jasowang@redhat.com>, "open
 list:STM32F205" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 06/23] hw/misc/aspeed_lpc: convert to use Resettable
 interface
Thread-Topic: [PATCH v1 06/23] hw/misc/aspeed_lpc: convert to use Resettable
 interface
Thread-Index: AQHc7ADGR+6PLnlOTkCnQShaE5cxQw==
Date: Mon, 25 May 2026 04:41:39 +0000
Message-ID: <20260525044129.3133916-7-kane_chen@aspeedtech.com>
References: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TYQPR06MB8085:EE_
x-ms-office365-filtering-correlation-id: 0a404961-fb0e-4dc6-c43b-08deba17e929
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|18002099003|22082099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info: l0+YergzkCJJtrho5w4vNSNR2pBuCX6JqL+4sDvtrLxT4wsFKMcM2eE4E8aAOwVrC1pWwFVNGMPGBmCRY9UlcP8rnrVposL33BSy8yK3FMF+dHNohhNkAvIdetlgLBQirWk7AgiIjRpFWaxgvhkAuYhmmmY6u9JT+jBUqIWhGT/71lveWJAWEvuio9XNhWqHDSndUIbAoV/6FvWJFhtwEZTp4fSwp5h8Cl3VhetVMh6sE0MZ/G4YGAtBJdJUaWByWg775CLu9hhBB7wlPGaWOFOEVZ6czIT7nwYRj3keloiGTbAcJcuBXEdgA0n7gM92mVb+rAo2E2pspUiWtMIH6zw2SM/+IVMyCRn3G70FL9HyBTxT8JCWWPOFx/uM4Zjaa2hrHBcpKwupZaHjLZpSL03uQ+z5Ewuy127L/czLZ59O4ZP4uNQtlMACM2XXxUO8nNQQ4VUIwtDrRag0KXUkGbLTcuY4lvwAB72MOoDzofBHuAHjg7/1735hGiBUtuVljuHed0hoQK+gY6CJ1GByVnmmynYLJKNeEA9JAVe2KZahkL2hED3AklT6QqimCuYlGU3J58fTDMygYitOjVIJaNQxiqjBtQGBGj0pidOrvx59PLL4CyOxeizwq1bl4UREtFdspoM9yDmAC8jPKAov66RwBa26DO5Pj64ErBKsApF34BfgR2s0MWLtFW/R05EKY27Jt2edMa1yxnpSduNIkpL9pMRdBYsu62+L67eox99a8IFsO4zunjTdelbAf2rikhEKssW/dqptlJZ4iC7slA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(56012099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sMfc5uyjd1agi8aNs2oXyncem0OnUpuj4I32s72pEZliq6oU80GmPqYofm?=
 =?iso-8859-1?Q?MiWKExirQOiGhSk8J26bjqCCJH4Lq+sG0B5NmCvNu6M23IvNiIxpScXjmb?=
 =?iso-8859-1?Q?+9fkB+i1zMh8VqSy+rV+nLoDpDFybe2bTYp+i3NHmdWj7uKOIEsmmDclc0?=
 =?iso-8859-1?Q?LnhF6IljfUJWXqMEBNHYiE5rOCb/8bBXSWYfgTzh1dlNboEt49yxrgBEK7?=
 =?iso-8859-1?Q?OE135UGNej2wd9z9a7Xi4ML+SGnmZwjt000eM2sHv/1cah9luoRZi3bXJT?=
 =?iso-8859-1?Q?pFa07Wf5R65sc1q2ZMbJUkXyXFd+WWMKFGomZ2zGL+9qMatD14NjI1K6ws?=
 =?iso-8859-1?Q?GrF7y9yylqQdaCgiWmKon10vcniWOZ/kVCywkyVN1M5FGzsxXoxjWd6aRf?=
 =?iso-8859-1?Q?k9/8LJ3j3qKFTgPfZ9QvPvIYk7lKBGQbNXy2hF4NXHJZNdeLeOYLAIpqob?=
 =?iso-8859-1?Q?1IHWXeXUZ44g4dXxsM6See8ie/oFhiZ5E961b8g7KHKM2EXEbzUP1vUu2Q?=
 =?iso-8859-1?Q?xFOMkyDX8omGnnlCp0H0tdhOSFZ6FDzYv5isnOjPzes0Tnelox0QgCGO7U?=
 =?iso-8859-1?Q?0WfYSxvucFCl+T4YKyJ+WTd5LMTbOS0tRK36mZ0sscYWbiJc11vQmpL6uH?=
 =?iso-8859-1?Q?l6L2IUdpXT7mMaT3EJ1fJwpo4FzAlklAHiyCl1mqN6vNpuT/A5FfEc7CIe?=
 =?iso-8859-1?Q?CWCWRfIiS23HH5P/hf6HuyFb9Pixa9BQZhk0x1jMZ78KJVoDGNCqS0oFV1?=
 =?iso-8859-1?Q?NhHgNo4myrxrEFIHHOPAJfhL8adodm3s0lqGqaKaNdz5ed1Ino3+91+sfd?=
 =?iso-8859-1?Q?Pe10ysbBmBW+rIB+npTKwnjE50g/1x6RHk1CYYyVXtumVoE9+MehRoIDg3?=
 =?iso-8859-1?Q?sQfnIIEyTjvH0+WN8M648aCuNS2vp/CVU7bf1DZLxLh0xtDKQF+8iCxIKs?=
 =?iso-8859-1?Q?Q4jn1T2u9hy9Le1RIGQl72ie+r6S2uiduWOwtIw01wNrqY4DLEw617inQW?=
 =?iso-8859-1?Q?QvKcncnRZGfVG0vPbV01koTaDGQ74bEsKSVuBQxjP3x27K0LL26iFMFfKF?=
 =?iso-8859-1?Q?Fuwkab/CK0upf68ym1dvI1FUegWcNbD8Mp1ojYv/4cX8m3vfovmb1RdVAn?=
 =?iso-8859-1?Q?eY99BOx9oKhUEpt3FvkHh8mhZYzqivEHD3vRuiY3Wi8Q1B1+tRO+FM51E/?=
 =?iso-8859-1?Q?/NXDNC/0BQxY7pM53trv+CnZcY94m4a2AlGY6+8PXLPj9CkKAtW/bVghmE?=
 =?iso-8859-1?Q?pAwH2aNRrNzeRfa7LioEd817tgrCfEYaVa04sS9420+iqqk6QTu+GgSy/n?=
 =?iso-8859-1?Q?zfW+YJ0XaZ3+jO7kQSmRhC/qOkL5EDk39I7fq8QE52TyfVILMoRwY0Lbyx?=
 =?iso-8859-1?Q?BdqVa3FkMBiGsPw6k1YKQerUifZnAbeDPg6viTKcQdK+yum8AwUStcQ17L?=
 =?iso-8859-1?Q?q0Urnud4KZ0O17+lBwg4ZkaRteh1qJ1iM3CCOSTfFsx47WHraJO1GHgEVw?=
 =?iso-8859-1?Q?WZcAmbigc1b8HIVWZBEm7mYx1jK9qYas/xQBuXGSFGXUPIaORwZPjx+91K?=
 =?iso-8859-1?Q?ad5yypgz8tlQ6hiEOewBNLGSvzw8GmjP0SH6Xa/C5hWru66PirlwagJ2Ae?=
 =?iso-8859-1?Q?RRtBINtm4SaGKIj6aQLwfYqK74hhBKgQNBI/DmvENIJ4pcIETz199MgIVc?=
 =?iso-8859-1?Q?cerksjR9lz5FpySbpQBOjIgla21WwNHpKdlpGpJy1p6o2+E+J7rWUoWLti?=
 =?iso-8859-1?Q?puePZb7vcptod3llulNQ+8vWh1Gb5pFY0wDv47C30xkBqMR3kUyS8+qr5M?=
 =?iso-8859-1?Q?P1SM9O6FNw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RkTl3joRCLk09G9CUoaSTFMS2ePdDgKdJroCWRYwBqMM8+SAry1HnB7ofOD3VsyLw7ISrFjzLWqq8DF28SdsphOU9gWFe1UtSr5me1ru8PN15CfzPkjQ1B8/TQGEEc1IXPzSbJ+aWyCzwKuSSrahPUqpYMK7Ak4DAeh05F6OJfkd0yYiBdWqFjTRtWmzKNMni/ZbmEaLk46toeGHYxP3F/romIBaeYa46Bsy0anp7Dd5dtTf7apwRCUwdEZcyKe/3epwEDLYDRhCjHK/5ZwaAgoXsbzUwQmVC3StZncf+Z/g/ruLl5ET9qXmG3v3Lxd/IpFAye4IGyIWqe/Tv0u5Gg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a404961-fb0e-4dc6-c43b-08deba17e929
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 04:41:39.1591 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6evtjftFIXkd2ldamAxZ4d9TxnBPLRc0YOOhxS2/D2f8ju4tI9nrXJAIQto2ChKA7dUAGSmxw19F5AgXMPbJj724d4Pick9Pa1cr8Gzsnjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR06MB8085
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=kane_chen@aspeedtech.com;
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

Replace the legacy reset callback registered via=0A=
device_class_set_legacy_reset() with the Resettable interface.=0A=
=0A=
Signed-off-by: Kane Chen <kane_chen@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_lpc.c | 7 ++++---=0A=
 1 file changed, 4 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_lpc.c b/hw/misc/aspeed_lpc.c=0A=
index 68f0f6334b..f69c48da12 100644=0A=
--- a/hw/misc/aspeed_lpc.c=0A=
+++ b/hw/misc/aspeed_lpc.c=0A=
@@ -384,9 +384,9 @@ static const MemoryRegionOps aspeed_lpc_ops =3D {=0A=
     },=0A=
 };=0A=
 =0A=
-static void aspeed_lpc_reset(DeviceState *dev)=0A=
+static void aspeed_lpc_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
-    struct AspeedLPCState *s =3D ASPEED_LPC(dev);=0A=
+    AspeedLPCState *s =3D ASPEED_LPC(obj);=0A=
 =0A=
     s->subdevice_irqs_pending =3D 0;=0A=
 =0A=
@@ -461,9 +461,10 @@ static const Property aspeed_lpc_properties[] =3D {=0A=
 static void aspeed_lpc_class_init(ObjectClass *klass, const void *data)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
 =0A=
     dc->realize =3D aspeed_lpc_realize;=0A=
-    device_class_set_legacy_reset(dc, aspeed_lpc_reset);=0A=
+    rc->phases.hold =3D aspeed_lpc_reset_hold;=0A=
     dc->desc =3D "Aspeed LPC Controller",=0A=
     dc->vmsd =3D &vmstate_aspeed_lpc;=0A=
     device_class_set_props(dc, aspeed_lpc_properties);=0A=
-- =0A=
2.43.0=0A=

