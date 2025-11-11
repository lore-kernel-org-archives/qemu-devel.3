Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59C9CCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 11:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vImtD-0002hx-Ux; Tue, 11 Nov 2025 06:50:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vImrq-0008MK-9f
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:49:00 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vImro-0004b6-HA
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:48:57 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-297d4ac44fbso6423515ad.0
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 03:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1762861735; x=1763466535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kMw21UKyK4t+LLYVevUj5AWfKcUQpnJ5koYbjOeAsAc=;
 b=QRITqwmAU4rakrlcSj8fsPvcEssQjyRatrR6siDYNA3DHJbNUhOVZ6DSAhvQn6m+I6
 Vb2ZGziPPDK5IB2Y6zbWm/VOaajEUt9uut5O11Du3e5wnLC8mp5jO6uQebGPBAttz4AQ
 ySw8gktTg2qe/anLSvzLOW7qJcBge93HlidWg1qMKgQRQTFYNdCAV59+g9DP99xzQK3W
 uXT0pn8zqPcxociHenDET3LJU9WeM+0qT3nZGuSOOt8e5NWS0nSA6Jlcj80c/KriFgrW
 sKQhWfdrrUsXjXNcg77MgwOSVnJkKilvvx/l4q+O0/Tg9qUXtwsWisPuxuEp/ejupbB4
 oUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762861735; x=1763466535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kMw21UKyK4t+LLYVevUj5AWfKcUQpnJ5koYbjOeAsAc=;
 b=neHzY1mTLIqMsnHlAWBPoinHaxuliGvZczjZ0eCi4m38TWvsV2i1/C5Jn3hmNNvCNe
 DadsrTmQuna/3TLVR2U9/nS0GXCmPCmrbArA1mNze7NQBeEgWvrItqtckVWjqIMFWBmo
 w/QhZ/pAGXU5ieYgi/pOr0hujB3ccMeAvVLgbLl4vf9QshziK7W3ms31gQs+RJxc9kfe
 AB1mStpn+ohKhXyNLijuE7PAfY/kmr05gE1LoxOUqlGFGM0uWwuuAwcYWSlnsPmV3KoK
 ZBF7eCHtFTepeJwbeCaelssHGK/fYhuQLsY+wz/v433XesViEd7/X4AmbHs2G59k3Z+e
 +E+g==
X-Gm-Message-State: AOJu0YzWlW/We7EczYFXxn8o1piXefY5QqpzHHd939wSX7WxWhsXCEWs
 jYka1UsxLRUr0AJM7zZrMjxt1M2ProhTGz6Ex2aoclnb7dUaJT8lWJ1iZGw+qwvCXcbF3rjvhpS
 6272e9zg=
X-Gm-Gg: ASbGncsx8wSVibiPEaCcUP8i4US7FJRMSMYRxL7u2tjlOdobC1/t63ajwtjWRDGPDSA
 tKby/acZHl3hfWB9yUgyLjeNvne6mAscKn/GVCU/QNq5ki2mB4k6RIVNslYt/pQQckw5aXXLGhq
 922/AYmJ4c9OnFihio4vzOEOyixfRfdSu6hbWPAZz5tQtFcSJThL//TJPUEh8JvRoWR4vWk67si
 U6clNnEjoHqDirX7AVmBR8qLvTYhdOOG9HFCF0pcJ4Q+XuD08wQBw4b6+7d1VOe08WRTNRh+BdX
 gH1cwmQI1Bkv7FnG2+iA5neNJ4idiDhHEbTiFVQLxwLMdYACut1iXC9LR5aIWatAKlMZqBGEHmo
 S5b1Wx7MxiNVa+r+FVLHS/i4aZlqYscTEe1bV9lQuQfAEcbUL3TdClXkh8aqDwMHS8rKBRo72+x
 3HCkd9x7ZUITsjNxaRM4B1ihrUSpkT+21IOPT53w==
X-Google-Smtp-Source: AGHT+IGYm/nSXeXjJlUuHA7uZjEfwYGQm6kgEBF4QJobsyLe9FPWr9rDlbkokaZglq2gLw1AJ1K24w==
X-Received: by 2002:a17:903:3bc8:b0:295:6850:a38d with SMTP id
 d9443c01a7336-29840842bdbmr35766615ad.19.1762861734691; 
 Tue, 11 Nov 2025 03:48:54 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([179.93.21.233])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29651c747d1sm177533125ad.63.2025.11.11.03.48.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 03:48:54 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 17/17] hw/riscv/trace: update branch bit in sync messages
