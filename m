Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD9EC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 03:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjqNu-0003Ka-PM; Tue, 14 Jul 2026 23:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjqNn-0003Fk-QH; Tue, 14 Jul 2026 23:34:04 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjqNm-0000nz-BC; Tue, 14 Jul 2026 23:34:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=klhSwy16eSd+jpdkoSYrULaBXdyE2ELx997HWWOBVUtcY9vYviD3hp7dn+JCtYu3L+UAMvZiBG8YctnYGklOMnyHSvMB5mPLcpWQEInSFGOL9zDRXOIRFBfZcCHTGAi1nqqgsbssWXF1Gqtj/pJ9Y54lWhIDbKizdJNE9qaZFD/jrUv4/ZdaFn3kfdr4tjBrjsacJYH2jpCWvrnhVguHeHGYVG49YkKt+xqquVQp4smJ7teFNRbzHgN0IuhSuMeF/CxULX4Kb0YTawXJarUrABQfYPYzHJz3QKz2FbDvgJSirnXY93m5ID1EjR4zs+DAmnB9sG+aYxbrUcj3n0TtJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIXG+q97TKpaf+I53c9KZynotwUlQwkuvjUOZl7dJHE=;
 b=CSFzbjN4fLYU7CRvm/o4O8bcsj1ifGgD06xD//239Bn5ppN+pWl1dFQZH6JIZK+FqZUMn6xZUitMK3ysDv2VYGtWvew0t7r5C+ciQh6QL3EeBLdq9QxdLIw8DqSUZYKt8bPJ5k17Jebc+jI19+ZZdgYU/9/4a/QTm84g7cEQ21RWBKP+yw/O4aoiKIIjb82XI7rvt3+8UvWJNIBG66WbpZWXa9X3h2mPqVcPRPXUbUNPLM7Xi9RM3uDcPHf5uZE+CCbmWwDYl2DqWoziU3EZfQyCcseAmmacVTpIqpQtpMmeZMv/fCEpOrDu835sJSlnTlzF18Eok+w50mHZY5JpCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIXG+q97TKpaf+I53c9KZynotwUlQwkuvjUOZl7dJHE=;
 b=HuLE3mFE9mTyOhgFFn9pUm9/5xQr9fCaZZTrPwAlVi8UF3LGklwklu/HVMI3W9zBxAsr4HDtvbzaPzgBhQDHXZoWujpNluk/zcPJiY8YPjsgSiPyh+LcRP0wlXt8v9FzP3ual8Aw3et19OIlKtFk6qO6xp9tEb1t3l0qNmmL9cnNqmHvfjBGCzZNDW/M+2uoVw5ykKoOcs4D7mMFya0ZL7GmG2f+ZMhLjBcS1s+08DPvCLUZVZMZgr/b9604wjUFiqeMiPKeUDcK12USzCkIwvv0zKKKtH1j4V8kmKp00EzItYb+OKOh6PJe+ObydP+LIvy6CwBbtnaBvgdEU+I39g==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TY0PR06MB5258.apcprd06.prod.outlook.com (2603:1096:400:205::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 03:33:35 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 03:33:34 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 13/17] hw/misc/aspeed_hace: Support 64-bit DMA for the
 crypto command
Thread-Topic: [PATCH v2 13/17] hw/misc/aspeed_hace: Support 64-bit DMA for the
 crypto command
