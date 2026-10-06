Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DF4CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 00:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEFuy-0006iF-Gl; Tue, 06 Oct 2026 20:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEFJe-0001Zp-8W
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 20:16:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEFJD-00011j-Iv
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 20:15:11 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6969Xbkm801248
 for <qemu-devel@nongnu.org>; Tue, 6 Oct 2026 10:01:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OrTB1UEgNvk9qRTstESWngRSI9amH7wWSHnxh6O1xdc=; b=cj3n45aKKYrUnvpK
 ozOW6VUWs4qtVYbHA/tSefVWAl3fz85fMKD7eYGoVDAVq3E7DgKF7vB7tP4bK2aP
 gWrUjwIHUmWuE6DvklP/5/flG8GycDKGNYVRQ6pZ74oYdREZZO0YOVe0m6WBe8J7
 cAUJJd851UtS+AY5Xdkbi00l8qi9Vbq7czHizbT/UuEp3VNnvxYqxDXq3/YOjUx+
 H7YRbLAEOLUMqU+f+wnww04rVb1OXf2QiRJiilznXPTBxwzEJU9kUz/Mq3E5owOk
 bmfeAIXNMHwKtvfRlfxzbUtctiGndZeVzt+5RuzZ/DLGQTeGQaPlJ2DHfHIeWNiM
 /5492Q==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xfbg3c6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 10:01:56 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7c0f07b4e97so2297321137.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 03:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791280915; x=1791885715; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OrTB1UEgNvk9qRTstESWngRSI9amH7wWSHnxh6O1xdc=;
 b=PQa4D1bAi+l9l8HcfUZqikk1r1q+zWGbqtDGeulBTeaMdR3wU0zSEFIVxZ4OH2QDTj
 t+MGi3u3ouFhsf6nUAcoN2V//ziShT5KXRMpTCRv52QkWa6j/YF7YZ/pus+MdLYVD3tK
 t6FKR38IaCL9r2HD0Vzru4RVtx5hpGsrh/cDRCnWLByDVlohdRcV/qetTMh0ia1r66zQ
 Q3GeK3RiAVvuSLYTlBQsUJWyZSmYt6vPHu/MbfSepFpOIrEWfDHuEJ0Aio5nzGpGcK/O
 IURrRhJtlVa3KaRukNOCMV0rYzgQNDJ59Crhx0VRK7sTI5iHiqQhgvSDu/D4HSB7SLz0
 a4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791280915; x=1791885715;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OrTB1UEgNvk9qRTstESWngRSI9amH7wWSHnxh6O1xdc=;
 b=UgBZp97mZAQm7rTE62gjFbiN+Pir2i8HpBraqebPeT5uisgohETQ2/E62G42F61O+z
 XDMFQmODWgXPqJK5oIbt7xDGnA6nOnXcvyJ4h1J4aEK8g45ofjKCrSATeHlFVdB2rChq
 t5msizIuPCEOeoQWDQLqN/l5ypzHqfiDl1asTvDfjOmL6XZRTww48uyN4LBCazY+kx2f
 88n3NRO0fLdNHB4UAAJCpHdBZzXT3O5rR5r5RdQKHtU2DZCvvTOB0auuYYrydCmp+81R
 4h+02emUP6yQAWUeHZDgiGG62jKBwr00BvyX7i2EZ5KxTogO9LYEF9dLFIXIAV9SXLPs
 u9HA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy0zy4SvuhZ0DpS9QynPgkE/mdHx7H4uLiVCkBSxpzN+eq4CdimvhT8KhejYE0DasAjrmrcBgneqBR8@nongnu.org
X-Gm-Message-State: AFq9FYKaPtNDrKotKks9cc56lqZ4vpQTsKZqdpbBhXWSQLK2AvZBlzIY
 O0EH/SZpJzd8YbEIaY7Qf0+aSSBlEMnyG3yL3LKjYBbY09EpOofMjEvZwSattbckZeDVpSCZsuz
 18bxblZ3Y99d542DztzwpaFdRGCrmUwZdgmi5J/0NQhJiDt3bXRMHevmEIQ==
X-Gm-Gg: AYBFou0P5C5Kox7ys+LocXb5s4k1ACBOgE6wWZcLFIhqQUo0nK4wF4m9zs9DhyF24p5
 73fI46xyOH3FSbreJQFWD2UIerKOokd+urDSFkrNu8JiAD/ZISgrT1IZkiNlE5VCUKmrX/eEUBp
 UqDRRZ36LSM6mQhnM4ZeYxGfcnz6logQNFdbJtQuVdbRpEgkXHffxZF7dI9uzL+JG7M4CmFi8Go
 WPBbrBt7Og0iosQJjyhEZgBJ5Ioj+y3Xl+wqmjY250x64Hbcj30nhdYkKn+JC1Eis85CldTa0b6
 2fQyd5wYil0cDDz3QV2nf7LG914qlYYlLIBmg1Lg5XDxHlNPS3Cj8Mglil3C0HKJ8Y0Eo5/jTbv
 hFkcJipy9mY0/krhXnnk0lg==
X-Received: by 2002:a05:6102:4189:b0:7bf:6218:bc59 with SMTP id
 ada2fe7eead31-7c87c7e7ec7mr196469137.32.1791280915510; 
 Tue, 06 Oct 2026 03:01:55 -0700 (PDT)
X-Received: by 2002:a05:6102:4189:b0:7bf:6218:bc59 with SMTP id
 ada2fe7eead31-7c87c7e7ec7mr196454137.32.1791280915019; 
 Tue, 06 Oct 2026 03:01:55 -0700 (PDT)
