Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5892BC3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 16:31:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDQcQ-0005sb-EG; Fri, 09 May 2025 12:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangxueqian@gmail.com>)
 id 1uDQcL-0005s8-Vb
 for qemu-devel@nongnu.org; Fri, 09 May 2025 12:30:34 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jiangxueqian@gmail.com>)
 id 1uDQcJ-0007y8-RQ
 for qemu-devel@nongnu.org; Fri, 09 May 2025 12:30:33 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-30828fc17adso2377654a91.1
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 09:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746808230; x=1747413030; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jfq80ZQtlerh3tsfBXzzSab1yGg9ZH7g5AReSzq5Vek=;
 b=mT4PGQQAEYgUwaeaJnQfMqASmyL9geqsp2oN80DKu4bGaISLRxh+CkCrJqLFpJ7k8n
 VHRlR+43ZqyAEO6EYmY/hpd42UnZTfdRVwbafcUGGFg9yNspXH8qpN5HbMnhtQBq/1Pb
 23mFoc8LfuA7tNqHTn5GefmdTjIBHVDG8AY+bTPtOP/f34y1VrLK4COlj837jPgOrodr
 ZGsccIvPuBqq+X7AdO+n/BKDQnoZL9S21f8J3SDA3XsYh5huFFmgTlTJThKKaphILP9F
 CMttG6+aCf70gYerZuHKwC+pal6cDFFjbXjgErUERKqKFa0rjqgduAhN+k/hqd5qfKee
 CD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746808230; x=1747413030;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jfq80ZQtlerh3tsfBXzzSab1yGg9ZH7g5AReSzq5Vek=;
 b=PdF5zUr2OKWvYi6XaWFVlTca40N5ISUCJkv4Q2h7KzYQW08YRu/Ivzo+Cy8/vDcE/S
 xh9UGQpbZ3xn3p5ZvYU+1bGHY8+vsRTsHoBA9wmXfgH3LuBTgK6bzYE7UrmLJsuhm6/Y
 M/Nh2g5UJ0uBMjIxXiObKWKUV4a2+F3qHnz7RdIIfYUr6JbSbjIGceqPuQlbmO7dZEvZ
 jg5MIb6pT+jjGzSaLdRj8L/1Sf16U/8d8NcDKU5kTxHO2GxYvQQWHBgI2RILSBGlnSBj
 E7a4rHVvd5K3yfBgSG+JYqq39r89zzCq3OawmwvL3cAUWBDYyVlJhvaVdQhZ0ICNgFYG
 Y/Ng==
X-Gm-Message-State: AOJu0Yx+qqD7VdnZbIAIBn5IUNb5YTjae60QpFKtOIMrTVbrbgtsgZrj
 /gzs0+9Iw5hq31+Yk1FtIM8u+VqMwYSTDfuZFXYmz8Oxmlap4ttSQRyeX41OzGs=
X-Gm-Gg: ASbGncuwENSUIrXZG8Kw5mVOftOdurbsKvCOfgIjwTNTgqN0MnutIUqiMWV5n1ebsUS
 NVK2k/fVjD53ggQnjutx5uzN5cnJkcIrisiHpEMN1X+JP0HJcA6aILqpqq2gtxWenOLQwx8P50g
 9gRCZeSg9niAw8QqHyM8UzJEZ2nonC5xxKdxnctTxAbqGSEZHMF+uWDO5agn5CuqHuVPKqbs2rI
 Sd80JFB3885ORVhBXcHbRuG16kKXaRIg983jCtkGq+RE0jcf22b6GGR4ElYwlPq3HHo1TS3bKQn
 5SRUSZ4MDkNWOF9IEThvIOf1Fu3xLt8isluSQrZf8hrLGuMQY0+LiWvIRGc=
X-Google-Smtp-Source: AGHT+IFYcV9tT1TnoovNXspCxHLjuzOgGa95+tQRQCWoZEfD/7npfWCz0SEmGXnop6lNzhkU9lp06w==
X-Received: by 2002:a17:90b:3d82:b0:2ee:f80c:6889 with SMTP id
 98e67ed59e1d1-30c3d661528mr8046136a91.33.1746808229495; 
 Fri, 09 May 2025 09:30:29 -0700 (PDT)
