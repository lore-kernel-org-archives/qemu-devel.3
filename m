Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C11D1A431
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2024 06:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szVUc-0001Pw-T1; Sat, 12 Oct 2024 02:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1szVUZ-0001Pb-C4
 for qemu-devel@nongnu.org; Sat, 12 Oct 2024 02:20:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1szVUW-0004TG-86
 for qemu-devel@nongnu.org; Sat, 12 Oct 2024 02:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728714038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QJwp/lW+t8SjkGA45hQldrPln7eKaErfHH5RO4GaHu8=;
 b=Fdadj5DK1F3U1nVLSDIBn34JBV7cVt69NgDn4CakJo6Y4Xziip/5xuCakT8z74hIz0inN9
 PZUPV5NXr3UsdTokhvE2RWh+4+PXtlKaeD85ZoaBhYCu46QgGzzHfbhXBSBoKOWa0uCVUW
 dZV6Wz/kRg2m66DiRP+dEGjnR3r5EiY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-Uhn8bLCsN0qU9l3skgM0IA-1; Sat, 12 Oct 2024 02:20:30 -0400
X-MC-Unique: Uhn8bLCsN0qU9l3skgM0IA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43124676f8aso4034655e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 23:20:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728714028; x=1729318828;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QJwp/lW+t8SjkGA45hQldrPln7eKaErfHH5RO4GaHu8=;
 b=eTTIiRrBEKa8CU1ZlDx2vyBFAgyfUe79n0N/8jD5bOfAKzRV5S2CAqNaYzPKAh3eMT
 umYekjXVMoBj6mFLjUjG+LC0NLEdvP3qAaQDRYbcl83XblqUy6T7vhDMfzKvBs6f3NgQ
 FJSHSZiXLIPfx7Pwu3S10B5vbv77Qvyv6dITm1HgWQjBBrqtDqUgLbQHZCf7MP2A2iDh
 W2H3A/O8IDmgyVITZEjrRIyEwYK+sUJnCXzmk2xNiLMqC+fPdQlJo1DdEhvjUf8PGZRV
 391omY6Sh2vGeLjna0OS/TyJP8SgXFlCeV4uJ7SgdVGYWtsVoMmGfszBYARgDfEvWLqS
 q6kA==
X-Gm-Message-State: AOJu0YxuEZr5J/eAoFk3nqLeecAABi7VhW/t8zOpVXYHSW2rSIP1+PAK
 o2O4Dv5gT5qKcfL1Pltp224oAGEmJ/ECru4ozUXmbQYirVwh0CR376gXA9ZVRE6z0diXKn8TJTA
 VeTP0IazeCfr8egS+QeW9y9zHBkyLwF5XWYa+yLR1bXuQ0AQB4e00BC7iRKgLL+D+IPRtRDDs5g
 cRCLSBNKF6w7Xhqaxs5hYTs/lhwU03Ng==
X-Received: by 2002:a05:600c:1d0e:b0:426:5fe1:ec7a with SMTP id
 5b1f17b1804b1-4311df4155amr37268375e9.31.1728714028214; 
 Fri, 11 Oct 2024 23:20:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSk3HbWWB0oq/srciR/M8K5NeNo/SWveN5nk3QrkUe2lTAlvxUgIZrS1vZmYEQ1hx5aDh1zQ==
