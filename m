Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203DEC4450A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 13:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjzv4-0005YN-1S; Wed, 15 Jul 2026 09:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wjzv1-0005We-Dm
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 09:44:59 -0400
Received: from mx1.catap.net ([2a01:4f8:271:125e::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wjzuy-0007u3-Rp
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 09:44:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=Hi1eRls
 rq5IF20+n++CRehrROOA1/74g4q4GLsA73qaBHwz5c5ElWbyAPYbHoKua1roXKRvM+8IFG
 HhPt0bSJudUaZwSPPZSME+O8ILHgv0xMgEj9pil3wOvVVrTmtMzEfvHdX7Ioh7q8UxjyuV
 g+3/z30+haPw3HiFaEsbM78p+7LAA9UlcfpYHDMQGhh2GwvRKGS7wWZ8Y4bSy+mpg/WvyX
 bHPZfPHS2wicy9x8ddzgFYDYVOUW5gdEhgbF6LMNWJxX1/3jId2ZY9pSVthAef3o2d0J/h
 /Se7WQTTdnM5NG0CAG5x1bNQ1nqhmD9Z3ISPB3L6tqhMPFXS0PshSmA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=6
 mS6E9/j2Z3UyVv8/YQsOxEUThpdW2ccwS2/LnYdZag=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=KDDzjVmnncssdIYLCWV0Eez63FyqSWwblNb3GGDgZqqk9XgUacxBTGqLndd2bKYgIhkc
 rl9k/zD9iKIdNMPUjjT4FSTEKQOQU1MQ1TlchoJTa1yJU8gmEaTY3dvMw+sh3D3L+s98kq
 Y0MHSKIcnybKnUX0x9aeK5tZwpmhbhBlM8o8M0qy28alionMVZ9Hm4XeetdaKoESvndFZe
 mNHtyDfQLzYVxmzF4W81VDzSJnsqy3HpavvH9rO85O5L7iXAbW6gwmAbG/Kh0SR28Xwn55
 cYjm2UMe8glOiiwKOxQkn5TaJDg7jQs4bk8rHUvHvLh+gxSUZHqMIfP8Zd5Tg7cA==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=Ue22u+iB; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=0WzbjoKy;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=6mS6E9/j
 2Z3UyVv8/YQsOxEUThpdW2ccwS2/LnYdZag=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=Ue22u+iBhM/1dtrEml1t3nWp9zFPl7Ga3TQ
 Z8TXP9u6KGn+jyy4IPeoLEFUwU7QkBGmm2/26HbSnQkb2DFqw7ZitPxNZclsftEwBC2Zdq
 0bTRhVBOiukSezub+pu0+a3S2V7FydUUX4s+2WD71JpBUjWI/8TtZ9J3CUxuEu7Wdgg6a6
 jTH3gMZudCsBM3tZFOdFl294c052KmhimUYbzoGj5bVXny4SYjRZx6SCmVL03uqGGu5fNZ
 H5d13mt7wx7vxR7Q5JQyhPJmmsH+4CjVXsEgpb3u3jf+6hYqcjV34kF6sVEnuZeMr//yEB
 5m529Bd7ES4LUuSnPzVp+kRNQAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=6mS6E9/j2Z3UyVv8/YQsOxEUThpdW2ccwS2/LnYdZag=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=0WzbjoKysEz25EL+Mc
 P1z9lU6HMPSe8ZQIvxQL0j2JaTxlPfnDG3TUVAUPYGcZRLe9ByRCq5M+kb6Q2kDMgWBA==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id 5f4afba7
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Wed, 15 Jul 2026 15:44:50 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 60a4bac6;
 Wed, 15 Jul 2026 15:44:48 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v2 03/25] target/mips: drop hidden TLB shadowing for tlbwr
Date: Wed, 15 Jul 2026 15:43:49 +0200
Message-ID: <20260715134447.56007-4-kirill@korins.ky>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715134447.56007-1-kirill@korins.ky>
References: <20260715134447.56007-1-kirill@korins.ky>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f8:271:125e::2;
 envelope-from=kirill@korins.ky; helo=mx1.catap.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

tlbwr replaces a random architectural TLB entry. Once that happens, the
evicted entry must stop translating guest virtual addresses.

The current helper keeps the evicted entry in QEMU-only extra TLB state.
That makes the old mapping survive until some later operation discards
the extra entries. A guest can observe this directly by writing through
a TLB mapping, replacing that entry with tlbwr, and writing through the
old virtual address again.

Invalidate the replaced entry instead of shadowing it. This keeps the
translated TLB state aligned with the architectural TLB contents.
---
 target/mips/tcg/system/tlb_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
index 9772df5d6c..4c0a25e622 100644
--- a/target/mips/tcg/system/tlb_helper.c
+++ b/target/mips/tcg/system/tlb_helper.c
@@ -165,7 +165,7 @@ static void r4k_helper_tlbwr(CPUMIPSState *env)
 {
     int r = cpu_mips_get_random(env);
 
-    r4k_invalidate_tlb(env, r, 1);
+    r4k_invalidate_tlb(env, r, 0);
     r4k_fill_tlb(env, r);
 }
 
-- 
2.54.0


