Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86CC606A33E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 12:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e5QFp0tm;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=syo89DOQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPJDX-00024H-UK; Fri, 06 Nov 2026 07:38:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xPJD2-000229-7q
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 07:38:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xPJD0-00013s-3p
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 07:38:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793968697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=p5zW4QfFAHTTA1kbcScUb2i0ypopriqFfz1j8LzLnZs=;
 b=e5QFp0tmU0TN7BIkY59klepJ7UOgMRTjzi/janOnz1qCXiGxgajeZHz4S/JsDoQpzKbmNk
 kotCgZAmZd2y2DbkoJo0Q4zgFrXEXzcIDlO2LyTjgt10Yc+1HSigS0vsv+SW/vHtDRLGs+
 uUCQm5W7ILk/yqSx91y/VqrtJxdw7fo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-H6ggQSn2PgOBOdxvK0ELNw-1; Fri, 06 Nov 2026 07:38:16 -0500
X-MC-Unique: H6ggQSn2PgOBOdxvK0ELNw-1
X-Mimecast-MFC-AGG-ID: H6ggQSn2PgOBOdxvK0ELNw_1793968695
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4931c89d228so347494f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 04:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793968695; x=1794573495; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=p5zW4QfFAHTTA1kbcScUb2i0ypopriqFfz1j8LzLnZs=;
 b=syo89DOQke0ucGiCJtENfSBbQxhR7mWmZWA71hSvk6ybRI29tFZc6Y7zuLsN/EA0f1
 PmDyFWxAfpOoyRN6RLtRZXYa2CnvROgU34sn2gJ6cu5gTy0rb3IitF8iVRP/lNcDEMWI
 vcNTLzir/glL1u8T+aUB1VQmsREs6HGPBg6c2JKcGp8xDV2hfqSSRpRlhKoGCi9T9vjT
 po4Zx/UYnWe3lVmcfx9Q3rOp9hYcJgE2xJly+Ti0DV5JNdYCUiKrsaj890jNmBVRN6YV
 Er7zwD+DCDDm3egFasSR9hizQgDDh9Cxv4j5t4e4W9kQtDkSigcGyufN1Q9OyMIdgkhs
 d4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793968695; x=1794573495;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p5zW4QfFAHTTA1kbcScUb2i0ypopriqFfz1j8LzLnZs=;
 b=vMqSCBQhRpzkk4cJljQaWylKrgOnNBnUodB4tpgDikkIiWb+w50FzsYILx4a8uu4nJ
 VQ0WdiTI5/ZNGVqKQXxB6GlKHu9u161M29fph/QKdxwlqWgSdW0B7mPLbaknRqmJX0Ei
 F707BNtuqAZwWSW0coI9g0eM9URYW8ZjCqXlOjRHcvFze5OlyxXzWpkN3UVux8f0ENiz
 49XIKIF2G7r/GEGd/uVJhLUlJApBBm9Oa2IEkXVmz8YRK48AOkr7oB9Qozikp3M47qm5
 pEprgRNQx2+riBpexP7YEArv6a9b3f5+dvy4XSYEUcr7nV63WrR7CUth/o87N7P6Ku7d
 TLVQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFrWc9tqM+UJ1mwD7CQ8W5AqiNAPx8bD4/nEN/DuLHGtJUMqlbEDCHumt+tG4VBgGHbgnhq5WNu/1Ho@nongnu.org
X-Gm-Message-State: APuU4Z/x6WdoY8o9ELl7/CCAS7sc8oNfq/wjUiW4BUuWeNXJrt9UszHa
 Z5PcOleyEY2hJcTXUdpqgsD2CsxmN6HuOw0Bb8KCOdB3exhoUTN1u3v9B5RrAyZDMk7wOEdaYbN
 DE5rkXdMoWxeH7VuVlZYc1nEp/77U5KhgutMMkZac92EVMdmCvMq/7SWw
X-Gm-Gg: AYBFou3PYxruQolOaDQy43GiHsbAnGmRqjOuLLwpP1unkToeVV9N62RvMjqxq9qQ5SW
 7S2aHdtz9nh2u6NP7Y/zIHFkx6mY7YI3siLkMPUjdtcjLuoQn8aoHozXvmso4NGpQRtlOFWJ/vR
 4Kp+Keb5qxO65yXYr0oHivrZfuSy/QhNfvh2SaJctsDui/syp4YCIjom5lZbEGCKO8SBBP+feWX
 WUxJ848nHZ47PSHO9pOX4/u//8I8VSM343RtZcDMsX2X/Ij5RBIcSxWEAVhAyQv0p6CmIEnFdWn
 EU13DTOWeTmboyInyv48s0ctdZxCimaW2dm/otmta4w/VHqKeUqDqSqp87SDUbBj68vZ1xH79un
 OJ7hTluo7ox6hSOPAVX/T+c37yUpo2HkaPIM00Fgbx8SAI6PnRWO9gQl8CIJjf1nqLJ6NNHp8f2
 h3wfm+z/hlkQ==
