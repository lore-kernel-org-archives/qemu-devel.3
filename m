Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1D5C43602
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 22:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgUy6-0002yJ-Ua; Sun, 05 Jul 2026 18:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUxo-0002hm-Fe
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 18:05:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUxl-0002X4-Vy
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 18:05:24 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665LxmEt2787330
 for <qemu-devel@nongnu.org>; Sun, 5 Jul 2026 22:05:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DH8pzOmc9lSj+TaHJtAy1BByOmTt0UHjszdsdLBbFUc=; b=Xa2lIRZEUheZhQWP
 fMfx4AnDGWzO7sKLT2FpY6fT2d+x3Q5fB4w2pt/lybee7IAwpb4Vyp+rv0Y2RGlv
 BnsltYRhOCDEfuz78j+tT8BeJAeUexDujoG/ApPAF0dYoyebHlxlVSQV8xA9szkN
 5gOzEiMyFxLHlWjiF7awXvrwOqM7n2Yf27fdVp+Q+NoaEBsrF7JIAi219Taw1EM5
 esywovRBM/hxR4hMlLr4IGV4e9IoHmvyWvYtu7XkHGUSrFs2rgDbEeGO5pu7PRer
 hmdJmtvtE3jVMZ0G4+//sM4PcK9RtU24vllqvzRbmPNcT1UQ53YSyY4qF5AsXg6s
 Ya2ymg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6qhnkuaj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 22:05:20 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e61b38eddso437279285a.2
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 15:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783289120; x=1783893920; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DH8pzOmc9lSj+TaHJtAy1BByOmTt0UHjszdsdLBbFUc=;
 b=QpETefceayUniZ0QDxjzRu5HFS+Nfx8a2iSfpziU46UVf66P/3wcyWrVY2oB3MjA1D
 eErdDvy5zb4qE81vGjYZoU2ie1UfkGdvoKQSR/C/k/GQ/e5MI4BbM7tg3raf2XmlO9rB
 EU3bmd652OSvwL9zoWlIobB8cS+lSHZcdV3VLD+Fph9Rj66E00vlDH3zp4zbokNOA/92
 Lu41aEhP4u8/fSNDUGhAo9M8aRaPxtoDWHp85szI1mFiKAsP019bRCxYUok7VR/Is0hY
 /2ngR7F52IyeFaJ82SfEwRsX1FG3NsVyA/rz7Pxas3R9TMGd5TaDY+wFHWBWNhDoW/Vy
 i9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783289120; x=1783893920;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DH8pzOmc9lSj+TaHJtAy1BByOmTt0UHjszdsdLBbFUc=;
 b=OqHbYaUVoBtkyu49Bdi2u8bmdQZtpueeCY8x8uP7uuT3F4poY1ZgJ+TWkB860kBw9S
 tIRWlthomJakIMKX9gsNxRQyVvFnMXqlpevGeepuOVcxRktfBL8hhn0UjSxVrOZ30n7Z
 VUvH9YdkgAh8kobr408yecGNwsYeNeMA9OvjNs1HjuSreLyrXon5uMTYfnulaYgIDYh2
 Xh6/Nv1QFpgY4Pr6mPNbvULklNMwb7wwP8FSYYLrDIPYyZplkjj0zy3o+IJ55erINCOU
 6cUIhJeoKJ9QZCPDgqYzmMGxod65/AycfWMVHydF5tdXvlbdq63tOr8TI8DJ3hHPgUSZ
 J0cg==
X-Gm-Message-State: AOJu0YwsH2I9sipfVM9l4aHBM3cPodGrYyobet1BKojdsZMimAaCDwLx
 ZObVGTQB7WlT/6b5O/rX3YDju1UqeYv20Q7ZQcOhfOMzNf0tEmtB9HoS2neOQDtz+sUYzaupQWi
 r4acJMaeOQv/Fj6POQVl0tTBHv2cWlXvlVup4UIWPt789EfcpCTe0R7C26A==
