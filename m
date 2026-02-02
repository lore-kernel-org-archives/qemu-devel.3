Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7770E7FDE4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:21:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn1Lc-0004Rz-F3; Mon, 02 Feb 2026 16:20:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1La-0004Rf-My
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:20:38 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1LX-0007K9-Tc
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:20:37 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47ff94b46afso1385625e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 13:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770067234; x=1770672034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FZySsQfVGsWoB5DbDHJmehqOfv8LCDyeSqzpu/czsbk=;
 b=WNUQD74VLJ92eA7WYcgKf9k/smgNRfWi3U6hCAVwutt6aKWcZecLL47My3KkC2dZvp
 Rgh5V3rXTLaPsAzfLely6exkt6Q2no1/dFo2pg8BM7gH52ftxilkHZALQQSlIT7vEkhd
 mALe4zEjaqtEhQRKixiZsSoS2BjQOipryfO5tR3CEm1UJqeSQWxRSioQ6E708hua8o3+
 6hSQdpBQOkpyMu5enymzUIvRf97tKiiEkNcW7r+NMQdNphHIwuGHRfOn69V65s912fRf
 4ORNFY05Q23IENtoiUQR0eGlX+6Jk4yGmLAnwXr0qF3Wb5izVHHbcUtLJT79dgdGPPxH
 Y2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770067234; x=1770672034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FZySsQfVGsWoB5DbDHJmehqOfv8LCDyeSqzpu/czsbk=;
 b=MZCkMRej2pbnulfCUUjlfk03QYJhXnL+F0uCEzxX+vk0S0nck9ZCZ5ZSItHbM8h4At
 6zFkXIQLv7fsCq2ZXzRL4xP7Ki02u9E/U2Wc5XNytRN10Td/YqqVNCdXr1CQfs+M3GL3
 UF6fx7KG9teRNksoy7CU3UbCv4tG53uo36e4ecRe2D/OQ3Fcxm6OhBxNGxxPvW7o/PNr
 RSGrLAOuRKYTqScoKNwCFSYnWcoO84drgk7TKEYW8+YuUmurzFfNhWD9GGOFstjBMn6b
 fUzu4p6mJv2qoISu0U4K9EuMUN7pY23beu3bnHB3A44z67Z77aCQNtm9O7ma7NlmKI9C
 kAGA==
X-Gm-Message-State: AOJu0YzzsynzNO9+o5bFuy5qGTZQpblyfhucVBYTe1y8x/6VhOM50Uk7
 UjtVzH0ma2RhjN60LHvaK948cf1BvpxDpR5Vuxro5loAjMuGJiyH4rj+sJffzvbbBEU3j4ejB7/
 YJgn06kU=
X-Gm-Gg: AZuq6aKOeFibSQkMWErYrdnb6w8J3PbzmIIQHS7LLR5T0RPtP132GU1iYZ8O+R1iRzd
 JFtqTwzcLku2XMzKJVyxSARBQbN0yvTceP1BQBJCU9zLFYdyfO8lYt+QPiqgsEGv+kX9UvJAuwW
 Oo+thyl0zU2rthG8mzYrICWxj7GCC8UA5DterMKX/ZOQBm/ueyUKZvHrjm95UNH5pUUZYliXyuF
 iQJxoqq5+12p64SnAVPlWLAQwfsxoSQvtCH4PVPwy8zz0RaBHnoubtS6kQpZgxfPVhmTEAaWO+A
 WmUz0a7L9s8xMvjCegvJE72oY+7zcPSt2T4nNBP1Z+Xd0wB9U6DdcTHwZbQUDCnPEfPEwI/BCxF
 p4aDJd4+Tk3jhu90xBLCzNq5EpKGeauqohcP095+5uakAT3WxUHxh61iNfR4vowgmgHsOhOYniJ
 bve5DVEFKziB9zU4Hp5JevnKpCZqgo6fy1/t2rpQ0sO734dzmEvFHnEaWDcztKGYdyngnnDPA=
X-Received: by 2002:a05:600c:5394:b0:480:4a90:1afd with SMTP id
 5b1f17b1804b1-483050f3f03mr13425855e9.0.1770067234074; 
 Mon, 02 Feb 2026 13:20:34 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830516a0a0sm13672525e9.15.2026.02.02.13.20.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 13:20:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/16] target/alpha: Use explicit little-endian LD/ST API
Date: Mon,  2 Feb 2026 22:20:05 +0100
Message-ID: <20260202212019.94205-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202212019.94205-1-philmd@linaro.org>
References: <20260202212019.94205-1-philmd@linaro.org>
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

The Alpha architecture uses little endianness. Directly
use the little-endian LD/ST API.

Mechanical change running:

  $ for a in uw w l q; do \
      sed -i -e "s/ld${a}_p(/ld${a}_le_p(/" \
        $(git grep -wlE '(ld|st)u?[wlq]_p' target/alpha/);
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251224160040.88612-2-philmd@linaro.org>
---
 target/alpha/helper.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index a9af52a928f..80542cb0665 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -214,17 +214,18 @@ static int get_physical_address(CPUAlphaState *env, target_ulong addr,
 
     pt = env->ptbr;
 
-    /* TODO: rather than using ldq_phys() to read the page table we should
+    /*
+     * TODO: rather than using ldq_phys_le() to read the page table we should
      * use address_space_ldq() so that we can handle the case when
      * the page table read gives a bus fault, rather than ignoring it.
-     * For the existing code the zero data that ldq_phys will return for
+     * For the existing code the zero data that ldq_phys_le will return for
      * an access to invalid memory will result in our treating the page
      * table as invalid, which may even be the right behaviour.
      */
 
     /* L1 page table read.  */
     index = (addr >> (TARGET_PAGE_BITS + 20)) & 0x3ff;
-    L1pte = ldq_phys(cs->as, pt + index*8);
+    L1pte = ldq_phys_le(cs->as, pt + index * 8);
 
     if (unlikely((L1pte & PTE_VALID) == 0)) {
         ret = MM_K_TNV;
@@ -237,7 +238,7 @@ static int get_physical_address(CPUAlphaState *env, target_ulong addr,
 
     /* L2 page table read.  */
     index = (addr >> (TARGET_PAGE_BITS + 10)) & 0x3ff;
-    L2pte = ldq_phys(cs->as, pt + index*8);
+    L2pte = ldq_phys_le(cs->as, pt + index * 8);
 
     if (unlikely((L2pte & PTE_VALID) == 0)) {
         ret = MM_K_TNV;
@@ -250,7 +251,7 @@ static int get_physical_address(CPUAlphaState *env, target_ulong addr,
 
     /* L3 page table read.  */
     index = (addr >> TARGET_PAGE_BITS) & 0x3ff;
-    L3pte = ldq_phys(cs->as, pt + index*8);
+    L3pte = ldq_phys_le(cs->as, pt + index * 8);
 
     phys = L3pte >> 32 << TARGET_PAGE_BITS;
     if (unlikely((L3pte & PTE_VALID) == 0)) {
-- 
2.52.0


