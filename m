Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19181C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx0Ku-0003nQ-BH; Thu, 20 Aug 2026 06:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx0Ks-0003h6-BP
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:49:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx0Ko-00067Q-Ct
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:49:26 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K6eZCj2161130
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 10:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TipPX5YNw3dRxG7nvDBKnheNZjk+0BKwSN/9tefKD8U=; b=UFq2n4f72oI3NZzM
 970zhHT+nPKPzK0LMS/mg4AB/Sc9TQJf2a6mJI3puKWQzMnMQmGfmQsLbnk7Scmx
 UtxWCGkLLE3eNpwstdsPpSDaum4+50H+LPfk+5ssallogIk14EldgZFulyP+aEIS
 2LyBI4bWnqQJ5llLBoxWkwbOhulI79IL5PeFNNwTY9M57GVtV3yvWQu+YS2EN/nd
 coyZjh0xjLCqkJt8XJQC+qH7ihFu9leTx+ZhSZwH29bcrYT05jkqcIGp7nphzTGW
 HIGpUrs7kn2CADKU0O/87TJ4C1edRBjg2IzjcExmjQreD2POaIHE/hSvw5R477cW
 7x9lyQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5vh7rx2j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 10:49:10 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e62e3459fso241083385a.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 03:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787222950; x=1787827750; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TipPX5YNw3dRxG7nvDBKnheNZjk+0BKwSN/9tefKD8U=;
 b=gfadsVrRVMS6ziewa8M1ywJE6rRP+oDxOafux//Ii12w/XG5krnOq0YGAj+3xklfAf
 N6xm9gOhmKyTiFtQL+YbZB/+0AEEDkqZnTlrWEA9SKtzbWFbN2k6pc6ZZH3tMto487Ss
 IyfBfdUmFVGRiTW7jWym0K7gR6aLvF6WLBJhUO1fJCuf1+TQklEGDgsNYLXwCfxZM2mv
 E9N1NBkoc5mVJulYsGfkyaaD6/FHDEfjptLcyzdmPJQhV+hOxjEJcbuMAync0X+BJd8U
 esodHxrvtkpOhFO3WdVHjfy0q+y1YmpSDurdapXnqIjpqHu+AZa6gR55FaT8OG2nB5Rw
 gttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787222950; x=1787827750;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TipPX5YNw3dRxG7nvDBKnheNZjk+0BKwSN/9tefKD8U=;
 b=NdAaGqoisQomHx4LERlduotwkjT2czEu9KgE8Yn/Ky70Xdr32VaBN+rv1rLhex12Gn
 K+bfQrzeWpp3pzy8BmKvVHmkjv5GhvyVBe65ykW2YU6s85VPhsE9cD95LpJ04BBwPBam
 kdkTccTP6LAGyN/H8L0SWtswctfnIwgZXsWltGPF7g61rACwzHoOF/DhAx92eGQdZ2r8
 znAb4qWV3U12CCkemvUwfbT0GG69i+lXRyM3eKixGYJOfy3JdbK3M69KxotQtIk5Zzh9
 Raq7ZDVl/QT0EGtjlh3M0cVmgDbAxVuyjq5PE1YIklckEqPSzVCSOXZI7I5K/2scQxqd
 T0Ww==
X-Gm-Message-State: AOJu0YxalGIwuOybxcE9GFWu9g+bGJ6gE7GUj70R0h8xNqHP/+cE2Un2
 Oda0UVYEXySZ722n4R7ee4Ab0eG2OXhvY/teC49OPYgWXEav01ZYIlLij3z0dlIvpgJNXISkvYB
 fr8H0iSiOJwvc/7FcCuRtQMSli0Hdfkp2wUInrzb2TuXcgyVy+wzFw8dJw3c+Dgwp+2pi
