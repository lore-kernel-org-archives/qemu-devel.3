Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3EAC79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 20:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4OVX-0008Kw-Qa; Wed, 09 Sep 2026 16:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x4OVV-0008Kf-KJ
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:02:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x4OVT-0005H4-HR
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:02:57 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 689JIgnq3423217
 for <qemu-devel@nongnu.org>; Wed, 9 Sep 2026 20:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XfRMQpOLAVE9+T0lTgcOZDux6EKDc6MP1lhQd9tFPAI=; b=OCmpCimeP6l0ATFc
 0U7H1RCfiYstITs5RN4mZQXlxdEtXp7rFZdMFQudh5JfdFZc9bViBZHOkpJFnglE
 ruxqpS7iPIaZ/KRcxAUbm2oRrwcNgs1toDpB9d1uxYnBOFPSe9QRa5hdR3RvPoHl
 mrhMHxfl0TAEVj6iGACISpiVsfU6mS6J8c2nALk7tE4pxeAryUSAUKSt/qOPMOgy
 677rGsoJze08rBsBAYw7OJOqi2NYk8YVhcGCyx8ow8tZWqKtou10Oe2qEI/roh0O
 xqXRwmTzL91O3kL3L44eZoK/gkLQQAYdFZPEM2djcO32iVJsmY6lW7RpM10T/GPg
 kuSw7g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyggayw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 20:02:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93918756165so1087890185a.0
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 13:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788984173; x=1789588973; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XfRMQpOLAVE9+T0lTgcOZDux6EKDc6MP1lhQd9tFPAI=;
 b=jEyBo2aJpATSEuP5xMvZvOeByCHhRgD9aEon1bxM0mabpdyfk7QaBS8P7GgmY5cc20
 ewlzLYxVH8U1ru91Irqi3js8HpY6iQEMPKak1BUMgV9lVHogGp8H9aUlxnypXy7CSEnH
 jwSoIrkuyak+opcMrNtFqJufdauOlpj/JPPBWrwOGCNG2D5cLx5DsUdgYf+wpDnzQKZf
 q5kOBAoFlOjozmzuN7CLhtYAvQSR4iOiWLdgh6XAom7YaXtJ/vIGG56f3VvP9szKom9j
 5qj1j1/cqlpfE6VN708LXTHlwciqnLORAAKFBlHsrca+lirX4HhBF9nNY2akh+9j476C
 BWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788984173; x=1789588973;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XfRMQpOLAVE9+T0lTgcOZDux6EKDc6MP1lhQd9tFPAI=;
 b=OWAmZy7blF+FWVYxnEGbqZhS2EdYfTlhoT/zWqKcEWIcTDEDt54UkBfgTZhHVwoIyY
 ImKR2MywdKBYzi79pm4RxyDWY6wUgrCLuvoGAf/PAhmcEdFofP81AaUMquHlzyHC+QNX
 rHqDNa+zayH94FNhflK4m2IiZirwl5f+QQrIOkLA3IvAoLD6m4sSmSCn3vIoUssTKfVJ
 OeLpvdCNsbJb59UlVjHWJCgSVwI0bLuwmNlZAjPs929UQoLMMjV/dEGofNHiXMIbVTlx
 pgcxQ8qgDn7NiTDYv26jQATiiPKfD9vhbqiSYynhvJLftjmKMRGgOiaItbJMP7ujltZB
 kPQA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz6JULOVU2aL/oYMcL5L3TnDZ8kOGhWC1m2o7dAZTKZ+jA7vuPPdYVWwWVuPd8KeZhF9SgohcKfELgS@nongnu.org
X-Gm-Message-State: AFuF++lMoFIUmuCDKMatstGR587O+0y5/TvaQ4IjdUEo4kUs2G4gTRAK
 3+z6etjmlXVguU3MzFNKjorWnxd9te6JNeXBa1fHGR6gwnghOupWs2lpbgI7dFeKDJ+HV431NgL
 d10sB5tWyhBJ3+aQrWTOM9gqSMIPGyO5t4tbgwtpzPkEeopQH/GBNZVU9TXgX20biiw==
