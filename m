Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3959CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 16:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9nla-0007rM-EN; Fri, 17 Oct 2025 12:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <k.semichastnov@syntacore.com>)
 id 1v9m1v-000436-DG; Fri, 17 Oct 2025 11:06:08 -0400
Received: from m.syntacore.com ([178.249.69.228])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <k.semichastnov@syntacore.com>)
 id 1v9m1i-0005Nu-6A; Fri, 17 Oct 2025 11:06:04 -0400
Received: from MRN-SC-KSMG-01.corp.syntacore.com (localhost [127.0.0.1])
 by m.syntacore.com (Postfix) with ESMTP id 3EB2A1A0004;
 Fri, 17 Oct 2025 15:05:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 m.syntacore.com 3EB2A1A0004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com; s=m;
 t=1760713540; bh=DTFS90AP3/VP9hxdygjMUjRKJkCvMbeeSBjLdW57QCY=;
 h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:From:From;
 b=ABekka0eDqG7RGDc3KtFHQd5cRmjK8tPCRUBBIV3tLr0aze+qiyxs/q4EOrUhW4Ug
 Ll5GW9WJpPfOzozlmalKWA5MNOxptyFpL8CIk57JBcShdLWFBoVKim3zQKOKVuCST3
 RnrTu9f1gPIdI/mKKzeDQNBTRtCJvmsIyryytyayyproMIJi4PTIBBxCNNnBtk40/a
 qWAUvFHbEaHRZNWhs9XJGprOnqb8q81dXqqBq+vSs03uh4oJM/88DE6fv8LtBR7Y3i
 /Q67CUsJLbvgPUbdIyvmXcotI9BacBYolgVXfBJNxwO1DL8E74HqiF7VfXBJ5XlOsV
 rQzi2ahI8rPUQ==
Received: from S-SC-EXCH-01.corp.syntacore.com (exchange.syntacore.com
 [10.76.202.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by m.syntacore.com (Postfix) with ESMTPS;
 Fri, 17 Oct 2025 15:05:39 +0000 (UTC)
Received: from [172.17.56.115] (172.17.56.115) by
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Oct 2025 18:04:46 +0300
Content-Type: multipart/alternative;
 boundary="------------SL4Gut365lzvxhHNVneUq4uM"
Message-ID: <2e7ac207-5aee-4941-9fe8-91456e1c7ea9@syntacore.com>
Date: Fri, 17 Oct 2025 18:05:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/17] hw/riscv, target/riscv: send resync updiscon trace
 packets
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <alistair.francis@wdc.com>, <liwei1518@gmail.com>,
 <zhiwei_liu@linux.alibaba.com>, <palmer@dabbelt.com>,
 <richard.henderson@linaro.org>, <k.semichastnov@syntacore.com>
References: <20251002112335.2374517-1-dbarboza@ventanamicro.com><20251002112335.2374517-15-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Konstantin Semichastnov <k.semichastnov@syntacore.com>
In-Reply-To: <20251002112335.2374517-15-dbarboza@ventanamicro.com>
X-Originating-IP: [172.17.56.115]
X-ClientProxiedBy: S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) To
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20)
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310,
 bases: 2025/10/17 13:40:00 #27882168
X-KSMG-LinksScanning: NotDetected, bases: 2025/10/17 14:34:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5
Received-SPF: pass client-ip=178.249.69.228;
 envelope-from=k.semichastnov@syntacore.com; helo=m.syntacore.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 17 Oct 2025 12:57:19 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--------------SL4Gut365lzvxhHNVneUq4uM
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit


On 02.10.2025 14:23, Daniel Henrique Barboza wrote:
> Send updiscon packets based on the constraints already discussed in the
> previous patch:
>
> - We do not implement any form of call/return prediction in the encoder,
>    and TCG will always retire a single insn per cycle, e.g. irreport will
>    always be equal to updiscon;
>
> - irdepth is not implemented since we'll always return a  package where
>    irreport == updiscon.
>
> Note that we're sending an updiscon packet if the 'updiscon_pending'
> flag is set when we're about the send a resync or a trap packet. The TCG
> helper in this case is just setting the trace encoder flags instead of
> actually triggering a RAM sink SMEM write.
>
> Signed-off-by: Daniel Henrique Barboza<dbarboza@ventanamicro.com>
> ---
>   hw/riscv/trace-encoder.c                      | 37 +++++++++++++++++++
>   hw/riscv/trace-encoder.h                      |  3 ++
>   target/riscv/helper.h                         |  1 +
>   .../riscv/insn_trans/trans_privileged.c.inc   | 11 ++++++
>   target/riscv/insn_trans/trans_rvi.c.inc       |  2 +
>   target/riscv/trace_helper.c                   | 14 +++++++
>   target/riscv/translate.c                      | 11 ++++++
>   7 files changed, 79 insertions(+)
>
> diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
> index 9a4530bbea..5572483d26 100644
> --- a/hw/riscv/trace-encoder.c
> +++ b/hw/riscv/trace-encoder.c
> @@ -402,6 +402,22 @@ static void trencoder_send_sync_msg(Object *trencoder_obj, uint64_t pc)
>       trencoder_send_message_smem(trencoder, msg, msg_size);
>   }
>   
> +static void trencoder_send_updiscon(TraceEncoder *trencoder, uint64_t pc)
> +{
> +    g_autofree uint8_t *format2_msg = g_malloc0(TRACE_MSG_MAX_SIZE);
> +    uint8_t addr_msb = extract64(pc, 31, 1);
> +    bool notify = addr_msb;
> +    bool updiscon = !notify;
> +    uint8_t msg_size;
> +
> +    msg_size = rv_etrace_gen_encoded_format2_msg(format2_msg, pc,
> +                                                 notify,
> +                                                 updiscon);
> +    trencoder_send_message_smem(trencoder, format2_msg, msg_size);
> +
> +    trencoder->updiscon_pending = false;
> +}
> +
>   void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc)
>   {
>       TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
> @@ -409,6 +425,10 @@ void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc)
>       g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
>       uint8_t msg_size;
>   
> +    if (trencoder->updiscon_pending) {
> +        trencoder_send_updiscon(trencoder, pc);
> +    }
> +
>       trencoder->first_pc = pc;
>       trace_trencoder_first_trace_insn(pc);
>       msg_size = rv_etrace_gen_encoded_sync_msg(msg, pc, priv);
> @@ -426,6 +446,10 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,
>       g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
>       uint8_t msg_size;
>   
> +    if (trencoder->updiscon_pending) {
> +        trencoder_send_updiscon(trencoder, pc);
> +    }
> +
>       msg_size = rv_etrace_gen_encoded_trap_msg(msg, pc, priv,
>                                                 ecause, is_interrupt,
>                                                 tval);
> @@ -435,9 +459,22 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,
>   
>   void trencoder_trace_ppccd(Object *trencoder_obj, uint64_t pc)
>   {
> +    TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
> +
> +    if (trencoder->updiscon_pending) {
> +        trencoder_send_updiscon(trencoder, pc);
> +    }
> +
>       trencoder_send_sync_msg(trencoder_obj, pc);
>   }
>   
> +void trencoder_report_updiscon(Object *trencoder_obj)
> +{
> +    TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
> +
> +    trencoder->updiscon_pending = true;
> +}
> +
>   static const Property trencoder_props[] = {
>       /*
>        * We need a link to the associated CPU to
> diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h
> index 2bf07c01f6..0c44092ccb 100644
> --- a/hw/riscv/trace-encoder.h
> +++ b/hw/riscv/trace-encoder.h
> @@ -36,6 +36,8 @@ struct TraceEncoder {
>       uint32_t regs[TRACE_R_MAX];
>       RegisterInfo regs_info[TRACE_R_MAX];
>   
> +    bool updiscon_pending;
> +
>       bool enabled;
>       bool trace_running;
>       bool trace_next_insn;
> @@ -51,5 +53,6 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,
>                                  bool is_interrupt,
>                                  uint64_t tval);
>   void trencoder_trace_ppccd(Object *trencoder_obj, uint64_t pc);
> +void trencoder_report_updiscon(Object *trencoder_obj);
>   
>   #endif
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index e80320ad16..f27ff319e9 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -131,6 +131,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
>   
>   /* Trace helpers (should be put inside ifdef) */
>   DEF_HELPER_2(trace_insn, void, env, i64)
> +DEF_HELPER_1(trace_updiscon, void, env)
>   
>   #ifndef CONFIG_USER_ONLY
>   DEF_HELPER_1(sret, tl, env)
> diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
> index 8a62b4cfcd..28089539d5 100644
> --- a/target/riscv/insn_trans/trans_privileged.c.inc
> +++ b/target/riscv/insn_trans/trans_privileged.c.inc
> @@ -26,6 +26,8 @@
>   
>   static bool trans_ecall(DisasContext *ctx, arg_ecall *a)
>   {
> +    gen_trace_updiscon();
> +
>       /* always generates U-level ECALL, fixed in do_interrupt handler */
>       generate_exception(ctx, RISCV_EXCP_U_ECALL);
>       return true;
> @@ -40,6 +42,8 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a)
>       uint32_t ebreak = 0;
>       uint32_t post   = 0;
>   
> +    gen_trace_updiscon();
> +
>       /*
>        * The RISC-V semihosting spec specifies the following
>        * three-instruction sequence to flag a semihosting call:
> @@ -95,6 +99,8 @@ static bool trans_sret(DisasContext *ctx, arg_sret *a)
>   {
>   #ifndef CONFIG_USER_ONLY
>       if (has_ext(ctx, RVS)) {
> +        gen_trace_updiscon();
> +
>           decode_save_opc(ctx, 0);
>           translator_io_start(&ctx->base);
>           gen_update_pc(ctx, 0);
> @@ -113,6 +119,8 @@ static bool trans_sret(DisasContext *ctx, arg_sret *a)
>   static bool trans_mret(DisasContext *ctx, arg_mret *a)
>   {
>   #ifndef CONFIG_USER_ONLY
> +    gen_trace_updiscon();
> +
>       decode_save_opc(ctx, 0);
>       translator_io_start(&ctx->base);
>       gen_update_pc(ctx, 0);
> @@ -129,6 +137,9 @@ static bool trans_mnret(DisasContext *ctx, arg_mnret *a)
>   {
>   #ifndef CONFIG_USER_ONLY
>       REQUIRE_SMRNMI(ctx);
> +
> +    gen_trace_updiscon();
> +
>       decode_save_opc(ctx, 0);
>       gen_helper_mnret(cpu_pc, tcg_env);
>       tcg_gen_exit_tb(NULL, 0); /* no chaining */
> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
> index b9c7160468..adda6b5bd8 100644
> --- a/target/riscv/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> @@ -183,6 +183,8 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
>           }
>       }
>   
> +    gen_trace_updiscon();
> +
>       lookup_and_goto_ptr(ctx);
>   
>       if (misaligned) {
> diff --git a/target/riscv/trace_helper.c b/target/riscv/trace_helper.c
> index ed84e6f79a..4b2b645f04 100644
> --- a/target/riscv/trace_helper.c
> +++ b/target/riscv/trace_helper.c
> @@ -28,9 +28,23 @@ void helper_trace_insn(CPURISCVState *env, uint64_t pc)
>           te->trace_next_insn = false;
>       }
>   }
> +
> +void helper_trace_updiscon(CPURISCVState *env)
> +{
> +    RISCVCPU *cpu = env_archcpu(env);
> +    TraceEncoder *te = TRACE_ENCODER(cpu->trencoder);
> +
> +    te->updiscon_pending = true;
> +    te->trace_next_insn = true;
> +}
>   #else /* #ifndef CONFIG_USER_ONLY */
>   void helper_trace_insn(CPURISCVState *env, uint64_t pc)
>   {
>       return;
>   }
> +
> +void helper_trace_updiscon(CPURISCVState *env)
> +{
> +    return;
> +}
>   #endif /* #ifndef CONFIG_USER_ONLY*/
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 75348480e6..17a6174899 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -604,6 +604,15 @@ static void gen_ctr_jal(DisasContext *ctx, int rd, target_ulong imm)
>   }
>   #endif
>   
> +static void gen_trace_updiscon(void)
> +{
> +    TCGLabel *skip = gen_new_label();
> +
> +    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_trace_running, 0, skip);
> +    gen_helper_trace_updiscon(tcg_env);
> +    gen_set_label(skip);
> +}
> +
>   static void gen_jal(DisasContext *ctx, int rd, target_ulong imm)
>   {
>       TCGv succ_pc = dest_gpr(ctx, rd);
> @@ -629,6 +638,8 @@ static void gen_jal(DisasContext *ctx, int rd, target_ulong imm)
>       gen_pc_plus_diff(succ_pc, ctx, ctx->cur_insn_len);
>       gen_set_gpr(ctx, rd, succ_pc);
>   
> +    gen_trace_updiscon();
I have a question about this line. Why have you added the generation of 
an updiscon message if the JAL instruction is an inferable jump?
> +
>       gen_goto_tb(ctx, 0, imm); /* must use this for safety */
>       ctx->base.is_jmp = DISAS_NORETURN;
>   }
--------------SL4Gut365lzvxhHNVneUq4uM
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 02.10.2025 14:23, Daniel Henrique
      Barboza wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20251002112335.2374517-15-dbarboza@ventanamicro.com">
      <pre wrap="" class="moz-quote-pre">Send updiscon packets based on the constraints already discussed in the
