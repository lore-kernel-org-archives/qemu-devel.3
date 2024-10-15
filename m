Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68B4D1D879
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 15:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0jjc-0000I3-Kw; Tue, 15 Oct 2024 11:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jja-0000GE-LE
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:45:18 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jjY-0000j3-Qw
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:45:18 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2e188185365so4282474a91.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 08:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729007115; x=1729611915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9XkclaxhDgiPYIH/QNOgI/sKQUHpGlRZU54F7qGZHXg=;
 b=b1HFCV3dpbcWQHKDfoaQerhWKsjbNAz2yYuNe/6MDoeoM24kBvL+x0QPOnFVqYtGUO
 IOC9HCU7UmKarGsgggoGtLD4VPuXv3RB6qoD9zWTQCHtEh372/5gz+TMEynQTZNaL9X5
 A9YcByNUP5PB4iTFrhWfjVR0gjtV/CO0iwurFzeGJPXsYcWDOx1RM341bGSw3/vFxQnq
 n/N+CmmRuBOBTONqF6YG7eYjNkm46gg6fenXK4WgLERJzalE1DB2a/dkRb2hOwA+lEV8
 Y0ndYCuJEjSIJnhI+wa+Gol0+M6DX5+fj4/BfEzCbb17CIXi2zG3H6WV/3leeWzP3v8F
 xMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729007115; x=1729611915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9XkclaxhDgiPYIH/QNOgI/sKQUHpGlRZU54F7qGZHXg=;
 b=rvlKo/74R8KrK2BQN90SNx5SrPR7grNx9v3dVVf7wSYHVjGHOtYs7FCD8JXg+2nekV
 PGwUuu4Y1H7lDScsv71KPFyfmOyy7wEHEWTUYPadcpO71OMkjhiZcK7TGwnZfNUSaOpZ
 u7V+6Sxr9IXAsC20KAUo5WX0Tp+DVJtIsHlQGJJ9eWfq+oWsr3vt7ok9tVvun0FpXarm
 HIq/f0G1rzDi0PFEojzd568aLcsLn42Imi4nntZY41xYU4iieFjlCkeZ9gGJYFow76Uc
 R1D9iK6tcxkkDsgyHAWsEmoBlw7pR7UY2Yp0XSj35bR+exkhXs2pTWYYFObvc/1YVLxa
 9Vjw==
X-Gm-Message-State: AOJu0Yym6vb8WaLTwWHDP6i/1nBMq36FCf7BreRAbuDY0tpvea+GgdiE
 Idh9EkmsS3Zr8iQk0rh5fh5XRvKLSZ3BecF0j22hEA1RF+FnMeKcNqaXFOimJXh2lOkjJHRwLdB
 6
X-Google-Smtp-Source: AGHT+IFH7SQ2Jwfjk7m/lYRL9wsdXQWI6YTxXSa9KDKC26f3L9q3siWb5i0gHJHk2IfhXAp34dPCPQ==
X-Received: by 2002:a17:90b:2242:b0:2e2:e743:7501 with SMTP id
 98e67ed59e1d1-2e2f0a52ef5mr15627861a91.8.1729007115158; 
 Tue, 15 Oct 2024 08:45:15 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e392f60480sm1957290a91.40.2024.10.15.08.45.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Oct 2024 08:45:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/33] target/hexagon: Replace ldtul_p() -> ldl_p()
Date: Tue, 15 Oct 2024 12:44:13 -0300
Message-ID: <20241015154443.71763-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015154443.71763-1-philmd@linaro.org>
References: <20241015154443.71763-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The Hexagon target is only built for 32-bit.
Using ldtul_p() is pointless, replace by ldl_p().

Mechanical change doing:

  $ sed -i -e 's/ldtul_p/ldl_p/' \
      $(git grep -wl ldtul_p target/hexagon/)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241004163042.85922-3-philmd@linaro.org>
---
 target/hexagon/gdbstub.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/hexagon/gdbstub.c b/target/hexagon/gdbstub.c
index 94e1db8ef8d..557b3029785 100644
--- a/target/hexagon/gdbstub.c
+++ b/target/hexagon/gdbstub.c
@@ -52,7 +52,7 @@ int hexagon_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     CPUHexagonState *env = cpu_env(cs);
 
     if (n == HEX_REG_P3_0_ALIASED) {
-        uint32_t p3_0 = ldtul_p(mem_buf);
+        uint32_t p3_0 = ldl_p(mem_buf);
         for (int i = 0; i < NUM_PREGS; i++) {
             env->pred[i] = extract32(p3_0, i * 8, 8);
         }
@@ -60,14 +60,14 @@ int hexagon_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     }
 
     if (n < TOTAL_PER_THREAD_REGS) {
-        env->gpr[n] = ldtul_p(mem_buf);
+        env->gpr[n] = ldl_p(mem_buf);
         return sizeof(target_ulong);
     }
 
     n -= TOTAL_PER_THREAD_REGS;
 
     if (n < NUM_PREGS) {
-        env->pred[n] = ldtul_p(mem_buf) & 0xff;
+        env->pred[n] = ldl_p(mem_buf) & 0xff;
         return sizeof(uint8_t);
     }
 
@@ -117,7 +117,7 @@ static int gdb_put_vreg(CPUHexagonState *env, uint8_t *mem_buf, int n)
 {
     int i;
     for (i = 0; i < ARRAY_SIZE(env->VRegs[n].uw); i++) {
-        env->VRegs[n].uw[i] = ldtul_p(mem_buf);
+        env->VRegs[n].uw[i] = ldl_p(mem_buf);
         mem_buf += 4;
     }
     return MAX_VEC_SIZE_BYTES;
@@ -127,7 +127,7 @@ static int gdb_put_qreg(CPUHexagonState *env, uint8_t *mem_buf, int n)
 {
     int i;
     for (i = 0; i < ARRAY_SIZE(env->QRegs[n].uw); i++) {
-        env->QRegs[n].uw[i] = ldtul_p(mem_buf);
+        env->QRegs[n].uw[i] = ldl_p(mem_buf);
         mem_buf += 4;
     }
     return MAX_VEC_SIZE_BYTES / 8;
-- 
2.45.2


