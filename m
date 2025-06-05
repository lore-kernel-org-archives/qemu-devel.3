Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9C1C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 19:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNGN5-0006er-8h; Thu, 05 Jun 2025 15:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uNGN3-0006ej-EE
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 15:35:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uNGN1-00014D-99
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 15:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749152120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=uzJe/sPQnm1gWrTGAwVgpm6sMaAUDom4Pfev81bYyd0=;
 b=f/MzJJaXuaZEJFJJz7q1/zPu4aJJkfPU73APNn0BbujpooIFQOYaOTh7EFwoHukkz6d3dS
 Z2csxjSTn+Mgh85++izg2VUeuu7NoaU/Bif3zo/1e3nfG3r+nrXSxfq+hLZPssYtVBv1wn
 kXjNkuZ5S0f/xvDzSyxS6eKwF0c4TD8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-Odu23TSlM7mP4vG9Ee80ag-1; Thu, 05 Jun 2025 15:35:18 -0400
X-MC-Unique: Odu23TSlM7mP4vG9Ee80ag-1
X-Mimecast-MFC-AGG-ID: Odu23TSlM7mP4vG9Ee80ag_1749152117
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-311a6b43ed7so1258371a91.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 12:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749152116; x=1749756916;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uzJe/sPQnm1gWrTGAwVgpm6sMaAUDom4Pfev81bYyd0=;
 b=tXOOBu7o9bLdUY6+cUPl1LR0a5j+ABfC35uTP75wdKZajUJwsTeAqHmPoCDdUR67QX
 mUkBg90TGKD27UZdSL5wBSWcjCH9Oc/rc9wc4WW9LnDbIBRdBnuCuDlP67noU838MbF3
 TKxCKmfvL/fNcksS2wc1GDMOzcK1QW+EyHVeEgZ1q8FyuUVasbWHXvKEUuAPSkTDboF6
 6aD7RrTGgSVf7KGFw+uUjJUVsuea58r2wyt/sycY9Z2WiWR1m6Z/0WqKNwMkRxOsblTd
 MkRGB3NHDxwPEFRTfGYGoyungxLf7kIREKnTKlQAIKW+kgIc2tzQKa29xxhDP5BqFgxu
 BTZg==
X-Gm-Message-State: AOJu0YwGtuD92BiYaYBfoh9MBO1r12qcQbZ18jpvShk+RPjk0f/KuqHk
 l+MznjGE+PTmb5XrNNoCTDHr+Q4viLAtsoFzc0OCg8ZdSjIe9tWQ6Yj74n7I12qis0MFgx972z1
 XflDI3kfDyorqWqwz/6WFxWmIO6EYUkpYAXqmZENew1KG5WRxtBn9nzA6Ma2JGnAvVbbAjy4MhP
 gGPAtnqsmUH9QiDypGfvUdFLrblYgpg9KcIBSRkYR0cg==
X-Gm-Gg: ASbGncsEMZlK0Mues9aK8rhfaOeJAuScN+5ILsVWGxgTFeCUnFrAxvyEY2HwtOOZL+N
 STsbbwvjeMevyvVU2X1isVGHofngH8HgmMsm4Ib0C4xntWFza87NEFvEMrg1SWgwxmHq+OTg39N
 t3VKtTqqdm8pxhgfFum6br9o1r7JMguW98umE=
X-Received: by 2002:a17:90b:4f48:b0:312:1d2d:18e1 with SMTP id
 98e67ed59e1d1-3134768f7acmr1053795a91.22.1749152116582; 
 Thu, 05 Jun 2025 12:35:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsflotocvv/L2+rgcA7prlYd5u6kxnc4XV8aYS7nNSKpYHuKoD39TSl7cNlHoa/xNxjOMaAlFMWtk5HeYqa8Q=
X-Received: by 2002:a17:90b:4f48:b0:312:1d2d:18e1 with SMTP id
 98e67ed59e1d1-3134768f7acmr1053774a91.22.1749152116143; Thu, 05 Jun 2025
 12:35:16 -0700 (PDT)
MIME-Version: 1.0
From: John Snow <jsnow@redhat.com>
Date: Thu, 5 Jun 2025 15:35:04 -0400
X-Gm-Features: AX0GCFs-4GhLZ1R76dyq_R-RHPSHn3xCjP-2sFm8dpHYhErymF21Pbjw5mv0JtY
Message-ID: <CAFn=p-YuqzXvWF-cGLUc0LVVMe2Rinx9+LOjvpHRY-vRrPyJow@mail.gmail.com>
Subject: Build platform guarantees, docs, tests, and snakes in the garden
To: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: multipart/alternative; boundary="0000000000008a948b0636d83693"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--0000000000008a948b0636d83693
Content-Type: text/plain; charset="UTF-8"

Hi, I've long been a little confused about the specifics of our build
platform guarantee and how it applies to documentation and testing.

My *current* understanding is that our build platform guarantee applies to
both unit tests and building documentation, but that this requirement may
not be as absolute as I imagine it.

