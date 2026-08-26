Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF7E0C61DBE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 22:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzMH6-0003IE-7F; Wed, 26 Aug 2026 18:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wzMH5-0003I1-Fc
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:39:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wzMH3-0007Dx-GA
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:39:15 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QKdN4m2583692
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 22:39:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kZEptwkVfAiP0/icey6BIiPGRqqgfzNl/wxt55ACeEE=; b=Pz8enmhuV1ne42G7
 vpndEiJN4aJd1/X3srQ4OoNbYnB8uVnMxSnsZ+sHWk9vqfZSE2Z/xnL5EUvd3PzU
 GxhUAhN463JYOr82rF+lk9e4GtwijSRAoa+p2S+o+AFahhQtgh1J/+ehtBDphrAt
 icsyRoT0XLjZyg0arKAREigOyjIgkrdvMeKswfcnjaj0RZqjNhKtzmiyYzwaudgM
 PZXudj7sog7jUwD30Bd48iAh694wPBz9qdD+mhsoHhkngtOxNmqo2Y5+SC4IpX6D
 Jk57Gb/LLGTXbC4Yk6VcgTF4bIeWMHUCHL8e6U/+IwOkoZiviX+OnDptwbwgjjNj
 plfR2Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga0wbt038-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 22:39:10 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38f57e31b6eso1750050a91.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 15:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787783950; x=1788388750; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kZEptwkVfAiP0/icey6BIiPGRqqgfzNl/wxt55ACeEE=;
 b=juoMd+eanBoy2RUld7K43bUA1zbn3Upfv1E7gNYnl7oROpA0slzGQ7wBQ8dKlLL4OF
 TSD2WPO/pEgSli7HmqHWdZ41ay8WAWgqwqUE5++EvpBVmbWrnjZqhY9TN463j3wL/93b
 wkVf5OLfyNFbB8tTi6HtTlMTMJG09VIfEPe/BCRAqY7nDsd1n/0nMduEDxGiVzWgP/Hu
 9ItV1+ZEphkL7suNn60M1Dme0ulMRbHIL1+HbodZrS00ZQzfluKwKJStJC29Gm/zfybS
 NnyvQx3QwlEiiKELgydDeayUZmpBkrN6SM+xSawUh6swBz355bqTGf5PUQ87pvA6UuI2
 JG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787783950; x=1788388750;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kZEptwkVfAiP0/icey6BIiPGRqqgfzNl/wxt55ACeEE=;
 b=E3BsVAaaeQ7cp44wZxZW1X+SWlGY/a13Ql97wVK/P9g03rYWw6hiLqRDBS6aTYvsKy
 PaExTV+iL/97YaXq8/fG3G6KrpizW4U1rjdd9GPVzO/tYBn9lv0DBRgdufB/lZPHqSyP
 VNvsZOrzxDNHUZaxIdT0dCwrpxAYWJqXHdDbcGm51AT88eVooQqiuLPYXNhv2DW/dd7W
 FJaA6bY9CHLG7VWIPOs7Npl86K46FGGGn3GtO6PT8KBgSaKP0h71nos27S8+uxyb5wc2
 JHZx0Ga613DWwg72eYZkQhrglEak9nRtPIxNBVSIjTV+Y/D4piUhbFIiOTpTvDr75YNF
 PCVw==
X-Gm-Message-State: AFuF++ks4sdJFajYJ73FsqYZbkZtYlVcRSvS/so8L9o/or7wnpmnq+Ig
 ir4Qrw3/w7VQKj+Yh5DybsXiXKUKLHg3eN2nesRuZsOl9sQeTCx7QmqSGSQnNsjmsofPqfUNVa9
 JGsiOiJIyy0i1ELaqu+H89Bl+hYz6O7xv8Ewks44QczwaJiWTx5R/LjjgdA==