Thread-Index: AQHdFAq34MtAXIkgpkeI+h62J8mDig==
Date: Wed, 15 Jul 2026 03:33:34 +0000
Message-ID: <20260715033311.1648424-14-jamin_lin@aspeedtech.com>
References: <20260715033311.1648424-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260715033311.1648424-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TY0PR06MB5258:EE_
x-ms-office365-filtering-correlation-id: eb6fb229-a7fc-48a6-a446-08dee221d9c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|56012099006|22082099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info: Zxb9XLiZ0JIkq08ngEsPmFgG8BDEn7yihq1Ti0MDGsndHwM0OdHRnx29EtKWf/l2Lvzlf3v2vOC0tcCoz2JCPPvbcrGhvZQR3fKBglHTu/DAkVa9NkHZQaG6Rrt1R2EloZWWwX1/Jg2AWTY6ydpIBK9d+9or0Xkhsd4EclBBAFQ+fXyExxRxmdSE2xYlGzjnld6KIjSVyFuvixvtdCGb1Wx7Qr6wP1yIEenfkRZweFdtyT4tNSlzrqWk5AGyxiO5I0ZCN4L7jXuSVKtxjfswqx8OZml6aXdR6eh2CgT/6vn+P7p/gxC7zxX6CTSWYwk0ykz6UNQATAGai+MnlLkLuwiVjGjU4Wf8AD+KZi0L09yb+Ln71WtDVODlIo/whhs+MmhcdKW6DLY2ecUjvvM1oga8ZUSTDfZA+RNEke4QUqbOojrKAE4U8Z9IY8xDlChoGpF1BC7CgvoCUIHywLJ3j6WfcemVoFfInnv8HQAUeHx6h0ZjYlrzF7IhWyE/gesASFZlhMComkYsG3hlAN/px/r4p409wU/dID3ePuyKDGtRP9GuzD4eZaDiBH2Zf2CUYxCohUQeqc3PmdtZbILwXlttB5UHxjlWBPUKNxJ5ZOl6B0DG1CAP5dy2Eh9DFG4YFePtXZsU/mI/NYvLWPzh7+TSjAS3AcsUALnFrIUsPBx0YkD9xgc5cJkJ5OaoI6BW5kGx47jxccyXFSLe3IV4LtPPTY3al3lVGfefBgJUG3I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(56012099006)(22082099003)(18002099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?v0KlCvXK9o+cf08I/AM1TX9VQ1QAZgZuudguH2MOu+gQknUPX2C/BACTxP?=
 =?iso-8859-1?Q?IxLtsKvkgrBGD2dOgLwKJIfiwIGHsFtrKoR6tPdqcpilnTD7Oa0HDoVkS9?=
 =?iso-8859-1?Q?3f2m+3e1otim6XXxoClSjeKlAvyNRMviqor2jHCNphAWvsmOLiJhNQXlJU?=
 =?iso-8859-1?Q?ll3btKYF7fwJUkHmU5T8PI/z2zoDVzWXShJO34XU0CcYRM8Ea5MUSyTAeb?=
 =?iso-8859-1?Q?kCCccCGnMOWS3LSwIeHxQlct5647K8MaLMGkDT/b9yU/P3Tn79QNWcqvoz?=
 =?iso-8859-1?Q?L/p1jS0LB7zJTEjUa7ylqYQMw7juXqEaMV6lqwyUE35GhLEMXE0QrZxOKL?=
 =?iso-8859-1?Q?zdxWEfhXuFmzSGwZQdWUrsaRkdoKEm6pP71r3D91J+nR70oDgZ3PPwDRz8?=
 =?iso-8859-1?Q?YoGVKniwC4NrpH4pEqlAqErkq+9iZ6oVzPzO9V8N4xKkknMGk8j6SLa5Ta?=
 =?iso-8859-1?Q?82Y/howN75LlTL8PxzmQUN55SOu2TbXpFnQO9UH+N/BrL8jAKIfrqUlok4?=
 =?iso-8859-1?Q?LRBwyKntMxcuZ9g9euAxREmugsykp4tyGZAPXpn5WXsNQt9TP6+k5rorrT?=
 =?iso-8859-1?Q?i+QWxxT1drKyDdkETU5YXxPdo6FE0qc7vl2OEyiwo25HJ971n7bkMyzQpB?=
 =?iso-8859-1?Q?KGdkufhsh0YRs1MvVzbcLnsU0o+HM46N9xkOVe8NHY/t5V769J3ObaLZqg?=
 =?iso-8859-1?Q?0bzKiLb9f8JpHCd2WTz6ng6o2r8SeSISYFy+GIOLeHcCRnD3JFy5mr7XTU?=
 =?iso-8859-1?Q?P16nt555dnWxqD5T9r6xrqMkJ8BlDfmv50ihYNJF+bDVsrFh8Gt6aqGhpT?=
 =?iso-8859-1?Q?YQ+bta+fLwHh22jT4qaUQs8tNhY6sZdnaf+YM64SIR/TnWD1dyMARWhfFM?=
 =?iso-8859-1?Q?t7IRZA6i/kAgwk/I20LRTUNnVgGPVr0f3a01Zaks8/hJGCidm/40F7TXVz?=
 =?iso-8859-1?Q?6Ct2AJKx/zdxa6tE8DY5gaGNyo5VuGVha02mSX489ry/j3TPH77FGYC978?=
 =?iso-8859-1?Q?qlRz6escBS7cFfyVR1Hkk07B8FfBCa2EV+gG3dALCqIq6w3+mDoWhn05tc?=
 =?iso-8859-1?Q?g1SG+RMS0rpF8mRF7G0FzPxELse8/C0tQ6MfGaei8hEWJCoWX5daAOipVs?=
 =?iso-8859-1?Q?mnQMrII1dgXDCuibE7CEofpBVmKtt3cHuZTkmnPleIL4W5PpWcy8RJ+tds?=
 =?iso-8859-1?Q?/oZCL3LL7x0yEr3izAtUuVaOXUE1/vZtqwm95GWQG1tarxpEYLLPYnqRhp?=
 =?iso-8859-1?Q?eglLm9Aaa2G3/UtJ31DKrLnMIfDgueaxLVKPPDROiizY72RlwJYdJTvuke?=
 =?iso-8859-1?Q?mvWGR8nyTFO/IngmViv3RDJOT+vs5+Io0tb+dCHePW+byE/U8pQeF76pRQ?=
 =?iso-8859-1?Q?r1+PG4eTKqrno/7uIgiXB1HoNb8A9tS82P1e3GRMI6EFkRK87LMWdCKNRn?=
 =?iso-8859-1?Q?Ia2zQxlSzx6R4dGyjq6j0WF3Xy+5LgoHNKavtjF5gYH8OAbklpHJkfT7bC?=
 =?iso-8859-1?Q?5qnDkP51QnsBDHAySIjNbQuVI8Er8cwZ/R6Pdjvee4ekpBf8m/4L8RH4Kp?=
 =?iso-8859-1?Q?4CY27E8NAlYa+BgDEWPH2uXO3JrSEDM82QQHyalbMN1cF4Hd8lIPxLg6jt?=
 =?iso-8859-1?Q?wMCX7NXZtyx8VD8tH4wEhgwwaAeaX4xtrxicecL6BZxRlfP/7XP7Scxkt1?=
 =?iso-8859-1?Q?7SnkJmSa8+Yz7qK4q5qkEbCFECwv326YRa/1KNc6A5jbsHd5r/FAGBXQBR?=
 =?iso-8859-1?Q?hJAA9M2JX+WzbIj8DQp7+1em6WdopU4em1fsh+ZMNSy8bY+dKBuK5d6K57?=
 =?iso-8859-1?Q?eTU1hir89w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Jb7xaFU4EPCn1WrNF5+o23Fkvni7YHxTP9ODiBbFUgPXYW/MmEirTziifj12ueCdP2UIrCxRWz6vAO4l9MPEVUIAx1tsnpzsiZQ5rhTV44+edJ8rmsWa20r55/v2uSpRb843hXsK5X00xYi2aoKPbiQZnWtnQ83GngUO8sApYgtuayyo1ywK04lQ3cMDwve1NcdDBN3q190ntuJVoPWkZsljayaS6PuKeHSDqE/cHfEW6Ph4E1Qbz+MmZwXNa5M8FHD6KjFUzJHn/kzL7YNG/TxrGMlzpr7ckixGgyTnAGS8BgOR89ymjEn7jJBFarz3veX8hIdt8FBGTRkZHq9pdQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6fb229-a7fc-48a6-a446-08dee221d9c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 03:33:34.4171 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5MVEi+bpgQO6g9BOjsXWQfGLpBFS07PhZ+cZAbmckJjY2Ruy+GYavNcvBC+hPan5yDgKRsTT646zdWKRT0a/l4f/ZV+pKm3Tswtdo3I2iLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5258
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

The AST2700 crypto engine addresses DRAM with 64 bits, supplying the high=
=0A=
half of the source, destination and context addresses through HACE80,=0A=
HACE84 and HACE88. Add those registers and a crypt_get_addr() helper that=
=0A=
combines the low and high halves when the SoC has 64-bit DMA, mirroring=0A=
the hash engine. SoCs without 64-bit DMA (AST2500/AST2600/AST1030) ignore=
=0A=
the high registers, so their behaviour is unchanged.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_hace.c | 33 ++++++++++++++++++++++++++++++---=0A=
 1 file changed, 30 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c=0A=
index 09d0515271..a807cc1422 100644=0A=
--- a/hw/misc/aspeed_hace.c=0A=
+++ b/hw/misc/aspeed_hace.c=0A=
@@ -58,6 +58,11 @@=0A=
 #define CRYPT_CTX_KEY_OFFSET        0x10=0A=
 #define CRYPT_CTX_SIZE              0x30=0A=
 =0A=
+/* AST2700 64-bit DMA high address registers for the crypto command */=0A=
+#define R_CRYPT_SRC_HI      (0x80 / 4)=0A=
+#define R_CRYPT_DEST_HI     (0x84 / 4)=0A=
+#define R_CRYPT_CONTEXT_HI  (0x88 / 4)=0A=
+=0A=
 #define R_STATUS        (0x1c / 4)=0A=
 #define HASH_IRQ        BIT(9)=0A=
 #define CRYPT_IRQ       BIT(12)=0A=
@@ -672,6 +677,19 @@ static void crypt_be_add(uint8_t *ctr, size_t len, uin=
t64_t add)=0A=
     }=0A=
 }=0A=
 =0A=
