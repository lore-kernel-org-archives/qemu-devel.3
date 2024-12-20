Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB1EE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 11:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tObTg-0001XE-27; Fri, 20 Dec 2024 06:47:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tObTe-0001T3-IX
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 06:47:30 -0500
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tObTc-0002Im-Ac
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 06:47:30 -0500
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id DDBC9181174
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 12:47:16 +0100 (CET)
Received: (qmail 17377 invoked by uid 990); 20 Dec 2024 11:47:16 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Fri, 20 Dec 2024 12:47:16 +0100
MIME-Version: 1.0
Date: Fri, 20 Dec 2024 11:47:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <590990025f1f43704ca8831254754661c176c42f@nut.email>
TLS-Required: No
Subject: Re: [RFC PATCH v3 11/11] tests: add plugin asserting correctness of
 discon event's to_pc
To: "Pierrick Bouvier" <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: "=?utf-8?B?QWxleCBCZW5uw6ll?=" <alex.bennee@linaro.org>, "Alexandre
 Iooss" <erdnaxe@crans.org>, "Mahmoud Mandour" <ma.mandourr@gmail.com>
In-Reply-To: <d4b17c7d-c1d2-4e43-8eee-d1667e3ee5a2@linaro.org>
References: <cover.1733063076.git.neither@nut.email>
 <36d316bf3e8b0aca778c5e8d1acde39a7f361946.1733063076.git.neither@nut.email>
 <d4b17c7d-c1d2-4e43-8eee-d1667e3ee5a2@linaro.org>
X-Rspamd-Bar: +
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) MIME_GOOD(-0.1)
X-Rspamd-Score: 1.399999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=TPws9O7oWat8V8+qKpa+pi8rJtKfWj5dn/3GbdSjnzY=;
 b=b5RPa9tz7ikt6jA9H8BkwruyMR8I2Zgnh5X+SVzdwj5Qh59c6Wlc65o2H+Vc/V+G+okqbLQ/q1
 yxOMnKeQTOIsJQXBWvGhGtA52CBC3YP7lB56UzUJD1RR00zjXaloJSJ8VLC3ksVbh/TA+FG3h5jL
 RKPd2Yjt92xkBkk61NzjqpN+E2jOW9p25FjpE14JJqcaPeZ5U9L4X6AIx8rDLkPgnXamBSfjB2Ke
 x52ajqeYmroNJqsLrmPmmvZ6KiepXLuYB6uzrBjir1zqZXWhERSJ1WNZuypdZt1p0dLqo42WQh7T
 xEDF6QuDOhqrAomOfLByELGFJ1wrHujzK6Khpn+AuENYOvGGqyhu2LZPM8oybBmmMDVdvphU/Gbk
 Lmaod2R4kuN80WiRU9Vav2487xzCcoz7f9F8HnAWLHbKMbGcGqlPVoyU209borctRLVhSiZYmONE
 6AseF4LnouxzfpjuK7yK99JWlIHI+tZ5QiuUk+0C1Q+zGUU2ijN1UeO/kn3m4CyiTkhi9N+Ptx27
 DK3Jk0H+9PQNWEX11F1L9iw741MONGjFj/BUwL9gjh5mnQL6zgcyKpuR0bpDBHJqHOyzkcZgFg/I
 QuIvaI7LP6LM3aJsnckFhHV8eylWWvJ/UmhV5qllJ1RQHe9o3tUpfQB/UPFCLaSO4cT9ss/Fu6zK
 0=
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

December 5, 2024 at 12:33 AM, "Pierrick Bouvier" wrote:
> On 12/2/24 11:41, Julian Ganz wrote:
> >  +static void insn_exec(unsigned int vcpu_index, void *userdata)
> >  +{
> >  + struct cpu_state *state =3D qemu_plugin_scoreboard_find(states, vc=
pu_index);
> >  + uint64_t pc =3D (uint64_t) userdata;
> >  + GString* report;
> >  +
> >  + if (state->has_next) {
> >  + if (state->next_pc !=3D pc) {
> >  + report =3D g_string_new("Trap target PC mismatch\n");
> >  + g_string_append_printf(report,
> >  + "Expected: %"PRIx64"\nEncountered: %"
> >  + PRIx64"\n",
> >  + state->next_pc, pc);
> >  + qemu_plugin_outs(report->str);
> >  + if (abort_on_mismatch) {
> >  + g_abort();
> >  + }
> >  + g_string_free(report, true);
> >  + }
> >  + state->has_next =3D false;
> >  + }
> >  +}
> >=20
>=20When booting an arm64 vm, I get this message:
> Trap target PC mismatch
> Expected: 23faf3a80
> Encountered: 23faf3a84

A colleague of mine went to great lengths trying to track and reliably
reproduce this. We think that it's something amiss with the existing
instruction exec callback infrastructure. So... it's not something I'll
be addressing with the next iteration as it's out of scope. We'll
probably continue looking into it, though.

The mismatch is reported perfectly normal and boring exceptions and
interrupts with no indication of any differences to other (not reported)
events that fire on a regular basis. Apparently, once in a blue moon
(relatively speaking), for the first instruction of a handler (even
though it is definitely executed and qemu does print a trace-line for
that instruction):

| Trace 0: 0x7fffa0b03900 [00104004/000000023fde73b4/00000021/ff020200]
| Trace 0: 0x7fffa02d9580 [00104004/000000023fde72b8/00000021/ff020200]
| Trace 0: 0x7fffa02dfc40 [00104004/000000023fde7338/00000021/ff020200]
| Trace 0: 0x7fffa0b03d00 [00104004/000000023fde73d4/00000021/ff020200]
| Trace 0: 0x7fffa0b03e80 [00104004/000000023fde73d8/00000021/ff020200]
| Trace 0: 0x7fffa0b04140 [00104004/000000023fde7408/00000021/ff020200]
| Trace 0: 0x7fffa02dd6c0 [00104004/000000023fde70b8/00000021/ff020200]
| Trace 0: 0x7fffa02dd800 [00104004/000000023fde7b90/00000021/ff020200]
| cpu_io_recompile: rewound execution of TB to 000000023fde7b90
| Taking exception 5 [IRQ] on CPU 0
| ...from EL1 to EL1
| ...with ESR 0x0/0x3800000
| ...with SPSR 0x20000305
| ...with ELR 0x23fde7b90
| ...to EL1 PC 0x23fd77a80 PSTATE 0x23c5
| Trace 0: 0x7fffa13a8340 [00104004/000000023fd77a80/00000021/ff021201]
| Trace 0: 0x7fffa13a8480 [00104004/000000023fd77a84/00000021/ff020200]
| Trap target PC mismatch CPU 0
| Expected:    23fd77a80
| Encountered: 23fd77a84
| warning: 44	./nptl/pthread_kill.c: No such file or directory
| Couldn't get registers: No such process.

It does show up with both single-core and multi-core VMs, so that at
least eliminates some possibilities. Maybe :/

The issue is nasty to reproduce in a way that allows any meaningful
investigation. It usually involves sifting through many GBs of Qemu logs
for maybe one occurance. We could add another testing/dummy plugin that
just prints the PC for _any_ instruction executed and have a skript
check for non-alternating Trace-lines from Qemu and that Plugin. But
then we're talking nearly double the amount of Lines to look through
with probably little additional information.

Regards,
Julian

