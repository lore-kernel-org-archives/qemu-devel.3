Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB4CC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 05:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfvYe-00030B-BQ; Fri, 01 Mar 2024 00:35:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfvYb-0002zQ-KP
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 00:35:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfvYZ-00051u-V7
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 00:35:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709271338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cHDa3NyKdnfgoqWsXFLe3750+/pe92Ommeg8MxEwmTU=;
 b=NcWGNb2tlINZn6Hs/t8Yu6ZhvKuApqqcTyvUrr0cGUmpK6ae6PYyqkwVw0na8nDdvjL+Xw
 zSmsEtVuDtgt9r1QxXr2yqnoUIF2m3auDHtKQx10OCmtnrKiBok4bGSUZasMSAFFp0exUO
 n9HMNXfKROvfmTZ6t9LNreWCVP/plzk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-e4y1dOlsPt-48q3sYoRHlg-1; Fri, 01 Mar 2024 00:35:36 -0500
X-MC-Unique: e4y1dOlsPt-48q3sYoRHlg-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1dcda4d7cdfso1556075ad.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 21:35:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709271336; x=1709876136;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cHDa3NyKdnfgoqWsXFLe3750+/pe92Ommeg8MxEwmTU=;
 b=COkriELqoL1b9py9R2B2kxf3hy+UramBnty7aK/Nu9N+irSThNGnltdjgfGjdJPU51
 9wcPFy+vn1mzmK9pn+JNtvBaM8i4p2Zujyxh/yo9WNd7f2D3wOGN3dkRyxgk6GcfYO5t
 RVANq2EfuHK7NnaKMWtNLj9+qXpuKBphKbz2TqNloNETw0ox3Xz0Pf8snpAMHiObAAF7
 6UzUs8Atc0y359KKK0LhQqxK8heEodtxVZrN2VtyeUBti7tIbLpUS82CeQs0JRO6mK24
 Jox6eqVCRfX1MEPzGyq+GKpNRZl2XAAxHy6d6B5VXA3inAMpVTTUt34txojrux0guM7r
 GULw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqfAb6bdoviyq6KQ9B1NE+VVcso06FayxjrF+r89wz1HqbK26CuZdE3Zy47LVhrDJRAx72g/+Ha26H7cDzU0GNaPzkBtE=
X-Gm-Message-State: AOJu0YzeD/cKwDLUIFxURCZB7qTZfMH4vImDMJS93IJ50EYddEhJQedS
 68F1W2wvCODebjZfISInzjMLY7xzcvppIzTetxj3JZLbuZrsV11x83mHUPQfcqGnnw0WxN8F+0t
 N4pzB4Xba940zXK98TUDErNAHK03ULMbfxudgcGQ99c8NWFUlN3IT
X-Received: by 2002:a05:6a20:b12a:b0:1a1:281b:ff1f with SMTP id
 ed42-20020a056a20b12a00b001a1281bff1fmr431724pzb.6.1709271335905; 
 Thu, 29 Feb 2024 21:35:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFArEIK27zPzZIJ/qz4gH4WQH1nJNbNfpY2nDcG6bsKtVLBwJFZYCoyhnWE20VHDYvieglHvg==
X-Received: by 2002:a05:6a20:b12a:b0:1a1:281b:ff1f with SMTP id
 ed42-20020a056a20b12a00b001a1281bff1fmr431718pzb.6.1709271335530; 
 Thu, 29 Feb 2024 21:35:35 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 sv8-20020a17090b538800b0029658c7bd53sm4563153pjb.5.2024.02.29.21.35.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 21:35:35 -0800 (PST)
Date: Fri, 1 Mar 2024 13:35:26 +0800
From: Peter Xu <peterx@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, linuxarm@huawei.com
Subject: Re: [PATCH 2/3] physmem: Factor out body of
 flatview_read/write_continue() loop
Message-ID: <ZeFpHr0KU6NWMv1x@x1n>
References: <20240215142817.1904-1-Jonathan.Cameron@huawei.com>
 <20240215142817.1904-3-Jonathan.Cameron@huawei.com>
 <ZeFnoBLJ_fKhLD8r@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZeFnoBLJ_fKhLD8r@x1n>
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

