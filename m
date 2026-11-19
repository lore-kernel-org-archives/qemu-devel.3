Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D2F60A2603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 09:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MgsLF4RM;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Viq3mCiy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTyIc-0007jA-TZ; Thu, 19 Nov 2026 04:19:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xTyIX-0007gd-Ge
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 04:19:20 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xTyIV-0004Jl-KB
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 04:19:17 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ9IMrb2514136
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 09:19:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fBDNo8cXj7oEknc0sznogZyqv2uUJOAo2E/f3zgy/P0=; b=MgsLF4RMDWnxVJx3
 Wpaj216Gu64/cnCjFWSGp+HgFHUSDfBGEbbYsi9liSEgwGE+edLe3CYOX1fE1+BX
 ID5ZNltmCscIrAVgzTDlE0okei060okWqiRKrT4Td7vu7VSICCWlA05UqapXPRE4
 zrWmoADP6Q+6GfLVyGTY9rS4+nm5AoVYGhrTaSobYYt1SyARJNdMXXYt1XAJHOxj
 JPd0YDlcQg9QMbRgeX4wycF4+lKAxKNdTG337+CKAP6VK5tGF1HVmGbVaAlFsvQZ
 +yfCidSUJ7fK51H9265fblfsIV4TcHZKrxkCHyu/ZRhwOA8R3m7I28jvdIBPHd1q
 OZsq7Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1xc6r06x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 09:19:12 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f6f4fe531so328593385a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 01:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795079952; x=1795684752; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fBDNo8cXj7oEknc0sznogZyqv2uUJOAo2E/f3zgy/P0=;
 b=Viq3mCiyscaKntDMZhDJUvKtH/0cqgrwGxZAGvnmEvKI53UwX5WYEwse218Uu9A7oa
 BOaTZCyQiqmYj/nUdgm3ymB5fvFD1ZZeobHQNDjHmFBrjhsA5+N3pmsiS/OWJI5o80TM
 ih3R7KtyQBay2kwnQSKb40E8WQgCRv1q+fKaQmLWn25bTkrXG1mO0tpwSFh4R2ATjWna
 vovt9/7uWUUIZY/tJ2Jo3Ks+b62rkNog4utUMv24XkrPNEnezwJ0mFAqScmox6MyZR8x
 qO/PxJsaNMRPZZYwtfvi8kglXvQYfjhjtBxscjlFXczCA+m2KMJ9wzin4HGAh965v+V9
 mjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795079952; x=1795684752;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fBDNo8cXj7oEknc0sznogZyqv2uUJOAo2E/f3zgy/P0=;
 b=ENRm6cJhWeBajrM809YVG8vq1QCHAvALWNtkZdu85ht0gUMfOQvbM+S1mW/wQhH1s1
 SWuBYFN4Q7bGI0UoxRtjs0lDv62pZuYUPkympB3Wj73iaJZZOjIUnnIdOL41NTMZGXbR
 he8hDuyY4adviepW9h8NEzV5TNFxjqhtQtEkJyQLPXMBBaMu29bCno+BBo2e0RirJfhB
 IYfC0qeOzkNB14kQx0Ysfhbu26FbMF+n6/3bUOpk2d3Hx0cX9YcaaVBxTEfHW4L0poZk
 4BhOp6dZmzqY2cYvJkHAcY3rGEJpxl89IIN8kMIDczQ8zzdyG/mv6KBZbgOjvkhc9u3l
 Sqpw==
X-Forwarded-Encrypted: i=1;
 AL+hErFP2A2iBjT30uPHBWhypihMd0WQVPM3nbxNuW8Rh4ZGTwnaCHL9Ml4MxjcWE/IuFkbuunLoHxedVp4f@nongnu.org
X-Gm-Message-State: APuU4Z9vqflO9T4fm6YqWoWCdH4bgD3E2eAKWvreFmDYYrirT9Rr5xnH
 j51YVnCuiz2DqQ0imyfewG1vvqYQY0xX5R76m7m6zdBpcRF69cZBpHXbUOV/MH+mMpZzdN7HsJj
 coRQKjBqZG9qXc06r9qzeC7LoarD2cfu2dv4/DFsxt5J9PjvhJrJE6kn3wA==
