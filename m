Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392E6C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1mmH-0002ia-Uu; Wed, 02 Sep 2026 11:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1mmE-0002Wo-VR
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 11:21:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1mmD-0000EQ-6Z
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 11:21:26 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682CR8do1549926
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 15:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ji5J4HKmPdW/CWTW2SUhTxHcUUTcenx5uhnZFfihhVE=; b=cqX616d/uyTXUNky
 cJut0zr4MaV7+EUooCerieI9I8TrtsBHshbM70H3UK9Dr47Wxv2ZHoBi7AzwTkBn
 gWQPdyCzT8A6nChtMHsKoGuNAqYlBgfiTbifEpGX/+9I3Hg3/9J5ViI7p3/itsIG
 vK0H8wMD4hitaKZa4Q6VtvQf/vnVKyyEP2wFLFBOSbQ5NQSyAMTO6DgAdbqC1KEc
 cgEktR8E3m1/dLAnMZ3QugU3ShnKO8leC48Dlh/oALNRvIfHwjnRmy98hVqW7XFJ
 Zlzg/ddITZiMX+oqiinFgRGCg55fToMQFACscoee84ANMaotLfd3ahkBFdwINSFR
 nfMQFg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gej2c94wa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 15:21:13 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e5fc4c7e9so49211385a.3
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 08:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788362473; x=1788967273; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ji5J4HKmPdW/CWTW2SUhTxHcUUTcenx5uhnZFfihhVE=;
 b=KyopZ55Fb4cGJfufJBbsH+osNZJKqYauriBJAF440QgkjhGHpfj6YXIKZMMQ75DkPx
 6Wydz/LhZfTa5+zLgLhwuiYQ/gEg+qEfRuI6MZm5xMLn3WT2GyhaQwMwG6sBUQ1HP8D0
 7ECN+tg80FTjgQE/Eb9EbxgUieOAjT4EDxiBppl9SmDW3DUegbFTonZahizSTTmOkoBN
 ve9uUEMZYWUq5zuXntI+NQNJD0nfTxe0dGIdqi0bx/aVS88IPBfcySFZj2Lchcu8YYKG
 TPXzRhPFcZ0g1poZro6l92KY8w3V7xqsAMhpzNZ1mUhhF/VY8e0/GV4Kq/JFmVPcLaVV
 T/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788362473; x=1788967273;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ji5J4HKmPdW/CWTW2SUhTxHcUUTcenx5uhnZFfihhVE=;
 b=oqiT6WxXd2sQuf7LH/vYgxGy52Yfm+DZP3TV8VPQvdvY1n3CuhcG+gSq2SZefahwax
 tRS+KySmKfnaaYGyGNq5ZnHrh7ZOZ0z1QqWfJ8+kdWWccCYNIXKDQKD/KAFmprKpfHm4
 2fe7cySqG70gGjd2aVOn2JANFHyDyW7eT3A9J/m6UM0wipRGwdTx/A9zLMKEJBm2FQbZ
 Qgzen5zwYCK7xubn+Zx712USrejAR48htglZ2QvstdJ0cuq2GJQXSTiOHOh5ZGx078AJ
 e9RdLA4GQsrIamUQVx0w5KRuWevJQDQQGUItL8G+kJazS5arxub6ltqvqiEnNrSqwxN8
 o3kQ==
X-Gm-Message-State: AFuF++mHMimdLa4b2K/vjK29+R2Ny6mTZHAu3mL/bFpAe0lmOm4a1obZ
 KtFWeIHGaR03rsObJVdsnfbRs2p392lSqKl1WqAoUwkAK5ZfW2YKbzCw5vTlvm49DUIPUZEWM+R
 DTSjUsSJYnvCzpN6HoPD6uOo17oAXzg3VYJ9L/mSDA7fQsPxdzYxpEeD7OuTJaxOp8w==
