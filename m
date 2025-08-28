Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DE9C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urau5-0003Mw-Hy; Thu, 28 Aug 2025 07:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urau2-0003K6-Dv
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:50 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uratz-0005jg-UP
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:50 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45b49f7aaf5so4645845e9.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 04:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756380886; x=1756985686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=p4G7w0pai8M2Z8EIlVyV0BgZ+1hlYNheGkiwdpE2My4=;
 b=uDDfad2kxXSEw3KSoF8QqoBKCuZ760lpGqa+3HU+isiza4h1y5LQas0Cvf1Z8MupcV
 1vUcqiiyYFsWeiU0my1xzeIkLRTRjoSXWZjqINg8qYwjTDvuj9jEqA7liOt0JksI5MOH
 JkI3QmFNiZP4LA63LYErlH1RVvgEkJ0nI5Bsm8ukLQOL/ZSq07bOpj/OX2w1bnLy4gz3
 lbzhzYIJ7lZlEGGlQz2FPx8sDZiBZCHHa7pCgilr8A1P1sFzUVL8pRXnWpRW8djeQ0Vn
 a4mRWTa1HnW3AFXOAInuiJ3GCDJN9a8idzWfW8CS5+7xMMYvxJLm37letR2lfceB4zbA
 i8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756380886; x=1756985686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p4G7w0pai8M2Z8EIlVyV0BgZ+1hlYNheGkiwdpE2My4=;
 b=XiWdA9Qp4wJYUzVxbPKYo+sSJTZI9EVGWcKMx0qlwThvxtaUs1qiitOJydqZ7UaDP5
 7RtifSVia8xTSipLu1dZmVU4u0/OXbAb/htz27Dx26MAFydg8PmalO4zPBNT5heU4khn
 w3J7124h34CSL8yfneEsS/Y21EstqoZhrK64K9NB3JyNwf2PB6U4wKxaIISmSV6Vnsz2
 tJtAYTvAFKaX2xU93WzcrQe2VMS6jv5O0HqwvY1/b2fXtq59LhKkr5GANvUTXT848uOZ
 sVWKnqWJOJQznUMyd85Db348L696PocmTMdf/2lc0FmO84WqIXwlhuHT5GAgdatTZkFU
 SmPA==
X-Gm-Message-State: AOJu0Yww3a4ipDTfhP9/eTiC1015ciTawjY9kqMg17WdXMYaK2SwHsvb
 8Mv9JdkDOX2AaSMXvDxkC8KZkyvm5EFVgMnlaGHY5EqcEnUDDu8G2owhq/G9/lqg2iaYLqF4PYQ
 7VuYx
X-Gm-Gg: ASbGncs3mTEG6ZFwINmugxT3uKzifQqjma7uszIub8uT09u/n2NNLhA5yYnfVrc5oTt
 kWsLxJB5xB9PkvCawl81pvoFts2x4qlQNnyU6hFYkb0isCcb0VbVKbw0f5V5oq30sdgSE8dD7rZ
 mSKRdeq1+xobWSYDwhctyVp9zEVbw81jkNft8BwL3A1ZxOEk6LZX1r1tcliFrlx7JZ3UkiygwOA
 M495Y1o1rfcs0niPylKJT5ZZ+rkxj+AcOKrhXHibQ9TqUqCtA7qfT3YghHWJ72/9t4+mzyfUKUM
 lVpxd3+VtBvHCtnxKcN1DtUw8or83LkuTJw60oeskwYNFZMGs2xGhVPweMhsZArpuXRLnFOrS08
 8EmwcXDTQ3PeCR1PTI3BUWQzg+QPNom27gRezPvM=
X-Google-Smtp-Source: AGHT+IE1j8YrFy8L91vbGxHq43Zd4SqAa4hxuY5RW2NGTw9zcdcfoMT+stdrrNSUsg//lpM+t+2iJA==
X-Received: by 2002:a05:600c:1f12:b0:45b:71ac:b45a with SMTP id
 5b1f17b1804b1-45b72e0ed54mr48972415e9.11.1756380886258; 
 Thu, 28 Aug 2025 04:34:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b79799c33sm28691015e9.5.2025.08.28.04.34.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 04:34:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/32] target/arm: Implement CTZ, CNT, ABS
Date: Thu, 28 Aug 2025 12:34:09 +0100
Message-ID: <20250828113430.3214314-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828113430.3214314-1-peter.maydell@linaro.org>
References: <20250828113430.3214314-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250803014019.416797-6-richard.henderson@linaro.org
[PMM: fix tcg_rd/tcg_rn mixup]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  4 ++++
 target/arm/tcg/translate-a64.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index a886b3ba4c7..766c610c019 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -726,6 +726,10 @@ REV64           1 10 11010110 00000 000011 ..... .....  @rr
 CLZ             . 10 11010110 00000 000100 ..... .....  @rr_sf
 CLS             . 10 11010110 00000 000101 ..... .....  @rr_sf
 
+CTZ             . 10 11010110 00000 000110 ..... .....  @rr_sf
+CNT             . 10 11010110 00000 000111 ..... .....  @rr_sf
+ABS             . 10 11010110 00000 001000 ..... .....  @rr_sf
+
 &pacaut         rd rn z
 @pacaut         . .. ........ ..... .. z:1 ... rn:5 rd:5  &pacaut
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c0fa9a44e7a..259aa70a36d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8308,6 +8308,37 @@ static void gen_cls32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
 TRANS(CLZ, gen_rr, a->rd, a->rn, a->sf ? gen_clz64 : gen_clz32)
 TRANS(CLS, gen_rr, a->rd, a->rn, a->sf ? tcg_gen_clrsb_i64 : gen_cls32)
 
+static void gen_ctz32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
+{
+    TCGv_i32 t32 = tcg_temp_new_i32();
+
+    tcg_gen_extrl_i64_i32(t32, tcg_rn);
+    tcg_gen_ctzi_i32(t32, t32, 32);
+    tcg_gen_extu_i32_i64(tcg_rd, t32);
+}
+
+static void gen_ctz64(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
+{
+    tcg_gen_ctzi_i64(tcg_rd, tcg_rn, 64);
+}
+
+static void gen_cnt32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
+{
+    gen_wrap2_i32(tcg_rd, tcg_rn, tcg_gen_ctpop_i32);
+}
+
+static void gen_abs32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
+{
+    gen_wrap2_i32(tcg_rd, tcg_rn, tcg_gen_abs_i32);
+}
+
+TRANS_FEAT(CTZ, aa64_cssc, gen_rr, a->rd, a->rn,
+           a->sf ? gen_ctz64 : gen_ctz32)
+TRANS_FEAT(CNT, aa64_cssc, gen_rr, a->rd, a->rn,
+           a->sf ? tcg_gen_ctpop_i64 : gen_cnt32)
+TRANS_FEAT(ABS, aa64_cssc, gen_rr, a->rd, a->rn,
+           a->sf ? tcg_gen_abs_i64 : gen_abs32)
+
 static bool gen_pacaut(DisasContext *s, arg_pacaut *a, NeonGenTwo64OpEnvFn fn)
 {
     TCGv_i64 tcg_rd, tcg_rn;
-- 
2.43.0


