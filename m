Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52056C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkdo-00085A-5R; Mon, 11 Mar 2024 14:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rjkdj-00081a-RG
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 14:44:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rjkdi-0003YH-0S
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 14:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710182684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sw3GeKk39KyNMMZmj4VnbSwyDIiOAbCZcbkxdviJ2fE=;
 b=diD9acexDG6CNcEUNOAjjDG2hwCWuHR90tSncHDxLKpxto4DDP2cVuP3eVSZGOKOJ8iWII
 //H+hkipUfIvzcAbFSm1dBSEDqpY6zbg44LkLsZP5agId0LTG9zse6RcasEOANHiqxCO7t
 7G7VKoGNSax3UAkkGJQUrnLEvIPsXzU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-rTG2fkLXNTON0gejDGt-_g-1; Mon, 11 Mar 2024 14:44:43 -0400
X-MC-Unique: rTG2fkLXNTON0gejDGt-_g-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-29bda2d3ea3so1981437a91.3
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 11:44:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710182682; x=1710787482;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sw3GeKk39KyNMMZmj4VnbSwyDIiOAbCZcbkxdviJ2fE=;
 b=VdBgbv0vfMWGIVC874c3HiNUO8i7Y310O1kGyUOrqcQjy+PVEhdMXwIgJIDKXf09B3
 rUi2Bix0QTGVUBmFKEp7H3R3fyyf3jw9D+rrUGuUT/8uppY69Wpct68aUOfxMTZ1d9gw
 0AK0VRlCUT0YiiTrhZQ+5pS4xWZDfeJ69tE98aUa04XjNBRHa4bGhVQu0ZjGqQ3b3eHH
 W6cil/8hIE/v/cswT9MIU4AisCNrzh+HwxC77L4c/UHRsFdzSPZFkLIfCSpLKXLcJSbc
 gyu0W3XadEETTPrqc6DFuVyftxXs4rnF7JEBQfxxz5OeIJBErH356KN2EnirlF3pCse+
 SS4w==
X-Gm-Message-State: AOJu0Yy/6CdLVT+iEOMKlOhM7Nd/vBYrTEN+VisqAHuRRP6Xa3kIR7sn
 +zVDQwvyXtkIZjx6KyR1H+9m1rk5eR3blUTu+BwpWC+FKrCYoNhsf5iicRPZQW3kHmRosGsHX5I
 bW2j0IuuQVhiRI7tzKsYxBOIbacYDtenxLRDMQSZFM9QTWVACJvJSrFMWX6qGCPdyiHzb1L1wA1
 qb0bokXRMBDuzkKetzleRNEOqKxvs=
X-Received: by 2002:a17:90b:3804:b0:29b:aea0:1883 with SMTP id
 mq4-20020a17090b380400b0029baea01883mr5579552pjb.2.1710182681811; 
 Mon, 11 Mar 2024 11:44:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErBmjQO5nd5/J7CZBnwYSMGmv6/G6ZznOZxARSmnJvRnH1U13d5MGjAlENEnD8hMfjt0qhoNH/EcN8mSHcmJU=
X-Received: by 2002:a17:90b:3804:b0:29b:aea0:1883 with SMTP id
 mq4-20020a17090b380400b0029baea01883mr5579540pjb.2.1710182681504; Mon, 11 Mar
 2024 11:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240201224246.39480-1-jsnow@redhat.com>
 <20240201224246.39480-11-jsnow@redhat.com>
 <87h6i35fmj.fsf@pond.sub.org>
In-Reply-To: <87h6i35fmj.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 11 Mar 2024 14:44:29 -0400
Message-ID: <CAFn=p-Y38th3qn+xFU-5eiQXVhtgjzzD662eKSrEXY=0+aZtbw@mail.gmail.com>
Subject: Re: [PATCH v3 10/20] qapi: use schema.resolve_type instead of
 schema.lookup_type
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 20, 2024 at 10:18=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > the function lookup_type() is capable of returning None, but some
> > callers aren't prepared for that and assume it will always succeed. For
> > static type analysis purposes, this creates problems at those callsites=
.
> >
> > Modify resolve_type() - which already cannot ever return None - to allo=
w
> > 'info' and 'what' parameters to be elided, which infers that the type
> > lookup is a built-in type lookup.
> >
> > Change several callsites to use the new form of resolve_type to avoid
> > the more laborious strictly-typed error-checking scaffolding:
> >
> >   ret =3D lookup_type("foo")
> >   assert ret is not None
> >   typ: QAPISchemaType =3D ret
> >
> > which can be replaced with the simpler:
> >
> >   typ =3D resolve_type("foo")
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/introspect.py | 4 ++--
> >  scripts/qapi/schema.py     | 5 ++---
> >  2 files changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> > index 67c7d89aae0..c38df61a6d5 100644
> > --- a/scripts/qapi/introspect.py
> > +++ b/scripts/qapi/introspect.py
> > @@ -227,10 +227,10 @@ def _use_type(self, typ: QAPISchemaType) -> str:
> >
> >          # Map the various integer types to plain int
> >          if typ.json_type() =3D=3D 'int':
> > -            typ =3D self._schema.lookup_type('int')
> > +            typ =3D self._schema.resolve_type('int')
> >          elif (isinstance(typ, QAPISchemaArrayType) and
> >                typ.element_type.json_type() =3D=3D 'int'):
> > -            typ =3D self._schema.lookup_type('intList')
> > +            typ =3D self._schema.resolve_type('intList')
> >          # Add type to work queue if new
> >          if typ not in self._used_types:
> >              self._used_types.append(typ)
> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> > index 573be7275a6..074897ee4fb 100644
> > --- a/scripts/qapi/schema.py
> > +++ b/scripts/qapi/schema.py
> > @@ -650,8 +650,7 @@ def check(self, schema, seen):
> >                      "discriminator '%s' is not a member of %s"
> >                      % (self._tag_name, base))
> >              # Here we do:
> > -            base_type =3D schema.lookup_type(self.tag_member.defined_i=
n)
> > -            assert base_type
> > +            base_type =3D schema.resolve_type(self.tag_member.defined_=
in)
> >              if not base_type.is_implicit():
> >                  base =3D "base type '%s'" % self.tag_member.defined_in
> >              if not isinstance(self.tag_member.type, QAPISchemaEnumType=
):
> > @@ -1001,7 +1000,7 @@ def lookup_type(self, name):
> >          assert typ is None or isinstance(typ, QAPISchemaType)
> >          return typ
> >
> > -    def resolve_type(self, name, info, what):
> > +    def resolve_type(self, name, info=3DNone, what=3DNone):
> >          typ =3D self.lookup_type(name)
> >          if not typ:
> >              assert info and what  # built-in types must not fail looku=
p
>
> I still dislike this, but I don't think discussing this more will help.
> I can either accept it as the price of all your other work, or come up
> with my own solution.
>
> Let's focus on the remainder of the series.

You're absolutely more than welcome to take the series and fork it to
help bring it home - as long as it passes type checking at the end, I
won't really mind what happens to it in the interim :)

Sorry if that comes across as being stubborn, it's more the case that
I genuinely don't think I see your point of view, and feel unable to
target it.

(Sorry.)

--js


