Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E44D66B9A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 19:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVww2-0005gg-Lu; Wed, 17 Dec 2025 14:11:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1vVwvz-0005ex-Tv; Wed, 17 Dec 2025 14:11:39 -0500
Received: from fhigh-a1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1vVwvy-00016H-8p; Wed, 17 Dec 2025 14:11:39 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 63CCA140014F;
 Wed, 17 Dec 2025 14:11:37 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 17 Dec 2025 14:11:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1765998697;
 x=1766085097; bh=qfeYsXVWAamQv+Ll4jDPpTtSNBLztoYOt1G2d/WxGMw=; b=
 ESm4D5MflflwbPYfpx039023JlPMGl0mcfzK8q04182ZONcUjhOLsB9uGqZmwOfa
 VK5QROVFOVkYjWLSJK4n+jYwXwAmJPURnsbAPKlX9ClvXMx69GXs5LpnrfjRa858
 4AvVQ0CEr+e1U2avSZxpt7//mp1umQmH5abLNhNS18B7aWyk67HpQ6t1xwrj6VHd
 wOuQYY/zbZbk8+v2BmwXvPSUQYcDEKIRkFDwOzWu18BCrL4VFW5Pb9t1QALggkVI
 W5XFB22cUwOaQ03GPU94/DfO+//j3HJQgGjVQ6erTO45RIXiUBE9R759VL7Uz5fu
 S30tEZIRP2JnOiElr6IHqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765998697; x=
 1766085097; bh=qfeYsXVWAamQv+Ll4jDPpTtSNBLztoYOt1G2d/WxGMw=; b=A
 LWKsjBqtV0etHttVzo3KFtufdWi+qElNvi3E88Hubi/AQYT8glKDUAo8XMdXkXo6
 S+K6P5CSFEaSFM0bkQULAfItJAnivYrm85ctiMLLEJlZy+n/tP1J8dKwIu/lligD
 Q/MzFd3pdknpBnh9/qu0uRehBxt2650PXnKyOxwbJTtzR/Ocm6dRGHEUshkoVfZv
 XdaqAcQdeaCMUPUoG0ZulNi+C0IrYYbYD0XzJyjlwKzWd1mYbz4Wgujdkdz0tghR
 UNGnbXD081Vj5bZWcNr7kteGAGGwWsu/gXFU92xoeC3k/Q9qvsqcoLw8FRWCwQAD
 ToVqysCxlAwVRP8J4efDQ==
X-ME-Sender: <xms:aQBDaSmuabNT_oUXMWHCuRng_QMzUpxvtIq8BuljxKQunvU672EcHg>
 <xme:aQBDac7-uKL8v4Mr0PAojdeybnU_MhPKRgT9YbRwsQjGz68_7jOxSqCiTv8xmRTAd
 rRd3tAaU4CqpkMLL3x_hsgsOqNIZ6JNfUO1V3HMJnN7KUlGFkQluKes>
X-ME-Received: <xmr:aQBDabRpt2P2UPXG6uacURhyVHIOqV3cuhdKHLkItLzWQVoTghIcA5c-uLo>
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
X-ME-Proxy: <xmx:aQBDaSwxAqH6uAAY3MlDZYW088uSCMbooPZ3ddB400z32aBqRf2NCg>
 <xmx:aQBDabrgbJb3QSPJHf372zj3z2rkOAdaEgTk_iKPYg4pom6tFNqwKw>
 <xmx:aQBDad3bLBgGYeN3ZxyuVaJSQubwiBBgp5iV6pC3qD6vi0rLxgjlpQ>
 <xmx:aQBDaTzt2HfuWFaEIEnH_oMmiws_Mlxq8L8kPjeV2hoWSw1bH5Qhtg>
 <xmx:aQBDaXmwXbVTxzfIW86YNaPdmyYJKNPXCNVR8fiYYurCRCVzCMG918k9>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Dec 2025 14:11:36 -0500 (EST)
From: Patrick Williams <patrick@stwcx.xyz>
Date: Wed, 17 Dec 2025 14:11:34 -0500
Subject: [PATCH 07/11] hw/arm/aspeed: catalina: add GB200 FRU EEPROM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-catalina-eeproms-v1-7-dc7b276efd57@stwcx.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3130; i=patrick@stwcx.xyz;
 h=from:subject:message-id;
 bh=JSq4Zf5ecxblPDZJopak/nNSkZ7TP5kw4S/wVk7Xn+I=;
 b=owEBbQKS/ZANAwAIAasDR8wtAMEZAcsmYgBpQwBg1Cxzk5WdrFOAW4SAbefiXgygHvdAYdhXr
 o8hGGexiA2JAjMEAAEIAB0WIQQEYP2KLgsT1w1uokGrA0fMLQDBGQUCaUMAYAAKCRCrA0fMLQDB
 GdFlD/45Thcd2ccfOvRpeq8AVnjEvCdGDz/JwtZhDgVq2Mf51qkjY6ZDV9u19J0u6pJsj+VTmYz
 AbxfMXpz/EgdvGR40d2ltqWq6ECIGn6AJrk7g2eLI2EO0AzzLtB+WmLh3jDETFEGejjmfQ1VXHx
 VkJtngO2rUj347cFAtLd5xDG5IXCztXwJ9OYKD8N7PkaP7gtJYhLCOX4UA/qnGMdvRoSXfAE4Lw
 XaMNwYJqjwMTR4ErYkarVpbL970naW/nBF+rIig5HOshSkMY3PLE3N3czwcTL+uHQiS089DlrWl
 /F/Jg1OU/6PhVjyxW31Hdc3/BWbCwZJZnr6uy8c23Cr1mTTnC8L9VNokamFvp38Wu3SoqBTnapK
 nthVw7aMx85/PjXHWVdqD18p+Mdj6rgjtBzqjmp30ScsjTeotYjoowMbYORT8f+CR/FsZWJvizD
 0iJkOGRKEh0vyU7DodX3B6yBUnuS/1j9JaE7Nl32whEVsCCjE1bfSe6RTua1XKvU7nDQ4PmUntM
 Kc00zhNbrV7SrYlZUD11tAiE9DiQorFs8XaihxUXB4ZUO/WW9GJBJ/9o9dCweALIjq1nCYqBc0S
 MgHYjugE18akhtQhTwfNZ5tkaQOVhTRLdgdlJOYWjdsDg0Naufh1Ac8E5vYQOvNPovfnxNOXCQe
 fJ+yu1CfHsuR3FA==
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

