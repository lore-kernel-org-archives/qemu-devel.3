Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD52CFB43F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 09:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxkEn-0005jC-TU; Mon, 07 Oct 2024 05:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sxkEl-0005iw-AX
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 05:41:07 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sxkEh-0005Av-MA
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 05:41:07 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-71df2b0a2f7so1428901b3a.3
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 02:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728294062; x=1728898862;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QryXnF6nXxKw6ZH1DrOeBNBk4Z+kgjoP0clVzHzesag=;
 b=nrVQ1Lzl5fmWmai+Xr6XjuR5TMbLpcqhrjodTXYuAmsqS96NVRDJ3WEre5Y38yVXbG
 Z2AC7uHl+oJQfgxO+qWGtASiNprMf5I81sv1CWikQtGa/zHoczIFfcGpEM0jA5CtF8n2
 1OChGo8/g3wN0CKk1Aq1snQkvUJ1qf772ZxVy/Gh51u406uBPjF0miaxdQ+1iQYWQ/X4
 +0W61BEhjR9bxLd/6KDEkw3mrqiy9k4dBf2ZUFFP+EblVQq3pKgtdgZkQM+MNsgDox1/
 FDtF9ZhAe9IOYdsTUO3xj1lz7+722COy44QBQJmDUVjo9SEfPfs+oCr9zlQ3Qt2jmVQS
 BwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728294062; x=1728898862;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QryXnF6nXxKw6ZH1DrOeBNBk4Z+kgjoP0clVzHzesag=;
 b=q8Prze25e6XAWTGafzUJMMHhD98fkLjpr9gjwO7h+q8DosH6plBT+dgkMGCYlV6CTN
 euzN7N1fEExH+TRwzeyHThH5dvN/bW59a85qfdgKvL9b4SO3KzLPm3dKRwtbkGwEFKVJ
 D1q4zMuD2v57ZIh5MUPoQzZ006GOJJeUS0t9xSDEyPEJPXQwdGyz5G5pF+VR+NHGDKSE
 7N5b3Pl6P+xEgz+dkQZDMPy3HPDC3LWfVAs6t92RAsZkLjrMIIeC2owDGuJNFkRhx9js
 RaP358l+f4IMF/uVGznGd+SfGwmqKlPfq4ozfbEsqdGPzbjGspLg6Espge6LmHQELR6d
 0CcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUunFYZ4m2DP0tQDnVlNmkqq9Kjs6dJMb4ll4v+lGeDPUdmUrn4KfuO5Kk4Kofg5VDi4079ck3sSrCW@nongnu.org
X-Gm-Message-State: AOJu0YzUoA4nFVKPWQPxcFM15mbMcMaLdFh73rXkIPOhr6ArG3hOyZ05
 nxmbiyLqw835l96ip/SK0r2sgrrGr2EZXTIz82grtC9gDC9+SaQlxMIQ/4VQRK4=
X-Google-Smtp-Source: AGHT+IFLhdHamsRokoW69B8BReR7QDTEp99ILAnHxpix3s5Ab580nuKm2vs2BOOZA8izY+iAoycijA==
X-Received: by 2002:a05:6a20:c890:b0:1cf:122b:6ab6 with SMTP id
 adf61e73a8af0-1d6dfa3a4ccmr15773658637.12.1728294062135; 
 Mon, 07 Oct 2024 02:41:02 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d7cf82sm3993427b3a.200.2024.10.07.02.40.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 02:41:01 -0700 (PDT)
Message-ID: <d93db4fb-9819-4e00-a243-16feb98fc4d9@daynix.com>
Date: Mon, 7 Oct 2024 18:40:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/6] ui/sdl2: Implement dpy dmabuf functions
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>
References: <20241006232350.3198759-1-dmitry.osipenko@collabora.com>
 <20241006232350.3198759-3-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241006232350.3198759-3-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42d.google.com
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

