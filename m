Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3827FCB608
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWeg-0003jZ-9z; Fri, 06 Mar 2026 09:59:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWed-0003Zr-TS
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:59:51 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWec-0002Iy-3Q
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:59:51 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-439ce3605ecso1481334f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 06:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809188; x=1773413988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+gNqFXUqIbXenOcWJQEnfBJDWo4MPWIcT3pXhz76S+8=;
 b=wReDVYFBCU+7KCDq6v0fJDJ7L429bOoNU7zDFazPYkF/tA+CuAZ/WIsKsgfUckLMl+
 YYQLmXGyFXTfVDO4gnKO+8YR+ISGrhd8yBxXfJg7o7TbRu4Nq744549/tH2WVuPVvou/
 k+q4XBFUnlxo+0Il48cF0j3ng+CkGquSGtCWljz9vJb1iig9ZF+WZJ60zs3OHF3nWJiP
 vNw01LhAOSq7C+moLsdTPRBajdFYyub43GqZmmV7siWFykoy+mFh2PzTayGfnwwmTrGC
 R2HDLMiq6jYOeCnyajWJ8qobu5xGNAdP/bpgC1w2SXuz3sXrJG09OdY9wBmrzQ4lQZ5k
 /oDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809188; x=1773413988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+gNqFXUqIbXenOcWJQEnfBJDWo4MPWIcT3pXhz76S+8=;
 b=MtlZNe3nb+kBxGtHK/9EmA4CV5/X0vJ14nmVJc/QsGHdBTImtQqH0NmIdc8pIDkD2c
 NnCFVkwZFCu2KhFmWjsGYtFuJn1qTKV79MHPdn07SAyu5OcDPEyozpElkMkI50UFW6i9
 ow2n++lnRL/+E+8CjYZn4/j3y6T4Onb5Y9vyYlATVq3Cxa2KEyTlgcO4GAqN3PdFX7sd
 nPSlel+QfY89KdWVIS3J/eYqi5NSElbyXrKyqAe1pdHSJ3Gd3utnDbjHejrAdqziRKvF
 Wmn9m6rXVOC69/4u0LDZzUiRkY/gJ935GNPlA/RCWVZdoRMSQ6d/8zApo21gYwY36fS5
 oJVg==
X-Gm-Message-State: AOJu0YxErAmZQP0J3RjeMI2wxrQV8kmk/+sEoQdBQcqsohpq4ZpQky3z
 jcLOUsS4OBmE1EgFbhjXZYuaWftr1lKO6yEDF5wS3wXsN4of0fBw8DUzH84thFo17x4riBngfls
 bjdQr
X-Gm-Gg: ATEYQzz9h7WTqDBZADwQAhpquiY3rii10v7YFK2py0qNjwl5pI6+290gtHHE1kVWWtA
 4SuZkb/TfPsWxsJemFmq5/HLw0bFnmxvCbosynowUG7OmYWQSZIV9wO3k37bVrsBATioLnHSEKJ
 JGpnpdCO7mv94VwopIc+dwrOb9h516xuZ2lrJZyBsRhwgojms5RSNt5OiB4OMHJg0WYgvMImE/x
 DsL7FWPEfboD5lIAh6ATFqNpyDFkP68wJo5lcmc6iQK7H0993UZSC4NOs+JhLx8PEg1/YGZwdDr
 7ZrsLOg4LwMta2wzxFpByo4z12GSY22+JwdIkxWRaXb8LDdbprqZiEqaMiD4zErUfz2L5LY//QW
 8a1wkrSd6jCYUlK9ArraHoI76a1uayX4CXmkZMe+Y8Xu93TumpGZW5X6rguo+2lhZMN6vs/lAIH
 j0gSvhnzQSl+gGDe76pLaNVMre7tn1Ic7DMElUJ9ZF3pVrf5DV42k/H/3fzxhM4a4irdz5taUiY
 SmUlwaz7TF+C112/pzfkQX51aU1WEU=