X-Gm-Gg: AfdE7cnaUABd6s4rWfEVnttlSXMk36z/CZKQa+AcfMfHjzJWLoD3oje3FWOkhUqScCV
 UMLdUN9/RRy3uq1HuHnQHE/sQ1bQke0E//39+W8gc4chv6T9mSEHJ9lCIyd15M8v3la6QAx368c
 UXcvdaOJoun/nfw/Ou8LH0T1b4lQjzkCskW/YUXENxZ/uPhJJTZe8CZVvjQtlrnWJ5Y6IZtUtaY
 Jnhp/AoL5Oe3z7l9kxiRss2hObnwrWugqg4FeS4THYScXnddSQCB1CWe/bjbQQo5ZXgTT7HCQSF
 z7iEsbmf7d1tbAJ/Wz96BSbTJAZIM+U1zkMdjhtzKa2lNMYuQ5vUCgWX5kz9JU5qZ97l7EQF5F4
 HjskXgfAQUUt2lVOY6IEpuYof3qxtVakXuXCENLeBxGNxgg0=
X-Received: by 2002:a05:620a:4693:b0:915:c7ad:8bd2 with SMTP id
 af79cd13be357-92e9a3be669mr1067121585a.30.1783289120350; 
 Sun, 05 Jul 2026 15:05:20 -0700 (PDT)
X-Received: by 2002:a05:620a:4693:b0:915:c7ad:8bd2 with SMTP id
 af79cd13be357-92e9a3be669mr1067111985a.30.1783289118768; 
 Sun, 05 Jul 2026 15:05:18 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c12b62c53c1sm610661066b.45.2026.07.05.15.05.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Jul 2026 15:05:17 -0700 (PDT)
Message-ID: <6c0ff642-8125-4c35-8ed0-8f89da555ee9@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 00:05:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv/virt: Add optional UART1
Content-Language: en-US
To: Yanfeng Liu <yfliu2008@qq.com>, qemu-riscv@nongnu.org,
 peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org
References: <tencent_06551FAEA44CD75E915AE611FCA0C99CDD09@qq.com>
 <24329582-f5cf-41de-aabe-c2c3d54f03ea@oss.qualcomm.com>
 <tencent_3045B23CF7A9872F29FC351E24D8F9373F07@qq.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <tencent_3045B23CF7A9872F29FC351E24D8F9373F07@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIzOSBTYWx0ZWRfXxx5PEGp3b0BP
 t9oKZ8v6PbHwkL6c0i56n8aRKAH1baZqxHdyik1Q54qaLqE/cNyk6btWbm5Hu8CmeagvT91TV6i
 E7afGfJ+8RTD7Mt8zAba1oOT734q314=
X-Proofpoint-ORIG-GUID: w75dR6xFjg2wb0DSW4y27o2rbeSLxwTi
X-Authority-Analysis: v=2.4 cv=J+yaKgnS c=1 sm=1 tr=0 ts=6a4ad520 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=dZbOZ2KzAAAA:8 a=4iFUP5XX9WVA2vuhWywA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIzOSBTYWx0ZWRfX+hB1xBpn8Fq6
 L9TnQ/8nvSQGi4Aw13low33Fn23R66KiQaWemMJtNtrYUq+jmsph9G6KZst1WlaccyRE+UNx9iJ
 ZuXQuzbEIa1Tx0rOL/oaWWWKH5sbsuEJjnVoQFR1zgf6aWf0n5nY2QmMqyjgau1fdmhZk2Aq0r8
 vXnV0tKBAEOC9MQOHtbmOWLrCSwh5Bb1AB0OLLAvcosSEwYmIOC3Ltl6Ij0m+pVV9ghENUQUlZG
 MWnJfkOUkdqBSbX/HFbP5FgDe13tn4YP1kVGv2cle/6dJajj0ybtLrPMbzRxLgMCTtqgnGxjme1
 VWnfkjz1CQ1wxochgXXVcJi/5egkW6tg6T3XimHTef3JJYCXQAiP4KmrpRbq+umA3MRFpOh/nX0
 LEPskwM62Daw/Trl3XU9rRKeTD4CuRr4j0S71qvKRhIS7kWY1tK1HPTh4/t7tJ8theYuelgyp9Q
 3/JiNiLM+BFbr7FCxSQ==
