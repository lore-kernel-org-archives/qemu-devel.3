Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C375A606A32E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 04:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=alistair23.me header.i=@alistair23.me header.a=rsa-sha256 header.s=fm3 header.b=NepD8BlT;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=0F2GBT2z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW4tO-0005hU-6y; Tue, 24 Nov 2026 23:46:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xW4tJ-0005eg-DQ
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 23:45:59 -0500
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xW4tE-0001HJ-TM
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 23:45:55 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 892D41400405
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:45:50 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Tue, 24 Nov 2026 23:45:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1795581950; x=1795668350; bh=XzvZ2D9Ew3H/bGnUhUR9sAcclrKHb6Xa
 ylHMG8qeMsg=; b=NepD8BlTVJEUSAve3/aS7TVZiKFXjBMcdsbS9nNXfxhHmc/a
 9Qcn4V2gnk6jeetwZ1t3PIF+jkziJVnk8iCuXufjCtN6tGeHQOzKoAhPKim+SL1x
 ibnh80L719ErXDyMr7J6aP4TKZ0ZADhf9nYMkSJIFsc0EP13j52C4VXKk2Ud08YZ
 fDpkuzkNs4D78piN121U5Nmx3e3QEj21rzdx3ikZhQYbIpTP1jvLI+vtzfxNG+lZ
 m7CxS+TxRBXUHw5BfJ32iLxNbIf3AFu1F/zX5I/o8M9WrjodmHwC7RhcSzrvZGxG
 3giP/I2OF5vMzg7u6lI5mk0GB50cF/nrLx/Xew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795581950; x=
 1795668350; bh=XzvZ2D9Ew3H/bGnUhUR9sAcclrKHb6XaylHMG8qeMsg=; b=0
 F2GBT2zsDBFbt+28QvaeDENIdrnfJeRSxYGz32qXPZjMfiOIDG/X3pmaC5P35K5s
 g+JwDDm/wCE7zEQhUM2veIhF3JbTqz7JHD9j0n64x8e5ISmLyv4Zb5461k6As0Go
 fC6kCvRrEujlpFtoTeb3cDHLRCymhlyVFANXVgcWJbVwrY0xG+UIxT/tTH4iVZ7G
 4j3mWaY+HuhgH531vZ+AOt5TpfOftFQq3JRih2y+4BIC8lmUSD6egKapR1sqTUTo
 er2ahfS8pZZiAy4K6Y369Lzr3i3edBAIZ5eApuSZ/ju5+v6kbxHveplj+nosxlxQ
 eqBYIVeeEankUNVlslCMg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795581950; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:hXuDLkbZlpo4eK065cgdl1W4JwvB9gUgLQO1mi9h3Z9nXZp
 5BPTzoIbGYehLs0iReBDmva+fwJBQ/YRpSuR/w6VmJ5pqDnNhJgvjYiIjW0eSqly
 8I7ENPlBnXT7Ouejyq6olCArrw1hcOHzJDdWS7qQ/TCIxBeHlVnizeBK+rNwymOR
 gBifYKxk8njJpv6UfaTxOmBgwJCtlqKmnq2KKpAxsToNIlaXgsGExCUuPRtqh3uj
 iwjuu4aLpDryvqKQR6bwZeEUE3yJ3Q7ZU148q5exaGXURw8xtEvk88WsKd3FEC4d
 r0POzAwmG/s8XH0lQt3+8ychBKW04A+cEagdSiA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:pF4uXtWsLAAKKWUmdIOgsgH3IyPd/hshJ7XNgl8LeP0=:XzvZ2D9Ew3H/bGnUhUR9sAcclrKHb6XaylHMG8qeMsg=;
X-ME-Sender: <xms:_mcGa7pctoZ3KTS3xHVPiKGObzyIHTEOqzIEM-2y_euB774yf7YzTQ>
 <xme:_mcGa5-CBJhvyAgCRTF72pOd0snuarpLyNpxiUdyax3FvfazMapzvlt_twK2-ToAR
 FJVnrKynOFEyU4AxxxmyxTy0IA_lYaRga_GcoyDzQr5jNdqzH0MJ1s>
