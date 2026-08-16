Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C87C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 15:18:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcc7-00035x-Hx; Sun, 16 Aug 2026 11:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcbz-00034e-1m
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 11:17:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcbv-0005AA-Lh
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 11:17:21 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDkuc83631486
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 15:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IjC/ciFDPuGvWvWUCVjSu8/vWWfDkE5Y80FiO9GPPTc=; b=fxHBmf2XVwNaldG6
 RU6FKPfkuzpuhJFtBsUjqKF+Mt/1E3thb65olLc6DHncFenklvsS/CYaqgj2Vfvm
 qIsZUuDNseXp8XBZ3TONCJFfAxoR6D4cqGZ4NbW0aEzBpk57pTidLHps4WPFHbzf
 Wwszf9baABDyRFtGhI0tOwpjidlav3VPFmACQL1pshE8vg2U3FFThpcyMgNWbKYr
 ocuGky53vaOOD9a/V+UUKt3TGoeAQxZpK3uSsTKsoHlR7y+lXBVufE/vyB7LoiIh
 gUHgq/dPt9HitjHGNXYF5fR5x9iVOzcyt6lVMneWa8zGdZYs/4Far+fV534gPdbs
 mQMW3w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghekruv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 15:17:18 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9349c5af52bso467688385a.0
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 08:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786893437; x=1787498237; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IjC/ciFDPuGvWvWUCVjSu8/vWWfDkE5Y80FiO9GPPTc=;
 b=GadsZu484dwWzK7Lto+U1MXkp44zDLNtAig0nfpDFOdBSDtsT0e6FPofQYUrjEeZSv
 gscX1/9fF1ND8Wi7PxQmqt8YTmc4wXWqNgqWnLRPTPOhZm/6GmHRGI/W0ry/Av7628kM
 tF+q6JVjgassHIPE9ayReOeemki6yR1auyYDUYhrZVjR0AYSy0r7KMgdYlOlFPRBDQRz
 e/PUza3poJwEIYEvQd16bmBOAd9R2ayacPP4bwWGCoc9HeKwI9yOtQmOm9CmAEuhgZvk
 U5Ci0E0yVD5+N9OWmirwytWPFyxJAfdXWnxhIzyR+8+3FLPpmITDGI6NSbwG1pG6QnO8
 KRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786893437; x=1787498237;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IjC/ciFDPuGvWvWUCVjSu8/vWWfDkE5Y80FiO9GPPTc=;
 b=G81Yr+PcJ5N3TxAUG5HTTj7hbUJ9DTnW3msdW7lQcrp5S5oSjdjFNl3tCmZzxbUxbo
 WtzEOHcM6czvR4c1TIN+qE0pRuS/THu9mxo77GYx5eVFlnI7a0SdHH/hNCxfbvc684/E
 M8+kuExaNsoJir6iokTJ4im6mgsdNdAoGLWfNdzICEbdYDBFJCn3liLvNfg8Ac5LTAor
 0IyJhg2svSq+C/5hs0qj+vQI64sQbfGUhILAGwaw3zjyvwZrB11zxMBryXzpPOGk14fu
 gEoa1py3qV7p0MsK2fx6k47tRUOpMI4bvq17tU41TYNy8rq4lkxqksGT4HXGqoUDtZjf
 ++mg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrkYczsRlq74ZQMklxneN7BCsBlIZBzD1R2EnsuK71axRESmf+db6z24GdDgxnFOVz2s+c0/Snpv+vZ@nongnu.org
X-Gm-Message-State: AOJu0Yx2JhBOrcUFEvynoimrL5Yr8u3e7vMncpiVGIogZ2K2JstPVql9
 dALItVUx3WjRyw5yFHvl+AGibbP4WUNf7TEb/Dmxoh492OVTUiHNnRPneEo07WTT2uhmC9MsPuU
 nYjsczhL7Bf93sthyPNxkyobWhQHqTWaMmQL7bza4siROQ6CQA1paI8B4Lg==
