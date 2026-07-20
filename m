Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D75C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 16:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlqRH-0003SP-KA; Mon, 20 Jul 2026 12:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wlqQz-0003Ks-6E
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 12:01:39 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wlqQw-0005cJ-78
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 12:01:36 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4799b3f7c83so7493227f8f.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 09:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784563292; x=1785168092; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0cW+DBXjbHlNYx8uEGxuJmMe8O8nUV9WEM9IPMn00Cw=;
 b=rgJCv2Shd2/m0yHDyW7WHYmuOcxJOG08LJG9C3b6TUrQ1HTzV/uNHw7lNSdo6mIV2X
 wcQRToe+OXurOcH1YXArlBNNyEXwAi9K4zCkpVIQogDqOfFhoT9MrqdKwKjcQZE1NXuh
 sALkfcSwkK9h1UdlpcUTrF0K60UehZC5lMtORnTNrlNYQzVNjlt4GRkC1OnSnDpDIq4g
 VklxUhcBQIPGqUz7xJmkfmMpP+aE3JqbSR5n/f15V1YYJvjVbloT8+bXjF8AOEBkULNt
 o9JD6GtbSPNEgv380TZjr7fcokALMcw3SIaZ0om3t1IzgkmgoDQFqiE6Uf/OHdnjR0dg
 vj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784563292; x=1785168092;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0cW+DBXjbHlNYx8uEGxuJmMe8O8nUV9WEM9IPMn00Cw=;
 b=JgQ2yd0LAxejq2cDzcU2auk3BCpOX4n0vfniEKl+2KthXzy0YZVJCSf6osWyZMvJDp
 AycZPwdA8DB7DBh+SZsTAUr3goqgmnLXqd/h0k3sbm2Ahc059BhiuwV/X+m7IQ1yxfHu
 0vn+HpVo/bpPHwtkmXetE2hT/MfLrJqbKM0RbM47SjoDjWmf6JVuMqC8CT5/ZUyQC2yW
 GP5SB3C6VPEyNpEv5KixrG+4FWGvv+SINAWvEzw7ETZGOS2FrnSMGc7nOmcQ0O7EOhvJ
 PiMYShe2EmqEWxi9ocYQ4ltdrLPKFfi9a3/PpHPdXKsfMQjyvtLEdvNXBTwjfpwKRqIm
 VLWA==
X-Gm-Message-State: AOJu0YxbtYwW/U0ygjHipsRdctz8T+hNRYifBX1QoU6yZLgwylP0VrTe
 R6HrWS2TnK7MGxY6zJgA6oghP7OwMLvILG5+pP/WoILfAApabLlE1V0zgC5Ur/OueKA=
X-Gm-Gg: AR+sD13MGgyQkZd7WtxDnWkf44tV+voV2tVDMU6yDWpT2g29PE0Z28KfnwzeSYkX1oR
 1Q6pidCIBGDAy9392lDBeLVbFJfxxE3ohVRQKGHx+dmTSGL4kFypwsD77E8wi+85WGrORJWzAE5
 kyOrURw4d+uy1q6uxLz4PYSHdYzlPjQdwY0qGuOkhm8KHH3lKrXIoD8GcGEwxexK8i4xYVHy58p
 oju0+1e5cpICPXJdIQKbQMOfcv++YoY9nhe6DMHlQ08bUUQV5RjSLsZni1s31RJuP9B2yEUGxIo
 Qs1bdSYzJkzyK+bx4l0M8Gbx+K1Y6G1HyMxYrGdN577bvFJadmjAuAqEtXbbsH5PupzdcC0pRJF
 jtBBAQ1bh5wrQ5z5f7WBlWBbOXIgaHE+cPJBDBDp6WMgMAB2DBotvOpAfMhSoCQdzCXbnk3pe9G
 iSLVR+76kuMDXHCJnUR8Ans0A=
X-Received: by 2002:adf:e00f:0:20b0:47f:77ae:d8f9 with SMTP id
 ffacd0b85a97d-47f77aeda2emr4353922f8f.59.1784563291417; 
 Mon, 20 Jul 2026 09:01:31 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e49500sm32901681f8f.2.2026.07.20.09.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 09:01:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BBF895F911;
 Mon, 20 Jul 2026 17:01:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [RFC PATCH] gitlab: remove gdb from MacOS jobs
Date: Mon, 20 Jul 2026 17:01:26 +0100
Message-ID: <20260720160126.2503610-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

This seems to be hanging in the CI.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/macos.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/macos.yml b/.gitlab-ci.d/macos.yml
index 53b6e6c4d8f..641a48b3832 100644
--- a/.gitlab-ci.d/macos.yml
+++ b/.gitlab-ci.d/macos.yml
@@ -22,7 +22,7 @@
     - export PKG_CONFIG_PATH="$PKG_CONFIG_PATH"
     - brew update
     - brew install $PKGS
-    - brew install gdb aarch64-elf-gcc i686-elf-gcc x86_64-elf-gcc
+    - brew install aarch64-elf-gcc i686-elf-gcc x86_64-elf-gcc
     - if test -n "$PYPI_PKGS" ; then PYLIB=$($PYTHON -c 'import sysconfig; print(sysconfig.get_path("stdlib"))'); rm -f $PYLIB/EXTERNALLY-MANAGED; $PIP3 install --break-system-packages $PYPI_PKGS ; fi
   script:
     - mkdir build
-- 
2.47.3


