Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC39C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwWd-0002Ii-CF; Thu, 25 Apr 2024 06:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWZ-00024m-Hv
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:19 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWX-0007F3-S0
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:19 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-34be34b3296so784418f8f.1
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041616; x=1714646416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ujr72QtXXZPe8hmblwWvpr0weZcNa/JXY/niqd+OE9Q=;
 b=fbA/x4RI0/dBbTL2sBbMfybrwOiQUUEoZOSFe7yaqtap2Q75lktQN0bErkt6PFDjP7
 aE2ymiJmciCGW9jDIWlR/VDkJSNBT0wcYSdCF9MjpIdVof0zEjSz7xuB0GhUEF8pmX3K
 V21Vrnll2SzzHJ6XNVZqeZ8OKIMg/4V+kLQEHtwrL4V2zQ5d6xTmVzjFnDfKXcKiW8q2
 /KY3XEIU7UeT1CVqeAWaT/w3bbTVRqUNsCZTvqx9Z22X8ziHrG3w88SRKlyU9JjBAHr+
 y/W++X0jxtnFgwC/5giBzeYeix+1YvOPvZBPg04prQWIvh566LjZTTZz3Dc2P1/nuJc9
 Xr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041616; x=1714646416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ujr72QtXXZPe8hmblwWvpr0weZcNa/JXY/niqd+OE9Q=;
 b=c35FvpCPUf1shbX0SUt2HMGtgW2EeqMMGyq5pO8qr2NZ9O01ji5WaDMFDPxr2EPLlc
 OzqCILJdcdHG78xbkyDN6n9CRzLKn9eNW1Sjo1DCAnTJr5ZrPkvIsHMLDrjfdTQAHgjy
 ONphRQRF9oIAkaEGlT4lxex6z7FTJjh6iLFre47sfR+/taiv7kbOhFoSO819sEOkFdb2
 qoYldVeg5FGc9ROjjb4HC/gD4ilHw1KywNCgkkUZ5oPURyAaCjX79d5OzqbtGAhlnrQn
 LIj/eugaPcA6WnP1S506NbZzlA5N2eaRwaYgtt32ynx+zZ2AP7GKagvL68yypDw2cH8N
 yfDg==
X-Gm-Message-State: AOJu0Yyu5+c2vHk981X8SQYuPT9o5RAn6SRg1h2XEXPsAKMEeJ1HrJIB
 Y2vdRBRbOski8y7S678Lx/DxxFtV3gcDJjrA9cL0Nw7sxnY7MF/59VGM3RPrCcXbCPWUFZ1aXRJ
 9
X-Google-Smtp-Source: AGHT+IFfmxajtciwOQoHhDbbckfH1YrlnaHmsj6OvnSk776hVbKEePDMQhqnqzUJkLSRO5dQwQ2s3A==
X-Received: by 2002:adf:f508:0:b0:345:be70:191c with SMTP id
 q8-20020adff508000000b00345be70191cmr4582958wro.37.1714041616582; 
 Thu, 25 Apr 2024 03:40:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm19485768wrx.107.2024.04.25.03.40.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:40:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/37] docs/devel/reset: Update to new API for hold and exit
 phase methods
Date: Thu, 25 Apr 2024 11:39:52 +0100
Message-Id: <20240425103958.3237225-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425103958.3237225-1-peter.maydell@linaro.org>
References: <20240425103958.3237225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

Update the reset documentation's example code to match the new API
for the hold and exit phase method APIs where they take a ResetType
argument.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Luc Michel <luc.michel@amd.com>
Message-id: 20240412160809.1260625-6-peter.maydell@linaro.org
---
 docs/devel/reset.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/devel/reset.rst b/docs/devel/reset.rst
index 2ea85e7779b..49baa1ea271 100644
--- a/docs/devel/reset.rst
+++ b/docs/devel/reset.rst
@@ -150,25 +150,25 @@ in reset.
         mydev->var = 0;
     }
 
-    static void mydev_reset_hold(Object *obj)
+    static void mydev_reset_hold(Object *obj, ResetType type)
     {
         MyDevClass *myclass = MYDEV_GET_CLASS(obj);
         MyDevState *mydev = MYDEV(obj);
         /* call parent class hold phase */
         if (myclass->parent_phases.hold) {
-            myclass->parent_phases.hold(obj);
+            myclass->parent_phases.hold(obj, type);
         }
         /* set an IO */
         qemu_set_irq(mydev->irq, 1);
     }
 
-    static void mydev_reset_exit(Object *obj)
+    static void mydev_reset_exit(Object *obj, ResetType type)
     {
         MyDevClass *myclass = MYDEV_GET_CLASS(obj);
         MyDevState *mydev = MYDEV(obj);
         /* call parent class exit phase */
         if (myclass->parent_phases.exit) {
-            myclass->parent_phases.exit(obj);
+            myclass->parent_phases.exit(obj, type);
         }
         /* clear an IO */
         qemu_set_irq(mydev->irq, 0);
-- 
2.34.1


