Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD9AC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZIW-00013Q-SS; Fri, 07 Mar 2025 10:07:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIS-00010k-Po
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:32 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIQ-0008Jv-Sh
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:32 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-390effd3e85so1772573f8f.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 07:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741360049; x=1741964849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=saDmTi5qBVoivSppj4pMAPptghWgJB1RwsIGgVuCH9w=;
 b=xa6cvBcf72XiZXwn2004RbZmRnn2fp6RbDCQzLNp/uC9DAGuLGAVUZe8MzqX6gq5Hb
 s4nvJQ609Um4KfTIF7Ym3m3QkmelHVaCrFllMgzNIMEWuEB+/QhG8hBqmiNzS7jaBVe5
 dZoWAeFKoVJp2lwgcC+qpPnBIxOyju0iIFd0P7dt6yLp9y/+RjmZWwp0doDEPB9nwBjU
 1GR3MBI5lswZ3SkRiAVGaG4KyEBOsDMIiIlEtY54cJhsh6B21XDv5KDhXITdM44nG1GV
 DyP4oz9gcLFSAGskQnO66Qtqm+74EJgicvitocsvdYEquzmHooaqPj5N6zGNB8u4xTwz
 5azw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741360049; x=1741964849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=saDmTi5qBVoivSppj4pMAPptghWgJB1RwsIGgVuCH9w=;
 b=OR31881FQ0Q+OrztEDywNo7vm80vBpIa21kn75tCGSQYb0Sm/0vA4zijSG2E8BvWfX
 nK9q54ArJhHhjY+AaLxtTkiz2gMSPzWc1Npe0FrxFVSmWGWsbsdU3ABcVDN3Nv2UyoYQ
 wOfQeFFiflIzyjZ9OPDhqJIyhYrZBz8WJN8nNfdcCLYsDda9VbD0hUDQ7+e9i/6Y17Mx
 IlRFjrOpAsJTT8qfiR9pcuNKKc8GJeqr7qY0LNpa2hXgLhAdFhaGIRhX3+HRKtqPNvmY
 BJWsrwZKgMlZIWXgu3tEHTVqqnxmxfpjZNT3GOu+o8XkezRTGKe908MWOlcSZywKqh3Z
 ry3g==
X-Gm-Message-State: AOJu0YwAzpWd4bR/hiWKbqnyFob9qWCN2jw8/1+A4rfm8iSkxjNfHTqj
 uy4DCgTrx10TeNx5tyI3zr6IHO712iUZpnf5k4esD9oTGrV7GxbDljWDwtrdUz8me5/s1zSvv6a
 K
X-Gm-Gg: ASbGncs1q5e4Hm8nwABFtNvd9IUB83rNfD5bb0cbrALCX25YzrKqouRQwoDU2zp7uW8
 oHPmG0/IjoJASI/cPgs9u/pQaYP3up1jSzbgSQIQ5jxqYdQaBfDjFsk/SRhq4RzthCYR5MxRnrB
 /+HIM2pPcIOJItww/Vj4RUpXPnaq4uWUGCCNKK92i8H0wZsfk6oKDKwTVUIzMXzHJ2wx5JOwas1
 1g/dAtm2x1SgB+OsCeUdxfcBxJ/LTKARnwTM5J/Imf56poTosUAG4eDfLka3WHfZlgQ1KgGe3WK
 Cyi6vmZvzURdIZykPA1OIp6l8xrWKI1Jr9pfDC72/5VUcYoZz7g=
X-Google-Smtp-Source: AGHT+IG/DI/PzagIoXFn3Y3PbRQSRXOr1wjolRSuyFV8uAkKlJotoHN4YGPXT1zPPnXXUW7f17a4/g==
X-Received: by 2002:a05:6000:1862:b0:390:fe4b:70b9 with SMTP id
 ffacd0b85a97d-39132d6c5demr3031096f8f.21.1741360047696; 
 Fri, 07 Mar 2025 07:07:27 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c1031fdsm5443627f8f.89.2025.03.07.07.07.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 07:07:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/21] target/arm: Correct STRD atomicity
Date: Fri,  7 Mar 2025 15:07:01 +0000
Message-ID: <20250307150708.3222813-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307150708.3222813-1-peter.maydell@linaro.org>
References: <20250307150708.3222813-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

Our STRD implementation doesn't correctly implement the requirement:
 * if the address is 8-aligned the access must be a 64-bit
   single-copy atomic access, not two 32-bit accesses

