Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA721C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTl1c-0007Am-U6; Tue, 16 Jul 2024 12:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sTl0n-0005wl-1X
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:26:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sTl0j-0006Kq-Mx
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721147201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7l9CBISZik38Vx75LgqGCvK2l7cFB1yAmxB0URF1Cpc=;
 b=EurDWzSjrmZ/iRyliUjIh/XzjQow1826jahN9smRjcU61aj2vMnU9amwSTx7bpBS+5rGsU
 EbsblF7BS/3RdR7ZXYG8dHAZVtPzChqrC0f8uXgeRm7X1itN406ZnQ4I2bnk1Y6aCxJkHO
 kiwEmiOGRJAk3yXtIjfOeqF9t+IP7D4=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-sXLenXwQPSOmHVbUVjlSWw-1; Tue, 16 Jul 2024 12:26:37 -0400
X-MC-Unique: sXLenXwQPSOmHVbUVjlSWw-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-70b45a51792so5804175b3a.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 09:26:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721147196; x=1721751996;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7l9CBISZik38Vx75LgqGCvK2l7cFB1yAmxB0URF1Cpc=;
 b=Qb6sBOHr0WJdWvj7waexunxmURepyfhi2Q4iPN+1OWj2b0Y0iJWiuBwgb4H9Pu9+yw
 AkgcFs+pwBGlQte0kM16LYTPZN0sjSBKLTfONqmOSzIOZ9gm5hL1WwyLHnhY9S+9lkdB
 PrKIKkOWKnijwE3FhIqF/ZTtERJDO6lYwuY/68ZIoj6MPrNDnNjVbhXiCvT2JSU23xpb
 yXLIfCTd1UJOuP5CkRhlsCfwtJh+2/YmLuJs6cjdBFk1XnG6vJIoCCZXY6A+1Y/0nRkm
 IqNN5ov/okYRv9dfXD7bZXqtrYZsR6U7RC6EKr/rOOAIZ7AgjK4t3Oa5pZv8hC+Sr1N7
 C6DA==
X-Gm-Message-State: AOJu0Yw1gVybPQEQgeF02LQu6OgSIWkoxHZtLRdolJ32hVRv1z4dmULS
 v8HmWCRvUIwyj+znTZqdUbme1jGGcFIGM/FLnYWzg2K8tkXXi06XnQpLpYEqft2gYpCK1ShkGYy
 WU9Cixwv9QXFzgNf5mr6rybPE+ZDQV0WnCoINPXjLEy7Q7MuVNZzW0bp3U7JJ8iEiXfeiufmF3a
 VTZYQy2gDJ2YgfPG5DrIxkyoEO9CY=
X-Received: by 2002:a05:6a20:729c:b0:1c1:89f8:8609 with SMTP id
 adf61e73a8af0-1c3f10e02d5mr3646562637.0.1721147195906; 
 Tue, 16 Jul 2024 09:26:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHao9KQrgvW+wn22BHCWz7xTFx+CT6aMsnM4EAKWuez0xRy5xFf847iZhkR6xTDWACvuLJkZ8cffPItSq3TkhY=
X-Received: by 2002:a05:6a20:729c:b0:1c1:89f8:8609 with SMTP id
 adf61e73a8af0-1c3f10e02d5mr3646534637.0.1721147195506; Tue, 16 Jul 2024
 09:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <qemu-stable-9.0.2-20240715075000@cover.tls.msk.ru>
 <20240715093435.571721-4-mjt@tls.msk.ru>
In-Reply-To: <20240715093435.571721-4-mjt@tls.msk.ru>
From: John Snow <jsnow@redhat.com>
Date: Tue, 16 Jul 2024 12:26:22 -0400
Message-ID: <CAFn=p-ZdYjn-FTZQa_abCUodp4=LU_sf2Mbm-syoFz=7BMkNzg@mail.gmail.com>
Subject: Re: [Stable-9.0.2 26/27] sphinx/qapidoc: Fix to generate doc for
 explicit, unboxed arguments
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-stable@nongnu.org, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000031d39b061d5fcf2d"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--00000000000031d39b061d5fcf2d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024, 5:34=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> wrot=
e:

> From: Markus Armbruster <armbru@redhat.com>
>
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
> Message-ID: <20240628112756.794237-1-armbru@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> (cherry picked from commit e389929d19a543ea5b34d02553b355f9f1c03162)
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
>

