Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10350C25B79
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QPW-0002wq-94; Mon, 13 May 2024 03:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPJ-0002qj-Rm
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:37 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPI-0001No-BU
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:37 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4200ee78f34so13124005e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586455; x=1716191255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OH/TFNVOaT2AXYWTY9lqS1dHX1CKyczy6W2/79bycMU=;
 b=GFfBhUOYkHTy6oWD3E4FDZY4oWUHb6ixsCIC1Z3nhSVYMjctYej3f+q3P0ByA0m6/B
 n+3cplE6eEY/IfcKh/gdghQk8JNCXUvEsbzCh2Zj5Qr0n12mTufbTrGUNyNrvLHSLhFB
 kXCEdxmo3UB9Fz6nbdljDVq5vV7hi96SVg1pvWp58k8r3lrYELCjKGpIM7322F4FfKSp
 9shAi2EhRjtZuptQdIsNVcDkxfiBgb7j5LjAwKbWYOChUzpNCNP2rMAPStsixAKrzuZf
 dNtGdZbHmtC1eOkcAYZd5EqYykpbX0FMg4x890mSlI6Fb7zOCPM6mg9Hemtd/XsP08mZ
 cXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586455; x=1716191255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OH/TFNVOaT2AXYWTY9lqS1dHX1CKyczy6W2/79bycMU=;
 b=J4Vu/865qbCmRcn8Mn9XJzUBER7TufVqZAdAbZ/jQg/FAL3+G2w+aUaUYoG3kIwWpa
 vQGCsKb3e98bBNK6idzQ0XL9c8BE/RL8jh9FHCrIj3VQPaluoxA5pLJFVKtr5vNXv3XR
 YcNxScwySVJyBD1kNJ0XAnX3+VxcYLwlpDcSW31rzkjjr3g1QDVUuQJBXaZGFD0Si/3e
 o2OKY1moK8N/Lp7cTHfclhtgVZDjec3Afq/26YKualBepvIgCJmmSYQOee++IDAR139G
 zbNsCMU2qTEjEP39yxfaKuQImd7dH/iDxg8p5d6mYaLg9Q9WD4zyQ8gfiLEYX6jnv3+z
 jjKw==
X-Gm-Message-State: AOJu0Yxl/nSAuN82wHqqUeZ63MPf6IBgazCwqAHZ98Xw0z39c6RgF75O
 ALkk0+kp8wfUblrUwV6+0wu80Fr8aeGntZ/tj1kNBZhVz8tM/UhTBofcr/dfrDLhhZ6yir25jyJ
 /wrI=
X-Google-Smtp-Source: AGHT+IFaZt1KSKGcjUSfVwFMqTHXF6S2Gan9SuoMvYJj359V6nVeuYC/rdQ+XscfjrkGb3y4psJtew==
X-Received: by 2002:a05:600c:1f93:b0:41e:dc7f:e2c with SMTP id
 5b1f17b1804b1-41feac59cddmr61732345e9.30.1715586454870; 
 Mon, 13 May 2024 00:47:34 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9318sm148204765e9.30.2024.05.13.00.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:47:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 22/45] target/hppa: Use TCG_COND_TST* in do_unit_zero_cond
Date: Mon, 13 May 2024 09:46:54 +0200
Message-Id: <20240513074717.130949-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513074717.130949-1-richard.henderson@linaro.org>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index e4e8034c5f..50cc6decd8 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1005,9 +1005,8 @@ static DisasCond do_unit_zero_cond(unsigned cf, bool d, TCGv_i64 res)
     tmp = tcg_temp_new_i64();
     tcg_gen_subi_i64(tmp, res, ones);
     tcg_gen_andc_i64(tmp, tmp, res);
-    tcg_gen_andi_i64(tmp, tmp, sgns);
 
-    return cond_make_ti(cf & 1 ? TCG_COND_EQ : TCG_COND_NE, tmp, 0);
+    return cond_make_ti(cf & 1 ? TCG_COND_TSTEQ : TCG_COND_TSTNE, tmp, sgns);
 }
 
 static TCGv_i64 get_carry(DisasContext *ctx, bool d,
-- 
2.34.1


