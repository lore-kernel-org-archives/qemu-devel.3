Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024AAC25B7A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 17:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7eya-00074E-5T; Thu, 16 May 2024 13:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s7eyY-00073m-1D
 for qemu-devel@nongnu.org; Thu, 16 May 2024 13:33:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s7eyW-0002sE-6Q
 for qemu-devel@nongnu.org; Thu, 16 May 2024 13:33:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715880782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bFbhp34npFZca/lPfYkcMAL53WDvbGiDJcr6qspwVqg=;
 b=ZcUpBBeBDq1e56q/G40eAGRZUeeyS2nTeJ4ofIIX+cgLc1opUFl6ntdywdJj1xqAeam2xZ
 mBkTytkmg5+SrrtpBpp0HfmsVBmMlxm+Sbc2EcvNhZzDur5DKKdbC9J2XkCfKZSC40qR+D
 0bczHFQsyBHYPpklF1QzPLbX2NcayzY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-tqyq6LKzOICMaJ0mskcuPQ-1; Thu, 16 May 2024 13:33:01 -0400
X-MC-Unique: tqyq6LKzOICMaJ0mskcuPQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-34e08bdc701so5283721f8f.3
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 10:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715880780; x=1716485580;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bFbhp34npFZca/lPfYkcMAL53WDvbGiDJcr6qspwVqg=;
 b=WCmwo3u4hwF2CRAEcPgpq0etweF6j6hk3f/TWC7W/zNMHrYdnvuf+j7tvU/8/6jZLm
 1dfY5DrG0fIwIGvnUnKQx1CIDZhYVE5xqGshQRAkPmko4GMBHY6FN6ux8qBupIfJWZ5M
 5VCbRxfviYCBXr3NXQ5BX3fvtUBQuSHWZkkl9MwhMkrn/yytdc/Ro9IAmtsYnn7zRj3f
 LQmZWnpw5sfHGE6lJbpJ9KoLFIshXIylx5YZrA6hyGzzFOzBCAeexiGCj23nK4LIEt40
 FLfO4ds72XPgxrapEHWClSn5530kIIdzhnUxx37ToXTjMHUxyn0lGbtIv14N4akgAx++
 vwzg==
X-Gm-Message-State: AOJu0YzjfPnC1MkYwNPmYrhTbER0g3Xs80tgIJe1oL5P2yy0YZ7F7F95
 7+SlLhO7HKg9iqyE/6p3z2FOsMhslXAHzvInWGd+wfOWg2uZW0jysiHKs1zFaqRzPGJeK5weXn3
 sYZINbBWoz4ib6NBYHfKjxqqoFhUFAToAvWvj2SHprxND6/EP0c8NHD5vXg4BTzptwD2jAw3Ye8
 R/mvPViJDqpnZGhllpVCpW5xRacG4=
X-Received: by 2002:adf:eb45:0:b0:34e:b6b8:80e3 with SMTP id
 ffacd0b85a97d-3504a96881amr12231226f8f.47.1715880779879; 
 Thu, 16 May 2024 10:32:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuWIoO+qn858UsVlzyPLvXtVKyjJywGelTrlQ0AOx9izQ6Gby8pIHlaNdZG7LpnIZ5ayY9XcqDxqpWChHrkTM=
X-Received: by 2002:adf:eb45:0:b0:34e:b6b8:80e3 with SMTP id
 ffacd0b85a97d-3504a96881amr12231196f8f.47.1715880779572; Thu, 16 May 2024
 10:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240514215740.940155-1-jsnow@redhat.com>
 <20240514215740.940155-7-jsnow@redhat.com>
 <875xvepa64.fsf@pond.sub.org>
In-Reply-To: <875xvepa64.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 16 May 2024 13:32:46 -0400
Message-ID: <CAFn=p-YbP7tH8qxRapEDV5tF=5ShDXx9ULquwU_Mu0-un0i==g@mail.gmail.com>
Subject: Re: [PATCH 06/20] qapi/parser: fix comment parsing immediately
 following a doc block
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, 
 Ani Sinha <anisinha@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Kevin Wolf <kwolf@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Mads Ynddal <mads@ynddal.dk>, 
 Jason Wang <jasowang@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Victor Toso de Carvalho <victortoso@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, Lukas Straub <lukasstraub2@web.de>, 
 Yanan Wang <wangyanan55@huawei.com>, Hanna Reitz <hreitz@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000580360061895a01c"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

