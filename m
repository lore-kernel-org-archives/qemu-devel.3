Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8AF4C47422
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:35:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT2gE-0006qE-0P; Thu, 25 Jan 2024 11:34:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rT2gC-0006oO-67
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:34:16 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rT2g8-00027o-KC
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:34:15 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-510218ab26fso623003e87.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 08:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706200450; x=1706805250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=anUa6cuHSmZzzEibxDgwncRp2+N6Aqc5mYUw8MYy6MY=;
 b=MM4SVWXs+fX+UNG98SQN+nuhHOdoEZ0UZN8CCGp19RihZ5wOiV/zXvZqcicT4xpga7
 YJj1NNStjfoXL/gLLknanQLBtkiq3Bmm0cmUisw8IRvnE/SqVEAWyQpL+eShGtrLth0P
 b6q2P4khUCJNkKZJG3QTTJgb0OztLxpPTzh7/imjbc43bZXaSAw2Dkr70N7rhyd5jkn8
 G0YNb3C8jIToUu9HXm8IqJDkXxUhTVqhTB2bQExELsk6+HIUoUgO4DD9v3iD8HrSU8JP
 ia5sCaXm5phomK+mO1IzG60nSen0Mr9eCKhPMpJMwEyAT2y8Y49d1zsmqDewtfoWMtAZ
 O5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706200450; x=1706805250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=anUa6cuHSmZzzEibxDgwncRp2+N6Aqc5mYUw8MYy6MY=;
 b=WbMh6QjEbW+hhHc7qckKwCtRuHvvUWOEy2McbZh7i+P7Bcemu97vtLuvTbWeFJoeV9
 783vopRxsBCX1B703e8Q9HBnOcvFjWyKhr8ndZqysHc2y9cUn/C5uS17ZFPiuInvSBUX
 6ZcwmgWvV0BlcDbMxmpVZrupM2UAANQPgx4jT0HgvRzy0U4vjOqpywqp+F8YjqnhvepX
 yyYb5f+jwmU8IaoQBKpqaBvvfhdmbdc3YnoIkhRwfwYplw4l/qgEAq8vyB+aGSjyFcCc
 +bpfcFJzDCN+Udky+AG13Lly1caVIsf/+6dL9KhcB5Owvc8jWs9IDkIrVsZv3ukD/tIX
 sgvw==
X-Gm-Message-State: AOJu0YysKHfBIP5EYb9RU9izPwiqc7/vlThoh1PEEfAuYqQpRJH5/prI
 ggM0TLK+HpKgfSHQ1YJqm8fyFYLbj238e1bEHfy49xi4XNkg8ApSg9Or0hganvy2ZkxLYvqqIyf
 b
X-Google-Smtp-Source: AGHT+IHwcJqJ5SFW62w37TyPL/UHvQi9LPJAKHrx3io3CMfSvUeFz5TXNGSQOMOxZ3O1i4q9rYhczw==
X-Received: by 2002:a19:3849:0:b0:510:b6f:bec6 with SMTP id
 d9-20020a193849000000b005100b6fbec6mr56558lfj.39.1706200450062; 
 Thu, 25 Jan 2024 08:34:10 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a05600c358d00b0040ea875a527sm3122208wmq.26.2024.01.25.08.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 08:34:09 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Subject: [PATCH 01/10] scripts/clean-includes: Update exclude list
Date: Thu, 25 Jan 2024 16:33:59 +0000
Message-Id: <20240125163408.1595135-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125163408.1595135-1-peter.maydell@linaro.org>
References: <20240125163408.1595135-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Update the exclude list to exclude some more files which don't follow our
standard #include policy.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/clean-includes | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/clean-includes b/scripts/clean-includes
index 58e1607a82e..bdbf4040240 100755
--- a/scripts/clean-includes
+++ b/scripts/clean-includes
@@ -51,7 +51,7 @@ GIT=no
 DUPHEAD=no
 
 # Extended regular expression defining files to ignore when using --all
-XDIRREGEX='^(tests/tcg|tests/multiboot|pc-bios)'
+XDIRREGEX='^(tests/tcg|tests/multiboot|tests/fp|tests/plugin|tests/uefi-test-tools|pc-bios|subprojects|contrib/plugins|tools/ebpf|ebpf/rss.bpf.skeleton.h|linux-user/(mips64|x86_64)/(cpu_loop|signal).c)'
 
 while true
 do
-- 
2.34.1


