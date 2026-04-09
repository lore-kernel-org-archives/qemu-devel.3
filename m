Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C3FE9DE60
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 08:21:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAkby-0006bI-Ip; Thu, 09 Apr 2026 04:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wAjOI-00053q-Lk
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 03:01:29 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wAjOF-00076a-Vj
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 03:01:25 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488a29e6110so5246215e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 00:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minio.io; s=minio; t=1775718077; x=1776322877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JQ+g+Ftg9KxAdBMCWpE/RWEcneIVeaJ38egOZv8j5vc=;
 b=ri/Wtg3MbS+6LRc8MAL0PASj79xpj8U+l356sN74ruPgBzQc+8dKS39s7RIJiZC+gK
 g0S33MjisGeuwANM8OApBYnSoj+gy9+LvjzbaX4yEIIfnF/agI0q9gMe2Enm0cCNV+18
 ThFbYjnPFmp1Z+F5fnFt9ybvq5vYUyULdQMn3BcVPh74huncKwbrXpJ+3AsMIve8DLs8
 XBZiHzTGOtiyKeInI+H2lmeG1iYHbHdkOKw3DtD+0kKPCIIPDu4EWVhh12kubAvxYLbw
 KiyCt0MsdDdK2EI+atMZvHa13ITqA3EuJW0q18xUN+55J3DHJbLpIKme+ZxjTJ4W05RV
 cLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775718077; x=1776322877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JQ+g+Ftg9KxAdBMCWpE/RWEcneIVeaJ38egOZv8j5vc=;
 b=DnNiQcuo0FXfj8C7bNkZVNvwqRRs0CxvgL+6OA+SxihQgXU8qxURE6VmAVy0bHlGlg
 gz4P7taRIUPIybjoL36FHrQn6OTCCZ0HaCHBWXQ0qkVwWw7kcQjAhA6K+lT7OYBNbNuf
 B2n/zMJj/9/aFOdrPR9mBg/K9AvCYbYIkcsPMsqP+JFPBnTiM6u/Wb4CV1+LIcyZTY71
 gNfAjRe2pbi9rosgfF5Be80c6BEoPy8xw6T3TPieXH5GwlTQrJTbPmA++UJtF6TQL1Qq
 dbFlENtzCchaZ+Lv99+d9RccKM6levRfr44BpUS/VLsH8bYLTixYkGU2bCXcO9hRvN4l
 dPeA==
X-Gm-Message-State: AOJu0YzgHnklhw+SkqPXND1jlWQR55iyFdU2vwXPQLkpCtc34Og4TrXi
 86uOoPBR3WDrlHQXCj2t8/f0cBpzJTh54B3laIfrbhoDkVp1FD3WuWr7+TMm2S8e+vDTtVIREVm
 mU/+2xB6fDIipOAG1N+l97pWmgM7phQ7U5Sp48heBWmym7y2r8T9JUf58Cc9m9lmbUNtoej3hwu
 HuQ4S5Ga0FLZcwWr1jS4JBn8GtdC8FpXLtETrqBZk=
X-Gm-Gg: AeBDieuWe9kw7IJxdqVqZvSLazWdkBMcrmGXxBeNLczNacXwQnorNRi0qo65nsqSJTb
 xwOw2L1PA/A33v9lt21VcYPUcbO3tJQj5tq6mdfQGURclzdh3S6AbkwsXTtzI1lGSzLDu/SkRW/
 jXvdPoD2CHurC3mp766YJ7+r3i3KD0OTg06l2osiLfnmD+549d0yyA8gVst8S9gi+8Nmaz5QykI
 gSZHMIWXFBxcZP5ti2kXB/DFhNvRL1tjn+Rm+knuCiqcaErdFn37KT+qHulU6I/QxNpGq4dVSYc
 V2AfWpylOu4LJ/W9PuSJwISMsajykqPEhVYD+m//aXwlCWOIJHBG3G0MytszCdDymDRWioWQNDA
 zwLW6ve7nF4BYSx6cgFUjV4ytazsojjdqipZ1pkVwjUZdRiZxWNVSJb5FJRUQeSmNh+qhLzh7C1
 4jruNPs2e1xZeZx0zbBijjs/2bBP6GHgS9k0z1XO4qFhCI6Vc63gOQw4ZXCNpjixNEdDnbGNbG3
 kcmNnxBJ0UjSXvSg5xjT0JEb5vlaK49eY736XOymDbjK0f+nm7/7213OfELbw==
X-Received: by 2002:a05:600c:8b32:b0:487:1c2:6a56 with SMTP id
 5b1f17b1804b1-488996afe1cmr324125805e9.3.1775718076834; 
 Thu, 09 Apr 2026 00:01:16 -0700 (PDT)
Received: from localhost (2a01cb00141148004df9ec80d3fa1cac.ipv6.abo.wanadoo.fr.
 [2a01:cb00:1411:4800:4df9:ec80:d3fa:1cac])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-43d1e4d2971sm63964653f8f.22.2026.04.09.00.01.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 00:01:16 -0700 (PDT)
From: mr-083 <matthieu@minio.io>
X-Google-Original-From: mr-083 <matthieu@min.io>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: its@irrelevant.dk, kbusch@kernel.org, stefanha@redhat.com,
 mr-083 <matthieu@min.io>
Subject: [PATCH 2/2] block/monitor: add drive_insert HMP command
Date: Thu,  9 Apr 2026 09:01:11 +0200
Message-ID: <20260409070114.11313-3-matthieu@min.io>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409070114.11313-1-matthieu@min.io>
References: <20260409070114.11313-1-matthieu@min.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=matthieu@minio.io; helo=mail-wm1-x330.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HK_NAME_MR_MRS=0.998,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 09 Apr 2026 04:19:30 -0400
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

