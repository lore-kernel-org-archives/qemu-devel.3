Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDD9C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 07:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWAIg-0000WK-MB; Tue, 23 Jul 2024 03:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sWAIf-0000SZ-70
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:51:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sWAId-0002Cb-Kv
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721721067;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YwLiV12ylPGbOLwUZE8EcVBmWZ5Ndxf+H7BAEMU81VQ=;
 b=K9ywCSDMGttsfZiuuxQrVwB8re2ZGa4hfhOnZoVNhPPbnNX6yNBi+wAh2EGqsuft+5NBYC
 D7cS8+xse49UxElzxijE1fxCFLPoaTwoWeRlBIKtRUvr+RKSC/qOBOag/kSy+DokEvPYuG
 tuCjw6Zlkxuh2ZmqfdawgJoNgS8GM8Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-URwvGjIeMVSOMRDIkj0mvw-1; Tue, 23 Jul 2024 03:51:02 -0400
X-MC-Unique: URwvGjIeMVSOMRDIkj0mvw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-427b57e3c6fso36751625e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 00:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721721061; x=1722325861;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YwLiV12ylPGbOLwUZE8EcVBmWZ5Ndxf+H7BAEMU81VQ=;
 b=p0d3ZBrPcbkUltyeZPwPVcZIj43QDEANfyAUtwVdtqqYJJulH9QjXE8wESN3PeVN4m
 RAT25uQYxC97G7dJo52LXmB8IQ+q7XzeZByUVQTYx3ZKmcPl3jkss019E19ZRZC+qkpS
 tn1jlAncgNa5SX0VIFqMbc/rYDUu6mWLrjFIeBFizVAhg4yUaatoFXTgGyMRX36wTBQS
 yPJQpQyHIEOZM5dtol42XpoMIRBlv82ZdoM3UMIs72L2ZLW6e2/Kmaut//LaBYzb6gwM
 HIdm/HIMS9sdbGrk0P4m1L+j8s/aaOh/buoP7lbNvN3QAFST0mEOnPzRlnDqXIq26HYi
 rkqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp+QTBTccA5f1fdks7JAZlsllb3iOdqRuskG1yvfRyFWtzhGLhs6kmxNDmze2yMktEgTIB88pXu2FK+7u8DJsV6TovjKg=
X-Gm-Message-State: AOJu0YzkTbVTZC8hf5r4JLH2Rxa59GjwEUa0S7owjrvIrxuYXgEpxZlt
 6tvz8gVjtt13EQHDMbS6lpmUH9D4EOUyJkaZULgbwrysGH9h+LHBjw7TVK7w80qK3l5h/FmLtQj
 P0JvxVJTvp6yujIGP8KNW3vTKe7cEGaTXBP0WoIrzOPi0MPrqgO2H
X-Received: by 2002:a05:600c:220f:b0:426:59ec:17a9 with SMTP id
 5b1f17b1804b1-427dc55a20bmr69171615e9.22.1721721060827; 
 Tue, 23 Jul 2024 00:51:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOK1fFF2786/TjiAVzVcnhHq3GvtI0WloxBHLmT17WQfyHjEEyvMY8ASzGeErZK/k/rmymHQ==
X-Received: by 2002:a05:600c:220f:b0:426:59ec:17a9 with SMTP id
 5b1f17b1804b1-427dc55a20bmr69171365e9.22.1721721060324; 
 Tue, 23 Jul 2024 00:51:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d68fa9b1sm161352735e9.8.2024.07.23.00.50.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 00:50:59 -0700 (PDT)
Message-ID: <2fd72e9b-c3b1-488c-a532-546ddf3612e0@redhat.com>
Date: Tue, 23 Jul 2024 09:50:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/9] vfio/iommufd: Probe and request hwpt dirty
 tracking capability
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
 <20240722211326.70162-6-joao.m.martins@oracle.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240722211326.70162-6-joao.m.martins@oracle.com>
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

Hi Joao,

On 7/22/24 23:13, Joao Martins wrote:
> In preparation to using the dirty tracking UAPI, probe whether the IOMMU
> supports dirty tracking. This is done via the data stored in
> hiod::caps::hw_caps initialized from GET_HW_INFO.
>
> Qemu doesn't know if VF dirty tracking is supported when allocating
> hardware pagetable in iommufd_cdev_autodomains_get(). This is because
> VFIODevice migration state hasn't been initialized *yet* hence it can't pick
> between VF dirty tracking vs IOMMU dirty tracking. So, if IOMMU supports
> dirty tracking it always creates HWPTs with IOMMU_HWPT_ALLOC_DIRTY_TRACKING
> even if later on VFIOMigration decides to use VF dirty tracking instead.
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  include/hw/vfio/vfio-common.h |  2 ++
>  hw/vfio/iommufd.c             | 20 ++++++++++++++++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 4e44b26d3c45..1e02c98b09ba 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -97,6 +97,7 @@ typedef struct IOMMUFDBackend IOMMUFDBackend;
>  
>  typedef struct VFIOIOASHwpt {
>      uint32_t hwpt_id;
> +    uint32_t hwpt_flags;
>      QLIST_HEAD(, VFIODevice) device_list;
>      QLIST_ENTRY(VFIOIOASHwpt) next;
>  } VFIOIOASHwpt;
> @@ -139,6 +140,7 @@ typedef struct VFIODevice {
>      OnOffAuto pre_copy_dirty_page_tracking;
>      bool dirty_pages_supported;
>      bool dirty_tracking;
> +    bool iommu_dirty_tracking;
>      HostIOMMUDevice *hiod;
>      int devid;
>      IOMMUFDBackend *iommufd;
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 2324bf892c56..7afea0b041ed 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -110,6 +110,11 @@ static void iommufd_cdev_unbind_and_disconnect(VFIODevice *vbasedev)
>      iommufd_backend_disconnect(vbasedev->iommufd);
>  }
>  
> +static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
> +{
> +    return hwpt && hwpt->hwpt_flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
> +}
> +
>  static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
>  {
>      ERRP_GUARD();
> @@ -246,6 +251,17 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>          }
>      }
>  
> +    /*
> +     * This is quite early and VFIO Migration state isn't yet fully
> +     * initialized, thus rely only on IOMMU hardware capabilities as to
> +     * whether IOMMU dirty tracking is going to be requested. Later
> +     * vfio_migration_realize() may decide to use VF dirty tracking
> +     * instead.
> +     */
> +    if (vbasedev->hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
> +        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
> +    }
> +
>      if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>                                      container->ioas_id, flags,
>                                      IOMMU_HWPT_DATA_NONE, 0, NULL,
> @@ -255,6 +271,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>  
>      hwpt = g_malloc0(sizeof(*hwpt));
>      hwpt->hwpt_id = hwpt_id;
> +    hwpt->hwpt_flags = flags;
>      QLIST_INIT(&hwpt->device_list);
>  
>      ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
> @@ -265,8 +282,11 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>      }
>  
>      vbasedev->hwpt = hwpt;
> +    vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
>      QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>      QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
> +    container->bcontainer.dirty_pages_supported |=
> +                                vbasedev->iommu_dirty_tracking;
Is it possible to have several devices with different

iommu_dirty_tracking value in the same container? In other words would they be attached to different container/ioas?

Eric

>      return true;
>  }
>  


