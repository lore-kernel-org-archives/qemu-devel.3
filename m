Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87462C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 08:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWAw7-0006cd-Ph; Tue, 23 Jul 2024 04:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sWAvv-0006Z0-DJ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:31:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sWAvs-0002GF-Qb
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721723496;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/qmr5qSrBZ6TnpL+CuUCxr4sdnsirmzJ/74xLXvxHCQ=;
 b=P766gXLzApw6yawLgk9USPzsdyCkt6lOdv9217tVE8p5ci33/Zf9E9bBlKdTEN18WHVy/o
 0omHVcYp1xNixNH49ytbJYuruTu87OQogF2gaM2vZkwY6o1VINt+6dQaegZzYKlcNKehRl
 XMmfNcY+U7NnnvvIK3vRwovPAITLsbk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-ot1e28PzPRedlxF2xvpfDg-1; Tue, 23 Jul 2024 04:31:32 -0400
X-MC-Unique: ot1e28PzPRedlxF2xvpfDg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3687f5a2480so3018285f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 01:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721723492; x=1722328292;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/qmr5qSrBZ6TnpL+CuUCxr4sdnsirmzJ/74xLXvxHCQ=;
 b=rtfh0M2CCUqS4O+MKN4PIdu6uvUUM+MnDl+60XUMgrHjcoCO+l1ZrRJesaFd61PMTp
 jK8I5LPYn1d3jiUn+0Q6OhK6g4WirpiZda4GTIRE+yAg4Yj5kHZMoD1wv0uOuB+2u+2V
 QrUmBIcCUhQnsF7utOZOyrZR3mmN68GRHcSu3KaLTJxt2vKVCBe/lSec/Xy/FZtsbnSW
 HqwpW7Z7pBkjMC6RgVyC/DrycDmpoDXerFMNgkpM2o6PBvJxYmKa/KRPi+cvdV2ySIQy
 LvhcS6/E4o60M1421GPTcnLhFmsTCYZpPnl/XC4ypnbFMcp/HnThV7Toe/JaEyJwCHMY
 PMZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2sR+dw4/gnfakDlvwCV+2bzZvS5757kSYFVqBJL1JwwviNQFS3GDt0kSp/BJmCsQ7WG6/mk7v+qjpti1wWgKKmyfjStc=
X-Gm-Message-State: AOJu0Yy4O5c4hVpB8+SaezLmfC1Tr14nELY+Wi2dJoKftg1MnqSWDUan
 CEp20jUlokH994YeP2mtALOOLMX8t6ZePyiBmrankKjpmKs99GsXgr6WZfBbRNn8iN29/tKUxaw
 iJZU6TVOeqhg6kRVGWPM8wbCu7PoL6t3l8DqbrpLE1n8sxl8MBVCP
X-Received: by 2002:a05:6000:154d:b0:368:4e2e:7596 with SMTP id
 ffacd0b85a97d-369dec1e50cmr2338296f8f.37.1721723491650; 
 Tue, 23 Jul 2024 01:31:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv51reHqk8FmCCJ8ZMhwHhhl7QxmSUgJZw/L18Jl5rp1ISnJzFhYnz3gXKoddzgoyWm2Nm9Q==
X-Received: by 2002:a05:6000:154d:b0:368:4e2e:7596 with SMTP id
 ffacd0b85a97d-369dec1e50cmr2338271f8f.37.1721723491243; 
 Tue, 23 Jul 2024 01:31:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684801sm10781098f8f.11.2024.07.23.01.31.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 01:31:30 -0700 (PDT)
Message-ID: <787e5d32-652c-4663-8a03-ce9b6f1a66ce@redhat.com>
Date: Tue, 23 Jul 2024 10:31:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 9/9] vfio/common: Allow disabling device dirty page
 tracking
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
 <20240722211326.70162-10-joao.m.martins@oracle.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240722211326.70162-10-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/22/24 23:13, Joao Martins wrote:
> The property 'x-pre-copy-dirty-page-tracking' allows disabling the whole
> tracking of VF pre-copy phase of dirty page tracking, though it means
> that it will only be used at the start of the switchover phase.
>
> Add an option that disables the VF dirty page tracking, and fall
> back into container-based dirty page tracking. This also allows to
> use IOMMU dirty tracking even on VFs with their own dirty
> tracker scheme.

Forced ON value isn't really meaningful though. I mean only valid values
are AUTO and OFF, correct?

Eric
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  include/hw/vfio/vfio-common.h | 1 +
>  hw/vfio/common.c              | 3 +++
>  hw/vfio/migration.c           | 4 +++-
>  hw/vfio/pci.c                 | 3 +++
>  4 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 1e02c98b09ba..fed499b199f0 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -138,6 +138,7 @@ typedef struct VFIODevice {
>      VFIOMigration *migration;
>      Error *migration_blocker;
>      OnOffAuto pre_copy_dirty_page_tracking;
> +    OnOffAuto device_dirty_page_tracking;
>      bool dirty_pages_supported;
>      bool dirty_tracking;
>      bool iommu_dirty_tracking;
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index da12cbd56408..36d0cf6585b2 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -199,6 +199,9 @@ bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer)
>      VFIODevice *vbasedev;
>  
>      QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
> +        if (vbasedev->device_dirty_page_tracking == ON_OFF_AUTO_OFF) {
> +            return false;
> +        }
>          if (!vbasedev->dirty_pages_supported) {
>              return false;
>          }
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index cbfaef7afffe..262d42a46e58 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -1036,7 +1036,9 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>          return !vfio_block_migration(vbasedev, err, errp);
>      }
>  
> -    if (!vbasedev->dirty_pages_supported && !vbasedev->iommu_dirty_tracking) {
> +    if ((!vbasedev->dirty_pages_supported ||
> +         vbasedev->device_dirty_page_tracking == ON_OFF_AUTO_OFF) &&
> +        !vbasedev->iommu_dirty_tracking) {
>          if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO) {
>              error_setg(&err,
>                         "%s: VFIO device doesn't support device and "
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 8c0f212a163e..a0767de54b8d 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3364,6 +3364,9 @@ static Property vfio_pci_dev_properties[] = {
>      DEFINE_PROP_ON_OFF_AUTO("x-pre-copy-dirty-page-tracking", VFIOPCIDevice,
>                              vbasedev.pre_copy_dirty_page_tracking,
>                              ON_OFF_AUTO_ON),
> +    DEFINE_PROP_ON_OFF_AUTO("x-device-dirty-page-tracking", VFIOPCIDevice,
> +                            vbasedev.device_dirty_page_tracking,
> +                            ON_OFF_AUTO_ON),
>      DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
>                              display, ON_OFF_AUTO_OFF),
>      DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),


