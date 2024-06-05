Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E85C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 20:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEwtU-0000xb-TU; Wed, 05 Jun 2024 16:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sEwtS-0000x6-3w
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 16:05:58 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sEwtM-0004Jx-HE
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 16:05:57 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f612d7b0f5so1224805ad.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 13:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1717617951; x=1718222751;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=didsxEtNNzkO9PRvXUmXSsu0yDBLvUMdPfG+5VrLadw=;
 b=2ZGcTge3/DcHTKBp6pSmN9aoXKMqIdYiR80arp5Z2az3YLmg/rUAqo3V2Q792fq9PF
 GSmR3pKHzWzIt+v7pgDovocf/RCT2ZIdExfQ2VK/BXniqO2yDE/V7TfOyvIgNjqW4160
 SmJ60owXF+jTMOr70tQIZ3MMvdtkAXGZwvZQhJknqrJH6vDfNxcuWarAnEYK791s8U3r
 07zSZzMvCgHhvCGqod6AiNXYupDWUDgYeJs9FfPCHicu3e2iT4fFyrhRl/XWOP+wYZua
 Oh5/3rINGlao24+yclSFPpWfjmdTejtU2HONanzZwfSR7LdBusiuE32aWI3/1SgnMNzy
 2k6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717617951; x=1718222751;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=didsxEtNNzkO9PRvXUmXSsu0yDBLvUMdPfG+5VrLadw=;
 b=euIO0GZzBcaMTSPKlGZdjFNeK1bvcKhvykfn80a3YUkPqCODsxECbflGjzrOF63fZy
 YP5COtYStiLwIypMXXdyNq1OaJcF2ZxygsU6Vor3lyEVAcq06SUUxh8l/cC6jcHIBcMy
 hNvOv/9o3+PqWRaaauCEnGuCkZb8cpUQMRvszDTi+m2U1ZADQfwnHQKfM1ZWxtIIlfa4
 cqwKADf9mmK2pxuLBzkbcEDs5a4k2Sofos+Z4daMDhYlhDwGVfAglrWk1UqZRlDegdmh
 rMjqm+PKi1K+4RcFxHikvBYPPxGdo9VM2r9Jk1mLEuu7jPV8abHB7CJeHLbkrBZ3cEHu
 MVGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2qRthr1qRrh8QI1I5IG3Tf+v45ymDEaefoPqEa5icXoxdS6Bnc7VHJH9yPgS+TFrceIaaqblXloEzKc/x2b7z0ZQOAAg=
X-Gm-Message-State: AOJu0Yxd3UvGxckiUs31rD4kjqErxx6p/jbYt+7rpsfTdTOAWCxJxK2A
 JfCrIzIWJXCIoGdkhCoTiBySLOVQJAB/M2KC1Ug4opnRGGftKBbvQvpAGx9qfkM=
X-Google-Smtp-Source: AGHT+IGywqrp1UBgEm6c9B4TzCp0lzyQ5ISKcBjorH7dn0tw9kVMWwugOk1pBLfi/IrSd0JxxHwnpw==
X-Received: by 2002:a17:902:ea04:b0:1f6:38ba:ef56 with SMTP id
 d9443c01a7336-1f6b8ead1efmr9157605ad.18.1717617950625; 
 Wed, 05 Jun 2024 13:05:50 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323ddac9sm108997765ad.173.2024.06.05.13.05.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 13:05:50 -0700 (PDT)
Message-ID: <43f3ae5f-4bb8-4330-a79d-b0a50d2e397a@daynix.com>
Date: Thu, 6 Jun 2024 05:05:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] subprojects: add a wrapper for libvirglrenderer
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20240605133527.529950-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240605133527.529950-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/06/05 22:35, Alex Bennée wrote:
> As the latest features for virtio-gpu need a pretty recent version of
> libvirglrenderer. When it is not available on the system we can use a
> meson wrapper and provide it when --download is specified in
> configure.
> 
> We have to take some additional care as currently QEMU will hang
> libvirglrenderer fails to exec the render server. As the error isn't
> back propagated we make sure we at least test we have a path to an
> executable before tweaking the environment.

Hi,

The intent of this patch sounds good to me. It is the responsibility of 
users to set up virglrenderer in principle, but we can just be kind for 
them.

> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   meson.build                    |  7 ++++++-
>   hw/display/virtio-gpu-virgl.c  | 24 ++++++++++++++++++++++++
>   subprojects/virglrenderer.wrap |  6 ++++++
>   3 files changed, 36 insertions(+), 1 deletion(-)
>   create mode 100644 subprojects/virglrenderer.wrap
> 
> diff --git a/meson.build b/meson.build
> index 1d7346b703..e4e270df78 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1203,7 +1203,8 @@ have_vhost_user_gpu = have_tools and host_os == 'linux' and pixman.found()
>   if not get_option('virglrenderer').auto() or have_system or have_vhost_user_gpu
>     virgl = dependency('virglrenderer',
>                        method: 'pkg-config',
> -                     required: get_option('virglrenderer'))
> +                     required: get_option('virglrenderer'),
> +                     default_options: ['default_library=static', 'render-server=true', 'venus=true'])

meson_options.txt of virglrenderer says:
 > DEPRECATED: render server is enabled by venus automatically

I'm also a bit concerned to enable Venus by default when the upstream 
virglrenderer doesn't. Why is it disabled by the upstream? Perhaps is it 
time for upstream to enable it by default?

>   endif
>   rutabaga = not_found
>   if not get_option('rutabaga_gfx').auto() or have_system or have_vhost_user_gpu
> @@ -2314,6 +2315,10 @@ if virgl.version().version_compare('>=1.0.0')
>     config_host_data.set('HAVE_VIRGL_RESOURCE_BLOB', 1)
>     config_host_data.set('HAVE_VIRGL_VENUS', 1)
>   endif
> +if virgl.type_name().contains('internal')
> +  config_host_data.set('HAVE_BUNDLED_VIRGL_SERVER', 1)
> +endif
> +
>   config_host_data.set('CONFIG_VIRTFS', have_virtfs)
>   config_host_data.set('CONFIG_VTE', vte.found())
>   config_host_data.set('CONFIG_XKBCOMMON', xkbcommon.found())
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index c9d20a8a60..53d6742e79 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -14,6 +14,7 @@
>   #include "qemu/osdep.h"
>   #include "qemu/error-report.h"
>   #include "qemu/iov.h"
> +#include "qemu/cutils.h"
>   #include "trace.h"
>   #include "hw/virtio/virtio.h"
>   #include "hw/virtio/virtio-gpu.h"
> @@ -1122,6 +1123,26 @@ void virtio_gpu_virgl_reset(VirtIOGPU *g)
>       virgl_renderer_reset();
>   }
>   
> +/*
> + * If we fail to spawn the render server things tend to hang so it is
> + * important to do our due diligence before then. If QEMU has bundled
> + * the virgl server we want to ensure we can run it from the build
> + * directory and if installed.

This comment sounds a bit misleading. The following code does not ensure 
the render server exists; it just opportunistically sets the path to the 
bundled render server or let it fail otherwise.

It also sounds like virgl_set_render_env() does an extra step to prevent 
hangs, but it is actually mandatory for relocated scenarios; the lack of 
render server always results in a non-functional Venus setup even if the 
hang is fixed.

The hang is better to be noted in subprojects/virglrenderer.wrap since 
that is the reason we would want to wrap the project.

> + *
> + * The principle way we can override the libvirglrenders behaviour is
> + * by setting environment variables.
> + */
> +static void virgl_set_render_env(void)
> +{
> +#ifdef HAVE_BUNDLED_VIRGL_SERVER
> +    g_autofree char *file = get_relocated_path(CONFIG_QEMU_HELPERDIR "/virgl_render_server");
> +    if (g_file_test(file, G_FILE_TEST_EXISTS | G_FILE_TEST_IS_EXECUTABLE)) {

I think this g_file_test() should be removed; we would not want to let 
virglrenderer pick a random render server when the bundled server exists 
since the ABI between them can be different in theory.

> +        g_setenv("RENDER_SERVER_EXEC_PATH", file, false);
> +    }
> +#endif
> +}
> +
> +
>   int virtio_gpu_virgl_init(VirtIOGPU *g)
>   {
>       int ret;
> @@ -1145,6 +1166,9 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>       }
>   #endif
>   
> +    /* Ensure we can find the render server */
> +    virgl_set_render_env();
> +
>       ret = virgl_renderer_init(g, flags, &virtio_gpu_3d_cbs);
>       if (ret != 0) {
>           error_report("virgl could not be initialized: %d", ret);
> diff --git a/subprojects/virglrenderer.wrap b/subprojects/virglrenderer.wrap
> new file mode 100644
> index 0000000000..3656a478c4
> --- /dev/null
> +++ b/subprojects/virglrenderer.wrap
> @@ -0,0 +1,6 @@
> +[wrap-git]
> +url = https://gitlab.freedesktop.org/virgl/virglrenderer.git
> +revision = virglrenderer-1.0.1
> +
> +[provide]
> +virglrenderer = libvirglrenderer_dep

