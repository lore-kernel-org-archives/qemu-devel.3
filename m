Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E575CFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINrF-0005LC-IW; Thu, 30 Apr 2026 05:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wINrA-00055N-7a
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:38:52 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wINqy-0002mP-72
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:38:51 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43d73352cf2so612491f8f.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 02:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777541918; x=1778146718; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WDQ7la2K8WbK8u2/23ch5pBkMkaDcwKmzot+lA8IzKQ=;
 b=pdNILHMJZ7QVh0cmQ6Y6dadwjvmv63QU75CS7bYaPTq8IkSxG9BxEg93lhFBL7+0mh
 zGa8XhGMK+TbUcPplaSDcxOjQ3qt4ENXLid7WNgb8FeHulS9+1jj8jBo+owRLU8xHLtV
 GKDVN8pF847wC5Y1nE9vNuDR8tqgNgAfmgKqpuOcJhlsEiGDozPwlQvTo/+jY0hOOWgd
 r66FXpy5Aw3y3E4+M2dSNCO+03hLUdljAHNYrvD7CsOJrD3ndhnK8289YdWyhBgtXI5u
 CYX4YPkLLzIEcKz5PoEOUqgW6nU/Mx5OYEgzVXBxxcL5qZC17y4g0dEtSprjY2vZKogo
 GEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777541918; x=1778146718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WDQ7la2K8WbK8u2/23ch5pBkMkaDcwKmzot+lA8IzKQ=;
 b=FrsOqQW4rlxZlYLxi3G2YGDkzuMOlr7pEpN7jXMqfX6d11tRsmM7qAj5y85PmoAIXH
 ktto5/7ggY2285Q9Oo2lqUWHnHpEse4/LqPsaMUWkBwlIQcQSpmUjqkYbiuPR0KnEaiX
 joE3FOk+cAeFPtEGz1tf3CtxaFzZI8huVhtNS/gW5JkVzQn490ERO4+JSQ16nn51YXvN
 eL3N8qvdspWwqXkPgs6mZEneRHe3s4kYVtMDjmD4ipK+GQMLM7dG4jTrMaQLe3ifrLnw
 qE5tLq1AQXTVJOjmeavnk9LNeIk3jAhIvvo2Jmcw95OahwogzAJxrDnqog721vIV9FiJ
 3Ufg==
X-Gm-Message-State: AOJu0Yxfh9TvEgqWOOPzRig07jlFbw4Kp0Uc23VwEuqTVab8l289Rn7P
 SAEq7WOrpEFYpaOY26iPx8uEYc+1X5A5+wUJGHvy9RrVzPyHGg1kF+YUoWhvYt1Xdp2DSiES18N
 VF8xP
X-Gm-Gg: AeBDiesj3x/9Z9Sqid//XlXi7OOyomYinYciv2D66YrXR3sEperPFNPhtG1zorSunEQ
 YBFR6I3zGgHpppTF8ppGvfpv8v3Bhi1/Xuv+F6bVIgcFPQp52JXrjhzmQE9Zl2kCPEXxcKsQySU
 v2XkDuE12GH4vbuUlHyFWvsRZ+m6cm2UXnBnA4faVkNN3rDC4NrIMiYuPvHQNvgNiDxW/tGjEFs
 WzIb5fh5ru71HtzVtsfgx3jKOystLEBhWrqLv0QSXxvE0IUpvmYKp5i6pFbMwpSQ5q64AVau62W
 mbqjqFkh+9BZDJhRd80fvwC+xPY4130G4/jCRPTO6M/genWjnDTBEN1pabUIlz2F/l140JvpoKX
 ULiwE0QNVg03XLrbFURwax02I+63izNnhVA0kEm2rTgqOTChl8M0B01Q0bROCFwxM6EDGXVLvc8
 fEQC9Nta1s09kdLvY70zOnggfKKDycpsWU+6ZFknTTBlvbIW6t9vD0rk2PR0xl1v6tuHw02KxX+
 8iYDmx+00oB5QN4Yi47cdTXNLn1kgHNhVsU15fwAQ==
X-Received: by 2002:a05:6000:2585:b0:43b:498f:dceb with SMTP id
 ffacd0b85a97d-4493c37ef0cmr3506822f8f.9.1777541917911; 
 Thu, 30 Apr 2026 02:38:37 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b421721fsm10816795f8f.15.2026.04.30.02.38.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:38:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 20/25] target/sparc: Use cpu_translate_for_debug()
Date: Thu, 30 Apr 2026 10:38:05 +0100
Message-ID: <20260430093810.2762539-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430093810.2762539-1-peter.maydell@linaro.org>
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

We want to remove the cpu_get_phys_addr_debug() function; update the
sparc dump_mmu() function to use cpu_translate_for_debug() instead.

The "mmu_probe succeeds but debug translate fails" cases are probably
not possible in practice; since cpu_get_phys_addr_debug() would
return -1 in that situation we make this conversion retain that
behaviour.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/sparc/mmu_helper.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index e1abd520c4..e441ffb8f7 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -360,26 +360,39 @@ void dump_mmu(CPUSPARCState *env)
     unsigned int n, m, o;
     hwaddr pa;
     uint32_t pde;
+    TranslateForDebugResult tres;
 
     qemu_printf("Root ptr: " HWADDR_FMT_plx ", ctx: %d\n",
                 (hwaddr)env->mmuregs[1] << 4, env->mmuregs[2]);
     for (n = 0, va = 0; n < 256; n++, va += 16 * 1024 * 1024) {
         pde = mmu_probe(env, va, 2);
         if (pde) {
-            pa = cpu_get_phys_addr_debug(cs, va);
+            if (!cpu_translate_for_debug(cs, va, &tres)) {
+                pa = -1;
+            } else {
+                pa = tres.physaddr;
+            }
             qemu_printf("VA: " TARGET_FMT_lx ", PA: " HWADDR_FMT_plx
                         " PDE: " TARGET_FMT_lx "\n", va, pa, pde);
             for (m = 0, va1 = va; m < 64; m++, va1 += 256 * 1024) {
                 pde = mmu_probe(env, va1, 1);
                 if (pde) {
-                    pa = cpu_get_phys_addr_debug(cs, va1);
+                    if (!cpu_translate_for_debug(cs, va1, &tres)) {
+                        pa = -1;
+                    } else {
+                        pa = tres.physaddr;
+                    }
                     qemu_printf(" VA: " TARGET_FMT_lx ", PA: "
                                 HWADDR_FMT_plx " PDE: " TARGET_FMT_lx "\n",
                                 va1, pa, pde);
                     for (o = 0, va2 = va1; o < 64; o++, va2 += 4 * 1024) {
                         pde = mmu_probe(env, va2, 0);
                         if (pde) {
-                            pa = cpu_get_phys_addr_debug(cs, va2);
+                            if (!cpu_translate_for_debug(cs, va2, &tres)) {
+                                pa = -1;
+                            } else {
+                                pa = tres.physaddr;
+                            }
                             qemu_printf("  VA: " TARGET_FMT_lx ", PA: "
                                         HWADDR_FMT_plx " PTE: "
                                         TARGET_FMT_lx "\n",
-- 
2.43.0


