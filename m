Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3048C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEVBM-0007lc-Rk; Mon, 12 May 2025 11:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9n-0004gx-GF
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:31 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9j-0006hW-3y
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:31 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CCACF9028222;
 Mon, 12 May 2025 15:33:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=IQ2klEfR/02+9Hqn1m16gK3h0R6iV+BQSmFbW26umWs=; b=
 oIE5FjTav1X2Sz8IKcdS6BuzvDd7RC3oGYLIyZQ/wCDG51A1AEmggvgNMuYNXPO1
 3mcpxaN6yoxRhjjePqrUxvrnYko7JDbCu5lUNKmV9lyCNvax2sIszqUOygVEFGZK
 btWJhcew2pJlxKjzWcMtoZKLG3+QMSgAPC13FgWYDyt3bJHeyWatV5yZOo9an4kp
 ry20rFeYm3cqaJTI8dImECcg1MT4HEkmV5XOQ5UySi00mxUUwiNkpsTM9mYK4f5f
 AsDqNs+E+N/rx8yiFnErRxrtHHx7uCTbTHWpcieFOVtsISwiYVLMm8oa2Ksi8jB+
 rB345hlqq4tmmWzkBlCkBA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j1662usf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:14 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CE214n002394; Mon, 12 May 2025 15:33:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx366mg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:13 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CFWk5Q030605;
 Mon, 12 May 2025 15:33:13 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46jwx36627-25; Mon, 12 May 2025 15:33:12 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 24/42] migration: close kvm after cpr
Date: Mon, 12 May 2025 08:32:35 -0700
Message-Id: <1747063973-124548-25-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_05,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505120161
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfXxCFMxsKCQYei
 kHe5YAHw3CuQhhoT0y0JHJY4d9B4xRteZyOukpy/SedBMG+hR+fdYcpt4SPrmaR6H/4MDlU4Frt
 6sehUjFQ47O/+WuHrc0EQHayf/qfTpjbqF3rlqHFzQwvQLWwDt76/+oPvFe6LMbx0iFi9CwVqlD
 86ODL52Ug4y71BB87T9yQh/gc0oUt8b9bQlP0mm7dvkRjbd/m+Y6jWCnT4O6jI9UCzGKLxxnaIK
 Tdlx9ejnR6+lmR33jSV/61igvpDoythmcBUOJui8bdoESpojodVm+RrlDre73o2bxfw3by5H3wV
 L1UI7ZSVBeuAAS4NmixcpGB5OZQBCRUOInA4ThFNiz0stK3WUYZKW12TzDfyocan0p+XnsYJyO5
 S+tTu+91BdQdIoPAGvpOPBTGrphDsJ2u6DGxBKb0TsJt1nftHACnGyXrwP0/ZPmpkQPdITeT
X-Authority-Analysis: v=2.4 cv=VMDdn8PX c=1 sm=1 tr=0 ts=682214ba b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=knuBMWxmVakelJ1COboA:9
X-Proofpoint-ORIG-GUID: VYSE6b0MJUF8uyYq4WT8isdAhJCl2tat
X-Proofpoint-GUID: VYSE6b0MJUF8uyYq4WT8isdAhJCl2tat
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

cpr-transfer breaks vfio network connectivity to and from the guest, and
the host system log shows:
  irq bypass consumer (token 00000000a03c32e5) registration fails: -16
which is EBUSY.  This occurs because KVM descriptors are still open in
the old QEMU process.  Close them.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 accel/kvm/kvm-all.c           | 28 ++++++++++++++++++++++++++++
 hw/vfio/helpers.c             | 10 ++++++++++
 include/hw/vfio/vfio-device.h |  2 ++
 include/migration/cpr.h       |  2 ++
 include/qemu/vfio-helpers.h   |  1 -
 include/system/kvm.h          |  1 +
 migration/cpr-transfer.c      | 18 ++++++++++++++++++
 migration/cpr.c               |  8 ++++++++
 migration/migration.c         |  1 +
 9 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 278a506..d619448 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -512,16 +512,23 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
         goto err;
     }
 
+    /* If I am the CPU that created coalesced_mmio_ring, then discard it */
+    if (s->coalesced_mmio_ring == (void *)cpu->kvm_run + PAGE_SIZE) {
+        s->coalesced_mmio_ring = NULL;
+    }
+
     ret = munmap(cpu->kvm_run, mmap_size);
     if (ret < 0) {
         goto err;
     }
+    cpu->kvm_run = NULL;
 
     if (cpu->kvm_dirty_gfns) {
         ret = munmap(cpu->kvm_dirty_gfns, s->kvm_dirty_ring_bytes);
         if (ret < 0) {
             goto err;
         }
+        cpu->kvm_dirty_gfns = NULL;
     }
 
     kvm_park_vcpu(cpu);
@@ -600,6 +607,27 @@ err:
     return ret;
 }
 
