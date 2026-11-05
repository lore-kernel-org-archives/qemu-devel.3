Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E48B606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 12:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KEnDwVZn;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=BMafNn7g
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOwSA-0004pO-1e; Thu, 05 Nov 2026 07:20:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xOwS6-0004kp-8s
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 07:20:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xOwS4-0001lI-FK
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 07:20:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793881218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HztNanC93EM3i8KGjlwUT4V4OnMNyHu5/gKf7giJuF0=;
 b=KEnDwVZnn+Wdz+pHKiJs3mxaOL/QWASu07GP/bgZ9+9xTeAaxVNLsXsf8S8Z587mnZqHMY
 mH+nU43jB2nwwFzSBmnrt1vFyBmNKBj+K/84CkOJO2WRPG7ob3TEUJje1QQdAM3FvrVlWG
 kTkiuvqQIBiOEA1dFhq+h8qg0XtyVws=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-MOXkiJJ9O6SsmLhFrW6SwA-1; Thu, 05 Nov 2026 07:20:17 -0500
X-MC-Unique: MOXkiJJ9O6SsmLhFrW6SwA-1
X-Mimecast-MFC-AGG-ID: MOXkiJJ9O6SsmLhFrW6SwA_1793881216
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ed216ed20dso5592085ad.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 04:20:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793881216; cv=none;
 d=google.com; s=arc-20260327;
 b=nh0AZ/pO/xRAf57z2xb0QCQ6Nt1AaGtMs3ltjfapgIYmAbLjAnRWNfldQE1EB4vLTM
 1K2o26S8pS73nQa+FIPeSebu/d0hERw+ndQMiWPCV73QBSPE1Qo88KWkmIew6Ts63WxD
 k9WR0e+YzKuqViieTwHdBlF/6RQ80KE7bh9lKpdISujGhrSql6lJCsePMTlrNuf+GijY
 vyza+X4X/Xg9c/EoHNh5lCP1XCXaz82YFqS2zTlQLeBnNcGYME1wMWNzQTnmteQ/qe6H
 rI2O3oJJNvgQMZJWEGWzKOQrD9Oy2+QIasPQWCYvFQYglhsPax38kB1D/WjKtbY6/pXn
 80xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HztNanC93EM3i8KGjlwUT4V4OnMNyHu5/gKf7giJuF0=;
 fh=ouvYxzE8zeNcUhxOzySM2B4B2JfIaNKS3rgo8mZw+iY=;
 b=kczOmnqa4a4HLvKD9f0BZWtrabkyt2RLJwlsBu/hruHGOz0jJ9ZSS6f9SM25aCs9Do
 H8Kp1i2MS4q9J9Vj6VDqjdYHlMMhdYd9puWJMDKZGFnLYFn1aCjG0ZiTuYBoGaKiT3IP
 NPOd7FZpqxOj2XruQgRSV6VBMW2DotqcCtg0cQaVsejZojgTBxkXpcZbVETS97aR0UHu
 7pXq0LzlWraTKleRTmNclDyz1IftZ6zwUYR6hBJj+81PHAX5+446FZmk1A1TTUhIyEoP
 o28GuXqaCJSarRAJ8ujOtTHlzxEuJHXqhJLhPiPUcjtbq2X6VdhzbeNsWXbVXFz+g1SM
 UY+g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793881216; x=1794486016; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HztNanC93EM3i8KGjlwUT4V4OnMNyHu5/gKf7giJuF0=;
 b=BMafNn7gK8lccwjwGXijoUWIW+GBnCXVQQFVPDvu/NZQYk+5jEDt7P1NZ+qjHHtm1M
 L/rTyT+O8FkLowXCUzdmod76CY2NXafECyK/IrDYK233OlGg0oOSGBNq2wyMbejA1/Pn
 rSUNzc1MIfnbOr2cCBATfZ7/UiOa902DoAT4lijIQrLDwFcgvhI8jmuZGG8jqIMzMLaA
 Ih3SnB0mfKwdzocPF3iBsuFA2DDi3H/xZCereRtxzm8Tqf4tnZYApYR8dVZUnKLL6o1r
 HLK6V8VCRng5XCpc23v6MEl/ZTLnBErsUGUImBKQCP0ykoL+DdIUmadANvgwsjWFI41t
 4fMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793881216; x=1794486016;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HztNanC93EM3i8KGjlwUT4V4OnMNyHu5/gKf7giJuF0=;
 b=n5yS5rJ7T3d7ut+X7Bo2GEZUY9DWMV25CGA43GVwTK6qvrIodnWuPJaRNMJuExM7cz
 x1wZS3XYIH/mlSWwiQamC74A96AkeO7YzkMIz/GCaCqjZIvMcv6EoVpxQ73gug+bA1SH
 nSJQoVmoKCaErWS31Oy8LSASgAbf95WLnPSmAWXEct7VX6c0ArGvnswMI6v21eqXdzRZ
 ldVLToXz223/WNA9+2i/7pvfBPOVYhoXPk/q2iIfsBtNP+4A9JWVnZLniGPgmZGS6sRe
 UhjTI7KX7+giyWP/jMHD5eg54E1CNT2vL1Zdy7jTZTWwixJYrflT0P/N4+jDZ5q3gD0n
 vrZA==
