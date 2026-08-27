Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9A3C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 21:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzhEk-0001aS-8d; Thu, 27 Aug 2026 17:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wzhEi-0001aC-Vm
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 17:02:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wzhEg-0000Us-Kj
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 17:02:12 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJM7sf654752
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 21:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tKfvJctMnCSLmvmwijqtIqwIir83XF+jIeOEkWjDKFQ=; b=UBc2ehAlLxzcuMqE
 FJ1nEeM2QIVHd/iaQ9MHAlWXKKCq8gCpztSiLu0AOriqXa6uJm41bepe7Re9MuVo
 ew5B7srlyMEKhnhhX2TFkZ4r+OmXR4JmVnWWqzdcHuY4kR5q5xPtAVV1y6I/zDsJ
 oBoCEQgcrw6k9UyNDwvZTMTEUX0FH3Ls5+2f9Gvg2BmGGz/hinNWuVxQyYDUY1RU
 cx3B7vyscMSOPAxSrAqXDvgDLWVWyX7G6pRhYQshwYpHmU+uJy6Gnl5yksHPf3dJ
 /QTpVUIuOP+padPii9sR0DoonEVhnLWtWZDsg1pB3iB4k4V6DWaDKz/C++u9GWAN
 uu1/WA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gagjfub4g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 21:02:08 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e54b6556aso181981a91.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 14:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787864528; x=1788469328; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tKfvJctMnCSLmvmwijqtIqwIir83XF+jIeOEkWjDKFQ=;
 b=JyvAYVdBp3/m93ZB/sYyz8tdc5R0RVWc/jxjPFLZ5ppdHpBzCU4o3JqF6o4xs9fBUC
 1KfDoAK+U/fMVXaHRqPX8FBHxadCPaHbQ52o1fSlbml16SXyNhg1UEETe4IOnoBC/tAY
 9AvNu2OuwdjMaMYIAsgKNg3fWyTW/V0CRPCh8iPKtut/UCnfEEaet4hGbsGXWJNCvTQg
 8mB0F5L1Y/jyVuQCuu5D+MFBgb9tK8x8r3aWCfoaM4pYNH6oRvE6ENdCDMS2vGbLeUvr
 6PWx0bFdFhcLcCtBe1Y5hq4OxzQKRKAE7ffLm0uNuDgZvr7mr0au/UWTdAyx2jSM0+sx
 mCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787864528; x=1788469328;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tKfvJctMnCSLmvmwijqtIqwIir83XF+jIeOEkWjDKFQ=;
 b=UcJjniPRzJoKzkXpbpezMRCtobCELFWpvbcepejFcFSVCpLfZfLe18r7vrQxeYUf/n
 UkA5hY+wG+JKGA9i2YpKwtvGlSXjHPxx+x11LtPOjtqVmdZrHzurSTvZWa00p2jD1+W9
 1dnJYD46bKP15vGjiK7T+cI6jxnxTnzxYI7+WSROVd3twQYUAgNcMKWAlGFngOu6Fd6I
 v/T9TYvOffeAJ/c5d0YLMeUbq/lzBHCqp42U9pwWWKocEpGefZ68/xIXM8CezomDw/wV
 aZVY052V98ccJsYXGL7wRILSwUCZDiEXf/NxJ6Ba39la+XT+mbaNgOMyvleVAT3NKctj
 0QkQ==
X-Gm-Message-State: AFuF++lnc/rN+mkxaGc3GdYbKG2EUn8J7kub2nJ+kkkvfqCPyjtnfgzS
 /GaZOmyOg8hTPBlumSOSPTZdK5780BzmYVm0LiQ7gW8JwgJx8suuE9q66JzNsctph9Lrxp1mvO9
 W+ab7Lwkh1YlrtXn6EaqtdkIIV59eLRVxW3pI9pYqM3b/NGL0eHsKiRSFDw==
X-Gm-Gg: AR+sD104U/tbwgBlPKt51LsKj0LToiFkxj/U/3ySCMryhcy/PRdUggvSebMXbR5BiYW
 VrZHZrFPur/v4m/SHxsodQsFrhM2dRAbxs3reHfKE1QmwZjwdR17FL2JCDzhwBlRwmU0JN/YRrG
 R3xZOhoEuxXor969aRdtoDzS6DEF+1jX5e58Sc/zO/D+bZ650gjXyf3P/UcbTUIT0VO+rFsL40g
 iNfMualL5qA2h9a0LrcLd3dfHCdsFPwNRrPwiVQIvZ5D2AFhPjsPTi26XZlXrx8QO4tV5S/dpwA
 8kce9at0ykSiyl9oHDy1Z2+4BM/DuSG7o1d+7GzV3BMa1bCYfgADATXwvqD5GPvPbnUxJ8dFahX
 sKEjtn9hu7Fn4j8XNIyUNM2pAgW1JrAUo3iUv8o5m8iFi8jgpKFZmdnL+uxiF0VEXUNol
