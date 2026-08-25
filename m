Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA79C61DC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wysR7-0000l0-6n; Tue, 25 Aug 2026 10:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1wys31-0002xm-5F
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:22:44 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1wys2y-0002Ch-EG
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:22:42 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-39c95395230so43290331fa.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 07:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787667759; x=1788272559; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+2Mr/ipwE4dzTL4NJo11V6O3s9hJ8jNTodoTedhmPBg=;
 b=KVbX0sHB9VJ8jiwTS8p3OizFNTY1V+3fQKOJwD+bsMpLE0vzRL02OP41HxuJL00ab8
 SMYFucPGjHZl3MpZdCW9TZ9sPsxBUoX8vWtWOHnQHod1HjcyUU3mDH3Hnx/Z8ooBzMsa
 xehs80kOjQcsG9YsEiJgSUVe3OS6Ih7tjRwcCq8Jhn/gMhqQRcfeB/n4juUwOjMTttO6
 Tdmf9NwagM7jZBVBKILAHbTbOfbDam1zpJ/EoL+ZjTvdm6oTVKYH2DUR+3Y2l0Dv6dxM
 xsshf1FR54/nykrksbhIpQvEK3KeeMyD4EhbFqw0hvVUzPLNgrBWlrdKzOXbq0q/ogMa
 hkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787667759; x=1788272559;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+2Mr/ipwE4dzTL4NJo11V6O3s9hJ8jNTodoTedhmPBg=;
 b=jSW9mGdFL7N3wthHEYk0FGhov1vCL/e8bL/5tN2NWk4Jrjer1CwiVWY/TxGCFH+mZc
 6j73yUHADBSjqkijqUUoqFXQJNnLwBHe1f5VOn2bXSdeTxVZV508m5KwTaRXruA7EJDI
 uTxT0DXVdGI5p4iA/+rwCzzNpomZQRoLj1nCulPjMKPiEFNRCSTfKi3f4FSObdGU/dow
 hbCEPwr3s4qU5HJocYDdU5mpyV6o8tkItLgoikx667M2WI91iGHp13ndhsRdSc0jpcv9
 a4jJYD05LNJSV/YG41CXiQNnw86V8vh6YC4HFd6pSNSOqrxhEQ7wVjcP+GFwMt0gTSyW
 MArA==
X-Gm-Message-State: AFuF++ll2wMK0JOuie7hepZsk9w+ZB7WMWAg8pkN3I9oo9VRc933AkSi
 nIOlFx4/RJNVHWjqzGV4CNOIDbxJu8x52YvR80i6zss+TR25d2BuK0gj
X-Gm-Gg: AR+sD10LPVq8kHKYV59AhRBt4JAF9FDM7SrCDcBBWKjcbv/z7fdscxQ+xrNbYvMHS1y
 glIMYkfc0lQ3XGyhFwIS/apIvFwx3uj3Q8xovh81FbagVB3HCx8u+dnfXPjSYmAalbIj3lxjjBg
 MiT9AyXMqe/j0zlFnAFZoDUcQ/lo1CFD+jMgIRHeuTBzv0pgGFHcddSKpDMLG6NbQRTE2jGJiq/
 cSioivwjB1n7oJJwkZGIeWhcYclkyQId5wgXHrWnrlw0vP1tv0WjJpE/JftGA/K9Zzv4dJJKKWD
 9hd8dSu+3+0El9T52zZbXt/Kr9BuSsUXYT1WeWxMuTOZQ92OIsiUnbkeb6m6HmzP6mYjXzvjlhJ
 dCeEbvLQ6dthG/X3b9lnToQ2PHNQY6bXlcbC3XbGekIJqT3YxobbDGTQ4TKtFKk0lLPZfwHhZGw
 2AL5G/N863B6c0fHFNasC55UIsteabyA2cwIXSNr+7DsXpJ43N22wVGDKDTPn86vf0TMK1/5JSP
 eImiOusoVnXAJO01a6OopWhd65dlw==
X-Received: by 2002:a05:651c:a209:10b0:399:9436:15c8 with SMTP id
 38308e7fff4ca-3a1ef340ca7mr10360901fa.2.1787667758592; 
 Tue, 25 Aug 2026 07:22:38 -0700 (PDT)
