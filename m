Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85AE6CD5BAC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYgi-0001Bt-P7; Wed, 20 May 2026 00:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgh-0001BT-CH
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:43 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYge-0003pF-Ct
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:42 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7de46b8e432so4485270a34.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251858; x=1779856658; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ktb//rSE3qSFthp8j7pO++7/bpM7M1LzWp5p9Hu2g0E=;
 b=qdOzy1giV44uzRnHwrtNCYdYXHPeVXXV3SKci0kbfi/YktlJ5jHdygkEDRN/495FWx
 kcWJ4ifNuptBQx5MwDpqJ0PHlyC2iINFTCjQsMPcWaZxi9Lr1JwPmYUSpxWmCMqzlhz5
 EQ8hoKss9zlPItDgL+7OOYDfVoGj6piLMl05KvuVdv5/ehxZgCJO6Rkd5F3ZZROiNoSj
 MM0qSECQ+nsvO5uYkH2N7KWQREJI2prWcjDOgYEryMuWZqlhKMMj1u6kdJcidBu/H+fo
 Z0xBLQ+oGG4mCka7qM1drahC5nRTLAixA3oGkBJtdDjzwnCa9TcWt85mpOnTs1GPVfyj
 Lp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251858; x=1779856658;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ktb//rSE3qSFthp8j7pO++7/bpM7M1LzWp5p9Hu2g0E=;
 b=OAjlxHfNyAvOHQ0pH1chYbnLQhhBlANXZvHVJcZ7CcW9zIS9wLM36of56eEQIswm+H
 dvYvx0YVlU56ENwzXrGCiDOj+hVny/iHgUrP08BshMidV1z1ytv5irjeHLFa76bIcgND
 wuYvViIkfS0YoGRDL+vCzIcctupqOutexReshEWVOCidMzWNf6C+DouexFyk61eyr/ke
 IoDfpTYCHYLA1n6/f/ruyzWtuReFXnQyC6wa8lPYBkYA74w7gRLGTGobvbEU3810Vq/F
 xn2Wxa/ze0+YZsN1yBnsqRehQMjY/fzBOgzgsf7Vw87aVT0okyUPE/1v15A20z0aB5p3
 nGkw==
X-Gm-Message-State: AOJu0YxGWGISYAGLcTiXBERd8tG9IwmJsG+YB0dT5tkaXOEkqphDlJ/m
 cQYTCrKZ6WeSgTDemaSNuaGWuC4urO5bn/no6x8gtQHvhvOo7nEr06Ez
X-Gm-Gg: Acq92OFvveHWnXcy4fkn0TQA5l0z15/s6PQHlHdOEYvL9RS7wItp4UK65Sx4EftuLXH
 9ou8e1RcIHgD15qs2yviRzj0uSuxy92Eiulc66fOjIO0AF8Uv5NttJ3l/Vy4WSTYO/URMZeq9/U
 oSPwdhfGNqAqoJe4gi9RWUHOdxn/8cRou2ebJ3s/VSVqO8SSj4Ymhio/6kxcrNA+Qc0yiwDmRJr
 lARSq5moZTch73ASsyBwYFOAApGhUh7BKYrQOljg/xRTXPBOorHX0oxjuKiS4UQ3OZ533CnacsG
 356H0sMCxXu5eUTVw7/u5RyUBYr2uaImTwA7DNwW4KIz+R3y+FSVlrmrY1PAbjk+zg8ik2Ngy19
 BtJt04D0q/+r26KvErazUyP0aHyWw9nHTCC0X8zQXFzSWVZrBcTpORH5ClPONN+5Uk548LOOuCL
 dMMC6QGfZfSKFzYIYtrMViMeckkCARffsFNk/7vRhrFgCNusPI9zERXzQStBBiTxhdoOFk7kUR8
 jGRvZuyiR8PzXyAjkwJEwezYZrQB1G1tYE4pdzlfWEe/klB5QrZNzsvH1gmbIYvqLsk
X-Received: by 2002:a05:6830:67cf:b0:7dc:c338:d23d with SMTP id
 46e09a7af769-7e4f2b2453dmr16870552a34.14.1779251858185; 
 Tue, 19 May 2026 21:37:38 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:37:37 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 22:37:14 -0600
Subject: [PATCH v10 20/45] target/mips: add Octeon V3MULU instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-20-306f9edfe15b@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x335.google.com
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

V3MULU extends VMULU across the full Octeon3 multiplier state, adding rt
and queued partial products.

Return the low result while shifting the remaining accumulated limbs back
into P[0] through P[5].

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

---
Changes v2 -> v3:
  - Split V3MULU out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Keep the Octeon3 MPL3-MPL5/P3-P5 high lanes used by the two-source
    MTM/MTP forms and Cavium SDK/runtime code.

Changes v7 -> v8:
  - Use Richard Henderson's v7.5 inline TCG translator with
    tcg_gen_addN_i64.
---
 target/mips/tcg/octeon.decode      |  1 +
 target/mips/tcg/octeon_translate.c | 40 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index f9c32e1dee..4d0ad05834 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -57,6 +57,7 @@ MTP2         011100 ..... ..... 00000 00000 001011 @r2
 
 VMULU        011100 ..... ..... ..... 00000 001111 @r3
 VMM0         011100 ..... ..... ..... 00000 010000 @r3
+V3MULU       011100 ..... ..... ..... 00000 010001 @r3
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index e51d3e6cf7..04e51538f9 100644
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
2.54.0


