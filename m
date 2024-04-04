Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFA9CD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 14:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsNms-0001Xk-5F; Thu, 04 Apr 2024 10:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rsNmm-0001XM-Aq
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:09:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rsNmg-0005rv-Is
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712239780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qbTxxXDxMHKkyBhv7NCJYGfLffph+aM60C21cm8e+c4=;
 b=gdNdTGvdF1hVQCKI36OSOKC7oEecS8fHaU0GFMDTOYCM1pjk0VCXtEgHWsZyeEJGr9+Gib
 TyVqUF9iT7oy8dpSHydPM17ckKVOSImyK0tRTxd1ozLElEi5LsjMMXqnxrGXr1L/3T0hb4
 W2VnsrdqbAVeR29EO+MvkxvWGzlwlM8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-8Efq-RwVM0iIoAEIQR38yA-1; Thu, 04 Apr 2024 10:09:38 -0400
X-MC-Unique: 8Efq-RwVM0iIoAEIQR38yA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2d4a0c99d66so7835521fa.3
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 07:09:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712239777; x=1712844577;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qbTxxXDxMHKkyBhv7NCJYGfLffph+aM60C21cm8e+c4=;
 b=w97+1ctK60UbOq+BVe+f4omRWoM3lNRzbHGPly19Sm6imtoTQwE4zBiQr8V0u7xiCu
 HOe5dllYNeMimemj4XjmazqOKQOJQrUd8nYM9MjzRI8C4kmwxVDu51fKdAVG23iLbc9v
 FUzOPJDfxO/Tjz86B501BKvwJ9d5ax4mhDQICfCz2e+HAz206L5QqHwAkIRMkZ6dxO1Q
 w3e7eotCmu3jiiJux9rpsJ+Se7Z7GAlnVR0b+VxBt5Af0AYQr3D8mi+Gq5NWZsgfYyuc
 51VHdvs7GRfELKyhKonGzBq8HyEW2S4+uJXftQBPG8z1CnYLQ3VE0BuDaA7UqExJ8MdF
 +tcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlr6+omAGjbmCMkRxwgOy/cZf1fM2eSuhgvCOyQoA15AyxgpL/iqRp9f0QQVNGTs6o/SO4g496x8i8k3o2HcxIo+qoymA=
X-Gm-Message-State: AOJu0YzffuT1iOwhxuI9a5rbdvI9vifwe0qw7+x4GgnhXpy5mpJHa6ka
 fZlrB2OdVDZ8TpYsIm4ZUhfmbMh0dIE0+++Z33/e6N/QGvfNcj7Jz82Mm57nFHfmNwKfE3QgoHk
 JYRWd4MaIcxOGjsO6/06XKXVu6BAGDE4J8bSnIMm+F6ect9LT4i3o
X-Received: by 2002:a2e:908c:0:b0:2d8:408c:3f5b with SMTP id
 l12-20020a2e908c000000b002d8408c3f5bmr2068039ljg.5.1712239777038; 
 Thu, 04 Apr 2024 07:09:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH23y/l1Wvft2MpCjPK2XM++yU6XvXc0bZGiG5lh/TTg9wjoAwkw3vyI8w9trr0iTIN+qwxQg==
X-Received: by 2002:a2e:908c:0:b0:2d8:408c:3f5b with SMTP id
 l12-20020a2e908c000000b002d8408c3f5bmr2068008ljg.5.1712239776587; 
 Thu, 04 Apr 2024 07:09:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c743:de00:7030:120f:d1c9:4c3c?
 (p200300cbc743de007030120fd1c94c3c.dip0.t-ipconnect.de.
 [2003:cb:c743:de00:7030:120f:d1c9:4c3c])
 by smtp.gmail.com with ESMTPSA id
 r18-20020a05600c35d200b004157ff88ad7sm2833321wmq.7.2024.04.04.07.09.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Apr 2024 07:09:36 -0700 (PDT)
Message-ID: <c5c89a6e-adf7-4f25-b9b5-2979e4367dfd@redhat.com>
Date: Thu, 4 Apr 2024 16:09:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 v3 09/11] hostmem: add a new memory backend based
 on POSIX shm_open()
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: Coiby Xu <Coiby.Xu@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, slp@redhat.com, Eduardo Habkost
 <eduardo@habkost.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, stefanha@redhat.com,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 gmaglione@redhat.com, Jason Wang <jasowang@redhat.com>
References: <20240404122330.92710-1-sgarzare@redhat.com>
 <20240404122330.92710-10-sgarzare@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240404122330.92710-10-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 04.04.24 14:23, Stefano Garzarella wrote:
> shm_open() creates and opens a new POSIX shared memory object.
> A POSIX shared memory object allows creating memory backend with an
> associated file descriptor that can be shared with external processes
> (e.g. vhost-user).
> 
> The new `memory-backend-shm` can be used as an alternative when
> `memory-backend-memfd` is not available (Linux only), since shm_open()
> should be provided by any POSIX-compliant operating system.
> 
> This backend mimics memfd, allocating memory that is practically
> anonymous. In theory shm_open() requires a name, but this is allocated
> for a short time interval and shm_unlink() is called right after
> shm_open(). After that, only fd is shared with external processes
> (e.g., vhost-user) as if it were associated with anonymous memory.
> 
> In the future we may also allow the user to specify the name to be
> passed to shm_open(), but for now we keep the backend simple, mimicking
> anonymous memory such as memfd.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v3
> - enriched commit message and documentation to highlight that we
>    want to mimic memfd (David)
> ---
>   docs/system/devices/vhost-user.rst |   5 +-
>   qapi/qom.json                      |  17 +++++
>   backends/hostmem-shm.c             | 118 +++++++++++++++++++++++++++++
>   backends/meson.build               |   1 +
>   qemu-options.hx                    |  11 +++
>   5 files changed, 150 insertions(+), 2 deletions(-)
>   create mode 100644 backends/hostmem-shm.c
> 
> diff --git a/docs/system/devices/vhost-user.rst b/docs/system/devices/vhost-user.rst
> index 9b2da106ce..35259d8ec7 100644
> --- a/docs/system/devices/vhost-user.rst
> +++ b/docs/system/devices/vhost-user.rst
> @@ -98,8 +98,9 @@ Shared memory object
>   
>   In order for the daemon to access the VirtIO queues to process the
>   requests it needs access to the guest's address space. This is
> -achieved via the ``memory-backend-file`` or ``memory-backend-memfd``
> -objects. A reference to a file-descriptor which can access this object
> +achieved via the ``memory-backend-file``, ``memory-backend-memfd``, or
> +``memory-backend-shm`` objects.
> +A reference to a file-descriptor which can access this object
>   will be passed via the socket as part of the protocol negotiation.
>   
>   Currently the shared memory object needs to match the size of the main
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 85e6b4f84a..5252ec69e3 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -721,6 +721,19 @@
>               '*hugetlbsize': 'size',
>               '*seal': 'bool' } }
>   
> +##
> +# @MemoryBackendShmProperties:
> +#
> +# Properties for memory-backend-shm objects.
> +#
> +# The @share boolean option is true by default with shm.
> +#
> +# Since: 9.1
> +##
> +{ 'struct': 'MemoryBackendShmProperties',
> +  'base': 'MemoryBackendProperties',
> +  'data': { } }
> +

Acked-by: David Hildenbrand <david@redhat.com>

One comment: we should maybe just forbid setting share=off. it doesn't 
make any sense and it can even result in an unexpected double memory 
consumption. We missed doing that for memfd, unfortunately.

-- 
Cheers,

David / dhildenb


