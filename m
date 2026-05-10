Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B741BCD37AF
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 02:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLtgT-0006C2-GO; Sat, 09 May 2026 22:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtgI-0006AF-DM
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:10 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtgG-0002zQ-SN
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:10 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6948da50eb5so1727824eaf.1
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 19:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778379247; x=1778984047; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JORHga7aTlCMz+QuOKMjtA/2ISg6aPqI+xE2yOVY0q8=;
 b=SBs/Wr2TooJLi96hc5NZxbSoKkMn9Ev5NXDlwYFWfztFGI5OW7WQVQvLruxfU0vMIE
 xUwOvhRigiSGaI4XpnfpU3JHsQ6YX1tPJ9WTiF5Xl33Cx33bY3tr1HKcSwyE1zqdT7ns
 uzaYl8bPSEcHD/NseNOmjVZIs+gScbWgS+XSGA7BisqbsSEM0OBboFOR/3mkCFfbhXU7
 0zKBehnoX9LzR8bEYolh6c03ToOyf3huISWcbknXMZeGZIAlRBIlNEXHeOCmF5RkzT6p
 JnIasB9iqNuGhm01BDo+Gv/5Ll2Nsz+Gvk6lG9qut9dbX0yHzLPq/I75RX5SEoCaxgwO
 P+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778379247; x=1778984047;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JORHga7aTlCMz+QuOKMjtA/2ISg6aPqI+xE2yOVY0q8=;
 b=g01WByqI+3EiS5zplwavmOs4qwP+p/em0ZKl6Dwt4NL7ziktAJRgB5wb5QooYl+L/6
 P4yxbLn4bIiTp8w01sR7TEx3qe51cSrfZcGKn/v0zHfO4n2nVcfcN4Alktpod3uLgX+G
 KpPFBRZXmQc/4AXYUsf0PJSVO8Z8/73BHXRrOmw1RIxXn8SDnXvNSKP2jf9Ho21yCuxh
 711si92q0YO65I7Whu94wAYJ3vN9RrBdJ3UauIu4urfWwLPWUnjyYjZ55y15r1ApnPb0
 J+EmnQ3iyFIY/JdGDpu+tiTszkeMle4AKZQPZY4bqXfeBpLjrEw09gIrZqagYZdbJRdp
 lCJQ==
X-Gm-Message-State: AOJu0Yylw/DFpl+vQWWHHtP6u4H7HLeu8y94lZmb6Kb01w1UwD82JnM+
 AcEY4olgzWFIQaxOioNPk/U6tEwlDgPSM2mQtxFBLxLWP6tPEI3v+VjPROtlGVtE
X-Gm-Gg: Acq92OHMzn+PzGhCG59rYpdSvti7DNSQEq2zdEA2rXdlkHrdOaX/BH+TFZZyqGW1YeC
 nHsFamv3Q0YyDpyxfcEgKuxAtiMnbfRBh1qRD7IvSq/aIZeSTna5HnGzH8Pz1e2jiJetT1B/3n+
 w7KYRLUrQfRECCJEmBadGYr4A4DpRFp+5CXnAyJxhhb67PHjlQG0pHO+X0cBLzyKWp2SrbokITr
 bws6Vcv8XvpNMXDr5DwN8wRX6VHkEyRZ+kztHmNaOPhpXcCQqoOGCcMiCJJhYJ4AJo9m5dAqRla
 nPxjAA29u8bubGi8nUOf9LFYzxqJKI7R8YriksUheikgfuPCMI4aFr4OsybtaLZa/KSZIY8ul5y
 Xr2oT1D8JVgf59lIXQ0FGvaTgBKxo7nWCiJlqYFLmWic2btCTUmrX2fDw4CuqIBeh9q2HKDhceU
 q3GrgJd4uM+9gAVzHm5H0sN8Zi0Xxe7Slo5oG+8N/nGUFeGmTecHZyf3yvzvzsBukqr47n0/vMk
 he2aHtlGJwHG2t2fa5gDCWAG2MnJNBCzFDItfw4xkYkO/bSMCYdIRZNfw8gpGAW3p7dmt/62+jN
 3/I=
X-Received: by 2002:a05:6820:290e:b0:696:1b18:18f3 with SMTP id
 006d021491bc7-699ab661cb5mr6451699eaf.24.1778379247633; 
 Sat, 09 May 2026 19:14:07 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25dbffdbsm3645643eaf.9.2026.05.09.19.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 19:14:06 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 09 May 2026 20:13:37 -0600
Subject: [PATCH v4 14/32] target/mips: add Octeon ZCBT instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-mips-octeon-missing-insns-v2-v4-14-d669dcd05c2f@gmail.com>
References: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
In-Reply-To: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oo1-xc35.google.com
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

ZCBT has the same user-mode memory effect as ZCB for QEMU's purposes.

Reuse the ZCB translator so both cache-block-zero forms clear the
containing 128-byte line.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split ZCBT out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index d8a1bfce77..56c54e0973 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -51,6 +51,7 @@ SAAD         011100 ..... ..... 00000 00000 011001 @saa
 
 &zcb         base
 ZCB          011100 base:5 00000 00000 11100 011111 &zcb
+ZCBT         011100 base:5 00000 00000 11101 011111 &zcb
 
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 794c8f033b..477f681f9e 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -203,6 +203,11 @@ static bool trans_ZCB(DisasContext *ctx, arg_zcb *a)
     return true;
 }
 
+static bool trans_ZCBT(DisasContext *ctx, arg_zcb *a)
+{
+    return trans_ZCB(ctx, a);
+}
+
 TRANS(SAA,  trans_saa, MO_UL);
 TRANS(SAAD, trans_saa, MO_UQ);
 TRANS(LBX,  trans_lx, MO_SB);

-- 
2.54.0


