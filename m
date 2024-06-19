Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2B1C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 17:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJzBD-0006Jz-F0; Wed, 19 Jun 2024 13:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sJzBC-0006Jh-Qt
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 13:33:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sJzBA-0004Qj-LK
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 13:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718818384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6nz4sDMlkhC/G+NOoN1TcyhswwSBHtT2TzqqP2NtNzU=;
 b=YOD3YHbQA9p2YNHqknGJUc0qlyHADZiscyXsgTmmXuBs67ACiSeyXvoImit0ysvPJshNdy
 J1KML+IuzYgJnf++jMtK3Zg2YWFLWIoRgiMpC5yJ1T8+yr2F3qL1FQ1eEe2rJDo0e+QZqR
 Z03jOpC91nusLSUSRSHcWA9VL1PD8YM=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-8A1Tb4x3NPmSMGrRILzb_Q-1; Wed, 19 Jun 2024 13:33:02 -0400
X-MC-Unique: 8A1Tb4x3NPmSMGrRILzb_Q-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1f6efc8759dso5875ad.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 10:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718818376; x=1719423176;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6nz4sDMlkhC/G+NOoN1TcyhswwSBHtT2TzqqP2NtNzU=;
 b=fNrN1oNN08tsn2WFT2Q7lQvhPcmBF+S8sg7Dz3PWyXtREOhsMEI03PYcUHXzm8P66n
 klS4FR129ZV0wmdCro9LpP6hpQq6zI9upi+VHnOndGSCdFerTt0rDREYxsCxUtgcC1W9
 9BLQ/TLcN8YMnIBekqKkDehY8nuPCod3QmAthuTjdCegaeolw+wFEvc3CkHc1Dw+5VxD
 Fpx+URB7rgoY2qez+OcZv21XWrqsVQ3MN1pko1yaCLxUqz75hCURQZ2Kwxt45x/Qeglk
 EpL65iSnLNrdf/SaFlCinRyOfDBoBID/J766DcE9X4NFcVmQEtlMkW3moLLQY61FUUge
 POxg==
X-Gm-Message-State: AOJu0YzfLkdPGxnfYVer2qmSLJVGsvh/FR2iKRDsnyEh295JS47Q9jmI
 WePhZXjvcf+oG5wwY2Ewmt0dvWA24FndjgKns4q/JXEGKvXM6575CHFNwjlWR0BQPxIXNPRE1Kv
 TjzdlEyI5RFG8AQkveGNm4bnRBuS90WFU7n1ko9po+W8X8tnf2EdkAE5zNcO1of6gYBrI2rBaLH
 +SCoYlbstNIiTtI+dPB8Lpg4pOiMc=
X-Received: by 2002:a17:902:a3ce:b0:1f9:b807:21ac with SMTP id
 d9443c01a7336-1f9b80721fcmr16181025ad.51.1718818376632; 
 Wed, 19 Jun 2024 10:32:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFNFD7yhI3NZF3+Icm/wI2ujBuBVTfUlkptNZLWsrOO2xcdMg3izaHKkUvMsU4/GKnRXMmHKSbiWDr6edt7KM=
X-Received: by 2002:a17:902:a3ce:b0:1f9:b807:21ac with SMTP id
 d9443c01a7336-1f9b80721fcmr16180745ad.51.1718818376250; Wed, 19 Jun 2024
 10:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240619003012.1753577-1-jsnow@redhat.com>
 <20240619003012.1753577-14-jsnow@redhat.com>
 <87sex9xe5u.fsf@pond.sub.org>
In-Reply-To: <87sex9xe5u.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 19 Jun 2024 13:32:44 -0400
Message-ID: <CAFn=p-a5hPi_U9MP4Mjccv3typLQoMc-CuxjW_Um6-H8BMMRAQ@mail.gmail.com>
Subject: Re: [PATCH 13/13] qapi: convert "Example" sections to rST
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
Content-Type: multipart/alternative; boundary="000000000000c01c43061b4196b4"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

--000000000000c01c43061b4196b4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024, 9:20=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Eliminate the "Example" sections in QAPI doc blocks, converting them
> > into QMP example code blocks. This is generally done in this patch by
> > converting "Example:" or "Examples:" lines into ".. code-block:: QMP"
> > lines.
> >
> > The old "Example:" or "Examples:" syntax is now caught as an error; but
> > with the previous commit, "Example::" is still permitted as explicit rS=
T
> > syntax. ('Example' is not special in this case; any sentence that ends
> > with "::" will start an indented code block in rST.)
> >
> > The ".. code-block:: QMP" form explicitly applies the QMP lexer and wil=
l
> > loosely validate an example as valid QMP/JSON. The "::" form does not
> > apply any lexer in particular and will not emit any errors.
> >
> > It is possible to choose the QMP lexer with the "::" form by using the
> > Sphinx directive ".. highlight:: QMP" in the document above where the
> > example appears; but this changes the lexer for *all* subsequent "::"
> > style code-blocks in the document thereafter.
> >
> > This patch does not change the default lexer for the legacy qapidoc
> > generator documents; future patches for the new qapidoc generator *may*
> > change this default.
> >
> > This patch has several benefits:
> >
> > 1. Example sections can now be written more arbitrarily, mixing
> >    explanatory paragraphs and code blocks however desired.
> >
> > 2. "Example sections" can now use fully arbitrary rST.
>
> Do the double-quotes signify something I'm missing?
>

