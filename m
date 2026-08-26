Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DD9C61DBE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 22:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzMAs-0001sC-VE; Wed, 26 Aug 2026 18:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wzMAq-0001rt-Um
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:32:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wzMAo-00060l-U7
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:32:48 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QKdbkm1380060
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 22:32:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RnMGgzMBMuEJvbS0qpvKbC80N2iJQk9SSYSWVvsf+GU=; b=S2h0Ujf0znIY0Ywy
 D82YLkxsPdOwvYypopjxly574E/bC580qkECBYgq0aODpNdu7A754rGIn57dISz5
 qo+7Ac+qWGeLZQB8VlnbYcSLBwY2lAoJr7ClYK87KpyfqwjVmqlKhp/fF8hl0wGQ
 zWkPrzjlXVQO/vBeFO9A4X6KCzqQMR4FHEV4UcLeAxEpVmMolck4DpLrY5bamXQf
 jMu3VMbteNzoO3vFw6fn+axWOea5sieFZWkqvWqC9hDJ3Q3o54Z6dVrASqLmmmLO
 1TAw/yKkzbSK3rj3YcEapwaroQkmvIfqcHVv7pVFovP4H0iWsfqzDCNraUAx6qdD
 2hsoSg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga03u2970-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 22:32:44 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3968bb86fb7so1132789a91.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 15:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787783564; x=1788388364; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RnMGgzMBMuEJvbS0qpvKbC80N2iJQk9SSYSWVvsf+GU=;
 b=bFRg5t7cXNYM/yQGi/AGlHp6CfR5+sGhAygye5Vwt6u56tWWTmNs7C5zXEw3Fentyc
 jmqOKrrzuGtUr6LouXu8ovcvO8UpbCUh8atlCzSzsTsjB6eOAJa1MJHNgULOlWuvnYqo
 JUOZZS7WEndeDySIywp7Z8k9MFDpd9BTvURIXTiJuh4Jb4Bu16GQSPniWhRo6y/75EGU
 F4T6U3Z662FOfIFK2NEGiYzkub4hN0F+YqQn8+5hsqA/FdwPH7Wof+jf8YgXJDK3jLLT
 kZ9fBSVGUq8tshnBop/2e4FmIO9U2Q9gtX352l/Su1H02Rycm5i6gaGfZtmgb8bXdZXV
 OUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787783564; x=1788388364;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RnMGgzMBMuEJvbS0qpvKbC80N2iJQk9SSYSWVvsf+GU=;
 b=c/JQKpXnqgUAdrCdg+kyO5YjZACBlZ3XIX+d19Tpz33TKafJUdYGmJ3hLFfFNrz0u/
 Wn2S1wGKPZjGIzZAdKOHizZKWEY7qiwW8ODlkfve+Nlr5ljvbdGsar5PC+sljHyy1NHC
 QHS/xKJvggEdpVSLlHs/qW+nDGpic3OB7l9seaAM53UYWJkaxyvotI3nwhPZ0kjCGht1
 qSFsLw1NzoXImiQqEjaqM2hG6vMpT3NHB2yHnLt11VazaROn6qSpNJsS7VXKnDB+t0pY
 7T34UQFkkllJz7m2LLc9QpmrGvQiHWxmsPvBdaNwGg7YeoMFX0CR7bj0wf4BdD2CkYD0
 Nbqw==
X-Gm-Message-State: AFuF++m4EmDD3R+oC9OZIcIWs37YHpX7dHKluuqR2XnB4rgIGrDdTtCh
 i9y7J1CK2y/16v7jxCERuVffklzu6LF1ycz+wUDeUjZgBAPGmkloILxriUXsMU/SZ41O69vRl6w
 c3ERV+8UE3NoX7KTOFQHLsvg8KRDA2MGPnbCIz323AkF5QCxWHt4JTLKbGg==
