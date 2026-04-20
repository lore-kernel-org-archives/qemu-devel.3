Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4085BF36C30
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 07:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEikv-0003ot-JF; Mon, 20 Apr 2026 03:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wEikk-0003mF-T8
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 03:09:08 -0400
Received: from 11.mo534.mail-out.ovh.net ([46.105.33.174])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wEikh-0003Xa-Lq
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 03:09:06 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4fzc686vv0z67hc;
 Mon, 20 Apr 2026 07:08:48 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Mon, 20 Apr 2026 07:08:48 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.231.30])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4fzc681rbmz1xrk; Mon, 20 Apr 2026 07:08:48 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.0])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id E9F5F203A99; 
 Mon, 20 Apr 2026 07:08:46 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R00207c970ca-cd83-4aaf-bee3-afe8e999efe3,
 EAA5D49A92D75878AB6B5DB8F91ADF3A5E4E180D) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <8ae66243-d55d-4d7b-bcab-dbdcd680aaf7@kaod.org>
Date: Mon, 20 Apr 2026 09:08:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/17] hw/usb/hcd-ehci: Add descriptor address offset
 property
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
 <20260416014928.1279360-14-jamin_lin@aspeedtech.com>
 <04a8d8d9-f605-4bd3-8468-0e2840ae8311@kaod.org>
 <20ee6c39-d0ff-4e07-95e6-5aeb86dc0916@linaro.org>
 <TYPPR06MB8206A19AD70BA0FAD7F68B15FC2F2@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <TYPPR06MB8206A19AD70BA0FAD7F68B15FC2F2@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 15060037153932094475
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGOONcY8WfF7Jme1UGg+GJHMyVjGqGmwrsmYULqCgRcLNJ1vZcUWp7fFX0ZI/N5k9LpzcKATgBpXg/8hRZtoYYctEOw51eZ52OHtzBDiUnjxuRwgg2uo6iBwFWO+6Jq4bxDjwMUfr2ybhHjYh6/yX7+p23s0JERG8kRxI8O+05bc+WwIUC6pPVph/e/72c4cFrCSDCy/Ca5dG0+RslPzrHjdZAS5w+TlXGIpcmZD3GL+huHG5WqdM8i+UKAnBo2cd+E1gphgcHsXJmFlc7uXDiNsv2HX5EWbNL3lPx6Pa97c3zDP+Pm9fJE2wkvs1lMaNf9fnsd6/piiqS56XjLgjEyj2TDHGfCX46FvkqO6qnRumkGHdJ/HyoovN+bweC8eIjaYj9EMqdTIh6qQ4nkF8LVmuDDqH1+qme8CvVTrxk3UJMvRbLlRjwSXUFyScKTNlS/LF8xaYd+2YJD0FFceUDTabXPlQ8B+pQOQqoLHA5tmKC9MFhGLM57HBE4zOxKrTREHQnqhWyU8SWdvKDDBU/rIoz91Sn485Yf9CrPLwoQROOUGV3RHgzpkkERFFasDalHAig1Ot95r+keeNkM1MkYLMoW+ELZn/k7dOoavzvunT6S0OwYFZyltsxluBRw+UBI6l4eU7/fxCYIeSBQwrWoq0FNmbHjpki/yIrDbLFOvA
DKIM-Signature: a=rsa-sha256; bh=auIHTPd+32kp8PROOlP0H6sz0Vr4xAC6j8vDNdpUKa4=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1776668930; v=1;
 b=krJixErk8RDNIkiN7Uq+6bJKmGR8Fyk1Qccp7ZJTx5d8f9HeiRkJsYPZUrusefUOXnCga0y7
 p7kLwuFq9lUdrVPP8PGbER5M7YCxdNG3mrxI/6ezqd4rD2H5EBeo6Xk22RiycLkhypQmCL93KjA
 6coQMNC2XWbTUIJ1Hf+n3CGO94M4cJC24QR95w+oaxdW6sGZJNRGw68dtCCron+Mkw8T6DGQQgU
 f6a22ZDNtyPGS7r1qdi5MlV1aYibsRnaFCOFaDGjmycN9uvCTkleO6NsdW+Fr42MqENKfyJu9OA
 dGAOS9f7VWfGhYGbxP3O4DSBu6lbsGR8MSzpE+xwBxqng==
Received-SPF: pass client-ip=46.105.33.174; envelope-from=clg@kaod.org;
 helo=11.mo534.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/20/26 07:47, Jamin Lin wrote:
