Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBB6CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPfAT-0008KY-Po; Wed, 20 May 2026 07:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPfAG-0007zn-Iz
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:32:46 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPfAE-0005Pp-Qv
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:32:40 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-394413a63d3so39749361fa.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 04:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779276756; x=1779881556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LtmhMmok2qaZ50VSXqH19jN+0cDOCQGc9KxyroHnHRA=;
 b=q0wEiDTsd+Cxl5vAd0M3txcRwwTHfE7+6D4OjBFXpgyvCNbytVvW8mQ6pY0aVIfTRn
 DwNyDT3x+ZdinrIMcP5hmOmHBPlzV33RYVaN6ifTnGEGVJWeQ75TsPCzoEdCWANgamgc
 lKiZxyEgpEOqn45rmpCm7PjWp4konIbbzqzfpDYM05HuWNsEE5kRq2cS3GsMo1zmmX1y
 HTW0IIHsGI14Mo9VqLxvZURLMVjvujZibjJRTI71+OFEBbLgrzyR8MmOhBpi8h9+zalb
 BK9LFqDuFZEbMBZ7m4Ws6Xh/K4YBlutNbWxr0S07JmImd+cO62zFzar4HLMh+pWsCl9p
 sA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779276756; x=1779881556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LtmhMmok2qaZ50VSXqH19jN+0cDOCQGc9KxyroHnHRA=;
 b=rDFyoG8/qKryHP/47Gd/i+5F7b290wfg7uxPfHLpsSY67E6LlAzjMNntWxT7RZtFTK
 yNoo0UfEyNlbr16l+c1SUxl5XmsUm3HiwHiz/dCkS1l+23mvHj7qzJogFzbA4d1DRwpF
 AYQbm7TALpDOP+HNB1OLHQfS3bVkOOHcenKkmbc9lhSIu+Ifph1aIo1yuHnxhF7Vf9tN
 5FzlSqW28uf+ZLp7p9lVzdZ0acBIM0CNwAwwG0NnvqTQFxuTEHIrZRFTx0AzK7WAzReo
 dCCtJDahPEoPGxvgZ5jHs0u6Eg0HIUh38Z81d3SJ5UXQkhafagBpokOsc81IGjs2J7+Z
 lsFQ==
X-Gm-Message-State: AOJu0Ywxr0A3GqYfQvW4A4R7n9S+JkyNqJLykTv0wxLkxXXlTbSdbTPI
 7c0JC0byH1+QwdZoyRmQDHf9s9Cj+dWIHRi+CNCovM+bggNztpNUa0VwHSruPBCakD/VisQVxHD
 +Wy8JH7M=
X-Gm-Gg: Acq92OFiWJ3DFdLU0f7xpdoCSIuEMYZKzAnC4EO5ynNm2bCdOghVbacEw45DsklyU5d
 Ha0xEL+Ftc49S4JGBpM5K1ZLJbU8jKQViPw5ougcXSQ3kk2xUXq+SbdWuInKVsq6NjhSzCThmHi
 /5UB+Jxd4e0QKMbJtV7N2gddPUomHHUJlIiIPzTRdoTqaLoyWokp9Aus+dqwKvc3ufGLuuEeGr6
 xndU//CxMb5UuJMja90X4dzDkh3rxL2+skUBN2yQWNIeE/b7OkyUvvV63dlKEAOHTJu5cTrGdVI
 LtJPHOPj2T73XZ7mxQt2W6+4c3bKmurgsM9ykB4DuyZEwKEKIoPAAz8QMwnf9dvRzkGqHTkmSWX
 ztiRMkIrrUkSEy3JJ/5bS0Qa6tovxPmbc5VAhyyElUy3BLnHMgvz21AKfJNbU+IsKxIU+nK5psO
 P5wQpfvybAVnr8Q2MhzCsSquozGA7pNdOjJgUq7DFraeI8/7htjErfPN7uDQxRAuDxj6d7LDsDG
 CD6uQ==
X-Received: by 2002:adf:f643:0:b0:45e:73b6:d107 with SMTP id
 ffacd0b85a97d-45e73b6d124mr18275366f8f.41.1779272452379; 
 Wed, 20 May 2026 03:20:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a19c2dsm53783964f8f.21.2026.05.20.03.20.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 03:20:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v11 22/24] target/mips: add Octeon V3MULU instruction
Date: Wed, 20 May 2026 12:18:03 +0200
Message-ID: <20260520101807.9971-23-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520101807.9971-1-philmd@linaro.org>
References: <20260520101807.9971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
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

From: James Hilliard <james.hilliard1@gmail.com>

V3MULU extends VMULU across the full Octeon3 multiplier state, adding rt
and queued partial products.

Return the low result while shifting the remaining accumulated limbs back
into P[0] through P[5].

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/octeon.decode      |  1 +
 target/mips/tcg/octeon_translate.c | 40 ++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index f9c32e1dee1..4d0ad058347 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -57,6 +57,7 @@ MTP2         011100 ..... ..... 00000 00000 001011 @r2
 
 VMULU        011100 ..... ..... ..... 00000 001111 @r3
 VMM0         011100 ..... ..... ..... 00000 010000 @r3
+V3MULU       011100 ..... ..... ..... 00000 010001 @r3
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index e51d3e6cf78..04e51538f93 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -316,3 +316,43 @@ static bool trans_VMM0(DisasContext *ctx, arg_VMM0 *a)
     octeon_zero_partial_product_state();
     return true;
 }
+
+static bool trans_V3MULU(DisasContext *ctx, arg_V3MULU *a)
+{
+    TCGv_i64 x[7], y[7], z[7];
+    TCGv_i64 tmp = tcg_temp_new_i64();
+
+    for (int i = 0; i < 7; ++i) {
+        z[i] = tcg_temp_new_i64();
+        y[i] = tcg_temp_new_i64();
+    }
+    memcpy(&x[0], z, 6 * sizeof(TCGv_i64));
+    x[6] = tcg_constant_i64(0);
+
+    /*
+     * Z = rs * mpl -- 64x384->448 bit multiply
+     * Compute even partial products into X and odd partial products into Y.
+     * Include RT into the odd partial products, which are 0 in bits [63:0].
+     */
+    gen_load_gpr(tmp, a->rs);
+    gen_load_gpr(y[0], a->rt);
+    for (int i = 0; i < 6; i += 2) {
+        tcg_gen_mulu2_i64(x[i + 0], x[i + 1], tmp, oct_mpl[i]);
+        tcg_gen_mulu2_i64(y[i + 1], y[i + 2], tmp, oct_mpl[i + 1]);
+    }
+
+    /* Sum even and odd to produce final product, plus rt. */
+    tcg_gen_addN_i64(7, z, x, y);
+
+    /* X == (0 : p5 : p4 : p3 : p2 : p1 : p0) -- x[6] is still 0 */
+    memcpy(&x[0], oct_p, 6 * sizeof(TCGv_i64));
+
+    /* Y == (p5 : p4 : p3 : p2 : p1 : p0 : tmp) */
+    memcpy(&y[1], oct_p, 6 * sizeof(TCGv_i64));
+    y[0] = tmp;
+
+    /* (p* : rd) = (0 : p*) + (rs * mpl + rt) */
+    tcg_gen_addN_i64(7, y, x, z);
+    gen_store_gpr(tmp, a->rd);
+    return true;
+}
-- 
2.53.0