Use ipmitool/frugen tool to generate a GB200 image based on a
sanitized set of data from a real device EEPROM.

Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
---
 hw/arm/aspeed_ast2600_catalina.c | 45 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index 4cfde870af..4dd72c615d 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -265,6 +265,45 @@ static const uint8_t hdd_eeprom[] = {
 };
 static const size_t hdd_eeprom_len = sizeof(hdd_eeprom);
 
+/*
+ * GB200 CPU/GPU Board FRU data. Generated with frugen.
+ *
+ *    {
+ *        "board": {
+ *            "mfg": "NVIDIA",
+ *            "pname": "PG548 (QEMU)",
+ *            "pn": "000-00000-0000-000",
+ *            "serial": "0000000000000",
+ *            "date": "01/12/2025 00:00",
+ *            "custom": ["Version: A", "Rework:"]
+ *        },
+ *        "product": {
+ *            "mfg": "NVIDIA",
+ *            "pname": "GB200 1CPU:1GPU Board PC",
+ *            "pn": "100-00000-0000-001",
+ *            "ver": "E01",
+ *            "serial": "1000000000001",
+ *            "atag": "QEMU"
+ *        }
+ *    }
+ */
+static const uint8_t gb200_eeprom[] = {
+    0x01, 0x00, 0x00, 0x01, 0x0a, 0x00, 0x00, 0xf4, 0x01, 0x09, 0x19, 0x8c,
+    0x19, 0xf0, 0x85, 0xae, 0x9d, 0x92, 0x69, 0x08, 0x89, 0xf0, 0x59, 0x51,
+    0x18, 0x80, 0xc4, 0x65, 0x5b, 0x27, 0x8a, 0x10, 0x04, 0x41, 0x10, 0x04,
+    0x41, 0x10, 0x04, 0x41, 0x10, 0x8e, 0x10, 0x04, 0x35, 0x10, 0x04, 0x41,
+    0x50, 0x03, 0x41, 0x10, 0xd4, 0x40, 0x10, 0x04, 0xc0, 0xca, 0x56, 0x65,
+    0x72, 0x73, 0x69, 0x6f, 0x6e, 0x3a, 0x20, 0x41, 0xc7, 0x52, 0x65, 0x77,
+    0x6f, 0x72, 0x6b, 0x3a, 0xc1, 0x00, 0x00, 0x37, 0x01, 0x09, 0x19, 0x85,
+    0xae, 0x9d, 0x92, 0x69, 0x08, 0xd8, 0x47, 0x42, 0x32, 0x30, 0x30, 0x20,
+    0x31, 0x43, 0x50, 0x55, 0x3a, 0x31, 0x47, 0x50, 0x55, 0x20, 0x42, 0x6f,
+    0x61, 0x72, 0x64, 0x20, 0x50, 0x43, 0x8e, 0x11, 0x04, 0x35, 0x10, 0x04,
+    0x41, 0x50, 0x03, 0x41, 0x10, 0xd4, 0x40, 0x50, 0x04, 0x83, 0x25, 0x14,
+    0x01, 0x8a, 0x11, 0x04, 0x41, 0x10, 0x04, 0x41, 0x10, 0x04, 0x41, 0x11,
+    0x83, 0x71, 0xd9, 0xd6, 0xc0, 0xc1, 0x00, 0x17
+};
+static const size_t gb200_eeprom_len = sizeof(gb200_eeprom);
+
 static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 {
     /* Reference from v6.16-rc2 aspeed-bmc-facebook-catalina.dts */
@@ -403,11 +442,13 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* &i2c12 */
     /* eeprom@50 */
-    at24c_eeprom_init(i2c[12], 0x50, 8 * KiB);
+    at24c_eeprom_init_rom(i2c[12], 0x50, 8 * KiB,
+                          gb200_eeprom, gb200_eeprom_len);
 
     /* &i2c13 */
     /* eeprom@50 */
-    at24c_eeprom_init(i2c[13], 0x50, 8 * KiB);
+    at24c_eeprom_init_rom(i2c[13], 0x50, 8 * KiB,
+                          gb200_eeprom, gb200_eeprom_len);
     /* eeprom@54 */
     at24c_eeprom_init(i2c[13], 0x54, 256);
     /* eeprom@55 */

-- 
2.51.2


