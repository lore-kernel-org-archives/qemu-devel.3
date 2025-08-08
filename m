Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F69C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 08:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukINg-0001v2-RT; Fri, 08 Aug 2025 04:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ukINJ-0001mb-WD
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:22:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ukING-0000Fn-DL
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754641369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3DN2VvnkwUjYu78kHT6V3QVIkwubW97ABiUntNoWNSk=;
 b=MjuCvs8RRCjAUi2cTIlj63zSbGHSzQqJlDgt3OPF92Moh2tDphWgG5DmN5SfK6AkKhWNLx
 J3Gl6wiPIXXlOPdfmY19e/iHAcgHORm6xFYd8J0OnM7cnz6y0xquwu7squnxSouX+FqwXI
 OoZlO10pKaYTuZVT4US/N3dkywD2J/s=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-4j45HimTO2Ol41hY5WQP-w-1; Fri, 08 Aug 2025 04:22:46 -0400
X-MC-Unique: 4j45HimTO2Ol41hY5WQP-w-1
X-Mimecast-MFC-AGG-ID: 4j45HimTO2Ol41hY5WQP-w_1754641365
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-31effad1358so1769474a91.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 01:22:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754641365; x=1755246165;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3DN2VvnkwUjYu78kHT6V3QVIkwubW97ABiUntNoWNSk=;
 b=GabwFaucVVWgFe6986TSYnb16wNjCshudMOQB957X9odzUQbcfp5GvgOx5XK7g8hOX
 002VcoIMKlUraNB6nCOW7xf9tDZin+Rv7OmFNWwPVWLuOFJ68NMmUl0rX117imUZTJ3X
 LLu73owYZtVzX7IcapW4CgQxl5HwQWgJ4zx2OomV2ZmsnfF8sM6ddIzzuk6WJaD16Oeu
 kQ2zmVhYWyG5leiOoMwvWo81lt/7M0soYiEkAad2i8I9lVvUMqSCK/J2F/bwgfZTXzw2
 XWjK3BCPswLqnoSYLS3SLDbBA+kPF7srnZVuUGBrH23H+LwXns+cu+fgGAKBZ9ewynSl
 vp6Q==
X-Gm-Message-State: AOJu0YwA6MWqV1JcUixk3C8OFvRMsaeE3c7MpGifCo+cVamRJmv7fm+8
 EmF48vbi2Eun4PmEAMbwrNdidwEjGfS9ZQSUOE50CL2V1mYRHLQtre+Vv3v01hgoSEenHNxE75j
 CBt7MhHae1aPK/9m/esuiOXwWYmHGvyfdf2yA/ardDe46iPbGU+7J3MEL70fojWIPR/DHxr3O1r
 LLAiRjl/hkMGAfsqNgpGfIkKo9YEgxeZs=
X-Gm-Gg: ASbGncursxoXm5cDctCXqCHGBr8LUMrUUJZGltqC5nsHA7Ft1eOwrkHHvOzkVaji9+R
 tHbu54Xi8VyNMRF6lyM6xgqhzSdo+EENefDzueiM+f0zOjSXHbUFQMU6abuzb5d051vTfIbdZ1W
 q6svcJ37WQFfco0qT3ZaMPJA==
X-Received: by 2002:a17:90b:3a0c:b0:312:e73e:cded with SMTP id
 98e67ed59e1d1-3217562b0a5mr9001869a91.16.1754641365259; 
 Fri, 08 Aug 2025 01:22:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmH0DRoBGEFas6tnSaTZvZso2UFkiG0U47d2b4BOMc0tKZQQ1TtjTTmXzjtPa9CXVxmhlkC31Aru2XlXqB+oo=
X-Received: by 2002:a17:90b:3a0c:b0:312:e73e:cded with SMTP id
 98e67ed59e1d1-3217562b0a5mr9001843a91.16.1754641364807; Fri, 08 Aug 2025
 01:22:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250808080823.2638861-1-armbru@redhat.com>
 <20250808080823.2638861-8-armbru@redhat.com>
