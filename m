Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 303EDF46C6D
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 18:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9oeo-0007Wm-4q; Mon, 06 Apr 2026 14:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9oem-0007Uv-So
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 14:26:40 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9oek-0002R5-1c
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 14:26:40 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c766a95a72dso2620934a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 11:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775499996; x=1776104796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QAUbPIMZvgGd8a5iLZaOYN2p4X0WpUbxXjz1zyQUBdM=;
 b=TK5UDexO48J7+LkutXRrcNQhii/vHiU9ew9GJufNAgUxmgXfGZs/mVZr3+RyANdYAZ
 gd6ovPg2VpWwpZH8QrojUlLK8Zx2dukABoBoF+LLlbhBNqKwQxeOOrYAhpR8WbUPaPEp
 KsxkZe/P1HnWQ9v/oiVcf+8MJ70mNcdUdQUVVOqfPYnX060GkRMb5RaYZairzSpCX1mg
 6AebjZ/Iqmgv3feR1FSbdNvGRe99OCEWwFr/Ja1+44V0sSIu9FhQBjTz35wHnfGWed6s
 R38PUFwCW8M/UhRN/KAHCQcmepkV3PPoLdFmWxX5CL27d13rQgQx6jcfnr7qocxH40JG
 zuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775499996; x=1776104796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QAUbPIMZvgGd8a5iLZaOYN2p4X0WpUbxXjz1zyQUBdM=;
 b=gZf5BXoSCMhRS41Wc6U/IuTzL77sQvggsjoedd3mz+idj2AA0xtfE2hx9dM9veGLn4
 o6wk7+g0skohtPcH6nQ9CPYE3uQaotZwCphz809xdu7KPFSVHkjlxkaQUlVAOHIHvq4N
 Hv+4iIX1qncXS7qpTFmYEBPrTTKmUR8wjHb2sca/4EaOttY33imhcwHTywF751DGff/3
 JkBNFBXnNhDkl0tnTtAftS0biOs0dB9Y61fvnjPqFmR2Q4/twQ6QuJ0u4/0V8vGk2kL2
 UTETL/pLDtNkxSSf378S29hel7t5pZGoWdhAyBIrjVwMv+RLDvjAAbeThviir83JkDp3
 QlwQ==
X-Gm-Message-State: AOJu0YwjPZWWjD2jbm36FxCqh2mn/ntMkaDU1gWuk6UuCxZRqiLS/FSq
 ALQkj3ETiItaM/C+GYrxFEeRPWDWniKNoyZJs75ZEoHENRE+fIZwRa/5ykhLzAo1wyWLRI2f9vd
 hVgfZrsPDHA==
X-Gm-Gg: AeBDieu/qaSaBIrTmDjsyn8ucNrYBuSFh+qHNdSelkOTcl44SCZhjxL9anxWQAJRc0P
 Ngf9nUxXWuPR6Y8Z3GsV8XANmaOlm2SO0feT45XlaYZSzrwuUBlFMIU/Q0nHSU5BVRzBzEFZ5cZ
 VrV7mbbiqR8St+qJifz2Z4dne/xGgi6jKK4fGBVx6bJXYeRBnIZAUhKUzdGSdf4mdbUU1dYgGGc
 gHGvFVKpMqNtS2QRxNq4mF77yLftq9k1H9ocvElCqtJFwaAtAHDsgt0LfsEUMhA7w0JQKeGJ4OX
 Wwdpt8r4C7+MA2s1ZHr7LaiBHj90S0x2T6UZYlfsEgah0aqQI1SDm90emVhMDmniZTGPpE3OAXx
 4fQkAGbwbi7rWZH+et/A3zotUnVPU7mUvhAwylm8I9xuiG3UolMTXGbaFkPwipXIBxjVn0CkgVx
 R2YqrselblDOs69PDKuJ7nAWsXQbEROLA6LnRSDJm0KZsYjiJYx6QQNhXhwhuYlzYtsNPFz27jm
 UIm
X-Received: by 2002:a05:6a20:6a28:b0:398:8db5:4131 with SMTP id
 adf61e73a8af0-39f2ed95189mr13110011637.9.1775499996376; 
 Mon, 06 Apr 2026 11:26:36 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6561fe9sm12765080a12.15.2026.04.06.11.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 11:26:35 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, jim.macarthur@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org, qemu-arm@nongnu.org
Subject: [PATCH v8 17/20] target/arm/tcg/translate.c: replace
 translator_ldl_swap with translator_ldl_end
Date: Mon,  6 Apr 2026 11:26:06 -0700
Message-ID: <20260406182609.193886-18-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
References: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x531.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 7fcf0656630..68f050746d4 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6279,6 +6279,13 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
     }
 }
 
+static MemOp arm_memop_endian_swap(bool sctlr_b)
+{
+    MemOp t = target_big_endian() ? MO_BE : MO_LE;
+    bool do_swap = bswap_code(sctlr_b);
+    return t ^ (do_swap * MO_BSWAP);
+}
+
 /* Ditto, for a halfword (Thumb) instruction */
 static inline uint16_t arm_lduw_code(CPUARMState *env, DisasContextBase* s,
                                      target_ulong addr, bool sctlr_b)
@@ -6290,7 +6297,7 @@ static inline uint16_t arm_lduw_code(CPUARMState *env, DisasContextBase* s,
         addr ^= 2;
     }
 #endif
-    return translator_lduw_swap(env, s, addr, bswap_code(sctlr_b));
+    return translator_lduw_end(env, s, addr, arm_memop_endian_swap(sctlr_b));
 }
 
 static bool insn_crosses_page(CPUARMState *env, DisasContext *s)
@@ -6531,7 +6538,7 @@ static void arm_post_translate_insn(DisasContext *dc)
 static inline uint32_t arm_ldl_code(CPUARMState *env, DisasContextBase *s,
                                     target_ulong addr, bool sctlr_b)
 {
-    return translator_ldl_swap(env, s, addr, bswap_code(sctlr_b));
+    return translator_ldl_end(env, s, addr, arm_memop_endian_swap(sctlr_b));
 }
 
 static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
-- 
2.47.3


