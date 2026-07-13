Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B48EC44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 21:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjOfu-0001Im-Uq; Mon, 13 Jul 2026 17:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjOft-0001HZ-KG
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 17:58:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjOfr-0005I0-Mt
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 17:58:53 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DJ9CAp2448662
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 21:58:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AkJl7fz5LOS2F9PlUnlW0GdMmION3pT91KozmF/Qlac=; b=gXVpwlQ/jkcjeXfD
 QfZBRqtz7RThGReTW5DSwtlpzLdZT0tgiiGDasFll/nb5VXUkLkn0Ph0cllOdgKC
 I/gMibvQSacp/cs3A66DkPGgXHDM7sQK5qZkzZfo6YUKx/Ndb9BaFj3avTAjWjVj
 +lO6VQjqdsLjQAMe49K+ZU6l7rGSel/8DIYm2j8cKJnEDGoM6AhDXgASpI9dU0qz
 UCuklanoVDpo7JYfMIZIB1vHbsYGwQNsPm1B3x2aqaYMxKTkHBnnIAAy2PwHr0nU
 4Jg3QCxAeJuk5UJ+7tk8wkNuZ5bwIcV2O+RF9bOt0CQ5/hBcoTQP7jajyGqDveW4
 Rm9dAQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd37x96hf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 21:58:49 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c88fc985a65so4433930a12.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 14:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783979929; x=1784584729; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AkJl7fz5LOS2F9PlUnlW0GdMmION3pT91KozmF/Qlac=;
 b=SWfiFMEsuVSDu/jQqg0pY9Yok5WM65jmCRNw8ahE1Tg27T+0obE1TJ4CjE3u3eSUq5
 9EufnIRJ50NoDGgKtIqePODZR4kvJWoGjMDGFJ82OXL+sNrZfBobYfdkwAJ3dU+GJd1J
 sqvTET63cqwyZy6ERa4ovz3LKm3yBvHTWzqWzgTHJoin0y9QUvGXN48iLHvhQr7wMs7Q
 a8nFXSkZqqZQr5xziNPaMReGzWztjtrmEVPiWYdyi8jBgx+r9zRFExDN+JLwe6s7U9bz
 Jw7mGk3EGEHv0cJZYcHih0sOuYOF7cObSouE2Np+k1cpryxQcccSgsnf7woOeklwm3RX
 vfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783979929; x=1784584729;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AkJl7fz5LOS2F9PlUnlW0GdMmION3pT91KozmF/Qlac=;
 b=EQVzLPinK2OeUqSYbyNDa9TL2ANQQJO/pEzqsfoURFlVMOzGXfERNGk9eaV3fqSvbq
 RmtFNyrN+e7dFcKiQ4IACTSOulKxP92m3YwFBE53bIHn6phdLQO5Z7r5IVVUShPmGzjm
 wU/6AEaQsOynnjT+ukpsBPothivA9Jj2UflfCksO1BZRPGPcvBuEVvGFXWciHeEQIGR6
 iBxg+uksdsISmMXNgqJ/FVVnOSL2TUjW1xowOJNai0xYYgOlDA51VePLpRHUAqxvU8hj
 BB7ZNf1s7eoamw5AURrWjgtg760u7dxFX12wTm7+qgSzKjV372osF5dnpxxaNMm4EFcD
 bvQQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpQjfoGPyldZMl8Bdd8b3eI1hm2dktQ2cdCbJ1IJKAoh9UJZ4PB1+LeFsYPspT4AYg5LaEbWGiVrRmS@nongnu.org
X-Gm-Message-State: AOJu0YzAsE3x2lgYPTdeUbJsJYnC+x+uFuOL2rCQPt8z/D+Po69Xivzc
 YpEMe/GCJLLRkBMUTkkJ3v7mkPuXqPT5BD93wCUPF32PFEvUevHKp4pylhFkLaeMqWHqscKVNXz
 3KK3cYp9pd1UZDQFy/0rIjfOdyC+QolV4MkrTWniFiRzPVgh4AV3Ee23XHw==
X-Gm-Gg: AfdE7clseskPr4XV1QGHpEq3Td3xCYNQ1MYhdf+pzLco2FvtzwcBmWZd+jIrYOPyU5J
 DZcpah/W0tYyjt2jtig+7jCUckpi5hNPALfmNZHYNmlL6GHLVgflxGO2Q4fW3RBOyXqaC9vu706
 7UyJ/0lUN2w6QceqTGXPRJo8plJmTvKmXyzhmKKMZWD9c59dqwbxhcXVr4ITW8XrM59fvFmuLzg
 5SK3xAyQlf2NJeRMVbuS/ld4m7bHRWPG516EgJnpyu8Ce1U0AtERfpLNByymXDo9ntGaXwkt25J
 d4oo7eJJ3EtEW910i1WfMHud6badRz80wn+CyaRZiak6hFSKyOJWrCq0Ce85JfOqiS2HZlxwZ3o
 Iy+gp98I717cESzTrmzoY2RGXieqSe1iqw7Gs1qeM66jEjYDtOncyOYNzwwT3MetNh1U0GOmZlC
 idV9k=
