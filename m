Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25783C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 08:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukIGW-0003w8-Ai; Fri, 08 Aug 2025 04:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ukIGT-0003sL-0v
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:15:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ukIGR-0007jz-1z
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754640946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z1We8FZOjXDzh3ySDxMXyWzZs8CCH85L8wJ9/oGsg54=;
 b=jSSRDR4oZgOk6BSrJic7NsgOSnFh2AEdRqniyFrw+XS35bFW3T9ropbNcylYQewQqzx+ik
 cl1HkD1zbWN8D+eX5LNDXBSqbOEkU6K82p48FvZRKH4So3NJJabHC8el5nKGpIW1ZVZG69
 M7kiVkpY8P9Tq8Fqr+DTGYjqM0G0+n8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-CBvIsgzhMT2MZaKyGF9r9Q-1; Fri, 08 Aug 2025 04:15:44 -0400
X-MC-Unique: CBvIsgzhMT2MZaKyGF9r9Q-1
X-Mimecast-MFC-AGG-ID: CBvIsgzhMT2MZaKyGF9r9Q_1754640943
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-32129c65bf8so2319416a91.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 01:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754640943; x=1755245743;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z1We8FZOjXDzh3ySDxMXyWzZs8CCH85L8wJ9/oGsg54=;
 b=dRXc80b2sZCVJ0oyF6sbbfRpRS2I12ieDqjaBN93DF6xakTBLJKk5Er9BPqFMkRen7
 9ay4dl4h6ihR4c7SexmMa0ksp/aDZ2j6gG+UljxkwCw+xjMGprVlmMxEWIgi0ZffomnR
 IuKVQD5XCKRmQL2bMWq3nVOSY0VCGSVv7Fdv98dB2hw+i8kNNYNGNL+VuKr5O8LrMdlZ
 RQ5KqwfxYRV2mcX2QDou4MZ8mhnMSsQzkWSS53Z/pB9meIta541xnQlypFv2Z2K9wEnC
 dN/ARP8KrLgSaxRnUfkObXFKtqwmtd2MGT/I7lBXy2V+UzwoZ+I7oLTHProVNbHkAa0s
 EcDw==
X-Gm-Message-State: AOJu0Yy5dgxOh/7sCdWtM7QN0wnV2bHfe8HtktOeAonl5FSH05jN8w9o
 UdEalZF6w49vYYqQzoyWk4ZsWc3/P6t8XsoWkjiOkAMmt7xn9EhpvfuYtdI+3ycrTd2gPFJWEDn
 RBtYnbZE4PIE8oMTS6upcHD5/W1ctr5BBF2oRU+I8NZJRs5kkCwAUzwkjO/TehTVcZk+VtDr+B6
 Do5ydzq/bf4vN7fG09snC4J2vP+sApmoE=
X-Gm-Gg: ASbGnctrF84eVX2fk9PiFILGcWvPzUhW9R5K2Zhh2vZdDMjP8n63IkCiv0RNnsnMkNG
 wJzPR4S8pBjerBOA2m+HTra6l6PE452PBk31c/NFducYIzJ4y3oQsSG+SrFlh81Ls0h0zZv8Xxa
 FYpRkzs5TlDCmOusGa+LI+3g==
X-Received: by 2002:a17:90b:264d:b0:31e:9cdb:32df with SMTP id
 98e67ed59e1d1-321839e3179mr3145462a91.10.1754640943333; 
 Fri, 08 Aug 2025 01:15:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8XUT5hexNK1Kn1qo4pOKDiDEPVnGrXMRUhFUBAl1uLEiig64VtkDIBdD8CnKKhf2C4NCTGJdocrAfNzS8tcI=
X-Received: by 2002:a17:90b:264d:b0:31e:9cdb:32df with SMTP id
 98e67ed59e1d1-321839e3179mr3145426a91.10.1754640942854; Fri, 08 Aug 2025
 01:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250808080823.2638861-1-armbru@redhat.com>
 <20250808080823.2638861-12-armbru@redhat.com>
In-Reply-To: <20250808080823.2638861-12-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 8 Aug 2025 12:15:31 +0400
X-Gm-Features: Ac12FXxdR3Ijs97oIgXZEV_DIhVT9eaiTwLw9vi0Wdwpdt0BQohtd5cd9sDy-Ng
Message-ID: <CAMxuvaxDc=vDZpRK2QcuSVYnfdx7i+L6EGZzEPPvta+D=A7FFw@mail.gmail.com>
Subject: Re: [PATCH 11/12] ui/dbus: Consistent handling of texture mutex
 failure
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, odaki@rsg.ci.i.u-tokyo.ac.jp
Content-Type: multipart/alternative; boundary="0000000000001b8b0f063bd62e2b"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
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

--0000000000001b8b0f063bd62e2b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Aug 8, 2025 at 12:08=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> We report d3d_texture2d_acquire0() and d3d_texture2d_release0()
> failure as error, except in dbus_update_gl_cb(), where we report it as
> warning.  Report it as error there as well.
>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>