X-Gm-Gg: AR+sD113LxMZZtem2LbEZ1qbsFARjRupHpI4qiWkXduOkjXs0VgbdutxgKiIZjoWvYT
 Y+wlsQ9mpGANjPYPKTZk2q/TWwsWgrWUjV1DeuPUXmgEJNZr64EZdTTchy8noth5MD6E8wLwjtO
 +NM8QisD1HKm7xuYfS0Boll6FZWJBU1XYUFFGF73Ann2V1cm39AeI/bxjZuUJAmNE30PVPS2Pci
 BF9JAVlTyQinFzXSRf2Nfj5TNQNO6aYluDiQKwVe47icerTQT3Fnc6Ij8qxs/oGGuLeLIB0MNCX
 KT2lELJfOmPjhoH6yRSG5mcEBA907fU4kFgsT61wOT0qOheRVDBqW/5Z7JUpsctUPL+cge3067W
 wtXkqjTSkQW76YOUwdL3bNaj34g/Wz9Tkd6C1UqSiXtehphtWrJYaCG35MfoUB8BcQiIU
X-Received: by 2002:a17:90a:d2c7:b0:38e:75f3:ad4d with SMTP id
 98e67ed59e1d1-3966d1f21d1mr23564819a91.7.1787783950061; 
 Wed, 26 Aug 2026 15:39:10 -0700 (PDT)
X-Received: by 2002:a17:90a:d2c7:b0:38e:75f3:ad4d with SMTP id
 98e67ed59e1d1-3966d1f21d1mr23564731a91.7.1787783949621; 
 Wed, 26 Aug 2026 15:39:09 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3283d730c3csm12502372eec.9.2026.08.26.15.39.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 15:39:09 -0700 (PDT)
Message-ID: <853eec97-f9a1-4e67-a125-51a6083d4f1b@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 15:39:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 035/104] tests/tcg/multiarch/gdbstub/prot-none.py:
 detect if /proc/self/mem can be used to access PROT_NONE pages
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
 <20260818192309.22169-36-pierrick.bouvier@oss.qualcomm.com>
 <87mru9oxyx.fsf@draig.linaro.org>
 <e98811cc-489b-433b-89be-a246492460e7@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e98811cc-489b-433b-89be-a246492460e7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 3QHYhu7CXpZsSgZyJSzWAUyS-gc_qIfL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE5MCBTYWx0ZWRfX6vri6eNBUy+p
 uOEp90aS7ZpaC++hnYPsSBv9RdeC3dmCmmMOD3Cx33x5Ku5f6lcp571besl6iRRohnR2dive7CJ
 JtAqV/cj5GsgO99+uEtkIrB29XnTrSU=
X-Proofpoint-GUID: 3QHYhu7CXpZsSgZyJSzWAUyS-gc_qIfL
X-Authority-Analysis: v=2.4 cv=SoCgLvO0 c=1 sm=1 tr=0 ts=6a8f6b0e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=XKPqqtnNjiz4iyg-TSoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE5MCBTYWx0ZWRfX6EJYjAMr5Ie6
 43toROQ4Bo6NnU6DnM+fHfgzxQRngjFciXxodd3Qk62CFPSPdsJwahRawai8OT3f2fIX6f2NBc4
 5kGdxSt30CA3mJJl+ETivWMgnTzTn1mdMBET3rh2TxNpLEllmqoBamLcPM8d5EPTeg/QTzobkst
 yBsdXg9nJG0MPQUQLBEopxVVypoz8CBK8YxM+IKPmlYEsjfDC+lJHWNPZJq4+xOmj0wG/cImx1Z
 c/izaHq5VfKiEA4LSiT+7IEN1qkVye9tpuMqI4TGncrg8LPlj356+gDpKtqKmCsAKfwyHhQhvMx
 dcMNwqOt/CGbav6bC/vEJ9LNoyT+4rOXMPOyIx4kJpAZNZwZ2RcL3kFT3d7DK7hULE8sO9UI5xX
 MTrV2eNTeMNrFbdFOHlJNJJBz9xxqW2cMpZKAc7lLDhcJfOY3f1xmvEJisAZeWkO5zEc0NKohVJ
 t6L3wRcSylGnis5ZT9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_06,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260190
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

