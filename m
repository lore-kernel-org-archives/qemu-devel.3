Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF22C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 07:50:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQj8C-0007yh-J3; Mon, 08 Jul 2024 03:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sQj8A-0007vJ-C4; Mon, 08 Jul 2024 03:49:50 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sQj88-0004S7-85; Mon, 08 Jul 2024 03:49:49 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3d928b2843dso1004514b6e.2; 
 Mon, 08 Jul 2024 00:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720424986; x=1721029786; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t3yMGckD+X8FuCJBtnXeS3BYtSCfzcrsw75BRLEPeiU=;
 b=VAgarvqIH8oiZYJ8GK8/Nk4SMRgP8h9Brg1WsAELn0aHGmetTbHkLFu5eTi/UFBOMc
 rW8qcFPgjaQVhm/rcJvVzbTJEJRvEAJSYM3OPIPFO4DiOlsx6jXVu7CjsmYAh8C6lzMb
 H/opl8zaRUe1pCSpfCxwZ40OZRkN85ERmYfeOZ2JOHdJK7IWRrNAAlEIOHzeOBm3T2+v
 5JIuxf6kVJdsgySEtKc5XuIIQJH+oR+URT4dzDGU5FjqBY9m/BPZbn+XEqTjA5zte0Mq
 11DShAA/X2gKQPvX7ZeyjVM4JCBXWhTfwKbNFs/VhLphX7xgLfywyyIbttWdXK/ZYLa8
 Sdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720424986; x=1721029786;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=t3yMGckD+X8FuCJBtnXeS3BYtSCfzcrsw75BRLEPeiU=;
 b=uC/1THtbGs5lxLwP9FlwIOq+6zICY9bIocbtrtGDGcqMWasNpe3IeI84D4EqjlQ5cE
 ZeD0RGoC1FiS6bKZvgwW3xSHRedvoUz3/Fa4HxIubEgqKCBkBSGKKuEMoreT6sGVSrIf
 TH+3XmUPezK63s9vgeCS5/cK9pMtXgVvz+CBgw70Yx14avE3wWDwvr2Yzd/28lvlaBVl
 cpNz6cW/mchju6fDqFGgu9flT0LM3lD5lCxkglemZCjwmN+e2/JeGDUwdpfVkapYKYmh
 TyAv8fPE80DZi5NoRFxUE//sRtc94pzAiY+kOudH2Nop8ydmzcbCKNWV4mq8sCkoKNrP
 bMmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTmWXcCeL3iYkD30d9krnuDktIoDl1EmLOIsBTCEots4xlxCvr7A06nEL0zfCjlYXKvaOncIcV0kt0gA3eLTyXdseZd45R9ZLex5aAys+4t4GdSW0iE7PAkDsIAyrIzuX88cx1zXHFhsyneyuKO+PXXw==
X-Gm-Message-State: AOJu0YzJCFNTHgdCo1q5G25Or1bC7Usj/Qb5TFsLGgJTfhYps09C7dBk
 B2ANLlRoPY/SJhhib0mGvgrCYQ7hziYIf8nSJaWiA9jM5FmJi0cf
X-Google-Smtp-Source: AGHT+IHG+0f9V4Nfqv/0fpkIsAAy1JKv2ykXFuUwx45/WBzYWQCNkTI9/jdBsgOvsEgSlnilHdV+0g==
X-Received: by 2002:a05:6808:309b:b0:3d9:3463:4461 with SMTP id
 5614622812f47-3d9346349c5mr863086b6e.12.1720424986121; 
 Mon, 08 Jul 2024 00:49:46 -0700 (PDT)
