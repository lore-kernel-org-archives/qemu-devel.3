Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3785CD5822
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 10:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdQjn-0005yQ-7F; Wed, 07 Jan 2026 05:25:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdQjk-0005pI-DG
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 05:25:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdQjh-0005oK-Sr
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 05:25:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767781552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zbA9y0HPafzzQ4Q2smWccMol3hR/HFqLaxZoIijBhcs=;
 b=YGhrJvdKmg9gyfRd+Ji6Qj/o2kvYx3uCJAkU/QwyVZoXIEnWjVFBQScrqEBbTZhAf0WN+o
 Qx1DzvPz3zInV37ltfOwPnVTBVoVMkkVskhv5p7mqXvQcuX2FZZdW2XDCjCXDVXLgX9gXT
 RsxBAgrMjBKoMTQiS2zaWH/5DkfhyaE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-8z02_CK2PfKcT3jqaPTfFQ-1; Wed, 07 Jan 2026 05:25:51 -0500
X-MC-Unique: 8z02_CK2PfKcT3jqaPTfFQ-1
X-Mimecast-MFC-AGG-ID: 8z02_CK2PfKcT3jqaPTfFQ_1767781550
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4775e00b16fso12738965e9.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 02:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767781550; x=1768386350; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=zbA9y0HPafzzQ4Q2smWccMol3hR/HFqLaxZoIijBhcs=;
 b=eSjRVb388kTmtMTJFVdfHZSi+YroNmkbkn5W9EsgJcK/LVh6vTtbApu1E69KZRWx/M
 F170BEMJ52C/MubK2d1xf8H573g9qJNEhSTeLpnHMSv6VkoSjWf58a3fg9SLoVfWq+SZ
 Z9ZWqNMzeAgCyy3tX0PIXcc2gJxyjQpwqhvgyohGVBJW0dEC+5T5K3xSgKP97AsORxLY
 SRpvPewXNkQxkcfMRIhKAPdaShXfULGeg01K/CpbPNQuYSxhMo2NyezotFG6/JJ/pUAt
 deBGwBrVmI6/vlME1QRfisVvLmyJQno+41ifPQN/Vz0nEqqjNQ8y8isPKb7k02ViginG
 Emng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767781550; x=1768386350;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zbA9y0HPafzzQ4Q2smWccMol3hR/HFqLaxZoIijBhcs=;
 b=ZQYWBM5UmKluacjreOt2djsyCFhnuh/hTsZnxRv2t3Pf4pD/q+LldWvP4PUBUe9Lzc
 BI5CyFBZg0kROD5OkH/0wNY82j6DoNgfGs1O6VvZezCoj6kDZC6ICGLZsdIqSY+sJdao
 1jFFvygV20XfXn6aaI/4N6J16djWfoTRIsPAf+8deC57QudnF24X5/oWHjIBdULe1oq2
 tJEoWf+FYrBQrm6q7IzcJFGmJ0On9Kzb/IOxbMAr9wD12rB3SEl6Gv0RJSCo5Sp3iN32
 TM5uOwISvMPLZZp7NQ1vMi4H6INtPpI4+LWUwDyzvk+AWir7ZovohiA42UB567x+2sMe
 ttUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdvWvyCklI7V1mYW3RTiE5W58PUajcfS4hpr5jbUi5jGaLqlz9cHi2zHtkgqrAvTZEi0d4tuWbiVoR@nongnu.org
X-Gm-Message-State: AOJu0YwQ+Av1FCYQAuagNkNoionVDJJ8nN8QHR+bn1+Tua+RuQgtf4bS
 Stl4MAQcbiSGXIMaJidgp5wx7Ss42zilcERdLjSb74bqbOeotuTizzjCjBLMQWMadiez1dj88oT
 1YmYU3R9Nr62TGOwiV8J1X8kOFcQ/KaME2q06O7sgMfGU/xAUVu0HKzww
X-Gm-Gg: AY/fxX5/glPgzymkHwghvBPElqrnbVZi6/kW2W1Q1XzqYnAgwwFDJTZZTxVA4ePRuJg
 Fh99+u7Mi0Avxqe8MUIirPtbJy6THxuLnoGfJyyLljpcO96qJsGnfET4IEyKu07kDiwS8Jjb5u2
 ZgEFnpfV9lt/JaptbyPHryb2bm17lWGiieXjd03Bt9bhXS2bcrvtwvek5wUa//WZ3sSUbPQsQwl
 w7VfL+w93uKuKJxc6h5/xaz+++bfR1KwFRQbTwnrvzvVLFxaFV8tVAUytg6XTge672fbzUg6ykK
 Uw3QolT7qmtNGyQPChQ80Dn0IziRLeGegtecbwlycJUKR8+sPMQVPKbrTu/l+wgPOdoCtYxtXNH
 HvHuf49VQKWW3LL2+y3NvRmAGuGLpr0NmQsI=
X-Received: by 2002:a05:600c:3556:b0:479:33be:b23e with SMTP id
 5b1f17b1804b1-47d84b3b4eamr23873575e9.17.1767781550169; 
 Wed, 07 Jan 2026 02:25:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1hc/04MlYZi7ReUwCR6UzF7KdSWGtb8fU7dVAhyFyECWQgCcmp5tWd19dxC2Mpt4r2XK9Eg==
X-Received: by 2002:a05:600c:3556:b0:479:33be:b23e with SMTP id
 5b1f17b1804b1-47d84b3b4eamr23873195e9.17.1767781549722; 
 Wed, 07 Jan 2026 02:25:49 -0800 (PST)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dacd1sm9447105f8f.4.2026.01.07.02.25.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 02:25:49 -0800 (PST)
