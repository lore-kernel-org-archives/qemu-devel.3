Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622FCC982FD
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 05:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9baI-0003Hz-UX; Thu, 24 Sep 2026 01:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9baH-0003HP-G3
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 01:01:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9baF-0008Tb-TR
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 01:01:25 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O43KKe364843
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 05:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pTySG00EnnB5o/4tbUqwNuxj1yLeKjJQyOxK0eHYs3s=; b=fFKR539vNnCQCZNk
 3uS95FDh6gqlDb0TSdluAjZZPT9/yN4Ghk/DSnpanLmEWVFLGXOav1OTzr+lxse7
 DrbtuoNJ7tobcknnwZfNXsrp+G8Re8u+MdMtzbFvQvx2U3ykWXq7xZ+KtNflHsjo
 uH7v7mPOftpA4CqbIQAL4R7xXo7IIW/KDRBBEFf6+PiZhRkFRasR32XcpdMCEP81
 9Nbw9HU2YFDiS02pwgf/3QwmDiSoA8zyzeyxGKDR3vfRtsAVUOvO3jgnxLsGuo/j
 5lfiqsrI8CPkfXCVqgu0DONkapxMHhJof97PFHZ4iDZvGGPtAj5j3KEsq6zpSUVL
 ZmS1mQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvvgh854m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 05:01:21 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5c9ebae1b10so544353e0c.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 22:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790226080; x=1790830880; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pTySG00EnnB5o/4tbUqwNuxj1yLeKjJQyOxK0eHYs3s=;
 b=Wh/DzqRlZyU5dUzN7VvSARfCi93P2kGulXQjPBu9gHhkq4V2AhKESTXk7Q+BZwim+d
 DE3xb1msgTLb2xPfhzHOpSiSM0MwCCWGv2iHooqmPW0qNToKrdpEMLjqUO9AZtEpQaCd
 KFr6Z9MR5Xe09pUjV8IU59Y21yl/E9E9qye9gSGP/krPbIL0Drta7c/Fb71oKZfgwhB9
 rEI8Vsu0SRb0Z+ppVkI85XsEnj+9H8Tf5LrVemwGGeOIs3IT9k6K4KDn6XfEj8Pwd/jA
 FIKJr9iIqvlVEltySuxh/wHK26zQPv9TrdTv8I0C3IX/8h2sYwKRTval1iZhcAp3NkID
 MTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790226080; x=1790830880;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pTySG00EnnB5o/4tbUqwNuxj1yLeKjJQyOxK0eHYs3s=;
 b=sNY23tef8cEeEiODAP0R24vMiKfljRn4lcPCCAiF4XflWsa8B6mSx0QlsGMXR03AqU
 SFflmtDPOHN5GF+ex6Dqsm04unSqxYPjBGnoVrM+sxlFyvnt1voJLoB4DLpK2KIGeOUY
 cHu7fCxqhOd/4gNYc11CW1vcwYhqOZ1BAZ9METhZu933w8txQ1FBjl41aoLAO2AcVDcU
 GyB9edox6yHNpTSYn4aQrX6Rq3uRa1Jp9oIfHuy8sn+bg6OImZ9Zr8lTmCNLrmlxXDFn
 H1ERjhedwRRybTwzJlvpYvMVv10SmGwIqiykaYPm9XluAU4F1Xr9SC+OI/qGlGaIlUZy
 31Lg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxO5VyGo6gUq8eQeK90Q3oiWmuTm8AyAO9X+1Z4BW1HXKj9YAsp+YFisoWwRvCBQIXXT0mUhFJXGQzj@nongnu.org
X-Gm-Message-State: AFuF++mr8duhHj7bFuz2nZHPbVO+kfT5AQ8elM4ureQ38ipJwU84gyt7
 +UobYPXvHgsOHSqvjeogRECoZW7ANG0ovIvKNexO4FcjGniwRcNbWYOCKYDB+4js5tl0DFXU1t1
 bBCjGf5Qk7YDYBkCeuY9H0UN+vWfx25CCTe3PHMW3diODJmZL2bAkyk2FqA==
