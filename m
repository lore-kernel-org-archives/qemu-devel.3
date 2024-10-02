Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDFDCF3195
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 07:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svtLf-0003f7-RF; Wed, 02 Oct 2024 03:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1svtLb-0003eO-Tu
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 03:00:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1svtLa-0003xa-7m
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 03:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727852427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zWSq610wMBtwIAeg3iWF+OcGpSQjELWrwT71Qmf8twU=;
 b=SztaZfgFfyx30aKA5+Ht620Mk70jFXSw0eKytQ/5IUEWcnF4KbfebToLDrJyUs8RFvLAc0
 IYMvqmu9JyL0CDXuoX1b1B3dVth1j8XeGeO/QKolU7Uq6yUvZ/mXETrJfnF3HneJfrAIk9
 sIpyke5ReowKs/WTNMNJCOV+nfYW2s8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-UwvrnHC0M8KgshDow9PK0Q-1; Wed, 02 Oct 2024 03:00:25 -0400
X-MC-Unique: UwvrnHC0M8KgshDow9PK0Q-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6cb317cd72eso132954866d6.1
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 00:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727852425; x=1728457225;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zWSq610wMBtwIAeg3iWF+OcGpSQjELWrwT71Qmf8twU=;
 b=aJJ/ViHZeBOl3Atd2pp4RuaN3oE8MwWZ65urWgZsnhysZtKo6OSRVl7mKK3cd6C4+S
 7EZbjMfjcHMSKXs0AHdW5vwue/kSbwKi3CdvRLJbUzG8h9ALQRkP676G1Tyn7fzTRMxS
 JfXbptxA7hC9TRxxprmsys3zdjPiZw4PG11KZc/HMmmxhwDRaxGdLMzUiCR3sjAqXhHY
 rSH/6mzXiVamXdctAejxL4nqbJRyVzYvkXeNDO+1UuLyZfl0wI9QG9abx+lYx/1Zu66L
 sJC+oygJSeBLm9cmKlb7Ykjsgsdqkjn9M8u0hTVpj/VxuJ3Xg/G7KcUol/gRomlAUYUm
 CJcQ==
X-Gm-Message-State: AOJu0Yx7wtdJ8VcbePHvEiWOMfmkxv2u7brp18Psive3SB/JKyGx0iFZ
 jfkPE5SuALEKktT5SOE2WJTpK1HeVvml54gaXIl7EHXIzEzbi3tnDXIVNgqmNl/1L9yoUadO3JP
 jcXCmKDc95beoYWZW9lcaDohUQybp0+FvRe2fGIE/z2zhlwEzCG2kD8vLE/tGwIsGgjr4eFGJ6P
 AIpyk90A9srJjVn126Q28xf3odz3E=
X-Received: by 2002:a05:6214:3f86:b0:6cb:7fb1:2038 with SMTP id
 6a1803df08f44-6cb81cc447emr32097566d6.53.1727852425269; 
 Wed, 02 Oct 2024 00:00:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGf93XhaV/HGLJBU/UQmddyb2Q2ELTW/ilX19rgXSCVnxhs2IE0SmmFz3dgV+rAdsaJEzzz2beH3r3Lwx4IuSQ=
X-Received: by 2002:a05:6214:3f86:b0:6cb:7fb1:2038 with SMTP id
 6a1803df08f44-6cb81cc447emr32097206d6.53.1727852424938; Wed, 02 Oct 2024
 00:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240930081458.1926382-1-marcandre.lureau@redhat.com>
 <20240930081458.1926382-22-marcandre.lureau@redhat.com>
 <87wmir9g9p.fsf@pond.sub.org>
In-Reply-To: <87wmir9g9p.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 2 Oct 2024 11:00:13 +0400
Message-ID: <CAMxuvazAEQf5hCe5KcFuAU9y5MUrn0wY3sZwtcJxbQT0mvH=LA@mail.gmail.com>
Subject: Re: [PATCH v3 21/22] qom/object: fix -Werror=maybe-uninitialized
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Fam Zheng <fam@euphon.net>,
 Song Gao <gaosong@loongson.cn>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, 
 qemu-block@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Greg Kurz <groug@kaod.org>, 
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Eric Blake <eblake@redhat.com>, Hyman Huang <yong.huang@smartx.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Jesper Devantier <foss@defmacro.it>, Peter Xu <peterx@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Bin Meng <bin.meng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Oct 2, 2024 at 10:21=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> marcandre.lureau@redhat.com writes:
>
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > object_resolve_path_type() didn't always set *ambiguousp.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Fixes: 81c48dd79655 (hw/i386/acpi: Add object_resolve_type_unambiguous to=
 improve modularity)
>

ok

> > ---
> >  qom/object.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/qom/object.c b/qom/object.c
> > index 28c5b66eab..bdc8a2c666 100644
> > --- a/qom/object.c
> > +++ b/qom/object.c
> > @@ -2201,6 +2201,9 @@ Object *object_resolve_path_type(const char *path=
, const char *typename,
> >          }
> >      } else {
> >          obj =3D object_resolve_abs_path(object_get_root(), parts + 1, =
typename);
> > +        if (ambiguousp) {
> > +            *ambiguousp =3D false;
> > +        }
> >      }
> >
> >      g_strfreev(parts);
> > @@ -2226,7 +2229,7 @@ Object *object_resolve_path_at(Object *parent, co=
nst char *path)
> >
> >  Object *object_resolve_type_unambiguous(const char *typename, Error **=
errp)
> >  {
> > -    bool ambig;
> > +    bool ambig =3D false;
> >      Object *o =3D object_resolve_path_type("", typename, &ambig);
> >
> >      if (ambig) {
>
> Contract:
>
>    /**
>     * object_resolve_path_type:
>     * @path: the path to resolve
>     * @typename: the type to look for.
>     * @ambiguous: returns true if the path resolution failed because of a=
n
>     *   ambiguous match
>     *
>     * This is similar to object_resolve_path.  However, when looking for =
a
>     * partial path only matches that implement the given type are conside=
red.
>     * This restricts the search and avoids spuriously flagging matches as
>     * ambiguous.
>     *
>     * For both partial and absolute paths, the return value goes through
>     * a dynamic cast to @typename.  This is important if either the link,
>     * or the typename itself are of interface types.
>     *
>     * Returns: The matched object or NULL on path lookup failure.
>     */
>
> Note the parameter is called @ambiguous here, but @ambiguousp in the
> definition.  Bad practice.

hmm

>
> All the contract promises is that true will be stored in the variable
> passed to @ambiguous when the function fails in a certain way.  For that
> to work, the variable must be initialized to false.
>
> You found a caller that doesn't: object_resolve_type_unambiguous().
> This is a bug.  There might be more.  Impact is not obvious.
>
> Two ways to fix:
>
> 1. Find all callers that don't, and fix them.  Your first hunk is then
>    superfluous.  Your second hunk fixes the one you already found.
>

Imho, that's not a good API, it's easy to get wrong.

> 2. Change the contract so callers don't have to initialize.  Your second
>    hunk is then superfluous.  The update to the contract is missing.
>

I prefer that it always set the variable. I also prefer that caller
initializes variables. So all are good practices imho, even if it's a
bit redundant.

> While there: the contract fails to specify that @ambiguous may be null.
> Needs fixing, too.
>
> Same for object_resolve_path().
>

ok


