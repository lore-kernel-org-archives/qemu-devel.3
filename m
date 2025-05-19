Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58153C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 12:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGzn6-0002re-8I; Mon, 19 May 2025 08:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uGzn4-0002rP-Vx
 for qemu-devel@nongnu.org; Mon, 19 May 2025 08:40:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uGzn1-0007jW-8h
 for qemu-devel@nongnu.org; Mon, 19 May 2025 08:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747658417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5KBErzXaDc+XYGfPbt7af9I7mqB8MaCCDu088FhOQ1s=;
 b=RsbCIbb98Xa0nuL64p+yS1zYO1IDB8ctMG0SNshjA9KsbkyEDisE6JiSG92iiab2OjNTMQ
 7Rm7LECwVHPPIM//3KFIQD617qM8YsBHhqKLbonsc0+dpZRJmPkgFkzqoWm3ZY8f7kfAi0
 qoUU6wx89Z5JuamMQRBJWbfwSqG9Zb0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-FyPzh-OCNe-orqG7RSH-_A-1; Mon, 19 May 2025 08:40:15 -0400
X-MC-Unique: FyPzh-OCNe-orqG7RSH-_A-1
X-Mimecast-MFC-AGG-ID: FyPzh-OCNe-orqG7RSH-_A_1747658414
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d007b2c79so34999765e9.2
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 05:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747658414; x=1748263214;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5KBErzXaDc+XYGfPbt7af9I7mqB8MaCCDu088FhOQ1s=;
 b=d5rxwWsrE+UzykldP1KGLGsTdGsSKlpmi2gVjZtLnkE1z6iHcDB88nVvnEe8e2uiXO
 4FP6O/7q+r0ZBo3XwQ7rW7m4XC0kD92efiMEPoQcgbIh1DJjjl8ofmotPp7tqWurB77u
 veA+SNt/wpFLoj7n4j5iwIduHke4Gg1jDsqLuVXm5S7DxtTu+Tp6bk+alTs5GjXeny52
 KjI1hE03b/y9RjIIO5yAFg8vrjkV/Z7uPECly1JmJmuAjQP3t1+dTlKxTn+tbrf51H4j
 VALztiMO8o7VngC8LnQoIVdHq6T0muBWsauXIDS3COKZn3bg2l394HjLIi3HMFXPclan
 GQwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn6ejgUz0SEGPonPKh3OQs9Kn7GTyS9iY3svHne2O4Od5jsGomXCIQH/rYLn0pV8qA4G2NzWiMHDdi@nongnu.org
X-Gm-Message-State: AOJu0YxnU2S1fd4y7Zx6R0OlMl4ne1O/zc9O36P4MrPVqlxPePrK2X0E
 PA+7Uen30L4BT1H2LWRFL22CdYwBYjx7Ke6meRANMs7kbshS+FcQXWVH3EpU9Vfa8eXddD8LB8D
 PSiGKwDOBcS5lyCnZ1GtVIRAqBW5lnjMCGrLTbkxJDED+vyXNbptFAn3T
X-Gm-Gg: ASbGncvUlUZnpC1IYU4W7dTypHotsZS99ha3mZJVmbWGhh6GE2nAy6yRb2YkR8877Hc
 crPmkUwcuzsR+TRaXgqsbJDYdtXj3RyPYkxTasiRUHEwWdjSn7dUUeTn/H+2c6DG8ocpgqaNlX8
 qTFOv82wYTVsOH5o6cVe587eZvToc2x4Ps2WFAn8X6ks7eGDY59ZNtvfLgu1Nyoc8VcvvfJZn3T
 n4SaOGPw8HS9yuYyHp1d7YxJjVIZDwmQRbsvy/+wWggYmYSbw/HGSjFVJjmbiVdJ1seLMSh3dWu
 MitqVRa7MmcbexRS8uFNSyXKYqc9DwOax38llJeIo3vhaz9iOw==
X-Received: by 2002:a05:600c:4fd4:b0:441:b00d:e9d1 with SMTP id
 5b1f17b1804b1-442fd606ce9mr135619485e9.2.1747658414300; 
 Mon, 19 May 2025 05:40:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNswlb6Df+GNOCz2EDpWsmjYmQkQuOzjnyupNmHZJmEVMQdS8kLNhHczYic5a6TyJHPBL5Nw==
X-Received: by 2002:a05:600c:4fd4:b0:441:b00d:e9d1 with SMTP id
 5b1f17b1804b1-442fd606ce9mr135619125e9.2.1747658413902; 
 Mon, 19 May 2025 05:40:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-443003ab9e2sm122050215e9.7.2025.05.19.05.40.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 May 2025 05:40:13 -0700 (PDT)
Message-ID: <6cc53fff-9583-48cc-a5e3-3dadf1dd215c@redhat.com>
Date: Mon, 19 May 2025 14:40:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/27] vfio-user client
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Steve Sistare <steven.sistare@oracle.com>
References: <20250515154413.210315-1-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250515154413.210315-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

John,

+ Steven,

