Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9925EC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 11:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzxUh-0002Ks-JS; Thu, 25 Apr 2024 07:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vilhelmgyda@gmail.com>)
 id 1rzxUe-0002KX-6K; Thu, 25 Apr 2024 07:42:24 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vilhelmgyda@gmail.com>)
 id 1rzxUc-0008Ne-JX; Thu, 25 Apr 2024 07:42:23 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6ed3cafd766so809113b3a.0; 
 Thu, 25 Apr 2024 04:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714045340; x=1714650140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4WihhI17+h0UselPTrYdal9ALxk/nvaFEA/Gh0x8DAg=;
 b=QgGTgsw7zzb9PQ2bh+NIZ4p2yO6WMWIplKvBIcn441aT00cis1oo+KbzURRyCIHCyu
 mqgILvCkTNhjXxKx4DUYm2OJswgWm/zidRlcwFTdNSbmUZzYXphpkjN/W5buLLV6eKzi
 eh8bPXSOBSE9aCa3fPeRqQvtRRf5afWbe+j4zTg6U7uLLUr+/zkYICFdILu0LA+pWydK
 DqsvGys6XiORbL78zesMidg1/U299CIcmUmHmFqOw4N7unAIs5CYm8ftRQgNinVLBJzG
 4ivk7uOU2Tq92msTU3n74p/r+CajX1sYPE5F6vDpfAHZPjKzxHpqmaRQH2WRq7rjY4RU
 f+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714045340; x=1714650140;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4WihhI17+h0UselPTrYdal9ALxk/nvaFEA/Gh0x8DAg=;
 b=Qdzgdmj2OgATEsKAtNAKmxE5bPPKy0HeTZKoul3XMpW/DifBPCUkYNdV+cJaY+Yo/t
 IQ3BdTtKZetXqF2P/QoV53KRQS3jspYC4qRT/MftNjSrRDHjGuqGRHPLQwFeWl6qewVw
 /Q9gzPxs8t/qqtfB3T6Uq5sfQp4Q0ydaUxsRTuWZGrVndJwChss+JBsu6Rm1toyxCSSF
 WNkZgWGysEemR0nBbsYuTBib2qcwXQ+qCKNXZsfS9S84iqtL2x2x8hGPC05cDZwQC8j/
 w5ot7Ec5KVWF4zk8mUeua85/dTygwdMlJu8XgDpFJI+EgdMA6mCvyT+CYSjB3HImIkJQ
 UDGQ==
X-Gm-Message-State: AOJu0Yzlf7M1repAYLeEqvzjww/EPrvHLyE3SwfPlAXoDUbovx0GOab9
 NmqkZiQcgq32qtg88ePYXyF1KVW9UveW6/38g/IgUgX7cXUaMCs4xtnKQA==
X-Google-Smtp-Source: AGHT+IFroAyZGr2Yu4FI0QuznNw8KSJC71P9j4Xno5MyQN0T4REq2InpO2FrIm06Ckk+SsHrqABH7g==
X-Received: by 2002:a05:6a21:339f:b0:1a9:a31a:1b67 with SMTP id
 yy31-20020a056a21339f00b001a9a31a1b67mr6142562pzb.47.1714045339674; 
 Thu, 25 Apr 2024 04:42:19 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:2ff7:384:8eb2:1cc1:dda:650a])
 by smtp.gmail.com with ESMTPSA id
 s27-20020a63525b000000b006008ee7e805sm6578791pgl.30.2024.04.25.04.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 04:42:19 -0700 (PDT)
From: Will Gyda <vilhelmgyda@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, quintela@redhat.com, jsnow@redhat.com,
 Will Gyda <vilhelmgyda@gmail.com>
Subject: [PATCH] migration/ram.c: API Conversion qemu_mutex_lock(),
 and qemu_mutex_unlock() to WITH_QEMU_LOCK_GUARD macro
Date: Thu, 25 Apr 2024 17:12:07 +0530
Message-Id: <20240425114207.54148-1-vilhelmgyda@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=vilhelmgyda@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

migration/ram.c: API Conversion qemu_mutex_lock(),
and qemu_mutex_unlock() to WITH_QEMU_LOCK_GUARD macro

Signed-off-by: Will Gyda <vilhelmgyda@gmail.com>
---
 migration/ram.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index a975c5af16..50df1e9cd2 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1066,14 +1066,14 @@ static void migration_bitmap_sync(RAMState *rs, bool last_stage)
     trace_migration_bitmap_sync_start();
     memory_global_dirty_log_sync(last_stage);
 
-    qemu_mutex_lock(&rs->bitmap_mutex);
-    WITH_RCU_READ_LOCK_GUARD() {
-        RAMBLOCK_FOREACH_NOT_IGNORED(block) {
-            ramblock_sync_dirty_bitmap(rs, block);
+    WITH_QEMU_LOCK_GUARD(&rs->bitmap_mutex) {
+        WITH_RCU_READ_LOCK_GUARD() {
+            RAMBLOCK_FOREACH_NOT_IGNORED(block) {
+                ramblock_sync_dirty_bitmap(rs, block);
+            }
+            stat64_set(&mig_stats.dirty_bytes_last_sync, ram_bytes_remaining());
         }
-        stat64_set(&mig_stats.dirty_bytes_last_sync, ram_bytes_remaining());
     }
-    qemu_mutex_unlock(&rs->bitmap_mutex);
 
     memory_global_after_dirty_log_sync();
     trace_migration_bitmap_sync_end(rs->num_dirty_pages_period);
-- 
2.25.1


