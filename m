Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAADCFB43F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 12:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxmQv-0008C0-O4; Mon, 07 Oct 2024 08:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sxmQu-0008Ag-2V
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 08:01:48 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sxmQr-0006VA-NK
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 08:01:47 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-71dfc1124cdso978482b3a.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 05:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728302503; x=1728907303;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B9yKGp1vWNKs7QA5b7GoWCNeeLnl4kk25l5cxOUfhbw=;
 b=qX9BSGugUV1P1At69Ni/YEV0FLJbSqveaeI4gOjFAsR56ZE8ov0DsNE60QSQkbhT9X
 jiyy6PwMKjVzRZ8lGfNyr+taM+t05x8JoeVJpWjd0lPptEY3NuP9fmckChZLhLLn/e9d
 Rw8VQIT104gl5sbPaXho/FxG+wyg09EAgzjqf7DLmLD8gjB4JyUrA1sXhk0wAoaB93Ln
 /S3dHfrYKLXAU46zZlEZZhximNqFHeOcGeR1X+AmgH7saCl7vMuG0OoBJJanwbFigNpY
 ZP3Wz8uqb+VSEzq/DC3XeRgh6//bz3Hy/+ShhW99aUL+PM+LZINDKeN6TtQl8mvqRg5d
 XCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728302503; x=1728907303;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B9yKGp1vWNKs7QA5b7GoWCNeeLnl4kk25l5cxOUfhbw=;
 b=CuTbMjn+gMUrFTm3HR7OXJO/nkxxVlDkX1aPQeY3sDdtZ7dFFjdIXG5iyQrehqqwG/
 l7Y0tLC2qihyLF18fGA7xjOm1fgqSH+HBG6DKaq3Kcn//IyhX9EsjjFc2WVs+SR4q9xl
 iRSQ+npKHEl4egZhqEG4XI0dCRGWMxetW8unzZtAMPixFJGAxRGwTo/MlhMZ8M+pe2KF
 BjB/PKj3saZcokTXHMayWrvgSsjW/MYItoPgjuJbGc2nsWkmCEDE8D2u/3BEbAyf7FvJ
 UzzEs0SLSgFTe9PDMhrmwRlVkkggSpqHiEYGWstkp3534dhpkuIO4VJbNFgppOi7vomB
 0p4g==
X-Gm-Message-State: AOJu0Yx8MVLl7mbTRDupwodGnE+a5WwGaB2fSY1LbMx3682+52QJJ/4W
 bfYs4WQ4FYyblBnKlhfwul9p1J8koAtBkEnQPd1ue6b3Gk8060fbVd0uqV1m0wg=
