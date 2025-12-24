Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D07E776C0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRRA-0007DW-Uc; Wed, 24 Dec 2025 11:10:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRR8-0007CL-Ns
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:10:06 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRR7-0000SS-7h
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:10:06 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-430f3ef2d37so4568564f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766592603; x=1767197403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p8cH+UJRswhJ7HOD8y3M4MwLljPkiUIuHHbXDl/Gg2w=;
 b=Ra4kqqIAeKlzzXcC6ffAPdQrpKbGt+hTnyXEJFPORyV8AZN9vFqq5KpdnKonjpXdJ/
 81N+ur7Esvf6rskFcCEU8iXKN9e8usfKBxIJhBD7r9J9H/MTao8m16mR1mb8dzKccwwB
 y8qQtXPz3MDJzO97jXWXJm3o/pM8NKI4oJd5hnB8s86w0+/rtiGUgmiy414DRl0wEEUY
 9bFhSlx+3aI7Kb/fJ7XBQXjchJLFXnBmZEZr5eTax4yMKC2n8Z7WAyYTZUUNVQs3QmFl
 MvpPIIeplxrqNYbNAu1x0tZbb8WKGKXDYzC9hXKUJpHfkIm1dvbvvn4O7WODD9asTwdB
 jIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766592603; x=1767197403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p8cH+UJRswhJ7HOD8y3M4MwLljPkiUIuHHbXDl/Gg2w=;
 b=htNJpMa20JXyBXYLVvdT27x5X4LZXBtG7q2o0aeg8+mtckEiOUaQjYXz+piLn8rxPF
 txqw9oZF0O4jtlcYtQJLmtHJHcjv3+Ghm+uaB3YMdTzs4s7pUfpUeyCOYsWLAp2DKEQy
 eCKBQIuYaDJYTkyvv7YWgx5VapDvk/TovJkEidaZJeuc8Vn+CiWxPl57sYlvj3FWlcZ5
 AN2WfD+XD+JIrdqFdGbQlG8Uzuufhk3aiJx4ItJghJRxx+B/Tk0Bgm9ITxEUbQXaAJLm
 7mfOjyLf65S9xuOcVt+R/GZxRcC8gA7/E2Y+TWlT3RTJfboUbBlCyXXBtBd5fRAC8rnD
 i3Qw==
X-Gm-Message-State: AOJu0YxR9e5hDprM944Q3lJfWWp5lVZm/YcKwGaXpvBR8HB7CpCfM1oU
 igc38t8gEmE+4KY4Isa0+aUFaa5E0fk4xOtCWmMsZPJm1OSlm3aXtSzxBX/dkadhndJQvBfBvwY
 V/el/wS8=
X-Gm-Gg: AY/fxX79sYczoNcuUOTODbMEJ+z28tyTNCmR7An+KoML7jt5jUtVuZxPhTFG88cz3qs
 smACtKhpyrAQ7hPKleWb4uKHiOXboX1r7V6IEJEUALCGTkDZVF5kL4Tf5j066F9u3z24cQsFPpi
 Fh0kMifShtsUtnykqJBuKCkmKvVoFbqGntTaGRPZK2EMg+bWXMZGM1x/YeKqcC1JNGsM/7VoCMt
 qSUpBHPgWxckKn7828xsm3rA6bGXl03IClU8HH1paz0TLLdyfVRqQQr6YCRYpj39KDn5+SPZOyp
 w1DgngEKhdkUt/k6mpC8+SmQb/E8esLO3bML4HCe2CQMoa8VLEYUOAjH+YefqAcaeMXbdupfelF
 mGicQ0SgZEGBZ7+rVHa0tvC1s/k1FxjNRELNu7H2o73fx32OMxtwc1hLhpnypoB/OXGZfgwLCD1
 SBuFoCikB1+/VkaPa560fFExJ/chsBjLznXKGEMl39qwGTzr3oZFxrVnI=
X-Google-Smtp-Source: AGHT+IGZ8BKNEXl5tuRui5kXTLEz3Y6JGPqhJjj3r9kuPhP+WcV8CNvcOse9EWzxz7iNW+TMa3ANBw==
X-Received: by 2002:a5d:584d:0:b0:430:f494:6aad with SMTP id
 ffacd0b85a97d-4324e4c632dmr18318925f8f.2.1766592603317; 
 Wed, 24 Dec 2025 08:10:03 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1af2bsm34922501f8f.1.2025.12.24.08.10.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:10:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/4] target/hppa: Use explicit big-endian LD/ST API
Date: Wed, 24 Dec 2025 17:09:40 +0100
Message-ID: <20251224160942.89386-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224160942.89386-1-philmd@linaro.org>
References: <20251224160942.89386-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

The HPPA architecture uses big endianness. Directly use
the big-endian LD/ST API.

Mechanical change using:

  $ end=be; \
    for acc in uw w l q tul; do \
      sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
             -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
        $(git grep -wlE '(ld|st)t?u?[wlq]_p' target/hppa/); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/gdbstub.c    | 2 +-
 target/hppa/int_helper.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
index 0daa52f7af2..537d0d2dfff 100644
--- a/target/hppa/gdbstub.c
+++ b/target/hppa/gdbstub.c
@@ -150,7 +150,7 @@ int hppa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     CPUHPPAState *env = cpu_env(cs);
-    uint32_t val = ldl_p(mem_buf);
+    uint32_t val = ldl_be_p(mem_buf);
 
     switch (n) {
     case 0:
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 4e4869285b5..d5a20cd549d 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -178,7 +178,7 @@ void hppa_cpu_do_interrupt(CPUState *cs)
                         break;
                     }
                 }
-                env->cr[CR_IIR] = ldl_phys(cs->as, paddr);
+                env->cr[CR_IIR] = ldl_be_phys(cs->as, paddr);
                 if (i == EXCP_ASSIST) {
                     /* stuff insn code into bits of FP exception register #1 */
                     env->fr[0] |= (env->cr[CR_IIR] & 0x03ffffff);
-- 
2.52.0


