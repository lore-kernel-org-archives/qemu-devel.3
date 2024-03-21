Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB01CD11DC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 19:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnO5S-0005I0-4T; Thu, 21 Mar 2024 15:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rnO5M-0005Gw-PI
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 15:28:20 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rnO5L-0006nL-9b
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 15:28:20 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1dffa5e3f2dso8685315ad.2
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 12:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711049298; x=1711654098; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kQVqrnpEFNAMTGSDkWy/XEPY0f16YIjRf/pXZgn4ChY=;
 b=G+QKWRYB/x9Y/G3i1Lw/r0+Yu6zJqJrqHChSm8ZuFOmL83q12Ic+QChB0FdlzEMEsD
 YgiAe4ubWzoQOpTltXrhFKWuQZNO6teISSFDyxZPCLoW38d2YgkSVjLcjDQ9v6hSKKUP
 u6lIxBq8akJYK+3cAYJZx0OLaJOCp3uQurFz5ueN759F0Vc9LGFRvAwHvgBJhBj3PJvP
 2fF6tajJ3zD52YM0q6QPoht+9a0cyuoM1+kJT0pHPtITriGMCmDzYqQ5VlaaBDYFFmsm
 A1PU9pkMuZUTplaNLQa9BTJJeRJAp0P1gDxzRJQtJtyVU4vzNQOSwWH+62SilRN3+p6c
 8UUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711049298; x=1711654098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kQVqrnpEFNAMTGSDkWy/XEPY0f16YIjRf/pXZgn4ChY=;
 b=U8y0fp+ZKCzHr7ATsn4cDSIhE2pAdFp9UfPcPIPMZh2NCxKbNFgdN2afZ8iF/3O8Tg
 21dQh6SWV9zp5VUqrVNye6TRAf5RiN+S0HzSs+dy3oBlb/CHFZ9DhqsVPD8qUhkw8gf2
 B4e8XzueP22IGnWeJpBnXrIKTIeygr42XmB55yS5dKWmG+p1iQqYIPp2uBoSKr/Nn6T3
 bYMAZJfYTMYamQD83bbPzIs28MQvgKACoMxAVvWggzzMSQmnIGKITKit+9hyLKA5x8tn
 rLcRsCEbjuWZVRFG5B3ijacQjuhQehhrsqxIV8MGnOdwqdBMiDKdzpkNjK9ynFGnbJYe
 UF9A==
X-Gm-Message-State: AOJu0Ywr478KUsY+lj3j7RgwFneRgEVF6HBjPjDMu3kbbaI6KDwteLMy
 CZE0y25EunSRdreD9TnMCD9Lx1RfLZLKuEyj4I8Z6Q2l3DaiiJYrSEDmWhyn7AImFqeHAR9nOHF
 s
X-Google-Smtp-Source: AGHT+IEVqP3prUbxvk3hByUXly2Mcl3iwdYjnaSf8j0E9e1JHBwNZm92k+mBJPuhXKzQLkE7160MhA==
X-Received: by 2002:a17:903:41c4:b0:1e0:294f:17d3 with SMTP id
 u4-20020a17090341c400b001e0294f17d3mr455931ple.5.1711049297771; 
 Thu, 21 Mar 2024 12:28:17 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 p8-20020a1709027ec800b001e06c1eed85sm207303plb.141.2024.03.21.12.28.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 12:28:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de,
	svens@stackframe.org
Subject: [PATCH 1/2] target/hppa: Fix BE,L set of sr0
Date: Thu, 21 Mar 2024 09:28:12 -1000
Message-Id: <20240321192813.371526-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240321192813.371526-1-richard.henderson@linaro.org>
References: <20240321192813.371526-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

The return address comes from IA*Q_Next, and IASQ_Next
is always equal to IASQ_Back, not IASQ_Front.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 19594f917e..1766a63001 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3817,7 +3817,7 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
     load_spr(ctx, new_spc, a->sp);
     if (a->l) {
         copy_iaoq_entry(ctx, cpu_gr[31], ctx->iaoq_n, ctx->iaoq_n_var);
-        tcg_gen_mov_i64(cpu_sr[0], cpu_iasq_f);
+        tcg_gen_mov_i64(cpu_sr[0], cpu_iasq_b);
     }
     if (a->n && use_nullify_skip(ctx)) {
         copy_iaoq_entry(ctx, cpu_iaoq_f, -1, tmp);
-- 
2.34.1


