Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27B8C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx0RD-0005lq-VY; Thu, 20 Aug 2026 06:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx0RB-0005lb-Jq
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:55:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx0RA-0007Qh-3n
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:55:57 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K8jdG02529517
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 10:55:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XJzehq9H+HHmqSUS4SZMP0gXgDCb7fqVfe8DvcbZk2c=; b=Mg0xyIvkPn/AfjZo
 /SuwJVMHFMTwXBM4IAZ8/vUSNu+FWlpnwc5bgCZ9SGEM1viAiY4Y1nI7dl/Hoavk
 Qg9Kgsy5LJZs7QiPfiTfXCnNgMH2b1CFDTCmRVpB3vBrM65+pN56B7EZH5nXoTCq
 lKX+ZmFqkCnZXp/omJcQweC0f8GI/v6aRiXRf/yaIFTMwodtT1kSLjybxP/44rMl
 VDxI36HsOx991Lo2DZ3hmV4IhP4+7aUpFIyTN8O6MVBkf/L5nBA7aBcmnj3Lp/71
 Q7fAVfbaX7JTw0ROisFgZJwo5eS08GGjdIIsOK/0CtzQXbezvlwulST66AkeYVQ5
 v5tVzQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xbv8gcg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 10:55:54 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-936aa34873bso187276685a.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 03:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787223354; x=1787828154; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XJzehq9H+HHmqSUS4SZMP0gXgDCb7fqVfe8DvcbZk2c=;
 b=iuF0BN44mmv5bMvJIvyE51kB5MBpuL0q/02+laC0RtorBxGxvoO6DLXLwEHJrlj/qf
 zvc8ZpUTmlyT/2a6l8EjhWe3Vkh4L99A29K0xr44YxsZqi93nPGj5IfAmbv40DziR9qK
 8KOJ3p5UgFAebZkUIikecW06XdneBd96TYUHszVeGcJhcxLdLR1iNqTfJKwj7+YnpjaT
 JFVcg4T4wSVEfidnnJYHTim1GSNuyoGIlxYT7lzMFtpZG8T23eAvlh6U24qrgtOKm8Ar
 z4QcfY0JZhBIyfr1bnnIYX1rvt5dDJZJk16cDx5LZ8EgjRnTZqDS+x6v6xHPs9Q6plHH
 Akvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787223354; x=1787828154;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XJzehq9H+HHmqSUS4SZMP0gXgDCb7fqVfe8DvcbZk2c=;
 b=mU19VwahbGugZKK7L2RDHX30j94b/z6ZVuSK2SuqGwBwtyNgaLhT+uY2vLXNBXW0BN
 x8+Jjrlcb89NyvnAA/9uoB/jZdPAgOekhuRL+xdiEncZbsE8M8GVTxY0KPFqhVwp0KR8
 qBz5bZx2ujxdXmpJWtOQn3+VEtCLUXDzfJ5q8kdasmVIe7KN5UzQMh+pZ1fiA6q3WgvO
 vgkBbum35AffFF3lcBy0Fs2kQ5WgOzVrS95QiQzenw8TmKJhYW6RZpWDkM+Utzs6DO+o
 yMeHJqC4CQaSgVOHNUDR0cf8ni85MkV0uzNzAJ66cFXrI8BrOZMp0eP/vV+iFVr3yc6W
 JotQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoovzdVe1OXocWXHl2RoxFXB9n4kzd1CF84KY8xIr34+SN8GRFiWST7MmvqrsOxdbyV95YPiXPfPlUd@nongnu.org
X-Gm-Message-State: AOJu0YwIoNk24tZ9KaZjCkIvTc59r7dRLEUQcq+AOV6YOySy01IMkSUW
 48cY49E5VBwa5vX6C+ID8dm2Wp0g9SdcZGGyYMK7HAOea5F2yWajR9ODn9gBGxzQDROr0TDQR0c
 wHU7we4IJ0AE/CauvNpzS+JAm9OsEiv5k6Afavuq59qRrepCMu/ccGWS9FQ==
X-Gm-Gg: AR+sD10b3gPWaQHZiSTNNZSJDoG65JibVuWO4gUE7eKTga2Xv4pH+iK7Sdw8bVJbVyG
 pVPOnSYOeFbbgwDRd08VglQI+jVHe6XbAJIvtzSrkkD1cIOk/hqCEHnyugsf+pw9r7casx+l4nJ
 vPiQVvs5FpyRCzg2mwyDg+fCS4VDUkclkeiRevaSXWWQzi75BPCirfVmQjQYnpwvjLTSeMDVQ24
 SKk25TOeh4LWnlPVX43BYj3xK+X8LsC4rYRFZ2v1r+GHUd9SKYK1CO4GWgFlVvKId4q2NaOKBB2
 VfWGSw8ySM6xEw8qS/9R3efa709qQKr7n98LZ++fj9VhlOfSaoxLnqOvSnT8I7+ihyVnZVu3qGM
 3nXsifgaKvFQD3bc3CC9byUOGrqN02mgsHko=
