Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B33CD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 13:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWwf0-0000Sh-IK; Tue, 09 Jun 2026 09:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wWwew-0000SK-2H
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 09:38:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wWweu-0003ln-G0
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 09:38:25 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659ClIKM2251583
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 13:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xIHty/11mw0B8J9msJRJHY45IKPbBhMdmHb2qkB989Y=; b=C6s8mkScYzytUGab
 uXXwmi6XUwHAuoEYSnoqqKUVuY6pjtBD/8MCdGsGpSgWK1KDZcI6RH8+ThT4mHnm
 unBs5JikdrAJBj0+81CDJ/Wj+JJrML5eDcdXwxzAcDIkhU+Q/2PAs5Q29XgillBw
 +2BPTF4PrZ1p0UnMlCY6CyLImYZidNK4W6HB2iPbaTZo7aDV7MlmEpObWENHBWkF
 GUlIAKYZAeWGZdR2hDSuBR7h+5WvZ3SUsnVdnY1MlspLMQWgUxSOyEg5AuTzcbNm
 VPJ18MaPlVZKAXzAC2xX7wlicwy1xI6yfiVfinD0NZff8x5idNErPtNZwh531/Hh
 vNO+Ow==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epeqghgbv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 13:38:19 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-6c69c788ce7so109548137.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 06:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781012299; x=1781617099; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xIHty/11mw0B8J9msJRJHY45IKPbBhMdmHb2qkB989Y=;
 b=BCGws9Yhtfoau/BmLnPBHQFVDCTD5M0/T1LD8q48caaresMHpuZf0MX4S5E0egfI7t
 LGhham8ib3jhgHYDRyqf/ygOpbSiZSI0aqSqGpxR+oMm9hClDD1/xbvSHYHXqmSvb2XP
 Q6Ry8GfJQ9m9ODJo3rKsn/kwCCgWEQUBZBu9wf9gm+bcF0r/k/UkO50QiCyR8Od4ufMu
 h/y4gYrhK14gs5OP87k3f0W9lv7TBmgyFzkVHZOuY5wcxfN1Zd4BXgPCsTOpocCNEKq8
 rF6/6SvBn6XvbBiuDq9bJoKHlqgL3KVG1HNNkpRwD7gIHlbGJc9/IvZJGXJwjQdkD8JH
 QlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781012299; x=1781617099;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xIHty/11mw0B8J9msJRJHY45IKPbBhMdmHb2qkB989Y=;
 b=raltxtYqbYnUjr9YdxTP9ROMTovla5RZUeM8+LlT9aRYDiV+T3chu0qR9gC7E9u6M1
 RTx+zQKX8Pp/G7QXEGpE2kpAst7y9/SRExp+Rqv5pMjSMz2MHjGk9++moUK3a1x/8l/1
 Mib1x3+J3man70LEukG6Q/KTfguF2yqEpVmJIz1+MTpbIQOtaY9pOb1b9Bhk3Of3sXdK
 MD5XPeJU6AQO/mIgXW/Z+Cj0K5HjIRu1dRu+w6Ev3PJCHoROZL+UI/pr7VZvL2oHxQeT
 N7xJ++GEdeSgl6DupCeN/wON5dJw6+x1vEDKobld7KNhDjDNNyPQSBC/r9FNIAE+9YFO
 4sWw==
X-Gm-Message-State: AOJu0YzGppOwXMqMv5h0sJKZPWPp9VBd0HQnyoSzUS0i316kuifVgkhd
 pqSOqfFdRl+g6uHbn3FJGQwqco/41/fHpUYxFyFwfyyjcqNZfea1V2+jymvkpFJ2NYt70uiX6j2
 xabH7UzO/h6gWyDsb1mHY7PcBghWz70QIsNXBacPRu875t40vK6UQa2YANw==
X-Gm-Gg: Acq92OE1blP9O6JG7Hoin201Mz8Tl+I0SzfkebIhiajqnYkCf2H8iG8uTM06B6ZQTw8
 BRaOeLX1Yv+I6JRp/xDgD6ruDX0VMkIGiK9VbBnk1tB3WSGREo+hWVYwc+hUITyTkeET7wjTYO6
 WrykMgPumXXsqZQNouNr1k/1iH+LqS6ZoZO3Fb2IKG88R/RLkhbpzzsWtTVm9ZO59CaNeZx4Jop
 MpWJZR4BC+gZB+3jXgDEDK6kAbbF25FNLp0hBqsLK515xqIdnyFxyD6qVCzKCvvT0O5yEJIqRbD
 ItZAmpOEGlhwTLgu2bm01dNDcd1K3vuDNBLEAyxkV1JdkNm0VI/hYSR9I8xR7RnkX//+nRx0l0E
 Dh0zOLINEPVSc4svPVai3OEQKrE6XSOuIv9mLxQ5CUAxweq39qiMOnzFAac+ANQ==
