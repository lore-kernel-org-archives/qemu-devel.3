Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E20CD4F3D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 01:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOmSi-0003mj-QI; Sun, 17 May 2026 21:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOmSP-0003XM-Ui
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:07:52 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOmSN-0007Le-Pz
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:07:45 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3699cdeec05so346194a91.3
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 18:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779066462; x=1779671262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cRap4hHLoftxvk5QRReZviSArK14cDpP3WccMVXPqXA=;
 b=Eb8nq0ME0grx2S14Dxo1fXprCM6mwoOJH8uuHPyfQ84o9FnHRqgpq1+r5cRWSKdaNH
 /ELvIzPWUoHNO3cPY/w24Ft4kD+AuYrzJ3MBCnfBRJ+4NLSYkjd9/ns7SHP9sRCcpoKo
 eUgoahkrr1BKAL0nuGZrCH4jPgkvV/1U1gh2ryg6ei/7BrUOh+2WnguXgiNHHYmEZIww
 p9NQIdoNE/fEGkP7Azd3pl94KmrITVRlTHTBJ3XR7vD+/xxlA5vsQljvUPheya2rJVfs
 VBj3A4N4vmGyr+P/3SkjXOtZEWjhPTefoXAbwYWuYC7k3YeJ5W69DAIjl/xabGqqhPFL
 nBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779066462; x=1779671262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cRap4hHLoftxvk5QRReZviSArK14cDpP3WccMVXPqXA=;
 b=itVxSxjBzZCoWjuFJYcoWh1pDM0gr6PxAIb3kz57RgoGXM3V7Dn9DnWvS3EHUYuVJ9
 cGOUHQlv/pCDEe833CadzqePLmMPSMg1J6uzRHQHUHxeAnjGNmTfvd3OL9KjhmnCeJWh
 jMuXpYTzdjzbltTIxX4BILaYron7q8hl0YdiHD0QaDpUc9Z3UGyG2+H+ysa5f4AOjWxj
 wxb6dxsBQioNtSonWnaxfICMMOu9+PfGR0bywdVkxIRYJICqQcj35IMgbyTKQvxjgzAQ
 Zi7WKQ2Addukb7qT2JzuC+nzpnhYEmup+Bhx93jlmIt7KzFI7MbwnbQ44Q7BQ2p/e010
 Tdbg==
X-Gm-Message-State: AOJu0Yw80J4oKozfe7IGcn8kjBDeGpRzhHVK77WMNaMp1GYOCWxS+qkr
 GpWWSV8ddOvX4XPdETfTUHazSloSqs1WB1iF5AJHsLQduybA7dzuXK47rV6dh5lVHFfe+B/a908
 lRb0k
X-Gm-Gg: Acq92OGkR9LK9VvaSRTVHvZSwQlWZ0MJ6WwygHjiRjZ9uN+ZsCpZ1Lk65fJi6doreza
 iQngdxeev/Tt9jZDCLO2UuOcM5lwYWTvtUg2zHhDUA+leNEebiFB4qpEiDjCzY4WtpgI/GXy0sJ
 O4ocfXPJBL0HLY8YCGKxA7twVWSJbAEMm1JFa64SkXWEFvrVQTPsPY1HqpUT2BCL6hUKWGV1lpM
 p6vTQNUIySxZ/UpyGh5XqJqkqNXHjgJrERGM6Rnd9TfNjMmDBPAaPq1zwf/QgILFZdAMkeE5NGf
 uMTQihA5/zaAXO6GiXrnTQKsh6zBc61+D4fElujtfo+CEx1+m5rZaxGogAau/5oKfM57cWWGn0J
 9GFKqAiNP6eO4+OM48V83VGd4Knna0o157aptcKeFoFRsZFoskQ1e2UTwFv6mmJweBa10i0z2x1
 /6yKdU1uhTW5dKA6+bfRtjx2e+x8cW
X-Received: by 2002:a17:90a:d648:b0:368:95e1:8d45 with SMTP id
 98e67ed59e1d1-36951cb7706mr11998080a91.26.1779066462066; 
 Sun, 17 May 2026 18:07:42 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36951584654sm9160939a91.7.2026.05.17.18.07.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 18:07:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: james.hilliard1@gmail.com,
	philmd@linaro.org
Subject: [PATCH v7.5 9/9] target/mips: add Octeon QMAC instructions
Date: Sun, 17 May 2026 18:07:33 -0700
Message-ID: <20260518010733.502237-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518010733.502237-1-richard.henderson@linaro.org>
References: <20260518010733.502237-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

QMAC.0x and QMACS.0x multiply the selected signed Q15 halfword lane
from rs by rt<15:0> and accumulate the Q31 product into the Octeon
HI/LO accumulator state.