X-Received: by 2002:a05:600c:8b0d:b0:482:dbd7:a1c1 with SMTP id
 5b1f17b1804b1-48526984289mr37146415e9.34.1772809188178; 
 Fri, 06 Mar 2026 06:59:48 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.06.59.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 06:59:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/49] hw/arm/smmuv3: Introduce a helper function for event
 propagation
Date: Fri,  6 Mar 2026 14:58:57 +0000
Message-ID: <20260306145939.2162189-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

Factor out the code that propagates event records to the guest into a
helper function. The accelerated SMMUv3 path can use this to propagate
host events in a subsequent patch.

Take the mutex inside the helper before accessing the Event Queue.
Today event propagation occurs only in the core SMMUv3 path and is
effectively serialized. A subsequent patch will also invoke this helper
from the accelerated event read path, which may run concurrently.
Therefore serialization is required here.

No functional change intended.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260226084456.112142-5-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-internal.h |  4 ++++
 hw/arm/smmuv3.c          | 20 ++++++++++++++------
 hw/arm/trace-events      |  2 +-
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index a6464425ec..b666109ad9 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -352,7 +352,11 @@ typedef struct SMMUEventInfo {
             (x)->word[6] = (uint32_t)(addr & 0xffffffff); \
     } while (0)
 
+#define EVT_GET_TYPE(x)  extract32((x)->word[0], 0, 8)
+#define EVT_GET_SID(x)   ((x)->word[1])
+
 void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *event);
+void smmuv3_propagate_event(SMMUv3State *s, Evt *evt);
 int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event);
 
 static inline int oas2bits(int oas_field)
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 5d718da764..af7a54143f 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -168,10 +168,22 @@ static MemTxResult smmuv3_write_eventq(SMMUv3State *s, Evt *evt)
     return MEMTX_OK;
 }
 
+void smmuv3_propagate_event(SMMUv3State *s, Evt *evt)
+{
+    MemTxResult r;
+
+    trace_smmuv3_propagate_event(smmu_event_string(EVT_GET_TYPE(evt)),
+                                 EVT_GET_SID(evt));
+    QEMU_LOCK_GUARD(&s->mutex);
+    r = smmuv3_write_eventq(s, evt);
+    if (r != MEMTX_OK) {
+        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_EVENTQ_ABT_ERR_MASK);
+    }
+}
+
 void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
 {
     Evt evt = {};
-    MemTxResult r;
 
     if (!smmuv3_eventq_enabled(s)) {
         return;
@@ -251,11 +263,7 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
         g_assert_not_reached();
     }
 
-    trace_smmuv3_record_event(smmu_event_string(info->type), info->sid);
-    r = smmuv3_write_eventq(s, &evt);
-    if (r != MEMTX_OK) {
-        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_EVENTQ_ABT_ERR_MASK);
-    }
+    smmuv3_propagate_event(s, &evt);
     info->recorded = true;
 }
 
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 8135c0c734..3457536fb0 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -40,7 +40,7 @@ smmuv3_cmdq_opcode(const char *opcode) "<--- %s"
 smmuv3_cmdq_consume_out(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "prod:%d, cons:%d, prod_wrap:%d, cons_wrap:%d "
 smmuv3_cmdq_consume_error(const char *cmd_name, uint8_t cmd_error) "Error on %s command execution: %d"
 smmuv3_write_mmio(uint64_t addr, uint64_t val, unsigned size, uint32_t r) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x(%d)"
-smmuv3_record_event(const char *type, uint32_t sid) "%s sid=0x%x"
+smmuv3_propagate_event(const char *type, uint32_t sid) "%s sid=0x%x"
 smmuv3_find_ste(uint16_t sid, uint32_t features, uint16_t sid_split) "sid=0x%x features:0x%x, sid_split:0x%x"
 smmuv3_find_ste_2lvl(uint64_t strtab_base, uint64_t l1ptr, int l1_ste_offset, uint64_t l2ptr, int l2_ste_offset, int max_l2_ste) "strtab_base:0x%"PRIx64" l1ptr:0x%"PRIx64" l1_off:0x%x, l2ptr:0x%"PRIx64" l2_off:0x%x max_l2_ste:%d"
 smmuv3_get_ste(uint64_t addr) "STE addr: 0x%"PRIx64
-- 
2.43.0