X-Received: by 2002:a05:6102:3910:b0:639:6533:65a0 with SMTP id
 ada2fe7eead31-719361e38d9mr1339591137.18.1781012298685; 
 Tue, 09 Jun 2026 06:38:18 -0700 (PDT)
X-Received: by 2002:a05:6102:3910:b0:639:6533:65a0 with SMTP id
 ada2fe7eead31-719361e38d9mr1339560137.18.1781012298168; 
 Tue, 09 Jun 2026 06:38:18 -0700 (PDT)
Received: from [10.156.84.244] (113.170.88.92.rev.sfr.net. [92.88.170.113])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e65b57c66sm8589225a12.28.2026.06.09.06.38.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 06:38:17 -0700 (PDT)
Message-ID: <c8c4c4bc-6936-4826-83c2-11c7322980e4@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 15:38:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/bcm2838: Route I2C interrupts to GIC
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Righi <nicholasrighi@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260525032634.7754-1-nicholasrighi@gmail.com>
 <CAFEAcA83RtkukDbExv72YztjHZkhLy8JyOc49gY3eaKoW-5jKA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAFEAcA83RtkukDbExv72YztjHZkhLy8JyOc49gY3eaKoW-5jKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEzMCBTYWx0ZWRfX5lWgFcbOQJ54
 kCJ3mzj0QGJ8jUVcWzRr6VjUx5RiwpsU7la/tUqyr6T7V/jW49N3EXVCBn/dAJP3HyL+l7RQ+v3
 NzJqnjJKMDk2lFrYZzZHGuyRahtoHBIHzj4uyqTxHXLgcBLijqLNS4/xFqAzBOxYluDcbSfSehk
 uvrkDGC1TlNnuYRiZoILpi5fz6+EAdxRlS4XdrlwbdQ1azhO+ST8kr9oousjYXsQmrLNrqWG0mE
 abytZVL8+zwtdeBE/dDBqNCnvBtxeC8L0RpKHsGOvqag8Slw8HQsKlVnjY5L9fWkr6cPdEhv9KM
 F0Z3EbCyndHKVtwbx7Y3yzOTuutHy77wazy2Fcpz9Ry6n6L+7rv6f8gm1mdMbOlUEE+tmlCR3L2
 W5tTaIIhJuXV1UrXBTZ2nbf5wER+9d2dni8b3cp/VlN4PcODXL5c8qi0aety5XbEA3daCwJNCLs
 5hLMCipL/ujlFvKPT7Q==
X-Proofpoint-ORIG-GUID: eToIXRiG9XlW78lcKZDqi3dSFXqASxEj
X-Authority-Analysis: v=2.4 cv=KdHidwYD c=1 sm=1 tr=0 ts=6a28174b cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=ASywmo1ADVsXjDI2RVyDAw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=--Y-9FJRVdA-VZ1UcwcA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: eToIXRiG9XlW78lcKZDqi3dSFXqASxEj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090130
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

On 26/5/26 10:08, Peter Maydell wrote:
> On Mon, 25 May 2026 at 04:26, Nicholas Righi <nicholasrighi@gmail.com> wrote:
>>
>> The I2C interrupts are only routed to the legacy interrupt controller. This means
>> that for modern device trees that use the GIC, the interrupts don't work. This patch
>> re-routes the I2C OR'd interrupt from the legacy interrupt controller to the GIC so
>> I2C emulation works out of the box with current kernels.
>>
> 
>> diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
>> index c14a854046..6895f70385 100644
>> --- a/hw/arm/bcm2838.c
>> +++ b/hw/arm/bcm2838.c
>> @@ -184,6 +184,9 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
>>       sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->aux), 0,
>>                          qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_AUX_UART1));
>>
>> +    qdev_connect_gpio_out(DEVICE(&ps_base->orgated_i2c_irq), 0,
>> +                        qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_I2C));
> 
> We already connect this output from orgated_i2c_irq to
> somewhere else, in hw/arm/bcm2835_peripherals.c:
> 
>      qdev_connect_gpio_out(DEVICE(&s->orgated_i2c_irq), 0,
>                            qdev_get_gpio_in_named(DEVICE(&s->ic),
>                                                   BCM2835_IC_GPU_IRQ,
>                                                   INTERRUPT_I2C));
> 
> It is not possible to connect one GPIO output to two places
> like this -- the second call will silently override the first one.
> You need to create a TYPE_IRQ_SPLIT object, connect the
> output from the device to the input of the splitter, and
> connect the outputs of the splitter to the legacy interrupt
> controller and the GIC.

Oops I misread that, good catch.


