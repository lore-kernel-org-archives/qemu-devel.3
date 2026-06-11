Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BCFDCD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 09:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXc6e-0005bq-0K; Thu, 11 Jun 2026 05:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wXc6b-0005bQ-O9
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:53:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wXc6Z-0003y1-Sa
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:53:45 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GKcK2247975
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 09:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 q7IyhJ9A3UVSHCPTP9d6w83TYbzzTlaoirtCImmcpNI=; b=ZQ/18lS//GhJanBm
 Q+gH2fPlaNd2UxWCfvlBsI30tsIHhFSbUc5iu0LoMmx4rOpQRnIAUMF5V2tnfVvn
 18fR35VyY8rQjbNbwJiFf7i+ruIB+EiDl+hs3sKAAEmE0Tdje7bVoznFkfzyATTI
 kD+T21qs/5eWAmRYUJ9o7EKIn1PEUQQM3uv4qrtaBFPjSnaZlVw36hoxSagHmMv5
 efQXl5xsofe4UwVv9H6di9qurf42ExXXaPxQfakTvLK1agdHZPerw53+UYWk7vBl
 jPXHJuqp6F+y44HsIFOOEAc0+RqGnI4TG1KzEzOb4kzUgiXKs7bK4oMN8cfnzFjf
 rIWGMg==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe79jrep-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 09:53:41 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-96387f0ca7bso2423570241.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 02:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781171620; x=1781776420; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q7IyhJ9A3UVSHCPTP9d6w83TYbzzTlaoirtCImmcpNI=;
 b=doSvExW1JwaEY1QdjpdLUnVfAKY1YBj9DQbc00QNq6equHAMEa4+YTcZyHTGFL7wK0
 CrMBcnHEST4ZO4MtlXj2pntU2PM6mQplx9zxv6E2N1hnpragVDwY7dD8PYE/gz7SERKx
 hn/943OALYwmedR+lLsdjFRVUgmhjsGeEydItKpD8fjH4voTkY4WoU+3r9zAc9fLfM23
 403/P+A3KHE2Mlxm/sh9372TzpD2FUL0lcUqoCtLxemAYjQ5pwqfQO8puANiOZ7ewtKs
 ySIEcWEfCeOf4k5d84SB5jJVG/1rN17ykRqgJfwCZF5oMfkLELptX/7cyCij3/cI/+8n
 N5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781171620; x=1781776420;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q7IyhJ9A3UVSHCPTP9d6w83TYbzzTlaoirtCImmcpNI=;
 b=X+jMvENygr3j7fpYc5wwkCXCKjG+V3k5Loe0yVrHw7Hv2W3w3+8lQOIlcM4Viy8SJJ
 vI5tnmHWBXEVY5IroH7R8XKHlW6WPYAJLnLQZ1KPonnFPyGMptH3j39T4/20D3bQnErU
 XbUevFpNwCiQGBt390YMVAvWjncvM6Tv28LBEwF+s1bifkb+QsEZEpo8/xhNhOozkZyT
 WMfvEcnB2HvExG+rvUARsC8Djvc6bYHwZwqxludGqvg1bIEyIq+FWdeKMjRKd50Pu75k
 yD1H9TcK1m/+LyDWA2ulp/XWwGDcWc/FdagWM8kUK/V1K8dTY/16dC/LXQYAIuZMUp0z
 aIPw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Jk4bR0grXh6DBqhm98x9GIgUl2awPbs2J0abkbvWe413yOqnBClV41lL6R2xsMtU6JIojvk/Hm+jt@nongnu.org
X-Gm-Message-State: AOJu0YxWFuor2hehwkH5gj9HPG8nifYzuPTZprx7PfBp4dGDAErvNb7q
 BCzo7tLG/YgrPRsZo7nbDbmOiKHFvjnkQfSGN3atb1WkOl8wq+r99XOXxOUlXRk0flQGVvJAFTO
 LDryOZCnGa69FFIfqkq+BNqiq0/ABLcRnv3Oti9hJojtdTFKw9Wt2y8fA6A==
