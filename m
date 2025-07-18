Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0DE3C83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 08:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucgSm-0003Q5-E2; Fri, 18 Jul 2025 04:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1ucgSc-0003Lk-8y
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 04:28:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1ucgSV-00053z-PY
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 04:28:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752827324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7kY0hUzHy+1xksL8EsYzei/AzxcaJy0QGDXDCxTluJ4=;
 b=cxitjrzGIA9bY+OStS9RUoZx/+l4drcfFm5rzfMo/USyrXLkDiG8Th2bHgZ4mSdM9s3u8Z
 ePh3giu0nMRiYZ8EJIJ9TAtbxxm4ILgMlLoEK6xeYgQBJD6l4blELfgGETHbggkYbpqXrg
 cmDxEuUpE6a0o+hSIR7Xbj4x4xPiyOE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-hOfxkIPkOeahuO3rtSvjSQ-1; Fri, 18 Jul 2025 04:28:42 -0400
X-MC-Unique: hOfxkIPkOeahuO3rtSvjSQ-1
X-Mimecast-MFC-AGG-ID: hOfxkIPkOeahuO3rtSvjSQ_1752827321
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ae3c8477f1fso128950066b.3
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 01:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752827321; x=1753432121;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7kY0hUzHy+1xksL8EsYzei/AzxcaJy0QGDXDCxTluJ4=;
 b=GDz9vYPuXqJB16bjBaNoci4rb7paIwjlTihFBuFLcOQgoPJExbhylV5NkmEF11XXzR
 EmkHyCF9zgv7u4ufH48KtxdbSide/9vYT8j2b6ERjijCOuzodIyW9O4io135SNeV4Mfp
 +7P7FFmmiTaTrcbb4W3JkAwBgXvLTNvRwCPuMjulUpmRicLSBpn8BaqlNqu5mpJQkGQT
 S2KRHGjeaaIeHDY2av411Bq5/RvSOMrPtLltA1SP8rJoOJED7LlX7kBs8lgYi/REOdvJ
 fdvaVWJ2gUPUVocul3Vm+NCQHIudcClnO3mIFpFWPCEzpdVxP7SzUDG9F5mNferfS7MH
 nL0A==
X-Gm-Message-State: AOJu0YzGP1RDO52YjPCCwJ/7dE+9j8e0Gq3uOy6Wq/RRQIVa+6JdDwS7
 Qt1uRmk4xQYkYLTHOF8mXsJBd9LNMK72QruOFeSjZE5uuU6pUgnwS2ZQ2ADMWhY3lP/QocALloi
 Bd6IE0jJEbFl8/3m/4EWApnemgjbksG4QjlrEIXLOYGCwaLbetSwnRzytnRPzY158NRQ8xKOIW0
 rpQrdf7Fe/QgSTSMz7esG2jcEIHahcrKk=
X-Gm-Gg: ASbGnct6W5vjNI//oEqsSlQNhmIik3ih7LdAkP7EJEjmmsWgJUeGmhJnyO66s5DXVi4
 y8zy7WgWKBC9rBz1g+6l5dVhTr3LzpkzrwOamryh2Cj6oP6tbvc1PbinFQXhq/uJU4VvNnyB4Xf
 USerWKnLtVp5Y1j7Vd12/u/Q==
X-Received: by 2002:a17:907:3c83:b0:ae3:bd92:e69b with SMTP id
 a640c23a62f3a-ae9c99814c7mr1034236766b.7.1752827321023; 
 Fri, 18 Jul 2025 01:28:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyEZj5EJqYckVvBSu8ghamCtIGS5k89o0krQiAjPuY0CyQfCfi/XKO91VzAFrzj9hUk58en8tNwTEwkvkY+aY=
X-Received: by 2002:a17:907:3c83:b0:ae3:bd92:e69b with SMTP id
 a640c23a62f3a-ae9c99814c7mr1034234666b.7.1752827320644; Fri, 18 Jul 2025
 01:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250716072854.13403-1-vsementsov@yandex-team.ru>
