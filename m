Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98346C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 15:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKJfw-0000Gy-Rx; Thu, 20 Jun 2024 11:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sKJfu-0000GP-UK
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:26:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sKJfs-0000Ki-3o
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718897166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PVWh+WNEDznQkCV/n7HzSseU4f0b7FoUVEvhIgbGBmI=;
 b=bCh3ESooLi4YoMIRU8VyCj4htL/KsbT6LWMyD1xYoEKHWc9yAiub2nrul6kpYkcwAVyQza
 MeX4p/gBivXVu4sTbis7AnxwLh/9EvboBH7eGHIg/01qqvhvoJXxmeae4gjJ9h2ikO7PTg
 nu2KZnGWXoK2ZscY8X2KUtJSlolNEO4=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-2jHLitv9PCykTI6vYr_SJw-1; Thu, 20 Jun 2024 11:26:04 -0400
X-MC-Unique: 2jHLitv9PCykTI6vYr_SJw-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-6507e2f0615so1054972a12.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 08:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718897163; x=1719501963;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PVWh+WNEDznQkCV/n7HzSseU4f0b7FoUVEvhIgbGBmI=;
 b=EcVx+ZWTIrMwwDMr4maE8s71h6x2/NO+ywaxXl6pmNu70qchMCq1Tj+aFyrlE9IYol
 kRLsA68D7LsZt5ra9URXGprhndi7A+6bYXmj8U48QYG/LOgJuN88rBYL+pgHgHWynHjr
 oOI7GYsKRV5rqCv1OuFiqA0xpxpUSr1fbydsRd2Fx9S9Ysq3AaoG6eMKHeiMS7nt90F6
 yKDnfAkEN7uEtXxq1CR3J8t8i8mRggBtMIrxGuPOWwV04yhtIgByG/va9CrZEqTkBIZT
 w3zjr6A8MG1ZT9MpMvQnFcnryV9OGIG/0Kx8lxmb7HSC44RsTwxWPZg2PI8iPacVj4XZ
 r/kw==
X-Gm-Message-State: AOJu0YwoCd+xjZEVYNy5VYVpYpD4vkDp5h+31EL0G+DeaogDhRfZ+sqw
 l9ztjXevQW++7RvPNGW5wGOuVSmSZ9zXMHCV3yMB+R4KD2Kd2LDOOwZKVSsvkHYR6yKRHpkfT+b
 UuEp7jPdriIDAOJyyCxNDPr98hn1aYPgxZEb7+w0CGM6+dCFH58rXocy/BVrG5B8DXq9cX7Qheg
 mAokco/mmOIxYqQ1cpZxdVJhz1qvU=
X-Received: by 2002:a17:902:ecc7:b0:1f7:21fd:ab83 with SMTP id
 d9443c01a7336-1f9aa461c07mr65806065ad.54.1718897163262; 
 Thu, 20 Jun 2024 08:26:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK3q6h/ro4t2ohqKpDes/3Oc/Xt4xrr5ZKe6fpWlKkhNl2VAT3dgv5xBoWMuwXwLgPiBvdviLJTOcgSRWYx/g=
X-Received: by 2002:a17:902:ecc7:b0:1f7:21fd:ab83 with SMTP id
 d9443c01a7336-1f9aa461c07mr65805645ad.54.1718897162866; Thu, 20 Jun 2024
 08:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240619003012.1753577-1-jsnow@redhat.com>
 <20240619003012.1753577-9-jsnow@redhat.com>
 <87plsd16bc.fsf@pond.sub.org>
In-Reply-To: <87plsd16bc.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 20 Jun 2024 11:25:51 -0400
Message-ID: <CAFn=p-bWCYpO2WhC-9JtmBq-3a+uE0H7jg1FOooatHDeCx4XJQ@mail.gmail.com>
Subject: Re: [PATCH 08/13] qapi: ensure all errors sections are uniformly
 typset
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Victor Toso de Carvalho <victortoso@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Lukas Straub <lukasstraub2@web.de>, Eduardo Habkost <eduardo@habkost.net>,
 Mads Ynddal <mads@ynddal.dk>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Qemu-block <qemu-block@nongnu.org>, Jiri Pirko <jiri@resnulli.us>, 
 Alex Williamson <alex.williamson@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000cc66e3061b53ee90"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
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

