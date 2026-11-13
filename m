Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F1F606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 05:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Sv+wwZ8q;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=a6DMwhRV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRjT6-0006pg-VR; Fri, 13 Nov 2026 00:04:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xRjT5-0006iy-5g
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 00:04:55 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xRjT3-0000pm-3d
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 00:04:54 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AD2K8Gb4120351
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 05:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 frHRU3FwaH6EJ6BUqaoiWvPeoYZn7jm7qlbycaLBIpg=; b=Sv+wwZ8qKZ6x57NG
 7aW0lIec4pzykEwFoSHUt7I1+HpZzmsWjdouk1kyTQA01zMwPs5AqDDLxIXzCmF0
 V/7foc8ZZMy+3EEh6Z3du7CtWfHWjAYMIsJhx6otDoQ5IQ5DHWcEN3zmTFXIhTff
 tEnWvRP8GEMuwM5SEFdNhvqYZ7vW9RQRKGXaLcPDgENgsGZrQxkq7VwsqrNf7bzW
 XYk0gbjFgpCQUq3KTilDv5q9ss1CFhjUdp37XNZ3mjdUD7r/m2G2duvNKJElaEQs
 Ps+Vpg7xrmpHUbxotnJdo8bqH3CZeWHLNsSsMJTJzI3ZYVDSs8GQotn73HlpyWs5
 cp513Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwbx33h33-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 05:04:49 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f3969a2a7so91785785a.2
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 21:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794546289; x=1795151089; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=frHRU3FwaH6EJ6BUqaoiWvPeoYZn7jm7qlbycaLBIpg=;
 b=a6DMwhRV+YhYkPtxNSlxcwx3xUaDXSRmv2ZXa0Y5oqeTsk7tpbyOwxW/cbH9fJ1l3J
 2dA46X5APRuXxTHvA8Hc0S043NkazflfLfddWh+u6f1uO0+eLNr3daQl8SMaYCWgxyQQ
 C1sfvfzTM8nQvE98atBPGisC4QW9ycdguqjwsg11Kl1vH4WAvnZ7HCPYvmRT/BOuBYgR
 3gYs59db9Rn6ufkS5xGxlqkkqpj/3ACrMudGu7uLOEXDy774dPQgX55Y1J2tTFfUmbTh
 L/0/K5+IigwbREkhYhqVXCxxmnIiFTgmowBKfcA7841O1kXo8dqHf2QzrTOgJpk0WcWB
 4hfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794546289; x=1795151089;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=frHRU3FwaH6EJ6BUqaoiWvPeoYZn7jm7qlbycaLBIpg=;
 b=RguFmgEO76TKhYnt1JLjhe90c5MqLC3gt3OglrjB8TtEkEf9eGhI5F9XYWrR5jD2fG
 iWRghSvo+ACPr66nreVBknXFaYSbDGJwtUrS/dYvkHjWJVLGP5Difa6jLHDVglG75X6E
 qFjJhK3r/zhcCy++BYUZmaX/8GzwkmTRLjLD3GsQYdssnWJQ0Nub3cB79zeMBg9f/+XH
 FIc9YTk1iPWZdsJojuHug/f8KFH9GVaQH4CWQ0eaIwtTnBkcv3wm3bbLmgY0UxGnGpTF
 PCVQWS2UyD8SgPP7Kiqqga7ty64MYYtYiHT5L0UAuLcPyAKjKeXb1PCo9r3gExPFYTtE
 l13g==
X-Forwarded-Encrypted: i=1;
 AL+hErEd+zQwfwzJRI1vIMYIwqidgjFB8/egpJA4v8hFC7Ca0eqEenccEqEVC86t+Q7N1Zdh9Nfmc6vp+QAB@nongnu.org
X-Gm-Message-State: APuU4Z8MycSpYOgUIatacHH1L13YT/7CWlDSDAI4M97kWq/yXV7/DNZc
 Kv3fdVpaWYTzTA0hCWPStJhoLIo7VLQsBe7UTnrU/MpM3k7uoh8BS0pQq4O5gVEWX0aUiJGdIJJ
 Y2wYLtHAlNXQgwTFUVtLmgEUn//ZIwiqgLC7NRBCLz6iCuLshLI8cDwjtYg==
