Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAF9C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4bF-00010b-IH; Fri, 10 Jul 2026 02:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4b9-0000sK-AN
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:20:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4b4-0004P4-W2
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:20:30 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nDbn3752767
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=UlGsSEvi1EGQV3q6XUqbC9
 BwlyG0eLN6j7prlwTM7S0=; b=cq3gbxU8iTwwXLKzdbW1cY7ZOV5P8Dtp6qfLkd
 hTTBs3WZSSPGcnK+7riBqVoHCA0DNohW6y/ZbwOHdAK5FaalrcO9RtxX08UeWHGy
 /0KtYPUTUCrnq4wkA6A4km3QvsfMiF/h0mWGnrJMQKh/y3bhUB5GPB3YjsC4jJ5T
 MXPCEXwAc02Rhex00pe0I3nbnm8iUbX3DIjecpjqKp/cVuh4sJQFMon3iWLRp5WH
 RVYHIZq4R+aB3rpTgnGWyyoW5cDWkZEFvNOypJCF5Ij3CNy4EOM3uXjJDFZwjsHz
 wtxrnIYfiV/8ufSV7hhzPf5SWhLNgBqXvA7xV8tOjXVj6jjg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fadvjb9h1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:20:25 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cacd6d37edso7889705ad.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664424; x=1784269224; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UlGsSEvi1EGQV3q6XUqbC9BwlyG0eLN6j7prlwTM7S0=;
 b=Kxj4KygNe8suuc9JiIdZxy7ZYPmh//FcOPmFm7FpSsrqjIil1a3mId4bIeDAEBzxkt
 e+xsQcmAMmC6PMtT5hSszxU1C4hFkDlK5+2qqueRqQ152I5luseeIrQ/9Yr7ox/0v0RL
 4YmUnyp7LlzmqsAt8/pW6Ps6W7yncSiRz84uNkvVqwt4Xjf+9vVcHLceS9LTcG3UR4HE
 WAZpZMT8zecDYzK3QOtLt0IJYH2ca4THDb/cRnn82M44PyZ0ZJowwzWNErmt/2cKUJUc
 KwuinyuR90v7WrCpDcrXo8Se7tdZCU4Dcpoeey5yP0cdpn9O7Is4xMcUVavdEy6KoYPh
 zCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664424; x=1784269224;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UlGsSEvi1EGQV3q6XUqbC9BwlyG0eLN6j7prlwTM7S0=;
 b=je8sTznKDijake5Mn6MRab5p38vBfJFShHDoIxiZ8g+ngYMevTQ0ToR/QJT/riqDWY
 IM1XkgZ5iMgEG+Y1KqV1ijGFkq3fNZT2eKqjNeJJCqDiLuP5KNrFUaNRQK7NVFludCkY
 aAtwaDzd1knv1HsJYtrPCP9nt3R262MnbjqxiSbuRrrMXyaeLuLHJYNqDyEllnzwa33U
 3UEJNmtLwEA8qfQdpgzQRlApXYsbM+HUYQsz33cht6957lGWF4FmuVkcsB7uW2V8k/Vq
 YGR8L4K9vkvTdVRiaWsrpgCqE+awJ4iGqhNvHXwy8sJZHKseSbdB3CsAlwXzifdhzwwV
 8XZw==
X-Gm-Message-State: AOJu0YzMRepSop71UydJpHkl5m6vAy0qbw8r2B1lSIfGH9RC9cQU0eTo
 N+flNqt1x11UdhAxTLfCHMGXnYDWcxkCpaTrDAtHZSD7LPmW5AQh1yON8YA792igkt9mqFZZuVD
 iWVQ3jaYJ+B1BFVy24l2hQCtWyMM04RXWSrYWC4tCh9o5fBux0rMnuCwiLPqZpmoCzw==
X-Gm-Gg: AfdE7clS5l7EMJMV5oFpxVUdmsGLUjJMjRH28zZXOiw0rXdpyIhpDZdASsI9NvxBKNF
 dXvb/AA9KZFnmuoq9lK2Qb6zRiJYEV+5Dao8lvSSeNtRFkgG/BSnRRoRu8nTlRAHhopXk90gnXk
 admZIaqobwpBmtEnkQPxX850pOKqLC5muANVp50c/XkQMAv7uWfS137uEkjFU12sJFq8ArsS3l6
 7yKjSJIamd4yKofQ1hWXOAoVJge37SabCduW7rqQRWq2z5W3mwOZnfUTPd4vlihvDKeRNEF1M0Y
 eb3Y+H7jlUH7TI2GRJZEcIQIh+X2lV3W++q6ly3EsmekE0irvz5mmZzsJQMe/WWJ5jv5DRNYFOY
 p0y3H9MksdX0Jnf8iF+G12D/4z+rOjBeELkLCx1ak2YCegsLI/Xq7/yq9/IBVu+e85lxpkZwqeJ
 WdOwWYEQ==
