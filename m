Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CF7C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 15:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKJuD-00016U-0f; Thu, 20 Jun 2024 11:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sKJuA-00016H-Vv
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:40:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sKJu8-0003Gu-Qi
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718898051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cdcb70U6lnMBVjxurnAdJ0azwCO7/L+Et6M/IpgzyBw=;
 b=SUyw2mUWwxgMr89dkRbzhpWQkvG8e1Hip3Jghs6wAJpZvuVGPgbXiZJmldK9wUrsJRltVW
 ZTQtppUGeLh79dR7j5yF8yhxK9QpQv1Y1xOjpMlWgJJiAgJvc9QvrVcLk6Pchz0rLSdkHX
 gx4desnrPzCxqwjkqXh+9iinkhQPaw4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-6wKCcke_PoO94Zpr6yo10Q-1; Thu, 20 Jun 2024 11:40:50 -0400
X-MC-Unique: 6wKCcke_PoO94Zpr6yo10Q-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2c79f32200aso1168537a91.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 08:40:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718898049; x=1719502849;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cdcb70U6lnMBVjxurnAdJ0azwCO7/L+Et6M/IpgzyBw=;
 b=TpZXPTcLPsUTzoUxoJY1zJIfCK/WubcqF58+U2+27q+XM2NsWJIYg1GPy12LL073+S
 VTpcagGImKf9rh6d7H7Qu73V5DubB5reH0bQ/mFYQnwBYTtM8duHNuaJoaqStsMkNPz6
 3L0KKK2I6rEk5bdCR2dasaHvlSMOF/0LSuBsoLRUMM3mjYSizIXlp3zLuSLY5/l1IZsn
 aQLw4DP5p6WBAGNtA/5YhciqtrjKAEIHGojuxvJwZ+Vvf5307vaoHWTngoSN+n8W7u+M
 VrpZYfwg/wpmij6Wwe2myCbBB0Q7YO6po70ebrAZgyNVAVLXBnsyoOXndkXGK9XKdQCV
 O3NQ==
X-Gm-Message-State: AOJu0YxkJ/KremYwkvcRxgATaeFibcMY0g3F3J+l4mq6cCkPSlozSMPG
 lF2nVthOr13Foxkmsl9m/O7tL4z8cDsOHouD8yNbAgPx8/G82acLtXmfOB3WUYS1VRrzSaDp2lV
 rBmvtfjwBoAPlUVSN9/bq0PeJRZeU4/QR9y19/CFECURhEN1XfJzIJ9Bf5iBPAhF1X8UZ2fiTEg
 QuQHyEm5MlItIfCOuX4B76Chl+wfQ=
X-Received: by 2002:a17:90a:3044:b0:2c4:fc64:6b81 with SMTP id
 98e67ed59e1d1-2c7b5d52cb7mr5938536a91.31.1718898049015; 
 Thu, 20 Jun 2024 08:40:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvk0/hMVhrTULLFjtB29bDDZLkMfvzIanmwUmc+p3GVEuqUqijkrFBHtsyR3sHtjrYMtMSHKwmZFKL41urKcA=
X-Received: by 2002:a17:90a:3044:b0:2c4:fc64:6b81 with SMTP id
 98e67ed59e1d1-2c7b5d52cb7mr5938507a91.31.1718898048666; Thu, 20 Jun 2024
 08:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240619003012.1753577-1-jsnow@redhat.com>
 <20240619003012.1753577-10-jsnow@redhat.com>
 <87zfrhxeqt.fsf@pond.sub.org>
In-Reply-To: <87zfrhxeqt.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 20 Jun 2024 11:40:36 -0400
Message-ID: <CAFn=p-Y9k++Gj1BJTjHBine85EspcjsmF5B_hXi3RM=fGeParQ@mail.gmail.com>
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
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Qemu-block <qemu-block@nongnu.org>, Jiri Pirko <jiri@resnulli.us>, 
 Alex Williamson <alex.williamson@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000098a3e5061b542397"
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

