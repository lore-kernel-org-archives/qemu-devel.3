Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 915D0C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgs2t-0001PI-35; Mon, 06 Jul 2026 18:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgs2s-0001Ov-7y
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:44:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgs2q-0000ob-3f
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:44:09 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KDxq11478039
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fZ66VI7tGRcrKslGsh/D/UErs7SdGdNUsf8wIezhHIw=; b=XoD480P22oIHrfcD
 0sWKT365rWb14lUCJDbaOeaLNGi6IMDvleCoiXrwV6KY6bapEKafwPr2k/XBQcLj
 mQ69md5/h1RUqBrc9ZDOoBfMf6iEun0S54IMHN2uMT3ZdsLhBxY20RpQuwTBNgaC
 /vBOyMWhOJhLd+YYXuvWuGBUob0fetSVVY9zJinbS3DzXAyc715bAMLzUHpTFtPJ
 Xm7IfkDSqJ5/vZ2aQofMlpHhqisjV+3fg7Q0rgGl8O/uBQv9YIcwXz4sc+rq9vCs
 CDqAB7NHTiJ6hmGLJZSL/SLOr2s0XQ9n2VFIkQcmzUhkxPz3aUn4klZ6Acyfepb0
 cHDW3Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hsbn0s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:44:06 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3840994b0d2so73554a91.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377846; x=1783982646; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fZ66VI7tGRcrKslGsh/D/UErs7SdGdNUsf8wIezhHIw=;
 b=YeWakYpJqtIWnpqlk/ATLKWa+Ndn98jh7LcsNeNW2iNjhI3dlHZrQnL0mU8z26hdSt
 Vb0OWSIFtucHjgSdAxcIe2+uUWYCPEExI0Hrme6GpIdB9oZxmPsrUd7J07Ri89Ul0EEh
 5mKn+Lx8wzb7bug1ve5J5dZokGVsY7Ad6NQ01Ie7DgNN/BPOrPvWA/3TDCp0OdFGZH8x
 /y+sgiYmo4oZvL22z1OdE39Bj60mF8AtxvIspXpGF/zc1rrDzi961JcjpzTUaIGGn/EB
 0iJ5o/eU/CfSuP5TZ2CjVTHUAvel0TwER7lY0IEB9Oa2UtY8XqozGR6X4H2OzxWm/RLt
 y03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377846; x=1783982646;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fZ66VI7tGRcrKslGsh/D/UErs7SdGdNUsf8wIezhHIw=;
 b=j5o527cyjWOAZqfAtbsmis3oj5GXquZDvQsN+Hn8grqbJ0/1u9oJnKMTE4fy9ZDx+l
 Rs3KMYNmdkFibqIok74u5fHDIRfl/e617luyqAi5phV3SmSOUhtyb31Xqk+9O8ei5pAs
 PgrSYoYA+3/JjEWcfF7mdzr0ZlvqfRKKf6bh6J3cp3h5bAnkvSdJd6yWugBDUrQsdKTf
 FT4g3ZXNS+ROXakBMnMenxWZEE05bN1Nwy+mG4GrXpK1oKDMtKgSuE7eRqXrMDbycIWP
 v2+/4Y9Azrop7848BYZDcQ7Bz3RLgcc1O7g2AmCLN1rpdPMRo1AXAwM+B8+I7EuTTqVs
 NzdA==
X-Gm-Message-State: AOJu0Yzeju9uZkpjfYXGqCc/FzLPwMqBZMyrHCYHnH1hKKoQtaAYbPBp
 fyfS+g/RmndOuQOMansezvB9rfPXJonbDmJQqMHg87iPLf2UHZuvQn7MSVtDC5W30sqVvNh2S57
 07tODNZtu9fmRRD6Zs4Jv6id8V9KBpLRYdrCgOc6nV/iTwiSMC0aStpYc9lUBkT5jXw==
X-Gm-Gg: AfdE7cnzLOqwtaKXzoQcQdSVrrtTntPZNVYfsZ9J3x9EIm89fj/Z9iByyzH+99Jzr4H
 bscBS9NGT5i3joUmP+SdIcGqoBPvfmuHrr6MnoH5Pb/LWMcMn2wePLA3jooWU8XkCrj1p40uQqu
 vKM+VbKr1W7Smlp9aoYLGEJyUobuuWENCoMtL1Mdow+JRJzMT4ZZnl7rYeds0knKsA+oPk3ZK3Z
 furQEIrirT5tlTQP4G9rflB3tGSG9B2AG6aU9YTkfDLalWnhGzLHnOizeWLi/W4pffFbciPtNqJ
 958HjixamFH7pAuDkqV7dsw58DT6BDsO87uidNGQK6UzYwkDoGcMVvFJyDLIPCp6rczm+XPprta
 801sg+w0Q26olYd2hFXT3WQDEd1FmWOzCYnbO/JdXaZsvQ0qM2IgHBoEC1Deg0awMDseaCvrYAg
 BXmj4=