On Fri, Mar 01, 2024 at 01:29:04PM +0800, Peter Xu wrote:
> On Thu, Feb 15, 2024 at 02:28:16PM +0000, Jonathan Cameron wrote:
> > This code will be reused for the address_space_cached accessors
> > shortly.
> > 
> > Also reduce scope of result variable now we aren't directly
> > calling this in the loop.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  system/physmem.c | 165 ++++++++++++++++++++++++++++-------------------
> >  1 file changed, 98 insertions(+), 67 deletions(-)
> > 
> > diff --git a/system/physmem.c b/system/physmem.c
> > index 39b5ac751e..74f92bb3b8 100644
> > --- a/system/physmem.c
> > +++ b/system/physmem.c
> > @@ -2677,6 +2677,54 @@ static bool flatview_access_allowed(MemoryRegion *mr, MemTxAttrs attrs,
> >      return false;
> >  }
> >  
> > +static MemTxResult flatview_write_continue_step(hwaddr addr,

One more thing: this addr var is not used, afaict.  We could drop addr1
below and use this to represent the MR offset.

I'm wondering whether we should start to use some better namings already
for memory API functions to show obviously what AS it is describing.  From
that POV, perhaps rename it to "mr_addr"?

> > +                                                MemTxAttrs attrs,
> > +                                                const uint8_t *buf,
> > +                                                hwaddr len, hwaddr addr1,
> > +                                                hwaddr *l, MemoryRegion *mr)
> > +{
> > +    if (!flatview_access_allowed(mr, attrs, addr1, *l)) {
> > +        return MEMTX_ACCESS_ERROR;
> > +    }
> > +
> > +    if (!memory_access_is_direct(mr, true)) {
> > +        uint64_t val;
> > +        MemTxResult result;
> > +        bool release_lock = prepare_mmio_access(mr);
> > +
> > +        *l = memory_access_size(mr, *l, addr1);
> > +        /* XXX: could force current_cpu to NULL to avoid
> > +           potential bugs */
> > +
> > +        /*
> > +         * Assure Coverity (and ourselves) that we are not going to OVERRUN
> > +         * the buffer by following ldn_he_p().
> > +         */
> > +#ifdef QEMU_STATIC_ANALYSIS
> > +        assert((*l == 1 && len >= 1) ||
> > +               (*l == 2 && len >= 2) ||
> > +               (*l == 4 && len >= 4) ||
> > +               (*l == 8 && len >= 8));
> > +#endif
> > +        val = ldn_he_p(buf, *l);
> > +        result = memory_region_dispatch_write(mr, addr1, val,
> > +                                              size_memop(*l), attrs);
> > +        if (release_lock) {
> > +            bql_unlock();
> > +        }
> > +
> > +        return result;
> > +    } else {
> > +        /* RAM case */
> > +        uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, addr1, l, false);
> > +
> > +        memmove(ram_ptr, buf, *l);
> > +        invalidate_and_set_dirty(mr, addr1, *l);
> > +
> > +        return MEMTX_OK;
> > +    }
> > +}
> > +
> >  /* Called within RCU critical section.  */
> >  static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
> >                                             MemTxAttrs attrs,
> > @@ -2688,42 +2736,9 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
> >      const uint8_t *buf = ptr;
> >  
> >      for (;;) {
> > -        if (!flatview_access_allowed(mr, attrs, addr1, l)) {
> > -            result |= MEMTX_ACCESS_ERROR;
> > -            /* Keep going. */
> > -        } else if (!memory_access_is_direct(mr, true)) {
> > -            uint64_t val;
> > -            bool release_lock = prepare_mmio_access(mr);
> > -
> > -            l = memory_access_size(mr, l, addr1);
> > -            /* XXX: could force current_cpu to NULL to avoid
> > -               potential bugs */
> > -
> > -            /*
> > -             * Assure Coverity (and ourselves) that we are not going to OVERRUN
> > -             * the buffer by following ldn_he_p().
> > -             */
> > -#ifdef QEMU_STATIC_ANALYSIS
> > -            assert((l == 1 && len >= 1) ||
> > -                   (l == 2 && len >= 2) ||
> > -                   (l == 4 && len >= 4) ||
> > -                   (l == 8 && len >= 8));
> > -#endif
> > -            val = ldn_he_p(buf, l);
> > -            result |= memory_region_dispatch_write(mr, addr1, val,
> > -                                                   size_memop(l), attrs);
> > -            if (release_lock) {
> > -                bql_unlock();
> > -            }
> > -
> >  
> > -        } else {
> > -            /* RAM case */
> > -            uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l,
> > -                                                   false);
> > -            memmove(ram_ptr, buf, l);
> > -            invalidate_and_set_dirty(mr, addr1, l);
> > -        }
> > +        result |= flatview_write_continue_step(addr, attrs, buf, len, addr1, &l,
> > +                                               mr);
> >  
> >          len -= l;
> >          buf += l;
> > @@ -2757,6 +2772,52 @@ static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
> >                                     addr1, l, mr);
> >  }
> >  
> > +static MemTxResult flatview_read_continue_step(hwaddr addr,
> > +                                               MemTxAttrs attrs, uint8_t *buf,
> > +                                               hwaddr len, hwaddr addr1,
> > +                                               hwaddr *l,
> > +                                               MemoryRegion *mr)
> > +{
> > +    if (!flatview_access_allowed(mr, attrs, addr1, *l)) {
> > +        return  MEMTX_ACCESS_ERROR;
>                   |
>                   ^ space
> 
> > +    }
> > +
> > +    if (!memory_access_is_direct(mr, false)) {
> > +        /* I/O case */
> > +        uint64_t val;
> > +        MemTxResult result;
> > +        bool release_lock = prepare_mmio_access(mr);
> > +
> > +        *l = memory_access_size(mr, *l, addr1);
> > +        result = memory_region_dispatch_read(mr, addr1, &val,
> > +                                                  size_memop(*l), attrs);
> 
> Please do proper indents.
> 
> Other than that:
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> -- 
> Peter Xu

-- 
Peter Xu


