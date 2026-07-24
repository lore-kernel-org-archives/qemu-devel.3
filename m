Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6ABC531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 06:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn9fL-00035N-7X; Fri, 24 Jul 2026 02:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wn9fC-00034l-M6
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 02:45:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wn9f8-0005FV-NG
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 02:45:40 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66O4lHZR1869015
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 06:45:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZYiRoENtHDmhA59nWTSdMz0yUv0EPN2TefBu2Y5tbKI=; b=fvP7j8L/o7M/O+QY
 +ImCTBWLJc5TPfqMO6RAhn0tcYQWClE3MrYtoAyq2hzUu8RW276MpMcaF+ES9hLB
 zVzM35T9rYRFtyPP+VZvh2GqEe5wxdPhr9XOe3eRuJo4uiRNCnLQzL82F3NVK5Xp
 YOU3NVT1XjmxzTJPOwShqJymkZn2TZx05Vpvyldu14L4oZeTHH12+iTOz6dHW2X0
 0EnbJ4tbV80a3tIhJ1Axez04Qfwy/E92m9d/mrQBgL0KieS0UTxSnpHsPJyZvQCb
 HhzacnRf4fQsiq4DD7JoMcKTy/rNn+qj6uPr6Bh9JPqlO8cqUpFlOQTiTEqn8cUI
 tBzqEQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm0pw8gue-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 06:45:36 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1e6f602cso1320501cf.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 23:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784875536; x=1785480336; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZYiRoENtHDmhA59nWTSdMz0yUv0EPN2TefBu2Y5tbKI=;
 b=Y9+XWMFRjjjjl4wNx96u8VD0LbiX+uzbWiBdW7UfVf8mIov2JhgNsodU12Yau4I5wN
 I4A/rziPCQZ2HE0/jhG2XgEkaOq9T1kb1pyB3MT4duHd16Z0Z9P5BO/q8P1MAgAqRtT0
 1khk52/qcpzke5i42uwfwAbkYsBwZD46cjJ0aeLi5EKSWL1G+UkbZW8VWYN7zu/RF0Jd
 WCgL4wOAf4feyzHrYRC5LuA7WitqTHAOFM7QUP/qNwLarm0W2QQFYUQtjFOZdt6UW4vj
 kjlu+7hk0SsftXl86vVnOrbJJuaCbd00FoKxypGzazWskq1jYeLde5/NOBns2yFCChea
 gIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784875536; x=1785480336;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZYiRoENtHDmhA59nWTSdMz0yUv0EPN2TefBu2Y5tbKI=;
 b=WAcK0xiW3HkAcCoO8QE9Ij3W5ARKj0EhZpyhYjrYU7REbED8HeE4vV5xuwgNht6pSL
 riMUa0YgF8PZJPtSaJLUEA3tjDiEbGsy8LF27IaCqz0NwVzrq+PjDRVO761pOILXaYkq
 nCs29BSH0w8tUk4Sk87tXIfzXRKmSlQlsp544IIdkkiGbq/gzxpJqU0qOErFh/kSOUGZ
 jIVhxnR/zyE2Sg/zJ39VmpU22FrYASTaKMwct77EaHxhw0Emu6J35oRMtILhvDMa8+tX
 nNzK8z3wQ38WOjj1ZHu5b0P2pUmjro5ZtKjCu8HQVw2Fv7TJJJht7I2DHARDndilaqr8
 jThg==
X-Gm-Message-State: AOJu0YwZLpH7M+oL40j+X4YF9nJRzdH84fbnnlBwF9svq7ufeHn9ctIs
 j4n7rWZ1J95aAKxcfmF7kQRmlu7dpQ4/KGHjCwEKXGa9Yn8+DctFhCTRNg0Mfd9kY33a6RLCkGT
 0Y7bMdIJX7XyxpUKSq2QQ1gfHudTOWkuH8Mj0bfvkB+xd75zRPMM6N5/aUA==
X-Gm-Gg: AR+sD11vJAQlq0R4OQGhvW/GwVxq9KyMAMhH6Ku52pYUpkRj6b3R1AS6pIlTm7G1dg9
 ZVptzu080d9jqWzrNn6wVkw0yq/Zi3xVB7cDRR7MNiGWnr8EHPRnavNdFgSgRuZGlzGQY2+k/sl
 HcDyPO27LUgeIFPAlE1ZHbSy8LKt0iGy+o/Ux8by6DMlZ4ShdCntQ87fGjiluO1Bahj2NOL0Fdx
 EBADOmJVItyhLYOCCm6PR4MYLwLvO8Zbi3Sm2FZKyinHbD/Al4k8DxOIuEthAN5Y6A5cVdIM1ZV
 lIJZbup9NdWgdSpR0a6stUt+9W5R8p8zL6XpTKhcTdB+Vg6eaDiFlcur1Kq/8Xgw7YJbfUpYe5r
 D2OCudeKQy7hWfupDEwWFClKV9S0=
