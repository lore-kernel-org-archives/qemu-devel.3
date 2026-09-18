Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB982C982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 15:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7afo-0006UW-8r; Fri, 18 Sep 2026 11:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1x7afm-0006U7-QB
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 11:38:46 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1x7afk-0003Ez-W9
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 11:38:46 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5b8997bc6e6so603945e87.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 08:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789745923; x=1790350723; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xtk6b3LqF8Alhgz5DsecTwmL5JMHV3Z0f7W0hoiRnUs=;
 b=C+G7XhpaIpT6ENyPid4yMuBk5SA59efGREsKMBPtYW3KTtjSTiau8T0EHFNDBzPNc2
 HCK0Nr+h1/ZlCFCfSSrFbyD5tdujSRyXV07/GZ8v2uVHx4Xwes9oMqfCbh8VH1uUHf4L
 1bRHHrpxfl0sixD/+NNdGRD5uRneFMuCiesJBEZHkCKdiz3SGo0Egj2urcMNX415reMU
 +fu5lUJleC/J1iLQkhqCK5MrslN8Z9K4b/EbG+6DkDnI9GQatFGhxqaFjSJkoLIlIbi4
 MrstBJ+mZIR7QuJ4OQ3+P+PcsCM7oLt/ckvN5BxIoVgrklh82CmLODnEyGSnP4sq1CUj
 ER2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789745923; x=1790350723;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xtk6b3LqF8Alhgz5DsecTwmL5JMHV3Z0f7W0hoiRnUs=;
 b=wvTM6YMfrW8BBfUi2xFKt0yFuDfkx/ZmPbk06G4S+Pqf4SgYbVrqWkovI9SbneE4UF
 dR8IZunFTNDwPSQSW8dBz1I3Twn0BzpD6xe9BUlgEVqdjmFVD9jPcEpCIGhyerZfGD1i
 qD4CqWP4srA6xTtZdf0uGOjmyod+vR5HSCgLlDv0bAixTczEWFmBKrB+k31SF0cgtIfL
 TJzfRmlHapo1GfvgZjMhvjV0M3lHP+kczrHtI9xc2C/V0eXwx9N/hXD3M4+FXp1Ba43U
 V4EkktPOqlFxTXkZx7A4Fy+BO57/YzmgRcyYsrrYOyDbltbZwaxEOBqofmctBAAsF5DA
 NszA==
X-Gm-Message-State: AFuF++mhgFRJNAUiQG20QjL9scUpyFlwGaweUFI753U6kO6ti+Klt0bF
 9I6IMqgHeGRu62P3qyakFf98+bsp+4Z2F9nuM+5pfjRZFQkFMIBvXiYQRW37Bj3q
X-Gm-Gg: AYBFou3HxSpWOQlTWAm1x3VRiJUieYfga/uVtEUQ+k+fwrNntCBx70U5sNeR0lDBJ6X
 Y3iJ1ubRjcL7Fz0pQ8Ljw9W9sleWVFMU8PBDpAgoMF5fSmxCy4zijIEYEcS1PcMoSxVsuGrc8SG
 I6VdpAusJ0XPNN7JwecZuY72PzBwp3P5FCX30Sd4V2kHO2my6lCrjZeqBlxcjpaMENcjDXR2wvS
 LnUJ+2BWSKkG/7PUR8Q4vSaCxYFOmjIWgCGAeYFIqjQybMvUP5vPloTJPBC09x23bFBDwBsQzrj
 QaR5yzN1sy15x4co0qPXeGy/OHTS8cgSoAek6UhdnCjNDFSjMT16IV7WuIkpO9pG/3T7YrGducS
 aI+/Dn4/Jmn1q7vU6P4C+oan1wPsWhNjP45xVFsimias6ahNwsAsMfZr0pzBqdtBT7XosoI1iEU
 EhlYN019au9lL70XV+LrYCNeD0ZUeXlPhnlv9MjCiExRJj8MyjOX80uYnLTZ1eW3zhgbBFwtZnh
 C3Mbw4=
X-Received: by 2002:a05:6512:138d:b0:5b8:c64a:57d1 with SMTP id
 2adb3069b0e04-5b8c64a5bfcmr93981e87.42.1789745923014; 
 Fri, 18 Sep 2026 08:38:43 -0700 (PDT)
