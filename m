Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61892C98304
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96xc-0003lH-Nl; Tue, 22 Sep 2026 16:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96xY-0003e6-Le
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:19:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96xV-00080o-9J
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1LK+1iYM3EVcRmDWxxwQd6hqG6qpIuWRBAQPvCkDbqY=;
 b=An+DvR4GE3x7AmH3BjrcVHMyjPNYq6qL71mEf5F/wyM8jEAyciCIHHWu1whuElY1mBKK7u
 U+2NmAj5oBe3Lfs4I5bQggps7w+LMpJxGHJNvgR8KI2oBqR0W2NjNMXKl+aeQV8Rqrd5cX
 vqmRcOfE2Rl9l0Q4vNcg1R6qwhkDiwI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-1blJMFq7Ok-ckmHNUuWsJg-1; Tue,
 22 Sep 2026 16:19:17 -0400
X-MC-Unique: 1blJMFq7Ok-ckmHNUuWsJg-1
X-Mimecast-MFC-AGG-ID: 1blJMFq7Ok-ckmHNUuWsJg_1790108355
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B800A1955F2F; Tue, 22 Sep 2026 20:19:13 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F1F501956095; Tue, 22 Sep 2026 20:19:10 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:09 +0400
Subject: [PATCH 02/88] build-sys: bump minimum glib version to v2.68
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-2-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Alexandre Iooss <erdnaxe@crans.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Stefan Weil <sw@weilnetz.de>, 
 Jason Wang <jasowangio@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Fam Zheng <fam@euphon.net>, Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Chao Liu <chao.liu@processmission.com>, Peter Xu <peterx@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=19711;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=EXLyyH7deMN1AQFmJ94dFqhJDdC3zkdv7UwNTAYmLgM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKuI9Zm/EGrub9mMBn9LZ1h2jfhrTecJdb2h
 H9iQusyfQKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLirgAKCRDa6OEJdZac
 5ZPqEACE1h4Le2sMNvIasZ4jpueaAs66zaEge5BFEQxIkNYGhyF9pLL7rmgHmqwoyWYOuuCf4VT
 2WSAD12tK5yZQeGtJ0ockMrLltLu4ApRb0qxujPsfvzUirZpMM6GEQ3/ipR72Rsy1twYYV9D0U1
 8nN3gRccb27ftfu5uJouIZxxYzXhSJUeToiyKQBhIbE3lJcNEPu58Xb8WCVmDrnKpeAfotZUMY8
 3Svx93EjXXtKyFIXYkUCc0QYwjFIbsttzuhmZoPIHL7wpA80Lw1btIwL4BPBw7L5Grx/TugOs0g
 0vkDM7HyNnsTwWHLasaS4JuLNs2D7X0N3XVaJdV8eS82t+6arbv9oTus0D5ZZ/nlHtDT8OYgF+m
 1nPa3Li6R4rDrSVbpjfvT7of2dQK6wHbdG9EEGXZm9BWMabBsu80hPUFuHtZQ+ZbgBGOGxhMDgf
 CaCquUhDe3spy2Q864+XK6uZ9qxp1fLDqBLX3+Tsn7DJ7aViusdjsMAkzLcJGKpziOfRiEl1adb
 BeGT1WQb2eNyYARqn5wkDupRtjcrJeUX8LEO9lI0QF0ptSeX05QhSv6B/fL0BEsFfQ+SQNvTpaB
 3T8hrV6Nq46YJFPdPVeUMj71ej0UKfzDEjNN8sNX9YUyhwNotLi3C11sPiGWnvI6IWtOhchFD4j
 knM17s6vX5YK/Vg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

CentOS Stream 9 bumped glib to 2.68, according to repology,
this is the floor version:

centos_stream_9        9       2.68.4
debian_12              12      2.74.6
fedora_43              43      2.86.5
freebsd                15.1    2.88.3
openbsd                7.8     2.88.3
opensuse_leap_15_6     15.6    2.78.6
ubuntu_24_04           24.04   2.80.0
homebrew               rolling 2.90.0
msys2_mingw            rolling 2.90.0

2.68 brings g_memdup2() for which we had a compat, but also has
GStrvBuilder, g_string_replace(), g_test_get_path() among other nice API
additions.

