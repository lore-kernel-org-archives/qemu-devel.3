Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB5ECAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 13:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v28LS-00089Y-L1; Fri, 26 Sep 2025 09:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v28LQ-00087g-0u
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:18:40 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v28Kw-00043t-0b
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:18:39 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e430494ccso1323715e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 06:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758892677; x=1759497477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2uZvm9cPBkSG9bbZTTshS2q8p+jP2mb7XOCO/jSy1Uc=;
 b=OEJUKjWROEJVFjEGw/gE6J8FbHNTWQ32TfHOypCQqj0eAPpMJc3xj148lwa/R0ghRO
 LEZR+YMfdKk7FJRydwR6aJTMsZ8J7+7QVoH15vtvDq4cn+/WcMIBKZnXEvRylVrVjwNu
 RWKQSEm/Y9vYDIbInZsipkXVJlsdj5KRqBjy5+YAkhp0vqEb5WFyMJehd/Ivh+8mtRPw
 PA9mLvm/rzh6FFnYj3o2clhpy11Cm0z/DWo2EShXZBDaotAna9Vk4TYXri1P569eCOlZ
 IhDOquSxLzAO2dShLyekJ8dYQ1FFWjkIHfIACuw0WNJJb6hwQDfv6BSpeVaTHAvXF0Sr
 wnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758892677; x=1759497477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2uZvm9cPBkSG9bbZTTshS2q8p+jP2mb7XOCO/jSy1Uc=;
 b=t0hkwEdP6rcVZuIGxT/hVr28THP+E9yRSgefdG1tRKym7lgDLeePTzlSUwndQ9xuga
 JU6IkwuS/POxJmyGBjgFPLItOMTFOoXbi6lRA1mdXBDMoalJjBce6VLhmmtB8hY3EF5T
 +sVxUXAo9OEpdQYsV6C/IK9M4YsHebKs21YtoWq6RDnVrX84eTt8N+BI5WbutPlGPPgI
 9pXxJyqzI8kpx5idq5MLWrZQ58E2ugrbviVnC7Qep+JVuIwY7kxn2Fm45ufl2c5gYQz6
 xoJ8N65fsSnk5jkZSQQDNxztstPqwfUc5+Yr1xnBPBrDYFIUsjJxKwc34G/qgtJ8Rsi9
 pyng==
X-Gm-Message-State: AOJu0YzfTJnX5kkne9t6xL1d+UXEi8pUmnE9649e0ru67brRp8cHaGVJ
 eRyqEQVGCQ5NhKambTs/Iptf7tGZI3h2KCw2vYSifwDatI7aqTB1LIUnIKPOx+amfJzXRUALjMx
 Cr9fh9Qk=
X-Gm-Gg: ASbGncv/9t2azNlj1jL33WJbAFgT6kVciPGRQsg8Kjs0ekBQOmj2LrPdS7pm+Eefdwn
 dVcH94RnnVZGG86O3voQVf62rzMgrWxCBzYOv4qh+SkFEqs8jdzcL5izuSwF9ek2IQ8NmgH99RM
 9CjOZR0k7Nud/v38DmN9zET2dikoaXTskTHaYLQX3OqG5rogEHs/+eAFnCmfq/qkt25AXvRglyc
 2ytlt3u/jokvakwRehDqaxc4DtUN8qjKZF/iXB3MW4bXHulfncw6aB7ZmoP5hwJynxvdA/hZaJi
 0pNSY1++9WnrLllkHk12Ag0V7HqvDaBgvKWibBfIjtgfkJCewhnoWEthBiY5tEipozw2WCraZ9t
 rTTuCWBwLFopV7SioRRutkJ0=
X-Google-Smtp-Source: AGHT+IH7SbjjlyWml6WwYtidtfOkUi5BbTCCKHdAaRNnD4C4oZBo4oXSjY95863Y6T1UyOH2BuP5Cw==
X-Received: by 2002:a05:6000:2504:b0:3fa:944b:9bc3 with SMTP id
 ffacd0b85a97d-40e4dabf402mr7201204f8f.62.1758892677207; 
 Fri, 26 Sep 2025 06:17:57 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb89fb264sm7315137f8f.20.2025.09.26.06.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 06:17:51 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DE3CD5F913;
 Fri, 26 Sep 2025 14:17:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 12/24] semihosting/arm-compat-semi: eradicate target_long
Date: Fri, 26 Sep 2025 14:17:31 +0100
Message-ID: <20250926131744.432185-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926131744.432185-1-alex.bennee@linaro.org>
References: <20250926131744.432185-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

We use int64_t or int32_t depending on ret size.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250822150058.18692-11-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250922093711.2768983-14-alex.bennee@linaro.org>

diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index 29cdab66f73..3c9192d8684 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -501,10 +501,13 @@ void do_common_semihosting(CPUState *cs)
         break;
 
     case TARGET_SYS_ISERROR:
+    {
         GET_ARG(0);
-        common_semi_set_ret(cs, (target_long)arg0 < 0);
+        bool ret = is_64bit_semihosting(env) ?
+                   (int64_t)arg0 < 0 : (int32_t)arg0 < 0;
+        common_semi_set_ret(cs, ret);
         break;
-
+    }
     case TARGET_SYS_ISTTY:
         GET_ARG(0);
         semihost_sys_isatty(cs, common_semi_istty_cb, arg0);
-- 
2.47.3