--00000000000098a3e5061b542397
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024, 9:07=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
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
> > This patch uses ".. note::" almost everywhere, with just two "caution"
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
> > diff --git a/qapi/control.json b/qapi/control.json
> > index 10c906fa0e7..59d5e00c151 100644
> > --- a/qapi/control.json
> > +++ b/qapi/control.json
> > @@ -22,14 +22,13 @@
> >  #          "arguments": { "enable": [ "oob" ] } }
> >  #     <- { "return": {} }
> >  #
> > -# Notes: This command is valid exactly when first connecting: it must
> > -#     be issued before any other command will be accepted, and will
> > -#     fail once the monitor is accepting other commands.  (see qemu
> > -#     docs/interop/qmp-spec.rst)
> > +# .. note:: This command is valid exactly when first connecting: it mu=
st
> > +#    be issued before any other command will be accepted, and will fai=
l
> > +#    once the monitor is accepting other commands.  (see qemu
> > +#    docs/interop/qmp-spec.rst)
> >  #
> > -#     The QMP client needs to explicitly enable QMP capabilities,
> > -#     otherwise all the QMP capabilities will be turned off by
> > -#     default.
> > +# .. note:: The QMP client needs to explicitly enable QMP capabilities=
,
> > +#    otherwise all the QMP capabilities will be turned off by default.
> >  #
> >  # Since: 0.13
> >  ##
> > @@ -150,8 +149,8 @@
> >  #          ]
> >  #        }
> >  #
> > -# Note: This example has been shortened as the real response is too
> > -#     long.
> > +# This example has been shortened as the real response is too long.
> > +#
>
> Here's one way to transform the elision note, ...
>
> >  ##
> >  { 'command': 'query-commands', 'returns': ['CommandInfo'],
> >    'allow-preconfig': true }
>
> [...]
>
> > diff --git a/qapi/pci.json b/qapi/pci.json
> > index 08bf6958634..f51159a2c4c 100644
> > --- a/qapi/pci.json
> > +++ b/qapi/pci.json
> > @@ -146,8 +146,8 @@
> >  #
> >  # @regions: a list of the PCI I/O regions associated with the device
> >  #
> > -# Notes: the contents of @class_info.desc are not stable and should
> > -#     only be treated as informational.
> > +# .. note:: The contents of @class_info.desc are not stable and should
> > +#    only be treated as informational.
> >  #
> >  # Since: 0.14
> >  ##
> > @@ -311,7 +311,8 @@
> >  #           ]
> >  #        }
> >  #
> > -# Note: This example has been shortened as the real response is too
> > +#     Note: This example has been shortened as the real response is to=
o
> >  #     long.
> > +#
>
> ... and here's another way.  Same way would be better, wouldn't it?
> They actually are after PATCH 13:
>
>   -#     Note: This example has been shortened as the real response is to=
o
>   -#     long.
>   +# This example has been shortened as the real response is too long.
>
> Move that hunk here, please.
>
> >  ##
> >  { 'command': 'query-pci', 'returns': ['PciInfo'] }
>
> [...]
>

Apologies, I meant to do this but forgot there were two cases and only
nabbed one.

Fixing.

>

