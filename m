Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42ADEC5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 04:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwuqa-0003Mi-EB; Thu, 20 Aug 2026 00:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wwuqY-0003MX-Dg
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 00:57:46 -0400
Received: from fhigh-b5-smtp.messagingengine.com ([202.12.124.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wwuqW-00059t-4B
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 00:57:45 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 858C47A00C8;
 Thu, 20 Aug 2026 00:57:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 20 Aug 2026 00:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1787201861;
 x=1787288261; bh=8IgeKrW3gP6FPlGHZu1CgHkTTqK178K4ykVNN9bq5AM=; b=
 WHU7t/IdKNGW0qYI30TPpl/T7zA7ZmtC/YHRF+HbfzXKa07quXpBrtkOy3ITQ2q4
 ANWOMbH+KQ3aSwSXGLkqyLIThSbJVooKLBfmhnnWelDguTE3+km+qUxcqHRiw+KS
 sXFzSwmf2rhmslceoy4P/NHmtW6cHp99+1EmYxdNoq/dgknsAiKR33e3ZyQZM9ce
 +X5bdTAwVzV1oGpxnbn+HmG+ORScnhl+G7CWn1podkXUFAHVPTLVN3YQBHsbsnpP
 TWD0JYyB2AySlFFXHdcglw+1ubzh4bVnlpqRX8bYs4hX1+IYIvYJ7Gcg0Xns/qpy
 oZzCJgEhU2AL8CkwV41UBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1787201861; x=1787288261; bh=8
 IgeKrW3gP6FPlGHZu1CgHkTTqK178K4ykVNN9bq5AM=; b=UpTZGTsLHrnr9jWl1
 rS1vbMi8SEuAvsWVXswdS0CfNaLDZ2eTh4RXgyMqW4rIw09m1oCeZ48RU2UhriKH
 o0SWoV/9FAuRR7yqg8ClsXpT1LCuIlntiKwZt1izNp4p7HUUkt4PNDIqjkPrsKVI
 NWAziuXOYH60r41hrqv6AxeMpPkjAZ13KHCg/SuJdJEucUact0AKVGAiMj17vxmS
 VEtae6kK9NgjA+fTVIC3rj1ZJFI2SvNor+inmWvM/1iaM0y4/nMNErMexfxmnklY
 Ru5gXQopCKNJlZRr6xQjIoyz/SKobaaqlr+Ey8+arWY7mq+vpeOCWFmOviyANA5t
 VF9Pw==
X-ME-Sender: <xms:RYmGagpU2-ub4_QHTNFxtiZGpgLq6GIzQYYlixzT5cv6XOtOsEew5Q>
 <xme:RYmGai-xxmBnbLZmTHY5we_ANC4Hs1TxL4Sc_gAFvIGA6NKseZ8ExF2RDZZG-K1x8
 Ct26hCId4-h9MnW5fBHsmKGTwa2UdmpkqhJsJQE2ABfYE_oAmtB3Qg>
X-ME-Received: <xmr:RYmGan-0HOCArP6uHwawd0BN14ibs82_RFU_kCla09gE1izczsVInkhLRY_fqTs74x24dntWLuJlc3o5zN8PDW2ZZYQ>
X-ME-Proxy-Cause: dmFkZTGiQkvhJ/oe/UAwEDGMdSZmDoEFytp6CUJf/oVCZxki4AjHJUJK/HtPSoO5ESKPmU
 3LJX8S2ulVq0RbZtaJlEe3GincQZin/tZ5qxnpGXYu6tmXfSy2QpRm3MyvHus1Ukim2gMT
 JKqJWkjNCjLCsMeK1MFG8IMI7koVKYTrCKMc9EgxIlRaUGIfLCaVAR5akPtqhSYUpZnr6l
 +Fu6z8zX2ZRyHAcKcxDyFBKXrq79u/XWgVYoRc4ETO1zs7EyrpK+ehk4LdMGp4gJRHpQoe
 zU2kO1te1daLeasnTaG3pUNlKv1os2j6Ylbr4aBklDq1xjDkJPccK/M1NxfkwJ/0Islan3
 Ti0jcrO96GPeNGY2jd0h4f/WXZVdRlyKOdhy3PAfs1S9ynrv1zE+RQzURbGJZ8jg5jaevy
 yqoxQQTtKYue4PZ6XtTn+BAjA58e0mmcSUbzNB2nD0bvT/7SX0Bh1Qltj/VprFmI7vyPdK
 Br5/thNqXfLcK+iZT4Yqbes3bensiFMet7cuWfWDrdLCVoaJ5M29vgLiFMYqB2ZBh+F5yJ
 WXMOmTvveVKcqjCCGZpjcXuHVoF2Tu2lx4No+vrWdoCkD7iJR6QzBrAfQZ5PQ0JZbFQRQ7
 PXe2Q/Fp6ajdPU8XgXD/v+viD51FImBwnOujlWB7GVkOOZ4gDx5AsqqYbSCg
X-ME-Proxy: <xmx:RYmGapuTCpbBPCTauHIhtf1CV4B9BM24tjb-wZk0_JeQVTbsUDSV7w>
 <xmx:RYmGaioRSxRjebIR1XTRJgogFhvPKwqPxzm2VUDpBS0_ztET0-EPfQ>
 <xmx:RYmGaulT9HucdUhZqmxgrpz50KQqcLxa1auv1j1byWs70XNQcb7Y5w>
 <xmx:RYmGauyN_Zx_F9_M5GynhEkGZ8hK9KPh-B_ZSILd4Cax3nIRKwHN-w>
 <xmx:RYmGapdG026FUrQLsjRKinu0qUlMWJf91r-7JJILbubYFLQPsrtNMe6L>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 00:57:39 -0400 (EDT)
Message-ID: <0be2d1745ff6b5d5d13b56b77ba85fb102508cfe.camel@alistair23.me>
Subject: Re: [PATCH] hw/riscv/virt: add dram-base machine property
From: Alistair <alistair@alistair23.me>
To: Shawn Rutledge <lists@ecloud.org>, qemu-devel@nongnu.org
Date: Thu, 20 Aug 2026 14:57:37 +1000
In-Reply-To: <3EA3AA8B-3FDB-42AC-A25E-0F78B6830FD6@ecloud.org>
References: <amscWwQvYUftUYW8@zen>
 <EB2AEA1E-D748-4448-8824-722A91099AA5@ecloud.org>
 <4d56aa849324980065070f85c05aa45f24180ac5.camel@alistair23.me>
 <3EA3AA8B-3FDB-42AC-A25E-0F78B6830FD6@ecloud.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.156;
 envelope-from=alistair@alistair23.me; helo=fhigh-b5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 2026-08-18 at 10:30 +0200, Shawn Rutledge wrote:
>=20
> > On Aug 12, 2026, at 18:13, Alistair <alistair@alistair23.me> wrote:
> >=20
> > On Fri, 2026-08-07 at 14:26 +0300, lists wrote:
> > > Ping.
> > >=20
> > > Do you have a different solution to emulate memory layouts of
> > > actual
> > > boards?
> >=20
> > The ideal answer is to model the board
>=20
>=20
> OK; that=E2=80=99s more work, and then there is an expectation that it wi=
ll
> be actively maintained, right? =C2=A0Banana Pi F3 is already out of

Correct

> production AFAICT; and it remains to be seen how many K3 boards will
> physically come into existence: there are already several designs so
> far, with different peripherals. Since I have theoretically bought
> the Deep Computing III Framework-based laptop (and it hasn=E2=80=99t ship=
ped
> yet), I hope I will be able to use it for a good long time, but maybe
> I won=E2=80=99t need emulation very often.

There seem to be a few K3 boards shipping. I have one on my desk now :)

>=20
> There is no demand for a distinct emulator for every known PC
> motherboard, despite often having different peripherals, but there is
> such a demand for embedded boards. =C2=A0Hmm. =C2=A0It seems like the ide=
a to
> =E2=80=9Cmodel the board=E2=80=9D every time and then maintain all those =
models
> doesn=E2=80=99t really scale. =C2=A0I would rather hope that riscv become=
s more of
> a standard platform, rather than ending up with a zoo of less-
> compatible devices like the ARM ecosystem does. =C2=A0Not that there=E2=
=80=99s
> much evidence for such a movement so far, but IMO there should be.

There are attempts at RVI, things like the server reference platform.=20
But that is up to them and the RISC-V ecosystem, not us in QEMU land.

>=20
> The point of the patch was to make the base address of virt
> adjustable, because it=E2=80=99s one thing that a particular kernel may b=
e
> least able to deal with, if its data segment (or worse, some code)
> contains absolute pointers. =C2=A0For a while it seemed that we would nee=
d

Yeah, I get that. But it is extra complexity for us to maintain and
doesn't really align with the goal of the virt board.

> to build separate kernels for each board. =C2=A0But I changed the linker
> to emit a relocation table, and the kernel to fix up the data-segment
> pointers at boot, and now we have a kernel that boots on the bpi-f3,
> a couple of K3 boards and qemu. =C2=A0So changing qemu=E2=80=99s base add=
ress is
> no longer necessary to get it to boot, but just enables testing high-
> memory paths where some bugs were found.

Great!

>=20
> > > For me this is necessary for the Plan 9 porting work: a Banana Pi
> > > F3
> > > has a different base address than one of the K3 boards, and both
> > > different than the QEMU default.
> >=20
> > The Banana Pi F3 and the K3 will also have different hardware
> > blocks at
> > different addresses. The starting address of memory isn't the only
> > or
> > even the main difference.
> >=20
> > I don't see how just changing the memory address fixes an issue for
> > you.
>=20
>=20
> It was just that certain bugs manifested in the case when the base
> address is at 0x100000000.
>=20
> So I suppose abandoning this is fine, if nobody else needs it.

It doesn't seem like something that anyone else needs

Thanks for the patch though!

Alistair

>=20
> > RISC-V SoCs can locate their DRAM at any address, that is true. But
> > I
> > don't see how just changing the virt machine address allows you to
> > suddenly test a K3 kernel on the virt board. The rest of the
> > hardware
> > is still different
>=20
>=20
> I don=E2=80=99t necessarily need to emulate all the hardware, at least to
> begin with.

