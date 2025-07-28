Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7398C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 10:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugKhq-00020s-Am; Mon, 28 Jul 2025 06:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ugKeD-0007V1-65; Mon, 28 Jul 2025 05:59:59 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ugKeA-0007NH-Sc; Mon, 28 Jul 2025 05:59:56 -0400
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4ab71ac933eso38459521cf.2; 
 Mon, 28 Jul 2025 02:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753696792; x=1754301592; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xk82SjWl+aL5BTTSW39BtMph2wo/nhX1oBoFTzdyBaM=;
 b=ADt5UiwwHu+6AJkFthERLMX8fs/1lgyTi1q+QdO+xXnnPtrqp1qFVqEZn1pLBoOreQ
 Z0Yyj3mNobgbNi/4Ir0TvAXe/d9KJ2FUUV6DiXRN1G8/tUiJNbdzEIUNPrl3nAkM/3Mr
 QuJcmY7B3zvnRZCmPjqkbv7Vh4rUHJWiATTmKoAS9zUHwQiGSFHfEcwpSL2ZJmOpxOZ0
 uECZg/8j6kWhJeWA9yn7Pe3yuM6d9MSkF4Yottsxn3bQGw1+VT09UvEfjQDUZnw7G0V4
 zzycaw4ukdmoL6RbP+Uss4emXX4FNrASF2HDVgLOwN3rSu9pCM716EMJixtlmhWxFFoG
 b4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753696792; x=1754301592;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xk82SjWl+aL5BTTSW39BtMph2wo/nhX1oBoFTzdyBaM=;
 b=sOV/tZa2qZQTmefNs/MufgnWk5PHzFTP3JH5RA2S/UjW7Fr4MZ0HGSKuq88oP4pp3F
 m74pOus8cV11adpaTpYJZdxvrQUiE1C4ZHPSGWIrb0V/Hh8X+ymmkmA3mHpzogiYEEfN
 UEKZDqOQsoSZoNpIJQBV3HhUOrNEb2BxCfXFutg7PN5HQo/yBx6cs8Ava3rWz5faMH6k
 +iiJgQQMeYzx9eJryN19bWE7i7SMoCiiBBbY6o9Hs34QYt0zuVXu+FnASGHcnQ6GCDQD
 C6n3m/wre28gMrY7dXrDiA73rgc2XLWaxlarTyXcJt/af8GFeZ7Swk/C7pD69jedueaz
 eEDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsTv0tC7tmaT9lhXEzFPUbZ5uWxv0g17xEBC47pNb8bwfKvayVw6J+q0tz7yb6kDaKe0kH4CeJZu4=@nongnu.org,
 AJvYcCW9Fofot7tcIp7/X9/h8346jiG54tbm0LKpbsi1A3sQJNvlRGoszW+zdrg8KhHPbVkO7tR0Cva8+9VqwQ==@nongnu.org,
 AJvYcCW9jEdidmrTnlywrHBnO6kLhxxFy47Vi8htbIj3AnHpx8I0EfODuOSg5NZ9zyP630QXoCQuZS4L1cmj@nongnu.org
X-Gm-Message-State: AOJu0YypHx2otyYIlr77SztfvgtpGXH6RmKDfeEKChNnv4bl/t5Li/Dx
 qMOVFeOjIBYiSn4V2d3wa9s5ER+iW/3wNGbJYhV+5JqyMxdQ7WMtOAq2NGgbykxHEQlS4k/+E3u
 iT3o1u8C26at7Vtoq0iQzJzdIpu209Q26PY4U+sfaIQ==
X-Gm-Gg: ASbGncsxe/YrM0yOUKBo94bzYo8qY2vdesOI7yRs/HY2QIDuv05n9WnMBhHewoon2da
 1zYDwH5P5oJL5OwuppXLDIqIrJHdIWZLaOI5D3e9vqyXlTCiQ0ue5+nKp2GTJCsFVtEp+toebPM
 ls64bk5cwplAywR0SiVQq/nmelLE2v7wEa49Z5v0Tx7pNEir9whP8rOTSMEougziW1YpYqEMh7I
 65GULkGBTA+BnIQapnfNyaPnYWR/MxAPs6nt84f
X-Google-Smtp-Source: AGHT+IFnWtJnKoxJBfD+WJjn4QJVC6rqrB9CmFs9uxp2HFk0z+5AuID3hseErhVwsl9tMHbyS2RF6AQPZzk0xogFQ5M=
X-Received: by 2002:a05:622a:1301:b0:4a9:b186:9443 with SMTP id
 d75a77b69052e-4ae8efb50b0mr168103071cf.21.1753696792062; Mon, 28 Jul 2025
 02:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
 <20250725-propagate_tpm_error-v7-1-d52704443975@redhat.com>
 <CAMxuvaznYbcpxc7dtDP5yVBzVcDJpVWVXHeWxB1zo0bfdBuw2g@mail.gmail.com>
 <CAMxuvawsX6ePZV=ek7d0rDwpJYQJmNwiFKhTetLW6u1PW6cTbA@mail.gmail.com>
 <aIc8fjnoA_G8iCqZ@redhat.com>
