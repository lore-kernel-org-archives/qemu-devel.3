Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F600D25926
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 10:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl3G4-00024a-5j; Wed, 28 Jan 2026 05:58:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vl3G2-00023r-Rw
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 05:58:47 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vl3G1-00029W-82
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 05:58:46 -0500
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-47f5c2283b6so50444995e9.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 02:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769597922; x=1770202722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Xri5nPLjqq920DtmBVk36uGiYNB2CFzx+rtg1k5XJOE=;
 b=lv1PoG8iyo5wDbx1eZrK4PNeh15q6KaqASD7z8dPKxDkmqTsCKoJcFr2VOkBHO7yuf
 Bk/Q4EhISpLK56kFRlraoFw5zjg67dZ1iCHOuOzIxPEA+rqOj3wqKl6EMwBnF3TXETKA
 KR9glOoAegq8hV4jpSno0ac+R+P5+nsyz0bv3VIZV1YifARVvVWcGGhuzLDyBwkJeTQg
 nmrkfWwN6TdHQeOHWFkwm+9QDCjwDZ93FC+XkQfqlTYUjzwZ9vS8KS0VubMWiIzt4yIi
 EZqyCrfZtbv3lznQmbLGjiC54Wo6dK5LXfL7j5qII4cA1Gpb+7CMU8AS+8ytjbEVRfwY
 FjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769597922; x=1770202722;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xri5nPLjqq920DtmBVk36uGiYNB2CFzx+rtg1k5XJOE=;
 b=IFg+7BXLEk0Q+iy3igvjH/Yq3IAyPIoA/FsADghop/WqavuZrtVhc+ucthPcEglq1l
 caFfZzDnyrLx5mYc/cGVzRQfNVbxiyfSqinN2cFpRunnZ1OlfCOBNJ8S8R8md4aDaMlo
 ONLiOgarw9yiOxvn68gi1wU1qEI2OM4UIQeMcgtYdwdJ0rp4PFOj+8Ketgh034gKV9w1
 llIhvTNHAe3x7qZfrpVWqFMuY0GzF9cvM2SFpuXuwSm6B3qkVP53H+sLMhw0N7cRKc3U
 eC3Ggpq6+zOVrICy+TKOtAZHUS5x72hcxz/nb92glZjtu361//WhYuln+v1H7JZ4wRt+
 YDCQ==
X-Gm-Message-State: AOJu0Yz9bxVlDDFYE7UxO5k3jXA9aSI9Rfgn0Ae6VLvPvkOYbhk3mzb8
 nZ1QsxnUHLTcxRUuXmnr1ixrTIhW5ZeV06e3vRQmB8NC2Yv8BT8NhazrCadvA4j2I+4=
X-Gm-Gg: AZuq6aLEWawVU/Ef1M9yoxALMbHPHDCNdGhefGpTPTc/fW5n9WpMSGeq6l9YMmaYpnq
 twDA5uvIkdDabCPSLXTpVoOQ7YfBoRtt0tDW3MUQE6n61EYhlmjOfS4rdNYGhE9K6jGj1id1vIM
 WYqUswdqJavWvUM3gfQk6TZLlnokTjXbSmwz+MYRt+CbCFIYoc3VoLdM0DjbQ2iDtRDzVtdHk08
 d7UV5w7fKtTsgraXxRSl29estbGPR/Iw/auU9WGYLKpGdBkkKf5gW92NYSIE8s9sZ8GFO3b2t+1
 dZCR+gFniskEAvQANs8Z3mxJwwt4ac1wykN1rS10JwlHlX0jbw1TENpXB8KHYefS4AU5MLCihnW
 3WDac8xWZj1e1D8B96nrN1AdHBEUmPDvvSkl+ULNOtb7gEE5GRkUhgHbHp5LejQMNRQtYAEagBd
 NyZ5J6++iSAxA=
X-Received: by 2002:a05:600c:8117:b0:47f:b737:5ce0 with SMTP id
 5b1f17b1804b1-48069c5a468mr57125975e9.23.1769597921673; 
 Wed, 28 Jan 2026 02:58:41 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806d98c8desm44397835e9.3.2026.01.28.02.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 02:58:40 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7038F5F7F5;
 Wed, 28 Jan 2026 10:58:39 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>
Subject: [PATCH 0/2] testing/next: current patches (docker,
 test asset migration)
Date: Wed, 28 Jan 2026 10:58:37 +0000
Message-ID: <20260128105839.3487840-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
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

Nothing much in my queue at the moment except a minor fix for the
container builds and migrating the last of the assets from old linaro
servers.

Alex.

Alex Bennée (2):
  tests/docker: rename wasm cross container
  tests/functional: migrate sbsa_ref test images

 .gitlab-ci.d/container-cross.yml                 |  1 -
 .gitlab-ci.d/container-template.yml              |  4 +---
 ...sm-cross.docker => emsdk-wasm64-cross.docker} |  0
 tests/functional/aarch64/test_sbsaref.py         | 16 ++++++----------
 4 files changed, 7 insertions(+), 14 deletions(-)
 rename tests/docker/dockerfiles/{emsdk-wasm-cross.docker => emsdk-wasm64-cross.docker} (100%)

-- 
2.47.3


