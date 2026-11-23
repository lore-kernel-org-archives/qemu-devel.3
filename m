Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47B8606A31F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 20:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fyFh8Ky3;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EE1dedoa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVaHt-000631-1C; Mon, 23 Nov 2026 15:05:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVaHr-00062p-B1
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 15:05:15 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVaHp-0002Cd-5G
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 15:05:14 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANJuYSG1579746
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 20:05:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jctTf7MlA/OhyTxx8VxIJDBlWtWuAXaZzvVIWxJ7eAI=; b=fyFh8Ky3grvgGf4W
 b164bB8vpAVIfd9+dP4UC4oQXvWF1HKrg8+XVc7TR2lWygMiLmQdm1WcZXLqCG+B
 C4FgpR6P0hEOkCglnXiAmcr8KzKwSlDfI8VX6+QONwz/H0t1dXlB8hmHWptB8UE/
 M9iKCBUdgp76CLs0+SkMZPhqTJ59ft5Qm5bydPlumLwgSgDxs4ppHoh3ZVQ6znPA
 41V9G1NCEWKJFNST5hr3T2gcNxIy2J+/jlKiwg9qPalYFGhmKXncyUUZJf3SsOch
 eh/Eg+AT7wTfrjg2oH6EBnPEmUBEPQCfG6AM7qsfnMn1PsObH75EGmySYRnOGIdb
 o7i+Uw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4ma0t5v3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 20:05:11 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-94970ad532bso74428885a.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 12:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795464310; x=1796069110; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jctTf7MlA/OhyTxx8VxIJDBlWtWuAXaZzvVIWxJ7eAI=;
 b=EE1dedoa6Gkw9hBh6H5J8b403otzQPaC5aLCpzF1B2yee9+eUzcM7a5Kj68EokTYMZ
 uldGhRqWCZQdYE72CdVUOFsx9G5CcqDMNym4RhTjuLZCuZI8ntvrxNtrdWnl+YWY8PxY
 ZKXYVGtUIPMZdVXiocSe/4STzJN8JNmi9rYYFyebcPZTvAfP2sXjfsdyxtdV7njl3Eaq
 zyTyi5MTy09te0DglfYFSbV2QvHpWiSScM7OF5ug9rz+lKEm0X6jaEaeTfL06++x8bif
 4uDZPBazyDzDKmP+95EAmAJgwnsuHQKp8DpN8Os+tdqidnNLT/dwvBLMouZtw9FmUg41
 aCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795464310; x=1796069110;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jctTf7MlA/OhyTxx8VxIJDBlWtWuAXaZzvVIWxJ7eAI=;
 b=xgv9ubhGE8RvPgl3zh//Ed0e/yHZDR0MimheUzrr4sv4UlKV1I6GGppn/bJEAFKzeO
 fo+OkGfvSBFWNhsL+Q6jhvdt/gM+43tVjpYsHJAxo+yWm/YSYqk6KfQHRw5JHFOYkNOO
 GWqYW0yL8B+YPc5SxBUvjGfy6PjICK0wE2PVZj591D6C+YU+yYcDdG5WKYFK/6/AWHSO
 JJskc3GX8Nmt2/bODTFSKdIrBa7uyAINX5MT7NabQP3/JUVrNGNhN1JeSzsBUmumU+Op
 j62Qdwo0RaGBeoVUrhzIDKfwad/bl4mdaPkWSdQZQkhWz5a1ZE+jp4RYxW+BpGkyQGlh
 vb+Q==
X-Forwarded-Encrypted: i=1;
 AL+hErEoWD3HnDqOwVZkq5zdyUIxn8syAcLz+X+vzxtXV28mBN4G5HYtq9Ucv83SQG8IC0DRVwEuiWKXeG+a@nongnu.org
X-Gm-Message-State: APuU4Z+sYSERcCtkBz2+eG4dNpBv2T2a7Yfr/+grFL4Vw5nsYSuTucXO
 F3i4c+D+nQgS7KRsM6j4OEp/1OfUTZjBdFHKXKqPEAa77I6ika/3TfuhE8c6w0FoAUgvWYV0q8j
 s5odAEGToQrnGIpgJwi8yaNuW0jDdBFQoPa0KSTRvFmwdAe2QfiTZ+XliwQ==
