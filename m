Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE947C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5mm-0001mS-0F; Mon, 03 Jun 2024 07:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sE5mh-0001IS-Jp
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:23:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sE5mf-0007yw-C8
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717413803;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p9Zx15s8jlaiOIPjcoNNx4Lk3rOD2uzQbIF7zMnsgYA=;
 b=ggGuy2eFXuA6aGKRL7dJWPPW3iZ70e57Lt+QUWfKCEr6BMvgT9WFmbKrMMIOCcRUCvFWsl
 rfGEE6+80/jEPMoz/SRvMSDB0DMf/vJJxI5pgYfS4h2/95GUCeV9SfWDqyehzaPw+JF1XI
 XrQHnxqtsdXwotr5MedDm6ZZsTZb8Wg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-W3MecyxVPSCrFZXvMoESiQ-1; Mon, 03 Jun 2024 07:23:22 -0400
X-MC-Unique: W3MecyxVPSCrFZXvMoESiQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-35dca12cca8so2128245f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 04:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717413801; x=1718018601;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p9Zx15s8jlaiOIPjcoNNx4Lk3rOD2uzQbIF7zMnsgYA=;
 b=HyrSqw6OvIAdeACMl5si/hboOvJOtdB/vwmxccBRx+t+LHveejA4vDBiNKDKI8rIcE
 QQ2O2+BW69KZe6iOOERqgg8dfntVXGY1fBI+pe45HG+3M+gtOX74kDtFpreGqE/M1tr6
 5p8uR3+JXylTxbrhVYroLoVuvZyW4CHmc+z60BYe3P4e229BW81syyl3dDzzIqUELXEG
 9hnBQ01TRLmmslSuw1yqo63FWQBarhPtidFNbLvuebk0pYigkAWjT92qAmkp8mCCr8RF
 FJDKtf0C2ah7Wm9SWgpjwP9URrI/hlk9M7UdSz2k1Pye7Z0HV9K+F7Zwkaz9uCJuMGXW
 N4zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtVqS4uPPuJjQvUD5ZmeHaBRPLWY/pRoDsArHdK4l0VAlaJtykgYbx+QqXB+1Bg6LLi5ZA07f5nbjKpWLAPKhh0iqcoMw=
X-Gm-Message-State: AOJu0Yygn9JjYZPcq3eg3NcemXHiZ2sWUil8KGtKbsgoAMy7F+B5y1xg
 kegzxz4BQEGeEcnFTbDjfRzfdyERK4Jp60WCKW1CWv2GZZ9dtpi6v5wGpICjz5nobeK8S9llGm7
 qHOl9n3vXtkG3qBu6nk8RBVjeJ8g+7Zn7XPPD0To2rNtpRPEf20Y5
X-Received: by 2002:adf:ea0f:0:b0:35e:543a:a930 with SMTP id
 ffacd0b85a97d-35e543aab55mr3044138f8f.18.1717413801345; 
 Mon, 03 Jun 2024 04:23:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5dqxtojmQwgL0Vvoi0S/MuDutKLLmoTIQd0WzszghOGTly+hGndPEiYOR1BLx2jnpdz5lPQ==
X-Received: by 2002:adf:ea0f:0:b0:35e:543a:a930 with SMTP id
 ffacd0b85a97d-35e543aab55mr3044123f8f.18.1717413800881; 
 Mon, 03 Jun 2024 04:23:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212b84d66bsm114768255e9.12.2024.06.03.04.23.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 04:23:20 -0700 (PDT)
Message-ID: <1a188365-7101-472d-adfb-89a74dab055b@redhat.com>
Date: Mon, 3 Jun 2024 13:23:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/19] vfio/container: Implement
 HostIOMMUDeviceClass::realize() handler
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-8-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240603061023.269738-8-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi Zhenzhong,

On 6/3/24 08:10, Zhenzhong Duan wrote:
> Utilize range_get_last_bit() to get host IOMMU address width and
> package it in HostIOMMUDeviceCaps for query with .get_cap().
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/vfio/container.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index c4fca2dfca..48800fe92f 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -1136,6 +1136,31 @@ static void vfio_iommu_legacy_class_init(ObjectClass *klass, void *data)
>      vioc->pci_hot_reset = vfio_legacy_pci_hot_reset;
>  };
>  
> +static bool hiod_legacy_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
> +                                     Error **errp)
> +{
> +    VFIODevice *vdev = opaque;
> +    /* iova_ranges is a sorted list */
> +    GList *l = g_list_last(vdev->bcontainer->iova_ranges);
> +
> +    /* Only support query HOST_IOMMU_DEVICE_CAP_AW_BITS with legacy backend */
I don't get the comment as HOST_IOMMU_DEVICE_CAP_AW_BITS support seems
to be introduced in [PATCH v6 11/19] backends/iommufd: Implement
HostIOMMUDeviceClass::get_cap() handler
> +    if (l) {
> +        Range *range = l->data;
> +        hiod->caps.aw_bits = range_get_last_bit(range) + 1;
> +    } else {
> +        hiod->caps.aw_bits = 0xff;
why this value?
> +    }
> +
> +    return true;
> +}
> +
> +static void hiod_legacy_vfio_class_init(ObjectClass *oc, void *data)
> +{
> +    HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
> +
> +    hioc->realize = hiod_legacy_vfio_realize;
> +};
> +
>  static const TypeInfo types[] = {
>      {
>          .name = TYPE_VFIO_IOMMU_LEGACY,
> @@ -1144,6 +1169,7 @@ static const TypeInfo types[] = {
>      }, {
>          .name = TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO,
>          .parent = TYPE_HOST_IOMMU_DEVICE,
> +        .class_init = hiod_legacy_vfio_class_init,
>      }
>  };
>  

Thanks

Eric