X-ME-Received: <xmr:_mcGa3Uqb-963WS11owDmBC1DXiPDQaSw9yhhop-hE1rWe2ghyRRkAsnZU-jNpjcGI5hYyiSfHOUABkrGYZt3s02mg0>
X-ME-Proxy-Cause: dmFkZTEsC5ZNzhSn0GKR5G2qInTaEC1/J70sak9Af3yLzWC5/gdyN4ia09uoG5aplK1GCA
 AEQSMiFKIZmv5P3v3w40ZKKT44HxFZgc8RNqGiQIpumWCQ3FzoReYkLnYBfG5j4psoedRV
 nP11mXreL6A0jBj/mCp1cK1JCbJK+TE+HQPXlO0HMgYk+8tyqfssB9+ggAmwqzxDjA9LK5
 Hc5CBFnJvG2kShfPdiJ+gU3KO5/6k1BR32SnMLI2dIulNvCW+HCzq5VfU2g650sisNHKQY
 U3vi0gNy8TuUxdr5/wUIovXR/ED5X5fW5VRcFK7JZ1jCIPQRY0m+JatkkKm74xhNXXn3jM
 848ym5nYM3la1+BiFfXC6WuJHbdthDA+CKHhJNVPGL0i2KRqp+9OmyVkASZn9LQhTMN+sy
 DYQkKupxXpMBcoKqMTk/uUVsMfZC5iesBVDqWFR0Fyaq1KL90C7WVVoVrvvJzrgzc6jG12
 81BfGiGlYGMAEcTW46z4Vpw/U3LBUwIP5olB13rpnHMQDRpPonXmkdr2aiilYyD+P19MX/
 43tXEpjxUqrpqylFVHV3vTe/EntvyUnvtcs6NF9fBYbQGX0YaSsHxwUkh7OLeZrjOmD9Dv
 4CB6mHbm2wFxP3My55eHhSpRAFc2ax1L8aHh3tJ2cJvhVFsTHtsTwTCl0YYw
X-ME-Proxy: <xmx:_mcGa3ApKB7ynQ9KMxpMl-IheSYk8sTTUsHbNd52OGDKLgU1dPxLgA>
 <xmx:_mcGawxNEnRbBBBs58trMy_wFTjJ7mbL8tkzsQFPSeWuRhrmKw6lTg>
 <xmx:_mcGa8AZ3jS-M7GvD6aCNoZPW1AnwxB_klBMd7NJTskxsZm0lRVwxA>
 <xmx:_mcGa1byFLXmx-qz9txRXHdqyukmvSlKt0jCK1lZrIg7RZ-9-rjYLg>
 <xmx:_mcGa3S5BCdW7Wgzk_r_D6l680N3kYgSE54fB3w9Q3dZrSXbSeVZbhv_>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 23:45:48 -0500 (EST)
Message-ID: <54fb26d98d3072005b7d0ada3a39e30be7579c78.camel@alistair23.me>
Subject: Re: [PATCH 0/7] RISC-V: Add CDAC VEGA machine support
From: Alistair <alistair@alistair23.me>
To: Karthika B <karthika.b@cdac.in>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 25 Nov 2026 14:45:46 +1000
In-Reply-To: <1877215787.132651.1795579446420@webmail2.cdac.in>
References: <385625713.441366.1761727810206@webmail2.cdac.in>
 <20261016080709.17331-1-karthika.b@cdac.in>
 <efc72269be92a118b39a7190003aa167fbbae579.camel@alistair23.me>
 <1877215787.132651.1795579446420@webmail2.cdac.in>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 (by Flathub.org) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.153;
 envelope-from=alistair@alistair23.me; helo=fhigh-a2-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 2026-11-25 at 09:34 +0530, Karthika B wrote:
>=20
> Hi Alistair,
>=20
> Checking in on this thread. Wanted to ask whether the patches are
> still under consideration, or if anything further is needed from our
> side. In particular, I'd like to confirm whether the follow-up

They are not under consideration. I left some comments and I don't see
a v2 that addresses those.

> patches (the CPU fix and the OpenSBI test) looked correct, and
> whether our response on the AI-policy question was sufficient, or if
> there's anything there you'd like us to clarify or change.

The code breaks QEMU's current AI policy, so can not be merged. The
policy seems to be changing soon, so it's possible it could be merged
in the future, but that isn't for certain.

Alistair