previous patch:

- We do not implement any form of call/return prediction in the encoder,
  and TCG will always retire a single insn per cycle, e.g. irreport will
  always be equal to updiscon;

- irdepth is not implemented since we'll always return a  package where
  irreport == updiscon.

Note that we're sending an updiscon packet if the 'updiscon_pending'
flag is set when we're about the send a resync or a trap packet. The TCG
helper in this case is just setting the trace encoder flags instead of
actually triggering a RAM sink SMEM write.

Signed-off-by: Daniel Henrique Barboza <a class="moz-txt-link-rfc2396E" href="mailto:dbarboza@ventanamicro.com">&lt;dbarboza@ventanamicro.com&gt;</a>
---
 hw/riscv/trace-encoder.c                      | 37 +++++++++++++++++++
 hw/riscv/trace-encoder.h                      |  3 ++
 target/riscv/helper.h                         |  1 +
 .../riscv/insn_trans/trans_privileged.c.inc   | 11 ++++++
 target/riscv/insn_trans/trans_rvi.c.inc       |  2 +
 target/riscv/trace_helper.c                   | 14 +++++++
 target/riscv/translate.c                      | 11 ++++++
 7 files changed, 79 insertions(+)

diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index 9a4530bbea..5572483d26 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -402,6 +402,22 @@ static void trencoder_send_sync_msg(Object *trencoder_obj, uint64_t pc)
     trencoder_send_message_smem(trencoder, msg, msg_size);
 }
 
