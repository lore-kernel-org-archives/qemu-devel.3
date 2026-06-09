Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E708CD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWyFr-0006jn-Mb; Tue, 09 Jun 2026 11:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wWyFq-0006jY-BE
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:20:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wWyFo-0007Wj-LL
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:20:38 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659ClGHa2251529
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 15:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5r35yqGg++eG69S7IlAB1e8plPQdyhU2WVyd+BDdsac=; b=iwPrt9ojx6TPd2ht
 sqSSmlALv4ehhEO9vFS8VMfBGF7c54K+s8Yf4tzbvzkHFty/xorHCh8SF+kOealp
 4Yr8hesHJUwGtJHqeKPRcVfuz7+/jEmnW+4WBWyTvQhVruWiKml/ektawoosLyeH
 fge9E/8RoVB9GRligFuEIRiQmRY8PKAw0xxNjezHyUQo5AD35rYqAsGCc/6KIFYU
 +bOHxPF7qXOZ5MbogZ7oesov3+1O9ULI1gyqcE+Y29r2aBUy+rs832jUXJ4UDRcH
 BHiEcEOLGjJTyNhaIJW1Yp0+N76xJNMXolWxZZLC5xHmpbCbNB9La5611eMWKjfd
 5gQ7Bg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epeqgj4tm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 15:20:34 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-6c6dc39a6afso3021325137.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 08:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781018433; x=1781623233; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5r35yqGg++eG69S7IlAB1e8plPQdyhU2WVyd+BDdsac=;
 b=iCN2LqRFoMww4ytPwUII7hudeZl3XStmztbdEUPTS87jDKkrcGBrxt9fMwGrx0MzYw
 jgKdSsOEQmKY/CgXmRJPaW1JC0/QXMwoo2DkU4xUbPmGO+fqvGvj9+rAP3cHa2RTSn1x
 TXO2r8PN8dg0/7qJH2YXq3h5gVpfHSwlkdtlV3ir9Evzgay8krdRXJlPg5g/FlfH0nad
 rKjsv0FAxW8PUSnuMW65fKiUeqN0HpcWiR626Rwuf4Z9sBTvtTUmBRVn89o6PkE8GI3T
 woTtc2jxV8wWDUgGqRhHNp/rXz2G0yglSHO/DVEol6NCDFCMxIE9DvaDu1pXSc/1WBig
 zt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781018433; x=1781623233;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5r35yqGg++eG69S7IlAB1e8plPQdyhU2WVyd+BDdsac=;
 b=U6lnqNWJ3A31k82Yi1nrmHIYytmfNNCZQ5eo9aUTtTs96T9tTVksTZDLZvZBT2/1e6
 SJYGPXGXVO0AtiUByhDh44CVPPtwNbIDXIird+jf0qXwvcJSwsRIZnAaH2z/xYw/Cj4p
 CkBealI8nbbE1eoAS7t8xP/00nrFJeYmlIhh/Ekmt2eKxz9JlSkuzpFKndoGFPvgiVXU
 yhK99IigGnsAStrfAjjuYMMTyj6IVr7aa8gf5cKxpH7/GyJAq0dJ97l5/0WQ58Nhq/YE
 8IJclw1jVh15pfLCCHrAZTn9V1aOC6v/lXMa9iVsCFZoqHU6Tf9E8BnC++MGA2se3vwr
 Vuqg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9lijOt1CVAAcXD5QEIuFRLJXHDFEwveYZKNn/OkZr8I7b9i16j294jIrfdSlBEn2XZXcODq1R/8zrI@nongnu.org
X-Gm-Message-State: AOJu0Ywt5b+ReY/WZbpQFLq3OS4IzglNYKiXa8GAfua3HW4rhQ3Lh/JY
 MS4JNT0SO1EEQVCWGy9/kjf8RkYE+CJvUGp527NO3OVIbM3POHRFLqaqCSexd8cNTLS768jRER6
 UCTGTJL16JcFSCT3tY6+WryuT+NzMtJvyKGyfN2NDFZNA743jgnPX7nMqdQ==
X-Gm-Gg: Acq92OEX7xJLEEZA1v0ZjPSTV3AVY0Pac0OzehM5jJBlWgaL1DIddQXuPA2rWZ/f3Uf
 LjEexwlp1zDADwTjLQLGHeltv20A5s2u8AlKhPk7zDNgn/7mtJZS2Ake9MTBuSFhsqfLcvIby1x
 MpwCWxHIWiiagPqO9JhYkk0BxIcJT4MqwBV12zB25VvuRFpPEvalAiNSv6xgce7b4ysjnHG3/Oq
 OWxFbXp9NA5cvWRgaUaoObNEpJdDduNmI6UejX3khA6JpsmYJehaLhv3i+ZCXOdhUMOKOvQMgVk
 geXppqtoJCi4rJ5LDPMpMOvn1wwbmTDJlHsHAZJk8wF0aNvQErEndZuEHGSg7BKJ6nxpOLTuw7e
 ld9XmuRiPdZcAnieXhAfso70aisDDel4se1DR1YQ7DcnPrs6mH88kajFXzzsMDyOomaU=
