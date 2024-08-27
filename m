Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED90CC54731
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 16:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sizQl-0000jt-3y; Tue, 27 Aug 2024 12:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1sizQj-0000im-IC; Tue, 27 Aug 2024 12:52:29 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1sizQh-0003c3-KH; Tue, 27 Aug 2024 12:52:29 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2700d796019so3876301fac.2; 
 Tue, 27 Aug 2024 09:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724777542; x=1725382342; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H4myQyZj4gtoBc2/mbmoj0Dh+cslxfOiDnGVSWXoPFs=;
 b=kUyckaNFmmmwKD74foFo7sN1cqh84E1BYbFvaPBFoiiW0Yvj1bx6xX0hgviK0pK3aq
 QRYQ/2p1+669xNxPPa+HUSc87RlXJsjJCofnx0LV8kVDhjg6NLohv9GZASvLQLAEVgMF
 FYkek75AEQjc0kPwzLcl9k+Tf4okTaBB2zQ5L/vbxFyHpPgpSU10IBGShJzt5RaqIqrj
 7W+GqZQMW10Dc/pfpTSmrurDrW68tDNRawvHUTjnzJr0BTLXo503a+IHscbH6WU2Awso
 W352qng5A9/L2H/uX1xo5NIfENK9qBSaHQCtLZY1j1pws0x2vcZPTfI3QR14y5ij9nRe
 +Nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724777542; x=1725382342;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H4myQyZj4gtoBc2/mbmoj0Dh+cslxfOiDnGVSWXoPFs=;
 b=UpofiWICb4f9czztD4A41cm7rkXFeQkq6Pp9aHhcFCI7QDdSUYh19nG6D2RhNpK2xt
 avqNnu/ZZdXvmzYUfWNLaNpbtTAvsHbsFkNbtXCANHtExQxg1QKevNLkW+9wiTB/3opD
 bRWQSIQviY7RbCPD3B7O2sh1TFIUV38yiFTwWPgH9ibB1+BgUBnD+3Q+XAa4Eh5a2+cd
 +jj4+iRBkO9AWiOlofvJ+lPuO337xlgofwvK2JirSy+aoNLpGSiT3CDTAm5FBaNOedI0
 sotnu4X1TKPwC97VAv7Pq2+2834Yrik3X3pXJDXRhs534hH3+xazY7L9hsmYRTZ0hW0W
 Nx1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXv2ojK7/JGikosFUlxFOyrUViSnPrKqAaN0bh1cQTf1SdA0W99+ET0Gkfki3jUB28sKbKq6US3V1j7PA==@nongnu.org
X-Gm-Message-State: AOJu0Ywtwt9Rklmkjm2aT04vWEYPEnyZixuQfattzE+AaOafJrs86YJl
 9r7u/hB0HoFNKBgOsWDLzZfLf9y1k4j36QpkU1qRzqevsljgNpE2oOwjPXY3skTTSIqUpjZJc0g
 ZT9aJg0CKWyMom8yWo2g3xsnnSqI=
X-Google-Smtp-Source: AGHT+IFbKBQuzOMdrasGoK+HafIdQT/oW5C71R//7F9jxrfXDtmZmEnNawHzbGzINTLoBZIbM+Gl0Ee88BWenxUFIrg=
X-Received: by 2002:a05:6871:3a13:b0:270:64ed:c125 with SMTP id
 586e51a60fabf-273e64feed5mr15451953fac.16.1724777541691; Tue, 27 Aug 2024
 09:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240827083715.257768-1-david@redhat.com>
