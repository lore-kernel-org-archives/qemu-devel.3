Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C95AC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 05:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfvSZ-0001Wx-Pi; Fri, 01 Mar 2024 00:29:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfvSR-0001Wc-Vp
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 00:29:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfvSQ-0003nK-9u
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 00:29:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709270957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mKifrSbFFPqzQAeAXeUl/ps8q6Qkwjn6MmN5oS4nnhI=;
 b=EsZoV6+tmMwDsASRM2P757UMTZNsmtaOA1/JIyF2zczvmhMGBuE/XfchN81p24h3tHBBn4
 B6TiSayHy9ca3kE1OSlHA8JhAuICQ3nlVmo7sUBlfaqP5POO3fni/7Do/LlFlFXwOAYPbV
 p2XPsqFC3O+1flBcIYDwfBoQJhzu/ts=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-57Io8zCyMsq-VE-TD7_pEw-1; Fri, 01 Mar 2024 00:29:15 -0500
X-MC-Unique: 57Io8zCyMsq-VE-TD7_pEw-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5cf53f904f9so342677a12.1
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 21:29:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709270955; x=1709875755;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mKifrSbFFPqzQAeAXeUl/ps8q6Qkwjn6MmN5oS4nnhI=;
 b=isSKCX+uhRafI7vTY4Fqg4oOR7DTThqoYwW2Lya71HgvtB85hVRnOviSo1FAfzd0nN
 F9nePi5nMEcWA1zG/pVQj7GCE4LKjC0zXfV3Ax8bzsjoG7gG1tKrimMgd/MhfE/nb3Md
 v5hfYOu6Rx2oZnbVgmUk0zxOZj7lwXA5ErxKteEpTT7CQlsloLRf1P1p7jvmwVIYHZid
 3qgVExJ0zsVYTzVV1XQDcbQLaV2Yrb4+BaY2dQiwaxr3kWdIuTDhbyrjO0tJBXZL9sHe
 AU6U8zxh5GCdLgUP0S3+acZ5EiYDqvP+3fn3pKfWe4mLbAzowkee/2C0EOo631fXbwb9
 1gxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKPkAcYgVpRpmmxRGskzJu+02AhR4zjiairTeD3U9x0kU9H+4gR67joLuRBu/zlXga8U14oa0DbHOCk7I8SSi0ts7QeZ4=
X-Gm-Message-State: AOJu0YxCOb/SC0s9bTS2VoS7sEgbASJ/feGObQVkkMsL+fKVRuOXue+i
 4QJCz4FD6TfbyDQckrSo+U7B9UHnthqDgd4WppUwNE53j//ZhBh0+pnXHU8i6n4Sl14PuPF/0MG
 bk/4mPHJoNSDlj2UcLTUNuu2LY0uMFxXVk/rj/4/RZuZN26PhtETm
X-Received: by 2002:a05:6a00:2da1:b0:6e5:3ec5:e814 with SMTP id
 fb33-20020a056a002da100b006e53ec5e814mr904041pfb.0.1709270954770; 
 Thu, 29 Feb 2024 21:29:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKlUbXG0aWUdhb7ygAnvZ8CPbWt17to3CDaTa/rrum2COOkha3wFYd4OtDwThxIuxKETPubQ==
X-Received: by 2002:a05:6a00:2da1:b0:6e5:3ec5:e814 with SMTP id
 fb33-20020a056a002da100b006e53ec5e814mr904030pfb.0.1709270954401; 
 Thu, 29 Feb 2024 21:29:14 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 jw16-20020a056a00929000b006e553cab65bsm2130323pfb.207.2024.02.29.21.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 21:29:14 -0800 (PST)
Date: Fri, 1 Mar 2024 13:29:04 +0800
From: Peter Xu <peterx@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, linuxarm@huawei.com
Subject: Re: [PATCH 2/3] physmem: Factor out body of
 flatview_read/write_continue() loop
Message-ID: <ZeFnoBLJ_fKhLD8r@x1n>
References: <20240215142817.1904-1-Jonathan.Cameron@huawei.com>
 <20240215142817.1904-3-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240215142817.1904-3-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 15, 2024 at 02:28:16PM +0000, Jonathan Cameron wrote:
> This code will be reused for the address_space_cached accessors
> shortly.
> 
> Also reduce scope of result variable now we aren't directly
> calling this in the loop.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  system/physmem.c | 165 ++++++++++++++++++++++++++++-------------------
>  1 file changed, 98 insertions(+), 67 deletions(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index 39b5ac751e..74f92bb3b8 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2677,6 +2677,54 @@ static bool flatview_access_allowed(MemoryRegion *mr, MemTxAttrs attrs,
>      return false;
>  }
>  
> +static MemTxResult flatview_write_continue_step(hwaddr addr,
> +                                                MemTxAttrs attrs,
> +                                                const uint8_t *buf,
> +                                                hwaddr len, hwaddr addr1,
> +                                                hwaddr *l, MemoryRegion *mr)
> +{
> +    if (!flatview_access_allowed(mr, attrs, addr1, *l)) {
> +        return MEMTX_ACCESS_ERROR;
> +    }
> +
> +    if (!memory_access_is_direct(mr, true)) {
> +        uint64_t val;
> +        MemTxResult result;
> +        bool release_lock = prepare_mmio_access(mr);
> +
> +        *l = memory_access_size(mr, *l, addr1);
> +        /* XXX: could force current_cpu to NULL to avoid
> +           potential bugs */
> +
> +        /*
> +         * Assure Coverity (and ourselves) that we are not going to OVERRUN
> +         * the buffer by following ldn_he_p().
> +         */
> +#ifdef QEMU_STATIC_ANALYSIS
> +        assert((*l == 1 && len >= 1) ||
> +               (*l == 2 && len >= 2) ||
> +               (*l == 4 && len >= 4) ||
> +               (*l == 8 && len >= 8));
> +#endif
> +        val = ldn_he_p(buf, *l);
> +        result = memory_region_dispatch_write(mr, addr1, val,
> +                                              size_memop(*l), attrs);
> +        if (release_lock) {
> +            bql_unlock();
> +        }
> +
> +        return result;
> +    } else {
> +        /* RAM case */
> +        uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, addr1, l, false);
> +
> +        memmove(ram_ptr, buf, *l);
> +        invalidate_and_set_dirty(mr, addr1, *l);
> +
> +        return MEMTX_OK;
> +    }
> +}
> +
>  /* Called within RCU critical section.  */
>  static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
>                                             MemTxAttrs attrs,
> @@ -2688,42 +2736,9 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
>      const uint8_t *buf = ptr;
>  
>      for (;;) {
> -        if (!flatview_access_allowed(mr, attrs, addr1, l)) {
> -            result |= MEMTX_ACCESS_ERROR;
> -            /* Keep going. */
> -        } else if (!memory_access_is_direct(mr, true)) {
> -            uint64_t val;
> -            bool release_lock = prepare_mmio_access(mr);
> -
> -            l = memory_access_size(mr, l, addr1);
> -            /* XXX: could force current_cpu to NULL to avoid
> -               potential bugs */
> -
> -            /*
> -             * Assure Coverity (and ourselves) that we are not going to OVERRUN
> -             * the buffer by following ldn_he_p().
> -             */
> -#ifdef QEMU_STATIC_ANALYSIS
> -            assert((l == 1 && len >= 1) ||
> -                   (l == 2 && len >= 2) ||
> -                   (l == 4 && len >= 4) ||
> -                   (l == 8 && len >= 8));
> -#endif
> -            val = ldn_he_p(buf, l);
> -            result |= memory_region_dispatch_write(mr, addr1, val,
> -                                                   size_memop(l), attrs);
> -            if (release_lock) {
> -                bql_unlock();
> -            }
> -
>  
> -        } else {
> -            /* RAM case */
> -            uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l,
> -                                                   false);
> -            memmove(ram_ptr, buf, l);
> -            invalidate_and_set_dirty(mr, addr1, l);
> -        }
> +        result |= flatview_write_continue_step(addr, attrs, buf, len, addr1, &l,
> +                                               mr);
>  
>          len -= l;
>          buf += l;
> @@ -2757,6 +2772,52 @@ static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
>                                     addr1, l, mr);
>  }
>  
> +static MemTxResult flatview_read_continue_step(hwaddr addr,
> +                                               MemTxAttrs attrs, uint8_t *buf,
> +                                               hwaddr len, hwaddr addr1,
> +                                               hwaddr *l,
> +                                               MemoryRegion *mr)
> +{
> +    if (!flatview_access_allowed(mr, attrs, addr1, *l)) {
> +        return  MEMTX_ACCESS_ERROR;
                  |
                  ^ space

> +    }
> +
> +    if (!memory_access_is_direct(mr, false)) {
> +        /* I/O case */
> +        uint64_t val;
> +        MemTxResult result;
> +        bool release_lock = prepare_mmio_access(mr);
> +
> +        *l = memory_access_size(mr, *l, addr1);
> +        result = memory_region_dispatch_read(mr, addr1, &val,
> +                                                  size_memop(*l), attrs);

Please do proper indents.

Other than that:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


