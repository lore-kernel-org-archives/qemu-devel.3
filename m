Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB75ECD1299
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 14:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsNe7-00055F-Vm; Thu, 04 Apr 2024 10:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsNe4-0004xf-GQ
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:00:49 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsNe1-000776-CN
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:00:48 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a4a393b699fso169668366b.0
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 07:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712239243; x=1712844043; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J7k8AFdR/LmcldfOzjj73YymViT4V83VKPf3kg+uexw=;
 b=VgmJgUIxrSAOihLj4kG1PQq+wPbgvEprvR5APZiR15y7hJc90fmVQtVeusCA0Lk6Mk
 0LTwJLOC1MaY1V1YqCPClIp/kNcIeb8snpfRqu5YCkkTFM4278U8OadtysRzEzdB++3Z
 VYotIxOGZkFuDqxrjGSKZ9mU+g0ZbQ93Ii9+cs0bNdtqdIHVBvIFQZGqY4A08lwTfWhv
 sPxR1W6KHjrC687q7ZRi03m1/84x7nxYgrwZsgXkptyauQPlWIyx8VsbhgL/kDkE6vMd
 ajXDNvhDJU9WAIfIri62XIn6tUcXUf73EKK/lZNCScaUZUNDPkdctqqBRi1GqWBenB9w
 PA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712239243; x=1712844043;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J7k8AFdR/LmcldfOzjj73YymViT4V83VKPf3kg+uexw=;
 b=AOJVYf1Aen3NNyb4dFTwydHhC0SCrCfFe3jxoIoAQw3XQbeuhgwLSOk/sIE43rt7R7
 embSEiuxB0kD8PJuGldYmtzNTud4LzZVVydIb5pFA6qARuEim3UMj3iZMjN8w4ExH8Ey
 TI6KP+QNRYYAmU6p2Ma+9/NWaGqPddX/M8x8Xsmdlhkp11JZReXB4b+VtWK2DTreRCbs
 S3f5xgrSYFZFS0CpUUkAKiMFq17oxQSJQRbB1q+yM/VDqtc+AwDuUz8Ygd1tvrfxoMBq
 aDVqs4mnlQ7VWKcsUE2IDHGbjuyy9XVidcSJwwfU7/znUffMoqWvxSW9jTe1dbHDvPQc
 QFGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVO6pUL2KVP4l33TwdtAjt2fBMVjPHFa9pRO83MYWqS4SSrN8HDXKcG9e91tM1pBUQe8f+ay3ezCO+Mb4dLYhdOF/EVsE=
X-Gm-Message-State: AOJu0Yw02eYCPV2xEvKvrFaPyLytisQHc1OfsAonZ0h7oNgVmOMRapNQ
 jeqhj+0Ve5znjQusA5t5JwB7AdD3GQNVTDG8/Gf7Cc8j/GGeh8p5B9694n6gbpg=
X-Google-Smtp-Source: AGHT+IGZqhuvGd5i4Klj5vabjFltjf8lBUdc8iJFfS/QrcN+gEERg0ahhe9Qqr87YvnWILtaNmzlhQ==
X-Received: by 2002:a17:906:5a8c:b0:a51:931a:f82c with SMTP id
 l12-20020a1709065a8c00b00a51931af82cmr858358ejq.32.1712239242633; 
 Thu, 04 Apr 2024 07:00:42 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.216.111])
 by smtp.gmail.com with ESMTPSA id
 gc9-20020a170906c8c900b00a4e440989f5sm7091977ejb.159.2024.04.04.07.00.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Apr 2024 07:00:41 -0700 (PDT)
Message-ID: <84c9d3f2-9aab-4dd6-b6f8-223acf6364fb@linaro.org>
Date: Thu, 4 Apr 2024 16:00:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 v3 08/11] contrib/vhost-user-blk: enable it on any
 POSIX system
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: Coiby Xu <Coiby.Xu@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, slp@redhat.com, Eduardo Habkost
 <eduardo@habkost.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 Brad Smith <brad@comstyle.com>, stefanha@redhat.com,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, gmaglione@redhat.com,
 Jason Wang <jasowang@redhat.com>
References: <20240404122330.92710-1-sgarzare@redhat.com>
 <20240404122330.92710-9-sgarzare@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240404122330.92710-9-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

Hi Stefano,

On 4/4/24 14:23, Stefano Garzarella wrote:
> Let's make the code more portable by using the "qemu/bswap.h" API
> and adding defines from block/file-posix.c to support O_DIRECT in
> other systems (e.g. macOS).
> 
> vhost-user-server.c is a dependency, let's enable it for any POSIX
> system.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   meson.build                             |  2 --
>   contrib/vhost-user-blk/vhost-user-blk.c | 19 +++++++++++++++++--
>   util/meson.build                        |  4 +++-
>   3 files changed, 20 insertions(+), 5 deletions(-)


> diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
> index a8ab9269a2..462e584857 100644
> --- a/contrib/vhost-user-blk/vhost-user-blk.c
> +++ b/contrib/vhost-user-blk/vhost-user-blk.c
> @@ -16,6 +16,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/bswap.h"
>   #include "standard-headers/linux/virtio_blk.h"
>   #include "libvhost-user-glib.h"


> @@ -267,13 +282,13 @@ static int vub_virtio_process_req(VubDev *vdev_blk,
>       req->in = (struct virtio_blk_inhdr *)elem->in_sg[in_num - 1].iov_base;
>       in_num--;
>   
> -    type = le32toh(req->out->type);
> +    type = le32_to_cpu(req->out->type);
>       switch (type & ~VIRTIO_BLK_T_BARRIER) {
>       case VIRTIO_BLK_T_IN:
>       case VIRTIO_BLK_T_OUT: {
>           ssize_t ret = 0;
>           bool is_write = type & VIRTIO_BLK_T_OUT;
> -        req->sector_num = le64toh(req->out->sector);
> +        req->sector_num = le64_to_cpu(req->out->sector);
>           if (is_write) {
>               ret  = vub_writev(req, &elem->out_sg[1], out_num);
>           } else {
Can we switch to the bswap API in a preliminary patch,
converting all the source files?

