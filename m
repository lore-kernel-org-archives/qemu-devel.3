Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4256FD88CD
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 23:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w06PB-0003EU-AQ; Tue, 10 Mar 2026 19:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w06P9-0002yK-6y
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:22:23 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w06P7-0000GO-6N
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:22:22 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4852e09e23dso32852775e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 16:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773184939; x=1773789739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yPwiAl82h64TYXltTtK6EZLk0biBATN1v9vVR0rYD/w=;
 b=jAzu5tClLQmf5Up+HnQM+2QULoTzEhZTuHsjaP7RRYB2iJm+gUvRvUfqOZM+hMX6cF
 bFv1pU60Y/FXiP9qXM+OwYhtnnky+Mlpqt4F+M4NjEGrTYHWnV4jglaHD0banz9vuZrf
 L6TC+JpGLo1t+mKUnhtIRjpQkF2vhXXQjTc7llYNxvFqJdO2paJCLfofAkxZxNpBYwPw
 rVclHsGlPMrLu7M51Z+4LB5cSKCmK18qSqkXkdtVoffgV7cw3mVE17ExZVMkIt5uTAsp
 mkad1KdJTXLhDeuCMzrlraTzd1y71nGd8eEqGhIcmzFDjeOql0STS25aSsEbhiAjx9Q7
 5c0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773184939; x=1773789739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yPwiAl82h64TYXltTtK6EZLk0biBATN1v9vVR0rYD/w=;
 b=oxe/LdENrkvmZ68NqpnVRq+yrJxdWR+TMGALHDeh/VOrM6Lvqm0TC4SwYlUJCpio3N
 7fIrKdxF2Pwq2eL1lYP0N66AVOJtxNgSMXC5KnYBzfOWKDoW9xpP2f/bSdeLmkYmQQgJ
 f8lhgXZgOeq6Y23N1vVZl5c1oXFO3Gig7+fCTTrW4J3aht0t1RBDTa2BNtSw4kWoS3XW
 EY2+jEeei5M43VvVeVNyQ2Z5pNVt+ehPiPwwvxc/4qiC/rLyoV+S0p47aB449A0dyCcI
 HDXXN6xiQjnT5f8wKiTExJLWvkc/DdpqEVMRZnQ9480UwWLdveLspQxwMYmU392nf5E0
 3sSA==
X-Gm-Message-State: AOJu0YzUp0U4l8W0npHXYpiJqjCzAgh6KYBhid2j37lmdF3m3iYWmOnZ
 fthFrPI32ZPEXFPiIkm2FkCoKsNxu3IRLYAsyzLlONwkivwVz1KTTZu4vWa63AdnF3Cd5pByUCf
 Dn0IBytc=
X-Gm-Gg: ATEYQzzOTKS9mqAvtsdvdQJpYlAYOeu2opDFzTuxhdIuPU3XPNKxIi/BPIjidWhaQd8
 AjOljTmjWFMwvjYYd5302q8E/I+GJTqtaY5+6pB4oxqx5N0RfHgHiVr32b0NLhVicuXP6D5zA8n
 QH40lvMACPtoEC30Umq/072Etxc61+ms2v5QnsQTMZ6rrgSpofdkPesSSwAMkRxnXgzwimoDrPe
 Lu3Cv5ED9Awiyre8TPQU/WeBmzKu9G6qnk7ofu9l/R6J8B8OeZ8FWX8uY0icdUG+fTZbR7oIvz9
 HaHbdhVYtRsWMctYFjRck8J2S4hV98sqgThCiDEDuHWKKlXgosIbJAmQzDI/ZNdYA5b95WZ1RcI
 CKbPfFxXfv7EEYpW4ZH0NmpJU20MOezWybhQ39YYqUJh0yF/s/n6RkpcFEBv4ZvcdjNYfX11p03
 urc6XslEOrx8OtAHPoTdYiZrUyl1+J+X09rbLZu5Hso5kyfyJzyCl4v9hzN1i9+Nmql99HmULzR
 g8xEczHs1I=
X-Received: by 2002:a05:600c:a46:b0:485:3026:2b8b with SMTP id
 5b1f17b1804b1-4854b12bfd2mr8329275e9.29.1773184939018; 
 Tue, 10 Mar 2026 16:22:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541aba60esm111657085e9.5.2026.03.10.16.22.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 16:22:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v4 13/16] tests/tcg: Re-enable disabled multiarch tests for
 PPC targets
Date: Wed, 11 Mar 2026 00:20:41 +0100
Message-ID: <20260310232045.58440-14-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310232045.58440-1-philmd@linaro.org>
References: <20260310232045.58440-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Previous patch fixed gdbstub / PPC, we can run the tests again.

This reverts commit 9e5e2a0e8726d041fe0328dddd4263683e354935.

Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/tcg/multiarch/Makefile.target | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 70e2ac38f5a..23377f7a4e3 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -161,16 +161,12 @@ else
 run-gdbstub-%:
 	$(call skip-test, "gdbstub test $*", "need working gdb with $(patsubst -%,,$(TARGET_NAME)) support")
 endif
-# gdbstub currently broken on ppc, see:
-# https://lore.kernel.org/qemu-devel/e44df309-d40d-46f0-88a8-7ac55f9a3634@fhofhammer.de/
-ifneq ($(TARGET_NAME), ppc)
 EXTRA_RUNS += run-gdbstub-sha1 run-gdbstub-qxfer-auxv-read \
 	      run-gdbstub-proc-mappings run-gdbstub-thread-breakpoint \
 	      run-gdbstub-registers run-gdbstub-prot-none \
 	      run-gdbstub-catch-syscalls run-gdbstub-follow-fork-mode-child \
 	      run-gdbstub-follow-fork-mode-parent \
 	      run-gdbstub-qxfer-siginfo-read run-gdbstub-late-attach
-endif
 
 # ARM Compatible Semi Hosting Tests
 #
-- 
2.53.0


