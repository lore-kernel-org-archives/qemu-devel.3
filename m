Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CB5C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 10:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm7TP-0008Nu-TS; Tue, 21 Jul 2026 06:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7TG-0008Lg-UN
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:13:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7TF-0007wM-CI
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:13:06 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LA7FI61564219
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0wqNTjwJgXxZ5gzIDaR/Voh3+T0rduboCnjjnb0NATw=; b=XsF/S2NI1YYT/atv
 bE50uVqoVDuVdw7b37rl97EKTvOZ5qaKHHU0KU5XlpNBZgyuzOtFoVcdxwf/fyS3
 vuFeScWArFmhNWoD0mBVoQODycqWf1PPTasFgGempPBPhRUStu3vE3CLz8cjyWwl
 z2JcdyHcr0tjNiatPvtS/jr8xuz1Glh0L1QUPFH66vi2UI7ab2JRMHnqdeaPZp+9
 x3vdZ++sERU278jpQ6Uihr9ID969T52bY+4GGNypYPYFtdA2ocfz0ODMgqPxtj9y
 8FPw0HECeOhlK6ZTiTQXwdUKzQZdo8nFfE4G2NLRO8nnb7xDelpsGjPMhL5qypQx
 nu8F6A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6r3g0ss-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:13:02 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c01ff996dso86708061cf.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 03:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784628781; x=1785233581; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0wqNTjwJgXxZ5gzIDaR/Voh3+T0rduboCnjjnb0NATw=;
 b=j6wqLroG9Yq0PKYKMlRZd+nlStXRU44A6jrkTGOutuu7ftqF5YPDizxwVgzV2eb0uS
 ZORf9HBuJw2U/EIxwLz7Zuut3IUVfU6dl5V+WYgMbkeLOa3uwZIHC0Zeba89Ghr7uddw
 GZ2a5228sqA5acOemvwxcT1dW3tEfiSd/cK92DXDARYIuTse1owbj46W/e8S4o80lzUV
 Y0UQuMgVYV1iHjLi3WibQTflF5qgJ0IkdTv5z2Opt40htoHEZmR9DBtGg13AN0wzw/9I
 FTFqVlOverwly6dr5Q5hbWPTOqUvkpGowmBxgsyldwaBiUhdMwsRu7bXGvaQ0K0Qvoxu
 w12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784628781; x=1785233581;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0wqNTjwJgXxZ5gzIDaR/Voh3+T0rduboCnjjnb0NATw=;
 b=EY+/TtZV8lmsiVJGzQix+omdA07gBk3Z1TG0x90ZWyqSiVxC1pnTzaL9KAKSrwBDaz
 JWp391wSZjwEsiTchyYE0dMbhrXoDHmlgHnJiMXabwAJV2DM0Qo+8pDvfMUepYWI2TUl
 d/9dtB+pgaLfButms4KbK/z6uBLXsJo8YVfcNjPsOSMYlgi0GNbaT9Z1fldr4LdFDnKi
 WuHCISfYiKfneVUjSITxi9+bAYQLsSUZ8Rpx73M7pFftxbCDfgZm6/A6Zad23Udc/SE8
 ZqMTyVJEiCN8VVwLWYW8q09Jl6eQLNyjVkyKaYj72IVz1VHHAmZolr72q4v5hou3c+d6
 Q8Lg==
X-Gm-Message-State: AOJu0Yw/XmmH3dL7vES3+9bKTSWlPVFzGmGIVPht7m4SCAknuyyGD891
 gkZpF2F6BHqrukC9MAEoEz2WWp+uIhFMjLP5QGT6eV0nX/4YqqdZKoaPf5WFn1t1JJDktxMWJ/V
 1dWu4l4yejvQa/ykTPl2mQBmiseGnuAEkfCK7yorjM50FraDC3oyUn1gFhg55W2mr8g==
