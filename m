Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499B3C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:11:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whqPA-0002Ux-2P; Thu, 09 Jul 2026 11:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whqP9-0002Un-2l
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 11:11:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whqP7-0003Ca-2J
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 11:11:10 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669DwDSJ1833939
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 15:11:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ii3Or4mdMiK1tZGwqK0c/6jLtUVZ7A4rP3f5RrXUTVM=; b=Owd8mnNvk7IDMaye
 eIveaBhUXRMNnODZZ4RsYpko1hNV6KfEfd0Yos0YuOY24+Y4izmk1AJGgF/h6nkS
 6oMfSdXzY9NldJwCF+Zx1pan9h7srqqVZkG01ddBI2C+lGG6XGz5Rg+Gl8y0MkJX
 4mb339rs5jB0lMH0Wtd45iRpUM3hOClI7lIYdwV5ud5P8SxOI6AZF64Y1c4ZZgpr
 EkljJDhmfz2aEYX9hW73i6oZ7xY5M9kpCxT34JcFkWVES9oxgMUXYe5fB7TRbste
 wDoJrFcDOC33SmQiJK03S1qkw2KyrFzaLUYwB+FKWC/BkT8TNDP84qPmeat+1tzu
 VEZlKQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9wwfux0m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 15:11:04 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c88ab059052so1138216a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 08:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783609862; x=1784214662; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ii3Or4mdMiK1tZGwqK0c/6jLtUVZ7A4rP3f5RrXUTVM=;
 b=B5U6ZwpNr4S3k/v1XYPUgHs9F1od/41udQqWsDIZfUwWF4QMvD7HHuG16No/yNCPQ4
 2px72TsEfgLzZLRtIQT7NposrCRpRB7mSQE7mygeYUlb0Spq5LPlIbhtJ6yQGoIpi7cJ
 e0sXRm/fDIqZbo3xbXFVtekxIW3dRmtNFM4tN0PTxkSyNh6Q3MWi2C/33Ahfr2dHfx5j
 kFP4rJSEW5gPFDN58KU8yU1DKNpZfBUiypO62LOXGguQzaSa4prSRhmJ4+Vg74LWThV/
 bt1l+A9XrzbMfltR7Rt5rK2KedgFp3/ZTW89wDbwW8w8zj5FHx1jj7M8XiJDGepsVvxf
 L7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783609862; x=1784214662;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ii3Or4mdMiK1tZGwqK0c/6jLtUVZ7A4rP3f5RrXUTVM=;
 b=VfkUIrML3c1J9cO3v6Y94vw41j8EPt687XiFWW0R0qWZXMydHF/JVhaZuiSfy/yfAU
 2r35UshIFHFoCNM4BvY9vMaAQgKlthnXOGRxoxERRLCNfB9IxL9ECzuMpv18+CiMscm7
 aderf4KrXfl9R7nd/yqG/Q1C/P0eQ4CmNJprpg2/DsvisNBClXzafLf0rWxpKQezG+lm
 1I6xplo6sZrPnRTN8vCzdaBK8Z3dxEDItwy5THsGCx1xWAIalBnddwhkkJgLRGYWxett
 Lfxx52GGAUbNxN5bAUthKCHQcPaW9eVRm4DpecVKUXtDvmAltFWZI+px9OI1EuNLuwkJ
 eaBA==
X-Gm-Message-State: AOJu0Yz1aZLuYOIvhS+Ff+utdtJMX28WNY0L+veUy7kOVNjoTiBtLHz0
 XJHVlzPmwqKBUY7VaQhfR5WCx15j0Sdt1BezV8jWIT9a18AXW2xpcvNgdR2qVflNGSOJB3D45O5
 ovZZ3nhQRLf+Kw+TobahfOOUnzH/C9B0U+tafSfU1o/q+D4Emmk+Owe0LdQ==
X-Gm-Gg: AfdE7clnfpO4DOdRAXQfGnv4XEB0Zg3DHg0iPJ6JC+T4m6nLtJYedRDuIgInX32cQbV
 hFTaoH/RtLg9YBZHmFrK/t3MXQmkCgwPQqZJYcJAiaDBRQEPR70nWogWNO8WCNM4cgfaycdzuKZ
 kaVt8BqAFGkr8Xq05UbHp24P1W0caJUiQntbl0kj2fRY2KMO4Q0wOVsUIMzFxmic6lHhY0PlHss
 QHupYoxaBScdDlGOsCTERUiobkAXWkgxm5kVzKDzSwFraO4Wqx273wctXKEfGoJ5PXx7rYv/MAy
 7P1z5u3WOZuSr3aEG33rTx0FYB75d5QW6c+mXYxHUa73bPc6byduVSkPyFs2G7Wrg1PMzwuF0MI
 ObRcjqX4kVXPhWSDW4d4QapMoQKQZhvTM6767hC0gXzr/q8acx/8HwqyGi1GjQzpB0nSHmiKw47
 s1Y9U=
X-Received: by 2002:a05:6a21:328b:b0:3bf:6763:f0d0 with SMTP id
 adf61e73a8af0-3c0d672acdemr5059067637.4.1783609862396; 
 Thu, 09 Jul 2026 08:11:02 -0700 (PDT)
X-Received: by 2002:a05:6a21:328b:b0:3bf:6763:f0d0 with SMTP id
 adf61e73a8af0-3c0d672acdemr5059023637.4.1783609861896; 
 Thu, 09 Jul 2026 08:11:01 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118ee6091dsm27085130eec.14.2026.07.09.08.11.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 08:11:01 -0700 (PDT)