--000000000000580360061895a01c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 2:01=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > If a comment immediately follows a doc block, the parser doesn't ignore
> > that token appropriately. Fix that.
>
> Reproducer?
>
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/parser.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> > index 41b9319e5cb..161768b8b96 100644
> > --- a/scripts/qapi/parser.py
> > +++ b/scripts/qapi/parser.py
> > @@ -587,7 +587,7 @@ def get_doc(self) -> 'QAPIDoc':
> >                  line =3D self.get_doc_line()
> >                  first =3D False
> >
> > -        self.accept(False)
> > +        self.accept()
> >          doc.end()
> >          return doc
>
> Can't judge the fix without understanding the problem, and the problem
> will be easier to understand for me with a reproducer.
>

audio.json:

```
##
# =3D Audio
##

##
# @AudiodevPerDirectionOptions:
#
# General audio backend options that are used for both playback and
# recording.
#
```

Modify this excerpt to have a comment after the "=3D Audio" header, say for
instance if you were to take out that intro paragraph and transform it into
a comment that preceded the AudiodevPerDirectionOptions doc block.

e.g.

```
##
# =3D Audio
##

# Lorem Ipsum

##
# @AudiodevPerDirectionOptions:
```

the parser breaks because the line I changed that primes the next token is
still set to "not ignore comments", but that breaks the parser and gives a
rather unhelpful message:

../qapi/audio.json:13:1: junk after '##' at start of documentation comment

Encountered when converting developer commentary from documentation
paragraphs to mere QAPI comments.

--js

--000000000000580360061895a01c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, May 16, 2024 at 2:01=E2=80=AF=
AM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank">jsn=
ow@redhat.com</a>&gt; writes:<br>
<br>
&gt; If a comment immediately follows a doc block, the parser doesn&#39;t i=
gnore<br>
&gt; that token appropriately. Fix that.<br>
<br>
Reproducer?<br>
<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 scripts/qapi/parser.py | 2 +-<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py<br>
&gt; index 41b9319e5cb..161768b8b96 100644<br>
&gt; --- a/scripts/qapi/parser.py<br>
&gt; +++ b/scripts/qapi/parser.py<br>
&gt; @@ -587,7 +587,7 @@ def get_doc(self) -&gt; &#39;QAPIDoc&#39;:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 line =3D=
 self.get_doc_line()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 first =
=3D False<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.accept(False)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.accept()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 doc.end()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return doc<br>
<br>
Can&#39;t judge the fix without understanding the problem, and the problem<=
br>
will be easier to understand for me with a reproducer.<br></blockquote><div=
><br></div><div>audio.json:</div><div><br></div><div>```<br></div><div>##<b=
r># =3D Audio<br>##<br><br>##<br># @AudiodevPerDirectionOptions:<br>#<br># =
General audio backend options that are used for both playback and<br># reco=
rding.<br>#</div><div>```</div><div><br></div><div>Modify this excerpt to h=
ave a comment after the &quot;=3D Audio&quot; header, say for instance if y=
ou were to take out that intro paragraph and transform it into a comment th=
at preceded the AudiodevPerDirectionOptions doc block.</div><div><br></div>=
<div>e.g.</div><div><br></div><div>```<br></div><div>##</div><div># =3D Aud=
io</div><div>##</div><div><br></div><div># Lorem Ipsum</div><div><br></div>=
##<br># @AudiodevPerDirectionOptions:</div><div class=3D"gmail_quote">```<b=
r></div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">the=
 parser breaks because the line I changed that primes the next token is sti=
ll set to &quot;not ignore comments&quot;, but that breaks the parser and g=
ives a rather unhelpful message:<br></div><div class=3D"gmail_quote"><br></=
div><div class=3D"gmail_quote">../qapi/audio.json:13:1: junk after &#39;##&=
#39; at start of documentation comment</div><div class=3D"gmail_quote"><br>=
</div><div class=3D"gmail_quote">Encountered when converting developer comm=
entary from documentation paragraphs to mere QAPI comments.<br></div><div c=
lass=3D"gmail_quote"><br></div><div class=3D"gmail_quote">--js<br></div><di=
v class=3D"gmail_quote"><br></div></div>

--000000000000580360061895a01c--


