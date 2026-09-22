Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21616C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 16:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x93kC-00078m-4y; Tue, 22 Sep 2026 12:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x93i6-0004cH-Rj
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 12:51:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x93i5-0002ZC-3Q
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 12:51:14 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MEjmM73952765
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 16:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TmpLRtcALdGvnoiA64jtGQ7kzwpnFEecY1PS7YhgtmQ=; b=cOF5E3ijO9WQ4RVq
 1kWMO1hQDpt9X5D53SrLpfzR5pBS+Fupgn2MxGjcVa2DRfcr4bOUo/JIaVakaWDg
 QQLxweSl/KIOO6XO8OTew/iBA/yZdMXJwwvspSfZsj9ntDvRPDMQfRXaGBFX25PD
 D4QPfMscBarXx53DaYnBqSKOA8gdgxM6EKmR2k3vU7ipnBllaAXYdygJM9sp562U
 TPwWy+4hqCwZ5an8leAebwvM5WwdyaMTLSl63rH+Ev9NvZU5NvbyA6F6fiClm/N4
 paWR/unWVWS+DXMOkTWzV7VlWwxRktNntos1riDnhMm0QgEM+POraMgKgynjHPsm
 vkKY6g==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gufsqbp8f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 16:51:01 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-79013d05471so1178137.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 09:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790095861; x=1790700661; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TmpLRtcALdGvnoiA64jtGQ7kzwpnFEecY1PS7YhgtmQ=;
 b=JiN/5Gz5qbtSj2D/W/48ccvCMH9JaQRlFmEVW5RhcdbbFpBKmc6/REp2noVCmrW71y
 T/dgWIu/2C6vf5aMHjhGBRBNa58DgA/ciVMwDpTgJCwZv9HmAYYXLFtJNKzoKkxPN3Ar
 0wGsMxS7eoMZbz2r+I6n00jtSDRD3zL6Ghh3q5n61xpjLzM9hOsX5zB6z8/KUObYMUE8
 h+zqTRKWd4wpjOF92h8/TU++1NqhRiGeD9TRqDfgSJAw1PfRpA9+XQsv+e8ykt3YMUlp
 ZhX9hvtYFFnghHmzjTNnkgyhNix1INYV8k5z+9fQztD9k/ZVoZWqvJmIwyxysZ+soRzG
 fyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790095861; x=1790700661;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TmpLRtcALdGvnoiA64jtGQ7kzwpnFEecY1PS7YhgtmQ=;
 b=YWMUg00XWBx/hbFUpv/fL8T8zKF41gVf5LKghBucaTcUcI60faFtnEir/mP5N/WrfC
 9T2PEWsB0HpoQKJ62JtE0K1xtZXGGh8qKiJCNmEFkzz3SJxrWKXvRgQTLMObCI2QFzZ2
 lnAfg3dgwq/kRZS4YmbP5D+ZQdX1zsHk3qGCLsWELTmM8GtIzIo1y5G7o1cwrGRjm+s3
 ZyOqsY1uqNz37CHUcrLQsr+SKLhBQG8PbN+CeICDAQ+dcZvuRTCFAAfmpvnDk09zr3ub
 iupnnK6uxwI4wVuLPyzeYAHvrEFSmpUxVCgeDRz+3Uh8C3NSZKDIN7hb262z+RJDoat4
 GhpA==
X-Gm-Message-State: AFuF++mS+8F0+fQIF2IH/H4QKqIsa2clxWtFuA4kQMJb7aye5F1+KaC4
 cR6fAfPs5ADvudzfyCP7hpAP1GnsqrGVRS609pVIea4joWz8hXsG852nCIeh041/PYCJHWXdb+A
 KLIOqWIxfXml1eGp3h+mLDgWpz3mANQvEiUte1NHyUQYYJIArqO6aSxnMrZrw5LmDRQ==
