Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE60AC5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 04:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtls-0007Fo-Vf; Wed, 19 Aug 2026 23:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtlq-0007F4-J5
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:48:50 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtlo-0004Rp-VG
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:48:50 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-38dfe910e9dso2044449a91.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197728; x=1787802528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sVV9c8S04txxWkCEX8+hRViSARQ6uNL7zv3RnJ4UqLs=;
 b=h6o+31kM49y2pbqN0oITp/oIKX84EjnBV5veFL+PoCza0V9zVCz4/rikJqg+LJSM8v
 HFCgRGKAvSw2nE5tbIDkIqBUyBNY8pFKFSCfV3TqGAfgn1+2cbuxOsV2hngRPE6JyUAn
 Nykl4PqJodrkgpl+BGQLJ6QvkwiMp5A6habYOgsU9uAvKsSNu6AM79gwVEFlksw7KYju
 d5U8GqFbOgnJCwGs39G/wqcHpenlz1Wl/pLMbLABP8kGgrC6SXPKeA0tBrmyqO8Cp+bA
 JGRGQLXDlwHsugkK4Y2oac4jSDBdi2LTaI6ZMSL3BeX02L449Je/EAMuynGH0jIKU7+6
 9c4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197728; x=1787802528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sVV9c8S04txxWkCEX8+hRViSARQ6uNL7zv3RnJ4UqLs=;
 b=rrRalfAB6MFHUH6dtXLFu/826JL+ZCkie0XBBTdRyFIuG/h2LRwYlBlnH/jVAoGYES
 8rpu3816y+C20OON+TwdoVSKYHhCEWCiMppoffPggwDUQV4GvyBSVGmSqcg3vRoaMkXQ
 XAYPzGRe/mjo3U6BUzTHZBRn5Dkk29dl5HTk4cdOhK1QU7kYSdxI0ivf9ZGLpr7C6t7n
 ndzgNN5TAAW5m4OqUwyWxuYmTkXWluFrs1E40I7sic33joD0K+z5TXk72jJsbWw6o6/O
 5xCltToWa1AxO3mbauEqCf4ZG9rvJoZGlveuXn5xRBOZEWytaEj2vu3iEnU+nyu8eJOh
 tcfA==
X-Gm-Message-State: AFuF++nKwjdMBiY1NCnuH9Jzu8kAOF8jK4zHVRyo9DVaO+tQ7UAmbmVp
 Vr+Mw5XEWRjR8GEi2rljgeW92YP+vSKB/lT8ljZvpxCllJ71QF29s7iS31FZEw==
X-Gm-Gg: AR+sD12hAa9w7kHrSSOoLb1IW7noQNIlY+wghTv3bbWskj7x8Ys4c+ZxnFXE3Kheeoi
 ySYnr/KqQbYPkl/u56fcDwd0FwGc+xUaP777ERaU/9knhYkdl/0otBBss1JCpqIYA7bZ6azeARR
 XeB8rvWsz2/xM/M6V0ByYEzKy0dO9cNSYBgl0Coa1vP2WoD7fjyUtQToms/0R3uEWTRm5OFntwd
 zR8U5eO7JJm/AwqDvfpgxytoAFpbRdJ4lBDg1xDFrBzeBCIDulyKq2BfG+XHFRRGFrBJggYM51b
 fJkAq5Kiynyt1GlJpEz9/tBAa7GIpTIE5YAstZrb8941fSx/fBcesr2+wJX+WbrWVaBGuAJLUBz
 WQFltnfqvPZ8ZgCDNkpi6u/3oyJQhYCYPWXppDamzssnfzHHtw6z590SKh9AVW/kk05HYlSfWmp
 CH7n4Wys3NZKlV1G8a++oja2OLrNuYjJV8cVjC0TBzU+1104QCTfuGYagde0P34Dm1fnrTogCj/
 6WTtQ==
X-Received: by 2002:a17:90b:540b:b0:38f:837e:fc5d with SMTP id
 98e67ed59e1d1-39580a8de4emr19574534a91.3.1787197727699; 
 Wed, 19 Aug 2026 20:48:47 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:48:47 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 85/93] disas/riscv: Tidy decode of c.mop.n
Date: Thu, 20 Aug 2026 13:44:22 +1000
Message-ID: <20260820034430.1186695-86-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Merge nested if's.
Reuse operand_cmop_imm for zicfiss decode.
Return pointers directly.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-50-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 39235e5bc7..197eaa43b1 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1027,18 +1027,17 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
             break;
         case 2: op = rv_op_c_li; break;
         case 3:
-            if (dec->cfg && dec->cfg->ext_zcmop) {
-                if ((((inst >> 2) & 0b111111) == 0b100000) &&
-                    (((inst >> 11) & 0b11) == 0b0)) {
-                    unsigned int cmop_code = 0;
-                    cmop_code = ((inst >> 8) & 0b111);
-                    op = rv_op_c_mop;
-                    if (dec->cfg->ext_zicfiss) {
-                        op = (cmop_code == 0) ? rv_op_c_sspush : op;
-                        op = (cmop_code == 2) ? rv_op_c_sspopchk : op;
+            if (dec->cfg
+                && dec->cfg->ext_zcmop
+                && ((inst >> 2) & 0b111111) == 0b100000
+                && ((inst >> 11) & 0b11) == 0) {
+                if (dec->cfg->ext_zicfiss) {
+                    switch (operand_cmop_imm(inst)) {
+                    case 1: return &rvi_opcode_data[rv_op_c_sspush];
+                    case 5: return &rvi_opcode_data[rv_op_c_sspopchk];
                     }
-                    break;
                 }
+                return &rvi_opcode_data[rv_op_c_mop];
             }
             if (inst & ((1 << 12) | (0x1f << 2))) {
                 switch ((inst >> 7) & 0b11111) {
-- 
2.54.0