X-Received: by 2002:a05:6a20:6f8d:b0:3bf:6222:2e7e with SMTP id
 adf61e73a8af0-3c0bcf4923emr13094562637.4.1783664423858; 
 Thu, 09 Jul 2026 23:20:23 -0700 (PDT)
X-Received: by 2002:a05:6a20:6f8d:b0:3bf:6222:2e7e with SMTP id
 adf61e73a8af0-3c0bcf4923emr13094503637.4.1783664423125; 
 Thu, 09 Jul 2026 23:20:23 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.20.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:20:22 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 00/97] tests/tcg: run tests with meson
Date: Thu,  9 Jul 2026 23:18:38 -0700
Message-ID: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX7uIL2lL+gss4
 Vfn1XGKIy1JFDhj3FfZDRWf7OxU/GlzGQGsxkWSDbhn47Q+N1zvmNbuKdmx8x5INjMu7F/jefcm
 rC+kyiO0F2OXO7DDaCQ2qDnC4W5rb2osCZvrdz7V7njSWrW5QyK3BRraoJw5xTuJsvSY+8ZG1LJ
 qiAswJkDHOY9ojMm8O09Ido3y/pO2hKRXo6b8SLPf64yi2Qc+jN14G5v+mKvGLtA+vZTa+DhiHh
 DbCqX9QpMz8uCD/aBgh6cLH/a648r6bJv6wdtrYEHB7O7Ja1403f6R8t93ljfA9t0E82o5fOEuM
 AbalToZUzyR7eGhbh6V3Rvyb3J9kQHFrYdmSDg+6wA6F90w/lsEA9jP6XJliGNbQ4Ll9df6VPnB
 yNpDGOjvuUlsGIsN5f2fogazzaJxbf8GhcdEtZEvjKSr2/cNjTLMPVnuiYiGai6DbrqI9TviXbb
 tGFdARWviC62m5sDe6g==
X-Authority-Analysis: v=2.4 cv=WpIb99fv c=1 sm=1 tr=0 ts=6a508f29 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=mUXnL0deTPNMi5eDGMMA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: KsqMCTRF4n9o0lPzlk9h3Sndr9BUj_7p
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfXxQ2lD0u3jJiw
 Fd0vYCu5OYsYN7ZBJuVpliohZU8Oyi35xVrxQ4n6FstY3+1Wc4036oRsdkSJKYjFF8knkD+UEO4
 uh4PIMK8z5fnLhJqBjwvw1MQrsgJ5Ck=
X-Proofpoint-ORIG-GUID: KsqMCTRF4n9o0lPzlk9h3Sndr9BUj_7p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100058
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
Makefiles and configure bits, and add documentation.

Usage:

```
make check-tcg
make check-tcg-aarch64-linux-user
make check-tcg-aarch64-softmmu
make tcg-tests

ninja tcg-tests
ninja clean
./pyvenv/bin/meson test aarch64-softmmu-asid2 --verbose
```

v4
--

- rebase on top of master (Makefiles + Dockerfile changes)
- full CI pass on GitLab
- update documentation for tcg-tests
- check host cross cc is working (handle fedora cross compiler without runtime or
  headers)
- rename cc_docker_arch to cc_docker_host_arch
- add test added since v3: aarch64/fprcvt
- enable tricore system tests (was missing -kernel parameter)
- add xtensaeb system tests
- remove dependency from s390x/console.c to roms/SLOF submodule, which allows to
  compile those tests without requiring the submodule.
- fix meson warnings (min version for test with external program in args +
  s/source_root/project_source_root/)
- skip failing test gdb-prot-none on GitLab CI

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

