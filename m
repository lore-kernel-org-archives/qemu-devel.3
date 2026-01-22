Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8004ED6CFA7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 21:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj1o0-0002o2-6A; Thu, 22 Jan 2026 16:01:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj1nn-0002aY-7C
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 16:01:16 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj1nl-0005Dg-75
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 16:01:14 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4801bbbdb4aso18232585e9.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 13:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769115671; x=1769720471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f+A1Qhq14Gtk+x2zfD9l4IW7BZOqF5jDpsZKQLHwfu4=;
 b=Ej55rBeVthNWMYmQtH3bdjEU18LqyZXMxJd8X98v4y9VjRQABJG2/B2i3UadYQm/NS
 Lc3UVf/BWOFBayEuKZsAI9jswYK+i7qeztUCH2+GT2Dq1NGqteTmrYIYZiHmSc7+xReB
 gs1JkclilK/tgvX2ipLIjKXuqx4ZKTRaScUA6RtO/aounDmT0QpSX3g+0Ggox4BFY/LW
 O8u/gP3jhk2xfpppFtmSSS1Utzkc0iTYwoANWQ6op8PzphcTVx1VUBQjbXXAHvvw56Fd
 i//cbMPXjPNlRq7ezAl55FHUjHklc51H3LNS/FBRtpnb5sMOyE02tPli0Xg+qdZUMSUX
 rhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769115671; x=1769720471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f+A1Qhq14Gtk+x2zfD9l4IW7BZOqF5jDpsZKQLHwfu4=;
 b=IrnaGmlGAzASA2885IkB2w3UpisV5hMEqrqXa/exxIIr0+pL22cep5PQZ/kWTferAu
 HnA80rMy13SrIn0qM29Ht23Dpq/cXcB2peKaUK+cf8VQvjcF8En1jrro6gcyfHy315Ew
 maB0IaYevcJPetFtK+XXR8tBmhQHhgZjnp14XunqilRwRjEb4CMLJ/9jrF64kP9uoGYn
 5uBzMzvzII7wouJSXj/wOVjTHV0wYmSC/fNAjt1twqP+PFZDJibET1gmDd5Guc1WgKPW
 arh7Ty8ShTJvWEBaMzG2wylsLx6t/n6VTP8H62BLoqUhpCnL+NO2MHmBKr9Jyu6TVKcZ
 r8vA==
X-Gm-Message-State: AOJu0Yx6DXywkYKbrWZBD28S0CjkTUQfVE4cO8kVwGgueUXoq6y+qnmS
 02hz1BrC0VLkkVkgfLYpCH11DXZg/C7TiPX3R057ONvpeZl30y94dKST9nhOvoj3YJUvm5rf5Aa
 W+G4aIhQ=
X-Gm-Gg: AZuq6aL0BNbO2q4TXRNdfy2ZLI4Kp6pPbwFsesRoOFUhhyxKgQkoIVsIcGkHDiAFJQD
 MDduo9cfOrsjUP0372aoTNlLZDIatisEbd1n5bdNoStQeWQu3OokafLhBqF0Ffz0IjNksYMD+Zs
 5aK3SYiQN6CXv+DWooUfuy+ML/kQtYUcoYkqa8NJJ4CHqzF7GpFJnB3P8HFNbzEObzupqUd8P6B
 dSiJ98LxGHh2RuH+i7V7nKw6h58c9mDPl3M9OdpHAEuW8LD+TusBeOEDhY0Sq/Tdv16IFgsqT4c
 Mjp1s6l6UOdM2yofX3EEQnVHgUQxm+I3SHuoiPWIv08EG8c0LnNHo5D/TeM3GA5ZjAJC5fnHE2B
 PMSzT3EUKmlV5EX8GgsXnQnrakvnKd3pJyq7kQbQcqOeQAJlCdWIrm8vse1ABGCw4w0kaNvz/3l
 aIHIykWy5mXpGxuoz6Gc+cyeheC64mtqN6hEUmlXX7Tr0AonRchIMS8qqHw7JT
X-Received: by 2002:a05:600c:3f12:b0:47e:e981:78b4 with SMTP id
 5b1f17b1804b1-4804d2ed089mr11775195e9.12.1769115671182; 
 Thu, 22 Jan 2026 13:01:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-480470472f1sm101319265e9.7.2026.01.22.13.01.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 13:01:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Anton Johansson <anjo@rev.ng>,
 qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 01/11] target/ppc: Inline cpu_ldl_data_ra() calls in ICBI
 helpers
Date: Thu, 22 Jan 2026 22:00:51 +0100
Message-ID: <20260122210101.55358-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122210101.55358-1-philmd@linaro.org>
References: <20260122210101.55358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Inline the cpu_ldl_data_ra() call in preparation of
removing it. Since the returned value is discarded,
don't bother to set the access endianness.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/mem_helper.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 7318b02c46a..636ad769a93 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -320,22 +320,27 @@ void helper_dcbzl(CPUPPCState *env, target_ulong addr)
 
 void helper_icbi(CPUPPCState *env, target_ulong addr)
 {
+    unsigned mmu_idx = cpu_mmu_index(env_cpu(env), false);
+    MemOpIdx oi = make_memop_idx(MO_UL | MO_UNALN, mmu_idx);
+
     addr &= ~(env->dcache_line_size - 1);
     /*
      * Invalidate one cache line :
      * PowerPC specification says this is to be treated like a load
      * (not a fetch) by the MMU. To be sure it will be so,
-     * do the load "by hand".
+     * do the load "by hand". As the returned data is not consumed,
+     * endianness is irrelevant.
      */
-    cpu_ldl_data_ra(env, addr, GETPC());
+    cpu_ldl_mmu(env, addr, oi, GETPC());
 }
 
 void helper_icbiep(CPUPPCState *env, target_ulong addr)
 {
 #if !defined(CONFIG_USER_ONLY)
+    MemOpIdx oi = make_memop_idx(MO_UL | MO_UNALN, PPC_TLB_EPID_LOAD);
     /* See comments above */
     addr &= ~(env->dcache_line_size - 1);
-    cpu_ldl_mmuidx_ra(env, addr, PPC_TLB_EPID_LOAD, GETPC());
+    cpu_ldl_mmu(env, addr, oi, GETPC());
 #endif
 }
 
-- 
2.52.0


