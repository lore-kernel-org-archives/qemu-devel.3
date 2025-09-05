Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DCCCA0FED
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 23:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uufrC-0000tQ-1i; Fri, 05 Sep 2025 19:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uufr8-0000sW-Qq
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 19:28:36 -0400
Received: from mailgate01.uberspace.is ([95.143.172.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uufqx-0000GG-UJ
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 19:28:32 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 6DC5060B4B
 for <qemu-devel@nongnu.org>; Sat,  6 Sep 2025 01:28:03 +0200 (CEST)
Received: (qmail 32358 invoked by uid 990); 5 Sep 2025 23:28:03 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sat, 06 Sep 2025 01:28:02 +0200
MIME-Version: 1.0
Date: Fri, 05 Sep 2025 23:28:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <3c8d0c3733edc984937ac33a417488f92dccb148@nut.email>
TLS-Required: No
Subject: Re: [PATCH v6 00/25] tcg-plugins: add hooks for discontinuities
To: "BALATON Zoltan" <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, "=?utf-8?B?QWxleCBCZW5uw6ll?="
 <alex.bennee@linaro.org>
In-Reply-To: <df0a8c4b-ae9b-1582-1570-6cb588149a7a@eik.bme.hu>
References: <cover.1757018626.git.neither@nut.email>
 <a1c2d356-e664-2632-002f-d0b9bea06e1e@eik.bme.hu>
 <cf6e7db43e9e9e59b6c9edb1c172b01ae62fb23f@nut.email>
 <df0a8c4b-ae9b-1582-1570-6cb588149a7a@eik.bme.hu>
X-Rspamd-Bar: /
X-Rspamd-Report: BAYES_HAM(-0.000318) MIME_GOOD(-0.1)
X-Rspamd-Score: -0.100318
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=3nY0oqHmg6ZXBcRdFkyWIcyEaIoaVe0F6FZFKuOU09E=;
 b=qOn7jsvI3yEZSX2AvKHK8NNEDf7lYwwS9KwoGdICCNpnChUKOSpX6z2NzmQunYy4DeXvYB90lA
 UnBn3WmIOXEdyHbrG4KZraRTEc92magDlNgUTBAgunF4owIrjCC182mgrr6KwKUsCSCLxc+/hym8
 4YvSPvvP1u33smyjfs1otepG4S5Osj81QYY0JdLYL/neCLneiB3xeJnNvgKzX9MBPhQtXnLLJSVb
 sERRuDKwL+vWnGWf4i9jG0u7GM5o8rdGyiCFGueyW1WkMLsXnSp2Z9jjM5awQm3YdoVt6I4PnxGD
 ApgMjLefXdTcmkEI6BeelQSnB+HknnFvGfqlQn7hwI5FZDDroTQOZSFQ7hTKp8WGzzjNwraMT1qg
 IDEfs29bU8WY28LIry5JYGdLXPH2a6HrO3p30rvtBoYzmhZqajnd/PwJtQrlILj98RlwJ+cwAAC/
 pWQCDL9F8gPtHmc6Cm4dsIt40gKu8USMPy6FSb0tMp9h+Aunj34Au95PdcKuPclRi2vA+8HcTvyA
 rT246Vh2cXxP1jxtaH0HonlXn6hBcQdXfmcDC6x+IYJDShHfVZXM1+M1MBpCLan8ko9iUFeq8vPR
 n/4qanMGYvX3i0dhN5qVc0PaUofFhHzdmvof1xF7wr+codh0kEga60K78P85KD+rTPQax7m4TXkq
 U=
Received-SPF: pass client-ip=95.143.172.20; envelope-from=neither@nut.email;
 helo=mailgate01.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

September 5, 2025 at 9:25 PM, "BALATON Zoltan" wrote:
> On Fri, 5 Sep 2025, Julian Ganz wrote:
> > September 5, 2025 at 1:38 PM, "BALATON Zoltan" wrote:
> > > Have you done any testing on how much overhead this adds
> > >  to interrupt heavy guest workloads? At least for PPC these are alr=
eady
> > >  much slower than real CPU so I'd like it to get faster not slower.
> > >=20
>=20>  No, I have not made any performance measurements. However, given t=
hat
> >  for every single TB execution a similar hook is called already, the
> >  impact related to other existing plugin infrastructure _should_ be
> >  neglectible.
> >=20
>=20>  That is, if your workload actually runs any code and is not consta=
ntly
> >  bombarded with interrupts that _do_ result in a trap (which _may_ ha=
ppen
> >  during some tests).
> >=20
>=20>  So if you are performance sensitive enough to care, you will very =
likely
> >  want to disable plugins anyway.
> >=20
>=20I can disable plugins and do that normally but that does not help tho=
se who get QEMU from their distro (i.e. most users). If this infrastructu=
re was disabled in default builds and needed an explicit option to enable=
 then those who need it could enable it and not imposed it on everyone el=
se who just get a default build from a distro and never use plugins. Havi=
ng an option which needs rebuild is like not having the option for most p=
eople. I guess the question is which is the larger group? Those who just =
run guests or those who use this instrumentation with plugins.

Hard to say.

> The default may better be what the larger group needs. Even then distro=
s may still change the default so it would be best if the overhead can be=
 minimised even if enabled. I think the log infrastructure does that, wou=
ld a similar solution work here?
>=20
>=20For testing I've found that because embedded PPC CPUs have a software=
 controlled MMU (and in addition to that QEMU may flush TLB entries too o=
ften) running something that does a lot of memory access like runnung the=
 STREAM benchmark on sam460ex is hit by this IIRC but anything else causi=
ng a lot of interrupts like reading from emulated disk or sound is probab=
ly affected as well. I've tried to optimise PPC exception handling a bit =
before but whenever I optimise something it is later undone by other chan=
ges not caring about performance.

I could try running the benchmark on multiple versions:

* qemu with plugins disabled,
* with plugins enabled but without these patches and
* with plugins enabled and with these patches.

However, I'll likely only report back with results next week, though.
Do you happen to have an image you can point me to? Either something
that has the benchmark already or some unixoid running on the platform?
I'm currently not motivated enough to cook up some bare-metal testbed
for a platform I'm not familiar with.

Regards,
Julian

