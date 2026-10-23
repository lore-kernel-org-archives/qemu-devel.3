Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC55606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 18:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z3rmBCi+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OlNvgSPv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKKCr-0002Ot-Kj; Fri, 23 Oct 2026 14:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xKKCT-0002IH-Q5
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 14:41:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xKKCR-0007Oz-M9
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 14:41:09 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NIZPHX2074769
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 18:41:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1a/dfM+7136CDra7CBk6zTi7NeKPREAoeMOA3X0DHw0=; b=Z3rmBCi+04vcbxW2
 lwPy5ql2BS2iAGZvjzbe4EMiR3UVNHE8jxAg3xCh4WtLDPXoD2V6FxnY/FC0YgRG
 8kJTn8Az0OiaX837c9qIZhZVXV/GVOlfKv31MDqRKyo3n7N3A1a8A7pkm1EYPukh
 bdxmUqUl4BVCF6xuMS0UBMMmyMGiNBLJs7G2mVcEOTuObAWQtdXw2SA6/LacOnmH
 YaHRQjPjYxLg52ZVYF/xkDIlP4cXu7VlydKXVi2g03PWACheOT0ev5J8RRZuYDH4
 kiIfltmR/f4/sMv6aYXJSQmSqRQPHPRIiYV3WFhQcSEoHCmXLkeHsjALHtnM4GML
 0tm26w==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgcr0833d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 18:41:05 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91be1227fdeso27960626d6.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 11:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792780864; x=1793385664; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1a/dfM+7136CDra7CBk6zTi7NeKPREAoeMOA3X0DHw0=;
 b=OlNvgSPvfMKUSIAdZKC5ItTJbkAuQZXozniWdsbw9KqtnVR/4lvULbV0RXNXww8qx/
 vW0V/CW92b5et7Kf2OgabgpGiqakZxVCF5BMiq9n+nVvMFNG7xBxVDOxB5bPi6xY0LXY
 q6hqycPXud7BfcG0pMLW/WmSkuRgfPucqs+W0jd4GrcG5KAS/E+r5jozReq5WP6jfUvi
 T4qI1BRW8AwtYJ3o06hGFaUjYa9ncT2ewQdA6HCv72DzPU/qNovbyqGedDGKlAJFDvIc
 dNwCXaWeq+3S1uF7twWfwGui3vnmkBF4XJ8UTs2LRFo2VwJ+unWT3yJGeiI0SDgvyGWV
 bi6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792780864; x=1793385664;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1a/dfM+7136CDra7CBk6zTi7NeKPREAoeMOA3X0DHw0=;
 b=IHOoQIqfOLD7dY6VE3+rKS3wH6yNDlYjQH0Brp76EfFq+e8KMd3bkdj1Xs9nzVV0Um
 kOFSz6BT89wVwOymUUSNw/KLMFcvrt2mWhtP5CAsejdkbMrGfLGAIaFEHmy8t0Ds2GYY
 qwRfqJzGC2l3yejrl/AOJBY6fEgu0m/Q0XdCEj8cTg/ht+SUSwKNslSlzuQgawHXHtv/
 +PiY4PVMevIkyCNKo/vvvuZp4mtU2Yoq4FNqPWc/paEWgJZUUq0dZ+KiecSdd0537pju
 hMhb3g5jrwQdznhtlVc8rwSmY8dNoZJQJypiznOb+YxnE5LgvnRfbhjh8gXbDrgCtsth
 XnZw==
X-Forwarded-Encrypted: i=1;
 AKwUvByJfwfrKVy2Ayd4Owd25BDhAVEe+keWpLRNB9JQN+2yHfuvh/SkzgFcxWl15rSK6Se5gnOrQD1iLHkN@nongnu.org
X-Gm-Message-State: AFq9FYJkpFMXm5hEIHH6pOiTW1ONGsyU/9FQcA2DbTI7t/Y9KLBMq5IY
 O2wUySDQ8JF4JSNuhU0cGK+sb6/MmeL3+xCUYXEV9LpASq/EN9tDdMP6+q9d7gUn7rXkVoiRF5g
 XyHHSbga5wj/5Ty6YFAPWuuhjWV2g+2Z2SQgM6D1GKfi4kDRURtx+kwEm2g==
