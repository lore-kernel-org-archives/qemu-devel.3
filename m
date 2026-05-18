Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CB0CD4F54
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 10:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOv7Y-0003Bx-Bo; Mon, 18 May 2026 06:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOv7K-00039U-Ct
 for qemu-devel@nongnu.org; Mon, 18 May 2026 06:22:35 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOv7F-0004Qc-MO
 for qemu-devel@nongnu.org; Mon, 18 May 2026 06:22:33 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so9103695e9.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 03:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779099745; x=1779704545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TZBH42ILwKQyH1XTfiS0LgBIXFhIK/W0uxA38waXJmE=;
 b=PDqXlmDNyyZFpIfwGnsahguxotU3aReLr+frhwao1FY9ByBK36kUTuOZE+3YOy2NmV
 pd+9px3O2RPaOU5/MzLr5+Uiw0IW9DvHX82jBZCG3yo8aveTNGmFN4SrNeBnXM6ZDVta
 r5wS8TfAtgofNUB+nDFU91IGyQArVPdhoT2vGQnBp44CIY0aZLOpETtFfJH5yzJfzQHr
 hQ4rrNt/zNVHZUu7YmtKMOUhkw++nbQXfMiAz2VQHuTzq5VYeR3jKB7ta+v+dfmT3/ae
 dl5kbunodJNXSSH+sCSzT8l8oM3b4Kj6RGduWxTSpnL60GTRVhfEKTR1exA54ShGd9st
 OCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779099745; x=1779704545;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TZBH42ILwKQyH1XTfiS0LgBIXFhIK/W0uxA38waXJmE=;
 b=c/O+5LmXPzUMBoee91jx7Q9sov3UV1rOmktwyNQx1ZGtpByBDl0eLy4KUnruDb0fzW
 ckd2h1xIfNUFnmLtnmWK2A9tgkQ/P8royrqmp1H2yA9eZDUYpvcJIM1JSsnqYaqzOerG
 43wQ7VlGBE1iuYRRhp5Ux2nQ41AMzpvHm1TUS28rVvf1j34B0qbOjn1E78hIXplmFaXe
 lbp1Vx6JFazUJolMTBN274ErD8qdcsY4ZgrcZWNV2NCL2S+8SpPu0fnL21DNJeHAstBo
 TmUi0z7l6Tt/yN4Z5r1z4i8vXbPjrBczSgyWOEmOl6TvEPTdIJPyE5E6eygnZa+tI8yU
 /AeQ==
X-Gm-Message-State: AOJu0YzIHkO/u2PV8DQ8rXggsoOLvSceRZ9Kzk+D1hZ2zvep2uVBD5Ir
 KJVfKpWn2Vg46n7oA92rB900GGzDylcGs4TSkv4BPpWSQR6yjSkUWRhC6TehZYXUQX2X3J5mbIE
 Pi+vyO68=
X-Gm-Gg: Acq92OE0jdMydHXl/YZsoiAPcG0pbhr2YS8tmy2zafpRtXmQxp0tOC9Fio6BS6YwbCj
 KJw9mMVlY+UEl8ceCew/58ZAFoOo4oIo7dgSRi0CszT/VoI6nI1l6I6eH/LbxPBLFAsd46wyFZM
 pwwcF7/m4fRuW9dRLVrSq1kir3aNCtsrZ4SHcAQVCJcRmKXccAO5rsDA4BkPFUXwDEEjRyjgnpQ
 vIuLtQA80UM+Pygl4qxVmxnAKvT+DE1rLyMfj1hleODmGz/7Rmla0nviFRyMUafVjH/rY1eDaou
 IZMmhyxq2KjgMYuQmAY9qHH5Qklnko5iE2GtisMMbc61BCnPP45F6DLV0Y4O8UfUTrs2K2H56kw
 1FG/ZuyUHN9U94fVSushjOI2HHMVkUfMf/OmY0fYeD90i81/Y5jipWbSU0QyHDlDuBv3IzjyI+7
 zvygY54tPlET7T+BAv18oLV+s2hKUAwproHroaRQ1MpyeKDDu11kzqlFZJ1LDJZOjXAbwcD16W
