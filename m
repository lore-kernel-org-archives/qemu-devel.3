Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A8DE7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 08:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIl42-0000Am-JX; Wed, 04 Dec 2024 03:48:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3cRdQZwgKCiIUFCLBPGIEMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--whendrik.bounces.google.com>)
 id 1tIl41-00009a-G9
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 03:48:53 -0500
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3cRdQZwgKCiIUFCLBPGIEMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--whendrik.bounces.google.com>)
 id 1tIl3z-000115-MJ
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 03:48:53 -0500
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-434941aa9c2so36879785e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 00:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1733302129; x=1733906929; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=sCZcKH4Kr7ShBFnIBULtC4cA/q7iBWqSRHDgtiBni9Y=;
 b=hd+o41kHBUb0hFBS+zNinEa24Ugbk01G0pTbrvp45nhKc0WP4dvCatb66Ag6NI8mAZ
 dO0LAvYtGcZSv24eY7SVAqkhcZNUldrCsknwGQr716hdbuP21/rLwwWByYCjP/HF+LSy
 0O4CMI3roAlDnVIGpx5TBZvsWyvV84p7hULYn/GMbCfJkNhCrQsW2Yh+dBoFCEgmSTm4
 1gOgKiNp/8gw1FQTbSehiMMIfNNsqeKtU4y4vqCU7Ysr8qkpt3i+r8bO/8TWOo7ITdHv
 Xo8oCZYg5rAicpZFBP2tipiqIYcex7w4A/qR4DeVYBlCatVVvr28KnKqczZ17hIIMBA9
 Y2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733302129; x=1733906929;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=sCZcKH4Kr7ShBFnIBULtC4cA/q7iBWqSRHDgtiBni9Y=;
 b=vU2So0IF198x6cHnEeNR4UPSgddxTJRl6m2ngyGyZI5Gw8N8NdtYPQ1Gu6hKiQofMC
 tyGT/sXki9rH4iMZJsrfs4ZOcyOcVm2Fb2Dg4UQXbgHDgJo5ncpx2zBHsqycTv3d9nLV
 kMrRSEnjUjvZ6/KssRUJjBcFM4cWGjVDu6uYIdeRMMw7g2n2nHYIZ8y8GwwReNRt2UKg
 V3LTMlW2h/CgBSv6BysGILMn3zWLzH5HlzMOz1WL9ce64Az9NWWzbje69E3IDcIXcb4u
 e5BWB/UiHRf0HsS6TXyvPDHgbNuhidG8qfPj4ElGpu4G02FHjd+Fd/3Xz+1lNw0KXYzW
 gIUg==
X-Gm-Message-State: AOJu0Yx3uoP/058T0ISXUA2Atj8IKfkXSjPnSDZOpbfMnZJZWqCsdzOO
 2SyUcVDsT90nuCPleUuWZlh58k748F4/wJyCJg1LcAonEdyDyoutSnVN4u8SISNZd7+dcL1PahA
 n+CQ5UX/H40TewUKgOE6EMBgeHXcn2j/rXSxIw/QvSDCTp0U/9w+Gpp9UZuXeHHWrpZCT2IBKrC
 m+zvjtlj8YWeoXLAQd4bT1mNkqj1/yDalhNe2oLl6u6A==
