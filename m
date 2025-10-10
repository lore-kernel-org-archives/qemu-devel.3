Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AFD5CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 05:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v75a1-0006eO-CO; Fri, 10 Oct 2025 01:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v75Zz-0006dj-Os
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 01:22:11 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v75Zt-0000WL-6M
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 01:22:11 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e37d6c21eso9694355e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 22:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760073722; x=1760678522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EzbqSn68xDAyKqnYgFzZBjEz8LT9WvYTgjVeUktXKQQ=;
 b=xnr+nxSz3on8MiN5A6ggAfaIQnk6P6x8cXVhkXOWr+QgdQKVhhyJJL2aj0x2OaEPaM
 V83FBuloJRzyxSbpbZynvjXQ+otZ5CYsqL/vusX59h+Y/nrlf054dULNBDVlfFlqY+cF
 7BvBnRicMpWXiEzXYvk1BPW3OlgTJsqakZR/+5tb+BmkGqVn6YqScEWrAFH2AEqrGxOd
 zj0/w6Sf/fKBrVnSaKDb6ZRcOCWmaaC13sZU88d8PuydAxSE4Jz4GNuQnXkDVoONQo3n
 qYaWRRM+XgjyfZ+1iQ2HLJmrbwiK0Fyx7rCftgtBQxeIl7wGsXAOOQmuxv6UWn5S5Hn4
 PR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760073722; x=1760678522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EzbqSn68xDAyKqnYgFzZBjEz8LT9WvYTgjVeUktXKQQ=;
 b=bjOuWZiQ/d7YRGnHLWSJJLMvCZLlBu3+JqwLx3waUT2Dt6+XDMdc1GVaI9IC/Jpm+N
 3eQqG9OfpeRP6vA4kUx3u6cf2/I3bYGuD35mGwQOulu78vMcjrOp0WBdxbakglVTOlJc
 LKzRYjjxLGQYo81OZBCP6bmFZLecDWkm++ZNJG2WgT/S5/dCVuNqz0xWRZVS48dNxfF7
 x1kD6KPKdSQkaZdkLcFCJz6ItY8oXiQjLFtknXmEVLAnXn+hlVtTlgZ7sWx6Z11HMlQM
 eyrLR9HQsZZkr6bbF7JP+HJZ02BwKfdUj7Z3u0GvQVIm8tr1EJuiqHfp97QNUfKs1JQV
 DiKQ==
X-Gm-Message-State: AOJu0Yx4bLMsUADQuvMBWUEq6W76KA4lJKQKUttnPah9Mk1coZzW6w4G
 1YTk4VkGweuI5lEmt1jf/iGt30578lc/6tAGtxmFI8pKEsTSq6UYv4Dqc4/NlG2qhfvCh9TOUuY
 WN7NEdjGaxQ==
X-Gm-Gg: ASbGncunDUenHvc4t3YRpy9y3hGBDQ4LqRULgIYMDSHe/3WTbXwe20MW+XNUyl94Lm3
 Pn9J8FjtTRaLsS/1wXZT9dg7vdLOaalKJ02INlQDlJO6kYK5jtJOu25BMiUxYlkmwDArTTMb5mQ
 byJuqyRROrIP8V7auwpswgjfXv916Pe1Kc/4FNs4juCP2pnn5WgTzpUhpDQcz9JHLkbJ5/zZw4q
 hPh0wdJwT+yCMso/VB7bTmKzrwch2Vv/8f85QVXa8Cunmmh1uNzxgAT6ZvZ6JbrYy5w0nif2Rm6
 ob6ed8TJwfKZuu0TXkzKDSAgVH+lskw36PhEfBOGHP2p8afZ29soYJz8MA7LSomBbLZ8Id085i9
 +5M5NHV9VCF90aXuwWgDoMOw9lxKQeUDphjRBvgalL0Rm9jTfPPjWi7fD1R1B3+AlLmeILKZRHS
 U+4HGcQsH7j1aIhfugqvopMIVR
X-Google-Smtp-Source: AGHT+IGfMf/DShJMPf67ScOV2eV/434C7lf429OB0bvRCW5gDIyqJec7y4vqT6OOk2Mc/57gO1qSkA==
X-Received: by 2002:a05:600c:3e1a:b0:46e:1d8d:cfa2 with SMTP id
 5b1f17b1804b1-46fa9af9842mr67655225e9.20.1760073722628; 
 Thu, 09 Oct 2025 22:22:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e13b6sm2276343f8f.44.2025.10.09.22.22.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 22:22:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 04/12] target/tricore: Remove target_ulong use in gen_addi_d()
Date: Fri, 10 Oct 2025 07:21:32 +0200
Message-ID: <20251010052141.42460-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010052141.42460-1-philmd@linaro.org>
References: <20251010052141.42460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Callers pass either int32_t or int16_t.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/tricore/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 4b769b204ab..116f45135bb 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -1308,7 +1308,7 @@ gen_msubui64_d(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
     gen_msubu64_d(ret_low, ret_high, r1, r2_low, r2_high, temp);
 }
 
-static inline void gen_addi_d(TCGv ret, TCGv r1, target_ulong r2)
+static inline void gen_addi_d(TCGv ret, TCGv r1, int32_t r2)
 {
     TCGv temp = tcg_constant_i32(r2);
     gen_add_d(ret, r1, temp);
-- 
2.51.0


