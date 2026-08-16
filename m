Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA8AC5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcAu-0005Es-HF; Sun, 16 Aug 2026 10:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcAp-0004ym-Qr
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:49:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcAn-00015m-VW
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:49:19 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDlLhA3450025
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:49:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fylwWBOb4eq+QCeRtYTXtDQS9okWQ8UEKVzFr5dTOhA=; b=OUkW8O6xCA/9i4vU
 MIhng9xcisqWQo0EvoGvvplfszJrvDtP+4BezrjRXk/rgMBfb9TDvVffGkljbdEH
 7f04aFBlnRzX4uxN1pJbLtNmply6YbiWpoEXLmc4pviEo7ec4f1PvlMKJNmQUIpv
 D4bdk/sSXcTvgwJYMmYh2nCOJ+T/xMcYrCq4ZcOSGHQhIDYlBmFF3aGF62Jsq2aD
 mm3KYAuWdOla4Y/woPwwiqwg6ySZ/cKX8KUuO2HXPNrj/m7Xruy51H/n2hNXM8mr
 ihTdaxfieRwJ3xIb+aadG+wEERBaaEKErpIQzAfGQRIIuUH7clQco2BylkrvvZHO
 TBFoIA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghk3mu7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:49:16 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51a8db414c7so37409051cf.0
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891756; x=1787496556; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fylwWBOb4eq+QCeRtYTXtDQS9okWQ8UEKVzFr5dTOhA=;
 b=f1V68rr9hhJbUobmiG9Y3u1PmRvQPOn+P42+WFOnMlwRs/11Zgnf+B2pnNyePP7ahv
 ri40NGirbjG/7pZbOavcRMO0hH91fzJsMIhPxGXTZPL6GnGqlmWbNkkIHM8K38+3/1lD
 FqgkykaLakHEJLsvJ1I6rl0VJGekE3WCVgAGXy3ms5Q+pEcSyhQWseQsBBv+HZ857rbo
 3iM9FwkABk8KS9SXCYEz8b3biOGyUA533ZdgvtuXNH4/8Fs6+3ZODZfJBxUk6M83qTdZ
 xt/yCAkjKTrJv4HLHnEn3kpfbbgYlhEHICBGle2KPERGJRmgCVM7eVN9G6AIi4dkIuGO
 /6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891756; x=1787496556;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fylwWBOb4eq+QCeRtYTXtDQS9okWQ8UEKVzFr5dTOhA=;
 b=Lsu0uRd9xRpQppd/kMyDzEG3Z9kq7yhuAJWY+b11ClMlTxV+D7KET9QjPNUMLy+Rl4
 56qnIu31Zy7ZLcMjDC4WqmpZEXKD6i/7oih0MB8Y2l4hklmdgCb8G2JGzuo86qU/RBc7
 FnSgHeXW2bLTE2lqwu25YVikqzqQoO8huCyzy/uJRKql/hMpS2xSj6VOzT9yFBIGv2aZ
 NZu8m4IGOU376+4kzlBL42GedPpowzh40SP1eclLlUB6moYlAOS2tx7jAkYbzHTRTP1N
 wPA0hOB6xOc8R9fGJ/1FFkqSSS3VAsTl76P7cdjvfsTc0Zg2EnkhNmBtwwjn2J3ZZKMo
 fFLA==
X-Gm-Message-State: AOJu0YxJ3pgxX1TQOxZK6wo3GELiStHo/oP5/KsUypvqSYjMvX9JdmhV
 G/HmHjEV2VuDXXTDGnYfjAuzti5837bRCF/fe1LMCeYE1PkYkTgTLmBg8HjOI+0UMb8HxwcPruJ
 4iY45EGvKZX7NVx1qJ4LE07leaTkhw5Tayaj42Mg5FGTkstuXw2OPCXPQiPm4XuAqBw==
