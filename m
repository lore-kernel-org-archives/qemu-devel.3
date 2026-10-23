Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C19B606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=e22G30U6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ck5pExKs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHzM-0007Lv-V4; Fri, 23 Oct 2026 12:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHz6-00072t-Jz
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:19:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHz4-0002eN-Pe
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:19:12 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5vmx4063370
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:19:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Gn9MiOR2eaQ37vMb0O5MnVQFkreDGb4IcS1IszPzllk=; b=e22G30U6n0yRSZmY
 Tl0sh8SoGMUHNKtck8LHoqtUGOqgHJG3iGxMA0q51rHcLvq8OiL2eJzUr8pJHORe
 zVbnZh+L8rxd9lNpo5XgfGgJYRHuQao05EenjLsmK/mwjLUCZ4+CJfxo4ukhVLvm
 2KqtobMPCF/JgKnae9qpGIsJT1qXsSEb8SuWE/Brm6BYAmcnS0E8T/Qiu98wlqSx
 ut5vGfuyjNDV24CjEqkvyf3ursU4h4qjfnCaKt+YjniTR/EK9H7Gwax2l6+NvMPm
 KJixq9tdmar2Jc4A5/TfkzkBaJ5dcz9ym3FW5yCZVePRKF6jMUtPypOHXv4daNtt
 +GmLcw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmrch0h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:19:09 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-936aa34873bso204146185a.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772348; x=1793377148; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Gn9MiOR2eaQ37vMb0O5MnVQFkreDGb4IcS1IszPzllk=;
 b=ck5pExKsTo2yX8wNREVj5PSvzSLMq1EjJc3gDMQN3xOKnFgHH0O9XzgVmqx8v2OxtB
 BwlTp/97iUxHmjanFWZnrDYsAAKZsl/S9wrp6yeQVmRSaGLJhuj2tat4w7+NcRExqzh6
 rHMXQeiGEyflfL2w6MXiS7GRgtqvJGnujRopAjtqs0pa3FsXGzK9lL+k7mrtEtmjJ4Sy
 oeIG+NhcDiIfCTvZ1OkGRmSMdZ5CqWO6svbfK5STFFjw6oj+CxrdX8D7fB8OHCki84Js
 z1/uVCiQkZFi6ZJDvQPdZ8IeTYi6b5g/5zIRPRzG+fa7yf+IjsLs2Upqv9ea+VHYbawW
 1ukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772348; x=1793377148;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Gn9MiOR2eaQ37vMb0O5MnVQFkreDGb4IcS1IszPzllk=;
 b=mYwo3Daw8EwA/r99nRjyKHT7AWa0Tmqrb7jKf59OFmBMduV4OM6reBC3DK5X5RYlNT
 7+VgjDrTc3TjHf8smig3iv8nSZKhT5hbDIN5Ne7rVbV//xgSJZruPfYGxKMLNAhLQ3tB
 EPZySPEbyjPyl/LJEX3GPyF3daiC7eRkYYI20WZQWUfMwoWMbbK+ZN7zwRgh5FIWbulz
 j32Pcj2pNJ5gbVXL5VCV8m9PEn7HZM3JGdlXonqcjonVAOpKiaphlmS97lvhjt192U4O
 Dt9Qt23YrV/sl5yfFFy4bMnJoLHY7JkZWUIDf9fFn/iIoNRq7eIajjdhwq6V1qYO/iaf
 PDNQ==
X-Gm-Message-State: AFq9FYIcxcYmW+o8L54Xs+xHWbsSDTbGp/AkPDwTlz66Qf9ueD+ldx3a
 lG1tMMrhaRfVa2hvKtNNPk4Bl7ztnhkBSdkjmIy++YHSC2FBkpt0UpXMg7o4TU9QSwiy5L5bkzt
 nZ1IShGTZsbQ5XxNmEifjetQvmh1l/NDAcLFj4HevMSIBOP5rH2k9IhUphH+yzuLcsM6S
