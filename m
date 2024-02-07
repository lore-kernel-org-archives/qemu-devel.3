Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A668C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 16:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXkwD-0002nv-Tf; Wed, 07 Feb 2024 11:38:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rXkwC-0002ne-Gb
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 11:38:16 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rXkwA-00066T-PH
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 11:38:16 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41028900b83so1257975e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 08:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707323893; x=1707928693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WlKp9d70XQ8fXpBt0YxGjxqCi1DdUKUDYda3Sj9Zt2k=;
 b=C/RsNRJiVBuOF78HAvFAsmjrxXzWVo+nYc539HHZ8X8pJ4Evc2dwWMHdSfhtPX8pm4
 UErdumWr6NC+bMrXXD6EozFEavKqoQuD/4Y87D7dApuEmJ4E6ZVCZSZXJeGalgChGLgY
 KSuNMXbP3+8zf0WXkbju5DtMqHHLt4FNKkrolnbOV5+fN8woaeKI1878WfL8QvyWk99l
 Hqr+EmIpgrs/sQ4UpV9cwglzh8o2Q/vJo3Erod8QCdb5phERjMc69ALGechVUzG6jXj/
 2HHNELpK0zM7YxdqwnSd+9UtcV8psu7KpB3oIFdss2cknD68QUEqGSOHIQibGCwV9grd
 NDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707323893; x=1707928693;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WlKp9d70XQ8fXpBt0YxGjxqCi1DdUKUDYda3Sj9Zt2k=;
 b=Y92EhqofgDY4rkfclDBYHetspDGBEqqkZRkRKaKfDcTZ/giBfLDzUq6U5qGy/Jsf9g
 WGpeptx/19WtNyQ2stpKqsm77xBrBp60DQ1B4zxfbN2KR8xfOzBoy45vAwfGx47orG+G
 V0cz8l/RFxRCZy8LYEszm1eGC6OgtlhiOfW3cinTLz2So9f4MbxXgDWUPli0OjQ8YsZB
 n/kcsBGZZo72MNMoelp5A8prsqeeyR4iqSh3MzixFcdfVWYey760g2Zwxsxjw+GZnklo
 OvGvcuHoAZQaISFjcvXCoSC8mLal3RFS++CX4m1m77vwI5etE4ifRjlsU9cx1ZImDp4F
 fZ2g==
X-Gm-Message-State: AOJu0YxREYvv6s58g/WomPO8YhKvkHADsg9YnQ6GPIPYvpVJ/bzvvP/q
 nKIVaA+WSYkUEBQ+GBPWpYPJufjVD5BIplbfFJaI9zXHVNCktwphUFkPjpDC7ig=
X-Google-Smtp-Source: AGHT+IG9ZsuE8Kac17CgEZosUatIAWfcA5HG129aTLlLVj14HE4KxHZMdVKgaa2zjkm/ypsPzXXesg==
X-Received: by 2002:a05:600c:46c7:b0:40e:b29c:7103 with SMTP id
 q7-20020a05600c46c700b0040eb29c7103mr4518974wmo.8.1707323892997; 
 Wed, 07 Feb 2024 08:38:12 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXVVD88JpHiK2idhRmUo7scVVxDeoiUY7Mzi58y7mzTVCUgK6rObnzakvMQNvNKKJzRhcc61r4pDoMwe3a5GwJxHGrpGBJI573Rt7dbsw5PNEpO6/rjOnhFroHiPuB72yu0Pom1kjUZrGKE7hKmRYJs7pqvHIrtP3m5EBac1czrux3Npa+OX7kLbVJonUt8LpgotKN98BX3ef7KKjxdvge68lkUGLJC7du283U2/4xK9d8RmQxXdpl1WDH2YsIXv/9wqO4Y3gns8jpdPlCwC5ggqK1bJkuNuAtgt4hDcPpMyLJACoUqcZYKfv4osCT8ZtMkPS83Sxa42tjwMDfDIfSl8oqD7ObU9UmAw1LMkHESL2LaYMSIstE4F1xqxsB6Ql8ts4hxAno+BHKRXH4Byw/se5rb+N5oXLn+SbUvklu8k1psTRdPeT+pEHFFFybYYS8kpFYbLik7pvY8qNTMDrRrBrQjg3gr99IC7rF1UKOkOOmiYJ0aZ2IqMs8l5DdODTzaeJZVaQKMPGgbQbl32qncqxYWLgwowss8nIIBjdY1U7Cp4bxEecNRnFcxFBzH3IYWt3T0nwKi26SH/xq/FA8neCXwZs7zfm+3j4C+p1q/XafpAUZsVba76mbREde9o9UscIjMoHc1kZ/8Fkc3EcDeKyxR1mTJ722gVcN6dzo4FzXWOuqi5dbr6Oj9JTvNtCEVDYODB1C01mQ/sUhTcCW5cme1NZHdvPzuloZn4hLThFERNkdBI7Q6yu5SOY/NyAedgx+Em0s097lWa672m4LRn9PrejIQIZDbKW+tTW7KDs6aXBaitTAFelUpjyiSttBjeG3nhmZOt0A=
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 g16-20020adfa490000000b0033b50ed5f98sm1154188wrb.72.2024.02.07.08.38.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 08:38:12 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 26D785F7B1;
 Wed,  7 Feb 2024 16:38:12 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Chris Wulff <crwulff@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Bin Meng <bin.meng@windriver.com>, Thomas Huth <thuth@redhat.com>,
 qemu-riscv@nongnu.org, Marek Vasut <marex@denx.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, Warner Losh <imp@bsdimp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Kyle Evans <kevans@freebsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>
