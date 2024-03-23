Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BA7C54E58
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Mar 2024 17:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ro5C6-0002kr-3G; Sat, 23 Mar 2024 13:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ro5C3-0002k7-Fd
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 13:30:07 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ro5C1-00065S-OI
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 13:30:07 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1dffa5e3f2dso19830045ad.2
 for <qemu-devel@nongnu.org>; Sat, 23 Mar 2024 10:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711215004; x=1711819804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iCXMa8NXK4SslxAJzO8oJ4YsLhlZ/FlXinB3WAZag7c=;
 b=UnDychnUrUw8jo2e7a5xYAVECR2PLxrLWY4Oi3XRjrnAqrI9OoL8iU+G1XcUz6fzAD
 uJg/2WcxZOvWoj96oLcLwyY4f5PBQjUKfAMZp5q/ne5FmZwlHPoOHi0lRwt75X9xdshi
 pf+he90x5t2elKn/8we1HQXE4ukPu6aPOU7VsLQHmBJBSWxRFZ5BWqAmMW+kTF2OYHaY
 YvHyIxovU1p5JsXjxwt/uedB3Voc84gMdZEvds2C0I2BFzAqe9hTDX5F8C2mw6SzTDcx
 NsyS1ksBkjjAZRKemXbLhom7oc071bePz87MNw/wLjBvEyzB5XtXxqFbUr+XX4gK8Mhg
 Dqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711215004; x=1711819804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iCXMa8NXK4SslxAJzO8oJ4YsLhlZ/FlXinB3WAZag7c=;
 b=GnI4gxf4VLCiXqdZdjBlKZ7skFVlMhTR0ckV+cnRhSzrpQPbULelKyNkO8BnjjJ8i1
 rMJsK8t0ZGbEx/aaU5ubRSJPrKKTpiurzM+lpRHRQ7gMsjnJ2Ux040ZIo7Ox6WwNrxBJ
 7QYTySh0XlKxqhMPmnpE8+TJQgxcU7/r2EPGB262a5xD8qzenf8EQY7O3mI2tIIpwgv/
 hVzGut4c3FDQISfEKZAhgnpJKPWshM6U0advCQH4SyOJ1QKossVhh3kQ+iAcxwANOHI0
 ppLquP3yu3Vz9D5TN8hzA4j6xay8WEOckAHP9qLwI0xNfZBwz7ptRcf3BXx8WyPKShij
 yWog==
X-Gm-Message-State: AOJu0Yxe8vQgDljjEKdKLxqhrHQRlCIGcnwuyZE9tYsDxzIfcDfiIVO6
 hwXo2axWraBPd0Tz8/du89/4mZjRnn4DFa14r+raJLB3UKH17vGhEvkpAyBgw8pmsq4giwDtQTH
 V
X-Google-Smtp-Source: AGHT+IEKuFCX3s8lMRFtdAhZDVmpO87xwPgvk9b68sY+eIX/e6Xn59kdAPEBkBtx6d0XPoe/gaTt0w==
X-Received: by 2002:a17:902:bb8b:b0:1de:ebb7:d1ed with SMTP id
 m11-20020a170902bb8b00b001deebb7d1edmr2529598pls.45.1711215004144; 
 Sat, 23 Mar 2024 10:30:04 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a170902d2cf00b001dcfaab3457sm1811758plc.104.2024.03.23.10.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Mar 2024 10:30:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: svens@stackframe.org,
	deller@gmx.de
Subject: [PATCH v2 4/7] target/hppa: Fix ADD/SUB trap on overflow for narrow
 mode
Date: Sat, 23 Mar 2024 07:29:51 -1000
Message-Id: <20240323172954.1041480-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240323172954.1041480-1-richard.henderson@linaro.org>
References: <20240323172954.1041480-1-richard.henderson@linaro.org>
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

From: Sven Schnelle <svens@stackframe.org>

Fixes: c53e401ed9ff ("target/hppa: Remove TARGET_REGISTER_BITS")
Signed-off-by: Sven Schnelle <svens@stackframe.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240321184228.611897-2-svens@stackframe.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 2cb91956da..ceb739c54a 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1126,6 +1126,9 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
     if (is_tsv || cond_need_sv(c)) {
         sv = do_add_sv(ctx, dest, in1, in2);
         if (is_tsv) {
+            if (!d) {
+                tcg_gen_ext32s_i64(sv, sv);
+            }
             /* ??? Need to include overflow from shift.  */
             gen_helper_tsv(tcg_env, sv);
         }
@@ -1217,6 +1220,9 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
     if (is_tsv || cond_need_sv(c)) {
         sv = do_sub_sv(ctx, dest, in1, in2);
         if (is_tsv) {
+            if (!d) {
+                tcg_gen_ext32s_i64(sv, sv);
+            }
             gen_helper_tsv(tcg_env, sv);
         }
     }
-- 
2.34.1