X-Gm-Gg: AYBFou1LmYfZXQ4c84NPraJ3yAdpPTQLUPqj/H3T4Ymy7eYiRsc7C1a1LKiBpldmMm1
 irHpfRz6UXC9+flv9f3clTQX9RbS490ww2CAyyTAHBaOp1fVvGxJJtzOX1Sz6r1gNoVPwU3/N7J
 cfAN7sNkgOILdXul/QrfGaTBOVqUHT4WkwL0ZrOL7aFW5Xym287kNWWOD5kSJWZHZDu28dwndCX
 QPOcz1ATBigEN8ceAv0H+VraGElJiPAV5n5e6nwXHYE4gh6XeI0GrY94F/pcaTED8nsYAEB3hu1
 EvTelBTiufS/sOKKU/N3IetWMISXBTdj32TFnz9cvndhWEJtxtxOL9ULpFB5LHYqvbBtn2ajoCM
 w6LauXptCiEhQ4WNt8Ei4OBFqhG1SPFA7OSz+Ox13
X-Received: by 2002:a05:6102:6a85:b0:7a7:fbfb:aa03 with SMTP id
 ada2fe7eead31-7a7fbfbaa9amr6088053137.21.1790095861175; 
 Tue, 22 Sep 2026 09:51:01 -0700 (PDT)
X-Received: by 2002:a05:6102:6a85:b0:7a7:fbfb:aa03 with SMTP id
 ada2fe7eead31-7a7fbfbaa9amr6087990137.21.1790095860642; 
 Tue, 22 Sep 2026 09:51:00 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fde1a3b46sm3415365e9.11.2026.09.22.09.50.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Sep 2026 09:50:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 11/17] accel/tcg: Introduce poll_during_halt() and
 leaving_halt()
Date: Tue, 22 Sep 2026 18:49:29 +0200
Message-ID: <20260922164936.15189-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922164936.15189-1-philmd@oss.qualcomm.com>
References: <20260922164936.15189-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ULhTn_0LP_5kWV_sUpAWtrWQEjqQkfmo
X-Proofpoint-GUID: ULhTn_0LP_5kWV_sUpAWtrWQEjqQkfmo
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI0NiBTYWx0ZWRfX/iVRYHJGS3ro
 +BHhlnkUx/E6GZmbtUnSQxy1UhmS0PmRdTMTpIaAVDIRs6TrjutLIswTePbmoukDN/kT0wH0QYn
 lvueRoCPZl/FbGcnRuMaNILd7mss50o=
X-Authority-Analysis: v=2.4 cv=NKBAaE6g c=1 sm=1 tr=0 ts=6ab2b1f6 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=DbqnPDNGgojIjNu1nyEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI0NiBTYWx0ZWRfX0GmHB3HRaz3B
 DWYMX8DFjOIPSAR+/f33IdPdoH9dDDe48avKgBtczhIuGpnDsWIhT2wQR+51tJw5xED7zqS/NXl
 gM3ys5rgiJEwLdUn9alMdOl4Ojq6iwX4iA9zbxXp6zLBfo5m6ON1gCXLBn35LBxnS85v6kn8a9v
 fi1vbJXFZkG3ro+fx88lS4Mw16v75G5aXF7JtgCbNGX7h3IcI/91kI42eSD/b/MSf7pH3h6dPpC
 DIdHisivCtteRsBeh92q4WeZmAF5Q9vibbsqGkd/mah6V2X81oEk2e+IEHnX20kPc1w73VV+NsZ
 AhkuHfirjsfrY5QXJYLnfi5KYFJoLX0rWk8pjoA36xJg3/YkbKtwp10TJ24Pzt/kEiF/mUAfQxi
 KwZ3ZiAyNvtu4i9ALQovE50XorFMbEUpSzF475FbPayi+hdTuc6177s+FIDIzNV15X3OiBFdHjr
 AS3YK9SfwYTBWCAZjQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220246
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Split target-specific halt handling into an optional
poll_during_halt() callback before cpu_has_work() and a
leaving_halt() callback after work is found.

