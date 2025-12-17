Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BFABD66BA1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 19:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVww7-0005ld-3U; Wed, 17 Dec 2025 14:11:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1vVww1-0005gC-I4; Wed, 17 Dec 2025 14:11:41 -0500
Received: from fhigh-a1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1vVww0-00016x-0E; Wed, 17 Dec 2025 14:11:41 -0500
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 259B91400171;
 Wed, 17 Dec 2025 14:11:39 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Wed, 17 Dec 2025 14:11:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1765998699;
 x=1766085099; bh=1yxv9VgjYUFC3WhMhsCWJn77lXJ2rnty7VmsWWQT5+U=; b=
 ek7NUxIXgGuqqW0zRELO1xDYmxlu7hwiFxVoxQE1LZBVVQwvjvJf+yKxyDN1kgXj
 Drp8fLNqhH8TbxN8N2amv7E3UhZm3Pxm7ZdmraVlY2+ULQN/AfnhYnvzrGI93ybg
 xnyh8SlpEKMaGh+Eoe9wgNMUIpYthrQLLGlll/oJTi+WojzvTMVdibTD554zkQWU
 xykfvRT6LyC94KaDahxIzzF3+G7A84B2No4eZ4y/EwiugJoVFk29ByalUiPmf4dh
 CJj1oz7GJ5TSlYrwT70hJmDK70VT0x3GrmIm/UMDJvAXidXiiw7TqMW+4F0WH2Q1
 BZO639RuvdTeWCs6MFQYzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765998699; x=
 1766085099; bh=1yxv9VgjYUFC3WhMhsCWJn77lXJ2rnty7VmsWWQT5+U=; b=T
 0T6eEJxbP34MC+v00bjXTxcNl1tA7idMRrEM+ZQgafhRzAlRuQixYsL3nf3Cuj96
 0JvjWyGqmjSsORjoVWo12n5IoMezrG58Jcp9QDu5xC2ljCnfAoZk1j+/Mo2YyE7t
 tE7TZ+Om+ugKm5B9uUJISQY6wtnkJCUGWeTi9lSwabdOfMZvsGg6kpA1TyJ5SNqf
 n7mE9MLTmXukQV/64wDyDt1qn752Vavmga6K/YNd+8/NXAnY2useWSNX9ta2caJQ
 JLVBwsZlZ9TwZ/TVzsQwAze5G9K5PhHHeEALHyjI2YjpNBPbU+qqLYKxtI+GxQJe
 dL4QJRgCxiYx/tModCHAg==
X-ME-Sender: <xms:awBDabOb7WZlF0wWhWkB_FbTj3oz9SlbfifEnjqQRGATttkzDDdGzg>
 <xme:awBDaZAeh0DBIlSpG4zHIWccGfzsehUp5DXDvn23NEiX0bNn0kVKR_kfQ2y6Q4z-0
 lf09_dr9-mEpiLpHisFNVQA7yRujPpXTR1blP3SagP6E-8-pDBkrVc>
X-ME-Received: <xmr:awBDaU4720e_3KrwVYxCk-jSYossdtq2g3NB-vDN1_P1LWu3Qg86rzclU9E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegfeefjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
 cuvffnffculdejtddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
 necuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmshcuoehprghtrhhitghksehsth
 iftgigrdighiiiqeenucggtffrrghtthgvrhhnpeehjeejhfektedtuedtgfegjeekvdej
 gfehveelhedtfffhudevjeeikeehgfeltdenucevlhhushhtvghrufhiiigvpedunecurf
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
X-ME-Proxy: <xmx:awBDab7LirjDQhEGR2YXsgZZkl5OyWU6ydz8Kem0dIzcrxJL3fnVZw>
 <xmx:awBDaeTcDXFQMwhOlsPAgLe7udv4ZkgaqkkJkFKAoVvWg72BVM-QfQ>
 <xmx:awBDab_1_bO9ubk7POi69QGcy1d8YTMin5B3dYvM4pDXZhwNSfUWsA>
 <xmx:awBDaXb-eYWaBCAmezNjwmJTfsymlU6y2Wu0fg3N1exezRJXSdaH4A>
 <xmx:awBDaXHsHHPJ2MOITabnFFgKdYTOM_C56-oQEb6oUzWMYlZxCkuDDBS->
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Dec 2025 14:11:38 -0500 (EST)
From: Patrick Williams <patrick@stwcx.xyz>
Date: Wed, 17 Dec 2025 14:11:36 -0500
Subject: [PATCH 09/11] hw/arm/aspeed: catalina: add HMC FRU EEPROM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-catalina-eeproms-v1-9-dc7b276efd57@stwcx.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2970; i=patrick@stwcx.xyz;
 h=from:subject:message-id;
 bh=3qON4J0qifGjcPDpqFfp57Z6rI2eYsG2QGpKgDuLtQE=;
 b=owEBbQKS/ZANAwAIAasDR8wtAMEZAcsmYgBpQwBgE8QnMCJblomUppvgqnpd/H4tecQ2/u21z
 ArsZp6PfqqJAjMEAAEIAB0WIQQEYP2KLgsT1w1uokGrA0fMLQDBGQUCaUMAYAAKCRCrA0fMLQDB
 GWsDEACiBuMsxFAcklCKwrUb0m2rdgBt+5Czc90F7JReGzoPWGNZmqmBuXOKzoVR8AB1Ev9yCL5
 rAAYgxFaZBHe542ndrXdZNxzxbcnxrRKtob2l1gzueSxCtr2LY0Uqvca3gIDHFhfyptYOYenv5i
 Xd1E0fxr1eAmSXc+eU7t5dO5txzC+ZGuAnEMO04kdXiOkInT/1Se5Zo4QgCv7sPsI+X0rWUMmA/
 G677XmfCeuH9G75Y/baXVJOgGt5ZVM/6j65KWuuAf9bRfWkvekucDpO4wfB2CaXwjtyoRUNDkTJ
 jxMUzBq8IciTRH6aqAj5NJy8/RNsudQhmIyrlHQFEKTg0PjiByj432gEZup4EVSEufiRdMCbjL+
 H9+D0OLHQhn7Zmh4wc/imod6nQeiBdBpytStW2f72ix2pr1OCyEM9y+WlPq81/+SjK+HsufzfYx
 /tEX3JuMUYn1R75P5afk8mxCxUUgGQN7ZWxShgTFQIrV5AY1m3t+cVfjvWLDkhN1fKqxU9onk0k
 M2VlRJZhC+MgOH+ER7VdtXLyR1HEHvkMnMFiR118nUAJdfpEA8+EwrZ/kvCt95Fm5yhQgobP8nT
 RvqZMykyLytfUr3c0IQ7/OIkZD6Wrz8nBsgK9JB7LKLgw9XUg0p5Ll64346d2Iqk6C18sQyr76M
 rzMw3eunjsG3gTQ==
