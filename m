Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D61CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNDe-0006fx-EJ; Tue, 19 May 2026 12:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDX-0006cy-1A
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:52 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDU-0000fV-VB
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:50 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-43ab7bfaa18so1105526fac.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207767; x=1779812567; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lsK81F0syPTphslU+QA3ef80444bfDXtbrnfPQ1ATFs=;
 b=Au1otY4vvcwjwdhu0btbdbQwFbsrAgSanR7lzIDoAdTH1MbLewFMMruO7rLRx39S+T
 0PCEvCV74asUfFke5vQWsNgXol210erCv/J1gbFE59YzUk7UjBTrIRyTK3Mgolzj55y0
 +alo5BsR7kJG+V8LQDW1rYV4Pe/i5FHypZ3OoFss+2qJ8WU/s0kPhzkt1f1HJqRmMT4e
 SMagf3eAPjc9rXXgYF8QidMvNHIKwX4Sx75Zlw+XMNnyltf9ZBBs+lt77LYVPSwONu4V
 Sns4ek/mmKanlNTsTjpofbbr78c1Av3gMc0feqTLoYZo30JeRmffBsGe88UkxusTQFtN
 2aQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207767; x=1779812567;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lsK81F0syPTphslU+QA3ef80444bfDXtbrnfPQ1ATFs=;
 b=kI4IYsynXVQ1F+7S7EBeVHL4tRux4luw9zrT2WQA/8Rt3t1AHNhvwiJHTK+dXKDC7c
 W8ElA8qWW0tUYrtA2CO10vJ4WQwXwWbo9PxxXgyusC0+Xn2roDpBpt1YqTUgiwRNJl8J
 rN6Pj07grwEXyNJnyvml7m3vUUQ0LgBx4WIDYvH4KtaDYn1bLW8mPct9Kl6A/PueqYhw
 UarZH9gi8hSrTjKx9TzY7pHQfCNYzKL2Po6hQA8BRIhjth1jbfyWLGmJO6u9R9fzu9ll
 /oMcADq1aI8ZNAEMKAkiydMfybMEUquWXic7ZB3MgbQATnUXs5AfrfBDb9QzFGyFFkQF
 +9uA==
X-Gm-Message-State: AOJu0YxB54moxdk56gMsb4G6vltGBI+giVRBdzQp2Ji9liqNMR+Zg53U
 u0f/Zvz0AxEcx7Hf6b3mgStuv9uo9NapRM/+jbN46LAZXVUmMKcsxkb6
X-Gm-Gg: Acq92OHJiM5mZLUxf2CmZhCFS7wvAy0Ndx2GWz8EQhkuegG708AvuRmLzJYd+Vmruu3
 YubQcS02DO2N7q7tAZx3tR5bac68eBKima/nE7qnYQcxnQ/HdNc5QgXNSJKeLoSujTvT3C1o/Yj
 9JYnQ4q66wQlXBZVH+OES99gglzVohv4oMb1bBFfh5rspVBPKsSJv/9VRea5IReblXNjtU5/nzy
 Eb4CtApjy5FPeGfa9uOqFydZFeNZODRCHv7roTV07pYhlyYdoJ5OuHfG3pwAYm2X12viw86ncJ3
 xqJNUm5EE5Po3y4Y8KTIngXrL9fCpbpfRbPyUoVbJ4JiceUaUgRMG+JhA46ZhAitHEq4GEDakqg
 wk99hUxj20hUA0HGUdmXAMtz/SKWCmOJWSLgZnePOF5yJwDTq9K3m7w/Vsdjie/ik3F4r5Jak7e
 idjgjjdZFMNbvig9YwMOyQqgafQkNxhKeHMRaKFp6ZdUnEwzXEP36KJrbP1b/bQhiCrqbJ3NZRW
 wJ61gcCGgzrz7GfXF0tLlXbu93hRd0WMTDJXspEF6Ucxt4dZ6zDtMLLEt371Bkn3kIp
X-Received: by 2002:a05:6870:45a3:b0:435:b230:fc0 with SMTP id
 586e51a60fabf-43a2de7cd1fmr12571295fac.37.1779207766884; 
 Tue, 19 May 2026 09:22:46 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a95762ceasm7056296fac.13.2026.05.19.09.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:22:46 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 10:22:14 -0600
Subject: [PATCH v9 12/40] target/mips: add Octeon ZCB and ZCBT instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v9-12-d7dd735ecddd@gmail.com>
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
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x31.google.com
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

ZCB zeros the 128-byte cache block containing the base address. ZCBT has
the same user-mode-visible memory effect for QEMU purposes.

Model both forms with a single decodetree wildcard entry, align the
address down to a 128-byte line, and store eight zero 128-bit chunks to
guest memory.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v8 -> v9:
  - Use MO_ATOM_NONE for the 128-bit zero stores so TCG does not
    require unavailable 128-bit atomic stores on hosts that lack them.

Changes v7 -> v8:
  - Fold the ZCBT wildcard decode into the ZCB patch so the series does not
    add a ZCB-only decode and rewrite it in the next patch.

Changes v6 -> v7:
  - Use 128-bit zero stores with MO_128 instead of sixteen 64-bit stores.
    (suggested by Philippe Mathieu-Daudé)
  - Fold ZCB and ZCBT into a single decodetree wildcard entry instead of
    using a duplicate entry with a selector comment.  (suggested by Philippe
    Mathieu-Daudé)

Changes v2 -> v3:
  - Split ZCB/ZCBT out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      |  3 +++
 target/mips/tcg/octeon_translate.c | 27 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index d77717cd50..01ed3b50be 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -49,6 +49,9 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 SAA          011100 ..... ..... 00000 00000 011000 @saa
 SAAD         011100 ..... ..... 00000 00000 011001 @saa
 
+&zcb         base
+ZCB          011100 base:5 00000 00000 1110- 011111 &zcb
+
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
 LWX          011111 ..... ..... ..... 00000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index d3dfef2e0c..721a9a8d9d 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -176,6 +176,33 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
 
 TRANS(SAA,  trans_saa, MO_32);
 TRANS(SAAD, trans_saa, MO_64);
+
+static bool trans_ZCB(DisasContext *ctx, arg_ZCB *a)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 line = tcg_temp_new_i64();
+    TCGv_i64 zero64 = tcg_constant_i64(0);
+    TCGv_i128 zero128 = tcg_temp_new_i128();
+
+    gen_base_offset_addr(ctx, addr, a->base, 0);
+    tcg_gen_concat_i64_i128(zero128, zero64, zero64);
+
+    /*
+     * QEMU models ZCB/ZCBT as zeroing the containing 128-byte cache line
+     * in guest memory.
+     */
+    tcg_gen_andi_i64(line, addr, ~0x7fULL);
+
+    for (int i = 0; i < 8; i++) {
+        TCGv_i64 slot = tcg_temp_new_i64();
+
+        tcg_gen_addi_i64(slot, line, i * 16);
+        tcg_gen_qemu_st_i128(zero128, slot, ctx->mem_idx,
+                             mo_endian(ctx) | MO_128 | MO_ATOM_NONE);
+    }
+
+    return true;
+}
 TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);

-- 
2.54.0


