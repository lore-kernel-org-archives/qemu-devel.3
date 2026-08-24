Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5E7C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wySjP-0001Rq-Eh; Mon, 24 Aug 2026 07:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wySjO-0001Q9-KW
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:20:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wySjM-0006f6-9h
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:20:46 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O99IFX1379005
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 11:20:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Z1sb8xdPE6jQ67WFAEfe8s7klmi3B+xWTGYkxFCxGUY=; b=PuyayCyPfGFVnTAW
 XzhWXrxbfQ+KqSPTekIQ6D+Knizu9BOzMgJ3O7+o4SBWjkeDrj7THwypwVjqpi6E
 OIc2hQtU0i+Q/iW8qIw1MMkaQK6zIW4X3NblTMFE07zYxW60WcCg4SwcU/afkGAD
 sLi/nsShjWAjhqfIrlLl/fYea4rIZnwyiZKFHsHSHbxd+uqtMO10hdng/78WjWV/
 EzyyYoyijOCZUyDUb0Z1iLW4r6gSvD270gNHqmoYR/bTIN+zpRxiArLN98ntgCex
 dbAvmr+BmoM63Ku2OWzRv5EinOjHZv17NKqedqCECE8gUUND547vqtuEj3ZK6YkI
 QuF6jA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8huf0wpk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 11:20:43 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-73c040cc990so387851137.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 04:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787570442; x=1788175242; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Z1sb8xdPE6jQ67WFAEfe8s7klmi3B+xWTGYkxFCxGUY=;
 b=It7NhA8gY6OtzWSG01V2MdTgvcVCmKBcfVWiHvkKRaQLmeQ/krlGlqi5zAHHt2FuNy
 BuzkS4ps1WzmVqKvNCCPg29mddhIfy43qODgsmRhFf+eY3UHbEEKBKzflZUK8tOSPo/l
 gkRCfZfCrQYJwVydfqPbQ+ixlt0Z8sLTB57gyNwzEF7uw0nP3Li5gFoIxqdAUZYski8n
 Bz0iIvxU12jb1e33M9/revlXkA027htOsCM96Ma4kB6vq3yWvbx2fB8deQkmTY1ORoWZ
 nsVG8VWLUcS9bqtW+2V9PXd054D0W5xdzbwOTp2xx9AwIfvu1uZJZSM1BLi0FJWgssZw
 sfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787570442; x=1788175242;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z1sb8xdPE6jQ67WFAEfe8s7klmi3B+xWTGYkxFCxGUY=;
 b=QV5udA+yOFQ5AClysqoe4h88x9egP9KfTXvCNN6XDITMJsjF2fLQYDiipxvoe0+8JC
 hG45OB6b5b2VmG/5Y0PzipQrnlajfgqPlWr1NnA51s9sXMQ5g2g985RmnKMjIFZUQnpH
 adLCIodwpXWdgFNHKjtD+LEn+kMJK1FXZ5VLVeiw5cxUDbPZnUmxdEy58WndJf3jB5Rh
 X/+d7he4MpDC4aSpyAb2RvpKFABGCM/0XlDf3sgppokxLOkMtIe6PTlz9thCAFQmd75P
 EGKZSnCMa9Vzg7xm5eaLnf05JLQxxHOgsBXnmcvXDjm0F7Ni/dClk8dPVKWF0ScvlQhm
 vGVA==
X-Gm-Message-State: AFuF++nBq/o74hedbvh9SvJKm1bX11jURaukij7cxFIQ+4Zyb1xvkK8n
 iCFvS4QTah/85weDe/4lgvQmiVCLRv0Ytx6f71lnuETQ5J0vngiag8hFod4NnSrfMY3QRCPbl6H
 K9HkCIH3/k08XiFP77oM9yy9EoUCvpi3snIrAbvOm/b04TA7prdVmpN5hNgxxPd88oA==
X-Gm-Gg: AR+sD129hskYCImlADetwDATu1IsiZagXkmdrMnmbjSqK/Zwy8RGiLNBezNrDtVYr54
 TXEIzu4vI91Fdjv1kazJA/ZpU8LJWLRl5GO+8HJG33TkMU+VrPX6EBDl3JcxM2zLKdL7dd5wzot
 ML3WHv4Kdz9Ke8hCUJZyRsYIY/QyYP7+manwtiNfxB8gtTpYA73vQ4dY3VYifD50EDoQ6p8WPzQ
 04w6DAU3+LPyTmbYf3Hp7QL1rkegeNmAF9uwZ7AbTI0RC20TvY6UtW6qll1v6U511Q7bE0pu1tl
 QC24Sa7jvFwLbXOj4QnoeWapnC6k5B05MpzC1qYVSYIno7hv1aSOCMhAW6G5W+qA6wOt/CVq5jS
 FsVxvgOM9fzx3NakpuXiZgZtH1EIb/x0NyD+lt4yXxINEaILHLQ==
