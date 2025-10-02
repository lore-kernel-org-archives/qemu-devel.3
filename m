Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5881CCA471
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 11:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4HQu-0005uA-80; Thu, 02 Oct 2025 07:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v4HQg-0005rt-RX
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 07:25:01 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v4HQ0-0005sc-Qg
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 07:24:58 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-71d603b60cbso9784977b3.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 04:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1759404248; x=1760009048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3xydZ38TvrJ8XLsRcG3ZSs21hlFl77rnQE7k8mQMlMk=;
 b=NaPUAqzWhLkO0dLEHTaxUV2d/koNXQQzhyO/Bxbdvw3iTSInEzawxtnjdOeA3BQ21c
 9hIlLd5nzYKGFq/NuIGamTmVTggyQ8s4e+iZdW7zgipYy6vD1vD4dRsQ1ikutjspydd7
 yF7SSNsmFjsJjpSPO1p/w025g/OTwUqmcA6h38fvuOL/oTQi/R+CWPu1cQWnZk7zIGUe
 BePJGkfQ51OvGl+aniBXBBnuTzxcz9E8Qt9Std6NxXWdzezVEi+qyihSugDU8gURYULa
 0xcX+0Iw8dyT8eBOWlvwL6mFq2KF3cv4KgzBDZBB0MbzbmAszt3qH91v9xDw8gJDXlNT
 RqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759404248; x=1760009048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3xydZ38TvrJ8XLsRcG3ZSs21hlFl77rnQE7k8mQMlMk=;
 b=C1lheI2Y9e7MIVZeXScsNdz991sXFxTlCU12TRW/1r0xjKpJvPV1ZTeH9MoV/ZHifR
 sIzWWpXPKxDNe17SiR1YAoY8+cCOEwHI/nIpZ5mphZlVf2u5NtWOmedH1LA0er+J4x6x
 IF8Glep2ctryDFiw9ihjSqiGijZJCKo9Jazi11adJ4V92gGyqQkn5vGwnssXCqFOISFW
 0y28mP0zBYq4sdp5B4CmpQwvO/90bChXpYfEjfxneOynu2RtoxbJp5h3Fn8oie96kICQ
 sTA3Hh0ceAQWGl/VaR5vbjH1/OZMzecL/BMMhEpoj/5DhBwOI+4ECCM/3alRSMEv9fHZ
 Ugog==
X-Gm-Message-State: AOJu0Ywd+guZcuDHS9juKSgN+UZ8WF0swc2FHEW9PYI+Y5jJFhjXLYWh
 8nZOBwFE4Z28gAaUm3oMO+L6vIsPx4xmS3eZ2YwbyuH8chz/un6YyCYHfMM3/voGQfkvYF/0aN2
 rthF8FMs=
X-Gm-Gg: ASbGncuU6gzP/3xh2UTFoDdAa/Ty1CsfZhSMaznr9UgXD1eliy3EqLlYnWRlLgBp266
 TplteJIcFVqoqyqcsm/kRUjtTTB1oNToIdCRCucVOERdTBhOZXMoIAy9ffhSF299AoxgcI5R9H6
 b9GbkNgrqD6v56XT+qGszGzatSvrhdTj+uS0avvDcqK0nOoS/ztjHYaAW58GTvC1vtj045zEcQz
 WuYknh1PlrYdxRV3GsXPBs3sMDpOO+uH75yI5OiCd0ItPSw4Z5zPHelEp299lITDjHQQYQqACvx
 L/X/obngBx7tFjgF2k37gM93sMfMhmEfHZpcEsZqY8W8mDr4OYm3NB05O+dqXF3olHVV8sus4sS
 1JBO5ah7t2/PKydDO1N4w752/Aqy4R2kL6/9BlcUOkSUnZbEGJQXDAAtf+0SlahOLiBFVks9/mZ
 w=
X-Google-Smtp-Source: AGHT+IGhOWcdZZswg9UU8/XLwQea5Z/O56gQy0vwWDKvMv892OyZJXGot9UZkaopipKFDaEx9b9DjA==
X-Received: by 2002:a05:690c:6d08:b0:76b:f6a9:5be9 with SMTP id
 00721157ae682-77f6f0c669bmr92628957b3.11.1759404247655; 
 Thu, 02 Oct 2025 04:24:07 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 ([2804:7f0:bcc0:b174:a9af:8146:7deb:fbf3])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-77f81c068f6sm7331627b3.5.2025.10.02.04.24.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 04:24:07 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 11/17] hw/riscv, target/riscv: send trace trap messages
Date: Thu,  2 Oct 2025 08:23:29 -0300
Message-ID: <20251002112335.2374517-12-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002112335.2374517-1-dbarboza@ventanamicro.com>
References: <20251002112335.2374517-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
index 3479a62cc7..6506f2beb4 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -37,6 +37,10 @@
 #include "debug.h"
 #include "pmp.h"
 
+#ifndef CONFIG_USER_ONLY
+#include "hw/riscv/trace-encoder.h"
+#endif
+
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
 {
 #ifdef CONFIG_USER_ONLY
@@ -2283,6 +2287,15 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
2.51.0


