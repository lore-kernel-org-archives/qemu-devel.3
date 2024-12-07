Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CF5E7717B
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2024 13:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJv0o-00031h-1j; Sat, 07 Dec 2024 08:38:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tJv0h-00031R-5r
 for qemu-devel@nongnu.org; Sat, 07 Dec 2024 08:38:16 -0500
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tJv0e-0004jm-6r
 for qemu-devel@nongnu.org; Sat, 07 Dec 2024 08:38:14 -0500
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 8E8D01809DC
 for <qemu-devel@nongnu.org>; Sat,  7 Dec 2024 14:38:01 +0100 (CET)
Received: (qmail 14767 invoked by uid 990); 7 Dec 2024 13:38:01 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sat, 07 Dec 2024 14:38:01 +0100
MIME-Version: 1.0
Date: Sat, 07 Dec 2024 13:38:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <2f8052fd509a1e7eba334c1881a6b46030f3d4dd@nut.email>
TLS-Required: No
Subject: Re: [RFC PATCH v3 01/11] plugins: add types for callbacks related to
 certain discontinuities
To: "Pierrick Bouvier" <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
In-Reply-To: <85423c12-3d2f-4d17-a7fa-ba3de32e7d44@linaro.org>
References: <cover.1733063076.git.neither@nut.email>
 <5e624b7244f1b0b294b28cd513aab04b6b294b1d.1733063076.git.neither@nut.email>
 <181b9b53a258257df1b24e7bfb8b0e6fc590c25f@nut.email>
 <35529516-cc96-41de-8e0d-a7807ccc09cb@linaro.org>
 <ca20c295f464ae7e3365e012ad9a550f70b34b51@nut.email>
 <64e40e6f-bc90-4760-bb70-fb67d80ff4d7@linaro.org>
 <51ac04eea17a6c5b59a240d3c57ce54a851e4989@nut.email>
 <e45c0eed-fb2d-465d-b21e-ab3d395bcf71@linaro.org>
 <0b8c1c08b7780b62dd2af81e437f2e690a07d70a@nut.email>
 <85423c12-3d2f-4d17-a7fa-ba3de32e7d44@linaro.org>
X-Rspamd-Bar: /
X-Rspamd-Report: BAYES_HAM(-0.350792) MIME_GOOD(-0.1)
X-Rspamd-Score: -0.450792
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:subject:date;
 bh=y/vwuyuoSoUTTjesu58k67Kfu6CP1ZLCXcRUqOs8rWE=;
 b=qCl9X1+7IsZIwmqcxwLuQE1xKB1xsiwGjS4mi6uF9520r/ZsHxPalsLBOgWCBoRvH+RJwGqlN/
 iesgOec/CID0VDBFnwe7d2G+ljwzv68dKlfYFaGb0YjUnaKebgez0+zo6pTasDu3xJxPfAEnNbYr
 EfA9+C5BjxAtVuZH50W08XjMxS6RlUHwgvNKrz+HzbaqHY/tcFQy2575OU/o1x1TQPIbcB5giTi9
 eeeZs5hzrAOHntYWWU/uUuu9A3h9eo7y5k3kjlzMvQ1hbwUXeS2t9becVM2eLEqnYwoGpvEmVMfT
 hhwKnPu570fVdrrccPotRukiB0BWFEF/b6I/QrA56Nx9WpzopnR+2QVZte7m/8Ems1ITsNzt+RGY
 I3ZCZxcLERzqCLmr9ndu/ywBgXbWNPd3WrXpqRcExeOwjyXXztKlxAMw0JxMqzO23BHrI1S0/hpX
 9Mxigg3dBDxhAQHCz78+/rqA+rVSqbVPe+MaQ+xMcZ64X/d27V2FFco4oyJVeon3xY1nYTLiXfLk
 m1RyYKjDqMOkmGqzUItL85BHDsddUvDKmRAngZiNdqsLfPoRX+gc8dEwHXEJLHkGELAbzJzg6EM2
 qg/6ZBXFRExsqUT1glkvaCSg6e059pJb3+q/aP62fmiTTnrAq0yut+iFBABqy28W94YvRGj6DWpn
 A=
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

December 6, 2024 at 7:59 PM, "Pierrick Bouvier" wrote:
> On 12/6/24 00:58, Julian Ganz wrote:
> >  December 6, 2024 at 12:03 AM, "Pierrick Bouvier" wrote:
> > > It's an interesting conversation. For the scope of this series, I a=
gree you should use the jump target, which triggered the trap.
> > >=20
>=20> >  In fine, transitions should simply follow what the cpu does.
> > >=20
>=20> >  - orig_insn: jump to A
> > >  - jump_target: execute A traps
> > >  - page_fault: load page
> > >  - jump_target: come back to A
> > >=20
>=20> >  event(JUMP, orig_insn, jump_target) // not covered by this serie=
s
> > >  event(EXCEPTION, jump_target, page_fault)
> > >  ... execute page_fault (with potential other transitions)
> > >  event(JUMP, end_page_fault, jump_target)
> > >=20
>=20> >  In the case of a double trap, we could follow the same logic, an=
d represent the original transition that lead to the trap, and the two co=
nsecutive traps.
> > >=20
>=20> >  Does it make sense?
> > >=20
>=20>  Yes, those transitions are correct imo. And if a jump event should=
 be
> >  introduced at some point, the call sequence would look like that. My
> >  issue is that testing this (in a plugin) will not be straight forwar=
d
> >  or even impossible. And overly complex tests don't exactly provoke
> >  confidence.
> >=20
>=20Instruction instrumentation is done before executing the instruction =
itself, as you can see by running:
> ./build/qemu-x86_64 -plugin build/tests/tcg/plugins/libinsn.so -d in_as=
m,op /usr/bin/true
>=20
>=20I'm not entirely sure about the sequence when there is an exception w=
hile fetching the instruction though. You can give it a try, track the PC=
 using insn instrumentation, and we can identify which cases are not work=
ing.
>=20
>=20The test plugin itself is not complicated.
> You'll need:
> - one callback per instruction to set the expected pc (possibly optimiz=
ed with inline operation), used to compare to from_pc, and we check if (o=
ptional) to_pc matches the current instruction.

What I'm saying ist that this exactly is not feasible for quite a few
relevant instructions. As someone who isn't all too intimate with TCG
itself, it's not even clear if we can rely on jump and branch
instructions only occuring at the end of a tb. At least a superficial
glance at the documentation tells me we can, but if this should in fact
not be the case, or if someone introduces something like zero overhead
loops inside a tb, all bets are off.

> - when the callback for discontinuity is called, we check if from_pc is=
 matching, and register the next expected with to_pc.
>=20
>=20We can then add tests targeting supported architectures using the plu=
gin, and ensuring it never fails.
> It's hard to know we don't miss events though. Except if we write manua=
l assembly system mode tests, that trigger the expected behaviour. But it=
 would be tedious, and I'm really not sure there is a real value with red=
uced examples like this.

So currently my thinking goes in the direction of having the plugin
print a warning every time we don't have an expected from_pc to check
against. Probably also have this be a feature you can deactivate.

Regards,
Julian Ganz

