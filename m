Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C98C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJEk-0004n5-2O; Fri, 10 Jul 2026 17:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJEj-0004mx-CI
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:58:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJEg-0007sf-5A
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:58:21 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3RhL1713145
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 a7XoUYeapv3k9eGK0RduURl+Q9RRm88A1d3rrBSUA6s=; b=X+buRCkb2kgGj1/g
 WQavDQanprCmGU3aMToijdO1Y3UoHBQAbmiugnvLQbKC2gYMvX1Tkwkqs1nENcy+
 KTH28pno4LIuBs9RmEl1vVvmwGDTfBg9TehdkOKu9EF0ncCxfLVtz7aMW5jW3upn
 mbdZ4+jc6HDEejDg6iQfwaEsqt92EK0Q12/PeDXZxW4bpmx/dxtRLU17uPJ3na0W
 OE2RnDwN/6csl09t7ZkHFJbUFPFiONEb5lZ22VpBBocN+ezjBIOtCz18HvVMP0N0
 OMn+boBz5FkXah9myahH+5I/UCoJsoThUAtoN/npEUn78xBocBkjkrr0eQiVcNAJ
 PBeTcg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb339saw1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:58:16 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-37d4f23eb37so2435697a91.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720695; x=1784325495; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=a7XoUYeapv3k9eGK0RduURl+Q9RRm88A1d3rrBSUA6s=;
 b=UamN+RPcfWaxLNgQ7eUQzo724jqSpXD7GVYmuMCuF16ea1bl7eclonLjRBWnbMrQgB
 W2nG9jUGwSMgeSY1gVLO+MhnOg2DublnPeBAEbpa9PBgodMV64oyqMOA+eCc9ZgaojXK
 w9H79Zl8j3i2EV8QbGWwlEvaV/MTGGSKy5ecyVJEEyDp4WpcZuqC7yYcIBV95ncjHmUb
 zuqAR0qR9AOr/GDvdPWqJqUo+Xs5IHDezZxkTJCjeho7iIs+Q1SrKZrLzhQ2W8pTvajG
 HnNiaE6qHEQOlc1TYP7k1NpO3leaRkaMTPOPg8BB07zeIEAjsejFpQBzc5xPkU6+9q77
 uOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720695; x=1784325495;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a7XoUYeapv3k9eGK0RduURl+Q9RRm88A1d3rrBSUA6s=;
 b=AXNcy0cYV/yNMuCca7hi2gFMkjXPC5NWdKObyajeg3Qxz3qIumGU5tOu6ViDwTu3JT
 6cj6Q/EmNZllx/Wpm6VoGNjsfV+fNH18Pr/wLUT2e5sRjuYEB9D/i7qotGJUF+0Z6cMi
 51RfyPs3WBaM6tQPWc0jV2lBWwehzrzXiU1InwZUzndBm4YpX70MCMJobYpflDATyLlK
 c9OJj5DuRwd+MxP/sk0WCzQIBWuVegqvERduVvtrs4YjJeu4v8Pdm7bbcyhvHzwfbD7/
 Sgy/Gk1ER7G2MH1eTMj2fhwP6gFJoSpQ72EToK/JudSWoqr9cJWCPeFk1Wd8F37jLvIS
 YI4w==
X-Gm-Message-State: AOJu0YymvFzrsYE4MfXrOW1BJxBqVP56Ju5Xu6tPlQB2o4gMkRoOvr7z
 NOAO0JY+hkv/KecBQplMso94ITUPep2hQWegj9BZNUhVl+LH+LpGz4fI+6fYzP2FI7vHdPuhvyi
 0P36DJ1nIrU1WWGmoF61Horvtru1EgHHxXsMds/MZa7XKfy7DxEb1FUVCON6Ia9i1yA==
X-Gm-Gg: AfdE7ckmiccOP8qbQv5qP99iJUYOcz65NAVfHz34/bqykmoGtnWFMK47jX5NtlDs/ev
 7FyYyv79grUeqLSrL/q7MZM3XK2c1F/uzPiCGsY8JnHQExGnd+wp8fSjsp8JiI6f95+06NDjB+t
 yDNtvY5CxigVTTfjOkeZdpMkihQWK0r9lGGlqSLXegAjqeP1I80l9fcFJnH2u2/1WF+X+7PZ/9S
 xG2az/kZPfjLqB1h2f3iea53NLJ9fN4T5LqQK06T+b8NLRV497R7nQmLhY6imyt35gC/wrDajWQ
 FMDSoqAdH6VlpG55oh0Ys5pPgIhQHV5eBpvRb+8x+eJcQZJuaZyVukhYqqNJl8eU2XlpG251HB0
 Ks6HeSY0phhAdPnOy/tmltD+aXou1dLZVDOMcC8gDpPjU5220mxD0Xj8X1Lxsd/Kb1SkkhZPHkk
 0w0s0=
