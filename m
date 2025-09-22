Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CA8CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 06:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0aWP-0005jz-4Y; Mon, 22 Sep 2025 02:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1v0aWM-0005jf-AG
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 02:59:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1v0aWH-0008M5-7H
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 02:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758524367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ILFQ0Y0zW5Kk4VARyAnZVL1s/MWkh7ue8t8bDu5Saw=;
 b=TspPoSrN/U/57QdDOYwvUZ4DD7ZfjiW8dqOcW3F0SpKCDMIpasjpxXO/phDHjQhFwqAXLc
 qlTSmXKyBiosW8im/EEIkWqKlbxlhCVRqRZa/vBtFH6EZ37YKhuy1hgb2UWW60InOLehjT
 iQfh7pOZPK34+njrVXk1Nfd6ww5aDCE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-setGISLMO3eGRyWpVZSCJA-1; Mon, 22 Sep 2025 02:59:24 -0400
X-MC-Unique: setGISLMO3eGRyWpVZSCJA-1
X-Mimecast-MFC-AGG-ID: setGISLMO3eGRyWpVZSCJA_1758524364
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-244581953b8so47033825ad.2
 for <qemu-devel@nongnu.org>; Sun, 21 Sep 2025 23:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758524364; x=1759129164;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9ILFQ0Y0zW5Kk4VARyAnZVL1s/MWkh7ue8t8bDu5Saw=;
 b=qBaVcxfvKwNogNToXlk1dTs5Jhbsawn9Uk28hEwSIrsCtMiU3JanwJ7VgdR2rZOIZr
 nzGnMCa2cr8gRNEt4tWRdKGDutonmvCuQqkbY4m5vVS5VTHys4yy8cjmNxRwiEeNK+ol
 3KiZVRjJnnJTBen9BYGIeghcfE3hW0Ct3vjxzAso30ux5fsTP8dijrR5XG97A5nBJRE5
 vqQkhsBxXYfLyuwccS38SQ4drr/oHskS431ZMzUg2Lnv1sajdcE7Xh5yICqHHzi2nAHp
 5a0ZWDJqJUpahYCoxcBoodZAKdz6mWBAeklM6K1rNIX8CjnGcpQzy4JqUTJJezIlL+P2
 q1QA==
X-Gm-Message-State: AOJu0Yw5CFOknJa49FRUrEfQO+oFLjl75NWVIGughmMso3XqMHMq0e2m
 cKGa39CNtv6LTuq0iwQxIUN4uyXWyDtdfjzMMC37UYlprAh10OMCabnbPs9Ldtl7I/j6MvjsVcE
 DFBIrzkAFGMLRqbWaKyi4HubTCTAPUZPnIoeWBBmJuBIS+1WaHgSHolxPoQfbe/PjUxTtmKQ2n4
 uhjLu2DIiguI9+ejLwVi4wL4yYopbsqoA=
X-Gm-Gg: ASbGncv3MhyIvWVchcjzX5lHvVfw4lnadQP8mQHGim8nTBfB1LISIMNn1XO33HM58TR
 xJkuc4LC5SiiLbW2ojx9HGovnElIdHicvewD7+BxIW2PGhW0mMghxwXv1g3fTak2HoWu59LjnlM
 91+uuad17KJUveEykwcwklZ/JwPdQ=
X-Received: by 2002:a17:902:dac4:b0:275:c1e7:c7e with SMTP id
 d9443c01a7336-275c1e70ff3mr44242995ad.4.1758524363759; 
 Sun, 21 Sep 2025 23:59:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKlx++rpGs3gt2oX73ThG6GM02A7J5+ackY+jAYsna3RcZosg3Kf9Ey6pSLFdnh6qxrkMUYV/ullozzO5KSWs=
X-Received: by 2002:a17:902:dac4:b0:275:c1e7:c7e with SMTP id
 d9443c01a7336-275c1e70ff3mr44242745ad.4.1758524363322; Sun, 21 Sep 2025
 23:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250919133320.240145-1-marcandre.lureau@redhat.com>
 <20250919133320.240145-3-marcandre.lureau@redhat.com>
 <aM1fjf1tuzuBXudQ@redhat.com>
In-Reply-To: <aM1fjf1tuzuBXudQ@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 22 Sep 2025 10:59:11 +0400
X-Gm-Features: AS18NWAMgCSrZ83n8cO7sguj_0LMUhm-iYwEdbiWkfX66XlHVAkOI-Kyvk4_6p4
Message-ID: <CAMxuvawKG1h2mv3sHvm-e1n2M8N_DOpLxJROxCi4QkN-RHqkgQ@mail.gmail.com>
Subject: Re: [PATCH 02/24] scripts/archive-source: speed up downloading
 subprojects
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, 
 Yonggang Luo <luoyonggang@gmail.com>, Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, Kyle Evans <kevans@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000014ccc063f5e5ccf"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--000000000000014ccc063f5e5ccf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Sep 19, 2025 at 5:50=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Fri, Sep 19, 2025 at 05:32:56PM +0400, marcandre.lureau@redhat.com
> wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Running meson on each subproject is quite slow.
>
> Why is this faster ?  Does it make meson do parallel downloads
> if you list then all at once ?
>

It doesn't look like it does it in paralllel, yet it is x times faster...

time sh -c 'for s in keycodemapdb libvfio-user berkeley-softfloat-3
berkeley-testfloat-3 anyhow-1-rs arbitrary-int-1-rs bilge-0.2-rs
bilge-impl-0.2-rs either-1-rs foreign-0.3-rs itertools-0.11-rs libc-0.2-rs
proc-macro2-1-rs proc-macro-error-1-rs proc-macro-error-attr-1-rs
quote-1-rs syn-2-rs unicode-ident-1-rs; do
  meson subprojects download $s >/dev/null
