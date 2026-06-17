Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5AF3CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 17:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZtrf-0000Xy-6v; Wed, 17 Jun 2026 13:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZtr6-0000Iy-UK
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:15:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZtr4-0006pf-CU
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:15:11 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HFokNO3212085
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 17:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 shBZaHEVi8dZt+d608wg6Iz3OCSBoWL8lHFLUYL6pVo=; b=AhgRUW3HhpvujJPN
 tG3W+oPKKnjYKZfjGHAJ73Zkc28JSiloD9EpIRduo3O+MbP9i2DF1H9mobEiHRwB
 xgu6IbPtm0a4wIVmaSoYcnPYSBsRIOFmGcZvorjlOgMGY/h8A7aH8of6rykUcrPh
 GRN10pXaQWD5XLDQPN/PzZ5La1QM+XxO+i315NId3IGK+W094RiQ7FSKUqb2p8bl
 ljdvT3Tb5svPDyqcnyQ079UM9FxFAYdJYSqqTtnW36JMaDk2CZczGHmvf/vHkA0F
 zXLzZhsnooQWdVGLp6Rs5fcMeTO9j288ew0x33xozcasMWfjHmhvd37sgv0VxTee
 depOlQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueerck4t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 17:15:09 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-963d7e5ac77so2618141241.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 10:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781716509; x=1782321309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=shBZaHEVi8dZt+d608wg6Iz3OCSBoWL8lHFLUYL6pVo=;
 b=jbG7gq+xS7iBm1VaaogX2sXbzoYe/j3OPN1dfcLW4gU0iMfwKpw5+aCyevegakHrYT
 XU/0Pb/ASQL8kB/OAMeXmTQfUkuJjQu5DWrLiv4Fpzp7bOwqKiSyw7SUjg8qBdzA4jh9
 4ozt2PKhp5XIem5rvz3R++b3cb5K94HxdwlR5pWtF6ZlaCY1T7yHxCSX0bSklUl+HLnE
 VbasiKMxjL3BDCbohvnJ/2o0jzkEKzUUY+CWqYOMbAIAcREZOQFcIUIdtCpLOj0M+r/7
 6mGc15JGALiYukNypiY6hJeAo/QTztGVkWzgFRUZsmvA178ST7v+EZ7J0SGx9Mf4Taju
 4Q0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781716509; x=1782321309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=shBZaHEVi8dZt+d608wg6Iz3OCSBoWL8lHFLUYL6pVo=;
 b=dRWLexDe4QAbJIELn0G7+e7zX2qABWc/Cw9TSHC/GArAAyaZlHfiumagDsmLEpxtuh
 kfFFA61S5SQe3D+LMWxePtVT/PRffDSuPX47OOjom2Mj2VqEANvFllUv8lWzabrWtKRb
 dyffXLjwxJsCv0xuolyslhYwe1qqM7S5J5kfilgUXbYL7rwXYNbWOdn9scZ4EjQ347ha
 5X2YtMDYcyHBuDWd+1xqPJPZdDlSRWsFZHGDMwxyDkraoRdXyVehRJFSpujiO796IZjy
 5x8QXQEV5vO+zW/5oUfDBjfS3pLZ1dTs/qc5J/nZuxxylM7DsnrNXxn3VVLW15mA0p27
 pKqg==
X-Gm-Message-State: AOJu0YyjN4CF65mZ1r5fWPzt3UafvEM9QbsNtEWZPmXHTiw0Oik0YcYY
 do08eC91NuRqf/KTOi+aoEYIXOFjZsmN1yXJvK0RxZzeLVVPRwkHs0szw7E/vfF1ZU89/AuOUD5
 UKv02qoPlbHTeu3EpZUHedE1mmt03KfkMsJQ3OQscY32Oeel6ZtaOS0f/k3UWNPa+4Q==