X-Received: by 2002:a05:620a:6c0d:b0:92e:57ae:3a53 with SMTP id
 af79cd13be357-9371e256628mr1040157185a.9.1787223353792; 
 Thu, 20 Aug 2026 03:55:53 -0700 (PDT)
X-Received: by 2002:a05:620a:6c0d:b0:92e:57ae:3a53 with SMTP id
 af79cd13be357-9371e256628mr1040152185a.9.1787223353166; 
 Thu, 20 Aug 2026 03:55:53 -0700 (PDT)
Received: from [192.168.69.231] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa1111a7sm137182745e9.6.2026.08.20.03.55.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 03:55:52 -0700 (PDT)
Message-ID: <2cceefa5-e087-4c91-a57d-391963cfdb7b@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 12:55:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] hw/arm: Remove the 'musicpal' machine
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jan Kiszka <jan.kiszka@web.de>
References: <20260819185430.3467629-1-peter.maydell@linaro.org>
 <20260819185430.3467629-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260819185430.3467629-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AMKAkK6n c=1 sm=1 tr=0 ts=6a86dd3a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=gpnIO3m2qDfVEuVCFyUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA4MCBTYWx0ZWRfX4qXkfsgxI7ZG
 BEFyYKO9MQBV1M7UUoYvgmMx3aAo5KnM8ll245RgEIAgHeadtsHCVaTfoWCXkGpOvK4P5xKm+dB
 NppGNGJoS9doe5qeO2aqZqjP5F8HnRewcEpHpu1UKaMIZfynxHsX60d4gp8iqQOBZbI1yDOTVdb
 SuScKP4x8NX0P/KXMh5U7UJ8mSVgn+Nqcj99tlZ6wlCTuZozZ2MJgWf5mh/IK8UtLfUWYJmxmT3
 ecprgwuPvKrSJADG3QM7O8szWq7xGq+uDLnqCL60/0DPAcBjO/Raj1QbX59mgU9jBLhbRJ8DFSo
 ugWFcEl0yVYblQFsRAwT8n+dK+q2yTNyHg/QYJ4bM0XavkKtSsd5jFaEnmVLpwIAN3wo1qvsutw
 BtaVhtF3ro4zCA11QgoKlV01cwDiQ3fk4at+5H1lw5ThUCiAgtMQLci91/qsb+1BwqcPwl8mHMy
 VWQBjgsPhpE4GjD7XCg==
X-Proofpoint-GUID: XJiGXLAj423hVvBCEJomM_4FN5aifD6u
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA4MCBTYWx0ZWRfXx2H0wsR0IU+s
 35k771Kf9Ff1Z63duAYM6O3/iuo1ILMPcnrUIdkcm5aLJEivU7v0GrQij/yUxXFn2aHwQ8Y/sEi
 T9TIekid2AyCWqmrbNcCXF4Qw+SiVBc=
X-Proofpoint-ORIG-GUID: XJiGXLAj423hVvBCEJomM_4FN5aifD6u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200080
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 19/8/26 20:54, Peter Maydell wrote:
> The 'musicpal' machine emulates the Freecom MusicPal, which was an
> "internet radio" released in the mid-2000s.  The stock system used a
> 2.6.16 Linux kernel, but as far as I'm aware, support for the
> hardware was never upstreamed to the mainline kernel.
> 
> There are a number of reasons for deprecating this board:
>   * The hardware is now solidly obsolete
>   * It was never supported in mainline Linux
>   * The SoC is a Marvell one with no public datasheet
>   * The only QEMU changes to it have been the usual tree wide
>     updates and refactoring work
>   * The only bug report we've ever had about it has been one of
>     the usual "bug found by static analysis" kind
> 
> But in fact we can just drop it immediately, because in commit
> 59754f85ed35 ("target/arm: Do memory type alignment check when
> translation disabled") in 2024 we broke the boot of the standard
> firmware image for this board.  (The image's u-boot does a LDRH to an
> unaligned address, which is UNPREDICTABLE; we used to let it through,
> but that commit makes it take a Data Abort, so the image crashes
> before it boots the kernel.) Since nobody complained, we can deduce
> that nobody's actually using this machine.
> 
> Remove the machine proper, and note this in the docs.  Devices used
> only by this board will be removed in subsequent commits.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   MAINTAINERS                             |   10 -
>   configs/devices/arm-softmmu/default.mak |    1 -
>   docs/about/removed-features.rst         |   10 +
>   docs/system/arm/musicpal.rst            |   19 -
>   docs/system/target-arm.rst              |    1 -
>   hw/arm/Kconfig                          |   12 -
>   hw/arm/meson.build                      |    1 -
>   hw/arm/musicpal.c                       | 1388 -----------------------
>   8 files changed, 10 insertions(+), 1432 deletions(-)
>   delete mode 100644 docs/system/arm/musicpal.rst
>   delete mode 100644 hw/arm/musicpal.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