X-Received: by 2002:a05:600c:4fcb:b0:488:a797:f0ac with SMTP id
 5b1f17b1804b1-48fe6613ab3mr209820765e9.28.1779099744693; 
 Mon, 18 May 2026 03:22:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5694fbfsm429263165e9.6.2026.05.18.03.22.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 May 2026 03:22:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/7] docker: Remove LegacyKeyValueFormat warnings
Date: Mon, 18 May 2026 12:22:15 +0200
Message-ID: <20260518102222.80735-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Update MAINTAINERS entries for manually maintained Dockerfiles.

Remove warnings such:

 - LegacyKeyValueFormat: "ENV key=value" should be used instead of legacy "ENV key value" format (line 98)
 - LegacyKeyValueFormat: "ENV key=value" should be used instead of legacy "ENV key value" format (line 64)
 - LegacyKeyValueFormat: "ENV key=value" should be used instead of legacy "ENV key value" format (line 97)

See https://docs.docker.com/reference/build-checks/legacy-key-value-format/

Philippe Mathieu-Daudé (7):
  MAINTAINERS: Fix docker/dockerfiles/debian-hexagon-cross.docker path
  MAINTAINERS: Cover debian-loongarch-cross.docker with LoongArch
    section
  MAINTAINERS: Cover debian-xtensa-cross.docker with Xtensa section
  MAINTAINERS: Cover debian-tricore-cross.docker with TriCore section
  MAINTAINERS: Cover python.docker with Python library section
  docker: Remove LegacyKeyValueFormat warnings in non-generated files
  docker: Remove LegacyKeyValueFormat warnings in generated files

 MAINTAINERS                                        |  6 +++++-
 tests/lcitool/refresh                              | 12 +++++++-----
 tests/docker/dockerfiles/alpine.docker             |  2 +-
 tests/docker/dockerfiles/centos9.docker            |  2 +-
 .../dockerfiles/debian-all-test-cross.docker       | 10 ++++++----
 tests/docker/dockerfiles/debian-amd64-cross.docker |  2 +-
 tests/docker/dockerfiles/debian-arm64-cross.docker |  2 +-
 tests/docker/dockerfiles/debian-armhf-cross.docker |  2 +-
 .../docker/dockerfiles/debian-hexagon-cross.docker | 14 +++++++-------
 tests/docker/dockerfiles/debian-i686-cross.docker  |  2 +-
 .../dockerfiles/debian-loongarch-cross.docker      | 10 +++++-----
 .../dockerfiles/debian-mips64el-cross.docker       |  2 +-
 .../docker/dockerfiles/debian-mipsel-cross.docker  |  2 +-
 .../docker/dockerfiles/debian-ppc64el-cross.docker |  2 +-
 .../docker/dockerfiles/debian-riscv64-cross.docker |  2 +-
 tests/docker/dockerfiles/debian-s390x-cross.docker |  2 +-
 .../docker/dockerfiles/debian-tricore-cross.docker |  6 +++---
 .../docker/dockerfiles/debian-xtensa-cross.docker  |  8 ++++----
 tests/docker/dockerfiles/debian.docker             |  2 +-
 .../docker/dockerfiles/fedora-rust-nightly.docker  |  2 +-
 tests/docker/dockerfiles/fedora-win64-cross.docker |  2 +-
 tests/docker/dockerfiles/fedora.docker             |  2 +-
 tests/docker/dockerfiles/opensuse-leap.docker      |  2 +-
 tests/docker/dockerfiles/python.docker             |  5 +++--
 scripts/coverity-scan/coverity-scan.docker         | 12 ++++++------
 scripts/git.orderfile                              |  4 ++++
 26 files changed, 66 insertions(+), 53 deletions(-)

-- 
2.53.0


