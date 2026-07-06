Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E616DC44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrtQ-0002kR-J1; Mon, 06 Jul 2026 18:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrt5-0002fP-09
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrsz-0005L6-KT
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:01 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE8GH1654895
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=8o+yg50Beq187Du2KBhSG7
 K3oyLT/fKkwmvGEmcbPYA=; b=VkW1hvmCfKqoeCmY8M4pX0681rbirC+t+xMnPS
 YeRi7NSnbmcGVW717cmff6hLW1HKGbI7+wHwF6YHGenhE/JFXHDHjEMrFHBUGDp0
 uMo3oaIdJ8Mh1t8uHsowXQqP/sgfHNhSmfFpp1eWFSOTfC3BvFNiO6E4olExH8xw
 DDAWUFeSd68ezvl8DHeI46SVkEQ+tpctwzvXbARKe3RqqIWo6rrhqpNfjGqOTx5W
 7EryvOHyAi28NX8pR5uhtQRcssxIZbt/91GSb96EEY5fDf+pu3xdFzrmPRji9pBN
 Z8G35aLElnXDBESwfvFoHtfBydb+4lTZkEwtEnwyzqdVQm+Q==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89qpk8ee-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:33:55 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c894c1c4aa9so5129359a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377234; x=1783982034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8o+yg50Beq187Du2KBhSG7K3oyLT/fKkwmvGEmcbPYA=;
 b=J0MotN3eV/oR+fskW6AHN1rgJsQYQ+XAoadt9MuiGu8TDmy5xhOaOuM76QrlYC49I2
 1waEqbmVm1p3hKaE0wCfS+pVKovf1L+fh/cEwAFk4WmhpVi94xO/a0QCu1BPypuoFwpK
 VvFkX6LdPunyMz8If+iU+6L+k8yHGZYxgPYUfriBY4ArfEzhq53kUbOUucO+mQs8bnyp
 oKETODR4my+CQ7mzH4H6vMI9MxoPISyb7kMSiwbtVBw+vnEVfr2/1Y+NcZ8CdSU82esE
 OEGYwY7tfheS9mSi5MFa1lBeVMDOF5UGRJ7qhxVUcVT/46nQ0SLbw5xzocVjCLiZUgaF
 ZxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377234; x=1783982034;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8o+yg50Beq187Du2KBhSG7K3oyLT/fKkwmvGEmcbPYA=;
 b=lArvabLOC/WMYwJqZYPDMQZUe59/Er8Rlb63Czx+Hcdzl7WRcMoKO84gLo4M1nYJDv
 2+Qllq0GOav1eB02cFDfZ2rRIyr1+G3lSsIbO+PVYezCRYngqVOnX1Th9EpIU1KEMhnp
 C6edQXnDjRCCzHtWc5jOIGpJU+D6VDwJUOEE1w65wz0PARlye0eY4ruHFdPsDw8HkvAA
 XNZhjxMbqXiY4WhhdkgHcyo5oYiqqiHnYArnN4XdTTpSMEkiMrql3IyZrsRzErX+LD06
 EJB2iinkgpvJgB/JokNkdpkkixUjU4TLP4ZyQcQAUMGnbhLVPSJsVcAeFhRmMM0Qg1Nz
 uhmw==
X-Gm-Message-State: AOJu0YyNGMjzf4ELX6leWPMGaBDMeC7Fm6pI8u2O5GXkkDV4N4mO2s1u
 5DLPPttX8JKtIUaVDifTEpzw04AP54BBxt2K+TpX4XcWREX3KmNsNcNpOvmwlcCoOeBJvEItVGD
 RcvFitdk+SdWGkjIyJJgdoEPsSfTtsFmx88ajHOu0mFQjN9IX7/sAisBjVcYfcmmiXg==
