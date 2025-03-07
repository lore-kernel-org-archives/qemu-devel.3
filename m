Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E317EC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 17:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqbsL-0006gt-7C; Fri, 07 Mar 2025 12:52:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tqbsJ-0006gj-NN
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 12:52:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tqbsI-0004wI-8r
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 12:52:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741369961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uF76AsHNHgnRExU9nB+LtF0/BPRBtEd72Oi53mF7B2Y=;
 b=I8+0d7uQtE0KbhiJtFm5lD+vQwP1NzlDnCDp9PQLs1YkeebpOVEw1CMOz1E8bmG1fXAW2N
 ljoX/XcfXkrtoL9hpCB1cNRJX8YFMGwaY4EgSgUvDFvlNg9X50k6HoIEtMHXi5iMkBp42E
 Krz67h+rFu1Kfh5JqjdPNx/p/QpJ8R4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-eo70VBcTPDy7HYTaHq6v6w-1; Fri, 07 Mar 2025 12:52:37 -0500
X-MC-Unique: eo70VBcTPDy7HYTaHq6v6w-1
X-Mimecast-MFC-AGG-ID: eo70VBcTPDy7HYTaHq6v6w_1741369956
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3912b54611dso1305998f8f.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 09:52:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741369956; x=1741974756;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=uF76AsHNHgnRExU9nB+LtF0/BPRBtEd72Oi53mF7B2Y=;
 b=f6fFxW0+O+etzpxPmDT75HSfhqRV7K26AUYiqsT8b0Bw1g6HawtuNEcWKC7Wi6kMfI
 zYHcXZGtDYvaimGVMcRCMfRofIVk9vmH718st780wvmUFI8dr+ntT6UNpA1KEKzf2AuY
 NK4CUDZAOmNjPiWfBQPhM3hjnm+EEoEpbz1o371hYEv9o1nCIAEVwlG2Z/eicYdNmsSZ
 6LKUpflNEdHAhOYvNPrY230CsT5NUGso1RIQom1jQOJ/nOvJ2d5y/Ot+JqhrKqxlWpKB
 3At9KiJhmWGtb/Den1km+dxP+CmAJ2sIrzBLfr2Byfvc5tFA2gx2ANwMkHzrCXTbGTyh
 rfUg==
X-Gm-Message-State: AOJu0Yxkb6qL6QjKGtsvI8UqBsvaNKH65Ur4IMp8mjDtTj9x4d7wV27w
 eypvuOv65my+0KIileG55f7CXSrbT+4Nklnda/bMMT8CON1YLDN3syDrLm4jPHPpJeMCa3fP2YZ
 CJ6pfJzUXYNrrx8vnF8DyMByQ0fS1Mfg3ySsIs9sq8jnXOhBTO11p
X-Gm-Gg: ASbGnctxTz9X6QML8T9rortAtGCttkVz3exCDkOLbV/zI4axXExz9ygTKToXTUZy5Cm
 8t4F1oM/nmbyGTheIyqkRx8iKfh9mtB6MsahZ5yMutfwuXCPoPglkyZHHXFb0l3X3Hl7ZxFJ0ey
 P9ObITzzPPaCTCBHO424XoVxO+FiQqus+tTSKtImaJ9ZbWB69ZXGpfp7N0TlAaXi0GCSlhi2K+t
 j7rrmPsaTNXz0s1R5wi81tnAx7gPn16nBd8QDfFjqUonnk7lprhMdPiSI3FHH8HRWWgvQuWuGvN
 ftUIzYgpYuI2LaqdTmd3O2/36njBq1qNymGr7moRBygaKpO9TXfg2TEzwB1geQ738by1gJGcBKu
 PxCGShaNtHv8WNOa3XUN9jHB/wFqw4QTv8hmNew==
X-Received: by 2002:a05:6000:402a:b0:390:e535:8758 with SMTP id
 ffacd0b85a97d-39132d2afc2mr2960361f8f.9.1741369955972; 
 Fri, 07 Mar 2025 09:52:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG07psx7nrROslR8sb3k2+VrPYd4Y+gRHYnnNZXbFev98tq8ia7nSVjJvoI9nWJEXx99axOog==
