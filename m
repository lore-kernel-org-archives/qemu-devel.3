Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846ACC36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 14:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3FHU-0004fG-Tm; Fri, 11 Apr 2025 10:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u3FHT-0004ey-5f
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 10:22:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u3FHR-0007yp-DR
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 10:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744381371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JyWJPEaMdWJWSr0ipI3nIM0W7/vnE9icxMZhVQUEjms=;
 b=fx01SyUTT/SU8WBuwlGUrbPB8ay0uD7y8Wrg16vVcvpDMxTCybEwoIF/R5nUjLzgC7sdHf
 srOBJj3BHuZpcKDUehMQgG2dS2qeNf6fgEeuGVzxnd04VysMuWk7IPd2fjfxBeK9kzKzYl
 4niKddwWgr5dnna9nQd3a8VxR8pFC18=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315--WVr-z4iPY6hkKN1WTn8Dg-1; Fri, 11 Apr 2025 10:22:50 -0400
X-MC-Unique: -WVr-z4iPY6hkKN1WTn8Dg-1
X-Mimecast-MFC-AGG-ID: -WVr-z4iPY6hkKN1WTn8Dg_1744381369
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d733063cdso18076545e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 07:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744381369; x=1744986169;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JyWJPEaMdWJWSr0ipI3nIM0W7/vnE9icxMZhVQUEjms=;
 b=UZLK1fwNe1ecsG+cSRNmNaBlEX7Qff357XeY9Uzr38WyQVApGxbeo/9+tNcnIteWLm
 BOX8aWP8HHNnDPvZnMICgXJFcZpkrsTlpEY9U8hfkHRzERQjzglTjDGV285uls+Q7bsb
 c0d1SDQs1qFMg+X1GVXnubEOkUvliItY1FEczPpQdcypAsT5ZMLimrHJgsSG0t2Y49ct
 41rJScjKF2j0UWFvZVa3jcINjMr3DstyKKGJLZNjI6mRukN5PL0RndeJwQDNBpR9xCwD
 A1ys0KgS/L53IEDMv17Wn+DnQDWehy/0PNdPJ+Jlwqs0HpKPk/KsuVEfXUyDb2Yyv6Fb
 b3sA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHrivIPB/T9KspG4hyABM8HsijXQ98jrOX98f6rB7BtxizDybc2YReciDGexqLxRWKHrlofJ1E8h6g@nongnu.org
X-Gm-Message-State: AOJu0Yw6553DZCEM/iO6YVQdMNGI8hzvXFwuRR6IfebqL7wOZ4O0eLf7
 DaWMmmewYrj7my9w6jVe6kd31wO7H3/bAwJPUYkhRK+idHB+o8Xz3ezcqSNLmnuuT/NRVud5G6L
 rQP3NV0Mn7XTocpagy8hRs9PN7nHXC+C9192DRrCmz9iikD/vLJkv
X-Gm-Gg: ASbGncvJ8/gNsj2xsUAUafKwvWmKLP/8y3eEWaAdqnqVvkAioOE/XnIo6IZgD2CcPit
 +PMFq4ERiWrpnOMOMw+WO+aJi4MjBs2iKpuDmKCJKVpgb616GmXXZaog27czAr8/YWKir4KcSPD
 7lLqHtwNGRk0XcBMCCdM2cNabwR1wek0IiWvneEPaO2rarC+XYNoxu2UDe4C/wNEpP3FX8ThELx
 D+zpoosuNdmw7YpIltOmH9aKyDKrnsF++jodGd2GJ4iWFuTFaqK3iwuZ79KRzSRnKGDWht4ihsL
 zk5ZrUkEiy0mpk7NCdWaat4LR3J54KJQir51PQgOIZU=
X-Received: by 2002:adf:9c92:0:b0:39e:cbf3:79db with SMTP id
 ffacd0b85a97d-39ecbf37a46mr115436f8f.10.1744381368754; 
 Fri, 11 Apr 2025 07:22:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF62JkmX7MBgqHvVgltrOHQ54OgqOylby/4vdE2JngCIt9qZTrJGX61B6tzkTxqYMlVYRU34Q==