X-Received: by 2002:ac8:5dc8:0:b0:51c:fc4:a144 with SMTP id
 d75a77b69052e-5283ddfc1b2mr59535581cf.4.1784875536378; 
 Thu, 23 Jul 2026 23:45:36 -0700 (PDT)
X-Received: by 2002:ac8:5dc8:0:b0:51c:fc4:a144 with SMTP id
 d75a77b69052e-5283ddfc1b2mr59535381cf.4.1784875535761; 
 Thu, 23 Jul 2026 23:45:35 -0700 (PDT)
Received: from [192.168.1.138] ([176.176.154.185])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c531afsm21564811f8f.24.2026.07.23.23.45.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 23:45:35 -0700 (PDT)
Message-ID: <8030c6a1-c389-46e3-b81e-f61cd95f1fe8@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 08:45:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv: Fix memory leak in
 riscv_trigger_unrealize()
Content-Language: en-US
To: Zeng Chi <zeng_chi911@163.com>, alistair.francis@wdc.com,
 chao.liu@processmission.com, daniel.barboza@oss.qualcomm.com,
 liwei1518@gmail.com, palmer@dabbelt.com, zhiwei_liu@linux.alibaba.com
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, zengchi@kylinos.cn
References: <9882f9e7-5c05-4a76-95f0-eb8ae8366f62@oss.qualcomm.com>
 <20260724063927.3360599-1-zeng_chi911@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260724063927.3360599-1-zeng_chi911@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA1OSBTYWx0ZWRfX/vv3kDYCmVgY
 n0Bie+Q6aB6eLVVy7tjS0xagxEmAs2HxjtekmqLzhq4o+MzP0Xk4KiXIwy2WmaRKbP/ajEpnx/9
 1iy7KCeIR/NBPvSiUInPmmPJDiVjno9CmT7T45IC7DkbEj8Mrjt2a2/J4uEoA+on3edDJTzyy1a
 kgL0hhJkWi9prHtd5oFTd23iyFutP4GRCY+xHeFEL9SjleB9S8qZi1Kcy7USBe/5eF40rSWJdJP
 zp5fd9x/GB3Y5Zrx6B1vxJvh1tZU/Nd0euKmxiWX6PA8/qMIFXlqD9YdJ4C/OShyrd/NYVf/zqe
 8Bj61N7KSank43A0dHwwbueJCHcxofeZjMr7uSfZQbo5vN0mVTfS50II6f4cG9KQDLh4zcNzw9G
 7clpEC0P+c/TiTPW2RMFPzImon8sSntcr98Q+uVXSu0ZnRSepdHTHDEsWyAE+3Cx8x/u3b8aafb
 +8/36zJ88wqbVj89itg==
X-Authority-Analysis: v=2.4 cv=RJeD2Yi+ c=1 sm=1 tr=0 ts=6a630a11 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=uVRRv9AK2fddTnT+2a2/4A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: ty0rOP7l-teg23e8E30IkoKZFAP7A4WX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA1OSBTYWx0ZWRfX+Qi3ZrgmSsRf
 mLD61+VrjtyTmN9vkHbQGouKNF7bsTQp0YGZVNHGTSliswdqU8cWh+A24+T5o97UxKDRfxSbP+X
 QEL7dI+6r3sRS3sjK1japKeoSIpabY0=
X-Proofpoint-GUID: ty0rOP7l-teg23e8E30IkoKZFAP7A4WX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240059
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

On 24/7/26 08:39, Zeng Chi wrote:
> From: Zeng Chi <zengchi@kylinos.cn>
> 
> In riscv_trigger_unrealize(), the per-trigger QEMUTimer objects are
> created in riscv_trigger_realize() using timer_new_ns().  However,
> unrealize only calls timer_del() to cancel them, but never frees the
> timer objects themselves. This results in a memory leak every time a
> CPU instance is unrealized (e.g., during hot-unplug or machine teardown).
> 
> Fix it by replacing timer_del() with timer_free(), which internally
> cancels the timer and frees its memory.  The separate timer_del() call
> is no longer needed.
> 
> Fixes: 820552a92e32 ("target/riscv: dynamic alloc of debug trigger arrays")
> Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
> ---
>   target/riscv/tcg/debug.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com> 
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

