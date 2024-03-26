Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061ACC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 06:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp0Xf-0004V6-Op; Tue, 26 Mar 2024 02:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rp0Xd-0004Up-QW
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 02:44:14 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rp0Xc-0004Xw-8n
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 02:44:13 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6e675181ceaso2836844a34.2
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 23:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711435451; x=1712040251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VDIupqWKv8Wdkk0Q3yVmDJqHZnSDTz4Dyh6M/jZqxCA=;
 b=DK7IzRYeCuAgwn40v3UtNhqxXq9l6/AK2918bIKVuQfu0vQyki8Vhdur5uW54JNnbw
 cd9VFKvbazcVUkXRhYxjKUpXBwOj9OfLQhkiuj0uE7eUWoDk2/NL9tNAqNZC3YZncDfc
 1/4dYR51VpSFgVLLH6yV4pwAUlndV5IrMhViFOwfJ9vhbt8VA+A8dNaAND/L02hpPz/d
 B96ja9aM+OSMytDlJYR7O3+K/Ixu+4nhPdvFn+pz1OoKvW0DMkChTn5j9bwB7s9byk9L
 OukkQZZD8f2Or1/bo99QsJzOH5Qhfh4K4xJpJvTpY62t4KCsH0Q1OWwZUd4bKD8xo+A/
 9dDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711435451; x=1712040251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VDIupqWKv8Wdkk0Q3yVmDJqHZnSDTz4Dyh6M/jZqxCA=;
 b=MWy9nfnnsOH1dBQirOZ5bfrV5usWS5eyHKCYuTyCZLLBhaJS9ViXbIkzPBwuiTR/em
 EUj94GPiXv82MmpBJx+m0tx8jeew8nZK/llKvmX3DeBl1/lB+wmF5ZkScPFJbu8jsIIG
 UqHpycY0VQP9KcyHzmk8VRKamteLmjDgVU1dStQgOX3S1vDeNxxOGaeFhMGf48p49PLt
 7d5OAcdcUY5bhLvMFdMnRsRm8IEnri0NgrcUdWetzsE2uc8oPcT7EdhYl8Hdogks7PY8
 WRLMpLRwkFEpGz2bEnereobIPzPxHfYPgOQY72vlej3JJzJgAkJDUlZnqxzWKStKrGju
 /dJw==
X-Gm-Message-State: AOJu0Yza1MQM3Utz4qMiH3JzpEVp6z71PFuS9ueo/q/f4SKx0HJqp+kn
 yUJJI1La2+9LIyRH3Cyn9R71ckIthzg9q8SFEblPxsmIMay9m04j28JnO8sr4roKfg10vBHFF/C
 r
X-Google-Smtp-Source: AGHT+IEhOw7nWC7b2/n6ITT73WQqyEMBOvb7Ii/sq267zr+KbdeYhN5rWWT0WyEmu2K1Etc3YTZYmg==
X-Received: by 2002:a9d:6e16:0:b0:6e6:d1ac:c989 with SMTP id
 e22-20020a9d6e16000000b006e6d1acc989mr5398447otr.6.1711435451014; 
 Mon, 25 Mar 2024 23:44:11 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a633503000000b005dc36761ad1sm6958819pga.33.2024.03.25.23.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 23:44:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 2/3] target/hppa: Replace c with uv in do_cond
Date: Mon, 25 Mar 2024 20:44:04 -1000
Message-Id: <20240326064405.320551-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326064405.320551-1-richard.henderson@linaro.org>
References: <20240326064405.320551-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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


