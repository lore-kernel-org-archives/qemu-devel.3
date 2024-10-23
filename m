Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A26CFA44E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 16:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3dy7-0003f3-ND; Wed, 23 Oct 2024 12:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nenut@skiff.uberspace.de>)
 id 1t3dy6-0003en-9k
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 12:12:18 -0400
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nenut@skiff.uberspace.de>)
 id 1t3dy4-0004ZQ-0W
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 12:12:18 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id D14D5180478
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 18:12:12 +0200 (CEST)
Received: (qmail 32638 invoked by uid 990); 23 Oct 2024 16:12:12 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Wed, 23 Oct 2024 18:12:12 +0200
MIME-Version: 1.0
Date: Wed, 23 Oct 2024 16:12:12 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <nenut@skiff.uberspace.de>
Message-ID: <fd9c687a05ccdcdf5a589a15fcecb38074da7c1d@skiff.uberspace.de>
TLS-Required: No
Subject: Re: [RFC PATCH v2 0/7] tcg-plugins: add hooks for interrupts,
 exceptions and traps
To: "Pierrick Bouvier" <pierrick.bouvier@linaro.org>, "Julian Ganz"
 <neither@nut.email>, qemu-devel@nongnu.org
In-Reply-To: <28f647ca-0b88-4a01-90d3-4cc4450e0d1d@linaro.org>
References: <20231021122502.26746-1-neither@nut.email>
 <cover.1729355735.git.neither@nut.email>
 <fad67d3f-5b8d-45f6-a1aa-666852a0dad4@linaro.org>
 <8929cd79ce653b55e7cb166300782cb13727da3b@skiff.uberspace.de>
 <f7e574bb-a780-4f5b-a511-ab9f0aa86f31@linaro.org>
 <ab29d100610abcc59ce2305a1ace1ac0b53340a3@skiff.uberspace.de>
 <2419ec6e-3d4e-4d6d-a738-7615c99ed60c@linaro.org>
 <0696c7fc52d1d58002f0a8be7e7502f57fd61d24@skiff.uberspace.de>
 <28f647ca-0b88-4a01-90d3-4cc4450e0d1d@linaro.org>
X-Rspamd-Bar: ---
X-Rspamd-Report: BAYES_HAM(-3) MIME_GOOD(-0.1)
X-Rspamd-Score: -3.1
Received-SPF: pass client-ip=185.26.156.114;
 envelope-from=nenut@skiff.uberspace.de; helo=mailgate02.uberspace.is
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

Hi, Pierrick,

October 23, 2024 at 5:16 PM, "Pierrick Bouvier" wrote:
>=20
>=20Hi Julian,
>=20
>=20On 10/23/24 05:56, Julian Ganz wrote:
>=20
>=20>  October 22, 2024 at 11:15 PM, "Pierrick Bouvier" wrote:
> >=20
>=20> >=20
>=20> > On 10/22/24 01:21, Julian Ganz wrote:
> > >=20
>=20>=20
>=20>  Ok, I'll introduce an enum and combine the three callbacks in the =
next
> >  iteration then.
> >  typedef struct {
> >  enum qemu_plugin_cf_event_type ev;
> >  union {
> >  data_for_interrupt interrupt;
> >  data_for_trap trap;
> >  data_for_semihosting semihosting;
> >  } qemu_plugin_cf_event;
> >  /* data_for_... could contain things like from/to addresses, interru=
pt id, ... */
> >=20
>=20>  I don't think this is a good idea.
> >  Traps are just too diverse, imo there is too little overlap between
> >  different architectures, with the sole exception maybe being the PC
> >  prior to the trap. "Interrupt id" sounds like a reasonably common
> >  concept, but then you would need to define a mapping for each and ev=
ery
> >  architecture. What integer type do you use? In RISC-V, for example,
> >  exceptions and interrupt "ids" are differentiated via the most
> >  significant bit. Dou keep that or do you zero it? And then there's
> >  ring/privilage mode, cause (sometimes for each mode), ...
> >=20
>=20> >=20
>=20> > I didn't want to open the per architecture pandora box :).
> > >  I don't think the plugin API itself should deal with per architect=
ure
> > >  details like meaning of a given id. I was just thinking to push th=
is "raw" information to the plugin, that may/may not use architecture spe=
cific knowledge to do its work. We already have plugins that have similar=
 per architecture knowledge (contrib/plugins/howvec.c) and it's ok in som=
e specific cases.
> > >=20
>=20>  But how would such an interface look? The last PC aside, what woul=
d you
> >  include, and how? A GArray with named items that are itself just opa=
que
> >  blobs?
> >=20
>=20I was not thinking about a new interface for this. Having the "raw" i=
nterrupt id is enough for a plugin to do useful things, by having knowled=
ge of which architecture it's instrumenting.

But what is would the "raw" interrupt id even be for a given
architecture? I don't think you can answer this question with "obviously
this _one_ integer" for all of them.

> >=20
>=20> And what would be the benefit compared to just querying the respect=
ive
> >  target specific registers through qemu_plugin_read_register? Which b=
tw.
> >  is what we were going to do for our use-case. Even the example you
> >  brought up (howvec) uses querying functions and doesn't expect to ge=
t
> >  all the info via parameters.
> >=20
>=20You're right, but it's because it's querying instruction data.
> I may be wrong on that, but at translation time, we may or may not be i=
nterested in accessing tb/insn data.
>=20
>=20However, for control flow analysis, beyond a simple counting plugin, =
we probably want to access further data almost everytime.
>=20
>=20I see it closer from syscall instrumentation, which pushes the syscal=
l id, and all register values, instead of letting the user poke it. Makes=
 more sense compared to that?

Yes, but then you are in "GArray of named, potentially complex value"
terretory again. And the comparison with syscalls also falls apart when
you consider that, for syscalls, they are well defined and enumerated
identically for at least a variety of targets, while the same kind of
"enumeration", if it even exists, is in completely different order for
every architecture.

> >=20
>=20> >=20
>=20> > But having something like from/to address seems useful to start. =
Even if we don't provide it for all events yet, it's ok.
> > >=20
>=20>  Yes, I certainly see the advantages of having either the last PC o=
r the
> >  would-be-next PC as they are sufficiently universal. You can usually
> >  retrieve them from target-specific registers, but that may be more
> >  complicated in practice. In the case of RISC-V for example, the valu=
e
> >  of the EPC differs between interrupts and exceptions.
> >=20
>=20To the opposite of interrupt id, a PC is something universal by defin=
ition, and with a single meaning across architecture. However, accessing =
it by name varies per architecture, and even per sub events, as you are s=
tating for RISC-V.

Yes. And for that very reason I would not pass "the EPC" to a callback
but a clearly, target agnostic, defined value such as:

| The PC of the instruction that would have been executed next, were it
| not for that event

or

| The PC of the instruction that was executed befroe the event occurred

And unlike interrupt ids, the plugin API already has a precedent for
what type to use: uint64_t

Regards,
Julian

