Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4BEC30653
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 01:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPXbL-0005LG-0r; Thu, 04 Jul 2024 21:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPXbJ-0005Ko-RC; Thu, 04 Jul 2024 21:19:01 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPXbI-0005E4-6B; Thu, 04 Jul 2024 21:19:01 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6f8d0a1e500so930063a34.3; 
 Thu, 04 Jul 2024 18:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720142338; x=1720747138; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m2xzOB0tt0912O1JvA/c1h3IsL2c4DnXn1uEtJDI2ME=;
 b=c27Q8+DVB7h2loBe3g05JyjhCWhAL8KadfKLYRHgAk6c7KEH7i3QYYtq1koWLOCjbk
 dxUHQFIZNfZP5ROhAA0T1dMJ5lXEyjEm1PF+H6V2EayuZAh0a7ZzSjWKx9+Ou2tFWuXp
 rx7VXPb8VRm5IeX7vs4PDixMJzg4CEBsg/37LstWZ1GVwAwN9WDxt84APDaCEq1ys4Yu
 RzlmBbxx0YMGm38GE7sOcwXMsmn7g3gQ2xbU17oTWVUyudidBBLcaM4F+BHJWldf8NfC
 5B5q7w2s6EEJLzEfwGrQN8VgS4CSwGo9jHXbUZeS/QZO/eH1zGTJzjPyMn1lKKw82sjA
 Pxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720142338; x=1720747138;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=m2xzOB0tt0912O1JvA/c1h3IsL2c4DnXn1uEtJDI2ME=;
 b=VpKtc4symyrln4CoD6LDzO1WcioKW2mgS8X98Z09/cHAHXni+0QPjJC+k9KlbL9Ac6
 6vHvMNrRXFh2W3xXnYVNqtqSAHFZ6ysYXgxB8us+VAhRbMmUXIbHRzRSY0VONfeLeKUL
 3mWbTyLrWhyTES/l1lZKrN63otJ2eu5d1Sx8rUhp1CgQNJNhcPzt7vvNrTZv7r1TkBeS
 VqaHvOCuEPHQOJaHPvxSGODvCnh+zM0nEKDkKg4LbRuV7sf9AkOjXyb3L9sSuoTd14y2
 ciRiMkmrpL3IVCJ7GmvlwGH35WurVd7ZAJ7p2sA1lhPLfvCQFXy9nJNkbDr0maDhlASD
 UnCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAwI5tapR//fXhOppP1t6TgybehGj+dAQtsksnEkcRmt3bFnOYOfISjftjkiAgPEPbNQfdMLhVPrgEZs31Q+iCW0AMlQwyNcxHsF7O6KLNRFxrv/wB+pxEbXVH9m8nkfO861hs0+M4g/vXoj0kjpK0wQ==
X-Gm-Message-State: AOJu0YwH41wv8rOz8Hu6XsAPW1agbsE9FPDlfWmc2RQ2FTKkOnyVEUEq
 KxNv94cHZ1QQRaqxECsO5PWbwXtCmDtZYKHXvP4k0AKO2xjDLcHf
X-Google-Smtp-Source: AGHT+IHls/lORG9/bWY/tBInAhs9ggoXUNtNNmnqVC1ixv/CIRWwpW3r8LOk8NeRs92q0RYaU1Uu+g==
X-Received: by 2002:a05:6870:2114:b0:25e:1817:e4b7 with SMTP id
 586e51a60fabf-25e2bea66b7mr2810872fac.38.1720142338000; 
 Thu, 04 Jul 2024 18:18:58 -0700 (PDT)
Received: from localhost (118-211-5-80.tpgi.com.au. [118.211.5.80])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70affc80913sm1950936b3a.69.2024.07.04.18.18.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 18:18:57 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Jul 2024 11:18:47 +1000
Message-Id: <D2H7KBZF8OA4.3EKIA8NHHJ3MJ@gmail.com>
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
To: "Peter Maydell" <peter.maydell@linaro.org>, "David Gibson"
 <david@gibson.dropbear.id.au>
X-Mailer: aerc 0.17.0
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
 <20240627-san-v2-6-750bb0946dbd@daynix.com>
 <CAFEAcA-Zmc0BQgUiqEgzCvVGWyiPt9bo+Xt90n4wxhJ3_D91fA@mail.gmail.com>
 <Zn98p6CUV0KnIo50@zatzit>
 <CAFEAcA_LN8i66KUkxrgg=CUKJNYM=s9pTYv6w5QQ7PSU1Q3=bg@mail.gmail.com>
In-Reply-To: <CAFEAcA_LN8i66KUkxrgg=CUKJNYM=s9pTYv6w5QQ7PSU1Q3=bg@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=npiggin@gmail.com; helo=mail-ot1-x329.google.com
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

