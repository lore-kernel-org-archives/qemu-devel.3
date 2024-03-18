Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27ADEC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 04:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm4in-0003Xd-QB; Mon, 18 Mar 2024 00:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1rm4iP-0003Vc-Eq
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 00:35:14 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1rm4iH-0003BS-MI
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 00:35:09 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a467d8efe78so370614466b.3
 for <qemu-devel@nongnu.org>; Sun, 17 Mar 2024 21:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1710736503; x=1711341303;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y96d3tpINZzGHkJOrUooqARs8TrxjT+BwmuHwGcMZdk=;
 b=HP/Rk0rqptLQnZp7PiS60SFDiQc1hJ53cW70ALLs+5KWg0KMJojwhiUakrBW/WaMLG
 Qu1OBLonNi/t3jVKCCylT/TqB+MOTMEjTQzFdFtk3v+Dhy5gbyT6VyUgsbM2+yzHhFz8
 63SvjyHtX3cwbDnlqY5N3PLoPLwXBtO/KU5/GBqkf9YPlP9G3tE7AFcCdADbKlEOxPhv
 kQfqDmnt0biLsbyGtY4/VWIcgkSBoGe/qIdJrljkG3ZfBM4CkAIjIMMBD+LD666VW/8W
 V+GGG//crmnuRqQ50PvTRc4KxG3Ecc29dgl8qaBU1qORjt3ZmYHWl9CSdgiMMo82qaAN
 pEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710736503; x=1711341303;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y96d3tpINZzGHkJOrUooqARs8TrxjT+BwmuHwGcMZdk=;
 b=HWcegyu+Um2BTvn5vMs3Qw4FE8D/e3XLMbgU8YiiRgF6F0eda8gNTCQ6PC2HMyZvBl
 bWy/Lsy4TSRQmxCXZPgn3GU3FR/VaQ8QMk7OTmXNIKM19nySESiJFtH8lTvUYfEatjqK
 X+XamlbA/ZaaId8ciLMr5zMfMWfIS8zDYphB1/W3ZEP2JlGnGAfGIF9dAG7t6Rh/nZo7
 vrcUUEND0B6GcVyZx/IltU7bsx3jM63rpqnWY4TmNg7bKVYQRI+WB+3/E8ZgyKeacVY6
 L9jNZQO7PBZG2gQ4HSEBFCBE47HkqfA5CYVTTWwJKFRVhxWMvMUISgrivA96yubcSvPR
 y74g==
X-Gm-Message-State: AOJu0YxbZG1umCoW3TmHDxWAR9xxk7IThCPmlDJsKQf0sUeOnmGClVMY
 pP6Ox2cV5pylM0BfwvzvOuYySAsV1l4J6wP34hSlG+9AfekJHNCae5uUoYZZeMsxdCftV9BnxU0
 HpwqZ+QoSGZLBv0wcEjswyVQRylJHp8da2CAQ9YVYa8lEV842
X-Google-Smtp-Source: AGHT+IHHdQAQ0N18txuwTkbpO/lTXtphxM+tDstK3voZatYyftKS3eEnXZ3+0hoeOT5LxxhJ6d/Vy/JNhRdF8sCwBuE=
X-Received: by 2002:a17:906:1958:b0:a46:bb98:c853 with SMTP id
 b24-20020a170906195800b00a46bb98c853mr1599660eje.63.1710736502341; Sun, 17
 Mar 2024 21:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240201081313.1339788-1-tomoyuki.hirose@igel.co.jp>
 <20240201081313.1339788-2-tomoyuki.hirose@igel.co.jp>
 <CAFS=Ecm+aY=pswdL4supc8v0NOGbdW7Mz80j1agLAqc3SQWJ4A@mail.gmail.com>
In-Reply-To: <CAFS=Ecm+aY=pswdL4supc8v0NOGbdW7Mz80j1agLAqc3SQWJ4A@mail.gmail.com>
From: Tomoyuki Hirose <tomoyuki.hirose@igel.co.jp>
Date: Mon, 18 Mar 2024 13:34:46 +0900
Message-ID: <CAFS=Ec=FWab6v2gy6+YJZzqKGcpvfEOdPR0NhijsciFehvKhiQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] system/memory.c: support unaligned access
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=tomoyuki.hirose@igel.co.jp; helo=mail-ej1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