On 5/15/25 17:43, John Levon wrote:
> The series contains an implement of a vfio-user client in QEMU, along with a few
> more preparatory patches.
> 
> The vfio-user protocol allows for implementing (PCI) devices in another
> userspace process; SPDK is one example, which includes a virtual NVMe
> implementation.
> 
> The vfio-user framework consists of 3 parts:
>   1) The VFIO user protocol specification.
>   2) A client - the VFIO device in QEMU that encapsulates VFIO messages
>      and sends them to the server.
>   3) A server - a remote process that emulates a device.
> 
> This patchset implements parts 1 and 2.
> 
> It has been tested against libvfio-user test servers as well as SPDK.
> 
> A previous version of this series can be found at
> https://lore.kernel.org/all/7dd34008-e0f1-4eed-a77e-55b1f68fbe69@redhat.com/T/
> (I've reset the version as it has changed significantly.)
> 
> thanks
> john
> 
> John Levon (25):
>    vfio/container: pass MemoryRegion to DMA operations
>    vfio: move more cleanup into vfio_pci_put_device()
>    vfio: move config space read into vfio_pci_config_setup()
>    vfio: refactor out IRQ signalling setup
>    vfio: enable per-IRQ MSI-X masking
>    vfio: add per-region fd support
>    vfio: mark posted writes in region write callbacks
>    vfio-user: add vfio-user class and container
>    vfio-user: connect vfio proxy to remote server
>    vfio-user: implement message receive infrastructure
>    vfio-user: implement message send infrastructure
>    vfio-user: implement VFIO_USER_DEVICE_GET_INFO
>    vfio-user: implement VFIO_USER_DEVICE_GET_REGION_INFO
>    vfio-user: implement VFIO_USER_REGION_READ/WRITE
>    vfio-user: set up PCI in vfio_user_pci_realize()
>    vfio-user: implement VFIO_USER_DEVICE_GET/SET_IRQ*
>    vfio-user: forward MSI-X PBA BAR accesses to server
>    vfio-user: set up container access to the proxy
>    vfio-user: implement VFIO_USER_DEVICE_RESET
>    vfio-user: implement VFIO_USER_DMA_MAP/UNMAP
>    vfio-user: implement VFIO_USER_DMA_READ/WRITE
>    vfio-user: add 'x-msg-timeout' option
>    vfio-user: support posted writes
>    vfio-user: add coalesced posted writes
>    docs: add vfio-user documentation
> 
> Steve Sistare (1):
>    vfio: return mr from vfio_get_xlat_addr
> 
> Thanos Makatos (1):
>    vfio-user: introduce vfio-user protocol specification
> 
>   MAINTAINERS                           |   10 +-
>   docs/devel/index-internals.rst        |    1 +
>   docs/devel/vfio-user.rst              | 1522 +++++++++++++++++++++++++
>   docs/system/device-emulation.rst      |    1 +
>   docs/system/devices/vfio-user.rst     |   24 +
>   meson.build                           |    1 +
>   hw/vfio-user/container.h              |   27 +
>   hw/vfio-user/device.h                 |   27 +
>   hw/vfio-user/protocol.h               |  245 ++++
>   hw/vfio-user/proxy.h                  |  137 +++
>   hw/vfio-user/trace.h                  |    1 +
>   hw/vfio/pci.h                         |   16 +
>   include/hw/vfio/vfio-container-base.h |    5 +-
>   include/hw/vfio/vfio-device.h         |   15 +-
>   include/hw/vfio/vfio-region.h         |    2 +
>   include/system/memory.h               |   16 +-
>   hw/vfio-user/container.c              |  348 ++++++
>   hw/vfio-user/device.c                 |  389 +++++++
>   hw/vfio-user/pci.c                    |  428 +++++++
>   hw/vfio-user/proxy.c                  | 1314 +++++++++++++++++++++
>   hw/vfio/container-base.c              |    4 +-
>   hw/vfio/container.c                   |    3 +-
>   hw/vfio/device.c                      |   57 +-
>   hw/vfio/iommufd.c                     |    3 +-
>   hw/vfio/listener.c                    |   35 +-
>   hw/vfio/pci.c                         |  163 ++-
>   hw/vfio/region.c                      |   10 +-
>   hw/virtio/vhost-vdpa.c                |    8 +-
>   system/memory.c                       |   25 +-
>   hw/meson.build                        |    1 +
>   hw/vfio-user/meson.build              |   11 +
>   hw/vfio-user/trace-events             |   18 +
>   meson_options.txt                     |    2 +
>   scripts/meson-buildoptions.sh         |    4 +
>   34 files changed, 4753 insertions(+), 120 deletions(-)
>   create mode 100644 docs/devel/vfio-user.rst
>   create mode 100644 docs/system/devices/vfio-user.rst
>   create mode 100644 hw/vfio-user/container.h
>   create mode 100644 hw/vfio-user/device.h
>   create mode 100644 hw/vfio-user/protocol.h
>   create mode 100644 hw/vfio-user/proxy.h
>   create mode 100644 hw/vfio-user/trace.h
>   create mode 100644 hw/vfio-user/container.c
>   create mode 100644 hw/vfio-user/device.c
>   create mode 100644 hw/vfio-user/pci.c
>   create mode 100644 hw/vfio-user/proxy.c
>   create mode 100644 hw/vfio-user/meson.build
>   create mode 100644 hw/vfio-user/trace-events
> 

patches 3-5 seem be ok to merge. They are first on my vfio-next
candidates.

patches 1-2 should be reworked on top of the memory_get_xlat_addr()
changes [1] proposed by Steven.

I haven't looked at patches 6-8 yet. I think I saw some conflicts
with the live update proposal from Steven. To be clarified next.

The rest (9-27) is vfio-user territory only (I hope). Still, it
should be merged through the VFIO tree. Would it be complex to
propose a functional test for it ?

Thanks,

C.


[1] https://lore.kernel.org/qemu-devel/1747415599-131553-1-git-send-email-steven.sistare@oracle.com/


