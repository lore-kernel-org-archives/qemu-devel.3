Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8875ACD98EE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZII-0000j1-3A; Tue, 16 Jun 2026 15:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZZIE-0000OP-IA
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:17:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZZIC-0004iX-Ny
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:17:50 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOohF303511
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 19:17:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /FrGaTt6kayuLx9k3LRHujapTadzTFWbY4tka7scFnA=; b=fQyZYZ3+FIujdDw2
 iImY6PYo5xefJ5s3Abuez93/n8oeJiQGhbDep2vzQq2kay3nj3sWk4qMfmTjkhlB
 SPuKElUZXKrGIRzp4ZdL7E8Zvlp7SWMT61D1qSCk5TXz9/Bi6Nlu5LPypmrfFwfy
 phSKmVceW5cZDKSfs3rcVQtcurUj+MTqEEaXTsTeVrEJ8mR2epN3UGiScbVJi9GK
 rPOCvLmXv7fcaBjFIbK2bd65Oyei7X1pxsqqbHEjHLnXtS2PTLyOCsLhiO7eKAsn
 8SsOFj+HZNyGj+B/yr1CY1gbw98ZqaQh24lUakII1mnmKTfNQbXfpy4XIvuxoznU
 B9d7mw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu1epbdc4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 19:17:47 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-915c8347cd5so970957985a.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781637467; x=1782242267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/FrGaTt6kayuLx9k3LRHujapTadzTFWbY4tka7scFnA=;
 b=F3DlzJj1q94SjXf52C/HSWQ1davhPUK04EmmX/qYEh9dt1Q3V3MY6Oa5UWv7Ifz5bj
 f03d3o+oJ5zb1I/z6A5MVWOM+v35O1mNo7rAZrjeUrR/pgaq3CunUT2piVOgqH/u6iP9
 Xlbc3HwLhbdUJNwFUltqrFu1MQqr1yReUyUC02QwKfs5/tM12n9JY0AnRdtcjpVz2gp7
 u3Ts+QRnbsVjs9A/imXr5ycIkwXezpUhcaqF8trWd08Pr3raItQjF6lNewlvySQP0AM2
 6Y+OmQzduLzxvuBPWXYMPNIpndSPDrqzTT79pXExDUT/VuTTSXwk6S7478faKf9e4iFu
 lfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781637467; x=1782242267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/FrGaTt6kayuLx9k3LRHujapTadzTFWbY4tka7scFnA=;
 b=ZsfMopgi4OE5FdyUaOOHi1te58NN66mK7KJQETMfIe6obkeG1uIjGKy1V7LVHdOFVX
 CDUhjIPU0fRkWly6vVufPmX+/jorIRNKRkyhbN6omIMmbqOf9zCPehaJ0jq154MEWKUg
 MYDEgEWRVmbERVTfg+V7R1z6n22EYTeorCj5CG6aw1WC0lxjJSF5BqrVW3kEcGmLNIWd
 TeSS+vamnMJQ7+3536t5VtGowXFJjh5Cytj/OfezrOJmoMP/jWzBmO4V83OWQx0e0PYM
 IP3Q35/XaAkHeBvD636PRfvMsJqtKG2+/vQpOuCfLiUHm1XIR+JXF1zQbH1T8YQxjX6s
 Db5g==
X-Gm-Message-State: AOJu0YxTYNoq4DUxPDZKjlaaWkaEqOFlaLwcLFTHUu4wfF/LsACq/sfG
 O4Ow5Xu2L9bu8d3J7WBFz4UoryNgAH3EMNtpvshFTM2Wfnt2rc9Jp8L1AqX08o5VFcyZhAjlYGR
 eS4ampLSfW1jAJGCphBIpIczmpEaLFIJ9Cr8tXEIteSMpQfoT3qnBlqkT3JZvFjl2Qg==