X-Gm-Gg: AR+sD11DJO/EsVKKrkQrkGAI/UPhs0rviElHO4qtSE48CFZTtAY5i46xNq4ZyApEXYv
 pQ+GTXnLmWAgOT2PljzVG8e6qQ6Z9IdsN9GwyGpQfBz92NU39lvNVt91NM9dRtmjG/EZyP3B7UX
 2KcQL3Ag17YJ8FFTyzhLLPGjXNKDFMvLZZmmeR00yBvmheHZHozq11JFuaTmgsE1grc+h+ikF5c
 rI6eV5uI2+jMEdA7WdzFdWrNeHF8PwkExCABzWJ8I5e7KEZu/lKhKkZ5dTks4qAt59rr+nRg28q
 XxR8e9HKgwujETgoDynNwsgTZSx3DncdG5huQWDKjxnnB48FQDjvLir5mPirgab/3AuAu0d+IKn
 E9HhkH6r6jdU0YDnOJZcD1N2gT2Vmmo6mTJ1FEKJN
X-Received: by 2002:a05:620a:371c:b0:937:6772:d8d with SMTP id
 af79cd13be357-93960f1811emr695433785a.20.1788362472228; 
 Wed, 02 Sep 2026 08:21:12 -0700 (PDT)
X-Received: by 2002:a05:620a:371c:b0:937:6772:d8d with SMTP id
 af79cd13be357-93960f1811emr695415885a.20.1788362471438; 
 Wed, 02 Sep 2026 08:21:11 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce58da3acsm127559305e9.0.2026.09.02.08.21.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Sep 2026 08:21:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 03/11] target/i386: Rename fake_do_interrupt to
 fake_user_exception
Date: Wed,  2 Sep 2026 17:20:34 +0200
Message-ID: <20260902152044.31291-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902152044.31291-1-philmd@oss.qualcomm.com>
References: <20260902152044.31291-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEzNSBTYWx0ZWRfX9jqgn/py7DKH
 q0Uy848X5YAOJoiu7EOvFO0+KaJwe2DUGq8ZiAo1FZg9dRyDoYXStoveixpJzvYxSLD/jIeTmme
 aTIg/17wQTHkiuB7Tl1/8u5txCRJ+T0=
X-Authority-Analysis: v=2.4 cv=G+ss1dk5 c=1 sm=1 tr=0 ts=6a983ee9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=QvbPrhRjooIPkqPMRvUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: ve7-lgHnRJQ3vsnRuWFJhWMAHt5OJw4K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEzNSBTYWx0ZWRfX9GplWtmmaUJd
 1fXEJjROmKyZgTx7QOX/rpWNRG+vGTkuTkFVuGYn2vjP4gYm6rMpEYIKQy4m4VWg+dG0Uo8SviT
 c++3W4TP5Wfaae/QWcyrMtow6mf5dIAns62ouQVpCXvctCL6rm0U2b2g45kKndJdyutGNG4nlZu
 NLxBIetoKf9IACUG8mKQzuH82wh41l8SwB7cAqkBjYvyrvPjCje6P9XDBMRgJx9sw0CHJmWAn0M
 kla7Mtt+KAs1YeppQm4CA+tIG0qkCF5FveSnvxgVxhWVCVtd3Sc5nwS6nRE+52rrNJcCLTgy56X
 L8Iu78L334gm6UM1feOz/QIuUvTft+NnOLGooTvyPc1sVEMQtwAK38PU4Oq57nbiqM6r658EfNE
 wv/LI9F4gDgpMkiUWKovztNyUbfwg9/17lMe3tpQ2gSI1FOMRWe3XAmqONPq1Tlq6aAOK95PgJ+
 IrS2QR0LWb9J0PCSyIA==
X-Proofpoint-ORIG-GUID: ve7-lgHnRJQ3vsnRuWFJhWMAHt5OJw4K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020135
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

