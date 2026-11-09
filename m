Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CCA606A330
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=k3THRoUk;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EAmWyjWN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQY8A-0004lB-0s; Mon, 09 Nov 2026 17:46:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQY87-0004js-4t
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:46:23 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQY85-0005EN-KG
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:46:22 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9LAPjp1401226
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 22:46:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DyXmRHs/pNpQYG4ZmyvHi0z6r83M9ad6cBl/UkIbd8c=; b=k3THRoUkYov8AY1O
 vbXpvr5Au3Zb/hInntXjL9MCN3iGw8exjJZk21T1qPc2Ht7ZGs4sEJMt3soFXgKY
 J+sen4+hHcTGkvBoy4eFOCf78w+MMNgYy3xXv6CNp2gebbcJTnAQNiOz2sVtMmh6
 AxD27e6IF1FEWC+e7xsr314oO2tOkA6t1DBvWeB+KJ3SI+KDHGCAHHjREt8elgW1
 J3DPBRHYFfOSRG/JsbZ77AMwIdmXHEicInlDaw/lQf+X58KtZTzmDNlxg6Y1COj7
 ejmR8psdApgvKC/1yFQZsQSwh9HvUjjmUXPfeF9X1DPqUUlWs3pnYCkTKZ70A+A9
 8FlMow==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hu6x2kv3t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 22:46:19 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5ec62c05c25so1267851e0c.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 14:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794264379; x=1794869179; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DyXmRHs/pNpQYG4ZmyvHi0z6r83M9ad6cBl/UkIbd8c=;
 b=EAmWyjWNuY8OJaV5aW7pCV0R/5bnO9Uhx3NXG2CXetXaIJOVpek8a0QPsQ9iDLPR2Z
 c0dsv/HwHByWha9CX8kO459PW2fKl8myK9RIgsY0CUf8mk5pbktG5/lDqqfNmPKJQ6zr
 VHkUiBK4dXCeX72sNhzhig1u6KNtjADGt/ndn701rEf10zMCuYUvpghz4/Ny9q7G0knB
 zhfwumyNxOjQP5bgv8pmD45jLm4t3JUPhI6n+vug+DwqfSaI5GVTZp5PPWcMlvopY79x
 Zol9tnPq4bLSdIzJkMksPTna8bhWkqILIIFChjZOgzk0K/D4Vx9amqsyUks58J+6D451
 Cudg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794264379; x=1794869179;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DyXmRHs/pNpQYG4ZmyvHi0z6r83M9ad6cBl/UkIbd8c=;
 b=MB5C37SqKaFHAURBk4ohU2h773KEmtuINWLYqgYAR1eZm3s4q0JvjGlgZdUxAGS4lL
 cxSILQNaOVk8e8WJsSOE02yjb+rdANvA/3cQo6TNaioSl7fPGkc3w8/Fq1MbvUDZj7Ft
 bBvlM4np8jaUE7axK2es+7vDyOKnVyslvOlmgpsFq0/RR5wvKtYuJ6I/nD6gHFh5CATl
 /PBjnHN/y1Q+NZcGiM3iUUc4Rt2mcDmtCRJa2h43t+w4ObJtmBFXTWDQ+jcKzESsNtS8
 sr43Twr6If4cQvg8Nn4dfAivx+GJ3yuucHeioi82gLfVORYEsUA41oZM6n+8m7R6EXig
 +y8w==
X-Forwarded-Encrypted: i=1;
 AL+hErHFHAaPy/Hdk5/1gGcMN44slitsK+L2Ky6K1p4To7Su8pc+eVe2UWPAsnTRA/W2Zt5DNQDuoHwngzgp@nongnu.org
X-Gm-Message-State: APuU4Z9J751bU0zITvje9SXUK+RB+pIYKtRWJGQQ6qK5H3qM9CAsAJky
 37GwEGnRPFcCHtOuO0KwhZT1uSJLRlrzpt9Pao8dHRW2nBynQKr2UozllejzjPJDBJ8bBLBLyOq
 J+QWwflD83R7RjD6qW7ZhrfeMciIUbLJBjvw5jGlVbRw32NrTT/vE/NoIQw==
X-Gm-Gg: AYBFou0I6qVSm5Mw+bYYCE7boqMZyExWBbLr/gzXW0PtjBULmI+3KN+Qe/e5UgQ7fkg
 sw3NpR+G52dmYRuLeSgYmwwsGA/j5f7VWSYrP5mRP9smhVM9l6CZAQVAUcqU8l00Hz5VkmG5avM
 IjD0ge7R2DZlWeXupedYhkVUBeKaS0t9USmPYKi8aFE2aO5MHknZc9n+QukmmAR9B8Kb3o3CoJb
 69o+Z3KH6RIAHKpTeX8DHbgnxfhjLrR7E1k/iC21AwOWzFCyWrKq067lVhlNu4ZJAdwdK9zlBA9
 wX98Mz7auPUQE/uT5Ah9VbQ/reENUGK2ch0gAm14FFiUuq0dPU9Yeo2/iEcBXNnULspHTfdJCyI
 /EQzYQnEMRURhO67UvP6MoktUAmrlD5nZ6O1Qt5sAh6tQhnjXnm9AztteQqw2mf3Wfte2griTEW
 nCmc2syg==