In-Reply-To: <20250808080823.2638861-8-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 8 Aug 2025 12:22:33 +0400
X-Gm-Features: Ac12FXwv5HNN_xrctYjYKK8fmecfy5R_08jOm66YTZ7YPA9SlqZKtzvM6FVnAsk
Message-ID: <CAMxuvawKyiqOPRNcouZxar+5+oXoOmcN0VtbY8VGi5MjKmJQWw@mail.gmail.com>
Subject: Re: [PATCH 07/12] ui/spice-core: Clean up error reporting
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, odaki@rsg.ci.i.u-tokyo.ac.jp
Content-Type: multipart/alternative; boundary="000000000000420a5b063bd64742"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

--000000000000420a5b063bd64742
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Aug 8, 2025 at 12:08=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> watch_add() reports _open_osfhandle() failure with
> error_setg(&error_warn, ...).
>
> I'm not familiar with Spice, so I can't say whether it will work after
> such a failure.  If it doesn't, then this should be an error.  If it
> does, then why bother the user with a warning that isn't actionable,
> and likely confusing?
>
> Regardless of that, error_setg_win32(&error_warn, ...) is undesirable
> just like error_setg(&error_fatal, ...) and error_setg(&error_abort,
> ...) are.  Replace by warn_report().
>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>


lgtm, thanks
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  ui/spice-core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/ui/spice-core.c b/ui/spice-core.c
> index 5992f9daec..97bdd171cd 100644
> --- a/ui/spice-core.c
> +++ b/ui/spice-core.c
> @@ -132,7 +132,8 @@ static SpiceWatch *watch_add(int fd, int event_mask,
> SpiceWatchFunc func, void *
>  #ifdef WIN32
>      fd =3D _open_osfhandle(fd, _O_BINARY);
>      if (fd < 0) {
> -        error_setg_win32(&error_warn, WSAGetLastError(), "Couldn't
> associate a FD with the SOCKET");
> +        warn_report("Couldn't associate a FD with the SOCKET: %s"
> +                    g_win32_error_message(WSAGetLastError()));
>          return NULL;
>      }
>  #endif
> --
> 2.49.0
>
>

--000000000000420a5b063bd64742
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 8, 2025 at 12:08=
=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armb=
ru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">watch_add() reports _open_osfhandle() failure with<br>
error_setg(&amp;error_warn, ...).<br>
<br>
I&#39;m not familiar with Spice, so I can&#39;t say whether it will work af=
ter<br>
such a failure.=C2=A0 If it doesn&#39;t, then this should be an error.=C2=
=A0 If it<br>
does, then why bother the user with a warning that isn&#39;t actionable,<br=
>
and likely confusing?<br>
<br>
Regardless of that, error_setg_win32(&amp;error_warn, ...) is undesirable<b=
r>
just like error_setg(&amp;error_fatal, ...) and error_setg(&amp;error_abort=
,<br>
...) are.=C2=A0 Replace by warn_report().<br>
<br>
Cc: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.co=
m" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank">armbru@redhat.com</a>&gt;<br></blockquote><div><br></div><=
div><br></div><div>lgtm, thanks</div><div>Reviewed-by: Marc-Andr=C3=A9 Lure=
au &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redh=
at.com</a>&gt;</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
---<br>
=C2=A0ui/spice-core.c | 3 ++-<br>
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/ui/spice-core.c b/ui/spice-core.c<br>
index 5992f9daec..97bdd171cd 100644<br>
--- a/ui/spice-core.c<br>
+++ b/ui/spice-core.c<br>
@@ -132,7 +132,8 @@ static SpiceWatch *watch_add(int fd, int event_mask, Sp=
iceWatchFunc func, void *<br>
=C2=A0#ifdef WIN32<br>
=C2=A0 =C2=A0 =C2=A0fd =3D _open_osfhandle(fd, _O_BINARY);<br>
=C2=A0 =C2=A0 =C2=A0if (fd &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(&amp;error_warn, WSAGetLastEr=
ror(), &quot;Couldn&#39;t associate a FD with the SOCKET&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 warn_report(&quot;Couldn&#39;t associate a FD =
with the SOCKET: %s&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_wi=
n32_error_message(WSAGetLastError()));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#endif<br>
-- <br>
2.49.0<br>
<br>
</blockquote></div></div>

--000000000000420a5b063bd64742--


