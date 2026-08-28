Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BC0C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzy2d-0008MT-8g; Fri, 28 Aug 2026 10:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1wzy2c-0008ML-8D
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 10:58:50 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1wzy2a-0006Tv-3G
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 10:58:49 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2d72ae08fa1so9673335ad.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 07:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787929127; x=1788533927; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aqb3fMBXrIR0S+P5mYA2YVaFPwG9I/Y8omJQFESd5y8=;
 b=l4GS3HedS+i07HISVzbDqkGePXM1k2ha8D9uDZj9UQfGqM4pJbc2ojNd23mY0tJNHo
 +8k78hOkAJFtdea0RgiRU2N3xT+fRewMq+3pyr5jhr/yWBUzjEYDezs7525lhJYR39FA
 n+xP6i4wupDXB1j8KmhUbBew442xm2RRT5wCOE0tcvf4JH/e3EYDE+dViqW5YW5Iveyg
 Gtj02nlN9eNtUWT7VMsHUWbaUHUSQXg49H++ooWG03KwvcwmU3MOD3hEliYGym9ZSNfB
 is688/RhKkoRUCWIjHgxYXNIhuYrRkjcUVGaDyUEJc1/FVTRNH0BUMnvkx2GyZo753x+
 kO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787929127; x=1788533927;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aqb3fMBXrIR0S+P5mYA2YVaFPwG9I/Y8omJQFESd5y8=;
 b=gkRaz20b//gPqj1SVr9nGIZrwxmxHMsMMAqL5AEJ/JzHQ2YnnclxdCaZzNck3+NcYy
 d97hOGBWIn8BTwK+sZJq8U54XCGCdlbWahSl4XDwdJ3qWL1v3PRkru8a5uDesEpb95qW
 kdYHvwYRQ1HL4V4f9Ng1CxVX1uTWfnxo9FrIafxxZl9ToPSMq4Dw5LobUyRWuR+jXxg6
 mLGNgaZadw5KPPi6UCdUnFjNuPHXPRVyoCovLc4Rjz4bouY0Y16PAFw4EqMGjXGHC9tq
 W7Rhl2KLp19eKfYf/8vqNnO7NMYrlwpA7oI3XLaWKRSbDLqHAEQsSRHCkpcqdmtPl5vW
 ZW4g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqJXWZ9n9N3bcPGgWKlnBtBdVAY661Tq6TeZXnzjj3k56S/C0qLRwx6uVPWBc2zPOJi7g89LTEuCnYZ@nongnu.org
X-Gm-Message-State: AFuF++k/l4Sz0G1NeA2oE7kItHKsZi9uh/kGBDqFTOaYvuLkFnuof8Cf
 mZMrXiVxjQ6ULqLRK3XafSpKB+s6Lxz09j4YPeWWseBiSoxwcn0MXg7n
X-Gm-Gg: AR+sD12LXpSYxUUdfsWii+pqt5476rh3f38tgp2gmTz83PIi7uIkz5cYY1EHwaTeTjt
 /xgniDpWkLkhy5o98ASqvpfpUYmdE2P6J+IyNNCVBqeKwaiDISBvYD6oyHrBa5WhnH4+tbGFGRc
 mgodKSahcw33Hn0T8QkXhyojXGhUs1jkk5MeTaMjl7Dpy2MjBH3OavgnZWz90QhAdJLuZdgC+A5
 aLjKekd1vSV2HvQB5NCG0Qja3KOfCxYRzIKeFOzjuad6/fPlHmig5HPVxf41Egc8mI+MgO0FAEI
 yQ5jpUm9BfAMd9cWO+fXMsLfUDUdnXOENusBH4HE43V+OU2dAmNQQvEZQrOEiwBR9p3bckMcZ8u
 VjPFj3SBuAIFBINBdhug+JYxlH3WDS7qd2lzd215ajyL9CLuFChNkYCurtIlVilvQQizs4SSdEw
 zb/xma1vMABkrM0AgALPgVgG19Evdd4e1cXRTClTdpg3VuotaMHCTDVa5ZB1ZQJludpUAUIk8ez
 LeeTAZqJmvLuE+zO2rQIn+x8rU=
X-Received: by 2002:a17:902:d4c2:b0:2d5:2f49:b3f4 with SMTP id
 d9443c01a7336-2d74dc1cd80mr139161715ad.2.1787929126337; 
 Fri, 28 Aug 2026 07:58:46 -0700 (PDT)
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp. [133.11.54.183])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d75988ac7asm5924635ad.57.2026.08.28.07.58.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 07:58:45 -0700 (PDT)
Message-ID: <99b9ddfc-ba10-43a6-b601-d82fc618b91f@gmail.com>
Date: Fri, 28 Aug 2026 23:58:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/display/virtio-gpu: introduce
 virtio_gpu_{simple,virgl}_resource_new()
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com, berrange@redhat.com
References: <20260828075308.3882813-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <20260828075308.3882813-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pl1-x62f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026/08/28 16:53, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> All allocation sites used g_new0() which zero-initializes fields.
> However share_handle must be SHAREABLE_NONE (-1 on Unix, NULL on
> Windows) and dmabuf_fd must be -1, not 0. Centralize allocation and
> field initialization in new constructors fix this and reduce code
> duplication.
> 
> This fixes -display dbus with virtio-gpu blob resources. The other
> end is currently receiving qemu fd 0.

