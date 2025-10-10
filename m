Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5DBCCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 15:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7FOm-0003yL-SI; Fri, 10 Oct 2025 11:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7FOj-0003wd-3C
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:51:13 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7FOZ-0002CO-2j
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:51:12 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3fa528f127fso1672550f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 08:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760111452; x=1760716252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PbZf/4lXCFUtVLVqfehR/2skaY6PUFbfsiZG7sUkFCE=;
 b=OI55x86LqEo74Lu/CE1hVZ51R54tFwIUBxO+GMplWQHwoCrrJ7iPtT4i2DHSKWEN7W
 k1BzY0YHf5oDV4UcEtnJBUb+d8GCRDrNeHq8Khg0Z/uUo7GTnCBJ9gGcvt/RiZL89RBi
 9C9WbaG6mhDXq+pznqj3+13GQeGO+X+C+8FFckx/6iiRT4/JNkxbrjZ34R9M3sb/91R1
 aXZR5mEOqb1EKVmQmFISWZPn1/um30aSwrwpzdE3OnDVyzyaQA59oEdaaAjzAyj6SGFC
 8xiXZtJhwwlk4odO1qSqcMLEzSegeEjKSmKPe6MVFTDS6j8r0sBGVsS/NPXpIwDfcvLj
 S2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760111452; x=1760716252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PbZf/4lXCFUtVLVqfehR/2skaY6PUFbfsiZG7sUkFCE=;
 b=AtcVeRKkE8BsJhRDSt30FAzHqJV/nR7pJTRINykeHc3SUWFa6pg0Ok3UKXoAoONX/x
 Ncts6isTy8/QRD5u2DUb0P31cp8qpeUr9NBELTGZ+k2eDYuj8EOguw8IjoIvJIw3oBTL
 177v16UgVbDC1vIO/VPIwPQNO7DjrQzO2qaL9jYBZMgLyKxnSCvzc/144sp6Vp9j9Knm
 XtV4FhZqVJNya5pOhet2TmWEnMvWzXfHTzg+xRp7GfA+3b6calJPvFY4pDh/jQdidssD
 tTmDlBb0odFxU/o0Vlexj40DPzSx2XNZc9qsX58LI9JLfKDpEhQ+pBigU/aZWT+7b/IM
 AJYQ==
X-Gm-Message-State: AOJu0Yz58aIJcVofbTrhfuQu2A4SKVLiNja5OXwE6R5BQitbLG7a2AOV
 2fvTJDwUl0aPQsVbZ+/jwZfvBBZigqKPMCZFJ5D1IMNRwlKWuf2lwAoOV/tJ/YJHoFaxL4i4kXF
 7knlK7HXqig==
X-Gm-Gg: ASbGnctgBwTotjyUcfkTG+NRVg1cSIHBZIQTb5ES1M+wUKdTVE2YWabti254jbpV/cS
 JgWXbqIe+AEJMToyJjQGLaqSmVLhGJ00RgngEJ0A4QiTzFzAxR7184q1xgmvbLWZINw4j26VZA7
 Ial0gG/tpoWAR7TgJ7By0h6AjX11r2lgWyoTDZJ0hvbwIysvDb8eoZJASYFrpel6tJvo/Qw0gBj
 lScVND8L5GLEQbHV9QlEB6tlvUjcvmnqlIhT9EkAsim2CqlcKQGet5CvRcXor86dmcq5FUkoIE2
 RR53XvrQd8UtsHkeYiTUQeTtUPV0QBRBnybMGGfV9RWGSOO2LW0Ht9nSRRLVIfVbe2L8L0onahS
 12+WRZvgfCF89Z412EMZ6crFcxx5utjlEB885qcUrOJN112J/UJT9y2mxeLHbl5/Szj3fgkAyOd
 AmHB4P2wEwTKDlkUop0BQ=
