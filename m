Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC03E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 21:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJJjv-0003f0-2j; Thu, 05 Dec 2024 16:50:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tJJjt-0003ed-F1
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:50:25 -0500
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tJJjr-00057M-AB
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:50:25 -0500
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id A012517F7A2
 for <qemu-devel@nongnu.org>; Thu,  5 Dec 2024 22:50:18 +0100 (CET)
Received: (qmail 4304 invoked by uid 990); 5 Dec 2024 21:50:18 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Thu, 05 Dec 2024 22:50:18 +0100
MIME-Version: 1.0
Date: Thu, 05 Dec 2024 21:50:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <51ac04eea17a6c5b59a240d3c57ce54a851e4989@nut.email>
TLS-Required: No
Subject: Re: [RFC PATCH v3 01/11] plugins: add types for callbacks related to
 certain discontinuities
To: "Pierrick Bouvier" <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
In-Reply-To: <64e40e6f-bc90-4760-bb70-fb67d80ff4d7@linaro.org>
References: <cover.1733063076.git.neither@nut.email>
 <5e624b7244f1b0b294b28cd513aab04b6b294b1d.1733063076.git.neither@nut.email>
 <181b9b53a258257df1b24e7bfb8b0e6fc590c25f@nut.email>
 <35529516-cc96-41de-8e0d-a7807ccc09cb@linaro.org>
 <ca20c295f464ae7e3365e012ad9a550f70b34b51@nut.email>
 <64e40e6f-bc90-4760-bb70-fb67d80ff4d7@linaro.org>
X-Rspamd-Bar: /
X-Rspamd-Report: MIME_GOOD(-0.1)
X-Rspamd-Score: -0.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:subject:date;
 bh=Wzvz8ovkmEzZLKp9u0lkfRSNMeelroRy4lk894gaUhI=;
 b=sQpLeQNltK6X5PeW4Aelg/bReYGPb14FTGfxdps/+0NES3zZAkOqWyyyksME4holMeRmJIqz5w
 Ur+FNces6vaMsZfi55KN+QUr0OGCRvatN7QEuzWbbCh9aIz9G6Xh7neFfoZT5gYm+TR2Bymw8g1v
 9g5qTU5+LTlkX2C6hGLKN1CgPIiQDv2QSqsI/0XObVC663GQvRUPmXPuLYkgCvbr8RV8jWnMvK9k
 ei3Gv1CGDobk3bGM4So4f2SM7CclkkdYSGqBa1jvGwp1GLno2Xcc4mGbYC7/qs03KqMeSHZlfHKV
 vp7EWy48jId3JkRkuYRgp6EEEpHMs1ScO3vZ4+pXgM9ji2zDFWGwiKd0bou72XiV/zYWiFuDW09W
 ATDPIwBhssW0s4do/RGOESCDc/n7YzqoYJUssn1VXbw1TEU781uIsK3E/AWlW442E04ROEUw843Y
 dMht7JVEls9IhbOYYu+LIC4N00FU4QUxfm5ZrLDmCa7iD0EFLvcSUiCTkPhGGckyBA3HJpG41FAh
 rO33p667abUxnH9OI8yYeM2Mc8oJ2cCraW6zpPuygBMM53mXvf73CNvfB7AMYWjaKsRf7xqQpvYg
 qDkehhy5297/2kKPLZMRoUYgfqBwGIlPjzbrPA6r9YSxCK1leJyiFThRuJrco7H9aikndbSAbXQS
 E=
Received-SPF: pass client-ip=2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4;
 envelope-from=neither@nut.email; helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi Pierrick,

December 5, 2024 at 6:56 PM, "Pierrick Bouvier" wrote:
> On 12/5/24 04:40, Julian Ganz wrote:
>=20
>=20>=20
>=20> Hi Pierrick,
> >  December 4, 2024 at 11:41 PM, "Pierrick Bouvier" wrote:
> > > Does it mean that information returned should be dependent of type =
of event, as we previously discussed on v1?
> > >=20
>=20>  Yes, and I don't like it.
> >=20
>=20I respect your personal preference, but our conversation should be ba=
sed on arguments, and not only tastes.
>=20
>=20The important thing, from my point of view, is that the API stays eas=
y to use and clear for the user. Having multiple callbacks is a headache,=
 because you can't clearly group them somewhere, and force the user to im=
plement all of them at once.

Having only one callback is not something I'm against.

> I was, and I am still ok with the current approach, of having from/to p=
arameters and a "simple" callback type. But remove "from" because we can'=
t get it right in some cases does not seem the best decision.

If you cannot rely on an input being a sensible value, doesn't that
render the input useless?

> Let's try to move forward, and solve the problems we have with from_pc.=
 The testing part can be solved already (as explained in a previous messa=
ge). In which cases can't you identify from_pc?

I'll have to check, but problems that I discussed with a colleague
included jumps to an unmapped page resulting in the appropriate
exception. We ultimately agreed that in such a situation from_pc should
point to the jump target inside the unmapped page, instead of, say, the
jump. We assume that most targets should already behave this way without
further changes. However, in order to compute the correct from_pc, we
need to know the jump target before the exception is raised (i.e. right
after the jump instruction is executed), and that's not necessarily
straight-forward to do in a plugin.

But as I wrote before in another message, I need to take another look at
the cflow plugin.

> By the way, and if you are open to talk about naming.

I'm open to suggestions.

> I understand why you picked up discontinuity, which is coming from a ma=
thematical background. However, I rarely see this term used in the litera=
ture for computer science, and people use "exceptional control flow" to q=
ualify interrupts and traps. In more, when we'll integrate classic contro=
l flow (including fallback between tb), the term discontinuity will lose =
its meaning. For this reason, I think that {cflow,CFLOW} makes more sense=
.

Using the term "discontinuity" was, in fact, inspired by "uninferable PC
discontinuities" defined in the RISC-V ETrace spec [1], arguably a
technical document. We chose discontinuity over the notion of control
flow because the PC is not the (only) thing affected by the event. In
the case of host calls, we ideally don't even observe an effect on the
PC. Thus control flow doesn't really fit the bill for those.

Regards,
Julian Ganz

[1] https://github.com/riscv-non-isa/riscv-trace-spec