X-Gm-Gg: Acq92OEpZiESJEdyR7aV37znVpAeM5SpaFivsg8CvsVjtwGSUujOe0XX0YP4SYAhR/P
 xot3s76a2ijQ5CPuDsqB8Amz5K/gLzdoyjzqLtQYWXtpySOqfCWY0YD7qhlyddLYog++wx/rXFN
 5CYBnb7+jZ84EGDRpzq8Ne/OnM7LajQQRQ8qOlCgn5CDCSdbvAKKC52R6lvkk7a8I2AE8dnKI4g
 jgcT6lFcbEA+iwefvl8xrGpN7Wy09tsc1LGJImLoEtXGu4N0YKXQ07rXiOTwxzrF2de1Fmw8F7Z
 4w1shCa+pkFEqT/TQ4vPXOy780hE08AK4tRcnBZHWeT5EEfdsBxuK4JxDpiOOL2ko04R9Uy4OlM
 qeykw0njJv3svlGgwJbV0c+SKjplRWy9HppsC5wzZSqgdQid1nZDsFSbgLUWQSf3wzU7U
X-Received: by 2002:a05:6102:5e93:b0:607:4fde:1921 with SMTP id
 ada2fe7eead31-71d5f4c9e9cmr583537137.24.1781171620168; 
 Thu, 11 Jun 2026 02:53:40 -0700 (PDT)
X-Received: by 2002:a05:6102:5e93:b0:607:4fde:1921 with SMTP id
 ada2fe7eead31-71d5f4c9e9cmr583532137.24.1781171619680; 
 Thu, 11 Jun 2026 02:53:39 -0700 (PDT)
Received: from [192.168.68.106] ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-71d900c43c1sm610880137.3.2026.06.11.02.53.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 02:53:39 -0700 (PDT)
Message-ID: <d3ab9f75-449a-4196-b4d4-802e71576edd@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 06:53:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] target/riscv: dynamic alloc of debug trigger arrays
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260610205457.1868701-1-daniel.barboza@oss.qualcomm.com>
 <20260610205457.1868701-2-daniel.barboza@oss.qualcomm.com>
 <380995c0-fbf5-4f1a-a996-fbf39513c166@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <380995c0-fbf5-4f1a-a996-fbf39513c166@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: q7Q2GE-aJIH41SoDrE9EOv-K7R2ENvb5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA5OCBTYWx0ZWRfX7Zn+PwzffeXx
 EwYZrBft/ToJ4CJDG5U7ljVRbYlvCorDU6wNMFGg5DVQuIHfOvrgh9HEDJapbAbu0VDOOAfkl/Z
 mR4NYRDyqaOSy8sBC8yOE5cg+dY4Z47/V76UrzXhG3MOx6lKZdLzBsbhzOLhbIDKJnyb2vZ9X8t
 qsSnkjoqqqokhsayt5+UPnuBAcE4XAdvcLTeFpKTi06uEQsYcHZmx0ZIXS3AXDEC9Cndn2bns4/
 1pCrBOG++x9s7NVQnDWE4/YhG89N9Whkd2X7/iBg4AOakcBopeB3/rMZHEhQpt7tfl5YpaZ9O8g
 vk6RjGTt7wdySzPr+LKsru0WvuAi6wsGwo/MO/f8VXsevXpX5eumzKVa6mOW4yquda6U59y0zLe
 Xrfi/yBoQDkzLV3RO9tvlot89XF7XTNHzyhu6ZnZ3MU+kP0KpMfcSUwdC3LNmF8+qYYcTjM3FTI
 Qhx7q+mkxxGAM8RVqeQ==
X-Proofpoint-GUID: q7Q2GE-aJIH41SoDrE9EOv-K7R2ENvb5
X-Authority-Analysis: v=2.4 cv=fbydDUQF c=1 sm=1 tr=0 ts=6a2a85a5 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=q7Ro75FnHStSpohpR88A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA5OCBTYWx0ZWRfX6vuBZOClhwQK
 ocjONCPLrZDLhBQtZKQp3MSgsEtejd5x89LYrrNCzLLq5kVgOnUgqn08hUUa0iXSnesAnJ5D01L
 LKsRzS1KHm58O7fTQJ676QCwYdNgvlc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110098
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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