Replace deprecate g_memdup() usage, and checkpatch check is now
redundant with compile-time deprecation error.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 accel/tcg/cputlb.c         |  4 ++--
 contrib/plugins/lockstep.c | 25 -------------------------
 hw/9pfs/9p-synth.c         |  2 +-
 hw/9pfs/9p-util.h          |  2 +-
 hw/9pfs/9p.c               |  2 +-
 hw/acpi/core.c             |  2 +-
 hw/core/machine.c          |  2 +-
 hw/i386/multiboot.c        |  2 +-
 hw/net/eepro100.c          |  2 +-
 hw/nvram/fw_cfg.c          |  8 ++++----
 hw/scsi/mptsas.c           |  5 +++--
 hw/vfio/pci.c              |  2 +-
 include/glib-compat.h      | 41 ++---------------------------------------
 linux-user/syscall.c       |  2 +-
 linux-user/uaccess.c       |  2 +-
 meson.build                |  2 +-
 net/colo.c                 |  4 ++--
 qapi/qapi-clone-visitor.c  | 16 ++++++++--------
 qapi/qapi-visit-core.c     |  6 ++++--
 scripts/checkpatch.pl      |  5 -----
 system/memory.c            |  2 +-
 system/vl.c                |  2 +-
 22 files changed, 38 insertions(+), 102 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 7f7c208ba121..a91bd167cf8a 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -833,13 +833,13 @@ void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
     /* Allocate a separate data block for each destination cpu.  */
     CPU_FOREACH(dst_cpu) {
         if (dst_cpu != src_cpu) {
-            p = g_memdup(&d, sizeof(d));
+            p = g_memdup2(&d, sizeof(d));
             async_run_on_cpu(dst_cpu, tlb_flush_range_by_mmuidx_async_1,
                              RUN_ON_CPU_HOST_PTR(p));
         }
     }
 
-    p = g_memdup(&d, sizeof(d));
+    p = g_memdup2(&d, sizeof(d));
     async_safe_run_on_cpu(src_cpu, tlb_flush_range_by_mmuidx_async_1,
                           RUN_ON_CPU_HOST_PTR(p));
 }
diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index ed9d18460fe3..a92658f0115b 100644
--- a/contrib/plugins/lockstep.c
+++ b/contrib/plugins/lockstep.c
@@ -101,31 +101,6 @@ static void plugin_exit(void *p)
     plugin_cleanup(NULL);
 }
 
-/*
- * g_memdup has been deprecated in Glib since 2.68 and
- * will complain about it if you try to use it. However until
- * glib_req_ver for QEMU is bumped we make a copy of the glib-compat
- * handler.
- */
-static inline gpointer g_memdup2_qemu(gconstpointer mem, gsize byte_size)
-{
-#if GLIB_CHECK_VERSION(2, 68, 0)
-    return g_memdup2(mem, byte_size);
-#else
-    gpointer new_mem;
-
-    if (mem && byte_size != 0) {
-        new_mem = g_malloc(byte_size);
-        memcpy(new_mem, mem, byte_size);
-    } else {
-        new_mem = NULL;
-    }
-
-    return new_mem;
-#endif
-}
-#define g_memdup2(m, s) g_memdup2_qemu(m, s)
-
 static void report_divergance(ExecState *us, ExecState *them)
 {
     DivergeState divrec = { log, 0 };
diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index 3b3654b2820b..225bb43d8a9b 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -525,7 +525,7 @@ static int synth_name_to_path(FsContext *ctx, V9fsPath *dir_path,
 out:
     /* Copy the node pointer to fid */
     g_free(target->data);
-    target->data = g_memdup(&node, sizeof(void *));
+    target->data = g_memdup2(&node, sizeof(void *));
     target->size = sizeof(void *);
     return 0;
 }
diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
index 8dfa803dc2c0..68bc33eeeb72 100644
--- a/hw/9pfs/9p-util.h
+++ b/hw/9pfs/9p-util.h
@@ -265,7 +265,7 @@ static inline struct dirent *qemu_dirent_dup(struct dirent *dent)
         sz = offsetof(struct dirent, d_name) +
                       strlen(dent->d_name) + 1;
     }
