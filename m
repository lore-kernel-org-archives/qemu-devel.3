Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38778C44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 11:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1visgT-0002Uv-BA; Thu, 22 Jan 2026 06:17:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1visgP-0002Ti-Lh
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 06:17:02 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1visgM-0001Ig-Fe
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 06:17:00 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-432d2c96215so701031f8f.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 03:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769080616; x=1769685416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ofJOOkHWkj0n80LafpXMa3XYu3HjN97maY6o0XA2DWI=;
 b=GN8WqJtsligOBUeO2KEceF6N+4EYQN0otFZmI+mUS9FT4on95tgO6w+VY1W1AXXPv2
 ueESeIgkeDUJR94U6L+D/j3qHXL+x5qDwfp5/syhGUIOs0uq/hmIIZkwFvMWuDi2VX04
 ern+buC6FJONKPQOs0FWJ6jCeCWUQREMDhlosvgQZuU14ScAQUoaTOn4a+ifzFvb7N21
 AVD4mStXQuVPrql6NL4cUaDNPf6O2mWrEzaeJjJbKBKmEUmWPqL8ckrcIABBPmV3GsGT
 oIyZ3xXvLvMAorSLCnqyzHKpDqTNHN/MjODIOIoDdBIvmUoPHptZEvECS2/V2G/fXhUU
 XLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769080616; x=1769685416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ofJOOkHWkj0n80LafpXMa3XYu3HjN97maY6o0XA2DWI=;
 b=v4QAPtGKCwIt5SD8WU+WmymyhK97zj1WRoxLyikJh+KLpvD8Iuhsw3WCDrSXAXut7U
 sJm6Hl4KHXPDKpDkJJrPpCQR991KogM76cC1GUp8WMkxfBMoYHW6thFOORZ8vOs9xkXy
 NBak21H+LafrdlQUIs1oQ/txx2yuLZWOhxd8nAyHEJiqIdI8HkLHbSun8+YSgfm1gXxX
 iWBjVXcGDIJv86R2K4bz/adHOf9ZwMlgFGCDeBAflkpdrugWrOFISu5AQMeI8EtVRJG9
 9IveijYaf5b3F8Yb0AoPHwxN7ZrgW1kGn3nudxV4l0/gUNM8TFaO0DQJhCWdgbVe2blC
 qRUQ==
X-Gm-Message-State: AOJu0YwyWKZjgYXkknN1rXY5L22/KNAIw+61J2zHLOmBz0V50vzWNLXF
 qfZ11YTa1aj/RyRpf0YL5chf+feb1VmMXKKDy2yR5owKfaZ+qP5WxM84EuzFegUA+lSxFQkveV8
 ArwqgAqQ=
X-Gm-Gg: AZuq6aLHc5fgoSYNPV/3yBmeWUUnEKfUcj+DngxAduUPppZ6CZV8F6zgaE9YSNF+rC7
 /ZdWW8G4S2+3SzqQhNWpzB2v2jNg+mFvbJiIZeaRHyHt+BNIsfalZIbtGLfENoYpLM1UCB2FNOH
 7Xlbd/cI45G/b0UqSpLmvbWbkHjRQxO7GD0CqoPhi9Rr4yWX0zTF+5pw91ztNWrZwIeMk3UC565
 ZcPxhC7lsLFLRSLaf9Z+Suq1DJ+r8ha/6p/FMCLp5TDDMmxakEiIU9TDEkeHatnVhDZmibJEJaM
 dRcaY452i0aMp1oHGHmUUjEAHAew+pQ0JFsJ1KFlxEgSWRaPd6l19Ys+Au0++sEdqDW1xJyWwEb
 IVqLhceHIDE0DW0ykaBqbXiWh9Vrzxq94IKUjFZCD0u2SPtKnqi09IXH6jKzbdKnFUfwlAhLCdG
 TqKSu3ryhTu/exo5lPLvmTFF0yj/mSQN21EgZjEfHx+JdQxw8sFbJ6reQZTMNNC3AWTDnFEFA=
X-Received: by 2002:adf:e848:0:b0:435:9ce0:f935 with SMTP id
 ffacd0b85a97d-4359ce0fab4mr7702212f8f.31.1769080616471; 
 Thu, 22 Jan 2026 03:16:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435966322a2sm15025269f8f.38.2026.01.22.03.16.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 03:16:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 02/37] target/riscv: Use little-endian variant of
 cpu_ld/st_data*() for vector
Date: Thu, 22 Jan 2026 12:16:35 +0100
Message-ID: <20260122111639.32346-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122111639.32346-1-philmd@linaro.org>
References: <20260122111639.32346-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

RISC-V vector "elements are simply packed in order from
the least-signicant to most-signicant bits of the vector
register" [*] which is little endianness, therefore the
cpu_ld/st_data*() definitions expand to the little endian
declarations. Use the explicit little-endian variants.

[*] RISC-V "V" Vector Extension v1.0

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-Id: <20251126202200.23100-4-philmd@linaro.org>
---
 target/riscv/vector_helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 2de3358ee86..caa8dd9c125 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -193,9 +193,9 @@ void NAME##_host(void *vd, uint32_t idx, void *host)        \
 }
 
 GEN_VEXT_LD_ELEM(lde_b, uint8_t,  H1, ldub)
-GEN_VEXT_LD_ELEM(lde_h, uint16_t, H2, lduw)
-GEN_VEXT_LD_ELEM(lde_w, uint32_t, H4, ldl)
-GEN_VEXT_LD_ELEM(lde_d, uint64_t, H8, ldq)
+GEN_VEXT_LD_ELEM(lde_h, uint16_t, H2, lduw_le)
+GEN_VEXT_LD_ELEM(lde_w, uint32_t, H4, ldl_le)
+GEN_VEXT_LD_ELEM(lde_d, uint64_t, H8, ldq_le)
 
 #define GEN_VEXT_ST_ELEM(NAME, ETYPE, H, STSUF)             \
 static inline QEMU_ALWAYS_INLINE                            \
@@ -214,9 +214,9 @@ void NAME##_host(void *vd, uint32_t idx, void *host)        \
 }
 
 GEN_VEXT_ST_ELEM(ste_b, uint8_t,  H1, stb)
-GEN_VEXT_ST_ELEM(ste_h, uint16_t, H2, stw)
-GEN_VEXT_ST_ELEM(ste_w, uint32_t, H4, stl)
-GEN_VEXT_ST_ELEM(ste_d, uint64_t, H8, stq)
+GEN_VEXT_ST_ELEM(ste_h, uint16_t, H2, stw_le)
+GEN_VEXT_ST_ELEM(ste_w, uint32_t, H4, stl_le)
+GEN_VEXT_ST_ELEM(ste_d, uint64_t, H8, stq_le)
 
 static inline QEMU_ALWAYS_INLINE void
 vext_continuous_ldst_tlb(CPURISCVState *env, vext_ldst_elem_fn_tlb *ldst_tlb,
-- 
2.52.0


