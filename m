Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F5BC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 18:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfiHw-0001fP-5L; Fri, 03 Jul 2026 14:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiHZ-0001aN-B8
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:06:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiHX-0002IN-8K
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:06:33 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663HiSTE675104
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 18:06:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nx/6w7J4y521AmPNG5qOYu0dUyp/4YSmzZyGwwbYfoo=; b=M8GjjV7Fg5RAO7mU
 cW9zfMQGVfnyR+6jrMCqsO5BW/77O0+lObamh7xdbGb1wd4YyWBSzoy5esS4Z5l4
 mr3GYbyRugC7WgQH7ZK+i7C7KodxpKfzvjchw9TEjeWtqwG8SMomvlU8kU7OCqtT
 lrIw44FXDC5PF6hV9NxiFxGaXOzuzyb8q1crZMNYFST5sm32vw/IDnxiemM+fcH+
 4GDC5TShVH73Lky8qwriOQhCp5HWSfixa3lWGs5G9iR3VdCjp/Ia1ZKEKrQOcQfh
 0AeoAeab9ubEShE3xV5W6L9yGRHrDZQFWSQ7nO1Ph8RZoUhrCY1NTsL8LznT64ah
 G+nwoQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6ckj18g1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 18:06:30 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c2af04aeeso9682191cf.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 11:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783101990; x=1783706790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nx/6w7J4y521AmPNG5qOYu0dUyp/4YSmzZyGwwbYfoo=;
 b=DfxpEetRVnop5CWX0ALWacvnTeZKrB7l4KfC1yUPgrW50xqmL99W8/I3TgPpThPDNx
 pS5pqMchaxGqWyAePs1e/vegBDuh5ScSYxw7sws+tot0l8xnahbgONvQWH6y3W0ckDvu
 M+ae7eqksAoO6Tmi/bjwp9Ncy1a/sFxnWdzWgCuzL1Biwa6oDt8aZ7BzkkitA7ZSX1dy
 3+o8+bzfoTU+gmPqWtj32jorq3ch5ZlBsRdW8IxnK//6cu2XtlqVwQyhz5t1da46NLYM
 Bx+6PL+XGAM6LqAt8vK3ZM1p3trvvyxAdUFpGZs0ckDpkIqGIitqiTVc2mzyOI+WDUSR
 6xag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783101990; x=1783706790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nx/6w7J4y521AmPNG5qOYu0dUyp/4YSmzZyGwwbYfoo=;
 b=R2dhzmUgKbs5skK8aMmuTe0S54ExLHxjqQfRJEaJgRlTf3EgyMybcfZFq3szBk/bmz
 GHefm1TWiYwZRqdoeFTMWmFaxaKjw2+eSPe09f0xC1o/kl+24eEU4K7TGjBt7EmBZFs0
 7UAMMkeskMdb2NXQA+cTcW8h/iNTiuCXITLPZdbn/ACl0bsMGJIWg1taW09e/ynnJdAa
 mVDpQcAHBFFSYMoqbqxpoMPX6upEiFb+9BNS0joJKVAaH1zUjM32UryaB9f1wvTuhEs0
 +qH939pgXbHHKB4QocCkPmSFFru6hFT0M9zy+CGVBDgoiZLs7qZefUqhumLSonmkyE9g
 GIkA==
X-Gm-Message-State: AOJu0YzOAMphGRwT57gR7yzEusA1RCbIsnrs0ImZCTGucw/Jtv/QQYge
 q6kKnF2iuJWXeuTwMUGILheJPIGDLNttnksdBY5XzCUhUrghYKaVD37HTogUBbLQExzlf2428v2
 dJCUpOLoJ6uYAJMQX9yRXjlHWofFpQzKO7387rHq7OstbOZQWXJig2JaIfDnBVPvZUQ==
X-Gm-Gg: AfdE7clGquAPA2O7Gvekt/J50p2G/dedTIeeRR8TYqBH0zjyqDLsUE4dUdlYQ2LFKvY
 VeqU65maP3M5EXyB1Mfc0M4wGY0YLlgY1lbetfcVaDHfch+5P31qpiFLS0UlwRP9Zdy37WeamLf
 JbYyIONmDWWqdCBb7uMDL3HaXtyqMIEHRfyQBYqj/hy11Y7yJ/zsZpR2Shu2ESoTJ6TZd5MUi82
 TmjnWDNyrkyFsDHXRT4no17vAn+DW3UZdNnq8rkRjl8fcv7BfZ4I2MSM0MCI8MrHbXdQscNwIVv
 MNlYV5u/DccRkZbrB2we/2tLv4MCTNQQkM9cAi/DWG5XtAgG0vwGtm5bOk+mqoGK2tB9wx7cQgu
 +0Ky5tUi2lTwXiugsSkK/Yb9gsuMTiB2mre+f8n9xTdLOoA==
