Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E65C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:48:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzXeM-0007pU-7g; Thu, 27 Aug 2026 06:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1wzXeK-0007pH-De
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:48:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1wzXeG-0000q5-9S
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:47:58 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R9VaZT2582047; Thu, 27 Aug 2026 10:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=6WPr2S
 Jj1CmDg5gcKNUe06+2l5dsbKGhhT/7kX9WBsQ=; b=ccDMiHlFrXx196j+EJ1cHE
 FRDxkrzf6bqKpAXT0P14JzDUZDwBGDw5HcfNYkDBLbTa5gegplMtj7HJCIMFQSE+
 afZHB21i3fR4S6/GvOLLpVgu9XJS2HLQ7ypm8Nqzt7BgMd+VRdz8wXCR2t951wau
 BKcoSNy3edTYpSE8HrIUumS5lHErGdCa8PZJeXqzb/uFefnSAkZ8bXfdBF5NCFGu
 glpK0Ri6Rl43gc9nx/p3CjxLfH7c82prsBE5Ja2vnaJOHE0sXe8lEqn/chERTA6R
 Zb5IwTJD7MrC/Ppt6RRoaLqsuPKHUcrIhHH04H1Vk4P9j1sDr+HPP9YzxS/pu+lg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7394ctkh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 10:47:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RAfO0h008800;
 Thu, 27 Aug 2026 10:47:50 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3k7j4f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 10:47:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67RAllvO51904792
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Aug 2026 10:47:47 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 57B922004D;
 Thu, 27 Aug 2026 10:47:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E219C20043;
 Thu, 27 Aug 2026 10:47:46 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.64.177])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Aug 2026 10:47:46 +0000 (GMT)
Message-ID: <b3451ce0-2d1f-4be4-9c22-1be491f21a94@linux.ibm.com>
Date: Thu, 27 Aug 2026 12:47:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 035/104] tests/tcg/multiarch/gdbstub/prot-none.py:
 detect if /proc/self/mem can be used to access PROT_NONE pages
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
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
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <853eec97-f9a1-4e67-a125-51a6083d4f1b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 6RSEtUFjnxWJNH-rrQSYbKy7lTo_57cK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA4NyBTYWx0ZWRfX+EQN4yTl/Efz
 9DDD5Ub/9ERvXAIqu99jH+cXkbuYAIHpYdKSp5wy0U8rzC1gkuQ/wmRu5YiAa1UycN7nnA5Keec
 V1MVzhEv5PAyNf6uAZgnq2JIZxlqxv5wZ5O8AReBiq51gWgywnO8i9cJgcv5MlqPVuxHdk52Pe5
 RRwPiChlwIlXsnT8lLnoIKZVYB5JNpXlfBDmOyjWfkK16rzJclxxpyvFKlNcTHFibX2/L++VEvP
 r8mNq1hw9nKbz/+BEeaqogCmLudRhz1us5cXzX9ILVCJcVLwDlV6QmbM8vyh7FjEvdfbdkej1LM
 4vJT8CNsYaa38/8Ldlggd3ECwNj52jxsl0SHDGPThKD5n4s6QoC8bDlLbHsvWnfS0/Rtrbh0zZ5
 xcxhVjhLit+PDzn+z7vU8HO2c9MT6WxTg4Lnyh0cuF0wRHvF+bryqjpTSudxyhv5b79t1JUeFzo
 MOD1ngrEdQUK2SNqlrw==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a9015d7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=p0WdMEafAAAA:8
 a=GcyzOjIWAAAA:8 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=Ea45Ija9ffq4WqWH2pAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=hQL3dl6oAZ8NdCsdz28n:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA4NyBTYWx0ZWRfX9TL2N/IPgZME
 Heg88e0od0Aex3p7nrQ5jgdMK56uTej4qftdZnzbplDA0LOphwTl50v/+/YkCjbmCVw5r0p/gCr
 EK09F2HvV5rYP97E3KIvNfhOFA2GCpw=
