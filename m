Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E12CC98321
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 19:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAC2P-0000wK-B9; Fri, 25 Sep 2026 15:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xAC2M-0000vl-3b
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 15:56:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xAC2J-0003Tj-7f
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 15:56:49 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PIndlf2888784
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 19:56:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BCnZYfxhogtoATPQ7SM8rwlR0+mC5MxE+eOp6L7J8Q4=; b=KQKO7LSWDpZiYAlV
 A2Go2lom6OlI/27Fbtx5NVdmb1QBQzUApSaJhdYRWo7klVVaFRVONCgpo2NRc/4G
 nmp7rX4MlFphhgxEbco8KfvATzjy9M8qBllntRla9kRh7bXrs5LlUSkfJPTKtxaW
 3w0OGav4EAUQkhiWzvTAuy8n2npuKlFV0AhGGwnTON045hj6EvkeZ+zoAK0qXhR8
 n513zJw4Abea7x737e4Sy8RkpVRpH4JlOEFZAJs635mqujB/nIWXwgkEKV4ncGY/
 WCOXWxJ68hWmDMNftglT/d7RJdBZimhzZtW1GimnvdzZMgVqkk9yN4jHh01PNmee
 WLr1gA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwwjc8j26-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 19:56:43 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-532e0dd7d9bso30702181cf.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 12:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790366203; x=1790971003; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BCnZYfxhogtoATPQ7SM8rwlR0+mC5MxE+eOp6L7J8Q4=;
 b=a7GO1x7N6fldlQ6bDGurAQXXUQsKEb73acLwOi5t0VbT4PWfnA5CtKR3uEYnCFMzmn
 i0BVyzF8eDZNE5MHZu0ENkjYCevn0o0VDh4nk/w6V8Z6vDbXzHlWGOx3sfYI2rDH/d0m
 lT6LL5g6gaJTZuZToAQSZr/FKfIk2JGGIFqfJMtj3jsZ5WRGAKB2MeMF/0AD1JDIh4HT
 ru5ulObEtejUcaJ/QVhXUBbKPzAxXCf/Ph3UWJJz9I5l2X5qYSdxun2q1hjVGwMVsYoy
 2YfiSb2s1Gi65uIedMgu0GbbmDtaDkJzKSiCdOE0Uurx7UoE0bnsTVCyhcdtaiNaR+sZ
 5l5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790366203; x=1790971003;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BCnZYfxhogtoATPQ7SM8rwlR0+mC5MxE+eOp6L7J8Q4=;
 b=VdML4Gu1T9R3s8cmTjSxHMmbujTytwzShiZDj3jmqJJa4yF9Zt+bhtnjcvmx8RyqaX
 IG3zWE+s6fgHs7IVt749bRxT3DE4sfPHnZ//WAqrZ0294t3j4Cu4DdJuw+6Q5yYww4hP
 nO9yRhR+cJNrMJhwzUimn3T+0CL6R8BQ1M2ZEB6sTC5bHc/XfAmI8wZY82AeTKbSIkGU
 dUWbnCHZTKTeHTTaUJJDK4DNqssPwEP+WF1pmgxtIUfE3lqXIVamMnHPHjHJR6xdm/Oe
 GDFWP2WslLsu8jEk/u5CAsgs+csR1ThalW8Sjy8f7uufaNHJ8wzjPJjkbZCDHtnr7rZ4
 HVbg==
X-Forwarded-Encrypted: i=1;
 AKwUvByKmYa6pEs7yPm6GrkmseGN5zzGAIFxaI6OVa7BxdE3x1K1n0V2rwJG8KmclpMpimeY2KIf21XbX9be@nongnu.org
X-Gm-Message-State: AFuF++k/apsdSFl3KbwsrhN8GBtW29VNZtk8nxz9r3+W3+zTqO380YTF
 UEIQYsjNa87Nz22Cxi1opcKjOCVk2+NH9Gj/sI8U90eYxq+VehPehZL9PC6DS4tKBG003+Z8Urn
 SAEbxcdcaXaFEX4mCSD3uQ7d4KIQ4lEtx5kXH5hPEqyQJ4sbZHuRpfBocsw==
X-Gm-Gg: AYBFou1TVMNeRji1P1DyBMb0pMpTOCTnp/yZy5qwyvgZuoN7pAjlg7aJw5lqp7GNABx
 PSElyq8M1RCCfiKgMUJvx7MRno+nqaTCccjQPB/EyHKtse8kOFeRWWStQbnZGUrVL43Yry1G8zL
 d8VRySbYyUsfXyJHUeC01oFuksq3hg5ORANtSxI3v5jsmLqVIl48WfpQ6Kf89VE6X9FBw4XXyQG
 8s8UItqFThVj+F2I8idWsZ+i/K/7u9pPY0axa0jN9FK9SZbaE3A9mGsD2/4Jq69iiumQWEK2J8h
 TDA46Tr2EdUQKume0eIzPMqiVvGu0bDpKPHU57bDL2IrhnGLF+SGfMYiPapEbudqmLOjh+fMPBY
 PB0gPffMjbcYPWfqh/ByqQ7QUbXE3taNOBw==
X-Received: by 2002:ac8:588d:0:b0:530:fd30:834c with SMTP id
 d75a77b69052e-5330b68d60amr65467571cf.34.1790366202967; 
 Fri, 25 Sep 2026 12:56:42 -0700 (PDT)
X-Received: by 2002:ac8:588d:0:b0:530:fd30:834c with SMTP id
 d75a77b69052e-5330b68d60amr65467151cf.34.1790366202456; 
 Fri, 25 Sep 2026 12:56:42 -0700 (PDT)
