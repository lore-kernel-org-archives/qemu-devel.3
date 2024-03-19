Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54B8C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 14:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmaBd-0008RW-8I; Tue, 19 Mar 2024 10:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmaAa-0007yg-Ca
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:10:29 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmaA6-0000yk-7S
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:10:14 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-566e869f631so6363284a12.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 07:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710857347; x=1711462147; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XxQvUt2uI2IhUP1FT7oId3U60tlbSgrIj/rYEOujcW8=;
 b=H5M4ISx5eGNOeGjq3xIvW8s+0MuqpY/h6CfXEVuwj1EtI8Z+LEZQB/bIbMNA5BhQ3A
 EBaklY7VtIpadMnCTMmGug3kAzlYpI7T8JNyHgjkfMswaLM/RFn2a+IPl/Kye+XQFgAr
 owVg4zbf7zUoGIGP0L5ErmmIX2XJqMJ6nbF0QC5NOYKsbZkuhtR2QSw2Xu8g0qdIZDhz
 T9CqPt1Kig4KnegCdUaCVoslXbemPzz4K9hAUh6xG0zfsbPKVGgr68Vael9StMqSZplm
 v9TCtSJ0FPcydetdNfYcvGrmXV5nDZRQ9HM4sccet6XCsAvxM+hOl//bfItsMwbGskmz
 KFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710857347; x=1711462147;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XxQvUt2uI2IhUP1FT7oId3U60tlbSgrIj/rYEOujcW8=;
 b=RtFyd4F5hhGmyChqCAH8zHezviK6LElakc9jcbClEZgpQJWHz22Bzo1BZZSc7b++AH
 2TbzGkMOZdvAeUPQgZLh1JmmVuF+BLeWS73Ns+7SkTwhysLUZLSds+2jJIy207u/t/vq
 AU+5I+3VhwIFehNLPtEwvC2Z3HR8vaQtkXIcYJNeUyw9pL7YqW9N3bomw5K+X1hW4F8T
 e6t1bj9RBgrgqK3lgIs8ZK0BsBw0urL0Cuf1OncWTKqjWXxf0JteJpHpKTKD9vxGRkei
 0VbuW/qElBUpXpUiMe3hwrf1/z0pjQjdh38fSLQtFPkP7eYh7pD3yVgbqAAAQmmsfgDI
 AabQ==
X-Gm-Message-State: AOJu0YxB0tTWJ22BPiZnKlq9fZ2jOUp3iguMrqxr9YAOXEVL5p3igE1f
 4ss7cW/6v60oEA3wQkWIpOXL1HGAnoeBb1F+85F1eNra7kq8/QZJ/Cb9IWIA0eTKUzhpjSWAlA/
 0VpEm/Xw8PtHuR1Fdw2WLB25zCILZDm06GBxv4w==
X-Google-Smtp-Source: AGHT+IEdYtzt/V/W39LlmbTi8RxkdvCW5TbR6RncsOsdWWNpqxXZhA+u3Q4rwXYpT3VSrQj9WsGj5IQHY1ka8JHWtHQ=
X-Received: by 2002:a05:6402:3645:b0:568:af3d:4a5f with SMTP id
 em5-20020a056402364500b00568af3d4a5fmr2640438edb.22.1710857347052; Tue, 19
 Mar 2024 07:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240201081313.1339788-1-tomoyuki.hirose@igel.co.jp>
 <20240201081313.1339788-2-tomoyuki.hirose@igel.co.jp>
In-Reply-To: <20240201081313.1339788-2-tomoyuki.hirose@igel.co.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Mar 2024 14:08:55 +0000
Message-ID: <CAFEAcA9Z8CbD2U9D0=DBrmRbV_OiVbeUUmTLdwRExhnS0HRnhQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] system/memory.c: support unaligned access
To: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, 1 Feb 2024 at 08:15, Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp> wrote:
>
> The previous code ignored 'impl.unaligned' and handled unaligned accesses
> as is. But this implementation cannot emulate specific registers of some
> devices that allow unaligned access such as xHCI Host Controller Capability
> Registers.
> This commit checks 'impl.unaligned' and if it is false, QEMU emulates
> unaligned access with multiple aligned access.
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

"signed foo" is a weird way to specify this type, which we use almost
nowhere else in the codebase -- this is equivalent to "int foo".

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

This still has a problem I noted for the v1 patch:
we compute the access_size without thinking about the alignment,
so for an access like:
 * addr = 2, size = 4, access_size_min = 2, access_size_max = 8
we will calculate access_size = 4 and do two 4-byte accesses
(at addresses 0 and 4) when we should do two 2-byte accesses
(at addresses 2 and 4).

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
> +        access_mask = MAKE_64BIT_MASK(access_mask_shift * 8,
> +            (access_mask_end_offset - access_mask_start_offset) * 8);

I don't understand here why the access_mask_shift and the
access_mask_start_offset are different. Aren't we trying to create
a mask value with 1s from start through to end ?

> +
> +        r |= access_fn(mr, current_addr, value, access_size, access_shift * 8,
> +                       access_mask, attrs);
>      }
>      if (mr->dev && reentrancy_guard_applied) {
>          mr->dev->mem_reentrancy_guard.engaged_in_io = false;

I agree with Philippe that we could be a lot more confident in
this change if we had some unit tests that tested whether
various combinations of unaligned accesses turned into the
right sequence of accesses to the underlying device.

thanks
-- PMM

