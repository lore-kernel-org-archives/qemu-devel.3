Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150D6C25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 12:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9lUj-00040J-II; Wed, 22 May 2024 08:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s9lUh-0003zg-6R
 for qemu-devel@nongnu.org; Wed, 22 May 2024 08:54:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s9lUf-0001rc-I8
 for qemu-devel@nongnu.org; Wed, 22 May 2024 08:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716382496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lkj5gBjQiaDyXyxgtQuTPRKn2Sqkjzef0TKATsw/6oo=;
 b=Jh0YmYv09trdp2nT3+jFsGJodKY+dTEbLUbjEnVgRe4dgFpWSgp4LbqpWek6y/LSJDLF/e
 KBSzyKzMhc0MTgcZVfauVoe5tDJnMT6x5Im2HcAFL21AqkQoh+WQG99IsirTXHj/13z6O3
 iv8y+ygnXL1+i+qr0Mk5MegiQ92JEQw=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-BlDSTBOZONO8WW-uyyxBng-1; Wed, 22 May 2024 08:54:54 -0400
X-MC-Unique: BlDSTBOZONO8WW-uyyxBng-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-ddaf165a8d9so20019383276.1
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 05:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716382494; x=1716987294;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lkj5gBjQiaDyXyxgtQuTPRKn2Sqkjzef0TKATsw/6oo=;
 b=WqefskreF2Rs7LVM919X4UdGCo4YmZJ2FLYAwZPGf+JUd2g0rZ1EencoBwGnfuKLBe
 BJOR3MiATdmehAbRqrsN3YpdBP8u9CAdnoaaUbV5m4f0J9DYy97T1CS8ZRGh/Rrhcuo0
 yilZFkiblru3WoHCZfkbIWgDlpoirkm+XJNgBs79lqHK29Sbnkc4nM0UlNqaXH57T9hx
 k2IVAHVR4ZvEpWv1N6Zi9xbbafc/JUh8zhitNtqY0BfdZSUYqHDNZHdjuET7ariEzz4E
 zaVR6PYJOHdGNzeppnYPm3UMaecKyaBEvQd5mVmLgh2NDFkexax64Z2Xw+IjYGEks5iz
 VU/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpNSLoj917z46dt0cGB8wqyGK2+hgjJdIyUjlWwSzDA/NMLsqzEY8BIvziOqm8AgoGdNG0+++mwiWTfblwkZHXAiBTgIg=
X-Gm-Message-State: AOJu0YyeWuhyDsbFc4tUdFWzacA384o8aEG7pp8hUgiVBnXKi+MXb2Ap
 EAxcDK6XF3Z13f1e6NVTkGL3QPUpZFrh1kFHU6PY/avDRFEe7UNr48y2dnIH5DiiG/EBUBt27k1
 E/S6G74pJ4jJAN2ydHYkawEnhP7sJe9ieoIySrn6cODaHFfJ7J8Ce
X-Received: by 2002:a25:7455:0:b0:df4:80f9:9f47 with SMTP id
 3f1490d57ef6-df4e0a9cb9emr2071304276.8.1716382494159; 
 Wed, 22 May 2024 05:54:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeLu+9mJSyec723wNE+6k4C8mNla6KyIvacwF/D0B2CM+EcUvhYKVx7FPq5UJO2lxDAwEHFQ==
X-Received: by 2002:a25:7455:0:b0:df4:80f9:9f47 with SMTP id
 3f1490d57ef6-df4e0a9cb9emr2071284276.8.1716382493836; 
 Wed, 22 May 2024 05:54:53 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-179-90.web.vodafone.de.
 [109.43.179.90]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43f7a6bd188sm57167971cf.19.2024.05.22.05.54.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 May 2024 05:54:53 -0700 (PDT)
Message-ID: <6c9a0d95-edc9-445f-8063-23a30dd74443@redhat.com>
Date: Wed, 22 May 2024 14:54:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] MAINTAINERS: drop audio maintainership
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexandre Ratchov <alex@caoua.org>
References: <20240516120344.531521-1-kraxel@redhat.com>
 <20240516120344.531521-2-kraxel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240516120344.531521-2-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 16/05/2024 14.03, Gerd Hoffmann wrote:
> Remove myself from audio (both devices and backend) entries.
> Flip status to "Orphan" for entries which have nobody else listed.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   MAINTAINERS | 19 ++++---------------
>   1 file changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1b79767d6196..7f52e2912fc3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
...
> @@ -2388,7 +2387,6 @@ F: hw/virtio/virtio-mem-pci.c
>   F: include/hw/virtio/virtio-mem.h
>   
>   virtio-snd
> -M: Gerd Hoffmann <kraxel@redhat.com>
>   R: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>   S: Supported

I think the status should be downgraded to Orphan or at least Odd-fixes, 
unless Manos wants to upgrade from "R:" to "M:" ?

>   ALSA Audio backend
> -M: Gerd Hoffmann <kraxel@redhat.com>
>   R: Christian Schoenebeck <qemu_oss@crudebyte.com>
>   S: Odd Fixes
>   F: audio/alsaaudio.c

I'd also suggest that Christian either upgrade from R: to M: or that we 
change the status to Orphan

>   JACK Audio Connection Kit backend
> -M: Gerd Hoffmann <kraxel@redhat.com>
>   R: Christian Schoenebeck <qemu_oss@crudebyte.com>
>   S: Odd Fixes
>   F: audio/jackaudio.c

dito

>   SDL Audio backend
> -M: Gerd Hoffmann <kraxel@redhat.com>
>   R: Thomas Huth <huth@tuxfamily.org>

I'm fine if you update my entry from R: to M: here.

>   S: Odd Fixes
>   F: audio/sdlaudio.c
>   
>   Sndio Audio backend
> -M: Gerd Hoffmann <kraxel@redhat.com>
>   R: Alexandre Ratchov <alex@caoua.org>
>   S: Odd Fixes
>   F: audio/sndioaudio.c

Same again, I'd suggest to either set to Orphan or upgrade the R: entry?

  Thomas


