Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86DE9CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utIaz-0007wf-Mh; Tue, 02 Sep 2025 00:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIax-0007tc-VQ
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:26:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIaw-0001Se-2z
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:26:11 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822Rsa8022023
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 04:26:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ID4JQ6Eo2/gYQiJFTxRhinYwpKFti6yLJgwUFYWoMUw=; b=WA6rl2qfI1f9PMLz
 5BE2fJQX3n2x/C7TA9t+sPeLrE79+7D+hQr2w7Bw1h/yaVxm9SvxBtC7tKNM+MCn
 t/vqA5f9NfOic25gMorXjOTrt/uXj8zkrRE2AHIzL93CFnF5MySmMojSvBfCwjoe
 N8xA0vZBuM/lHqYZbhzZ1I6lQhly5fKvdPmuKntjVpVUD5tjJyAAGDOBwV5PkQ3k
 X693gM+SlwJj9CLnqWyTug4EoRbbV7lFjwmz6kjwQzHd0gwKtSg+TcgJv/BTXPpq
 P+S0Rcg3tNk9NavittWQUcPYWke9cTQqE6WUIIQHNe+4DYUPQ6Ifhg4f1fI01Cgg
 5pt/sg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnp6mar-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 04:26:08 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4b29cdc7417so96973541cf.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 21:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756787168; x=1757391968;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ID4JQ6Eo2/gYQiJFTxRhinYwpKFti6yLJgwUFYWoMUw=;
 b=hgv4XxdgB05gyOuWNzFrlEbbCEFAoyjs/WN7AZkI0QM6gqhN8b16lJ2IKSFfoFNOCs
 4mKRgYTT08hek6DkuFSAu9JQC7SK+MyCO40dHfpJY/pmV/ZT2B+JtCsrOFFgFz/UDB8d
 2p5f5b1RNCIK7wKS0uVq1FtmwSPfjQp/KEycrJ2yrjFFmI7HG0Rj3/tfnhWEwD/cF+kb
 6UAjAT8sIoTmfxdYmGeZvaWyxemLd3OfOeUf8n1z6CiWEIQ7KkrYWe3SZ3Kjy0e+HByS
 kcq23y0K1/bi56CVFBuqMf5YAIx6bhJ2m/S72Gqet0sllmbp6vgN85vywJGb3RY9sScD
 cl1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtXDaSXByqWq6ZPEhLCxXt6hJDwTey2FXWH40WeN9TOyrorZBPnwbxV2KaP+vABwYXoSLxswRHxM5y@nongnu.org
X-Gm-Message-State: AOJu0Ywt5g4TbNYVGBhW5uyNahX1sTodpsx75jH8/xcPw6ZaBUtHdAZB
 jHkGyKkttH9JrIcqbDtZshCT3E8mBjD80XXWYu+1+DSN42UfDkhqxZ5kUvowL3jFPWY5rAhlpGS
 z7V8GrTJ84Fu9QrioQLXAkYRF3ANkpC47yqyz5P+oExW8TV3cZ04kIV9J1g==
X-Gm-Gg: ASbGncuAfJ+IUrKsP/RWNDMrjZiLR4Sw6q4Yj9gciuVCSQFer0s94+KeDZMD73tDspF
 +A8S/xwLoTpx1ozcbhvxO9V0nwsakJm6dJa03zDXT5ijhSI/omM7Op1TGl1KjYyE3rNKd5Jram/
 BqmRJ69m9fzT2Og88QKRS8dFKe5rMNsO9e5ttTa4APoqg4uiaOQe98FIbDWbvX+kKByGG8wikJG
 xAJb74xtw8hPdy5EoBR7Ak1/KNx2jXiaS4mMpaZeK1Eda20RqCV7D8XBQPj74UJ3KQA47LR12AH
 cDX9N1HZFTkU//XWRvGIj3UEP3jgAP+EbKtPq/Eb+ULuWHGxXUb6aoZyggFu2g==
X-Received: by 2002:a05:622a:8c9:b0:4b3:30d:5384 with SMTP id
 d75a77b69052e-4b31dca54c1mr139440451cf.70.1756787168063; 
 Mon, 01 Sep 2025 21:26:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3hJXMzwadAqXD/aBUNk3XIgR0erLTgA1IOYtu82UzCCiAOJPu07H3MCmP7rTUhswqtMhkoQ==
X-Received: by 2002:a05:622a:8c9:b0:4b3:30d:5384 with SMTP id
 d75a77b69052e-4b31dca54c1mr139440341cf.70.1756787167629; 
 Mon, 01 Sep 2025 21:26:07 -0700 (PDT)
