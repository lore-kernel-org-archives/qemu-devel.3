Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDEAC30658
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 08:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNTsy-0006y5-SF; Sat, 29 Jun 2024 04:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNTsw-0006xQ-3i
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 04:56:42 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNTsu-0008GC-KY
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 04:56:41 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-700d29bb4e2so740976a34.1
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2024 01:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719651399; x=1720256199;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Xhtl2nryjT/VmrtOBPaLo9RlgNr9OGF02gemGn9ndhY=;
 b=YAE4VfXEdhiXA/gSjifrpweChM9UNDDYoFRyGtu+MaisE5BWGAvKEDz9BIvBg0UTRs
 KDrIj423NSIgGoDT+01joUyu5bvOca21Tqgo9DmHqjDlD1lYmObumFB4OHkFkOP8cT8k
 HghVC+67w7Ivr4u1yHKi8z+5lnD42u6CYZ9+51OdgX2ZD8N8qUyJiQ78F3nStifyb/L8
 QhqjrAdGZdzKPhHM9Y7CPu4uEqzu/QFE0wVHu6CrWfXHS8lsH4nnCb8SPd/YexY0wvXQ
 yyalYZFt8ONUy8pkjVbVfr+k6aFxieJcK8V7NUtmELRMIUHk6KL0NbG/zYgqlVp6a95t
 NeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719651399; x=1720256199;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xhtl2nryjT/VmrtOBPaLo9RlgNr9OGF02gemGn9ndhY=;
 b=H3bRO9MiuZYgvi1+BQubMmPv0x+sfB/tXscCwNy5AddAp289MFxyHYyY6Ag4QLUYBs
 iyUlcwGINRwRNZGH9NlcG2hP8kCBjAoo5+4He34xvO5Gy9ofY+rVJxiJM0CZccVfxgY7
 Ivk9N9Vvyeb203BGZbWIHLPb/WwCKM67JN9Uk1PNUVP5fvgnao7PWV+oTKilC+Dh8TRr
 dWzx7t/zAxB5UBy9O6VEW7jbbWkgi3LzAABYXgTYSb11dRTY/LX9zrGa/ig1w3IzsjiZ
 Juah2MJRxm9I1LUy9TmmDujHFeYS5796nIddoxdbYcYod2OaOBHpbRq1CL15C6XK7Zz7
 PNTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMzsTj7QM9QRKvxzBo6CUxo9DUgngIH8ZXyKgVEauyLvPlk1RwSL9SlnGnqy7aYf9lFiiI+UJdI0rjVy/pWbM/qDSPsrw=
X-Gm-Message-State: AOJu0YyVmyWFLcMly9FXeUYVrMePir2akWuktAClvLJD+qgqR/O0+vzZ
 pG6uqePeb7XYwRAeFYLUMNN1pj4OH6EaIzKiXEs2yhP6+zW95lOLGXqooDFZ5UToHijfUxHb/Sx
 rYnI=
X-Google-Smtp-Source: AGHT+IHAFkrXQ9ub+a/QkEklFBVX8IhRBK3TFyzQ6+ssk2A2dADGhezaTmscRR67+8Sbwz3LnRex0Q==
X-Received: by 2002:a05:6808:13d5:b0:3d5:296c:5a4f with SMTP id
 5614622812f47-3d6b2b23c81mr503824b6e.3.1719651399290; 
 Sat, 29 Jun 2024 01:56:39 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-70801e53b21sm2961307b3a.19.2024.06.29.01.56.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Jun 2024 01:56:38 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 29 Jun 2024 17:56:28 +0900
Subject: [PATCH v3 2/7] tests/tcg/aarch64: Specify -Wa,-march=armv9-a+sme
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240629-tcg-v3-2-fa57918bdf09@daynix.com>
References: <20240629-tcg-v3-0-fa57918bdf09@daynix.com>
In-Reply-To: <20240629-tcg-v3-0-fa57918bdf09@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::336;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x336.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The availability of -Wa,-march=armv9-a+sme was checked but it was never
used. Use it for SME tests.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tests/tcg/aarch64/Makefile.target | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 05f98c80c88d..d3e739b566d9 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -72,6 +72,7 @@ endif
 # SME Tests
 ifneq ($(CROSS_AS_HAS_ARMV9_SME),)
 AARCH64_TESTS += sme-outprod1 sme-smopa-1 sme-smopa-2
+sme-%: CFLAGS += -Wa,-march=armv9-a+sme
 ifneq ($(CROSS_CC_HAS_FNO_INTEGRATED_AS),)
 sme-%: CFLAGS += -fno-integrated-as
 endif

-- 
2.45.2


