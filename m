Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45515CD11C2
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbST-00019l-89; Tue, 19 Mar 2024 11:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rmbSO-00017x-S0
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:32:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rmbSL-00039M-8h
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:32:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710862368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V0Y6pFLbRXsgygkfoGIXNA6pa4F4yqsGm07wH5k2a18=;
 b=PVH/6FPWjCtNaNhjkDEmaDVfzob/o+2qf+LxYPyTsoOBEqWqOd6kQkyL0ThiIUMR7+nEM1
 A3kPpD+6NviZtdWqbF43sHMDHVbMViJYMwchKt2G997ypGU6RdTnu3ORWhxmaAzZICZbso
 vkmqUaXHconRIWhZPM9VazQ9TOqQynw=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-wRhIRStwN0O0kqCZDTe1gg-1; Tue, 19 Mar 2024 11:32:43 -0400
X-MC-Unique: wRhIRStwN0O0kqCZDTe1gg-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5c65e666609so4970612a12.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 08:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710862363; x=1711467163;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V0Y6pFLbRXsgygkfoGIXNA6pa4F4yqsGm07wH5k2a18=;
 b=OzVA9+3cfSSntK+hNf8LZN2lL6uMhnY7vurLErrKZn+Qe6gx8lKC+zr5v4JYuDNtHH
 Z6By9GDZTJhdTinJSmLa7Hb6HHQYOWyaGSJ7UGhAEMNIOU1kJAe/SncBrimkcEqmjPYL
 2JSufN84B6nP/Lnm8fvIntHgPO3FVQnMfc01Yd/0Xt1nnNy6O3LkjbbI0MqTsAaB2HPL
 gZKNyTSgmsIIdEZFlCeorcgxG/2qeGLcUP3FfHfZGBXcUhhk26Rcuuo+ezjFLvjsCQgz
 o+RuvlboRQb9C56Qz57hdFr5Psemdyd+2iruuPS7UnZR9nS4MJpkalIctpRX7DyJuYJS
 BVOQ==
X-Gm-Message-State: AOJu0Yy3Krs1JyMrj4aa9ICvntk36Bj/cMmoREUOyd+pzBQ1i7R1XwwQ
 i0AHvBNZ+oKd3eDXOR6wWmK3aWrthqGQUGsY9p6Vmo0U1qTQ0/U06UzRZPcamS8YRateNEXiQuc
 f9q5HDuZuy1ctHSTuuBbQQjP8Bt3w9N4WX8FBkdQfmuXPSf3tSyDIvpjs5XgsEWrdTuMo8wKztw
 D0BoYSQ1fYpu27zzUpVhrxcSThtsc=
X-Received: by 2002:a17:90a:6d01:b0:29b:c9ac:c563 with SMTP id
 z1-20020a17090a6d0100b0029bc9acc563mr13320685pjj.19.1710862362741; 
 Tue, 19 Mar 2024 08:32:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcZwEOd7WKHYD3aDBiAueREF/HiG3NArGO1zCjXVYEGmf9PNL9p4+IVjb+5/jwL7VwHs7Dw6aFfL7y2S/ToZc=
X-Received: by 2002:a17:90a:6d01:b0:29b:c9ac:c563 with SMTP id
 z1-20020a17090a6d0100b0029bc9acc563mr13320621pjj.19.1710862361654; Tue, 19
 Mar 2024 08:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240315152301.3621858-1-armbru@redhat.com>
 <20240315152301.3621858-26-armbru@redhat.com>