X-Gm-Gg: AR+sD1264mzNYRARVW9d4ttTHqwlmdUf8cZiRLd0EOvYEBJQ5dr4OrUT/Ah4SVdDQOR
 ItHPB7KO2PTpxn3o0o7/MBNYKtKoB1WOd9E2aXKlFxKp3PV3kgkq/enY6dfLNbiUD0hRuKIBulY
 a4wyf9sgAS0dnQdyHneXhx0sEIttpR2b7/UATCugA5mrZqQhR2gvBZd+0+PXbrtBIfGEUIo6Bef
 unhs+SaAOpl8NMFy3CoNTqlfqZDrbSLGjW9QS1frv7BHHY8bn4GFFRMMjdpXyhn06X90iVnp+j6
 dvN3bVomDOs427hXdTgi3Gw7Yc4xorFXL/uAQCcz95ZwLofaLUm6Bx83bjDltYTbOuCmuSGspzP
 M9fafL0Uh413/Hfg1tQIsjm0suokGXwAe90u6VFoO6w==
X-Received: by 2002:a05:620a:2891:b0:930:a348:6ae with SMTP id
 af79cd13be357-9371e31723dmr968864085a.38.1787222949245; 
 Thu, 20 Aug 2026 03:49:09 -0700 (PDT)
X-Received: by 2002:a05:620a:2891:b0:930:a348:6ae with SMTP id
 af79cd13be357-9371e31723dmr968860185a.38.1787222948714; 
 Thu, 20 Aug 2026 03:49:08 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441753sm13942403f8f.5.2026.08.20.03.49.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Aug 2026 03:49:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Zhao Liu <zhao1.liu@intel.com>,
 Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
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
Subject: [RFC PATCH 13/13] cpus: Constify @cpu in SysemuCPUOps::has_work()
 handler
Date: Thu, 20 Aug 2026 12:47:29 +0200
Message-ID: <20260820104730.25462-14-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820104730.25462-1-philmd@oss.qualcomm.com>
References: <20260820104730.25462-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA3OSBTYWx0ZWRfXxPN1Llm0fk99
 ZasZALa70zANBbGx4hdyMxnQcay7pPOzK+Z21DSN+Jv3IDqhR2Va3vMmLcM79Ffq6Ee0W4exqjt
 TIezmPU9yo84UjdoESRPSxYso4reY7rEUwuXJY7liI1TgcvZb2HT/eHwJ6LM+NOgQMEuBoLKPZG
 6OGyca6pk6Yup5+Faniv4pLfm80J+QnVAUaAUxQM5+zX6rhczfkj1xZNa3h7o/057fKNvJ6INT6
 GeuQdjQF1O5AzpbWlF1r0R9IfyS2piRbxNhaoyvotsvM0Y3tvHBrNAwZFCHZoT1oH/giFQsJCoB
 8bGAHS2xkWMG9qoWJggnW1EX/9LGIyvapMMt4/FVloBYm8tvGaFk8Ac0CtT9kgxhPcNEITEku5s
 99UU9k9CPfpZBuOnbP2fWC/54ZAj8VK93JfEJUCO+Pm+F+6rXlo0GU7tLadAWpV7daWhO2uzHkR
 D26uSylLL48/LtmS3ww==
X-Proofpoint-ORIG-GUID: x7Wn0V3HpNm6OVbK6H_62c4S8ECQvXJD
X-Authority-Analysis: v=2.4 cv=Y7fIdBeN c=1 sm=1 tr=0 ts=6a86dba6 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=SERbGe8VzmIjvadycG8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA3OSBTYWx0ZWRfX9QeNU/UnlOuC
 opKJQOtGyroIbMLHCS3TWQe2TO47WhHJfEODRR+a2mN2rprsBmjihQBJfkS4shUHCxUjWxB03ca
 jHHop9/ixB8LkLL+ELV9uVXu+xWy99M=
X-Proofpoint-GUID: x7Wn0V3HpNm6OVbK6H_62c4S8ECQvXJD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200079
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