-    return g_memdup(dent, sz);
+    return g_memdup2(dent, sz);
 }
 
 /*
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 4764d9db13b1..ffb43993c7a3 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -229,7 +229,7 @@ void v9fs_path_copy(V9fsPath *dst, const V9fsPath *src)
 {
     v9fs_path_free(dst);
     dst->size = src->size;
-    dst->data = g_memdup(src->data, src->size);
+    dst->data = g_memdup2(src->data, src->size);
 }
 
 int v9fs_name_to_path(V9fsState *s, V9fsPath *dirpath,
diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index a6a62a742d11..3de7bbd6c6d9 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -647,7 +647,7 @@ void acpi_pm1_cnt_init(ACPIREGS *ar, MemoryRegion *parent,
         suspend[3] = 1 | ((!disable_s3) << 7);
         suspend[4] = s4_val | ((!disable_s4) << 7);
 
-        fw_cfg_add_file(fw_cfg, "etc/system-states", g_memdup(suspend, 6), 6);
+        fw_cfg_add_file(fw_cfg, "etc/system-states", g_memdup2(suspend, 6), 6);
     }
 }
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 92f7be52a13f..c99b7ade2161 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -739,7 +739,7 @@ HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machine)
 
         cpu_item->type = g_strdup(machine->possible_cpus->cpus[i].type);
         cpu_item->vcpus_count = machine->possible_cpus->cpus[i].vcpus_count;
-        cpu_item->props = g_memdup(&machine->possible_cpus->cpus[i].props,
+        cpu_item->props = g_memdup2(&machine->possible_cpus->cpus[i].props,
                                    sizeof(*cpu_item->props));
 
         cpu = machine->possible_cpus->cpus[i].cpu;
diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index d544b62afbd5..a59a59338975 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -387,7 +387,7 @@ int load_multiboot(X86MachineState *x86ms,
     mb_debug("           mb_mods_count = %d", mbs.mb_mods_count);
 
     /* save bootinfo off the stack */
-    mb_bootinfo_data = g_memdup(bootinfo, sizeof(bootinfo));
+    mb_bootinfo_data = g_memdup2(bootinfo, sizeof(bootinfo));
 
     /* Pass variables to option rom */
     fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ENTRY, mh_entry_addr);
diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index aaa3eb60f8ab..cbf9e400f3ec 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -1883,7 +1883,7 @@ static void e100_nic_realize(PCIDevice *pci_dev, Error **errp)
 
     qemu_register_reset(nic_reset, s);
 
-    s->vmstate = g_memdup(&vmstate_eepro100, sizeof(vmstate_eepro100));
+    s->vmstate = g_memdup2(&vmstate_eepro100, sizeof(vmstate_eepro100));
     s->vmstate->name = qemu_get_queue(s->nic)->model;
     vmstate_register_any(VMSTATE_IF(&pci_dev->qdev), s->vmstate, s);
 }
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index b057d870c004..62102f6cf3fc 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -197,7 +197,7 @@ static void fw_cfg_bootsplash(FWCfgState *s)
         /* use little endian format */
         bst_le16 = cpu_to_le16(bst_val);
         fw_cfg_add_file(s, "etc/boot-menu-wait",
-                        g_memdup(&bst_le16, sizeof bst_le16), sizeof bst_le16);
+                        g_memdup2(&bst_le16, sizeof bst_le16), sizeof bst_le16);
     }
 
     /* insert splash file if user configurated */
@@ -247,7 +247,7 @@ static void fw_cfg_reboot(FWCfgState *s)
     }
 
     rt_le32 = cpu_to_le32(rt_val);
-    fw_cfg_add_file(s, "etc/boot-fail-wait", g_memdup(&rt_le32, 4), 4);
+    fw_cfg_add_file(s, "etc/boot-fail-wait", g_memdup2(&rt_le32, 4), 4);
 }
 
 static void fw_cfg_write(FWCfgState *s, uint8_t value)
@@ -745,7 +745,7 @@ void fw_cfg_add_string(FWCfgState *s, uint16_t key, const char *value)
     size_t sz = strlen(value) + 1;
 
     trace_fw_cfg_add_string(key, trace_key_name(key), value);
