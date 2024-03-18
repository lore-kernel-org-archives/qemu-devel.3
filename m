Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D51AC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 14:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmDuK-0001R1-S4; Mon, 18 Mar 2024 10:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rmDuG-0001QW-Uk
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 10:24:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rmDuC-0000tV-Cq
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 10:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710771839;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UgLbnnCPTPbQjyiazg1DCM+1FQd9opTAwIkPBI+4zs4=;
 b=C64HrmaXpF8qc8NuP5W6wvueAwCCIPwemOc4gcgImtxxfgXQyLIp5jA9vbvrHU6syI5PxP
 QXSRxWsJRTSgr/LFbwNd4P3wUUGX/ZryTQdR8UmvAVEhkB0NZFg2UB8wEzxDoorLgOMaOD
 S9QlxLd6psqAX+aikvZwQBpNt0k5r5g=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-2stLNWbnNoewX4y_JIPAVw-1; Mon, 18 Mar 2024 10:23:57 -0400
X-MC-Unique: 2stLNWbnNoewX4y_JIPAVw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-789e0996c3cso525513285a.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 07:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710771837; x=1711376637;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UgLbnnCPTPbQjyiazg1DCM+1FQd9opTAwIkPBI+4zs4=;
 b=fJ8VxdzCDfN9Wb4D8srDwc98Zf6rCyxywoi8BDKG9O+n5f0zN24zyTKwoHSf+iWS9H
 5PGek7JOJ2h03cmzul7dWPgQsUtgyQdGZfDmAS22i5PnQapLFvO182cEN4yMc/jEL4AI
 sChglYSBcqqyxOHrbs6JSElih3NBIEb4d0qxNLJweBD2PeyRd2MbKanB+ytUuxL0fSNq
 x/GeqVsCdFKINVAOocRdShzhJ4MO9LUx1XnOoFtPM0cdA4YV/u4P3n0+/uOZk2+yZx5q
 iGZOwAXfnIIzMg4A2QmGqOEB+mqxvAySWPe51rT/+DtZXEeAJIwuNr92NciuQI/oYyuU
 0igw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU50nzmDtkc/R8wJNtCOyhkGqkyinrkLwLB+/Zm5fyktlG+J9EZOzEpAsZ01Aj7aeA8r+IsSg3OMIAJ0Mrn8+YhfsWxvk4=
X-Gm-Message-State: AOJu0YxtMG3TLiKr6lIhfDo+G8QOEk5yFMGwjNDNauYs/cstRn5dIS+f
 7+lrzeHOdTCkoiNBD/CTZDgAaFDufVpcY8qrIUro6RBVnepjOOKuJYKisGvfkjdxSK0o3kWw9dg
 99eR6Tn2BLZs9ZgSH1t3oI8uqajmBJYXr4iEOjtjaGdQxCFNYswKN
X-Received: by 2002:a05:620a:4e2:b0:789:f500:cdc0 with SMTP id
 b2-20020a05620a04e200b00789f500cdc0mr5001205qkh.22.1710771837258; 
 Mon, 18 Mar 2024 07:23:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7iCu6ixhqeZDYIUJuyWgzeMgRLZSAv5KpoMhBKeCxsjvcyLb3W0FwKMH5o/UiG7WmA/eTJw==
X-Received: by 2002:a05:620a:4e2:b0:789:f500:cdc0 with SMTP id
 b2-20020a05620a04e200b00789f500cdc0mr5001194qkh.22.1710771837030; 
 Mon, 18 Mar 2024 07:23:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 z7-20020ae9c107000000b00789e1c94cf4sm3693189qki.113.2024.03.18.07.23.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 07:23:56 -0700 (PDT)
Message-ID: <2d9b6b71-6913-4169-9759-0b25ae9eddbc@redhat.com>
Date: Mon, 18 Mar 2024 15:23:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/11] Introduce a common abstract struct
 HostIOMMUDevice
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
 <20240228035900.1085727-2-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240228035900.1085727-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
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
On 2/28/24 04:58, Zhenzhong Duan wrote:
> HostIOMMUDevice will be inherited by two sub classes,
> legacy and iommufd currently.
As this patch introduces the object, you describe what the object is
meant for and used for. Maybe reuse text from the cover letter

Thanks

Eric
>
> Introduce a helper function host_iommu_base_device_init to initialize it.
>
> Suggested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/sysemu/host_iommu_device.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 include/sysemu/host_iommu_device.h
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


