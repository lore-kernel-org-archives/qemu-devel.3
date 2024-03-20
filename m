Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BB6CD11DB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 00:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmjsi-00004q-1W; Tue, 19 Mar 2024 20:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmjsg-0008W0-KR
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 20:32:34 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmjsf-0005XB-4w
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 20:32:34 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e6afb754fcso5876874b3a.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 17:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710894752; x=1711499552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=02J+igt5o8+h2PP+0HZoPaFUg0nUo/WrdtySb2LvSHk=;
 b=LRnPt6hTKt80yKhLCvjqc+4OtR5kdLoQuDm6MS972S6dXNUrHkWuJ+9jCm0MN+DBA8
 QxIKiCVJtgNdwcxc5y4FRRt6OXKE0AxTXWr4dGM9QsNOucbEd2LPTORB445qYCxQCtDS
 +8756Hjoq6PALeW2QIazwF78PFuwmoWAcFoIVHrO1y2zx3NNhgsonjP6sgSjiLHybdOZ
 h87TFXZSpsnFORkXj1xdb4q1FjqqKf1CIph17CQlG2rU7HQhmVC6U/IK8mYxFtZul9bv
 ONTlQzkmLjuV7RTIF91XPoVszZBXqEmcRB1dGHVtB/hcmOQzxY3q2z0dEkf4n9Dzbdj5
 yqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710894752; x=1711499552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=02J+igt5o8+h2PP+0HZoPaFUg0nUo/WrdtySb2LvSHk=;
 b=ZyLy2//Nwx5v4Td0/56/VwhvBu68GsWDMvn/6YPHwAuVwWG64iBuCGRKiT7pKELpXm
 9e1orsdpWoCpFe9jX6Tpsyw4MiQx5sSBoUOiuBxoqISsNzPnKNylSErV8yJoP4ZBDiHu
 IfJ2xpUViDPvQrtI0J2tp3KY7oH8Q+zmELxklJ3pea71VNIW6lS2voXsVpcpAHeIAT3U
 HjRXJ693QpxUukvKBS7b3Cmy7/ay/pXfeHGv8/FD6xz2AZr0JhSHH7sE6pV31pCFQmwY
 RVlaaSEhr914p9Vn4/P0Mx4cSGZ424FJznCqcvJWPVXw3BCRaTK3JVR/2xk3txntSCLJ
 /eVQ==
X-Gm-Message-State: AOJu0YwsEu+bLweks/d+P8kWsPTUcGBX6aw2hQCc1kQjk5ZfFD2cr5GJ
 +MLHE1v6vV0nA2DW83wKuqihC/c6GecRfw/JcolU+hvNeoxcZ7Y9igf53vkkQiLKdoOB1Uc2rZn
 G
X-Google-Smtp-Source: AGHT+IE/8zCzKXxnNpjB9Fk64LBYiZGwaGCXqqFNJe7788Qdlut6kfdEtnrMncEgRd3DL+6KNI8djA==
X-Received: by 2002:a05:6a00:4648:b0:6e6:5343:c165 with SMTP id
 kp8-20020a056a00464800b006e65343c165mr723033pfb.16.1710894751641; 
 Tue, 19 Mar 2024 17:32:31 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d19-20020a63d653000000b005d553239b16sm8475645pgj.20.2024.03.19.17.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 17:32:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sven Schnelle <svens@stackframe.org>
Subject: [PULL 4/9] target/hppa: ldcw,s uses static shift of 3
Date: Tue, 19 Mar 2024 14:32:18 -1000
Message-Id: <20240320003223.554145-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320003223.554145-1-richard.henderson@linaro.org>
References: <20240320003223.554145-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

From: Sven Schnelle <svens@stackframe.org>

Fixes: 96d6407f363 ("target-hppa: Implement loads and stores")
Signed-off-by: Sven Schnelle <svens@stackframe.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240319161921.487080-2-svens@stackframe.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index be0b0494d0..47c6db78c7 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3135,7 +3135,7 @@ static bool trans_ldc(DisasContext *ctx, arg_ldst *a)
         dest = dest_gpr(ctx, a->t);
     }
 
-    form_gva(ctx, &addr, &ofs, a->b, a->x, a->scale ? a->size : 0,
+    form_gva(ctx, &addr, &ofs, a->b, a->x, a->scale ? 3 : 0,
              a->disp, a->sp, a->m, MMU_DISABLED(ctx));
 
     /*
-- 
2.34.1


