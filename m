Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D7B606B2E1
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ajaob3/A
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQlTt-0007pU-DZ; Tue, 10 Nov 2026 08:01:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xQlTW-0007kO-NM
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 08:01:24 -0500
Received: from mail-pj2-x07.google.com ([2607:f8b0:4864:39::7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xQlTU-0001Na-K9
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 08:01:22 -0500
Received: by mail-pj2-x07.google.com with SMTP id
 98e67ed59e1d1-3ac749e0719so573388a91.0
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 05:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794315679; x=1794920479; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kQiLrzQX1/k2GFbN6f9KsjHbyC56JupEZyNnQmB+Ilw=;
 b=ajaob3/Ab4QQkye6ry0LkYdtF6nTxkKRdKVDeiSMdPNtg9LI0Qf6xelv6iGe43FnnL
 ErBi2Rqjf+mFYJRkqO3g1wrH1nTkIlNPXjyMImWdb8FHgB4OEHVgqfV4+Q8dbMGvrsgu
 3ZBB6WjJRFDRj3l4auxRbVVPRwoLnvvfUL5AeF14h4ygRld1ob/ldhzi3lifiNPAdiL4
 3fxBVjfnSX1m26haXpgD0kop7FpFBhrHBHVTJ2LFejrtPYyAqMexJc5A5yaSeaHnWZS3
 TucMvlUoPDNgqw3UVDtJGD0rdhOchprCsmWzK28hKTt77WX6nTO8jbYcCEBUlutAwMD8
 XYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794315679; x=1794920479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kQiLrzQX1/k2GFbN6f9KsjHbyC56JupEZyNnQmB+Ilw=;
 b=rUDQFLB9f/yAJoVdC+9wXfpGgrX6MF7+jJLfNpG+2MxaynlWoJTNXhrxPINVuSAFFJ
 WmST7V/Y5H/3RIjJc2tAqkCAh210BMl6zRc2+Gp5Zbvg6rWQnXF/yngJXsac0pJZOxt0
 9jBzUudsJCX86sAnuH7vbIXCK/Akw3rjxj89gRxHLWZsXKx7b79us9RL/ciRAh70A/y7
 HFyg3Gt1rNyIO0eQ7AQXLj/YmKPcP2kW61FcSqES53SA0zd0pM19Ix01irkVfzyXsq4R
 3zczzjxpsY/mt/dkInDkm+32xFNDBdgK/6LpS1j7iZONme9yVQKuVImMZd4h92UF9sCZ
 LgnQ==
X-Gm-Message-State: APuU4Z8J1lyJkHczncGzC/9QXkKImf5/hcIsJ4KbyLYFjuQBUYfbYcxr
 tEYAqzURrbXm64EJyyVpRCxI2w6jz3AhCkKMvLjh9M3kufzZtx7VhMcA4mInxHQS
X-Gm-Gg: AYBFou1nX0WDz9OEdLWpEJwJjDOEXz/CK3dQEN5eWgkp3AmGqyGuoDqnE3dgPB1yfB4
 QG5mFZpcwmi/PL+gcaNcLVZ+TIXhrpShEDpDN+FFjfv8fATgHW8rLs0QD4z2k5Q0aqC0iiJ8d33
 4z+ksoEyN2sz+BAXr0KEaqDbpdgmr6lyo/TVP4jCgmCtyZJcDKQtPZwCqyKig/JTpqQSE39p3td
 eyp20Eb0xVHiKOHqiZPiiZbPH4maFNeN4RpPJdR7BhTapTeyqCQnv+5AWy6o1PqMr3xdNzHKSdi
 E9Uvw2JOW0GufRHv3T7ccZJiCxIPZyXd4Gtd8kn/C9Kn57eGnxfnWbBaGFGeehmSkO/92sLFqHU
 2pQqSJ2fmQwALNyxONzOS6Bc32qkHtV4SYo+AIeRQYUjgFNDHZf2aE/gXdh9nBC+a57YOIvqhz+
 UWO/IjVcLzTr5xzRVyMfbp9ghIZk4DiH8f/YHw48Ao/r+n9gyWrwSNC4qZ87xEmBPFGMJiksxXS
 2sNI237Mjul8sgiFbPcJkbWVB2lVCOa1ZFA+oZK8oRg3kPU2CfdT9iHkTiLXQpOIhxWaqqMbDJ6
 tJ/frCJIguraVsdnSFmmuowQDrplK/A=
X-Received: by 2002:a17:90b:4c49:b0:3ac:8ee5:e007 with SMTP id
 98e67ed59e1d1-3b166cc1533mr2411701a91.20.1794315678611; 
 Tue, 10 Nov 2026 05:01:18 -0800 (PST)
Received: from computer ([2604:3d09:98d:800:e939:4613:1d28:dfcc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b16769b589sm3765567a91.5.2026.11.10.05.01.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 05:01:18 -0800 (PST)
From: Tim <mdspan.github@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, zhao1.liu@intel.com,
 Tim <mdspan.github@gmail.com>
Subject: [PATCH 2/4] accel/tcg: compare large pages under the flush mask
Date: Tue, 10 Nov 2026 13:01:06 +0000
Message-ID: <20261110130108.706228-3-mdspan.github@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110130108.706228-1-mdspan.github@gmail.com>
References: <20261110130108.706228-1-mdspan.github@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::7;
 envelope-from=mdspan.github@gmail.com; helo=mail-pj2-x07.google.com
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
in the next patch, which installs TLB entries under tagged addresses
and flushes every tagged alias on INVLPG of the untagged address with
tlb_flush_page_bits_by_mmuidx().

Signed-off-by: Tim <mdspan.github@gmail.com>
---
 accel/tcg/cputlb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index dc83f3b..ad2a5aa 100644
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


