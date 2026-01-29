Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403EED73EA7
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 23:29:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlbSA-0006c6-K7; Thu, 29 Jan 2026 18:29:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlbS9-0006aa-Ao
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 18:29:33 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlbS7-0007qF-KX
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 18:29:32 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-481188b7760so9492085e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 15:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769729369; x=1770334169; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y354yoYAYkBybuOQv3USi7eqSN6jn8tk7Mw6/eJsjzY=;
 b=bwH5em1dY7oWdP09jqz/KQFuHKYLaWc7akLpX11Z5kexxIL/eXcV4HMSnuBP09Ztax
 qfFEc37m7Kv97wvqeiJsl12eMfb6WlYwhVGSFsVtjCXLeXGSFW2s+icbLKoCrVt1ZV4p
 beQGD6VElgs7OskaqoiiwSTBRkmHdtibdyG0wKUKqmIMr8Ojjfjudir2g028IbI8iqsu
 LBhhPl5Fx+/ZWzvDpcOCsj5+JfcsnuCF9xvjKFswKSSB5Yc9r0pP/7SNu9i+lwIMzjuv
 pLOwkep5DS3mCt6jpAFbCur6njay+EHZ0xnMxFBPlDmnrPZ8JuW2IIi4M1i20Of8qE6x
 D1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769729369; x=1770334169;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y354yoYAYkBybuOQv3USi7eqSN6jn8tk7Mw6/eJsjzY=;
 b=eacXgtHxHDrt6o1eTNQwefTqr98Z2Ruf0qTI73Hb9QjYD+6CgeoXP0fqz8RX6v2O/l
 SqlBx2XdFv+ytxxLDf/t5mJAtuFDoouYBW/MYIn1r36GaHtNOpzH6zIaLNfAnWqrUbdu
 LOS4q+/ia0YT4VSv/LP3v7ue9EPNFnu2Eu/SqgUKSHVf/jUdhWM65JrV6ksKul7PeKVq
 HYZP9HHUFXVF39SxHK9X3ZGJfLoGN3QYaNwn/PRIT7fNW/3bCjopZD5M/L1rnsuldhcA
 sLOb38BBziVNuxPbi7CMHZqxLfw2WX/O4AD+kGIW4DuPRnqv9GXibt5cbiiAqawVWROb
 Xe/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdFimO7Qf2FGWrcyRuOg3wb3DG4TwMHDgjK+1bN9eIW5z0XtkIm8AUriO1+zq4kUmSBdR4sEGC7mgs@nongnu.org
X-Gm-Message-State: AOJu0YzVegsjE8dBiesXHS5e7MWzfo8qJO6rWKM/OtKPtvPQq9zX3Apm
 fjndaVr94hdjBfte7HqM8cxMxjF48+fXs21kj6ySuoYjYcudF99+2yJVbRouh894hxI=
X-Gm-Gg: AZuq6aK8CquQHl+m1IUYe1Pg3QlDcbYXD/81cug32Jss11viHevyW3aFMlKx2d3iP/4
 W/HTa6iHImz1Jc1AhyR3qXf9EfD8n7tghCXw4/gIMmqVRu4QwiIyFkj2Msb51WY5iiKeueQxtcv
 amul6XlBbfEM2UwQa9oMdyOP9qWvXib5iyWWgaXGRKNlskIZkZMJK1Oxr+RHU0YG2F1ohwm1qmZ
 667XefyvSMfNm7ihnL/uEgteMOUsdY9fn+evfTUPvxrrMSlvAPFP4Wc8w4DxBrI2Mabk3KilMdu
 rwcxvfr/gb/cnLCRgkBm+4GQDHT8/1+DarINdDGxv6tAhpL38lU/Ms4c+NnbxZ2iE1pyzCeb/Kl
 uvpQ2YI+qlTgTL9zDuYNy5+DLGStA/fCp8zf90VC+NZ5BwKO7mFABDpgUWQnc5Ke15I/SmfKjoC
 WYSwoR/6VqggtR54ylhpnF8V3Ryd2Rxs1FfEX+Tc0/xXxpTUhxCspHKw==
X-Received: by 2002:a05:600c:a00d:b0:477:89d5:fdb2 with SMTP id
 5b1f17b1804b1-482db465e44mr8021125e9.14.1769729369314; 
 Thu, 29 Jan 2026 15:29:29 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482dbc75e13sm5409295e9.1.2026.01.29.15.29.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 15:29:28 -0800 (PST)
Message-ID: <7a99451d-adfa-4d1a-8c74-4072607d9714@linaro.org>
Date: Fri, 30 Jan 2026 00:29:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] memory: Remove
 memory_region_init_rom_device_nomigrate()
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>
References: <cover.1769703287.git.balaton@eik.bme.hu>
 <87d6eafa7c7f7f62de0e82dd5c70cd0d0a4f59b8.1769703287.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87d6eafa7c7f7f62de0e82dd5c70cd0d0a4f59b8.1769703287.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 29/1/26 17:20, BALATON Zoltan wrote:
> This function is never used, remove it.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   docs/devel/memory.rst                         |  1 -
>   include/system/memory.h                       | 27 ------------
>   .../memory-region-housekeeping.cocci          |  8 ----
>   system/memory.c                               | 41 ++++++-------------
>   4 files changed, 13 insertions(+), 64 deletions(-)


> -bool memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
> -                                             Object *owner,
> -                                             const MemoryRegionOps *ops,
> -                                             void *opaque,
> -                                             const char *name,
> -                                             uint64_t size,
> -                                             Error **errp)
> -{
> -    Error *err = NULL;
> -    assert(ops);
> -    memory_region_init(mr, owner, name, size);
> -    mr->ops = ops;
> -    mr->opaque = opaque;
> -    mr->terminates = true;
> -    mr->rom_device = true;
> -    mr->destructor = memory_region_destructor_ram;
> -    mr->ram_block = qemu_ram_alloc(size, 0, mr, &err);
> -    if (err) {
> -        mr->size = int128_zero();
> -        object_unparent(OBJECT(mr));
> -        error_propagate(errp, err);
> -        return false;
> -    }
> -    return true;
> -}
> -
>   void memory_region_init_iommu(void *_iommu_mr,
>                                 size_t instance_size,
>                                 const char *mrtypename,
> @@ -3802,9 +3776,20 @@ bool memory_region_init_rom_device(MemoryRegion *mr,
>                                      Error **errp)
>   {
>       DeviceState *owner_dev;
> +    Error *err = NULL;
>   
> -    if (!memory_region_init_rom_device_nomigrate(mr, owner, ops, opaque,
> -                                                 name, size, errp)) {
> +    assert(ops);
> +    memory_region_init(mr, owner, name, size);
> +    mr->ops = ops;
> +    mr->opaque = opaque;
> +    mr->terminates = true;
> +    mr->rom_device = true;
> +    mr->destructor = memory_region_destructor_ram;
> +    mr->ram_block = qemu_ram_alloc(size, 0, mr, &err);
> +    if (err) {
> +        mr->size = int128_zero();
> +        object_unparent(OBJECT(mr));
> +        error_propagate(errp, err);
>           return false;
>       }
>       /* This will assert if owner is neither NULL nor a DeviceState.

The code is actually inlined, not removed. With that clarified:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


