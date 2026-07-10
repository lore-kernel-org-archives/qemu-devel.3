Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 002D3C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiK4H-0008T2-DP; Fri, 10 Jul 2026 18:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiK4F-0008SC-IW
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:51:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiK4D-00025h-HY
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:51:35 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3Ffr1621110
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:51:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 z/wVe3YuLeO+7pWs2arkCpV/LKdkrdsw/SVfaI+s3oM=; b=cTNhfpjM+tMhJhga
 qIkkPNqpIEul/lYJ8Z4JJ3v67dKAzkXYSX/xU9uarzSK/5FoGzEBUdm4N5rU/RpS
 S3G2eS7aV5h3cO7OFHtYwJliKLtN3nHatkiJEvs0vU+33p+SyNBj31nZgmRIRQ7u
 cV/9e1PEfAISW44dk+QMKYNwFL5iD4nn3xlYQrrUGNnTcTseul/SQzXiskuqXbHE
 wJQ4gkLrU3S1NrJnZNQf2gBkNhU8C9GqexuMSn+h4EdxpAwZxudA97T+0+99M7ya
 Rw8piLJj6YQz4MxdRDkijrMGl4Ktqhsn11gVS69y6gu8cLtRxCxS8jGyXyiVryn4
 vsMWpg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb4rm91a2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:51:31 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1a97644aso14718601cf.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 15:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783723891; x=1784328691; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=z/wVe3YuLeO+7pWs2arkCpV/LKdkrdsw/SVfaI+s3oM=;
 b=LIwihd6ke2KjBq6HSFKL8h6ARxMgQgkOjp5ylc8aX3UfVeuZzsKhk1dnZsvpwM0+Cz
 dYeXV9OXQ4+VG7MQTTJrDCMLcplBs2AwdkstViEpJXTXt4vlL2F6VlPqX9+/jBO4o7jP
 eSHYl40CftDz18tD7wDzqvqguTktr4AFJmrOZk8H3LNu8nIyn4wGe86clyodVgOWxGp2
 Tf9LUXLFUoP07aR3dOfXso2uIZPjQhpNmmXy2wcgx0KAIxg9Of5LiVtECXIYNvG1QMYa
 oTpZMOSF0F41mQHyzlvuDAgzYmGSvMz35u1O3AfqLm/EqUm9G3zeN7rUnhe11TxWJJGO
 4CSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783723891; x=1784328691;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z/wVe3YuLeO+7pWs2arkCpV/LKdkrdsw/SVfaI+s3oM=;
 b=b/Z6259qrAkPV2x5+Rg3n8ATY7741wXQ9Z0UsIaeP1nKOr7e/iTbD9r2UkEFWHjVDY
 Qw+cTzVFis5Kmb0WqyZltkzZYaIIErj9CafcoI5jDFsIKY3gk4wuu4HFChtg9bQkxUia
 d+zODgw8BjB+uu1mL7NKxF7iBAu282qKXFwD/VzzX0u5gz/soaagnKXiBjHjq84Jwmba
 BNjn+Azb0mKipqXdp77GPv7ZNCM55E0WGgGNbycXWVakgreobMfJaIBBocS7P3RB0DbG
 IfYA6kIfCDaKE3EqL1Be6ip1HGGlmAp4KSlDxUhMdxiKgnpOrV29c8JFiA6zse6bWZeB
 AhkQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpOjHFh+HCvpwSeB49ifIHHKWvZT7gH0h39VElLYLmMrjWBRMzZlTirBu8LErF2yX+2ur2TPoLX2AFU@nongnu.org
X-Gm-Message-State: AOJu0Yx2RJs4VxeQuxJFr1wpl8bM5bN4fIyovPCiPGL/TU9wGGPKnq+a
 rRBw967ZK8+ssZznAYCQffwMSC4rwj6JyiRchr+4kv1YiTXHemeCr4Vwf2JAVMRDYnxupBf8xq2
 hM9J84nPr8FKYRHKAcKsHi90AbL+sBrEbUCmqVCfiqWAK0QpZPrpf79jlFZJ6DarxnA==