X-Google-Smtp-Source: AGHT+IFec6tJzjkxLlLlFEt9D93P56h780sUOKmKiYIRaBVsCLtJOjjOVVGcddk5slz4ufCRS09q2Q==
X-Received: by 2002:a5d:588c:0:b0:3f4:5bda:2710 with SMTP id
 ffacd0b85a97d-425829b0578mr10312452f8f.9.1760111452485; 
 Fri, 10 Oct 2025 08:50:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb55ac08dsm45452255e9.13.2025.10.10.08.50.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Oct 2025 08:50:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Christoph Muellner <christoph.muellner@vrull.eu>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Valentin Haudiquet <valentin.haudiquet@canonical.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabien Portas <fabien.portas@grenoble-inp.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
Subject: [PATCH 01/13] target/riscv: Really use little endianness for 128-bit
 loads/stores
Date: Fri, 10 Oct 2025 17:50:32 +0200
Message-ID: <20251010155045.78220-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010155045.78220-1-philmd@linaro.org>
References: <20251010155045.78220-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Per commit a2f827ff4f4 ("target/riscv: accessors to registers upper
part and 128-bit load/store") description:

 > The 128-bit ISA adds ldu, lq and sq. We provide support for these
 > instructions. Note that (a) we compute only 64-bit addresses to
 > actually access memory, cowardly utilizing the existing address
 > translation mechanism of QEMU, and (b) we assume for now
 > little-endian memory accesses.

   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

However this commit used MO_TE (target endianness) for the
gen_load_i128() and gen_store_i128() helpers. Likely it was
unnoticed because current targets are only built using little
endianness:

  $ git grep -L TARGET_BIG_ENDIAN=y configs/targets/riscv*
  configs/targets/riscv32-linux-user.mak
  configs/targets/riscv32-softmmu.mak
  configs/targets/riscv64-bsd-user.mak
  configs/targets/riscv64-linux-user.mak
  configs/targets/riscv64-softmmu.mak

Replace by MO_TE -> MO_LE to really use little endianness.

Cc: Fabien Portas <fabien.portas@grenoble-inp.org>
Cc: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
Fixes: a2f827ff4f4 ("target/riscv: accessors to registers upper part and 128-bit load/store")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/insn_trans/trans_rvi.c.inc | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index b9c71604687..df0b555176a 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -389,9 +389,11 @@ static bool gen_load_i128(DisasContext *ctx, arg_lb *a, MemOp memop)
         }
     } else {
         /* assume little-endian memory access for now */
-        tcg_gen_qemu_ld_tl(destl, addrl, ctx->mem_idx, MO_TEUQ);
+        MemOp memop = MO_LEUQ;
+
+        tcg_gen_qemu_ld_tl(destl, addrl, ctx->mem_idx, memop);
         tcg_gen_addi_tl(addrl, addrl, 8);
-        tcg_gen_qemu_ld_tl(desth, addrl, ctx->mem_idx, MO_TEUQ);
+        tcg_gen_qemu_ld_tl(desth, addrl, ctx->mem_idx, memop);
     }
 
     gen_set_gpr128(ctx, a->rd, destl, desth);
@@ -494,9 +496,11 @@ static bool gen_store_i128(DisasContext *ctx, arg_sb *a, MemOp memop)
         tcg_gen_qemu_st_tl(src2l, addrl, ctx->mem_idx, memop);
     } else {
         /* little-endian memory access assumed for now */
-        tcg_gen_qemu_st_tl(src2l, addrl, ctx->mem_idx, MO_TEUQ);
+        MemOp memop = MO_LEUQ;
+
+        tcg_gen_qemu_st_tl(src2l, addrl, ctx->mem_idx, memop);
         tcg_gen_addi_tl(addrl, addrl, 8);
-        tcg_gen_qemu_st_tl(src2h, addrl, ctx->mem_idx, MO_TEUQ);
+        tcg_gen_qemu_st_tl(src2h, addrl, ctx->mem_idx, memop);
     }
     return true;
 }
-- 
2.51.0