X-Received: by 2002:a17:90b:1ccc:b0:380:40b:f30a with SMTP id
 98e67ed59e1d1-38dc74d047amr660606a91.13.1783720694641; 
 Fri, 10 Jul 2026 14:58:14 -0700 (PDT)
X-Received: by 2002:a17:90b:1ccc:b0:380:40b:f30a with SMTP id
 98e67ed59e1d1-38dc74d047amr660575a91.13.1783720694035; 
 Fri, 10 Jul 2026 14:58:14 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f596asm44325101eec.2.2026.07.10.14.58.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 14:58:13 -0700 (PDT)
Message-ID: <d6d19210-67e0-4995-8ca5-b5bdc41e16ee@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 14:58:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/98] tests/tcg: run tests with meson
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyMSBTYWx0ZWRfX1MVbzMJS18qT
 uYwNAjLYW42bHNXVyBNRYb9Rz1I9UFE8Q0iSbhjc+YEOpIxQf9ETHK3fMmvYhOIPCnjhPrt4ZDp
 fm/4ql0Nyz/QcywWTsDU2awMRGryXyo=
X-Authority-Analysis: v=2.4 cv=Re6gzVtv c=1 sm=1 tr=0 ts=6a516af8 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=rVJ3e4Pa7mP1m8dQMO8A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: fFLrCDoe8gn3MA7xit3ecdwGEDZxeyGO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyMSBTYWx0ZWRfX9VtFJaCVGfcc
 kroaZRgLilWz2TYFMlW7hmw9p3AR4SRo6zOeUgVwcblhu4Qo2uucHdVJKlBBBiZS8fF30F3fgBx
 4heoLpSQYUaP4d3WcQsDYIx1V8qCd9Pw/ZXYqMQTrO13xsVA0ISvtq/+m/Yfek64SnqWvRgVyx6
 Hd4juGUhb/iS2ljmv3BXhurOhAmoi3T9jTQkW50J88NhqF99vig5aJLsYR2h+3juCZBuuZUt7EG
 qU4oHS2hNztk+rxkhWAv/Mq8jeeYmJ/KTlFO8ta4vVBGypyQRQnQQEpfGsXBLDMlanBKjJoUi8k
 ZQZPjJqo5gXlMIFGN+qSj0qzbTCa0smKuHSAQgtFIPXSI9rKT29A7eu+KxRIIc0x0Lr+b7aVqLt
 wW/rUg6Vh94bvgYM7WYDLs4ngxm2d5nu5ppCz7Z2P7a40lGan3tHIDkwyoJ3SOUKRn7P8PVcflA
 T2/ZV8tySlahboURnhA==
X-Proofpoint-GUID: fFLrCDoe8gn3MA7xit3ecdwGEDZxeyGO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100221
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

