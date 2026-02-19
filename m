Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB663E9A05E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9e6-0002EM-Cr; Thu, 19 Feb 2026 14:25:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9dE-0008Ou-Ig
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:24:13 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9dB-0000CM-Md
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:24:12 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48371119eacso12132035e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771529048; x=1772133848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L32EWnAhlxjYpU4wjI6tt0RgVcwm8HD1E6hyO3V/GzQ=;
 b=Rm9zKY/cH15UC6tC+Cnon1YOvIXpKViOKgBLEOjCjSrBjuqtT9F0bHRE9Fz1RGDNgo
 hVOx6PAmeSP6FI2XgA7mPeLzDPe6grMhL3QU0Kh99ESvmKXVieME5nLPIkFJHR1Y3+UZ
 pDrKcvPsmROTu8P6LFX1wEPBgtGntnknIRlRBZfmxJXaTtjJXdG1SzbNd5jAj38p+GWD
 SJ80qg04FYrBlA7d4eyx5xDA//xNwUn66SbY3P9UGEJPJ/x06BNeunOGO8IyHTZOa6BS
 sKRJOERA4v16a81nbuLdLhMZarwy/5Vgeshai6hn4MgqKdOWQv+ToURpXPYTjR3IgdE8
 HuHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771529048; x=1772133848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L32EWnAhlxjYpU4wjI6tt0RgVcwm8HD1E6hyO3V/GzQ=;
 b=hfF6w1AFX9EQCt6MO2hD6D90H263LgZU4r2Jhsi5VVibjx9bqvLgDAGwoq648TdU+C
 1c9fQH1GWnVeVDT+fXYU6OzbQd9nd0ZjefjHaC+I4K2BEbussMWUeqm7U0yMwYaxG7u0
 q/iHrRCAKewguAzOTM1eBKOnNHj0tI8cR0ZEUcsc42c+8UwOtpuBG53/2RK6lQuXfxkb
 2R8Elnii++cKmWqmEVkDMMTxpQrWEbjAL07SYPQ+OfTzdnQss9CLM9s6V2AxBppyRsv7
 IIhAxM/W6l2eLwROLbz9Ix8l46qtsbEr0iXRe2RTh6T0MF6zGsutbM/BBns42DEZKeVs
 raaA==
X-Gm-Message-State: AOJu0YxSOd1OMyCPkAJzsaqfVdA/lEPBsIg+kWDAnA2M+lrU7C4jCq+6
 73JWZiXf/jbBIUA/4UOFusN4rHE5oVu9aHlMwCCQEpGhYJTXRbbyIC51tVPiGfXtcfDyw+AXtoH
 x/D3o2Aq+UA==
X-Gm-Gg: AZuq6aKKVDnG3H4Uaoems/Rfah+sP1kXzWkvQGmQwk+Yt1PsbNoi1YyvuqfrJVMCrDJ
 WLlDhWKgCZaW1M6+Y6J4VmD5F/kruoGhYl6QMJd2wtAD8O5eO5RTVJNOSuBCTS1jerFtUjLPgAg
 NWYNzBiu3M2a2/9xNXgvPxYWIXIpJ7fIhoGxm1ILpV1jObcw4qBCWBWBVzlR7b4VoGd/14yoFNO
 Qp8GZf/J437/9yY1TQLfEvyHkXkY38VO62SENfnBRdjbd0J1Myd0/LZHOMd4daZMpZ41EqqJew6
 C6iCJgNuhyxA1KzVHqRrxMsE0cFqd1OEQOCAy+vCNDWukFjU55ZBsZnNPNvsJ5toJqgBTL3jHzw
 AxzCVKGmFt2+YZNjukFvfXBH+qQ6dkmSl8sN8+70aCDJNOu8j6459z2DGu/SKLAN0tANdip/k9q
 1M5mTkEn/WrZ9iaDc7ZmELnjZnclcqhONBtUQN2TshvZwELL08AWTyv3g6b0DoF4vZF81k6sQK
