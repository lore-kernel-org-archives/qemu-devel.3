Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BA9C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wysR0-0000he-1r; Tue, 25 Aug 2026 10:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1wys31-0002xp-OX
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:22:44 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1wys2z-0002Cv-Qz
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:22:43 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-39c8ee87f7eso50341301fa.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 07:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787667760; x=1788272560; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X1ShuPzo9HjlF0LASxGXhgjJp4my/PBrBzxPZau8+fc=;
 b=lH/0Hcdr1ExnGfVNdZ96KH5hU27Ha1MYXqRhTTmpU7A9ff1OpUzPMvKPEtmPQCvf3Z
 4SEczx9I4lbkXPMNZnMOhWh1pZHrrPkG8pR5thKf9TIALNuQTo8k3N7HhZch+RIYMAa+
 RvpNZmm4Z+Xu53UvQ+y8+J82Y927S7hufCtn8eC8xhXpoqAFKHwyzYr2fZQsJFGGnNfb
 xrPuCbGs6TtEsIGxok2fGrBMip4syJGa5ZKYDDjyodVreeFFUaBlqsYtfByRP3+6hOwG
 bUOe61jGztj4eungp6cy5/4kI/veSUqXxUr63WASoB/yO45Rn+O0Hk2cXyhZwzr6pLps
 UG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787667760; x=1788272560;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X1ShuPzo9HjlF0LASxGXhgjJp4my/PBrBzxPZau8+fc=;
 b=UyKmEakUPNHSe6bQTvLa/JfjvzjDeVaJfmHnduvxkbbxLPRNzEgzZ+YThqZCzgCE7c
 WJz1K7U3FkkSeJehf8q/tI6enTWHVb42BFYHpBvokI+SPk6GkJHNJlUriRey+/mJ7GZs
 ggi/ayTylAsbkmwmJIfp1waY5c6IyMZuFspX3Fz3cgRpErjR9alu5aqdOScevCcEDN01
 jWcbbD2cVXzcn6WjlxmvF3Ed6Ei0z609E3MYE0Qi4VwQtFyEQio6cgmw2EVZifWEoSzY
 NHA4b57Hng9YU9LiYnCOHOT/qzOZMypMFj57/BSSt0rAINoFC+uMWbBdLm7RDkvttgxq
 O2XA==
X-Gm-Message-State: AFuF++kljjwLviBmg6bV7ipbSQCrKW3E+QFKGK+BpqSAoT/kZ+n5aG3q
 Uu2d3FPUb2zWnVT6zqjnjXsb2ub/EP7Q0uzW7s4iheVfdIoyQPVeuxLI0fykJa3k
X-Gm-Gg: AR+sD12001ppFtT4hOERyg+pwoTD7ACL1YCA99CZRGmsOHC/SZTdoJcyBfQt9vg/4qf
 y0+1c9x4oUp1fMKyrjt24EtX4UvGqe2/OOVShHE0HpYOpRqW86mTwR0epRX0dAwghR7jvcvyyZD
 peN8Y1M/w6c9Kk7+OId+XLJJfjCl8+vAqC5qLCTdfSbAy9qmn1TwJEMaIVTKZMVhM++/jQE/CDk
 AYcasxB79jziVClyRVvhiEphE0fj2P9pEbpiDOAUUhnSRMim85ZTdT/sksuBXM4cYFBFxhN9Eep
 s2ZdrMSEYDfOFO7icMSl5fOG+EXQcamGazS/Zd2bl+ku19Rd7Q/oe4kaWIqOm6ulF6OR/ttnyzC
 U7eYj0CWBOOsUvoIIrdkENzOAXpka2smT5sEQGfog8zw1lIwG+JpvNkksqRl+kGcsbMIlScBVzf
 xdj30VT+DXPQEN3+0h/P87AxiZINuqhi4T6AnvEsNPyCmUS45cAe+OVEk+D+9xjO9hm2BN30+YP
 PUq46208XlIPfKHBvMYo/RNLkBrwQ==
X-Received: by 2002:a05:651c:a10c:20b0:3a1:476:74b3 with SMTP id
 38308e7fff4ca-3a1ef5d54f3mr11709671fa.9.1787667759955; 
 Tue, 25 Aug 2026 07:22:39 -0700 (PDT)
