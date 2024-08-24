Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D85AC52D6F
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2024 16:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shtJf-0005Oa-Cl; Sat, 24 Aug 2024 12:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1shtJd-0005Nv-Hn
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 12:08:37 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1shtJb-0005ws-Kz
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 12:08:37 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5bed0a2ae0fso3660079a12.1
 for <qemu-devel@nongnu.org>; Sat, 24 Aug 2024 09:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724515713; x=1725120513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0RKtHsllaFBWhpgp+Yh12CocZ/lit3Jpzg1mIlpvzK8=;
 b=rygkJFdrF5sURHZwxAjWfMY4GpOprdtFC49lfDXlm7BZ2iJ/rts4uNKW0HQm+KqGJJ
 60+gRoYpKgcDB0jaGE2isUBRAxWB09qGK5SEd1LO/4L0mEcQNCyr7C9P9qp3BzQ57IOl
 amiqpGPN+v6R1246dMTww8fWWxCwnfDIsRunvJQNxwpH5PyE7KDFkHwOY7qNz2wa8zVU
 TJRcik/OmA05VRkq6i3sT6WVzUDCTqHl5WCSgU77v4cqwgiflQM0DfMvhMLXM/fxEj3k
 VOdZxyunmrOuagVI7I/MKdeehLNYIjm5eYsTI+pbipAerqbeKfWB9x36zFVH71xKQFaE
 uFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724515713; x=1725120513;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0RKtHsllaFBWhpgp+Yh12CocZ/lit3Jpzg1mIlpvzK8=;
 b=oL31qGIM5Ke5NPXePWJwRv5bqvjQ6HwUR5fRBAbyy+9kRq8kfn7h/rPh5aYe9CXTS2
 QRDdY2LyY57+eLq7Y+hn7BLm2sVQbjPoRiCGY6cjhhlz3ntB7VZLTMa5EDqQ6ITFZCxO
 ZRUyr/Ga8Tti8Wh5B0PYJAHqfEhJYrdWsZwuOG1jtOdexqHLw1R69cEcFWSvMDT1i84T
 q3p5USyYWvLBotXQXh5FYtJtncBAp4u7mwG1ebzs9+3szGYewkCfeHxld4p773FkuX9u
 UAvP8CWvCOv7ENz+H/o0hUcI2fVO+XnsZvrWBBt9ajk/6WZzkebzhB4Nx6IQYDU6m9aQ
 rszA==
X-Gm-Message-State: AOJu0YzR1VKB8QPVAtAs+BDHbwoR4gFYd3YZOTto7PIkOWGprGEbZRpk
 Q6aAAD4gTPWHX5LWf2Awv6/rN2fMv9V83Fjk+wmTbV4XWMu9rsKjRIyrFpWVAplWt3aDdz7qGhw
 F
X-Google-Smtp-Source: AGHT+IFNpHJkSv4BTfct8HJ79b9nkV6srMEEkmtpafDR0yOJC1Z03JTLwJih8YXXXysV6gLAYyWpMg==
X-Received: by 2002:a17:906:f5a9:b0:a86:963f:ea8d with SMTP id
 a640c23a62f3a-a86a54df8demr390723166b.64.1724515713100; 
 Sat, 24 Aug 2024 09:08:33 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.198.30])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a868f29d749sm415682566b.66.2024.08.24.09.08.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 24 Aug 2024 09:08:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Cleber Rosa <crosa@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 0/7] tests/functional: Convert few MIPS avocado tests
Date: Sat, 24 Aug 2024 18:08:21 +0200
Message-ID: <20240824160829.27655-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

$ RESCUE_YL_PATH=/path/to/fuloong2e/rescue-yl \
  QEMU_TEST_ALLOW_UNTRUSTED_CODE=1 \
  QEMU_TEST_FLAKY_TESTS=1 \
  QEMU_TEST_TIMEOUT_EXPECTED=1 \
    make check-functional V=1
▶  2/17 test_empty_cpu_model.EmptyCPUModel.test                                                      OK
 2/17 qemu:func-quick+func-mips64el / func-mips64el-empty_cpu_model                                  OK  0.14s   1 subtests passed
▶  8/17 test_empty_cpu_model.EmptyCPUModel.test                                                      OK
 8/17 qemu:func-quick+func-mips / func-mips-empty_cpu_model                                          OK  0.13s   1 subtests passed
▶  4/17 test_version.Version.test_qmp_human_info_version                                             OK
▶  5/17 test_empty_cpu_model.EmptyCPUModel.test                                                      OK
▶  7/17 test_version.Version.test_qmp_human_info_version                                             OK
 4/17 qemu:func-quick+func-mips64el / func-mips64el-version                                          OK  0.17s   1 subtests passed
 5/17 qemu:func-quick+func-mipsel / func-mipsel-empty_cpu_model                                      OK  0.17s   1 subtests passed
 7/17 qemu:func-quick+func-mipsel / func-mipsel-version                                              OK  0.18s   1 subtests passed
▶ 10/17 test_version.Version.test_qmp_human_info_version                                             OK
10/17 qemu:func-quick+func-mips / func-mips-version                                                  OK  0.21s   1 subtests passed
▶  1/17 test_mips64el_fuloong2e.MipsFuloong2e.test_linux_kernel_2_6_27_isa_serial                    OK
▶  3/17 test_info_usernet.InfoUsernet.test_hostfwd                                                   OK
▶ 11/17 test_empty_cpu_model.EmptyCPUModel.test                                                      OK
 3/17 qemu:func-quick+func-mips64el / func-mips64el-info_usernet                                     OK  0.29s   1 subtests passed
