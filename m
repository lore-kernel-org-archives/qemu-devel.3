Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BEAC9830E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9QYF-0007I8-Lg; Wed, 23 Sep 2026 13:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9QWz-0005qq-Kc
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:13:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9QWw-0001GF-Qg
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:13:16 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NGTbmF3798584
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TmpLRtcALdGvnoiA64jtGQ7kzwpnFEecY1PS7YhgtmQ=; b=nisyyqOohJaiCiNO
 ABaJBBqubUMyIYSOyjSLV2qu5z0Ai29jUvMiRipfBoGL9G5PO+8Cr+NcuuqAaC+K
 HVBdnX7CG2Q5qS5S+c8D/KAbHTnmhpV3UCf+DGjy4T0+NB/hn3dGDlrl963nRxpZ
 9LvJ4UpAiJt19ooaPDl2o28lso3OZXbHStZK5ZjfEj/stJtO3hUHJnlAnc9gZ2fs
 qIZz0O7YOphJLorPFSusfDfM+6cbmisRgqQ9bxNTbs1RWJjhmQl9hSQw/LecufW0
 xmDSU7FSy9BBafzjVXm8gULzW1LdVkf+YlsS+yhVHySOMG2TghduQpNr05KfFOxh
 ArLL/A==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvhsb0c15-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:13:03 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-785827e6073so352674137.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790183583; x=1790788383; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TmpLRtcALdGvnoiA64jtGQ7kzwpnFEecY1PS7YhgtmQ=;
 b=fJ2zIzg7/Xtu7i/u5Oi+FaRqjeFL0C8IQhdBP1Z6FkDdSHrGP8Eg7KR4voefhlmsnt
 mTes0f6+2MdCwnJqaklRxG2WfwvtI9xjnbK72++2AuxhZ40MBHu5G0iQFLrLVjlnht+A
 Brh8+QB3SDUGaiHvahWGOfd2316phqls0VXtCAxAjRFEVBKOoczkI2RujZD412U2RC7P
 Tjc2JR3oyyvKDU/i+IRW3s0hG9TkYXr7duJ2XCtUT1MPre/7CbA8aWMz6MaCcpZCwgh8
 MyTGSwqXPnk57QZfKQdLNuCNt3mkR4emoE1WKi5Cc1/SawpXkiAffH0ZEGfWsI1YjqzX
 0fbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790183583; x=1790788383;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TmpLRtcALdGvnoiA64jtGQ7kzwpnFEecY1PS7YhgtmQ=;
 b=gBSz/gR3Dl0wZsSGGA5CopBPl1lHLqU56z3TNvIgLLhH8/4Av9LUe+ws74NS7hC4EM
 firZ/bhBiPWijl34EFMBiFIx7kSDtFSiwUHxdHhfUq8NOcYizsugHpXMH7G/LCUJ/yeq
 8LOP/lWzTEB2wtGY5x6rKypMnN9uF+KPZxumKlBA/GhPhgHWz4zzFWEKnrsY0IoKB8mt
 qmsG93B+pKLQcwfOpkYiffnB1Niv+Mnp/XxVnbBg0XHCKp5bXcokJvnA1Mbsyv9dKxaw
 2PMieKRh7mks/tOc3RhFb4SRVI5os+FtH3etVv62UxD6IkeaPYRU0QWRgOo2wUeBs9I/
 NOtA==
X-Gm-Message-State: AFuF++mUIeX5lATo+Ba8fue/qJJDZtHYU96Fw7Lf8Bbw59kGDai2Yo7R
 NmUp7+plM9jPBDKQ7M/aG0GirIS4oaTro6KiXtevDtf5pJHJL/kj+wo5bLq9RP4h/EUPYfXCURD
 XXjLUeAuHObsUqmg5WrdHeQXQO1I3lkKHCb5MkKQDtq02EvEq2tukqJrJUSJuNYdGDwCR
X-Gm-Gg: AYBFou0y9gpGOGQ/uJahSjxXfPPRm0Oa4IPYFIXbLv1C9JbXF+ES78eY0uBa5/POjz+
 HBn4iv98obucW8Q2wjwsu94H0o4g7FupDvgySE+5dEi1qVqS3NPn7VGffpLQQQax+CnMlj0Em+4
 bKfaKXMSYuJI5nnFFhMbE2qs2MVY9gYQr3unImRI3ubGq3uN6Ssk/f/IlqroXnjX+YOvSXoExPk
 Nf+F1zqhsMJs9lUt9ahUffb9mvQ9HWweoE8MtQblXcU52n5WBUZWHnpw3AHKfCXwpO+CUnbk2J5
 h90NzyQISYcq7ByENYngphJWPfSBqE8teL1hGAXDK7W3+Oi7LVXBwDf17rrsGX6d295CTh0ws9r
 aKeJCEa5/ogs7QfZbA/US9oYORFhovnFM2wtFTkzT
X-Received: by 2002:a05:6102:38ce:b0:7a1:f7d2:e84b with SMTP id
 ada2fe7eead31-7ac1da2dce8mr2818768137.27.1790183583153; 
 Wed, 23 Sep 2026 10:13:03 -0700 (PDT)
X-Received: by 2002:a05:6102:38ce:b0:7a1:f7d2:e84b with SMTP id
 ada2fe7eead31-7ac1da2dce8mr2818746137.27.1790183582641; 
 Wed, 23 Sep 2026 10:13:02 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe0c104a6sm67021345e9.0.2026.09.23.10.13.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 23 Sep 2026 10:13:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 14/21] accel/tcg: Introduce poll_during_halt() and
 leaving_halt()
Date: Wed, 23 Sep 2026 19:11:08 +0200
Message-ID: <20260923171116.31276-15-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923171116.31276-1-philmd@oss.qualcomm.com>
References: <20260923171116.31276-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bqwNdGyPP0bWZ6-SLcmNTSgU2aXgO7SF
X-Proofpoint-ORIG-GUID: bqwNdGyPP0bWZ6-SLcmNTSgU2aXgO7SF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfX9LqkyNgEozDz
 UYtVX2MuJCN8/rnvLPjPUbLCzO/l08wKLdAc4TrJav4bo2L9j6uqNLGK+XTRXxmU136dLMqyovk
 +NfaYB6+vSGC9tkmj63EjLPU5mjjp1klA8Uj8n1fijQnXAhFvZRWG0BWtN/4/5bMWsYXR12cu3s
 +BtgndrpaG+q9J+uNGLJhBTKxdPsLF5h+BXhm/Q8me6lX5OdXLFf1j0QmeNIqKGZNIckNBKSX/o
 ++iqODTD8SCQ1kzw6LfHuvVLl1azY1KsVn9vyxXdNC1c50GElaZN53rTqwdWSM/rDpLrvdo+6KG
 8P31BofiqbCYXicq6ts7WqnoabuqIRBX6l2fw+UatLVWrUneAWDBe11zF6uQboUhXMBACXkKqba
 OW1LHVpDgU3BEdjIgxnHJJcsXHPdKCwOKElDp+UfbHQlDYH1w3FBq8doCeqnujpDChM1yERBceU
 x4F7wLPKcowIaN8qpwQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfX6DM6Njguoucq
 4awb0+u6XUqIqFWQ/vHpXcud2ZOEX6opQ8BUG7Co0BiiDQiydHWRGS+LE5huthIxpKnzGGtZrOd
 WDTsA8raHhwc4REZEBwZTVikZEA1YS8=
X-Authority-Analysis: v=2.4 cv=f7vdl+yM c=1 sm=1 tr=0 ts=6ab4089f cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=DbqnPDNGgojIjNu1nyEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230068
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