Received: from [127.0.1.1] (broadband-90-154-73-22.ip.moscow.rt.ru.
 [90.154.73.22]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a1c82f6b02sm22457551fa.41.2026.08.25.07.22.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 07:22:38 -0700 (PDT)
From: Konstantin Semichastnov <antikostya2@gmail.com>
Date: Tue, 25 Aug 2026 17:22:31 +0300
Subject: [PATCH 07/13] hw/riscv/trace-encoder: add interrupt support to
 N-Trace encoder
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-upstream-ntrace_core-v1-7-f8be2f40d2fd@gmail.com>
References: <20260825-upstream-ntrace_core-v1-0-f8be2f40d2fd@gmail.com>
In-Reply-To: <20260825-upstream-ntrace_core-v1-0-f8be2f40d2fd@gmail.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alexei Filippov <halip0503@gmail.com>, 
 Konstantin Semichastnov <antikostya2@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6840; i=antikostya2@gmail.com; 
 h=from:subject:message-id;
 bh=Ukz5rO4kftJNVrzk2svX+D1y5ayKYJclAQ/Alkbj5bY=; 
 b=owEBbQKS/ZANAwAKAUiKpW6lUN52AcsmYgBqjaUjnhy1lMxBT9QoVd4Lm8IvUTtTcGNiOIiDb
 BmwEYqA5bCJAjMEAAEKAB0WIQRMBWLx2o+linEPEBhIiqVupVDedgUCao2lIwAKCRBIiqVupVDe
 drqED/0ZjAmU/TOK2TRatFw2qkrrpIVjmn/IbERQrSYwzMxEZMPCHPy1C99y0qEzZt1JyGUTP73
 wqEi20vmh/2EN1cn1jI4tjIWGBrgvPKRXEj8Q0SkU/ttCucMMrVUl2c7tXgQwpCSejndELnRuee
 +xb15nS+DCP48ZVJ+LIgi1Uh18YUJNVo7B0R+qM/l8jYtkCkL5wyKrsaebzaT0piLKbLGxxiuBF
 c6txsYkGf0gy7Ergcc7gweZCOV8X2IsoFUy2BDU95Vehterett96VK9Tpi/Ark4wZM9UsIVZK1J
 a3EvJc3djwgCjWFHj78L7Gk/WAZaOfndNPYviN1NPmWyrU4RhkDmhikj0wpHFxJFS/Lwv+nTzQK
 vwPTMBxPNpJPEJvwJApaaGd8U0rfxuIbwKOnKuX6jE9RBSWdKzm0zpbSHda1tP5BonECi9SO/F8
 V4+IKVLawNd4bR/nghc9Wr+xJnJX72mOJcGCx+hJtoLAIdkiWi9qJGoNuV2ykAV9+REhJdj9oMm
 YVLfPpRBF3HitCIMSDx8Ie8FiCGpNYA7E7I7zFh8NxsCy+EDHdRnZXEDJMVuQFr86oc/EU4wFRr
 LOtJAtk9mbXIH7NtTocrFckuWoiHtjz2sRGQhLUFkqvc92AAdC31BhJCT12MbxfX3g4l9mKq2Hf
 mHIstLgJCvHCvJw==
X-Developer-Key: i=antikostya2@gmail.com; a=openpgp;
 fpr=4C0562F1DA8FA58A710F1018488AA56EA550DE76
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=antikostya2@gmail.com; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 25 Aug 2026 10:47:29 -0400
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

Now IndirectBranchHist messages sent not only when branch executed,
but also when exceptino or trap happen.

Signed-off-by: Konstantin Semichastnov <antikostya2@gmail.com>
---
 disas/riscv.c             |  2 +-
 disas/riscv.h             |  2 ++
 hw/riscv/trace-encoder.c  | 36 +++++++++++++++++++++++++++++-------
 hw/riscv/trace-encoder.h  |  7 +++----
 target/riscv/cpu_helper.c | 21 ++++++++++++---------
 5 files changed, 47 insertions(+), 21 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 85cd2a9c2a..541fc93e0a 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -5058,7 +5058,7 @@ static bool check_constraints(rv_decode *dec, const rvc_constraint *c)
 
 /* instruction length */
 
-static size_t inst_length(rv_inst inst)
+size_t inst_length(rv_inst inst)
 {
     /* NOTE: supports maximum instruction size of 64-bits */
 
diff --git a/disas/riscv.h b/disas/riscv.h
index d211700cb2..c14c159103 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -306,4 +306,6 @@ enum {
 #define rv_fmt_rd2_imm                "O\t0,2,(1),i"
 #define rv_fmt_fli                    "O\t3,h"
 
+size_t inst_length(rv_inst inst);
+
 #endif /* DISAS_RISCV_H */
diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index fafafb7b9b..face6f83b7 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -22,6 +22,8 @@
 #include "cpu.h"
 #include "hw/riscv/trace-ram-sink.h"
 #include "rv-trace-messages.h"
+#include "system/dma.h"
+#include "disas/riscv.h"
 
 /*
  * Size of header + payload since we're not sending
@@ -229,6 +231,23 @@ static uint64_t trencoder_te_ctrl_prew(RegisterInfo *reg, uint64_t val)
     return val;
 }
 
+static uint32_t get_inst_len_at(uint64_t pc)
+{
+    bfd_byte packet[2];
+    uint16_t opcode;
+    MemTxResult status;
+
+    status = dma_memory_read(&address_space_memory, pc, packet, 2,
+                             MEMTXATTRS_UNSPECIFIED);
+    if (status != MEMTX_OK) {
+        error_setg(&error_fatal, "failed to read instruction during trace operation");
+    }
+
+    opcode = bfd_getl16(packet);
+
+    return inst_length(opcode);
+}
+
 static void trencoder_te_ctrl_postw(RegisterInfo *reg, uint64_t val)
 {
     TraceEncoder *te = TRACE_ENCODER(reg->opaque);
@@ -639,10 +658,9 @@ static uint32_t rv_ntrace_get_and_reset_icnt(TraceEncoder *trencoder,
     return icnt;
 }
 
-void trencoder_trace_trap_insn(Object *trencoder_obj,
-                               uint64_t pc, uint32_t ecause,
-                               bool is_interrupt,
-                               uint64_t tval)
+void trencoder_trace_trap_insn(Object *trencoder_obj, uint64_t curr_pc,
+                               uint64_t target_pc, uint32_t ecause,
+                               bool is_interrupt, uint64_t tval)
 {
     TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
     TracePrivLevel priv = trencoder_get_curr_priv_level(trencoder);
@@ -650,15 +668,19 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,
     uint8_t msg_size;
 
     if (trencoder->ntrace) {
-        /* send IndirectBranchHist message */
+        uint32_t curr_inst_len = get_inst_len_at(curr_pc);
+        uint32_t btype = is_interrupt ? BTYPE_INTERRUPT : BTYPE_EXCEPTION;
+
+        trencoder_send_indirect_branch_hist(trencoder, curr_pc, curr_inst_len,
+                                            target_pc, btype);
         return;
     }
 
     if (trencoder->updiscon_pending) {
-        trencoder_send_updiscon(trencoder, pc);
+        trencoder_send_updiscon(trencoder, curr_pc);
     }
 
-    msg_size = rv_etrace_gen_encoded_trap_msg(msg, pc, priv,
+    msg_size = rv_etrace_gen_encoded_trap_msg(msg, curr_pc, priv,
                                               ecause, is_interrupt,
                                               tval);
 
diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h
index f8a6a254dc..d1ff813035 100644
--- a/hw/riscv/trace-encoder.h
+++ b/hw/riscv/trace-encoder.h
@@ -74,10 +74,9 @@ void trencoder_send_indirect_branch_hist(TraceEncoder *trencoder,
                                          uint32_t curr_inst_len,
                                          uint64_t target_pc,
                                          TraceBranchType btype);
-void trencoder_trace_trap_insn(Object *trencoder_obj,
-                               uint64_t pc, uint32_t ecause,
-                               bool is_interrupt,
-                               uint64_t tval);
+void trencoder_trace_trap_insn(Object *trencoder_obj, uint64_t curr_pc,
+                               uint64_t target_pc, uint32_t ecause,
+                               bool is_interrupt, uint64_t tval);
 void trencoder_trace_ppccd(Object *trencoder_obj, uint64_t pc);
 void trencoder_report_updiscon(Object *trencoder_obj);
 void trencoder_report_branch(Object *trencoder_obj, uint64_t pc,
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 665aad6dea..9b7df4d4fd 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -2300,15 +2300,6 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                   __func__, env->mhartid, async, cause, env->pc, tval,
                   riscv_cpu_get_trap_name(cause, async));
 
-    if (cpu->trencoder) {
-        TraceEncoder *te = TRACE_ENCODER(cpu->trencoder);
-
-        if (te->trace_running) {
-            trencoder_trace_trap_insn(cpu->trencoder, env->pc,
-                                      cause, async, tval);
-        }
-    }
-
     mode = env->priv <= PRV_S && cause < 64 &&
         (((deleg >> cause) & 1) || s_injected || vs_injected) ? PRV_S : PRV_M;
 
@@ -2391,6 +2382,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         env->htinst = tinst;
         env->pc = (env->stvec >> 2 << 2) +
                   ((async && (env->stvec & 3) == 1) ? cause * 4 : 0);
+
+        if (cpu->trencoder && TRACE_ENCODER(cpu->trencoder)->trace_running) {
+            trencoder_trace_trap_insn(cpu->trencoder, env->sepc, env->pc,
+                                      env->scause, async, env->stval);
+        }
+
         riscv_cpu_set_mode(env, PRV_S, virt);
 
         src = env->sepc;
@@ -2477,6 +2474,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
             env->pc = (env->mtvec >> 2 << 2) +
                       ((async && (env->mtvec & 3) == 1) ? cause * 4 : 0);
         }
+
+        if (cpu->trencoder && TRACE_ENCODER(cpu->trencoder)->trace_running) {
+            trencoder_trace_trap_insn(cpu->trencoder, env->mepc, env->pc,
+                                      env->mcause, async, env->mtval);
+        }
+
         riscv_cpu_set_mode(env, PRV_M, virt);
         src = env->mepc;
     }

-- 
2.43.0


