Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF675C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 17:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEuMG-0006Dq-DL; Wed, 05 Jun 2024 13:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuMD-0006C0-V7
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:29 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuMC-0003wp-9N
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:29 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2c1b9152848so47552a91.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 10:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717608207; x=1718213007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Zc6NlkQbS2lcn1kKKKWe0Yu4/0TMcIiGPLy1T3CK0w=;
 b=L6uNUjRfDHicwqE7BAOoP6ArpZe2MLu2wYrZP0UJhX++D6ZjwjxP7q0DMAQmwyKTtG
 9Pbv0ZRJmBNBPytdoW60E6sRjRxPpLCdRm0amuo4woBQxE+EKJQxeH0h9JJlCCxaie/d
 6M4SRkS1x3jjg0oZtJKOMaAVwHpGhbr8AzMyrQC5Rky53y6BmPd+HTATpAPyvXkqweId
 UXnlWiiMl1u8JjRyXwqTja/wid1FbE6K8uIRsNIBb/WNiyzZ24VNxg1FYFGMG6awo7kA
 k8zSpN26PyLaM/GCv6N2CuNlhS1GGeVlN+fSe7F3x9RfR7onBrKOfi6MNNz9M2q4nHWY
 8KOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717608207; x=1718213007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Zc6NlkQbS2lcn1kKKKWe0Yu4/0TMcIiGPLy1T3CK0w=;
 b=jN9Lqy349jYjizWDrEDGvDaM0/ePSgY8VLMtBSMdBNjBN922iYtdCu8bbyVgUZ8Dfd
 xgFG9u0Ew138pn7+jDTAaMt06SMeiiI05uZQyO7rHQiG2o+BBrAKogdrcbdlxASvpzsU
 /kLEKDpxSG2lMB9FKSWKU+Z1OQCBodkT0LBrUM/+EsG+ZOKJ4C5pRHF+QVb0r/S9cG0D
 BYTrTAYht4V6qBQr0mC/etHhjKS0JPQO/EcWvP7ATC9gYt+BOEj1tuY7qJSYOilpV/jE
 HPFYM5V6gp9ynLAg7mIRxkzztWvvVYJhHFkBh6nuZukHpJrLSRR6t5EBlZfe42NYhpAm
 Q0NA==
X-Gm-Message-State: AOJu0YzpLPAecZzSp5T9W9PmEE8/gthkEFSiDr8liWI4QMExtNhyGppP
 sn5qHEYrPjXhs+9oRqGrE5sU47vlSlNtr6Kh5UvAw9n3mp7wewkgIDjBHFpQptTXxiEVDcI0jx5
 U
X-Google-Smtp-Source: AGHT+IGO1Y/vkH6+HwxAemEVRnIK65mEMH24GuzVqoLHt4hjE0ZUxnVsnk5m3EUrPmQ34PY9/5T+WA==
X-Received: by 2002:a17:90a:b383:b0:2c2:4134:51cc with SMTP id
 98e67ed59e1d1-2c27db11924mr3230306a91.18.1717608206827; 
 Wed, 05 Jun 2024 10:23:26 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c28066d511sm1720915a91.9.2024.06.05.10.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 10:23:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 34/38] target/sparc: Implement FPMIN, FPMAX
Date: Wed,  5 Jun 2024 10:22:49 -0700
Message-Id: <20240605172253.356302-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605172253.356302-1-richard.henderson@linaro.org>
References: <20240605172253.356302-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode | 14 ++++++++++++++
 target/sparc/translate.c  | 14 ++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index be591171ad..2ebee5a1ca 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -524,6 +524,20 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     FPSUBUS8    10 ..... 110110 ..... 1 0101 0111 .....    @d_d_d
     FPSUBUS16   10 ..... 110110 ..... 1 0101 0011 .....    @d_d_d
 
+    FPMIN8      10 ..... 110110 ..... 1 0001 1010 .....    @d_d_d
+    FPMIN16     10 ..... 110110 ..... 1 0001 1011 .....    @d_d_d
+    FPMIN32     10 ..... 110110 ..... 1 0001 1100 .....    @d_d_d
+    FPMINU8     10 ..... 110110 ..... 1 0101 1010 .....    @d_d_d
+    FPMINU16    10 ..... 110110 ..... 1 0101 1011 .....    @d_d_d
+    FPMINU32    10 ..... 110110 ..... 1 0101 1100 .....    @d_d_d
+
+    FPMAX8      10 ..... 110110 ..... 1 0001 1101 .....    @d_d_d
+    FPMAX16     10 ..... 110110 ..... 1 0001 1110 .....    @d_d_d
+    FPMAX32     10 ..... 110110 ..... 1 0001 1111 .....    @d_d_d
+    FPMAXU8     10 ..... 110110 ..... 1 0101 1101 .....    @d_d_d
+    FPMAXU16    10 ..... 110110 ..... 1 0101 1110 .....    @d_d_d
+    FPMAXU32    10 ..... 110110 ..... 1 0101 1111 .....    @d_d_d
+
     FLCMPs      10 000 cc:2 110110 rs1:5 1 0101 0001 rs2:5
     FLCMPd      10 000 cc:2 110110 ..... 1 0101 0010 ..... \
                 rs1=%dfp_rs1 rs2=%dfp_rs2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index e856c811af..5bed23a00b 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5061,6 +5061,20 @@ TRANS(FSRL32, VIS3, do_gvec_ddd, a, MO_32, tcg_gen_gvec_shrv)
 TRANS(FSRA16, VIS3, do_gvec_ddd, a, MO_16, tcg_gen_gvec_sarv)
 TRANS(FSRA32, VIS3, do_gvec_ddd, a, MO_32, tcg_gen_gvec_sarv)
 
+TRANS(FPMIN8, VIS4, do_gvec_ddd, a, MO_8, tcg_gen_gvec_smin)
+TRANS(FPMIN16, VIS4, do_gvec_ddd, a, MO_16, tcg_gen_gvec_smin)
+TRANS(FPMIN32, VIS4, do_gvec_ddd, a, MO_32, tcg_gen_gvec_smin)
+TRANS(FPMINU8, VIS4, do_gvec_ddd, a, MO_8, tcg_gen_gvec_umin)
+TRANS(FPMINU16, VIS4, do_gvec_ddd, a, MO_16, tcg_gen_gvec_umin)
+TRANS(FPMINU32, VIS4, do_gvec_ddd, a, MO_32, tcg_gen_gvec_umin)
+
+TRANS(FPMAX8, VIS4, do_gvec_ddd, a, MO_8, tcg_gen_gvec_smax)
+TRANS(FPMAX16, VIS4, do_gvec_ddd, a, MO_16, tcg_gen_gvec_smax)
+TRANS(FPMAX32, VIS4, do_gvec_ddd, a, MO_32, tcg_gen_gvec_smax)
+TRANS(FPMAXU8, VIS4, do_gvec_ddd, a, MO_8, tcg_gen_gvec_umax)
+TRANS(FPMAXU16, VIS4, do_gvec_ddd, a, MO_16, tcg_gen_gvec_umax)
+TRANS(FPMAXU32, VIS4, do_gvec_ddd, a, MO_32, tcg_gen_gvec_umax)
+
 static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i64, TCGv_i64, TCGv_i64))
 {
-- 
2.34.1


