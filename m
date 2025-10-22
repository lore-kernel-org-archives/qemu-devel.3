Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77D0CCD195
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 11:14:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBWmo-0000aR-76; Wed, 22 Oct 2025 07:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vBWmk-0000aD-D7
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 07:13:42 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vBWmc-0007ra-L5
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 07:13:41 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4e2d2d764a3so8086771cf.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 04:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761131613; x=1761736413; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gJm3aHrIHKXcpk9IUMUX6l4uxbOhXHibBE+5xKgDqfE=;
 b=h5gyaFk32t4+zZmeoJDqsDadapaeEU19/GxEW5c8rXF4BakLLfZg8vZesJxI4U4JMt
 9bGHm8ybRWgSe4ij1GQ8EQA9UsshGtTrL6mW8M223oFQnjvVYjQeL0YCw2xQkiY6G54p
 M+k8rbZW39BIMa8jgTqAHvwod6Ct352BM5SrFvqrWh6/2edQ574gVfj9uE2TAQeEDVgw
 3BkK8YlgaMqaPFxZqb9RNVVaio84ZhC9ZSmn8Q/jmXUHoo0igv+SPYcwMBMNDGPK18Fy
 p6zKmmod3HpnErt/emqJcwXuMQzL2CLH3c8opPBTaRTupm2jnACZeGbxtXZIJIeKUd3x
 WmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761131613; x=1761736413;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gJm3aHrIHKXcpk9IUMUX6l4uxbOhXHibBE+5xKgDqfE=;
 b=dS88bCq7qDb4XKQPR30jVBZ8S4V2A/og77ofY2XQdLOrPCJ01H3fCiHcm+Z3Agxkaz
 eRvZZjlumjAlVwEawMhGm6NGCQIx+DzFH4xjeY/Vgs0/z9NrYcAnDUC3dutqvRSUWwDs
 vY5EB52z7ipYwAQYVRyDdJQjRDdW09229MkCWFvN8sTdqD4qvBS9Aj2EEzN7aUiV1yxz
 EERHGAhzJB0r9X6NDm7gvu44xqm+Hw/uZFV9BYSRqbI3NxnDVYFg/i/D2mRsDP+UeAEe
 0fM1d0fecVP1obXwVo9Jt45TDTYIrghz3+fGDJqsQNzkmsj02DyURmBDzyS5+PVfBnDw
 XrmA==
X-Gm-Message-State: AOJu0Ywlc76+oykP2bSCeHPldBr4eg/TSSiDDdnQTyTkgWoXmRMjE9fQ
 CS9YYEsj/9lOJ3B2phT9tgSX4b7nyv6pwdruUVjBaaCP/pnrmU8ebp09XnFs66Y2r4bnuLl6qm4
 IQSL2e/+b1dkRqbGe/h8AlQkctuE8H6I=
X-Gm-Gg: ASbGncvRf9phYft3RjqdKqM5Dtx/DKXZCLtUutMoX3B+VuZO/BevtERQiDsUQcAWaXP
 Sb8uW8JLf//ZNXa1RqPdbSbHIcca6ecQIwEqpwIFrhvdMfwhs9s+OoOuD2U0iu6yo+YpdB7JguI
 rA2oGRMLjB/jomyZlqShMVIxtUo0xE8k+gYZZEl6if25U3VwxMJ5fha/RSp5xtzQCzoUm+srjOk
 mm+b7ykyTK55GmObvP9/QvKi3eWNnDmka+f1ZXA+nrRaelEH4EBe910zAF3nqL8w+smtrNj9nLF
 XIWxWkYuEa7JR3QaQ7JfB2fg9Qk=
X-Google-Smtp-Source: AGHT+IFvhzdDL0BVkKsDcow3tfRWYKIYb/DHj9NL+++5t9I0gVhWpLNlwVE1Hi+8R1pwnMzeylQm/mNECa9wvJD0sus=
X-Received: by 2002:ac8:7f46:0:b0:4e8:bad8:7c18 with SMTP id
 d75a77b69052e-4e8bad87fcbmr120235941cf.15.1761131613092; Wed, 22 Oct 2025
 04:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <20251022101420.36059-1-armbru@redhat.com>
 <20251022101420.36059-4-armbru@redhat.com>
In-Reply-To: <20251022101420.36059-4-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 22 Oct 2025 15:13:20 +0400
X-Gm-Features: AS18NWDGAkkdcL7SKwq8TBcJS9Xr0FiVDYwGsBElYTx5VUp2a69tgQYvF_-OOfM
Message-ID: <CAJ+F1C+2vp+Byp2Q40GQZUYLW0xpoTbFAj5oc2R=nbsy8i_8Eg@mail.gmail.com>
Subject: Re: [PATCH 3/3] qdev: Legacy properties are now unused, drop
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x833.google.com
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


On Wed, Oct 22, 2025 at 2:15=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

I don't think we have much reasonable way to use those "legacy-*"
properties from qom-get and similar, so it's probably ok to just
remove them without deprecation.

Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/core/qdev-properties.c | 46 ---------------------------------------
>  1 file changed, 46 deletions(-)
>
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 422a486969..46a12652f4 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -1108,51 +1108,6 @@ static void qdev_class_add_property(DeviceClass *k=
lass, const char *name,
>      object_class_property_set_description(oc, name, prop->info->descript=
ion);
>  }
>
> -/**
> - * Legacy property handling
> - */
> -
> -static void qdev_get_legacy_property(Object *obj, Visitor *v,
> -                                     const char *name, void *opaque,
> -                                     Error **errp)
> -{
> -    const Property *prop =3D opaque;
> -    char *s;
> -
> -    s =3D prop->info->print(obj, prop);
> -    visit_type_str(v, name, &s, errp);
> -    g_free(s);
> -}
> -
> -/**
> - * qdev_class_add_legacy_property:
> - * @dev: Device to add the property to.
> - * @prop: The qdev property definition.
> - *
> - * Add a legacy QOM property to @dev for qdev property @prop.
> - *
> - * Legacy properties are string versions of QOM properties.  The format =
of
> - * the string depends on the property type.  Legacy properties are only
> - * needed for "info qtree".
> - *
> - * Do not use this in new code!  QOM Properties added through this inter=
face
> - * will be given names in the "legacy" namespace.
> - */
> -static void qdev_class_add_legacy_property(DeviceClass *dc, const Proper=
ty *prop)
> -{
> -    g_autofree char *name =3D NULL;
> -
> -    /* Register pointer properties as legacy properties */
> -    if (!prop->info->print && prop->info->get) {
> -        return;
> -    }
> -
> -    name =3D g_strdup_printf("legacy-%s", prop->name);
> -    object_class_property_add(OBJECT_CLASS(dc), name, "str",
> -        prop->info->print ? qdev_get_legacy_property : prop->info->get,
> -        NULL, NULL, (Property *)prop);
> -}
> -
>  void device_class_set_props_n(DeviceClass *dc, const Property *props, si=
ze_t n)
>  {
>      /* We used a hole in DeviceClass because that's still a lot. */
> @@ -1165,7 +1120,6 @@ void device_class_set_props_n(DeviceClass *dc, cons=
t Property *props, size_t n)
>      for (size_t i =3D 0; i < n; ++i) {
>          const Property *prop =3D &props[i];
>          assert(prop->name);
> -        qdev_class_add_legacy_property(dc, prop);
>          qdev_class_add_property(dc, prop->name, prop);
>      }
>  }
> --
> 2.49.0
>
>


--
Marc-Andr=C3=A9 Lureau