X-Gm-Gg: AfdE7ckZqfzmgE8MYc9+Ck9D/GUa2LKIIRv1db9hYsaNE1HZ9cQFkl9QOBYLTbL5j8Z
 bbcRfLy0J69hlkYWLVNilBQ0qimIVOaFDjlWQU3oyDBrRTRHsJ0j8QLb+7uVSn1eKbRq9OnGGJW
 KWmMQN58045tlBvlAyZZsAnX/imWFV+rTopel15ldM0a3SwYqOJMFw815OAmAPMCxKbhttLsJc2
 HtsnW7EKrP3kgxbLYV+WzFb7+DzzuRzxfNDmNN0zoAGo5MVk+y2AYz/1nWVqQH76G/jpQLfclIh
 RI8DJgIRztYYpezd/3CYKfUbz52a1qoBp6IS/iZKjG1XLLRQ3+e6G6J0whGyVGdQf6i6K3EzrBI
 V0s1GuhY/vg+m+XZXPk759pfUKowgHh8ymn3Ue4xMjHNXUP0lQ4yJjjjnvx/W7D3L5zuyr3q5K4
 urbGJpHg==
X-Received: by 2002:a05:6300:618d:b0:3bf:a698:ce4c with SMTP id
 adf61e73a8af0-3c08f001b9fmr3117023637.58.1783377234143; 
 Mon, 06 Jul 2026 15:33:54 -0700 (PDT)
X-Received: by 2002:a05:6300:618d:b0:3bf:a698:ce4c with SMTP id
 adf61e73a8af0-3c08f001b9fmr3116964637.58.1783377233495; 
 Mon, 06 Jul 2026 15:33:53 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:33:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 00/91] tests/tcg: run tests with meson
Date: Mon,  6 Jul 2026 15:32:12 -0700
Message-ID: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=c6qbhx9l c=1 sm=1 tr=0 ts=6a4c2d53 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=bcjhJ3e7-cdmNuwNZLYA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: atlkbf0WbahE4UDqC4uX11rXAes11PmC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX4J1mdQmw7sic
 6aI2JaUymULEetCo+bG1J1g8IhRIbaUt8WWZ1/CDWELMAkI5B1TYDkAuL/DLeyQoObqGCFrwC8z
 aORNJ0jD8j/2FQPYX/i/zXGA+5EtIv5YUjxqBZUoQhM8VTVlyTfXzrQjnJw9bS9z8k3bcg2mh4+
 +q1giKCeXHpMmlgsqi1BijzxFQC5Z9mTAtmkb2QjavTZwVsn92TXe3uBdCVrzsxqmStdJ9sg+Cf
 npD8bW5JrNhjyPX3NQeH7mtwbBWuONBcBi1L2O3hJy3JpHG4A1mJhokCrX9v0ZusSiEkuSsfp7g
 +va46QFWNIQBzoujOOefz77S1zIZ6cGnEM6gKMN052n0hn2KgvZGWE/WijxAbx6FJs67xQ/vVTL
 TLIpFCCqHPR+5Qoqqf6q3M72kfBR7ltOAFBuG9yCvc2I5GsCMa7KvSciLgy2luppypPd2xgo1Qd
 DKPb53jZYCKLTNSknoA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX4na2J0/TqnUB
 RuV4OiJoDo8y2vkORDh1wi3c5vaQAQdL023JqC6vQrSN9wNZEWurb9kk5dNjTF3DBFPwYXRsVjb
 Nn65bdITj6N1Tgt7+zP/571dlciegW4=
X-Proofpoint-GUID: atlkbf0WbahE4UDqC4uX11rXAes11PmC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060227
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

This series replaces TCG tests makefiles with meson, with the
goal of having something more readable and maintainable in the long term.
Also it closes the gap that tcg tests had with the rest of tests, by integrating
them with meson directly.

It covers all existing tests for all architectures, including
user/system/multiarch-user/multiarch-system. It implements all requirements
listed on original thread [1].

[1] https://lore.kernel.org/qemu-devel/87wlwfsay4.fsf@draig.linaro.org/

We also have for free:
- correct and complete dependencies for any test, including:
  scripts, c.inc, headers, reference files and binaries/plugins.
- catch test declaration issues at configure time vs test time.
- proper data types for variables instead of string expansion with make.

