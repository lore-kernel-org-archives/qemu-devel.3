Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07587CCD18A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CqT-0007O6-PQ; Fri, 10 Oct 2025 09:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CqO-0007IW-QM
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:36 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CpR-00040I-Sb
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:36 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3ee12332f3dso668278f8f.2
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101592; x=1760706392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PxKsrlwHpoapQQL65JppSCf2QZ2QbTS/NgH2OWxrhJY=;
 b=ygklRhwedYaldtR3MrGoUKwZGAu91GK/11ci2OtWOgXukTHtJM1yFfZnxGMjNB58Qo
 /GG0a/tBfAM+PihqTEPjsX6TP2lMtk294a7dpn6R70B0zEEWSfoADsykEylqQ0U/s8t4
 aJZ1rZ/4izuqw1QEgUkE0kFGS2l2nEx4dFqRvyzHn6DyJM7x2qwz/i2cT/N5vPAQkoB1
 MIjp/E1WqIG6Qkay0Dd8A9Z4b1jdRbFrbmL/EU2D1Wj/DI7ht0947OGyOpYpLPJByOUP
 ikBzNRLXpPfp2Ybdh7TJccTdXVEgF42PfIxACZNAAEhlieg/64Xbpgk77hLGAYlv28fl
 gqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101592; x=1760706392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PxKsrlwHpoapQQL65JppSCf2QZ2QbTS/NgH2OWxrhJY=;
 b=DsuYyb36KB57waOFmYi4r9hQSE8NxbfG7kpRryMpNdNXEt1WYCwqup1LndEhK4xXN1
 DFKXflzGWQ+RT+I71YTUXj/EgqKwNY1Evqpn+cYnM+2EPzRWZmnx+XY7O5Tcuwz6LfU9
 +nrWYxEayCXX9U+wEtaCKsLTXnGbz/EPlRdfvhH/0Q0CxmvDnlnqDNCErXenaQCfrUdf
 fMX+Fg2j4lrGHxRCi34kmi+OxgVpEJylfq4X1WPFm11IROk/5IfsjYJl7wpVpy6TCzly
 scHa2tJBJ1d8I6QsltVlu5+JomMAq1CEdlCma8hRVe+NGgwx4sjkYdqwr6DLkGsqlVSg
 owqg==
X-Gm-Message-State: AOJu0YzFoN7lefjPWrQNNEtvYJNixYjSC8cZojOyLJarRr165U/XjiGM
 tr84jYZUzAXgstC+ARVutuxbOahlXeQr8XY/bf/CZU4VRBAtM0xcHDq5Xb+f0jEGG9e+4wc4q5c
 LsNZi
X-Gm-Gg: ASbGnctJV+4JYRkzGBYhQPSGFaOeo5pU5DOdhtIFWyPvIE7JaYDmQ0c9Czj6b3MWQva
 R7dPBjjfA7ZYPyEPJhJJi/PrMFpezpqfA7av7Z2W9Rwd6F6E7UU/SfuJP/wTMSf8CFTzUcXNEwm
 Unj/IE/Wp3OmR9p7qHIcSlJUyahvK2VBt6QnXi8YVvzkqS3u93QMUkUVLGWxsBsgKVmK2yxZsEf
 AQ7yB60XhejC5OQ4StzQG9+MzBoAmXzJ00shzBykf4EDZeplhsSPbPMYV3HAbmd/5nVHH5Ti6jk
 w14tiGatB7sWOMQC4zXpNRCkM4YMuvkzYoVhX2kqeAqwVWuMNqo+lAYzmI97QUCcmvlRbzgOSaB
 Hw81FrTxriISaVlcX3jc2knv70xRhIul4lYdnk1uV6Y71NIz1ZvFBdR92CdUF3g==
X-Google-Smtp-Source: AGHT+IHNoaIQKUY8kr/2eBWIZn+NrIfT6y507rxInDi6RBsogfgTdx1/kl7NqzFSHN986vs+d8FM4Q==
X-Received: by 2002:a05:6000:22c5:b0:425:7c63:95c3 with SMTP id
 ffacd0b85a97d-4267260e166mr7516277f8f.48.1760101592490; 
 Fri, 10 Oct 2025 06:06:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 56/76] target/arm: Add gcs record for BLR
Date: Fri, 10 Oct 2025 14:05:07 +0100
Message-ID: <20251010130527.3921602-57-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-57-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 9a564339fa4..fcfa4223f5c 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1782,15 +1782,15 @@ static bool trans_BR(DisasContext *s, arg_r *a)
 
 static bool trans_BLR(DisasContext *s, arg_r *a)
 {
-    TCGv_i64 dst = cpu_reg(s, a->rn);
-    TCGv_i64 lr = cpu_reg(s, 30);
-    if (dst == lr) {
-        TCGv_i64 tmp = tcg_temp_new_i64();
-        tcg_gen_mov_i64(tmp, dst);
-        dst = tmp;
+    TCGv_i64 link = tcg_temp_new_i64();
+
+    gen_pc_plus_diff(s, link, 4);
+    if (s->gcs_en) {
+        gen_add_gcs_record(s, link);
     }
-    gen_pc_plus_diff(s, lr, curr_insn_len(s));
-    gen_a64_set_pc(s, dst);
+    gen_a64_set_pc(s, cpu_reg(s, a->rn));
+    tcg_gen_mov_i64(cpu_reg(s, 30), link);
+
     set_btype_for_blr(s);
     s->base.is_jmp = DISAS_JUMP;
     return true;
-- 
2.43.0


