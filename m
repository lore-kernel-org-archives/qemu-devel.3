Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B84CD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 08:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXENK-00035W-Eo; Wed, 10 Jun 2026 04:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXENJ-00035D-Dp
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 04:33:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXENH-0004uE-UY
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 04:33:25 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65A7hk3f530226
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 08:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xZwMrQ9cJwMlOF/+HcUoi3SY2nB0zh1dHc4plVfTG0Q=; b=jDmRbuKtPmPX7dyx
 1JYDzDak2mfQp0aCBpaJiMRicn8tC/hHAogr9gfi0jhLbFcl1Vm+8fh5I0PKLbb5
 wJeSirKdXaY4e3+G5qbpx0nHm4/7vEa8Fy7QuneOo4WQHBB5EblGkBg/xQXVRDhC
 o4vu0TwSTPAeWoniCKgZIknFXFDINkwxlJevpGo1mviVUHzVgtDvb80XjZWUYDR0
 N4jFmzl8OxKDOEnAKhxq0oSi1+3IcBgEaK1QykVuYoirPMJ1nx0jTHYD8SlElkdU
 EFFFOQx6EXbQLU97suOql450gWL574tCwfIlXDXbX+M3GqfayRQ699/IdiTnFKSA
 a6jKnw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epwr2hgen-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 08:33:21 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5175a1e32e3so176396011cf.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 01:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781080400; x=1781685200; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xZwMrQ9cJwMlOF/+HcUoi3SY2nB0zh1dHc4plVfTG0Q=;
 b=MDNiTGeQrrZ+ccXgQrjRtoFX07TMoUb11JOIiw66VO3TVjFiixnwhSqkn17/iTelOk
 BKhEyfK4HmxXrqy5DKdf7vW/cciTNgEcoUTkoPrOYPlLleIyPFSpqBDcXsvx4RyyhASP
 CVprqeZk/iLuif71MJCldaWpTBLBkWUKouX+KDASLfyzfFItjBbh/+NAnRdCS5MlJ93q
 cA2QIvItSD5YNCRivSy8BuQKJI1HHFOXFz90vn4BK4jcKRCy24pkl4i5a7tWyDMJkpwu
 fvyEsQMkKE2erHzlcwylcywnP7XbjhKT89qadAYYzYp0/JJYugVrr3gy7w2TClAkcpBC
 Is5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781080400; x=1781685200;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xZwMrQ9cJwMlOF/+HcUoi3SY2nB0zh1dHc4plVfTG0Q=;
 b=By8eKXPAUUgfF16D+TfhEwYYu6zynXEUmXHgFCbb65x0jBF0rdXGPY6bamKKsxM+uY
 3AvN21alJLSnOV9g1OPX4GbOe95KlwwKUDpRdPyOl27e0oihO0KDI/vFhV9sFpu14VLe
 xDuas/czST1f48w8rZuLsJERc8Ihs8n6fCaH5l6ZFu/DyWLKNXa9n8OwzeoUOO7HrUas
 48K65VV2frMJJ99dBWe73awj3Z8LFhaznsD/n8F9d0sh8GGT9FW0gWAb7AcQeSBoulja
 9si/VIE4D9fF4/rWCv0myEg8sBy6NafmVjqyqRYgMnxEr8gN0YQ8gJw+2l7PEwpsm1Uy
 UAuw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9iNo0QAdnO097YiyeKwY9HuQG4cnXAZICJzxGjkkNKHYlsj5Mo4zJ7jr0gAawsZOidEfwwVw+uGjcA@nongnu.org
X-Gm-Message-State: AOJu0YzPAikh1g7R88U0zXG+fb17EnpZ7NRVFXoAXgwp+8CSjc7giZx0
 jvAZA0xfDiiTFGsaRo2aukikw6LZF3SUGIp+//x4NBGAYplSMBbdwOSz3GRtLMl1AGwVCmEQ2SE
 dAek5qfej4CVGoSj2yd3EbBjSrj7W4QwvYKaPSjdMW0TfzPPxzAHBCJD/3A==
