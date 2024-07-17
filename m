Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD61C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 12:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU3dR-0008MA-Jf; Wed, 17 Jul 2024 08:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sU3dO-0008FW-Qy
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 08:19:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sU3dM-0000tz-LS
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 08:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721218786;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2wCUyz8MS1RSEczJaZkFxh9bu1fvYy48TPOGIcx9XLw=;
 b=aaIQUMzg81eCw9pKRQonmf+XkTT+4G/gvSILLaRUAGbAilR0m5XnBYab1AvjR+K57SRYdT
 iaGQCzC0QXIijnLSjcvgU9DfnZ82qIzD2akUkOJ7oLFaiaD+lvK4GChfNYtnl6nLUY8Pu/
 5CLrMVEfviDLhpWuTnRVNn8SIMw3aOM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-wi_L3Bm_PdirCZvHRG8KOw-1; Wed, 17 Jul 2024 08:19:45 -0400
X-MC-Unique: wi_L3Bm_PdirCZvHRG8KOw-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-447f84aadc1so85468891cf.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 05:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721218785; x=1721823585;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2wCUyz8MS1RSEczJaZkFxh9bu1fvYy48TPOGIcx9XLw=;
 b=kbGy/yXXKo8weEcmGMRfdqrA4EJB1+sXel7qWaBuJ9QsVTrKYyCWqrKd1Vd/VW8JIv
 zJBqxBDJCD1MGxnL6poHASKC+06JsnGlInvy5u3WFxSd0l0w4FOrBHZdiXHTCCLOCLFy
 Q5/tMXe2NJ19MXD7dSqbakdlcgFWTTFqgOXXR7po03IZzZe25sdqzCrD1PhWn9M6r7MF
 GC17l1fzeUFjaoRXKCciElQ5d7U/jURiboA2J+W8FDZ4SNGJAnyVmjE4kj99QCh6FTzC
 tHl9H3ctC0x92Cwwx5M+C4cOgJ4ko1RWz8mltq2dHYn9sQ+ncM2szwESP8YuSB3vZA5+
 Yifg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwhMe/DMDYX6iXBREo3lGKuZWIk3doYeb/mBCDUOlHrWZ7MvFmxTPb7fwl7fvKL+DUpRev2hGw8wHQpjK10pDn6Bvm5ys=
X-Gm-Message-State: AOJu0YxyHh+YRv8SQ9piUOejsi9v/Exp+lRMRprLrgavmHPfHRr5fAON
 URPo//viq5qL/gClGmge87321r8pZ0H5HntKUYYFzaVTJjGWYpm76k8us83FPGNpWFUOHkt1knu
 vAwsJ+wOZtBASQ83mRzcphM590yZkr46OgCHTipx/lsr+RdoEj7e7
X-Received: by 2002:a05:622a:44b:b0:446:4730:f1a4 with SMTP id
 d75a77b69052e-44f86e6391dmr17782731cf.58.1721218785019; 
 Wed, 17 Jul 2024 05:19:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECRl9xcGeiSiuWj/TF1FvnIbg5PKmLGMyo5e/35agR1oFo6k2Zqdpiywv1whqBkgAcfwtdMA==
X-Received: by 2002:a05:622a:44b:b0:446:4730:f1a4 with SMTP id
 d75a77b69052e-44f86e6391dmr17782491cf.58.1721218784599; 
 Wed, 17 Jul 2024 05:19:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44f5b7e32ffsm46756711cf.24.2024.07.17.05.19.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 05:19:43 -0700 (PDT)
Message-ID: <6b67c303-774a-44cb-bbe0-24df973ab889@redhat.com>
Date: Wed, 17 Jul 2024 14:19:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/12] vfio/{iommufd,container}: Initialize
 HostIOMMUDeviceCaps during attach_device()
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-8-joao.m.martins@oracle.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240712114704.8708-8-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Joao,

