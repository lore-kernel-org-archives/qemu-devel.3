Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A191C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzVoy-00082H-JA; Thu, 27 Aug 2026 04:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzVon-00080K-GT
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 04:50:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzVol-0000kv-Lh
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 04:50:41 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R6R9cs3257853
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 08:50:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 40rN5bwlaPuxqv5tDaLHOUPXPfypNCn9j4ojI/TTEN4=; b=WGGT6cU9Bfjyfwfa
 mkPrgIuAXanyZx20aAk/RPWEyxm+7n8/zmzZWoTseOLD57LTJ5wZZYJ8kXa1w1CP
 TgaOpGN/T4BArh+HWyn3RoI9hhYSIu/uN+dZsDABcP7h+oL6SDLCcqlKFeJ7azr3
 2z08ybOCEM2PGrysDeVN5m5pSYGTKhpTA53AHQ8xPc3ao9Y4pRtZ+jvnASh6TKiE
 K1OgMqbv9EeQKsax+nfifAb8O6zcoquB84dn/gS4z/Dur9PjzlMhOTL8dkwauJyS
 jDffWUn+bxvrJtqCEFQmUm+cIu0yYQtHKpaqLzMJagb5mJSFk8z3Td4bv2oQtfLg
 Ht3rQQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga4ecavsm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 08:50:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-936aa34873bso159416485a.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 01:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787820637; x=1788425437; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=40rN5bwlaPuxqv5tDaLHOUPXPfypNCn9j4ojI/TTEN4=;
 b=jx0MOoCuAH853Dkj3mxvOWCxLs6h2n0T/0brfQ/Q8tiquMmEjfsRNX/DQy9e/hB3wo
 I3561AMaHNiEvweyVkvQw9K7kafmTymckVHjGnJKGtbMWxqwjaIgITkw5Ea2jtS/XBEq
 uQDV8JYh4UrpR7HPV3hEMmslXcFsI2ly4AZrz9YgTOmD/poIYc+JsRk0GqaAXXg9pbbo
 zM1hRsuurQb8qmPpHTVmQsLokcjxM5kJ54XsI6yk//yi4FumZvLniWd0Dmj6skA5xzAe
 qNtLbYVGbWLznLCUhVV1nLaYZd3VmBKEp6EKFEwwPl4X171YpA8Gq/DABUcFhmMVgC93
 5WNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787820637; x=1788425437;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=40rN5bwlaPuxqv5tDaLHOUPXPfypNCn9j4ojI/TTEN4=;
 b=q2xPey7wYodNFQsUdUDkC3UM32/mr8Ipz86DCOtH4ML0LDxLuLGJ6XugDjQdEcdOug
 qELIEGnpPQHSIPriirZZPXAA9Xls0XTBiUtmpyVAwMUr/iECKLwA8vow+FtiI1gUWXzb
 +UpzoNoT88uwBWFIclFThdVcUSOjeYgd3Mxrv6J4XA73N/LqjBKB9Z3RvqEkFk+jQD3K
 NE6c27cUsnWLg0JXLP/Ujbp5NJ5AX/SWUIvTC8J4gGTpj8Nd71UHo0ufYKCbAHOhBCH7
 683pMX39obouf0Gl1zkn8+/By017BZqdMeELqpGXVkCK9MaZtrcLAcinsk73Axj8A8up
 DSFA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrXI7gc3J644EO7MNfZDK1/hDidfBA5JTQLRxDi7hQdO3Z421ZpbzwoUJuKinX/miWxjUYnIpHGYaWg@nongnu.org
X-Gm-Message-State: AFuF++ljMeC8w0+7pZF38jTvqUMPxzoHC8lUT6gsmzUX0rMp+oUKYLzb
 MpQ3n6u4MT3FPrIbTffao0SsC2u7iCk8MhiaTJrAlLSio+n1eVKt6brMbuQdJAADgOabCzqeLvq
 ZdXiknYcRrLqor7xQIphpjcgYiOkdoob8xVI8t3liOuDyEDLWSFXfZCArrA==
