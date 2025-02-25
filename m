Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E34BC021BB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzMK-0008OG-Kk; Tue, 25 Feb 2025 13:08:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJT-0008Vo-7n
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:50 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJG-0002F0-Sk
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:37 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-439350f1a0bso499135e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506731; x=1741111531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5Z8Nzv9ZM0He2i+V6gc5y7de2Dtz4AMqJaa77A8pNZw=;
 b=mRxb0ClJeIDPS3Q0FCjrOrjfn34sf932Sla18HBvg7MpoDgbetzQmlU9QVrsTC6ZTx
 3Vm0GWn+MRX3MZFmiqXZ4Ty6o5+6qREtRWah6Lfsc/2K4g9rf8YJuqy8hgrvoLEXR7aM
 B+2EcybeC4bj56F6VeAM9HmjxBt28uOLXdvjlCbqli5dqGSqqyDwqKN8Twf+p4kXOVmE
 BCEnGSdWBj7FXZZW5rj7eW87/Rj9MqYlEaoXP14UyfOcwrNNMlaAfeCqb943IcUpg01J
 FRg1lxL3lHPxfW1noGC05c4cEA+BKVNwCJ1SA0TdIItDcPsd9KwAU6taRE0v68zTnH33
 OdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506731; x=1741111531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Z8Nzv9ZM0He2i+V6gc5y7de2Dtz4AMqJaa77A8pNZw=;
 b=acPaqr7hA6bHMSAhCS1lHF93/AeTkLNadYmqSBzt9yVHWenUuklbTy4vdMXE0KnCeN
 fh7wopiYIneQnz69HPpgscGmC/RJOzfsM0s9Sv02RN0hgqQb5S+AWBnISXADmLZKXi+G
 Yov0Ej4HYsJo+zHRA7JoGnrPrBKXep4FtxcuzOnleGk1/TCl4gsgnh7vtRouI2lsvLco
 4zGzScqvMbt1vZsKh1wYge1MWMa+5lTQWEEiY4V6pTr6rGvKmgXoFbgHI21CN+u7+ivn
 GgugX0NHeac7ubilqGr9nSNhtHkyG9UsDDlMXqvZV8SVWgOw5R3xdQ58AJpakFkDxMXb
 hIjQ==
X-Gm-Message-State: AOJu0Yxq7pOdcGdUnqrSawAn6lERDggqmuiogw2YDzLtyLP1Ciz83bdx
 wj+Un7cII//8Ve82O0DDsYIiPRyNZhZY2yMYd5u3EhxNK1Uc1CGi1KK+763EZwizOD8p7BJntEY
 6
X-Gm-Gg: ASbGncvS3lJ6DXnBvDPncBnuvt4nYiEA0bJJ8tX3zINY/IZFBgIvumHig+vdtdhIWOZ
 Tro5zaPD7xv60O9P40OpOozVN+s89GdeGezQn4gjcxc+vRjCglR0MZfwd9lhJ+Iz1eSxqP3Iwth
 8o7a6nFW2ngpcqrgXUka1eqHV4zZBxM33+OzK0nws9ZRdeq3Z3Gy18QYTjaegX1SmCXEz14FDsX
 mTmUm8x27ntshqAzvtXanHV4gNCEk6s5EuI2PnXvlcPI7C5ZaL7vB/HmeFm3me+VKUQhUDZClVg
 JYITTGyuBJ+sidPNVHj8rljLk2SnlQfK
X-Google-Smtp-Source: AGHT+IFarU4xe/fPjEp2/y3mgdv2khzvrx2aofpm9oCz39l3GgpXbOMvfOeeEl9mkS3gxO2oV4indQ==
X-Received: by 2002:a05:600c:4f8b:b0:439:86c4:a8d7 with SMTP id
 5b1f17b1804b1-439ae2e1d60mr130864265e9.5.1740506731494; 
 Tue, 25 Feb 2025 10:05:31 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/43] fpu: Move m68k_denormal fmt flag into floatx80_behaviour
Date: Tue, 25 Feb 2025 18:04:42 +0000
Message-ID: <20250225180510.1318207-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently we compile-time set an 'm68k_denormal' flag in the FloatFmt
for floatx80 for m68k.  This controls our handling of what the Intel
documentation calls a "pseudo-denormal": a value where the exponent
field is zero and the explicit integer bit is set.

For x86, the x87 FPU is supposed to accept a pseudo-denormal as
input, but never generate one on output.  For m68k, these values are
permitted on input and may be produced on output.

Replace the flag in the FloatFmt with a flag indicating whether the
float format has an explicit bit (which will be true for floatx80 for
all targets, and false for every other float type).  Then we can gate
the handling of these pseudo-denormals on the setting of a
floatx80_behaviour flag.

As far as I can see from the code we don't actually handle the
x86-mandated "accept on input but don't generate" behaviour, because
the handling in partsN(canonicalize) looked at fmt->m68k_denormal.
So I have added TODO comments to that effect.

