Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B57CD5BAB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmYv-0003gw-IU; Wed, 20 May 2026 15:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmYr-0003O8-VP
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:26:34 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmYp-0002er-SG
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:26:33 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48e82c23840so43136915e9.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779305190; x=1779909990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JYV/kaaC7k38g6qL5qazYDyJyJKp/5xNFedOOo711+k=;
 b=i1K9lUZCqKkE+xBzGBhCegy++DY+ndS4WuUVqc7wZ4MEaVr3a6h/0vXSDsGgUz0t5+
 k1pknzITrMdCMf4fr43+Vd/Hz1si6KO+pG4/3ASudSY68+EyXM8hv/KEqxqbiNWCRgjK
 OSBEo4ilceVMUlWCadKyns6RGC2+OmoWi4MFom5sQ7TD2gd3CEtoSc+jtpuH1zGNv+aq
 TerI29M3uLYjodWX3+ZWAXNT1WFbz64cCuylabCvF1yGGi3GaaONTMJn0dZFetJIbJ8w
 Vy/GljcsDnw7H9JMlrJ9ZdfA4HwPwEHc9oyGt80r3kTnr8gHX3voCES1ZkMjqu9YLuRw
 AI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305190; x=1779909990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JYV/kaaC7k38g6qL5qazYDyJyJKp/5xNFedOOo711+k=;
 b=CPqNc3qyvVTIAC1rS8i8DeUARRUPzYUf14PPHP/rt/ORUKszBS7yOh7YUxeCzMvECB
 R3kTHMXvtKinw1MM3+jNzn2M7h5l68LfBrj+Vb+7/c85+rHAWyo+USh72xN2An7LsW15
 Vc79D3kQFsG2b5hVuUbQjy7T/sW6+h4t0nEFxoY3AfIJxAIRebJScPTCZ4HU6TGjTpYO
 HrgsQj0G2Nmr08rXgHcO4lFCoYbLL2QKkEl5YZcMNV/ZPbSRtv/q+xBpVppdvdrlNOIf
 GtxNCaJRdvCWJcTxlT5UhkVXwWOUCrplMWAypUoKc6+XRXJLELqtiE23jfvf68JV+gVv
 1BfQ==
X-Gm-Message-State: AOJu0YyR84mpSAKSDo2FVs/mK8xKHoK8pCcR/e9cT3ERPuKUkbxtaneS
 0ICJWzNnwAtMWpO0rcWBimRbQZg8VVaUwpZAFguICtUmb4UEQ97hIZYCbmI2vU9/Bnj2Rf3NI28
 L5tH7Wbo=
X-Gm-Gg: Acq92OFmlPq6UA6DCHL7FTv3OAfYwL3xlbfe3AtUsj1w4d3bZytt8TCeyWaH5tk4pwx
 T1qq4Op62mCmA51OtDNCw2R7laO/T72Xhi8qZxCDfm35ASALxzYZle89l1yqZmpnhXntV+KTj6l
 +Rwe+SxMJrXjE5ER6raDXGYjIdUuMtBgF0JwlEel36BBdLY+OMCI1xEg8Tp8RvT3u0nzYIipib6
 4IZKph96Fo4CVZJC8gpS4jCPFGyKyt7RQMIC4N2h9t5yDuDyInHiRUyS5kCGXQ9q6Q3nmuqF2rj
 GY4p9moi0t6yl5TEvJ0to6Nx5dtQlgI0au8PzLtGhdSjL3ekqt5RvR2NgtE1WGKvspyQ6Ax/VOJ
 PDxYgyq2UNgPstXIZSLbxezYD6pobeeHPwVOfMsM4+hrnkUrvguQ0QatnY3/tcTtQoLwkHqYLCC
 7FFAuiuyGO0jLBe0argIEvpW6YJH5n8zyDH2L227TYkmCKDi2zPZ8AZhTrJHsUgTZ48wvYe7Eu
X-Received: by 2002:a05:600c:35c6:b0:48f:dfe3:dae4 with SMTP id
 5b1f17b1804b1-48fe60e9f8cmr432622935e9.13.1779305189911; 
 Wed, 20 May 2026 12:26:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d5987esm11252755e9.12.2026.05.20.12.26.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 12:26:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/33] target/mips: add Octeon ZCB and ZCBT instructions
Date: Wed, 20 May 2026 21:23:29 +0200
Message-ID: <20260520192338.40036-25-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520192338.40036-1-philmd@linaro.org>
References: <20260520192338.40036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

ZCB zeros the 128-byte cache block containing the base address. ZCBT has
the same user-mode-visible memory effect for QEMU purposes.

Model both forms with a single decodetree wildcard entry, align the
address down to a 128-byte line, and store eight zero 128-bit chunks to
guest memory.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20260520172313.23777-16-philmd@linaro.org>
---
 target/mips/tcg/octeon.decode      |  3 +++
 target/mips/tcg/octeon_translate.c | 25 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index d77717cd507..01ed3b50beb 100644
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
index 23748695a14..5392fed08a8 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -184,3 +184,28 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
 
 TRANS(SAA,  trans_saa, MO_32);
 TRANS(SAAD, trans_saa, MO_64);
+
+static bool trans_ZCB(DisasContext *ctx, arg_ZCB *a)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 line = tcg_temp_new_i64();
+    TCGv_i128 zero128 = tcg_zero_i128();
+    const MemOp mop = mo_endian(ctx) | MO_128 | MO_ATOM_NONE;
+
+    gen_base_offset_addr(ctx, addr, a->base, 0);
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
-- 
2.53.0


