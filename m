Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1B7C5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhk6-0000Ef-6F; Wed, 19 Aug 2026 10:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwhjO-00082c-Mx
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:57:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwhjM-0000XR-L5
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:57:30 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JEboTv588430
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 14:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k/dw9CAIDDIAnKODIG5Nq+u40gkHa9+e1vlUBVaUTiM=; b=P9kt2wghpIkQD6pv
 7rYdmGC8jK47ekFdcCi5biyBUPlG3Wb602CRzc3mjjUj+EQlTU4PbcbW1m0MJ4Wt
 EMiPMmdl1ixudzHP2SGzQcsqI0jFgIqaicHgTG86ZauoXWGDho/LawM9mJtq+ADm
 LJ82v/aWUeHG9p3YYpZC5m16ltuVuxXrXRMNjcB+mY29jHu/RpWs+9JchBFgRRQj
 Jl4u+24gCKpsMD1//5MSltgAMb0eAQy2M9268ZksKttfNHaVvv7EDC/gyaT6Zr9b
 qOalA4R+NN9HONob3dge9AIdeemoJWDOMTbhvBpCRvqYXAz5Hu1L1ZSogEe9UvrK
 I0jPvA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfkburd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 14:57:27 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e9a2b95b5so197247185a.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 07:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787151447; x=1787756247; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=k/dw9CAIDDIAnKODIG5Nq+u40gkHa9+e1vlUBVaUTiM=;
 b=DFOMeIbALUACwFGmsKrZ2vgJDmpn7HfOJFAWAsYEgWIJz8Wesp/u2nqZ0lIZagBN+G
 okUPOe9adVguTFfbpbJgfgo2082kufWZgGYcm6r4nRUWSRNJYzjf8iRIkoMbYsbKWOle
 0edXlPzKM1al36/zoU1hd6bgQVW+W9x8/9m1sUqVZoqpzEOqWDehUQ3ERxNRaCASXhTp
 RYFMpa1z4KK+9HInkGa4vAZybJsEU1V1LvVU30aF582U3W2q193TNpmNpCrlFpLSQgpY
 V2zim5xNR16tyZVY8KwO7XBYzTixvZEElPI0BnWmqcDOt+t849LnBR/p/Gi2C+/8iXdg
 l2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787151447; x=1787756247;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k/dw9CAIDDIAnKODIG5Nq+u40gkHa9+e1vlUBVaUTiM=;
 b=ZgyzQNMQk31Dr2OdQJV/qGuCJNv+qBCxXwtENc5m23aYMBigDlw1i2Euyt21LoAdvr
 va1Jmmx7BfKPKNUMRW3YQC/a9QUN+69RkScUovmCh8I+OzGwxQrzrK5K9xXNX+TvyTu4
 SOTntmaRfuzIL2Ccz6hiLiuj1HeliaCw/vP9LzZPXlEMlEepnMyYYJ2D2PjGaKN1t2kw
 Ctk+Jcke2w4neRP6P/+S3b7C7L2oDx/+w4f5u3bCemip/MZeoSEgHtodzy3WSPLeOFbr
 lhdPWwwo0fHOhmu04urfod4qzgtO+fYzfabfrn5V8emPI9pq8mNSuxJ/9+0MwbfBPZWn
 csNw==
X-Gm-Message-State: AOJu0YyYCyrrJXK/mxHxN6vgZLeOsECciDKH45bOGGMGs8yutDyOp0hD
 hY5E3Ssro+ATI6ZCaFGo7DsbZhQdrqnwHSIIvrpPy4Olktu5qPHShjF3xA9WUlGFTOJb4c6BUcE
 mlkOoQJWLtF6lzIdhXr8tIaI2CDhzvhla1Ail7cBT5zvYhjK+wvscVsCuH/FHWjqn/noa
X-Gm-Gg: AR+sD135F3xX0LZZNgIXq3xgTYapvbK2bRoq5noE0D9VH+a7OA7Uw4uHyaD7qcUA4wj
 Pb6hngqfPIUuSLSf2amBVoExZQMA98EZS0AoxFgtKUprpSd03PVD9zNrjqMVB79t/YA5JOAh6bG
 +Uv1B+mEmX30sE8x4JxvoY6d2WOp5av51yfHO4Zdu+0vNj918ly3nBTRqGbp4RFh6gGWNN5D7QC
 09myNENXgvDLoYAxiOm7dCD61S2i6rnmsHE2Os3uoT/3Mph9jEy9/qgSiqUOUauPG4U5+L2jJZO
 hGSFM0DXLvduEJbVlm7QGoMk+jZ0slf0A4Nr07P5NOyxXwLXKL2RxNizvhzRn7JscYXxN10Fe9Z
 en/CXA99dpeafkAkZLZESrQsvN6Zq/GlLJOblImCtrA==
X-Received: by 2002:a05:620a:700e:b0:916:10f6:780f with SMTP id
 af79cd13be357-9371e6f6079mr422162085a.27.1787151447097; 
 Wed, 19 Aug 2026 07:57:27 -0700 (PDT)
X-Received: by 2002:a05:620a:700e:b0:916:10f6:780f with SMTP id
 af79cd13be357-9371e6f6079mr422156685a.27.1787151446562; 
 Wed, 19 Aug 2026 07:57:26 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441c78sm6324437f8f.2.2026.08.19.07.57.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Aug 2026 07:57:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 05/11] accel/tcg: Introduce .process_async_events and
 .transition_halt_to_exec
