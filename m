Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD066606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 08:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L/GYzGiI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMhlw-0006T4-TR; Fri, 30 Oct 2026 04:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xMhlf-0006MT-43
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 04:15:20 -0400
Received: from mail-dl1-x1232.google.com ([2607:f8b0:4864:20::1232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xMhlZ-0001PF-Em
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 04:15:17 -0400
Received: by mail-dl1-x1232.google.com with SMTP id
 a92af1059eb24-14fc585291cso328472c88.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 01:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793348112; x=1793952912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Fp9LZTokCb77yom7hPnnnrO7TqI9laTG0ZXcPuVz3to=;
 b=L/GYzGiIFVRRBi00ZSGIw3sAcr3F6Y2/M51IcssoSzY+JUVyX8F2/g8o1xtuBBZ/w1
 bjDvWO7oP187sK56hgjTgKXBWSbZNg8zj+fP2eObHAo88NiA+fkgbGhIXPKIMEuZH+37
 Ir3WMO/0/uaseHAX1oNX2S6Yk3tqi9Y7yLoNmHBCLjc+7FsDsWXCGZU9mFWLE2V+lwtG
 24WujA4VXN0eYb0EKR/ideg8ELo8t8ToHL8Ay/y0TqzDPzIZgfreZAvvO3h+rNCFfkA/
 Rmgy70BEl2uaflEn3RddzZzENOB3MiGZKx3S+vCzMBRPJGGE1H2vU9jA/K8drnjCeUNS
 wXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793348112; x=1793952912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Fp9LZTokCb77yom7hPnnnrO7TqI9laTG0ZXcPuVz3to=;
 b=FZFUidyPAdvj4jbUZ4ojZ3r1ghhO5BgXDQgZbZIeouCm2QOni84hwMGff+/YS7KIzI
 3mr47WlHbZEwjDWhYnrEw86qKmTlb7Wzkn3ntHWxpYEV98wXTt7Vas4+FFDb3uB2YsLj
 M9mDK66F45Azu0lwzwk2JaaPbwvRPZh0yxomxg6NSnePqba1CDsGtpqGcVSX8PvF7Bwo
 06SRzBb9FZu/XeqybJe8qOVJywwpqftP2xvZ3Fh7UB6ihsjIOjq6Fgl/arF/q2ltG4g2
 07XSGeesTqleZ1ikOrjhW3PjDEP4ZslPG41ctpzu755lQ3a6JvXrY/iFjhPA9ForworR
 cuAw==
X-Gm-Message-State: AFq9FYIUXduxU0MG4YajMrTSqigyAqqjoHANIwDkb7mqPlapAeH4QezN
 2y6nttesWiSgneNeiKs2oBHAdQ+zgGsazklf/RKDZp61IjupioH+8BAF8IWqBA==
X-Gm-Gg: AYBFou1OqmNP7rxeiz4xhmT3gNBUMp0HI4X7iTSvoryCUEUxGNh4U+jvWsz+4lR1w7v
 MJYxI6EzHLFyEZP17tr5W6Iv11P77BhisBKMugzsAH1Omtveb2aWOhJn34VcxyYc08XiQ/8aRlD
 TcrG3qCxOlCwks0B1htNukOKKjxC0+wwmhu1LbCRZxITfC4ZTJ47EHqaV+S4GhCu9FvZBqk1CU0
 yUyPj3wzRqd+wtq+xGmv1or/BefG01IpLW/iQvzOQUk6gE2cty7vi5/L39ivIaRR0GuileEL5gN
 tMwZUny7GISCezBlFKi3g/qWUpoXha5UBH/BEFb607nbEzkelLJceqZ1qxtQ/56YXcMK++3oaM0
 iZEh8HKrT1wFpMlGWH/0CRFAgf2WZHZwR6jrMXTM+60NG7Vc1KPV+i4aBhjV+ytqC+UsKesmnC4
 TrWH1qOjmeDlMdCVZXhwwwuEE/zR6Hvr1bG7QCbmFNR8G9HkupD16EgVN5lVbBjxzUB0Geoijpn
 vhCSJobmU9lnXoLISs1pyZSxOWKB8lP/4RyWI788VhipJhOpbnbf8eKNdqaQmLUwh7VL8gm2E0b
 e35wqrUaP3fpGA/okOlPZBllyKD0CXQ8C5z/RSnBSjtF6+NC7Jnf20TydgnqOzs0dQQs/TZIXk8
 xUW6PTTiJOjg=
X-Received: by 2002:a05:7022:29c:10b0:143:8860:afa1 with SMTP id
 a92af1059eb24-1ac5f36d693mr2070019c88.46.1793348111926; 
 Fri, 30 Oct 2026 01:15:11 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac193b8179sm5905766c88.11.2026.10.30.01.15.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 01:15:11 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, fam@euphon.net, kwolf@redhat.com,
 hreitz@redhat.com, qemu-block@nongnu.org, daejun7.park@samsung.com,
 stanleyjhu@google.com, dridiha98@gmail.com, jeuk20.kim@samsung.com,
 j-young.choi@samsung.com
Subject: [PULL 05/12] hw/ufs: Add experimental fault injection properties for
 holding requests
Date: Fri, 30 Oct 2026 17:14:31 +0900
Message-ID: <c821f2f69f1e9d94873dbe7a60f6e8eac74e8ec9.1793347487.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793347487.git.jeuk20.kim@samsung.com>
References: <cover.1793347487.git.jeuk20.kim@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1232;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-dl1-x1232.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Stanley Jhu <stanleyjhu@google.com>

Add experimental properties x-fault-inject-tag and x-fault-inject-mode
to ufs-pci and ufs-sysbus devices for testing host driver error
handling and recovery routines.

When x-fault-inject-tag is set to a specific tag (0..255), the
controller holds the matching SCSI command request in u->held_req
without completing it. When x-fault-inject-tag is set to 0xfffffffe
(UFS_FAULT_INJECT_TAG_ANY), the controller intercepts the first
READ_10, WRITE_10, READ_16, or WRITE_16 command with LBA >= 512,
skipping boot-time metadata reads. The default value is 0xffffffff
(UFS_FAULT_INJECT_TAG_NONE), which disables fault injection.

Both properties can be changed at runtime through QOM (for example
QMP qom-set). A held request is released on HCE reset. Task
management handling for held requests follows in the next patch.

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/trace-events |   2 +
 hw/ufs/ufs-pci.c    |   7 ++
 hw/ufs/ufs-sysbus.c |   7 ++
 hw/ufs/ufs.c        | 164 ++++++++++++++++++++++++++++++++++++++++++++
 hw/ufs/ufs.h        |  61 ++++++++++++++++
 5 files changed, 241 insertions(+)

diff --git a/hw/ufs/trace-events b/hw/ufs/trace-events
index db9d1727135..17acbebd301 100644
--- a/hw/ufs/trace-events
+++ b/hw/ufs/trace-events
@@ -16,6 +16,8 @@ ufs_mcq_create_sq(uint8_t sqid, uint8_t cqid, uint64_t addr, uint16_t size) "mcq
 ufs_mcq_create_cq(uint8_t cqid, uint64_t addr, uint16_t size) "mcq create cq cqid %"PRIu8", addr 0x%"PRIx64", size %"PRIu16""
 ufs_write_mcq_op_reg(uint8_t qid, uint32_t offset, uint32_t data) "qid %"PRIu8", offset 0x%"PRIx32", data 0x%"PRIx32""
 ufs_process_tmr(uint8_t func, uint32_t tag, uint8_t resp) "query_func 0x%"PRIx8", task_tag %"PRIu32", tm_resp 0x%"PRIx8""
+ufs_fault_inject_hold_req(uint8_t tag, uint64_t lba) "held command tag %"PRIu8", lba %"PRIu64""
+ufs_fault_inject_set_tag(uint32_t tag) "fault-inject-tag set to 0x%"PRIx32""
 ufs_hce_reset(void) "HCE 1 -> 0 reset: cancelling BHs, resetting MCQ and request lists"
 
 # error condition
diff --git a/hw/ufs/ufs-pci.c b/hw/ufs/ufs-pci.c
index 8abd7d98e3d..8a2268f11ff 100644
--- a/hw/ufs/ufs-pci.c
+++ b/hw/ufs/ufs-pci.c
@@ -72,6 +72,13 @@ static const Property ufs_pci_props[] = {
                        0x400),
     DEFINE_PROP_UINT32("wb-min-size", UfsPciState, ufs.params.wb_min_size,
                        0x100),
+    DEFINE_PROP_UNSIGNED("x-fault-inject-tag", UfsPciState,
+                         ufs.params.fault_inject_tag, UFS_FAULT_INJECT_TAG_NONE,
+                         ufs_prop_fault_inject_tag, uint32_t),
+    DEFINE_PROP_SIGNED("x-fault-inject-mode", UfsPciState,
+                       ufs.params.fault_inject_mode,
+                       UFS_FAULT_INJECT_ABORT_SUCCESS,
+                       ufs_prop_fault_inject_mode, UfsFaultInjectMode),
 };
 
 static const VMStateDescription ufs_pci_vmstate = {
diff --git a/hw/ufs/ufs-sysbus.c b/hw/ufs/ufs-sysbus.c
index 84de2e95ac4..7e85d8fc4c9 100644
--- a/hw/ufs/ufs-sysbus.c
+++ b/hw/ufs/ufs-sysbus.c
@@ -45,6 +45,13 @@ static const Property ufs_sysbus_props[] = {
                        0x400),
     DEFINE_PROP_UINT32("wb-min-size", SysbusUfsState, ufs.params.wb_min_size,
                        0x100),
+    DEFINE_PROP_UNSIGNED("x-fault-inject-tag", SysbusUfsState,
+                         ufs.params.fault_inject_tag, UFS_FAULT_INJECT_TAG_NONE,
+                         ufs_prop_fault_inject_tag, uint32_t),
+    DEFINE_PROP_SIGNED("x-fault-inject-mode", SysbusUfsState,
+                       ufs.params.fault_inject_mode,
+                       UFS_FAULT_INJECT_ABORT_SUCCESS,
+                       ufs_prop_fault_inject_mode, UfsFaultInjectMode),
 };
 
 static const VMStateDescription ufs_sysbus_vmstate = {
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index cd28f97a123..1a5bc54eac4 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -15,8 +15,10 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/visitor.h"
 #include "scsi/constants.h"
 #include "hw/core/irq.h"
+#include "hw/core/qdev-prop-internal.h"
 #include "trace.h"
 #include "ufs.h"
 
@@ -778,6 +780,77 @@ static bool ufs_mcq_delete_cq(UfsHc *u, uint8_t qid)
     return true;
 }
 
+static void ufs_fault_inject_init(UfsHc *u)
+{
+    u->active_fault_inject_tag = u->params.fault_inject_tag;
+    u->held_req = NULL;
+}
+
+static void ufs_fault_inject_hce_reset(UfsHc *u)
+{
+    if (u->held_req) {
+        u->held_req = NULL;
+        u->active_fault_inject_tag = UFS_FAULT_INJECT_TAG_NONE;
+        u->params.fault_inject_tag = UFS_FAULT_INJECT_TAG_NONE;
+    } else {
+        u->active_fault_inject_tag = u->params.fault_inject_tag;
+    }
+}
+
+static bool ufs_fault_inject_exec_req(UfsRequest *req)
+{
+    UfsHc *u = req->hc;
+
+    if (likely(u->active_fault_inject_tag == UFS_FAULT_INJECT_TAG_NONE) ||
+        u->held_req != NULL ||
+        req->req_upiu.header.trans_type != UFS_UPIU_TRANSACTION_COMMAND) {
+        return false;
+    }
+
+    if (u->active_fault_inject_tag == UFS_FAULT_INJECT_TAG_ANY) {
+        uint8_t op = req->req_upiu.sc.cdb[0];
+        uint64_t lba = 0;
+        bool is_match = false;
+
+        if (op == READ_10 || op == WRITE_10) {
+            /*
+             * In 10-byte SCSI read/write commands (SBC-4), bytes 2..5
+             * encode the 32-bit Logical Block Address (LBA) in
+             * big-endian.
+             */
+            lba = ldl_be_p(&req->req_upiu.sc.cdb[2]);
+            is_match = (lba >= UFS_FAULT_INJECT_MIN_LBA);
+        } else if (op == READ_16 || op == WRITE_16) {
+            /*
+             * In 16-byte SCSI read/write commands (SBC-4), bytes 2..9
+             * encode the 64-bit Logical Block Address (LBA) in
+             * big-endian.
+             */
+            lba = ldq_be_p(&req->req_upiu.sc.cdb[2]);
+            is_match = (lba >= UFS_FAULT_INJECT_MIN_LBA);
+        }
+
+        /*
+         * Only intercept target I/O targeting LBA >=
+         * UFS_FAULT_INJECT_MIN_LBA. Skips guest boot-time partition
+         * table and superblock scanning.
+         */
+        if (is_match) {
+            u->active_fault_inject_tag = req->req_upiu.header.task_tag;
+            u->held_req = req;
+            trace_ufs_fault_inject_hold_req(
+                req->req_upiu.header.task_tag, lba);
+            return true;
+        }
+    } else if (req->req_upiu.header.task_tag == u->active_fault_inject_tag) {
+        u->held_req = req;
+        trace_ufs_fault_inject_hold_req(req->req_upiu.header.task_tag, 0);
+        return true;
+    }
+
+    return false;
+}
+
 static void ufs_hce_reset(UfsHc *u)
 {
     int i;
@@ -854,6 +927,8 @@ static void ufs_hce_reset(UfsHc *u)
         memset(u->mcq_op_reg, 0, sizeof(u->mcq_op_reg));
     }
 
+    ufs_fault_inject_hce_reset(u);
+
     u->resetting = false;
 
     /* 5. De-assert IRQ */
@@ -2432,6 +2507,10 @@ static void ufs_exec_req(UfsRequest *req)
         return;
     }
 
