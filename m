Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABE0F327D9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 17:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFEtO-0003z7-JM; Tue, 21 Apr 2026 13:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wFEt5-0003mE-HC
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 13:27:54 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wFEsx-0006hJ-Gy
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 13:27:46 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6948b5b1c53so1212530eaf.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 10:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776792462; x=1777397262; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kgzwGQYDZtqHRkDL6zR0riBaHHmRrVYiB8biiUGPmfo=;
 b=f801x8Ja4cmH/KHBVA+lLgNCWysFHJvuPqw4fF76mGpHv9wf3I0Kaj+7973dEUXojK
 wOcStprnmmXv8dXMtdbKDtiOrIo0BTrJwFQhTQ4sIy64bhDJlo9OWK2HR69Mgd2aWVdz
 BizPu1euPTPLjc9Xlc0LRz/W+KBUqBHXG7JhFSbX2qYlIkquETSJ+6rnjRGQCDw9xz4b
 kd6cEynGTX/zhdFTCXRQg4wQvvgxskApsLAJPTLHNaXSsUmiC73I9B9/YIP49sC5TIHb
 /0jxzmel+VfEsqenSEtIkUSz8FlVMLnwbnik4v7q4ytM1v6j2qGOEUCgJfCjwF0G6pPY
 Lgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776792462; x=1777397262;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kgzwGQYDZtqHRkDL6zR0riBaHHmRrVYiB8biiUGPmfo=;
 b=FTaHQM81a44Hq10f+wsQr4Zj6rPy1AvO0BeyKfOh6ULG8oI6bF7HZKleQ/gLMlwDPB
 Qq3i4MdmTIeU3hmo1m1Xm/az5LVjgeySHT2SEoJAcrBmsHk/jA3MGtvrYp/6piWGp9Dq
 3DZDxngblpdnMG8ljbY5C/o+eNAu6GojmUcT0otEjh/97RHxogNTUmfIjL6I9+oRFO5g
 5znf4nWR5KdX7YFamtVZzLchFRBeJJXBNvEVf9cDqQcJXjegW2OhdKtrB76v5NJnhT39
 UejqY0LnwfFNe6pQhI2QmJPGHQp8AEerW48xwLey5Wgtcqb10TqnvEfuCdAgioBjqSe9
 2wog==
X-Gm-Message-State: AOJu0YwIDA7+GOc+5du7KhW4kRWgHHKD/Jd1rZDVJPK5ngcZGfwv7SAT
 iAY8Vvu9AWyXTdMHeiOrqrMbUr8idtpHZcarejW+ZGvqeMOuoSDy9NQP
X-Gm-Gg: AeBDieu5s0+/Yy5NBSs1XjAMAFW46yEc3Y3fZ/8gNbbCbwKzZcvNBFlcRsMAxs4DwHK
 SpT3Dr0Vd3NZJXxzxW8+ihjtiB3ctge/JUTUsA11An6dNY3EDw46+XV+gbl55V5visLr2jeDlPD
 4RlGxHjjUfs06I6Y3qmWZwbE4imukbeRlB+HESInDp3WkEej6I96SHuSu3Oo/eoSEcCIVZtSre6
 5eXkZeTjchSrPNPO+JQfFXWT1i1xCbXJs+u4h0vpAolkfyLaiD+YaX8Z0od/BsJzrnoSsOvM1y3
 hvuV7gehtWAlQfTeUuH2N6yWAC4O/RQAyr8vKHu6wTBdz1+UyBolzAJxWGi5Dy/Z1xoGNPemGKw
 OXgxULzkrI6qcSwmU1/B4N6sJwvFtsIq4pbo0EW07k08644lzyv09TWzy38rZbnqf4EePDbhf4z
 r3GFsTmd+pjshQydZ4YBcTICg7CvGf0iJ+aRYryVY66BVuSfDetFNsvdiT3CqC6Y5Sa5L2U8e88
 qv1S2kQ+sEnISmN8WOaTdKyxZOPEN9Adaqa/CnkwTJz/Mxs72kShMWFJ2ZQ5I6PZkFEwACbN/26
 ap4+2YGYs18IvvXq
X-Received: by 2002:a05:6820:f03:b0:67b:f12a:dfcb with SMTP id
 006d021491bc7-69462f2ee31mr11258364eaf.60.1776792462189; 
 Tue, 21 Apr 2026 10:27:42 -0700 (PDT)