X-Gm-Gg: AR+sD13kZEDBuZz5GMNpYpBgcw170umqTw3rybe8X8vUIcTEk8hKOSzyVy1le7ILjls
 vmNLhSFMeSBBKwuzwWKRaIpQDZQq+K1bk5nIRkzI1t+h3CrU+vNgfau9Jot5J3xNWNq6GFewj/U
 A/5ngOaRjAZySpnAYDevfeqaXGFnBo1G8YPJGSd6WberBZsaF4nNfthEcbNnq1wxQ1TfR93KfPV
 7jXEMS+risLPTaDqWsMhIzxtZ73jk918DKvJXGhP0zf6Jp+ts9XshwQjG5Wm8+flipnMJdxX2YX
 eybfxHzxqFFtqnj5QbLrM0VAjYI/h/U9FiTgNgQ1/3PK5UTxiHc+AnJbzrp6TEgbvYAppgp5tyY
 bRpCr1s9urnL+YZZ7dBqUzf45FJz6JaYa9dkTXFEpZ4nhnwdcSXgfx0azhT4/PaFPyNRJ
X-Received: by 2002:a17:90a:d60f:b0:392:6638:2e6a with SMTP id
 98e67ed59e1d1-3966d44aa98mr22273044a91.13.1787783563958; 
 Wed, 26 Aug 2026 15:32:43 -0700 (PDT)
X-Received: by 2002:a17:90a:d60f:b0:392:6638:2e6a with SMTP id
 98e67ed59e1d1-3966d44aa98mr22272952a91.13.1787783563522; 
 Wed, 26 Aug 2026 15:32:43 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3283d60d25esm13617573eec.4.2026.08.26.15.32.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 15:32:43 -0700 (PDT)
Message-ID: <22268dff-506c-4608-8d4f-bf4f5ec6bc4e@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 15:32:41 -0700
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE5MCBTYWx0ZWRfX4TEbFi7IaqRD
 w0cmhF3ZnJSEpp4yAIAZSZYS/UQZDhKGP9pRoX5hfJ2wQ12C230YdUqp8Z8hjJ7/0n7f86//hf0
 MCPMOncXyNDIDKyLNHUUY/DapkxJqM+ih3mDtKIRxlVfhgh1tK06LtWg3HR/bqYWWxSAbsYpLE+
 mgWIY2IPkcOjfwbKkwc7C1VA82atdzmdVTAzghI+1J81SyBZle2kOr3c8zX0uQw8u0ATBIoAWHL
 SdcH2XUorhQ7dGfFESw1G3LqYXmMK7tDh+y6vP2NOSMMK67DdE0ySh/fx6oO8JndJH/gqaxdOhM
 fC6OCeymFjfVGSNPJlJlX6tq0yVEzfx81S/zbgT+CnWWJ3rGsaB9S64avT/czpAeRkVGD2R+QpX
 WPFRx+o1z7+hI8MsNpgmbqML50QxobV6RJw4kaTJeYOlVNyeliYOtEGE8g+KDMj1wP3rPNDsOxR
 SzP/MkA+KYubUgRbaBQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE5MCBTYWx0ZWRfX24KUAJ6Mxshp
 LoPVqRxCNmBp2xpB+mrL1ZKPYaULOe+DSfrFR0fbvAFXuvhfNs8CZ54EOWsOi6UJVXmoeC5FTAB
 wjjBWdM1y3dl8ckPRwdEpKSjEkYMJ+g=
X-Proofpoint-ORIG-GUID: r4gZSkZOYMRSszdlPqtk60PUyafmrlxF
X-Authority-Analysis: v=2.4 cv=RcqgzVtv c=1 sm=1 tr=0 ts=6a8f698c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8
 a=iokFPoVa9C6NMrLyFB0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: r4gZSkZOYMRSszdlPqtk60PUyafmrlxF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_06,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260190
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

Added.

>          data = os.pread(fd, size, addr)
>      except Exception as e:
>          print("/proc/self/mem pread error: " + str(e))
> 
> I think the comment in cpu_memory_rw_debug is wrong through, pread isn't
> using the ptrace interface.
> 
> Otherwise:
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> 


