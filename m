Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF07D6CFA5
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 21:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj1oE-0002zK-8q; Thu, 22 Jan 2026 16:01:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj1o8-0002st-4F
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 16:01:39 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj1o5-0005GY-LE
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 16:01:34 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4801bc32725so11780795e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 13:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769115692; x=1769720492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xwyaty6/9Dku7w0or7x9Z1FwEL5g3XwXIWEi/fxrfjo=;
 b=YiH8u4lwZL1Ho+ELvZ0F+z/P1AgxsBez4WWBx+0pBiK2kj3UCjyKO0OAEMJ9AJUZHl
 6fvBJkJj+hbR5h++2Xn86bGD+Ed6cFvHFM7mEjf2PtcojNpCjWJBOtSMv9+6y4cM8ZTW
 9K8YcUOtIDu+PWx/mWQ8IlT2gICsCMZAKEPqRHFF73gfhbjvd0M+X7V2rH5SNtcgWfF7
 9EKFO2WoafmkGyxfPxMdZNHRRzH4PK5lq/DUkztpPfWZtXmnNeR43SX72YRXiz0AQI+7
 Fj0pSWUyh+KLwYWCdLQBlXUijQsgV5Eok5JATJEyp+j6Y1NpxgsWmz3bxtmOMMNGO416
 TNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769115692; x=1769720492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xwyaty6/9Dku7w0or7x9Z1FwEL5g3XwXIWEi/fxrfjo=;
 b=XttjSUgYkOsFGUpgrtOmCpmgR7SGcjDcwrMVV6uHGTr+ozqigT+yENW9VbQRT9qS6+
 U4YWU/Sa86OdavnyyqyFfltwBdFZ4yipAGLbiGMcklHY1i1tXWseA8kYmyj2SmveWVqt
 PoW7vhlypZnuf7M1vEK8utGcmDXB8aiPYU6M9D5CrnaR9RxX6QQVR5CHAX164P6msemP
 UMk91nH49X0X9DEewP8enMZ1d6QzRWGPNhkG2ShufVHiekF0SBZi2aMWxPZCdMnR1URr
 l3ZLQlFlhNj+RGtEV/pra9Fwd0LQk+WBiwx/wLCT1rB8axLnWpu3okXZ+0YPTVtiMCXw
 aTZg==
X-Gm-Message-State: AOJu0YwfmfWIGBRRF8T6WvX2bsK6KuS7+5D1wD0/gGqRLBfu16gkDm0r
 cUDbEJIQnMMhnYX5qb4PjMuvPIkoGuRIUJCHcmGcZQFTHxp+P2zRpgNAVVX8q/NWHBMc5sNUQAY
 q6Y5ifNQ=
X-Gm-Gg: AZuq6aLTrWN2Cn1mDHBJzFPWvGCtVSZp4J1ZPHHZYAXBZKsnysFeUaCMs0w6m8hQ9li
 lXtshAdmw3NVQlmNg2ZyKtgT+Mr3ro0AhiW46kBZ78PXbl8Jr106jhWAoRjTb3ggB+w4Kg4n3M3
 IVsxzuO4rLXd9V6BoPOBew9F+mVO4aDfiT155Y8angOhFIWbchUIZh+yGWU9pfUWlu+xtrjqDCx
 Y2YzesUbxkTd2W87pLttwwvgv/MuToDuvAdPWqVnbQ01ue7DjlgvmXRdA3xt4IMLIPJy3emtuxs
 PvsJIEdTCHegKaBTxXEY0Sbktm+Va2qftTV0aAKbyMnyCJFA64GlrNmXsJleAsqexzMupKEuXzf
 F36KmNplj6282vf30g20NzhE/7ioIT1bdpycPZ57hdoDqs02obmqI8Kf9ynMYQCKQLmLxT5hKAe
 E2OA7MXZq74peaR8SaTg4shSaN5RB25qmMmAMaT3lVgjSv89ULVax3bsqLX9b6Dhqkt8CoZ/c=
X-Received: by 2002:a05:600c:37c8:b0:47e:e20e:bbb7 with SMTP id
 5b1f17b1804b1-4804c9bbfc1mr16297905e9.25.1769115691744; 
 Thu, 22 Jan 2026 13:01:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d85cff5sm8596855e9.7.2026.01.22.13.01.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 13:01:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Anton Johansson <anjo@rev.ng>,
 qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 04/11] target/ppc: Expect page translation hash addresses
 to be aligned
Date: Thu, 22 Jan 2026 22:00:54 +0100
Message-ID: <20260122210101.55358-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122210101.55358-1-philmd@linaro.org>
References: <20260122210101.55358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

The page translation hash addresses are aligned:
remove the misleading MO_UNALN flag.

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/tcg-excp_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index 6f5d82af636..a8c67364669 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -161,7 +161,7 @@ static void do_hash(CPUPPCState *env, target_ulong ea, target_ulong ra,
 {
     uint64_t calculated_hash = hash_digest(ra, rb, key), loaded_hash;
     unsigned mmu_idx = cpu_mmu_index(env_cpu(env), false);
-    MemOp op = MO_TE | MO_UQ | MO_UNALN;
+    MemOp op = MO_TE | MO_UQ;
     MemOpIdx oi = make_memop_idx(op, mmu_idx);
     uintptr_t retaddr = GETPC();
 
-- 
2.52.0


