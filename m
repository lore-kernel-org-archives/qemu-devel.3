Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058BECD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZVpJ-0003nL-Dp; Tue, 16 Jun 2026 11:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZVpH-0003e5-3Z
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:35:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZVpF-0005TV-I1
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:35:42 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GDxc3e3432058
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 15:35:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nUKKV7PVI4xH5CmB8e88UihTk3Xw2MiC1v6lMYEBZTM=; b=SWOYQtLeUH9AZJlr
 UWefiWC3A2g7G5yepbV1X4PzuYsJctCD5C8UrQN1mdB9omgfT3os0FLI8ROadp0L
 xIvzWQzlU2/d3eMV0dqhazoP/dqwwJvlNuy9EvxQXAMwn5pkaq1Q7two1XXOxdYI
 Z7hmty0s9C3t0Ic7DLKhxKy6dkRnyjAH30sqUO4EAwjLANhnWVNDobbJqkTCvR7W
 NVsmE0ZzZ+rw5stCYCgkIcxCywlaEd4+MJpj6SQX6+/96WQTMetZsw0Ox0hTaZaE
 c9DF54kXmOKJ28Xs3PaQY+RQplyu70yOiPvPRC1ZuQXBggKYWKgcYjZzD4rNhp9U
 rH8wdA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu1762du3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 15:35:40 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-6cc5ae9b959so4809067137.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 08:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781624139; x=1782228939; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nUKKV7PVI4xH5CmB8e88UihTk3Xw2MiC1v6lMYEBZTM=;
 b=DhIN+YSiBtBIJLchIY/myv/rfUfiHuwHiJVWC3jXL0DywYHbTdPDVD7DvZKLiERzC4
 +j5nw3821AVq/ZbK6TFyNPffbxFhzTgm+TkPYkcUOEGwTN0apAPFkTHE65jsjRxZH5Lf
 oRJY8ZcpSjuHdY5vwmGOmkY+exWg/1j6vhxYze9DNmIgngoKBvUzH1tqluX8JRMi6+ry
 UhdwM6vX+Z3Y9gtRrbaRVguCiu/LqQ4qwB0d2uZXc5qQyxgBfUpSrQQca+gcyMVD7kJf
 AMXG1RgHmj49evTh62GWg+8jEl5Wvmz0gFy4GhP5tL28PwiabhDqnU1fdbEJVTVMdh6n
 aiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781624139; x=1782228939;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nUKKV7PVI4xH5CmB8e88UihTk3Xw2MiC1v6lMYEBZTM=;
 b=auAQToVCCVFkc5mh1m0at8oz/Jkr6X3wPCxfZB0CRvv7aCRkc5tlpPqygg3fhcriLI
 1m/1Z0ItDs2bzy3gUSuEntzhUGfxo+fvS8GeoI++hOqxno2hr7ZRIgfGh4fmjsKuzSz8
 rV7+bXZwLtd82sQKalWhJbt9+r7UDdjoU2xd8hGf1jv+BZvz3sIPCts0KpnIvfQ4L8Ms
 V6M2hm/NevPzcjZ4k58ymCfgS7miVY1kuLed0gKgGRt9Zdn0178GMQiIlLPH1J2BWl3v
 FcAozPHRIHr4gugfLzoJ81UKZVSSstbPEly3iXMhO6JZHXtYTw3MqTyTjmvP9eWgscM+
 XngQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+hMzLm5fTdyz8U0z2O/wf0wEYS5bsXYr0oghguvgddp67+8dAefH3hK4xWQDeIAepT1VdAODAz9pLt@nongnu.org
X-Gm-Message-State: AOJu0Yypifc/M7gEZILOThmbyFFM/dCYBbLLamYJAxXQVVGNz5HdJ83N
 FEXyPvizpV/KP+I1zHNx7b9CvCdzvikXpu64Qb0Cb4Ptb4lUZYq22eLjoSrINj1+ftCwbpW4VfU
 g/sgIPfWnxKpquleJ/zqgLd6lEJSbirxI/YzjC/NWW7yM/MunuN69s0m5xw==
