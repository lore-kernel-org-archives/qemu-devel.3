Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F63CCD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYga-00017k-Mo; Wed, 20 May 2026 00:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgY-00016k-DZ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:34 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgV-0003nG-Ib
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:33 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7dcd689829eso3753259a34.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251849; x=1779856649; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7r2JZOP407stREDmdSr8VFs+49L5cEL0rjNOeyyPOaQ=;
 b=U7eFU6uzq6m9j4vXKY7p2IZJsu5Wj0v4ImqQAhzftIqXdq+LYGYhbl6pfQLftbP5jN
 8HO0VJM+JJJ7YumQ5Ynm7kcWcSCzd+73NiCzVWn4TvN9HCnFSB4Aeu90eyk4K4UaIuIl
 qOP3bP7Y9W3N0/p5IVpapD++kgS4AsyW6fL4Gln2dUNuRebh8I6FYMWoo/Rt/b2ebp8s
 caWnrQZYZYJ+cKo+gEUbRVNHUe+YHEy/0NquBmJzwoIfJwvDsF7e4WnptXEoGdqjH9d6
 +k0A5h+nt3hC7GDCJQt+mvlfrElrJn4/eKEtyDfi6SnJqA26efNP2HnMwUBUJfLpzRc5
 NfmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251849; x=1779856649;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7r2JZOP407stREDmdSr8VFs+49L5cEL0rjNOeyyPOaQ=;
 b=N488U6CDPzuwHO0TcvrPM0tZHJdFu16O2UvBk9dXMhjTSCGc4fcekAl/W4Ltj1Vcga
 dLsCSRFj3cD0HwwXJIWoS0mXeBn8vTJvf2G5y4KoyWx4/WkrH1CtF+XlIIpWt8qwbNyF
 z4itSk7EB6D1OQ/GKY2h5YwIVoVtORybpCB5TRtay/F8MOA8GEHaylziqOuhxY7jYteh
 kE7j7hGNbqekuc6d9aUhzIHJ5hKARG8b6FVv919PALT5c7R8m6FPpbClWkcyBOvrPQBe
 DGGUcYg0qp32K0fkpVvUb85ZSMB0GxUBYj+QE/7AIHA4bI2kkjYqJJqpA+QZT2fyOJeS
 LrKw==
X-Gm-Message-State: AOJu0Yz3i4gqH9eOuVP58OygnchPUIX/QIRtYM5Fw2CwvxOv1IkHEgGl
 ceJ+yGDn4nQbK380Ej91Z9HFiMrLTC+pUiRZorm3LzyCdh2KZJz/EV/u
X-Gm-Gg: Acq92OFMHIKFt89nC23paCxV/0/Mp/cEtxSgCecgfIQWmLWGe2PoBOHKy7E3Ern7w1x
 iUSdQjzPncBmPGtaLNGU/g9tkRQSCZxrb3k/MNBj2KxObhjznXaQb2WVU2TpFCXeti7hlkn1cSK
 l3YHFeJY3yK+yuoThv+HqWg6lR+idNaY5+isoBnr5ghXc8fqNzF4C4zozyKXYuML3jPYE4Xq45K
 BZwHkQnd2LKrAmTcQ3vMh7/Iorzp9M8ube0MZ4i8Aiq9zhokWt/xTo+xs+hnTxwG3ryteXzTLV/
 vm0TC+d+yaGL43lDaRxx4oEIB4nbkYloYwOP1xqVqM8SCJFVFubEpt4IbjV1FxlbaI8XKyo587g
 YxXXX+r/6kz+JK2KFaRNhvaz1m3997IbwZIuhb0aJsgveYEfVxwhOVWYC1zdVmSMQNXRUI+E3go
 YOUVBCCATLJCQPKv+w8w/Onafi9JIKikKKQDS6ghHwR1eDZpuTNLChbZIlJW+0069G2dHN+zlZN
 uNI18Dx3Zm+7NFHEKjFqR5jtu3tiI1fAh5e7ZQ9GPKomCN0UhvdnZPn1ojrn/GA/TcA
X-Received: by 2002:a05:6830:4394:b0:7dc:de56:d75a with SMTP id
 46e09a7af769-7e4ea04ccbemr16680607a34.4.1779251848911; 
 Tue, 19 May 2026 21:37:28 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.37.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:37:28 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 22:37:06 -0600
Subject: [PATCH v10 12/45] target/mips: add Octeon ZCB and ZCBT
 instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-12-306f9edfe15b@gmail.com>
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

ZCB zeros the 128-byte cache block containing the base address. ZCBT has
the same user-mode-visible memory effect for QEMU purposes.

Model both forms with a single decodetree wildcard entry, align the
address down to a 128-byte line, and store eight zero 128-bit chunks to
guest memory.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Changes v9 -> v10:
  - Hoist the zero-store MemOp into a local constant.
  - Add Philippe's Reviewed-by tag.

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
index d3dfef2e0c..b5ebad9804 100644
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
+    const MemOp mop = mo_endian(ctx) | MO_128 | MO_ATOM_NONE;
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
+        tcg_gen_qemu_st_i128(zero128, slot, ctx->mem_idx, mop);
+    }
+
+    return true;
+}
 TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);

-- 
2.54.0