X-Gm-Gg: AYBFou31LwtCcDwde2QNfCrU0+BAlXoCUnPR55heINawbbfejJtvaQwaWzxsmhabmXu
 sI6dz+hKw3FideLJ4AV7C7dhsavJbYYAENLGc3bqtIrZVSBooCmT5FQbpl9K4hQjBSirl41w/J0
 xjlXkR99U9wfz+l2E3uGw5nEhyMboHWd1Asne7aAdsKnTAve4r5uQ1Wx5KaUnv7cLY3K4gKIGJ/
 R71AYZ8yOCweAEzPsWqCaAnrxVURrS2j8UDLo03mYVtB1lgSmNOCv4o1AQMrWq9xWgEUN6do7iD
 MgIOtizcWLKsemXtP8mK0pA1cYDLXRzPjjBpY3q79Cf9/9DSZtShtsYx+IT9S1GnqbO/0pTtW2b
 haYA35DwX3h5zVsXDyJ/CAczvEnn/efXkS8rDLtzfz6hNUK7S2EE94LANXfobIQgchBEPtUayVU
 Ah
X-Received: by 2002:a05:620a:1a28:b0:93e:f930:5ed1 with SMTP id
 af79cd13be357-9494bcd7f68mr254802585a.82.1794546288561; 
 Thu, 12 Nov 2026 21:04:48 -0800 (PST)
X-Received: by 2002:a05:620a:1a28:b0:93e:f930:5ed1 with SMTP id
 af79cd13be357-9494bcd7f68mr254800285a.82.1794546287871; 
 Thu, 12 Nov 2026 21:04:47 -0800 (PST)
Received: from [172.31.27.103] ([69.196.88.181])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9494c8683desm102036485a.28.2026.11.12.21.04.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2026 21:04:46 -0800 (PST)
Message-ID: <75f67bc1-9e0a-4106-b850-60d5d054c190@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 23:04:43 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] target/hexagon: Forward return address to HLX
 load/store helpers
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, marco.liebel@oss.qualcomm.com
References: <20261112232032.396-1-anjo@rev.ng>
 <20261112232032.396-4-anjo@rev.ng>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261112232032.396-4-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=S+5MU4sP c=1 sm=1 tr=0 ts=6af69a71 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=cE0r1ZmtaMrRAdDjMn+EDw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=fLCaJPVeE6EzPI-FDqkA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAxOSBTYWx0ZWRfX8vCSp8AnV6bC
 i8BxnR05SCSnOHm8gWtfBGNlZANDmLlI1vkgr5ZkCvWxvsrfgn042ZURRwT67huOpH1jzAcYrK4
 8grqqEMmkASyDIb47jphH1+EQC/irpO3iXJq+6HcBtCAZJ+xIOnF682F6k5t68wD2TX+LJ4dn9p
 Uub77od9iVQSJlrSBZRFrbe7tfLliL3iUqq1veGsgCTwRVfumuYIE8zO/x2zlWb0hoc1ALPBS58
 j8XkV7KYq6itCUhl36trH+IkkrrxZhMp49ikv7dM9+AxZ7j92XFnNtSLtWUDdnobh+Nqhg33R5G
 d9olPE+l1GkWv6pvg5KCHBP42zu2mOyrmPm9x0t2bSVJinD/bg8KvBQHK7psteUdDXZLxqGoNIH
 jPheM5J2J/yCRN4Xb69HarzBWguijWW2jg8mjTNxTjhluTrVYEegcPQi8lixmzwwQPgPGAPY0y6
 AC5jNXdtbIb+mIPGR9A==
