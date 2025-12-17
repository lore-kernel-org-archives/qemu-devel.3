Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D350D66B9A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 19:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVww7-0005lm-Uj; Wed, 17 Dec 2025 14:11:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1vVww2-0005gh-IJ; Wed, 17 Dec 2025 14:11:42 -0500
Received: from fhigh-a1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1vVww0-00017E-VI; Wed, 17 Dec 2025 14:11:42 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 0DCAF1400153;
 Wed, 17 Dec 2025 14:11:40 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 17 Dec 2025 14:11:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1765998700;
 x=1766085100; bh=trdvBtKEUmPko8wZZZRCAPQSdqmLgmNhs+xnFYm/J7A=; b=
 p6x6aS1vj9Rks5K9YhVeeNY8BlCo9pe0ub47lnylV0ESQxno3RTy1qHdWdWxNMpL
 DojaDosvg/GDe6uxAO4odmWxpSH54lErrnwGHJOiTw7fhl20/MWIZY7lAdZpWsbR
 IrftXsRzmA5IWXM6cbEHWLZ3vC2AqnkAN4R1jMupFYpE70vwByGgZGi8+kfOI5Zs
 Z9TAoYkj7iw1Igj5soJF/7OcP5pOT4HJPvKxyDXi8aKYhAZqyHehQsEj6shWWzl5
 5qoof24KnVexdzKgtdwmQUBrjj384OXfmrqqGohqe8VJUVQIhU+ppaChQyLjLLQL
 0/lkULVhKGo0bEpZPQQTjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765998700; x=
 1766085100; bh=trdvBtKEUmPko8wZZZRCAPQSdqmLgmNhs+xnFYm/J7A=; b=i
 DGK+MSUoU6SV+/QP9TiiLVQpGPLZy+3S8lnuqhNDUmfUa+zZoymFa4GDiFAGG8hH
 kIiIZJnUoPYZSx2ph3FWfL2dPwR3BlW9k9XWaQs7Ykbg0piNqYZADFaQ8m8pBxx0
 lolAdtWfXdwTlhk+YTQR3zq2I/qcOHkRNZa2VKs9zNXTIpH2EAGZUsLyMDPPRw0g
 XVRazf0i062MIY6ERXEFsaVRrGA7bC/VVElM7QHodHuiuLZOzzSYd8IpKwKWrKNQ
 V//z3X9VT2rX1L8zGMRoQqHL3YQkhMbX39WCaGyYbCoFNPq18W9+XH6suE9EKH4s
 Y9ka5QJG5xeZq/uHPJ/Sg==
X-ME-Sender: <xms:awBDafps-HNqo3NvVI4kTQ0jXWGxYPm3kNtGnsIgeHmKk0v6mZmHEw>
 <xme:awBDacsDnAXqJZ-375ycrRsC_1vfoFzXPzYaA4OcEmqDsDBNinUHX5sEYzLbUIHF4
 xuD2hk8oNbNHtCwhkuqlSN1wlE7DGG3soRt88VENsGLGlnDG4FXfSo>
X-ME-Received: <xmr:awBDaW3XF3QGZBt2BX668UWOBsTLz3ACmGZRrU-kDT8vNT6TK_NW6sN9z_E>
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
X-ME-Proxy: <xmx:awBDafEeMdGsvcLQt06MH8YYRK0QovdxELxOhUiGEvwuyOQy4VE2TQ>
 <xmx:awBDaZsbo0vC4bgwerPMiFE5wieE0tl_UsJONH2_1xDR1knx9Iw52w>
 <xmx:awBDaaoTll4kqpntf9aPYH6_CHUiDJNhB2UXiKrxDpbRAmp7Xj9Yzg>
 <xmx:awBDaYXdwzEHvWI6-i6MDhyQZQVS1sVOsUNsPQIO40rl5AgzikBxHA>
 <xmx:bABDabCEKevFNWVtVfrp6iD_ObF5E6xmPLhD07K8PATRWEvuavEtoIum>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Dec 2025 14:11:39 -0500 (EST)
From: Patrick Williams <patrick@stwcx.xyz>
Date: Wed, 17 Dec 2025 14:11:37 -0500
Subject: [PATCH 10/11] hw/arm/aspeed: catalina: add NIC FRU EEPROM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-catalina-eeproms-v1-10-dc7b276efd57@stwcx.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3292; i=patrick@stwcx.xyz;
 h=from:subject:message-id;
 bh=AqK7FC2aq6QrbLuNqpsdQ9FZzJn2q1br67zuerRR6nU=;
 b=owEBbQKS/ZANAwAIAasDR8wtAMEZAcsmYgBpQwBgeHMkfYMSr6BTFoN7LnM9f/kteb5pZya0U
 NrPmsgoil2JAjMEAAEIAB0WIQQEYP2KLgsT1w1uokGrA0fMLQDBGQUCaUMAYAAKCRCrA0fMLQDB
 GT23D/911R58tATUBEdSNMy0X7ZFgE+F7NAy0G9WU2Em+CLTrIxFa8usDHswsniitcSzcKrP+pq
 LlCdcpX6MPCn+qhuYC1gAxwwit35qAtBsv6mCGgOaxyXUvbCwEXl5eyWtjG+LzAKTfb7yugAJt9
 t3U3G8k8q3CmcZJ7XnCUiWJ8w1SGHMUwaeVCPg9k2TFKLDSv/EUH5XjddmzV9CB35HjtN8qPAmA
 LqPVrq4fl/Z9L28V1gan+XIOiTVqtZVBoVlhdskNFsoOJPtu1PBJA8LJziaZ4FUDotIOY1UANsc
 LGA92448ll4EwIfC0oNdxu9D+pn28YmJGAaLl2rPAFHrGvnf37ce5LonFxbGO1V4w2RXQ7352kO
 4crTra9ZFTC4W/YzBvOqA/14exlgZVRtxH0GrHbdxD0/uFDL50gJo4uPa6dFYKVSpdBG2YlqGTL
 aO7BzIO/VVtJBLSUQ3zuxeX4dJYEaHSXVj3y42kd3tEHtCI8UMh4WLsqIlZBsRVwxD3CFJ3YK6J
 WlXMZfF8YPWgWvEcqpwpo+bBsng8fsCg9X7GhzkwR02u7vNqGGZzz/SegkZMRh4u94FUiqbeT0e
 CM8OdAc/40hTc+yZwBenXl+3oUC/V+SS+1bXNWtOKA6DKJRUyfNkgLWkYTBLE7RQxwjvxmuL+/J
 LiPNBlcE7+1ykcA==
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

