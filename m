Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAEDCC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 19:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whYPd-00040q-J3; Wed, 08 Jul 2026 15:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whYPc-000409-06
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 15:58:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whYPY-0003T0-00
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 15:58:27 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668GL5ij3304276
 for <qemu-devel@nongnu.org>; Wed, 8 Jul 2026 19:58:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U96ee1ZajSWHoJy/jjT9aVwAByMc+r9OfdDXrU5tC6Q=; b=Vhm372JvY6qS/il4
 R8UrjpqXLnD3DXe1K4pU0/sZJQtnkJ57EV2NLDhltro21KUqnjpjiSAmwSD0VrVm
 39JnpRN2UI4WDEexrxaQjAGg/2yLh6CMsRM/enKkGS2k8JwoL51s00k2zW4EkqlH
 AeK0m9sNpwDQ44Q2sGoclsuVb+Os7hpCpxUIaJVDhrNLHaOBTQvsV/b9lSHFB1iP
 DEZeF+eyioWLoKAXNfPREquauBMqhrM8UcmKPYjCJHFXfJJ0Tu/2buUWnw1IUJM2
 Z8/JS3FZWEuNZtmSZo9TjqVda5CiGzd95iC7nCi9csqdSUzI4/PjNjOceZ1czj1p
 E9UF4g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9rq318eu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 19:58:22 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c9151bf6ce7so135384a12.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 12:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783540701; x=1784145501; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=U96ee1ZajSWHoJy/jjT9aVwAByMc+r9OfdDXrU5tC6Q=;
 b=Ed2j2NSrloxTRdGPvWVJYsZC3HSb/AdNsVjOhCfuQPqoI+Upfh6SuVfW9O5JFqENto
 /6z3ZI8sT9bYzxEaWj1dpUf6PH4sSblZTLWIjtcWWjX52kAzXGUucIjqxn3KBbTN1AZM
 2K8yZIFYAFAF0BP75UOEBka8NBOFRR+5Al+Sp60INnnzTyU02ZDMm8M3jFTcpHjozoK3
 rJLw3a92UGP3S17U7R5b5cAHcNE3NVcgn3AhnHR+eUHBh2N0xf9QgzXsoaAbyvNIeNFq
 fhl4QdvRk+PJdcW+OxhDcJjQez1BgfaOL9endJ4q/vosD826+aSGGzBJoALHNdWjCNIX
 6iIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783540701; x=1784145501;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U96ee1ZajSWHoJy/jjT9aVwAByMc+r9OfdDXrU5tC6Q=;
 b=h1L65eTD+wG/NbU30xgx25uwuoE7KswiT4A8wfXuQ5ig9Q5u/viSLktCYS02vODaA9
 nKwi6rYbUyxIkKc0JTeIKmqIbXT7B5sdvj+pCX7anrrQsEdF21BONRzIefZvPUSjETBj
 yXHvYVMwPfwwImsP483PYoTgLZkkniudUvaumuXaHjt5gkEia5ZLaXi9f2a1nSBUEO3v
 iIpel2TDdEDor6qFwqJUouHQVReZY0X7QYGCSwnhFwiLT1TkL2/hXB3RL9WkY38/7Kdl
 TrqTdNDQpR/iiOPFIj7BazB+AEpYSR9guJTWnCjcp52D7ns7fARudaU+lvOBgEHF4Rrp
 ev0A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqJZ4yp/SWTLJV34Yud5DZDT66a3sB780B4K4JqgnOqyRB2qiUPbWRhPrABZqFbjTT7OZEqIpkoJ3y8@nongnu.org
X-Gm-Message-State: AOJu0Ywe4oDYfEwAWOtdGPeMKBF+g/tnAa0k7yjdd15+/tp4G6ACK2II
 XOZvaUENA3p/X9iyZWAk/xX+0b0GYwcMK4J08n7YjEBTYV582AoILoX9jN79WLeU5I+4KcUJ3RP
 qiq0OdoJhGAytxMipFERP6ZwYfLNb5vp8S6bRY9hNrw1oma4SIVCkN1zTsQ==
X-Gm-Gg: AfdE7cl8JBG/1z0ItCFxrqqWan9ZiqMgSgKLP2WH/NCheXKhRGr385SBAc07o2N6pDG
 qIaPlSeBCZyTEpnkwmgRr1IMblFt7jO62qLu909Y86Vv2u9YpnsCWgVRPzmIivvaamcf0UTgTE4
 duLVT1GYuTO0G4+pGitym++vXEB2hLWWcb6uhPjRQzmoaLTM/mhA/nsggTA4Tr0mrb4obxv0uf0
 lWpuFEUlvk36dExzX/I/8aOc1vd+d0E5mkzftPs8KsFzuXgAVzyKEXO4Qa+iPhDgM6gExXFMyWW
 AhtqpHv7joQmMtg41Jumu1CvuziqSEsyvvQt+Khq6bXNNCwpbpTF9snBOLtD6A8nijbTW0Ra+50
 69OrgbLRnm0m/7gIUppSwuhSsXrerjYsahY1poSSAsWbWzU3ZOc3hNYWxveFZR4/Ee9m1AXYf1G
 UKWEc=
