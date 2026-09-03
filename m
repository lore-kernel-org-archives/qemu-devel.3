Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801C4C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24QL-0003JS-Sr; Thu, 03 Sep 2026 06:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24QK-0003It-Es
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:12:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24QI-0000cY-Qp
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:12:00 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683925Uk3035733
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:11:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EauNGdA+3+5LzZFzExyz0KcB/RCUZ63cle+tQ5g8ZeI=; b=YqqaXpX6gIix1Ztg
 BUoIcxVVbDkzuymGlrdZfrxA/RDhFoDo59u6ZrFZp/EHzHXCn6jSWrgzYaV+9cB9
 YsZpq+HutNvYfqlFmYKDf73t64ar4Uw/y+LPiO58wXMgnLiAf3OK6J8ci6DOr7oo
 E0kQH3lIrWIhU1gH5agob1WK9lf6OSazbnlUXORQ36OIV3alJndBtRxiec9QmtO+
 +AA3jCPTGscfHhfSv2FB5DM4svblo4xi3VJlyhkPodeuqjFgP93D5EDMtyrZlND4
 yhjz2R0QLHQlEE45rtZUIkeC6OOCsR85F1wwALnBE4HZ4p4Px5hx2rDAJkh1Aj91
 irxJ+w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf5d10dvv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:11:55 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-938153538caso422906185a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788430314; x=1789035114; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EauNGdA+3+5LzZFzExyz0KcB/RCUZ63cle+tQ5g8ZeI=;
 b=LmteG6JzmwdsmPMrTHACoF58dWGtd4FpN9danZcQdb0MYUygTNWYjWb+7h/g6BmdwZ
 aWsUh3NrpVjkaTkhLtLzFz6PWF5Jv+nWsMnK6b2XjBNzg3i7sKS+0uSNZ1oWRBhcvTvI
 JDO/pKdIHiiEVb9AfSqLCj5qYav/m18iUkI6JI2OTh6iAH2J5il7XhtPiOldpvwWO58l
 ZkRFZ3bTYeRhQu5gtE2u123AisFeo4MbCIs5qpr5HSP5nJ2QJWdOgxpOx+zQHtj6ucLy
 RpCDsFlAv7geXjfcN35ek+GN22KzVbPdS6HrY7CVKogtQfjQnKYCOS6jDrue2UBi7ebB
 gfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788430314; x=1789035114;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EauNGdA+3+5LzZFzExyz0KcB/RCUZ63cle+tQ5g8ZeI=;
 b=EMopGwcZIQiUZ1089nfHAG+H5kY3fUF3Q/8m4re/EUboahnnONDSpQqj5Oa3RtPX9W
 KrYsLBxL1R2YxpySxDxX7YJwOi96NEP8QXxjttmT1G3eurfiIyhb6ve9Kd0t7RsHtniW
 tbEeRyAQ8LMCCTpOHKyKIML8OELYlGUZCb1NU8BG0PE35ETBkNaV4aBE3BEF9nWra5lJ
 FsPAv0GxsMD/IS0ZOMnnrNe+Dh4qGkGonUanKyrmkwsRYI6mDJp9Uvh4L3GT3GHqnDBA
 /FO1hPcQwbbxKZExqjvvXcLwFm6GiwgF+0c9YKCyZRb0WRn+/V8JroWXO5MjAhRQU5MN
 inTw==
X-Forwarded-Encrypted: i=1;
 AKwUvByclNoaMG0qeZvSVUSk6Z2RJZ0SwwBu2DBiebQKWw0bFTnalDkxmiqR6kQKk3aZs4oQKWswy8Jy/QWm@nongnu.org
X-Gm-Message-State: AFuF++mgcxlGEi7igZZmSZz6GzTke6DmAfzzaQryfxWTDwTxArMJ7n3H
 YqeUhCEvEGC/UdAmKQwzqaAk06E+1CcG7HDKeaNY7FDkqbFfnJcgctsufDE1i8kr7W7ZYVaCbst
 q2x8lBVLLuvw7mpKa8fAOpfBj5/HdLI7RrAjTqHzii6Kv1wAmhzAdI42oFw==
X-Gm-Gg: AYBFou29tWHW7T0ByoiCTaT+rrFhMbjrPxYqdhztz1tsN3I2Q+KLVzAi3vo5+f2AH0R
 vCFvGs2r1sQyEZxo8saHzQuFuXg6QWKBlYWe/1vQGrGBxJl5RNDOZQ9k6NsjB9cceVfNY8jl5nt
 ea+5N2yZnJMJVr1xrPr2GNaohVU1/B+OsVZTIXpZMLElczEMf8Pz+gE2snGbHM6mjefAeqJulLc
 D8zzrY2aXry1N7lCPCWJ/DXo/38jiEqX2Xh0M8R8teEkluDO9NaBXkXQz4Jq+hNj/Jzmb3mr768
 jgF7UwqgJnJJgEOF0UlwMOFksQR9nSEklnBem4gcPu3FaVzku0y7utQ4JvIWLMv2EHqPSYeFYoD
 UzuE3wyA8E7MNnExXvw+I2rtIDXsGxmhNnQ==
