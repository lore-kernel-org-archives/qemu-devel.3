Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2C9EA853C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 18:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzJGm-0006Cu-RA; Sun, 08 Mar 2026 14:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzJGk-0006Cd-SV
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 14:54:27 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzJGj-0007Wc-AA
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 14:54:26 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-439c5b40f60so3999232f8f.0
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 11:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772996063; x=1773600863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vYpLSymU1Mur/fLUfLPxJBc477mDHAJYRAzi7O//2Yg=;
 b=D9RFYjSWfnWcqxSDKrc7g0Tf523JukcWUYxiX0a4ySWwf3jgdJ4dkPdayc2fR12PFk
 WsKlTcHw3zqT8A8FHk5f/wru24c7QQ2UMcvO2zpms+KkCBeY7XSsgsPVwy3uafb2HLAI
 izryMbWsJxrn7G/RrwfUgGLuC4xNsGXb3R3Q7GENhhjpsaRWCjXT14GtVO6deOxhl2gS
 CceC/I/sSyi2q4X3sxE0EmouVXYFDeaH1Ak+LgktXFI4NZRbTg3r89ZBgdfQ7egfgk5y
 BirFXgSTq9qOgiRiisb2na9jMFsU7C5+5+mDIC80pJT+azles7+9jMmrz5JTEBXeNj42
 m5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772996063; x=1773600863;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vYpLSymU1Mur/fLUfLPxJBc477mDHAJYRAzi7O//2Yg=;
 b=CjxOLobtK43eQ7DPNaNVjk8oTjych9p+AlBvCGSCwdVsYis0xe4XuJ5FRBm+wv7EfP
 SFp3YhP08+yBQoR3Fdtzl3txuSkqBqIK8cWOzP9Fy3Z6/Z+o4gJWnr6vcdoLfTql35e7
 eI6TEuJMcNYs8j08nAekaziHqiyPgMWprfb12RBYON7VpC97+itn8FRKt29FNgG51VyG
 XitDR71h7kEyZ7auh2bMQNGt4mfCnhLHbawhZv8SNRzeNDNYC7dIYwRcSX6wMfHgDcCU
 HPoaeYq9mRmc3QpU5JkEIyLMUcPWBXGhE/0zuDLa6TG2ky96Va9OlbuFpeG+uo7FSiD4
 V+oQ==
X-Gm-Message-State: AOJu0YyHQvEp4r1ZT29pXWM3YXD6OFmpFx/j/OsYYx4aJUJYStgMueKc
 Mve6wvuB7rdN/vqt/tfon1/z3sw/Q6CjuNXezwAuhN/AgioW8tXsV+YLxCyZ7ANmqGNbRsNVN3Z
 lzc4W
X-Gm-Gg: ATEYQzz3St9Wi5mLpae0BeYzX3LiYaPo3JJl6yBbYPscako0015euK2iCtRV4rUjUAK
 GeKMV0bKypVW+xTYrqQ0jRn7uLnvuGo+yGN+2Bz70t3bZGh1oaI+ZTjcrIyGvdbwrwjlu85KkfF
 l2XZ4wlC+yiqsYf8NpnM0X82mp/8a91WPbP6AgQwW7onX3NTLdFbcA9I1tGhk0tH1ISREJhaxtc
 8JJ976I9LL0Clh98cxy/pcec1ImN7S61+LykmJyujuxo5BHVmHkHDcL5GV6SmkS4KLcIqfNoYVY
 LaOpVa6Q7le2GqyudF5zSL/GBbsZY4EZOBNsjEsM1BpsQcF1+p0UoJyOAklD0M0KcnZYXnEO6jm
 wDC02MKQzAmZAj8oYk1iUsKn4IYpxVfGIVE77B0HY9F0US57ul+D3x+anM6MSes9IzvSEXEwn8P
 JHSc3pDzndQvSbah4gbDMrcfse3Fa2HL3eSQ/tU8CSaPTh4dg+xk61qbN0yO+QoAlwq7MiyJhev
 SM2CfZF16x7SoH3vKlpvqJHNE5vBik=
X-Received: by 2002:a05:6000:2913:b0:439:af0e:57a8 with SMTP id
 ffacd0b85a97d-439da669bcdmr15880983f8f.33.1772996062970; 
 Sun, 08 Mar 2026 11:54:22 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dadb29fdsm20451324f8f.16.2026.03.08.11.54.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2026 11:54:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 0/2] tests/qtest/test-x86-cpuid-compat: fix leaks
Date: Sun,  8 Mar 2026 18:54:19 +0000
Message-ID: <20260308185421.972734-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

The test-x86-cpuid-compat has some leaks because it allocates
memory when setting up tests, and only frees it when the test
is actually run. This means that it leaks:
 * if the user asks to run only a particular test
 * if the user asks to list the tests with -l
 * when the subprocess tests re-invoke the test binary to
   run a single test in a subprocess

This patchset fixes this by deferring all allocations
to when the test is actually run, and instead passing
the test a pointer to a constant struct that has the
information it needs.

thanks
-- PMM

Peter Maydell (2):
  tests/qtest/test-x86-cpuid-compat: Switch test_cpuid_prop to
    data-driven
  tests/qtest/test-x86-cpuid-compat: Switch test_feature_flag to
    data-driven

 tests/qtest/test-x86-cpuid-compat.c | 430 ++++++++++++++++------------
 1 file changed, 245 insertions(+), 185 deletions(-)

-- 
2.43.0


