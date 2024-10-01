Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196FACEACD5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 15:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sveiG-0000vM-KI; Tue, 01 Oct 2024 11:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sveiE-0000v0-TE; Tue, 01 Oct 2024 11:22:54 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sveiD-0004Ga-87; Tue, 01 Oct 2024 11:22:54 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-45830ff5b70so48667661cf.1; 
 Tue, 01 Oct 2024 08:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727796172; x=1728400972; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5r+8l6d1yc4+rx/9n55Z20Fjh7fS7wMTmjiWQnu0O8Y=;
 b=PKazP9x8akZ9b8zmhD3vvoysAADfBU3yLfirmRKFXlzGfp0E62/d59uEbA++tsyJpI
 rqN2A92X8tSj293H4Ji+pulo4HTgpyUF4jvAECqi0YB06kK89KjlsHWAp90bLtYKmDI0
 ayKChB+e+VzGzkQzYDF9HrreEgdm6VrGCMkq8Lpvp6oq1VQAkWJFk1/uld2DYf+eJeUQ
 r7l5vtEwLgaYxJaL0vGX05BMR71cwJC4zGmAIPQ5B5EYYpZFHzUtDsmS2YlD3vdOTYBI
 xxcOYFXUBWWFVcBjHZTB+IN/J2SZXDQ/ghyQemzsv4Cdy/mtfEdgCdSKTIllzDVG5U3V
 yZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727796172; x=1728400972;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5r+8l6d1yc4+rx/9n55Z20Fjh7fS7wMTmjiWQnu0O8Y=;
 b=WtNa0rEExj6R5LNdp1Yv0RATjmYYlsanizmrzbDobBsjB7QE3HJITCu8+rqnRasS63
 0zhTI+3TL7GIlBWk0sZbE22mwdRgkCkrnyixrhliYsxLI7txKUjWk55M95roj9GnNFVZ
 A9TNOO7Jc8T5qQBnaybYiCiCBr7nlp/npu6ww/NqRRKpwkll5WjIekSpKHHcnSvUtqiP
 /AyYdvUwWh0/5IkdtvvMqV9zzpMbH6R64w0EP4GZJ/fK0yJmSd37Wzv5J83dvbkjiV6e
 7Gb3d8dekLTVzzGT1zcBPKd6xaVCkBq7jmSB2ezQIDvnjojHr+TZDlmPlqYdKG0cmugZ
 Kv0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5vWCThoi6X84rVnxs/jS8fddYfQHXORRTtfLvkXouN4UAIK78Ah9aayftuE3O2wLjlipitb6cjgxZ@nongnu.org
X-Gm-Message-State: AOJu0YxJEQw1fnb/hJ1lLN7JWzl253lQ09fuJcBRXwrPIkLI95qvK+tT
 t9QHKZW8ird3hLrpHcf0grNi3ic6+/SyNV1EDrZjshPxe6rEJL1xQRuJLya8zvW+eNJGctapRpO
 cNypNTbczMMOEskAINhVjbu7vRM4=
X-Google-Smtp-Source: AGHT+IF8SOPwZxnvk7risdSDQLSXO34a+DpJmuvtx0tpj3liJW3CDuI/JHTCqkyQXlLeiOgoSeXDDa3hM1UiqAIF+B8=
X-Received: by 2002:a05:622a:d1:b0:458:34df:1e6a with SMTP id
 d75a77b69052e-45c9f292b5bmr255834181cf.48.1727796171604; Tue, 01 Oct 2024
 08:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240930081458.1926382-1-marcandre.lureau@redhat.com>
 <20240930081458.1926382-22-marcandre.lureau@redhat.com>
 <c02e70b2-c76a-49ff-844d-3e8b66a4fe3b@yandex-team.ru>
In-Reply-To: <c02e70b2-c76a-49ff-844d-3e8b66a4fe3b@yandex-team.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 1 Oct 2024 19:22:40 +0400
Message-ID: <CAJ+F1C+n3NJDmSP53o9p6qZvPnVzKv20rB0_U7vn+8JRq0Rc0A@mail.gmail.com>
Subject: Re: [PATCH v3 21/22] qom/object: fix -Werror=maybe-uninitialized
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Fam Zheng <fam@euphon.net>,
 Song Gao <gaosong@loongson.cn>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, 
 qemu-block@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
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
Content-Type: multipart/alternative; boundary="0000000000000d8b4506236be51b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000000d8b4506236be51b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vladimir

On Tue, Oct 1, 2024 at 6:06=E2=80=AFPM Vladimir Sementsov-Ogievskiy <
vsementsov@yandex-team.ru> wrote:

> On 30.09.24 11:14, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > object_resolve_path_type() didn't always set *ambiguousp.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   qom/object.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/qom/object.c b/qom/object.c
> > index 28c5b66eab..bdc8a2c666 100644
> > --- a/qom/object.c
> > +++ b/qom/object.c
> > @@ -2201,6 +2201,9 @@ Object *object_resolve_path_type(const char *path=
,
> const char *typename,
> >           }
> >       } else {
> >           obj =3D object_resolve_abs_path(object_get_root(), parts + 1,
> typename);
> > +        if (ambiguousp) {
> > +            *ambiguousp =3D false;
> > +        }
>
> Doesn't this hunk in isolation fix the issue? With this
> object_resolve_path_type() should set the pointer on all paths if it is
> non-null..
>
>


> Hmm, called object_resolve_partial_path() also doesn't set ambiguous on
> every path, so this hunk is at lease incomplete.
>

yeah, but object_resolve_path_type() initializes it.

I'm unsure about what semantics expected around ambigous pointers, but it
> seems to me that it is set only on failure paths, as a reason, why we
> failed. If this is true, I think, we need only the second hunk, which
> initializes local "ambig".
>
>
right, and that seems good enough.

Do you ack/rb this change then?


    qom/object: fix -Werror=3Dmaybe-uninitialized

    object_resolve_path_type() didn't always set *ambiguousp.

    Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

diff --git a/qom/object.c b/qom/object.c
index 28c5b66eab..d3d3003541 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2226,7 +2226,7 @@ Object *object_resolve_path_at(Object *parent, const
char *path)

 Object *object_resolve_type_unambiguous(const char *typename, Error **errp=
)
 {
-    bool ambig;
+    bool ambig =3D false;
     Object *o =3D object_resolve_path_type("", typename, &ambig);

     if (ambig) {


thanks!


> >       }
> >
> >       g_strfreev(parts);
> > @@ -2226,7 +2229,7 @@ Object *object_resolve_path_at(Object *parent,
> const char *path)
> >
> >   Object *object_resolve_type_unambiguous(const char *typename, Error
> **errp)
> >   {
> > -    bool ambig;
> > +    bool ambig =3D false;
> >       Object *o =3D object_resolve_path_type("", typename, &ambig);
> >
> >       if (ambig) {
>
> --
> Best regards,
> Vladimir
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000000d8b4506236be51b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Vladimir<br></div><br><div><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 1, 2024 =
at 6:06=E2=80=AFPM Vladimir Sementsov-Ogievskiy &lt;<a href=3D"mailto:vseme=
ntsov@yandex-team.ru" target=3D"_blank">vsementsov@yandex-team.ru</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 30.09.2=
4 11:14, <a href=3D"mailto:marcandre.lureau@redhat.com" target=3D"_blank">m=
arcandre.lureau@redhat.com</a> wrote:<br>
&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
&gt; <br>
&gt; object_resolve_path_type() didn&#39;t always set *ambiguousp.<br>
&gt; <br>
&gt; Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.=
lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br=
>
&gt; ---<br>
&gt;=C2=A0 =C2=A0qom/object.c | 5 ++++-<br>
&gt;=C2=A0 =C2=A01 file changed, 4 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/qom/object.c b/qom/object.c<br>
&gt; index 28c5b66eab..bdc8a2c666 100644<br>
&gt; --- a/qom/object.c<br>
&gt; +++ b/qom/object.c<br>
&gt; @@ -2201,6 +2201,9 @@ Object *object_resolve_path_type(const char *pat=
h, const char *typename,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0obj =3D object_resolve_abs_pat=
h(object_get_root(), parts + 1, typename);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ambiguousp) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *ambiguousp =3D false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
Doesn&#39;t this hunk in isolation fix the issue? With this object_resolve_=
path_type() should set the pointer on all paths if it is non-null..<br>
<br></blockquote><div><br></div><div>=C2=A0<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
Hmm, called object_resolve_partial_path() also doesn&#39;t set ambiguous on=
 every path, so this hunk is at lease incomplete.<br></blockquote><div><br>=
</div><div>yeah, but object_resolve_path_type() initializes it.</div><div><=
br> </div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
I&#39;m unsure about what semantics expected around ambigous pointers, but =
it seems to me that it is set only on failure paths, as a reason, why we fa=
iled. If this is true, I think, we need only the second hunk, which initial=
izes local &quot;ambig&quot;.<br>
<br></blockquote><div><br></div><div>right, and that seems good enough.</di=
v><div><br></div><div>Do you ack/rb this change then?<br></div><div><br></d=
iv><div><br>=C2=A0 =C2=A0 qom/object: fix -Werror=3Dmaybe-uninitialized<br>=
=C2=A0 =C2=A0 <br>=C2=A0 =C2=A0 object_resolve_path_type() didn&#39;t alway=
s set *ambiguousp.<br>=C2=A0 =C2=A0 <br>=C2=A0 =C2=A0 Signed-off-by: Marc-A=
ndr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcand=
re.lureau@redhat.com</a>&gt;<br><br>diff --git a/qom/object.c b/qom/object.=
c<br>index 28c5b66eab..d3d3003541 100644<br>--- a/qom/object.c<br>+++ b/qom=
/object.c<br>@@ -2226,7 +2226,7 @@ Object *object_resolve_path_at(Object *p=
arent, const char *path)<br>=C2=A0<br>=C2=A0Object *object_resolve_type_una=
mbiguous(const char *typename, Error **errp)<br>=C2=A0{<br>- =C2=A0 =C2=A0b=
ool ambig;<br>+ =C2=A0 =C2=A0bool ambig =3D false;<br>=C2=A0 =C2=A0 =C2=A0O=
bject *o =3D object_resolve_path_type(&quot;&quot;, typename, &amp;ambig);<=
br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0if (ambig) {</div><div><br></div><div><br>=
</div><div>thanks!<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0g_strfreev(parts);<br>
&gt; @@ -2226,7 +2229,7 @@ Object *object_resolve_path_at(Object *parent, c=
onst char *path)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0Object *object_resolve_type_unambiguous(const char *typena=
me, Error **errp)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 bool ambig;<br>
&gt; +=C2=A0 =C2=A0 bool ambig =3D false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Object *o =3D object_resolve_path_type(&quot=
;&quot;, typename, &amp;ambig);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ambig) {<br>
<br>
-- <br>
Best regards,<br>
Vladimir<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div></div>

--0000000000000d8b4506236be51b--

