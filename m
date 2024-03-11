Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC723C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:28:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkN0-000212-1m; Mon, 11 Mar 2024 14:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rjkMZ-0001qK-19
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 14:27:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rjkMV-0000D9-9k
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 14:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710181618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QYYvrSKzlnHfIla6eDUMUhctJ37kYkQMWj+SzeQTbWo=;
 b=H+ylpDmeaL+a7LXVr47HJTavhieamsG7MubAZAjgMrkF5+RLBA+pgW/HEVk9kWwRBCMl2d
 E4hk6YmGGZRru6CcI5hdXmtntc5FZiT8AJvBorqwpVnrW8t8oXzyaM4o5ieKbfIhOagG1a
 gAqyICr9hQOJJ8zDyKVl4DGpFN8GAh8=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-rArP2-j_MHiqupY-aIq2cA-1; Mon, 11 Mar 2024 14:26:57 -0400
X-MC-Unique: rArP2-j_MHiqupY-aIq2cA-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1ddae7e74f6so5660605ad.2
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 11:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710181615; x=1710786415;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QYYvrSKzlnHfIla6eDUMUhctJ37kYkQMWj+SzeQTbWo=;
 b=D2C3/NxPlBADDUNqU4Yp74GudzwFOjIT2fwLVHANfaQs3SB5XRYx/UAp7MSrd7MJpG
 R1RqJuVBw02b1pJTXiqf8THSFbA793sShfZR9eW0ZUfWBKZKCqZhI+V89+hjbJntM0xO
 N0zkf8ytWKz1eC+gyj+ID3RmoTUeMmS26IC+gSixRw/cvp+oW5qL7zrhfNFbAo4l45w5
 kRI7R4iU1ah/Dbro6+cFA54JSkjw+aIgltdH2Kgo5+8XCElofyNyhNfan5AgeJDA9suc
 AQ9LUqARMt8ea1FTEZskKk2W2QHOxw+3qTXpHm57xxHIJaomUdhlztDm3nImMihrhoW/
 X93Q==
X-Gm-Message-State: AOJu0YyBqYLiKqu2jBRH6UOhjvzaYxMaewkElfXdvENc2vqsWe7DzYQ5
 8AmGLPQwJv5tzKVbDZ6vWQJzFelV+ug2dAAGQtdTQ323FwNQuAJMQlCcfqoq3fCwdGn/6krRHph
 uPkItCKLrbXQWmUNjF78xioBPsb38h6dMCA/gyLPH2m/7JlK6FyG7o8O7AKegLBESIIrcZuUEgd
 tQ7XLN2MuBhO314sNz0wGu2Ye/c1EZ+SpMrJc=
X-Received: by 2002:a17:903:1206:b0:1dd:76f0:4455 with SMTP id
 l6-20020a170903120600b001dd76f04455mr7944380plh.49.1710181615569; 
 Mon, 11 Mar 2024 11:26:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEevGhmIPgUBq1AGABnTIdwbs9g0x+CuxzzKxL+futSezGGEZCzMSxN7JLsDlb49OFOWwT/+khAgQ07IOoxZgI=
X-Received: by 2002:a17:903:1206:b0:1dd:76f0:4455 with SMTP id
 l6-20020a170903120600b001dd76f04455mr7944367plh.49.1710181615279; Mon, 11 Mar
 2024 11:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240201224246.39480-1-jsnow@redhat.com>
 <20240201224246.39480-9-jsnow@redhat.com>
 <87zfvvberq.fsf@pond.sub.org>
 <CAFn=p-amLiQmaFoN3J+m=Yrij_JLzzezW8QFd3t+8N1ETfmUHA@mail.gmail.com>
In-Reply-To: <CAFn=p-amLiQmaFoN3J+m=Yrij_JLzzezW8QFd3t+8N1ETfmUHA@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 11 Mar 2024 14:26:43 -0400
Message-ID: <CAFn=p-YkNHQM7QQUfd+p9E7d4BpdS4JpfGw30RJ6SsVmeWGZmw@mail.gmail.com>
Subject: Re: [PATCH v3 08/20] qapi/schema: add type narrowing to lookup_type()
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

On Mon, Mar 11, 2024 at 2:14=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:
>
> On Tue, Feb 20, 2024 at 5:39=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
> >
> > John Snow <jsnow@redhat.com> writes:
> >
> > > This function is a bit hard to type as-is; mypy needs some assertions=
 to
> > > assist with the type narrowing.
> > >
> > > Signed-off-by: John Snow <jsnow@redhat.com>
> > > ---
> > >  scripts/qapi/schema.py | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> > > index 043ee7556e6..e617abb03af 100644
> > > --- a/scripts/qapi/schema.py
> > > +++ b/scripts/qapi/schema.py
> > > @@ -997,7 +997,9 @@ def lookup_entity(self, name, typ=3DNone):
> >        def lookup_entity(self, name, typ=3DNone):
> >            ent =3D self._entity_dict.get(name)
> >            if typ and not isinstance(ent, typ):
> >                return None
> > >          return ent
> > >
> > >      def lookup_type(self, name):
> > > -        return self.lookup_entity(name, QAPISchemaType)
> > > +        typ =3D self.lookup_entity(name, QAPISchemaType)
> > > +        assert typ is None or isinstance(typ, QAPISchemaType)
> > > +        return typ
> > >
> > >      def resolve_type(self, name, info, what):
> > >          typ =3D self.lookup_type(name)
> >
> > I figure the real trouble-maker is .lookup_entity().
> >
> > When not passed an optional type argument, it returns QAPISchemaEntity.
> >
> > When passed an optional type argument, it returns that type or None.
> >
> > Too cute for type hints to express, I guess.
> >
> > What if we drop .lookup_entity()'s optional argument?  There are just
> > three callers:
> >
> > 1. .lookup_type(), visible above.
> >
> >        def lookup_type(self, name):
> >            ent =3D self.lookup_entity(name)
> >            if isinstance(ent, QAPISchemaType):
> >                return ent
> >            return None
> >
> >     This should permit typing it as -> Optional[QAPISchemaType] without
> >     further ado.
> >
> > 2. ._make_implicit_object_type() below
> >
> >    Uses .lookup_type() to check whether the implicit object type alread=
y
> >    exists.  We figure we could
> >
> >            typ =3D self.lookup_entity(name)
> >            if typ:
> >                assert(isinstance(typ, QAPISchemaObjectType))
> >                # The implicit object type has multiple users.  This can
> >
> > 3. QAPIDocDirective.run() doesn't pass a type argument, so no change.
> >
> > Thoughts?
> >
> > If you'd prefer not to rock the boat for this series, could it still
> > make sense as a followup?
>
> It makes sense as a follow-up, I think. I had other patches in the
> past that attempted to un-cuten these functions and make them more
> statically solid, but the shifting sands kept making it easier to put
> off until later.
>
> Lemme see if I can just tack this on to the end of the series and see
> how it behaves...

Oh, I see what you're doing. Well, I think it's fine if you want to,
but it's also fine to keep this "stricter" method. There's also ways
to type it using mypy's @overload which I've monkey'd with in the
past. Dealer's choice, honestly, but I think I'm eager to just get to
the "fully typed" baseline and then worry about changing more stuff.