X-Proofpoint-ORIG-GUID: y4RAGMdkEX_AVNAVrsw89n6wjtv8K4Ut
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAxOSBTYWx0ZWRfX74w/0wVgtaqc
 hI8t7x7nMgL3MQapBzwf2rKsyIyJ5Y0PIUr8+itV9dxEHvcq0YO7vzJLNqdbFhgFvmSs+sUmJli
 ZooiZj5bnksLmZ0ULu3i7m539CskidU=
X-Proofpoint-GUID: y4RAGMdkEX_AVNAVrsw89n6wjtv8K4Ut
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130019
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/12/2026 5:20 PM, Anton Johansson wrote:
> Fixes: 2db29a3615a5ad2a3 ("target/hexagon: add HLX helper support")
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> ---
>   target/hexagon/hlx_helper.h | 19 +++++++++++++++++++
>   target/hexagon/macros.h     | 13 +++++++++----
>   target/hexagon/hlx_helper.c | 31 ++++++++++++++++++++++---------
>   3 files changed, 50 insertions(+), 13 deletions(-)
>   create mode 100644 target/hexagon/hlx_helper.h

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

> diff --git a/target/hexagon/hlx_helper.h b/target/hexagon/hlx_helper.h
> new file mode 100644
> index 0000000000..ab36cc1049
> --- /dev/null
> +++ b/target/hexagon/hlx_helper.h
> @@ -0,0 +1,19 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HEXAGON_HLX_HELPER_H
> +#define HEXAGON_HLX_HELPER_H
> +
> +#include "cpu.h"
> +
> +void hlx_load_vec_ra(CPUHexagonState *env, void *dst_void,
> +                     target_ulong ea, uint32_t above, uint32_t below,
> +                     uintptr_t ra);
> +
> +void hlx_store_vec_ra(CPUHexagonState *env, target_ulong ea,
> +                      void *src_void, uint32_t above, uint32_t below,
> +                      uintptr_t ra);
> +
> +#endif
> diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
> index 2748e26d6c..5799016ea4 100644
> --- a/target/hexagon/macros.h
> +++ b/target/hexagon/macros.h
> @@ -22,6 +22,7 @@
>   #include "hex_regs.h"
>   #include "reg_fields.h"
>   #include "accel/tcg/getpc.h"
> +#include "hlx_helper.h"
>   
>   #define GET_FIELD(FIELD, REGIN) \
>       fEXTRACTU_BITS(REGIN, reg_field_info[FIELD].width, \
> @@ -738,8 +739,10 @@ static inline TCGv gen_read_ireg(TCGv result, TCGv val, int shift)
>                               EA, tcg_constant_i32(ABOVE), \
>                               tcg_constant_i32(BELOW))
>   #else
> -#define fLOADMML(EA, DST, ABOVE, BELOW) \
> -    do { HELPER(hlx_load_vec)(env, &(DST), (EA), (ABOVE), (BELOW)); } while (0)
> +#define fLOADMML(EA, DST, ABOVE, BELOW)                                \
> +    do {                                                               \
> +        hlx_load_vec_ra(env, &(DST), (EA), (ABOVE), (BELOW), GETPC()); \
> +    } while (0)
>   #endif
>   
>   /* The helper logs the store for packet commit. */
> @@ -748,8 +751,10 @@ static inline TCGv gen_read_ireg(TCGv result, TCGv val, int shift)
>       gen_helper_hlx_store_vec(tcg_env, EA, tcg_constant_ptr((intptr_t)&(SRC)), \
>                                tcg_constant_i32(ABOVE), tcg_constant_i32(BELOW))
>   #else
> -#define fSTOREMML(EA, SRC, ABOVE, BELOW) \
> -    do { HELPER(hlx_store_vec)(env, (EA), &(SRC), (ABOVE), (BELOW)); } while (0)
> +#define fSTOREMML(EA, SRC, ABOVE, BELOW)                                \
> +    do {                                                                \
> +        hlx_store_vec_ra(env, (EA), &(SRC), (ABOVE), (BELOW), GETPC()); \
> +    } while (0)
>   #endif
>   
>   /* Helpers receive .new registers in future_LRegs. */
> diff --git a/target/hexagon/hlx_helper.c b/target/hexagon/hlx_helper.c
> index c063706cfa..bc638f6403 100644
> --- a/target/hexagon/hlx_helper.c
> +++ b/target/hexagon/hlx_helper.c
> @@ -7,6 +7,7 @@
>   #include "cpu.h"
>   #include "accel/tcg/cpu-ldst.h"
>   #include "exec/helper-proto.h"
> +#include "hlx_helper.h"
>   #include "hlx/hlx.h"
>   #include "hw/hexagon/hexagon_hlx.h"
>   #include "accel/tcg/probe.h"
> @@ -15,40 +16,52 @@
>   #define HLX_MEM_ALIGN_MASK (~(HLX_VEC_SIZE_BYTES - 1))
>   
>   /* Align down to 2KB. Above and below are unused in V85. */
> -void HELPER(hlx_load_vec)(CPUHexagonState *env, void *dst_void,
> -                          target_ulong ea, uint32_t above, uint32_t below)
> +void hlx_load_vec_ra(CPUHexagonState *env, void *dst_void,
> +                     target_ulong ea, uint32_t above, uint32_t below,
> +                     uintptr_t ra)
>   {
>       HLXVector *dst = (HLXVector *)dst_void;
>       target_ulong aligned_ea = ea & HLX_MEM_ALIGN_MASK;
> -    uintptr_t raddr = GETPC();
>       int mmu_idx = cpu_mmu_index(env_cpu(env), false);
>   
>       /* A 2KB-aligned access stays within one page. */
> -    void *host = probe_read(env, aligned_ea, HLX_VEC_SIZE_BYTES, mmu_idx,
> -                            raddr);
> +    void *host = probe_read(env, aligned_ea, HLX_VEC_SIZE_BYTES, mmu_idx, ra);
>   
>       if (host) {
>           memcpy(dst, host, HLX_VEC_SIZE_BYTES);
>       } else {
>           for (int i = 0; i < HLX_VEC_SIZE_BYTES; i += 8) {
> -            uint64_t val = cpu_ldq_le_data_ra(env, aligned_ea + i, raddr);
> +            uint64_t val = cpu_ldq_le_data_ra(env, aligned_ea + i, ra);
>               memcpy(&dst->ub[i], &val, 8);
>           }
>       }
>   }
>   
> -void HELPER(hlx_store_vec)(CPUHexagonState *env, target_ulong ea,
> -                           void *src_void, uint32_t above, uint32_t below)
> +void hlx_store_vec_ra(CPUHexagonState *env, target_ulong ea,
> +                      void *src_void, uint32_t above, uint32_t below,
> +                      uintptr_t ra)
>   {
>       target_ulong aligned_ea = ea & HLX_MEM_ALIGN_MASK;
>       int mmu_idx = cpu_mmu_index(env_cpu(env), false);
>   
> -    probe_write(env, aligned_ea, HLX_VEC_SIZE_BYTES, mmu_idx, GETPC());
> +    probe_write(env, aligned_ea, HLX_VEC_SIZE_BYTES, mmu_idx, ra);
>       memcpy(&env->hlx_store_data, src_void, sizeof(HLXVector));
>       env->hlx_store_va = aligned_ea;
>       env->hlx_store_pending = true;
>   }
>   
> +void HELPER(hlx_load_vec)(CPUHexagonState *env, void *dst_void,
> +                          target_ulong ea, uint32_t above, uint32_t below)
> +{
> +    hlx_load_vec_ra(env, dst_void, ea, above, below, GETPC());
> +}
> +
> +void HELPER(hlx_store_vec)(CPUHexagonState *env, target_ulong ea,
> +                           void *src_void, uint32_t above, uint32_t below)
> +{
> +    hlx_store_vec_ra(env, ea, src_void, above, below, GETPC());
> +}
> +
>   void HELPER(hlx_commit_store)(CPUHexagonState *env)
>   {
>       target_ulong va = env->hlx_store_va;