They aren't *sections* (QAPIDoc terminology) anymore, but was at a loss for
more precise phrasing.


> >
> > 3. All code blocks are now lexed and validated as QMP; increasing
> >    usability of the docs and ensuring validity of example snippets.
> >
> >    (To some extent - This patch only gaurantees it lexes correctly, not
> >    that it's valid under the JSON or QMP grammars. It will catch most
> >    small mistakes, however.)
> >
> > 4. Each code-block can be captioned independently without bypassing the
> >    QMP lexer/validator.
> >
> >    (i.e. code blocks are now for *code* only, so we don't have to
> >    sacrifice annotations/captions for having lexicographically correct
> >    examples.)
> >
> > For any sections with more than one example, examples are split up into
> > multiple code-block regions. If annotations are present, those
> > annotations are converted into code-block captions instead, e.g.
> >
> > ```
> > Examples:
> >
> >    1. Lorem Ipsum
> >
> >    -> { "foo": "bar" }
> > ```
> >
> > Is rewritten as:
> >
> > ```
> > .. code-block:: QMP
> >    :caption: Example: Lorem Ipsum
> >
> >    -> { "foo": "bar" }
> > ```
> >
> > This process was only semi-automated:
> >
> > 1. Replace "Examples?:" sections with sed:
> >
> > sed -i 's|# Example:|# .. code-block:: QMP|' *.json
> > sed -i 's|# Examples:|# .. code-block:: QMP|' *.json
> >
> > 2. Identify sections that no longer parse successfully by attempting th=
e
> >    doc build, convert annotations into captions manually.
> >    (Tedious, oh well.)
> >
> > 3. Add captions where still needed:
> >
> > sed -zi 's|# .. code-block:: QMP\n#\n|# .. code-block:: QMP\n#
> :caption: Example\n#\n|g' *.json
> >
> > Not fully ideal, but hopefully not something that has to be done very
> > often. (Or ever again.)
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > Acked-by: Stefan Hajnoczi <stefanha@redhat.com> [for block*.json]
>
> [...]
>
> > diff --git a/qapi/pci.json b/qapi/pci.json
> > index f51159a2c4c..9192212661b 100644
> > --- a/qapi/pci.json
> > +++ b/qapi/pci.json
> > @@ -182,7 +182,8 @@
> >  #
> >  # Since: 0.14
> >  #
> > -# Example:
> > +# .. code-block:: QMP
> > +#    :caption: Example
> >  #
> >  #     -> { "execute": "query-pci" }
> >  #     <- { "return": [
> > @@ -311,8 +312,7 @@
> >  #           ]
> >  #        }
> >  #
> > -#     Note: This example has been shortened as the real response is to=
o
> > -#     long.
> > +# This example has been shortened as the real response is too long.
>
> Squash into PATCH 09.
>
> >  #
> >  ##
> >  { 'command': 'query-pci', 'returns': ['PciInfo'] }
>
> Otherwise looks good to me except for the somewhat ugly rendering in
> HTML mentioned in the commit message.
>

ACK


> [...]
>
>

--000000000000c01c43061b4196b4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Jun 19, 2024, 9:20=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:js=
now@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&g=
t; writes:<br>
<br>
&gt; Eliminate the &quot;Example&quot; sections in QAPI doc blocks, convert=
ing them<br>
&gt; into QMP example code blocks. This is generally done in this patch by<=
br>
&gt; converting &quot;Example:&quot; or &quot;Examples:&quot; lines into &q=
uot;.. code-block:: QMP&quot;<br>
&gt; lines.<br>
&gt;<br>
&gt; The old &quot;Example:&quot; or &quot;Examples:&quot; syntax is now ca=
ught as an error; but<br>
&gt; with the previous commit, &quot;Example::&quot; is still permitted as =
explicit rST<br>
&gt; syntax. (&#39;Example&#39; is not special in this case; any sentence t=
hat ends<br>
&gt; with &quot;::&quot; will start an indented code block in rST.)<br>
&gt;<br>
&gt; The &quot;.. code-block:: QMP&quot; form explicitly applies the QMP le=
xer and will<br>
&gt; loosely validate an example as valid QMP/JSON. The &quot;::&quot; form=
 does not<br>
&gt; apply any lexer in particular and will not emit any errors.<br>
&gt;<br>
&gt; It is possible to choose the QMP lexer with the &quot;::&quot; form by=
 using the<br>
