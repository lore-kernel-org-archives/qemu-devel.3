Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB06C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjwd-0001jB-KQ; Tue, 02 Jul 2024 16:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOjvj-000758-Gv
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:16:50 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOjvZ-0008IK-Ud
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:16:47 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2ec408c6d94so47112901fa.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719951396; x=1720556196; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1ZNQWxchbYqRE/ztI0Efzhv51Qe7ss4Fe5+9hHsNJe0=;
 b=CU3xthDXWcb+aKzV0IjRdbXuq4cC4K7ElBPTQ0Gl/WWmpMVmDBT4x+gJlgYwWxXW7G
 zWvm8/4lzDDBmwvbrTWflSAD1obR42oZjrzXn704BdnSPq4r+UHONT9OAdNQNtwlOeO1
 3ZHAoe/osn2fQQiOkIOUsRKzLfr/OSshGsPyFH1+RRdAQQWlNs9GxCEzEOWKPC1GnhBQ
 9DmEYXGsGSKeOqcdNbE8yfz2tJoLv+2irEanim0I3U2GkpwEA6QqpH7XTEn2TUf5vcNz
 gCRA12LDq6XsbAWJ1oEKJcrJSo0B9DbbN+QJB8fNGupG+8v9rd+ulGBlqt/0kEyuZAj+
 6aUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951396; x=1720556196;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1ZNQWxchbYqRE/ztI0Efzhv51Qe7ss4Fe5+9hHsNJe0=;
 b=rFo2xq08nxteqHqNkWBSD7lL7y9cfegGrbb3AKLELhrbH8QIxxL2Zl315htdJ6o6o0
 +OPSzRYsrcW5rniPsC4M4CsstuPli1OgnDDoDR3xYJ6RuIZDrPw9ZRLFnRxBMuCES0c0
 XmfL1PpUJk8+tlmxRsP8eWx94ecf9Mr5RCOTfpRVN7+MZxHeTLk8ypRaERiWYCwryVfk
 VvuWC6RK4AjLXrQHOe5akwRfprIRAwoccFGZDgmHhmHyjGIzhRmFXSuiEmyx0mkeJrkV
 dkrXYkcQ1AFZtbUbC0L5LnnYwMOGefzqWZHyXoOuBsUK/xznsmHW3MIl7Xxj0ZpEqsMX
 jhtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWv7gzK7Pp8c4udxxGaWg322gC33lkWRTOTNHe/rb1gp0RZ1ODtYQ5sxOzpSN0u6wKkPzxE0r6AXB1zcwS2R14mS6rQbQ=
X-Gm-Message-State: AOJu0Yz+7hdtfr4NDcUpwMCL1ATaOXUIqyx422+f82MBl4xBvJ4a4f6R
 2QkCHrYWdJOKBJuL/KWvo9E4etJ6KapiG1oMPrjjklBJUDV1Tn82/L9GvQo9fZ6n/rBcXB54X9m
 Z
X-Google-Smtp-Source: AGHT+IGMX6MnZLCe/1fW+tugyANw9Un86MNPq2sjgTHmfF/LiOiIPxPiJlGxbHVST/re+GRx3NFbYg==
X-Received: by 2002:a05:651c:2115:b0:2eb:fc08:5d83 with SMTP id
 38308e7fff4ca-2ee5e704790mr73455611fa.44.1719951395485; 
 Tue, 02 Jul 2024 13:16:35 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af3c25esm210533775e9.9.2024.07.02.13.16.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 13:16:35 -0700 (PDT)
Message-ID: <b2866a26-7119-4906-8228-b02698838b23@linaro.org>
Date: Tue, 2 Jul 2024 22:16:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio: Implement Virtio Backend for SD/MMC in QEMU
To: Mikhail Krasheninnikov <krashmisha@gmail.com>, qemu-devel@nongnu.org
Cc: Matwey Kornilov <matwey.kornilov@gmail.com>, qemu-block@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20240702185842.31061-1-krashmisha@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240702185842.31061-1-krashmisha@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
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

Hi Mikhail,

(mostly style comments)

On 2/7/24 20:58, Mikhail Krasheninnikov wrote:
> From: Mi <krashmisha@gmail.com>
> 
> Add a Virtio backend for SD/MMC devices. Confirmed interoperability with
> Linux.
> 
> Signed-off-by: Mikhail Krasheninnikov <krashmisha@gmail.com>
> CC: Matwey Kornilov <matwey.kornilov@gmail.com>
> CC: qemu-block@nongnu.org
> CC: Michael S. Tsirkin <mst@redhat.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> 
> After a feedback, moved virtio.c from virtio core directory to hw/block.
>  From what I see from the examples of virtio drivers, other files should
> be where they are now. Correct me if I'm wrong.

Alternative is hw/sd/.

> 
>   hw/block/Kconfig                            |   5 +
>   hw/block/meson.build                        |   1 +
>   hw/block/virtio-mmc.c                       | 165 ++++++++++++++++++++

virtio-sdhci.c could be a better name.

