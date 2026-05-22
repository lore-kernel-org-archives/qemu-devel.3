Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0C0CD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXob-0000kH-77; Fri, 22 May 2026 17:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXo7-0000Gr-1p; Fri, 22 May 2026 17:53:27 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXo5-00056Z-3T; Fri, 22 May 2026 17:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779486561; bh=uwIk2g6C48QDxHZ1Rndg/wiAHcFoc6O9sffrranMGdI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=nT/Bfw3FoH7+43073IhsRUegDbv5rG6UbBj0M8L4qxvo4HnsWRcEwWz7OZOo86+Wi
 RjQlwN4Fi+YqaFTV5qnWBKBvGCiBU9p6wzgYx9BY3yrxSU1i5Em1u6JxZbLFwvd+Mo
 c/V4MUoO1jtUsjKUgGhvMUWvPX6OC10ULowTdw9OtaViBB1iW55Y76/R3dKSZSOpWx
 aYAesmwevBvTtj2sJVbnt8OEjnT2aHTaO2aPH/eHg9i2XapWjMufgyeYKt9DYbAMCU
 IUR9jDamssJoZORdl9HJ9yAxNDGg6m1mrV5XcVvqYzywGWDGfSj/KBpNZnj/dBfw/N
 sERhCBIIRjr1Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DD4F41AFB86;
 Sat, 23 May 2026 00:49:21 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 11D423B71D5;
 Sat, 23 May 2026 00:49:26 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Lexi Winter <ivy@FreeBSD.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 144/149] block: Add more defaults to DEFAULT_BLOCK_CONF
Date: Sat, 23 May 2026 00:49:16 +0300
Message-ID: <20260522214923.807017-45-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru>
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

From: Kevin Wolf <kwolf@redhat.com>

discard_granularity was missing from this, which means that SCSI disks
created with -drive if=scsi would default to 0 (i.e. disabling discards)
instead of -1, which makes scsi-hd automatically pick a granularity and
is the default of the corresponding qdev property for -device scsi-hd.

This was broken in QEMU 9.0 with commit 3089637.

Also set other fields whose default isn't an obvious 0. These are not
actual bug fixes because ON_OFF_AUTO_AUTO in fact happens to be 0, but
it's better not to rely on the order of enums.

Cc: qemu-stable@nongnu.org
Fixes: 308963746169 ('scsi: Don't ignore most usb-storage properties')
Reported-by: Lexi Winter <ivy@FreeBSD.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20260410152314.86412-3-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit f27aea1896338f4dd085a0e2cb2ab3797c5fe3e9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index 7da643faff..9225e75925 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -53,7 +53,12 @@ static inline unsigned int get_physical_block_exp(BlockConf *conf)
 
 #define DEFAULT_BLOCK_CONF (BlockConf) {                                \
     .bootindex = -1,                                                    \
+    .backend_defaults = ON_OFF_AUTO_AUTO,                               \
+    .discard_granularity = -1,                                          \
+    .wce = ON_OFF_AUTO_AUTO,                                            \
     .share_rw = false,                                                  \
+    .account_invalid = ON_OFF_AUTO_AUTO,                                \
+    .account_failed = ON_OFF_AUTO_AUTO,                                 \
     .rerror = BLOCKDEV_ON_ERROR_AUTO,                                   \
     .werror = BLOCKDEV_ON_ERROR_AUTO,                                   \
 }
-- 
2.47.3


