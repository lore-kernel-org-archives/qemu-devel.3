Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09C4D66BA1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 19:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVww1-0005g8-Jw; Wed, 17 Dec 2025 14:11:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1vVwvy-0005dw-RZ; Wed, 17 Dec 2025 14:11:38 -0500
Received: from fhigh-a1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1vVwvx-00015k-92; Wed, 17 Dec 2025 14:11:38 -0500
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 6F0CC140009E;
 Wed, 17 Dec 2025 14:11:36 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Wed, 17 Dec 2025 14:11:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1765998696;
 x=1766085096; bh=ebQk04CyPh/8mC3YTxA9itW1+9QJBQFW7D28xrLm5Qc=; b=
 XQFVrOgcCc+HtX+V8NGxj2eX6rFVBDXxDADFkWgZ+hRiCULm0u79vWDRYZ8UX4OB
 UBczdebNWXuxxlB6ghsshG+wa1n9hitXPIa+dscVK8KIKfo/LLrAhuXL7r6ZwZno
 X0wPaBSRT/V/bh5B0jx1vLvKPeWdDb8O6dgBIEmccL2g4KMqqTXBud4O3EZfoinj
 4FJn0FPb81WgJqBX9aK1D5dOKAM52eu5oSRMxx8MoScyX6NjWjuMzSt+KPG9TWZx
 IFOiwMYLpB7KI65xVvD4xyDAJqRevH/kCOuhumc3lXx6lDutLG3w/no2nCO8Ptdb
 RjS+UAb21LvmgPM+jXQzow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765998696; x=
 1766085096; bh=ebQk04CyPh/8mC3YTxA9itW1+9QJBQFW7D28xrLm5Qc=; b=T
 CkwO4ZMjILrNH1wq6RUvQMp5zaAgQG/9v5paCEjQqVrjidQiz6rLdvXuoMYmIXT1
 nJZbNyWN/xbK5IC5ZnXkz6DBQo2wlC2ihqVNCwIYhr4gq6WRkjjbV8f+ys7jhZHd
 HIK+AjWjJAZpA1x9i42HKLwLg0VDfHXpsLfbE0mA+CaXAR2i3o3TwXT1eQwb20Qx
 v7pzReawldGxBuSAUvGdUP9bRg5y4r0Qkxup56BZtHBz9bQFZroiKXbavNyH5jZa
 2CBrZO8qpEbtMRVm1NpmCemELOYgwUMVssFp7V536pBkLQ9yTwn+kP2tFoY4pU40
 Sg9yxVjpv+jJDeN92A8KA==
X-ME-Sender: <xms:aABDacCsQhYqEbYdOPHDEWKHVpMs0-p62Boswpiouj6mGNriYWXCKg>
 <xme:aABDaRkPDVPbnljMekpvkmiL_ASREJkq2X2rHaY7BzNkCc2ONVmmeB_lFA7dz30lH
 Ycd1vBs5zyAMBXX-RNzykotMqBvOU2fLZ06wTTGLMHq1WWbjbjQd0I>
X-ME-Received: <xmr:aABDaaO7SQ0qXW695dfLSIU2mhSQZicJUg7ZJ10hhnrzUos9qGsOA3QeU5E>
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
X-ME-Proxy: <xmx:aABDae_NPxR-oBWJxW6TdRBvAwEzd9_iigOWpdUYvo2zVaUEY7Tw-Q>
 <xmx:aABDacHRQ6CaK6yDNf9eYvhdQ7CmmImX60EKhO-oxn3g3LdjvWQXkQ>
 <xmx:aABDadjFsamGe4_v6FoJB51QToZTpf5Vd7Nw1W0br1pTZ9ZxkGqKkQ>
 <xmx:aABDaRsPDDUrTdmOgB827XhqAujQaO9tBx5PYWaYhOiYidBzG6jYnQ>
 <xmx:aABDaSbigWl5j5HBTDGMiAt1ayZfYJGPuz1KkvJ4aQcE3q7w4ziLL0FI>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Dec 2025 14:11:35 -0500 (EST)
