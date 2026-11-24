Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561F9606A336
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zUllK/JE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVnaj-0001qg-1x; Tue, 24 Nov 2026 05:17:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xVnah-0001qN-69
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 05:17:35 -0500
Received: from mail-pj2-x00.google.com ([2607:f8b0:4864:39::])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xVnaf-0004Xe-4y
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 05:17:34 -0500
Received: by mail-pj2-x00.google.com with SMTP id
 98e67ed59e1d1-3b411059cd2so985647a91.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 02:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795515452; x=1796120252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HkHhYkPvRYzpmxeD5z1O5pwdDg/dr3/spBsYEEDgr38=;
 b=zUllK/JEytwhSO7r08x9vZOue3gFm1LME61r19Q62P1N72wJ0TA1FCVwbrSdT25IjV
 uf3j6a0sb70FHxUhz1qwi3iukFLg6VgKYOZOltYjjinpiIlQRP/Fe2zeyPYLHWvP0PHZ
 S5pNKnZjQBww5jNwAru9zUq5opdWHAhKo5IoTsr32hgKN+oQOp/xh/L5vYjB4ft7nuG1
 7COzsiDopM9Wt8JOGR+KUfLXzGkQHi2D8XPE33w3B99jJv/lcNt1I3HV9ZoS5Hs1m0hl
 YmUoG+LGy8Xp+J4soRBvjpxKTNyI+bQQU5ywqES/UbK3gohtuQaAbkv0/4i6fEtd18tk
 eAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795515452; x=1796120252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HkHhYkPvRYzpmxeD5z1O5pwdDg/dr3/spBsYEEDgr38=;
 b=G0PSJOaOZWcEF9ty02KSE2kxidc7wVypYKr7fThNNVOOvgGTBoh5MH2nfHPYTWRl9N
 EpIHVnRqcHSoqbWFOibdlSQqwtJHHSmakqwDNo7LZ0rxXLUzL8cwdHwWPB9QRnfySY68
 nbiNi61i8u94blx/pA5HuVAU3SQJ5VCQsizMkL/HdXCgYN6LUjkM1MJBKHR0uKhpWJrv
 7DA2c4qh+pFAREGiyYvMNievLfinxXeElou+jMMbsc4hO9kCNC8Yi/rbviML4l2Y9I3H
 AmAa7ZqmIi8zeQ8Jh/W1Ih7KgSCu5c9HLyAnutGsTPUPKemXbHN+Pn4yqT4oE7VpolcN
 VKqw==
X-Gm-Message-State: APuU4Z+L5Bp633HscvVLuSqVu9Mq9LLPM7GpmOCniCMA2r8g+HsW620E
 Kh7nnPJ10LBqDXOGt3Kk2uH30qc2tsW1DdolNCg7UgoxV8Zq9aQYy70r1fu4VbjQ
X-Gm-Gg: AZFdTZfJ4PuerPi5w9QKQrRtTsFEBJ08H4usiejQ+MZ/6yL1SnScJsyfAehnRkTTpMw
 1skMez/x7f00dvGoQrFD+OsqZnKeXc2amq1L51jzYMLNRh8QOFUCs4vt3RtMGY2a5xKnM1n3hsz
 KfLVIDhpoNdcAYdNSC/5Mpm+kEaBj2Ahm4BBiPvR5JpAhut72Q1Kap8NDa9FeutIg+tEs/1Owg9
 3/XfwZ9+q2BaH+s7zVjnWszdiV8TBGkXmDu4I6ocEz5uQy9fsuU3YpL44qC0YvJh2LVlCHVZqvn
 1Hk4RexfsJMoi2PAahoGFh+pVuMTSEF827Z6Ph+JlzCQda52KRxEFZbj6UguxWRUr3URkhJaO3p
 YuLYHjrhRFm5U6dwJHsWQO89fNy6STIplZvVpXVD7SXzGQPI8k+596TdgqhrzS2B4o1vrO28eHI
 ps2AOOMrzRjzZBamu9TWYmVVw1x3noEljTQmelHE7aLWB8q/7wlEn3shhQJCjv2NSAXVVxaRso1
 vB9S8dE+SZE0UDB69NXkDJjKhi4SRTfN7bDZYodyisnFI+GKQXpumBiD6etkaoDupt26TeA2YEG
 Cllmsf1gZ0t/uupZFaWdh5pVbyyQibM=
X-Received: by 2002:a17:90b:4a48:b0:3b1:4018:bfdd with SMTP id
 98e67ed59e1d1-3b41c7d5cc7mr11685234a91.7.1795515451756; 
 Tue, 24 Nov 2026 02:17:31 -0800 (PST)
Received: from computer ([2604:3d09:98d:800:e939:4613:1d28:dfcc])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cde6cea748csm6627920a12.4.2026.11.24.02.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 02:17:31 -0800 (PST)
From: Tim <mdspan.github@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, zhao1.liu@intel.com,
 Tim <mdspan.github@gmail.com>
Subject: [PATCH v3 2/5] accel/tcg: compare large pages under the flush mask
Date: Tue, 24 Nov 2026 10:16:51 +0000
Message-ID: <20261124101655.2269531-3-mdspan.github@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124101655.2269531-1-mdspan.github@gmail.com>
References: <20261124101655.2269531-1-mdspan.github@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::;
 envelope-from=mdspan.github@gmail.com; helo=mail-pj2-x00.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

tlb_flush_range_locked() flushes entries whose address matches the
range under @mask, the low @bits of the address.  Its large page
check, however, compares the range end with the recorded large page
in all bits.  If the large page was entered under an address that
differs from the flushed range above @bits, the check fails, and the
large page is not flushed.

Compare under @mask as well.  This matters for the x86 LAM emulation
in a later patch, which installs TLB entries under tagged addresses
and flushes every tagged alias on INVLPG of the untagged address with
tlb_flush_page_bits_by_mmuidx().

Signed-off-by: Tim <mdspan.github@gmail.com>
---
 accel/tcg/cputlb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index dc83f3ba..ad2a5aa1 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -691,8 +691,10 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
      * Check if we need to flush due to large pages.
      * Because large_page_mask contains all 1's from the msb,
      * we only need to test the end of the range.
+     * Compare under @mask, ignoring bits above @bits.
      */
-    if (((addr + len - 1) & d->large_page_mask) == d->large_page_addr) {
+    if (((addr + len - 1) & d->large_page_mask & mask) ==
+        (d->large_page_addr & mask)) {
         tlb_debug("forcing full flush midx %d ("
                   "%016" VADDR_PRIx "/%016" VADDR_PRIx ")\n",
                   midx, d->large_page_addr, d->large_page_mask);
-- 
2.47.3