Received: from [192.168.11.20] ([74.48.121.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30ad4ffb4a0sm4266707a91.46.2025.05.09.09.30.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 09:30:29 -0700 (PDT)
Message-ID: <093aee8f-030d-472e-865c-bf2f20eae87c@gmail.com>
Date: Sat, 10 May 2025 00:30:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-gpu-gl: Add 'serverfd' property
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
References: <20250403155129.3396821-1-jiangxueqian@gmail.com>
 <87tt5vmhx9.fsf@draig.linaro.org>
Content-Language: en-US
From: Jiang XueQian <jiangxueqian@gmail.com>
In-Reply-To: <87tt5vmhx9.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=jiangxueqian@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



On 5/8/25 8:00 PM, Alex Bennée wrote:
> Jiang XueQian <jiangxueqian@gmail.com> writes:
> 
>> This property passes socket of a externally started virgl_render_server
>> to virglrenderer, so that it won't try to spawn new process and get
>> killed by seccomp, allowing virtio-gpu-gl venus and sandbox to enable
>> at the same time.
> 
> Do we have an example of how to start such a virgl server?
> docs/syste,/devices/virtio-gpu.rst could be expanded with some example
> invocations of the various modes.
> 

virgl_render_server can be started like `path/to/virgl_render_server 
--socket-fd <seqpacket-socketpair-fd>`.

It is spawned by virgl_render_init function without this patch, so I 
used that 
(https://gitlab.freedesktop.org/virgl/virglrenderer/-/blob/1.1.1/src/proxy/proxy_server.c?ref_type=tags#L73) 
as a reference during development.

Thank you for the advice. I'll add some examples and docs.

>>
>> Signed-off-by: Jiang XueQian <jiangxueqian@gmail.com>
>> ---
>>   hw/display/virtio-gpu-gl.c     | 15 +++++++++++++++
>>   hw/display/virtio-gpu-virgl.c  | 17 +++++++++++++++++
>>   include/hw/virtio/virtio-gpu.h |  2 ++
>>   3 files changed, 34 insertions(+)
>>
>> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
>> index 683fad3bf8..e7c89f7c29 100644
>> --- a/hw/display/virtio-gpu-gl.c
>> +++ b/hw/display/virtio-gpu-gl.c
>> @@ -22,6 +22,7 @@
>>   #include "hw/virtio/virtio-gpu-bswap.h"
>>   #include "hw/virtio/virtio-gpu-pixman.h"
>>   #include "hw/qdev-properties.h"
>> +#include "monitor/monitor.h"
>>   
>>   #include <virglrenderer.h>
>>   
>> @@ -143,6 +144,17 @@ static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
>>           return;
>>       }
>>   
>> +#if VIRGL_RENDERER_CALLBACKS_VERSION >= 3
>> +    if (g->parent_obj.conf.serverfd) {
>> +        g->parent_obj.conf.serverfd_parsed =
>> +            monitor_fd_param(monitor_cur(),
>> g->parent_obj.conf.serverfd, errp);
> 
> I think the right place to validate we have a valid serverfd is in a
> property setter function.
> 

I see your point, but I prefer to keep it simple.

Using both variables is confusing and worth improving. This code is not 
only used to validate serverfd.

Here monitor_fd_param find the fd by its symbolic name or by parsing 
digits, and take ownership of it. The fd is stored and later pass to 
virglrenderer.

After this, .serverfd is only used as a boolean, indicating whether 
.serverfd_parsed is valid.

Many devices accept fd but most of them do so by accepting a chardev, 
which is not suitable in this case. Only a few devices accept fd 
directly, I found vhost-scsi and vhost-vsock, and they are using 
monitor_fd_param. I believe abstracting it further is unnecessary.

>> +        if (g->parent_obj.conf.serverfd_parsed < 0) {
>> +            error_prepend(errp, "unable to parse serverfd: ");
>> +            return;
>> +        }
>> +    }
>> +#endif
>> +
>>       g->parent_obj.conf.flags |= (1 << VIRTIO_GPU_FLAG_VIRGL_ENABLED);
>>       g->capset_ids = virtio_gpu_virgl_get_capsets(g);
>>       VIRTIO_GPU_BASE(g)->virtio_config.num_capsets = g->capset_ids->len;
>> @@ -159,6 +171,9 @@ static const Property virtio_gpu_gl_properties[] = {
>>                       VIRTIO_GPU_FLAG_STATS_ENABLED, false),
>>       DEFINE_PROP_BIT("venus", VirtIOGPU, parent_obj.conf.flags,
>>                       VIRTIO_GPU_FLAG_VENUS_ENABLED, false),
>> +#if VIRGL_RENDERER_CALLBACKS_VERSION >= 3
>> +    DEFINE_PROP_STRING("serverfd", VirtIOGPU,
>> parent_obj.conf.serverfd),
> 
> Use DEFINE_PROP with a PropertyInfo structure.
> 
>> +#endif
>>   };
>>   
>>   static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
>> index 145a0b3879..420aae3b05 100644
>> --- a/hw/display/virtio-gpu-virgl.c
>> +++ b/hw/display/virtio-gpu-virgl.c
>> @@ -1030,6 +1030,19 @@ static int virgl_make_context_current(void *opaque, int scanout_idx,
>>                                      qctx);
>>   }
>>   
>> +#if VIRGL_RENDERER_CALLBACKS_VERSION >= 3
>> +static int virgl_get_server_fd(void *opaque, uint32_t version)
>> +{
>> +    VirtIOGPU *g = opaque;
>> +
>> +    if (g->parent_obj.conf.serverfd) {
>> +        return g->parent_obj.conf.serverfd_parsed;
>> +    }
>> +
>> +    return -1;
>> +}
>> +#endif
>> +
>>   static struct virgl_renderer_callbacks virtio_gpu_3d_cbs = {
>>       .version             = 1,
>>       .write_fence         = virgl_write_fence,
>> @@ -1097,6 +1110,10 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>>       uint32_t flags = 0;
>>       VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
>>   
>> +#if VIRGL_RENDERER_CALLBACKS_VERSION >= 3
>> +    virtio_gpu_3d_cbs.version = 3;
>> +    virtio_gpu_3d_cbs.get_server_fd = virgl_get_server_fd;
>> +#endif
>>   #if VIRGL_RENDERER_CALLBACKS_VERSION >= 4
>>       if (qemu_egl_display) {
>>           virtio_gpu_3d_cbs.version = 4;
>> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
>> index a42957c4e2..40a81f500c 100644
>> --- a/include/hw/virtio/virtio-gpu.h
>> +++ b/include/hw/virtio/virtio-gpu.h
>> @@ -128,6 +128,8 @@ struct virtio_gpu_base_conf {
>>       uint32_t xres;
>>       uint32_t yres;
>>       uint64_t hostmem;
>> +    char *serverfd;
>> +    int serverfd_parsed;
> 
> And we can drop char serverfd and have an explicit place for the fd. Is
> 0 a valid fd or do we need a initialise to -1?
> 

I'll improve this by always giving .serverfd_parsed a value, so that 
later code don't have to check .serverfd.

>>   };
>>   
>>   struct virtio_gpu_ctrl_command {
> 

