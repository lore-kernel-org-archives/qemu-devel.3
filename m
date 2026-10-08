Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC89CA600E
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 09:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEkYm-0002Vx-Rb; Thu, 08 Oct 2026 05:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEkYl-0002VC-Nk
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 05:37:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEkYj-0004P7-Rv
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 05:37:07 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6987K2mo3190799
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 09:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iO9r7zwCun+KX83pt2QrwFbYyPiSgbKYl+Lp/51cv5A=; b=P/UkEUdO4QF61wOh
 KrEu5UbnTKDwiqRnn6GpgaIVZsSWjrQG3jUZzUfxshaxX1EvJUVJD4g4dHYYBCOx
 J5AZnQSoJtOiQruGQrCOJon7k6c+9CuydLiKDtN7qpcRFv/RIOsiKqhSo/Y5Y/Cn
 2IzZ4EKqgUoh1tOsGro0SDKRkiH4qxtiKbqBYnq+9OTUATyRxgatBthBkhZSl0bp
 pjHRn/lJrUdx9uhTDqpd6JxMD2Osq70h2fYZboD6te9OEaKY3b4GtSXrYivWOH93
 xQQ5g7KE+eio5xwn5IawM446Q9RX5J+yi8V/B/5whvgCq9QbN+wH/8ywPenVZVUl
 SWcLfw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe6a8ah-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 09:37:02 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93e834ff4d0so915666085a.3
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 02:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791452221; x=1792057021; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iO9r7zwCun+KX83pt2QrwFbYyPiSgbKYl+Lp/51cv5A=;
 b=QSAJRsdsWwXet1GH7ws1PULNZwdcodUq2kd9BjluAZlXg78mpt904Vkc2xn+WyBLx3
 04VT6VkjLUawoAYX1nhI/FehfwGlqhMoC5NK2WreM+4FlRZCBEa9dicoQ0y0O+PTGVLZ
 cdxTYhL7crludAFXcuUIAxUmAelVRxPcRZfMtmDGd070geS9iKtuhR3IEYpGt/v0ZK86
 bdJohd616cLBQDO8iNSdBvLcEWQPkDbolIMA68P8Hj03J62wQMeM9HQCatVAfeTv3usV
 QpRpy1W0qFbYC2XB16Gpg1VHxVUk6eUxGMVdgj2k5EZxkss2o1y2GOzwRLthWfxMjsy7
 HWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791452221; x=1792057021;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iO9r7zwCun+KX83pt2QrwFbYyPiSgbKYl+Lp/51cv5A=;
 b=UD6pCiCuB+x3pkdp8VyVfubdiy/ief7nOkYlpGX+VzqqRHoUK5FErg8J6FXTJOY4oO
 nZL4I1yrNa1Frx54iQlGmSL2kpGgJWdRFEWsbpNYbR5RhVmfDIUUhigv/SPu5uFq8dnr
 2XvgRnhm30UTgvVaZV4nYMupEy/VLLkU6VEuryA9sPBAG62TdPZw6XEnu1TcP5oeguHn
 d57Jt/ktSVvw1qhsqYIoZrAhop0FDuFaBiu1ILC5Cb7G6X+TJZ0+77Bn88161acCeLa1
 LXECdjiX7lJFySEmyq4QOENpr2NvwtgQVkjGN8SkL/MAJSED6tPY7QkueBx6GI0MvLi+
 yt+g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwvUGqCC7tAsaaWKvWu0JxncIsRIbQqBxBgLgHA61UEycl4QoHyTjS0VaUuf1mSErJwBbrBC8Kt7CNi@nongnu.org
X-Gm-Message-State: AFuF++kzsBP+8Zkjro5YNgWzd0D8/KHvhfiXMiv26L934RYu2KuvqbQJ
 F65cA5a+K9+PjQK+Ne0O2H7PYKC/SMDWPk6cw2N41vyIrIDk+UZdjUBtLwtEnJ6xWQqBWwRKE0R
 lsSywLHDQDbq5+tJo5NXCipTGf/O8X9NnCgC5wz/FCmBj3Aa4dLHowrgVAlg+mZoh4bv7
