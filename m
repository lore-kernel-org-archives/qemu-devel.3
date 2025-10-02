Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5FACAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 11:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4HR9-00067J-Ci; Thu, 02 Oct 2025 07:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v4HQk-0005ru-GI
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 07:25:02 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v4HQ1-0005t6-Io
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 07:24:57 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-73b4e3d0756so10917717b3.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 04:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1759404250; x=1760009050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gLNDhzH/1hmTHYQk+i4nExfuEUFE7koIfBU6WKnnAV0=;
 b=k0PXL+m1Op1PODvBdOG8T4A2oFstycDSwu4ZYdqsQHxSYvhJHeyhuxtD7Ym9S7+jvB
 FxLUi8Wb/Pswl+bqKvM89NVOr7AwKjlD+YunJnooRYUavEt1taW4GFtuc36/PDU3J4Sp
 0wtumkP2L6AFbsWXFyZgzXsXFLcNYgH0Pr8hh8BhoNLljFARV6gHa/OakYLkvWftGpnv
 7nuneTbuXwSadfwrcNnnP5XjJLPBLzqxZT+3DvIvq9AXSTeDrGzaUMav3AwOBdaGNIVT
 fxjktqYjJ9cnXYtW19zPHHP7RPAQqU9HfcLcI5on+sdl97iNtY8inskHoYDcT6v2z/6V
 Sfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759404250; x=1760009050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gLNDhzH/1hmTHYQk+i4nExfuEUFE7koIfBU6WKnnAV0=;
 b=Tz8910Et5cIztME/8/5yTPhO5r6kLV6vnBXgkbydF+5D/PFeWcn2NDCyfu6les1Y7u
 CAxEHnHD3r5NG+l8dJIlG4TgTT6SEu0J9mPBCyR2vpJROJwjUbmjf+ot2ldfV7uz6uZm
 s8kePk14eKchwKJ5Obrwog0Ggwbe8gYcjjcAog0EbWRbr4bnuZoCNI9CXb9Ovpgrjel3
 fwoY0Nb9vEljKCs8aArI1+da1QqF7Ml+Vzz7D6B40XLzv9Pnpk0tNXkzkuJXhoayKKW+
 SJlc+D5nkia02IfOtDkd6kia4C+PHjbAoS/zNqzk1udAtCjFSxt2jfrs+E3gIuURxX0Z
 yjLQ==
X-Gm-Message-State: AOJu0YxlOIgRyoozkUvTTFOx2xbZQuzroLOoNI2GkaDq3CIv6ZPf6rew
 KSYIXBYJ7C0sXIDGiRTVYS8cd+qPJtmIePoNjzmfwXe4zzTkMaRYTuzTH3u4DxMjyqQKXI4NJu2
 ++pKdEaY=
X-Gm-Gg: ASbGncsdxbt2qbPZk2310AHNapng7uCEuwvGym1CI3R2YpSGE/JnBQZQWbnqygJf0EW
 EZcuqzR4wUqFqQuNkrFjADXe/PrpLx55dkUSiBVyv+7qqktSSZTvlp/QMBVnp+vwKBjqPNKQWrs
 GoiwJwYthaRyRC3t6dToI1mF9sqdZt/SAvygewdcuhxrmD9jIM0/nXbnH5NOjRa4vMqTS/3z20N
 hLnSzb8lTkeCubccJDcmOqTPkFMThUOz8cD8dAYndbkZ/VhDGy+z4/EUwOJTf4YkmtDQ8/Y0VYW
 ZaB3ywR21DX+e5Hl2LcKtmbDbTSIloeDkoLNESF0sfvgoTllz2SjMmUFMKN28zMUJgPBKYsjtA7
 BtYgTbIydgkO3op8DgUyVn4xpKB+vkX/Tjtbyo7vXg9kHnR9lZ+cYRGVAfGf6f0lxkH66xXAmlj
 ttUvt85u8tfA==
