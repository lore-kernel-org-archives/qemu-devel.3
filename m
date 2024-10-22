Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB22D1CDD7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 10:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3CHG-0002F8-PR; Tue, 22 Oct 2024 06:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1t3CH8-0002Dr-Nl
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:38:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1t3CH6-00086f-Qp
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729593483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DYys+vRWOMnIu7PgKi0m5o10tmKC8NFFYb/cgfdQ9oE=;
 b=cotgUiDKH22r3JydzIP64rku926N8weFyFilmKyJRSoKPYyr4iw8pEhD21UziA4eQYSihP
 WlPJD0GQ6xB4+kvaBlmhL2IrKTt0Oq1DU8GzbQ3DmQQUMuWL8UsJFCaWTYX6P4sM8ukx1c
 qycfKeYJZ6mYR6g4E+h+AELakmHvZm8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-Yrp_lgJiMNGsXOhIO-_mBw-1; Tue, 22 Oct 2024 06:38:01 -0400
X-MC-Unique: Yrp_lgJiMNGsXOhIO-_mBw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a9a0c259715so373035566b.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 03:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729593480; x=1730198280;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DYys+vRWOMnIu7PgKi0m5o10tmKC8NFFYb/cgfdQ9oE=;
 b=N+xxlz/r3Mq5XCxElEEfVQF+2//yoamPVWfsK10l8tdgUHvP1qmwUcSp4iPW7MZj2I
 3ZdM83JxDqfvXbhJ5SeyLcvnLy+jZAnoTJYuA3rRpfKjOFqwPQYzpFRcyfqQnc8v3mB1
 3ELWbH3F/vFaBosqWQF6JngkY5CYRYkO7JZg7WZOJCgAe0iSc1CLlF39PScIfa2AFWQo
 RR4Y0X99Ug0hn2ppbpDuMyOM55hvlGE/nEEShsE3vq3mPTN5H5aKGIF9fjYpZ9Kb6IFO
 kXipStj4ItTpSdtQyNuoU+5p5GSiUx5pZbZhfh5mgrzc2c2bQFhXCaH2dQFuAdKZbwuh
 F33g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmVMP1HFfl3myfCPytn/IzdEEtxnXKatsHgtYWQsfx5qNJTej2/YajHdbpN9cmdAt5fkcsVFD5n6s4@nongnu.org
X-Gm-Message-State: AOJu0Yz5OpFIyN0X61H0vGlxUywKDI9BNroFhCmJB8vB8rwfRvwMZAVX
 f61ATwAYecRUz+JSR8g0s9kPsf6krujwpehfn7NJlkyzgCktZduEZOQg6re7Qb8+/c3MRos75Lx
 3J1+8psgc/ZzmkdAI+IgZ2Tpw5OJu3t8WFziAPj6vD61upiU/QhdxPXSifA1cQc+ZOukU8QVjz8
 C0w4prDLCbpNGQf2xKVh9zAhYW/94=
X-Received: by 2002:a17:907:d2a:b0:a9a:5e3a:641d with SMTP id
 a640c23a62f3a-a9aad376421mr149250666b.59.1729593479987; 
 Tue, 22 Oct 2024 03:37:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEejQiBOVZrZpYvrzd1GUFZ0j8/uWNjhjqSdHZRyzXE+SaArKMz6OhV6oEP3eyNvXVbFbeLqR4tqhy1Sr6rF6M=
X-Received: by 2002:a17:907:d2a:b0:a9a:5e3a:641d with SMTP id
 a640c23a62f3a-a9aad376421mr149249166b.59.1729593479583; Tue, 22 Oct 2024
 03:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20241021132839.463255-1-demeng@redhat.com>
 <20241021132839.463255-7-demeng@redhat.com>
 <ZxaFOdhqE54A5vWf@redhat.com>
 <CAPMcbCqa-1i6zVwF_YmecbADyVBSzeJCJRF=a7rMXkLRbznvUw@mail.gmail.com>
In-Reply-To: <CAPMcbCqa-1i6zVwF_YmecbADyVBSzeJCJRF=a7rMXkLRbznvUw@mail.gmail.com>
From: Dehan Meng <demeng@redhat.com>
Date: Tue, 22 Oct 2024 18:37:48 +0800
Message-ID: <CA+kPPJxfLM3oKvSSr=rKipjpQJMrjCW_VB-kCmFv8LvfJA98ZA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] qemu-ga: 'Null' check for mandatory parameters
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, michael.roth@amd.com, peter.maydell@linaro.org
Content-Type: multipart/alternative; boundary="000000000000f4f8af06250e5cf0"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=demeng@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000f4f8af06250e5cf0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

okay, thanks all for the suggestions, I'll make changes to a new commit, so
that you can review the commit5 later.