The fake_user_exception hook handles exceptions in the outer
exception loop (cpu_handle_exception), not inner loop interrupts
(cpu_handle_interrupt). Rename to clarify the scope and intent.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/accel/tcg/cpu-ops.h       | 4 ++--
 target/i386/tcg/helper-tcg.h      | 4 +++-
 accel/tcg/cpu-exec.c              | 4 ++--
 target/i386/tcg/tcg-cpu.c         | 2 +-
 target/i386/tcg/user/seg_helper.c | 6 +++---
 5 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 3ff6e6810e0..ded7cc700df 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -106,12 +106,12 @@ struct TCGCPUOps {
 
 #ifdef CONFIG_USER_ONLY
     /**
-     * @fake_user_interrupt: Callback for 'fake exception' handling.
+     * @fake_user_exception: Callback for 'fake exception' handling.
      *
      * Simulate 'fake exception' which will be handled outside the
      * cpu execution loop (hack for x86 user mode).
      */
-    void (*fake_user_interrupt)(CPUState *cpu);
+    void (*fake_user_exception)(CPUState *cpu);
 
     /**
      * record_sigsegv:
diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index f4b2ff740d5..5349ab71be9 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -35,11 +35,13 @@
  * x86_cpu_do_interrupt:
  * @cpu: vCPU the interrupt is to be handled by.
  */
-void x86_cpu_do_interrupt(CPUState *cpu);
 #ifndef CONFIG_USER_ONLY
+void x86_cpu_do_interrupt(CPUState *cpu);
 bool x86_cpu_exec_halt(CPUState *cpu);
 bool x86_need_replay_interrupt(int interrupt_request);
 bool x86_cpu_exec_interrupt(CPUState *cpu, int int_req);
+#else
+void x86_cpu_fake_user_exception(CPUState *cs);
 #endif
 
 void breakpoint_handler(CPUState *cs);
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 257211235db..609931a0d6e 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -717,8 +717,8 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
      * handled outside the cpu execution loop.
      */
     const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
-    if (tcg_ops->fake_user_interrupt) {
-        tcg_ops->fake_user_interrupt(cpu);
+    if (tcg_ops->fake_user_exception) {
+        tcg_ops->fake_user_exception(cpu);
     }
     *ret = cpu->exception_index;
     cpu->exception_index = -1;
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 6f5dc06b3b9..7a4d73e7fee 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -173,7 +173,7 @@ const TCGCPUOps x86_tcg_ops = {
     .cpu_exec_enter = x86_cpu_exec_enter,
     .cpu_exec_exit = x86_cpu_exec_exit,
 #ifdef CONFIG_USER_ONLY
-    .fake_user_interrupt = x86_cpu_do_interrupt,
+    .fake_user_exception = x86_cpu_fake_user_exception,
     .record_sigsegv = x86_cpu_record_sigsegv,
     .record_sigbus = x86_cpu_record_sigbus,
 #else
diff --git a/target/i386/tcg/user/seg_helper.c b/target/i386/tcg/user/seg_helper.c
index 3a4a6d5a745..019a781458b 100644
--- a/target/i386/tcg/user/seg_helper.c
+++ b/target/i386/tcg/user/seg_helper.c
@@ -42,7 +42,7 @@ void helper_syscall(CPUX86State *env, int next_eip_addend)
  * instruction. It is only relevant if is_int is TRUE or if intno
  * is EXCP_SYSCALL.
  */
-static void do_interrupt_user(CPUX86State *env, int intno, int is_int,
+static void do_exception_user(CPUX86State *env, int intno, int is_int,
                               int error_code, target_ulong next_eip)
 {
     if (is_int) {
@@ -76,7 +76,7 @@ static void do_interrupt_user(CPUX86State *env, int intno, int is_int,
     }
 }
 
-void x86_cpu_do_interrupt(CPUState *cs)
+void x86_cpu_fake_user_exception(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
@@ -84,7 +84,7 @@ void x86_cpu_do_interrupt(CPUState *cs)
     /* if user mode only, we simulate a fake exception
        which will be handled outside the cpu execution
        loop */
-    do_interrupt_user(env, cs->exception_index,
+    do_exception_user(env, cs->exception_index,
                       env->exception_is_int,
                       env->error_code,
                       env->exception_next_eip);
-- 
2.53.0


