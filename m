Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48B7E9A05F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 20:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtAk6-0004Pn-Bo; Thu, 19 Feb 2026 15:35:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtAk2-0004NU-CB
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 15:35:18 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtAjz-00058A-7F
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 15:35:17 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2a8a7269547so13166225ad.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 12:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771533313; x=1772138113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=97kyqO3kfQ/imXuTO9S5LMjAQyWRh+VXL02VgY/BK5E=;
 b=svJBAtkOUKcWye18jaCXyGgMBEXfh3hTnCZBsFvRCmQWMCNBzlqcSWUC7n9VSQ+Tii
 A37ArQfzTRtJMpXpUmAZlMaPxGPxeXFbANUNyYXjtK/OU3cGcsQgagKdfuMp+BO1sRiM
 wGNj42Xq4hPBhilqmuKcA1CXS/aNP7zoBrYRlQOWA4rJY624CP8qpV8y7fsjv9l8vcN1
 2Z86SNWaUD5b/nse8zFYqhrNqyT4/OLAIcst7tQnkGrWaULNSRd/8Wc/8tS6GYMHVdqX
 90PlI9NdQ66gO2ORUa1zxXPf2KhX0tjYCgWe9aSk5IzFsuHqHX8nN4clzgbP1pHbGmBE
 jU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771533313; x=1772138113;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=97kyqO3kfQ/imXuTO9S5LMjAQyWRh+VXL02VgY/BK5E=;
 b=ZwsUEGDYUppnXn1TaRPl4RgilymFzb3PALj1KBwx4tRIKgDkVKnNUcGuqP+gar6Dq+
 O9oF/I82juTVgOx/heXxBSfBxvzxQ4gxTTMNce8ob0N+CjgFHWO9V8zJxOljM9Nn6FVN
 o3ucWDWN5q4xJlstQpMtpEqs4cZ1w6XVT4Hr5Dp281m8f7Q7Y8k8NnGyWG3JS6h1CIYQ
 DyCKW23awNXeCIiuOeS5eZpMCQNcdx2xRG6Iqw6FOI1liqbGY/CL3wb5XIQkWj5HfF07
 cn8ZFV20FJj+vBxky4UX8cKUGx8umQHWtPtULSQB9qr0GA885z445bEmWbjysbjU5Zjd
 pRRQ==
X-Gm-Message-State: AOJu0YwIRMJfdT2/4Ypfe16SGNJCrcX4zHCkpLxUek564lk8q4209qI0
 sTgz8UfQh4CWKfAibEUPXKXZtWm78NroO/Q5KaM2ZffQZxKPy4SZJY7eaVijp8gWbPBTz3UzKnC
 HkSGz
X-Gm-Gg: AZuq6aK4JYYU457xiB76Jl5YcsvILvMNUn5rwrGTsHIV/FuTx8PVmHjlnbYvDPb1wAl
 Mi52mTdw8LupKjaG5/5s611QTPVIc057fsaPLnThAEvGBiE7tmRvD1QXDhLbpIdAS8r3hz9saml
 ohFMGb8XtojFPeMvp/rBLBHaXVT9fS6V6hY+RB/ZSw3fC+tcifwzbz2uvWGEdKxdaewhdK1g70l
 Zqy5oc4FvTilQYcgutU9mUDVrKhag6l9TJmMu/qfz8Hwqf3e23Y11KmlDH/2doEngnVwSIFX8xs
 1jNEXZW21UqA6o8KLp7XYFGdsUpksrnGQPX0daNrhJctiJ56G1PULrrJCaeszopWvYyNWxm9be/
 j5CUPCJG6ONyhiPCrlMTK0nbRI4lxe+d421S1xbcvQjtXWTJMWvBWMsS7uwa0+Vwukv94AHaJlm
 Kdv7gFgvQOUztNjrgD41ctAMkbKS0oFBlks1ukNPoll5I5lZOVJsY365krcRMLyZd5kLlZ9k6eK
 hG0
X-Received: by 2002:a17:903:124d:b0:2aa:d0ff:c3a3 with SMTP id
 d9443c01a7336-2ab4d06d4e7mr223858405ad.47.1771533312993; 
 Thu, 19 Feb 2026 12:35:12 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1aadc7f8sm169325795ad.66.2026.02.19.12.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 12:35:12 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 0/1] Plugins fix compilation for cpp plugin
Date: Thu, 19 Feb 2026 12:35:06 -0800
Message-ID: <20260219203507.3502009-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

The following changes since commit 07f97d5da04a9f97e273de85c76f5017d8135a6e:

  Merge tag 'pull-target-arm-20260219' of https://gitlab.com/pm215/qemu into staging (2026-02-19 10:36:06 +0000)

are available in the Git repository at:

  https://gitlab.com/pbo-linaro/qemu tags/pr-plugins-20260219

for you to fetch changes up to 396d005e4b83aa4a65d81778d180d545046ba0a8:

  contrib/plugins/cpp: use __has_include (2026-02-19 12:34:11 -0800)

----------------------------------------------------------------
Changes:
- [PATCH] contrib/plugins/cpp: use __has_include (Pierrick Bouvier <pierrick.bouvier@linaro.org>)
  Link: https://lore.kernel.org/qemu-devel/20260214061025.1239457-1-pierrick.bouvier@linaro.org

----------------------------------------------------------------
Pierrick Bouvier (1):
      contrib/plugins/cpp: use __has_include

 contrib/plugins/cpp.cpp | 261 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 259 insertions(+), 2 deletions(-)