X-Received: by 2002:a05:600c:3e0c:b0:480:6b76:dfb4 with SMTP id
 5b1f17b1804b1-48398a65eefmr97612305e9.8.1771529047889; 
 Thu, 19 Feb 2026 11:24:07 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4839f99067dsm27066085e9.29.2026.02.19.11.24.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:24:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: [PATCH v2 35/50] target/sh4: Expand gdb_get_regl() -> gdb_get_reg32()
Date: Thu, 19 Feb 2026 20:19:37 +0100
Message-ID: <20260219191955.83815-36-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

The SH4 targets are only built as 32-bit:

  $ git grep TARGET_LONG_BITS configs/targets/sh4*
  configs/targets/sh4-linux-user.mak:5:TARGET_LONG_BITS=32
  configs/targets/sh4-softmmu.mak:2:TARGET_LONG_BITS=32
  configs/targets/sh4eb-linux-user.mak:6:TARGET_LONG_BITS=32
  configs/targets/sh4eb-softmmu.mak:3:TARGET_LONG_BITS=32

Mechanically replace:

  gdb_get_regl() -> gdb_get_reg32()

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sh4/gdbstub.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/sh4/gdbstub.c b/target/sh4/gdbstub.c
index 75926d4e049..4f36e800d2c 100644
--- a/target/sh4/gdbstub.c
+++ b/target/sh4/gdbstub.c
@@ -31,43 +31,43 @@ int superh_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
     switch (n) {
     case 0 ... 7:
         if ((env->sr & (1u << SR_MD)) && (env->sr & (1u << SR_RB))) {
-            return gdb_get_regl(mem_buf, env->gregs[n + 16]);
+            return gdb_get_reg32(mem_buf, env->gregs[n + 16]);
         } else {
-            return gdb_get_regl(mem_buf, env->gregs[n]);
+            return gdb_get_reg32(mem_buf, env->gregs[n]);
         }
     case 8 ... 15:
-        return gdb_get_regl(mem_buf, env->gregs[n]);
+        return gdb_get_reg32(mem_buf, env->gregs[n]);
     case 16:
-        return gdb_get_regl(mem_buf, env->pc);
+        return gdb_get_reg32(mem_buf, env->pc);
     case 17:
-        return gdb_get_regl(mem_buf, env->pr);
+        return gdb_get_reg32(mem_buf, env->pr);
     case 18:
-        return gdb_get_regl(mem_buf, env->gbr);
+        return gdb_get_reg32(mem_buf, env->gbr);
     case 19:
-        return gdb_get_regl(mem_buf, env->vbr);
+        return gdb_get_reg32(mem_buf, env->vbr);
     case 20:
-        return gdb_get_regl(mem_buf, env->mach);
+        return gdb_get_reg32(mem_buf, env->mach);
     case 21:
-        return gdb_get_regl(mem_buf, env->macl);
+        return gdb_get_reg32(mem_buf, env->macl);
     case 22:
-        return gdb_get_regl(mem_buf, cpu_read_sr(env));
+        return gdb_get_reg32(mem_buf, cpu_read_sr(env));
     case 23:
-        return gdb_get_regl(mem_buf, env->fpul);
+        return gdb_get_reg32(mem_buf, env->fpul);
     case 24:
-        return gdb_get_regl(mem_buf, env->fpscr);
+        return gdb_get_reg32(mem_buf, env->fpscr);
     case 25 ... 40:
         if (env->fpscr & FPSCR_FR) {
             return gdb_get_reg32(mem_buf, env->fregs[n - 9]);
         }
         return gdb_get_reg32(mem_buf, env->fregs[n - 25]);
     case 41:
-        return gdb_get_regl(mem_buf, env->ssr);
+        return gdb_get_reg32(mem_buf, env->ssr);
     case 42:
-        return gdb_get_regl(mem_buf, env->spc);
+        return gdb_get_reg32(mem_buf, env->spc);
     case 43 ... 50:
-        return gdb_get_regl(mem_buf, env->gregs[n - 43]);
+        return gdb_get_reg32(mem_buf, env->gregs[n - 43]);
     case 51 ... 58:
-        return gdb_get_regl(mem_buf, env->gregs[n - (51 - 16)]);
+        return gdb_get_reg32(mem_buf, env->gregs[n - (51 - 16)]);
     }
 
     return 0;
-- 
2.52.0


