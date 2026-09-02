Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 373FFC61DFD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 04:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1cja-0004N5-F0; Wed, 02 Sep 2026 00:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1cjY-0004M9-Sg
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:38:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1cjX-0008Ae-8F
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:38:00 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681KTbNJ3048782
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 04:37:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 c/PD8wQ3sg4aZz5ftnF6nZoLTs5csQqd4zWwgQO1LtQ=; b=NxTBpHBWrNMjibOP
 SVASAxYIfxsE2k37AnUJxM/hKrgS7g92G5Ez/1NSrvbkVRfm/Az5iEf7uZFdc+7m
 /NnWSsoVEy0N3GivGnRSz431H2PBG7ZQwPtF/u5p1djIQAPbI7+nhXSczgR5uGpJ
 oB97gz1ZzxaJWI48PRvXnUTyGFWpa6VfumlrPVY3p34nnbH1tfiN0NdNzZmQOyE3
 o+QoVoTzugK7VELphX8mj9iWLHrtfQK1l/kWKoEszuWE89/AKgQEec5gWdhdbS5u
 gcpBfTBpQJFW4seILdSvok+ianrE1/YvaY67HrU/WMJdU1hbXbhrvftvipHihfnq
 laYEdg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge397a4km-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 04:37:57 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93494527488so138766885a.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788323877; x=1788928677; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=c/PD8wQ3sg4aZz5ftnF6nZoLTs5csQqd4zWwgQO1LtQ=;
 b=BBAT9YJFdk7NMOoxbx0J/g8N6RYw1OriL4YWbMOFpirEVIEeEa57jpGDSqyF3OTKBR
 d0AvKDFVSkreRDH9b+2AzNoOzgJVGLZ5Dmtn4XcI1Nt889HhG/1PHQyoGEJqOwqYGMfv
 ngOqpWRx45rC8y2bp4EO+ZC2zCX+zq3HpZt+UBX4xcGujcRGM2XA2BVJywRN+rskELPV
 Y36Shuxpfs+cuybhnqqEUlZuYed8XY773Zy556feXpd1DDdxty8tssc8amFui6OxUO43
 v8ZD/UCm0g/HygVAiAVIaH6/IDa+tS+PAdT0jD5pOVZlYyMBR/Op3jW5x8rpQLbZ96xz
 rBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788323877; x=1788928677;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c/PD8wQ3sg4aZz5ftnF6nZoLTs5csQqd4zWwgQO1LtQ=;
 b=kR4QgvR0rguSJ1R4B1ODYd8lj/YFA/hhnXIi2biareAuOCTj6v0UIU44Z34ph8WNpP
 WsPoZIh0YfLpl+8Lxy/nADXnyDjflKMEfuSSFV+CUVBYkhrmDowyeWP+gcX1syNSAFzF
 Hd7KwWQc8IlsrpATtZb5bPtmmEglb2mOwcfWqARi4jOONmYVADhZY2W7PHGiisLiV0GR
 zApqnOKMGe+9XSTaKpQpZYmd580KH8mbn+Y+0wv67qSIIyVp69xPm1i4ax5s3aS04PXz
 x1ylbizy6dOVtSUhVMP/bczr2AMe3bLrp7AayyFcwD8LPSgIDtKHRdFYuOQpx4zROjfE
 NORw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp3NQUzarHwocxKfKgV1heB7PDNTWrb5sOhBr1/HaXyxT/O5QhfoLhKVq8B9KOl88J6sPBNOKTaHkKQ@nongnu.org
X-Gm-Message-State: AFuF++mfS8+2WksUA6bjykKpvpVZk0e3t0bhw8l5z4RpNY/dj3dXYuJ6
 HW4tUa6nUvXtjAI2i99fhJe2aYUERp0OpWAg/RjNQBgIf0R2U3fD4yMnxjCeJaPeaHy8EKK7LwZ
 +ogBmza8uLb4WpVwpLnSy9gcNH8rklfh4k87sSbQi7cTFzLViM8VVOU9DZOwfFA8W8A==
