Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16101C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1mnQ-0005xX-6y; Wed, 02 Sep 2026 11:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1mnO-0005uc-JG
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 11:22:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1mnL-0000ST-DZ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 11:22:38 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682CR2Xi1549590
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 15:22:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KXT2HoT9XOUG9FUuZMd1l0BLthY+lhHbpK91MW/9FJA=; b=O0ydlC3zDIFT0N8R
 j6iOADnr9d2ynI5Hg5Dbha2fnqHfn+5SWKA2bcUqO4B1K6lqHnHEXBEUZBZnzjCA
 FK0DMnAUEvVjSSfwkTwkug85TsCjPbRf5SLeD65FUW89SEp6q19D/U14dXRH4XEM
 0XRNEVdUgI2pVKuY2bXl2IFP5fmTtysQ+cCKZ5vH5aFraOksd+QZcPkr/l3bdXyd
 430/YleCwWYSgh6SX3UTAjW5EVy8JtlHacalzygdGiIZX1mOisOlfzFAGvxtJrsf
 QqlYrEWI6fBIOtEoBTR7T8IVeLPN3xymniVpwX5Q0FaOX3f9Ah7DI3d+SZRjb8w4
 eW8NYw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gej2c9541-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 15:22:23 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-97e8be2221eso85909241.2
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 08:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788362543; x=1788967343; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KXT2HoT9XOUG9FUuZMd1l0BLthY+lhHbpK91MW/9FJA=;
 b=VlOxHXKY69YyYO5FgSxp89rTu7dlvpzCTHpuc9Axv5g7qDWKYIVqnaXBlLEF3myapE
 EbFVSwLhWJs3kE+Q9FsM/JvvapRfN/Gt238JFtCfUss9k4hn1XrZHXKXN7UJ1YtMu6Yz
 PANeSaFAGKRB69wYTqNtjsuDyRx7MxCQq0XsZQkCykpo6idsHaGEmZ/RIqPZ0pe2h2oN
 TU1SgvYYy7L6UiqTNKJGDz8p349GSXD/J0runEBEDJNDYalk2iw33N+/J1GbRb/oXIXE
 S3NkxYWzsM+lGyHUbX5Yyi9BDMnY7yqnzmSnEpn/Z0llt8xVf12OJLB6CsEp9W6iYVQA
 7KeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788362543; x=1788967343;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KXT2HoT9XOUG9FUuZMd1l0BLthY+lhHbpK91MW/9FJA=;
 b=kEKl7bTFshQwQ9FRt8fyAi4NI3bOmVqfuYnvlbpR+e7gqSkCSGkgoBP2IlkwXuHbDd
 RH1OGusCyy3vIvHKJqEjSHD6ErkCSUgK++vIKHC+JOqbu0FV3pSpCMTJOoJtwvapqqD8
 fxg5BS/3zGjsnICyG4uLdEx6LOwVu3+DMNPFYYsp+zRFrNoGyhmncFetFmZmIzMWCMJb
 3kW58ZFY5TcIKnzj+KJtJF743MrTPn8/UtcYeE9q30GyiN3tPTeS/9a8RUg4EmymPpgH
 UeIaYTbbwWM/nJwmtewy+gwzNmqHTS/WAWbaPYSU/xsVel8PcPCPj6IdbAGUePS7aKKl
 2ERw==
X-Gm-Message-State: AFuF++k7DWVWNBAWlN0rTRkKRtC5c3/1J0VPrFS0i+fTOF5pV9EbXM1W
 82Ik+xnyK8idTBczBFoGj7v5m5XgYiQtfNXYjppKLMT/vAEh+lRzTTTzo6+iblxZD6ECMz3FO1v
 4r9Fu1+WdU1bkw03Rd4UZs34ifJlzKSkbdQsb3uYEY99C1ncIzqN9c6bhp0vb9jgZhQ==
