Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C64606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 18:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CQbbhQqW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKJeG-0006as-QZ; Fri, 23 Oct 2026 14:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xKJeE-0006Zp-Ji
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 14:05:46 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xKJeC-0004WQ-8u
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 14:05:46 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a1dede3c2cso13453535e9.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 11:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792778742; x=1793383542; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XeIAYcaI+vZjSoFwq5jZxMU2KYhs7cAs5vvdrEQlLFI=;
 b=CQbbhQqWLAEOgRMoPy6gNp3WxPnd3f8Y7jw+2RB+B8ELmXPwL8o5fpdrkVJKXoOn3Z
 mF+OJrAC/PiHn9f7GgZq6S5xEy9hYN78Melx/eoTkgRbcQf4t6/f6pBeZgewm3USCqAy
 3xPAG8UmYWS0E/Z+lavK9ljg1RYkFC734XU3MPkK3k+X3/lks7nsMCv3KKatOcF+CcnP
 Qm33krNpMOwNWFg8v3fjuX9C143TEOTlLKh+WherHHLoyP51dHjAKqZ/uy8CphYGAYKX
 V9xsNdaqUJQOK1gQRPOn4u+z/0jKxRdy/ikST7edeH+yAqjdPbyTjoMPIH8yXzNDPko8
 gucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792778742; x=1793383542;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XeIAYcaI+vZjSoFwq5jZxMU2KYhs7cAs5vvdrEQlLFI=;
 b=wVzcMf7AbupLe5B2WAkC6rlQkgd2p2C3C3bYeql3sOwDcjSX1Xando8AU1xK8PFz1E
 rh8D5oFkx+8B4htZAsGzY8wIpn87NIEVZcyWlGGGzOJXez86jYr2PtpxHgg5UfWTZEL3
 h1+k/DAkS4U1reCZM53jkxMt2zI+pGSq+xSWdUSJTi51gCna4fsjaDdWGw1jrn3Y52Ug
 RVfNqZk+iRo1cWFGJt3174l2Irv02IiE+aI0looF4LZD+6hzuI1ou04svCvFTFV4XK+p
 CvnKlVir+0GIpBErU/n4JMr9/0yiUloppnu80tXF01flXyYaZ21CtzibI9FJ26FyFs72
 pQGQ==
X-Gm-Message-State: AFq9FYKaJ030mYpPGX286b6wicn0dituCErRw48WLljhgDHj4NACEtTr
 l6x8ErdL+I9R9c4kk1GlacJL5W4wI8k+chZ27J0hVPCCYMKdnPQ0J0aDDhVPO32VcEE8QcvGAlw
 oRIB4IC8=
X-Gm-Gg: AYBFou1+vxAD8MATUG84zvDMF+FvVqd0XHoGDyKZv4fryAbbGrA6xlr470ly7BD8cOO
 Jhq5oUiKigp6bKgtWnaWXAJ2yd1XTj1W58Cxb/3NR4SwVAEmC/wsvnd706R8BwW4y+CSmyQ7DXh
 wZkzE6/5A5EOBxssLI2sfrySFZP33hcdwxEZ/iazsyzucN38OjG8WkJy1MUaF96M1PtkDnSfq3s
 ThQfuP0eAAGdn5LgGGLzNaQcZLO5b8LnUJrl4r+EaZJAnGT8OMsVsuYd55fcBlGIE8BeUBpuHnf
 MrhFGGOlHZN+SDRqshjfWmoFWzSPOWZbMxi/dZhjvmRNCdyKRPWcI60IQOi+vqezkXZa0ttOMoH
 iT1MFJDQQ2kG7RLei/+vc3rBpMrrVNaSbyq1M5QNtAAuQP6oS7f7dCQyu3lGVxroTcdCTrdaaM0
 d1yw4PmugAJ1WocE5o/fOf2yIwoOYisBbYpAqPo4duouRa4Xt/R0MdJR497aL/WZ/9lWvLuL8vy
 abqBFMAEGPMl/88dfKuQQYXKyFPpVx3V2i44qsTGMj8U+8TbOyrbAw=
X-Received: by 2002:a05:600c:3b25:b0:4a2:994:5750 with SMTP id
 5b1f17b1804b1-4a211f0a70amr53864155e9.32.1792778742543; 
 Fri, 23 Oct 2026 11:05:42 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2b061ceb7sm19731305e9.6.2026.10.23.11.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 11:05:41 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A4FA26007A;
 Fri, 23 Oct 2026 19:05:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 03/19] .dir-locals: include QEMU code in PYTHONPATH
Date: Fri, 23 Oct 2026 19:05:21 +0100
Message-ID: <20261023180539.1574134-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023180539.1574134-1-alex.bennee@linaro.org>
References: <20261023180539.1574134-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When editing python code the linters tools have a hard time with our
imports as they can't be found. To ease this we can expand a
PYTHONPATH in .dir-locals so at least Emacs users can have less
warnings in their editor.

I still get complaints from python-mypy about missing library stubs
that mean it can't do proper type analysis though.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20261019192704.3220373-4-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.dir-locals.el b/.dir-locals.el
index 3ac0cfc6f0d..51871619422 100644
--- a/.dir-locals.el
+++ b/.dir-locals.el
@@ -1,2 +1,8 @@
 ((c-mode . ((c-file-style . "stroustrup")
-	    (indent-tabs-mode . nil))))
+	    (indent-tabs-mode . nil)))
+ (python-mode .
+              ((eval . (when-let* ((root (locate-dominating-file default-directory ".dir-locals.el")))
+                         (setq-local process-environment (copy-sequence process-environment))
+                         (setenv "PYTHONPATH"
+                                 (concat (expand-file-name "python" root) ":"
+                                         (expand-file-name "tests/functional" root))))))))
-- 
2.47.3