X-Gm-Message-State: APuU4Z8ySsBtghG+SQ2lRTpts8ua2MmVVF3TWe5qaFcWrADdIGJS6Dnm
 tGy1gKTXPycsW8Ir1TCDug7YnvCpwfZneEKi+TfHb7vkmNBeWwGnycq5UZyejh8u4jC777EsPPU
 kj5i+rK/xIDm0lUOWugQW1nrKUuj3iQ2pZK0Qjn9BGbbAdUF3cYM//ONnX+/ynFOrjE33TaZNBi
 S0h2vCTo0LrZZY7ftJr7L4+SYnxxS1rAg=
X-Gm-Gg: AYBFou305ynxjm6cU4s9rWqBuRDsokj2cJ01Se6Xo2mXhNxLR54IafDWDOn0cIBn+Dl
 dydbcOELvbk1DhICOyg9eUVpv7Uhco9nscF/ODe4EKnpmgbFESZa7brxreHnXLiH4aWNTsNmRoE
 cQmdj71oJdqgw4zNezlU3hSO7DlOAzPVzxDs0bwunTno6B8mJKko0080lpmHDpY9HH6WaEWYY2c
 EUUMKyWvFTMs6HuGePeIJpdUJRWdmOZqN2/wrbkw4bBK058vvIxAIit+3zvQ//X5fdiza9TxCth
 Gg==
X-Received: by 2002:a17:903:f8d:b0:2e5:cd0f:518f with SMTP id
 d9443c01a7336-2ed23a5382amr16951575ad.0.1793881215890; 
 Thu, 05 Nov 2026 04:20:15 -0800 (PST)
X-Received: by 2002:a17:903:f8d:b0:2e5:cd0f:518f with SMTP id
 d9443c01a7336-2ed23a5382amr16951385ad.0.1793881215444; Thu, 05 Nov 2026
 04:20:15 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105080310.1656968-1-armbru@redhat.com>
 <20261105080310.1656968-6-armbru@redhat.com>
In-Reply-To: <20261105080310.1656968-6-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 5 Nov 2026 16:20:02 +0400
X-Gm-Features: AclHuK_FbN5j8XjYKPQYkGw7LR3JGaA0gpap4lF8z7IowzX3mCSt8c0YF4mN9-o
Message-ID: <CAMxuvaxD5Ku-CZevoUUCko=vnyyx=vKe8C_YzD1QF+gvhV8rDg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] qom: Convert child and link properties to
 QAPI-aware registration
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 5, 2026 at 12:03=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Child and link properties get serialized as QOM paths, i.e. as
> strings.  Use &str_type_info for them.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  qom/object.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/qom/object.c b/qom/object.c
> index 774a976c8b..9276b7a435 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1914,7 +1914,7 @@ object_property_try_add_child(Object *obj, const ch=
ar *name,
>
>      type =3D g_strdup_printf("child<%s>", object_get_typename(child));
>
> -    op =3D object_property_try_add(obj, name, type, NULL,
> +    op =3D object_property_try_add(obj, name, type, &str_type_info,
>                                   object_get_child_property,
>                                   NULL, object_finalize_child_property,
>                                   child, errp);
> @@ -2109,7 +2109,7 @@ object_add_link_prop(Object *obj, const char *name,
>
>      full_type =3D g_strdup_printf("link<%s>", type);
>
> -    op =3D object_property_add(obj, name, full_type, NULL,
> +    op =3D object_property_add(obj, name, full_type, &str_type_info,
>                               object_get_link_property,
>                               check ? object_set_link_property : NULL,
>                               object_release_link_property,
> @@ -2146,7 +2146,7 @@ object_class_property_add_link(ObjectClass *oc,
>
>      full_type =3D g_strdup_printf("link<%s>", type);
>
> -    op =3D object_class_property_add(oc, name, full_type, NULL,
> +    op =3D object_class_property_add(oc, name, full_type, &str_type_info=
,
>                                     object_get_link_property,
>                                     check ? object_set_link_property : NU=
LL,
>                                     object_release_link_property,
> --
> 2.55.0
>


