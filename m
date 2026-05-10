Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98388CD37AF
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 02:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLtgJ-0006AS-RB; Sat, 09 May 2026 22:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtgE-000699-QN
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:06 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtgD-0002yf-2c
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:06 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6948fb494a0so1756155eaf.2
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 19:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778379244; x=1778984044; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1dyL5mvtKCvLzqslr5gudn8wtXC6RGz9JM9Y1Xdfj14=;
 b=jTqzacWfkLk43bnLuSVvoorCLZ9crB9Q1BPDGOGkRrypyGpIPH9eHhTiVP3zOw7BUr
 93urnkfdDwGxBpJto4yQNjGmij7fT27GPH6aLpGy60zOUIb49XH/TxKzZ6yNkssKtJJP
 uqW4kQhLY7bc5GVBUM11hmsF3MvYekmcwCFI6fS1I2F/vTiKu1tb3H7GKsfHN0TBaagv
 Q/ZsirLFhFXjcwwMEsPpAQoGgSehoqeSeo4DQ4an51xvcbQLcg1vRyEcZU2R8bPWN6qL
 GRKE1WmHbuQea5tgKZEo85t77PgmYK7UppJ/ilWSdH23QGCt6MhggHNf72X0SiJfCcXT
 E2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778379244; x=1778984044;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1dyL5mvtKCvLzqslr5gudn8wtXC6RGz9JM9Y1Xdfj14=;
 b=sx4O5Wl6+sD/6ql+0fSe/uq6NDjkHyFY1/nuiQaIIFUoJlXWW7dwuSxY25DRfkJCNi
 Is8bo6FwsG/LhNiPq8FgD4k+Q0fr7/PJq8gxg1Oe8QFRXxbYe/ExRS6RyT6AfEcktyJX
 CkbvcqkauFtBKt/zaJnH85s956KzUcDEx6HxIoWRCsAHU8bg4WBk9b2RCEYrvMz3s3TP
 RqQUmukE+rM+Q5C1bAXFIIlB7uDnpK6Jjs5mC5WZUfpsj4i9N9iyJgunD4VIm0/F3pY2
 U2YYC4f76J4Rae8PndwEfdi36fxbx1tSffLYKIwePUk641XOsFQmiNifp6Hx3RCRwMXM
 UfZg==
X-Gm-Message-State: AOJu0YxzOOzOy0oyhP/e00Z3jUsDtpcBMmsHbS1K9zOnlS+gQewaeyHS
 AXTioHx/Y5yO6RxefJZScFp4S2CoLCBNDdCmPEo+BhiPNx+LudZhHX8s5ESQBT1o
X-Gm-Gg: Acq92OEusmgMro5xBHAFkJho5OQh3uC5dUXd/nM8rP8ZTo3NEvDXDn+p3Nx1AIgI2D6
 F2mekGMjj3eaRdUkmF1puI0JwD5Np55J2s3CyZ1ah7xymjvPG9E7lXDDvzq4+BjtTSwvCyz4+tF
 5xwf4nmISTw9NzPkf40fa7Vkti4WNJSwf0rQ2Qq0jiJnoXNaxaNcGkA2MN2xyE6eYj3lyeLCLKW
 jAUMOQ4AlDQcTXjZpqreU7S8427Y3hVe/FzQe7m5qwa/44hjyULkK4kD0aNLl0Ug5YqMnoQIpCl
 h66mXPAeZ4fxn4Hcd/uUP3RnP8fcgGCHTLsRIihmigyinQIrGP9P5mTfM6CX0emNHbiUDET24ui
 lL/XgRqmB4+rOLhNJUhZM5MsQLtdz/onBzLips9+AEMAF0HYX0frIXADfSVgiUWc9ZCejCxAE0X
 LJyvhwo/m0SHn/2UB6Wi+YyCxT4LgzsQbxwm/CNkkRMUEBFfezbXq/tkOkV86kBKvekOIuuhrL6
 I9AAqe0WOnvx0uHNHmB+SyzZO02l3j6GfJKNmIQKfEwq0uEIpBvurjSPDsZ0NXGqfGT8GfjBrVe
 S1Y=
X-Received: by 2002:a05:6820:2017:b0:696:1f5a:9bf0 with SMTP id
 006d021491bc7-69998cca75amr10374977eaf.15.1778379243652; 
 Sat, 09 May 2026 19:14:03 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25dbffdbsm3645643eaf.9.2026.05.09.19.14.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 19:14:03 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 09 May 2026 20:13:34 -0600
Subject: [PATCH v4 11/32] target/mips: add Octeon SAA instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-mips-octeon-missing-insns-v2-v4-11-d669dcd05c2f@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oo1-xc2f.google.com
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

SAA is an Octeon+ instruction that atomically adds rt to the naturally
aligned 32-bit word at base and discards the old memory value.

Add an Octeon+ feature bit, enable it for Octeon68XX, and implement the
common SAA/SAAD translator with TCG atomic_fetch_add_i64.  The MemOp
selects the word or doubleword transaction size.

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
---
 target/mips/cpu-defs.c.inc         |  2 +-
 target/mips/mips-defs.h            |  1 +
 target/mips/tcg/octeon.decode      |  4 ++++
 target/mips/tcg/octeon_translate.c | 19 +++++++++++++++++++
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index faefab0473..69e02532c4 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -1014,7 +1014,7 @@ const mips_def_t mips_defs[] =
         .CP0_Status_rw_bitmask = 0x12F8FFFF,
         .SEGBITS = 42,
         .PABITS = 49,
-        .insn_flags = CPU_MIPS64R2 | INSN_OCTEON,
+        .insn_flags = CPU_MIPS64R2 | INSN_OCTEON | INSN_OCTEONP,
         .mmu_type = MMU_TYPE_R4000,
     },
 
diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
index 9d4d292586..386e7179c8 100644
--- a/target/mips/mips-defs.h
+++ b/target/mips/mips-defs.h
@@ -41,6 +41,7 @@
 #define INSN_LOONGSON2F   0x0000080000000000ULL
 #define INSN_LOONGSON3A   0x0000100000000000ULL
 #define INSN_OCTEON       0x0000200000000000ULL
+#define INSN_OCTEONP      0x0000400000000000ULL
 /*
  *   bits 52-63: vendor-specific ASEs
  */
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
index c93eff59a5..548ab1b220 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -161,6 +161,25 @@ static bool trans_lx(DisasContext *ctx, arg_lx *a, MemOp mop)
     return true;
 }
 
+static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 value = tcg_temp_new_i64();
+    TCGv_i64 old = tcg_temp_new_i64();
+    MemOp amo = mo_endian(ctx) | mop | MO_ALIGN;
+
+    if (unlikely(!(ctx->insn_flags & INSN_OCTEONP))) {
+        gen_reserved_instruction(ctx);
+        return true;
+    }
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


