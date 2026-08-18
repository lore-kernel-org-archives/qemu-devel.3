Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1549CC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 14:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwLH5-0001mq-Oy; Tue, 18 Aug 2026 10:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1wwLH3-0001mG-LN
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 10:58:45 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1wwLH2-0001WR-4m
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 10:58:45 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5b015b2d792so4420664e87.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 07:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787065121; x=1787669921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=okyVK+5iTTtti3irT3oD0GGgq2lms6vhAteHDMiQvqU=;
 b=YTjQJm3rRn7Fcyd9KGN7pkhZhbWV0ZB+gxL5s9jXoEHXFfr8XRXYpTaxbPoubVZz5e
 2aQVp1vChZHAuQNBJcbW8DhcSghMHjg3vL5pHpRjpsS6ocvP/bo8gxRZkdykYPmbitjJ
 0aoxbTBexRRCH9eLd9e/CbOepVnYxIw9vlu28tgg/a/WoiWTbUNz9pcl8qUu+YTjQYeF
 oLnLaaKaZGWq3r34mTLzOTb6WUyKDZhE6Se7KJoo84B5qPmpSglMCVRCDowpdn3yxEak
 4hJo3fzavf7XYOv9v1HBR+S98PudSeNv/cPt4MUi0XqVmlOKrmb35spIgb2IRF5/Ckdd
 orIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787065121; x=1787669921;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=okyVK+5iTTtti3irT3oD0GGgq2lms6vhAteHDMiQvqU=;
 b=WizzsChri0SaH16LMcLy/qjzIosZAhImfxehdkUhkElU1wQP8TYAZ2hQYrtjij1F8o
 u4g8onLbyaBGQmm7TAKGbJVnO+vkdRnQVX0qbYj2DyDyDTUu0uYuxLSFq53JzBdp44L9
 HaHWj3enx8a4qTSpTHV8/h+wWgAJp+Wv3xaIpZt4TmguEQJVrshMhL9t4mbDLDrp+w7Y
 9VTIG4cDSzLwUG06G5i/zj544qgU64uf8J2zPHhFY6B2+bguOXloh6aziTuC6Dhz6xBk
 D3haw0ArEVrAXZ8sdf6ue+wMUiXOmiXa6VuSAMlGSnKqbqyJDHUjUxu7hBvbf1E6ectU
 MhXQ==
X-Gm-Message-State: AOJu0Yw9TjMKVv0mwLvZId6ajbod78qYNvftwdx8GGtoDUi2/41THPAq
 BX5YeSmmztUt0lcs5NuN3/9H6fYHxPUFPERWCLG3ZrxMHVbAg/YZbuF0ZmwNGRquat8=
X-Gm-Gg: AR+sD131JFgIvdo28gf06rYgvQeNj2XZJchH8sGXB+zENlMJaHC5WiWP5s+6MzxirOr
 rCf4aXAsQu3xTj+04XDfjQ/DPhHjEOztc3M892TQ+4a3bNOXrbTGKKvrk5p8D57TDDWnCepelwy
 wnJ/dafmFaIUJD5ujZP6OxAPcn2iOwV+0Q2O6j0tIymADQ3qxCngEKU3bSSYt8JW7GfbkijAZB1
 hgpxOFvVYjgnQtd6Lqltx4opB3Xv7nDzP6YBfCGSVXIjK3h4CR92ecdN5KNVZwdLAAzkifQ/rwG
 iYrgBB9X/dYdRXfnABt3UPXsQu3mPzBT2XuEeDFFyJZxaKWH8xMuWnGVipKyByoKfpzOpSP+HCX
 Qd9GIpy8YcEsQvA1sqb2y5MHYc4dcWuahvmPitUBjCIHU2Jq7h9JtUEGZgGiot8RQtZMTnwcKDF
 GqF2SqxsfUSU1CJvM0h984Ym6jaj/BuAQglTDeamTiPVj36kJL78S1dVhMPVpp8hOGzw==
X-Received: by 2002:ac2:568e:0:b0:5b0:e6e:8a8c with SMTP id
 2adb3069b0e04-5b470679582mr2325054e87.19.1787065121012; 
 Tue, 18 Aug 2026 07:58:41 -0700 (PDT)
Received: from kali ([82.162.57.219]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b46cf957e2sm1308207e87.3.2026.08.18.07.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 07:58:40 -0700 (PDT)
From: Andrey Polivoda <apolivodaa433@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] target/i386: Mark MOVNTI as not valid with prefixes 0x66, 0xF2,
 0xF3
Date: Wed, 19 Aug 2026 00:58:37 +1000
Message-ID: <20260818145837.550059-1-apolivodaa433@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=apolivodaa433@gmail.com; helo=mail-lf1-x129.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

According to both table A-3 in Volume 2 of Intel 64 and IA-32 Architectures
Software Developer's Manual and table A-3 in Volume 3 of AMD64 Architecture
Programmer's Manual, 0F C3 is decoded as MOVNTI only if the instruction is
not preceded by prefixes 0x66, 0xF2, or 0xF3.

Currently, QEMU does not check the presence of these prefixes when decoding 
0F C3, which leads to QEMU happily executing 0F C3 as MOVNTI instead of raising
an expected #UD when any of these prefixes are present, which does not match
the behavior of the real hardware.

This patch fixes this bug by correcting the decode table for MOVNTI so that
it requires that none of the 0x66, 0xF2, and 0xF3 prefixes is present.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Fixes: 3519b813e1f1 ("target/i386: port extensions of one-byte opcodes to new decoder")
Signed-off-by: Andrey Polivoda <apolivodaa433@gmail.com>
---
Note: scripts/checkpatch.pl reports style errors. These are false positives,
since the patch is not modifying the formatting of the affected part of 
the decoder table entry.
The error about the line being too long is also a false positive, because
the length that exceeds 90 characters seems to be a normal thing in
the decoder table.

 target/i386/tcg/decode-new.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index ac181308ca..cf8431e3f4 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1364,7 +1364,7 @@ static const X86OpEntry opcodes_0F[256] = {
     [0xc0] = X86_OP_ENTRY2(XADD,       E,b, G,b,            lock),
     [0xc1] = X86_OP_ENTRY2(XADD,       E,v, G,v,            lock),
     [0xc2] = X86_OP_ENTRY4(VCMP,       V,x, H,x, W,x,       vex2_rep3 p_00_66_f3_f2),
-    [0xc3] = X86_OP_ENTRY3(MOV,        EM,y,G,y, None,None, cpuid(SSE2)), /* MOVNTI */
+    [0xc3] = X86_OP_ENTRY3(MOV,        EM,y,G,y, None,None, cpuid(SSE2) p_00), /* MOVNTI */
     [0xc4] = X86_OP_ENTRY4(PINSRW,     V,dq,H,dq,E,w,       vex5 mmx p_00_66),
     [0xc5] = X86_OP_ENTRY3(PEXTRW,     G,d, U,dq,I,b,       vex5 mmx p_00_66),
     [0xc6] = X86_OP_ENTRY4(VSHUF,      V,x, H,x, W,x,       vex4 p_00_66),
-- 
2.53.0


