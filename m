Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892CEC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 22:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzM4n-00008o-4u; Wed, 26 Aug 2026 18:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wzM4l-00008Z-2X
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:26:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wzM4j-0004MS-A9
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:26:30 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QKdlxH1465042
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 22:26:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8qUSLCZhmv1qZlSEWG0Gd8Wv6JPY170Z/xoBrv+ZDzY=; b=N2yMSDFPZ0mDr4Ul
 AqfN9QYYHjVaynQogMo48SjPvk35lQ3/V6vX8t3LX57PK0cCjTUXPRjFRl6GHlFf
 oQNzYoYIVW6do4taosmfRAwJ4b9C0akDQGBQd0IlWfakwxK4b4bk8qu91SQrId+j
 qWgKUF/0A/lY27VD31ouZgrE5FiZJQHGbe/v4jCmhCa75usd6SGqesO1xkzASdxP
 QoQUOluGuktGK3OTRcEmYIQakSc5ksPjcrBbJlSVOsiovlve9AfZ5wGk0vwAEix7
 Tquy7e7H68NTymnRg8QNzWcFDQq+sq65uslxKcI/THlqpaO2/bLMJxiBrQdHcOey
 yDhVHQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga4fwh1c1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 22:26:26 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-396638f9a18so2702323a91.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 15:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787783186; x=1788387986; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8qUSLCZhmv1qZlSEWG0Gd8Wv6JPY170Z/xoBrv+ZDzY=;
 b=iL3C9PweoTtlILCekSSyLPtzurer5z0F3zEJThAvMb3bdXPXLVu7lx5KhkP0YkpZK8
 4lMKjz42JtbLufnfNfe5aN9UFUK/2WRmIO3p/AtrXErw3Tuxe6cCW7vbQjabeAiiGYiU
 3jqb6We3iWS8c+UBqmSDF8Z01E6fRUy9Px8u85uQvAGfc5WBJE5Lv5mB4Za4ubfPJzpn
 aJGsUdv1/yQZ+ZsJAm/Sj0+4QfnCVkiNTKGzT+9+G5pTLTNP9gmIwkqsB2LHCw6zNG7n
 1A+4FvULlebD78oz90V2t3+AC5NKgVqVkt3SuzELE8FMC5W5hi8ALp5mryVgSpCYe8tQ
 zyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787783186; x=1788387986;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8qUSLCZhmv1qZlSEWG0Gd8Wv6JPY170Z/xoBrv+ZDzY=;
 b=Kk7jue2MUqnssQyXypqEgf6eRx9VXTePVSMDHzRecU3oABHYRrzrNn49U47CINAmNi
 FC7jLqBjbJZzT0R/r+6LdWDE9FnK+vDWLXU5/mjfIiVwgniEsVs88vqXEdskIZK7LSa/
 H/A2pdgfgC5ZqVX0rwUtBms3u3VMlJwkeIBtNNVHSesJzk4b89bVtHyhhzIrdfvLynEZ
 kx96REGrUxqtux0876QE8qt1aLpWc/PCnM0c9A9jQ/FsRY6c7JHrG+u+Bsjq6n1eMknr
 +W5No3SDq1bB/r+Dgf8lh4vC2VHXxUUKZVYxglc5UpX0NLa1SQ28CbKbvOQT2TCfJhGI
 zowQ==
X-Gm-Message-State: AFuF++kRY5dNVbhXOLvPtsUE4vaOiD3qn/ltplHmyFb4905O+468tU8N
 C5MoIB5fDLvlZZh67QC+iLxY0+BI+Z/0Me1+E211le89i5HKZe2JE6YJUgMR2NCvcidFTZ3XUDr
 +n6MokkrYpR/0J2v5+pJX2r/q1yAkLC54O40hG8whr1aQxIDcp7ROawvi2Q==
X-Gm-Gg: AR+sD11cAesatf8ao+HkyJyJN8Vwr98jRjnZ40X2z/potr0/QM8WrvLRMv2bIhJOcqO
 n+8kdl7fhsyEzJddKUxVEI2yg8qzs99zobmddS6nLjZ1iJIfGroPCyzC1YNzdiWAC7D8G/QFwre
 zJzFh9+goj2qObwilcsjjiLcUiSwjgxgy+XlqZHPM7QNhCeqzIkiY8bqiWgpSjqzcPD/ZxNV6Nv
 flCnE+S1ePk9JecOZod1NfaKvu2N9D3u7akqyqzs8nDoSojzJjDoJbYsHHRQs1Wd+58SCt8wQFr
 CIArCBsGywv7OzHVTp5q1NobhBpvVOPk/zA+ANW+W4mwzhyRTUrSvRWfkIMz5tO7uet3MH+CAHM
 LhujLSrFNAnBsN7IkGpcSKljdNECQRS4LzxCuYk52c8KrjN2JLcne58rGK5V+bVFY5Tl3
X-Received: by 2002:a17:90b:530c:b0:38e:b400:a860 with SMTP id
 98e67ed59e1d1-3966d443d6bmr19238974a91.13.1787783185873; 
 Wed, 26 Aug 2026 15:26:25 -0700 (PDT)
X-Received: by 2002:a17:90b:530c:b0:38e:b400:a860 with SMTP id
 98e67ed59e1d1-3966d443d6bmr19238884a91.13.1787783185416; 
 Wed, 26 Aug 2026 15:26:25 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3283d884d5esm11667269eec.17.2026.08.26.15.26.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 15:26:24 -0700 (PDT)