Received: from localhost ([213.79.119.14]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8c274e53bsm554108e87.27.2026.09.18.08.38.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 08:38:42 -0700 (PDT)
From: Konstantin Semichastnov <antikostya2@gmail.com>
Date: Fri, 18 Sep 2026 18:34:40 +0300
Subject: [PATCH 4/6] hw/riscv/ntrace: emit PPCCD and Ownership on priv change
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-upstream-ntrace_msg-v1-4-16a56ad8e0ef@gmail.com>
References: <20260918-upstream-ntrace_msg-v1-0-16a56ad8e0ef@gmail.com>
In-Reply-To: <20260918-upstream-ntrace_msg-v1-0-16a56ad8e0ef@gmail.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-riscv@nongnu.org, Alexei Filippov <halip0503@gmail.com>, 
 Arseniy Semenov <ar.semenov@outlook.com>, 
 Konstantin Semichastnov <antikostya2@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5455; i=antikostya2@gmail.com; 
 h=from:subject:message-id;
 bh=Ql9XhGC59YQRAF2d1m24g1XJo9BhDV997HVghtOXinw=; 
 b=owEBbQKS/ZANAwAKAUiKpW6lUN52AcsmYgBqrVoNJc0tLJLigSJK8+SDMzBXW68KS+TnV5rZe
 BPSOSzpD9OJAjMEAAEKAB0WIQRMBWLx2o+linEPEBhIiqVupVDedgUCaq1aDQAKCRBIiqVupVDe
 dgxXD/93dUR0HjLbhmKyCBjxSQr+bhI/napVqz4Y/4UfeJapckbcd1oeVNGdPBXknetIkp+x7XY
 CphjQBXattn/SJcTFAUc3oCTzSf90AcGwEfuweGQPmIsg7wm3D04vnOiTbRGEDqNafge3skFB2h
 qEoemtsDQd59QkX6p5vbz+JClYbRcYwJ1x4MmM/IHPHm5Ly/llr6N26JZqi/L7lXaJxGd7n5i2Z
 ZjkOP4dePJl7twhKKJeAidEUENzFkHR2de2YGhlL4eaLYGKc84ooHUX8gW4UrjQYYaRx2UTtuo7
 xt5ddtYcyhei2SnnRSke7NKz5i4qOKYVRSGGYYQm3lULfkIKvT6Bu7fbLrC8aXBv1Wacc9GkiOj
 3Jx5kAWqYtD/czLze/KKs0risNR+lTKAiYj7sTX17g7D2bZBLer5WBgQaRv/sVL1Nhv6c3h6b3c
 GtrMqq7ySaNTbqk5t+9XZLnmbHWQRXSS/nnrDmaTqCN1xWPtsd7szO8n07GPMnS9zsYC0JIVGY9
 PhZpQDyndz5me6J4Zl4h4rVcHuJVg4JQPIZF1qkm1XD3jfQIYQc6AMMkYIgHGL9sKQXulFLmUvf
 RrY6cCQW75JjUnUyO4PHRy0Wps4R+t3ilW3E0QmHf33JR42h+Q7WkjRxSxK4t7jwOSk4l3lk//b
 2Lu1kxggEbsw/Gw==
X-Developer-Key: i=antikostya2@gmail.com; a=openpgp;
 fpr=4C0562F1DA8FA58A710F1018488AA56EA550DE76
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=antikostya2@gmail.com; helo=mail-lf1-x129.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

According to "RISC-V N-Trace (Nexus-based Trace) Specification" 1.0 and
"Efficient Trace for RISC-V Version 2.0" we should emit
Ownership and ppccd messages, if it's change of privilege mode,
on next instruction after mode change

Signed-off-by: Alexei Filippov <halip0503@gmail.com>
Signed-off-by: Konstantin Semichastnov <antikostya2@gmail.com>
---
 hw/riscv/trace-encoder.c  | 13 +++++++++++--
 hw/riscv/trace-encoder.h  |  2 +-
 target/riscv/cpu_helper.c | 11 ++---------
 target/riscv/op_helper.c  |  8 ++++++++
 4 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index 1d04ab0668..a2a030bb83 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -943,15 +943,24 @@ static void trencoder_trace_ppccd(Object *trencoder_obj, uint64_t pc)
     trencoder_send_sync_msg(trencoder_obj, pc);
 }
 
