Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59615CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 17:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXMR6-0004q5-7q; Wed, 10 Jun 2026 13:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wXMQu-0004pD-L0
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 13:09:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wXMQr-0002s0-Bj
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 13:09:39 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AFxJS91670870
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 17:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S9So1qU7ASlswzgVgsmN7Z6DsWQBMtFAct6WUEE8Pdc=; b=YU0io8zCaB20pYHv
 HtdbpxdlWPKYCz9e0eyiwg2UpYTRO90TDUN/ozmABcGcD1ewYEEYXPy9BUT/Z/Ul
 VoAHR9xNDOn+tOmr+RtaCXT7U6VXYaM9X/JAEoteVEzq3RAboxKHw+BNVTU8I/z5
 oTURyoECfyn0pR2q7UjiBhPyPvYGXkyJdispap4BXi5zMMs2GWf0UL5vCtPKLR8w
 23fqSKO/iwjwFCaNVaPXOMt335btSlIFzBs7MvoHoFqpFRCqmY3Vh9AtWpibNR5Z
 D95NGtosgBlqM/+3EAdvGRTctT7LMXmkQTa/MtEPjL0Vm0rSDTq1ZKXBgdzUa5Uj
 WRzgWA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq0m1u2by-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 17:09:34 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304df51ff3eso7586114eec.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 10:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781111374; x=1781716174; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S9So1qU7ASlswzgVgsmN7Z6DsWQBMtFAct6WUEE8Pdc=;
 b=ia3AGUhpginulT0aAI367OdyS4lHaapMmKmHnDj61Xx11euu32suauRL4T2hgrJa/N
 3OlTxZ/Yhm7pgzhqeJl+Tuwz7ei8jQ9OG8JhbSuLuPWZzqadxMj07JqmfC4L2Did/wQw
 gk0enIqkumFDxpGc3u7GYryL+/p/TnAO1zf0OOa9AdZGB0AETDBpk4k5vZxJUTLWl0ts
 pkpZ9jw9SAA+Pj9Xo4KGntH4vRVpcglg3rVMjBs8M4fVyUrsL/etCN9jCRYLFYnV7Be4
 9NZ6rUaXyDBmHeqUslxLIdE1qn8GhXGSKMmXInTBxILaTfJWc6Dos/AOvPBB9vQGt9bf
 36Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781111374; x=1781716174;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S9So1qU7ASlswzgVgsmN7Z6DsWQBMtFAct6WUEE8Pdc=;
 b=oq6/woWsRMAFwmjuN1Z+MiJ8ziM4Ra+wignsSO/CP8aB9r/SBybHUY8Qrw8Nr+t9AO
 1rUyiD4r7Ry9mNpFY4c3LAnSrK3XXyEj7Q6A9bPplZtd/UAlnbaH+U1Tj2LJTReLuYwT
 xSVH0KW43c5k83wzDJj5MxJw8BnWj0Qzke02lZKvGYSDK1sKF3mzVDVxkUeFMwuRxV3V
 DXfNG9GfNWaKkR5HfLU0gMbb3WI4WdOLFE3hvZ4GavqIipND34om6hUpO6U9G8l19LUE
 xcD7dK0yetqI5hNKcZ9tLk2+G6DFkbWyKA9U4xVgie6iCZkBZJPWEYh5ziuuJ4IUEUns
 4ylQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/9BU0xxvmIG0dKCFPBSrZq6+DfFuOyX+o6cN47lfPWaLkOz7AOy37rDpWkT7JwRarE/2k/9cOz2Wpa@nongnu.org
X-Gm-Message-State: AOJu0YxYwPgnjzyQLm41+5Pgua6yr6BMngrzr371++/R9PuxH6eECgzu
 xcx2aMa09UJwFQSJh7nqmzuO5gcc9kvauDfbpeo5bP3PHr+t6oxYQWEQz9iL5vKfLYpVQrqefab
 NyWllN4bLvAI/gdUbU1TE90y77x7l9SvCMQcg4JIUtP1MdqxtAvgtMcjL5g==
X-Gm-Gg: Acq92OEaZcuiAeu43pHi3ndU/q/GSOReFHyqW7IWHxyRaKvYktDM/TS9Wv3w8uewTs7
 zxpbXU1fvRgGRnymkqabhDCkDJKpHrFIIBC63XsiYEX7KtHJoXSxWlnsXqCDEgzUmg2HvpR57Uq
 h3c5gHPKsoJYcCPApR6XRhYnlZdzV3tC5GSfeTM3OqoxQ41dULxQTzhwKCqQY8IX9+zuaSQ99pk
 2af2N/lHmvfyPds4D4NblvPc0uMYAcZ3ktWvYtU6x9R/vCno+LrAEAO4O0WpWRLfpscmSNrPP6Q
 mTnnd8LeKZQ8NwIr6vblMDMpwGBN7Za+DZnY7Ksc7nAidrdc5x23MEim1lEVxBzAL+n/AYe44QO
 0EagpdExDuN0PFtIlK8drBlZN+csyuw7ka0cHkz3c4b5uxe4QA5SeFu94yOUx1kNty+MnIbzREi
 KH4V/fingsbyoy+8V4HHVc0aX9