On 7/10/2026 2:42 PM, Pierrick Bouvier wrote:
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
>   scripts, c.inc, headers, reference files and binaries/plugins.
> - catch test declaration issues at configure time vs test time.
> - proper data types for variables instead of string expansion with make.
> 
> Series first introduce the meson machinery needed in tests/tcg/meson.build, step
> by step. Then it adds support for all existing archs. Finally, we remove
> Makefiles and configure bits, and add documentation.
> 
> Usage:
> 
> ```
> make check-tcg
> make check-tcg-aarch64-linux-user
> make check-tcg-aarch64-softmmu
> make tcg-tests
> 
> ninja tcg-tests
> ninja clean
> ./pyvenv/bin/meson test aarch64-softmmu-asid2 --verbose
> ```
> 
> v5
> --
> 
> - remove Makefiles incrementally to ease review, as suggested by Philippe
> - default timeout 120 (matching Makefile default)
> 
> v4
> --
> 
> - rebase on top of master (Makefiles + Dockerfile changes)
> - full CI pass on GitLab
> - update documentation for tcg-tests
> - check host cross cc is working (handle fedora cross compiler without runtime or
>   headers)
> - rename cc_docker_arch to cc_docker_host_arch
> - add test added since v3: aarch64/fprcvt
> - enable tricore system tests (was missing -kernel parameter)
> - add xtensaeb system tests
> - remove dependency from s390x/console.c to roms/SLOF submodule, which allows to
>   compile those tests without requiring the submodule.
> - fix meson warnings (min version for test with external program in args +
>   s/source_root/project_source_root/)
> - skip failing test gdb-prot-none on GitLab CI
> 
> v3
> --
> 
> - add all architectures
> - reduce number of plugins tests (only add one test for each plugin from
>   multiarch pool)
> - add depends for executable - allow to depend on a custom target for generated
>   headers (x86_64 mmx, avx)
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
>   natively installed, to avoid triggering a container build.
> - reword some comments based on reviewers feedback
> - always declare all tests and avoid "per config" errors (no 'if' in arch files)
> - move compiler feature and gdb version checks directly in tests/tcg/meson.build
> - add support for cross containers
> - add top target 'tcg-tests' to rebuild all tests
> 
> Pierrick Bouvier (98):
>   tests/tcg/multiarch/system/memory.c: remove unused variable
>   tests/tcg/multiarch/plugin/check-plugin-output.sh: take test output as
>     input
>   tests/tcg/multiarch/plugin: rename check-plugin-output to
>     regex-compare
>   meson: bump minimal version to 1.6.0
>   tests/tcg: introduce meson.build
>   tests/tcg/meson.build: introduce exe_name
>   tests/tcg/meson.build: introduce test_name
>   tests/tcg/meson.build: introduce cflags
>   tests/tcg/meson.build: introduce qemu_args
>   tests/tcg/meson.build: introduce env_var
>   tests/tcg/plugins: build list of test_plugins
>   tests/tcg/meson.build: introduce plugin_test
>   tests/tcg/meson.build: test gdb support and introduce gdb_arch
>   tests/tcg/meson.build: introduce gdb_test
>   tests/tcg/meson.build: introduce wrapper
>   tests/tcg/meson.build: introduce expected_output
>   tests/tcg/meson.build: add wrapper run_and_check_forbidden_output
>   tests/tcg/meson.build: add wrapper run_with_input
>   tests/tcg/meson.build: add wrapper record_replay
>   tests/tcg/meson.build: add wrapper check_plugin_output
>   tests/tcg/meson.build: add logic to skip tests
>   tests/tcg/meson.build: introduce cc_feat and cc_feat_cflags
>   tests/tcg/meson.build: introduce gdb_feat and gdb_feat_version
>   tests/tcg/meson.build: move gdb_arch support check
>   tests/tcg/meson.build: let test infrastructure detect compiler
>   tests/docker/docker.py: return error code if probe fails
>   tests/docker/docker.py: remove "Image is up to date" info
>   tests/tcg/meson.build: introduce cc_dockerfile and cc_docker_host_arch
>   tests/tcg/meson.build: check host cross cc is working
>   tests/tcg/meson.build: introduce depends
>   tests/tcg/meson.build: add top-level 'tcg-tests' target
>   tests/tcg/Makefile: skip user/system tests if target Makefile is not
>     present
>   tests/tcg/multiarch/gdbstub/prot-none.py: deactivate on gitlab CI
>   tests/tcg/multiarch: declare user tests
>   tests/tcg/multiarch: declare system tests
>   tests/tcg/meson.build: add generic plugin tests
>   tests/tcg/arm/fcvt.c: use raw opcode for FPRCVT
>   tests/tcg/aarch64: user tests
>   tests/tcg/aarch64/system/gpc-test.c: remove unused variables
>   tests/tcg/aarch64: system tests
>   tests/tcg/aarch64_be: user tests
>   tests/tcg/alpha: add float reference files
>   tests/tcg/alpha: user tests
>   tests/tcg/alpha: system tests
>   tests/tcg/arm: user tests
>   tests/tcg/arm: system tests
>   tests/tcg/hexagon/overflow.c: add missing include
>   tests/tcg/hexagon: user tests
>   tests/tcg/multiarch/sha1.c: fix big endian implementation
>   tests/tcg/hppa: add float reference files
>   tests/tcg/hppa: user tests
>   tests/tcg/i386: add missing float reference files
>   tests/tcg/i386: user tests
>   tests/tcg/i386: system tests
>   tests/tcg/loongarch64: user tests
>   tests/tcg/loongarch64: system tests
>   tests/tcg/m68k: add float reference files
>   tests/tcg/m68k: user tests
>   scripts/probe-gdb-support.py: add mapping for mips architecture
>   tests/tcg/mips: add float reference files
>   test/tcg/mips: user tests
>   tests/tcg/mips64: add float reference files
>   tests/tcg/mips64: user tests
>   tests/tcg/mips64el: add float reference files
>   tests/tcg/mips64el: user tests
>   tests/docker/dockerfiles/debian-all-test-cross.docker: add or1k
>     toolchain
>   tests/tcg/or1k/test_addic.c: remove unused variables
>   tests/tcg/or1k/test_muli.c: remove set but unused variable
>   tests/tcg/or1k: add float reference files
>   plugins/api.c: identify or1k pc register and mark it as read only
>   tests/tcg/or1k: user tests
>   tests/tcg/ppc64: add float reference files
>   tests/tcg/ppc64: remove dependency on qemu/compiler.h
>   tests/tcg/ppc64: user tests
>   tests/tcg/ppc64le: add missing float reference file
>   tests/tcg/ppc64le: user tests
>   tests/tcg/riscv64: add float reference files
>   tests/tcg/riscv64: user tests
>   tests/tcg/riscv64: system tests
>   tests/tcg/s390x/head64.S: declare _exit symbol after main
>   tests/tcg/s390x: add float reference files
>   tests/tcg/s390x: user tests
>   tests/tcg/s390x/console.c: directly implement memcpy and memset
>   tests/tcg/s390x: system tests
>   tests/tcg/sh4: add float reference files
>   tests/tcg/sh4: user tests
>   tests/tcg/tricore: system tests
>   tests/tcg/x86_64: add missing float reference file
>   tests/tcg/x86_64: user tests
>   tests/tcg/x86_64: system tests
>   tests/tcg/xtensa/crt.S: align .text section
>   tests/docker/dockerfiles/debian-xtensa-cross.docker: add test_kc705_be
>     toolchain for xtensaeb
>   tests/tcg/xtensa: system tests
>   tests/tcg/xtensa: xtensaeb system tests
>   tests: remove tcg tests machinery
>   tests/tcg: remove remaining Makefiles
>   configure: remove --cross-cc* options
>   docs/devel/testing/: update documentation
> 
>  configure                                     | 473 ---------
>  docs/devel/build-system.rst                   |   4 +-
>  docs/devel/testing/main.rst                   |  55 +-
>  meson.build                                   |   4 +-
>  plugins/api.c                                 |   2 +
>  pythondeps.toml                               |   2 +-
>  scripts/probe-gdb-support.py                  |   1 +
>  .../packagefiles/anyhow-1-rs/meson.build      |   2 +-
>  .../arbitrary-int-1-rs/meson.build            |   2 +-
>  .../packagefiles/attrs-0.2-rs/meson.build     |   2 +-
>  .../packagefiles/bilge-0.2-rs/meson.build     |   2 +-
>  .../bilge-impl-0.2-rs/meson.build             |   2 +-
>  .../packagefiles/either-1-rs/meson.build      |   2 +-
>  .../packagefiles/foreign-0.3-rs/meson.build   |   2 +-
>  .../packagefiles/glib-sys-0.21-rs/meson.build |   2 +-
>  .../itertools-0.11-rs/meson.build             |   2 +-
>  .../packagefiles/libc-0.2-rs/meson.build      |   2 +-
>  .../packagefiles/probe-0.5-rs/meson.build     |   2 +-
>  .../proc-macro-error-1-rs/meson.build         |   2 +-
>  .../proc-macro-error-attr-1-rs/meson.build    |   2 +-
>  .../packagefiles/proc-macro2-1-rs/meson.build |   2 +-
>  .../packagefiles/quote-1-rs/meson.build       |   2 +-
>  subprojects/packagefiles/syn-2-rs/meson.build |   2 +-
>  .../unicode-ident-1-rs/meson.build            |   2 +-
>  tests/Makefile.include                        |  68 +-
>  tests/docker/docker.py                        |   4 +-
>  .../dockerfiles/debian-all-test-cross.docker  |  14 +-
>  .../dockerfiles/debian-xtensa-cross.docker    |   4 +-
>  tests/lcitool/refresh                         |  14 +-
>  tests/meson.build                             |   2 +-
>  tests/tcg/Makefile.target                     | 281 -----
>  tests/tcg/aarch64/Makefile.softmmu-target     | 147 ---
>  tests/tcg/aarch64/Makefile.target             | 210 ----
>  tests/tcg/aarch64/meson.build                 | 207 ++++
>  tests/tcg/aarch64/system/gpc-test.c           |   5 -
>  tests/tcg/aarch64/system/meson.build          | 108 ++
>  tests/tcg/aarch64_be/Makefile.target          |  17 -
>  tests/tcg/aarch64_be/meson.build              |  22 +
>  tests/tcg/alpha/Makefile.softmmu-target       |  34 -
>  tests/tcg/alpha/Makefile.target               |  18 -
>  tests/tcg/alpha/float_convd.ref               | 988 ++++++++++++++++++
>  tests/tcg/alpha/float_convs.ref               | 748 +++++++++++++
>  tests/tcg/alpha/float_madds.ref               | 768 ++++++++++++++
>  tests/tcg/alpha/meson.build                   |  55 +
>  tests/tcg/alpha/system/meson.build            |  46 +
>  tests/tcg/arm/Makefile.softmmu-target         |  80 --
>  tests/tcg/arm/Makefile.target                 |  87 --
>  tests/tcg/arm/fcvt.c                          |   6 +-
>  tests/tcg/arm/meson.build                     |  80 ++
>  tests/tcg/arm/system/meson.build              |  66 ++
>  tests/tcg/hexagon/Makefile.target             | 146 ---
>  tests/tcg/hexagon/meson.build                 | 111 ++
>  tests/tcg/hexagon/overflow.c                  |   1 +
>  tests/tcg/hppa/Makefile.target                |  14 -
>  tests/tcg/hppa/float_convd.ref                | 988 ++++++++++++++++++
>  tests/tcg/hppa/float_convs.ref                | 748 +++++++++++++
>  tests/tcg/hppa/float_madds.ref                | 768 ++++++++++++++
>  tests/tcg/hppa/meson.build                    |  22 +
>  tests/tcg/i386/Makefile.softmmu-target        |  37 -
>  tests/tcg/i386/Makefile.target                | 102 --
>  tests/tcg/i386/float_convd.conf               | 988 ------------------
>  tests/tcg/i386/float_convd.ref                | 988 ++++++++++++++++++
>  tests/tcg/i386/float_madds.ref                | 768 ++++++++++++++
>  tests/tcg/i386/meson.build                    |  58 +
>  tests/tcg/i386/system/meson.build             |  48 +
>  tests/tcg/loongarch64/Makefile.softmmu-target |  33 -
>  tests/tcg/loongarch64/Makefile.target         |  20 -
>  tests/tcg/loongarch64/meson.build             |  32 +
>  tests/tcg/loongarch64/system/meson.build      |  47 +
>  tests/tcg/m68k/Makefile.target                |   7 -
>  tests/tcg/m68k/float_convd.ref                | 988 ++++++++++++++++++
>  tests/tcg/m68k/float_convs.ref                | 748 +++++++++++++
>  tests/tcg/m68k/float_madds.ref                | 768 ++++++++++++++
>  tests/tcg/m68k/meson.build                    |  23 +
>  tests/tcg/meson.build                         | 462 ++++++++
>  tests/tcg/minilib/Makefile.target             |  21 -
>  tests/tcg/mips/Makefile.target                |  19 -
>  tests/tcg/mips/float_convd.ref                | 988 ++++++++++++++++++
>  tests/tcg/mips/float_convs.ref                | 748 +++++++++++++
>  tests/tcg/mips/float_madds.ref                | 768 ++++++++++++++
>  tests/tcg/mips/meson.build                    |  25 +
>  tests/tcg/mips64/Makefile.target              |  20 -
>  tests/tcg/mips64/float_convd.ref              | 988 ++++++++++++++++++
>  tests/tcg/mips64/float_convs.ref              | 748 +++++++++++++
>  tests/tcg/mips64/float_madds.ref              | 768 ++++++++++++++
>  tests/tcg/mips64/meson.build                  |  27 +
>  tests/tcg/mips64el/Makefile.target            |   8 -
>  tests/tcg/mips64el/float_convd.ref            | 988 ++++++++++++++++++
>  tests/tcg/mips64el/float_convs.ref            | 748 +++++++++++++
>  tests/tcg/mips64el/float_madds.ref            | 768 ++++++++++++++
>  tests/tcg/mips64el/meson.build                |  14 +
>  tests/tcg/multiarch/Makefile.target           | 224 ----
>  tests/tcg/multiarch/gdbstub/prot-none.py      |  11 +-
>  tests/tcg/multiarch/meson.build               | 149 +++
>  .../multiarch/plugin/check-plugin-output.sh   |  36 -
>  tests/tcg/multiarch/plugin/regex-compare.sh   |  28 +
>  tests/tcg/multiarch/sha1.c                    |   4 +-
>  tests/tcg/multiarch/sha1.ref                  |   1 +
>  .../multiarch/system/Makefile.softmmu-target  |  81 --
>  tests/tcg/multiarch/system/memory.c           |   3 +-
>  tests/tcg/multiarch/system/meson.build        |  53 +
>  tests/tcg/or1k/Makefile                       |  71 --
>  tests/tcg/or1k/float_convd.ref                | 247 +++++
>  tests/tcg/or1k/float_convs.ref                | 187 ++++
>  tests/tcg/or1k/float_madds.ref                | 192 ++++
>  tests/tcg/or1k/meson.build                    |  72 ++
>  tests/tcg/or1k/test_addic.c                   |   2 +-
>  tests/tcg/or1k/test_muli.c                    |   5 +-
>  tests/tcg/plugins/meson.build                 |  11 +-
>  tests/tcg/ppc64/Makefile.target               |  63 --
>  tests/tcg/ppc64/float_convd.ref               | 988 ++++++++++++++++++
>  tests/tcg/ppc64/float_convs.ref               | 748 +++++++++++++
>  tests/tcg/ppc64/float_madds.ref               | 768 ++++++++++++++
>  tests/tcg/ppc64/meson.build                   |  56 +
>  tests/tcg/ppc64/vector.c                      |  11 +-
>  tests/tcg/ppc64/vsx_f2i_nan.c                 |   7 +-
>  tests/tcg/ppc64le/Makefile.target             |   7 -
>  tests/tcg/ppc64le/float_convd.ref             | 988 ++++++++++++++++++
>  tests/tcg/ppc64le/meson.build                 |  14 +
>  tests/tcg/riscv64/Makefile.softmmu-target     |  45 -
>  tests/tcg/riscv64/Makefile.target             |  20 -
>  tests/tcg/riscv64/float_convd.ref             | 988 ++++++++++++++++++
>  tests/tcg/riscv64/float_convs.ref             | 748 +++++++++++++
>  tests/tcg/riscv64/float_madds.ref             | 768 ++++++++++++++
>  tests/tcg/riscv64/meson.build                 |  38 +
>  tests/tcg/riscv64/system/meson.build          |  38 +
>  tests/tcg/s390x/Makefile.softmmu-target       |  57 -
>  tests/tcg/s390x/Makefile.target               | 127 ---
>  tests/tcg/s390x/console.c                     |  30 +-
>  tests/tcg/s390x/float_convd.ref               | 988 ++++++++++++++++++
>  tests/tcg/s390x/float_convs.ref               | 748 +++++++++++++
>  tests/tcg/s390x/float_madds.ref               | 768 ++++++++++++++
>  tests/tcg/s390x/head64.S                      |   2 +
>  tests/tcg/s390x/meson.build                   | 140 +++
>  tests/tcg/s390x/system/meson.build            |  90 ++
>  tests/tcg/scripts/check_plugin_output.sh      |  25 +
>  tests/tcg/scripts/record_replay.sh            |  16 +
>  .../scripts/run_and_check_forbidden_output.sh |  19 +
>  tests/tcg/scripts/run_and_diff.sh             |  15 +
>  tests/tcg/scripts/run_with_input.sh           |  12 +
>  tests/tcg/sh4/Makefile.target                 |  18 -
>  tests/tcg/sh4/float_convd.ref                 | 494 +++++++++
>  tests/tcg/sh4/float_convs.ref                 | 374 +++++++
>  tests/tcg/sh4/float_madds.ref                 | 384 +++++++
>  tests/tcg/sh4/meson.build                     |  25 +
>  tests/tcg/test_cc.c                           |   7 +
>  tests/tcg/tricore/Makefile.softmmu-target     |  53 -
>  tests/tcg/tricore/meson.build                 |  57 +
>  tests/tcg/x86_64/Makefile.softmmu-target      |  44 -
>  tests/tcg/x86_64/Makefile.target              |  40 -
>  tests/tcg/x86_64/float_madds.ref              | 768 ++++++++++++++
>  tests/tcg/x86_64/meson.build                  |  83 ++
>  tests/tcg/x86_64/system/meson.build           |  62 ++
>  tests/tcg/xtensa/Makefile.softmmu-target      |  46 -
>  tests/tcg/xtensa/crt.S                        |   1 +
>  tests/tcg/xtensa/meson.build                  | 110 ++
>  tests/tcg/xtensaeb/Makefile.softmmu-target    |   5 -
>  157 files changed, 30640 insertions(+), 3855 deletions(-)
>  delete mode 100644 tests/tcg/Makefile.target
>  delete mode 100644 tests/tcg/aarch64/Makefile.softmmu-target
>  delete mode 100644 tests/tcg/aarch64/Makefile.target
>  create mode 100644 tests/tcg/aarch64/meson.build
>  create mode 100644 tests/tcg/aarch64/system/meson.build
>  delete mode 100644 tests/tcg/aarch64_be/Makefile.target
>  create mode 100644 tests/tcg/aarch64_be/meson.build
>  delete mode 100644 tests/tcg/alpha/Makefile.softmmu-target
>  delete mode 100644 tests/tcg/alpha/Makefile.target
>  create mode 100644 tests/tcg/alpha/float_convd.ref
>  create mode 100644 tests/tcg/alpha/float_convs.ref
>  create mode 100644 tests/tcg/alpha/float_madds.ref
>  create mode 100644 tests/tcg/alpha/meson.build
>  create mode 100644 tests/tcg/alpha/system/meson.build
>  delete mode 100644 tests/tcg/arm/Makefile.softmmu-target
>  delete mode 100644 tests/tcg/arm/Makefile.target
>  create mode 100644 tests/tcg/arm/meson.build
>  create mode 100644 tests/tcg/arm/system/meson.build
>  delete mode 100644 tests/tcg/hexagon/Makefile.target
>  create mode 100644 tests/tcg/hexagon/meson.build
>  delete mode 100644 tests/tcg/hppa/Makefile.target
>  create mode 100644 tests/tcg/hppa/float_convd.ref
>  create mode 100644 tests/tcg/hppa/float_convs.ref
>  create mode 100644 tests/tcg/hppa/float_madds.ref
>  create mode 100644 tests/tcg/hppa/meson.build
>  delete mode 100644 tests/tcg/i386/Makefile.softmmu-target
>  delete mode 100644 tests/tcg/i386/Makefile.target
>  delete mode 100644 tests/tcg/i386/float_convd.conf
>  create mode 100644 tests/tcg/i386/float_convd.ref
>  create mode 100644 tests/tcg/i386/float_madds.ref
>  create mode 100644 tests/tcg/i386/meson.build
>  create mode 100644 tests/tcg/i386/system/meson.build
>  delete mode 100644 tests/tcg/loongarch64/Makefile.softmmu-target
>  delete mode 100644 tests/tcg/loongarch64/Makefile.target
>  create mode 100644 tests/tcg/loongarch64/meson.build
>  create mode 100644 tests/tcg/loongarch64/system/meson.build
>  delete mode 100644 tests/tcg/m68k/Makefile.target
>  create mode 100644 tests/tcg/m68k/float_convd.ref
>  create mode 100644 tests/tcg/m68k/float_convs.ref
>  create mode 100644 tests/tcg/m68k/float_madds.ref
>  create mode 100644 tests/tcg/m68k/meson.build
>  create mode 100644 tests/tcg/meson.build
>  delete mode 100644 tests/tcg/minilib/Makefile.target
>  delete mode 100644 tests/tcg/mips/Makefile.target
>  create mode 100644 tests/tcg/mips/float_convd.ref
>  create mode 100644 tests/tcg/mips/float_convs.ref
>  create mode 100644 tests/tcg/mips/float_madds.ref
>  create mode 100644 tests/tcg/mips/meson.build
>  delete mode 100644 tests/tcg/mips64/Makefile.target
>  create mode 100644 tests/tcg/mips64/float_convd.ref
>  create mode 100644 tests/tcg/mips64/float_convs.ref
>  create mode 100644 tests/tcg/mips64/float_madds.ref
>  create mode 100644 tests/tcg/mips64/meson.build
>  delete mode 100644 tests/tcg/mips64el/Makefile.target
>  create mode 100644 tests/tcg/mips64el/float_convd.ref
>  create mode 100644 tests/tcg/mips64el/float_convs.ref
>  create mode 100644 tests/tcg/mips64el/float_madds.ref
>  create mode 100644 tests/tcg/mips64el/meson.build
>  delete mode 100644 tests/tcg/multiarch/Makefile.target
>  create mode 100644 tests/tcg/multiarch/meson.build
>  delete mode 100755 tests/tcg/multiarch/plugin/check-plugin-output.sh
>  create mode 100755 tests/tcg/multiarch/plugin/regex-compare.sh
>  create mode 100644 tests/tcg/multiarch/sha1.ref
>  delete mode 100644 tests/tcg/multiarch/system/Makefile.softmmu-target
>  create mode 100644 tests/tcg/multiarch/system/meson.build
>  delete mode 100644 tests/tcg/or1k/Makefile
>  create mode 100644 tests/tcg/or1k/float_convd.ref
>  create mode 100644 tests/tcg/or1k/float_convs.ref
>  create mode 100644 tests/tcg/or1k/float_madds.ref
>  create mode 100644 tests/tcg/or1k/meson.build
>  delete mode 100644 tests/tcg/ppc64/Makefile.target
>  create mode 100644 tests/tcg/ppc64/float_convd.ref
>  create mode 100644 tests/tcg/ppc64/float_convs.ref
>  create mode 100644 tests/tcg/ppc64/float_madds.ref
>  create mode 100644 tests/tcg/ppc64/meson.build
>  delete mode 100644 tests/tcg/ppc64le/Makefile.target
>  create mode 100644 tests/tcg/ppc64le/float_convd.ref
>  create mode 100644 tests/tcg/ppc64le/meson.build
>  delete mode 100644 tests/tcg/riscv64/Makefile.softmmu-target
>  delete mode 100644 tests/tcg/riscv64/Makefile.target
>  create mode 100644 tests/tcg/riscv64/float_convd.ref
>  create mode 100644 tests/tcg/riscv64/float_convs.ref
>  create mode 100644 tests/tcg/riscv64/float_madds.ref
>  create mode 100644 tests/tcg/riscv64/meson.build
>  create mode 100644 tests/tcg/riscv64/system/meson.build
>  delete mode 100644 tests/tcg/s390x/Makefile.softmmu-target
>  delete mode 100644 tests/tcg/s390x/Makefile.target
>  create mode 100644 tests/tcg/s390x/float_convd.ref
>  create mode 100644 tests/tcg/s390x/float_convs.ref
>  create mode 100644 tests/tcg/s390x/float_madds.ref
>  create mode 100644 tests/tcg/s390x/meson.build
>  create mode 100644 tests/tcg/s390x/system/meson.build
>  create mode 100755 tests/tcg/scripts/check_plugin_output.sh
>  create mode 100755 tests/tcg/scripts/record_replay.sh
>  create mode 100755 tests/tcg/scripts/run_and_check_forbidden_output.sh
>  create mode 100755 tests/tcg/scripts/run_and_diff.sh
>  create mode 100755 tests/tcg/scripts/run_with_input.sh
>  delete mode 100644 tests/tcg/sh4/Makefile.target
>  create mode 100644 tests/tcg/sh4/float_convd.ref
>  create mode 100644 tests/tcg/sh4/float_convs.ref
>  create mode 100644 tests/tcg/sh4/float_madds.ref
>  create mode 100644 tests/tcg/sh4/meson.build
>  create mode 100644 tests/tcg/test_cc.c
>  delete mode 100644 tests/tcg/tricore/Makefile.softmmu-target
>  create mode 100644 tests/tcg/tricore/meson.build
>  delete mode 100644 tests/tcg/x86_64/Makefile.softmmu-target
>  delete mode 100644 tests/tcg/x86_64/Makefile.target
>  create mode 100644 tests/tcg/x86_64/float_madds.ref
>  create mode 100644 tests/tcg/x86_64/meson.build
>  create mode 100644 tests/tcg/x86_64/system/meson.build
>  delete mode 100644 tests/tcg/xtensa/Makefile.softmmu-target
>  create mode 100644 tests/tcg/xtensa/meson.build
>  delete mode 100644 tests/tcg/xtensaeb/Makefile.softmmu-target
> 

If someone with a macos machine could give a try with their podman or
docker, it would be nice. The hosts I have access to don't have
virtualization support unfortunately.

Infrastructure patches missing reviews:
- 4
- 28-29
- 31
- 36

All commits above 31 (multiarch and arch) need review also.

Regards,
Pierrick

