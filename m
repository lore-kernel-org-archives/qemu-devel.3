Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD84C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 13:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seb0C-00076Q-9S; Thu, 15 Aug 2024 09:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1seb0A-000758-59
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 09:58:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1seb07-0008Il-1N
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 09:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723730328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=Hl9SwxGAgx7JcWxuk7Kku+v/ECZUskjH9cIieeY9Sc4=;
 b=GCFHIuiY9yqJCRo/wZdAtSOix4rj36tXpxFDX5jeupdxBoqbhKduRQQ2OMkb6n3AbNVXay
 NI4POyW/2zjSyBmCguxI2zZtvZcKd6EKQix0Dtw3nFVYWKO/6wguVOjZ8/urP3wrNL6dm6
 Qg7Dq8oh1cTLK066OdvMVBqjDwTRdJs=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-1RK4iCjdMFGUwF5IaQhJxg-1; Thu, 15 Aug 2024 09:58:45 -0400
X-MC-Unique: 1RK4iCjdMFGUwF5IaQhJxg-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-7c6a9c1a9b8so820806a12.0
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 06:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723730324; x=1724335124;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hl9SwxGAgx7JcWxuk7Kku+v/ECZUskjH9cIieeY9Sc4=;
 b=PDRdp1UL3fGoENhNAAzG407YKxtoBxjNmPlhUjw5lQ8G6T8yvA/FbL40WD/j9QjlpB
 yvlt9aNhvZ0lltfzREbD6n2BPWwbbpiqgR10lwTpkSNiGSCtkT0Osx52GV3yjjtnZBjT
 oTCgvwc7eHr5sSkAimQA2epoP0w6a6YsNIdI6wjqm0S85gXfBWVQZhb47k6+DeFxGrfe
 4g9I+EHjiWEVchOawMLLHqctOA4xgfzCdImNTrGgplPTtLg49nmL1Z4xhP2ARRDDEctN
 afyrjNtDIvc2u/fL0wM30KSKzJI5AEl70TQyefHqwvGl+y95XvHYWAHkZX16D152SH8B
 8HZg==
X-Gm-Message-State: AOJu0YxisAe3S4G/CYBfxR3Av+JZP+sYo5GMw7DyBW72Ed2JBtASZVBK
 3WGI+k/16id2mvKWoo16Pz9/4rOj0+Lj8fm3DT9jRjiV+qpWK51JENTmbJPbb9+rCTiVIWUA7HJ
 o+ZkZV1IhsICZ4cR5dbuDD7zXhLwSltE+oM2TmCifFn20NcERtvY7lqFVth/ijy/fUFlKR3UuU/
 JXlJC+B4vtDD1LGb/+KO08M88ubkk=
X-Received: by 2002:a05:6a21:e8a:b0:1c6:b0cc:c448 with SMTP id
 adf61e73a8af0-1c8eaf6965emr8084150637.43.1723730324333; 
 Thu, 15 Aug 2024 06:58:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGU/eICcRlUkZw/Nvm2iDdRiBGSkyN+OOlKlreq8GNiQdXUbaiTSfxkhVKpvM6PjtlSwPLgJl1RlRjazRxwIDA=
X-Received: by 2002:a05:6a21:e8a:b0:1c6:b0cc:c448 with SMTP id
 adf61e73a8af0-1c8eaf6965emr8084128637.43.1723730323826; Thu, 15 Aug 2024
 06:58:43 -0700 (PDT)
MIME-Version: 1.0
From: John Snow <jsnow@redhat.com>
Date: Thu, 15 Aug 2024 09:58:31 -0400
Message-ID: <CAFn=p-ZJZ1BScebJtgGmFBwV4n2Yhyha6WFAmVe9_T2c4ML7Dw@mail.gmail.com>
Subject: Removing python/qemu/qmp
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a3fd14061fb93ddc"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

--000000000000a3fd14061fb93ddc
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,

Let's discuss finally dropping the qemu.qmp lib out of qemu.git in favor of
using the standalone package at
https://gitlab.com/qemu-project/python-qemu-qmp/

To recap, the qemu.qmp lib offers only QMP tooling but no qapi bindings. I
make a new release *about* once a year to accommodate new Python releases. (
https://qemu.readthedocs.io/projects/python-qemu-qmp/en/latest/main.html#changelog
)

