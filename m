Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4902D59F5A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 17:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8k9h-0000SX-JB; Wed, 06 Nov 2024 12:49:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t8k9g-0000S2-JB
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:49:20 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t8k9e-0007X2-QZ
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:49:20 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43162cf1eaaso1077155e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 09:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730915357; x=1731520157; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vU0yxeUeeQjYu+6+Ks5E67A+GOiWsnQ4QMaXjXo138M=;
 b=Y+CJeJJmA3Pg2jDGrsA1GEwsx+pNVFmcNEwtLOJuRWUkdBFmvSG1Ehn/feX30qhEZW
 XhpV6+joTE9s/gjB/OGk3VjzmuMzPI8rwmOo9c7gPF6EFw1RbQxp+oUtRRIVLPcPtHmO
 2CaIE5tUf1Dp+GobIERo1QhOk2FlBs6LP6y8I4UqQm8rn0GigZgOZlI/msR/H7KyiODO
 QcjTv1DS2zHkiQ13vs8aR2g1rUcZkUuZA9/ACEYODWjkzd+KyVlP/gbJcymX+ctBv3dr
 OuO9o1FW8uJKsXqOOo6p5xGmYmOsXbjkyPg+yDU3fuPgXTCH4HKHp646Gr4Jw+A/+++6
 HPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730915357; x=1731520157;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vU0yxeUeeQjYu+6+Ks5E67A+GOiWsnQ4QMaXjXo138M=;
 b=B6X6EI6w7/r/GrVSBfCQFV9iyPpWAsOdwPtaSiynUn6/ZzhcMrbxC+rYlcpKAceWBg
 bNP8zpzpUnBZW99y9TQIb9K9dCZqIoIjRMYH1BFM3CAXtPmefiivM7ddVQFRzZnaVuWr
 lI/dujtVwbN1eT58FrsHibZ3WgGtuXDixCuq4FMmLqYkTsLMaMajn1gLYYLcndIfAm7J
 2C2sfJpyicw4t7RwH1Aymk1hMza+6uFmWZwTBfgSzcezATmljMfArsTQ+nHU+oXt6l7c
 CEiMPe0tIS5giwdtbcgrEzSG0z1/5gXYX1nXxGYZ2breUiuLs3GHwhByFmrNX2vRh5Lb
 90+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0A0NPCvvQyxhjzaclRdWgVZii86pbsaYRCjQzdoutgSikyXwyysRm4EoQcA0W9FJol+g+b20gASrX@nongnu.org
X-Gm-Message-State: AOJu0Yz9zQkTo10uoaW5X7NxtVQpTk/VqK8aZtN5Qy6VcR1kCNCVAJAK
 hY25rSI3seQT54M1ycVTOwuJ47BNsIO9sl0hsyt0Iqiew0MAh2+rqZxWCH4bYI8whOJsR9DyW7y
 w1Zw3Ax6r
X-Google-Smtp-Source: AGHT+IE/AKTbFhyTqedqbK09JxZklNLz3ZJYMb/JPSuNQWvbVO/GP/yitct6kBe3veftRCJ5oa9XZw==
X-Received: by 2002:a05:600c:4ec6:b0:431:542d:2599 with SMTP id
 5b1f17b1804b1-4328327c4d7mr218939805e9.22.1730915356943; 
 Wed, 06 Nov 2024 09:49:16 -0800 (PST)
