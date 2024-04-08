Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5AAC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 09:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtl89-0005Hw-TJ; Mon, 08 Apr 2024 05:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtl87-0005Hb-UR
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 05:17:31 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtl86-0000oU-4d
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 05:17:31 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a44ad785a44so490799466b.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 02:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712567848; x=1713172648; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5WPhMGGEAlaCWePqPOlTOMNDZLZtX2QuCPlFl7nQ+uM=;
 b=Gdx4KxJ58ou6ose4TapUnT8Ps33fRXFCVvp0T9rFPwQl/900fV7N9TVHxeJjThITmf
 TBRbOmw1WjiD42k/KYD9/c6te0Ji5p2KvJeoU6FSH7YMpJTw7z/GpwJ8RAaXXoC2uzMk
 rN+1kIN61+guaRpvTBqZJ+l/NAult0U6e2F8jmKUJ1fQ0qcjLxbraXDF672TojRnPiVK
 OrDkc7yOa8+swykdTlKxcLqvYGfzQF17gvYKNmzLHG+L+s+VfrPnV18SihDxvVe/bahJ
 A3G4HcyZ0Oa51pgUJGlol+bVLGFzJNNnuglv835yy2M6WLq31VsVIAeyoHzO2cKAHUAl
 rb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712567848; x=1713172648;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5WPhMGGEAlaCWePqPOlTOMNDZLZtX2QuCPlFl7nQ+uM=;
 b=UxC/XMOl9CGrKIknUoB9YWejmU1Dgh39drT6kkN9wtnkipQLrG0ulJnC34Bxmad4DL
 7d8aTSUcVGS4mN0SWW8aGqjEqiAACXMy2WV9i0pAmHUOLZNgB1Bj9zGkxjwdpfxNGWb1
 zngwGv69DAQLisXIaoNZ9YeGaBfCoVFFG9FA9C+T+26eFHn4T3y6GgbrIVuEiLmZJJH4
 Abhh7XcaexleOrKPxAS7mpCm9aJtkFJoJMRpxMRCSaVMTWjzbhXER8PWFEbi+Rn/Codl
 mbgNrk6tDcTxNjyNW6zEliebYZ/FRU0TCp6QaxtAXYF7aKLGgENaX/rPSGLnHRdLkOrz
 H9yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaZSSlx5rvApSzN/5ducWLWjfW+zbMI0BTTCUhIi/R8xn3ncLVsUKkkBKDMmaXZEKWnswY+LOY9wGwDrXXfXw49s1KHXM=
X-Gm-Message-State: AOJu0Yyn3u10ekP2ALoxLPH8iYZ/Z33ps0YjqpM/ZWKBbFupHrqBItrt
 Pf1gYuD1MHzse6VF7iWZcx6JRXKABKDrtsTagArBnnBJ5nGkVnL+6BzzlGzA4UBn+mfo255Ywo8
 o
X-Google-Smtp-Source: AGHT+IGvQtVYMjPtz0nu7w+Rs53Ah8dJIWxGt8kzNo/5lumlaj5IvG4cvdcCSZ3muG+7M/n2+xb0Gw==
X-Received: by 2002:a17:906:eceb:b0:a51:bca7:3a93 with SMTP id
 qt11-20020a170906eceb00b00a51bca73a93mr3270997ejb.28.1712567848311; 
 Mon, 08 Apr 2024 02:17:28 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 jz8-20020a17090775e800b00a4672fb2a03sm4266768ejc.10.2024.04.08.02.17.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 02:17:27 -0700 (PDT)
Message-ID: <52a52836-f875-4cb6-8200-bf142d3a6a04@linaro.org>
Date: Mon, 8 Apr 2024 11:17:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hcd-ohci: Fix inconsistency when resetting ohci root hubs
To: Qiang Liu <cyruscyliu@gmail.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
References: <20220830033022.1164961-1-cyruscyliu@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20220830033022.1164961-1-cyruscyliu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 30/8/22 05:30, Qiang Liu wrote:
> I found an assertion failure in usb_cancel_packet() and posted my analysis in
> https://gitlab.com/qemu-project/qemu/-/issues/1180. I think this issue is
> because the inconsistency when resetting ohci root hubs.
> 
> There are two ways to reset ohci root hubs: 1) through HcRhPortStatus, 2)
> through HcControl. However, when the packet's status is USB_PACKET_ASYNC,
> resetting through HcRhPortStatus will complete the packet and thus resetting
> through HcControl will fail. That is because IMO resetting through
> HcRhPortStatus should first detach the port and then invoked usb_device_reset()
> just like through HcControl. Therefore, I change usb_device_reset() to
> usb_port_reset() where usb_detach() and usb_device_reset() are invoked
> consequently.
> 
> Fixes: d28f4e2d8631 ("usb: kill USB_MSG_RESET")
> Reported-by: Qiang Liu <cyruscyliu@gmail.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1180
> Signed-off-by: Qiang Liu <cyruscyliu@gmail.com>
> ---
>   hw/usb/hcd-ohci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> index 895b29fb86..72df917834 100644
> --- a/hw/usb/hcd-ohci.c
> +++ b/hw/usb/hcd-ohci.c
> @@ -1426,7 +1426,7 @@ static void ohci_port_set_status(OHCIState *ohci, int portnum, uint32_t val)
>   
>       if (ohci_port_set_if_connected(ohci, portnum, val & OHCI_PORT_PRS)) {
>           trace_usb_ohci_port_reset(portnum);
> -        usb_device_reset(port->port.dev);
> +        usb_port_reset(&port->port);
>           port->ctrl &= ~OHCI_PORT_PRS;
>           /* ??? Should this also set OHCI_PORT_PESC.  */
>           port->ctrl |= OHCI_PORT_PES | OHCI_PORT_PRSC;

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


