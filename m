Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B819CE835D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 17:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svK1F-0003of-5R; Mon, 30 Sep 2024 13:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1svK1A-0003nU-65
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 13:17:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1svK17-0002UF-Eh
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 13:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727716619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=KLX2vmXpWw5EKUCP7TCclqtuxtBat0RwNdVyLDJm5xc=;
 b=ZsLypoC5MGpXjc+IL2kqnDl/SSwVeIXgc+hbdqbu5Hmt1SVib3qCXdWEK/0VDDXT6FQs+s
 LcmAo9EIcm9uEgaOLkkKH9G+AMRbtbzT+kryetLSel/X03E8VhK5rouT4/z5UDD4qNJqW/
 Vm5PaP2xvi9Awx9hbt8ZJsUipZjxggQ=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-MZsrUe88N--07e4Ekq3EQA-1; Mon, 30 Sep 2024 13:16:57 -0400
X-MC-Unique: MZsrUe88N--07e4Ekq3EQA-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3e27a0f8613so2888958b6e.2
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 10:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727716614; x=1728321414;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KLX2vmXpWw5EKUCP7TCclqtuxtBat0RwNdVyLDJm5xc=;
 b=n1Uv8UKJv6c96/p2EnY4O5m3eJKdLrf36iibF+0F69FAMN1XR2d8CxWO//3wY57t67
 /GMrNAWoemwT4Ti/YfLCukUZvI7NQTewc102iOtxjiCXp6FNazSbCg3usOJoZ+6MY7sU
 PhXPc442mr1EImVH5RUviEflOic9l7jw5L3Q5JuRu9a2v/vCO+M+NwODMPwlwaBBwBoy
 G0tozVRB+wXaHfxMoK2R3nF2LA4c3YNJOYVroWEBrKNv6xFk1ThGhqRiIAN7qH4UXdEJ
 dpPim4sBOURBGEA7cjEXcR8xksaxQEZr/UFSCc86yAn+rw4+i/XufzUNOjh43LBIxGcy
 V2CQ==
X-Gm-Message-State: AOJu0Yx8vRyDReTx/K7cNHJ95X3xLn4MehA3LQuaGQTv9avzD+PWSv9O
 bijS9CVhNX/KPeuhUTaD2u5U9IpMZdPvgRV2iDfVh8NU6D2H1aEcvsxi/nuPkGz+xbiNg1E9pwC
 JVtHn6ua9oPqyLKNMRz+PnWVgZShInaDhTOgHTeYHpOTdee7wUVPWuqBxFuEUUYxo0boDLSJs+W
 pL8dpFAdEPoF3kDxSwh7a/+XJOdwlL5rE5AGRpRg==
X-Received: by 2002:a05:6808:1b0a:b0:3e0:71c9:cbd9 with SMTP id
 5614622812f47-3e393961603mr8473187b6e.13.1727716614507; 
 Mon, 30 Sep 2024 10:16:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKnSvEwGPKHmgdoSdlxe0NndrHh8GpuLrhxlyHhh32itcjAembOMnMOOfJssFUHQQGntskPSPgcjoFAgNr4ag=
X-Received: by 2002:a05:6808:1b0a:b0:3e0:71c9:cbd9 with SMTP id
 5614622812f47-3e393961603mr8473153b6e.13.1727716614161; Mon, 30 Sep 2024
 10:16:54 -0700 (PDT)
MIME-Version: 1.0
From: John Snow <jsnow@redhat.com>
Date: Mon, 30 Sep 2024 13:16:42 -0400
Message-ID: <CAFn=p-bfv=uRCGzODQDyK4mO1ct-7tG3REfN9pm0o=n2GBGKug@mail.gmail.com>
Subject: Minimum sphinx version?
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Daniel Berrange <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000f64730623595fe5"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--0000000000000f64730623595fe5
Content-Type: text/plain; charset="UTF-8"

