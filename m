Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8243F8D765
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 17:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDQxl-0004XC-KK; Thu, 16 Apr 2026 13:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1wDQxj-0004Wb-FZ
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 13:57:11 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1wDQxh-0006hq-Ai
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 13:57:11 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2b25cf1b5f0so55095015ad.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 10:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776362228; x=1776967028; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kBFInjrJF2j/zE2Lb7WPQPedUT1UUv3ujUW7DIa2cWA=;
 b=RfUadpYwuqpBFOaOJdy7vVjs+YdtOX1DhU2vvbXlt87r0ZyBbmv4fXVoA052JxRGxT
 dWQHwq2g/az1Fjv4JTr+5pL5HooEwhwe7fVGVFzI/O4jrqXauTkO/N+HH+oj+cg171g7
 QvMdCKihciSdQmGoYn/KJZ5AB/LWjSD21EBgANiwamtkCS8TwCutBK5UCuyJu3jOU4oS
 7calf5mfBr5pZotJGfm9u2c2XZipBB2x9doz+MO6mLC8qHtu0kHDZOmVm/bkj+EGmUFE
 ncgyS3umEB38YYoUj9C/Tx8oEmhzvHPthREmSbEeAdSXM+GdAtv9wgm2QXiJHXqVvnxA
 M0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776362228; x=1776967028;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kBFInjrJF2j/zE2Lb7WPQPedUT1UUv3ujUW7DIa2cWA=;
 b=R0DIu6fscuiwHL64ncmhp1m3HI0uEKhGIE0cnHGJruvHb0ueLlsYtC974aYqb/7rND
 iE8fo7aSgPOcUBK3K34rGm61JTz5tq+7VVITSQHE8zS//bLAPQHm0fUrm+l5NCblrhzi
 f6rq2oOiwmrBwN8CgMKN8D8ztYPvlu2d+lvcC6c8MohRIBvCwJ94fb0YMXU6cpM+LJy/
 m5TaBLcQiSlg8alElW4L/0JKaXshAYoRTPfpxnwE2O78xzbghBphMdC8ZGXZKDNgU/d2
 MuMJ/Q+szXzLrOjQeNF1GJHMRowq/5LPPMYvDlxn/nXXn4fQrWFMaOC49RRt2k347dfP
 iMbw==
X-Gm-Message-State: AOJu0YwCjNPc5+e2ZFmwl/fxnHX84dw925PpuRgaOwV6aQX0n2OtRLHE
 mTkx1ZJO6mEtrwsxg6Db02oaeHxpxeiiq129B5wGBnoEM1aFcjyRD2M47Y/Ue53J
X-Gm-Gg: AeBDiev6QnIclR7hTkd+3oMVGbpAYjzA06Lpxpuy4dgjLI8iOwXWEe+2CDWQ2QzoQqz
 NVbqeEBdPlIz1nLsoWhjRzDoPUzFp3FFoiOviaJg9ugEtawYqoHlv7DxVntIB2JSVYZo0gjaEtJ
 9Ju/xJCGUHiqAcLRc1Z43LefAynCg3vWt/WxX0RK3vvuuYxrEFulPCKtVd4v9I4jrxhdA8BCjHY
 NZgORr9Wi3tntiOL/E+7pnHFDgCt0xaBGI34VmTu0on/TO6kAiZwH/53vNevXwRgbBY6LPxzLjW
 9qXWH9BuFW6d46FxrFKsmSIaSAHl8aRRhgKymUfFTfIbNjByqHcN1PhVhdzBpZeIMW4T2GdsTLV
 iiHh2yIFBJyOh2GLj8tSplKbBdYKoSQlVHTypafYQwQanKYTAe3YynbuY10ONAhRS5pKcoDgASi
 ftcfLd3QRLQcI3rOQJj7gYMjXKqoOnQ/5YiL/scmipGPZlE+ydB1DVE2E58w==
X-Received: by 2002:a17:903:f84:b0:2b2:596d:594 with SMTP id
 d9443c01a7336-2b2d59619a5mr259362895ad.13.1776362227395; 
 Thu, 16 Apr 2026 10:57:07 -0700 (PDT)
