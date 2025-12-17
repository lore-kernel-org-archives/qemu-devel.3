Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5EED66B9D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 19:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVww4-0005hi-1h; Wed, 17 Dec 2025 14:11:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1vVwvw-0005cA-Qu; Wed, 17 Dec 2025 14:11:36 -0500
Received: from fout-a8-smtp.messagingengine.com ([103.168.172.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1vVwvu-00014r-Mc; Wed, 17 Dec 2025 14:11:36 -0500
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id D5924EC011C;
 Wed, 17 Dec 2025 14:11:33 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Wed, 17 Dec 2025 14:11:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1765998693;
 x=1766085093; bh=IYNyEYtFuolxuLICrRO3YgG3x5tAFKgZGLn8f+nn+AM=; b=
 GXwC3eHMtN+RqXYLPZjTju/Mut97Z8eA0GeOlQm8IltLQPa2e9NeWDatd5cux1mB
 LCatP9deUr2XuZOAXmtq0W+V05sSd25ud1kGzN123mbcetVfnnjecz+LQVlef56c
 xNjsukJLu8LTqrY+SSLptdae9tCgDWIkYV7HhkfAbLTcgMDSIlEsTauo3FzKkiHo
 bKaKUU9hgQ9neD2eCNqEjNcKQRY6JlAPUKfnKXTiJxeMIBSw8c+BvZwkim6WawU+
 XL6xSzb7octU3HQrnb+qp53ZoNnnYzi1+adcsE6gF9A+InZYNTUU+FhMacmd3/RH
 KR/2BBC7zi567FFFYNfJkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765998693; x=
 1766085093; bh=IYNyEYtFuolxuLICrRO3YgG3x5tAFKgZGLn8f+nn+AM=; b=J
 JuripEMixPr9lkiO2sLtpPMZqkXI6rHMD1KHM6O1j/imo6xR9+KetGVROKLjgbQm
 qDDoIu260ZuvMdiK2JIMbclcyOTA9DZVreb+pLoXUjBEI/lC+LlKN5KZNnDeV+aO
 LyFAs89qjtjClGO43C/eH1WzbQKA0KGJb5MWE6eyw0sdUOx+8A4CJJreLVjZL1gK
 M4hAIEr5yLJpZyJQoH0l8ORVy3CAHoNQ/hDl+c5j8WgBX8LqfyYftZGmYhR7EfgM
 ae3mWXJ/XsKtdqRt/yNjFwQdvAf8Q8cInIxkJps6F0JtQRIt7/ui+BmxsQQk4REp
 5yJUq5xAPb5/leCr407JQ==
X-ME-Sender: <xms:ZQBDaTeMTEYKaICxWOi4d_YXWO7o4d8d2a9-09O3xSvaAptT2QOgNw>
 <xme:ZQBDacQeutkMC5yrzHuSxucf34HLfetozRyOxu25gA9qmy_uUPhMDJLQ-BD2nET0d
 LVSFMNWoWUqA_ZSRactl1pFgCtU-k0YJJAP6vT3PqtAkynozD_nFBQ>
X-ME-Received: <xmr:ZQBDaXIJsZyJIMRtwGfgRenq4jlHSCFK11TgejECir7K17lvFBz_lJHMUR4>
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
X-ME-Proxy: <xmx:ZQBDaRLp9y9dDmwrsVA5kONEw8snnt-gEtUOPTt5gWijszXkWeRAvw>
 <xmx:ZQBDaajRTDSYvRX3IUQxUaDU8zhMX36IYKCrOBlzctGE-oI0RnID4A>
 <xmx:ZQBDaTNFZAIJ4-SANllJbt-nXhpmBlp1JKenKxt0KN7lB2TOMEwehA>
 <xmx:ZQBDadoKXKkU-KsYgsxGH60zGlM59nt77SwyzY4Vkl-4ven3DqUEJw>
 <xmx:ZQBDaRX2esLNYzIC9ljJxLTNeYy6qPAtI54hCCNmSaTtNzd45Kn64-p5>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Dec 2025 14:11:33 -0500 (EST)
From: Patrick Williams <patrick@stwcx.xyz>
Date: Wed, 17 Dec 2025 14:11:30 -0500
Subject: [PATCH 03/11] hw/arm/aspeed: catalina: add PDB FRU EEPROM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-catalina-eeproms-v1-3-dc7b276efd57@stwcx.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3439; i=patrick@stwcx.xyz;
 h=from:subject:message-id;
 bh=743vlcsdT8g1t/2Q0+AWKYAMdQDwHhTqybRKjZPrPVI=;
 b=owEBbQKS/ZANAwAIAasDR8wtAMEZAcsmYgBpQwBgbh2DvhB1ArR7mzF27ViTfiAV4CawtMjeK
 hHPjBEzMNaJAjMEAAEIAB0WIQQEYP2KLgsT1w1uokGrA0fMLQDBGQUCaUMAYAAKCRCrA0fMLQDB
 GY1gD/0b7HRp/1SjkoZmxbs8IblvgBWgZISK/QTXWYf3D+f91bfL/h70LNrK9PhwLXxKukzTNJx
 ASyJKFT4FSE1WWsbGs9DqqRpX7ScXF6wqQmRg8EH9aaSNAsP42Y5lhMJvaDQ2e1eqCtxCTYXhcu
 48R2oYqfBcW9HEj+eAwePgJtR7ZtOU2WOREjclOE8x32nRCzmxvZvg0gZwuqa+ON6APlHjvbsN8
 TVM/zU0yln6aqrEkY6cm0HocLlWEmDitTCxxu4BHpQ13mBKkHPSapcQMBlxo5EGSb3VqtnFxUAA
 F6dvF9iwsvGOZC1cgCkbyAdxTnm0LlyPmrvzjkrdpxHP0G3xBwv9echLk7ztas3O7/sQaHZwq71
 acWF29aKf7ZVa71cKDi6B5y1FKHHJpI3KXOCb+bymqxIwmQ8L2DrnXa8yS4GHaEQnaZqiyl46sX
 MmpdNeeQW8XEfI06mYIFs7FpkVBfA5jAvfXWftsDQ1MX5fzLK5uRg2B0f9T1ONmUUG3jIREKYwr
 hvmLKvjG1urhV/p7gWGqldbHYEQBHmZPy4bxvKUZbOzm1h8Y88w49TXI2SnTfCqWexZpM1mOhvn
 zvjLJQ1MS2Uc4r9ptn+tKovaW9+vna9PLtCi5MYJZKfxGZ/sfvmqnEtf7T7jRpHk9TQ22iCnksO
 ZUF+70MFsA4AQbw==
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

Use ipmitool/frugen tool to generate a PDB image based on a
sanitized set of data from a real device EEPROM.

Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
---
 hw/arm/aspeed_ast2600_catalina.c | 51 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index 6e8f4d39d9..2ba2c5c088 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -103,6 +103,54 @@ static const uint8_t scm_eeprom[] = {
 };
 static const size_t scm_eeprom_len = sizeof(scm_eeprom);
 
+/*
+ * "Power Distribution Board" FRU data. Generated with frugen.
+ *
+ *    {
+ *        "board": {
+ *            "mfg": "Quanta",
+ *            "pname": "Catalina PDB MP (QEMU)",
+ *            "pn": "00000000000",
+ *            "serial": "00000000000000",
+ *            "date": "01/12/2025 00:00",
+ *            "custom": [
+ *                "19-100579",
+ *                "",
+ *                "",
+ *                "hsc-ltc fsc-max vr-delta gndsen-ina p12vsen-ina p12vfan-mps"
+ *            ]
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
+static const uint8_t pdb_eeprom[] = {
+    0x01, 0x00, 0x00, 0x01, 0x12, 0x00, 0x00, 0xec, 0x01, 0x11, 0x19, 0x8c,
+    0x19, 0xf0, 0xc6, 0x51, 0x75, 0x61, 0x6e, 0x74, 0x61, 0xd6, 0x43, 0x61,
+    0x74, 0x61, 0x6c, 0x69, 0x6e, 0x61, 0x20, 0x50, 0x44, 0x42, 0x20, 0x4d,
+    0x50, 0x20, 0x28, 0x51, 0x45, 0x4d, 0x55, 0x29, 0x8b, 0x10, 0x04, 0x41,
+    0x10, 0x04, 0x41, 0x10, 0x04, 0x41, 0x10, 0x04, 0x89, 0x10, 0x04, 0x41,
+    0x10, 0x04, 0x41, 0x10, 0x04, 0x01, 0xc0, 0x87, 0x51, 0xd6, 0x44, 0x10,
+    0x54, 0x5d, 0x19, 0xc0, 0xc0, 0xfb, 0x68, 0x73, 0x63, 0x2d, 0x6c, 0x74,
+    0x63, 0x20, 0x66, 0x73, 0x63, 0x2d, 0x6d, 0x61, 0x78, 0x20, 0x76, 0x72,
+    0x2d, 0x64, 0x65, 0x6c, 0x74, 0x61, 0x20, 0x67, 0x6e, 0x64, 0x73, 0x65,
+    0x6e, 0x2d, 0x69, 0x6e, 0x61, 0x20, 0x70, 0x31, 0x32, 0x76, 0x73, 0x65,
+    0x6e, 0x2d, 0x69, 0x6e, 0x61, 0x20, 0x70, 0x31, 0x32, 0x76, 0x66, 0x61,
+    0x6e, 0x2d, 0x6d, 0x70, 0x73, 0xc1, 0x00, 0x00, 0x00, 0x00, 0x00, 0x24,
+    0x01, 0x07, 0x19, 0xc6, 0x51, 0x75, 0x61, 0x6e, 0x74, 0x61, 0xcb, 0x43,
+    0x49, 0x2d, 0x43, 0x61, 0x74, 0x61, 0x6c, 0x69, 0x6e, 0x61, 0x89, 0x11,
+    0x04, 0x41, 0x10, 0x04, 0x41, 0x10, 0x14, 0x01, 0x82, 0x2d, 0x0c, 0x8b,
+    0x11, 0x04, 0x41, 0x10, 0x04, 0x41, 0x10, 0x04, 0x41, 0x10, 0x04, 0x83,
+    0x71, 0xd9, 0xd6, 0xc0, 0xc1, 0x00, 0x00, 0x37
+};
+static const size_t pdb_eeprom_len = sizeof(pdb_eeprom);
+
 static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 {
     /* Reference from v6.16-rc2 aspeed-bmc-facebook-catalina.dts */
@@ -166,7 +214,8 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* i2c1mux0ch5 */
     /* eeprom@54 */
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 5), 0x54, 8 * KiB);
+    at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 5), 0x54, 8 * KiB,
+                          pdb_eeprom, pdb_eeprom_len);
     /* tpm75@4f */
     i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5), TYPE_TMP75, 0x4f);
 

-- 
2.51.2


