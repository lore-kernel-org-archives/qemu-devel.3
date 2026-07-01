Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141ADC43602
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 06:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weoAq-0004qH-Ir; Wed, 01 Jul 2026 02:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1weoAp-0004pc-Ho
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 02:11:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1weoAm-0004aj-MM
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 02:11:51 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6615lRrg103006
 for <qemu-devel@nongnu.org>; Wed, 1 Jul 2026 06:11:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SoHyYqO4aqroluLj9Q1S+7qEdoozN1L04oaP2Sw1UDc=; b=SN/Pavn5l0nOKbXO
 Jltj6avEsGCkPjJkv4MyT5Y8ci2Nt3SIGuL3dmtl2wV8WTq4Emz6mkN/lqoYWrHr
 EAXkJ3WreYmiF0EcTRgqaNxowvObK+auipeICpsy4JSye32RjyHpBl56hPgxbnHB
 soO30D1mOX5Xko58C/i1V8OHgTGjHtcnaNFewtRA4CanC7coahwR2IDdi7mphMc6
 w9ft3ftMlrDw1GcIMEq1ae9wURzb2t6OjIcNNGOFvhvuCP5exRrij8/AmjYUvwqK
 5dkwN9JP6q5uzAGMbxzoGZnggkfOIbaqhaviLJ8FiVKiq8sr540hlwwSymoH9eXC
 BlMOBQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jvwabsa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 06:11:47 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e73fc29bfso51277185a.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 23:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782886307; x=1783491107; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SoHyYqO4aqroluLj9Q1S+7qEdoozN1L04oaP2Sw1UDc=;
 b=ck35inMSrQUyeisaVbFrdpgKiPhc4A1cuEsXUv6tzi46KnqMBlZsb09BwFQ7Oqcky9
 T9DPlGNC8UUffHumma7FjrlQVPVqR3w36oRGkscU7CIFcVRxozquHa4K2y6L/JAVivRj
 hRANXdGSH4VPjXYvwFxtMS7tSRdb/nkQfp67d+h3w321ivK6LIWobiX12FCb25JWkbWM
 gF8hYliMN3RHqMONIpLIk0Uat1NEaebT+hu51m3aXMHl1W/JDx7wGJBPK3gj7NTBWUqd
 9Z0LFCnVHgUx6+yWrKI3kp/25PlF6ON1BAdXbOYl5LlOuiTPlx9eyWm05nNn+m5aUtah
 SbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782886307; x=1783491107;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SoHyYqO4aqroluLj9Q1S+7qEdoozN1L04oaP2Sw1UDc=;
 b=Oth2cZEkaEaEbMcOZjHlOqhOSuIii6eeoZJlFFW+O+eRs32+7KoDw9S1DfsKIR5ncZ
 5t4bSx35pP5nTVffGPKGwa4D4vhaptEWazib0xVk1NhEplFRqdTWqbHMI9iSCA8Ihy1o
 vN0QADbKKJMiyTZ82qyrup5ypQD+J8yjqO5d/fHg86GaXLRg9toxjHOXlhv9MmOYDhdZ
 eWsd+Xd1cNnIZz814H1B36pgz2zXiQJcoWqNOaEIcGjpsLa/gLJTrtBdQ9RDHqr9UQYA
 TXXpu70ml0MzQtlGbxjdNDb8bY3ht7yikBRS4zMOj9Z2YWk8xZzb3W4pNysnRjvt1qlx
 PI5g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8c1hktPTmmGVIqexI0LilUCluu1jIpCEXLKL+yogBS4JbSSEwPuZwKy9d6KOc94xNAjPW8nocVm9rj@nongnu.org
X-Gm-Message-State: AOJu0Yy1KbhKCTPocsYkNXVJr5b3w5WhoHkjh/o3OCb8otyq/1WC4P5N
 cEHP0eM5hmUz+bT2iLhmG520fwv4vl0SZArVtoMFiLgx6PepC/pAUhCykDcIh4kvPSFQiMw4EJ1
 ncFeET6P476uZdWsrO4q5elh6Moj1TDWmd/L4aygIBk1eqIxZiHXeux1rgg==
X-Gm-Gg: AfdE7cklczrCwkBUjsM7StsEG8kX/DowFRWf89EwGwuHXTWV+EX5Y/knjPglYFbNk0r
 6dg1E5g3D6NfRsUaV6k8FF+6t4p8Kz4gfjbSVDh1QLTNy3hs3lMgQ2QJZeZu2z8jM9m9BINFwag
 PNuToDeX3ly8BOn9VOyJY/dmsTlNz4agwwmdLfVsS02TH6eZFcWY03wCys7Zg87gqv+4ur1Zx6s
 FniEQEmlBfapwzSg43IK6QL63cu7/CZRiqOkxlwte3v558hxDmxfnrP+djZ96jx8nJp9dp7T41W
 5UT10AlCCO/wgKMvtToMCwJXc8AZkP2ScFgInW675N9IVrWgYlHOSaZtmsW7/3hS7OjoFXOpAoy
 AAWzWINpty5rVHPLmCJdXh4Rol3TDa/V1veAvtZzK5a4VRnGADzArsz8/xZfhQw==