Received: from [127.0.1.1] (broadband-90-154-73-22.ip.moscow.rt.ru.
 [90.154.73.22]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a1c82f6b02sm22457551fa.41.2026.08.25.07.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 07:22:37 -0700 (PDT)
From: Konstantin Semichastnov <antikostya2@gmail.com>
Date: Tue, 25 Aug 2026 17:22:30 +0300
Subject: [PATCH 06/13] hw/riscv: add n-trace IndirectBranchHist
 rv-trace-message
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-upstream-ntrace_core-v1-6-f8be2f40d2fd@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9518; i=antikostya2@gmail.com; 
 h=from:subject:message-id;
 bh=1hp3usv2luZh19p8uPxK4gCIjXWkwk4HyYib1VZ6GbE=; 
 b=owEBbQKS/ZANAwAKAUiKpW6lUN52AcsmYgBqjaUjlrgvD1XasY8pmiWsdTAQGo+YOK44EaUbL
 bRX4z+yY8SJAjMEAAEKAB0WIQRMBWLx2o+linEPEBhIiqVupVDedgUCao2lIwAKCRBIiqVupVDe
 drLzEAC0w+Bxyh5Z7uqAYvdPGHSKLANb/+SzI25qaN4W9aIHHKRmjL9a/7ijv9VNE0RidDXJnzF
 Ub1+8Urv9zFCXZx+G9jFp4K9xnkeEwygeMDTJYsjeD/WoDiedLkmshF7QdcjOBt87XAu5pXNtpw
 vPYkGg/fOq5nNPoiwmoxkVu2x9TnQ5xZrhc8vKAgGpsHPp31EndNmujk3XamD6rvE4SbBqAuqts
 WdV2Z+kskezsAW68P9ijEa9k8/8h+ubDfppeGsEfZG/d9kqeGmA+t6aitynnzrYe4Oquw6a9jP5
 oZd9pfYuJuR7/Bety8IdDQmf+X/XegymUlo4UIPy2eSQVY6pVm5j03IA9q9gqO95eDRoQOuyJxK
 t3tYii7kLekuy5qrzdhQzvEk5yLrjO9L/d4g+FYq3ZlF4tnuiQ29+K03zv0VWtBLjAe5NPBoDZW
 EHS4//m3W2QVS+aAb7NnZ8RBQJwUS9bi1qsVnpJhF8LMh39Aj7fba3nKAHpQJavbHgseCRnlQI7
 lG8YrtOFL5Ckm2jGYhBhDMatAtPVvm/NoNbnM3OMGCELa/zzMV14AAifvm5fOau+Qo+NyoVsp97
 rTcxAf74beZ3IDlOoDl3Tw619eoC/Vz+XnbkVufsbPuZxH+9/BU0SB82anYu+7ST05G1Kl6TEfp
 Yl2sdYoBx67w9CQ==
X-Developer-Key: i=antikostya2@gmail.com; a=openpgp;
 fpr=4C0562F1DA8FA58A710F1018488AA56EA550DE76
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=antikostya2@gmail.com; helo=mail-lj1-x235.google.com
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

Add generation, encoding and sending logic for N-Trace
IndirectBranchHist message.

Signed-off-by: Konstantin Semichastnov <antikostya2@gmail.com>
Signed-off-by: Alexei Filippov <halip0503@gmail.com>
---
 hw/riscv/rv-trace-messages.c | 42 +++++++++++++++++++++
 hw/riscv/rv-trace-messages.h |  4 ++
 hw/riscv/trace-encoder.c     | 87 ++++++++++++++++++++++++++++++++++++++++++++
 hw/riscv/trace-encoder.h     | 10 +++++
 target/riscv/trace_helper.c  |  3 +-
 5 files changed, 145 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/rv-trace-messages.c b/hw/riscv/rv-trace-messages.c
index 0b90d6a437..2ee38c4354 100644
--- a/hw/riscv/rv-trace-messages.c
+++ b/hw/riscv/rv-trace-messages.c
@@ -354,12 +354,16 @@ typedef enum {
 typedef enum {
     WIDTH_TCODE  = 6,
     WIDTH_SYNC   = 4,
+    WIDTH_BTYPE  = 2,
     WIDTH_ICNT   = 22,
     WIDTH_FADDR  = 63,
+    WIDTH_UADDR  = 63,
+    WIDTH_HIST   = 32,
 } NTraceFieldWidth;
 
 typedef enum {
     TCODE_PROG_TRACE_SYNC        = 0x9,
+    TCODE_INDIRECT_BRANCH_HIST   = 0x1c,
 } NTraceTcodeFieldValues;
 
 typedef enum {
@@ -387,6 +391,13 @@ typedef struct NTraceFieldPayload {
         .value = (val),      \
     }
 
+#define PAYLOAD_BTYPE(val)    \
+    {                         \
+        .type = FIELD_FIXED,  \
+        .width = WIDTH_BTYPE, \
+        .value = (val),       \
+    }
+
 #define PAYLOAD_ICNT(val)    \
     {                        \
         .type = FIELD_VAR,   \
@@ -400,6 +411,20 @@ typedef struct NTraceFieldPayload {
         .width = WIDTH_FADDR, \
         .value = (val),       \
     }
+
+#define PAYLOAD_UADDR(val)    \
+    {                         \
+        .type = FIELD_VAR,    \
+        .width = WIDTH_UADDR, \
+        .value = (val),       \
+    }
+
+#define PAYLOAD_HIST(val)    \
+    {                        \
+        .type = FIELD_VAR,   \
+        .width = WIDTH_HIST, \
+        .value = (val),      \
+    }
 #define PAYLOAD_END()      \
     {                      \
         .type = FIELD_END, \
@@ -492,3 +517,20 @@ size_t rv_ntrace_gen_encoded_prog_trace_sync_msg(uint8_t *buf, uint64_t faddr)
     return rv_ntrace_gen_encoded_msg(buf, msg_fields);
 }
 
+size_t rv_ntrace_gen_indirect_branch_hist_msg(uint8_t *buf, uint8_t btype,
+                                              uint32_t icnt, uint64_t uaddr,
+                                              uint32_t hist)
+{
+    const NTraceFieldPayload msg_fields[] = {
+        PAYLOAD_TCODE(TCODE_INDIRECT_BRANCH_HIST),
+        /* SRC field is not supported for now */
+        PAYLOAD_BTYPE(btype),
+        PAYLOAD_ICNT(icnt),
+        PAYLOAD_UADDR(uaddr >> 1),
+        PAYLOAD_HIST(hist),
+        /* TSTAMP field is not supported for now */
+        PAYLOAD_END(),
+    };
+
+    return rv_ntrace_gen_encoded_msg(buf, msg_fields);
+}
diff --git a/hw/riscv/rv-trace-messages.h b/hw/riscv/rv-trace-messages.h
index 635e498393..d113129d65 100644
--- a/hw/riscv/rv-trace-messages.h
+++ b/hw/riscv/rv-trace-messages.h
@@ -38,4 +38,8 @@ size_t rv_etrace_gen_encoded_format1(uint8_t *buf,
                                      bool notify, bool updiscon);
 
 size_t rv_ntrace_gen_encoded_prog_trace_sync_msg(uint8_t *buf, uint64_t faddr);
+size_t rv_ntrace_gen_indirect_branch_hist_msg(uint8_t *buf, uint8_t btype,
+                                              uint32_t icnt, uint64_t uaddr,
+                                              uint32_t hist);
+
 #endif
diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index 46501e4f03..fafafb7b9b 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -31,6 +31,11 @@
 
 #define TRACE_MAX_BRANCHES 31
 
+static uint64_t rv_ntrace_encode_uaddr(TraceEncoder *trencoder, uint64_t target_pc);
+static uint32_t rv_ntrace_encode_and_reset_branch_map(TraceEncoder *trencoder);
+static uint32_t rv_ntrace_get_and_reset_icnt(TraceEncoder *trencoder,
+                                             uint64_t pc, uint32_t inst_len);
+
 static TracePrivLevel trencoder_get_curr_priv_level(TraceEncoder *te)
 {
     CPURISCVState *env = &te->cpu->env;
@@ -478,6 +483,28 @@ static void trencoder_send_sync_msg(Object *trencoder_obj, uint64_t pc)
     trencoder_send_message_smem(trencoder, msg, msg_size);
 }
 
+void trencoder_send_indirect_branch_hist(TraceEncoder *trencoder,
+                                         uint64_t curr_pc,
+                                         uint32_t curr_inst_len,
+                                         uint64_t target_pc,
+                                         TraceBranchType btype)
+{
+    g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
+    uint8_t msg_size;
+
+    uint32_t icnt = rv_ntrace_get_and_reset_icnt(trencoder, curr_pc, curr_inst_len);
+    uint64_t uaddr = rv_ntrace_encode_uaddr(trencoder, target_pc);
+    uint32_t hist = rv_ntrace_encode_and_reset_branch_map(trencoder);
+
+    g_assert(trencoder->ntrace);
+
+    msg_size = rv_ntrace_gen_indirect_branch_hist_msg(msg, btype, icnt, uaddr, hist);
+    trencoder->last_addr_reported = target_pc;
+    trencoder->last_icnt_reset = target_pc;
+
+    trencoder_send_message_smem(trencoder, msg, msg_size);
+}
+
 static void trencoder_send_updiscon(TraceEncoder *trencoder, uint64_t pc)
 {
     g_autofree uint8_t *format2_msg = g_malloc0(TRACE_MSG_MAX_SIZE);
@@ -551,6 +578,66 @@ void trencoder_send_prog_trace_sync(Object *trencoder_obj, uint64_t pc)
     trencoder_send_message_smem(trencoder, msg, msg_size);
 }
 
+static uint64_t rv_ntrace_encode_uaddr(TraceEncoder *trencoder, uint64_t target_pc)
+{
+    return trencoder->last_addr_reported ^ target_pc;
+}
+
+static uint32_t rv_ntrace_encode_and_reset_branch_map(TraceEncoder *trencoder)
+{
+    const uint32_t stop_bit = 1;
+
+    uint32_t hist = trencoder->branch_map;
+
+    if (trencoder->branches == 0) {
+        /*
+         * if branches == 0, we will overflow on bit shift, so just return
+         * empty history value here (i.e. - only stop bit)
+         */
+        return stop_bit;
+    }
+
+    /*
+     * trencoder->branch_map stores bit 1 for NOT taken branches,
+     * but N-Trace expects to stored bit 1 for TAKEN branches,
+     * so, we should invert bits
+     */
+    hist = ~hist;
+
+    /*
+     * Also, trencoder->branch_map is implemented in such way,
+     * that oldest branch is LSB bit, but N-Trace format require
+     * to HIST values be in shift-left format: the most recent branch
+     * should be in LSB bit. So we should reverse order
+     * of valid history bits
+     */
+    hist = revbit32(hist) >> (32 - trencoder->branches);
+
+    /* And finally N-Trace expects bit 1 as stop bit at the MSB position */
+    hist = deposit32(hist, trencoder->branches, 1, stop_bit);
+
+    trencoder->branch_map = 0;
+    trencoder->branches = 0;
+
+    return hist;
+}
+
+static uint32_t rv_ntrace_get_and_reset_icnt(TraceEncoder *trencoder,
+                                             uint64_t pc, uint32_t inst_len)
+{
+    uint64_t icnt = (pc + inst_len - trencoder->last_icnt_reset) / 2 +
+                    trencoder->icnt_accumulated;
+
+    trencoder->last_icnt_reset = pc;
+    trencoder->icnt_accumulated = 0;
+
+    if (icnt > MAKE_64BIT_MASK(0, 22)) {
+        /* I-CNT overflow reporting is not supported for now */
+        error_setg(&error_fatal, "N-Trace icnt overflowed");
+    }
+
+    return icnt;
+}
 
 void trencoder_trace_trap_insn(Object *trencoder_obj,
                                uint64_t pc, uint32_t ecause,
diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h
index 6551ac77f9..f8a6a254dc 100644
--- a/hw/riscv/trace-encoder.h
+++ b/hw/riscv/trace-encoder.h
@@ -57,6 +57,11 @@ typedef enum {
     BRANCH_TAKEN_UNCONDITIONAL = 2,
 } TraceBranchRes;
 
+typedef enum {
+    BTYPE_CONTROL_FLOW = 0,
+    BTYPE_EXCEPTION    = 2,
+    BTYPE_INTERRUPT    = 3,
+} TraceBranchType;
 
 #define TYPE_TRACE_ENCODER "trace-encoder"
 
@@ -64,6 +69,11 @@ OBJECT_DECLARE_SIMPLE_TYPE(TraceEncoder, TRACE_ENCODER)
 
 void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc);
 void trencoder_send_prog_trace_sync(Object *trencoder_obj, uint64_t pc);
+void trencoder_send_indirect_branch_hist(TraceEncoder *trencoder,
+                                         uint64_t curr_pc,
+                                         uint32_t curr_inst_len,
+                                         uint64_t target_pc,
+                                         TraceBranchType btype);
 void trencoder_trace_trap_insn(Object *trencoder_obj,
                                uint64_t pc, uint32_t ecause,
                                bool is_interrupt,
diff --git a/target/riscv/trace_helper.c b/target/riscv/trace_helper.c
index f6201e2fb9..d7763a998f 100644
--- a/target/riscv/trace_helper.c
+++ b/target/riscv/trace_helper.c
@@ -36,7 +36,8 @@ void helper_trace_updiscon(CPURISCVState *env, target_ulong curr_pc,
     TraceEncoder *te = TRACE_ENCODER(cpu->trencoder);
 
     if (te->ntrace) {
-        /* send IndirectBranchHist message */
+        trencoder_send_indirect_branch_hist(te, curr_pc, curr_inst_len, env->pc,
+                                            BTYPE_CONTROL_FLOW);
     } else {
         te->updiscon_pending = true;
         te->trace_next_insn = true;

-- 
2.43.0


