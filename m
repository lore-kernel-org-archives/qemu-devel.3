Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCD9C44525
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 12:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viXfM-0002cs-QX; Wed, 21 Jan 2026 07:50:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1viXer-0002Eu-Qv
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 07:50:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1viXep-0002Bc-CS
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 07:50:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768999797;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vHKoWbVSlaEoA9TLXK/mcp3NsfvDU5iP0ZrSWefJUfU=;
 b=FtdfFO97byBLcYyRKgt/L7WKxNLJn09+npK7PV9QyX/K5sYf70oApRxWhkingmkm5Y47ca
 RYvK7qoYL5oUam1DHlQ2vV/oTBsWvY1XfBZ7ZH9V0qNZALgJoRyrWbulyBpuHJgv9HSn7T
 UU9hz5XB8g/K8bX15QsZi48BO/goa9o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-mbfkxOXqNd2lAVerwDHaeQ-1; Wed, 21 Jan 2026 07:49:54 -0500
X-MC-Unique: mbfkxOXqNd2lAVerwDHaeQ-1
X-Mimecast-MFC-AGG-ID: mbfkxOXqNd2lAVerwDHaeQ_1768999793
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-432c05971c6so718261f8f.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 04:49:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768999793; x=1769604593;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vHKoWbVSlaEoA9TLXK/mcp3NsfvDU5iP0ZrSWefJUfU=;
 b=ZyyGK+6hmGLXjjE48z7ZNNkefAx6jatWDxanWaOokvxVyFCRUxAR6KdgUEjybD5bnK
 HWCra2OSCVmSqEwv2pgExCekhc8Kg5lqGRhrhCly1W7WA+pt3qfjqfTM7Pm/7ih9IVDL
 hAy809YmTcBrCd4o7xGTJLGnyucB6gO7qTn7wUSdZC8Xe2WOlDeAO6MKqDwyrwee4BJG
 SUCpcsuoMuOFh02n93o1DwbCGQLBUz53FSDGZRqkRGvqfPxotfLlBiYkbmWo/UHa5WBj
 c8CS+7RCzRs2FOuLuSuuLao2CHBlVBPMK8acssdIETqvSq8CAvmWqdf3zwasoan3vck7
 mZ9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVSE0O7rkQ+5KCCc6aoIr51hbZjPBHAebR2Rt8KUIq9qtbjVj/afhzzh+wbucSfDxr7Ng4i0uzDsu8@nongnu.org
X-Gm-Message-State: AOJu0YxfHySGU0dXVc45xsDKhU2VqjHX97NE7+Nm7RDaA2WCisiyOpGz
 XqtaX+s7Hg/aqpN+lb5UBLotC/q3tlf8RyOl9yfvn7pKvlkVuGBYb07wfOvQ1zlDIEyAqnO+4nm
 2LvdVPjRnVnULfBTJQl7LdPGmd/o4SuERF/5RipDhHsyoTRjjMWFiGj2k
X-Gm-Gg: AZuq6aKykgJcVJoCQFAxWGYGxZ2UrTDWzD+PgVYKIcosUIko7NIM3UqTw1Ta4yasEDI
 sDyb/dt85TX99FRE84/QcTR82y6MYDwLOowP0mYbt/B/pVmMG9jRwZlUeD3CObLwYRAsgY5H9CS
 TEtCRPZIQDtgVW6T4Vbp8T9ZXzMk7zpmxr/u2gsU2m9XWLFbeR12sZKn0QKIUXRkoybNrxRU0S1
 OedpNzU80ekb6s4BfNJaSslfFPU/m2rHmePw29CAO0pmSP9oliX7g7hLPwEf437FdxWz2qgEC1U
 L7mHVE3vqPJw0FjEr+Q9FNRIBsGTiMOrfnNMKOO4K/jzt7UY/e0BKsh5VtKfHUdy27fNKamAJxY
 PnxLT40cVzbIfuvfWoCNPFRT1pXn+CPZzX7NxXRJLhQmnTbrB9Y2lvoP+Mw==
X-Received: by 2002:a05:6000:1acd:b0:435:9e32:2b85 with SMTP id
 ffacd0b85a97d-4359e32307fmr2934375f8f.29.1768999792990; 
 Wed, 21 Jan 2026 04:49:52 -0800 (PST)
