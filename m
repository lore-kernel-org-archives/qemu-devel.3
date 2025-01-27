Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8CDC02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 14:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcPsS-0007IG-EI; Mon, 27 Jan 2025 09:14:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tcPsB-0007Fc-VJ
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 09:13:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tcPs9-0001dO-1x
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 09:13:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737987231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KUo9JUYZWDWybvRBzs3FvJpvv1MHztGo1UsEJXYcnmI=;
 b=DIx/d0foU7wenD8p++CfrHyNUgmiA8zYYrQ619Mxtsy6YhhMrSZnJDhDdIt2DF/AK1H4vV
 aHS61eDB+HvS4qs5zFKJ+YYAKYWwWQiJAphelm5afYpZ9vxH8f9xZTRULmlH6lwKpZX7Sk
 G/L7y3LjW43Vu382hPlLKlYRVpdM/bY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-AmWH5dlnOTeg4CsAG6jxPA-1; Mon, 27 Jan 2025 09:13:48 -0500
X-MC-Unique: AmWH5dlnOTeg4CsAG6jxPA-1
X-Mimecast-MFC-AGG-ID: AmWH5dlnOTeg4CsAG6jxPA
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4361f371908so30673305e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 06:13:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737987227; x=1738592027;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KUo9JUYZWDWybvRBzs3FvJpvv1MHztGo1UsEJXYcnmI=;
 b=HnlDK47VhhHbIWEOdgUGyJZRe2fGQo+iMFb/XuActALbrQB6qpyTzOd+Xf8coEzaRw
 P1MI0/Rup86POn8dM9/PeryrDwCZYOQI7gSI8KMRUkJUACAFyEZqRWvdvBjMiRftj7o/
 Iv6KToqOu9SlhRBn5GPS7aNjExOV4Rkk8t5sVtCSOCr6OEVNHW5BmMPeTJqkxDYM4Och
 tFPI8x1GuLTG3ISaX5iKUlODFvq3kxzKDChH/xtgnjr1R5l5XTiN0aQPuNcyvBqQE3LB
 qBpzE9PMzOJLovpDaAxJ5jJc59PVsjNZUqU7rRgzgRu50L0awB4e3kt6qud0/Lwoizqg
 rXKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrHeKQXhAsLgcSqxGrKVQZWVdATiNysnphJw/UmBBMIiUpU1vKQxZWllhX6OVHb9pmvNTh3/JaMtX1@nongnu.org
X-Gm-Message-State: AOJu0Yyw+V6ptwuccfCS2Lzbq3KBBsM9vFFzOjpTC8fRsyOwUiLcub7l
 lE14MWwtjaM7WLFJgNBPqwWjTvNvPfmCVN1UMwRxGhg1UGHVvrVC1R4h8wo/WUpgEGpOHk7XfKg
 jt1UpsvPj+hNHdGQbQBuFMG3q+jIDt2Q0OsqhcL5+YIZrSsWQ8MWf
X-Gm-Gg: ASbGncsdFGlAHiAf62LU/GZPouqNsVCtPDcscrrC9dEd52gY/LrOTcnit/bMEcB2pip
 t4bhuuYm7ouz83tvnqRt+0YEm74TsaG/0HowCyeWKEKi+jSSRTLyJC0LAJNQO0EN5dnStWLbVDy
 LZ/40s5Kx1BEuXiYQDdf1HzUlir0IKyz1CXGn/3jVjmvLKfggtCFoi2UtPnFlr56qRyXNzwml1c
 a6ubgVp1W6FgBdgaoM7kjYTFbM+oh6VJPZquHJuEvijneLejbICSdacfaLw/54EjzR/PcbvRtWN
 F3J/B/KOHlZ3KDuO4GBHaMdRQVbgQA==
X-Received: by 2002:a05:600c:a07:b0:434:f9c4:a850 with SMTP id
 5b1f17b1804b1-438913cb16emr400114455e9.10.1737987226821; 
 Mon, 27 Jan 2025 06:13:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsXP482El/+CbTo1QizpX/xu08jsppn7qJEvnEWlSu1OsbYArdqC9svNNl8cwMZ2JM+GMwvA==
X-Received: by 2002:a05:600c:a07:b0:434:f9c4:a850 with SMTP id
 5b1f17b1804b1-438913cb16emr400114195e9.10.1737987226468; 
 Mon, 27 Jan 2025 06:13:46 -0800 (PST)
Received: from [10.33.192.228] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd43cdbbsm133229055e9.0.2025.01.27.06.13.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 06:13:46 -0800 (PST)
Message-ID: <209cba11-2fb3-404f-bbe4-e02b8e2595dd@redhat.com>
Date: Mon, 27 Jan 2025 15:13:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] s390x/pci: add support for guests that request
 direct mapping
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, schnelle@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, clegoate@redhat.com, qemu-devel@nongnu.org
References: <20250124202115.349386-1-mjrosato@linux.ibm.com>
 <20250124202115.349386-2-mjrosato@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250124202115.349386-2-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 24/01/2025 21.21, Matthew Rosato wrote:
> When receiving a guest mpcifc(4) or mpcifc(6) instruction without the T
> bit set, treat this as a request to perform direct mapping instead of
> address translation.  In order to facilitate this, pin the entirety of
> guest memory into the host iommu.
> 
> Pinning for the direct mapping case is handled via vfio and its memory
> listener.  Additionally, ram discard settings are inherited from vfio:
> coordinated discards (e.g. virtio-mem) are allowed while uncoordinated
> discards (e.g. virtio-balloon) are disabled.
> 
> Subsequent guest DMA operations are all expected to be of the format
> guest_phys+sdma, allowing them to be used as lookup into the host
> iommu table.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
...
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index e386d75d58..4c108fa8c4 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -16,6 +16,7 @@
>   #include "exec/memory.h"
>   #include "qemu/error-report.h"
>   #include "system/hw_accel.h"
> +#include "hw/boards.h"
>   #include "hw/pci/pci_device.h"
>   #include "hw/s390x/s390-pci-inst.h"
>   #include "hw/s390x/s390-pci-bus.h"
> @@ -1008,17 +1009,25 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
>       }
>   
>       /* currently we only support designation type 1 with translation */
> -    if (!(dt == ZPCI_IOTA_RTTO && t)) {
> +    if (t && !(dt == ZPCI_IOTA_RTTO)) {

While you're at it, you could change that "!(dt == ZPCI_IOTA_RTTO)" into
"dt != ZPCI_IOTA_RTTO".

>           error_report("unsupported ioat dt %d t %d", dt, t);
>           s390_program_interrupt(env, PGM_OPERAND, ra);
>           return -EINVAL;
> +    } else if (!t && !pbdev->rtr_allowed) {
> +        error_report("relaxed translation not allowed");

Not sure, but maybe better use qemu_log_mask(LOG_GUEST_ERROR, ...) instead?

> +        s390_program_interrupt(env, PGM_OPERAND, ra);
> +        return -EINVAL;
>       }

  Thomas