-    fw_cfg_add_bytes(s, key, g_memdup(value, sz), sz);
+    fw_cfg_add_bytes(s, key, g_memdup2(value, sz), sz);
 }
 
 void fw_cfg_modify_string(FWCfgState *s, uint16_t key, const char *value)
@@ -753,7 +753,7 @@ void fw_cfg_modify_string(FWCfgState *s, uint16_t key, const char *value)
     size_t sz = strlen(value) + 1;
     char *old;
 
-    old = fw_cfg_modify_bytes_read(s, key, g_memdup(value, sz), sz);
+    old = fw_cfg_modify_bytes_read(s, key, g_memdup2(value, sz), sz);
     g_free(old);
 }
 
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index 5df124c0ce50..fef94ae28bb9 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -458,7 +458,8 @@ static void mptsas_process_scsi_task_mgmt(MPTSASState *s, MPIMsgSCSITaskMgmt *re
             } else {
                 MPTSASCancelNotifier *notifier;
 
-                reply_async = g_memdup(&reply, sizeof(MPIMsgSCSITaskMgmtReply));
+                reply_async = g_memdup2(&reply,
+                                       sizeof(MPIMsgSCSITaskMgmtReply));
                 reply_async->IOCLogInfo = INT_MAX;
 
                 count = 1;
@@ -485,7 +486,7 @@ static void mptsas_process_scsi_task_mgmt(MPTSASState *s, MPIMsgSCSITaskMgmt *re
             goto out;
         }
 
-        reply_async = g_memdup(&reply, sizeof(MPIMsgSCSITaskMgmtReply));
+        reply_async = g_memdup2(&reply, sizeof(MPIMsgSCSITaskMgmtReply));
         reply_async->IOCLogInfo = INT_MAX;
 
         count = 0;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 428ab2f06983..1a0dddbd8d94 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2646,7 +2646,7 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev, bool ats_needed)
      * physical device, we cache the config space to avoid overwriting
      * the original config space when we parse the extended capabilities.
      */
-    config = g_memdup(pdev->config, vdev->config_size);
+    config = g_memdup2(pdev->config, vdev->config_size);
 
     /*
      * Extended capabilities are chained with each pointing to the next, so we
diff --git a/include/glib-compat.h b/include/glib-compat.h
index 32ee2afdcdf5..1be08ab2764b 100644
--- a/include/glib-compat.h
+++ b/include/glib-compat.h
@@ -19,12 +19,12 @@
 /* Ask for warnings for anything that was marked deprecated in
  * the defined version, or before. It is a candidate for rewrite.
  */
-#define GLIB_VERSION_MIN_REQUIRED GLIB_VERSION_2_66
+#define GLIB_VERSION_MIN_REQUIRED GLIB_VERSION_2_68
 
 /* Ask for warnings if code tries to use function that did not
  * exist in the defined version. These risk breaking builds
  */
-#define GLIB_VERSION_MAX_ALLOWED GLIB_VERSION_2_66
+#define GLIB_VERSION_MAX_ALLOWED GLIB_VERSION_2_68
 
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wdeprecated-declarations"
@@ -76,43 +76,6 @@
  * without generating warnings.
  */
 