On 2024/10/07 8:23, Dmitry Osipenko wrote:
> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> 
> If EGL is used, we can rely on dmabuf to import textures without
> doing copies.
> 
> To get this working on X11, we use the existing SDL hint:
> SDL_HINT_VIDEO_X11_FORCE_EGL (because dmabuf can't be used with GLX).
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   include/ui/sdl2.h |  5 +++++
>   ui/sdl2-gl.c      | 39 +++++++++++++++++++++++++++++++++++++++
>   ui/sdl2.c         |  8 ++++++++
>   3 files changed, 52 insertions(+)
> 
> diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
> index dbe6e3d9739b..b14552f5cd71 100644
> --- a/include/ui/sdl2.h
> +++ b/include/ui/sdl2.h
> @@ -96,5 +96,10 @@ void sdl2_gl_scanout_texture(DisplayChangeListener *dcl,
>                                void *d3d_tex2d);
>   void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
>                              uint32_t x, uint32_t y, uint32_t w, uint32_t h);
> +void sdl2_gl_scanout_dmabuf(DisplayChangeListener *dcl,
> +                            QemuDmaBuf *dmabuf);
> +void sdl2_gl_release_dmabuf(DisplayChangeListener *dcl,
> +                            QemuDmaBuf *dmabuf);
> +bool sdl2_gl_has_dmabuf(DisplayChangeListener *dcl);
>   
>   #endif /* SDL2_H */
> diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
> index b1fe96d6af22..24aa9108682e 100644
> --- a/ui/sdl2-gl.c
> +++ b/ui/sdl2-gl.c
> @@ -26,6 +26,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/main-loop.h"
>   #include "ui/console.h"
>   #include "ui/input.h"
>   #include "ui/sdl2.h"
> @@ -227,6 +228,44 @@ void sdl2_gl_scanout_texture(DisplayChangeListener *dcl,
>                            backing_id, false);
>   }
>   
> +void sdl2_gl_scanout_dmabuf(DisplayChangeListener *dcl,
> +                            QemuDmaBuf *dmabuf)
> +{
> +    struct sdl2_console *scon = container_of(dcl, struct sdl2_console, dcl);
> +
> +    assert(scon->opengl);
> +    SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
> +
> +    egl_dmabuf_import_texture(dmabuf);
> +    if (!qemu_dmabuf_get_texture(dmabuf)) {
> +        fprintf(stderr, "sdl2_gl_scanout_dmabuf failed fd=%d\n",
> +                qemu_dmabuf_get_fd(dmabuf));

Use error_report(). Use __func__ to print the function name.

> +    }
> +
> +    sdl2_gl_scanout_texture(dcl, qemu_dmabuf_get_texture(dmabuf), false,
> +                            qemu_dmabuf_get_width(dmabuf),
> +                            qemu_dmabuf_get_height(dmabuf),
> +                            0, 0,
> +                            qemu_dmabuf_get_width(dmabuf),
> +                            qemu_dmabuf_get_height(dmabuf),
> +                            NULL);
> +
> +    if (qemu_dmabuf_get_allow_fences(dmabuf)) {
> +        scon->guest_fb.dmabuf = dmabuf;
> +    }
> +}
> +
> +void sdl2_gl_release_dmabuf(DisplayChangeListener *dcl,
> +                            QemuDmaBuf *dmabuf)
> +{
> +    egl_dmabuf_release_texture(dmabuf);
> +}
> +
> +bool sdl2_gl_has_dmabuf(DisplayChangeListener *dcl)
> +{
> +    return qemu_egl_has_dmabuf();
> +}
> +
>   void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
>                              uint32_t x, uint32_t y, uint32_t w, uint32_t h)
>   {
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index bd4f5a9da14a..8c7b01c5e62f 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -120,6 +120,9 @@ void sdl2_window_create(struct sdl2_console *scon)
>           /* The SDL renderer is only used by sdl2-2D, when OpenGL is disabled */
>           scon->real_renderer = SDL_CreateRenderer(scon->real_window, -1, 0);
>       }
> +
> +    qemu_egl_display = eglGetCurrentDisplay();
> +
>       sdl_update_caption(scon);
>   }
>   
> @@ -820,6 +823,10 @@ static const DisplayChangeListenerOps dcl_gl_ops = {
>       .dpy_gl_scanout_disable  = sdl2_gl_scanout_disable,
>       .dpy_gl_scanout_texture  = sdl2_gl_scanout_texture,
>       .dpy_gl_update           = sdl2_gl_scanout_flush,
> +
> +    .dpy_gl_scanout_dmabuf   = sdl2_gl_scanout_dmabuf,
> +    .dpy_gl_release_dmabuf   = sdl2_gl_release_dmabuf,
> +    .dpy_has_dmabuf          = sdl2_gl_has_dmabuf,
>   };
>   
>   static bool
> @@ -877,6 +884,7 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
>       SDL_SetHint(SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED, "0");
>   #endif
>       SDL_SetHint(SDL_HINT_WINDOWS_NO_CLOSE_ON_ALT_F4, "1");
> +    SDL_SetHint(SDL_HINT_VIDEO_X11_FORCE_EGL, "1");

I think it needs to handle cases where X11 is not used or only GLX is 
available.

>       SDL_EnableScreenSaver();
>       memset(&info, 0, sizeof(info));
>       SDL_VERSION(&info.version);