This commit doesn't change any behaviour for any target.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250224111524.1101196-9-peter.maydell@linaro.org
Message-id: 20250217125055.160887-7-peter.maydell@linaro.org
---
 include/fpu/softfloat-types.h | 19 +++++++++++++++++++
 fpu/softfloat.c               |  9 ++++-----
 target/m68k/cpu.c             |  3 ++-
 fpu/softfloat-parts.c.inc     | 27 ++++++++++++++++++++++++---
 4 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index b1941384aef..1af2a0cb14b 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -349,6 +349,25 @@ typedef enum __attribute__((__packed__)) {
      * and using them as inputs to a float op will raise Invalid.
      */
     floatx80_unnormal_valid = 8,
+
+    /*
+     * If the exponent is 0 and the Integer bit is set, Intel call
+     * this a "pseudo-denormal"; x86 supports that only on input
+     * (treating them as denormals by ignoring the Integer bit).
+     * For m68k, the integer bit is considered validly part of the
+     * input value when the exponent is 0, and may be 0 or 1,
+     * giving extra range. They may also be generated as outputs.
+     * (The m68k manual actually calls these values part of the
+     * normalized number range, not the denormalized number range.)
+     *
+     * By default you get the Intel behaviour where the Integer
+     * bit is ignored; if this is set then the Integer bit value
+     * is honoured, m68k-style.
+     *
+     * Either way, floatx80_invalid_encoding() will always accept
+     * pseudo-denormals.
+     */
+    floatx80_pseudo_denormal_valid = 16,
 } FloatX80Behaviour;
 
 /*
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 2a20ae871eb..b299cfaf860 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -537,7 +537,8 @@ typedef struct {
  *   round_mask: bits below lsb which must be rounded
  * The following optional modifiers are available:
  *   arm_althp: handle ARM Alternative Half Precision
- *   m68k_denormal: explicit integer bit for extended precision may be 1
+ *   has_explicit_bit: has an explicit integer bit; this affects whether
+ *   the float_status floatx80_behaviour handling applies
  */
 typedef struct {
     int exp_size;
@@ -547,7 +548,7 @@ typedef struct {
     int frac_size;
     int frac_shift;
     bool arm_althp;
-    bool m68k_denormal;
+    bool has_explicit_bit;
     uint64_t round_mask;
 } FloatFmt;
 
@@ -600,9 +601,7 @@ static const FloatFmt floatx80_params[3] = {
     [floatx80_precision_d] = { FLOATX80_PARAMS(52) },
     [floatx80_precision_x] = {
         FLOATX80_PARAMS(64),
-#ifdef TARGET_M68K
-        .m68k_denormal = true,
-#endif
+        .has_explicit_bit = true,
     },
 };
 
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 505fa97a53f..2617d8f6ede 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -139,7 +139,8 @@ static void m68k_cpu_reset_hold(Object *obj, ResetType type)
     set_floatx80_behaviour(floatx80_default_inf_int_bit_is_zero |
                            floatx80_pseudo_inf_valid |
                            floatx80_pseudo_nan_valid |
-                           floatx80_unnormal_valid,
+                           floatx80_unnormal_valid |
+                           floatx80_pseudo_denormal_valid,
                            &env->fp_status);
 
     nan = floatx80_default_nan(&env->fp_status);
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 1d09f066c5d..171bfd06e3a 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -195,6 +195,25 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
 static void partsN(canonicalize)(FloatPartsN *p, float_status *status,
                                  const FloatFmt *fmt)
 {
+    /*
+     * It's target-dependent how to handle the case of exponent 0
+     * and Integer bit set. Intel calls these "pseudodenormals",
+     * and treats them as if the integer bit was 0, and never
+     * produces them on output. This is the default behaviour for QEMU.
+     * For m68k, the integer bit is considered validly part of the
+     * input value when the exponent is 0, and may be 0 or 1,
+     * giving extra range. They may also be generated as outputs.
+     * (The m68k manual actually calls these values part of the
+     * normalized number range, not the denormalized number range,
+     * but that distinction is not important for us, because
+     * m68k doesn't care about the input_denormal_used status flag.)
+     * floatx80_pseudo_denormal_valid selects the m68k behaviour,
+     * which changes both how we canonicalize such a value and
+     * how we uncanonicalize results.
+     */
+    bool has_pseudo_denormals = fmt->has_explicit_bit &&
+        (status->floatx80_behaviour & floatx80_pseudo_denormal_valid);
+
     if (unlikely(p->exp == 0)) {
         if (likely(frac_eqz(p))) {
             p->cls = float_class_zero;
@@ -206,7 +225,7 @@ static void partsN(canonicalize)(FloatPartsN *p, float_status *status,
             int shift = frac_normalize(p);
             p->cls = float_class_denormal;
             p->exp = fmt->frac_shift - fmt->exp_bias
-                   - shift + !fmt->m68k_denormal;
+                   - shift + !has_pseudo_denormals;
         }
     } else if (likely(p->exp < fmt->exp_max) || fmt->arm_althp) {
         p->cls = float_class_normal;
@@ -342,13 +361,15 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
         frac_clear(p);
     } else {
         bool is_tiny = s->tininess_before_rounding || exp < 0;
+        bool has_pseudo_denormals = fmt->has_explicit_bit &&
+            (s->floatx80_behaviour & floatx80_pseudo_denormal_valid);
 
         if (!is_tiny) {
             FloatPartsN discard;
             is_tiny = !frac_addi(&discard, p, inc);
         }
 
-        frac_shrjam(p, !fmt->m68k_denormal - exp);
+        frac_shrjam(p, !has_pseudo_denormals - exp);
 
         if (p->frac_lo & round_mask) {
             /* Need to recompute round-to-even/round-to-odd. */
@@ -379,7 +400,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
             p->frac_lo &= ~round_mask;
         }
 
-        exp = (p->frac_hi & DECOMPOSED_IMPLICIT_BIT) && !fmt->m68k_denormal;
+        exp = (p->frac_hi & DECOMPOSED_IMPLICIT_BIT) && !has_pseudo_denormals;
         frac_shr(p, frac_shift);
 
         if (is_tiny) {
-- 
2.43.0


