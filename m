Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DABDCA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxSZ-0001Cn-3o; Wed, 30 Sep 2026 12:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBxSJ-00014G-KB
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:46:55 -0400
Received: from mail-wr2-x0f.google.com ([2a00:1450:4864:30::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBxSH-000325-R8
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:46:55 -0400
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-488811c9ebaso2877680f8f.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790786812; x=1791391612; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=s3d9e3+6lATNIJ3R591QZAB9SA98d8rqm4Qwimrj2Jc=;
 b=ch5wmFOgy32//GC4k9fA6B/IXPXAIM8V/XyPUrsNhIGfkVP8uAxC8EGO54d72PICar
 1GItIWX0e35SNRFeDkdecYj5BKHU21aXZrqojxpiAdzubjnVGx4rN3hJ6XF/DW0jeggr
 MiTrBv9uRw35rB4+hDoLLfMD8wUJWVJB5S2goiD++g4peiEXNkMdc6BmtU/SL8cwXKHG
 Cil6AxHrp48f0J1adFV/IxfqcF+zLsDp2u7LfxmdDSO9wpcvyGpRHupfhgvf12zlPPCA
 8XLsnfB5CO/TKvGfT9cZbdeUN+oYtm0z+yi9IZnGBOegmsIFxax2TJJqR/7UQh+f8YlO
 B6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790786812; x=1791391612;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=s3d9e3+6lATNIJ3R591QZAB9SA98d8rqm4Qwimrj2Jc=;
 b=pJKJi0HUHbQtIi5eFmJmZi1TsKTkWBAGMz2keTAboda1oNqujUw7h2jba57XhYk3tp
 HFisEk3lMZppQEjCFJ31yYb7FdshcJiE6Inf7tDl9lnoLqqWgKs0BfnpthEYSlEXLC+3
 2PjOUtnfPkckv4jJg+0+IMXFe00EVbi7shDdBdpGYlh+PgKoelM29RISOJxktPKMfjxj
 ZGgVizQ5LnquzCvaYxfGLGmGFjetlrbLe3w94SrKtKB4wAX2OA1/RaktyNY2Gs8e1630
 X2klqncLdBLQHWfU6JYOboVLZu8WJmgMeB0LKodXl4Xn7uqqWPITobZE+B/jHstsgCf0
 ZrUQ==
X-Gm-Message-State: AFuF++lAWO/oJ6+Pq+aXBvGfJXl1vT4YIhpQ0KFO9826BAcc4jQs+rsd
 QlW5Ehp98//fa7lDrBV8LB6ksclN7wpESfaQHrWVByBggZIJT2sYbiX+k2LqWMIwuII=
X-Gm-Gg: AYBFou3LP6tBcGfC3g9fm8SCOqElbUEwWLyZNwOs8N2wRYG7bmjrd/q1eXENvqZMmJE
 79OlKNiD/zP9ANeY+fNgiCLZBH6cJQT7d41idGx8/OfyN5a+b119q+uTmEE2neZBV8iQwhof/13
 76KDH9UBEiUqYjesqZsgErrM5qUcD8BHXBIFIfBlYzBIlPfSfLoBcWoXvmp/pVvDyNa/g7jZTeC
 X0TcBDvVi5H2KTS0DuhZbL/Dok2fQBT32f/TyVtOyZWF2lueJoXoR6s2mus0c//MuH2tAZ6BZ5L
 J8zTVBUb17vPzZ5bx9x4uaB4pefeldWk/QEMqLoISvZEOMEBe7H9R5gCoCaEvpftFAINXaSvyvU
 wqCB23aSspBfGgqLs+rQ0+q0L8/y8vMl9FV13qKOquRMNwZaLncGb+2KO/SZV7c9v8a7hvbR4oq
 wklsgSHjpuaV674fegZUCBg3FjOPVqNauu9XtJJG1j59OJIe1wOPVQDfoNWbq32QIMkZfpmQ==
X-Received: by 2002:a05:600d:4448:10b0:49c:fa20:cc02 with SMTP id
 5b1f17b1804b1-4a01b1215ddmr28190465e9.25.1790786812048; 
 Wed, 30 Sep 2026 09:46:52 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01eb694fcsm3849545e9.6.2026.09.30.09.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:46:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B89045F8D0;
 Wed, 30 Sep 2026 17:46:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Song Gao <gaosong@loongson.cn>,
 Ani Sinha <anisinha@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brad Smith <brad@comstyle.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Anders Roxell <anders.roxell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Klaus Jensen <its@irrelevant.dk>
Subject: [PATCH 00/13] testing/next: functional testing updates for gdb
Date: Wed, 30 Sep 2026 17:46:36 +0100
Message-ID: <20260930164649.433573-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr2-x0f.google.com
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

Hi,

This is the current state of my testing/next tree. There a are a few
minor tweaks and fixes that I've picked up. The majority of the new
code adds testing for the gdb stub when used via KVM. There are two
approaches.

The first is an attempt to work just with the default bios code. It's
a little limited and I'm not super happy with the "special" heuristics
due to the fragility but it does work without symbols.

As a result I spoke to Anders who handles the tuxrun images and he was
able to turn on debugging symbols and provide a vmlinux alongside the
bootable image. With these updates I was able to resurrect the old
test script I was running by hand and then plumb it into a functional
test.

So far I've only done x86_64 but if people are happy with the result
I'll do the remaining KVM hosts and test the ones where I can (do we
have a riscv kvm host anywhere?).

The reason I went on the side-quest is because when working on
cleaning up QEMU's internal KVM api I realised that quite a large
chunk of it is not exercised by our functional tests. This would
ensure that at least:

  kvm_arch_update_guest_debug
  kvm_arch_get_registers
  kvm_arch_set_registers

is exercised and I'm less likely to break things in my r-factor ;-)

Alex.

Alex Bennée (12):
  tests/functional: test_acpi_bits requires TCG
  tests/functional: add migration diagnostics and pace nvme activity
    (HACK!)
  meson: move gdb detection into the top level build file
  tests/functional: add basic gdbstub test for KVM
  tests/functional: allow tuxrun tests to be passed "accel"
  tests/functional: split x86_64 tuxrun into tcg and kvm run
  tests/functional: split aarch64 tuxrun into tcg and kvm run
  tests/functional: update x86_64 tuxrun images
  tests/guest-debug: add --kargs option to run-test
  tests/guest-debug: add --symbols option to run-test
  tests/functional: teach tuxrun about launching gdb tests
  tests/functional: add tuxrun kvm gdb test for x86_64

Max Filippov (1):
  tests/tcg: fix buffer overflow in multiarch/linux/linux-sigrtminmax

 meson.build                                   |  15 +-
 tests/tcg/multiarch/linux/linux-sigrtminmax.c |   2 +-
 tests/functional/aarch64/test_tuxrun.py       |  10 ++
 .../functional/gdb-scripts/kernel_gdb_test.py | 157 ++++++++++++++++++
 .../functional/gdb-scripts/kvm_fw_gdb_test.py | 119 +++++++++++++
 tests/functional/meson.build                  |   5 +-
 tests/functional/migration.py                 |  37 ++++-
 tests/functional/qemu_test/tuxruntest.py      |  99 +++++++++--
 tests/functional/x86_64/meson.build           |   1 +
 tests/functional/x86_64/test_acpi_bits.py     |   2 +
 tests/functional/x86_64/test_kvm_gdbstub.py   |  55 ++++++
 .../functional/x86_64/test_nvme_migration.py  |   1 +
 tests/functional/x86_64/test_tuxrun.py        |  45 ++++-
 tests/guest-debug/run-test.py                 |  10 ++
 tests/tcg/meson.build                         |   5 -
 15 files changed, 523 insertions(+), 40 deletions(-)
 create mode 100644 tests/functional/gdb-scripts/kernel_gdb_test.py
 create mode 100644 tests/functional/gdb-scripts/kvm_fw_gdb_test.py
 create mode 100755 tests/functional/x86_64/test_kvm_gdbstub.py

-- 
2.47.3


