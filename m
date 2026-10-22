Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD960606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=v7SHuDzI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJnUK-0007FJ-2U; Thu, 22 Oct 2026 03:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Db_ZagoKClAABs53wG1zCy66y3w.u648w4C-vwDw3565y5C.69y@flex--stanleyjhu.bounces.google.com>)
 id 1xJnUJ-0007Ez-08
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:45:23 -0400
Received: from mail-pj1-x1045.google.com ([2607:f8b0:4864:20::1045])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Db_ZagoKClAABs53wG1zCy66y3w.u648w4C-vwDw3565y5C.69y@flex--stanleyjhu.bounces.google.com>)
 id 1xJnUG-0002G4-FF
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:45:22 -0400
Received: by mail-pj1-x1045.google.com with SMTP id
 98e67ed59e1d1-3acc98e3b3cso1563658a91.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 00:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792655118; x=1793259918; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=59PDeabW57Atf4QewYFYLbLETvC3v4AbC3AOLWtCo+E=;
 b=v7SHuDzIhHSAutNvYxk4Zjpvf1D88w6hz7IoSW1RzqaE1Q4aRI098QXrCSfzkbESTI
 42KI/lE+6+AbqJf071trpitbaNP576+8BktlVZ1C5EoHyu/QpkwfcMd44tuLL5YoJb9X
 AYKECNEsqrrG6d845fGiCA2gQhWJiYNncvTxlxplJyeKmQjSBNBnNE4dQ+Bkf0NqBtc8
 TzpR/bd3sdbNy9ny5Mn0SO9c/hkbgagKUTNbR3DNoOTkubDkUIKiLh9ouaORDOl7tofP
 UVXxYH72Zp2iTCcR/WVXacqizZpuOKtnXHg2JrOSFyn6SCM9WM0fqDw0L8+dlV7b8MwR
 P+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792655118; x=1793259918;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=59PDeabW57Atf4QewYFYLbLETvC3v4AbC3AOLWtCo+E=;
 b=xcQYuVPnRo920M53MGHjml7YoHhmCt5+O2f8BK+7og4+YZUZwqf4p/X4rafe2KPHFi
 fD5jrdAEUKQX3xwV5E78BnyndjvCKWgzh+o4/tkvEFjC9SML0Jf9SopiQBlTUTJIHvQt
 xnoFeoOYkzGGlLpwP58Cu1nzRyNeVfTxP7JvJp5T78WEZZLbzwpX6yFTZXJmUlJtHNv+
 Cxmk+ctovWiPrRo0SdUZ/VtRQBATCSyl7EXvX1UDRPsBbyygOnFcuv4hmlmtxHcwc60B
 Z9+3x9iaCOYbcyBDsN5vM8AJSg091ReOlG4Hb3peyVl4WPVcyhBCNue/H5ZxqFtqARyS
 Hd9w==
X-Gm-Message-State: AFq9FYJcezKT8xjoMs19IJfIV1pdLNOHjyZNWPneWpM/ClvqbFyWdoDz
 xKc3DBChOoQr9YGwWg6cfeoORjgnBAzvlsDuFZzE+kSEaWKPp8T4j8I/YT+wp/BLLND5jEvgbk1
 UN67oxJaeGMEHTL0xMAIK3w==
X-Received: from pgfd4-n2.prod.google.com
 ([2002:a05:6a02:6544:20b0:cd6:db2:b293])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4d01:b0:3a8:92a3:8baa with SMTP id
 98e67ed59e1d1-3ad86d50bfbmr3960650a91.27.1792655117426; 
 Thu, 22 Oct 2026 00:45:17 -0700 (PDT)
Date: Thu, 22 Oct 2026 15:45:06 +0800
In-Reply-To: <20261022074513.2292281-1-stanleyjhu@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261022074513.2292281-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261022074513.2292281-2-stanleyjhu@google.com>
Subject: [PATCH v2 1/8] hw/ufs: Add experimental fault injection properties
 for holding requests
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jinyoung Choi <j-young.choi@samsung.com>,
 Daejun Park <daejun7.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1045;
 envelope-from=3Db_ZagoKClAABs53wG1zCy66y3w.u648w4C-vwDw3565y5C.69y@flex--stanleyjhu.bounces.google.com;
 helo=mail-pj1-x1045.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add experimental properties x-fault-inject-tag and x-fault-inject-mode
to ufs-pci and ufs-sysbus devices for testing host driver error
handling and recovery routines.

When x-fault-inject-tag is set to a specific tag (0..255), the
controller holds the matching SCSI command request in u->held_req
without completing it. When x-fault-inject-tag is set to 0xfffffffe
(UFS_FAULT_INJECT_TAG_ANY), the controller intercepts the first
READ_10 or WRITE_10 command with LBA >= 512, skipping boot-time
metadata reads. The default value is 0xffffffff
(UFS_FAULT_INJECT_TAG_NONE), which disables fault injection.