On 7/12/24 13:46, Joao Martins wrote:
> Fetch IOMMU hw raw caps behind the device and thus move the
what does mean "Fetch IOMMU hw raw caps behind the device'"
> HostIOMMUDevice::realize() to be done during the attach of the device. It
> allows it to cache the information obtained from IOMMU_GET_HW_INFO from
what do you mean by " It allows it to cache the information obtained
from IOMMU_GET_HW_INFO from iommufd early on"
> iommufd early on. However, while legacy HostIOMMUDevice caps
what does mean "legacy HostIOMMUDevice caps always return true"?
> always return true and doesn't have dependency on other things, the IOMMUFD
> backend requires the iommufd FD to be connected and having a devid to be
> able to query capabilities. Hence when exactly is HostIOMMUDevice
> initialized inside backend ::attach_device() implementation is backend
> specific.
>
> This is in preparation to fetch parse hw capabilities and understand if
fetch parse?
> dirty tracking is supported by device backing IOMMU without necessarily
> duplicating the amount of calls we do to IOMMU_GET_HW_INFO.
But we move code from generic place to BE specific place?

Sorry I feel really hard to understand the commit msg in general

Eric


>
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  include/sysemu/host_iommu_device.h |  1 +
>  hw/vfio/common.c                   | 16 ++++++----------
>  hw/vfio/container.c                |  6 ++++++
>  hw/vfio/iommufd.c                  |  7 +++++++
>  4 files changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
> index 20e77cf54568..b1e5f4b8ac3e 100644
> --- a/include/sysemu/host_iommu_device.h
> +++ b/include/sysemu/host_iommu_device.h
> @@ -24,6 +24,7 @@
>   */
>  typedef struct HostIOMMUDeviceCaps {
>      uint32_t type;
> +    uint64_t hw_caps;
please also update the doc comment
>  } HostIOMMUDeviceCaps;
>  
>  #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index b0beed44116e..cc14f0e3fe24 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1544,7 +1544,7 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>  {
>      const VFIOIOMMUClass *ops =
>          VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
> -    HostIOMMUDevice *hiod;
> +    HostIOMMUDevice *hiod = NULL;
>  
>      if (vbasedev->iommufd) {
>          ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
> @@ -1552,21 +1552,17 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>  
>      assert(ops);
>  
> -    if (!ops->attach_device(name, vbasedev, as, errp)) {
> -        return false;
> -    }
>  
> -    if (vbasedev->mdev) {
> -        return true;
> +    if (!vbasedev->mdev) {
> +        hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
> +        vbasedev->hiod = hiod;
>      }
>  
> -    hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
> -    if (!HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
> +    if (!ops->attach_device(name, vbasedev, as, errp)) {
>          object_unref(hiod);
> -        ops->detach_device(vbasedev);
> +        vbasedev->hiod = NULL;
>          return false;
>      }
> -    vbasedev->hiod = hiod;
>  
>      return true;
>  }
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index c27f448ba26e..29da261bbf3e 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -907,6 +907,7 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
>                                        AddressSpace *as, Error **errp)
>  {
>      int groupid = vfio_device_groupid(vbasedev, errp);
> +    HostIOMMUDevice *hiod = vbasedev->hiod;
>      VFIODevice *vbasedev_iter;
>      VFIOGroup *group;
>      VFIOContainerBase *bcontainer;
> @@ -917,6 +918,11 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
>  
>      trace_vfio_attach_device(vbasedev->name, groupid);
>  
> +    if (hiod &&
> +        !HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
> +        return false;
> +    }
> +
>      group = vfio_get_group(groupid, as, errp);
>      if (!group) {
>          return false;
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 873c919e319c..d34dc88231ec 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -384,6 +384,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>      Error *err = NULL;
>      const VFIOIOMMUClass *iommufd_vioc =
>          VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
> +    HostIOMMUDevice *hiod = vbasedev->hiod;
>  
>      if (vbasedev->fd < 0) {
>          devfd = iommufd_cdev_getfd(vbasedev->sysfsdev, errp);
> @@ -401,6 +402,11 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>  
>      space = vfio_get_address_space(as);
>  
> +    if (hiod &&
> +        !HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
> +        return false;
> +    }
> +
>      /* try to attach to an existing container in this space */
>      QLIST_FOREACH(bcontainer, &space->containers, next) {
>          container = container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
> @@ -722,6 +728,7 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>  
>      hiod->name = g_strdup(vdev->name);
>      caps->type = type;
> +    caps->hw_caps = hw_caps;
>  
>      return true;
>  }


