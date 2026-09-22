Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F4D2C98308
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 16:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x93lF-0000bT-HU; Tue, 22 Sep 2026 12:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x93ia-0004xL-5H
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 12:51:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x93iY-0002cv-LP
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 12:51:43 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MEjdSs898320
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 16:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NMMUYlRFOEu4Y+0NjhX8Ge/q9RoTfSWrF7SafoChtWc=; b=a9sDnEEWrb/dnNAd
 Snn8Ix/BsRS1Fn5Mq6hUVkHaQZ8kkozC9WFbv/hEJ1aiA8wndlfwN2CvaYDF0Sjm
 i8gEpmzUI99SeHccSOdZ+NUJzUGRUtC+569up8XbLQNET1nadDL8qtQ/l8N/BsDR
 Fi/vn6999YoD/EKcpjL/GY+6mumthjgZPm0rH1H1QMl6JPyHXWgvmItww5v9EhY+
 /2IOBKvKUimP/MOlOqNZUsfGKm/+88/107Ld4pOz4vgiPkcbtPgs825EAhGipeAy
 K3L4HbXW/62mmUiTAEzCftxcnB79DTbe0TViWaN6PLDdzp4CqyxqoNcOUHV/UGj1
 ChIq8Q==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gueybkw01-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 16:51:31 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7a532e31dadso2450137.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 09:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790095891; x=1790700691; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NMMUYlRFOEu4Y+0NjhX8Ge/q9RoTfSWrF7SafoChtWc=;
 b=Znx+ShXCwf4t91rd/q2QJw68c4I8nc+6HP5PtIi5RdnPwZriz8WFsQYDqpDPehsxDA
 b6B4z5z3dbFO9bfEh2l4on1r8ypkYPam+Q6Q5rgntVFcdzWZ+/SG/jPMB1l0IUR+iXKR
 uvnQNDbhzeQMRSl982CUFdKOL34GZghIReOCsg2215VkorUJoarY6elwMs+7iej9UGds
 /bqv9o/aTh2bLtM+bVdlq8XJvbUwlG+WGdO9+hJR7JylQrWCgBLowGMCx5eZ6EgE4rAJ
 AC9TCfYpj/eulypvCOmSJLh43TbKhBvIFqS9OoksJ6QyRwjLKW65siubFkjg3tFh+I5A
 l3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790095891; x=1790700691;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NMMUYlRFOEu4Y+0NjhX8Ge/q9RoTfSWrF7SafoChtWc=;
 b=Mu0dHW8Y/Tg9x62X17OxzL5e1RxBC6bKAigHGcAQEo/Ep7ruj8QY4HOgFGCww31o7n
 kgQ1WJdI1tqktSZY+WDQeXhqg1tWXCVeuhefT9kIdwUphFPNqo26rHZKH4mZyReY1ZSV
 1Al+M5WDje55FzaWzzlmhVx/fymzs6JG9fyW90h2B1XL0MrYwlP+0OGED0RcpaG7lrkC
 /CzcJGqiwH1LSpKZfquHqSFvyqZDfDoIOnXaHaPZwb0kLLvJS39UyysikSam4CoKzN0l
 qEpNi71yC/kZA/nBy1tPSzYHUxm4YztiU2GSERSZGRmOoyGZkLaNAhzX9kokfLRIrUIh
 lGiA==
X-Gm-Message-State: AFuF++la9riipQSGTCjjeIgI+tegPN47kfkxLcCKiJuxlWm5+NbMZJyH
 zawlcP0L7JYUI7W7vHXTWkaf3tdkRvqnEoEbGMN4vHSlGtroheg/Y7VdGu66t82+/wK/V8vnPDQ
 BlbYFGrummMg6KYta+lyj6rcusfDPQSp0BI9xfGOeFuIajdCernFiJjAuBpR9sRxxlg==
X-Gm-Gg: AYBFou2LTH1CANTAHxijFrsPVOrlQ2whRQnJ5K2xTScsWqoEGjTdPv0xkYSjS1hh8qM
 mdmp6Nwy6td4RYWF2s10/heijld5Ai7VFApnuvjEC03x0qXjswaVvBojul3nZZvFJify8XQkdT5
 MyKEEhBaCrLiQOibKJuuS04YMBIPlq4KZVYZnUX83ERPn4xNT7V0oTmlUgcOuedzEEfntwQiUHo
 bBGmdMos2pYZMcBPG26g5DWMxfaCETB99Dw8KsedYdbHjDlDgnjvMcTSfHWCNNIYH1B2eHyviQO
 ETCvu52vhESZzOYxLo2n+9DjvC+nJf2zxFInEWOOjPhcY913raOyEpZuXILxn8s3/8dhoWvP8Nv
 gMIPVsji49/RcPYQTtOoNvhR1s32Qksj8pQBRH4K/
X-Received: by 2002:a05:6102:6a83:b0:7a1:f7e2:aae3 with SMTP id
 ada2fe7eead31-7a55ca7b59bmr9262528137.21.1790095890841; 
 Tue, 22 Sep 2026 09:51:30 -0700 (PDT)
