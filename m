Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96D6E7545C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRJ5-0006ii-5C; Wed, 24 Dec 2025 11:01:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRIe-0006an-BB
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:01:38 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRIZ-0006Lw-BX
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:01:18 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b7cee045187so1079213766b.0
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766592070; x=1767196870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y7LlkqUnSiDvgUOMZirWuDEM7gLUdON5nHRETaU0k+Y=;
 b=HLgqlOBmkLLhc6sppzY4+cvIkx8U2n2GILkaaUMCXs36JxSyngg1PZcY1p2s+NHgiO
 LRAEp5YA0nSTEeljrt6bA1RVf6hvzeOCwRU/Iv6grsWXbgZVPRawKAM2nUIOD72YlY58
 mQc/Hh/G01pQBfcBsoJK6KYcj+r1/20sYNIac0mivALNj+fz5kKka+Pdas6ovh6SVrGl
 SzMbv6oHt//M9W/iluZsfPjlx+LjztLmdQiGkn1oYyCC985UoBqgfjc91LARgIdAIHVz
 ekc/AOsOejsnIaiEDQb1bfZ/w2X+xXGQF2Dm48hsF3H2Av3aeiycBLeYJBtBM6ozMY7b
 QUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766592070; x=1767196870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y7LlkqUnSiDvgUOMZirWuDEM7gLUdON5nHRETaU0k+Y=;
 b=MvOVAGsgvayHFRrycM/upQ2/YsljQvdE2+HqYsWxwWD031BzhjX/xh9lF+03EOtR23
 r596ABNSd1d3p6vhaO1+FI424GPLCRGBIDRDFUeWrcJWl5bega9TISjzxBM4u5RC/+YD
 wNctbWNpPowMA7SmWyp8exxmXVdpvW+4RF6vjRaYWtJH3x0lYqWHA3v4+tWJd0+/zhMr
 kPyEM42N9JQeYSz/k3zxWfD3Qz//rzQUbhxytxanWYgk5iZ/CiCHvyQiOel4BiDLLFfC
 0GjRDg85Hn7Wn3dbnSyDZ8OaI7TZuD1pdwLIzkKKrJmGFPTn6d1cBx7vBmRgOFqkmXLW
 /9tg==
X-Gm-Message-State: AOJu0YxM4ComnT1C7VxUyUfW1XLhh5HG2GKHu0k12D9yEeaXQiSISfCA
 Lqj347KnUa4WqwrbuSrAThY+L6DITQvXDcgKZYj2jVC2O+WQ8Y2PtDcvIniRB60AcSP7cflYRRs
 fDIJjSnU=
X-Gm-Gg: AY/fxX7Yv/Amz+WQwmP6okme9qz1QivS9LYonYs+/b8Ezv8f3GFIUI4Ox1/itmh6F59
 wuKSRusDs2NLjFu3b4dc1EANknXg9MWO6r6uPy5ERpnGdfFaWrtyOj7g/oMXGpIIKLQ8ovo6cDd
 sTgwSEaWNRiiXLT9ZRcc7ERqdiChQQj06uO6WSRUfS6QCcH1UKo7vc/2Pa51zeypZD4n1Ou6uaz
 HEBwok02fyhNApkE1sYfHvyfxLqDAwaJRijA24r5TLpz8OXrjVW6rkjqAcc5id6rIvzf7BJQ/K9
 28I6a0Hj6dNzpO+TxrWwkSYnoE6t5KBqps61R1chk7M7dIZ0AkmGlFp3pygzz9HKxcTlVayT5rn
 bp/iG2Zaxzt4TX3tc+l5OHKSl6uOpWp+5SMyhWjBeFgZ5hybmO2OcZI9iqwN3APz8CL5cUIdsNT
 uy1eZF5krn5GNhPeAUgXPsXHdh0qNT0v0buIyXO/9nMLelJ9Jy4ny+5AQ=
X-Google-Smtp-Source: AGHT+IHDW+02wxJfJV4idVw0Baj3VFK3rcdn1mUbF5kHj7M5lMaoXVEIqxKPeC/Ai8Q0o/88v1mnkw==
X-Received: by 2002:a17:907:948a:b0:b79:ea1b:f13d with SMTP id
 a640c23a62f3a-b80355b7986mr2380994666b.2.1766592070246; 
 Wed, 24 Dec 2025 08:01:10 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037ad83dasm1857633966b.25.2025.12.24.08.01.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:01:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/6] target/alpha: Inline cpu_ldl_code() call in
 do_unaligned_access()
Date: Wed, 24 Dec 2025 17:00:36 +0100
Message-ID: <20251224160040.88612-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224160040.88612-1-philmd@linaro.org>
References: <20251224160040.88612-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

In preparation of removing the cpu_ldl_code wrapper, inline it.
Use the return address argument.

Since Alpha instructions are always stored in little-endian
order, replace MO_TE -> MO_LE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/mem_helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/alpha/mem_helper.c b/target/alpha/mem_helper.c
index 2113fe33ae2..572ea9cb418 100644
--- a/target/alpha/mem_helper.c
+++ b/target/alpha/mem_helper.c
@@ -24,13 +24,15 @@
 
 static void do_unaligned_access(CPUAlphaState *env, vaddr addr, uintptr_t retaddr)
 {
+    CPUState *cs = env_cpu(env);
+    MemOpIdx oi = make_memop_idx(MO_LEUL, cpu_mmu_index(cs, true));
     uint64_t pc;
     uint32_t insn;
 
     cpu_restore_state(env_cpu(env), retaddr);
 
     pc = env->pc;
-    insn = cpu_ldl_code(env, pc);
+    insn = cpu_ldl_code_mmu(env, pc, oi, retaddr);
 
     env->trap_arg0 = addr;
     env->trap_arg1 = insn >> 26;                /* opcode */
-- 
2.52.0