Both properties can be changed at runtime through QOM (for example
QMP qom-set). A held request is released on HCE reset. Task
management handling for held requests follows in the next patch.

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 hw/ufs/trace-events |   3 +
 hw/ufs/ufs-pci.c    |   6 ++
 hw/ufs/ufs-sysbus.c |   6 ++
 hw/ufs/ufs.c        | 229 ++++++++++++++++++++++++++++++++++++++++++++
 hw/ufs/ufs.h        |  58 +++++++++++
 5 files changed, 302 insertions(+)

diff --git a/hw/ufs/trace-events b/hw/ufs/trace-events
index c5c148be91..a26529a1ed 100644
--- a/hw/ufs/trace-events
+++ b/hw/ufs/trace-events
@@ -16,6 +16,9 @@ ufs_mcq_create_sq(uint8_t sqid, uint8_t cqid, uint64_t addr, uint16_t size) "mcq
 ufs_mcq_create_cq(uint8_t cqid, uint64_t addr, uint16_t size) "mcq create cq cqid %"PRIu8", addr 0x%"PRIx64", size %"PRIu16""
 ufs_write_mcq_op_reg(uint8_t qid, uint32_t offset, uint32_t data) "qid %"PRIu8", offset 0x%"PRIx32", data 0x%"PRIx32""
 ufs_process_tmr(uint8_t func, uint32_t tag, uint8_t resp) "query_func 0x%"PRIx8", task_tag %"PRIu32", tm_resp 0x%"PRIx8""
+ufs_fault_inject_hold_req(uint8_t tag, uint32_t lba) "held command tag %"PRIu8", lba %"PRIu32""
+ufs_fault_inject_set_tag(uint32_t tag) "fault-inject-tag set to 0x%"PRIx32""
+ufs_fault_inject_set_mode(const char *mode) "fault-inject-mode set to %s"
 ufs_hce_reset(void) "HCE 1 -> 0 reset: cancelling BHs, resetting MCQ and request lists"
 
 # error condition
diff --git a/hw/ufs/ufs-pci.c b/hw/ufs/ufs-pci.c
index 8abd7d98e3..504a63bef9 100644
--- a/hw/ufs/ufs-pci.c
+++ b/hw/ufs/ufs-pci.c
@@ -72,6 +72,12 @@ static const Property ufs_pci_props[] = {
                        0x400),
     DEFINE_PROP_UINT32("wb-min-size", UfsPciState, ufs.params.wb_min_size,
                        0x100),
+    DEFINE_PROP_UNSIGNED("x-fault-inject-tag", UfsPciState,
+                         ufs.params.fault_inject_tag, UFS_FAULT_INJECT_TAG_NONE,
+                         ufs_prop_fault_inject_tag, uint32_t),
+    DEFINE_PROP("x-fault-inject-mode", UfsPciState,
+                ufs.params.fault_inject_mode, ufs_prop_fault_inject_mode,
+                char *),
 };
 
 static const VMStateDescription ufs_pci_vmstate = {
diff --git a/hw/ufs/ufs-sysbus.c b/hw/ufs/ufs-sysbus.c
index 84de2e95ac..9de31557e7 100644
--- a/hw/ufs/ufs-sysbus.c
+++ b/hw/ufs/ufs-sysbus.c
@@ -45,6 +45,12 @@ static const Property ufs_sysbus_props[] = {
                        0x400),
     DEFINE_PROP_UINT32("wb-min-size", SysbusUfsState, ufs.params.wb_min_size,
                        0x100),
+    DEFINE_PROP_UNSIGNED("x-fault-inject-tag", SysbusUfsState,
+                         ufs.params.fault_inject_tag, UFS_FAULT_INJECT_TAG_NONE,
+                         ufs_prop_fault_inject_tag, uint32_t),
+    DEFINE_PROP("x-fault-inject-mode", SysbusUfsState,
+                ufs.params.fault_inject_mode, ufs_prop_fault_inject_mode,
+                char *),
 };
 
 static const VMStateDescription ufs_sysbus_vmstate = {
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index cd28f97a12..f356818375 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -15,6 +15,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/visitor.h"
 #include "scsi/constants.h"
 #include "hw/core/irq.h"
 #include "trace.h"
@@ -778,6 +779,66 @@ static bool ufs_mcq_delete_cq(UfsHc *u, uint8_t qid)
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
+
+        if (op == READ_10 || op == WRITE_10) {
+            /*
+             * In 10-byte SCSI read/write commands (SBC-4), bytes 2..5
+             * encode the 32-bit Logical Block Address (LBA) in
+             * big-endian.
+             */
+            uint32_t lba = ldl_be_p(&req->req_upiu.sc.cdb[2]);
+
+            /*
+             * Only intercept target I/O targeting LBA >=
+             * UFS_FAULT_INJECT_MIN_LBA. Skips guest boot-time partition
+             * table and superblock scanning.
+             */
+            if (lba >= UFS_FAULT_INJECT_MIN_LBA) {
+                u->active_fault_inject_tag = req->req_upiu.header.task_tag;
+                u->held_req = req;
+                trace_ufs_fault_inject_hold_req(
+                    req->req_upiu.header.task_tag, lba);
+                return true;
+            }
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
@@ -854,6 +915,8 @@ static void ufs_hce_reset(UfsHc *u)
         memset(u->mcq_op_reg, 0, sizeof(u->mcq_op_reg));
     }
 
+    ufs_fault_inject_hce_reset(u);
+
     u->resetting = false;
 
     /* 5. De-assert IRQ */
@@ -2432,6 +2495,10 @@ static void ufs_exec_req(UfsRequest *req)
         return;
     }
 
