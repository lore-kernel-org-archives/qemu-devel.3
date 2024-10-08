Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322C3CEFC33
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 17:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syDgz-0002dF-P1; Tue, 08 Oct 2024 13:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1syDgw-0002ch-Hs
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 13:08:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1syDgu-0006OE-M8
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 13:08:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728407287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u4nvbUqJhwAR/bwOnuP86etRfbK4MPG0PTANBGRiNVM=;
 b=T2htCCbvktKBRB+FVphBX5BNAWybs2LC5KM/RKiNzu11RN2LybRNGNr1bt/guvgN21ZNDG
 Bjh9jovSusFYITFKDUhy/OsrviiLmKS9L17aZx8fptkwWxAGOb1POftk9v2EhMhoaSFgKP
 aQguwmvTbo7HH99kBKw2ZxZTtfCgxnM=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-WiDPqk8aO0u8Kvuy4gVE7w-1; Tue, 08 Oct 2024 13:08:04 -0400
X-MC-Unique: WiDPqk8aO0u8Kvuy4gVE7w-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-20afe0063e0so53827165ad.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 10:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728407282; x=1729012082;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u4nvbUqJhwAR/bwOnuP86etRfbK4MPG0PTANBGRiNVM=;
 b=Dhsma5bxcklg8hZX/pOywY+lECmREqvEFGl2L2R2Yl9l3LfF7aklq8yK++m6HpgvA/
 0ela8leQyUSkdOAHyv+zQ5EtPja5qHYUWcHH1owrmBeK0EtFQj6HJS7K5owYZ+eMpodw
 eawShHTr7kFlSochPlkhfd/aS5WGFtQtW+hc+xjawa5B5yceyKH5fZB6BU4SlE6HNoqx
 zLsrrRHrmrUHM/aTkaxbAR3nI6bU1CD+nIkt5ht4joZIEUtKoFTWkQ35j4CdwdjYr36a
 OkbEaTOF6Fx38oju3I7RSh2J6omOrkcT1j6QZL2XJs428YqXvb8a2L+yD0l24q+2WHtb
 pkfw==
X-Gm-Message-State: AOJu0YzQ8jHjW3GYFB155LMqoZ/QSd32PcQ46tBcSkEJVxrbjk71ioJq
 PPzGY1MkqwNBkeCbgDQyA3dD75c6KAkJjJs2j7N49qNRfjFJvDutmOAgAA0dxr1Su+eOxf1l4fx
 uw3m4LrnMFSvvvJNzi64FK3Bk9BLBGKl5CnHxvPwobF4jDnh987F7a6I2NBTEQxhZTg118fCxv9
 NT+KXCCxW/BvTi95YZ59slKWi5pBI=
X-Received: by 2002:a17:902:e743:b0:20b:4b88:a583 with SMTP id
 d9443c01a7336-20bfe0583f0mr310334245ad.13.1728407281654; 
 Tue, 08 Oct 2024 10:08:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAleQQq8g1lwWrIa2wd5Cavt7SfJ5e8I1IXJI4nUA/55ErAYG5WzalU8s3aY9uMUkflVM94fWNYR4N1980XkE=
X-Received: by 2002:a17:902:e743:b0:20b:4b88:a583 with SMTP id
 d9443c01a7336-20bfe0583f0mr310333885ad.13.1728407281316; Tue, 08 Oct 2024
 10:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_y6xYLyK_qEjngtCm+Y5-Yuw-rqK2Qm0UhVAFHtp610w@mail.gmail.com>
 <CAFn=p-ZU8sDP6xEN=AD6gN-OLCOgSOZ=WxfHZeCmzJVgwcYpcQ@mail.gmail.com>
 <CAFEAcA9k1-mRPOtehaf-+yLM8kpHpuGSs4rR8D9gLVZtQ99XxQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9k1-mRPOtehaf-+yLM8kpHpuGSs4rR8D9gLVZtQ99XxQ@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 8 Oct 2024 13:07:49 -0400
Message-ID: <CAFn=p-ZaZuDBG=ug1zr3gTssTRTo6q6DNtQpdggwukm11KW6wg@mail.gmail.com>
Subject: Re: qemu-iotests test 297 tries to run python linters on editor
 backup files
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000007d03c0623fa2edb"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--00000000000007d03c0623fa2edb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024, 1:03=E2=80=AFPM Peter Maydell <peter.maydell@linaro.or=
g> wrote:

