Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06AF2C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 16:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whrrb-0005Qt-A2; Thu, 09 Jul 2026 12:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whrra-0005Qk-Nd
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:44:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whrrY-00046H-ME
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:44:38 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669DvwGb2001943
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 16:44:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BAKemxnwRXzDc6zVDxQfWj+RauFM3CiOuBb6+0UEyIs=; b=JpZqcrFlsEWQ0QmR
 xieNZGbHwnJLfPhIWAoC0GSw8GcIHM4rb7ldPgjk/GR6mHHWFvLtqqxgxQS2lUBD
 xhdIdctdeg/+xu+tXgVrPGED6T/YB8gqX07ZY5c6c9D5hdNvPV3z+9dLHF9AUX2k
 M9U8FgsHVidcAsDDoLKsPyTDJQcpo52JBfLLNh5m+0qTEQ32ioYBTEpyhzW2yHVR
 hGJIvX+HZ3b8UZX4p++LSrpnPhXxKd7+Gurj1fYDeR3/t2drCL0LjG+wmkYSmD+T
 BNKlmP0uVyFNSQAkjNUwp1M/wLrEge83qdR2+4ooaA3TdGC+EgT3VKm+qeMe7HYJ
 I4Gf5g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa6p3ttb7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 16:44:34 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cae455cf6dso32817455ad.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 09:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783615474; x=1784220274; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BAKemxnwRXzDc6zVDxQfWj+RauFM3CiOuBb6+0UEyIs=;
 b=XGsEH+FRU99STszLdSkzuNIPENhwWkB7E+IlyVMYN9xYpwquvVmXZYVq3l2lVTZys+
 cmQSZ/FG8uSWNyS3kAIZUgvJtl09dyTXTly1b6AEAMsSf0GRdgrOC+p1QaIPwIt8K8qc
 Ka/fPHb36+8l8T8QTcszSokqkYd/hrYnAqvrgGvfJhBS3qhpoZWiJf/0gSfBcWa5z6fq
 rcqzTzskzxr17nTqjmIMBb6ymtRhT7lcQfZfnhelqoEz6otv13P+0UjX+GwAFOngxGpB
 UpznNwOIrVpY6oIwbY9BJccUp0Lc9TauPEPTS0DUkYpIv+ZnFE/jgW80cQ+bsgxjloLB
 yg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783615474; x=1784220274;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BAKemxnwRXzDc6zVDxQfWj+RauFM3CiOuBb6+0UEyIs=;
 b=dGMGtw0Bvsp27M2882g0NlF5KdRFxBCC42Jy+gwcxvoRHAXDGovAw1E9HCFdz7AnHn
 Ft3g3q+H4S3fQ0Oeo89eDEccE9f5STMW72VnJj1p6QR5qHqCkCrrWaLqX3Z5XYXrNPlL
 amA9WIcF6ZVuugYWNwByQ2Ts6NK3A/iulLcbtxXUbC/Pz2MQZ+lOiP5MIWOIro6LHkJi
 SYtxz0S9cnbxktw1xLiyHoecmmu3LH49MLa6y5e+ccax3U8yauCu2tci92Oxi+kDNiWt
 fhviSg4u6Qr4JDZzEPGw6IJMUE1do9DgEA+UGVMGZfkLvMYGeD8p/kvj4qtiKNNCcrXy
 300A==
X-Gm-Message-State: AOJu0YwsFPMnei71o8DFibN65MPpACScXAcaCYA+3BoVJWqtWJABntdG
 Wi5l28Exth4OdTsLcoWITmF60IHNDt8wEoncR3PLNrqlAYpGi04o5NnnKWdLXRbMj5GAB+81oeJ
 a1/zjt3ggVfK8w8UWsQrrBXjqRUhRoYWIDJFICAops0ko+gYG6rix7awStQ==
