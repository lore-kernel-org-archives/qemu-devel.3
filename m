Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84976CA0EFD
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 17:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk5oR-0004an-9w; Fri, 30 Aug 2024 13:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sk5oO-0004a8-Ax
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 13:53:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sk5oJ-0005Ju-Rs
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 13:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725040401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KOuc8CEpJgPhxnnNzEB1z62qRsLxZZODQy39OEpNVyo=;
 b=bGWOiy0eop4na+3loxQa/81Uz7Z7c9wWEcRvo+F19ood8DIBmOG3VxtKGfaBxc86utO3kd
 5k1f+rm5Ae5aVJn1L4TRHn1+zzOXm0zissCgDE3imD3faVLtwhukw4eD5XfJOc8cudI3+m
 F/Dq54hUUe4s7iGa81B6iftujJVrI9Y=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-v_lu6whGMyO2CEa4isgiaQ-1; Fri, 30 Aug 2024 13:53:19 -0400
X-MC-Unique: v_lu6whGMyO2CEa4isgiaQ-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-7ad78c1a019so1786264a12.2
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 10:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725040399; x=1725645199;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KOuc8CEpJgPhxnnNzEB1z62qRsLxZZODQy39OEpNVyo=;
 b=kTQJlmXZ0lO/AByg6/HPSyCtnkajMYi2xvzM1afceeni7Fa26ksQC5OG6NPaXfQjkC
 R7/zb4i94U6+w/jkJvF7E296f/txXUBGzF3n69CFSyiahBQa8ajxXle9aVQVagpeEkwG
 p1Cx44Lwp4PvHb2SaNan1N3Wj+nRROXsA9NsCwDa8wU2kpW6OWFPL8bqPeAtkgMp8/rw
 JiHdMZ/99qGKVwrkpnhT3Kb6iBORi2Dn3okH96y+beihsQHfvjDarVURHPN1KjDyC/2K
 SMeKh9YYj1aOLxM2uCfSyu1Ka4pWIOSh9j/hnZ/JUEQJnUIIyQ4SPFiVDfcampjBTKEM
 b2RQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzOvSKaKucgDapCxZvQB2lD4937FLafGKFH1YkPJls39t0XIFWShNuPGVmndqJVX8SOTAmGp2ZXt9O@nongnu.org
X-Gm-Message-State: AOJu0YyRNw0R3seozp+H9BcGt48oM/QP5HQVZxFCqXPxIJttUL3jG7di
 LrLmEj7fR5DMylcngoB+Sy0dT8R6cRTFMJ/4hEsrlE1pDRKBE/YXpeYFR4/qGjpWbzV+RYVEKHs
 IrNtIHHaowo7jXOrhkDF/3vN+EZkwExeDqJlV/nW9U4F9APcEIz0pMQg9ueHoeF5oLihGrfcKw2
 laMw9fQfmJ8pwd/TmbotbfE/SDU80=
X-Received: by 2002:a17:903:1c3:b0:205:2918:3d8e with SMTP id
 d9443c01a7336-20529183ffbmr27877715ad.43.1725040398490; 
 Fri, 30 Aug 2024 10:53:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHME18CMAl+xS13gapycNlLMMxyg+3+i6Ulo+BwAxiad+U2mpKV3/5K4loARHDiMqdfGKoSRiMMIk3s3LhKYlQ=
X-Received: by 2002:a17:903:1c3:b0:205:2918:3d8e with SMTP id
 d9443c01a7336-20529183ffbmr27877455ad.43.1725040398010; Fri, 30 Aug 2024
 10:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240820002318.1380276-1-jsnow@redhat.com>
 <20240820002318.1380276-8-jsnow@redhat.com>
 <87bk1acl4s.fsf@pond.sub.org> <ZtGtHHXW6uFjaNPz@redhat.com>