X-Google-Smtp-Source: AGHT+IGu/XNknBT9LBbCp+sav/qYdCEqi4647BS9KYEdmZmuZuxcJ7VuNbedZsIBmcd25wHQXUC6Ww==
X-Received: by 2002:a05:6a00:22d0:b0:71e:d7:378a with SMTP id
 d2e1a72fcca58-71e00d73998mr5733863b3a.11.1728302503194; 
 Mon, 07 Oct 2024 05:01:43 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:32ed:25ae:21b1:72d6?
 ([2400:4050:a840:1e00:32ed:25ae:21b1:72d6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0ccd1aesm4261849b3a.67.2024.10.07.05.01.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 05:01:42 -0700 (PDT)
Message-ID: <2987c447-0fe7-4c9f-8a28-0963fb673fab@daynix.com>
Date: Mon, 7 Oct 2024 21:01:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/16] ui/surface: allocate shared memory on !win32
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 belmouss@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20241003112244.3340697-1-marcandre.lureau@redhat.com>
 <20241003112244.3340697-13-marcandre.lureau@redhat.com>
 <24a91b5d-89a3-4338-874c-78aaf22b93ac@daynix.com>
 <CAMxuvay2B_hwZ4eyqp_cRGe5XH1wWkHbVPDEOgBjScKAE7uosA@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAMxuvay2B_hwZ4eyqp_cRGe5XH1wWkHbVPDEOgBjScKAE7uosA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::429;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/10/07 20:47, Marc-André Lureau wrote:
> On Sat, Oct 5, 2024 at 12:59 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2024/10/03 20:22, marcandre.lureau@redhat.com wrote:
>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>
>>> Use qemu_memfd_alloc() to allocate the display surface memory, which
>>> will fallback on tmpfile/mmap() on systems without memfd, and allow to
>>> share the display with other processes.
>>>
>>> This is similar to how display memory is allocated on win32 since commit
>>> 09b4c198 ("console/win32: allocate shareable display surface").
>>>
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>    include/ui/surface.h |  8 ++++++++
>>>    ui/console.c         | 30 ++++++++++++++++++++++++++++--
>>>    2 files changed, 36 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/ui/surface.h b/include/ui/surface.h
>>> index 345b19169d..dacf12ffe2 100644
>>> --- a/include/ui/surface.h
>>> +++ b/include/ui/surface.h
>>> @@ -23,6 +23,10 @@ typedef struct DisplaySurface {
>>>        GLenum gltype;
>>>        GLuint texture;
>>>    #endif
>>> +#ifndef WIN32
>>> +    int shmfd;
>>> +    uint32_t shmfd_offset;
>>> +#endif
>>>    #ifdef WIN32
>>>        HANDLE handle;
>>
>> What about defining a new struct that contains either of shmfd or
>> handle? We can then have a unified set of functions that uses the struct
>> to allocate/free a shared pixman image and to set one to DisplaySurface.
> 
> Well, that structure is pretty much DisplaySurface. I am not sure if
> it's valuable to introduce another abstraction.

I was thinking using the abstraction for virtio-gpu to save ifdefs. It 
already has resource_set_image_destroy to abstract away the resource 
deallocation so ui/console.c can absorb it.

> 
>>
>>>        uint32_t handle_offset;
>>> @@ -37,6 +41,10 @@ DisplaySurface *qemu_create_displaysurface_from(int width, int height,
>>>    DisplaySurface *qemu_create_displaysurface_pixman(pixman_image_t *image);
>>>    DisplaySurface *qemu_create_placeholder_surface(int w, int h,
>>>                                                    const char *msg);
>>> +#ifndef WIN32
>>> +void qemu_displaysurface_set_shmfd(DisplaySurface *surface,
>>> +                                   int shmfd, uint32_t offset);
>>> +#endif
>>>    #ifdef WIN32
>>>    void qemu_displaysurface_win32_set_handle(DisplaySurface *surface,
>>>                                              HANDLE h, uint32_t offset);
>>> diff --git a/ui/console.c b/ui/console.c
>>> index fdd76c2be4..56f2462c3d 100644
>>> --- a/ui/console.c
>>> +++ b/ui/console.c
>>> @@ -37,6 +37,7 @@
>>>    #include "trace.h"
>>>    #include "exec/memory.h"
>>>    #include "qom/object.h"
>>> +#include "qemu/memfd.h"
>>>
>>>    #include "console-priv.h"
>>>
>>> @@ -452,6 +453,17 @@ qemu_graphic_console_init(Object *obj)
>>>    {
>>>    }
>>>
>>> +#ifndef WIN32
>>> +void qemu_displaysurface_set_shmfd(DisplaySurface *surface,
>>> +                                   int shmfd, uint32_t offset)
>>> +{
>>> +    assert(surface->shmfd == -1);
>>> +
>>> +    surface->shmfd = shmfd;
>>> +    surface->shmfd_offset = offset;
>>> +}
>>> +#endif
>>> +
>>>    #ifdef WIN32
>>>    void qemu_displaysurface_win32_set_handle(DisplaySurface *surface,
>>>                                              HANDLE h, uint32_t offset)
>>> @@ -469,12 +481,16 @@ DisplaySurface *qemu_create_displaysurface(int width, int height)
>>>        void *bits = NULL;
>>>    #ifdef WIN32
>>>        HANDLE handle = NULL;
>>> +#else
>>> +    int shmfd = -1;
>>>    #endif
>>>
>>>        trace_displaysurface_create(width, height);
>>>
>>>    #ifdef WIN32
>>>        bits = qemu_win32_map_alloc(width * height * 4, &handle, &error_abort);
>>> +#else
>>> +    bits = qemu_memfd_alloc("displaysurface", width * height * 4, 0, &shmfd, &error_abort);
>>>    #endif
>>>
>>>        surface = qemu_create_displaysurface_from(
>>> @@ -486,9 +502,13 @@ DisplaySurface *qemu_create_displaysurface(int width, int height)
>>>
>>>    #ifdef WIN32
>>>        qemu_displaysurface_win32_set_handle(surface, handle, 0);
>>> -    pixman_image_set_destroy_function(surface->image,
>>> -                                      qemu_pixman_shared_image_destroy, handle);
>>> +    void *data = handle;
>>> +#else
>>> +    qemu_displaysurface_set_shmfd(surface, shmfd, 0);
>>> +    void *data = GINT_TO_POINTER(shmfd);
>>>    #endif
>>> +    pixman_image_set_destroy_function(surface->image, qemu_pixman_shared_image_destroy, data);
>>> +
>>>        return surface;
>>>    }
>>>
>>> @@ -499,6 +519,9 @@ DisplaySurface *qemu_create_displaysurface_from(int width, int height,
>>>        DisplaySurface *surface = g_new0(DisplaySurface, 1);
>>>
>>>        trace_displaysurface_create_from(surface, width, height, format);
>>> +#ifndef WIN32
>>> +    surface->shmfd = -1;
>>> +#endif
>>>        surface->image = pixman_image_create_bits(format,
>>>                                                  width, height,
>>>                                                  (void *)data, linesize);
>>> @@ -512,6 +535,9 @@ DisplaySurface *qemu_create_displaysurface_pixman(pixman_image_t *image)
>>>        DisplaySurface *surface = g_new0(DisplaySurface, 1);
>>>
>>>        trace_displaysurface_create_pixman(surface);
>>> +#ifndef WIN32
>>> +    surface->shmfd = -1;
>>> +#endif
>>>        surface->image = pixman_image_ref(image);
>>>
>>>        return surface;
>>
> 


