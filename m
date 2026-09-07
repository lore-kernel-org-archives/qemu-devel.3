Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85096C79FA0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 17:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3dN1-00026c-TH; Mon, 07 Sep 2026 13:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3dMz-00026B-Kg
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 13:43:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3dMx-0004fu-FI
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 13:43:01 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687HZq70472608
 for <qemu-devel@nongnu.org>; Mon, 7 Sep 2026 17:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gV8y0TGvee2XULE2T2HZVTQVSI+o+VN423nDauT2W2w=; b=NGnMkYheldXH/fzr
 Zkfmkn7KXgbZPfpkZL/qDl4ZVY01BwOgdfvG+1qoB3ZZPjZQI7RhxFCp6HTdWl6p
 X3MEO1WZc53bttgpB8BuPRG24G/nX4GfIsnqFoLaqZPINlprReZlTcYkIL5VoIE9
 hdG+fWqTEgzZCgDX6lznf6Bnj2VeQM9hceiAhqUU3ba7Uz8oegZo06BjJkUs74X8
 CtG8pbB3kmbvEcIkR/0I0W7nrOCsPSvGeAUBzwEmcTZZjVc5oNyexpr6jEl9hUjW
 vCAkyc17bLj2VrYJBIofXay/AsJR6O5UArbx3Vk2URwXpa312eb8bYipOV2IvzOI
 LhdGiA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghsfyj5d3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 17:42:58 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91043af01d9so56106736d6.2
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 10:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788802977; x=1789407777; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gV8y0TGvee2XULE2T2HZVTQVSI+o+VN423nDauT2W2w=;
 b=AD5i7LgACXsAFe0vzwEoD+hWJA8HNMAyT74ByoACeh7s1cs7CXfm8Gc98aDXl74+/g
 YpepIIUvJBfn7TUaNP9j6StCF9iog6t3HE29EAQpUQXvvTDSrmOD2oxE255tRfNZXI0x
 fYjnnBoVKI6a1KVRIQbUNxYfZpkBLy28HPU4FOzGpPEeaJvkBEC8N9d9vYogqoW24ybd
 P2InOl6/636nMKAadArtnFevVlncDh+IioNyOA9Ti6bWGL2jqBnKwJxHGSrvKihktSDY
 ck3lebihGMNPwPfj2zjzOUI5gPvwhcdqkjFj9wf1YHVQsmMAK57bHWi4yiVopv+Yaecz
 Hu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788802977; x=1789407777;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gV8y0TGvee2XULE2T2HZVTQVSI+o+VN423nDauT2W2w=;
 b=R3+sYj9oIJXtPl4oFAjhOLGEQVDr/1k4e643zHUu0ajGyhIjR7lfB5+gNbaz3oYhCf
 3oXZWH8XoWGYMdsY8P0/eJK91SdfVFMb5DerCsbkfpPtK09htLw7y/Y6S6WrXOeDqags
 VFhNwkENbbB3tX7PuO7ESti5dMvQX+bjxEzeg5AP+n7spUtLR3im+Mrzrck9TI5LmKn9
 ftPmhvL9LJvI27Wnm1eynTDeffg03fuFbu9nbkByNbIO3MgBR+1/bgrkhqL9pDwRMr2K
 ewiQgSAWnLVnG2KgnYojWXtG6aSghivEEZrTk8nocqtsJ2rLkh7f+M4bRc4Q4L8Dlu8E
 MhQw==
X-Forwarded-Encrypted: i=1;
 AKwUvBztIjAZXz2CGzwfJreW8Gq9ssV8zoOfwNjoG8YBZJjSP9EqYgZ7EWUXElJuonaX6P6m5CYtMKgl95bK@nongnu.org
X-Gm-Message-State: AFuF++m/TptNRW9zzb0ffXw1C2JVXSU76C5D3B7J34sk28SCs+20tl8a
 PMKJu5P6fQm8QIwk8+KCoKi7Zx6n+onA0S0nAm9cA3sMRb6tMgUYrXSKT2WuIeHXPQmZLptcH1+
 190aU+REa1qvi8QfbUIFoi8SmBKhbZ/nLnayOsinZBFLJeHqeOqlmcnJPhg==
