Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDEFCD11C2
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbR3-0008Hm-Kt; Tue, 19 Mar 2024 11:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rmbQq-0008FS-65
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:31:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rmbQl-0002ZI-Q0
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710862267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iGWjjGr997LVBjLLFPRncequwPhUDZF7nClH4loSotw=;
 b=CfIn1vU0OuWhCe64n8mMcNypS6TG5gr3eqmh2FsDSWzgTL/Fhg6Hxj52Skpv+7vta3XwIZ
 CeUzE3vwZsxpt2gVzchUwGCNkybnrHZWXAVqT2+1rMae+UGnAIbZM/1JZFt8lDNM/tgl0P
 84SO/BY4wH5RYWtI9jAyz4vgZd8RKlg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-IGITSao4Puy8th5kk6nuLg-1; Tue, 19 Mar 2024 11:31:04 -0400
X-MC-Unique: IGITSao4Puy8th5kk6nuLg-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-29dfa2c256fso3067009a91.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 08:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710862263; x=1711467063;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iGWjjGr997LVBjLLFPRncequwPhUDZF7nClH4loSotw=;
 b=FHsa5vj5erOS+jUwq4RkWlNKOlEgc9WmrxbDBXDqv+ZQ7glYaaAlskNr+biCHKukpq
 UWn0MHlXPFzP1z84WYPbILNQ/JH7kn8ReZD6z/kS6BxJXG4zarFFyVlvhx/sWZ8GOnv6
 429otMvzyeR7MouQuOdBmScFf7n9N7gUXUO9MploHBY/dpbiSuEIBV/4t9+7q/pCJ1gW
 OKdmtvx6jI6aj5H2iZ0MS7lmjEeEbIKAo2AcIjVYKcTkORNsrrta7ycyccq0/rz30OUb
 hwcBT5DAJgU6L2a6drybpmRnfFaW2Nh+1T8HNBIOBGCquT2P6DOOnbW5Tk0R380veiZj
 TPPw==
X-Gm-Message-State: AOJu0Yzn7eBRmiCgoHj5gV/Qc+Re145nGzp8J4eIwsoM2ASnKOxS881F
 5zOXbCe4i3SG6pbcUeRT/YPBKD6uI+yXXdapYBbG52YYl0fe3MLQ5xw9Rycr8HXv4N3c4hhL1qh
 KbI9DxoRL5hxQb05ozgumUeZtzuQm9qgnFADMy/SMId6q+l0FHRESoXEEtv/F1YRITIiyh1IbQM
 Twug0hJPh6Li6yZD5AZ58ErepVldc=
X-Received: by 2002:a17:90b:fcb:b0:29b:9f1e:ab2d with SMTP id
 gd11-20020a17090b0fcb00b0029b9f1eab2dmr13846953pjb.36.1710862263216; 
 Tue, 19 Mar 2024 08:31:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSBZg54i4mJwHW9TxEHgp7M4+jG1CeqJgBELlzEDbwABjm/OUBX61bW2/V6KTDwtGt5FwuZiFIYL8Lc3ygJJ4=
X-Received: by 2002:a17:90b:fcb:b0:29b:9f1e:ab2d with SMTP id
 gd11-20020a17090b0fcb00b0029b9f1eab2dmr13846927pjb.36.1710862262875; Tue, 19
 Mar 2024 08:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240315152301.3621858-1-armbru@redhat.com>
 <20240315152301.3621858-25-armbru@redhat.com>
In-Reply-To: <20240315152301.3621858-25-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 19 Mar 2024 11:30:50 -0400
Message-ID: <CAFn=p-YuKWRvGcxDApVt3kXg22c1YJDogWJG9g4AXud_tgbZag@mail.gmail.com>
Subject: Re: [PATCH v5 24/25] qapi: Tighten check whether implicit object type
 already exists
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000704bc506140529bd"
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

--000000000000704bc506140529bd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024, 11:23=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> Entities with names starting with q_obj_ are implicit object types.
> Therefore, QAPISchema._make_implicit_object_type()'s .lookup_entity()
> can only return a QAPISchemaObjectType.  Assert that.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi/schema.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index e52930a48a..a6180f93c6 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -1297,8 +1297,9 @@ def _make_implicit_object_type(
>              return None
>          # See also QAPISchemaObjectTypeMember.describe()
>          name =3D 'q_obj_%s-%s' % (name, role)
> -        typ =3D self.lookup_entity(name, QAPISchemaObjectType)
> +        typ =3D self.lookup_entity(name)
>          if typ:
> +            assert(isinstance(typ, QAPISchemaObjectType))
>              # The implicit object type has multiple users.  This can
>              # only be a duplicate definition, which will be flagged
>              # later.
> --
> 2.44.0
>

Seems obviously fine, though I don't suppose this narrowing will be
"remembered" by the type system. Do we care?

Reviewed-by: John Snow <jsnow@redhat.com>

>

--000000000000704bc506140529bd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, Mar 15, 2024, 11:23=E2=80=AFAM Markus Armbrust=
er &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">Entities with names starting with=
 q_obj_ are implicit object types.<br>
Therefore, QAPISchema._make_implicit_object_type()&#39;s .lookup_entity()<b=
r>
can only return a QAPISchemaObjectType.=C2=A0 Assert that.<br>
<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;<br>
---<br>
=C2=A0scripts/qapi/schema.py | 3 ++-<br>
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py<br>
index e52930a48a..a6180f93c6 100644<br>
--- a/scripts/qapi/schema.py<br>
+++ b/scripts/qapi/schema.py<br>
@@ -1297,8 +1297,9 @@ def _make_implicit_object_type(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return None<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# See also QAPISchemaObjectTypeMember.des=
cribe()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name =3D &#39;q_obj_%s-%s&#39; % (name, r=
ole)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 typ =3D self.lookup_entity(name, QAPISchemaObj=
ectType)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 typ =3D self.lookup_entity(name)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if typ:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(isinstance(typ, QAPISchem=
aObjectType))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# The implicit object type =
has multiple users.=C2=A0 This can<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# only be a duplicate defin=
ition, which will be flagged<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# later.<br>
-- <br>
2.44.0<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"=
auto">Seems obviously fine, though I don&#39;t suppose this narrowing will =
be &quot;remembered&quot; by the type system. Do we care?</div><div dir=3D"=
auto"><br></div><div dir=3D"auto">Reviewed-by: John Snow &lt;<a href=3D"mai=
lto:jsnow@redhat.com">jsnow@redhat.com</a>&gt;</div><div dir=3D"auto"><div =
class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"></blockquote></div></d=
iv></div>

--000000000000704bc506140529bd--


