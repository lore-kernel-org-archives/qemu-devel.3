Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986AFCCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhcB-0001Iz-Co; Fri, 16 Oct 2026 09:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHfFt-0006l0-00; Fri, 16 Oct 2026 06:33:41 -0400
Received: from out203-205-221-240.mail.qq.com ([203.205.221.240])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHfFp-0004s5-JX; Fri, 16 Oct 2026 06:33:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792146814; bh=XiS6voLPqdDPZedvyPlkXdQ71IPKaN5xiRvjG/IVNiw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Yp9gbAyjfEJC79FqttjD+PNBvY6hXiY/wuvLNof5SOS/jXqohQXblc3u9+NkWjS3a
 4TAKK132PpzrnX5B5iZ5ml4iZvNKRBmrTCw0+YH3J99oi6N2AOLTBsJGho7p4oyTIQ
 bKcGYCSixhDfCtRl2DbYw0JeVQPTzvOJ4MfOAe7k=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
 id 85FA54A8; Fri, 16 Oct 2026 18:33:31 +0800
X-QQ-mid: xmsmtpt1792146811t4gukfzhj
Message-ID: <tencent_B7E4F1EE8A5BDAD20424E2F8AD9AD4E54C06@qq.com>
X-QQ-XMAILINFO: NmhoXJR/eu5xP+XJZRp08cVOjfLBhmTeo1MdCzyUsbk0stnWppdBqQeXg0cICg
 IBx0f6dJRnM6/8GAwKYMVN4TJi51PwmLeQ8UxqKCp8pE6y56qgYKYxwstLvbHOOZbVTr5Nd06Wzp
 SzpQcWF4jdCUDrl2IzV1l+jie0+H4YnxNB+Cw/3ZJqZuKTgzVruZ/kLIC20ykLx3L1M4ccrQjFJl
 yl4umZfpDYcGWleFvkXc96XXYicnlWi4JeAPQF4fymwnPOiIkZGzxrpS0bY3PYN4mlUNnApcjeW1
 Y9ZwSsqho+aRGdRYYBVpxDJyTGVprhXA/dBcsBZd7VbHscb/OYAjJ/MsPx75gel75n/YF2SwJVGl
 PNYmY9h0VXabIBTm0khb3VV97zNHRTJMbYqEX0/xKL6w8djwrg9U+v3hNvZS847dXr+lVeLbklsj
 qLF4wD492cyZo+VQZGm2Hz75/h+c+UZ+6cC3kzQnJYRzWQ0dGmec3H1017lsns8/KbCIOVIbWY/9
 RPtWV4V8kbMBoSkxtUTRlOsjONyV5vr6h/WQrEI/3gGrJ2x18Of63Fggj8v8Mv3oS4mc0CbCUa3I
 j4+F1m7cJffnkeqCX7vNzlcMrbzOlAPRh8p+9hjbMh+viEbDKI0pDcECzSaIaIeXre14d7vHs5xa
 0Dkjrb46RpOsWSvwEtt7y/NTvJ2hXS4V891+W9CKI99XayyqIxQlpX8+J/oRN8q7HkjVZHM5zdTw
 roBoL5oqoplp7TaW6TZEDIbaq2GUZk5OCah1AfQ2HohAXOWZQS1yP/f2KXP53er6VVEidFTNnaCP
 qjjXcxVEvF/sBCBoMXuzyA9WzVSvblYBnRoRJebBSxuiDFQRptMS3s0LD0uCUbvtyPF+tMkzvdgl
 cEns67V6N6Cme38gm3wx+d24rbPQVZeeJT0Oq3Bye7Up+cb6WDyqIEACHbjhBZfIi9JIfX9wwhm1
 H8XriI+PdJdLUcgwLRYM7qlHtZQ2IHiAkXaIiSDW0V1oHvKFH0mbFfcbrz8SWznWbIC1hWxIueML
 qEAoeCPPO/4siwwmWw82JG+okbh0pHLkm0eNOSzZ5sRSZe7Jtmh6UgAbCdnmaPaSd/wHF1JNKRyu
 AchXZBB11rvUFcuoburAEyKyt0vw==
