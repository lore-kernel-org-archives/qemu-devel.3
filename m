Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF9CCD3447
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 12:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLK0U-0008HW-VX; Fri, 08 May 2026 08:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wLK0P-0008GY-RX
 for qemu-devel@nongnu.org; Fri, 08 May 2026 08:08:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wLK0M-0006wo-Uf
 for qemu-devel@nongnu.org; Fri, 08 May 2026 08:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778242108;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kT24KiX6bIOQJcUn/CX+tGn/Ogd+de60J2c97e6J6DM=;
 b=iWCBUXdjKtK4gjQB8KcK3bWzCNecrM4LyfF3/GVVo8Gs8rxHYYE174c9gxmWVMr816RGf/
 Q90k01DBrQGbIdwfCFcaxuY4MmRCFuxl3pb4nZofAvpTVp9Sfso9ziWpXQU/Tw061hKv7V
 9F2kwX4dGYUL5wQtOkgubby/HhZzUF8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-xTJVR6M2PImSxLx-pGa1iQ-1; Fri, 08 May 2026 08:08:27 -0400
X-MC-Unique: xTJVR6M2PImSxLx-pGa1iQ-1
X-Mimecast-MFC-AGG-ID: xTJVR6M2PImSxLx-pGa1iQ_1778242106
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48e51dc35a3so15348875e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 05:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778242106; x=1778846906;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kT24KiX6bIOQJcUn/CX+tGn/Ogd+de60J2c97e6J6DM=;
 b=crrMf+cT1uX5ikYw5LEb9iX6fI5e+KmAHVB5cqYxG4QXfSXmMVlqy7SAuZ+GIPHIDC
 YxA6OfImXM5Vo6eQxhCLqFSxyoT8gcHu3CfVUMP8cA9E4Pbi5tx6kxASo1kTf9D8qs2y
 +18QRvGMFrGYnndEwi/z+GCovSG5oLIvUAllq6SZ/LO9LU1vteO+RGKXuMLuYR70cCDW
 BQOhYKj81ARUblRPka2QwMs3w/ZwpUWFGT3qTn9CRjdDVbagKb/X5nJGy97JdzwqkIFy
 LCGW/8wURq6kRtCXs7fJ+Lw5L+ngVC6LA+G0yTfud0+Grxxd+hE7pcLnJ4RWCzHSU4Zq
 KGmQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Mr/7a/y6Tsmd8fSccjpMO7SYzoAaKSk1cZ7tr7fMcBwcpOk89w1UIQ4kNQk0dZQBIyDM1/fvlLXfC@nongnu.org
X-Gm-Message-State: AOJu0YzwRllsoQNFIkbNSBixXcg+8A+vlrnjrJkZkE9HEUF9r1pl04zO
 pYPzJUNRSLqWynPttSQq2Jd72HaYKElFfQ81vkEosY6MISq/CjtzmhHDJhIoh6OXJJ3mnTn9SMe
 FDAV6OnMBU8VPsY5IAvvTmTL8WKCV6RV34M42yaTusdNtjOV7GjkH1y/C
X-Gm-Gg: AeBDiesOViKGKEJABbFo0oNTt9foHcCqRztP9BilGhCs39AKiCEmk4MePBHkZNSbQih
 Axn8SXhm98CgzFpmiig+6WE4H0IdlKPc/zQ/30Puns76S3X159NWkxkUGFxiHEROUZse+y32JXw
 OI3oj8slTlM8y0rROicWJMRRv6yJzL5ZeY3LOu0C8PSypShtUIVabZobjYpudwhAu990sYlKbOU
 rU493SPML39JHTgvqTxWEruBDMvzYYLW4oAYAqlQo3caHcKGCNi8xjjUBklt1ULeY1JjbeG+Xu/
 DwaL0sbBR8KFkuM7HcSD4yzcy5OKc/hkNJQzjEIVEOVJrQ/bz8qSdp8eQA07X0LeaIEFHyYn2N3
 PFHCrKg/wJtIR32EAuxIqoxBIUA3uVii407ZnOCbC7+cjWxPtUwW9vPsyr6/CCO86KIEowA==
X-Received: by 2002:a05:600c:470a:b0:488:a639:b772 with SMTP id
 5b1f17b1804b1-48e51e15485mr195442475e9.7.1778242105905; 
 Fri, 08 May 2026 05:08:25 -0700 (PDT)