X-Received: by 2002:a05:6102:3ec7:b0:77a:d53e:7d19 with SMTP id
 ada2fe7eead31-77ad53e7fbemr6896525137.13.1787570442473; 
 Mon, 24 Aug 2026 04:20:42 -0700 (PDT)
X-Received: by 2002:a05:6102:3ec7:b0:77a:d53e:7d19 with SMTP id
 ada2fe7eead31-77ad53e7fbemr6896472137.13.1787570441948; 
 Mon, 24 Aug 2026 04:20:41 -0700 (PDT)
Received: from localhost.localdomain (44.170.88.92.rev.sfr.net. [92.88.170.44])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e1cdbe9sm8226759a12.24.2026.08.24.04.20.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Aug 2026 04:20:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Song Gao <17746591750@163.com>,
 Bibo Mao <maobibo@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v4 19/20] cpus: Constify @cpu in SysemuCPUOps::has_work()
 handler
Date: Mon, 24 Aug 2026 13:17:08 +0200
Message-ID: <20260824111711.26297-20-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824111711.26297-1-philmd@oss.qualcomm.com>
References: <20260824111711.26297-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5NCBTYWx0ZWRfX7EVddgtFFMgL
 Jm2rEV1dzqNDwR9CzskZWOEBEK19KCS6R+l9blwMWAqESvp1EcGheQqD1W6UTNYa6MD8gwWBsdY
 bASDmBJeu1TMsSwk9kpLa0biB2pqmBE=
X-Authority-Analysis: v=2.4 cv=Wac8rUhX c=1 sm=1 tr=0 ts=6a8c290b cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=s1NLoHz9uzatdv2VNqxUSg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=cM1bI5kxBi4gRGPUlTgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 7vOmbsPmG4bjh0BMYLEt6IcXwxyZe9v-
X-Proofpoint-GUID: 7vOmbsPmG4bjh0BMYLEt6IcXwxyZe9v-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5NCBTYWx0ZWRfX7TvUWYX3VwdI
 uz1x3fpWiqDMlZKwH3sw04jjEbRsIvWufGbIgsXqSyFXsb1wKM/3NtzElUNg6CJERoAscUfN5g1
 IJglpXNu4nagAjZiU9HkqQSWNWTnCPY6wb8oTdDTfQLTNFWzM7cdiEa67EGFqHDY5366d0GI7Bh
 EV/SrMQbh10qm5JqUkO9GrMCBPTKP5CTvcQuy7RkLvY0jYjGId8QP9+XHh5MheRUqv3qBBdl0lK
 45ikLC0uUPRMyUqSD9YyLQ+/osNnJasvTvDcJwPTzfR6K6CD1ktJ4p5UkK7D9HY/kkB9Jh2xoq7
 6AqAOizxPdNad1pyVVFFDa1tF93/f+ZEfjHiiIT3d+HZO43/l4F/QQqruYl6cTKEhAwJochqehu
 xh33quZMROTyqVHrGNXgxOFI1Za3TxcHsvFnuzHqx7MG8HpcaIziJkzH6DpWm/ZOZx8TKY+UEX8
 nXRCJLwg4LACUrxFt2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240094
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

