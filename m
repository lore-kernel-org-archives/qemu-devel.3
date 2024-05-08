Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C30C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 10:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4eb3-0008CK-MR; Wed, 08 May 2024 06:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4eat-0008BQ-2d
 for qemu-devel@nongnu.org; Wed, 08 May 2024 06:32:18 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4ear-0003ts-33
 for qemu-devel@nongnu.org; Wed, 08 May 2024 06:32:14 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a59a0e4b773so1003355866b.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 03:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715164331; x=1715769131; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V1JCzKfKW81HHC1WXdjaZQdy6k41u3I8fI8h0TqGMoE=;
 b=NTCuVu8XrldxO+NdhppkQhUXtRVybisrx8PtYuL477IDqBDn9QlQ7yXM8Eed/Ro2m8
 n8GUOvh14n4mZB1wDXIN/XdpAPCRaWY6gcXX6mhGFs/sFRfXzcPIakKMGu4WaKJ4u1jU
 RvVO6Fzhj0ezTikOVyhRtwuytaEFtC8rRjyWU4R6fAxpEz++DHEuuSc9soqxbrL/oJIA
 v7ek7LTtf/4/EcF0JU+ee70+GvUoibbDwNhAaGnEXjBco4VZwIEXbrRGJkf/5gdflDmv
 hO5pExRB7Tju6cQjp5jnYQKo1GxNERw7uadeBSOy75JyLVq11PC+Dme/qzZG6DXbTqnr
 I2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715164331; x=1715769131;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V1JCzKfKW81HHC1WXdjaZQdy6k41u3I8fI8h0TqGMoE=;
 b=hBnvvydCu90M1LGtvqJDcLMiEUul3PhiHhUQTAw5UfEyxv/ATw2VvNFUqkrrWPulHn
 kptsFgxBV5VPmOL6yIlkq6dp4a4YdCw5KfPFpMdGJcmMEEtbHYykg2Fmfm1nvy3bH3O6
 vBl0fwZKG+j2nr89ClDnDC939wTc7Nm62kVZoFUxOdEKYyllPQGaOH9UjwebmKtTk8Jt
 s31G5CW6EKot7Uci0fE/vdcEd/eWA/Wgzng/BeyjohtKI5S+EaZa83c8LloMsAZqteo6
 +vnzT+B1MoTMiv2qFJlcZuGZW/Teer7dGy9nlwOVicWBqxYoW8EmYCqBRjkhCQSuDVP3
 EFoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV05/guHNzO0mA8hyht5yv8cSURUn6V8IBMSwKD6+cfjx/28v9oO4soQJPs/N2nqSMOGamoSyhyflFgnqE5Fs8F+4Z0UD8=
X-Gm-Message-State: AOJu0YwAoEm4aU2ztYqsMh1698JTnaGk35MumkZ5+mU8jRmXw//t6dwq
 lZyudv8GzTMZbD7lBTo6fmBj8ftuYWstVFRHLm76izQvn5ISxa7wVDAKE5MRA4A=
X-Google-Smtp-Source: AGHT+IFnOw5JvEE2uf5p/4/dM5+rYsEo0s11+72R8I5EYooxEJDY+ZWSx2A/oZgeRJ1PkaCeDWFqsQ==
X-Received: by 2002:a50:8750:0:b0:571:cb02:418a with SMTP id
 4fb4d7f45d1cf-5731daa2c96mr1333857a12.40.1715164331666; 
 Wed, 08 May 2024 03:32:11 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 e15-20020a056402088f00b0057232df2e5dsm7456626edy.32.2024.05.08.03.32.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 03:32:11 -0700 (PDT)
Message-ID: <ed6199d5-63b8-4a03-8dc1-dce27bc93e92@linaro.org>
Date: Wed, 8 May 2024 12:32:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/12] contrib/vhost-user-blk: enable it on any POSIX
 system
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, slp@redhat.com,
 Brad Smith <brad@comstyle.com>, Eduardo Habkost <eduardo@habkost.net>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, gmaglione@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, stefanha@redhat.com,
 David Hildenbrand <david@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20240508074457.12367-1-sgarzare@redhat.com>
 <20240508074457.12367-10-sgarzare@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240508074457.12367-10-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

On 8/5/24 09:44, Stefano Garzarella wrote:
> Let's make the code more portable by adding defines from
> block/file-posix.c to support O_DIRECT in other systems (e.g. macOS).
> 
> vhost-user-server.c is a dependency, let's enable it for any POSIX
> system.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v4:
> - moved using of "qemu/bswap.h" API in a separate patch [Phil]
> ---
>   meson.build                             |  2 --
>   contrib/vhost-user-blk/vhost-user-blk.c | 14 ++++++++++++++
>   util/meson.build                        |  4 +++-
>   3 files changed, 17 insertions(+), 3 deletions(-)


> diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
> index 9492146855..a450337685 100644
> --- a/contrib/vhost-user-blk/vhost-user-blk.c
> +++ b/contrib/vhost-user-blk/vhost-user-blk.c
> @@ -25,6 +25,20 @@
>   #include <sys/ioctl.h>
>   #endif
>   
> +/* OS X does not have O_DSYNC */
> +#ifndef O_DSYNC
> +#ifdef O_SYNC
> +#define O_DSYNC O_SYNC
> +#elif defined(O_FSYNC)
> +#define O_DSYNC O_FSYNC
> +#endif
> +#endif
> +
> +/* Approximate O_DIRECT with O_DSYNC if O_DIRECT isn't available */
> +#ifndef O_DIRECT
> +#define O_DIRECT O_DSYNC
> +#endif

Could we add that in "qemu/osdep.h" instead?

Otherwise,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


