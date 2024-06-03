Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3201C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 13:01:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE7IM-00032j-62; Mon, 03 Jun 2024 09:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sE7IC-0002o1-UP
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 09:00:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sE7IB-0002hv-3o
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 09:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717419602;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eYBhP00Ndcpi8ZbrIRy3Ymj3tx3br+ER/qltOcBHsHE=;
 b=Hi9JSUYKO8RsI0UJXQ2MJ/+k6SQx5rnIwq8SjskziI2Y5hhdjV04+51kvi4R6Noi7EbSYU
 fYDLH672nadOJBeAcDrhlv5fA0EacEGduOVDOChKTJuR2fpNmnyGtDxTuccRt8mQ5u4l66
 WO5qf+CopCbATJ7CBAYx3+/WiBB6Kf0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-vK1OCRFAM_SjKxtsdvg7dA-1; Mon, 03 Jun 2024 09:00:01 -0400
X-MC-Unique: vK1OCRFAM_SjKxtsdvg7dA-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-43fb0949d28so73078731cf.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 06:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717419600; x=1718024400;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eYBhP00Ndcpi8ZbrIRy3Ymj3tx3br+ER/qltOcBHsHE=;
 b=fSeLGdgWoHmG/LGmPQsfjjcV66SP+yoyrfEoocwQ4a7R/+NsoahOGImqeyKySkpge1
 ijY1CIH7SiZaPVNwlNMWrZJbOJXcQHGkJsmmgF100Dvdmy43fsbAsX+pIG1wEcj5Pl/G
 OErhN6LI3fr6Jaj2LI2PH+qhyyR72EDEfhjCQ9GrsTXvzEH7PGZZjdUBtXqKYz8zJ9EY
 oJHugs3c2f5hqvuil8o/7NnUboKBQas+4Z7DPboxeNE8laGxtpfDkyKIz5hP69MXodVc
 UUd8Vti/wLjH2pRRUDR7wPc94Txmn615hTCs3R8KuRxp/qYuAUlkzuW5Bt0IDOR3YhYz
 JpuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMmV1a/SbueHe957jluaQ/4u56BC9fdi+Q7wksPCFu8vLZlGJcdzwv6fi7SrwlLS5597/tS0qmiliH+PdL0ANO/pl49Fs=
X-Gm-Message-State: AOJu0YzSR1HnSe/PkMumXxTIotkBsFD836mF0upDDg8oxTSpkWiVYpQa
 s9Cby8NTB3FIWbFAgF8vJwDNjtbyE7q2/5TuB5PCFl1KILkX5Z5WTvjwlbnDK3Eb86KnvZESPj3
 mRBGeZ3vFPlf0g6yNQiexycGNb0sbonGUZRVBHru673O7s0YjH2XS
X-Received: by 2002:a05:622a:199a:b0:43b:9f:5ac8 with SMTP id
 d75a77b69052e-43ff366db05mr163226671cf.31.1717419600343; 
 Mon, 03 Jun 2024 06:00:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtLTsiqmo8Da9/bxLyv/qpHCFIV0tI5IrSi8NISwc5iRsKdaXbpkWYrVTo1KJpJWIOk/7ogQ==
X-Received: by 2002:a05:622a:199a:b0:43b:9f:5ac8 with SMTP id
 d75a77b69052e-43ff366db05mr163226131cf.31.1717419599875; 
 Mon, 03 Jun 2024 05:59:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4400810b022sm19962681cf.93.2024.06.03.05.59.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 05:59:59 -0700 (PDT)
Message-ID: <70b5f291-7615-4aa5-9f89-c84339dba9a5@redhat.com>
Date: Mon, 3 Jun 2024 14:59:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/19] vfio: Create host IOMMU device instance
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-14-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240603061023.269738-14-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hi Zhenzhong,

On 6/3/24 08:10, Zhenzhong Duan wrote:
> Create host IOMMU device instance in vfio_attach_device() and call
> .realize() to initialize it further.

I would squash this with the previous patch

Eric
>
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/hw/vfio/vfio-common.h |  1 +
>  hw/vfio/common.c              | 16 +++++++++++++++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 56d1717211..c0851e83bb 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -127,6 +127,7 @@ typedef struct VFIODevice {
>      OnOffAuto pre_copy_dirty_page_tracking;
>      bool dirty_pages_supported;
>      bool dirty_tracking;
> +    HostIOMMUDevice *hiod;
>      int devid;
>      IOMMUFDBackend *iommufd;
>  } VFIODevice;
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index f9619a1dfb..f20a7b5bba 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1528,6 +1528,7 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>  {
>      const VFIOIOMMUClass *ops =
>          VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
> +    HostIOMMUDevice *hiod;
>  
>      if (vbasedev->iommufd) {
>          ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
> @@ -1535,7 +1536,19 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>  
>      assert(ops);
>  
> -    return ops->attach_device(name, vbasedev, as, errp);
> +    if (!ops->attach_device(name, vbasedev, as, errp)) {
> +        return false;
> +    }
> +
> +    hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
> +    if (!HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
> +        object_unref(hiod);
> +        ops->detach_device(vbasedev);
> +        return false;
> +    }
> +    vbasedev->hiod = hiod;
> +
> +    return true;
>  }
>  
>  void vfio_detach_device(VFIODevice *vbasedev)
> @@ -1543,5 +1556,6 @@ void vfio_detach_device(VFIODevice *vbasedev)
>      if (!vbasedev->bcontainer) {
>          return;
>      }
> +    object_unref(vbasedev->hiod);
>      vbasedev->bcontainer->ops->detach_device(vbasedev);
>  }


