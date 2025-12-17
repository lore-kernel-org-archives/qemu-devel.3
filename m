Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADA1D66BA1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 19:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVwvz-0005eX-Pe; Wed, 17 Dec 2025 14:11:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1vVwvx-0005cr-LD; Wed, 17 Dec 2025 14:11:37 -0500
Received: from fhigh-a1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1vVwvv-000156-UQ; Wed, 17 Dec 2025 14:11:37 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id A41E5140001E;
 Wed, 17 Dec 2025 14:11:34 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Wed, 17 Dec 2025 14:11:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1765998694;
 x=1766085094; bh=LuoadUt5hmbMt01Gp3muN+fmuqo83j4AFDH5AKgwSG0=; b=
 gHK87Fq81H+UCjigmFrp52sdwesZ2uvF/1aWgWllHGS6kmPrO1Wjz/Ii6NHjb5CQ
 JUwN3qSyRsiOndIZlJBAHOOQ80bw5jqypPx/xUoVMkP58dqZolWcuUuhf5ZrSUML
 ry1yRp/tOUMJ2iDX3vjZVY4/OqhV3BLCaLv9ko1bPOrZdQ624RYVv7kIAMydHxyk
 NAqUcBVLas/IjR8wIrHL+F6x5pE2n8WFzWtxUEdfWCpDP4ywilH+SiGP2Le8A89E
 ShDsDMgFN9C3qQDfoe/Wg++C+5QJQ3ygG1fdwDWSg1wbIoVsaDV0cIJMnjLT487D
 /UOVJ6qAqEAdnmZ/Gn6Whg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765998694; x=
 1766085094; bh=LuoadUt5hmbMt01Gp3muN+fmuqo83j4AFDH5AKgwSG0=; b=T
 KdnnreFMqofJCAuuV34Ecic8GljXDstjYczP+vENIsCzjr8QI3B/GgfF8rPhzNv9
 oHMPy5e1nUoPxL7E+Gwb08u88afVbq4fe9CRED7R1zOfvSbqifgFy9AV8waZLP8B
 03c7tNslgYLfsPUTn9Gt7UtyAnTjrQoUUS3Pw7fm3AngtMCYNHAX21jtXZrmi5/t
 qHiQd7z3yVJ9bDArH5IUu+xBQJwc2Y1R5SXON9QHEP7ERk0gvvK32X8mj5YGvEp4
 TPYeu35iPqixlhmSKezHQ6T1VrdMIMMMa+aRuR8aH1zTMwEmlkRoGIO6HBI2bKL4
 M9ugxLs+kFK2Do2+rhVMQ==
X-ME-Sender: <xms:ZgBDaTLkFJAI2JpbcFgWztIWZGQ4BVPBvM7Y4_wR9ZPl2Fr7Sq_BbA>
 <xme:ZgBDaaMWdwhsx1w60ddzCAL33asZ0iOzuDj7xHrqt7oUC7TQJ3GMiX5Pa9WXNFWQX
 J5uvVc8jNjd3kwhNADxwBJdxN8zhJmSwsFGdlPwxlR3mYS_GC1N4Q8>
X-ME-Received: <xmr:ZgBDaWXtbC1mAFM40O7BAgU_NpxjPb0l0ZxmEKbJxWeFk8v0V0U2pw6xojQ>
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
X-ME-Proxy: <xmx:ZgBDaYlJyHyaDhdotXbEbK24Xlgrl3LSgc8FCyIJtNKiDIIGUobFfg>
 <xmx:ZgBDaVPOZD984r-tZLIb4-DsFrnqiOesqpnYgLihgdR--jcXcC21oA>
 <xmx:ZgBDaQJ8QIDBGNFb4YJxgxsH3SZ7I4y95whgI6rlq7NYY2w8CpBJ3A>
 <xmx:ZgBDaf1aMSI3r2v-Td_XUNyDnvDj8wIstAUkxHBp5-5S_ws_g2P15Q>
 <xmx:ZgBDaajbd0v8C8rtbNzOa0u4ybIEkcVUzNXiquqPMI1Gq3pmKPbJyzN2>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Dec 2025 14:11:34 -0500 (EST)