X-Gm-Gg: AfdE7cnx73XfCIaZVPzqxjeehNM/OhnotIXUZC7g15iHoWIzcvSsopfg+u+uaoY+Y2o
 xCsxQUbgmkGVeBmipWMsjMW5gi3Bk8mE2WAhV11jyEYkW5DvhGPIWs0jjct80jQvao5N92+1ZoW
 LcNpHDYPQEiPUWNvr17QO2AKbDTWXVL2459Gi+57QXp41abJc4gPUAEasQO8dcCEYaZm4wEMkxE
 fEe/apEa6KXoCe9+QUDr192UiAUr9XUS5DcEEJ78eE1WKAfBpLoAuvMN3yEI0HgUCvD7QvV3j35
 o63k2IiKKqz88J0rE4oGJHr5aYHFbOtc+bNBI2FupLyZsRAzgVwagm6DPT4aU1/NwrkSVGu+IhN
 pXQ8O5OqgDMaRwyWhe8dBT3Dj+jYxBs5Fpe/nf+aI8nsluQZEateheGR5uoMQAJr3LsiNN0lBw+
 tLvA0=
X-Received: by 2002:a17:903:32c9:b0:2ca:e9dc:7357 with SMTP id
 d9443c01a7336-2ccea2d8029mr85404175ad.9.1783615474079; 
 Thu, 09 Jul 2026 09:44:34 -0700 (PDT)
X-Received: by 2002:a17:903:32c9:b0:2ca:e9dc:7357 with SMTP id
 d9443c01a7336-2ccea2d8029mr85403945ad.9.1783615473598; 
 Thu, 09 Jul 2026 09:44:33 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc99cc5aasm47497235ad.0.2026.07.09.09.44.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 09:44:33 -0700 (PDT)
Message-ID: <b4f09684-06e7-40c6-9d3f-7dfc8c71423f@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 09:44:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/91] tests/tcg/meson.build: add wrapper record_replay
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
 <20260706223343.988769-20-pierrick.bouvier@oss.qualcomm.com>
 <87echcrzah.fsf@draig.linaro.org>
 <41fb9818-b18f-4deb-889c-e1847293a3f0@oss.qualcomm.com>
 <decd7f0d-fd74-4314-8a44-df9f7a75d8d5@oss.qualcomm.com>
 <878q7krvju.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <878q7krvju.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: c7zKSD3zIM8kA8TIQu_U5o9gTkwYtbiR
X-Proofpoint-GUID: c7zKSD3zIM8kA8TIQu_U5o9gTkwYtbiR
X-Authority-Analysis: v=2.4 cv=TPh1jVla c=1 sm=1 tr=0 ts=6a4fcff2 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=L1gDOh7HvEhQyT2m31UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE2NCBTYWx0ZWRfXw7EM38p93dVo
 qucm2fqirRK/0cwA3HP2rxDXikkGcdOZB7P4k0DK+pdOoaEdG2vJs8S9t0URzf+2eJ7S4BmAl9c
 k7lctDjFZ0DjKY1kJMtW2iW3tzW96nY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE2NCBTYWx0ZWRfX+mGhKgacB/Ng
 tr5XhpAFiLMoY+M2Rasyp4Mcy6Z//nqXNjQDOlSziwxzEUUEwNwGFUVWSHKhqCrUULxzNLR5Qbi
 TdcSZcuDnxSJvxEq03L1h3rtpa1bfDzvC14GeZQCxw/qbJQMvQKahcnoEAL3sn1k1cXvUVq4ARQ
 W9rtFwsluIUG7GStSjptD43UtdncmeqlA4qpU82YEsfokc6ypkaehRe1Nn1rYh3S+Tx1qGw1Y1L
 XSqhhSurarjhzurX3ThApH2vBb/rnMFGltOmLacVo6MqvqjwJD3bNFmDurGVp8nhoEXLYyNgXhf
 iBNxrYFaGwYCiEhzd+vgNc6AJEqlmJVsaWaamhlA5aGwGYLURXABQXmHq0lGYEisMRy79S6do3D
 e8JFN/pKqHNTLiH4mEuWuSGYE3QifOFJBLLv+pc3kQ3EbQCHqHWq1bEkFYAydRLA6Cr5/aubMxv
 +NePxM9hpZrra80LcYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090164
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

