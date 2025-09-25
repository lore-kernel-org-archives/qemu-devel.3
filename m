Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECE9CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 12:44:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1lJD-000308-1p; Thu, 25 Sep 2025 08:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v1lJ8-0002zo-Us
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 08:42:48 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v1lJ4-0002hy-Sj
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 08:42:46 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id EB06460B3B
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 14:42:35 +0200 (CEST)
Received: (qmail 22347 invoked by uid 990); 25 Sep 2025 12:42:35 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Thu, 25 Sep 2025 14:42:35 +0200
MIME-Version: 1.0
Date: Thu, 25 Sep 2025 12:42:35 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <232880215edf63a01d026de5f2dac8bf4b06fb85@nut.email>
TLS-Required: No
Subject: Re: [PATCH v6 23/25] tests: add plugin asserting correctness of
 discon event's to_pc
To: "=?utf-8?B?QWxleCBCZW5uw6ll?=" <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, "Pierrick Bouvier" <pierrick.bouvier@linaro.org>,
 "Alexandre Iooss" <erdnaxe@crans.org>, "Mahmoud Mandour"
 <ma.mandourr@gmail.com>, "Richard Henderson" <richard.henderson@linaro.org>
In-Reply-To: <87bjmyke52.fsf@draig.linaro.org>
References: <cover.1757018626.git.neither@nut.email>
 <073cad7dd8ae509ff64a2835fd146833b60c1f60.1757018626.git.neither@nut.email>
 <87segf69f6.fsf@draig.linaro.org>
 <51342318ee32c932dc2a867c808989ea627d874f@nut.email>
 <f7f5cfabe46ede28ea57e49ce36c617aa774ec0b@skiff.uberspace.de>
 <359dc52bc7ebe3ea8a3d549f23d42a592066d685@nut.email>
 <87bjmyke52.fsf@draig.linaro.org>
X-Rspamd-Bar: +
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-0.379054) MIME_GOOD(-0.1)
X-Rspamd-Score: 1.020945
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=Qid2UbzyzKRHTGEYkRzxPjvoFmQcQUmR8wt0Y4KJbAE=;
 b=GhI1kVehWhzTO1R2ktljHHpgfM9ro5DudfII8pMrzfiy5qfuIkCwe5JW0kwMWXYcJ9/tLp6YNR
 uMvUzouCgrfx/+EuNGRgAO+gLUkfYau/KZpDZt2pgGOCcuEFJRg4BOdhKRywEN3yUyU9vYab8wP2
 JfPvvuahNFimn4yETTJrBkLTRbdRE3I3OIPRtuu+EyLLebGMkLG3OMuXdeiWipSr/4qtp9CjmbzQ
 P0RFmmdQ7D2DmM1YrdDGHFmNAPsaUNFjAF44+OvF1JP+XGR/n+9H6yPnEWAM3cej8rvWLq3ZYuUQ
 ivdKdTmIGFjjL3tfBr5/SdGH+k430OIosIMJpZJrIBpioljLiyK9Ebgzl2pJRTwM9MIsOE+NwHii
 AYjO0+/I1uCzAgKYIs4L1Yojf/A1j1hzqjed742984C539YFp/Po/1H651ptw8qHRkc+HCyt9mjK
 i0ejx03Q2/9Li1pSnieE5ynvLYiwrnyFVhRJcUTdkeVbt/8gEPBzx3VXjGqF2TgTQ712RH3hs7z/
 gOJVWxZqKQ7KDshAFXEJUle7LnyzGLIgPiYMdqgRA9etGkleyfu2SL9ygpo6VP+MDq9eVIUGp/vU
 N8yI+L3zq//Hydc2l1QruAYry+OgxTa7Mbo9Kz7kA142oRNYVLqA6wbjBSohlLJ0Vd1d7xQhmWg+
 s=
Received-SPF: pass client-ip=2001:1a50:11:0:c83f:a8ff:fea6:c8da;
 envelope-from=neither@nut.email; helo=mailgate01.uberspace.is
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

Hi Alex,

September 25, 2025 at 12:41 PM, "Alex Benn=C3=A9e" wrote:
> "Julian Ganz" <neither@nut.email> writes:
> > September 23, 2025 at 10:29 PM, "Julian Ganz" wrote:
> > > September 22, 2025 at 12:11 PM, "Julian Ganz" wrote:
> > > > (gdb) p report->str
> > >  > $2 =3D (gchar *) 0x51100001fbc0 "Discon target PC mismatch on VC=
PU 0\nExpected: 8057369\nEncountered: 805736b\nExecuted Last: 805736b\nEv=
ent type: exception\n"
> > >  > (gdb)=20
>=20> >  >=20
>=20> >  > I think this is where it is going wrong:
> > >  >=20
>=20> >  > IN: _dl_early_allocate
> > >  > 0x0805736b: 89 c2 movl %eax, %edx
> > >  > 0x0805736d: 8d 1c 28 leal (%eax, %ebp), %ebx
> > >  > 0x08057370: 89 c8 movl %ecx, %eax
> > >  > 0x08057372: cd 80 int $0x80
> > >  >=20
>=20> >  > Thanks! I'll have a closer look.
> > >  >=20
>=20> >  I probably didn't configure the target I need for this test on m=
y
> > >  private machine (which uses musl, so some targets are awkward).
> > >=20
>=20>  Turned out I just ran `make` in the wrong directory.
> >=20
>=20> >=20
>=20> > Could it
> > >  be that this doesn't run in system emulation mode and the exceptio=
n is
> > >  somehow handled natively? I did not account for that possibility a=
nd I
> > >  don't think I'll get the testing plugin to do anything meaningful
> > >  outside system emulation.
> > >=20
>=20>  As expected the plugin ran in a qemu configuration in which the AP=
I does
> >  not behave as expected. Which I could have figured out by the logs A=
lex
> >  provided if I paid attention. Sorry for the noise.
> >=20
>=20>  I added a check to the plugin that bails out if qemu does not run =
in
> >  system emulation mode (which I thought I did, but that was only for =
the
> >  contrib plugin).
> >=20
>=20>  Even if we cannot test the API for user mode, it may still provide=
 some
> >  utility, so I suggest _just_ letting the testing plugin do nothing i=
n
> >  that case. In fact, I'm considering removing the check from the cont=
rib
> >  "traps" plugin now that I saw that the API _is_ triggered in user
> >  mode.
> >=20
>=20Is this just because we are missing the hooks into the linux-user
> run-loop? I assume int $0x80 is a syscall so we should report an
> exception type at that point?

We _do_ observe the exception occuring, we just don't observe it being
handled. Instead we observe the result after the trap handler returned.
And that's probably what we want for user-mode emulation where we don't
have any introspection into the trap handler's execution.

What trips the testing plugin is that it expects observing the trap
handler, and there's currently nothing we can do here instead of just
giving up when running user-mode emulation. We can introduce actual tests
for user-mode emulation again in the future, should we introduce a
discontinuity type for trap handler return (e.g. for RISC-V's `mret`).

> In fact I think you could probably generate the event at
> qemu_plugin_vcpu_syscall()?

I could, but that would be somewhat separate from the trap related
stuff. Syscalls would likely qualify as a separate, new discontinuity
type similar to host calls.

> force_sig_fault() and force_sig() might be the other places that should
> be hooked. Or possibly handle_pending_signal() where all the other
> signals affect the code flow.
>
> I think that can avoid patching every arches run loop.

I still need to distinguish between discontinuity types, and that does
(currently) require target specific knowledge. Or maybe I misunderstood
what you were trying to say?

Regards,
Julian