Received: from [10.111.138.48] ([212.136.9.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a178c5d8dfsm63810545e9.14.2026.10.06.03.01.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2026 03:01:54 -0700 (PDT)
Message-ID: <9fff40ae-6378-41c8-9cff-74d4a15645de@oss.qualcomm.com>
Date: Tue, 6 Oct 2026 12:01:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/31] hw/arm/fsl-imx25: Derive from TYPE_SYS_BUS_DEVICE
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-arm@nongnu.org,
 Jason Wang <jasowangio@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
References: <20261006083445.30362-1-shentey@gmail.com>
 <20261006083445.30362-13-shentey@gmail.com>
 <d63caf07-24f1-4911-b0f9-f375c48b6159@oss.qualcomm.com>
 <1EAADDBD-1ED9-47BA-81AA-E6539880B7E4@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <1EAADDBD-1ED9-47BA-81AA-E6539880B7E4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=D8TSufRj c=1 sm=1 tr=0 ts=6ac4c714 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=FRSEYCzRAAAA:8 a=pGLkceISAAAA:8 a=pDo3CIXR1aYm_AGmTWgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-GUID: c_YnPz07fsjHurXHDDm1b07T5cf1-ADn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzOSBTYWx0ZWRfXxNjoyQMHqdO4
 fG9WiAV0iSZYpZaqfHh2en0Cv3MLMaQFkrHrbH41GoESpR5AdfE6CgynnoP1yyhYRUFEKz6EzhX
 A/ywLSHteeskD3W0ueBMXrJKcnPydJo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzOSBTYWx0ZWRfX4ik3kYtALp1p
 WEwX8Uk0K7/xtMPAUqUK0PZaZ1gGNjgcoIWim/Zh8mikh8KMjAcW3uS+Hs0bIAhKgVOVQFRFubR
 oKfSnLROdDheR27MMw7mShuxa7OdjGXcRsAGghF0hLObfn1yxP4n5dkFK+JuLNuGC5KazGdRnBD
 WFawcfv1eE1+1ufWXQ3ioSw79Vnb9cG6CIVMlOrvJxtAViw+Syy92Majwwf6ffGgrGiCIbCpXrX
 JYZrNDYD3gzS6zkP143v8kCkVmcQ/AZynuChwRjaXmLsTFAwQ5v84setH0kWGqMgz0wuQS1cJIr
 wkAeN++7ulXhh9yqKLWQYNkqHLeql8jlGugu8DYiF/85vPUpVktVAwoh9FCaCi13c/dwZqPr61F
 LJkCvwKot+UlARxfshxIWJ7VV9efjVEgGVI0lB5Ids9mrIe/WxX+Z9jrMwcD1yma5DjZP7s1/yj
 Dj+ODTch4QmF82AmYfQ==
X-Proofpoint-ORIG-GUID: c_YnPz07fsjHurXHDDm1b07T5cf1-ADn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060039
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 2026-10-06 11:47, Bernhard Beschow wrote:
> 
> 
> Am 6. Oktober 2026 09:26:52 UTC schrieb "Philippe Mathieu-Daudé" <philmd@oss.qualcomm.com>:
>> On 6/10/26 10:34, Bernhard Beschow wrote:
>>> Deriving from TYPE_SYS_BUS_DEVICE fixes the SoC object to be reset upon
>>> machine reset.
>>>
>>> Reviewed-by: Bin Meng <bin.meng@processmission.com>
>>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>>> ---
>>>    include/hw/arm/fsl-imx25.h | 5 ++---
>>>    hw/arm/fsl-imx25.c         | 7 +------
>>>    hw/arm/imx25_pdk.c         | 2 +-
>>>    3 files changed, 4 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/include/hw/arm/fsl-imx25.h b/include/hw/arm/fsl-imx25.h
>>> index b68d4334a0..4bb4d5b3e5 100644
>>> --- a/include/hw/arm/fsl-imx25.h
>>> +++ b/include/hw/arm/fsl-imx25.h
>>> @@ -29,6 +29,7 @@
>>>    #include "hw/sd/sdhci.h"
>>>    #include "hw/usb/chipidea.h"
>>>    #include "hw/watchdog/wdt_imx2.h"
>>> +#include "hw/core/sysbus.h"
>>>    #include "system/memory.h"
>>>    #include "target/arm/cpu.h"
>>>    #include "qom/object.h"
>>> @@ -45,10 +46,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslIMX25State, FSL_IMX25)
>>>    #define FSL_IMX25_NUM_USBS 2
>>>      struct FslIMX25State {
>>> -    /*< private >*/
>>> -    DeviceState parent_obj;
>>> +    SysBusDevice parent_obj;
>>>    -    /*< public >*/
>>>        ARMCPU         cpu;
>>>        IMXAVICState   avic;
>>>        IMX25CCMState  ccm;
>>> diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
>>> index 7f65f4ca4b..efb22359c5 100644
>>> --- a/hw/arm/fsl-imx25.c
>>> +++ b/hw/arm/fsl-imx25.c
>>> @@ -317,16 +317,11 @@ static void fsl_imx25_class_init(ObjectClass *oc, const void *data)
>>>        device_class_set_props(dc, fsl_imx25_properties);
>>>        dc->realize = fsl_imx25_realize;
>>>        dc->desc = "i.MX25 SOC";
>>> -    /*
>>> -     * Reason: uses serial_hds in realize and the imx25 board does not
>>> -     * support multiple CPUs
>>> -     */
>>> -    dc->user_creatable = false;
>>
>> Can we explain this change?
> 
> SysBus devices aren't user-creatable, are they?

"Remove clearing user-creatable which is implicit for
  SysBus-based devices" comment would have cleared any
  doubts.