On 7/9/2026 9:12 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> On 7/9/2026 8:03 AM, Pierrick Bouvier wrote:
>>> On 7/9/2026 7:52 AM, Alex Bennée wrote:
>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>>
>>>>> Runs a record and replay test, and make sure the output produced by
>>>>> both runs is the same.
>>>>>
>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>>> ---
>>>>>  tests/tcg/meson.build              |  1 +
>>>>>  tests/tcg/scripts/record_replay.sh | 16 ++++++++++++++++
>>>>>  2 files changed, 17 insertions(+)
>>>>>  create mode 100755 tests/tcg/scripts/record_replay.sh
>>>>>
>>>>> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>>>>> index 30178df0f7a..e610ce30f40 100644
>>>>> --- a/tests/tcg/meson.build
>>>>> +++ b/tests/tcg/meson.build
>>>>> @@ -7,6 +7,7 @@ if config_host.has_key('GDB')
>>>>>  endif
>>>>>  gdb = find_program(gdb_progs, required: false)
>>>>>  prog_gdb_test = find_program('../guest-debug/run-test.py')
>>>>> +prog_record_replay = find_program('./scripts/record_replay.sh')
>>>>>  prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
>>>>>  prog_run_with_input = find_program('./scripts/run_with_input.sh')
>>>>>  prog_run_and_check_forbidden_output = find_program(
>>>>> diff --git a/tests/tcg/scripts/record_replay.sh b/tests/tcg/scripts/record_replay.sh
>>>>> new file mode 100755
>>>>> index 00000000000..57775a2d4c1
>>>>> --- /dev/null
>>>>> +++ b/tests/tcg/scripts/record_replay.sh
>>>>> @@ -0,0 +1,16 @@
>>>>> +#!/usr/bin/env bash
>>>>
>>>> While at it is there any reason this couldn't be plain POSIX shell. I
>>>> don't think we explicitly require bash although its super likely to be
>>>> on most systems. configure is all POSIX shell.
>>>>
>>>
>>> The main reason for me to use bash is that it supports set -uo pipefail
>>> in combination with set -e.
>>>
>>> Which produces:
>>> - exit if a variable is undefined
>>> - exit if any command in a pipe sequence fails
>>> Without this, script shells are pretty much house of cards waiting to
>>> collapse on any corner case.
>>>
>>> bash is available out of the box at least on macos, msys2, and I expect,
>>> every single linux distro out there. Not sure about bsds though.
>>>
>>> If that's such a big issue, I can port the scripts to sh.
>>>
>>
>> Interestingly, QEMU main Makefile makes bash a defacto requirement,
>> since it uses it for every single command to run. The reason is... to
>> use -o pipefail.
>>
>> https://gitlab.com/qemu-project/qemu/-/blob/master/Makefile?ref_type=heads#L17
>>
> 
> Well it looks like I misremembered as we list bash as a dependency in
> qemu-minimal:
> 
>   packages:
>    - bash
> 
> so I drop my objection.
>

👍

> 
>>>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>>>> +
>>>>> +set -euo pipefail
>>>>> +
>>>>> +if [ $# -lt 2 ]; then
>>>>> +    echo "record_replay: qemu_bin [args]..." 1>&2
>>>>> +    exit 1
>>>>> +fi
>>>>> +qemu="$1";shift
>>>>> +tmp=$(mktemp -d)
>>>>> +trap "rm -rf $tmp" EXIT
>>>>> +set -x
>>>>> +$qemu -icount shift=5,rr=record,rrfile=$tmp/rr.bin "$@" |& tee $tmp/record
>>>>> +$qemu -icount shift=5,rr=replay,rrfile=$tmp/rr.bin "$@" |& tee $tmp/replay
>>>>> +diff $tmp/record $tmp/replay
>>>>
>>>
> 


