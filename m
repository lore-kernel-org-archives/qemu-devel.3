Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1721EC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 16:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whrqE-0004un-Gf; Thu, 09 Jul 2026 12:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whrqC-0004uc-AF
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:43:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whrq9-0003qL-69
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:43:12 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669GPvx92318975
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 16:43:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 46eOjTIV12NS+eFJCUPAc4kSAVURYjaSyn62iT1Hpk4=; b=UcnYiUW71miaverw
 iWs3vZ00hlkMagk6snqas2umW1KhmSGuT41BQa6Lqu+8OwvBt+zrIAVbquHnaPll
 8IpK/Yoh4TmVnVxO1/mPobEyxUhspFMkDLaLr580WQ5L3U13JpZwerFtRnGiTUgs
 AS1mOI6Kp5QHntzZbu0H5KraJXtg/KmuJwraDP712eaSJBndxljj+9viHNSG+Rld
 shuYnxT24GrnyeG0cYnsx1xE0f87dgMGRSE3fIC+Mu7Sd3DEHHN4UZIkhsYRHBjB
 zHAouePRWI37tl3ekjYNwKLMwGeCMHYbpShl+EtwFu2Q8fi42PcwnfLX9Oh2SH37
 wN24zw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf5mr3ty-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 16:43:07 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-84859a64079so1717250b3a.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 09:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783615387; x=1784220187; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=46eOjTIV12NS+eFJCUPAc4kSAVURYjaSyn62iT1Hpk4=;
 b=ABP3KZSGPde/JQvMX0FwomG/UGo1zy5NPCt7t89j9OtaHzgIdE6Nj0XlEKl9REUd1B
 mYJhi/vRBxt5YPDOgZAyLRDm52y36QS3VOBieGLPDoOfz+5uLQXHyDV7Ok+LC5YMT/rw
 kpZOE1LYe0XY6Rb/WXHkGQ9+UUIFXTCwpg4atQzWJbWZi+BpZnXmJtIy/dI8q9An4zfG
 4yN1J50AlontA3E7B60BjNWJbJ0zTaSYbtU0BUETQVyhEaGy77uIVXDyAgkobhFBP4wf
 9ZhyYD2dPt7IjMgO9p1/3v1hwCh9pzIeayOyR3oa2kWRugu5Vu4rIAAl1v9Ca1nXbQI4
 6tiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783615387; x=1784220187;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=46eOjTIV12NS+eFJCUPAc4kSAVURYjaSyn62iT1Hpk4=;
 b=bzINsVspOy53DwpQPnvo6ho1oy9X+SOSzxObaINsI4vKnLGfihRYu0cP4LZDGCxgYi
 JhnBC4TJjqSSEHw0Pqh7qvfi9FncLkn0GZxOPQRDm/jGBagXfK1GeMG0cS8Ptq79rybo
 L1qnlW4JBJ9avVCg7tiEqHx+riX+6HRbLKv4v253Rc3EfvMqp9MDR8uQs2+y2No57n6g
 UpSDCLnlunonQePnNP/eu0BKOZJNwMfWHXUrgrHXd5y6ICZcwyQ/Wh1pjAUeye6vEB0q
 IEV0CYxhcsedgnUbGjikM1mkLl46qegx/C03Jg03cTcWOI8xkylm9IEZN2wMLtvORNwg
 7VjA==
X-Gm-Message-State: AOJu0YwCFvNjc7poaIgG+tYQWHBIjZC2sAsyLU78hi2MFwQKiKauijBj
 bE74dy2k6AM+FBAgMJlDsyYSE8QN018gtqMzqn7+fJAFAyPPsRw3rEw87Szf3dCDQ3LehNGPemk
 5LjiXYVuRVHS4eBm0D2LzjcIFRFJT4UUkWnkNIAD4WgPBP+hGyCGvz/BGJw==
X-Gm-Gg: AfdE7cmmORSxurpCGTDnFmhfwaIgoF+epERPwELChtuZk/jjZnMEhlBkwIl9ngUM0es
 ZACHBoecKPIJF7nbJ9JToSTiWEKj/5s5xpwFyn9m9r6Rs3GeopJthRNtD3h0Oz1eWpyK/C1Eo2h
 kjM1A3Rs6JQMRtc/6yk8g65t4o8VfAhJ71C+7qu3L6axHLPPx0SkI812xwosIiTZ2g3xBYeQJUl
 u0JslJT/q78OnFGWe50bTsGrjjrZx/g8oI+uDRhrKq1gw1TKYvFguheVCAe7UsZ3y3bJ80il/pl
 Kljir6bPioDqh/Mr052Uprr3oveHXyegh45aLvBounfgNW/aPprTSbnG2w1gcx3I47Tetkzop9Y
 RO+fhCLcKK0PoQ3491tSgBEhCmEEhU61DyTT/jc+YVeubs4MBGtfOYWPpjvsjYrz7wLt9b5FejE
 SnFIc=