Message-ID: <decd7f0d-fd74-4314-8a44-df9f7a75d8d5@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 08:10:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/91] tests/tcg/meson.build: add wrapper record_replay
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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
Content-Language: en-US
In-Reply-To: <41fb9818-b18f-4deb-889c-e1847293a3f0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0OSBTYWx0ZWRfX8HB93rgumPxN
 9tZcqDW5JqcnpCDDtRQ5jnlH8bUqtZk1bWMqsemevMj5/ull1P2uY6FpXqX6ujRQVVWiwdWIGDy
 0OlNF04LbLvQpEcjj4nCfxAi4LV50f0ywr1LZ3RQ3SQxAX1Rl6+8y+bZbiS7xxk6+9icxeWUNPZ
 4dMmMgdIvemb5E5+IUu8EqX5RL5uGlAiL+UEC/koSW7eEu3BdrUX4Jt4J+P+E69b9GTtSWx0UdD
 kZDRAO1/bHZHBvq3dQVjXm4+scjsIgpwVE/ol168CkZMZEnluT2EZZeaKxeo5ps92IKaElqZ1gl
 gor5knsexwymQhFEr0sj8NXdLQo7lVxHr7YNLcYhk5A3Z86M/fYwSbdhhQx2A6S7RHq9+p1n1dz
 Xgc1pX3hFdCmVFHaZCo9BCa4fz2U+DMMsBlADZ3YDf6wsTiI9BoQLL8NE23ObNQlv9ctzyRxy3F
 QpjBGjmnfZhkCH2tCzw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0OSBTYWx0ZWRfX7dz9A+qotCNc
 V3qsPvYwAxT90T25akHi4ARkNdmNKsmOGdCEAmWQfPGHydkd2GHDgUefLIsfMs/ACPj88Lte50m
 p6ptXj7ntbThZfjL+GdQK+wJepMY+Is=
X-Proofpoint-ORIG-GUID: 0MamEtA7REjNTTTVJduKIqgDLuj7M1eN
X-Proofpoint-GUID: 0MamEtA7REjNTTTVJduKIqgDLuj7M1eN
X-Authority-Analysis: v=2.4 cv=Krh9H2WN c=1 sm=1 tr=0 ts=6a4fba08 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=-U2V7TQ2D_QJDzsPZhIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090149
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

On 7/9/2026 8:03 AM, Pierrick Bouvier wrote:
> On 7/9/2026 7:52 AM, Alex Bennée wrote:
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>
>>> Runs a record and replay test, and make sure the output produced by
>>> both runs is the same.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> ---
>>>  tests/tcg/meson.build              |  1 +
>>>  tests/tcg/scripts/record_replay.sh | 16 ++++++++++++++++
>>>  2 files changed, 17 insertions(+)
>>>  create mode 100755 tests/tcg/scripts/record_replay.sh
>>>
>>> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>>> index 30178df0f7a..e610ce30f40 100644
>>> --- a/tests/tcg/meson.build
>>> +++ b/tests/tcg/meson.build
>>> @@ -7,6 +7,7 @@ if config_host.has_key('GDB')
>>>  endif
>>>  gdb = find_program(gdb_progs, required: false)
>>>  prog_gdb_test = find_program('../guest-debug/run-test.py')
>>> +prog_record_replay = find_program('./scripts/record_replay.sh')
>>>  prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
>>>  prog_run_with_input = find_program('./scripts/run_with_input.sh')
>>>  prog_run_and_check_forbidden_output = find_program(
>>> diff --git a/tests/tcg/scripts/record_replay.sh b/tests/tcg/scripts/record_replay.sh
>>> new file mode 100755
>>> index 00000000000..57775a2d4c1
>>> --- /dev/null
>>> +++ b/tests/tcg/scripts/record_replay.sh
>>> @@ -0,0 +1,16 @@
>>> +#!/usr/bin/env bash
>>
>> While at it is there any reason this couldn't be plain POSIX shell. I
>> don't think we explicitly require bash although its super likely to be
>> on most systems. configure is all POSIX shell.
>>
> 
> The main reason for me to use bash is that it supports set -uo pipefail
> in combination with set -e.
> 
> Which produces:
> - exit if a variable is undefined
> - exit if any command in a pipe sequence fails
> Without this, script shells are pretty much house of cards waiting to
> collapse on any corner case.
> 
> bash is available out of the box at least on macos, msys2, and I expect,
> every single linux distro out there. Not sure about bsds though.
> 
> If that's such a big issue, I can port the scripts to sh.
>

Interestingly, QEMU main Makefile makes bash a defacto requirement,
since it uses it for every single command to run. The reason is... to
use -o pipefail.

https://gitlab.com/qemu-project/qemu/-/blob/master/Makefile?ref_type=heads#L17

>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>> +
>>> +set -euo pipefail
>>> +
>>> +if [ $# -lt 2 ]; then
>>> +    echo "record_replay: qemu_bin [args]..." 1>&2
>>> +    exit 1
>>> +fi
>>> +qemu="$1";shift
>>> +tmp=$(mktemp -d)
>>> +trap "rm -rf $tmp" EXIT
>>> +set -x
>>> +$qemu -icount shift=5,rr=record,rrfile=$tmp/rr.bin "$@" |& tee $tmp/record
>>> +$qemu -icount shift=5,rr=replay,rrfile=$tmp/rr.bin "$@" |& tee $tmp/replay
>>> +diff $tmp/record $tmp/replay
>>
> 


