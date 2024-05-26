Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF77AC25B7D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:43:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJmS-000140-33; Sun, 26 May 2024 15:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJmF-0000X6-4L
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:32 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJmB-0007mQ-8D
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:30 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1f48e9414e9so2727955ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752605; x=1717357405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2xkTnIJzxFSsgLxwFEGJgc9RCPD2wi0PV4sGMffGtxM=;
 b=O98WC+38BpZpX+/HWyUgf7DHEDIzcTW6/R24wqlAE9yrOxNvbceNmH459jBh3a/ERE
 GUGonLc5wCwo8oz/A5AaWLx9nHWR3XmiD7J4pKvxABRMrMVjbl34Dito+lwtR6QxEQrA
 YAFSoSFGCEU00rTAIjF+84rDW3Ofj/He/FhuXhSvA7ozBjxoPqXd9GbO2/qRO1IigQ9d
 t+SN+N609Lh6XBHsiyFN46MWQOz2c6Ign10fX/4F5a2+Rw468/rKnq45GZUFW0jSekIG
 Js+G6Tjw7faWvWhdRkGaC5UfRaFezGi+YVv8w75lfguN/8CwqZ7u6gr9CnbttZl68l6F
 w7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752605; x=1717357405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2xkTnIJzxFSsgLxwFEGJgc9RCPD2wi0PV4sGMffGtxM=;
 b=sB4KmWuMpZ2ccnho/9HXRfoZKcoB8jRR3Sw69bbPz5uB1114ND5MljlSJi94vuJ+z8
 ZwaROh41Sa30j2CCOI9FDTQ/U7FuOGvOg6MoJvUN8GKBc8Inr7MJQNRxsQbcMbhAFReT
 BlSKWhF/sq5nz0QSql3h6TdS/BcLScHBASWpVsWQO8v+d4jvL8+71ptOuzUqwzutGGhp
 6y0ATjZifj8FO6BQirzWb2LZcL0XZkS3e6aUGK7/q9lSEYtZ4ZfOAr0CzZCK5xKlKbh6
 TSAUUcU3JFygwKn6kFivBRPhcYz9XKp62w2p0OZo2t5Yx8eO3BiSN5v0X7p7ODh2E4is
 9PtA==
X-Gm-Message-State: AOJu0Yw16p+2m27PQWTyxWjMj/aRHTIT76v1Awcag8xLem61PW6SWcBk
 oVhYPoVP/c284jUlRFt+FmR4y6FfjgeigCc15aCtI+xsnE8PqEiefSRilR6qNzRgqTd75yWfMyO
 q
X-Google-Smtp-Source: AGHT+IGoGAFNbMYjr5ZS0AH7vYGoE2K6yt6BnQMFWTgoR97D+6JwHPnjeUjVBfc2v7Xv09WUhVlztA==
X-Received: by 2002:a17:902:ea03:b0:1f3:81c:c17 with SMTP id
 d9443c01a7336-1f4481f22cfmr109993785ad.23.1716752604691; 
 Sun, 26 May 2024 12:43:24 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f46ad93c2esm28165935ad.263.2024.05.26.12.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:43:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 37/37] target/sparc: Enable VIS4 feature bit
Date: Sun, 26 May 2024 12:42:54 -0700
Message-Id: <20240526194254.459395-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526194254.459395-1-richard.henderson@linaro.org>
References: <20240526194254.459395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 88da5254e8..9bacfb68cb 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -552,6 +552,7 @@ static const char * const feature_name[] = {
     [CPU_FEATURE_BIT_FMAF] = "fmaf",
     [CPU_FEATURE_BIT_VIS3] = "vis3",
     [CPU_FEATURE_BIT_IMA] = "ima",
+    [CPU_FEATURE_BIT_VIS4] = "vis4",
 #else
     [CPU_FEATURE_BIT_MUL] = "mul",
     [CPU_FEATURE_BIT_DIV] = "div",
@@ -886,6 +887,8 @@ static Property sparc_cpu_properties[] = {
                     CPU_FEATURE_BIT_VIS3, false),
     DEFINE_PROP_BIT("ima",      SPARCCPU, env.def.features,
                     CPU_FEATURE_BIT_IMA, false),
+    DEFINE_PROP_BIT("vis4",     SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_VIS4, false),
 #else
     DEFINE_PROP_BIT("mul",      SPARCCPU, env.def.features,
                     CPU_FEATURE_BIT_MUL, false),
-- 
2.34.1


