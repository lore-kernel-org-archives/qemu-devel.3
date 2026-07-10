Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06241C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJC2-0002Sy-Tv; Fri, 10 Jul 2026 17:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJBz-0002Ri-LO
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:55:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJBx-0007Fj-NX
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:55:31 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3Aov1891693
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J0JErute59YZCE1QPeYjwvNPAb/QF8V9CXZId4ouJXI=; b=b6s/YX2LNY2/+VN8
 k0huwEJnq6Qkxnxl0DdqG5PFuA6Nk8dVcIuw/5GCMoGKijPa/TS4gozDM0iUIDPp
 7X8xAwVa3S1UaZoLNxlNU+M1XK4c33fgK1W5on9yxvRR+K51uHxoBpkRSIjsgzmC
 V7hnyLJr5QzWfP/A28V2EZ6iH3G/PvDzB5kmp0tmNmFQWpyRlvvmdiXhV1coByj5
 dekGA7V1/wwx6xKV+xqVa0sVMtYaJNUhw6n+t4SAqD661Edv39E4yuJ6E1zCoBEk
 3HWin5ysxDdpGBJcsPK8iJ2IiP9mstbC3a9blSJffeh/4SWj8yOsA0snRmnLo3Kn
 sgi+4g==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb3xvs3us-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:55:17 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ef8249f871so15756056d6.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720516; x=1784325316; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=J0JErute59YZCE1QPeYjwvNPAb/QF8V9CXZId4ouJXI=;
 b=GfqfXWGrJzh6Nov0RfWfGpOAl6HJMLodlQJ50gDCLucTaiU8QmyEYaFIn7Zy3JPqhy
 uzpYGOH93hWEmXwS9Lz0U3Fu0+SkiJId4v08iV4KLB1EVyT1IkSORAxuWT42JP3eYVAs
 8NiqGX1pYhKQyZVq8OujU05fX87l32Lw7OtPxHGUVonF6aImdyzJ+ZooTwsahjZcahO7
 FnJV1x0IE1/3kZGMYdzdP0SZXykEKosaXu6usoiiGBnR6Uk9IlZVwZky9ldlV8C+4a7r
 Ta78cK4OTZLL2ohsI4gjb+Do29XEuPPpl3HCn1kF/n4B9lPEkR+0ATbDq8CR+CLh0XGX
 Tjxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720516; x=1784325316;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J0JErute59YZCE1QPeYjwvNPAb/QF8V9CXZId4ouJXI=;
 b=IKGIKYRoCj+45T43ElSbHijm45QxmNQOBiheJdPDB2wIttBsxdPOVdAc8nCKK3vicK
 ZM+GseSDP16LD1dHml1kbVcrkoO8AoWcFH/UuEpTBvwsC7N+5jJy2EFizQyua4fQGSKz
 /UKVFQWupjy2gjt/LgZCeH7ujDWF7Zs1EZXua4GCUm2+saj1Px+9c1hfj6g5NTc3rR52
 ZXgN0cdP3Zd3184OKIwq6uJ7NKHXmoDRXvRKU0khOKf7PTFPeN3/IXagjDUsqxlBRvn2
 SToG3Ut7jdCop5tYKbIK9HExyj3wb1SlytJdmZykhxFBBlHhPsZNGzuy+ZgqQUQ2OS04
 u8BA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq03h/6aum8QV6rdtnoU00z9HdfJc03p/yWOUXJ2aHTOYRVOo59BbCmOXVhAt83JYI/x95Z2wRf5D/X@nongnu.org
X-Gm-Message-State: AOJu0Yx4+op6a17/NAZDD9sNQpvq3BBAtP+W0+i1HxoyfhCqk1+0BrgA
 LxalpAizpFvt6O3f2rVbU+gimgsInGCtu2qtwodKemTrS/4Ek7lgs02LAxdR9mbKDmScpYoOPNR
 zRC6rOmYVyZvZEkrirDt24MzdVNxeYa8gMO48RskBlleAfTW0LRoUEZt8lQ==
