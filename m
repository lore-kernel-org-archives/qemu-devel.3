Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 140C6CF45D7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQpE-0007Dd-FG; Mon, 12 Jan 2026 17:55:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQpA-0006xg-KU
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:55:50 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQp8-0004P2-T8
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:55:48 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so65437075e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258545; x=1768863345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iJJ3gBRSSej+H+nQd8C80Px5Z8M+3ay836FIJe8skzk=;
 b=gdaikX7O9V+ovrji1/JEzUjciQHtfBb5l9eX2Q74ZU87DlZwBA1CSlwOQLphRNVNwz
 kkQY5g7bno4A1q5LBC4iIHiJPWqyr88ZSC/tdXg3OhFEdSsGeJedbRuNU8ZvrWOUNDHG
 CTB3B5dlk3oZ//aT3fY+08H941eRuaPaBPUdEB0MiW9w9xwh/fwcobxtIm/g8s1udy4n
 XLVnvbZWe+qSWVrtOLGZe7wfduKHof0xXIS5Xym38Xt9PGeFHmBZH4I4eC/+mWgR9vHS
 cw7WGeEgcvK/iHdpYZp555H1iErIgDvA0CaoT9gKPgn9VLTh+CirAk3pKM7h/hUr+SXl
 cBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258545; x=1768863345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iJJ3gBRSSej+H+nQd8C80Px5Z8M+3ay836FIJe8skzk=;
 b=Xd6a01x7ZR914KWsCWU9lLTYjbnQFrjy462+W212encnzIv0X0gdqlh6gbGr929msh
 /w3+beNrCn84McGlUJXKc3Z0h/GyFkcWkCGN2JxXEvFoDz1IWJPe5FrG3TrRIzpgy95X
 AiWT/wJSPgmCWM+69PFh6uY1XWnhNWb/hsXrHJUsg0mkPlUd7TDYgw+a+r/42isPIL6N
 BNWhSAN+qQzcsHT+9rdzg7HrUottfDbZsBLcFLBMEkDynGAdCgAhpmPxsR2GZJLpnuoI
 frxTQV1L8nGWd0cjyeILRTUG/eBc0VNslTrlSqUBXkoIa0wLzE/5HtKMURx1h2+bnnMi
 kDYg==
X-Gm-Message-State: AOJu0YykgMLSE+VuHHUQtBVAyBJJH564QukWqlxdIkQ7QIHiHMXC6TiJ
 C81up9OukXrstpztkqYEBy6L6MysQozMhaPlG42ZvonO4k0aaP29hfp/zB3nOS57IhocIFqoPuY
 qmTJP1cc=
X-Gm-Gg: AY/fxX7XvbTVzpNnU2IHenVzcu/+FDM0zYFxN2KYVHkApwZ3O4GQ3XzqRfFY+141tfm
 b8v3TSEL6owQxVaWvlIbU6HjyLmtOsBlGdzMbxDdaqcbm8k/E/sSZcM7X4Wh343a7ckPUvQxqOK
 McklJqd0qo/KcToGQhudYo+XJPhXLpRZoRvEeVCYruks+Uq6EK6lyCtt6QRWqQ0XytQdNOhxzFq
 L3BgM1Gv/bOmIoMmdwygYCQvLVXTZm/t4Y2DFVmJZOFUfv4I2oi2uvZiXcYukSMOOERjs3PVF4z
 46sJgjtGe3zlIpSYhoyZA9PUjd7LSn/70hJvSMVfEFr3QEfCKqux19uipSgNuWEhSVI4RgpCQSs
 ul8kvric8l/q0ZHzHkfWlj4bh53CmWhLbuU75IaB2Judo2SZnWa7uAC7oFhQSdrZFXB8qsANUu4
 EagPZoJxBNRs7fByOfv3hl7yJQ4kFLrBNUJ4ANjHaM5ESqsx8KGxzFpUgetx/q
X-Google-Smtp-Source: AGHT+IGNGK+Sx/oUAFwBBIPqS43XgJ9iPi8aZKSK9lsYvuwilhmYOlKz4719rZ6Enp17toQfe1KALQ==
X-Received: by 2002:a05:6000:2209:b0:431:266:d134 with SMTP id
 ffacd0b85a97d-432c37617f6mr25169186f8f.53.1768258545202; 
 Mon, 12 Jan 2026 14:55:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e16ffsm41913891f8f.12.2026.01.12.14.55.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:55:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 59/61] gdbstub/helpers.h: allow header to be called from common
 code
Date: Mon, 12 Jan 2026 23:48:54 +0100
Message-ID: <20260112224857.42068-60-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Target specific variants can't be used in common code, thus limit their
definition to COMPILING_PER_TARGET.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260109053158.2800705-2-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/gdbstub/helpers.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/gdbstub/helpers.h b/include/gdbstub/helpers.h
index b685afac436..197592036bf 100644
--- a/include/gdbstub/helpers.h
+++ b/include/gdbstub/helpers.h
@@ -12,13 +12,12 @@
 #ifndef _GDBSTUB_HELPERS_H_
 #define _GDBSTUB_HELPERS_H_
 
-#ifndef COMPILING_PER_TARGET
-#error "gdbstub helpers should only be included by target specific code"
-#endif
-
 #include "qemu/bswap.h"
 #include "qemu/target-info.h"
+
+#ifdef COMPILING_PER_TARGET
 #include "cpu-param.h"
+#endif
 
 /*
  * The GDB remote protocol transfers values in target byte order. As
@@ -102,6 +101,7 @@ static inline uint8_t *gdb_get_reg_ptr(GByteArray *buf, int len)
     return buf->data + buf->len - len;
 }
 
+#ifdef COMPILING_PER_TARGET
 #if TARGET_LONG_BITS == 64
 #define gdb_get_regl(buf, val) gdb_get_reg64(buf, val)
 #define ldtul_p(addr) ldq_p(addr)
@@ -113,5 +113,6 @@ static inline uint8_t *gdb_get_reg_ptr(GByteArray *buf, int len)
 #define ldtul_le_p(addr) ldl_le_p(addr)
 #define ldtul_be_p(addr) ldl_be_p(addr)
 #endif
+#endif /* COMPILING_PER_TARGET */
 
 #endif /* _GDBSTUB_HELPERS_H_ */
-- 
2.52.0