X-Gm-Gg: AYBFou3YCdlUXVJSzIRghFYk8FtTUoNanTeSZN0FDYHqMNU0lfoFuySDTtgR8h6sJTz
 jEdO9flSgaAuu7eYZLNnHp7o8UE8serCZZwAQKfbT76yyhUMJp9hm8nTHV2PcgOkYCNNaQFKe6o
 3PcfhckhYAs4tNxTLhNbA3nEjJvWKLawgAo3LSDTr/dMnaZI0qsu0N/4PCU2Eyqe3Aph1Iecsg4
 Kjufo8MnZz34oEscQot+7s0/UXLjWbC9ZLaTfbQKvXA+dHWZ3MnW5vuaW/6YcKgCoZeDnIKjvUZ
 YQS3KMJHDwkOlt4lGrqwCOgDmiI4tWAaYrJ5Fx71I0O1XyfBSiudNGTFvsfVYlMKu8hZy5NorbF
 3QcleMwjEe/c/U4NcFJmbTth5z+xe8RNQl/PwExbh
X-Received: by 2002:a05:620a:8389:b0:93c:c73b:39ed with SMTP id
 af79cd13be357-93f6f7c4facmr447639485a.39.1792772348231; 
 Fri, 23 Oct 2026 09:19:08 -0700 (PDT)
X-Received: by 2002:a05:620a:8389:b0:93c:c73b:39ed with SMTP id
 af79cd13be357-93f6f7c4facmr447633285a.39.1792772347581; 
 Fri, 23 Oct 2026 09:19:07 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a312fb9b90sm10794415e9.4.2026.10.23.09.19.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:19:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 46/83] target/s390x: Implement and register
 CPUClass::exception_name()
Date: Fri, 23 Oct 2026 18:12:54 +0200
Message-ID: <20261023161332.60153-47-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xURG-Z-LG3Guw4SdTbLKl8fD7hy7jcIo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX+tUoeaZ6OkIy
 bF75OBGx8scmoggRTO1UbxQriqLlx2ZznxSMoPCP25MfQTZQ1Mi8tU5XrlRk9Ok/FrubYLWKs1O
 /JxfACI/zHTG1T7ANCnz7Xci2HzIcDI=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6adb88fd cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=u-qA4s_dmyebC3KKCgsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfXwSZShbKEu1u7
 y7iEIC9gGZl6QElJv1Pm6MiE19zd5znxjmE2iDG/AY/GcqffSjFWe+tQP4JR/VqAfDcwCZDTCYd
 jNL1Qq8eTuNr43rW1yJWqKfPyh2icGkkzoMtfhubmiAN9iWGc+3TjYTyMiABVlBhyFL9QETgBzY
 +cY5qO8t3oo6+8Dpee/DPBh/aYFR8fXz0SOCeY+eyHwCIa7wzZECGjqmqaJTcd00sbG3CbETl4l
 u0q5njbtOv4fMhcI8fmiL678evzJ5kFnDI+QWyZxm8CWe78iY8TmrmW23XHAj4rgQFlbWcdKaw7
 mYZ2EnGH0WrsCKckV9ORplPkRmbYaTPvyGGhy5/ghJ99k/rCdcyutf8AZFDPhfPbQ70C0LU5LHI
 IfMid71kEar8Ok6IzklAVXxORQkC0xtcRj6CEQOrrDGsSroOGY/+l3Kwk9cegGYB3w0xafuqxW9
 vRdeW2+4y97+o0HKAlQ==
X-Proofpoint-ORIG-GUID: xURG-Z-LG3Guw4SdTbLKl8fD7hy7jcIo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230063
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement s390x_exception_name() and register it as the
CPUClass::exception_name() handler, so the common exception
logging can resolve s390x exception codes to names.

Use the new helper in s390_cpu_do_interrupt() and helper_exception().

