Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9965BC2BA1A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 15:52:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKK5R-0004Gu-9V; Thu, 20 Jun 2024 11:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sKK5O-0004Fa-MR
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:52:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sKK5L-0005QX-Pe
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718898746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oLLNs7i4L+E1U+i3DHFsqAZJzRfNIlbXdCAPKlHc44A=;
 b=LgZrz38/KpL2i6h6drEvSiWUhoTHLX9CLON1divBqwUxSmTDpgm5PIFOEVcfxl+ARz3lJq
 Zx8IG9edFFb1THOWfzub/+fqx31Df7Z3FE0fN9a9A9KFojsi/EDHHq/4zLWP6Ln3Kn9esH
 0IAvMoelryqEmzNgxR8lDbqQhJirKO0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-4Prjj_YZN5qFNhIEvXan_A-1; Thu, 20 Jun 2024 11:52:24 -0400
X-MC-Unique: 4Prjj_YZN5qFNhIEvXan_A-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2c7bb0fe8b4so1079747a91.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 08:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718898743; x=1719503543;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oLLNs7i4L+E1U+i3DHFsqAZJzRfNIlbXdCAPKlHc44A=;
 b=qqVwNN69G9V+1HNdZjICmI/hwiJyfSPvB0w09iHKQn0J3wCGzFHAInIRkQj813XXu3
 CvQtn2b6xmIzfgzn6i1474o+G2jTODSiJbzJiE0IlRsBSMuAqaVh4Nd77Bzm713NbisA
 B+cisyUyKS50LkLpvTwwyeNmxZx7iXgYmTgouEP8QCWTxQv7wlA5pSgm/NXmQH8q0WLd
 6+fPj+VT966yIOWfPAWGSWa98D+GvcAFqwZU/u/6RogCizTWGA9M4D/0LTeSqgyhuYPf
 uuXvxqFWGSTUjJHDhlV2mxl7KvEACvMg9ooXDlcYAy5fU4rcTsTBxN3fG6IXsdnXTgY8
 D5VA==
X-Gm-Message-State: AOJu0Yx27qpG2XUp0afcH1pv4r3qKxBmR3XlN6uzI5JcvbsPad5LFmCd
 fx2QwdYrXEBG5t+/NtL97W/lz7wb4amPoI5OiCcfY/FtU6cF5+W2pkLSSiHlAt9zwVyrhDWGfp/
 wZGoIlOVmZAJzMvTwJKFeRXFitcF659i85nAHdcNPnZC33V6typUOaY+zqSuetcIbLFy0ZK2D52
 ZLOtFermC1tJssYxFcbOkEu4Hqen0=
X-Received: by 2002:a17:90b:e91:b0:2c8:87f:4fcc with SMTP id
 98e67ed59e1d1-2c8087f5745mr922678a91.12.1718898743391; 
 Thu, 20 Jun 2024 08:52:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+4Ff1bD3TXy7tYoQUDjhx+ycbt94s+KpRn7TlvmQNpnVNyZmUdpxgtt+Lfyq1/TGmcn7UVLPaCtOE7IzGlDo=
X-Received: by 2002:a17:90b:e91:b0:2c8:87f:4fcc with SMTP id
 98e67ed59e1d1-2c8087f5745mr922628a91.12.1718898743025; Thu, 20 Jun 2024
 08:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240619003012.1753577-1-jsnow@redhat.com>
 <20240619003012.1753577-10-jsnow@redhat.com>
 <87a5jfu3bm.fsf@pond.sub.org>
In-Reply-To: <87a5jfu3bm.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 20 Jun 2024 11:52:11 -0400
Message-ID: <CAFn=p-aC_MjWCy1y7_w=gWRwGNW7LYFBnkzioftSNZz0t4246g@mail.gmail.com>
Subject: Re: [PATCH 09/13] qapi: convert "Note" sections to plain rST
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
 Gerd Hoffmann <kraxel@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Qemu-block <qemu-block@nongnu.org>, Jiri Pirko <jiri@resnulli.us>, 
 Alex Williamson <alex.williamson@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000fbb4db061b544cc4"
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

