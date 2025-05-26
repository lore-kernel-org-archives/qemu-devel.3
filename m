Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015BDC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 11:49:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJWJx-0007WH-BA; Mon, 26 May 2025 07:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uJWJu-0007VA-Jn
 for qemu-devel@nongnu.org; Mon, 26 May 2025 07:48:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uJWJs-0004nf-LJ
 for qemu-devel@nongnu.org; Mon, 26 May 2025 07:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748260119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UTaI9LX+jxTOaPPpHOGYvqZm9NfJMliF/p2/pnLY1I4=;
 b=HOY1eTIS62GGwqcgLeuuH02jpZz28YAnJfICfGvYMG375nxDp/0XiWEcm5x+z/0x3ma9ie
 8ecT7Dcq1hEcofHdmd8dLC0TUXT1aJRzY76igrALam9hhHPNm1EzAuWmpo0XBiCGoW3MNf
 3N1dtoVX2YdvAYH8wGaJIwB9Xk8rXno=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-XXNObAajPNyLG4JuqAPOCA-1; Mon, 26 May 2025 07:48:38 -0400
X-MC-Unique: XXNObAajPNyLG4JuqAPOCA-1
X-Mimecast-MFC-AGG-ID: XXNObAajPNyLG4JuqAPOCA_1748260117
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-441c96c1977so12410515e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 04:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748260117; x=1748864917;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UTaI9LX+jxTOaPPpHOGYvqZm9NfJMliF/p2/pnLY1I4=;
 b=PsAog1sMHAdCsFKxNP7IWXcO7dY+5V+PVArM+m2ms+RkM790gz8PCfYVJf7vrUUth3
 sw1XpTsC04koSB1n6BQpy5nj7sQqajnbRVNaQMPetzPBF6rqA7V3ROuzzYmnqDwgljkI
 mCZUOzN2D/IQMPg92Tdui3FqSsmabLm8/7sUoOcVVi22vyB37kx3/2jd/3tcT+7Klk4n
 q4sMMog4ef51HH/m6dUPLVnZTBqCEhol8p+Id2qAOImgrkdUJEGLuNQgtgarBR+kia3I
 QP4mujvdgc5QXWbpl8Ro4+J5E6FG2ub6Z+C+r7dMZ5sirJjdpD5ZDwEWJhiTEnp+TkiQ
 ur6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWr+wPLx0IHbyWFhhykG4ddx6Gcyl+kbe7WqB4bdA3w1gLgRt5ZYe8BmO0U0QpcDvuRjL4XhQQZf8s@nongnu.org
X-Gm-Message-State: AOJu0Yw1R/5OYoj+MGk3bMZ6f3UbRIM9G/fdG+9kZyqzyGCJQVza7ui7
 W6zHo6Yu15rS9gJVWgBhR5KHqhVKzMcNj0a0Yc7o/dTlOrYP787LsfLbr7OUJa0wxhlIlW4Mnzk
 uBphVjYM+/q+LaZGYAyOFO58wG1/wz5Rib3D5MkD4/OKHz/Me06BUoKxR
X-Gm-Gg: ASbGncsrCz5r1QBrod7/F7wC/0MAdcVuZYTnJLnKDKTVt+jRw0GPVcYuirGZpIxCFGQ
 VH7kJpNiPSHWvHNDxWw5QSEUtVQU1OdblPwOct56/yjmfjdC63dFMJN37GP4hMGDIkSMNEiSmQx
 EiT4FS+H4JCqiXZlQBnQs247XkC7XSNjSOfPoOaN7UQ7sV7eeEm6ubyXIakse1Hb53wGXOKq8FO
 GQWNmHYXnfurhoBawvh3Gi/9nGMpkUMLTRmYAww/7fBSy9ZyJwrqBWeG6b1sRV0+vpeAaNutgVQ
 /Zfmh+O23wnkZ+gXtVnbTOWIV5VijrFPx2pA8Of+x7SmclxDug==
X-Received: by 2002:a05:600c:314b:b0:43d:45a:8fc1 with SMTP id
 5b1f17b1804b1-44c93da7c4dmr78069815e9.4.1748260116992; 
 Mon, 26 May 2025 04:48:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpwzgwtwlLTaI0RTHEisOkgrBNIbkDnS9nXQ7fX4NX3twtHdUI+na2PFpiuQdFYAaLJHmdkg==
X-Received: by 2002:a05:600c:314b:b0:43d:45a:8fc1 with SMTP id
 5b1f17b1804b1-44c93da7c4dmr78069565e9.4.1748260116579; 
 Mon, 26 May 2025 04:48:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4db284261sm2085850f8f.67.2025.05.26.04.48.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 04:48:36 -0700 (PDT)
Message-ID: <eff37ca7-d977-450e-85e0-ca8e4f6f3d5a@redhat.com>
Date: Mon, 26 May 2025 13:48:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/ppc: Add stub for pnv_chip_find_core()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20250526112346.48744-1-philmd@linaro.org>
 <20250526112346.48744-4-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250526112346.48744-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/26/25 13:23, Philippe Mathieu-Daudé wrote:
> Since commit 9808ce6d5cb, building QEMU configured with
> '--without-default-devices' fails:
> 
>    Undefined symbols for architecture arm64:
>      "_pnv_chip_find_core", referenced from:
>          _helper_load_sprd in target_ppc_misc_helper.c.o
>          _helper_store_sprd in target_ppc_misc_helper.c.o
>    ld: symbol(s) not found for architecture arm64
>    clang: error: linker command failed with exit code 1
> > Fix by adding a stub when CONFIG_POWERNV is not available.

The fix would be to add an abstract handler to implement SPRD accesses
on the PowerNV machine.

Thanks,

C.



> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Fixes: 9808ce6d5cb ("target/ppc: Big-core scratch register fix")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/ppc/pnv_stub.c  | 15 +++++++++++++++
>   hw/ppc/meson.build |  3 ++-
>   2 files changed, 17 insertions(+), 1 deletion(-)
>   create mode 100644 hw/ppc/pnv_stub.c
> 
> diff --git a/hw/ppc/pnv_stub.c b/hw/ppc/pnv_stub.c
> new file mode 100644
> index 00000000000..8d11c8b65bb
> --- /dev/null
> +++ b/hw/ppc/pnv_stub.c
> @@ -0,0 +1,15 @@
> +/*
> + * QEMU PowerPC PowerNV stubs
> + *
> + *  Copyright (c) Linaro
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/ppc/pnv.h"
> +
> +PnvCore *pnv_chip_find_core(PnvChip *chip, uint32_t core_id)
> +{
> +    g_assert_not_reached();
> +}
> diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
> index 9893f8adebb..02f248f5f46 100644
> --- a/hw/ppc/meson.build
> +++ b/hw/ppc/meson.build
> @@ -55,7 +55,8 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
>     'pnv_pnor.c',
>     'pnv_nest_pervasive.c',
>     'pnv_n1_chiplet.c',
> -))
> +), if_false: files('pnv_stub.c'))
> +
>   # PowerPC 4xx boards
>   ppc_ss.add(when: 'CONFIG_PPC440', if_true: files(
>     'ppc440_bamboo.c',