X-Received: by 2002:a05:6000:402a:b0:390:e535:8758 with SMTP id
 ffacd0b85a97d-39132d2afc2mr2960341f8f.9.1741369955635; 
 Fri, 07 Mar 2025 09:52:35 -0800 (PST)
Received: from ?IPV6:2003:cb:c721:7400:ab0b:9ceb:d2:6a17?
 (p200300cbc7217400ab0b9ceb00d26a17.dip0.t-ipconnect.de.
 [2003:cb:c721:7400:ab0b:9ceb:d2:6a17])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0195casm6097677f8f.53.2025.03.07.09.52.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 09:52:35 -0800 (PST)
Message-ID: <3666e5ef-c664-4b83-acd6-f3d553fd7ae1@redhat.com>
Date: Fri, 7 Mar 2025 18:52:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] hw/virtio/virtio-mem: Convert
 VIRTIO_MEM_USABLE_EXTENT to runtime
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20250307151543.8156-1-philmd@linaro.org>
 <20250307151543.8156-6-philmd@linaro.org> <877c503ie6.fsf@draig.linaro.org>
 <a7126584-00fa-42ed-8e5c-d27d9933ac2f@linaro.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <a7126584-00fa-42ed-8e5c-d27d9933ac2f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 07.03.25 17:49, Philippe Mathieu-Daudé wrote:
> On 7/3/25 17:38, Alex Bennée wrote:
>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>
>>> Use qemu_arch_available() to check at runtime if a target
>>> architecture is built in.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>    hw/virtio/virtio-mem.c | 20 ++++++++++++--------
>>>    1 file changed, 12 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
>>> index 5f57eccbb66..8c40042108c 100644
>>> --- a/hw/virtio/virtio-mem.c
>>> +++ b/hw/virtio/virtio-mem.c
>>> @@ -15,6 +15,7 @@
>>>    #include "qemu/cutils.h"
>>>    #include "qemu/error-report.h"
>>>    #include "qemu/units.h"
>>> +#include "system/arch_init.h"
>>>    #include "system/numa.h"
>>>    #include "system/system.h"
>>>    #include "system/reset.h"
>>> @@ -170,13 +171,16 @@ static bool virtio_mem_has_shared_zeropage(RAMBlock *rb)
>>>     * necessary (as the section size can change). But it's more likely that the
>>>     * section size will rather get smaller and not bigger over time.
>>>     */
>>> -#if defined(TARGET_X86_64) || defined(TARGET_I386) || defined(TARGET_S390X)
>>> -#define VIRTIO_MEM_USABLE_EXTENT (2 * (128 * MiB))
>>> -#elif defined(TARGET_ARM)
>>> -#define VIRTIO_MEM_USABLE_EXTENT (2 * (512 * MiB))
>>> -#else
>>> -#error VIRTIO_MEM_USABLE_EXTENT not defined
>>> -#endif
>>> +static uint64_t virtio_mem_usable_extent_size(void)
>>> +{
>>> +    if (qemu_arch_available(QEMU_ARCH_I386 | QEMU_ARCH_S390X)) {
>>> +        return 2 * 128 * MiB;
>>> +    } else if (qemu_arch_available(QEMU_ARCH_ARM)) {
>>> +        return 2 * 512 * MiB;
>>> +    } else {
>>> +        g_assert_not_reached();
>>> +    }
>>> +}
>>
>> What happens if/when we have multiple arches available? Won't we want to
>> know which CPU the virtio-mem device is attached to or do we take the
>> minimal value over the whole system?

We should take the maximum value here, not the minimum.

> 
> "per attached vcpu" is how I was previously considering this problem,
> but IIUC from the discussions with Pierrick, we should consider single
> binary as a first step before heterogeneous emulation.

It would be related to the machine/vcpu, yes.

Taking the maximum over all available arches is easier; it's a pure 
optimization.

-- 
Cheers,

David / dhildenb


