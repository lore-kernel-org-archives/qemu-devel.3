Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E49FC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whqHk-0000bx-O2; Thu, 09 Jul 2026 11:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whqHg-0000bJ-Mw
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 11:03:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whqHe-0008Eb-O0
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 11:03:28 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669DvxlR2017688
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 15:03:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yInNDfp6GRrmlretqI3G1x31Ji/vfnXCZx1QuhQHXGU=; b=AuGHK8UXuRAi2imO
 Qt3w5+tK+1u+WrGib1zdEAj5UC3PMHMfqDB8BSEdynxozfk5IwmzoM0TO8Id1S/U
 qfgHDhlhXie9ZVAqoGqdnVPf3x1Kcfrc832MCf64poWgoOICiKwyxphbrWn1PhGo
 Lmgo9iCV/5YxpfR5EEx4EIH7et3221+s1l8weXzrniiwjs+8q3dOuxHUu2h1C48O
 WTaNYBYAU9rhNl2ERYMHLp2/7Q7tzkjGToLPWm4QQEK9M9858Ui+dbBHLkP4bo4M
 DZ8EdZ57HEkNXiGkgmwL/iE1Wn9ly4q6reMNiP4U9gVMxDPqSguGDu3ImS7koQQB
 fs61aw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9sqscxnc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 15:03:24 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38096521198so3813583a91.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 08:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783609404; x=1784214204; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yInNDfp6GRrmlretqI3G1x31Ji/vfnXCZx1QuhQHXGU=;
 b=C8DiQ479JnL/5GG4QP7G3NR8zjh/PC84BnRIigGKXCcMS1tpKzw/yCU19jbZw1xqg8
 /l3QGrnx6IBk+UZyrj5jeaBvxwON8N+uf6jeuhbIvGpAXLWaMJzVmXfEXl/231nImkY+
 MXp2HAvGtCJ3BN1vw3a5syHtKUyDMaastZEA86xlCsauZSUqsqbqGu4UxN02ex8boxuF
 rwfiAqZvCoDRPeIAETaoKYNxsrNGjoLDWB1Wgum+5lDqu544E2/2ylJeC4p9hiB6p1Gc
 5c5ilOZdBMqxVKN9K1TVDCcOM5U5fsbXQDFmy2miE7aGj3gvIrmCNYRfkmPXM3snBs3K
 kaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783609404; x=1784214204;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yInNDfp6GRrmlretqI3G1x31Ji/vfnXCZx1QuhQHXGU=;
 b=WwZU5jiHdklKVOl0Ghj+fUAqSEJzuROD9R24hhsvln35Uzef2n9wQvKLNHwZpwHl+M
 iVXhkLHcm0jDzZEzZz0GxrAP+4UToi/uBhxwPS4nPFN7zaicMmzrZ+3wjn/aeyL+EC5s
 1fRnrh36P2AaQe+D9hUYp9thyl/XfLrwKlWsfF9oyQEg3vaQgQ29hsYK+9+r9VID7hqg
 qfN/25nCoN1LkVhOffkRlWciKqMV8g+Ig0uyqpxrXmHm+qMaiZoVLkgGMU1z3x2x2/F2
 w8835j+Q60ZoC41QnswTuyRoICgDRvhGG0Diy+uG9Xd7c8d1tt4rJiC9HNTkLV+4haCW
 4y+g==
X-Gm-Message-State: AOJu0YyBdExH7TQf0Ew+XIA8yBktABzsIMVRgwTgQGv4GCcD+d/gTrBx
 kaZmY/i19V1QjvrbwIwaIhROHmhkkqVH5qDarPFZ5DE9Uh3BX7AXBCPg7+pGaFyq83kVZfy93yf
 k33cHYJUkfxpWRXjGi7/2lFec4BwMH6YQkiVDna+LAfNv0UijfrAnWI2L0w==
X-Gm-Gg: AfdE7cnTxkB7OcEhkrNsDJoa7whK676JJbDWHj22186CkKswWREasWXr9wghHtKtoQa
 POqexSofkuz4KL1ZB9BEQr6/lfHPG/w/abXlU8r7OXBsSDF6BmHDk/hDTc+/+3rAtlzyBAFrIEI
 qXBU/0cFUyCtC3k3rg+fyqUkJ78kiV+bqeks+adAn8bCZdofrwTi9iKYSGKF31VVmTXIcZnW+D3
 vssu9+AmzrtrhdnTPfm/5C0wqmsavGNIqN88YbEQiA1knuNlshixRNTHb86uHUIavWBVkmdf4Ju
 iRXzyNs0lE39+rK+CyTLDfRjYbbtXAxKWX2ytfGie2JX3Xj6vaYxgvvZp+FwdxVNPMzW8TyNnPL
 70u2nk2vf7tyAKc2BEhqEMJMrrPAX5GexJshd8N+3sYBoyKhpOueuRPhHOFiG+faQUdyCIIsb3g
 xkLOU=
X-Received: by 2002:a17:90b:1fd0:b0:37f:9ce1:cdac with SMTP id
 98e67ed59e1d1-389421ae11cmr7572156a91.26.1783609402522; 
 Thu, 09 Jul 2026 08:03:22 -0700 (PDT)