done'
sh -c   5.27s user 0.33s system 99% cpu 5.613 total

time sh -c 'meson subprojects download keycodemapdb libvfio-user
berkeley-softfloat-3 berkeley-testfloat-3 anyhow-1-rs arbitrary-int-1-rs
bilge-0.2-rs bilge-impl-0.2-rs either-1-rs foreign-0.3-rs itertools-0.11-rs
libc-0.2-rs proc-macro2-1-rs proc-macro-error-1-rs
proc-macro-error-attr-1-rs quote-1-rs syn-2-rs unicode-ident-1-rs'
sh -c   0.32s user 0.01s system 99% cpu 0.339 total


>
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  scripts/archive-source.sh | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
> > index 035828c532..85cd0a63a0 100755
> > --- a/scripts/archive-source.sh
> > +++ b/scripts/archive-source.sh
> > @@ -77,9 +77,10 @@ function subproject_dir() {
> >  git archive --format tar "$(tree_ish)" > "$tar_file"
> >  test $? -ne 0 && error "failed to archive qemu"
> >
> > +meson subprojects download $subprojects
> > +test $? -ne 0 && error "failed to download subprojects $subprojects"
> > +
> >  for sp in $subprojects; do
> > -    meson subprojects download $sp
> > -    test $? -ne 0 && error "failed to download subproject $sp"
> >      tar --append --file "$tar_file" --exclude=3D.git
> subprojects/"$(subproject_dir $sp)"
> >      test $? -ne 0 && error "failed to append subproject $sp to
> $tar_file"
> >  done
> > --
> > 2.51.0
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--000000000000014ccc063f5e5ccf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 19, 2=
025 at 5:50=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berran=
ge@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">On Fri, Sep 19, 2025 at 05:32:56PM +0400,=
 <a href=3D"mailto:marcandre.lureau@redhat.com" target=3D"_blank">marcandre=
.lureau@redhat.com</a> wrote:<br>
&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
&gt; <br>
&gt; Running meson on each subproject is quite slow.<br>
<br>
Why is this faster ?=C2=A0 Does it make meson do parallel downloads<br>
if you list then all at once ?<br></blockquote><div><br></div><div>It doesn=
&#39;t look like it does it in paralllel, yet it is x times faster...</div>=
<div><br></div><div>time sh -c &#39;for s in keycodemapdb libvfio-user berk=
eley-softfloat-3 berkeley-testfloat-3 anyhow-1-rs arbitrary-int-1-rs bilge-=
0.2-rs bilge-impl-0.2-rs either-1-rs foreign-0.3-rs itertools-0.11-rs libc-=
0.2-rs proc-macro2-1-rs proc-macro-error-1-rs proc-macro-error-attr-1-rs qu=
ote-1-rs syn-2-rs unicode-ident-1-rs; do<br>=C2=A0 meson subprojects downlo=
ad $s &gt;/dev/null<br>done&#39;<br>sh -c =C2=A0 5.27s user 0.33s system 99=
% cpu 5.613 total</div><div><br></div><div>time sh -c &#39;meson subproject=
s download keycodemapdb libvfio-user berkeley-softfloat-3 berkeley-testfloa=
t-3 anyhow-1-rs arbitrary-int-1-rs bilge-0.2-rs bilge-impl-0.2-rs either-1-=
rs foreign-0.3-rs itertools-0.11-rs libc-0.2-rs proc-macro2-1-rs proc-macro=
-error-1-rs proc-macro-error-attr-1-rs quote-1-rs syn-2-rs unicode-ident-1-=
rs&#39;</div><div>sh -c =C2=A0 0.32s user 0.01s system 99% cpu 0.339 total<=
br>=C2=A0=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; <br>
&gt; Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.=
lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br=
>
&gt; ---<br>
&gt;=C2=A0 scripts/archive-source.sh | 5 +++--<br>
&gt;=C2=A0 1 file changed, 3 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh<br>
&gt; index 035828c532..85cd0a63a0 100755<br>
&gt; --- a/scripts/archive-source.sh<br>
&gt; +++ b/scripts/archive-source.sh<br>
&gt; @@ -77,9 +77,10 @@ function subproject_dir() {<br>
&gt;=C2=A0 git archive --format tar &quot;$(tree_ish)&quot; &gt; &quot;$tar=
_file&quot;<br>
&gt;=C2=A0 test $? -ne 0 &amp;&amp; error &quot;failed to archive qemu&quot=
;<br>
&gt;=C2=A0 <br>
&gt; +meson subprojects download $subprojects<br>
&gt; +test $? -ne 0 &amp;&amp; error &quot;failed to download subprojects $=
subprojects&quot;<br>
&gt; +<br>
&gt;=C2=A0 for sp in $subprojects; do<br>
&gt; -=C2=A0 =C2=A0 meson subprojects download $sp<br>
&gt; -=C2=A0 =C2=A0 test $? -ne 0 &amp;&amp; error &quot;failed to download=
 subproject $sp&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 tar --append --file &quot;$tar_file&quot; --exclud=
e=3D.git subprojects/&quot;$(subproject_dir $sp)&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 test $? -ne 0 &amp;&amp; error &quot;failed to app=
end subproject $sp to $tar_file&quot;<br>
&gt;=C2=A0 done<br>
&gt; -- <br>
&gt; 2.51.0<br>
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

--000000000000014ccc063f5e5ccf--


