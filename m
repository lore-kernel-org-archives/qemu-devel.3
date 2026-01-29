Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F948D6101A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 15:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlTjM-00086N-3s; Thu, 29 Jan 2026 10:14:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vlTjG-00083m-LF
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 10:14:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vlTjC-0002oi-W6
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 10:14:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769699677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vMj2ya+fgceNjjJgX09/hqHpY/FABmYbgGbPqkweLRk=;
 b=R06cjFrQxjLMPSdkO+pJ4Io6PsIgjMuJmB8WWbWtwpX04RHj5+oDRBdwqBj4BKcREg7Z0S
 q24Lmm/JXuEfo0vlZ3XZIsZDcX7gtrnKP78//9jLr+/2DXPWICQgt/AxiDrKVh1bcHYrka
 zsEFUksCQhytVdnKpRWyvNJ/NqCJOQM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-RTgYSfLKO-eYYGbi8MFl1g-1; Thu, 29 Jan 2026 10:14:35 -0500
X-MC-Unique: RTgYSfLKO-eYYGbi8MFl1g-1
X-Mimecast-MFC-AGG-ID: RTgYSfLKO-eYYGbi8MFl1g_1769699674
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-6581b412518so1590373a12.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 07:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769699674; x=1770304474; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=vMj2ya+fgceNjjJgX09/hqHpY/FABmYbgGbPqkweLRk=;
 b=tL5H7vGIvayTlXkUUPSxpuqAVYgNUDYUEmBssuszCxglnDPehv43MqMFImjjTcuyc9
 2yDeYjH5hsOCZtR5qY5q3e+EGhvflQ1j4GLnTi+jExqiHGA3/5pSf6bk11zPm76h54rx
 2S0dsV1iq43JLOeH9xH6dFObmVMrvN6VcchZH7SBqjzFhoBfSwcd1sa/YLk8iXVdoScV
 Wp5D+ocuF8ZT2LUm2Yw7LaL9oeaYlNICWOyeL799OYPRZ2SGGp68lQgA7xXvZhPgxfkO
 TIuoXo3v87IvzUe96VKBqjQyY4o9yHo00TkAf7KLtwMCK2dxQJ7Bm2HC/EPnzg9kE01l
 9UxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769699674; x=1770304474;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vMj2ya+fgceNjjJgX09/hqHpY/FABmYbgGbPqkweLRk=;
 b=T+wONxqp8UAN1DhCy7KD/TCINI7IqN4+xghDsw6XRev9YzT7uFQY4R1m1BKrX/3MCW
 mx4YJwQaxEY4hTes30YhcrFPx9Ud1bu+2vZAUTiQ6/8uC/u9sbk6dm3qM6aXEKjYI+eH
 7m0aIhDivGLvv1SwcXrymNiR7f29l6TrPGAHYmvGSGkHqdf3m+7Ird7nOoD7o657fhsu
 jFCmWhmw5xrif3oPj0d5RhA/xzqvVWRPx2wsJRpLNfO6nJzrJZmugXmhWMWg1bW0aMMz
 FwvpBYjZsJ5tG3jTtG2rydXzRBCiIRXzrL1XtCYElU1DW3xwQ9lfvgj44O8XloQqXmW+
 gR5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYm6qIImF9u/t7fHj+OYMlRcA+Qf8R3wjQF9rZXN6Ulxk5NiYD/EbDoIfd4Hski57TCm5XlXQNQCcQ@nongnu.org
X-Gm-Message-State: AOJu0Yy9uhCiW2l8NL4safiGbflSuwbj2c/lhoIyShXyN/N+BRHlfxWH
 BnS7JC9tn6+UhRki7SBbWCiN7xEgqa6WcMBCFy+i19+o3zH1KMXCDSxQepInTRC7L0Fq/GZM6+o
 KSRyrmoZie/rtGmT3sZ3nTsdkkCFJ3WzONW/3YhNcxnixwzG8qQC5Pwim
