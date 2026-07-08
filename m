Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D78C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 12:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whR5l-0003kS-17; Wed, 08 Jul 2026 08:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1whR5j-0003kE-8Z
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 08:09:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1whR5f-0005UK-Un
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 08:09:27 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668BmVFF3180206; Wed, 8 Jul 2026 12:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=VSwxAT
 lTFCJAYtNWNHGL3s0T2ll4KsgvspeNu+U8w/Q=; b=Lx6BPAZoT7h/kCVsBvqfK6
 n/o4dTTm0nosr2IHK/8XiTXNKqtIDrPXgcL75wCVc+LaT1apZCLwI8I4WVhAECig
 +Rppu39URQV3RKfDdxCp/MSC2II3NOvRLeCNrci/8ICbbIQWSu3KTK3jK+OxKYtZ
 jUlr2kUQ/acSnorPbvA1YLQ1d0oc6m7njHh8Lb+EJG3hqYKfF62/i3csJnfDlWlU
 mc09/fcNKNsuHEdpZLt/sQHUKDQUujmRxFYfs8Yc1Wm4NruCszFBFIMDXRuXCdPi
 /Cu8LEy854pZ+6Xe5KLBxaL1YZMM9PItnOhGChP12ppwB8arcMi84Ex/ypOwl8Dg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3vaj3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 12:09:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 668BnbHd026352;
 Wed, 8 Jul 2026 12:09:18 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6y7k06-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 12:09:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 668C9Grh51052830
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Jul 2026 12:09:16 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E74720043;
 Wed,  8 Jul 2026 12:09:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C2C520040;
 Wed,  8 Jul 2026 12:09:16 +0000 (GMT)
Received: from [9.224.75.238] (unknown [9.224.75.238])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  8 Jul 2026 12:09:15 +0000 (GMT)
Message-ID: <ed40c4a1-3e15-4ca9-8287-602723cbf6a4@linux.ibm.com>
Date: Wed, 8 Jul 2026 14:09:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/91] tests/tcg: run tests with meson
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4e3def cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=f7Z6t77VAApPFimNAjoA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDExNSBTYWx0ZWRfX8p2xslbXIP7k
 v0mc733zkwnjH0S8IW7NA3LjDhtuYwfYStj7z4ysZ6gYeDaOvhzKXLsLyq2/JJGML0/P6MJ9xUh
 fDDDECB3L/TGRFwBxlp8VrakjgLzGfw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDExNSBTYWx0ZWRfX3jQVmEEfT3X3
 yY3eMcIgBO17ZV1OqaqqKjDK83B7sQxqZSxwgneXnaMhqwGK7YBlz64EZ6Wx+V+gjrgMtK0nQdG
 lzpzKNW8+aKY/aKo4CmpUwQQ47xMqq/PdMrfRG+1vNfSk9q3nn0nGbwe5NDPju3467lhXVk3LjB
 vfPaCAuEI8egRXyc3FW5aY5/ERemHRYljyucGWOjzdSHXh+7BexwP6DuahizyP2XoXxGYqCwchx
 r1sNz7RJXWUygsZjuBBVyMZMuh/iu5cyuJC9WQrvnD+vj3V8Rg1YT0Owlupqx9Kucy2C24trGI9
 a84XqNHA34wrWUcD8xOoPiv3MlJ0dsUb4nSxSfJ4WvWCubdWVaRggwT8KTMxSXULWNs1E2ogWBk
 /ztxF8WH2GFnEIO/JWdwVCZ3dXfYWCzcpHu5xUgp2Pjz5fKvDogxMjev3bz1vkURC6qYNSdufV4
 Hut42jd9dwwtd6iN1tQ==
