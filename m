Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E5DC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 06:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxi6X-0004nE-IY; Fri, 19 Apr 2024 02:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxi6V-0004mq-ME
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 02:52:11 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxi6T-0002nM-KF
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 02:52:11 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-418c2bf2f90so9302295e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 23:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713509527; x=1714114327; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WaMB7jFXehJEyTJjj/VhZjgYYgswnpNtF1chA9msUBI=;
 b=kyTp8b83CSKKUfOPL6X5V1cuu2/BZxh1AUhbB7cFOPgPcQAfLNgWOlf0/7/noUGco6
 9Hy/uOYN/zkWhjN2NslEn+xidhQQnfXdNwjiXN8ZNoNmVAFFDsnwWNlioy3Ogvnuw3ng
 d+W4iCACXi/wT1kQMKF0iGz8khYd26f3VbjG189C3/xchG1c46SaCGVcuxSmNAzBDRyX
 FaQZQi+dAgKCRpaNuq0k4rulbbUJ2LEI+zgNM/dUu1brHEWynmdRxKmq5n6ANwpvtufh
 Nonoz4+8SfHCCy5XEd6EEvzQWuDMVH8qJmET+TvlOY6aAl5NobpInVeDQpdDaSrArNY7
 ItGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713509527; x=1714114327;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WaMB7jFXehJEyTJjj/VhZjgYYgswnpNtF1chA9msUBI=;
 b=uattlJt3hu4MgqMFgSG/507T+DTKZRp8oTJWI1yqhlHU01EhKWfWGcODKKhRKVx+tf
 nQTGsvM5+Z6TgiDM2FKTv+0mL4nXsD8REgg3wHT4Hko+tebj5ZvB6GvUy6pkyauKXhRK
 3zu/GEAl1G4u5PP+KJ2v94xRPCyPpyIvke4HydLpOBWUyPeRQ7x/tVOGBYLP57sigB9B
 q4kGvwG5TXKO/06twdGz6CSSgezpWop3MR74oyewMw4iyltxXUsGX+PP4Tjnht0bcEGL
 CGp9d/fKwDSBDXzYGoD+Y1leKWhkYZWqFK520Vf6CkBrMBDBP0ez/isaGl42WaJmuRUA
 jZpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUr1R9b4wHxU27XMIX5ZcIvdJaEjOix+KIeA+apsi+6+XEK18y6B1zuO6S2ByNu5POaNjBxs43t5sQv/ADTIuE1bas7tWA=
X-Gm-Message-State: AOJu0YwCW2wNFx+bBTijf0bVyRb6kGYygCSeoGvbvQcGA3WqNM9YYhhf
 3OV7Mv1RipPyZrvC0uWTXwH1/CgjNJUvG5Po1hFiajWCPiOkVc5KJAUNz2mBisM=
X-Google-Smtp-Source: AGHT+IFoU5vuN1yH11oSca1h+JVapE5tKPcYQvYzSPGOHMGtTUHUlsrFBbanVbXD3KJ2/IBEwpWMFg==
X-Received: by 2002:a05:600c:5409:b0:418:5ef3:4a04 with SMTP id
 he9-20020a05600c540900b004185ef34a04mr801599wmb.18.1713509527458; 
 Thu, 18 Apr 2024 23:52:07 -0700 (PDT)
Received: from [192.168.235.175] (149.red-88-28-24.dynamicip.rima-tde.net.
 [88.28.24.149]) by smtp.gmail.com with ESMTPSA id
 j13-20020a05600c190d00b00418a386c17bsm9108918wmq.12.2024.04.18.23.52.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 23:52:07 -0700 (PDT)
Message-ID: <101063e8-595b-4bc9-8bf9-4acb418f907b@linaro.org>
Date: Fri, 19 Apr 2024 08:52:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] ui/dmabuf: New dmabuf.c and dmabuf.h for
 QemuDmaBuf struct and helpers
To: dongwon.kim@intel.com, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, berrange@redhat.com
References: <20240418220541.931134-1-dongwon.kim@intel.com>
 <20240418220541.931134-6-dongwon.kim@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240418220541.931134-6-dongwon.kim@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 19/4/24 00:05, dongwon.kim@intel.com wrote:
