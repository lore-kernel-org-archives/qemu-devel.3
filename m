Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A40C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkBk-0003V1-En; Mon, 11 Mar 2024 14:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rjkBU-0003OE-IW
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 14:15:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rjkBT-0006Vs-0e
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 14:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710180933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DAqWM14werV1ReYVXIrsp+ItUTcsERZXjNzfqVEoVmU=;
 b=huw9gks+VcIgsrvt7ukI+jz4c+Au4SlcAI8SwOTmaCiIjQ4dD7R5eFMPwD/ey1msDuA9PU
 RihuaJxW/pi9vYYvj5YYHkW8CwxZKXhxuXdvtSy1/XlnxpPh9abDPjLyn/H9O2/8apMhCZ
 rD9zfteTsEsR5D/EDAj2IQxDosPS2hI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-bs0-BbSxMVaPIxbIUkbtpw-1; Mon, 11 Mar 2024 14:14:25 -0400
X-MC-Unique: bs0-BbSxMVaPIxbIUkbtpw-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-29bacf6d11eso3129420a91.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 11:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710180863; x=1710785663;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DAqWM14werV1ReYVXIrsp+ItUTcsERZXjNzfqVEoVmU=;
 b=smIGctkoq9WwS8FXlWD5V9iFQU/kwCdB4SNz9sQN2+ruMrYnCB3R+ImNeKqoR2x3u2
 P/c18ul38d6U6JY6BD86eSNPu6sCRaOMt3LYSgeUK57ZPCm6z53+fFTIBgLO1lxgzSIg
 BhZxlnwdv5WaoJI66KIpYyL332/EResGR1+UfJsb+x48cESdRNBHShHp+MIuN//UkCHF
 1zDt1KI5w01L4RU3f8wJtPrXscYEWTblvgjF3k/iTQBpttduYojCjwZ5yVqdXEi3lA8R
 d821pAfWXrvPQxq0pi/EUjgJA8TZnhDKyVCMpjSARv5sWjklFClaxpH7gdn8mmkjoa7N
 Hs6g==
X-Gm-Message-State: AOJu0YxnjpUDicS9fVzDoJFzR3C72ChpSK/e5CPszbHY+wIeAaiKzYCS
 yBg6cRNGMbCOBlrQPBlSSJ15K4xCchRJPTmbVzTCqEWnFW+RNH6CvLdig1z4skppQLxs8a1g060
 mQu62Mzz68sqtV4ti7Kv1sfRZMo6Yk1t1u0acaSXv8iGUtL1u4murxvgiuXJDuC+BYY75w6EjjC
 Gs46zGP5U+Qs/TxZ8KffQm77RnEydBrnZmqeU=
X-Received: by 2002:a17:90a:db86:b0:29b:9c92:a28a with SMTP id
 h6-20020a17090adb8600b0029b9c92a28amr1311121pjv.16.1710180863111; 
 Mon, 11 Mar 2024 11:14:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXs+3wNpieVNDk06ShsVVx4V1sTyJznncHl8BRhFmNVs8HJLprYABww05cmP83gOvh6ODxREDYmc0H69Dpjlw=
X-Received: by 2002:a17:90a:db86:b0:29b:9c92:a28a with SMTP id
 h6-20020a17090adb8600b0029b9c92a28amr1311103pjv.16.1710180862784; Mon, 11 Mar
 2024 11:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240201224246.39480-1-jsnow@redhat.com>
 <20240201224246.39480-9-jsnow@redhat.com>
 <87zfvvberq.fsf@pond.sub.org>
In-Reply-To: <87zfvvberq.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 11 Mar 2024 14:14:11 -0400
Message-ID: <CAFn=p-amLiQmaFoN3J+m=Yrij_JLzzezW8QFd3t+8N1ETfmUHA@mail.gmail.com>
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

On Tue, Feb 20, 2024 at 5:39=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > This function is a bit hard to type as-is; mypy needs some assertions t=
o
> > assist with the type narrowing.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/schema.py | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> > index 043ee7556e6..e617abb03af 100644
> > --- a/scripts/qapi/schema.py
> > +++ b/scripts/qapi/schema.py
> > @@ -997,7 +997,9 @@ def lookup_entity(self, name, typ=3DNone):
>        def lookup_entity(self, name, typ=3DNone):
>            ent =3D self._entity_dict.get(name)
>            if typ and not isinstance(ent, typ):
>                return None
> >          return ent
> >
> >      def lookup_type(self, name):
> > -        return self.lookup_entity(name, QAPISchemaType)
> > +        typ =3D self.lookup_entity(name, QAPISchemaType)
> > +        assert typ is None or isinstance(typ, QAPISchemaType)
> > +        return typ
> >
> >      def resolve_type(self, name, info, what):
> >          typ =3D self.lookup_type(name)
>
> I figure the real trouble-maker is .lookup_entity().
>
> When not passed an optional type argument, it returns QAPISchemaEntity.
>
> When passed an optional type argument, it returns that type or None.
>
> Too cute for type hints to express, I guess.
>
> What if we drop .lookup_entity()'s optional argument?  There are just
> three callers:
>
> 1. .lookup_type(), visible above.
>
>        def lookup_type(self, name):
>            ent =3D self.lookup_entity(name)
>            if isinstance(ent, QAPISchemaType):
>                return ent
>            return None
>
>     This should permit typing it as -> Optional[QAPISchemaType] without
>     further ado.
>
> 2. ._make_implicit_object_type() below
>
>    Uses .lookup_type() to check whether the implicit object type already
>    exists.  We figure we could
>
>            typ =3D self.lookup_entity(name)
>            if typ:
>                assert(isinstance(typ, QAPISchemaObjectType))
>                # The implicit object type has multiple users.  This can
>
> 3. QAPIDocDirective.run() doesn't pass a type argument, so no change.
>
> Thoughts?
>
> If you'd prefer not to rock the boat for this series, could it still
> make sense as a followup?

It makes sense as a follow-up, I think. I had other patches in the
past that attempted to un-cuten these functions and make them more
statically solid, but the shifting sands kept making it easier to put
off until later.

Lemme see if I can just tack this on to the end of the series and see
how it behaves...