--000000000000fbb4db061b544cc4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024, 9:55=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > We do not need a dedicated section for notes. By eliminating a speciall=
y
> > parsed section, these notes can be treated as normal rST paragraphs in
> > the new QMP reference manual, and can be placed and styled much more
> > flexibly.
> >
> > Convert all existing "Note" and "Notes" sections to pure rST. As part o=
f
> > the conversion, capitalize the first letter of each sentence and add
> > trailing punctuation where appropriate to ensure notes look sensible an=
d
> > consistent in rendered HTML documentation.
> >
> > Update docs/devel/qapi-code-gen.rst to reflect the new paradigm, and ..=
.
> >
> > ... Update the QAPI parser to prohibit "Note" sections while suggesting
> > a new syntax. The exact formatting to use is a matter of taste, but a
> > good candidate is simply:
> >
> > .. note:: lorem ipsum ...
> >
> > ... but there are other choices, too. The Sphinx readthedocs theme
> > offers theming for the following forms (capitalization unimportant); al=
l
> > are adorned with a (!) symbol in the title bar for rendered HTML docs.
> >
> > See
> >
> https://sphinx-rtd-theme.readthedocs.io/en/stable/demo/demo.html#admoniti=
ons
> > for examples of each directive/admonition in use.
> >
> > These are rendered in orange:
> >
> > .. Attention:: ...
> > .. Caution:: ...
> > .. WARNING:: ...
> >
> > These are rendered in red:
> >
> > .. DANGER:: ...
> > .. Error:: ...
> >
> > These are rendered in green:
> >
> > .. Hint:: ...
> > .. Important:: ...
> > .. Tip:: ...
> >
> > These are rendered in blue:
> >
> > .. Note:: ...
> > .. admonition:: custom title
> >
> >    admonition body text
> >
> > This patch uses ".. note::" almost everywhere,
>
> Not mentioned, and may or may not be worth mentioning: both "Note:" and
> "Notes:" become ".. note::", which renders as "Note".  One instance
> quoted below.
>
> No objection to the change; you obviously double-checked it reads okay
> that way.
>

Right, some become "Note" if it feels appropriate, while others (mentioned
just below) retained their "Notes" phrasing with a custom admonition if it
felt appropriate.

I can mention it more explicitly that some (but not all) "Notes" became
"Note".

(I am beginning to have doubts anyone will ever read and find these
detailed commits useful, but you're welcome to tell your manager how much
you love my commit messages and that I deserve a raise for such heroic
efforts. /s)


> >                                                with just two "caution"
> > directives. ".. admonition:: notes" is used in a few places where we ha=
d
> > an ordered list of multiple notes that would not make sense as
> > standalone/separate admonitions.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > Acked-by: Stefan Hajnoczi <stefanha@redhat.com> [for block*.json]
>
> [...]
>
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index df5e07debd2..cacedfb771c 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
>
> [...]
>
> > @@ -6048,9 +6048,9 @@
> >  #
> >  # @name: the name of the internal snapshot to be created
> >  #
> > -# Notes: In transaction, if @name is empty, or any snapshot matching
> > -#     @name exists, the operation will fail.  Only some image formats
> > -#     support it, for example, qcow2, and rbd.
> > +# .. note:: In transaction, if @name is empty, or any snapshot matchin=
g
> > +#    @name exists, the operation will fail.  Only some image formats
> > +#    support it, for example, qcow2, and rbd.
> >  #
> >  # Since: 1.7
> >  ##
>
> [...]
>
>

--000000000000fbb4db061b544cc4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Jun 20, 2024, 9:55=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:js=
now@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&g=
t; writes:<br>
<br>
&gt; We do not need a dedicated section for notes. By eliminating a special=
ly<br>
&gt; parsed section, these notes can be treated as normal rST paragraphs in=
<br>
&gt; the new QMP reference manual, and can be placed and styled much more<b=
r>
&gt; flexibly.<br>
&gt;<br>
&gt; Convert all existing &quot;Note&quot; and &quot;Notes&quot; sections t=
o pure rST. As part of<br>
&gt; the conversion, capitalize the first letter of each sentence and add<b=
r>
&gt; trailing punctuation where appropriate to ensure notes look sensible a=
nd<br>
&gt; consistent in rendered HTML documentation.<br>
&gt;<br>
&gt; Update docs/devel/qapi-code-gen.rst to reflect the new paradigm, and .=
..<br>
&gt;<br>
&gt; ... Update the QAPI parser to prohibit &quot;Note&quot; sections while=
 suggesting<br>
