Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9970CC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 21:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk9Iv-0003On-69; Tue, 12 Mar 2024 17:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rk9It-0003O4-Hl
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 17:04:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rk9Ir-0005Z7-EM
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 17:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710277491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cH8teo+mlmEzIzYAPkrD2P4DvAuQ/xYWJSImlRLo00M=;
 b=EIczIlyUUay8fIRJcAiNUeheEp/FdXwsDskyckZDc/iDJIEqU/oagooTSBymFUqrFXElRx
 X6cz+3wS41TnKTHlInn6z9jlHfx5YvjQFI1CGxNM0hPhowQo3HfQeqWrJYrHRxl3hc3urw
 M5o5hW7D5bqB9k+HCcHXCJ3pFalGygY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-Uq7fkkRfOI2_smjcC-lk4w-1; Tue, 12 Mar 2024 17:04:50 -0400
X-MC-Unique: Uq7fkkRfOI2_smjcC-lk4w-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-29baacab848so208450a91.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 14:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710277489; x=1710882289;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cH8teo+mlmEzIzYAPkrD2P4DvAuQ/xYWJSImlRLo00M=;
 b=CrdoS3dwI7/h97CcgUYQHJvW/VRSlk0UIIUajB3VW6k+Al8VYg6i060Mpybk1jgggv
 d29GdE11G1gzbFhW3CxpG4Rh0mtsIOar6PyrRzHDQJp9abOBvNY+2P8rxF0ofMdAyDeS
 JPlaqGLxO1mrv8BBQYgpW4NqCEJ6AasZxYmEHfhHEIwaE07TfwqBQr3gsXJQSsKhYCA2
 I4lEnGZ4nOiltY1IHMpIzEI9JnzFWFIxQqvm/OSutcGJueDGOcO++jLVQxzavR1jLfyq
 4LBPe6T55ktRZTDjhqDsLCKuW8LPoMuw8ze0SougQ927gW1hdnd7wWBfygs0hwA9jRx0
 dF2w==
X-Gm-Message-State: AOJu0YwokApYSqEyQ8w7dZxg+z01tFnruMFv8MM3GUQfKbRVLgt5dxy3
 4+Wi0IVlK9GP4cDnv0lN1xbrvU651vkajfJClYh521oAzjEsNZdo6G8yBLE2MZtV+0Ud47AiBon
 a1Z9jsLcik+RKf29VpYFjtbDTWE9v4xmZpYGqLt+B0DbdS0eU5g7WE7E8WcdHo6vooNfdoiDzRx
 kn+66FzSQdwdbVZemVEYgs+yIWleU=
X-Received: by 2002:a17:903:40d2:b0:1dd:c18f:1886 with SMTP id
 t18-20020a17090340d200b001ddc18f1886mr1924427pld.65.1710277489117; 
 Tue, 12 Mar 2024 14:04:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHU1TTCz8GPm1naYFkejl2fVBcKzxSbMeQTmLhY5CXEo3YwzbJiHiFrjvdlAO2RcHv+PdZJacmqycTVn7UAjo=
X-Received: by 2002:a17:903:40d2:b0:1dd:c18f:1886 with SMTP id
 t18-20020a17090340d200b001ddc18f1886mr1924407pld.65.1710277488815; Tue, 12
 Mar 2024 14:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240201224246.39480-1-jsnow@redhat.com>
 <20240201224246.39480-14-jsnow@redhat.com>
 <87cysr9scs.fsf@pond.sub.org>
