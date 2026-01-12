Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31248CF45D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:53:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQm1-0003LC-6P; Mon, 12 Jan 2026 17:52:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQlm-0002r0-53
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:52:20 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQlj-0003CV-9P
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:52:17 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so47503815e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258332; x=1768863132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HXnDGnM4F4GWWrI+WXkDyeFYrvN63k8fphpbNjR0dkk=;
 b=tsKSVj3LV6V4ywPldARXXfRvXY0ykcGm0JXKFRlwgdLYVNml4LQNdTiJB5ebsU3Ytb
 NkaQsbe6gcrtApy0zb7p/WA7jVUmnoLejkK/WuUxw8yxrB1yO4sQg5491cRRjl+KeJje
 TBD2s63vT9/JGqeM4OmHvLGAYI6fN7arAzNpVNhsYrsZpKSQUnXFuMc3BtFRxBgxNNC9
 28wuXqDR5QosepjQp0AgtEqWxQ44oCovGGs07F8sbp5aXi5FGWrHOxIUh9Qi1TVuhPzE
 hrHlYlab75XCBCSdAeqeq3x+Xrnj/HY9jiZnuOn5o2dH5syVi9acoBOJjYjcAoKJQS2Y
 WI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258332; x=1768863132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HXnDGnM4F4GWWrI+WXkDyeFYrvN63k8fphpbNjR0dkk=;
 b=FlSuk2RXQ+qgtEyhZ5QtgjzNGuIJfuZ9hWtd2ay00iE+9URTy0lrHfnIHLBQs+++ox
 VmISCICevSF+2pu5DcKYh5rQ61gH/8Nvp46luMr1W8LL3TragwLY0OCBqU64yZoctsrd
 OoJyPDKmzL+IJ+PHx0g7P0U2NjLmUJh6MBKJ73uXJPR7EzWWYi2ycm2TK2MWIfTv5S0S
 mBWAcUHLHixxk0fF12cuL1oW7spAh3c3o+eT6VsRzBa0yt+TxcsnwN5JkpoeXlj4MRRY
 Lyn2aF47JpeIXpQCyB/QTzeS4UQ2zpY999Q/jcF0qNlDzvRQgkYrY7OSQ/cQj0JjzTqB
 7PoQ==
X-Gm-Message-State: AOJu0YwNY3a7WS5vEnEdZ2CkicA4p4LCI8w/oPOTUkMTorEwCW/W4uHG
 +kXwvPwCB1KvyPKCTfr2yn0tO2zRPz1SWJnLjfK0Ba8X3cahS6pQ7Mu19jLvZDzX9qjLvNLFg2O
 uzc7lpOY=
X-Gm-Gg: AY/fxX6b+1Yg32RkpTCCAsHenEID+HA7bD8m8bWf1YjeUpzTFbfBvQvTtEHTmF+1DqG
 qLAV+WhF6mZos3vATecF1reXuJUyd3WPACh0QJX4tSo0oSNJCsi2uhBpJh0ql5mcH336rix9eUA
 T01invSu5HPJVpp/tSS/6WvUaCMKV7fC3kX9viletSywlzIUbHN3ZWsS7VaLNMLmB2OEF854rZH
 UVnWUAlNz+2fm77lSWLt9cMccwh0gb16wrhj8qunPvxV3alhDpqtGj+pTaJ/aDjNUqR6jAr4ztA
 uPtv5eizHmteFs5wtD84GcgJ9Vgjwy+bSdDZ5rqOcng/i3Q7qXkKRiQ9sjXfWxNxJF5DK/bji9W
 RP6XoUDYdo0F1tvCoPmVcZcUhXTpABG1iUIr6WsQMoMTzGLy7M57L+O0X4/W3Hv3nGGQATj7EzB
 jaINg0NREhsf7o0PVxa8K8qFCjR/8qMgqYAXOBfyrxpplEANUhWZnHoRb4cCn/hPzg+PJnZNE=
