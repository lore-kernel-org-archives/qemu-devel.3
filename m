Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257F3CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 19:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lgF-0005jd-36; Mon, 22 Sep 2025 14:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lfd-0004bP-IY
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:53:54 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lfC-0004yB-KT
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:53:52 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-269639879c3so47715595ad.2
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567202; x=1759172002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YZyzytTG6Yaz6DpHagIM25/JOwu8QYdC7JKQkoo6/E4=;
 b=a9vlamDycBmA8SELDISum7J9sR3vKBdiDtOpUXarUOveL5g/kNwDfCi+gS4EL+9QfV
 hJvW1voW2THeQysSb/JlWO7lydhtnWa2Q7c/Q/Z6Ct6s56BHpOcuKPHzkg1PWuv4jedF
 Su+lOsL3LNuDCUQDt3fgNxw0mw3e76lS/Dw/SlQlzBt6McS+KsGkqaO8QVakurFA6iEt
 p46YXM3on1xeQhxJPy50k1U8OV50REjp/AjZxJWyxirihNZaq0k89sRNiHVRFPrXUgKT
 meRiAHj3gpN3gQ/YB4QqtCBPDg2m3fPKvsnQlMhZBGvSs6B6G62GdxgG3VYOsukUAz2b
 s7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567202; x=1759172002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YZyzytTG6Yaz6DpHagIM25/JOwu8QYdC7JKQkoo6/E4=;
 b=w5rrj/i7sPr+xKldnDYCR9OJXgK2/jx32vKMZ8MoRGtMbNNQKTNmv3wjDOWrR/O5ZZ
 CYT5D+vDns3S4DJ5wFdng1ueCpVfrKIErt7dYVIRfnAACNOwCMorpCh3jkaM/fjrYjB6
 XsyvViH/gA+K6f3pRkVEeWm7wdP974cw3+GI3zBnuvDThsFD7u/KtLgGN1AiyN3ZluXb
 sEjkjV1ajYQSRJVPah8Opzou8o9+sbZ+vc/Ln0cLkHvWkakqkYmNO6R0s2hsm/pH16Tg
 ADtrpGhLoPha86bWfm04/7EMtra62JRQN4kEhOhsoCM8NZa8z/FHBIn4+OyYyGIAtNlZ
 U9TA==
X-Gm-Message-State: AOJu0Ywln33mT67Q2gQGDgLFdkRcnMGsnF1z7SfowfnWlqVNFDrPCUx4
 2YJT04vl7cais/KfE93ET041xig8QN9kH6tRmv/4bazOZsbW3xblQ1ctpDgYMy8NXGWXFIKHJYP
 x3yJm
X-Gm-Gg: ASbGncvfJXrBeTLvD8Z6lDAZGVrRIiq8vZtcbwrLEtEjuaJPqKQdW0+FdHGv0AQgzCV
 Gl7xjO3fdM1Tu1u5lszcgHjin7YZoKsTWXTAV+nqAc185Z+0mQLoM3xsurG7HG3/e4HGxsFzXRq
 m0/Mh1hijbphfbYPkliHdnyffP7RD8ksvHCUbOFRv0GvtlXAgisd6/NPKFx4nGanL281UuCx2zc
 OasuL1d++1J4ENglKFln2vuiAdIJOe7zXgvpX3tGM4qHfQpd+T+onc4CdVxkZhZsr2zPqcChsqa
 aAQDF1dF5j2gQdVMfJdu/C6wuzvZWZooNDVat0+Ke5iSJeDRrssQIOj6O/LH5SGBV8uc5wdWdEW
 VLVT/hN/3dfCH1TMUZTfEXTQWkRj2
X-Google-Smtp-Source: AGHT+IHDF+lSQomXVZ77tmiKbqM6PI0GOUCHza8kOVKg7aq9Bp+GxqJJgPIEDgsyh0aiNAOSTlOp4A==
X-Received: by 2002:a17:902:e550:b0:272:2bf1:6a21 with SMTP id
 d9443c01a7336-2722bf16e99mr126366715ad.14.1758567201849; 
 Mon, 22 Sep 2025 11:53:21 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2698018a472sm138554795ad.58.2025.09.22.11.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:53:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 50/76] target/arm: Implement GCSB
Date: Mon, 22 Sep 2025 11:48:58 -0700
Message-ID: <20250922184924.2754205-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 8 ++++++++
 target/arm/tcg/a64.decode      | 1 +
 2 files changed, 9 insertions(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 2849805f1c..7e45197d8a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2080,6 +2080,14 @@ static bool trans_ESB(DisasContext *s, arg_ESB *a)
     return true;
 }
 
+static bool trans_GCSB(DisasContext *s, arg_GCSB *a)
+{
+    if (dc_isar_feature(aa64_gcs, s)) {
+        tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
+    }
+    return true;
+}
+
 static bool trans_PACIAZ(DisasContext *s, arg_PACIAZ *a)
 {
     if (s->pauth_active) {
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 2ae73f443a..01b1b3e38b 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -248,6 +248,7 @@ ERETA           1101011 0100 11111 00001 m:1 11111 11111 &reta  # ERETAA, ERETAB
     AUTIA1716   1101 0101 0000 0011 0010 0001 100 11111
     AUTIB1716   1101 0101 0000 0011 0010 0001 110 11111
     ESB         1101 0101 0000 0011 0010 0010 000 11111
+    GCSB        1101 0101 0000 0011 0010 0010 011 11111
     PACIAZ      1101 0101 0000 0011 0010 0011 000 11111
     PACIASP     1101 0101 0000 0011 0010 0011 001 11111
     PACIBZ      1101 0101 0000 0011 0010 0011 010 11111
-- 
2.43.0


