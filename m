Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F22C25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJlr-0008Dm-DR; Sun, 26 May 2024 15:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJlp-0008Cj-9y
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:05 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJln-0007e0-GK
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:05 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-681adefa33fso2056905a12.3
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752582; x=1717357382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4OF6NAHLFk8bx77QH1kehHlo2DsgfnveZ/OaIZj+BNU=;
 b=VPZvVVqv2rv18id5zBjeHfgQTr8t/sDIOmfg8bLy8pJ00YqK3v/zTmD8i1sPzKp4pb
 d5wFa8YJxHHGEjXgL8KQrFPQwwSQ+5P6+9NTgLk3ze71dOSDGSvaPlQZ05kyOxOpyMlr
 qh0tppaWtJhBFme9bQLvNOtSyydUYnZRL0/niJISV4qv7a8vZbZHzn4y1CegXWVWM0Y/
 0lJrp28QlyIdFxulnRmT77HFWP1wXgtt6F3MDgmNAe858qJU08pYSTbi4QKJnhQ9wX83
 Hjbw8Vo4EYSouoztwHyJOE+BVxYiNmKYp0gLv3JtWOl+R72lK9xDT3iJXtXE/5fj220x
 RMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752582; x=1717357382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4OF6NAHLFk8bx77QH1kehHlo2DsgfnveZ/OaIZj+BNU=;
 b=h2mP3yyjBtTT5nVFxENaFuerhjDwARXvWs8lKAMyJGkCHkBWtCRh/llz311r/4RJi+
 ffCxzUS3UffLW/ZohEDdNIEEoR7+x52pUmjNPfh+ZEzkX0SqbrqShUUreFPb4hvyiHTn
 yWPDZcLbJ+RS8JTgsdtfGfXNwxTcODRH0vmtBrnwacerhkDjQmpE+pzxRQ+63M+rlZZ1
 5cLyw3caksvDYsZeLXx8GhuiOGCLirlkTdrQSm1xdi3+OXVqbksgWv86HvLRX2eKPCUA
 6ghwOXZcL6LF71PiuDF/yApNifLqXgO9PzPqfT6x9Ifn9XUB+ylSQ8miUlHrrlWui78k
 27lA==
X-Gm-Message-State: AOJu0YyopikH8jMplPd73CCsnpwytMxTj5zjfT+Yoy0LI2Kt+8eta1HT
 ABgjJlOdUsu3YSUkkqqKdVhvWRviK6CkRh+rlKCchpJ8BbHPHE/XhjGRuNtsxW7RnYu1qe52ERZ
 W
X-Google-Smtp-Source: AGHT+IFfUWKxGRh1f6RxZ/ndGyp7BItJizLJWccKekUgGQ7UUk/4Mwea8gdV5WmlUYvBiXnmPqse+w==
X-Received: by 2002:a17:902:d50c:b0:1e0:dc6e:45d6 with SMTP id
 d9443c01a7336-1f4498f0d7emr115677005ad.60.1716752581965; 
 Sun, 26 May 2024 12:43:01 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f46ad93c2esm28165935ad.263.2024.05.26.12.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:43:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 08/37] target/sparc: Use gvec for VIS1 parallel add/sub
Date: Sun, 26 May 2024 12:42:25 -0700
Message-Id: <20240526194254.459395-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526194254.459395-1-richard.henderson@linaro.org>
References: <20240526194254.459395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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
 target/sparc/translate.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 362e88de18..8731e4f8bb 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4664,6 +4664,20 @@ static bool do_dfd(DisasContext *dc, arg_r_r_r *a,
 
 TRANS(FMUL8x16, VIS1, do_dfd, a, gen_helper_fmul8x16)
 
+static bool do_gvec_ddd(DisasContext *dc, arg_r_r_r *a, MemOp vece,
+                        void (*func)(unsigned, uint32_t, uint32_t,
+                                     uint32_t, uint32_t, uint32_t))
+{
+    func(vece, gen_offset_fpr_D(a->rd), gen_offset_fpr_D(a->rs1),
+         gen_offset_fpr_D(a->rs2), 8, 8);
+    return advance_pc(dc);
+}
+
+TRANS(FPADD16, VIS1, do_gvec_ddd, a, MO_16, tcg_gen_gvec_add)
+TRANS(FPADD32, VIS1, do_gvec_ddd, a, MO_32, tcg_gen_gvec_add)
+TRANS(FPSUB16, VIS1, do_gvec_ddd, a, MO_16, tcg_gen_gvec_sub)
+TRANS(FPSUB32, VIS1, do_gvec_ddd, a, MO_32, tcg_gen_gvec_sub)
+
 static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i64, TCGv_i64, TCGv_i64))
 {
@@ -4684,10 +4698,6 @@ static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
 TRANS(FMUL8SUx16, VIS1, do_ddd, a, gen_helper_fmul8sux16)
 TRANS(FMUL8ULx16, VIS1, do_ddd, a, gen_helper_fmul8ulx16)
 
-TRANS(FPADD16, VIS1, do_ddd, a, tcg_gen_vec_add16_i64)
-TRANS(FPADD32, VIS1, do_ddd, a, tcg_gen_vec_add32_i64)
-TRANS(FPSUB16, VIS1, do_ddd, a, tcg_gen_vec_sub16_i64)
-TRANS(FPSUB32, VIS1, do_ddd, a, tcg_gen_vec_sub32_i64)
 TRANS(FNORd, VIS1, do_ddd, a, tcg_gen_nor_i64)
 TRANS(FANDNOTd, VIS1, do_ddd, a, tcg_gen_andc_i64)
 TRANS(FXORd, VIS1, do_ddd, a, tcg_gen_xor_i64)
-- 
2.34.1