Message-ID: <e98811cc-489b-433b-89be-a246492460e7@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 15:26:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 035/104] tests/tcg/multiarch/gdbstub/prot-none.py:
 detect if /proc/self/mem can be used to access PROT_NONE pages
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
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87mru9oxyx.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lfmsEZ_A7rPJ6AeJQ6FpGTkVbHv99B5v
X-Authority-Analysis: v=2.4 cv=OtZ/DS/t c=1 sm=1 tr=0 ts=6a8f6812 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8
 a=AFqthKxHHmGxGxEoxEgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: lfmsEZ_A7rPJ6AeJQ6FpGTkVbHv99B5v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE4OSBTYWx0ZWRfX4rDNHqs0yQRQ
 iS55MzotlwOmV4oZoYj+mwM0DML2m90ckhh61Lx6daotL/hqSLvbMmXu88hseFvtAdRtZYxWf14
 uLsxhNfL/fGkmZ4CnDOKCqjYDYp8RfDU4K46pwm9EwnNY921IM/UgFkRjC07TTTSmPHETUWdqzW
 Ls1MYUFRy0uf2/KmP004PpxO38pAqNo+CBJOKYFXRFDquL8yZDxeDXTy/HwRcSizGWL293wanNR
 Hvh1vv6I4YIAgXaBn+JKRYEzaghIR4bnG8JgdbhykoE2GqGES9lUTpNFCiQlYvwlkCZE8PdGSow
 2vftfMREqEZqiuohgQ878+lpGHbXrH4PMD+qvoJiKVGzztTyvuGKFy34BdT0SdUskoXqjVZCxhm
 4Fc+F+aTtHhH5Fq+YPYsKzxOE72qnvQrITQ89evtG51/n+7CIvKSSrFN7PBK84D3DNhIYo/Namm
 nD/GtW7oNKCOBO7vkvg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE4OSBTYWx0ZWRfX1dty5siOpR85
 YmO5iyGwDaRbQqmtoFO7Wmq/8PvsQzorlViV0onSIJO/pall6b2ZXhAc5fIaybW6Mc1QHmX7/Bf
 NEI8M1bcxBDn/ZEhkv+P34VYDWl6BDI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_06,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260189
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

On 8/26/2026 5:41 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> Recently (July 2026), this issue became reproducible on debian stable
>> with kernel (7.1.3) from backports. I suspect it's a default hardening
>> of kernel related to recent CVEs.
>>
>> By tracking error reported, we can see that /proc/self/mem pread from
>> cpu_memory_rw_debug in accel/tcg/user-exec.c returns an error
>> (Input/Output error).
>>
>> Detect this situation directly from our gdb python script, by trying the
>> same thing from current process. If this operation fails, we can
>> gracefully skip the test.
>>
>> Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/3329
>> Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>  tests/tcg/multiarch/gdbstub/prot-none.py | 35 ++++++++++++++++++++++--
>>  1 file changed, 32 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/tcg/multiarch/gdbstub/prot-none.py b/tests/tcg/multiarch/gdbstub/prot-none.py
>> index e653bc697f6..393626a9798 100644
>> --- a/tests/tcg/multiarch/gdbstub/prot-none.py
>> +++ b/tests/tcg/multiarch/gdbstub/prot-none.py
>> @@ -5,6 +5,8 @@
>>  SPDX-License-Identifier: GPL-2.0-or-later
>>  """
>>  import ctypes
>> +import ctypes.util
>> +import mmap
>>  import os
>>  from test_gdbstub import gdb_exit, main, report
>>  
>> @@ -18,6 +20,34 @@ def probe_proc_self_mem():
>>      except OSError:
>>          return False
>>  
>> +def probe_proc_self_mem_access_prot_none():
>> +    libc = ctypes.CDLL(ctypes.util.find_library("c"), use_errno=True)
>> +    libc.mmap.restype = ctypes.c_void_p
>> +    libc.mmap.argtypes = [ctypes.c_void_p, ctypes.c_size_t, ctypes.c_int,
>> +                          ctypes.c_int, ctypes.c_int, ctypes.c_long]
>> +    size = os.sysconf("SC_PAGESIZE")
>> +    # mmap a PROT_NONE page
>> +    PROT_NONE = 0
>> +    addr = libc.mmap(None, size, PROT_NONE,
>> +                     mmap.MAP_PRIVATE | mmap.MAP_ANONYMOUS, -1, 0)
>> +    assert addr != ctypes.c_void_p(-1).value
>> +    fd = os.open("/proc/self/mem", os.O_RDWR)
>> +    try:
>> +        # read it through /proc/self/mem
> 
> It might be worth pointing to it here:
> 
> modified    tests/tcg/multiarch/gdbstub/prot-none.py
> @@ -34,6 +34,7 @@ def probe_proc_self_mem_access_prot_none():
>      fd = os.open("/proc/self/mem", os.O_RDWR)
>      try:
>          # read it through /proc/self/mem
> +        # this is the fallback in cpu_memory_rw_debug
>          data = os.pread(fd, size, addr)
>      except Exception as e:
>          print("/proc/self/mem pread error: " + str(e))
> 
> I think the comment in cpu_memory_rw_debug is wrong through, pread isn't
> using the ptrace interface.
>

I'm not sure which comment you talk about (link to source?), but pread
is absolutely not related to ptrace. It's just a read with a specific
offset. seek + read can be used to achieve the same result.

> Otherwise:
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> 