X-Received: by 2002:a05:600c:470a:b0:488:a639:b772 with SMTP id
 5b1f17b1804b1-48e51e15485mr195441735e9.7.1778242105283; 
 Fri, 08 May 2026 05:08:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e642d1b70sm19942565e9.2.2026.05.08.05.08.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 05:08:24 -0700 (PDT)
Message-ID: <cfdc0d2e-59ed-4460-adb2-23dee2ca157b@redhat.com>
Date: Fri, 8 May 2026 14:08:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] qemu-options.hx: Support "auto" for accel SMMUv3
 properties
Content-Language: en-US
To: Nathan Chen <nathanc@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20260422204335.23116-1-nathanc@nvidia.com>
 <20260422204335.23116-8-nathanc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260422204335.23116-8-nathanc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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


Hi Nathan,
On 4/22/26 10:43 PM, Nathan Chen wrote:
> Update documentation now that "auto" is supported for accelerated SMMUv3
> properties.
>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  qemu-options.hx | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 21972f8326..2c6ba16a26 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1291,30 +1291,43 @@ SRST
>          Enabling accel configures the host SMMUv3 in nested mode to support
>          vfio-pci passthrough.
>  
> -     The following options are available when accel=on.
> -     Note: 'auto' mode is not currently supported.
> -
> -    ``ril=on|off`` (default: on)
> +     The following options will be set to auto by default if not manually
> +     set. When accel=on and these properties are set to auto, the value is
> +     derived from the host SMMUv3 capabilities via IOMMU_GET_HW_INFO. With
> +     accel=on, this requires at least one cold-plugged vfio-pci device; if
> +     none is present at machine init, QEMU will abort.
> +
> +     If accel=off and these property values are set to auto, the values will
> +     not be derived from the host SMMUv3 capabilities. Instead, they will
> +     resolve to the defaults described below, and a cold-plugged vfio-pci
> +     device is not required.
I would simply say:

If accel=off auto values resolve to the non accel default given below.


> +
> +    ``ril=on|off`` (default: auto)
ril=on|off|auto (default: auto)
          -------

I would rewrite it into:

Support for Range Invalidation, which allows the SMMUv3 driver to
invalidate TLB entries for a range of IOVAs at once instead of issuing
separate commands to invalidate each page. 
- with accel=on auto means the value is automatically derived from the host SMMU
  if explicitly set to 'on', the host must also support it.
- with accel=off auto is resolved into 'on'

If we have this explanation here in object_class_property_set_description()
just explain the basic semantic and list the valid values and default value.
No use to rexplain the auto mode semantic.



>          Support for Range Invalidation, which allows the SMMUv3 driver to
>          invalidate TLB entries for a range of IOVAs at once instead of issuing
>          separate commands to invalidate each page. Must match with host SMMUv3
> -        Range Invalidation support.
> +        Range Invalidation support. If accel=off and ril is set to auto, this
> +        property value will resolve to on.
Same for the others ...

Thanks

Eric
>  
> -    ``ats=on|off`` (default: off)
> +    ``ats=on|off`` (default: auto)
>          Support for Address Translation Services, which enables PCIe devices to
>          cache address translations in their local TLB and reduce latency. Host
>          SMMUv3 must support ATS in order to enable this feature for the vIOMMU.
> +        If accel=off and ats is set to auto, the property value will resolve to
> +        off.
>  
> -    ``oas=val`` (supported values are 44 and 48. default: 44)
> +    ``oas=val`` (supported values are 44 and 48. default: auto)
>          Sets the Output Address Size in bits. The value set here must be less
>          than or equal to the host SMMUv3's supported OAS, so that the
>          intermediate physical addresses (IPA) consumed by host SMMU for stage-2
> -        translation do not exceed the host's max supported IPA size.
> +        translation do not exceed the host's max supported IPA size. If
> +        accel=off and oas is set to auto, the property value will resolve to 44.
>  
> -    ``ssidsize=val`` (val between 0 and 20. default: 0)
> +    ``ssidsize=val`` (val between 0 and 20. default: auto)
>          Sets the Substream ID size in bits. When set to a non-zero value,
>          PASID capability is advertised to the vIOMMU and accelerated use cases
> -        such as Shared Virtual Addressing (SVA) are supported.
> +        such as Shared Virtual Addressing (SVA) are supported. If accel=off
> +        and ssidsize is set to auto, the property value will resolve to 0.
>  
>  ``-device amd-iommu[,option=...]``
>      Enables emulation of an AMD-Vi I/O Memory Management Unit (IOMMU).


