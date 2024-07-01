Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61D0C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 23:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOQnd-0002TO-1t; Mon, 01 Jul 2024 19:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sOQna-0002Sk-W4
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 19:51:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sOQnY-0005E2-PH
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 19:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719877863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WEGks9uA82NhCP38UaC7cUKi018i/owZcpFUNtNQymI=;
 b=DvyIe+IYvBVN3GTZtW0kV0Z/jLedqF3NNJLyxcWD/VrqidCLWx9OsnO5wyqZiexgCqzhnM
 KiOfDHORmkdLJR2dGbbWu0pq6dxjqjQRqOIPItS9SrJGaJ0Gl1sL4EPX7ru+rrtWHR2I80
 Q2jFgO87nxs4IboTyh4jTsIR0HbO4Wo=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-T-TPJWgOP-SRBHg8kR0MKA-1; Mon, 01 Jul 2024 19:50:59 -0400
X-MC-Unique: T-TPJWgOP-SRBHg8kR0MKA-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2c8f8388f60so2320464a91.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 16:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719877858; x=1720482658;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WEGks9uA82NhCP38UaC7cUKi018i/owZcpFUNtNQymI=;
 b=f9AjHvYwRUSdvyuVDvvc6KZ9nTgDHeT37Vt4WZxaz40gxwRbC2wqh/VfVKCiamagSq
 40OgzasrcVrZaGW/gnZOHK5QfkAE+BUJ6kNcOLSsnbjXCPYCzetdR4qoMIznchpvAmW4
 omOWiKVCL6vV37VvelXCGBIdHJezdMGAqM8hrCZR8K8w2eu+kNXQjiQZWZ4uNi+39xbJ
 h9VDS2cs8hTb4oZ3zmz73aKbjoz4o486dQtlNj2Ivdgpern8v8cOtxpqQ2/SPAFhMwdk
 Kgo7hi6KnTyMb4FtxxEF0TA17VEbUGUhpF0EM83rMyVlI5fi62pjiV06E3YZ3snMe+hR
 dhPQ==
X-Gm-Message-State: AOJu0YxzpiulkIGw+UOIzE8V8UOZpBDQvszS8mgZ2yF1LwQ44sGxU+2w
 BT2JK+uVyxIpHnnxNVsON/GNlwzxPr4G0UMkCWsp5uAl3E8sGdvq3Bt1QJ2m8EfTyImLOdseIea
 jtd2Mm8ebH5mx4IbmvwpUMqKkL7S5kOjudQmbYZKKxL6ansysO8lE1/B0MW2VaNwePHdR8SYBDf
 ZWXStaFqcDd+c98MAiPjPDMWoeaFA=
X-Received: by 2002:a17:90a:1c08:b0:2c5:10a6:e989 with SMTP id
 98e67ed59e1d1-2c93d75a3d5mr4059656a91.35.1719877858243; 
 Mon, 01 Jul 2024 16:50:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMGjk890O09o5/axo0mJFxD3VB/r3sXD9XtRqepk9HilPUESn0neSThkB7RkS5ZXdmKpp0C7YVYEIldoZHebc=
X-Received: by 2002:a17:90a:1c08:b0:2c5:10a6:e989 with SMTP id
 98e67ed59e1d1-2c93d75a3d5mr4059648a91.35.1719877857809; Mon, 01 Jul 2024
 16:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240628112756.794237-1-armbru@redhat.com>
