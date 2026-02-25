Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FB0FD45F1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO8v-0003n8-3u; Wed, 25 Feb 2026 18:18:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO8e-0003Yj-U0
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:17:56 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO8d-00039M-38
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:17:52 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4375d4fb4d4so144830f8f.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061469; x=1772666269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KwFBaOjwYWri1oyotMlqElEX9mt5n22sEObHgA60FZc=;
 b=kfBroIyrsVj8rKZBMSJKHyIKpC9Jy+HiOK1j8JOG7nw4ojzSp+G5D89Xy1Xw1znURl
 sWUfDeaZM5nXkk8MKRJ9LxyA1/LbH6/fOQYJaJybHkkG0xR/0iJbDN/4dDc6y4IzS+ZS
 vbqC7aP3GlZPhmm74boma4Vw5M1UPanXoctYJnuG4+RtX//LDBZ17L/ddUKnsSYYjYuU
 xkODlAY+NcyKQeV8SDsZ93nTcUMjb089+a/8cq3lgJq3wylUXarPs1Jx/blCetjKRpG+
 9iJ9RaU/k2cgdYNC8EXf6lz62TrYCjpzxlkY7Z5aTV5CSbCy38nfOQlcoTV4emTxn6Bq
 Du7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061469; x=1772666269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KwFBaOjwYWri1oyotMlqElEX9mt5n22sEObHgA60FZc=;
 b=U008rgEzVvRI2PsiYQGr/QRKFq6p1+psnxebbFVB8Jg/I0v6qTzx1OCZ5lam5IEiZo
 d23Xl5NjzQRByRS+V8uEZbFNXfOOc4h0kk6FvBEhwKrHrmR0dUg1DagD8JviP/5R1Lt8
 OYIURxI++wp15Um+NBtDAq1knOKMBz5ZBCPnalUvS5QIGmh/G7ofbedvt6DXuKPEOeXA
 T7fAYFZnEuH74n7BJ0ymophsAwYkGkQnTWWh83/0G/fsoWDPW59LxZWoEcLZYoL/bwY7
 6t5gMoZlo9NBEIPX9DxxAwj47F5SCo1V9zes7y41HIFkqb6WN1opQcrubac1DW8289KD
 jcog==
X-Gm-Message-State: AOJu0YyVIGzAz1MDz/Er4Jzj4mxevEn0v3iFMEfAS4j5dzUfjPOyEONb
 qeIkgj5poDGjcQ4s9ok2F+RU5eADSXoEeq74m3/NMvW3C5CZ5K/Gc0SmX7bgp1ImJwUcokH84rv
 Smh/d6hY=
X-Gm-Gg: ATEYQzzB17Jdk//VTjEADoFHqbn0N0HReW47ouMKlnvxXCMlx6neDdE0FmgpRhyxay4
 qCONdyh9rEOJu/0FUSdYIajsNxhlvQ/CuG8m5GoxSk4zUBRb/YsZsw25mLdso+TcQlBkhI0x9kV
 VxevjDxiD5QViCGxfDAnHtRyFfRwqZk3Qa3DT/hTKIqoNwaBai9FPXt2ur+ntyHDV1IjbJJGu6n
 YF19WSJ8r8I06kLE91CaPHsdMtaXvrr4S1mBsdGnn+3jHAqQEluo1D0oPDp0l3mNAGb3k3AxwIy
 gNAzmwfbBXtfxYr3Zv3uNkb2u75x4QvR6XV5h4BMhF8U7Flri8KFQPBGJwE4Y2eMzWW8A9FvcN0
 51oyDerlVcBKGEfuOcnzy6nzodANTBi0K3mCsj7lfXWbb2ahVqgXqVl6Y/ocnrXJV3eG8g804cA
 vTOP3d/ZRodhKRVzV0kp1R3+Xrq/dhm3xCERsa5NixP+tbriwlLbJ3fwr03V7bzaNtS/C2i0bE
X-Received: by 2002:a05:6000:2212:b0:439:8dd7:18b5 with SMTP id
 ffacd0b85a97d-43997f34140mr596222f8f.37.1772061468919; 
 Wed, 25 Feb 2026 15:17:48 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43995fb04e5sm2327545f8f.6.2026.02.25.15.17.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:17:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/70] target/sparc: Factor sparc_cpu_gdb_write_register() out
Date: Thu, 26 Feb 2026 00:13:32 +0100
Message-ID: <20260225231411.96482-33-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Factor sparc_cpu_gdb_write_register() out.

Prefer ldn_p(target_long_bits/8) over target-specific ldtul_p().

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-25-philmd@linaro.org>
---
 target/sparc/gdbstub.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index ed52e521dcc..d19819cd1a9 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -124,19 +124,22 @@ static int sparc_cp0_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
     return 0;
 }
 
+static unsigned sparc_gdb_register_bytes(void)
+{
+#ifdef CONFIG_USER_ONLY
+# if defined(TARGET_ABI32)
+    return 4;
+# endif
+#endif
+    return target_long_bits() / 8;
+}
+
 int sparc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     SPARCCPU *cpu = SPARC_CPU(cs);
     CPUSPARCState *env = &cpu->env;
-#if defined(TARGET_ABI32)
-    uint32_t tmp;
-
-    tmp = ldl_p(mem_buf);
-#else
-    target_ulong tmp;
-
-    tmp = ldtul_p(mem_buf);
-#endif
+    const unsigned regsz = sparc_gdb_register_bytes();
+    uint64_t tmp = ldn_p(mem_buf, regsz);
 
     if (n < 8) {
         /* g0..g7 */
@@ -145,11 +148,7 @@ int sparc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         /* register window */
         env->regwptr[n - 8] = tmp;
     }
-#if defined(TARGET_ABI32) || !defined(TARGET_SPARC64)
-    return 4;
-#else
-    return 8;
-#endif
+    return regsz;
 }
 
 static int sparc_fpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
-- 
2.52.0