X-Proofpoint-ORIG-GUID: 4vgDvlWKWyLHxePBM5iNpaVD5oaQUbwO
X-Proofpoint-GUID: 7PvJFMrOhz6TyKhGCib87KFunr-NWl9_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1011
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080115
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 7/7/26 00:32, Pierrick Bouvier wrote:
> This series replaces TCG tests makefiles with meson, with the
> goal of having something more readable and maintainable in the long term.
> Also it closes the gap that tcg tests had with the rest of tests, by integrating
> them with meson directly.
> 
> It covers all existing tests for all architectures, including
> user/system/multiarch-user/multiarch-system. It implements all requirements
> listed on original thread [1].
> 
> [1] https://lore.kernel.org/qemu-devel/87wlwfsay4.fsf@draig.linaro.org/
> 
> We also have for free:
> - correct and complete dependencies for any test, including:
>    scripts, c.inc, headers, reference files and binaries/plugins.
> - catch test declaration issues at configure time vs test time.
> - proper data types for variables instead of string expansion with make.
> 
> Series first introduce the meson machinery needed in tests/tcg/meson.build, step
> by step. Then it adds support for all existing archs. Finally, we remove
> Makefiles and configure bits.
> 
> Usage:
> 
> ```
> make check-tcg
> make check-tcg-aarch64-linux-user
> make check-tcg-aarch64-softmmu
> 
> make tcg-tests
> 
> ninja clean
> ./pyvenv/bin/meson test aarch64-softmmu-asid2 --verbose
> ```
> 
> A few items were left for further work (out of scope for this series):
> - xtensaeb: didn't find how to cross compile for this architecture with what we
>    have now in container debian-xtensa-cross. Tips are welcome.
> - tricore: implemented but reverted as all tests seem to hang. To be
>    investigated.
> - riscv64/interruptedmemory.S is hanging. To be investigated.
> - i386/test-i386-fprem.c is deactivated for now. It's broken (output does not
>    match bare metal result) and is the slowest test we have. To be refactored and
>    fixed.
> 
> v3
> --
> 
> - add all architectures
> - reduce number of plugins tests (only add one test for each plugin from
>    multiarch pool)
> - add depends for executable - allow to depend on a custom target for generated
>    headers (x86_64 mmx, avx)
> - add new tests added since last version for aarch64 (mte + gpc)
> - refactor series to keep all arch files at end
> - add docker host architecture selection
> 
> v2
> --
> 
> - s/mispell/misspell
> - moved comment about why we remove 'lib' prefix for plugins
> - if user declare a wrong entry in a dictionary, list possible keys
> - build tests by default (with 'all' target), as long as cross compiler is
>    natively installed, to avoid triggering a container build.
> - reword some comments based on reviewers feedback
> - always declare all tests and avoid "per config" errors (no 'if' in arch files)
> - move compiler feature and gdb version checks directly in tests/tcg/meson.build
> - add support for cross containers
> - add top target 'tcg-tests' to rebuild all tests
> 
> Pierrick Bouvier (91):
>    tests/tcg/multiarch/system/memory.c: remove unused variable
>    tests/tcg/multiarch/plugin/check-plugin-output.sh: take test output as
>      input
>    tests/tcg/multiarch/plugin: rename check-plugin-output to
>      regex-compare
>    tests/tcg: introduce meson.build
>    tests/tcg/meson.build: introduce exe_name
>    tests/tcg/meson.build: introduce test_name
>    tests/tcg/meson.build: introduce cflags
>    tests/tcg/meson.build: introduce qemu_args
>    tests/tcg/meson.build: introduce env_var
>    tests/tcg/plugins: build list of test_plugins
>    tests/tcg/meson.build: introduce plugin_test
>    tests/tcg/meson.build: test gdb support and introduce gdb_arch
>    tests/tcg/meson.build: introduce gdb_test
>    tests/tcg/meson.build: add default flag for testing compiler support
>    tests/tcg/meson.build: introduce wrapper
>    tests/tcg/meson.build: introduce expected_output
>    tests/tcg/meson.build: add wrapper run_and_check_forbidden_output
>    tests/tcg/meson.build: add wrapper run_with_input
>    tests/tcg/meson.build: add wrapper record_replay
>    tests/tcg/meson.build: add wrapper check_plugin_output
>    tests/tcg/meson.build: add logic to skip tests
>    tests/tcg/meson.build: introduce cc_feat and cc_feat_cflags
>    tests/tcg/meson.build: introduce gdb_feat and gdb_feat_version
>    tests/tcg/meson.build: move gdb_arch support check
>    tests/tcg/meson.build: let test infrastructure detect compiler
>    tests/docker/docker.py: return error code if probe fails
>    tests/docker/docker.py: remove "Image is up to date" info
>    tests/tcg/meson.build: introduce cc_dockerfile and cc_docker_arch
>    tests/tcg/meson.build: introduce depends
>    tests/tcg/meson.build: add top-level 'tcg-tests' target
>    tests/tcg/multiarch: declare user tests
>    tests/tcg/multiarch: declare system tests
>    tests/tcg/meson.build: add generic plugin tests
>    tests/tcg/aarch64: user tests
>    tests/tcg/aarch64/system/gpc-test.c: remove unused variables
>    tests/tcg/aarch64: system tests
>    tests/tcg/aarch64_be: user tests
>    tests/tcg/alpha: add float reference files
>    tests/tcg/alpha: user tests
>    tests/tcg/alpha: system tests
>    tests/tcg/arm: user tests
>    tests/tcg/arm: system tests
>    tests/tcg/hexagon/overflow.c: add missing include
>    tests/tcg/hexagon: user tests
>    tests/tcg/multiarch/sha1.c: fix big endian implementation
>    tests/tcg/hppa: add float reference files
>    tests/tcg/hppa: user tests
>    tests/tcg/i386: add missing float reference files
>    tests/tcg/i386: user tests
>    tests/tcg/i386: system tests
>    tests/tcg/loongarch64: user tests
>    tests/tcg/loongarch64: system tests
>    tests/tcg/m68k: add float reference files
>    tests/tcg/m68k: user tests
>    scripts/probe-gdb-support.py: add mapping for mips architecture
>    tests/tcg/mips: add float reference files
>    test/tcg/mips: user tests
>    tests/tcg/mips64: add float reference files
>    tests/tcg/mips64: user tests
>    tests/tcg/mips64el: add float reference files
>    tests/tcg/mips64el: user tests
>    tests/docker/dockerfiles/debian-all-test-cross.docker: add or1k
>      toolchain
>    tests/tcg/or1k/test_addic.c: remove unused variables
>    tests/tcg/or1k/test_muli.c: remove set but unused variable
>    tests/tcg/or1k: add float reference files
>    plugins/api.c: identify or1k pc register and mark it as read only
>    tests/tcg/or1k: user tests
>    tests/tcg/ppc64: add float reference files
>    tests/tcg/ppc64: remove dependency on qemu/compiler.h
>    tests/tcg/ppc64: user tests
>    tests/tcg/ppc64le: add missing float reference file
>    tests/tcg/ppc64le: user tests
>    tests/tcg/riscv64: add float reference files
>    tests/tcg/riscv64: user tests
>    tests/tcg/riscv64: system tests
>    tests/tcg/s390x/head64.S: declare _exit symbol after main
>    tests/tcg/s390x: add float reference files
>    tests/tcg/s390x: user tests
>    tests/tcg/s390x: system tests
>    tests/tcg/sh4: add float reference files
>    tests/tcg/sh4: user tests
>    tests/tcg/tricore: system tests
>    Revert "tests/tcg/tricore: system tests"
>    tests/tcg/x86_64: add missing float reference file
>    tests/tcg/x86_64: user tests
>    tests/tcg/x86_64: system tests
>    tests/tcg/xtensa/crt.S: align .text section
>    tests/tcg/xtensa: system tests
>    tests: remove tcg tests machinery
>    tests/tcg: remove Makefiles
>    configure: remove --cross-cc* options
> 
>   configure                                     | 473 ---------
>   docs/devel/testing/main.rst                   |  22 +-
>   plugins/api.c                                 |   2 +
>   scripts/probe-gdb-support.py                  |   1 +
>   tests/Makefile.include                        |  68 +-
>   tests/docker/docker.py                        |   4 +-
>   .../dockerfiles/debian-all-test-cross.docker  |  16 +-
>   tests/lcitool/refresh                         | 107 +-
>   tests/meson.build                             |   2 +-
>   tests/tcg/Makefile.target                     | 281 -----
>   tests/tcg/aarch64/Makefile.softmmu-target     | 147 ---
>   tests/tcg/aarch64/Makefile.target             | 198 ----
>   tests/tcg/aarch64/meson.build                 | 195 ++++
>   tests/tcg/aarch64/system/gpc-test.c           |   5 -
>   tests/tcg/aarch64/system/meson.build          | 108 ++
>   tests/tcg/aarch64_be/Makefile.target          |  17 -
>   tests/tcg/aarch64_be/meson.build              |  22 +
>   tests/tcg/alpha/Makefile.softmmu-target       |  34 -
>   tests/tcg/alpha/Makefile.target               |  18 -
>   tests/tcg/alpha/float_convd.ref               | 988 ++++++++++++++++++
>   tests/tcg/alpha/float_convs.ref               | 748 +++++++++++++
>   tests/tcg/alpha/float_madds.ref               | 768 ++++++++++++++
>   tests/tcg/alpha/meson.build                   |  55 +
>   tests/tcg/alpha/system/meson.build            |  46 +
>   tests/tcg/arm/Makefile.softmmu-target         |  80 --
>   tests/tcg/arm/Makefile.target                 |  87 --
>   tests/tcg/arm/meson.build                     |  80 ++
>   tests/tcg/arm/system/meson.build              |  66 ++
>   tests/tcg/hexagon/Makefile.target             | 146 ---
>   tests/tcg/hexagon/meson.build                 | 111 ++
>   tests/tcg/hexagon/overflow.c                  |   1 +
>   tests/tcg/hppa/Makefile.target                |  14 -
>   tests/tcg/hppa/float_convd.ref                | 988 ++++++++++++++++++
>   tests/tcg/hppa/float_convs.ref                | 748 +++++++++++++
>   tests/tcg/hppa/float_madds.ref                | 768 ++++++++++++++
>   tests/tcg/hppa/meson.build                    |  22 +
>   tests/tcg/i386/Makefile.softmmu-target        |  37 -
>   tests/tcg/i386/Makefile.target                | 102 --
>   tests/tcg/i386/float_convd.conf               | 988 ------------------
>   tests/tcg/i386/float_convd.ref                | 988 ++++++++++++++++++
>   tests/tcg/i386/float_madds.ref                | 768 ++++++++++++++
>   tests/tcg/i386/meson.build                    |  58 +
>   tests/tcg/i386/system/meson.build             |  48 +
>   tests/tcg/loongarch64/Makefile.softmmu-target |  33 -
>   tests/tcg/loongarch64/Makefile.target         |  20 -
>   tests/tcg/loongarch64/meson.build             |  32 +
>   tests/tcg/loongarch64/system/meson.build      |  47 +
>   tests/tcg/m68k/Makefile.target                |   7 -
>   tests/tcg/m68k/float_convd.ref                | 988 ++++++++++++++++++
>   tests/tcg/m68k/float_convs.ref                | 748 +++++++++++++
>   tests/tcg/m68k/float_madds.ref                | 768 ++++++++++++++
>   tests/tcg/m68k/meson.build                    |  23 +
>   tests/tcg/meson.build                         | 447 ++++++++
>   tests/tcg/minilib/Makefile.target             |  21 -
>   tests/tcg/mips/Makefile.target                |  19 -
>   tests/tcg/mips/float_convd.ref                | 988 ++++++++++++++++++
>   tests/tcg/mips/float_convs.ref                | 748 +++++++++++++
>   tests/tcg/mips/float_madds.ref                | 768 ++++++++++++++
>   tests/tcg/mips/meson.build                    |  25 +
>   tests/tcg/mips/user/ase/dsp/Makefile          | 184 ----
>   tests/tcg/mips/user/isa/mips64r6/crc/Makefile |  40 -
>   tests/tcg/mips/user/isa/r5900/Makefile        |  32 -
>   tests/tcg/mips64/Makefile.target              |  20 -
>   tests/tcg/mips64/float_convd.ref              | 988 ++++++++++++++++++
>   tests/tcg/mips64/float_convs.ref              | 748 +++++++++++++
>   tests/tcg/mips64/float_madds.ref              | 768 ++++++++++++++
>   tests/tcg/mips64/meson.build                  |  27 +
>   tests/tcg/mips64el/Makefile.target            |   8 -
>   tests/tcg/mips64el/float_convd.ref            | 988 ++++++++++++++++++
>   tests/tcg/mips64el/float_convs.ref            | 748 +++++++++++++
>   tests/tcg/mips64el/float_madds.ref            | 768 ++++++++++++++
>   tests/tcg/mips64el/meson.build                |  14 +
>   tests/tcg/multiarch/Makefile.target           | 233 -----
>   tests/tcg/multiarch/meson.build               | 149 +++
>   .../multiarch/plugin/check-plugin-output.sh   |  36 -
>   tests/tcg/multiarch/plugin/regex-compare.sh   |  28 +
>   tests/tcg/multiarch/sha1.c                    |   4 +-
>   tests/tcg/multiarch/sha1.ref                  |   1 +
>   .../multiarch/system/Makefile.softmmu-target  |  81 --
>   tests/tcg/multiarch/system/memory.c           |   3 +-
>   tests/tcg/multiarch/system/meson.build        |  53 +
>   tests/tcg/or1k/Makefile                       |  71 --
>   tests/tcg/or1k/float_convd.ref                | 247 +++++
>   tests/tcg/or1k/float_convs.ref                | 187 ++++
>   tests/tcg/or1k/float_madds.ref                | 192 ++++
>   tests/tcg/or1k/meson.build                    |  72 ++
>   tests/tcg/or1k/test_addic.c                   |   2 +-
>   tests/tcg/or1k/test_muli.c                    |   5 +-
>   tests/tcg/plugins/meson.build                 |  11 +-
>   tests/tcg/ppc64/Makefile.target               |  63 --
>   tests/tcg/ppc64/float_convd.ref               | 988 ++++++++++++++++++
>   tests/tcg/ppc64/float_convs.ref               | 748 +++++++++++++
>   tests/tcg/ppc64/float_madds.ref               | 768 ++++++++++++++
>   tests/tcg/ppc64/meson.build                   |  56 +
>   tests/tcg/ppc64/vector.c                      |  11 +-
>   tests/tcg/ppc64/vsx_f2i_nan.c                 |   7 +-
>   tests/tcg/ppc64le/Makefile.target             |   7 -
>   tests/tcg/ppc64le/float_convd.ref             | 988 ++++++++++++++++++
>   tests/tcg/ppc64le/meson.build                 |  14 +
>   tests/tcg/riscv64/Makefile.softmmu-target     |  45 -
>   tests/tcg/riscv64/Makefile.target             |  20 -
>   tests/tcg/riscv64/float_convd.ref             | 988 ++++++++++++++++++
>   tests/tcg/riscv64/float_convs.ref             | 748 +++++++++++++
>   tests/tcg/riscv64/float_madds.ref             | 768 ++++++++++++++
>   tests/tcg/riscv64/meson.build                 |  38 +
>   tests/tcg/riscv64/system/meson.build          |  38 +
>   tests/tcg/s390x/Makefile.softmmu-target       |  57 -
>   tests/tcg/s390x/Makefile.target               | 127 ---
>   tests/tcg/s390x/float_convd.ref               | 988 ++++++++++++++++++
>   tests/tcg/s390x/float_convs.ref               | 748 +++++++++++++
>   tests/tcg/s390x/float_madds.ref               | 768 ++++++++++++++
>   tests/tcg/s390x/head64.S                      |   2 +
>   tests/tcg/s390x/meson.build                   | 140 +++
>   tests/tcg/s390x/system/meson.build            |  92 ++
>   tests/tcg/scripts/check_plugin_output.sh      |  25 +
>   tests/tcg/scripts/record_replay.sh            |  16 +
>   .../scripts/run_and_check_forbidden_output.sh |  19 +
>   tests/tcg/scripts/run_and_diff.sh             |  15 +
>   tests/tcg/scripts/run_with_input.sh           |  12 +
>   tests/tcg/sh4/Makefile.target                 |  18 -
>   tests/tcg/sh4/float_convd.ref                 | 494 +++++++++
>   tests/tcg/sh4/float_convs.ref                 | 374 +++++++
>   tests/tcg/sh4/float_madds.ref                 | 384 +++++++
>   tests/tcg/sh4/meson.build                     |  25 +
>   tests/tcg/tricore/Makefile.softmmu-target     |  53 -
>   tests/tcg/x86_64/Makefile.softmmu-target      |  44 -
>   tests/tcg/x86_64/Makefile.target              |  40 -
>   tests/tcg/x86_64/float_madds.ref              | 768 ++++++++++++++
>   tests/tcg/x86_64/meson.build                  |  83 ++
>   tests/tcg/x86_64/system/meson.build           |  62 ++
>   tests/tcg/xtensa/Makefile.softmmu-target      |  46 -
>   tests/tcg/xtensa/crt.S                        |   1 +
>   tests/tcg/xtensa/meson.build                  |  89 ++
>   tests/tcg/xtensaeb/Makefile.softmmu-target    |   5 -
>   134 files changed, 30491 insertions(+), 4114 deletions(-)
>   delete mode 100644 tests/tcg/Makefile.target
>   delete mode 100644 tests/tcg/aarch64/Makefile.softmmu-target
>   delete mode 100644 tests/tcg/aarch64/Makefile.target
>   create mode 100644 tests/tcg/aarch64/meson.build
>   create mode 100644 tests/tcg/aarch64/system/meson.build
>   delete mode 100644 tests/tcg/aarch64_be/Makefile.target
>   create mode 100644 tests/tcg/aarch64_be/meson.build
>   delete mode 100644 tests/tcg/alpha/Makefile.softmmu-target
>   delete mode 100644 tests/tcg/alpha/Makefile.target
>   create mode 100644 tests/tcg/alpha/float_convd.ref
>   create mode 100644 tests/tcg/alpha/float_convs.ref
>   create mode 100644 tests/tcg/alpha/float_madds.ref
>   create mode 100644 tests/tcg/alpha/meson.build
>   create mode 100644 tests/tcg/alpha/system/meson.build
>   delete mode 100644 tests/tcg/arm/Makefile.softmmu-target
>   delete mode 100644 tests/tcg/arm/Makefile.target
>   create mode 100644 tests/tcg/arm/meson.build
>   create mode 100644 tests/tcg/arm/system/meson.build
>   delete mode 100644 tests/tcg/hexagon/Makefile.target
>   create mode 100644 tests/tcg/hexagon/meson.build
>   delete mode 100644 tests/tcg/hppa/Makefile.target
>   create mode 100644 tests/tcg/hppa/float_convd.ref
>   create mode 100644 tests/tcg/hppa/float_convs.ref
>   create mode 100644 tests/tcg/hppa/float_madds.ref
>   create mode 100644 tests/tcg/hppa/meson.build
>   delete mode 100644 tests/tcg/i386/Makefile.softmmu-target
>   delete mode 100644 tests/tcg/i386/Makefile.target
>   delete mode 100644 tests/tcg/i386/float_convd.conf
>   create mode 100644 tests/tcg/i386/float_convd.ref
>   create mode 100644 tests/tcg/i386/float_madds.ref
>   create mode 100644 tests/tcg/i386/meson.build
>   create mode 100644 tests/tcg/i386/system/meson.build
>   delete mode 100644 tests/tcg/loongarch64/Makefile.softmmu-target
>   delete mode 100644 tests/tcg/loongarch64/Makefile.target
>   create mode 100644 tests/tcg/loongarch64/meson.build
>   create mode 100644 tests/tcg/loongarch64/system/meson.build
>   delete mode 100644 tests/tcg/m68k/Makefile.target
>   create mode 100644 tests/tcg/m68k/float_convd.ref
>   create mode 100644 tests/tcg/m68k/float_convs.ref
>   create mode 100644 tests/tcg/m68k/float_madds.ref
>   create mode 100644 tests/tcg/m68k/meson.build
>   create mode 100644 tests/tcg/meson.build
>   delete mode 100644 tests/tcg/minilib/Makefile.target
>   delete mode 100644 tests/tcg/mips/Makefile.target
>   create mode 100644 tests/tcg/mips/float_convd.ref
>   create mode 100644 tests/tcg/mips/float_convs.ref
>   create mode 100644 tests/tcg/mips/float_madds.ref
>   create mode 100644 tests/tcg/mips/meson.build
>   delete mode 100644 tests/tcg/mips/user/ase/dsp/Makefile
>   delete mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/Makefile
>   delete mode 100644 tests/tcg/mips/user/isa/r5900/Makefile
>   delete mode 100644 tests/tcg/mips64/Makefile.target
>   create mode 100644 tests/tcg/mips64/float_convd.ref
>   create mode 100644 tests/tcg/mips64/float_convs.ref
>   create mode 100644 tests/tcg/mips64/float_madds.ref
>   create mode 100644 tests/tcg/mips64/meson.build
>   delete mode 100644 tests/tcg/mips64el/Makefile.target
>   create mode 100644 tests/tcg/mips64el/float_convd.ref
>   create mode 100644 tests/tcg/mips64el/float_convs.ref
>   create mode 100644 tests/tcg/mips64el/float_madds.ref
>   create mode 100644 tests/tcg/mips64el/meson.build
>   delete mode 100644 tests/tcg/multiarch/Makefile.target
>   create mode 100644 tests/tcg/multiarch/meson.build
>   delete mode 100755 tests/tcg/multiarch/plugin/check-plugin-output.sh
>   create mode 100755 tests/tcg/multiarch/plugin/regex-compare.sh
>   create mode 100644 tests/tcg/multiarch/sha1.ref
>   delete mode 100644 tests/tcg/multiarch/system/Makefile.softmmu-target
>   create mode 100644 tests/tcg/multiarch/system/meson.build
>   delete mode 100644 tests/tcg/or1k/Makefile
>   create mode 100644 tests/tcg/or1k/float_convd.ref
>   create mode 100644 tests/tcg/or1k/float_convs.ref
>   create mode 100644 tests/tcg/or1k/float_madds.ref
>   create mode 100644 tests/tcg/or1k/meson.build
>   delete mode 100644 tests/tcg/ppc64/Makefile.target
>   create mode 100644 tests/tcg/ppc64/float_convd.ref
>   create mode 100644 tests/tcg/ppc64/float_convs.ref
>   create mode 100644 tests/tcg/ppc64/float_madds.ref
>   create mode 100644 tests/tcg/ppc64/meson.build
>   delete mode 100644 tests/tcg/ppc64le/Makefile.target
>   create mode 100644 tests/tcg/ppc64le/float_convd.ref
>   create mode 100644 tests/tcg/ppc64le/meson.build
>   delete mode 100644 tests/tcg/riscv64/Makefile.softmmu-target
>   delete mode 100644 tests/tcg/riscv64/Makefile.target
>   create mode 100644 tests/tcg/riscv64/float_convd.ref
>   create mode 100644 tests/tcg/riscv64/float_convs.ref
>   create mode 100644 tests/tcg/riscv64/float_madds.ref
>   create mode 100644 tests/tcg/riscv64/meson.build
>   create mode 100644 tests/tcg/riscv64/system/meson.build
>   delete mode 100644 tests/tcg/s390x/Makefile.softmmu-target
>   delete mode 100644 tests/tcg/s390x/Makefile.target
>   create mode 100644 tests/tcg/s390x/float_convd.ref
>   create mode 100644 tests/tcg/s390x/float_convs.ref
>   create mode 100644 tests/tcg/s390x/float_madds.ref
>   create mode 100644 tests/tcg/s390x/meson.build
>   create mode 100644 tests/tcg/s390x/system/meson.build
>   create mode 100755 tests/tcg/scripts/check_plugin_output.sh
>   create mode 100755 tests/tcg/scripts/record_replay.sh
>   create mode 100755 tests/tcg/scripts/run_and_check_forbidden_output.sh
>   create mode 100755 tests/tcg/scripts/run_and_diff.sh
>   create mode 100755 tests/tcg/scripts/run_with_input.sh
>   delete mode 100644 tests/tcg/sh4/Makefile.target
>   create mode 100644 tests/tcg/sh4/float_convd.ref
>   create mode 100644 tests/tcg/sh4/float_convs.ref
>   create mode 100644 tests/tcg/sh4/float_madds.ref
>   create mode 100644 tests/tcg/sh4/meson.build
>   delete mode 100644 tests/tcg/tricore/Makefile.softmmu-target
>   delete mode 100644 tests/tcg/x86_64/Makefile.softmmu-target
>   delete mode 100644 tests/tcg/x86_64/Makefile.target
>   create mode 100644 tests/tcg/x86_64/float_madds.ref
>   create mode 100644 tests/tcg/x86_64/meson.build
>   create mode 100644 tests/tcg/x86_64/system/meson.build
>   delete mode 100644 tests/tcg/xtensa/Makefile.softmmu-target
>   create mode 100644 tests/tcg/xtensa/meson.build
>   delete mode 100644 tests/tcg/xtensaeb/Makefile.softmmu-target
> 

