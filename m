Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD9FC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 09:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCz10-00011G-Sk; Fri, 31 May 2024 05:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1sCz0z-0000xe-4X
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:57:37 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1sCz0x-0004tf-Hb
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:57:36 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4211249fdf4so19576615e9.3
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 02:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717149454; x=1717754254; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uu9NBKSJTgs+S9TqmVtiCE86u3gD06b0P6Ww5JBGrEU=;
 b=PDODQl09t17S+kjM8/0zrFck1gJXgukFBtU6OllOW4GgkYBhr7dT/PAYVp2DrLL4lB
 zW9pvr2HGcABssIsTb9alcJHRjdSTattz8ZBq7uCDFVpxjlvMgSIT6Vaw93ttCcZPTLF
 lhkE6UEJas015x95MKAkGNRzdGifHcPswODeuOClaJQPxQ2LD98ht+A7bz4lSpSA0I0v
 iZWY8NN8LLS4ODObRj6k6s+pikWJg2Y3/CFnDoXkwyTCiXcfgT+DMsw40E3Mm1pj+J5p
 xRJYoVHNgFiI3LSck/JSCrXAkK8VMcF7aT6a1a23Vzeg+nMzsMSTwUeIOiXfkTSioEAt
 4M8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717149454; x=1717754254;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uu9NBKSJTgs+S9TqmVtiCE86u3gD06b0P6Ww5JBGrEU=;
 b=roMziqKvOclDIWAMlnBt+q/jg5A8PS/s1pGiZr8GQ5IkKr6LntmtQYcSCRQ3t/uU7U
 tiRtnozxwsg0SWeM0NjRvO5opZxiBsMrL0hPWsTjVNr6FK9E/YojX2Br8gCzOQTrYhgY
 pfGSv2F55BPe636iglBqIC+YjhQzghvLJUsfbq3M0Y4Okp6x3C1x+OZxqKvENGUbR+KK
 TVRnbLuMjCmvqorHx8NQeGhjWb69DLu+TB+HeC2XiFOpieiaS9d6j3h0keIHLTg6pX4k
 RPDtcyN+3vmXdXsiN4CLVqNOWE9h6qz6csfq7/fdy97ICCg0Qawp/6YLYghdB/D/hA44
 yMCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNuYPJd2t977CTzUnW6fR+s9+1WEaFsKufEamSAR5xBFNxX5Yy/vvHOieUL/Fd/TK1WlZx8hSXnoo8JMCHsk08sMpkPdE=
X-Gm-Message-State: AOJu0YwicshYfxD10EhuHG/r8bEbluKUXzqlvhAE8uDgZ7l9Q93btP95
 +4TLlqkVeYDf3ODqGIA/TUpOaG9oZE1GQCcwvwi5+u/BtUjCmylz
X-Google-Smtp-Source: AGHT+IHf4eM0iKAXjhQyPe69MDAOzotT91YOZAZUcca/8FhBKouvh0wHz3U7tpeuUdH7yKkwcX0cHQ==
X-Received: by 2002:a05:600c:3547:b0:416:bc18:2a00 with SMTP id
 5b1f17b1804b1-4212e0b5066mr12944045e9.38.1717149453760; 
 Fri, 31 May 2024 02:57:33 -0700 (PDT)
Received: from [192.168.3.251] (54-240-197-236.amazon.com. [54.240.197.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421270697b6sm49927995e9.24.2024.05.31.02.57.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 May 2024 02:57:33 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <660203c1-b6d9-4978-8336-1988247fd543@xen.org>
Date: Fri, 31 May 2024 10:57:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] hw/xen: register legacy backends via
 xen_backend_init
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Anthony PERARD <anthony@xenproject.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20240510104908.76908-1-philmd@linaro.org>
 <20240510104908.76908-7-philmd@linaro.org>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <20240510104908.76908-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/05/2024 11:49, Philippe Mathieu-Daudé wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> It is okay to register legacy backends in the middle of xen_bus_init().
> All that the registration does is record the existence of the backend
> in xenstore.
> 
> This makes it possible to remove them from the build without introducing
> undefined symbols in xen_be_init().  It also removes the need for the
> backend_register callback, whose only purpose is to avoid registering
> nonfunctional backends.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-ID: <20240509170044.190795-8-pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/xen/xen-legacy-backend.h | 11 ++---------
>   include/hw/xen/xen_pvdev.h          |  1 -
>   hw/9pfs/xen-9p-backend.c            |  8 +++++++-
>   hw/display/xenfb.c                  |  8 +++++++-
>   hw/usb/xen-usb.c                    | 14 ++++----------
>   hw/xen/xen-legacy-backend.c         | 16 ----------------
>   6 files changed, 20 insertions(+), 38 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


