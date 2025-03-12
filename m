Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12773C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 14:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsMnj-0003T4-Um; Wed, 12 Mar 2025 10:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tsMne-0003SL-UB
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:11:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tsMna-0001dM-5c
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741788663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZfDJkr80rE0A5Ty+yK7hcwpEySqLg6UrBMpDUcvhRzg=;
 b=WFxktZxU5KybrI9724hTJtszerWRZbZInhDAeg0TchajX3dMPTmLsh8tjr2kpsSd2/Mg4V
 MOJ3hNsEJpg66uWDnfzizxQKDvbpAVA44/3MU1O0T49UZkBOkeGvu5xadL7hARUl7IgpM6
 VfTyi/yKgFbFqHpX1wD5sR8fAeNtlCo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-tR_kpM8kMjiVHNxujSfhFA-1; Wed, 12 Mar 2025 10:11:00 -0400
X-MC-Unique: tR_kpM8kMjiVHNxujSfhFA-1
X-Mimecast-MFC-AGG-ID: tR_kpM8kMjiVHNxujSfhFA_1741788660
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6ead629f6c6so7468946d6.2
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 07:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741788660; x=1742393460;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZfDJkr80rE0A5Ty+yK7hcwpEySqLg6UrBMpDUcvhRzg=;
 b=SWw1Ovy1/869WPteNlIez7+v8vpdyyaE/vC+aJ9tpG4XXVNoCeOsllaJW38l09yiis
 U/ArnpmWzjvLfPNT0aZv4lB2t0hWCD1wRGeldZQv4ue4xtrNJMSPwqszA2QfTA03RIZz
 rVDrgU9CfNka0wg9oSTCznY5nI+nz0aEV2OAaAt2IH/Pjrk61hOItsfFjy6+i5DJPwdx
 3tkXxFruevT/D0yoJxwBdZJy+Gbpiamh2fLp4DIb8k3PZLjUsB7TpILRtejgaLw7NBzw
 zqnGSAXWtNNh/poGO7oyb5qV31uuzcEjTFffkC4oBJ7jnwNpYJb/PbAXN4DlDYX1oHvH
 gPTQ==
X-Gm-Message-State: AOJu0YzFpe/nB1rkIyjKZajUtbTf9xRVcqP+c7SdZzaG3VmIjZhLXsgU
 x6eTmetaqsljUJg4Oi/PAjQhgr590VH0JK0we6+0IP1M+VN3Pg5ECmgnp+5bXyJIubADkWDoM+B
 5hkaU8CmYE/Bh4aZc8pBFPbuNJ6WgaPmvzRT0C7b9xG1iJzaerBoGjb4fAs5yE5n+vgqrchK9r0
 d/mBqvLeZzTKRUinRpcUG0Y2CXETVpMMP2TQeZhQ==
X-Gm-Gg: ASbGnct2lUBUscGLvIY4BwXl1LnIAX8a+xzCSTobreLrChMBuVoFm08WTPWYCqDl07B
 Z7lOCH/J6+o3gZcMylET2/FgNlZ0Pu9SC9ucTBvGA2cf3My1Y4czM6m1uvkbjGzIPJ2Agghh1lN
 M=
X-Received: by 2002:a05:6214:1c4c:b0:6d8:a7e1:e270 with SMTP id
 6a1803df08f44-6e90068cbb0mr266867776d6.40.1741788659770; 
 Wed, 12 Mar 2025 07:10:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/80qTD0DEr47NoDKYyPXvaZ4ykxN8WoH+wXDbYmDUKR31wmYceqlY0/5ESyI2Fc2c1RNZFK6vtD/MIF1CX4Y=
X-Received: by 2002:a05:6214:1c4c:b0:6d8:a7e1:e270 with SMTP id
 6a1803df08f44-6e90068cbb0mr266867326d6.40.1741788659454; Wed, 12 Mar 2025
 07:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMcbCquaBmWhx3jWBKMC1oLrMZBUVhfWFcW=_5uhVqOep4NWw@mail.gmail.com>
 <Z9GUldol1IQT1uiY@redhat.com>