The way I have endeavored to manage the Python tooling in our tree so far
is to preserve, without fail, our ability to perform fully offline builds
on all supported platforms (provided that the right distro repo packages
are available). The Python virtual environment created at configure time
bends over backwards to use system packages *whenever possible*, and the
list of exceptions - notably Meson itself - uses vendored packages only in
very specific cases where it is possible to vendor such packages. Fetching
packages from PyPI is generally offered only as a convenience for developer
workstations to, in general, save developers from having to know anything
about Python. (I think I've done a good job there, to be honest!)

(Notably: Meson is pure python and has no dependencies, so it is possible
to vendor it for offline builds. Tools like Sphinx, however, have many
dependencies and are not so easily vendored. Thus, we have created a
tenuous arrangement where we are allowed to use versions of Meson that
otherwise would break our build platform guarantee.)

Lately, we've had some issues with the wide range of Sphinx versions we
support presenting various cross-platform difficulties. In particular,
Akihiko Odaki has sent patches to bump our Sphinx version to at least
6.2.1, because platforms with Python 3.13.1 can no longer run Sphinx 3.x at
all, so having that be our "default install version" causes issues on newer
platforms.

However, if we take as iron-clad our commitment to the build platform
promise -- *and* guarantee offline/tarball builds as well -- then Debian 12
(as an example) only offers Sphinx 5.3.0 and not newer unless we allow
internet access to fetch Sphinx 6.2.1. This is not a problem for developer
workstations at all, but I am unclear on what problems this may cause for
tarball releases and downstream offline/isolated/reproducible builds, if
any.

In this case, we can (probably) "fix" the issue by continuing to allow
older Sphinx while preferring a newer Sphinx version when it is missing,
but then we lose the ability to make code cleanups and drop a lot of
back-compat crud. If memory serves, there were other issues recently where
older versions of Sphinx behaved differently from newer versions, causing
intermittent failures that were hard to track down.

What I'd like to know is: what precisely are our options in this scenario?
Do we consider it acceptable for some platforms to be unable to build docs
offline? How highly do we value the ability to locally build docs for any
given release?

Before I throw my weight behind any given option, I just want to know what
we consider our non-negotiable obligations to be.

Thanks,
--js

--0000000000008a948b0636d83693
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi, I&#39;ve long been a little confused about the sp=
ecifics of our build platform guarantee and how it applies to documentation=
 and testing.</div><div><br></div><div>My *current* understanding is that o=
ur build platform guarantee applies to both unit tests and building documen=
tation, but that this requirement may not be as absolute as I imagine it.</=
div><div><br></div><div>The way I have endeavored to manage the Python tool=
ing in our tree so far is to preserve, without fail, our ability to perform=
 fully offline builds on all supported platforms (provided that the right d=
istro repo packages are available). The Python virtual environment created =
at configure time bends over backwards to use system packages *whenever pos=
sible*, and the list of exceptions - notably Meson itself - uses vendored p=
ackages only in very specific cases where it is possible to vendor such pac=
kages. Fetching packages from PyPI is generally offered only as a convenien=
ce for developer workstations to, in general, save developers from having t=
o know anything about Python. (I think I&#39;ve done a good job there, to b=
e honest!)</div><div><br></div><div>(Notably: Meson is pure python and has =
no dependencies, so it is possible to vendor it for offline builds. Tools l=
ike Sphinx, however, have many dependencies and are not so easily vendored.=
 Thus, we have created a tenuous arrangement where we are allowed to use ve=
rsions of Meson that otherwise would break our build platform guarantee.)</=
div><div><br></div><div>Lately, we&#39;ve had some issues with the wide ran=
ge of Sphinx versions we support presenting various cross-platform difficul=
ties. In particular, Akihiko Odaki has sent patches to bump our Sphinx vers=
ion to at least 6.2.1, because platforms with Python 3.13.1 can no longer r=
un Sphinx 3.x at all, so having that be our &quot;default install version&q=
uot; causes issues on newer platforms.</div><div><br></div><div>However, if=
 we take as iron-clad our commitment to the build platform promise -- *and*=
 guarantee offline/tarball builds as well -- then Debian 12 (as an example)=
 only offers Sphinx 5.3.0 and not newer unless we allow internet access to =
fetch Sphinx 6.2.1. This is not a problem for developer workstations at all=
, but I am unclear on what problems this may cause for tarball releases and=
 downstream offline/isolated/reproducible builds, if any.</div><div><br></d=
iv><div>In this case, we can (probably) &quot;fix&quot; the issue by contin=
uing to allow older Sphinx while preferring a newer Sphinx version when it =
is missing, but then we lose the ability to make code cleanups and drop a l=
ot of back-compat crud. If memory serves, there were other issues recently =
where older versions of Sphinx behaved differently from newer versions, cau=
sing intermittent failures that were hard to track down.</div><div><br></di=
v><div>What I&#39;d like to know is: what precisely are our options in this=
 scenario? Do we consider it acceptable for some platforms to be unable to =
build docs offline? How highly do we value the ability to locally build doc=
s for any given release?</div><div><br></div><div>Before I throw my weight =
behind any given option, I just want to know what we consider our non-negot=
iable obligations to be.</div><div><br></div><div>Thanks,</div><div>--js</d=
iv><div><br></div></div>

--0000000000008a948b0636d83693--


