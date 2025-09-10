Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806D3CA101F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 11:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwJCn-0005Bb-I3; Wed, 10 Sep 2025 07:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uwJCl-0005BS-5g
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 07:41:39 -0400
Received: from mailgate01.uberspace.is ([95.143.172.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uwJCa-0008HY-75
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 07:41:38 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 6407860C88
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 13:41:16 +0200 (CEST)
Received: (qmail 8880 invoked by uid 990); 10 Sep 2025 11:41:16 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Wed, 10 Sep 2025 13:41:16 +0200
MIME-Version: 1.0
Date: Wed, 10 Sep 2025 11:41:15 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <71a535f9154ddc269c0a948053e39053550bd8c0@nut.email>
TLS-Required: No
Subject: Re: [PATCH v6 00/25] tcg-plugins: add hooks for discontinuities
To: "BALATON Zoltan" <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, "=?utf-8?B?QWxleCBCZW5uw6ll?="
 <alex.bennee@linaro.org>
In-Reply-To: <a18a99ca-8415-71bf-3022-c9a98e46c2b5@eik.bme.hu>
References: <cover.1757018626.git.neither@nut.email>
 <a1c2d356-e664-2632-002f-d0b9bea06e1e@eik.bme.hu>
 <cf6e7db43e9e9e59b6c9edb1c172b01ae62fb23f@nut.email>
 <df0a8c4b-ae9b-1582-1570-6cb588149a7a@eik.bme.hu>
 <3c8d0c3733edc984937ac33a417488f92dccb148@nut.email>
 <819c9f3b-13f4-2ef2-e651-5cfec52f2e12@eik.bme.hu>
 <a2eaee5105fb4b3302e2f65bb8bbea987a85454e@nut.email>
 <a18a99ca-8415-71bf-3022-c9a98e46c2b5@eik.bme.hu>
X-Rspamd-Bar: ---
X-Rspamd-Report: BAYES_HAM(-3) MIME_GOOD(-0.1)
X-Rspamd-Score: -3.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=18vUTW3Z0r2EShXVKd+PDtSakA2MsKx+lNli2o1WDa8=;
 b=AtX5bb8HfCg6xKLzZWI4V4FrSsuKYNymgEiw1PqimHEA7Hp0jJGIGAd7CMKvLq72NCzjO/2YhI
 6mmYThv+4gVapCKc6jJi+VO5XISoWLoShJhElEXQuDsseMg6k6zQY0MZWwHk4TrMdV2CFOghGttx
 IlhZwuiqBa3Qkzq4EtqpZjSpfrfYw6yxeMgRlgzappOwIhpIMAIuWYQ10u4t/ob1mIOBJipN8Oc4
 fvL/Ckykjzqt118p3Vy7k77fybxtqKLSgZT2y2j/UJdLTPyfYyiKq/rbyP8MXyojZUzUDtYFk7jQ
 alSJALc4CNDgTEdQ/x798qs7gCCCvPGooqfQdrB9HRd5zFh3uJjTMnIVoVAqjH6TZ5VbKDfD7Vv8
 nc2xbnTOeAtngLljMCsDquIXcratcFZiWq1GGOPktROkpi610quB2Qh//KZQT+7W/N5qtdxqWOia
 C+ZMWYw3JP4yCX80a+O2MQpr4XmROP71RDzTGwDGsGUL0SmytT62xgVM+EpfVSxRdUfqcE/SXHsF
 3bAeac0o3p0kMmH0pk+51ZeT0HGOs6W6nuAhiSOtmrVX4B8wsh3KtoxppvfTn8pA9phBXNCwx3OQ
 74CpJaqZhy/h1du9i6xKEHJWXL2JvCCnxEYTnJuBPRW6e+YbjSLNWWr+YFhPmOpm/puJysOC/Jcw
 Q=
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

September 10, 2025 at 12:06 PM, "BALATON Zoltan" wrote:
> On Tue, 9 Sep 2025, Julian Ganz wrote:
> > I ran streamPPCpowerpcO3 on qemu with these patches:
> >=20
>=20>  -------------------------------------------------------------
> >  Function Best Rate MB/s Avg time Min time Max time
> >  Copy: 2867.6 0.056828 0.055795 0.061792
> >  Scale: 1057.5 0.153282 0.151305 0.158115
> >  Add: 1308.8 0.187095 0.183380 0.193672
> >  Triad: 1111.6 0.220863 0.215902 0.230440
> >  -------------------------------------------------------------
> >=20
>=20>  After doing a clean build, with the fans still audible:
> >=20
>=20>  -------------------------------------------------------------
> >  Function Best Rate MB/s Avg time Min time Max time
> >  Copy: 2932.9 0.055131 0.054554 0.055667
> >  Scale: 1067.9 0.151520 0.149832 0.155000
> >  Add: 1324.9 0.184807 0.181150 0.191386
> >  Triad: 1122.0 0.220080 0.213896 0.229302
> >  -------------------------------------------------------------
> >=20
>=20What was different between the above two runs? I guess maybe one is w=
ith plugins disabled but it's not clear from the description.

The difference is nothing but a a clean rebuild of qemu. As you see
there are fluctuations already. Plugins are enabled for both cases.

> > On qemu (6a9fa5ef3230a7d51e0d953a59ee9ef10af705b8) without these
> >  patches, but plugins enabled:
> >=20
>=20>  -------------------------------------------------------------
> >  Function Best Rate MB/s Avg time Min time Max time
> >  Copy: 2972.1 0.054407 0.053834 0.054675
> >  Scale: 1068.6 0.151503 0.149726 0.154594
> >  Add: 1327.6 0.185160 0.180784 0.193181
> >  Triad: 1127.2 0.219249 0.212915 0.229230
> >  -------------------------------------------------------------
> >=20
>=20>  And on qemu (6a9fa5ef3230a7d51e0d953a59ee9ef10af705b8) without the=
se
> >  patches, with plugins disabled:
> >=20
>=20>  -------------------------------------------------------------
> >  Function Best Rate MB/s Avg time Min time Max time
> >  Copy: 2983.4 0.055141 0.053630 0.060013
> >  Scale: 1058.3 0.152353 0.151186 0.155072
> >  Add: 1323.9 0.184707 0.181279 0.188868
> >  Triad: 1128.2 0.218674 0.212734 0.230314
> >  -------------------------------------------------------------
> >=20
>=20>  I fail to see any significant indication that these patches, or
> >  plugins in general, would result in a degredation of performance.
> >=20
>=20With worst case Copy test it seems to be about 3.5% (and about 1.7% w=
ith plugins disabled?) and should be less than that normally so it does n=
ot add much more overhead to plugins than there is already so this should=
 be acceptable. It may still be interesting to see if the overhead with p=
lugins disabled can be avoided with a similar way as logging does it.

The thing is: that's probably just usual fluctuations. As you have seen
with the first two measurements the values fluctuate quite a bit between
runs of the test on the very same qemu (assuming that a clean build did
not incur any _other_ relevant change). For example, the best rate for
scale shown with plugins enabled is one percent faster than with plugins
disabled. Is this significant? Probably not. Or at least it doesn't make
much sense.

TL:RD: run the very same test multiple times without any changes and
you get "vastly" different results.

And just from these coarse statistics it's hard to judge whether
especially min/max have any significance anyway. That's why you usually
also include deviation/variance when writing performance tests, and some
percentiles if you have enough individual measurements and the means
to store those. What you _can_ tell from these numbers is that the
spread for a single function and run is in the percents.

I may do some more tests this week, with runtimes longer than a few
seconds if I can find the motivation to set up everything I'd need to
compile your benchmark. In the mean-time, you are welcome to make your
own measurements if you want to. The patches are also availible at [1]
if you don't want to apply them to your local tree yourself.

Regards,
Julian

[1]: https://github.com/patchew-project/qemu/tree/patchew/cover.175701862=
6.git.neither@nut.email