On Thu Jul 4, 2024 at 10:15 PM AEST, Peter Maydell wrote:
> On Sat, 29 Jun 2024 at 04:17, David Gibson <david@gibson.dropbear.id.au> =
wrote:
> >
> > On Fri, Jun 28, 2024 at 04:20:02PM +0100, Peter Maydell wrote:
> > > On Thu, 27 Jun 2024 at 14:39, Akihiko Odaki <akihiko.odaki@daynix.com=
> wrote:
> > > >
> > > > FDT properties are aligned by 4 bytes, not 8 bytes.
> > > >
> > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > > ---
> > > >  hw/ppc/vof.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
> > > > index e3b430a81f4f..b5b6514d79fc 100644
> > > > --- a/hw/ppc/vof.c
> > > > +++ b/hw/ppc/vof.c
> > > > @@ -646,7 +646,7 @@ static void vof_dt_memory_available(void *fdt, =
GArray *claimed, uint64_t base)
> > > >      mem0_reg =3D fdt_getprop(fdt, offset, "reg", &proplen);
> > > >      g_assert(mem0_reg && proplen =3D=3D sizeof(uint32_t) * (ac + s=
c));
> > > >      if (sc =3D=3D 2) {
> > > > -        mem0_end =3D be64_to_cpu(*(uint64_t *)(mem0_reg + sizeof(u=
int32_t) * ac));
> > > > +        mem0_end =3D ldq_be_p(mem0_reg + sizeof(uint32_t) * ac);
> > > >      } else {
> > > >          mem0_end =3D be32_to_cpu(*(uint32_t *)(mem0_reg + sizeof(u=
int32_t) * ac));
> > > >      }
> > >
> > > I did wonder if there was a better way to do what this is doing,
> > > but neither we (in system/device_tree.c) nor libfdt seem to
> > > provide one.
> >
> > libfdt does provide unaligned access helpers (fdt32_ld() etc.), but
> > not an automatic aligned-or-unaligned helper.   Maybe we should add tha=
t?
>
> fdt32_ld() and friends only do the "load from this bit of memory"
> part, which we already have QEMU utility functions for (and which
> are this patch uses).
>
> This particular bit of code is dealing with an fdt property ("memory")
> that is an array of (address, size) tuples where address and size
> can independently be either 32 or 64 bits, and it wants the
> size value of tuple 0. So the missing functionality is something at
> a higher level than fdt32_ld() which would let you say "give me
> tuple N field X" with some way to specify the tuple layout. (Which
> is an awkward kind of API to write in C.)
>
> Slightly less general, but for this case we could perhaps have
> something like the getprop equivalent of qemu_fdt_setprop_sized_cells():
>
>   uint64_t value_array[2];
>   qemu_fdt_getprop_sized_cells(fdt, nodename, "memory", &value_array,
>                                ac, sc);
>   /*
>    * fills in value_array[0] with address, value_array[1] with size,
>    * probably barfs if the varargs-list of cell-sizes doesn't
>    * cover the whole property, similar to the current assert on
>    * proplen.
>    */
>   mem0_end =3D value_array[0];

Since 4/8 byte cells are most common and size is probably
normally known, what about something simpler to start with?

Thanks,
Nick

---
diff --git a/libfdt/libfdt.h b/libfdt/libfdt.h
index 0677fea..c4b6355 100644
--- a/libfdt/libfdt.h
+++ b/libfdt/libfdt.h
@@ -148,6 +148,15 @@ static inline uint32_t fdt32_ld(const fdt32_t *p)
 		| bp[3];
 }
=20
+/*
+ * Load the value from a 32-bit cell of a property. Cells are 32-bit align=
ed
+ * so can use a single load.
+ */
+static inline uint32_t fdt32_ld_prop(const fdt32_t *p)
+{
+	return fdt32_to_cpu(*p);
+}
+
 static inline void fdt32_st(void *property, uint32_t value)
 {
 	uint8_t *bp =3D (uint8_t *)property;
@@ -172,6 +181,18 @@ static inline uint64_t fdt64_ld(const fdt64_t *p)
 		| bp[7];
 }
=20
+/*
+ * Load the value from a 64-bit cell of a property. Cells are 32-bit align=
ed
+ * so can use two loads.
+ */
+static inline uint64_t fdt64_ld_prop(const fdt64_t *p)
+{
+	const fdt64_t *_p =3D p;
+
+	return ((uint64_t)fdt32_to_cpu(_p[0]) << 32)
+		| fdt32_to_cpu(_p[1]);
+}
+
 static inline void fdt64_st(void *property, uint64_t value)
 {
 	uint8_t *bp =3D (uint8_t *)property;

