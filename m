Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD02F8E4A7
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDZt1-0002D3-7j; Thu, 16 Apr 2026 23:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZsz-0002Au-3N; Thu, 16 Apr 2026 23:28:53 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZsx-0005oG-MW; Thu, 16 Apr 2026 23:28:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1jv2vGo7sT3GRGLuvTgUKU4nIc5jyclwx0t3ibUmuXUhi9yNKi4fb6SQafI2qcf6u9W1iZQrX9O+VBWOg+MqzTzf1U5+0gLLqae2X0HdD7bcYD0mHHe+vKBSiRCDpF23KMvRAiszX7J5rcF0MYyqkBUZKBbIGh8mfq0vStZys4PxE6Q7yReMW5P8Ew55eKwy7rBq4OmO1XYVLa0L6uWI85vIlTeC0sMr/avpyY1jf6/6jLFx7m1u/VUAJIBcR4mqRYWHhhi93vFEJ7k1tDA1dJPgAqhAK+uUFhxKk6YkUqvwAJT8Xv6YLUkFWu7cDP5cgdwS4MyYI8GUnOmlvoVKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2vQMfUWJPYifFqSbL8Y9hJ/S0RWq6niSBoiAN3wMTc=;
 b=T2w06H22AYl0mBcX1qR2ll5YtWdGsF16gMF/DHM3p8K2OxOP8aXuO+v1VlG2TYyJW3BeUTdZ2bdhbHpUwO3mNhf4XjzWyJ64h9/NPkVlAnCc36cNgMWoAU5Es6+NlKYg+QaKgBMWag3WSLD3lgKZFyWceo+MgqHM9DQkEkpD7x+4TgpbfmNuLt4G1JgdDipUEHPQqP3nZsEXAx+D46TSb+OialfPQdWMVIvZVz+3I14D0bIggxPhfAaPYW8l+9MaO1zGOAwB3ozZL/4KRjDZU+aSkY6j4yAmUUv9iaJ3HkhLYBgYpnnGR39Ty8FH+DNg3Thnl939kb1IWWU9YN2UhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2vQMfUWJPYifFqSbL8Y9hJ/S0RWq6niSBoiAN3wMTc=;
 b=ipDdSYunjtnqtfoo4asmlir/VqgpAYoJVe23i/7tzBPVINXr7JG5JaQlxC8OOQd5u08s1RciR+c1W8CNSWQRXzGXg3I3eIuWf/YJ3J+lTrakPpb7Rb87f30yVLTsQTaBzsm9afpyUgcpBtU/B97P/f4Ts0W1YgGm8+prrMIzl5H7AnZ8Ac+WXfcQ3vnUMy9jg+FMzBRJFnA+Y7KOgHwy9f37WMOBLt12p9umb0hhaP9SNAgG/baoMGc0TN67y/w+vYfIFbxZO6kkdn7U6L8ol+86WYczCfcAVZZZ6pxrhpIsyy4ewKHi4s3oF2K4axdclcrUj0Bdmc8aLHwdpmFumw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6299.apcprd06.prod.outlook.com (2603:1096:820:ce::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 03:28:41 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 03:28:41 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@linaro.org>, Alistair Francis
 <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:Block layer
 core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 02/21] hw/misc/aspeed_scu: Add separate reset handler for
 AST2700 SCUIO
Thread-Topic: [PATCH v4 02/21] hw/misc/aspeed_scu: Add separate reset handler
 for AST2700 SCUIO
