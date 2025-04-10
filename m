Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0C4C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 12:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2qny-0006Tc-Cm; Thu, 10 Apr 2025 08:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2qnt-0006Sr-UX
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 08:14:46 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2qnr-0006re-Lj
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 08:14:45 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso6046125e9.0
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 05:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744287281; x=1744892081; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1RNQhSRNuvdlOyom3KD1yMuWAUd7GDTIT5OFQE4tc9Y=;
 b=s5vfVYFofKGQIOUrTZpHWADSgiX0WvakzFFxa4e4nFT0GWZpW6UcWOvXQS9UgsqD/y
 ipdsyWXCWT4jJ2yFx2ztKlFaPDYCGVazCjJQTAUDG/PRWlYWQiy1MPiaI4Lvn/OEq3tt
 GVKKJZOoaFbSCeUCqKRrcqzqP11w6PT0L/9Quzx7EeFue5n0LdnVsFyGnQ3c8SXHddG9
 OY67Dm6KjxvVOVLlINBHHaXniqck9UL4joVSImlZcY9/hgBkln0fELoQUBrPs3Ru/WvX
 JZ/uKj9zYbQAuvTFDkOK80gJ+U5ZqEiyHOg7+giLO+wd6Bng1sWPw/1bmhE2c00UrvAS
 GteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744287281; x=1744892081;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1RNQhSRNuvdlOyom3KD1yMuWAUd7GDTIT5OFQE4tc9Y=;
 b=DHjfZiWQ6kFSXWJL2kAcl2LGBJwVFpyIufLASnu9h/EkNXPi+2LKvfNcqcZ5+sZ99+
 72BLO97tWI/cHHArS4Axm+ugM9mvGPcfcX8DrkBsPwup1RjO1HmXmZsM6NfUBsSdpcrl
 bp6I/X8erNV4XH7p7uEmrvcPRURIDzexrglR4lJJwp8pEOtJqOU5p6xvGt++FLQkwH7/
 06gmLk2/6YlMdzYWIugWlKgRmqwo8Y0KA7Csl3n4alJ57DDBafq2tA6wQ+7s2ubgKrLw
 Jb2kCZOMQOZ+O13f6Gjcx6T7gER161wOrKE2otVJ11QICPX0aZSvE6LDwo/gcOhLqc2B
 dxXQ==
X-Gm-Message-State: AOJu0YyJ1pwPxWAwA60PXu+AJfbwzMZnEUDSGTTQb4NQ8RhGDBspdfs4
 y8DMWnKh/2watR0mhvnTeNmYJomduSk1cIOkfYdJ5ChMH8XZtdOc7z7yOfHh6IOmYwtxqk2COLm
 /TR8=
X-Gm-Gg: ASbGncuep+pT1WYdDPWOb+1YnewGpnSBAUgyIzI2rSIScEhZLGgiue4LMca61gOtBOp
 kuAIsTarrtZ61rAx+ltMYHsHWdUtO8gNk0OlbmBBabQJzc/prXVh/F29JECFLnBy+tMYValP9oV
 X5dNMtF4gfhJSYYgLC1MCNI+nPvLTZTotgRgExFy2l43EAG/n+fRr3amtRicqof/c7byfQQgUjT
 jzee/NR1uCY2985LpqZLiVD+7+HRq5UIuKluqKq4io5wpyic/IJc0qPDUYf0ZjBiw92AdNqkALZ
 trhR/UuQ0nencwJeeS2lPauKRdW23Nf+nwqVMeMkY3FC/GxAo8EyIfKbwaKPRv0uoX6ovYw3XOk
 AfYSs4FDV/J+wbQ==
X-Google-Smtp-Source: AGHT+IHS23AK9o7NcJvvNnqqR4GZnyhUSCkDuTJo0qzIlrYuYJp22H5/M2L7uOCwVePPjQ5q8kCN5Q==
X-Received: by 2002:a05:600c:35cf:b0:43c:ef13:7e5e with SMTP id
 5b1f17b1804b1-43f2d96dd56mr23935025e9.26.1744287281255; 
 Thu, 10 Apr 2025 05:14:41 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f235a5d31sm49491265e9.35.2025.04.10.05.14.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 05:14:40 -0700 (PDT)