Received: from mac.localdomain (97-118-149-104.hlrn.qwest.net.
 [97.118.149.104]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b8fe2c52bsm12209290fac.0.2026.04.21.10.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 10:27:41 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 21 Apr 2026 11:27:30 -0600
Subject: [PATCH v2 03/13] target/mips: split Octeon SEQ/SNE decode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260421-mips-octeon-missing-insns-v2-v2-3-a0791df188c9@gmail.com>
References: <20260421-mips-octeon-missing-insns-v2-v2-0-a0791df188c9@gmail.com>
In-Reply-To: <20260421-mips-octeon-missing-insns-v2-v2-0-a0791df188c9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oo1-xc30.google.com
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

Decode the equality and inequality forms as explicit SEQ/SNE and
SEQI/SNEI instructions rather than using shared generated SEQNE/SEQNEI
entries.

The explicit decoder names match the architectural mnemonics, which
makes the translator entry points and trace/debug output easier to
correlate with the instruction set.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Split the SEQ/SNE decode cleanup out of the Octeon arithmetic
    instruction patch.  (suggested by Philippe Mathieu-Daudé)
---
 target/mips/tcg/octeon.decode      |  8 ++++++--
 target/mips/tcg/octeon_translate.c | 26 +++++++++++++++++++++++---
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 102a05860d..8a262feb1d 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -30,6 +30,8 @@ BBIT         11 set:1 . 10 rs:5 ..... offset:s16 p=%bbit_p
 # SNEI rt, rs, immediate
 
 @r3          ...... rs:5 rt:5 rd:5 ..... ......
+&cmp3        rs rt rd ne
+&cmpi        rs rt imm ne
 %bitfield_p  0:1 6:5
 @bitfield    ...... rs:5 rt:5 lenm1:5 ..... ..... . p=%bitfield_p
 
@@ -38,8 +40,10 @@ DMUL         011100 ..... ..... ..... 00000 000011 @r3
 EXTS         011100 ..... ..... ..... ..... 11101 . @bitfield
 CINS         011100 ..... ..... ..... ..... 11001 . @bitfield
 POP          011100 rs:5 00000 rd:5 00000 10110 dw:1
-SEQNE        011100 rs:5 rt:5 rd:5 00000 10101 ne:1
-SEQNEI       011100 rs:5 rt:5 imm:s10 10111 ne:1
+SEQ          011100 rs:5 rt:5 rd:5 00000 101010 &cmp3 ne=0
+SNE          011100 rs:5 rt:5 rd:5 00000 101011 &cmp3 ne=1
+SEQI         011100 rs:5 rt:5 imm:s10 101110 &cmpi ne=0
+SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi ne=1
 
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 41e0d770f5..fce01eb196 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -131,7 +131,7 @@ static bool trans_POP(DisasContext *ctx, arg_POP *a)
     return true;
 }
 
-static bool trans_SEQNE(DisasContext *ctx, arg_SEQNE *a)
+static bool trans_seqne(DisasContext *ctx, const arg_cmp3 *a)
 {
     TCGv t0, t1;
 
@@ -154,7 +154,17 @@ static bool trans_SEQNE(DisasContext *ctx, arg_SEQNE *a)
     return true;
 }
 
-static bool trans_SEQNEI(DisasContext *ctx, arg_SEQNEI *a)
+static bool trans_SEQ(DisasContext *ctx, arg_cmp3 *a)
+{
+    return trans_seqne(ctx, a);
+}
+
+static bool trans_SNE(DisasContext *ctx, arg_cmp3 *a)
+{
+    return trans_seqne(ctx, a);
+}
+
+static bool trans_seqnei(DisasContext *ctx, const arg_cmpi *a)
 {
     TCGv t0;
 
@@ -168,7 +178,7 @@ static bool trans_SEQNEI(DisasContext *ctx, arg_SEQNEI *a)
     gen_load_gpr(t0, a->rs);
 
     /* Sign-extend to 64 bit value */
-    target_ulong imm = a->imm;
+    int64_t imm = a->imm;
     if (a->ne) {
         tcg_gen_setcondi_tl(TCG_COND_NE, cpu_gpr[a->rt], t0, imm);
     } else {
@@ -177,6 +187,16 @@ static bool trans_SEQNEI(DisasContext *ctx, arg_SEQNEI *a)
     return true;
 }
 
+static bool trans_SEQI(DisasContext *ctx, arg_cmpi *a)
+{
+    return trans_seqnei(ctx, a);
+}
+
+static bool trans_SNEI(DisasContext *ctx, arg_cmpi *a)
+{
+    return trans_seqnei(ctx, a);
+}
+
 static bool trans_lx(DisasContext *ctx, arg_lx *a, MemOp mop)
 {
     gen_lx(ctx, a->rd, a->base, a->index, mop);

-- 
2.53.0


