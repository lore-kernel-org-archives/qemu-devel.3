Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7371C282D0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 20:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to6bx-0005Lp-Qu; Fri, 28 Feb 2025 15:05:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <37xbCZwgKCmoePMVLZQSOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--whendrik.bounces.google.com>)
 id 1to6bc-0004wG-TB
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 15:05:10 -0500
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <37xbCZwgKCmoePMVLZQSOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--whendrik.bounces.google.com>)
 id 1to6ba-00016H-Bk
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 15:05:08 -0500
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-4399a5afc72so12993005e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 12:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1740773103; x=1741377903; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=BwTgJJO2SlsGl4rYeVMdy42gc14Aj/IPZZveRoI2VoA=;
 b=Mzfcu1aSfIlaNkrYe/oxWRJxFxl8UASYJQKSjCeUBcN4oTRUDrIhn3u16u6YsTx/us
 M4NoSKhukFTs5fEAESlu4evIDQp5bN8XRMLhLkMde+pyoaYqqh1XjhgifTCcgZ74zSrY
 7lFsiGmNKAu0TakvopYvBzF0K2nflq3UpP6mTIKt1t6ZdkxiE1Y/IWdUf2+YGvwlJ2wD
 9GSoNzBbBYeUwsxuzFUZpts3qDzPxPL5ZTXtbN2YeRi/kdQEiGDsbNulCE5qZcY12tRp
 b7VgD3zb+COgVYVQXrfVQ5QfsUIeMvdOzYCCiQpO5OXoGIt9aovQZGSseUjLm7w+jHAY
 ileQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740773103; x=1741377903;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BwTgJJO2SlsGl4rYeVMdy42gc14Aj/IPZZveRoI2VoA=;
 b=Xtt2dWyfhydja16XjexPHyedhNtJVwc5QNEYVa90UtpIj1UWirLlyp3Bs6QWoQtiVx
 2DkgwXtYWvzmjYDSuZ67IZ/KepTMuoVs1dnFopFlK7wd0NCdAaAb628Pur1PT+6TkRQC
 3RQBh4RYWzo7qd/4eOubemQ7m5KwT/d4Y0SCVXBsaWbTln/S6Atimra4jgrvERPk3UvT
 srWAdCVbPFT/VqJgexnHrrCpDN1EHa5JG6/HeQjVjbPoua704oycVzmirxJXyrYBmPkA
 Od/dBvbCQEsoBYoWTwQoAXxMBYBWgGMi6nRo9i7WWDhsS3m+e16Aj9JMmGNvj5OTrJd6
 c3YA==
X-Gm-Message-State: AOJu0YwSVb9lSdBqEy0n8UrDh0pbZQVrcqVJrKTUETMISGAbAzTDpI6r
 8aBB2uUmlJjCP8A01A3sbQ6UME3muXoLhH1vHehbUjkmLNPhXlIYNfq59Zdbs7g4vF2VRvh6XhG
 tLmxzjzc9kh6nC8+AAYIiAbBboMdGRrG00x+5Q0uRa6b2QQfHZH5dfzsSub0OAOp/qN3IU3v6IQ
 Xo3UeoIkCoIg/v/c96SXexGEtlsZLZXaVfIOL2f/W+lA==