In-Reply-To: <Z9GUldol1IQT1uiY@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Wed, 12 Mar 2025 16:10:47 +0200
X-Gm-Features: AQ5f1JomS32LUe3hp2CTb7JarXzBOCDBQ5XqzOiJti7IBGPNQrBDgwKLmv9W17I
Message-ID: <CAPMcbCpwY_VmMjNnSzvHxhQO9FxRPfa1TwDkV7nNQLxJTqxSOQ@mail.gmail.com>
Subject: Re: Cross-compilation artifact is broken
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005223f3063025c611"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--0000000000005223f3063025c611
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I can provide the full log, but I see on GitLab CI the same results
https://gitlab.com/qemu-project/qemu/-/jobs/9368756844

[3417/3430] Linking target tests/qtest/fuzz-e1000e-test.exe
/usr/lib/gcc/x86_64-w64-mingw32/14.1.1/../../../../x86_64-w64-mingw32/bin/l=
d:
tests/qtest/fuzz-e1000e-test.exe:/4: section below image base
/usr/lib/gcc/x86_64-w64-mingw32/14.1.1/../../../../x86_64-w64-mingw32/bin/l=
d:
tests/qtest/fuzz-e1000e-test.exe:/24: section below image base

Best Regards,
Konstantin Kostiuk.


On Wed, Mar 12, 2025 at 4:05=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Wed, Mar 12, 2025 at 03:52:45PM +0200, Konstantin Kostiuk wrote:
> > Hi All,
> >
> > I cross-compiled qemu-ga from current master branch
> > (825b96dbcee23d134b691fc75618b59c5f53da32) and found strange behavior.
> >
> > Configure CLI:
> > ./configure --disable-docs --disable-system --disable-user
> > --cross-prefix=3Dx86_64-w64-mingw32- --enable-guest-agent
> > --disable-guest-agent-msi --disable-qga-vss
> > Build CLI:
> > make -j8 qemu-ga
> >
> > Linker wrote the following information but exited with 0 code:
> >
> >
> /usr/lib/gcc/x86_64-w64-mingw32/14.2.0/../../../../x86_64-w64-mingw32/bin=
/ld:
> > qga/qemu-ga.exe:/4: section below image base
> >
> /usr/lib/gcc/x86_64-w64-mingw32/14.2.0/../../../../x86_64-w64-mingw32/bin=
/ld:
> > qga/qemu-ga.exe:/24: section below image base
> >
> > As a result, this binary failed to start on Windows without any details=
,
> > just a message that the application is not compatible. I also tried to
> run
> > it with wine and got the error:
> >
> > wine: failed to start
> > L"Z:\\home\\user\\Documents\\repos\\qemu\\build\\qga\\qemu-ga.exe"
> > Application could not be started, or no application associated with the
> > specified file.
> > ShellExecuteEx failed: Bad EXE format for
> > Z:\home\user\Documents\repos\qemu\build\qga\qemu-ga.exe.
> >
> > I bisected the tree and found the commit that caused the problem:
> >
> https://gitlab.com/qemu-project/qemu/-/commit/563b1a35ed1f1151505d4fe5f72=
3827d1b3fd4bc
> >
> > Adding --disable-split-debug to the configure CLI fixes the issue.
> >
> > $ x86_64-w64-mingw32-gcc --version
> > x86_64-w64-mingw32-gcc (GCC) 14.2.0
> >
> > My question is, is this expected behavior or is this a bug?
>
> Your configure args don't include "--enable-debug", so I would
> not have expected -gsplit-dwarf to have been enabled, so I'm
> surprised that commit casued a problem.
>
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

--0000000000005223f3063025c611
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I can provide the full log, but I see on GitLab CI th=
e same results <a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/93687=
56844">https://gitlab.com/qemu-project/qemu/-/jobs/9368756844</a></div><div=
><br></div><div><code class=3D"gmail-job-log gmail-gl-block"><div class=3D"=
gmail-js-log-line gmail-job-log-line"><span class=3D"gmail-job-log-line-con=
tent"><span class=3D"gmail-">[3417/3430] Linking target tests/qtest/fuzz-e1=
000e-test.exe</span></span></div><div class=3D"gmail-js-log-line gmail-job-=
log-line"></div></code><code class=3D"gmail-job-log gmail-gl-block"><div cl=
ass=3D"gmail-js-log-line gmail-job-log-line"><span class=3D"gmail-job-log-l=
ine-content"><span class=3D"gmail-">/usr/lib/gcc/x86_64-w64-mingw32/14.1.1/=
../../../../x86_64-w64-mingw32/bin/ld: tests/qtest/fuzz-e1000e-test.exe:/4:=
 section below image base</span></span></div><div class=3D"gmail-js-log-lin=
