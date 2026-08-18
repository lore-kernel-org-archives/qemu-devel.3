Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9821C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPPD-0006ZA-P1; Tue, 18 Aug 2026 15:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPP9-0006XM-VD
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPP6-0006Vn-Gw
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:23 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHH3Cn1943387
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ff0oXtu+CvEPWcqzAPzOcj
 w5RIURr49TrLj84Bvf5mg=; b=Xm5qwaqZpT65ebrW8EMcsuGzV4jRDCF4NWk4bL
 0whJ/NH4ks2+1jOeZLPvUQQWwz5WA6jLmYxuHbGhMXP+3xC7rTbUYtVZwnMqXDef
 3krYjY38hCPmAadwKPCMLz1FZYRQZsGpg2RmxdfRYI0btQc+ggsix/XTpeGRM9Is
 9N07xHqZJQQ0DfI6/iTDrHMptUkOmD1PhIpXrc4/wA7ZQS2V3HhS3mXdnKLWI+MG
 v/tA+fDzmQHZcWFp0qGDZ1wr3oPtFvkaj71UIfQ7oga9xjxK0shuRF+61XYtStai
 kh2lA4AC4VHeNBMO9ulnjtYQ5d9M8QGX3jK7L+V+1tUZXXWw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4prn268p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:17 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cb6cf425e86so166119a12.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787080996; x=1787685796; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ff0oXtu+CvEPWcqzAPzOcjw5RIURr49TrLj84Bvf5mg=;
 b=THauKS5BrLOtMviIHxnRGZPEPJ6hdsR3ulCbU4+z0q0MKBr6s3RfizPO6Zbs3RNZHk
 6sKckmhPSG+s3wCAnhg0bLR3wXCP0iFmJGTdbYgbEvkR1jiefpfuZH/pkmEPptjfIeJS
 K2vIu+nkc8IiAyQmNvysBjT9y1/3l31pEKsbzextgTujpYhKDi6g+k9CU0x4k2+SxMiq
 XwrMa4VQlt9KmmxPBttBL+jRQqv4wzsVzM9xiE4NlDtuLDqaco4gPytRzsVBr5JCCGIK
 ok07dqy+dxHvmjQboMxDd1vCMrgT0XGChWc2XvXU6tSR6sD/hIAc8EfwYma0BjiBWW2I
 jNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787080996; x=1787685796;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ff0oXtu+CvEPWcqzAPzOcjw5RIURr49TrLj84Bvf5mg=;
 b=RLfePFRHm3MeATotqiHDU60yBaWhSP5LBa0sUJpBAeHWOs+REY3kAEAknmW1MZe+MF
 haQCYumTahGEQzLMotaYSEJp4uVfu1ov73vrQBsqbYKMwVfLgy0u7HBkH8dmM2vB2V4F
 zS+zuFB3DT9LrmrE01AZSNxbR3xy+/1wbfiueIIk/0lQxPFjgjjl1fupHnjNTGBLFrc0
 24fEY7mwv4p2vpC9sYqqgsjU9PPvjO8h8HkGsy0/osXuJEgFegL+vifQkdjRBNtYhWpI
 6UdRhcjkCgkmd0yiRv38b4han6HN2IEBMs310xBM+2E+A/+qAz3rrZAwbh1loCfGPp2Q
 iJiA==
X-Gm-Message-State: AOJu0YxcdRl2FbnSQwCMRqu0kkSHDZCc9R36kKIQTzrKgQNIvvqX9YsK
 k6XtDly3ZwhZr2b2GZ3+LPD5/hKLhoRjXSj5KAheTqSFU9jFfDfpd3Kl/EBknXa0VHP9G9CXTMj
 Un7eUI7TN/TN6Zbjb7gK5kJXyq/hdqoyuEMAnLj3/FneBmmh/6/rexv5PtZ2TxK2jNg==
X-Gm-Gg: AR+sD10LJBKFB3ypFwiFaI493p9xpnjwxg2sC68uywrfMWJ2+qIqbQECMsa0fYTi1JV
 1xq3fvjfVWHguKh4xQGL+OdRR3Mf0gbU41DHkdVAXtq9jiTPQap8/5Y6Z7gx6s8NXFJmc+VVT3s
 ZnCwieGOBkvBlIbXhdm2bOEpkMjBKTob0pO3/Sl7vVz0y9bSCXKPyH7ubN/3hB/ewBbn8bJXR/P
 0fYQpCID798Wrt8zC/Jo6g/bD1t3Jj5x3ZWHu0Rg2L0FMOQzJwCnwZgHMemQLCMfddH2n71ABbc
 rRgf152wzSEKD9gXgCCeECG/UKlV7MvKsgbN4/mO3yMBn9gZzySHISpGBdVzgx1bwTxBaCBH+Pk
 TMWqGQu3o0w+lAVRzXjQQnyAn/a4Xd4z2B0EgWz2R9LEytXiftnhfC3KwxNQ=