In-Reply-To: <20240315152301.3621858-26-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 19 Mar 2024 11:32:29 -0400
Message-ID: <CAFn=p-aVawvAWicGZFkbPFqRQghJ33y7Gi0pUW=S5o9jWm+6wg@mail.gmail.com>
Subject: Re: [PATCH v5 25/25] qapi: Dumb down QAPISchema.lookup_entity()
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="0000000000005399d90614052f81"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--0000000000005399d90614052f81
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024, 11:23=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> QAPISchema.lookup_entity() takes an optional type argument, a subtype
> of QAPISchemaDefinition, and returns that type or None.  Callers can
> use this to save themselves an isinstance() test.
>
> The only remaining user of this convenience feature is .lookup_type().
> But we don't actually save anything anymore there: we still the
> isinstance() to help mypy over the hump.
>
> Drop the .lookup_entity() argument, and adjust .lookup_type().
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi/schema.py | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index a6180f93c6..5924947fc3 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -1157,20 +1157,14 @@ def _def_definition(self, defn:
> QAPISchemaDefinition) -> None:
>                  defn.info, "%s is already defined" %
> other_defn.describe())
>          self._entity_dict[defn.name] =3D defn
>
> -    def lookup_entity(
> -        self,
> -        name: str,
> -        typ: Optional[type] =3D None,
> -    ) -> Optional[QAPISchemaDefinition]:
> -        ent =3D self._entity_dict.get(name)
> -        if typ and not isinstance(ent, typ):
> -            return None
> -        return ent
> +    def lookup_entity(self,name: str) -> Optional[QAPISchemaEntity]:
> +        return self._entity_dict.get(name)
>
>      def lookup_type(self, name: str) -> Optional[QAPISchemaType]:
> -        typ =3D self.lookup_entity(name, QAPISchemaType)
> -        assert typ is None or isinstance(typ, QAPISchemaType)
> -        return typ
> +        typ =3D self.lookup_entity(name)
> +        if isinstance(typ, QAPISchemaType):
> +            return typ
> +        return None
>
>      def resolve_type(
>          self,
> --
> 2.44.0
>

Sure, dealer's choice.

with your commit message fixup:

Reviewed-by: John Snow <jsnow@redhat.com>

>

--0000000000005399d90614052f81
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, Mar 15, 2024, 11:23=E2=80=AFAM Markus Armbrust=
er &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">QAPISchema.lookup_entity() takes =
an optional type argument, a subtype<br>
of QAPISchemaDefinition, and returns that type or None.=C2=A0 Callers can<b=
r>
use this to save themselves an isinstance() test.<br>
<br>
The only remaining user of this convenience feature is .lookup_type().<br>
But we don&#39;t actually save anything anymore there: we still the<br>
isinstance() to help mypy over the hump.<br>
<br>
Drop the .lookup_entity() argument, and adjust .lookup_type().<br>
<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;<br>
---<br>
=C2=A0scripts/qapi/schema.py | 18 ++++++------------<br>
=C2=A01 file changed, 6 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py<br>
index a6180f93c6..5924947fc3 100644<br>
--- a/scripts/qapi/schema.py<br>
+++ b/scripts/qapi/schema.py<br>
@@ -1157,20 +1157,14 @@ def _def_definition(self, defn: QAPISchemaDefinitio=
n) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"ht=
tp://defn.info" rel=3D"noreferrer noreferrer" target=3D"_blank">defn.info</=
a>, &quot;%s is already defined&quot; % other_defn.describe())<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._entity_dict[<a href=3D"http://defn.=
name" rel=3D"noreferrer noreferrer" target=3D"_blank">defn.name</a>] =3D de=
fn<br>
<br>
-=C2=A0 =C2=A0 def lookup_entity(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 name: str,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 typ: Optional[type] =3D None,<br>
-=C2=A0 =C2=A0 ) -&gt; Optional[QAPISchemaDefinition]:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ent =3D self._entity_dict.get(name)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if typ and not isinstance(ent, typ):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return None<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ent<br>
+=C2=A0 =C2=A0 def lookup_entity(self,name: str) -&gt; Optional[QAPISchemaE=
ntity]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self._entity_dict.get(name)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def lookup_type(self, name: str) -&gt; Optional[QAPISch=
emaType]:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 typ =3D self.lookup_entity(name, QAPISchemaTyp=
e)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert typ is None or isinstance(typ, QAPISche=
maType)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return typ<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 typ =3D self.lookup_entity(name)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if isinstance(typ, QAPISchemaType):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return typ<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return None<br>
<br>
=C2=A0 =C2=A0 =C2=A0def resolve_type(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self,<br>
-- <br>
2.44.0<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"=
auto">Sure, dealer&#39;s choice.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">with your commit message fixup:</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">Reviewed-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat=
.com">jsnow@redhat.com</a>&gt;</div><div dir=3D"auto"><div class=3D"gmail_q=
uote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--0000000000005399d90614052f81--


