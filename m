Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848EAE9A054
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9cx-00074h-9o; Thu, 19 Feb 2026 14:23:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9bz-0003lA-Rr
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:23:03 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9bv-0008M8-EC
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:22:54 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48374014a77so14359155e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771528970; x=1772133770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gp2sKwAqzwE1qDhhmH0nRCkz7CQKwljiKEsZ2Elj5KY=;
 b=DtKQqISSQ2V8qQT7eQjTVVxBS9f0AAGSos87trXNG+f44L/fv8ZguCLMhFAL297Dom
 F83NBGOUG0Fol4jr1lSUKVMQCWT2esGLCsmdA9SRGTuy26WLr9Yg8jCE3OWq0zANoh+2
 i+P4SpE6prxXSEccy6DBaPctot8un1eXtXXuYxSeqbG/exCJlSIRlvFwkmuC/Or2xSg1
 AeU87Bkml0gqdmaH0ddcZ0Ktkh+nwI9CCXmOS8W8yQr3m8YHKOhFJ4JiEp0THNC+QAPP
 0qKyc9eeZww8yD/u4Jk29+JtPcEeFt1OOQA67EDcIk3VPSm1j7LVYIfgF6VrWtggwaC/
 rwog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771528970; x=1772133770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Gp2sKwAqzwE1qDhhmH0nRCkz7CQKwljiKEsZ2Elj5KY=;
 b=blplmzT1GJ283agYp44oFXtoeIa/aOH5GdRYyzn1pl+mCa750WbBXgg5B7t1ClweGM
 fkdfc1ETe69PPRE4xQxp3SNMGuDt1OJYunEbXvLUtD06Tj7CJsTTSsXFnah6YCpbJ/jN
 Ie2FwHEoWUc72R47upZm9HBkxCt/BdEx6D88jHvOr7m97dSGHxLgHzzTtmtPCNqqj4qJ
 VBsAutxUp/Hl0gziGiWP/IKGWQDptpymvqyubI/ebNGOsNpWTiGoQ9yS77T0Gsj4HyfW
 RZy7Qba4cmlyBZQv3QLt77AQoCgXWZepkw+w4HZnZ4fVlWdehWbfPGgPxMaz9KiOovsI
 MRXA==
X-Gm-Message-State: AOJu0YySFU3TL0z4pqHn0COEKhBKlJdG71284BpN9BaIldWqyAiK4S61
 KUtxY3IYgDUHf2gnNv9cHBJgqftLAzPvQU/8RZaGF4WGI9xu8Q4I877wUHheqFtN7MztJE7eSFp
 CmdZKwHl9Iw==
X-Gm-Gg: AZuq6aI0cpC4DNUKx64vmP6ee2cluTqC10c2c0ZFcjMPFWVQeA0GxkhOpOEGYzQz0m8
 MqSwtEIjO+ya6flVrmmpD76v5NokmgogBY3Sb4v85uOJ0SGO864APgifV5T1sck3ab+27LU4EOf
 Xma+qvfGtGzMiRskkh3ASr4ayl29lOFJZcXHBWZzNCaH748YBqmnfm1V2KSb5tbp8jibKjf1xM2
 XNaoYwR6mk5bkQbXauNliQu7SzRBFx8NmlsFyaa3gbuD88lUvq8cI4TkSHjgZivZqDJTqIknKB6
 3sLnrnMrwOtzKrJAwKKS/SXzcDtqi8RKNqxx54nVg5Cjz+C54QUZt7lpNBRDXVCUM9p+vSi7Raz
 mIbMPdMYmrGBWA4WeXGU6t0PMrJjYlK4AmXtKye+gPo94EWMqHW82KWyuvJwrMHpaE09F5fd36m
 672uxjJlpbIm4pD2d+raXz/PsFSh/ynUshLgaoMPwwmFNwhojHS7F2KyvHuQqx0KlXpegELh6x
X-Received: by 2002:a05:600c:3e87:b0:480:32da:f338 with SMTP id
 5b1f17b1804b1-48373a0f961mr360858765e9.14.1771528969670; 
 Thu, 19 Feb 2026 11:22:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31b3e0dsm35954695e9.1.2026.02.19.11.22.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:22:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH v2 24/50] target/sparc: Factor sparc_cpu_gdb_write_register()
 out
Date: Thu, 19 Feb 2026 20:19:26 +0100
Message-ID: <20260219191955.83815-25-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Factor sparc_cpu_gdb_write_register() out.

Prefer ldn_p(target_long_bits/8) over target-specific ldtul_p().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