X-Received: by 2002:adf:e84c:0:b0:48d:e5c9:39a4 with SMTP id
 ffacd0b85a97d-492775eef16mr3852336f8f.33.1793968694700; 
 Fri, 06 Nov 2026 04:38:14 -0800 (PST)
X-Received: by 2002:adf:e84c:0:b0:48d:e5c9:39a4 with SMTP id
 ffacd0b85a97d-492775eef16mr3852286f8f.33.1793968694262; 
 Fri, 06 Nov 2026 04:38:14 -0800 (PST)
Received: from ?IPV6:2a01:599:b03:7322:436f:1f3:b26e:91b8?
 ([2a01:599:b03:7322:436f:1f3:b26e:91b8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d84726basm3751753f8f.57.2026.11.06.04.38.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 04:38:13 -0800 (PST)
Message-ID: <6d195593-7cf4-40b2-8143-098771967876@redhat.com>
Date: Fri, 6 Nov 2026 13:38:12 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/28] hw/pci-host: mark common x86, ppc, arm and s390
 PCI hosts as secure
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>
References: <20261029131241.2275706-1-berrange@redhat.com>
 <20261029131241.2275706-15-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20261029131241.2275706-15-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 29/10/2026 14.12, Daniel P. Berrangé wrote:
> Mark the PCI hosts secure if they are used from machine types
> that are considered for the virtualization use case.
> 
> There is also a special case for the 'remote' type and the
> Xen passthrough type.
> 
> Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Acked-by: Cornelia Huck <cohuck@redhat.com> #s390
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
...
> diff --git a/hw/pci-host/pnv_phb.c b/hw/pci-host/pnv_phb.c
> index 0b556d1bf5c..bc8313d2cd0 100644
> --- a/hw/pci-host/pnv_phb.c
> +++ b/hw/pci-host/pnv_phb.c
> @@ -333,6 +333,7 @@ static const TypeInfo pnv_phb_type_info = {
>       .parent        = TYPE_PCIE_HOST_BRIDGE,
>       .instance_size = sizeof(PnvPHB),
>       .class_init    = pnv_phb_class_init,
> +    .secure        = true,
>   };
>   
>   static const TypeInfo pnv_phb_root_port_info = {
> @@ -340,6 +341,7 @@ static const TypeInfo pnv_phb_root_port_info = {
>       .parent        = TYPE_PCIE_ROOT_PORT,
>       .instance_size = sizeof(PnvPHBRootPort),
>       .class_init    = pnv_phb_root_port_class_init,
> +    .secure        = true,
>   };
>   
>   static void pnv_phb_register_types(void)
> diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
> index db061c134e9..abf43e3226d 100644
> --- a/hw/pci-host/pnv_phb3.c
> +++ b/hw/pci-host/pnv_phb3.c
> @@ -910,6 +910,7 @@ static const TypeInfo pnv_phb3_iommu_memory_region_info = {
>       .parent = TYPE_IOMMU_MEMORY_REGION,
>       .name = TYPE_PNV_PHB3_IOMMU_MEMORY_REGION,
>       .class_init = pnv_phb3_iommu_memory_region_class_init,
> +    .secure = true,
>   };
>   
>   /*
> @@ -1123,6 +1124,7 @@ static const TypeInfo pnv_phb3_type_info = {
>       .instance_size = sizeof(PnvPHB3),
>       .class_init    = pnv_phb3_class_init,
>       .instance_init = pnv_phb3_instance_init,
> +    .secure        = true,
>   };
>   
>   static void pnv_phb3_root_bus_get_prop(Object *obj, Visitor *v,
> @@ -1186,6 +1188,7 @@ static const TypeInfo pnv_phb3_root_bus_info = {
>       .parent = TYPE_PCIE_BUS,
>       .instance_size = sizeof(PnvPHB3RootBus),
>       .class_init = pnv_phb3_root_bus_class_init,
> +    .secure = true,
>   };
>   
>   static void pnv_phb3_register_types(void)
> diff --git a/hw/pci-host/pnv_phb3_msi.c b/hw/pci-host/pnv_phb3_msi.c
> index 66ba7b79134..5edc0d43eb0 100644
> --- a/hw/pci-host/pnv_phb3_msi.c
> +++ b/hw/pci-host/pnv_phb3_msi.c
> @@ -306,6 +306,7 @@ static const TypeInfo phb3_msi_info = {
>       .class_init = phb3_msi_class_init,
>       .class_size = sizeof(ICSStateClass),
>       .instance_init = phb3_msi_instance_init,
> +    .secure = true,
>   };
>   
>   static void pnv_phb3_msi_register_types(void)
> diff --git a/hw/pci-host/pnv_phb3_pbcq.c b/hw/pci-host/pnv_phb3_pbcq.c
> index 1f7a149580d..687c8325158 100644
> --- a/hw/pci-host/pnv_phb3_pbcq.c
> +++ b/hw/pci-host/pnv_phb3_pbcq.c
> @@ -354,6 +354,7 @@ static const TypeInfo pnv_pbcq_type_info = {
>       .instance_size = sizeof(PnvPBCQState),
>       .instance_init = phb3_pbcq_instance_init,
>       .class_init    = pnv_pbcq_class_init,
> +    .secure        = true,
>       .interfaces    = (const InterfaceInfo[]) {
>           { TYPE_PNV_XSCOM_INTERFACE },
>           { }
> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> index ac09a0b034d..1a652110f5d 100644
> --- a/hw/pci-host/pnv_phb4.c
> +++ b/hw/pci-host/pnv_phb4.c
> @@ -1388,6 +1388,7 @@ static const TypeInfo pnv_phb4_iommu_memory_region_info = {
>       .parent = TYPE_IOMMU_MEMORY_REGION,
>       .name = TYPE_PNV_PHB4_IOMMU_MEMORY_REGION,
>       .class_init = pnv_phb4_iommu_memory_region_class_init,
> +    .secure = true,
>   };
>   
>   /*
> @@ -1729,13 +1730,13 @@ static const TypeInfo pnv_phb4_type_info = {
>       .instance_init = pnv_phb4_instance_init,
>       .instance_size = sizeof(PnvPHB4),
>       .class_init    = pnv_phb4_class_init,
> +    .secure        = true,
>       .interfaces = (const InterfaceInfo[]) {
>               { TYPE_XIVE_NOTIFIER },
>               { },
>       }
>   };
>   
> -
>   static void pnv_phb4_root_bus_get_prop(Object *obj, Visitor *v,
>                                          const char *name,
>                                          void *opaque, Error **errp)
> @@ -1797,6 +1798,7 @@ static const TypeInfo pnv_phb4_root_bus_info = {
>       .parent = TYPE_PCIE_BUS,
>       .instance_size = sizeof(PnvPHB4RootBus),
>       .class_init = pnv_phb4_root_bus_class_init,
> +    .secure = true,
>   };
>   
>   static void pnv_phb4_register_types(void)
> diff --git a/hw/pci-host/pnv_phb4_pec.c b/hw/pci-host/pnv_phb4_pec.c
> index ee5cdc3e450..280a15e8df1 100644
> --- a/hw/pci-host/pnv_phb4_pec.c
> +++ b/hw/pci-host/pnv_phb4_pec.c
> @@ -388,6 +388,7 @@ static const TypeInfo pnv_pec_type_info = {
>       .instance_size = sizeof(PnvPhb4PecState),
>       .class_init    = pnv_pec_class_init,
>       .class_size    = sizeof(PnvPhb4PecClass),
> +    .secure        = true,
>       .interfaces    = (const InterfaceInfo[]) {
>           { TYPE_PNV_XSCOM_INTERFACE },
>           { }

The changes to the pnv* files are related to the powernv machine - which is 
not covered by the virtualization use case. Please remove these from your patch.


> diff --git a/hw/pci-host/remote.c b/hw/pci-host/remote.c
> index 9ea95fac6e6..a58fc39bded 100644
> --- a/hw/pci-host/remote.c
> +++ b/hw/pci-host/remote.c
> @@ -63,6 +63,7 @@ static const TypeInfo remote_pcihost_info = {
>       .parent = TYPE_PCIE_HOST_BRIDGE,
>       .instance_size = sizeof(RemotePCIHost),
>       .class_init = remote_pcihost_class_init,
> +    .secure = true,
>   };
This is part of the "remote" machine, isn't it? I don't think we cover this 
in the virtualization use case, do we? Please remove this, too.

  Thomas



