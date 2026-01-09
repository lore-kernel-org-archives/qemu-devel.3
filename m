Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F102AD232DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 05:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve56l-0004S9-Kk; Fri, 09 Jan 2026 00:32:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56j-0004NG-JV
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:21 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56h-0003j8-VZ
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:21 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-ba599137cf8so1033303a12.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 21:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767936739; x=1768541539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1pzH52nruw/NQPCqhWmjdkOJqM8QRb33UktwGYQCddQ=;
 b=SUqKLBk/adweulHYA5sBKXSIag6gtoknWVge1wTD6Dk8gW7TkEFG9RGdMJ+lji8YlA
 9ldffxHKqQq1DsQSCjyULyLj+R6DteM/V4JI1KC278wlUj/50pjxQ85oKTftuD+1eCHE
 K0iQN3n6VWeled4p4R8ZtqQLIJp6kBASSDtiYbirUFdE26r1XSAk3DiGmcluxKtID6WC
 Gc6Aq5xZH57Q1BDhHLLX3wlMKjXJmR3Z69L48q/zR/CS/UA/idEimWf0rrUHLXPwP2pg
 tOnwegQKuhy6kB1g9fy5C3MHHIf8hh6BzuW9+NfZLrgaeZ27+pbS2j0AT2Jkb7baQvg8
 ez5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767936739; x=1768541539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1pzH52nruw/NQPCqhWmjdkOJqM8QRb33UktwGYQCddQ=;
 b=tZ/yRafg7zFqGCiHiCgtzzxtBMdcSO2GuBSsTF0J/LioZv6BOraZ9Q/qpCw/sVIe8N
 5Z6Ri+CH2C8wqymnZP2aYrthCSCQqeYoGejcLkTw/mp3mUMcHtIcCz07sTkatechPDn8
 B0qRchO6timu+dW1lsF2paxeW0flVzFxHmemcJTNe0K0pCHBUIOUZOqfq2VMb1qL0oDi
 rLuHYJ6Ji/xAKr6MT6f7zWYZjeo4xAxInLkCZBoH8O6+ULq+6VPUdiE6XL4N5BLd9234
 yjzVV7VmFDQR7n5GXevaM6UPh0FVUpvovaZz35WqijNgsF2fRp3eiSlySiYV+Yam7zB8
 KyWg==
X-Gm-Message-State: AOJu0YyXjbOnLCpA13skQL5B3EzW2hUGWSjxLbyYTqO10oQJGE6+EoHz
 OTHTVcdSlAta7s5EAutVUSx+C4lcKof9or6nJs9A9oeIjnTthnLmqEXV3EouLgHxM0ovWs3U/ed
 htu7J
X-Gm-Gg: AY/fxX6X/if5xMi0w9TN8wPhsYXsORadgCmBn/mp5AJHskyvHDqaBRQ/jQpkxXKMnaV
 DGQJpZ6kgFnTGeBD2YFBMBVs1J8nhFO6abFN4j1tZGVq57H5sRQH2ysWE4u3AzK6hm6lshsZSKp
 NF/5/mhll402GGFSp3iCS4u+B6eK3N3O5zdC3vqD+v98WECBpKKTC7utnLl4S8XErRbPDnc3khB
 lpY1xISOKkWkn4U1Q2ZxwXUxEputWrDXYK65+ZUum5t6yVQETyp6NM2TgnHkiMr9ms12TU6BXrX
 UFsUR8OcXI0/6lw0HQ12LqUIl4lXt1UIbazqTVmnpQPpnWfp7I+UW4hAgC6IjsWKFWAYmEtNuD9
 5dBZr5i5b3On7rjC64Ev6psn2A0rEVR10WRiCAp/N0XSZGMh2T+eGM/Oww93tXhAUqPuwYawmlM
 cqjl0e1D5GvYxsnxeu0DaXzT7dUP35E/IZD7KR4ehL+EaIgQfR1zW0bcbuamKym2ML
