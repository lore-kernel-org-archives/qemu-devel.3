Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C2ECDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 17:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcRE0-0000Dy-Oz; Wed, 24 Jun 2026 13:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wcRDs-0000Cp-TS
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:17:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wcRDp-0007hz-Uf
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:17:11 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OFnGhP3572985
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 17:17:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Fq72G79FICCoV9xYFarccrDDiQRovC+JtNXnSJ1ghHM=; b=NPTmi7OGbDARLVQU
 ZJJ7NN/teQ/WYUbdaNtF1eWzEWIBg5xAFzL+hXhbQ8unY0EN+d1W8Iyjgp/IxNPs
 PvhlK2wuUCf1VgEc3E/25KN+t4wlTQNyfbjy3TH1YHsL2X5QqVUpFsTlZIR7aAx/
 6r7euN0w0U2F1P5riMHc7iCC48oe+c2MRZ77n9r25Ldt+AwazIpdEZwf1thkW3qG
 8iYyVX7teG3PpobvOGS/oPB7jaowuezeeDnCSzw6NuXosVJIsckzWRebEFJWddvD
 /xqBklcot9ksEyiO9NuXOZQubsJShC7JyEL+XlJVzhuFpgvr1/ijwyLBcxJCtitf
 WHAXgA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0j7drcp2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 17:17:07 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-96756491508so147692241.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 10:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782321427; x=1782926227; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fq72G79FICCoV9xYFarccrDDiQRovC+JtNXnSJ1ghHM=;
 b=PPvGZHNft+25EU79Wh51JUR87rIPV9+frqm1wv4v3M8VWSfpmcRjagZavgTyJhGHiJ
 NDNGlyNpPdQp7633Wa/GX/11TfcrULAW9/LxUnaF3/JZOnngigTwxrPMWT1LvLeEoZby
 nXroBiImLVSOU5SmzjBv7nBgF1RRAYp8EHcqaF/VTyk4/Fjts/Ya5p3AIOM72VprvUEl
 +1ij2NYyBU1gCQmUZahijzO6bvPJyLqJBorEoKdRbkeciQkkeNUr6PXzTS7d6pw9zRae
 q58WH2gN0o0+vRaolJpPnBRwdsVMaqXhCl0jWKryJ8hVteepo0a9vdkDN7VQ+Pl0eLcI
 QVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782321427; x=1782926227;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fq72G79FICCoV9xYFarccrDDiQRovC+JtNXnSJ1ghHM=;
 b=p9QhLDcfxWPqK6xprm0IH5uV4GHMG5S8b5iKTwPKjKiCaUgketPG+MHIkLEt8rOJ35
 jVYDrNPfI2bOQrOG3mIcnv6Tqy2lSxzJmqw70fkkQI8EZu+nfxkc9gSBl+Z2kZLNGw61
 upxJQUY5ptFHmwk7upNV2apU2Jw7E5iRvcoK8z1jrykHe5FWTTA0PpDiPbgmzRfQSG5v
 rd+cAmaeC6fKJqa8zf7ivRldVX4/uZLuiQiAqQVLxiCFSYpeAe9G4Le4+kAzWKc/bAT0
 5/VTNvuluHlbwrEq9oTJSJlH4KiyrM59PO46OmB3XiTyPB2spbBy3A6deyRIOhESyEcl
 kWxw==
X-Gm-Message-State: AOJu0YxJdZct9KNEoHrYyqLanA4TBj80I/2YIRWtZA2MyEd9YwhtBAdx
 wE8ab4XfmVesFe1WqUC9P8SpvZgNKp2ggb4QAP8oRozWkX+PprcIv8aPzqyE0iGdP79qoI3UdSX
 NibDsHdvsMbQqeAL2toXH4Pylmd20x7EuVi+Emy0sINuJWFw2YqBdgoW5lw==
X-Gm-Gg: AfdE7cmwNfzkdaVb5CjT+M8+6WeHa5ql0vaI9gPNQ1FJFQUZlsGAgnqt98RVhHqwUKD
 KyZiJCaruntZJeTWoIC8TrMl8BViKyJnzxnyaV+cevZ/ouqeabsQxO7HkRoNRqc4QcfSW3p1vjU
 rOwATPrgDnGZo481LPQizQkJDQX/DQGhy3LFbwm7T5fw5S6g+kqVpDJVQRKeJc4DJQGituP5BTU
 ChoJxu1MunxufvGLkMVd6k4uJm60BrDhshOmYkqRWaEwRLopSjNA3kvnAT/RWM+1uzQPF2XaXgx
 uAJphsRbQ8uBO05XTDpACNZEPFl/o20hRG2fYSpGP0hhMA732kbiTlB/WEF/6BdTIRBHrKcEiXU
 upSDR2kwmn9lKVtURPD5moG0wPV76pIpP8GEcJh3KkG5S2cupktGenOyxdXydIg==
X-Received: by 2002:a05:6102:5344:b0:730:2637:6bb5 with SMTP id
 ada2fe7eead31-7311620ed51mr2377286137.16.1782321426754; 
 Wed, 24 Jun 2026 10:17:06 -0700 (PDT)