X-QQ-XMRINFO: NV153Ut7BKVGEBPxNGBppa2DJCr1urzIPw==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 37/37] hw/arm/mpam: Implement query-mpam-cache
Date: Fri, 16 Oct 2026 18:10:57 +0800
X-OQ-MSGID: <20261016101058.1900808-23-2118537295@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016101058.1900808-1-2118537295@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.240; envelope-from=2118537295@qq.com;
 helo=out203-205-221-240.mail.qq.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Oct 2026 09:02:47 -0400
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Implement the query-mpam-cache QMP command: walk the QOM tree for
mpam-msc-cache devices and report each via mpam_cache_fill_info()
(with the per-RIS register state and the configured CPBM bitmaps),
building on the generated header now included from the device
contract header.

Based on an RFC series by Jonathan Cameron, adapted to the current
qapi documentation rules.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/arm/meson.build    |  5 ++--
 hw/arm/mpam-qapi.c    | 62 ++++++++++++++++++++++++++++++++++++++++
 hw/arm/mpam.c         | 66 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/mpam.h |  3 ++
 4 files changed, 134 insertions(+), 2 deletions(-)
 create mode 100644 hw/arm/mpam-qapi.c

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index adf9146..da73546 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -106,8 +106,9 @@ arm_common_ss.add(when: 'CONFIG_NETDUINO2', if_true: files('netduino2.c'))
 arm_common_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_peripherals.c'))
 arm_common_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2838_peripherals.c'))
 arm_common_ss.add(when: 'CONFIG_STRONGARM', if_true: files('strongarm.c'))
-arm_common_ss.add(when: 'CONFIG_MPAM', if_true: files('mpam.c'))
-arm_common_ss.add(files('mpam-qapi-stubs.c'))
+arm_common_ss.add(when: 'CONFIG_MPAM', if_true: files('mpam.c', 'mpam-qapi.c'))
+arm_common_ss.add(when: 'CONFIG_MPAM', if_false: files('mpam-qapi-stubs.c'))
+arm_common_ss.add(when: 'CONFIG_ALL', if_true: files('mpam-qapi-stubs.c'))
 arm_common_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
 arm_common_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
 arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
