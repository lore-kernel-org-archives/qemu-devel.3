Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A94CDE000
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 12:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wciyC-0001i9-I0; Thu, 25 Jun 2026 08:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wciyB-0001hn-2s
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 08:14:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wciy9-0003CG-0X
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 08:14:10 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9juOw1723061
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 12:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 e6wIekjmXUC4mYjEPxFY4sNl/54KNlgu1Hw6ZfYR2bE=; b=XHdx2uabViw78Qiy
 tgB88hbG2WMqhW6RbbrqLzEImjFEghwMXYkJlNRmVyEkBzca0eBBKILscUB3nOLd
 GaYd22InhFmkzo12KMwVNGFZ2KaSgDCHJbq0Sc8+aVeZQ+QuLmtWxYqXJDJiLQD0
 U6/93lt+BAe64lFXjyd1v2hk95mtrGTu8F40UZiIt3d4x/1ViRqi1p6b/LLAhe7/
 QP+3HnSvykMkkOLHFHuudreuaIZtMqBffmdweM9HU3i6QlX2tPER7lhEYIsQ1yJb
 PRY2P8L3FUFlrUyj/kUJB1zWXBBMFwJGp+IbyJ2EMlSkDI/Vg2HJbZoGI/oRT7rJ
 jZWyUg==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0j7dv6w9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 12:14:06 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7e93b1b8b52so2729562a34.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 05:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782389646; x=1782994446; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e6wIekjmXUC4mYjEPxFY4sNl/54KNlgu1Hw6ZfYR2bE=;
 b=PFua5cEHw2xi8X8MuIoyjW79XMPN5F0upHBCczuMMLrr9Pi7hSQ7+T578KEcre513n
 q1Obcr8KF2SKtiU3ztDauVVU7NctH6GrVvkJskvl9/pN7meNyEPN+4hvSSiXfEmRJfLT
 3w4iUftvKXW7jScllLSqCa1/Ko/pZXGLL19xfbvswuROswPlriQnT5dgR+bdb/ksKkoB
 cO0sAoTYz8bL2BZCafvAbOGvatSBldzIX6aCHuxlGmx8sOWKY3ovkiUivOhD2qTUSnKi
 CsT242RfrHdPPs7JcmEp5VDyy65CDQZ0YfYlvCP8DtX3VFlj7tsvs0KFl5J5oa4mivUL
 PPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782389646; x=1782994446;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e6wIekjmXUC4mYjEPxFY4sNl/54KNlgu1Hw6ZfYR2bE=;
 b=H10hqz4OASOzDfPfvxJ1L3VbCbnlsJFu3qYKikZXu3tgxR09G4HD3OmdxA5vXWyMOa
 exGVB0Shg3wd/hHg75k3sVY2wyBqN/ie2bRhpd5mUEyrk00yEty5xWfJa/6OvxKbRCYk
 8IvwyMiujUM9c+CyveRHbTvIfdHvEluOjDeUXLSZ0LMUXB0w2/nxkMyxoPcU6dcCAxlV
 Ez+Z6IrR9ns0HrLACoS1i9yKvZ1wC3VRP3kjbVvzKar6FzZyUQo226utVBpmRnYdae11
 FJFGlSJ6o+amr5Ld19WKbDBG8AnCBrZGZUQYqax2N1FUyx/CJHQIfJGao9vIfTAq2Uyi
 X6Pw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Yi0MJb0oC7sRmqwe450Qg4DN2pawRVWHirdCn3jSvLY0gQG/4Ljdbmg0TSBOKnxwszHMCM859Tslv@nongnu.org
X-Gm-Message-State: AOJu0YzbVGgx636nNpUPBnbt4Kr367LCDlAHDTAa7kRuQGTKk/v/7RlE
 T7UYYLqdmDRXVQO2tN+xBpXnmhT0kBOcMJkwXYInpZ9pjHjDmaLjYqKjcRVRZp2vKLtnj9yq/Ob
 vTK3+bqttUqGMLUGmMBHjBfNBm5GM2tvwDyRWgUb4I0sWEvIsmp4ir+Zvhg==