Received: from localhost.localdomain ([42.114.219.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b47810b898sm59435405ad.25.2026.04.16.10.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 10:57:07 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
X-Google-Original-From: Trieu Huynh <viking4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH] migration: expose per-device state save times via
 query-migrate
Date: Fri, 17 Apr 2026 00:56:59 +0700
Message-ID: <20260416175659.41215-1-viking4@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=vikingtc4@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Trieu Huynh <vikingtc4@gmail.com>

The stop-and-copy phase pauses the VM and saves all non-iterable device
states. qemu_savevm_state_non_iterable() already measures per-device
elapsed time for tracing (trace_vmstate_downtime_save, added in
commit 3c80f14272), but this information is never stored or surfaced
to somewhere.

Expose the result through a new 'device-state-times' list in
MigrationInfo, filled by qemu_savevm_get_device_state_times() helper
and returned by query-migrate when status is completed.

A new QAPI type is introduced:
DeviceSaveStateTime { 'name': 'str', 'instance-id': 'int', 'save-time': 'int' }
where 'save-time' is the elapsed time in microseconds.

This allows operators and tooling to identify which device(s) are
contributing most to migration downtime.

Related prior work: Joao Martins posted a phase-level downtime
breakdown series in 2023 [1] that stalled during review. This patch
takes a complementary approach with per-device rather than per-phase
granularity, building on the tracepoint infrastructure that was merged
from that discussion.

* As-is:
{"execute":"query-migrate"}
{
  "return": {
    "expected-downtime": 300,
    "status": "active",
    "setup-time": 1,
    "total-time": 25501,
    "ram": {
      "total": 8607571968,
      "postcopy-requests": 0,
      "dirty-sync-count": 1,
      "multifd-bytes": 0,
      "pages-per-second": 32960,
      "downtime-bytes": 0,
      "page-size": 4096,
      "remaining": 2027167744,
      "postcopy-bytes": 0,
      "mbps": 1082.1441599999998,
      "transferred": 3409746788,
      "dirty-sync-missed-zero-copy": 0,
      "precopy-bytes": 3409871158,
      "duplicate": 777383,
      "dirty-pages-rate": 0,
      "normal-bytes": 3396239360,
      "normal": 829160
    }
  }
}

* To-be:
{"execute":"query-migrate"}
{
  "return": {
    "device-state-times": [
      {
        "name": "apic",
        "instance-id": 0,
        "save-time": 35
      },
      {
        "name": "cpu_common",
        "instance-id": 0,
        "save-time": 4
      },
      {
        "name": "cpu",
        "instance-id": 0,
        "save-time": 145
      },

      ...

      {
        "name": "kvm-tpr-opt",
        "instance-id": 0,
        "save-time": 23
      },
      {
        "name": "0000:00:00.0/I440FX",
        "instance-id": 0,
        "save-time": 9
      },
      {
        "name": "PCIHost",
        "instance-id": 0,
        "save-time": 3
      },
      {
        "name": "PCIBUS",
        "instance-id": 0,
        "save-time": 4
      },
    ],
    "status": "completed",
    "setup-time": 1,
    "downtime": 42,
    "total-time": 36049,
    "ram": {
      "total": 8607571968,
      "postcopy-requests": 0,
      "dirty-sync-count": 5,
      "multifd-bytes": 0,
      "pages-per-second": 32980,
      "downtime-bytes": 39224358,
      "page-size": 4096,
      "remaining": 0,
      "postcopy-bytes": 0,
      "mbps": 1080.48687394585,
      "transferred": 4868673854,
      "dirty-sync-missed-zero-copy": 0,
      "precopy-bytes": 4829122945,
      "duplicate": 1032714,
      "dirty-pages-rate": 0,
      "normal-bytes": 4849577984,
      "normal": 1183979
    }
  }
}

[1] https://lore.kernel.org/qemu-devel/20230926161841.98464-1-joao.m.martins@oracle.com/
Related-to: https://wiki.qemu.org/ToDo/LiveMigration#Device_state_downtime_analysis_and_accountings

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 migration/migration.c |  1 +
 migration/savevm.c    | 29 +++++++++++++++++++++++++++++
 migration/savevm.h    |  3 +++
 qapi/migration.json   | 26 +++++++++++++++++++++++++-
 4 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 5c9aaa6e58..61bd98dc84 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1161,6 +1161,7 @@ static void fill_source_migration_info(MigrationInfo *info)
         populate_time_info(info, s);
         populate_ram_info(info, s);
         migration_populate_vfio_info(info);
+        qemu_savevm_get_device_state_times(info);
         break;
     case MIGRATION_STATUS_FAILED:
         info->has_status = true;
diff --git a/migration/savevm.c b/migration/savevm.c
index dd58f2a705..3b1c4ff4a7 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -46,6 +46,7 @@
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/qapi-builtin-visit.h"
+#include "qapi/qapi-visit-migration.h"
 #include "qemu/error-report.h"
 #include "system/cpus.h"
 #include "system/memory.h"
@@ -263,6 +264,9 @@ typedef struct SaveState {
     QemuUUID uuid;
 } SaveState;
 
+/* Per-device save times recorded */
+static DeviceSaveStateTimeList *savevm_device_state_times;
+
 static SaveState savevm_state = {
     .handlers = QTAILQ_HEAD_INITIALIZER(savevm_state.handlers),
     .handler_pri_head = { [0 ... MIG_PRI_MAX] = NULL },
@@ -1710,11 +1714,18 @@ int qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp)
     int64_t start_ts_each, end_ts_each;
     JSONWriter *vmdesc = ms->vmdesc;
     SaveStateEntry *se;
+    DeviceSaveStateTimeList **tail;
+    int64_t save_time;
     int ret;
 
     /* Making sure cpu states are synchronized before saving non-iterable */
     cpu_synchronize_all_states();
 
+    /* Reset list from any previous migration run */
+    qapi_free_DeviceSaveStateTimeList(savevm_device_state_times);
+    savevm_device_state_times = NULL;
+    tail = &savevm_device_state_times;
+
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (se->vmsd && se->vmsd->early_setup) {
             /* Already saved during qemu_savevm_state_setup(). */
@@ -1731,6 +1742,14 @@ int qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp)
         end_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
         trace_vmstate_downtime_save("non-iterable", se->idstr, se->instance_id,
                                     end_ts_each - start_ts_each);
+        save_time = end_ts_each - start_ts_each;
+        if (se->vmsd && save_time > 0) {
+            DeviceSaveStateTime *dsst = g_new0(DeviceSaveStateTime, 1);
+            dsst->name = g_strdup(se->idstr);
+            dsst->instance_id = se->instance_id;
+            dsst->save_time = save_time;
+            QAPI_LIST_APPEND(tail, dsst);
+        }
     }
 
     trace_vmstate_downtime_checkpoint("src-non-iterable-saved");
