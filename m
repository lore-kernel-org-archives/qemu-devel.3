Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89CFDC5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 18:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtqon-000614-OD; Tue, 11 Aug 2026 14:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtqok-0005zW-6g; Tue, 11 Aug 2026 14:03:16 -0400
Received: from fhigh-a5-smtp.messagingengine.com ([103.168.172.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtqoi-0005Jq-FO; Tue, 11 Aug 2026 14:03:13 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 1247C1400157;
 Tue, 11 Aug 2026 14:03:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Tue, 11 Aug 2026 14:03:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786471390; x=1786557790; bh=q/4cA+OUv4vxd+wTzVWMBpask7QSetud
 6QSGUeUsdew=; b=R4kaKZt1TEiQJrhWsNLgxVrZ5wBwHm3tEbm2g4IE1S396shj
 r2UI4vyO5SJLLJTJ0Nk3v0hD+qpw4ktMewiJIkyk3/dz0Ttk9rycbfQg9lsjp7aA
 FOmKzRcj+VBRKMhmaobNTUh5I7toqGz6QCY7HNbV1LxzIyFUm+9QFQ11beQaDQX9
 fvGtbYvKIbwyE8d12/jRKlipt27Bvf8K8SaqsBXcRRjiP9CXOz3KN0ebr6GnTnbg
 kMMFmu5V8FxLKyT4t7CbQc+Deepvy4Up+qhqcLZKiQ+AvtT5kmmorosMGArKmDwC
 E0pgKkQ5kwtMpcKIcOZmYAYDjwHrKIAoRwMHqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786471390; x=
 1786557790; bh=q/4cA+OUv4vxd+wTzVWMBpask7QSetud6QSGUeUsdew=; b=X
 /LZK/y34t63EdlvPcvWMaeYUzaNIPuNO5P9mgASIeagg4a4E5vAWDATgD3xxum/B
 2IUIkltvMxXoeon7y1Hvh7aGM+xrorLWg1p/u9KdZ90V5Pnl4EYIGftx20wk7nRL
 kcKF0yT1VuTJbZXEit96Sn+lUOCpyMav6selOuHA1O84aTo3iKvLkUhLeBggTFdE
 BTG0jDpZPY/okaymAdBMdZw1fcFx4nD7uCiwKkTFhkt3F1iLKiwB8j4vXjx9nmSr
 7E8Wkc6Hq9uAF3gfk5/441jo64SNNdC51M1oUxijtwPiMZ5FWquMLZDYP4/sCEfN
 8woHslXCj38YipgJUU9TQ==
X-ME-Sender: <xms:3GN7ajdD7-E0ov2xgxhhPJeJFx7niDSoMbxBblkLHpJB0lynZY9D8g>
 <xme:3GN7amvr5EsppVlUr_ZjKG0vmncjjZWOYVhQ3aQP4JYK4lsTZHwiNJo9jDFvrcVI_
 7T2-dCdRtIF-VjDucEYXEBSoaJJwzlgUFwSbO_yeDfM9oFlZXni-M0>
X-ME-Received: <xmr:3GN7avJRZGqo8jeW-B3SsGnMRAf8eLizFO6tUHa5twBU2bE7ujkmT-zcLPLjamd-4c6QxQ>
X-ME-Proxy-Cause: dmFkZTF2OoQAX4BzEYzCjUnT2RpKPFthUnXxKEzvpt4adCjVM/pJSLbNPovdJU/Q008usi
 Xz04QYLtUM3sOi5xDxDcE0pzDk8upUOg17/NLOuPo8cNTGeiwzVShPQp+Vi1gxqyBJRo4I
 avV7RJ7QWE0PqmRhxcAv7vjR3JlcY1waAjXGwDf8QPXuWzpLavInoAb/a1mKHSTRFC7pdp
 kGTksPyR79VRlEFgrADbCe/Nw62gLSF66NwjdSx7+LqigVJ9qmgtc4jPrT2DRkbBj4JOGR
 JzomfzPK/1owE9pE018qTODZ9hwneZfHQSfLyktoWB9wbBF6ryiqW4Ef/PYa1JVRzPeONw
 K9HRK5No9g2UV9u/nYvj6wJppfwY4iv1KweV7wY8cAkJxHqbu10+4m/+S6JumrzXa+YM84
 O7M8JYEEvBdgPavf2a847s4llYE/Ucu5ougrxQPvegAmBG7kiOpO5Uo3n0J7Qd2Jxw/TV3
 IAqmyH/L0f3muHBXTRpgBe1dU6lahggnp0oZvymT9p38Y/Os+fk3snRGibweeP07vl3Gsh
 vTp6XRieyAeEw151c+uQUS3IMML+zxAZyTxmPivkcE+mO6fXOt2imUM5V5W4XZkh6q34f1
 l5KzjoQksk8+Kb0dZu1aP1odIt2eOt5mD/eq1pIalwQHXapEy5Re2hVt1qTw
X-ME-Proxy: <xmx:3GN7aqad5ZxVVjLk1a3UTf2VBK9gAmClOGxBdEyWn0_a4wYAp5tMpQ>
 <xmx:3GN7aimL75IyO8KyBQ4MCtIOeOobl-e0GizMmr9rnYSkKvqBly8xJA>
 <xmx:3GN7aoWeO76A6q_ZsWXqHXGdvAaqrj75vJzzqn3pWl3eKCp_UiJBig>
 <xmx:3GN7asI7iKb73Ev1zLj1MAdI0KGP1vq_MkFO_ejGju3lBT6l38N-OQ>
 <xmx:3mN7arMXu-AmCzE-slMDeZCH-aYVGR-g-vgXxTAc0_mRktY6L6od8yP0>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 14:03:08 -0400 (EDT)
Message-ID: <ad5ca737b2a4bf6de158f18d876dec740e470f8f.camel@alistair23.me>
Subject: Re: [PATCH v2 0/3] riscv: Add K230 DDR controller and PHY models
From: Alistair <alistair@alistair23.me>
To: Junze Cao <caojunze424@gmail.com>, qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>, Weiwei
 Li <liwei1518@gmail.com>, Daniel Henrique Barboza	
 <daniel.barboza@oss.qualcomm.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>,  Fabiano Rosas <farosas@suse.de>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Aug 2026 04:03:07 +1000
In-Reply-To: <20260807-k230-ddr-v2-v2-0-c531308ae819@gmail.com>
References: <20260807-k230-ddr-v2-v2-0-c531308ae819@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.156;
 envelope-from=alistair@alistair23.me; helo=fhigh-a5-smtp.messagingengine.com
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

On Fri, 2026-08-07 at 18:21 +0800, Junze Cao wrote:
> The K230 SDK U-Boot SPL initializes DRAM by programming the DDRC CFG
> and DDR PHY MMIO regions. The k230 machine currently exposes the DDR
> configuration region as unimplemented and does not provide the PHY,
> so
> the SPL cannot complete the training and DFI handshakes.
>=20
> Add minimal models for the register behavior exercised by the SDK
> SPL.
> The controller model provides reset values, register access policy,
> DFI
> and software-update handshakes, and the Init-to-Normal transition.
> The
> PHY model provides CSR ownership, the training mailbox, and DFI
> completion. Wire both devices into the k230 machine and document the
> resulting SPL support.
>=20
> These device models allow firmware to complete the DDR initialization
> sequence.
>=20
> Changes in v2:
>=20
> * Add LOG_UNIMP messages for unimplemented DDR PHY register accesses,
> =C2=A0 including reads returning zero and ignored writes.
>=20
> Testing performed:
>=20
> * scripts/checkpatch.pl --branch upstream/master..HEAD
> * meson test -C build --print-errorlogs
> =C2=A0 qemu:qtest-riscv64/k230-ddr-test (6 subtests passed)
> * Booted the K230 SDK U-Boot SPL through DDR initialization to its
> SPI
> =C2=A0 boot path
>=20
> ---
> Junze Cao (3):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw/misc: Add K230 DDR controller and PHY m=
odels
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw/riscv: Connect K230 DDR controller and =
PHY models
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tests/qtest: Add K230 DDR controller tests

Thanks!

Applied to riscv-to-apply.next

Alistair

>=20
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
> =C2=A0docs/system/riscv/k230.rst=C2=A0 |=C2=A0=C2=A0 4 +
> =C2=A0hw/misc/k230_ddr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 556
> ++++++++++++++++++++++++++++++++++++++++++++
> =C2=A0hw/misc/meson.build=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 1 +
> =C2=A0hw/riscv/k230.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 19 +-
> =C2=A0include/hw/misc/k230_ddr.h=C2=A0 |=C2=A0 59 +++++
> =C2=A0include/hw/riscv/k230.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
> =C2=A0tests/qtest/k230-ddr-test.c | 226 ++++++++++++++++++
> =C2=A0tests/qtest/meson.build=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
> =C2=A09 files changed, 871 insertions(+), 4 deletions(-)
> ---
> base-commit: 3e3ccab106f879b1512f8e0d51a827dd4de30e22
> change-id: 20260807-k230-ddr-v2-f8037b6ac237
>=20
> Best regards,
> --=C2=A0=20
> Junze Cao <caojunze424@gmail.com>
>=20