X-Received: by 2002:a05:6000:1acd:b0:435:9e32:2b85 with SMTP id
 ffacd0b85a97d-4359e32307fmr2934339f8f.29.1768999792616; 
 Wed, 21 Jan 2026 04:49:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435a431c189sm256307f8f.24.2026.01.21.04.49.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jan 2026 04:49:52 -0800 (PST)
Message-ID: <b7d5721d-f6f3-43ea-b2cf-088d7bc5ec3b@redhat.com>
Date: Wed, 21 Jan 2026 13:49:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] vfio: Add DMABUF support for PCI BAR regions
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, cohuck@redhat.com, mst@redhat.com,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jgg@nvidia.com,
 jonathan.cameron@huawei.com, zhenzhong.duan@intel.com,
 vivek.kasireddy@intel.com, kjaju@nvidia.com
References: <20260121114111.34045-1-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260121114111.34045-1-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 1/21/26 12:41 PM, Shameer Kolothum wrote:
> Hi,
>
> Linux now provides a VFIO dmabuf exporter to expose PCI BAR memory for P2P
> use cases. This adds support for vfio devices to create a dmabuf for
> each mapped BAR region.
>
> Changes from v3:
>  https://lore.kernel.org/qemu-devel/20260116092950.15796-1-skolothumtho@nvidia.com/
>  
>  - Folded in patch #2 to linux-headers update to avoid bisect failure
>    due to build error.
>
> The dmabuf support was sanity tested on an NVIDIA grace paltform.
>
> Please take a look and let me know.
>
> Thanks,
> Shameer
>
> Nicolin Chen (1):
>   hw/vfio/region: Create dmabuf for PCI BAR per region
>
> Shameer Kolothum (2):
>   linux-headers: Update to Linux v6.19-rc1
>   hw/vfio: Add helper to retrieve device feature
>
>  hw/net/virtio-net.c                           |  11 +-
>  hw/vfio/container.c                           |   2 +-
>  hw/vfio/device.c                              |   9 ++
>  hw/vfio/listener.c                            |   4 +-
>  hw/vfio/region.c                              |  65 +++++++++-
>  hw/vfio/trace-events                          |   1 +
>  include/hw/vfio/vfio-device.h                 |   3 +
>  include/standard-headers/drm/drm_fourcc.h     |  25 ++--
>  include/standard-headers/linux/ethtool.h      |   5 +
>  .../linux/input-event-codes.h                 |  14 ++-
>  include/standard-headers/linux/pci_regs.h     |  89 ++++++++++++++
>  include/standard-headers/linux/virtio_net.h   |   3 +-
>  include/standard-headers/linux/virtio_pci.h   |   2 +-
>  linux-headers/asm-arm64/kvm.h                 |   2 +-
>  linux-headers/asm-arm64/unistd_64.h           |   1 +
>  linux-headers/asm-generic/unistd.h            |   4 +-
>  linux-headers/asm-loongarch/kvm.h             |   1 +
>  linux-headers/asm-loongarch/unistd.h          |   6 +
>  linux-headers/asm-loongarch/unistd_64.h       |   1 +
>  linux-headers/asm-mips/unistd_n32.h           |   1 +
>  linux-headers/asm-mips/unistd_n64.h           |   1 +
>  linux-headers/asm-mips/unistd_o32.h           |   1 +
>  linux-headers/asm-powerpc/unistd_32.h         |   1 +
>  linux-headers/asm-powerpc/unistd_64.h         |   1 +
>  linux-headers/asm-riscv/kvm.h                 |   3 +
>  linux-headers/asm-riscv/unistd_32.h           |   1 +
>  linux-headers/asm-riscv/unistd_64.h           |   1 +
>  linux-headers/asm-s390/bitsperlong.h          |   4 -
>  linux-headers/asm-s390/unistd.h               |   4 -
>  linux-headers/asm-s390/unistd_64.h            |   9 +-
>  linux-headers/asm-x86/kvm.h                   |   1 +
>  linux-headers/asm-x86/unistd_32.h             |   1 +
>  linux-headers/asm-x86/unistd_64.h             |   1 +
>  linux-headers/asm-x86/unistd_x32.h            |   1 +
>  linux-headers/linux/iommufd.h                 |  10 ++
>  linux-headers/linux/kvm.h                     |  11 ++
>  linux-headers/linux/mshv.h                    | 116 +++++++++++++++++-
>  linux-headers/linux/psp-sev.h                 |  66 ++++++----
>  linux-headers/linux/vfio.h                    |  28 +++++
>  39 files changed, 450 insertions(+), 60 deletions(-)
>
For the whole series:

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric


