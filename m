Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0FDDCD3427
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 20:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMAwj-00053d-Uk; Sun, 10 May 2026 16:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwi-00053C-U2
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:16 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwh-0003zQ-9A
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:16 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-4824b15c19eso939387b6e.2
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778445614; x=1779050414; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aqsuYbowt8xgBXPY0wGXm/Zcrj5Kri8srcZpZj5O34Y=;
 b=mSEAgk5lEKByblnLRlrPxRnMm77WE7aA32ABcRBmEKA8qzhxSesUaVPX7vJtcCtU/f
 cyN/ZPoMnNdwkLGAoHSXh2Lko7nkGT1fvF28kNdXTJV6F+9z5u/BYTRW4XgmxrEP43hJ
 QSq5nGcS6umeUDJQk80AYLmCOkKufWuo2ZKSiN+mXBD3+xStx8WpqzWAgdHnmk6l5a94
 Bm/dbOhhMdQgKugXjcm86XZR6omDGFY/OJog8oykSCublxXf2pwmtPC3IQ5iuAuKQJBb
 Mln8EAYmVWez1POZTul/3u+FijlyOCd4fw2mCZKLURjzMJWOBzZGHGxIx0YiVn6v7xeG
 dXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778445614; x=1779050414;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aqsuYbowt8xgBXPY0wGXm/Zcrj5Kri8srcZpZj5O34Y=;
 b=FLgH2Vn/rIXEUgvBgwKaNiEyLnq63Pb16B+d4miKcuByeQL6Avbwpfe7cuiYT8hdhz
 1IjK8GCjjfpzST/3PZ+VeUdugETIuYNf98PYd/nURiuSoIWkzXpub8+DE4u4f1hsjO9a
 zxQ5sPMcMYCHll3uRetcz850Zpg5UZ36o/XeLZU/ho70GSODTHLLok5m9jcI6xdysNp2
 +GJbDsX6CoN5uXb3SQ2N3EPDRcmR35buYi3TD+Wx53B4TEp5KWGbj0ICuIw6fBbLuKs2
 xe5LRH0HrlTI0pv334G3XxKVbOhr75N7ISn2VyNWBa48a5ZM//Lq6x5Dj/BJspNUdl1F
 BcHg==
X-Gm-Message-State: AOJu0Yw4gV+wBkZThIsy9yT8PT6+YsKI2T+mK6R6+vPgR26aonVvYtM9
 c+xFnB3YfKzomZCg9QtrMMrRwOQWc+cjUyTYp5tcX7YEBeVZWHho/IFl
X-Gm-Gg: Acq92OFyrrrB7EmF2qJkbJN4qUFXiPZl2X9+6RD4Dm9xRMcY8qCWxAhRZwCKNnkGSHs
 0Q2momgLV/MRjQniifc8sbnVq4KbhU8zLkJsELXOgE30StLHnDEqOZoe5iK+V8B5USeBMmnYaHR
 nEmDhwlwM8Nwgu89R/D5uxsJK6g4fxnI6KdFal9HRtmJduatzSXTOavI/vbPbhQJfgVqyNuUfrq
 F9ShP/ya65YHOzEe9zF3XuBFAxbyJ8wxsD2IckGsxl/NnpDJKxsdhTFnc+tagzc2pOS7F4fJ47i
 HVW99pHTPIjPckC+0c7MdKRM4WxB+EHzRifH9mlknvqYs+l8JqB4Cx64+PEL/nffg2Mf78+e7M9
 e+krZKNKLYW/Sc6+E7z8Q0CCbiG4+d8TVzkBfXM4kt09+4WF2e7MtA8iDRADPxsfYYtMjFDDh74
 CujkmJxQAG6vsQDQUvpaRyDcvId3Pp7s1Hx4j485fwfLCaSiF/sQXYjuM9r4yzxcD24KYYeQIiE
 XXuSSMLUlfYveZi/b8v+9dIlp3cDtjUEDgJ3WXOKRg=
X-Received: by 2002:a05:6808:171a:b0:479:d6cf:ca8f with SMTP id
 5614622812f47-4824ab06984mr3922191b6e.39.1778445614096; 
 Sun, 10 May 2026 13:40:14 -0700 (PDT)
Received: from MacBook-Pro.local ([209.245.15.183])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76935637sm18908207b6e.12.2026.05.10.13.40.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 13:40:13 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 10 May 2026 14:39:41 -0600
Subject: [PATCH v5 11/32] target/mips: add Octeon SAA instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-mips-octeon-missing-insns-v2-v5-11-d5d2668d15ab@gmail.com>
References: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
In-Reply-To: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x235.google.com
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

SAA atomically adds rt to the naturally aligned 32-bit word at base and
discards the old memory value.

Implement the common SAA/SAAD translator with TCG atomic_fetch_add_i64.
The MemOp selects the word or doubleword transaction size.  QEMU only has
one Octeon CPU model today, so keep SAA/SAAD under the existing Octeon
instruction feature bucket instead of adding a finer-grained Octeon+
feature bit.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split SAA out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Gate SAA/SAAD behind an Octeon+ feature bit.  (reported by Richard
    Henderson)
  - Use the i64 TCG atomic add path for both word and doubleword sizes.
    (suggested by Richard Henderson)

Changes v4 -> v5:
  - Drop the separate Octeon+ feature bit; QEMU only has one Octeon CPU
    model today.  (comment by Richard Henderson)
---
 target/mips/tcg/octeon.decode      |  4 ++++
 target/mips/tcg/octeon_translate.c | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index db7d5f55f0..d6b241de42 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -44,6 +44,10 @@ SNE          011100 ..... ..... ..... 00000 101011 @r3
 SEQI         011100 rs:5 rt:5 imm:s10 101110 &cmpi
 SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 
+&saa         base rt
+@saa         ...... base:5 rt:5 ................ &saa
+SAA          011100 ..... ..... 00000 00000 011000 @saa
+
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
 LWX          011111 ..... ..... ..... 00000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index c93eff59a5..f5f09464ce 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -161,6 +161,20 @@ static bool trans_lx(DisasContext *ctx, arg_lx *a, MemOp mop)
     return true;
 }
 
+static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 value = tcg_temp_new_i64();
+    TCGv_i64 old = tcg_temp_new_i64();
+    MemOp amo = mo_endian(ctx) | mop | MO_ALIGN;
+
+    gen_base_offset_addr(ctx, addr, a->base, 0);
+    gen_load_gpr(value, a->rt);
+    tcg_gen_atomic_fetch_add_i64(old, addr, value, ctx->mem_idx, amo);
+    return true;
+}
+
+TRANS(SAA,  trans_saa, MO_UL);
 TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);

-- 
2.54.0


