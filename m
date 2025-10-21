Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55045CCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 12:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBBwc-0006Ad-LZ; Tue, 21 Oct 2025 08:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vBBwb-0006A9-4k
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 08:58:29 -0400
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vBBwY-0000GL-UL
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 08:58:28 -0400
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-890deb84f95so621172585a.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 05:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761051505; x=1761656305; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=96CYvlD6uhLxBW8TiRf/cv97M07vTXYDF933VGBl2m4=;
 b=awRnMpl3UzItFTMRhzMak8MWphg6OXaZ2/pySX6Bc8Ye6wi5Bj9eDSMHQUpzO2E0un
 vzrxUjE0mK+ufjO3meCVP1/+Jm4Cijwm40L6fi/oT0ufYT5cTu5KELFhyjFKOfJeQIaO
 741s5/0OQ3eJDwikYxzvPwJz9sBwjoM7ZDcyzrIM3wzGFJZs0cRIDlYSdus6f408Rp52
 NhLV42LO8YbwtfT/0udHQuBdEBOVuN1w5RcLeTI5Vqw/aDNiI25/Rz9h7KJb9ra+321P
 vALN0ltzMqQ4XtUW3CyQ8JZ5u0LNjLlI1vN8/O22yno/eDrhveRBMpV6bCrqp+TQYZp5
 JoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761051505; x=1761656305;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=96CYvlD6uhLxBW8TiRf/cv97M07vTXYDF933VGBl2m4=;
 b=OQYRvT4iJdtEwU798+Buiyib6McjUqlXkTi9KUprlZd+RvqiYUe7ii3hyAQ7JwBcYS
 cExeB83kF6SY6yhLlHIucSEjA391rMPIikGs3bZBx+taCiQLkDSp2/JAKs+rQHk8pjt7
 tm8O1NwQsRxnk8A+QifDvFNYVxNsBHloGHvdhaREQDTZGNmnLrDt0yIAJ6gmQutPM2hS
 9JUwCKK6Dbb8fPOFWCyh7iz2vSQcog7Q6lJg+O2vy+OtXFkI5iqgXG5mpwtOSUP7PR87
 6/RKn1ETheNrinuCaw7pqZ0/JPOADNQYgks5gRTiVGfKMccczWHxpVA8uudNaohft7fu
 MxUg==
X-Gm-Message-State: AOJu0YxcVCfqP3c2VaQmfoaJi5la7tc358IyW0pz3D+ZQnvQosjZsBih
 4/KUd5suTfUHt5LIcBFypYhazDl0OuF7U+vU6NBMXAvW5ENZUNE/yjrDvR99IoK/PLGHZBqbvyq
 2duehUIdvNJW4WxaAAqyPA4jVZPENcAc=
X-Gm-Gg: ASbGncspyA+NbHSwodK8d7bRCihCGLk+4zgLQLj05R4FhXdmBtzX637zXX7CU2RJ8+X
 yNTFQWnW65jD5igCcDhiHUO5Uh3cUidBpoOQ9olng9ddMZCiNqBfWSVLjZM1ETKaLBuedtxQjAk
 83E+xuUO0G7v6rH+30TMr575dVQx+z0MUKvYi1l1IpixgLi3ALQG3wD/LUyfKgCCCLeMe0q37Bs
 sa6Rd7XNNz10BEmGe0N7EmQSQ1F9OJOk2KNjo7U/vJZ2pVL7Ioe7qsbrfn/ogiaEkIfc9H7qyL7
 tVV5AtVvxG7VSvzP
X-Google-Smtp-Source: AGHT+IEt5410kUkhnjNKwQAwOSJAuLd22xXcG1+N7T5FKUMl0Z4g4dYBqiJqYqU3VDkWsGbDIbABUIiusl8bNhgAvnI=
X-Received: by 2002:ac8:7f44:0:b0:4e8:b478:66 with SMTP id
 d75a77b69052e-4e8b4780995mr115322371cf.82.1761051505046; 
 Tue, 21 Oct 2025 05:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <20251015105419.2975542-1-marcandre.lureau@redhat.com>
 <87o6q0mn4o.fsf@pond.sub.org>