X-Developer-Key: i=patrick@stwcx.xyz; a=openpgp;
 fpr=0460FD8A2E0B13D70D6EA241AB0347CC2D00C119
Received-SPF: pass client-ip=103.168.172.152; envelope-from=patrick@stwcx.xyz;
 helo=fhigh-a1-smtp.messagingengine.com
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

Use ipmitool/frugen tool to generate a HMC image based on a
sanitized set of data from a real device EEPROM.

Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
---
 hw/arm/aspeed_ast2600_catalina.c | 42 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index 37f0e1b65e..2c9b4b6fff 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -341,6 +341,46 @@ static const uint8_t gb200io_eeprom[] = {
 };
 static const size_t gb200io_eeprom_len = sizeof(gb200io_eeprom);
 
+/*
+ * HMC ("HGX Management Controller") FRU data. Generated with frugen.
+ *
+ *    {
+ *        "board": {
+ *            "mfg": "NVIDIA",
+ *            "pname": "P4764-A02 (QEMU)",
+ *            "pn": "000-00000-0000-000",
+ *            "serial": "0000000000000",
+ *            "date": "01/12/2025 00:00",
+ *            "custom": ["Version: G", "Rework: R0"]
+ *        },
+ *        "product": {
+ *            "mfg": "NVIDIA",
+ *            "pname": "HMC for GB200 NVL72",
+ *            "pn": "100-00000-0000-001",
+ *            "ver": "A1",
+ *            "serial": "1000000000001",
+ *            "atag": "QEMU"
+ *        }
+ *    }
+ */
+static const uint8_t hmc_eeprom[] = {
+    0x01, 0x00, 0x00, 0x01, 0x0b, 0x00, 0x00, 0xf3, 0x01, 0x0a, 0x19, 0x8c,
+    0x19, 0xf0, 0x85, 0xae, 0x9d, 0x92, 0x69, 0x08, 0x8c, 0x30, 0x75, 0x59,
+    0x54, 0x13, 0x42, 0x12, 0x80, 0xc4, 0x65, 0x5b, 0x27, 0x8a, 0x10, 0x04,
+    0x41, 0x10, 0x04, 0x41, 0x10, 0x04, 0x41, 0x10, 0x8e, 0x10, 0x04, 0x35,
+    0x10, 0x04, 0x41, 0x50, 0x03, 0x41, 0x10, 0xd4, 0x40, 0x10, 0x04, 0xc0,
+    0xca, 0x56, 0x65, 0x72, 0x73, 0x69, 0x6f, 0x6e, 0x3a, 0x20, 0x47, 0xca,
+    0x52, 0x65, 0x77, 0x6f, 0x72, 0x6b, 0x3a, 0x20, 0x52, 0x30, 0xc1, 0x00,
+    0x00, 0x00, 0x00, 0x81, 0x01, 0x09, 0x19, 0x85, 0xae, 0x9d, 0x92, 0x69,
+    0x08, 0xd3, 0x48, 0x4d, 0x43, 0x20, 0x66, 0x6f, 0x72, 0x20, 0x47, 0x42,
+    0x32, 0x30, 0x30, 0x20, 0x4e, 0x56, 0x4c, 0x37, 0x32, 0x8e, 0x11, 0x04,
+    0x35, 0x10, 0x04, 0x41, 0x50, 0x03, 0x41, 0x10, 0xd4, 0x40, 0x50, 0x04,
+    0x82, 0x61, 0x04, 0x8a, 0x11, 0x04, 0x41, 0x10, 0x04, 0x41, 0x10, 0x04,
+    0x41, 0x11, 0x83, 0x71, 0xd9, 0xd6, 0xc0, 0xc1, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x65
+};
+static const size_t hmc_eeprom_len = sizeof(hmc_eeprom);
+
 static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 {
     /* Reference from v6.16-rc2 aspeed-bmc-facebook-catalina.dts */
@@ -493,7 +533,7 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     /* eeprom@55 */
     at24c_eeprom_init(i2c[13], 0x55, 256);
     /* eeprom@57 */
-    at24c_eeprom_init(i2c[13], 0x57, 256);
+    at24c_eeprom_init_rom(i2c[13], 0x57, 256, hmc_eeprom, hmc_eeprom_len);
 
     /* &i2c14 */
     /* io_expander9 - pca9555@10 */

-- 
2.51.2