diff --git a/hw/arm/mpam-qapi.c b/hw/arm/mpam-qapi.c
new file mode 100644
index 0000000..ceed734
--- /dev/null
+++ b/hw/arm/mpam-qapi.c
@@ -0,0 +1,62 @@
+/*
+ * QEMU MPAM QMP commands
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/arm/mpam.h"
+#include "qom/object.h"
+#include "qapi/qapi-commands-mpam.h"
+
+typedef struct MPAMQueryState {
+    Error **errp;
+    MpamCacheInfoList **head;
+    bool level_filter_on;
+    int level;
+} MPAMQueryState;
+
+static int mpam_query_cache(Object *obj, void *opaque)
+{
+    MPAMQueryState *state = opaque;
+    MpamCacheInfoList *infolist;
+    MpamCacheInfo *info;
+
+    if (!object_dynamic_cast(obj, TYPE_MPAM_MSC_CACHE)) {
+        return 0;
+    }
+    if (state->level_filter_on &&
+        object_property_get_uint(obj, "cache-level", state->errp) !=
+        state->level) {
+        return 0;
+    }
+
+    infolist = g_malloc0(sizeof(*infolist));
+    info = g_malloc0(sizeof(*info));
+
+    mpam_cache_fill_info(obj, info);
+
+    infolist->value = info;
+
+    *state->head = infolist;
+    state->head = &infolist->next;
+
+    return 0;
+}
+
+MpamCacheInfoList *qmp_query_mpam_cache(bool has_level, int64_t level,
+                                        Error **errp)
+{
+
+    MpamCacheInfoList *head = NULL;
+    MPAMQueryState state = {
+        .errp = errp,
+        .head = &head,
+        .level_filter_on = has_level,
+        .level = level,
+    };
+
+    object_child_foreach_recursive(object_get_root(), mpam_query_cache, &state);
+
+    return head;
+}
diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
index 6c43e3e..f4f40ca 100644
--- a/hw/arm/mpam.c
+++ b/hw/arm/mpam.c
@@ -645,6 +645,72 @@ DECLARE_INSTANCE_CHECKER(MPAMMSCMemState, MPAM_MSC_MEM_DEVICE,
 DECLARE_INSTANCE_CHECKER(MPAMMSCCacheState, MPAM_MSC_CACHE_DEVICE,
                          TYPE_MPAM_MSC_CACHE);
 
+void mpam_cache_fill_info(Object *obj, MpamCacheInfo *info)
+{
+    MPAMMSCCacheState *cs = MPAM_MSC_CACHE_DEVICE(obj);
+    MPAMMSCState *s = MPAM_MSC_DEVICE(obj);
+    MpamRegsList *reg_list = NULL, **r_next = &reg_list;
+    int i, p, b;
+
+    info->cpu = cs->cpu;
+    info->level = cs->cache_level;
+    info->type = cs->cache_level;
+    for (i = 0; i < s->num_ris; i++) {
+        MpamRegsList *regs;
+        MpamRegs *r;
+        MpamBmList *bm_list = NULL, **bm_next = &bm_list;
+
+        Mpamf *mpamf = &s->mpamf[i];
+
+        r = g_malloc0(sizeof(*r));
+        regs = g_malloc0(sizeof(*regs));
+        regs->value = r;
+
+        *r = (MpamRegs) {
+            .idr = mpamf->idr,
+            .iidr = mpamf->iidr,
+            .aidr = mpamf->aidr,
+            .cpor_idr = mpamf->cpor_idr,
+            .ccap_idr = mpamf->ccap_idr,
+            .mbw_idr = mpamf->mbw_idr,
+            .pri_idr = mpamf->pri_idr,
+            .partid_nrw_idr = mpamf->partid_nrw_idr,
+            .msmon_idr = mpamf->msmon_idr,
+            .csumon_idr = mpamf->csumon_idr,
+            .mbwumon_idr = mpamf->mbwumon_idr,
+            .ecr = mpamf->ecr,
+            .esr = mpamf->esr,
+            .cfg_part_sel = mpamf->cfg_part_sel, /* Garbage */
+        };
+
+        /* This is annoyingly complex */
+        for (p = 0; p < s->num_int_partid; p++) {
+            intList *w_list = NULL, **w_next = &w_list;
+            MpamBm *bm = g_malloc0(sizeof(*bm));
+            MpamBmList *bml = g_malloc0(sizeof(*bml));
+
+            bml->value = bm;
+
+            for (b = 0; b < (MPAM_CACHE_PART + 31) / 32; b++) {
+                intList *il = g_malloc0(sizeof(*il));
+
+                il->value = mpamf->per_nrw_id[p].cfg_cpbm[b];
+                *w_next = il;
+                w_next = &il->next;
+
+            }
+            *bm_next = bml;
+            bm_next = &bml->next;
+            bm->words = w_list;
+        }
+        r->cfg_cpbm = bm_list;
+        *r_next = regs;
+        r_next = &regs->next;
+    }
+    info->regs = reg_list;
+
+}
+
 static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
                                   unsigned size)
 {
diff --git a/include/hw/arm/mpam.h b/include/hw/arm/mpam.h
index e7557a9..cb1c106 100644
--- a/include/hw/arm/mpam.h
+++ b/include/hw/arm/mpam.h
@@ -7,6 +7,7 @@
 #define _MPAM_H_
 
 #include "qom/object.h"
+#include "qapi/qapi-commands-mpam.h"
 
 #define TYPE_MPAM_MSC_MEM "mpam-msc-mem"
 #define TYPE_MPAM_MSC_CACHE "mpam-msc-cache"
@@ -17,4 +18,6 @@
  */
 #define MPAM_SIZE 0x4000
 
+void mpam_cache_fill_info(Object *obj, MpamCacheInfo *info);
+
 #endif /* _MPAM_H_ */
-- 
2.43.0


