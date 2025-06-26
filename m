Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CBAC7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 07:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUgn9-0006oT-6Z; Thu, 26 Jun 2025 03:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUgn7-0006nk-Ls
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 03:13:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUgn5-0002Wm-Fl
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 03:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750921976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=h1v1feE3nJ6gEdfXh0mcEEZvNzG8nt8E4Z2RlaQL5SU=;
 b=OZd3e83WGNaV0Q5InM4F/qE8h7db0ImbbAqsSf/+piEM6JQXtHg1x4j1BKr5VKHLBWI/oo
 xQ5cEDNsd2WBRd1+7guQfa1Tw6rL5/2gaO2k3yFqRN/DwIc+IDOgkJhZGB9ZTSM3ayZG7Z
 Occ0YlXPnlKsK3Rxs6F/yb499ZALxns=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-QyBFv2ZTN0GymgUq6VFv5A-1; Thu, 26 Jun 2025 03:12:53 -0400
X-MC-Unique: QyBFv2ZTN0GymgUq6VFv5A-1
X-Mimecast-MFC-AGG-ID: QyBFv2ZTN0GymgUq6VFv5A_1750921972
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-450db029f2aso2328555e9.3
 for <qemu-devel@nongnu.org>; Thu, 26 Jun 2025 00:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750921972; x=1751526772;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h1v1feE3nJ6gEdfXh0mcEEZvNzG8nt8E4Z2RlaQL5SU=;
 b=p/mnSre/lrIw22/QndHiCRagqIjvwfTj1vRGJaRKl3ERwtCwJmaYFgKahfN04ni+YX
 tM1kk4CFU3RbXUH1ZSIG3EjVuCjo2Ik2Ddpav4zIs3Et8jycIHfmljdrT3MjgI2vC6Hf
 s7WQcGqYjtJBZMhd2TJNF6nJEvpjoOhq5sqmp6VkgnWlzRkbryCc1eTJebGkp7g8tgkm
 PCJJOgzI9Nu1EdBIqXUSVWMGhJgZl51w1/2sMjVkmH2UlgXLdPMDDcBA4hlj6TsWci4F
 PzjzVaW3avGyZJn74fnljFQwdCsxlyJhv0zdjH6nyUskq0NtLa+l3w7pbQA8anaQxtlf
 PwdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHDpEAa4zs5Lr6ajVpzriiuVYvWvZWeRU3lY5JerGWYxtkKsrfHaZzMXA3YXkWFraRat+oVyu92TWd@nongnu.org
X-Gm-Message-State: AOJu0YyZhyUAWeBEPPF0e76Hm01eyhHK7Ryof1AhX9ZcQeySrnqNS8d+
 XUz5kAGtEcAZyGC0MLowrpBvSZ+jTNlERelvaInftsovhitHcyjg7p7G7HmdfUF4d1F0FYvQ4JX
 aCsntTDZ32JE9bsn4RuwrALdLb68feQHjrlXhKLt1Y7taEbaIr0WCohLY
X-Gm-Gg: ASbGncuHZu3zMuDzxpfUDk8rsSp6o945Al7zfo5cAYdgN0qHTqP1Q0fC4CQ2xJ40x+d
 tuuOf+dcqdqZgdRB5XLt/QQ3j3YYPJg8RNHcumRLASkvAWlknNTw2SsRo0FBHB3UuzwkOIssLP6
 w8fi0Izc1CxOs9udj4kQ8yDLH69HxaaoygS7kXLWMGXzBuFQMQHhLb2bpGYWLNt8SaEAqARmshy
 SgnmfTlZL/L+AWjFgyvD/WfqiPbfVWQKID3bjG+RxbZkesof5uZawIzCCnOVrcH8jlQwJBsVyT5
 pub4gPD7TxyTyV/JMUsR1lRbDp82fJ19fUSu5w5fgcq4LCCHWl2HRZ7/lAUB
X-Received: by 2002:a05:6000:2b06:b0:3a4:dc32:6cbc with SMTP id
 ffacd0b85a97d-3a6ed638214mr3316077f8f.20.1750921971827; 
 Thu, 26 Jun 2025 00:12:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7V2amDr6eot22iLAQiG6KH+PLlvDZdaF4XxDaXgvsjOOiTr8YZuxahdk6tuhOuy7OZhlm5w==
X-Received: by 2002:a05:6000:2b06:b0:3a4:dc32:6cbc with SMTP id
 ffacd0b85a97d-3a6ed638214mr3316056f8f.20.1750921971371; 
 Thu, 26 Jun 2025 00:12:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6f3a79377sm1326959f8f.20.2025.06.26.00.12.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Jun 2025 00:12:50 -0700 (PDT)
Message-ID: <0398b04a-7fa6-498e-a674-619de2227b11@redhat.com>
Date: Thu, 26 Jun 2025 09:12:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/19] vfio-user client
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250625193012.2316242-1-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250625193012.2316242-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 6/25/25 21:29, John Levon wrote:
> The series contains an implementation of a vfio-user client in QEMU.
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
> A functional test is still being worked on.
> 
> A previous version of this series can be found at
> https://lore.kernel.org/qemu-devel/20250619133154.264786-1-john.levon@nutanix.com/
> 
> Changes since last series:
> 
>   - fixed SPDX identifier nits
>   - code review changes for error handling
> 
> thanks
> john
> 
> John Levon (18):
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
> Thanos Makatos (1):
>    vfio-user: introduce vfio-user protocol specification
> 
>   MAINTAINERS                           |   11 +-
>   docs/interop/index.rst                |    1 +
>   docs/interop/vfio-user.rst            | 1520 +++++++++++++++++++++++++
>   docs/system/device-emulation.rst      |    1 +
>   docs/system/devices/vfio-user.rst     |   26 +
>   meson.build                           |    1 +
>   hw/vfio-user/container.h              |   23 +
>   hw/vfio-user/device.h                 |   24 +
>   hw/vfio-user/protocol.h               |  242 ++++
>   hw/vfio-user/proxy.h                  |  135 +++
>   hw/vfio-user/trace.h                  |    4 +
>   hw/vfio/pci.h                         |    1 +
>   include/hw/vfio/vfio-container-base.h |    1 +
>   include/hw/vfio/vfio-device.h         |    2 +
>   hw/vfio-user/container.c              |  370 ++++++
>   hw/vfio-user/device.c                 |  441 +++++++
>   hw/vfio-user/pci.c                    |  475 ++++++++
>   hw/vfio-user/proxy.c                  | 1356 ++++++++++++++++++++++
>   hw/Kconfig                            |    1 +
>   hw/meson.build                        |    1 +
>   hw/vfio-user/Kconfig                  |    7 +
>   hw/vfio-user/meson.build              |   11 +
>   hw/vfio-user/trace-events             |   20 +
>   23 files changed, 4673 insertions(+), 1 deletion(-)
>   create mode 100644 docs/interop/vfio-user.rst
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
>   create mode 100644 hw/vfio-user/Kconfig
>   create mode 100644 hw/vfio-user/meson.build
>   create mode 100644 hw/vfio-user/trace-events
> 


Applied to vfio-next.

Thanks,

C.




