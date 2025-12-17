Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5523ED66BA1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 19:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVww5-0005jX-I9; Wed, 17 Dec 2025 14:11:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1vVww3-0005hJ-Ff; Wed, 17 Dec 2025 14:11:43 -0500
Received: from fout-a8-smtp.messagingengine.com ([103.168.172.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1vVww1-00017S-Np; Wed, 17 Dec 2025 14:11:43 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id D00E3EC0148;
 Wed, 17 Dec 2025 14:11:40 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 17 Dec 2025 14:11:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1765998700;
 x=1766085100; bh=gKj1H52jdX4JqTyoIYt0DUYRT70Xq/RB6Gg3pGSwHsI=; b=
 iDtLO1uubR9dXuLDOYdwwwGNiqR+4CUhKSKp9WbVNeTxSAGhrDaEfjS/wkIGF836
 eP2xtlaSZ7ECO6oxxQoVfAMjfYWF4wpiqB3VQ9r9uboa5ioS90EaHPXDVOChRbD6
 l80HeymAGJF59nm1cz0sR9EidbAMxn2r8BsLRWJ0QWzgn1V4Tbmj/0rt3/vklcV1
 UlumeOxSgZCrNYGZqTuzYHHRkTKJmxNDQTbOQ/SDTTnbs0chFFe/dr+ULhgBidO0
 mocTneBobRGReVmTe5lQl6CFIGHEjk0AyFk66oUuSE+2P4b50K8QyicQutA8XTUz
 mP6ilV4wVhcq+VQZ3fuhGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765998700; x=
 1766085100; bh=gKj1H52jdX4JqTyoIYt0DUYRT70Xq/RB6Gg3pGSwHsI=; b=S
 UtVEfT327TigzX6VNsKPfY5ZUU6MLx4mFPDxry7JQp+hZmndVgiCKVqG316BOS8G
 I3Mycw7YDhq0E1GhDLsShkS5nvv1Fl40zh2/UbeigP6P24M5HRkcSHxbYPyTTY6i
 uKsavvCTUYSb8ZQwtGMRQezJxn6edpGEE+O6GXQtVKmEGZBDLDnhxo4Pm3Dw+wsI
 /CccLv3b+D+wZd6Aa14PllH3S40mpHNBYC5m62Bw6lLZhbAIMileDzD0ZSMe1FGi
 PY1VAcJtHXuAFtg9BAXl5tHQAhAGIWk2SXQ+tonaStk4UIIM60Qw3g+ErdSdkkAf
 Sn4bmFARHAlpExkwH1e2g==
X-ME-Sender: <xms:bABDaX6XeRShzcvBrvRRicMzxGBjvb8uvnlq_zIOvFR-2tGvB5CkHw>
 <xme:bABDaf-1fRKN4eJAjWElUDKYDZ0iobgc9zG9QAEi0Hpwzl1k6vWVOwcnIEih9jfok
 cxbAiTIQcW3xNgdkmX-PZ-E2f6vRg3t84a74d9n_VDSjPxupFhQIR_d>
X-ME-Received: <xmr:bABDaZFvOxbTtdCZVlcY_-29nbIu_G_mUbf6NDz7fzJUYzfGu4eQF0U0pf8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegfeefjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
 cuvffnffculdejtddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
 necuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmshcuoehprghtrhhitghksehsth
 iftgigrdighiiiqeenucggtffrrghtthgvrhhnpeehjeejhfektedtuedtgfegjeekvdej
 gfehveelhedtfffhudevjeeikeehgfeltdenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehprghtrhhitghksehsthiftgigrdighiiipdhnsggp
 rhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgrthhrih
 gtkhesshhtfigtgidrgiihiidprhgtphhtthhopehpvghtvghrrdhmrgihuggvlhhlsehl
 ihhnrghrohdrohhrghdprhgtphhtthhopehsthgvvhgvnhgplhgvvgesrghsphgvvgguth
 gvtghhrdgtohhmpdhrtghpthhtohepqhgvmhhuqdgrrhhmsehnohhnghhnuhdrohhrghdp
 rhgtphhtthhopehjrghmihhnpghlihhnsegrshhpvggvughtvggthhdrtghomhdprhgtph
 htthhopegrnhgurhgvfiestghouggvtghonhhsthhruhgtthdrtghomhdrrghupdhrtghp
 thhtoheplhgvvghtrhhohiesghhmrghilhdrtghomhdprhgtphhtthhopehqvghmuhdqug
 gvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepjhhovghlsehjmhhsrdhiugdr
 rghu
X-ME-Proxy: <xmx:bABDaUU-OU5DDFy29X_ir2x3kOJi1PawuX0HsI52t-RIhFX8uqJS-g>
 <xmx:bABDaV_qrY0YNCsG7JJsiKUF4CEnovFe5K1A_vHX8CE13NSdc6d-lw>
 <xmx:bABDaR41pMfXU1JmSyeYe-G4gOSbicjS944LoC0DgY3iT0C4ybAqMw>
 <xmx:bABDaelTxg3QdIhInxvHdVIHzALJaUik1Gmyo4nB_s7_k3Vjxzzm_Q>
 <xmx:bABDaVQYHHvS914_YhDUk2ATfBaSWWPQjThTDMGZN4TuS97D4QBnCU5P>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Dec 2025 14:11:40 -0500 (EST)
From: Patrick Williams <patrick@stwcx.xyz>
Date: Wed, 17 Dec 2025 14:11:38 -0500
Subject: [PATCH 11/11] hw/arm/aspeed: catalina: add Cable Cartridge FRU EEPROM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-catalina-eeproms-v1-11-dc7b276efd57@stwcx.xyz>
References: <20251217-catalina-eeproms-v1-0-dc7b276efd57@stwcx.xyz>
In-Reply-To: <20251217-catalina-eeproms-v1-0-dc7b276efd57@stwcx.xyz>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Patrick Williams <patrick@stwcx.xyz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3469; i=patrick@stwcx.xyz;
 h=from:subject:message-id;
 bh=UAIHiNVWOoGfAlUZ/SDuOB3pVwIMyRegj1WLMWCJoQw=;
 b=owEBbQKS/ZANAwAIAasDR8wtAMEZAcsmYgBpQwBg57zDXncJHIO4HkF2wmtnKsBJtVOX4NHtK
 z8MzuoZmCKJAjMEAAEIAB0WIQQEYP2KLgsT1w1uokGrA0fMLQDBGQUCaUMAYAAKCRCrA0fMLQDB
 GcI0D/96Ld8yBdDY7kmFwS9WZv0UNNCpcOsvXqqUq3PalNCtrE+ZGYNX1bLmw2O28EtGrncCwYo
 F7mtGLhO3MqS1Yy0ssbRRLl7TCVKpZCBRpI4XrtHRQ17GGtz2zf8pTQzEHavzmpvtY5aowmpRQ6
 fg09QNxw8owA3GsGpj0Mfvs7Znwvb1elzbzNXaHx++msJuPISethlSEVzSKIECG+jBDCWBVv+sy
 HpLFLlyTYvOc1TBgZ5BBTlF9qwmCo0venrIuwSyCB/tsL16CJ2ghJqNq4Dga61E72xMF38S7Z50
 Gow84VzIRJkq+DGvLRJ/rjer0E6WShLHj5M1p9ptUvDzdvzm23tL1wkdGO1FId9ok6voaZ+pQoX
 WN7a3mak/F4fAFsS760ecF+gp6DmhWiIxFJmycPfLEE7QdtfMPQNxFZu6xvyyUKadllz9Gte2nY
 T4h+aGTGAAhVxuhH6T6X9YU/QmfVS1rOJe1Wu0GMdKZb9NCFdgmHDTcTlsiTYNupihX+MTAqXfM
 uvEIVLI6NSmO83EqhU7+r72xmuKn/2VtQmG/8597TZzZBMWn0ropGDzXZuwurL65G8h172yAII0
 vSHQcRRywZERGWFIjF4g/S1L29VTP2RlwqBc00Yt/TF2KYPYaDpzuapsUfwizDZD4I6LM/9CJw+
 oRDCxvyxNTbnP+Q==
X-Developer-Key: i=patrick@stwcx.xyz; a=openpgp;
 fpr=0460FD8A2E0B13D70D6EA241AB0347CC2D00C119
Received-SPF: pass client-ip=103.168.172.151; envelope-from=patrick@stwcx.xyz;
 helo=fout-a8-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.498, PDS_OTHER_BAD_TLD=1.997, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Use ipmitool/frugen tool to generate a Cable Cart image based on a
sanitized set of data from a real device EEPROM.  The EEPROM
bus/address did not match device tree for one of the EEPROMs so move
it from bus 13 / 55 to bus 12 / 54.

Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
---
 hw/arm/aspeed_ast2600_catalina.c | 46 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index 5044441f38..4edb30bb16 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -419,6 +419,44 @@ static const uint8_t nic_eeprom[] = {
 };
 static const size_t nic_eeprom_len = sizeof(nic_eeprom);
 
+/*
+ * Cable Cartridge FRU data. Generated with frugen.
+ *
+ *    {
+ *        "board": {
+ *            "mfg": "Nvidia",
+ *            "pname": "18x1RU CBL Cartridge (QEMU)",
+ *            "pn": "000-0000-000",
+ *            "serial": "0000000000000",
+ *            "date": "01/12/2025 00:00"
+ *        },
+ *        "product": {
+ *            "mfg": "Nvidia",
+ *            "pname": "18x1RU CBL Cartridge",
+ *            "pn": "100-00000-0000-001",
+ *            "ver": "E.4",
+ *            "serial": "1000000000001",
+ *            "atag": "QEMU"
+ *        }
+ *    }
+ */
+static const uint8_t cable_eeprom[] = {
+    0x01, 0x00, 0x00, 0x01, 0x0a, 0x00, 0x00, 0xf4, 0x01, 0x09, 0x19, 0x8c,
+    0x19, 0xf0, 0xc6, 0x4e, 0x76, 0x69, 0x64, 0x69, 0x61, 0xdb, 0x31, 0x38,
+    0x78, 0x31, 0x52, 0x55, 0x20, 0x43, 0x42, 0x4c, 0x20, 0x43, 0x61, 0x72,
+    0x74, 0x72, 0x69, 0x64, 0x67, 0x65, 0x20, 0x28, 0x51, 0x45, 0x4d, 0x55,
+    0x29, 0x8a, 0x10, 0x04, 0x41, 0x10, 0x04, 0x41, 0x10, 0x04, 0x41, 0x10,
+    0x89, 0x10, 0x04, 0x35, 0x10, 0x04, 0x41, 0x0d, 0x04, 0x41, 0xc0, 0xc1,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xb1, 0x01, 0x09, 0x19, 0xc6,
+    0x4e, 0x76, 0x69, 0x64, 0x69, 0x61, 0xd4, 0x31, 0x38, 0x78, 0x31, 0x52,
+    0x55, 0x20, 0x43, 0x42, 0x4c, 0x20, 0x43, 0x61, 0x72, 0x74, 0x72, 0x69,
+    0x64, 0x67, 0x65, 0x8e, 0x11, 0x04, 0x35, 0x10, 0x04, 0x41, 0x50, 0x03,
+    0x41, 0x10, 0xd4, 0x40, 0x50, 0x04, 0x83, 0xa5, 0x43, 0x01, 0x8a, 0x11,
+    0x04, 0x41, 0x10, 0x04, 0x41, 0x10, 0x04, 0x41, 0x11, 0x83, 0x71, 0xd9,
+    0xd6, 0xc0, 0xc1, 0x00, 0x00, 0x00, 0x00, 0x25
+};
+static const size_t cable_eeprom_len = sizeof(cable_eeprom);
+
 static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 {
     /* Reference from v6.16-rc2 aspeed-bmc-facebook-catalina.dts */
@@ -561,15 +599,17 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     /* eeprom@50 */
     at24c_eeprom_init_rom(i2c[12], 0x50, 8 * KiB,
                           gb200_eeprom, gb200_eeprom_len);
+    /* eeprom@54 */
+    at24c_eeprom_init_rom(i2c[12], 0x54, 256,
+                          cable_eeprom, cable_eeprom_len);
 
     /* &i2c13 */
     /* eeprom@50 */
     at24c_eeprom_init_rom(i2c[13], 0x50, 8 * KiB,
                           gb200_eeprom, gb200_eeprom_len);
     /* eeprom@54 */
-    at24c_eeprom_init(i2c[13], 0x54, 256);
-    /* eeprom@55 */
-    at24c_eeprom_init(i2c[13], 0x55, 256);
+    at24c_eeprom_init_rom(i2c[13], 0x54, 256,
+                          cable_eeprom, cable_eeprom_len);
     /* eeprom@57 */
     at24c_eeprom_init_rom(i2c[13], 0x57, 256, hmc_eeprom, hmc_eeprom_len);
 

-- 
2.51.2


