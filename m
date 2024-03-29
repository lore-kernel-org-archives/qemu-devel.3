Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B900C6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 22:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqKl7-0002Zr-1m; Fri, 29 Mar 2024 18:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKkv-0002W7-5H
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:31:25 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKkt-0003VV-M8
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:31:24 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1e0ae065d24so21059115ad.1
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711751482; x=1712356282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4HCtEnOimuoA4trumoTnA/CP5fOcqoSfBq8bXqNwYa0=;
 b=nRFtev9E4MYBmpSupyLNQR7Dk+3wfBjLJMQdAXsWpyuell2JQCsGSjK3ciDTotVVfl
 J0duTcIhCQtypLAHSovrnRaar/0UsKM1eoxQlsebBrt9h1esywaMxv9DUqSCMY7747Zn
 n7UL7obZaJqxLa5t7fYXODj06MGtSLZJMu55L1gJNnMKWYT1PjKudDYJyh4zKVXvXXyd
 xephYatKRdBlsYm18NE/VFT4naO6/YfNnTfXg2k4cKE3JDhZPkJhIDaijQKwU3Vd7nvc
 SqfJL7r41AIzEGCRV0NHE0dOtvCtji91wALytnSvzniFUMSNfGHudhPsyt3htV3Lz0B6
 8q2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711751482; x=1712356282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4HCtEnOimuoA4trumoTnA/CP5fOcqoSfBq8bXqNwYa0=;
 b=k0bTBZTBVrIjmM/rc1eC0ifGROKGqTYFcXq/8h+np/bYU/K+IS4+1sP+i5cpx9xDzh
 3uvOA0aslNE2C2eXZhcCiRwFXBQ4fOuoYouTMBFx73HqLtm6vFQj94gHAu7UvZY89lQv
 NApAffdShEB+nCPp45x2hcC7L0MswBwyYy3Jfkvz90N58ACarcsPEUbg/sBup0T/hkkh
 PVJu9mdDantgV+PELzWMFdSf+ZMtnIMwUlrgLXMm9BmkvIA0Z4HABSuldq3vHujf0Mt2
 jiExIzC2pBSgJ4aUmCwDphKABYMLi0WKQpE+ElKbnbVsWzq0sq2XdCpxdSVTCzXqSvx7
 +q8A==
X-Gm-Message-State: AOJu0YzV6TybjD8edwxrAK8JqYWEgzf6xKJ8OGiUxA+Gg2vCAxXE3tru
 bpUzXzGjapAxHVFwWmm8vRLP/zEm+eJZxPJ09f34h6MTDcmI8gFK87+6fhDITP2ydQwgOlamzvT
 U
X-Google-Smtp-Source: AGHT+IH3K5ssB3JDYEYORgQuF5kJ6ajhsshPqKO8AUG6KHHCybY2EVo2/UZFVi5z21GkdADbeMdVrg==
X-Received: by 2002:a17:902:bf04:b0:1e0:115c:e03c with SMTP id
 bi4-20020a170902bf0400b001e0115ce03cmr3345989plb.53.1711751481781; 
 Fri, 29 Mar 2024 15:31:21 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a170902684800b001e09b636cafsm4000955pln.287.2024.03.29.15.31.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 15:31:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 05/18] target/hppa: Mark interval timer write as io
Date: Fri, 29 Mar 2024 12:30:58 -1000
Message-Id: <20240329223111.1735826-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329223111.1735826-1-richard.henderson@linaro.org>
References: <20240329223111.1735826-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Reviewed-by: Helge Deller <deller@gmx.de>
Tested-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index ceb739c54a..8c1a564c5d 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2162,6 +2162,9 @@ static bool trans_mtctl(DisasContext *ctx, arg_mtctl *a)
 
     switch (ctl) {
     case CR_IT:
+        if (translator_io_start(&ctx->base)) {
+            ctx->base.is_jmp = DISAS_IAQ_N_STALE;
+        }
         gen_helper_write_interval_timer(tcg_env, reg);
         break;
     case CR_EIRR:
-- 
2.34.1


