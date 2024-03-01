Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24491C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgBy9-0005SR-7k; Fri, 01 Mar 2024 18:07:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxb-0004rK-Dp
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:37 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxZ-0004DK-VV
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:35 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dcd0431f00so20092965ad.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334391; x=1709939191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zYkpQqoaMHDWxrt9KPP15xrK5H9LSGOtZoW36Ee0L04=;
 b=xhmLORufVFrs4Wlyc1lAnnduiPw2cZI3KC6yuNbI0pneuPJ8XUa4N2AzAai+aLxvnK
 5icri/0GhBeIsWpJGPC0feazGh7l+CvFm609Ck2EhGx9z03Immb31sz1zuec1SuNMBVk
 ErZn2BldOLgeSohUjSG7/GpJA4G32tGh1LDylQLcpEallPgXR/Ap8VKzqeQOsHEcNEoG
 tWmTV5KaHllStVigB2lMcOJbI+iWHkVgn6DZc2d+99qFKaI62kj3DrPKY/nrCp6nCelg
 XCwVQGo/UG1ewu5U0v+cBmfHf4yHKYlW5vRQs75+QQl2Ha3oRaWWIsZsCMtnL2RE6jzL
 X2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334391; x=1709939191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zYkpQqoaMHDWxrt9KPP15xrK5H9LSGOtZoW36Ee0L04=;
 b=EEM4jXTHIep5EHhb3SNsHIBRga6EZEE7hMbSBdbKyz+f35VUAq0CRTT64ildgMZRw5
 3koFAjiOzpLMVAwyUGDeHJYJDX8t1GdAdCf7Xwxrx3JItW3wOcyu2Z6m7sgSQGsNkfa5
 q+ssyIgL1TtwjZye/EhRIEGY9crJdojeaFHSkVh86YJuO5xr+HYtt35OhS1fU7kDxZdL
 h8ROvM9Y/AvG1KJoCxkN/rnIrHPmlnAxx6OgFwGHBpcAmU5wLjZ5IfMzFjiQDeZuUgv2
 5xnDzKz4pEPWQtL7n8/Urwhaw8e959VpbEgc+CZFRAqLXnOitoTPFH4QgyJcp5cPFl/W
 wTag==
X-Gm-Message-State: AOJu0Yyc8vwAMjKYM9aPJHRI7FyMz1qRi8HHZB+QV8Gge4Y2xO8LjEqn
 +VaFkIJZC2mORYFIo9dNiPwyGpsRjq1iE+YnqllXafnQQcGScfYDRff0Rmm6DF5/1aKdyl6xMUb
 n
X-Google-Smtp-Source: AGHT+IHL0ymjXRyQUGELhQHc/vNMAGDuobcq6m/6d/oPI7pKcQOnFX8kGhFwHiY9MaxOFijOVazSZg==
X-Received: by 2002:a17:902:c94f:b0:1db:5c84:9523 with SMTP id
 i15-20020a170902c94f00b001db5c849523mr3765895pla.67.1709334391394; 
 Fri, 01 Mar 2024 15:06:31 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.06.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:06:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/60] linux-user/elfload: Truncate core file on open
Date: Fri,  1 Mar 2024 13:05:26 -1000
Message-Id: <20240301230619.661008-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

While we usually create a new corefile, truncate otherwise.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 877799e9c7..16dd08a828 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4652,7 +4652,7 @@ static int elf_core_dump(int signr, const CPUArchState *env)
 
     {
         g_autofree char *corefile = core_dump_filename(ts);
-        fd = open(corefile, O_WRONLY | O_CREAT,
+        fd = open(corefile, O_WRONLY | O_CREAT | O_TRUNC,
                   S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
     }
     if (fd < 0) {
-- 
2.34.1