X-Google-Smtp-Source: AGHT+IGORsmFmY/qcnvRgJKrupRQH9HUbV1wIJx8SptaX+RkwHAOAdkvgqFCIHwY6qETcjnoMvvhxXxV71SgsQ==
X-Received: from wmpb42.prod.google.com ([2002:a05:600c:4aaa:b0:434:a3bc:96d2])
 (user=whendrik job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1e21:b0:434:9934:575 with SMTP id
 5b1f17b1804b1-434d3fae14dmr30406485e9.16.1733302129595; 
 Wed, 04 Dec 2024 00:48:49 -0800 (PST)
Date: Wed,  4 Dec 2024 08:48:32 +0000
In-Reply-To: <20241204084837.517299-1-whendrik@google.com>
Mime-Version: 1.0
References: <20241204084837.517299-1-whendrik@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204084837.517299-4-whendrik@google.com>
Subject: [PATCH v3 3/8] i386: Add RDT functionality
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, eduardo@habkost.net, 
 richard.henderson@linaro.org, marcel.apfelbaum@gmail.com, mst@redhat.com, 
 pbonzini@redhat.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=3cRdQZwgKCiIUFCLBPGIEMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--whendrik.bounces.google.com;
 helo=mail-wm1-x34a.google.com
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.453,
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

From: =E2=80=AAHendrik W=C3=BCthrich <whendrik@google.com>

Add RDT code to Associate CLOSID with RMID / set RMID for monitoring,
write COS, and read monitoring data. This patch does not add code for
the guest to interact through these things with MSRs, only the actual
ability for the RDT device to do them.

Signed-off-by: Hendrik W=C3=BCthrich <whendrik@google.com>
---
 hw/i386/rdt.c         | 124 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/i386/rdt.h |  16 ++++++
 2 files changed, 140 insertions(+)

diff --git a/hw/i386/rdt.c b/hw/i386/rdt.c
index 2fb9fb476b..19fea8999a 100644
--- a/hw/i386/rdt.c
+++ b/hw/i386/rdt.c
@@ -21,6 +21,11 @@
 #include "qom/object.h"
 #include "target/i386/cpu.h"
=20
+/* RDT Monitoring Event Codes */
+#define RDT_EVENT_L3_OCCUPANCY 1
+#define RDT_EVENT_L3_REMOTE_BW 2
+#define RDT_EVENT_L3_LOCAL_BW 3
+
 /* Max counts for allocation masks or CBMs. In other words, the size of re=
spective MSRs*/
 #define RDT_MAX_L3_MASK_COUNT      127
 #define RDT_MAX_L2_MASK_COUNT      63
@@ -29,6 +34,9 @@
 #define TYPE_RDT "rdt"
 #define RDT_NUM_RMID_PROP "rmids"
=20
+#define QM_CTR_ERROR        (1ULL << 63)
+#define QM_CTR_UNAVAILABLE  (1ULL << 62)
+
 OBJECT_DECLARE_TYPE(RDTState, RDTStateClass, RDT);
=20
 struct RDTMonitor {
@@ -69,6 +77,122 @@ struct RDTState {
 struct RDTStateClass {
 };
=20
+bool rdt_associate_rmid_cos(uint64_t msr_ia32_pqr_assoc) {
+    X86CPU *cpu =3D X86_CPU(current_cpu);
+    RDTStatePerCore *rdt =3D cpu->rdt;
+    RDTAllocation *alloc;
+
+    uint32_t cos_id =3D (msr_ia32_pqr_assoc & 0xffff0000) >> 16;
+    uint32_t rmid =3D msr_ia32_pqr_assoc & 0xffff;
+
+    if (cos_id > RDT_MAX_L3_MASK_COUNT || cos_id > RDT_MAX_L2_MASK_COUNT |=
|
+    cos_id > RDT_MAX_MBA_THRTL_COUNT || rmid > rdt_max_rmid(rdt)) {
+        return false;
+    }
+
+    rdt->active_rmid =3D rmid;
+
+    alloc =3D &rdt->rdtstate->allocations[rmid];
+
+    alloc->active_cos =3D cos_id;
+
+    return true;
+}
+
+uint32_t rdt_read_l3_mask(uint32_t pos)
+{
+    X86CPU *cpu =3D X86_CPU(current_cpu);
+    RDTStatePerCore *rdt =3D cpu->rdt;
+
+    uint32_t val =3D rdt->rdtstate->msr_L3_ia32_mask_n[pos];
+    return val;
+}
+
+uint32_t rdt_read_l2_mask(uint32_t pos)
+{
+    X86CPU *cpu =3D X86_CPU(current_cpu);
+    RDTStatePerCore *rdt =3D cpu->rdt;
+
+    uint32_t val =3D rdt->rdtstate->msr_L2_ia32_mask_n[pos];
+    return val;
+}
+
+uint32_t rdt_read_mba_thrtl(uint32_t pos)
+{
+    X86CPU *cpu =3D X86_CPU(current_cpu);
+    RDTStatePerCore *rdt =3D cpu->rdt;
+
+    uint32_t val =3D rdt->rdtstate->ia32_L2_qos_ext_bw_thrtl_n[pos];
+    return val;
+}
+
+void rdt_write_msr_l3_mask(uint32_t pos, uint32_t val) {
+    X86CPU *cpu =3D X86_CPU(current_cpu);
+    RDTStatePerCore *rdt =3D cpu->rdt;
+
+    rdt->rdtstate->msr_L3_ia32_mask_n[pos] =3D val;
+}
+
+void rdt_write_msr_l2_mask(uint32_t pos, uint32_t val) {
+    X86CPU *cpu =3D X86_CPU(current_cpu);
+    RDTStatePerCore *rdt =3D cpu->rdt;
+
+    rdt->rdtstate->msr_L2_ia32_mask_n[pos] =3D val;
+}
+
+void rdt_write_mba_thrtl(uint32_t pos, uint32_t val) {
+    X86CPU *cpu =3D X86_CPU(current_cpu);
+    RDTStatePerCore *rdt =3D cpu->rdt;
+
+    rdt->rdtstate->ia32_L2_qos_ext_bw_thrtl_n[pos] =3D val;
+}
+
+uint32_t rdt_max_rmid(RDTStatePerCore *rdt)
+{
+    RDTState *rdtdev =3D rdt->rdtstate;
+    return rdtdev->rmids - 1;
+}
+
+uint64_t rdt_read_event_count(RDTStatePerCore *rdtInstance, uint32_t rmid,=
 uint32_t event_id)
+{
+    CPUState *cs;
+    RDTMonitor *mon;
+    RDTState *rdt =3D rdtInstance->rdtstate;
+
+    uint32_t count_l3 =3D 0;
+    uint32_t count_local=3D 0;
+    uint32_t count_remote =3D 0;
+
+    if (!rdt) {
+        return 0;
+    }
+
+    CPU_FOREACH(cs) {
+        rdtInstance =3D &rdt->rdtInstances[cs->cpu_index];
+        if (rmid >=3D rdtInstance->monitors->len) {
+            return QM_CTR_ERROR;
+        }
+        mon =3D &g_array_index(rdtInstance->monitors, RDTMonitor, rmid);
+        count_l3 +=3D mon->count_l3;
+        count_local +=3D mon->count_local;
+        count_remote +=3D mon->count_remote;
+    }
+
+    switch (event_id) {
+        case RDT_EVENT_L3_OCCUPANCY:
+            return count_l3 =3D=3D 0 ? QM_CTR_UNAVAILABLE : count_l3;
+            break;
+        case RDT_EVENT_L3_REMOTE_BW:
+            return count_remote =3D=3D 0 ? QM_CTR_UNAVAILABLE : count_remo=
te;
+            break;
+        case RDT_EVENT_L3_LOCAL_BW:
+            return count_local =3D=3D 0 ? QM_CTR_UNAVAILABLE : count_local=
;
+            break;
+        default:
+            return QM_CTR_ERROR;
+    }
+}
+
 OBJECT_DEFINE_TYPE(RDTState, rdt, RDT, ISA_DEVICE);
=20
 static Property rdt_properties[] =3D {
diff --git a/include/hw/i386/rdt.h b/include/hw/i386/rdt.h
index a21d95b265..875142bad8 100644
--- a/include/hw/i386/rdt.h
+++ b/include/hw/i386/rdt.h
@@ -17,9 +17,25 @@
 #ifndef HW_RDT_H
 #define HW_RDT_H
=20
+#include <stdbool.h>
+#include <stdint.h>
+
 typedef struct RDTState RDTState;
 typedef struct RDTStatePerCore RDTStatePerCore;
 typedef struct RDTMonitor RDTMonitor;
 typedef struct RDTAllocation RDTAllocation;
=20
 #endif
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
+uint64_t rdt_read_event_count(RDTStatePerCore *rdt, uint32_t rmid, uint32_=
t event_id);
+uint32_t rdt_max_rmid(RDTStatePerCore *rdt);
+
--=20
2.47.0.338.g60cca15819-goog


