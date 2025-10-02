Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADE2CAC5BB
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 02:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v48h9-0006nX-2U; Wed, 01 Oct 2025 22:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v48h3-0006nK-Pw
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 22:05:18 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v48gs-0004fV-Dk
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 22:05:16 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-269639879c3so3985655ad.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 19:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759370694; x=1759975494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FivvktU0jbEhjj/HTdgr6u5hVHc6MYuV57Fgxg1uJks=;
 b=H5yROKi1bk3lWOM5wTY+t/kNm/LG3GtzUh6rLTYeF/2kxMXWPoHMVVKOhdLCbv79cV
 PH7s/o63oHv+TG4+LRpge4e2IuB9Hxr71f4YFKfKFvmPLSmTV13BVhNRN2WcfuefjOBU
 E8+1tekgoEZjyhKEgIyyBNhzz5gOZKan0GHT3/JNS2E/oYKC4pgwd+mngbynzK+KLkzM
 zVlsVndvz0Gz0+8cZrJJzgGc5Klv4sTkhxNTM6S+P20KGZR8xnSXK5VIa1q1k/620TmE
 pj4wEDey8nI0OkwHfbN9TS5Jd9hrFO3TMaA7FH1rI/nnxgh2qVo3Pocx3mUbDEoGhDq0
 Br3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759370694; x=1759975494;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FivvktU0jbEhjj/HTdgr6u5hVHc6MYuV57Fgxg1uJks=;
 b=YKtGHgsh1GAHvJYxe6m+n7nkxtsda7rI+3L0Jjngt/5SLsCxY2THMMiev/zCxWFzBu
 GIDXz9WmfQCiGyFLKrcC25lXFT+9Pdda+tSogAm4JZDgKXNGlhGARjCngn//NWiZgIB1
 EPHM1CU/IsxV2405vfMGKyQ3BLqd+GP8k1co5kc/bId8VUmRYkc9aKWKFEvrXj2HcdA+
 zs19VBz9OLOnjVPmCJkJiQm4mdWD0iPdrWbJncaSOqFwVNa3zkmAdMfMUbvDBXbVoMOB
 IJc1TvNhqhoF6Q9wdGONQvuWmnlQ5O4Sn+okwWTZoPU/v9a+AVgJ4//ItuEfZ4s5uPDN
 vM/w==
X-Gm-Message-State: AOJu0YwNEqZDHlkmKJVsR0rZh53MZel6W0TOLsuCysuT5E0TgZSW1mOY
 PxLBjKUZVhHiV4tY+A3u53X5zcB8tdOkTO69QLnsRW9mwNjZvGkiJdtqVXOHv43adoqzRjdfMqb
 MtV7l
X-Gm-Gg: ASbGncspMUOjnBpcCYleWH9b4rSWXpt6pYVaZ4+IJzkL0HFIeRlBPwnitKUQOmD1yXl
 RE4CfGZfsMDefMFgYkYjas6CuV2g/ks9liX9KB0HM48L4s4KYPwVGoF/PdErWa01ZyeJOF7DTls
 eo8IVBkw9tCvO78UmhBEwemN0KBIeyydJbIV/xDQ08zY1cpnCLsMscVZ3N3PJlHImcH+SZfazxk
 oW3RE0vYmXa9DO5gq/pZnOesIROkVUb9BI5YLm8HslZR9csVIqtuxQvIfze4t4I+6boDMyygGC9
 s3trG6HRYquiznrOPp6U8vVyQNCdiCFuSBURrDBWak/hEgNaHSg9QWH2SmVGKtZsrt15g1vtHq7
 5ZRtRg1yaZFncTnuRr58dvu5UjJ2Zy1/YKIHA5HRJ/oz1CS/KLBh+uK0X
X-Google-Smtp-Source: AGHT+IGVgOgOR4ddg0P5T4pwf/rinS24E0pt8DH8l7WBbsNeh5GVp10Utv8yBtG5q5o2P5/L+Lx6tQ==
X-Received: by 2002:a17:902:82c6:b0:269:a8a8:4029 with SMTP id
 d9443c01a7336-28e7f16792bmr55380585ad.5.1759370694018; 
 Wed, 01 Oct 2025 19:04:54 -0700 (PDT)
Received: from gromero0.. ([186.215.59.111]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1d95bdsm9476735ad.119.2025.10.01.19.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 19:04:53 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 berrange@redhat.com
Cc: qemu-arm@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v5 0/9] tests/functional: Adapt reverse_debugging to run w/o
 Avocado
Date: Thu,  2 Oct 2025 02:04:23 +0000
Message-Id: <20251002020432.54443-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x635.google.com
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

The goal of this series is to remove Avocado as a dependency for running
the reverse_debugging functional test.

