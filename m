Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3DC1D1D862
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 06:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR2rz-00068L-1F; Thu, 04 Dec 2025 01:31:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vR2rt-00063G-8s
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 01:31:10 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vR2rq-00025O-8K
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 01:31:08 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5B46TSj4048898
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 4 Dec 2025 15:30:55 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=jSKX60ET3827mEN1cOD5D6dCR586jg70HwXfucDkGig=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1764829855; v=1;
 b=ff3YvVWY5kMRmLf6s/PcYsqXjAlKzkQ3RExFfXHqzRFqsgk40I+2KMWHIxHn4cLK
 TjFEUH8ajhj2bScv6eqfFWgM9gRtdXlyiO0keYtXOBqm0EXLlsOpic/X7W/4FuSy
 7JIo0Cewqt3EqYNeQCjZMU++OhMdRMK6KR9jEemn8wLNCfnJQlKMbLgqksVzu1n8
 Gy0Bb+3+xeVa2R9WfN1zFxXyaRjxIk/gJ1ZZcb+F7MC9Qo/RHBGjD9y3PzvhenTy
 yAvuzJb0Y69w9EkgS0crQ9nKwiWOAXbTvolMKW8k/3DUuR2eB95BMCqQJ5mQ94Kw
 iePaDzWtBh7nd64p1EpG4Q==
Message-ID: <3a401334-700f-4b11-b006-a93470d38a66@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 4 Dec 2025 15:29:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/7] egl-helpers: store handle to native device
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20251203040754.94487-1-j@getutm.app>
 <20251203040754.94487-2-j@getutm.app>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251203040754.94487-2-j@getutm.app>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/12/03 13:07, Joelle van Dyne wrote:
> Make way for other platforms by making the variable more general. Also we
> will be using the device in the future so let's save the pointer in the
> global instead of just a boolean flag.
> 
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> ---
>   include/ui/egl-helpers.h      | 2 +-
>   hw/display/virtio-gpu-virgl.c | 2 +-
>   ui/egl-helpers.c              | 4 ++--
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
> index acf993fcf5..c239d32317 100644
> --- a/include/ui/egl-helpers.h
> +++ b/include/ui/egl-helpers.h
> @@ -12,7 +12,7 @@
>   extern EGLDisplay *qemu_egl_display;
>   extern EGLConfig qemu_egl_config;
>   extern DisplayGLMode qemu_egl_mode;
> -extern bool qemu_egl_angle_d3d;
> +extern void *qemu_egl_angle_native_device;

I guess ANGLE will not be relevant for Metal and leaving it will be 
misleading.

Regards,
Akihiko Odaki

>   
>   typedef struct egl_fb {
>       int width;
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 07f6355ad6..20c856c04e 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -1152,7 +1152,7 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>       }
>   #endif
>   #ifdef VIRGL_RENDERER_D3D11_SHARE_TEXTURE
> -    if (qemu_egl_angle_d3d) {
> +    if (qemu_egl_angle_native_device) {
>           flags |= VIRGL_RENDERER_D3D11_SHARE_TEXTURE;
>       }
>   #endif
> diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> index e3f2872cc1..57bcf99498 100644
> --- a/ui/egl-helpers.c
> +++ b/ui/egl-helpers.c
> @@ -28,7 +28,7 @@
>   EGLDisplay *qemu_egl_display;
>   EGLConfig qemu_egl_config;
>   DisplayGLMode qemu_egl_mode;
> -bool qemu_egl_angle_d3d;
> +void *qemu_egl_angle_native_device;
>   
>   /* ------------------------------------------------------------------ */
>   
> @@ -651,7 +651,7 @@ int qemu_egl_init_dpy_win32(EGLNativeDisplayType dpy, DisplayGLMode mode)
>           }
>   
>           trace_egl_init_d3d11_device(device);
> -        qemu_egl_angle_d3d = device != NULL;
> +        qemu_egl_angle_native_device = d3d11_device;
>       }
>   #endif
>   


