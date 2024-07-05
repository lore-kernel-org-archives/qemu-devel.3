Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11885C30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 07:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPdiH-0006Wh-Jn; Fri, 05 Jul 2024 03:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPdiF-0006Vs-PU; Fri, 05 Jul 2024 03:50:35 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPdiD-0001ny-Uc; Fri, 05 Jul 2024 03:50:35 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-71884eda768so826680a12.1; 
 Fri, 05 Jul 2024 00:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720165831; x=1720770631; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MY8bhF0U0Adro05b1VbDAQUEpDRF9aukSPLeIwP4jL8=;
 b=AYTAnJK+tHMLj1Fiaoo0Hw3l2Uz/Qqn3h8VBF362N0sTKEfOs8LhzJIefDh1e2onXd
 kdAYLnSBei5zSAkrxZVNXykjkiMhZfWyaI0b/iMXbtVDKUfETy1iiKx5N6bJTk1qXTm5
 ex4k+Zab6Flm1RAD1TDMTlXv5ETORFGYbHB1fb4DPMpIVAVse0oIET1eVfgC8ZO2FjIt
 XUJO0LACcCSx9zWR4SkZJqdXSHCC15ry0uFcDtHM4sza4tU4+Ma6vTFEMcA58Ycy7RH3
 0APiyFu+tYOQJr6G81J2Z2ndLsSqZUbBCZX4Jjlz3QXInUBvcfCAqtcWGK+0rr9RPGnu
 nbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720165831; x=1720770631;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MY8bhF0U0Adro05b1VbDAQUEpDRF9aukSPLeIwP4jL8=;
 b=ZdyXmIDZ9oCSQS1nZAc6xPXufEH/nbrzY56vjrUDnDbn5eo7cM6AWO313A6ZE5Y5He
 Xixo6BZ6S7RXdzrbXzXwDF0DZaY5Kxof2B1CaCZMzEFbr1aJpxFLkGEMmKkX4BkhWUsF
 wPQCzp8h8poNNDx4GJamvEAZDnLTSVmZGRFWVzJyvwPDi21JJgYRbUNHIReE2Q+NODV9
 xsTIqXYqzlzF/bTlOvnscy/owjqofBppWA66SgtKJl28E7EZIbNVFK8q2VgCW1Cj7UB8
 PiF+kb10JLNGLDmgzi9od9m79no4xie5PUdjS83CLXSo9lWKb56H5lDOrGPhIDjAV26W
 DCXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD+P25+vV8RUcAxEWqCPTQIA3lBZgpXyEstHT3GmI3sQtbOKJ8R2AZ+D7o1AsrlFlRWu5uXdsuxRMK3ydFko2KoHNlW0iOI4kNgczjVn3Lpc34mbMDUZV+jDiHBcJYJsmlsKTb/Tu3aqlEvirSJ681oQ==
X-Gm-Message-State: AOJu0Yz+lLdYzYJCliTmnutx17QWH/yqjhhij8pi9fJjxvXh00k7dB3A
 dCWhvorwm+OscJv73P91xhi6P+hH4ykPEVwXlQsOAxWDgiGdOJnT
X-Google-Smtp-Source: AGHT+IEAAeRn3j2RhQE+wS5HhoNOmptKU2aSHpunMo1xUOHvMmP0CQ/UxqDQ0FQJ9W3XSG7qv6ZAoA==
X-Received: by 2002:a05:6a20:9185:b0:1be:2e11:ab28 with SMTP id
 adf61e73a8af0-1c0cc728cd8mr4024923637.5.1720165831288; 
 Fri, 05 Jul 2024 00:50:31 -0700 (PDT)