In-Reply-To: <87cysr9scs.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 12 Mar 2024 17:04:37 -0400
Message-ID: <CAFn=p-ZBPeqQr7oPxpXBuU8jr8+zzY96757Ctc33qJPDVLKiOQ@mail.gmail.com>
Subject: Re: [PATCH v3 13/20] qapi/schema: split "checked" field into
 "checking" and "checked"
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Feb 20, 2024 at 8:29=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > Instead of using the None value for the members field, use a dedicated
> > "checking" value to detect recursive misconfigurations.
> >
> > This is intended to assist with subsequent patches which will seek to
> > remove the "None" value from the members field (which can never be set
> > legally after the final call to check()) in order to simplify static
> > typing of that field, by avoiding needing assertions littered at many
> > callsites.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/schema.py | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> > index d4d3c3bbcee..a459016e148 100644
> > --- a/scripts/qapi/schema.py
> > +++ b/scripts/qapi/schema.py
> > @@ -458,19 +458,21 @@ def __init__(self, name, info, doc, ifcond, featu=
res,
> >          self.local_members =3D local_members
> >          self.variants =3D variants
> >          self.members =3D None
> > +        self._checking =3D False
> >
> >      def check(self, schema):
> >          # This calls another type T's .check() exactly when the C
> >          # struct emitted by gen_object() contains that T's C struct
> >          # (pointers don't count).
> > -        if self.members is not None:
> > -            # A previous .check() completed: nothing to do
> > -            return
> > -        if self._checked:
> > +        if self._checking:
> >              # Recursed: C struct contains itself
> >              raise QAPISemError(self.info,
> >                                 "object %s contains itself" % self.name=
)
> > +        if self._checked:
> > +            # A previous .check() completed: nothing to do
> > +            return
>
> The diff would be easier to read if you could keep the order...  You
> don't due to the subtle change of the state predicates.  More on that
> below.
>
> >
> > +        self._checking =3D True
> >          super().check(schema)
> >          assert self._checked and self.members is None
> >
> > @@ -495,7 +497,8 @@ def check(self, schema):
> >              self.variants.check(schema, seen)
> >              self.variants.check_clash(self.info, seen)
> >
> > -        self.members =3D members  # mark completed
> > +        self.members =3D members
> > +        self._checking =3D False  # mark completed
> >
> >      # Check that the members of this type do not cause duplicate JSON =
members,
> >      # and update seen to track the members seen so far. Report any err=
ors
>
> We .check() entities on after the other.  *Except*
> QAPISchemaObjectType.check() "calls another type T's .check() exactly
> when the C struct emitted by gen_object() contains that T's C struct".
> If the recursion loops, the schema asks for C structs containing
> themselves.  To catch this, we have QAPISchemaType objects go through
> three states:
>
> 1. Not yet checked.
>
> 2. Being checked; object.check() is on the call stack.
>
> 3. Checked, i.e. object.check() completed.
>
> How to recognize the states before the patch:
>
> 1. not ._checked and .members is None
>
> 2. ._checked and .members is None
>
> 3. ._checked and .members is not None
>
>    Since .members is not None implies .checked, we simply use
>    .members is not None.
>
> We go from state 1. to 2. in super().check().
>
> We go from state 2. to 3. at # mark completed.
>
> Note that .checked becomes true well before we finish checking.  This is
> admittedly confusing.  If you can think of a less confusing name, ...

"checking", of course ;)

I won't change it here, but... that's what I'd be drawn to ...

>
> The patch's aim is to avoid use of .members, to enable the next patch.
>
> I don't doubt that your solution works, but trying to understand how it
> works makes my tired brain go owww!
>
> State invariants (I think):
>
> 1. not ._checked and .members is None and not ._checking
>
> 2. ._checked and .members is None and ._checking
>
> 3. ._checked and .members is not None and not ._checking
>
> We can then recognize states without use of .members:
>
> 1. not ._checked and not ._checking
>
>    Since not ._checked implies not .checking, we can simply use
>    not ._checked.
>
> 2. ._checked and ._checking
>
>    A deliciously confusing predicate, isn't it?
>
> 3. ._checked and not ._checking
>
> Deep breath...  alright, here's the stupidest replacement for use of
> .members that could possibly work: add a flag, ensure it's True exactly
> when .members is not None.  Like this:

OK, sure. As long as the next patch also shakes out just fine...

>
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index d4d3c3bbce..095831baf2 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -458,12 +458,13 @@ def __init__(self, name, info, doc, ifcond, feature=
s,
>          self.local_members =3D local_members
>          self.variants =3D variants
>          self.members =3D None
> +        self._check_complete =3D False
>
>      def check(self, schema):
>          # This calls another type T's .check() exactly when the C
>          # struct emitted by gen_object() contains that T's C struct
>          # (pointers don't count).
> -        if self.members is not None:
> +        if self._check_complete:
>              # A previous .check() completed: nothing to do
>              return
>          if self._checked:
> @@ -495,7 +496,8 @@ def check(self, schema):
>              self.variants.check(schema, seen)
>              self.variants.check_clash(self.info, seen)
>
> -        self.members =3D members  # mark completed
> +        self.members =3D members
> +        self._check_complete =3D True  # mark completed
>
>      # Check that the members of this type do not cause duplicate JSON me=
mbers,
>      # and update seen to track the members seen so far. Report any error=
s
>
>
> Thoughts?
>