X-Received: by 2002:a05:6102:38ca:b0:7d2:e54d:ef69 with SMTP id
 ada2fe7eead31-7d30122c706mr263990137.44.1794264379203; 
 Mon, 09 Nov 2026 14:46:19 -0800 (PST)
X-Received: by 2002:a05:6102:38ca:b0:7d2:e54d:ef69 with SMTP id
 ada2fe7eead31-7d30122c706mr263979137.44.1794264378658; 
 Mon, 09 Nov 2026 14:46:18 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4983284c9a6sm1441942f8f.2.2026.11.09.14.46.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 14:46:17 -0800 (PST)
Message-ID: <a9da56ea-3901-4f0e-95d5-151e2f9eb0bb@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 23:46:16 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/26] target/mips: drop hidden TLB shadowing for tlbwr
Content-Language: en-US
To: "Kirill A. Korinsky" <kirill@korins.ky>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20261101142723.41346-1-kirill@korins.ky>
 <20261101142723.41346-4-kirill@korins.ky>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261101142723.41346-4-kirill@korins.ky>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TMjQ2Fla c=1 sm=1 tr=0 ts=6af24d3b cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=ZkKvDDlCTDZ5-YK6cwwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA5MCBTYWx0ZWRfX+HvQNdc1+cTj
 /YK8njqB2//JolKgdpg7ClVvTZzCfqqs6Fms0rm15Suo2DJ4u3NnQ1oDrntQs4f+pjKVDoTRg4l
 SpUHz1dloqWVVfEB6eGmOGaHZe0Ed/1niLDKryZAndbd/FLopcCcrxDu3hplNc5j0ne1tjIq2Bw
 9Xuzz4NU/LAylQ341KJ1aa1zIv8WluSIl7cRMogfEKjgZE+SYrHfV7kxtjydr+QQA3YNVAubzca
 bXCxNurW28riXrn/pTJ21gSH0alh0X7yM0jhzI25+9ZXf3P/lcjprIIYmSav7A3Csrb/54U/t2+
 QAD+fmVzMPG1Xvqtai8qnZfhz8vc4pe3xW8I5J2x6InjmyTXIo94y6wKtLVTZgePFj5iN0/bQ1r
 Ozv+hp1GTmZ7qfMkG9FVMqEFLRhhF1R5gtVPUEhmkB13ARuf7t77tVNN5kH4R2kLhxYtBMPm/iX
 Wat7LvVUg+P9TGveJvA==
X-Proofpoint-GUID: u-EUEVfIUs_63uo_g9b-q2BNbA_RKsLl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA5MCBTYWx0ZWRfX5F3P7IohBtn1
 U7npbWYy8pogFOaEkKnSYB6fkXt85LeSLEHLhs1Uc/SqRitwPP4IrS/io423Ew0CBu1OBc65tdr
 xfMaBtAUAZuZnL4ZJgkKWG+Dzj0761E=
X-Proofpoint-ORIG-GUID: u-EUEVfIUs_63uo_g9b-q2BNbA_RKsLl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090090
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

+Richard/Peter

On 1/11/26 15:23, Kirill A. Korinsky wrote:
> tlbwr replaces a random architectural TLB entry. Once that happens, the
> evicted entry must stop translating guest virtual addresses.
> 
> The current helper keeps the evicted entry in QEMU-only extra TLB state.
> That makes the old mapping survive until some later operation discards
> the extra entries. A guest can observe this directly by writing through
> a TLB mapping, replacing that entry with tlbwr, and writing through the
> old virtual address again.
> 
> Invalidate the replaced entry instead of shadowing it. This keeps the
> translated TLB state aligned with the architectural TLB contents.
> 
> Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
> ---
>   target/mips/tcg/system/tlb_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
> index 9e01c07609..08b978b3f5 100644
> --- a/target/mips/tcg/system/tlb_helper.c
> +++ b/target/mips/tcg/system/tlb_helper.c
> @@ -165,7 +165,7 @@ static void r4k_helper_tlbwr(CPUMIPSState *env)
>   {
>       int r = cpu_mips_get_random(env);
>   
> -    r4k_invalidate_tlb(env, r, 1);
> +    r4k_invalidate_tlb(env, r, 0);
>       r4k_fill_tlb(env, r);
>   }
>   

IIUC target-level shadow became redundant with commit 88e89a57f985
("implementing victim TLB for QEMU system emulated TLB", 2014) and
later 68fea0385530 ("accel/tcg: Avoid caching overwritten tlb
entries", 2018). We can thus remove 814b9a47490c ("MIPS TLB
performance improvements", 2006) as no longer necessary.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Peter, Richard, extra eyes welcomed :)