X-Received: by 2002:a05:600c:1d0e:b0:426:5fe1:ec7a with SMTP id
 5b1f17b1804b1-4311df4155amr37268055e9.31.1728714027735; 
 Fri, 11 Oct 2024 23:20:27 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:9000:9100:a34f:49ce:8596:8d47?
 ([2a01:cb19:9000:9100:a34f:49ce:8596:8d47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d4b6cff9asm5460307f8f.48.2024.10.11.23.20.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2024 23:20:27 -0700 (PDT)
Message-ID: <eff3385f-6d43-42e7-8b36-7225e2fee7df@redhat.com>
Date: Sat, 12 Oct 2024 08:20:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] hw/misc/aspeed_hace: Fix SG Accumulative hashing
To: qemu-devel@nongnu.org, berrange@redhat.com
Cc: kris.conklin@seagate.com, jonathan.henze@seagate.com,
 evan.burgess@seagate.com, peter.maydell@linaro.org,
 Alejandro Zeise <alejandro.zeise@seagate.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
References: <20241011053825.361544-1-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20241011053825.361544-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

+ Aspeed reviewers. Sorry about that.

C.


On 10/11/24 07:38, Cédric Le Goater wrote:
> From: Alejandro Zeise <alejandro.zeise@seagate.com>
> 
> Make the Aspeed HACE module use the new qcrypto accumulative hashing functions
> when in scatter-gather accumulative mode. A hash context will maintain a
> "running-hash" as each scatter-gather chunk is received.
> 
> Previously each scatter-gather "chunk" was cached
> so the hash could be computed once the final chunk was received.
> However, the cache was a shallow copy, so once the guest overwrote the
> memory provided to HACE the final hash would not be correct.
> 
> Possibly related to: https://gitlab.com/qemu-project/qemu/-/issues/1121
> Buglink: https://github.com/openbmc/qemu/issues/36
> 
> Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
> [ clg: - Checkpatch fixes
>         - Reworked qcrypto_hash*() error reports in do_hash_operation() ]
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
> 
>   Changes in v6:
>   - Reworked qcrypto_hash*() error reports in do_hash_operation()
> 
>   include/hw/misc/aspeed_hace.h |   4 ++
>   hw/misc/aspeed_hace.c         | 104 +++++++++++++++++++---------------
>   2 files changed, 63 insertions(+), 45 deletions(-)
> 
> diff --git a/include/hw/misc/aspeed_hace.h b/include/hw/misc/aspeed_hace.h
> index ecb1b67de816..4af99191955a 100644
> --- a/include/hw/misc/aspeed_hace.h
> +++ b/include/hw/misc/aspeed_hace.h
> @@ -1,6 +1,7 @@
>   /*
>    * ASPEED Hash and Crypto Engine
>    *
> + * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
>    * Copyright (C) 2021 IBM Corp.
>    *
>    * SPDX-License-Identifier: GPL-2.0-or-later
> @@ -10,6 +11,7 @@
>   #define ASPEED_HACE_H
>   
>   #include "hw/sysbus.h"
> +#include "crypto/hash.h"
>   
>   #define TYPE_ASPEED_HACE "aspeed.hace"
>   #define TYPE_ASPEED_AST2400_HACE TYPE_ASPEED_HACE "-ast2400"
> @@ -35,6 +37,8 @@ struct AspeedHACEState {
>   
>       MemoryRegion *dram_mr;
>       AddressSpace dram_as;
> +
> +    QCryptoHash *hash_ctx;
>   };
>   
>   
> diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
> index b6f43f65b29a..bc1d66ad8064 100644
> --- a/hw/misc/aspeed_hace.c
> +++ b/hw/misc/aspeed_hace.c
> @@ -1,6 +1,7 @@
>   /*
>    * ASPEED Hash and Crypto Engine
>    *
> + * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
>    * Copyright (C) 2021 IBM Corp.
>    *
>    * Joel Stanley <joel@jms.id.au>
> @@ -151,49 +152,28 @@ static int reconstruct_iov(AspeedHACEState *s, struct iovec *iov, int id,
>       return iov_count;
>   }
>   
> -/**
> - * Generate iov for accumulative mode.
> - *
> - * @param s             aspeed hace state object
> - * @param iov           iov of the current request
> - * @param id            index of the current iov
> - * @param req_len       length of the current request
> - *
> - * @return count of iov
> - */
> -static int gen_acc_mode_iov(AspeedHACEState *s, struct iovec *iov, int id,
> -                            hwaddr *req_len)
> -{
> -    uint32_t pad_offset;
> -    uint32_t total_msg_len;
> -    s->total_req_len += *req_len;
> -
> -    if (has_padding(s, &iov[id], *req_len, &total_msg_len, &pad_offset)) {
> -        if (s->iov_count) {
> -            return reconstruct_iov(s, iov, id, &pad_offset);
> -        }
> -
> -        *req_len -= s->total_req_len - total_msg_len;
> -        s->total_req_len = 0;
> -        iov[id].iov_len = *req_len;
> -    } else {
> -        s->iov_cache[s->iov_count].iov_base = iov->iov_base;
> -        s->iov_cache[s->iov_count].iov_len = *req_len;
> -        ++s->iov_count;
> -    }
> -
> -    return id + 1;
> -}
> -
>   static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
>                                 bool acc_mode)
>   {
>       struct iovec iov[ASPEED_HACE_MAX_SG];
> +    uint32_t total_msg_len;
> +    uint32_t pad_offset;
>       g_autofree uint8_t *digest_buf = NULL;
>       size_t digest_len = 0;
> -    int niov = 0;
> +    bool sg_acc_mode_final_request = false;
>       int i;
>       void *haddr;
> +    Error *local_err = NULL;
> +
> +    if (acc_mode && s->hash_ctx == NULL) {
> +        s->hash_ctx = qcrypto_hash_new(algo, &local_err);
> +        if (s->hash_ctx == NULL) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "qcrypto hash failed : %s",
> +                          error_get_pretty(local_err));
> +            error_free(local_err);
> +            return;
> +        }
> +    }
>   
>       if (sg_mode) {
>           uint32_t len = 0;
> @@ -226,8 +206,16 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
>               }
>               iov[i].iov_base = haddr;
>               if (acc_mode) {
> -                niov = gen_acc_mode_iov(s, iov, i, &plen);
> -
> +                s->total_req_len += plen;
> +
> +                if (has_padding(s, &iov[i], plen, &total_msg_len,
> +                                &pad_offset)) {
> +                    /* Padding being present indicates the final request */
> +                    sg_acc_mode_final_request = true;
> +                    iov[i].iov_len = pad_offset;
> +                } else {
> +                    iov[i].iov_len = plen;
> +                }
>               } else {
>                   iov[i].iov_len = plen;
>               }
> @@ -252,21 +240,42 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
>                * required to check whether cache is empty. If no, we should
>                * combine cached iov and the current iov.
>                */
> -            uint32_t total_msg_len;
> -            uint32_t pad_offset;
>               s->total_req_len += len;
>               if (has_padding(s, iov, len, &total_msg_len, &pad_offset)) {
> -                niov = reconstruct_iov(s, iov, 0, &pad_offset);
> +                i = reconstruct_iov(s, iov, 0, &pad_offset);
>               }
>           }
>       }
>   
> -    if (niov) {
> -        i = niov;
> -    }
> +    if (acc_mode) {
> +        if (qcrypto_hash_updatev(s->hash_ctx, iov, i, &local_err) < 0) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "qcrypto hash update failed : %s",
> +                          error_get_pretty(local_err));
> +            error_free(local_err);
> +            return;
> +        }
> +
> +        if (sg_acc_mode_final_request) {
> +            if (qcrypto_hash_finalize_bytes(s->hash_ctx, &digest_buf,
> +                                            &digest_len, &local_err)) {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "qcrypto hash finalize failed : %s",
> +                              error_get_pretty(local_err));
> +                error_free(local_err);
> +                local_err = NULL;
> +            }
>   
> -    if (qcrypto_hash_bytesv(algo, iov, i, &digest_buf, &digest_len, NULL) < 0) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto failed\n", __func__);
> +            qcrypto_hash_free(s->hash_ctx);
> +
> +            s->hash_ctx = NULL;
> +            s->iov_count = 0;
> +            s->total_req_len = 0;
> +        }
> +    } else if (qcrypto_hash_bytesv(algo, iov, i, &digest_buf,
> +                                   &digest_len, &local_err) < 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "qcrypto hash bytesv failed : %s",
> +                      error_get_pretty(local_err));
> +        error_free(local_err);
>           return;
>       }
>   
> @@ -397,6 +406,11 @@ static void aspeed_hace_reset(DeviceState *dev)
>   {
>       struct AspeedHACEState *s = ASPEED_HACE(dev);
>   
> +    if (s->hash_ctx != NULL) {
> +        qcrypto_hash_free(s->hash_ctx);
> +        s->hash_ctx = NULL;
> +    }
> +
>       memset(s->regs, 0, sizeof(s->regs));
>       s->iov_count = 0;
>       s->total_req_len = 0;