>=20
> Happy to provide any further detail.
>=20
> > On 10/19/2026 7:11 AM Alistair <alistair@alistair23.me> wrote:
> >=20
> > =C2=A0
> > On Fri, 2026-10-16 at 13:37 +0530, Karthika B wrote:
> > > This series adds QEMU machine support for VEGA, a RISC-V SoC
> > > family
> > > developed by C-DAC (Centre for Development of Advanced Computing,
> > > India) as part of the DIR-V processor program.
> > > VEGA series of microprocessors are developed as part of the
> > > Microprocessor Development Programme, initiated and funded by
> > > MeitY
> > > (Ministry of Electronics and Information Technology, Government
> > > of
> > > India), with the mission objective to design and develop
> > > indigenously a family of microprocessors, related IPs, and the
> > > complete ecosystem to enable fully indigenous product development
> > > catering to various requirements in the strategic, industrial,
> > > and
> > > commercial sectors. VEGA is developed at C-DAC,
> > > Thiruvananthapuram.
> > >=20
> > > Background
> > > ----------
> > > VEGA is a series of 32-bit and 64-bit single/multi-core RISC-V
> > > processors (Thejas32 and Thejas64) developed under the DIR-V
> > > program,
> > > integrated with multi-level caches, an MMU, and a coherent
> > > interconnect on real silicon. This series adds a QEMU 'vega'
> > > machine
> > > model supporting both the Thejas32 (RV32) and Thejas64 (RV64)
> > > variants, modelled on real silicon behaviour rather than a
> > > synthetic/virtual platform.
> >=20
> > Thanks for the series. It's cool to see some more RISC-V designs.
> >=20
> > Thank you for submitting the patches.
> >=20
> > For some context, we already have support for a Shakti machine, and
> > that is being deprecated and removed as it hasn't been maintained
> > by
> > the original submitter.
> >=20
> > I also noticed that you listed yourself as "Odd Fixes" in the
> > maintainers file, so this won't be accepted.
> >=20
> > We don't have the resource to maintain your custom board and
> > reviewers
> > are stretched very thin to look at your patches. If you don't want
> > to
> > maintain it, we aren't going to be able to either.
> >=20
> > >=20
> > > More details on the VEGA processor series:
> > > =C2=A0 https://vegaprocessors.in/
> > > VEGA documentation:
> > > =C2=A0 https://cdac-vega.gitlab.io/
> > >=20
> > > The model has been validated against Aries boards (Thejas32) and
> > > Thejas64 SoCs, booting:
> > > =C2=A0 - bare-metal ELF payloads via -bios (no DTB, fixed UART
> > > framing),
> > > =C2=A0=C2=A0=C2=A0 for both RV32 and RV64, using the VEGA SDK's examp=
le UART
> > > =C2=A0=C2=A0=C2=A0 "hello world" application
> > > =C2=A0 - Linux via BBL with a user-supplied -dtb describing the SoC
> > > (RV64)
> >=20
> > No BBL, please use OpenSBI or an equivalent
> >=20
> > >=20
> > > What's included
> > > ----------------
> > > =C2=A0- hw/riscv/vega.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 - machine model, device creation,
> > > boot
> > > flow.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Note: VEGA does not genera=
te its
> > > device
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tree internally; -dtb is
> > > required
> > > for any
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -kernel boot (see note bel=
ow)
> > > =C2=A0- hw/intc/vega_plic.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 - CDAC PLIC variant (register
> > > layout
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 differs from the generic
> > > riscv,plic0;
> >=20
> > Why?
> >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 see patch N/N for details)
> > > =C2=A0- hw/intc/vega_aclint.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - ACLINT =
MSWI/SSWI/MTIMER, with the
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 STIMECMP handling VEGA's b=
oot
> > > ROM /
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BBL relies on
> > > =C2=A0- target/riscv/cpu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 - adds TYPE_RISCV_CPU_VEGA32 and
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TYPE_RISCV_CPU_VEGA64, CPU
> > > subtypes
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 baking in VEGA's fixed bas=
eline
> > > (IMA
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S/U + Zicsr/Zifencei +
> > > SV32/SV39),
> > > so
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -M vega boots on either
> > > architecture
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 without a manual -cpu stri=
ng;
> > > see
> > > note
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 below on why both are pare=
nted
> > > on
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sifive-u rather than the g=
eneric
> > > base
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPU type
> > > =C2=A0- docs/system/riscv/vega.rst - user-facing documentation
> > > =C2=A0- tests/functional/riscv32/test_vega.py,
> > > =C2=A0=C2=A0 tests/functional/riscv64/test_vega.py
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - functional tests booting -M vega
> > > on
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 both architectures (bare-m=
etal
> > > on
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 both; bare-metal + Linux/B=
BL on
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 riscv64), fetching small t=
est
> > > binaries
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from a stable, checksummed
> > > external
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asset repository
> > > =C2=A0- MAINTAINERS entry
> > >=20
> > > Notable hardware characteristics reviewers should know up front
> >=20
> > Have you read QEMU's AI policy?
> >=20
> > https://www.qemu.org/docs/master/devel/code-provenance.html#use-of-ai-g=
enerated-content
> >=20
> > > -----------------------------------------------------------------
> > > =C2=A0- The PLIC and CLINT/ACLINT are co-located at the same base
> > > address
> > > =C2=A0=C2=A0 on real VEGA silicon (0x20010000). This is not a QEMU
> > > modelling
> > > =C2=A0=C2=A0 error; it reflects the actual SoC memory map.
> >=20
> > What? Why?
> >=20
> > > =C2=A0- The PLIC aperture is 0x400 bytes, sized for the current
> > > maximum
> > > =C2=A0=C2=A0 hart count on this SoC family; it is not the generic ups=
tream
> > > PLIC
> > > =C2=A0=C2=A0 aperture size.
> > > =C2=A0- UART register framing differs between boot modes: bare-metal
> > > always
> > > =C2=A0=C2=A0 uses shift=3D2/io-width=3D4 (fixed 32-bit stride), while=
 Linux