X-Gm-Gg: AZuq6aJtQdAwxyuSK7OHt7jIEZFreAB3L+IvgBX21YVt1shqwpp5W2tryBfh+W6gXI5
 UaMY7W4tycvMrlRuQy+JAQ2Te70CzIy3ERQr5ViRRxdDsysdGiJL7y5cuN6qXPtcpXHUOqy6IU+
 GTXNK+6sCk7d2T40q/S7aWu5dtiCUysiLwrBWGD+ebkTZUBteNDwIBFh2ht08AL2CxQgK9iQjXS
 Hj1nffawrv74A4qAa9QmAFbdQvkfg1dKRtEbdTWQJoKZ3Efu0kdFh0+LMJJvvdsFkcqSU5BRERR
 HLXA+GHFZ603Zp4n0RDfjOPUAbCnXS3LpLWWJSFewHWmEK7x9an+OW7BJJJeGPpJm1iH7p+wkoE
 hhDOpWW8=
X-Received: by 2002:a05:6402:2711:b0:658:1eee:8a40 with SMTP id
 4fb4d7f45d1cf-658a600eeb3mr6321466a12.2.1769699673765; 
 Thu, 29 Jan 2026 07:14:33 -0800 (PST)
X-Received: by 2002:a05:6402:2711:b0:658:1eee:8a40 with SMTP id
 4fb4d7f45d1cf-658a600eeb3mr6321447a12.2.1769699673228; 
 Thu, 29 Jan 2026 07:14:33 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-658b4691e78sm2907344a12.17.2026.01.29.07.14.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 07:14:32 -0800 (PST)
Message-ID: <b99fd467-090c-474b-b269-c1ffb5f1f6b4@redhat.com>
Date: Thu, 29 Jan 2026 16:14:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/14] pc-bios/s390-ccw: Introduce PCI device
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
 <20260127161547.459443-10-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260127161547.459443-10-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 27/01/2026 17.15, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Define selected s390x PCI instructions.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
...
> diff --git a/pc-bios/s390-ccw/pci.h b/pc-bios/s390-ccw/pci.h
> new file mode 100644
> index 0000000000..ff8d5687f4
> --- /dev/null
> +++ b/pc-bios/s390-ccw/pci.h
> @@ -0,0 +1,80 @@
> +/*
> + * s390x PCI definitions
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Jared Rossi <jrossi@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef PCI_H
> +#define PCI_H
> +
> +#include <stdint.h>
> +#include <stdbool.h>
> +#include "clp.h"
> +
> +#define ZPCI_CREATE_REQ(handle, space, len)                    \
> +    ((uint64_t) handle << 32 | space << 16 | len)
> +
> +union register_pair {
> +    unsigned __int128 pair;
> +    struct {
> +        unsigned long even;
> +        unsigned long odd;
> +    };
> +};
> +
> +#define PCIFIB_FC_ENABLED      0x80
> +#define PCIFIB_FC_ERROR        0x40
> +#define PCIFIB_FC_BLOCKED      0x20
> +#define PCIFIB_FC_DMAREG       0x10
> +
> +#define PCIST_DISABLED         0x0
> +#define PCIST_ENABLED          0x1
> +
> +#define PCI_CFGBAR             0xF  /* Base Address Register for config space */
> +#define PCI_CAPABILITY_LIST    0x34 /* Offset of first capability list entry */
> +
> +struct PciFib {
> +    uint32_t reserved0[2];
> +    uint8_t fcflags;
> +    uint8_t reserved1[3];
> +    uint32_t reserved2;
> +    uint64_t pba;
> +    uint64_t pal;
> +    uint64_t iota;
> +    uint16_t isc:4;
> +    uint16_t noi:12;
> +    uint8_t reserved3:2;
> +    uint8_t aibvo:6;
> +    uint8_t s:1;
> +    uint8_t reserved4:1;
> +    uint8_t aisbo:6;
> +    uint32_t reserved5;
> +    uint64_t aibv;
> +    uint64_t aisb;
> +    uint64_t fmba;
> +    uint32_t reserved6[2];
> +};
> +typedef struct PciFib PciFib;

I can't comment on the gory details here since I don't have the spec, but 
from a distance, the patch looks fine to me now.

Acked-by: Thomas Huth <thuth@redhat.com>


