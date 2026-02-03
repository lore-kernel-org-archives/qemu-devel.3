Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450F9E8783D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHz3-0003fW-8R; Tue, 03 Feb 2026 10:06:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHz1-0003Ri-GS
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:06:27 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHyy-0002IY-VI
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:06:26 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4806d23e9f1so64316895e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770131183; x=1770735983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IBMz02HxPx5Ep8SztZCzfzvBJYPYJifqEnFHjrUKd+Q=;
 b=UB55AK5h1gOGh6jXhhYwbf5ZONaKs5wWrcXq0gYKGMUiyA7wBqJzM+cPiEHZ+W3RSa
 h1L5myGeNwpgJRByaNiO9SzXzlHN243L5hbXknmYst65Mf3BASFMexS72nt6EDuYMRJR
 WWE3CfRzBeAALb8+L3IqqCriWAlqrl+Wp1JOv6QHdfU99WhR25K9mI6QthkFECVAcHiq
 s3NM8HvkOuQHZOwxpyb3+JY9vaJTOQ0tAh0MHF6uAUzofH3EOuSZJ0HMTMExgYDTL9Kx
 EZ6veWnhzxs0qbDwmPIezMUt1PE4qSNPVA1i9McnmqpoPO59OtVniv7baY9fB4qtZGXM
 5vSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770131183; x=1770735983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IBMz02HxPx5Ep8SztZCzfzvBJYPYJifqEnFHjrUKd+Q=;
 b=EY11trjY5HuZrfkJ7iZBibcl4mk4SEA5CBPw/PnuRlL9k7ZlCKXrPPi+kS2PfeSij9
 XHdlABm0V39GcljsjHsmDjqroYVZ0Qmu+A0iGNuFAcLvHMfP0dSGB+tWZ5Y6k7mUJN2b
 wt4T6yHyM4spltmyUxi0cS3aXAYQpc/53LhyD2OffiQ3iMf2LHJVzRQPa3mJfGrgrpmx
 0via3b/wLFW8440Xl1KH1cW++Jtc2M4nDSk8I4XWDhg/4ekUMWFGkpU4Tn8Qv3QjvS4l
 WR+jX7/Q/oMZGJZ4AAu/71c0mS0VERz1JCvQ63dDF1CuNalMjRSY1APCGk3PR/PEr2Fp
 q0Ag==
X-Gm-Message-State: AOJu0Yx2JLS5QH/AettLkP7TWpraZZdkq7S+KoL2hPqGNrg76EYBWiKU
 M7gnLgHA1UvNi7TbrHDTCElPCTGIpU7f5DYsH/85N4Z0ozMip7WVS6QA9ijM2WkiOIXL5R8GtGX
 +ROeAv/E=
X-Gm-Gg: AZuq6aLr9O09x0xbvzCtjECILNjBBu3tIWXYo6pd8REFjqcEl/zoWAiV8P1r+ER1Zxy
 NXgEswME908VSwFV3pkryJ2FIFVKhCDvmP1om3XlHLwWiASimgP0jgCWOUmiSSU85vzMw/LUsCt
 2dVl14d/Y2usDcpoJaisWhXIcFK5kjI9WEIvxR/ccU56tD8NSUQkBj7Xxk0OY5JCvM70a240Rs9
 tWgJZe8Y72UPa1HZz70hkyPTvmsDE0domwhVAbTiMvt53YLNn86MJK2SW/xB0VqIa6/hBU169Ix
 +sQVC7FwJgjEOQfVF+4U7xx0W9ihNMo80qZ9YJrYWaQWKSq6i8j/1t5QMw70sSICNF06V4QEFn1
 fZ2SIHHiBDwNL7VVIbGOTF4NhkL+F+Yiae9Sytz/lb6Dov7vB1smBwYSdidp4dGbGJyt+5JNhVE
 YVSBVvb/DZzdvm0x1+hgWAKQftilSYbKzs1L73JE8VgKbShgkDqagpurRsSc7I
X-Received: by 2002:a05:6000:26c1:b0:430:f3ab:56af with SMTP id
 ffacd0b85a97d-435f3abc7b7mr22465818f8f.48.1770131182902; 
 Tue, 03 Feb 2026 07:06:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e4757sm54692144f8f.5.2026.02.03.07.06.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 07:06:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/30] target/i386: Inline translator_ld[uw,l,q]() calls
Date: Tue,  3 Feb 2026 16:04:20 +0100
Message-ID: <20260203150436.71907-16-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203150436.71907-1-philmd@linaro.org>
References: <20260203150436.71907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

In preparation of removing the translator_ld[uw,l,q]() methods,
inline them for the x86 targets, expanding MO_TE -> MO_LE since
the architecture uses little endian order.

Mechanical change using the following Coccinelle 'spatch' script:

    @@
    expression env, db, pc, do_swap;
    @@
    (
    - translator_lduw(env, db, pc)
    + translator_lduw_end(env, db, pc, MO_LE)
    |
    - translator_ldl(env, db, pc)
    + translator_ldl_end(env, db, pc, MO_LE)
    |
    - translator_ldq(env, db, pc)
    + translator_ldq_end(env, db, pc, MO_LE)
    )

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260202213348.96754-1-philmd@linaro.org>
---
 target/i386/tcg/decode-new.c.inc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 086a3bcec18..bc105aab9ea 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -315,18 +315,18 @@ static inline uint8_t x86_ldub_code(CPUX86State *env, DisasContext *s)
 
 static inline uint16_t x86_lduw_code(CPUX86State *env, DisasContext *s)
 {
-    return translator_lduw(env, &s->base, advance_pc(env, s, 2));
+    return translator_lduw_end(env, &s->base, advance_pc(env, s, 2), MO_LE);
 }
 
 static inline uint32_t x86_ldl_code(CPUX86State *env, DisasContext *s)
 {
-    return translator_ldl(env, &s->base, advance_pc(env, s, 4));
+    return translator_ldl_end(env, &s->base, advance_pc(env, s, 4), MO_LE);
 }
 
 #ifdef TARGET_X86_64
 static inline uint64_t x86_ldq_code(CPUX86State *env, DisasContext *s)
 {
-    return translator_ldq(env, &s->base, advance_pc(env, s, 8));
+    return translator_ldq_end(env, &s->base, advance_pc(env, s, 8), MO_LE);
 }
 #endif
 
-- 
2.52.0