+static void trencoder_send_updiscon(TraceEncoder *trencoder, uint64_t pc)
+{
+    g_autofree uint8_t *format2_msg = g_malloc0(TRACE_MSG_MAX_SIZE);
+    uint8_t addr_msb = extract64(pc, 31, 1);
+    bool notify = addr_msb;
+    bool updiscon = !notify;
+    uint8_t msg_size;
+
+    msg_size = rv_etrace_gen_encoded_format2_msg(format2_msg, pc,
+                                                 notify,
+                                                 updiscon);
+    trencoder_send_message_smem(trencoder, format2_msg, msg_size);
+
+    trencoder-&gt;updiscon_pending = false;
+}
+
 void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc)
 {
     TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
@@ -409,6 +425,10 @@ void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc)
     g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
     uint8_t msg_size;
 
+    if (trencoder-&gt;updiscon_pending) {
+        trencoder_send_updiscon(trencoder, pc);
+    }
+
     trencoder-&gt;first_pc = pc;
     trace_trencoder_first_trace_insn(pc);
     msg_size = rv_etrace_gen_encoded_sync_msg(msg, pc, priv);
@@ -426,6 +446,10 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,
     g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
     uint8_t msg_size;
 
+    if (trencoder-&gt;updiscon_pending) {
+        trencoder_send_updiscon(trencoder, pc);
+    }
+
     msg_size = rv_etrace_gen_encoded_trap_msg(msg, pc, priv,
                                               ecause, is_interrupt,
                                               tval);
@@ -435,9 +459,22 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,
 
 void trencoder_trace_ppccd(Object *trencoder_obj, uint64_t pc)
 {
+    TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
+
+    if (trencoder-&gt;updiscon_pending) {
+        trencoder_send_updiscon(trencoder, pc);
+    }
+
     trencoder_send_sync_msg(trencoder_obj, pc);
 }
 