@@ -3177,6 +3196,16 @@ bool qemu_loadvm_load_state_buffer(const char *idstr, uint32_t instance_id,
     return se->ops->load_state_buffer(se->opaque, buf, len, errp);
 }
 
+void qemu_savevm_get_device_state_times(MigrationInfo *info)
+{
+    if (!savevm_device_state_times) {
+        return;
+    }
+    info->device_state_times = QAPI_CLONE(DeviceSaveStateTimeList,
+                                          savevm_device_state_times);
+    info->has_device_state_times = true;
+}
+
 bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
                   bool has_devices, strList *devices, Error **errp)
 {
diff --git a/migration/savevm.h b/migration/savevm.h
index b3d1e8a13c..a18af7eaed 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -14,6 +14,8 @@
 #ifndef MIGRATION_SAVEVM_H
 #define MIGRATION_SAVEVM_H
 
+#include "qapi/qapi-types-migration.h"
+
 #define QEMU_VM_FILE_MAGIC           0x5145564d
 #define QEMU_VM_FILE_VERSION_COMPAT  0x00000002
 #define QEMU_VM_FILE_VERSION         0x00000003
@@ -78,5 +80,6 @@ int qemu_savevm_state_non_iterable_early(QEMUFile *f,
                                          Error **errp);
 bool qemu_loadvm_load_state_buffer(const char *idstr, uint32_t instance_id,
                                    char *buf, size_t len, Error **errp);
+void qemu_savevm_get_device_state_times(MigrationInfo *info);
 
 #endif
diff --git a/qapi/migration.json b/qapi/migration.json
index 7134d4ce47..17c7876392 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -200,6 +200,23 @@
 { 'struct': 'VfioStats',
   'data': {'transferred': 'int' } }
 
+##
+# @DeviceSaveStateTime:
+#
+# Save time information for a single device's state during migration.
+#
+# @name: device name as registered in the migration stream
+#
+# @instance-id: device instance ID
+#
+# @save-time: time in microseconds spent saving this device's state
+#     during the stop-and-copy phase
+#
+# Since: 10.2
+##
+{ 'struct': 'DeviceSaveStateTime',
+  'data': { 'name': 'str', 'instance-id': 'uint32', 'save-time': 'uint64' } }
+
 ##
 # @MigrationInfo:
 #
@@ -300,6 +317,12 @@
 #     average memory load of the virtual CPU indirectly.  Note that
 #     zero means guest doesn't dirty memory.  (Since 8.1)
 #
+# @device-state-times: list of per-device state save times recorded
+#     during the stop-and-copy phase.  Only present after a completed
+#     migration.  Entries with zero save time are omitted.  Useful for
+#     diagnosing which devices contribute most to migration downtime.
+#     (Since 10.2)
+#
 # Features:
 #
 # @unstable: Members @postcopy-latency, @postcopy-vcpu-latency,
@@ -331,7 +354,8 @@
                'type': 'uint64', 'features': [ 'unstable' ] },
            '*socket-address': ['SocketAddress'],
            '*dirty-limit-throttle-time-per-round': 'uint64',
-           '*dirty-limit-ring-full-time': 'uint64'} }
+           '*dirty-limit-ring-full-time': 'uint64',
+           '*device-state-times': ['DeviceSaveStateTime']} }
 
 ##
 # @query-migrate:
-- 
2.43.0


