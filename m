Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8477C0218B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 21:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb5Bf-0004rp-GK; Thu, 23 Jan 2025 16:56:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb5Bd-0004r7-RM
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 16:56:29 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb5Bc-0002kB-A1
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 16:56:29 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso791473f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 13:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737669386; x=1738274186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=axO9L9zvQNnbH3QdpMtYTEFgm/4DySr8I7ccuAMR/ZA=;
 b=FKOEFDr1EFefZD0yugHOrspdszTIlAuZtREP6Dj+0cTxXrYe0j6fvtUYiPcZUQt1wa
 DiAbHY+niOr1OGHSl8CAtTygVdObsHjWjtPbStRz7xOrIxIra+wZwO4p+x54cXU3C0o2
 IFlnDjD4DtZP3PBBWGT8cw1CaU2R0lkqwmcET+QWdXekbwuLIZ8SL4/UdJeY7ESkmrT8
 XPNXvV508rN9xpxoDHIvcBI5T8rvPkbr+RTDW634EcgF7LY5KQPTD79/cISgeQT+q+fy
 H6kIDMqFkdk4MT3ou0ZGzYUOA+rn6YieUE5QH5ihf/tjDlpBQYpOi30DNdWqVmxqXys/
 WT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737669386; x=1738274186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=axO9L9zvQNnbH3QdpMtYTEFgm/4DySr8I7ccuAMR/ZA=;
 b=eGlKVUNFdn7VzxS/4VH7I4FCuNEp9pTzJd3SngCuXN4DeBNjKE5WjODYk7vdCwp/SX
 /TnEF7ffvkjKenTHH3YtxnxRdAj0FHDRSvuBFaH8zjVxEY1+o3KRZUe1wFcX6h9YSu9w
 2JzTlCYBmMWOrnsR39+64Xhx/oCPPpjVYZiiNl032qSVquG0aMA7tigQbl8G66pMHqqx
 bxPWnEkk/XAwjihYf9nYO6v9cjSKU1Sx5GEpjJUWQ5kg3ZlrR0ZiUDf+3vfzKa51PmTN
 K5a2xE7hoDvsdwwUZoUzEOOrLBKvjdZkPsi3dC8PtAa+4JoQQCn4pBW0Og6Qfplgd2I4
 tKkA==
X-Gm-Message-State: AOJu0Yy//k5327GSPy/NpjAWuAxArZFPmSm0oSYMRE0PVowCbOZ65gbc
 MVQrZIlr0Lgl9lTdaoC0pfGQWVjqFa/L06kogGMt2Tg29kksUOq5Qb7LPlYwuiGthCruO4FkCm7
 kxVw=
X-Gm-Gg: ASbGncv1ra2vTPNp5TB7fAvM8ndYYWaeYikak6mUdsLJa3IjzwPatGUINux2qJupiaR
 Ny9ILO2CfCFBAPbf0w2hJ7S0WrdNKC3UP5DYaH8PLlvhiC5CXnQpWD4EDjMGOTN+RzxQnURz730
 up9ZymyWCpdghGNqw/eb2yZPahsAPaVQoauBX6QLeDGctb5B2xRnKh6QeQEgjmQTbUtGgOKIjWE
 k/hn3++KZmIyf7nx841CulLrI1d1KU4MUh5yHevvM2AT5mDRG9OR7pFQxkZrocG2R8Ko7jlYrBK
 4Em7oog2SrgGi+9yGc8Ippn5noLB61X7OtmDWBTT4g6ZR+GeNeo+mA4=
X-Google-Smtp-Source: AGHT+IECQx1WS+jZlHk1MY0GOX2cHrUpakdad4wpWux5HYvgkNbIovppXdBG5zTPm1hh9m6qIpbLHQ==
X-Received: by 2002:a05:6000:b04:b0:388:caf4:e909 with SMTP id
 ffacd0b85a97d-38bf566f3camr22750985f8f.25.1737669386348; 
 Thu, 23 Jan 2025 13:56:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17d759sm789025f8f.24.2025.01.23.13.56.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Jan 2025 13:56:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 03/15] target/ppc: Make ppc_ldl_code() declaration public
Date: Thu, 23 Jan 2025 22:55:57 +0100
Message-ID: <20250123215609.30432-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123215609.30432-1-philmd@linaro.org>
References: <20250123215609.30432-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We are going to move code calling ppc_ldl_code() out of
excp_helper.c where it is defined. Expose its declaration
for few commits, until eventually making it static again
once everything is moved.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/internal.h    | 2 ++
 target/ppc/excp_helper.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 20fb2ec593c..46db6adfcf6 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -268,6 +268,8 @@ static inline void pte_invalidate(target_ulong *pte0)
 #define PTE_PTEM_MASK 0x7FFFFFBF
 #define PTE_CHECK_MASK (TARGET_PAGE_MASK | 0x7B)
 
+uint32_t ppc_ldl_code(CPUArchState *env, target_ulong addr);
+
 #ifdef CONFIG_USER_ONLY
 void ppc_cpu_record_sigsegv(CPUState *cs, vaddr addr,
                             MMUAccessType access_type,
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index fde9912230e..7ed4bbec035 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -144,7 +144,7 @@ static inline bool insn_need_byteswap(CPUArchState *env)
     return !!(env->msr & ((target_ulong)1 << MSR_LE));
 }
 
-static uint32_t ppc_ldl_code(CPUArchState *env, target_ulong addr)
+uint32_t ppc_ldl_code(CPUArchState *env, target_ulong addr)
 {
     uint32_t insn = cpu_ldl_code(env, addr);
 
-- 
2.47.1


