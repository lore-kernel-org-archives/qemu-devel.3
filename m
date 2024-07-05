Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113C9C30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 04:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPakV-0006wg-Q7; Fri, 05 Jul 2024 00:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPakR-0006ry-Jf; Fri, 05 Jul 2024 00:40:39 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPakM-0003T8-Nv; Fri, 05 Jul 2024 00:40:38 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-65465878c1fso276937b3.2; 
 Thu, 04 Jul 2024 21:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720154431; x=1720759231; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T82L/c5XETygIXcbVVnE8ZgZ4PysgILa/Ah7LG+aDkA=;
 b=VAPhE3GVvy+7fx/EdSyCE9tHVOPdTpFGHIKKvjHJxx3C8nbGk7uEeeCxHkvD6i8/aw
 X6CUBiJ7qfDHysC4iArkQxTP1F0/xFhO003ArOFk/CirlRJMO1vcF/NJD9MnUvzVYjJW
 5eVpvCzT3CkY0b1/0vOlNLhGRIBXOb77Rpnir/tuHJWLkHMIRLmKdgKxr7IG38q2hIBD
 qpTC12gZFls/JQfZp2z4CId6wz5Fxd42Lo+n8gmx0KBmaVOLPK/EYpxEtWrQKEZAL9DS
 iOd1PHIzm6obgGyhjYkJYjpL9ogbA4faovR1fu7miGGZnyPNT9K/bzcGEY0WPMwlmyky
 qtfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720154431; x=1720759231;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=T82L/c5XETygIXcbVVnE8ZgZ4PysgILa/Ah7LG+aDkA=;
 b=WxvqfCYJr//IcuosUph8mj5z1gCNlrAQcdX92+a++s0M1UWfLD67u0usjeIojKdu4d
 OMnS9Xf/+qyjGpE+UjMP9CUtF/qaDVUd4JxBHz1BLjqnwpGUEIizM2zAIkSH5Rp0Pji7
 MaUaoaGwJ3dtxrRNRhRC8uL+Pnq5qU3FJcGVc8axAprcyBTUx3Pdf36yuJQ21MP1UGHa
 /+I7G/ogK/FG/KnHjuUbcACuYtwFpExxYBfUMOVxfrBJx+zKNFBSx5AB956Ky4XqAOQD
 gNQ37JAD72Uec9fJPStricKu6/QhcSOrHsimvKB94SYXrKBXgoHWLWEk3IeuzvGGZjLn
 J0Mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMZrJt4tiM/VgDsgKuuk9ocV3CrZS2SrwIfQIRFM7HDpYP5eXARroQAJ/9G0INBeUQm/AEykIkrShAAiY4N2mDHtyFRcDzc0DxGjfqLeP339cHbfkfiC4zgwj0YgT8SAOOEW+Nios5hoiAzxP9r6mXog==
X-Gm-Message-State: AOJu0Yx4ArQ2jDPt6IQawoS6PTcVpuqoC8A2Wm8PWDZn0157MdWz/rv+
 KpRUb88BZ1dG6UPQujO6S18rBVafKh2FIA3reKYNs460BUVptDHs
X-Google-Smtp-Source: AGHT+IFmzlDZzeBd4mG2a3j1h9cq4Pj6UU8qG1LM3V28a2zDARRWNZnz/EouiRi0mTKP75eLa4TnHQ==
X-Received: by 2002:a05:690c:6b0e:b0:64a:4728:eed with SMTP id
 00721157ae682-652d803ad69mr41792697b3.46.1720154431089; 
 Thu, 04 Jul 2024 21:40:31 -0700 (PDT)
Received: from localhost (118-211-5-80.tpgi.com.au. [118.211.5.80])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7080256c9dcsm13025732b3a.74.2024.07.04.21.40.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 21:40:30 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Jul 2024 14:40:19 +1000
Message-Id: <D2HBUN5N504E.27WH86Z4HPTKW@gmail.com>
Cc: "Peter Maydell" <peter.maydell@linaro.org>, "Akihiko Odaki"
 <akihiko.odaki@daynix.com>, "Eduardo Habkost" <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
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
To: "David Gibson" <david@gibson.dropbear.id.au>
X-Mailer: aerc 0.17.0
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
 <20240627-san-v2-6-750bb0946dbd@daynix.com>
 <CAFEAcA-Zmc0BQgUiqEgzCvVGWyiPt9bo+Xt90n4wxhJ3_D91fA@mail.gmail.com>
 <Zn98p6CUV0KnIo50@zatzit>
 <CAFEAcA_LN8i66KUkxrgg=CUKJNYM=s9pTYv6w5QQ7PSU1Q3=bg@mail.gmail.com>
 <D2H7KBZF8OA4.3EKIA8NHHJ3MJ@gmail.com> <ZodPOTAcLo1XF4MB@zatzit>
