Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E793CC5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:23:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuGPs-0006tG-Mv; Wed, 12 Aug 2026 17:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGPr-0006hr-0O
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:23:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGPp-0008O3-FP
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:23:14 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CK2cjI4038381
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ICf2YN7mJuZH8p0BVFPS8EgSyQwRCd3+WWtVkO84Axc=; b=k1vm7V+Fgcjh/h/W
 kfaAPvtob0Jx7UbMcWO86fymg+Vc7cVbNpwuPHI5PFY7uiT9u1WLf4uSZwLYlvoS
 iukUkDYQ76asbqbJasGTW3zBeS47gsclMxMUhgnJoU+F/u8Y0iY7Y/NgeJsokLGr
 qG+go7PsJrdGJd5Oh/v77wDkCElHKSM5jW555M9OKrRgcOdS7546EDbB0mQqw2Nz
 5IhQtG1vwBOIrtyurphFkbYsM2Ekd2Gl5dciOva7B/6QE1ikuDbd/3+hm24hBkV5
 htB5zetylv7QcXSW3TbU6wIg2XUOQAcKmp+joGw2lQDQRk5ODifyOGdb5RWGTIwt
 PnwXeA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0mndbg6r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:23:11 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52d28f8737eso72001cf.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 14:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786569790; x=1787174590; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ICf2YN7mJuZH8p0BVFPS8EgSyQwRCd3+WWtVkO84Axc=;
 b=OTP95QYjOOTiX9kvzbG1C+Z/8Lw/8/+O4X9SN49x+tu4/5U1vRUKEBEuKC3itwHF/7
 UqA1Hdlcc1Yh2jwHM/sqTBvcpL3WL9nRY/JGl2DH+GpEJdtBCt3UQgTuiUpJ1sUmiKW9
 qKI6W2uFVRt4+6hx/3UTlsCViwIhEi0HCrgkPuynYxW5Cu/VtBAzrZkE/BuCuqOuwHwj
 ZQrb3y8Ds5PuZaHokSvaEpLzq/KaWiAugUD71aI38ilHVkNa//I4VZOUkhLwDboHMpts
 EP1wdsEEH8HET9P6Cv5E/H84eEZxnToSeAwL9xHis6Agq/oWLL+fYAz0c/qVPGvr/NVw
 krig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786569790; x=1787174590;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ICf2YN7mJuZH8p0BVFPS8EgSyQwRCd3+WWtVkO84Axc=;
 b=crQ04RLo5DGZMJCif2IQkYkw0apsd1Pv4BfEBPj3ItEqjJjc1S5NxIQvQv6BRWN0x6
 JX3MibfGeLLEsh0rXlZhVe81NySYyI4xtJcOqa2QLZflA+1YOAvsFg8vSeV7jqgMgHnA
 Wew3glJFf0JNHZjGUmtNhRgt2Vt4XoQtLAwY4kaqjwbPY7+f0B20cwyRuv6NBc0ahM1B
 r7Zv3qzBJQ8O9yx/cC3ACh+ZCVxAI+1ZCvuXI2K27uIYdNfOcxUsTssgMl0/Pr2m8OO+
 tZCHOl5P70YYbVkZzNDuq0XNFIDAi3Mtjf3M+Azf0lQoXaCQ/hFQ1ZyFx2T1ls/E+mAU
 Hogg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrkOy21nyzIdzNbPtdu9+uFew1dK6lKGeis3hhtz+SBiV0CldhbHNp+t4+inq9Hc6D6PKbuGvwHoEW5@nongnu.org
X-Gm-Message-State: AOJu0Yzu0vv+Cr4qXDnGsJSBmypKQBKsqHs9Zd813EbGpBL7rcW1e9bx
 sP17/VdNSunuHwDWlSazHG3ZND9Gp9L97ZUbQijXMWUaJ+ZU5Ku4ze9QKsCJ/yrx6BoujX6wAmk
 eUcFs2gpMxEtVAu1gQn3WpmWQ0xJeXovr2dJjKGuNF6wlejN5wKeAEH1XIQ==