X-Gm-Gg: AfdE7cnHQfnluJ08Z6+r1uzAe8+JMHhSMLHgoA+x6/HFu+eMbK3gp2cmUlcprutjWo4
 Gj891tYRdL1iuZvWyPjnaGHcILRZNswvGZqnQ9bFWJJAOrbOsvKS/3T0PGbzfSQPlguFqAEDZu+
 WvaruiRBr/v3CV48CzsQiCbRhJL/udQ8wbsErCCom2VG1B3jOaZqaI9o0Af6twab1J1H+Bk4TAG
 s0lVZKjk6YWjjuWz0k0b3VwIPeErHye2rG/4VfOYEHicm8Usl5wBH4xAsxsQoTc9psNq36q80FN
 xKsxW0TSX1iBmJeRhfKXtFnoQ0cRCpkHjSGsZURUDc9kSRAnLM9YTwWuodQvofjKBn3a1SGb5ue
 FBsf3mywqnEU95WQZo9ThkSGpcXP7l7U7rlQ+keq3/oTtl9jttvq7hWYRXP2M17bCAYfZ0a6YpF
 WzUG0=
X-Received: by 2002:a05:6830:6a8a:b0:7e9:419:acd with SMTP id
 46e09a7af769-7e99c25bb4fmr2315689a34.17.1782389646007; 
 Thu, 25 Jun 2026 05:14:06 -0700 (PDT)
X-Received: by 2002:a05:6830:6a8a:b0:7e9:419:acd with SMTP id
 46e09a7af769-7e99c25bb4fmr2315661a34.17.1782389645542; 
 Thu, 25 Jun 2026 05:14:05 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc2:6962:5520:30ca:9e66:df39?
 ([2804:7f0:bcc2:6962:5520:30ca:9e66:df39])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e94424c93fsm15123632a34.14.2026.06.25.05.14.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2026 05:14:04 -0700 (PDT)
Message-ID: <15e2ffbd-cb14-4767-ab56-e647fdc38b15@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 09:13:59 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Report QEMU CPU archid as 42
To: Charlie Jenkins <thecharlesjenkins@gmail.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Atish Patra <atish.patra@linux.dev>, qemu-riscv@nongnu.org
References: <20260624-marchid-v1-1-a0af7997071f@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260624-marchid-v1-1-a0af7997071f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 922ttTQWyFX3UR90-YH3qbSWcpH4ab_0
X-Authority-Analysis: v=2.4 cv=NvHhtcdJ c=1 sm=1 tr=0 ts=6a3d1b8e cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=xvfqbYfxAAAA:20
 a=VwQbUJbxAAAA:8 a=h0uksLzaAAAA:8 a=pGLkceISAAAA:8 a=-mnagkuO7avN7E2oGvQA:9
 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22 a=MSi_79tMYmZZG2gvAgS0:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEwNSBTYWx0ZWRfX/ISYElC6cEDK
 S3dlXSOswJSm2xi7rQyh7qZPMwp8HEzOV5C89n7GdJY8LHOSy/xC+ClIT2BvMlTQoWq9rK1hTiD
 jKPf49/+1pU+URKLUXD8Imd4ZDRzX/A=
X-Proofpoint-ORIG-GUID: 922ttTQWyFX3UR90-YH3qbSWcpH4ab_0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEwNSBTYWx0ZWRfX+YZBXw+BNn/e
 Tj2iLNG6WoE4aHiPkxlhLiu7KUMr4zImzmb6JyUbgmuDFfmOaiqAKj2kQQiI9s99pyvX4WlqTGk
 QrYN84mi/FSL0HfF5I+pfXpCJlEirCOnpNvxxXc3WmsgCT/LiFmtjh80BvZZAXy4zaOWe+KzqiS
 MZcz24+cqJwCPPKIUjyBsiNTG/5VzFIfGiNFlj5EpQxovZChE9sT2xtSTl2WpNJrLn9RFh88Aj+
 i9tMzGrCjZqwS3Z5fxwak22fpEQxF4CJbIYy14/jxdjnMRQhoeMSiqFY4mCfBz3mzMlkAizG7kr
 mVjMhBDvgRjZTQ8VkYV4dOMrIZT45BOv2JQpcUxiVIyIrLPib/KMBJI3JFHNitDt5Axo/gcIaMg
 wMthLSzQaHAFX9JE/oBEpljqwhVaud4TJIxwnAy/kyk+uiJhC8FcsoXJDZMcIKJFevymjznhHTO
 yGZxUKdzWM/wwyxTAqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250105
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Hi,

