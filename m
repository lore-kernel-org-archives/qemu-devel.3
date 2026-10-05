Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D782CA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 16:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDlIi-0005fK-JD; Mon, 05 Oct 2026 12:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xDlIS-0005d0-OX
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 12:12:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xDlIR-00079P-3S
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 12:12:12 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695EP2MW2014915
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 16:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gWGjBdy7NDC8HgfWd4j7LCkGEtGOMXe0sIV8VVvUOeM=; b=JUFGNOaxEklFVkqg
 Xgm2Hn0Redr4RAd1nNE+BqAbfuZOa4piziW69OfHpx98vL/fn/+3XmMc6cV/rD7l
 1uNa23YG5uMwRXJpYfb/BV3qo1zDqZXxYdgmlKoY5N/GzuEbjhpIQL7qUgjPflAf
 JwlwhFytPvc57uh7aBqxzXp3w48hiPQ4SRGyhbYNwXeHPIsuDp0FJS+uTBgtURgh
 jrlXXZHt8yrdx5W3X+0Nxg7lunbSZDTAmz9XutTEEqQLLr6R2bIcxZ/mT1OyeHsh
 eStLq03AaXI+Izni7SMiIZQmzFPVnUXCcGzfhSEwuM59QfWNLGutcn0IykQ9KEhJ
 48Cuew==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h3xhs2wh7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 16:12:08 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91235881828so46859516d6.3
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 09:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791216728; x=1791821528; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gWGjBdy7NDC8HgfWd4j7LCkGEtGOMXe0sIV8VVvUOeM=;
 b=HjamCXEMApFUstOw6gn04fT5/Tsh0Rjtkerp+6TxWvu4/QLmRQLQQBfp8+8KPpAfgv
 DRQLXMBYjP52lMh1tAui3Udj4LSE7tWIEypW0ANpo82GgeYv0IZwWFZRIjTrOPjQ/CZ+
 awWZfWaq5LlabgWSEmaE4K4XHcAtsYHCB+3n//DOzCckBRGMYzopVCTyzppnsRTOlLji
 hJyA+uoJSrqe2dpZvO/F75gr04+dzIma2VBLpJM5lS9Bnxq3ZS/NmYTatweClwvWjpiS
 tOBdO9q5ebhZQWmxIWYmjyRuc5Y6krXEcYFtGC+SyNDsT1TQuWqoAKzFU5c6tDnnIG+u
 gKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791216728; x=1791821528;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gWGjBdy7NDC8HgfWd4j7LCkGEtGOMXe0sIV8VVvUOeM=;
 b=hUZD/JUfmPHZsL+0w1D3LsrvntUR5ipGsGSXS7xNhGGUz3wGBUsxiZ8kMpUqCO17v3
 jk0oSCAW4/r4iIY8yvaL1WSEC+ScFHf9TcGHYFVlNiHi6DJdjOcivr6A0qlPuptznt7k
 s0JUK073YgUjcmqKWlyLFQCzKLHY1EX/+GgvCv+7LDP2N25CH7tBAxczvr42egJ3Np6f
 FcbG0f3Fppo9jcJTu/inztOj1kMDHL0Fy9jRdqiZK7QOC5Nhyx0nPohNnf9tSVb8E9TQ
 DLsK/2cBhcYkhe489jZmq9mACVlZPA+ZuEIbani4KrSWvN4MyttDQHAZA4gDSckB1t01
 vcsw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz8aail2/Rg8lx7i9o2vTeja3K8RUo1UHJtOFT8LIErYUyYw7BE81XT/s8q/DAixXejYlZWfsVdUK0A@nongnu.org
X-Gm-Message-State: AFuF++nmqU/7cu/61pa8zOpUrYOyEo7B9dOdp3/vpxNzD4vDx9nqOOIO
 obG4fINyTcKRFOoYrlHR0TmM/0aERWGyAoZs3POpnR49QvQOG6NoH8Zjl1pqa1c9UFbXZC2txgg
 VFOkXSYYz2ASbYW/jdR5EK7NRYWQEH54tg11jd2HKRdJ4XKNbgXhoURMN1g==
X-Gm-Gg: AYBFou0a7kkl5HBHnnd1JcrAL+nuxuqF/v8TK85Nee8QXi8VgNdc4/JmyIrnxHDKLUo
 Y6a42dC88+TO3QlHzmV9l4uAqBZhPfiJ1db5og0376jnorIuyPrAGQaLjEzQX0U2oeEJ93Bl3u3
 fUe3aTgw9MOEA7JmRrUF3BS0rEIBQTBdd0iZprF4v0tDSv9YBfTZboUdJifW7jIBRHnhSsncWeU
 i5DDKkSNvnR4dPXzkR1uIYcLf6Jt6kYV+6+TmQ5siA1QUDanbpve5m6g9ddA1r0AsSxdiwnNgJZ
 1rlLaFurgZkKrN4fIVq59vilDSSf+toXpw3ywBx8MVwZVW29wbekU0HzmTN+aEKxFccIRL9OXOo
 cHeF8TEsw6+vD37FoB8Av3PHRmLeZva+OyDS6aiL2RIlsMf13V3CzC63MjhFdzC4D
X-Received: by 2002:a05:6214:5294:b0:917:a646:7fa6 with SMTP id
 6a1803df08f44-917c008e5fcmr206780906d6.16.1791216728241; 
 Mon, 05 Oct 2026 09:12:08 -0700 (PDT)