X-Gm-Gg: AR+sD12S10hlfGQP63tht1ctyNotg4ajKW/8j3r6KLGd6TdBPStztfNFXfbPwGtOPAk
 vEvgX2oGmtwgvk0auXSmzwo2u0AkOLpubk7/Ct0CZQ9nBk7sV8P5lCgSkNG6FXSHZVnbdFcWQSc
 UzV30O3J7CMkkzoE3UADj3G9WxI/nhX399EcbQ+dvxpw/4Wp4SJPa49/BXDhhMVM+YQUr5mdqpH
 Eo0DOxKdPlAhu3Ov5xwayrjNPa0zpF1D4sRcxLKx/lm7neuF/2BMjgRpjJYcLRcZlH0zajMCoxQ
 zQQmSwCHL/80GdtcYHNPuo5MHTXqAno42c6UjmvsmC5ACYdN6bkovGLasAPp/lR9gp2cARtqTh4
 EJYAs+01X94VyZiJu3cp/QH7MaLREk95R8H4EP5q42vIv4SWe
X-Received: by 2002:a05:622a:148:b0:52e:12e6:6d7b with SMTP id
 d75a77b69052e-52e423f69fcmr128780001cf.39.1787820636876; 
 Thu, 27 Aug 2026 01:50:36 -0700 (PDT)
X-Received: by 2002:a05:622a:148:b0:52e:12e6:6d7b with SMTP id
 d75a77b69052e-52e423f69fcmr128779661cf.39.1787820636455; 
 Thu, 27 Aug 2026 01:50:36 -0700 (PDT)
Received: from [10.254.188.74] (164.170.88.92.rev.sfr.net. [92.88.170.164])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b49cc61cfsm35507555e9.6.2026.08.27.01.50.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 01:50:35 -0700 (PDT)
Message-ID: <33c9db8d-2004-482a-8d86-5400252fe2d2@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 10:50:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] hw/char/cadence_uart: Reserve MMIO with dynamic
 size
Content-Language: en-US
To: Kuan-Jui Chiu <kchiu@axiado.com>, 163wangjack@gmail.com,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org
References: <20260826074635.2850931-1-kchiu@axiado.com>
 <20260826074635.2850931-5-kchiu@axiado.com>
 <5e22ac73-0650-493d-a099-c88cbb74b397@oss.qualcomm.com>
 <a3210074-7795-4a9b-b72e-aea0efb53664@axiado.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <a3210074-7795-4a9b-b72e-aea0efb53664@axiado.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KIBqylFo c=1 sm=1 tr=0 ts=6a8ffa5d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=T/Q9W4kDmp1FI4VDxy1skw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=440cDlBIAAAA:8 a=IMLJHsy39I7ZlmX_EL8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=d9D1X1bx8dWolqnE4HNT:22
X-Proofpoint-ORIG-GUID: HlPQIlbdSrrCp0tf2SPXucIwWmhIM3V_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA3MiBTYWx0ZWRfX62JkL7DTq/VN
 +yIri/h3DTNmxGNFQUKZXsvyZC6vKb91U/fcWzHqhis4IOZx/LmijvpjuGsgD1NzTKlOTEu4joE
 ERY9UBAr6MCuFSYYsf8ijoG53V9lVrV3KdQ9OGI4/fIRABb+4Iznb9NKVy1Nm0MR2pi51Bd5DWb
 CMxp8FTFQbkE+LHI0Nx1Qh4cIT+O/Jikow/PcI1eyxpaRYiBjQoxkBTh3H7NplirBkpENkUcXJ6
 Sud0nMR39aTszrczg1X0Z2jr20DZEiXZen5tX5CraomtncANnnfyrEKDSKUes0lrnbwhjX1R7yy
 wvcdoxgWKVL1cYCKBXitwXt1Cr3z7dWyg7UtPmimCjH53ZRdLAD8WCbxplfyjY5ZsCQjnsuW/1V
 nGboUtSlpLXKsSgdWWYGDTEGsnft7jk4FSkHZ35wLBPmUBb9+jmivW71cdTO+IVSL/nKIhKUmT1
 1X4blM4eApQwvcbWs0w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA3MiBTYWx0ZWRfX+zRv+tsA3pS3
 PEbLftmKUvaC5RUKRTMFj9ZXxUGQcbBxrClHKGmUIinFxwMU1cWtb/oLayYOe86Oi7E6WOzy6ZI
 w6EXXUB8PsJqi1dXqYhI9NmQOBM6yr4=