X-Received: by 2002:a17:90b:5107:b0:381:1c96:829b with SMTP id
 98e67ed59e1d1-3957b0fd561mr164490a91.3.1787080996199; 
 Tue, 18 Aug 2026 12:23:16 -0700 (PDT)
X-Received: by 2002:a17:90b:5107:b0:381:1c96:829b with SMTP id
 98e67ed59e1d1-3957b0fd561mr164387a91.3.1787080995568; 
 Tue, 18 Aug 2026 12:23:15 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:23:15 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v7 000/104] tests/tcg: run tests with meson
Date: Tue, 18 Aug 2026 19:21:24 +0000
Message-ID: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX7RhcOBLHd/Xc
 Gc9dJscLG1rQSeHcPAMf9VlpVJUEzacGGWAr6xNfoW9q2FtOzpOHMCrhsVC8J+yUEaYfniydzB8
 oPhSyM8o+RqDaYd4GykJ9ggExdpyzmo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX2UrVPUeaGivz
 QFDNRz2vLDzqZgUwebcJP/JPMwqkHqCsCY/BdfB1otALah12DQIOyZ5LVJxlQnR3a8/ZCGQJPoS
 deMBFgrgbs++Mhv0vXMkHj8Bynr7EeMy6eLuCOEEtKP0Dn3N6rPYXgvrr8PhpBozqrmfKbYB+uZ
 /ZmUC1L2kurG0TvwVXY1lvCFpNPPORSYhPAzNgWoSqF3WSD/IeV4e8lk/ardY6Na8LNPwHkYAcZ
 QHJAii+juD9/CRlm20eMyxArn0TDXBYIod1m7gmMaGVxRNyUmXNq6LncIXydOWkJpQewJa9oiqY
 klLJWhBlCcxKFpDfgFzdNPqliBbU8Q9fnYnNjB+dTtq+eXFw1932vrMgaHmRS1sfoybXNKOPaMi
 xzjP82dT6sf4fDOzCHrfjWwemW3nrqg51Xw48cyCZHED1xZ+4x6e4WgBqsYoFntu+DwsleDkD1i
 qqpS7+ZcVqwKZPKHUoA==
X-Proofpoint-ORIG-GUID: tdhGS9sOYLI-HNQGP27nPYdIF2utUc8a
X-Authority-Analysis: v=2.4 cv=HNrz0Itv c=1 sm=1 tr=0 ts=6a84b125 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=zoMHqS0SsrMhSdMGEmoA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: tdhGS9sOYLI-HNQGP27nPYdIF2utUc8a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

v7
--
- tested on MacOS hosts (x64 + aarch64) in addition to linux x64 + aarch64
- fix sha1.c for big endian simply by including endian.h
- fix meson version bump: wrongly bumped qpl which had same version than meson
- gdb probe: add mipsel
- added missing compilation flags: -ffreestanding for all system tests, -march=armv7-a+fp for arm/system tests
- host cc system test: run simple test with -ffreestanding option
- testing doc: use ./run meson instead of ./pyvenv/bin/meson
- add new tests from upstream:
  - hexagon: fp_hvx, fp_hvx_disabled, fp_hvx_cvt, fp_hvx_cmp, valid-slots
  - s390x: prno-trng, stckf

v6
--
- add description for commits adding float reference files
- cache result of tests/docker/docker.py probe for faster container run
- fixed bug to detect if host cc is working
- detect when to deactivate prot-none.c test
- delete tests/tcg/s390x/pgm-specification.mak
- move remaining bits of gdb detection from configure to meson
- implement meson summary to dump tcg tests configuration
- implement ./configure containers options
- implement ./configure -cross-cc-* options
- add new tests added since last version: hexagon/unaligned_data.c

v5
--

- remove Makefiles incrementally to ease review, as suggested by Philippe
- default timeout 120 (matching Makefile default)

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

