Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15773C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 17:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZYyQ-0002as-32; Wed, 09 Jul 2025 13:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uZYyH-0002Yc-WD
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 13:52:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uZYyE-0002Oz-PZ
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 13:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752083555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pOG229tLkfmKTZ6kRfqK53pteA3NueMB65BU+cRzlI4=;
 b=VSh5vO6u8W+xlPOHozmgibHLl/ozPERnK2jwcBq6dD/ONBXkYkLeJ6N5BWRDLPJd2zurEO
 Mi4zYw0CUOqMV3NOS9jQZsJpnhP9vh7cV9GOQCwYx79MeaZOIOJ2HAw3qA8R/iDYBUxW54
 Km2ik5N+6RYRz1GYpiZzQVOdkolMvj8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-Ogm0Jy6MMkqOhiuporaEKQ-1; Wed, 09 Jul 2025 13:52:34 -0400
X-MC-Unique: Ogm0Jy6MMkqOhiuporaEKQ-1
X-Mimecast-MFC-AGG-ID: Ogm0Jy6MMkqOhiuporaEKQ_1752083553
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-313fb0ec33bso180937a91.2
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 10:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752083552; x=1752688352;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pOG229tLkfmKTZ6kRfqK53pteA3NueMB65BU+cRzlI4=;
 b=Lw3nEyLB/JRWAC511AxFwvu6t7HerOfyYLJ9ljOl4bk0HYJMjg1DA4udQYTyyrBEmM
 Gleb572COpDbYazgHUUDuBgAqXrcJCwMA6LNQuMDMhi0McaF2Reghxd5QzLErgZerFjh
 LgMMoqesFodHavYgEN3JoqtHF40dn7qgjiNj9fJCU4nzrV49KjXnj5KLnyLm1HrSsLq5
 3GghsdL4ckGUXhuBSt7aJw5KqIJoK8xmzBHBHk4zuGEBt6O52Bh+WgYI1UG/pyh3Iuhe
 O5bV3KypnmgLXr7Ml9ySHp/Np4y6DGk0wvDYKIeKxyoUQLIkayKttddFkaEDWZbA0pih
 TPDw==
X-Gm-Message-State: AOJu0Yy69GwLu4h6PSjbixxgEPhtC03EWNwZIMvgilDl/hNTBfrUc8b/
 ZSkATN6clHIPtMuCZogq44yCK6a9oH1yYhSNmyrhs+Rc6Xl6w8GqJZY4UOG0vyNyhJ1h0M7k91N
 eKSU7CIA12r0de7g9P0pOF1OYFZzjaLMEWeO2jdhq6bWoH5FaUuHC7C7LcNBu753i3YhnzdYlIJ
 qHbA8U4g+JGaJe75uTRF62GMSed9W/ryRZjX5cETU4ww==
X-Gm-Gg: ASbGncuHslC973lkGvC2CnozDIaD0P0810q6EG/ecef2TiwjM/F2ieJmt8/NFBYuWqh
 gTIgMYcm4v9qI0Oh+kqoYJ3MnM8SexiWiNgVx0yu4ajGRahClE8qh5DL4DFonMhXWloms9o38Zp
 e7ZN4aXpgixv1VHM+rZrfq4u4OIJpCE/qHEJQ=
X-Received: by 2002:a17:90b:5108:b0:313:f9fc:7213 with SMTP id
 98e67ed59e1d1-31c3c2e2c48mr1026737a91.21.1752083552247; 
 Wed, 09 Jul 2025 10:52:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDX/H1Ofjlhb5U6Rgjdna1yEpze0LKnOPlZx2jjDpuUrkhbz4qg/OCTBuR+gtDrS/zfUUPrTHeOkYRn//BaqQ=
X-Received: by 2002:a17:90b:5108:b0:313:f9fc:7213 with SMTP id
 98e67ed59e1d1-31c3c2e2c48mr1026701a91.21.1752083551782; Wed, 09 Jul 2025
 10:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAFn=p-bp_hFTu7yDGuQa-Eoctnpb_dd4_fgfhrC3umpX1EuvCA@mail.gmail.com>