All functions called by target has_work() handler take a const @cpu
argument. We can now fulfill the comment added in commit c2804566f6
("target/arm: do not clear halting reason in has_work helper"),
qualifying the handler const to denote its idempotency.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/core/sysemu-cpu-ops.h | 4 ++--
 target/loongarch/internals.h     | 2 +-
 target/riscv/internals.h         | 2 +-
 target/s390x/s390x-internal.h    | 2 +-
 target/alpha/cpu.c               | 2 +-
 target/arm/cpu.c                 | 4 ++--
 target/avr/cpu.c                 | 5 +++--
 target/hexagon/cpu.c             | 4 ++--
 target/hppa/cpu.c                | 2 +-
 target/i386/cpu.c                | 2 +-
 target/loongarch/cpu.c           | 4 ++--
 target/m68k/cpu.c                | 2 +-
 target/microblaze/cpu.c          | 2 +-
 target/mips/cpu.c                | 4 ++--
 target/or1k/cpu.c                | 2 +-
 target/ppc/cpu_init.c            | 2 +-
 target/riscv/cpu.c               | 2 +-
 target/rx/cpu.c                  | 2 +-
 target/s390x/cpu-system.c        | 2 +-
 target/sh4/cpu.c                 | 2 +-
 target/sparc/cpu.c               | 4 ++--
 target/tricore/cpu.c             | 4 ++--
 target/xtensa/cpu.c              | 4 ++--
 23 files changed, 33 insertions(+), 32 deletions(-)

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
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index 6a733e6c3a5..d86029bcb31 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -38,7 +38,7 @@ uint64_t cpu_loongarch_get_constant_timer_counter(LoongArchCPU *cpu);
 uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu);
 void cpu_loongarch_store_constant_timer_config(LoongArchCPU *cpu,
                                                uint64_t value);
-bool loongarch_cpu_has_work(CPUState *cs);
+bool loongarch_cpu_has_work(const CPUState *cs);
 bool cpu_loongarch_hw_interrupts_pending(const CPULoongArchState *env);
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 5d84e4de960..782f12abfaf 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -203,7 +203,7 @@ static inline target_ulong get_xepc_mask(CPURISCVState *env)
 
 #ifndef CONFIG_USER_ONLY
 /* Our implementation of SysemuCPUOps::has_work */
-bool riscv_cpu_has_work(CPUState *cs);
+bool riscv_cpu_has_work(const CPUState *cs);
 #endif
 
 /* Zjpm addr masking routine */
diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index 54b62808d83..00917473a54 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -248,7 +248,7 @@ bool s390_cpu_system_realize(DeviceState *dev, Error **errp);
 void s390_cpu_finalize(Object *obj);
 void s390_cpu_system_class_init(CPUClass *cc);
 void s390_cpu_machine_reset_cb(void *opaque);
-bool s390_cpu_has_work(CPUState *cs);
+bool s390_cpu_has_work(const CPUState *cs);
 #endif /* CONFIG_USER_ONLY */
 
 
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
index a01e6fa4751..1024c0ae9a2 100644
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
@@ -43,10 +44,10 @@ static vaddr avr_cpu_get_pc(CPUState *cs)
     return cpu->env.pc_w * 2;
 }
 
-static bool avr_cpu_has_work(CPUState *cs)
+static bool avr_cpu_has_work(const CPUState *cs)
 {
     return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD | CPU_INTERRUPT_RESET)
-            && cpu_interrupts_enabled(cpu_env(cs));
+            && cpu_interrupts_enabled(cpu_env_const(cs));
 }
 
 static int avr_cpu_mmu_index(CPUState *cs, bool ifetch)
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 7ae5740899b..4ad1cae354a 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -364,9 +364,9 @@ bool hexagon_thread_is_enabled(const CPUHexagonState *env)
     return E_bit;
 }
 
