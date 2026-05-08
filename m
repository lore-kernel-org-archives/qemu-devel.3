Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35DCCD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMtU-0002ll-AX; Fri, 08 May 2026 11:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMtD-0002gH-Fa
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:20 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMtB-0001j2-4b
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:19 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7dd73b7c757so1116891a34.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778253196; x=1778857996; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hRW7lzYmIT4LWA5/NlEpDMeZYVJPDf5iQGLoHhxqnXQ=;
 b=e684avDNLyvhOXzsS+ZrI7DY0d7aOT0WYNak+RLOFkK0LY77AOH2kSHQT6dE5IoXKb
 /ABS7KOFvdHZ8zZ7HCppmL5IaWOxf3AvQNe5THEF6AnszpmqTHrupHNsEZyVVi4tAAQq
 lMYWFxCQ6jCmU+HHbHMP/quu29glun2UYXy+///ZNZB1mc+HZ9urex92LqBwJFkd+8dB
 jgUk/YEfoUEphRTSSBY3YIG0SHUQ2RQGXITP3Y5V6ZPCoDQG6f7HfkI6V45ITog2iKa/
 bAOx90uE4sCIuSYHcD3d4AHSzGod1pqtq1P8APUNF4JPXQ+0h8PZrOV69zD3kUTF+VLJ
 RoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253196; x=1778857996;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hRW7lzYmIT4LWA5/NlEpDMeZYVJPDf5iQGLoHhxqnXQ=;
 b=BpiViQ0+3TJJIq6+WJQ3an8xFNIlss42ZJdoeAl5cZXhvNELd2mXi8PevoHroofg4j
 a9itQRXLxmdB0p628Sx7MiKwYvcE2E5dB1hR9iKF7Mze1OVXvgXJ/nIzIvKt8VHwcnzX
 MymWL5yNKr2SeTrimJP5QZ4o4vZDQfOVtNT/t5bUajENWR79DSQSg1BqRlj9+tWKBeM8
 scGbJjP0qqPo58HMMhFFXg++8UN6t2uSClYDuUg30GxO78/1LnoZz8ek1i1L/9Q+hCYh
 rc8E2VNPCIxCIlZ+jutRxHEZAbZUAGNntvkp61Mm9zSn+v8l+ingifIdQgdHO9i5igAH
 Fo1w==
X-Gm-Message-State: AOJu0Yy2kZW5OZngx9Rm0OSxaPvPd0brfenV7BdpBeygBRODLZsuNcyU
 JaxGveU87305tLHeUgqjqaa+D6f2WJmSmxx7BXeJh9crtXfnALgyIl//pVE5XA==
X-Gm-Gg: AeBDietXMHNUoglc94r53uwmO8kTtyzEyq5TXUMgIhSsgu7ost3FhOST6BV0o5E5Ldi
 EjTil+shTVUosGnoQQIOusTuDL7pa3WHmW3BvcBdriGxeIjLR/Knt31ZZnAmwiPMZ34gqQC0J7b
 88or3dsS+qgB2aWv5trhUAhsP69ZBKcRdNHWB+ppsxO5OwWbnboPfdUUp0QkMc0rtCu2hfJZwFo
 wpZJHDZXbLUH7dXPy56UUXjvGc+YaRp7h6GbAvS76eIlNd/fJEnf/w3tldZYERWrYrK2Z3fOXUJ
 0X1/jXsbaQVHJOnT/SnHlCyAmpVtI9Rr14rwZ8zUkwfkFhlt1Cw8jQFhVn4NqoSHLpD9ldY6m/O
 RZwnsN/xBdcACvTpYRjiQ+1iYDyChGJDcMzYEErcyBNjuMATIVAkJlZsn7FHPQhV3f+Yu2qYCxL
 DoUq8nKGjVqVq4zHXOisTvgoQ/m3av4uFKJqqJMNfh7glBu71Zn25eXTctstF//CLVIUPquaTto
 YvjNYRmeobNsMZkEipvz8LgOHhqE87ZDCL7LP0bDrO44Y5W6zF2mgdD9+gvO9GBeurUifJnnlN1
 vp2FWSWp4s+b4NwiEWQLyJEI6I86wbyg1NffZde9W+th+PM+JDMvahaFbfKrDVq5Kd6nRnY=
X-Received: by 2002:a05:6820:61e:b0:67b:bd89:90ed with SMTP id
 006d021491bc7-69998d30169mr7612484eaf.41.1778253191086; 
 Fri, 08 May 2026 08:13:11 -0700 (PDT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (71-218-113-237.hlrn.qwest.net. [71.218.113.237])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43557109b7dsm1897904fac.5.2026.05.08.08.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:13:10 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 08 May 2026 09:12:13 -0600
Subject: [PATCH v3 13/32] target/mips: add Octeon ZCB instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-mips-octeon-missing-insns-v2-v3-13-bcbec96357d9@gmail.com>
References: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
In-Reply-To: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32a.google.com
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

ZCB zeros the 128-byte cache block containing the base address.

Model the user-mode-visible effect by aligning the address down to a
128-byte line and storing sixteen zero doublewords to guest memory.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split ZCB out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      |  3 +++
 target/mips/tcg/octeon_translate.c | 24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index d77717cd50..d8a1bfce77 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -49,6 +49,9 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 SAA          011100 ..... ..... 00000 00000 011000 @saa
 SAAD         011100 ..... ..... 00000 00000 011001 @saa
 
+&zcb         base
+ZCB          011100 base:5 00000 00000 11100 011111 &zcb
+
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
 LWX          011111 ..... ..... ..... 00000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 104822a64a..c2a3eae134 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -187,6 +187,30 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
     return true;
 }
 
+static bool trans_ZCB(DisasContext *ctx, arg_zcb *a)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 line = tcg_temp_new_i64();
+    TCGv_i64 zero = tcg_constant_i64(0);
+
+    gen_base_offset_addr(ctx, addr, a->base, 0);
+
+    /*
+     * QEMU models ZCB/ZCBT as zeroing the containing 128-byte cache line
+     * in guest memory.
+     */
+    tcg_gen_andi_i64(line, addr, ~0x7fULL);
+
+    for (int i = 0; i < 16; i++) {
+        TCGv_i64 slot = tcg_temp_new_i64();
+
+        tcg_gen_addi_i64(slot, line, i * 8);
+        tcg_gen_qemu_st_i64(zero, slot, ctx->mem_idx, mo_endian(ctx) | MO_UQ);
+    }
+
+    return true;
+}
+
 TRANS(SAA,  trans_saa, MO_UL);
 TRANS(SAAD, trans_saa, MO_UQ);
 TRANS(LBX,  trans_lx, MO_SB);

-- 
2.54.0