Add a drive_insert HMP command that reconnects a host block device file
to an existing guest device whose backing store was previously removed
with drive_del.

After drive_del, the BlockBackend remains attached to the guest device
but has no BlockDriverState (shown as "[not inserted]" in info block).
drive_insert opens the specified file, finds the device's BlockBackend
by iterating all backends and matching the attached device ID, then
calls blk_insert_bs() to reconnect the backing store.

This complements drive_del for non-removable devices (such as NVMe
namespaces) where blockdev-change-medium cannot be used. Combined with
PCIe AER Surprise Down error injection to trigger a controller reset,
this enables complete NVMe disk hot-swap simulation where the guest
sees the same device names throughout.

Example usage:
  drive_del drv0             # remove backing store
  drive_insert ns0 disk.qcow2  # reconnect backing
  pcie_aer_inject_error rp0 SDN  # trigger controller reset

Signed-off-by: Matthieu Receveur <matthieu@min.io>
---
 block/monitor/block-hmp-cmds.c | 59 ++++++++++++++++++++++++++++++++++
 hmp-commands.hx                | 18 +++++++++++
 include/block/block-hmp-cmds.h |  1 +
 3 files changed, 78 insertions(+)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 1fd28d59eb..77e9662ead 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -38,7 +38,9 @@
 #include "qemu/osdep.h"
 #include "hw/core/boards.h"
 #include "system/block-backend.h"
+#include "system/block-backend-global-state.h"
 #include "system/blockdev.h"
+#include "block/block-global-state.h"
 #include "qapi/qapi-commands-block.h"
 #include "qapi/qapi-commands-block-export.h"
 #include "qobject/qdict.h"
@@ -195,6 +197,63 @@ unlock:
     hmp_handle_error(mon, err);
 }
 
+void hmp_drive_insert(Monitor *mon, const QDict *qdict)
+{
+    const char *id = qdict_get_str(qdict, "id");
+    const char *filename = qdict_get_str(qdict, "filename");
+    BlockBackend *blk = NULL;
+    BlockBackend *iter;
+    BlockDriverState *bs;
+    Error *err = NULL;
+
+    GLOBAL_STATE_CODE();
+
+    /*
+     * After drive_del, the BlockBackend is removed from the monitor name
+     * registry but still attached to the device. Find it by iterating all
+     * BlockBackends and matching by the device ID shown in "info block".
+     */
+    for (iter = blk_all_next(NULL); iter; iter = blk_all_next(iter)) {
+        DeviceState *dev = blk_get_attached_dev(iter);
+        if (dev && dev->id && strcmp(dev->id, id) == 0) {
+            blk = iter;
+            break;
+        }
+    }
+
+    if (!blk) {
+        /* Fallback: try by block backend name */
+        blk = blk_by_name(id);
+    }
+
+    if (!blk) {
+        error_setg(&err, "Device '%s' not found", id);
+        goto out;
+    }
+
+    if (blk_bs(blk)) {
+        error_setg(&err, "Device '%s' already has a medium inserted", id);
+        goto out;
+    }
+
+    bs = bdrv_open(filename, NULL, NULL, BDRV_O_RDWR, &err);
+    if (!bs) {
+        goto out;
+    }
+
+    if (blk_insert_bs(blk, bs, &err) < 0) {
+        bdrv_unref(bs);
+        goto out;
+    }
+
+    bdrv_unref(bs);
+    monitor_printf(mon, "OK\n");
+    return;
+
+out:
+    hmp_handle_error(mon, err);
+}
+
 void hmp_commit(Monitor *mon, const QDict *qdict)
 {
     const char *device = qdict_get_str(qdict, "device");
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 5cc4788f12..79af8e8988 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -207,6 +207,24 @@ SRST
   actions (drive options rerror, werror).
 ERST
 
+    {
+        .name       = "drive_insert",
+        .args_type  = "id:B,filename:F",
+        .params     = "device filename",
+        .help       = "insert a host block device into an empty drive",
+        .cmd        = hmp_drive_insert,
+    },
+
+SRST
+``drive_insert`` *device* *filename*
+  Insert a host block device file into a drive that has been emptied by
+  ``drive_del``.  This reconnects the backing store without removing the
+  guest device, enabling transparent disk hot-swap for non-removable devices
+  such as NVMe namespaces.  Combined with PCIe AER Surprise Down error
+  injection (``pcie_aer_inject_error`` *device* ``SDN``), this enables
+  complete NVMe disk hot-swap simulation.
+ERST
+
     {
         .name       = "change",
         .args_type  = "device:B,force:-f,target:F,arg:s?,read-only-mode:s?",
diff --git a/include/block/block-hmp-cmds.h b/include/block/block-hmp-cmds.h
index 71113cd7ef..73c9607402 100644
--- a/include/block/block-hmp-cmds.h
+++ b/include/block/block-hmp-cmds.h
@@ -21,6 +21,7 @@ void hmp_drive_add(Monitor *mon, const QDict *qdict);
 
 void hmp_commit(Monitor *mon, const QDict *qdict);
 void hmp_drive_del(Monitor *mon, const QDict *qdict);
+void hmp_drive_insert(Monitor *mon, const QDict *qdict);
 
 void hmp_drive_mirror(Monitor *mon, const QDict *qdict);
 void hmp_drive_backup(Monitor *mon, const QDict *qdict);
-- 
2.50.1 (Apple Git-155)


