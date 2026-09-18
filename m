Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC634C982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 15:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7afk-0006TZ-RK; Fri, 18 Sep 2026 11:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1x7afh-0006T4-Sf
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 11:38:41 -0400
Received: from mail-lf2-x10.google.com ([2a00:1450:4864:36::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1x7afe-0003EG-Ve
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 11:38:41 -0400
Received: by mail-lf2-x10.google.com with SMTP id
 2adb3069b0e04-5b5e4f1801fso961115e87.2
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 08:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789745917; x=1790350717; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tFHhCtGDf0La5i3ESE5+Rob9N9pOyy1dqxOtcNDbMX4=;
 b=mZYdFABUohAG7UZBQA5a2avG205bE3qFMCaKCNHGEVAju+VAIquPXS5sPWfUNm3AzD
 f14nYY7PH+oVvkot8MZy0DqOqXw9SZvQcQ7duZCv1M3PrzckQkt/TRxkM7s6KUlEZrjL
 Z7IaYldLluUwQ1j4x2jK6u1Lzf+Js2oFjRHpAJosDEKDX51svb5s4dwP4EHt8cajtNNT
 cNp2nRT3b+W402uXG1iC4z6DaHV5omXQloI4DpCDP+gmQP2p7Kdz73dtsCUACDoGY1EA
 eD5/rebGC05pU4WPUEONl+bIOhC8o1NZdA8Hp3o7jYKthzCCC5XQZ7lkyNDtlQbmDbLS
 QnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789745917; x=1790350717;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tFHhCtGDf0La5i3ESE5+Rob9N9pOyy1dqxOtcNDbMX4=;
 b=ndHnKIX6fzGPT2NZnF1XLLRXtfrBRZLUbDoWjOrHmArJZuYVoE/R8buk2vmZLSdvPO
 Hfej1HAP8yL0AGbO6kmszBg5FkQz4oGqVh0cT97v1soBEJ1jt2nPMRHlehGXh9YG/3oO
 jKA/yUYRYDP08Ugaziv5dn1VxWQMTu991WCoOTZw6Z67fycpIMP8MGFpeXo3UEddihzx
 LFMN3X+wWIwKrt8edzHw0hcxocq1tHiHzsIkX264u8cBleKdB+tNdVtUfAguVB6HATGd
 y8lYK/yaJwGCvyb7cV071hsLbKU1jwQpjgcQfFsNYO70Wi6ojka4JRN9wAp2JIjqDgWh
 qoBQ==
X-Gm-Message-State: AFuF++lh64+7dX2GMcivjK7KmTDaFj7xKIw4SmMc0AcHW/xQbaVWQLxA
 E0nzrVbxcypv1ggoRnCz4hrF6sKFeb6mOw/0T/L7/S2ZiA12iqeMxFKYM7Sf9FOo
X-Gm-Gg: AYBFou0znWO4hg5vqTWSoZxYe4Pqv7/syaIfSYTpG1kzjdu391AaOIzd0kXrHYeT5s3
 6V6hXKfMDaJFGfNKCT4fMIGo5z+xdkLN6EOZeUP21y2A4qlP84Vu/mY2dw91OLNNgwVtvcezKOE
 4XekEFH9OOPFH5snIRIQWA2n5leR9ZpM9X5E/VB0DGqEaEpH7k+/eygZHObO3mmfJeI+y5NqAUh
 senJIYa28dgTGLx6uXLMNkOTNHKj+joz1gdxni+EcUb3rVQv+iJ8DUGh98oeQMY0vdNEnpEuMor
 G/uEao+fTyBzhzdstRq+ewVZwC92rIsIKDt9toarf5DzdYyeQ700+RhplZNTtpShXx7VVKcXGPd
 2agkM6c4npJbEre4LG++4+FKP0zDZOAlAKWvoMlMZE28XgWDwPQrGa3mYnFy4KYm6rKijN5tuhF
 oCzRnp3FWLfohSPhvrdXGWIj0Dc1GA14TCkNxLnS38sfKoZTigFWdFNnpSXuS4dskXYDdlTwd4P
 i9m4Sg=
X-Received: by 2002:a05:6512:a92:b0:5b6:183b:d207 with SMTP id
 2adb3069b0e04-5b8c185410dmr922815e87.46.1789745917212; 
 Fri, 18 Sep 2026 08:38:37 -0700 (PDT)
Received: from localhost ([213.79.119.14]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a5fd8673aasm5950351fa.34.2026.09.18.08.38.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 08:38:36 -0700 (PDT)
From: Konstantin Semichastnov <antikostya2@gmail.com>
Date: Fri, 18 Sep 2026 18:34:39 +0300
Subject: [PATCH 3/6] hw/riscv/trace-encoder.c: Implement Ownership messages
 for NTrace
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-upstream-ntrace_msg-v1-3-16a56ad8e0ef@gmail.com>
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
 Arseniy Semenov <ar.semenov@outlook.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12668;
 i=antikostya2@gmail.com; h=from:subject:message-id;
 bh=5olOmfExN3JwtgMLEwrbP9zM4esxUEWpE+x6PLSE3q8=;
 b=owEBbQKS/ZANAwAKAUiKpW6lUN52AcsmYgBqrVoN7UCM7FSiF4qUpD5R87Y0ZLVWZKiS/fLcP
 1yotp4hXNqJAjMEAAEKAB0WIQRMBWLx2o+linEPEBhIiqVupVDedgUCaq1aDQAKCRBIiqVupVDe
 dqRKD/9ZaK7NsirQ1g5K6d1HA8n+mdTCqb/QAN88gHCnvmfO0VU88ETUenOPHrM9XMQU+Wu9tGH
 v5Pau2/00eRvm3f67I0RMfHwghrDXTrS6S2Qm69nlB3OuF1ml6SyKq2T3/ytJFZ9f7B2HcBUrgR
 4YOsgB/aLM3RtcVKW9IZ9/bSkibun1dXVCcqfvtBqkliel8GMYJxnxQxzlBpC8dxkaQk3ygt08P
 GehcNHE+QkdW0Obe/vONaIuiOPnasQN4j0hbZ7jtDL40jojL/IMbPLDJIGKR5Adc7H3TNeiyGFz
 kOuqA1iEqLP07ZZZfIOjsVDoxjq0IffHHKusuBGDOcivcLkI//4o03nNBlDQKqyjaj7Sq35i7PR
 wt75bpTiDO++jqBFjMLGsiwjuMnbmU+IB86KEWn7/y/5d5H3P6+Iw9cDl7AbnVId8w9sfJ7yZkw
 /XeuAlDAIXVHabOL0H6hNoUBwHCNci23frYWLBiuPKV3PZOxFjs21ux8wpXwjR7Lt9+EnEwD73F
 +l7TxG2W0eiK0rkOAHfkLM0MQyEYDpTh7F3qdKqFO0/dsF7kS6y/8t0+IoinMtSEWJ+bOO5Gjex
 morO/3NXFJWHh/tN4Rex5pW9Ich6Z62jaqNFjfywFEjNBsM8iT1qBtuE/USM1rwfa3XYNrS1sqC
 S2DStPRHcdiDJcg==
X-Developer-Key: i=antikostya2@gmail.com; a=openpgp;
 fpr=4C0562F1DA8FA58A710F1018488AA56EA550DE76
Received-SPF: pass client-ip=2a00:1450:4864:36::10;
 envelope-from=antikostya2@gmail.com; helo=mail-lf2-x10.google.com
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

Note: generation of Ownership messages on writes to
scontext and hcontext CSRs will be revisited later

Signed-off-by: Alexei Filippov <halip0503@gmail.com>
---
 hw/riscv/rv-trace-messages.c |  52 +++++++++++++++++++++
 hw/riscv/rv-trace-messages.h |   5 ++
 hw/riscv/trace-encoder.c     | 108 ++++++++++++++++++++++++++++++++++++++++++-
 hw/riscv/trace-encoder.h     |  13 +++++-
 target/riscv/cpu_helper.c    |   2 +-
 5 files changed, 175 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/rv-trace-messages.c b/hw/riscv/rv-trace-messages.c
index 507c5fb7bf..f3647e89dd 100644
--- a/hw/riscv/rv-trace-messages.c
+++ b/hw/riscv/rv-trace-messages.c
@@ -14,6 +14,7 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "trace.h"
+#include "hw/register.h"
 
 typedef enum {
     HEADER_SIZE = 1,
@@ -366,6 +367,7 @@ typedef enum {
 
 typedef enum {
     TCODE_PROG_TRACE_SYNC           = 0x9,
+    TCODE_OWNERSHIP                 = 0x2,
     TCODE_PROG_TRACE_CORRELATION    = 0x21,
     TCODE_RESOURCE_FULL             = 0x1b,
     TCODE_INDIRECT_BRANCH_HIST      = 0x1c,
@@ -391,6 +393,20 @@ typedef struct NTraceFieldPayload {
     uint64_t value;
 } NTraceFieldPayload;
 
+#define REG_MXL64_32(reg, addr)         \
+        REG64(reg ## _MXL_RV64, addr)   \
+        REG32(reg ## _MXL_RV32, addr)
+
+#define REG_FIELD_BY_MXL(reg, field, shift, length, mxl)   \
+        FIELD(reg ## _ ## mxl, field, shift, length)
+
+REG64(NTRACE_PROCESS_PAYLOAD, 0x0)
+    FIELD(NTRACE_PROCESS_PAYLOAD, FORMAT, 0, 2)
+    FIELD(NTRACE_PROCESS_PAYLOAD, PRV, 2, 2)
+    FIELD(NTRACE_PROCESS_PAYLOAD, VIRT, 4, 1)
+    REG_FIELD_BY_MXL(NTRACE_PROCESS_PAYLOAD, CONTEXT, 5, 16, MXL_RV32)
+    REG_FIELD_BY_MXL(NTRACE_PROCESS_PAYLOAD, CONTEXT, 5, 32, MXL_RV64)
+
 #define PAYLOAD_TCODE(val)    \
     {                         \
         .type = FIELD_FIXED,  \
@@ -461,6 +477,27 @@ typedef struct NTraceFieldPayload {
         .value = (val),       \
     }
 
+uint64_t rv_ntrace_gen_process_encode(uint8_t format, uint8_t newpriv,
+                                      uint8_t is_virt, uint64_t context)
+{
+    uint64_t out = 0;
+
+    out = FIELD_DP64(out, NTRACE_PROCESS_PAYLOAD, FORMAT, format);
+    out = FIELD_DP64(out, NTRACE_PROCESS_PAYLOAD, PRV, newpriv);
+    out = FIELD_DP64(out, NTRACE_PROCESS_PAYLOAD, VIRT, is_virt);
+    /* format + priv + virt fields have 5 bit width by the spec */
+    out = (out) | (context << 5);
+
+    return out;
+}
+
+#define PAYLOAD_PROCESS(process_msg, wdth)  \
+    {                                       \
+        .type = FIELD_VAR,                  \
+        .width = (wdth),                    \
+        .value = (process_msg),             \
+    }
+
 #define PAYLOAD_END()      \
     {                      \
         .type = FIELD_END, \
@@ -623,3 +660,18 @@ size_t rv_ntrace_gen_indirect_branch_hist_msg(uint8_t *buf, uint8_t btype,
 
     return rv_ntrace_gen_encoded_msg(buf, msg_fields);
 }
+
+size_t rv_ntrace_gen_ownership_msg(uint8_t *buf, uint64_t process_msg,
+                                   uint32_t process_len)
+{
+
+    const NTraceFieldPayload msg_fields[] = {
+        PAYLOAD_TCODE(TCODE_OWNERSHIP),
+        /* SRC field is not supported for now */
+        PAYLOAD_PROCESS(process_msg, process_len),
+        /* TSTAMP field is not supported for now */
+        PAYLOAD_END(),
+    };
+
+    return rv_ntrace_gen_encoded_msg(buf, msg_fields);
+}
diff --git a/hw/riscv/rv-trace-messages.h b/hw/riscv/rv-trace-messages.h
index c237e6b57c..5b75dc0a7d 100644
--- a/hw/riscv/rv-trace-messages.h
+++ b/hw/riscv/rv-trace-messages.h
@@ -49,5 +49,10 @@ size_t rv_ntrace_gen_indirect_branch_hist_sync_msg(uint8_t *buf, uint8_t btype,
 size_t rv_ntrace_gen_indirect_branch_hist_msg(uint8_t *buf, uint8_t btype,
                                               uint32_t icnt, uint64_t uaddr,
                                               uint32_t hist);
+size_t rv_ntrace_gen_ownership_msg(uint8_t *buf, uint64_t process_msg,
+                                   uint32_t process_len);
+uint64_t rv_ntrace_gen_process_encode(uint8_t format, uint8_t newpriv,
+                                      uint8_t is_virt, uint64_t context);
+
 
 #endif
diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index dfe04781e2..1d04ab0668 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -179,7 +179,6 @@ static uint64_t trencoder_te_ctrl_set_hardwire_vals(uint64_t input)
 {
     input = FIELD_DP32(input, TR_TE_CONTROL, EMPTY, 1);
     input = FIELD_DP32(input, TR_TE_CONTROL, INST_MODE, 0x6);
-    input = FIELD_DP32(input, TR_TE_CONTROL, CONTEXT, 0);
     input = FIELD_DP32(input, TR_TE_CONTROL, INST_TRIG_ENABLE, 0);
     input = FIELD_DP32(input, TR_TE_CONTROL, INST_STALL_OR_OVERFLOW, 0);
     input = FIELD_DP32(input, TR_TE_CONTROL, INST_STALL_ENA, 0);
@@ -550,6 +549,7 @@ void trencoder_send_indirect_branch_hist(TraceEncoder *trencoder,
 {
     g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
     uint8_t msg_size;
+    bool send_ownership = false;
 
     uint32_t icnt = rv_ntrace_get_and_reset_icnt(trencoder, curr_pc, curr_inst_len);
     uint64_t uaddr = rv_ntrace_encode_uaddr(trencoder, target_pc);
@@ -564,6 +564,7 @@ void trencoder_send_indirect_branch_hist(TraceEncoder *trencoder,
         msg_size = rv_ntrace_gen_indirect_branch_hist_sync_msg(msg, btype, icnt,
                                                                faddr, hist);
         trencoder->sync_cnt = 0;
+        send_ownership = true;
     } else {
         msg_size = rv_ntrace_gen_indirect_branch_hist_msg(msg, btype, icnt, uaddr,
                                                           hist);
@@ -572,6 +573,97 @@ void trencoder_send_indirect_branch_hist(TraceEncoder *trencoder,
     trencoder->last_icnt_reset = target_pc;
 
     trencoder_send_message_smem(trencoder, msg, msg_size);
+
+    if (send_ownership && ARRAY_FIELD_EX32(trencoder->regs, TR_TE_CONTROL,
+                                           CONTEXT)) {
+        trencoder_send_ownership_msg(trencoder, FORMAT_SYNC_HCONTEXT,
+                                     trencoder->cpu->env.priv);
+        trencoder_send_ownership_msg(trencoder, FORMAT_SYNC_SCONTEXT,
+                                     trencoder->cpu->env.priv);
+    }
+}
+
+static uint64_t rv_ntrace_context_encode(TraceEncoder *trencoder,
+                                         uint64_t *context_msg,
+                                         NTraceOwnershipFormat format)
+{
+    RISCVCPU *cpu = trencoder->cpu;
+    CPURISCVState *env = &cpu->env;
+    uint64_t context;
+    uint32_t len;
+
+    switch (format) {
+    case FORMAT_PRIV_CHANGE:
+        break;
+    case FORMAT_SYNC_SCONTEXT:
+        /* Specification suggest 16 bits scontext for rv32 and 32 for rv64 */
+        context = 0;
+        len = 16 * riscv_cpu_mxl(env);
+        break;
+    case FORMAT_SYNC_HCONTEXT:
+        /* Specification suggest 7 bits hcontext for rv32 and 14 for rv64 */
+        context = 0;
+        len = 7 * riscv_cpu_mxl(env);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    *context_msg = context;
+
+    return len;
+}
+
+static uint32_t rv_ntrace_process_encode(TraceEncoder *trencoder,
+                                         NTraceOwnershipFormat format,
+                                         uint8_t newpriv, uint8_t is_virt,
+                                         uint64_t context_msg,
+                                         uint32_t context_len,
+                                         uint64_t *process_msg)
+{
+    *process_msg = rv_ntrace_gen_process_encode(format, newpriv, is_virt, context_msg);
+
+    /* According to Ntrace spec fields V + PRV + FORMAT should always be 5 bits length */
+    return context_len + 5;
+}
+
+void trencoder_send_ownership_msg(TraceEncoder *trencoder,
+                                  NTraceOwnershipFormat format, uint8_t newpriv)
+{
+    g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
+    uint64_t context_msg, process_msg;
+    uint8_t msg_size;
+
+    g_assert(trencoder->ntrace);
+
+    /* By the Ntrace specification process len is format + priv + virt, which
+     * is always 5 bit len plus context field.
+     */
+    uint32_t context_len = rv_ntrace_context_encode(trencoder, &context_msg,
+                                                    format);
+    /* V mode is not supported(0) for now */
+    uint32_t process_len = rv_ntrace_process_encode(trencoder, format,
+                                                    newpriv, 0, context_msg,
+                                                    context_len, &process_msg);
+
+    msg_size = rv_ntrace_gen_ownership_msg(msg, process_msg, process_len);
+
+    trencoder_send_message_smem(trencoder, msg, msg_size);
+}
+
+void trencoder_send_ownership_scontext_msg(Object *trencoder_obj)
+{
+    TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
+
+    if (!trencoder_obj) {
+        return;
+    }
+
+    if (trencoder->ntrace  &&
+        ARRAY_FIELD_EX32(trencoder->regs, TR_TE_CONTROL, CONTEXT)) {
+        trencoder_send_ownership_msg(trencoder, FORMAT_SYNC_SCONTEXT,
+                                     trencoder->cpu->env.priv);
+    }
 }
 
 static void trencoder_send_updiscon(TraceEncoder *trencoder, uint64_t pc)
@@ -840,7 +932,7 @@ void trencoder_report_branch(Object *trencoder_obj, uint64_t pc,
     }
 }
 
-void trencoder_trace_ppccd(Object *trencoder_obj, uint64_t pc)
+static void trencoder_trace_ppccd(Object *trencoder_obj, uint64_t pc)
 {
     TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
 
@@ -851,6 +943,18 @@ void trencoder_trace_ppccd(Object *trencoder_obj, uint64_t pc)
     trencoder_send_sync_msg(trencoder_obj, pc);
 }
 
+void trencoder_trace_priv_change(Object *trencoder_obj, uint64_t pc,
+                                 uint8_t newpiv)
+{
+    TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
+
+    if (trencoder->ntrace && ARRAY_FIELD_EX32(trencoder->regs, TR_TE_CONTROL, CONTEXT)) {
+        trencoder_send_ownership_msg(trencoder, FORMAT_PRIV_CHANGE, newpiv);
+    } else if (!trencoder->ntrace) {
+        trencoder_trace_ppccd(trencoder_obj, pc);
+    }
+}
+
 void trencoder_report_updiscon(Object *trencoder_obj)
 {
     TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h
index 4cfdb47ecf..34177a64bd 100644
--- a/hw/riscv/trace-encoder.h
+++ b/hw/riscv/trace-encoder.h
@@ -77,6 +77,12 @@ typedef enum {
     TR_TE_INST_SYNC_MODE_INST   = 3,
 } TraceSyncMode;
 
+typedef enum {
+    FORMAT_PRIV_CHANGE          = 0,
+    FORMAT_SYNC_SCONTEXT        = 0b10,
+    FORMAT_SYNC_HCONTEXT        = 0b11,
+} NTraceOwnershipFormat;
+
 #define TYPE_TRACE_ENCODER "trace-encoder"
 
 OBJECT_DECLARE_SIMPLE_TYPE(TraceEncoder, TRACE_ENCODER)
@@ -95,10 +101,13 @@ void trencoder_send_indirect_branch_hist(TraceEncoder *trencoder,
 void trencoder_trace_trap_insn(Object *trencoder_obj, uint64_t curr_pc,
                                uint64_t target_pc, uint32_t ecause,
                                bool is_interrupt, uint64_t tval);
-void trencoder_trace_ppccd(Object *trencoder_obj, uint64_t pc);
+void trencoder_trace_priv_change(Object *trencoder_obj, uint64_t pc,
+                                 uint8_t newpiv);
 void trencoder_report_updiscon(Object *trencoder_obj);
 void trencoder_report_branch(Object *trencoder_obj, uint64_t pc,
                              uint64_t insn_len, uint64_t offset,
                              TraceBranchRes taken);
-
+void trencoder_send_ownership_msg(TraceEncoder *trencoder,
+                                  NTraceOwnershipFormat value, uint8_t newpiv);
+void trencoder_send_ownership_scontext_msg(Object *trencoder_obj);
 #endif
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 9b7df4d4fd..912aa24f54 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1048,7 +1048,7 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en)
 
             if (cpu->trencoder &&
                 TRACE_ENCODER(cpu->trencoder)->trace_running) {
-                trencoder_trace_ppccd(cpu->trencoder, env->pc);
+                trencoder_trace_priv_change(cpu->trencoder, env->pc, newpriv);
             }
         }
 

-- 
2.43.0