+static uint64_t crypt_get_addr(AspeedHACEState *s, int reg, int reg_hi)=0A=
+{=0A=
+    AspeedHACEClass *ahc =3D ASPEED_HACE_GET_CLASS(s);=0A=
+    uint64_t addr;=0A=
+=0A=
+    addr =3D deposit64(0, 0, 32, s->regs[reg]);=0A=
+    if (ahc->has_dma64) {=0A=
+        addr =3D deposit64(addr, 32, 32, s->regs[reg_hi]);=0A=
+    }=0A=
+=0A=
+    return addr;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Perform an AES/DES/3DES ECB/CBC operation. The source and destination a=
re=0A=
  * either single contiguous buffers (direct access mode) or scatter-gather=
=0A=
@@ -719,7 +737,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint=
32_t cmd)=0A=
     }=0A=
 =0A=
     /* Fetch the IV and key from the context buffer in DRAM. */=0A=
-    ctx_addr =3D s->regs[R_CRYPT_CONTEXT];=0A=
+    ctx_addr =3D crypt_get_addr(s, R_CRYPT_CONTEXT, R_CRYPT_CONTEXT_HI);=
=0A=
     if (address_space_read(&s->dram_as, ctx_addr, MEMTXATTRS_UNSPECIFIED,=
=0A=
                            ctx, sizeof(ctx))) {=0A=
         qemu_log_mask(LOG_GUEST_ERROR,=0A=
@@ -760,7 +778,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint=
32_t cmd)=0A=
     dst_buf =3D g_malloc0(buf_len);=0A=
 =0A=
     /* Gather the source into the bounce buffer, per the selected mode. */=
=0A=
-    src_addr =3D s->regs[R_CRYPT_SRC];=0A=
+    src_addr =3D crypt_get_addr(s, R_CRYPT_SRC, R_CRYPT_SRC_HI);=0A=
     if (sg_mode) {=0A=
         status =3D crypt_prepare_sg(s, src_addr, src_buf, len, false);=0A=
     } else {=0A=
@@ -796,7 +814,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint=
32_t cmd)=0A=
     }=0A=
 =0A=
     /* Scatter the result back out, per the selected mode. */=0A=
-    dst_addr =3D s->regs[R_CRYPT_DEST];=0A=
+    dst_addr =3D crypt_get_addr(s, R_CRYPT_DEST, R_CRYPT_DEST_HI);=0A=
     if (sg_mode) {=0A=
         status =3D crypt_prepare_sg(s, dst_addr, dst_buf, len, true);=0A=
     } else {=0A=
@@ -960,6 +978,15 @@ static void aspeed_hace_write(void *opaque, hwaddr add=
r, uint64_t data,=0A=
     case R_HASH_KEY_BUFF_HI:=0A=
         data &=3D ahc->key_hi_mask;=0A=
         break;=0A=
+    case R_CRYPT_SRC_HI:=0A=
+        data &=3D ahc->src_hi_mask;=0A=
+        break;=0A=
+    case R_CRYPT_DEST_HI:=0A=
+        data &=3D ahc->dest_hi_mask;=0A=
+        break;=0A=
+    case R_CRYPT_CONTEXT_HI:=0A=
+        data &=3D ahc->key_hi_mask;=0A=
+        break;=0A=
     default:=0A=
         break;=0A=
     }=0A=
-- =0A=
2.43.0=0A=