X-Received: by 2002:a05:6214:5294:b0:917:a646:7fa6 with SMTP id
 6a1803df08f44-917c008e5fcmr206774536d6.16.1791216722174; 
 Mon, 05 Oct 2026 09:12:02 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-917e0bcd906sm89757686d6.31.2026.10.05.09.12.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 09:12:01 -0700 (PDT)
Message-ID: <6d2355e6-fc9d-435f-9d76-9ff6c306d55e@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 11:12:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/hexagon: gdbstub - Add sys reg support
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260930175108.3592113-1-brian.cain@oss.qualcomm.com>
 <20260930175108.3592113-3-brian.cain@oss.qualcomm.com>
 <623a0707-e074-42e2-a40a-bbbb01c618a2@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <623a0707-e074-42e2-a40a-bbbb01c618a2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: sfa7AtZ4yI91bi9Kem0BZ6QKa1LId0oS
X-Proofpoint-GUID: sfa7AtZ4yI91bi9Kem0BZ6QKa1LId0oS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA2MyBTYWx0ZWRfX48zLDQTCvKEB
 RW6qeyRVVWOigUNk0SRK5ATCqGtmylqLBuLfqUxiCjx8QD1KxTqzM2lCn+8WenFQGp9sgnabp2U
 tU1tLdgEQ0sTR+rxbPa/xxMhNPkkpUM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA2MyBTYWx0ZWRfX4X1SBSCkVJ6q
 v8dCSLMB95eB3wwmmd29SKZRwvXmsDUJG0NCbvAj59gnDFHXF5yh2+OaqaTTIbXoxsfKBPaHAUz
 PFb+15IjTPw8ua7FoJ5zuLyyzlCmkXxxkADNXT2+vtCIXZMpCA5VMgN8vv8H6atlanVjoN8gkyf
 p0b9HDeMl1lLkTkv6yEpmdAUxxxuvqAEEVQ0Zd7lm0mbn4uJ1B4zlCKm74EOl1hMxiEDyKw+yoR
 445bSVaK5v4+kLqJOv7xgYJ3vZ5+EOdzRDBnAKPT6W2aOd1h9xL9LatgvKICj9CXb9D3gpX7YSX
 PYtQvVSu0j5YseQ+HOcJcHLYodDyScWbK5rY5mypYA0PXrp+mYlK+/cde7lWhI47rd9tKswBFUP
 opTfX6joe/Qj7STCVxxjOJ+vuFyqusZjU6ypwEsf9sKxBB5CNXB5ZwR/1dj3Dz0lofIjmtJNrIi
 TT4/v8Rl8V8GiVea8Ag==
X-Authority-Analysis: v=2.4 cv=Q6tHcI2a c=1 sm=1 tr=0 ts=6ac3cc58 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=0hCBIctGHN8lopuAG_kA:9
 a=6G3yfeA19X49byLq:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_04,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050063
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 10/1/2026 11:45 PM, Philippe Mathieu-Daudé wrote:
> On 30/9/26 19:51, Brian Cain wrote:
>> Add support for the system and guest registers to the gdbstub.
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/cpu.h      |  1 +
>>   target/hexagon/internal.h |  4 +++
>>   target/hexagon/cpu.c      | 14 ++++++++
>>   target/hexagon/gdbstub.c  | 68 +++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 87 insertions(+)
>
>
>> +void hexagon_greg_write(CPUHexagonState *env, uint32_t reg, uint32_t 
>> val)
>> +{
>> +    if (reg <= HEX_GREG_G3) {
>> +        env->greg[reg] = val;
>> +        return;
>> +    }
>> +    qemu_log_mask(LOG_UNIMP, "writing greg %" PRIu32
>> +            " not yet supported.\n", reg);
>
> Not sure void/LOG_UNIMP is safe, LOG_UNIMP is only enabled with
> '-d unimp' and goes on stderr, ...
>
> (nit misaligned style)
>
>> +}
>

Sorry I unintentionally omitted you from the v2, Phil.  The changes here 
should solve the UNIMP/returncode issues by taking another approach - 
just delivering the reg read/writes without the G3 guard.

https://lore.kernel.org/qemu-devel/20261005030538.1257295-1-brian.cain@oss.qualcomm.com/


>
>> +int hexagon_sys_gdb_write_register(CPUState *cs, uint8_t *mem_buf, 
>> int n)
>> +{
>> +    CPUHexagonState *env = cpu_env(cs);
>> +    HexagonCPU *cpu = env_archcpu(env);
>> +    BQL_LOCK_GUARD();
>> +
>> +    if (n < NUM_SREGS) {
>> +        uint32_t val = ldl_le_p(mem_buf);
>> +        if (n == HEX_SREG_SSR) {
>> +            uint32_t old = env->t_sreg[HEX_SREG_SSR];
>> +            env->t_sreg[HEX_SREG_SSR] = val;
>> +            hexagon_modify_ssr(env, val, old);
>> +        } else if (n < HEX_SREG_GLB_START) {
>> +            env->t_sreg[n] = val;
>> +        } else if (cpu->globalregs) {
>> +            hexagon_globalreg_write(cpu->globalregs, n, val, 
>> env->threadId);
>> +        }
>> +        return sizeof(uint32_t);
>> +    }
>> +    n -= NUM_SREGS;
>> +
>> +    if (n < NUM_GREGS) {
>> +        hexagon_greg_write(env, n, ldl_le_p(mem_buf));
>> +        return sizeof(uint32_t);
>
> ... and here we tell the user the register was correctly written.
>
>> +    }
>> +    n -= NUM_GREGS;
>> +
>> +    g_assert_not_reached();
>> +}

