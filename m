Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D59E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 21:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVdLA-0006zh-2L; Wed, 08 Jan 2025 16:11:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tVdL8-0006zR-1t
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:11:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tVdL5-0001ds-TF
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:11:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736370702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G3paryiEzLcMTdXSth0QTn6Dq7ETDO6sx5FXoYdoz7k=;
 b=BlsiAyZN2urgzvSmU5E3NKyf6HMrd34ouhQIaIkeFkWR7mbc1A0KVWLjQ3/cuiCTbcSEvq
 ckZqrOKWCRD+tzZYiHnB4w0dlthqYBR+sgwxFJq9Gron/dq337o1u7x2xRowlVw91FCKkH
 b5tA+Kng2PQX+EIIGwL9IpPGI9krwtk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-WFhRnlj9NKOZc5un21t7TQ-1; Wed, 08 Jan 2025 16:11:37 -0500
X-MC-Unique: WFhRnlj9NKOZc5un21t7TQ-1
X-Mimecast-MFC-AGG-ID: WFhRnlj9NKOZc5un21t7TQ
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ef9e38b0cfso386274a91.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 13:11:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736370696; x=1736975496;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G3paryiEzLcMTdXSth0QTn6Dq7ETDO6sx5FXoYdoz7k=;
 b=tXOqdO6PsS2fITbQFaOo4RbTnOiC4UvxBIoR96Fe3rQmKrzEp9kCsrEHTQElwCcR9V
 NvHDwCd7rj9K5YnNl5/z4xGBhhaxlwPD73A3IVUFZMm52oRVJb3X42l+/kuiztOyffHZ
 bv5PyALVcwMlN225mGaRQPAUg+JidlLKFjgkITEng0ePZ/M9JQOR+cGmOcQpg++GeI8F
 FZmGFZcIImT0dsD65jRAALosMdQ7Q+aI66/bvzZvHmIJrtaL/rzCA4UrZQg3lGe9v0g6
 IjUCghx7NaK1P3k+W7BFSLfMbaFRJiTvClmhXMcFaozzpkImrLzZfA8mg+urWRd4dATw
 CvBQ==
X-Gm-Message-State: AOJu0YxkHjii2cA8p0fH2Ze2dbOQg0hvwpUx9n225EyjFxT3fucBXCX4
 4S7bAul3PF2RTy1JwP4guYoP+MkYlpNEm7/vBcY49X1+ppecq5EFlv8cSLbtmUJGFwNFu07UyPi
 AcOPfkb/NTFNAlNbMUs1BFjHRYVvYLBLEMX9f9XV/B61Hor5ZNAdfftqVK+9g3Nezd9MIU4mA7x
 gF0rvzJWhE08SzD7X9o5kG0Pv8PSs=
X-Gm-Gg: ASbGncsboLIVdzXo23On8BQ5Npt2+mjjmU0H0J86ZRUYZY4OpLHL1PIPcBMUcLo3xpg
 iN7ItThSc5n5MqKPO13h27Msu0cg4ZoLcauUPNiFF/bpx8XfAGSwBESpvTw0xDQMvdGmnnA==
X-Received: by 2002:a17:90b:2c84:b0:2f4:47fc:7f18 with SMTP id
 98e67ed59e1d1-2f548ebb679mr6730577a91.10.1736370696431; 
 Wed, 08 Jan 2025 13:11:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqungkFrFod5T7mwgE30xL0kfwGMv1l0DUoxCDnagcycCKD9bztsu70kwT+R3idXSf3aUZwgJnQ0JrwiFLA/4=
X-Received: by 2002:a17:90b:2c84:b0:2f4:47fc:7f18 with SMTP id
 98e67ed59e1d1-2f548ebb679mr6730556a91.10.1736370696208; Wed, 08 Jan 2025
 13:11:36 -0800 (PST)
MIME-Version: 1.0
References: <20241213021827.2956769-1-jsnow@redhat.com>
 <20241213021827.2956769-18-jsnow@redhat.com>
 <878qsa302b.fsf@pond.sub.org>
