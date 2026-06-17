Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0163CCD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 17:16:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZtrh-0000Yq-2Z; Wed, 17 Jun 2026 13:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZtrU-0000Us-0z
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:15:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZtrR-0006yj-QB
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:15:35 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HFoULd2731330
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 17:15:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SYTycsYV8IBDgqm0YFuqjeDvuJkqJsQvzubIvsOiL5w=; b=QDdLi8Bgba576CGf
 8tV/8XASpiH/3J7RBxzHKX3Zy6Z+r3WIecwHYoUQDSkrTHRpRrc58MtLsO+w2oQn
 ksAQMoixeoNWXUcFBAStXTimCVk3xNoXf1XyLMxsHt/V8/ywHYiTzNstvAY9ZWfU
 FmUtIWA0CfdUk9hUaCfs8cjCR5VM+mqfLrPR/kIdjO0xzx56LLKbTtTpV15lX5/d
 3XUZyQ3UdgXyMDNAZ2DcFuXVdVzvNHS1rqUjZ5cKm6ZdqoVyX/nf2Iw36hqUgl5l
 AnhoW5FATjS6dDyk0urzwyy7VEE2Ao6Qqmn53FoItmGxl4RpjSkvJV5lIkIyh5fh
 zvtorw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2c8pd5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 17:15:32 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-963d24c3886so5012252241.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 10:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781716531; x=1782321331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SYTycsYV8IBDgqm0YFuqjeDvuJkqJsQvzubIvsOiL5w=;
 b=QMhDaVDTin+H85jyp9ekRvTcJRKuPPL+Cg5YXQhKxTny33SWRyqZRLP3G1+dkrUNMq
 7rlz1IyBWy+1cG590PMoWFAws/SyYboh74Oaq9HDsrqNTh0Luf8YhTVje8sDsidqNUkI
 zdetbhfawUWbe9PqpW39WdgBgCpZ3PFumugwv6bjo0NDsMQsQodsGBHyGsqLn1AvO4S7
 8M1pXSJPBAd98gPKfIBrve6hqPhpGvXWKedgc51A5CFbi+7utVNVrYbG5c6Bvf3X8pAP
 Zr1S8imCZi6re5OXwirF+/sG/YzbeiI+h8jzoWpBgnMVmE0R1HOBf3vE2UOdrK8Y3gLk
 xiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781716531; x=1782321331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SYTycsYV8IBDgqm0YFuqjeDvuJkqJsQvzubIvsOiL5w=;
 b=YpKeuyUnSkdDHx78KARvQAzdpKqhM60Yp4MH7AE86506nWSAnDLrVb4sQf8b+AQ5JB
 Dp1rzgEFLDEEXMlJ9LM62xqW0VzY/VwRDWQxrfL2a8RwfRsDg/9gXTtODoAva14c+K7M
 L6Jk/opjEBCLwaMStfrZps61zMLpDlIrqYdmihvsm+rQ+tns4xe3zFhFDpERXm+lw/0P
 NV/g5+5EHhltd2C22+6/Vj7EHcB85C/e8AMw+Ux2jzuzWveqI/WUt7BPYWdpnvSK2zP5
 EmJ6Ajnxskje1hK3v5C48Ksvb3EwhOHk8LSDTlyrwyCVH+7Xo9HI4gGtVceSac7EuVXC
 F+sg==
X-Gm-Message-State: AOJu0YxbT2KSH/3kSZNBsqv+mxF4LcuTEdrPQo1kKlX95thB3sDMIb8e
 TvtVQKpVkAPeixcQqUrrnnMBF0kHPhTpfvM5VltrV0lD12Git3D7BSXau+MbRzqeXfbgx1+WeiU
 0zxhLIuIethqJEZ18rdSv3Btbro/nr1ksIzLbiJb7FVb+mlwvVXgXMtRPvxStu8Bmrg==
X-Gm-Gg: AfdE7cl+GeHOxEeWlFio7gv4GFpDMsjRdmO2li7UIeRq22WH51EzcS9pxAjVvs5xpTf
 GyRBOrSR13P0giLOr/n2w/V/rhd0cjd5AamA1fRWzrZyhdyWIKFotAO18QIxU1BTqe5Bv/2OtL+
 Q0AiQHd6Rdj7D0MQx4ccCzVFdw6A7UI7LpQeqEHwUcICH4Oa8YqqQKP5IvGqghnZcHmk46cSgKb
 dTV1C2mQndipReqbVme8cVk2nTNcCNzzwHvOS+zDLU08iZ7McGbOyROb/bb6Ck17BEAN6hmgRfX
 BjcBNhmKAJKVZqP/L0VRgpifWwmPOaNM7Z20Ogl6+UbTB/SVj0q0zzsShXtYevktVC1c8JtArNz
 8AdLuPiSjMdAsNof6FQ0RPCwah5sBelCdYghoXMuEhE9tcm7/4H/iIC9PjjUWrH4QlP97
