Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5F5CD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNa1v-0001Ow-NZ; Thu, 14 May 2026 13:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa0r-0000pl-7b
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:25 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa0g-0003u2-1G
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:15 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-409de4132b5so4849168fac.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778780283; x=1779385083; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V+Z5Xa+4C9Lk0TNV9LgOzbpa9crqmSVwKd0svd97e8w=;
 b=obGhINpO/pg2OVyIaGELU93G2S2FKxYtP48Xw+lXvchPv9+EftklXsBfVFXw41Br22
 Mz01osN4S1YsII3bgh60KGtLVxQcbc7KDH4vcNXeP/uDfNRUxCXEEqTRtg1jm5Bk5MlL
 deOQcF6ai7ijytQfCnedL9wF3UnHBDeHfME1l0rTMIy1odAh86niEfksxwEJRFWtAzq+
 Cv6DASSOI0P1z6dyqYZt7IiKZxVKCPFqz9tup9FlZ2+nuOlqPS2JQSQdAwZSxSHNG6tJ
 74YAF9rXUWxP+15cZrO0SQNXxcPLx7GAFxR5xfuHnARESkdZ/C2nbV26e3EWXAN95EZK
 Okqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778780283; x=1779385083;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=V+Z5Xa+4C9Lk0TNV9LgOzbpa9crqmSVwKd0svd97e8w=;
 b=WxYJVHvd75fdJbkO2e4qNF3bp6MGXUjklpeDMkMR3dYmodVa1kP8gKBWXlfVUE89aN
 IyG8npsuWQwksjux/Q4OOfm+yIQFNxVxhbV8aO7HTMvsayMPEsoEuUMw6VQso0wlFNik
 Jgr8Kg5wMcCv+SSTl5rKv+8giq4xHPNv6WDmePzUhLbvugdSsx2wVojywVI7y0ysBjMz
 uvePjeRMly5GzLJ9ehoaqG3/vbGNfN01Bq7lvXxa3Qe6ZwUYt99E1wxwqp7vOqbv3A2n
 5cEAK10VnqT2w6cReceD8ksBYx0FkqebQ6GiOSTVbm+vtYgixEr1YfWUOjxz1WpZTmtg
 Iubg==
X-Gm-Message-State: AOJu0YxGxZINw3AiP505OuHxIO1RaIQ5aL1qKRDDSQTewyS/8s6Keqnj
 wczhZeBWzIFlJKQEdip46LvXCc7iAVNYF9xugWYQFZCsnzLIONJH8wmo
X-Gm-Gg: Acq92OE9i2/gcUF59FW3xfEk7WsGHlHkkIMllD38JIYY5p8vuXmZ/dKEScSZgLnRgqG
 65azbnzNbrWTKn3puUlx8xgeVtI0kuF/GeXpwM8FpgHxmVDdFkj68hplDOE7HqbL6X9QcHz5CHP
 WKIfSv7WtupjTWkjhgCsxc4ACEq+45UlT2gh223V1kV19IWHOgs1yfkQjbROzYGQKArU7Fby4aH
 82qVnRNj0v6SycGuXRiJyrtvARuMait8NvJf3dWld8q0mvemmCfgi+oMJaV8q4jOF8tNf2wRc3Z
 UtY2OtkTwxqNdaZYlk9ATbyKrDU8dy3nfpXky/DphDemMMWptvfdER3+4byUzufYfCJ0ksa+Fd5
 AIjm6sKaBGW49T6ZlcdeLPFXufVMjVmgj3QLIs6wis5f7Gc7AjA8Qkw56mKZyxjm93aaqq/OMDl
 1PpR9uH35bxTaxS55tr4D0Wcyz1VAr/GQ/8OvD8v276ju2u8wrPzT4tCFXCUSQEvvGUsjScEjQ1
 p0owsJM3PZS3OAWcFPV8izOjmQdAlEP/lR9dhrVmca00ZCgx/RbNbZMJ6qwz542hcz2
X-Received: by 2002:a05:6820:98d:b0:69b:3360:3f90 with SMTP id
 006d021491bc7-69c942ae194mr288748eaf.3.1778780282978; 
 Thu, 14 May 2026 10:38:02 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b8ccdc74esm1687254eaf.13.2026.05.14.10.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:38:02 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 14 May 2026 11:36:59 -0600
Subject: [PATCH v7 10/35] target/mips: add Octeon SAA instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260514-mips-octeon-missing-insns-v2-v7-10-226686be4ce1@gmail.com>
References: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
In-Reply-To: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
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
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x36.google.com
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