X-Received: by 2002:a05:620a:2617:b0:939:6dea:4f1a with SMTP id
 af79cd13be357-9396dea5390mr599425885a.48.1788430314085; 
 Thu, 03 Sep 2026 03:11:54 -0700 (PDT)
X-Received: by 2002:a05:620a:2617:b0:939:6dea:4f1a with SMTP id
 af79cd13be357-9396dea5390mr599422785a.48.1788430313703; 
 Thu, 03 Sep 2026 03:11:53 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5d5d12sm57875485e9.5.2026.09.03.03.11.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 03:11:52 -0700 (PDT)
Message-ID: <767d3fc8-bd47-48df-8838-d1313885bdb4@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 12:11:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] hw/sd: sdhci: Fix SDMA boundary bug
Content-Language: en-US
To: Tao Ding <dingtao0430@163.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260715160731.29969-1-dingtao0430@163.com>
 <20260715160731.29969-2-dingtao0430@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260715160731.29969-2-dingtao0430@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA4OCBTYWx0ZWRfXywd2OUqzuPKU
 /trS+WebuEW1ZRHTzQIYVT9c3FG9GbL+PKcaoc/BhXDPs7sPUQM4FR9U3Sl89Z+9+XnKxVp4Liw
 7dXM6piWjpDiVt1goRPA4HTIUjic31rOuTJgL5rcqk5s73slLna90M9YUVqCrOagAKdqlahTKuC
 BeLrV7IgQq3TJYdn3kwldMjfLG3vZdsOfW8/aeGLFPzT32+0bo0u8bNy1f27qi+LpGaa3aQDrUs
 rRx5hOecGIOYyVN9WBwMqsP1VHFTrJPJsADCAuVlHRFimbIwga3LW4XTF+mMAfqYpQDwfdcF9GW
 BSTrYUADAB/ZSiuVN5jx1CuglFQXaRuBhVWteAgovwDMwk9wivuuaOWprl2hGu7aEqgMpxYlH+G
 +AErTO/2qIfyzQrufzzJLit4tzWzXy31iNXrcVoFu1HkGDaUxWcjRckpmCqIFzLJMzzisp5f3oS
 sVkG7VmPkR/q8Q+jvUg==
X-Proofpoint-ORIG-GUID: T-qU-TPyWc7cbdkuNf_CnhvCcB6_yNZi
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA4OCBTYWx0ZWRfX3TU7qCaZRgj3
 xXxaGvxzODj3qNpz5BHlS9/tXYkvLJJzhe+VBSJ8cGHv75XM2yeQsWiDTnRRhfbkwf5Q6FF1RFy
 UN3/ZtU+Sq7LWCgHrYQzjcNsIuW9fpM=
X-Proofpoint-GUID: T-qU-TPyWc7cbdkuNf_CnhvCcB6_yNZi
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=6a9947eb cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=Byx-y9mGAAAA:8 a=vjhuYSkz6juMgjB3m4QA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030088
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

On 15/7/26 18:07, Tao Ding wrote:
> During SDMA transfers, the controller raises an interrupt at buffer boundaries
> to request a system address update. The host driver will rewrite the SDHC_SYSAD register.
> (according to PartA2_SD_Host_Controller_Simplified_Specification_Ver2.00.pdf section 2.2.1)
> However, the current code will ignore write operations to SDHC_SYSAD.
> 
> To fix this bug, when SDMA encounters a boundary, a state is set to record it.
> In this state, SDHC_SYSAD can be written. In other cases, it is still protected by TRANSFERRING_DATA.
> 
> Meanwhile, a subsection has been added for migration.
> 
> Suggested-by: Bin Meng <bmeng.cn@gmail.com>
> Signed-off-by: Tao Ding <dingtao0430@163.com>
> ---


> +static bool sdhci_sdma_transfer_active(SDHCIState *s)
> +{
> +    return TRANSFERRING_DATA(s->prnsts) &&
> +            (s->trnmod & SDHC_TRNS_DMA) &&
> +            s->blkcnt &&
> +            (s->blksize & BLOCK_SIZE_MASK) &&
> +            SDHC_DMA_TYPE(s->hostctl1) == SDHC_CTRL_SDMA;
> +}

> @@ -1185,7 +1198,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
>   
>       switch (offset & ~0x3) {
>       case SDHC_SYSAD:
> -        if (!TRANSFERRING_DATA(s->prnsts)) {
> +        if (!TRANSFERRING_DATA(s->prnsts) || s->sdma_boundary_paused) {
>               s->sdmasysad = (s->sdmasysad & mask) | value;
>               MASKED_WRITE(s->sdmasysad, mask, value);
>               /* Writing to last byte of sdmasysad might trigger transfer */

So the SYSAD write-protection guard didn't account for the
boundary-pause state, silently dropping the driver's continuation write
and stalling SDMA transfers forever once a boundary was crossed, OK.

Series queued!