In-Reply-To: <aIc8fjnoA_G8iCqZ@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 28 Jul 2025 13:59:40 +0400
X-Gm-Features: Ac12FXzAXJ5Mq17GQkD6PTgXRdqBrii1EEOr_cyKo-IwUyb2tWTImIKwzE-HBrk
Message-ID: <CAJ+F1CK1_zVY-az5XF+ds+82Vq=3hi-_yLf4nw4obtPSySwqow@mail.gmail.com>
Subject: Re: [PATCH v7 01/24] migration: push Error **errp into
 vmstate_subsection_load()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, 
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82d.google.com
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

Hi

On Mon, Jul 28, 2025 at 1:06=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Mon, Jul 28, 2025 at 12:44:53PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Fri, Jul 25, 2025 at 5:46=E2=80=AFPM Marc-Andr=C3=A9 Lureau <
> > marcandre.lureau@redhat.com> wrote:
> >
> > >
> > >
> > > On Fri, Jul 25, 2025 at 4:19=E2=80=AFPM Arun Menon <armenon@redhat.co=
m> wrote:
> > >
> > >> This is an incremental step in converting vmstate loading
> > >> code to report error via Error objects instead of directly
> > >> printing it to console/monitor.
> > >> It is ensured that vmstate_subsection_load() must report an error
> > >> in errp, in case of failure.
> > >>
> > >> Signed-off-by: Arun Menon <armenon@redhat.com>
> > >> ---
> > >>  migration/vmstate.c | 11 ++++++++---
> > >>  1 file changed, 8 insertions(+), 3 deletions(-)
> > >>
> > >> diff --git a/migration/vmstate.c b/migration/vmstate.c
> > >> index
> > >> 5feaa3244d259874f03048326b2497e7db32e47c..aeffeafaa4fa7582076a4f2747=
906ddf9aca891b
> > >> 100644
> > >> --- a/migration/vmstate.c
> > >> +++ b/migration/vmstate.c
> > >> @@ -25,7 +25,7 @@ static int vmstate_subsection_save(QEMUFile *f, co=
nst
> > >> VMStateDescription *vmsd,
> > >>                                     void *opaque, JSONWriter *vmdesc=
,
> > >>                                     Error **errp);
> > >>  static int vmstate_subsection_load(QEMUFile *f, const VMStateDescri=
ption
> > >> *vmsd,
> > >> -                                   void *opaque);
> > >> +                                   void *opaque, Error **errp);
> > >>
> > >>  /* Whether this field should exist for either save or load the VM? =
*/
> > >>  static bool
> > >> @@ -225,7 +225,7 @@ int vmstate_load_state(QEMUFile *f, const
> > >> VMStateDescription *vmsd,
> > >>          field++;
> > >>      }
> > >>      assert(field->flags =3D=3D VMS_END);
> > >> -    ret =3D vmstate_subsection_load(f, vmsd, opaque);
> > >> +    ret =3D vmstate_subsection_load(f, vmsd, opaque, NULL);
> > >>      if (ret !=3D 0) {
> > >>          qemu_file_set_error(f, ret);
> > >>          return ret;
> > >> @@ -566,7 +566,7 @@ vmstate_get_subsection(const VMStateDescription =
*
> > >> const *sub,
> > >>  }
> > >>
> > >>  static int vmstate_subsection_load(QEMUFile *f, const VMStateDescri=
ption
> > >> *vmsd,
> > >> -                                   void *opaque)
> > >> +                                   void *opaque, Error **errp)
> > >>  {
> > >>      trace_vmstate_subsection_load(vmsd->name);
> > >>
> > >> @@ -598,6 +598,8 @@ static int vmstate_subsection_load(QEMUFile *f, =
const
> > >> VMStateDescription *vmsd,
> > >>          sub_vmsd =3D vmstate_get_subsection(vmsd->subsections, idst=
r);
> > >>          if (sub_vmsd =3D=3D NULL) {
> > >>              trace_vmstate_subsection_load_bad(vmsd->name, idstr,
> > >> "(lookup)");
> > >> +            error_setg(errp, "VM subsection '%s' in '%s' does not e=
xist",
> > >> +                       idstr, vmsd->name);
> > >>              return -ENOENT;
> > >>          }
> > >>          qemu_file_skip(f, 1); /* subsection */
> > >> @@ -608,6 +610,9 @@ static int vmstate_subsection_load(QEMUFile *f, =
const
> > >> VMStateDescription *vmsd,
> > >>          ret =3D vmstate_load_state(f, sub_vmsd, opaque, version_id)=
;
> > >>          if (ret) {
> > >>              trace_vmstate_subsection_load_bad(vmsd->name, idstr,
> > >> "(child)");
> > >> +            error_setg(errp,
> > >> +                       "Loading VM subsection '%s' in '%s' failed :=
 %d",
> > >>
> > >
> > > extra space before ":"
> > >
> > > other than that
> > > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > >
> >
> > Actually, almost systematically when you introduce an extra **errp
> > argument, you should ERRP_GUARD() in the function (see include/qapi/err=
or.h
> > doc). Was this discussed before? Can you update the following patches t=
oo?
>
> ERRP_GUARD is only needed in functions which derefence errp, which should
> very rarely be needed when all functions are non-void return value.

But also, it avoids this pitfall with @errp argument:

* - It should not be passed to error_prepend(), error_vprepend(), or
 *   error_append_hint(), because that doesn't work with &error_fatal.

either way, I don't care much, but for consistency it sounds
reasonable to ask every new function with **errp to have it.

>
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>
>


--=20
Marc-Andr=C3=A9 Lureau

