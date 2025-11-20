Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFC8CFA441
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 20:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMB8g-0004uD-S3; Thu, 20 Nov 2025 15:20:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMB8d-0004r6-1W
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 15:20:20 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMB8b-0001jG-MN
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 15:20:18 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-477a1c28778so15495045e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 12:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763670015; x=1764274815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uhfSYXVJhQzgILc5n4xlE7EXEuT5rMWIJU0DyKOMRY4=;
 b=m25RS87iMGz+67hPiVlZOUOzG+oLNYKvj8CstzGNF2fkQYKuiMXBc7P2lhmWO9dZcX
 OePH3YXk64peoFgy69+F7Z2vRZsiQ8CDTEaYdCKrQ68wryLwDsF6RQf0jFvGM7JMgb17
 YDTSEn3nyakmrlFWNHeQHtPN/yh506srzBDfvNLHLk168YoAZ0E2IVMshjrb89wXLR3H
 6fRtdJuqw4g6wAfpPSI9JaKuAkGdW+FMC1L/GeK0Iq/wxV14FyMErnIgsXzY/Ioxrab7
 VKTn8inytH8r+5mexWj43R03CR1Xd2r61eoVmFwls9U3vp8C2oIIXq0mRZdSp5b/7bbJ
 Rt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763670015; x=1764274815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uhfSYXVJhQzgILc5n4xlE7EXEuT5rMWIJU0DyKOMRY4=;
 b=Q5VBmna8+/Tmx0HsH6dkwpZcfkAkB0sb0ah9KljG+Hja9ZnDaAEsbZ6DWHB0fAQ7u6
 /a8YsIsS1Tb1MposmBl3XDOSW1tIEktC9BNN1AhkCcklXGfIzLrXtlBVMbfuWZ5xh2Iu
 UGoBxso8798td1xk3959lIdv8hNFQS0WLgJ6UoNncHRJRuvi6Ur2Fhv9GAcy+UdFY0BD
 aLjMx2j7Iex+OT2Kk3py9iDojwEw+9ZoPatgWXLCbZuoGEWtENZHJEKB6d1mAHX/hahd
 j3wPrAZqppDvTxbDNRf8Jr6gSQmflFwmQm/13sEKAREGR2nKZGTVXmbHaWBXj48RmuTr
 lb1g==
X-Gm-Message-State: AOJu0YyK6JRl/r5c0lTJFqJVEIbblmQ+G8a24KhwXgIr0ebV6ssH6MKK
 S1IsS9Bq7MXR/9t1617DJ4R3z1FmeMKHY8jJylAsPj8J1r1oCmNbxW+T8MgLkZbaK70Z0DobhEP
 nQEqUfBMeBQ==
X-Gm-Gg: ASbGncsNsPRDqNX0t4MVcqhAdRZGSPikRgm8C1DN/417kW9TAOdfVYcBZ0J98ofRa2p
 rti5+EKEpDSBy68kO/etrlAXr1Q/jr0ubfnf308Cx5Wc4QMdlyThbkHQ3E258GI5YSPaDfSKVyG
 HjAYWXoqZPcmUhNri1qgxnBCVLH0I5gN08d2bcPPDGnZQoft+MPJUFuhtm5fZ4W2SVCP8aZsb8q
 5Q0IZ12Mty9CVNzXdaS0QwRMuA+06cxwk0WvyszL1wQq8vh+V/majO/8+YJu64jYFvnFw8rLWFq
 PA8WkWD7yJ3vEEMJtiNp5WY9BgvjKOFYcJ/cYBjXvK6LMpruCwfs8eBVO79kWjTvA8eumhvklXq
 8ejZWSUBSOcFAunaBNxVftX7qyBW9R8JgoGuK66yBhCLQcT5po29bPWGVWs5ADBjEgii4DYlKlU
 PguN/y2KeIENqiZUcYYtHCFdZTU3Ra8FJ0x0Vkfd1mg/vfM/l9e5RPILaNq6pH
X-Google-Smtp-Source: AGHT+IHuXCub4+Stos5FIhnGivLRFFSyVolGrMTi+d0bxoksGX9K2vIv9PdpqOesJVPAsPPL0E7gsA==
X-Received: by 2002:a7b:c04f:0:b0:477:76c2:49c9 with SMTP id
 5b1f17b1804b1-477c016c015mr120485e9.2.1763670015456; 
 Thu, 20 Nov 2025 12:20:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf1df334sm7709235e9.3.2025.11.20.12.20.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Nov 2025 12:20:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC-PATCH-for-11.0 v2 8/8] accel/tcg: Remove non-explicit endian
 cpu_ld*_code() helpers
Date: Thu, 20 Nov 2025 21:19:19 +0100
Message-ID: <20251120201919.8460-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120201919.8460-1-philmd@linaro.org>
References: <20251120201919.8460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

All uses were converted to the explicit cpu_ld*_{be,le}_code()
helpers, no need for the non-explicit versions anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/accel/tcg/cpu-ldst.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/accel/tcg/cpu-ldst.h b/include/accel/tcg/cpu-ldst.h
index e4ec4e7d367..a3125fc9026 100644
--- a/include/accel/tcg/cpu-ldst.h
+++ b/include/accel/tcg/cpu-ldst.h
@@ -523,14 +523,4 @@ static inline uint64_t cpu_ldq_be_code(CPUArchState *env, abi_ptr addr)
     return cpu_ldq_code_mmu(env, addr, oi, 0);
 }
 
-#if TARGET_BIG_ENDIAN
-# define cpu_lduw_code        cpu_lduw_be_code
-# define cpu_ldl_code         cpu_ldl_be_code
-# define cpu_ldq_code         cpu_ldq_be_code
-#else
-# define cpu_lduw_code        cpu_lduw_le_code
-# define cpu_ldl_code         cpu_ldl_le_code
-# define cpu_ldq_code         cpu_ldq_le_code
-#endif
-
 #endif /* ACCEL_TCG_CPU_LDST_H */
-- 
2.51.0