For fixes and things needed for qemu I'm likely to release point updates
per-fix, but it hasn't really been a necessity yet because of the code
duplication. Even so, it's in a pretty stable state that doesn't appear to
need much maintainer bandwidth at the moment.

I'd like to finally drop the in-tree mirror so I don't have to manually
sync changes back and forth. The tough bit is that the in-tree python
tooling would now have its first mandatory "external" dependency. i.e.
qemu.git/python/setup.cfg would start requiring e.g. qemu.qmp == 0.0.3.

That'd mean that scripts and tooling in-tree that rely on import path hacks
to utilize the in-tree packages could start breaking if the dependencies
aren't met. To ensure they're met, we need to pip install the in-tree
packages.

(To my knowledge: qom tools, iotests, and potentially other things. Maybe
the VM tests? The Avocado tests already handle this installation via the
Makefile, but this approach isn't suitable/scalable for everything in-tree
that needs it.)

However, doing so unconditionally even when we have no intention to run
tests/scripts means a 2-3 second delay on every last configure invocation -
something we worked extremely hard to avoid.

Is it time to add a "testing" group to pythondeps.toml?


I imagine I need to do these things:

1. vendor the qemu.qmp wheel. simple enough.

2. add qemu.qmp as a requirement to python/setup.cfg. I like to do this to
ensure that the python stuff in this directory is as "normal" as possible,
even if we handle venv config/instantiation elsewhere; e.g. I've documented
you can just "pip install" this directory when needed for years and years
now.

3. add a testing group to pythondeps.toml; I'm not currently sure if I can
add the in-tree source package by path or if I'll need to handle it
"specially" like I did for avocado. I may or may not need to specify the
qemu.qmp dependency explicitly here, based on how mkvenv tries to source
dependencies. I'll test this and report back.

4. Figure out when the testing group should be ensured during initial
configuration. My hunch is "almost always", but if it cannot be configured
for some reason, it should be non-fatal to the build.

(But at the moment I don't know why, if I vendor the wheel, it should ever
fail except for mkvenv toolchain failures - unforeseen problems with the
way we use venv/pip/setuptools/distlib et al. Still, maybe future
requirements may be less promise-able and we should perhaps be flexible
here.)

Do we want --enable-tests and --disable-tests, with a default to "enable if
possible", like we do for docs?

Or should I just hit the heavy hammer and force it always like for meson?

(If I do it always, I'm just concerned about the installation speed because
unlike meson, we will *never* already have the package! It needs to be
installed from the sourcs tree as a matter of course.)

5. Figure out how to perform a delayed initialization of the testing group
to achieve just-when-needed testing support. I believe this is important
for running iotests outside of the make system, which last I checked with
Kevin and Hannah et al was a non-negotiable argument.