On Tue, Oct 22, 2024 at 1:14=E2=80=AFAM Konstantin Kostiuk <kkostiuk@redhat=
.com>
wrote:

>
>
> On Mon, Oct 21, 2024 at 7:45=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange=
@redhat.com>
> wrote:
>
>> On Mon, Oct 21, 2024 at 09:28:36PM +0800, Dehan Meng wrote:
>> > sscanf return values are checked and add 'Null' check for
>> > mandatory parameters.
>> >
>> > Signed-off-by: Dehan Meng <demeng@redhat.com>
>> > ---
>> >  qga/commands-linux.c | 12 +++++++++++-
>> >  1 file changed, 11 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/qga/commands-linux.c b/qga/commands-linux.c
>> > index 51d5e3d927..f0e9cdd27c 100644
>> > --- a/qga/commands-linux.c
>> > +++ b/qga/commands-linux.c
>> > @@ -2103,7 +2103,9 @@ static char *hexToIPAddress(const void *hexValue=
,
>> int is_ipv6)
>> >          int i;
>> >
>> >          for (i =3D 0; i < 16; i++) {
>> > -            sscanf(&hexStr[i * 2], "%02hhx", &in6.s6_addr[i]);
>> > +            if (sscanf(&hex_str[i * 2], "%02hhx", &in6.s6_addr[i]) !=
=3D
>> 1) {
>> > +                return NULL;
>> > +            }
>> >          }
>> >          inet_ntop(AF_INET6, &in6, addr, INET6_ADDRSTRLEN);
>> >
>> > @@ -2164,6 +2166,10 @@ GuestNetworkRouteList
>> *qmp_guest_network_get_route(Error **errp)
>> >                  networkroute =3D route;
>> >                  networkroute->iface =3D g_strdup(Iface);
>> >                  networkroute->destination =3D
>> hexToIPAddress(Destination, 1);
>> > +                if (networkroute->destination =3D=3D NULL) {
>> > +                    g_free(route);
>> > +                    continue;
>> > +                }
>>
>> This is still leaking the 'networkroute->iface' string.
>>
>> The existing code is a bit strange having 'route' and 'networkroute'
>> variables.
>>
>> I'd suggest removing the "route" variable entirely.
>>
>
> This part was done in patch 4/4
>
>
>>
>> Then have a code pattern that relies on g_autoptr to automatically
>> free the struct & all its fields.
>>
>
> Agree with this
>
>
>>
>> eg something that looks approx like this:
>>
>>    g_autoptr(GuestNetorkRoute) networkroute =3D NULL;
>>
>>    ...
>>
>>    if (is_ipv6) {
>>        ...
>>        networkroute =3D g_new0(GuestNetorkRoute, 1);
>>        networkroute->iface =3D g_strdup(Iface);
>>        networkroute->destination =3D hexToIPAddress(Destination, 1);
>>        if (networkroute->destination =3D=3D NULL) {
>>           continue;
>>        }
>>        ...
>>    } else {
>>        ...
>>        networkroute =3D g_new0(GuestNetorkRoute, 1);
>>        networkroute->iface =3D g_strdup(Iface);
>>        networkroute->destination =3D hexToIPAddress(Destination, 1);
>>        if (networkroute->destination =3D=3D NULL) {
>>           continue;
>>        }
>>        ...
>>    }
>>
>>    QAPI_LIST_APPEND(tail, g_steal_pointer(&networkroute));
>>
>>
>> >                  networkroute->metric =3D Metric;
>> >                  networkroute->source =3D hexToIPAddress(Source, 1);
>> >                  networkroute->desprefixlen =3D g_strdup_printf(
>> > @@ -2195,6 +2201,10 @@ GuestNetworkRouteList
>> *qmp_guest_network_get_route(Error **errp)
>> >                  networkroute =3D route;
>> >                  networkroute->iface =3D g_strdup(Iface);
>> >                  networkroute->destination =3D
>> hexToIPAddress(&Destination, 0);
>> > +                if (networkroute->destination =3D=3D NULL) {
>> > +                    g_free(route);
>> > +                    continue;
>> > +                }
>> >                  networkroute->gateway =3D hexToIPAddress(&Gateway, 0)=
;
>> >                  networkroute->mask =3D hexToIPAddress(&Mask, 0);
>> >                  networkroute->metric =3D Metric;
>> > --
>> > 2.40.1
>> >
>>
>> With regards,
>> Daniel
>> --
>> |: https://berrange.com      -o-
>> https://www.flickr.com/photos/dberrange :|
>> |: https://libvirt.org         -o-
>> https://fstop138.berrange.com :|
>> |: https://entangle-photo.org    -o-
>> https://www.instagram.com/dberrange :|
>>
>>

--000000000000f4f8af06250e5cf0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">okay, thanks all for the=C2=A0suggestions, I&#39;ll make c=
hanges to a new commit, so that you can review the commit5 later.=C2=A0</di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On T=
ue, Oct 22, 2024 at 1:14=E2=80=AFAM Konstantin Kostiuk &lt;<a href=3D"mailt=
o:kkostiuk@redhat.com">kkostiuk@redhat.com</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"=
><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Mon, Oct 21, 2024 at 7:45=E2=80=AFPM Daniel P. Ber=
rang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com" target=3D"_blank">ber=
range@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">On Mon, Oct 21, 2024 at 09:28:36PM +0800, Dehan Meng wrote:=
<br>
&gt; sscanf return values are checked and add &#39;Null&#39; check for<br>
&gt; mandatory parameters.<br>
&gt; <br>
&gt; Signed-off-by: Dehan Meng &lt;<a href=3D"mailto:demeng@redhat.com" tar=
get=3D"_blank">demeng@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qga/commands-linux.c | 12 +++++++++++-<br>
&gt;=C2=A0 1 file changed, 11 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/qga/commands-linux.c b/qga/commands-linux.c<br>
&gt; index 51d5e3d927..f0e9cdd27c 100644<br>
&gt; --- a/qga/commands-linux.c<br>
&gt; +++ b/qga/commands-linux.c<br>
&gt; @@ -2103,7 +2103,9 @@ static char *hexToIPAddress(const void *hexValue=
, int is_ipv6)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int i;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; 16; i++) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sscanf(&amp;hexStr[i * 2], =
&quot;%02hhx&quot;, &amp;in6.s6_addr[i]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sscanf(&amp;hex_str[i *=
 2], &quot;%02hhx&quot;, &amp;in6.s6_addr[i]) !=3D 1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 inet_ntop(AF_INET6, &amp;in6, addr, =
INET6_ADDRSTRLEN);<br>
&gt;=C2=A0 <br>
&gt; @@ -2164,6 +2166,10 @@ GuestNetworkRouteList *qmp_guest_network_get_ro=
ute(Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkr=
oute =3D route;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkr=
oute-&gt;iface =3D g_strdup(Iface);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkr=
oute-&gt;destination =3D hexToIPAddress(Destination, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (networkro=
ute-&gt;destination =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 g_free(route);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
This is still leaking the &#39;networkroute-&gt;iface&#39; string.<br>
<br>
The existing code is a bit strange having &#39;route&#39; and &#39;networkr=
oute&#39;<br>
variables.<br>
<br>
I&#39;d suggest removing the &quot;route&quot; variable entirely.<br></bloc=
kquote><div><br></div><div>This part was done in patch 4/4<br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Then have a code pattern that relies on g_autoptr to automatically<br>
free the struct &amp; all its fields.<br></blockquote><div><br></div><div>A=
gree with this<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
<br>
eg something that looks approx like this:<br>
<br>
=C2=A0 =C2=A0g_autoptr(GuestNetorkRoute) networkroute =3D NULL;<br>
<br>
=C2=A0 =C2=A0...<br>
<br>
=C2=A0 =C2=A0if (is_ipv6) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0networkroute =3D g_new0(GuestNetorkRoute, 1);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0networkroute-&gt;iface =3D g_strdup(Iface);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0networkroute-&gt;destination =3D hexToIPAddress(=
Destination, 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (networkroute-&gt;destination =3D=3D NULL) {<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0...<br>
=C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0networkroute =3D g_new0(GuestNetorkRoute, 1);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0networkroute-&gt;iface =3D g_strdup(Iface);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0networkroute-&gt;destination =3D hexToIPAddress(=
Destination, 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (networkroute-&gt;destination =3D=3D NULL) {<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0...<br>
=C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0QAPI_LIST_APPEND(tail, g_steal_pointer(&amp;networkroute));<br=
>
<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkr=
oute-&gt;metric =3D Metric;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkr=
oute-&gt;source =3D hexToIPAddress(Source, 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkr=
oute-&gt;desprefixlen =3D g_strdup_printf(<br>
&gt; @@ -2195,6 +2201,10 @@ GuestNetworkRouteList *qmp_guest_network_get_ro=
ute(Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkr=
oute =3D route;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkr=
oute-&gt;iface =3D g_strdup(Iface);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkr=
oute-&gt;destination =3D hexToIPAddress(&amp;Destination, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (networkro=
ute-&gt;destination =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 g_free(route);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkr=
oute-&gt;gateway =3D hexToIPAddress(&amp;Gateway, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkr=
oute-&gt;mask =3D hexToIPAddress(&amp;Mask, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 networkr=
oute-&gt;metric =3D Metric;<br>
&gt; -- <br>
&gt; 2.40.1<br>
&gt; <br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div></div>
</div>
</blockquote></div>

--000000000000f4f8af06250e5cf0--


