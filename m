Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A81EC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfa81-0002i3-CT; Fri, 03 Jul 2026 05:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfa7z-0002hi-V5
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:24:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfa7x-0005ri-My
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:24:06 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6637Zv1e3410413
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 09:24:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wfyTnT5jM0Dfotee9N7GYIMzJWZJb8180pLhqJQjo2Q=; b=bbm3qmkvNbJKZXFP
 iVI9+bxl07Ith4bgMIenja+bLYuY+sdAY32f+9ZpQHUSBYITHAODIElN5caZqgdU
 gE/SOXju79x/zyQiU7Ff4HbDj2jPt4FRmjiBH4MOxC74bKIxSorokMoK6n5Ki8Eo
 MszETB4PYb3eiq3xDc4AJvdlaOVzwgOGbm6eG0KTWB6H61wAdDYK7JFo/RReXbdx
 y9e2YQeAeDjOLARqc9k5z5cTNXmLv0ZMf6NZKMXLdbr8Ra4dxJLlSC98ckKuSDWo
 80CyHPZVRktubIGJstuYGlCbFbgDuJrmWYONWn2+o379cj4gApER0FiPPlOANFJ3
 xz02Qw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f68u30d24-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:24:03 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e8004d60eso58933185a.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 02:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783070642; x=1783675442; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wfyTnT5jM0Dfotee9N7GYIMzJWZJb8180pLhqJQjo2Q=;
 b=Ip2h6k0sfK6fV1aRdYGp63fAcm0F29mND5jVHRL6XZUzhwGylY9EOGi8MhEPgTinRV
 h15BQJMShO5ebi67ahfM6TKnfMScTqOa5SjFaEbLx70kr4F84Hd6n+DyuA+1Bc6kzRFA
 udEUxL7OS7ep7sRyxb0qmL1C0isUkUk0Lcb1mVHReg26mz5ZpZ4nFkUGTRgkQKSrOe04
 WuSxTspOlQ7zxkrs0Up0+anJyYHr82+X7FImo5L1aNes1A38hwyyRtOhzp7qkaMmryZt
 pVdUIn1lcOT+tKzpRvw1i4gf6NNaEPr8JQS++vmB0nKF1wc9q4qUBfwI/aPSJWySuci4
 riCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783070642; x=1783675442;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wfyTnT5jM0Dfotee9N7GYIMzJWZJb8180pLhqJQjo2Q=;
 b=ZwbvVQDpGRcxNwWqQbHvrFZFRvln59QvZCfPMTWniKK7BNTOgScvWYhYHFIXxEVYhz
 MGRg+A7t2rD3ErqLunBHs1saaOAUuJJT5JhrrSxT6Sh+6E1mKLC0i+H8euhi+SuYYAcf
 cgDcQ6o/AksxWulhrUUi6hyFNPdTIxzArrduLDOBtJ3zEIKhFz4Ye8uCl/4ySAQq5srU
 m1pvCASvXaiv1Mig0fw1hWkW32g1BTlGwfbJxff5MDJudgcEnM0wY2/23WxXn0nhsoDW
 fEVtOFCc/50g1TvoIG7rzC/DlVx4t704NKY/D5y45wWi80X6TM5OKQx+HGBzBq5TaCkq
 qQPQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/xgrdRVJw/HQdgXAWPO7b+70n7TAJtFwYyZ3NxvwOhhANVyTfCc3JLtBywq0R6sBqjFSxt+/rxVwFI@nongnu.org
X-Gm-Message-State: AOJu0YxO1HrErd+vUiV+Vh7fLWqjpXJtkK5nLBmoQyxUuVklZZ3aPBaZ
 WwK/aB4ggOZsgWgrf/0QKhCx13J9aK29JOoFZwNkIa2qN/iVSmdsR6VYNcNe4qNpg3QXfK7oQ0B
 MCzWSvqWHeo1atQNCx7fIUvMmda5DvV3vBQwCRPyaWwa2yciHlfe4nVTtYA==