+void kvm_close(void)
+{
+    CPUState *cpu;
+
+    CPU_FOREACH(cpu) {
+        cpu_remove_sync(cpu);
+        close(cpu->kvm_fd);
+        cpu->kvm_fd = -1;
+        close(cpu->kvm_vcpu_stats_fd);
+        cpu->kvm_vcpu_stats_fd = -1;
+    }
+
+    if (kvm_state && kvm_state->fd != -1) {
+        close(kvm_state->vmfd);
+        kvm_state->vmfd = -1;
+        close(kvm_state->fd);
+        kvm_state->fd = -1;
+    }
+    kvm_state = NULL;
+}
+
 /*
  * dirty pages logging control
  */
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index d0dbab1..af1db2f 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -117,6 +117,16 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
 int vfio_kvm_device_fd = -1;
 #endif
 
+void vfio_kvm_device_close(void)
+{
+#ifdef CONFIG_KVM
+    if (vfio_kvm_device_fd != -1) {
+        close(vfio_kvm_device_fd);
+        vfio_kvm_device_fd = -1;
+    }
+#endif
+}
+
 int vfio_kvm_device_add_fd(int fd, Error **errp)
 {
 #ifdef CONFIG_KVM
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 4e4d0b6..6eb6f21 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -231,4 +231,6 @@ void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
 void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
                       DeviceState *dev, bool ram_discard);
 int vfio_device_get_aw_bits(VFIODevice *vdev);
+
+void vfio_kvm_device_close(void);
 #endif /* HW_VFIO_VFIO_COMMON_H */
diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index fc6aa33..5f1ff10 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -31,7 +31,9 @@ void cpr_state_close(void);
 struct QIOChannel *cpr_state_ioc(void);
 
 bool cpr_needed_for_reuse(void *opaque);
+void cpr_kvm_close(void);
 
+void cpr_transfer_init(void);
 QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
 QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
 
diff --git a/include/qemu/vfio-helpers.h b/include/qemu/vfio-helpers.h
index bde9495..a029036 100644
--- a/include/qemu/vfio-helpers.h
+++ b/include/qemu/vfio-helpers.h
@@ -28,5 +28,4 @@ void qemu_vfio_pci_unmap_bar(QEMUVFIOState *s, int index, void *bar,
                              uint64_t offset, uint64_t size);
 int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
                            int irq_type, Error **errp);
-
 #endif
diff --git a/include/system/kvm.h b/include/system/kvm.h
index b690dda..cfaa94c 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -194,6 +194,7 @@ bool kvm_has_sync_mmu(void);
 int kvm_has_vcpu_events(void);
 int kvm_max_nested_state_length(void);
 int kvm_has_gsi_routing(void);
+void kvm_close(void);
 
 /**
  * kvm_arm_supports_user_irq
diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
index e1f1403..396558f 100644
--- a/migration/cpr-transfer.c
+++ b/migration/cpr-transfer.c
@@ -17,6 +17,24 @@
 #include "migration/vmstate.h"
 #include "trace.h"
 
+static int cpr_transfer_notifier(NotifierWithReturn *notifier,
+                                 MigrationEvent *e,
+                                 Error **errp)
+{
+    if (e->type == MIG_EVENT_PRECOPY_DONE) {
+        cpr_kvm_close();
+    }
+    return 0;
+}
+
+void cpr_transfer_init(void)
+{
+    static NotifierWithReturn notifier;
+
+    migration_add_notifier_mode(&notifier, cpr_transfer_notifier,
+                                MIG_MODE_CPR_TRANSFER);
+}
+
 QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp)
 {
     MigrationAddress *addr = channel->addr;
diff --git a/migration/cpr.c b/migration/cpr.c
index 0b01e25..6102d04 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -7,12 +7,14 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "hw/vfio/vfio-device.h"
 #include "migration/cpr.h"
 #include "migration/misc.h"
 #include "migration/options.h"
 #include "migration/qemu-file.h"
 #include "migration/savevm.h"
 #include "migration/vmstate.h"
+#include "system/kvm.h"
 #include "system/runstate.h"
 #include "trace.h"
 
@@ -252,3 +254,9 @@ bool cpr_needed_for_reuse(void *opaque)
     MigMode mode = migrate_mode();
     return mode == MIG_MODE_CPR_TRANSFER;
 }
+
+void cpr_kvm_close(void)
+{
+    kvm_close();
+    vfio_kvm_device_close();
+}
diff --git a/migration/migration.c b/migration/migration.c
index 4697732..89e2026 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -337,6 +337,7 @@ void migration_object_init(void)
 
     ram_mig_init();
     dirty_bitmap_mig_init();
+    cpr_transfer_init();
 
     /* Initialize cpu throttle timers */
     cpu_throttle_init();
-- 
1.8.3.1


