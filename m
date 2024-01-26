Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A38DC47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 15:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTO2f-0004Qw-JX; Fri, 26 Jan 2024 10:22:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rTO2d-0004Nb-Ie
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 10:22:51 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rTO2X-0003s5-6F
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 10:22:51 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33ade380b9fso674362f8f.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 07:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706282561; x=1706887361; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rDOh4Y5UMc3IdZmX4VDDoFn51Oj5Dy07qT4wPSSp1Yw=;
 b=JF3RiJVjxLh1mlUSNejvADTmU3TclPzFdDexsedHY+GtakipM3NjMM9QKTmchl/B3D
 NNk/RdisLVJYITp5nvPh4o6ddzFMQdNEWM81M521cq2+tUkazyJ3QqtuvxMacyFghWQd
 g3mt8nqiklHPjHs8Rk2tbJrllhwDtSRR0OZrOfTeS19Lw8zZSsZYQ6w4/vBB16Afa/dl
 TqixBY0W0vyS1AnI1AIEOdOaUcYNnQZLZ5VO/qQqwYRp9P4YTBGBQ5QX69Ef3HbXTPmT
 Z1aMIgV23Q7gC9RPCicZWBu3xG1wiKWtKPsmOaRauJy/2q3tDzewKXXW3i5ZqTwJMEf+
 svcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706282561; x=1706887361;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rDOh4Y5UMc3IdZmX4VDDoFn51Oj5Dy07qT4wPSSp1Yw=;
 b=HNrxaFWQ9jJsuLaY2QcFxsVaz5LBoo0ZEX3VK+lvgwyh/AgtGfdjv2znmCk/mNsjcm
 04x0bvX5G7MqaumsFBnR48+0MEp3at07x5Q/HuoZtOmSTnW1cVrqs49r2bb98dctsJFf
 6kPGDjJ2w1Rp2c+2nSk+nVNhbuvc1rTpAtmJ36T7Y+oUgBgb1+F3p6DXFtf+8L96luNh
 WzlHPfz4ZxCX2eUEGJuaG+zz32+98qnpv9nRDUK0J7hqQYzrWcLsRsNXK6D7WVa9rTOP
 1jzcr9JGwWePo74fE+v/XPXNyBznNVuktVMAVL2LI5xNF55MHySGtxLqR5n+6sq4nX+n
 g0Aw==
X-Gm-Message-State: AOJu0Ywz6wWx5niRdpjIIkTu1ICfki3PJCTfXncTrzkQMaQMpbq8/k2D
 gMZNDiDB9DB+YhjIMThfIYhravPPC7MwNZjM27AEn9gIX1Kf/j8QnzkDjvt5IaU=
X-Google-Smtp-Source: AGHT+IGGsupsUFdXVZmnL6DzGJ1QLHoewDvX/zUR1ABl8nfD4fTTBIjyDcQPj6RA2Lg4YOCJ6X0wPQ==
X-Received: by 2002:adf:cd84:0:b0:337:62d7:21d2 with SMTP id
 q4-20020adfcd84000000b0033762d721d2mr609440wrj.133.1706282561118; 
 Fri, 26 Jan 2024 07:22:41 -0800 (PST)
Received: from [192.168.69.100] ([176.176.142.39])
 by smtp.gmail.com with ESMTPSA id
 r15-20020adfda4f000000b00337d9a717bcsm1474067wrl.52.2024.01.26.07.22.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 07:22:40 -0800 (PST)
Message-ID: <b99352e9-efd2-42a3-b6de-a87832bb007c@linaro.org>
Date: Fri, 26 Jan 2024 16:22:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] virtio-gpu.c: add resource_destroy class method
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>
References: <cover.1706279540.git.manos.pitsidianakis@linaro.org>
 <c123808b760f4d8d743c4fd4a04e730005ff673e.1706279540.git.manos.pitsidianakis@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c123808b760f4d8d743c4fd4a04e730005ff673e.1706279540.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Manos,

On 26/1/24 15:41, Manos Pitsidianakis wrote:
> When destroying/unrefing resources, devices such as virtio-gpu-rutabaga
> need to do their own bookkeeping (free rutabaga resources that are
> associated with the virtio_gpu_simple_resource).
> 
> This commit adds a class method so that virtio-gpu-rutabaga can override
> it in the next commit.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   hw/display/virtio-gpu.c        | 19 ++++++++++++++++---
>   include/hw/virtio/virtio-gpu.h |  2 ++
>   2 files changed, 18 insertions(+), 3 deletions(-)


>   static void virtio_gpu_resource_unref(VirtIOGPU *g,
> @@ -1488,11 +1491,20 @@ static void virtio_gpu_device_unrealize(DeviceState *qdev)
>   static void virtio_gpu_reset_bh(void *opaque)
>   {
>       VirtIOGPU *g = VIRTIO_GPU(opaque);
> +    VirtIOGPUClass *vgc = VIRTIO_GPU_GET_CLASS(g);
>       struct virtio_gpu_simple_resource *res, *tmp;
> +    int32_t result, resource_id;
>       int i = 0;
>   
>       QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
> -        virtio_gpu_resource_destroy(g, res);
> +        resource_id = res->resource_id;
> +        result = vgc->resource_destroy(g, res);
> +        if (result) {
> +            error_report("%s: %s resource_destroy"
> +                         "for resource_id = %d failed with return value = %d;",

'%d' is for 'int', for 'int32_t' you need 'PRId32'.

But why return that type instead of 'int'?

> +                         __func__, object_get_typename(OBJECT(g)), resource_id,
> +                         result);
> +        }
>       }


> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index 584ba2ed73..5683354236 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -219,6 +219,8 @@ struct VirtIOGPUClass {
>       void (*update_cursor_data)(VirtIOGPU *g,
>                                  struct virtio_gpu_scanout *s,
>                                  uint32_t resource_id);
> +    int32_t (*resource_destroy)(VirtIOGPU *g,
> +                                struct virtio_gpu_simple_resource *res);
>   };
>   
>   struct VirtIOGPUGL {