X-Received: by 2002:a05:6102:443:b0:727:48aa:f604 with SMTP id
 ada2fe7eead31-72748ab1fbdmr800880137.28.1781716531343; 
 Wed, 17 Jun 2026 10:15:31 -0700 (PDT)
X-Received: by 2002:a05:6102:443:b0:727:48aa:f604 with SMTP id
 ada2fe7eead31-72748ab1fbdmr800859137.28.1781716530830; 
 Wed, 17 Jun 2026 10:15:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4619b9b7750sm27389858f8f.6.2026.06.17.10.15.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jun 2026 10:15:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 07/11] accel/tcg: Move cpu_restore_state() out of
 'exec/cpu-common.h'
Date: Wed, 17 Jun 2026 19:14:34 +0200
Message-ID: <20260617171438.75914-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617171438.75914-1-philmd@oss.qualcomm.com>
References: <20260617171438.75914-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE2NiBTYWx0ZWRfX25+TA34h0TZ/
 sAyWLviEQZSXtVYgn8pWdMKdF9kJWeJY3+NAvGq8W+8QXtShPoDe8utXsGzThL8Rw746fuiN64N
 5+7cSxNOSZ6ojPPmGfEAVg+GOKhuJbQmA4HYG3+JXYZqVCcMdp/m3Rx72rc0nJYOSsF2GgTRGEf
 SPIXZBgFYWJ8BVW+MLH7NnywAyOgahlkFpXgYTpN/0SWk1YXQh1za/UXTZZqqoIUAQ3ljaQc+Aw
 XnANW4xl1Q+4qFZQN03DJH9jCfbBu/mD3M1kBajdeffvohsx6SCom/XsxkGGQFHi+USZ7r2qhCG
 ZwJvwvJgyFUI26FDa+BjKvzz1T3Eek4udwFO7+1U2lnl/Nw+FL15qrv6CEfEcdxwC7U4c5uN+vg
 dj6S4jzVBHYKowGAD+GLDVT61//ZqxUePCF7emorp34UsOsjbagE1IpleutRbdQXLoLYSYN+jn+
 +3xmUVRiRzPlJ2jou/w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE2NiBTYWx0ZWRfX2MIcsOAz0QhY
 2fo6z7hC2eUtYxSRYeBTHGuY50gPgNb5qWZzWbsJ7/9Exz555Xjxbi0I5PLTCnLZ/l17yuH8ii0
 qaYhIpF2yEVRAMyQa6i0zJfFc1L3nzo=
X-Proofpoint-GUID: F65sR-7EfnfMAQ_oxQs6xZDOXGr6fqD1
X-Proofpoint-ORIG-GUID: F65sR-7EfnfMAQ_oxQs6xZDOXGr6fqD1
X-Authority-Analysis: v=2.4 cv=WN1PmHsR c=1 sm=1 tr=0 ts=6a32d634 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=7NYfQX0GWP59tyU10OEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170166
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Move the TCG-specific cpu_restore_state() declaration out
of the generic "exec/cpu-common.h" header, to the recently
created "accel/tcg/cpu-loop.h" one.

Include "accel/tcg/cpu-loop.h" where appropriate.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-loop.h        | 12 ++++++++++++
 include/exec/cpu-common.h           | 12 ------------
 accel/tcg/cpu-exec-common.c         |  1 +
 accel/tcg/user-exec.c               |  1 +
 target/alpha/helper.c               |  1 +
 target/alpha/mem_helper.c           |  1 +
 target/arm/tcg/op_helper.c          |  1 +
 target/arm/tcg/tlb_helper.c         |  1 +
 target/hppa/cpu.c                   |  1 +
 target/hppa/mem_helper.c            |  1 +
 target/hppa/op_helper.c             |  1 +
 target/i386/tcg/system/svm_helper.c |  1 +
 target/m68k/op_helper.c             |  1 +
 target/microblaze/helper.c          |  1 +
 target/ppc/tcg-excp_helper.c        |  1 +
 target/s390x/tcg/excp_helper.c      |  1 +
 target/sh4/op_helper.c              |  1 +
 target/tricore/op_helper.c          |  1 +
 target/xtensa/helper.c              |  1 +
 19 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/include/accel/tcg/cpu-loop.h b/include/accel/tcg/cpu-loop.h
index f328aaa0377..2fc38c8f1c4 100644
--- a/include/accel/tcg/cpu-loop.h
+++ b/include/accel/tcg/cpu-loop.h
@@ -28,4 +28,16 @@ void cpu_exec_step_atomic(CPUState *cpu);
  */
 bool cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *data);
 
+/**
+ * cpu_restore_state:
+ * @cpu: the cpu context
+ * @host_pc: the host pc within the translation
+ * @return: true if state was restored, false otherwise
+ *
+ * Attempt to restore the state for a fault occurring in translated
+ * code. If @host_pc is not in translated code no state is
+ * restored and the function returns false.
+ */
+bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc);
+
 #endif
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index ba98304c5fa..3757ab15967 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -64,18 +64,6 @@ void list_cpus(void);
 #ifdef CONFIG_TCG
 #include "qemu/atomic.h"
 