On 6/25/2026 3:26 AM, Charlie Jenkins wrote:
> When a non-vendor CPU is used, report the archid as 42 which has been
> allocated for QEMU in the riscv isa manual [1]. This can help software
> check if it is running in QEMU.
> 
> [1] https://github.com/riscv/riscv-isa-manual/blob/main/marchid.md
> 
> Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
> ---
> This series was original proposed by Palmer Dabbelt [1] with a follow up
> by Daniel Henrique Barboza. This patch implement's Daniel's suggestion.
> 
> When booting with a non-vendor CPU such as with the qemu arg "-cpu rv64"
> marchid will now be reported as 42.
> 
>> qemu-system-riscv64 ... -cpu rv64
> 
> processor       : 0
> hart            : 0
> isa             : rv64imafdch_zicbom_zicbop_zicboz_ziccrse_zicntr_zicsr_zifencei_zihintntl_zihintpause_zihpm_zaamo_zalrsc_zawrs_zfa_zca_zcd_zba_zbb_zbc_zbs_sstc_svadu_svvptc
> mmu             : sv57
> mvendorid       : 0x0
> marchid         : 0x2a
> mimpid          : 0x0
> hart isa        : rv64imafdch_zicbom_zicbop_zicboz_ziccrse_zicntr_zicsr_zifencei_zihintntl_zihintpause_zihpm_zaamo_zalrsc_zawrs_zfa_zca_zcd_zba_zbb_zbc_zbs_sstc_svadu_svvptc
> 
> When booting with a vendor CPU like veyron-v1, the proper marchid will
> still appear.
> 
>> qemu-system-riscv64 ... -cpu veyron-v1
> 
> processor       : 0
> hart            : 0
> isa             : rv64imafdch_zicbom_zicboz_ziccrse_zicntr_zicsr_zifencei_zihpm_zaamo_zalrsc_zca_zcd_zba_zbb_zbc_zbs_smaia_smstateen_ssaia_sscofpmf_sstc_svinval_svnapot_svpbmt
> mmu             : sv48
> mvendorid       : 0x61f
> marchid         : 0x8000000000010000
> mimpid          : 0x111
> hart isa        : rv64imafdch_zicbom_zicboz_ziccrse_zicntr_zicsr_zifencei_zihpm_zaamo_zalrsc_zca_zcd_zba_zbb_zbc_zbs_smaia_smstateen_ssaia_sscofpmf_sstc_svinval_svnapot_svpbmt
> 
> [1] https://lore.kernel.org/all/20240131182430.20174-1-palmer@rivosinc.com/

Thanks for linking the discussion.  I have but a vague memory of it and the link
helped.


> ---
>   target/riscv/cpu.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index fa497e5e8a..59d63f82c2 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -44,6 +44,9 @@
>   #endif
>   
>   /* RISC-V CPU definitions */
> +#define RISCV_CPU_MVENDORID 0
> +#define RISCV_CPU_MARCHID 42
> +#define RISCV_CPU_MIMPID 0
>   static const char riscv_single_letter_exts[] = "IEMAFDQCBPVH";
>   const uint32_t misa_bits[] = {RVI, RVE, RVM, RVA, RVF, RVD, RVV,
>                                 RVC, RVS, RVU, RVH, RVG, RVB, 0};
> @@ -1198,6 +1201,12 @@ static void riscv_cpu_init(Object *obj)
>       }
>   #endif
>   
> +    if (!riscv_cpu_is_vendor(obj)) {
> +        RISCV_CPU(obj)->cfg.mvendorid = RISCV_CPU_MVENDORID;
> +        RISCV_CPU(obj)->cfg.marchid = RISCV_CPU_MARCHID;
> +        RISCV_CPU(obj)->cfg.mimpid = RISCV_CPU_MIMPID;
> +    }
> +

Two things:

- we have a 'cpu' pointer at the start so you can use cpu->cfg... instead;

- the "cpu_is_vendor" check shouldn't be needed.  Whatever is set as default during
cpu_init() must be overwritten by CPUDef settings done in each DEFINE_RISCV_CPU()
macro.

This happens at this point:


     env->misa_ext_mask = env->misa_ext = mcc->def->misa_ext;
     riscv_cpu_cfg_merge(&cpu->cfg, &mcc->def->cfg);  <================

Therefore we can remove the "cpu_is_vendor" check and just assign the default QEMU IDs
as long as we do it before cpu_cfg_merge(e.g. right after "cpu->cfg.max_satp_mode = -1;").
If we do that we'll ensure that all CPUs will carry the RVI archid 42 unless told otherwise
by the CPU definition.

Yes, this will end up changing the IDs for vendor CPUs that don't set their own IDs.  This is
fine - if the CPU doesn't bother setting its own ID this means that the CPU is perfectly
fine with whatever default ID QEMU will provide.


Thanks,
Daniel


>       accel_cpu_instance_init(CPU(obj));
>   }
>   
> 
> ---
> base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
> change-id: 20260624-marchid-80d176b873d8
> 
> Best regards,
> --
> - Charlie
> 


