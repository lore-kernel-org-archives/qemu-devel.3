Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62438C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvutM-0006Sm-Hb; Mon, 17 Aug 2026 06:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvusY-0005Z9-NE; Mon, 17 Aug 2026 06:47:43 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvusX-0004LQ-09; Mon, 17 Aug 2026 06:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786963486; bh=PuGyth0maI/b4y4DeiSqPw+A+mfTPcrszkcFVxZiEjM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Z4C0gKwN7rA/v0xiKwqOyeqhY59TAVxOgOZlEq7kN4oqsxfENrkvBNcheRosmma2t
 lbQ3THCZlCPGbYV3Prhh9XFAkGPGCutNNFH+N98GrYEJ8QzjxZel5acxzjNSMz66lH
 K4weawk7j7sTx/1Wv5IOgC9QjZI+kHwleRELPkUEV6obMtICQNYf6WRyyraO6HudQ5
 DeM4GQ2KMAZChNXoexfYBootK2JGcyGkh6n3WiUknjZFSXEGgDy9vkFfF41tGLgTOm
 astO3rfBlvCk+rMMWfUnFplkrDs2f8FPCCU6i8PlONBkJJa7hMikBoGey0MeqKcyDl
 myjTdcdJ79OOw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D73DE1CBB85;
 Mon, 17 Aug 2026 13:44:46 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D8B0940D216;
 Mon, 17 Aug 2026 13:45:07 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 4F33A30E82; Mon, 17 Aug 2026 13:44:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 v2 152/161] tests/qtest/libqos/ahci: support raw
 (2352-byte) READ CD
Date: Mon, 17 Aug 2026 13:43:06 +0300
Message-ID: <20260817104344.2047346-32-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260817125055@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260817125055@cover.tls.msk.ru>
MIME-Version: 1.0
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: "Denis V. Lunev" <den@openvz.org>

ahci_exec() always builds ATAPI commands with a 2048-byte logical
sector size, so it cannot drive a READ CD that returns full 2352-byte
raw sectors. Add an atapi_raw option that sets the READ CD
field-selector to 0xf8 and the command's sector size to 2352 before
the transfer is sized, so the derived block count stays correct while
the buffer and byte counts cover the raw sectors.

Signed-off-by: Denis V. Lunev <den@openvz.org>
(cherry picked from commit de86ef3dfd337ec5a74b43d7d042ab937d0166bf)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
index 0621a6c4775..e3019a1ecad 100644
--- a/tests/qtest/libqos/ahci.c
+++ b/tests/qtest/libqos/ahci.c
@@ -707,6 +707,11 @@ void ahci_exec(AHCIQState *ahci, uint8_t port,
     if (opts->atapi) {
         uint16_t bcl = opts->set_bcl ? opts->bcl : ATAPI_SECTOR_SIZE;
         cmd = ahci_atapi_command_create(op, bcl, opts->atapi_dma);
+        if (opts->atapi_raw) {
+            /* request full 2352-byte raw sectors; sector_size must match */
+            cmd->atapi_cmd[9] = 0xf8;
+            cmd->sector_size = ATAPI_RAW_SECTOR_SIZE;
+        }
     } else {
         cmd = ahci_command_create(op);
     }
diff --git a/tests/qtest/libqos/ahci.h b/tests/qtest/libqos/ahci.h
index a0487a1557d..2a48a7523df 100644
--- a/tests/qtest/libqos/ahci.h
+++ b/tests/qtest/libqos/ahci.h
@@ -242,6 +242,7 @@
 
 #define AHCI_SECTOR_SIZE                (512)
 #define ATAPI_SECTOR_SIZE              (2048)
+#define ATAPI_RAW_SECTOR_SIZE          (2352)
 
 #define AHCI_SIGNATURE_CDROM     (0xeb140101)
 #define AHCI_SIGNATURE_DISK      (0x00000101)
@@ -485,6 +486,7 @@ typedef struct AHCIOpts {
     uint64_t buffer;    /* Pointer to source or destination guest buffer */
     bool atapi;         /* ATAPI command? */
     bool atapi_dma;     /* Use DMA for ATAPI? */
+    bool atapi_raw;     /* READ CD returning 2352-byte raw sectors */
     bool error;
     int (*pre_cb)(AHCIQState*, AHCICommand*, const struct AHCIOpts *);
     int (*mid_cb)(AHCIQState*, AHCICommand*, const struct AHCIOpts *);
-- 
2.47.3


