Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB47DC5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 09:40:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJqn9-00059M-Ve; Tue, 27 May 2025 05:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uJqmw-00055u-My
 for qemu-devel@nongnu.org; Tue, 27 May 2025 05:40:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uJqmo-00025d-Ox
 for qemu-devel@nongnu.org; Tue, 27 May 2025 05:40:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748338792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zmNQ1Zpcx1KVQ+1w3Eu1wPtC1KdXP16T1zWbscxtEYI=;
 b=IJw6n3SYtuEmvUnycqD0YirIf99DKDHF+Vo/9fQsFwhhnvUKC/0P7XS2S5B8jXxFlIBboe
 L7T5VpofeqO5Z6wmWcin2lbWGKCV7zi5e9TXPnEpU2bLELdp7XN8XPwgMmAN5LlyW94Ih5
 wiuL1yCVxElhd9DbOtUHDWuoaxwsB5o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-qq4wMkL5NnqPMh7KyxjDvg-1; Tue, 27 May 2025 05:39:50 -0400
X-MC-Unique: qq4wMkL5NnqPMh7KyxjDvg-1
X-Mimecast-MFC-AGG-ID: qq4wMkL5NnqPMh7KyxjDvg_1748338790
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4d81f7adeso1315874f8f.2
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 02:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748338790; x=1748943590;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zmNQ1Zpcx1KVQ+1w3Eu1wPtC1KdXP16T1zWbscxtEYI=;
 b=mD8Y6wtTJk/6j2sHKqg/prawM4DAs7vRFX8LZNLbdqo5OCNJ53TsPghMHs81ekM/i1
 0mPZ0vY+x2vH74uP64c86ing/tgE6gYjy7nfJYuHcv3onKNNsKo0zXKRrkNJsPOBCuU9
 4Jt3M6eWxksfnrBZ2DGRd1bi0+6kPbTtzOPOv4Dt9hSVP8hDNVgrXv6Wjs32jCZfFJmf
 nL4ILcZKpXXrcAwO9eBG6ezeSkY7Io6sXXe7q7dirfBihl0djffNKndHVQiGe4qrC9uB
 eYojXcxRy4mV0yU1iWJstmzirGquNl/ZC7117o5GefdPU/8POuiJfWl44Pt9+WTN4zI5
 VOvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyOeCyPdwd4UpsowM/bbjZe3mLz8LACSP58D+nwMpV2I8vVxPKl58TkJs1O9BAsThloMSupOA9G97V@nongnu.org
X-Gm-Message-State: AOJu0YwApgcgjJvKJPphzELaICTy3qsvxGujA0RLl4eBsufCQeCHQIYZ
 nX/LQE16r5+GODW3z0s5a60bthTlQfNvAurIXgawNjNBiCQCNhdTkv9thF82pCoMxIuiJqYEr3+
 iV34P1hThi4Fr4AdUkfo4xVe5vshuVn272c4qsC1YlCZbmGN/i4sxtfPw
X-Gm-Gg: ASbGncsYeQCb0rglYpk5kLL6/7K+4gg0IM7uFICFhTVIdA9JswqUuhKp7WKRiN0bPUG
 i9C/gDE5GeEp0MkjPV31fjZRhXZm0uk0VZxUbQY+zoJgJ0UvBFmGJLxbuZ+rXVQybixJb6R3Hi2
 Sz42K1oI6OyvyDPfr7qQ+2WF7xAQH2ZAp9/15XxJYyLqiSEVjMTbB1pQ95KXt7WluH/nO0480Op
 owSCyKlyBoOOoGYe3pw+4nEHToW76DCgpWqCD1RjKVmjR6Pe2UDWQIAoiUgyGLNRaRVzkJz2VLi
 DxdPaflmgDjYoHYjxRvrVnB1DI/uOiR8QXBsW0rKOj1/iyp33A==
X-Received: by 2002:a05:6000:250c:b0:3a4:cfbf:51ae with SMTP id
 ffacd0b85a97d-3a4cfbf5352mr8951742f8f.4.1748338789782; 
 Tue, 27 May 2025 02:39:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYyHvn1znb2fGSOc6L34yb9bCfeG+Gbn0z0kVxP2IYJ3UR3+8Fi7GxN9MQc1Lz9UtIBkO3Ww==
X-Received: by 2002:a05:6000:250c:b0:3a4:cfbf:51ae with SMTP id
 ffacd0b85a97d-3a4cfbf5352mr8951707f8f.4.1748338789379; 
 Tue, 27 May 2025 02:39:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4ccc2c88dsm10191916f8f.69.2025.05.27.02.39.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 02:39:48 -0700 (PDT)
Message-ID: <ef917520-09c6-40c0-b432-b500f030a2c4@redhat.com>
Date: Tue, 27 May 2025 11:39:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/29] vfio-user client
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250520150419.2172078-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

John

On 5/20/25 17:03, John Levon wrote:
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
> https://lore.kernel.org/qemu-devel/047d7d93-3fa5-41db-bdbf-3c14c8b47455@redhat.com/T/#t
> 
> Changes since last series:
> 
>   - rebased on v5 of vfio: return mr from vfio_get_xlat_addr
>   - added docs for VFIOIOMMUClass
>   - separated out vfio pci exports and renamed to vfio_pci namespace
> 
> John Levon (27):
>    vfio: add more VFIOIOMMUClass docs
>    vfio: move more cleanup into vfio_pci_put_device()
>    vfio: move config space read into vfio_pci_config_setup()
>    vfio: refactor out IRQ signalling setup
>    vfio: export PCI helpers needed for vfio-user
>    vfio: enable per-IRQ MSI-X masking
>    vfio: add per-region fd support
>    vfio: mark posted writes in region write callbacks
>    vfio/container: pass MemoryRegion to DMA operations
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
>   include/hw/vfio/vfio-container-base.h |   70 +-
>   include/hw/vfio/vfio-device.h         |   15 +-
>   include/hw/vfio/vfio-region.h         |    2 +
>   include/system/memory.h               |   19 +-
>   hw/vfio-user/container.c              |  348 ++++++
>   hw/vfio-user/device.c                 |  389 +++++++
>   hw/vfio-user/pci.c                    |  428 +++++++
>   hw/vfio-user/proxy.c                  | 1314 +++++++++++++++++++++
>   hw/vfio/container-base.c              |    4 +-
>   hw/vfio/container.c                   |    3 +-
>   hw/vfio/device.c                      |   57 +-
>   hw/vfio/iommufd.c                     |    3 +-
>   hw/vfio/listener.c                    |   39 +-
>   hw/vfio/pci.c                         |  195 ++--
>   hw/vfio/region.c                      |   10 +-
>   hw/virtio/vhost-vdpa.c                |    9 +-
>   system/memory.c                       |   32 +-
>   hw/meson.build                        |    1 +
>   hw/vfio-user/meson.build              |   11 +
>   hw/vfio-user/trace-events             |   18 +
>   hw/vfio/trace-events                  |    6 +-
>   meson_options.txt                     |    2 +
>   scripts/meson-buildoptions.sh         |    4 +
>   35 files changed, 4845 insertions(+), 146 deletions(-)
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

I am planning to take first patches 2,3,4 in vfio-next. The rest
either requires rework or conflicts with the live update series.
Tell me if you are ok with that.


Thanks,

C.



