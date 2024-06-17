Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9CFC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 11:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJAqP-0002gi-Bp; Mon, 17 Jun 2024 07:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sJAqN-0002gD-2T
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 07:48:15 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sJAqK-0007Ep-Q7
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 07:48:14 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70417a6c328so3243228b3a.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 04:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1718624891; x=1719229691;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3whCFEkgOfgkGnJ6VfCDr4OUD71FsTa7JT0YgrUOPtw=;
 b=0vWhDsY2r+UV1X+5fPhz0YhNDTUgaLMirj3LekP3PEDukf/iF6NlSB3qC0GL0A1GGF
 CXoaRNeeWWsZZyr/7V77oZ9ISHyBzbVXPnmIMMoYARo9lkNPnmv7/4Kvexli88nil7F7
 6ni+wuaI8HhpGjTwuH10qFEAm0GnsN8TAPys3wS6A9J0en9tJ0ohDpbNEcxn5cY27SyP
 Zx2FiyxiLLDwOD4LA2K4ploRxHs7W25hcl4ssHi3bYU0oHZ1XRjo2C5M8EI1MmrsIYxv
 lKml+0fkG/x5uZ/+jD8FNoZEFp/eqZqmrr4hpr7F2l2OTOLUjIsmBoPN0QiY4pxLiAA2
 j5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718624891; x=1719229691;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3whCFEkgOfgkGnJ6VfCDr4OUD71FsTa7JT0YgrUOPtw=;
 b=n8+MQsV9FsZhhcdXZh4mKMcprd5iyN4UACb/h2TKhPZ83BakNmB5fslCbzbfsdeU/w
 95G3ylu/TY6jElbO2b32o5kt5J9GzXJxZPG5dIdhUxCf/UTVrInwZy0dshPZQm7GWwbP
 RDwNzJEPN+xiuk6Zi3j3ns4gffzXKutMrHbf82nmA5/2wxJuXis9B64m4R8CD+K5nd0g
 cjCEWzsfMeSvJW8lI0rGpsj2VWv0XSfYETBrFLrvq+E/kto5nwG4X9THCvO5IefragCL
 YiM44adCvQNvSdNu8EJ+9edUt7Tz05ykinNQKzYf+gXJC+bra/Xe8Q7t9PeV28YYvjlQ
 W+fw==
X-Gm-Message-State: AOJu0Yw83ddm0y+A758gcDL7VNIjF6zN5V+LFAiaOvK+b3WxnmrVfkQY
 xmH946yJ0VfqHa+hr5FHD0hyLZCyh4gk0JhDXHeV8MIaIQ1+5ePHlCXlCrdhqGk=
X-Google-Smtp-Source: AGHT+IFNbaVWpao5MRiQfdxiiquJ3v0wVQpEgFZfFNGu+HSznAPjn2U5WlyjhnvIVRnk0tjFcUmhBg==
X-Received: by 2002:a05:6a00:2349:b0:705:bc88:612a with SMTP id
 d2e1a72fcca58-705d70e4c2cmr11824150b3a.1.1718624890989; 
 Mon, 17 Jun 2024 04:48:10 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb6bf4fsm7187260b3a.169.2024.06.17.04.48.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 04:48:10 -0700 (PDT)
Message-ID: <454b686c-5c96-4a4d-b3e6-11f059e2148e@daynix.com>
Date: Mon, 17 Jun 2024 20:48:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] subprojects: add a wrapper for libvirglrenderer
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20240605133527.529950-1-alex.bennee@linaro.org>
 <43f3ae5f-4bb8-4330-a79d-b0a50d2e397a@daynix.com>
 <87cyofeu0q.fsf@draig.linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87cyofeu0q.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42d.google.com
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

