Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B220C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 08:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmUeg-0004vy-EK; Tue, 19 Mar 2024 04:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmUec-0004vZ-Rf
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 04:17:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmUeO-0000GE-Kj
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 04:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710836206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tGBZ1NodGkw1twMe2bHAbus80Q+dbCq/LWCLgEri9RM=;
 b=HsUf8WxP3/lylu+8VY4nvCKa7pj2n2O88vqXK+2z12aJDV1v1QX0Lq1kee7dMunIsL2ymc
 JtGxUWWhmHOIVeP+t4lVZVi8Y0xguvWVB0T4CEpYOmdAlFX/8QBuwo33DOW6J+eYgEmwXA
 dCGz1AjnQtM+WtvEFbKJRcmVMo2egLM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-uehHy28SMs2Ys3FhW5cl8w-1; Tue, 19 Mar 2024 04:16:43 -0400
X-MC-Unique: uehHy28SMs2Ys3FhW5cl8w-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-430bde4b347so39326761cf.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 01:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710836203; x=1711441003;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tGBZ1NodGkw1twMe2bHAbus80Q+dbCq/LWCLgEri9RM=;
 b=SARXJ7wODZOM1vqe/AmxBeQsGKSPTGTEOtQ4ZEQnvtB5rH7WGkiDpOloecLHZld/46
 ATYxfi09GIsVTYPHH0AtIl8bX7jR7i/K1aaUoPjkgA1B8Mx7sAl2nsGwDDsCMUkzE9h/
 cp/X1SUsFRq+0MPYCjaL4or/6p7c0LZTNuTChIM3n8EfOLpdR7nUc9OwEKpVyFUlFPCc
 iICnkK+D/phM8yk5gUiR5Vu4vaTrFZJiIqbO6sqozSrgG/DIa7zO9Zn+Tfx13Xf/tXgK
 L2em7kOQ1WFB0qebEeT3IEFizr7pmoAQnm1xUDwSMpcCR6YfGB/gyyPJiw1+Q9rL7FkG
 fYkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcB+t5Ry483+iAKxnC4Ggr56tPMVFRP17J/OZdrLexNSctyrMdgumTX4TKWvg5I26sUd84HGSJLJvDHINubg8Yrk6N3z8=
X-Gm-Message-State: AOJu0Yw+7DZr2huqlgUzuN2/PnvnaNQMr1PvHQXLPR2kQmKWvSxRQcL5
 vqdP04qlqPE06IZiF6ZDFtmp76ML2eLBSAA6uHi+TKgMJFaWME8VAbPyoXPqWPIKq0asS9ymK+Z
 3e6Fhttq4vh0PJZxQHGuQvy2oJixPIQJvNtT+IJ+V5UeqexcODgVv
X-Received: by 2002:a05:622a:40b:b0:430:95e4:7c12 with SMTP id
 n11-20020a05622a040b00b0043095e47c12mr15847442qtx.55.1710836203191; 
 Tue, 19 Mar 2024 01:16:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFibSsJgdd+2SE1pGuu6cCic6KmiRSmU7eywm/rD3FkCR8BJ/WgDlUNW9JYn8N319R53rvEBw==
X-Received: by 2002:a05:622a:40b:b0:430:95e4:7c12 with SMTP id
 n11-20020a05622a040b00b0043095e47c12mr15847433qtx.55.1710836202945; 
 Tue, 19 Mar 2024 01:16:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ay29-20020a05622a229d00b00430b385f721sm4369373qtb.15.2024.03.19.01.16.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 01:16:42 -0700 (PDT)
Message-ID: <e6af68f4-f38d-413f-a63c-d1ae7254d802@redhat.com>
Date: Tue, 19 Mar 2024 09:16:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/11] Introduce a common abstract struct
 HostIOMMUDevice
Content-Language: en-US, fr
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
 <20240228035900.1085727-2-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240228035900.1085727-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello Zhenzhong,

On 2/28/24 04:58, Zhenzhong Duan wrote:
> HostIOMMUDevice will be inherited by two sub classes,
> legacy and iommufd currently.
> 
> Introduce a helper function host_iommu_base_device_init to initialize it.
> 
> Suggested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/sysemu/host_iommu_device.h | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
>   create mode 100644 include/sysemu/host_iommu_device.h
> 
> diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
> new file mode 100644
> index 0000000000..fe80ab25fb
> --- /dev/null
> +++ b/include/sysemu/host_iommu_device.h
> @@ -0,0 +1,22 @@
> +#ifndef HOST_IOMMU_DEVICE_H
> +#define HOST_IOMMU_DEVICE_H
> +
> +typedef enum HostIOMMUDevice_Type {
> +    HID_LEGACY,
> +    HID_IOMMUFD,
> +    HID_MAX,
> +} HostIOMMUDevice_Type;
> +
> +typedef struct HostIOMMUDevice {
> +    HostIOMMUDevice_Type type;

A type field is not a good sign and that's where QOM is useful.

Is vtd_check_hdev() the only use of this field ? If so, can we simplify
with a QOM interface in any way ?

Thanks,

C.

  


> +    size_t size;
> +} HostIOMMUDevice;
> +
> +static inline void host_iommu_base_device_init(HostIOMMUDevice *dev,
> +                                               HostIOMMUDevice_Type type,
> +                                               size_t size)
> +{
> +    dev->type = type;
> +    dev->size = size;
> +}
> +#endif