Received: from localhost ([1.146.70.66]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac1535e62sm134507865ad.154.2024.07.05.00.50.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jul 2024 00:50:29 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Jul 2024 17:50:17 +1000
Message-Id: <D2HFW32A8VYB.2PS3EWIXHS2UY@gmail.com>
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
 <D2HBUN5N504E.27WH86Z4HPTKW@gmail.com> <ZoeAutfGIAaNEFBC@zatzit>
In-Reply-To: <ZoeAutfGIAaNEFBC@zatzit>
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x534.google.com
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

On Fri Jul 5, 2024 at 3:12 PM AEST, David Gibson wrote:
> On Fri, Jul 05, 2024 at 02:40:19PM +1000, Nicholas Piggin wrote:
> > On Fri Jul 5, 2024 at 11:41 AM AEST, David Gibson wrote:
> > > On Fri, Jul 05, 2024 at 11:18:47AM +1000, Nicholas Piggin wrote:
> > > > On Thu Jul 4, 2024 at 10:15 PM AEST, Peter Maydell wrote:
> > > > > On Sat, 29 Jun 2024 at 04:17, David Gibson <david@gibson.dropbear=
.id.au> wrote:
> > > > > >
> > > > > > On Fri, Jun 28, 2024 at 04:20:02PM +0100, Peter Maydell wrote:
> > > > > > > On Thu, 27 Jun 2024 at 14:39, Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
> > > > > > > >
> > > > > > > > FDT properties are aligned by 4 bytes, not 8 bytes.
> > > > > > > >
> > > > > > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > > > > > > ---
> > > > > > > >  hw/ppc/vof.c | 2 +-
> > > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
> > > > > > > > index e3b430a81f4f..b5b6514d79fc 100644
> > > > > > > > --- a/hw/ppc/vof.c
> > > > > > > > +++ b/hw/ppc/vof.c
> > > > > > > > @@ -646,7 +646,7 @@ static void vof_dt_memory_available(voi=
d *fdt, GArray *claimed, uint64_t base)
> > > > > > > >      mem0_reg =3D fdt_getprop(fdt, offset, "reg", &proplen)=
;
> > > > > > > >      g_assert(mem0_reg && proplen =3D=3D sizeof(uint32_t) *=
 (ac + sc));
> > > > > > > >      if (sc =3D=3D 2) {
> > > > > > > > -        mem0_end =3D be64_to_cpu(*(uint64_t *)(mem0_reg + =
sizeof(uint32_t) * ac));
> > > > > > > > +        mem0_end =3D ldq_be_p(mem0_reg + sizeof(uint32_t) =
* ac);
> > > > > > > >      } else {
> > > > > > > >          mem0_end =3D be32_to_cpu(*(uint32_t *)(mem0_reg + =
sizeof(uint32_t) * ac));
> > > > > > > >      }
> > > > > > >
> > > > > > > I did wonder if there was a better way to do what this is doi=
ng,
> > > > > > > but neither we (in system/device_tree.c) nor libfdt seem to
> > > > > > > provide one.
> > > > > >
> > > > > > libfdt does provide unaligned access helpers (fdt32_ld() etc.),=
 but
> > > > > > not an automatic aligned-or-unaligned helper.   Maybe we should=
 add that?
> > > > >
> > > > > fdt32_ld() and friends only do the "load from this bit of memory"
> > > > > part, which we already have QEMU utility functions for (and which
> > > > > are this patch uses).
> > > > >
> > > > > This particular bit of code is dealing with an fdt property ("mem=
ory")
> > > > > that is an array of (address, size) tuples where address and size
> > > > > can independently be either 32 or 64 bits, and it wants the
> > > > > size value of tuple 0. So the missing functionality is something =
at
> > > > > a higher level than fdt32_ld() which would let you say "give me
> > > > > tuple N field X" with some way to specify the tuple layout. (Whic=
h
> > > > > is an awkward kind of API to write in C.)
> > > > >
> > > > > Slightly less general, but for this case we could perhaps have
> > > > > something like the getprop equivalent of qemu_fdt_setprop_sized_c=
ells():
> > > > >
> > > > >   uint64_t value_array[2];
> > > > >   qemu_fdt_getprop_sized_cells(fdt, nodename, "memory", &value_ar=
ray,
> > > > >                                ac, sc);
> > > > >   /*
> > > > >    * fills in value_array[0] with address, value_array[1] with si=
ze,
> > > > >    * probably barfs if the varargs-list of cell-sizes doesn't
> > > > >    * cover the whole property, similar to the current assert on
> > > > >    * proplen.
> > > > >    */
> > > > >   mem0_end =3D value_array[0];
> > > >=20
> > > > Since 4/8 byte cells are most common and size is probably
> > > > normally known, what about something simpler to start with?
> > >
> > > Hrm, I don't think this helps much.  As Peter points out the actual
> > > load isn't really the issue, it's locating the right spot for it.
> >=20
> > I don't really see why that's a problem, it's just a pointer
> > addition - base + fdt_address_cells * 4. The problem was in
>
> This is harder if #address-cells and #size-cells are different, or if
> you're parsing ranges and #address-cells is different between parent
> and child node.
>
> > the memory access (yes it's fixed with the patch but you could
> > add a general libfdt way to do it).
>
> Huh.. well I'm getting different impressions of what the problem
> actually is from what I initially read versus Peter Maydell's
> comments, so I don't really know what to think.

If I'm not mistaken, the sanitizer caught an unaligned 64-bit
load which is the bug.

The tuple address calculation itself I think is not buggy. I suppose
Peter was thinking of an accessor that takes care of addressing and
alignment. I don't think we're at the point it warrants it here, but
could be convinced (maybe a bunch of other code would use it).

I think the API is a little dangerous for overflows though, hard to
static check. sscanf() style could be checked by the compiler but
seems overkill to implement.

> If it's just the load then fdt32_ld() etc. already exist.  Or is it
> really such a hot path that unconditionally handling unaligned
> accesses isn't tenable?

Yeah that's true, hardly any point to adding the faster variant.

It could just be fixed like this then? The original patch is a
fix too, but I do prefer using the same style for both, and
I think using the fdt accessor is nicer to read.

Thanks,
Nick

---

diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
index e3b430a81f..a666a133d7 100644
--- a/hw/ppc/vof.c
+++ b/hw/ppc/vof.c
@@ -646,9 +646,9 @@ static void vof_dt_memory_available(void *fdt, GArray *=
claimed, uint64_t base)
     mem0_reg =3D fdt_getprop(fdt, offset, "reg", &proplen);
     g_assert(mem0_reg && proplen =3D=3D sizeof(uint32_t) * (ac + sc));
     if (sc =3D=3D 2) {
-        mem0_end =3D be64_to_cpu(*(uint64_t *)(mem0_reg + sizeof(uint32_t)=
 * ac));
+        mem0_end =3D fdt64_ld((fdt64_t *)(mem0_reg + sizeof(uint32_t) * ac=
));
     } else {
-        mem0_end =3D be32_to_cpu(*(uint32_t *)(mem0_reg + sizeof(uint32_t)=
 * ac));
+        mem0_end =3D fdt32_ld((fdt32_t *)(mem0_reg + sizeof(uint32_t) * ac=
));
     }

     g_array_sort(claimed, of_claimed_compare_func);