X-Gm-Gg: AYBFou02rKdCu0439ZTzJHxJGWXWsC9HgLPYQZc+zYwnF7ToNazmKGDMcRBDL0Z/W9Q
 WIuNUDS+lKzdvWhyuLXKym+4SFm9Gl/5FcmOxwbaLrEtOjd8Bd1qpEEl3TYvPbzdIF340POVju4
 mTyU7XmcDYiacwcnChbUoORclqKQVWMWxYCoZHukBWmqi2G2Hp7eOxptVrsnnhbAamzJzpChNw1
 S58nJXJuitUPcCQgwX6A3jABQtPB5f+XBQ4t2Ts0GHV7nWjvPACNurAUumOeKtQuHFq6pHiNihW
 KBcmPCla/D8Y7nmBtSE6UCH0XjE+hpO49Dw41evgYvVyBVGN/Q3RZU5j2uXweq4AjvfigIUPBxZ
 KbW3eWlkxzUBlcxtua++3yY2IO6qZVoSeu5s=
X-Received: by 2002:a05:6214:f25:b0:910:44f2:5ce3 with SMTP id
 6a1803df08f44-91044f25d21mr250682936d6.8.1788802977475; 
 Mon, 07 Sep 2026 10:42:57 -0700 (PDT)
X-Received: by 2002:a05:6214:f25:b0:910:44f2:5ce3 with SMTP id
 6a1803df08f44-91044f25d21mr250679746d6.8.1788802974857; 
 Mon, 07 Sep 2026 10:42:54 -0700 (PDT)
Received: from [192.168.68.102] ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91043b54cd6sm85722896d6.34.2026.09.07.10.42.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 10:42:54 -0700 (PDT)
Message-ID: <d72d945a-f9ec-42c0-a01c-c7b4d6d6a41a@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 14:42:51 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] target/riscv: require read permission for HLVX
 accesses
To: wangyang <wangyang25@otcaix.iscas.ac.cn>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
References: <20260905093749.491-1-wangyang25@otcaix.iscas.ac.cn>
 <20260905093749.491-4-wangyang25@otcaix.iscas.ac.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260905093749.491-4-wangyang25@otcaix.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: tsMdhfnX-6k6C9Xe_HT39B8ezpe1u7xY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE5NiBTYWx0ZWRfX5ijN+s9PUSbY
 AmN3ma0oZNadml4r82ESsNhmYM8H5rCpsC3YWgBIDYG1BOx/lZRDXOPcrGJIOjbN5UKyYIEeSMF
 UZKAKQjKcSKrGcyV3w4Ws9W2k/6v6qsnqmYjU/yR8iuMh7R36ll7cU/kqqEY0+f/nBh8BlGkde7
 xHnYI3Tzhlj700SAeiw86gyyD1CkdAlIgICn15Q55J9BQvkrBH6Rjqc994kek4TGfVunMQ+2LTu
 c+QniCsMN4ASe5GDoovNPGTDMowq3YofE1C0odzg8+7PM0/5SirQfICqQilONjGuLk63xCamqH2
 ncZi+8LMICqb6wPilGkA4OBF7j+5JNVOi6yZzB8JkSO7MrDAxI24fn4eMM+cvCXRyIVU4KygqXX
 oC4608yCqFOdDTJaTYD0JNpZtVrkuMOlP44RQkHScv7Utrd7zwtiu6Aj1O5rTKAJcQLAeNqB/Dy
 iGfP82Rw7Ll15mPhjaw==
X-Proofpoint-GUID: tsMdhfnX-6k6C9Xe_HT39B8ezpe1u7xY
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE5NiBTYWx0ZWRfX1d6tp4F4atkB
 pixNbb+iYwUVSR8/G/gPYGriCQ8ONACau0S0HYja6Za9Myswi4/2gNuK+yU6me5O1IXNRBYGzjy
 bP9axUHiHaoHvpco9C6xL++OknXvdpA=
