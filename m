Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC1FC43602
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHuq-0003lB-Uj; Thu, 02 Jul 2026 09:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfHuo-0003i3-Uc
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:57:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfHum-0001qK-Db
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:57:18 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D0Ykm518276
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aivI8BFY27w6wlECKCWaQAvc1x8e/NO4LqB61FIMXDo=; b=MM+rjQODMOr8kSKf
 5KGkH+uWkEByihKXr/BKtdHMiy0Ufdx8DobBnist0OfikAWRxNi8bADWGHQf4I73
 D+wY5SPltv8Ylimo/4INqkY6es5EzU4+z3MQNUVfYN/M4JEhcbrRSFs1B4Q6jGzv
 zPfO92PfMbSo3kExH6kp5A/brg1EKmJIHQ8EpYrTM7OHqIuacgmeVt/jI4a1Zurh
 ErSH3Z+BKSuzjPteV1iNCAE2/YMlmKtX14rnzgnTNCZjdOVaxeGmV8CteAQIYKMD
 khQezTsmQnAa9Kfv0624M3WeMARbYuUcfafnJeya8KmEoI7ndohPsiKBh9rpSQl8
 OqZByA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5qfc0gcm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:57:14 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e8004d60eso149421285a.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783000633; x=1783605433; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aivI8BFY27w6wlECKCWaQAvc1x8e/NO4LqB61FIMXDo=;
 b=byMsFUBqzE8vcln1ayCzlzf9bGng+j2nGWckAEfYCZECX45j057jpNJseZpZPu32qX
 nh3KO+M+8s0p7vl0HvE0QFxZLGJ2Dks2X4i5WFk7xqVsUBdVvkwtomUsLeywbj05qJZt
 38Vnpc4cLw75Hqsh9tQxMMHoAmaKH54zVBKZIaxhW666Se36EiBVoelU8NoFa6DiUkp6
 vt8tyQ18uYtods1MdSylgVmPihAxzC7Up3LTjDs7AFbId5DAoFZXb/mqM0qDW9sx/DZT
 MiIBwJy0c+iUHPlXInS7PntimPyjSNjyI+iKNa2oaerFfX6na+zST9QLz1CJXadidXyF
 YxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783000633; x=1783605433;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aivI8BFY27w6wlECKCWaQAvc1x8e/NO4LqB61FIMXDo=;
 b=SHVo1/vZNmnHw3e2UeaQD2mNiRCiK1gL82J2BxPa0UNIjKHBBxmSDq2UgnBZM8akVm
 +yWD51PfplNL3DD29WYuNRl6ahsYPRIXrOYKdty0XDvKhSpsyD+ecCgK+7U9+fR2xDVm
 05tMXwWNYs1bVqCYnmW0SLkP8tujR/v/vI2Nq/UPJTM8HNJCT7uVPQMxhHUAlPip4pQs
 2Dm833uP10gSydgqKnmNIcIJT59XSzmafZN5As6H5OC11zh0nYKgIvW4+PxtWU+FE7rB
 BhM4Isg/R87Qt7V63tCNT5gITvvagSBz+ypj/sVma7pySYOAV+ufkNR5AoFgjwVWpv1x
 Jvsg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+j+4GM6kqccQLfdF4XDaMGtem17LMtSExlUCuS3W9Y3M6phHzrBvnYMqJkOFqkHeYOd8y5e3YlQFVd@nongnu.org
X-Gm-Message-State: AOJu0Yw/J8uMRd5Ew5n9O/tPcaPPuTx1JtUYL8vy3R8hSxnus4b+iUai
 LmdUoiLK4XxXVvpJ5XoChldzSuiNRJgfkO7bMX05ssJuXiJ28BZy+ZJK5JYhq18HDo/oDnr8COG
 9VM5S9yWbEAcJwZC0lkrkmKJJ5SfjZz31eIN5/omqNKkgwm5KiDfcX04dXA==
X-Gm-Gg: AfdE7ckkvqrM7cUYECiMNTtNbX2mie+hRmBhK884OCW2e4kycWyHkXg0YY19oBWZoOY
 s1cNh6b2oFfpjpoE6Juoo3hEKc6vWe5+AzLHTvYmRYs2oSBOuAmXo9NmKrU5MzGHz5zE+X094c4
 kgUdf4EIjzFrD7UH593etlrUWCdpiwJocW1TRu65BCBjlwdxME5g4UwHh6W5s89u8YbY7iCHE7s
 WDX7VV5ZsOJteQNOOsRRI/x7IOUU20oqf0bPnTS32OILz4yae6Lb19tXdJqiM4zbP9dvlD4exsp
 NO8oLmR9dYPJkeflz3vtRbRdS9YXUgYyoqdryucHw1R3nsgg4nhBDgeTpy4bk3IFCtQ73DfDg4y
 1yMht88pcW5CoowC73Im8kwT3NzwZG0ZGUk3mrqsxb4Vr+a/lgIi8rz/4jAFT0A==
X-Received: by 2002:a05:620a:691a:b0:92b:6805:917f with SMTP id
 af79cd13be357-92e7b42043fmr753935385a.71.1783000633301; 
 Thu, 02 Jul 2026 06:57:13 -0700 (PDT)
