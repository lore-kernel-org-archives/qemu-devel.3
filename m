Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E7AE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJFP-0001mG-Vs; Thu, 19 Dec 2024 11:19:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tOGw5-0007Hg-Ah
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 08:51:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tOGw3-0001LH-Kh
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 08:51:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734616285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hAXXvvOkklGkw9sjph4RvQEZTmWxQ6bkUycqSZlViZ0=;
 b=cUJv4kZWjzFsI7CMvJEDxgPDDLtbZyfzihWTWVKvlhMlWCnHnxGxrYoPKOuZN7yJQOQYmy
 5hXOTJylO90G9lLs46sazsfBruAne5fWfLBwipqxQebHVoJztTeUpeBeknZtGENU5wM262
 Z3FJaLPmOyhYzB4vPl2PjmyWPHSX2Vs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-0FesnXQRPIWAbR4lC82Ljw-1; Thu, 19 Dec 2024 08:51:24 -0500
X-MC-Unique: 0FesnXQRPIWAbR4lC82Ljw-1
X-Mimecast-MFC-AGG-ID: 0FesnXQRPIWAbR4lC82Ljw
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4361fc2b2d6so5034185e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 05:51:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734616283; x=1735221083;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=hAXXvvOkklGkw9sjph4RvQEZTmWxQ6bkUycqSZlViZ0=;
 b=rLozZen2UDug2DatECnBEcWvK4gLZA41CFQRrGj/rTGhb5t83lh2qY6irqqblLCIWz
 BMqTgg2uJ/b3Ta/TSDyNU0mTTUN4JpC1GJMnVrUMDThxR2tOtd8WzRd0AmxHw5sac8fU
 u69mY8ra1FSi96o4gX1gDZBmWDkVHjlORyj2pimvtPQyLoLLfOtUtR//5u/h16eoJxKc
 M9MRPyBuXOLDn7+3twOW6CoaO2E7hyJRh01fVfp2+Xdk2fhSms1FypO0YVYiCLVGq69B
 MnXTuaSDf3BD7m2OC1DkK6X6P9hagf9TRSYFHwBMKlJzeBUXXg3wd4d/SNK4S9PCTLLK
 IU8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcQ6dwwnnUATSPORmE0TwulwZy2y7WX4HhOJkO4YiOV/V/8q/arQBov9mnhm7y57SIWpoT+WdFc71A@nongnu.org
X-Gm-Message-State: AOJu0Ywf/6UcYa1+8IxwO39UNe7PF4UnMFezdkQvgz1FI04sZbEzpJUM
 Nrbv+yeYOOqYWMSBVZ2KBNWMq+MghBUUmLU+HyEDFclDmoTfhvIPX3g+ld3X68arIrRj7w7Tzta
 ISrIMa9XvkmtQkM9hMAhp8wXX4wmFw6TEHSwR24vEENh3YS+qE0k3
X-Gm-Gg: ASbGncsKNFg1TMMOQW4jZN1tDWX0OV2Gt1BYxBV4/s5VmBE4lG+mEC3uNshsZ8yT/0E
 4KxMkhUK+8KmN4PwAxgbdoKlfBa6auyXm6g/bpYw5y7aH5RNnkLDybGvFXw0/pHE3OirKiygrGx
 WHeomJgaW5MzVHiWwCXrC/o03WOwEm5TqWPQwr3jV2syPFmumqW3GLH9Rmn9OCfKl6kd7kbzF0H
 66j4v9u/xpo3DhiHS9Z6btW1YNNOPSEMFYVnlDPisZtejVWALlczEWZHQJR11yntctNS94KNOvP
 55CRS3M3keSDzSekf47tK6R/sTbQATGORpIY1YVtmqQ4O4tv9TV1vXteF3JL6YFSMRQUA9wOpY6
 q0b5Rfw==
X-Received: by 2002:a05:6000:4010:b0:385:f7a3:fea6 with SMTP id
 ffacd0b85a97d-38a19b08171mr3150471f8f.13.1734616283351; 
 Thu, 19 Dec 2024 05:51:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXM+lBMWPWLQThprfVGv8fy+Ns4/aWKeXlcJoMDWPYLUFJGL5ivoXjtSc1HpZsG8esdpQILQ==
X-Received: by 2002:a05:6000:4010:b0:385:f7a3:fea6 with SMTP id
 ffacd0b85a97d-38a19b08171mr3150460f8f.13.1734616282955; 
 Thu, 19 Dec 2024 05:51:22 -0800 (PST)
