Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD66FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 17:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJwdu-0007vw-Au; Mon, 04 May 2026 12:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wJwdr-0007uu-5J
 for qemu-devel@nongnu.org; Mon, 04 May 2026 12:59:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wJwdo-0006hC-MC
 for qemu-devel@nongnu.org; Mon, 04 May 2026 12:59:33 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644Dl934366314
 for <qemu-devel@nongnu.org>; Mon, 4 May 2026 16:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tR5cqv6CSf2SoCz0JdL9wOqorT/qb6GXUDkLJ90A6a0=; b=OMc1u9SISO4VxRbP
 g2zovc+WLvlwIR4U5JJlRZSxjQjUlt/QkOkX9ly9zL3XcBj8pngRm+Fs/DtVJ9oN
 yAOypdmsL1O2xHY3DNfYvld+gqBcbIZ9v4K20WY6PKWSaDj4VNeuGN0ZcVi16vE7
 bqYDtfcnoflctv4LqLYx8fZ3LWdSn3Wh9VuVf+I34MwnHY6McWaI3HpK0M8gY3R1
 EBXzyJ8zIyiu9L8rhVXkl7v4J65L5NXVu/sWaj394FzQg7NynxFJ+mY+eqcLoLo8
 p82iwvf7ic2H9dxqS/+TnFXSas7J1a1zAjiz9+h15hfKFkIEz8vN6VhkUOMGaOtZ
 ECV77g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvn6rq4h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 16:59:31 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2ef37c3f773so2417471eec.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 09:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777913970; x=1778518770; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tR5cqv6CSf2SoCz0JdL9wOqorT/qb6GXUDkLJ90A6a0=;
 b=Q25/pQQYZUsGSnyqZ29hj9CV4Y10N4LURyWKnDgfp5qx8vZ6btY3fvaUh2j9Un+FSX
 T3pQkviqiQUFgEdIExtnUnijPkGhbgHVVa8ObufvJ1GslLc+9xL7zQn4amO1OgkxeFCl
 pyQdURQCVw9BLM09nv+gcrC7HxCgK8Fq8/cRzSuM8W38S1rwNwQ2IjeSpt8/CDrStdbw
 Ma3KiHn2SDPOLAbgJaDb8pN1ICCq0YqAke5BMh+xWx9xjALF38v2YrojaKyBllwzPxkQ
 7z1OPe8HTsxHok7DoERzoyXLVGb55EZbEzYq9Gu8AenQEnyiHDa+XbNpPrMIUqJ51eIq
 gClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777913970; x=1778518770;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tR5cqv6CSf2SoCz0JdL9wOqorT/qb6GXUDkLJ90A6a0=;
 b=bTbB2A6IrEFEJc1qFZSxuLHm263AEXeZxlpwCFlJu51MzNpPAiFWi9Bg/UbSJR7S3X
 3uuJ/u2OVM9Vc+XLEM/XSe80yl7Zr1p2pNyKYgnZN6Um5LBGwEEKtNWv7p1ogFobF1xZ
 lRkByKO4W/otk+EKaaFxegVL6krj0p0h1FyndF5/XrOBYk9/Vc90dx+Lsr3Tq21mm1Vy
 Vys2fuez65tVpD75LfC8kMGb7R0v2eVnIAjvyXzOuLHPCaRHKamrB4fVpOxoVC5+xQS2
 aPnoF+ojmOCOPrD0PLXioXo+Us3oZO/KumoatDej3oyXlC3ZpWRJ3VFdyhRCnk7ibpaw
 qDSg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8AbSs2MuwLY96UBEAgxvI+TZRhSsvCy6R8v/jBHKaRm+mdTTF2P7jJdrtr04jVATS9rWM5yWZfWVut@nongnu.org
X-Gm-Message-State: AOJu0YxC+7LCyis+o1UiIxo9+xP1B7lX33IYrSXf8IjuZ37gtzGqBb7c
 lTixor4mVM01yP+05d4BWm3J50TQceZeKh9D83c/5UT9RtYDe1gzBy53D3sqnnT5f7zGB7cgWGd
 rS1UFNOP1O6xELyfU3nYf3UV41sXK/EKeBqOVu21q2d0mqA/rTnMgXIkgwA==
