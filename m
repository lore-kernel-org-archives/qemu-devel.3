Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B961C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QRA-0006C9-0Y; Mon, 13 May 2024 03:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPW-0002yd-K1
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:50 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPQ-0001Pz-Os
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:50 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42011507a4eso9205025e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586463; x=1716191263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lYICVLRWbF85s9jaYUNXAJVer+rQQT46dzOe8LbGwwQ=;
 b=uR+vzGJKkk5+PNN4DkB2wGLJnaSzWzgDgaAzr52QGzF4VjFGOVra2jJqPI9THXxbOU
 BdAUPzrT8j9WcOmOdSpdSG7t9CXgqM/84QTlLLWmeIV8DNOl4PrAyxNhvH1nj4oRwBHM
 XaNEB+KSfcmndMyyI2qn3DP9ZGRdM1ekTYDVT1xfIAbqrbfF1jHyyP4HYlDhpo3sskuF
 btfySwtBVTrGQgPIT0oTOJ07W1R+ZrQaSQzc5Tqxg/d5NVyKCR1jsioZt7SGsgzc+Ujo
 0ogFhtG5kd2uPJnwY+7fF0XfaogGLmyh0MvQewMxlakgG+P2I4a3dGNHkF7VnS19y3fL
 KsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586463; x=1716191263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lYICVLRWbF85s9jaYUNXAJVer+rQQT46dzOe8LbGwwQ=;
 b=gNIpWghDbOxr/bwCDv+jZLujzLHUoCpCOXbZ42f3qzycigt6we1zFLchZTQsHi9Hzs
 eCSmLIPDoXUwLCjlo4YnnIyEYKqnVzqq8MhPWWgXmMIlLbqSJsEpzyj+MW1v0Jj1d1KK
 v+8gADfIbo5Se+t8De6XeVBFLS4qmj7Vm/HOs63opac9PiQxJGYrieuwVdvHuKJff9E9
 qML6CiZ1rO4/F41LfToMmGWA6FTZJMVfrvs7a+QLygBKRIe/s844lEbmZXdI4oHmB8CA
 Hyi8X5FN6tzk1K1RpGpRUxvIfPzUX8qwdLXDclAlm02u/pfD55NFDrjLWCFjGmDs+IRL
 Oobg==
X-Gm-Message-State: AOJu0YzjsaktF1+aYCXalFc5J7Ht3EdvGDdvY+fDkl4g6ICx2D8Kl86K
 bKtreB89tY8P4hLnsfm29uoNAco2LUDoKlW3lxK6alUJ4bF8/fQc1yWvECnPtFSzMCPD4noplYD
 a4eA=
X-Google-Smtp-Source: AGHT+IE8Tfqc7itqhvg4N0cWGf50/8CZNFBibz0GSdJYGTmjwkJPcl+PYRpxL6JQh6alaaCKrDbc9A==
X-Received: by 2002:a05:600c:4f04:b0:420:139e:9eda with SMTP id
 5b1f17b1804b1-420139ea0c7mr24276865e9.12.1715586462861; 
 Mon, 13 May 2024 00:47:42 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9318sm148204765e9.30.2024.05.13.00.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:47:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 33/45] target/hppa: Do not mask in copy_iaoq_entry
Date: Mon, 13 May 2024 09:47:05 +0200
Message-Id: <20240513074717.130949-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513074717.130949-1-richard.henderson@linaro.org>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
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

As with loads and stores, code offsets are kept intact until the
full gva is formed.  In qemu, this is in cpu_get_tb_cpu_state.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 67197e98b3..abb21b05c8 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -637,15 +637,10 @@ static DisasIAQE iaqe_next_absv(DisasContext *ctx, TCGv_i64 var)
 static void copy_iaoq_entry(DisasContext *ctx, TCGv_i64 dest,
                             const DisasIAQE *src)
 {
-    uint64_t mask = gva_offset_mask(ctx->tb_flags);
-
     if (src->base == NULL) {
-        tcg_gen_movi_i64(dest, (ctx->iaoq_first + src->disp) & mask);
-    } else if (src->disp == 0) {
-        tcg_gen_andi_i64(dest, src->base, mask);
+        tcg_gen_movi_i64(dest, ctx->iaoq_first + src->disp);
     } else {
         tcg_gen_addi_i64(dest, src->base, src->disp);
-        tcg_gen_andi_i64(dest, dest, mask);
     }
 }
 
-- 
2.34.1


