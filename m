Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F57E9B265
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 13:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vusqJ-0007U3-3O; Tue, 24 Feb 2026 08:52:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vusqG-0007TZ-N9
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 08:52:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vusqD-0000YM-H0
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 08:52:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771941163;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lt8BBNz8s0SpZbq73sqRpE3xZ8Z+U0PvjqMyHfQe41o=;
 b=LGyKDmEebLQnQH0NKI1OxfwxiKBi2MIzerma2rh0TNopD0RQ+Bik3UNv7MAPgnWqNIOyx8
 dvNZ2pt49zG3BLqJoDg5ywnzwmmwKHWz6ilGdyQg4URQltdI8Kd2crmEqeLNPd1MrSwFBq
 D5n3H1uTy/fadkQFm6jOty92K5jJ9F8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-Gnc7Jpl6PcOJzLHb1M7vwQ-1; Tue, 24 Feb 2026 08:52:42 -0500
X-MC-Unique: Gnc7Jpl6PcOJzLHb1M7vwQ-1
X-Mimecast-MFC-AGG-ID: Gnc7Jpl6PcOJzLHb1M7vwQ_1771941161
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-483a2db68caso43614465e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 05:52:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771941161; x=1772545961;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lt8BBNz8s0SpZbq73sqRpE3xZ8Z+U0PvjqMyHfQe41o=;
 b=I2numbAS+AvW3VO26veeLdHSWBbxcs3qXtb0ewWbojgvKfJBTgH6J5gHglMXjnwfYR
 tqLZA1PlmiselIhC9MDRAewZfbTcf6/zSSqoJmysoOrVXIAzF/63O8yiJXW66RnxWY4b
 KDdTtXuHHJyKWq2sLSyoYYLVqKmpkizcowCS++BTtqh4dqJ0JYYdFIgulnLl1P0q3NJy
 7Tj/dIrZqSiYLvS4vo+b5+OuQVx9sZrA3qoA6pYzGmMNiQqYp9c0bOPjuT13oc8i9aZ7
 GYbhZmL2HQnWr5CFFwupjYxphcaHKIqhfeUcYgv/qspn6yCqG04NZHjIlHXx8Anz0zmh
 1lfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWz+FtYagd6hEcK0D5bYuNN6SFI11ONAdFOdaJu7e3YFMJYTS9GDKf26NAgV3ycMAjwoErtFUAT1bV3@nongnu.org
X-Gm-Message-State: AOJu0YxjCuzATncaUNSkrJo3aRUT10fRY/RiYQEQ2YWyIpy7djYvufRN
 KirGi2CM650yvP+skoMe8ARzs+1jwO5lo91M+wnTmX1WhKvYKaQBarX8NowZqzjUdwPICH+8Olp
 N2p26oLZ5l7IiDOyoyw+OR61+1Rn2uCUe6T1w/66P5hMh/zUddwgcJsbv
X-Gm-Gg: AZuq6aKStlQQWIKxueKu5oo1fdM245WS/BYDa4aahVGKJOwkKtfA+UZPo7xsiSIw45r
 RP0YDSolFU8UkM+7FHGAobe1ya/C14hgwUoVaRlOSwr+NVDgGL9XeflGiduLUjUgsbYtg447mkL
 zNpdMoFALyaeQzSAh/GxLgtwiflwgIO9JTrtzyFFQx2hRG62yBTImtlYHeZetD7pgOH+rU0F31d
 uQ40lzqIIr7YbwUJozFQHkPx1QGQfiJ5Lte1toyOHyUOE1RoOyMp4LUh9o+xeff3wG6eTj58C4y
 isgS90vFw+V/H6Hpf29gVkrcg+ZSJGWvYab6yMvgj0AUvRdtf6Kj0lX8yk1JG/jpOaXUGY8OSBf
 xMkUKZc9oYIlAQEKNuzRyDS34sqdTbn+YY/2LELonCYADi/c8aRkG7cJw3XRtXe9mjEpgsQ==
X-Received: by 2002:a05:600c:3484:b0:483:3380:ca11 with SMTP id
 5b1f17b1804b1-483a95ee3fdmr179355935e9.33.1771941161180; 
 Tue, 24 Feb 2026 05:52:41 -0800 (PST)
X-Received: by 2002:a05:600c:3484:b0:483:3380:ca11 with SMTP id
 5b1f17b1804b1-483a95ee3fdmr179355665e9.33.1771941160689; 
 Tue, 24 Feb 2026 05:52:40 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6854c7sm4260105e9.0.2026.02.24.05.52.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 05:52:40 -0800 (PST)
Message-ID: <b362122e-f46a-4298-874c-63b76cb62489@redhat.com>
Date: Tue, 24 Feb 2026 14:52:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/5] vEVENTQ support for accelerated SMMUv3 devices
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nicolinc@nvidia.com, nathanc@nvidia.com,
 mochs@nvidia.com, jan@nvidia.com, jgg@nvidia.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, kjaju@nvidia.com
References: <20260219090103.33697-1-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260219090103.33697-1-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

Hi,

On 2/19/26 10:00 AM, Shameer Kolothum wrote:
> Hi,
>
> Changes from v6:
>  https://lore.kernel.org/qemu-devel/20260213103942.142823-1-skolothumtho@nvidia.com/
>  
>  -Addressed feedback and picked up R-by/T-by tags. Thanks!
>  -Updated error report (patch #3)
>
> Please take a look and let me know.
Thanks Shameer, this looks ready now!

Feel free to grab my

Tested-by: Eric Auger <eric.auger@redhat.com>

Eric
>
> Thanks,
> Shameer
>
> ---
> Background(From v2):
>
> When accel=on is enabled for an SMMUv3 instance, the host hardware SMMUv3
> may generate Stage-1 (S1) event notifications that are intended for the
> vIOMMU instance in userspace.
>
> This series adds QEMU support for receiving such host events through the
> vEVENTQ interface and propagating them to the guest. The implementation
> uses the vEVENTQ support provided by the IOMMUFD subsystem in the kernel.
>
> I have tested this on a Grace platform using some hacks to generate
> events. Further testing and feedback are welcome.
> ---
>
>
> Nicolin Chen (2):
>   backends/iommufd: Introduce iommufd_backend_alloc_veventq
>   hw/arm/smmuv3-accel: Allocate vEVENTQ for accelerated SMMUv3 devices
>
> Shameer Kolothum (3):
>   hw/arm/smmuv3-accel: Add viommu free helper
>   hw/arm/smmuv3: Introduce a helper function for event propagation
>   hw/arm/smmuv3-accel: Read and propagate host vIOMMU events
>
>  hw/arm/smmuv3-accel.h    |   6 ++
>  hw/arm/smmuv3-internal.h |   4 ++
>  include/system/iommufd.h |  14 ++++
>  backends/iommufd.c       |  31 +++++++++
>  hw/arm/smmuv3-accel.c    | 146 ++++++++++++++++++++++++++++++++++++---
>  hw/arm/smmuv3.c          |  26 +++++--
>  backends/trace-events    |   1 +
>  hw/arm/trace-events      |   2 +-
>  8 files changed, 215 insertions(+), 15 deletions(-)
>


