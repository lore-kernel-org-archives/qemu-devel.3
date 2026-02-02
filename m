Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1A2E7FDDA
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn13c-0002mx-Al; Mon, 02 Feb 2026 16:02:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn12v-0000uj-Oh
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:01:21 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn12r-0004PT-L6
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:01:20 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43601e96f72so1244259f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 13:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770066076; x=1770670876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ezUyjTdJ4WpRBMli8LXI8bKZQUV8vKPEmVQPuIYa6Dc=;
 b=FqG6fVEIawE+vDsvU4UsNpSBi+Yvcd8Wr/6PdcfdBtH5t/jOAquVYnxiReAiFXZuo0
 1MwQmoWjUXimxhqEGRMCX6EF6pgn8yX0cwmS3wG0XnmgPXVI+BelYEHjxNusYwqH1ofe
 O2HwJ3VIF8Sb5OTMJ6Iaakn1WRng/xTo/B96WZQnPd2dykZ7IrQDHOV7CHVd7rPcY6nt
 TnnUv5LyUiMXa0VU49qwjZ/DGmekbXjU2REdsGXx9rKoU71op2p4B632WXNlRREnsjNJ
 PrnTkG0p/YdeMO1ZFgMOQUuWoPYvHCCqajXFJt8Y7Muzv70qV1DxVxNzXiWI9aGCb7XV
 FkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770066076; x=1770670876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ezUyjTdJ4WpRBMli8LXI8bKZQUV8vKPEmVQPuIYa6Dc=;
 b=bHpfz5xzF0EOosTFPh6nyhKHUj0oxruKCfyzUvzXoZ2FxYjs4KEEqZ/7ayEF1vC+bI
 54C9kQe3GtQEkz2S/u0GeaGYmze7aCiupSbec0YNf5xc5jo7zaPUsuBXxAV1bKKgd2Kr
 60wq5XMvZRQ8jUsb4TGQDy1X3qWqs29sl7CY00Nkt3tZEmSrYQAsEk9en12P2MNchVrz
 AOFjRrY82Ew3vLy5UdtU8RA9THEOrY9Ca1pwbJLPSZaFeIYjzexHaRrf0PbH7wxNZ/AK
 rIBYjFRlUFv1kDlyO0nYYZkMQP0c5E5f2EOhwLe8pkWROnl+NPvxoi8+Y077ChwG6D6m
 tyhQ==
X-Gm-Message-State: AOJu0YzsxPElh4U3CmPMWo7iWLacqYXTo7s+qVxj/KrjKs7DddUyf5AZ
 lvM0ZdGhYc79Y8ko0b978hFMfrn6+UTWPi2GhVZyKTPxXD+R9X15mofuN/ARDnwjuatjq2g+q80
 /qmPElVw=
X-Gm-Gg: AZuq6aKQkWJKSlCxZXJilhDYhhSXx2/rihC+1BiSQUvyNmdtskHyofgpc6iKEuSEULs
 dlnRyWUFhIz8ZjngiYS0R6tG0BJkgBeKzU0UI8mtu6/XynjmELq74+lAVW9204yZ4DGrEXwE5p7
 oNcBYwoQpC9zXFDGykWbpEVPbI7ilJCmRb3+FB90vbzMfz5ArWd3fRR5s945yYZ5VjVrwM2w9Ku
 qkpOuzCa1p6HM16d8qoccrNoe6lMEvdBSJfVDtgQPqyxs56foyQfqy5jZEhKk/U17AWd/AV3YfI
 1C4GT+qh7XM8kP+2P5x6DrGw1yujbbo4PP/fwK2JoBu9uCn+VdRiGAbaLAgNOLtuK2FfPazMaPt
 SlqC9JvvQ+n8hIBnZ9CQTVvbtJ3+8M1mUGO7KUVIlEzCGTnZZEbNbQ7Gt6k6YMw5ruz081PhacW
 bovk7KFcS9NPF826+VM1wera3JXkhYpjipwk4BztyhBqlPrtSlafhAdrFGZtyx
X-Received: by 2002:a05:6000:1786:b0:430:fd84:317a with SMTP id
 ffacd0b85a97d-435f3aa90acmr20512163f8f.38.1770066075642; 
 Mon, 02 Feb 2026 13:01:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e4757sm48274822f8f.5.2026.02.02.13.01.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 13:01:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 01/11] target/ppc: Inline cpu_ldl_data_ra() calls in ICBI
 helpers
Date: Mon,  2 Feb 2026 22:00:55 +0100
Message-ID: <20260202210106.93257-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202210106.93257-1-philmd@linaro.org>
References: <20260202210106.93257-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Inline the cpu_ldl_data_ra() call in preparation of
removing it. Since the returned value is discarded,
don't bother to set the access endianness.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
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