On 2024/06/17 19:35, Alex Bennée wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> On 2024/06/05 22:35, Alex Bennée wrote:
>>> As the latest features for virtio-gpu need a pretty recent version of
>>> libvirglrenderer. When it is not available on the system we can use a
>>> meson wrapper and provide it when --download is specified in
>>> configure.
>>> We have to take some additional care as currently QEMU will hang
>>> libvirglrenderer fails to exec the render server. As the error isn't
>>> back propagated we make sure we at least test we have a path to an
>>> executable before tweaking the environment.
>>
>> Hi,
>>
>> The intent of this patch sounds good to me. It is the responsibility
>> of users to set up virglrenderer in principle, but we can just be kind
>> for them.
>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> ---
>>>    meson.build                    |  7 ++++++-
>>>    hw/display/virtio-gpu-virgl.c  | 24 ++++++++++++++++++++++++
>>>    subprojects/virglrenderer.wrap |  6 ++++++
>>>    3 files changed, 36 insertions(+), 1 deletion(-)
>>>    create mode 100644 subprojects/virglrenderer.wrap
>>> diff --git a/meson.build b/meson.build
>>> index 1d7346b703..e4e270df78 100644
>>> --- a/meson.build
>>> +++ b/meson.build
>>> @@ -1203,7 +1203,8 @@ have_vhost_user_gpu = have_tools and host_os == 'linux' and pixman.found()
>>>    if not get_option('virglrenderer').auto() or have_system or have_vhost_user_gpu
>>>      virgl = dependency('virglrenderer',
>>>                         method: 'pkg-config',
>>> -                     required: get_option('virglrenderer'))
>>> +                     required: get_option('virglrenderer'),
>>> +                     default_options: ['default_library=static', 'render-server=true', 'venus=true'])
>>
>> meson_options.txt of virglrenderer says:
>>> DEPRECATED: render server is enabled by venus automatically
>>
>> I'm also a bit concerned to enable Venus by default when the upstream
>> virglrenderer doesn't. Why is it disabled by the upstream? Perhaps is
>> it time for upstream to enable it by default?
>>
>>>    endif
>>>    rutabaga = not_found
>>>    if not get_option('rutabaga_gfx').auto() or have_system or have_vhost_user_gpu
>>> @@ -2314,6 +2315,10 @@ if virgl.version().version_compare('>=1.0.0')
>>>      config_host_data.set('HAVE_VIRGL_RESOURCE_BLOB', 1)
>>>      config_host_data.set('HAVE_VIRGL_VENUS', 1)
>>>    endif
>>> +if virgl.type_name().contains('internal')
>>> +  config_host_data.set('HAVE_BUNDLED_VIRGL_SERVER', 1)
>>> +endif
>>> +
>>>    config_host_data.set('CONFIG_VIRTFS', have_virtfs)
>>>    config_host_data.set('CONFIG_VTE', vte.found())
>>>    config_host_data.set('CONFIG_XKBCOMMON', xkbcommon.found())
>>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
>>> index c9d20a8a60..53d6742e79 100644
>>> --- a/hw/display/virtio-gpu-virgl.c
>>> +++ b/hw/display/virtio-gpu-virgl.c
>>> @@ -14,6 +14,7 @@
>>>    #include "qemu/osdep.h"
>>>    #include "qemu/error-report.h"
>>>    #include "qemu/iov.h"
>>> +#include "qemu/cutils.h"
>>>    #include "trace.h"
>>>    #include "hw/virtio/virtio.h"
>>>    #include "hw/virtio/virtio-gpu.h"
>>> @@ -1122,6 +1123,26 @@ void virtio_gpu_virgl_reset(VirtIOGPU *g)
>>>        virgl_renderer_reset();
>>>    }
>>>    +/*
>>> + * If we fail to spawn the render server things tend to hang so it is
>>> + * important to do our due diligence before then. If QEMU has bundled
>>> + * the virgl server we want to ensure we can run it from the build
>>> + * directory and if installed.
>>
>> This comment sounds a bit misleading. The following code does not
>> ensure the render server exists; it just opportunistically sets the
>> path to the bundled render server or let it fail otherwise.
>>
>> It also sounds like virgl_set_render_env() does an extra step to
>> prevent hangs, but it is actually mandatory for relocated scenarios;
>> the lack of render server always results in a non-functional Venus
>> setup even if the hang is fixed.
>>
>> The hang is better to be noted in subprojects/virglrenderer.wrap since
>> that is the reason we would want to wrap the project.
>>
>>> + *
>>> + * The principle way we can override the libvirglrenders behaviour is
>>> + * by setting environment variables.
>>> + */
>>> +static void virgl_set_render_env(void)
>>> +{
>>> +#ifdef HAVE_BUNDLED_VIRGL_SERVER
>>> +    g_autofree char *file = get_relocated_path(CONFIG_QEMU_HELPERDIR "/virgl_render_server");
>>> +    if (g_file_test(file, G_FILE_TEST_EXISTS | G_FILE_TEST_IS_EXECUTABLE)) {
>>
>> I think this g_file_test() should be removed; we would not want to let
>> virglrenderer pick a random render server when the bundled server
>> exists since the ABI between them can be different in theory.
> 
> I was thinking mainly of validating it was built, maybe that should be
> an assert instead because if we failed to build the server we got the
> bundling wrong?

virglrenderer should emit errors and refuse to function in such a case 
so we don't have to do that ourselves.