X-Proofpoint-GUID: HlPQIlbdSrrCp0tf2SPXucIwWmhIM3V_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270072
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

On 27/8/26 06:26, Kuan-Jui Chiu wrote:
> Hi
> 
> Philippe Mathieu-Daudé 於 2026/8/26 下午 04:11 寫道:
>> CAUTION: This email originated from outside of the organization. Do 
>> not click links or open attachments unless you recognize the sender 
>> and know the content is safe.
>>
>>
>> Hi,
>>
>> On 26/8/26 09:46, Kuan-Jui Chiu wrote:
>>> Candence UART model is reserving 4 KiB for registers statically
>>> For other SoC models, the MMIO size may be not 4 KiB which would have
>>> overlapping sysbus regions in QEMU
>>>
>>> This patch adds a property which allows other models to revise the MMIO
>>> size and it is 4 KiB by default
>>>
>>> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
>>> ---
>>>   hw/char/cadence_uart.c         | 8 ++++++--
>>>   include/hw/char/cadence_uart.h | 3 +++
>>>   2 files changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
>>> index f57cad57a8..d83c71b877 100644
>>> --- a/hw/char/cadence_uart.c
>>> +++ b/hw/char/cadence_uart.c
>>> @@ -541,6 +541,10 @@ static void cadence_uart_realize(DeviceState 
>>> *dev, Error **errp)
>>>   {
>>>       CadenceUARTState *s = CADENCE_UART(dev);
>>>
>>> +    memory_region_init_io(&s->iomem, OBJECT(dev), &uart_ops, s, "uart",
>>> +                          s->mmio_size);
>>> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
>>> +
>>>       s->fifo_trigger_handle = timer_new_ns(QEMU_CLOCK_VIRTUAL,
>>>                                             fifo_trigger_update, s);
>>>
>>> @@ -561,8 +565,6 @@ static void cadence_uart_init(Object *obj)
>>>       SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>>>       CadenceUARTState *s = CADENCE_UART(obj);
>>>
>>> -    memory_region_init_io(&s->iomem, obj, &uart_ops, s, "uart", 
>>> 0x1000);
>>
>> Are we sure this size is even correct and not a copy/paste error?
>> We can clearly reduce it up to 0x80 (so far the last register
>> implemented is R_TTRIG at address 0x44).
>>
> No
> 
> It is 0x1000 since the first release of this model

QEMU model use 0x1000, but what the datasheet says? I'm
suspicious using 0x1000 for the current model is correct.
Can you point me to the datasheet please?

> 
> Sure, I will change it to 0x80. It would be a simpler fix
> 
>>> -    sysbus_init_mmio(sbd, &s->iomem);
>>>       sysbus_init_irq(sbd, &s->irq);
>>>
>>>       s->refclk = qdev_init_clock_in(DEVICE(obj), "refclk",
>>> @@ -621,6 +623,8 @@ static const VMStateDescription 
>>> vmstate_cadence_uart = {
>>>
>>>   static const Property cadence_uart_properties[] = {
>>>       DEFINE_PROP_CHR("chardev", CadenceUARTState, chr),
>>> +    DEFINE_PROP_SIZE("mmio-size", CadenceUARTState, mmio_size,
>>> +                     CADENCE_UART_MMIO_SIZE),
>>>   };
>>
> 


