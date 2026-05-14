Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C99CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNa20-0001j5-KS; Thu, 14 May 2026 13:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa17-0000t2-EE
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:39 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa0z-0003uN-Ty
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:34 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7de7dc85b74so6749906a34.2
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778780285; x=1779385085; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=POF0l051QujwitIJAfqcVgotBzAjWMSDYCXMdZExEP8=;
 b=EqYyRRtrjlvl+UsOhbDptfw8M+iIHwXpnnIx7zhXIBbAfzhNoKqu+5bVnjryoOyVzG
 URBaE+6Xh2Cjx6XVuhU2JfeKC94IaaLqaLgMGAr2lw1l+tXKBHMLbExNS7zDLmtAzydY
 FrbtLp7sm+XF+MLAPyoA51ZeSSvM2kNS2r1SKyI7aO8oQYFk7sy/wpretca2zzZbtQhb
 uYam2UwJQwwIyxGuxOBbGiV00GAlpMmHbw4cfon/vsgqx4ALt4JdNB4H/z66IlogXexc
 GZ1ud54lOC+WLTm5eg0PgxyJXR84ZQ+bAmCe1uhgbkZMsCdf8DvVEgKYEjlFBs9uvunS
 GJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778780285; x=1779385085;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=POF0l051QujwitIJAfqcVgotBzAjWMSDYCXMdZExEP8=;
 b=TuEc68L1QTLMYMzcV8Qb8/hODdsyFLoeMWcykY+R81phpAhlh0LVsxBwSCpB30ZlXl
 Aj2EY+3kZPGPDUtNL+eSNAMlcz7Ro2VuQvPtGxnVKaYiD3R3dsU9Mu+2Ol3kNd9RzNbB
 +Q7j0GNVKfOJ8m9kHb1pfoD8N1tBAEgNXKagiUNf6ikeY5Z+UL8tbRTauYdcvsI8LlFP
 7L8yMl62roSIpM5mQDIloCk8QVnO/EO/G90MuIFOkceuGF8dVuuZhaQQqRq4cLMxyftp
 WpQLkF9fXnr3WmgIRvodAHmGNdGWH4SrrEDu8YJVa/sns4HNEuzPBvmZ8LZPzU3RGHK0
 tkvA==
X-Gm-Message-State: AOJu0Yx3wj7/i8p4RMsqc5ommr2D0HCXOlifG+h6+RMz9LQACK4g7m4g
 VTtMJXWF+fJ4jSoOiFJDkAKGckDlXLREpKbURxAnCp87aGp88JxTSpH+
X-Gm-Gg: Acq92OFdn39oZhg8U5cWs7EoHvK+nCBipUIHrLuF36HWIclFkA7pVb3NDtxfCbDSSzQ
 A3PtYz36BDtZlrEbABf3ZGTliYghybuyOiM8hD/opH7EolWhFbw576ShF6KNFrq3LxfVgfnJ1sa
 LfkbgUsmpkti4Fjljo3pVFUKUyYs67OwaguRuHkfzdCI0Ks4Pcsmi8IL+R9wxoGr0cG2PJrlKT8
 Szky/EPUZD9g2h21TyeXbPsFCMMJjdcUrn4keXYPLGoitwfNyTEeCKvNOHFzXvB4LCaj6u2TleQ
 o71LirOMaSspeFfM0YwRVBJ3xAEjtjMteTltcgH+gT6exUe+aS7KNpvFESvvezoV0KkyfSfbD8a
 +0BsF4/ZAJpp4XdF+S6RYvfFQoWhnv9jEMyxWpn6vDo7Wijp8lMpGipEIRvhc8YHm7tqMZRB4Od
 jjDnbWxZinoYV5IrfoZ+mvq6qpGROqzMWqHkZ2PO+sV+qgcNwKtRmr2CnJtW6qu26onQY4vI0Tp
 C1dGVuY+oH8tVsqdX+kPSQ03/asnkwuA92oBskwJ+VgirQbyvJkWRpoBbMK/JCtkIL3Z15KIj0w
 syY=
X-Received: by 2002:a05:6820:1f06:b0:694:8f3a:3f3d with SMTP id
 006d021491bc7-69c94375246mr255972eaf.35.1778780285542; 
 Thu, 14 May 2026 10:38:05 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b8ccdc74esm1687254eaf.13.2026.05.14.10.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:38:05 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 14 May 2026 11:37:01 -0600
Subject: [PATCH v7 12/35] target/mips: add Octeon ZCB instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260514-mips-octeon-missing-insns-v2-v7-12-226686be4ce1@gmail.com>
References: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
In-Reply-To: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32e.google.com
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

ZCB zeros the 128-byte cache block containing the base address.

Model the user-mode-visible effect by aligning the address down to a
128-byte line and storing eight zero 128-bit chunks to guest memory.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v6 -> v7:
  - Use 128-bit zero stores with MO_128 instead of sixteen 64-bit stores.
    (suggested by Philippe Mathieu-Daudé)

Changes v2 -> v3:
  - Split ZCB out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      |  3 +++
 target/mips/tcg/octeon_translate.c | 27 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index d77717cd50..d8a1bfce77 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -49,6 +49,9 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 SAA          011100 ..... ..... 00000 00000 011000 @saa
 SAAD         011100 ..... ..... 00000 00000 011001 @saa
 
+&zcb         base
+ZCB          011100 base:5 00000 00000 11100 011111 &zcb
+
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
 LWX          011111 ..... ..... ..... 00000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index d3dfef2e0c..d89e53045e 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -176,6 +176,33 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
 
 TRANS(SAA,  trans_saa, MO_32);
 TRANS(SAAD, trans_saa, MO_64);
+
+static bool trans_ZCB(DisasContext *ctx, arg_ZCB *a)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 line = tcg_temp_new_i64();
+    TCGv_i64 zero64 = tcg_constant_i64(0);
+    TCGv_i128 zero128 = tcg_temp_new_i128();
+
+    gen_base_offset_addr(ctx, addr, a->base, 0);
+    tcg_gen_concat_i64_i128(zero128, zero64, zero64);
+
+    /*
+     * QEMU models ZCB/ZCBT as zeroing the containing 128-byte cache line
+     * in guest memory.
+     */
+    tcg_gen_andi_i64(line, addr, ~0x7fULL);
+
+    for (int i = 0; i < 8; i++) {
+        TCGv_i64 slot = tcg_temp_new_i64();
+
+        tcg_gen_addi_i64(slot, line, i * 16);
+        tcg_gen_qemu_st_i128(zero128, slot, ctx->mem_idx,
+                             mo_endian(ctx) | MO_128);
+    }
+
+    return true;
+}
 TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);

-- 
2.54.0