From: Patrick Williams <patrick@stwcx.xyz>
Date: Wed, 17 Dec 2025 14:11:33 -0500
Subject: [PATCH 06/11] hw/arm/aspeed: catalina: add HDD FRU EEPROM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-catalina-eeproms-v1-6-dc7b276efd57@stwcx.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2964; i=patrick@stwcx.xyz;
 h=from:subject:message-id;
 bh=VGv2cXOMR+fpR4qDjJxOyivbclt3BXVWQFnOwLWmPl4=;
 b=owEBbQKS/ZANAwAIAasDR8wtAMEZAcsmYgBpQwBgHkBC/J86k60OWDDDph2yfS16063jDeQ3T
 1weqIgRrj2JAjMEAAEIAB0WIQQEYP2KLgsT1w1uokGrA0fMLQDBGQUCaUMAYAAKCRCrA0fMLQDB
 GYQKD/9ncLM4sCIOjfmixDZBFAQnOgViQxOTLxHz/qXQ+e+HH1ZllJyUw1PWcTYK201OAI0hDcl
 TWl+AFLnHuvYfGJedmW3FUYC5S8DHg+vYn2/Jclbcp421QXo3VYiBWLPNFXT4rN9OPr8pMKU/7y
 bj7YmpbdTFXjRQK5zgyN7d81oG3fV7/UBucJjRfX+0QLnVCJyS4/vtrCJWXRinyWVlVxrt0h6Dz
 NHJ8LhjD+Si/ZfG/7bnfL+WB8zvM6JD7ung/dENorDiwFq5E/ccRv7Vm0X7yxY3f7J4CTUVjptQ
 8JYp8cXOfYk6LbAtxItlEWDPLzr74WweE6ptN4pHFFK3qSBrIv1g3BHjT26jnwuD2PEjKmS1l+0
 TtkcN1WuNuqYCX4Je8FRkuHWcXtKBWh+P2qHWkhaGsUMf0Avh+eTzREEog204xR3yvsNekAXGyK
 /1WCECz/GX5CHXMxveCURyD7oD5epDMqpGiM0Z6T20eiNHLW5p8IgL+hEsMg4LXxOozFpVP7d8M
 TZGFVCHgcxR74LTd4Sbt6MtFIB9BYFfhbD59z9UTv0AgHxbPvCrN0SK7ITia8b1dLxVOENiWcYj
 diLgSPYWO9dFt+Kpl1t8CRZVg/4jWiyW00hk6xKkkYGb5gC2AHj7+1LiGeGl9RHF/8B88lskrDZ
 xpPmNWpFBy84GAw==
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

Use ipmitool/frugen tool to generate a HDD image based on a
sanitized set of data from a real device EEPROM.

Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
---
 hw/arm/aspeed_ast2600_catalina.c | 41 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index 17db9035bd..4cfde870af 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -227,6 +227,44 @@ static const uint8_t fio_eeprom[] = {
 };
 static const size_t fio_eeprom_len = sizeof(fio_eeprom);
 
+/*
+ * HDD Carrier Board FRU data. Generated with frugen.
+ *
+ *    {
+ *        "board": {
+ *            "mfg": "Quanta",
+ *            "pname": "Catalina HDD MP (QEMU)",
+ *            "pn": "00000000000",
+ *            "serial": "00000000000000",
+ *            "date": "01/12/2025 00:00",
+ *            "custom": ["19-100319", "", "", "adc-ina"]
+ *        },
+ *        "product": {
+ *            "mfg": "Quanta",
+ *            "pname": "CI-Catalina",
+ *            "pn": "10000000001",
+ *            "ver": "MP",
+ *            "serial": "10000000000000",
+ *            "atag": "QEMU"
+ *        }
+ *    }
+ */
+static const uint8_t hdd_eeprom[] = {
+    0x01, 0x00, 0x00, 0x01, 0x0b, 0x00, 0x00, 0xf3, 0x01, 0x0a, 0x19, 0x8c,
+    0x19, 0xf0, 0xc6, 0x51, 0x75, 0x61, 0x6e, 0x74, 0x61, 0xd6, 0x43, 0x61,
+    0x74, 0x61, 0x6c, 0x69, 0x6e, 0x61, 0x20, 0x48, 0x44, 0x44, 0x20, 0x4d,
+    0x50, 0x20, 0x28, 0x51, 0x45, 0x4d, 0x55, 0x29, 0x8b, 0x10, 0x04, 0x41,
+    0x10, 0x04, 0x41, 0x10, 0x04, 0x41, 0x10, 0x04, 0x89, 0x10, 0x04, 0x41,
+    0x10, 0x04, 0x41, 0x10, 0x04, 0x01, 0xc0, 0x87, 0x51, 0xd6, 0x44, 0x10,
+    0x34, 0x45, 0x19, 0xc0, 0xc0, 0xc7, 0x61, 0x64, 0x63, 0x2d, 0x69, 0x6e,
+    0x61, 0xc1, 0x00, 0xff, 0x01, 0x07, 0x19, 0xc6, 0x51, 0x75, 0x61, 0x6e,
+    0x74, 0x61, 0xcb, 0x43, 0x49, 0x2d, 0x43, 0x61, 0x74, 0x61, 0x6c, 0x69,
+    0x6e, 0x61, 0x89, 0x11, 0x04, 0x41, 0x10, 0x04, 0x41, 0x10, 0x14, 0x01,
+    0x82, 0x2d, 0x0c, 0x8b, 0x11, 0x04, 0x41, 0x10, 0x04, 0x41, 0x10, 0x04,
+    0x41, 0x10, 0x04, 0x83, 0x71, 0xd9, 0xd6, 0xc0, 0xc1, 0x00, 0x00, 0x37
+};
+static const size_t hdd_eeprom_len = sizeof(hdd_eeprom);
+
 static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 {
     /* Reference from v6.16-rc2 aspeed-bmc-facebook-catalina.dts */
@@ -330,7 +368,8 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_mux = i2c_slave_create_simple(i2c[5], TYPE_PCA9548, 0x70);
     /* i2c5mux0ch6 */
     /* eeprom@52 */
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 6), 0x52, 8 * KiB);
+    at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 6), 0x52, 8 * KiB,
+                          hdd_eeprom, hdd_eeprom_len);
     /* i2c5mux0ch7 */
     /* ina230@40 - no model */
     /* ina230@41 - no model */

-- 
2.51.2