X-Gm-Gg: AYBFou2iLmGWZR+WcpY8zP+WAVcIHHanEK7xvE+m/e9rty9jUIZgO711Dp/zop5ayFs
 HqmvRBl/t+FBpA6yjwVzsRNwt42koZZml6+QpgXp+RPMX9yUG99X0iy3zjqqDpJVrARJO5JqyPe
 qJM+b+4b2rl/sTAtyTk63hC6dl4oyxpvnzGKR8Tj9UVGZRv05qJ55wvnjUz7OuWQlmQpBrIiFVu
 pz2tSRjWuFE7XKS+qkSS4KamdD3KiShWW3mFMXuonEZ4HjQGK8N/HdW8ExOxL0nueegExYvWlyg
 v6LLhm3BpBhHg/RttF7mXnRH83/IUUULNaIojqWiiLF7VfL26G4TnTIEkvhHquVWukqWvuJtH43
 DhGtg/AZO+Hy0jDHih2HftsKXobBzoD2fSOzyuI1Yn7sRRM8Fj/6nPJ9azQuw3btKt5O9Bad/Q5
 f3VxUaFBM=
X-Received: by 2002:a05:620a:700d:b0:945:f6b0:db0 with SMTP id
 af79cd13be357-9499970fadbmr897889485a.30.1795079951738; 
 Thu, 19 Nov 2026 01:19:11 -0800 (PST)
X-Received: by 2002:a05:620a:700d:b0:945:f6b0:db0 with SMTP id
 af79cd13be357-9499970fadbmr897887085a.30.1795079951294; 
 Thu, 19 Nov 2026 01:19:11 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8535741esm36464275e9.11.2026.11.19.01.19.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 01:19:10 -0800 (PST)
Message-ID: <b985f864-3816-46f4-b5c2-7972351e5cde@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 10:19:09 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-11.2] accel/tcg: Fix jump cache flush after large
 page flush
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20261118164019.258874-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261118164019.258874-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ef+o7LEH c=1 sm=1 tr=0 ts=6afebf10 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=qOpL5232Bh34HXG1jCUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzNiBTYWx0ZWRfXybdu2C96piT4
 pxFSya+R6UfrYI4ps4mykeWizBssYsrAg/MRMEZFOf/Fe+UtoCAkEQ8ZO8hsXdwbPxQPl4n/RnP
 38hPkV9IZV2paHKsH2xLlSIsqejvgxs0e5BuZ9g+m8NQpmidNzFNc3ZNOA9qD4yTgpD570Q49/f
 yGZcX2IJpKIrtBlSmuA+SZr+b22VGd/ZAeCJbhlvbh0g1ZEh8YMnlapta8LNo6ReCKThZBCxfN2
 yhHgLuIFHvZZAc1Nn2do7PRO06ZSg9PAv+f5hdwfZGbfYM6/JsmNavtlrfI3pSF6ph/4KQKucRh
 lB5k+PK4wvey7ZhQ/Q9qQxXY0vMTlLt1PhMTCun7zOapj1WDOp4AK+ZPrQrASd93j555qwFJV6L
 G4OLU2pLbxY9OIjRjV6rT/kWMFyqW15uypdt5h6LuIq+jnqLBIP8RSz1OGPALUZVryviV9klfIn
 h4udb+rynoPgzuYqSUw==
X-Proofpoint-ORIG-GUID: W-vp9cF2OK8-dfPGG4lr_CTL2USsIa-F
X-Proofpoint-GUID: W-vp9cF2OK8-dfPGG4lr_CTL2USsIa-F
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzNiBTYWx0ZWRfXxqd6+xxppkRQ
 7GCyFUBggTAFAfSO9HN+rYQ1ZPrSzpMs5sbZvwi+eWMUmgYX09Wr9j2qz6pN1bObnbhoFQNdCfo
 1roPkmHuWCC3A7Us9k91S2nvBFJvIos=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190036
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 18/11/26 17:40, Richard Henderson wrote:
> When a large page flush occurs, flush the entire jump cache.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4873
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Apply the same fix to range-based flushes.
> ---
>   accel/tcg/cputlb.c | 37 +++++++++++++++++++++++--------------
>   1 file changed, 23 insertions(+), 14 deletions(-)


> -static void tlb_flush_page_locked(CPUState *cpu, int midx, vaddr page)
> +static bool tlb_flush_page_locked(CPUState *cpu, int midx, vaddr page)
>   {


> -static void tlb_flush_range_locked(CPUState *cpu, int midx,
> +static bool tlb_flush_range_locked(CPUState *cpu, int midx,
>                                      vaddr addr, vaddr len,
>                                      unsigned bits)
Please add a 1-one line comment on what express this returned value,
otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