On 8/26/2026 3:26 PM, Pierrick Bouvier wrote:
> On 8/26/2026 5:41 AM, Alex Bennée wrote:
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>
>>> Recently (July 2026), this issue became reproducible on debian stable
>>> with kernel (7.1.3) from backports. I suspect it's a default hardening
>>> of kernel related to recent CVEs.
>>>
>>> By tracking error reported, we can see that /proc/self/mem pread from
>>> cpu_memory_rw_debug in accel/tcg/user-exec.c returns an error
>>> (Input/Output error).
>>>
>>> Detect this situation directly from our gdb python script, by trying the
>>> same thing from current process. If this operation fails, we can
>>> gracefully skip the test.
>>>
>>> Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/3329
>>> Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> ---
>>>  tests/tcg/multiarch/gdbstub/prot-none.py | 35 ++++++++++++++++++++++--
>>>  1 file changed, 32 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tests/tcg/multiarch/gdbstub/prot-none.py b/tests/tcg/multiarch/gdbstub/prot-none.py
>>> index e653bc697f6..393626a9798 100644
>>> --- a/tests/tcg/multiarch/gdbstub/prot-none.py
>>> +++ b/tests/tcg/multiarch/gdbstub/prot-none.py
>>> @@ -5,6 +5,8 @@
>>>  SPDX-License-Identifier: GPL-2.0-or-later
>>>  """
>>>  import ctypes
>>> +import ctypes.util
>>> +import mmap
>>>  import os
>>>  from test_gdbstub import gdb_exit, main, report
>>>  
>>> @@ -18,6 +20,34 @@ def probe_proc_self_mem():
>>>      except OSError:
>>>          return False
>>>  
>>> +def probe_proc_self_mem_access_prot_none():
>>> +    libc = ctypes.CDLL(ctypes.util.find_library("c"), use_errno=True)
>>> +    libc.mmap.restype = ctypes.c_void_p
>>> +    libc.mmap.argtypes = [ctypes.c_void_p, ctypes.c_size_t, ctypes.c_int,
>>> +                          ctypes.c_int, ctypes.c_int, ctypes.c_long]
>>> +    size = os.sysconf("SC_PAGESIZE")
>>> +    # mmap a PROT_NONE page
>>> +    PROT_NONE = 0
>>> +    addr = libc.mmap(None, size, PROT_NONE,
>>> +                     mmap.MAP_PRIVATE | mmap.MAP_ANONYMOUS, -1, 0)
>>> +    assert addr != ctypes.c_void_p(-1).value
>>> +    fd = os.open("/proc/self/mem", os.O_RDWR)
>>> +    try:
>>> +        # read it through /proc/self/mem
>>
>> It might be worth pointing to it here:
>>
>> modified    tests/tcg/multiarch/gdbstub/prot-none.py
>> @@ -34,6 +34,7 @@ def probe_proc_self_mem_access_prot_none():
>>      fd = os.open("/proc/self/mem", os.O_RDWR)
>>      try:
>>          # read it through /proc/self/mem
>> +        # this is the fallback in cpu_memory_rw_debug
>>          data = os.pread(fd, size, addr)
>>      except Exception as e:
>>          print("/proc/self/mem pread error: " + str(e))
>>
>> I think the comment in cpu_memory_rw_debug is wrong through, pread isn't
>> using the ptrace interface.
>>
> 
> I'm not sure which comment you talk about (link to source?), but pread
> is absolutely not related to ptrace. It's just a read with a specific
> offset. seek + read can be used to achieve the same result.
>

Comment is coming from this commit:
https://gitlab.com/qemu-project/qemu/-/commit/87ab270429618c13a6bf6dfc90d5edf6a3fa99b9

It's indeed incorrect, and seems like the alternative idea mentioned in
commit description.

@Ilya: was it a leftover from when you tried to implement this with ptrace?

Regards,
Pierrick