(IIRC it should be simple enough to have the iotests environment
bootstrapper make a call to mkvenv ensure-group as long as it's fast in the
do-nothing case. I'm less sure about other scripts that may require this
env prepping. I'll audit that.)


Thoughts? Lets schedule a call to discuss if we can. (Anyone else
interested can join if they want.)

~~js

--000000000000a3fd14061fb93ddc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Paolo,<div dir=3D"auto"><br></div><div dir=3D"auto">Le=
t&#39;s discuss finally dropping the qemu.qmp lib out of qemu.git in favor =
of using the standalone package at=C2=A0<a href=3D"https://gitlab.com/qemu-=
project/python-qemu-qmp/">https://gitlab.com/qemu-project/python-qemu-qmp/<=
/a></div><div dir=3D"auto"><br></div><div dir=3D"auto">To recap, the qemu.q=
mp lib offers only QMP tooling but no qapi bindings. I make a new release *=
about* once a year to accommodate new Python releases. (<a href=3D"https://=
qemu.readthedocs.io/projects/python-qemu-qmp/en/latest/main.html#changelog"=
>https://qemu.readthedocs.io/projects/python-qemu-qmp/en/latest/main.html#c=
hangelog</a>)</div><div dir=3D"auto"><br></div><div dir=3D"auto">For fixes =
and things needed for qemu I&#39;m likely to release point updates per-fix,=
 but it hasn&#39;t really been a necessity yet because of the code duplicat=
ion. Even so, it&#39;s in a pretty stable state that doesn&#39;t appear to =
need much maintainer bandwidth at the moment.</div><div dir=3D"auto"><br></=
div><div dir=3D"auto">I&#39;d like to finally drop the in-tree mirror so I =
don&#39;t have to manually sync changes back and forth. The tough bit is th=
at the in-tree python tooling would now have its first mandatory &quot;exte=
rnal&quot; dependency. i.e. qemu.git/python/setup.cfg would start requiring=
 e.g. qemu.qmp =3D=3D 0.0.3.</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">That&#39;d mean that scripts and tooling in-tree that rely on import p=
ath hacks to utilize the in-tree packages could start breaking if the depen=
dencies aren&#39;t met. To ensure they&#39;re met, we need to pip install t=
he in-tree packages.</div><div dir=3D"auto"><br></div><div dir=3D"auto">(To=
 my knowledge: qom tools, iotests, and potentially other things. Maybe the =
VM tests? The Avocado tests already handle this installation via the Makefi=
le, but this approach isn&#39;t suitable/scalable for everything in-tree th=
at needs it.)</div><div dir=3D"auto"><br></div><div dir=3D"auto">However, d=
oing so unconditionally even when we have no intention to run tests/scripts=
 means a 2-3 second delay on every last configure invocation - something we=
 worked extremely hard to avoid.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Is it time to add a &quot;testing&quot; group to pythondeps.toml?=
</div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">I imagine I need to do these things:</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">1. vendor the qemu.qmp wheel. simple enough.</div><div di=
r=3D"auto"><br></div><div dir=3D"auto">2. add qemu.qmp as a requirement to =
python/setup.cfg. I like to do this to ensure that the python stuff in this=
 directory is as &quot;normal&quot; as possible, even if we handle venv con=
fig/instantiation elsewhere; e.g. I&#39;ve documented you can just &quot;pi=
p install&quot; this directory when needed for years and years now.</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">3. add a testing group to pytho=
ndeps.toml; I&#39;m not currently sure if I can add the in-tree source pack=
age by path or if I&#39;ll need to handle it &quot;specially&quot; like I d=
id for avocado. I may or may not need to specify the qemu.qmp dependency ex=
plicitly here, based on how mkvenv tries to source dependencies. I&#39;ll t=
est this and report back.</div><div dir=3D"auto"><br></div><div dir=3D"auto=
">4. Figure out when the testing group should be ensured during initial con=
figuration. My hunch is &quot;almost always&quot;, but if it cannot be conf=
igured for some reason, it should be non-fatal to the build.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">(But at the moment I don&#39;t know w=
hy, if I vendor the wheel, it should ever fail except for mkvenv toolchain =
failures - unforeseen problems with the way we use venv/pip/setuptools/dist=
lib et al. Still, maybe future requirements may be less promise-able and we=
 should perhaps be flexible here.)</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Do we want --enable-tests and --disable-tests, with a default to=
 &quot;enable if possible&quot;, like we do for docs?</div><div dir=3D"auto=
"><br></div><div dir=3D"auto">Or should I just hit the heavy hammer and for=
ce it always like for meson?</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">(If I do it always, I&#39;m just concerned about the installation spee=
d because unlike meson, we will *never* already have the package! It needs =
to be installed from the sourcs tree as a matter of course.)</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">5. Figure out how to perform a delaye=
d initialization of the testing group to achieve just-when-needed testing s=
upport. I believe this is important for running iotests outside of the make=
 system, which last I checked with Kevin and Hannah et al was a non-negotia=
ble argument.</div><div dir=3D"auto"><br></div><div dir=3D"auto">(IIRC it s=
hould be simple enough to have the iotests environment bootstrapper make a =
call to mkvenv ensure-group as long as it&#39;s fast in the do-nothing case=
. I&#39;m less sure about other scripts that may require this env prepping.=
 I&#39;ll audit that.)</div><div dir=3D"auto"><br></div><div dir=3D"auto"><=
br></div><div dir=3D"auto">Thoughts? Lets schedule a call to discuss if we =
can. (Anyone else interested can join if they want.)</div><div dir=3D"auto"=
><br></div><div dir=3D"auto">~~js</div><div dir=3D"auto"><br></div></div>

--000000000000a3fd14061fb93ddc--


