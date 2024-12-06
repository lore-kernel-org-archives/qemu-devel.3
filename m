Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62586E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 08:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJUAf-0003uH-J1; Fri, 06 Dec 2024 03:58:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tJUAe-0003u9-Rd
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 03:58:44 -0500
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tJUAc-0003Vo-Ks
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 03:58:44 -0500
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id D97E3181486
 for <qemu-devel@nongnu.org>; Fri,  6 Dec 2024 09:58:39 +0100 (CET)
Received: (qmail 8922 invoked by uid 990); 6 Dec 2024 08:58:39 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Fri, 06 Dec 2024 09:58:39 +0100
MIME-Version: 1.0
Date: Fri, 06 Dec 2024 08:58:39 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <0b8c1c08b7780b62dd2af81e437f2e690a07d70a@nut.email>
TLS-Required: No
Subject: Re: [RFC PATCH v3 01/11] plugins: add types for callbacks related to
 certain discontinuities
To: "Pierrick Bouvier" <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
In-Reply-To: <e45c0eed-fb2d-465d-b21e-ab3d395bcf71@linaro.org>
References: <cover.1733063076.git.neither@nut.email>
 <5e624b7244f1b0b294b28cd513aab04b6b294b1d.1733063076.git.neither@nut.email>
 <181b9b53a258257df1b24e7bfb8b0e6fc590c25f@nut.email>
 <35529516-cc96-41de-8e0d-a7807ccc09cb@linaro.org>
 <ca20c295f464ae7e3365e012ad9a550f70b34b51@nut.email>
 <64e40e6f-bc90-4760-bb70-fb67d80ff4d7@linaro.org>
 <51ac04eea17a6c5b59a240d3c57ce54a851e4989@nut.email>
 <e45c0eed-fb2d-465d-b21e-ab3d395bcf71@linaro.org>
X-Rspamd-Bar: ---
X-Rspamd-Report: BAYES_HAM(-3) MIME_GOOD(-0.1)
X-Rspamd-Score: -3.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:subject:date;
 bh=Hc9hJXWSrS7vSgauEXZl9oG5yKi37qkaJrfBPSUlBWk=;
 b=dYXpfoTtXnYdJVmEhM3mY6vXGzfIPLjL3Xx8vbj/L/JPJeO+VhtaY0FN8WtME/DEzEWllA8Nns
 PpXhN8PFDExtSPBWgaP/2Fm/3vz9CNC1nC1bAIvM9h5IRy3tIvgs9RU1ow2eaGY0EavE5Ht4XlEw
 jZ1OFXWnPoSSB/JPUy8et7dxeqBWR/mjvl59BSgePq0jlqnhYi3q+C+Lg3qZIa/dU4V8BFY6o1NE
 weXwNG84PCbPty+AdgBVizgEbXjmpIh3h9wP2IxPsrcmTj1Jbw4mad1WBW4+XSTLmOVwNyQVIa0Y
 vJYAGL8c4MKCPGd9vEsrBKm/9/PzvuuFl1hAdVj4f2q4hDRkAOoBTV4OYWz3CEmLBo+VMuewHN4O
 MZw1kkf8A55p2rW0f74wI5K6P4BONRUeo4ZW8lgKzHUgP3fxqK9HIPMluFeQCP4BAxNfGuD1Y8RX
 QvtvAFp2dhDiPOvnQsnoPyiz5qVFDQk0RaJZGXSVgKOhv7rDeayV54RcCSNXLEnrRXQ3n9qOY2y6
 jyMbJk2iFa2TkeCyjg9ulO8e90nsPxknHID4mwMgV9JmX6SqNjoTFdKhtq9w6Q+r4df2gJk+n28j
 3dfD7alqWl4f91i1rPSVXp9mJSRi/X5D8ViO61Cwa2k5kvO/RGzfyZ2Hwvzz1bDJklv680y7RMh1
 0=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
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

Hi Pierrick,

December 6, 2024 at 12:03 AM, "Pierrick Bouvier" wrote:
> On 12/5/24 13:50, Julian Ganz wrote:
> >  If you cannot rely on an input being a sensible value, doesn't that
> >  render the input useless?
> >=20
>=20I agree. If for a specific event it's impossible to provide a value (=
i.e. the value has no meaning for a real cpu), it will just point that we=
 need several types of data per event, and the compromise of having a sin=
gle callback won't be possible.
>=20
>=20We should differentiate "it's hard to find this value in QEMU" vs "th=
is value does not exist in real life". The first can be solved if we put =
effort into it. And every time a cpu changes it's flow of execution, it m=
akes sense to find where it was just before.
>=20
>=20One of the end goals is to be able to build a full control flow graph=
, with edges labeled on transition type (exceptions, traps, interrupts, j=
ump, fallback), which we can do with the triple {event,from,to}.

I agree that that triple is sensible for any event type and likely
useful to plugin authors. At least if the semantics are sufficiently
uniform among event types. However, I also feel that given the actual
implementation (hooks sprinkled over target specific code) this is not
easily achievable reliably. At least testability should be a hard
requirement. Otherwise the API's reliability will inevitably deteriorate
over time without any way to tell how bad the situation got.

> > > Let's try to move forward, and solve the problems we have with from=
_pc. The testing part can be solved already (as explained in a previous m=
essage). In which cases can't you identify from_pc?
> > >=20
>=20>  I'll have to check, but problems that I discussed with a colleague
> >  included jumps to an unmapped page resulting in the appropriate
> >  exception. We ultimately agreed that in such a situation from_pc sho=
uld
> >  point to the jump target inside the unmapped page, instead of, say, =
the
> >  jump. We assume that most targets should already behave this way wit=
hout
> >  further changes. However, in order to compute the correct from_pc, w=
e
> >  need to know the jump target before the exception is raised (i.e. ri=
ght
> >  after the jump instruction is executed), and that's not necessarily
> >  straight-forward to do in a plugin.
> >=20
>=20It's an interesting conversation. For the scope of this series, I agr=
ee you should use the jump target, which triggered the trap.
>=20
>=20In fine, transitions should simply follow what the cpu does.
>=20
>=20- orig_insn: jump to A
> - jump_target: execute A traps
> - page_fault: load page
> - jump_target: come back to A
>=20
>=20event(JUMP, orig_insn, jump_target) // not covered by this series
> event(EXCEPTION, jump_target, page_fault)
> ... execute page_fault (with potential other transitions)
> event(JUMP, end_page_fault, jump_target)
>=20
>=20In the case of a double trap, we could follow the same logic, and rep=
resent the original transition that lead to the trap, and the two consecu=
tive traps.
>=20
>=20Does it make sense?

Yes, those transitions are correct imo. And if a jump event should be
introduced at some point, the call sequence would look like that. My
issue is that testing this (in a plugin) will not be straight forward
or even impossible. And overly complex tests don't exactly provoke
confidence.

Regards,
Julian Ganz

