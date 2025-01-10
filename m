Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B86E5E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 11:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWDf3-0006xR-8v; Fri, 10 Jan 2025 06:58:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tWDf2-0006xE-4i
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 06:58:44 -0500
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tWDf0-0000Kb-Be
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 06:58:43 -0500
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 38F6D1814AF
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 12:58:39 +0100 (CET)
Received: (qmail 17340 invoked by uid 990); 10 Jan 2025 11:58:39 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Fri, 10 Jan 2025 12:58:39 +0100
MIME-Version: 1.0
Date: Fri, 10 Jan 2025 11:58:38 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <6a8376f614cf26112a81d5d870c684a653b6952e@nut.email>
TLS-Required: No
Subject: Re: [RFC PATCH v3 11/11] tests: add plugin asserting correctness of
 discon event's to_pc
To: "=?utf-8?B?QWxleCBCZW5uw6ll?=" <alex.bennee@linaro.org>
Cc: "Pierrick Bouvier" <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 "Alexandre Iooss" <erdnaxe@crans.org>, "Mahmoud  Mandour"
 <ma.mandourr@gmail.com>, "Richard Henderson" <richard.henderson@linaro.org>
In-Reply-To: <87a5c06j7b.fsf@draig.linaro.org>
References: <cover.1733063076.git.neither@nut.email>
 <36d316bf3e8b0aca778c5e8d1acde39a7f361946.1733063076.git.neither@nut.email>
 <d4b17c7d-c1d2-4e43-8eee-d1667e3ee5a2@linaro.org>
 <590990025f1f43704ca8831254754661c176c42f@nut.email>
 <87a5c06j7b.fsf@draig.linaro.org>
X-Rspamd-Bar: +
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) MIME_GOOD(-0.1)
X-Rspamd-Score: 1.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=LSH1nSJmyfhNRNVWO2SLmnQp072MPX8FC2MZxk/Zwh8=;
 b=KwCItIGO8qmp1FVr/CrN5T2xLIJYiUDyHfKNSIggB+mk3Kr6m8aZRlQ8eJk8J0oBhWhyF5aPgu
 X6lvj/J0SFEYY384LkTUd5JUD4zG7PE7ZbQ5/UOQPe1nsZ1zjsVTHz5N4iz1daKmumQ8PsUGfYO/
 CRn12l0S1pIkDZfccHAADJ6Yhr6TGASgCx9Zi0aUvR0C7au2LAnrxJdfWMG2J6HJXDo6t2KYD4Yj
 NR03Z0JQ5nZ+lTmua2ebyutbY1cEgKnmDdUHg57IE6KrcDyAf/DhC7PYpjbM0bUWUzUmpS9yRLm/
 S5CXwvoeMuajhN2IzOjwO3G/QIsahOJJHy1VCH3QBCfznQaavnzNz5wZZkOpDNgZtF9ourJidrxP
 83XaFFhuuSL0ZjKoha+/D4/QqrrtMweKbR70TyMIuL7COqzM7pHVIH/Ja8oUbbCOyUe0Qnebo389
 3Y10pCqvxRzy0Fisfm9PBvE+bknzYrgmc2qMRiGoiLW7ynCNCwJXzmt/jQ1z9kJqgbtWIRDtWqgN
 aeX7eACs77GpXEWDdYC8WUXgN+1ifNUSnIcizL5nhLDhBh6RXVirt+ZMkIV7ap2ldL3UJRQUevmF
 uxYKnJ35qXBy38z51TxoACSuJZeEat0uuiFSoX+Z2FVPNeqTN1FYb1SwLMvmrY9L2PxqhJxNp1td
 Q=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
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

Hi Alex,

Sorry for tha late reply.

