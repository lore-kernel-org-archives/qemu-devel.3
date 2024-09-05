Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745B0CD5BAA
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 11:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smAZr-0008TM-1k; Thu, 05 Sep 2024 07:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3i5TZZggKClgM74D3H8A6EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--whendrik.bounces.google.com>)
 id 1smAZl-0008KC-IO
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 07:23:00 -0400
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3i5TZZggKClgM74D3H8A6EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--whendrik.bounces.google.com>)
 id 1smAZi-0002yB-IA
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 07:22:57 -0400
Received: by mail-wm1-x349.google.com with SMTP id
 5b1f17b1804b1-42c80412dc1so5769525e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 04:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1725535371; x=1726140171; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=lFaNWg8OWFczEyq2WHl6zYa8BiQZim1ugNOx63N6xVc=;
 b=O7OPOD7zWqtW63IP4Iz3suheIY9UL3wiMlO9+AM+3S6xW5pYsOIXzzeKo0tHnYBgA8
 KvK9mHbfUUv50hxDdi0a7+wrPkfLdjbiv6uByxKC8bw0vMyxWtoJSMEF0osUlODQwYdM
 nmFQ+nB3x6KePBqWGJ0w5qhr6clTo+TgI0RtpbSWs7FFazvTQ93Wh0E30x3P8sbUuW50
 sfqbYgwq87S3Pm4+nWAC3e4cjYGfxs/lf6idxfu5RBJIuae6nKzi3vmIEXvvKEn+xAkH
 VzhYotOjcLC999ny89aDHicJVX1vkcqfv0omnXegeoY4Mr3OmE4eBxUCsKw7VxQM3maE
 7Yww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725535371; x=1726140171;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=lFaNWg8OWFczEyq2WHl6zYa8BiQZim1ugNOx63N6xVc=;
 b=a8w29vlpXKQHZs0RbuooiHJrDzBVjVaHTB6ZBoPCwr3dtqyeL6v/laaxmawKg7rXs4
 ieyu9ujTYsYexhqP+xlf5BNGEjMMdi8sWjjnv27v/1FHtVoDk3MfvFHiLUbxQdRn5HEw
 c7SIwoyUtenx8B6XinhUqx6MIPBbwbTBfVh1b8SagfpO9MHYVVBm14l9bFuZwS8uFPH+
 Z4y/i0vYivy5J5W6XRNF8sagYAMTrjNiFIaMyfFK/yOiUL+ROgEdhn6MW52pGw1WhXNL
 Omiq6PuxjG2syTEoXKFIX9rIr1GYFGiSr3F4FXNB9CA3My/e2o3rcxY60qnvxSe04awt
 yWcQ==
X-Gm-Message-State: AOJu0Yzeo8NLnROwQndZ/FZqRdev2Y3fLmSGKngiriWrlu3D+NQwnvZn
 Y0smgBe4yNjWiuQqoG7ZI+QFm9d1rB5Uo13ilWpUJezCEEEukoViuu7nO2GE0fosOnSrVm1jiBL
 eRykFvuE4VatucVee/7g6PVi0EVKVnhGfD5NzTSeJfBEYsH5vkdeTRz1ZKGdhzldXCQOdYU5dR9
 L9CVMCtucGWYzyihVNxduda/mQpFi9freoiUbrtdyEzQ==
X-Google-Smtp-Source: AGHT+IE9PM3K8A/rfhGKcerdF03Vl+fPELu1Yj80Mt8JhiPeDAXc6RQEz6Zwv3oaiunPrlVRlUyd51T8EZRbfQ==
X-Received: from whendrik-specialist-workstation.c.googlers.com
 ([fda3:e722:ac3:cc00:130:7cd9:ac11:98f1]) (user=whendrik job=sendgmr) by
 2002:adf:ee52:0:b0:374:bd06:7ea3 with SMTP id
 ffacd0b85a97d-374bd067f89mr24038f8f.2.1725535371198; 
 Thu, 05 Sep 2024 04:22:51 -0700 (PDT)
Date: Thu,  5 Sep 2024 11:22:32 +0000
In-Reply-To: <20240905112237.3586972-1-whendrik@google.com>
Mime-Version: 1.0
References: <20240905112237.3586972-1-whendrik@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240905112237.3586972-4-whendrik@google.com>
Subject: [PATCH v2 3/8] i386: Add RDT functionality
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, eduardo@habkost.net, 
 richard.henderson@linaro.org, marcel.apfelbaum@gmail.com, mst@redhat.com, 
 pbonzini@redhat.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::349;
 envelope-from=3i5TZZggKClgM74D3H8A6EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--whendrik.bounces.google.com;
 helo=mail-wm1-x349.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
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
index c395ab91a9..288f1fd107 100644
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
 #define RDT_MAX_L3_MASK_COUNT      128
 #define RDT_MAX_L2_MASK_COUNT      48
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
+    uint32_t count_local =3D 0;
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
index a21d95b265..14b1c64b72 100644
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
 #endif
--=20
2.46.0.469.g59c65b2a67-goog


