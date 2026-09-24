Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D6AC98318
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 19:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9onr-00050O-AI; Thu, 24 Sep 2026 15:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9onj-00050A-T7
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 15:08:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9onh-0004MU-UD
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 15:08:11 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OIeL842997612
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 19:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mBX4pmgTgF6OuExfMusCvCaOl9ELByMLjsvLiUyvwAU=; b=n1V+BmLH481ntDH1
 BY8qAgf0gI0Bj3XMSphTLt0YLPxDvYgdckJC+iMyG358zAv/fBd3BMPgQDs4ZUDS
 hO7tdJd22KEyXtQHbgcJTj1P2ek1S9fXMyfyjgMD2UjLq/aWDq+faL8HEQNaA5xq
 Ub61Yhi+ttyY3MN7J76AnGFN5SNFAxMNKLAKPZRECJ4k1GML1aSKodJPCLe/nBbA
 PeW89EgwHhFa60azFTQQZXz8+Kq5rsR6tooPuDYhuYuPOMIld8CCOGa9ieyJtSOT
 I84F7S/8aOEQHHreqMm20GyNnVYIUgNLTOu2x4ORsMf3uQYVWPoCzwb6wj3gwKaI
 P7q0YA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw4651p53-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 19:08:05 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-338c2e27430so97103eec.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 12:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790276884; x=1790881684; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mBX4pmgTgF6OuExfMusCvCaOl9ELByMLjsvLiUyvwAU=;
 b=VaA+GvmlEi2lIR3JLaecJHf5Ti8WFFim7FHUUoYbqqQUZuy3TOk9xDi+FZB6m4E0iG
 0q2Ywlg7snLE9xaPWF1QFJI3E4fJUK2FjIKnZRLsuCzCcznDO/vQyOkY5n03O62Xl3hj
 bNUX7ieWUDRYM9w77nL7XOPwohev8eZooGi0wIqLKOkucvWLJ/o+He57HOWwvZfV0thc
 4zxGZC9HzNdesHOQ6HScuwRozRPY+q4HFAEOqHfFbVwGxDXbHKrP2HWfgixSsadd8OiM
 Ol+0dmSQh40uEm/frRE+v2wIOk/KW67zKlGc19V88/1i6nTS8Ds2UkC0Erld8xBqjAwz
 Q+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790276884; x=1790881684;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mBX4pmgTgF6OuExfMusCvCaOl9ELByMLjsvLiUyvwAU=;
 b=NdZvzb9uVX3IwIU6TP1ibwCR4Ho/G7uQtKJ8FjOnRcxcJisYh9DlDsn6f4mmDJQm2q
 EcaIClYOjGRcft9XKrWevEU914TNgIbFrVxo6ROx6IZBIaHa7yVzLTtPhyu2OG1+Q1MH
 TvjnnX1hMbwY6ckTWvZ2H0g/2n8au4jTa6M8STqqs+vct5O9So68fdwNwUMzRP5ViZe1
 W9VBt2iOzSroHb0Qv+6r2pmmCDKIOWsh2vqUQ1lMm2TAwE5Mb/bNJZ2Vo5u4uqC0/Jb5
 j64dnJ9bVyB9t1FNc4sAdSrEJPwigcUfqZvFyx8+i8urbGBvuLBeAQD5MrmNEvG5zL/q
 5NRQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzq+/4ZY+fmLGlgvhU2H+yTFqadTlG8rBJxkDOSWyDfWSCNQPRJ/qEF/3T4zQUbygcPPPFCsUVPN72L@nongnu.org
X-Gm-Message-State: AFuF++k3Djz6F2S+7nKaL8Hn5nWLno5ZU8eFpno0jMyuAXA5obspc2/5
 PfzS11Y7VGy+j/2ydADqUcqH7zUP70d/5HCVVKC/9nFM0hB3fW5l5NetY9LKwrir4Kbw/juJIQ3
 KLKPNqL3tCMi1SgpzHiY/zlQVKi3/tQbZimGNV10Ql7kk5ENhj6M7Td0JVA==
X-Gm-Gg: AYBFou3m/NGxJAa4YtXjPKfyphTrwV3brsbbnma/id/kpB8a8aXNXwKcM37y1YZWGKI
 L51KiZSy0vVVPej+JmBzbMmGxuzMiT4Tv/pm2ywpeQMS8gboAWG7OEZxsdG1l1nQY6IeKXUuPWd
 TNwjmQG1GymiewdC12d1p+blAGB4nSIW0sB4lwfHxaxL4i4eCX8uaZIyv/WSkItlIZTODjTEhnE
 0psAWtiVW7QK7ApaJJoiSpVjAv+guQl0w6hHKPlTVyx1tOFQTRw5X/GIR0NnuVwOpvFDSq3sv3M
 FhSzKwQ6OQUwwrDN2Wrughshu4Hiv/3E9ZKLRVvBPTO9DgJZ5c6aw8SvIkcmgBsjgip0EZJ24zf
 BY3kth6KVWHn4IWmoptOnJIFngYOzABOsU8UgWwbwOjk8SFQxAdPOKQuMwh4rhtkuoVY=
X-Received: by 2002:a05:7301:1445:b0:33c:719:f1aa with SMTP id
 5a478bee46e88-33ffe746729mr2403069eec.8.1790276884250; 
 Thu, 24 Sep 2026 12:08:04 -0700 (PDT)
