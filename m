Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47967D66B9A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 19:12:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVww4-0005iL-M0; Wed, 17 Dec 2025 14:11:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1vVww1-0005fq-2H; Wed, 17 Dec 2025 14:11:41 -0500
Received: from fout-a8-smtp.messagingengine.com ([103.168.172.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1vVwvz-00016a-5S; Wed, 17 Dec 2025 14:11:40 -0500
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 4289FEC016D;
 Wed, 17 Dec 2025 14:11:38 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Wed, 17 Dec 2025 14:11:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1765998698;
 x=1766085098; bh=e3tdTU5FgZzFrFyCe8/22sGzfbLFpKr2Ary/1eiPI3g=; b=
 hlXDYetzk/FXTDHwV8/7dpSZUkp7S7Ixzh6YaVh922XlIre16Z52B3ccADUsGOeC
 wgxoOeSrcrQYFsifku1rnvzdMlqrlAoQMHgcVKAPgKQROJ59saXGRnfxLDSiajnT
 ByCVZQJ5C4HnU1+NeQmJL7QW33Yu71AeLebGyi1zvNFNtLPz0rVc9qFfiQuXZorz
 rGI1GEIqz7+W5vRurul7aaBcFlf5xReZvrplSgrWLRTWYtNBrhEfpiZb3d3kLqMp
 REYRkZ4b7URgr239MQD6ujnEzHIVqEkwZ5XBGwH77/fEHvUoVDjPlmUecSOvpZQ9
 4qPehObggeJJAdVsH3hj3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765998698; x=
 1766085098; bh=e3tdTU5FgZzFrFyCe8/22sGzfbLFpKr2Ary/1eiPI3g=; b=L
 2TwPYtb2E1ytbo8H3Akr6N+luFipztkgVN/4QVDrVNTwNu714mUBcDRP994yeuYZ
 ujRV1tDJtv/VJ++xIfP/8dY3Yw5tE1cvhTAS8qjS2WA0SNSRWbT8N9esf+DTzinW
 +PTPWCpkZK/Yc85pMsxslUrbFvpPnDFMSxLSyXgYfcboyqbL2aXiipLytkxDUzFO
 ExWP3KEsxlPSwZK03HPA71kYXDTJLusQHW8lEUS55JlKU4pVv3aY2/kWvAXyXcsg
 KpKsCcjDVtZkKAiZ5++YQeD/ed7+U+IB8PvVf1fqWY58e8cAZFNqpF7uieKvF3tY
 gSnQHA4QsBcXHOUm88sKw==
X-ME-Sender: <xms:agBDaUYqj82IBmje1XzjCaVuiiz3QOLi55ESLQwbSZWaJgnkWSWC3g>
 <xme:agBDaSfl7AJo0me5ywHWrcuyqzL3_xNxaWvmBlhL_La0dhl14dSSOkS4N9FHX0vHT
 w61trDNRdfP5S780YoF7qUBFxT6C9L6zWVsB0hLrN6IKc5mbw-nhPY>
X-ME-Received: <xmr:agBDaZlz0IJkOnK6ZFLyVWhL6isiWs16bC5E0UDEwWg46NE45uBZ0pKZ_40>
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
X-ME-Proxy: <xmx:agBDaa0lqxLwOT8nN9dseJrvq-lE0OGp-IvbKZOBOXUWaIHQfTlLKg>
 <xmx:agBDaafh9Atec16eq8F445Eh6WlSibekExG1dxOlMr7g8ClQX9Btxw>
 <xmx:agBDacYuZrTjwGbLPM1o3uhMBUMlOvTXFMWuHJDoHD-SnFgaoP8c7w>
 <xmx:agBDaXGQivlFxTB8C4KaYkHH8sPZ18o50_d3PnT34ttRkX8ISJad1A>
 <xmx:agBDaVybdAjfkN_vbQVmk8vceFXcaEbkrOao8ForUzHUerZxBnIbTlA0>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Dec 2025 14:11:37 -0500 (EST)
From: Patrick Williams <patrick@stwcx.xyz>
Date: Wed, 17 Dec 2025 14:11:35 -0500
Subject: [PATCH 08/11] hw/arm/aspeed: catalina: add GB200-IO FRU EEPROM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-catalina-eeproms-v1-8-dc7b276efd57@stwcx.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3520; i=patrick@stwcx.xyz;
 h=from:subject:message-id;
 bh=YEYbZFVnyrAhmT/IuKuOMQN6c9X+TkUpscRK8pFOgIQ=;
 b=owEBbQKS/ZANAwAIAasDR8wtAMEZAcsmYgBpQwBgbY1yG2MQ4rM3BakqeQFFpB1CYAPVLmZW8
 8LTONm9moyJAjMEAAEIAB0WIQQEYP2KLgsT1w1uokGrA0fMLQDBGQUCaUMAYAAKCRCrA0fMLQDB
 GYXtD/9BztB5h8j++KXt3mg5quP0TgmrndTnvrgZ3wEDxa5+RCmPYucVmS2vcmapPnnptqFKEY9
 cNl63VdO4q4m5/T17+bnz7ip/l8avBk/ldSjQ58Tu4txpQm+pcrWOSr7/cRbAaADzJLzzzbtJV8
 trRX5maZIVoTQcOm9lVt4nnsgh88eX42XZPtKvj+yrymGawlKfGLemJlSD46fT8MtqNIyxEKibr
 zFiUCtW3NOcffcyHXdVPN4zXEr7CjHjzH5OWhxhBSi0cRBVr7MEoi3UdmzA7JisPvl3zE9INhUl
 UFk+3ZUl/DGQ28EUr5ujVs2Xqnk2MqtA13DOOyuBHVGQhQhV3hyRcfjtchvcgFc4Pbf8d0KF4+W
 Awo8Trd7FwxWUfQ0Tk/8Z0Fb6r/57ohS1peOLfJiEg2UmHWuoFEKG6afioiX8ozdTG98wSY1EDA
 HhwrEEZhpV6UIkUmBSws4/XTwDd8HhE1Rkm1IA6qnqpWS1clAbRQ7zvDhy1bJPS4Z0tCnGMH/2n
 VhT8V4ty2rXoMf2ud0xdXNlUDPFNH7Xm0c+RKMZznfNCH+cLCYmRDfblRihBaogsXEheYQgwYot
 u2c7SvQxqAPk4CICSSdWpdTzK12Jb9EqE7L5Cp/6+DUaNl1lGHmBfvHjWJ//Yd/l9TtLTiCOgG1
 ZOnj2Nep/ExhrqA==
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

Use ipmitool/frugen tool to generate a GB200-IO image based on a
sanitized set of data from a real device EEPROM.

Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
---
 hw/arm/aspeed_ast2600_catalina.c | 43 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index 4dd72c615d..37f0e1b65e 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -304,6 +304,43 @@ static const uint8_t gb200_eeprom[] = {
 };
 static const size_t gb200_eeprom_len = sizeof(gb200_eeprom);
 
+/*
+ * GB200 IO Board FRU data. Generated with frugen.
+ *
+ *    {
+ *        "board": {
+ *            "mfg": "Nvidia",
+ *            "pname": "2x ConnectX-7 Mezz (QEMU)",
+ *            "pn": "000-00000-0000-000",
+ *            "serial": "000000000000",
+ *            "date": "01/12/2025 00:00"
+ *        },
+ *        "product": {
+ *            "mfg": "Nvidia",
+ *            "pname": "2x ConnectX-7 Mezz",
+ *            "pn": "100-00000-0000-001",
+ *            "ver": "A1",
+ *            "serial": "100000000001",
+ *            "atag": "QEMU"
+ *        }
+ *    }
+ */
+static const uint8_t gb200io_eeprom[] = {
+    0x01, 0x00, 0x00, 0x01, 0x0a, 0x00, 0x00, 0xf4, 0x01, 0x09, 0x19, 0x8c,
+    0x19, 0xf0, 0xc6, 0x4e, 0x76, 0x69, 0x64, 0x69, 0x61, 0xd9, 0x32, 0x78,
+    0x20, 0x43, 0x6f, 0x6e, 0x6e, 0x65, 0x63, 0x74, 0x58, 0x2d, 0x37, 0x20,
+    0x4d, 0x65, 0x7a, 0x7a, 0x20, 0x28, 0x51, 0x45, 0x4d, 0x55, 0x29, 0x89,
+    0x10, 0x04, 0x41, 0x10, 0x04, 0x41, 0x10, 0x04, 0x41, 0x8e, 0x10, 0x04,
+    0x35, 0x10, 0x04, 0x41, 0x50, 0x03, 0x41, 0x10, 0xd4, 0x40, 0x10, 0x04,
+    0xc0, 0xc1, 0x00, 0x00, 0x00, 0x00, 0x00, 0x8e, 0x01, 0x08, 0x19, 0xc6,
+    0x4e, 0x76, 0x69, 0x64, 0x69, 0x61, 0xd2, 0x32, 0x78, 0x20, 0x43, 0x6f,
+    0x6e, 0x6e, 0x65, 0x63, 0x74, 0x58, 0x2d, 0x37, 0x20, 0x4d, 0x65, 0x7a,
+    0x7a, 0x8e, 0x11, 0x04, 0x35, 0x10, 0x04, 0x41, 0x50, 0x03, 0x41, 0x10,
+    0xd4, 0x40, 0x50, 0x04, 0x82, 0x61, 0x04, 0x89, 0x11, 0x04, 0x41, 0x10,
+    0x04, 0x41, 0x10, 0x04, 0x45, 0x83, 0x71, 0xd9, 0xd6, 0xc0, 0xc1, 0x04
+};
+static const size_t gb200io_eeprom_len = sizeof(gb200io_eeprom);
+
 static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 {
     /* Reference from v6.16-rc2 aspeed-bmc-facebook-catalina.dts */
@@ -329,7 +366,8 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1),
                             TYPE_PCA9552, 0x20);
     /* eeprom@50 */
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 8 * KiB);
+    at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 8 * KiB,
+                          gb200io_eeprom, gb200io_eeprom_len);
 
     /* i2c-mux@73 (PCA9546) on i2c0 */
     i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x73);
@@ -345,7 +383,8 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1),
                             TYPE_PCA9552, 0x21);
     /* eeprom@50 */
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 8 * KiB);
+    at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 8 * KiB,
+                          gb200io_eeprom, gb200io_eeprom_len);
 
     /* i2c-mux@77 (PCA9546) on i2c0 */
     i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x77);

-- 
2.51.2