X-Gm-Gg: AeBDieuCjFxigRktt93ABdhBQXBpXxABeSj6H3bxOzE5U1B3lJCm3ZHK+I0Kxj1Qr0o
 gMK1i5nexoRneE6wQvKN28WQQE1/r8WDxlz7gTg3Vzr7cuovmGmgAD9H5Mr8uXtMOislf11W+2D
 f3YcfeTlMFvpMqll0Srhm6CTtCSLPeZreeEevYk+Gp9mxa05UT2e+C9HywmVrorDbJnNM7b2iXF
 qVFOLq2G9cgP0jx7rIsndM5966/5irdvxYOy+H6jns4wA8f5/Q3CVokALkN9CZggOyzIUFMpplC
 EO+nvw87ngDAqOdK8+Nyb8bakRnl+WFiseq/yVs4ncRIIc6Myyj+JM791zFdm3luQ7S/I9d/ibS
 gsKhief5dzuaj+ZmSs+IoFY+E8MPHEQtfONfMT/Ge8h7Rwlyunl8TZSJiSIT6/YUdL4T87Fw6yR
 fMSjMLgn7pTg4mqyzNKRtK89BS
X-Received: by 2002:a05:7300:cb17:b0:2ed:e14:42e7 with SMTP id
 5a478bee46e88-2efba7a6b4cmr4316985eec.32.1777913970007; 
 Mon, 04 May 2026 09:59:30 -0700 (PDT)
X-Received: by 2002:a05:7300:cb17:b0:2ed:e14:42e7 with SMTP id
 5a478bee46e88-2efba7a6b4cmr4316963eec.32.1777913969448; 
 Mon, 04 May 2026 09:59:29 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f194556795sm6599209eec.2.2026.05.04.09.59.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 09:59:29 -0700 (PDT)
Message-ID: <8ccf97a5-d16a-43ca-a3e5-a5d0489ea361@oss.qualcomm.com>
Date: Mon, 4 May 2026 09:59:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] docs/devel/tcg-ops: Slightly expand on discard()
 opcode
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260504125032.35465-1-philmd@linaro.org>
 <20260504125032.35465-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260504125032.35465-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: yO0ahISkiVYaVYhVt0URa8W_aCUM6SB7
X-Authority-Analysis: v=2.4 cv=Z+vc2nRA c=1 sm=1 tr=0 ts=69f8d073 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=On1QBEPkcWwVD2HCWJUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: yO0ahISkiVYaVYhVt0URa8W_aCUM6SB7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE1MSBTYWx0ZWRfX1h88eR+8D4fV
 IcY5ewB4KBfdLyextEXhYt2Tf3HTId7Y5G3sA/J9LMRE0J6YXcQbjXMG3MYqBcWZzE+IJe3gaIo
 DBxInUDwottvuLCRm9VG7ZI5w6eMxLyjVvmnERJstG0LXZFbL0JCYy2RrWvp//ob+rFwHQIisK2
 Qvd8ECvv/7IWlxFlnKJZgLzatGbhROqCKg3rb9FSlD4ZSahrJN84bZoPsTMSk3l8OuRx6tRKe6M
 z+TJbNOy4OmZ8+tPYsSWHFqMdvNwmRkrMMsxweaCQM2kfm/aNhDhiQYj2JkUWu93qLmZHkFUI4x
 q8XZxZFEZ6RL29z9rM/3RWQduPuLWEbuzJanlI/S2BUkfjRZVQc/Qh1pnPm/0U+WicjWIxs2+tF
 H0wpyzfgMqCDHb77DZtrSzKrOlUZ+sPg3F7mnh/INjm2eiBAAYLY1iO4yM+yJbAGeUQZSsnmeEg
 tQT5sIbAKixOk+To6hg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040151
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 5/4/2026 5:50 AM, Philippe Mathieu-Daudé wrote:
> No need to precise the argument size.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  docs/devel/tcg-ops.rst | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