In-Reply-To: <87o6q0mn4o.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 21 Oct 2025 16:58:13 +0400
X-Gm-Features: AS18NWDmJOIoYlqGEn3ar7nl0DFPKUYkZk0dX_xv1dcgEyZYZS2qa3OUHVsXl2Q
Message-ID: <CAJ+F1CJ6UiUZ=rY_O41Za=yPSDoW2atbM8Yk_oSdpQ+Nkjz1uw@mail.gmail.com>
Subject: Re: [PATCH] RFC: qdev: add legacy properties only for those
 print()-able
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x735.google.com
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

On Tue, Oct 21, 2025 at 4:55=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> marcandre.lureau@redhat.com writes:
>
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > The link properties are not printed in "info qtree", I don't know if
> > this was intentional. We currently register legacy properties for
> > link/ptr properties, but they don't have PropertyInfo getters (only
> > ObjectPropertyAccessor, when using non-legacy properties)
> >
> > By not registering a (unusable?) legacy property, "info qtree" can now
> > print the link.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  hw/core/qdev-properties.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> > index b7e8a89ba5..fe260a9670 100644
> > --- a/hw/core/qdev-properties.c
> > +++ b/hw/core/qdev-properties.c
> > @@ -1143,14 +1143,13 @@ static void qdev_class_add_legacy_property(Devi=
ceClass *dc, const Property *prop
> >  {
> >      g_autofree char *name =3D NULL;
> >
> > -    /* Register pointer properties as legacy properties */
> > -    if (!prop->info->print && prop->info->get) {
> > +    if (!prop->info->print) {
> >          return;
> >      }
> >
> >      name =3D g_strdup_printf("legacy-%s", prop->name);
> >      object_class_property_add(OBJECT_CLASS(dc), name, "str",
> > -        prop->info->print ? qdev_get_legacy_property : prop->info->get=
,
> > +        qdev_get_legacy_property,
> >          NULL, NULL, (Property *)prop);
> >  }
>
> The old code confuses me.  Let's go through it real slow.
>
>     /**
>      * qdev_class_add_legacy_property:
>      * @dev: Device to add the property to.
>      * @prop: The qdev property definition.
>      *
>      * Add a legacy QOM property to @dev for qdev property @prop.
>      *
>      * Legacy properties are string versions of QOM properties.  The form=
at of
>      * the string depends on the property type.  Legacy properties are on=
ly
>      * needed for "info qtree".
>      *
>      * Do not use this in new code!  QOM Properties added through this in=
terface
>      * will be given names in the "legacy" namespace.
>      */
>     static void qdev_class_add_legacy_property(DeviceClass *dc, const Pro=
perty *prop)
>     {
>         g_autofree char *name =3D NULL;
>
>         /* Register pointer properties as legacy properties */
>
> The comment talks about "pointer properties".  We used to call
> properties defined with DEFINE_PROP_PTR() that way, but these were
> deleted years ago.  The comment is even older.  I'm going to ignore it.
>
>         if (!prop->info->print && prop->info->get) {
>             return;
>         }
>
> To get here, prop->info->print || !prop->info->get.
>
>         name =3D g_strdup_printf("legacy-%s", prop->name);
>         object_class_property_add(OBJECT_CLASS(dc), name, "str",
>             prop->info->print ? qdev_get_legacy_property : prop->info->ge=
t,
>             NULL, NULL, (Property *)prop);
>
> If qdev property @prop has a .print() method, we create a QOM property
> "legacy-FOO" of type "str" with qdev_get_legacy_property() as .get(),
> and no .set() or .release().
>
> qdev_get_legacy_property() is a QOM .get() wrapping around qdev
> .print(): it calls .print() to format the property value as a string
> (arbitrarily limited to 1023 characters), then visits it with
> visit_type_str().
>
> Aside: there seems to be just one property that implements .print():
> DEFINE_PROP_PCI_DEVFN(), in qdev_prop_pci_devfn.  Quite a lot of
> infrastructure just for that.
>
> Else, prop->info->get is null, because prop->info->print || !prop->info->=
get.
> So we create a QOM property "legacy-FOO" with no .get(), .set(),
> .release().  Why?
>
> Your patch gets rid of these.  How does this make "info qtree" show link
> properties?  Hmm...  qdev_print_props() uses "legacy-FOO" instead of
> "FOO" when it exists.  But a "legacy-FOO" without a .get() will fail.
> When it does, the property is skipped.
>
> Is this what makes the patch work?
>


Yes, that matches my understanding and I agree about your feeling
about the infrastructure just for DEVFN. But at the same time, it's
nice to have and I don't have a proposal to change that :)

--=20
Marc-Andr=C3=A9 Lureau