X-Received: by 2002:a05:6a21:6d8a:b0:3b4:3ef0:9132 with SMTP id
 adf61e73a8af0-3c110009b1emr12210592637.11.1783979928950; 
 Mon, 13 Jul 2026 14:58:48 -0700 (PDT)
X-Received: by 2002:a05:6a21:6d8a:b0:3b4:3ef0:9132 with SMTP id
 adf61e73a8af0-3c110009b1emr12210564637.11.1783979928536; 
 Mon, 13 Jul 2026 14:58:48 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b987fc629sm28065017c88.0.2026.07.13.14.58.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 14:58:48 -0700 (PDT)
Message-ID: <c39fe476-7c99-4d0f-9c82-6951264ffb79@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 14:58:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] target/hexagon: add aux functions for guest mem
 load/store
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
References: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
 <9cdc7c7f27a70257276119e485a55674bf5f2551.1783973054.git.matheus.bernardino@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <9cdc7c7f27a70257276119e485a55674bf5f2551.1783973054.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIyNiBTYWx0ZWRfXxBxMm3g+c+3Y
 AktYLKdsMtWImHzWeQDSK44xzMe+bA4YUN4s9A3Pq45ha+Oj3srJGvVU/hNYrO8eVoyKw4UpFfJ
 Afod4vFJqNWa+MQM6/4P2wHg/hB3jqmk3Ul31kcUqxCS5yqk3/sa+0Xf7RrATYlvP2anOelxJe0
 sIiTZZVc2SVy6V1kzcxKebopLgUymEKht/SiE1DK6hY9FXVDLbfkbCcUJbkmS0Kf58+lDJib05J
 Ro3Qe7EVWmPFcIEqc0NVUvU1RfqNdXyQZXRob5zvLVjKBXBNKvIj96Y4Viu3lNI6l10R0PklvPj
 H688IkoXr72QJhrVwi3IFcq6YmZT1k4/FqJEpdWBw2F39cjc/Tid4WMMgQB+wzhehn6m/9BZO5U
 08GjsRT6EFiFScmx2yGof5JQwOMcBkIkkRT5gKys3iOWZsq6j3cxB8HeBUSWTHwiZ3GFvKR9FTk
 yH0cYqqVGG4bG+AiEPg==
X-Authority-Analysis: v=2.4 cv=BNWDalQG c=1 sm=1 tr=0 ts=6a555f99 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=8S7QujD0rX2GVkS5WLwA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: ha8xH_MdYQVdDs1YB6Qs_eOli-TClg3z
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIyNiBTYWx0ZWRfX6tA7ASrVgkk6
 PaltqjIXidWKipjGYYNzRwP2nvDEMKC1x4FG11ig4wq/II7+fphjzU2QrbWkNWLKst+UpFFfpcA
 3vGZszefRs0chUMxFCnV7ANbhdHQP68=