X-Gm-Gg: AfdE7cnXnPgT7VeDN/RUcilzhWQJyil1neIoCf3szZ0f95A54CT9HJs4wskXM5y/mqd
 5cIZHDS6KQgy7/eZXAHqdU6+PrHrhfdAfn9dNNtjiQd2yN3QauuPlvbFTXz/npWljiePpqGoAug
 SK5rUESXjPRaMDTxZuZgzcKuvMcEQ7Eh+g4zKNksPPHjHQys3Hbb0vZB+SRTIOtr1m3zKAMk1Ts
 l5fVBUKfj55DWO1ZU/0MIJ/u1EZZ1zEEOI8+1VD0ITaHBdbqXDj4LbzC0zclaRjwyhNETUfshCR
 wg87bzvwKWnTis1VSu4E7wXSs1RxWdZ8icL/Tm1ZjyfvcRhXLnx//6OhuhdhydRu+HUI1iHtuEk
 FIww8FtKRUmAZs24DTGHEoAm3M+fZQ7OjN6onZWwr6roE2V432WLdUcCbdl/Gi3+1zsEc
X-Received: by 2002:a05:6102:947:b0:612:21f8:5afd with SMTP id
 ada2fe7eead31-7245da8b3edmr2811060137.12.1781716508683; 
 Wed, 17 Jun 2026 10:15:08 -0700 (PDT)
X-Received: by 2002:a05:6102:947:b0:612:21f8:5afd with SMTP id
 ada2fe7eead31-7245da8b3edmr2811026137.12.1781716508100; 
 Wed, 17 Jun 2026 10:15:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4631217027bsm4863350f8f.12.2026.06.17.10.15.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jun 2026 10:15:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 04/11] accel/tcg: Move cpu_exec() out of 'exec/cpu-common.h'
Date: Wed, 17 Jun 2026 19:14:31 +0200
Message-ID: <20260617171438.75914-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617171438.75914-1-philmd@oss.qualcomm.com>
References: <20260617171438.75914-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE2NiBTYWx0ZWRfX5QbY0KfqF6uR
 aEAzOaYkzOfr3tPMNjV9lOm3Qwtj+aZErFR1WIjM5IRLH43CSRcyCd3p/N/KX8/iDw4B7gvLiCm
 FzKZh5bqV+3WS7BRkEVGiqsBq3bf6N8=
X-Proofpoint-GUID: Ujggb6vQAUC-Utta9n8QqtC_EcfTsZRl
X-Authority-Analysis: v=2.4 cv=d4fFDxjE c=1 sm=1 tr=0 ts=6a32d61d cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=JBFRhVxWIrjttJGYeT4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=TD8TdBvy0hsOASGTdmB-:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE2NiBTYWx0ZWRfXxUO7TAXXJmJF
 Oesyc/jB0NPan45vEf7Es9ov+I60dyYuqP5TWasHRO4v4DT9HEmGXJd3Qt+EU1/YQdvDsGJYjHY
 fSTOZTKEZMnvYLfKrvgvKLTiA6JHdncbq2S9ryWeXNuG4QdK4Sa0fZTXiVtNuwz3JDEwyhPZeXX
 QkyuJkPedNb6KEpueaNVaIQ0i7O4jS7LTO+z7wnQhp1rPZtE4P5RKnfKDu8WozpwW8XNGbany5N
 cNMfds+qEzMUpAvy5MJfm0IwWem45TY3mMoBspRqqlbdz1aUJpILor2QKiXkopqEBqUL+bvzraF
 xXufMAsXUox73/shdH6CDk5DC0TadGgOW7vnQyvPQRd+9f8erXddtbZ+tf4859EAolFLQ7yZo2h
 pOca+2BcY2SgM81NXAymBQSrV7a8Oo57TXeFnzGjT6kaPv96re9hsb1Q41+3Kis31F5w9jkio3n
 KsqLswCIJtRJFOv8OpQ==
X-Proofpoint-ORIG-GUID: Ujggb6vQAUC-Utta9n8QqtC_EcfTsZRl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170166
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