> From: Dongwon Kim <dongwon.kim@intel.com>
> 
> Create new header and source files to encapsulate QemuDmaBuf struct
> and its data for privatization.
> 
> Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>   include/ui/console.h |  52 +---------
>   include/ui/dmabuf.h  |  38 ++++++++
>   ui/console.c         | 179 +---------------------------------
>   ui/dmabuf.c          | 223 +++++++++++++++++++++++++++++++++++++++++++
>   ui/meson.build       |   1 +
>   5 files changed, 264 insertions(+), 229 deletions(-)
>   create mode 100644 include/ui/dmabuf.h
>   create mode 100644 ui/dmabuf.c


> diff --git a/include/ui/dmabuf.h b/include/ui/dmabuf.h
> new file mode 100644
> index 0000000000..8de33cd1ab
> --- /dev/null
> +++ b/include/ui/dmabuf.h
> @@ -0,0 +1,38 @@

Missing license.

> +#ifndef DMABUF_H
> +#define DMABUF_H
> +
> +typedef struct QemuDmaBuf QemuDmaBuf;
> +
> +QemuDmaBuf *qemu_dmabuf_new(uint32_t width, uint32_t height,
> +                                   uint32_t stride, uint32_t x,
> +                                   uint32_t y, uint32_t backing_width,
> +                                   uint32_t backing_height, uint32_t fourcc,
> +                                   uint64_t modifier, int32_t dmabuf_fd,
> +                                   bool allow_fences, bool y0_top);
> +void qemu_dmabuf_free(QemuDmaBuf *dmabuf);
> +
> +G_DEFINE_AUTOPTR_CLEANUP_FUNC(QemuDmaBuf, qemu_dmabuf_free);
> +
> +int32_t qemu_dmabuf_get_fd(QemuDmaBuf *dmabuf);
> +uint32_t qemu_dmabuf_get_width(QemuDmaBuf *dmabuf);
> +uint32_t qemu_dmabuf_get_height(QemuDmaBuf *dmabuf);
> +uint32_t qemu_dmabuf_get_stride(QemuDmaBuf *dmabuf);
> +uint32_t qemu_dmabuf_get_fourcc(QemuDmaBuf *dmabuf);
> +uint64_t qemu_dmabuf_get_modifier(QemuDmaBuf *dmabuf);
> +uint32_t qemu_dmabuf_get_texture(QemuDmaBuf *dmabuf);
> +uint32_t qemu_dmabuf_get_x(QemuDmaBuf *dmabuf);
> +uint32_t qemu_dmabuf_get_y(QemuDmaBuf *dmabuf);
> +uint32_t qemu_dmabuf_get_backing_width(QemuDmaBuf *dmabuf);
> +uint32_t qemu_dmabuf_get_backing_height(QemuDmaBuf *dmabuf);
> +bool qemu_dmabuf_get_y0_top(QemuDmaBuf *dmabuf);
> +void *qemu_dmabuf_get_sync(QemuDmaBuf *dmabuf);
> +int32_t qemu_dmabuf_get_fence_fd(QemuDmaBuf *dmabuf);
> +bool qemu_dmabuf_get_allow_fences(QemuDmaBuf *dmabuf);
> +bool qemu_dmabuf_get_draw_submitted(QemuDmaBuf *dmabuf);
> +void qemu_dmabuf_set_texture(QemuDmaBuf *dmabuf, uint32_t texture);
> +void qemu_dmabuf_set_fence_fd(QemuDmaBuf *dmabuf, int32_t fence_fd);
> +void qemu_dmabuf_set_sync(QemuDmaBuf *dmabuf, void *sync);
> +void qemu_dmabuf_set_draw_submitted(QemuDmaBuf *dmabuf, bool draw_submitted);
> +void qemu_dmabuf_set_fd(QemuDmaBuf *dmabuf, int32_t fd);
> +
> +#endif


> diff --git a/ui/dmabuf.c b/ui/dmabuf.c
> new file mode 100644
> index 0000000000..a81cc244ac
> --- /dev/null
> +++ b/ui/dmabuf.c
> @@ -0,0 +1,223 @@
> +/*
> + * QEMU DmaBuf
> + *
> + * Copyright (c) 2024 Dongwon Kim <dongwon.kim@intel.com>
> + *

Please consider adding the SPDX tag to ease tooling:

  * SPDX-License-Identifier: MIT

(Optionally removing the boilerplate license)

> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "ui/dmabuf.h"