X-Google-Smtp-Source: AGHT+IF07h6ns0pW4hjQ6M95bIwqrrotuPKczjaARiePyd0fgWCOkwmyajoPyUieI6KwDDO8XbGp4A==
X-Received: by 2002:a05:600c:a04:b0:47d:5dae:73b1 with SMTP id
 5b1f17b1804b1-47d84b3b668mr249556435e9.23.1768258331842; 
 Mon, 12 Jan 2026 14:52:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f390a69sm370666305e9.0.2026.01.12.14.52.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:52:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/61] target/loongarch: Replace MO_TE -> MO_LE
Date: Mon, 12 Jan 2026 23:48:23 +0100
Message-ID: <20260112224857.42068-29-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

We only build the LoongArch target using little endianness
order, therefore the MO_TE definitions expand to the little
endian one. Use the latter which is more explicit.

Mechanical change running:

  $ sed -i -e s/MO_TE/MO_LE/ \
        $(git grep -wl MO_TE target/loongarch/)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Message-ID: <20251224161456.89707-5-philmd@linaro.org>
---
 .../tcg/insn_trans/trans_atomic.c.inc         | 80 +++++++++----------
 .../tcg/insn_trans/trans_fmemory.c.inc        | 32 ++++----
 .../tcg/insn_trans/trans_memory.c.inc         | 64 +++++++--------
 .../loongarch/tcg/insn_trans/trans_vec.c.inc  | 16 ++--
 4 files changed, 96 insertions(+), 96 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
index 77eeedbc42b..a1de389e51b 100644
--- a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
@@ -69,43 +69,43 @@ static bool gen_am(DisasContext *ctx, arg_rrr *a,
     return true;
 }
 
