Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B916C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 15:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJEIS-0003RK-5i; Mon, 17 Jun 2024 11:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sJEIQ-0003R1-9W
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 11:29:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sJEIO-0007Im-RE
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 11:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718638164;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Pwuismj4dGFDsbq4kN9lMshi1MUmHpLPcvLtM3MqrA=;
 b=IvSU3yU9ECHy2pBjwEKlgZbbZBy7WYP5kych35qCPvSOuBocnW0ocxENhs+Tf6Ho/ax1GI
 HAQPqfOiarOw24ydpoIGQ6MI680fd7R1odle4yDAEJmcy/E5PXXwaIQKEM/SsyICkHtSNc
 jaMdi0evo5lF3Y3x7re6UUDNWDjsRZk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-wHK187G7OTqjhwptqmlK7w-1; Mon, 17 Jun 2024 11:29:22 -0400
X-MC-Unique: wHK187G7OTqjhwptqmlK7w-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4406476507cso50708871cf.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 08:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718638162; x=1719242962;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0Pwuismj4dGFDsbq4kN9lMshi1MUmHpLPcvLtM3MqrA=;
 b=Krj+k2WZ/11wnQHVdxX71paVxUMQmZ8eMlvFj31narazrosePFVY3iiY0kk3DYXId7
 YR0y3UBXZJfbrkKcsltmdG91AnWEiJKoTQyNGSeOaUFz60zloHQ47f1i7uZqcGEaFSsC
 EuFBx9a6Us/oy3HmbF5u/eRl0D9NPrUW2FxbMMDfDVaFmrraHLrHIhgRqw1Lg2Y5m3xX
 KlZ1PXqifUzdn2/Gp2izf7o22PAYw3tXPFdygZxMYWRLRGbdFfb+OITyXwJ3yDyRITqR
 PlgdSkKaTliou9AsbhpN1YdUELb1LCV7YnOIi8XfMjlTMkKCLuaDPipM9DbkWcr8RxzL
 8AKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6eIxzMbxy6VtM2gfIeK+JlCrwh+PZmou7OkE1H5pBmlf+j4sfdQUYoN+yGc6D2cpN6VSJiphyv6LQnpiiMnU4mzufGkc=
X-Gm-Message-State: AOJu0Yx+S1n/9oYuTTo3A9vkDDFGka3QeUCgEvNJeXLeERpJiZGDXeAR
 YACwTo0Lu+lFto+9nJitkkMuaFW+IShzq02usl2WmNSG6uR/qHdmuutZj0Mq9pTtFJ1WM7CQDk+
 qgTnxzayuA07WvHBpbIUGfU+jflX91Ndwnd2LnQnUraQKQxxP2rfy
X-Received: by 2002:ac8:4e31:0:b0:442:1962:f2c with SMTP id
 d75a77b69052e-44219622165mr87213411cf.9.1718638162289; 
 Mon, 17 Jun 2024 08:29:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaJAa8e8VkPVHAmAMAPeVTxG2v2U53atanwCEJ05y6W8PldZmaFNXjj3Vwg/B7ulU53B4toA==
X-Received: by 2002:ac8:4e31:0:b0:442:1962:f2c with SMTP id
 d75a77b69052e-44219622165mr87213281cf.9.1718638161928; 
 Mon, 17 Jun 2024 08:29:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-441ef3d89c7sm47256291cf.20.2024.06.17.08.29.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 08:29:21 -0700 (PDT)
Message-ID: <15d89127-ab6e-4496-92b9-3c7ef82d18b7@redhat.com>
Date: Mon, 17 Jun 2024 17:29:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/17] vfio/container: Introduce
 vfio_iommu_legacy_instance_init()
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240617063409.34393-1-clg@redhat.com>
 <20240617063409.34393-17-clg@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240617063409.34393-17-clg@redhat.com>
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
> Just as we did for the VFIOContainerBase object, introduce an
> instance_init() handler for the legacy VFIOContainer object and do the
> specific initialization there.
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/vfio/container.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 3f2032d5c496de078c277ebacc49d7db89f4cc65..45123acbdd6a681f4ce7cae7aa2509100ea225ab 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -639,7 +639,6 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>  
>      vfio_kvm_device_add_group(group);
>  
> -    QLIST_INIT(&container->group_list);
>      vfio_address_space_insert(space, bcontainer);
>  
>      group->container = container;
> @@ -1183,6 +1182,13 @@ hiod_legacy_vfio_get_iova_ranges(HostIOMMUDevice *hiod, Error **errp)
>      return l;
>  }
>  
> +static void vfio_iommu_legacy_instance_init(Object *obj)
> +{
> +    VFIOContainer *container = VFIO_IOMMU_LEGACY(obj);
> +
> +    QLIST_INIT(&container->group_list);
> +}
> +
>  static void hiod_legacy_vfio_class_init(ObjectClass *oc, void *data)
>  {
>      HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
> @@ -1196,6 +1202,7 @@ static const TypeInfo types[] = {
>      {
>          .name = TYPE_VFIO_IOMMU_LEGACY,
>          .parent = TYPE_VFIO_IOMMU,
> +        .instance_init = vfio_iommu_legacy_instance_init,
>          .instance_size = sizeof(VFIOContainer),
>          .class_init = vfio_iommu_legacy_class_init,
>      }, {