Message-ID: <84b2bcf7-9df7-43e2-83d8-cae9d34ca541@linaro.org>
Date: Thu, 10 Apr 2025 14:14:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-8.0 09/10] hw/virtio: Extract
 vhost_user_ram_slots_max() to vhost-user-target.c
To: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Hanna Reitz <hreitz@redhat.com>
References: <20221212230517.28872-1-philmd@linaro.org>
 <20221212230517.28872-10-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20221212230517.28872-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Hi Pierrick,

On 13/12/22 00:05, Philippe Mathieu-Daudé wrote:
> The current definition of VHOST_USER_MAX_RAM_SLOTS is
> target specific. By converting this definition to a runtime
> vhost_user_ram_slots_max() helper declared in a target
> specific unit, we can have the rest of vhost-user.c target
> independent.
> 
> To avoid variable length array or using the heap to store
> arrays of vhost_user_ram_slots_max() elements, we simply
> declare an array of the biggest VHOST_USER_MAX_RAM_SLOTS,
> and each target uses up to vhost_user_ram_slots_max()
> elements of it. Ensure arrays are big enough by adding an
> assertion in vhost_user_init().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> RFC: Should I add VHOST_USER_MAX_RAM_SLOTS to vhost-user.h
>       or create an internal header for it?
> ---
>   hw/virtio/meson.build          |  1 +
>   hw/virtio/vhost-user-target.c  | 29 +++++++++++++++++++++++++++++
>   hw/virtio/vhost-user.c         | 26 +++++---------------------
>   include/hw/virtio/vhost-user.h |  7 +++++++
>   4 files changed, 42 insertions(+), 21 deletions(-)
>   create mode 100644 hw/virtio/vhost-user-target.c
> 
> diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
> index eb7ee8ea92..bf7e35fa8a 100644
> --- a/hw/virtio/meson.build
> +++ b/hw/virtio/meson.build
> @@ -11,6 +11,7 @@ if have_vhost
>     specific_virtio_ss.add(files('vhost.c', 'vhost-backend.c', 'vhost-iova-tree.c'))
>     if have_vhost_user
>       specific_virtio_ss.add(files('vhost-user.c'))
> +    specific_virtio_ss.add(files('vhost-user-target.c'))
>     endif
>     if have_vhost_vdpa
>       specific_virtio_ss.add(files('vhost-vdpa.c', 'vhost-shadow-virtqueue.c'))
> diff --git a/hw/virtio/vhost-user-target.c b/hw/virtio/vhost-user-target.c
> new file mode 100644
> index 0000000000..6a0d0f53d0
> --- /dev/null
> +++ b/hw/virtio/vhost-user-target.c
> @@ -0,0 +1,29 @@
> +/*
> + * vhost-user target-specific helpers
> + *
> + * Copyright (c) 2013 Virtual Open Systems Sarl.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/virtio/vhost-user.h"
> +
> +#if defined(TARGET_X86) || defined(TARGET_X86_64) || \
> +    defined(TARGET_ARM) || defined(TARGET_ARM_64)
> +#include "hw/acpi/acpi.h"
> +#elif defined(TARGET_PPC) || defined(TARGET_PPC64)
> +#include "hw/ppc/spapr.h"
> +#endif
> +
> +unsigned int vhost_user_ram_slots_max(void)
> +{
> +#if defined(TARGET_X86) || defined(TARGET_X86_64) || \
> +    defined(TARGET_ARM) || defined(TARGET_ARM_64)
> +    return ACPI_MAX_RAM_SLOTS;
> +#elif defined(TARGET_PPC) || defined(TARGET_PPC64)
> +    return SPAPR_MAX_RAM_SLOTS;
> +#else
> +    return 512;

Should vhost_user_ram_slots_max be another TargetInfo field?

> +#endif
> +}
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 8f635844af..21fc176725 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -41,24 +41,7 @@
>   #define VHOST_MEMORY_BASELINE_NREGIONS    8
>   #define VHOST_USER_F_PROTOCOL_FEATURES 30
>   #define VHOST_USER_SLAVE_MAX_FDS     8
> -
> -/*
> - * Set maximum number of RAM slots supported to
> - * the maximum number supported by the target
> - * hardware plaform.
> - */
> -#if defined(TARGET_X86) || defined(TARGET_X86_64) || \
> -    defined(TARGET_ARM) || defined(TARGET_ARM_64)
> -#include "hw/acpi/acpi.h"
> -#define VHOST_USER_MAX_RAM_SLOTS ACPI_MAX_RAM_SLOTS
> -
> -#elif defined(TARGET_PPC) || defined(TARGET_PPC64)
> -#include "hw/ppc/spapr.h"
> -#define VHOST_USER_MAX_RAM_SLOTS SPAPR_MAX_RAM_SLOTS
> -
> -#else
>   #define VHOST_USER_MAX_RAM_SLOTS 512
> -#endif
>   
>   /*
>    * Maximum size of virtio device config space
> @@ -935,7 +918,7 @@ static int vhost_user_add_remove_regions(struct vhost_dev *dev,
>   
>       if (track_ramblocks) {
>           memcpy(u->postcopy_client_bases, shadow_pcb,
> -               sizeof(uint64_t) * VHOST_USER_MAX_RAM_SLOTS);
> +               sizeof(uint64_t) * vhost_user_ram_slots_max());
>           /*
>            * Now we've registered this with the postcopy code, we ack to the
>            * client, because now we're in the position to be able to deal with
> @@ -956,7 +939,7 @@ static int vhost_user_add_remove_regions(struct vhost_dev *dev,
>   err:
>       if (track_ramblocks) {
>           memcpy(u->postcopy_client_bases, shadow_pcb,
> -               sizeof(uint64_t) * VHOST_USER_MAX_RAM_SLOTS);
> +               sizeof(uint64_t) * vhost_user_ram_slots_max());
>       }
>   
>       return ret;
> @@ -1030,7 +1013,7 @@ static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
>           }
>   
>           memset(u->postcopy_client_bases, 0,
> -               sizeof(uint64_t) * VHOST_USER_MAX_RAM_SLOTS);
> +               sizeof(uint64_t) * vhost_user_ram_slots_max());
>   
>           /*
>            * They're in the same order as the regions that were sent
> @@ -2169,7 +2152,7 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
>                   return -EINVAL;
>               }
>   
> -            u->user->memory_slots = MIN(ram_slots, VHOST_USER_MAX_RAM_SLOTS);
> +            u->user->memory_slots = MIN(ram_slots, vhost_user_ram_slots_max());
>           }
>       }
>   
> @@ -2649,6 +2632,7 @@ static void vhost_user_state_destroy(gpointer data)
>   
>   bool vhost_user_init(VhostUserState *user, CharBackend *chr, Error **errp)
>   {
> +    assert(vhost_user_ram_slots_max() <= VHOST_USER_MAX_RAM_SLOTS);
>       if (user->chr) {
>           error_setg(errp, "Cannot initialize vhost-user state");
>           return false;
> diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
> index 191216a74f..e13584ade8 100644
> --- a/include/hw/virtio/vhost-user.h
> +++ b/include/hw/virtio/vhost-user.h
> @@ -86,4 +86,11 @@ void vhost_user_async_close(DeviceState *d,
>                               CharBackend *chardev, struct vhost_dev *vhost,
>                               vu_async_close_fn cb);
>   
> +/**
> + * vhost_user_ram_slots_max()
> + *
> + * Return: maximum number of RAM slots supported by the target hardware plaform.
> + */
> +unsigned int vhost_user_ram_slots_max(void);
> +
>   #endif