X-Received: by 2002:a05:620a:691a:b0:92b:6805:917f with SMTP id
 af79cd13be357-92e7b42043fmr753929385a.71.1783000632767; 
 Thu, 02 Jul 2026 06:57:12 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477de3dcf59sm9245386f8f.34.2026.07.02.06.57.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 06:57:12 -0700 (PDT)
Message-ID: <afba4705-4ab7-407d-9d70-f2706736ebb3@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 15:57:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/33] cpu: Define BreakpointFlags type
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-19-philmd@oss.qualcomm.com>
 <f01bb2e5-2de4-4aa8-8ceb-485300ba8cf3@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <f01bb2e5-2de4-4aa8-8ceb-485300ba8cf3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pnq1rCdF4HRtK6PV5EMBePOyYpeWb_rN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0NSBTYWx0ZWRfX6kXyGlQ+Biw6
 hSId4P8Olb/EBxYuQYZk6h3XgSxlWYfhR0TuC3UOfwCwQhg8zTthWJRbsMOY2aPi2V1aeehxlfy
 Wia7F5TYWkEV1UnzVTEttSufW7uYjoBDqqWXjNuvWYSYWQSiiCGAbr07z6X406uzxILHqcyKYAf
 oS7UcQMtEZVSMhqIJr8tA5InGOKO1ZaynbfTQoGvTkd1Nt0UxRwl4uDb7JXSrMiB/fmvKRujMNh
 PqcvVAFhuOvjddD34wGh9Vs+j5pLKsEwPbRxVAn6XyCd3pPr3puNvAH137HWqQEvz2BsgqITL83
 sQZq160uNTq75Fh1O06owl7XZMWzhjw9N9KFdYNq5wZvjPqrL3DTY6vfAORu9XKxwXI5d5F+htx
 xg7SRglrYXlSeBv0q1x5l5TIbXePNvXSjbCZ18GBNiEp5pBubwhN6pp932YxI+ZWejdmhNb+2B9
 XASX9TAY8XfmpT+KSMg==
X-Authority-Analysis: v=2.4 cv=dvXrzVg4 c=1 sm=1 tr=0 ts=6a466e3a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=6p8Ah_ZBihweHsgv6SUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: pnq1rCdF4HRtK6PV5EMBePOyYpeWb_rN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0NSBTYWx0ZWRfX0p5WSQc4hudF
 htasLu+seYWb4IaG/RcxVemKH16Z/LfD9kewxY/F8grY+Oh+0Ir91KjDBRVP6h4aTDKeXmfx9hl
 d7EYJ/wXeF3KrTAXZpSiJS/ngCAy7a4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020145
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/7/26 15:26, Daniel Henrique Barboza wrote:
> Hello fine sir,
> 
> This patch fails to apply to master due to a riscv conflict down there:
> 
> On 6/30/2026 7:00 PM, Philippe Mathieu-Daudé wrote:
>> Use the BreakpointFlags typedef to better follow when
>> we deal with breakpoint flags (BP_*).
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   include/accel/tcg/cpu-ops.h |  6 ++++--
>>   include/exec/breakpoint.h   |  3 ++-
>>   include/exec/watchpoint.h   |  8 +++++---
>>   include/hw/core/cpu.h       | 11 ++++++-----
>>   accel/tcg/cputlb.c          | 12 +++++++-----
>>   accel/tcg/tcg-accel-ops.c   | 10 +++++-----
>>   accel/tcg/user-exec-stub.c  | 11 ++++++-----
>>   accel/tcg/watchpoint.c      |  9 +++++----
>>   cpu-common.c                |  8 ++++----
>>   system/watchpoint.c         |  8 ++++----
>>   target/arm/tcg/debug.c      |  4 ++--
>>   target/arm/tcg/mte_helper.c |  3 ++-
>>   target/ppc/cpu.c            |  2 +-
>>   target/ppc/kvm.c            |  5 +++--
>>   target/riscv/cpu_helper.c   |  2 +-
>>   target/riscv/debug.c        | 12 +++++-------
>>   target/s390x/tcg/debug.c    |  3 ++-
>>   target/xtensa/dbg_helper.c  |  2 +-
>>   18 files changed, 65 insertions(+), 54 deletions(-)


>> @@ -992,12 +992,10 @@ bool riscv_cpu_debug_check_watchpoint(CPUState 
>> *cs, CPUWatchpoint *wp)
>>       CPURISCVState *env = &cpu->env;
>>       target_ulong ctrl;
>>       target_ulong addr;
>> -    int trigger_type;
>> -    int flags;
>> -    int i;
>> -    for (i = 0; i < RV_MAX_TRIGGERS; i++) {
>> -        trigger_type = get_trigger_type(env, i);
>> +    for (int i = 0; i < RV_MAX_TRIGGERS; i++) {
>> +        int trigger_type = get_trigger_type(env, i);
>> +        BreakpointFlags flags;
> 
> Here ^ the reason is we're not using RV_MAX_TRIGGERS anymore but env- 
>  >num_triggers.

Yeah I am aware of this, I was waiting for the RISCV queue to be
merged but the soft-freeze date is approaching so I preferred to
post for review, and re-post just after, no other alternative when
updating a core API used by all subsystems. -- this workflow issue
has been discussed elsewhere recently --.

> 
> 
> Patch LGTM otherwise.  For the RISC-V bits:
> 
> 
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Thanks!