X-Gm-Gg: AZFdTZddfiR4+PxkyZkWyNL/p13PVa/HMsgPzdrtdUg4yEUtmRSa/lUTRPmtendL8QW
 5s1pTBzc9bLsLt14rgrwudR273f4E73nNZmoltzJPhBNexX591XqtGKxQsNTtpoFXuhFXKBQdJV
 NW68AioY/8J7Rw3DJREgHzMA+6MAQpgxvqWulMFF9ytJpaHFyd+ec9V06wxl1J8NOwUbI1lpYXa
 YVMk5SnJ2FUWHYMXa+t8Gtj1veKGxBjRyTMr3GpxlEx7y5/EL+FjRDnlgf5+RiHVXlgJ9km9SAj
 09J0Yaiu0QrUYYlCMVHaWI2tpOMj6NNZj4WgLj0+LvXJFxr4JbApiodqmFd3qTnoyZtdPnfyrdh
 hutQcd9ozMRrlTZjS4XFPNQqEZxhxfW5+osCigVfaKgTnMxMSjgMQ+8gZAbmMXV+p6sY47my9l1
 TyPrrJDZlD
X-Received: by 2002:a05:620a:2995:b0:93f:43a4:a48c with SMTP id
 af79cd13be357-949baa0640dmr2226389185a.45.1795464309832; 
 Mon, 23 Nov 2026 12:05:09 -0800 (PST)
X-Received: by 2002:a05:620a:2995:b0:93f:43a4:a48c with SMTP id
 af79cd13be357-949baa0640dmr2226379585a.45.1795464309153; 
 Mon, 23 Nov 2026 12:05:09 -0800 (PST)
Received: from [192.168.68.101] ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb34ae74sm876952585a.8.2026.11.23.12.05.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 12:05:08 -0800 (PST)
Message-ID: <4fe0858f-aa32-4f1a-bb92-767c2e51c8a4@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 17:05:05 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/riscv: iommu: Add migration support for common
 state
To: Tan Chi <tanchi25@mails.ucas.ac.cn>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com
References: <20261119024251.280765-1-tanchi25@mails.ucas.ac.cn>
 <20261119024251.280765-2-tanchi25@mails.ucas.ac.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261119024251.280765-2-tanchi25@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: E39EXLuOEn0rfLW5YUlx1lSSEyWla1mC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3OSBTYWx0ZWRfX4oxpQPpTJiK9
 Od/gVO64oawKzot/zb8x69lIjzR62BKEGIvMDraowny5cq6l22g7EAmM6tzu6rFDUOzu3PJklti
 agi1C48toaWJ3R23ljNmFkYsXYETOao=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3OSBTYWx0ZWRfX0FV/TicH7epu
 DYCOoRksORRP3JirVGu7i9RNDyR8S+SDuQGuDE4st1UvGhBzxEWn70VtBviOb2EayWC21jlqFZq
 z2kHSYz1hcE7WD0SYhvaVMltPB8b92QLolXgg83Vp4MVatiW8fOv0Qk0WisPvNHAJg6DKPoI/tu
 FdVSz5RAX3p2Hihle1EnWFscV+ygS10u2UY1KqxTS7DmYUkFoJxq3qaR3uYLLgh8mRqQcmOQYfe
 7n2cwmHUd4fB3PR9SzZNexe+s3quPW500AEji+3RZrURI1MAO4HgtHoaoEstuYT8z1OJRZOaYsR
 3ZbgG6+ogHLPHPzLGJrllJNziRuRGtfwGbKkQKRnF6Ncom2jPcCRTOeBCCO9hDGX9Z6tKPQpSui
 MpT/zQUG5CUJtZMDocy5fwij4sLIkFIXf9wLEKdZYTnarfbmcCEdxXoD3d0t/7yYzPSg6GieGAi
 WjMCxy7E6nTW9VJpK9A==
X-Authority-Analysis: v=2.4 cv=Yr+a1IYX c=1 sm=1 tr=0 ts=6b049c77 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=jNSlP54px0yOmMIMDkQA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: E39EXLuOEn0rfLW5YUlx1lSSEyWla1mC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230079
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



