Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4816E77183
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 20:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL75S-000754-OO; Tue, 10 Dec 2024 15:44:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tL75N-0006z8-3Z
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 15:44:01 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tL75G-0001zU-NX
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 15:44:00 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4361a50e337so4998835e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 12:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733863433; x=1734468233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XRWNv/TWApB4FZiRPy0+mcCq2y3awyCcpQtghS1vd8E=;
 b=QKY30bZ00KgYGpHU4IrgIi/jM/Ht5Ivw35AAGI5+i5/VJuOvQ6zvjPySqDxy0F5MLm
 DimJAuT/KgdvEwjKrybT4gH8ZmoD+YAIcdqXD3aeXVe4l8pWicZp5tCVs3pRRNOQyZDx
 8TsfrrpIAGo3RTyC6+nYPekmxSAGR+0wTJMLb/2nRj9IOkfq6bCafN7hdPacuRdpReen
 IHrMPPM7CDTZzVZyUOkbjsEspNGFWaF6WsuKUQsrB4OzTZ9FUNe919nCCsMCkgr+po7w
 HD9IkJbpVIBeHiOx4jAiTNsrN3TogNOLLGoLcom2bmwdhVWPmJpGel8mbaKf3b0FWvi3
 /Z6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733863433; x=1734468233;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XRWNv/TWApB4FZiRPy0+mcCq2y3awyCcpQtghS1vd8E=;
 b=wwqgkNc3bGs3xgGohCpRKCJPFgfI9ApkeEPur5LhQPo1OoAxEnBrSAK1LYH+rvwVkq
 SFoAk0Br9QqszEkOpH6ixiF06AaBBWGukk1E/OlDxl/Ce/S6JvK8iDtrrM9MLwU99F39
 okJa3kr8uu11Dybq2D13cQ8LG9jXHJvPPTDxWXQQV0ApOKNw6Mau6BThPk/iAgbPqJ/h
 A6rtIYmaxJP0uTMKgZ8BNbvYwdVFvtPZL9emfsfv0tPKYmu6EIf8v4urRskwgYgfQXvr
 cwfY89faDJlQramnK9008w5SdhaCEKlmt83gG1ye+zBteO98zr08oMCe0pBeZ4LqPe3o
 rhPA==
X-Gm-Message-State: AOJu0Yz1GgwKq3Irvt4Sg+hspZkRFULBOG5bRG47x64uLzQ+FP+WYr9S
 ob5c+rQKZbgS45SAX2dvjoFvwpcF2ftPplU06b5Re1HZuCcRUVORzIl7cTgyKqA=
X-Gm-Gg: ASbGncuxfFhpg6n0n7if9XrtjSi+0H05LEN41ovVbOJC+bPZYagezXBh2vIF4dCXb/p
 eJX3XhRLryeAo9sLrFXFKjIJwxqyYgDQLcM1dXTa7WdFJNkOsmyhRZtmH+FnuU/Fd5iTwZ74tRl
 rMQxSgSKF13JWVczE+w0OSArcA6WIiKtkr+CTCr7wwfh8rhY4I1JmI7olY+sxLIsQ5SQei4gLmt
 xZDVpO/S7DKzZEReisHRmSskoGITetq/o1UxHeTHGLYpObTrpAF
X-Google-Smtp-Source: AGHT+IGkmi88FnDs8R8bYlRVGNYC7VXbqQdjkVeYKDQILouG8LBR2/FW78cUWGpF687x9ouk0NUxyA==
X-Received: by 2002:a05:600c:5122:b0:42c:c401:6d8b with SMTP id
 5b1f17b1804b1-4361c38d8edmr1804255e9.7.1733863433071; 
 Tue, 10 Dec 2024 12:43:53 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3862f0e6ea2sm13170856f8f.79.2024.12.10.12.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 12:43:51 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6DB445F87D;
 Tue, 10 Dec 2024 20:43:49 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-s390x@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Cleber Rosa <crosa@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-arm@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 00/20] testing/next: functional tests and qtest timers
Date: Tue, 10 Dec 2024 20:43:29 +0000
Message-Id: <20241210204349.723590-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

There are two parts to this series. The first is the updated images
for all the guests that didn't make it into 9.2. There are also some
new functional tests for virtio-gpu along with some other clean-ups.

The qtest patches focus on ensuring things calling clock_step and
clock_set actually pay attention to return values. Currently only the
virtio tests needed a little re-jigging although arguably the timeout
loops aren't needed at all.

Please review:

  tests/functional: extend test_aarch64_virt with vulkan test
  tests/functional: remove hacky sleep from the tests
  system/qtest: properly feedback results of clock_[step|set]
  tests/qtest: move clock_steps to after checks
  util/qemu-timer: fix indentation

Alex.

Alex Bennée (19):
  tests/functional: update the arm tuxrun tests
  tests/functional: update the i386 tuxrun tests
  tests/functional: add a m68k tuxrun tests
  tests/functional: update the mips32 tuxrun tests
  tests/functional: update the mips32el tuxrun tests
  tests/functional: update the mips64 tuxrun tests
  tests/functional: update the mips64el tuxrun tests
  tests/functional: update the ppc32 tuxrun tests
  tests/functional: update the ppc64 tuxrun tests
  tests/functional: update the riscv32 tuxrun tests
  tests/functional: update the riscv64 tuxrun tests
  tests/functional: update the s390x tuxrun tests
  tests/functional: update the sparc64 tuxrun tests
  tests/functional: update the x86_64 tuxrun tests
  util/qemu-timer: fix indentation
  tests/qtest: move clock_steps to after checks
  system/qtest: properly feedback results of clock_[step|set]
  tests/functional: remove hacky sleep from the tests
  tests/functional: extend test_aarch64_virt with vulkan test

Pierrick Bouvier (1):
  tests/functional/aarch64: add tests for FEAT_RME

 system/qtest.c                               |  23 ++--
 tests/qtest/libqos/virtio.c                  |   6 +-
 util/qemu-timer.c                            |   2 +-
 tests/functional/meson.build                 |   5 +
 tests/functional/test_aarch64_rme_sbsaref.py |  70 +++++++++++++
 tests/functional/test_aarch64_rme_virt.py    | 100 ++++++++++++++++++
 tests/functional/test_aarch64_virt.py        | 105 ++++++++++++++++---
 tests/functional/test_arm_tuxrun.py          |  28 ++---
 tests/functional/test_i386_tuxrun.py         |   8 +-
 tests/functional/test_m68k_tuxrun.py         |  34 ++++++
 tests/functional/test_mips64_tuxrun.py       |   8 +-
 tests/functional/test_mips64el_tuxrun.py     |   8 +-
 tests/functional/test_mips_tuxrun.py         |   8 +-
 tests/functional/test_mipsel_tuxrun.py       |   8 +-
 tests/functional/test_ppc64_tuxrun.py        |  16 +--
 tests/functional/test_ppc_tuxrun.py          |   8 +-
 tests/functional/test_riscv32_tuxrun.py      |   8 +-
 tests/functional/test_riscv64_tuxrun.py      |  16 +--
 tests/functional/test_s390x_tuxrun.py        |   8 +-
 tests/functional/test_sparc64_tuxrun.py      |   8 +-
 tests/functional/test_x86_64_tuxrun.py       |   8 +-
 21 files changed, 387 insertions(+), 98 deletions(-)
 create mode 100755 tests/functional/test_aarch64_rme_sbsaref.py
 create mode 100755 tests/functional/test_aarch64_rme_virt.py
 create mode 100644 tests/functional/test_m68k_tuxrun.py

-- 
2.39.5


