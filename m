Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51A7CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNDk-0006k3-TU; Tue, 19 May 2026 12:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDX-0006cx-12
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:52 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDU-0000ed-U7
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:50 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6949192b843so968215eaf.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207766; x=1779812566; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V+Z5Xa+4C9Lk0TNV9LgOzbpa9crqmSVwKd0svd97e8w=;
 b=Fw6pLxQA7Fp4vrJV/bV3CARjHjpaMKnDFJwgQaceNzqaLgft6sj5+Ki2SFwB7PRACP
 CqiS4n9e6ggvd3ZdRjcrrT/vA9H9nR+aLm0RlHLlvHdWDCjNvmdotUhj/BScQBjaz6og
 MjEcEOaIIGq7SQXtzpuDfGln+8Cas7LY9STmP3epcIo7lLnpLaH2oJ5hSxxjQIWwLe1k
 dB+l5GhbAorJgZEQ+KEaRPpSaQoiTQBGSRNe80rvGPoUxUCjJK9b6I7IFFlLjxahLfPM
 7Qh/TqEW174vu1eS1btWtMr8a7DYRf4V/rRyqGkDL5ZjRN4eup+MDwlotYkLxXZPXACY
 pivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207766; x=1779812566;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=V+Z5Xa+4C9Lk0TNV9LgOzbpa9crqmSVwKd0svd97e8w=;
 b=heLwdWrBh3pyk/9omjR5u82tYxQnrxHn2jF5xzbJkse7lccvPBje0bZ3FRstQyPP5p
 E6EmlKcH/lnn1d0OuwX8uL4t4uoB57DJzxtWBiDGwzerr6XLfeKiSQyZRbPVIDvzqe86
 q5iTqqV4F0yTrZAjhxBoSaZ42Hey8sp1saaGr7nkeNkH63BvC88hsWKIsG8pXVp3L0um
 qsgkcqc3EjF0vOnqnMKinH9Nl+hNI19so4UxV9fl2t9+MdR/qfjA4VGLQS0y4lepHTh7
 5pDsqUSG6t253dPDGh7YOra+K6bQWc9UCo8hbaZn0jlytDRuEn+jLpuR7tC2kGyRerNc
 k9gA==
X-Gm-Message-State: AOJu0Yy380vIq1wayEe/rY/k4NuCG+b6AflY6Uam6sCu2OakGuvbpb9P
 /y2eheetKDIGSQ4XjxGhP0/GFclIJJ+Rgw3U8t4Qo5SWLV8k4hrWmDj8
X-Gm-Gg: Acq92OHGgEVLgKBYbcikaCy3s6J1rN4mKSAWoWFh9I98tJ5L1jxQH1bV7OtNtsCwS/6
 wA7QGPS7LIz1zYb1HxJ+fqp52WgOza5sBAdYy2lY3TrtIG8Z42Yx8zMERnE9CxRgtbfxj7VAD8R
 RiuatM6aKEibKLl9XYRCX8HClDIGb3AhwYoW36pb1R+xuUmZqIbeoWHIeudPTo4Q9hiJTWIPcny
 ra6gA8hANnCnHjDhqUk0hTlMoU4bEjhzzNzV3LlenHmDPJw5HJO/+6qghTSJ95+pdNVZT/VAU0+
 n6o4WvivFHkNiGarEEsfd6j/JuJzOjejDJT0oKTQnTem08+FGgw7d8RP+N/HVpYU01GAvZIfbTT
 JKtJu5ybV3DdjZiKWgvr0u5RaqxjDURuetxcmg/mwSVrWVNCM/6BMH21nsFBu8/OHB31z21gadg
 8HFty5sampFTxBg1oHyByC0kDQDcQuwnmXk4oSKzSE+iPreiolXPZxVoXnHfD6j7OcBAbxPd7Cb
 ucuOne0370b+gYrAf/CfbWQTuHanM/hgMNiB7T3Bn2ITe15fdFKqjmSxVSVXCELe4eP
X-Received: by 2002:a05:6820:200d:b0:69b:f252:c622 with SMTP id
 006d021491bc7-69c9bfd597amr12315546eaf.57.1779207764810; 
 Tue, 19 May 2026 09:22:44 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a95762ceasm7056296fac.13.2026.05.19.09.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:22:44 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 10:22:12 -0600
Subject: [PATCH v9 10/40] target/mips: add Octeon SAA instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v9-10-d7dd735ecddd@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oo1-xc2c.google.com
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
Changes v6 -> v7:
  - Use MO_32 for the word-size atomic transaction; the signedness bits are
    irrelevant for a discarded fetch-add result.  (suggested by Philippe
    Mathieu-Daudé)

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
index 401c4bd14b..f00692830a 100644
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
+TRANS(SAA,  trans_saa, MO_32);
 TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);

-- 
2.54.0