In-Reply-To: <878qsa302b.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 8 Jan 2025 16:11:24 -0500
X-Gm-Features: AbW1kvaxH_VvjHq6H_JXNrnwgCfFR_TyplVU_j3l0tKxozaQjTjddzp8TGHl0z8
Message-ID: <CAFn=p-Y4AwYfgCVAWJ-tTCjnr0dwJ6EOnF4aNYXdd5VPTr__DQ@mail.gmail.com>
Subject: Re: [PATCH 17/23] docs/qapidoc: record current documented entity in
 transmogrifier
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="0000000000008bde94062b384e1a"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000008bde94062b384e1a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2024 at 9:23=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Keep a record of which entity we're working on documenting for the
> > purposes of being able to change certain generative features
> > conditionally and create stronger assertions.
> >
> > If you find yourself asking: "Wait, but where does the current entity
> > actually get recorded?!", you're right! That part comes with the
> > visit_entity() implementation, which gets added later.
>
> That's fine, except your title promises "record current documented
> entity".  Perhaps "Prepare to record entity being transmogrified".
>

Sometimes, I think I exist in a time and space that doesn't actually exist;
a hallucination of multiple timelines that might exist only in my own
consciousness. I'd be worried if I wasn't an ardent solipsist.

--js


>
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/sphinx/qapidoc.py | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> > index 02f434c09ab..c731c597daf 100644
> > --- a/docs/sphinx/qapidoc.py
> > +++ b/docs/sphinx/qapidoc.py
> > @@ -74,9 +74,15 @@ def dedent(text: str) -> str:
> >
> >  class Transmogrifier:
> >      def __init__(self, schema):
> > +        self._curr_ent =3D None
> >          self._result =3D StringList()
> >          self.indent =3D 0
> >
> > +    @property
> > +    def entity(self) -> QAPISchemaEntity:
> > +        assert self._curr_ent is not None
> > +        return self._curr_ent
> > +
> >      # General-purpose rST generation functions
> >
> >      def get_indent(self) -> str:
>
>

--0000000000008bde94062b384e1a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Dec 20,=
 2024 at 9:23=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Keep a record of which entity we&#39;re working on documenting for the=
<br>
&gt; purposes of being able to change certain generative features<br>
&gt; conditionally and create stronger assertions.<br>
&gt;<br>
&gt; If you find yourself asking: &quot;Wait, but where does the current en=
tity<br>
&gt; actually get recorded?!&quot;, you&#39;re right! That part comes with =
the<br>
&gt; visit_entity() implementation, which gets added later.<br>
<br>
That&#39;s fine, except your title promises &quot;record current documented=
<br>
entity&quot;.=C2=A0 Perhaps &quot;Prepare to record entity being transmogri=
fied&quot;.<br></blockquote><div><br></div><div>Sometimes, I think I exist =
in a time and space that doesn&#39;t actually exist; a hallucination of mul=
tiple timelines that might exist only in my own consciousness. I&#39;d be w=
orried if I wasn&#39;t an ardent solipsist.</div><div><br></div><div>--js<b=
r></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/sphinx/qapidoc.py | 6 ++++++<br>
&gt;=C2=A0 1 file changed, 6 insertions(+)<br>
&gt;<br>
&gt; diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py<br>
&gt; index 02f434c09ab..c731c597daf 100644<br>
&gt; --- a/docs/sphinx/qapidoc.py<br>
&gt; +++ b/docs/sphinx/qapidoc.py<br>
&gt; @@ -74,9 +74,15 @@ def dedent(text: str) -&gt; str:<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 class Transmogrifier:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def __init__(self, schema):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._curr_ent =3D None<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._result =3D StringList()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.indent =3D 0<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 @property<br>
&gt; +=C2=A0 =C2=A0 def entity(self) -&gt; QAPISchemaEntity:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert self._curr_ent is not None<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self._curr_ent<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 # General-purpose rST generation functions<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def get_indent(self) -&gt; str:<br>
<br>
</blockquote></div></div>

--0000000000008bde94062b384e1a--


