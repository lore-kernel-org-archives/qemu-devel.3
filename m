Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EB3CD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:39:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNa1s-0001Iw-JX; Thu, 14 May 2026 13:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa0y-0000qP-3r
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:29 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa0q-00042B-RB
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:25 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7e4004a4a6fso633177a34.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778780293; x=1779385093; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l+nqzgqvyBv9EPNxEuvCnIGDCz4QCO1jqQ+B1OX+JI0=;
 b=r+Lfxkvk4MUYALoH1/X9GmrQ9RyAMGfQJsqCpCLTqisU/9DIncjy3UkRsDEd7ajyNG
 xB6byOdCGWzS0y0M1m8r/YXB3kOGj+O5BKj1xEz6xlUKcE9Y2y2X3toCOXfJhAgwA2zU
 oC6yP2gzh2gmnFofp/vEo5dzn9ZDQO7HdSxAy5MZYsqWOgwfH5citWeeX0Kj5fI+8x2q
 ZzvPTnbTyZK4rgJcyOPM7MNekEBVPSxo5B3+nBpEDo/f2Z8AImb11oG7zQrclMNE3kYi
 kW+/tlTBtisbJGy8b8fC7h/dvHK7zw2betyu2zHAAzmgvsADV8H0RenEpTgdEF759pka
 78Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778780293; x=1779385093;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=l+nqzgqvyBv9EPNxEuvCnIGDCz4QCO1jqQ+B1OX+JI0=;
 b=mOjR/+ajRrQNLOjhKkY2h5m7ODnXmElDewMDGEE4E/Cesg+8isnZ2iSFJ+9wut//5z
 gb7oKeECgokM//VfmLQnlEcmoQ5DX6R0FXmVEdYd7+eCcLX1t5gYwXJlOs0gh5IcVqFP
 dKcVgzPo77bqpZS/gSfPIcJX3jARdwpypAqdl6IAESruIPcWJwBMpHa1uXcXfUICct1V
 1qTqVmYuI4xv4UYXT4diKGpjOBj1RBeo3241JPiwv/Ub1WD2CMVS7OMu3BAaDfx5OQ0F
 WGM7chnUmBTy+fqGc+HYLOaVncnR/yurIapupxaSgcCf0L5Gx3zy1mTRnTYZIW399S5V
 8Fuw==
X-Gm-Message-State: AOJu0YzExA0CmWpai8wQ3XhshZw8Z/c5LHSfm7xLUaAgrv9Kfs/aT/Kx
 UsJIEzpBsTOictBeieCiEzR+9W7J+PPyJ5XwXp9w3IFCtYg40Idazmxs
X-Gm-Gg: Acq92OEl7dLoo/scNkxTjSYb755nefrk4mBKem8dybhgConVCJ0ZsnC5D72z/RFFrN8
 SbVMMDkNKWWQp7Gko1JsxtO2KbYa8bbu8DWUBtAkIQ9lmjBYSG8Bqu/Ho/kznvwN/xGCnApEkO1
 G+l9mJzvEsulkirV23Sb9BXTV3DW9Ipwgv8/x/r7nPIVVnmiV0J1Op9Q5QJwFjoRk+Fh1TRZyoB
 3IkFpMzrSQx08TXr3RKcvgGBwphhwWRCSIv9IgzIK3NImpg1E8A3vG64TZuDotEDbHzvpW8qLLJ
 4LpMFqUKUlrHJ0W3nKfXxkJGETqi/3RE5G/DUnw/SX7d1zuB2HRPH4b9w8RBU/m4G1O0HbvsDJ4
 WJASpKjUWIiKDUFuUNJxLeaAagnMNtPp/1JvEe+mnK90VcpDgGAwaIZVSGyoc4SdKJWcjY2Ks9l
 ggHBSHSTY4Q7kgxHCc0JzZbBBDeILdHS/EU4hYU7NyM5oEcbe+vCst2EEzDJh0YjgeCd/NIrlWO
 r4vNMAuzTYzqJVmzbdo/ZXXhUw8ZWk3gg1R8tP5H63yqLg9NvKHVrAyIcYOtiSjLwe+
X-Received: by 2002:a05:6820:f034:b0:69b:3788:e5cf with SMTP id
 006d021491bc7-69c94290de3mr305400eaf.7.1778780293238; 
 Thu, 14 May 2026 10:38:13 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b8ccdc74esm1687254eaf.13.2026.05.14.10.38.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:38:12 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 14 May 2026 11:37:09 -0600
Subject: [PATCH v7 20/35] target/mips: add Octeon MTM2 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-mips-octeon-missing-insns-v2-v7-20-226686be4ce1@gmail.com>
References: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
In-Reply-To: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32d.google.com
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

MTM2 loads the high Octeon3 multiplier operand pair from rs/rt into
MPL[2] and MPL[5].

This supplies the final operand pair consumed by the V3MULU multiplier
helper.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split MTM2 out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Describe the Octeon3 rs/rt MPL[2]/MPL[5] pair handled by the shared
    MTM translator.
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index e6b06ac4b6..2279bf3eb5 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -49,6 +49,7 @@ MTP0         011100 rs:5 rt:5 00000 00000 001001 &r2
 MTP1         011100 rs:5 rt:5 00000 00000 001010 &r2
 MTP2         011100 rs:5 rt:5 00000 00000 001011 &r2
 MTM1         011100 rs:5 rt:5 00000 00000 001100 &r2
+MTM2         011100 rs:5 rt:5 00000 00000 001101 &r2
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 623fb093cf..365079cfb9 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -296,6 +296,7 @@ TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);
 TRANS(MTM0, trans_mtm, 0);
 TRANS(MTM1, trans_mtm, 1);
+TRANS(MTM2, trans_mtm, 2);
 TRANS(MTP0, trans_mtp, 0);
 TRANS(MTP1, trans_mtp, 1);
 TRANS(MTP2, trans_mtp, 2);

-- 
2.54.0


