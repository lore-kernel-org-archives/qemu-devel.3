Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AD8C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 17:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc7DV-0007Ww-TA; Mon, 19 Feb 2024 12:14:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rc7DQ-0007Vx-Gz
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 12:14:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rc7DO-00010Q-52
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 12:14:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708362841;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0QDjzYHVbHN7negQ6qoEi7AIA5+tA+LMvVZTmLYz+z4=;
 b=VGvqFeWgCERdzN92RJ95p3LvUDZbeBrosXSpt24GCCFawr/oeumNxKgssPcwsWSkd0Lwjv
 PpMNPNPLO5y7hZKX7u/MZ73+8CYvyJPeQP2UaYj37AHfJdtcBhIIzruTJr1Ga+AGOaCuMH
 8pfp2Q7f9A8ZDPifpWHXjtc3QDxAmLk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-AQFRhmTdOhqvWb-s6xh-hA-1; Mon, 19 Feb 2024 12:13:59 -0500
X-MC-Unique: AQFRhmTdOhqvWb-s6xh-hA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7817253831cso535319585a.0
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 09:13:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708362839; x=1708967639;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0QDjzYHVbHN7negQ6qoEi7AIA5+tA+LMvVZTmLYz+z4=;
 b=iXikouSjUxBKBdfTeotRnYlNpLXVmMxiVDlFlDKuOkwI4NgTkqy53Mwm53xfI0K1Gg
 jsPA5jVlo/znEDhQk5YV4BUkkLDPeNKOnu+/WPDVPZz6/dgswsM7MFzoWmqM37XEYOAX
 QZ6AyFP8qJ3YMIZgh/lQEurO5O3HkMqmsDBaRHrr7NlZPLNbti8kmMPgbo+AznYhttUq
 1NkzsC8a/9TzezKRvMQWrnqnEdNHSQLWlj/QfV0cnkTaboAwzeveVoiFweD84j2Z7suF
 2uLpJkjJeDpFg/nhAZnfjvNQ8+4G0Vd+iKxHlUE+TDE+Oh43dgbZnI33PwhGz5k6ySXQ
 w5ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2ZsQnATfOmBsesawVyibhgmCXaECR21eeQSNC9cMFZoI4ZN+UEGXh2q7nc6VVSmx5QmAuDWm+KAenJJL/ZCtX7+RfM+U=
X-Gm-Message-State: AOJu0YwvfWXSvbpcE6/32pMGh7SBWKiBHU+x5UWmvcAtyMblfM9n/CM+
 IjGXFNVdfWoQsk0a4tDXSTR8LD8s9Cuo/Eu0lb1Qtur3emp53w3LueFW9B5EaBFgLgaFISIWo66
 pN+NZGcMrheFraSJthZAziX+NIpMBVKJRkBiXW9VxYUPdwuZjcaey
X-Received: by 2002:a05:620a:a9a:b0:787:51c3:8147 with SMTP id
 v26-20020a05620a0a9a00b0078751c38147mr7486322qkg.77.1708362838993; 
 Mon, 19 Feb 2024 09:13:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkFA9QrA2eTgpwBG6Nqjv9yKR9jRE9JpEDWSFHMge7dqzSBX3hTkUYw/Z5lEgmKvn2UiPz4Q==
X-Received: by 2002:a05:620a:a9a:b0:787:51c3:8147 with SMTP id
 v26-20020a05620a0a9a00b0078751c38147mr7486300qkg.77.1708362838715; 
 Mon, 19 Feb 2024 09:13:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 k8-20020a05620a0b8800b007876fbf2aa4sm519793qkh.99.2024.02.19.09.13.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 09:13:58 -0800 (PST)
Message-ID: <16acbc9f-7895-42b4-b762-55b36a1cc7df@redhat.com>
Date: Mon, 19 Feb 2024 18:13:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv2 07/18] vfio/container: Implement
 host_iommu_device_init callback in legacy mode
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20240201072818.327930-1-zhenzhong.duan@intel.com>
 <20240201072818.327930-8-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240201072818.327930-8-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
On 2/1/24 08:28, Zhenzhong Duan wrote:
> This callback will be used to initialize base and public elements
> in IOMMULegacyDevice.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/vfio/container.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index bd25b9fbad..8fafd4b4e5 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -1120,6 +1120,12 @@ out_single:
>      return ret;
>  }
>  
> +static void vfio_legacy_host_iommu_device_init(VFIODevice *vbasedev)
> +{
> +    host_iommu_base_device_init(&vbasedev->base_hdev, HID_LEGACY,
> +                                sizeof(IOMMULegacyDevice));
To me this should allocate a new

 IOMMULegacyDevice and set the VFIODevice base_hdev handle to its base @

Thanks

Eric

> +}
> +
>  static void vfio_iommu_legacy_class_init(ObjectClass *klass, void *data)
>  {
>      VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
> @@ -1132,6 +1138,7 @@ static void vfio_iommu_legacy_class_init(ObjectClass *klass, void *data)
>      vioc->set_dirty_page_tracking = vfio_legacy_set_dirty_page_tracking;
>      vioc->query_dirty_bitmap = vfio_legacy_query_dirty_bitmap;
>      vioc->pci_hot_reset = vfio_legacy_pci_hot_reset;
> +    vioc->host_iommu_device_init = vfio_legacy_host_iommu_device_init;
>  };
>  
>  static const TypeInfo types[] = {