X-Received: by 2002:a17:90b:50c6:b0:38e:97f0:aa4b with SMTP id
 98e67ed59e1d1-396d1017316mr3763840a91.13.1787864527601; 
 Thu, 27 Aug 2026 14:02:07 -0700 (PDT)
X-Received: by 2002:a17:90b:50c6:b0:38e:97f0:aa4b with SMTP id
 98e67ed59e1d1-396d1017316mr3763698a91.13.1787864526919; 
 Thu, 27 Aug 2026 14:02:06 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32854db74eesm12499672eec.18.2026.08.27.14.02.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 14:02:06 -0700 (PDT)
Message-ID: <0ea0b4a3-de63-4bda-b888-dcfe4cd9ac76@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 14:02:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 035/104] tests/tcg/multiarch/gdbstub/prot-none.py:
 detect if /proc/self/mem can be used to access PROT_NONE pages
To: Ilya Leoshkevich <iii@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
 <20260818192309.22169-36-pierrick.bouvier@oss.qualcomm.com>
 <87mru9oxyx.fsf@draig.linaro.org>
 <e98811cc-489b-433b-89be-a246492460e7@oss.qualcomm.com>
 <853eec97-f9a1-4e67-a125-51a6083d4f1b@oss.qualcomm.com>
 <b3451ce0-2d1f-4be4-9c22-1be491f21a94@linux.ibm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <b3451ce0-2d1f-4be4-9c22-1be491f21a94@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: LgFsV3kWSCSzluu_B902ju1SZM41z1X4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE3OCBTYWx0ZWRfX24PHn1RBRGbD
 6ZBPmWSxGbrmkquQvWoejrDXrhABrOFFuTDNybRoYwKsaN/oJPwwSvCMqchwdKdWud24fVjZ/XR
 Oamh++W8F47co2MbfDNkTxqaRoyCTwaEqQCDG9hnwwkcs4u5PAQjlnZ2rmrtA2dE2f4e/xx5Rjm
 xjbagUEABP/tA/DbaagzuWrHH+QLdQ3b2xv5KuyAZof6G2RrStB1mukVoF7L4Tne6CaI36aaD4i
 PH95/46o7u8v3SSWGwPmk1y9/esgOSqGWnE2P8ccyNJRN5YvJc7q2SCyMKvy5Zv6k5D6rUIU4UL
 WflhVSW0muHM6kHY7cMVFZRFAz35crRAAIKOYtuDxG8ZUjGLQqqaAM+JS2lzo/n/9NKgD/uD+ya
 LgOH3VvbjLC9luiU3+7/yE6cLetZ+kfpTa5uzFwWCnJ1qgsrv/GpFRFUXXn8tD3nT6EQVV4eJTT
 AwvWBwzhG2qDX/g6sQg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE3OCBTYWx0ZWRfX5o6tPYQ6dTUe
 NkeByZL51/yfRIVKs/SwcUJLE8E6JfHaRtdCEpPuwDOKdHLEpkFq4xUetSq3WKSuwX6SMZevx9a
 0C7gv5Muuh2+ATq8o60sFbRzcirnI68=
X-Proofpoint-GUID: LgFsV3kWSCSzluu_B902ju1SZM41z1X4
X-Authority-Analysis: v=2.4 cv=dd+wG3Xe c=1 sm=1 tr=0 ts=6a90a5d0 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=GcyzOjIWAAAA:8 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8
 a=JwAURsosnR-K66FmFEUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=hQL3dl6oAZ8NdCsdz28n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270178
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