X-Gm-Gg: AYBFou2KdlDD9zqkeE9T5ATIf2B6sndgeBvbHBz16izLbcnIcR2UO1UF9ViXZfbLH9Q
 M5xhHNIfAYaVRdUatL4giPM+ggZE3AayVDGKzso2RBfSfU/QX4K+zxQUBZ6vSoAxIIL9jNmsQf4
 lfCpiRHMx5S1szTuPSA+9Wz5dMKjFOx4vFzxiTQWbefnDXyUVFRLsr6Alr1hqQCGO8PP0MvhlN0
 kf4HoeMNjnCcmR6UozMpD3PJ4LnBYFJrE02Rv+Pw/DhY+XOR4V6XM1zTkZB7wkrRFBq+ug1NA+U
 aB7MpnhmzUCIJv5sltX3bAncM5gtT9oJARHzeOWLlt5Kze8bpWvu6LsZr1+lGGgd2Yj9HxLLW9/
 cf3W8M34h6PCWiTrOLOBXlOZ24Y0V1OOn1uTekezn
X-Received: by 2002:a05:6102:14a5:b0:784:94dd:5389 with SMTP id
 ada2fe7eead31-78a1f3954bfmr1682906137.13.1788362532152; 
 Wed, 02 Sep 2026 08:22:12 -0700 (PDT)
X-Received: by 2002:a05:6102:14a5:b0:784:94dd:5389 with SMTP id
 ada2fe7eead31-78a1f3954bfmr1682618137.13.1788362525679; 
 Wed, 02 Sep 2026 08:22:05 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce7d04c69sm42533125e9.8.2026.09.02.08.22.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Sep 2026 08:22:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [RFC PATCH v3 10/11] targets: Move BQL locking into do_interrupt()
 handlers
Date: Wed,  2 Sep 2026 17:20:41 +0200
Message-ID: <20260902152044.31291-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902152044.31291-1-philmd@oss.qualcomm.com>
References: <20260902152044.31291-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEzNiBTYWx0ZWRfXwMciV1UGbkhG
 7eC3ZLGSBUbCnIetQvJCgjGKd5AAYH7PLBfYD/3DMRkm4en3/S1FxGyvWA+3QayPsQSDd8S3MQD
 3TOdr+/wt1duWqC4Cpjgw9WqPF8NqBg=
X-Authority-Analysis: v=2.4 cv=G+ss1dk5 c=1 sm=1 tr=0 ts=6a983f30 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=u4KzQEefR3bvkf7lQMoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: zbEBzS9V4siG8gk737yGszMtHSGpDkiI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEzNiBTYWx0ZWRfX/OYDsyWEx5he
 1F2g4uqTmRmg+eUDXhXbOo9UQbdgQOv10lKF/I+s99tsqLGo4dW95GlwepRBemEhxJnxhFiiC9I
 ADyO1MJhFb9/NPgJgBt9ambFD4Vh/yVFYbK6039sU+bhLFrRGbchLnCNbK3YaZpRbSPFfSUpq3i
 295b3E8mZ4JxwB+OnPxYgT+hPvNFsFz9uIFEMAEOVpT7+u3ujY7IwoC+3ZSt7LrapvPbK7T3fhS
 yJ7whzJWjc646PaNLsOaf+unukU32vRzmBzEfm6phBMtsok+kjQr20iZZ9IALdRXpcvSNEfWw3x
 kl1sGyzNFl/VaUgGNNR4zFAFodxVDtP+1WuzmRfe+M90Xz32W/+H0SXZrgbT/2j4L6gi99b655K
 IEor9YRE841zX5ES0lPUfysOaG29Db7iCyRhmn4wSM1QhF2epzOiMyT4iD/Oz2TKZaAi0g52xEb
 QjoKj4zvyAPqz+IKuug==
X-Proofpoint-ORIG-GUID: zbEBzS9V4siG8gk737yGszMtHSGpDkiI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020136
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