--000000000000cc66e3061b53ee90
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024, 8:10=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Transactions have the only instance of an Errors section that isn't a
> > rST list; turn it into one.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> Let;s explain the "why" a bit more clearly.  Maybe
>
>     qapi: Nail down convention that Errors sections are lists
>
>     By unstated convention, Errors sections are rST lists.  Document the
>     convention, and make the one exception conform.
>
> > ---
> >  docs/devel/qapi-code-gen.rst | 7 +++++++
> >  qapi/transaction.json        | 2 +-
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rs=
t
> > index f453bd35465..cee43222f19 100644
> > --- a/docs/devel/qapi-code-gen.rst
> > +++ b/docs/devel/qapi-code-gen.rst
> > @@ -1011,6 +1011,13 @@ like this::
> >  "Returns" and "Errors" sections are only valid for commands.  They
> >  document the success and the error response, respectively.
> >
> > +"Errors" sections should be formatted as an rST list, each entry
> > +detailing a relevant error condition. For example::
> > +
> > + # Errors:
> > + #     - If @device does not exist, DeviceNotFound
> > + #     - Any other error returns a GenericError.
> > +
> >  A "Since: x.y.z" tagged section lists the release that introduced the
> >  definition.
> >
> > diff --git a/qapi/transaction.json b/qapi/transaction.json
> > index 5749c133d4a..07afc269d54 100644
> > --- a/qapi/transaction.json
> > +++ b/qapi/transaction.json
> > @@ -235,7 +235,7 @@
> >  #     additional detail.
> >  #
> >  # Errors:
> > -#     Any errors from commands in the transaction
> > +#     - Any errors from commands in the transaction
> >  #
> >  # Note: The transaction aborts on the first failure.  Therefore, there
> >  #     will be information on only one failed operation returned in an
>
> Preferably with an improved commit message
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>

okie dokie.

(Feel free to adjust the doc phrasing too, if you want. I promise I'm not
offended by that.)

>

--000000000000cc66e3061b53ee90
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Jun 19, 2024, 8:10=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:js=
now@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&g=
t; writes:<br>
<br>
&gt; Transactions have the only instance of an Errors section that isn&#39;=
t a<br>
&gt; rST list; turn it into one.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
<br>
Let;s explain the &quot;why&quot; a bit more clearly.=C2=A0 Maybe<br>
<br>
=C2=A0 =C2=A0 qapi: Nail down convention that Errors sections are lists<br>
<br>
=C2=A0 =C2=A0 By unstated convention, Errors sections are rST lists.=C2=A0 =
Document the<br>
=C2=A0 =C2=A0 convention, and make the one exception conform.<br>
<br>
&gt; ---<br>
&gt;=C2=A0 docs/devel/qapi-code-gen.rst | 7 +++++++<br>
&gt;=C2=A0 qapi/transaction.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
&gt;=C2=A0 2 files changed, 8 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.r=
st<br>
&gt; index f453bd35465..cee43222f19 100644<br>
&gt; --- a/docs/devel/qapi-code-gen.rst<br>
&gt; +++ b/docs/devel/qapi-code-gen.rst<br>
&gt; @@ -1011,6 +1011,13 @@ like this::<br>
&gt;=C2=A0 &quot;Returns&quot; and &quot;Errors&quot; sections are only val=
id for commands.=C2=A0 They<br>
&gt;=C2=A0 document the success and the error response, respectively.<br>
&gt;=C2=A0 <br>
&gt; +&quot;Errors&quot; sections should be formatted as an rST list, each =
entry<br>
&gt; +detailing a relevant error condition. For example::<br>
&gt; +<br>
&gt; + # Errors:<br>
&gt; + #=C2=A0 =C2=A0 =C2=A0- If @device does not exist, DeviceNotFound<br>
&gt; + #=C2=A0 =C2=A0 =C2=A0- Any other error returns a GenericError.<br>
&gt; +<br>
&gt;=C2=A0 A &quot;Since: x.y.z&quot; tagged section lists the release that=
 introduced the<br>
&gt;=C2=A0 definition.<br>
&gt;=C2=A0 <br>
&gt; diff --git a/qapi/transaction.json b/qapi/transaction.json<br>
&gt; index 5749c133d4a..07afc269d54 100644<br>
&gt; --- a/qapi/transaction.json<br>
&gt; +++ b/qapi/transaction.json<br>
&gt; @@ -235,7 +235,7 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0additional detail.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Errors:<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0Any errors from commands in the transaction<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0- Any errors from commands in the transaction<br=
>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Note: The transaction aborts on the first failure.=C2=A0 There=
fore, there<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0will be information on only one failed oper=
ation returned in an<br>
<br>
Preferably with an improved commit message<br>
Reviewed-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" tar=
get=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;<br></blockquote=
></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">okie dokie.</div=
><div dir=3D"auto"><br></div><div dir=3D"auto">(Feel free to adjust the doc=
 phrasing too, if you want. I promise I&#39;m not offended by that.)</div><=
div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000cc66e3061b53ee90--


