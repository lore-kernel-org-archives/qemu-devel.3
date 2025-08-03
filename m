Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 567A0C87FD2
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 01:43:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiNiQ-0006x2-DX; Sat, 02 Aug 2025 21:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiNiN-0006tv-28
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 21:40:43 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiNiL-0004cb-GN
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 21:40:42 -0400
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e8fd38cb2abso2726351276.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 18:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754185240; x=1754790040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5QRcnvxwZypphjcA+fW9oCNiYxHSuJ0HKfcdLiVVrmc=;
 b=baDOk48iK4I0alefuz+HwDt0XTNBsCntI7/bjThFsMQAfWlYBF089x59AB6cNyjQLJ
 ciQfOaevEuJ8e/qn6514v8rjqOFt4OVwG3cVJQ+BydKZ6ILZAnBS7HTVUu7ln3YEWWn7
 Svqbhqz0nkxfJqrhaHFmrcUK+mXmUt+lBwyb0+qDlAjBw+DhBPWtRi+xC0ceSRd8p3d2
 gaMsy/bjI+qwbWagzCQGekB1NoMUQp0FjTKW3S97AJwpQ0xFqmYCe6xdJ5Ebzyd+yPMP
 LoRbyK49r5BF7bGoLm4kFHMDCfDPjoX1bpIaRzIm99XeKpvtY/lrlzlovo2JfOo3RC3g
 aLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754185240; x=1754790040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5QRcnvxwZypphjcA+fW9oCNiYxHSuJ0HKfcdLiVVrmc=;
 b=HisIfoSzqxYpd32jFdLC2gD8jX5SXya+kPrVarZ0QaqVpHsk69bUzf4UZnFIwZyBZZ
 Grnij6FIH6lwlVtzeNR6XiEWM+Hj6Fkgk38GK3rOUAAHCffj4Q1C65HOYEjk/O4+TvaB
 tTLlyaS5lK7yur8wkr5dJzOOv9MDBEkbNFBIKPLrcdAa3fgJrIz/Kgr0NKutKy9S26ox
 3OQHPOyYjnnkjjrQNVhe94jBUMr19asaSgMq277TkhKGQ0IoeVaLubEYs4n3CfkLaLxs
 CcyiFBe/MWjAxdteL/PFsCSghQ62eQYDXO82S9LKpj5MBU3h8IhyXvgqbwmCdtGkbGOq
 lQYw==
X-Gm-Message-State: AOJu0Yx3JwGHLwyJc/5Y2wEEd6qYl7BKo8pJfr0mT1yMGZCLWlRUmBjd
 jy0ld3wrymb92zoC4l6B1qL+9C0ZG69cAr43tjfcEofq1nD1jRjn6poG+jWtvJTOvpsJhP7kUw3
 AnTjOweY=
X-Gm-Gg: ASbGncvn5CGyGUjbuUzm9t3NBLa4cyRxmainRzNL3W4tiMEJ8Lz343NceEjg1O+pi5y
 oE2J/gIJcswq2zOhUAp+8Uo0BTekyXD02q3b5cnYZMfgmf7pUcfZ6jeYzeWw6UgSPQ4BCxf9gxP
 cglHry7HMHwLJQCDaWkpjKK+hqzbdiUw2ZgPc8oH2/Em60456jcA05dnX/VCmDaK+XlaVwNLw22
 7R2rzmGTOFRyCMrI9dwCTwf2s7Tu29JcARA5mE3JSWrRL6/cwNoamvJ2yIy9nH3ZHqIixGLcduu
 dt58v9JrVrCHtWxrHzLE/U900bPT3Tns9kKQglbl/kviHB/3KJillIanb/pfB/W+Njzm2Y2ic9h
 s2z1b++w2yvk5kCCdVFHagPpRusT5kxRwIMjWl07TmftHRA1lGhlW
X-Google-Smtp-Source: AGHT+IHFJtSXHJ0rqgwtfe7GEGd7wopnQpf02JHSKD5f8uO3oSxDVSn7lDIRNQmK8OcPTk1k+pTAxA==
X-Received: by 2002:a05:690c:39a:b0:71b:6ad2:d10a with SMTP id
 00721157ae682-71b7ed71054mr51823487b3.11.1754185240474; 
 Sat, 02 Aug 2025 18:40:40 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-71b5a6031a1sm18753227b3.86.2025.08.02.18.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 18:40:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 03/11] target/arm: Implement MIN/MAX (register)
Date: Sun,  3 Aug 2025 11:40:11 +1000
Message-ID: <20250803014019.416797-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250803014019.416797-1-richard.henderson@linaro.org>
References: <20250803014019.416797-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb34.google.com
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
---
 target/arm/tcg/translate-a64.c | 22 ++++++++++++++++++++++
 target/arm/tcg/a64.decode      |  5 +++++
 2 files changed, 27 insertions(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index b70ae5befd..bb92bdc296 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8201,6 +8201,28 @@ static bool trans_PACGA(DisasContext *s, arg_rrr *a)
     return false;
 }
 
+static bool gen_rrr(DisasContext *s, arg_rrr_sf *a, ArithTwoOp fn)
+{
+    TCGv_i64 tcg_rm = cpu_reg(s, a->rm);
+    TCGv_i64 tcg_rn = cpu_reg(s, a->rn);
+    TCGv_i64 tcg_rd = cpu_reg(s, a->rd);
+
+    fn(tcg_rd, tcg_rn, tcg_rm);
+    if (!a->sf) {
+        tcg_gen_ext32u_i64(tcg_rd, tcg_rd);
+    }
+    return true;
+}
+
+TRANS_FEAT(SMAX, aa64_cssc, gen_rrr, a,
+           a->sf ? tcg_gen_smax_i64 : gen_smax32_i64)
+TRANS_FEAT(SMIN, aa64_cssc, gen_rrr, a,
+           a->sf ? tcg_gen_smin_i64 : gen_smin32_i64)
+TRANS_FEAT(UMAX, aa64_cssc, gen_rrr, a,
+           a->sf ? tcg_gen_umax_i64 : gen_umax32_i64)
+TRANS_FEAT(UMIN, aa64_cssc, gen_rrr, a,
+           a->sf ? tcg_gen_umin_i64 : gen_umin32_i64)
+
 typedef void ArithOneOp(TCGv_i64, TCGv_i64);
 
 static bool gen_rr(DisasContext *s, int rd, int rn, ArithOneOp fn)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index c1811b0274..a886b3ba4c 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -708,6 +708,11 @@ GMI             1 00 11010110 ..... 000101 ..... .....  @rrr
 
 PACGA           1 00 11010110 ..... 001100 ..... .....  @rrr
 
+SMAX            . 00 11010110 ..... 011000 ..... .....  @rrr_sf
+SMIN            . 00 11010110 ..... 011010 ..... .....  @rrr_sf
+UMAX            . 00 11010110 ..... 011001 ..... .....  @rrr_sf
+UMIN            . 00 11010110 ..... 011011 ..... .....  @rrr_sf
+
 # Data Processing (1-source)
 
 @rr             . .......... ..... ...... rn:5 rd:5     &rr
-- 
2.43.0