X-Received: by 2002:a05:7301:1445:b0:33c:719:f1aa with SMTP id
 5a478bee46e88-33ffe746729mr2403044eec.8.1790276883456; 
 Thu, 24 Sep 2026 12:08:03 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34144757747sm597617eec.13.2026.09.24.12.08.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 12:08:02 -0700 (PDT)
Message-ID: <353ea82d-9227-4482-80f2-d78788e36e2a@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 12:08:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 092/105] tests/tcg/x86_64: system tests
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: Bernhard Beschow <shentey@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Aniket Sahu <asahu1x@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
 <20260904124604.2207440-93-alex.bennee@linaro.org>
 <cae2d17b-571c-421d-98c8-fbc467134141@gmail.com>
 <6b37b050-9d5a-40a1-ac65-4126fa725342@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <6b37b050-9d5a-40a1-ac65-4126fa725342@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Wrq+otfv c=1 sm=1 tr=0 ts=6ab57515 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=IFlH_9TGYeQF7RgDkE4A:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: G1CublB7p1OU3rwNxjZ_Brnzx-Qijv9M
X-Proofpoint-GUID: G1CublB7p1OU3rwNxjZ_Brnzx-Qijv9M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA3OCBTYWx0ZWRfX34nmHyXBRzUh
 Pjx53pKP9wLV2JxGlFbAb9Vb8GVZCDwfpEexSpTbZ2RC+PepZqYiynchYOeNDODVS2H9XKUIqvC
 mLtiJCtq5I8n+xTcuijk5ypiDmsGXGIU/nA731vckaFlagb3zoHJoEMnwZoiSRXOP+087TX6l0D
 2cnyMPINmksYqQSLJNOEXKWPl5590d1INvtc3XfnFz7X9D8hkIXfbKUK9BPXA8nDleGsRhbI+6R
 K6Si+7dWskIiB5WYeigkwK+YzuYRgQW63Cj3Fd9nhX2a1EHr3Dfz2ijyHdjPFGG4o5r0FvwEBA9
 LEpAOdSr5uwJpc76Z6UltC6FMbHApCEavRxaoYrlwgRvrJP5dg3pX3HRWiE/1HgD6QtL6I9N2dl
 UJ9WuyWr7pw9SAxS6E9ROviBfdbdkzC5fFnHzaG1C/UF+sWtaqYr32ydAhnZMuZtXv1ygnbx3lW
 g+uyCrm6k5qOgXOb9ZQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA3OCBTYWx0ZWRfX+xl2+pE99C3b
 jGvMxVEpVYq98dYQXZBd9Z9wYaQ/yRFbPsbF37qp0zOe7jrr98+Lm2SHUdSv+ik6CosxYN1dSex
 efVu7yw0WMGOpXHUIN2pesKMbcBgK8g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240078
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

On 9/24/2026 11:30 AM, Pierrick Bouvier wrote:
> Hi Bernard,
> 
> On 9/24/2026 11:18 AM, Bernhard Beschow wrote:
> 
>> With this patch I get under Archlinux:
>>
>> $ make tests/tcg/x86_64-softmmu-hello.test
>> [1/1] Generating tests/tcg/x86_64-softmmu-hello with a custom command
>> FAILED: [code=1] tests/tcg/x86_64-softmmu-hello.test
>> /usr/bin/x86_64-linux-gnu-gcc qemu/src/tests/tcg/multiarch/system/
>> hello.c -o tests/tcg/x86_64-softmmu-hello.test -static -MMD -MF tests/
>> tcg/x86_64-softmmu-hello.d -Wall -Werror -O0 -g -fno-strict-aliasing -
>> nostdlib -ffreestanding -Wa,--noexecstack -I qemu/src/tests/tcg/x86_64/
>> system/../../minilib qemu/src/tests/tcg/x86_64/system/../../minilib/
>> printf.c ../src/tests/tcg/x86_64/system/boot.S -Wl,-T ../src/tests/tcg/
>> x86_64/system/kernel.ld -Wl,-melf_x86_64 -Wl,--no-warn-rwx-segments -
>> Wl,--build-id=none -lgcc
>> /usr/bin/ld: /tmp/ccRh6mPz.o: in function `print_num':
>> qemu/src/tests/tcg/x86_64/system/../../minilib/printf.c:45:(.text+0xec):
>> undefined reference to `__stack_chk_fail'
>> /usr/bin/ld: /tmp/ccRh6mPz.o: in function `ml_printf':
>> qemu/src/tests/tcg/x86_64/system/../../minilib/printf.c:136:
>> (.text+0x549): undefined reference to `__stack_chk_fail'
>> collect2: error: ld returned 1 exit status
>> ninja: build stopped: subcommand failed.
>> make: *** [Makefile:170: run-ninja] Error 1
>>
>> Reverting this patch I'm able to run `make check` successfully again.
>> Any idea what might be causing this?
>>
> 
> Thanks for the report.
> Tests were previously compiled with -fno-stack-protector, and it was
> unclear which distro/setup required this, so we removed it to find what
> requires it. It seems like archlinux is one of them.
> 
> I'll re-add the flag by default.
> 
> Can you please confirm the command above (x86_64-linux-gcc ...) works
> with -fno-stack-protector added?
>

After testing in a archlinux container,
I confirm that's the right fix.
Patch is coming after CI end up running.

>> Best regards,
>>
>> Bernhard
>>
> 
> Regards,
> Pierrick


