Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FECFC3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 17:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUrVQ-00048l-GL; Fri, 19 Jul 2024 13:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3d5SaZggKCkY4pmvlzqsowwotm.kwuymu2-lm3mtvwvov2.wzo@flex--whendrik.bounces.google.com>)
 id 1sUqUO-0002lT-Jf
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 12:29:48 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3d5SaZggKCkY4pmvlzqsowwotm.kwuymu2-lm3mtvwvov2.wzo@flex--whendrik.bounces.google.com>)
 id 1sUqUL-0004PE-UW
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 12:29:48 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-664ccf0659cso56061607b3.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 09:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1721406584; x=1722011384; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=eL5RLnzpAzf7TFLl1U6rQzX+YN9nJj6N45FXkDozc0Q=;
 b=JFmrCX8f296oNAcNMkNBnmXJVTXLbgoU9oZvHtzDVh0mK4Gf+uQC84ChaR29Uisr7U
 9L5cw9HkjM0LE76ufmjNShxGYfr0hmjcm1Xxh+AAp8Qd/NHnrqyEfmWnnq+cudpjOv95
 De9/6euNw1NXK0pSQeICzOTBigqCMKz2QfOevsi35eowkSOdwN1H9dbIysrFsfn5oOJr
 YyThPs080KioDxHZ9nO9uRbts/ioHBcY9OHytRLpvudldG3E+yG9nhgTEwpRWqVlRIEZ
 b4Rn4HOIXNpSLie98b3vQPXnMGDJ4MBrFJGigsE/lpNHyD14mhPM5xMbEMjc4BwzjnSr
 C7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721406584; x=1722011384;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=eL5RLnzpAzf7TFLl1U6rQzX+YN9nJj6N45FXkDozc0Q=;
 b=UTWm11Sqge7RCAn0l6ZQnFXG2QFFfgP0aWHha0eR0jx4ZKGhDk2slVfxv0Ui4H7lMC
 vZVf0U/URuP1FQ54TG3vjqfpxFY4V00RTf00qGXSB8i8sBHBAdLN3g73QfqV1HIXZuU9
 jGt0TRPXWK1WAVFPusQLtsY+nI3pZ6mxtbMZpKO0NPRV9sK0hmYJzpfDUXN5yEjXcJNW
 KsVNtFY0kap7gHfSP+Z3AzRD142z17d/yodWh9fcRQCyzlv3FDJj3GajrsyQxfHHrLEW
 ApoYQ9HeOd+h7uG737+hbxkFA9pMKDDD80JCdZrM7yW8EX3JMU5IwD6N7mhmet74rSiW
 azyg==
X-Gm-Message-State: AOJu0Yw/JuD9B7OahJb3KrxOHhtHiJqguc0M7c05cEcO2afab5eIfU2d
 k9qLpM2ARJRiPdRK1vJhWLbmFLYoNqjcg3Hl/lTDAQh3UmoVS0ZT9rg64j77tI15JCodTwjDLhI
 Hkj4hT4AqEVTE3eVz4mUGVM2zrt8DX6ApLPy2bBNVehXxMcIKwnPw/SEpPEG+7jzhvAwvXltkJB
 t4IpxsayBbICSS63jPvV/Oqx6nWvaikiV6l+CytTRqjg==
X-Google-Smtp-Source: AGHT+IHHKg6j1+AEXWGqsFZwMZ13q4eDMIJ4oL7BiD6+1uRsdihxgaIIK8LxEHmDDBbHFzd3iR8BzLF/sFNH2A==
X-Received: from whendrik-specialist-workstation.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:967]) (user=whendrik job=sendgmr) by
 2002:a05:690c:f14:b0:62c:ea0b:a44c with SMTP id
 00721157ae682-66a6654ba97mr90457b3.2.1721406583914; 
 Fri, 19 Jul 2024 09:29:43 -0700 (PDT)
Date: Fri, 19 Jul 2024 16:29:24 +0000
In-Reply-To: <20240719162929.1197154-1-whendrik@google.com>
Mime-Version: 1.0
References: <20240719162929.1197154-1-whendrik@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240719162929.1197154-5-whendrik@google.com>
Subject: [PATCH v1 4/9] Add RDT functionality
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3d5SaZggKCkY4pmvlzqsowwotm.kwuymu2-lm3mtvwvov2.wzo@flex--whendrik.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 19 Jul 2024 13:34:50 -0400
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
 include/hw/i386/rdt.h |  13 +++++
 2 files changed, 137 insertions(+)

diff --git a/hw/i386/rdt.c b/hw/i386/rdt.c
index 259dafc963..77b7b4f2d4 100644
--- a/hw/i386/rdt.c
+++ b/hw/i386/rdt.c
@@ -7,6 +7,11 @@
 #include "target/i386/cpu.h"
 #include "hw/isa/isa.h"
=20
+/* RDT Monitoring Event Codes */
+#define RDT_EVENT_L3_OCCUPANCY 1
+#define RDT_EVENT_L3_REMOTE_BW 2
+#define RDT_EVENT_L3_LOCAL_BW 3
+
 /* Max counts for allocation masks or CBMs. In other words, the size of re=
spective MSRs*/
 #define MAX_L3_MASK_COUNT      128
 #define MAX_L2_MASK_COUNT      48
@@ -15,6 +20,9 @@
 #define TYPE_RDT "rdt"
 #define RDT_NUM_RMID_PROP "rmids"