+    if (ufs_fault_inject_exec_req(req)) {
+        return;
+    }
+
     switch (req->req_upiu.header.trans_type) {
     case UFS_UPIU_TRANSACTION_NOP_OUT:
         req_result = ufs_exec_nop_cmd(req);
@@ -3058,8 +3125,166 @@ static void ufs_init_hc(UfsHc *u)
 
     timer_init_ms(&u->idle_timer, QEMU_CLOCK_VIRTUAL_RT, ufs_idle_timer_cb, u);
     timer_mod(&u->idle_timer, now + UFS_IDLE_TIMER_TICK);
+
+    ufs_fault_inject_init(u);
+}
+
+static bool ufs_fault_inject_parse_mode(const char *str,
+                                        UfsFaultInjectMode *mode,
+                                        Error **errp)
+{
+    if (!str || g_strcmp0(str, "abort-success") == 0) {
+        *mode = UFS_FAULT_INJECT_ABORT_SUCCESS;
+    } else if (g_strcmp0(str, "abort-failed") == 0) {
+        *mode = UFS_FAULT_INJECT_ABORT_FAILED;
+    } else if (g_strcmp0(str, "in-transition") == 0) {
+        *mode = UFS_FAULT_INJECT_IN_TRANSITION;
+    } else if (g_strcmp0(str, "timeout") == 0) {
+        *mode = UFS_FAULT_INJECT_TIMEOUT;
+    } else {
+        error_setg(errp, "invalid x-fault-inject-mode: %s", str);
+        return false;
+    }
+    return true;
 }
 
+static bool ufs_fault_inject_realize(UfsHc *u, Error **errp)
+{
+    return ufs_fault_inject_parse_mode(u->params.fault_inject_mode,
+                                       &u->fault_inject_mode, errp);
+}
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
+static void ufs_prop_get_fault_inject_mode(Object *obj, Visitor *v,
+                                           const char *name, void *opaque,
+                                           Error **errp)
+{
+    Property *prop = opaque;
+    char **ptr = object_field_prop_ptr(obj, prop);
+    UfsParams *params = container_of(ptr, UfsParams, fault_inject_mode);
+    UfsHc *u = container_of(params, UfsHc, params);
+    const char *str;
+    char *val;
+
+    switch (u->fault_inject_mode) {
+    case UFS_FAULT_INJECT_ABORT_FAILED:
+        str = "abort-failed";
+        break;
+    case UFS_FAULT_INJECT_IN_TRANSITION:
+        str = "in-transition";
+        break;
+    case UFS_FAULT_INJECT_TIMEOUT:
+        str = "timeout";
+        break;
+    case UFS_FAULT_INJECT_ABORT_SUCCESS:
+    default:
+        str = "abort-success";
+        break;
+    }
+
+    val = g_strdup(str);
+    visit_type_str(v, name, &val, errp);
+    g_free(val);
+}
+
+static void ufs_prop_set_fault_inject_mode(Object *obj, Visitor *v,
+                                           const char *name, void *opaque,
+                                           Error **errp)
+{
+    Property *prop = opaque;
+    char **ptr = object_field_prop_ptr(obj, prop);
+    UfsParams *params = container_of(ptr, UfsParams, fault_inject_mode);
+    UfsHc *u = container_of(params, UfsHc, params);
+    char *str;
+    UfsFaultInjectMode mode;
+
+    if (!visit_type_str(v, name, &str, errp)) {
+        return;
+    }
+
+    if (!ufs_fault_inject_parse_mode(str, &mode, errp)) {
+        g_free(str);
+        return;
+    }
+
+    g_free(*ptr);
+    *ptr = str;
+    u->fault_inject_mode = mode;
+    trace_ufs_fault_inject_set_mode(str);
+}
+
+static void ufs_prop_release_fault_inject_mode(Object *obj, const char *name,
+                                               void *opaque)
+{
+    Property *prop = opaque;
+    char **ptr = object_field_prop_ptr(obj, prop);
+
+    g_free(*ptr);
+    *ptr = NULL;
+}
+
+const PropertyInfo ufs_prop_fault_inject_mode = {
+    .type = "str",
+    .description = "Fault injection mode: abort-success, abort-failed, "
+                   "in-transition, timeout",
+    .get = ufs_prop_get_fault_inject_mode,
+    .set = ufs_prop_set_fault_inject_mode,
+    .release = ufs_prop_release_fault_inject_mode,
+    .realized_set_allowed = true,
+};
+
 bool ufs_realize(UfsHc *u, DeviceState *dev, AddressSpace *dma_as, Error **errp)
 {
     u->dev = dev;
@@ -3069,6 +3294,10 @@ bool ufs_realize(UfsHc *u, DeviceState *dev, AddressSpace *dma_as, Error **errp)
         return false;
     }
 
