Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8A2D6CFAB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 22:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj2uq-0008HL-Lg; Thu, 22 Jan 2026 17:12:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj2uk-0007v3-JO
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 17:12:30 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj2ug-0003WK-Tl
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 17:12:29 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4359249bbacso1706655f8f.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 14:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769119945; x=1769724745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dsgN08xwFykkgI55V8CeZLzuXOe+HEtSRM2XAs4O99o=;
 b=fXqzzD/4xPf8dS+eAjLRrbSjd8wRgDEypCAAY3WyAHJuY3ifXzBUtc+zbZ0wLN0QQY
 dN/D5oLUsB7cw7QtWT8BkZPs87Yjiqa86/rkIwpXUCXT7e6xCYzu9WVjbpEJKEds0xtt
 48mWQplD3zSpQxkzz9gXsCsgIp12TT6P/XB6oG8JSOIYieySUccF1xf7O5l59Gkc3mvo
 Mlc8+K4c7dyuPqSbRBatVpr896xnaO/cs+e+CFinD4+Q1/phWl+nDztc8Au7sQ6QVrHo
 2po+EsGdF6GQUfv8Xw+Jed39x3Fx5J66sJlbDrNpe22a7Kf7W0xKBuZzpLhdgLosJxiN
 0D+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769119945; x=1769724745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dsgN08xwFykkgI55V8CeZLzuXOe+HEtSRM2XAs4O99o=;
 b=XcI41q7Xfgy6I6LCmhia+dJHUGag6W+WzoClG25A3g570/pHIwMxAsFAMg3eNCaH23
 G8Iytr2abiXepipItL9+YiG6b/eNX9QgAZgecjuUPUn9ybfhZeRN32jGdoElLdheQrNk
 WEre9ks8ye4ZIO4wp/TIYMS0tV4b/SkFdKtY6uOrhIN5rdhSTzqGZAXa3ZckytnhBIFO
 m8mN6ztM8WmEDn5LFMTftpEELVyoSe3/MHSPT2kwdzBohtDtCsntAa/eI3buq36JqKZL
 FsqCebPYOAbU0m1pvylZdbbivlEmcUaGluv8xx9xKJ1TxlcDvrux4Qci1yMYLM9tGDog
 H1JA==
X-Gm-Message-State: AOJu0YzPSz3OlvPnsKI16353UVhA09G/9kcHzUDPV2cH5u2sQknDIBIs
 mGdaDTHLmyE2rJjnbt3R6NZHSVVZft16rKOWLp44NV71du63ioiIp2alq2orfUu/RF9P9r6YZxh
 RL6EpZok=
X-Gm-Gg: AZuq6aJ91t8+ZWVV42qMmYUyQ05ph+rzEtFlx1U1ro8lY0mOjyvmb6vxXvWIEIhcCsu
 RnhwuTP0SBKPfRzGByxTNI2hKOoJCg4F6dtHFkL2bv4w01ypJyZIF2nhXhtktGg8vni4+P93oGW
 3m8ck9ge+Fw7IOazOF+VIKFBaV89hpZQIuNUR2HqAkkj+1rpJN8g3/X90ZJmIAlxZDJd2PedzJH
 zio+0l9MOO8Gqy66cnrUnxhXAHdC8M0GPPsN/6QfP6NIjtM8jV7ZOXwtOhqJXV03aG8wXtuU9c9
 17/ptDXHQ5e4wZpmF8TU7WTV2LbnaqVDwPPzCf2aAc/p0Jgm5hBKwEvJ2YB9yVRyjXGldrJlYDv
 tjhv7mf5lOQrfXGBsNv/QYWwqOX6RMbV3xxZe62jAWuN0vZ1GgDaeWE4w4EWXRGDowVlJLM6chC
 wzUWB3ZnYC9ftucYQe1ArsjeUsvUue12DyKhu+ne5tINE9QxXpi7UqtzDq1/bV
X-Received: by 2002:a05:6000:4382:b0:431:771:a50c with SMTP id
 ffacd0b85a97d-435a5f5cd09mr7190474f8f.1.1769119945167; 
 Thu, 22 Jan 2026 14:12:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7b41asm1663647f8f.39.2026.01.22.14.12.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 14:12:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 11/11] target/ppc: Inline cpu_ldl_code() call in
 ppc_ldl_code()
Date: Thu, 22 Jan 2026 23:11:05 +0100
Message-ID: <20260122221106.57184-12-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122221106.57184-1-philmd@linaro.org>
References: <20260122221106.57184-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

In preparation of removing the cpu_ldl_code wrapper, inline it.

Get the runtime endianness with mo_endian_env(), passing it
to cpu_ldl_code_mmu(). No need to swap versus qemu-system binary
anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/tcg-excp_helper.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index 77d21523a5b..955afc40a83 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -428,22 +428,13 @@ G_NORETURN void powerpc_checkstop(CPUPPCState *env, const char *reason)
     cpu_loop_exit_noexc(cs);
 }
 
-/* Return true iff byteswap is needed to load instruction */
-static inline bool insn_need_byteswap(CPUArchState *env)
-{
-    /* SYSTEM builds TARGET_BIG_ENDIAN. Need to swap when MSR[LE] is set */
-    return !!(env->msr & ((target_ulong)1 << MSR_LE));
-}
-
 uint32_t ppc_ldl_code(CPUArchState *env, target_ulong addr)
 {
-    uint32_t insn = cpu_ldl_code(env, addr);
+    CPUState *cs = env_cpu(env);
+    MemOp op_end = mo_endian_env(env);
+    MemOpIdx oi = make_memop_idx(MO_UL | op_end, cpu_mmu_index(cs, true));
 
-    if (insn_need_byteswap(env)) {
-        insn = bswap32(insn);
-    }
-
-    return insn;
+    return cpu_ldl_code_mmu(env, addr, oi, 0);
 }
 
 #if defined(TARGET_PPC64)
-- 
2.52.0