Pierrick Bouvier (104):
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
  tests/tcg/meson.build: use full path for QEMU binary
  tests/tcg/meson.build: add top-level 'tcg-tests' target
  tests/tcg/Makefile: skip user/system tests if target Makefile is not
    present
  tests/tcg/multiarch/gdbstub/prot-none.py: deactivate on gitlab CI
  tests/tcg/multiarch/gdbstub/prot-none.py: detect if /proc/self/mem can
    be used to access PROT_NONE pages
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
  tests/tcg: remove remaining Makefiles
  configure: directly pass gdb path as a meson option
  tests/tcg/meson.build: implement ./configure containers options
  tests/tcg/meson.build: implement ./configure -cross-cc-* options
  configure: remove cross_cc and gdb detection logic
  meson.build: add summary for TCG tests
  docs/devel/testing/: update documentation

 configure                                     | 530 +---------
 docs/devel/build-system.rst                   |   4 +-
 docs/devel/testing/main.rst                   |  35 +-
 meson.build                                   |  21 +-
 meson_options.txt                             |  95 +-
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
 tests/tcg/aarch64/system/meson.build          | 109 ++
 tests/tcg/aarch64_be/Makefile.target          |  17 -
 tests/tcg/aarch64_be/meson.build              |  22 +
 tests/tcg/alpha/Makefile.softmmu-target       |  34 -
 tests/tcg/alpha/Makefile.target               |  18 -
 tests/tcg/alpha/float_convd.ref               | 988 ++++++++++++++++++
 tests/tcg/alpha/float_convs.ref               | 748 +++++++++++++
 tests/tcg/alpha/float_madds.ref               | 768 ++++++++++++++
 tests/tcg/alpha/meson.build                   |  55 +
 tests/tcg/alpha/system/meson.build            |  47 +
 tests/tcg/arm/Makefile.softmmu-target         |  80 --
 tests/tcg/arm/Makefile.target                 |  87 --
 tests/tcg/arm/fcvt.c                          |   6 +-
 tests/tcg/arm/meson.build                     |  80 ++
 tests/tcg/arm/system/meson.build              |  68 ++
 tests/tcg/hexagon/Makefile.target             | 163 ---
 tests/tcg/hexagon/meson.build                 | 118 +++
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
 tests/tcg/i386/system/meson.build             |  49 +
 tests/tcg/loongarch64/Makefile.softmmu-target |  33 -
 tests/tcg/loongarch64/Makefile.target         |  20 -
 tests/tcg/loongarch64/meson.build             |  32 +
 tests/tcg/loongarch64/system/meson.build      |  48 +
 tests/tcg/m68k/Makefile.target                |   7 -
 tests/tcg/m68k/float_convd.ref                | 988 ++++++++++++++++++
 tests/tcg/m68k/float_convs.ref                | 748 +++++++++++++
 tests/tcg/m68k/float_madds.ref                | 768 ++++++++++++++
 tests/tcg/m68k/meson.build                    |  23 +
 tests/tcg/meson.build                         | 513 +++++++++
 tests/tcg/minilib/Makefile.target             |  21 -
 tests/tcg/mips/Makefile.target                |  19 -
 tests/tcg/mips/float_convd.ref                | 988 ++++++++++++++++++
 tests/tcg/mips/float_convs.ref                | 748 +++++++++++++
 tests/tcg/mips/float_madds.ref                | 768 ++++++++++++++
 tests/tcg/mips/meson.build                    |  25 +
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
 tests/tcg/multiarch/gdbstub/prot-none.py      |  40 +-
 tests/tcg/multiarch/meson.build               | 149 +++
 .../multiarch/plugin/check-plugin-output.sh   |  36 -
 tests/tcg/multiarch/plugin/regex-compare.sh   |  28 +
 tests/tcg/multiarch/sha1.c                    |   1 +
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
 tests/tcg/riscv64/system/meson.build          |  39 +
 tests/tcg/s390x/Makefile.softmmu-target       |  57 -
 tests/tcg/s390x/Makefile.target               | 129 ---
 tests/tcg/s390x/console.c                     |  30 +-
 tests/tcg/s390x/float_convd.ref               | 988 ++++++++++++++++++
 tests/tcg/s390x/float_convs.ref               | 748 +++++++++++++
 tests/tcg/s390x/float_madds.ref               | 768 ++++++++++++++
 tests/tcg/s390x/head64.S                      |   2 +
 tests/tcg/s390x/meson.build                   | 142 +++
 tests/tcg/s390x/pgm-specification.mak         |  15 -
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
 tests/tcg/test_cc.c                           |   9 +
 tests/tcg/tricore/Makefile.softmmu-target     |  53 -
 tests/tcg/tricore/meson.build                 |  57 +
 tests/tcg/x86_64/Makefile.softmmu-target      |  44 -
 tests/tcg/x86_64/Makefile.target              |  40 -
 tests/tcg/x86_64/float_madds.ref              | 768 ++++++++++++++
 tests/tcg/x86_64/meson.build                  |  83 ++
 tests/tcg/x86_64/system/meson.build           |  63 ++
 tests/tcg/xtensa/Makefile.softmmu-target      |  46 -
 tests/tcg/xtensa/crt.S                        |   1 +
 tests/tcg/xtensa/meson.build                  | 110 ++
 tests/tcg/xtensaeb/Makefile.softmmu-target    |   5 -
 159 files changed, 30852 insertions(+), 3924 deletions(-)
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
 delete mode 100644 tests/tcg/s390x/pgm-specification.mak
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
2.43.0