Use ipmitool/frugen tool to generate a CX-7 NIC image based on a
sanitized set of data from a real device EEPROM.

Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
---
 hw/arm/aspeed_ast2600_catalina.c | 42 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index 2c9b4b6fff..5044441f38 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -381,6 +381,44 @@ static const uint8_t hmc_eeprom[] = {
 };
 static const size_t hmc_eeprom_len = sizeof(hmc_eeprom);
 
+/*
+ * CX-7 NIC FRU data. Generated with frugen.
+ *
+ *    {
+ *        "board": {
+ *            "mfg": "Nvidia",
+ *            "pname": "Nvidia ConnectX-7 OCP3.0 (QEMU)",
+ *            "pn": "CX70000000-000_00",
+ *            "serial": "000000000000",
+ *            "date": "01/12/2025 00:00"
+ *        },
+ *        "product": {
+ *            "mfg": "Nvidia",
+ *            "pname": "Nvidia ConnectX-7 OCP3.0",
+ *            "pn": "CX71000000-000_01",
+ *            "ver": "A7",
+ *            "serial": "100000000001",
+ *            "atag": "QEMU"
+ *        }
+ *    }
+ */
+static const uint8_t nic_eeprom[] = {
+    0x01, 0x00, 0x00, 0x01, 0x0a, 0x00, 0x00, 0xf4, 0x01, 0x09, 0x19, 0x8c,
+    0x19, 0xf0, 0xc6, 0x4e, 0x76, 0x69, 0x64, 0x69, 0x61, 0xdf, 0x4e, 0x76,
+    0x69, 0x64, 0x69, 0x61, 0x20, 0x43, 0x6f, 0x6e, 0x6e, 0x65, 0x63, 0x74,
+    0x58, 0x2d, 0x37, 0x20, 0x4f, 0x43, 0x50, 0x33, 0x2e, 0x30, 0x20, 0x28,
+    0x51, 0x45, 0x4d, 0x55, 0x29, 0x89, 0x10, 0x04, 0x41, 0x10, 0x04, 0x41,
+    0x10, 0x04, 0x41, 0x8d, 0x23, 0x7e, 0x41, 0x10, 0x04, 0x41, 0x10, 0xd4,
+    0x40, 0x10, 0xf4, 0x43, 0x10, 0xc0, 0xc1, 0xc3, 0x01, 0x09, 0x19, 0xc6,
+    0x4e, 0x76, 0x69, 0x64, 0x69, 0x61, 0xd8, 0x4e, 0x76, 0x69, 0x64, 0x69,
+    0x61, 0x20, 0x43, 0x6f, 0x6e, 0x6e, 0x65, 0x63, 0x74, 0x58, 0x2d, 0x37,
+    0x20, 0x4f, 0x43, 0x50, 0x33, 0x2e, 0x30, 0x8d, 0x23, 0x7e, 0x45, 0x10,
+    0x04, 0x41, 0x10, 0xd4, 0x40, 0x10, 0xf4, 0x43, 0x11, 0x82, 0xe1, 0x05,
+    0x89, 0x11, 0x04, 0x41, 0x10, 0x04, 0x41, 0x10, 0x04, 0x45, 0x83, 0x71,
+    0xd9, 0xd6, 0xc0, 0xc1, 0x00, 0x00, 0x00, 0xf3
+};
+static const size_t nic_eeprom_len = sizeof(nic_eeprom);
+
 static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 {
     /* Reference from v6.16-rc2 aspeed-bmc-facebook-catalina.dts */
@@ -514,7 +552,7 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     /* temperature-sensor@1f - tpm421 */
     i2c_slave_create_simple(i2c[10], TYPE_TMP421, 0x1f);
     /* eeprom@50 */
-    at24c_eeprom_init(i2c[10], 0x50, 8 * KiB);
+    at24c_eeprom_init_rom(i2c[10], 0x50, 8 * KiB, nic_eeprom, nic_eeprom_len);
 
     /* &i2c11 */
     /* ssif-bmc@10 - no model */
@@ -553,7 +591,7 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     /* temperature-sensor@1f - tmp421 */
     i2c_slave_create_simple(i2c[15], TYPE_TMP421, 0x1f);
     /* eeprom@52 */
-    at24c_eeprom_init(i2c[15], 0x52, 8 * KiB);
+    at24c_eeprom_init_rom(i2c[15], 0x52, 8 * KiB, nic_eeprom, nic_eeprom_len);
 }
 
 static void aspeed_machine_catalina_class_init(ObjectClass *oc,

-- 
2.51.2