-TRANS(ll_w, ALL, gen_ll, MO_TESL)
-TRANS(sc_w, ALL, gen_sc, MO_TESL)
-TRANS(ll_d, 64, gen_ll, MO_TEUQ)
-TRANS(sc_d, 64, gen_sc, MO_TEUQ)
-TRANS(amswap_w, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TESL)
-TRANS64(amswap_d, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
-TRANS(amadd_w, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESL)
-TRANS64(amadd_d, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
-TRANS(amand_w, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TESL)
-TRANS64(amand_d, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
-TRANS(amor_w, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TESL)
-TRANS64(amor_d, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
-TRANS(amxor_w, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TESL)
-TRANS64(amxor_d, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
-TRANS(ammax_w, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TESL)
-TRANS64(ammax_d, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ)
-TRANS(ammin_w, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TESL)
-TRANS64(ammin_d, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ)
-TRANS(ammax_wu, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TESL)
-TRANS64(ammax_du, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEUQ)
-TRANS(ammin_wu, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TESL)
-TRANS64(ammin_du, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEUQ)
-TRANS(amswap_db_w, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TESL)
-TRANS64(amswap_db_d, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
-TRANS(amadd_db_w, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESL)
-TRANS64(amadd_db_d, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
-TRANS(amand_db_w, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TESL)
-TRANS64(amand_db_d, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
-TRANS(amor_db_w, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TESL)
-TRANS64(amor_db_d, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
-TRANS(amxor_db_w, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TESL)
-TRANS64(amxor_db_d, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
-TRANS(ammax_db_w, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TESL)
-TRANS64(ammax_db_d, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ)
-TRANS(ammin_db_w, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TESL)
-TRANS64(ammin_db_d, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ)
-TRANS(ammax_db_wu, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TESL)
-TRANS64(ammax_db_du, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEUQ)
-TRANS(ammin_db_wu, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TESL)
-TRANS64(ammin_db_du, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEUQ)
+TRANS(ll_w, ALL, gen_ll, MO_LESL)
+TRANS(sc_w, ALL, gen_sc, MO_LESL)
+TRANS(ll_d, 64, gen_ll, MO_LEUQ)
+TRANS(sc_d, 64, gen_sc, MO_LEUQ)
+TRANS(amswap_w, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_LESL)
+TRANS64(amswap_d, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_LEUQ)
+TRANS(amadd_w, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_LESL)
+TRANS64(amadd_d, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_LEUQ)
+TRANS(amand_w, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_LESL)
+TRANS64(amand_d, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_LEUQ)
+TRANS(amor_w, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_LESL)
+TRANS64(amor_d, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_LEUQ)
+TRANS(amxor_w, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_LESL)
+TRANS64(amxor_d, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_LEUQ)
+TRANS(ammax_w, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_LESL)
+TRANS64(ammax_d, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_LEUQ)
+TRANS(ammin_w, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_LESL)
+TRANS64(ammin_d, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_LEUQ)
+TRANS(ammax_wu, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_LESL)
+TRANS64(ammax_du, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_LEUQ)
+TRANS(ammin_wu, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_LESL)
+TRANS64(ammin_du, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_LEUQ)
+TRANS(amswap_db_w, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_LESL)
+TRANS64(amswap_db_d, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_LEUQ)
+TRANS(amadd_db_w, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_LESL)
+TRANS64(amadd_db_d, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_LEUQ)
+TRANS(amand_db_w, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_LESL)
+TRANS64(amand_db_d, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_LEUQ)
+TRANS(amor_db_w, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_LESL)
+TRANS64(amor_db_d, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_LEUQ)
+TRANS(amxor_db_w, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_LESL)
+TRANS64(amxor_db_d, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_LEUQ)
+TRANS(ammax_db_w, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_LESL)
+TRANS64(ammax_db_d, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_LEUQ)
+TRANS(ammin_db_w, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_LESL)
+TRANS64(ammin_db_d, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_LEUQ)
+TRANS(ammax_db_wu, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_LESL)
+TRANS64(ammax_db_du, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_LEUQ)
+TRANS(ammin_db_wu, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_LESL)
+TRANS64(ammin_db_du, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_LEUQ)
diff --git a/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc b/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc
index 79da4718a56..b863ba1dc21 100644
--- a/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc
@@ -140,19 +140,19 @@ static bool gen_fstore_le(DisasContext *ctx, arg_frr *a, MemOp mop)
     return true;
 }
 
-TRANS(fld_s, FP_SP, gen_fload_i, MO_TEUL)
-TRANS(fst_s, FP_SP, gen_fstore_i, MO_TEUL)
-TRANS(fld_d, FP_DP, gen_fload_i, MO_TEUQ)
-TRANS(fst_d, FP_DP, gen_fstore_i, MO_TEUQ)
-TRANS(fldx_s, FP_SP, gen_floadx, MO_TEUL)
-TRANS(fldx_d, FP_DP, gen_floadx, MO_TEUQ)
-TRANS(fstx_s, FP_SP, gen_fstorex, MO_TEUL)
-TRANS(fstx_d, FP_DP, gen_fstorex, MO_TEUQ)
-TRANS64(fldgt_s, FP_SP, gen_fload_gt, MO_TEUL)
-TRANS64(fldgt_d, FP_DP, gen_fload_gt, MO_TEUQ)
-TRANS64(fldle_s, FP_SP, gen_fload_le, MO_TEUL)
-TRANS64(fldle_d, FP_DP, gen_fload_le, MO_TEUQ)
-TRANS64(fstgt_s, FP_SP, gen_fstore_gt, MO_TEUL)
-TRANS64(fstgt_d, FP_DP, gen_fstore_gt, MO_TEUQ)
-TRANS64(fstle_s, FP_SP, gen_fstore_le, MO_TEUL)
-TRANS64(fstle_d, FP_DP, gen_fstore_le, MO_TEUQ)
+TRANS(fld_s, FP_SP, gen_fload_i, MO_LEUL)
+TRANS(fst_s, FP_SP, gen_fstore_i, MO_LEUL)
+TRANS(fld_d, FP_DP, gen_fload_i, MO_LEUQ)
+TRANS(fst_d, FP_DP, gen_fstore_i, MO_LEUQ)
+TRANS(fldx_s, FP_SP, gen_floadx, MO_LEUL)
+TRANS(fldx_d, FP_DP, gen_floadx, MO_LEUQ)
+TRANS(fstx_s, FP_SP, gen_fstorex, MO_LEUL)
+TRANS(fstx_d, FP_DP, gen_fstorex, MO_LEUQ)
+TRANS64(fldgt_s, FP_SP, gen_fload_gt, MO_LEUL)
+TRANS64(fldgt_d, FP_DP, gen_fload_gt, MO_LEUQ)
+TRANS64(fldle_s, FP_SP, gen_fload_le, MO_LEUL)
+TRANS64(fldle_d, FP_DP, gen_fload_le, MO_LEUQ)
+TRANS64(fstgt_s, FP_SP, gen_fstore_gt, MO_LEUL)
+TRANS64(fstgt_d, FP_DP, gen_fstore_gt, MO_LEUQ)
+TRANS64(fstle_s, FP_SP, gen_fstore_le, MO_LEUL)
+TRANS64(fstle_d, FP_DP, gen_fstore_le, MO_LEUQ)
diff --git a/target/loongarch/tcg/insn_trans/trans_memory.c.inc b/target/loongarch/tcg/insn_trans/trans_memory.c.inc
index 42f4e740126..90bb0815ff3 100644
--- a/target/loongarch/tcg/insn_trans/trans_memory.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_memory.c.inc
@@ -151,44 +151,44 @@ static bool gen_stptr(DisasContext *ctx, arg_rr_i *a, MemOp mop)
 }
 
 TRANS(ld_b, ALL, gen_load, MO_SB)
-TRANS(ld_h, ALL, gen_load, MO_TESW)
-TRANS(ld_w, ALL, gen_load, MO_TESL)
-TRANS(ld_d, 64, gen_load, MO_TEUQ)
+TRANS(ld_h, ALL, gen_load, MO_LESW)
+TRANS(ld_w, ALL, gen_load, MO_LESL)
+TRANS(ld_d, 64, gen_load, MO_LEUQ)
 TRANS(st_b, ALL, gen_store, MO_UB)
-TRANS(st_h, ALL, gen_store, MO_TEUW)
-TRANS(st_w, ALL, gen_store, MO_TEUL)
-TRANS(st_d, 64, gen_store, MO_TEUQ)
+TRANS(st_h, ALL, gen_store, MO_LEUW)
+TRANS(st_w, ALL, gen_store, MO_LEUL)
+TRANS(st_d, 64, gen_store, MO_LEUQ)
 TRANS(ld_bu, ALL, gen_load, MO_UB)
-TRANS(ld_hu, ALL, gen_load, MO_TEUW)
-TRANS(ld_wu, 64, gen_load, MO_TEUL)
+TRANS(ld_hu, ALL, gen_load, MO_LEUW)
+TRANS(ld_wu, 64, gen_load, MO_LEUL)
 TRANS(ldx_b, 64, gen_loadx, MO_SB)
-TRANS(ldx_h, 64, gen_loadx, MO_TESW)
-TRANS(ldx_w, 64, gen_loadx, MO_TESL)
-TRANS(ldx_d, 64, gen_loadx, MO_TEUQ)
+TRANS(ldx_h, 64, gen_loadx, MO_LESW)
+TRANS(ldx_w, 64, gen_loadx, MO_LESL)
+TRANS(ldx_d, 64, gen_loadx, MO_LEUQ)
 TRANS(stx_b, 64, gen_storex, MO_UB)
-TRANS(stx_h, 64, gen_storex, MO_TEUW)
-TRANS(stx_w, 64, gen_storex, MO_TEUL)
-TRANS(stx_d, 64, gen_storex, MO_TEUQ)
+TRANS(stx_h, 64, gen_storex, MO_LEUW)
+TRANS(stx_w, 64, gen_storex, MO_LEUL)
+TRANS(stx_d, 64, gen_storex, MO_LEUQ)
 TRANS(ldx_bu, 64, gen_loadx, MO_UB)
-TRANS(ldx_hu, 64, gen_loadx, MO_TEUW)
-TRANS(ldx_wu, 64, gen_loadx, MO_TEUL)
-TRANS(ldptr_w, 64, gen_ldptr, MO_TESL)
-TRANS(stptr_w, 64, gen_stptr, MO_TEUL)
-TRANS(ldptr_d, 64, gen_ldptr, MO_TEUQ)
-TRANS(stptr_d, 64, gen_stptr, MO_TEUQ)
+TRANS(ldx_hu, 64, gen_loadx, MO_LEUW)
+TRANS(ldx_wu, 64, gen_loadx, MO_LEUL)
+TRANS(ldptr_w, 64, gen_ldptr, MO_LESL)
+TRANS(stptr_w, 64, gen_stptr, MO_LEUL)
+TRANS(ldptr_d, 64, gen_ldptr, MO_LEUQ)
+TRANS(stptr_d, 64, gen_stptr, MO_LEUQ)
 TRANS(ldgt_b, 64, gen_load_gt, MO_SB)
-TRANS(ldgt_h, 64, gen_load_gt, MO_TESW)
-TRANS(ldgt_w, 64, gen_load_gt, MO_TESL)
-TRANS(ldgt_d, 64, gen_load_gt, MO_TEUQ)
+TRANS(ldgt_h, 64, gen_load_gt, MO_LESW)
+TRANS(ldgt_w, 64, gen_load_gt, MO_LESL)
+TRANS(ldgt_d, 64, gen_load_gt, MO_LEUQ)
 TRANS(ldle_b, 64, gen_load_le, MO_SB)
-TRANS(ldle_h, 64, gen_load_le, MO_TESW)
-TRANS(ldle_w, 64, gen_load_le, MO_TESL)
-TRANS(ldle_d, 64, gen_load_le, MO_TEUQ)
+TRANS(ldle_h, 64, gen_load_le, MO_LESW)
+TRANS(ldle_w, 64, gen_load_le, MO_LESL)
+TRANS(ldle_d, 64, gen_load_le, MO_LEUQ)
 TRANS(stgt_b, 64, gen_store_gt, MO_UB)
-TRANS(stgt_h, 64, gen_store_gt, MO_TEUW)
-TRANS(stgt_w, 64, gen_store_gt, MO_TEUL)
-TRANS(stgt_d, 64, gen_store_gt, MO_TEUQ)
+TRANS(stgt_h, 64, gen_store_gt, MO_LEUW)
+TRANS(stgt_w, 64, gen_store_gt, MO_LEUL)
+TRANS(stgt_d, 64, gen_store_gt, MO_LEUQ)
 TRANS(stle_b, 64, gen_store_le, MO_UB)
-TRANS(stle_h, 64, gen_store_le, MO_TEUW)
-TRANS(stle_w, 64, gen_store_le, MO_TEUL)
-TRANS(stle_d, 64, gen_store_le, MO_TEUQ)
+TRANS(stle_h, 64, gen_store_le, MO_LEUW)
+TRANS(stle_w, 64, gen_store_le, MO_LEUL)
+TRANS(stle_d, 64, gen_store_le, MO_LEUQ)
diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
index 38bccf28386..ea7e705bab4 100644
--- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
@@ -5279,7 +5279,7 @@ static bool trans_vld(DisasContext *ctx, arg_vr_i *a)
 
     addr = make_address_i(ctx, addr, a->imm);
 
-    tcg_gen_qemu_ld_i128(val, addr, ctx->mem_idx, MO_128 | MO_TE);
+    tcg_gen_qemu_ld_i128(val, addr, ctx->mem_idx, MO_128 | MO_LE);
     tcg_gen_extr_i128_i64(rl, rh, val);
     set_vreg64(rh, a->vd, 1);
     set_vreg64(rl, a->vd, 0);
@@ -5311,7 +5311,7 @@ static bool trans_vst(DisasContext *ctx, arg_vr_i *a)
     get_vreg64(ah, a->vd, 1);
     get_vreg64(al, a->vd, 0);
     tcg_gen_concat_i64_i128(val, al, ah);
-    tcg_gen_qemu_st_i128(val, addr, ctx->mem_idx, MO_128 | MO_TE);
+    tcg_gen_qemu_st_i128(val, addr, ctx->mem_idx, MO_128 | MO_LE);
 
     return true;
 }
@@ -5337,7 +5337,7 @@ static bool trans_vldx(DisasContext *ctx, arg_vrr *a)
     rh = tcg_temp_new_i64();
 
     addr = make_address_x(ctx, src1, src2);
-    tcg_gen_qemu_ld_i128(val, addr, ctx->mem_idx, MO_128 | MO_TE);
+    tcg_gen_qemu_ld_i128(val, addr, ctx->mem_idx, MO_128 | MO_LE);
     tcg_gen_extr_i128_i64(rl, rh, val);
     set_vreg64(rh, a->vd, 1);
     set_vreg64(rl, a->vd, 0);
@@ -5369,7 +5369,7 @@ static bool trans_vstx(DisasContext *ctx, arg_vrr *a)
     get_vreg64(ah, a->vd, 1);
     get_vreg64(al, a->vd, 0);
     tcg_gen_concat_i64_i128(val, al, ah);
-    tcg_gen_qemu_st_i128(val, addr, ctx->mem_idx, MO_128 | MO_TE);
+    tcg_gen_qemu_st_i128(val, addr, ctx->mem_idx, MO_128 | MO_LE);
 
     return true;
 }
@@ -5478,12 +5478,12 @@ static void gen_xvld(DisasContext *ctx, int vreg, TCGv addr)
     TCGv temp = tcg_temp_new();
     TCGv dest = tcg_temp_new();
 
-    tcg_gen_qemu_ld_i64(dest, addr, ctx->mem_idx, MO_TEUQ);
+    tcg_gen_qemu_ld_i64(dest, addr, ctx->mem_idx, MO_LEUQ);
     set_vreg64(dest, vreg, 0);
 
     for (i = 1; i < 4; i++) {
         tcg_gen_addi_tl(temp, addr, 8 * i);
-        tcg_gen_qemu_ld_i64(dest, temp, ctx->mem_idx, MO_TEUQ);
+        tcg_gen_qemu_ld_i64(dest, temp, ctx->mem_idx, MO_LEUQ);
         set_vreg64(dest, vreg, i);
     }
 }
@@ -5495,12 +5495,12 @@ static void gen_xvst(DisasContext * ctx, int vreg, TCGv addr)
     TCGv dest = tcg_temp_new();
 
     get_vreg64(dest, vreg, 0);
-    tcg_gen_qemu_st_i64(dest, addr, ctx->mem_idx, MO_TEUQ);
+    tcg_gen_qemu_st_i64(dest, addr, ctx->mem_idx, MO_LEUQ);
 
     for (i = 1; i < 4; i++) {
         tcg_gen_addi_tl(temp, addr, 8 * i);
         get_vreg64(dest, vreg, i);
-        tcg_gen_qemu_st_i64(dest, temp, ctx->mem_idx, MO_TEUQ);
+        tcg_gen_qemu_st_i64(dest, temp, ctx->mem_idx, MO_LEUQ);
     }
 }
 
-- 
2.52.0


