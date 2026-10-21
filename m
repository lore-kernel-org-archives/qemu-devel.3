Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60F9606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=IqiLz0od
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXEe-00036m-Rj; Wed, 21 Oct 2026 10:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDS-0001eW-L9
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:56 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDO-0002BB-8h
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:54 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48e1d0e5dafso1310162f8f.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592567; x=1793197367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N/IrgyDzZUsGQ+T7LwWrXV4GsgjIAaDexV4iJGkOg2s=;
 b=IqiLz0odFUDPHrsXQB8n/XBX7xfEPlQKzghaOAP/NoOYb2IQVtBadisdJSd8CEkp6C
 4NopDBZd4OZfBoUcrFPOVWyOGzjz6khL40bORpSi1KwZ9LRwxwjI9ytvQs2xaXd9X4bq
 jjfGm6zsxNB3EAnw9kaHK6lm9izMNVhCpet8Ni0h3864gpqJKd98xus/ccyMKLaATi5p
 07rj6aPCcWi0guLeynxQ6lFV89wIQTW4aaz7uHrfd3uz2HUSSeAXBwJFKKSwHs/8WOMo
 UH7KUCIYwxh94MpKMTtw4OOZUXndDrY2gruSp5m0xJbMsuNE23k51T/mCiaUEXVgeOP5
 3S3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592567; x=1793197367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=N/IrgyDzZUsGQ+T7LwWrXV4GsgjIAaDexV4iJGkOg2s=;
 b=KZNfvfVEMd6AD9bFmD0gut3VnNomVjz8AYXoHS9F/LGGaLoXs1coFaP3hQCzaz4reN
 RV4LMVOpCnJmmW882Pp1sx+GEoDJTO604Qmc8D/olkA7zM5I2d35Iak3NrfzI8Fu7Jgq
 k0t9TSPQqwTyXr3fun5UVCsJJrbtmKZmGntPP5o8MVWQ2VcpYWy+201t9Y7s/CsC/3f4
 23aDO5EsgB2lrBaMxDoRd6IZ0BaYeZMVEY4lWzy9YUaanfT5egyZBF495wloDvHR41W4
 QaRRTfeq9kItYXQdhSm1JG4+BL9BJBj+nfRfB6PjITcRp911NqBcBS0aB3f6eAdiud7c
 52iw==
X-Gm-Message-State: AFq9FYKQp5hGjI2ES5eJEyRUfFbbsbVpVqD/7qdRE5fA5mfI7xhBpNJ/
 GSoj9ean+MapyAjrH7o1Mash84vsmzRUDzJ3eo3C6m3ce/XOGDY36Ips/0rx5usXkzvjH/hHgcy
 fzE85clg=
X-Gm-Gg: AYBFou1yjcwnb23+7rK6afTuFOSniOdhHfRSB2okTPEC4cuea1HVUZWVRTCGKM8FRs2
 CAToywNdv3sUHzxBmYFNe6Uy6BkhgogCj7PZOCyOsLjc7th3aVX1cc4pPPZQ/qS5Jf5c3y5Igym
 mSYHVf9j48UiOkFIKjEx8+Q51UservZrHa6y4lBchvJY2Apw1XVb2JudqxgTZwYa/1/zh2TpHr+
 h+yg4cDZl06o2d7q2FQw2BguXKnCRQU//ooV9CeT8vCUiU9tIPl2NBz5vwO4X1n4ux9SoNjVLW1
 uutHvtK3sCYE5Ufv4Pn9DB7okJ8NawKsYIfI+1tBK7C81LL2AHl6ZIzRysNSExFE4CDezEZiDJW
 Ye/kKWkQLldafReSM1pNl87GeWArrYFebmQKucaYmr8Gc0M31tYdM7qDGWxr8wMgNwh9+v6VGDb
 mfv9LOTSes8K0hqbljMCyGzKGewVGU6uUsyZwqSbD2ppdE85+nCulsX0u4tVenCRkMhMoqUwEy8
 muHrgYy+p769DuAfP2ddx4ZMea9daUuVC0ewmDGmvEB60Y3Nvy02iuCbJbY8gi2VJPWJs/Fbdjm
 C7Ud9m8lP0Lhmp5BA/I7vt/LaUs=
X-Received: by 2002:a05:6000:27c9:10b0:48d:f852:c66b with SMTP id
 ffacd0b85a97d-48e1e7e065emr9838785f8f.22.1792592567227; 
 Wed, 21 Oct 2026 07:22:47 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 068/100] tcg: Generic expansion of tcg_gen_ext16u_*
Date: Wed, 21 Oct 2026 16:16:20 +0200
Message-ID: <20261021141652.363109-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x430.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index cbeae67794..3af56710cb 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -143,7 +143,6 @@ void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -185,7 +184,6 @@ void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_ext16u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext_i64(TCGv_i64 ret, TCGv_i64 val, MemOp opc);
 void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 4c1fc9633c..6208a51f53 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -22,6 +22,7 @@ DEF3(divu, TCGV, TCGV, TCGV)
 DEF2(ext8s, TCGV, TCGV)
 DEF2(ext8u, TCGV, TCGV)
 DEF2(ext16s, TCGV, TCGV)
+DEF2(ext16u, TCGV, TCGV)
 DEF4(extract, TCGV, TCGV, unsigned, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 55bd8ccf8f..3c34f503e7 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -614,6 +614,11 @@ void tcg_gen_ext16s(TCGType type, TCGTemp *dst, TCGTemp *src)
     tcg_gen_sextract(type, dst, src, 0, 16);
 }
 
+void tcg_gen_ext16u(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    tcg_gen_extract(type, dst, src, 0, 16);
+}
+
 void tcg_gen_extract(TCGType type, TCGTemp *dst, TCGTemp *src,
                      unsigned int ofs, unsigned int len)
 {
@@ -1179,11 +1184,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
     tcg_temp_free_i64(t1);
 }
 
-void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    tcg_gen_extract_i32(ret, arg, 0, 16);
-}
-
 /*
  * Internal helper for bit and byte reversal.
  * Given a repeating matched block of 1's and 0's, swap the bits within
@@ -1475,11 +1475,6 @@ void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg)
     tcg_gen_sextract_i64(ret, arg, 0, 32);
 }
 
-void tcg_gen_ext16u_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    tcg_gen_extract_i64(ret, arg, 0, 16);
-}
-
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_extract_i64(ret, arg, 0, 32);
-- 
2.53.0