X-Gm-Gg: AfdE7cnEYdfAdNzcn0dVwGHYW4V3jje0BPpEKvRN5YoLj1bnVT97gM+QljR164mFx5X
 QkofLsVrzBdCCMpyVKtxRNi9G+5OKhv4yhSOgwkTywhTP8yJ8sqMyyO3rxf5mVMCbd4/xc0equB
 40r02tryUDS88sowr3gNykvoDGKtc/cSsLX6ZGFmzZmC6oKZzuZH9dOX09OoENoVNuIrBTSKbeh
 Ai9L2G4AHaToLuVoXwSLE3Ci+f5aYNcPLsjuZwzKb+DeJAeciaEKEa/Gi3SkLRkPH5eRNr7YFbs
 t6c5y/NfcXKPMl0mwIj9WQJJyCFEnwRcNqycnv3obfqFVqSlqgK2EdwY0yppokO+RJYUx144wcM
 JapVnIDu1DKNtGNxqY5EB3cvLeqAqcdzzEnLA3coi8tvHcbPYQg7nPNkjxlG7vQ==
X-Received: by 2002:a05:622a:8cf:b0:51c:7b11:41b3 with SMTP id
 d75a77b69052e-51cbf2eafdbmr8590371cf.79.1783723890978; 
 Fri, 10 Jul 2026 15:51:30 -0700 (PDT)
X-Received: by 2002:a05:622a:8cf:b0:51c:7b11:41b3 with SMTP id
 d75a77b69052e-51cbf2eafdbmr8590231cf.79.1783723890603; 
 Fri, 10 Jul 2026 15:51:30 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e3e2702sm68768003f8f.9.2026.07.10.15.51.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 15:51:28 -0700 (PDT)
Message-ID: <25c99b7b-7abb-40f9-977e-5fab68eb7c21@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 00:51:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.1] target/arm: Be more defensive for invalid
 tlbi_aa64_get_range
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-stable@nongnu.org
References: <20260710175818.528974-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710175818.528974-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: H1Tde27mtVNWmRmWvt7178Jrjt569dlA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyOSBTYWx0ZWRfXy0BSsdOoXcW0
 0miLopYUstA7h5XG5EV7k7xw4HejvGp1vukHt80tfuQUNukStkPMacZv87Lj4C4vobbgP8djLC+
 RObbAeR1++kdLVSjJMB9Kz6LIkyPgGUQHuU7nQzOCaYY3bA9LtNrYqJIxPI4fYKbabhn8ef5VHd
 sHPnIqeZ5JR8ZDTqg0ccEszbPtRQyZHM6/IpgfQ8Bi1z45DGRlfAs4JlYmECaw4AnhKHPcmP1Wi
 gm4iTczCUFT+ZnCTJ9C3zoaV8x+KOeF8o69cfyqealHFuTXOI9fsn/MU6o74Fqybm4zgqZ5FCQ1
 //dsyToDXB0VlD3hxT5/BVtm37HzFtUF1NkUzS22x94FvSKEGsnDnD+VfGcCpIiHcBvooNsQsAN
 e7t7tnfmiq+i4afeuEv6tvJxxecQu19Q2WCeVPJdtH/MiuYugnnCJkmbnL4vjDODapJh5Ab4fW3
 fxpAcpHTJOeOKr2vOuA==
X-Authority-Analysis: v=2.4 cv=JIYLdcKb c=1 sm=1 tr=0 ts=6a517773 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=VSasMQlgsk1z0BmcdTYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: H1Tde27mtVNWmRmWvt7178Jrjt569dlA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyOSBTYWx0ZWRfX5bFpqNKHTaP0
 Gs0Mql/3USRSXXiRKHbEHnWs3qe9u0bHqCkkLeYy93ORahO1sULt7cBjmjP3+SxN4mwwr8/fbaB
 DYsmlEmBbqIeQZysrd5vbWPYl3FYX+Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100229
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

On 10/7/26 19:58, Richard Henderson wrote:
> It's possible to program TCR_ELx with an invalid granule size,
> which could match passing an invalid granule size to TLBI RVA,
> which would then fall through to assert in arm_granule_bits.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 3c003f7029e ("target/arm: Use ARMGranuleSize in ARMVAParameters")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/tlb-insns.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Ah, out of the breakpoint/watchpoint rework, good.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