&gt; a new syntax. The exact formatting to use is a matter of taste, but a<=
br>
&gt; good candidate is simply:<br>
&gt;<br>
&gt; .. note:: lorem ipsum ...<br>
&gt;<br>
&gt; ... but there are other choices, too. The Sphinx readthedocs theme<br>
&gt; offers theming for the following forms (capitalization unimportant); a=
ll<br>
&gt; are adorned with a (!) symbol in the title bar for rendered HTML docs.=
<br>
&gt;<br>
&gt; See<br>
&gt; <a href=3D"https://sphinx-rtd-theme.readthedocs.io/en/stable/demo/demo=
.html#admonitions" rel=3D"noreferrer noreferrer" target=3D"_blank">https://=
sphinx-rtd-theme.readthedocs.io/en/stable/demo/demo.html#admonitions</a><br=
>
&gt; for examples of each directive/admonition in use.<br>
&gt;<br>
&gt; These are rendered in orange:<br>
&gt;<br>
&gt; .. Attention:: ...<br>
&gt; .. Caution:: ...<br>
&gt; .. WARNING:: ...<br>
&gt;<br>
&gt; These are rendered in red:<br>
&gt;<br>
&gt; .. DANGER:: ...<br>
&gt; .. Error:: ...<br>
&gt;<br>
&gt; These are rendered in green:<br>
&gt;<br>
&gt; .. Hint:: ...<br>
&gt; .. Important:: ...<br>
&gt; .. Tip:: ...<br>
&gt;<br>
&gt; These are rendered in blue:<br>
&gt;<br>
&gt; .. Note:: ...<br>
&gt; .. admonition:: custom title<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 admonition body text<br>
&gt;<br>
&gt; This patch uses &quot;.. note::&quot; almost everywhere,<br>
<br>
Not mentioned, and may or may not be worth mentioning: both &quot;Note:&quo=
t; and<br>
&quot;Notes:&quot; become &quot;.. note::&quot;, which renders as &quot;Not=
e&quot;.=C2=A0 One instance<br>
quoted below.<br>
<br>
No objection to the change; you obviously double-checked it reads okay<br>
that way.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Right, some become &quot;Note&quot; if it feels appropriate, whil=
e others (mentioned just below) retained their &quot;Notes&quot; phrasing w=
ith a custom admonition if it felt appropriate.</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">I can mention it more explicitly that some (but not=
 all) &quot;Notes&quot; became &quot;Note&quot;.</div><div dir=3D"auto"><br=
></div><div dir=3D"auto">(I am beginning to have doubts anyone will ever re=
ad and find these detailed commits useful, but you&#39;re welcome to tell y=
our manager how much you love my commit messages and that I deserve a raise=
 for such heroic efforts. /s)</div><div dir=3D"auto"><br></div><div dir=3D"=
auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 with just two &quot;caution&quot;<br>
&gt; directives. &quot;.. admonition:: notes&quot; is used in a few places =
where we had<br>
&gt; an ordered list of multiple notes that would not make sense as<br>
&gt; standalone/separate admonitions.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; Acked-by: Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">stefanha@redhat.com</a>&gt; [for block*=
.json]<br>
<br>
[...]<br>
<br>
&gt; diff --git a/qapi/block-core.json b/qapi/block-core.json<br>
&gt; index df5e07debd2..cacedfb771c 100644<br>
&gt; --- a/qapi/block-core.json<br>
&gt; +++ b/qapi/block-core.json<br>
<br>
[...]<br>
<br>
&gt; @@ -6048,9 +6048,9 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @name: the name of the internal snapshot to be created<br>
&gt;=C2=A0 #<br>
&gt; -# Notes: In transaction, if @name is empty, or any snapshot matching<=
br>
&gt; -#=C2=A0 =C2=A0 =C2=A0@name exists, the operation will fail.=C2=A0 Onl=
y some image formats<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0support it, for example, qcow2, and rbd.<br>
&gt; +# .. note:: In transaction, if @name is empty, or any snapshot matchi=
ng<br>
&gt; +#=C2=A0 =C2=A0 @name exists, the operation will fail.=C2=A0 Only some=
 image formats<br>
&gt; +#=C2=A0 =C2=A0 support it, for example, qcow2, and rbd.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 1.7<br>
&gt;=C2=A0 ##<br>
<br>
[...]<br>
<br>
</blockquote></div></div></div>

--000000000000fbb4db061b544cc4--