X-Received: by 2002:a05:6102:94c:b0:6cb:d562:b96a with SMTP id
 ada2fe7eead31-6ff02387516mr11454613137.14.1781018433146; 
 Tue, 09 Jun 2026 08:20:33 -0700 (PDT)
X-Received: by 2002:a05:6102:94c:b0:6cb:d562:b96a with SMTP id
 ada2fe7eead31-6ff02387516mr11454536137.14.1781018432697; 
 Tue, 09 Jun 2026 08:20:32 -0700 (PDT)
Received: from [10.156.84.244] (113.170.88.92.rev.sfr.net. [92.88.170.113])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf054dfe3aesm1060817666b.37.2026.06.09.08.20.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 08:20:31 -0700 (PDT)
Message-ID: <de269628-00bd-4d50-842f-55e90dcd186d@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 17:20:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/17] hw/input/ps2: keep QemuInputHandlerState in PS2State
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20260609-ui-input-v1-0-42615deb818e@redhat.com>
 <20260609-ui-input-v1-10-42615deb818e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260609-ui-input-v1-10-42615deb818e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE0NSBTYWx0ZWRfX3PSHVt9iEsSC
 wWMKwXA5M7H8DSoeff/yKHBpmWWRjxEDSaEWsf0gC8hyzzlLJZeT+JR7L8tW8cRhHa/0n9jZwbr
 D6Pi6Bc6178DsPkw32N6mtwqtsgi88efSonXplcFzl+ebqWvspmgoLRUhq/UT0rJHOBxm3j0Y4s
 YZujgF3zrdTpTDuZ8+WcKYiO7ZUZtCcqt30BkfCt/+JAKoHU4a8aYL560SGQAWRqd9Qss1cLcAK
 fM5lwDL56fU+TQZr/7c1Um0D9FjlR7jcE7RVHI/NkJa81IOtjQy7YoaCBdl8bduCXw+FrEio9uG
 Sa1XnQKeNiXV4Ql/ARfLw+eVN0KD4urSfU8eXfN5yy+FDO0uoRrlXSsX2UuGGM+U5AN8vwOUxE2
 3jyv0EjOryRthtWEZVy9dUDh7VkLtqqWoBJTuKj6UgnKra1ppX9aUQq0RkufsqSP5f6MQ7DiQAZ
 lmSuJ6jXsFOn81nbafw==
X-Proofpoint-ORIG-GUID: FJwq3QbGzudL4o71OY2jqs8AHLFmKquZ
X-Authority-Analysis: v=2.4 cv=KdHidwYD c=1 sm=1 tr=0 ts=6a282f42 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=ASywmo1ADVsXjDI2RVyDAw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=WkbpMPZKrzgXMzBxJacA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: FJwq3QbGzudL4o71OY2jqs8AHLFmKquZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090145
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

On 9/6/26 16:34, Marc-AndrÃ© Lureau wrote:
> Track the input handled state, and dispose it on unrealize.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/hw/input/ps2.h |  2 ++
>   hw/input/ps2.c         | 24 ++++++++++++++++++++++--
>   2 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/input/ps2.h b/include/hw/input/ps2.h
> index 058db3e0890..d0c532a38f2 100644
> --- a/include/hw/input/ps2.h
> +++ b/include/hw/input/ps2.h
> @@ -26,6 +26,7 @@
>   #define HW_PS2_H
>   
>   #include "hw/core/sysbus.h"
> +#include "ui/input.h"
>   
>   #define PS2_MOUSE_BUTTON_LEFT   0x01
>   #define PS2_MOUSE_BUTTON_RIGHT  0x02
> @@ -59,6 +60,7 @@ struct PS2State {
>       PS2Queue queue;
>       int32_t write_cmd;
>       qemu_irq irq;
> +    QemuInputHandlerState *hs;
>   };
>   
>   #define TYPE_PS2_DEVICE "ps2-device"
> diff --git a/hw/input/ps2.c b/hw/input/ps2.c
> index f2523ff4bc7..97df7a9a43e 100644
> --- a/hw/input/ps2.c
> +++ b/hw/input/ps2.c
> @@ -1233,7 +1233,16 @@ static const QemuInputHandler ps2_keyboard_handler = {
>   
>   static void ps2_kbd_realize(DeviceState *dev, Error **errp)
>   {
> -    qemu_input_handler_register(dev, &ps2_keyboard_handler);
> +    PS2State *s = PS2_DEVICE(dev);
> +
> +    s->hs = qemu_input_handler_register(dev, &ps2_keyboard_handler);

Should we annotate qemu_input_handler_register() with
G_GNUC_WARN_UNUSED_RESULT?

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +}
> +
> +static void ps2_kbd_unrealize(DeviceState *dev)
> +{
> +    PS2State *s = PS2_DEVICE(dev);
> +
> +    g_clear_pointer(&s->hs, qemu_input_handler_unregister);
>   }