X-Gm-Gg: AR+sD11dReWIq28LdY7ZmlPMQNKgz+QuIbX98aO4XHNKYXD7rUVamnAoiTc4b1DalUB
 wbqHbe903N2GLfSp1Ez2rcspuwYJia0CqMih2oBTSaPYWdnmlIK0ENwevH1DxI+frK/mXsmecLr
 STdQtz3vBL7E7nOSNnFkm5ZlBYb15ym0t83k9Du1ufyg3NmRbNJ3nnY2oK9ARPkZcENPD3h4Kue
 mwthowP3OpJmYsdqeM08yQm38+jHnnjsjxPbL7bXO87IdkY9ly/65PIs6UuWZI4KsOUsxHBSFID
 h1IyaaZy1HFB1hHYHzpAtkhbjrn9E4h7tDMmR5yVSdgHDLlAXOeReyUmHjpDG8dXA2GTkyzCXDj
 5zfqFUcMFvJ0N5LYP5Vrz//gGs+eOaYQmGZm1K1lVrw==
X-Received: by 2002:a05:622a:258c:b0:52d:9a3f:85bc with SMTP id
 d75a77b69052e-52d9a3f954fmr105178381cf.18.1786891756094; 
 Sun, 16 Aug 2026 07:49:16 -0700 (PDT)
X-Received: by 2002:a05:622a:258c:b0:52d:9a3f:85bc with SMTP id
 d75a77b69052e-52d9a3f954fmr105178091cf.18.1786891755653; 
 Sun, 16 Aug 2026 07:49:15 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2cd7ecsm24527480f8f.36.2026.08.16.07.49.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:49:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/56] hw/cpu: Move internal declarations to new
 'cpu-internal.h' header
Date: Sun, 16 Aug 2026 16:45:22 +0200
Message-ID: <20260816144556.69009-24-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX2QA5hV844L8j
 /ezB0aY+GXd138KalaVYC+saBjr8ycuv4bUBNMeGusGxBUkMV30En1JjgPmYnD+4UmveFXNTH/F
 w1qJtk7wBQy56G5QpJgOi9GEGr0qNok=
X-Proofpoint-GUID: h1XO6CJ-vXkg1MoyMofU_dp8EtjYhjht
X-Authority-Analysis: v=2.4 cv=f+14wuyM c=1 sm=1 tr=0 ts=6a81cdec cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=S56xvJB5AAAA:8 a=QyXUC8HyAAAA:8
 a=FTwMDBjRCo8fwpzlDxYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22 a=MH9Ivq0PDQRhlrFuIVvX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX4+k0O3YI7esz
 sAwq+F/z69jR2WGTohNScvL0XFRELamCxA4abJCh9jK3bUEftFzZUVswXSRUGelEpaSMtMsIR3u
 EjomxtGjB0SMqzdZEwRx/Lf6RF7e6JbzbHJiq/oAOYOieMEBVsou3G2RVlg9tS+sRQQMeqBUrXs
 0df2m4YZ286pTUD+AwB8JHaK0wlLbqr1x/7BoGZtD22QQnofgKuFmaCFUQpcVhRWH9tFkZUkTl9
 lvLRem0NUvrG8ItPADHWcuM6xwwbd3+iNFiJmD+plFKs0RtXAhAH1TJamCWPQS4Yn9x7XKY60Vg
 iIlX2+vDuQEv956t4JTwuvCKEqSBuNMirv0RKIkiVH2n7lK0p0bq136mou0gKAvvr4l2o9wEa0A
 5uh5b3INGmN22/AvUBevWw6UI0A+Qpg1EBu+kOnEMQD6/ih+ozlK/g/XyliZcPvWFQbFnbTXOc6
 P/ogxkwp5QQlDbhZUQg==
X-Proofpoint-ORIG-GUID: h1XO6CJ-vXkg1MoyMofU_dp8EtjYhjht
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160118
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Some declarations are only used within hw/core/, in particular
by the 3 cpu-{common,user,system}.c. Restrict the declarations
scope by moving them to a new "cpu-internal.h" local header.

Rename cpu_exec_initfn() -> cpu_exec_init() because we usually
have the 'fn' suffix for handler, not API entry point methods.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260811183410.22428-4-philmd@oss.qualcomm.com>
---
 MAINTAINERS            |  1 +
 hw/core/cpu-internal.h | 22 ++++++++++++++++++++++
 include/hw/core/cpu.h  |  6 ------
 hw/core/cpu-common.c   |  3 ++-
 hw/core/cpu-system.c   |  3 ++-
 hw/core/cpu-user.c     |  3 ++-
 6 files changed, 29 insertions(+), 9 deletions(-)
 create mode 100644 hw/core/cpu-internal.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f249be744e9..c296dd5abfd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2093,6 +2093,7 @@ Machine core
 M: Philippe Mathieu-Daudé <philmd@mailo.com>
 R: Zhao Liu <zhao1.liu@intel.com>
 S: Maintained