-/*
- * g_memdup2_qemu:
- * @mem: (nullable): the memory to copy.
- * @byte_size: the number of bytes to copy.
- *
- * Allocates @byte_size bytes of memory, and copies @byte_size bytes into it
- * from @mem. If @mem is %NULL it returns %NULL.
- *
- * This replaces g_memdup(), which was prone to integer overflows when
- * converting the argument from a #gsize to a #guint.
- *
- * This static inline version is a backport of the new public API from
- * GLib 2.68, kept internal to GLib for backport to older stable releases.
- * See https://gitlab.gnome.org/GNOME/glib/-/issues/2319.
- *
- * Returns: (nullable): a pointer to the newly-allocated copy of the memory,
- *          or %NULL if @mem is %NULL.
- */
-static inline gpointer g_memdup2_qemu(gconstpointer mem, gsize byte_size)
-{
-#if GLIB_CHECK_VERSION(2, 68, 0)
-    return g_memdup2(mem, byte_size);
-#else
-    gpointer new_mem;
-
-    if (mem && byte_size != 0) {
-        new_mem = g_malloc(byte_size);
-        memcpy(new_mem, mem, byte_size);
-    } else {
-        new_mem = NULL;
-    }
-
-    return new_mem;
-#endif
-}
-#define g_memdup2(m, s) g_memdup2_qemu(m, s)
-
 static inline bool
 qemu_g_test_slow(void)
 {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9f454502cb6f..8c62c52d7f2e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8373,7 +8373,7 @@ static abi_long do_open_by_handle_at(abi_long mount_fd, abi_long handle,
         return -TARGET_EFAULT;
     }
 
-    fh = g_memdup(target_fh, total_size);
+    fh = g_memdup2(target_fh, total_size);
     fh->handle_bytes = size;
     fh->handle_type = tswap32(target_fh->handle_type);
 
diff --git a/linux-user/uaccess.c b/linux-user/uaccess.c
index f9bd713edd76..cddd60e0007b 100644
--- a/linux-user/uaccess.c
+++ b/linux-user/uaccess.c
@@ -16,7 +16,7 @@ void *lock_user(int type, abi_ulong guest_addr, ssize_t len, bool copy)
     host_addr = g2h_untagged(guest_addr);
 #ifdef CONFIG_DEBUG_REMAP
     if (copy) {
-        host_addr = g_memdup(host_addr, len);
+        host_addr = g_memdup2(host_addr, len);
     } else {
         host_addr = g_malloc0(len);
     }
diff --git a/meson.build b/meson.build
index cfac634cf13e..e9bf1c310ab4 100644
--- a/meson.build
+++ b/meson.build
@@ -1058,7 +1058,7 @@ have_xen_pci_passthrough = get_option('xen_pci_passthrough') \
 # the _WIN32_WINNT setting in osdep.h according to the value from glib.
 # You should also check if any of the glib.version() checks
 # below can also be removed.
-glib_req_ver = '>=2.66.0'
+glib_req_ver = '>=2.68.0'
 glib_pc = dependency('glib-2.0', version: glib_req_ver, required: true,
                     method: 'pkg-config')
 glib_cflags = []
diff --git a/net/colo.c b/net/colo.c
index fb2c36a026f8..21d6b250015f 100644
--- a/net/colo.c
+++ b/net/colo.c
@@ -166,7 +166,7 @@ Packet *packet_new(const void *data, int size, int vnet_hdr_len)
 {
     Packet *pkt = g_slice_new0(Packet);
 
-    pkt->data = g_memdup(data, size);
+    pkt->data = g_memdup2(data, size);
     pkt->size = size;
     pkt->creation_ms = qemu_clock_get_ms(QEMU_CLOCK_HOST);
     pkt->vnet_hdr_len = vnet_hdr_len;
@@ -221,7 +221,7 @@ Connection *connection_get(GHashTable *connection_track_table,
     Connection *conn = g_hash_table_lookup(connection_track_table, key);
 
     if (conn == NULL) {
-        ConnectionKey *new_key = g_memdup(key, sizeof(*key));
+        ConnectionKey *new_key = g_memdup2(key, sizeof(*key));
 
         conn = connection_new(key);
 
diff --git a/qapi/qapi-clone-visitor.c b/qapi/qapi-clone-visitor.c
index 30997638de50..7ee26cb64464 100644
--- a/qapi/qapi-clone-visitor.c
+++ b/qapi/qapi-clone-visitor.c
@@ -37,7 +37,7 @@ static bool qapi_clone_start_struct(Visitor *v, const char *name, void **obj,
         return true;
     }
 
-    *obj = g_memdup(*obj, size);
+    *obj = g_memdup2(*obj, size);
     qcv->depth++;
     return true;
 }
@@ -65,8 +65,8 @@ static GenericList *qapi_clone_next_list(Visitor *v, GenericList *tail,
     QapiCloneVisitor *qcv = to_qcv(v);
 
     assert(qcv->depth);
-    /* Unshare the tail of the list cloned by g_memdup() */
-    tail->next = g_memdup(tail->next, size);
+    /* Unshare the tail of the list cloned by g_memdup2() */
+    tail->next = g_memdup2(tail->next, size);
     return tail->next;
 }
 
@@ -83,7 +83,7 @@ static bool qapi_clone_type_int64(Visitor *v, const char *name, int64_t *obj,
     QapiCloneVisitor *qcv = to_qcv(v);
 
     assert(qcv->depth);
-    /* Value was already cloned by g_memdup() */
+    /* Value was already cloned by g_memdup2() */
     return true;
 }
 
@@ -93,7 +93,7 @@ static bool qapi_clone_type_uint64(Visitor *v, const char *name,
     QapiCloneVisitor *qcv = to_qcv(v);
 
     assert(qcv->depth);
-    /* Value was already cloned by g_memdup() */
+    /* Value was already cloned by g_memdup2() */
     return true;
 }
 
@@ -103,7 +103,7 @@ static bool qapi_clone_type_bool(Visitor *v, const char *name, bool *obj,
     QapiCloneVisitor *qcv = to_qcv(v);
 
     assert(qcv->depth);
-    /* Value was already cloned by g_memdup() */
+    /* Value was already cloned by g_memdup2() */
     return true;
 }
 
@@ -114,7 +114,7 @@ static bool qapi_clone_type_str(Visitor *v, const char *name, char **obj,
 
     assert(qcv->depth);
     /*
-     * Pointer was already cloned by g_memdup; create fresh copy.
+     * Pointer was already cloned by g_memdup2; create fresh copy.
      * Note that as long as qobject-output-visitor accepts NULL instead of
      * "", then we must do likewise. However, we want to obey the
      * input visitor semantics of never producing NULL when the empty
@@ -130,7 +130,7 @@ static bool qapi_clone_type_number(Visitor *v, const char *name, double *obj,
     QapiCloneVisitor *qcv = to_qcv(v);
 
     assert(qcv->depth);
-    /* Value was already cloned by g_memdup() */
+    /* Value was already cloned by g_memdup2() */
     return true;
 }
 
diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index 706c61e02608..469b5694f401 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -432,8 +432,10 @@ bool visit_type_enum(Visitor *v, const char *name, int *obj,
     case VISITOR_OUTPUT:
         return output_type_enum(v, name, obj, lookup, errp);
     case VISITOR_CLONE:
-        /* nothing further to do, scalar value was already copied by
-         * g_memdup() during visit_start_*() */
+        /*
+         * nothing further to do, scalar value was already copied by
+         * g_memdup2() during visit_start_*()
+         */
         return true;
     case VISITOR_DEALLOC:
         /* nothing to deallocate for a scalar */
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c023767f9670..5c46567ad03c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3253,11 +3253,6 @@ sub process {
 			WARN("consider using g_path_get_$1() in preference to g_strdup($1())\n" . $herecurr);
 		}
 
-# enforce g_memdup2() over g_memdup()
-		if ($line =~ /\bg_memdup\s*\(/) {
-			ERROR("use g_memdup2() instead of unsafe g_memdup()\n" . $herecurr);
-		}
-
 # recommend qemu_strto* over strto* for numeric conversions
 		if ($line =~ /\b(strto[^kd].*?)\s*\(/) {
 			ERROR("consider using qemu_$1 in preference to $1\n" . $herecurr);
diff --git a/system/memory.c b/system/memory.c
index 264dc90c0a55..7ada0f6d8caa 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1198,7 +1198,7 @@ static char *memory_region_escape_name(const char *name)
         bytes += memory_region_need_escape(*p) ? 4 : 1;
     }
     if (bytes == p - name) {
-       return g_memdup(name, bytes + 1);
+        return g_memdup2(name, bytes + 1);
     }
 
     escaped = g_malloc(bytes + 1);
diff --git a/system/vl.c b/system/vl.c
index 468a9fc247ac..d9617a6e25e1 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1186,7 +1186,7 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
     }
     if (nonempty_str(str)) {
         size = strlen(str); /* NUL terminator NOT included in fw_cfg blob */
-        buf = g_memdup(str, size);
+        buf = g_memdup2(str, size);
     } else if (nonempty_str(gen_id)) {
         if (!fw_cfg_add_file_from_generator(fw_cfg, object_get_objects_root(),
                                             gen_id, name, errp)) {

-- 
2.56.0.rc0.29.g47ce80527c56