Received: from [10.134.195.192] ([193.32.126.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6c0414sm30869915e9.23.2024.11.06.09.49.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 09:49:16 -0800 (PST)
Message-ID: <511e6589-1a99-4665-9a08-d9cea1f7bee9@linaro.org>
Date: Wed, 6 Nov 2024 09:49:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eif: cope with huge section sizes
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: dorjoychy111@gmail.com
References: <20241106174443.557557-1-pbonzini@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241106174443.557557-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 11/6/24 09:44, Paolo Bonzini wrote:
> Check for overflow as well as allocation failure.  Resolves Coverity CID 1564859.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/core/eif.c | 48 +++++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 41 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/core/eif.c b/hw/core/eif.c
> index cbcd80de58b..25f2aedf3fa 100644
> --- a/hw/core/eif.c
> +++ b/hw/core/eif.c
> @@ -123,6 +123,10 @@ static bool read_eif_header(FILE *f, EifHeader *header, uint32_t *crc,
>   
>       for (int i = 0; i < MAX_SECTIONS; ++i) {
>           header->section_sizes[i] = be64_to_cpu(header->section_sizes[i]);
> +        if (header->section_sizes[i] > SSIZE_MAX) {
> +            error_setg(errp, "Invalid EIF image. Section size out of bounds");
> +            return false;
> +        }
>       }
>   
>       header->unused = be32_to_cpu(header->unused);
> @@ -282,7 +286,12 @@ static bool get_signature_fingerprint_sha384(FILE *eif, uint64_t size,
>       struct cbor_load_result result;
>       bool ret = false;
>   
> -    sig = g_malloc(size);
> +    sig = g_try_malloc(size);
> +    if (!sig) {
> +        error_setg(errp, "Out of memory reading signature section");
> +        goto cleanup;
> +    }
> +
>       got = fread(sig, 1, size, eif);
>       if ((uint64_t) got != size) {
>           error_setg(errp, "Failed to read EIF signature section data");
> @@ -324,7 +333,12 @@ static bool get_signature_fingerprint_sha384(FILE *eif, uint64_t size,
>           error_setg(errp, "Invalid signature CBOR");
>           goto cleanup;
>       }
> -    cert = g_malloc(len);
> +    cert = g_try_malloc(len);
> +    if (!cert) {
> +        error_setg(errp, "Out of memory reading signature section");
> +        goto cleanup;
> +    }
> +
>       for (int i = 0; i < len; ++i) {
>           cbor_item_t *tmp = cbor_array_get(pair->value, i);
>           if (!tmp) {
> @@ -503,7 +517,11 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
>                   goto cleanup;
>               }
>   
> -            ptr = g_malloc(hdr.section_size);
> +            ptr = g_try_malloc(hdr.section_size);
> +            if (!ptr) {
> +                error_setg(errp, "Out of memory reading kernel section");
> +                goto cleanup;
> +            }
>   
>               iov_ptr = g_malloc(sizeof(struct iovec));
>               iov_ptr->iov_base = ptr;
> @@ -528,7 +546,11 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
>                   goto cleanup;
>               }
>               size = hdr.section_size;
> -            *cmdline = g_malloc(size + 1);
> +            *cmdline = g_try_malloc(size + 1);
> +            if (!cmdline) {
> +                error_setg(errp, "Out of memory reading command line section");
> +                goto cleanup;
> +            }
>               if (!read_eif_cmdline(f, size, *cmdline, &crc, errp)) {
>                   goto cleanup;
>               }
> @@ -567,7 +589,11 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
>                   }
>               }
>   
> -            ptr = g_malloc(hdr.section_size);
> +            ptr = g_try_malloc(hdr.section_size);
> +            if (!ptr) {
> +                error_setg(errp, "Out of memory reading initrd section");
> +                goto cleanup;
> +            }
>   
>               iov_ptr = g_malloc(sizeof(struct iovec));
>               iov_ptr->iov_base = ptr;
> @@ -606,7 +632,11 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
>               uint8_t *buf;
>               size_t got;
>               uint64_t size = hdr.section_size;
> -            buf = g_malloc(size);
> +            buf = g_try_malloc(size);
> +            if (!buf) {
> +                error_setg(errp, "Out of memory reading unknown section");
> +                goto cleanup;
> +            }
>               got = fread(buf, 1, size, f);
>               if ((uint64_t) got != size) {
>                   g_free(buf);
> @@ -662,7 +692,11 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
>               goto cleanup;
>           }
>   
> -        ptr = g_malloc(machine_initrd_size);
> +        ptr = g_try_malloc(machine_initrd_size);
> +        if (!ptr) {
> +            error_setg(errp, "Out of memory reading initrd file");
> +            goto cleanup;
> +        }
>   
>           iov_ptr = g_malloc(sizeof(struct iovec));
>           iov_ptr->iov_base = ptr;

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