&gt; Sphinx directive &quot;.. highlight:: QMP&quot; in the document above =
where the<br>
&gt; example appears; but this changes the lexer for *all* subsequent &quot=
;::&quot;<br>
&gt; style code-blocks in the document thereafter.<br>
&gt;<br>
&gt; This patch does not change the default lexer for the legacy qapidoc<br=
>
&gt; generator documents; future patches for the new qapidoc generator *may=
*<br>
&gt; change this default.<br>
&gt;<br>
&gt; This patch has several benefits:<br>
&gt;<br>
&gt; 1. Example sections can now be written more arbitrarily, mixing<br>
&gt;=C2=A0 =C2=A0 explanatory paragraphs and code blocks however desired.<b=
r>
&gt;<br>
&gt; 2. &quot;Example sections&quot; can now use fully arbitrary rST.<br>
<br>
Do the double-quotes signify something I&#39;m missing?<br></blockquote></d=
iv></div><div dir=3D"auto"><br></div><div dir=3D"auto">They aren&#39;t *sec=
tions* (QAPIDoc terminology) anymore, but was at a loss for more precise ph=
rasing.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gm=
ail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">
<br>
&gt;<br>
&gt; 3. All code blocks are now lexed and validated as QMP; increasing<br>
&gt;=C2=A0 =C2=A0 usability of the docs and ensuring validity of example sn=
ippets.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 (To some extent - This patch only gaurantees it lexes cor=
rectly, not<br>
&gt;=C2=A0 =C2=A0 that it&#39;s valid under the JSON or QMP grammars. It wi=
ll catch most<br>
&gt;=C2=A0 =C2=A0 small mistakes, however.)<br>
&gt;<br>
&gt; 4. Each code-block can be captioned independently without bypassing th=
e<br>
&gt;=C2=A0 =C2=A0 QMP lexer/validator.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 (i.e. code blocks are now for *code* only, so we don&#39;=
t have to<br>
&gt;=C2=A0 =C2=A0 sacrifice annotations/captions for having lexicographical=
ly correct<br>
&gt;=C2=A0 =C2=A0 examples.)<br>
&gt;<br>
&gt; For any sections with more than one example, examples are split up int=
o<br>
&gt; multiple code-block regions. If annotations are present, those<br>
&gt; annotations are converted into code-block captions instead, e.g.<br>
&gt;<br>
&gt; ```<br>
&gt; Examples:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 1. Lorem Ipsum<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 -&gt; { &quot;foo&quot;: &quot;bar&quot; }<br>
&gt; ```<br>
&gt;<br>
&gt; Is rewritten as:<br>
&gt;<br>
&gt; ```<br>
&gt; .. code-block:: QMP<br>
&gt;=C2=A0 =C2=A0 :caption: Example: Lorem Ipsum<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 -&gt; { &quot;foo&quot;: &quot;bar&quot; }<br>
&gt; ```<br>
&gt;<br>
&gt; This process was only semi-automated:<br>
&gt;<br>
&gt; 1. Replace &quot;Examples?:&quot; sections with sed:<br>
&gt;<br>
&gt; sed -i &#39;s|# Example:|# .. code-block:: QMP|&#39; *.json<br>
&gt; sed -i &#39;s|# Examples:|# .. code-block:: QMP|&#39; *.json<br>
&gt;<br>
&gt; 2. Identify sections that no longer parse successfully by attempting t=
he<br>
&gt;=C2=A0 =C2=A0 doc build, convert annotations into captions manually.<br=
>
&gt;=C2=A0 =C2=A0 (Tedious, oh well.)<br>
&gt;<br>
&gt; 3. Add captions where still needed:<br>
&gt;<br>
&gt; sed -zi &#39;s|# .. code-block:: QMP\n#\n|# .. code-block:: QMP\n#=C2=
=A0 =C2=A0 :caption: Example\n#\n|g&#39; *.json<br>
&gt;<br>
&gt; Not fully ideal, but hopefully not something that has to be done very<=
br>
&gt; often. (Or ever again.)<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; Acked-by: Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">stefanha@redhat.com</a>&gt; [for block*=
.json]<br>
<br>
[...]<br>
<br>
&gt; diff --git a/qapi/pci.json b/qapi/pci.json<br>
&gt; index f51159a2c4c..9192212661b 100644<br>
&gt; --- a/qapi/pci.json<br>
&gt; +++ b/qapi/pci.json<br>
&gt; @@ -182,7 +182,8 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 0.14<br>
&gt;=C2=A0 #<br>
&gt; -# Example:<br>
&gt; +# .. code-block:: QMP<br>
&gt; +#=C2=A0 =C2=A0 :caption: Example<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0-&gt; { &quot;execute&quot;: &quot;query-pc=
i&quot; }<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0&lt;- { &quot;return&quot;: [<br>
&gt; @@ -311,8 +312,7 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0]<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 #<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0Note: This example has been shortened as the rea=
l response is too<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0long.<br>
&gt; +# This example has been shortened as the real response is too long.<b=
r>
<br>
Squash into PATCH 09.<br>
<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 { &#39;command&#39;: &#39;query-pci&#39;, &#39;returns&#39;: [&#=
39;PciInfo&#39;] }<br>
<br>
Otherwise looks good to me except for the somewhat ugly rendering in<br>
HTML mentioned in the commit message.<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">ACK</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>
<br>
[...]<br>
<br>
</blockquote></div></div></div>

--000000000000c01c43061b4196b4--