X-Received: by 2002:a17:90b:2dc8:b0:36b:4d63:4a93 with SMTP id
 98e67ed59e1d1-387d8dee0fcmr221543a91.13.1783377845786; 
 Mon, 06 Jul 2026 15:44:05 -0700 (PDT)
X-Received: by 2002:a17:90b:2dc8:b0:36b:4d63:4a93 with SMTP id
 98e67ed59e1d1-387d8dee0fcmr221504a91.13.1783377845233; 
 Mon, 06 Jul 2026 15:44:05 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174a583bcsm1131423eec.19.2026.07.06.15.44.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 15:44:04 -0700 (PDT)
Message-ID: <aa144aa5-1a3a-4b0d-bd4b-30c8924c1d3c@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 15:44:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/37] tests/tcg: run tests with meson
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>
References: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: NMTjCooBlRMsIcF6-VamlQq5vdi_92Ne
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOSBTYWx0ZWRfX/cFOCLz9IsIl
 uISJzJ6rgEpFBvIN22aWaPaxYA14g9vSu720nK43Af76VoNAos22t+6i9IxvgPYheh8KScbx21P
 8gP/NBbttcmaymrImNJGimjV5IPtjIN56lAo6rIKypCKSbzPHPssIjkOQ7LUaNzNTAr4dEqM6Cr
 RMCKipB244Oa8f+44K5Ztdvm9xjJ3hDDzYMP1eP+m1uYeLN02s38tbY6cpMpPR0shK8E5it9rwT
 D4T/EYLk7Sn7ZPABTNDGyrz4w61ohzMYG2AGzAq6q6wmvn0TaNAlPpxJWjMbH6081uAb67mbrUf
 xiyJKgholRvm6FnpnKUwSHOTzbduZ6XUMCkwaUe7kzLJXtrFX0ohA3wIOPrwwIWS9b9tbeoHyTd
 GCQYs3c0XDY39gNKCnGbwWuOV8w/uOydreHeW021yahD++8UqTdLJP8oTqQRkDQ/KH48SOMWkhA
 CbwsBprWiTcVWnVYc2g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOSBTYWx0ZWRfX8xBhJrnS5e04
 ImrmGZ62TdthuPXlcDS0bHG59qB2cyNf8Yru1/TI78mrThVaG5oF/7WOC2W5oenzMu+zKLWSkCL
 XiM+U6eOQWs9FwlRSS46NsMHIjrjmFs=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4c2fb6 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=5xVL20QGa_1HK4rKbeQA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: NMTjCooBlRMsIcF6-VamlQq5vdi_92Ne
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060229
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