-static bool hexagon_cpu_has_work(CPUState *cs)
+static bool hexagon_cpu_has_work(const CPUState *cs)
 {
-    CPUHexagonState *env = cpu_env(cs);
+    const CPUHexagonState *env = cpu_env_const(cs);
 
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
index 8777bcbae85..93b617f94dc 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10639,7 +10639,7 @@ int x86_cpu_pending_interrupt(const CPUState *cs, int interrupt_request)
     return 0;
 }
 
-static bool x86_cpu_has_work(CPUState *cs)
+static bool x86_cpu_has_work(const CPUState *cs)
 {
     return x86_cpu_pending_interrupt(cs, cs->interrupt_request) != 0;
 }
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 82ec35e081f..4c1aae4fb01 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -96,12 +96,12 @@ bool cpu_loongarch_hw_interrupts_pending(const CPULoongArchState *env)
 #endif
 
 #ifndef CONFIG_USER_ONLY
-bool loongarch_cpu_has_work(CPUState *cs)
+bool loongarch_cpu_has_work(const CPUState *cs)
 {
     bool has_work = false;
 
     if (cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
-        cpu_loongarch_hw_interrupts_pending(cpu_env(cs))) {
+        cpu_loongarch_hw_interrupts_pending(cpu_env_const(cs))) {
         has_work = true;
     }
 
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
index c069aa1c0b7..0f9374d98a9 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -134,9 +134,9 @@ static vaddr mips_cpu_get_pc(CPUState *cs)
 }
 
 #if !defined(CONFIG_USER_ONLY)
-static bool mips_cpu_has_work(CPUState *cs)
+static bool mips_cpu_has_work(const CPUState *cs)
 {
-    CPUMIPSState *env = cpu_env(cs);
+    const CPUMIPSState *env = cpu_env_const(cs);
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
index ab2868dc1e2..b455b997561 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -950,7 +950,7 @@ int riscv_cpu_vsirq_pending(const CPURISCVState *env)
                                     (irqs | irqs_f_vs), env->hviprio);
 }
 
-bool riscv_cpu_has_work(CPUState *cs)
+bool riscv_cpu_has_work(const CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
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
index cc9685221ae..22ed2b097bb 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -39,7 +39,7 @@
 #include "system/tcg.h"
 #include "hw/core/sysemu-cpu-ops.h"
 
-bool s390_cpu_has_work(CPUState *cs)
+bool s390_cpu_has_work(const CPUState *cs)
 {
     S390CPU *cpu = S390_CPU(cs);
 
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
index 2baa5036871..f7c04daf0c9 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -783,10 +783,10 @@ static void sparc_restore_state_to_opc(CPUState *cs,
 }
 
 #ifndef CONFIG_USER_ONLY
-static bool sparc_cpu_has_work(CPUState *cs)
+static bool sparc_cpu_has_work(const CPUState *cs)
 {
     return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
-           cpu_interrupts_enabled(cpu_env(cs));
+           cpu_interrupts_enabled(cpu_env_const(cs));
 }
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 6d448727005..33a5875ef24 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -111,9 +111,9 @@ static void tricore_cpu_reset_hold(Object *obj, ResetType type)
     cpu_state_reset(cpu_env(cs));
 }
 
-static bool tricore_cpu_has_work(CPUState *cs)
+static bool tricore_cpu_has_work(const CPUState *cs)
 {
-    return true;
+    return true; /* XXX */
 }
 
 static int tricore_cpu_mmu_index(CPUState *cs, bool ifetch)
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 99c8bd4b5fb..fe7965651f4 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -140,9 +140,9 @@ static void xtensa_restore_state_to_opc(CPUState *cs,
 }
 
 #ifndef CONFIG_USER_ONLY
-static bool xtensa_cpu_has_work(CPUState *cs)
+static bool xtensa_cpu_has_work(const CPUState *cs)
 {
-    CPUXtensaState *env = cpu_env(cs);
+    const CPUXtensaState *env = cpu_env_const(cs);
 
     return !env->runstall && env->pending_irq_level;
 }
-- 
2.53.0