On 6/11/2026 4:09 AM, Philippe Mathieu-Daudé wrote:
> On 10/6/26 22:54, Daniel Henrique Barboza wrote:
>> The debug trigger facility consists of a set of arrays: tdata1-3,
>> cpu_breakpoint, cpu_watchpoint and itrigger_timer.  All of them are
>> static allocated with RV_MAX_TRIGGERS (2).  This means that all RISC-V
>> cpus will have 2 triggers per hart.
>>
>> The RISC-V Server Ref demands at least 11 triggers per hart, and several
>> CPUs in the wild works with 4+ triggers.  We need more flexibility, ergo
>> we need to parametrize the amount of triggers and make it configurable.
>>
>> Before doing that we need to handle a situation faced in a previous
>> attempt [1].  We were unable to set the tdataN array length in
>> vmstate_debug, meaning that we would always migrate RV_MAX_TRIGGERS
>> regardless of the actual amount of triggers in play. To fix that we need
>> to change the tdata arrays from static to dynamic, allowing us to use
>> VMSTATE_VARRAY_UINT32().  This also means that, in contrast with [1], we
>> have the opportunity to turn all trigger arrays into dynamic allocation
>> and reduce the amount of stuff being carried by CPURISCVState, or in
>> other words, we can carry just what we're using instead of a static max
>> value.
>>
>> All the forementioned trigger facility arrays are now dynamic.  They are
>> allocated during realize time in riscv_trigger_realize(), and their size
>> is expressed by env->num_triggers.  All relevant code is changed to use
>> env->num_triggers instead of the RV_MAX_TRIGGERS to loop through each
>> array.
>>
>> This will make it easier for the next patch to parametrize
>> env->num_triggers.
>>
>> [1] https://lore.kernel.org/qemu-devel/94c772b0-5231-40e4-9cab-6ac39b9e4d45@oss.qualcomm.com/
>>
>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> ---
>>   target/riscv/cpu.h     | 18 ++++++++++++------
>>   target/riscv/csr.c     |  2 +-
>>   target/riscv/debug.c   | 31 +++++++++++++++++++++++--------
>>   target/riscv/machine.c | 12 +++++++++---
>>   4 files changed, 45 insertions(+), 18 deletions(-)
> 
> 
>> @@ -1049,7 +1049,22 @@ void riscv_trigger_realize(CPURISCVState *env)
>>   {
>>       int i;
>> -    for (i = 0; i < RV_MAX_TRIGGERS; i++) {
>> +    /*
>> +     * Alloc env->tdata1/2/3, cpu_breakpoint, cpu_watchpoint and
>> +     * itrigger_timer dynamically.  This is overkill now
>> +     * given that they could be static arrays with RV_MAX_TRIGGERS
>> +     * but we'll parametrize the trigger number later, i.e. the
>> +     * array length won't be static.
>> +     */
>> +    env->num_triggers = RV_MAX_TRIGGERS;
>> +    env->tdata1 = g_new0(uint64_t, env->num_triggers);
>> +    env->tdata2 = g_new0(uint64_t, env->num_triggers);
>> +    env->tdata3 = g_new0(uint64_t, env->num_triggers);
>> +    env->cpu_breakpoint = g_new0(struct CPUBreakpoint *, env->num_triggers);
>> +    env->cpu_watchpoint = g_new0(struct CPUWatchpoint *, env->num_triggers);
>> +    env->itrigger_timer = g_new0(QEMUTimer *, env->num_triggers);
>> +
>> +    for (i = 0; i < env->num_triggers; i++) {
>>           env->itrigger_timer[i] = timer_new_ns(QEMU_CLOCK_VIRTUAL,
>>                                                 riscv_itrigger_timer_cb, env);
>>       }
> 
> Ideally we'd implement riscv_cpu_unrealize() first, so
> in this patch you could fill the riscv_trigger_unrealize()
> cleaning path. Can be done later, but the sooner the
> better IMHO.

I guess we can add a riscv_cpu_unrealize() cb in this patch.  If we already have
existing stuff that would be eligible for that I can add a prep patch for it.

I'll take a look.

> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


Thx!


Daniel


