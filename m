Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C122C5DF70
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 08:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwFDc-0002TF-9p; Tue, 18 Aug 2026 04:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@ecloud.org>) id 1wwFDT-0002SF-Ti
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 04:30:45 -0400
Received: from cow.ash.relay.mailchannels.net ([23.83.222.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@ecloud.org>) id 1wwFDP-0000uC-Kd
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 04:30:39 -0400
X-Sender-Id: dreamhost|x-authsender|lists@ecloud.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 9A074403872
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 08:30:31 +0000 (UTC)
Received: from pdx1-sub0-mail-a225.dreamhost.com
 (100-113-72-160.trex-nlb.outbound.svc.cluster.local [100.113.72.160])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id EEDB94034BE
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 08:30:30 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|lists@ecloud.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|lists@ecloud.org
X-MailChannels-Auth-Id: dreamhost
X-Hysterical-Shrill: 516949f41acf11e4_1787041831467_2769609364
X-MC-Loop-Signature: 1787041831467:4065318997
X-MC-Ingress-Time: 1787041831467
Received: from pdx1-sub0-mail-a225.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.113.72.160 (trex/8.0.2); Tue, 18 Aug 2026 08:30:31 +0000
Received: from smtpclient.apple (55a42392.bb.online.no [85.164.35.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lists@ecloud.org)
 by pdx1-sub0-mail-a225.dreamhost.com (Postfix) with ESMTPSA id 4hPNF23XlPz4F
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 01:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ecloud.org;
 s=dreamhost; t=1787041830;
 bh=99FnGzf0ZHMYHe+drflmseV/5j1Y6JEULrYCSH0Ieo0=;
 h=From:Content-Type:Subject:Date:To;
 b=rZNfz6AKSOizKDKI8IaXqvIQeVqoNKZ2PdqO+XPxiDefKpW52YPVrexHJBJ7PDqgx
 DxXIIUBy09vmJaAYORVj2gFa2EiM0xasp3iMNnfhB7beeAnqSZ3K8dE9IHtkcWABic
 st0P3MEhHASkWkXysw2E9KSAvWXeB7Ol1NiIBXkin7Qc3F4mXIYm1XS4rx1lBrlVEg
 kV+vEpg79ESeQV1YMu0zJ0/dx9RMEsQUpjCn+h1wd6wNIeboFaMWYFGsJsRyieivmE
 8izqH/IZgytwbjiGRgBuRxQeIB/482vg72xePOpk8+Nd9RHJSjlD89aPQHrUuQQ1uC
 Wps8FAAae3zcg==
From: Shawn Rutledge <lists@ecloud.org>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_DE1CA345-321E-454E-9FCB-CA9E743CEE8A"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.5\))
Subject: Re: [PATCH] hw/riscv/virt: add dram-base machine property
Date: Tue, 18 Aug 2026 10:30:17 +0200
References: <amscWwQvYUftUYW8@zen>
 <EB2AEA1E-D748-4448-8824-722A91099AA5@ecloud.org>
 <4d56aa849324980065070f85c05aa45f24180ac5.camel@alistair23.me>
To: qemu-devel@nongnu.org
In-Reply-To: <4d56aa849324980065070f85c05aa45f24180ac5.camel@alistair23.me>
Message-Id: <3EA3AA8B-3FDB-42AC-A25E-0F78B6830FD6@ecloud.org>
X-Mailer: Apple Mail (2.3901.100.1.1.5)
Received-SPF: pass client-ip=23.83.222.41; envelope-from=lists@ecloud.org;
 helo=cow.ash.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--Apple-Mail=_DE1CA345-321E-454E-9FCB-CA9E743CEE8A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Aug 12, 2026, at 18:13, Alistair <alistair@alistair23.me> wrote:
>=20
> On Fri, 2026-08-07 at 14:26 +0300, lists wrote:
>> Ping.
>>=20
>> Do you have a different solution to emulate memory layouts of actual
>> boards?
>=20
> The ideal answer is to model the board

OK; that=E2=80=99s more work, and then there is an expectation that it =
will be actively maintained, right?  Banana Pi F3 is already out of =
production AFAICT; and it remains to be seen how many K3 boards will =
physically come into existence: there are already several designs so =
far, with different peripherals. Since I have theoretically bought the =
Deep Computing III Framework-based laptop (and it hasn=E2=80=99t shipped =
yet), I hope I will be able to use it for a good long time, but maybe I =
won=E2=80=99t need emulation very often.

There is no demand for a distinct emulator for every known PC =
motherboard, despite often having different peripherals, but there is =
such a demand for embedded boards.  Hmm.  It seems like the idea to =
=E2=80=9Cmodel the board=E2=80=9D every time and then maintain all those =
models doesn=E2=80=99t really scale.  I would rather hope that riscv =
becomes more of a standard platform, rather than ending up with a zoo of =
less-compatible devices like the ARM ecosystem does.  Not that there=E2=80=
=99s much evidence for such a movement so far, but IMO there should be.

The point of the patch was to make the base address of virt adjustable, =
because it=E2=80=99s one thing that a particular kernel may be least =
able to deal with, if its data segment (or worse, some code) contains =
absolute pointers.  For a while it seemed that we would need to build =
separate kernels for each board.  But I changed the linker to emit a =
relocation table, and the kernel to fix up the data-segment pointers at =
boot, and now we have a kernel that boots on the bpi-f3, a couple of K3 =
boards and qemu.  So changing qemu=E2=80=99s base address is no longer =
necessary to get it to boot, but just enables testing high-memory paths =
where some bugs were found.

>> For me this is necessary for the Plan 9 porting work: a Banana Pi F3
>> has a different base address than one of the K3 boards, and both
>> different than the QEMU default.
>=20
> The Banana Pi F3 and the K3 will also have different hardware blocks =
at
> different addresses. The starting address of memory isn't the only or
> even the main difference.
>=20
> I don't see how just changing the memory address fixes an issue for
> you.

It was just that certain bugs manifested in the case when the base =
address is at 0x100000000.

So I suppose abandoning this is fine, if nobody else needs it.

> RISC-V SoCs can locate their DRAM at any address, that is true. But I
> don't see how just changing the virt machine address allows you to
> suddenly test a K3 kernel on the virt board. The rest of the hardware
> is still different

I don=E2=80=99t necessarily need to emulate all the hardware, at least =
to begin with.


--Apple-Mail=_DE1CA345-321E-454E-9FCB-CA9E743CEE8A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br><div><blockquote type=3D"cite"><div>On=
 Aug 12, 2026, at 18:13, Alistair &lt;alistair@alistair23.me&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><div><div>On Fri, =
2026-08-07 at 14:26 +0300, lists wrote:<br><blockquote =
type=3D"cite">Ping.<br><br>Do you have a different solution to emulate =
memory layouts of actual<br>boards?<br></blockquote><br>The ideal answer =
is to model the =
board<br></div></div></blockquote><div><br></div><div>OK; that=E2=80=99s =
more work, and then there is an expectation that it will be actively =
maintained, right? &nbsp;Banana Pi F3 is already out of production =
AFAICT; and it remains to be seen how many K3 boards will physically =
come into existence: there are already several designs so far, with =
different peripherals. Since I have theoretically bought the Deep =
Computing III Framework-based laptop (and it hasn=E2=80=99t shipped =
yet), I hope I will be able to use it for a good long time, but maybe I =
won=E2=80=99t need emulation very often.</div><div><br></div><div>There =
is no demand for a distinct emulator for every known PC motherboard, =
despite often having different peripherals, but there is such a demand =
for embedded boards. &nbsp;Hmm. &nbsp;It seems like the idea to =E2=80=9Cm=
odel the board=E2=80=9D every time and then maintain all those models =
doesn=E2=80=99t really scale. &nbsp;I would rather hope that riscv =
becomes more of a standard platform, rather than ending up with a zoo of =
less-compatible devices like the ARM ecosystem does. &nbsp;Not that =
there=E2=80=99s much evidence for such a movement so far, but IMO there =
should be.</div><div><br></div><div>The point of the patch was to make =
the base address of <i>virt</i> adjustable, because it=E2=80=99s one =
thing that a particular kernel may be least able to deal with, if its =
data segment (or worse, some code) contains absolute pointers. &nbsp;For =
a while it seemed that we would need to build separate kernels for each =
board. &nbsp;But I changed the linker to emit a relocation table, and =
the kernel to fix up the data-segment pointers at boot, and now we have =
a kernel that boots on the bpi-f3, a couple of K3 boards and qemu. =
&nbsp;So changing qemu=E2=80=99s base address is no longer necessary to =
get it to boot, but just enables testing high-memory paths where some =
bugs were found.</div><br><blockquote type=3D"cite"><div><div><blockquote =
type=3D"cite">For me this is necessary for the Plan 9 porting work: a =
Banana Pi F3<br>has a different base address than one of the K3 boards, =
and both<br>different than the QEMU default.<br></blockquote><br>The =
Banana Pi F3 and the K3 will also have different hardware blocks =
at<br>different addresses. The starting address of memory isn't the only =
or<br>even the main difference.<br><br>I don't see how just changing the =
memory address fixes an issue =
for<br>you.<br></div></div></blockquote><div><br></div><div>It was just =
that certain bugs manifested in the case when the base address is at =
0x100000000.</div><div><br></div><div>So I suppose abandoning this is =
fine, if nobody else needs it.</div><div><br></div><blockquote =
type=3D"cite"><div><div>RISC-V SoCs can locate their DRAM at any =
address, that is true. But I<br>don't see how just changing the virt =
machine address allows you to<br>suddenly test a K3 kernel on the virt =
board. The rest of the hardware<br>is still =
different<br></div></div></blockquote><div><br></div>I don=E2=80=99t =
necessarily need to emulate <i>all</i> the hardware, at least to begin =
with.</div><div><br></div></body></html>=

--Apple-Mail=_DE1CA345-321E-454E-9FCB-CA9E743CEE8A--