--00000000000098a3e5061b542397
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Jun 19, 2024, 9:07=E2=80=AFAM Markus Armbruste=
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
&gt; This patch uses &quot;.. note::&quot; almost everywhere, with just two=
 &quot;caution&quot;<br>
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
&gt; diff --git a/qapi/control.json b/qapi/control.json<br>
&gt; index 10c906fa0e7..59d5e00c151 100644<br>
&gt; --- a/qapi/control.json<br>
&gt; +++ b/qapi/control.json<br>
&gt; @@ -22,14 +22,13 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;arguments&quot;: { &qu=
ot;enable&quot;: [ &quot;oob&quot; ] } }<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0&lt;- { &quot;return&quot;: {} }<br>
&gt;=C2=A0 #<br>
&gt; -# Notes: This command is valid exactly when first connecting: it must=
<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0be issued before any other command will be accep=
ted, and will<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0fail once the monitor is accepting other command=
s.=C2=A0 (see qemu<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0docs/interop/qmp-spec.rst)<br>
&gt; +# .. note:: This command is valid exactly when first connecting: it m=
ust<br>
&gt; +#=C2=A0 =C2=A0 be issued before any other command will be accepted, a=
nd will fail<br>
&gt; +#=C2=A0 =C2=A0 once the monitor is accepting other commands.=C2=A0 (s=
ee qemu<br>
&gt; +#=C2=A0 =C2=A0 docs/interop/qmp-spec.rst)<br>
&gt;=C2=A0 #<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0The QMP client needs to explicitly enable QMP ca=
pabilities,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0otherwise all the QMP capabilities will be turne=
d off by<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0default.<br>
&gt; +# .. note:: The QMP client needs to explicitly enable QMP capabilitie=
s,<br>
&gt; +#=C2=A0 =C2=A0 otherwise all the QMP capabilities will be turned off =
by default.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 0.13<br>
&gt;=C2=A0 ##<br>
&gt; @@ -150,8 +149,8 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 #<br>
&gt; -# Note: This example has been shortened as the real response is too<b=
r>
&gt; -#=C2=A0 =C2=A0 =C2=A0long.<br>
&gt; +# This example has been shortened as the real response is too long.<b=
r>
&gt; +#<br>
<br>
Here&#39;s one way to transform the elision note, ...<br>
<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 { &#39;command&#39;: &#39;query-commands&#39;, &#39;returns&#39;=
: [&#39;CommandInfo&#39;],<br>
&gt;=C2=A0 =C2=A0 &#39;allow-preconfig&#39;: true }<br>
<br>
[...]<br>
<br>
&gt; diff --git a/qapi/pci.json b/qapi/pci.json<br>
&gt; index 08bf6958634..f51159a2c4c 100644<br>
&gt; --- a/qapi/pci.json<br>
&gt; +++ b/qapi/pci.json<br>
&gt; @@ -146,8 +146,8 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @regions: a list of the PCI I/O regions associated with the de=
vice<br>
&gt;=C2=A0 #<br>
&gt; -# Notes: the contents of @class_info.desc are not stable and should<b=
r>
&gt; -#=C2=A0 =C2=A0 =C2=A0only be treated as informational.<br>
&gt; +# .. note:: The contents of @class_info.desc are not stable and shoul=
d<br>
&gt; +#=C2=A0 =C2=A0 only be treated as informational.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 0.14<br>
&gt;=C2=A0 ##<br>
&gt; @@ -311,7 +311,8 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0]<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 #<br>
&gt; -# Note: This example has been shortened as the real response is too<b=
r>
&gt; +#=C2=A0 =C2=A0 =C2=A0Note: This example has been shortened as the rea=
l response is too<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0long.<br>
&gt; +#<br>
<br>
... and here&#39;s another way.=C2=A0 Same way would be better, wouldn&#39;=
t it?<br>
They actually are after PATCH 13:<br>
<br>
=C2=A0 -#=C2=A0 =C2=A0 =C2=A0Note: This example has been shortened as the r=
eal response is too<br>
=C2=A0 -#=C2=A0 =C2=A0 =C2=A0long.<br>
=C2=A0 +# This example has been shortened as the real response is too long.=
<br>
<br>
Move that hunk here, please.<br>
<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 { &#39;command&#39;: &#39;query-pci&#39;, &#39;returns&#39;: [&#=
39;PciInfo&#39;] }<br>
<br>
[...]<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Apologies, I meant to do this but forgot there were two cases and only=
 nabbed one.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Fixing.</di=
v><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
</blockquote></div></div></div>

--00000000000098a3e5061b542397--