In-Reply-To: <20240628112756.794237-1-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 1 Jul 2024 19:50:45 -0400
Message-ID: <CAFn=p-bA8teBvvVg3ieYZfC9=j5rb18Fvxoow3Z+WjrDOU82kw@mail.gmail.com>
Subject: Re: [PATCH] sphinx/qapidoc: Fix to generate doc for explicit,
 unboxed arguments
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>, qemu-stable@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000c5b068061c384446"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000c5b068061c384446
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024, 7:28=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> When a command's arguments are specified as an explicit type T,
> generated documentation points to the members of T.
>
> Example:
>
>     ##
>     # @announce-self:
>     #
>     # Trigger generation of broadcast RARP frames to update network
>     [...]
>     ##
>     { 'command': 'announce-self', 'boxed': true,
>       'data' : 'AnnounceParameters'}
>
> generates
>
>     "announce-self" (Command)
>     -------------------------
>
>     Trigger generation of broadcast RARP frames to update network
>     [...]
>
>     Arguments
>     ~~~~~~~~~
>
>     The members of "AnnounceParameters"
>
> Except when the command takes its arguments unboxed , i.e. it doesn't
> have 'boxed': true, we generate *nothing*.  A few commands have a
> reference in their doc comment to compensate, but most don't.
>
> Example:
>
>     ##
>     # @blockdev-snapshot-sync:
>     #
>     # Takes a synchronous snapshot of a block device.
>     #
>     # For the arguments, see the documentation of BlockdevSnapshotSync.
>     [...]
>     ##
>     { 'command': 'blockdev-snapshot-sync',
>       'data': 'BlockdevSnapshotSync',
>       'allow-preconfig': true }
>
> generates
>
>     "blockdev-snapshot-sync" (Command)
>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>     Takes a synchronous snapshot of a block device.
>
>     For the arguments, see the documentation of BlockdevSnapshotSync.
>     [...]
>
> Same for event data.
>
> Fix qapidoc.py to generate the reference regardless of boxing.  Delete
> now redundant references in the doc comments.
>
> Fixes: 4078ee5469e5 (docs/sphinx: Add new qapi-doc Sphinx extension)
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>

LGTM

Didn't test because my branch is a mess at the moment but I don't see
anything obviously wrong.

If it breaks something I'm sure I'll find out, so

Reviewed-by: John Snow <jsnow@redhat.com>


