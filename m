Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3672C9830E
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 03:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAJ13-00081o-2d; Fri, 25 Sep 2026 23:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paul@galbraiths.ca>)
 id 1xAJ12-00081f-0B
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 23:23:56 -0400
Received: from fout-b6-smtp.messagingengine.com ([202.12.124.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paul@galbraiths.ca>)
 id 1xAJ10-00009v-9m
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 23:23:55 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 42C811D0006B;
 Fri, 25 Sep 2026 23:23:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Fri, 25 Sep 2026 23:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=galbraiths.ca;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1790393033; x=
 1790479433; bh=8S3opI7vrdEG/nPSyIv/cACVp2yZhGAylytqy0JQ/xA=; b=r
 Jah5Rd4WLCweMc1oFWsDpkvepfq6KN12vvBc+gLOcT6GP75GJsvu2tpfISjkPmhP
 T321ypYLIca5GMO3Okquw1h9Mo033htu+GTqky0Lro7o/oWx3mivXSiyHrWvfzvI
 3a1xQX2elU6w4SxcGj+5cdX3odkmBEGw8MnHLHTJsucYWZ6cM1a6Bh5swwFGmNt7
 jpyUIlxQs/F7ZgKIMe6DsfXgdJvt/XcvNYzPqx2rHAvqONv4gUtSCDK8CfNTjpvU
 +SW7aNqQ53xaG0pBL8KXfWWRkmRXW6IZR8WUlT6XhVNrUN60CA0KNPIrxd0IDQVL
 oISofGsEr/v4AJyyIngjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1790393033; x=1790479433; bh=8
 S3opI7vrdEG/nPSyIv/cACVp2yZhGAylytqy0JQ/xA=; b=VQXPkHgsj9zl0ZwqU
 9ozDDqf+V0gm5wBr5m6huR5sJ+cB+pq4aP3tk0B5RTVM7LGZmjHPFACSJkVqi3wi
 OqWTBdTaH4p26O0JY4wxtzrbTSZXIZGrhTujEl5Vr8VwZuigQvNzHCLAG2c9FhNu
 myEi8CKTvCMKeUeuqWYN9/L/dxcdFkKvk01oIsG2XpsD72pX6shwbJ5SJ6XENmBO
 oJ+b00z39c95HZMADChBm8MghfFgJGMCfp8FSkhTSGsoPBuwqLFWyvylU/81CQrN
 YeNKudjzglwELoHlT41hZj6NNnkznSxNzOieKOHkG0uxc3fAec1BXO1hF6jTF9u2
 T2UPQ==
X-ME-Sender: <xms:yDq3all2lrjTBAGA_m1dlJ2MwkBszQRIRaDxsqgLuFqB9Ds9NhvfIw>
 <xme:yDq3ag_bARkjLy0WWDRTQV7xmZlQgwDoV6qInYVLasRxxxsYQbuvV0RmJpWlER7O_
 SlInjRTa_1ylWeIZDy89XByFiVNA1De0WFTpIErwnk7JTxInUNOMAMv>
X-ME-Received: <xmr:yDq3ajnJQLJOFNf7B3I_pPuJmoxCfa_d9uAx69Vdnh_42PyfuGQ1qkoNPtwJIuSn2Pw3CdtuA_Mgp130f-HO>
X-ME-Proxy-Cause: dmFkZTEdcYkaQJ+iTkEjT16KNjbMj/htJ3DV+pGdLzXjvnJy9fGhY1qphRJciGsxrBuXCC
 bb+cl4WKhrxJp8Goxc19okexAaTOj4CDMqZqizpnJ0ubVqM8KNY/hSvvh1buLqPKyS2fpO
 +LjHGB7+2cYSSXelwG+xd050NaAPXU4lAn3pJGFgEn85LfB2nBXv1OLLK/jhVRexc6VGR9
 RNwZh+5ooCWfAd1jt972K7Ebiic6+xTZOa5lym4OBU+x+5MCW5y/GqxHwD35zOus83Hw59
 oIEJ7zVVqvXpCNoGr0bd/cPstn1MUEBzPppeoLL6RQB9HvvtfDg8QRP/Pd3RgSonjFRZOK
 RYfCDwcJAZz6dgveZTkP5V18K4aNw9Qq5c9gOh/IQTqF/8Ln0FwNm9o7e+oLEDKBiTM93A
 3EEpGzW7CNKBXGuK182Ja6Xp5Sa+iH6XUfX02WbIumG+s/msx2ke99QJdJhPEZf/lpIzQ4
 cDTEqdxIL2LQ/cYAlp43aEBeSSeJWMg7fGQdR1jb5aYpcvZj85sqGQeUWhAwIV8aOGk0W9
 JyY20GSMvIMxzFLMrEU7s52mJKsSY3TuieeGghOgm6qAI7tFuBx5fsH8RSPv7xOv174rY3
 rnHSuGWihx+TEyO9Xj4+VvZbEm/dnoE+0HMZYT9wlVTSIPOfHqd9+AcbUt5Q
X-ME-Proxy: <xmx:yDq3at2jGWw16IiSzWJN1-lOs6asXJWqfLpbKmixnzGK5KF_PUbvYg>
 <xmx:yDq3aupgyTNGDhqt-9bPWHtrh0sLQAcb2LWt0w266FW5N8wSO4lN9A>
 <xmx:yDq3aqeNqBYxbb0MbFUk_4BSjCrirHf3VPgrE6QfOzG9KyTfa-J6Yw>
 <xmx:yDq3atqPPSpqSOd5BfOIL0C2TxFTLQsVLYV2iBkHKjZwLUe68uhPhg>
 <xmx:yTq3agp0UzGYGlYBVa156JgaZXO4-m2ahHiPooiCOFXt2_u2oTnUYzGE>
Feedback-ID: i00314697:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 23:23:52 -0400 (EDT)
From: Paul Galbraith <paul@galbraiths.ca>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org,
 Paul Galbraith <paul@galbraiths.ca>
Subject: [PATCH v3 1/2] target/i386/tcg: fix EIP truncation for wrapping
 16-bit near branches
Date: Fri, 25 Sep 2026 23:23:35 -0400
Message-ID: <20260926032336.933-2-paul@galbraiths.ca>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20260926032336.933-1-paul@galbraiths.ca>
References: <20260926032336.933-1-paul@galbraiths.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.149; envelope-from=paul@galbraiths.ca;
 helo=fout-b6-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

A 16-bit near branch that wraps through 0xFFFF must truncate EIP.
TCG skipped this when the target was on the same page, which can
happen when the CS base is not page aligned.

Signed-off-by: Paul Galbraith <paul@galbraiths.ca>
---
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
2.55.0.windows.3