+F: hw/core/cpu-internal.h
 F: hw/core/cpu-common.c
 F: hw/core/cpu-system.c
 F: hw/core/machine-qmp-cmds.c
diff --git a/hw/core/cpu-internal.h b/hw/core/cpu-internal.h
new file mode 100644
index 00000000000..ae6a31bca2d
--- /dev/null
+++ b/hw/core/cpu-internal.h
@@ -0,0 +1,22 @@
+/*
+ * QEMU private CPU interface between user / system modes)
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_CORE_CPU_INTERNAL_H
+#define HW_CORE_CPU_INTERNAL_H
+
+#include "hw/core/qdev.h"
+#include "hw/core/cpu.h"
+
+void cpu_class_init_props(DeviceClass *dc);
+void cpu_exec_class_post_init(CPUClass *cc);
+
+void cpu_exec_init(CPUState *cpu);
+
+void cpu_vmstate_register(CPUState *cpu);
+void cpu_vmstate_unregister(CPUState *cpu);
+
+#endif
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index c5064a5449b..6490fb070f2 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1178,12 +1178,6 @@ G_NORETURN void cpu_abort(CPUState *cpu, const char *fmt, ...)
  */
 void qemu_process_cpu_events(CPUState *cpu);
 
-/* $(top_srcdir)/cpu.c */
-void cpu_class_init_props(DeviceClass *dc);
-void cpu_exec_class_post_init(CPUClass *cc);
-void cpu_exec_initfn(CPUState *cpu);
-void cpu_vmstate_register(CPUState *cpu);
-void cpu_vmstate_unregister(CPUState *cpu);
 bool cpu_exec_realizefn(CPUState *cpu, Error **errp);
 void cpu_exec_unrealizefn(CPUState *cpu);
 void cpu_exec_reset_hold(CPUState *cpu);
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 8c9ff25e04a..17d76580930 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -39,6 +39,7 @@
 #ifdef CONFIG_PLUGIN
 #include "qemu/plugin.h"
 #endif
+#include "cpu-internal.h"
 
 CPUState *cpu_by_arch_id(int64_t id)
 {
@@ -326,7 +327,7 @@ static void cpu_common_initfn(Object *obj)
     QTAILQ_INIT(&cpu->breakpoints);
     QTAILQ_INIT(&cpu->watchpoints);
 
-    cpu_exec_initfn(cpu);
+    cpu_exec_init(cpu);
 
     /*
      * Plugin initialization must wait until the cpu start executing
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 14eb4ed87f8..8a9f2fcea84 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -30,6 +30,7 @@
 #include "hw/core/sysemu-cpu-ops.h"
 #include "migration/vmstate.h"
 #include "system/tcg.h"
+#include "cpu-internal.h"
 
 bool cpu_has_work(CPUState *cpu)
 {
@@ -188,7 +189,7 @@ void cpu_exec_class_post_init(CPUClass *cc)
     g_assert(cc->sysemu_ops->has_work);
 }
 
-void cpu_exec_initfn(CPUState *cpu)
+void cpu_exec_init(CPUState *cpu)
 {
     cpu->memory = get_system_memory();
     object_ref(OBJECT(cpu->memory));
diff --git a/hw/core/cpu-user.c b/hw/core/cpu-user.c
index 25aa25ad240..c2cb00a85d3 100644
--- a/hw/core/cpu-user.c
+++ b/hw/core/cpu-user.c
@@ -11,6 +11,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/core/cpu.h"
 #include "migration/vmstate.h"
+#include "cpu-internal.h"
 
 static const Property cpu_user_props[] = {
     /*
@@ -32,7 +33,7 @@ void cpu_exec_class_post_init(CPUClass *cc)
     /* nothing to do */
 }
 
-void cpu_exec_initfn(CPUState *cpu)
+void cpu_exec_init(CPUState *cpu)
 {
     /* nothing to do */
 }
-- 
2.53.0


