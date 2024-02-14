Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B65C4829A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 01:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra41v-000778-7U; Tue, 13 Feb 2024 20:25:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ra41t-00075t-Bl
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 20:25:41 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ra41r-00014e-Nj
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 20:25:41 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d93edfa76dso40229865ad.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 17:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707873938; x=1708478738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8A+ZdhxnkDzIAc1RYMXIDcGYuypp6UD3QlbP2p+Il38=;
 b=QH/Poy2MLvsg/8KFEufLR0taJfPu1xQPTUK+cagcWVcxZxmV9ks54/dAvo1ExOKFwz
 OkcejTfFubXrd2UTgPmH2WSadiGNjGBv9NC/4UYGZMyAdaXqfv2J3/jCzN6xvaVv3fhk
 Uj6sBZ4hh5l8/eZxXASTbinKzdT3h8k9AS5nWAFY+c0L6SL4U/oxlPZNAkyuR6ZxQGev
 WVU9fVasIHDVfh8EgGxvfDDTeJYnIJnYyxxZh9efI2//+V+jxR+rtix8epLf7qr7qaSf
 M8+4yVXqjY2GU0Xi5McO7rFvgI0xkMQ4e0eUlE9oFkyOMDQZUx1AErt0ahFL+pHjWOaf
 Pv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707873938; x=1708478738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8A+ZdhxnkDzIAc1RYMXIDcGYuypp6UD3QlbP2p+Il38=;
 b=fErBhsdO6IZcufW5bxEBOBXc/SS4CyIgq29Ro+KrYtlyFInJhp6HL2thtXsj7gpn+S
 D/ADQTxbYuF0FEGLs5mS1172oH5B/e201nGvi4nZx31/AWN622nxUcvZiWMiSHEy1dzM
 UxEUhCB6ZV5k5a5E+QtkQ1+CW5ehTEv+hOOm8v0lomkOP6D49/8EuX17FRxKfR0RIuR/
 6vpEPZrXy8mcRJYc/JtrWSM+zccKvQPdNrWdJvuePqd2L6euORfBGPRtKD9ObOL+AAI4
 R3KfGXVgYWgh/A2MenmOwy1CzpwqcjscBn5TcThYy79OdHx2lhX3TI9MJlpE+y6Wz340
 rIBw==
X-Gm-Message-State: AOJu0YyEPelOukibUEaQe3M/CKtRKoDbkDcX9Qtk7upGo7a9ytb6E6zI
 8QsILhiSwgS7z9vbLM2vcacLWSV2K/2+zBvGtOC/thX9MErphqsxGx1Qnd8Xqn81VuK5Mhmf5gu
 V
X-Google-Smtp-Source: AGHT+IE03+QtV01WIrZEKraUxmIHoXzL7NdprP/ct5FbZDAZgDsh4OhjwQAEF8Tw42E6m/f88LyoMQ==
X-Received: by 2002:a17:902:7d84:b0:1d9:7121:170e with SMTP id
 a4-20020a1709027d8400b001d97121170emr1317239plm.35.1707873938247; 
 Tue, 13 Feb 2024 17:25:38 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWFzPvKwNTRMXM69uBjd/faSb0cPVHmZBeyfUTnkY+RpIf9MYFc3+cboZBdjGVBfucPYFBV9GORelr1ZeziPtiamah8dIjrbK5r/EWIO8KhKds=
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d11-20020a170902cecb00b001d961f28b0asm2660333plg.270.2024.02.13.17.25.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 17:25:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 1/2] tcg: Increase width of temp_subindex
Date: Tue, 13 Feb 2024 15:25:32 -1000
Message-Id: <20240214012533.453511-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214012533.453511-1-richard.henderson@linaro.org>
References: <20240214012533.453511-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

We need values 0-3 for TCG_TYPE_I128 on 32-bit hosts.

Cc: qemu-stable@nongnu.org
Fixes: 43eef72f4109 ("tcg: Add temp allocation for TCGv_i128")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2159
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Tested-by: Michael Tokarev <mjt@tls.msk.ru>
---
 include/tcg/tcg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index daf2a5bf9e..451f3fec41 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -412,7 +412,7 @@ typedef struct TCGTemp {
     unsigned int mem_coherent:1;
     unsigned int mem_allocated:1;
     unsigned int temp_allocated:1;
-    unsigned int temp_subindex:1;
+    unsigned int temp_subindex:2;
 
     int64_t val;
     struct TCGTemp *mem_base;
-- 
2.34.1