X-Proofpoint-GUID: w75dR6xFjg2wb0DSW4y27o2rbeSLxwTi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050239
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

On 4/7/26 03:41, Yanfeng Liu wrote:
> 
> Philippe,
> 
> The v1 always creates UART1 carelessly, then Peter suggested following
> 5d8a250f9068 (openrisc) and e7100972f2 (arm) to reduce guest breakage.

Oh I missed that. I'm confused because I thought not checking for
backend use of a chardev (in particular calling serial_hd) was part
of Peter's recommendations, since he did that cleanup years ago. I'll
let him finish his review of your series then; simply ignore my
comments.

Regards,

Phil.

> 
> I looked around and noticed the pattern is used in arm/virt, arm/msf2-
> soc, arm/kzm, xrtensa/sim, and ppc/e500 etc.
> 
> Please give me clear direction here.
> 
> Regards,
> Yanfeng
> 
> 
> On Fri, 2026-07-03 at 11:31 +0200, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> On 3/7/26 06:24, Yanfeng Liu wrote:
>>> This adds optional UART1 to RiscV virt board if required at
>>> runtime to simplify multicore development.
>>>
>>> Note that UART0 remains default serial_hd(0) and it is:
>>>
>>> - the lowest address UART
>>> - first serial in DTB
>>> - behind /aliases/serial0 in DTB
>>> - the /chosen/stdout-path in DTB
>>>
>>> Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
>>> ---
>>>    docs/system/riscv/virt.rst |  5 ++++-
>>>    hw/riscv/virt-acpi-build.c | 12 ++++++++----
>>>    hw/riscv/virt.c            | 39 ++++++++++++++++++++++++++++-----
>>> -----
>>>    include/hw/riscv/virt.h    |  3 +++
>>>    4 files changed, 44 insertions(+), 15 deletions(-)
>>
>>
>>> @@ -1567,6 +1579,13 @@ static void virt_machine_init(MachineState
>>> *machine)
>>>            0, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ), 399193,
>>>            serial_hd(0), DEVICE_LITTLE_ENDIAN);
>>>    
>>> +    if (serial_hd(1)) {
>>
>> Checking for chardev backend connected to map a peripheral block
>> is an anti-pattern; the block exists on HW regardless.
>>
>>> +        serial_mm_init(system_memory, s->memmap[VIRT_UART1].base,
>>> +            0, qdev_get_gpio_in(mmio_irqchip, UART1_IRQ), 399193,
>>> +            serial_hd(1), DEVICE_LITTLE_ENDIAN);
>>> +        s->uart1_present = true;
>>
>> Thus we want to always instantiate all UART peripherals.
>>
>> If you drop the uart1_present field then the patch LGTM.
>>
>>> +    }
>>> +
>>>        sysbus_create_simple("goldfish_rtc", s-
>>>> memmap[VIRT_RTC].base,
>>>            qdev_get_gpio_in(mmio_irqchip, RTC_IRQ));
>>>    
>>> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
>>> index 18a2a323a3..7d57c8292e 100644
>>> --- a/include/hw/riscv/virt.h
>>> +++ b/include/hw/riscv/virt.h
>>> @@ -59,6 +59,7 @@ struct RISCVVirtState {
>>>        int aia_guests;
>>>        char *oem_id;
>>>        char *oem_table_id;
>>> +    bool uart1_present;
>>>        OnOffAuto acpi;
>>>        const MemMapEntry *memmap;
>>>        struct GPEXHost *gpex_host;
> 
> 