X-Received: by 2002:a05:6a20:a105:b0:3c0:9c19:6584 with SMTP id
 adf61e73a8af0-3c0bcf97aecmr4954817637.62.1783540701094; 
 Wed, 08 Jul 2026 12:58:21 -0700 (PDT)
X-Received: by 2002:a05:6a20:a105:b0:3c0:9c19:6584 with SMTP id
 adf61e73a8af0-3c0bcf97aecmr4954761637.62.1783540700378; 
 Wed, 08 Jul 2026 12:58:20 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d87a2sm21491519c88.13.2026.07.08.12.58.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 12:58:19 -0700 (PDT)
Message-ID: <42e25b4d-b2fa-4674-ac62-e1163c9e2690@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 12:58:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/91] tests/tcg: run tests with meson
To: Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x <qemu-s390x@nongnu.org>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <ed40c4a1-3e15-4ca9-8287-602723cbf6a4@linux.ibm.com>
 <5e1aac59-63a8-4e5b-87f8-b9437dc44e61@oss.qualcomm.com>
 <f9053102-bdcd-4c09-be76-924056407bc3@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <f9053102-bdcd-4c09-be76-924056407bc3@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: YFPz0bd17Xnl7Z9c1CkYGxiuui4tfsFP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE5NiBTYWx0ZWRfX3xYamlZenvx8
 DwXvb6bNmG0viIeIhFNX9/m5xLXekUrE47rUV03XUuuWqy8e3R/XLpKTlnGwkw7DHgqnkIoFsGP
 VTYs87N7K7RxB8a1XJvwjB12L6G+6pNn+iVYsLtkCyk8EtETKY2rdycmOfL/F0WMBW5FspwWDZC
 oYQMLgNB6srP4F29Cj0Lc08F097jGY1a8htBtQiJMAQWpTOOgFNr0YdeONWpNnD1bjmex6uTjq/
 GYLtMMneRod0sgxSLrRs9rLi1CdgUD0+vlgO5aOUG6ObXI7g08BMhj/l/dLDXg7VQQ6LuFwqVMh
 3xH8wyGSUDs42ACP6iNLOlRhtef9244xkabGQi//0m5TNIXkpW0VcmHzwV5Su5FiHO13/M5/Xmx
 5ifd/hpSuwE5puZswd71Yj0kbLg0ZEudRhLrCXat446hH7YgPiTHXPoyT82JqogY+HOR1S9XUt/
 wn2gdPkMzgHeTSlw+Ow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE5NiBTYWx0ZWRfX1t9CIdgALwLo
 XbbF0dqxXsMKCx4pouWIIDE3K1K4nlBaVxnc7CXB2TkengP0Yvbvy1Hf7Qi5anOAlfiHzRKLTaa
 2ugZOHxr+20XZ8JcQbi3NhWgM3fBZP0=
X-Authority-Analysis: v=2.4 cv=PYPPQChd c=1 sm=1 tr=0 ts=6a4eabde cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=hR3j1kLqxibxIAXuA1sA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: YFPz0bd17Xnl7Z9c1CkYGxiuui4tfsFP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_03,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080196
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