X-Received: by 2002:a05:620a:258e:b0:92e:51ee:7944 with SMTP id
 af79cd13be357-92e784d1225mr40354985a.34.1782886306904; 
 Tue, 30 Jun 2026 23:11:46 -0700 (PDT)
X-Received: by 2002:a05:620a:258e:b0:92e:51ee:7944 with SMTP id
 af79cd13be357-92e784d1225mr40350685a.34.1782886306167; 
 Tue, 30 Jun 2026 23:11:46 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47560effc81sm14096761f8f.0.2026.06.30.23.11.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 23:11:38 -0700 (PDT)
Message-ID: <bf05f5e5-737d-44ca-8fd5-abd97c6513d4@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 08:11:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/17] exec/breakpoint: Move BP declarations from
 hw/core/cpu.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: shivangu@linux.ibm.com, qemu-arm@nongnu.org, qemu-riscv@nongnu.org
References: <20260701030443.1382447-1-richard.henderson@linaro.org>
 <20260701030443.1382447-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260701030443.1382447-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: zdnrhXRhvfSleVLSOA-LJa98u1zfJ3Xx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA2MSBTYWx0ZWRfX3/A9riQFyek3
 Mj62Qw8dBFb7iUBEx4byZtaitgX3QuLLX3GjRt2ESeyxx0U5PFnllsNhj9bAqSqdbUfGcMuDosP
 bl4Mk5Go23WzrfaBf8XXgXZ7qjnlPAU=
X-Authority-Analysis: v=2.4 cv=JKgLdcKb c=1 sm=1 tr=0 ts=6a44afa3 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=9e7byKQMp6R3KdQvgMwA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: zdnrhXRhvfSleVLSOA-LJa98u1zfJ3Xx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA2MSBTYWx0ZWRfXyo3pM1vn/+Nm
 +OpVM9ZPGJpqq01AcHLK3xb7LtI/OoJWruHIf0B+p3VOpB+FjAU18i0mSpvgJjc/oNHCRCdfwql
 lzkm2D6FM7I5ag8LDXS/Qy+0N9XIw19ea868BK5lPgi2KxsgF/YpAgclxC1X5oS2aOmWRQqMFmL
 YROX9ohdPTfA/wJBgIVU3PdbwwtYCO6eG4tEvT148VwOqkrGNlCWASWPlSRhimWsWlc0TVIprD/
 Y88r2/S/72UNrYG/mrFPeAjahS/jZJ6Y572P5fH6ouEuTv+QdpyarTeFpp9lfWAg/jQiUsh6hd+
 s53omapQwVyW6XWNhq1L80sr9ypyNhVPt2haLr1Ri+FYX7RwRAZ/YEEmThdCI51JG6MXCoWY+Jh
 03O9rhKqCF4mipGEZVDpcQSXimsdICFIyRZ+ypIHsFbIja4XlaOuYTah+2Q5TplbDxuHA5aRvkN
 +XnVrPDkvzS/V0CClfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010061
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 1/7/26 05:04, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/breakpoint.h | 21 +++++++++++++++++++++
>   include/hw/core/cpu.h     | 21 ---------------------
>   2 files changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/include/exec/breakpoint.h b/include/exec/breakpoint.h
> index 95f0482e6d..4013d9a07c 100644
> --- a/include/exec/breakpoint.h
> +++ b/include/exec/breakpoint.h
> @@ -12,6 +12,20 @@
>   #include "exec/vaddr.h"
>   #include "exec/memattrs.h"
>   
> +/* Breakpoint/watchpoint flags */
> +#define BP_MEM_READ           0x01
> +#define BP_MEM_WRITE          0x02
> +#define BP_MEM_ACCESS         (BP_MEM_READ | BP_MEM_WRITE)
> +#define BP_STOP_BEFORE_ACCESS 0x04
> +/* 0x08 currently unused */
> +#define BP_GDB                0x10
> +#define BP_CPU                0x20
> +#define BP_ANY                (BP_GDB | BP_CPU)
> +#define BP_HIT_SHIFT          6
> +#define BP_WATCHPOINT_HIT_READ  (BP_MEM_READ << BP_HIT_SHIFT)
> +#define BP_WATCHPOINT_HIT_WRITE (BP_MEM_WRITE << BP_HIT_SHIFT)
> +#define BP_WATCHPOINT_HIT       (BP_MEM_ACCESS << BP_HIT_SHIFT)

See 
https://lore.kernel.org/qemu-devel/20260630220100.1289-18-philmd@oss.qualcomm.com/ 
;)

