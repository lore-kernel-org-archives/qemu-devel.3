Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C811DC7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 09:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSXmK-0002oX-3G; Fri, 20 Jun 2025 05:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uSXmI-0002nB-HV
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 05:11:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uSXmG-0005fG-EO
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 05:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750410674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ly6OokCx1Kwu7YBL32J1LshUu8sgJ5edxF1Yjpyc5VY=;
 b=ZS46aYLW9IAGnZ5BlWt3Q7MKFtsLMGD9r6LD/WQrF2EkFlLsviqebC+rwvxYVgrJnll6fs
 sMKa8lPn5dD2aQqd79qjbJBShC6rxia8SxlUOpM9KzMcXpthnnrTynzol1ZcybAgh2ax3I
 luUbEYkLI3BVmz/dAQv5zw8abth5u2I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-IRr7q9Q_OJOyys_w5sjnYw-1; Fri, 20 Jun 2025 05:11:13 -0400
X-MC-Unique: IRr7q9Q_OJOyys_w5sjnYw-1
X-Mimecast-MFC-AGG-ID: IRr7q9Q_OJOyys_w5sjnYw_1750410672
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a579058758so754195f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 02:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750410672; x=1751015472;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ly6OokCx1Kwu7YBL32J1LshUu8sgJ5edxF1Yjpyc5VY=;
 b=YG+ugdPVaESVgzbG2TsYAny7QJuiCm67VaNiI5cxyhiurOkPsOCcfU5m8Ef/QqC4To
 6pf1VCP3yST/D7z4bqzVUfA/cP5dft8f4IMFrb6QoEe67o5FiUUUDMTn7zLOQv5SQXKC
 nCYjXfY85iVQkbcPwKDwkXdh4RdOd6P43ooqCqt01+i10LXZqxHo1RLPhQ+dC9UCC9PS
 yla3xVMcI9HwyZ23eVhTZhs7xzb0ic8ALD680KyFwXYKJ1qdL3c1cLSUo16bu21gre5E
 3Wkxo6ky23Ob0LWT8NCSgvoFFhoB9aCVEc8njQEUrdrr0Uy+tDgThBcSlU3Gs5Z5hNXL
 H8Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/ihhnZPcbf3BCHOasm7U0r7nmZrg9ZRn4/vcgBgAwe1KjD2eo1clc5Omh1Etl4xsjWvyV+ypfljxC@nongnu.org
X-Gm-Message-State: AOJu0YxVwVLRrTadmu80Oj9m5XeCB4tffKD1+Iby4UMzAW9Q5DqwmSDx
 zqTCgleEiN1p3iIkq55r0015AVYED6NjtyN+iwThLGuLTBPpFT7lXrRBQTbYJKjvrUHfd0LrJDV
 eYM1eMPgm2KkqVDFBwNKIrLVUbSsrvnSnodYwOP8PGP716n54wbwQn/5D
X-Gm-Gg: ASbGncv/d/E913E/xp4vcdoXgQ17s9WJcg3K6cCUboMSan2BUWE7Q4lF4zUQ/ECrAVT
 x0qE8coyb4vlZGU+8leTJwkw9FW4XEwd8/+w+WMG0gzpktDduqHiHmbppfXGXSDspBmezNINM9i
 Y7BS8f9A1g45NXJG1N0/GIFOytq4vjQ6sgBTaQ44WD1Z9DKL+tsd2ANQm0pFpo5/r3yV5mGh7u3
 DcDemizMsKt7s86RbESLdoCHsYGZenLYsuJbr/7x4m64rxfTRUZ3TkTZ/iQvW9dyhe3UzXiY0Da
 wt7GpfNLRv7qAl6g+aVcd9XonIpOIh5CM1aCaL2eDlQ3yXLNGJr7NjmPdANd
X-Received: by 2002:a05:6000:4284:b0:3a4:ee3f:8e1e with SMTP id
 ffacd0b85a97d-3a6d12dee20mr1679929f8f.39.1750410672177; 
 Fri, 20 Jun 2025 02:11:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlJwj2GedXspJLdixXnDKZB3KbvST+G+litLHhT9aL5T4eOg7FQf5OMNL7wx/VeWCjWOR0nw==
X-Received: by 2002:a05:6000:4284:b0:3a4:ee3f:8e1e with SMTP id
 ffacd0b85a97d-3a6d12dee20mr1679898f8f.39.1750410671729; 
 Fri, 20 Jun 2025 02:11:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535ef6edbesm50324365e9.20.2025.06.20.02.11.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Jun 2025 02:11:11 -0700 (PDT)
Message-ID: <3757d761-db62-4d22-b16e-c634f504bcb3@redhat.com>
Date: Fri, 20 Jun 2025 11:11:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/19] vfio-user client
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250619133154.264786-1-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250619133154.264786-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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

On 6/19/25 15:31, John Levon wrote:
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
> A functional test is still pending.
> 
> A previous version of this series can be found at
> https://lore.kernel.org/qemu-devel/20250607001056.335310-1-john.levon@nutanix.com/
> 
> Changes since last series:
> 
>   - the vfio-user client is now enabled by default, the configure option has been
>     removed
>   - the documentation has been relocated next to vhost-user's
>   - SocketAddress is now used for the command line parameter
>   - small bits of code review feedback
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
>   docs/interop/vfio-user.rst            | 1518 +++++++++++++++++++++++++
>   docs/system/device-emulation.rst      |    1 +
>   docs/system/devices/vfio-user.rst     |   24 +
>   meson.build                           |    1 +
>   hw/vfio-user/container.h              |   23 +
>   hw/vfio-user/device.h                 |   24 +
>   hw/vfio-user/protocol.h               |  242 ++++
>   hw/vfio-user/proxy.h                  |  134 +++
>   hw/vfio-user/trace.h                  |    1 +
>   hw/vfio/pci.h                         |    1 +
>   include/hw/vfio/vfio-container-base.h |    1 +
>   include/hw/vfio/vfio-device.h         |    2 +
>   hw/vfio-user/container.c              |  345 ++++++
>   hw/vfio-user/device.c                 |  387 +++++++
>   hw/vfio-user/pci.c                    |  475 ++++++++
>   hw/vfio-user/proxy.c                  | 1311 +++++++++++++++++++++
>   hw/Kconfig                            |    1 +
>   hw/meson.build                        |    1 +
>   hw/vfio-user/Kconfig                  |    5 +
>   hw/vfio-user/meson.build              |    9 +
>   hw/vfio-user/trace-events             |   18 +
>   23 files changed, 4535 insertions(+), 1 deletion(-)
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

John,

Please run ./scripts/checkpatch.pl and resend later on, as we might get
reviews. I still hope to have a test too.


Thanks,

C.