Pierrick Bouvier (97):
  tests/tcg/multiarch/system/memory.c: remove unused variable
  tests/tcg/multiarch/plugin/check-plugin-output.sh: take test output as
    input
  tests/tcg/multiarch/plugin: rename check-plugin-output to
    regex-compare
  meson: bump minimal version to 1.6.0
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
  tests/tcg/meson.build: introduce cc_dockerfile and cc_docker_host_arch
  tests/tcg/meson.build: check host cross cc is working
  tests/tcg/meson.build: introduce depends
  tests/tcg/meson.build: add top-level 'tcg-tests' target
  tests/tcg/multiarch/gdbstub/prot-none.py: deactivate on gitlab CI
  tests/tcg/multiarch: declare user tests
  tests/tcg/multiarch: declare system tests
  tests/tcg/meson.build: add generic plugin tests
  tests/tcg/arm/fcvt.c: use raw opcode for FPRCVT
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
  tests/tcg/s390x/console.c: directly implement memcpy and memset
  tests/tcg/s390x: system tests
  tests/tcg/sh4: add float reference files
  tests/tcg/sh4: user tests
  tests/tcg/tricore: system tests
  tests/tcg/x86_64: add missing float reference file
  tests/tcg/x86_64: user tests
  tests/tcg/x86_64: system tests
  tests/tcg/xtensa/crt.S: align .text section
  tests/docker/dockerfiles/debian-xtensa-cross.docker: add test_kc705_be
    toolchain for xtensaeb
  tests/tcg/xtensa: system tests
  tests/tcg/xtensa: xtensaeb system tests
  tests: remove tcg tests machinery
  tests/tcg: remove Makefiles
  configure: remove --cross-cc* options
  docs/devel/testing/: update documentation

 configure                                     | 473 ---------
 docs/devel/build-system.rst                   |   4 +-
 docs/devel/testing/main.rst                   |  55 +-
 meson.build                                   |   4 +-
 plugins/api.c                                 |   2 +
 pythondeps.toml                               |   2 +-
 scripts/probe-gdb-support.py                  |   1 +
 .../packagefiles/anyhow-1-rs/meson.build      |   2 +-
 .../arbitrary-int-1-rs/meson.build            |   2 +-
 .../packagefiles/attrs-0.2-rs/meson.build     |   2 +-
 .../packagefiles/bilge-0.2-rs/meson.build     |   2 +-
 .../bilge-impl-0.2-rs/meson.build             |   2 +-
 .../packagefiles/either-1-rs/meson.build      |   2 +-
 .../packagefiles/foreign-0.3-rs/meson.build   |   2 +-
 .../packagefiles/glib-sys-0.21-rs/meson.build |   2 +-
 .../itertools-0.11-rs/meson.build             |   2 +-
 .../packagefiles/libc-0.2-rs/meson.build      |   2 +-
 .../packagefiles/probe-0.5-rs/meson.build     |   2 +-
 .../proc-macro-error-1-rs/meson.build         |   2 +-
 .../proc-macro-error-attr-1-rs/meson.build    |   2 +-
 .../packagefiles/proc-macro2-1-rs/meson.build |   2 +-
 .../packagefiles/quote-1-rs/meson.build       |   2 +-
 subprojects/packagefiles/syn-2-rs/meson.build |   2 +-
 .../unicode-ident-1-rs/meson.build            |   2 +-
 tests/Makefile.include                        |  68 +-
 tests/docker/docker.py                        |   4 +-
 .../dockerfiles/debian-all-test-cross.docker  |  14 +-
 .../dockerfiles/debian-xtensa-cross.docker    |   4 +-
 tests/lcitool/refresh                         |  14 +-
 tests/meson.build                             |   2 +-
 tests/tcg/Makefile.target                     | 281 -----
 tests/tcg/aarch64/Makefile.softmmu-target     | 147 ---
 tests/tcg/aarch64/Makefile.target             | 210 ----
 tests/tcg/aarch64/meson.build                 | 207 ++++
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
 tests/tcg/arm/fcvt.c                          |   6 +-
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
 tests/tcg/meson.build                         | 461 ++++++++
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
 tests/tcg/multiarch/Makefile.target           | 224 ----
 tests/tcg/multiarch/gdbstub/prot-none.py      |  11 +-
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
 tests/tcg/s390x/console.c                     |  30 +-
 tests/tcg/s390x/float_convd.ref               | 988 ++++++++++++++++++
 tests/tcg/s390x/float_convs.ref               | 748 +++++++++++++
 tests/tcg/s390x/float_madds.ref               | 768 ++++++++++++++
 tests/tcg/s390x/head64.S                      |   2 +
 tests/tcg/s390x/meson.build                   | 140 +++
 tests/tcg/s390x/system/meson.build            |  90 ++
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
 tests/tcg/test_cc.c                           |   7 +
 tests/tcg/tricore/Makefile.softmmu-target     |  53 -
 tests/tcg/tricore/meson.build                 |  57 +
 tests/tcg/x86_64/Makefile.softmmu-target      |  44 -
 tests/tcg/x86_64/Makefile.target              |  40 -
 tests/tcg/x86_64/float_madds.ref              | 768 ++++++++++++++
 tests/tcg/x86_64/meson.build                  |  83 ++
 tests/tcg/x86_64/system/meson.build           |  62 ++
 tests/tcg/xtensa/Makefile.softmmu-target      |  46 -
 tests/tcg/xtensa/crt.S                        |   1 +
 tests/tcg/xtensa/meson.build                  | 110 ++
 tests/tcg/xtensaeb/Makefile.softmmu-target    |   5 -
 160 files changed, 30639 insertions(+), 4111 deletions(-)
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
 create mode 100644 tests/tcg/test_cc.c
 delete mode 100644 tests/tcg/tricore/Makefile.softmmu-target
 create mode 100644 tests/tcg/tricore/meson.build
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