> On Tue, 8 Oct 2024 at 17:50, John Snow <jsnow@redhat.com> wrote:
> >
> >
> >
> > On Tue, Oct 8, 2024, 12:31=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org>
> wrote:
> >>
> >> I made some changes to a block backend so I wanted to run the iotests.
> >> I ran into an unrelated failure of iotest 297. The bulk of this
> >> seems to be because the iotest tries to run on all files
> >> in qemu-iotests, even on editor backups like in this case "040~"
> >> (which is an old editor backup of 040). But there are also
> >> some warnings about files that do exist in the tree and which
> >> I haven't modified:
> >>
> >> +tests/migrate-bitmaps-test:63:4: R0201: Method could be a function
> >> (no-self-use)
> >> +tests/mirror-change-copy-mode:109:4: R0201: Method could be a
> >> function (no-self-use)
> >> +fat16.py:239:4: R0201: Method could be a function (no-self-use)
> >>
> >> Q1: can we make this test not run the linters on editor backup files?
> >
> >
> > Shouldn't be a problem. AFAIK we decide what to lint based on looking
> for the shebang in the file and exclude a known-bad list, but we can
> exclude the emacs confetti files too.
> >
> > I'll fix it.
>
> Thanks!
>
> >> Q2: why do I see the errors above but they aren't in the reference fil=
e
> >> output?
> >
> >
> > You mean, why are there errors in files you haven't modified?
>
> Yes, and/or "why isn't the test forcing a pylint version?"
> and/or "why is the test run by default if it depends on
> the pylint version?" :-)
>

"because it's always been like that and I've had difficulties fixing it",
mostly :)

qemu configure venv was the first step to finally fixing it, but I've run
into some troubles since but have been too busy with Sphinx junk.

I know it's bonkers, sorry!


> > Very likely: pylint version differences. I've been meaning to remove
> iotest 297 for a long time, but when you run it directly through iotests
> (i.e. not through the python directory tests, the ones that run on gitlab
> ci), the linter versions are not controlled for. It's a remaining ugly sp=
ot
> of the python consistency work. (sparing you the details on why but it's =
a
> known thing I need to fix.)
> >
> > In this case I bet "check-python-tox" (an optionally run, may-fail job)
> is also failing on gitlab and I didn't notice yet.
>
> I kicked off a job by hand, and yes, it fails, but apparently
> not for the same set of errors as the above...
>
> https://gitlab.com/qemu-project/qemu/-/jobs/8009902380
>
> > for now (assuming my guesses above are right): I'll fix 297 to tolerate
> the newest versions. As soon as I'm done my sphinx work, I'll pivot back =
to
> finally adding a "check python" subtest to "make check" that *does* contr=
ol
> linter versions, and delete iotest 297.
> >
> > Just in case my guesses are wrong, can you please go to your QEMU build
> directory (post-configure) and type:
> >
> > > source pyvenv/bin/activate.[whatever shell suffix you use]
> > > pylint --version
> > > deactivate
> >
> > and let me know what version of pylint you have in the qemu build
> environment?
>
> (pyvenv) e104462:jammy:x86-tgts$ pylint --version
> pylint 2.12.2
> astroid 2.9.3
> Python 3.10.12 (main, Sep 11 2024, 15:47:36) [GCC 11.4.0]
>
> (This is an Ubuntu 22.04 system.)
>
> thanks
> -- PMM
>

Great, thanks. will work on this today and get everything green again.

>