Thread-Index: AQHczhpJp+kxoYfObkuBqMDdF3UsQw==
Date: Fri, 17 Apr 2026 03:28:41 +0000
Message-ID: <20260417032837.2664122-3-jamin_lin@aspeedtech.com>
References: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6299:EE_
x-ms-office365-filtering-correlation-id: 0bdf7dc6-ee22-48e4-cb97-08de9c316c02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|921020|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 3dpILANM/6F92HulfOasDUi0hamqAaozrBGaZC/D8e3aZ/K211ky+1C4N9Jp58P73I2VkXOWRBy7qMQRPn6K+daVZvfcCo3FiG6JDPeWEtuvu1z/XWIGLzgG1IeD/h+yw8PwXrX2ae/u1s0252ByllhuxGJJbRUIp1duKEHBgI9hrsXeoBgvdL0Iylij0sRiohuY2sOOfQ/peUid0/y6oF+vuAbhtpF8/yWmwizuED8ndmr26TWjWZEgtD7ABRL9yZuG6Ip1JmifBwsJduDfPqOqdg1xazQBg18H8X39qT+eY/c2sYK6MIgZITnLgmhN4OGfhuEC/6+4e/YsaMWs6RpadGpSjz3gsmHHwX/V+GsGhcLYq5LQXB/etiS12lsUhbGvCMWwIpUWGDegq/eoAKiVx/lEXo6FNGNVSVe/98cdlrn1O5OHJJibyBkjAPjEWpeGXFZy1grCfhk3laYUcXbjRrDX1ZZtk85vbKkLon/fkylMFg+gJsA6GCahvXhj+vQhZpmLJ+LqvYpY9r25CxqGY5Hq+MjVDullao1mEvinSWvfuqT71LCo5jA2KrKwkvJa95uLlg4CvixpTzPD5siGjebyVNo8jArl/kyhGI5ZkDD5dUDWXvuupXwI1rMmi5VxR6lEhyyUqq6yWs8tfhp7bnKHf9Jic5ryv0e23OObxeMozcfprE3zWODW7hy+ZwSZ0dkbMBkz3FHIApyCMonuBZ8mqIhhg64K8chzc0a78c2XRdayYiXF7ZmmcxMYZRp9fMIA8D7fN8D6NSiII62qZw60oQ66CtlHPj3aN1nzU9DEQdJX0NGLKjbgxNQW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KP9y3O3RKfYkCqwGXkJo2vHQ7vqd6cx4EafQvzPx1Jh2yF00ZNzwjh9Zxl?=
 =?iso-8859-1?Q?BTqYG2KoiUx+Z84lz0QlgF1RYHUMv0KqRqjX3SmgUrTXWJyASUDI62XpOT?=
 =?iso-8859-1?Q?9r7jJuR0SHf8SGwIWsCBB2SRnzaqNGGQ9bQVEAjUeO4BKLINuSBgb4KDEs?=
 =?iso-8859-1?Q?NDckQnomhzxfL8W+MEBO+LKFuLXRLTO4x2ksEtAqPu6E75ahCvYW2Oq7XD?=
 =?iso-8859-1?Q?e+SpLEKH+WU910QrlnQcYToGSXWi7KodjH6fYVRejCL1AdbpzLpPR4gYGI?=
 =?iso-8859-1?Q?d6nAzkWKwNZTFL1Oz/R3JzkSbxCCDHMb4MA9WSbwdFz3SqfpRhHyswImrd?=
 =?iso-8859-1?Q?7DIbNtDALUMMDTGAEjKrPxiEYV0V88qqXp0xXjgIsopFc6P0URxXCDzhMH?=
 =?iso-8859-1?Q?QWNud4fv9uNzp7TT2VpB/s4H0ug66IvA3CMQJw0tykZ7KfCvjZiJzgmkAZ?=
 =?iso-8859-1?Q?a3yojQfUzk03B2gtd8RueYevASB2ZrNRVP5MGS1uyVW1cbNY6DxAQdKD4E?=
 =?iso-8859-1?Q?9IFICXOO9bZxbyL5BRrYWUQLehqYiXKSoLWLFT+b3bIWGND6kfCRvfbe5H?=
 =?iso-8859-1?Q?YL6YiGRnpW8waifgZKMlxykJBH6W91a6Ja0pltCg5mX74T/HTYJPTl3xBg?=
 =?iso-8859-1?Q?EQCcbSThnyLIQRoa4rAlQkoxnFRPt0ezTBFeFy3HHV9RAqqhGw6kIEuRf9?=
 =?iso-8859-1?Q?2vPnA5CA2/ndV751TNKshmvUxf0ath+eeZntUQDulAB3EsZuYhHZxGhiH6?=
 =?iso-8859-1?Q?Qr5G44LzN/AYN8OPUHNfEpOlvt5YdLSwmj1p4NHSAY1hZvzhWG1kyfNjvi?=
 =?iso-8859-1?Q?3TF5gcCHVSuVDSKTS/sqGDZv7Jnl/Kl1KoqYJ8aUnOY2Qfi1oUFkmwHOej?=
 =?iso-8859-1?Q?5urdtQx5Iu843iEClcsmTpOt2+SN4QJLbLpkTkF61mFdUQtkWf0MR5ltuP?=
 =?iso-8859-1?Q?FiCBGB17dyKY0TO9CYmzdP5YJcqCcRMqFz2r/1DoK7niNIgfUfiL49x+UC?=
 =?iso-8859-1?Q?mMgCPm+1GyKULLJOu6z11YeuAeOrxN+Wkrig5VXBfR0raBpGU/UOVJMJ83?=
 =?iso-8859-1?Q?M/AXBf22HfIpeBdJ6ylOpU/1Gf7qPEaiNsQLDzV6BOjfV+3ycYwbWV5hw5?=
 =?iso-8859-1?Q?9+68y71QGHqvbVRZL6Vq9RThZC30LLuzmX3x7mRW5pu4LYgCdEoouSQ5zg?=
 =?iso-8859-1?Q?0qVZDATSF5m0W0VlOoh3asD4CZ+2PvcqQAHgHPJv8W/bKlicBxYYuZwZrD?=
 =?iso-8859-1?Q?RhA4q4N8qKw9iyJt6clDECr1ohsQzhfHeoINwrNnklcQ2+cRCAV1RmWEWY?=
 =?iso-8859-1?Q?QUiaMS3x2Z0nH8+Yp+EkYUvRmTkzfHt81KKkyxbtU3lKbffaqkFCM5qyqI?=
 =?iso-8859-1?Q?h8AaeLHb9Q8hUkcgH3erRxMNEYOAd6KI49Ncwbi7z2HX/Vacetl9GXiM0L?=
 =?iso-8859-1?Q?AM0ryZUA5eCEkH5vW/pidpqSwdlP+SHHfr9CysH+InLqsqqz2QcmzpjZ07?=
 =?iso-8859-1?Q?buaVD4GRA0/TWD/s9hGCmeKEDrhxKW6kzHQOUO1EZtO5cVQfxRlufCTzZp?=
 =?iso-8859-1?Q?Ydgkl+9qPCT24MyB72vNVVEJZKVakKzJKwgljK/095ZCz8voot7qXuGLPr?=
 =?iso-8859-1?Q?oGPbCP2WatiD5T69fFBKtvwreqCip9m82WNg9zLAm9O6DD34POq5b0V2q1?=
 =?iso-8859-1?Q?hfG0paJuPCQK/PPqc1/KExB4lprNdlzYkPdJQzDOP8ZCoNKi+XkrzBu/nI?=
 =?iso-8859-1?Q?rKp3AA8FkPK+fZlGac6QHjd2jeCKQsRTd3LE6kP31zqVAsuKLnXJhHpye6?=
 =?iso-8859-1?Q?GGS1CJdveg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LSA+C+t8GPTXWQ2QKSjMopYRL/mX9DrR4PCr6y2h1yRmKPiixy+s1KW0v+g4r5a1STAsCcsDQsuUQVW3xc+2WqjWaYnTAXhsU5sG6poVJ73+WlrD3+2pJeSWj4LaVbPx+VdDvR1Myg9WGTGxW9N3Rzr6O/6aHeeRKBXdaM+++y5sDu+ZrDuP2i3bHs2mG83VYMuuItqp4fX+JyUfzKRVLBOtvzuAf/381HSScDfT+TJG9o0bhq1F2fS041TXEo+uZnGKYINkb9tiqv8ufc3zVL7gxKEsOWYCZdk+hGVdkZnuoix0gLsdSuv2kvxGHuRnlpf5mmjaceGkNLMPO84Hjg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bdf7dc6-ee22-48e4-cb97-08de9c316c02
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 03:28:41.2100 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cWIdJfM2F3H6rHZ//T1ckWXX1r8ylP8escHxYWPwL/cGY/fmUWjWczYS/1hByOeU0vXycFM2/O+8g6EfsVlnVKLRH+xI11g5EkayP4S9FgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6299
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