X-Gm-Gg: AYBFou1tgldhRJRXYtmeIYoODR79KFvMbOuy+OmPSHERkSvxtsU6mHHmFR2pAZt0/WY
 h2zSOeiO2ccJPwgOtIQxhOAhrFG3yDvqJUz2LIQu01HlGX8Z0Hj/eGEWElyNs2yoUqDdnFIdtIl
 HDdBBWUJuCxwyx6P9Ed5qY2J+MD8/L8NJ2/m4Ukt7bEDwZ/e7q6hORwFMifnya7YOlJiGLr1tEk
 UTfrY5ndqsEjOeJq3rG9G2Xy3HQK8Q69YTFslfjSrhwFo/kd3DdFq+huKE5wVfhcZMBnLo/xAkm
 rSuTuXqo8QLhTvElHv5IaXZy0wk85XzPO69EMSpuoMTpmrKSzyT8dvRWPuPxOjGudaUgO9SfJVG
 LNgjsOE1quvgepQgu60qld7ZoVPA8O6Ra3XA=
X-Received: by 2002:a05:620a:3941:b0:92e:4927:2002 with SMTP id
 af79cd13be357-939d4a8ebb0mr553970285a.39.1788984173281; 
 Wed, 09 Sep 2026 13:02:53 -0700 (PDT)
X-Received: by 2002:a05:620a:3941:b0:92e:4927:2002 with SMTP id
 af79cd13be357-939d4a8ebb0mr553961985a.39.1788984172777; 
 Wed, 09 Sep 2026 13:02:52 -0700 (PDT)
Received: from [192.168.68.102] ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939b0493142sm758134485a.13.2026.09.09.13.02.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2026 13:02:52 -0700 (PDT)
Message-ID: <6bbd55ed-90ab-4740-9585-66d9fdb291e8@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 17:02:47 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] target/riscv: require read permission for HLVX
 accesses
To: wangyang <wangyang25@otcaix.iscas.ac.cn>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
References: <20260908124755-v3-0-wangyang25@otcaix.iscas.ac.cn>
 <20260908124755-v3-3-wangyang25@otcaix.iscas.ac.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260908124755-v3-3-wangyang25@otcaix.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDIyNCBTYWx0ZWRfX/F2OjVPu2xqo
 DyE3v0Xf7pcdzxj14rXXjqmuPdBlebG+5ejjMCDHKfcq22/OpyjToSBjkQ24K6KUr9hvUht8K0z
 qUz1mUfbD7bJHUIiaAlC6cBvEHVrFT8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDIyNCBTYWx0ZWRfX7AEguMaZg0R3
 RxBAzytQH8T13cCYY5lhs7TcNUxlxOmMM8vFicsgbPqSmwiCLtnE7UtZFqei7rGghhhBzofMQyc
 X0FU0hUo8pWTzjta3LnbRUIlsn6jx25qojsd0gXDZfHFTAoHQVntKlzLNyXIfIgR8xlbYRjjNBC
 O4pS9TSsu8tgVxDWjuNzq1BKW/5GEs79fy2+17ez/hQla9I5bhE3qbFOr+byehl0hhEjoS6S+OL
 BHDH5fXyuMx4riyoQyof2m7SgCjOPjuPY9Qa8SmT6a9TSAtxlPLDAjtrcravaWOIiaz7+zEt6N5
 0J80zYwjsyW14tI1EKhzZew0x+zRtXZA7zludha49ZoGTMtAt778P2uKSlvBag/uD46nqfu3V4Y
 DrmGoaLq0ZkejQHOIUeMMsDk53QmJBC2IwnB4o0b5fzOJTF80E/LR8FOnzZeKBs8G/S97QlFIhe
 tHgckZ1Pj5+mgqxcJUQ==
X-Proofpoint-ORIG-GUID: 6CDXvxUcxUY6zTYUYCfP3WdjkuOrgy8n
X-Proofpoint-GUID: 6CDXvxUcxUY6zTYUYCfP3WdjkuOrgy8n
X-Authority-Analysis: v=2.4 cv=Z/F5j3RA c=1 sm=1 tr=0 ts=6aa1bb6d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=UUCCqBSPgqXJescDracA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-09_01,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609090224
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



On 9/8/2026 1:47 AM, wangyang wrote:
> HLVX address translation uses execute permission, but the final PMP
> check on the supervisor physical address must also require read
> permission. Carry the HLVX operation through the MMU index and include
> PMP_READ in the final check so execute-only pages fault.
> 
> Tested: RV32 system-mode RWX, HLV, and HLVX.WU PMP test cases.
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4414
> 
> Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

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