X-Google-Smtp-Source: AGHT+IHfCU0ujoyRvnDbL0nq/Wyu3NbDZIlOQGBajXuNFa9CDNFVFPlAf4lTK7Yh0SoJ7yRwfo3+fw==
X-Received: by 2002:a05:690c:6501:b0:76e:d9a5:1eb7 with SMTP id
 00721157ae682-77f6f30f73bmr101462967b3.27.1759404249856; 
 Thu, 02 Oct 2025 04:24:09 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 ([2804:7f0:bcc0:b174:a9af:8146:7deb:fbf3])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-77f81c068f6sm7331627b3.5.2025.10.02.04.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 04:24:09 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 12/17] target/riscv, hw/riscv: send trace ppccd packets
Date: Thu,  2 Oct 2025 08:23:30 -0300
Message-ID: <20251002112335.2374517-13-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002112335.2374517-1-dbarboza@ventanamicro.com>
References: <20251002112335.2374517-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

The ppccd (privilege change) trace packets consists of sync packets like we
already sent during trace start and resyncs.

The privilege change is being fetched via riscv_cpu_set_mode().

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/trace-encoder.c  | 18 ++++++++++++++++++
 hw/riscv/trace-encoder.h  |  1 +
 target/riscv/cpu_helper.c | 13 ++++++++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index 0750bd22b5..9a4530bbea 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -389,6 +389,19 @@ static void trencoder_send_message_smem(TraceEncoder *trencoder,
     trencoder_update_ramsink_writep(trencoder, dest, wrapped);
 }
 
+static void trencoder_send_sync_msg(Object *trencoder_obj, uint64_t pc)
+{
+    TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
+    TracePrivLevel priv = trencoder_get_curr_priv_level(trencoder);
+    g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
+    uint8_t msg_size;
+
+    trencoder->first_pc = pc;
+    msg_size = rv_etrace_gen_encoded_sync_msg(msg, pc, priv);
+
+    trencoder_send_message_smem(trencoder, msg, msg_size);
+}
+
 void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc)
 {
     TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
@@ -420,6 +433,11 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,
     trencoder_send_message_smem(trencoder, msg, msg_size);
 }
 
+void trencoder_trace_ppccd(Object *trencoder_obj, uint64_t pc)
+{
+    trencoder_send_sync_msg(trencoder_obj, pc);
+}
+
 static const Property trencoder_props[] = {
     /*
      * We need a link to the associated CPU to
diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h
index 4898026f2b..2bf07c01f6 100644
--- a/hw/riscv/trace-encoder.h
+++ b/hw/riscv/trace-encoder.h
@@ -50,5 +50,6 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,
                                uint64_t pc, uint32_t ecause,
                                bool is_interrupt,
                                uint64_t tval);
+void trencoder_trace_ppccd(Object *trencoder_obj, uint64_t pc);
 
 #endif
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 6506f2beb4..7255d038a8 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1034,6 +1034,8 @@ void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_long dst,
 
 void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en)
 {
+    CPUState *cs = env_cpu(env);
+
     g_assert(newpriv <= PRV_M && newpriv != PRV_RESERVED);
 
     if (newpriv != env->priv || env->virt_enabled != virt_en) {
@@ -1041,6 +1043,15 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en)
             riscv_itrigger_update_priv(env);
         }
 
+        if (newpriv != env->priv) {
+            RISCVCPU *cpu = RISCV_CPU(cs);
+
+            if (cpu->trencoder &&
+                TRACE_ENCODER(cpu->trencoder)->trace_running) {
+                trencoder_trace_ppccd(cpu->trencoder, env->pc);
+            }
+        }
+
         riscv_pmu_update_fixed_ctrs(env, newpriv, virt_en);
     }
 
@@ -1061,7 +1072,7 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en)
     if (riscv_has_ext(env, RVH)) {
         /* Flush the TLB on all virt mode changes. */
         if (env->virt_enabled != virt_en) {
-            tlb_flush(env_cpu(env));
+            tlb_flush(cs);
         }
 
         env->virt_enabled = virt_en;
-- 
2.51.0


