Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A33E77182
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9RY-0008T6-EB; Fri, 13 Dec 2024 12:27:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ZW5cZwgKCvQsdajZnegckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--whendrik.bounces.google.com>)
 id 1tM9RX-0008Sa-2x
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:27:11 -0500
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ZW5cZwgKCvQsdajZnegckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--whendrik.bounces.google.com>)
 id 1tM9RU-0007ow-A9
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:27:10 -0500
Received: by mail-wm1-x349.google.com with SMTP id
 5b1f17b1804b1-436225d4389so12028125e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1734110821; x=1734715621; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=wHkF/WN4dNFxkLkmakBOXW7PVPtTgVOdWntjSAqATHM=;
 b=4nel8UJVC7z0wX52nJV1EtcfgOv9rxFm2O4tZAwziontV9CA/LfcPtwKiQ1Gw7d3BO
 VqVE8MdvKbOAyUSu4z9axLe4WUzoX3RUDif9PPRyhdQbu95L+vdTIO/SLYc+l9g5t1aE
 n3hh77gFfQKav5JPzrmLZCRnB5imAeb/xHbRWWome6JXhL1UDY2h2Lhl+aWG+E3HJWcN
 fQ5LVCnCF9fS2UdMaRyeAKWU7Nq3Nwgu+BX+ConLsqch7kkU3DsRGYP3HObSrLFK1oOS
 y81tNVud8aruNghuQRZanWihUr6p2vG78Ax7AKX7GYd8mqHFkumFDZtzI1n2iTCZxssz
 AtQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734110821; x=1734715621;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wHkF/WN4dNFxkLkmakBOXW7PVPtTgVOdWntjSAqATHM=;
 b=mX5aoD1ZSOEjArQF37HjHmJj6MNW34rcFuprkiLpCWP/GRt+UuLUGUCXjl00kYXnfv
 nB7UBA2uJNdjCe0+df56FDPTsxmrOIKPaCvXuKj/KDFBwWszWbDfWEl3IyAtmty/OTF2
 0hlBLy7UkgpiLMwagWWkELZGUOklyEdHC/XVzsdeyLNdHvTthSwIig7iTt4qlCL6s+pN
 14NdVoaZIJMIlbJ1wTzzNbRgYwGOU3H+QVKFWMvMa4dVvg/HVdKXbGGgRBH+gly+3Nkt
 +0I+E2Fd2mYmvxsPqy8L4Nda9D7TLU2twSLXstXrwVzVgKkMHs03ipFTkeyH8lOeKodW
 Kizw==
X-Gm-Message-State: AOJu0YzCuEXDE/uVjAPXbwjv9LXKMt5Aprgz8Ur4idG2iuTvJIzoWdVd
 hyhdv6viv1ixZC4D71iDvNwKZBYj0tFN7YpImrmgQ5LLSLx2Jxqkr+C9cD0MfkMjaoHHJaRTfCg
 PsyWfavFhuCjxdotM6cl6ac8zaEB1cuxH4UdRMXdspAAmT8f7T5amaQ/KrveEw3yvvns6HnBRMx
 LvaYu1RUaOZQQo0sY1HGMxozug6Md0zeGUdQQljR2WVA==
X-Google-Smtp-Source: AGHT+IEMkZfiEnVCAyo4k+UhSr0cGRiRQ+sCypTfbN+MSmfiRcGk0iUpUbI+RfTJZ0x2zF6MW4xRf+cjS3NhXA==
X-Received: from wmsk11.prod.google.com ([2002:a05:600c:1c8b:b0:434:ef30:4be3])
 (user=whendrik job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1551:b0:435:1a2:262a with SMTP id
 5b1f17b1804b1-4362b10271amr27866945e9.3.1734110821229; 
 Fri, 13 Dec 2024 09:27:01 -0800 (PST)
Date: Fri, 13 Dec 2024 17:26:40 +0000
In-Reply-To: <20241213172645.2751696-1-whendrik@google.com>
Mime-Version: 1.0
References: <20241213172645.2751696-1-whendrik@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241213172645.2751696-4-whendrik@google.com>
Subject: [PATCH v5 3/8] i386: Add RDT functionality
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com, 
 zhao1.liu@intel.com, xiaoyao.li@intel.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::349;
 envelope-from=3ZW5cZwgKCvQsdajZnegckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--whendrik.bounces.google.com;
 helo=mail-wm1-x349.google.com
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
2.47.1.613.gc27f4b7a9f-goog