In-Reply-To: <CAFn=p-bp_hFTu7yDGuQa-Eoctnpb_dd4_fgfhrC3umpX1EuvCA@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 9 Jul 2025 13:52:19 -0400
X-Gm-Features: Ac12FXypEpKO-0P_iWoi7nchVrWWU8sBbswTC7VSEmct07fP1GMzvKyiFPFykjU
Message-ID: <CAFn=p-YOYUjwk-fuTDGCVDu=oxCRZp3UowVk_4kJT66J=jQ6Qw@mail.gmail.com>
Subject: Re: Python ecosystem versions overview
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Top-posting (Gasp!) to share a gitlab URL where this script is now located.

https://gitlab.com/jsnow/repology-dashboard#

GPL2.0-or-later, barely polished, a bit hacky. Have fun! This script
outputs more data than you've ever wanted to stdout, json and csv.
Suggestions/patches welcome if you find the script useful but clunkily
written (it is clunkily written.) The repo contains all of the sample
output in a data/ folder you can nose around if desired.

I currently have no appetite for trying to get this into qemu.git as a
maintainer scrichvrches nightmarespt, but maybe you do - in which
case, be my guest and change absolutely whatever you want to make it
happen, I do not care and have no pride on the matter. O:-)

--js

P.S. would it maybe be worth reproducing the summary table as-is in
our developer manual as something linked to from the platform policy
page? It will rot over time, but it's still potentially a quite useful
reference and I don't know where else to put it. I know we have a
wiki, but I think the wiki is not really a great source of information
for our project as *most* pages there are quite rotted.