Rewrite the handling of STRD to use a single tcg_gen_qemu_st_i64()
of a value produced by concatenating the two 32 bit source registers.
This allows us to get the atomicity right.

As with the LDRD change, now that we don't update 'addr' in the
course of performing the store we need to adjust the offset
we pass to op_addr_ri_post() and op_addr_rr_post().

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250227142746.1698904-3-peter.maydell@linaro.org
---
 target/arm/tcg/translate.c | 59 +++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 20 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 93772da39a4..404a254678a 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -5063,10 +5063,42 @@ static bool trans_LDRD_rr(DisasContext *s, arg_ldst_rr *a)
     return true;
 }
 
+static void do_strd_store(DisasContext *s, TCGv_i32 addr, int rt, int rt2)
+{
+    /*
+     * STRD is required to be an atomic 64-bit access if the
+     * address is 8-aligned, two atomic 32-bit accesses if
+     * it's only 4-aligned, and to give an alignment fault
+     * if it's not 4-aligned.
+     * Rt is always the word from the lower address, and Rt2 the
+     * data from the higher address, regardless of endianness.
+     * So (like gen_store_exclusive) we avoid gen_aa32_ld_i64()
+     * so we don't get its SCTLR_B check, and instead do a 64-bit access
+     * using MO_BE if appropriate, using a value constructed
+     * by putting the two halves together in the right order.
+     *
+     * As with LDRD, the 64-bit atomicity is not required for
+     * M-profile, or for A-profile before LPAE, and we provide
+     * the higher guarantee always for simplicity.
+     */
+    int mem_idx = get_mem_index(s);
+    MemOp opc = MO_64 | MO_ALIGN_4 | MO_ATOM_SUBALIGN | s->be_data;
+    TCGv taddr = gen_aa32_addr(s, addr, opc);
+    TCGv_i32 t1 = load_reg(s, rt);
+    TCGv_i32 t2 = load_reg(s, rt2);
+    TCGv_i64 t64 = tcg_temp_new_i64();
+
+    if (s->be_data == MO_BE) {
+        tcg_gen_concat_i32_i64(t64, t2, t1);
+    } else {
+        tcg_gen_concat_i32_i64(t64, t1, t2);
+    }
+    tcg_gen_qemu_st_i64(t64, taddr, mem_idx, opc);
+}
+
 static bool trans_STRD_rr(DisasContext *s, arg_ldst_rr *a)
 {
-    int mem_idx = get_mem_index(s);
-    TCGv_i32 addr, tmp;
+    TCGv_i32 addr;
 
     if (!ENABLE_ARCH_5TE) {
         return false;
@@ -5077,15 +5109,9 @@ static bool trans_STRD_rr(DisasContext *s, arg_ldst_rr *a)
     }
     addr = op_addr_rr_pre(s, a);
 
-    tmp = load_reg(s, a->rt);
-    gen_aa32_st_i32(s, tmp, addr, mem_idx, MO_UL | MO_ALIGN);
+    do_strd_store(s, addr, a->rt, a->rt + 1);
 
-    tcg_gen_addi_i32(addr, addr, 4);
-
-    tmp = load_reg(s, a->rt + 1);
-    gen_aa32_st_i32(s, tmp, addr, mem_idx, MO_UL | MO_ALIGN);
-
-    op_addr_rr_post(s, a, addr, -4);
+    op_addr_rr_post(s, a, addr, 0);
     return true;
 }
 
@@ -5213,20 +5239,13 @@ static bool trans_LDRD_ri_t32(DisasContext *s, arg_ldst_ri2 *a)
 
 static bool op_strd_ri(DisasContext *s, arg_ldst_ri *a, int rt2)
 {
-    int mem_idx = get_mem_index(s);
-    TCGv_i32 addr, tmp;
+    TCGv_i32 addr;
 
     addr = op_addr_ri_pre(s, a);
 
-    tmp = load_reg(s, a->rt);
-    gen_aa32_st_i32(s, tmp, addr, mem_idx, MO_UL | MO_ALIGN);
+    do_strd_store(s, addr, a->rt, rt2);
 
-    tcg_gen_addi_i32(addr, addr, 4);
-
-    tmp = load_reg(s, rt2);
-    gen_aa32_st_i32(s, tmp, addr, mem_idx, MO_UL | MO_ALIGN);
-
-    op_addr_ri_post(s, a, addr, -4);
+    op_addr_ri_post(s, a, addr, 0);
     return true;
 }
 
-- 
2.43.0


