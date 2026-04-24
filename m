Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96D4FB44A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8Cd-0007WC-7R; Fri, 24 Apr 2026 00:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8CL-00072i-2y
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:31:30 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8CI-0002pa-Us
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:31:24 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7d1872504cbso6281511a34.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777005082; x=1777609882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WK09IV4jv+83fptexQw6qhQ3h5DqduadUD1Gz4A8BTk=;
 b=Ms4UiT5SWXYhqDm+jhlI0r3QTW7D2GDhwjVur4nO1XLxBdOsZS4IHeHuEbgR1wJw0u
 zdOV5AAVVuANXqLZoIB4QH1AcJ1qvncO+D6un6QZR9lZ8QOhdTutsMnTQmYEKpvLccEd
 z2S92Cp1z/mBkeAbulrNURHN5hdF5nTKdjccaQeZ/GVQFOfT+3tngf/QtJkVReeNv/ff
 qYXdxkS50eKIgmppFk+AAy7Y+Wm+QVGJsLdgEPM7j2sYc8PnLMRiuFCaYMPnOZw9dzoq
 l+GJgXeknQdLWfLwKr8yoGaqxb956KsjBiv3Th/kGpMvO4PShROBCDhosnK191bg2OCv
 2RYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777005082; x=1777609882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WK09IV4jv+83fptexQw6qhQ3h5DqduadUD1Gz4A8BTk=;
 b=XQhfGP6eJey0CnDuu7OgH+OYhwH1Essdo4kBokynYqcO+sK/Evo6xKyrqdHQfpZU64
 f1BN6CtB6JH8SDz2z7TkFvYsqp/gewwLm3IdxJHaDU8hzgAl1uqbgUXhhT+N2pw2SLgl
 8Mp5CMl1TS8HuAd+9k6pyU+ItazhjonGko9Dms/B/5x57r6rP2YmES5rsPos12WJIWHW
 NFktcHZTEAEUi9j/xLN+RnYC6trtLPzAkw8stkN5zUvVHzR5Rakebfi/KpcxSaP4PtZ4
 NwzQugeu+cm1ARIyY2LBCgEShylQOkJhGLhoQ9X+XQgdAzaJozazjsQ1rf6m1+b6su/T
 gr7Q==
X-Gm-Message-State: AOJu0YwVifS9d/n6+4W/Mh2HZTxg+XkGXmCNZiKKx0O7yMJV4x1aLTiB
 a9fWJTPDbAhQXmjbFqctoPDBhgwXE3YzZnZSebgdCdQlAe35+NZqT9gWa2XmLrIBCj4GEmw3PkN
 DglvrIz0=
X-Gm-Gg: AeBDiev1yNsbYfCBXF3v31zp/tLftBky4badWHyUxe8pXYuJPAFTaSz9Mgw5/aMafcs
 RfQpe7pLm6TsWoUtbMONAX4V1SShmfhotnXyKC6iWxwO1GftvoZ9KkAu9D2FW0w9GbXXL+ffbZM
 9SyRGDGvIGWvpLdz8pvB0LGzn7FPkuJk54A9Ya/b0QnKev3dVn1tXQkD36rZPlSTE0cuPaYmUm3
 6BPkyQqbMY7Q9ons+y0koU4bE11o4ARaC59AOpQYaORwgb9hvOc5Wr576RMNLfUWrfbs2KIkCWg
 wzzDHV98bgsgxNXpJVdY8wGM5DBfErSh8+QrnbZ70StgmuOjbopGgxZ3WSt/XHxkG2VrxHOHVtN
 Yw2HQ7LxgNDnUcPgQ38VXBGddIAbK4S1be84OpzBl7XdZgDUBo6YvNM6fPbcfdpIqd9fxY0/aRA
 0UVXnIyAdxtJ73BtsI+p7s3nE4GK1IZtH+pws/YlniPhrLowrQX5cEJiXLoJt2TQ==
X-Received: by 2002:a05:6820:2208:b0:694:8b8a:b43d with SMTP id
 006d021491bc7-6948b8abaedmr9535877eaf.29.1777005081663; 
 Thu, 23 Apr 2026 21:31:21 -0700 (PDT)
Received: from stoup.. ([172.58.183.19]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b9ac54ec5sm18880864fac.13.2026.04.23.21.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 21:31:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 14/40] target/arm: Enable FEAT_FPMR for -cpu max
Date: Fri, 24 Apr 2026 14:29:48 +1000
Message-ID: <20260424043014.46305-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424043014.46305-1-richard.henderson@linaro.org>
References: <20260424043014.46305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c        | 4 ++++
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 5 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 343536523a..40ed799fb8 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1287,6 +1287,10 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* FEAT_GCS */
     SET_IDREG(isar, ID_AA64PFR1, t);
 
+    t = GET_IDREG(isar, ID_AA64PFR2);
+    t = FIELD_DP64(t, ID_AA64PFR2, FPMR, 1);      /* FEAT_FPMR */
+    SET_IDREG(isar, ID_AA64PFR2, t);
+
     t = GET_IDREG(isar, ID_AA64MMFR0);
     t = FIELD_DP64(t, ID_AA64MMFR0, PARANGE, 6); /* FEAT_LPA: 52 bits */
     t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN16, 1);   /* 16k pages supported */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 579df4c47b..fda73d3d07 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -75,6 +75,7 @@ the following architecture extensions:
 - FEAT_FPAC (Faulting on AUT* instructions)
 - FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
 - FEAT_FPACC_SPEC (Speculative behavior of combined pointer authentication instructions)
+- FEAT_FPMR (Floating-point mode register)
 - FEAT_FRINTTS (Floating-point to integer instructions)
 - FEAT_FlagM (Flag manipulation instructions v2)
 - FEAT_FlagM2 (Enhancements to flag manipulation instructions)
-- 
2.43.0