X-Gm-Gg: AR+sD13I5FSV46TKvAXyhtIZ7VHXfM2HW9zSELvOEg5RtB9ndXtoeMS0m2LNKCTAKcT
 XfGlUnt6Szfdf5WIqfXdVR+jszoikUu7LMLwvwuShBeCu4wwx5UHlmNNlSXj9/1hvhysn5mopRP
 dC0RLGYltUO0p3RhhxO0Dij5WwakkXy1WbddSIAkJtRDRuy0FKIXGboeSqJHlE8e3KFL7fcZYaY
 Up4BOkNMdYmNzWUNIe+iYUmdsCwlLqEAGJEE/i7CaqpC7adhLckFrhCAXoGcUmoBjrmEJQ05+JZ
 UChz3OPSpaB+TK9a0nKp+LJ6buIoSWlWDFIXqdXKNPOXnLP9Eupw6pOIikJPjgzjtL1hoi6j4Lj
 16D6Z5dZvuiT+LzAuKjczKeOT7bWQ+1I0TTY=
X-Received: by 2002:a05:620a:44c7:b0:915:8055:3f91 with SMTP id
 af79cd13be357-936d239f8a7mr1930482885a.43.1786893437522; 
 Sun, 16 Aug 2026 08:17:17 -0700 (PDT)
X-Received: by 2002:a05:620a:44c7:b0:915:8055:3f91 with SMTP id
 af79cd13be357-936d239f8a7mr1930478285a.43.1786893437019; 
 Sun, 16 Aug 2026 08:17:17 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996188217sm131142035e9.13.2026.08.16.08.17.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 08:17:16 -0700 (PDT)
Message-ID: <26a073f0-9e8e-40c1-97dc-6b420740e20a@oss.qualcomm.com>
Date: Sun, 16 Aug 2026 17:17:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 12/18] accel/tcg: Replace size with first/last in
 TCGCPUOps.tlb_fill*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org
References: <20260815203730.1468365-1-richard.henderson@linaro.org>
 <20260815203730.1468365-13-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260815203730.1468365-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EKc2FVZC c=1 sm=1 tr=0 ts=6a81d47e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=GuUwtT5LwiOZPJdfuKMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDEyMiBTYWx0ZWRfXwboQzSc675OL
 sEpgD+PXk8cM9GbgyxG3CV/Oqi0h0NTrCM6sOJr7SxfkNqUj5sBv97R7/TxMmczAvOjRkfyOCe7
 +3o1ZoorLmdyRaqFEmL8XFm6AFKMYf8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDEyMiBTYWx0ZWRfXw8I84Z8Kv6wX
 uolXDPbMFWuAPdKcVQUZyuiyPmTjaxeynbgyOnerK9JGzOKvYUEptbaLv4gaZeLw+6C6MM9FtC8
 25RDM7U4ECzDFPbu+Ht8IE8wo6XHs/sQ+aIR3ZOGmkW34oLaYAa/oScVd7rLlVVI0Kzxbgu2lDg
 rRTVYiWY/rIdthpJvjsRDd26/w5Hta59r69Vxb8W6m1VQGAv+iwKtbbo/S9yn0uzqOisq+qf7mi
 Mah3f+5xbgOQTY+6VaBIdpq6wmblmras/qukR7uc4V2yqD4S7xkdHulqhXdBFssZwwKrlJ1o8VM
 dHZEf2Tb6ctg0OBBmCIW4jZYOsgIAoURD2NbI3yrRvWfuWreEGQz/u/7Zh40v2csaddWPS2n9g4
 jhFbIV5H47g9e4GQ0CGpD0U25uSkchZsOcBI/En+d0bKKBSv1O7WAPKYOnRL8qB2BWs9zBDyDGD
 nXAX0+eD+kOTwjdvR4w==
