Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29949CFA442
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 20:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMB8M-0004m9-20; Thu, 20 Nov 2025 15:20:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMB8J-0004jX-HR
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 15:19:59 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMB8H-0001T0-V1
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 15:19:59 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-477b1cc8fb4so8493265e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 12:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763669995; x=1764274795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dSqacx8J6/zgtlp2PptQ1lYmcrsegZl83a7tVHbquyY=;
 b=Jd+PQMLi4MwgW93sqPUhGqnLZtnppyKtW8bRg3xui9uyAu8awOiX2eIfd2FqCbJaAT
 Z0jNJuRak3PDcuNI+4K60HumEOzFHbA4Kj4MUPs7aEhjVc320+To8CfI/nG5sctM0UlC
 E9LpxuV1zeOuifRR3bxsr0D4fiF4f/3NgRWde+SmFlbhvSYL5ru9cnGkXgjlKfl+n9Sr
 Q78zUTNcu62VRvqEV5KiQDvAfHQAz7O9DvMRrGfkblsxwKQRItubdqd/SI6SXBN6zyp/
 cKyWXOWA32bdbuo/F0pvDRGAjO/s9xIwSfqNflTeJVY1+DCM1Ngt3AkoFvdgGv4O1ZhC
 GRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763669995; x=1764274795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dSqacx8J6/zgtlp2PptQ1lYmcrsegZl83a7tVHbquyY=;
 b=TaWKwPMVOkPxYtTOqtfvEdWpzUMPyKev/ZNVuZVtryrFrwJCKFpGKb5iUyMbI/QLkk
 MfMqQB8oH3UySlfH40WvXpwNLId+JzRSL/jZVue+iytN/O0y3sDTp06iQkBBw/XYUp+x
 FLBy0kF7HVbx2nJtTqOR651Rh1W5za3OM6WjZbJavHRW28CNJzKGgG3H4bUcepEoGW5m
 adu8tNPWcOJJ3Tnm42Z9KiGU0Frjy6FJ4HpqKIelEtcQe75NcQxt0JnP+58kvrOfKOrM
 1TPM29bjNNDxCi9DK6+A2wDBM0hy83Huo7fxrOPz+kUVWfrV8H4I0O4e211oFyW6gE5l
 SzNA==
X-Gm-Message-State: AOJu0Yx2dHakpe4nvr3TS/CHPntSGIE1H6z/00S/u2wxcEEvXmNBTLMH
 I8XL6N3FVaTfsmBIBopECsswSjwPIUkpSQZCFzy6h4lcUXceMLPmAPv2NSdBV6FoiQXFDr/gBW7
 12eGggSxd6A==
X-Gm-Gg: ASbGnctr6IDxb5OpVymQeu1eYdwC/9jfrkqYlUigeTzTXjNjeE8wBYMCWcI2preHFhn
 9WFucKuAdHky+0uQDfxbEw2W3vC9u4SeZWaocSgwfLEgk/CYzVX8M4TO6SJXc6kY8BaiLnW4AI6
 lO0CegGoqFJRwi86PWR9EJkjL2mUggbS9XRDg8eVHiLPuixqFmNtP3qKBxmfkjyPQFqC7xX6O9m
 ybNSyhCTwMPvRSemambqVNcfhbZIy6YUsmKzooaT6nSr5FeyQqMd6KDv8AVzXMkAhy6MYJN4fXE
 a3YvxiDQttY9AqOhQ5vmoraWeoZ0clULVtOYsR783I8rlwu1J8GLCdFmCznmvooAkkR+8rxyC7U
 1DqfsWM/TWPnv8seR3bcwdFaNjtoYWi+Ill/8ZT7eDX9OyxmKi7nzcYxzB65wkz9j7TTLEMFcof
 9iMIB9uMtjvtFH9Dv+MRkfHzIrb4i+XMhAzD7E39TfoJNnIBr07NSnfbUB6YZj
X-Google-Smtp-Source: AGHT+IGDOZ0VH4StGb/uuJBcaSxcZgdxUHQ7xHC19rhVjn/nV8RR9UpBBoBaD/UKOB1g0nLEd0QQ+A==
X-Received: by 2002:a05:600c:b93:b0:46e:4246:c90d with SMTP id
 5b1f17b1804b1-477c01811e8mr87225e9.11.1763669995092; 
 Thu, 20 Nov 2025 12:19:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a9dcd891sm71487425e9.7.2025.11.20.12.19.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Nov 2025 12:19:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC-PATCH-for-11.0 v2 5/8] target/s390x: Use big-endian variant of
 cpu_ld{uw, l}_code()
Date: Thu, 20 Nov 2025 21:19:16 +0100
Message-ID: <20251120201919.8460-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120201919.8460-1-philmd@linaro.org>
References: <20251120201919.8460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

S390x instructions are always stored in big-endian order.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/tcg/mem_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 24675fc818d..84d901c2008 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -2437,7 +2437,7 @@ void HELPER(ex)(CPUS390XState *env, uint32_t ilen, uint64_t r1, uint64_t addr)
         tcg_s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
     }
 
-    insn = cpu_lduw_code(env, addr);
+    insn = cpu_lduw_be_code(env, addr);
     opc = insn >> 8;
 
     /* Or in the contents of R1[56:63].  */
@@ -2449,10 +2449,10 @@ void HELPER(ex)(CPUS390XState *env, uint32_t ilen, uint64_t r1, uint64_t addr)
     case 2:
         break;
     case 4:
-        insn |= (uint64_t)cpu_lduw_code(env, addr + 2) << 32;
+        insn |= (uint64_t)cpu_lduw_be_code(env, addr + 2) << 32;
         break;
     case 6:
-        insn |= (uint64_t)(uint32_t)cpu_ldl_code(env, addr + 2) << 16;
+        insn |= (uint64_t)(uint32_t)cpu_ldl_be_code(env, addr + 2) << 16;
         break;
     default:
         g_assert_not_reached();
-- 
2.51.0


