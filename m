Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4852606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eYGk9KDo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMmTZ-0004Sx-Fs; Fri, 30 Oct 2026 09:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmSr-0002j8-2x
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:17 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmSj-0005Vg-4w
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:08 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-8490a7d6696so474390a34.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 06:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793366164; x=1793970964; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CkynieniSMNB9bKfWnjCUGS/8yE0sMA+FHoBj/3zs6c=;
 b=eYGk9KDoSPfZL67whQ4j0hmsUKtyCm/dsZiy8toVKthXuLXosHB9fdA3Ksxy/PMHPY
 3WtJ49XeZL2wjQ1EEkeRZ7HTbzzGMADT0ChWWBPY5L8Xx4iGG0rRyPkCLMNlzCtoN/k/
 6V1Szk0pAcXziUtA3onCcE78tBl9LzhtQELVe8Hpt6T8/xJCYSvT6Y7y9Yh9lNISlJ+Z
 ax73hN+sQN4IKMYiuB/2kKsPIuvZSwFHMAra5qGt0/rMeeJP+0hguQsvUd8RByoaShuz
 NaLOTEaNY+r0OqzMugNJXaT/70fQT5LiThUTtzYw9h5ks6Hgln8EJgaB5G21Ag6OktBG
 V4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793366164; x=1793970964;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CkynieniSMNB9bKfWnjCUGS/8yE0sMA+FHoBj/3zs6c=;
 b=tBGX29SYjRwd3c0GV9qKgoaRQOnxKFAvZ5z8RZV9tvMZuqE6YdijQqJ6NfchRGRBpj
 aitXF6jN1y6MUnOXmoJNUfWZqEupTIJtiQhtZd+K7jSngNZQiT99x5hGnC07DAy+SlXt
 RRMD2pAejaljzZLsaSqW3jTjkhE5BH1QcUPw48h0OAzX2/rQEpEsX89X0nc3br5HMnnj
 LP3NsHA1+AusHEvw/wfsDEPTHfci8dAgcNIHIh8aZDiXTAI7wkwuOqFK5OfcStahyAws
 LgoljYc5Lfq4jFBMxnGr3Co/7Teiss/xWBZY0EBlYbzg+AsNfgnWPujWThZkhEdxtqjs
 WJVQ==
X-Gm-Message-State: AFq9FYIKdJ97OJNFFYysyyUV/aE8XsX5suAJmf/Vg4nRw/x8xGptUr2j
 zLNEcDd55/CgfUpzW3zCG2F6G9WqJejQ1OV89MYjiXHmPFZjHMgFdZUkC7IZ3h7Ms9lKFas4Yr7
 aJYIo
X-Gm-Gg: AYBFou22T3VySDearYG6B71dZOToe2O42XxkSh0JCRL6gc9NctpX6lY99KDBKWQ+tYK
 3nYQOKUgLKMz2X19J+I13hrlP7tQtCSpler9l4wk4iafNb0CKHe7aUgVZNcR7Dz7VA3Bi79CX7N
 +phXkUcDbsYfSJVefV8Fl03BJMISUT1OVT8yVOMFGFc8dHkwQYTYVsQQyqHwK7cOpJPqI6BmFNw
 yfpqq8qbZ8t8ZwvwwJ497nwVrimpDy6chc4+mqaXHJDhH9CiU2ERlfmLvplH1DV+ADrmeb/Qbdj
 +iDFydST/O9g/e8hYN78mM5UARFLBEgaa5r/1ODOpdkcWhNAq2Yh8E7sVQGwdBdyDBzPLkZ4pw2
 oeEG3gUy70Y7YDOx0DIPu9LPbAGZZ/0WHn+/ITbX3ZqBgQhO9qYLX7MTbuOc4e7tSEDKgXh0Thm
 5nMD2mfOzLTw5WxSLI/f8iyuIvQ6FaDKbXKP6+2BtI9XVVW4kHEW3PuDMqfEi6o32f1GG4pq66G
 YGX9vFXkGll86542vstLv/u/EyiVy3rLoEA84KisvmWebqc4ogndQ1jPM0bS/8J6fKtHuF+Ockf
 YpAuepzxGQqsDIAVPIjINn6jjVWViw==
X-Received: by 2002:a05:6808:4fce:b0:4d6:9222:99f7 with SMTP id
 5614622812f47-5640dde6011mr1717399b6e.55.1793366163796; 
 Fri, 30 Oct 2026 06:16:03 -0700 (PDT)
Received: from stoup ([50.233.235.3]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a90ae4e6bcsm1796812fac.3.2026.10.30.06.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 06:16:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 08/19] target/loongarch: Use tcg_gen_lea_tl for ALSL
Date: Fri, 30 Oct 2026 08:15:43 -0500
Message-ID: <20261030131554.41208-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030131554.41208-1-richard.henderson@linaro.org>
References: <20261030131554.41208-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/tcg/insn_trans/trans_arith.c.inc | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_arith.c.inc b/target/loongarch/tcg/insn_trans/trans_arith.c.inc
index 2be057e932..c358e64264 100644
--- a/target/loongarch/tcg/insn_trans/trans_arith.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_arith.c.inc
@@ -188,9 +188,7 @@ static void gen_rem_w(TCGv dest, TCGv src1, TCGv src2)
 
 static void gen_alsl(TCGv dest, TCGv src1, TCGv src2, target_long sa)
 {
-    TCGv t0 = tcg_temp_new();
-    tcg_gen_shli_tl(t0, src1, sa);
-    tcg_gen_add_tl(dest, t0, src2);
+    tcg_gen_lea_tl(dest, src2, src1, sa, 0);
 }
 
 static bool trans_lu32i_d(DisasContext *ctx, arg_lu32i_d *a)
-- 
2.53.0


