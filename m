Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588FCC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 16:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJF8T-0005I0-QU; Mon, 17 Jun 2024 12:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sJF8R-0005GY-69
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 12:23:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sJF8P-0002rp-BP
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 12:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718641387;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v2/3hXpjiHtV6yuTWreuT55nosg1/FSqeQydUfwQ1zQ=;
 b=TFBC7pESPFOEhMVf/mH6TKegVkF++i45bK6kR9Tql8Qvsi3r/YARXkss4Vg0EkSIEfErzP
 k1LdxY6Swa6ngZUu/3aRuwPCykIe3B/hrHCPFio2efExsKwgKdP6QSZfQ60QyXSjCSsPnP
 Ye4KZ2XfkbnoX9TYBF2O4tYKwobmnTA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-6bqih-VjMravTX0ltNDlHQ-1; Mon, 17 Jun 2024 12:23:02 -0400
X-MC-Unique: 6bqih-VjMravTX0ltNDlHQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6b06f5e35b0so82132296d6.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 09:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718641382; x=1719246182;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v2/3hXpjiHtV6yuTWreuT55nosg1/FSqeQydUfwQ1zQ=;
 b=lHaicGqzHeUp1a1/dOrht/sj7savA7raDq97jr6QJ7DvZ+G4IoPFNnRcAG+G4cdPzV
 EaNMboobyG3KZrhjMXScC7Rc+fxcUoTwoxD/W8+vR8TVxbEPStThte5OHC1fDv7xJOuM
 x8AJYZpCg2yRAlOCAuV1+6YVFVI9tYQAWm6GdeldEIcU9aLqgWu1g88LTC8dGxlyJ1BG
 Jxhe02pDEP10y48xfjFc8r+fNc3lSehuS0SM81bPds7h8qJnfNUQigRnLnns7r+qRZAd
 PKqMK5ES0GZEvMOe/CQCISSp1WjqKpEXjPaT2U5QYQ9aYIhGL+Xij5+2dgzPSM57c2CY
 lYrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF3vOQP6TtmUVRXfQP5tDLTXWqV7lmgmET77WZhUDIUqJ7Zfe91nHjV231PLi4qR2jv11rovMYhamosngRAgMShb4tYqE=
X-Gm-Message-State: AOJu0YycIsbODwWCndtNEnzcxJ54d5tG6fxRKpKPJNIcEduL5hq0cVZj
 +6fyLcOP5hInqA89IJSxQ8r3uxKfLCq+SDyTVESnwpJdRiUp5gWYQbjtIPa8t0DzF8CufErIPdZ
 QCLYav9TYoX3utfD1MkI0bpmoj7AMW7kwBUYX1aBMEm8BHL1aQMqc
X-Received: by 2002:ad4:40c1:0:b0:6b2:dc61:c8bd with SMTP id
 6a1803df08f44-6b2e2330cddmr2093326d6.27.1718641381660; 
 Mon, 17 Jun 2024 09:23:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn1FeQWfPMR5CinJ2+S37htF4blhbdZfCpIU7lFNTRkg+KQwOox40kXJK03mFdf7ihf7Nbxw==
X-Received: by 2002:ad4:40c1:0:b0:6b2:dc61:c8bd with SMTP id
 6a1803df08f44-6b2e2330cddmr2092996d6.27.1718641381323; 
 Mon, 17 Jun 2024 09:23:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b2aa669db4sm53335926d6.51.2024.06.17.09.22.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 09:23:00 -0700 (PDT)
Message-ID: <f419417d-2346-4cfa-a7e4-068946d4bafc@redhat.com>
Date: Mon, 17 Jun 2024 18:22:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] vfio: QOMify VFIOContainer
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240617063409.34393-1-clg@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240617063409.34393-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Cédric,

On 6/17/24 08:33, Cédric Le Goater wrote:
> Hello,
>
> The series starts with simple changes (patch 1-4). Two of which were
> initially sent by Joao in a series adding VFIO migration support with
> vIOMMU [1].
>
> The changes following prepare VFIOContainer for QOMification, switch
> the container models to QOM when ready and add some final cleanups.
>
> Applies on top of :
>
>  * [v7] Add a host IOMMU device abstraction to check with vIOMMU
>    https://lore.kernel.org/all/20240605083043.317831-1-zhenzhong.duan@intel.com
>  * [v4] VIRTIO-IOMMU/VFIO: Fix host iommu geometry
>    https://lore.kernel.org/all/20240614095402.904691-1-eric.auger@redhat.com

For the whole series, feel free to add my

Tested-by: Eric Auger <eric.auger@redhat.com>

I tested with legacy/iommufd BE and with/without virtio-iommu

Eric

>
> Thanks,
>
> C.
>
> [1] https://lore.kernel.org/qemu-devel/20230622214845.3980-1-joao.m.martins@oracle.com/
>
>
> Changes in v2:
>  - Used OBJECT_DECLARE_SIMPLE_TYPE
>  - Introduced a instance_finalize() handler
>
> Avihai Horon (1):
>   vfio/common: Extract vIOMMU code from vfio_sync_dirty_bitmap()
>
> Cédric Le Goater (15):
>   vfio: Make vfio_devices_dma_logging_start() return bool
>   vfio: Remove unused declarations from vfio-common.h
>   vfio/container: Introduce vfio_address_space_insert()
>   vfio/container: Simplify vfio_container_init()
>   vfio/container: Modify vfio_get_iommu_type() to use a container fd
>   vfio/container: Introduce vfio_get_iommu_class_name()
>   vfio/container: Introduce vfio_create_container()
>   vfio/container: Discover IOMMU type before creating the container
>   vfio/container: Change VFIOContainerBase to use QOM
>   vfio/container: Switch to QOM
>   vfio/container: Introduce an instance_init() handler
>   vfio/container: Remove VFIOContainerBase::ops
>   vfio/container: Remove vfio_container_init()
>   vfio/container: Introduce vfio_iommu_legacy_instance_init()
>   vfio/container: Move vfio_container_destroy() to an
>     instance_finalize() handler
>
> Joao Martins (1):
>   vfio/common: Move dirty tracking ranges update to helper
>
>  include/hw/vfio/vfio-common.h         |  10 ++-
>  include/hw/vfio/vfio-container-base.h |  19 +---
>  hw/vfio/common.c                      | 124 ++++++++++++++++----------
>  hw/vfio/container-base.c              |  70 +++++++++------
>  hw/vfio/container.c                   | 106 ++++++++++++----------
>  hw/vfio/iommufd.c                     |  13 ++-
>  hw/vfio/pci.c                         |   4 +-
>  hw/vfio/spapr.c                       |   3 +
>  8 files changed, 196 insertions(+), 153 deletions(-)
>