On 6/26/2026 4:38 PM, Pierrick Bouvier wrote:
> This series is an experiment to replace TCG tests makefiles with meson, with the
> goal of having something more readable and maintainable in the long term.
> Also it closes the gap that tcg tests had with the rest of tests, by integrating
> them with meson directly.
> 
> It covers all existing tests for aarch64 architecture, including
> user/system/multiarch-user/multiarch-system. I'll carry the effort to port all
> other architectures once we agree on a base. We agreed with Alex to not merge
> anything before all arch are covered.
> 
> It implements all requirements listed on original thread [1].
> 
> [1] https://lore.kernel.org/qemu-devel/87wlwfsay4.fsf@draig.linaro.org/
> 
> We also have for free:
> - correct and complete dependencies for any test, including:
>   scripts, c.inc, headers, reference files and binaries/plugins.
> - catch test declaration issues at configure time vs test time.
> - proper data types for variables instead of string expansion with make.
> - we now build tests binaries by default with 'all' target.
> - hopefully, better readability to your taste.
> 
> Main ideas for the current design are:
> - make arch files as simple and explicit as possible. If it conflicts,
>   always pick explicit, as long as we don't expose meson details.
>   remove any kind of "skip, override, filter" logic.
> - never expose custom_target and meson details in arch files.
> - catch any spelling mistake on test or any dependency.
> - keep complexity contained in tests/tcg/meson.build.
> 
> Usage:
> 
> ```
> make check-tcg
> make check-tcg-aarch64-linux-user
> make check-tcg-aarch64-softmmu
> make tcg-tests
> 
> from build folder:
> ./pyvenv/bin/meson test --list --suite tcg
> ninja clean
> ./pyvenv/bin/meson test aarch64-softmmu-asid2 --verbose
> ```
> 
> v2:
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
> Pierrick Bouvier (37):
>   tests/tcg/multiarch/system/memory.c: remove unused variable
>   tests/tcg/multiarch/plugin/check-plugin-output.sh: take test output as
>     input
>   tests/tcg/multiarch/plugin: rename check-plugin-output to
>     regex-compare
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
>   tests/tcg/meson.build: add default flag for testing compiler support
>   tests/tcg/meson.build: introduce wrapper
>   tests/tcg/meson.build: introduce expected_output
>   tests/tcg/meson.build: add wrapper run_and_check_forbidden_output
>   tests/tcg/meson.build: add wrapper run_with_input
>   tests/tcg/meson.build: add wrapper record_replay
>   tests/tcg/meson.build: add wrapper check_plugin_output
>   tests/tcg/aarch64: add user tests
>   tests/tcg/aarch64: add system tests
>   tests/tcg/multiarch: declare user tests
>   tests/tcg/aarch64: add multiarch user tests
>   tests/tcg/multiarch: declare system tests
>   tests/tcg/aarch64: add multiarch system tests
>   tests/tcg/meson.build: add generic plugin tests
>   tests/tcg/meson.build: add logic to skip tests
>   tests/tcg/meson.build: introduce cc_feat and cc_feat_cflags
>   tests/tcg/meson.build: introduce gdb_feat and gdb_feat_version
>   tests/tcg/meson.build: move gdb_arch support check
>   tests/tcg/aarch64: delegate cc_feat and gdb_feat
>   tests/tcg/meson.build: let test infrastructure detect compiler
>   tests/docker/docker.py: return error code if probe fails
>   tests/tcg/meson.build: introduce cc_dockerfile
>   tests/tcg/aarch64: add container support
>   tests/tcg/meson.build: add top-level 'tcg-tests' target
> 
>  tests/docker/docker.py                        |   1 +
>  tests/meson.build                             |   2 +-
>  tests/tcg/aarch64/meson.build                 | 193 +++++++++
>  tests/tcg/aarch64/system/meson.build          | 101 +++++
>  tests/tcg/meson.build                         | 402 ++++++++++++++++++
>  tests/tcg/multiarch/Makefile.target           |   3 +-
>  tests/tcg/multiarch/meson.build               | 149 +++++++
>  .../multiarch/plugin/check-plugin-output.sh   |  36 --
>  tests/tcg/multiarch/plugin/regex-compare.sh   |  28 ++
>  tests/tcg/multiarch/sha1.ref                  |   1 +
>  tests/tcg/multiarch/system/memory.c           |   3 +-
>  tests/tcg/multiarch/system/meson.build        |  53 +++
>  tests/tcg/plugins/meson.build                 |  11 +-
>  tests/tcg/scripts/check_plugin_output.sh      |  19 +
>  tests/tcg/scripts/record_replay.sh            |  16 +
>  .../scripts/run_and_check_forbidden_output.sh |  19 +
>  tests/tcg/scripts/run_and_diff.sh             |  15 +
>  tests/tcg/scripts/run_with_input.sh           |  12 +
>  18 files changed, 1019 insertions(+), 45 deletions(-)
>  create mode 100644 tests/tcg/aarch64/meson.build
>  create mode 100644 tests/tcg/aarch64/system/meson.build
>  create mode 100644 tests/tcg/meson.build
>  create mode 100644 tests/tcg/multiarch/meson.build
>  delete mode 100755 tests/tcg/multiarch/plugin/check-plugin-output.sh
>  create mode 100755 tests/tcg/multiarch/plugin/regex-compare.sh
>  create mode 100644 tests/tcg/multiarch/sha1.ref
>  create mode 100644 tests/tcg/multiarch/system/meson.build
>  create mode 100755 tests/tcg/scripts/check_plugin_output.sh
>  create mode 100755 tests/tcg/scripts/record_replay.sh
>  create mode 100755 tests/tcg/scripts/run_and_check_forbidden_output.sh
>  create mode 100755 tests/tcg/scripts/run_and_diff.sh
>  create mode 100755 tests/tcg/scripts/run_with_input.sh
> 

sent v3, with support for all architectures:
https://lore.kernel.org/qemu-devel/20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com/T/#

Regards,
Pierrick

