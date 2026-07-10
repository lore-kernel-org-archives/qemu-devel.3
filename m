Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4685C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 13:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiBQ9-0003tX-7V; Fri, 10 Jul 2026 09:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiBQ2-0003tC-Vf
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:37:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiBQ1-0005Qf-ER
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:37:30 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AD5umD969033
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gTsW+0DajqGNV0WMB20q1y1f6fLmLWtEIcN+wk9ygf8=; b=cwfqRNkFwPiuWsYx
 ej6mL+R0Aheycuka0R9ZifMEbpRAKt5r8D0oVfCvCWKrOx3bPfBiB369pqI8Rgs3
 DFbMzxRNeNaZ0R8v4rYrPm8qcDOiuJvR5NceFHKhqO3X4QjXx6OQ/MFYx2VlxSdb
 hQsmE5EZXtzAXZcUV3G5sQbHPfLo3QdCBXw81GS5cmqULVoz/aZ8zfU73vbYphTF
 KRlVmpHn6+Z+deraiQpQnz4wk4vDlDpMsJOrnWWHwc/92h63LZnRTB6FCI+zA2gO
 98qDOfoNuufnZ6FDOglF0M1pOxKRVhY7W7PlLJw6H4SA4JDImqg8s7t3niFs3X0F
 ViupaQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeg3mp2x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:37:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1c7f135bso16738911cf.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783690647; x=1784295447; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gTsW+0DajqGNV0WMB20q1y1f6fLmLWtEIcN+wk9ygf8=;
 b=WlzK2jAft8YGwyXYK/Td5L1RAHK9sE41q2rJhZadPF9v7T6YDlfKOG48TJL+4xYyz9
 A7UjZYYhL+i8SVh3ubrDdGi6rQrARfVl+DQUT4ERey7k7M3H6UFdkQ+/k3k3hw8glZP6
 9sZBpXLlaZmlSIUrtaTW83qrmezdGMOJF/GRbEw1xynii+pI9Y8o6dQjoJx9B6OadMoY
 dg7q+/fmMAC8mkbZiSS+3a82ggZ7ct43FbetrZx1Wq0WkYE6HiE4Gguffl3KNQ2WleZJ
 I+5um7VN3HIoffz8E3yi4VzCd9eYA7QXSscN4f+1zGEDEqrzKcLPuCrR3PkdLZ0m8Ekd
 iK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783690647; x=1784295447;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gTsW+0DajqGNV0WMB20q1y1f6fLmLWtEIcN+wk9ygf8=;
 b=qnssEPGXqO8ugyHU4h5Se3zgHBPettGsOARBQsirE9veFNtXfWrO48Hef0PaYFCl5m
 mBQJLZx+zbEuGHkuEWdUqwHkzSSzYZePc3BCcEwQz2mSNE4E8zRfLefDwWPd+pQN7woZ
 jsJHHtGW+en+5aV+vHDre4nscHHnwPn6kSZrjeKwZ5gKW5xxnLKY0lf/ZYpljMMlvpMq
 r1EzRWyFoWY0KNF1/R0WHjHG03Tt/I5Y8Q5/IVOeuoyqSYxPVlaC1ynnJK7BW+Os/P6x
 ebk96dKOYqyvbJoH2u+1BFxbC6XJqMvXOKS1VPEKYlKIIlfdEyTjsCTjBpUifno2r84q
 5WxQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpntQP3+ic2HjedXGtIq+UcDEhxoY1+rjkGH+fpvl96nrYzIPJYIYCzZY2FLkn7Wjb9vKJe/QGFaXQf@nongnu.org
X-Gm-Message-State: AOJu0YyhVrj7+fKoMWj4YT6TBpLW1gXN5YiGxpaACHXiY7JxRfj9OvIE
 2IQdd7O6lkJXOiDOFD9pA7a1Kz2fK0HXoo5JhWXJBjrrZo/YiXCljEGB2SazsWmOs6MP9wojmFg
 TlWPhOSFa4fuuTgiXxNOiB00kmER+B5ClBPZxGRPqfEu1bRxn5kE1bdYzcA==
