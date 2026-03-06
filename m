Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CAFF0182B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 12:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyTwj-000130-6d; Fri, 06 Mar 2026 07:06:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyTwX-00011Z-NA
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 07:06:11 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyTwS-0005NY-94
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 07:06:06 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4852a8482fcso500725e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 04:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772798762; x=1773403562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rmVL/oP8ev2RCLRHzaRTkgTZx8lvORGMiCeZEC6hwwo=;
 b=apj6Av5Hud17DjXD2nxc1B1PHffOE84V9Yb4s0s6Aq1qrZpFyeN543QYUBv74PgbqF
 1wmVX6JJPdps8fFbcb5Sfayhf4sknnUOC+FwE3STwPnoFTQbZRfRB+rUtgNlC/MRhwLT
 bd7YXKfJyt0coGOlBtsHIDUYqoU8MuWNAqCKcqn8FQgYX76BwFyY9Bjv5vpLNeKo//7M
 HXV19/RMJ0ScJiYqn0fhRjg5LqbPPZhbNFNx/p1ceTXSAy/MZFpOkZfao+5F97PYhWCE
 i4zi/lSpsNwlAI8m9mqDCVxNDpYSSkOeYznsV/vWcya9pWVbs5d9VPRGBH4zpXlfFX56
 1IgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772798762; x=1773403562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rmVL/oP8ev2RCLRHzaRTkgTZx8lvORGMiCeZEC6hwwo=;
 b=rX6vkDpvB614EJyANSGg0p0MO1WM8OIDp5GnBTnfUfNK0kJi0sLrfxf3pUCq+muoSF
 8JbhaVAIK2pq63Du9isZlWtYmWB2kXj+ddgoI7xIrQx9u4AUzASvNosiU2Yom9aO5dQK
 ZY5pR5UVZLY6F831HKfqjsVlSYs5xkUgkpeI3q1q0TLJagljBpDSJPs/GMIdpFaiQLnu
 8+ZNGDfkKqclO6Akvtzx6ohjEF1ZnoK/Y4AfzCZrBI2+Z+gSfjdk/Rs9LnaI1EIM3jQN
 RIGKef707VWPnwRHIqu1RrErIlPaycQnXf9S3/+szDAIECqIiwveaSPAVAEfwJPIO9KP
 REUA==
X-Gm-Message-State: AOJu0Yy9lo0kVdvyLXQudhVBEHo8ihnuoDm2W/DI3NMlhD/6YTbTeE9b
 Qi4gBLCkwuIWr3IOX/Yye4GCvEEHLXr7qnx1xLpz2mrAv8JxW+69Di1m7aXincQGfTLcw7I8Hxl
 lYmta
X-Gm-Gg: ATEYQzy1oSy/2Pz2ciXAVZY+ZBHx4JYB3f/IsfBMyNDWZES4V76et+1c6URWryepiPC
 srkM0ssHNvb8sS2I5qIp0Xg4ViO+8WSPhrptyomkE+SRpp9DGNBbNy5AoxX9OG3U18M7sag3Nlt
 eSLE0A56OW78C+pxaVtI87R+bb+QN9HwU/QdPmHkqeOqeRo9mQkQRnK4BvZU3AeNlOHrC9r+6a8
 8ohNfdM1pnBUpEM3buPvJGLChIp53EN4Q3Xyw/IxK8MqYJMDWxQHog6VWPHvEhWCmbrzQzxGHpB
 lBazxQtb+wm3nBq4ttEBALdICu13YMyEoz7wq8cWAPcE18cj+pWJEXHJrG42hd9hQwafh5iuWqP
 Y2yXihaenWJrBHxQ+QygGSRO2zRRw6nauGeMrP5h1G60g1cbBt+b2AuWgiwuJkUU1UcX/hvebee
 SpF04a9SSuoHNHuw5HZAcbdXTCqtzBdEe9jiXZz1EuF4UPvecbnwraNCUYKRESP93c4LFSlKiMK
 ZWvupKU2WtLU5yl5P7q5YgbhpSa0l0=
X-Received: by 2002:a05:600c:4e03:b0:483:702f:4641 with SMTP id
 5b1f17b1804b1-48526918685mr29881135e9.3.1772798762379; 
 Fri, 06 Mar 2026 04:06:02 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48527681e2bsm32841945e9.5.2026.03.06.04.06.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 04:06:01 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/6] MAINTAINERS: Remove Chris Browy
Date: Fri,  6 Mar 2026 12:05:55 +0000
Message-ID: <20260306120555.2035421-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306120555.2035421-1-peter.maydell@linaro.org>
References: <20260306120555.2035421-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Chris Browy's listed email address is undeliverable:

The recipient server did not accept our requests to connect; it
times out on attempts to connect by my sending mail server (gmail):
  [avery-design.com 99.83.249.127: timed out]
  [avery-design.com 75.2.78.167: timed out]

Remove his name from the file.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 37c93f0611..dc4b837821 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2169,7 +2169,6 @@ F: docs/system/sriov.rst
 
 PCIE DOE
 M: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
-M: Chris Browy <cbrowy@avery-design.com>
 S: Supported
 F: include/hw/pci/pcie_doe.h
 F: hw/pci/pcie_doe.c
-- 
2.43.0