Date: Wed, 19 Aug 2026 16:56:43 +0200
Message-ID: <20260819145649.23439-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819145649.23439-1-philmd@oss.qualcomm.com>
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: iIjRKu0lErtjqJ3V2QH5E7ggx7FXIYXy
X-Proofpoint-ORIG-GUID: iIjRKu0lErtjqJ3V2QH5E7ggx7FXIYXy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDExNiBTYWx0ZWRfXxab8jZsDHwx1
 e8TaAIyr8Zolq2hcFOQta+JIQSts7MvyK5BmjJNb8jMJVYZHxrhRUHdrVCLd39c3FOpTo7zDbAx
 eCDGw7qCrUGQRmKvCfyJYIpLAjurVf8b0zsAU2uQ/xoknFeY+o1DtOyejJNKtqJgy9UTw7HFbwd
 9M2qhmzeQdq41DjTTRmd4VYCr15goQf/Rg9TediYaRpdmf6xLm6mL30ydF14mLvISp4Xc7vb7Uh
 bgnR52ec4BWmmYvJv1zqmfaPCFadw5ZNCI3xJGV5MCfklvcOTvX7E8hQO1pV1U52HBNFanTa0Rv
 QZgVaWE/1CkpAngVzt0O7AExIW9yKZrCpgh7r5m55WTchbcU3UH6niXq9uUQBlm1oOvN5l0f/tJ
 0zVX0DExdr4q2qbuhephFjBZRMuafPyQJ0UjZWvXf8+JieJ7AI+boq4wgpdHbQbG5itNytCfXpS
 I4Zizbxm0yJj3zmtUiw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDExNiBTYWx0ZWRfXwBsapw1/FwYt
 Sb2Rqco4BsqlL3bGvKO0n9FSkFAoDti+444J5/YKyGNDc+lE+Rdo6gh++CDxswVlv9xMPdO2BKF
 YGrO31ZhM19zcRrg7xTC5BvJrY1JsLw=
X-Authority-Analysis: v=2.4 cv=fvfsol4f c=1 sm=1 tr=0 ts=6a85c457 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=gtMiE9pvqgAortkEK9IA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190116
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

Decompose the halt-to-execution transition into distinct steps:

 - process_async_events() called first to handle
   target-specific asynchronous events,

 - transition_halt_to_exec() called after a halted
   CPU has detected pending work and is about to
   resume execution.

Either callback is optional; targets that don't implement them
fall back to the existing cpu_exec_halt() callback for backward
compatibility.

cpu_has_work_after_processing_async_events() orchestrates these
callbacks: process async events, check for work, transition from
halt, and clear the halted flag.

Inspired-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/accel/tcg/cpu-ops.h | 17 ++++++++++++++++-
 accel/tcg/cpu-exec.c        | 21 +++++++++++++++++----
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 3ff6e6810e0..16c19da997d 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -169,6 +169,20 @@ struct TCGCPUOps {
      */
     vaddr (*untagged_addr)(CPUState *cs, vaddr addr);
 #else
+    /**
+     * @process_async_events: Process target-specific asynchronous CPU events.
+     *
+     * Called at the start of cpu_exec() to handle target-specific event
+     * processing before instruction execution begins.
+     */
+    void (*process_async_events)(CPUState *cpu);
+    /**
+     * @transition_halt_to_exec: Prepare CPU state when exiting halt.
+     *
+     * Called after a halted CPU has detected pending work and is about to
+     * resume execution. Target-specific cleanup and state synchronization.
+     */
+    void (*transition_halt_to_exec)(CPUState *cpu);
     /** @do_interrupt: Callback for interrupt handling.  */
     void (*do_interrupt)(CPUState *cpu);
     /** @cpu_exec_interrupt: Callback for processing interrupts in cpu_exec */
@@ -185,7 +199,8 @@ struct TCGCPUOps {
      * if it should remain in the halted state. (This should generally
      * be the same value that cpu_has_work() would return.)
      *
-     * This method must be provided. If the target does not need to
+     * Either %transition_halt_to_exec() or this method must be provided.
+     * If the target does not need to
      * do anything special for halt, the same function used for its
      * SysemuCPUOps::has_work method can be used here, as they have the
      * same function signature.
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 1a942664895..54561ed31c1 100644
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
 static bool cpu_has_work_after_processing_async_events(CPUState *cpu)
 {
     const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
-    bool leave_halt = tcg_ops->cpu_exec_halt(cpu);
 
-    if (!leave_halt) {
-        return false;
+    if (tcg_ops->transition_halt_to_exec) {
+        assert(!tcg_ops->cpu_exec_halt);
+        if (tcg_ops->process_async_events) {
+            tcg_ops->process_async_events(cpu);
+        }
+        if (!cpu_has_work(cpu)) {
+            return false;
+        }
+        tcg_ops->transition_halt_to_exec(cpu);
+    } else {
+        assert(!tcg_ops->process_async_events);
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
+        assert(tcg_ops->cpu_exec_halt || tcg_ops->transition_halt_to_exec);
         assert(tcg_ops->cpu_exec_interrupt);
         assert(tcg_ops->cpu_exec_reset);
         assert(tcg_ops->pointer_wrap);
-- 
2.53.0


