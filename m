Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4C4CD1291
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 22:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqKlK-0002cl-MU; Fri, 29 Mar 2024 18:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKl5-0002Yh-Ta
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:31:36 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKl3-0003XG-T2
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:31:35 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1e0fa980d55so20855055ad.3
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711751492; x=1712356292; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gQ+m60fTouB/z1dl63SfVFQPMFAMSTWz5wWftzZofAQ=;
 b=jA7plFwNEpab3qwlR02+D9TLzBussiynHPlVK9xBHhTNcX2Ylfs6G6d3wQRM90jDQC
 jiTGarw09WOAeJvKBc4+WTG8ft8hh8eC/gs/1ifRyoCSJ/YT0Ss8TMwPSxuBHV8z3P0U
 63p6FPz6MwkMlbMBe3PiVXyu1Ic+rzAyc6ARa6FrN/58YonjwenV1t69h4GhG/j1TAgS
 jWFzUQdEhWbMvEtzCWPeUjb1h/m8xqdo81e/Uooalw2RZf5qc+k3B6hZ8UO50u6rsFZ/
 L+HBbLlN7PGEE1U7vQYsRU/RwiVwKJ+As5qTAlN8+puC40UroiAl6FTVmfltpnLe6Rnb
 iJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711751492; x=1712356292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gQ+m60fTouB/z1dl63SfVFQPMFAMSTWz5wWftzZofAQ=;
 b=n/lsxHFXzHpzMO1gjD8E6W7s+Ns+qQfe/Xpba3n3sYqzHfYBvjIPMPB9SLWfqf/o1T
 +q3ofsOhkSZLyJgYkSvTCrlnxIWvF90F0YQDJIIOGBQuFpmmGl9U6jd0S1N9I7Y2yfGU
 kBGWuDpYKJp7jccoXWnUz6krYuQkzE2GrycwL4Tzt+Pvc+yN3zXT68Wj7fWP2a77YlPV
 RtmZOzPiHrVH1yFxUNbI6Ub8HPJkHgrYyYEUBMQwcAWc2+m5MXu8hzVzprcYJnmu4o9H
 Z4cx5VGTX5y/0hG1n4D+rT3C9EudmoLujiKaI7pC+YsMoVDkDA8jG/LMSvpxPzZZeDD/
 fXkw==
X-Gm-Message-State: AOJu0YwqkRifa7FZ5geq4p6NGgeir7QG6uwhvU+ACZ7Nmgfl4MJwXV+J
 2y4S73HKCsAruQd/jBhYIJq3rIUZK1YqyNWKXXxtuO5pbJb5lPWOr2rtXmXb+rid9Ju8Z1BJV01
 H
X-Google-Smtp-Source: AGHT+IHUJIZP4SnNn+e8TZXA2Qv15Gd1Q3twIlnohkGr05IhlUt3U7grEo2ODkg2APWT8V8SjlqdNw==
X-Received: by 2002:a17:902:e54d:b0:1dd:c288:899f with SMTP id
 n13-20020a170902e54d00b001ddc288899fmr4360935plf.18.1711751492617; 
 Fri, 29 Mar 2024 15:31:32 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a170902684800b001e09b636cafsm4000955pln.287.2024.03.29.15.31.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 15:31:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 13/18] target/hppa: Replace c with uv in do_cond
Date: Fri, 29 Mar 2024 12:31:06 -1000
Message-Id: <20240329223111.1735826-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329223111.1735826-1-richard.henderson@linaro.org>
References: <20240329223111.1735826-1-richard.henderson@linaro.org>
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

Prepare for proper indication of shladd unsigned overflow.
The UV indicator will be zero/not-zero instead of a single bit.

Tested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index a70d644c0b..9d31ef5764 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -707,7 +707,7 @@ static bool cond_need_cb(int c)
  */
 
 static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
-                         TCGv_i64 res, TCGv_i64 cb_msb, TCGv_i64 sv)
+                         TCGv_i64 res, TCGv_i64 uv, TCGv_i64 sv)
 {
     DisasCond cond;
     TCGv_i64 tmp;
@@ -754,14 +754,12 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
         }
         cond = cond_make_0_tmp(TCG_COND_EQ, tmp);
         break;
-    case 4: /* NUV / UV      (!C / C) */
-        /* Only bit 0 of cb_msb is ever set. */
-        cond = cond_make_0(TCG_COND_EQ, cb_msb);
+    case 4: /* NUV / UV      (!UV / UV) */
+        cond = cond_make_0(TCG_COND_EQ, uv);
         break;
-    case 5: /* ZNV / VNZ     (!C | Z / C & !Z) */
+    case 5: /* ZNV / VNZ     (!UV | Z / UV & !Z) */
         tmp = tcg_temp_new_i64();
-        tcg_gen_neg_i64(tmp, cb_msb);
-        tcg_gen_and_i64(tmp, tmp, res);
+        tcg_gen_movcond_i64(TCG_COND_EQ, tmp, uv, ctx->zero, ctx->zero, res);
         if (!d) {
             tcg_gen_ext32u_i64(tmp, tmp);
         }
-- 
2.34.1