=20
+#define QM_CTR_Error        (1ULL << 63)
+#define QM_CTR_Unavailable  (1ULL << 62)
+
 OBJECT_DECLARE_TYPE(RDTState, RDTStateClass, RDT);
=20
 struct RDTMonitor {
@@ -49,6 +57,122 @@ struct RDTState {
=20
 struct RDTStateClass { };
=20
+bool rdt_associate_rmid_cos(uint64_t msr_ia32_pqr_assoc) {
+    X86CPU *cpu =3D X86_CPU(current_cpu);
+    RDTStateInstance *rdt =3D cpu->rdt;
+    RDTAllocation *alloc;
+
+    uint32_t cos_id =3D (msr_ia32_pqr_assoc & 0xffff0000) >> 16;
+    uint32_t rmid =3D msr_ia32_pqr_assoc & 0xffff;
+
+    if (cos_id > MAX_L3_MASK_COUNT || cos_id > MAX_L2_MASK_COUNT ||
+    cos_id > MAX_MBA_THRTL_COUNT || rmid > rdt_max_rmid(rdt)) {
+        return false;
+    }
+
+    rdt->active_rmid =3D rmid;
+
+    alloc =3D &g_array_index(rdt->rdtstate->allocations, RDTAllocation, rm=
id);
+
+    alloc->active_cos =3D cos_id;
+
+    return true;
+}
+
+uint32_t rdt_read_l3_mask(uint32_t pos)
+{
+    X86CPU *cpu =3D X86_CPU(current_cpu);
+    RDTStateInstance *rdt =3D cpu->rdt;
+
+    uint32_t val =3D rdt->rdtstate->msr_L3_ia32_mask_n[pos];
+    return val;
+}
+
+uint32_t rdt_read_l2_mask(uint32_t pos)
+{
+    X86CPU *cpu =3D X86_CPU(current_cpu);
+    RDTStateInstance *rdt =3D cpu->rdt;
+
+    uint32_t val =3D rdt->rdtstate->msr_L2_ia32_mask_n[pos];
+    return val;
+}
+
+uint32_t rdt_read_mba_thrtl(uint32_t pos)
+{
+    X86CPU *cpu =3D X86_CPU(current_cpu);
+    RDTStateInstance *rdt =3D cpu->rdt;
+
+    uint32_t val =3D rdt->rdtstate->ia32_L2_qos_ext_bw_thrtl_n[pos];
+    return val;
+}
+
+void rdt_write_msr_l3_mask(uint32_t pos, uint32_t val) {
+    X86CPU *cpu =3D X86_CPU(current_cpu);
+    RDTStateInstance *rdt =3D cpu->rdt;
+
+    rdt->rdtstate->msr_L3_ia32_mask_n[pos] =3D val;
+}
+
+void rdt_write_msr_l2_mask(uint32_t pos, uint32_t val) {
+    X86CPU *cpu =3D X86_CPU(current_cpu);
+    RDTStateInstance *rdt =3D cpu->rdt;
+
+    rdt->rdtstate->msr_L2_ia32_mask_n[pos] =3D val;
+}
+
+void rdt_write_mba_thrtl(uint32_t pos, uint32_t val) {
+    X86CPU *cpu =3D X86_CPU(current_cpu);
+    RDTStateInstance *rdt =3D cpu->rdt;
+
+    rdt->rdtstate->ia32_L2_qos_ext_bw_thrtl_n[pos] =3D val;
+}
+
+uint32_t rdt_max_rmid(RDTStateInstance *rdt)
+{
+    RDTState *rdtdev =3D rdt->rdtstate;
+    return rdtdev->rmids - 1;
+}
+
+uint64_t rdt_read_event_count(RDTStateInstance *rdtInstance, uint32_t rmid=
, uint32_t event_id)
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
+        rdtInstance =3D &g_array_index(rdt->rdtInstances, RDTStateInstance=
, cs->cpu_index);
+        if (rmid >=3D rdtInstance->monitors->len) {
+            return QM_CTR_Error;
+        }
+        mon =3D &g_array_index(rdtInstance->monitors, RDTMonitor, rmid);
+        count_l3 +=3D mon->count_l3;
+        count_local +=3D mon->count_local;
+        count_remote +=3D mon->count_remote;
+    }
+
+    switch (event_id) {
+        case RDT_EVENT_L3_OCCUPANCY:
+            return count_l3 =3D=3D 0 ? QM_CTR_Unavailable : count_l3;
+            break;
+        case RDT_EVENT_L3_REMOTE_BW:
+            return count_remote =3D=3D 0 ? QM_CTR_Unavailable : count_remo=
te;
+            break;
+        case RDT_EVENT_L3_LOCAL_BW:
+            return count_local =3D=3D 0 ? QM_CTR_Unavailable : count_local=
;
+            break;
+        default:
+            return QM_CTR_Error;
+    }
+}
+
 OBJECT_DEFINE_TYPE(RDTState, rdt, RDT, ISA_DEVICE);
=20
 static Property rdt_properties[] =3D {
diff --git a/include/hw/i386/rdt.h b/include/hw/i386/rdt.h
index 45e34d3103..8092c5f290 100644
--- a/include/hw/i386/rdt.h
+++ b/include/hw/i386/rdt.h
@@ -10,3 +10,16 @@ typedef struct RDTMonitor RDTMonitor;
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
+uint64_t rdt_read_event_count(RDTStateInstance *rdt, uint32_t rmid, uint32=
_t event_id);
+uint32_t rdt_max_rmid(RDTStateInstance *rdt);
+
--=20
2.45.2.1089.g2a221341d9-goog


