Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B5A606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GO+zWYqz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM6aA-0006SD-L3; Wed, 28 Oct 2026 12:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6a8-0006RB-SF
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:32:56 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6a7-0007WM-9T
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:32:56 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-82109f51565so589088a34.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 09:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793205174; x=1793809974; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CkynieniSMNB9bKfWnjCUGS/8yE0sMA+FHoBj/3zs6c=;
 b=GO+zWYqzWWFdhZ/Vqdbe8RA/kzcI1lE3G5CkbVSCsjJ1eiBiX0gksto1L6MI/7QUms
 Y9yJDCQR56excdOrQONL2HQ9XJFkemoq8vde/ShvxS1Fn3pBmZpNySnnvgBSy1lR5G/Z
 WpIl1gOlvZdAdZqaPguxNwZTDP2PtnpgXwl7CXwxeZbwhQG0hbcmR7isEb+GjbLWBxKT
 WlHJ0BMqmN7BzYtRNMznQ3CJP0rg5YwBuE5aZ0UrNP6/PdFQtgXxLwJqM/RtlwDkWKL3
 7Iok2GLLGa+hGP1h+Pzuk2D5Beb3Bmp+6w1nC/zsrzbLajkDGPQfpwnuz4eRc46YJBnu
 uQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793205174; x=1793809974;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CkynieniSMNB9bKfWnjCUGS/8yE0sMA+FHoBj/3zs6c=;
 b=C+5soYn8rfJmsSrtMofsW+iqB/a2oemtsuu9KRfRDy24QPN/dMjA/8nWI7dH90iKO7
 S32qULOE4oTKthb2zVcfUyOO90LWLmZJ6MW1goG9WydOUOoSuZYCqxwV36zPZ0sirygG
 ZEDaidSien2XS/e2o5AOtPvLpt+A/PHwKuDe7ZNN4l0zKU3M3Y990z2o6THD5+/mo6we
 WlfB2coxg4pibwzYHkcGp2NsFqb1wlNJimCM4qZukWxp/u8WIR+D14WsWu1Rh7Xmre/k
 R+kX9exnx72o9sdPrX837zgMAdTZGN1NOJvPzmyklcRxoqjFmPSJLtED2t8ebqE/Wnju
 5z9A==
X-Gm-Message-State: AFq9FYKuXbpzdbH8rWDILK7MV9/bvV5fvq3353OJceWw1kEr5K9j+dS6
 Jf/GViZ5t3Nj8lWKKNyW2mgCX1gYb4xOWqsnou6USmstLct4MQuZlqaxJnVgXKGtsWQHBjZ09ey
 D2u7Z
X-Gm-Gg: AYBFou2Qz48VdyffiNBwApe16JKar2aUNo7haoleLhNflq8lLNmy92HRhdt2b6CLxrO
 e/MNbllRpq8yacj/Ikv9rDdYk0l60dPVW/qLdT9QAKtYV/e0gcwOjZezH81+JWzo24FqDYC120b
 jiaeknLaj2IAo8yLaYn58wuB4ccz2qkgU/HiYXVaPleP+O5276PSy+FchQFMvFMDSgZ5EXrSeR7
 rF2K9oXsHyWeEsUfFunStpH10nnLomc0F4Z+5q9DElaF6fXc6xRaQHWdo62iTFXNH4hct4Mw+8g
 9DFNmS+sOdNVkrUuUGpxyTmR0Z26GwJTydXOtkRIZZPJ5R3z8w7fRw1sEc2viLtNXanmx2QzRus
 7HtQA+fDExHqDx1nXmQrQ6CCy86R8nE3mFjdZZ8sI3XjhWcm1Tv8rtm8Yd69X1favuBCmOACbvE
 9zcemo+ckyPgij5+5nuIuv1fgWwaD/WkwFpjznjmhZWVgytLyVdPvsfmbHWivt/ccXaSyH6yPZS
 aDyQSl0Y6AHcF8xjTwgP4QjNu2ob7gDG+xZmFyxlRyPgqUKpoltvwLFq7KQ7xYiWlQ9xSLaz5P1
 3RekeXDoKXf6d4hGmA7bJcl7XOdFxd4i0XjmYP+UkKO48jKOF6ORVqs=
X-Received: by 2002:a05:6830:439f:b0:816:b03e:f9dc with SMTP id
 46e09a7af769-85ab9872352mr2958690a34.5.1793205173763; 
 Wed, 28 Oct 2026 09:32:53 -0700 (PDT)
Received: from stoup ([2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b1f4368f3sm2538965a34.7.2026.10.28.09.32.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:32:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 05/16] target/loongarch: Use tcg_gen_lea_tl for ALSL
Date: Wed, 28 Oct 2026 11:32:34 -0500
Message-ID: <20261028163245.1031673-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028163245.1031673-1-richard.henderson@linaro.org>
References: <20261028163245.1031673-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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