After several rounds of discussions about v1 and v2, and experiments
done by Daniel and Thomas (thanks for all the experiments and comments
so far), I've taken a new approach and moved away from using a runner
for GDB. The changes, I believe, are much simpler now.

This new series uses GDB's machine interface (MI) via the pygdbmi module
(thanks Manos and Peter for the inputs). pygdbmi provides a controller
to start GDB and communicate with it through MI, so there is no longer a
risk of version clashes between libpython in GDB and Python modules in
the pyvenv, as it could, in theory, happen when GDB executes the test
script via -x option.

Also, as Daniel pointed out, the overall test output is pretty bad and
currently does not allow one to easily follow the sequence of GDB
commands used in the test. I took this opportunity to improve the output
and it now prints the sequence in a format that can be copied and pasted
directly into GDB.

The TAP protocol is respected, and Meson correctly displays GDB's test
output in testlog-thorough.txt.

Because the pygdbmi "shim" is so thin, I had to write a trivial GDB
class around it to easily capture and print the payloads returned by its
write() method. The GDB class allows clean, single-line commands to be
used in the tests through method chaining, making them easier to follow,
for example:

pc = gdb.cli("print $pc").get_add()

The test is kept “skipped” for aarch64, ppc64, and x86_64, so it is
necessary to set QEMU_TEST_FLAKY_TESTS=1 in the test environment to
effectively run the test on these archs.

On aarch64, the test is flaky, but there is a fix that I’ve tested while
writing this series [0] that resolves it. On ppc64 and x86_64, the test
always fails: on ppc64, GDB gets a bogus PC, and on x86_64, the last
part of the test (reverse-continue) does not hit the last executed PC
(as it should happen) but instead jumps to the beginning of the code
(first PC in forward order).

Thus, to effectively run the reverse_debugging test on aarch64:

$ export QEMU_TEST_FLAKY_TESTS=1
$ make check-functional

or:
$ make check-functional-aarch64

or even, to run only the reverse_debug test after 'make check-functional':
$ ./pyvenv/bin/meson test --verbose --no-rebuild -t 1 --setup thorough --suite func-thorough func-aarch64-reverse_debug


Cheers,
Gustavo

v1:
https://patchew.org/QEMU/20250819143916.4138035-1-gustavo.romero@linaro.org/

v2:
https://patchew.org/QEMU/20250904154640.52687-1-gustavo.romero@linaro.org/

v3:
https://patchew.org/QEMU/20250922054351.14289-1-gustavo.romero@linaro.org/

v4:
https://patchew.org/QEMU/20250926051542.104432-1-gustavo.romero@linaro.org/

v5:
- Fixed installation of "pygdbmi" in the test env for
  "make check-functional-<ARCH>" (thuth)
- Increased GDB command timeout from 4 to 32 seconds (thuth)
- Reverted use of get_pc() in reverse_debugging.py (thuth)
- Removed $gdb_arches from configure and checked if GDB supports the
  arch to be tested in reverse_debugging.py instead. If the arch is not
  supported by GDB the test is skipped (thuth)
- Corrected grammar in GDB timeout message (thuth)
- Skipped test if "pygdbmi" is not installed in the test environment
  (thuth, danpb)
- Improved error handling in try: block when GDB commands fail, time out,
  or when the test fails, so there is no "double exception"


Daniel P. Berrangé (2):
  tests/functional: replace avocado process with subprocess
  tests/functional: drop datadrainer class in reverse debugging

Gustavo Romero (7):
  tests/functional: Re-activate the check-venv target
  python: Install pygdbmi in meson's venv
  tests/functional: Provide GDB to the functional tests
  tests/functional: Add GDB class
  tests/functional: Add decorator to skip test on missing env vars
  tests/functional: Adapt reverse_debugging to run w/o Avocado
  tests/functional: Adapt arches to reverse_debugging w/o Avocado

 configure                                     |   2 +
 meson_options.txt                             |   2 +
 pythondeps.toml                               |   1 +
 scripts/meson-buildoptions.sh                 |   2 +
 tests/Makefile.include                        |   4 +-
 .../functional/aarch64/test_reverse_debug.py  |  11 +-
 tests/functional/meson.build                  |   6 +
 tests/functional/ppc64/test_reverse_debug.py  |  15 +-
 tests/functional/qemu_test/__init__.py        |   4 +-
 tests/functional/qemu_test/decorators.py      |  18 +++
 tests/functional/qemu_test/gdb.py             |  88 ++++++++++
 tests/functional/reverse_debugging.py         | 151 +++++++++---------
 tests/functional/x86_64/test_reverse_debug.py |  15 +-
 13 files changed, 218 insertions(+), 101 deletions(-)
 create mode 100644 tests/functional/qemu_test/gdb.py

-- 
2.34.1