ping.

On Mon, Feb 26, 2024 at 4:28=E2=80=AFPM Tomoyuki Hirose
<tomoyuki.hirose@igel.co.jp> wrote:
>
> Hello,
> I would be happy if you could give me some comments.
>
> ping.
>
> On Thu, Feb 1, 2024 at 5:14=E2=80=AFPM Tomoyuki HIROSE
> <tomoyuki.hirose@igel.co.jp> wrote:
> >
> > The previous code ignored 'impl.unaligned' and handled unaligned access=
es
> > as is. But this implementation cannot emulate specific registers of som=
e
> > devices that allow unaligned access such as xHCI Host Controller Capabi=
lity
> > Registers.
> > This commit checks 'impl.unaligned' and if it is false, QEMU emulates
> > unaligned access with multiple aligned access.
> >
> > Signed-off-by: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
> > ---
> >  system/memory.c | 38 +++++++++++++++++++++++++-------------
> >  1 file changed, 25 insertions(+), 13 deletions(-)
> >
> > diff --git a/system/memory.c b/system/memory.c
> > index a229a79988..a7ca0c9f54 100644
> > --- a/system/memory.c
> > +++ b/system/memory.c
> > @@ -535,10 +535,17 @@ static MemTxResult access_with_adjusted_size(hwad=
dr addr,
> >                                        MemTxAttrs attrs)
> >  {
> >      uint64_t access_mask;
> > +    unsigned access_mask_shift;
> > +    unsigned access_mask_start_offset;
> > +    unsigned access_mask_end_offset;
> >      unsigned access_size;
> > -    unsigned i;
> >      MemTxResult r =3D MEMTX_OK;
> >      bool reentrancy_guard_applied =3D false;
> > +    bool is_big_endian =3D memory_region_big_endian(mr);
> > +    signed start_diff;
> > +    signed current_offset;
> > +    signed access_shift;
> > +    hwaddr current_addr;
> >
> >      if (!access_size_min) {
> >          access_size_min =3D 1;
> > @@ -560,19 +567,24 @@ static MemTxResult access_with_adjusted_size(hwad=
dr addr,
> >          reentrancy_guard_applied =3D true;
> >      }
> >
> > -    /* FIXME: support unaligned access? */
> >      access_size =3D MAX(MIN(size, access_size_max), access_size_min);
> > -    access_mask =3D MAKE_64BIT_MASK(0, access_size * 8);
> > -    if (memory_region_big_endian(mr)) {
> > -        for (i =3D 0; i < size; i +=3D access_size) {
> > -            r |=3D access_fn(mr, addr + i, value, access_size,
> > -                        (size - access_size - i) * 8, access_mask, att=
rs);
> > -        }
> > -    } else {
> > -        for (i =3D 0; i < size; i +=3D access_size) {
> > -            r |=3D access_fn(mr, addr + i, value, access_size, i * 8,
> > -                        access_mask, attrs);
> > -        }
> > +    start_diff =3D mr->ops->impl.unaligned ? 0 : addr & (access_size -=
 1);
> > +    current_addr =3D addr - start_diff;
> > +    for (current_offset =3D -start_diff; current_offset < (signed)size=
;
> > +         current_offset +=3D access_size, current_addr +=3D access_siz=
e) {
> > +        access_shift =3D is_big_endian
> > +                          ? (signed)size - (signed)access_size - curre=
nt_offset
> > +                          : current_offset;
> > +        access_mask_shift =3D current_offset > 0 ? 0 : -current_offset=
;
> > +        access_mask_start_offset =3D current_offset > 0 ? current_offs=
et : 0;
> > +        access_mask_end_offset =3D current_offset + access_size > size
> > +                                     ? size
> > +                                     : current_offset + access_size;
> > +        access_mask =3D MAKE_64BIT_MASK(access_mask_shift * 8,
> > +            (access_mask_end_offset - access_mask_start_offset) * 8);
> > +
> > +        r |=3D access_fn(mr, current_addr, value, access_size, access_=
shift * 8,
> > +                       access_mask, attrs);
> >      }
> >      if (mr->dev && reentrancy_guard_applied) {
> >          mr->dev->mem_reentrancy_guard.engaged_in_io =3D false;
> > --
> > 2.39.2
> >