X-Proofpoint-GUID: JuZuI9YFp1aGxCuOg0jnwAgEISOpqj2x
X-Proofpoint-ORIG-GUID: JuZuI9YFp1aGxCuOg0jnwAgEISOpqj2x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160122
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 15/8/26 22:37, Richard Henderson wrote:
> Expand the interfaces to allow an address within a range to be tested.
> Additionally, where was an edge case of size == 0 which was ambiguous,
> and is now eliminated.
> 
> Only change the functional interface.  Where required by the callee,
> rebuild "size = last - addr + 1" locally.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/accel/tcg/cpu-ops.h          | 16 ++++++++++++----
>   target/alpha/cpu.h                   |  2 +-
>   target/arm/internals.h               |  5 +++--
>   target/avr/cpu.h                     |  2 +-
>   target/hppa/cpu.h                    |  5 +++--
>   target/i386/tcg/helper-tcg.h         |  2 +-
>   target/loongarch/tcg/tcg_loongarch.h |  2 +-
>   target/m68k/cpu.h                    |  2 +-
>   target/microblaze/cpu.h              |  2 +-
>   target/mips/tcg/tcg-internal.h       |  2 +-
>   target/or1k/cpu.h                    |  2 +-
>   target/ppc/internal.h                |  2 +-
>   target/riscv/cpu.h                   |  2 +-
>   target/s390x/s390x-internal.h        |  2 +-
>   target/sh4/cpu.h                     |  2 +-
>   target/sparc/cpu.h                   |  2 +-
>   target/tricore/cpu.h                 |  2 +-
>   target/xtensa/cpu.h                  |  2 +-
>   accel/tcg/cputlb.c                   |  7 +++----
>   target/alpha/helper.c                |  2 +-
>   target/arm/tcg/tlb_helper.c          |  5 +++--
>   target/avr/helper.c                  |  2 +-
>   target/hexagon/cpu.c                 |  8 +++++---
>   target/hppa/mem_helper.c             |  6 ++++--
>   target/i386/tcg/system/excp_helper.c |  2 +-
>   target/loongarch/tcg/tlb_helper.c    |  3 ++-
>   target/m68k/helper.c                 |  3 ++-
>   target/microblaze/helper.c           |  2 +-
>   target/mips/tcg/system/tlb_helper.c  |  2 +-
>   target/or1k/mmu.c                    |  2 +-
>   target/ppc/mmu_helper.c              |  2 +-
>   target/riscv/tcg/cpu_helper.c        |  3 ++-
>   target/rx/cpu.c                      |  2 +-
>   target/s390x/tcg/excp_helper.c       |  2 +-
>   target/sh4/helper.c                  |  2 +-
>   target/sparc/mmu_helper.c            |  4 ++--
>   target/tricore/helper.c              |  2 +-
>   target/xtensa/helper.c               |  2 +-
>   38 files changed, 68 insertions(+), 51 deletions(-)


> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 0ddd898e6e..bfcd9b6159 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -666,11 +666,13 @@ static const char *access_type_names[] = { "MMU_DATA_LOAD ", "MMU_DATA_STORE",
>   static const char *mmu_idx_names[] = { "MMU_USER_IDX", "MMU_GUEST_IDX",
>                                          "MMU_KERNEL_IDX" };
>   
> -static bool hexagon_tlb_fill(CPUState *cs, vaddr address, int size,
> -                             MMUAccessType access_type, int mmu_idx, bool probe,
> -                             uintptr_t retaddr)
> +static bool hexagon_tlb_fill(CPUState *cs, vaddr address,
> +                             vaddr first, vaddr last,
> +                             MMUAccessType access_type, int mmu_idx,
> +                             bool probe, uintptr_t retaddr)
>   {
>       CPUHexagonState *env = cpu_env(cs);
> +    int size = last - address + 1;

Nitpicking, since we know last >= first, could we use size_t instead?
Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

>       int slot = 0;
>       hwaddr phys;
>       int prot = 0;

