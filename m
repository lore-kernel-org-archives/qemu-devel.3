Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2308A606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=RkgSh9Gm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp6A-00035i-U7; Fri, 27 Nov 2026 01:06:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp2L-0004Gz-Sx; Fri, 27 Nov 2026 01:02:23 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp2J-0001wS-Gi; Fri, 27 Nov 2026 01:02:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759041; bh=1XiSdYhg6i22bKb1UIQ9tET9djylqBSV9GRzRoFO2FQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RkgSh9GmrDHDqN45c92JYB4DUb0n1Je0H5AyVRhjH7mBNxVOkSuXbYcf33y7qrEBo
 VRtYBZYcATvMCbWoO/4/hB19MqZ+5Ak424F/GsgdClEAi1HDWa8kU0P0Mq4CAocEk4
 LwMN/fjZny39bIbWuUVekP9t5OivKV7wEBT22SGC4Srsix7hPw70oXIIPNkG5y1GwS
 gBNYP/PiBJDU4LBKingRjLXAKf+NQl2k2PD9uk+tdzz75s0HuHSydARa5DP0WoMVOM
 S3Wb6UJPrZr+CaDSdcT8pDqX9CowMRhGhwrx2DzI7/tJYC7Cp0FYagUDTvvJYSpKKU
 w6xWuMaOVeTDQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5577A1EA331;
 Fri, 27 Nov 2026 08:57:21 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 531C046995D;
 Fri, 27 Nov 2026 08:57:21 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 4C7C4CF2B2; Fri, 27 Nov 2026 08:57:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 064/152] hw/intc/arm_gicv5: Use correct type for
 value in lpi_cache_get_hppi()
Date: Fri, 27 Nov 2026 08:53:22 +0300
Message-ID: <20261127055709.39630-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

lpi_cache_get_hppi() is a function we pass to g_hash_table_foreach()
to iterate over the LPI cache hashtable.  This hash table has keys
which are GINT_TO_POINTER(intid) and values which hold the L2 ISTE
value, allocated as "hashvalue = g_new(uint32_t, 1)".

The function is passed the key and value as type 'gpointer' and has
to cast them to the real types itself, but it incorrectly casts the
value pointer to a uint64_t*.  This works on little-endian hosts
(since we only read specific fields of the L2 ISTE using bitmasking),
but won't work on big-endian, and trips the clang sanitizer.

Fix the pointer type; for consistency we fix also the type of the
local variable, though that was not producing any incorrect
behaviour.

Cc: qemu-stable@nongnu.org
Fixes: a0562ada75e ("hw/intc/arm_gicv5: Calculate HPPI in the IRS")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20261103172616.2400758-5-peter.maydell@linaro.org
(cherry picked from commit a378b4701c73abfe124212b3de2084ffec471895)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index ebfb0878af3..fd9e647ea67 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -390,7 +390,7 @@ typedef struct GetHPPIUserData {
 static void lpi_cache_get_hppi(gpointer key, gpointer value, gpointer user_data)
 {
     uint64_t id = GPOINTER_TO_INT(key);
-    uint64_t l2_iste = *(uint64_t *)value;
+    uint32_t l2_iste = *(uint32_t *)value;
     uint32_t prio, iaffid;
     GetHPPIUserData *ud = user_data;
 
-- 
2.47.3


