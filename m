Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E75606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 06:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fHfLvD/B;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i/yxLyLF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMJfn-0004zc-DV; Thu, 29 Oct 2026 02:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMJfW-0004z5-3i
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 02:31:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMJfU-0004f0-Ap
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 02:31:21 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T5HHnw177185
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 06:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iXl5ftCDupNZy/JVhsedkJSiXjcIN1U5uoyTTsFMrDs=; b=fHfLvD/BmGnZkgok
 GfsX9a8ybpsly1h2zlmsUlyA5HiEJ7e0CjlNCKIMuO+DvLxH9iZm91lJl8wYN6dv
 3pCvfmQIWU0mZFH3lL3Hbx981AEsnxCq14UqbPwQ4uCnpo7ITG0J+cY3v6L1EiHm
 0DaFkwrXkuDgRL4D9q8+jwIa7HCMkZGblIvWarAyWFMgQfeEnQHeR2Y3+TqJA3QC
 AIhPJ2oYvQ8trjsaIKedyPTnJI4V39h9XyTjWos2FWkvB/A3Zmzmg73vC3su5H7e
 anXxnWFH08+OkmOP7yv7QoOzvpKGS6TDZh1YXC9G12sPps3I0JmzGCfJcjAFJs3S
 62L1BA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkkehu80f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 06:31:17 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2eac6e96bd4so26139555ad.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 23:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793255477; x=1793860277; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iXl5ftCDupNZy/JVhsedkJSiXjcIN1U5uoyTTsFMrDs=;
 b=i/yxLyLFyB7GE/vyvbxi+YEFN+okJ3J5tBvIfeRjLCmFHWBfE2fnrcA9fWjv6yaFTC
 /SRCEqu8c55G7aY0S5rZY21WDzyyovfRf7g0/SKDX43LRH2a+ML61dR7A9qhA2DRkabW
 DsFSdgvUHVVFClxUvW5OWkWZwIB86y5TjwB/WZ6rIUbSKvsbhq1mStE6jNKav10gT/8F
 d/X1LPL/5Xxry7Ayp0qW0dPEomdWXh03Q0WsE38g1jREHBvv4JtHl9XoHeKtKe8pyj4I
 +pEdnHAqDUnKiFXYqTOrb2y3A6VwpJrEt1aqAc1m9Wq36LobkQxUPpuvUUm2Lk5C2GJH
 7j2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793255477; x=1793860277;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iXl5ftCDupNZy/JVhsedkJSiXjcIN1U5uoyTTsFMrDs=;
 b=ZeMzFHdF51zRGhxfwaVxYLMPYqdS8lIKy1tQ0g9TvKxJLvr3jf0YY29UFg7ilEWhwy
 LGmT9jpbGpioJ93lwoSiqz54ygFUFJtatoZfUmmHhDc71LoxGWmK2Y83wXYY/0h7vXIZ
 TP6qcgRBj+WTFSMiQwVIUL9VJqbEBfUQNqtoB1PCZCQ+otEnOF9WjkfM1QcqqxQ6ImG1
 iqU/tZ4RH9ANelLMknTMHWU9HraNwbDVjJe67rIz3epP6EzJjktYPQXct8YtyM/qIBOf
 rC29mRIEMavGM99TLPK9l4WTiGUQfRU9DXu5XWWuRCd20K87RtdbfTyG0l0o2/aR6g/T
 YTvA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzOOc7WiwXUMsH6ajBb+MnGSHP3f9FBEGAgQwwpEvQ3gw5JkixIa2LrRUqB+fJ3uul4tGFuRyTyMTqB@nongnu.org
X-Gm-Message-State: AFq9FYJQnhOAe7RncsmgrWv5kkg/aa68/Wwq9J7hJJHT8+d9bmCrQXnJ
 YT0u4LtSPZ5Gc7+V85RdquCH8o+ptNEqVrczmg9s17effJPc91tMhr81pY7lX97h+5em/n+1DSc
 YiMDpr5zpbgNabItMhTso4dcJhiT7SIGt9FS/aiW+fR7cyJ4ELiE41H6jzQ==
X-Gm-Gg: AYBFou0DRUf/l1/XZe/2/Dr1EbcF73mVAdNvFu0657pgK3bJK+u+M9sQeKTIL20LDGH
 tGf2fWe9y9xRgzWxpQ3NEMn+N+3BWtExdgnStWH5c/qA4fUFIdvhcdDJRafM6jAPBfCQKTT9a1Z
 G+Bgzqr/Vts708dtQtzy5UTFFuXQvMslKmoFsq8rMCFUorgESQxvHVk6Ud/q+mhpRvhDljSidnu
 8JJoJ7B0xW01dGnrphEJR0VwVzYOzX6GVN+n7+xu/5VVp2LXL9hlVaWSHhNERLLtpPNll3ojerf
 TdcI1QJKyDV7R88bxoy//MAnBsXL6ghzCUWzxkqCzHpgpPv/DcpBW1dP75ZFgB+1IVM/9fk38Kh
 yIrRAbwW3drlQTLk46q6zghQGlZRHZkFKFgzunCSutbnM5WA+w8mqiozN4c58QSTHA/RDrNuP7K
 XV0AbVdN2xwu0B0VEyada5krWi9Pn9yQ==
X-Received: by 2002:a17:903:38d0:b0:2eb:a1b:e9fd with SMTP id
 d9443c01a7336-2eb0a1bed3fmr30362965ad.41.1793255477156; 
 Wed, 28 Oct 2026 23:31:17 -0700 (PDT)
