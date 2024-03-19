Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89668CD11C2
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:25:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbKj-0006RF-7g; Tue, 19 Mar 2024 11:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rmbKh-0006Qv-Sl
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:24:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rmbKg-0001QK-9F
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710861893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P5iZ9A1H2hAPKUK0OQWotwuY5hXUf0wEzUmR35o9c20=;
 b=MxMoy7g0loC0Ttsd01lkdI/XqNEu51mYiSEDSM2UtQzI+fPeGvQmPo9N2mwtgvYHXZi0S3
 yX8vxT443hbTK8MXYg3yQ0wqZ6DZPBKQeCebShlwO/nHE9TdtHrE98iJqvGxXXKdc6P7lP
 Co6acrUvcWTiphUiTYr3q1Qog2znV5c=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-hqlQMIPNOE21Waxenz0spA-1; Tue, 19 Mar 2024 11:24:50 -0400
X-MC-Unique: hqlQMIPNOE21Waxenz0spA-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5cec8bc5c66so3555183a12.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 08:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710861890; x=1711466690;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P5iZ9A1H2hAPKUK0OQWotwuY5hXUf0wEzUmR35o9c20=;
 b=mlGP3eO1AnZkBeKcJkwL0rBg7CsP+Qxrtmzan7N0pKDi9YTU3+RMMifMY5YoqaUyhy
 hi8ivVjQea+ZI8TRHdBy73r2XecgsnZQB6jKH5txch2R7OoJ32yqJDAmWc7BKSoooO/J
 cXxyCx5mO2CqrzlPWwGDPZnN7ueFT6K06tAQCjBS0VoNtOWvQAI1w90HDVnEaJr8NeBC
 RZQNmpy5UWt6EzGYoqowCSlwplBakWUw1m/bFFqOeTDB+4/vraOdoytWwW9tD4uPjOWz
 t0x8dBZ/3QqcuFh2Wfhmjv+PST1hQGXwKXqMh/RJAy7vYt0w7z5I7zEvxuAnOj43nWTs
 pomA==
X-Gm-Message-State: AOJu0Ywp1nfVjPpZ+LlK6PnjG+Wz3RN4Xx8mhejQY1Wex1+Z2wr5LcMS
 7469w01v7RwgKvtQiEMtr4ChFEcoXbA6TAVqyE7XV0EWHg3SsSzAryuHaJharE8hk0rYO6sFDAU
 NuECCe6rhRWYIPjDnz/tRN01gDFdrClgx8cWFxockJxqqhfcxagPkAU3P5QyhR+U4/wUGAYCNZr
 SPiDcSn1r2EYIqEpthjOs7KUZA2yc=
X-Received: by 2002:a17:90a:fd95:b0:29e:e0a:e8c8 with SMTP id
 cx21-20020a17090afd9500b0029e0e0ae8c8mr7789018pjb.5.1710861889902; 
 Tue, 19 Mar 2024 08:24:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsf+1r7qtBfwPXP+omtrJf0uim6X/H9ScZ5vgOx4Ab4v6xfPofxC+jPS5GsW6HNeJ+Rv9dPOCXrAYGjTF2fh8=
X-Received: by 2002:a17:90a:fd95:b0:29e:e0a:e8c8 with SMTP id
 cx21-20020a17090afd9500b0029e0e0ae8c8mr7789002pjb.5.1710861889535; Tue, 19
 Mar 2024 08:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240315152301.3621858-1-armbru@redhat.com>
 <20240315152301.3621858-13-armbru@redhat.com>
In-Reply-To: <20240315152301.3621858-13-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 19 Mar 2024 11:24:37 -0400
Message-ID: <CAFn=p-aoo3T8S-EOvHT8whMy=ov_qX4cAAHs5qtUN9Kbjh30Jg@mail.gmail.com>
Subject: Re: [PATCH v5 12/25] qapi: Assert built-in types exist
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="0000000000002fa2b70614051343"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
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

