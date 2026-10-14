Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961C9CC6B2D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 21:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH6He-0000qL-T4; Wed, 14 Oct 2026 17:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH6Hd-0000qB-IX
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:13:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH6Hc-0001Ia-18
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:13:09 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbRsn3813096
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:13:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 M8Oq0mhDsqF0uetwELUfiZ4kOPz6VQYCHm6DIxo5be4=; b=DbsI0Jkp2mBwVQVT
 P8g4l8b2WDTuwd19/0fZavZELgMfwnv0YAeojtBPd6+hjLF13x1wXVhSi+CSi9aN
 K/3nk93aLFL6Y4wOZwwctaJ08ukA2oIs0JS88JVe2wznJ1XnfBkih09VPfs/AZPw
 gDbsk4KtlV7+xqRsb9veCdpxRteitmFkRG/Gs+/rvbRsOeaY7SEAg2LqGxzhxKe4
 gbsfT/HMj6JczZWK8I71uPhdnBvTml5ZJJAbCMf3plvRQue4AZlz27a7uf3DpcCh
 GBWunvjgw2+ZJQ0+fq1yI8BDpJzHp8JKClWlnJ8AUE0F35h07Tc3MwWjoIvm37OT
 ijNM9A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha46u3jh2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:13:05 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3515266f6eeso2571692eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 14:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792012385; x=1792617185; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=M8Oq0mhDsqF0uetwELUfiZ4kOPz6VQYCHm6DIxo5be4=;
 b=aDDT098jJ6kw0fKqN8FRaDMP2BDTydhVj2m/FX4/UWKINtqKMBqfKwLzFjee3iUBUO
 +pcSv/dAmyU1QEaEK+N/cFxVFpBCTsvcFBT7d/+cMT2YAIzi/rfcPDmp1XOJqC1xD32V
 Y65/Fg59BzmW6fSbFsJ6Z0XPvjrbab8ZzMpFiGAdWgMN2lJR1PM//quXvVFaYdj4xdrM
 KZjBNb/t5YH4K7c3ffLNbGteHkVSBWtGTCmUpimZLm2z4YYQZVMgAL+vbQ28oIC3EbmF
 WRuQ3TdfSdnjkl/ZmuGlbrULJivi07Wtr+LD65GQg2wpVQ7EacE6CFRV1Sx1xtkbUiZR
 15NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792012385; x=1792617185;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M8Oq0mhDsqF0uetwELUfiZ4kOPz6VQYCHm6DIxo5be4=;
 b=JXI/6mlnv+wuMsJPMfhiC99VuhSLJv4Qbj3tI8/wDUnYdI15fV5LKDd9qHfSqwepwD
 BsJt5HWV7dCW+/qqM1rS+0rVEI+vnnRqT2Yk7pwSeDCj4PYCr2sScSOR8ZLHveMBQn9A
 IZJ01neAy1uzsqAqgVmtTZyGG5PfC2xKH3nzRTd3Zqfu+l/D+cq9TD4xHnCvq5Az9btX
 sUQbFI8zDeh1voyI6yuSQ264wEhPYgyx6vrfDaK6oeVSGu6ZkHrK5853jsUVmiO5TneK
 zLv9UkiQyfvs3LR6v0qMaCMLdwEiHf18/yz0fJbt6uvUzf/RMu7PsOhGauFwBD6VS3r/
 BMHg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSv4RgffVMeeG7ox1N6lI/YEgrRL1gmP7Gp7IUNMzdmKuZ9+UMzQK4cF7e+CzEtS2yBD/1vctYucFI@nongnu.org
X-Gm-Message-State: AFq9FYJAAiyetWM4KXim/lUhEVbzvdogb1l5FZQzeIhWDCtfkJx0o6Kd
 jkK57KC0NgjzGZHFsEk/csE09K09ctP+P6hJDT3wt1YFKpc+hAGoarSDnOs6JdgpPoy/YoCepX8
 s5j3w88CoSEcYRc/IO8sWJAyX6CiSS10sHJ/IycCeiiDU2ZF2ewAjLo6D0w==