In-Reply-To: <ZtGtHHXW6uFjaNPz@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Fri, 30 Aug 2024 13:53:05 -0400
Message-ID: <CAFn=p-b--XFvHrG09nikvXdOsBr4NOoaLkURYfS0GEsYVzA1Hg@mail.gmail.com>
Subject: Re: [PATCH 7/8] python/qapi: move scripts/qapi to python/qemu/qapi
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Beraldo Leal <bleal@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000025a7f30620ea449f"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--00000000000025a7f30620ea449f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 7:29=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Fri, Aug 30, 2024 at 01:20:35PM +0200, Markus Armbruster wrote:
> > John Snow <jsnow@redhat.com> writes:
> >
> > > This is being done for the sake of unifying the linting and static ty=
pe
> > > analysis configurations between scripts/qapi and python/qemu/*.
> > >
> > > With this change, the qapi module will now be checked by mypy, flake8=
,
> > > pylint, isort etc under all python versions from 3.8 through 3.13 und=
er
> > > a variety of different dependency configurations in the GitLab testin=
g
> > > pipelines.
> > >
> > > The tests can be run locally, as always:
> > >
> > >> cd qemu.git/python
> > >> make check-minreqs
> > >> make check-tox
> > >> make check-dev
> > >
> > > "check-minreqs" is the must-pass GitLab test.
> > > "check-tox" is the optional allowed-to-fail GitLab test.
> > >
> > > Signed-off-by: John Snow <jsnow@redhat.com>
> >
> > I don't understand why we have to keep Python code in its own directory
> > just to get it checked.  We wouldn't do that say for Rust code, would
> > we?  Anyway, if it's the price of checking, I'll pay[*].
>
> The 'check-tox' target is defined in python/Makefile, and is
> written to only check code below that location, which is a
> somewhat arbitrary choice.
>
> Having this in "make" at all is a bit outdated. Ideally all
> the targets in python/Makefile should be converted into meson
> targets and/or tests, in a "python" suite.
>

Yes, ideally, but there are still gaps between the python tooling ecosystem
and our own conventions in the QEMU source tree. Saying "everything under
python/ should adhere to python ecosystem conventions" was just an
extremely convenient way to make python tooling not throw a hissy fit over
stuff in that directory. The "make" targets in that directory are really
just simple script invocations that we don't really need "make" for at all,
it's just so I don't have to re-explain how to invoke the tests as they
stand. I don't think it's "outdated" in that sense, it's just a nice little
syntactic shorthand using a tool people are familiar with - not too far out
from what we do for the VM tests.

One of the barriers to implementing this in "make check" et al is setting
up the package installation needed for e.g. mypy and the optional feature
packages (like urwid, fusepy, etc) in a way that is unobtrusive to the
build system. The build-time configure venv was a step in that direction,
but the work remains unfinished.

I am in the process (right now!) of setting up mkvenv to install the
in-tree python packages to the configure venv - one of the barriers *here*
is that this is a little bit slow with older setuptools, and due to very
tumultuous changes in Python packaging in the last several years (fallout
from PEP-517, PEP-518 and PEP-660) is that it is taking me a good long
while to ensure it's rock solid across all of our supported platforms while
supporting isolated offline builds. (Python stuff was really, really,
really not designed to cope very well with that restriction, I have learned
in the last few years.)

Another reason for the decision to treat the python/ subdirectory as a
"mini-repository" was purely for sake of ease with splitting out
subpackages that became useful beyond the confines of our castle walls:
qemu.qmp in particular. By structuring everything here like an upstream
package, it becomes pretty trivial to fork things out into standalone
packages, because they're already structured identically to how standalone
packages would be.

TLDR: "It makes my life easier to follow python ecosystem norms in this
directory, but I still want to integrate it more formally to the QEMU build
system and am working on that."


>
> IOW, we should make 'check-tox' a target in meson.build at the
> top level, and have it check any .py file in the source tree,
> with an exclude list for files we know are not "clean" yet,
> so we don't have to move stuff around as we clean up individual
> files.
>

Maybe someday.

Right now, I consider anything under python/ to be "maintained" for the
python ecosystem and anything outside of this to be "good luck!".

I do not volunteer to apply the same level of effort I do for python/ to
*every last python script in the tree*. The standards I apply in python/
are vastly more strict than those that could apply to everything else; I
don't think I could handle the workload of polishing every last python
thing in the tree up to the same standard. qemu.qmp, qemu.machine and qapi
are just vastly more important than the majority of one-off scripts that
automate niche tasks I have no domain expertise in.

For any python scripts with import dependencies on other in-tree modules,
it is useful to structure those imported modules as normal packages so that
mypy, pylint, etc can function with minimal fuss and without needing lots
of prone-to-breakage environment hacks and custom launcher scripts to make
them work. Anything that *doesn't* need to import anything else from the
tree is relatively easy to check where it lives, I just don't do that at
the moment. It's possible we could make a separate test that applies a much
lower bar of type checking and linting that really only catches *hard*
errors and applies to everything in the tree automatically, but I don't
think I want to lower the bar for the stuff already in python/.

That said, I *do* want to move the python tests into our usual build
testing infrastructure, there's just some more work to do with mkvenv to
bridge the gap, which I'm working on currently.


>
> >
> > [...]
> >
> > > diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
> > > index f3518d29a54..42912c91716 100644
> > > --- a/scripts/qapi-gen.py
> > > +++ b/scripts/qapi-gen.py
> > > @@ -11,9 +11,11 @@
> > >  execution environment.
> > >  """
> > >
> > > +import os
> > >  import sys
> > >
> > > -from qapi import main
> > > +sys.path.append(os.path.join(os.path.dirname(__file__), '..',
> 'python'))
> > > +from qemu.qapi import main
> > >
> > >  if __name__ =3D=3D '__main__':
> > >      sys.exit(main.main())
> >
> > Suggest to use the opportunity to rename to just qapi-gen (no .py) and
> > chmod +x, possibly in a separate patch.
> >
> > [...]
> >
> >
> > [*] Grudgingly.
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

--00000000000025a7f30620ea449f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 30, 2024 at 7:29=E2=80=AF=
AM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berra=
nge@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On Fri, Aug 30, 2024 at 01:20:35PM +0200, Markus Armbruster w=
rote:<br>
&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank">js=
now@redhat.com</a>&gt; writes:<br>
&gt; <br>
&gt; &gt; This is being done for the sake of unifying the linting and stati=
c type<br>
&gt; &gt; analysis configurations between scripts/qapi and python/qemu/*.<b=
r>
&gt; &gt;<br>
&gt; &gt; With this change, the qapi module will now be checked by mypy, fl=
ake8,<br>
&gt; &gt; pylint, isort etc under all python versions from 3.8 through 3.13=
 under<br>
&gt; &gt; a variety of different dependency configurations in the GitLab te=
sting<br>
&gt; &gt; pipelines.<br>
&gt; &gt;<br>
&gt; &gt; The tests can be run locally, as always:<br>
&gt; &gt;<br>
&gt; &gt;&gt; cd qemu.git/python<br>
&gt; &gt;&gt; make check-minreqs<br>
&gt; &gt;&gt; make check-tox<br>
&gt; &gt;&gt; make check-dev<br>
&gt; &gt;<br>
&gt; &gt; &quot;check-minreqs&quot; is the must-pass GitLab test.<br>
&gt; &gt; &quot;check-tox&quot; is the optional allowed-to-fail GitLab test=
.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" =
target=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; <br>
&gt; I don&#39;t understand why we have to keep Python code in its own dire=
ctory<br>
&gt; just to get it checked.=C2=A0 We wouldn&#39;t do that say for Rust cod=
e, would<br>
&gt; we?=C2=A0 Anyway, if it&#39;s the price of checking, I&#39;ll pay[*].<=
br>
<br>
The &#39;check-tox&#39; target is defined in python/Makefile, and is<br>
written to only check code below that location, which is a<br>
somewhat arbitrary choice.<br>
<br>
Having this in &quot;make&quot; at all is a bit outdated. Ideally all<br>
the targets in python/Makefile should be converted into meson<br>
targets and/or tests, in a &quot;python&quot; suite.<br></blockquote><div><=
br></div><div>Yes, ideally, but there are still gaps between the python too=
ling ecosystem and our own conventions in the QEMU source tree. Saying &quo=
t;everything under python/ should adhere to python ecosystem conventions&qu=
ot; was just an extremely convenient way to make python tooling not throw a=
 hissy fit over stuff in that directory. The &quot;make&quot; targets in th=
at directory are really just simple script invocations that we don&#39;t re=
ally need &quot;make&quot; for at all, it&#39;s just so I don&#39;t have to=
 re-explain how to invoke the tests as they stand. I don&#39;t think it&#39=
;s &quot;outdated&quot; in that sense, it&#39;s just a nice little syntacti=
c shorthand using a tool people are familiar with - not too far out from wh=
at we do for the VM tests.<br></div><div><br></div><div>One of the barriers=
 to implementing this in &quot;make check&quot; et al is setting up the pac=
kage installation needed for e.g. mypy and the optional feature packages (l=
ike urwid, fusepy, etc) in a way that is unobtrusive to the build system. T=
he build-time configure venv was a step in that direction, but the work rem=
ains unfinished.</div><div><br></div><div>I am in the process (right now!) =
of setting up mkvenv to install the in-tree python packages to the configur=
e venv - one of the barriers *here* is that this is a little bit slow with =
older setuptools, and due to very tumultuous changes in Python packaging in=
 the last several years (fallout from PEP-517, PEP-518 and PEP-660) is that=
 it is taking me a good long while to ensure it&#39;s rock solid across all=
 of our supported platforms while supporting isolated offline builds. (Pyth=
on stuff was really, really, really not designed to cope very well with tha=
t restriction, I have learned in the last few years.)<br></div><div><br></d=
iv><div>Another reason for the decision to treat the python/ subdirectory a=
s a &quot;mini-repository&quot; was purely for sake of ease with splitting =
out subpackages that became useful beyond the confines of our castle walls:=
 qemu.qmp in particular. By structuring everything here like an upstream pa=
ckage, it becomes pretty trivial to fork things out into standalone package=
s, because they&#39;re already structured identically to how standalone pac=
kages would be.</div><div><br></div><div>TLDR: &quot;It makes my life easie=
r to follow python ecosystem norms in this directory, but I still want to i=
ntegrate it more formally to the QEMU build system and am working on that.&=
quot;<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
<br>
IOW, we should make &#39;check-tox&#39; a target in meson.build at the<br>
top level, and have it check any .py file in the source tree,<br>
with an exclude list for files we know are not &quot;clean&quot; yet,<br>
so we don&#39;t have to move stuff around as we clean up individual<br>
files.<br></blockquote><div><br></div><div>Maybe someday.</div><div><br></d=
iv><div>Right now, I consider anything under python/ to be &quot;maintained=
&quot; for the python ecosystem and anything outside of this to be &quot;go=
od luck!&quot;.<br></div><div><br></div><div>I do not volunteer to apply th=
e same level of effort I do for python/ to *every last python script in the=
 tree*. The standards I apply in python/ are vastly more strict than those =
that=20
could apply to everything else; I don&#39;t think I could handle the=20
workload of polishing every last python thing in the tree up to the same
 standard. qemu.qmp, qemu.machine and qapi are just vastly more important t=
han the majority of one-off scripts that automate niche tasks I have no dom=
ain expertise in.<br></div><div><br></div><div>For any python scripts with =
import dependencies on other in-tree modules, it is useful to structure tho=
se imported modules as normal packages so that mypy, pylint, etc can functi=
on with minimal fuss and without needing lots of prone-to-breakage environm=
ent hacks and custom launcher scripts to make them work. Anything that *doe=
sn&#39;t* need to import anything else from the tree is relatively easy to =
check where it lives, I just don&#39;t do that at the moment. It&#39;s poss=
ible we could make a separate test that applies a much lower bar of type ch=
ecking and linting that really only catches *hard* errors and applies to ev=
erything in the tree automatically, but I don&#39;t think I want to lower t=
he bar for the stuff already in python/.<br></div><div><br></div><div>That =
said, I *do* want to move the python tests into our usual build testing inf=
rastructure, there&#39;s just some more work to do with mkvenv to bridge th=
e gap, which I&#39;m working on currently.<br></div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; <br>
&gt; [...]<br>
&gt; <br>
&gt; &gt; diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py<br>
&gt; &gt; index f3518d29a54..42912c91716 100644<br>
&gt; &gt; --- a/scripts/qapi-gen.py<br>
&gt; &gt; +++ b/scripts/qapi-gen.py<br>
&gt; &gt; @@ -11,9 +11,11 @@<br>
&gt; &gt;=C2=A0 execution environment.<br>
&gt; &gt;=C2=A0 &quot;&quot;&quot;<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt; +import os<br>
&gt; &gt;=C2=A0 import sys<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt; -from qapi import main<br>
&gt; &gt; +sys.path.append(os.path.join(os.path.dirname(__file__), &#39;..&=
#39;, &#39;python&#39;))<br>
&gt; &gt; +from qemu.qapi import main<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt;=C2=A0 if __name__ =3D=3D &#39;__main__&#39;:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 sys.exit(main.main())<br>
&gt; <br>
&gt; Suggest to use the opportunity to rename to just qapi-gen (no .py) and=
<br>
&gt; chmod +x, possibly in a separate patch.<br>
&gt; <br>
&gt; [...]<br>
&gt; <br>
&gt; <br>
&gt; [*] Grudgingly.<br>
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

--00000000000025a7f30620ea449f--