X-Gm-Gg: AfdE7cmAqrB+PfzPp6y5hLQ9C2ZZlyZPpTZTGHvpx6fy7h+7g/hF7K6jl/IYpFehP8k
 37syzxSC4cBbs4iQ2MakypJIMpq9SnILtVqF8vJm+IR0hYWDuG38Agk3m8g1VgTTWbUK/8u9XtL
 n+G5xtgAJas7EKyMgshtvPFkI4vvqo7IzkVDyozy0gYHtiJFLr4D4QVAvN2+kx7BPSVTUIwmjFD
 fgSoJRr3sMnhXGZAPwtNzA44O0DyXKl5Mc4eS5K0FxI1rKjNST1BtAzTigNKmhLlIau2aRbI1rZ
 4IkcrS+ZuavzuR6DbI478RUwZVFXlAALikcJLBl+jtzKyCvbNenGHQmkaDwe600SqHEYBQXEbdL
 nWRlBVMLudwJD/0960ug2PdgHg++TXHvXfJE7FgVH9IY6ZesekkTzs/4j9Ua6Nw==
X-Received: by 2002:a05:620a:4555:b0:92e:44be:bbd2 with SMTP id
 af79cd13be357-92e7afb2399mr1079517785a.9.1783070642483; 
 Fri, 03 Jul 2026 02:24:02 -0700 (PDT)
X-Received: by 2002:a05:620a:4555:b0:92e:44be:bbd2 with SMTP id
 af79cd13be357-92e7afb2399mr1079513585a.9.1783070642000; 
 Fri, 03 Jul 2026 02:24:02 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63bfba1sm134777755e9.15.2026.07.03.02.23.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2026 02:24:00 -0700 (PDT)
Message-ID: <a987a022-377e-4a6b-b8fa-152dafc52120@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 11:23:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/5] hw/arm/aspeed_ast27x0: Add unimplemented OTP
 controller MMIO regions for SSP/TSP
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260703064506.937904-1-jamin_lin@aspeedtech.com>
 <20260703064506.937904-6-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260703064506.937904-6-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: I9l_O7LueZ_vagNg0e6Ma6-3-W6fMrKz
X-Proofpoint-ORIG-GUID: I9l_O7LueZ_vagNg0e6Ma6-3-W6fMrKz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA4OCBTYWx0ZWRfX9vjery6E4I20
 0tSzaSQeqexl68ueO2+WxgJRpkedccNNCUU8vKCV7efUSL34gzRS6OThfOXQwQLhOFSWpvR7yXY
 EO5xTmxkw9lN78SZTrt02VkMHHEsixk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4OCBTYWx0ZWRfX6Mn21mPJNe3r
 a9tRBwW0Kxlr97pQL/tELDawHUc+s99kQ5nNPsKqNkxKoe+IK3Qqtu+V4dArnRDYlvbpuPsDNt1
 S4Of1eOh6vGKSul3Re0KFXgayIC56sHPZHCIEZeUZ+wfa43RNfxelkhuRtDQMiKqCUqLNc8WHfi
 OOvc1YLIZe0QZ2vj99G1RKqDI8tSq487LdTswEhX73DXGAYXbejDcvFLcqggICamrN4aXkaO+Nj
 LtDVxx2qc3D6yQVV9i50wGdF8xdP7mXeH1Fyd1vapASNi/C8XIkX0wbKu/EnzKeMBfOMKEf1I5T
 4Ljeno4xm2zBJU/xzzEhaDj3GSMdArZw9T47TdTKCYVDeHPMJPoDaFxhKBWsDgQina7WlZPv8z3
 nIPVhRLJw8pLnZ9xWPjq140rbhFniSahiNp4Xib3+hK8YD5VBmPi7s9ACXBFDKvBVAcGXF8sQVG
 bB2QdILhm7HAe91rhdw==
X-Authority-Analysis: v=2.4 cv=OaKoyBTY c=1 sm=1 tr=0 ts=6a477fb3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=V2NxCb60AAAA:8 a=EUspDBNiAAAA:8 a=0ue78yuwkkn2aMjpMEwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030088
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

On 3/7/26 08:45, Jamin Lin wrote:
> The AST2700 SSP/TSP firmware accesses OTP MMIO regions that
> are not yet implemented in QEMU.
> 
> This change adds unimplemented MMIO devices for the OTP and maps them to
> their corresponding physical addresses in the SSP/TSP address space.
> These stub devices allow QEMU to safely handle firmware
> accesses and prevent spurious exceptions, while accurately reflecting
> the hardware memory map.
> 
> No functional changes.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/arm/aspeed_coprocessor.h | 1 +
>   include/hw/arm/aspeed_soc.h         | 1 +
>   hw/arm/aspeed_ast27x0-ssp.c         | 6 ++++++
>   hw/arm/aspeed_ast27x0-tsp.c         | 6 ++++++
>   4 files changed, 14 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