+    if (ufs_fault_inject_exec_req(req)) {
+        return;
+    }
+
     switch (req->req_upiu.header.trans_type) {
     case UFS_UPIU_TRANSACTION_NOP_OUT:
         req_result = ufs_exec_nop_cmd(req);
@@ -3058,8 +3137,93 @@ static void ufs_init_hc(UfsHc *u)
 
     timer_init_ms(&u->idle_timer, QEMU_CLOCK_VIRTUAL_RT, ufs_idle_timer_cb, u);
     timer_mod(&u->idle_timer, now + UFS_IDLE_TIMER_TICK);
+
+    ufs_fault_inject_init(u);
 }
 
+const QEnumLookup UfsFaultInjectMode_lookup = {
+    .array = (const char *const[]) {
+        [UFS_FAULT_INJECT_ABORT_SUCCESS] = "abort-success",
+        [UFS_FAULT_INJECT_ABORT_FAILED] = "abort-failed",
+        [UFS_FAULT_INJECT_IN_TRANSITION] = "in-transition",
+        [UFS_FAULT_INJECT_TIMEOUT] = "timeout",
+    },
+    .size = UFS_FAULT_INJECT_MODE_MAX,
+};
+
+static void ufs_prop_get_fault_inject_tag(Object *obj, Visitor *v,
+                                          const char *name, void *opaque,
+                                          Error **errp)
+{
+    Property *prop = opaque;
+    uint32_t *ptr = object_field_prop_ptr(obj, prop);
+    UfsParams *params = container_of(ptr, UfsParams, fault_inject_tag);
+    UfsHc *u = container_of(params, UfsHc, params);
+
+    visit_type_uint32(v, name, &u->active_fault_inject_tag, errp);
+}
+
+static void ufs_prop_set_fault_inject_tag(Object *obj, Visitor *v,
+                                          const char *name, void *opaque,
+                                          Error **errp)
+{
+    Property *prop = opaque;
+    uint32_t *ptr = object_field_prop_ptr(obj, prop);
+    UfsParams *params = container_of(ptr, UfsParams, fault_inject_tag);
+    UfsHc *u = container_of(params, UfsHc, params);
+    uint32_t val;
+
+    if (!visit_type_uint32(v, name, &val, errp)) {
+        return;
+    }
+
+    if (val > 255 && val != UFS_FAULT_INJECT_TAG_NONE &&
+        val != UFS_FAULT_INJECT_TAG_ANY) {
+        error_setg(errp,
+                   "invalid %s %u: must be 0..255, 0x%x (none), or 0x%x (any)",
+                   name, val, UFS_FAULT_INJECT_TAG_NONE,
+                   UFS_FAULT_INJECT_TAG_ANY);
+        return;
+    }
+
+    if (u->held_req != NULL) {
+        error_setg(errp,
+                   "cannot change %s while a request (tag %u) is held",
+                   name, u->held_req->req_upiu.header.task_tag);
+        return;
+    }
+
+    *ptr = val;
+    u->active_fault_inject_tag = val;
+    trace_ufs_fault_inject_set_tag(val);
+}
+
+static void ufs_prop_set_default_fault_inject_tag(ObjectProperty *op,
+                                                  const Property *prop)
+{
+    object_property_set_default_uint(op, prop->defval.u);
+}
+
+const PropertyInfo ufs_prop_fault_inject_tag = {
+    .type = "uint32",
+    .description = "Task tag to hold for fault injection",
+    .get = ufs_prop_get_fault_inject_tag,
+    .set = ufs_prop_set_fault_inject_tag,
+    .set_default_value = ufs_prop_set_default_fault_inject_tag,
+    .realized_set_allowed = true,
+};
+
+const PropertyInfo ufs_prop_fault_inject_mode = {
+    .type = "UfsFaultInjectMode",
+    .description = "Fault injection mode: abort-success, abort-failed, "
+                   "in-transition, timeout",
+    .enum_table = &UfsFaultInjectMode_lookup,
+    .get = qdev_propinfo_get_enum,
+    .set = qdev_propinfo_set_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
+    .realized_set_allowed = true,
+};
+
 bool ufs_realize(UfsHc *u, DeviceState *dev, AddressSpace *dma_as, Error **errp)
 {
     u->dev = dev;
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index 15b3a352f3b..80bdaa1a2aa 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -90,6 +90,56 @@ typedef struct UfsLu {
     UfsScsiOp scsi_op;
 } UfsLu;
 
+/*
+ * Fault injection modes for x-fault-inject-mode property.
+ * Controls how the held transfer request and subsequent Task Management
+ * Request (TMR) are resolved by the controller:
+ *
+ * UFS_FAULT_INJECT_ABORT_SUCCESS: TMR ABORT_TASK aborts the held request,
+ *                                 clears its state, and returns SUCCESS
+ *                                 (COMPL).
+ * UFS_FAULT_INJECT_ABORT_FAILED:  TMR ABORT_TASK returns
+ *                                 TASK_MANAGEMENT_FUNC_FAILED, forcing host
+ *                                 driver to escalate to Host Reset.
+ * UFS_FAULT_INJECT_IN_TRANSITION: TMR QUERY_TASK releases the held request to
+ *                                 execute normally through the SCSI layer and
+ *                                 returns the real task status (SUCCEEDED while
+ *                                 the command is still in flight);
+ *                                 ABORT_TASK cancels the held request and
+ *                                 returns FUNCTION_COMPLETE.
+ * UFS_FAULT_INJECT_TIMEOUT:       TMR ABORT_TASK does not complete or clear
+ *                                 doorbell, triggering hardware-level TMR
+ *                                 timeout.
+ */
+typedef enum UfsFaultInjectMode {
+    UFS_FAULT_INJECT_ABORT_SUCCESS = 0,
+    UFS_FAULT_INJECT_ABORT_FAILED,
+    UFS_FAULT_INJECT_IN_TRANSITION,
+    UFS_FAULT_INJECT_TIMEOUT,
+    UFS_FAULT_INJECT_MODE_MAX,
+} UfsFaultInjectMode;
+
+/*
+ * Sentinel values for x-fault-inject-tag property.
+ * Task Tags in UFS are 8-bit (0..255). Values >= 256 are reserved as
+ * sentinel flags to preserve full testability of Tag 0.
+ *
+ * UFS_FAULT_INJECT_TAG_NONE: Disable fault injection (default).
+ * UFS_FAULT_INJECT_TAG_ANY:  Automatically intercept the first user-space
+ *                            READ_10, WRITE_10, READ_16, or WRITE_16 command
+ *                            targeting LBA >= UFS_FAULT_INJECT_MIN_LBA.
+ */
+#define UFS_FAULT_INJECT_TAG_NONE 0xffffffff
+#define UFS_FAULT_INJECT_TAG_ANY  0xfffffffe
+
+/*
+ * Minimum Logical Block Address (LBA) for automatic fault injection.
+ * Skip early disk blocks (LBA 0..511, e.g. MBR, GPT partition tables, EFI,
+ * and filesystem superblocks) to ensure guest OS boot-time disk discovery
+ * and partition scanning complete cleanly without being held.
+ */
+#define UFS_FAULT_INJECT_MIN_LBA 512
+
 typedef struct UfsParams {
     char *serial;
     uint8_t nutrs; /* Number of UTP Transfer Request Slots */
@@ -99,6 +149,8 @@ typedef struct UfsParams {
     uint8_t mcq_maxq; /* MCQ Maximum number of Queues */
     uint32_t wb_max_size; /* WB Maximum allocation units */
     uint32_t wb_min_size; /* WB Minimum allocation units */
+    uint32_t fault_inject_tag;
+    UfsFaultInjectMode fault_inject_mode;
 } UfsParams;
 
 /*
@@ -188,6 +240,10 @@ typedef struct UfsHc {
     uint32_t hid_fragment_count; /* Remaining fragmented 4KB units */
     uint32_t hid_defrag_total; /* Requested units at defrag start */
     uint32_t hid_defrag_remaining; /* Requested units left to move */
+
+    /* Test and fault injection properties */
+    uint32_t active_fault_inject_tag;
+    UfsRequest *held_req;
 } UfsHc;
 
 static inline uint32_t ufs_mcq_sq_tail(UfsHc *u, uint32_t qid)
@@ -312,4 +368,9 @@ void ufs_init_wlu(UfsLu *wlu, uint8_t wlun);
 bool ufs_realize(UfsHc *u, DeviceState *dev, AddressSpace *dma_as,
                  Error **errp);
 void ufs_unrealize(UfsHc *u);
+
+extern const PropertyInfo ufs_prop_fault_inject_tag;
+extern const PropertyInfo ufs_prop_fault_inject_mode;
+extern const QEnumLookup UfsFaultInjectMode_lookup;
+
 #endif /* HW_UFS_UFS_H */
-- 
2.43.0


