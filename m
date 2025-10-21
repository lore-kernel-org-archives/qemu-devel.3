Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A7BCCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 07:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB79l-0002MP-77; Tue, 21 Oct 2025 03:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vB79k-0002MH-0s
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 03:51:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vB79h-0002cG-Vx
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 03:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761033097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CiJyKte1CnvRiE/5jsKSedxi4YJJ3247r8MZMSkeUz4=;
 b=dQ1wR7PWYbePUm99Jij7e7DmntgajmFV1hLGoM1kNIWwB/iD9IhBt7/4eLE9lkLPdyrbge
 jJIfeI9rPMfRWW2GUNg+xPdAkR7Ce8lIpTT388qShFd7yJSVlQxOef//vouaIlyCyE1zHl
 0HqqkDJEhvcHvlDd0O5/f8KzWzSx6N4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-duZugh3rOfm6dZQZ6UlDnA-1; Tue, 21 Oct 2025 03:51:36 -0400
X-MC-Unique: duZugh3rOfm6dZQZ6UlDnA-1
X-Mimecast-MFC-AGG-ID: duZugh3rOfm6dZQZ6UlDnA_1761033095
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-33d8970ae47so2562381a91.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 00:51:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761033094; x=1761637894;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CiJyKte1CnvRiE/5jsKSedxi4YJJ3247r8MZMSkeUz4=;
 b=CHhOglyWorPy/5djqM7oMdlOYgMew2V2AUhIJRWipMBi/YxHMUqvMormfg/ME9vSJ7
 MqBXATo0vRUG7KQou+rkN8IF8KR3kqePmy3rh8Mkw5usSLp3IEHSYgXwmFZgYE0KSSql
 ApUFkPKpUAnbGI4YQaaya8mxDTaaY32Ga5bgnpv8ZrlkRT0GEi5RjXE0YQGDmuAt2q32
 RguWb6YSQNc4EsdNngbmmlZS0gmRoDwtX50o0zgQA9W/jb9ec7g+L9G5BlZxiblsRdyj
 xSBINsMc2M21W+Q0WT32ou6/q6BQopxOAmyRyhIY7ohOK/8XhkcilMFxHIqKN0dgEqdl
 PnqQ==
X-Gm-Message-State: AOJu0YwMpemLZYIOBGoBbpq+Ec/4s7WgBqIvgz4aD9NWYhQpWCAb9C2F
 ZLEeYOe6fh1TRMUBkPXRFXpAmw8gWbrVFzGFO5CQO0bT8/18862u5Aqbhn93FiHYdwWJs+UQUNW
 pKFObJSJDY4nObCoXts5CvArdf3C2AMhWBEEwyGDeupwoHsqLh76EOJCKvHX7UHwqv4W6teBdic
 JD9/agcHw5suhImFQH7EOiQswxpkFmpIp0dYkLw9rcTg==
X-Gm-Gg: ASbGncvfHqQPZMtAg+UeCdxQ2erq0OFl56jMcXijCaDJzCjGz8qqwq3itYReIpBHU8Z
 oadt5WjfW9zlQl3AxOui3qosmhe5dx6q6RFZC04VLf/s+yQl6OOzE2rzETTVL+E6vPxwuGDgeLF
 MB3+HtqmEMDZo3ubxnToJDhNfuvzRzrNmylcuIQ+5jK3DpabJa/C5dF+QO3TlZV9Zi/xHkQXVD9
 YweZSBIMnlwy0o=
X-Received: by 2002:a17:90b:1d0e:b0:330:7a11:f111 with SMTP id
 98e67ed59e1d1-33bcf9222e2mr24183529a91.35.1761033094432; 
 Tue, 21 Oct 2025 00:51:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCM6914uI4d1xdNbZXstemoL3DS44Fl7Bl45yVofQzAlpBjJyu8569GCsKawvz/mmPdQSDk/4K06u2LP/oxvM=
X-Received: by 2002:a17:90b:1d0e:b0:330:7a11:f111 with SMTP id
 98e67ed59e1d1-33bcf9222e2mr24183497a91.35.1761033094068; Tue, 21 Oct 2025
 00:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20251015105419.2975542-1-marcandre.lureau@redhat.com>