X-Gm-Gg: AYBFou2oudT9HVMG3vJ+svenhi95SbLDAXoTHTpFQQ503tREJttQVt6ZkU6u2AEqtba
 8saHRsIqDQq+Vz3x2oWXlOhJsgJ/Wjj/585zneNna9O+JaDLcaH6hx1qPOvtLEmvyzyNAEErbEY
 u9WFoqR8rbZymziCqrvTlTDxE8inD2l8FNLwWq2pe0TXCue8xQm0IyY6sZ8RANJfPAFc6eWTVS8
 Mx5XOlmrZix2DvLB+7c8ttHtcPdhb50H3XLhpNsPTbRjVdTmO/UbxPe17N7VLUZVxaphx7GLjcp
 Blla8RZzUrFG0OSXubm3e1ziAO0GVjxtRvHPDPNqMix8645Uifu80tUILgJCW+Uih2TSqRyqBIM
 1h4cNiYzJyNa9m2CZuvXVnKbmqb39XIO12/dLLp5pUXrItKmoceoY1rleS3s4nliBb/KnpQ==
X-Received: by 2002:a05:7300:d18b:b0:351:1e2e:da4d with SMTP id
 5a478bee46e88-3537e0bdfe0mr24257986eec.23.1792012385056; 
 Wed, 14 Oct 2026 14:13:05 -0700 (PDT)
X-Received: by 2002:a05:7300:d18b:b0:351:1e2e:da4d with SMTP id
 5a478bee46e88-3537e0bdfe0mr24257963eec.23.1792012384508; 
 Wed, 14 Oct 2026 14:13:04 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537c841648sm62639754eec.3.2026.10.14.14.13.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 14:13:03 -0700 (PDT)
Message-ID: <3d24a9c9-acce-41f3-9d3d-ac35540212e6@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 14:13:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] target/hexagon: add vsf* instructions
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>,
 Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>, Helge Deller <deller@gmx.de>
References: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
 <20261014195223.3233623-12-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261014195223.3233623-12-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfX6mAfRQak/T0k
 iXfrDujeGXrNJvivtARBFs2+TBTMwyYw5W+k5Uj6I32BAAMWKUgBBok9c/4MoGAX7jB1idvkIzd
 OQg5wX0hvUPT5aR0X8ZYvlVQgA4XJLo=
X-Proofpoint-GUID: gLiQpXs-gCZwx6M86yI1w8Omnh4a_c7a
X-Authority-Analysis: v=2.4 cv=Y6ttIReN c=1 sm=1 tr=0 ts=6acff061 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=g13S2Zp8ICRfDkLosdsA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfXz9h/bw/ujPiS
 ewNRYS8iJzAlnjqbDg0/P+bynnfr+1lw6YrqwThFwLNOevJAK0yIuYeA8fqYlmorXYywSJY0lc6
 Eygo6cb34qsb54OfUeNOFwCNoUVsjUP3uZwru2e8dE3K+vUTE8m/U7YPrTEevTBwjPlSeXXiX7m
 0biYPv5xKie+FgfzaLW6gZRFzd0Hm50jiEBKhuxjFhdeFZ5NT25X1IykFyiorTcwJGxQ/jf2B4u
 YM2YX/7w4MjSMDoBD9qTRPJ/Lf9VxRP7g/rXv6dS3vMrMj4QTO9DNepUc51szzpHDTRkjfrlHzY
 smZfdK8DAKD5pZ467vcQRETyw7JcZH6NftO3uEAUUTyNQFAArP3/GT8SIEMp+vbIV2n1rf3JvtC
 QCYXA6zR0VGkq6LNINA+t+IwHocBSZk+bus+p/c6rHlFtMAjtL6/GImxTvY/9bECGlUW2qouPQn
 nA3k2ZwTJqYo4GzIHPA==
X-Proofpoint-ORIG-GUID: gLiQpXs-gCZwx6M86yI1w8Omnh4a_c7a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140084
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 10/14/2026 12:52 PM, Brian Cain wrote:
> Implement the v83 two-lane scalar floating-point arithmetic instructions.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/gen_tcg.h              | 10 ++++
>  target/hexagon/helper.h               |  5 ++
>  target/hexagon/op_helper.c            | 73 +++++++++++++++++++++++++++
>  target/hexagon/tag_rev_info.c.inc     |  5 ++
>  target/hexagon/imported/encode_pp.def |  5 ++
>  target/hexagon/imported/float.idef    | 49 ++++++++++++++++++
>  6 files changed, 147 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