X-Received: by 2002:a05:6102:6a83:b0:7a1:f7e2:aae3 with SMTP id
 ada2fe7eead31-7a55ca7b59bmr9262501137.21.1790095890377; 
 Tue, 22 Sep 2026 09:51:30 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fde17dab9sm5197455e9.2.2026.09.22.09.51.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Sep 2026 09:51:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 15/17] target/i386: Split leaving-halt handling from
 x86_cpu_exec_halt()
Date: Tue, 22 Sep 2026 18:49:33 +0200
Message-ID: <20260922164936.15189-16-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922164936.15189-1-philmd@oss.qualcomm.com>
References: <20260922164936.15189-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bP6Ds/+Z c=1 sm=1 tr=0 ts=6ab2b213 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=GiXQl85om2WzCxkx9rAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: g3UXi4l9BbB0c8D7BLxdwFOsra1MecpS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI0NiBTYWx0ZWRfX/dQHLBTQ+nJP
 98BPvLFXAXH+XXe++hX/lJVi/5W69JhsEVm4lpLdrsrGQ9D7vAnt8m5ue7DVgleAOngj3yk6PQl
 UApy/zhprSrjeVmKIs9Ja9DJS8xIPgh5T13bDA8aH323BNG43HLn2HDi4S/vxIQl2i8m786jP4X
 797fcrY1Fiw4tPTKoYsstXU9gFZR5yqzbWRojemPeOrPNHUEZnc8uZHuLBWkiVGukQ9IerP4QgL
 cQ07+a40a/PzAIYugPqPYgINegtJbl8uG3YTXvRvDrTZGPLc4RPfbcQKW5seGPB5ZBjooxcBDnB
 fgtsPWYNVYHct2WZOdoTrQBqhSQgdRUFLNNYzT2JfWBdlI2InpT/E/JlRb0AucmrpXbf0sl01j5
 VLcxi5qwKTjL8QuXKqWWHkTfRUHvf+sxWedm63bR9B6os2LbnW275PFpKVp2jLSTfMfBn2rOtwy
 BV4FGYEIMmZsT3eaFyw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI0NiBTYWx0ZWRfX0uytNJY5BXc2
 1iYqMOK7+ZElifpYmT5QYYmU5T0DLhqcxBncLcK1FZG8rsji67GPvIdYdRywKJWLn0FEvLPhgtN
 AAWm67+PElL+Y2PGOZlscaoi9eJS+Hg=
X-Proofpoint-GUID: g3UXi4l9BbB0c8D7BLxdwFOsra1MecpS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
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

Move debug exception handling performed when leaving HLT into
x86_cpu_leaving_halt(). Keep x86_cpu_exec_halt() responsible
for checking whether the CPU can resume.

Document that #DB IRQ delivery through do_interrupt_all() runs
in the vCPU thread and does not require BQL protection.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/helper-tcg.h        |  1 +
 target/i386/tcg/system/seg_helper.c | 25 +++++++++++++++++--------
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index 58e8ca0bc1b..96accb30a80 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -39,6 +39,7 @@ void x86_cpu_do_interrupt(CPUState *cpu);
 #ifndef CONFIG_USER_ONLY
 void x86_cpu_poll_during_halt(CPUState *cpu);
 bool x86_cpu_exec_halt(CPUState *cpu);
+void x86_cpu_leaving_halt(CPUState *cpu);
 bool x86_need_replay_interrupt(int interrupt_request);
 bool x86_cpu_exec_interrupt(CPUState *cpu, int int_req);
 #endif
diff --git a/target/i386/tcg/system/seg_helper.c b/target/i386/tcg/system/seg_helper.c
index 9ce608a0bb7..566b3d4d80c 100644
--- a/target/i386/tcg/system/seg_helper.c
+++ b/target/i386/tcg/system/seg_helper.c
@@ -140,22 +140,31 @@ void x86_cpu_poll_during_halt(CPUState *cpu)
     }
 }
 
-bool x86_cpu_exec_halt(CPUState *cpu)
+void x86_cpu_leaving_halt(CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86_cpu->env;
-
-    x86_cpu_poll_during_halt(cpu);
-
-    if (!cpu_has_work(cpu)) {
-        return false;
-    }
+    CPUX86State *env = cpu_env(cpu);
 
     /* Complete HLT instruction.  */
     if (env->eflags & TF_MASK) {
         env->dr[6] |= DR6_BS;
+        /*
+         * do_interrupt_all() is the normal TCG exception-delivery path
+         * and runs in the same vCPU thread context, so #DB delivery does
+         * not require BQL protection here.
+         */
         do_interrupt_all(x86_cpu, EXCP01_DB, 0, 0, env->eip, 0);
     }
+}
+
+bool x86_cpu_exec_halt(CPUState *cpu)
+{
+    if (!cpu_has_work(cpu)) {
+        return false;
+    }
+
+    x86_cpu_leaving_halt(cpu);
+
     return true;
 }
 
-- 
2.53.0