All functions called by target has_work() handler take a const @cpu
argument. We can now fulfill the comment added in commit c2804566f6
("target/arm: do not clear halting reason in has_work helper"),
qualifying the handler const to denote its idempotency.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/sysemu-cpu-ops.h | 4 ++--
 target/alpha/cpu.c               | 2 +-
 target/arm/cpu.c                 | 4 ++--
 target/avr/cpu.c                 | 3 ++-
 target/hexagon/cpu.c             | 4 ++--
 target/hppa/cpu.c                | 2 +-
 target/i386/cpu.c                | 2 +-
 target/loongarch/cpu.c           | 2 +-
 target/m68k/cpu.c                | 2 +-
 target/microblaze/cpu.c          | 2 +-
 target/mips/cpu.c                | 4 ++--
 target/or1k/cpu.c                | 2 +-
 target/ppc/cpu_init.c            | 2 +-
 target/riscv/cpu.c               | 5 ++---
 target/rx/cpu.c                  | 2 +-
 target/s390x/cpu-system.c        | 4 ++--
 target/sh4/cpu.c                 | 2 +-
 target/sparc/cpu.c               | 2 +-
 target/tricore/cpu.c             | 2 +-
 target/xtensa/cpu.c              | 4 ++--
 20 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 9a45596169a..095bdcd997a 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -19,10 +19,10 @@ typedef struct SysemuCPUOps {
     /**
      * @has_work: Callback for checking if there is work to do.
      *
-     * This function should be idempotent (i.e. not change state) as
+     * This function is idempotent (i.e. not change state) as
      * it will likely be queried multiple times before a CPU resumes.
      */
-    bool (*has_work)(CPUState *cpu); /* MANDATORY NON-NULL */
+    bool (*has_work)(const CPUState *cpu); /* MANDATORY NON-NULL */
     /**
      * @get_memory_mapping: Callback for obtaining the memory mappings.
      */
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 7d1d036e1d3..21d4f8ac23b 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -77,7 +77,7 @@ static void alpha_restore_state_to_opc(CPUState *cs,
 }
 
 #ifndef CONFIG_USER_ONLY
-static bool alpha_cpu_has_work(CPUState *cs)
+static bool alpha_cpu_has_work(const CPUState *cs)
 {
     /* Here we are checking to see if the CPU should wake up from HALT.
        We will have gotten into this state only for WTINT from PALmode.  */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 9761bb173c1..ba66359d410 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -141,9 +141,9 @@ int arm_cpu_mmu_index(CPUState *cs, bool ifetch)
  * CPU_INTERRUPT_*NMI anyway. So we might as well accept NMI here
  * unconditionally.
  */
-static bool arm_cpu_has_work(CPUState *cs)
+static bool arm_cpu_has_work(const CPUState *cs)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
+    const ARMCPU *cpu = ARM_CPU(cs);
 
     /*
      * Only another PSCI call can wake the CPU up in which case the
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index a01e6fa4751..a96bef46ff1 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -23,6 +23,7 @@
 #include "qemu/qemu-print.h"
 #include "exec/translation-block.h"
 #include "system/address-spaces.h"
+#include "hw/core/cpu.h"
 #include "cpu.h"
 #include "disas/dis-asm.h"
 #include "tcg/debug-assert.h"
@@ -43,7 +44,7 @@ static vaddr avr_cpu_get_pc(CPUState *cs)
     return cpu->env.pc_w * 2;
 }
 
-static bool avr_cpu_has_work(CPUState *cs)
+static bool avr_cpu_has_work(const CPUState *cs)
 {
     return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD | CPU_INTERRUPT_RESET)
             && cpu_interrupts_enabled(cpu_env(cs));
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 4cc6bd67c28..868aef0cde4 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -364,9 +364,9 @@ bool hexagon_thread_is_enabled(const CPUHexagonState *env)
     return E_bit;
 }
 
-static bool hexagon_cpu_has_work(CPUState *cs)
+static bool hexagon_cpu_has_work(const CPUState *cs)
 {
-    CPUHexagonState *env = cpu_env(cs);
+    const CPUHexagonState *env = cpu_env(cs);
 
     return hexagon_thread_is_enabled(env) &&
         (cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_SWI
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 7b1309a7c38..dbf58466c24 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -134,7 +134,7 @@ static void hppa_restore_state_to_opc(CPUState *cs,
 }
 
 #ifndef CONFIG_USER_ONLY
-static bool hppa_cpu_has_work(CPUState *cs)
+static bool hppa_cpu_has_work(const CPUState *cs)
 {
     return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1fc02cf94e6..0606ac16664 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10638,7 +10638,7 @@ int x86_cpu_pending_interrupt(const CPUState *cs, int interrupt_request)
     return 0;
 }
 
-static bool x86_cpu_has_work(CPUState *cs)
+static bool x86_cpu_has_work(const CPUState *cs)
 {
     return x86_cpu_pending_interrupt(cs, cs->interrupt_request) != 0;
 }
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 2dbe2203b20..7bf7596172b 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -96,7 +96,7 @@ bool cpu_loongarch_hw_interrupts_pending(const CPULoongArchState *env)
 #endif
 
 #ifndef CONFIG_USER_ONLY
-static bool loongarch_cpu_has_work(CPUState *cs)
+static bool loongarch_cpu_has_work(const CPUState *cs)
 {
     bool has_work = false;
 
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 523694d8fbf..da3681fab1f 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -76,7 +76,7 @@ static void m68k_restore_state_to_opc(CPUState *cs,
 }
 
 #ifndef CONFIG_USER_ONLY
-static bool m68k_cpu_has_work(CPUState *cs)
+static bool m68k_cpu_has_work(const CPUState *cs)
 {
     return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD);
 }
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 6013a8def8e..d1d2f0ec7e3 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -127,7 +127,7 @@ static void mb_restore_state_to_opc(CPUState *cs,
 }
 
 #ifndef CONFIG_USER_ONLY
-static bool mb_cpu_has_work(CPUState *cs)
+static bool mb_cpu_has_work(const CPUState *cs)
 {
     return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index c069aa1c0b7..0f39f8fe0a5 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -134,9 +134,9 @@ static vaddr mips_cpu_get_pc(CPUState *cs)
 }
 
 #if !defined(CONFIG_USER_ONLY)
-static bool mips_cpu_has_work(CPUState *cs)
+static bool mips_cpu_has_work(const CPUState *cs)
 {
-    CPUMIPSState *env = cpu_env(cs);
+    const CPUMIPSState *env = cpu_env(cs);
     bool has_work = false;
 
     /*
diff --git a/target/or1k/cpu.c b/target/or1k/cpu.c
index 42d9351b6d7..10b13ae69cd 100644
--- a/target/or1k/cpu.c
+++ b/target/or1k/cpu.c
@@ -76,7 +76,7 @@ static void openrisc_restore_state_to_opc(CPUState *cs,
 }
 
 #ifndef CONFIG_USER_ONLY
-static bool openrisc_cpu_has_work(CPUState *cs)
+static bool openrisc_cpu_has_work(const CPUState *cs)
 {
     return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD | CPU_INTERRUPT_TIMER);
 }
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 85a91ff4bb6..fd63cd6ab09 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7224,7 +7224,7 @@ static int ppc_cpu_mmu_index(CPUState *cs, bool ifetch)
 #endif /* CONFIG_TCG */
 
 #ifndef CONFIG_USER_ONLY
-static bool ppc_cpu_has_work(CPUState *cs)
+static bool ppc_cpu_has_work(const CPUState *cs)
 {
     return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD);
 }
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 278e00d260c..928e1f9f6a4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -950,10 +950,9 @@ int riscv_cpu_vsirq_pending(const CPURISCVState *env)
                                     (irqs | irqs_f_vs), env->hviprio);
 }
 