Series first introduce the meson machinery needed in tests/tcg/meson.build, step
by step. Then it adds support for all existing archs. Finally, we remove
Makefiles and configure bits.

Usage:

```
make check-tcg
make check-tcg-aarch64-linux-user
make check-tcg-aarch64-softmmu

make tcg-tests

ninja clean
./pyvenv/bin/meson test aarch64-softmmu-asid2 --verbose
```

A few items were left for further work (out of scope for this series):
- xtensaeb: didn't find how to cross compile for this architecture with what we
  have now in container debian-xtensa-cross. Tips are welcome.
- tricore: implemented but reverted as all tests seem to hang. To be
  investigated.
- riscv64/interruptedmemory.S is hanging. To be investigated.
- i386/test-i386-fprem.c is deactivated for now. It's broken (output does not
  match bare metal result) and is the slowest test we have. To be refactored and
  fixed.

v3
--

- add all architectures
- reduce number of plugins tests (only add one test for each plugin from
  multiarch pool)
- add depends for executable - allow to depend on a custom target for generated
  headers (x86_64 mmx, avx)
- add new tests added since last version for aarch64 (mte + gpc)
- refactor series to keep all arch files at end
- add docker host architecture selection

v2
--

- s/mispell/misspell
- moved comment about why we remove 'lib' prefix for plugins
- if user declare a wrong entry in a dictionary, list possible keys
- build tests by default (with 'all' target), as long as cross compiler is
  natively installed, to avoid triggering a container build.
- reword some comments based on reviewers feedback
- always declare all tests and avoid "per config" errors (no 'if' in arch files)
- move compiler feature and gdb version checks directly in tests/tcg/meson.build
- add support for cross containers
- add top target 'tcg-tests' to rebuild all tests