X-Gm-Gg: AfdE7cn2ajn/q61FCJKqEMwUHMJYKeFObPSQKIq8XzFOHo2z6B7mtsvclH7YBdtEBsA
 o5OeB3tYRsQ+CyvYkDnrTjec/x6OPPmU5T/Z1JdT4YWMWD5R//0RCyq3xQkrqpTZ9sQlorH2E+i
 vYckxum4Tl7fdIaAdZ+i9F8YC3LOD6raBkIQcDDFuKTF0MtPmVkx5ZJURe6Zbf+rVvHTeoS0rGo
 Qez0nE0J7jAqTGRCzfZelUL8zxY/nqgm6RUMcDVlFebu7NVevce1YyrxYTtJerXJr/O6P82Hl/M
 iBE6gNRYEMfLHPGVP0g1z6Lo1JQhKvo7+x8mttviajuAcJRy77qow2Y+yAQzIXcHxXVw8Qc1uHr
 7OjCz9zAFcAzFC14o5dNQVz1pT1xj78tTBweJJrOGnb367dag6I0=
X-Received: by 2002:a05:622a:229d:b0:51c:1634:effd with SMTP id
 d75a77b69052e-5213c013f4dmr156092171cf.15.1784628781476; 
 Tue, 21 Jul 2026 03:13:01 -0700 (PDT)
X-Received: by 2002:a05:622a:229d:b0:51c:1634:effd with SMTP id
 d75a77b69052e-5213c013f4dmr156092061cf.15.1784628780913; 
 Tue, 21 Jul 2026 03:13:00 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f6fa848fcsm27526783f8f.0.2026.07.21.03.12.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 03:13:00 -0700 (PDT)
Message-ID: <71f8fcf7-4dfb-4ba3-8b03-c891ed4e789b@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 12:12:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc/applesmc: Fix a typo setting MSSD key
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-stable@nongnu.org,
 Matthew Jackson <matthew@pq.io>
References: <20260720115336.75063-1-philmd@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260720115336.75063-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEwOCBTYWx0ZWRfXyAooRxsFnIYP
 ZcOD4Q4bL4bYGPiV3XQkKbFG+LbL1N6fy0plX+Bm8NlupWV84tX57N/d61JitnUAIapOBANlVD0
 XJDL+DAExKj4JSz1d/KCnQ4faPSWkVa4/FMt37zK8+ZvV/Sb5YlfmqLV9/lQ460DjfbklitdbS1
 5UliGUMKvr85eM11OCJ0CkUk+KaY1RZCDeKBOZ1mLCyVLphoM2BblY9kTqEGglBVRT95smH4XY9
 GupQytHuEaKw8GDydXjo4v5cOdDrEOOPqcko5Bms24FRCXA/oUKdNFPKCIfXqPxCLkrCvZSe8FI
 VDi9qSKc7FLNB2eVwgVw3wtRuEH7FcdFyzj8kdcnlVqnXOtajVMj32QWQENaS2gxDYdD9T4R9RA
 thH3xMcpaTNSXJGBDDFAhFXABI3TvGr8hjJgnn2egOsNcnweSsGALnf6uBXmvGmseyYvIZOwql7
 QO5s4+Wr72FEHO7Mbbw==
X-Proofpoint-ORIG-GUID: TsEiYKVi3LPInYP4cd_elyEhfLJtdqr9
X-Proofpoint-GUID: TsEiYKVi3LPInYP4cd_elyEhfLJtdqr9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEwOCBTYWx0ZWRfX9o0OthMA6S8q
 F9aWrp1hQhtLPslbPzpvSPQIXWRaEV4PToCparv/o7HbsZW03ra2WN4YXaDeGs4MXefl6jv+oxT
 RTxZAkQ/dCDP56QBIpcdIwKWfugFpPY=
X-Authority-Analysis: v=2.4 cv=SIRykuvH c=1 sm=1 tr=0 ts=6a5f462e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=qRoIxKKI5YXCHxYeohkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=dawVfQjAaf238kedN5IG:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210108
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

On 20/7/26 13:53, Philippe Mathieu-DaudÃ© wrote:
> In commit 1ddda5cd364 we meant to set MSSD=3, but due
> to a typo we ended setting MSSD=0. Convert the two other
> NATJ and MSSP keys to use hexadecimal notation to avoid
> similar copy/paste typos.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 1ddda5cd364 ("AppleSMC device emulation")
> Reported-by: Matthew Jackson <matthew@pq.io>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   hw/misc/applesmc.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Patch queued, thanks.