Subject: [PATCH v2 00/14] maintainer updates for 9.0 pre-PR (docker,
 plugin tests, deprecation, elf, semihosting, gdbstub)
Date: Wed,  7 Feb 2024 16:37:58 +0000
Message-Id: <20240207163812.3231697-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

A fairly random collection of fixes in this tree. I've still got a
report of openbsd rebuilding which is confusing me (something triggers
it but calling again works as expected).

v2
  - added Ilya's vm-build and gdbstub patches

Everything is reviewed now so baring objections I intend to post the
PR on Friday afternoon.

Alex.

Alex Bennée (2):
  docs: mark CRIS support as deprecated
  Revert "hw/elf_ops: Ignore loadable segments with zero size"

Fabiano Rosas (1):
  tests/docker: Add sqlite3 module to openSUSE Leap container

Ilya Leoshkevich (9):
  tests/vm: Set UseDNS=no in the sshd configuration
  tests/vm/freebsd: Reload the sshd configuration
  test-util-filemonitor: Adapt to the FreeBSD inotify rename semantics
  meson: Link with libinotify on FreeBSD
  gdbstub: Expose TARGET_SIGTRAP in a target-agnostic way
  gdbstub: Allow specifying a reason in stop packets
  gdbstub: Add syscall entry/return hooks
  gdbstub: Implement catching syscalls
  tests/tcg: Add the syscall catchpoint gdbstub test

Paolo Bonzini (2):
  configure: run plugin TCG tests again
  kconfig: use "select" to enable semihosting

 docs/about/deprecated.rst                     |   8 ++
 configure                                     |   3 +
 configs/devices/m68k-softmmu/default.mak      |   2 -
 configs/devices/mips-softmmu/common.mak       |   3 -
 configs/devices/nios2-softmmu/default.mak     |   2 -
 configs/devices/riscv32-softmmu/default.mak   |   2 -
 configs/devices/riscv64-softmmu/default.mak   |   2 -
 configs/devices/xtensa-softmmu/default.mak    |   2 -
 meson.build                                   |  23 +++-
 gdbstub/internals.h                           |   2 +
 include/gdbstub/user.h                        |  29 ++++-
 include/hw/elf_ops.h                          |  75 ++++++-------
 include/user/syscall-trace.h                  |   7 +-
 gdbstub/gdbstub.c                             |   9 ++
 gdbstub/user-target.c                         |   5 +
 gdbstub/user.c                                | 104 +++++++++++++++++-
 tests/tcg/multiarch/catch-syscalls.c          |  51 +++++++++
 tests/unit/test-util-filemonitor.c            |   8 ++
 target/m68k/Kconfig                           |   1 +
 target/mips/Kconfig                           |   1 +
 target/nios2/Kconfig                          |   1 +
 target/riscv/Kconfig                          |   2 +
 target/xtensa/Kconfig                         |   1 +
 tests/docker/dockerfiles/opensuse-leap.docker |   1 +
 tests/lcitool/mappings.yml                    |   4 +
 tests/lcitool/projects/qemu.yml               |   1 +
 tests/tcg/multiarch/Makefile.target           |  10 +-
 tests/tcg/multiarch/gdbstub/catch-syscalls.py |  53 +++++++++
 tests/vm/basevm.py                            |   2 +
 tests/vm/freebsd                              |   1 +
 util/meson.build                              |   6 +-
 31 files changed, 358 insertions(+), 63 deletions(-)
 create mode 100644 tests/tcg/multiarch/catch-syscalls.c
 create mode 100644 tests/tcg/multiarch/gdbstub/catch-syscalls.py

-- 
2.39.2


