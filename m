Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B117DC79FBF
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 18:06:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4j9n-0001UQ-8H; Thu, 10 Sep 2026 14:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paul@galbraiths.ca>)
 id 1x4j9l-0001UE-DD
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 14:05:53 -0400
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paul@galbraiths.ca>)
 id 1x4j9j-0004ik-4C
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 14:05:53 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 7B1FB1400124;
 Thu, 10 Sep 2026 14:05:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Thu, 10 Sep 2026 14:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=galbraiths.ca;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm2; t=1789063549; x=1789149949; bh=8QNfHbEBej
 fokY1cnwOn4sosK+OKY/B9eUJ6IWy/jnU=; b=vDqN01mkI+jNxwaHexyWCd/TUG
 H+6kC1BZpToYLL9QbribTOHsIw5kYwmJnKSkXNQDTKhC3vnL7OVBfM9z93716krw
 Inn4EbB1pwIiYJ06PvhW7qRgi/QQNiLzJ4wYPJ038kcn245xD72+XPPvFTb2kjWP
 U2GNmx+AA97mJaF653xIfLl+QV/hH6qpZwEAaEIEM62GTdGe0uRG8heKWHWANyIC
 V+omWav3mGeRFuVELIC0LWVRu77UFgyVXza17pK1PQgJMBas9D4gY9U/8KQaD3e3
 BWJJnVzx7JMCLv8QjUdDZruBAXAZC8bpVQsAptcJ7NzS3OimVqAIM76t9HNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1789063549; x=1789149949; bh=8QNfHbEBejfokY1cnwOn4sosK+OKY/B9eUJ
 6IWy/jnU=; b=cgupIiQsr8Irj27qyNZaB6a+Q1fRIJQqnoQJd4WiaX/6yvQjqM/
 qtO3sX9CooNGUxOiJT3SemB1cUYddi0mUv3KI7iq1AOhF25Et/IxqdFztdIYokZf
 74NMOtlE7Y37+xcFP57MmIDoPWS9BHd8z5VkOIpjC/OL8rnG3H4w8C5QF98ouVym
 nnDjBJSomrtDCKltN4rjxT+pgDyt310HWF6myzsynaTD664iexpLKlGI2ht9PR+9
 jtAig3rZp30jQXaH4RoBgDysa21T51ljTAa7yOk39Ba0A1Oejc8B9DnMolCH5FRp
 LUtBD2LjctJa/qiRIYDt38ox3Jx3Ax9CjOA==
X-ME-Sender: <xms:ffGialB3afVIiqKKAsMf0f_1_2C3F2oz9_ZWNTXtmnlDD_Y12JVs4Q>
 <xme:ffGiajoua6e9_ZoxHK60jamK12vm_Du7YFZ7gm6ywjhl66aMYxvdfHu7Qzz8swNqI
 Y7qkKyXyLnQyVqleonoA6GEKzzLS3FBrCQCzKyjXXElsAtgX8d_lwY>
X-ME-Received: <xmr:ffGiaojUdesq6TQuZtzAe53bwvUf2DhZfBhLbcA81hDcJLUjy-ESy53fIBfOZOlXeZP_0-Chp1xvJJf7z0A>
X-ME-Proxy-Cause: dmFkZTGCeWlioMSBXvrOfU3jQFjNE4yJ/NT2m2J+Y5WH3IdZ6Ba/pdFJRhzvXWiomRx+jW
 Lpd2WjFTBn+NSwhMQFrR8Q5Pu9+0UE95jVrRArEsLYHQzXczRYjeN96+DRyGD94xQQzheC
 zJiTGGu/7GrJQKoKxLj/dgKzWBllk29SI7caJuk0gbFTAljM+tXjurd2W237B74284z+S5
 daF0m5KdS1ynsu6hL5bEgFK4Cp0FAdM0jhKr/znyvf0+SHtY7Om90Z0nilQir+r1A1mOki
 IQ4O2EKBbXkZmJrbYqEBI2CJzBJAJPbBoAJELQv7TnUMBOEEsRovEkLTGWoFC+X273iBom
 JzXLX9QymiSUPfIExi8FquOdfnkjdIeZFrvNmDHKRQjMsMw3qeZ0EtQCAmO7p+Tyioo/Lo
 4KvcYVA0W/XBj544BVYwRdEbHLhD1TBvJflo4pPccQZO8Yrh2EkoJJF2mSXbpAC5SJFXVF
 9IRDo46oqK2hrokF8AXld37HUVXaI13tkjahIaKhJMlvlckEFX1FIilNprd4xA2THVXjIa
 P/h2uPtK0RoYbujN7M2yGDJrMPXqwm5lOI7JapIxkczTdaXLfgWUrgqV1dNiiRDm7LBUX+
 nGdi5L3iJkxEuTMTBopeGokwnn2Vcia50zXsGOX16qOTGz1OOmwS8jUZ9jLQ
X-ME-Proxy: <xmx:ffGiaoBurF7ECXpQilCiGn4eNwALMjoKNxj5ElQMZpa3SrtrC1WXxA>
 <xmx:ffGialEanIZv_m0bb47pnmXBiwROZmguoV4gyImMeIYVMf2JB8VOdA>
 <xmx:ffGiaoII6OnEvgkDqLGyb3AMaYkBBWPI-Nx0SdqF-3incRh5STZtEQ>
 <xmx:ffGiahmhiVAvNTN1sc4WmYfGLryT3jWzBAEESsqEPaiuw6L3brrF6Q>
 <xmx:ffGiaoELMCgSqdpHZ8nI7qA2X4or11yrMwGlduscLArrvJwQDfu_mpIq>
Feedback-ID: i00314697:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 14:05:48 -0400 (EDT)
From: Paul Galbraith <paul@galbraiths.ca>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paul Galbraith <paul@galbraiths.ca>
Subject: [PATCH v2 1/2] target/i386/tcg: fix EIP truncation for wrapping
 16-bit near branches
Date: Thu, 10 Sep 2026 14:05:15 -0400
Message-ID: <20260910180517.97-1-paul@galbraiths.ca>
X-Mailer: git-send-email 2.54.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.158; envelope-from=paul@galbraiths.ca;
 helo=fhigh-a7-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

A 16-bit near branch must truncate EIP to 16 bits. gen_jmp_rel() skips
that when the target lands on the same guest page as the translation
block, taking a branch that stayed on the page as proof the addition did
not wrap.

That holds for the linear address, but EIP wraps at 0x10000, and the two
only coincide when cs_base is page aligned. Otherwise two linear
addresses can share a page while the EIP values either side of them
straddle 0x10000, and a CALL or JMP rel16 runs with EIP untruncated.

Compare the source and destination EIP pages instead. It has to stay a
page test rather than a check on the EIP values: a CF_PCREL TB is not
keyed on the virtual PC and records only its page offset, so the same TB
can later run with EIP shifted by whole pages.

One case is left over: a 16-bit segment with a limit above 0xffff (D/B
clear, G set), where EIP can start out above the mask. The data16 guard
keys on D/B and not the limit, so it does not catch that either. Closing
it needs the limit in the TB key.

64-bit mode is unaffected, as no masking is applied there.

Signed-off-by: Paul Galbraith <paul@galbraiths.ca>
---
v1: https://patchew.org/QEMU/6c5fca8e-b9f4-48a0-a070-42f10d1f942b@app.fastmail.com/

Changes in v2:
 - Different approach. v1 required cs_base to be page aligned before allowing
   goto_tb, and dropped the data16-in-code32 guard on the assumption that the
   new condition subsumed it. It does not: that guard is there for a separate
   case, EIP starting out above the mask, so v1 would have swapped one problem
   for another. v2 compares source and destination EIP pages and leaves the
   guard alone.
 - Split into two patches; the regression test is now patch 2.

 target/i386/tcg/translate.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index d8de290acb..6d3c929eee 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2025,12 +2025,24 @@ static void gen_jmp_rel(DisasContext *s, MemOp ot, int diff, int tb_num)
 
     if (tb_cflags(s->base.tb) & CF_PCREL) {
         tcg_gen_addi_tl(cpu_eip, cpu_eip, new_pc - s->pc_save);
+
+        /*
+         * True if a wrap cannot be ruled out: the source and destination EIP
+         * are in different EIP pages.  If they share one, the addition cannot
+         * leave [0, mask] on any rerun of this TB, which only ever shifts EIP
+         * by whole pages.
+         */
+        bool eip_may_wrap = !CODE64(s) &&
+            (((s->pc_save - s->cs_base) ^ (new_pc - s->cs_base))
+             & TARGET_PAGE_MASK) != 0;
+
         /*
-         * If we can prove the branch does not leave the page and we have
-         * no extra masking to apply (data16 branch in code32, see above),
-         * then we have also proven that the addition does not wrap.
+         * If we can prove the branch does not leave the page, does not leave
+         * its EIP page, and we have no extra masking to apply (data16 branch
+         * in code32, see above), then the addition does not wrap.
          */
-        if (!use_goto_tb || !translator_is_same_page(&s->base, new_pc)) {
+        if (!use_goto_tb || !translator_is_same_page(&s->base, new_pc)
+                || eip_may_wrap) {
             tcg_gen_andi_tl(cpu_eip, cpu_eip, mask);
             use_goto_tb = false;
         }
-- 
2.54.0.windows.1