X-Google-Smtp-Source: AGHT+IG5DhFXsHuSJfkCEqhAjL8N3K2UTZP1dj2CMbohoovDrvWhXa/oaAtqmwdUgvwn+JQCw8SP6w==
X-Received: by 2002:a05:6a20:a105:b0:35f:5896:859b with SMTP id
 adf61e73a8af0-3898e9c8310mr9649748637.4.1767936738540; 
 Thu, 08 Jan 2026 21:32:18 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa93f30sm9260137a91.5.2026.01.08.21.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 21:32:18 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 15/29] accel/tcg/translate-all.c: detect addr_type dynamically
Date: Thu,  8 Jan 2026 21:31:44 -0800
Message-ID: <20260109053158.2800705-16-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

With TARGET_ADDRESS_BITS mechanism, it's now possible to specify which
variant every source file is written for. Compared to before, it means
that addr_type will now vary per tb translation, where it was constant
for a given target previously.

Instead of introducing a new parameter to translator_loop(), we simply
add this information in TCGTBCPUState, which is returned by
get_tb_cpu_state() during the translation, and passed down to
tb_gen_code().

To avoid modifying all target with this new field, we simply define a
default value that is equivalent to current state: use
target_long_bits(). With this, we can progressively convert new
architectures.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/accel/tcg/tb-cpu-state.h | 12 ++++++++++++
 accel/tcg/translate-all.c        | 15 ++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/accel/tcg/tb-cpu-state.h b/include/accel/tcg/tb-cpu-state.h
index 8f912900ca6..b77c4dd5100 100644
--- a/include/accel/tcg/tb-cpu-state.h
+++ b/include/accel/tcg/tb-cpu-state.h
@@ -8,11 +8,23 @@
 
 #include "exec/vaddr.h"
 
+/*
+ * Default value 0 means to refer to target_long_bits(). It allows to stay
+ * compatible with architectures that don't yet have varying definition of TCGv
+ * depending on execution mode.
+ */
+typedef enum TCGvType {
+    TCGV_TYPE_TARGET_LONG = 0,
+    TCGV_TYPE_I32,
+    TCGV_TYPE_I64,
+} TCGvType;
+
 typedef struct TCGTBCPUState {
     vaddr pc;
     uint32_t flags;
     uint32_t cflags;
     uint64_t cs_base;
+    TCGvType tcgv_type;
 } TCGTBCPUState;
 
 #endif
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index fba4e9dc21c..bc5d9d74e21 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -257,6 +257,19 @@ static int setjmp_gen_code(CPUArchState *env, TranslationBlock *tb,
     return tcg_gen_code(tcg_ctx, tb, pc);
 }
 
+static TCGType tcgv_type_to_tcg_type(TCGvType t)
+{
+    switch (t) {
+    case TCGV_TYPE_TARGET_LONG:
+        return target_long_bits() == 64 ? TCG_TYPE_I64 : TCG_TYPE_I32;
+    case TCGV_TYPE_I32:
+        return TCG_TYPE_I32;
+    case TCGV_TYPE_I64:
+        return TCG_TYPE_I64;
+    }
+    g_assert_not_reached();
+}
+
 /* Called with mmap_lock held for user mode emulation.  */
 TranslationBlock *tb_gen_code(CPUState *cpu, TCGTBCPUState s)
 {
@@ -316,7 +329,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu, TCGTBCPUState s)
     }
 
     tcg_ctx->gen_tb = tb;
-    tcg_ctx->addr_type = target_long_bits() == 32 ? TCG_TYPE_I32 : TCG_TYPE_I64;
+    tcg_ctx->addr_type = tcgv_type_to_tcg_type(s.tcgv_type);
     tcg_ctx->guest_mo = cpu->cc->tcg_ops->guest_default_memory_order;
 
  restart_translate:
-- 
2.47.3


