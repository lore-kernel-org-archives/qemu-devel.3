Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AFBC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 23:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgY2a-00065i-5d; Tue, 20 Aug 2024 19:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@szczek.dev>) id 1sgY2Y-00064i-F2
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 19:13:26 -0400
Received: from mail-4018.proton.ch ([185.70.40.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@szczek.dev>) id 1sgY2W-0004Xe-N7
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 19:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szczek.dev;
 s=protonmail; t=1724195602; x=1724454802;
 bh=1EjIWgfEriusn9pVSkMGTVtsPLEopXNQBFwy7k0OjtY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=LXOQ43yR9nxwKXOmSle1qMf3fLELhEGiU+AFvhyAuqiPXVuTq8sUTIPS83s69KEen
 F9LEvETAZjSRr9g0M9U69P87OylF3eRL/hqIzfq8Jhzvad6hKvGZur830FtMMbPH1x
 3IyV1JEYW55VW4HPdqsssmq4e0l9iwG119WiYJK8LfGIvwTpa7uAcRbS9hfa9G5RUS
 kPH/cBxdOyeL1zW5sxwK2e/p8JdDpx6MXJMQ1Z17zsgnrgtgmIOhr4x95UPwVXEDlA
 O6rMUlqwaZVPgiwNtGL4YI/UgxSkD6OxnlpAXd9NZZg6sLPb2bPkLVYBhRgi1nFKj4
 lUs/ncfAsc6RQ==
Date: Tue, 20 Aug 2024 23:13:17 +0000
To: Richard Henderson <richard.henderson@linaro.org>
From: =?utf-8?Q?Kamil_Szcz=C4=99k?= <kamil@szczek.dev>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: Re: [PATCH] hw/i386/pc: Fix enum value assertion
Message-ID: <TDUpU7Y9sXLNyDSH5sTnX-puxNecA2F0kc0OeQzH9IrHCCICaXQViz5aaExICXxLR9zNO-WtnG-i6fGciPXi0-YqtsU0GDGf-irZRr7uhiI=@szczek.dev>
In-Reply-To: <245b32c8-ff8d-4c24-8ca1-fafa1e2fbb0b@linaro.org>
References: <oPimw5pKWjOolRVo_7-wrc75fq9RQccGIZFwWLTLupIprA9PaVm6IDzlE5M_MEZLCWtT31P55BAwc1VgCpEGyB21qyGLDRekNlK6ueu4MaA=@szczek.dev>
 <245b32c8-ff8d-4c24-8ca1-fafa1e2fbb0b@linaro.org>
Feedback-ID: 37679334:user:proton
X-Pm-Message-ID: 1524725a407e15a48b3f06d5e8489ae313993680
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.40.18; envelope-from=kamil@szczek.dev;
 helo=mail-4018.proton.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wednesday, August 21st, 2024 at 00:59, Richard Henderson <richard.hender=
son@linaro.org> wrote:
> On 8/21/24 08:52, Kamil Szcz=C4=99k wrote:
>=20
> > Coverity reported:
> >=20
> > > > > CID 1559533: Integer handling issues (CONSTANT_EXPRESSION_RESULT)
> > > > > "pcms->vmport >=3D 0" is always true regardless of the values of
> > > > > its operands. This occurs as the logical first operand of "&&".
> >=20
> > Signed-off-by: Kamil Szcz=C4=99k kamil@szczek.dev
> > Reported-By: Philippe Mathieu-Daud=C3=A9 philmd@linaro.org
> > ---
> > hw/i386/pc.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index 7779c88a91..523dfe3f3f 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -1221,7 +1221,7 @@ void pc_basic_device_init(struct PCMachineState *=
pcms,
> > isa_realize_and_unref(pcms->pcspk, isa_bus, &error_fatal);
> > }
> >=20
> > - assert(pcms->vmport >=3D 0 && pcms->vmport < ON_OFF_AUTO__MAX);
> > + assert(pcms->vmport < ON_OFF_AUTO__MAX);
>=20
>=20
> Given the usage here
>=20
> > if (pcms->vmport =3D=3D ON_OFF_AUTO_AUTO) {
>=20
>=20
> and later, here
>=20
> > pc_superio_init(isa_bus, create_fdctrl, pcms->i8042_enabled,
> > pcms->vmport !=3D ON_OFF_AUTO_ON, &error_fatal);
>=20
>=20
> absolutely nothing goes off the rails no matter the value of vmport.
>=20
> It is not used to index an array, which might be out of bounds.
> It it not a security issue.
> There's no need or benefit for the assert at all.
>=20

Agreed, v2 posted.