---
>  docs/sphinx/qapidoc.py | 12 +++++-------
>  qapi/block-core.json   |  7 -------
>  2 files changed, 5 insertions(+), 14 deletions(-)
>
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index f270b494f0..aacb2cd721 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -219,15 +219,15 @@ def _nodes_for_enum_values(self, doc):
>          section +=3D dlnode
>          return [section]
>
> -    def _nodes_for_arguments(self, doc, boxed_arg_type):
> +    def _nodes_for_arguments(self, doc, arg_type):
>          """Return list of doctree nodes for the arguments section"""
> -        if boxed_arg_type:
> +        if arg_type and not arg_type.is_implicit():
>              assert not doc.args
>              section =3D self._make_section('Arguments')
>              dlnode =3D nodes.definition_list()
>              dlnode +=3D self._make_dlitem(
>                  [nodes.Text('The members of '),
> -                 nodes.literal('', boxed_arg_type.name)],
> +                 nodes.literal('', arg_type.name)],
>                  None)
>              section +=3D dlnode
>              return [section]
> @@ -332,8 +332,7 @@ def visit_command(self, name, info, ifcond, features,
> arg_type,
>                        allow_preconfig, coroutine):
>          doc =3D self._cur_doc
>          self._add_doc('Command',
> -                      self._nodes_for_arguments(doc,
> -                                                arg_type if boxed else
> None)
> +                      self._nodes_for_arguments(doc, arg_type)
>                        + self._nodes_for_features(doc)
>                        + self._nodes_for_sections(doc)
>                        + self._nodes_for_if_section(ifcond))
> @@ -341,8 +340,7 @@ def visit_command(self, name, info, ifcond, features,
> arg_type,
>      def visit_event(self, name, info, ifcond, features, arg_type, boxed)=
:
>          doc =3D self._cur_doc
>          self._add_doc('Event',
> -                      self._nodes_for_arguments(doc,
> -                                                arg_type if boxed else
> None)
> +                      self._nodes_for_arguments(doc, arg_type)
>                        + self._nodes_for_features(doc)
>                        + self._nodes_for_sections(doc)
>                        + self._nodes_for_if_section(ifcond))
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index df5e07debd..c5cb0c5d56 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1675,8 +1675,6 @@
>  #
>  # Takes a synchronous snapshot of a block device.
>  #
> -# For the arguments, see the documentation of BlockdevSnapshotSync.
> -#
>  # Errors:
>  #     - If @device is not a valid block device, DeviceNotFound
>  #
> @@ -1705,8 +1703,6 @@
>  # device, the block device changes to using 'overlay' as its new
>  # active image.
>  #
> -# For the arguments, see the documentation of BlockdevSnapshot.
> -#
>  # Features:
>  #
>  # @allow-write-only-overlay: If present, the check whether this
> @@ -6065,9 +6061,6 @@
>  # string, or a snapshot with name already exists, the operation will
>  # fail.
>  #
> -# For the arguments, see the documentation of
> -# BlockdevSnapshotInternal.
> -#
>  # Errors:
>  #     - If @device is not a valid block device, GenericError
>  #     - If any snapshot matching @name exists, or @name is empty,
> --
> 2.45.0
>
>

--000000000000c5b068061c384446
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, Jun 28, 2024, 7:28=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">When a command&#39;s arguments are=
 specified as an explicit type T,<br>
generated documentation points to the members of T.<br>
<br>
Example:<br>
<br>
=C2=A0 =C2=A0 ##<br>
=C2=A0 =C2=A0 # @announce-self:<br>
=C2=A0 =C2=A0 #<br>
=C2=A0 =C2=A0 # Trigger generation of broadcast RARP frames to update netwo=
rk<br>
=C2=A0 =C2=A0 [...]<br>
=C2=A0 =C2=A0 ##<br>
=C2=A0 =C2=A0 { &#39;command&#39;: &#39;announce-self&#39;, &#39;boxed&#39;=
: true,<br>
=C2=A0 =C2=A0 =C2=A0 &#39;data&#39; : &#39;AnnounceParameters&#39;}<br>
<br>
generates<br>
<br>
=C2=A0 =C2=A0 &quot;announce-self&quot; (Command)<br>
=C2=A0 =C2=A0 -------------------------<br>
<br>
=C2=A0 =C2=A0 Trigger generation of broadcast RARP frames to update network=
<br>
=C2=A0 =C2=A0 [...]<br>
<br>
=C2=A0 =C2=A0 Arguments<br>
=C2=A0 =C2=A0 ~~~~~~~~~<br>
<br>
=C2=A0 =C2=A0 The members of &quot;AnnounceParameters&quot;<br>
<br>
Except when the command takes its arguments unboxed , i.e. it doesn&#39;t<b=
r>
have &#39;boxed&#39;: true, we generate *nothing*.=C2=A0 A few commands hav=
e a<br>
reference in their doc comment to compensate, but most don&#39;t.<br>
<br>
Example:<br>
<br>
=C2=A0 =C2=A0 ##<br>
=C2=A0 =C2=A0 # @blockdev-snapshot-sync:<br>
=C2=A0 =C2=A0 #<br>
=C2=A0 =C2=A0 # Takes a synchronous snapshot of a block device.<br>
=C2=A0 =C2=A0 #<br>
=C2=A0 =C2=A0 # For the arguments, see the documentation of BlockdevSnapsho=
tSync.<br>
=C2=A0 =C2=A0 [...]<br>
=C2=A0 =C2=A0 ##<br>
=C2=A0 =C2=A0 { &#39;command&#39;: &#39;blockdev-snapshot-sync&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 &#39;data&#39;: &#39;BlockdevSnapshotSync&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 &#39;allow-preconfig&#39;: true }<br>
<br>
generates<br>
<br>
=C2=A0 =C2=A0 &quot;blockdev-snapshot-sync&quot; (Command)<br>
=C2=A0 =C2=A0 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
<br>
=C2=A0 =C2=A0 Takes a synchronous snapshot of a block device.<br>
<br>
=C2=A0 =C2=A0 For the arguments, see the documentation of BlockdevSnapshotS=
ync.<br>
=C2=A0 =C2=A0 [...]<br>
<br>
Same for event data.<br>
<br>
Fix qapidoc.py to generate the reference regardless of boxing.=C2=A0 Delete=
<br>
now redundant references in the doc comments.<br>
<br>
Fixes: 4078ee5469e5 (docs/sphinx: Add new qapi-doc Sphinx extension)<br>
Cc: <a href=3D"mailto:qemu-stable@nongnu.org" target=3D"_blank" rel=3D"nore=
ferrer">qemu-stable@nongnu.org</a><br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;<br></blockquo=
te></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">LGTM</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">Didn&#39;t test because my branch=
 is a mess at the moment but I don&#39;t see anything obviously wrong.</div=
><div dir=3D"auto"><br></div><div dir=3D"auto">If it breaks something I&#39=
;m sure I&#39;ll find out, so</div><div dir=3D"auto"><br></div><div dir=3D"=
auto">Reviewed-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com">jsnow@=
redhat.com</a>&gt;</div><div dir=3D"auto"><br></div><div dir=3D"auto"><br><=
/div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">
---<br>
=C2=A0docs/sphinx/qapidoc.py | 12 +++++-------<br>
=C2=A0qapi/block-core.json=C2=A0 =C2=A0|=C2=A0 7 -------<br>
=C2=A02 files changed, 5 insertions(+), 14 deletions(-)<br>
<br>
diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py<br>
index f270b494f0..aacb2cd721 100644<br>
--- a/docs/sphinx/qapidoc.py<br>
+++ b/docs/sphinx/qapidoc.py<br>
@@ -219,15 +219,15 @@ def _nodes_for_enum_values(self, doc):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0section +=3D dlnode<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return [section]<br>
<br>
-=C2=A0 =C2=A0 def _nodes_for_arguments(self, doc, boxed_arg_type):<br>
+=C2=A0 =C2=A0 def _nodes_for_arguments(self, doc, arg_type):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Return list of doctree =
nodes for the arguments section&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if boxed_arg_type:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if arg_type and not arg_type.is_implicit():<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert not doc.args<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0section =3D self._make_sect=
ion(&#39;Arguments&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dlnode =3D nodes.definition=
_list()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dlnode +=3D self._make_dlit=
em(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[nodes.Text(&=
#39;The members of &#39;),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nodes.litera=
l(&#39;&#39;, <a href=3D"http://boxed_arg_type.name" rel=3D"noreferrer nore=
ferrer" target=3D"_blank">boxed_arg_type.name</a>)],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nodes.litera=
l(&#39;&#39;, <a href=3D"http://arg_type.name" rel=3D"noreferrer noreferrer=
" target=3D"_blank">arg_type.name</a>)],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0None)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0section +=3D dlnode<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return [section]<br>
@@ -332,8 +332,7 @@ def visit_command(self, name, info, ifcond, features, a=
rg_type,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0allow_preconfig, coroutine):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0doc =3D self._cur_doc<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._add_doc(&#39;Command&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 self._nodes_for_arguments(doc,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 arg_type if boxed else None)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 self._nodes_for_arguments(doc, arg_type)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0+ self._nodes_for_features(doc)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0+ self._nodes_for_sections(doc)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0+ self._nodes_for_if_section(ifcond))<br>
@@ -341,8 +340,7 @@ def visit_command(self, name, info, ifcond, features, a=
rg_type,<br>
=C2=A0 =C2=A0 =C2=A0def visit_event(self, name, info, ifcond, features, arg=
_type, boxed):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0doc =3D self._cur_doc<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._add_doc(&#39;Event&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 self._nodes_for_arguments(doc,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 arg_type if boxed else None)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 self._nodes_for_arguments(doc, arg_type)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0+ self._nodes_for_features(doc)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0+ self._nodes_for_sections(doc)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0+ self._nodes_for_if_section(ifcond))<br>
diff --git a/qapi/block-core.json b/qapi/block-core.json<br>
index df5e07debd..c5cb0c5d56 100644<br>
--- a/qapi/block-core.json<br>
+++ b/qapi/block-core.json<br>
@@ -1675,8 +1675,6 @@<br>
=C2=A0#<br>
=C2=A0# Takes a synchronous snapshot of a block device.<br>
=C2=A0#<br>
-# For the arguments, see the documentation of BlockdevSnapshotSync.<br>
-#<br>
=C2=A0# Errors:<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0- If @device is not a valid block device, Device=
NotFound<br>
=C2=A0#<br>
@@ -1705,8 +1703,6 @@<br>
=C2=A0# device, the block device changes to using &#39;overlay&#39; as its =
new<br>
=C2=A0# active image.<br>
=C2=A0#<br>
-# For the arguments, see the documentation of BlockdevSnapshot.<br>
-#<br>
=C2=A0# Features:<br>
=C2=A0#<br>
=C2=A0# @allow-write-only-overlay: If present, the check whether this<br>
@@ -6065,9 +6061,6 @@<br>
=C2=A0# string, or a snapshot with name already exists, the operation will<=
br>
=C2=A0# fail.<br>
=C2=A0#<br>
-# For the arguments, see the documentation of<br>
-# BlockdevSnapshotInternal.<br>
-#<br>
=C2=A0# Errors:<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0- If @device is not a valid block device, Generi=
cError<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0- If any snapshot matching @name exists, or @nam=
e is empty,<br>
-- <br>
2.45.0<br>
<br>
</blockquote></div></div></div>

--000000000000c5b068061c384446--