X-Gm-Gg: AfdE7cnjsmOFkjQ52N7XfNzwiC3sT96LOiLImYSGor+GH4fBiqs9cZ6qywlcUR4llo9
 9ViRmaW/iiMWtDuXOv1gRF8YXAcV7EZWrRRoMgdFZQr9Q1291ud97QESooLDK9kYZzWNCBx/FJo
 1GKJG+aviWQ6jrz+bjbvNTCK1GfTgGrz3QsfqIlsEduZDc2spOq9lxVmqR9iPrfkUBp4pLGHvF2
 mPrP8nb85VvXuRcyTSR0N9HnoerC5vHG5IO5o87yolb/DiwxpWvdr0K2bBatqSeItFkEEkxCtxM
 auK3Depz3h4LNdkWzr4oAOJqCxBBxVrmJC10v9sJbmre1oHIGMGriQLJOo6Ew4Ev+SJoEqKno8v
 akFDUKbdEp8CduZzFkT4sEDgCkOZl69VpC0hgVjaMGSpRdcKAmHC2NFJe1Uc5Nw==
X-Received: by 2002:a05:622a:1e0a:b0:517:642c:8196 with SMTP id
 d75a77b69052e-51cbf0701fbmr8242511cf.12.1783720516175; 
 Fri, 10 Jul 2026 14:55:16 -0700 (PDT)
X-Received: by 2002:a05:622a:1e0a:b0:517:642c:8196 with SMTP id
 d75a77b69052e-51cbf0701fbmr8242301cf.12.1783720515802; 
 Fri, 10 Jul 2026 14:55:15 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6df417sm173979145e9.8.2026.07.10.14.55.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 14:55:15 -0700 (PDT)
Message-ID: <78caf14c-d316-4924-bd23-6e7edec997d2@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 23:55:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/51] exec/breakpoint: Return the new wp from
 cpu_watchpoint_insert
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-22-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710205401.836304-22-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6DFTvskSMHXMcrghWjGRPgTZ24XOHCSp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyMCBTYWx0ZWRfXxYBIpCVzqWuF
 /NwRM0TCD0y8ipH5LFTPqpAY+7K1VyIDKxS2UIoNZH9rGv/5D3eAWwZoToLMNKUc3wNojobf9JF
 x2IUVpHROvZg9tBoDun3G7eWdIF+S1R7Omk+IeAeWBnsgEydWeLCtRx4GEUfOEfyKJVNuZlGFoU
 t417NaQkioocE2jLRy87aCoApRITLtHFpj5BPBLjskgPzPCSMATsVH8jXpIDhkNKLMou5gQ6e4n
 IvGxwj2w3DUeOn7GUHRtq1bxyB8cFxz+ydqhyfbTbjWuZIo3qeSmfR4/ppxndNzJDF0L5jg2V7r
 +CooIyDghYceSmfKQiXgGBqKZRG9kKwxQ8HWQgLHdKnoFvmGEYMApAZiWFLjakcW2a4I7MIRft4
 1Jds1kB/9XHNlEe+jQcy4EL32QcRdew//u/wj9reUl8Zf/p+5cd2FKWjqBWTPxCj6sFXwV1AqhT
 feplPY9N5yh1WGiaIyw==
X-Proofpoint-GUID: 6DFTvskSMHXMcrghWjGRPgTZ24XOHCSp
X-Authority-Analysis: v=2.4 cv=HInz0Itv c=1 sm=1 tr=0 ts=6a516a45 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=iEHWvvDq4-ptc5kxTzQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyMCBTYWx0ZWRfX3BOy4Rgb2uj9
 IVKQzrnX20bjV2lwJgo7x0SwIr7/0WzJcgGokFOsipBnu/Zufbyr6nULElMVIjRRSVi6tEmsLNQ
 Q5DQjfNI2p8vpwii2TD0qewr0pfX8ME=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100220
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 10/7/26 22:53, Richard Henderson wrote:
> The cpu_watchpoint_insert function cannot fail, so the error
> return value isn't actually used.  Instead of returning the
> new watchpoint by reference, return it directly.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/breakpoint.h           |  5 ++---
>   accel/tcg/tcg-accel-ops.c           |  9 ++-------
>   accel/tcg/user-exec-stub.c          |  7 +++----
>   system/watchpoint.c                 | 11 +++--------
>   target/arm/tcg/debug.c              |  4 ++--
>   target/i386/tcg/system/bpt_helper.c | 20 ++++++++------------
>   target/ppc/cpu.c                    |  4 ++--
>   target/riscv/debug.c                | 28 +++++++++-------------------
>   target/s390x/tcg/debug.c            | 10 +++++-----
>   target/xtensa/dbg_helper.c          | 10 +++-------
>   10 files changed, 39 insertions(+), 69 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