X-Received: by 2002:adf:9c92:0:b0:39e:cbf3:79db with SMTP id
 ffacd0b85a97d-39ecbf37a46mr115407f8f.10.1744381368396; 
 Fri, 11 Apr 2025 07:22:48 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-221.web.vodafone.de.
 [109.42.49.221]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f20b2c355sm40864255e9.2.2025.04.11.07.22.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 07:22:47 -0700 (PDT)
Message-ID: <fb4e2106-921e-4bd2-a410-1d5c4dc36e1a@redhat.com>
Date: Fri, 11 Apr 2025 16:22:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/24] s390x/diag: Introduce DIAG 508 for secure IPL
 operations
To: Zhuoying Cai <zycai@linux.ibm.com>, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250408155527.123341-1-zycai@linux.ibm.com>
 <20250408155527.123341-9-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250408155527.123341-9-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.681,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 08/04/2025 17.55, Zhuoying Cai wrote:
> From: Collin Walling <walling@linux.ibm.com>
> 
> In order to support secure IPL (aka secure boot) for the s390-ccw BIOS,
> a new s390 DIAGNOSE instruction is introduced to leverage QEMU for
> handling operations such as signature verification and certificate
> retrieval.
> 
> Currently, only subcode 0 is supported with this patch, which is used to
> query a bitmap of which subcodes are supported.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>   hw/s390x/ipl.h                 |  1 +
>   include/hw/s390x/ipl/diag508.h | 17 +++++++++++++++++
>   target/s390x/diag.c            | 26 ++++++++++++++++++++++++++
>   target/s390x/kvm/kvm.c         | 14 ++++++++++++++
>   target/s390x/s390x-internal.h  |  2 ++
>   5 files changed, 60 insertions(+)
>   create mode 100644 include/hw/s390x/ipl/diag508.h
> 
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index 822535ad76..e9ef8ddccd 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -18,6 +18,7 @@
>   #include "exec/address-spaces.h"
>   #include "hw/qdev-core.h"
>   #include "hw/s390x/ipl/diag320.h"
> +#include "hw/s390x/ipl/diag508.h"
>   #include "hw/s390x/ipl/qipl.h"
>   #include "qom/object.h"
>   
> diff --git a/include/hw/s390x/ipl/diag508.h b/include/hw/s390x/ipl/diag508.h
> new file mode 100644
> index 0000000000..83c4439cb2
> --- /dev/null
> +++ b/include/hw/s390x/ipl/diag508.h
> @@ -0,0 +1,17 @@
> +/*
> + * S/390 DIAGNOSE 508 definitions and structures
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Collin Walling <walling@linux.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +
> +#ifndef S390X_DIAG508_H
> +#define S390X_DIAG508_H
> +
> +#define DIAG_508_SUBC_QUERY_SUBC    0x0000
> +
> +#endif
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index 82e4dc9e1e..ad7f4b5025 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -488,3 +488,29 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>       }
>       env->regs[r1 + 1] = rc;
>   }
> +
> +void handle_diag_508(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
> +{
> +    uint64_t subcode = env->regs[r3];
> +    int rc;

Do we need to check some feature bit here? e.g. check 
s390_has_feat(S390_FEAT_DIAG_320) here, too?

> +    if (env->psw.mask & PSW_MASK_PSTATE) {
> +        s390_program_interrupt(env, PGM_PRIVILEGED, ra);
> +        return;
> +    }
> +
> +    if ((subcode & ~0x0ffffULL) || (r1 & 1)) {
> +        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +        return;
> +    }
> +
> +    switch (subcode) {
> +    case DIAG_508_SUBC_QUERY_SUBC:
> +        rc = 0;
> +        break;
> +    default:
> +        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +        return;
> +    }
> +    env->regs[r1 + 1] = rc;
> +}

  Thomas