On 11/18/2026 11:42 PM, Tan Chi wrote:
> Add VMState support for the common RISC-V IOMMU device to preserve
> its register state, device directory configuration, and command,
> fault, and page-request queue state across migration.
> 
> Save the HPM cycle counter state and overflow timer in a separate
> subsection when HPM is enabled. Rebuild the HPM event-to-counter
> mapping from the restored event selector registers on the
> destination.
> 
> Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/riscv/riscv-iommu-hpm.c | 27 +++++++++++++++++++
>   hw/riscv/riscv-iommu-hpm.h |  2 ++
>   hw/riscv/riscv-iommu.c     | 54 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 83 insertions(+)
> 
> diff --git a/hw/riscv/riscv-iommu-hpm.c b/hw/riscv/riscv-iommu-hpm.c
> index 9bfef6db45..9656fdc839 100644
> --- a/hw/riscv/riscv-iommu-hpm.c
> +++ b/hw/riscv/riscv-iommu-hpm.c
> @@ -381,3 +381,30 @@ void riscv_iommu_process_hpmevt_write(RISCVIOMMUState *s, uint32_t evt_reg)
>   
>       update_event_map(s, val, ctr_idx);
>   }
> +
> +int riscv_iommu_hpm_post_load(void *opaque, int version_id)
> +{
> +    RISCVIOMMUState *s = opaque;
> +    uint64_t evt_val;
> +    unsigned int i;
> +
> +    if (!(s->cap & RISCV_IOMMU_CAP_HPM)) {
> +        return 0;
> +    }
> +
> +    g_hash_table_remove_all(s->hpm_event_ctr_map);
> +
> +    for (i = 0; i < s->hpm_cntrs; i++) {
> +        evt_val = riscv_iommu_reg_get64(
> +                    s, RISCV_IOMMU_REG_IOHPMEVT_BASE + (i << 3));
> +
> +        if (!check_valid_event_id(
> +                get_field(evt_val, RISCV_IOMMU_IOHPMEVT_EVENT_ID))) {
> +            continue;
> +        }
> +
> +        update_event_map(s, evt_val, i);
> +    }
> +
> +    return 0;
> +}
> diff --git a/hw/riscv/riscv-iommu-hpm.h b/hw/riscv/riscv-iommu-hpm.h
> index 5fc4ef2e8b..516974ec87 100644
> --- a/hw/riscv/riscv-iommu-hpm.h
> +++ b/hw/riscv/riscv-iommu-hpm.h
> @@ -30,4 +30,6 @@ void riscv_iommu_process_iocntinh_cy(RISCVIOMMUState *s, bool prev_cy_inh);
>   void riscv_iommu_process_hpmcycle_write(RISCVIOMMUState *s);
>   void riscv_iommu_process_hpmevt_write(RISCVIOMMUState *s, uint32_t evt_reg);
>   
> +int riscv_iommu_hpm_post_load(void *opaque, int version_id);
> +
>   #endif
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 5b1a388364..7c23e32693 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -3067,6 +3067,59 @@ void riscv_iommu_reset(RISCVIOMMUState *s)
>       qemu_mutex_unlock(&s->iot_lock);
>   }
>   
> +static bool riscv_iommu_hpm_state_needed(void *opaque)
> +{
> +    RISCVIOMMUState *s = opaque;
> +
> +    return !!(s->cap & RISCV_IOMMU_CAP_HPM);
> +}
> +
> +static const VMStateDescription vmstate_riscv_iommu_hpm = {
> +    .name = "riscv-iommu/hpm",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = riscv_iommu_hpm_state_needed,
> +    .post_load = riscv_iommu_hpm_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT64(hpmcycle_val, RISCVIOMMUState),
> +        VMSTATE_UINT64(hpmcycle_prev, RISCVIOMMUState),
> +        VMSTATE_UINT64(irq_overflow_left, RISCVIOMMUState),
> +        VMSTATE_TIMER_PTR(hpm_timer, RISCVIOMMUState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription vmstate_riscv_iommu = {
> +    .name = "riscv-iommu",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .priority = MIG_PRI_IOMMU,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_BUFFER_POINTER_UNSAFE(regs, RISCVIOMMUState,
> +            0, RISCV_IOMMU_REG_MSI_CONFIG),
> +
> +        VMSTATE_UINT64(ddtp, RISCVIOMMUState),
> +        VMSTATE_UINT64(fctl, RISCVIOMMUState),
> +
> +        VMSTATE_UINT64(cq_addr, RISCVIOMMUState),
> +        VMSTATE_UINT64(fq_addr, RISCVIOMMUState),
> +        VMSTATE_UINT64(pq_addr, RISCVIOMMUState),
> +
> +        VMSTATE_UINT32(cq_mask, RISCVIOMMUState),
> +        VMSTATE_UINT32(fq_mask, RISCVIOMMUState),
> +        VMSTATE_UINT32(pq_mask, RISCVIOMMUState),
> +
> +        VMSTATE_BUFFER_POINTER_UNSAFE(regs_ro, RISCVIOMMUState,
> +            0, RISCV_IOMMU_REG_MSI_CONFIG),
> +
> +        VMSTATE_END_OF_LIST(),
> +    },
> +    .subsections = (const VMStateDescription * const []) {
> +        &vmstate_riscv_iommu_hpm,
> +        NULL
> +    }
> +};
> +
>   static const Property riscv_iommu_properties[] = {
>       DEFINE_PROP_UINT32("version", RISCVIOMMUState, version,
>           RISCV_IOMMU_SPEC_DOT_VER),
> @@ -3094,6 +3147,7 @@ static void riscv_iommu_class_init(ObjectClass *klass, const void *data)
>       dc->user_creatable = false;
>       dc->realize = riscv_iommu_realize;
>       dc->unrealize = riscv_iommu_unrealize;
> +    dc->vmsd = &vmstate_riscv_iommu;
>       device_class_set_props(dc, riscv_iommu_properties);
>   }
>   


