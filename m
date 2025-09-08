Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7854CA1016
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 20:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uviqG-0008Vm-4I; Mon, 08 Sep 2025 16:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uviq8-0008UA-Eu
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 16:51:54 -0400
Received: from mailgate01.uberspace.is ([95.143.172.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uviq4-0008SV-Mp
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 16:51:51 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 5E36760E38
 for <qemu-devel@nongnu.org>; Mon,  8 Sep 2025 22:51:33 +0200 (CEST)
Received: (qmail 7269 invoked by uid 990); 8 Sep 2025 20:51:33 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 08 Sep 2025 22:51:33 +0200
MIME-Version: 1.0
Date: Mon, 08 Sep 2025 20:51:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <b85feecbb3e48feac89064916ce2477242a55603@nut.email>
TLS-Required: No
Subject: Re: [PATCH v6 00/25] tcg-plugins: add hooks for discontinuities
To: "BALATON Zoltan" <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, "=?utf-8?B?QWxleCBCZW5uw6ll?="
 <alex.bennee@linaro.org>
In-Reply-To: <819c9f3b-13f4-2ef2-e651-5cfec52f2e12@eik.bme.hu>
References: <cover.1757018626.git.neither@nut.email>
 <a1c2d356-e664-2632-002f-d0b9bea06e1e@eik.bme.hu>
 <cf6e7db43e9e9e59b6c9edb1c172b01ae62fb23f@nut.email>
 <df0a8c4b-ae9b-1582-1570-6cb588149a7a@eik.bme.hu>
 <3c8d0c3733edc984937ac33a417488f92dccb148@nut.email>
 <819c9f3b-13f4-2ef2-e651-5cfec52f2e12@eik.bme.hu>
X-Rspamd-Bar: ---
X-Rspamd-Report: BAYES_HAM(-3) MIME_GOOD(-0.1)
X-Rspamd-Score: -3.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=pYa6nbnP02MT5Ra8XrIgvVGVkTeCZFVwN6IfNpnSSw8=;
 b=vuqXzPILg8LHj3i2P8xR7K+l0Up6hD6OxUjRDrtkFZRpwA0S4eGUrP5T8TZvI2iwuVBL6cu6Kf
 fo83XZ6hnVCSYJxN2cNFHhHBxtkI8N4k2yfZfoei4fVB5BxZO+rVlnDakVu0PlHjPrhoa0o2/gV0
 Fh04lRL/Oe4eTB1WmJf9H2J+eSbsDYS/mFdy5OSxxOTijGX07eKJcZWhC0TkVKYLAMz1L88egRjb
 SEFjAWsWua/YLNRlWKOJfUU4DgAOQf1q4RWciQt7zUhbkuyngmNrHeHYiRlE6699mn38xEy4MgNS
 I4lYOLiT1rVWNSdSbkOYPpZk3PiiKEvjRw5cgGws57Hte6wVNdK7enbs36/Eg0QAEwmKY6uvbCrD
 5bbPrZvsS9cJoAYDukvdAfIt5Ca8QWnrES8Z0Eh2mqbfCYzJOGl1TTbVmZFr0X2fRkffvwQeMEJ9
 bsEY26q+r9i0UgEaJWaBMKS4zNfk+C1q+ALtx08bgI4GyaytMbjc78LQhDRCeuhsavFUrqjXVEtt
 TRll+bnrc0q7qmH0wjOpjz88eKV+aZXWQSz1Hvn/64wyreLs4ZAJO5p6P8djKtJ11gBwNvVdRR2+
 db1C2pDqxDLkOcy6HFM4N8gK/GXcHGvISqXhi3XBaeTBZuoOXhkBDKiQQ6egM46Beo6Hj/peCglw
 w=
Received-SPF: pass client-ip=95.143.172.20; envelope-from=neither@nut.email;
 helo=mailgate01.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

September 7, 2025 at 10:21 PM, "BALATON Zoltan" wrote:
> On Fri, 5 Sep 2025, Julian Ganz wrote:
>=20
>=20>=20
>=20> September 5, 2025 at 9:25 PM, "BALATON Zoltan" wrote:
> > > The default may better be what the larger group needs. Even then di=
stros may still change the default so it would be best if the overhead ca=
n be minimised even if enabled. I think the log infrastructure does that,=
 would a similar solution work here?
> > >=20
>=20> >  For testing I've found that because embedded PPC CPUs have a sof=
tware controlled MMU (and in addition to that QEMU may flush TLB entries =
too often) running something that does a lot of memory access like runnun=
g the STREAM benchmark on sam460ex is hit by this IIRC but anything else =
causing a lot of interrupts like reading from emulated disk or sound is p=
robably affected as well. I've tried to optimise PPC exception handling a=
 bit before but whenever I optimise something it is later undone by other=
 changes not caring about performance.
> > >=20
>=20>  I could try running the benchmark on multiple versions:
> >=20
>=20>  * qemu with plugins disabled,
> >  * with plugins enabled but without these patches and
> >  * with plugins enabled and with these patches.
> >=20
>=20>  However, I'll likely only report back with results next week, thou=
gh.
> >  Do you happen to have an image you can point me to? Either something
> >  that has the benchmark already or some unixoid running on the platfo=
rm?
> >  I'm currently not motivated enough to cook up some bare-metal testbe=
d
> >  for a platform I'm not familiar with.
> >=20
>=20I don't have ready images to test embedded PPC MMU exceptions which I=
 think this may affect most. I had an image for pegasos2 for a general te=
st used here:
> https://lists.nongnu.org/archive/html/qemu-discuss/2023-12/msg00008.htm=
l
> but that machine has a G4 CPU which has hardware MMU so is likely not a=
ffected.

I ran this test anyway, because it was easy enough to run. Tweaked the
script to do 10 runs, each with one of the aforementioned variants.
Isolating the time stats printed gives you the following:

Qemu with patches and plugins enabled:

    Frame          |  CPU time/estim | REAL time/estim | play/CPU |    ET=
A
  1149/1149  (100%)|    0:23/    0:23|    0:23/    0:23|   1.2557x|    0:=
00
  1149/1149  (100%)|    0:23/    0:23|    0:23/    0:23|   1.2621x|    0:=
00
  1149/1149  (100%)|    0:23/    0:23|    0:23/    0:23|   1.2536x|    0:=
00
  1149/1149  (100%)|    0:24/    0:24|    0:24/    0:24|   1.2394x|    0:=
00
  1149/1149  (100%)|    0:23/    0:23|    0:23/    0:23|   1.2529x|    0:=
00
  1149/1149  (100%)|    0:23/    0:23|    0:23/    0:23|   1.2565x|    0:=
00
  1149/1149  (100%)|    0:24/    0:24|    0:24/    0:24|   1.2456x|    0:=
00
  1149/1149  (100%)|    0:24/    0:24|    0:24/    0:24|   1.2450x|    0:=
00
  1149/1149  (100%)|    0:23/    0:23|    0:23/    0:23|   1.2526x|    0:=
00
  1149/1149  (100%)|    0:23/    0:23|    0:23/    0:23|   1.2528x|    0:=
00

Qemu (6a9fa5ef3230a7d51e0d953a59ee9ef10af705b8) without these patches,
but plugins enabled:

    Frame          |  CPU time/estim | REAL time/estim | play/CPU |    ET=
A
  1149/1149  (100%)|    0:24/    0:24|    0:24/    0:24|   1.2309x|    0:=
00
  1149/1149  (100%)|    0:24/    0:24|    0:24/    0:24|   1.2399x|    0:=
00
  1149/1149  (100%)|    0:23/    0:23|    0:23/    0:23|   1.2547x|    0:=
00
  1149/1149  (100%)|    0:23/    0:23|    0:23/    0:23|   1.2511x|    0:=
00
  1149/1149  (100%)|    0:24/    0:24|    0:24/    0:24|   1.2265x|    0:=
00
  1149/1149  (100%)|    0:24/    0:24|    0:24/    0:24|   1.2156x|    0:=
00
  1149/1149  (100%)|    0:24/    0:24|    0:24/    0:24|   1.2401x|    0:=
00
  1149/1149  (100%)|    0:24/    0:24|    0:24/    0:24|   1.2460x|    0:=
00
  1149/1149  (100%)|    0:24/    0:24|    0:24/    0:24|   1.2472x|    0:=
00
  1149/1149  (100%)|    0:24/    0:24|    0:24/    0:24|   1.2370x|    0:=
00

Qemu (6a9fa5ef3230a7d51e0d953a59ee9ef10af705b8) without these patches,
with plugins disabled:

    Frame          |  CPU time/estim | REAL time/estim | play/CPU |    ET=
A
  1149/1149  (100%)|    0:24/    0:24|    0:24/    0:24|   1.2478x|    0:=
00
  1149/1149  (100%)|    0:23/    0:23|    0:23/    0:23|   1.2509x|    0:=
00
  1149/1149  (100%)|    0:24/    0:24|    0:24/    0:24|   1.2500x|    0:=
00
  1149/1149  (100%)|    0:24/    0:24|    0:24/    0:24|   1.2019x|    0:=
00
  1149/1149  (100%)|    0:24/    0:24|    0:24/    0:24|   1.2439x|    0:=
00
  1149/1149  (100%)|    0:24/    0:24|    0:24/    0:24|   1.2453x|    0:=
00
  1149/1149  (100%)|    0:25/    0:25|    0:25/    0:25|   1.1945x|    0:=
00
  1149/1149  (100%)|    0:24/    0:24|    0:24/    0:24|   1.2331x|    0:=
00
  1149/1149  (100%)|    0:23/    0:23|    0:23/    0:23|   1.2510x|    0:=
00
  1149/1149  (100%)|    0:24/    0:24|    0:24/    0:24|   1.2467x|    0:=
00

So nothing to see here. If anything, we see a slight reduction in
runtime with these patches, which doesn't makes any sense. I did not do
a fresh clean build for those, and the order I ran the tests may have
had some influence on the results.

> I have uploaded some PPC binaries for the STREAM benchmark that I teste=
d with before here:
> http://zero.eik.bme.hu/~balaton/qemu/stream-test.zip
> which may excercise this if run on sam460ex or ppce500 machines but I d=
on't have a scripted test case for that. There is some docs on how to run=
 Linux on these machines here:
> https://www.qemu.org/docs/master/system/target-ppc.html

Thanks, I'll have alook at how to run those over the course of this
week.

> Alternatively maybe running a disk IO benchmark on an emulated IDE cont=
roller using PIO mode or some other device that generates a lots of inter=
rupts may test this. I think you can use the "info irq" command in QEMU M=
onitor to check how many interrupts you get.

I started writing a small exception/interrupt torture test for the
PPC440 with the help of robots. If and when I'm finishing it I'll do
some measurements with that.

Regards,
Julian