The bug was introduced by 5f899c34af1d (“virtio-gpu: allocate
shareable 2d resources on !win32”). Please add the corresponding Fixes: 
tag, as required by: docs/devel/submitting-a-patch.rst

> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   v2: add virgl_gpu_virgl_resource_new()

I think you meant virtio_gpu_virgl_resource_new().

> ---
>   hw/display/virtio-gpu-rutabaga.c | 20 +++++-------------
>   hw/display/virtio-gpu-virgl.c    | 34 ++++++++++++++++++-------------
>   hw/display/virtio-gpu.c          | 35 +++++++++++++++++++++-----------
>   include/hw/virtio/virtio-gpu.h   |  4 ++++
>   4 files changed, 52 insertions(+), 41 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
> index 041216a10d04..234fe94b178b 100644
> --- a/hw/display/virtio-gpu-rutabaga.c
> +++ b/hw/display/virtio-gpu-rutabaga.c
> @@ -100,12 +100,8 @@ rutabaga_cmd_create_resource_2d(VirtIOGPU *g,
>       result = rutabaga_resource_create_3d(vr->rutabaga, c2d.resource_id, &rc_3d);
>       CHECK(!result, cmd);
>   
> -    res = g_new0(struct virtio_gpu_simple_resource, 1);
> -    res->width = c2d.width;
> -    res->height = c2d.height;
> -    res->format = c2d.format;
> -    res->resource_id = c2d.resource_id;
> -
> +    res = virtio_gpu_simple_resource_new(c2d.resource_id, c2d.width,
> +                                         c2d.height, c2d.format);
>       QTAILQ_INSERT_HEAD(&g->reslist, res, next);
>   }
>   
> @@ -139,12 +135,8 @@ rutabaga_cmd_create_resource_3d(VirtIOGPU *g,
>       result = rutabaga_resource_create_3d(vr->rutabaga, c3d.resource_id, &rc_3d);
>       CHECK(!result, cmd);
>   
> -    res = g_new0(struct virtio_gpu_simple_resource, 1);
> -    res->width = c3d.width;
> -    res->height = c3d.height;
> -    res->format = c3d.format;
> -    res->resource_id = c3d.resource_id;
> -
> +    res = virtio_gpu_simple_resource_new(c3d.resource_id, c3d.width,
> +                                         c3d.height, c3d.format);
>       QTAILQ_INSERT_HEAD(&g->reslist, res, next);
>   }
>   
> @@ -634,9 +626,7 @@ rutabaga_cmd_resource_create_blob(VirtIOGPU *g,
>   
>       CHECK(cblob.resource_id != 0, cmd);
>   
> -    res = g_new0(struct virtio_gpu_simple_resource, 1);
> -
> -    res->resource_id = cblob.resource_id;
> +    res = virtio_gpu_simple_resource_new(cblob.resource_id, 0, 0, 0);
>       res->blob_size = cblob.size;
>   
>       if (cblob.blob_mem != VIRTIO_GPU_BLOB_MEM_HOST3D) {
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 9bda572426b2..d32801c3893a 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -309,6 +309,23 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
>   }
>   #endif
>   
> +static struct virtio_gpu_virgl_resource *
> +virtio_gpu_virgl_resource_new(uint32_t resource_id, uint32_t width,
> +                              uint32_t height, uint32_t format)
> +{
> +    struct virtio_gpu_virgl_resource *res = g_new0(struct virtio_gpu_virgl_resource, 1);
> +
> +    res->base.share_handle = SHAREABLE_NONE;
> +    res->base.dmabuf_fd = -1;
> +
> +    res->base.resource_id = resource_id;
> +    res->base.width = width;
> +    res->base.height = height;
> +    res->base.format = format;

I think it's better to omit the width, height, and format assignments.

They only matter for non-blob resources, so they do not fit well in the 
common function. blob_size, which is only valid for blob resources, is 
also assigned outside this function, so we can make them consistent.

Having four integer parameters is also slightly confusing. Reducing the 
number of parameters may make sense in this regard too.

With the four assignments removed, this and 
virtio_gpu_simple_resource_new() will become quite small, so I'm not 
sure if we should have virtio_gpu_simple_resource_init() or something 
similar to share the remaining assignments; I'm kind of netural in that 
aspect.

> +
> +    return res;
> +}
> +
>   static void virgl_cmd_create_resource_2d(VirtIOGPU *g,
>                                            struct virtio_gpu_ctrl_command *cmd)
>   {
> @@ -335,12 +352,7 @@ static void virgl_cmd_create_resource_2d(VirtIOGPU *g,
>           return;
>       }
>   
> -    res = g_new0(struct virtio_gpu_virgl_resource, 1);
> -    res->base.width = c2d.width;
> -    res->base.height = c2d.height;
> -    res->base.format = c2d.format;
> -    res->base.resource_id = c2d.resource_id;
> -    res->base.dmabuf_fd = -1;
> +    res = virtio_gpu_virgl_resource_new(c2d.resource_id, c2d.width, c2d.height, c2d.format);
>       QTAILQ_INSERT_HEAD(&g->reslist, &res->base, next);
>   
>       args.handle = c2d.resource_id;
> @@ -383,12 +395,7 @@ static void virgl_cmd_create_resource_3d(VirtIOGPU *g,
>           return;
>       }
>   
> -    res = g_new0(struct virtio_gpu_virgl_resource, 1);
> -    res->base.width = c3d.width;
> -    res->base.height = c3d.height;
> -    res->base.format = c3d.format;
> -    res->base.resource_id = c3d.resource_id;
> -    res->base.dmabuf_fd = -1;
> +    res = virtio_gpu_virgl_resource_new(c3d.resource_id, c3d.width, c3d.height, c3d.format);
>       QTAILQ_INSERT_HEAD(&g->reslist, &res->base, next);
>   
>       args.handle = c3d.resource_id;
> @@ -853,8 +860,7 @@ static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
>           return;
>       }
>   
> -    res = g_new0(struct virtio_gpu_virgl_resource, 1);
> -    res->base.resource_id = cblob.resource_id;
> +    res = virtio_gpu_virgl_resource_new(cblob.resource_id, 0, 0, 0);
>       res->base.blob_size = cblob.size;
>       res->base.dmabuf_fd = -1;

This dmabuf_fd assignment is now redundant.

Regards,
Akihiko Odaki

>   
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 55a1c7f80fb8..d5405f0c715f 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -41,6 +41,24 @@ virtio_gpu_find_check_resource(VirtIOGPU *g, uint32_t resource_id,
>   
>   static void virtio_gpu_reset_bh(void *opaque);
>   
> +struct virtio_gpu_simple_resource *
> +virtio_gpu_simple_resource_new(uint32_t resource_id, uint32_t width,
> +                               uint32_t height, uint32_t format)
> +{
> +    struct virtio_gpu_simple_resource *res =
> +        g_new0(struct virtio_gpu_simple_resource, 1);
> +
> +    res->share_handle = SHAREABLE_NONE;
> +    res->dmabuf_fd = -1;
> +
> +    res->resource_id = resource_id;
> +    res->width = width;
> +    res->height = height;
> +    res->format = format;
> +
> +    return res;
> +}
> +
>   void virtio_gpu_update_cursor_data(VirtIOGPU *g,
>                                      struct virtio_gpu_scanout *s,
>                                      uint32_t resource_id)
> @@ -259,12 +277,8 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
>           return;
>       }
>   
> -    res = g_new0(struct virtio_gpu_simple_resource, 1);
> -
> -    res->width = c2d.width;
> -    res->height = c2d.height;
> -    res->format = c2d.format;
> -    res->resource_id = c2d.resource_id;
> +    res = virtio_gpu_simple_resource_new(c2d.resource_id, c2d.width,
> +                                         c2d.height, c2d.format);
>   
>       pformat = virtio_gpu_get_pixman_format(c2d.format);
>       if (!pformat) {
> @@ -345,8 +359,7 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
>           return;
>       }
>   
> -    res = g_new0(struct virtio_gpu_simple_resource, 1);
> -    res->resource_id = cblob.resource_id;
> +    res = virtio_gpu_simple_resource_new(cblob.resource_id, 0, 0, 0);
>       res->blob_size = cblob.size;
>   
>       if (cblob.nr_entries) {
> @@ -1442,8 +1455,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
>               return -EINVAL;
>           }
>   
> -        res = g_new0(struct virtio_gpu_simple_resource, 1);
> -        res->resource_id = resource_id;
> +        res = virtio_gpu_simple_resource_new(resource_id, 0, 0, 0);
>           res->width = qemu_get_be32(f);
>           res->height = qemu_get_be32(f);
>           res->format = qemu_get_be32(f);
> @@ -1555,8 +1567,7 @@ static int virtio_gpu_blob_load(QEMUFile *f, void *opaque, size_t size,
>               return -EINVAL;
>           }
>   
> -        res = g_new0(struct virtio_gpu_simple_resource, 1);
> -        res->resource_id = resource_id;
> +        res = virtio_gpu_simple_resource_new(resource_id, 0, 0, 0);
>           res->blob_size = qemu_get_be32(f);
>           res->iov_cnt = qemu_get_be32(f);
>   
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index 69b5ee2e382f..090719aa0522 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -64,6 +64,10 @@ struct virtio_gpu_simple_resource {
>       QTAILQ_ENTRY(virtio_gpu_simple_resource) next;
>   };
>   
> +struct virtio_gpu_simple_resource *
> +virtio_gpu_simple_resource_new(uint32_t resource_id, uint32_t width,
> +                               uint32_t height, uint32_t format);
> +
>   struct virtio_gpu_framebuffer {
>       pixman_format_code_t format;
>       uint32_t width, height;