▶  6/17 test_info_usernet.InfoUsernet.test_hostfwd                                                   OK
11/17 qemu:func-quick+func-mips64 / func-mips64-empty_cpu_model                                      OK  0.16s   1 subtests passed
 6/17 qemu:func-quick+func-mipsel / func-mipsel-info_usernet                                         OK  0.30s   1 subtests passed
▶  9/17 test_info_usernet.InfoUsernet.test_hostfwd                                                   OK
 9/17 qemu:func-quick+func-mips / func-mips-info_usernet                                             OK  0.30s   1 subtests passed
▶ 13/17 test_version.Version.test_qmp_human_info_version                                             OK
13/17 qemu:func-quick+func-mips64 / func-mips64-version                                              OK  0.19s   1 subtests passed
▶ 12/17 test_info_usernet.InfoUsernet.test_hostfwd                                                   OK
12/17 qemu:func-quick+func-mips64 / func-mips64-info_usernet                                         OK  0.24s   1 subtests passed
▶ 17/17 test_mips_malta.MaltaMachineConsole.test_mips_malta                                          OK
▶ 16/17 test_mipsel_malta.MaltaMachineConsole.test_mips_malta32el_nanomips_16k_up                    OK
▶  1/17 test_mips64el_fuloong2e.MipsFuloong2e.test_linux_kernel_3_16                                 OK
 1/17 qemu:func-quick+func-mips64el / func-mips64el-mips64el_fuloong2e                               OK  3.10s   2 subtests passed
▶ 16/17 test_mipsel_malta.MaltaMachineConsole.test_mips_malta32el_nanomips_4k                        OK
▶ 14/17 test_mips64el_loongson3v.MipsLoongson3v.test_pmon_serial_console                             OK
14/17 qemu:func-thorough+func-mips64el-thorough+thorough / func-mips64el-mips64el_loongson3v         OK  4.71s   1 subtests passed
▶ 16/17 test_mipsel_malta.MaltaMachineConsole.test_mips_malta32el_nanomips_64k_dbg                   OK
▶ 16/17 test_mipsel_malta.MaltaMachineYAMON.test_mipsel_malta_yamon                                  OK
16/17 qemu:func-thorough+func-mipsel-thorough+thorough / func-mipsel-mipsel_malta                    OK  8.64s   4 subtests passed
▶ 15/17 test_mips64el_malta.MaltaMachineConsole.test_mips64el_malta                                  OK
▶ 17/17 test_mips_malta.MaltaMachineConsole.test_mips_malta_cpio                                     OK
17/17 qemu:func-thorough+func-mips-thorough+thorough / func-mips-mips_malta                          OK  14.06s   2 subtests passed
▶ 15/17 test_mips64el_malta.MaltaMachineConsole.test_mips64el_malta_5KEc_cpio                        OK
▶ 15/17 test_mips64el_malta.MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_1core     OK
▶ 15/17 test_mips64el_malta.MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_7cores    OK
▶ 15/17 test_mips64el_malta.MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_8cores    OK
▶ 15/17 test_mipsel_malta.MaltaMachineYAMON.test_mipsel_malta_yamon                                  OK
15/17 qemu:func-thorough+func-mips64el-thorough+thorough / func-mips64el-mips64el_malta              OK  56.88s   6 subtests passed

Ok:                 17
Expected Fail:      0
Fail:               0
Unexpected Pass:    0
Skipped:            0
Timeout:            0

Based-on: <20240821082748.65853-1-thuth@redhat.com>

Philippe Mathieu-Daudé (7):
  tests/functional: Convert mips64el Fuloong2e avocado test (1/2)
  tests/functional: Convert mips64el Fuloong2e avocado test (2/2)
  tests/functional: Convert mips64el I6400 Malta avocado tests
  tests/functional: Convert mips64el 5KEc Malta avocado tests
  tests/functional: Convert mips32el Malta YAMON avocado test
  tests/functional: Convert nanomips Malta avocado tests
  tests/functional: Convert mips32eb 4Kc Malta avocado tests

 MAINTAINERS                                 |   6 +-
 tests/avocado/boot_linux_console.py         | 217 --------------------
 tests/avocado/machine_mips_fuloong2e.py     |  42 ----
 tests/avocado/machine_mips_malta.py         | 162 ---------------
 tests/functional/meson.build                |  13 ++
 tests/functional/qemu_test/utils.py         |  20 ++
 tests/functional/test_mips64el_fuloong2e.py |  67 ++++++
 tests/functional/test_mips64el_malta.py     | 193 +++++++++++++++++
 tests/functional/test_mips_malta.py         |  84 ++++++++
 tests/functional/test_mipsel_malta.py       |  98 +++++++++
 10 files changed, 479 insertions(+), 423 deletions(-)
 delete mode 100644 tests/avocado/machine_mips_fuloong2e.py
 delete mode 100644 tests/avocado/machine_mips_malta.py
 create mode 100755 tests/functional/test_mips64el_fuloong2e.py
 create mode 100755 tests/functional/test_mips64el_malta.py
 create mode 100755 tests/functional/test_mips_malta.py
 create mode 100755 tests/functional/test_mipsel_malta.py

-- 
2.45.2


