Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95FDC28B30
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 14:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsMuf-00069u-S0; Wed, 12 Mar 2025 10:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tsMub-00069b-8E
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:18:21 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tsMuZ-00027m-A3
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:18:20 -0400
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e63504bedd0so4873768276.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 07:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741789097; x=1742393897; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QyAuhZ+YcdTcX2MQjCN5PxL2AFyvDSU6MZv5l4MR3K0=;
 b=fNqMNYXoerju08i0Un24ELdHhW5PG2KVuZ85W7OdSoK8VNL+bmDNNh3QiYjcwaAvs4
 wjGK1z7oWMc+MOndW80WmmO378f85Ow7sWiYBuk3d4JJ2r0ZnWwYyQa0QJGgpud17YMe
 Uf692W/zAyy16/6QJmRE3gACxZ6IIXGY0+5SBBQB1pvuR9/dQGoykwr+0LYr3TAROVFw
 03+UckMfTxDVEatEk7e/uDrIVFVBwUyaDBjrLePn8HK86WwDmzZt0PtgCOtk/FLu1vIv
 ioZQk81Xb8oi/4OE9bYOywbKMC+N9E2vlVhbIjx5a4mUmxKMHBQqP7ldzWYA4eIeAmQM
 rRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741789097; x=1742393897;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QyAuhZ+YcdTcX2MQjCN5PxL2AFyvDSU6MZv5l4MR3K0=;
 b=KhECyBfKJipiH6PhzQH8y71u9ykc1lKqvBJYdHKki4TYU2Bof6wi4E2qAKten+QM/b
 jC+yWi9a4m90B0ghri1lyv0lifKSyALJN/95HhTvqwGEaFQKxPnn/Gyinp8Bsi6oRlb7
 l25b4x/GH4JtXDro4HUl73c9UnypZS2vhGFS38p843x05O6mjAhuWJW1V+e/u0P9cJ4i
 3tBQUF9AVuJ9WrUaUnph4EG8zM5wNj73244VnmL+T4AaMQzqDqtLDM8Noe9tGCB+NKx6
 pQe+uxAYl1PE+zmRoYskssbQv+Fvxbo/MPAfMCqJerH26Ju1PLiGNYTvO4hKKe2nKePg
 IFsg==
X-Gm-Message-State: AOJu0YzkEXsZXzf4wlJOb1V2UgxXnQE/Y0Sd37Z79IpDn1ggdK+zqnVM
 O97CFh0TRz3aOuCDCeV8v+e4Bd5lVYdccVcUdgNH8ffO8VmkDAHK5SEZwvJoJ+6uJ7Ly5caKaQW
 VNoKxi312StpEjvhWt247RYMbrpswwm37yR6OzA==
X-Gm-Gg: ASbGncsHVuNRrT76YPpktuksS3+V1WztmoE47pz2ORtyRvYqo/ypQVYgaN2U95WYlAt
 iOiHWMEgP/Stv3ELef6H00qJuRmCzLrhiZanlLhVfIVJ8roNQfFy3hAKBG9f59kTwr74wdbh289
 L5SPAdsqZRLnJwR52gSpilB5NNkeE=
X-Google-Smtp-Source: AGHT+IHnPtYP94s9dcpOQAeaQ1lqNHqAy/IX7qppJz9ft/P5cJhN2Fuzr4aGkNM0+v7S/jnXrdl+PFNAUX99I26aTtw=
X-Received: by 2002:a05:6902:1b12:b0:e63:6e52:2140 with SMTP id
 3f1490d57ef6-e63b5180997mr8936687276.16.1741789097710; Wed, 12 Mar 2025
 07:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250310203622.1827940-1-komlodi@google.com>
 <20250310203622.1827940-2-komlodi@google.com>
In-Reply-To: <20250310203622.1827940-2-komlodi@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 12 Mar 2025 14:18:05 +0000
X-Gm-Features: AQ5f1JoCViMQ22iJltuKjGz_K1SH4fOLu33rsNwKD7wOk6h4n6dOBEGwNQ-kJdQ
Message-ID: <CAFEAcA8VO4QNU5+9Xk=AiBObXFCRoPF3NUN9m2r1752oi1cShA@mail.gmail.com>
Subject: Re: [PATCH 1/1] util/cacheflush: Make first DSB unconditional on
 aarch64
To: Joe Komlodi <komlodi@google.com>
Cc: qemu-devel@nongnu.org, slongfield@google.com, richard.henderson@linaro.org,
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
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

On Mon, 10 Mar 2025 at 20:36, Joe Komlodi <komlodi@google.com> wrote:
>
> On ARM hosts with CTR_EL0.DIC and CTR_EL0.IDC set, this would only cause
> an ISB to be executed during cache maintenance, which could lead to QEMU
> executing TBs containing garbage instructions.
>
> This seems to be because the ISB finishes executing instructions and
> flushes the pipeline, but the ISB doesn't guarantee that writes from the
> executed instructions are committed. If a small enough TB is created, it's
> possible that the writes setting up the TB aren't committed by the time the
> TB is executed.

Yes; we need the DSB to ensure that the stores have completed
and are visible to subsequent icache fills; and then we need
the ISB to ensure that any instructions that we execute after
this are done with an instruction fetch that happens after the
ISB (i.e. the CPU hasn't already speculatively fetched the insn
before we forced the store to complete).

> This function is intended to be a port of the gcc implementation
> (https://github.com/gcc-mirror/gcc/blob/85b46d0795ac76bc192cb8f88b646a647acf98c1/libgcc/config/aarch64/sync-cache.c#L67)
> which makes the first DSB unconditional, so we can fix the synchronization
> issue by doing that as well.
>
> Signed-off-by: Joe Komlodi <komlodi@google.com>

We should add:

Cc: qemu-stable@nongnu.org
Fixes: 664a79735e4deb1 ("util: Specialize flush_idcache_range for aarch64")

> ---
>  util/cacheflush.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/util/cacheflush.c b/util/cacheflush.c
> index a08906155a..1d12899a39 100644
> --- a/util/cacheflush.c
> +++ b/util/cacheflush.c
> @@ -279,9 +279,11 @@ void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
>          for (p = rw & -dcache_lsize; p < rw + len; p += dcache_lsize) {
>              asm volatile("dc\tcvau, %0" : : "r" (p) : "memory");
>          }
> -        asm volatile("dsb\tish" : : : "memory");
>      }
>
> +    /* DSB unconditionally to ensure any outstanding writes are committed. */
> +    asm volatile("dsb\tish" : : : "memory");
> +
>      /*
>       * If CTR_EL0.DIC is enabled, Instruction cache cleaning to the Point
>       * of Unification is not required for instruction to data coherence.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Richard, are you doing a TCG pullreq for rc0? If not, I can
put this into target-arm.next.

thanks
-- PMM