With '-d int', s390_cpu_do_interrupt() now logs the exception
name in parentheses after its number.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261022215115.19680-28-philmd@oss.qualcomm.com>
---
 target/s390x/cpu.h             |  2 ++
 target/s390x/cpu.c             |  1 +
 target/s390x/interrupt.c       | 16 ++++++++++++++++
 target/s390x/tcg/excp_helper.c |  6 ++++--
 target/s390x/tcg/misc_helper.c |  3 ++-
 5 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index ef73b15218e..37b6e541312 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -437,6 +437,8 @@ QEMU_BUILD_BUG_ON(FLAG_MASK_PER_IFETCH_NULLIFY !=
 #define EXCP_IO  7 /* I/O interrupt */
 #define EXCP_MCHK 8 /* machine check */
 
+const char *s390x_exception_name(int excp);
+
 #define INTERRUPT_EXT_CPU_TIMER          (1 << 3)
 #define INTERRUPT_EXT_CLOCK_COMPARATOR   (1 << 4)
 #define INTERRUPT_EXTERNAL_CALL          (1 << 5)
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index e7f81fabff6..d1250945d48 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -407,6 +407,7 @@ static void s390_cpu_class_init(ObjectClass *oc, const void *data)
                                        &scc->parent_phases);
 
     cc->class_by_name = s390_cpu_class_by_name;
+    cc->exception_name = s390x_exception_name;
     cc->list_cpus = s390_cpu_list;
     cc->dump_state = s390_cpu_dump_state;
     cc->query_cpu_fast = s390_query_cpu_fast;
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index d7e3fd45e4b..28174522944 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "cpu.h"
 #include "kvm/kvm_s390x.h"
 #include "s390x-internal.h"
@@ -19,6 +20,21 @@
 #include "hw/s390x/s390_flic.h"
 #endif
 
+const char *s390x_exception_name(int excp)
+{
+    static const char * const excp_names[] = {
+        [EXCP_EXT]      = "external interrupt",
+        [EXCP_SVC]      = "supervisor call",
+        [EXCP_PGM]      = "program interruption",
+        [EXCP_RESTART]  = "restart interrupt",
+        [EXCP_STOP]     = "stop interrupt",
+        [EXCP_IO]       = "I/O interrupt",
+        [EXCP_MCHK]     = "machine check",
+    };
+
+    return STR_ARRAY_ELEM_OR_NULL(excp_names, excp) ?: "unknown";
+}
+
 /* Ensure to exit the TB after this call! */
 void trigger_pgm_exception(CPUS390XState *env, uint32_t code)
 {
diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index d952bb20cf1..83fe65e1f8c 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -508,8 +508,10 @@ void s390_cpu_do_interrupt(CPUState *cs)
     bool stopped = false;
     uint64_t last_pc = cpu->env.psw.addr;
 
-    qemu_log_mask(CPU_LOG_INT, "%s: %d at psw=%" PRIx64 ":%" PRIx64 "\n",
-                  __func__, cs->exception_index, env->psw.mask, env->psw.addr);
+    qemu_log_mask(CPU_LOG_INT, "%s: %d (%s) at psw=%" PRIx64 ":%" PRIx64 "\n",
+                  __func__, cs->exception_index,
+                  s390x_exception_name(cs->exception_index),
+                  env->psw.mask, env->psw.addr);
 
 try_deliver:
     /* handle machine checks */
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index f1c8563af00..a01c5d894e7 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -61,7 +61,8 @@ void HELPER(exception)(CPUS390XState *env, uint32_t excp)
 {
     CPUState *cs = env_cpu(env);
 
-    HELPER_LOG("%s: exception %d\n", __func__, excp);
+    HELPER_LOG("%s: exception %d (%s)\n", __func__, excp,
+               s390x_exception_name(excp));
     cs->exception_index = excp;
     cpu_loop_exit(cs);
 }
-- 
2.55.0