In-Reply-To: <20251015105419.2975542-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 21 Oct 2025 11:51:22 +0400
X-Gm-Features: AS18NWAk_rF4zarqRDpoFBIt2D9BZV4D9bpgy3lmf-SlNSs1eSu4XRobyVJbfMg
Message-ID: <CAMxuvawQJ=psU+uWaH7T8eiSSbV8O9D5rMYw5tojJBteQTb-VQ@mail.gmail.com>
Subject: Re: [PATCH] RFC: qdev: add legacy properties only for those
 print()-able
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: multipart/alternative; boundary="00000000000002895d0641a678b9"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--00000000000002895d0641a678b9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

On Wed, Oct 15, 2025 at 2:54=E2=80=AFPM <marcandre.lureau@redhat.com> wrote=
:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The link properties are not printed in "info qtree", I don't know if
> this was intentional. We currently register legacy properties for
> link/ptr properties, but they don't have PropertyInfo getters (only
> ObjectPropertyAccessor, when using non-legacy properties)
>
> By not registering a (unusable?) legacy property, "info qtree" can now
> print the link.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>

Any objections?


> ---
>  hw/core/qdev-properties.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index b7e8a89ba5..fe260a9670 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -1143,14 +1143,13 @@ static void
> qdev_class_add_legacy_property(DeviceClass *dc, const Property *prop
>  {
>      g_autofree char *name =3D NULL;
>
> -    /* Register pointer properties as legacy properties */
> -    if (!prop->info->print && prop->info->get) {
> +    if (!prop->info->print) {
>          return;
>      }
>
>      name =3D g_strdup_printf("legacy-%s", prop->name);
>      object_class_property_add(OBJECT_CLASS(dc), name, "str",
> -        prop->info->print ? qdev_get_legacy_property : prop->info->get,
> +        qdev_get_legacy_property,
>          NULL, NULL, (Property *)prop);
>  }
>
> --
> 2.51.0
>
>

--00000000000002895d0641a678b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi!</div><br><div class=3D"gmail_quote gm=
ail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 15, =
2025 at 2:54=E2=80=AFPM &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">=
marcandre.lureau@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mail=
to:marcandre.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.c=
om</a>&gt;<br>
<br>
The link properties are not printed in &quot;info qtree&quot;, I don&#39;t =
know if<br>
this was intentional. We currently register legacy properties for<br>
link/ptr properties, but they don&#39;t have PropertyInfo getters (only<br>
ObjectPropertyAccessor, when using non-legacy properties)<br>
<br>
By not registering a (unusable?) legacy property, &quot;info qtree&quot; ca=
n now<br>
print the link.<br>
<br>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br></bl=
ockquote><div><br></div><div>Any objections?</div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0hw/core/qdev-properties.c | 5 ++---<br>
=C2=A01 file changed, 2 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c<br>
index b7e8a89ba5..fe260a9670 100644<br>
--- a/hw/core/qdev-properties.c<br>
+++ b/hw/core/qdev-properties.c<br>
@@ -1143,14 +1143,13 @@ static void qdev_class_add_legacy_property(DeviceCl=
ass *dc, const Property *prop<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0g_autofree char *name =3D NULL;<br>
<br>
-=C2=A0 =C2=A0 /* Register pointer properties as legacy properties */<br>
-=C2=A0 =C2=A0 if (!prop-&gt;info-&gt;print &amp;&amp; prop-&gt;info-&gt;ge=
t) {<br>
+=C2=A0 =C2=A0 if (!prop-&gt;info-&gt;print) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0name =3D g_strdup_printf(&quot;legacy-%s&quot;, prop-&g=
t;name);<br>
=C2=A0 =C2=A0 =C2=A0object_class_property_add(OBJECT_CLASS(dc), name, &quot=
;str&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;info-&gt;print ? qdev_get_legacy_prop=
erty : prop-&gt;info-&gt;get,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_legacy_property,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL, (Property *)prop);<br>
=C2=A0}<br>
<br>
-- <br>
2.51.0<br>
<br>
</blockquote></div></div>

--00000000000002895d0641a678b9--