> > > boot
> > > =C2=A0=C2=A0 reads reg-shift from the DTB serial node, since the two =
boot
> > > paths
> > > =C2=A0=C2=A0 exercise the hardware through different firmware layers.
> > > =C2=A0- TYPE_RISCV_CPU_VEGA32/VEGA64 are parented on
> > > TYPE_RISCV_CPU_SIFIVE_U
> > > =C2=A0=C2=A0 rather than TYPE_RISCV_CPU_BASE or TYPE_RISCV_BARE_CPU.
> > > =C2=A0=C2=A0 TYPE_RISCV_CPU_BASE's default misa_ext includes RVH, and=
 the
> > > =C2=A0=C2=A0 class-level misa_ext merge is OR-only (a subtype cannot =
clear
> > > a
> > > bit
> > > =C2=A0=C2=A0 its parent already set), so RVH could not be disabled fr=
om a
> > > =C2=A0=C2=A0 TYPE_RISCV_CPU_BASE-derived subtype. TYPE_RISCV_BARE_CPU
> > > avoids
> > > =C2=A0=C2=A0 that, but unconditionally forces max_satp_mode to 'bare'=
 for
> > > any
> > > =C2=A0=C2=A0 CPU in its lineage regardless of what the subtype config=
ures,
> > > which
> > > =C2=A0=C2=A0 breaks paging. TYPE_RISCV_CPU_SIFIVE_U has neither issue=
, but
> > > =C2=A0=C2=A0 silently sets priv_spec to PRIV_VERSION_1_10_0 (an older=
 RISC-
> > > V
> > > =C2=A0=C2=A0 privileged spec version) rather than the current one. Th=
is
> > > surfaced
> > > =C2=A0=C2=A0 as a real boot hang against production BBL/DTB pairs (BB=
L's
> > > =C2=A0=C2=A0 delegate_traps() mideleg assertion failed) that was not
> > > visible in
> > > =C2=A0=C2=A0 simpler test boots, since the hang depends on firmware b=
uilt
> > > =C2=A0=C2=A0 against a newer priv spec than 1.10.0. Both VEGA CPU sub=
types
> > > =C2=A0=C2=A0 explicitly override priv_spec back to PRIV_VERSION_LATES=
T to
> > > fix
> > > =C2=A0=C2=A0 this; anyone deriving a new CPU subtype from a SiFive-fa=
mily
> > > parent
> > > =C2=A0=C2=A0 should be aware this default does not propagate the way =
ISA
> > > =C2=A0=C2=A0 extension bits might be assumed to.
> > > =C2=A0- VEGA does not generate a device tree internally. -dtb is
> > > required
> > > =C2=A0=C2=A0 for any -kernel (Linux/BBL) boot; the machine errors out
> > > clearly
> > > if
> > > =C2=A0=C2=A0 a kernel is given without -dtb and without -bios firmwar=
e. A
> > > bare
> > > =C2=A0=C2=A0 "-M vega" with no boot arguments at all (e.g. qtest's ge=
neric
> > > =C2=A0=C2=A0 smoke tests) is a valid, inert state and does not error.=
 This
