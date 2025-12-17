Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A54BD66B9A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 19:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVww4-0005iS-UN; Wed, 17 Dec 2025 14:11:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1vVwvw-0005cB-Tk; Wed, 17 Dec 2025 14:11:36 -0500
Received: from fhigh-a1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1vVwvt-00014Q-TJ; Wed, 17 Dec 2025 14:11:36 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 07AAE1400135;
 Wed, 17 Dec 2025 14:11:33 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Wed, 17 Dec 2025 14:11:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1765998693;
 x=1766085093; bh=lpt5+IR16CqJoRHLmrUmUyPY1RM3rlR4vGhvmFAy/To=; b=
 k3q6I8Ks8QIjGyneT4lMGJYs+H8k279xT0ToHdL6Ty1FQ3RwIu/QIwBjHLMuG5iU
 LXidLgjcZYYZQhKcj9KIRDybrSHdHAV2NPwImbCENJjYF/5PfkdJ21q7ra1+6LlF
 LMnS1IBnI/92UKn9OhNClGuiIKX0Br4m/HOEZKKrNGNSmbYthqHOvXrLGRi5S8fO
 JFMbb4EIfeWEGKlU5ORFTbwiT1bZseKisNJPxoOiIVinj8KWVyjF7Kdq//YjXt7y
 f2UfgKX/bwo3KKZHcSTQ0MJ1nqdMqxNhyUOypMBzUWMBInVMkoIEUek1ABYNO4+H
 EZ0wvpYtgEhszzZToJOW5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765998693; x=
 1766085093; bh=lpt5+IR16CqJoRHLmrUmUyPY1RM3rlR4vGhvmFAy/To=; b=Q
 o2URXiiGOT9bjlWcyxFJSkchhx9b6Ai23P0UNGxKq5bHVZ1k1s/uIL7Hw13gcizc
 XxVE8ZfViXUuQQPKWZ/MujWW6/a0n/qsD0e7IsuRkd3jFV2oV9MUj3sUiL5fe7xn
 W4V5o4fnbktuySWrpcJs9Nt9NplByVcgRHLehYdhUS9ABoUI3fv0P/NfNIdIKQgR
 vEQQMRpg7QgHhBFSZiPa2KK13TNxkeWWcH2saKcClqQpUmVdNOhjD4eoywVyku7N
 o2Pyhd1mP+TgxpYdSp9e+iD/eCeVa4W+e46L9PPa+PTxMX2Drqr3s5cQA4SeQQST
 NCKdgIF3UCtJKP/xr0FBQ==
X-ME-Sender: <xms:ZABDaSSol1AyCuMk3fzJFdLQNuXA1jzqRI9Fa5XJpL8uCU4cP3FbNw>
 <xme:ZABDaVLH8CbWuGsjLFRHMYG2kR_wzz_JbRqhedFLQl2HmRvnNwGlkkJm1QK2_VFGR
 pM_Fp83MyfHKcLKJPAvueIjV8mGknJiiIQc3lTzlqVUhujPH6oUmELj>
X-ME-Received: <xmr:ZABDaXIBM5wdes4DBqmbQRt8_6PKThtCkejla8eLP6DWvUtMgT1mMJ81NjY>
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
X-ME-Proxy: <xmx:ZABDaYhy3BlA6D7jK2A1KuHV3cz8rRPlyvGV-DuRPfivVdZGXk08fA>
 <xmx:ZABDaZMElVmKuH4uoUSOajspkLVPgYaMOMJkc57jnH_LYN6GIBDn8w>
 <xmx:ZABDabrGjUE_iZxukVZ77JbxZwQBnHvftB7Y0YSdSUIRk2T0QkqD0A>
 <xmx:ZABDaT4_2Su9d17OFpGT4Sgo94hXdigi7KNidBR_olzNIqvzbwhQYw>
 <xmx:ZQBDaY0lK6afHeKQ1zMIDf48dBebw6PhCS8F5wmZWtLZGzMjVry4WjqN>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Dec 2025 14:11:32 -0500 (EST)