X-Received: by 2002:a17:903:38d0:b0:2eb:a1b:e9fd with SMTP id
 d9443c01a7336-2eb0a1bed3fmr30362715ad.41.1793255476680; 
 Wed, 28 Oct 2026 23:31:16 -0700 (PDT)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6b7a691sm29171075ad.26.2026.10.28.23.31.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 23:31:15 -0700 (PDT)
Message-ID: <d0069ed7-18c7-4918-8a43-a2f1cf084135@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 23:31:15 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] tests/guest-debug: Allow placing the binary within
 system QEMU args
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Richard Henderson <richard.henderson@linaro.org>,
 Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>
References: <20261028192538.31600-1-philmd@oss.qualcomm.com>
 <20261028192538.31600-4-philmd@oss.qualcomm.com>
 <efc20a14-3d7f-4a07-ac18-418176dce90d@oss.qualcomm.com>
 <ffeb9d35-33d2-43b7-8fcf-b06b41da76c4@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ffeb9d35-33d2-43b7-8fcf-b06b41da76c4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: uC5-sxtxNrBjgmZZrp787ivu8wKked3k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAyNCBTYWx0ZWRfX/ICtzrzZYvW2
 IG5IIy5/V9y0h5KiBnDeOBPnAENhd3037qmV+aS7WQ6/kemj5mcUFyq+9YrL5gXQArwqFgriOGX
 eipBKqb/PNI0l8cdYXm+W1DwugUv2mIIRKDC9d+A+vAsHK7Ap7jg7+ckuVv2h1jb1j8HDRITDIL
 sBEZEbSEoxFonQZFL4VUGdYvJ9jkn+z1EOcxBprWuyz1jctdaruWu11AxPNdVC4baY+iqwRj8ma
 vtpURhr17eR5wZ6oOMHvZlFGjkrS3uCRzHeqzfuJIVCAHdlN0WL8c75HEv7WiwOBhtOlz0qT0h5
 75/AylzYBpNqC6cfGoV6L8DEgIc3nepVizy/S/00oCRrAE4krfBlQy5W0XWBgGhhc/9YOCfZ6TR
 DQ8h8XjPLaXO3OaOSX2J4Pte1yTvmrjc1nuL6Njs9DNywZuzc1dP8uDA+zMUqvqIFWAgXixEgCC
 aDUkiinC8RZV2icQr5Q==
X-Proofpoint-GUID: uC5-sxtxNrBjgmZZrp787ivu8wKked3k
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAyNCBTYWx0ZWRfXyPiJ/8zaKfob
 Fu1QhcWX6oUUbkJGxhFhZZ3ZxQAkyB2mq7hfePK4dr1INsnqOCuQhHj3+RWOMDNVYDrh8+ZZ6PY
 pJxewsG8boevxHpJCfBczHX9T7zyi1I=
X-Authority-Analysis: v=2.4 cv=bYv+w+PB c=1 sm=1 tr=0 ts=6ae2e835 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=_AleZyxL_MbEFHomfeoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290024
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 11:29 PM, Philippe Mathieu-Daudé wrote:
> On 28/10/26 21:36, Pierrick Bouvier wrote:
>> On 10/28/2026 11:25 AM, Philippe Mathieu-Daudé wrote:
>>> In system mode the binary is appended to the QEMU arguments, which
>>> must end with an option taking it, such as -kernel. Machines without
>>> -kernel, like 'none', load it with the generic loader device, where
>>> the path is part of an option value.
>>>
>>> Replace @BINARY@ in the arguments by the binary path if present,
>>> otherwise keep appending it.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>> ---
>>>    tests/guest-debug/run-test.py | 9 +++++++--
>>>    1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
>>> index 9fdf05b55d31..e6911300e8d0 100755
>>> --- a/tests/guest-debug/run-test.py
>>> +++ b/tests/guest-debug/run-test.py
>>> @@ -87,9 +87,14 @@ def format_cmd(cmd):
>>>    
>>>        if "system" in args.qemu:
>>>            # for system mode we assume qargs has set-up for binary if
>>> -        # indeed we have set one.
>>> +        # indeed we have set one, either ending with an option taking
>>> +        # it (e.g. -kernel) or using the @BINARY@ placeholder.
>>>            if args.binary:
>>> -            qemu_cmd.append(args.binary)
>>> +            if any("@BINARY@" in arg for arg in qemu_cmd):
>>> +                qemu_cmd = [arg.replace("@BINARY@", args.binary)
>>> +                            for arg in qemu_cmd]
>>> +            else:
>>> +                qemu_cmd.append(args.binary)
>>>            if not args.no_suspend:
>>>                qemu_cmd.append("-S")
>>>            qemu_cmd.extend(["-gdb", f"unix:path={socket_name},server=on"])
>>
>> A bit implicit, but good for me.
> 
> Indeed; I updated the script help output:
> 
> -- >8 --
> diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
> index e6911300e8d0..74844a64d42b 100755
> --- a/tests/guest-debug/run-test.py
> +++ b/tests/guest-debug/run-test.py
> @@ -23,7 +23,12 @@ def get_args():
>        parser = argparse.ArgumentParser(description="A gdbstub test runner")
>        parser.add_argument("--qemu", help="Qemu binary for test",
>                            required=True)
> -    parser.add_argument("--qargs", help="Qemu arguments for test")
> +    parser.add_argument("--qargs",
> +                        help="Qemu arguments for test. In system mode, "
> +                             "@BINARY@ is replaced by the --binary path; "
> +                             "without it the path is appended last "
> +                             "(so qargs must end with an option taking "
> +                             "it, e.g. -kernel)")
>        parser.add_argument("--pargs", help="Program arguments for test")
>        parser.add_argument("--kargs", help="Kernel args to --append")
>        parser.add_argument("--binary", help="Binary to debug")
> ---
>

Looks great.
>>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Thanks!