-/**
- * cpu_restore_state:
- * @cpu: the cpu context
- * @host_pc: the host pc within the translation
- * @return: true if state was restored, false otherwise
- *
- * Attempt to restore the state for a fault occurring in translated
- * code. If @host_pc is not in translated code no state is
- * restored and the function returns false.
- */
-bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc);
-
 /**
  * cpu_loop_exit_requested:
  * @cpu: The CPU state to be tested
diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index c5c513f1e4a..e48ea31373f 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -21,6 +21,7 @@
 #include "exec/log.h"
 #include "system/tcg.h"
 #include "qemu/plugin.h"
+#include "accel/tcg/cpu-loop.h"
 #include "internal-common.h"
 
 bool tcg_allowed;
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index d283d3cc724..7704e4017dd 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -25,6 +25,7 @@
 #include "qemu/bitops.h"
 #include "qemu/rcu.h"
 #include "accel/tcg/cpu-ldst-common.h"
+#include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/helper-retaddr.h"
 #include "accel/tcg/probe.h"
 #include "user/cpu_loop.h"
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 2abf07c1919..c3614ecafda 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -28,6 +28,7 @@
 #include "exec/helper-proto.h"
 #include "qemu/qemu-print.h"
 #include "system/memory.h"
+#include "accel/tcg/cpu-loop.h"
 #include "qemu/plugin.h"
 
 
diff --git a/target/alpha/mem_helper.c b/target/alpha/mem_helper.c
index 572ea9cb418..b3988417e4b 100644
--- a/target/alpha/mem_helper.c
+++ b/target/alpha/mem_helper.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-loop.h"
 
 static void do_unaligned_access(CPUAlphaState *env, vaddr addr, uintptr_t retaddr)
 {
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 504526153a6..9f9ea39be5a 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -23,6 +23,7 @@
 #include "helper.h"
 #include "internals.h"
 #include "cpu-features.h"
+#include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/probe.h"
 #include "cpregs.h"
 
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index f90765cb597..2ce63734099 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -8,6 +8,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "helper.h"
+#include "accel/tcg/cpu-loop.h"
 #include "internals.h"
 #include "cpu-features.h"
 
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 6443122cf1a..a68152f9682 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -29,6 +29,7 @@
 #include "fpu/softfloat.h"
 #include "tcg/tcg.h"
 #include "hw/hppa/hppa_hardware.h"
+#include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/cpu-ops.h"
 
 static void hppa_cpu_set_pc(CPUState *cs, vaddr value)
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index f5076492264..01e6149c811 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "exec/cputlb.h"
+#include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/cpu-mmu-index.h"
 #include "accel/tcg/probe.h"
 #include "exec/page-protection.h"
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index f961046e4c5..76a8d8a0d34 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/probe.h"
 #include "qemu/timer.h"
 #include "trace.h"
diff --git a/target/i386/tcg/system/svm_helper.c b/target/i386/tcg/system/svm_helper.c
index d5ffabc2f4d..52a234e7fac 100644
--- a/target/i386/tcg/system/svm_helper.c
+++ b/target/i386/tcg/system/svm_helper.c
@@ -23,6 +23,7 @@
 #include "exec/helper-proto.h"
 #include "exec/cputlb.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-loop.h"
 #include "tcg/helper-tcg.h"
 
 /* Secure Virtual Machine helpers */
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 8148a8852e7..38f7a689814 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-loop.h"
 #include "semihosting/semihost.h"
 #include "qemu/plugin.h"
 
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 6a982c18c0f..05a90f5ecb2 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/cputlb.h"
+#include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/cpu-mmu-index.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index 5e6c1e326d4..b04f07a6377 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/log.h"
 #include "target/ppc/cpu.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-loop.h"
 #include "exec/helper-proto.h"
 #include "system/runstate.h"
 
diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index 05e448d3f20..d952bb20cf1 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -24,6 +24,7 @@
 #include "exec/helper-proto.h"
 #include "exec/cputlb.h"
 #include "exec/target_page.h"
+#include "accel/tcg/cpu-loop.h"
 #include "s390x-internal.h"
 #include "tcg_s390x.h"
 #ifndef CONFIG_USER_ONLY
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index cf0f80e4a54..90c065b217b 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -20,6 +20,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-loop.h"
 #include "fpu/softfloat.h"
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index 3cff5000c73..46b17da2bc6 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -19,6 +19,7 @@
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-loop.h"
 #include "qemu/plugin.h"
 #include <zlib.h> /* for crc32 */
 
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 2d93b45036d..5a0e8655146 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -32,6 +32,7 @@
 #include "exec/target_page.h"
 #include "gdbstub/helpers.h"
 #include "exec/helper-proto.h"
+#include "accel/tcg/cpu-loop.h"
 #include "qemu/error-report.h"
 #include "qemu/qemu-print.h"
 #include "qemu/host-utils.h"
-- 
2.53.0


