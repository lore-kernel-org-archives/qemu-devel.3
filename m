Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B099BC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 09:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1jzk-00054T-0i; Tue, 30 Apr 2024 05:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s1jze-0004hd-Fy
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:41:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s1jzc-0005uk-Hp
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714470101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xlL7Qzo9mZNyJ6Z1TuQkziJBsHMvA966HXlmzEgDbyw=;
 b=Fa+DTEP6wxGuw+0lb2OZYuMMtFfkVa1wkeWHn0X3ol27vVTGn4yZ6U5DDKgQbv3YeopSXn
 kn38LikIjoxirurFcnQ5kdNLUmuIWuC0cY7Ncr3Xergo/wUFluDPTR1k1TQ1D5q7LxFYaK
 t1jokgYsEdwC9d2jlr5e4gtajNPWQSw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-LUNP8gZiNI6aoHAL2Dp7vg-1; Tue, 30 Apr 2024 05:41:39 -0400
X-MC-Unique: LUNP8gZiNI6aoHAL2Dp7vg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a5872678bd2so299050466b.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 02:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714470098; x=1715074898;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xlL7Qzo9mZNyJ6Z1TuQkziJBsHMvA966HXlmzEgDbyw=;
 b=sYF/zaCGV39qjCLFwTbcdryscWJIbB03B8tNJOrGJB0/OftiGnjlvXpTC0tMCqo1QG
 TWgf/OhPAKCK6RXGS7KSjxnaqOgC9OlYoQLr821JqAQnrwLGHI9W4YGp5DgVO7aRt5yV
 Ian2QocCTC5CCFctuGQdYsXyHRQ+6sISp9c21SBoO77jZfLEDCcSdOoPEJp2gkBJZ2Ho
 XZppL8ejufdcU/xFvZw/W7zVs5HSc2j7jWJ9/VFUwjbTLZpznWlhjUZOo+dc/nXcXn0s
 9hoMblPYP0Z/5vf+WK6JsXMtu+k06J09eY88B0AWJLYi8LOfjhkCfCbgSJgsHlOEU1pp
 GO6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+56598KzFmOjh15ZyWXa8RXu1Ryc1GkuhauqxCTFp+fyrP8MtPcREpG9m9wI9l0QcjoZ56LNmm3MBYYHqLgbgnP30aOg=
X-Gm-Message-State: AOJu0YxixINmmmBylysBacdEQQSgm7o3nHf6QiJ7VxGBhn/MOEhrYPfb
 hrewh/7lE1BUWRmy2olX87+3gk2C49vqGYuIehAQdq/sYJhz8eZrMlKiOho48d/+UikZ+jbilTd
 SFEEjoQ87iHjhVxW2WzEFQhvoHjKghTUdTAHmR3z+vsYmt2m7k0z/
X-Received: by 2002:a17:906:7f03:b0:a52:6435:ef09 with SMTP id
 d3-20020a1709067f0300b00a526435ef09mr8602340ejr.76.1714470098462; 
 Tue, 30 Apr 2024 02:41:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXsIM/BUKSIXZyJROdcuOL0Mj/aTocRr2DirGyexTPp0ti8oYacIOXCEOG9NOt+LSV2ponTg==
X-Received: by 2002:a17:906:7f03:b0:a52:6435:ef09 with SMTP id
 d3-20020a1709067f0300b00a526435ef09mr8602331ejr.76.1714470098219; 
 Tue, 30 Apr 2024 02:41:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 gl20-20020a170906e0d400b00a5889ee66d6sm7803905ejb.45.2024.04.30.02.41.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 02:41:37 -0700 (PDT)
Message-ID: <dccbba66-57c9-45de-9fa9-beb7b528e0b1@redhat.com>
Date: Tue, 30 Apr 2024 11:41:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Subject: Re: [PATCH v3 11/19] backends/iommufd: Implement
 HostIOMMUDeviceClass::check_cap() handler
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
 <20240429065046.3688701-12-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
In-Reply-To: <20240429065046.3688701-12-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/29/24 08:50, Zhenzhong Duan wrote:
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   backends/iommufd.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index d61209788a..28faec528e 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -233,6 +233,23 @@ int iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>       return ret;
>   }
>   
> +static int hiod_iommufd_check_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
> +{
> +    switch (cap) {
> +    case HOST_IOMMU_DEVICE_CAP_IOMMUFD:
> +        return 1;

I don't understand this value.


Thanks,

C.


> +    default:
> +        return host_iommu_device_check_cap_common(hiod, cap, errp);
> +    }
> +}
> +
> +static void hiod_iommufd_class_init(ObjectClass *oc, void *data)
> +{
> +    HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
> +
> +    hioc->check_cap = hiod_iommufd_check_cap;
> +};
> +
>   static const TypeInfo types[] = {
>       {
>           .name = TYPE_IOMMUFD_BACKEND,
> @@ -251,6 +268,7 @@ static const TypeInfo types[] = {
>           .parent = TYPE_HOST_IOMMU_DEVICE,
>           .instance_size = sizeof(HostIOMMUDeviceIOMMUFD),
>           .class_size = sizeof(HostIOMMUDeviceIOMMUFDClass),
> +        .class_init = hiod_iommufd_class_init,
>           .abstract = true,
>       }
>   };


