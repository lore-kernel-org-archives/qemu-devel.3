Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA7DBC0219D
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 13:33:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thqNt-00083y-UI; Tue, 11 Feb 2025 08:33:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1thqNq-00083h-9i
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 08:33:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1thqNo-0007YR-PT
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 08:33:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739280779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+FaHkAG3brrOmH0uAyYUDAavNNR2klJ7+ZurSf9Gqcw=;
 b=NQ2VVCY8c1benxjXEkL9FzpI5nm/d91Z4p0wprae27YxwJ2SR1+H3UZccAG/h3L5SvJCbW
 MBVbCgT70BkpA+gtefygVW3JuWyRE6wL2ZR4xMTwR5WGxu/5GEZx232UgZ+35u/whIA6FS
 I90IwE08Jh9aL+x3Amc+lcTbATZa4lc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-NPecRjd3OsaEsqqoHWO8oQ-1; Tue, 11 Feb 2025 08:32:57 -0500
X-MC-Unique: NPecRjd3OsaEsqqoHWO8oQ-1
X-Mimecast-MFC-AGG-ID: NPecRjd3OsaEsqqoHWO8oQ
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4393182f0a6so13828415e9.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 05:32:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739280776; x=1739885576;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+FaHkAG3brrOmH0uAyYUDAavNNR2klJ7+ZurSf9Gqcw=;
 b=Rm7qwkA/XbQBwzGh/QJS5SpeqynevVwc2c63xGumVimtBqr/4JdadZSiiJmgNRm9KZ
 pSWeuMUenHKMQ0BZcwn+6Y7sVJjiN75sY0ODyUHFqinjqsTwZJjsmS5MO4VgNJ2u6/Zq
 nigQhIVDHMbPhxwedmrdCGkYsoPfYGAIEL15WyPK3+e+WNHkaSU71ZB6SBdJ37p9eLSd
 OAkhECu10EIGC52EXxP/tesrAG8KR9O5BKczaP0Zjbz2nrXLqeEqjdLpb2HTbVAsh0hn
 0S+6A0OtGykXj/CjXt8PsDv8ffb8lBg5Cl4d068x3OHYOKLdZIbwhPw3wGP38cjU1N9O
 WsHQ==
X-Gm-Message-State: AOJu0Yya+kp4HmDCwZlD24zbIbiDMrUzKbNwgYrhd/jCQtBCpbR47zBy
 7Kicr4Gbed7SYF/nhaQy+bNB+f0lgnvvhMUkZEssrusNRo36AfrgmsCqHb3V2yZG/x4GcF4190a
 EIl5Nrv8nY1Mi4oz/70wWKvqliTrOu956tUAkSA5qDo2mfyW3U27ENNTycOmW8MHlwshCB42mSM
 eew8fOMBdSKTFiG0NUk7TNDO+OfRqWhw==
X-Gm-Gg: ASbGncvnVNz251ZlQ+6nSaaf3QQyyTHIM5Drd9soq/bB2R3sJCiwt2qhHh7DmDIcaEa
 XEShCCVDyxrel6dUtrAWfc5mMRCGU8sYIxBPz54TrfttimeBkcYKK+OsQe3Iif3Wi8yTx0pJCyX
 e9DQLj6PFH2vzXhLS0otEoeI4dXZmhA0BByjZZQsHD+e3YwUss2iYGbd0RI8uCUvH4pk0lNov0Z
 APhUE8WJNugtOIiTgfUI9PwUt9qRUt5rYYilXwO1T3f+8R8YtjU9HmvziB4rzsUu4gxm15DZA47
 qOGdgRCouySd8t01EFtcyGVjTbZwZNXq4GMcOpivtFE=
X-Received: by 2002:a05:600c:4245:b0:436:1b77:b5aa with SMTP id
 5b1f17b1804b1-4394cebd103mr30446255e9.8.1739280776155; 
 Tue, 11 Feb 2025 05:32:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHY2zJ0BiDqQVhprYCZ6MulHLXilzkwRfQGL0zF+dSd8xf9OVdDVV41hIf/hVl5GEkx+Bc4+g==
X-Received: by 2002:a05:600c:4245:b0:436:1b77:b5aa with SMTP id
 5b1f17b1804b1-4394cebd103mr30446005e9.8.1739280775718; 
 Tue, 11 Feb 2025 05:32:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:ecac:5b28:cd98:868a?
 ([2a01:e0a:280:24f0:ecac:5b28:cd98:868a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd4d826c6sm9377924f8f.69.2025.02.11.05.32.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2025 05:32:55 -0800 (PST)
Message-ID: <7fa41dda-d0cf-490b-bf31-09985aca59b5@redhat.com>
Date: Tue, 11 Feb 2025 14:32:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] vfio: Improve error reporting when MMIO region
 mapping fails
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>
References: <20250206131438.1505542-1-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250206131438.1505542-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 2/6/25 14:14, Cédric Le Goater wrote:
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Hello,
> 
> Under certain circumstances, a MMIO region of a device fails to map
> because the region is outside the supported IOVA ranges of the VM. In
> this case, PCI peer-to-peer transactions on BARs are not supported.
> This typically occurs when the IOMMU address space width is less than
> the physical address width, as can be the case on some Intel consumer
> processors or when using a vIOMMU device with default settings.
> 
> This series tries to clarify the error message reported to the user.
> 
> Thanks,
> 
> C.
> 
> Changes in v3:
> 
>   - Fixed warn_report_err_once()
>   - Improved commit logs a bit
>   - Dropped check on compatibility of CPU and IOMMU address space
>     width. Will address later in its own series.
> 
> Changes in v2:
> 
>   - Removed advice on how to resolve the issue. Diagnostic is enough.
>   - Introduced helpers
>   - Checked device type, since this only applies to PCI
>   - Added cleanup
>   
> Cédric Le Goater (7):
>    util/error: Introduce warn_report_err_once()
>    vfio/pci: Replace "iommu_device" by "vIOMMU"
>    vfio: Rephrase comment in vfio_listener_region_add() error path
>    vfio: Introduce vfio_get_vfio_device()
>    vfio: Improve error reporting when MMIO region mapping fails
>    vfio: Remove reports of DMA mapping errors in backends
>    vfio: Remove superfluous error report in vfio_listener_region_add()
> 
>   include/hw/vfio/vfio-common.h |  1 +
>   include/qapi/error.h          | 12 +++++++++++
>   backends/iommufd.c            |  3 ---
>   hw/vfio/common.c              | 40 +++++++++++++++++++++++++----------
>   hw/vfio/container.c           |  2 --
>   hw/vfio/helpers.c             | 10 +++++++++
>   hw/vfio/pci.c                 |  2 +-
>   util/error.c                  | 11 ++++++++++
>   8 files changed, 64 insertions(+), 17 deletions(-)
> 


Applied to vfio-next.

Thanks,

C.