X-Received: by 2002:a05:6a00:1788:b0:848:2f84:72f with SMTP id
 d2e1a72fcca58-8484303520bmr7138134b3a.66.1783615386845; 
 Thu, 09 Jul 2026 09:43:06 -0700 (PDT)
X-Received: by 2002:a05:6a00:1788:b0:848:2f84:72f with SMTP id
 d2e1a72fcca58-8484303520bmr7138082b3a.66.1783615385904; 
 Thu, 09 Jul 2026 09:43:05 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8484c6ae0e7sm2302822b3a.45.2026.07.09.09.43.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 09:43:05 -0700 (PDT)
Message-ID: <7c8299d6-b585-4466-9890-7956307abbb6@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 09:43:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/91] tests/tcg: run tests with meson
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <87wlv4qgjz.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87wlv4qgjz.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FqM8bemFGaR8nwsIU6r98jd7obebD00x
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE2NCBTYWx0ZWRfX212PuvOaewvt
 hvT1pRdzIEqWefqqrShEUauKEC6KMzj9oFg2id1sUkq0VizE0S1UDqGVW/0yyPaa49zTbkzDqo5
 uFEW+mK/t0oaAy88umgeZTi0sHQkfy8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE2NCBTYWx0ZWRfX8l1CRCERV5pi
 3MU3MEekRkzWk16oPyTMW6jxcWc8e5q56YdmrHlmqG6AU+5MQHH19hgiKTMBIP2mV36lGyuO8vk
 sykM6n33F51oPZbPcTt9wg46B/nuwYG5jEGj651bF9NqYst0tTYDcpq3DdI6Fw7Ok8in/WOgr6B
 9rIUjtdebgs0iKD96jlkN9wHyGOhpVOXh1FWLo+D99Pbjq0SDxLSoEmTujuiHCAPl2aciIlOs0O
 +5bXb0HwkAToZgqdWIEZzGdCSrAQ95tChT15R7X+NnHavIy/mSkxQ0fOunOs/OtQVqeR92DDQty
 1v3ZYTcNAA48GUrr3XqA1O+F55uY08C8CbM+19kIS2ZMTLHZN1U//cVUcsLHHjJm4ByUjwo/tOy
 ZIASRPAQgDvDwvnSny6yVaMoVRC1Hlsxc4bnKIiEcRuR0DchrKmssGTfJJ98oNZRFhb1FWSaWlk
 UKKC5Um5/4JrYtcvksQ==
X-Proofpoint-GUID: FqM8bemFGaR8nwsIU6r98jd7obebD00x
X-Authority-Analysis: v=2.4 cv=N+QZ0W9B c=1 sm=1 tr=0 ts=6a4fcf9c cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=ID6ng7r3AAAA:8 a=EUspDBNiAAAA:8
 a=AjtTLzbVdUPvytr2UzEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=cvBusfyB2V15izCimMoJ:22 a=AkheI1RvQwOzcTXhi5f4:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090164
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