-static bool riscv_cpu_has_work(CPUState *cs)
+static bool riscv_cpu_has_work(const CPUState *cs)
 {
-    RISCVCPU *cpu = RISCV_CPU(cs);
-    CPURISCVState *env = &cpu->env;
+    const CPURISCVState *env = cpu_env(cs);
     /*
      * Definition of the WFI instruction requires it to ignore the privilege
      * mode and delegation registers, but respect individual enables
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 69946928995..dfa09a85bce 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -73,7 +73,7 @@ static void rx_restore_state_to_opc(CPUState *cs,
     cpu->env.pc = data[0];
 }
 
-static bool rx_cpu_has_work(CPUState *cs)
+static bool rx_cpu_has_work(const CPUState *cs)
 {
     return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIR);
 }
diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
index 84faceb3338..3a0ff46e144 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -39,9 +39,9 @@
 #include "system/tcg.h"
 #include "hw/core/sysemu-cpu-ops.h"
 
-static bool s390_cpu_has_work(CPUState *cs)
+static bool s390_cpu_has_work(const CPUState *cs)
 {
-    S390CPU *cpu = S390_CPU(cs);
+    const S390CPU *cpu = S390_CPU(cs);
 
     /* STOPPED cpus can never wake up */
     if (s390_cpu_get_state(cpu) != S390_CPU_STATE_LOAD &&
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 55c73a1da35..b0ed356d0f7 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -107,7 +107,7 @@ static bool superh_io_recompile_replay_branch(CPUState *cs,
     return false;
 }
 
-static bool superh_cpu_has_work(CPUState *cs)
+static bool superh_cpu_has_work(const CPUState *cs)
 {
     return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD);
 }
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 2baa5036871..8dd9b0d5ee3 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -783,7 +783,7 @@ static void sparc_restore_state_to_opc(CPUState *cs,
 }
 
 #ifndef CONFIG_USER_ONLY
-static bool sparc_cpu_has_work(CPUState *cs)
+static bool sparc_cpu_has_work(const CPUState *cs)
 {
     return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
            cpu_interrupts_enabled(cpu_env(cs));
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 82b56c3cd56..357f3737053 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -111,7 +111,7 @@ static void tricore_cpu_reset_hold(Object *obj, ResetType type)
     cpu_state_reset(cpu_env(cs));
 }
 
-static bool tricore_cpu_has_work(CPUState *cs)
+static bool tricore_cpu_has_work(const CPUState *cs)
 {
     /* Interrupts are not implemented */
     return true;
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 99c8bd4b5fb..1b299568776 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -140,9 +140,9 @@ static void xtensa_restore_state_to_opc(CPUState *cs,
 }
 
 #ifndef CONFIG_USER_ONLY
-static bool xtensa_cpu_has_work(CPUState *cs)
+static bool xtensa_cpu_has_work(const CPUState *cs)
 {
-    CPUXtensaState *env = cpu_env(cs);
+    const CPUXtensaState *env = cpu_env(cs);
 
     return !env->runstall && env->pending_irq_level;
 }
-- 
2.53.0


