Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9739C3271E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 12:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPLOY-0007yA-E0; Thu, 04 Jul 2024 08:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sPLNo-0007rm-TD
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 08:16:20 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sPLNj-0002Rp-81
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 08:16:16 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2ebe6495aedso5590661fa.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 05:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720095368; x=1720700168; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N68lwFl0nfpyW4wDEg4VIaNRRSkKW426BhVoyDd5Sxg=;
 b=g0FxUZSerB9gQjuidjlm2REvO0RgG4Dh+M8NkHNkWhAVox4yHW3muQbb9xXBF1VPBL
 ybcE+u0oBOm+xR5V4a5rJfUMop81ITM4L3hLY/7c7PXG5xgfXmDLvleR22hQtaSjDkKo
 lgxm9uEdE9y0Rmgn3Yr8boTnOdR638iOZvO9CCX6zx7hF2TYEYJgZ/zPHm8YZsaLBLXP
 vmzMKrdgPZhLi5av9yb+0bueSE9LKoiy0c8nw8TpwZ0Vrk7VIzr687EcWAdKCxtP5iTc
 JF7cvavaE2HHZWzk8qGw9c4K4H9/W9dTT+MCCml/kVa14MiBhahfWq7XKiSpb4BJaT3H
 6eiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720095368; x=1720700168;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N68lwFl0nfpyW4wDEg4VIaNRRSkKW426BhVoyDd5Sxg=;
 b=gd/lUPQKzG6U3D13H2xqa5Tbim7ZLzWnHmKtjJPg0HB1PCJpS3UULCbLc0tAWub4H4
 ojUPvzffs0ZHmN/KXDsBqntPCQpwBSnRpygvXVJ7ifCXlXndCuJfCftjyCAfeahngeUS
 LnWHeQRdOyeSp6j0bwVbe3JaA937oOUru+1DCcribdn4JxcIaLajFtF+yJxHV3OW6ENX
 XprWd+ZS/YKsdurof0SYP/d9/uu/+toJzoi06KlnnwFpmdPvIbn7rTaFNktzMglt06Hf
 W7L8FhYTiRUaHtRHGjbOHpsn086MevPQ0BJBAYarso2T2++YtUk+wSRYM0jHgtQzuPx9
 s30A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYHDqGgnijHlCysVmnLkYQzdPC78cjkYrvuURmyJXDm24f2shM41P9f/US0+FiWq+4Riln/2h+2tt8GinYa84PKwk1LsI=
X-Gm-Message-State: AOJu0YykPJyCqs25FRNYw8CUlNqHd342ZWDv47hq0O5PzC1TCh50M+zA
 TuODNGgPerTh5uwYU9pHZCosZmMElDeZEj2/rgRO+WQqzz1okPQHwLF9F+Wiv0/fnV7vVzUYzgE
 z+8wF5VT5VnvwV2sV/z/J54B+u5+p7/1L61SUvA==
X-Google-Smtp-Source: AGHT+IGpvoRhPHYw1R430AwkSGs8NzMqZYnIQNg7OZ/y9s9RwtAV5NC48d5dl6qLKcX1KZc2fA3lIbQM7cCFgIUlauI=
X-Received: by 2002:a19:5f5c:0:b0:52e:9ebe:7325 with SMTP id
 2adb3069b0e04-52ea065f06cmr1074378e87.31.1720095368378; Thu, 04 Jul 2024
 05:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
 <20240627-san-v2-6-750bb0946dbd@daynix.com>
 <CAFEAcA-Zmc0BQgUiqEgzCvVGWyiPt9bo+Xt90n4wxhJ3_D91fA@mail.gmail.com>
 <Zn98p6CUV0KnIo50@zatzit>
In-Reply-To: <Zn98p6CUV0KnIo50@zatzit>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jul 2024 13:15:57 +0100
Message-ID: <CAFEAcA_LN8i66KUkxrgg=CUKJNYM=s9pTYv6w5QQ7PSU1Q3=bg@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] ppc/vof: Fix unaligned FDT property access
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, 
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, 29 Jun 2024 at 04:17, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> On Fri, Jun 28, 2024 at 04:20:02PM +0100, Peter Maydell wrote:
> > On Thu, 27 Jun 2024 at 14:39, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> > >
> > > FDT properties are aligned by 4 bytes, not 8 bytes.
> > >
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > ---
> > >  hw/ppc/vof.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
> > > index e3b430a81f4f..b5b6514d79fc 100644
> > > --- a/hw/ppc/vof.c
> > > +++ b/hw/ppc/vof.c
> > > @@ -646,7 +646,7 @@ static void vof_dt_memory_available(void *fdt, GArray *claimed, uint64_t base)
> > >      mem0_reg = fdt_getprop(fdt, offset, "reg", &proplen);
> > >      g_assert(mem0_reg && proplen == sizeof(uint32_t) * (ac + sc));
> > >      if (sc == 2) {
> > > -        mem0_end = be64_to_cpu(*(uint64_t *)(mem0_reg + sizeof(uint32_t) * ac));
> > > +        mem0_end = ldq_be_p(mem0_reg + sizeof(uint32_t) * ac);
> > >      } else {
> > >          mem0_end = be32_to_cpu(*(uint32_t *)(mem0_reg + sizeof(uint32_t) * ac));
> > >      }
> >
> > I did wonder if there was a better way to do what this is doing,
> > but neither we (in system/device_tree.c) nor libfdt seem to
> > provide one.
>
> libfdt does provide unaligned access helpers (fdt32_ld() etc.), but
> not an automatic aligned-or-unaligned helper.   Maybe we should add that?

fdt32_ld() and friends only do the "load from this bit of memory"
part, which we already have QEMU utility functions for (and which
are this patch uses).

This particular bit of code is dealing with an fdt property ("memory")
that is an array of (address, size) tuples where address and size
can independently be either 32 or 64 bits, and it wants the
size value of tuple 0. So the missing functionality is something at
a higher level than fdt32_ld() which would let you say "give me
tuple N field X" with some way to specify the tuple layout. (Which
is an awkward kind of API to write in C.)

Slightly less general, but for this case we could perhaps have
something like the getprop equivalent of qemu_fdt_setprop_sized_cells():

  uint64_t value_array[2];
  qemu_fdt_getprop_sized_cells(fdt, nodename, "memory", &value_array,
                               ac, sc);
  /*
   * fills in value_array[0] with address, value_array[1] with size,
   * probably barfs if the varargs-list of cell-sizes doesn't
   * cover the whole property, similar to the current assert on
   * proplen.
   */
  mem0_end = value_array[0];

thanks
-- PMM

