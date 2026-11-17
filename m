Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF6C606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hKsGcZjx;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=H77FEjYL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTONq-0004Ik-BG; Tue, 17 Nov 2026 13:58:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xTONo-0004GY-Vj
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:58:21 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xTONn-0006M2-8S
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:58:20 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHGJxv0617424
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:58:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1WQFCudrH7JosyJ1lJCPxb8aLmtAI+8b/EayuBQmPpk=; b=hKsGcZjxAL2a1diy
 JLYts9PElfIFip+a/TH2FLO3twKp0HpZ/iA8PDGoA0bY33VYVF9+v1QUyGZJOBeG
 l+J+8Au2KW+ec3JbMBf1M9sO420wv4Xx8awB71W6MYOJBJUMiDuWzT1aRJhVQUpG
 aKoQFhmfnWIehtMBsvQJtkW7D9D4CoRiNLEmjCV8ju/+8fp3hgqc+wxLPWl8x2L6
 +SedR1+autx13bFwLRQYxHEEdax0eWvuQ4O5ZVdd+hqCO0Is2eH534ZR9IvUbgam
 U59C3SiBKZXRfrScC8xALpfemXUT5p1aOX/ZYWPmFoasKK2ol9IkYn1dIWVSQ4Rc
 fiqxBw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0tbu8r67-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:58:17 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-948d83322f6so34727085a.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 10:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794941896; x=1795546696; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1WQFCudrH7JosyJ1lJCPxb8aLmtAI+8b/EayuBQmPpk=;
 b=H77FEjYLb+j9ZGwhsQd2UBSs8gnVgbOFa16qvmL9YM3QVamLsBDYDwNer7+Zz9nWyW
 FeIXdvaP0VPhOF2BtSyOZ+xSiabopEx3Al5KIm2MXxWkkw4AjbtVwPPs98H7kV8qiRc7
 Z88HUYHDk7hFaCgwPY7vVYzhdTr9QpBNDxcwrnn6ybiUbuSrT9uUKlbtYYSrdaSw7c5f
 YZLEZP+wP7IIMzMqy0Y/fmCk8s4G4Wlg6Y4u7qcV83LNIGmQD/YJIDm3MfxlfHkwJaiU
 X7lgOVEshHDRHysNX5yrRbz1T/MXBz6AXx4TirKa3a/82z68rxDEyn5c7eG44J8JjIwZ
 tmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794941896; x=1795546696;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1WQFCudrH7JosyJ1lJCPxb8aLmtAI+8b/EayuBQmPpk=;
 b=YnyXqZbWT41R5+wTqkGBs2L4DikOKda0LzgGYqEZC4O7y9vWGRAvxTaBmJi4ChKJAT
 Q1bhzQwBlqjGfZWiB2V19bf20rzzC35SLyk2yM1F1TRQJvhzpJgnu7w2kWGHHl2RGcGy
 of3TgvWjMeE3BKE1acJu5TfBapwJWLHE1Jh5KfzrXZtWm4DJIe9VlKqSN6JkGaKOqfH5
 rRkwGp0FNmljrqiXayW09jAAS5qoT7s1uLpSHH+zBCB4DdyttP+R0lDV349lABUOikhf
 yAkK0fXQTeSDXUrrjuAPEYGgaTl29+wyauYV3BQOYm7H6dnnfmtKmwBUbjhJy+FmUg1s
 1Z5g==
X-Forwarded-Encrypted: i=1;
 AL+hErFvS9yKwgB3H4JDwwoizmmdoSkCyxnq74ShJd1A3bVXV+lOwBFg1UHXS5jlcBGEOOFJSVT8qJ1WNB6U@nongnu.org
X-Gm-Message-State: APuU4Z8fHJPxmbiAGM1u2RS0M6pHd7E1y17eom3JjnAgNXM5FryrIe/D
 BhhwIXNIM4X2Iga1GBq9PGRoj1DVIF+2t+vpQ5M4fmIo8xO9BgR5r2YZvyCSaunNGQOo0kDU33i
 1Xh5GbHgNzr1QZ1xusaS2rGXN5aZJbA/fIZTVe40tuH/zM1xf0zVXvX3Dl39fNGaQAw==