X-Gm-Gg: AYBFou1mWrQ/yAq6uPDXibPoygnPnJ4JQNDeZ75dVBebrWSMTdF8qa2p8uYNknzTpuj
 jPeZ/TCl/aXlwRnsFCPDKXR+rXBYGY42YwSSrKyGRcDCq/u83XADR41sUgo61A9uTZ40shfFoVH
 SJe9TLmiciFaKkOIkqYuVFRd1JItYXIaKIoaEeEO+lv3TB5QifLzuI1p1cSsx9znmcPFSzemU5o
 rIV9UPMkCy+pn6rYCTIAkee1m9l6Yx6/f43U4ywEfCA0SXUS1vFYB189WilkP2lN6SZ6Uho6u/1
 cscGftv6OTKiqo8/9R0cv9vVsMKwWTT2bswQ5qeFFRsPGNi9K+E9uQQNhhn3MCq4/ClQRceofI6
 nQXhvf5x1dfrkmGOOXOLl6HlXSuo22wPJpw==
X-Received: by 2002:a05:620a:1a1b:b0:93e:5cf8:e5aa with SMTP id
 af79cd13be357-93e9b7e3e52mr969233885a.61.1791452221269; 
 Thu, 08 Oct 2026 02:37:01 -0700 (PDT)
X-Received: by 2002:a05:620a:1a1b:b0:93e:5cf8:e5aa with SMTP id
 af79cd13be357-93e9b7e3e52mr969230885a.61.1791452220712; 
 Thu, 08 Oct 2026 02:37:00 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1843cb261sm59426725e9.3.2026.10.08.02.36.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 02:37:00 -0700 (PDT)
Message-ID: <5d81e092-86f2-4459-a34b-460d69009568@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 11:36:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/arm_gicv5: Make IRS_IDR0 reads return actual
 value, not 0
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20261008092327.4036856-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261008092327.4036856-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: t3ng4JNx3VJ7nvwWwgKtZO8wVpyAJ9Yc
X-Authority-Analysis: v=2.4 cv=HcWB3SE8 c=1 sm=1 tr=0 ts=6ac7643e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ZPVIWaONiU0xY8L9-hkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: t3ng4JNx3VJ7nvwWwgKtZO8wVpyAJ9Yc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzOCBTYWx0ZWRfX5l1H969jHMgE
 IAeXetZdkMMuzc5LAO9pCUUm5dviYdgnG1gPIZHhdXEwL9IL7yWEA8SpsrvG7aP8lJ2uvtxQjd0
 xJXL8hyWx0xzQHS8A1YO+y8iySqrsxB3OeIGgGZdu62Cz4M/Hd7y8mnZD53ZDslK46deQSz4lTS
 vG/fvLDD16E2AbLPB2kKuTAqQKwkXH49kS+PiC+7rmSLWSDAwRlagmh0LJT5971Ao5pcw4dM+qt
 5AWAr9im1Rr98bgp7KQSu5Y//59O6/rb+1f003RteQ9y6+U6kGqzlF+h4Febk3TQybkM0GIwrB9
 lIBUQw9TBjZ41BWAJ+LEcgjB9gTdTtoXbFqNpKuJexU/jY/V/rbdr1EU2DEVBCYUMEW6GVenDi+
 3fdEbr6Wm6Om8tjMmLGL8TkRWuZyDzz3AE4XbUF3pPiXw4oRcEzLEAEpUSrE1KZ6V6hrvaoDoHB
 o4dp7ttZE3RPa3LRkRQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzOCBTYWx0ZWRfX5fkshdrIKYtA
 mKC/kkYirtFWT7sQOFM1lrCbogFa3+Zb2vqaIERmSDi9WFG8CdSrGqbG+UqnkMHrYC83Us3AKkQ
 kzdISuEOOMyEw7uGjESKyGfLCyBdCQE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610080038
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

On 8/10/26 11:23, Peter Maydell wrote:
> IN the code for handling reads of IRS_IDR0, we carefully construct
> the correct value starting with cs->irs_idr0 and adjusting it.
> However, we never actually write the final value into *data, so
> the guest will always see zero.
> 
> We didn't notice this before, because Linux happens to not care
> about this register value except to check for the presence of
> virtualization.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 405ad2e76f13254 ("hw/intc/arm_gicv5: Implement IRS ID regs")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/intc/arm_gicv5.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
> index 08878193dfc..ebfb0878af3 100644
> --- a/hw/intc/arm_gicv5.c
> +++ b/hw/intc/arm_gicv5.c
> @@ -1433,6 +1433,7 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
>               /* ...which means VIRT_ONE_N is also RES0 */
>               v &= ~R_IRS_IDR0_VIRT_ONE_N_MASK;
>           }

Looking at the code path it is obvious, I wonder why compilers or
coverity didn't warned 'v' is set but not used...

> +        *data = v;
>           return true;

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