Introduce a dedicated reset handler for SCUIO.=0A=
=0A=
Previously, SCU and SCUIO shared the same reset handler. This no longer=0A=
fits the AST2700 design, where SCU uses the Aspeed2700SCUState subclass=0A=
and will handle coprocessor-related control in future changes.=0A=
=0A=
Since these controls are defined in SCU (not SCUIO), SCU and SCUIO=0A=
should not share the same reset logic.=0A=
=0A=
This change gives SCUIO its own reset handler and prepares for upcoming=0A=
SCU-specific functionality.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_scu.c | 12 +++++++++++-=0A=
 1 file changed, 11 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index 0a2dad4537..51696443bd 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -1084,13 +1084,23 @@ static const uint32_t ast2700_a0_resets_io[ASPEED_A=
ST2700_SCU_NR_REGS] =3D {=0A=
     [AST2700_SCUIO_FREQ_CNT_CTL]        =3D 0x00000080,=0A=
 };=0A=
 =0A=
+static void aspeed_ast2700_scuio_reset(DeviceState *dev)=0A=
+{=0A=
+    AspeedSCUState *s =3D ASPEED_SCU(dev);=0A=
+    AspeedSCUClass *asc =3D ASPEED_SCU_GET_CLASS(dev);=0A=
+=0A=
+    memcpy(s->regs, asc->resets, asc->nr_regs * 4);=0A=
+    s->regs[AST2700_SILICON_REV] =3D s->silicon_rev;=0A=
+    s->regs[AST2700_HW_STRAP1] =3D s->hw_strap1;=0A=
+}=0A=
+=0A=
 static void aspeed_2700_scuio_class_init(ObjectClass *klass, const void *d=
ata)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
     AspeedSCUClass *asc =3D ASPEED_SCU_CLASS(klass);=0A=
 =0A=
     dc->desc =3D "ASPEED 2700 System Control Unit I/O";=0A=
-    device_class_set_legacy_reset(dc, aspeed_ast2700_scu_reset);=0A=
+    device_class_set_legacy_reset(dc, aspeed_ast2700_scuio_reset);=0A=
     asc->resets =3D ast2700_a0_resets_io;=0A=
     asc->calc_hpll =3D aspeed_2600_scu_calc_hpll;=0A=
     asc->get_apb =3D aspeed_2700_scuio_get_apb_freq;=0A=
-- =0A=
2.43.0=0A=

