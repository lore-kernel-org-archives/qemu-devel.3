Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDCFC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 11:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPL2d-0004qn-V1; Thu, 04 Jul 2024 07:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPL2c-0004qT-Rk; Thu, 04 Jul 2024 07:54:22 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPL2a-0005W6-RP; Thu, 04 Jul 2024 07:54:22 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-70699b6afddso385573b3a.1; 
 Thu, 04 Jul 2024 04:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720094058; x=1720698858; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ViFTZGz7b69e2OkFljgAsDm2Eyk0LA+22Hzj+AsoPlc=;
 b=MM/MtRrzVnuTDFrdcPNUpKZXtNvpWYd74Y/OItNpVuLfMv5kgpYZRUfvORoZBHML5Q
 G0yGeBKqnr1ADAG3TqXZvqzK76Rz9/TurtBeGMpQru5aD4EIanDTNAywAqFbzG0490VG
 N28YKoUSfpS6i7WOq01ii9XaQFo/wWFxDBlwOAEgz1I3g2pLZTKgV8V4EgoUUJpId/z1
 j1gr3KZ/nF6QnF425IY8grjc4pu4cuf8COyCz4kk0rrr//ItMUqDwDS0s78N//WpgVFk
 k667OfSB0aALCUmurxjBB/PFDZiB9Hn9pOQ4I/U32j8XUlQjRy2UcoD1cfvkeF7RMKE+
 GT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720094058; x=1720698858;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ViFTZGz7b69e2OkFljgAsDm2Eyk0LA+22Hzj+AsoPlc=;
 b=Im+R50+wOIqRgZ32jSsY/xtdKN896Jx2D8wBSxgywjIXKp5QB0wJKKlbj4VcBDS6WT
 TGpjbrPR0Kx5s3IoUvwPujHnP7UurqUYQ2j2TMeg8YfrZLVvUjAcHGtcT2X1zQ7o4Rtb
 rB6KfvTJa33wLnRgWBp1HeQuIFxh08DicPz7UO7QD+ZBYUDS1usk/2A3twIV0vfe9kNU
 Oo3/5TK5/pnD5LX2cqg9pEIZt4epEQ1dTgJnX3wXT867ZYgzKeCj+sBYc7qz3w2bjcZf
 XY3V4JDsiSe0UPDpBdrstB/p2pzp+/8iafjchEQ7BJPxDl5nERVylLFWWLrB+4KnRiFR
 YbxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJctOo9dkQ8dAJLCiiqxwgg1748nZJD9u1cjEDiAuv5qtPcLNgsIII3DwKqcGGXz4ofZUabzU/zKCchwJCWR6Ovc3XOu3pE7fCR99LScgGxwaEugG4srFULbw1VNDy/MYUXIDR7u8FNRGrs1ewbQZ8Lg==
X-Gm-Message-State: AOJu0Yye2TmCcgYXql+MRqePjQPxIvrTzERKKnIa83g3O2L2O0dSklFr
 2NRC9lznGnD89v3Xz5O7v2TVtFP9R71nGXE5d6qvd7aQvKAco+Lq
X-Google-Smtp-Source: AGHT+IGUnv9nENtwVvIWQfXl41NimERvUIA1EFGuqd5e3ncM9lBoCt4bFYYuTX9xBTs4ctWQhvkLKg==
X-Received: by 2002:a05:6a00:2d0c:b0:70b:2a:15cd with SMTP id
 d2e1a72fcca58-70b007e5689mr1638876b3a.0.1720094057904; 
 Thu, 04 Jul 2024 04:54:17 -0700 (PDT)
Received: from localhost (118-211-5-80.tpgi.com.au. [118.211.5.80])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-708044adb98sm12432735b3a.172.2024.07.04.04.54.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 04:54:17 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 21:54:06 +1000
Message-Id: <D2GQG8AHHSZT.7SJ9JCS11EVN@gmail.com>
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
In-Reply-To: <Zn98p6CUV0KnIo50@zatzit>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
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

On Sat Jun 29, 2024 at 1:16 PM AEST, David Gibson wrote:
> On Fri, Jun 28, 2024 at 04:20:02PM +0100, Peter Maydell wrote:
> > On Thu, 27 Jun 2024 at 14:39, Akihiko Odaki <akihiko.odaki@daynix.com> =
wrote:
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
> > > @@ -646,7 +646,7 @@ static void vof_dt_memory_available(void *fdt, GA=
rray *claimed, uint64_t base)
> > >      mem0_reg =3D fdt_getprop(fdt, offset, "reg", &proplen);
> > >      g_assert(mem0_reg && proplen =3D=3D sizeof(uint32_t) * (ac + sc)=
);
> > >      if (sc =3D=3D 2) {
> > > -        mem0_end =3D be64_to_cpu(*(uint64_t *)(mem0_reg + sizeof(uin=
t32_t) * ac));
> > > +        mem0_end =3D ldq_be_p(mem0_reg + sizeof(uint32_t) * ac);
> > >      } else {
> > >          mem0_end =3D be32_to_cpu(*(uint32_t *)(mem0_reg + sizeof(uin=
t32_t) * ac));
> > >      }
> >=20
> > I did wonder if there was a better way to do what this is doing,
> > but neither we (in system/device_tree.c) nor libfdt seem to
> > provide one.
>
> libfdt does provide unaligned access helpers (fdt32_ld() etc.), but
> not an automatic aligned-or-unaligned helper.   Maybe we should add that?

Runtime test if the pointer is aligned?

What about just fdt_prop32_ld() and fdt_prop64_ld() where you know it's
4 byte aligned. Then just do 2 x 4 byte loads for the 64-bit, I don't
think performance would matter so much to try get a single load.

Thanks,
Nick