On 7/8/2026 11:56 AM, Thomas Huth wrote:
> On 08/07/2026 18.25, Pierrick Bouvier wrote:
>> On 7/8/2026 5:09 AM, Ilya Leoshkevich wrote:
>>>
>>>
>>> On 7/7/26 00:32, Pierrick Bouvier wrote:
>>>> This series replaces TCG tests makefiles with meson, with the
>>>> goal of having something more readable and maintainable in the long
>>>> term.
>>>> Also it closes the gap that tcg tests had with the rest of tests, by
>>>> integrating
>>>> them with meson directly.
>>>>
>>>> It covers all existing tests for all architectures, including
>>>> user/system/multiarch-user/multiarch-system. It implements all
>>>> requirements
>>>> listed on original thread [1].
>>>>
>>>> [1] https://lore.kernel.org/qemu-devel/87wlwfsay4.fsf@draig.linaro.org/
>>>>
>>>> We also have for free:
>>>> - correct and complete dependencies for any test, including:
>>>>     scripts, c.inc, headers, reference files and binaries/plugins.
>>>> - catch test declaration issues at configure time vs test time.
>>>> - proper data types for variables instead of string expansion with
>>>> make.
>>>>
>>>> Series first introduce the meson machinery needed in tests/tcg/
>>>> meson.build, step
>>>> by step. Then it adds support for all existing archs. Finally, we
>>>> remove
>>>> Makefiles and configure bits.
>>>>
>>>> Usage:
>>>>
>>>> ```
>>>> make check-tcg
>>>> make check-tcg-aarch64-linux-user
>>>> make check-tcg-aarch64-softmmu
>>>>
>>>> make tcg-tests
>>>>
>>>> ninja clean
>>>> ./pyvenv/bin/meson test aarch64-softmmu-asid2 --verbose
>>>> ```
>>>>
>>>> A few items were left for further work (out of scope for this series):
>>>> - xtensaeb: didn't find how to cross compile for this architecture
>>>> with what we
>>>>     have now in container debian-xtensa-cross. Tips are welcome.
>>>> - tricore: implemented but reverted as all tests seem to hang. To be
>>>>     investigated.
>>>> - riscv64/interruptedmemory.S is hanging. To be investigated.
>>>> - i386/test-i386-fprem.c is deactivated for now. It's broken (output
>>>> does not
>>>>     match bare metal result) and is the slowest test we have. To be
>>>> refactored and
>>>>     fixed.
>>>>
>>>> v3
>>>> -- 
>>>>
>>>> - add all architectures
>>>> - reduce number of plugins tests (only add one test for each plugin
>>>> from
>>>>     multiarch pool)
>>>> - add depends for executable - allow to depend on a custom target for
>>>> generated
>>>>     headers (x86_64 mmx, avx)
>>>> - add new tests added since last version for aarch64 (mte + gpc)
>>>> - refactor series to keep all arch files at end
>>>> - add docker host architecture selection
>>>>
>>>> v2
>>>> -- 
>>>>
>>>> - s/mispell/misspell
>>>> - moved comment about why we remove 'lib' prefix for plugins
>>>> - if user declare a wrong entry in a dictionary, list possible keys
>>>> - build tests by default (with 'all' target), as long as cross
>>>> compiler is
>>>>     natively installed, to avoid triggering a container build.
>>>> - reword some comments based on reviewers feedback
>>>> - always declare all tests and avoid "per config" errors (no 'if' in
>>>> arch files)
>>>> - move compiler feature and gdb version checks directly in tests/tcg/
>>>> meson.build
>>>> - add support for cross containers
>>>> - add top target 'tcg-tests' to rebuild all tests
>>>>
>>>> Pierrick Bouvier (91):
>>>>     tests/tcg/multiarch/system/memory.c: remove unused variable
>>>>     tests/tcg/multiarch/plugin/check-plugin-output.sh: take test
>>>> output as
>>>>       input
>>>>     tests/tcg/multiarch/plugin: rename check-plugin-output to
>>>>       regex-compare
>>>>     tests/tcg: introduce meson.build
>>>>     tests/tcg/meson.build: introduce exe_name
>>>>     tests/tcg/meson.build: introduce test_name
>>>>     tests/tcg/meson.build: introduce cflags
>>>>     tests/tcg/meson.build: introduce qemu_args
>>>>     tests/tcg/meson.build: introduce env_var
>>>>     tests/tcg/plugins: build list of test_plugins
>>>>     tests/tcg/meson.build: introduce plugin_test
>>>>     tests/tcg/meson.build: test gdb support and introduce gdb_arch
>>>>     tests/tcg/meson.build: introduce gdb_test
>>>>     tests/tcg/meson.build: add default flag for testing compiler
>>>> support
>>>>     tests/tcg/meson.build: introduce wrapper
>>>>     tests/tcg/meson.build: introduce expected_output
>>>>     tests/tcg/meson.build: add wrapper run_and_check_forbidden_output
>>>>     tests/tcg/meson.build: add wrapper run_with_input
>>>>     tests/tcg/meson.build: add wrapper record_replay
>>>>     tests/tcg/meson.build: add wrapper check_plugin_output
>>>>     tests/tcg/meson.build: add logic to skip tests
>>>>     tests/tcg/meson.build: introduce cc_feat and cc_feat_cflags
>>>>     tests/tcg/meson.build: introduce gdb_feat and gdb_feat_version
>>>>     tests/tcg/meson.build: move gdb_arch support check
>>>>     tests/tcg/meson.build: let test infrastructure detect compiler
>>>>     tests/docker/docker.py: return error code if probe fails
>>>>     tests/docker/docker.py: remove "Image is up to date" info
>>>>     tests/tcg/meson.build: introduce cc_dockerfile and cc_docker_arch
>>>>     tests/tcg/meson.build: introduce depends
>>>>     tests/tcg/meson.build: add top-level 'tcg-tests' target
>>>>     tests/tcg/multiarch: declare user tests
>>>>     tests/tcg/multiarch: declare system tests
>>>>     tests/tcg/meson.build: add generic plugin tests
>>>>     tests/tcg/aarch64: user tests
>>>>     tests/tcg/aarch64/system/gpc-test.c: remove unused variables
>>>>     tests/tcg/aarch64: system tests
>>>>     tests/tcg/aarch64_be: user tests
>>>>     tests/tcg/alpha: add float reference files
>>>>     tests/tcg/alpha: user tests
>>>>     tests/tcg/alpha: system tests
>>>>     tests/tcg/arm: user tests
>>>>     tests/tcg/arm: system tests
>>>>     tests/tcg/hexagon/overflow.c: add missing include
>>>>     tests/tcg/hexagon: user tests
>>>>     tests/tcg/multiarch/sha1.c: fix big endian implementation
>>>>     tests/tcg/hppa: add float reference files
>>>>     tests/tcg/hppa: user tests
>>>>     tests/tcg/i386: add missing float reference files
>>>>     tests/tcg/i386: user tests
>>>>     tests/tcg/i386: system tests
>>>>     tests/tcg/loongarch64: user tests
>>>>     tests/tcg/loongarch64: system tests
>>>>     tests/tcg/m68k: add float reference files
>>>>     tests/tcg/m68k: user tests
>>>>     scripts/probe-gdb-support.py: add mapping for mips architecture
>>>>     tests/tcg/mips: add float reference files
>>>>     test/tcg/mips: user tests
>>>>     tests/tcg/mips64: add float reference files
>>>>     tests/tcg/mips64: user tests
>>>>     tests/tcg/mips64el: add float reference files
>>>>     tests/tcg/mips64el: user tests
>>>>     tests/docker/dockerfiles/debian-all-test-cross.docker: add or1k
>>>>       toolchain
>>>>     tests/tcg/or1k/test_addic.c: remove unused variables
>>>>     tests/tcg/or1k/test_muli.c: remove set but unused variable
>>>>     tests/tcg/or1k: add float reference files
>>>>     plugins/api.c: identify or1k pc register and mark it as read only
>>>>     tests/tcg/or1k: user tests
>>>>     tests/tcg/ppc64: add float reference files
>>>>     tests/tcg/ppc64: remove dependency on qemu/compiler.h
>>>>     tests/tcg/ppc64: user tests
>>>>     tests/tcg/ppc64le: add missing float reference file
>>>>     tests/tcg/ppc64le: user tests
>>>>     tests/tcg/riscv64: add float reference files
>>>>     tests/tcg/riscv64: user tests
>>>>     tests/tcg/riscv64: system tests
>>>>     tests/tcg/s390x/head64.S: declare _exit symbol after main
>>>>     tests/tcg/s390x: add float reference files
>>>>     tests/tcg/s390x: user tests
>>>>     tests/tcg/s390x: system tests
>>>>     tests/tcg/sh4: add float reference files
>>>>     tests/tcg/sh4: user tests
>>>>     tests/tcg/tricore: system tests
>>>>     Revert "tests/tcg/tricore: system tests"
>>>>     tests/tcg/x86_64: add missing float reference file
>>>>     tests/tcg/x86_64: user tests
>>>>     tests/tcg/x86_64: system tests
>>>>     tests/tcg/xtensa/crt.S: align .text section
>>>>     tests/tcg/xtensa: system tests
>>>>     tests: remove tcg tests machinery
>>>>     tests/tcg: remove Makefiles
>>>>     configure: remove --cross-cc* options
>>>>
>>>>    configure                                     | 473 ---------
>>>>    docs/devel/testing/main.rst                   |  22 +-
>>>>    plugins/api.c                                 |   2 +
>>>>    scripts/probe-gdb-support.py                  |   1 +
>>>>    tests/Makefile.include                        |  68 +-
>>>>    tests/docker/docker.py                        |   4 +-
>>>>    .../dockerfiles/debian-all-test-cross.docker  |  16 +-
>>>>    tests/lcitool/refresh                         | 107 +-
>>>>    tests/meson.build                             |   2 +-
>>>>    tests/tcg/Makefile.target                     | 281 -----
>>>>    tests/tcg/aarch64/Makefile.softmmu-target     | 147 ---
>>>>    tests/tcg/aarch64/Makefile.target             | 198 ----
>>>>    tests/tcg/aarch64/meson.build                 | 195 ++++
>>>>    tests/tcg/aarch64/system/gpc-test.c           |   5 -
>>>>    tests/tcg/aarch64/system/meson.build          | 108 ++
>>>>    tests/tcg/aarch64_be/Makefile.target          |  17 -
>>>>    tests/tcg/aarch64_be/meson.build              |  22 +
>>>>    tests/tcg/alpha/Makefile.softmmu-target       |  34 -
>>>>    tests/tcg/alpha/Makefile.target               |  18 -
>>>>    tests/tcg/alpha/float_convd.ref               | 988 +++++++++++++
>>>> +++++
>>>>    tests/tcg/alpha/float_convs.ref               | 748 +++++++++++++
>>>>    tests/tcg/alpha/float_madds.ref               | 768 ++++++++++++++
>>>>    tests/tcg/alpha/meson.build                   |  55 +
>>>>    tests/tcg/alpha/system/meson.build            |  46 +
>>>>    tests/tcg/arm/Makefile.softmmu-target         |  80 --
>>>>    tests/tcg/arm/Makefile.target                 |  87 --
>>>>    tests/tcg/arm/meson.build                     |  80 ++
>>>>    tests/tcg/arm/system/meson.build              |  66 ++
>>>>    tests/tcg/hexagon/Makefile.target             | 146 ---
>>>>    tests/tcg/hexagon/meson.build                 | 111 ++
>>>>    tests/tcg/hexagon/overflow.c                  |   1 +
>>>>    tests/tcg/hppa/Makefile.target                |  14 -
>>>>    tests/tcg/hppa/float_convd.ref                | 988 +++++++++++++
>>>> +++++
>>>>    tests/tcg/hppa/float_convs.ref                | 748 +++++++++++++
>>>>    tests/tcg/hppa/float_madds.ref                | 768 ++++++++++++++
>>>>    tests/tcg/hppa/meson.build                    |  22 +
>>>>    tests/tcg/i386/Makefile.softmmu-target        |  37 -
>>>>    tests/tcg/i386/Makefile.target                | 102 --
>>>>    tests/tcg/i386/float_convd.conf               | 988
>>>> ------------------
>>>>    tests/tcg/i386/float_convd.ref                | 988 +++++++++++++
>>>> +++++
>>>>    tests/tcg/i386/float_madds.ref                | 768 ++++++++++++++
>>>>    tests/tcg/i386/meson.build                    |  58 +
>>>>    tests/tcg/i386/system/meson.build             |  48 +
>>>>    tests/tcg/loongarch64/Makefile.softmmu-target |  33 -
>>>>    tests/tcg/loongarch64/Makefile.target         |  20 -
>>>>    tests/tcg/loongarch64/meson.build             |  32 +
>>>>    tests/tcg/loongarch64/system/meson.build      |  47 +
>>>>    tests/tcg/m68k/Makefile.target                |   7 -
>>>>    tests/tcg/m68k/float_convd.ref                | 988 +++++++++++++
>>>> +++++
>>>>    tests/tcg/m68k/float_convs.ref                | 748 +++++++++++++
>>>>    tests/tcg/m68k/float_madds.ref                | 768 ++++++++++++++
>>>>    tests/tcg/m68k/meson.build                    |  23 +
>>>>    tests/tcg/meson.build                         | 447 ++++++++
>>>>    tests/tcg/minilib/Makefile.target             |  21 -
>>>>    tests/tcg/mips/Makefile.target                |  19 -
>>>>    tests/tcg/mips/float_convd.ref                | 988 +++++++++++++
>>>> +++++
>>>>    tests/tcg/mips/float_convs.ref                | 748 +++++++++++++
>>>>    tests/tcg/mips/float_madds.ref                | 768 ++++++++++++++
>>>>    tests/tcg/mips/meson.build                    |  25 +
>>>>    tests/tcg/mips/user/ase/dsp/Makefile          | 184 ----
>>>>    tests/tcg/mips/user/isa/mips64r6/crc/Makefile |  40 -
>>>>    tests/tcg/mips/user/isa/r5900/Makefile        |  32 -
>>>>    tests/tcg/mips64/Makefile.target              |  20 -
>>>>    tests/tcg/mips64/float_convd.ref              | 988 +++++++++++++
>>>> +++++
>>>>    tests/tcg/mips64/float_convs.ref              | 748 +++++++++++++
>>>>    tests/tcg/mips64/float_madds.ref              | 768 ++++++++++++++
>>>>    tests/tcg/mips64/meson.build                  |  27 +
>>>>    tests/tcg/mips64el/Makefile.target            |   8 -
>>>>    tests/tcg/mips64el/float_convd.ref            | 988 +++++++++++++
>>>> +++++
>>>>    tests/tcg/mips64el/float_convs.ref            | 748 +++++++++++++
>>>>    tests/tcg/mips64el/float_madds.ref            | 768 ++++++++++++++
>>>>    tests/tcg/mips64el/meson.build                |  14 +
>>>>    tests/tcg/multiarch/Makefile.target           | 233 -----
>>>>    tests/tcg/multiarch/meson.build               | 149 +++
>>>>    .../multiarch/plugin/check-plugin-output.sh   |  36 -
>>>>    tests/tcg/multiarch/plugin/regex-compare.sh   |  28 +
>>>>    tests/tcg/multiarch/sha1.c                    |   4 +-
>>>>    tests/tcg/multiarch/sha1.ref                  |   1 +
>>>>    .../multiarch/system/Makefile.softmmu-target  |  81 --
>>>>    tests/tcg/multiarch/system/memory.c           |   3 +-
>>>>    tests/tcg/multiarch/system/meson.build        |  53 +
>>>>    tests/tcg/or1k/Makefile                       |  71 --
>>>>    tests/tcg/or1k/float_convd.ref                | 247 +++++
>>>>    tests/tcg/or1k/float_convs.ref                | 187 ++++
>>>>    tests/tcg/or1k/float_madds.ref                | 192 ++++
>>>>    tests/tcg/or1k/meson.build                    |  72 ++
>>>>    tests/tcg/or1k/test_addic.c                   |   2 +-
>>>>    tests/tcg/or1k/test_muli.c                    |   5 +-
>>>>    tests/tcg/plugins/meson.build                 |  11 +-
>>>>    tests/tcg/ppc64/Makefile.target               |  63 --
>>>>    tests/tcg/ppc64/float_convd.ref               | 988 +++++++++++++
>>>> +++++
>>>>    tests/tcg/ppc64/float_convs.ref               | 748 +++++++++++++
>>>>    tests/tcg/ppc64/float_madds.ref               | 768 ++++++++++++++
>>>>    tests/tcg/ppc64/meson.build                   |  56 +
>>>>    tests/tcg/ppc64/vector.c                      |  11 +-
>>>>    tests/tcg/ppc64/vsx_f2i_nan.c                 |   7 +-
>>>>    tests/tcg/ppc64le/Makefile.target             |   7 -
>>>>    tests/tcg/ppc64le/float_convd.ref             | 988 +++++++++++++
>>>> +++++
>>>>    tests/tcg/ppc64le/meson.build                 |  14 +
>>>>    tests/tcg/riscv64/Makefile.softmmu-target     |  45 -
>>>>    tests/tcg/riscv64/Makefile.target             |  20 -
>>>>    tests/tcg/riscv64/float_convd.ref             | 988 +++++++++++++
>>>> +++++
>>>>    tests/tcg/riscv64/float_convs.ref             | 748 +++++++++++++
>>>>    tests/tcg/riscv64/float_madds.ref             | 768 ++++++++++++++
>>>>    tests/tcg/riscv64/meson.build                 |  38 +
>>>>    tests/tcg/riscv64/system/meson.build          |  38 +
>>>>    tests/tcg/s390x/Makefile.softmmu-target       |  57 -
>>>>    tests/tcg/s390x/Makefile.target               | 127 ---
>>>>    tests/tcg/s390x/float_convd.ref               | 988 +++++++++++++
>>>> +++++
>>>>    tests/tcg/s390x/float_convs.ref               | 748 +++++++++++++
>>>>    tests/tcg/s390x/float_madds.ref               | 768 ++++++++++++++
>>>>    tests/tcg/s390x/head64.S                      |   2 +
>>>>    tests/tcg/s390x/meson.build                   | 140 +++
>>>>    tests/tcg/s390x/system/meson.build            |  92 ++
>>>>    tests/tcg/scripts/check_plugin_output.sh      |  25 +
>>>>    tests/tcg/scripts/record_replay.sh            |  16 +
>>>>    .../scripts/run_and_check_forbidden_output.sh |  19 +
>>>>    tests/tcg/scripts/run_and_diff.sh             |  15 +
>>>>    tests/tcg/scripts/run_with_input.sh           |  12 +
>>>>    tests/tcg/sh4/Makefile.target                 |  18 -
>>>>    tests/tcg/sh4/float_convd.ref                 | 494 +++++++++
>>>>    tests/tcg/sh4/float_convs.ref                 | 374 +++++++
>>>>    tests/tcg/sh4/float_madds.ref                 | 384 +++++++
>>>>    tests/tcg/sh4/meson.build                     |  25 +
>>>>    tests/tcg/tricore/Makefile.softmmu-target     |  53 -
>>>>    tests/tcg/x86_64/Makefile.softmmu-target      |  44 -
>>>>    tests/tcg/x86_64/Makefile.target              |  40 -
>>>>    tests/tcg/x86_64/float_madds.ref              | 768 ++++++++++++++
>>>>    tests/tcg/x86_64/meson.build                  |  83 ++
>>>>    tests/tcg/x86_64/system/meson.build           |  62 ++
>>>>    tests/tcg/xtensa/Makefile.softmmu-target      |  46 -
>>>>    tests/tcg/xtensa/crt.S                        |   1 +
>>>>    tests/tcg/xtensa/meson.build                  |  89 ++
>>>>    tests/tcg/xtensaeb/Makefile.softmmu-target    |   5 -
>>>>    134 files changed, 30491 insertions(+), 4114 deletions(-)
>>>>    delete mode 100644 tests/tcg/Makefile.target
>>>>    delete mode 100644 tests/tcg/aarch64/Makefile.softmmu-target
>>>>    delete mode 100644 tests/tcg/aarch64/Makefile.target
>>>>    create mode 100644 tests/tcg/aarch64/meson.build
>>>>    create mode 100644 tests/tcg/aarch64/system/meson.build
>>>>    delete mode 100644 tests/tcg/aarch64_be/Makefile.target
>>>>    create mode 100644 tests/tcg/aarch64_be/meson.build
>>>>    delete mode 100644 tests/tcg/alpha/Makefile.softmmu-target
>>>>    delete mode 100644 tests/tcg/alpha/Makefile.target
>>>>    create mode 100644 tests/tcg/alpha/float_convd.ref
>>>>    create mode 100644 tests/tcg/alpha/float_convs.ref
>>>>    create mode 100644 tests/tcg/alpha/float_madds.ref
>>>>    create mode 100644 tests/tcg/alpha/meson.build
>>>>    create mode 100644 tests/tcg/alpha/system/meson.build
>>>>    delete mode 100644 tests/tcg/arm/Makefile.softmmu-target
>>>>    delete mode 100644 tests/tcg/arm/Makefile.target
>>>>    create mode 100644 tests/tcg/arm/meson.build
>>>>    create mode 100644 tests/tcg/arm/system/meson.build
>>>>    delete mode 100644 tests/tcg/hexagon/Makefile.target
>>>>    create mode 100644 tests/tcg/hexagon/meson.build
>>>>    delete mode 100644 tests/tcg/hppa/Makefile.target
>>>>    create mode 100644 tests/tcg/hppa/float_convd.ref
>>>>    create mode 100644 tests/tcg/hppa/float_convs.ref
>>>>    create mode 100644 tests/tcg/hppa/float_madds.ref
>>>>    create mode 100644 tests/tcg/hppa/meson.build
>>>>    delete mode 100644 tests/tcg/i386/Makefile.softmmu-target
>>>>    delete mode 100644 tests/tcg/i386/Makefile.target
>>>>    delete mode 100644 tests/tcg/i386/float_convd.conf
>>>>    create mode 100644 tests/tcg/i386/float_convd.ref
>>>>    create mode 100644 tests/tcg/i386/float_madds.ref
>>>>    create mode 100644 tests/tcg/i386/meson.build
>>>>    create mode 100644 tests/tcg/i386/system/meson.build
>>>>    delete mode 100644 tests/tcg/loongarch64/Makefile.softmmu-target
>>>>    delete mode 100644 tests/tcg/loongarch64/Makefile.target
>>>>    create mode 100644 tests/tcg/loongarch64/meson.build
>>>>    create mode 100644 tests/tcg/loongarch64/system/meson.build
>>>>    delete mode 100644 tests/tcg/m68k/Makefile.target
>>>>    create mode 100644 tests/tcg/m68k/float_convd.ref
>>>>    create mode 100644 tests/tcg/m68k/float_convs.ref
>>>>    create mode 100644 tests/tcg/m68k/float_madds.ref
>>>>    create mode 100644 tests/tcg/m68k/meson.build
>>>>    create mode 100644 tests/tcg/meson.build
>>>>    delete mode 100644 tests/tcg/minilib/Makefile.target
>>>>    delete mode 100644 tests/tcg/mips/Makefile.target
>>>>    create mode 100644 tests/tcg/mips/float_convd.ref
>>>>    create mode 100644 tests/tcg/mips/float_convs.ref
>>>>    create mode 100644 tests/tcg/mips/float_madds.ref
>>>>    create mode 100644 tests/tcg/mips/meson.build
>>>>    delete mode 100644 tests/tcg/mips/user/ase/dsp/Makefile
>>>>    delete mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/Makefile
>>>>    delete mode 100644 tests/tcg/mips/user/isa/r5900/Makefile
>>>>    delete mode 100644 tests/tcg/mips64/Makefile.target
>>>>    create mode 100644 tests/tcg/mips64/float_convd.ref
>>>>    create mode 100644 tests/tcg/mips64/float_convs.ref
>>>>    create mode 100644 tests/tcg/mips64/float_madds.ref
>>>>    create mode 100644 tests/tcg/mips64/meson.build
>>>>    delete mode 100644 tests/tcg/mips64el/Makefile.target
>>>>    create mode 100644 tests/tcg/mips64el/float_convd.ref
>>>>    create mode 100644 tests/tcg/mips64el/float_convs.ref
>>>>    create mode 100644 tests/tcg/mips64el/float_madds.ref
>>>>    create mode 100644 tests/tcg/mips64el/meson.build
>>>>    delete mode 100644 tests/tcg/multiarch/Makefile.target
>>>>    create mode 100644 tests/tcg/multiarch/meson.build
>>>>    delete mode 100755 tests/tcg/multiarch/plugin/check-plugin-output.sh
>>>>    create mode 100755 tests/tcg/multiarch/plugin/regex-compare.sh
>>>>    create mode 100644 tests/tcg/multiarch/sha1.ref
>>>>    delete mode 100644 tests/tcg/multiarch/system/Makefile.softmmu-
>>>> target
>>>>    create mode 100644 tests/tcg/multiarch/system/meson.build
>>>>    delete mode 100644 tests/tcg/or1k/Makefile
>>>>    create mode 100644 tests/tcg/or1k/float_convd.ref
>>>>    create mode 100644 tests/tcg/or1k/float_convs.ref
>>>>    create mode 100644 tests/tcg/or1k/float_madds.ref
>>>>    create mode 100644 tests/tcg/or1k/meson.build
>>>>    delete mode 100644 tests/tcg/ppc64/Makefile.target
>>>>    create mode 100644 tests/tcg/ppc64/float_convd.ref
>>>>    create mode 100644 tests/tcg/ppc64/float_convs.ref
>>>>    create mode 100644 tests/tcg/ppc64/float_madds.ref
>>>>    create mode 100644 tests/tcg/ppc64/meson.build
>>>>    delete mode 100644 tests/tcg/ppc64le/Makefile.target
>>>>    create mode 100644 tests/tcg/ppc64le/float_convd.ref
>>>>    create mode 100644 tests/tcg/ppc64le/meson.build
>>>>    delete mode 100644 tests/tcg/riscv64/Makefile.softmmu-target
>>>>    delete mode 100644 tests/tcg/riscv64/Makefile.target
>>>>    create mode 100644 tests/tcg/riscv64/float_convd.ref
>>>>    create mode 100644 tests/tcg/riscv64/float_convs.ref
>>>>    create mode 100644 tests/tcg/riscv64/float_madds.ref
>>>>    create mode 100644 tests/tcg/riscv64/meson.build
>>>>    create mode 100644 tests/tcg/riscv64/system/meson.build
>>>>    delete mode 100644 tests/tcg/s390x/Makefile.softmmu-target
>>>>    delete mode 100644 tests/tcg/s390x/Makefile.target
>>>>    create mode 100644 tests/tcg/s390x/float_convd.ref
>>>>    create mode 100644 tests/tcg/s390x/float_convs.ref
>>>>    create mode 100644 tests/tcg/s390x/float_madds.ref
>>>>    create mode 100644 tests/tcg/s390x/meson.build
>>>>    create mode 100644 tests/tcg/s390x/system/meson.build
>>>>    create mode 100755 tests/tcg/scripts/check_plugin_output.sh
>>>>    create mode 100755 tests/tcg/scripts/record_replay.sh
>>>>    create mode 100755 tests/tcg/scripts/
>>>> run_and_check_forbidden_output.sh
>>>>    create mode 100755 tests/tcg/scripts/run_and_diff.sh
>>>>    create mode 100755 tests/tcg/scripts/run_with_input.sh
>>>>    delete mode 100644 tests/tcg/sh4/Makefile.target
>>>>    create mode 100644 tests/tcg/sh4/float_convd.ref
>>>>    create mode 100644 tests/tcg/sh4/float_convs.ref
>>>>    create mode 100644 tests/tcg/sh4/float_madds.ref
>>>>    create mode 100644 tests/tcg/sh4/meson.build
>>>>    delete mode 100644 tests/tcg/tricore/Makefile.softmmu-target
>>>>    delete mode 100644 tests/tcg/x86_64/Makefile.softmmu-target
>>>>    delete mode 100644 tests/tcg/x86_64/Makefile.target
>>>>    create mode 100644 tests/tcg/x86_64/float_madds.ref
>>>>    create mode 100644 tests/tcg/x86_64/meson.build
>>>>    create mode 100644 tests/tcg/x86_64/system/meson.build
>>>>    delete mode 100644 tests/tcg/xtensa/Makefile.softmmu-target
>>>>    create mode 100644 tests/tcg/xtensa/meson.build
>>>>    delete mode 100644 tests/tcg/xtensaeb/Makefile.softmmu-target
>>>>
>>>
>>> Seems like something is wrong with cross-compiler detection now.
>>> On Fedora I get:
>>>
>>> FAILED: tests/tcg/s390x-softmmu-memory.test
>>> /usr/lib64/ccache/s390x-linux-gnu-gcc /mnt/root/home/iii/qemu-
>>> worktrees/20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com/
>>> tests/tcg/multiarch/system/memory.c -o tests/tcg/s390x-softmmu-
>>> memory.test -static -MMD -MF tests/tcg/s390x-softmmu-memory.d -Wall -
>>> Werror -O0 -g -fno-strict-aliasing -nostdlib -I /mnt/root/home/iii/qemu-
>>> worktrees/20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com/
>>> tests/tcg/s390x/system/../../minilib /mnt/root/home/iii/qemu-
>>> worktrees/20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com/
>>> tests/tcg/s390x/system/../../minilib/printf.c -I /mnt/root/home/iii/
>>> qemu-worktrees/20260706223343.988769-1-
>>> pierrick.bouvier@oss.qualcomm.com/include/hw/s390x/ipl -I /mnt/root/
>>> home/iii/qemu-worktrees/20260706223343.988769-1-
>>> pierrick.bouvier@oss.qualcomm.com/roms/SLOF/lib/libc/include -
>>> march=z13 ../tests/tcg/s390x/system/../head64.S ../tests/tcg/s390x/
>>> system/../console.c -DCHECK_UNALIGNED=0
>>> In file included from /mnt/root/home/iii/qemu-
>>> worktrees/20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com/
>>> tests/tcg/multiarch/system/memory.c:15:
>>> /usr/lib/gcc/s390x-linux-gnu/15/include/stdint.h:11:16: fatal error:
>>> stdint.h: No such file or directory
>>>     11 | # include_next <stdint.h>
>>>        |                ^~~~~~~~~~
>>>
>>> The cross-compiler situation on Fedora is that they ship the
>>> cross-compiler itself, but no userspace headers, so it's usable
>>> only for kernel builds. In this case QEMU should fall back to Docker,
>>> which works for me on master, but not with this series.
>>
>> Thanks for the report. I just tried that on debian for now.
>>
>> Also, for s390x, I noticed that some tests are relying on roms/SLOF/...
>> headers, which are not available if submodules are not initialized.
>> Probably another corner case to cover.
> We've got some logic in the configure script that should always
> initialize the roms/SLOF submodule when you build the s390x target:
> 
> if have_target s390x-softmmu && probe_target_compiler s390x-softmmu && \
>     GIT=git "$source_path/scripts/git-submodule.sh"
> "$git_submodules_action" roms/SLOF >> config.log 2>&1; then
> 
> Is that failing in your case?
>

The latest commits remove all those configure steps to use meson directly.

I solved it by adding the memcpy and memset definition directly in
console.c to remove the dependency on roms/SLOF.

>  Thomas
> 

Regards,
Pierrick

