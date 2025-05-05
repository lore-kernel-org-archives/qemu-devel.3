Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C044C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBsHT-0004n4-SH; Mon, 05 May 2025 05:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uBsHR-0004mF-Ou
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:38:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uBsHQ-000352-8v
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746437911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uzn7rvH7F/IQ6SMhkBPdLDP3L/8Na5c+GpQod4MMne8=;
 b=bLbc6FVOPLiESUV8qXMeZhTuKm4RVkhyc0BtN7fH4z12Af2rHOdcUR7fuN6NO8pLDy9ngl
 b/WZbThUVOHTrj27xAbmlB+Y2WKP25m3yngL5HCCrJg9r0rQagdf36lL6jwtJRD97nE61k
 HSlInLmg94DG+m+6IQe/U0mSsKl8IUQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-0zWjt4EkMCK4uwblD_i_uw-1; Mon, 05 May 2025 05:38:30 -0400
X-MC-Unique: 0zWjt4EkMCK4uwblD_i_uw-1
X-Mimecast-MFC-AGG-ID: 0zWjt4EkMCK4uwblD_i_uw_1746437909
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-441c122fa56so6462015e9.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 02:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746437909; x=1747042709;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uzn7rvH7F/IQ6SMhkBPdLDP3L/8Na5c+GpQod4MMne8=;
 b=DPgMVqv6XZTL9SatVt9ssZGFueXI0J0ZRpQ1bbPMqTTCgbjZLXiswvfCZHYPF1gKG+
 nssaYavLG205l/UUyp7qoXL8XeuiYd4X/bUUu+mqT+DbXi053UwxxzOS63rLynfy+p4B
 hq3u1FYm7NVK4UNFYagzn4nso7+SAf3cbD4PHI6c9KUANZlJ0qVxjvRYykRBY1Li01SP
 aufKWn3KM8Wv/6PxHmTBdRt67quaFBtNLSjUasdqH11LakFlVgO6/9+YrJE54Hgjs8fC
 i1nrLJtJDkQCryxBB+l3ZcnCc66xXLM4w+G5W6N3rpOY9EfINHMhmLQJREWb+fyPopQf
 U2eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyOT33IenMCEDBe86PVZsHdEjSOeoQQ07maWpxyl6ZIFH/j6GXv5YhL41GNkOK2HmegBYBbM+2b3r0@nongnu.org
X-Gm-Message-State: AOJu0Yx2PckDkPHhP7UuBbb1SBAQhiDF3vqNW3oJwvptJVGaizgQDPnM
 CjaE9fD/Kz+X0dNv7TMbpNZOd6w2dXrs2gdJOK6xLdhiLzHMZyI8u0Xl17J0d5hMaLybYs/DZkK
 t4ODFmqs064nvWi5kpBWVHqUMeVRq0MRcLsjvf6TDAHoyfQF5QsZm
X-Gm-Gg: ASbGncvTAb5V8JAqxJ7Q2KI5rTdILWKDgUN1GvEdbrdYBGMDL+LDcVcysfldzGIKufw
 1h3zP3EEoZBAy/kCEPwNcyGyYjMUKSuSQ00oWnLEclmM0onaTLJaXeV+8bgOXhMi8tsP6/gxOIP
 HQnsH4/mp+7xUSTPGUUdQFjzWIjZPMARIa7BpJuN83jU0bF7Ob19WrHjy7wiBdx61EcrJEzwHAV
 lvKlgv7Ul1OfQqpxsygx5lJM7a4SrJKtzigSKY5dHM+zMbsr2gQmrTxvjRShBG6mDyJGmDO3PMf
 od4SgHDuaAR/LxYMl5nqRguBQp2WCaiueNrEf5cj
X-Received: by 2002:a05:600c:1c27:b0:43d:609:b305 with SMTP id
 5b1f17b1804b1-441c1cfc494mr60598975e9.17.1746437908895; 
 Mon, 05 May 2025 02:38:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5gLo3uwWuj5RnjZP3iHHU7kCwiKclGgaSdDdYD4SA57dcKyQwGO8nNRYFAILKdsQxt4TQCw==
X-Received: by 2002:a05:600c:1c27:b0:43d:609:b305 with SMTP id
 5b1f17b1804b1-441c1cfc494mr60598665e9.17.1746437908526; 
 Mon, 05 May 2025 02:38:28 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-87.web.vodafone.de. [109.42.49.87])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441c0dfc537sm81483645e9.16.2025.05.05.02.38.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 02:38:28 -0700 (PDT)
Message-ID: <0e1bcc40-7429-4aec-8632-31cd49f9d333@redhat.com>
Date: Mon, 5 May 2025 11:38:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] include: Add a header to define host PCI MMIO
 functions
To: Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, stefanha@redhat.com, mjrosato@linux.ibm.com,
 schnelle@linux.ibm.com, philmd@linaro.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net
References: <20250430185012.2303-1-alifm@linux.ibm.com>
 <20250430185012.2303-3-alifm@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250430185012.2303-3-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 30/04/2025 20.50, Farhan Ali wrote:
> Add a generic API for host PCI MMIO reads/writes
> (e.g. Linux VFIO BAR accesses). The functions access
> little endian memory and returns the result in
> host cpu endianness.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
...
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
...
> +static inline void host_pci_stb_le_p(void *ioaddr, uint8_t val)
> +{
> +#ifdef __s390x__
> +    s390x_pci_mmio_write_8(ioaddr, val);
> +#else
> +    stb_p(ioaddr, val);
> +#endif
> +}

Cosmetic nit: host_pci_ldub_p() does not have a "_le_" in its name, while 
host_pci_stb_le_p() has it. Could be fixed up while picking up the patch, so 
no need to respin just because of this.

Reviewed-by: Thomas Huth <thuth@redhat.com>