X-Received: by 2002:a05:6102:5344:b0:730:2637:6bb5 with SMTP id
 ada2fe7eead31-7311620ed51mr2377227137.16.1782321426318; 
 Wed, 24 Jun 2026 10:17:06 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4926401a2e7sm9287515e9.3.2026.06.24.10.17.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 10:17:02 -0700 (PDT)
Message-ID: <ca9278b0-ef99-462b-a326-ec72ef89a930@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 19:17:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 16/35] accel/mshv: Add vCPU creation and execution loop
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>
References: <20251009075026.505715-1-pbonzini@redhat.com>
 <20251009075026.505715-17-pbonzini@redhat.com>
 <CAFEAcA--=G3j=jDXvT-Afzk=Hbo_3y_6S6CwJRJynzN+ueydBQ@mail.gmail.com>
 <3fd7f80c-3a1e-49f6-b4f0-ed49e0691a74@oss.qualcomm.com>
In-Reply-To: <3fd7f80c-3a1e-49f6-b4f0-ed49e0691a74@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CXxTa5NEAlpdp1TvfB2bj1ylSnh8Qz_H
X-Authority-Analysis: v=2.4 cv=NvHhtcdJ c=1 sm=1 tr=0 ts=6a3c1113 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=1ssbkZ7fVD0QybApJZYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE0NCBTYWx0ZWRfX9TaPlG8jwFNs
 sCfva0j2vWwmj9+kOvz3HD1BYfPJAtwBl8HEvjNB1iNFav8GrR2beDKtnhyWYi8L+Hm8JkZDBK9
 FCYUtXdPrl9/rVEFbDILOSIblKUKo0Q=
X-Proofpoint-ORIG-GUID: CXxTa5NEAlpdp1TvfB2bj1ylSnh8Qz_H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE0NCBTYWx0ZWRfXyOqEB/JiN4p/
 yaaM8bB6eQzlNbtpc1YV+cKgRbn7N+/CqT2dwsf4v8BDBa6tRgaxNpYMXcLJxlcJqyx1Itk5IEy
 pkJqnsL8e7d95eLBvCQ806TQsR3pVmg0RrWbRjqJGhDFXSsJSigj0TiASQ/oC8Frljptcm4/jTg
 rksIWbRlySAIzNh0OgbvWE3TCw/VibvZlsBtjckhDcZZGeOFV4sAYP8Wi5iROToGlcCD6eIK4Q9
 RKpqw1LO9kjiaM1ehnqys+TBG6cZhrslDhT+WBHb+BsjPSGUq6o2QXr6+i4kTfCjrrqGKRI3qb6
 kOhHHTlOKbgwZKfY/8IP7V4609gvwpy/E0sArAi/0lduZPLebHxgCRdTsqdhbbKlqTzqWXkh37O
 vEM5b7DCzbaL0Z706CQWPVHA2ufr7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240144
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 24/6/26 19:14, Philippe Mathieu-DaudÃ© wrote:
> On 21/10/25 17:48, Peter Maydell wrote:
>> On Thu, 9 Oct 2025 at 08:53, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>
>>> From: Magnus Kulke <magnuskulke@linux.microsoft.com>
>>>
>>> Create MSHV vCPUs using MSHV_CREATE_VP and initialize their state.
>>> Register the MSHV CPU execution loop loop with the QEMU accelerator
>>> framework to enable guest code execution.
>>>
>>> The target/i386 functionality is still mostly stubbed out and will be
>>> populated in a later commit in this series.
>>>
>>> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
>>> Link: https://lore.kernel.org/r/20250916164847.77883-11- 
>>> magnuskulke@linux.microsoft.com
>>> [Fix g_free/g_clear_pointer confusion; rename qemu_wait_io_event;
>>>   mshv.h/mshv_int.h split. - Paolo]
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>
>>
>> Hi; Coverity points out a problem with this code (CID 1641400):
>>
>>>   static void mshv_start_vcpu_thread(CPUState *cpu)
>>>   {
>>> -    error_report("unimplemented");
>>> -    abort();
>>> +    char thread_name[VCPU_THREAD_NAME_SIZE];
>>
>> Here we create an array, which we don't initialize...
>>
>>> +
>>> +    cpu->thread = g_malloc0(sizeof(QemuThread));
>>> +    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
>>> +
>>> +    qemu_cond_init(cpu->halt_cond);
> 
> These 3 fields are already initialized in cpu_common_initfn()
> from hw/core/cpu-common.c.

(I forgot to mention, I'll post a patch to clean that).

>>> +
>>> +    trace_mshv_start_vcpu_thread(thread_name, cpu->cpu_index);
>>
>> ...and here we tell the trace event to print the uninitialized
>> array as a string, which will print garbage...
>>
>>> +    qemu_thread_create(cpu->thread, thread_name, mshv_vcpu_thread, cpu,
>>> +                       QEMU_THREAD_JOINABLE);
>>
>> ...and we pass the uninitialized array to qemu_thread_create() too.
>>
>> Something needs to init the array here :-)
> 
> This was fixed by 2cd3c1d35a0 ("accel/mshv: initialize thread name").
> 
>>
>>> +}
>>
>> thanks
>> -- PMM
>>
> 
> 


