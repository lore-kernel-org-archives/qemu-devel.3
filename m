Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CAAC5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5Zl-0007ie-Gl; Thu, 20 Aug 2026 12:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx5Zk-0007fX-EG
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:25:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx5Zh-0006Vu-EW
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:25:08 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KG6wgu281891
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 16:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lfIPsPcVdgpyqD3aZm86AZryTnDte96i27WaxFlVrl8=; b=l9/Sa0YAl76gn8mz
 Zcln50fLJrBWhHJOR/CMyofJ6+Mu9exUTdRQzPDLyOrnmAMcx04b/8l7L8T8Jenr
 rqRJqBB9L++zvpqZ8iBitIeqjr2pwFLG46N0Npi/5XK86TDXQHND1HFQuj0JSFa7
 EzXTNCwzyJKBr7GdDBsCfvRLYCk7TfWqqBW/U64DlAiHchdPHkYMd+KEVuq7KpZM
 xM5CQ0tWZnB9Uqkq8dfRUmm6JvaL2nl5GHViUHEeAUkKvbT0EElVYkMm1foshclk
 AjgOTYdUgrjPLQZXZXlkAxrj/kMCdMA8hDzxJj+4YbhwvHp8ykmpEMh5fcW9l2VD
 nr2QkA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xgc9wbx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 16:25:01 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93494527488so420182685a.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787243100; x=1787847900; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lfIPsPcVdgpyqD3aZm86AZryTnDte96i27WaxFlVrl8=;
 b=j5/Xjzx7S39UQgS5tmWk6VsZs/Fu1bKQeOfWegqWOcA+0wfuqnevhnBRGdotghRTsx
 MC2BaBE9qvPYHUZa0Nd2jFwhPS2SHkT1aVASj8cZox0oaxSNWkfAMXQkZTasSd0OIj4v
 5lB6Uo+yMMmSfLP3pvPc8qDQ/9A7H96TBcevNxOCjPAZePNs85FXSoGmvr+qX7ZkmTxO
 pL4zupy13PnDDz658k9l1dxLGifPzVpDD2BUh52IdOU5gC1njaAj/NZN4cwsNMHLgG1S
 MAsG7agRfX9vxIVLDqIjJPzWEkhZ5MurAoVUnB+pi7hMq3ZBYczPrvGJBKz6VdWfu35Q
 /1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787243100; x=1787847900;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lfIPsPcVdgpyqD3aZm86AZryTnDte96i27WaxFlVrl8=;
 b=YFpPGr1GZCrxnarD+k6PosNj7Vjl+foGaKxSO4srVmgIZsonygjvhXrtfwiVNTqeSy
 T4dfSgs9jgzDCTUla46wmFyzACOsZmizyi722PUajW8c3Yhrj67CVzusLAqKJAxXSNI8
 2FKeTu2qm+FGn0E67+1P331xbyEpEzqw0LN7NRIB6N7KlQisRJvwj0P0K4fAZYWUAwv3
 G8aIiurchj9jhs/MAwqOxV+Eqm5mAMs/haRhjYWoKdp7T0k42eqjpAs9/UmEnO9OfaKO
 mZEN0KNNUq21/OeQ+MICPPUdgP4vUKo2F+r3Wd1lhsyujjvYIp+3V2b3KRmlhoghMjn7
 VvvQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqtqhCvZ0LLZvx/VKf/O8T537bAur1rlflGeNxw/20dhJpxPZCs4GlPoYTveubF7hbVbYRZdizHTdKt@nongnu.org
X-Gm-Message-State: AOJu0YwH8y4zQvBy5L46RZ1cw5024vgAD4vjGLBtlW00TWFyKK40EAiS
 x7gQcqotV1FCL1eUoeTH0/r33m80euyKkHqnJkDxb1bMlGTitLIPsj770QfUU6IDP7tL1TtmLok
 LVwzI+p7XYCze1b7gsGAXS8bbtYcHPBm8oYW5m0+bCeOHUs3W3MEYaw3Zgw==
X-Gm-Gg: AR+sD13Ev8siVhZUzdFNRGJGWwgrGvzZeJnPSVT3NEGmNPklnq+N+0FwCQc1siYrQGj
 Yucx7ynlzGHmg3UaIeIvG1h4pcgm3VESE4fNA+JJYjwSKi4KgOF1XRr3gIr5x0GjAGQwlcwM/nh
 rtzUmSzzVhd65Fpn96w3+vISP65r3zs+IWwtF9fFl7cwqOHkRt5CaavU1lbLj79ocqe9/zdilzn
 uRX2JeHev1mVsC4/LoDfVnIE4ZYyo/1RTEQ8OY3y1XyIWvMW4oxDYSDtjLubc2zppt+/hhRI9vI
 0eDhXmv5pfpFvVKcb7mc539u/l8klGTQJwjPCqyGz4r2jSJt07/9GOmp3T6X9yQzYE4g/aEbjcx
 y/8nLOfBxT5grR7eP6eIiHgQ=
X-Received: by 2002:a05:620a:370e:b0:936:583a:dd75 with SMTP id
 af79cd13be357-9371e63f7a0mr1188355785a.17.1787243100270; 
 Thu, 20 Aug 2026 09:25:00 -0700 (PDT)