+void trencoder_report_updiscon(Object *trencoder_obj)
+{
+    TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
+
+    trencoder-&gt;updiscon_pending = true;
+}
+
 static const Property trencoder_props[] = {
     /*
      * We need a link to the associated CPU to
diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h
index 2bf07c01f6..0c44092ccb 100644
--- a/hw/riscv/trace-encoder.h
+++ b/hw/riscv/trace-encoder.h
@@ -36,6 +36,8 @@ struct TraceEncoder {
     uint32_t regs[TRACE_R_MAX];
     RegisterInfo regs_info[TRACE_R_MAX];
 
+    bool updiscon_pending;
+
     bool enabled;
     bool trace_running;
     bool trace_next_insn;
@@ -51,5 +53,6 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,
                                bool is_interrupt,
                                uint64_t tval);
 void trencoder_trace_ppccd(Object *trencoder_obj, uint64_t pc);
+void trencoder_report_updiscon(Object *trencoder_obj);
 
 #endif
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index e80320ad16..f27ff319e9 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -131,6 +131,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
 
 /* Trace helpers (should be put inside ifdef) */
 DEF_HELPER_2(trace_insn, void, env, i64)
+DEF_HELPER_1(trace_updiscon, void, env)
 
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(sret, tl, env)
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index 8a62b4cfcd..28089539d5 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -26,6 +26,8 @@
 
 static bool trans_ecall(DisasContext *ctx, arg_ecall *a)
 {
+    gen_trace_updiscon();
+
     /* always generates U-level ECALL, fixed in do_interrupt handler */
     generate_exception(ctx, RISCV_EXCP_U_ECALL);
     return true;
@@ -40,6 +42,8 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a)
     uint32_t ebreak = 0;
     uint32_t post   = 0;
 
+    gen_trace_updiscon();
+
     /*
      * The RISC-V semihosting spec specifies the following
      * three-instruction sequence to flag a semihosting call:
@@ -95,6 +99,8 @@ static bool trans_sret(DisasContext *ctx, arg_sret *a)
 {
 #ifndef CONFIG_USER_ONLY
     if (has_ext(ctx, RVS)) {
+        gen_trace_updiscon();
+
         decode_save_opc(ctx, 0);
         translator_io_start(&amp;ctx-&gt;base);
         gen_update_pc(ctx, 0);
@@ -113,6 +119,8 @@ static bool trans_sret(DisasContext *ctx, arg_sret *a)
 static bool trans_mret(DisasContext *ctx, arg_mret *a)
 {
 #ifndef CONFIG_USER_ONLY
+    gen_trace_updiscon();
+
     decode_save_opc(ctx, 0);
     translator_io_start(&amp;ctx-&gt;base);
     gen_update_pc(ctx, 0);
@@ -129,6 +137,9 @@ static bool trans_mnret(DisasContext *ctx, arg_mnret *a)
 {
 #ifndef CONFIG_USER_ONLY
     REQUIRE_SMRNMI(ctx);
+
+    gen_trace_updiscon();
+
     decode_save_opc(ctx, 0);
     gen_helper_mnret(cpu_pc, tcg_env);
     tcg_gen_exit_tb(NULL, 0); /* no chaining */
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index b9c7160468..adda6b5bd8 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -183,6 +183,8 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
         }
     }
 
+    gen_trace_updiscon();
+
     lookup_and_goto_ptr(ctx);
 
     if (misaligned) {
diff --git a/target/riscv/trace_helper.c b/target/riscv/trace_helper.c
index ed84e6f79a..4b2b645f04 100644
--- a/target/riscv/trace_helper.c
+++ b/target/riscv/trace_helper.c
@@ -28,9 +28,23 @@ void helper_trace_insn(CPURISCVState *env, uint64_t pc)
         te-&gt;trace_next_insn = false;
     }
 }
+
+void helper_trace_updiscon(CPURISCVState *env)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+    TraceEncoder *te = TRACE_ENCODER(cpu-&gt;trencoder);
+
+    te-&gt;updiscon_pending = true;
+    te-&gt;trace_next_insn = true;
+}
 #else /* #ifndef CONFIG_USER_ONLY */
 void helper_trace_insn(CPURISCVState *env, uint64_t pc)
 {
     return;
 }
+
+void helper_trace_updiscon(CPURISCVState *env)
+{
+    return;
+}
 #endif /* #ifndef CONFIG_USER_ONLY*/
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 75348480e6..17a6174899 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -604,6 +604,15 @@ static void gen_ctr_jal(DisasContext *ctx, int rd, target_ulong imm)
 }
 #endif
 
+static void gen_trace_updiscon(void)
+{
+    TCGLabel *skip = gen_new_label();
+
+    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_trace_running, 0, skip);
+    gen_helper_trace_updiscon(tcg_env);
+    gen_set_label(skip);
+}
+
 static void gen_jal(DisasContext *ctx, int rd, target_ulong imm)
 {
     TCGv succ_pc = dest_gpr(ctx, rd);
@@ -629,6 +638,8 @@ static void gen_jal(DisasContext *ctx, int rd, target_ulong imm)
     gen_pc_plus_diff(succ_pc, ctx, ctx-&gt;cur_insn_len);
     gen_set_gpr(ctx, rd, succ_pc);
 
+    gen_trace_updiscon();</pre>
    </blockquote>
    <span style="white-space: pre-wrap;">I have a question about this line. Why have you added the generation of an updiscon message if the JAL instruction is an inferable jump?</span>
    <blockquote type="cite"
      cite="mid:20251002112335.2374517-15-dbarboza@ventanamicro.com">
      <pre wrap="" class="moz-quote-pre">
+
     gen_goto_tb(ctx, 0, imm); /* must use this for safety */
     ctx-&gt;base.is_jmp = DISAS_NORETURN;
 }
</pre>
    </blockquote>
  </body>
</html>

--------------SL4Gut365lzvxhHNVneUq4uM--