Migrate 13 targets to acquire the BQL explicitly within their
do_interrupt() implementations instead of relying on the TCG core
to hold it. This allows per-target control over locking granularity
and paves the way for fine-grained BQL optimization.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/alpha/cpu.c                  | 2 +-
 target/alpha/helper.c               | 3 +++
 target/arm/cpu.c                    | 2 +-
 target/arm/helper.c                 | 1 +
 target/arm/tcg/cpu-v7m.c            | 2 +-
 target/arm/tcg/m_helper.c           | 2 ++
 target/avr/cpu.c                    | 2 +-
 target/avr/helper.c                 | 3 +++
 target/hppa/cpu.c                   | 2 +-
 target/hppa/int_helper.c            | 2 ++
 target/i386/tcg/system/seg_helper.c | 2 ++
 target/i386/tcg/tcg-cpu.c           | 2 +-
 target/mips/cpu.c                   | 2 +-
 target/mips/tcg/system/tlb_helper.c | 3 +++
 target/ppc/cpu_init.c               | 2 +-
 target/ppc/excp_helper.c            | 2 ++
 target/riscv/tcg/tcg-cpu.c          | 2 +-
 target/rx/cpu.c                     | 2 +-
 target/rx/helper.c                  | 3 +++
 target/s390x/cpu.c                  | 2 +-
 target/s390x/tcg/excp_helper.c      | 3 +++
 target/sh4/cpu.c                    | 2 +-
 target/sh4/helper.c                 | 3 +++
 target/sparc/cpu.c                  | 2 +-
 target/sparc/int32_helper.c         | 2 ++
 target/sparc/int64_helper.c         | 2 ++
 target/xtensa/cpu.c                 | 2 +-
 target/xtensa/exc_helper.c          | 2 ++
 28 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index aca9e82bfb2..12e86021663 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -267,7 +267,7 @@ static const TCGCPUOps alpha_tcg_ops = {
     .cpu_exec_interrupt = alpha_cpu_exec_interrupt,
     .cpu_exec_halt = alpha_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-    .do_interrupt_locked = alpha_cpu_do_interrupt,
+    .do_interrupt = alpha_cpu_do_interrupt,
     .do_transaction_failed = alpha_cpu_do_transaction_failed,
     .do_unaligned_access = alpha_cpu_do_unaligned_access,
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index c3614ecafda..e21cd8e2b44 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -26,6 +26,7 @@
 #include "fpu/softfloat-types.h"
 #include "fpu/softfloat-helpers.h"
 #include "exec/helper-proto.h"
+#include "qemu/main-loop.h"
 #include "qemu/qemu-print.h"
 #include "system/memory.h"
 #include "accel/tcg/cpu-loop.h"
@@ -341,6 +342,8 @@ void alpha_cpu_do_interrupt(CPUState *cs)
     int i = cs->exception_index;
     uint64_t last_pc = env->pc;
 
+    BQL_LOCK_GUARD();
+
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         static int count;
         const char *name = "<unknown>";
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 0d0555b7ad4..77aa78f00e2 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2606,7 +2606,7 @@ static const TCGCPUOps arm_tcg_ops = {
     .cpu_exec_interrupt = arm_cpu_exec_interrupt,
     .cpu_exec_halt = arm_cpu_exec_halt,
     .cpu_exec_reset = cpu_reset,
-    .do_interrupt_locked = arm_cpu_do_interrupt,
+    .do_interrupt = arm_cpu_do_interrupt,
     .do_transaction_failed = arm_cpu_do_transaction_failed,
     .do_unaligned_access = arm_cpu_do_unaligned_access,
     .adjust_watchpoint_address = arm_adjust_watchpoint_address,
diff --git a/target/arm/helper.c b/target/arm/helper.c
index c3f607e6d6b..fbedb3fa39c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9714,6 +9714,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
     uint64_t last_pc = cs->cc->get_pc(cs);
 
     assert(!arm_feature(env, ARM_FEATURE_M));
+    BQL_LOCK_GUARD();
 
     arm_log_exception(cs);
     qemu_log_mask(CPU_LOG_INT, "...from EL%d to EL%d\n", arm_current_el(env),
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 1f698b70283..502998dbd1c 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -304,7 +304,7 @@ static const TCGCPUOps arm_v7m_tcg_ops = {
     .cpu_exec_interrupt = arm_v7m_cpu_exec_interrupt,
     .cpu_exec_halt = arm_cpu_exec_halt,
     .cpu_exec_reset = cpu_reset,
-    .do_interrupt_locked = arm_v7m_cpu_do_interrupt,
+    .do_interrupt = arm_v7m_cpu_do_interrupt,
     .do_transaction_failed = arm_cpu_do_transaction_failed,
     .do_unaligned_access = arm_cpu_do_unaligned_access,
     .adjust_watchpoint_address = arm_adjust_watchpoint_address,
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 33c9e7c55bc..9e15781f08d 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -2214,6 +2214,8 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
     bool ignore_stackfaults;
     uint64_t last_pc = env->regs[15];
 
+    BQL_LOCK_GUARD();
+
     arm_log_exception(cs);
 
     /*
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index bc7639031b8..f8409f32ab9 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -249,7 +249,7 @@ static const TCGCPUOps avr_tcg_ops = {
     .cpu_exec_halt = avr_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .tlb_fill = avr_cpu_tlb_fill,
-    .do_interrupt_locked = avr_cpu_do_interrupt,
+    .do_interrupt = avr_cpu_do_interrupt,
     /*
      * TODO: code and data wrapping are different, but for the most part
      * AVR only references bytes or aligned code fetches.  But we use
diff --git a/target/avr/helper.c b/target/avr/helper.c
index f452c9d9040..ed839b6db31 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "accel/tcg/cpu-ops.h"
 #include "accel/tcg/cpu-loop.h"
@@ -89,6 +90,8 @@ void avr_cpu_do_interrupt(CPUState *cs)
         vector = ctz64(env->intsrc) + 1;
     }
 
+    BQL_LOCK_GUARD();
+
     if (avr_feature(env, AVR_FEATURE_3_BYTE_PC)) {
         do_stb(env, env->sp--, ret, 0);
         do_stb(env, env->sp--, ret >> 8, 0);
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index c6d915d314f..07b49e51326 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -272,7 +272,7 @@ static const TCGCPUOps hppa_tcg_ops = {
     .cpu_exec_interrupt = hppa_cpu_exec_interrupt,
     .cpu_exec_halt = hppa_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-    .do_interrupt_locked = hppa_cpu_do_interrupt,
+    .do_interrupt = hppa_cpu_do_interrupt,
     .do_unaligned_access = hppa_cpu_do_unaligned_access,
     .do_transaction_failed = hppa_cpu_do_transaction_failed,
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 3e87b9a0011..852d0649d84 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -98,6 +98,8 @@ void hppa_cpu_do_interrupt(CPUState *cs)
     uint64_t old_psw, old_gva_offset_mask;
     uint64_t last_pc = cs->cc->get_pc(cs);
 
+    BQL_LOCK_GUARD();
+
     /* As documented in pa2.0 -- interruption handling.  */
     /* step 1 */
     env->cr[CR_IPSW] = old_psw = cpu_hppa_get_psw(env);
diff --git a/target/i386/tcg/system/seg_helper.c b/target/i386/tcg/system/seg_helper.c
index 8c7856be81e..8eaeb746128 100644
--- a/target/i386/tcg/system/seg_helper.c
+++ b/target/i386/tcg/system/seg_helper.c
@@ -115,6 +115,8 @@ void x86_cpu_do_interrupt(CPUState *cs)
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
 
+    BQL_LOCK_GUARD();
+
     if (cs->exception_index == EXCP_VMEXIT) {
         assert(env->old_exception == -1);
         do_vmexit(env);
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index ff65641654d..7a4d73e7fee 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -179,7 +179,7 @@ const TCGCPUOps x86_tcg_ops = {
 #else
     .tlb_fill = x86_cpu_tlb_fill,
     .pointer_wrap = x86_pointer_wrap,
-    .do_interrupt_locked = x86_cpu_do_interrupt,
+    .do_interrupt = x86_cpu_do_interrupt,
     .cpu_exec_halt = x86_cpu_exec_halt,
     .cpu_exec_interrupt = x86_cpu_exec_interrupt,
     .cpu_exec_reset = x86_cpu_exec_reset,
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 073e466b713..0fead20d651 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -718,7 +718,7 @@ static const TCGCPUOps mips_tcg_ops = {
     .cpu_exec_interrupt = mips_cpu_exec_interrupt,
     .cpu_exec_halt = mips_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-    .do_interrupt_locked = mips_cpu_do_interrupt,
+    .do_interrupt = mips_cpu_do_interrupt,
     .do_transaction_failed = mips_cpu_do_transaction_failed,
     .do_unaligned_access = mips_cpu_do_unaligned_access,
     .io_recompile_replay_branch = mips_io_recompile_replay_branch,
diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
index 4398c6f80b4..2b8478f9a9d 100644
--- a/target/mips/tcg/system/tlb_helper.c
+++ b/target/mips/tcg/system/tlb_helper.c
@@ -18,6 +18,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
+#include "qemu/main-loop.h"
 #include "qemu/plugin.h"
 
 #include "cpu.h"
@@ -1045,6 +1046,8 @@ void mips_cpu_do_interrupt(CPUState *cs)
     int cause = -1;
     uint64_t last_pc = env->active_tc.PC;
 
+    BQL_LOCK_GUARD();
+
     if (qemu_loglevel_mask(CPU_LOG_INT)
         && cs->exception_index != EXCP_EXT_INTERRUPT) {
         qemu_log("%s enter: PC " TARGET_FMT_lx " EPC " TARGET_FMT_lx
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 2676562b2f1..6c626843c93 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7498,7 +7498,7 @@ static const TCGCPUOps ppc_tcg_ops = {
   .cpu_exec_interrupt = ppc_cpu_exec_interrupt,
   .cpu_exec_halt = ppc_cpu_has_work,
   .cpu_exec_reset = cpu_reset,
-  .do_interrupt_locked = ppc_cpu_do_interrupt,
+  .do_interrupt = ppc_cpu_do_interrupt,
   .cpu_exec_enter = ppc_cpu_exec_enter,
   .cpu_exec_exit = ppc_cpu_exec_exit,
   .do_unaligned_access = ppc_cpu_do_unaligned_access,
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 6d05b865058..6352a4fcaf3 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1761,6 +1761,8 @@ void ppc_cpu_do_interrupt(CPUState *cs)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
 
+    BQL_LOCK_GUARD();
+
     powerpc_excp(cpu, cs->exception_index);
 }
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index ea3189ab3d2..9e3cc87f8a3 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -289,7 +289,7 @@ const TCGCPUOps riscv_tcg_ops = {
     .cpu_exec_interrupt = riscv_cpu_exec_interrupt,
     .cpu_exec_halt = riscv_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-    .do_interrupt_locked = riscv_cpu_do_interrupt,
+    .do_interrupt = riscv_cpu_do_interrupt,
     .do_transaction_failed = riscv_cpu_do_transaction_failed,
     .do_unaligned_access = riscv_cpu_do_unaligned_access,
     .debug_excp_handler = riscv_cpu_debug_excp_handler,
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index ea58a804154..9b8473d71cf 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -229,7 +229,7 @@ static const TCGCPUOps rx_tcg_ops = {
     .cpu_exec_interrupt = rx_cpu_exec_interrupt,
     .cpu_exec_halt = rx_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-    .do_interrupt_locked = rx_cpu_do_interrupt,
+    .do_interrupt = rx_cpu_do_interrupt,
 };
 
 static void rx_cpu_class_init(ObjectClass *klass, const void *data)
diff --git a/target/rx/helper.c b/target/rx/helper.c
index 0f99279bbaa..784193ebd40 100644
--- a/target/rx/helper.c
+++ b/target/rx/helper.c
@@ -18,6 +18,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
+#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "exec/log.h"
 #include "accel/tcg/cpu-ldst.h"
@@ -47,6 +48,8 @@ void rx_cpu_do_interrupt(CPUState *cs)
     uint32_t save_psw;
     uint64_t last_pc = env->pc;
 
+    BQL_LOCK_GUARD();
+
     env->in_sleep = 0;
 
     if (env->psw_u) {
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 053eafaa842..7c725b8a4a4 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -386,7 +386,7 @@ static const TCGCPUOps s390_tcg_ops = {
     .cpu_exec_interrupt = s390_cpu_exec_interrupt,
     .cpu_exec_halt = s390_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-    .do_interrupt_locked = s390_cpu_do_interrupt,
+    .do_interrupt = s390_cpu_do_interrupt,
     .debug_excp_handler = s390x_cpu_debug_excp_handler,
     .do_unaligned_access = s390x_cpu_do_unaligned_access,
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index 01c0d77b13b..d39d41bfcf3 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -28,6 +28,7 @@
 #include "s390x-internal.h"
 #include "tcg_s390x.h"
 #ifndef CONFIG_USER_ONLY
+#include "qemu/main-loop.h"
 #include "qemu/timer.h"
 #include "system/address-spaces.h"
 #include "system/memory.h"
@@ -503,6 +504,8 @@ void s390_cpu_do_interrupt(CPUState *cs)
     bool stopped = false;
     uint64_t last_pc = cpu->env.psw.addr;
 
+    BQL_LOCK_GUARD();
+
     qemu_log_mask(CPU_LOG_INT, "%s: %d at psw=%" PRIx64 ":%" PRIx64 "\n",
                   __func__, cs->exception_index, env->psw.mask, env->psw.addr);
 
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index fdab5106b27..3bbdee301d5 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -314,7 +314,7 @@ static const TCGCPUOps superh_tcg_ops = {
     .cpu_exec_interrupt = superh_cpu_exec_interrupt,
     .cpu_exec_halt = superh_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-    .do_interrupt_locked = superh_cpu_do_interrupt,
+    .do_interrupt = superh_cpu_do_interrupt,
     .do_unaligned_access = superh_cpu_do_unaligned_access,
     .io_recompile_replay_branch = superh_io_recompile_replay_branch,
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index b6b057f104b..1d854262d13 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -28,6 +28,7 @@
 #include "qemu/plugin.h"
 
 #if !defined(CONFIG_USER_ONLY)
+#include "qemu/main-loop.h"
 #include "hw/sh4/sh_intc.h"
 #include "system/runstate.h"
 #endif
@@ -64,6 +65,8 @@ void superh_cpu_do_interrupt(CPUState *cs)
     int do_exp, irq_vector = cs->exception_index;
     uint64_t last_pc = env->pc;
 
+    BQL_LOCK_GUARD();
+
     /* prioritize exceptions over interrupts */
 
     do_exp = cs->exception_index != -1;
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 23fd0a5e3fe..ae9bdca9df8 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1076,7 +1076,7 @@ static const TCGCPUOps sparc_tcg_ops = {
     .cpu_exec_interrupt = sparc_cpu_exec_interrupt,
     .cpu_exec_halt = sparc_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-    .do_interrupt_locked = sparc_cpu_do_interrupt,
+    .do_interrupt = sparc_cpu_do_interrupt,
     .do_transaction_failed = sparc_cpu_do_transaction_failed,
     .do_unaligned_access = sparc_cpu_do_unaligned_access,
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index d6bb3fa1e54..3eea824c9a3 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -105,6 +105,8 @@ void sparc_cpu_do_interrupt(CPUState *cs)
     CPUSPARCState *env = cpu_env(cs);
     int cwp, intno = cs->exception_index;
 
+    BQL_LOCK_GUARD();
+
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         static int count;
         const char *name;
diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index 60ab0478fc6..e26d3ac5142 100644
--- a/target/sparc/int64_helper.c
+++ b/target/sparc/int64_helper.c
@@ -138,6 +138,8 @@ void sparc_cpu_do_interrupt(CPUState *cs)
     int intno = cs->exception_index;
     trap_state *tsptr;
 
+    BQL_LOCK_GUARD();
+
 #ifdef DEBUG_PCALL
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         static int count;
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index e980a13eadd..7c25b9ab707 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -327,7 +327,7 @@ static const TCGCPUOps xtensa_tcg_ops = {
     .cpu_exec_interrupt = xtensa_cpu_exec_interrupt,
     .cpu_exec_halt = xtensa_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-    .do_interrupt_locked = xtensa_cpu_do_interrupt,
+    .do_interrupt = xtensa_cpu_do_interrupt,
     .do_transaction_failed = xtensa_cpu_do_transaction_failed,
     .do_unaligned_access = xtensa_cpu_do_unaligned_access,
     .debug_check_breakpoint = xtensa_debug_check_breakpoint,
diff --git a/target/xtensa/exc_helper.c b/target/xtensa/exc_helper.c
index 7cb67d179a8..81b303a35f3 100644
--- a/target/xtensa/exc_helper.c
+++ b/target/xtensa/exc_helper.c
@@ -208,6 +208,8 @@ void xtensa_cpu_do_interrupt(CPUState *cs)
 {
     CPUXtensaState *env = cpu_env(cs);
 
+    BQL_LOCK_GUARD();
+
     if (cs->exception_index == EXC_IRQ) {
         uint64_t last_pc = env->pc;
 
-- 
2.53.0


