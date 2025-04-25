Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF744C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 09:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8FBX-0005vS-C6; Fri, 25 Apr 2025 05:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u8FBV-0005ui-PK
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 05:17:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u8FBR-0006rP-Do
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 05:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745572639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7O6uTca/+r5QI4AIONjB9wp9gfg/4SplKOIlMqXO/0A=;
 b=jBDivObmm4pStB57Hpqkqtd8bjyFBlCVyPfpmWxjArS9DeNhGguNNOYHjGx5Jp8SYrfy2q
 rWzQGUDeTUpR7HVq2XPbG1LjKqMnsw8z6zsNDD+476s6Is+VfkonHvSCmT24yS0ARpeff6
 dT7z7mSsfh7ihsIcE2R1s6WZ+FYZDZI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-ytWc31L5OPWHkAs-LPz6DA-1; Fri, 25 Apr 2025 05:17:18 -0400
X-MC-Unique: ytWc31L5OPWHkAs-LPz6DA-1
X-Mimecast-MFC-AGG-ID: ytWc31L5OPWHkAs-LPz6DA_1745572637
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39ee57e254aso967209f8f.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 02:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745572637; x=1746177437;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7O6uTca/+r5QI4AIONjB9wp9gfg/4SplKOIlMqXO/0A=;
 b=OeSRdstgwQ9xJ/GIHv1hU4g0Ne8ZSX1txa02LyJcRKrfoSBLvch4mzYs/aPL3hwSZE
 +zH+yvMzwTGrbUE3X9MXeXyPRA7xGK2iabejEPuTu8oY2oTpnlN8ZiisMD9lteI3mPP1
 X1rQuiNlc9lVh3ZHz575txPM9CW97M04SPDyOLiAZ7KP/hyP6u6CueWdM/DT2yLzRK4f
 UNyfew6HMXcDKy3/ujwj77JBbw6amhtzsygzUn7uNJn3xU7Wd6QGas9eXcTWyDMMnYhu
 N/mqA9kOXx2QNG0HMAWLNGtlTUB7PRnGMMqDzLGU5OZIYCk83ux+KTEIGJWmp22Vol88
 ciEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN58cLpq+KURuxrWhBkt/xCgewDzk08AQKMc4Vs4Oi0UGw9RT0f8QQmmM0fhiXInPxwbKGurC5M3zG@nongnu.org
X-Gm-Message-State: AOJu0Ywiy6XMHiSQ8HoTN33hncPyIEJK2t12hkIv9huOAbcW0erbrKhh
 tLVP/d8JuApeIZ6xP2A+VDShhK+AKvHYEzkbUGNdP3zmb1IIX/En9w9YMPqJM+EjN1eMpYtDL+D
 Rh6kAW+PtBpctZ4mJZrBmOmr4HYBkbXR19DJEtpv/6Spmhp2ipnkw
X-Gm-Gg: ASbGncskoprxU1QlzeRMrCMhF2I+qV7nIRh8HBi22jY1mOR/nQsK/kqXSP1v5qn4+p4
 ajEdQbBpA9jtyYFMKEpW5uzm2WVxMyRGQI8HJF56Ln3RaTp4wfVRZ7eFQndKUcUSwvi6EX3jhSE
 jV0rqhbKJHQjEYhNQSzvL8p+JsRryG+X2snMEQcr0izURwsmtwojKQGUeR4jzK/AyKj3H6S+KcH
 rksOTzetd135wDdHuY+R9eT+FsQItKAjf4bP5AnqSH+GJMXHlM0Io1xZHtLPIwSKhMcU7NxAByk
 RRvA6TKtt8giH6sevfo84D6BOJYGJre7Onoj1H1NIldNBA==
X-Received: by 2002:a5d:5986:0:b0:39e:e588:672f with SMTP id
 ffacd0b85a97d-3a074f854aamr1260772f8f.55.1745572637203; 
 Fri, 25 Apr 2025 02:17:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECKQzntTP30uyuxB6xEgPxj45RqgS0QVy0tbzIaaez78F+BAM1qnBeElpDtcz56F3TCah9aw==
X-Received: by 2002:a5d:5986:0:b0:39e:e588:672f with SMTP id
 ffacd0b85a97d-3a074f854aamr1260744f8f.55.1745572636838; 
 Fri, 25 Apr 2025 02:17:16 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-43-178-177.web.vodafone.de.
 [109.43.178.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5c6a0sm1721190f8f.86.2025.04.25.02.17.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 02:17:16 -0700 (PDT)
Message-ID: <8decd67b-f1f7-4dcb-b2d5-519ea907e317@redhat.com>
Date: Fri, 25 Apr 2025 11:17:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] include: Add a header to define host PCI MMIO
 functions
To: Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, stefanha@redhat.com, mjrosato@linux.ibm.com,
 schnelle@linux.ibm.com, philmd@linaro.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net
References: <20250417173801.827-1-alifm@linux.ibm.com>
 <20250417173801.827-3-alifm@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250417173801.827-3-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 17/04/2025 19.38, Farhan Ali wrote:
