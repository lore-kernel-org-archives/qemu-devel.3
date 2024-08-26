Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CC8C5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 16:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sicAb-0007mh-Ab; Mon, 26 Aug 2024 12:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sicAS-0007UJ-U4
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 12:02:11 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sicAQ-0007e7-OU
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 12:02:08 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52f01b8738dso3172226e87.1
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 09:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724688124; x=1725292924; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YySsm5TiX/4fN46sT0WY+qZECOqdxmwRp2hj8qzAXEc=;
 b=hCbxy/ZT2tIExKwug7S6RvAYfxzvt7UmtPNla4r1wuyQR9eairT4lAJYM5R5lfuIb7
 vMEMo5PZHe+rdRN4VvrnOps8b8AOYOVIKeusrWA1QR1dTF44T3jigWf5lAEGjZ8nVQTi
 +KPbIsINKtqLvjak3x97SB58BVvQNjhJCztaD2VR6wZISMV+4fvrJjAYPkvdFXH/6qsY
 5F+2u4Ok+a8h5vO7nh8uHSgDHMlWeYlnF8fLzH9/RmxOFD7tpI6j/XPpDEFOqB0AKWgl
 PjJPTHsprXN/2CH/9/3OjI5sa19arvYnZUK1urOdbIuLndbLZJehBEW5t0lWyYWnL1yT
 wtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724688124; x=1725292924;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YySsm5TiX/4fN46sT0WY+qZECOqdxmwRp2hj8qzAXEc=;
 b=ZndU2BhrLirALwg5MShpCLNQonJiVkiSAngNk4sAVG5yn88tAA57rFUuU3yTyP33aT
 GziiX8u74MeAQP3A9qc2bn5dX+b9oRTrjqCOF70DMRFekjQfMEUpi6kwgAEDEJR/hrFD
 mkW5kWH4MZmxfOSKz4OLuFE58HSvZ0JjZssb03UZTZ8GkBwzpBzb4E/bSKTl26m4XeLL
 25oWnPxwVtrayNWMKV+8Gk2SpZJnCWLcwbCf48HRbm9J4Oh5u2WOjyMZSaYAg8sC9Jw/
 TAZB/QoylfDDwcv0HyPOD6GDpPMziNiiDoDNKv7jJLoqSWBBqaBpY/TejHliR1Mg3Ekn
 Lgwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuh627BcQ7KGCHeJl4aq5LT4b04EUlHbo0fQ2IUUa7MvtYx5PSCqflhtgz4c+TH/Dv9jkulWZbTyhl@nongnu.org
X-Gm-Message-State: AOJu0Yz7CLeEaWeEZ0Vi+syrlv/7gj6gW5VGKDdwaz3OaOhCPvlwLCmm
 EigtBIVAhNp4GYKOstsLgGgLLI4zh/36J7qR61NHiJ977Y9Rg71H6BF6plyG4/461gWDYyvprlB
 A
X-Google-Smtp-Source: AGHT+IEqvezziWwxEzCr9jIomE2TYxn1bK+QwEylm9LC7eNtlCLvwZBdREj66z8BCGzzmhdzrXWV/w==
X-Received: by 2002:a05:6512:124f:b0:533:526a:cd08 with SMTP id
 2adb3069b0e04-53438773434mr8029705e87.14.1724688123976; 
 Mon, 26 Aug 2024 09:02:03 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.216.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a868f220d16sm683005566b.22.2024.08.26.09.02.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 09:02:03 -0700 (PDT)
Message-ID: <155a9629-634a-4b69-a332-873b7af8b9fb@linaro.org>
Date: Mon, 26 Aug 2024 18:02:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 01/10] hw/s390/virtio-ccw: Convert to three-phase
 reset
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
 <20240813165250.2717650-2-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240813165250.2717650-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Peter,

On 13/8/24 18:52, Peter Maydell wrote:
> Convert the virtio-ccw code to three-phase reset.  This allows us to
> remove a call to device_class_set_parent_reset(), replacing it with
> the three-phase equivalent resettable_class_set_parent_phases().
> Removing all the device_class_set_parent_reset() uses will allow us
> to remove some of the glue code that interworks between three-phase
> and legacy reset.
> 
> This is a simple conversion, with no behavioural changes.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> It looks a little odd that we do the this-class reset first
> and then chain up to the parent's reset, but that's what the
> existing code does, so I left it alone.

Do you plan to post a follow up patch inverting the
call order? Otherwise, could you add a comment in the
code so we don't forget about this odd case?

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> ---
>   hw/s390x/virtio-ccw.h |  2 +-
>   hw/s390x/virtio-ccw.c | 13 ++++++++-----
>   2 files changed, 9 insertions(+), 6 deletions(-)


> -static void virtio_ccw_reset(DeviceState *d)
> +static void virtio_ccw_reset_hold(Object *obj, ResetType type)
>   {
> -    VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
> +    VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(obj);
>       VirtIOCCWDeviceClass *vdc = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
>   
>       virtio_ccw_reset_virtio(dev);
> -    if (vdc->parent_reset) {
> -        vdc->parent_reset(d);
> +
> +    if (vdc->parent_phases.hold) {
> +        vdc->parent_phases.hold(obj, type);
>       }
>   }