On 7/9/2026 9:22 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> This series replaces TCG tests makefiles with meson, with the
>> goal of having something more readable and maintainable in the long term.
>> Also it closes the gap that tcg tests had with the rest of tests, by integrating
>> them with meson directly.
>>
>> It covers all existing tests for all architectures, including
>> user/system/multiarch-user/multiarch-system. It implements all requirements
>> listed on original thread [1].
>>
>> [1] https://lore.kernel.org/qemu-devel/87wlwfsay4.fsf@draig.linaro.org/
>>
>> We also have for free:
>> - correct and complete dependencies for any test, including:
>>   scripts, c.inc, headers, reference files and binaries/plugins.
>> - catch test declaration issues at configure time vs test time.
>> - proper data types for variables instead of string expansion with make.
>>
>> Series first introduce the meson machinery needed in tests/tcg/meson.build, step
>> by step. Then it adds support for all existing archs. Finally, we remove
>> Makefiles and configure bits.
>>
>> Usage:
>>
>> ```
>> make check-tcg
>> make check-tcg-aarch64-linux-user
>> make check-tcg-aarch64-softmmu
>>
>> make tcg-tests
> 
> Can these be built via ninja?
>

Yes sure. I just listed make commands because I know some people can be
very sensitive about using anything out of make.

make tcg-tests is the same target as ninja tcg-tests.

The check targets are custom to Makefiles, because in an ideal world we
should be using meson test instead of make for this. Now that all tests
are meson native, maybe it will be time to reconsider this and
officially use meson test instead of make.

> Also I noticed docs/devel/testing/main.rst needs updating for the new
> world. It would be nice to add a simple example of adding a new test if
> you can.
>

If possible, I would like to avoid duplicating the comments from
tests/tcg/meson.build in docs. Documentation tends to become obsolete,
while code itself has to stay up to date by definition.

There are plenty of examples in tests/tcg/* to find how to declare tests
if someone is looking for information. Usually, a new test will just be
a copy of an existing one.

What do you think?

For the rest, you're right, I'll update
https://www.qemu.org/docs/master/devel/testing/main.html#testing-with-make-check-tcg
to match the new commands.

>>
>> ninja clean
>> ./pyvenv/bin/meson test aarch64-softmmu-asid2 --verbose
>> ```
>>
>> A few items were left for further work (out of scope for this series):
>> - xtensaeb: didn't find how to cross compile for this architecture with what we
>>   have now in container debian-xtensa-cross. Tips are welcome.
>> - tricore: implemented but reverted as all tests seem to hang. To be
>>   investigated.
>> - riscv64/interruptedmemory.S is hanging. To be investigated.
>> - i386/test-i386-fprem.c is deactivated for now. It's broken (output does not
>>   match bare metal result) and is the slowest test we have. To be refactored and
>>   fixed.
>>
>> v3
>> --
>>
>> - add all architectures
>> - reduce number of plugins tests (only add one test for each plugin from
>>   multiarch pool)
>> - add depends for executable - allow to depend on a custom target for generated
>>   headers (x86_64 mmx, avx)
>> - add new tests added since last version for aarch64 (mte + gpc)
>> - refactor series to keep all arch files at end
>> - add docker host architecture selection
>>
>> v2
>> --
>>
>> - s/mispell/misspell
>> - moved comment about why we remove 'lib' prefix for plugins
>> - if user declare a wrong entry in a dictionary, list possible keys
>> - build tests by default (with 'all' target), as long as cross compiler is
>>   natively installed, to avoid triggering a container build.
>> - reword some comments based on reviewers feedback
>> - always declare all tests and avoid "per config" errors (no 'if' in arch files)
>> - move compiler feature and gdb version checks directly in tests/tcg/meson.build
>> - add support for cross containers
>> - add top target 'tcg-tests' to rebuild all tests
>>
>> Pierrick Bouvier (91):
>>   tests/tcg/multiarch/system/memory.c: remove unused variable
>>   tests/tcg/multiarch/plugin/check-plugin-output.sh: take test output as
>>     input
>>   tests/tcg/multiarch/plugin: rename check-plugin-output to
>>     regex-compare
>>   tests/tcg: introduce meson.build
>>   tests/tcg/meson.build: introduce exe_name
>>   tests/tcg/meson.build: introduce test_name
>>   tests/tcg/meson.build: introduce cflags
>>   tests/tcg/meson.build: introduce qemu_args
>>   tests/tcg/meson.build: introduce env_var
>>   tests/tcg/plugins: build list of test_plugins
>>   tests/tcg/meson.build: introduce plugin_test
>>   tests/tcg/meson.build: test gdb support and introduce gdb_arch
>>   tests/tcg/meson.build: introduce gdb_test
>>   tests/tcg/meson.build: add default flag for testing compiler support
>>   tests/tcg/meson.build: introduce wrapper
>>   tests/tcg/meson.build: introduce expected_output
>>   tests/tcg/meson.build: add wrapper run_and_check_forbidden_output
>>   tests/tcg/meson.build: add wrapper run_with_input
>>   tests/tcg/meson.build: add wrapper record_replay
>>   tests/tcg/meson.build: add wrapper check_plugin_output
>>   tests/tcg/meson.build: add logic to skip tests
>>   tests/tcg/meson.build: introduce cc_feat and cc_feat_cflags
>>   tests/tcg/meson.build: introduce gdb_feat and gdb_feat_version
>>   tests/tcg/meson.build: move gdb_arch support check
>>   tests/tcg/meson.build: let test infrastructure detect compiler
>>   tests/docker/docker.py: return error code if probe fails
>>   tests/docker/docker.py: remove "Image is up to date" info
>>   tests/tcg/meson.build: introduce cc_dockerfile and cc_docker_arch
>>   tests/tcg/meson.build: introduce depends
>>   tests/tcg/meson.build: add top-level 'tcg-tests' target
>>   tests/tcg/multiarch: declare user tests
>>   tests/tcg/multiarch: declare system tests
>>   tests/tcg/meson.build: add generic plugin tests
>>   tests/tcg/aarch64: user tests
>>   tests/tcg/aarch64/system/gpc-test.c: remove unused variables
>>   tests/tcg/aarch64: system tests
>>   tests/tcg/aarch64_be: user tests
>>   tests/tcg/alpha: add float reference files
>>   tests/tcg/alpha: user tests
>>   tests/tcg/alpha: system tests
>>   tests/tcg/arm: user tests
>>   tests/tcg/arm: system tests
>>   tests/tcg/hexagon/overflow.c: add missing include
>>   tests/tcg/hexagon: user tests
>>   tests/tcg/multiarch/sha1.c: fix big endian implementation
>>   tests/tcg/hppa: add float reference files
>>   tests/tcg/hppa: user tests
>>   tests/tcg/i386: add missing float reference files
>>   tests/tcg/i386: user tests
>>   tests/tcg/i386: system tests
>>   tests/tcg/loongarch64: user tests
>>   tests/tcg/loongarch64: system tests
>>   tests/tcg/m68k: add float reference files
>>   tests/tcg/m68k: user tests
>>   scripts/probe-gdb-support.py: add mapping for mips architecture
>>   tests/tcg/mips: add float reference files
>>   test/tcg/mips: user tests
>>   tests/tcg/mips64: add float reference files
>>   tests/tcg/mips64: user tests
>>   tests/tcg/mips64el: add float reference files
>>   tests/tcg/mips64el: user tests
>>   tests/docker/dockerfiles/debian-all-test-cross.docker: add or1k
>>     toolchain
>>   tests/tcg/or1k/test_addic.c: remove unused variables
>>   tests/tcg/or1k/test_muli.c: remove set but unused variable
>>   tests/tcg/or1k: add float reference files
>>   plugins/api.c: identify or1k pc register and mark it as read only
>>   tests/tcg/or1k: user tests
>>   tests/tcg/ppc64: add float reference files
>>   tests/tcg/ppc64: remove dependency on qemu/compiler.h
>>   tests/tcg/ppc64: user tests
>>   tests/tcg/ppc64le: add missing float reference file
>>   tests/tcg/ppc64le: user tests
>>   tests/tcg/riscv64: add float reference files
>>   tests/tcg/riscv64: user tests
>>   tests/tcg/riscv64: system tests
>>   tests/tcg/s390x/head64.S: declare _exit symbol after main
>>   tests/tcg/s390x: add float reference files
>>   tests/tcg/s390x: user tests
>>   tests/tcg/s390x: system tests
>>   tests/tcg/sh4: add float reference files
>>   tests/tcg/sh4: user tests
>>   tests/tcg/tricore: system tests
>>   Revert "tests/tcg/tricore: system tests"
>>   tests/tcg/x86_64: add missing float reference file
>>   tests/tcg/x86_64: user tests
>>   tests/tcg/x86_64: system tests
>>   tests/tcg/xtensa/crt.S: align .text section
>>   tests/tcg/xtensa: system tests
>>   tests: remove tcg tests machinery
>>   tests/tcg: remove Makefiles
>>   configure: remove --cross-cc* options
>>
>>  configure                                     | 473 ---------
>>  docs/devel/testing/main.rst                   |  22 +-
>>  plugins/api.c                                 |   2 +
>>  scripts/probe-gdb-support.py                  |   1 +
>>  tests/Makefile.include                        |  68 +-
>>  tests/docker/docker.py                        |   4 +-
>>  .../dockerfiles/debian-all-test-cross.docker  |  16 +-
>>  tests/lcitool/refresh                         | 107 +-
>>  tests/meson.build                             |   2 +-
>>  tests/tcg/Makefile.target                     | 281 -----
>>  tests/tcg/aarch64/Makefile.softmmu-target     | 147 ---
>>  tests/tcg/aarch64/Makefile.target             | 198 ----
>>  tests/tcg/aarch64/meson.build                 | 195 ++++
>>  tests/tcg/aarch64/system/gpc-test.c           |   5 -
>>  tests/tcg/aarch64/system/meson.build          | 108 ++
>>  tests/tcg/aarch64_be/Makefile.target          |  17 -
>>  tests/tcg/aarch64_be/meson.build              |  22 +
>>  tests/tcg/alpha/Makefile.softmmu-target       |  34 -
>>  tests/tcg/alpha/Makefile.target               |  18 -
>>  tests/tcg/alpha/float_convd.ref               | 988 ++++++++++++++++++
>>  tests/tcg/alpha/float_convs.ref               | 748 +++++++++++++
>>  tests/tcg/alpha/float_madds.ref               | 768 ++++++++++++++
>>  tests/tcg/alpha/meson.build                   |  55 +
>>  tests/tcg/alpha/system/meson.build            |  46 +
>>  tests/tcg/arm/Makefile.softmmu-target         |  80 --
>>  tests/tcg/arm/Makefile.target                 |  87 --
>>  tests/tcg/arm/meson.build                     |  80 ++
>>  tests/tcg/arm/system/meson.build              |  66 ++
>>  tests/tcg/hexagon/Makefile.target             | 146 ---
>>  tests/tcg/hexagon/meson.build                 | 111 ++
>>  tests/tcg/hexagon/overflow.c                  |   1 +
>>  tests/tcg/hppa/Makefile.target                |  14 -
>>  tests/tcg/hppa/float_convd.ref                | 988 ++++++++++++++++++
>>  tests/tcg/hppa/float_convs.ref                | 748 +++++++++++++
>>  tests/tcg/hppa/float_madds.ref                | 768 ++++++++++++++
>>  tests/tcg/hppa/meson.build                    |  22 +
>>  tests/tcg/i386/Makefile.softmmu-target        |  37 -
>>  tests/tcg/i386/Makefile.target                | 102 --
>>  tests/tcg/i386/float_convd.conf               | 988 ------------------
>>  tests/tcg/i386/float_convd.ref                | 988 ++++++++++++++++++
>>  tests/tcg/i386/float_madds.ref                | 768 ++++++++++++++
>>  tests/tcg/i386/meson.build                    |  58 +
>>  tests/tcg/i386/system/meson.build             |  48 +
>>  tests/tcg/loongarch64/Makefile.softmmu-target |  33 -
>>  tests/tcg/loongarch64/Makefile.target         |  20 -
>>  tests/tcg/loongarch64/meson.build             |  32 +
>>  tests/tcg/loongarch64/system/meson.build      |  47 +
>>  tests/tcg/m68k/Makefile.target                |   7 -
>>  tests/tcg/m68k/float_convd.ref                | 988 ++++++++++++++++++
>>  tests/tcg/m68k/float_convs.ref                | 748 +++++++++++++
>>  tests/tcg/m68k/float_madds.ref                | 768 ++++++++++++++
>>  tests/tcg/m68k/meson.build                    |  23 +
>>  tests/tcg/meson.build                         | 447 ++++++++
>>  tests/tcg/minilib/Makefile.target             |  21 -
>>  tests/tcg/mips/Makefile.target                |  19 -
>>  tests/tcg/mips/float_convd.ref                | 988 ++++++++++++++++++
>>  tests/tcg/mips/float_convs.ref                | 748 +++++++++++++
>>  tests/tcg/mips/float_madds.ref                | 768 ++++++++++++++
>>  tests/tcg/mips/meson.build                    |  25 +
>>  tests/tcg/mips/user/ase/dsp/Makefile          | 184 ----
>>  tests/tcg/mips/user/isa/mips64r6/crc/Makefile |  40 -
>>  tests/tcg/mips/user/isa/r5900/Makefile        |  32 -
>>  tests/tcg/mips64/Makefile.target              |  20 -
>>  tests/tcg/mips64/float_convd.ref              | 988 ++++++++++++++++++
>>  tests/tcg/mips64/float_convs.ref              | 748 +++++++++++++
>>  tests/tcg/mips64/float_madds.ref              | 768 ++++++++++++++
>>  tests/tcg/mips64/meson.build                  |  27 +
>>  tests/tcg/mips64el/Makefile.target            |   8 -
>>  tests/tcg/mips64el/float_convd.ref            | 988 ++++++++++++++++++
>>  tests/tcg/mips64el/float_convs.ref            | 748 +++++++++++++
>>  tests/tcg/mips64el/float_madds.ref            | 768 ++++++++++++++
>>  tests/tcg/mips64el/meson.build                |  14 +
>>  tests/tcg/multiarch/Makefile.target           | 233 -----
>>  tests/tcg/multiarch/meson.build               | 149 +++
>>  .../multiarch/plugin/check-plugin-output.sh   |  36 -
>>  tests/tcg/multiarch/plugin/regex-compare.sh   |  28 +
>>  tests/tcg/multiarch/sha1.c                    |   4 +-
>>  tests/tcg/multiarch/sha1.ref                  |   1 +
>>  .../multiarch/system/Makefile.softmmu-target  |  81 --
>>  tests/tcg/multiarch/system/memory.c           |   3 +-
>>  tests/tcg/multiarch/system/meson.build        |  53 +
>>  tests/tcg/or1k/Makefile                       |  71 --
>>  tests/tcg/or1k/float_convd.ref                | 247 +++++
>>  tests/tcg/or1k/float_convs.ref                | 187 ++++
>>  tests/tcg/or1k/float_madds.ref                | 192 ++++
>>  tests/tcg/or1k/meson.build                    |  72 ++
>>  tests/tcg/or1k/test_addic.c                   |   2 +-
>>  tests/tcg/or1k/test_muli.c                    |   5 +-
>>  tests/tcg/plugins/meson.build                 |  11 +-
>>  tests/tcg/ppc64/Makefile.target               |  63 --
>>  tests/tcg/ppc64/float_convd.ref               | 988 ++++++++++++++++++
>>  tests/tcg/ppc64/float_convs.ref               | 748 +++++++++++++
>>  tests/tcg/ppc64/float_madds.ref               | 768 ++++++++++++++
>>  tests/tcg/ppc64/meson.build                   |  56 +
>>  tests/tcg/ppc64/vector.c                      |  11 +-
>>  tests/tcg/ppc64/vsx_f2i_nan.c                 |   7 +-
>>  tests/tcg/ppc64le/Makefile.target             |   7 -
>>  tests/tcg/ppc64le/float_convd.ref             | 988 ++++++++++++++++++
>>  tests/tcg/ppc64le/meson.build                 |  14 +
>>  tests/tcg/riscv64/Makefile.softmmu-target     |  45 -
>>  tests/tcg/riscv64/Makefile.target             |  20 -
>>  tests/tcg/riscv64/float_convd.ref             | 988 ++++++++++++++++++
>>  tests/tcg/riscv64/float_convs.ref             | 748 +++++++++++++
>>  tests/tcg/riscv64/float_madds.ref             | 768 ++++++++++++++
>>  tests/tcg/riscv64/meson.build                 |  38 +
>>  tests/tcg/riscv64/system/meson.build          |  38 +
>>  tests/tcg/s390x/Makefile.softmmu-target       |  57 -
>>  tests/tcg/s390x/Makefile.target               | 127 ---
>>  tests/tcg/s390x/float_convd.ref               | 988 ++++++++++++++++++
>>  tests/tcg/s390x/float_convs.ref               | 748 +++++++++++++
>>  tests/tcg/s390x/float_madds.ref               | 768 ++++++++++++++
>>  tests/tcg/s390x/head64.S                      |   2 +
>>  tests/tcg/s390x/meson.build                   | 140 +++
>>  tests/tcg/s390x/system/meson.build            |  92 ++
>>  tests/tcg/scripts/check_plugin_output.sh      |  25 +
>>  tests/tcg/scripts/record_replay.sh            |  16 +
>>  .../scripts/run_and_check_forbidden_output.sh |  19 +
>>  tests/tcg/scripts/run_and_diff.sh             |  15 +
>>  tests/tcg/scripts/run_with_input.sh           |  12 +
>>  tests/tcg/sh4/Makefile.target                 |  18 -
>>  tests/tcg/sh4/float_convd.ref                 | 494 +++++++++
>>  tests/tcg/sh4/float_convs.ref                 | 374 +++++++
>>  tests/tcg/sh4/float_madds.ref                 | 384 +++++++
>>  tests/tcg/sh4/meson.build                     |  25 +
>>  tests/tcg/tricore/Makefile.softmmu-target     |  53 -
>>  tests/tcg/x86_64/Makefile.softmmu-target      |  44 -
>>  tests/tcg/x86_64/Makefile.target              |  40 -
>>  tests/tcg/x86_64/float_madds.ref              | 768 ++++++++++++++
>>  tests/tcg/x86_64/meson.build                  |  83 ++
>>  tests/tcg/x86_64/system/meson.build           |  62 ++
>>  tests/tcg/xtensa/Makefile.softmmu-target      |  46 -
>>  tests/tcg/xtensa/crt.S                        |   1 +
>>  tests/tcg/xtensa/meson.build                  |  89 ++
>>  tests/tcg/xtensaeb/Makefile.softmmu-target    |   5 -
>>  134 files changed, 30491 insertions(+), 4114 deletions(-)
>>  delete mode 100644 tests/tcg/Makefile.target
>>  delete mode 100644 tests/tcg/aarch64/Makefile.softmmu-target
>>  delete mode 100644 tests/tcg/aarch64/Makefile.target
>>  create mode 100644 tests/tcg/aarch64/meson.build
>>  create mode 100644 tests/tcg/aarch64/system/meson.build
>>  delete mode 100644 tests/tcg/aarch64_be/Makefile.target
>>  create mode 100644 tests/tcg/aarch64_be/meson.build
>>  delete mode 100644 tests/tcg/alpha/Makefile.softmmu-target
>>  delete mode 100644 tests/tcg/alpha/Makefile.target
>>  create mode 100644 tests/tcg/alpha/float_convd.ref
>>  create mode 100644 tests/tcg/alpha/float_convs.ref
>>  create mode 100644 tests/tcg/alpha/float_madds.ref
>>  create mode 100644 tests/tcg/alpha/meson.build
>>  create mode 100644 tests/tcg/alpha/system/meson.build
>>  delete mode 100644 tests/tcg/arm/Makefile.softmmu-target
>>  delete mode 100644 tests/tcg/arm/Makefile.target
>>  create mode 100644 tests/tcg/arm/meson.build
>>  create mode 100644 tests/tcg/arm/system/meson.build
>>  delete mode 100644 tests/tcg/hexagon/Makefile.target
>>  create mode 100644 tests/tcg/hexagon/meson.build
>>  delete mode 100644 tests/tcg/hppa/Makefile.target
>>  create mode 100644 tests/tcg/hppa/float_convd.ref
>>  create mode 100644 tests/tcg/hppa/float_convs.ref
>>  create mode 100644 tests/tcg/hppa/float_madds.ref
>>  create mode 100644 tests/tcg/hppa/meson.build
>>  delete mode 100644 tests/tcg/i386/Makefile.softmmu-target
>>  delete mode 100644 tests/tcg/i386/Makefile.target
>>  delete mode 100644 tests/tcg/i386/float_convd.conf
>>  create mode 100644 tests/tcg/i386/float_convd.ref
>>  create mode 100644 tests/tcg/i386/float_madds.ref
>>  create mode 100644 tests/tcg/i386/meson.build
>>  create mode 100644 tests/tcg/i386/system/meson.build
>>  delete mode 100644 tests/tcg/loongarch64/Makefile.softmmu-target
>>  delete mode 100644 tests/tcg/loongarch64/Makefile.target
>>  create mode 100644 tests/tcg/loongarch64/meson.build
>>  create mode 100644 tests/tcg/loongarch64/system/meson.build
>>  delete mode 100644 tests/tcg/m68k/Makefile.target
>>  create mode 100644 tests/tcg/m68k/float_convd.ref
>>  create mode 100644 tests/tcg/m68k/float_convs.ref
>>  create mode 100644 tests/tcg/m68k/float_madds.ref
>>  create mode 100644 tests/tcg/m68k/meson.build
>>  create mode 100644 tests/tcg/meson.build
>>  delete mode 100644 tests/tcg/minilib/Makefile.target
>>  delete mode 100644 tests/tcg/mips/Makefile.target
>>  create mode 100644 tests/tcg/mips/float_convd.ref
>>  create mode 100644 tests/tcg/mips/float_convs.ref
>>  create mode 100644 tests/tcg/mips/float_madds.ref
>>  create mode 100644 tests/tcg/mips/meson.build
>>  delete mode 100644 tests/tcg/mips/user/ase/dsp/Makefile
>>  delete mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/Makefile
>>  delete mode 100644 tests/tcg/mips/user/isa/r5900/Makefile
>>  delete mode 100644 tests/tcg/mips64/Makefile.target
>>  create mode 100644 tests/tcg/mips64/float_convd.ref
>>  create mode 100644 tests/tcg/mips64/float_convs.ref
>>  create mode 100644 tests/tcg/mips64/float_madds.ref
>>  create mode 100644 tests/tcg/mips64/meson.build
>>  delete mode 100644 tests/tcg/mips64el/Makefile.target
>>  create mode 100644 tests/tcg/mips64el/float_convd.ref
>>  create mode 100644 tests/tcg/mips64el/float_convs.ref
>>  create mode 100644 tests/tcg/mips64el/float_madds.ref
>>  create mode 100644 tests/tcg/mips64el/meson.build
>>  delete mode 100644 tests/tcg/multiarch/Makefile.target
>>  create mode 100644 tests/tcg/multiarch/meson.build
>>  delete mode 100755 tests/tcg/multiarch/plugin/check-plugin-output.sh
>>  create mode 100755 tests/tcg/multiarch/plugin/regex-compare.sh
>>  create mode 100644 tests/tcg/multiarch/sha1.ref
>>  delete mode 100644 tests/tcg/multiarch/system/Makefile.softmmu-target
>>  create mode 100644 tests/tcg/multiarch/system/meson.build
>>  delete mode 100644 tests/tcg/or1k/Makefile
>>  create mode 100644 tests/tcg/or1k/float_convd.ref
>>  create mode 100644 tests/tcg/or1k/float_convs.ref
>>  create mode 100644 tests/tcg/or1k/float_madds.ref
>>  create mode 100644 tests/tcg/or1k/meson.build
>>  delete mode 100644 tests/tcg/ppc64/Makefile.target
>>  create mode 100644 tests/tcg/ppc64/float_convd.ref
>>  create mode 100644 tests/tcg/ppc64/float_convs.ref
>>  create mode 100644 tests/tcg/ppc64/float_madds.ref
>>  create mode 100644 tests/tcg/ppc64/meson.build
>>  delete mode 100644 tests/tcg/ppc64le/Makefile.target
>>  create mode 100644 tests/tcg/ppc64le/float_convd.ref
>>  create mode 100644 tests/tcg/ppc64le/meson.build
>>  delete mode 100644 tests/tcg/riscv64/Makefile.softmmu-target
>>  delete mode 100644 tests/tcg/riscv64/Makefile.target
>>  create mode 100644 tests/tcg/riscv64/float_convd.ref
>>  create mode 100644 tests/tcg/riscv64/float_convs.ref
>>  create mode 100644 tests/tcg/riscv64/float_madds.ref
>>  create mode 100644 tests/tcg/riscv64/meson.build
>>  create mode 100644 tests/tcg/riscv64/system/meson.build
>>  delete mode 100644 tests/tcg/s390x/Makefile.softmmu-target
>>  delete mode 100644 tests/tcg/s390x/Makefile.target
>>  create mode 100644 tests/tcg/s390x/float_convd.ref
>>  create mode 100644 tests/tcg/s390x/float_convs.ref
>>  create mode 100644 tests/tcg/s390x/float_madds.ref
>>  create mode 100644 tests/tcg/s390x/meson.build
>>  create mode 100644 tests/tcg/s390x/system/meson.build
>>  create mode 100755 tests/tcg/scripts/check_plugin_output.sh
>>  create mode 100755 tests/tcg/scripts/record_replay.sh
>>  create mode 100755 tests/tcg/scripts/run_and_check_forbidden_output.sh
>>  create mode 100755 tests/tcg/scripts/run_and_diff.sh
>>  create mode 100755 tests/tcg/scripts/run_with_input.sh
>>  delete mode 100644 tests/tcg/sh4/Makefile.target
>>  create mode 100644 tests/tcg/sh4/float_convd.ref
>>  create mode 100644 tests/tcg/sh4/float_convs.ref
>>  create mode 100644 tests/tcg/sh4/float_madds.ref
>>  create mode 100644 tests/tcg/sh4/meson.build
>>  delete mode 100644 tests/tcg/tricore/Makefile.softmmu-target
>>  delete mode 100644 tests/tcg/x86_64/Makefile.softmmu-target
>>  delete mode 100644 tests/tcg/x86_64/Makefile.target
>>  create mode 100644 tests/tcg/x86_64/float_madds.ref
>>  create mode 100644 tests/tcg/x86_64/meson.build
>>  create mode 100644 tests/tcg/x86_64/system/meson.build
>>  delete mode 100644 tests/tcg/xtensa/Makefile.softmmu-target
>>  create mode 100644 tests/tcg/xtensa/meson.build
>>  delete mode 100644 tests/tcg/xtensaeb/Makefile.softmmu-target
> 