X-Gm-Gg: AYBFou1wOBraq2EoHzb0JIWz7nsc3pERfn53rskiZY/8e9k26DurkelcZV25/OKCjZB
 p4DF0XgNN1NoBbNtnJ7YByUxaDUnZxAvao75RaHcnp6nineyghf0BNWnBbGuucyXLLHjN0qnCW/
 al2GtqqyRyGraWVswOKvjzUCf6s4DzAW29iIrx7vTEejKI1lmqBwuivAF1ftPY4MmD0rZRdX5zL
 GVRwlVzgFHZnZz7j6VJj0yjhRKT0Zo3hyRRf4yORSNKLeBZrinCfAnOWrgpdzqM43r1oWOPKHiy
 PDmOhfAUpXlWkh71NIIKvQ00EINBTWqkleBNx0slCimFqu3ckWpkSc7uhK5zuMYC8yehJXAEl8U
 lb4No2QjbAtCwpK0ppASpEyDJnEkEcxQsPO7Q
X-Received: by 2002:a05:620a:2603:b0:93f:2463:f78f with SMTP id
 af79cd13be357-93f6f898d18mr581682085a.62.1792780864122; 
 Fri, 23 Oct 2026 11:41:04 -0700 (PDT)
X-Received: by 2002:a05:620a:2603:b0:93f:2463:f78f with SMTP id
 af79cd13be357-93f6f898d18mr581678185a.62.1792780863599; 
 Fri, 23 Oct 2026 11:41:03 -0700 (PDT)
Received: from [192.168.68.104] ([152.234.125.162])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9404722f49bsm86016085a.13.2026.10.23.11.41.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 11:41:03 -0700 (PDT)
Message-ID: <32fc55cb-bdf2-4407-8309-6d52757a210f@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 15:41:00 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] hw/intc/riscv_aplic: Add in-kernel aplic save and
 restore function
To: Wang Yechao <wang.yechao255@zte.com.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Xuemei Liu <liu.xuemei1@zte.com.cn>
References: <20261023021237.486091-1-wang.yechao255@zte.com.cn>
 <20261023021237.486091-3-wang.yechao255@zte.com.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261023021237.486091-3-wang.yechao255@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ZH650t7JkDxhepAz0ifU07GGO3fNfkK9
