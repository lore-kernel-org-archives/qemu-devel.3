Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9DACD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVHZ-0004jd-5c; Mon, 11 May 2026 14:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHQ-0004hZ-J9
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:00 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHO-0002fr-Pm
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:00 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7dca4debedaso4600314a34.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778523777; x=1779128577; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=riSBN5i1giMN1aGqVtPhbyNKtygz2qVbg+uw6OxejTo=;
 b=NHwxVvALp9PHp7UEaSmZDh1eRPvTLj5PGPyD6WO7Nv4EXBQR8cD8OdaycRlGRnDuId
 Zrn7CXWmGuFWsNtIEW453Iiwdhi1jY/3krsOHZnMsskTYb/tk+am6xBdy5TZBFMHt5P4
 tI//F/Gqk652KK0q1e/hrwtPTMQ1PgYmKvZSvUl0SKfhz3b/O2hm5CqWuQI2DwPsv5Vu
 PipS41QE4cX91Rlm+c+N3QeP2GiBDxM5l/W3WPLDW4+rAnmuz471FrjIb5+gyq2LpuzX
 Grt7KrRzO0tTrrV5Y43o9oTgKDI3n+3VZQN1VWBZ/m4pTJFr6fTP2+absz5JZ79nhbkR
 J6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523777; x=1779128577;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=riSBN5i1giMN1aGqVtPhbyNKtygz2qVbg+uw6OxejTo=;
 b=NtkOU14VjNEXqUWw0SmVDnz05Nagw7S6tu/eLzsbfWBIX+OtqyMapH9U4WwdONNZKT
 kgVZ5xnRs4jj0+fhh4YpmNcfRNJp+W35Z+GiEJ0RBg72dRAKTkfFaZe3Funkfum/ip2/
 NFr1YucYOIB28FdCno64DTQbIYnouLllXpjM0W/RcUHZgxC5C6wL3+Hm8hmndhhPF+Oo
 EvHoFKGQHlyZVMG06uSfzN3DdYxQxKcwZLPbMD/WjMRUOahKW0GN5A0xYTUimb/dGFD5
 KhDQ8fzhqbf0n1gclfeUXfPh0rE3M6+Mw2dPJlAukK0+yh/yMyb6FAyeO3TgYw4CJQk+
 dj3A==
X-Gm-Message-State: AOJu0YxKc1D1o9491dLWx9Y6AIXgAN8Tjz1xWF7a2rLdFKRk5N+x7Sa6
 joNpihlpVHxuSZR72XX8jhJhSOHAUbkTBHYgcG3OLijg8HDvs8aKZo+P
X-Gm-Gg: Acq92OGcdoD2QxOG7mZE8FtYCyDSwqrlsR49bJyoTDL6h4/4NHtY8NaHsAPT2ZkTJHx
 Ed5qwDrH7kVkmQGMsLzFzO1rC+BnQAOKM//7XVBxbdEaIanmWZtongeD1htZ0bpZv3i60CAhVyQ
 0UrOivXWvQL6BDDrBx8newYnF2sV3rlFCo6Cbug0EE/nPaU2AH4w2ta1lazw96IVQmngO1SxcW9
 r6aGJJd9xLcvi4gWZaBJ2HJj9lE84/a3ZYvPDYkN/rXb1XUjuXINqBa4Dllr+1FA+TOxoDbmnij
 Ev66Yp4dBfchRjguE742Njif3dUAo1uLB1SBKevS1QAZyB28N1aYQTX2vrKIPCry7r+hbGG6wM/
 yjHl8R7y6xYMN0uw311nFeGzl+FwmVqjpZDA00+B+EH1Li2B4b3yp0lOns6ASlWgZaxLO+2doSc
 1e8KFLC6e4n6rTOfJJhlj7i1OKTNsM9t/Bbz/bd4LOvaDj+EN3BcjAJsikiQtiOTIkD/piE/+46
 HSfk4DqYVJLYaqn5YMDx5yrOQiTke/y+ncoP0Ra8t1SkGfXU9+DzvbJIibOj5KeX0nY
X-Received: by 2002:a05:6830:3691:b0:7db:f6a1:3742 with SMTP id
 46e09a7af769-7e3821e4c3cmr6809177a34.28.1778523777089; 
 Mon, 11 May 2026 11:22:57 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d90148sm7504871a34.20.2026.05.11.11.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:22:56 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 11 May 2026 12:22:37 -0600
Subject: [PATCH v6 06/35] target/mips: drop Octeon zero-register fast paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-mips-octeon-missing-insns-v2-v6-6-5062889c4d3c@gmail.com>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x333.google.com
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

EXTS, CINS, and POP route their destination writes through
gen_store_gpr(), which already discards writes to $zero. Remove the
remaining translator fast paths for destination $zero so these Octeon
instructions follow the same shape as BADDU/DMUL and the generic MIPS
translator helpers.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Remove the remaining destination $zero fast paths and let
    gen_store_gpr() discard writes to $zero.  (suggested by Richard
    Henderson)
---
 target/mips/tcg/octeon_translate.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 8e49e16b5a..5497ddfb10 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -74,11 +74,6 @@ static bool trans_EXTS(DisasContext *ctx, arg_EXTS *a)
 {
     TCGv_i64 t0;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     tcg_gen_sextract_i64(t0, t0, a->p, a->lenm1 + 1);
@@ -90,11 +85,6 @@ static bool trans_CINS(DisasContext *ctx, arg_CINS *a)
 {
     TCGv_i64 t0;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     tcg_gen_deposit_z_i64(t0, t0, a->p, a->lenm1 + 1);
@@ -106,11 +96,6 @@ static bool trans_POP(DisasContext *ctx, arg_POP *a)
 {
     TCGv_i64 t0;
 
-    if (a->rd == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     if (!a->dw) {

-- 
2.54.0