On 8/27/2026 3:47 AM, Ilya Leoshkevich wrote:
> 
> 
> On 8/27/26 00:39, Pierrick Bouvier wrote:
>> On 8/26/2026 3:26 PM, Pierrick Bouvier wrote:
>>> On 8/26/2026 5:41 AM, Alex Bennée wrote:
>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>>
>>>>> Recently (July 2026), this issue became reproducible on debian stable
>>>>> with kernel (7.1.3) from backports. I suspect it's a default hardening
>>>>> of kernel related to recent CVEs.
>>>>>
>>>>> By tracking error reported, we can see that /proc/self/mem pread from
>>>>> cpu_memory_rw_debug in accel/tcg/user-exec.c returns an error
>>>>> (Input/Output error).
>>>>>
>>>>> Detect this situation directly from our gdb python script, by
>>>>> trying the
>>>>> same thing from current process. If this operation fails, we can
>>>>> gracefully skip the test.
>>>>>
>>>>> Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/3329
>>>>> Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>>> ---
>>>>>   tests/tcg/multiarch/gdbstub/prot-none.py | 35 +++++++++++++++++++
>>>>> +++--
>>>>>   1 file changed, 32 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/tests/tcg/multiarch/gdbstub/prot-none.py b/tests/tcg/
>>>>> multiarch/gdbstub/prot-none.py
>>>>> index e653bc697f6..393626a9798 100644
>>>>> --- a/tests/tcg/multiarch/gdbstub/prot-none.py
>>>>> +++ b/tests/tcg/multiarch/gdbstub/prot-none.py
>>>>> @@ -5,6 +5,8 @@
>>>>>   SPDX-License-Identifier: GPL-2.0-or-later
>>>>>   """
>>>>>   import ctypes
>>>>> +import ctypes.util
>>>>> +import mmap
>>>>>   import os
>>>>>   from test_gdbstub import gdb_exit, main, report
>>>>>   @@ -18,6 +20,34 @@ def probe_proc_self_mem():
>>>>>       except OSError:
>>>>>           return False
>>>>>   +def probe_proc_self_mem_access_prot_none():
>>>>> +    libc = ctypes.CDLL(ctypes.util.find_library("c"), use_errno=True)
>>>>> +    libc.mmap.restype = ctypes.c_void_p
>>>>> +    libc.mmap.argtypes = [ctypes.c_void_p, ctypes.c_size_t,
>>>>> ctypes.c_int,
>>>>> +                          ctypes.c_int, ctypes.c_int, ctypes.c_long]
>>>>> +    size = os.sysconf("SC_PAGESIZE")
>>>>> +    # mmap a PROT_NONE page
>>>>> +    PROT_NONE = 0
>>>>> +    addr = libc.mmap(None, size, PROT_NONE,
>>>>> +                     mmap.MAP_PRIVATE | mmap.MAP_ANONYMOUS, -1, 0)
>>>>> +    assert addr != ctypes.c_void_p(-1).value
>>>>> +    fd = os.open("/proc/self/mem", os.O_RDWR)
>>>>> +    try:
>>>>> +        # read it through /proc/self/mem
>>>>
>>>> It might be worth pointing to it here:
>>>>
>>>> modified    tests/tcg/multiarch/gdbstub/prot-none.py
>>>> @@ -34,6 +34,7 @@ def probe_proc_self_mem_access_prot_none():
>>>>       fd = os.open("/proc/self/mem", os.O_RDWR)
>>>>       try:
>>>>           # read it through /proc/self/mem
>>>> +        # this is the fallback in cpu_memory_rw_debug
>>>>           data = os.pread(fd, size, addr)
>>>>       except Exception as e:
>>>>           print("/proc/self/mem pread error: " + str(e))
>>>>
>>>> I think the comment in cpu_memory_rw_debug is wrong through, pread
>>>> isn't
>>>> using the ptrace interface.
>>>>
>>>
>>> I'm not sure which comment you talk about (link to source?), but pread
>>> is absolutely not related to ptrace. It's just a read with a specific
>>> offset. seek + read can be used to achieve the same result.
>>>
>>
>> Comment is coming from this commit:
>> https://gitlab.com/qemu-project/qemu/-/
>> commit/87ab270429618c13a6bf6dfc90d5edf6a3fa99b9
>>
>> It's indeed incorrect, and seems like the alternative idea mentioned in
>> commit description.
>>
>> @Ilya: was it a leftover from when you tried to implement this with
>> ptrace?
> 
> I think what I had in mind when I wrote it was [1]:
> 
>        /proc/pid/mem
>               This file can be used to access the pages of a process's
>               memory through open(2), read(2), and lseek(2).
> 
>               Permission to access this file is governed by a ptrace
>               access mode PTRACE_MODE_ATTACH_FSCREDS check; see
>               ptrace(2).
> 
> But I don't think this is relevant for /proc/self/mem, that should
> always work.
>

It's technically correct (/proc/self/mem is a symlink to
/proc/$pid/mem), so kernel will check for ptrace access, but because
it's the same process, it's always allowed anyway.

> [1] https://man7.org/linux/man-pages/man5/proc_pid_mem.5.html
> 
>> Regards,
>> Pierrick
> 

