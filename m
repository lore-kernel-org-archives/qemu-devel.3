Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86596C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:16:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFe7-000702-DP; Mon, 18 Mar 2024 12:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rmFe4-0006yW-62
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:15:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rmFe2-0004Ps-BV
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710778523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PYKUVe+R/AI6Jux+MQS3obISa51Dg5rB22KdrQYfWcY=;
 b=OCSn2VEMnhocLXJmSGjpSuCH4gSb05/Tg1pSVePYIvSdo9obJZmJBQX8EJfMdU2pDYuetk
 mn66dchaG5aJx1SJqhgolsQCb9GrX5FSykAemJFoEHC6sAXhg5WKFB/Zr/nxw3BooiF9TL
 HKoHpwA5EEB7yaMrAuFIl2FciOr8Uaw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-9aUJN2wFPqG6c6ScUfR4rw-1; Mon, 18 Mar 2024 12:15:20 -0400
X-MC-Unique: 9aUJN2wFPqG6c6ScUfR4rw-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-430d73c0492so2604701cf.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:15:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710778520; x=1711383320;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PYKUVe+R/AI6Jux+MQS3obISa51Dg5rB22KdrQYfWcY=;
 b=Wl7vbn1hqu3mydQwZ7tCdDrrRN/szdEn88dr5dl/U6ZF/NUhw2/w3s+wRVaRRnBK15
 DT5yVFdRKfkEpRfzdQjWlqb8cs/RXsCoMsJ8uoMo0ndRUOlzPW/BzFut/Q4aeZuHnmya
 +o/lrjuSRyte+t5pQoWdxY1DO96Fadt2FNsD5Kx/NbotjT5kiWqkymdBt4yFgak5OM/m
 6f8FiY98/h8+8hxbB3U8hNeDQTOl7g8jW3CMh1l8MInkJ8piBAfr9Kiu/4QNCM34W5xj
 FiOgtwQrw3OT1jd5A8fGy++TUXCBu9k/dZfpKA4YPpnlZxWEPG9QCcqPStHhYde/Yb4p
 QCeA==
X-Gm-Message-State: AOJu0YyOK/Zn5g4fOFwmSlLujuvhhJRUQnSe+DBkRmPO1Rq+i8YTzfKl
 YQpql+ksamumUhO9y5SqJ6sEblZRbuTZTMezqBi7j5PjOcZhj4FPWrQVJ0/EJ7Zp0Us/m+nPZz2
 7MxkdiktUrkq4NWJmbIDA9DrX/LZFxmwNxEkUG2GPJz//hbEN2cLU
X-Received: by 2002:a05:6214:4384:b0:691:2524:2d87 with SMTP id
 oh4-20020a056214438400b0069125242d87mr14276354qvb.2.1710778519759; 
 Mon, 18 Mar 2024 09:15:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyg1Zs2TFt2knjFawIurlWGWL9rEMIkaTXzXQcy6YOYzDkt91KmE7edm/Ce7fUnDslS5HXjg==
X-Received: by 2002:a05:6214:4384:b0:691:2524:2d87 with SMTP id
 oh4-20020a056214438400b0069125242d87mr14276324qvb.2.1710778519257; 
 Mon, 18 Mar 2024 09:15:19 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 gm9-20020a056214268900b00691865eae7bsm3403408qvb.4.2024.03.18.09.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 09:15:18 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:15:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 1/2] system/memory.c: support unaligned access
Message-ID: <ZfholB7fuWEbuBss@x1n>
References: <20240201081313.1339788-1-tomoyuki.hirose@igel.co.jp>
 <20240201081313.1339788-2-tomoyuki.hirose@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240201081313.1339788-2-tomoyuki.hirose@igel.co.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi,

On Thu, Feb 01, 2024 at 05:13:12PM +0900, Tomoyuki HIROSE wrote:
> The previous code ignored 'impl.unaligned' and handled unaligned accesses
> as is. But this implementation cannot emulate specific registers of some
> devices that allow unaligned access such as xHCI Host Controller Capability
> Registers.
> This commit checks 'impl.unaligned' and if it is false, QEMU emulates
> unaligned access with multiple aligned access.

This patch looks mostly good to me.  Just a few trivial comments.

Firstly, can we provide the USB example here (or also the bug link) so that
we can still pick up the context of why this will start to be useful when
people read about this commit separately?

> 
> Signed-off-by: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
> ---
>  system/memory.c | 38 +++++++++++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/system/memory.c b/system/memory.c
> index a229a79988..a7ca0c9f54 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -535,10 +535,17 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
>                                        MemTxAttrs attrs)
>  {
>      uint64_t access_mask;
> +    unsigned access_mask_shift;
> +    unsigned access_mask_start_offset;
> +    unsigned access_mask_end_offset;
>      unsigned access_size;
> -    unsigned i;
>      MemTxResult r = MEMTX_OK;
>      bool reentrancy_guard_applied = false;
> +    bool is_big_endian = memory_region_big_endian(mr);
> +    signed start_diff;
> +    signed current_offset;
> +    signed access_shift;
> +    hwaddr current_addr;
>  
>      if (!access_size_min) {
>          access_size_min = 1;
> @@ -560,19 +567,24 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
>          reentrancy_guard_applied = true;
>      }
>  
> -    /* FIXME: support unaligned access? */
>      access_size = MAX(MIN(size, access_size_max), access_size_min);
> -    access_mask = MAKE_64BIT_MASK(0, access_size * 8);
> -    if (memory_region_big_endian(mr)) {
> -        for (i = 0; i < size; i += access_size) {
> -            r |= access_fn(mr, addr + i, value, access_size,
> -                        (size - access_size - i) * 8, access_mask, attrs);
> -        }
> -    } else {
> -        for (i = 0; i < size; i += access_size) {
> -            r |= access_fn(mr, addr + i, value, access_size, i * 8,
> -                        access_mask, attrs);
> -        }
> +    start_diff = mr->ops->impl.unaligned ? 0 : addr & (access_size - 1);
> +    current_addr = addr - start_diff;
> +    for (current_offset = -start_diff; current_offset < (signed)size;
> +         current_offset += access_size, current_addr += access_size) {
> +        access_shift = is_big_endian
> +                          ? (signed)size - (signed)access_size - current_offset
> +                          : current_offset;
> +        access_mask_shift = current_offset > 0 ? 0 : -current_offset;
> +        access_mask_start_offset = current_offset > 0 ? current_offset : 0;
> +        access_mask_end_offset = current_offset + access_size > size
> +                                     ? size
> +                                     : current_offset + access_size;

Maybe this looks slightly easier to read?

        if (current_offset < 0) {
            access_mask_shift = -current_offset;
            access_mask_start_offset = 0;
        } else {
            access_mask_shift = 0;
            access_mask_start_offset = current_offset;
        }
        access_mask_end_offset = MIN(current_offset + access_size, size);

But I confess this can be pretty subjective..

Since PeterM used to comment, please remember to copy PeterM too in the
future post in case this got overlooked.

Peter, do you still have any other comments or concerns?

Thanks,

> +        access_mask = MAKE_64BIT_MASK(access_mask_shift * 8,
> +            (access_mask_end_offset - access_mask_start_offset) * 8);
> +
> +        r |= access_fn(mr, current_addr, value, access_size, access_shift * 8,
> +                       access_mask, attrs);
>      }
>      if (mr->dev && reentrancy_guard_applied) {
>          mr->dev->mem_reentrancy_guard.engaged_in_io = false;
> -- 
> 2.39.2
> 

-- 
Peter Xu