Keep cpu_exec_halt() as a legacy alternative for targets
that have not migrated. Require each target to provide either
cpu_exec_halt() or leaving_halt(), but not both.

Inspired-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-ops.h | 24 +++++++++++++++++++++++-
 accel/tcg/cpu-exec.c        | 21 +++++++++++++++++----
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 3ff6e6810e0..1ee5d3d8bdb 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -169,6 +169,27 @@ struct TCGCPUOps {
      */
     vaddr (*untagged_addr)(CPUState *cs, vaddr addr);
 #else
+    /**
+     * @poll_during_halt: Poll target-specific events while the CPU is halted.
+     * @cpu: vCPU context
+     *
+     * Called when the CPU is halted to handle target-specific asynchronous
+     * event processing before instruction execution begins.
+     * The caller does not hold the BQL.
+     */
+    void (*poll_during_halt)(CPUState *cpu);
+    /**
+     * @leaving_halt: Perform target-specific cleanup before resuming
+     *                execution.
+     * @cpu: vCPU context
+     *
+     * Called after a halted CPU has detected pending work and is about to
+     * resume execution from the halted state. This callback performs any
+     * necessary target-specific state transitions or synchronization before
+     * instruction execution resumes. The caller does not hold the BQL.
+     * Either this callback or @cpu_exec_halt must be provided (but not both).
+     */
+    void (*leaving_halt)(CPUState *cpu);
     /** @do_interrupt: Callback for interrupt handling.  */
     void (*do_interrupt)(CPUState *cpu);
     /** @cpu_exec_interrupt: Callback for processing interrupts in cpu_exec */
@@ -185,7 +206,8 @@ struct TCGCPUOps {
      * if it should remain in the halted state. (This should generally
      * be the same value that cpu_has_work() would return.)
      *
-     * This method must be provided. If the target does not need to
+     * Either @leaving_halt or this method must be provided, but not both.
+     * If the target does not need to
      * do anything special for halt, the same function used for its
      * SysemuCPUOps::has_work method can be used here, as they have the
      * same function signature.
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 76182803592..edb719b0d10 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -48,6 +48,7 @@
 #include "internal-common.h"
 #if !defined(CONFIG_USER_ONLY)
 #include "accel/tcg/iommu.h"
+#include "hw/core/sysemu-cpu-ops.h"
 #endif
 
 /* -icount align implementation. */
@@ -657,10 +658,22 @@ static inline void tb_add_jump(TranslationBlock *tb, int n,
 static bool cpu_poll_while_halted(CPUState *cpu)
 {
     const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
-    bool leave_halt = tcg_ops->cpu_exec_halt(cpu);
 
-    if (!leave_halt) {
-        return false;
+    if (tcg_ops->leaving_halt) {
+        assert(!tcg_ops->cpu_exec_halt);
+        if (tcg_ops->poll_during_halt) {
+            tcg_ops->poll_during_halt(cpu);
+        }
+        if (!cpu_has_work(cpu)) {
+            return false;
+        }
+        tcg_ops->leaving_halt(cpu);
+    } else {
+        assert(!tcg_ops->poll_during_halt);
+        assert(cpu->cc->sysemu_ops->has_work == tcg_ops->cpu_exec_halt);
+        if (!tcg_ops->cpu_exec_halt(cpu)) {
+            return false;
+        }
     }
 
     cpu->halted = 0; /* allow execution */
@@ -1059,7 +1072,7 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
         /* Check mandatory TCGCPUOps handlers */
         const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 #ifndef CONFIG_USER_ONLY
-        assert(tcg_ops->cpu_exec_halt);
+        assert(tcg_ops->cpu_exec_halt || tcg_ops->leaving_halt);
         assert(tcg_ops->cpu_exec_interrupt);
         assert(tcg_ops->cpu_exec_reset);
         assert(tcg_ops->pointer_wrap);
-- 
2.53.0