Just do me a favor and test build the html docs in the stable branch and
verify that they appear to render correctly with a quick visual glance --
we've been poking around a lot in that area.

I don't see any obvious point of conflict in this patch, but I have a
nagging doubt.

As long as they build and they look alright, I'm confident it's fine.


> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index 8d428c64b0..8d3518e887 100644
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
> @@ -331,8 +331,7 @@ def visit_command(self, name, info, ifcond, features,
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
> @@ -340,8 +339,7 @@ def visit_command(self, name, info, ifcond, features,
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
> index 746d1694c2..4b18e01b85 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1671,8 +1671,6 @@
>  #
>  # Takes a synchronous snapshot of a block device.
>  #
> -# For the arguments, see the documentation of BlockdevSnapshotSync.
> -#
>  # Errors:
>  #     - If @device is not a valid block device, DeviceNotFound
>  #
> @@ -1701,8 +1699,6 @@
>  # device, the block device changes to using 'overlay' as its new
>  # active image.
>  #
> -# For the arguments, see the documentation of BlockdevSnapshot.
> -#
>  # Features:
>  #
>  # @allow-write-only-overlay: If present, the check whether this
> @@ -6061,9 +6057,6 @@
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
> 2.39.2
>
>

--00000000000031d39b061d5fcf2d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Mon, Jul 15, 2024, 5:34=E2=80=AFAM Michael Tokarev =
&lt;<a href=3D"mailto:mjt@tls.msk.ru">mjt@tls.msk.ru</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">From: Markus Armbruster &lt;<a href=3D"mai=
lto:armbru@redhat.com" target=3D"_blank" rel=3D"noreferrer">armbru@redhat.c=
om</a>&gt;<br>
<br>
When a command&#39;s arguments are specified as an explicit type T,<br>
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
arget=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;<br>
Message-ID: &lt;<a href=3D"mailto:20240628112756.794237-1-armbru@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">20240628112756.794237-1-armbru@redha=
t.com</a>&gt;<br>
Reviewed-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_b=
lank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
(cherry picked from commit e389929d19a543ea5b34d02553b355f9f1c03162)<br>
Signed-off-by: Michael Tokarev &lt;<a href=3D"mailto:mjt@tls.msk.ru" target=
=3D"_blank" rel=3D"noreferrer">mjt@tls.msk.ru</a>&gt;<br></blockquote></div=
></div><div dir=3D"auto"><br></div><div dir=3D"auto">Just do me a favor and=
 test build the html docs in the stable branch and verify that they appear =
to render correctly with a quick visual glance -- we&#39;ve been poking aro=
und a lot in that area.</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
I don&#39;t see any obvious point of conflict in this patch, but I have a n=
agging doubt.</div><div dir=3D"auto"><br></div><div dir=3D"auto">As long as=
 they build and they look alright, I&#39;m confident it&#39;s fine.</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">
<br>
diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py<br>
index 8d428c64b0..8d3518e887 100644<br>
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
@@ -331,8 +331,7 @@ def visit_command(self, name, info, ifcond, features, a=
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
@@ -340,8 +339,7 @@ def visit_command(self, name, info, ifcond, features, a=
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
index 746d1694c2..4b18e01b85 100644<br>
--- a/qapi/block-core.json<br>
+++ b/qapi/block-core.json<br>
@@ -1671,8 +1671,6 @@<br>
=C2=A0#<br>
=C2=A0# Takes a synchronous snapshot of a block device.<br>
=C2=A0#<br>
-# For the arguments, see the documentation of BlockdevSnapshotSync.<br>
-#<br>
=C2=A0# Errors:<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0- If @device is not a valid block device, Device=
NotFound<br>
=C2=A0#<br>
@@ -1701,8 +1699,6 @@<br>
=C2=A0# device, the block device changes to using &#39;overlay&#39; as its =
new<br>
=C2=A0# active image.<br>
=C2=A0#<br>
-# For the arguments, see the documentation of BlockdevSnapshot.<br>
-#<br>
=C2=A0# Features:<br>
=C2=A0#<br>
=C2=A0# @allow-write-only-overlay: If present, the check whether this<br>
@@ -6061,9 +6057,6 @@<br>
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
2.39.2<br>
<br>
</blockquote></div></div></div>

--00000000000031d39b061d5fcf2d--