X-Gm-Gg: AYBFou0YwXE9b5TcLaArNmCAOXRPrYnzJZ5eSQFkwA28+2Qq9rNBsl6RSpjFZrbLYYb
 ACn2E05WKKDH0JxicsOjaFhRsMI4PCqCihgKfVSaJOgh3WDM2/SJMvrNkR5NWDi9w3+dGgT3LH5
 5sVG96n+1Q4Q0xJmmKmS1GBZRPT7ufndKNOWhpPUcVhhj202RzaQSnnecKscSl0qR4bgl3ruEfe
 qPGaPsMdgyRqxdiaN0iAN4azUm+hrddCwkzpDIzjcaFOOEsLdOPpoU+Xh7XeUV/rPuQXZvP6uAW
 M5VGMMPO7KZRbNtzkCr1iQTyrIw2gPehVnJU2QhavT8uL6jPFnFKN48uVo1ehdlwd/w94ebYtad
 hIEm09RnCjwhXJlqRvSqG5P8EALibFoZdpgdsoW+Wo9hEDxMp2iMD+NyneqXyFI2aBeNVnrx/bT
 /StaMKTEk4E8ZcKsP3FYELfiZ3BtVNVZyninCmbw==
X-Received: by 2002:a05:620a:6605:b0:93f:17e6:6ee2 with SMTP id
 af79cd13be357-94999557e0bmr100722685a.6.1794941896516; 
 Tue, 17 Nov 2026 10:58:16 -0800 (PST)
X-Received: by 2002:a05:620a:6605:b0:93f:17e6:6ee2 with SMTP id
 af79cd13be357-94999557e0bmr100720185a.6.1794941896029; 
 Tue, 17 Nov 2026 10:58:16 -0800 (PST)
Received: from [10.222.168.147] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9494c870f31sm1164606785a.27.2026.11.17.10.58.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 10:58:15 -0800 (PST)
Message-ID: <96ffb25f-5684-4ad4-86aa-5079bde85e48@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 12:58:14 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] target/hexagon: check packet alignment before TLB
 probes
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261117183629.2002840-1-marco.liebel@oss.qualcomm.com>
 <20261117183629.2002840-13-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261117183629.2002840-13-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3NSBTYWx0ZWRfX3x2E+vRWUeX5
 g7J5LRCbF82vpVaz6lHpZgzMLOaogUtUhObu+2ibYPCsL0Lfq7SqTEoO9lmDtBhcbsRCqxFO86e
 vjNahc89TESmwqWe1ZzsqqfhShTibzV6IyEIaFHT1h4qwvM8hfHr7pNrBhixCT9maNssgx2JMNo
 P01+WivD66jM0/FrgpK156lhoHHsKfApnF6PEBl2x8C++Po7MUfo+D0x14tSvN4JbEXuwmFf7DF
 nzWqkHe36q61R+mHm+E1walsVk22lgZiWfPYBDzwRSCXSnDwWKULiqgXukYQyoT1iC1ZUwQwR8A
 NFziugOVWThbIpIbS7UkNpRW9qnrUB15/oqZS/S9qcZ0BTXpKJU0vqJsrvh/hXD7+Cu7Du0dE8T
 aLVGu8NpaJ53s3BvSzYsH018q4qVILDiuHOJDOkbWknwMCMxbc3S8gnCvmlMgGuruk2Y2nu0sM3
 KKMoBQv41hdDEsgvcgQ==