X-Gm-Gg: Acq92OGLRkw2/bVN6zXPpRpClhX55kGJTUgARybFnOTj6c6kpz0JZxT2DIPnkygz4dA
 4/G6tXbNB8KZKMtLD+3b79E6gaU1W6ItGxvT8q8jAM+oFN+LJIMpahQdEn0Ie1Mz9J2VPLJ7gzQ
 mzns7Se/fqsUxB3ROKGWIzQjIAtGr/50rwvmIIwKzT4dn3jFpNyjFGqiT11pRLHUi8N/u2IgHBf
 tQ1QVFi1atOOFZqtBAVVAF5xU3yhQiBwtA3aj5PGaZxGefkeLZgbGJeppLLo8U5wOP1ib0wfgqS
 sN26xEWxdChbdo2m8rO/S6nRqDcVQTPQ9F19eJUKA/edG8JsYYrmQSa6bF5e98DyOcrtfsT/8e/
 Q6Tr7kBGD0bePIJ58zP5tCSSZafHbfxDcFfcTWdqVz266IX/Gk4hKAS+1IdyfCBgEtDykFu3MA/
 /Us1g=
X-Received: by 2002:a05:620a:29d5:b0:915:bf79:3e0a with SMTP id
 af79cd13be357-91d8ccb259dmr177018185a.26.1781637466886; 
 Tue, 16 Jun 2026 12:17:46 -0700 (PDT)
X-Received: by 2002:a05:620a:29d5:b0:915:bf79:3e0a with SMTP id
 af79cd13be357-91d8ccb259dmr177011785a.26.1781637466429; 
 Tue, 16 Jun 2026 12:17:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa97a07sm167857455e9.14.2026.06.16.12.17.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jun 2026 12:17:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 04/10] accel/tcg: Move cpu_exec() out of 'exec/cpu-common.h'
Date: Tue, 16 Jun 2026 21:17:10 +0200
Message-ID: <20260616191716.12932-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616191716.12932-1-philmd@oss.qualcomm.com>
References: <20260616191716.12932-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=I/ZVgtgg c=1 sm=1 tr=0 ts=6a31a15b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=JBFRhVxWIrjttJGYeT4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5NiBTYWx0ZWRfX5vzGZeBifLuy
 FHp6mPEzcni+49sxcjBFopRGHhpbt9j2cFtnxQ9Az5jl+JSikRGh4qEhUg8wAUmfKox4rlElgPX
 aKqjZCvlCi/J9JhWhQKOHUv10H9y5sg=
X-Proofpoint-ORIG-GUID: J_br4pYj2yfKsc9bUOugA_8DZkCni29T
X-Proofpoint-GUID: J_br4pYj2yfKsc9bUOugA_8DZkCni29T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5NiBTYWx0ZWRfX1rR1uYVvXMVv
 w+wKDQqQZ2ceDNc9fc+gT0471TfBYJwAQ5Mbio9Rs6bbLBOFnuvPXtbrKD7TyrHhb90pD4IuBb3
 wTgUq2z1euPlYpun2H/L4uRW2J4vgMyZYQRQ2V3XJnCQLD9xRyxlXZ+RqnBUrSbXph4ngPHKT1g
 KBmaN0CI9WJDXUUtdXuyQ9gun3mGZf2NtoDXfxRXL3so0orXHzsbYlNGvC6BRbtEBvTSym+7fbV
 ywDJO+SlrSe/7FDyRLqP5EmZyhYjN4eD90eQRuisZhDfP0h7q3d0NXlFC6ZJ+umX4qdpM7+nHyq
 o2AT8ck4Qa18nzMABELK3QUQb2/eyGtXXwpwimxfD6GvUXUNuAZWrc+sXS2TMp9/ZqQDuZ3bHb/
 YU2O2vy8owU8783/Bf15OnjsYeGnAWUuVc/71ivfWN52NU0izxk7klqb1SgLxiAMYwQxcAJKmLx
 VFXkHmwOhEwHq55FyqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160196
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