>   hw/virtio/meson.build                       |   1 +
>   hw/virtio/virtio-mmc-pci.c                  |  85 ++++++++++
>   hw/virtio/virtio.c                          |   3 +-
>   include/hw/virtio/virtio-mmc.h              |  20 +++
>   include/standard-headers/linux/virtio_ids.h |   1 +
>   8 files changed, 280 insertions(+), 1 deletion(-)
>   create mode 100644 hw/block/virtio-mmc.c
>   create mode 100644 hw/virtio/virtio-mmc-pci.c
>   create mode 100644 include/hw/virtio/virtio-mmc.h
> 
> diff --git a/hw/block/Kconfig b/hw/block/Kconfig
> index 9e8f28f982..a3059261fa 100644
> --- a/hw/block/Kconfig
> +++ b/hw/block/Kconfig
> @@ -44,3 +44,8 @@ config VHOST_USER_BLK
>   
>   config SWIM
>       bool
> +
> +config VIRTIO_MMC

(config VIRTIO_SDHCI?)

> +    bool
> +    default y

for SDBus API:

        select SD

> +    depends on VIRTIO

[...]

> diff --git a/hw/block/virtio-mmc.c b/hw/block/virtio-mmc.c
> new file mode 100644
> index 0000000000..50bd7113c5
> --- /dev/null
> +++ b/hw/block/virtio-mmc.c
> @@ -0,0 +1,165 @@
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +
> +#include "hw/virtio/virtio.h"
> +#include "hw/virtio/virtio-mmc.h"
> +#include "qemu/typedefs.h"
> +#include "sysemu/blockdev.h"
> +
> +typedef struct mmc_req {
> +    uint32_t opcode;
> +    uint32_t arg;
> +} mmc_req;
> +
> +typedef struct virtio_mmc_req {
> +    uint8_t flags;
> +
> +#define VIRTIO_MMC_REQUEST_DATA BIT(1)
> +#define VIRTIO_MMC_REQUEST_WRITE BIT(2)
> +#define VIRTIO_MMC_REQUEST_STOP BIT(3)
> +#define VIRTIO_MMC_REQUEST_SBC BIT(4)
> +
> +    mmc_req request;
> +
> +    uint8_t buf[4096];
> +    size_t buf_len;
> +
> +    mmc_req stop_req;
> +    mmc_req sbc_req;
> +} virtio_mmc_req;
> +
> +typedef struct virtio_mmc_resp {
> +    uint32_t response[4];
> +    int resp_len;
> +    uint8_t buf[4096];
> +} virtio_mmc_resp;
> +
> +static void send_command(SDBus *sdbus, mmc_req *mmc_request, uint8_t *response,
> +                         virtio_mmc_resp *virtio_resp)
> +{
> +    SDRequest sdreq;

QEMU style declares variables in function prologue.

> +    sdreq.cmd = (uint8_t)mmc_request->opcode;
> +    sdreq.arg = mmc_request->arg;
> +    int resp_len = sdbus_do_command(sdbus, &sdreq, response);
> +    virtio_resp->resp_len = resp_len;
> +
> +    for (int i = 0; i < resp_len / sizeof(uint32_t); i++) {
> +        virtio_resp->response[i] = ldl_be_p(&virtio_resp->response[i]);
> +    }
> +}
> +
> +static void send_command_without_response(SDBus *sdbus, mmc_req *mmc_request)
> +{
> +    SDRequest sdreq;
> +    sdreq.cmd = (uint8_t)mmc_request->opcode;
> +    sdreq.arg = mmc_request->arg;
> +    uint8_t response[4];

Ditto style (various occurences).

> +    sdbus_do_command(sdbus, &sdreq, response);
> +}

[...]
> diff --git a/include/hw/virtio/virtio-mmc.h b/include/hw/virtio/virtio-mmc.h
> new file mode 100644
> index 0000000000..a68f45d7cb
> --- /dev/null
> +++ b/include/hw/virtio/virtio-mmc.h
> @@ -0,0 +1,20 @@
> +#pragma once
> +
> +#include "hw/virtio/virtio.h"
> +#include "hw/sd/sd.h"
> +#include "qemu/typedefs.h"
> +
> +#define VIRTIO_ID_MMC 42
> +
> +#define TYPE_VIRTIO_MMC "virtio-mmc-device"
> +#define VIRTIO_MMC(obj) \
> +    OBJECT_CHECK(VirtIOMMC, (obj), TYPE_VIRTIO_MMC)
> +#define VIRTIO_MMC_GET_PARENT_CLASS(obj) \
> +    OBJECT_GET_PARENT_CLASS(VIRTIO_MMC(obj), TYPE_VIRTIO_MMC)
> +
> +typedef struct VirtIOMMC {
> +    VirtIODevice parent_obj;

Please add a newline here

> +    VirtQueue *vq;
> +    SDBus sdbus;
> +    BlockBackend *blk;
> +} VirtIOMMC;

Otherwise (skipping virtio), for SD/MMC LGTM so far.

Regards,

Phil.