X-Received: by 2002:a17:90b:1fd0:b0:37f:9ce1:cdac with SMTP id
 98e67ed59e1d1-389421ae11cmr7572034a91.26.1783609401688; 
 Thu, 09 Jul 2026 08:03:21 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118ee6080dsm18450615eec.17.2026.07.09.08.03.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 08:03:21 -0700 (PDT)
Message-ID: <41fb9818-b18f-4deb-889c-e1847293a3f0@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 08:03:19 -0700
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
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87echcrzah.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0OCBTYWx0ZWRfX0B+kWbpu6TRD
 QSPmFryFJXwNZBi5IhTh0RhSl3trG3Mk0d/6hdYrnsHr0L+ytRSz2EvWU/ntPn9iQ1RmQMxYBm4
 +DNqJNTfr+4q6+qOW/BavaB3PaV0hQc=
X-Proofpoint-GUID: A7NDTEh8WeVrK5E1P_O7amNckbst17Xx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0OCBTYWx0ZWRfX5YWH5kukEH02
 pljeN6MvBW6eiiwdL7bEslb5sy9DksTxAYgda2/tmWHAyWcLEUu83ssiqvmCKcRNJAXJc+65AsT
 K+rtXMUm/7Him/w9Z8S/KbdF/hvwnfW/o5+LvG7swjQsZ8Jgjog5JqVdI1VybnR3Wd91kUd8d2N
 EtM2Qu1GRMHgmX+Kel380BTsuN5zuVaLT3ufwzVcda+uyCs/uKIOYgZR+U/sMwssWAAZ39O4HQw
 sT8gG8hUYLQJO414bZplwrJmbpMz7uq3X00IGVmiiWbTkosRjrwldL2ajxSjki2YxM/FviANGh7
 ciUFZRGPvebK55MN+WlR2GbOOfBkumwLpB/ria8AsfBTyL3ROPoYlzIjIgP1EyLP/Qpe6Fiol3g
 1A4XDTtsBEUJ0MprtIuSNtbZcDNYMhbNWcE2DTbJ3MhoRoj53s7tkGs0Dfc0k39b7szYvzhK36n
 Hw/fCqG7AVDwZKlC/Lw==
X-Authority-Analysis: v=2.4 cv=Sv2gLvO0 c=1 sm=1 tr=0 ts=6a4fb83c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=VFwj2R4tEzDYkTMSR1cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: A7NDTEh8WeVrK5E1P_O7amNckbst17Xx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090148
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

On 7/9/2026 7:52 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> Runs a record and replay test, and make sure the output produced by
>> both runs is the same.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>  tests/tcg/meson.build              |  1 +
>>  tests/tcg/scripts/record_replay.sh | 16 ++++++++++++++++
>>  2 files changed, 17 insertions(+)
>>  create mode 100755 tests/tcg/scripts/record_replay.sh
>>
>> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>> index 30178df0f7a..e610ce30f40 100644
>> --- a/tests/tcg/meson.build
>> +++ b/tests/tcg/meson.build
>> @@ -7,6 +7,7 @@ if config_host.has_key('GDB')
>>  endif
>>  gdb = find_program(gdb_progs, required: false)
>>  prog_gdb_test = find_program('../guest-debug/run-test.py')
>> +prog_record_replay = find_program('./scripts/record_replay.sh')
>>  prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
>>  prog_run_with_input = find_program('./scripts/run_with_input.sh')
>>  prog_run_and_check_forbidden_output = find_program(
>> diff --git a/tests/tcg/scripts/record_replay.sh b/tests/tcg/scripts/record_replay.sh
>> new file mode 100755
>> index 00000000000..57775a2d4c1
>> --- /dev/null
>> +++ b/tests/tcg/scripts/record_replay.sh
>> @@ -0,0 +1,16 @@
>> +#!/usr/bin/env bash
> 
> While at it is there any reason this couldn't be plain POSIX shell. I
> don't think we explicitly require bash although its super likely to be
> on most systems. configure is all POSIX shell.
>

The main reason for me to use bash is that it supports set -uo pipefail
in combination with set -e.

Which produces:
- exit if a variable is undefined
- exit if any command in a pipe sequence fails
Without this, script shells are pretty much house of cards waiting to
collapse on any corner case.

bash is available out of the box at least on macos, msys2, and I expect,
every single linux distro out there. Not sure about bsds though.

If that's such a big issue, I can port the scripts to sh.

>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +set -euo pipefail
>> +
>> +if [ $# -lt 2 ]; then
>> +    echo "record_replay: qemu_bin [args]..." 1>&2
>> +    exit 1
>> +fi
>> +qemu="$1";shift
>> +tmp=$(mktemp -d)
>> +trap "rm -rf $tmp" EXIT
>> +set -x
>> +$qemu -icount shift=5,rr=record,rrfile=$tmp/rr.bin "$@" |& tee $tmp/record
>> +$qemu -icount shift=5,rr=replay,rrfile=$tmp/rr.bin "$@" |& tee $tmp/replay
>> +diff $tmp/record $tmp/replay
> 