> > > keeps
> > > =C2=A0=C2=A0 the initial series scoped to what has been directly test=
ed;
> > > =C2=A0=C2=A0 internal FDT generation may follow as a later series.
> > > =C2=A0- PLIC and CLINT compatible strings are "cdac,plic-1.0.0" and
> > > =C2=A0=C2=A0 "riscv,clint0" respectively. CDAC's own Buildroot-based
> > > BBL/Linux
> > > =C2=A0=C2=A0 builds use a CDAC-specific PLIC driver matched against t=
he
> > > former,
> > > =C2=A0=C2=A0 and use the generic CLINT compatible string directly (no
> > > =C2=A0=C2=A0 CDAC-specific CLINT driver exists in any current VEGA fi=
rmware
> > > =C2=A0=C2=A0 variant). A DTB intended to boot stock, unmodified riscv=
-
> > > pk/BBL
> > > =C2=A0=C2=A0 (which only recognises "riscv,plic0" verbatim) will need=
 to
> > > =C2=A0=C2=A0 additionally advertise that generic string for the PLIC =
node.
> > >=20
> > > What is NOT included / deliberately left out
> > > ---------------------------------------------
> > > =C2=A0- No AIA/APLIC/IMSIC support: current VEGA silicon does not
> > > implement
> > > =C2=A0=C2=A0 AIA, so that code path (present in earlier internal revi=
sions)
> > > has
> > > =C2=A0=C2=A0 been removed rather than left as dead code.
> >=20
> > Again, please read the AI code policy
> >=20
> > https://www.qemu.org/docs/master/devel/code-provenance.html#use-of-ai-g=
enerated-content
> >=20
> > Alistair
> >=20
> > > =C2=A0- No internal device-tree generation: see note above; -dtb is
> > > =C2=A0=C2=A0 required for -kernel boots in this series.
> > > =C2=A0- No SDHCI, SPI, I2C functional models yet: exposed as
> > > =C2=A0=C2=A0 unimplemented-device stubs matching the real address ran=
ges,
> > > so
> > > =C2=A0=C2=A0 guest software can probe them safely; functional models =
may
> > > follow
> > > =C2=A0=C2=A0 in later series.
> > > =C2=A0- No RV32 Linux boot test yet: the functional test suite covers
> > > =C2=A0=C2=A0 bare-metal on both architectures and a full Linux/BBL bo=
ot on
> > > =C2=A0=C2=A0 riscv64 only, since an RV32 (Thejas32) Linux/BBL boot ha=
s not
> > > yet
> > > =C2=A0=C2=A0 been verified; this may follow in a later series once
> > > available.
> > >=20
> > > Testing
> > > -------
> > > =C2=A0- riscv32-softmmu and riscv64-softmmu builds, `make check` clea=
n
> > > on
> > > =C2=A0=C2=A0 both
> > > =C2=A0- checkpatch.pl clean across the series
> > > =C2=A0- Functional tests added under
> > > tests/functional/riscv32/test_vega.py
> > > =C2=A0=C2=A0 and tests/functional/riscv64/test_vega.py, passing via b=
oth
> > > direct
> > > =C2=A0=C2=A0 invocation and `meson test` on both architectures:
> > > =C2=A0=C2=A0=C2=A0=C2=A0 - bare-metal "hello world" boot (RV32 and RV=
64)
> > > =C2=A0=C2=A0=C2=A0=C2=A0 - full Linux boot via BBL to a login prompt =
(RV64)
> > > =C2=A0- Manual testing additionally covered: virtio-net networking,
> > > and an
> > > =C2=A0=C2=A0 extended stress-ng run (CPU, matrix, VM, filesystem, dev=
ice-
> > > access
> > > =C2=A0=C2=A0 stressors) under Linux on -M vega
> > >=20
> > > We previously posted an early version of VEGA machine support
> > > (Message-ID: <385625713.441366.1761727810206@webmail2.cdac.in>)
> > > without a proper cover letter, MAINTAINERS entry, documentation,
> > > or
> > > tests, and sent via a webmail client rather than git send-email,
> > > which likely affected formatting. This series is a corrected
> > > resubmission addressing all of that: it is sent via git send-
> > > email,
> > > and adds the documentation, MAINTAINERS entry, and functional
> > > tests
> > > that were missing before. We've since read and followed
> > > docs/devel/submitting-a-patch.rst in full. Feedback on process as
> > > well as code is very welcome.
> > >=20
> > > Karthika B (7):
> > > =C2=A0 hw/intc: Add CDAC VEGA PLIC device model
> > > =C2=A0 hw/intc: Add CDAC VEGA ACLINT device model
> > > =C2=A0 target/riscv: Add VEGA32 and VEGA64 CPU types
> > > =C2=A0 hw/riscv: Add CDAC VEGA machine model
> > > =C2=A0 docs/system/riscv: Add VEGA machine documentation
> > > =C2=A0 tests/functional: Add VEGA machine functional tests
> > > =C2=A0 MAINTAINERS: Add entry for VEGA machine
> > >=20
> > > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
14 +
> > > =C2=A0configs/devices/riscv64-softmmu/default.mak |=C2=A0=C2=A0 1 +
> > > =C2=A0docs/system/riscv/vega.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 219 ++=
+++++
> > > =C2=A0docs/system/target-riscv.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > =C2=A0hw/intc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +
> > > =C2=A0hw/intc/meson.build=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> > > =C2=A0hw/intc/vega_aclint.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 668
> > > ++++++++++++++++++++
> > > =C2=A0hw/intc/vega_plic.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 517
> > > +++++++++++++++
> > > =C2=A0hw/riscv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 11 +
> > > =C2=A0hw/riscv/meson.build=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > =C2=A0hw/riscv/vega.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 502
> > > +++++++++++++++
> > > =C2=A0include/hw/intc/vega_aclint.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 84 +++
> > > =C2=A0include/hw/intc/vega_plic.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 87 +++
> > > =C2=A0include/hw/riscv/vega.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 136 ++++
> > > =C2=A0target/riscv/cpu-qom.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> > > =C2=A0target/riscv/cpu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 25 +
> > > =C2=A0tests/functional/riscv32/meson.build=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > =C2=A0tests/functional/riscv32/test_vega.py=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 32 +
> > > =C2=A0tests/functional/riscv64/meson.build=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > =C2=A0tests/functional/riscv64/test_vega.py=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 63 ++
> > > =C2=A020 files changed, 2374 insertions(+)
> > > =C2=A0create mode 100644 docs/system/riscv/vega.rst
> > > =C2=A0create mode 100644 hw/intc/vega_aclint.c
> > > =C2=A0create mode 100644 hw/intc/vega_plic.c
> > > =C2=A0create mode 100644 hw/riscv/vega.c
> > > =C2=A0create mode 100644 include/hw/intc/vega_aclint.h
> > > =C2=A0create mode 100644 include/hw/intc/vega_plic.h
> > > =C2=A0create mode 100644 include/hw/riscv/vega.h
> > > =C2=A0create mode 100644 tests/functional/riscv32/test_vega.py
> > > =C2=A0create mode 100644 tests/functional/riscv64/test_vega.py
>=20
> With Regards,
> Karthika B
> Project Engineer
> HDG
>=20
> ---------------------------------------------------------------------
> ---------------------------------------
> [ C-DAC is on Social-Media too. Kindly follow us at:
> Facebook: https://www.facebook.com/CDACINDIA=C2=A0& Twitter: @cdacindia ]
>=20
> This e-mail is for the sole use of the intended recipient(s) and may
> contain confidential and privileged information. If you are not the
> intended recipient, please contact the sender by reply e-mail and
> destroy
> all copies and the original message. Any unauthorized review, use,
> disclosure, dissemination, forwarding, printing or copying of this
> email
> is strictly prohibited and appropriate legal action will be taken.
> ---------------------------------------------------------------------
> ---------------------------------------