Received: from [172.19.248.181] ([80.149.170.9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b88007a60sm65955265e9.8.2025.09.01.21.25.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 21:26:07 -0700 (PDT)
Message-ID: <2b42ef3f-fd67-4939-8906-3d92efe4583e@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 21:42:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 39/39] target/hexagon: Add pcycle setting functionality
To: ltaylorsimpson@gmail.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, quic_mathbern@quicinc.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-40-brian.cain@oss.qualcomm.com>
 <02cd01db98ff$a295cb90$e7c162b0$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <02cd01db98ff$a295cb90$e7c162b0$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: JDU5L5JB5koHWzo-zZ-w6HVcyZrX1MJ-
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b671e0 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=oqm+nZh+PgUSu2IGv/nVbQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=CzZscUXsqi73GC32EEUA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: JDU5L5JB5koHWzo-zZ-w6HVcyZrX1MJ-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX0tWR7rQnMmBT
 zz0v9ISK7qo7zK7p0CgN5DI509h+41vspJiYFxrTIh6PPE92GLHnmtJ1L7lVYXxOh6kUg2OLWmU
 VadTSsvmdR0nglLYTGE10UWKDtOGQKKYEIcHVuAAHtZCsXjaI9FOU1t1xJdNuWmnJLOIDqXUF0f
 6SryPwpBBZ2Bdxm4ySDC3aY9S9pm3lnB60ZXOnzdo8kAewyFufj6PAkKpAE4f0vwTfbnacLOLo/
 dOXINah0CYWpKza34EYCpeYfF/TBu3bcxqTMjve9ZR9QnK+bsjfvdSYTMa/+h/ARWwEpDs2t/Mk
 1vv9A34ts0ukoG79TDJNGBZGSXqjiz2DlypDa8Lo9v1WcRx8FdKggLYwdb9qAaonvkN5TiOObH9
 Sd7uSxCj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 3/19/2025 1:49 PM, ltaylorsimpson@gmail.com wrote:
>
>> -----Original Message-----
>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>> Sent: Friday, February 28, 2025 11:29 PM
>> To: qemu-devel@nongnu.org
>> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
>> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
>> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
>> alex.bennee@linaro.org; quic_mburton@quicinc.com;
>> sidneym@quicinc.com
>> Subject: [PATCH 39/39] target/hexagon: Add pcycle setting functionality
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
>> ---
>>   target/hexagon/cpu.c        | 10 +++++++---
>>   target/hexagon/cpu_helper.c | 17 ++++++++++++++---
>>   2 files changed, 21 insertions(+), 6 deletions(-)
>>
>> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c index
>> 80f5e23794..4ca6add834 100644
>> --- a/target/hexagon/cpu.c
>> +++ b/target/hexagon/cpu.c
>> @@ -440,19 +440,23 @@ static void hexagon_cpu_realize(DeviceState *dev,
>> Error **errp)  #endif
>>
>>       qemu_init_vcpu(cs);
>> -#ifndef CONFIG_USER_ONLY
>>       CPUHexagonState *env = cpu_env(cs);
>> +#ifndef CONFIG_USER_ONLY
>>       hex_mmu_realize(env);
>>       if (cs->cpu_index == 0) {
>>           env->g_sreg = g_new0(target_ulong, NUM_SREGS);
>> -        env->g_pcycle_base = g_malloc0(sizeof(*env->g_pcycle_base));
>>       } else {
>>           CPUState *cpu0 = qemu_get_cpu(0);
>>           CPUHexagonState *env0 = cpu_env(cpu0);
>>           env->g_sreg = env0->g_sreg;
>> -        env->g_pcycle_base = env0->g_pcycle_base;
>>       }
>>   #endif
>> +    if (cs->cpu_index == 0) {
>> +        env->g_pcycle_base = g_malloc0(sizeof(*env->g_pcycle_base));
> Another shared resource ...
>
>> +    } else {
>> +        CPUState *cpu0 = qemu_get_cpu(0);
>> +        env->g_pcycle_base = cpu_env(cpu0)->g_pcycle_base;
>> +    }
>>
>>       mcc->parent_realize(dev, errp);
>>   }
>> diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
>> index 9c44cb7950..08c749e9fa 100644
>> --- a/target/hexagon/cpu_helper.c
>> +++ b/target/hexagon/cpu_helper.c
>> @@ -70,18 +70,29 @@ uint32_t
>> hexagon_get_sys_pcycle_count_low(CPUHexagonState *env)  void
>> hexagon_set_sys_pcycle_count_high(CPUHexagonState *env,
>>           uint32_t cycles_hi)
>>   {
>> -    g_assert_not_reached();
>> +    uint64_t cur_cycles = hexagon_get_sys_pcycle_count(env);
>> +    uint64_t cycles =
>> +        ((uint64_t)cycles_hi << 32) | extract64(cur_cycles, 0, 32);
>> +    hexagon_set_sys_pcycle_count(env, cycles);
>>   }
>>
>>   void hexagon_set_sys_pcycle_count_low(CPUHexagonState *env,
>>           uint32_t cycles_lo)
>>   {
>> -    g_assert_not_reached();
>> +    uint64_t cur_cycles = hexagon_get_sys_pcycle_count(env);
>> +    uint64_t cycles = extract64(cur_cycles, 32, 32) | cycles_lo;
>> +    hexagon_set_sys_pcycle_count(env, cycles);
>>   }
>>
>>   void hexagon_set_sys_pcycle_count(CPUHexagonState *env, uint64_t
>> cycles)  {
>> -    g_assert_not_reached();
> Do we need a lock here?
I will address the lack of locking here in v3, seems like an appropriate 
change.
>> +    *(env->g_pcycle_base) = cycles;
>> +
>> +    CPUState *cs;
>> +    CPU_FOREACH(cs) {
>> +        CPUHexagonState *env_ = cpu_env(cs);
> This underscore is easy to miss.  Just
>      cpu_env(cs)->t_cycle_count = 0;
>
>
>

