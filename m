Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A515CD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 07:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtjDc-0008L6-CE; Mon, 08 Apr 2024 03:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtjDU-0008JS-MJ
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 03:14:57 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtjDI-0007HW-RK
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 03:14:56 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-563cb3ba9daso4016378a12.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 00:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712560482; x=1713165282; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PGwmT5aIOwYgxuIJvyGnTpmmf+uDtNLYcjgT93GKrn0=;
 b=x0GA38ED8Iitd+IqaLQbJjKnPVXMKi/rGZBqIhBIzcUwmtmphF1EJv/S/RIDhyz0SQ
 bTMnUgpKjqQC5tvjPbU/QAcKdFiGVCP3paDHCg/Xh6Rxmyr+iB7YDLF8PP4DVceBwtrD
 /XboHDv2VTHjyxWMwDd6pf80rFF286Go6dDgH17HTnrQeMcgie5Ol8/wr0tY3fg2zIoU
 F/HmLyE+qVr6yV/QydhIpDpXXho0Qa4JI+otXYsXDwM8M1ILCTyrukwe/8iokhha/4P8
 kmHmJec3gMXWMkVMtLOgDTYn0j6BuJpOjgXlTBPGbVuFAz9TGKr13NztDP5Rs7Ziev5I
 nNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712560482; x=1713165282;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PGwmT5aIOwYgxuIJvyGnTpmmf+uDtNLYcjgT93GKrn0=;
 b=BTHpcCMsTGYYZwlBmfpHqDADoFN1a2qur+/a0v/7sS5SigNLDUbcWlKf5yHbF+ytCH
 FBy4hBqFrYY0QwAxwHWRnEvf/YOcsPzwHI7u7ztGpbhUZVtHT/zxYagVKklAV8x2Ykn1
 AFKpWlgxaArUIZ65q+QGSSLOPxsD1ZsYmMcy8W3w8kK0XoOeGzvWJJupiE3r3jffARug
 ZnlCxLXZrEzfFRadT8ILxZoZ0wm1Ul285E25gH7uRUyuc5oZcmKgDmAyBWBK7rEH9+TQ
 sULtTOjg5zNwqYgf7Ad5pyAWMk/31TET7gq9UVFVq5FKC+UH7e3uqfJ/sqARjVYmjUm3
 S9Mg==
X-Gm-Message-State: AOJu0Yz1lnziQPE2mP3j5IaCkSMpyT/W48+5rVug5zC/JO8iXPlYK+CO
 ui7eJY56HQ1x+HuMkszbEysXeKskkOMB5GAr0z3Jd1IDvwdG644N4ZtINsT6/NfHWjI6tTQMS1L
 2
X-Google-Smtp-Source: AGHT+IFI50pb3dc6P05shZU52pww3NzNl3vZxVP5cY4nac6GDv1HEdQ4pzYoTpSxFFEYcUSQmhQ3Uw==
X-Received: by 2002:a17:906:298a:b0:a4e:6c21:6d5f with SMTP id
 x10-20020a170906298a00b00a4e6c216d5fmr5828388eje.72.1712560482490; 
 Mon, 08 Apr 2024 00:14:42 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 n2-20020a1709062bc200b00a517e505e3bsm4020780ejg.204.2024.04.08.00.14.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 00:14:42 -0700 (PDT)
Message-ID: <942c06fd-fac0-49da-9421-92dc3a357cb3@linaro.org>
Date: Mon, 8 Apr 2024 09:14:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 3/4] hw/char/virtio-serial-bus: Protect from DMA
 re-entrancy bugs
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Amit Shah <amit@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org
References: <20240404191339.5688-1-philmd@linaro.org>
 <20240404191339.5688-4-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240404191339.5688-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/4/24 21:13, Philippe Mathieu-Daudé wrote:
> Replace qemu_bh_new_guarded() by virtio_bh_new_guarded()
> so the bus and device use the same guard. Otherwise the
> DMA-reentrancy protection can be bypassed.
> 
> Cc: qemu-stable@nongnu.org
> Suggested-by: Alexander Bulekov <alxndr@bu.edu>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/char/virtio-serial-bus.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> index 016aba6374..cd0e3a11f7 100644
> --- a/hw/char/virtio-serial-bus.c
> +++ b/hw/char/virtio-serial-bus.c
> @@ -985,8 +985,7 @@ static void virtser_port_device_realize(DeviceState *dev, Error **errp)
>           return;
>       }
>   
> -    port->bh = qemu_bh_new_guarded(flush_queued_data_bh, port,
> -                                   &dev->mem_reentrancy_guard);
> +    port->bh = virtio_bh_new_guarded(vdev, flush_queued_data_bh, port);

Missing:
-- >8 --
-    port->bh = virtio_bh_new_guarded(vdev, flush_queued_data_bh, port);
+    port->bh = virtio_bh_new_guarded(VIRTIO_DEVICE(dev),
+                                     flush_queued_data_bh, port);
---

>       port->elem = NULL;
>   }
>   