In-Reply-To: <20240827083715.257768-1-david@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 27 Aug 2024 12:52:09 -0400
Message-ID: <CAJSP0QX+NiO7An468cKMFja3TGmgGzyNcPZjEtpPrfi3Q_1xgw@mail.gmail.com>
Subject: Re: [PATCH v1] softmmu/physmem: fix memory leak in
 dirty_memory_extend()
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-stable@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, 27 Aug 2024 at 04:38, David Hildenbrand <david@redhat.com> wrote:
>
> As reported by Peter, we might be leaking memory when removing the
> highest RAMBlock (in the weird ram_addr_t space), and adding a new one.
>
> We will fail to realize that we already allocated bitmaps for more
> dirty memory blocks, and effectively discard the pointers to them.
>
> Fix it by getting rid of last_ram_page() and simply storing the number
> of dirty memory blocks that have been allocated. We'll store the number
> of blocks along with the actual pointer to keep it simple.
>
> Looks like this leak was introduced as we switched from using a single
> bitmap_zero_extend() to allocating multiple bitmaps:
> bitmap_zero_extend() relies on g_renew() which should have taken care of
> this.
>
> Resolves: https://lkml.kernel.org/r/CAFEAcA-k7a+VObGAfCFNygQNfCKL=3DAfX6A=
4kScq=3DVSSK0peqPg@mail.gmail.com
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Fixes: 5b82b703b69a ("memory: RCU ram_list.dirty_memory[] for safe RAM ho=
tplug")
> Cc: qemu-stable@nongnu.org
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/exec/ramlist.h |  1 +
>  system/physmem.c       | 44 ++++++++++++++----------------------------
>  2 files changed, 16 insertions(+), 29 deletions(-)
>
> diff --git a/include/exec/ramlist.h b/include/exec/ramlist.h
> index 2ad2a81acc..f2a965f293 100644
> --- a/include/exec/ramlist.h
> +++ b/include/exec/ramlist.h
> @@ -41,6 +41,7 @@ typedef struct RAMBlockNotifier RAMBlockNotifier;
>  #define DIRTY_MEMORY_BLOCK_SIZE ((ram_addr_t)256 * 1024 * 8)
>  typedef struct {
>      struct rcu_head rcu;
> +    unsigned int num_blocks;

The maximum amount of memory supported by unsigned int is:
(2 ^ 32 - 1) * 4KB * DIRTY_MEMORY_BLOCK_SIZE
=3D ~32 exabytes

This should be fine. The maximum guest RAM sizes are in the TBs range
(source: https://access.redhat.com/articles/rhel-kvm-limits).

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

>      unsigned long *blocks[];
>  } DirtyMemoryBlocks;
>
> diff --git a/system/physmem.c b/system/physmem.c
> index 94600a33ec..fa48ff8333 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -1534,18 +1534,6 @@ static ram_addr_t find_ram_offset(ram_addr_t size)
>      return offset;
>  }
>
> -static unsigned long last_ram_page(void)
> -{
> -    RAMBlock *block;
> -    ram_addr_t last =3D 0;
> -
> -    RCU_READ_LOCK_GUARD();
> -    RAMBLOCK_FOREACH(block) {
> -        last =3D MAX(last, block->offset + block->max_length);
> -    }
> -    return last >> TARGET_PAGE_BITS;
> -}
> -
>  static void qemu_ram_setup_dump(void *addr, ram_addr_t size)
>  {
>      int ret;
> @@ -1799,28 +1787,31 @@ void qemu_ram_msync(RAMBlock *block, ram_addr_t s=
tart, ram_addr_t length)
>  }
>
>  /* Called with ram_list.mutex held */
> -static void dirty_memory_extend(ram_addr_t old_ram_size,
> -                                ram_addr_t new_ram_size)
> +static void dirty_memory_extend(ram_addr_t new_ram_size)
>  {
> -    ram_addr_t old_num_blocks =3D DIV_ROUND_UP(old_ram_size,
> -                                             DIRTY_MEMORY_BLOCK_SIZE);
>      ram_addr_t new_num_blocks =3D DIV_ROUND_UP(new_ram_size,
>                                               DIRTY_MEMORY_BLOCK_SIZE);
>      int i;
>
> -    /* Only need to extend if block count increased */
> -    if (new_num_blocks <=3D old_num_blocks) {
> -        return;
> -    }
> -
>      for (i =3D 0; i < DIRTY_MEMORY_NUM; i++) {
>          DirtyMemoryBlocks *old_blocks;
>          DirtyMemoryBlocks *new_blocks;
> +        ram_addr_t old_num_blocks =3D 0;
>          int j;
>
>          old_blocks =3D qatomic_rcu_read(&ram_list.dirty_memory[i]);
> +        if (old_blocks) {
> +            old_num_blocks =3D old_blocks->num_blocks;
> +
> +            /* Only need to extend if block count increased */
> +            if (new_num_blocks <=3D old_num_blocks) {
> +                return;
> +            }
> +        }
> +
>          new_blocks =3D g_malloc(sizeof(*new_blocks) +
>                                sizeof(new_blocks->blocks[0]) * new_num_bl=
ocks);
> +        new_blocks->num_blocks =3D new_num_blocks;
>
>          if (old_num_blocks) {
>              memcpy(new_blocks->blocks, old_blocks->blocks,
> @@ -1846,11 +1837,9 @@ static void ram_block_add(RAMBlock *new_block, Err=
or **errp)
>      RAMBlock *block;
>      RAMBlock *last_block =3D NULL;
>      bool free_on_error =3D false;
> -    ram_addr_t old_ram_size, new_ram_size;
> +    ram_addr_t ram_size;
>      Error *err =3D NULL;
>
> -    old_ram_size =3D last_ram_page();
> -
>      qemu_mutex_lock_ramlist();
>      new_block->offset =3D find_ram_offset(new_block->max_length);
>
> @@ -1901,11 +1890,8 @@ static void ram_block_add(RAMBlock *new_block, Err=
or **errp)
>          }
>      }
>
> -    new_ram_size =3D MAX(old_ram_size,
> -              (new_block->offset + new_block->max_length) >> TARGET_PAGE=
_BITS);
> -    if (new_ram_size > old_ram_size) {
> -        dirty_memory_extend(old_ram_size, new_ram_size);
> -    }
> +    ram_size =3D (new_block->offset + new_block->max_length) >> TARGET_P=
AGE_BITS;
> +    dirty_memory_extend(ram_size);
>      /* Keep the list sorted from biggest to smallest block.  Unlike QTAI=
LQ,
>       * QLIST (which has an RCU-friendly variant) does not have insertion=
 at
>       * tail, so save the last element in last_block.
> --
> 2.46.0
>
>