From: Patrick Williams <patrick@stwcx.xyz>
Date: Wed, 17 Dec 2025 14:11:31 -0500
Subject: [PATCH 04/11] hw/arm/aspeed: catalina: add OSFP FRU EEPROM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-catalina-eeproms-v1-4-dc7b276efd57@stwcx.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2886; i=patrick@stwcx.xyz;
 h=from:subject:message-id;
 bh=Znm5bQkxFZtTaIT824ye9Fr2PKuM0CvmA4wFRpX/qXs=;
 b=owEBbQKS/ZANAwAIAasDR8wtAMEZAcsmYgBpQwBgLQnkIXT3BedN6jOhvCxA9uTVeMrrEVg0H
 /3z/KQRcDGJAjMEAAEIAB0WIQQEYP2KLgsT1w1uokGrA0fMLQDBGQUCaUMAYAAKCRCrA0fMLQDB
 GVf4D/9C2VYCtjE/FHjJngrxAhyCUeLHF7PArosC6JJQ7w/lwt27O+0iKZRniD6BuHHc0NDw7Yo
 +H4GSmbZYizINkiWq/LY0vmIUNnmf/7VbrHuVJxMIgXGox6eyG5jTqWA7WtJ0KJ1rHQmOlpNb1B
 cVQLtHxo3bTwEQaWugq3a2R9MmzNvRAnNqnidbhG7m+HYAar0pEy//YovmfPAKlgIENbgQIFRQO
 b3Sc2Eiunsgz4v6F6igGCz2KjI/wdjQsvVpnsT3C3+SZEHgKaZGMMm6Qo20A/4Rv2dVe4rnelQU
 mPvShP0wpIbppGFnF0EeaUXObse6TgkLJbILWE4aXNPv1oWUkCCGihFatIKPw4v9bOS3lSrVQ05
 HfweahdPPLJTq+AJFe3ccWG1ynZ8EmtQCgR3vD3OePOUMwGYlCTHLW7r1kxrR0Y/wKSOUDMf6Rx
 3j6y3AhFP3Gqxg2UKBNCMiq9QEl8wJHdsJmxt+ne+zATkf63ftEMb4oocAPDqWBhUFx4lKyNlcs
 mI05XFCYAZzzr9OOvzqU0aZCtuQFBO9kBov7XyU9ZGqruQ+lcUnsa5xPv54NZzpBZYa5Opzk2Hd
 j3UNoylzVYnEAf96fZE3CO8B6U63kPLTN515kQqeNPthDSWAmph47bSDrU3KmT7GbBuD4OP5oPJ
 KCsjVtogfw4lY2Q==
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

Use ipmitool/frugen tool to generate an OSFP image based on a
sanitized set of data from a real device EEPROM.

Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
---
 hw/arm/aspeed_ast2600_catalina.c | 41 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index 2ba2c5c088..c8e62afdfe 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -151,6 +151,44 @@ static const uint8_t pdb_eeprom[] = {
 };
 static const size_t pdb_eeprom_len = sizeof(pdb_eeprom);
 
+/*
+ * OSFP Carrier Board FRU data. Generated with frugen.
+ *
+ *    {
+ *        "board": {
+ *            "mfg": "Quanta",
+ *            "pname": "Catalina OSFP MP (QEMU)",
+ *            "pn": "00000000000",
+ *            "serial": "00000000000000",
+ *            "date": "01/12/2025 00:00",
+ *            "custom": ["19-100316"]
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
+static const uint8_t osfp_eeprom[] = {
+    0x01, 0x00, 0x00, 0x01, 0x0a, 0x00, 0x00, 0xf4, 0x01, 0x09, 0x19, 0x8c,
+    0x19, 0xf0, 0xc6, 0x51, 0x75, 0x61, 0x6e, 0x74, 0x61, 0xd7, 0x43, 0x61,
+    0x74, 0x61, 0x6c, 0x69, 0x6e, 0x61, 0x20, 0x4f, 0x53, 0x46, 0x50, 0x20,
+    0x4d, 0x50, 0x20, 0x28, 0x51, 0x45, 0x4d, 0x55, 0x29, 0x8b, 0x10, 0x04,
+    0x41, 0x10, 0x04, 0x41, 0x10, 0x04, 0x41, 0x10, 0x04, 0x89, 0x10, 0x04,
+    0x41, 0x10, 0x04, 0x41, 0x10, 0x04, 0x01, 0xc0, 0x87, 0x51, 0xd6, 0x44,
+    0x10, 0x34, 0x45, 0x16, 0xc1, 0x00, 0x00, 0x6e, 0x01, 0x07, 0x19, 0xc6,
+    0x51, 0x75, 0x61, 0x6e, 0x74, 0x61, 0xcb, 0x43, 0x49, 0x2d, 0x43, 0x61,
+    0x74, 0x61, 0x6c, 0x69, 0x6e, 0x61, 0x89, 0x11, 0x04, 0x41, 0x10, 0x04,
+    0x41, 0x10, 0x14, 0x01, 0x82, 0x2d, 0x0c, 0x8b, 0x11, 0x04, 0x41, 0x10,
+    0x04, 0x41, 0x10, 0x04, 0x41, 0x10, 0x04, 0x83, 0x71, 0xd9, 0xd6, 0xc0,
+    0xc1, 0x00, 0x00, 0x37
+};
+static const size_t osfp_eeprom_len = sizeof(osfp_eeprom);
+
 static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 {
     /* Reference from v6.16-rc2 aspeed-bmc-facebook-catalina.dts */
@@ -227,7 +265,8 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 6),
                             TYPE_PCA9552, 0x25);
     /* eeprom@51 */
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 6), 0x51, 8 * KiB);
+    at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 6), 0x51, 8 * KiB,
+                          osfp_eeprom, osfp_eeprom_len);
 
     /* i2c1mux0ch7 */
     /* eeprom@53 */

-- 
2.51.2