X-Gm-Gg: AfdE7ckUFivHDsbyuDwW6vl+Y4cWRmubdZKVUPgau5AR5FN3yrwWN+MoWLGdD8nI64j
 qooh7API/029WOL0lUF7gPoWAXaxMZ45H8tSW7VAVeLClMcrS9+2CLJjL1qNT4scYrXarX3bVC0
 budkkehN0v195BB2o8oGCpYIzW5b7xN76wEtNIZ0EgUukqRSKY22rzWIGXceNsgtRonjtUMUtiR
 61TcKe+P6leFIibt/XQBaPxlf4aBwnI2cN5Qq/wyO0ooxi82PHnnePr6hjFb28zlYDM/avLDCDz
 7KMvMuAD4UFDUY+CWcdvUPsE5qlAvYry7za1M6ihw8L6NI1nV/yesSUqOjQPS1Acz1gqNwuI/Mi
 JHr/wOAdPPJc3FSZO+yxhrsjhKLtHxogCbqpy9BLnGrOgtcu0u86EW+wPfr5zJg==
X-Received: by 2002:a05:622a:1811:b0:51c:15f2:4bd3 with SMTP id
 d75a77b69052e-51c8b3d432emr123998081cf.22.1783690646751; 
 Fri, 10 Jul 2026 06:37:26 -0700 (PDT)
X-Received: by 2002:a05:622a:1811:b0:51c:15f2:4bd3 with SMTP id
 d75a77b69052e-51c8b3d432emr123997781cf.22.1783690646332; 
 Fri, 10 Jul 2026 06:37:26 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039af67sm67998785f8f.17.2026.07.10.06.37.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 06:37:25 -0700 (PDT)
Message-ID: <4162f17d-c91a-4e59-82e4-d4c1f590396c@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 15:37:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] include/hw/arm/omap_dma.h: Move to include/hw/dma
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
References: <20260710105907.2570621-1-peter.maydell@linaro.org>
 <20260710105907.2570621-9-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710105907.2570621-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEzNSBTYWx0ZWRfX6vY68Si25SKV
 jChfH3HLHvMQGUhqi3QJGtIIrzK7LARdLANlFmfcvfLIl45IEGAQUjgdZAbVxAtGQdQCzK/XIUp
 xPaHysWn5nnaAX/7OkNyNGzI07kQ9h1psnkbxor65tx0eGFHNePUzXbjQB6RUcdQY4U7mRmSmxb
 wtDcA/OyKKmCoPYjkt+P/kBlhfCcioXvzuRgT5R+vNatCvvM8GN8JnWP1KFicnCHgcRjPit4CE0
 xl5TJV3EoaE+lV/9OYkfw7z8CBJkKmRWxSC5UENBUGolQi44x1al5bTmWmdrn0oyVQV5iNly3Bo
 jaH8qd44rr1FAt4nhpOfgUBuk/LXmLRm5mFFC+pFORPM3STcL/U2o/UpqCDUmuCq3w8f14IX5Lx
 N1Y3yf7Yrpj0RasCJWOhZ9f6zHFOk/dOk22mWXwKDABiAbTo3kaero3+pERxMHOD6p8FNDVp87d
 B6UX/CfEaHQ1HZEE2Lg==
X-Authority-Analysis: v=2.4 cv=ZcMt8MVA c=1 sm=1 tr=0 ts=6a50f597 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Aj_Y6IE_OcN_L7gj-gkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEzNSBTYWx0ZWRfXxreThJ5aAceK
 xrjygg9vDYYw/wCibmJedBnurAytjEji4eNBgUviqd/NkhnQ8Yxt4jnCe51/lwm0V9GG8cfulCA
 Y+dLlfokm/qI/rAq5zVpTadvjxsl1RU=
X-Proofpoint-GUID: pGvsnjZAAU6BtnI0pQPDOkkLY1bkZT3H
X-Proofpoint-ORIG-GUID: pGvsnjZAAU6BtnI0pQPDOkkLY1bkZT3H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100135
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

On 10/7/26 12:59, Peter Maydell wrote:
> omap_dma.h is the header file for hw/dma/omap_dma.c; it fits better
> to put it in include/hw/dma/ to match where we have the .c file.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/omap1.c                    | 2 +-
>   hw/dma/omap_dma.c                 | 2 +-
>   hw/dma/soc_dma.c                  | 2 +-
>   include/hw/{arm => dma}/soc_dma.h | 0
>   4 files changed, 3 insertions(+), 3 deletions(-)
>   rename include/hw/{arm => dma}/soc_dma.h (100%)

Per the cover letter, "The omap_dma device is the only user of
the soc_dma code", then maybe take the rename opportunity to
name as omap_dma.h? Anyhow:

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