--0000000000002fa2b70614051343
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024, 11:24=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> QAPISchema.lookup_type('FOO') returns a QAPISchemaType when type 'FOO'
> exists, else None.  It won't return None for built-in types like
> 'int'.
>
> Since mypy can't see that, it'll complain that we assign the
> Optional[QAPISchemaType] returned by .lookup_type() to QAPISchemaType
> variables.
>
> Add assertions to help it over the hump.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi/introspect.py | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> index 67c7d89aae..4679b1bc2c 100644
> --- a/scripts/qapi/introspect.py
> +++ b/scripts/qapi/introspect.py
> @@ -227,10 +227,14 @@ def _use_type(self, typ: QAPISchemaType) -> str:
>
>          # Map the various integer types to plain int
>          if typ.json_type() =3D=3D 'int':
> -            typ =3D self._schema.lookup_type('int')
> +            type_int =3D self._schema.lookup_type('int')
> +            assert type_int
> +            typ =3D type_int
>          elif (isinstance(typ, QAPISchemaArrayType) and
>                typ.element_type.json_type() =3D=3D 'int'):
> -            typ =3D self._schema.lookup_type('intList')
> +            type_intList =3D self._schema.lookup_type('intList')
> +            assert type_intList
> +            typ =3D type_intList
>          # Add type to work queue if new
>          if typ not in self._used_types:
>              self._used_types.append(typ)
> --
> 2.44.0
>

Yeah, if you like this more, go ahead. I know it works because I did it
this way at one point!

Matter of taste and preference etc.

Reviewed-by: John Snow <jsnow@redhat.com>

>

--0000000000002fa2b70614051343
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, Mar 15, 2024, 11:24=E2=80=AFAM Markus Armbrust=
er &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">QAPISchema.lookup_type(&#39;FOO&#=
39;) returns a QAPISchemaType when type &#39;FOO&#39;<br>
exists, else None.=C2=A0 It won&#39;t return None for built-in types like<b=
r>
&#39;int&#39;.<br>
<br>
Since mypy can&#39;t see that, it&#39;ll complain that we assign the<br>
Optional[QAPISchemaType] returned by .lookup_type() to QAPISchemaType<br>
variables.<br>
<br>
Add assertions to help it over the hump.<br>
<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;<br>
---<br>
=C2=A0scripts/qapi/introspect.py | 8 ++++++--<br>
=C2=A01 file changed, 6 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py<br>
index 67c7d89aae..4679b1bc2c 100644<br>
--- a/scripts/qapi/introspect.py<br>
+++ b/scripts/qapi/introspect.py<br>
@@ -227,10 +227,14 @@ def _use_type(self, typ: QAPISchemaType) -&gt; str:<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Map the various integer types to plain =
int<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if typ.json_type() =3D=3D &#39;int&#39;:<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 typ =3D self._schema.lookup_type=
(&#39;int&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 type_int =3D self._schema.lookup=
_type(&#39;int&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert type_int<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 typ =3D type_int<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elif (isinstance(typ, QAPISchemaArrayType=
) and<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0typ.element_type.jso=
n_type() =3D=3D &#39;int&#39;):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 typ =3D self._schema.lookup_type=
(&#39;intList&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 type_intList =3D self._schema.lo=
okup_type(&#39;intList&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert type_intList<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 typ =3D type_intList<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Add type to work queue if new<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if typ not in self._used_types:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._used_types.append(typ=
)<br>
-- <br>
2.44.0<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"=
auto">Yeah, if you like this more, go ahead. I know it works because I did =
it this way at one point!=C2=A0</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Matter of taste and preference etc.</div><div dir=3D"auto"><br></=
div><div dir=3D"auto">Reviewed-by: John Snow &lt;<a href=3D"mailto:jsnow@re=
dhat.com">jsnow@redhat.com</a>&gt;</div><div dir=3D"auto"><div class=3D"gma=
il_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex"></blockquote></div></div></div>

--0000000000002fa2b70614051343--