X-Gm-Gg: AR+sD12E/+GkygJQq0QRRDx456YvdVTVX1roT4osj0JXOt0FhGZBqwelscmLoYlZfhM
 hZEMCqThs0gp5THxrXd0Bo2YrjJg/gZNulqnipGk/hk/kXQB5kZ3D5x8ezRTz2y/hp6CAl03SCj
 7umeApFVdQL3bgsJugGJQzj1g9TzO1zJx3QpFpu6O2r+Lzq4N8mtsb7pGPt2lpiMHQH2ImhvuiP
 3Dra8ifNvrV1XTIrzbDRKa1i4J7URqM/NsjJtuBplLGF+y7MGnMLnGjvuuxuI1ZewtcVY4/cWae
 uiDamK+EJvN3pmQtbg6xd46Y4m+Ocm2WEQ+kVK7EbL+jInfc401dTjtMBvIZv/sKQqKsODVkmqV
 sIUAesRFOuKqd8jxVFp89rN1ZSdqm9r9sWQ==
X-Received: by 2002:a05:620a:e86:b0:939:4b04:cb01 with SMTP id
 af79cd13be357-93960fa0806mr184999585a.31.1788323877382; 
 Tue, 01 Sep 2026 21:37:57 -0700 (PDT)
X-Received: by 2002:a05:620a:e86:b0:939:4b04:cb01 with SMTP id
 af79cd13be357-93960fa0806mr184997785a.31.1788323876969; 
 Tue, 01 Sep 2026 21:37:56 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce171c3sm125533135e9.8.2026.09.01.21.37.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 21:37:56 -0700 (PDT)
Message-ID: <d41a6ac9-86b1-4283-baf4-78b5df67fe50@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 06:37:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] hw/arm: remove {arm, arm_aarch64,
 aarch64}_machine_interfaces
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
 <20260901202043.26532-9-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260901202043.26532-9-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDAzOSBTYWx0ZWRfX+HchdzorJNiX
 mzWEcOPU5p8Ur3MMF3PKFkRJukmWWafnGodbjp/Ac3e4YUwqbX1F+2WiMqAa5SiK1aYYhRxtGJG
 /9dSlevGKS5yVpe81MMUuaNsGkTnXUkJpkPkpOO4zVUFNkdedtgxdJhXaaafOXaHtPKhiAbpW3+
 5+Qv0czPjnAAV133Taa0K6vFwfMKHRfNWZ9wizdexNw9TyFInqWqinZFG2B95g+PlDg4PnDKhig
 5m9jLSM+sK3dmrIcIx8Pok1XjZ+caUbRzCB9uqBYRkCZYSd6BbJa1v6bI2xiU97AA0W8MdxlQtt
 sGGM9gqLdfMg6UVeSpL3Zg1gAq4XpqEHZ9d5nFHS0YxMkVjn/vQiobwftZg4IIDYEDa9ZyMtaCl
 cM2n2M5UUxguepKCSEDeQWbuB0KPfUG0GL3/dHD84GHb/vPk+KtMQtL4P+QQcFEVJaHPta+TSqH
 5NvmebmkxfSNQrXzw5g==
X-Proofpoint-GUID: o3hX-uXemlu0MMw4aii1cFI_g4zAzAa0
X-Proofpoint-ORIG-GUID: o3hX-uXemlu0MMw4aii1cFI_g4zAzAa0
X-Authority-Analysis: v=2.4 cv=Re6gzVtv c=1 sm=1 tr=0 ts=6a97a825 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=JgGFZziSFi4rzet4RtMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDAzOSBTYWx0ZWRfX6sIpyKuPdIfY
 5+oVWoWQSdp0Ql7ptkk99bZMb/1Cui1h+0jGfRoFfLMK0R2lwiCejoN3mMoaB5ogJ7I8pQ44GWm
 Um6VeHiO+DIQvdqWr8yvgO8oQzZRnO8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020039
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