X-Authority-Analysis: v=2.4 cv=AduB2XXG c=1 sm=1 tr=0 ts=6a9ef7a2 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=p0WdMEafAAAA:8 a=UUCCqBSPgqXJescDracA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_05,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070196
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 9/5/2026 6:37 AM, wangyang wrote:
> HLVX address translation uses execute permission, but the final PMP
> check on the supervisor physical address must also require read
> permission. Carry the HLVX operation through the MMU index and include
> PMP_READ in the final check so execute-only pages fault.
> 
> Tested: RV32 system-mode RWX, HLV, and HLVX.WU PMP witness matrix.

Please remove the "witness matrix" part.

We are aware that some Gitlab issues, like 4414 that is being fixed here,
are using the word "witness" quite liberally.  In 4414 alone:

"I triaged the result and independently replayed the fixed witness on
  upstream QEMU 11.1.1."

"OS/kernel version: not applicable to the direct witness."

"Source witness and linker script are attached to this issue."

"Build the attached witness source and linker script into ..."


I'll take a guess that 'witness' is being used as a synonym for 'test case'. I
would expect reading something like "witness matrix" in a Law and Order episode,
not QEMU source.

English isn't my native language, and maybe the use of 'witness' here is valid.
Even then I'll ask to remove any references to it, replacing it with 'test case'
if needed, to keep the source code easier to follow.


ps: the code LGTM. Thanks,

Daniel

> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4414
> 
> Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>
> ---
>   target/riscv/internals.h      |  6 ++++++
>   target/riscv/tcg/cpu_helper.c | 24 ++++++++++++++++--------
>   target/riscv/tcg/op_helper.c  | 11 +++++------
>   3 files changed, 27 insertions(+), 14 deletions(-)
> 
> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
> index 5d84e4de96..832c6406bc 100644
> --- a/target/riscv/internals.h
> +++ b/target/riscv/internals.h
> @@ -42,6 +42,7 @@
>   #define MMUIdx_M            3
>   #define MMU_2STAGE_BIT      (1 << 2)
>   #define MMU_IDX_SS_WRITE    (1 << 3)
> +#define MMU_IDX_HLVX        (1 << 4)
>   
>   static inline privilege_mode_t mmuidx_priv(int mmu_idx)
>   {
> @@ -62,6 +63,11 @@ static inline bool mmuidx_2stage(int mmu_idx)
>       return mmu_idx & MMU_2STAGE_BIT;
>   }
>   
> +static inline bool mmuidx_hlvx(int mmu_idx)
> +{
> +    return mmu_idx & MMU_IDX_HLVX;
> +}
> +
>   /*
>    * Return the endianness for the current privilege
>    * level, based on the MSTATUS MBE/SBE/UBE bits.
> diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
> index 07d9222652..ad41de9d06 100644
> --- a/target/riscv/tcg/cpu_helper.c
> +++ b/target/riscv/tcg/cpu_helper.c
> @@ -905,6 +905,7 @@ void riscv_cpu_set_mode(CPURISCVState *env, privilege_mode_t newpriv,
>    */
>   static int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
>                                       int size, MMUAccessType access_type,
> +                                    pmp_priv_t extra_privs,
>                                       privilege_mode_t mode)
>   {
>       pmp_priv_t pmp_priv;
> @@ -915,7 +916,8 @@ static int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
>           return TRANSLATE_SUCCESS;
>       }
>   
> -    pmp_has_privs = pmp_hart_has_privs(env, addr, size, 1 << access_type,
> +    pmp_has_privs = pmp_hart_has_privs(env, addr, size,
> +                                       (1 << access_type) | extra_privs,
>                                          &pmp_priv, mode);
>       if (!pmp_has_privs) {
>           *prot = 0;
> @@ -1177,7 +1179,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>           int pmp_prot;
>           int pmp_ret = get_physical_address_pmp(env, &pmp_prot, pte_addr,
>                                                  sxlen_bytes,
> -                                               MMU_DATA_LOAD, PRV_S);
> +                                               MMU_DATA_LOAD, 0, PRV_S);
>           if (pmp_ret != TRANSLATE_SUCCESS) {
>               return TRANSLATE_PMP_FAIL;
>           }
> @@ -1425,7 +1427,8 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>           }
>   
>           pmp_ret = get_physical_address_pmp(env, &pmp_prot, pte_addr,
> -                                           sxlen_bytes, MMU_DATA_STORE, PRV_S);
> +                                           sxlen_bytes, MMU_DATA_STORE, 0,
> +                                           PRV_S);
>           if (pmp_ret != TRANSLATE_SUCCESS) {
>               return TRANSLATE_PMP_FAIL;
>           }
> @@ -1711,7 +1714,9 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>   
>               if (ret == TRANSLATE_SUCCESS) {
>                   ret = get_physical_address_pmp(env, &prot_pmp, pa,
> -                                               size, access_type, mode);
> +                                               size, access_type,
> +                                               mmuidx_hlvx(mmu_idx) ?
> +                                               PMP_READ : 0, mode);
>                   tlb_size = pmp_get_tlb_size(env, pa);
>   
>                   qemu_log_mask(CPU_LOG_MMU,
> @@ -1746,7 +1751,9 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>   
>           if (ret == TRANSLATE_SUCCESS) {
>               ret = get_physical_address_pmp(env, &prot_pmp, pa,
> -                                           size, access_type, mode);
> +                                           size, access_type,
> +                                           mmuidx_hlvx(mmu_idx) ?
> +                                           PMP_READ : 0, mode);
>               tlb_size = pmp_get_tlb_size(env, pa);
>   
>               qemu_log_mask(CPU_LOG_MMU,
> @@ -1786,9 +1793,10 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>           cpu_check_watchpoint(cs, address, size, MEMTXATTRS_UNSPECIFIED,
>                                wp_access, retaddr);
>   
> -        raise_mmu_exception(env, address, access_type, pmp_pma_violation,
> -                            first_stage_error, two_stage_lookup,
> -                            two_stage_indirect_error);
> +        raise_mmu_exception(env, address,
> +                            mmuidx_hlvx(mmu_idx) ? MMU_DATA_LOAD : access_type,
> +                            pmp_pma_violation, first_stage_error,
> +                            two_stage_lookup, two_stage_indirect_error);
>           cpu_loop_exit_restore(cs, retaddr);
>       }
>   
> diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
> index 3e94005d2b..060d97ee9c 100644
> --- a/target/riscv/tcg/op_helper.c
> +++ b/target/riscv/tcg/op_helper.c
> @@ -650,7 +650,7 @@ static int check_access_hlsv(CPURISCVState *env, bool x, uintptr_t ra)
>       if (!x && mode == PRV_S && get_field(env->vsstatus, MSTATUS_SUM)) {
>           mode = MMUIdx_S_SUM;
>       }
> -    return mode | MMU_2STAGE_BIT;
> +    return mode | MMU_2STAGE_BIT | (x ? MMU_IDX_HLVX : 0);
>   }
>   
>   target_ulong helper_hyp_hlv_bu(CPURISCVState *env, target_ulong addr)
> @@ -726,11 +726,10 @@ void helper_hyp_hsv_d(CPURISCVState *env, target_ulong addr, target_ulong val)
>   }
>   
>   /*
> - * TODO: These implementations are not quite correct.  They perform the
> - * access using execute permission just fine, but the final PMP check
> - * is supposed to have read permission as well.  Without replicating
> - * a fair fraction of cputlb.c, fixing this requires adding new mmu_idx
> - * which would imply that exact check in tlb_fill.
> + * HLVX accesses are translated with execute permission (first stage),
> + * but the final PMP check on the supervisor physical address must
> + * require read permission as well.  The MMU_IDX_HLVX mmu_idx bit set
> + * by check_access_hlsv() makes riscv_cpu_tlb_fill() enforce this.
>    */
>   target_ulong helper_hyp_hlvx_hu(CPURISCVState *env, target_ulong addr)
>   {


