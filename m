Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C89C55822
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 21:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrMgZ-0003Lj-Vg; Tue, 04 Aug 2026 17:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wrMgW-0003Kl-M9
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 17:28:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wrMgV-0006HG-4u
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 17:28:28 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 674JlK7w015809
 for <qemu-devel@nongnu.org>; Tue, 4 Aug 2026 21:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sfJu6m6zv4ZbcOV2nuQefd5KWgd+E5EC9owSk4liGBw=; b=EW/pNUPM5cNtUNhv
 nr2OQ40VWCwSfRPZmfUIpSqrOiCLf1ViAza2JDt1Uo6aIaP9ENbe3YBfQfNvQZn0
 PTtbc1mlrWld57iSOkYJcuqNdnJ23l7UJRJY+4pHCsdqTKAUBe04Kp+PVjrQB5zK
 LE29H8RcUGaSFD3n8RdBE0r5UxR7eBteoB4xXkC13L+nLh70dwcvSpPIf13AFeWn
 xRbsYC89JwRnPMd1fNBNbvIc60FojfkLG13+pzRjyeJzEOpWfWqM7+yjLC+XyPbJ
 PJTzSsyvalsIPnO33+tRMDBjmQ0gL3uDzrQ0qZ0bb+NJm8Ir4kgNc+hzvMXW9x6p
 mEhulQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fud23k9kd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2026 21:28:23 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c21c01cf3so3860531cf.2
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2026 14:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785878902; x=1786483702; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sfJu6m6zv4ZbcOV2nuQefd5KWgd+E5EC9owSk4liGBw=;
 b=DJiEfck049JR40zKbju2pUtsvcOw0HGIuoHY5KI3gVUcFEScvPXs3QDiuubr1r9sGZ
 LZ4M4ZwiJm9R9IL7JueOoLBrO3GWOu9cjoe18f6FBuT4PmtO0vatxnzf0xyTWF2y9Tdc
 1jprODpqY8Tbq2AaMoqnZOLjJc0wL0zjkDUmM65xNPvrdXWvjQ0NzXn88KKBavUYDAOf
 LhqEwMkhq2mrz10yBmrTdd98B8RJnd+xNdxOlbL/EIACbqwRMNjUH9ojx7xBJI/RpHU1
 MqtE9Nijv2ptCL0GEF8bN9a4qq6P3HtfzWMUnUN6FL7SpK0iU0kyhmpEiyoICTvVs2dB
 y4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785878902; x=1786483702;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sfJu6m6zv4ZbcOV2nuQefd5KWgd+E5EC9owSk4liGBw=;
 b=KKZV96C0oWXwb1JhYxTwsyamXllGesUqxpIbgOsCX6Lb6E45jXq2r+/lbE8YbcoLiO
 bd/awa+qDxg5YrMMSEq9rT8pTB7RsHSJLDJ/KiPY+NbYPPMtB+OES3M0Bxyieu3xTBsp
 NhXmgfjQN4OoO84XDPSa+vMgFYetLXxV/uLQ7eAI1RaVRcVCtUFOhXYq+nEqGXI0zYSM
 2RY34J33Q5OoNRqrVhNQQP/2UEeCc+m5IqGSAUD+GJQqml1ErZEGK7GNzEMe7vVzqsAR
 xs8ikp4Wb3PdWcQU6G7PALvgnv43NCMKTyXadAi9NOpNaQUo+f3LYi+QmG4yl81NTDGv
 I7PA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrWWy9j+tMIo2mu8qXXZzLlwceoZZoFCrNu4+0YgpBa58RdyF04YoHouG+ezWauAnGgqZcYJiO+0gez@nongnu.org
X-Gm-Message-State: AOJu0YzEaPfZ8PLRXBPhzPoifbxNNuhlIJlfXwAm/y+jalUwSojQH0A9
 6ao1yUBsBm0I2eWofaOsMUlWItaa6wwTbb/QNVBc2vwnMq6Aj4vHeeJrKbxb2tw5N2F1IjzYqkR
 jrDHsbmiceurvTMxxbBfPACdG98/0fc3jZeVP3gShhB6EQZCNoJ/lQRBiKw==
X-Gm-Gg: AR+sD12er5SMrFK7jzWrVORLixSy/Flm+bjNaqkbnZIbQOFTJ4t+WlSU/HIIXvuqsGw
 6aL1ijFOozhx1EgKFYq/pD1DsfRLYJn/wqvj6n4JQR+WG1wUgCGc/36TtCo9sPft/p8l0BHxDrU
 pko8r5/scHd4/im0/omGTqrvuBpaFnpCNz29e06DRN+T25qsdDzVwdZUjD4TiGZJfHgQP+AbOut
 o6bLo6jxs9WgAMeBW0Av00To1VQQJ/1BkfEGg/8PlkMPBn0SyzQvw8puYTmjGnP80umbOI6llF6
 a1zxu40/MNDXNmOjUCIxDs1YqXsOnFRnoVh6K7RKAL/J9hjM/Q0nlWchanT+HWej2UiqkPz5lfA
 2RJeeo39/5r0rVjV1GdkIGmeOE9Z27uXe7xk=