X-Google-Smtp-Source: AGHT+IEtdtVOtWqGgDtExekSulp7Zlq4K94heqhVYF+st1QF5a4L2jdS6zQypslzGA1NEYQSWcLQuj635k4zng==
X-Received: from wmdd18.prod.google.com ([2002:a05:600c:a212:b0:439:96eb:cfa0])
 (user=whendrik job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5106:b0:439:9496:181c with SMTP id
 5b1f17b1804b1-43ba67745d4mr43309435e9.29.1740773103477; 
 Fri, 28 Feb 2025 12:05:03 -0800 (PST)
Date: Fri, 28 Feb 2025 20:04:48 +0000
In-Reply-To: <20250228200453.45173-1-whendrik@google.com>
Mime-Version: 1.0
References: <20250228200453.45173-1-whendrik@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228200453.45173-3-whendrik@google.com>
Subject: [PATCH v6 3/8] i386: Add RDT functionality
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com, 
 zhao1.liu@intel.com, xiaoyao.li@intel.com, Jonathan.Cameron@huawei.com, 
 v6-0000-cover-letter.patch@google.com
Cc: peternewman@google.com, Hendrik Wuethrich <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=37xbCZwgKCmoePMVLZQSOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--whendrik.bounces.google.com;
 helo=mail-wm1-x34a.google.com
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

Add RDT code to Associate CLOSID with RMID / set RMID for monitoring,
write COS, and read monitoring data. This patch does not add code for
the guest to interact through these things with MSRs, only the actual
ability for the RDT device to do them.

Signed-off-by: Hendrik Wuethrich <whendrik@google.com>
---
 hw/i386/rdt.c         | 145 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/i386/rdt.h |  16 +++++
 2 files changed, 161 insertions(+)

diff --git a/hw/i386/rdt.c b/hw/i386/rdt.c
index 498c7b70ad..32ef1ee124 100644
--- a/hw/i386/rdt.c
+++ b/hw/i386/rdt.c
@@ -22,9 +22,17 @@
 #include "qom/object.h"
 #include "target/i386/cpu.h"
 
+/* RDT Monitoring Event Codes */
+#define RDT_EVENT_L3_OCCUPANCY 1
+#define RDT_EVENT_L3_REMOTE_BW 2
+#define RDT_EVENT_L3_LOCAL_BW 3
+
 #define TYPE_RDT "rdt"
 #define RDT_NUM_RMID_PROP "rmids"
 
+#define QM_CTR_ERROR        (1ULL << 63)
+#define QM_CTR_UNAVAILABLE  (1ULL << 62)
+
 OBJECT_DECLARE_TYPE(RDTState, RDTStateClass, RDT);
 
 struct RDTMonitor {
@@ -73,6 +81,143 @@ struct RDTState {
 struct RDTStateClass {
 };
 
+bool rdt_associate_rmid_cos(uint64_t msr_ia32_pqr_assoc)
+{
+    X86CPU *cpu = X86_CPU(current_cpu);
+    RDTStatePerL3Cache *rdtStatePerL3Cache = cpu->rdtStatePerL3Cache;
+    RDTStatePerCore *rdtPerCore = cpu->rdtPerCore;
+    RDTAllocation *alloc;
+
+    uint32_t cos_id = (msr_ia32_pqr_assoc & 0xffff0000) >> 16;
+    uint32_t rmid = msr_ia32_pqr_assoc & 0xffff;
+
+    if (cos_id > RDT_MAX_L3_MASK_COUNT || cos_id > RDT_MAX_L2_MASK_COUNT ||
+        cos_id > RDT_MAX_MBA_THRTL_COUNT || rmid > rdt_max_rmid(rdtStatePerL3Cache)) {
+        return false;
+    }
+
+    qemu_mutex_lock(&rdtPerCore->lock);
+    qemu_mutex_lock(&rdtStatePerL3Cache->lock);
+
+    rdtPerCore->active_rmid = rmid;
+
+    alloc = &rdtStatePerL3Cache->rdtstate->allocations[rmid];
+
+    alloc->active_cos = cos_id;
+
+    qemu_mutex_unlock(&rdtStatePerL3Cache->lock);
+    qemu_mutex_unlock(&rdtPerCore->lock);
+
+    return true;
+}
+
+uint32_t rdt_read_l3_mask(uint32_t pos)
+{
+    X86CPU *cpu = X86_CPU(current_cpu);
+    RDTStatePerL3Cache *rdt = cpu->rdtStatePerL3Cache;
+
+    qemu_mutex_lock(&rdt->lock);
+    return rdt->msr_L3_ia32_mask_n[pos];
+    qemu_mutex_unlock(&rdt->lock);
+}
+
+uint32_t rdt_read_l2_mask(uint32_t pos)
+{
+    X86CPU *cpu = X86_CPU(current_cpu);
+    RDTStatePerL3Cache *rdt = cpu->rdtStatePerL3Cache;
+
+    qemu_mutex_lock(&rdt->lock);
+    return rdt->msr_L2_ia32_mask_n[pos];
+    qemu_mutex_unlock(&rdt->lock);
+}
+
+uint32_t rdt_read_mba_thrtl(uint32_t pos)
+{
+    X86CPU *cpu = X86_CPU(current_cpu);
+    RDTStatePerL3Cache *rdt = cpu->rdtStatePerL3Cache;
+
+    qemu_mutex_lock(&rdt->lock);
+    return rdt->ia32_L2_qos_ext_bw_thrtl_n[pos];
+    qemu_mutex_unlock(&rdt->lock);
+}
+
+void rdt_write_msr_l3_mask(uint32_t pos, uint32_t val)
+{
+    X86CPU *cpu = X86_CPU(current_cpu);
+    RDTStatePerL3Cache *rdt = cpu->rdtStatePerL3Cache;
+
+    qemu_mutex_lock(&rdt->lock);
+    rdt->msr_L3_ia32_mask_n[pos] = val;
+    qemu_mutex_unlock(&rdt->lock);
+}
+
+void rdt_write_msr_l2_mask(uint32_t pos, uint32_t val)
+{
+    X86CPU *cpu = X86_CPU(current_cpu);
+    RDTStatePerL3Cache *rdt = cpu->rdtStatePerL3Cache;
+
+    qemu_mutex_lock(&rdt->lock);
+    rdt->msr_L2_ia32_mask_n[pos] = val;
+    qemu_mutex_unlock(&rdt->lock);
+}
+
+void rdt_write_mba_thrtl(uint32_t pos, uint32_t val)
+{
+    X86CPU *cpu = X86_CPU(current_cpu);
+    RDTStatePerL3Cache *rdt = cpu->rdtStatePerL3Cache;
+
+    qemu_mutex_lock(&rdt->lock);
+    rdt->ia32_L2_qos_ext_bw_thrtl_n[pos] = val;
+    qemu_mutex_unlock(&rdt->lock);
+}
+
+uint32_t rdt_max_rmid(RDTStatePerL3Cache *rdt)
+{
+    RDTState *rdtdev = rdt->rdtstate;
+    return rdtdev->rmids - 1;
+}
+
+uint64_t rdt_read_event_count(RDTStatePerL3Cache *rdtInstance,
+                              uint32_t rmid, uint32_t event_id)
+{
+    RDTMonitor *mon;
+    RDTState *rdt = rdtInstance->rdtstate;
+
+    uint32_t count_l3 = 0;
+    uint32_t count_local = 0;
+    uint32_t count_remote = 0;
+
+    if (!rdt) {
+        return 0;
+    }
+
+    qemu_mutex_lock(&rdtInstance->lock);
+
+    for (int i = 0; i < rdt->l3_caches; i++) {
+        rdtInstance = &rdt->rdtInstances[i];
+        if (rmid >= rdtInstance->rdtstate->rmids) {
+            return QM_CTR_ERROR;
+        }
+        mon = &rdtInstance->monitors[rmid];
+        count_l3 += mon->count_l3;
+        count_local += mon->count_local;
+        count_remote += mon->count_remote;
+    }
+
+    qemu_mutex_unlock(&rdtInstance->lock);
+
+    switch (event_id) {
+    case RDT_EVENT_L3_OCCUPANCY:
+        return count_l3 == 0 ? QM_CTR_UNAVAILABLE : count_l3;
+    case RDT_EVENT_L3_REMOTE_BW:
+        return count_remote == 0 ? QM_CTR_UNAVAILABLE : count_remote;
+    case RDT_EVENT_L3_LOCAL_BW:
+        return count_local == 0 ? QM_CTR_UNAVAILABLE : count_local;
+    default:
+        return QM_CTR_ERROR;
+    }
+}
+
 static inline int16_t cache_ids_contain(uint32_t current_ids[],
                                         uint16_t size, uint32_t id) {
     for (int i = 0; i < size; i++) {
diff --git a/include/hw/i386/rdt.h b/include/hw/i386/rdt.h
index 1f99f98f7f..d087627499 100644
--- a/include/hw/i386/rdt.h
+++ b/include/hw/i386/rdt.h
@@ -17,6 +17,9 @@
 #ifndef HW_RDT_H
 #define HW_RDT_H
 
+#include <stdbool.h>
+#include <stdint.h>
+
 /* Max counts for allocation masks or CBMs. In other words, the size of
  * respective MSRs.
  * L3_MASK and L3_mask are architectural limitations. THRTL_COUNT is just
@@ -32,4 +35,17 @@ typedef struct RDTStatePerCore RDTStatePerCore;
 typedef struct RDTMonitor RDTMonitor;
 typedef struct RDTAllocation RDTAllocation;
 
+bool rdt_associate_rmid_cos(uint64_t msr_ia32_pqr_assoc);
+
+void rdt_write_msr_l3_mask(uint32_t pos, uint32_t val);
+void rdt_write_msr_l2_mask(uint32_t pos, uint32_t val);
+void rdt_write_mba_thrtl(uint32_t pos, uint32_t val);
+
+uint32_t rdt_read_l3_mask(uint32_t pos);
+uint32_t rdt_read_l2_mask(uint32_t pos);
+uint32_t rdt_read_mba_thrtl(uint32_t pos);
+
+uint64_t rdt_read_event_count(RDTStatePerL3Cache *rdt, uint32_t rmid, uint32_t event_id);
+uint32_t rdt_max_rmid(RDTStatePerL3Cache *rdt);
+
 #endif
-- 
2.48.1.711.g2feabab25a-goog