Received: from ?IPV6:2003:cb:c749:6600:b73a:466c:e610:686?
 (p200300cbc7496600b73a466ce6100686.dip0.t-ipconnect.de.
 [2003:cb:c749:6600:b73a:466c:e610:686])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e219sm1619492f8f.84.2024.12.19.05.51.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 05:51:22 -0800 (PST)
Message-ID: <d2730488-8468-4639-876c-18a860c6469e@redhat.com>
Date: Thu, 19 Dec 2024 14:51:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio: reset virtio balloon stats on machine reset
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>
References: <20241218172912.4170899-1-berrange@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241218172912.4170899-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 18.12.24 18:29, Daniel P. Berrangé wrote:
> When a machine is first booted, all virtio balloon stats are initialized
> to their default value -1 (18446744073709551615 when represented as
> unsigned).
> 
> They remain that way while the firmware is loading, and early phase of
> guest OS boot, until the virtio-balloon driver is activated. Thereafter
> the reported stats reflect the guest OS activity.
> 
> When a machine reset is performed, however, the virtio-balloon stats are
> left unchanged by QEMU, despite the guest OS no longer updating them,
> nor indeed even still existing.
> 
> IOW, the mgmt app keeps getting stale stats until the guest OS starts
> once more and loads the virtio-balloon driver (if ever). At that point
> the app will see a discontinuity in the reported values as they sudden
> jump from the stale value to the new value. This jump is indigituishable
> from a valid data update.
> 
> While there is an "last-updated" field to report on the freshness of
> the stats, that does not unambiguously tell the mgmt app whether the
> stats are still conceptually relevant to the current running workload.
> 
> It is more conceptually useful to reset the stats to their default
> values on machine reset, given that the previous guest workload the
> stats reflect no longer exists. The mgmt app can now clearly identify
> that there are is no stats information available from the current
> executing workload.
> 
> The 'last-updated' time is also reset back to 0.
> 
> IOW, on every machine reset, the virtio stats are in the same clean
> state they were when the macine first powered on.
> 
> A functional test is added to validate this behaviour with a real
> world guest OS.
 > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
> 
> One side-thought I have, is whether it makes sense to add a
> 'reset-count' field in the virtio stats, alongside the
> 'last-updated' field. While apps can infer a reset from seeing
> the stats all go back to their defaults, an explicit flag is
> simpler...
> 
>   MAINTAINERS                             |   1 +
>   hw/virtio/virtio-balloon.c              |  30 ++++-
>   include/hw/virtio/virtio-balloon.h      |   4 +
>   tests/functional/test_virtio_balloon.py | 161 ++++++++++++++++++++++++
>   4 files changed, 195 insertions(+), 1 deletion(-)
>   create mode 100755 tests/functional/test_virtio_balloon.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 822f34344b..1380d53d03 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2234,6 +2234,7 @@ F: include/hw/virtio/virtio-balloon.h
>   F: system/balloon.c
>   F: include/sysemu/balloon.h
>   F: tests/qtest/virtio-balloon-test.c
> +F: tests/functional/test_virtio_balloon.py
>   
>   virtio-9p
>   M: Greg Kurz <groug@kaod.org>
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index ab2ee30475..fe0854e198 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -31,7 +31,7 @@
>   #include "trace.h"
>   #include "qemu/error-report.h"
>   #include "migration/misc.h"
> -
> +#include "sysemu/reset.h"
>   #include "hw/virtio/virtio-bus.h"
>   #include "hw/virtio/virtio-access.h"
>   
> @@ -910,6 +910,8 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
>       }
>   
>       reset_stats(s);
> +    s->stats_last_update = 0;
> +    qemu_register_resettable(OBJECT(dev));
>   }
>   
>   static void virtio_balloon_device_unrealize(DeviceState *dev)
> @@ -917,6 +919,7 @@ static void virtio_balloon_device_unrealize(DeviceState *dev)
>       VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>       VirtIOBalloon *s = VIRTIO_BALLOON(dev);
>   
> +    qemu_unregister_resettable(OBJECT(dev));
>       if (s->free_page_bh) {
>           qemu_bh_delete(s->free_page_bh);
>           object_unref(OBJECT(s->iothread));
> @@ -987,6 +990,27 @@ static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t status)
>       }
>   }

Using qemu_register_resettable() can have unfortunate side effects that 
this code is triggered when the device is reset, not necessarily when 
the complete machine.

For virtio-mem at least that's an issue, and here is how I'll fix it:

https://lore.kernel.org/qemu-devel/20241218105303.1966303-2-david@redhat.com/

-- 
Cheers,

David / dhildenb