X-Received: by 2002:a05:622a:4085:b0:50b:29da:ec58 with SMTP id
 d75a77b69052e-51c4d071d46mr2707541cf.8.1783101989613; 
 Fri, 03 Jul 2026 11:06:29 -0700 (PDT)
X-Received: by 2002:a05:622a:4085:b0:50b:29da:ec58 with SMTP id
 d75a77b69052e-51c4d071d46mr2707061cf.8.1783101989021; 
 Fri, 03 Jul 2026 11:06:29 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c41d2d688sm22560081cf.17.2026.07.03.11.06.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 11:06:28 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 16/24] target/riscv: gate riscv_cpu_update_mip with
 tcg_enabled()
Date: Fri,  3 Jul 2026 15:05:28 -0300
Message-ID: <20260703180538.3346781-17-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
References: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfX0o+RCnJ0abnE
 jO7taI06Istz46qRqnQZKsVAcGkMJP7OLGbd2Sy0QZHXO2LQYDBPwq+0sdsPRDYTlsi3wSoJcON
 3i/IAHSIeab82vIELa61llBX/GJml8k=
X-Authority-Analysis: v=2.4 cv=E8v9Y6dl c=1 sm=1 tr=0 ts=6a47fa26 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=pBdMQyqLZ6fKue3OrpUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: hfZJggnn9wyrt0Jp9oM2GeB0i8tcD9EZ
X-Proofpoint-GUID: hfZJggnn9wyrt0Jp9oM2GeB0i8tcD9EZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfX8iGTkFOCZ90U
 02ldYhQBSpeHDIVUdFBwF10aS6nEh67ucELYuIQyw5ut7RRwoIpeRs5I8o0cI9lnSnLejrd2ozN
 3M7F14rBMz/qH1zgO56EhfEaJMcrDCHzum7en7YFRiZVcLA554faymFG2ZaCIK9cB8X77NGGNcn
 Kb1WmNFAjkXYFsseCgvIpJ6MtZu4at6bq6reaa0OThFu89AKADcII8RksRQBoJ30CA/NaSn7UIo
 t7VHkvmvHeNyVfjYeA3Y4MBdjohtJ8KaAlp+Jq3xvam+QUV0Wg7eNOAmcUDbrgemjVghARSbqjp
 s8VnCgBtPfMBG8s4RksjrBLdZX0crETJ2lYCOE5e+lD0KgE5T8ZmldZTkD9qRADBKeSWhul/3eD
 yAveZPyHRho92LPzuLDH3H39zF2X1BD3Y6H3CfDm9I/iEG3lSjJYvX+c6i988zRm1j6mkmioTEt
 dyK+X81aFw4YUNF5Eqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030181
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

riscv_cpu_update_mip() is a TCG only call.  Its KVM equivalent is
kvm_riscv_set_irq().  cpu.c gates the KVM only function with a
kvm_enabled() check, making it unavailable for TCG only builds.  We need
to do the same for riscv_cpu_update_mip() otherwise a KVM only build
will fail because it doesn't know what this function is.

Use tcg_enabled() for the couple of riscv_cpu_update_mip() calls we have
unguarded in cpu.c.

We have way more calls to deal with in time_helper.c which isn't using
kvm_riscv_set_irq() at all, so create a riscv_accel_set_irq() local
helper that will choose whether to use the KVM or TCG API.

The reason we're going through all this hassle in time_helper.c is
because hw/int/riscv_aclint.c uses it, and if we don't do something
about we won't have riscv_aclint working for KVM.  Whether this is a
real problem or not and we should remove aclint support for KVM is
question for another day.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 19 ++++++++++++++-----
 target/riscv/time_helper.c | 33 +++++++++++++++++++++++++--------
 2 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index db18c52656..6b79dcc5ee 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1343,14 +1343,18 @@ static void riscv_cpu_set_irq(void *opaque, int irq, int level)
         case IRQ_M_EXT:
             if (kvm_enabled()) {
                 kvm_riscv_set_irq(cpu, irq, level);
-            } else {
+            }
+
+            if (tcg_enabled()) {
                 riscv_cpu_update_mip(env, 1 << irq, BOOL_TO_MASK(level));
             }
              break;
         case IRQ_S_EXT:
             if (kvm_enabled()) {
                 kvm_riscv_set_irq(cpu, irq, level);
-            } else {
+            }
+
+            if (tcg_enabled()) {
                 env->external_seip = level;
                 riscv_cpu_update_mip(env, 1 << irq,
                                      BOOL_TO_MASK(level | env->software_seip));
@@ -1377,9 +1381,14 @@ static void riscv_cpu_set_irq(void *opaque, int irq, int level)
             env->hgeip |= 1ULL << irq;
         }
 