e gmail-job-log-line"></div></code><code class=3D"gmail-job-log gmail-gl-bl=
ock"><span class=3D"gmail-job-log-line-content"><span class=3D"gmail-">/usr=
/lib/gcc/x86_64-w64-mingw32/14.1.1/../../../../x86_64-w64-mingw32/bin/ld: t=
ests/qtest/fuzz-e1000e-test.exe:/24: section below image base</span></span>=
</code></div><div><br></div><div><div dir=3D"ltr" class=3D"gmail_signature"=
 data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div>Best Regards,</di=
v><div>Konstantin Kostiuk.</div></div></div></div><br></div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">On Wed, Mar 12, 2025 at 4:05=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a hr=
ef=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, Mar 12, 2025 a=
t 03:52:45PM +0200, Konstantin Kostiuk wrote:<br>
&gt; Hi All,<br>
&gt; <br>
&gt; I cross-compiled qemu-ga from current master branch<br>
&gt; (825b96dbcee23d134b691fc75618b59c5f53da32) and found strange behavior.=
<br>
&gt; <br>
&gt; Configure CLI:<br>
&gt; ./configure --disable-docs --disable-system --disable-user<br>
&gt; --cross-prefix=3Dx86_64-w64-mingw32- --enable-guest-agent<br>
&gt; --disable-guest-agent-msi --disable-qga-vss<br>
&gt; Build CLI:<br>
&gt; make -j8 qemu-ga<br>
&gt; <br>
&gt; Linker wrote the following information but exited with 0 code:<br>
&gt; <br>
&gt; /usr/lib/gcc/x86_64-w64-mingw32/14.2.0/../../../../x86_64-w64-mingw32/=
bin/ld:<br>
&gt; qga/qemu-ga.exe:/4: section below image base<br>
&gt; /usr/lib/gcc/x86_64-w64-mingw32/14.2.0/../../../../x86_64-w64-mingw32/=
bin/ld:<br>
&gt; qga/qemu-ga.exe:/24: section below image base<br>
&gt; <br>
&gt; As a result, this binary failed to start on Windows without any detail=
s,<br>
&gt; just a message that the application is not compatible. I also tried to=
 run<br>
&gt; it with wine and got the error:<br>
&gt; <br>
&gt; wine: failed to start<br>
&gt; L&quot;Z:\\home\\user\\Documents\\repos\\qemu\\build\\qga\\qemu-ga.exe=
&quot;<br>
&gt; Application could not be started, or no application associated with th=
e<br>
&gt; specified file.<br>
&gt; ShellExecuteEx failed: Bad EXE format for<br>
&gt; Z:\home\user\Documents\repos\qemu\build\qga\qemu-ga.exe.<br>
&gt; <br>
&gt; I bisected the tree and found the commit that caused the problem:<br>
&gt; <a href=3D"https://gitlab.com/qemu-project/qemu/-/commit/563b1a35ed1f1=
151505d4fe5f723827d1b3fd4bc" rel=3D"noreferrer" target=3D"_blank">https://g=
itlab.com/qemu-project/qemu/-/commit/563b1a35ed1f1151505d4fe5f723827d1b3fd4=
bc</a><br>
&gt; <br>
&gt; Adding --disable-split-debug to the configure CLI fixes the issue.<br>
&gt; <br>
&gt; $ x86_64-w64-mingw32-gcc --version<br>
&gt; x86_64-w64-mingw32-gcc (GCC) 14.2.0<br>
&gt; <br>
&gt; My question is, is this expected behavior or is this a bug?<br>
<br>
Your configure args don&#39;t include &quot;--enable-debug&quot;, so I woul=
d<br>
not have expected -gsplit-dwarf to have been enabled, so I&#39;m<br>
surprised that commit casued a problem.<br>
<br>
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
</blockquote></div>

--0000000000005223f3063025c611--