X-Received: by 2002:a05:620a:370e:b0:936:583a:dd75 with SMTP id
 af79cd13be357-9371e63f7a0mr1188350785a.17.1787243099826; 
 Thu, 20 Aug 2026 09:24:59 -0700 (PDT)
Received: from [10.111.143.150] ([212.136.9.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14d0360sm13248429f8f.33.2026.08.20.09.24.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 09:24:59 -0700 (PDT)
Message-ID: <854739cc-1275-4324-aaea-576f0a504172@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 18:24:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/13] cpus: Add const-qualified CPU environment
 accessors
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20260820104730.25462-1-philmd@oss.qualcomm.com>
 <20260820104730.25462-10-philmd@oss.qualcomm.com>
 <0b70e3cc-e14f-4737-b265-c7d12898169a@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <0b70e3cc-e14f-4737-b265-c7d12898169a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GPM41ONK c=1 sm=1 tr=0 ts=6a872a5d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=R-ZshP3Jd51NVqe3fDcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: xf5o74CEk3O8tLkRwv7EyTGTLeHyRmLx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEyMyBTYWx0ZWRfX7OU+H0sJAW3U
 O53lN/l4/RJDnpiQwmHPIQ0Qot3Ra65uxo6EEg704sj3NXhRq3iUNwI30sRt5ailiZCIlk8sgIW
 04stD1rUNmXwmMfKeM8e0ivmoQ9UWhFbiyGLqiEvxiE1jLoozOha0Z2cHLMGY02L+Bl4U33mcl4
 Y9fiZoIovib/3wXQu+f330Eba1x5utVFVJpCS/FLKKnYd3Tb9V9mMYeR7nIsz4vIkcW9ZH2YQqc
 Cd5tKkL1rxFRNE+YzGjjPreQB1wb6xN0BvK9WLXRd3wNFybL+tl03NRPF5+YxhL6+dQQOaaSJNZ
 PczKHrsVw4WC98ZIwzsPEt+0weIy9nmLxQz12IpDbydm5MpGZm5+LV/brRyC5U2x38ESPw5o23R
 8ySUmnEdLAvddG9MS6EPPXn8wlFLX+AO6IhmYwIfIyB4gjVhKXCm7BqDbMfVJlpbKt6B+slm1Tq
 02NkP+2j8OlrJT2lR0g==
X-Proofpoint-GUID: xf5o74CEk3O8tLkRwv7EyTGTLeHyRmLx
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEyMyBTYWx0ZWRfX6qojMJsYIK1w
 8enymgZqdoKj9V9US+8tLPcnoj/Jb0Hx9u3mX1XzhUQSik1p0dXEjZ4o9aXoJ2wRFScuJzZRNKi
 Y2pNVbm55heVUZdngqI8TBHQ2KHPq38=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200123
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

On 2026-08-20 17:21, Richard Henderson wrote:
> On 8/20/26 03:47, Philippe Mathieu-Daudé wrote:
>> Introduce const-qualified variants of cpu_env() and
>> env_archcpu(), to safely access CPU architecture
>> state when it should not be modified.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   include/exec/cpu-common.h | 11 +++++++++++
>>   include/hw/core/cpu.h     |  6 ++++++
>>   2 files changed, 17 insertions(+)
>>
>> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
>> index 6594f7fa1be..f3a3799f451 100644
>> --- a/include/exec/cpu-common.h
>> +++ b/include/exec/cpu-common.h
>> @@ -79,6 +79,17 @@ static inline bool cpu_loop_exit_requested(const 
>> CPUState *cpu)
>>   }
>>   #endif /* CONFIG_TCG */
>> +/**
>> + * env_archcpu_const(env)
>> + * @env: The architecture environment (const).
>> + *
>> + * Return the const ArchCPU associated with the environment.
>> + */
>> +static inline const ArchCPU *env_archcpu_const(const CPUArchState *env)
>> +{
>> +    return (const void *)env - sizeof(CPUState);
>> +}
>> +
>>   /**
>>    * env_archcpu(env)
>>    * @env: The architecture environment
>> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
>> index 81af7b9ee1a..59f777f3f15 100644
>> --- a/include/hw/core/cpu.h
>> +++ b/include/hw/core/cpu.h
>> @@ -594,6 +594,12 @@ struct CPUState {
>>   QEMU_BUILD_BUG_ON(offsetof(CPUState, neg) !=
>>                     sizeof(CPUState) - sizeof(CPUNegativeOffsetState));
>> +static inline const CPUArchState *cpu_env_const(const CPUState *cpu)
>> +{
>> +    /* We validate that CPUArchState follows CPUState in cpu-target.c */
>> +    return (const CPUArchState *)(cpu + 1);
>> +}
>> +
>>   static inline CPUArchState *cpu_env(CPUState *cpu)
>>   {
>>       /* We validate that CPUArchState follows CPUState in cpu- 
>> target.c */
> 
> I wonder if we can use _Generic to make this automatic, rather than have 
> to choose between two different function names.
Eh clever :) This seems to work:

   #define env_archcpu_(p) _Generic(*(p), \
                               CPUArchState: (void *)p, \
                               const CPUArchState: (const void *)p)