X-Gm-Gg: Acq92OF2p7ZbRn/jNBczP6yVFQ7jIjARmaergP2xtzUXaFY9wVvffUyJQ2HlB7LRnSL
 yIKOn6vYRGTGzNa+jWTxfpwQhSsRRDpB2DQuPPB4yjEgY8emjGoikuIo/rA11ngvOcja88qJCHh
 v9k0DSxqNvWiOyKyDxcAYir6fpGl/WSPear78CCMULibAxXQvPxFk7dBYvMV7OxFRP5cANWAt3r
 M3Dgk6d/7xrU3Lbe5bhnwEMDkPB0X1/+RIyv5vFzO003377nWdsR6Qel/OJX2KmTOFZk9CMNdGB
 viF6FJ+bVeS1X69xWYR5G7ZtHkAJAjaQAYxWaoz0yR7n6tmXkZxE+OrFm2GZ05wbDX3wx5QDJCn
 E4aoJuTbwbJUHclEVe/B317maqeadHAyZjOZZ828YxCf6TBkwwUq3hHlwAQlY5J+Y3bevRWgN
X-Received: by 2002:a05:6102:160a:b0:636:984a:1e5d with SMTP id
 ada2fe7eead31-71f5eb00fb7mr9631039137.11.1781624139025; 
 Tue, 16 Jun 2026 08:35:39 -0700 (PDT)
X-Received: by 2002:a05:6102:160a:b0:636:984a:1e5d with SMTP id
 ada2fe7eead31-71f5eb00fb7mr9630982137.11.1781624138573; 
 Tue, 16 Jun 2026 08:35:38 -0700 (PDT)
Received: from [192.168.69.214] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-461eaa0d275sm2117526f8f.2.2026.06.16.08.35.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 08:35:37 -0700 (PDT)
Message-ID: <a2686ecb-a36e-474d-b14c-91ff4e5e92d6@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 17:35:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/tcg: Restrict IOMMU declarations
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260616152842.92275-1-philmd@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260616152842.92275-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: eINjFjaNi2LeV-blIW2u_G6fYS-teo1v
X-Proofpoint-ORIG-GUID: eINjFjaNi2LeV-blIW2u_G6fYS-teo1v
X-Authority-Analysis: v=2.4 cv=I4RVgtgg c=1 sm=1 tr=0 ts=6a316d4c cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=209pFy6FlnFkDuPbtgoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE1OSBTYWx0ZWRfX2FEodOnslTDM
 GiwLxWiHVmnFGqkRdwShLWtsGFtUAQi2EY3gxlhY0unDCFjpXhPVQMVw3iIfxn0XJTHPJI46O5p
 dQOPzFccyCX2YtDWWMyo2YQJoby8pZ8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE1OSBTYWx0ZWRfX86gGA5OkgmH9
 XLjktO5gMqZzlQ649uqSgAC1RWWRQBQfQzm2A1S26EOTnAXzNiLbbm4pW3ki54lo5xQgO1sM2qd
 pN7XOtoCxPxbh6wagB6ZCASUhG0L2hx2bnYikJR9UgNKgtv0mmAzJtqXYbwG+Jm+ipAJRi/J4gL
 Do6Wi/dNzpx7TL03ArGoTieY0PMGD5bu7OKEqk8OOdnEWKj08Em1WvdpcT2siBpPZZYE0GVALEs
 1MPHQTNARZ4T7X6VerefmalZmFQGrb5za4i2toQRpaTsi/1USZRLriQVegHh8JGmu9Q+wCNUEdg
 yQQqx/u0nldQhnnkdb2yR48FAnX+epUNi4S+M8xPmzaP2GD2loNBxNIZ6TwEf6pheTei9eni0AJ
 gQZjhViGqx0uzjaOrPs8LyDAIpXmODAv1PLRrL1REjbXag27OKLD9Q5lH8Kc5alDsSIwuZLXJ5W
 jRabMpSlz0usjjBSfSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160159
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

On 16/6/26 17:28, Philippe Mathieu-DaudÃ© wrote:
> Move the two TCG-specific IOMMU method declarations from the
> generic "exec/cpu-common.h" header to "accel/tcg/iommu.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   include/accel/tcg/iommu.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/include/accel/tcg/iommu.h b/include/accel/tcg/iommu.h
> index 2b6d0ff7282..a4032a292e5 100644
> --- a/include/accel/tcg/iommu.h
> +++ b/include/accel/tcg/iommu.h
> @@ -7,6 +7,10 @@
>   #ifndef ACCEL_TCG_IOMMU_H
>   #define ACCEL_TCG_IOMMU_H
>   
> +#ifndef CONFIG_TCG
> +#error Can only include this header with TCG
> +#endif

Rebase failed :>