-        /* Update mip.SGEIP bit */
-        riscv_cpu_update_mip(env, MIP_SGEIP,
-                             BOOL_TO_MASK(!!(env->hgeie & env->hgeip)));
+        if (kvm_enabled()) {
+            kvm_riscv_set_irq(cpu, irq, level);
+        }
+        if (tcg_enabled()) {
+            /* Update mip.SGEIP bit */
+            riscv_cpu_update_mip(env, MIP_SGEIP,
+                                 BOOL_TO_MASK(!!(env->hgeie & env->hgeip)));
+        }
     } else {
         g_assert_not_reached();
     }
diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
index 400e917354..ede1a4c2a3 100644
--- a/target/riscv/time_helper.c
+++ b/target/riscv/time_helper.c
@@ -21,19 +21,34 @@
 #include "cpu_bits.h"
 #include "time_helper.h"
 #include "hw/intc/riscv_aclint.h"
+#include "kvm/kvm_riscv.h"
+#include "system/kvm.h"
+#include "system/tcg.h"
+
+static void riscv_accel_set_irq(RISCVCPU *cpu, int irq, int level)
+{
+    if (kvm_enabled()) {
+        kvm_riscv_set_irq(cpu, irq, level);
+    }
+
+    if (tcg_enabled()) {
+        riscv_cpu_update_mip(&cpu->env, irq, level);
+    }
+}
+
 
 static void riscv_vstimer_cb(void *opaque)
 {
     RISCVCPU *cpu = opaque;
     CPURISCVState *env = &cpu->env;
     env->vstime_irq = 1;
-    riscv_cpu_update_mip(env, 0, BOOL_TO_MASK(1));
+    riscv_accel_set_irq(cpu, 0, BOOL_TO_MASK(1));
 }
 
 static void riscv_stimer_cb(void *opaque)
 {
     RISCVCPU *cpu = opaque;
-    riscv_cpu_update_mip(&cpu->env, MIP_STIP, BOOL_TO_MASK(1));
+    riscv_accel_set_irq(cpu, MIP_STIP, BOOL_TO_MASK(1));
 }
 
 /*
@@ -48,6 +63,7 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMUTimer *timer,
     RISCVAclintMTimerState *mtimer = env->rdtime_fn_arg;
     uint32_t timebase_freq;
     uint64_t rtc_r;
+    RISCVCPU *cpu;
 
     if (!riscv_cpu_cfg(env)->ext_sstc || !env->rdtime_fn ||
         !env->rdtime_fn_arg || !get_field(env->menvcfg, MENVCFG_STCE)) {
@@ -63,6 +79,7 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMUTimer *timer,
 
     timebase_freq = mtimer->timebase_freq;
     rtc_r = env->rdtime_fn(env->rdtime_fn_arg) + delta;
+    cpu = env_archcpu(env);
 
     if (timecmp <= rtc_r) {
         /*
@@ -71,9 +88,9 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMUTimer *timer,
          */
         if (timer_irq == MIP_VSTIP) {
             env->vstime_irq = 1;
-            riscv_cpu_update_mip(env, 0, BOOL_TO_MASK(1));
+            riscv_accel_set_irq(cpu, 0, BOOL_TO_MASK(1));
         } else {
-            riscv_cpu_update_mip(env, MIP_STIP, BOOL_TO_MASK(1));
+            riscv_accel_set_irq(cpu, MIP_STIP, BOOL_TO_MASK(1));
         }
         return;
     }
@@ -81,9 +98,9 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMUTimer *timer,
     /* Clear the [VS|S]TIP bit in mip */
     if (timer_irq == MIP_VSTIP) {
         env->vstime_irq = 0;
-        riscv_cpu_update_mip(env, 0, BOOL_TO_MASK(0));
+        riscv_accel_set_irq(cpu, 0, BOOL_TO_MASK(0));
     } else {
-        riscv_cpu_update_mip(env, timer_irq, BOOL_TO_MASK(0));
+        riscv_accel_set_irq(cpu, timer_irq, BOOL_TO_MASK(0));
     }
 
     /*
@@ -151,7 +168,7 @@ static void riscv_timer_disable_timecmp(CPURISCVState *env, QEMUTimer *timer,
 {
     /* Disable S-mode Timer IRQ and HW-based STIP */
     if ((timer_irq == MIP_STIP) && !get_field(env->menvcfg, MENVCFG_STCE)) {
-        riscv_cpu_update_mip(env, timer_irq, BOOL_TO_MASK(0));
+        riscv_accel_set_irq(env_archcpu(env), timer_irq, BOOL_TO_MASK(0));
         timer_del(timer);
         return;
     }
@@ -161,7 +178,7 @@ static void riscv_timer_disable_timecmp(CPURISCVState *env, QEMUTimer *timer,
         (!get_field(env->menvcfg, MENVCFG_STCE) ||
          !get_field(env->henvcfg, HENVCFG_STCE))) {
         env->vstime_irq = 0;
-        riscv_cpu_update_mip(env, 0, BOOL_TO_MASK(0));
+        riscv_accel_set_irq(env_archcpu(env), 0, BOOL_TO_MASK(0));
         timer_del(timer);
         return;
     }
-- 
2.43.0