X-Authority-Analysis: v=2.4 cv=FM6OVOos c=1 sm=1 tr=0 ts=6adbaa41 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=AgQEunjic7gIBKSbIeB6Ag==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=1RTuLK3dAAAA:8 a=EUspDBNiAAAA:8 a=tvxrRNcjlJDut60I9ZoA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-GUID: ZH650t7JkDxhepAz0ifU07GGO3fNfkK9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA3MyBTYWx0ZWRfX3bmvhOwPX5P1
 UmSeU4R7MpqFHVZUHjQpGyMoJsf0EQ9zKbVbG0qjf7Z0wqFhLpMLhwS5PelrPXYRAJ6RfGbAj6w
 zJcXkpLBwgq9bwhtiOKi4uJpIgAlrqc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA3MyBTYWx0ZWRfX69XV1FSAfvmj
 VV3h8iD6rYEO8lTLk3ZTVEXlufrDDypsIsAUiSuHfgcRcbihSuLyZsXyP8tWBssDCRIQRU8vGti
 DG6NJPYBTYBzOZn8d0KsIBToNJSBlo/zE83mEQfpd5tEPM7Seo19jxpQs2VQwCEyReSX8Ph8vSx
 P7cr96V+0b1eJyOeZD/45iLUYqQE1MSHGnjpSBo9Ty/tryCxqOwzavssGGhOaIGSNl6Om525org
 vePbQja64OahpIPrNSzZLJbKg29IWIv37POoNorNP90m3TtGb5HFN3zdq7boQPYGVxIFGpB8wMW
 NkZ3EN7BXsSfvcL+STxaXbs7FB29uZfzjqdR8esi/NcwsKVv8mRwi9gRyfo4nkhjUhpeIVyolQB
 IXtMJLqGPJLwYjOrSrpCpbvCBBRhNT6lP6yXi8iGeJhx9SwBSyyPlIuUfI8px5TY+DuzCXUWquR
 1abG3QJFMLVXOIG/hWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230073
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/22/2026 11:12 PM, Wang Yechao wrote:
> From: Xuemei Liu <liu.xuemei1@zte.com.cn>
> 
> Add save and restore function if riscv_use_emulated_aplic return
> false, it is to get and set APLIC irqchip state from KVM kernel.
> 
> Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/intc/riscv_aplic.c         | 201 +++++++++++++++++++++++++++++-----
>   include/hw/intc/riscv_aplic.h |   4 +
>   2 files changed, 179 insertions(+), 26 deletions(-)
> 
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index 03a0852b8b..a3d209ca23 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -979,9 +979,7 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
>           }
>   
>           aplic->bitfield_words = (aplic->num_irqs + 31) >> 5;
> -        aplic->sourcecfg = g_new0(uint32_t, aplic->num_irqs);
>           aplic->state = g_new0(uint32_t, aplic->num_irqs);
> -        aplic->target = g_new0(uint32_t, aplic->num_irqs);
>           aplic->idelivery = g_new0(uint32_t, aplic->num_harts);
>           aplic->iforce = g_new0(uint32_t, aplic->num_harts);
>           aplic->ithreshold = g_new0(uint32_t, aplic->num_harts);
> @@ -993,8 +991,16 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
>           if (kvm_enabled()) {
>               aplic->kvm_splitmode = true;
>           }
> +    } else {
> +        aplic->nr_words = BITS_TO_U32S(aplic->num_irqs);
> +        aplic->setip = g_new0(uint32_t, aplic->nr_words);
> +        aplic->clrip = g_new0(uint32_t, aplic->nr_words);
> +        aplic->setie = g_new0(uint32_t, aplic->nr_words);
>       }
>   
> +    aplic->sourcecfg = g_new0(uint32_t, aplic->num_irqs);
> +    aplic->target = g_new0(uint32_t, aplic->num_irqs);
> +
>       /*
>        * Only root APLICs have hardware IRQ lines. All non-root APLICs
>        * have IRQ lines delegated by their parent APLIC.
> @@ -1020,47 +1026,190 @@ static const Property riscv_aplic_properties[] = {
>       DEFINE_PROP_BOOL("mmode", RISCVAPLICState, mmode, 0),
>   };
>   
> -static bool riscv_aplic_state_needed(void *opaque)
> +static bool riscv_emulated_aplic_state_needed(void *opaque)
>   {
>       RISCVAPLICState *aplic = opaque;
>   
>       return riscv_use_emulated_aplic(aplic->msimode);
>   }
>   
> +static const VMStateDescription vmstate_emulated_aplic_state = {
> +    .name = "riscv_aplic/emulated_aplic_state",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = riscv_emulated_aplic_state_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_VARRAY_UINT32(state, RISCVAPLICState,
> +                              num_irqs, 0,
> +                              vmstate_info_uint32, uint32_t),
> +        VMSTATE_UINT32(mmsicfgaddr, RISCVAPLICState),
> +        VMSTATE_UINT32(mmsicfgaddrH, RISCVAPLICState),
> +        VMSTATE_UINT32(smsicfgaddr, RISCVAPLICState),
> +        VMSTATE_UINT32(smsicfgaddrH, RISCVAPLICState),
> +        VMSTATE_UINT32(kvm_msicfgaddr, RISCVAPLICState),
> +        VMSTATE_UINT32(kvm_msicfgaddrH, RISCVAPLICState),
> +        VMSTATE_VARRAY_UINT32(idelivery, RISCVAPLICState,
> +                              num_harts, 0,
> +                              vmstate_info_uint32, uint32_t),
> +        VMSTATE_VARRAY_UINT32(iforce, RISCVAPLICState,
> +                              num_harts, 0,
> +                              vmstate_info_uint32, uint32_t),
> +        VMSTATE_VARRAY_UINT32(ithreshold, RISCVAPLICState,
> +                              num_harts, 0,
> +                              vmstate_info_uint32, uint32_t),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +#ifdef CONFIG_KVM
> +static bool kvm_riscv_aplic_state_needed(void *opaque)
> +{
> +    RISCVAPLICState *aplic = opaque;
> +
> +    return !riscv_use_emulated_aplic(aplic->msimode);
> +}
> +
> +static int kvm_riscv_aplic_state_pre_save(void *opaque)
> +{
> +    RISCVAPLICState *aplic = opaque;
> +
> +    for (uint32_t i = 0; i < aplic->nr_words; i++) {
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                 APLIC_SETIP_BASE + i * 4,
> +                                 aplic->setip + i, false);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                 APLIC_CLRIP_BASE + i * 4,
> +                                 aplic->clrip + i, false);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                 APLIC_SETIE_BASE + i * 4,
> +                                 aplic->setie + i, false);
> +    }
> +
> +    return 0;
> +}
> +
> +static int kvm_riscv_aplic_state_post_load(void *opaque, int version_id)
> +{
> +    RISCVAPLICState *aplic = opaque;
> +
> +    for (uint32_t i = 0; i < aplic->nr_words; i++) {
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                 APLIC_SETIP_BASE + i * 4,
> +                                 aplic->setip + i, true);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                 APLIC_CLRIP_BASE + i * 4,
> +                                 aplic->clrip + i, true);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                 APLIC_SETIE_BASE + i * 4,
> +                                 aplic->setie + i, true);
> +    }
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_kvm_aplic_state = {
> +    .name = "riscv_aplic/kvm_aplic_state",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = kvm_riscv_aplic_state_needed,
> +    .pre_save = kvm_riscv_aplic_state_pre_save,
> +    .post_load = kvm_riscv_aplic_state_post_load,
> +    .fields = (const VMStateField[]) {
> +            VMSTATE_VARRAY_UINT32(setip, RISCVAPLICState,
> +                                  nr_words, 0,
> +                                  vmstate_info_uint32, uint32_t),
> +            VMSTATE_VARRAY_UINT32(clrip, RISCVAPLICState,
> +                                  nr_words, 0,
> +                                  vmstate_info_uint32, uint32_t),
> +            VMSTATE_VARRAY_UINT32(setie, RISCVAPLICState,
> +                                  nr_words, 0,
> +                                  vmstate_info_uint32, uint32_t),
> +            VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static int riscv_aplic_pre_save(void *opaque)
> +{
> +    RISCVAPLICState *aplic = opaque;
> +
> +    if (!riscv_use_emulated_aplic(aplic->msimode)) {
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC, APLIC_DOMAINCFG,
> +                                 &aplic->domaincfg, false);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC, APLIC_GENMSI,
> +                                 &aplic->genmsi, false);
> +
> +        for (uint32_t i = 1; i < aplic->num_irqs; i++) {
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_SOURCECFG_BASE + (i - 1) * 4,
> +                                     aplic->sourcecfg + i, false);
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_TARGET_BASE + (i - 1) * 4,
> +                                     aplic->target + i, false);
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static int riscv_aplic_post_load(void *opaque, int version_id)
> +{
> +    RISCVAPLICState *aplic = opaque;
> +
> +    if (!riscv_use_emulated_aplic(aplic->msimode)) {
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC, APLIC_DOMAINCFG,
> +                                 &aplic->domaincfg, true);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC, APLIC_GENMSI,
> +                                 &aplic->genmsi, true);
> +
> +        for (uint32_t i = 1; i < aplic->num_irqs; i++) {
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_SOURCECFG_BASE + (i - 1) * 4,
> +                                     aplic->sourcecfg + i, true);
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_TARGET_BASE + (i - 1) * 4,
> +                                     aplic->target + i, true);
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +#else
> +static int riscv_aplic_pre_save(void *opaque)
> +{
> +    return 0;
> +}
> +
> +static int riscv_aplic_post_load(void *opaque, int version_id)
> +{
> +    return 0;
> +}
> +#endif
> +
>   static const VMStateDescription vmstate_riscv_aplic = {
>       .name = "riscv_aplic",
> -    .version_id = 3,
> -    .minimum_version_id = 3,
> -    .needed = riscv_aplic_state_needed,
> +    .version_id = 4,
> +    .minimum_version_id = 4,
> +    .pre_save = riscv_aplic_pre_save,
> +    .post_load = riscv_aplic_post_load,
>       .fields = (const VMStateField[]) {
>               VMSTATE_UINT32(domaincfg, RISCVAPLICState),
> -            VMSTATE_UINT32(mmsicfgaddr, RISCVAPLICState),
> -            VMSTATE_UINT32(mmsicfgaddrH, RISCVAPLICState),
> -            VMSTATE_UINT32(smsicfgaddr, RISCVAPLICState),
> -            VMSTATE_UINT32(smsicfgaddrH, RISCVAPLICState),
>               VMSTATE_UINT32(genmsi, RISCVAPLICState),
> -            VMSTATE_UINT32(kvm_msicfgaddr, RISCVAPLICState),
> -            VMSTATE_UINT32(kvm_msicfgaddrH, RISCVAPLICState),
> -            VMSTATE_VARRAY_UINT32(sourcecfg, RISCVAPLICState,
> -                                  num_irqs, 0,
> -                                  vmstate_info_uint32, uint32_t),
> -            VMSTATE_VARRAY_UINT32(state, RISCVAPLICState,
> +            VMSTATE_VARRAY_UINT32(sourcecfg , RISCVAPLICState,
>                                     num_irqs, 0,
>                                     vmstate_info_uint32, uint32_t),
>               VMSTATE_VARRAY_UINT32(target, RISCVAPLICState,
>                                     num_irqs, 0,
>                                     vmstate_info_uint32, uint32_t),
> -            VMSTATE_VARRAY_UINT32(idelivery, RISCVAPLICState,
> -                                  num_harts, 0,
> -                                  vmstate_info_uint32, uint32_t),
> -            VMSTATE_VARRAY_UINT32(iforce, RISCVAPLICState,
> -                                  num_harts, 0,
> -                                  vmstate_info_uint32, uint32_t),
> -            VMSTATE_VARRAY_UINT32(ithreshold, RISCVAPLICState,
> -                                  num_harts, 0,
> -                                  vmstate_info_uint32, uint32_t),
>               VMSTATE_END_OF_LIST()
> -        }
> +    },
> +    .subsections = (const VMStateDescription * const []) {
> +        &vmstate_emulated_aplic_state,
> +#ifdef CONFIG_KVM
> +        &vmstate_kvm_aplic_state,
> +#endif
> +        NULL
> +    }
>   };
>   
>   static void riscv_aplic_class_init(ObjectClass *klass, const void *data)
> diff --git a/include/hw/intc/riscv_aplic.h b/include/hw/intc/riscv_aplic.h
> index 62d2b33ade..de0fed4748 100644
> --- a/include/hw/intc/riscv_aplic.h
> +++ b/include/hw/intc/riscv_aplic.h
> @@ -53,6 +53,9 @@ struct RISCVAPLICState {
>       uint32_t *idelivery;
>       uint32_t *iforce;
>       uint32_t *ithreshold;
> +    uint32_t *setip;
> +    uint32_t *clrip;
> +    uint32_t *setie;
>   
>       /* topology */
>   #define QEMU_APLIC_MAX_CHILDREN        16
> @@ -66,6 +69,7 @@ struct RISCVAPLICState {
>       uint32_t num_harts;
>       uint32_t iprio_mask;
>       uint32_t num_irqs;
> +    uint32_t nr_words;
>       bool msimode;
>       bool mmode;
>   