January 9, 2025 at 5:33 PM, "Alex Benn=C3=A9e" wrote:
> "Julian Ganz" <neither@nut.email> writes:
>=20
>=20(Add Richard to CC)
>=20
>=20>=20
>=20> Hi Pierrick,
> >=20
>=20>  December 5, 2024 at 12:33 AM, "Pierrick Bouvier" wrote:
> >=20
>=20> >=20
>=20> > On 12/2/24 11:41, Julian Ganz wrote:
> > >  > +static void insn_exec(unsigned int vcpu_index, void *userdata)
> > >  > +{
> > >  > + struct cpu_state *state =3D qemu_plugin_scoreboard_find(states=
, vcpu_index);
> > >  > + uint64_t pc =3D (uint64_t) userdata;
> > >  > + GString* report;
> > >  > +
> > >  > + if (state->has_next) {
> > >  > + if (state->next_pc !=3D pc) {
> > >  > + report =3D g_string_new("Trap target PC mismatch\n");
> > >  > + g_string_append_printf(report,
> > >  > + "Expected: %"PRIx64"\nEncountered: %"
> > >  > + PRIx64"\n",
> > >  > + state->next_pc, pc);
> > >  > + qemu_plugin_outs(report->str);
> > >  > + if (abort_on_mismatch) {
> > >  > + g_abort();
> > >  > + }
> > >  > + g_string_free(report, true);
> > >  > + }
> > >  > + state->has_next =3D false;
> > >  > + }
> > >  > +}
> > >  >=20
>=20> >  When booting an arm64 vm, I get this message:
> > >  Trap target PC mismatch
> > >  Expected: 23faf3a80
> > >  Encountered: 23faf3a84
> > >=20
>=20>  A colleague of mine went to great lengths trying to track and reli=
ably
> >  reproduce this. We think that it's something amiss with the existing
> >  instruction exec callback infrastructure. So... it's not something I=
'll
> >  be addressing with the next iteration as it's out of scope. We'll
> >  probably continue looking into it, though.
> >=20
>=20>  The mismatch is reported perfectly normal and boring exceptions an=
d
> >  interrupts with no indication of any differences to other (not repor=
ted)
> >  events that fire on a regular basis. Apparently, once in a blue moon
> >  (relatively speaking), for the first instruction of a handler (even
> >  though it is definitely executed and qemu does print a trace-line fo=
r
> >  that instruction):
> >=20
>=20>  | Trace 0: 0x7fffa0b03900 [00104004/000000023fde73b4/00000021/ff02=
0200]
> >  | Trace 0: 0x7fffa02d9580 [00104004/000000023fde72b8/00000021/ff0202=
00]
> >  | Trace 0: 0x7fffa02dfc40 [00104004/000000023fde7338/00000021/ff0202=
00]
> >  | Trace 0: 0x7fffa0b03d00 [00104004/000000023fde73d4/00000021/ff0202=
00]
> >  | Trace 0: 0x7fffa0b03e80 [00104004/000000023fde73d8/00000021/ff0202=
00]
> >  | Trace 0: 0x7fffa0b04140 [00104004/000000023fde7408/00000021/ff0202=
00]
> >  | Trace 0: 0x7fffa02dd6c0 [00104004/000000023fde70b8/00000021/ff0202=
00]
> >  | Trace 0: 0x7fffa02dd800 [00104004/000000023fde7b90/00000021/ff0202=
00]
> >  | cpu_io_recompile: rewound execution of TB to 000000023fde7b90
> >=20
>=20So this happens when an instruction that is not the last instruction =
of
> the block does some IO. As IO accesses can potentially change system
> state we can't allow more instructions to run in the block that might
> not have that change of state captured
>=20
>=20cpu_io_recompile exits the loop and forces the next TranslationBlock =
to
> be only one (or maybe two instructions). We have to play games with
> instrumentation to avoid double counting execution:
>=20
>=20 /*
>  * Exit the loop and potentially generate a new TB executing the
>  * just the I/O insns. We also limit instrumentation to memory
>  * operations only (which execute after completion) so we don't
>  * double instrument the instruction.
>  */
>  cpu->cflags_next_tb =3D curr_cflags(cpu) | CF_MEMI_ONLY | n;
>=20
>=20The instruction is in a weird state having both executed (from the
> plugin point of view) but not changed any state (stopped from doing MMI=
O
> until the next instruction).
>=20
>=20>=20
>=20> | Taking exception 5 [IRQ] on CPU 0
> >  | ...from EL1 to EL1
> >  | ...with ESR 0x0/0x3800000
> >  | ...with SPSR 0x20000305
> >  | ...with ELR 0x23fde7b90
> >  | ...to EL1 PC 0x23fd77a80 PSTATE 0x23c5
> >=20
>=20I guess before we re-executed the new block an asynchronous interrupt
> came in?
>=20
>=20Does changing the above to:
>=20
>=20 cpu->cflags_next_tb =3D curr_cflags(cpu) | CF_MEMI_ONLY | CF_NOIRQ |=
 n;
>=20
>=20make the problem go away? It should ensure the next 1/2 instruction
> block execute without checking for async events. See gen_tb_start() for
> the gory details.

So my collegue was tracing this issue himself over the last week(a) and
arrived more or less at the same conclusion. According to him we don't
observe the issue anymore, either.

Thanks for the fix!

Regards,
Julian

