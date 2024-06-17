Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7249C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 14:30:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJDNA-0007xf-Hw; Mon, 17 Jun 2024 10:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sJDN2-0007wd-3T
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 10:30:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sJDMz-0004xZ-89
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 10:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718634602;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lppI5lXbeckKBYh/84U/RM78TpkH3UBIDyH6W0RnEQA=;
 b=c2ebVUGBklgsIzzZVj39Inu3FBTWO/QR2jJh8tc4pOktD5n7LChlXwb1Ihnm6WK3ZqbX2G
 gHS1d0YtlQsuttzZQ1fuQ/BvesBJBR/3feLqfXPmyJvYQ1tSi9LGzMrNq3YmZuYU/M20wX
 7dpEZnXcEEGsQ9gA/kila++LhWWaRkc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-ZllFMHSUMu-pDPCaA1BhcQ-1; Mon, 17 Jun 2024 10:30:01 -0400
X-MC-Unique: ZllFMHSUMu-pDPCaA1BhcQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6b2bee3654aso42144256d6.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 07:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718634600; x=1719239400;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lppI5lXbeckKBYh/84U/RM78TpkH3UBIDyH6W0RnEQA=;
 b=AA5qhRtRfiOBjd8Bc70maX5bWNyNRW/S2/LUjCiusTexg0pnRf92H1qTZLa4Awepi+
 NbCr3TTiOlSgEK/kx35RBU2hYXN2lCaZ46aI6TDba7Gsk5SYBpxHv0chrIstsHnYggra
 911gZsZm6UeTPkvibxPkSvQlcv64qfBU2ttef+UM8F6Mk5tvwZiD8+JrAOEamTA1gkZp
 0G2GNQEbb5nohB3/D6kSj1176SkW6YpezZu2NGHb2D/gXJIN2VUn3ZksM2AqvdyhCr8y
 /NQ2YyU+qoaSTjxSy6B40SZWh1pi11/eYGfPKI/2+8w06HjOPtwKvqpNOpd4P03vMQvT
 TKVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJf8r7kpr2QPIQcsN78CXQdfFFGyxQ8psymOc7rXdbtrgEq2nKt1fcme0Xq7m6f59iuMJYB7Y9bPNaPjDMrzR7LrCo42k=
X-Gm-Message-State: AOJu0YxamsqL+2YDEdTa6/JETZqN/Px/9hZE4jb1wEBajkA0iqMVwi0N
 ehQvosLZAXNlFpU44EnsnAfwjSl0C7nBCGjlCInqCpgIpJXNU1q///Y3IDiWFUat5lL41FCSw85
 DYngKeKyC5/WAhA+uTEMOWFDMmrvIAjQeyD82X4PX7bIyf9Ila1OW
X-Received: by 2002:a05:6214:2a47:b0:6b0:7365:dde0 with SMTP id
 6a1803df08f44-6b2a33de160mr245508536d6.18.1718634600328; 
 Mon, 17 Jun 2024 07:30:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyCRW+mA99lmpUtxlXCsGcxNKo/+xNCIIbYnUt2qv3XPqth3LdE37/YcouugjHZLtxhRuq9A==
X-Received: by 2002:a05:6214:2a47:b0:6b0:7365:dde0 with SMTP id
 6a1803df08f44-6b2a33de160mr245508206d6.18.1718634600017; 
 Mon, 17 Jun 2024 07:30:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44212efe609sm43231571cf.52.2024.06.17.07.29.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 07:29:59 -0700 (PDT)
Message-ID: <50d1f0d0-9109-42e4-8b34-8c1e6bf215ec@redhat.com>
Date: Mon, 17 Jun 2024 16:29:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/17] vfio/container: Introduce
 vfio_get_iommu_class_name()
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240617063409.34393-1-clg@redhat.com>
 <20240617063409.34393-9-clg@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240617063409.34393-9-clg@redhat.com>
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



On 6/17/24 08:34, Cédric Le Goater wrote:
> Rework vfio_get_iommu_class() to return a literal class name instead
> of a class object. We will need this name to instantiate the object
> later on. Since the default case asserts, remove the error report as
> QEMU will simply abort before.
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Eric Auger <eric.auger@redhat.com>


Eric
> ---
>  hw/vfio/container.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 589f37bc6d68dae18f9e46371f14d6952b2240c0..bb6abe60ee29d5b69b494523c9002f53e1b2a3c8 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -373,24 +373,20 @@ static int vfio_get_iommu_type(int container_fd,
>  /*
>   * vfio_get_iommu_ops - get a VFIOIOMMUClass associated with a type
>   */
> -static const VFIOIOMMUClass *vfio_get_iommu_class(int iommu_type, Error **errp)
> +static const char *vfio_get_iommu_class_name(int iommu_type)
>  {
> -    ObjectClass *klass = NULL;
> -
>      switch (iommu_type) {
>      case VFIO_TYPE1v2_IOMMU:
>      case VFIO_TYPE1_IOMMU:
> -        klass = object_class_by_name(TYPE_VFIO_IOMMU_LEGACY);
> +        return TYPE_VFIO_IOMMU_LEGACY;
>          break;
>      case VFIO_SPAPR_TCE_v2_IOMMU:
>      case VFIO_SPAPR_TCE_IOMMU:
> -        klass = object_class_by_name(TYPE_VFIO_IOMMU_SPAPR);
> +        return TYPE_VFIO_IOMMU_SPAPR;
>          break;
>      default:
>          g_assert_not_reached();
>      };
> -
> -    return VFIO_IOMMU_CLASS(klass);
>  }
>  
>  static bool vfio_set_iommu(VFIOContainer *container, int group_fd,
> @@ -398,6 +394,7 @@ static bool vfio_set_iommu(VFIOContainer *container, int group_fd,
>  {
>      int iommu_type;
>      const VFIOIOMMUClass *vioc;
> +    const char *vioc_name;
>  
>      iommu_type = vfio_get_iommu_type(container->fd, errp);
>      if (iommu_type < 0) {
> @@ -426,11 +423,8 @@ static bool vfio_set_iommu(VFIOContainer *container, int group_fd,
>  
>      container->iommu_type = iommu_type;
>  
> -    vioc = vfio_get_iommu_class(iommu_type, errp);
> -    if (!vioc) {
> -        error_setg(errp, "No available IOMMU models");
> -        return false;
> -    }
> +    vioc_name = vfio_get_iommu_class_name(iommu_type);
> +    vioc = VFIO_IOMMU_CLASS(object_class_by_name(vioc_name));
>  
>      vfio_container_init(&container->bcontainer, vioc);
>      return true;