X-Proofpoint-GUID: ha8xH_MdYQVdDs1YB6Qs_eOli-TClg3z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130226
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 7/13/2026 1:07 PM, Matheus Tavares Bernardino wrote:
> From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> 
> Will be used for semihosting.
> 
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu_helper.h |   6 ++
>  target/hexagon/cpu_helper.c | 133 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 139 insertions(+)
> 
> diff --git a/target/hexagon/cpu_helper.h b/target/hexagon/cpu_helper.h
> index d1767503156..f6a31ecbab0 100644
> --- a/target/hexagon/cpu_helper.h
> +++ b/target/hexagon/cpu_helper.h
> @@ -7,6 +7,12 @@
>  #ifndef HEXAGON_CPU_HELPER_H
>  #define HEXAGON_CPU_HELPER_H
>  
> +void hexagon_read_memory(CPUHexagonState *env, target_ulong vaddr, int size,
> +                         void *retptr, uintptr_t retaddr);
> +void hexagon_write_memory(CPUHexagonState *env, target_ulong vaddr,
> +                          int size, uint64_t data, uintptr_t retaddr);
> +void hexagon_touch_memory(CPUHexagonState *env, uint32_t start_addr,
> +                          uint32_t length, uintptr_t retaddr);
>  uint32_t hexagon_get_pmu_counter(CPUHexagonState *cur_env, int index);
>  void hexagon_modify_ssr(CPUHexagonState *env, uint32_t new, uint32_t old);
>  int get_cpu_mode(CPUHexagonState *env);
> diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
> index 64c5746c6d9..1ab2564e3dc 100644
> --- a/target/hexagon/cpu_helper.c
> +++ b/target/hexagon/cpu_helper.c
> @@ -25,6 +25,139 @@
>  #include "sys_macros.h"
>  #include "arch.h"
>  
> +#ifndef CONFIG_USER_ONLY
> +
> +static bool hexagon_read_memory_small(CPUHexagonState *env, target_ulong addr,
> +                                      int byte_count, unsigned char *dstbuf,
> +                                      int mmu_idx, uintptr_t retaddr)
> + {
> +    /* handle small sizes */
> +    switch (byte_count) {
> +    case 1:
> +        *dstbuf = cpu_ldub_mmuidx_ra(env, addr, mmu_idx, retaddr);
> +        return true;
> +
> +    case 2:
> +        if (QEMU_IS_ALIGNED(addr, 2)) {
> +            *(unsigned short *)dstbuf =
> +                cpu_lduw_le_mmuidx_ra(env, addr, mmu_idx, retaddr);
> +            return true;
> +        }
> +        break;
> +
> +    case 4:
> +        if (QEMU_IS_ALIGNED(addr, 4)) {
> +            *(uint32_t *)dstbuf =
> +                cpu_ldl_le_mmuidx_ra(env, addr, mmu_idx, retaddr);
> +            return true;
> +        }
> +        break;
> +
> +    case 8:
> +        if (QEMU_IS_ALIGNED(addr, 8)) {
> +            *(uint64_t *)dstbuf =
> +                cpu_ldq_le_mmuidx_ra(env, addr, mmu_idx, retaddr);
> +            return true;
> +        }
> +        break;
> +
> +    default:
> +        /* larger request, handle elsewhere */
> +        return false;
> +    }
> +
> +    /* not aligned, copy bytes */
> +    for (int i = 0; i < byte_count; ++i) {
> +        *dstbuf++ = cpu_ldub_mmuidx_ra(env, addr++, mmu_idx, retaddr);
> +    }
> +    return true;
> +}
> +
> +void hexagon_read_memory(CPUHexagonState *env, target_ulong vaddr, int size,
> +                         void *retptr, uintptr_t retaddr)
> +{
> +    BQL_LOCK_GUARD();
> +    CPUState *cs = env_cpu(env);
> +    unsigned mmu_idx = cpu_mmu_index(cs, false);
> +    if (!hexagon_read_memory_small(env, vaddr, size, retptr, mmu_idx,
> +                                   retaddr)) {
> +        cpu_abort(cs, "%s: ERROR: bad size = %d!\n", __func__, size);
> +    }
> +}
> +
> +static bool hexagon_write_memory_small(CPUHexagonState *env, target_ulong addr,
> +                                       int byte_count, unsigned char *srcbuf,
> +                                       int mmu_idx, uintptr_t retaddr)
> +{
> +    /* handle small sizes */
> +    switch (byte_count) {
> +    case 1:
> +        cpu_stb_mmuidx_ra(env, addr, *srcbuf, mmu_idx, retaddr);
> +        return true;
> +
> +    case 2:
> +        if (QEMU_IS_ALIGNED(addr, 2)) {
> +            cpu_stw_le_mmuidx_ra(env, addr, *(uint16_t *)srcbuf, mmu_idx, retaddr);
> +            return true;
> +        }
> +        break;
> +
> +    case 4:
> +        if (QEMU_IS_ALIGNED(addr, 4)) {
> +            cpu_stl_le_mmuidx_ra(env, addr, *(uint32_t *)srcbuf, mmu_idx, retaddr);
> +            return true;
> +        }
> +        break;
> +
> +    case 8:
> +        if (QEMU_IS_ALIGNED(addr, 8)) {
> +            cpu_stq_le_mmuidx_ra(env, addr, *(uint64_t *)srcbuf, mmu_idx, retaddr);
> +            return true;
> +        }
> +        break;
> +
> +    default:
> +        /* larger request, handle elsewhere */
> +        return false;
> +    }
> +
> +    /* not aligned, copy bytes */
> +    for (int i = 0; i < byte_count; ++i) {
> +        cpu_stb_mmuidx_ra(env, addr++, *srcbuf++, mmu_idx, retaddr);
> +    }
> +
> +    return true;
> +}
> +
> +void hexagon_write_memory(CPUHexagonState *env, target_ulong vaddr,
> +                          int size, uint64_t data, uintptr_t retaddr)
> +{
> +    CPUState *cs = env_cpu(env);
> +    unsigned mmu_idx = cpu_mmu_index(cs, false);
> +    if (!hexagon_write_memory_small(env, vaddr, size, (unsigned char *)&data,
> +                                   mmu_idx, retaddr)) {
> +        cpu_abort(cs, "%s: ERROR: bad size = %d!\n", __func__, size);
> +    }
> +}
> +
> +static inline uint32_t page_start(uint32_t addr)
> +{
> +    uint32_t page_align = ~(TARGET_PAGE_SIZE - 1);
> +    return addr & page_align;
> +}
> +
> +void hexagon_touch_memory(CPUHexagonState *env, uint32_t start_addr,
> +                          uint32_t length, uintptr_t retaddr)
> +{
> +    unsigned int warm;
> +    uint32_t first = page_start(start_addr);
> +    uint32_t last = page_start(start_addr + length - 1);
> +    for (uint32_t page = first; page <= last; page += TARGET_PAGE_SIZE) {
> +        hexagon_read_memory(env, page, 1, &warm, retaddr);
> +    }
> +}
> +

Name could be misleading, I would be expectng to see a read/write
sequence in each page instead of just reading.
Maybe hexagon_peek_memory_range?

> +#endif
>  
>  uint32_t hexagon_get_pmu_counter(CPUHexagonState *cur_env, int index)
>  {

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