X-Proofpoint-ORIG-GUID: A25ene7UZi62WCg0NVujmfq1TOG1Wlz1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270087
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 8/27/26 00:39, Pierrick Bouvier wrote:
> On 8/26/2026 3:26 PM, Pierrick Bouvier wrote:
>> On 8/26/2026 5:41 AM, Alex Bennée wrote:
>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>
>>>> Recently (July 2026), this issue became reproducible on debian stable
>>>> with kernel (7.1.3) from backports. I suspect it's a default hardening
>>>> of kernel related to recent CVEs.
>>>>
>>>> By tracking error reported, we can see that /proc/self/mem pread from
>>>> cpu_memory_rw_debug in accel/tcg/user-exec.c returns an error
>>>> (Input/Output error).
>>>>
>>>> Detect this situation directly from our gdb python script, by trying the
>>>> same thing from current process. If this operation fails, we can
>>>> gracefully skip the test.
>>>>
>>>> Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/3329
>>>> Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>> ---
>>>>   tests/tcg/multiarch/gdbstub/prot-none.py | 35 ++++++++++++++++++++++--
>>>>   1 file changed, 32 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/tests/tcg/multiarch/gdbstub/prot-none.py b/tests/tcg/multiarch/gdbstub/prot-none.py
>>>> index e653bc697f6..393626a9798 100644
>>>> --- a/tests/tcg/multiarch/gdbstub/prot-none.py
>>>> +++ b/tests/tcg/multiarch/gdbstub/prot-none.py
>>>> @@ -5,6 +5,8 @@
>>>>   SPDX-License-Identifier: GPL-2.0-or-later
>>>>   """
>>>>   import ctypes
>>>> +import ctypes.util
>>>> +import mmap
>>>>   import os
>>>>   from test_gdbstub import gdb_exit, main, report
>>>>   
>>>> @@ -18,6 +20,34 @@ def probe_proc_self_mem():
>>>>       except OSError:
>>>>           return False
>>>>   
>>>> +def probe_proc_self_mem_access_prot_none():
>>>> +    libc = ctypes.CDLL(ctypes.util.find_library("c"), use_errno=True)
>>>> +    libc.mmap.restype = ctypes.c_void_p
>>>> +    libc.mmap.argtypes = [ctypes.c_void_p, ctypes.c_size_t, ctypes.c_int,
>>>> +                          ctypes.c_int, ctypes.c_int, ctypes.c_long]
>>>> +    size = os.sysconf("SC_PAGESIZE")
>>>> +    # mmap a PROT_NONE page
>>>> +    PROT_NONE = 0
>>>> +    addr = libc.mmap(None, size, PROT_NONE,
>>>> +                     mmap.MAP_PRIVATE | mmap.MAP_ANONYMOUS, -1, 0)
>>>> +    assert addr != ctypes.c_void_p(-1).value
>>>> +    fd = os.open("/proc/self/mem", os.O_RDWR)
>>>> +    try:
>>>> +        # read it through /proc/self/mem
>>>
>>> It might be worth pointing to it here:
>>>
>>> modified    tests/tcg/multiarch/gdbstub/prot-none.py
>>> @@ -34,6 +34,7 @@ def probe_proc_self_mem_access_prot_none():
>>>       fd = os.open("/proc/self/mem", os.O_RDWR)
>>>       try:
>>>           # read it through /proc/self/mem
>>> +        # this is the fallback in cpu_memory_rw_debug
>>>           data = os.pread(fd, size, addr)
>>>       except Exception as e:
>>>           print("/proc/self/mem pread error: " + str(e))
>>>
>>> I think the comment in cpu_memory_rw_debug is wrong through, pread isn't
>>> using the ptrace interface.
>>>
>>
>> I'm not sure which comment you talk about (link to source?), but pread
>> is absolutely not related to ptrace. It's just a read with a specific
>> offset. seek + read can be used to achieve the same result.
>>
> 
> Comment is coming from this commit:
> https://gitlab.com/qemu-project/qemu/-/commit/87ab270429618c13a6bf6dfc90d5edf6a3fa99b9
> 
> It's indeed incorrect, and seems like the alternative idea mentioned in
> commit description.
> 
> @Ilya: was it a leftover from when you tried to implement this with ptrace?

I think what I had in mind when I wrote it was [1]:

        /proc/pid/mem
               This file can be used to access the pages of a process's
               memory through open(2), read(2), and lseek(2).

               Permission to access this file is governed by a ptrace
               access mode PTRACE_MODE_ATTACH_FSCREDS check; see
               ptrace(2).

But I don't think this is relevant for /proc/self/mem, that should
always work.

[1] https://man7.org/linux/man-pages/man5/proc_pid_mem.5.html

> Regards,
> Pierrick