X-Gm-Gg: Acq92OG7HItILif9LntYyHl83CIxiA+lY/fKw9j8NOe6UsakSPBwJ7meA8iLS/QXuLC
 Mii0ApHdKLoAQLlZZ8MtaE0j5ygj0hkLdP0wriHplAKK9TGNiFDqemeq9PRmVG8BrS3HrX+BJoK
 l0IlG9tIac8JgWdae7lDI6NZEHrmBrJbUdoDVaUIRXcsdhxlK5izyyi4hAEZQ2X61YJIxj2oSt3
 p8pFOi7qzwdcYNt3bVf6bf85j8wH2iDAmLOwbP1cpMaqYAUHoIndi8zJKcGropggK8+nUT12yNN
 G/NkHF+yI7GKNtJ90BadIWFdqa9kfcoQgqjVZfXm4aWCviSM8FMOnH3NLpPmgBc3MvUuJHmaSW6
 laASshPurOurW/M2wp7NOS7hp+2IeRcDIAt0uxhN+uL3gvPjFXj5TXvYUQ9QhZol2fuEOJviFzQ
 ==
X-Received: by 2002:ac8:5755:0:b0:517:899b:7f77 with SMTP id
 d75a77b69052e-51795bfa2dfmr358393381cf.27.1781080399991; 
 Wed, 10 Jun 2026 01:33:19 -0700 (PDT)
X-Received: by 2002:ac8:5755:0:b0:517:899b:7f77 with SMTP id
 d75a77b69052e-51795bfa2dfmr358393021cf.27.1781080399579; 
 Wed, 10 Jun 2026 01:33:19 -0700 (PDT)
Received: from [10.156.84.244] (49.170.88.92.rev.sfr.net. [92.88.170.49])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6915a637180sm5618699a12.26.2026.06.10.01.33.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 01:33:18 -0700 (PDT)
Message-ID: <7ea81b3e-df34-4f13-898d-26879019c33f@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 10:33:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/27] tests/tcg/meson.build: introduce wrapper
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell
 <peter.maydell@linaro.org>, Gustavo Romero <gustavo.romero@linaro.org>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
 <20260609214745.772536-16-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260609214745.772536-16-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Gu1yPE1C c=1 sm=1 tr=0 ts=6a292151 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=YLXAUxGLE6hMr2F5uSHVqQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA3OCBTYWx0ZWRfX+k7c4ZamC6vs
 NxwTn2JY5egU3Gresrl+4HoMeCoMLL3HARVo+UvWOAvJSYVdqa1fU4SPS6Rv6iVHcdpwRnAuHU9
 lU4qwLWkIh+QjsBops8TDI5GX4jhxkJKChW9PfvI+J3ZDJFC6Dt2gXCGbnPYnv2U/pch2Rp4PI9
 bEekvG6CIn0XISNEORJpyE+T8yIquohyGl9cQpI3vDUc5ufKrwlr4r+sAPgfKUiX8AvXtLTBB9o
 I7EyuVW+54Y3fSoyQS7wADwW/KWK0Y/Z2ji+x9i6EY/Si85cTSyEgtv/iRMPfIN6M7BXZSvCtd3
 fz//ISZ5uO2ArWZ8KLxoaOZNvPXg6yEcxUAOdlhOAlgQOKZ2zgjImyF3UjQAhoz6H6CJt35bVbi
 gTCwmA16ruqqeEyLcAQ2rPW4P+69UNDfxJyyds61mZ71IE77Gqms8eoX4hwoeb39CEAPwCFihrI
 GHzR35POenL2Mkcd/9Q==
X-Proofpoint-ORIG-GUID: U7ElGJBo-LetmmUVYMV9E1qbN4nDUNT5
X-Proofpoint-GUID: U7ElGJBo-LetmmUVYMV9E1qbN4nDUNT5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0
 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100078
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

On 9/6/26 23:47, Pierrick Bouvier wrote:
> We add possibility to wrap a test command through a given script. This
> can be used to provide any kind of ad-hoc check for specific tests.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/meson.build | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