In-Reply-To: <20250716072854.13403-1-vsementsov@yandex-team.ru>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 18 Jul 2025 16:28:02 +0800
X-Gm-Features: Ac12FXyykOgvccBzN1fMtJt5A6vlz1KnOV4MqK5gM6xaArn92MJHiOAJpNTrBE4
Message-ID: <CAPpAL=wghDOvxdiprfTmB+B=PFMhz3Js3RmZqOq_KEV0xCzZ6Q@mail.gmail.com>
Subject: Re: [PATCH v2] net/tap: drop too small packets
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, d-tatianin@yandex-team.ru
Content-Type: multipart/alternative; boundary="000000000000cd11e3063a2fe9f2"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000cd11e3063a2fe9f2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this patch v2 again,everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Wed, Jul 16, 2025 at 3:29=E2=80=AFPM Vladimir Sementsov-Ogievskiy <
vsementsov@yandex-team.ru> wrote:

> Theoretically tap_read_packet() may return size less than
> s->host_vnet_hdr_len, and next, we'll work with negative size
> (in case of !s->using_vnet_hdr). Let's avoid it.
>
> Don't proceed with size =3D=3D s->host_vnet_hdr_len as well in case
> of !s->using_vnet_hdr, it doesn't make sense.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>
> v2: change "<" -> "<=3D"
>
>  net/tap.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/tap.c b/net/tap.c
> index 23536c09b46..2a859360193 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -190,6 +190,11 @@ static void tap_send(void *opaque)
>              break;
>          }
>
> +        if (s->host_vnet_hdr_len && size <=3D s->host_vnet_hdr_len) {
> +            /* Invalid packet */
> +            break;
> +        }
> +
>          if (s->host_vnet_hdr_len && !s->using_vnet_hdr) {
>              buf  +=3D s->host_vnet_hdr_len;
>              size -=3D s->host_vnet_hdr_len;
> --
> 2.48.1
>
>

--000000000000cd11e3063a2fe9f2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Tested this patch v2 again,everything works fine.<div><br>=
</div><div>Tested-by: Lei Yang &lt;<a href=3D"mailto:leiyang@redhat.com">le=
iyang@redhat.com</a>&gt;</div></div><br><div class=3D"gmail_quote gmail_quo=
te_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 16, 2025 at=
 3:29=E2=80=AFPM Vladimir Sementsov-Ogievskiy &lt;<a href=3D"mailto:vsement=
sov@yandex-team.ru">vsementsov@yandex-team.ru</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">Theoretically tap_read_packet(=
) may return size less than<br>
s-&gt;host_vnet_hdr_len, and next, we&#39;ll work with negative size<br>
(in case of !s-&gt;using_vnet_hdr). Let&#39;s avoid it.<br>
<br>
Don&#39;t proceed with size =3D=3D s-&gt;host_vnet_hdr_len as well in case<=
br>
of !s-&gt;using_vnet_hdr, it doesn&#39;t make sense.<br>
<br>
Signed-off-by: Vladimir Sementsov-Ogievskiy &lt;<a href=3D"mailto:vsementso=
v@yandex-team.ru" target=3D"_blank">vsementsov@yandex-team.ru</a>&gt;<br>
---<br>
<br>
v2: change &quot;&lt;&quot; -&gt; &quot;&lt;=3D&quot;<br>
<br>
=C2=A0net/tap.c | 5 +++++<br>
=C2=A01 file changed, 5 insertions(+)<br>
<br>
diff --git a/net/tap.c b/net/tap.c<br>
index 23536c09b46..2a859360193 100644<br>
--- a/net/tap.c<br>
+++ b/net/tap.c<br>
@@ -190,6 +190,11 @@ static void tap_send(void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;host_vnet_hdr_len &amp;&amp; size &l=
t;=3D s-&gt;host_vnet_hdr_len) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Invalid packet */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;host_vnet_hdr_len &amp;&amp; !s=
-&gt;using_vnet_hdr) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf=C2=A0 +=3D s-&gt;host_v=
net_hdr_len;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size -=3D s-&gt;host_vnet_h=
dr_len;<br>
-- <br>
2.48.1<br>
<br>
</blockquote></div>

--000000000000cd11e3063a2fe9f2--


