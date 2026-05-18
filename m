Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F49CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 05:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOqYY-0007CH-Nq; Mon, 18 May 2026 01:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqY8-0006vM-RU
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:30:06 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqY2-0003VG-Da
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:29:53 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-479ef2b78f3so1866956b6e.2
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 22:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779082183; x=1779686983; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2hAP2bga8LzYrDCBtvN1aj2xH/chyc3MGESqvnHhxlw=;
 b=eDQ07HAGagH8/PEt9lP5pDLJKS1DLioUCaOyycp1FT4Z0t/EUSQwsdaVcCrXSQq26H
 nYJC/Tuo8UZp6sTrggkGmMwWgwcUtZDqtNkS6obMTXg+yynogCC2zx11W/nf2/3om3qw
 N6m8QExYmBtmgp/+eDAbI5vIoyjhpm/dPi7Fqj6zt5mUTJZDTxb9LbmE4nkW4hfQWevj
 7HeboJf8rjV+ype2ea6QvyE2F5ZYb5RSahqqdqrJCikr6fOR1WlTX4DXeu4Eu+AYDpj3
 +W0vR5ppOH7c3Fg2XMNmYrppW2GZ4PatOY/p4MmlY0iq9W7gkeGg1vmGmkNAs9CmaLLW
 GU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779082183; x=1779686983;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2hAP2bga8LzYrDCBtvN1aj2xH/chyc3MGESqvnHhxlw=;
 b=prdsWwyVhQMcqmzUrZnH2GXm7Rp1teMHxnlnbwHGPz6GLCEjxvfM3AkKz97QvneIyd
 Ehy1Oileua8kb7oNdCt5V6PMUolryF7eAuRUqV2EIq29gxAtUSsoesYikbl+oUd/hXpN
 3SXJ/NRd/UAljkA5VxzNVn7x0ZLKdGf6EEP3dsOOkVJiqRaZPeVQrYW4dNaA4j4RLpTO
 2gvJBTR2bssRTIKJlN+LxvvyASF7atevvExxWjqa3zKhNJxi6OyRdI6FkjlolryRPAGH
 t55jVprDvrgadDSvuKkOWqPAhFdZ77rrAo2TIOGYq8Pbj4fi8VQ03du2TtHqFFIwdzYA
 vUWg==
X-Gm-Message-State: AOJu0Yzqm5cQuzFBjJIECyfGu5uUjHiH2RpI7/n/ExJPVrAs8xHUp4/Z
 qEvOnkStHdyRsnActhZZh1UvBD5irs6YflEB67ZQDQghJdobXy0/Pkw+
X-Gm-Gg: Acq92OGR15MNfn4WGVzeq3b11c3+Wri3DGLy7XgEb7BNkEJ2ESqiL2hPEPvcgqT5npp
 W7IKxQ4x9LowLtCwJj7jG9ruwN5a74pyNz4xsoH19QcyqyOtCvqvYguWd1oYyUrz3onjvdbH4ZM
 7NHKBDgRP6b8oFPIWQV2oyR0ZdqE6oS6f+sHbY1HmNfpQrd/gdfL63sFkO4jm4SlFJ0k3NGpZVO
 +Dyq/L836vytjCNGVFVdK3dGTBCK2ls6FIu82tLOVT8tktFWCPb5+A1GtFLko7110/y0WmEj/uk
 8Y2EYAm5usYO/bUV5auuKKJNZjHHyLysoK2Bf/EwQpgEQSGzfpZhrd59IMvY71RfQ7xMcz/S98N
 TqrNcgSQC7gc17Vxog86KBXUAQ5VX3LWh6UmQwu27M9Brw7QG+4/XbnQVPPtfrklzXzuTdlNxwy
 ViN4IJF7rJo+DVgs2P3gKnu7K6xxfD7XZduz+iAEQI7shus5HwEwr76Ak9hP+lGqECJhzZubHxs
 W43Px3Pu5GeObnbQcxtpgXYHYXgXiXYpRtwPsCcWu9G7d4M8ji2duyVqutv7Od4llw+Uih2Z9+r
 fT2u/Q==
X-Received: by 2002:a05:6808:c16c:b0:47a:4fd:95de with SMTP id
 5614622812f47-482e57bbebcmr9970275b6e.44.1779082183602; 
 Sun, 17 May 2026 22:29:43 -0700 (PDT)
Received: from mac.localdomain (71-218-255-245.hlrn.qwest.net.
 [71.218.255.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-482ee5349a5sm4628357b6e.15.2026.05.17.22.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 22:29:43 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 17 May 2026 23:29:17 -0600
Subject: [PATCH v8 20/35] target/mips: add Octeon V3MULU instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-mips-octeon-missing-insns-v2-v8-20-206151ee77ec@gmail.com>
References: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
In-Reply-To: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
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
index 9e3dc24455..30d6f14ee1 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -318,3 +318,43 @@ static bool trans_VMM0(DisasContext *ctx, arg_VMM0 *a)
     }
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


