Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA311C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 10:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4ef8-0000uB-FF; Wed, 08 May 2024 06:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4ef7-0000tf-4z
 for qemu-devel@nongnu.org; Wed, 08 May 2024 06:36:37 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4ef5-00068q-IW
 for qemu-devel@nongnu.org; Wed, 08 May 2024 06:36:36 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a59c04839caso943421566b.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 03:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715164594; x=1715769394; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XW9LpS1IbXUstiaFxl42nMLceOCHN/O69a7yEHMHlgw=;
 b=FYZCrNXYy4MOJOQJGaTiJhc0x+i6LeB40yzzaCBolo0MBUz4rMkqAZW8sKUzR9tL23
 B0/8cLz9H6pZNH2ADHugphHcuc/hhlE4KS+xDfZGrxnMmUBa9el+u3fx4PZVtiNyeCjz
 gABAb8IM7q29BoWX1oJ/Ey35MH65EYpGXVeyYyWCx71l2khj1AsIiD9IOl5nfBVlVmhk
 ekZ6uVK08IbTOaI4YKckx1MKUr6ugZO52TJDxqmokX47KGSpR+XQTUHIOAYybzPFmzBY
 DiB7XSYjY0Rc3iPA+uw0znFsfAOL/HUGpUKfLbDX+/PA6djZ1pxCSv1JldFtsZOId3gc
 4f+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715164594; x=1715769394;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XW9LpS1IbXUstiaFxl42nMLceOCHN/O69a7yEHMHlgw=;
 b=D5lZzZYqwSakBya6NodvAuYLMxvlKZHzGoZZiwn1Zgm11rkIrVs1B13xWUY0CtMYBd
 RIoTNMiP1TlqaWK9ZEAFXNQoTouGalbOZxGqz6w8svcTQsXTVNB5fH4avEPNYVBXBNml
 BXz2F/ZR089wSOiNsdoKSb6TCImwjmxcuX8a1yPBCq24QkAXjZTFiSwpMhMdSskxq8Xv
 Yj49V5MH2Wu3W3Y2/U0+1R+izA8qo9/TimuxUIt5JyA2QDEFpnrTwVUxuQjGpc1Ertzl
 vX1Atp5bBgebncqSdepci/2WL2vJi2gTjn3g+HuNK7v2YbYpw7NOh3Y0DbsO21eMtKPR
 r6TA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiZODwN+tDWz+sGdv2BvjauoibwOytmfS/mHR+8rTwFd+Ehc7vanorwocnj3EBnSHbgfn0L49l+8EkI5e9IHUOmGs0UUY=
X-Gm-Message-State: AOJu0YyVsHNOqHyu/7sAqAJk0vtn5cxEjHNh4P8hAPbz8ilQNnCoMrqe
 6WzufKIGC45ojvZ6lcC6mjWiPwrwWUXxb+aNk+kJlj0mpS9vav7N625cYHZmyWk=
X-Google-Smtp-Source: AGHT+IEVVVLSyUiD/R/7P4eziGIJLJJwgEoMoxOcafGp+j9P3nSruJP0zHwvVU9NkRwEMMB0iG2T5Q==
X-Received: by 2002:a50:9b42:0:b0:572:a711:3daf with SMTP id
 4fb4d7f45d1cf-5731da6975amr1313090a12.40.1715164593875; 
 Wed, 08 May 2024 03:36:33 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 dj28-20020a05640231bc00b00572c2a849acsm7396504edb.21.2024.05.08.03.36.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 03:36:33 -0700 (PDT)
Message-ID: <74f4593a-eada-40cc-8371-0f53a62f39ad@linaro.org>
Date: Wed, 8 May 2024 12:36:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/12] libvhost-user: enable it on any POSIX system
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
 <20240508074457.12367-9-sgarzare@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240508074457.12367-9-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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
> The vhost-user protocol is not really Linux-specific so let's enable
> libvhost-user for any POSIX system.
> 
> Compiling it on macOS and FreeBSD some problems came up:
> - avoid to include linux/vhost.h which is avaibale only on Linux

"available"

>    (vhost_types.h contains many of the things we need)
> - macOS doesn't provide sys/endian.h, so let's define them
>    (note: libvhost-user doesn't include qemu's headers, so we can't use

"QEMU"

>     use "qemu/bswap.h")
> - define eventfd_[write|read] as write/read wrapper when system doesn't
>    provide those (e.g. macOS)
> - copy SEAL defines from include/qemu/memfd.h to make the code works
>    on FreeBSD where MFD_ALLOW_SEALING is defined

Alternatively add in subprojects/libvhost-user/include/osdep.h.

> - define MAP_NORESERVE if it's not defined (e.g. on FreeBSD)
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   meson.build                               |  2 +-
>   subprojects/libvhost-user/libvhost-user.h |  2 +-
>   subprojects/libvhost-user/libvhost-user.c | 60 +++++++++++++++++++++--
>   3 files changed, 59 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>



