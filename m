Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F999C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 10:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBspp-0003Pb-CF; Mon, 05 May 2025 06:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uBspn-0003PK-JZ
 for qemu-devel@nongnu.org; Mon, 05 May 2025 06:14:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uBspm-0007tf-5h
 for qemu-devel@nongnu.org; Mon, 05 May 2025 06:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746440041;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ohHJP0l/CPWxZVkZm6JMqzdhqvKYYPKZgEYiFXsrn4M=;
 b=OMyoK/KGDbaxrFkfl/FhroRAM3uiLE0YeTjtjeti0u84DRy/EYbp/2/rvIoE/r7nMFIXsx
 i/MxYTX7Pe0UVDKwzeIWVgOv2W43dekZRFP61I8YlrzB1l1L/hMagpRdLoqwqrB58VOTIB
 n0dgtpzGeGSeD1jXYyy3zd5+xySC9RY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-bFu3wrOUOqi8pi9YUvs0xw-1; Mon, 05 May 2025 06:13:59 -0400
X-MC-Unique: bFu3wrOUOqi8pi9YUvs0xw-1
X-Mimecast-MFC-AGG-ID: bFu3wrOUOqi8pi9YUvs0xw_1746440039
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d733063cdso30930575e9.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 03:13:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746440039; x=1747044839;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ohHJP0l/CPWxZVkZm6JMqzdhqvKYYPKZgEYiFXsrn4M=;
 b=W073v3jlzioZWwu5onZxDF1SaOqO7ZTru/G+stBUv+RgIxxtCNqIv/QhXEEs3l3FAQ
 WFou4Z1L51vhBbv0B0T1hkUszVOd4AzZDpUeDHUXKDSUFmXH8tI0dQk53Udp1+McXWwT
 BEchwgcFlDZkAxs3Z++vTKg8GH3wHDBnEw6Xb8v5BsqDonLRD8Z5IfAUv1zXFYAsdVs2
 6McD9bWBzawGP8pwFFdKJ7M0tWLe3BprCtWifz48LceHaUdN7ttZX6zv/qBZ2acigbW1
 gT/M8QfGFc7/O0/c29193tp4agxpRyk8kdJCfR8lS9mdfnMOCQxDRM8jS+LyAWw+4fHE
 Pieg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWv3WucUcbtdVJtw0jZ2xyRxvdcBfQ1xrlbybGGav4IJfkfmWOdy5D22FANpqpnafcYfOtiKzHD4flC@nongnu.org
X-Gm-Message-State: AOJu0YxT38sqwh/QmaLISojqr1NVUsuczP2AVQHPF9VvXQQEZql0HBTE
 iMx9IzCaLBATLonNPLq7fFLBW5f2k3t76WJRIifSzV3KJWSv2DtOtW0YqeoTZN2P/XxydxAHy+F
 tN06aR/VwqT1yoXlfZvleT7aAjKNw2KkHKD1+a7Apn16DGoQiHaV0
X-Gm-Gg: ASbGncsq4kkOhzBK/ZgTnKheLNtLQ38cy2QoXuzVI5k/QsWP/TobQ+YJzXJq2Czk/nL
 0M43BddzwqU3YwXHiyOZ4HixEbH1j0MKhVsmWxdNDyc2TmV0y0bZ1dtO3d6qVaLz+Js6a9dQpkK
 GeVyAsixP1DYp9lZYlK9wieUJ98wa8oMSp0pZEh+L96+SfQ+0QqodIgGaGIMuukXDAwwI97tz6c
 De5/Acz/tERgyiG8gLEqCsMu+rWAmmnK5gv1BYbspbcNJxdVmXVLEC91eUc936GVkq3MerUf4A3
 veZEgFHKKYpoznLDNxhJBcJ3+h0YnfMK/dU0QlZfQjUICwm+EJ5GOy8Yrkk=
X-Received: by 2002:a05:600c:1d15:b0:43d:745a:5a50 with SMTP id
 5b1f17b1804b1-441c1cfc72amr64240965e9.19.1746440038816; 
 Mon, 05 May 2025 03:13:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKVcp+cji5J5oMqw2Dko1ulIFQOnsS/IozetKQuRVppiOneClCk1PFK5MP9C8BmmvfIsUkPA==
X-Received: by 2002:a05:600c:1d15:b0:43d:745a:5a50 with SMTP id
 5b1f17b1804b1-441c1cfc72amr64240765e9.19.1746440038540; 
 Mon, 05 May 2025 03:13:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae7a55sm9793708f8f.45.2025.05.05.03.13.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 03:13:57 -0700 (PDT)
Message-ID: <dcced2ee-d13f-4af2-83e1-9616d117faaf@redhat.com>
Date: Mon, 5 May 2025 12:13:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] hw/arm/smmuv3: Enable smmuv3 device creation
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
 <20250502102707.110516-7-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250502102707.110516-7-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 5/2/25 12:27 PM, Shameer Kolothum wrote:
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/smmuv3.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 605de9b721..e13950b7c5 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -2022,6 +2022,7 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>      device_class_set_props(dc, smmuv3_properties);
>      dc->hotpluggable = false;
>      dc->bus_type = TYPE_PCIE_BUS;
> +    dc->user_creatable = true;
>  }
>  
>  static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
I would squash this into the previous patch

Eric