X-Proofpoint-GUID: X7X6Gh_yQgYXG0fXAfWpoSXCWWQNzRbk
X-Authority-Analysis: v=2.4 cv=FeOiV5+6 c=1 sm=1 tr=0 ts=6afca3c9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=7u_qiBwI6BVxAjpLk_wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: X7X6Gh_yQgYXG0fXAfWpoSXCWWQNzRbk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3NSBTYWx0ZWRfX9cMbbhYSD/DO
 0CUCt8sYuuF9S1NobtF3cWlBXKxDEOr9eU6RCSr0kjuGDhdRzh6GUoQGVuTozX1etobCCbParlQ
 smfiVYQlLT5tNoor4MlKWfug0rSV6sM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170075
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


On 11/17/2026 12:36 PM, Marco Liebel wrote:
> Check active scalar addresses for alignment before translating either
> slot. An alignment error must not trigger a recoverable TLB miss first.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> ---
>   target/hexagon/cpu.c       | 12 ++++++++++++
>   target/hexagon/cpu.h       |  6 ++++++
>   target/hexagon/op_helper.c | 10 ++++++++++
>   3 files changed, 28 insertions(+)
>
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 77fd8156ed..bc8e51ee61 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -833,6 +833,18 @@ static void raise_misaligned_exception(CPUState *cs, uint32_t VA, int slot,
>       env->cause_code = excp;
>   }
>   
> +void hexagon_check_alignment(CPUHexagonState *env, uint32_t va,
> +                             unsigned size, int slot,
> +                             MMUAccessType access_type, uintptr_t retaddr)
> +{
> +    if (va & (size - 1)) {
> +        CPUState *cs = env_cpu(env);
> +        raise_misaligned_exception(cs, va, slot, access_type);
> +        do_raise_exception(env, cs->exception_index, env->gpr[HEX_REG_PC],
> +                           retaddr);
> +    }
> +}
> +
>   static const char *access_type_names[] = { "MMU_DATA_LOAD ", "MMU_DATA_STORE",
>                                              "MMU_INST_FETCH" };
>   
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> index 092462cb6c..e7ecbb1d59 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -233,6 +233,12 @@ typedef struct CPUArchState {
>       HmxState *hmx_state;
>   } CPUHexagonState;
>   
> +#ifndef CONFIG_USER_ONLY
> +void hexagon_check_alignment(CPUHexagonState *env, uint32_t va,
> +                             unsigned size, int slot,
> +                             MMUAccessType access_type, uintptr_t retaddr);
> +#endif
> +
>   typedef struct HexagonCPUClass {
>       CPUClass parent_class;
>   
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 0814a32fa3..7afd13c996 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -70,6 +70,15 @@ void HELPER(probe_packet_mem)(CPUHexagonState *env, uint32_t mmu_idx)
>   {
>       uintptr_t ra = GETPC();
>   
> +    /* Alignment errors have priority over address translation faults. */
> +    for (int slot = 1; slot >= 0; slot--) {
> +        if (env->mem_access_valid & (1U << slot)) {
> +            hexagon_check_alignment(env, env->mem_access_va[slot],
> +                                    env->mem_access_size[slot], slot,
> +                                    env->mem_access_store[slot] ?
> +                                    MMU_DATA_STORE : MMU_DATA_LOAD, ra);
> +        }
> +    }

... and related to the prior patch -- there's already MO_ALIGN which 
should be able to do the heavy lifting here.

If exception precedence is the problem maybe we can move the cost of 
solving this correctness problem to the backend where exceptions get 
raised?  That would mean that we could save ourselves the significant 
expense here with all loads/stores to just the cases where they're 
unaligned.


>       for (int slot = 1; slot >= 0; slot--) {
>           if (env->mem_access_valid & (1U << slot)) {
>               env->mem_slot = slot;
> @@ -507,6 +516,7 @@ void HELPER(probe_noshuf_load)(CPUHexagonState *env, target_ulong va,
>       uintptr_t retaddr = GETPC();
>   #ifndef CONFIG_USER_ONLY
>       env->mem_slot = 0;
> +    hexagon_check_alignment(env, va, size, 0, MMU_DATA_LOAD, retaddr);
>   #endif
>       probe_read(env, va, size, mmu_idx, retaddr);
>   }