--00000000000007d03c0623fa2edb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, Oct 8, 2024, 1:03=E2=80=AFPM Peter Maydell &lt=
;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">On Tue, 8 Oct 2024 at 17:=
50, John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=
=3D"noreferrer">jsnow@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Tue, Oct 8, 2024, 12:31=E2=80=AFPM Peter Maydell &lt;<a href=3D"mai=
lto:peter.maydell@linaro.org" target=3D"_blank" rel=3D"noreferrer">peter.ma=
ydell@linaro.org</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; I made some changes to a block backend so I wanted to run the iote=
sts.<br>
&gt;&gt; I ran into an unrelated failure of iotest 297. The bulk of this<br=
>
&gt;&gt; seems to be because the iotest tries to run on all files<br>
&gt;&gt; in qemu-iotests, even on editor backups like in this case &quot;04=
0~&quot;<br>
&gt;&gt; (which is an old editor backup of 040). But there are also<br>
&gt;&gt; some warnings about files that do exist in the tree and which<br>
&gt;&gt; I haven&#39;t modified:<br>
&gt;&gt;<br>
&gt;&gt; +tests/migrate-bitmaps-test:63:4: R0201: Method could be a functio=
n<br>
&gt;&gt; (no-self-use)<br>
&gt;&gt; +tests/mirror-change-copy-mode:109:4: R0201: Method could be a<br>
&gt;&gt; function (no-self-use)<br>
&gt;&gt; +fat16.py:239:4: R0201: Method could be a function (no-self-use)<b=
r>
&gt;&gt;<br>
&gt;&gt; Q1: can we make this test not run the linters on editor backup fil=
es?<br>
&gt;<br>
&gt;<br>
&gt; Shouldn&#39;t be a problem. AFAIK we decide what to lint based on look=
ing for the shebang in the file and exclude a known-bad list, but we can ex=
clude the emacs confetti files too.<br>
&gt;<br>
&gt; I&#39;ll fix it.<br>
<br>
Thanks!<br>
<br>
&gt;&gt; Q2: why do I see the errors above but they aren&#39;t in the refer=
ence file<br>
&gt;&gt; output?<br>
&gt;<br>
&gt;<br>
&gt; You mean, why are there errors in files you haven&#39;t modified?<br>
<br>
Yes, and/or &quot;why isn&#39;t the test forcing a pylint version?&quot;<br=
>
and/or &quot;why is the test run by default if it depends on<br>
the pylint version?&quot; :-)<br></blockquote></div></div><div dir=3D"auto"=
><br></div><div dir=3D"auto">&quot;because it&#39;s always been like that a=
nd I&#39;ve had difficulties fixing it&quot;, mostly :)</div><div dir=3D"au=
to"><br></div><div dir=3D"auto">qemu configure venv was the first step to f=
inally fixing it, but I&#39;ve run into some troubles since but have been t=
oo busy with Sphinx junk.</div><div dir=3D"auto"><br></div><div dir=3D"auto=
">I know it&#39;s bonkers, sorry!</div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; Very likely: pylint version differences. I&#39;ve been meaning to remo=
ve iotest 297 for a long time, but when you run it directly through iotests=
 (i.e. not through the python directory tests, the ones that run on gitlab =
ci), the linter versions are not controlled for. It&#39;s a remaining ugly =
spot of the python consistency work. (sparing you the details on why but it=
&#39;s a known thing I need to fix.)<br>
&gt;<br>
&gt; In this case I bet &quot;check-python-tox&quot; (an optionally run, ma=
y-fail job) is also failing on gitlab and I didn&#39;t notice yet.<br>
<br>
I kicked off a job by hand, and yes, it fails, but apparently<br>
not for the same set of errors as the above...<br>
<br>
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/8009902380" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qem=
u/-/jobs/8009902380</a><br>
<br>
&gt; for now (assuming my guesses above are right): I&#39;ll fix 297 to tol=
erate the newest versions. As soon as I&#39;m done my sphinx work, I&#39;ll=
 pivot back to finally adding a &quot;check python&quot; subtest to &quot;m=
ake check&quot; that *does* control linter versions, and delete iotest 297.=
<br>
&gt;<br>
&gt; Just in case my guesses are wrong, can you please go to your QEMU buil=
d directory (post-configure) and type:<br>
&gt;<br>
&gt; &gt; source pyvenv/bin/activate.[whatever shell suffix you use]<br>
&gt; &gt; pylint --version<br>
&gt; &gt; deactivate<br>
&gt;<br>
&gt; and let me know what version of pylint you have in the qemu build envi=
ronment?<br>
<br>
(pyvenv) e104462:jammy:x86-tgts$ pylint --version<br>
pylint 2.12.2<br>
astroid 2.9.3<br>
Python 3.10.12 (main, Sep 11 2024, 15:47:36) [GCC 11.4.0]<br>
<br>
(This is an Ubuntu 22.04 system.)<br>
<br>
thanks<br>
-- PMM<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"=
auto">Great, thanks. will work on this today and get everything green again=
.</div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">
</blockquote></div></div></div>

--00000000000007d03c0623fa2edb--