Date: Tue, 11 Nov 2025 08:46:56 -0300
Message-ID: <20251111114656.2285048-18-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
References: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Now that we have a working branch map update the branch bit in sync
messages by checking if the sync address is a branch address that was
taken (or not).

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/rv-trace-messages.c |  6 +++---
 hw/riscv/rv-trace-messages.h |  3 ++-
 hw/riscv/trace-encoder.c     | 30 ++++++++++++++++++++++++++++--
 3 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/rv-trace-messages.c b/hw/riscv/rv-trace-messages.c
index a93b0adfc6..a0a0cbb6ce 100644
--- a/hw/riscv/rv-trace-messages.c
+++ b/hw/riscv/rv-trace-messages.c
@@ -115,11 +115,12 @@ static void rv_etrace_write_header(uint8_t *buf, RVTraceMessageHeader header)
 }
 
 size_t rv_etrace_gen_encoded_sync_msg(uint8_t *buf, uint64_t pc,
-                                      TracePrivLevel priv_level)
+                                      TracePrivLevel priv_level,
+                                      bool pc_is_branch)
 {
     RVTraceSyncPayload payload = {.format = 0b11,
                                   .subformat = 0b00,
-                                  .branch = 1,
+                                  .branch = pc_is_branch,
                                   .privilege = priv_level};
     RVTraceMessageHeader header = {.flow = 0, .extend = 0,
                                    .length = SYNC_PAYLOAD_SIZE_64BITS};
@@ -158,7 +159,6 @@ size_t rv_etrace_gen_encoded_trap_msg(uint8_t *buf, uint64_t trap_addr,
 {
     RVTraceTrapPayload payload = {.format = 0b11,
                                   .subformat = 0b01,
-                                  .branch = 1,
                                   .privilege = priv_level,
                                   .ecause = ecause};
     RVTraceMessageHeader header = {.flow = 0, .extend = 0,
diff --git a/hw/riscv/rv-trace-messages.h b/hw/riscv/rv-trace-messages.h
index 2b371641a4..fd4bb10860 100644
--- a/hw/riscv/rv-trace-messages.h
+++ b/hw/riscv/rv-trace-messages.h
@@ -20,7 +20,8 @@ typedef enum {
 } TracePrivLevel;
 
 size_t rv_etrace_gen_encoded_sync_msg(uint8_t *buf, uint64_t pc,
-                                      TracePrivLevel priv_level);
+                                      TracePrivLevel priv_level,
+                                      bool pc_is_branch);
 size_t rv_etrace_gen_encoded_trap_msg(uint8_t *buf, uint64_t trap_addr,
                                       TracePrivLevel priv_level,
                                       uint8_t ecause,
diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index 5b8f773b11..39ed8c8d54 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -394,15 +394,38 @@ static void trencoder_send_message_smem(TraceEncoder *trencoder,
     trencoder_update_ramsink_writep(trencoder, dest, wrapped);
 }
 
+static bool trencoder_addr_is_branch_taken(TraceEncoder *te, uint64_t addr)
+{
+    uint8_t last_branch;
+
+    if (te->branches == 0) {
+        return false;
+    }
+
+    if (te->last_branch_pc == addr) {
+        last_branch = extract32(te->branches, te->branches - 1, 1);
+
+        /* 0: branch taken, 1: not taken*/
+        if (last_branch == 0) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
 static void trencoder_send_sync_msg(Object *trencoder_obj, uint64_t pc)
 {
     TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
     TracePrivLevel priv = trencoder_get_curr_priv_level(trencoder);
     g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
     uint8_t msg_size;
+    bool is_branch_taken;
 
     trencoder->first_pc = pc;
-    msg_size = rv_etrace_gen_encoded_sync_msg(msg, pc, priv);
+    is_branch_taken = trencoder_addr_is_branch_taken(trencoder, pc);
+    msg_size = rv_etrace_gen_encoded_sync_msg(msg, pc, priv,
+                                              is_branch_taken);
 
     trencoder_send_message_smem(trencoder, msg, msg_size);
 }
@@ -440,6 +463,7 @@ void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc)
     TracePrivLevel priv = trencoder_get_curr_priv_level(trencoder);
     g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
     uint8_t msg_size;
+    bool is_branch_taken;
 
     if (trencoder->updiscon_pending) {
         trencoder_send_updiscon(trencoder, pc);
@@ -447,7 +471,9 @@ void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc)
 
     trencoder->first_pc = pc;
     trace_trencoder_first_trace_insn(pc);
-    msg_size = rv_etrace_gen_encoded_sync_msg(msg, pc, priv);
+    is_branch_taken = trencoder_addr_is_branch_taken(trencoder, pc);
+    msg_size = rv_etrace_gen_encoded_sync_msg(msg, pc, priv,
+                                              is_branch_taken);
 
     trencoder_send_message_smem(trencoder, msg, msg_size);
 }
-- 
2.51.1