X-Received: by 2002:a05:7300:214f:b0:2f3:c3d4:382f with SMTP id
 5a478bee46e88-307ff540686mr44957eec.8.1781111373546; 
 Wed, 10 Jun 2026 10:09:33 -0700 (PDT)
X-Received: by 2002:a05:7300:214f:b0:2f3:c3d4:382f with SMTP id
 5a478bee46e88-307ff540686mr44925eec.8.1781111372924; 
 Wed, 10 Jun 2026 10:09:32 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db528dcsm32245631eec.3.2026.06.10.10.09.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 10:09:32 -0700 (PDT)
Message-ID: <a4517d21-d243-47c6-ae0c-a795a40d41e8@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 10:09:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/27] tests/tcg/meson.build: add wrapper
 check_plugin_output
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud_=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn_=C3=A9_e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell
 <peter.maydell@linaro.org>, Gustavo Romero <gustavo.romero@linaro.org>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
 <20260609214745.772536-21-pierrick.bouvier@oss.qualcomm.com>
 <tgenkp.crsxljvbliqb@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <tgenkp.crsxljvbliqb@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE2MiBTYWx0ZWRfX7k+t4Yxuy+X1
 w9Eg7bguaA8soSXJx7igV8d2JGQQL5UnLI3gst1o7+4KZChhYolyl/ZtOSiOWKrIeYcDCumGNMI
 HAwvANaaFL0IfJZ77G5L3j9/D7988vDLmv2ihRALQWCYf8vGMGS9t3wf3vaQKLWjIWwQgYs6S1d
 uD5kcvCOQR1NcNVn7P+j5GeSS8Xjwkuz+TTzr1l7vi7/DRsQpnt7dzVmnbsNhTnWNhlQ04ve3XL
 7lFbo3hzj044kBVJJ+jkSnC130ZOqhy6zoaEVPQDB5p65FFjBOBeorAkzlpJvX9DrMnlZNHaSV7
 FqFHptmgeKztJJWTmkpMSb/MJihYngWSGVOPpzwu/5QYpiaXggRNUfl/741Bij/isjpIPSZJ/Yn
 iyd2My1OHDEewfRBOL19glyxBG1Eow7XebctizjZwsF0J3Dm2VDOHVyp6lcWDTLOgOlnvFflh0F
 pX4rOjf2xYQzIFUFx0w==
X-Proofpoint-GUID: 62vwYtQ_c6-KHp9cZ4prBhaLu5okGfVO
X-Authority-Analysis: v=2.4 cv=UdJhjqSN c=1 sm=1 tr=0 ts=6a299a4e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=F35cBGiUz0qV-L6tl88A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: 62vwYtQ_c6-KHp9cZ4prBhaLu5okGfVO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100162
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

On 6/10/2026 12:30 AM, Manos Pitsidianakis wrote:
> On Wed, 10 Jun 2026 00:47, Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>> This wrapper runs a qemu command, record command output and plugin
>> output, and forward both to a check script.
>> We use this pattern in several plugin tests (for instance, with
>> validate-memory-counts.py).
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>> tests/tcg/meson.build                    |  1 +
>> tests/tcg/scripts/check_plugin_output.sh | 19 +++++++++++++++++++
>> 2 files changed, 20 insertions(+)
>> create mode 100755 tests/tcg/scripts/check_plugin_output.sh
>>
>> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>> index f0efd46ee3e..6e46c121fda 100644
>> --- a/tests/tcg/meson.build
>> +++ b/tests/tcg/meson.build
>> @@ -6,6 +6,7 @@ if config_host.has_key('GDB')
>>   gdb_progs = [config_host['GDB'], gdb_progs]
>> endif
>> gdb = find_program(gdb_progs, required: false)
>> +prog_check_plugin_output = find_program('./scripts/
>> check_plugin_output.sh')
>> prog_gdb_test = find_program('../guest-debug/run-test.py')
>> prog_record_replay = find_program('./scripts/record_replay.sh')
>> prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
>> diff --git a/tests/tcg/scripts/check_plugin_output.sh b/tests/tcg/
>> scripts/check_plugin_output.sh
>> new file mode 100755
>> index 00000000000..4d12e23ad60
>> --- /dev/null
>> +++ b/tests/tcg/scripts/check_plugin_output.sh
>> @@ -0,0 +1,19 @@
>> +#!/usr/bin/env bash
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +set -euo pipefail
>> +
>> +if [ $# -lt 3 ]; then
>> +    echo "check_plugin_output: check_cmd qemu_bin [args]..." 1>&2
>> +    exit 1
>> +fi
>> +check_cmd="$1"; shift
>> +qemu="$1"; shift
>> +tmp=$(mktemp -d)
>> +trap "rm -rf $tmp" EXIT
>> +
>> +set -x
>> +
>> +$qemu -d plugin -D $tmp/plugin "$@" |& tee $tmp/output
>> +cat $tmp/plugin
>> +$check_cmd $tmp/output $tmp/plugin
>> -- 
> 
> Could we write a single python script for all the shell script wrappers
> and use a different kind of wrapper depending on its command line flags/
> subcommand we invoke it with?
> Maybe this could be better? WDYT?

We could do that for sure. Better or not? Not sure, but I don't have
strong opinion.
I just picked bash because it's more concise than python for this.
Before putting too much effort into the wrapper part, I'll wait to see
if the rest is working for maintainers.

Regards,
Pierrick