Seems like something is wrong with cross-compiler detection now.
On Fedora I get:

FAILED: tests/tcg/s390x-softmmu-memory.test
/usr/lib64/ccache/s390x-linux-gnu-gcc 
/mnt/root/home/iii/qemu-worktrees/20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com/tests/tcg/multiarch/system/memory.c 
-o tests/tcg/s390x-softmmu-memory.test -static -MMD -MF 
tests/tcg/s390x-softmmu-memory.d -Wall -Werror -O0 -g 
-fno-strict-aliasing -nostdlib -I 
/mnt/root/home/iii/qemu-worktrees/20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com/tests/tcg/s390x/system/../../minilib 
/mnt/root/home/iii/qemu-worktrees/20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com/tests/tcg/s390x/system/../../minilib/printf.c 
-I 
/mnt/root/home/iii/qemu-worktrees/20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com/include/hw/s390x/ipl 
-I 
/mnt/root/home/iii/qemu-worktrees/20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com/roms/SLOF/lib/libc/include 
-march=z13 ../tests/tcg/s390x/system/../head64.S 
../tests/tcg/s390x/system/../console.c -DCHECK_UNALIGNED=0
In file included from 
/mnt/root/home/iii/qemu-worktrees/20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com/tests/tcg/multiarch/system/memory.c:15:
/usr/lib/gcc/s390x-linux-gnu/15/include/stdint.h:11:16: fatal error: 
stdint.h: No such file or directory
    11 | # include_next <stdint.h>
       |                ^~~~~~~~~~

The cross-compiler situation on Fedora is that they ship the
cross-compiler itself, but no userspace headers, so it's usable
only for kernel builds. In this case QEMU should fall back to Docker,
which works for me on master, but not with this series.

