Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E9DCCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 11:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vImrX-0007J5-FN; Tue, 11 Nov 2025 06:48:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vImrE-0006Vi-Ey
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:48:20 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vImrC-0004VN-S4
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:48:20 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-298145fe27eso25516625ad.1
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 03:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1762861697; x=1763466497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ku4gzQekXNmP0NCrTTNTgWbZgcWQty+FiingVB4OVqg=;
 b=Ynw6sL2ZhJ1IEL0HoB8RCgu3lqQAZZBgCDvbMMAovof+VABNuRg5LWMEp6QWGurxZN
 Pcxdfxa7N4WylYSEpj3xfkVOgI9xsITqatqpOlDS6X/l6wC9zseY/SSv6HO8o6FF0sZS
 FX2cMj6G6KaYkLMbZ9sYhs0ljeB31cqKNw2CNvWGwZ0cwMaOxYna4RVVfVNSfk0vLUjW
 MnIp9f4wZvfsG5XQ7i99oE6DNTTgoz/twgfGnmGfNSqlPhRArOfjkUz0zbK0gGwkvRPY
 w+MhEb2znpCYQpJTvPtBA+ljNX/CZ6wUM8ek8S6PzxKbx95hJfZnA5q00m3CctbSJTdN
 PIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762861697; x=1763466497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ku4gzQekXNmP0NCrTTNTgWbZgcWQty+FiingVB4OVqg=;
 b=hUiwsrK+VAAp40MPh3nPcbaTpsZPGZ772AxWMuNz1vV7trJJHS8MRoFQ79nXG4bQQp
 Qy9oNBaNM2VdWYskqwpXfVfGjjDcM35F+Lt4hsVitZR3yGUu3VuSYDXIaRoZ/oZWtmL1
 GVTIDVvNG5TwQuJAPXHPC4gfUs/sySiRhyRifAzYF/PpkGhM/1z66CGiKKD39lDTVAQF
 51s0zHEcpukjkCZARrsbgnDHuFw/ge5iU0ieHispUfR+otXTcDivE2cl5OvFJZnSScru
 8Tsli+OCbRwFnkt6cv60rHJH+nhL63TEKgQs5OyMEvvq0ck6Y68K9nAfJuYrUFvaPsY3
 6YEg==
X-Gm-Message-State: AOJu0Yyl58vL5MloIdMsykF7ZQkYm5qpKGWJxLVcdY052wdLsuZuImV6
 ywJYNbEqMNeV0MNeb9/WNz6/qfrYMXmqTLhyLmgPafsJmE+S8QaD7AShiGsGGOFRZVidZCYQluh
 hUSsT3mA=
X-Gm-Gg: ASbGncvRrgAevr+Btdqcnlyqjej9T72vV6zsJjXWPhyK6ClxKzzvnawTJ/gimu979LW
 IMml0moP4zYbyfS/oyuMaQsj0f6ve1JKq7cl+GiAzXbKJa+KQCEDhxiGG+5F3frmiRvso8Ey1s6
 eSwbNtu5sjIT0g/eL2cCJDpbicWtoRTEKJ5SGzNgmgYXWTAPSwbR27TVyEtqx97HuZIvB2IZgNH
 i38QtGLlwg+E9O23SYXd7hKwcLdO/8Gps9OZCPl4Lhhjk8K3WRHXPpL/pKP6rU5rFnyYnf6dvgu
 GeGXdGEYxeYh4Ta6Riziu0jDrx+z57flLiUk16SJNi+ArlzusISteYUJ2DeTew9s7soK1Ez1qHO
 zUpVDhUDOz2ZD+ucoC3WoiGZn8TyYqWVzbg7W1Lq31LtPkQgpFnmun3BWNtfM8so3LIpVZM+E6d
 cCbVuJlaLWPfQR4H5iBYx/IZUpBPs=
X-Google-Smtp-Source: AGHT+IH2FjSwQR7RqNkf8xLZGC4fVzSyj9wagLoOE7f/RejEJlqlwhGad4+ldZZJP4sEtTP7MHEEBw==
X-Received: by 2002:a17:902:f683:b0:297:e231:f40c with SMTP id
 d9443c01a7336-297e562ea74mr147955615ad.19.1762861696899; 
 Tue, 11 Nov 2025 03:48:16 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([179.93.21.233])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29651c747d1sm177533125ad.63.2025.11.11.03.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 03:48:16 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 11/17] hw/riscv, target/riscv: send trace trap messages
Date: Tue, 11 Nov 2025 08:46:50 -0300
Message-ID: <20251111114656.2285048-12-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
References: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62e.google.com
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

Use the rv_etrace_gen_encoded_trap_msg() helper we added in the previous
patch to encode trap packets to be written in the RAM sink SMEM.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/trace-encoder.c  | 17 +++++++++++++++++
 hw/riscv/trace-encoder.h  |  4 ++++
 target/riscv/cpu_helper.c | 13 +++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index 16c9475d46..0750bd22b5 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -403,6 +403,23 @@ void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc)
     trencoder_send_message_smem(trencoder, msg, msg_size);
 }
 
+void trencoder_trace_trap_insn(Object *trencoder_obj,
+                               uint64_t pc, uint32_t ecause,
+                               bool is_interrupt,
+                               uint64_t tval)
+{
+    TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
+    TracePrivLevel priv = trencoder_get_curr_priv_level(trencoder);
+    g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
+    uint8_t msg_size;
+
+    msg_size = rv_etrace_gen_encoded_trap_msg(msg, pc, priv,
+                                              ecause, is_interrupt,
+                                              tval);
+
+    trencoder_send_message_smem(trencoder, msg, msg_size);
+}
+
 static const Property trencoder_props[] = {
     /*
      * We need a link to the associated CPU to
diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h
index cf3177aefe..4898026f2b 100644
--- a/hw/riscv/trace-encoder.h
+++ b/hw/riscv/trace-encoder.h
@@ -46,5 +46,9 @@ struct TraceEncoder {
 OBJECT_DECLARE_SIMPLE_TYPE(TraceEncoder, TRACE_ENCODER)
 
 void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc);
+void trencoder_trace_trap_insn(Object *trencoder_obj,
+                               uint64_t pc, uint32_t ecause,
+                               bool is_interrupt,
+                               uint64_t tval);
 
 #endif
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index c4fb68b5de..f2990cf7c4 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -38,6 +38,10 @@
 #include "pmp.h"
 #include "qemu/plugin.h"
 
+#ifndef CONFIG_USER_ONLY
+#include "hw/riscv/trace-encoder.h"
+#endif
+
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
 {
 #ifdef CONFIG_USER_ONLY
@@ -2285,6 +2289,15 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                   __func__, env->mhartid, async, cause, env->pc, tval,
                   riscv_cpu_get_trap_name(cause, async));
 
+    if (cpu->trencoder) {
+        TraceEncoder *te = TRACE_ENCODER(cpu->trencoder);
+
+        if (te->trace_running) {
+            trencoder_trace_trap_insn(cpu->trencoder, env->pc,
+                                      cause, async, tval);
+        }
+    }
+
     mode = env->priv <= PRV_S && cause < 64 &&
         (((deleg >> cause) & 1) || s_injected || vs_injected) ? PRV_S : PRV_M;
 
-- 
2.51.1