Received: from localhost ([1.146.34.14]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-743148a5acfsm11736722a12.48.2024.07.08.00.49.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jul 2024 00:49:45 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Jul 2024 17:49:32 +1000
Message-Id: <D2JZR5EF6CF1.1DDFFT4TZAD1H@gmail.com>
Cc: "Akihiko Odaki" <akihiko.odaki@daynix.com>, "Eduardo Habkost"
 <eduardo@habkost.net>, "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Yanan Wang"
 <wangyanan55@huawei.com>, "John Snow" <jsnow@redhat.com>, "BALATON Zoltan"
 <balaton@eik.bme.hu>, "Jiaxun Yang" <jiaxun.yang@flygoat.com>, "Daniel
 Henrique Barboza" <danielhb413@gmail.com>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>, "Alexey Kardashevskiy" <aik@ozlabs.ru>, "Michael
 S. Tsirkin" <mst@redhat.com>, =?utf-8?q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Peter Xu" <peterx@redhat.com>, "Fabiano Rosas"
 <farosas@suse.de>, "Paolo Bonzini" <pbonzini@redhat.com>, "David
 Hildenbrand" <david@redhat.com>, "Thomas Huth" <thuth@redhat.com>, "Laurent
 Vivier" <lvivier@redhat.com>, <qemu-devel@nongnu.org>,
 <qemu-block@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: Re: [PATCH v2 06/15] ppc/vof: Fix unaligned FDT property access
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "David Gibson" <david@gibson.dropbear.id.au>, "Peter Maydell"
 <peter.maydell@linaro.org>
X-Mailer: aerc 0.17.0
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
 <20240627-san-v2-6-750bb0946dbd@daynix.com>
 <CAFEAcA-Zmc0BQgUiqEgzCvVGWyiPt9bo+Xt90n4wxhJ3_D91fA@mail.gmail.com>
 <Zn98p6CUV0KnIo50@zatzit>
 <CAFEAcA_LN8i66KUkxrgg=CUKJNYM=s9pTYv6w5QQ7PSU1Q3=bg@mail.gmail.com>
 <D2H7KBZF8OA4.3EKIA8NHHJ3MJ@gmail.com> <ZodPOTAcLo1XF4MB@zatzit>
 <D2HBUN5N504E.27WH86Z4HPTKW@gmail.com> <ZoeAutfGIAaNEFBC@zatzit>
 <CAFEAcA-QyGWNqS5saqGMc9f4WVS5mg8+YjUfOczovaT6duZAvQ@mail.gmail.com>
 <ZonXSmp9XZxl_HHp@zatzit>
In-Reply-To: <ZonXSmp9XZxl_HHp@zatzit>
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Sun Jul 7, 2024 at 9:46 AM AEST, David Gibson wrote:
> On Sat, Jul 06, 2024 at 11:37:08AM +0100, Peter Maydell wrote:
> > On Fri, 5 Jul 2024 at 06:13, David Gibson <david@gibson.dropbear.id.au>=
 wrote:
> > >
> > > On Fri, Jul 05, 2024 at 02:40:19PM +1000, Nicholas Piggin wrote:
> > > > On Fri Jul 5, 2024 at 11:41 AM AEST, David Gibson wrote:
> > > > > On Fri, Jul 05, 2024 at 11:18:47AM +1000, Nicholas Piggin wrote:
> > > > > > On Thu Jul 4, 2024 at 10:15 PM AEST, Peter Maydell wrote:
> > > > > > > On Sat, 29 Jun 2024 at 04:17, David Gibson <david@gibson.drop=
bear.id.au> wrote:
> > > > > > > >
> > > > > > > > On Fri, Jun 28, 2024 at 04:20:02PM +0100, Peter Maydell wro=
te:
> > > > > > > > > On Thu, 27 Jun 2024 at 14:39, Akihiko Odaki <akihiko.odak=
i@daynix.com> wrote:
> > > > > > > > > >
> > > > > > > > > > FDT properties are aligned by 4 bytes, not 8 bytes.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > > > > > > > > ---
> > > > > > > > > >  hw/ppc/vof.c | 2 +-
> > > > > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
> > > > > > > > > > index e3b430a81f4f..b5b6514d79fc 100644
> > > > > > > > > > --- a/hw/ppc/vof.c
> > > > > > > > > > +++ b/hw/ppc/vof.c
> > > > > > > > > > @@ -646,7 +646,7 @@ static void vof_dt_memory_available=
(void *fdt, GArray *claimed, uint64_t base)
> > > > > > > > > >      mem0_reg =3D fdt_getprop(fdt, offset, "reg", &prop=
len);
> > > > > > > > > >      g_assert(mem0_reg && proplen =3D=3D sizeof(uint32_=
t) * (ac + sc));
> > > > > > > > > >      if (sc =3D=3D 2) {
> > > > > > > > > > -        mem0_end =3D be64_to_cpu(*(uint64_t *)(mem0_re=
g + sizeof(uint32_t) * ac));
> > > > > > > > > > +        mem0_end =3D ldq_be_p(mem0_reg + sizeof(uint32=
_t) * ac);
> > > > > > > > > >      } else {
> > > > > > > > > >          mem0_end =3D be32_to_cpu(*(uint32_t *)(mem0_re=
g + sizeof(uint32_t) * ac));
> > > > > > > > > >      }
> > > > > > > > >
> > > > > > > > > I did wonder if there was a better way to do what this is=
 doing,
> > > > > > > > > but neither we (in system/device_tree.c) nor libfdt seem =
to
> > > > > > > > > provide one.
> > > > > > > >
> > > > > > > > libfdt does provide unaligned access helpers (fdt32_ld() et=
c.), but
> > > > > > > > not an automatic aligned-or-unaligned helper.   Maybe we sh=
ould add that?
> > > > > > >
> > > > > > > fdt32_ld() and friends only do the "load from this bit of mem=
ory"
> > > > > > > part, which we already have QEMU utility functions for (and w=
hich
> > > > > > > are this patch uses).
> > > > > > >
> > > > > > > This particular bit of code is dealing with an fdt property (=
"memory")
> > > > > > > that is an array of (address, size) tuples where address and =
size
> > > > > > > can independently be either 32 or 64 bits, and it wants the
> > > > > > > size value of tuple 0. So the missing functionality is someth=
ing at
> > > > > > > a higher level than fdt32_ld() which would let you say "give =
me
> > > > > > > tuple N field X" with some way to specify the tuple layout. (=
Which
> > > > > > > is an awkward kind of API to write in C.)
> > > > > > >
> > > > > > > Slightly less general, but for this case we could perhaps hav=
e
> > > > > > > something like the getprop equivalent of qemu_fdt_setprop_siz=
ed_cells():
> > > > > > >
> > > > > > >   uint64_t value_array[2];
> > > > > > >   qemu_fdt_getprop_sized_cells(fdt, nodename, "memory", &valu=
e_array,
> > > > > > >                                ac, sc);
> > > > > > >   /*
> > > > > > >    * fills in value_array[0] with address, value_array[1] wit=
h size,
> > > > > > >    * probably barfs if the varargs-list of cell-sizes doesn't
> > > > > > >    * cover the whole property, similar to the current assert =
on
> > > > > > >    * proplen.
> > > > > > >    */
> > > > > > >   mem0_end =3D value_array[0];
> > > > > >
> > > > > > Since 4/8 byte cells are most common and size is probably
> > > > > > normally known, what about something simpler to start with?
> > > > >
> > > > > Hrm, I don't think this helps much.  As Peter points out the actu=
al
> > > > > load isn't really the issue, it's locating the right spot for it.
> > > >
> > > > I don't really see why that's a problem, it's just a pointer
> > > > addition - base + fdt_address_cells * 4. The problem was in
> > >
> > > This is harder if #address-cells and #size-cells are different, or if
> > > you're parsing ranges and #address-cells is different between parent
> > > and child node.
> > >
> > > > the memory access (yes it's fixed with the patch but you could
> > > > add a general libfdt way to do it).
> > >
> > > Huh.. well I'm getting different impressions of what the problem
> > > actually is from what I initially read versus Peter Maydell's
> > > comments, so I don't really know what to think.
> > >
> > > If it's just the load then fdt32_ld() etc. already exist.  Or is it
> > > really such a hot path that unconditionally handling unaligned
> > > accesses isn't tenable?
> >=20
> > The specific problem here is that the code as written tries to
> > cast a not-aligned-enough pointer to uint64_t* to do the load,
> > which is UB.
>
> Ah... and I'm assuming it's the cast itself which triggers the UB, not
> just dereferencing it.

Oh it's just the cast itself that is UB? Looks like that's true.
Interesting gcc and clang don't flag it, I guess they care about
warning on practical breakage first.

> Which makes the interface of fdt32_ld()
> etc. unusable for their intended purpose.  Well.. damn.  Now... how do
> I fix it without breaking compatibility any more than I have to.

Why not just make them take a void * ptr? I don't think that would
break anything but existing code that was forced to add the cast
may be at risk of the UB.

Could also add fdt64_unaligned_t types with aligned(1) attribute
for new code. Those can just be dereferenced directly and the
caller the compiler can choose the appropriate access supported by
the host. (Actually gcc can recognise that load unaligned and
byteswap pattern and do the same anyway, but clang at least can
not yet).

Thanks,
Nick