QMAC updates the full 64-bit HI/LO accumulator. QMACS saturates the
32-bit Q31 result in LO and keeps HI<0> as the sticky saturation flag.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/tcg/octeon_translate.c | 60 ++++++++++++++++++++++++++++++
 target/mips/tcg/octeon.decode      |  5 +++
 2 files changed, 65 insertions(+)

diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 5bcea1de3b..ba11773aa9 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -334,3 +334,63 @@ static bool trans_V3MULU(DisasContext *ctx, arg_V3MULU *a)
     gen_store_gpr(tmp, a->rd);
     return true;
 }
+
+static bool trans_QMAC(DisasContext *ctx, arg_QMAC *a)
+{
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+
+    gen_load_gpr(t0, a->rt);
+    gen_load_gpr(t1, a->rs);
+
+    /* t0 = rt<0> * rs<lane> * 2 */
+    tcg_gen_ext16s_i64(t0, t0);
+    tcg_gen_sextract_i64(t1, t1, a->lane * 16, 16);
+    tcg_gen_mul_i64(t0, t0, t1);
+    tcg_gen_add_i64(t0, t0, t0);
+
+    /* Saturate -0x8000 * -0x8000 * 2 = 0x8000000 -> 0x7ffffff */
+    tcg_gen_smin_i64(t0, t0, tcg_constant_i64(INT32_MAX));
+
+    /* HI:LO += t0 */
+    tcg_gen_concat32_i64(t1, cpu_LO[0], cpu_HI[0]);
+    tcg_gen_add_i64(t0, t0, t1);
+    tcg_gen_sextract_i64(cpu_LO[0], t0, 0, 32);
+    tcg_gen_sextract_i64(cpu_HI[0], t0, 32, 32);
+    return true;
+}
+
+static bool trans_QMACS(DisasContext *ctx, arg_QMACS *a)
+{
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+
+    gen_load_gpr(t0, a->rt);
+    gen_load_gpr(t1, a->rs);
+
+    /* t0 = rt<0> * rs<lane> * 2 */
+    tcg_gen_ext16s_i64(t0, t0);
+    tcg_gen_sextract_i64(t1, t1, a->lane * 16, 16);
+    tcg_gen_mul_i64(t0, t0, t1);
+    tcg_gen_add_i64(t0, t0, t0);
+
+    /*
+     * Saturate -0x8000 * -0x8000 * 2 = 0x8000000 -> 0x7ffffff
+     * Accumulate overflow in HI[0].
+     */
+    tcg_gen_smin_i64(t1, t0, tcg_constant_i64(INT32_MAX));
+    tcg_gen_setcond_i64(TCG_COND_NE, t0, t0, t1);
+    tcg_gen_or_i64(cpu_HI[0], cpu_HI[0], t0);
+
+    /*
+     * LO = sat32(LO + t0)
+     * Accumulate overflow in HI[0].
+     */
+    tcg_gen_ext32s_i64(t0, cpu_LO[0]);
+    tcg_gen_add_i64(t0, t0, t1);
+    tcg_gen_smin_i64(cpu_LO[0], t0, tcg_constant_i64(INT32_MAX));
+    tcg_gen_smax_i64(cpu_LO[0], cpu_LO[0], tcg_constant_i64(INT32_MIN));
+    tcg_gen_setcond_i64(TCG_COND_NE, t0, t0, cpu_LO[0]);
+    tcg_gen_or_i64(cpu_HI[0], cpu_HI[0], t0);
+    return true;
+}
diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 15d3c79344..acf67857c2 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -28,6 +28,8 @@ BBIT         11 set:1 . 10 rs:5 ..... offset:s16 p=%bbit_p
 # SEQI rt, rs, immediate
 # SNE rd, rs, rt
 # SNEI rt, rs, immediate
+# QMAC.0x rs, rt
+# QMACS.0x rs, rt
 
 @r3          ...... rs:5 rt:5 rd:5 ..... ......
 %bitfield_p  0:1 6:5
@@ -41,6 +43,9 @@ POP          011100 rs:5 00000 rd:5 00000 10110 dw:1
 SEQNE        011100 rs:5 rt:5 rd:5 00000 10101 ne:1
 SEQNEI       011100 rs:5 rt:5 imm:s10 10111 ne:1
 
+QMACS        011100 rs:5 rt:5 00000 000 lane:2 010010
+QMAC         011100 rs:5 rt:5 00000 100 lane:2 010010
+
 &r2          rs rt
 @r2          ...... rs:5 rt:5 ..... ..... ...... &r2
 
-- 
2.43.0