Hi, following up from my KVM forum talk (
https://www.youtube.com/watch?v=GGbz3WwvqLw ) I wanted to ask about what
version of Sphinx we could use as a minimum version to help ease the burden
of modernizing our QMP docs without a long backwards compatibility tail
(and hundreds of lines of compatibility goop to make it happen.)

First, some necessary background on the current state of our Python
environment and build system:

Paolo and I worked on a Python virtual environment tied to the QEMU build
system (python/scripts/mkvenv.py) which performs various setup actions
necessary to instantiate python *stuff* to ensure the build works and is
always using the correct, configured Python interpreter.

Currently, configure will invoke mkvenv in such a fashion that it prefers
any local packages you have installed: notably, meson, sphinx, and
sphinx-rtd-theme if you already have them installed from your distro's
repository will be used *if they use the version of python you specified to
configure* (or they match the version that configure guessed if you didn't
specify one.)

For meson, if you don't meet the minimum version, we will install a version
for you from our vendored whl files in the repository/tarball.

For sphinx, if you don't meet the minimum version and you have specified
--enable-docs, we'll install a version from the internet, from PyPI. If you
did not specify --enable-docs, we disable docs.

We did it this way because:
- It's *really fast* if you already have the dependencies you need
- meson is easy to vendor as a .whl because it's pure python, has *zero*
dependencies, and it's absolutely required for the build.
- docs are not *required* to build QEMU
- We went out of our way to ensure that QEMU could be built in an offline,
isolated environment on all of our supported platforms.

That being said:

The current reality is that Sphinx 3.4.3 is our minimum because RHEL 9
offers that as the distro package and I have not dared bump our version
beyond that for fear of disrupting our ability to build docs on RHEL 9
without internet.

What I'd like to ask is: How adamant are we that we can build docs on older
platforms? Do we consider it part of our platform promise? Can we bump
Sphinx to a slightly newer version at the expense of offline doc builds for
RHEL 9?

To reiterate: interactive developer builds from git or source tarballs
would continue to work (and be able to build docs just fine) so long as
--enable-docs is passed, but will require an internet connection to set up
the python environment with a new-enough sphinx. RHEL 9 rpm builds of
bleeding edge QEMU may be cut off from building docs in isolated RPMBUILD
environments unless that repository backports a newer sphinx that can be
identified as a dependency in the specfile.

How much of a problem do we consider that to be?

CCing the usual suspects.

--js

--0000000000000f64730623595fe5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi, following up from my KVM forum talk ( <a href=3D"=
https://www.youtube.com/watch?v=3DGGbz3WwvqLw">https://www.youtube.com/watc=
h?v=3DGGbz3WwvqLw</a> ) I wanted to ask about what version of Sphinx we cou=
ld use as a minimum version to help ease the burden of modernizing our QMP =
docs without a long backwards compatibility tail (and hundreds of lines of =
compatibility goop to make it happen.)<br></div><div><br></div><div>First, =
some necessary background on the current state of our Python environment an=
d build system:<br></div><div><br></div><div>Paolo and I worked on a Python=
 virtual environment tied to the QEMU build system (python/scripts/mkvenv.p=
y) which performs various setup actions necessary to instantiate python *st=
uff* to ensure the build works and is always using the correct, configured =
Python interpreter.<br></div><div><br></div><div>Currently, configure will =
invoke mkvenv in such a fashion that it prefers any local packages you have=
 installed: notably, meson, sphinx, and sphinx-rtd-theme if you already hav=
e them installed from your distro&#39;s repository will be used *if they us=
e the version of python you specified to configure* (or they match the vers=
ion that configure guessed if you didn&#39;t specify one.)</div><div><br></=
div><div>For meson, if you don&#39;t meet the minimum version, we will inst=
all a version for you from our vendored whl files in the repository/tarball=
.</div><div><br></div><div>For sphinx, if you don&#39;t meet the minimum ve=
rsion and you have specified --enable-docs, we&#39;ll install a version fro=
m the internet, from PyPI. If you did not specify --enable-docs, we disable=
 docs.</div><div><br></div><div>We did it this way because:</div><div>- It&=
#39;s *really fast* if you already have the dependencies you need<br></div>=
<div>- meson is easy to vendor as a .whl because it&#39;s pure python, has =
*zero* dependencies, and it&#39;s absolutely required for the build.<br></d=
iv><div>- docs are not *required* to build QEMU</div><div>- We went out of =
our way to ensure that QEMU could be built in an offline, isolated environm=
ent on all of our supported platforms.</div><div><br></div><div>That being =
said:<br></div><div><br></div><div>The current reality is that Sphinx 3.4.3=
 is our minimum because RHEL 9 offers that as the distro package and I have=
 not dared bump our version beyond that for fear of disrupting our ability =
to build docs on RHEL 9 without internet.</div><div><br></div><div>What I&#=
39;d like to ask is: How adamant are we that we can build docs on older pla=
tforms? Do we consider it part of our platform promise? Can we bump Sphinx =
to a slightly newer version at the expense of offline doc builds for RHEL 9=
?</div><div><br></div><div>To reiterate: interactive developer builds from =
git or source tarballs would continue to work (and be able to build docs ju=
st fine) so long as --enable-docs is passed, but will require an internet c=
onnection to set up the python environment with a new-enough sphinx. RHEL 9=
 rpm builds of bleeding edge QEMU may be cut off from building docs in isol=
ated RPMBUILD environments unless that repository backports a newer sphinx =
that can be identified as a dependency in the specfile.<br></div><div><br><=
/div><div>How much of a problem do we consider that to be?</div><div><br></=
div><div>CCing the usual suspects.<br></div><div><br></div><div>--js<br></d=
iv><div><br></div></div>

--0000000000000f64730623595fe5--


