Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D412E77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 20:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJI20-0002v2-3e; Thu, 05 Dec 2024 15:01:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3YgZSZwgKCvcvgdmcqhjfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--whendrik.bounces.google.com>)
 id 1tJI1m-0002sc-2e
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:00:47 -0500
Received: from mail-wr1-x449.google.com ([2a00:1450:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3YgZSZwgKCvcvgdmcqhjfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--whendrik.bounces.google.com>)
 id 1tJI1j-0001de-Vv
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:00:45 -0500
Received: by mail-wr1-x449.google.com with SMTP id
 ffacd0b85a97d-3862a49fbdaso67742f8f.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 12:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1733428834; x=1734033634; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=L0Vl0lgng4jKpAj1S2pwpVZ8cBNzdb9nnkfVpbstCPM=;
 b=BF8HjJ6cgMZrGR1F+RYxHIW1EkcKAh0rzqWWATi0i4Ai5ygobaow93gjRMf8DBmfVD
 WIfa5MMKtdinIsG5/w2gxK7kcuv4MtTDexEBz0GpcuCAEbPGPX15BKWPNB40l5hfhozs
 iFqldhtkdnJdr9Uus5/DqHHtRRCqlN1WGe62atmbU+ft5KseWhRJyswW7vzs/iaLOJAZ
 JDr4k9MIenqQKfeFesR1hKK1uF5HlHIti4tDBl+NTsCJPaiwbN4BPRg88i+qw54c3o8i
 8WFj7RaxIawaG48AybTo6B9/75/b81nGCLovZTF74Pjzrc/CODVJIirCggflm3NQDLaZ
 B4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733428834; x=1734033634;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=L0Vl0lgng4jKpAj1S2pwpVZ8cBNzdb9nnkfVpbstCPM=;
 b=KoXIoivBFkvqWdDfzQ92c8XvEUjXhD4SIVgc3dq9CSOud72tbEL9wTeFRYFhMllbsO
 CEhoSrMdX7UyWDUQYfp2WrDlhUtx/KovuVesVDklMBUpTNYDfz5QpdgpcUcz/xoncahx
 Fp7gm26EfYeOngI2Uv0REO4EG8PUGhfSUlOQz9EiRI1oTkJLed8aaexwghHWhtBMz6BT
 1FbK0SJIX5gfSByiyer8TTfj5+t1aiOg8b9bPYyDhN8cIjSFyVJErPkZQKVFV8+Hezuh
 UBZM270eN8RR+5syzJ6ia2vcJU79LMSN+MEWbOvSXUykNEjj4pAAW2WjTEMugCKHW5yY
 Vj2Q==
X-Gm-Message-State: AOJu0YxfxOwZ0cQWzSmNv4rstLf3Dy2VOghnBgDzfBPRHnRIJPPa8TGd
 gbBpQHr5QerLg17wZjlg/X1IpUnY/EJWrlG9o72ZRTVzZEAFonVG1q76oFb93xPp55tigO0ZCO6
 xGhaoQDJhMuXCjipydpgrsjdTxf2SHzifnMi1A7NcmEp/tkeRhD85pooa05m3FtkrCj5/nYUygo
 xV7Kdne66Q8VqasNfZEK3MXxpu9dTWYSsEekgr48mftg==
X-Google-Smtp-Source: AGHT+IFbU++A+uXAqwDDUJOvkgHLl8bAA57ohJDZvEPUuBXvobDV2395uwyYzQevzW24y3sUzyrl3tHeEHaaYg==
X-Received: from wmim9.prod.google.com ([2002:a7b:cb89:0:b0:434:9cfd:391e])
 (user=whendrik job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:6c69:0:b0:385:fb2c:6021 with SMTP id
 ffacd0b85a97d-3862b3d5ad0mr283355f8f.39.1733428834109; 
 Thu, 05 Dec 2024 12:00:34 -0800 (PST)
Date: Thu,  5 Dec 2024 20:00:20 +0000
In-Reply-To: <20241205200025.2081863-1-whendrik@google.com>
Mime-Version: 1.0
References: <20241205200025.2081863-1-whendrik@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241205200025.2081863-4-whendrik@google.com>
Subject: [PATCH v4 3/8] i386: Add RDT functionality
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::449;
 envelope-from=3YgZSZwgKCvcvgdmcqhjfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--whendrik.bounces.google.com;
 helo=mail-wr1-x449.google.com
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
 hw/i386/rdt.c         | 123 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/i386/rdt.h |  16 ++++++
 2 files changed, 139 insertions(+)

diff --git a/hw/i386/rdt.c b/hw/i386/rdt.c
index 920e9c5dbe..01bee79cbe 100644
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
 /* Max counts for allocation masks or CBMs. In other words, the size of
  * respective MSRs.
  * L3_MASK and L3_mask are architectural limitations. THRTL_COUNT is just
@@ -33,6 +38,9 @@
 #define TYPE_RDT "rdt"
 #define RDT_NUM_RMID_PROP "rmids"
=20
+#define QM_CTR_ERROR        (1ULL << 63)
+#define QM_CTR_UNAVAILABLE  (1ULL << 62)
+
 OBJECT_DECLARE_TYPE(RDTState, RDTStateClass, RDT);
=20
 struct RDTMonitor {
@@ -73,6 +81,121 @@ struct RDTState {
 struct RDTStateClass {
 };
=20
+bool rdt_associate_rmid_cos(uint64_t msr_ia32_pqr_assoc)
+{
+    X86CPU *cpu =3D X86_CPU(current_cpu);
+    RDTStatePerCore *rdt =3D cpu->rdt;
+    RDTAllocation *alloc;
+
+    uint32_t cos_id =3D (msr_ia32_pqr_assoc & 0xffff0000) >> 16;
+    uint32_t rmid =3D msr_ia32_pqr_assoc & 0xffff;
+
+    if (cos_id > RDT_MAX_L3_MASK_COUNT || cos_id > RDT_MAX_L2_MASK_COUNT |=
|
+        cos_id > RDT_MAX_MBA_THRTL_COUNT || rmid > rdt_max_rmid(rdt)) {
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
+    return rdt->rdtstate->msr_L3_ia32_mask_n[pos];
+}
+
+uint32_t rdt_read_l2_mask(uint32_t pos)
+{
+    X86CPU *cpu =3D X86_CPU(current_cpu);
+    RDTStatePerCore *rdt =3D cpu->rdt;
+
+    return rdt->rdtstate->msr_L2_ia32_mask_n[pos];
+}
+
+uint32_t rdt_read_mba_thrtl(uint32_t pos)
+{
+    X86CPU *cpu =3D X86_CPU(current_cpu);
+    RDTStatePerCore *rdt =3D cpu->rdt;
+
+    return rdt->rdtstate->ia32_L2_qos_ext_bw_thrtl_n[pos];
+}
+
+void rdt_write_msr_l3_mask(uint32_t pos, uint32_t val)
+{
+    X86CPU *cpu =3D X86_CPU(current_cpu);
+    RDTStatePerCore *rdt =3D cpu->rdt;
+
+    rdt->rdtstate->msr_L3_ia32_mask_n[pos] =3D val;
+}
+
+void rdt_write_msr_l2_mask(uint32_t pos, uint32_t val)
+{
+    X86CPU *cpu =3D X86_CPU(current_cpu);
+    RDTStatePerCore *rdt =3D cpu->rdt;
+
+    rdt->rdtstate->msr_L2_ia32_mask_n[pos] =3D val;
+}
+
+void rdt_write_mba_thrtl(uint32_t pos, uint32_t val)
+{
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
+uint64_t rdt_read_event_count(RDTStatePerCore *rdtInstance,
+                              uint32_t rmid, uint32_t event_id)
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
+    case RDT_EVENT_L3_OCCUPANCY:
+        return count_l3 =3D=3D 0 ? QM_CTR_UNAVAILABLE : count_l3;
+    case RDT_EVENT_L3_REMOTE_BW:
+        return count_remote =3D=3D 0 ? QM_CTR_UNAVAILABLE : count_remote;
+    case RDT_EVENT_L3_LOCAL_BW:
+        return count_local =3D=3D 0 ? QM_CTR_UNAVAILABLE : count_local;
+    default:
+        return QM_CTR_ERROR;
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
2.47.0.338.g60cca15819-goog