In order to keep TCG-specific functions under a TCG
API namespace, add the "accel/tcg/cpu-loop.h" header
and move cpu_exec() declaration to it. Add a bit of
documentation.

Include "accel/tcg/cpu-loop.h" where appropriate.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 bsd-user/freebsd/os-proc.h   |  1 +
 include/accel/tcg/cpu-loop.h | 16 ++++++++++++++++
 include/exec/cpu-common.h    |  3 ---
 include/user/cpu_loop.h      |  2 +-
 accel/tcg/cpu-exec.c         |  1 +
 accel/tcg/tcg-accel-ops.c    |  1 +
 bsd-user/main.c              |  1 +
 7 files changed, 21 insertions(+), 4 deletions(-)
 create mode 100644 include/accel/tcg/cpu-loop.h

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index 72ccf23e17e..1cf3c43de34 100644
--- a/bsd-user/freebsd/os-proc.h
+++ b/bsd-user/freebsd/os-proc.h
@@ -14,6 +14,7 @@
 #include <sys/procdesc.h>
 #include <sys/wait.h>
 
+#include "accel/tcg/cpu-loop.h"
 #include "target_arch_cpu.h"
 
 pid_t safe_wait4(pid_t wpid, int *status, int options, struct rusage *rusage);
diff --git a/include/accel/tcg/cpu-loop.h b/include/accel/tcg/cpu-loop.h
new file mode 100644
index 00000000000..528adb5588c
--- /dev/null
+++ b/include/accel/tcg/cpu-loop.h
@@ -0,0 +1,16 @@
+#ifndef ACCEL_TCG_CPU_LOOP_COMMON_H
+#define ACCEL_TCG_CPU_LOOP_COMMON_H
+
+#ifndef CONFIG_TCG
+#error Can only include this header with TCG
+#endif
+
+/**
+ * cpu_exec:
+ * @cpu: the cpu context
+ *
+ * Returns one of the EXCP_* definitions (see "exec/cpu-common.h").
+ */
+int cpu_exec(CPUState *cpu);
+
+#endif
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 883389b0abf..ac3ab0e1cdf 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -114,9 +114,6 @@ G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc);
 #endif /* CONFIG_TCG */
 G_NORETURN void cpu_loop_exit(CPUState *cpu);
 
-/* accel/tcg/cpu-exec.c */
-int cpu_exec(CPUState *cpu);
-
 /**
  * env_archcpu(env)
  * @env: The architecture environment
diff --git a/include/user/cpu_loop.h b/include/user/cpu_loop.h
index 346e37ede8b..c9d49398f01 100644
--- a/include/user/cpu_loop.h
+++ b/include/user/cpu_loop.h
@@ -22,7 +22,7 @@
 
 #include "exec/vaddr.h"
 #include "exec/mmu-access-type.h"
-
+#include "accel/tcg/cpu-loop.h"
 
 /**
  * adjust_signal_pc:
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 7292ff15060..9c754b03656 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -22,6 +22,7 @@
 #include "qapi/error.h"
 #include "qapi/type-helpers.h"
 #include "hw/core/cpu.h"
+#include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/cpu-ops.h"
 #include "accel/tcg/helper-retaddr.h"
 #include "trace.h"
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 3bd98005042..c179cd4adeb 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -28,6 +28,7 @@
 #include "qemu/osdep.h"
 #include "accel/accel-ops.h"
 #include "accel/accel-cpu-ops.h"
+#include "accel/tcg/cpu-loop.h"
 #include "system/tcg.h"
 #include "system/replay.h"
 #include "exec/icount.h"
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 73aae8c3274..4f1544342eb 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -39,6 +39,7 @@
 #include "user/guest-base.h"
 #include "user/page-protection.h"
 #include "accel/accel-ops.h"
+#include "accel/tcg/cpu-loop.h"
 #include "tcg/startup.h"
 #include "qemu/timer.h"
 #include "qemu/envlist.h"
-- 
2.53.0