+    if (!ufs_fault_inject_realize(u, errp)) {
+        return false;
+    }
+
     qbus_init(&u->bus, sizeof(UfsBus), TYPE_UFS_BUS, dev, dev->id);
     u->bus.hc = u;
 
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index f6583a5db7..39213650bb 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -133,6 +133,53 @@ typedef struct UfsLu {
     UfsZoneState *zone_array;
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
+ * UFS_FAULT_INJECT_IN_TRANSITION: TMR QUERY_TASK / ABORT_TASK completes the
+ *                                 held request successfully and returns
+ *                                 COMPL (simulating a command completing in
+ *                                 transition / grace period).
+ * UFS_FAULT_INJECT_TIMEOUT:       TMR ABORT_TASK does not complete or clear
+ *                                 doorbell, triggering hardware-level TMR
+ *                                 timeout.
+ */
+typedef enum UfsFaultInjectMode {
+    UFS_FAULT_INJECT_ABORT_SUCCESS = 0,
+    UFS_FAULT_INJECT_ABORT_FAILED,
+    UFS_FAULT_INJECT_IN_TRANSITION,
+    UFS_FAULT_INJECT_TIMEOUT,
+} UfsFaultInjectMode;
+
+/*
+ * Sentinel values for x-fault-inject-tag property.
+ * Task Tags in UFS are 8-bit (0..255). Values >= 256 are reserved as
+ * sentinel flags to preserve full testability of Tag 0.
+ *
+ * UFS_FAULT_INJECT_TAG_NONE: Disable fault injection (default).
+ * UFS_FAULT_INJECT_TAG_ANY:  Automatically intercept the first user-space
+ *                            READ_10 or WRITE_10 command targeting
+ *                            LBA >= UFS_FAULT_INJECT_MIN_LBA.
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
@@ -142,6 +189,8 @@ typedef struct UfsParams {
     uint8_t mcq_maxq; /* MCQ Maximum number of Queues */
     uint32_t wb_max_size; /* WB Maximum allocation units */
     uint32_t wb_min_size; /* WB Minimum allocation units */
+    uint32_t fault_inject_tag;
+    char *fault_inject_mode;
 } UfsParams;
 
 /*
@@ -231,6 +280,11 @@ typedef struct UfsHc {
     uint32_t hid_fragment_count; /* Remaining fragmented 4KB units */
     uint32_t hid_defrag_total; /* Requested units at defrag start */
     uint32_t hid_defrag_remaining; /* Requested units left to move */
+
+    /* Test and fault injection properties */
+    uint32_t active_fault_inject_tag;
+    UfsFaultInjectMode fault_inject_mode;
+    UfsRequest *held_req;
 } UfsHc;
 
 static inline uint32_t ufs_mcq_sq_tail(UfsHc *u, uint32_t qid)
@@ -355,4 +409,8 @@ void ufs_init_wlu(UfsLu *wlu, uint8_t wlun);
 bool ufs_realize(UfsHc *u, DeviceState *dev, AddressSpace *dma_as,
                  Error **errp);
 void ufs_unrealize(UfsHc *u);
+
+extern const PropertyInfo ufs_prop_fault_inject_tag;
+extern const PropertyInfo ufs_prop_fault_inject_mode;
+
 #endif /* HW_UFS_UFS_H */
-- 
2.56.0.218.g1ec904b173-goog