Message-ID: <3a30e4c5-24be-449d-ac9f-16ce2096b31c@redhat.com>
Date: Wed, 7 Jan 2026 11:25:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] pc-bios/s390-ccw: Introduce CLP Architecture
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20251210205449.2783111-1-jrossi@linux.ibm.com>
 <20251210205449.2783111-6-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251210205449.2783111-6-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/12/2025 21.54, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Call Logical Processor (CLP) Architecture is used for managing PCI functions on
> s390x. Define and include the structures and routines needed to interact with
> PCI devices during IPL.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/clp.h    | 24 ++++++++++
>   pc-bios/s390-ccw/clp.c    | 96 +++++++++++++++++++++++++++++++++++++++
>   pc-bios/s390-ccw/Makefile |  2 +-
>   3 files changed, 121 insertions(+), 1 deletion(-)
>   create mode 100644 pc-bios/s390-ccw/clp.h
>   create mode 100644 pc-bios/s390-ccw/clp.c
> 
> diff --git a/pc-bios/s390-ccw/clp.h b/pc-bios/s390-ccw/clp.h
> new file mode 100644
> index 0000000000..1ac2f8c177
> --- /dev/null
> +++ b/pc-bios/s390-ccw/clp.h
> @@ -0,0 +1,24 @@
> +/*
> + * Call Logical Processor (CLP) architecture definitions
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Jared Rossi <jrossi@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef CLP_H
> +#define CLP_H
> +
> +#ifndef QEMU_PACKED
> +#define QEMU_PACKED __attribute__((packed))
> +#endif
> +
> +#include <stdint.h>
> +#include <s390-pci-clp.h>
> +
> +int clp_pci(void *data);
> +int find_pci_function(uint32_t fid, ClpFhListEntry *entry);
> +int enable_pci_function(uint32_t *fhandle);
> +
> +#endif
> diff --git a/pc-bios/s390-ccw/clp.c b/pc-bios/s390-ccw/clp.c
> new file mode 100644
> index 0000000000..6dc72c685c
> --- /dev/null
> +++ b/pc-bios/s390-ccw/clp.c
> @@ -0,0 +1,96 @@
> +/*
> + * Call Logical Processor (CLP) architecture
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Jared Rossi <jrossi@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "clp.h"
> +#include <stdio.h>
> +#include <string.h>
> +
> +int clp_pci(void *data)
> +{
> +    struct { uint8_t _[2048]; } *req = data;
> +    int cc = 3;
> +
> +    asm volatile (
> +        "     .insn   rrf,0xb9a00000,0,%[req],0,2\n"
> +        "     ipm     %[cc]\n"
> +        "     srl     %[cc],28\n"
> +        : [cc] "+d" (cc), "+m" (*req)
> +        : [req] "a" (req)
> +        : "cc");
> +    return cc;
> +}
> +
> +/*
> + * Get the PCI function entry for a given function ID
> + * Return 0 on success, 1 if the FID is not found, or a negative RC on error
> + */
> +int find_pci_function(uint32_t fid, ClpFhListEntry *entry)
> +{
> +    int count = 0;
> +    int limit = PCI_MAX_FUNCTIONS;
> +    ClpReqRspListPci rrb;
> +
> +    rrb.request.hdr.len = 32;
> +    rrb.request.hdr.cmd = 0x02;
> +    rrb.request.resume_token = 0;
> +    rrb.response.hdr.len = sizeof(ClpRspListPci);
> +
> +    do {
> +        if (clp_pci(&rrb) || (rrb.response.hdr.rsp != 0x0010)) {

You could drop the parentheses around rrb.response.hdr.rsp != 0x0010 here.

> +            puts("Failed to list PCI functions");
> +            return -1;
> +        }
> +
> +        /* Resume token set when max enteries are returned */
> +        if (rrb.response.resume_token) {
> +            count = CLP_FH_LIST_NR_ENTRIES;
> +            rrb.request.resume_token = rrb.response.resume_token;
> +        } else {
> +            count = (rrb.response.hdr.len - 32) / sizeof(ClpFhListEntry);
> +        }
> +
> +        limit -= count;
> +
> +        for (int i = 0; i < count; i++) {
> +            if (rrb.response.fh_list[i].fid == fid) {
> +                memcpy(entry, &rrb.response.fh_list[i], sizeof(ClpFhListEntry));
> +                return 0;
> +            }
> +        }
> +
> +    } while (rrb.request.resume_token && limit);

Maybe check for "limit > 0", just in case... ?

> +    puts("No function entry found for FID!");
> +
> +    return 1;
> +}
> +
> +/*
> + * Enable the PCI function associated with a given handle
> + * Return 0 on success or a negative RC on error
> + */
> +int enable_pci_function(uint32_t *fhandle)
> +{
> +    ClpReqRspSetPci rrb;
> +
> +    rrb.request.hdr.len = 32;
> +    rrb.request.hdr.cmd = 0x05;
> +    rrb.request.fh = *fhandle;
> +    rrb.request.oc = 0;
> +    rrb.request.ndas = 1;
> +    rrb.response.hdr.len = 32;
> +
> +    if (clp_pci(&rrb) || (rrb.response.hdr.rsp != 0x0010)) {

Drop parentheses, please.

> +        puts("Failed to enable PCI function");
> +        return -1;
> +    }
> +
> +    *fhandle = rrb.response.fh;
> +    return 0;
> +}
> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
> index 259cff09db..9c29548f84 100644
> --- a/pc-bios/s390-ccw/Makefile
> +++ b/pc-bios/s390-ccw/Makefile
> @@ -35,7 +35,7 @@ QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
>   
>   OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o netmain.o \
>   	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o \
> -	  virtio-ccw.o
> +	  virtio-ccw.o clp.o
>   
>   SLOF_DIR := $(SRC_PATH)/../../roms/SLOF
>   

  Thomas