X-Gm-Gg: AR+sD13vfWptMdX8bCPuxxh2E3v+gZN+0z+SpqmpM+Wedl2lwv3YnW2SsDEFLoAs1G1
 JNnSVHjVI1rQGwEFiZV33jaggIvHmlpCpixrKNT3sdLdkAnDUg/P3Dd7KqlXIXcKSr2ijx6sNnf
 NnQp6oNRx6nLW/DQXfMp7okD9sTrAUcaZxhbznhjaLHq3Br0rZzqlsKvTaPSPb9tgPd+S9u4SMR
 EufyJFhhQpQDYDaSEHT04MR5iV+ANCtW9cq9AwtvlGMIashoqBBBey1+TBYXHAxPxqU71NRFCTX
 2gU7dOJu7Kr0c9iMliZ1d81un/CKP3Bwsp5dHec3k5oHfkIvTEyd7ueAANGqalRY4baUT57JZge
 a9bhPuyPZQo90liOsxF5Ko65SrqgCcEpcwEA=
X-Received: by 2002:ac8:5748:0:b0:517:6d82:ceff with SMTP id
 d75a77b69052e-52d73c6f14bmr10187301cf.13.1786569790187; 
 Wed, 12 Aug 2026 14:23:10 -0700 (PDT)
X-Received: by 2002:ac8:5748:0:b0:517:6d82:ceff with SMTP id
 d75a77b69052e-52d73c6f14bmr10186901cf.13.1786569789798; 
 Wed, 12 Aug 2026 14:23:09 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981e54b31sm5387345e9.4.2026.08.12.14.23.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 14:23:09 -0700 (PDT)
Message-ID: <c5dad01e-253a-444a-9e0b-8bc3f43b188f@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 23:23:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] target/arm: Tidy cpu_max_initfn
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260812204435.295067-1-richard.henderson@linaro.org>
 <20260812204435.295067-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260812204435.295067-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3MiBTYWx0ZWRfX96WZ3ulktlhA
 LEhIVPm4Dodh4jzFNwrnvfuVROqV0Mj/GU00CgQwXl1ukssqGUyHFdPlk7AmXnujwFaZK7XuPin
 xJVdHjyq+RRMwGlx3z8nRzvHY4nciak=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3MiBTYWx0ZWRfX1r3wv8cRbu8+
 yOn1o8ApJB+qo1yJLsa5py3BBpuV5xMPb3zfb4r2mw/lqB4W+uYsrSGZW7xzpwXqrldKtI4tb7g
 CEtjq7UjuJNJzR9QwliW05OWfoVVpNnJfILAPWX5d8Ofpeh/UNerK0QG6pd53KTBbrcrPK1rgfs
 ihFYk3hVTrTn+sgy6fylG/yrFOYV2CEyq0byqYMJ+1iOQB25H0hoK1iJlqDZaaCnffcbtIDyN1m
 KKcZYIH7Ucbj8Bn4gkMkoy5rLdp7DiQPGy+N6z/Aptc9ZEweGSjuIvQ0H8Jr9oTevrQoCteXlbi
 EMhd2ysE2hQScSGQMV8Gqqhx4e9xBhJ3Idw3NG5MCcyur+Ml+0cijEUPP0jpRVzkSvdRdWWO16V
 s+hs/WWdBB/BcvODuJ4A0UGrtw/MrfryebN95bHivjxhaHForBT1m1bu5jutIJYaZ3odqkWJS9m
 hYFpkuy/SdKEYAhpnmQ==
X-Proofpoint-GUID: 1x2NYOlXG_htAE9LjsYuyya-E9jN-bQV
X-Authority-Analysis: v=2.4 cv=C87ZDwP+ c=1 sm=1 tr=0 ts=6a7ce43f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=CSguRQI8Ln2yzAMP_ywA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 1x2NYOlXG_htAE9LjsYuyya-E9jN-bQV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120172
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

On 12/8/26 22:44, Richard Henderson wrote:
> Once we have eliminated hwaccel_enabled, only tcg and qtest remain.
> Separate tcg from qtest initialization.  Remove an assert on
> aarch64_enabled that is directly protected by a preceding if.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu-max.c | 39 +++++++++++++++++++++------------------
>   1 file changed, 21 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +    /* Ultimate fallback: -cpu max as cortex-a57. */
> +    assert(qtest_enabled());
> +    aarch64_aa32_a57_init(obj, !aarch64_enabled);

IIRC there is not CPU in QTest. I suppose we are just testing the
CLI, so "-cpu max" doesn't barf.

>   }
>   
>   static const ARMCPUInfo arm_max_cpu = {