X-Gm-Gg: AYBFou2O2yPQ9kJ9TAZqbx4jW5xgBWc6D9Q5fpLzetkDAOZp1VX89p71N78Inp/S/um
 62BWTe9tQMvOUXp5n5WxHPZ5fgZL/FvLJXOSdQPUUO7XuZTRZT7/Mx+giYE/GEdmPT39nkC7quC
 oqOb1hyXSzE2iA5I17HVsJiYh/9jgqj+Geh2T2fUdDFrPcqmBIOVxXRtwtW7cFpj2YbOTQVcSow
 F4PJ9RTsphlFVhE3FDbcdUb6AxUp53TukObxtjIYuMxCSeF95NNK/Bgp0gv94LFR0TFSkk3t+SN
 QK8StoXXq42sBHFJS7yar7AHDZyvpxjWvSOmazSVzwWVYhqQKpUHSBd0XraCPTar8P1eLgA5TOf
 32wTmkxkDpqH5VQ/pcmbx//bCyXZP/rDKiw==
X-Received: by 2002:a05:6102:3c86:b0:7ab:f00e:8d59 with SMTP id
 ada2fe7eead31-7af1e9f5836mr650199137.17.1790226080322; 
 Wed, 23 Sep 2026 22:01:20 -0700 (PDT)
X-Received: by 2002:a05:6102:3c86:b0:7ab:f00e:8d59 with SMTP id
 ada2fe7eead31-7af1e9f5836mr650190137.17.1790226079805; 
 Wed, 23 Sep 2026 22:01:19 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5cbd134sm40431765e9.9.2026.09.23.22.01.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 22:01:19 -0700 (PDT)
Message-ID: <f8debc95-0fe6-4765-8219-0f0cfc964976@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 07:01:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/7] target/hexagon: prepare for separate HVX contexts
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, marco.liebel@oss.qualcomm.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>
References: <20260923171516.3794996-1-brian.cain@oss.qualcomm.com>
 <20260923171516.3794996-6-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260923171516.3794996-6-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KYhHIgYD c=1 sm=1 tr=0 ts=6ab4aea1 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=3q1FPIo8JGfx5WVhvewA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: vo5EFFwNNQuhzjVzvaxTXmsLn8O3h-vD
X-Proofpoint-ORIG-GUID: vo5EFFwNNQuhzjVzvaxTXmsLn8O3h-vD
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAyMSBTYWx0ZWRfX2KUWi7XXnewm
 Yv99WI+KPN8b+HagwvceXhIpYIHQMFMXSzJ0P5YxmaEouMRPyokNLjna68wL1HV8n3+TWyFMsB2
 3YzS1L/gCar3ungTI0cd9zlRuDLy5A0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAyMSBTYWx0ZWRfXx5WoZ5THNjl9
 unRaAZFNuGAYRKUGrXUKO4+oW0UmoHZk1RoHHgg/8hSBc8oom/6s14e7BapX2Hc5vXuAx7nUiLz
 S1U9vH5wrSxx6GbCC05Ni9uobwRmNd9nhOwPgt875SjfrSXNyxtUAiH2IA5G02kIw6ITMPEOZny
 GLYT1bZ8GQgdSddiYX+v7699vXY2y0mn/ZHfR2SHMsciCL9nLKLubgZPSR6id4hYh2YlfNn9oQT
 esomkyu57J9JhHvgtxBCuTxFj0F8cZxFbCe+8N+vtHj4vNm1NRuPp6qncrj70iOfQ9vz7X275c/
 BSk0EOKv4S74NSNpDl9sqEme+cTHbWiqwipBN1N925kML+EXHGnJ4ulodvw62LGi52rIi9RE+N0
 GIHTovqbJDD6XvydpOL6kp2ro9ieOtTos8w6KVXVaq6ZcpClc582a3NtPd/JjDEU8DAQZFED8hg
 JMrASn1ugzUPG8efNCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240021
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 23/9/26 19:15, Brian Cain wrote:
> Prepare for system emulation modeling of HVX contexts, which are remapped
> at runtime.  No functional change is intended, this is just refactoring.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/cpu.h          |   5 +
>   target/hexagon/gen_tcg_hvx.h  | 608 +++++++++++++++++++---------------
>   target/hexagon/genptr.h       |   8 +
>   target/hexagon/mmvec/macros.h |  14 +-
>   target/hexagon/translate.h    |   6 +-
>   target/hexagon/cpu.c          |  13 +-
>   target/hexagon/gdbstub.c      |  16 +-
>   target/hexagon/genptr.c       | 102 +++---
>   target/hexagon/op_helper.c    |  37 ++-
>   target/hexagon/translate.c    |  55 +--
>   target/hexagon/hex_common.py  | 179 +++++-----
>   11 files changed, 597 insertions(+), 446 deletions(-)

Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