-void trencoder_trace_priv_change(Object *trencoder_obj, uint64_t pc,
+void trencoder_trace_priv_change(Object *trencoder_obj, hwaddr curr_pc,
                                  uint8_t newpiv)
 {
+    if (!trencoder_obj) {
+        return;
+    }
+
     TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
+    uint8_t prev_priv = trencoder->cpu->env.priv;
+
+    if (!trencoder->trace_running || newpiv == prev_priv) {
+        return;
+    }
 
     if (trencoder->ntrace && ARRAY_FIELD_EX32(trencoder->regs, TR_TE_CONTROL, CONTEXT)) {
         trencoder_send_ownership_msg(trencoder, FORMAT_PRIV_CHANGE, newpiv);
     } else if (!trencoder->ntrace) {
-        trencoder_trace_ppccd(trencoder_obj, pc);
+        trencoder_trace_ppccd(trencoder_obj, curr_pc);
     }
 }
 
diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h
index 34177a64bd..9d2f1c162e 100644
--- a/hw/riscv/trace-encoder.h
+++ b/hw/riscv/trace-encoder.h
@@ -101,7 +101,7 @@ void trencoder_send_indirect_branch_hist(TraceEncoder *trencoder,
 void trencoder_trace_trap_insn(Object *trencoder_obj, uint64_t curr_pc,
                                uint64_t target_pc, uint32_t ecause,
                                bool is_interrupt, uint64_t tval);
-void trencoder_trace_priv_change(Object *trencoder_obj, uint64_t pc,
+void trencoder_trace_priv_change(Object *trencoder_obj, hwaddr curr_pc,
                                  uint8_t newpiv);
 void trencoder_report_updiscon(Object *trencoder_obj);
 void trencoder_report_branch(Object *trencoder_obj, uint64_t pc,
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 912aa24f54..8aac23b400 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1043,15 +1043,6 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en)
             riscv_itrigger_update_priv(env);
         }
 
-        if (newpriv != env->priv) {
-            RISCVCPU *cpu = RISCV_CPU(cs);
-
-            if (cpu->trencoder &&
-                TRACE_ENCODER(cpu->trencoder)->trace_running) {
-                trencoder_trace_priv_change(cpu->trencoder, env->pc, newpriv);
-            }
-        }
-
         riscv_pmu_update_fixed_ctrs(env, newpriv, virt_en);
     }
 
@@ -2388,6 +2379,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                                       env->scause, async, env->stval);
         }
 
+        trencoder_trace_priv_change(cpu->trencoder, env->sepc, PRV_S);
         riscv_cpu_set_mode(env, PRV_S, virt);
 
         src = env->sepc;
@@ -2480,6 +2472,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                                       env->mcause, async, env->mtval);
         }
 
+        trencoder_trace_priv_change(cpu->trencoder, env->mepc, PRV_M);
         riscv_cpu_set_mode(env, PRV_M, virt);
         src = env->mepc;
     }
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 6ccc127c30..12fb0209f6 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -29,6 +29,8 @@
 #include "trace.h"
 
 #ifndef CONFIG_USER_ONLY
+#include "hw/riscv/trace-encoder.h"
+
 static inline MemOp mo_endian_env(CPURISCVState *env)
 {
     /*
@@ -289,6 +291,8 @@ target_ulong helper_sret(CPURISCVState *env)
     target_ulong prev_priv, prev_virt = env->virt_enabled;
     const target_ulong src_priv = env->priv;
     const bool src_virt = env->virt_enabled;
+    CPUState *cs = env_cpu(env);
+    RISCVCPU *cpu = RISCV_CPU(cs);
 
     if (!(env->priv >= PRV_S)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
@@ -349,6 +353,7 @@ target_ulong helper_sret(CPURISCVState *env)
         }
     }
 
+    trencoder_trace_priv_change(cpu->trencoder, env->pc, prev_priv);
     riscv_cpu_set_mode(env, prev_priv, prev_virt);
 
     /*
@@ -410,6 +415,8 @@ target_ulong helper_mret(CPURISCVState *env)
     uint64_t mstatus = env->mstatus;
     target_ulong prev_priv = get_field(mstatus, MSTATUS_MPP);
     uintptr_t ra = GETPC();
+    CPUState *cs = env_cpu(env);
+    RISCVCPU *cpu = RISCV_CPU(cs);
 
     check_ret_from_m_mode(env, retpc, prev_priv, ra);
 
@@ -436,6 +443,7 @@ target_ulong helper_mret(CPURISCVState *env)
         riscv_cpu_swap_hypervisor_regs(env);
     }
 
+    trencoder_trace_priv_change(cpu->trencoder, env->pc, prev_priv);
     riscv_cpu_set_mode(env, prev_priv, prev_virt);
     /*
      * If forward cfi enabled for new priv, restore elp status

-- 
2.43.0