> Add a generic API for host PCI MMIO reads/writes
> (e.g. Linux VFIO BAR accesses). The functions access
> little endian memory and returns the result in
> host cpu endianness.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>   include/qemu/host-pci-mmio.h | 141 +++++++++++++++++++++++++++++++++++
>   1 file changed, 141 insertions(+)
>   create mode 100644 include/qemu/host-pci-mmio.h
> 
> diff --git a/include/qemu/host-pci-mmio.h b/include/qemu/host-pci-mmio.h
> new file mode 100644
> index 0000000000..c93f77dcd4
> --- /dev/null
> +++ b/include/qemu/host-pci-mmio.h
> @@ -0,0 +1,141 @@
> +/*
> + * API for host PCI MMIO accesses (e.g. Linux VFIO BARs)
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Farhan Ali <alifm@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HOST_PCI_MMIO_H
> +#define HOST_PCI_MMIO_H
> +
> +#include "qemu/bswap.h"
> +#include "qemu/s390x_pci_mmio.h"
> +
> +

Cosmetic nit: It's more common in QEMU to only use one empty line instead of 
two.

> +static inline uint8_t host_pci_ldub_p(const void *ioaddr)
> +{
> +    uint8_t ret = 0;
> +#ifdef __s390x__
> +    ret = s390x_pci_mmio_read_8(ioaddr);
> +#else
> +    ret = ldub_p(ioaddr);
> +#endif
> +
> +    return ret;
> +}
> +
> +static inline uint16_t host_pci_lduw_le_p(const void *ioaddr)
> +{
> +    uint16_t ret = 0;
> +#ifdef __s390x__
> +    ret = le16_to_cpu(s390x_pci_mmio_read_16(ioaddr));
> +#else
> +    ret = lduw_le_p(ioaddr);
> +#endif
> +
> +    return ret;
> +}
> +
> +static inline uint32_t host_pci_ldl_le_p(const void *ioaddr)
> +{
> +    uint32_t ret = 0;
> +#ifdef __s390x__
> +    ret = le32_to_cpu(s390x_pci_mmio_read_32(ioaddr));
> +#else
> +    ret = (uint32_t)ldl_le_p(ioaddr);

This is the only spot where you used a cast. Is it necessary, or could it be 
omitted?

> +#endif
> +
> +    return ret;
> +}
> +
> +static inline uint64_t host_pci_ldq_le_p(const void *ioaddr)
> +{
> +    uint64_t ret = 0;
> +#ifdef __s390x__
> +    ret = le64_to_cpu(s390x_pci_mmio_read_64(ioaddr));
> +#else
> +    ret = ldq_le_p(ioaddr);
> +#endif
> +
> +    return ret;
> +}
> +
> +static inline void host_pci_stb_le_p(void *ioaddr, uint8_t val)
> +{
> +

Remove the empty line, please.

> +#ifdef __s390x__
> +    s390x_pci_mmio_write_8(ioaddr, val);
> +#else
> +    stb_p(ioaddr, val);
> +#endif
> +}
> +
> +static inline void host_pci_stw_le_p(void *ioaddr, uint16_t val)
> +{
> +

dito.

> +#ifdef __s390x__
> +    s390x_pci_mmio_write_16(ioaddr, cpu_to_le16(val));
> +#else
> +    stw_le_p(ioaddr, val);
> +#endif
> +}
> +
> +static inline void host_pci_stl_le_p(void *ioaddr, uint32_t val)
> +{
> +

dito.

> +#ifdef __s390x__
> +    s390x_pci_mmio_write_32(ioaddr, cpu_to_le32(val));
> +#else
> +    stl_le_p(ioaddr, val);
> +#endif
> +}
> +
> +static inline void host_pci_stq_le_p(void *ioaddr, uint64_t val)
> +{
> +

dito

> +#ifdef __s390x__
> +    s390x_pci_mmio_write_64(ioaddr, cpu_to_le64(val));
> +#else
> +    stq_le_p(ioaddr, val);
> +#endif
> +}
> +
> +static inline uint64_t host_pci_ldn_le_p(const void *ioaddr, int sz)
> +{
> +    switch (sz) {
> +    case 1:
> +        return host_pci_ldub_p(ioaddr);
> +    case 2:
> +        return host_pci_lduw_le_p(ioaddr);
> +    case 4:
> +        return host_pci_ldl_le_p(ioaddr);
> +    case 8:
> +        return host_pci_ldq_le_p(ioaddr);
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +static inline void host_pci_stn_le_p(void *ioaddr, int sz, uint64_t v)
> +{
> +    switch (sz) {
> +    case 1:
> +        host_pci_stb_le_p(ioaddr, v);
> +        break;
> +    case 2:
> +        host_pci_stw_le_p(ioaddr, v);
> +        break;
> +    case 4:
> +        host_pci_stl_le_p(ioaddr, v);
> +        break;
> +    case 8:
> +        host_pci_stq_le_p(ioaddr, v);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +#endif

Apart from the nits, patch looks good to me.

  Thomas