Pierrick Bouvier (91):
  tests/tcg/multiarch/system/memory.c: remove unused variable
  tests/tcg/multiarch/plugin/check-plugin-output.sh: take test output as
    input
  tests/tcg/multiarch/plugin: rename check-plugin-output to
    regex-compare
  tests/tcg: introduce meson.build
  tests/tcg/meson.build: introduce exe_name
  tests/tcg/meson.build: introduce test_name
  tests/tcg/meson.build: introduce cflags
  tests/tcg/meson.build: introduce qemu_args
  tests/tcg/meson.build: introduce env_var
  tests/tcg/plugins: build list of test_plugins
  tests/tcg/meson.build: introduce plugin_test
  tests/tcg/meson.build: test gdb support and introduce gdb_arch
  tests/tcg/meson.build: introduce gdb_test
  tests/tcg/meson.build: add default flag for testing compiler support
  tests/tcg/meson.build: introduce wrapper
  tests/tcg/meson.build: introduce expected_output
  tests/tcg/meson.build: add wrapper run_and_check_forbidden_output
  tests/tcg/meson.build: add wrapper run_with_input
  tests/tcg/meson.build: add wrapper record_replay
  tests/tcg/meson.build: add wrapper check_plugin_output
  tests/tcg/meson.build: add logic to skip tests
  tests/tcg/meson.build: introduce cc_feat and cc_feat_cflags
  tests/tcg/meson.build: introduce gdb_feat and gdb_feat_version
  tests/tcg/meson.build: move gdb_arch support check
  tests/tcg/meson.build: let test infrastructure detect compiler
  tests/docker/docker.py: return error code if probe fails
  tests/docker/docker.py: remove "Image is up to date" info
  tests/tcg/meson.build: introduce cc_dockerfile and cc_docker_arch
  tests/tcg/meson.build: introduce depends
  tests/tcg/meson.build: add top-level 'tcg-tests' target
  tests/tcg/multiarch: declare user tests
  tests/tcg/multiarch: declare system tests
  tests/tcg/meson.build: add generic plugin tests
  tests/tcg/aarch64: user tests
  tests/tcg/aarch64/system/gpc-test.c: remove unused variables
  tests/tcg/aarch64: system tests
  tests/tcg/aarch64_be: user tests
  tests/tcg/alpha: add float reference files
  tests/tcg/alpha: user tests
  tests/tcg/alpha: system tests
  tests/tcg/arm: user tests
  tests/tcg/arm: system tests
  tests/tcg/hexagon/overflow.c: add missing include
  tests/tcg/hexagon: user tests
  tests/tcg/multiarch/sha1.c: fix big endian implementation
  tests/tcg/hppa: add float reference files
  tests/tcg/hppa: user tests
  tests/tcg/i386: add missing float reference files
  tests/tcg/i386: user tests
  tests/tcg/i386: system tests
  tests/tcg/loongarch64: user tests
  tests/tcg/loongarch64: system tests
  tests/tcg/m68k: add float reference files
  tests/tcg/m68k: user tests
  scripts/probe-gdb-support.py: add mapping for mips architecture
  tests/tcg/mips: add float reference files
  test/tcg/mips: user tests
  tests/tcg/mips64: add float reference files
  tests/tcg/mips64: user tests
  tests/tcg/mips64el: add float reference files
  tests/tcg/mips64el: user tests
  tests/docker/dockerfiles/debian-all-test-cross.docker: add or1k
    toolchain
  tests/tcg/or1k/test_addic.c: remove unused variables
  tests/tcg/or1k/test_muli.c: remove set but unused variable
  tests/tcg/or1k: add float reference files
  plugins/api.c: identify or1k pc register and mark it as read only
  tests/tcg/or1k: user tests
  tests/tcg/ppc64: add float reference files
  tests/tcg/ppc64: remove dependency on qemu/compiler.h
  tests/tcg/ppc64: user tests
  tests/tcg/ppc64le: add missing float reference file
  tests/tcg/ppc64le: user tests
  tests/tcg/riscv64: add float reference files
  tests/tcg/riscv64: user tests
  tests/tcg/riscv64: system tests
  tests/tcg/s390x/head64.S: declare _exit symbol after main
  tests/tcg/s390x: add float reference files
  tests/tcg/s390x: user tests
  tests/tcg/s390x: system tests
  tests/tcg/sh4: add float reference files
  tests/tcg/sh4: user tests
  tests/tcg/tricore: system tests
  Revert "tests/tcg/tricore: system tests"
  tests/tcg/x86_64: add missing float reference file
  tests/tcg/x86_64: user tests
  tests/tcg/x86_64: system tests
  tests/tcg/xtensa/crt.S: align .text section
  tests/tcg/xtensa: system tests
  tests: remove tcg tests machinery
  tests/tcg: remove Makefiles
  configure: remove --cross-cc* options

 configure                                     | 473 ---------
 docs/devel/testing/main.rst                   |  22 +-
 plugins/api.c                                 |   2 +
 scripts/probe-gdb-support.py                  |   1 +
 tests/Makefile.include                        |  68 +-
 tests/docker/docker.py                        |   4 +-
 .../dockerfiles/debian-all-test-cross.docker  |  16 +-
 tests/lcitool/refresh                         | 107 +-
 tests/meson.build                             |   2 +-
 tests/tcg/Makefile.target                     | 281 -----
 tests/tcg/aarch64/Makefile.softmmu-target     | 147 ---
 tests/tcg/aarch64/Makefile.target             | 198 ----
 tests/tcg/aarch64/meson.build                 | 195 ++++
 tests/tcg/aarch64/system/gpc-test.c           |   5 -
 tests/tcg/aarch64/system/meson.build          | 108 ++
 tests/tcg/aarch64_be/Makefile.target          |  17 -
 tests/tcg/aarch64_be/meson.build              |  22 +
 tests/tcg/alpha/Makefile.softmmu-target       |  34 -
 tests/tcg/alpha/Makefile.target               |  18 -
 tests/tcg/alpha/float_convd.ref               | 988 ++++++++++++++++++
 tests/tcg/alpha/float_convs.ref               | 748 +++++++++++++
 tests/tcg/alpha/float_madds.ref               | 768 ++++++++++++++
 tests/tcg/alpha/meson.build                   |  55 +
 tests/tcg/alpha/system/meson.build            |  46 +
 tests/tcg/arm/Makefile.softmmu-target         |  80 --
 tests/tcg/arm/Makefile.target                 |  87 --
 tests/tcg/arm/meson.build                     |  80 ++
 tests/tcg/arm/system/meson.build              |  66 ++
 tests/tcg/hexagon/Makefile.target             | 146 ---
 tests/tcg/hexagon/meson.build                 | 111 ++
 tests/tcg/hexagon/overflow.c                  |   1 +
 tests/tcg/hppa/Makefile.target                |  14 -
 tests/tcg/hppa/float_convd.ref                | 988 ++++++++++++++++++
 tests/tcg/hppa/float_convs.ref                | 748 +++++++++++++
 tests/tcg/hppa/float_madds.ref                | 768 ++++++++++++++
 tests/tcg/hppa/meson.build                    |  22 +
 tests/tcg/i386/Makefile.softmmu-target        |  37 -
 tests/tcg/i386/Makefile.target                | 102 --
 tests/tcg/i386/float_convd.conf               | 988 ------------------
 tests/tcg/i386/float_convd.ref                | 988 ++++++++++++++++++
 tests/tcg/i386/float_madds.ref                | 768 ++++++++++++++
 tests/tcg/i386/meson.build                    |  58 +
 tests/tcg/i386/system/meson.build             |  48 +
 tests/tcg/loongarch64/Makefile.softmmu-target |  33 -
 tests/tcg/loongarch64/Makefile.target         |  20 -
 tests/tcg/loongarch64/meson.build             |  32 +
 tests/tcg/loongarch64/system/meson.build      |  47 +
 tests/tcg/m68k/Makefile.target                |   7 -
 tests/tcg/m68k/float_convd.ref                | 988 ++++++++++++++++++
 tests/tcg/m68k/float_convs.ref                | 748 +++++++++++++
 tests/tcg/m68k/float_madds.ref                | 768 ++++++++++++++
 tests/tcg/m68k/meson.build                    |  23 +
 tests/tcg/meson.build                         | 447 ++++++++
 tests/tcg/minilib/Makefile.target             |  21 -
 tests/tcg/mips/Makefile.target                |  19 -
 tests/tcg/mips/float_convd.ref                | 988 ++++++++++++++++++
 tests/tcg/mips/float_convs.ref                | 748 +++++++++++++
 tests/tcg/mips/float_madds.ref                | 768 ++++++++++++++
 tests/tcg/mips/meson.build                    |  25 +
 tests/tcg/mips/user/ase/dsp/Makefile          | 184 ----
 tests/tcg/mips/user/isa/mips64r6/crc/Makefile |  40 -
 tests/tcg/mips/user/isa/r5900/Makefile        |  32 -
 tests/tcg/mips64/Makefile.target              |  20 -
 tests/tcg/mips64/float_convd.ref              | 988 ++++++++++++++++++
 tests/tcg/mips64/float_convs.ref              | 748 +++++++++++++
 tests/tcg/mips64/float_madds.ref              | 768 ++++++++++++++
 tests/tcg/mips64/meson.build                  |  27 +
 tests/tcg/mips64el/Makefile.target            |   8 -
 tests/tcg/mips64el/float_convd.ref            | 988 ++++++++++++++++++
 tests/tcg/mips64el/float_convs.ref            | 748 +++++++++++++
 tests/tcg/mips64el/float_madds.ref            | 768 ++++++++++++++
 tests/tcg/mips64el/meson.build                |  14 +
 tests/tcg/multiarch/Makefile.target           | 233 -----
 tests/tcg/multiarch/meson.build               | 149 +++
 .../multiarch/plugin/check-plugin-output.sh   |  36 -
 tests/tcg/multiarch/plugin/regex-compare.sh   |  28 +
 tests/tcg/multiarch/sha1.c                    |   4 +-
 tests/tcg/multiarch/sha1.ref                  |   1 +
 .../multiarch/system/Makefile.softmmu-target  |  81 --
 tests/tcg/multiarch/system/memory.c           |   3 +-
 tests/tcg/multiarch/system/meson.build        |  53 +
 tests/tcg/or1k/Makefile                       |  71 --
 tests/tcg/or1k/float_convd.ref                | 247 +++++
 tests/tcg/or1k/float_convs.ref                | 187 ++++
 tests/tcg/or1k/float_madds.ref                | 192 ++++
 tests/tcg/or1k/meson.build                    |  72 ++
 tests/tcg/or1k/test_addic.c                   |   2 +-
 tests/tcg/or1k/test_muli.c                    |   5 +-
 tests/tcg/plugins/meson.build                 |  11 +-
 tests/tcg/ppc64/Makefile.target               |  63 --
 tests/tcg/ppc64/float_convd.ref               | 988 ++++++++++++++++++
 tests/tcg/ppc64/float_convs.ref               | 748 +++++++++++++
 tests/tcg/ppc64/float_madds.ref               | 768 ++++++++++++++
 tests/tcg/ppc64/meson.build                   |  56 +
 tests/tcg/ppc64/vector.c                      |  11 +-
 tests/tcg/ppc64/vsx_f2i_nan.c                 |   7 +-
 tests/tcg/ppc64le/Makefile.target             |   7 -
 tests/tcg/ppc64le/float_convd.ref             | 988 ++++++++++++++++++
 tests/tcg/ppc64le/meson.build                 |  14 +
 tests/tcg/riscv64/Makefile.softmmu-target     |  45 -
 tests/tcg/riscv64/Makefile.target             |  20 -
 tests/tcg/riscv64/float_convd.ref             | 988 ++++++++++++++++++
 tests/tcg/riscv64/float_convs.ref             | 748 +++++++++++++
 tests/tcg/riscv64/float_madds.ref             | 768 ++++++++++++++
 tests/tcg/riscv64/meson.build                 |  38 +
 tests/tcg/riscv64/system/meson.build          |  38 +
 tests/tcg/s390x/Makefile.softmmu-target       |  57 -
 tests/tcg/s390x/Makefile.target               | 127 ---
 tests/tcg/s390x/float_convd.ref               | 988 ++++++++++++++++++
 tests/tcg/s390x/float_convs.ref               | 748 +++++++++++++
 tests/tcg/s390x/float_madds.ref               | 768 ++++++++++++++
 tests/tcg/s390x/head64.S                      |   2 +
 tests/tcg/s390x/meson.build                   | 140 +++
 tests/tcg/s390x/system/meson.build            |  92 ++
 tests/tcg/scripts/check_plugin_output.sh      |  25 +
 tests/tcg/scripts/record_replay.sh            |  16 +
 .../scripts/run_and_check_forbidden_output.sh |  19 +
 tests/tcg/scripts/run_and_diff.sh             |  15 +
 tests/tcg/scripts/run_with_input.sh           |  12 +
 tests/tcg/sh4/Makefile.target                 |  18 -
 tests/tcg/sh4/float_convd.ref                 | 494 +++++++++
 tests/tcg/sh4/float_convs.ref                 | 374 +++++++
 tests/tcg/sh4/float_madds.ref                 | 384 +++++++
 tests/tcg/sh4/meson.build                     |  25 +
 tests/tcg/tricore/Makefile.softmmu-target     |  53 -
 tests/tcg/x86_64/Makefile.softmmu-target      |  44 -
 tests/tcg/x86_64/Makefile.target              |  40 -
 tests/tcg/x86_64/float_madds.ref              | 768 ++++++++++++++
 tests/tcg/x86_64/meson.build                  |  83 ++
 tests/tcg/x86_64/system/meson.build           |  62 ++
 tests/tcg/xtensa/Makefile.softmmu-target      |  46 -
 tests/tcg/xtensa/crt.S                        |   1 +
 tests/tcg/xtensa/meson.build                  |  89 ++
 tests/tcg/xtensaeb/Makefile.softmmu-target    |   5 -
 134 files changed, 30491 insertions(+), 4114 deletions(-)
 delete mode 100644 tests/tcg/Makefile.target
 delete mode 100644 tests/tcg/aarch64/Makefile.softmmu-target
 delete mode 100644 tests/tcg/aarch64/Makefile.target
 create mode 100644 tests/tcg/aarch64/meson.build
 create mode 100644 tests/tcg/aarch64/system/meson.build
 delete mode 100644 tests/tcg/aarch64_be/Makefile.target
 create mode 100644 tests/tcg/aarch64_be/meson.build
 delete mode 100644 tests/tcg/alpha/Makefile.softmmu-target
 delete mode 100644 tests/tcg/alpha/Makefile.target
 create mode 100644 tests/tcg/alpha/float_convd.ref
 create mode 100644 tests/tcg/alpha/float_convs.ref
 create mode 100644 tests/tcg/alpha/float_madds.ref
 create mode 100644 tests/tcg/alpha/meson.build
 create mode 100644 tests/tcg/alpha/system/meson.build
 delete mode 100644 tests/tcg/arm/Makefile.softmmu-target
 delete mode 100644 tests/tcg/arm/Makefile.target
 create mode 100644 tests/tcg/arm/meson.build
 create mode 100644 tests/tcg/arm/system/meson.build
 delete mode 100644 tests/tcg/hexagon/Makefile.target
 create mode 100644 tests/tcg/hexagon/meson.build
 delete mode 100644 tests/tcg/hppa/Makefile.target
 create mode 100644 tests/tcg/hppa/float_convd.ref
 create mode 100644 tests/tcg/hppa/float_convs.ref
 create mode 100644 tests/tcg/hppa/float_madds.ref
 create mode 100644 tests/tcg/hppa/meson.build
 delete mode 100644 tests/tcg/i386/Makefile.softmmu-target
 delete mode 100644 tests/tcg/i386/Makefile.target
 delete mode 100644 tests/tcg/i386/float_convd.conf
 create mode 100644 tests/tcg/i386/float_convd.ref
 create mode 100644 tests/tcg/i386/float_madds.ref
 create mode 100644 tests/tcg/i386/meson.build
 create mode 100644 tests/tcg/i386/system/meson.build
 delete mode 100644 tests/tcg/loongarch64/Makefile.softmmu-target
 delete mode 100644 tests/tcg/loongarch64/Makefile.target
 create mode 100644 tests/tcg/loongarch64/meson.build
 create mode 100644 tests/tcg/loongarch64/system/meson.build
 delete mode 100644 tests/tcg/m68k/Makefile.target
 create mode 100644 tests/tcg/m68k/float_convd.ref
 create mode 100644 tests/tcg/m68k/float_convs.ref
 create mode 100644 tests/tcg/m68k/float_madds.ref
 create mode 100644 tests/tcg/m68k/meson.build
 create mode 100644 tests/tcg/meson.build
 delete mode 100644 tests/tcg/minilib/Makefile.target
 delete mode 100644 tests/tcg/mips/Makefile.target
 create mode 100644 tests/tcg/mips/float_convd.ref
 create mode 100644 tests/tcg/mips/float_convs.ref
 create mode 100644 tests/tcg/mips/float_madds.ref
 create mode 100644 tests/tcg/mips/meson.build
 delete mode 100644 tests/tcg/mips/user/ase/dsp/Makefile
 delete mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/Makefile
 delete mode 100644 tests/tcg/mips/user/isa/r5900/Makefile
 delete mode 100644 tests/tcg/mips64/Makefile.target
 create mode 100644 tests/tcg/mips64/float_convd.ref
 create mode 100644 tests/tcg/mips64/float_convs.ref
 create mode 100644 tests/tcg/mips64/float_madds.ref
 create mode 100644 tests/tcg/mips64/meson.build
 delete mode 100644 tests/tcg/mips64el/Makefile.target
 create mode 100644 tests/tcg/mips64el/float_convd.ref
 create mode 100644 tests/tcg/mips64el/float_convs.ref
 create mode 100644 tests/tcg/mips64el/float_madds.ref
 create mode 100644 tests/tcg/mips64el/meson.build
 delete mode 100644 tests/tcg/multiarch/Makefile.target
 create mode 100644 tests/tcg/multiarch/meson.build
 delete mode 100755 tests/tcg/multiarch/plugin/check-plugin-output.sh
 create mode 100755 tests/tcg/multiarch/plugin/regex-compare.sh
 create mode 100644 tests/tcg/multiarch/sha1.ref
 delete mode 100644 tests/tcg/multiarch/system/Makefile.softmmu-target
 create mode 100644 tests/tcg/multiarch/system/meson.build
 delete mode 100644 tests/tcg/or1k/Makefile
 create mode 100644 tests/tcg/or1k/float_convd.ref
 create mode 100644 tests/tcg/or1k/float_convs.ref
 create mode 100644 tests/tcg/or1k/float_madds.ref
 create mode 100644 tests/tcg/or1k/meson.build
 delete mode 100644 tests/tcg/ppc64/Makefile.target
 create mode 100644 tests/tcg/ppc64/float_convd.ref
 create mode 100644 tests/tcg/ppc64/float_convs.ref
 create mode 100644 tests/tcg/ppc64/float_madds.ref
 create mode 100644 tests/tcg/ppc64/meson.build
 delete mode 100644 tests/tcg/ppc64le/Makefile.target
 create mode 100644 tests/tcg/ppc64le/float_convd.ref
 create mode 100644 tests/tcg/ppc64le/meson.build
 delete mode 100644 tests/tcg/riscv64/Makefile.softmmu-target
 delete mode 100644 tests/tcg/riscv64/Makefile.target
 create mode 100644 tests/tcg/riscv64/float_convd.ref
 create mode 100644 tests/tcg/riscv64/float_convs.ref
 create mode 100644 tests/tcg/riscv64/float_madds.ref
 create mode 100644 tests/tcg/riscv64/meson.build
 create mode 100644 tests/tcg/riscv64/system/meson.build
 delete mode 100644 tests/tcg/s390x/Makefile.softmmu-target
 delete mode 100644 tests/tcg/s390x/Makefile.target
 create mode 100644 tests/tcg/s390x/float_convd.ref
 create mode 100644 tests/tcg/s390x/float_convs.ref
 create mode 100644 tests/tcg/s390x/float_madds.ref
 create mode 100644 tests/tcg/s390x/meson.build
 create mode 100644 tests/tcg/s390x/system/meson.build
 create mode 100755 tests/tcg/scripts/check_plugin_output.sh
 create mode 100755 tests/tcg/scripts/record_replay.sh
 create mode 100755 tests/tcg/scripts/run_and_check_forbidden_output.sh
 create mode 100755 tests/tcg/scripts/run_and_diff.sh
 create mode 100755 tests/tcg/scripts/run_with_input.sh
 delete mode 100644 tests/tcg/sh4/Makefile.target
 create mode 100644 tests/tcg/sh4/float_convd.ref
 create mode 100644 tests/tcg/sh4/float_convs.ref
 create mode 100644 tests/tcg/sh4/float_madds.ref
 create mode 100644 tests/tcg/sh4/meson.build
 delete mode 100644 tests/tcg/tricore/Makefile.softmmu-target
 delete mode 100644 tests/tcg/x86_64/Makefile.softmmu-target
 delete mode 100644 tests/tcg/x86_64/Makefile.target
 create mode 100644 tests/tcg/x86_64/float_madds.ref
 create mode 100644 tests/tcg/x86_64/meson.build
 create mode 100644 tests/tcg/x86_64/system/meson.build
 delete mode 100644 tests/tcg/xtensa/Makefile.softmmu-target
 create mode 100644 tests/tcg/xtensa/meson.build
 delete mode 100644 tests/tcg/xtensaeb/Makefile.softmmu-target

-- 
2.47.3