In-Reply-To: <ZodPOTAcLo1XF4MB@zatzit>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=npiggin@gmail.com; helo=mail-yw1-x1129.google.com
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

On Fri Jul 5, 2024 at 11:41 AM AEST, David Gibson wrote:
> On Fri, Jul 05, 2024 at 11:18:47AM +1000, Nicholas Piggin wrote:
> > On Thu Jul 4, 2024 at 10:15 PM AEST, Peter Maydell wrote:
> > > On Sat, 29 Jun 2024 at 04:17, David Gibson <david@gibson.dropbear.id.=
au> wrote:
> > > >
> > > > On Fri, Jun 28, 2024 at 04:20:02PM +0100, Peter Maydell wrote:
> > > > > On Thu, 27 Jun 2024 at 14:39, Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
> > > > > >
> > > > > > FDT properties are aligned by 4 bytes, not 8 bytes.
> > > > > >
> > > > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > > > > ---
> > > > > >  hw/ppc/vof.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
> > > > > > index e3b430a81f4f..b5b6514d79fc 100644
> > > > > > --- a/hw/ppc/vof.c
> > > > > > +++ b/hw/ppc/vof.c
> > > > > > @@ -646,7 +646,7 @@ static void vof_dt_memory_available(void *f=
dt, GArray *claimed, uint64_t base)
> > > > > >      mem0_reg =3D fdt_getprop(fdt, offset, "reg", &proplen);
> > > > > >      g_assert(mem0_reg && proplen =3D=3D sizeof(uint32_t) * (ac=
 + sc));
> > > > > >      if (sc =3D=3D 2) {
> > > > > > -        mem0_end =3D be64_to_cpu(*(uint64_t *)(mem0_reg + size=
of(uint32_t) * ac));
> > > > > > +        mem0_end =3D ldq_be_p(mem0_reg + sizeof(uint32_t) * ac=
);
> > > > > >      } else {
> > > > > >          mem0_end =3D be32_to_cpu(*(uint32_t *)(mem0_reg + size=
of(uint32_t) * ac));
> > > > > >      }
> > > > >
> > > > > I did wonder if there was a better way to do what this is doing,
> > > > > but neither we (in system/device_tree.c) nor libfdt seem to
> > > > > provide one.
> > > >
> > > > libfdt does provide unaligned access helpers (fdt32_ld() etc.), but
> > > > not an automatic aligned-or-unaligned helper.   Maybe we should add=
 that?
> > >
> > > fdt32_ld() and friends only do the "load from this bit of memory"
> > > part, which we already have QEMU utility functions for (and which
> > > are this patch uses).
> > >
> > > This particular bit of code is dealing with an fdt property ("memory"=
)
> > > that is an array of (address, size) tuples where address and size
> > > can independently be either 32 or 64 bits, and it wants the
> > > size value of tuple 0. So the missing functionality is something at
> > > a higher level than fdt32_ld() which would let you say "give me
> > > tuple N field X" with some way to specify the tuple layout. (Which
> > > is an awkward kind of API to write in C.)
> > >
> > > Slightly less general, but for this case we could perhaps have
> > > something like the getprop equivalent of qemu_fdt_setprop_sized_cells=
():
> > >
> > >   uint64_t value_array[2];
> > >   qemu_fdt_getprop_sized_cells(fdt, nodename, "memory", &value_array,
> > >                                ac, sc);
> > >   /*
> > >    * fills in value_array[0] with address, value_array[1] with size,
> > >    * probably barfs if the varargs-list of cell-sizes doesn't
> > >    * cover the whole property, similar to the current assert on
> > >    * proplen.
> > >    */
> > >   mem0_end =3D value_array[0];
> >=20
> > Since 4/8 byte cells are most common and size is probably
> > normally known, what about something simpler to start with?
>
> Hrm, I don't think this helps much.  As Peter points out the actual
> load isn't really the issue, it's locating the right spot for it.

I don't really see why that's a problem, it's just a pointer
addition - base + fdt_address_cells * 4. The problem was in
the memory access (yes it's fixed with the patch but you could
add a general libfdt way to do it).

Some fancy function like above could be used, But is it really
worth implementing such a thing for this?

Thanks,
Nick

