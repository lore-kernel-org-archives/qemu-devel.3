Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5158C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgC2b-0005J1-6b; Fri, 01 Mar 2024 18:11:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1g-0003x2-7u
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:52 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1a-0005oY-GI
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:46 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e5dddd3b95so361791b3a.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334641; x=1709939441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nZgxz9sv+Wfw3NEh+PaVP4+cTZIcAB3l+Ojbwy+/FqY=;
 b=JoQqJsukC/sdCxYeC04RI8lTFwT9Q/Vvt8iqAEY0Q5kIANSMH4MBIAfVoQJbl7l36n
 UseZ6Uoi8+2UH2Z56ltL0or42vOAZxeUBYiyBPJQ4n8+I1jpDchF7bgjSDjrdZK4lg1i
 xrikDcw4M/S7xOxE+PJOiPh73Ib18lkCnSzXqWn131Xx1J8xC+C08r2UuIzPMziq/CDb
 PYh272ZPZMvfTm4yjCNI4CFeqLCCgI/jzvAbQlRG5WpS0su4GSYNTAtdvvjOQkI4unrb
 xQZan7bcYGmC/SNNaQFv3HRmUMmfW73wVf1eHuYtM+unqU/jrwy7qmvq4Pt4eEJ43g7u
 /ymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334641; x=1709939441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nZgxz9sv+Wfw3NEh+PaVP4+cTZIcAB3l+Ojbwy+/FqY=;
 b=FcJ7ehP3o66QutpPxtR9ZrZ8qDXIE70ZKObZktevcfy6yD8lU95S7lvqjCt9n4QJMH
 iZu3PL2DClbXayfkmKmNrHtedsGnfp2w7MDA1TXrCYsqKtEgpkV58BnOJ1+4BP78/zUO
 idB6RovnKIgSOsRSLnAYHR9KtALMyHxHyBZgR1CoB9Eo4eIQRhMbrnSPuJKz9Wtvw9qz
 TcHjFrC0fXF8yyP5hS5tgbuzKMdX477RysCJr41ccBeFp3CUbC3hPwgwPZeKBiahG2Fz
 9UcDvuIHmFKPFQa3zJmCdk67CFeD15RmWgGdyFC/Dj0JW8QIrWfusuv3KKqJc+VYSFhs
 OcHg==
X-Gm-Message-State: AOJu0YwO1bBYjTJE/piM/3NgKB4lt8wI+oW4lRFqnBl4VBUI7ABYMRLm
 2JWYfFEnIFmNkshm5i/H1jca5T+q1Cmx6Ca6KBgr4RO++QrcEpNYy2ryhM+T+i9J70jbNqmPRBj
 T
X-Google-Smtp-Source: AGHT+IGS/Gnnhep5/8v52GmFZNAjO5E04snhFDEPYOGkKPGu1hfxQrHV/RK3TXqJ6ll+ccH1qBjeKA==
X-Received: by 2002:a05:6a21:2d09:b0:19e:3391:343b with SMTP id
 tw9-20020a056a212d0900b0019e3391343bmr8982155pzb.27.1709334641195; 
 Fri, 01 Mar 2024 15:10:41 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 c2-20020a634e02000000b005e438fe702dsm3449407pgb.65.2024.03.01.15.10.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:10:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH 53/60] target/alpha: Enable TARGET_PAGE_BITS_VARY for user-only
Date: Fri,  1 Mar 2024 13:06:12 -1000
Message-Id: <20240301230619.661008-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Since alpha binaries are generally built for multiple
page sizes, it is trivial to allow the page size to vary.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-34-richard.henderson@linaro.org>
---
 target/alpha/cpu-param.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/alpha/cpu-param.h b/target/alpha/cpu-param.h
index 68c46f7998..c969cb016b 100644
--- a/target/alpha/cpu-param.h
+++ b/target/alpha/cpu-param.h
@@ -9,10 +9,22 @@
 #define ALPHA_CPU_PARAM_H
 
 #define TARGET_LONG_BITS 64
-#define TARGET_PAGE_BITS 13
 
 /* ??? EV4 has 34 phys addr bits, EV5 has 40, EV6 has 44.  */
 #define TARGET_PHYS_ADDR_SPACE_BITS  44
-#define TARGET_VIRT_ADDR_SPACE_BITS  (30 + TARGET_PAGE_BITS)
+
+#ifdef CONFIG_USER_ONLY
+/*
+ * Allow user-only to vary page size.  Real hardware allows only 8k and 64k,
+ * but since any variance means guests cannot assume a fixed value, allow
+ * a 4k minimum to match x86 host, which can minimize emulation issues.
+ */
+# define TARGET_PAGE_BITS_VARY
+# define TARGET_PAGE_BITS_MIN 12
+# define TARGET_VIRT_ADDR_SPACE_BITS  63
+#else
+# define TARGET_PAGE_BITS 13
+# define TARGET_VIRT_ADDR_SPACE_BITS  (30 + TARGET_PAGE_BITS)
+#endif
 
 #endif
-- 
2.34.1