On 1/9/26 22:20, Pierrick Bouvier via qemu development wrote:
> We can now remove those arrays.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   hw/arm/aspeed_ast1040_evb.c               |  1 -
>   hw/arm/aspeed_ast10x0_evb.c               |  2 --
>   hw/arm/aspeed_ast2400_palmetto.c          |  1 -
>   hw/arm/aspeed_ast2400_quanta-q71l.c       |  1 -
>   hw/arm/aspeed_ast2400_supermicrox11.c     |  1 -
>   hw/arm/aspeed_ast2500_evb.c               |  1 -
>   hw/arm/aspeed_ast2500_g220a.c             |  1 -
>   hw/arm/aspeed_ast2500_romulus.c           |  1 -
>   hw/arm/aspeed_ast2500_supermicro-x11spi.c |  1 -
>   hw/arm/aspeed_ast2500_tiogapass.c         |  1 -
>   hw/arm/aspeed_ast2500_witherspoon.c       |  1 -
>   hw/arm/aspeed_ast2500_yosemitev2.c        |  1 -
>   hw/arm/aspeed_ast2600_anacapa.c           |  1 -
>   hw/arm/aspeed_ast2600_bletchley.c         |  1 -
>   hw/arm/aspeed_ast2600_catalina.c          |  1 -
>   hw/arm/aspeed_ast2600_evb.c               |  1 -
>   hw/arm/aspeed_ast2600_fby35.c             |  1 -
>   hw/arm/aspeed_ast2600_fuji.c              |  1 -
>   hw/arm/aspeed_ast2600_gb200nvl.c          |  1 -
>   hw/arm/aspeed_ast2600_rainier.c           |  1 -
>   hw/arm/aspeed_ast27x0-fc.c                |  1 -
>   hw/arm/aspeed_ast27x0_evb.c               |  2 --
>   hw/arm/ax3000-boards.c                    |  1 -
>   hw/arm/b-l475e-iot01a.c                   |  1 -
>   hw/arm/bananapi_m2u.c                     |  2 +-
>   hw/arm/collie.c                           |  1 -
>   hw/arm/cubieboard.c                       |  2 +-
>   hw/arm/exynos4_boards.c                   |  2 --
>   hw/arm/imx8mm-evk.c                       |  2 +-
>   hw/arm/imx8mp-evk.c                       |  1 -
>   hw/arm/integratorcp.c                     |  2 +-
>   hw/arm/mcimx7d-sabre.c                    |  2 +-
>   hw/arm/microbit.c                         |  1 -
>   hw/arm/mps2-tz.c                          |  4 ----
>   hw/arm/mps2.c                             |  4 ----
>   hw/arm/mps3r.c                            |  1 -
>   hw/arm/musca.c                            |  2 --
>   hw/arm/musicpal.c                         |  2 +-
>   hw/arm/npcm7xx_boards.c                   |  5 -----
>   hw/arm/npcm8xx_boards.c                   |  1 -
>   hw/arm/omap_sx1.c                         |  2 --
>   hw/arm/orangepi.c                         |  2 +-
>   hw/arm/raspi.c                            |  5 -----
>   hw/arm/raspi4b.c                          |  1 -
>   hw/arm/realview.c                         |  4 ----
>   hw/arm/sabrelite.c                        |  1 -
>   hw/arm/sbsa-ref.c                         |  1 -
>   hw/arm/stellaris.c                        |  2 --
>   hw/arm/versatilepb.c                      |  2 --
>   hw/arm/vexpress.c                         |  2 --
>   hw/arm/virt.c                             |  1 -
>   hw/arm/xen-pvh.c                          |  1 -
>   hw/arm/xilinx_zynq.c                      |  1 -
>   hw/arm/xlnx-versal-virt.c                 |  2 --
>   hw/arm/xlnx-zcu102.c                      |  1 -
>   include/hw/arm/machines-qom.h             | 16 ++--------------
>   target/arm/machine.c                      | 12 ------------
>   57 files changed, 9 insertions(+), 107 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

