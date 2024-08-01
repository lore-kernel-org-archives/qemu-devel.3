Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA5DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 17:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZZWh-00063V-33; Thu, 01 Aug 2024 13:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZZWe-000631-Pr
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:23:40 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZZWd-0003Hi-4d
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:23:40 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a7b2dbd81e3so942074466b.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 10:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722533017; x=1723137817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2m/9Wkb+aruwgsoyJbKrntqaNAKPY2tLgX7GjjE/K7Y=;
 b=Dnp1g11n6ANhY/F+KUGp4tCv3xUCGbJcEEVfwgeo0HdXnTr4x/Io7po0HXc4r6QyXv
 T4tAgno6BA9rRoBpfJwWTWIYMTH7mWv7hH4KpayPb3Fy1m1a3bgRuyHfICQRcjnXWkJ/
 0OjwG1VDjrpOQOyQMDUB6de6sCiSYKPBtIk2lySZCUQTVM27TIaF7gLWsbCGflbQsYPY
 O8foVxjPZbNJERxMkdC1/H5ZqVBM1v1mHVcB2gs6zX/DYuxB7g/hop5yZs2HEnrEQml4
 dVhbf9C+nDUO486ix743nmRXS0DEi72ivHtlnQ3qLbIDVNwJed7OacYhNIRHYFbAOn5s
 rLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722533017; x=1723137817;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2m/9Wkb+aruwgsoyJbKrntqaNAKPY2tLgX7GjjE/K7Y=;
 b=JXUdQdkpMuCDFf1V9sG3sO9qDEXRRGaYImU2iOsPYfEthHPPYlzJKfQG4jHnuq6CM3
 PrHcdL3Ip2Lvz7Wx2BpHOnontuHI2ukXSPBUCdGS/mqxZc2NEI0bGRdXmxOWhJ4xkQI6
 MSSHl/x0+hh0ad+lSVPP4bE4S0Xjn3S68uIlQo5echNGB4zi/R74Hh84YmjELc/5jtJ9
 Uh8MZrULN8CTYMmXcpSIVrlNzHVu0il3YQ8JL3MxY4A2E/9oeFBbhqeW9DTHUB+mv/AH
 H2wZZxItpRTwTnsgLQzsVVjlJU0i5YNzZAHdcA+JXzx1ssvfZnTVujcvuQwYrnxMDdNa
 JkpQ==
X-Gm-Message-State: AOJu0YwmMLFNXa+AqlnYhpOi6VkD0u83SES92GH2NA4l0FQLLaJ+VzZj
 rqyYV0C3GUEjCaCOLuVpfa87BfzN3w6h0FOrVbBqlRWSn3p3dW09AhnqbVzXU+MHAY8vQ9/jf25
 HXpQ=
X-Google-Smtp-Source: AGHT+IENQdfCIL6MTw0hs0F5nKio7S3Yr4Qb9ysJPTSt/yeAQ2la6i2iIKGDRwkDBVrLHk8Hf2L1uA==
X-Received: by 2002:a17:906:bc0f:b0:a7a:c812:36c5 with SMTP id
 a640c23a62f3a-a7dc509f924mr79221866b.46.1722533016689; 
 Thu, 01 Aug 2024 10:23:36 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.211.94])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d426e6sm3422866b.122.2024.08.01.10.23.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 Aug 2024 10:23:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH] tests/avocado: Re-enable gdbsim-r5f562n8 testing U-Boot
Date: Thu,  1 Aug 2024 19:23:32 +0200
Message-ID: <20240801172332.65701-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

We disabled all RX tests on commit 9b45cc9931 ("docs/devel:
rationalise unstable gitlab tests under FLAKY_TESTS") for
being flaky. However I don't recall the U-Boot test to fail
(the problematic line checking the 'version' string is already
commented out), and I'm running this test reliably, so re-enable
it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/avocado/machine_rx_gdbsim.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tests/avocado/machine_rx_gdbsim.py b/tests/avocado/machine_rx_gdbsim.py
index 412a7a5089..a83873b738 100644
--- a/tests/avocado/machine_rx_gdbsim.py
+++ b/tests/avocado/machine_rx_gdbsim.py
@@ -22,8 +22,6 @@ class RxGdbSimMachine(QemuSystemTest):
     timeout = 30
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
 
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-
     def test_uboot(self):
         """
         U-Boot and checks that the console is operational.
-- 
2.45.2