Received: from [192.168.68.102] ([177.94.15.187])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5332238c585sm756691cf.20.2026.09.25.12.56.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 12:56:41 -0700 (PDT)
Message-ID: <e8abec5a-9f69-4218-a0b1-81890d009896@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 16:56:38 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/3] target/riscv: Add vstimecmp support
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Bin Meng <bin.meng@processmission.com>
References: <20220824221357.41070-1-atishp@rivosinc.com>
 <20220824221357.41070-4-atishp@rivosinc.com>
 <f890177a-4322-4207-93a0-7f690cae6b2d@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <f890177a-4322-4207-93a0-7f690cae6b2d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3OSBTYWx0ZWRfX0bsYxyO4V3+X
 ktEb9GRIC1jxIsSTsER8vfHg9iDUps3IKRkMz8h+TsPvfTeb9VGi6ZjTrhdRMt5dZq3rSPKnOWo
 8RSgRHNapsaZtdQL1UfFq8z5TjLnEpg=
X-Authority-Analysis: v=2.4 cv=dZwVTnXe c=1 sm=1 tr=0 ts=6ab6d1fc cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=0kFmPUMe/4ewoYCJjrGTNA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=JF9118EUAAAA:8 a=h0uksLzaAAAA:8 a=a-3ul52hziEg8PtNN30A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=xVlTc564ipvMDusKsbsT:22
 a=MSi_79tMYmZZG2gvAgS0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3OSBTYWx0ZWRfX5t8zQHCdr5dT
 80QpUM3T5GvRB3AyGgd7rosXTlyzO7R07myzn9y91hLhh+l6GJXUW5Sgoh8bjAdkslYaPhA2Q7C
 FKvZhgkVDIX0OBTcz7OeHA2hcy0dwVrYQ7uQtB+MhfEH7N6u23UliQfQ9r3zW/eXbo3ircFqGvK
 43EHvNf1n526XL08UNj9sIkq31ZtBtNe2krmAqUUJmZ5aX3OJDoKN5A/ONnz8ux7YyLxoxFfBPu
 Ni48bMauOzaek1MlUf+qeuBHnvb5p0Mu0N9UwTH40XSNrKZhOuZxizmV90pqmJz7ZFPVQkKAUHm
 WLv2/WQeDI+qetWNqGONaZdE8ZONLPeay0WZ+2Ehp7pBt8zwtlq8XWrTprAwktYayhs7Ug6enNm
 kOA8y6mn5J940dx3PwLo55ZA1YFC8Kv4oExPYndHsWCfhVOcJoJSJksFKgD9mmGSatVx1T+AB2a
 bPW9yc8do3yYJ9GOZ5Q==
X-Proofpoint-GUID: WKvWd7P2MaFmP_TqVm9z-1uGLFxtHU1_
X-Proofpoint-ORIG-GUID: WKvWd7P2MaFmP_TqVm9z-1uGLFxtHU1_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250079
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 9/23/2026 11:38 AM, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> (now committed as 3ec0fe18a31fabfe999b480e4c21847ac0d51560)
> 
> On 25/8/22 00:13, Atish Patra wrote:
>> vstimecmp CSR allows the guest OS or to program the next guest timer
>> interrupt directly. Thus, hypervisor no longer need to inject the
>> timer interrupt to the guest if vstimecmp is used. This was ratified
>> as a part of the Sstc extension.
>>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>> ---
>>   target/riscv/cpu.h         |  4 ++
>>   target/riscv/cpu_bits.h    |  4 ++
>>   target/riscv/cpu_helper.c  | 11 +++--
>>   target/riscv/csr.c         | 88 ++++++++++++++++++++++++++++++++++++--
>>   target/riscv/machine.c     |  1 +
>>   target/riscv/time_helper.c | 16 +++++++
>>   6 files changed, 118 insertions(+), 6 deletions(-)
>>
>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> index d2529b757aab..d895a0af2c6d 100644
>> --- a/target/riscv/cpu.h
>> +++ b/target/riscv/cpu.h
>> @@ -311,6 +311,8 @@ struct CPUArchState {
>>       /* Sstc CSRs */
>>       uint64_t stimecmp;
>> +    uint64_t vstimecmp;
>> +
>>       /* physical memory protection */
>>       pmp_table_t pmp_state;
>>       target_ulong mseccfg;
>> @@ -365,6 +367,8 @@ struct CPUArchState {
>>       /* Fields from here on are preserved across CPU reset. */
> 
>          ^^^
> 
>>       QEMUTimer *stimer; /* Internal timer for S-mode interrupt */
>> +    QEMUTimer *vstimer; /* Internal timer for VS-mode interrupt */
>> +    bool vstime_irq;
> 
> Shouldn't vstime_irq be reset upon vCPU reset?

It's not needed ... I guess.  If you check riscv_cpu_reset_hold():

     env->menvcfg = (cpu->cfg.ext_svpbmt ? MENVCFG_PBMTE : 0) |
                    (!cpu->cfg.ext_svade && cpu->cfg.ext_svadu ?
                     MENVCFG_ADUE : 0);

The bit that enables these timers (STCE) is zeroed.  So as far as the CPU goes there's
no sstc extension and no timers, and vstime_irq is ignored.

When SSTC is set during reset (write_menvcfg() in csr.c) we'll go to riscv_timer_stce_changed(),
and then we'll enable or disable the timer (i.e. set env->vstime_irq) accordingly.


At least this is what I understood reading the code.  Hopefully Alistair can correct
me if I'm talking nonsense.


Cheers,
Daniel


> 
>>       hwaddr kernel_addr;
>>       hwaddr fdt_addr;