X-Received: by 2002:a05:622a:a08:b0:51c:1d0c:605f with SMTP id
 d75a77b69052e-52ce6218254mr24865051cf.20.1785878902431; 
 Tue, 04 Aug 2026 14:28:22 -0700 (PDT)
X-Received: by 2002:a05:622a:a08:b0:51c:1d0c:605f with SMTP id
 d75a77b69052e-52ce6218254mr24864561cf.20.1785878901900; 
 Tue, 04 Aug 2026 14:28:21 -0700 (PDT)
Received: from [192.168.69.212] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49949fcb345sm121394595e9.6.2026.08.04.14.28.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2026 14:28:21 -0700 (PDT)
Message-ID: <c41b7873-f6f7-45dc-b0e0-25ffa0d6613b@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 23:28:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i2c/bcm2835_i2c: Correct iomem size
Content-Language: en-US
To: botszhuang <huang.botsz@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@mailo.com, qemu-arm@nongnu.org,
 sef1548@gmail.com
References: <20260804144611.31735-1-huang.botsz@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260804144611.31735-1-huang.botsz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Oew3XiIxaMtK-ubqsSME00eyxlL3gfRf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE3MyBTYWx0ZWRfX9wXLqSENb/HD
 g1QO/UlCcCuFIeE3+e+2bYlaGlduCxJ6afLqnuJjXM6OtBK82PnMyqku0xFkRBjkEyY/OxQjrfS
 LD5oeOBlr+NqEMNOrNqo9twquVUtHkk=
X-Authority-Analysis: v=2.4 cv=XIkAjwhE c=1 sm=1 tr=0 ts=6a725977 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=X8ZPm0S_kNcVzREjRFEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: Oew3XiIxaMtK-ubqsSME00eyxlL3gfRf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE3MyBTYWx0ZWRfX/jN/IRHygmZq
 lW7n0YlXHtI+ZI5dph3ZuXxSn78OwRFPRt9wQmJw2ZFNLnevRd7QSvaNkfFMGb7Pc5gP7zm94rx
 9Jrjk5TzqzR+ZksCVs/2OzltLGPi/Y2h4FUeyGt6A0M2v00VrKPfVx7rJWabrCRpxXlT4kgtXED
 ZyzozZN1377ORJX1PxyjVPvgFDnMEgRZuQc+vViv9g/yO9f1DZ3LhlQISTcr3s4xCTxgBiYc+tn
 h1UulcFqq79Ek8Y6/FcmQsdiaEKEVXw2bUFwqY1QAC2to03Z6LFo86nibYx7D5SOY8TRrWvQikb
 JNx0VCUCjSe1Lim7qxcTor56x0jEBR/LNtXadp9E+Zx53WBDva2rcwnmXO/7QQe13E4Gjkyvs/U
 Uwr2cSBaS9vmKbQ7tf11ElP3WcTm9aOHdYEX2P9kbH0C0rNTWDsjmY+IRgup0CyfiTT+Gv1+x5G
 FeMQOJQX9EJFDWfnmkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040173
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

On 4/8/26 16:46, botszhuang wrote:
> The last valid register is the Clock Stretch Timeout (CLKT) at
> offset 0x1c. Since it is a 32-bit register, the total memory
> region size should be 0x1c + 4 = 0x20.
> 
> Update the size parameter in memory_region_init_io() from 0x24
> to 0x20 to accurately reflect the hardware specification.
> 

Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> Signed-off-by: botszhuang <huang.botsz@gmail.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> ---
>   hw/i2c/bcm2835_i2c.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i2c/bcm2835_i2c.c b/hw/i2c/bcm2835_i2c.c
> index 34de1f36e5..5f6093087d 100644
> --- a/hw/i2c/bcm2835_i2c.c
> +++ b/hw/i2c/bcm2835_i2c.c
> @@ -222,7 +222,7 @@ static void bcm2835_i2c_realize(DeviceState *dev, Error **errp)
>       s->bus = i2c_init_bus(dev, NULL);
>   
>       memory_region_init_io(&s->iomem, OBJECT(dev), &bcm2835_i2c_ops, s,
> -                          TYPE_BCM2835_I2C, 0x24);
> +                          TYPE_BCM2835_I2C, 0x20);
>       sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
>       sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
>   }