From: Patrick Williams <patrick@stwcx.xyz>
Date: Wed, 17 Dec 2025 14:11:29 -0500
Subject: [PATCH 02/11] hw/arm/aspeed: catalina: add DC-SCM FRU EEPROM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-catalina-eeproms-v1-2-dc7b276efd57@stwcx.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2796; i=patrick@stwcx.xyz;
 h=from:subject:message-id;
 bh=5sMIW5i+afOIdU1FbonCdPE8ODma6AUF6ZUDP3gaZZ4=;
 b=owEBbQKS/ZANAwAIAasDR8wtAMEZAcsmYgBpQwBg+5RsLUTyuPJInSJDgV0v1yuTH3mCu+x4X
 cqukxVzP9uJAjMEAAEIAB0WIQQEYP2KLgsT1w1uokGrA0fMLQDBGQUCaUMAYAAKCRCrA0fMLQDB
 GZDDD/9JTpz3GoBiCt3Pk+dvchK2VpCRuiXWsCgrkLsNS2nS9OvsyFfPKJK/uQO2XRqWGogU2ux
 cxRX17b7a87+6AaaBnNgZGBX71Dr2VD2ChNwSqnTn2s6yHSIrCSS3Bbzn320QXOhCFIH07GMFIr
 TZz1N0BW3WwWtu9wGM6qEgHtHDx1b8bjzFESPRJmAB+/rEk303/keIJKC/LtFphGWZRxvh8GCXO
 3iVmvacsJ5MrdmlRpHuB2npyTrhKaamRvLh61/pRQLmxoyxo0ODPPg38k/dctPDmKpXtui0jHEP
 iC5noY+nP/vwAT9sEN34/NH/CYEUInPslVz8l6JQNye4KO0Yy+hjyD0FOH56GItPsLXtJxvfunZ
 R6wCvmOWNBV1vlURnAk597LA0W01nPvpadZYFUC28nUzsMa26e1BITD3Qm93EKgMC1298v1X82R
 hHlfVmSYd5z1zsg7Zj3qHVAeT8coWKwMqfLzwMzLnOUgxZtOfmkqSHtmUxdGe1pwdjrCGdpybrt
 QwLPP8fXefDFoU3P03xW+T0jlvqeyLsNeaNjYGZjwjx6tedbX0UR4+PhmSds8FoOMddt39iZjNl
 Hjj5WfTvs7DCBp51CETAPdX+xD+skHY6BRlTjctUUh4eKRk9lTpsrhxypujYw2H8rYT0Y0cd6/D
 VgqTLwRWwws5BZw==
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

Use ipmitool/frugen tool to generate a DC-SCM image based on a
sanitized set of data from a real device EEPROM.

Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
---
 hw/arm/aspeed_ast2600_catalina.c | 41 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index 0f229f4dc6..6e8f4d39d9 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -64,6 +64,45 @@ static const uint8_t bsm_eeprom[] = {
 };
 static const size_t bsm_eeprom_len = sizeof(bsm_eeprom);
 
+/*
+ * "Secure Control Module" FRU data. Generated with frugen.
+ *
+ *    {
+ *      "board": {
+ *        "mfg": "Quanta",
+ *        "pname": "Catalina SCM MP (QEMU)",
+ *        "pn": "00000000000",
+ *        "serial": "00000000000000",
+ *        "date": "01/12/2025 00:00",
+ *        "custom": ["19-100325"]
+ *      },
+ *      "product": {
+ *        "mfg": "Quanta",
+ *        "pname": "CI-Catalina",
+ *        "pn": "10000000001",
+ *        "ver": "MP",
+ *        "serial": "10000000000000",
+ *        "atag": "QEMU"
+ *      }
+ *    }
+ *
+ */
+static const uint8_t scm_eeprom[] = {
+    0x01, 0x00, 0x00, 0x01, 0x0a, 0x00, 0x00, 0xf4, 0x01, 0x09, 0x19, 0x8c,
+    0x19, 0xf0, 0xc6, 0x51, 0x75, 0x61, 0x6e, 0x74, 0x61, 0xd6, 0x43, 0x61,
+    0x74, 0x61, 0x6c, 0x69, 0x6e, 0x61, 0x20, 0x53, 0x43, 0x4d, 0x20, 0x4d,
+    0x50, 0x20, 0x28, 0x51, 0x45, 0x4d, 0x55, 0x29, 0x8b, 0x10, 0x04, 0x41,
+    0x10, 0x04, 0x41, 0x10, 0x04, 0x41, 0x10, 0x04, 0x89, 0x10, 0x04, 0x41,
+    0x10, 0x04, 0x41, 0x10, 0x04, 0x01, 0xc0, 0x87, 0x51, 0xd6, 0x44, 0x10,
+    0x34, 0x49, 0x15, 0xc1, 0x00, 0x00, 0x00, 0xc1, 0x01, 0x07, 0x19, 0xc6,
+    0x51, 0x75, 0x61, 0x6e, 0x74, 0x61, 0xcb, 0x43, 0x49, 0x2d, 0x43, 0x61,
+    0x74, 0x61, 0x6c, 0x69, 0x6e, 0x61, 0x89, 0x11, 0x04, 0x41, 0x10, 0x04,
+    0x41, 0x10, 0x14, 0x01, 0x82, 0x2d, 0x0c, 0x8b, 0x11, 0x04, 0x41, 0x10,
+    0x04, 0x41, 0x10, 0x04, 0x41, 0x10, 0x04, 0x83, 0x71, 0xd9, 0xd6, 0xc0,
+    0xc1, 0x00, 0x00, 0x37
+};
+static const size_t scm_eeprom_len = sizeof(scm_eeprom);
+
 static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 {
     /* Reference from v6.16-rc2 aspeed-bmc-facebook-catalina.dts */
@@ -183,7 +222,7 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     /* temperature-sensor@4b - tpm75 */
     i2c_slave_create_simple(i2c[9], TYPE_TMP75, 0x4b);
     /* eeprom@50 */
-    at24c_eeprom_init(i2c[9], 0x50, 8 * KiB);
+    at24c_eeprom_init_rom(i2c[9], 0x50, 8 * KiB, scm_eeprom, scm_eeprom_len);
     /* eeprom@56 */
     at24c_eeprom_init_rom(i2c[9], 0x56, 8 * KiB, bsm_eeprom, bsm_eeprom_len);
 

-- 
2.51.2