On Tue, Jul 8, 2025 at 4:36=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:
>
> Hi, recently there was some discussion and debate over what versions
> of which things in the Python ecosystem we need to support with
> regards to our build platform promise. I don't address those issues in
> this mail at all. O:-)
>
> In researching that problem, I created a CLI script to automatically
> poll repology and several other sources (homebrew and macports APIs)
> to assemble a cohesive overview of the "Python ecosystem" across all
> of our target platforms. I felt this was necessary because it's often
> quite difficult to determine at a glance what is available as each
> platform has quite different ways of packaging, de/bundling, or
> factoring these tightly related projects.
>
> Here's the summary output:
>
> nago@fedora ~/s/repology-dashboard (devel)> python3 python_repology.py
> Fetching https://repology.org/api/v1/project/python
> Fetching https://repology.org/api/v1/project/python%3Asphinx
> Fetching https://repology.org/api/v1/project/python%3Asetuptools
> Fetching https://repology.org/api/v1/project/setuptools
> Fetching https://repology.org/api/v1/project/pip
> Fetching https://ports.macports.org/api/v1/ports/py-setuptools/
> MacPorts de-facto python version is python313. Results will be narrowed.
> FreeBSD de-facto python version is 311. Results will be narrowed.
> NetBSD de-facto python version is 312. Results will be narrowed.
> Fetching https://formulae.brew.sh/api/formula/python@3.13.json
> Homebrew de-facto python version is python@3.13. Results will be narrowed=
.
>
> ...
>
> =3D=3D=3D=3D=3D=3D=3D=3D
> overview
> =3D=3D=3D=3D=3D=3D=3D=3D
> distro              python3  pip     setuptools  sphinx  repos
> -------------------------------------------------------------------------=
------------------------------
> alpine_3_19         3.11.13  23.3.1  70.3.0      6.2.1   main,
> community
> alpine_3_20         3.12.11  24.0    70.3.0      7.2.6   main,
> community
> alpine_3_21         3.12.11  24.3.1  70.3.0      8.1.3   main,
> community
> alpine_3_22         3.12.11  25.1.1  80.9.0      8.2.3   main,
> community
> centos_stream_9     3.9.23   21.3.1  53.0.0      3.4.3   BaseOS, CRB
> centos_stream_10    3.12.11  23.3.2  69.0.3      7.2.6   BaseOS, CRB
> debian_12           3.11.2   23.0.1  66.1.1      5.3.0   bookworm/main
> fedora_40           3.12.10  23.3.2  69.0.3      7.2.6   updates,
> release
> fedora_41           3.13.5   24.2    69.2.0      7.3.7   updates,
> release
> fedora_42           3.13.5   24.3.1  74.1.3      8.1.3   updates,
> release
> freebsd             3.11.13  23.3.2  63.1.0      5.3.0   ---
> homebrew            3.13.5   ---     80.9.0      8.2.3   ---
> macports            3.13.5   25.1.1  78.1.1      8.2.3   ---
> openbsd             3.12.11  25.1.1  79.0.1      8.2.3   ---
> opensuse_leap_15_6  3.6.15   20.0.2  44.1.1      2.3.1   updates/sle,
> main/oss
> pkgsrc_current      3.12.11  25.1.1  80.9.0      8.2.3   ---
> ubuntu_22_04        3.10.12  22.0.2  59.6.0      4.3.2
> jammy-updates/main, jammy/universe, jammy/main
> ubuntu_24_04        3.12.3   24.0    68.1.2      7.2.6   noble/main,
> noble/universe
> ubuntu_24_10        3.12.7   24.2    74.1.2      7.4.7
> oracular/main, oracular/universe
> ubuntu_25_04        3.13.3   25.0    75.8.0      8.1.3   plucky/main,
> plucky/universe
>
> Some notes and observations:
>
> (1) Homebrew doesn't have a pip version listed because technically
> Homebrew does not ship pip; it's bundled directly with python. I did
> not find any reasonable mechanism to determine what that version is.
> However, as part of a "ports" style collection, it's usually bleeding
> edge and not likely to run afoul of "too old to reasonably support".
>
> (2) Alpine doesn't ship pip except via its "community" repo. I am
> unclear on if this is a repository enabled by default or not.
>
> (3) CentOS stream does not ship "sphinx" except via "CRB", which I
> think may not be enabled by default.
>
> (4) OpenSUSE Leap 15.6 is egregiously old. 16.x is promised for later
> this year, but we are past the promised "five year" support window for
> this platform in some sense -- 15.0 released in 2018 -- so I believe
> it can actually be ignored. Even though we still have a (working)
> dockerfile for it, and I see value in supporting SUSE in general,
> future python subsystem decisions may opt to exclude SUSE as a
> first-tier supported platform as per our policy. (It is also possible
> to pull in newer packages from different streams, but I was unable to
> investigate this in detail at this time.)
>
> (5) Ubuntu only ships pip in "universe", but also ships some Python
> 3.x interpreter updates to that repository as well. I have filtered
> this list to only use Universe for pip packages, leaving Python the
> base version that ships with the platform in x/main or x-updates/main.
>
> (6) "ports" collections (FreeBSD, NetBSD, OpenBSD/pkgsrc_current,
> Homebrew and MacPorts) do not necessarily have the concept of a
> platform default Python interpreter version, but other packages in the
> collection can be used as a heuristic to determine which one is best
> suited.
>
> For instance, FreeBSD and NetBSD only ship pip et al for a single
> interpreter version.
> OpenBSD has a symbolic "python3" package that installs a specific
> version. Homebrew has a "python3" alias that chooses a specific Python
> interpreter version. MacPorts similarly has a symbolic "py-setuptools"
> package that will choose a specific interpreter version.
>
> These are used as heuristics to determine a "de-facto" default for the
> ports collection platforms.
>
> -
>
> That's all for now. I will publish the script to the list later,
> though I have no intention of cleaning it up for inclusion in our
> tree. When I send it, bookmark the email if you'd like to try using
> this for other purposes or running it for yourself. Maybe I will throw
> it up on my personal GitLab in case it is useful to other subsystem
> maintainers in the future. The filtering code is a little messy, but
> it got the job done and should be reasonably straightforward to make
> sense of at a glance. It uses only the 'requests' library as a third
> party dependency.
>
> Your humble Python sin-eater,
> --js