> Hi Philippe, Cédric
> 
>>>> -    return ehci_get_buf_addr(s, s->ctrldssegment, low, UINT32_MAX);
>>>> +    uint64_t addr;
>>>> +
>>>> +    addr = ehci_get_buf_addr(s, s->ctrldssegment, low, UINT32_MAX);
>>>> +    addr += s->descriptor_addr_offset;
>>>
>>>
>>> Instead, can we force a default value for ctrldssegment when
>>> caps_64bit_addr is set ?
>>>
>>> I am still trying to digest :
>>>
>>>     https://lore.kernel.org/qemu-devel/
>>>
>> TYPPR06MB8206C7461E004C4FF07B8E92FC242@TYPPR06MB8206.apcprd06.
>> prod.out
>>> look.com/
>>
>> Same here, but since it doesn't break and I don't have much more time to
>> dedicate to this I ended thinking "good enough for now, could be improved
>> later", so no objection on my side.
>>
>>>
>>> We have time let's take a moment to think about the workaround.
>>
>> Then keep me in the loop!
> 
> 
> Thanks for the review and the suggestion.
> 
> I tried to address this by introducing a new property:
> aspeed-ast2700-workaround.

This is not specific to AST2700.

I think a forced default value for CTRLDSSEGMENT would be more
appropriate. Perhaps "ctrldssegment-default", as a uint32_t,
which defaults to 0x0 and when the ast2700 SoC is realized,
set to BIT(2).


> 
> When this property is enabled:
> 
> 1. We force bit 2 of the CTRLDSSEGMENT register to 1 during initialization (when caps_64bit_addr is set).
> 2. Additionally, if firmware writes to the CTRLDSSEGMENT register, we also ensure that bit 2 remains set.
> 
> This keeps the behavior contained to AST2700-specific usage and avoids impacting other platforms.
> Let me know if you think this approach makes sense, or if you'd prefer a different direction.
> 
> Jamin
> 
> diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
> index af8c080c60..0a58dca668 100644
> --- a/hw/usb/hcd-ehci.h
> +++ b/hw/usb/hcd-ehci.h
> @@ -263,6 +263,7 @@ struct EHCIState {
>       /* properties */
>       uint32_t maxframes;
>       bool caps_64bit_addr;
> +    bool aspeed_ast2700_workaround;
> 
>       /*
>        *  EHCI spec version 1.0 Section 2.3
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index 4a1f7cad73..83114bae90 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -858,6 +858,9 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>       for (i = 0; i < sc->ehcis_num; i++) {
>           object_property_set_bool(OBJECT(&s->ehci[i]), "caps-64bit-addr", true,
>                                    &error_abort);
> +        object_property_set_bool(OBJECT(&s->ehci[i]),
> +                                 "aspeed-ast2700-workaround", true,
> +                                 &error_abort);
>           if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), errp)) {
>               return;
>           }
> diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
> index 61215e9f3d..01f72a5a1e 100644
> --- a/hw/usb/hcd-ehci-sysbus.c
> +++ b/hw/usb/hcd-ehci-sysbus.c
> @@ -36,6 +36,9 @@ static const Property ehci_sysbus_properties[] = {
>                        false),
>       DEFINE_PROP_BOOL("caps-64bit-addr", EHCISysBusState, ehci.caps_64bit_addr,
>                        false),
> +    DEFINE_PROP_BOOL("aspeed-ast2700-workaround", EHCISysBusState,
> +                     ehci.aspeed_ast2700_workaround,
> +                     false),
>   };
> 
>   static void usb_ehci_sysbus_realize(DeviceState *dev, Error **errp)
> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> index 7f90fd119d..403d7e84a7 100644
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -1133,6 +1133,9 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,
>                             "      64-bit addressing capability is disabled\n");
>               return;
>           }
> +        if (s->aspeed_ast2700_workaround) {
> +            val |= BIT(2);
> +        }

With the proposal above, this would be changed to :

	val |= s->ctrldssegment_default;

>           break;
>       case ASYNCLISTADDR:
>           if (ehci_async_enabled(s)) {
> @@ -2582,6 +2585,9 @@ void usb_ehci_realize(EHCIState *s, DeviceState *dev, Error **errp)
>       }
>       if (s->caps_64bit_addr) {
>           s->caps[0x08] |= BIT(0);
> +        if (s->aspeed_ast2700_workaround) {
> +            s->ctrldssegment |= BIT(2);

Shouldn't these assignments be in the reset handlers ?

Thanks,

C.


> +        }
>       }