lgtm, thanks

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
>  ui/dbus-listener.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
> index 09d7a319b1..b82e7c7115 100644
> --- a/ui/dbus-listener.c
> +++ b/ui/dbus-listener.c
> @@ -214,26 +214,31 @@ static void dbus_update_gl_cb(GObject *source_objec=
t,
>                                GAsyncResult *res,
>                                gpointer user_data)
>  {
> -    g_autoptr(GError) err =3D NULL;
> +    g_autoptr(GError) gerr =3D NULL;
> +#ifdef WIN32
> +    Error **err =3D NULL;
> +#endif
>      DBusDisplayListener *ddl =3D user_data;
>      bool success;
>
>  #ifdef CONFIG_GBM
>      success =3D qemu_dbus_display1_listener_call_update_dmabuf_finish(
> -        ddl->proxy, res, &err);
> +        ddl->proxy, res, &gerr);
>      if (!success) {
> -        error_report("Failed to call update: %s", err->message);
> +        error_report("Failed to call update: %s", gerr->message);
>      }
>  #endif
>
>  #ifdef WIN32
>      success =3D
> qemu_dbus_display1_listener_win32_d3d11_call_update_texture2d_finish(
> -        ddl->d3d11_proxy, res, &err);
> +        ddl->d3d11_proxy, res, &gerr);
>      if (!success) {
> -        error_report("Failed to call update: %s", err->message);
> +        error_report("Failed to call update: %s", gerr->message);
>      }
>
> -    d3d_texture2d_acquire0(ddl->d3d_texture, &error_warn);
> +    if (!d3d_texture2d_acquire0(ddl->d3d_texture, &err)) {
> +        error_report_err(err);
> +    }
>  #endif
>
>      graphic_hw_gl_block(ddl->dcl.con, false);
> --
> 2.49.0
>
>

--0000000000001b8b0f063bd62e2b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 8, 2025 at 12:08=
=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armb=
ru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">We report d3d_texture2d_acquire0() and d3d_texture2d_release0(=
)<br>
failure as error, except in dbus_update_gl_cb(), where we report it as<br>
warning.=C2=A0 Report it as error there as well.<br>
<br>
Cc: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.co=
m" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank">armbru@redhat.com</a>&gt;<br></blockquote><div><br></div><=
div><div>lgtm, thanks</div><div><br></div><div>Reviewed-by: Marc-Andr=C3=A9=
 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau=
@redhat.com</a>&gt;</div><div><br></div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
---<br>
=C2=A0ui/dbus-listener.c | 17 +++++++++++------<br>
=C2=A01 file changed, 11 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c<br>
index 09d7a319b1..b82e7c7115 100644<br>
--- a/ui/dbus-listener.c<br>
+++ b/ui/dbus-listener.c<br>
@@ -214,26 +214,31 @@ static void dbus_update_gl_cb(GObject *source_object,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GAsyncResult *res,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gpointer user_data)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 g_autoptr(GError) err =3D NULL;<br>
+=C2=A0 =C2=A0 g_autoptr(GError) gerr =3D NULL;<br>
+#ifdef WIN32<br>
+=C2=A0 =C2=A0 Error **err =3D NULL;<br>
+#endif<br>
=C2=A0 =C2=A0 =C2=A0DBusDisplayListener *ddl =3D user_data;<br>
=C2=A0 =C2=A0 =C2=A0bool success;<br>
<br>
=C2=A0#ifdef CONFIG_GBM<br>
=C2=A0 =C2=A0 =C2=A0success =3D qemu_dbus_display1_listener_call_update_dma=
buf_finish(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ddl-&gt;proxy, res, &amp;err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ddl-&gt;proxy, res, &amp;gerr);<br>
=C2=A0 =C2=A0 =C2=A0if (!success) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Failed to call update: %s&q=
uot;, err-&gt;message);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Failed to call update: %s&q=
uot;, gerr-&gt;message);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#endif<br>
<br>
=C2=A0#ifdef WIN32<br>
=C2=A0 =C2=A0 =C2=A0success =3D qemu_dbus_display1_listener_win32_d3d11_cal=
l_update_texture2d_finish(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ddl-&gt;d3d11_proxy, res, &amp;err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ddl-&gt;d3d11_proxy, res, &amp;gerr);<br>
=C2=A0 =C2=A0 =C2=A0if (!success) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Failed to call update: %s&q=
uot;, err-&gt;message);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Failed to call update: %s&q=
uot;, gerr-&gt;message);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 d3d_texture2d_acquire0(ddl-&gt;d3d_texture, &amp;error_warn)=
;<br>
+=C2=A0 =C2=A0 if (!d3d_texture2d_acquire0(ddl-&gt;d3d_texture, &amp;err)) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(err);<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0#endif<br>
<br>
=C2=A0 =C2=A0 =C2=A0graphic_hw_gl_block(ddl-&gt;dcl.con, false);<br>
-- <br>
2.49.0<br>
<br>
</blockquote></div></div>

--0000000000001b8b0f063bd62e2b--


