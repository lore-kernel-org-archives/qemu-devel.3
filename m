Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91795C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 19:12:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtrtW-0001aS-Ew; Tue, 11 Aug 2026 15:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtrtV-0001aA-8S; Tue, 11 Aug 2026 15:12:13 -0400
Received: from fhigh-a5-smtp.messagingengine.com ([103.168.172.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtrtT-0001P0-I4; Tue, 11 Aug 2026 15:12:13 -0400
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 474B71400141;
 Tue, 11 Aug 2026 15:12:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Tue, 11 Aug 2026 15:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786475530; x=1786561930; bh=T5AyB0ah59LGJZdySV6J4dpGz0cOZmaR
 LEGnRgE3Gxk=; b=MyOYaAOrBbr7I7MVVYq3YT/feY3fSwvek4WXdWnc0/alLeFX
 VsqCSn+RWCd4zHtEa+TsilBJ1mPGhd1qtEtKx/aXMTjqodf9/3uRIUpznyKdJIsi
 2FYen+WBJefhj3128K3I5c1SIk1ggTdPIkaZ2JXQxIG0AkLLlCVvGV37w0MvK4lH
 TLdY0xP6QkirJ7UHlbecobzDK/NNbdM9+o0g6sjsEKfQnSgVYguj8IQk1iPXySpE
 x/UWZfa9oLmBM+wEikoqIqgq7+uufBqGNkX0FA08AqMnNFE4EmTQAtAGic7DaIF+
 JL2+wgBWwpTwVQzciWJhQQsCXX5l7PDt6cWlQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786475530; x=
 1786561930; bh=T5AyB0ah59LGJZdySV6J4dpGz0cOZmaRLEGnRgE3Gxk=; b=A
 x4BDiRuvblEhFwC9oMFfIGq6U18HzL20ey0HurNPdI7i1vxO7KJWf+sr2AtR8PVQ
 vnnSvmfVk6wV62QkDwzEzCXYCCjPznFEpCp76fIWBiLsbnc4HcGQAjPYmPcFtR0o
 ac17yVaLJpnhPDls1c2IR7rzMgtiZsyv1O9m09WvwosPH9PxMm4VwqZqXcugTH5R
 PricdzYcn3I1n4OqMVjBi9fg7A/b19ss8EtZET4u647H98BGUrr6TyHi4RzDHmsT
 7y29+9hyb2M0sR+CNO08pEtXUP01y3l+7ePncbfDUuov4945Gd+MgCRt3/O1uGEU
 b+F3NISqiQiUkG43w1iwg==
X-ME-Sender: <xms:CHR7ahF_5cmexVme2zYcHc0K7v2gtPpAz3L1Z5miy1jnfW0aXjdwIw>
 <xme:CHR7as3_-W3tGvHiGJzIC4_ZbpYTEMHuG-fG74qQGqlsuqrJ6JrrNPGHIVugILYRU
 lxHsgWxSXIk4fxNhrFVJJiPzubm5yrTWcpWyaTF1-d9XSxVIAfJalk>
X-ME-Received: <xmr:CHR7ahIjKp-1ee_KmdLUok_j0D6RN9MNk9ZCIkmD-J1u5u22Yji3kg4rJfEzvryzAxb8HA>
X-ME-Proxy-Cause: dmFkZTFxT514kitKIdGOhXPEiLUJyDOYCZHOcJCRAOs4iYG0U2+eCRfL4rAqpKWp8tzCCR
 q4/lWng/GUxRzf9jB8M/gjcbSNH7eBBgrAogeCEgch6IlePQaIL0umnHG/4whnLqGUmuy5
 1XdTh9EINXUFcqBkSrcRd4KWJy/1VXgYkKm79H+kfjltKRZGpszgKqB3IkB6CgkqF8tCy2
 jsy1lIEvkV1EEPh9/pUxL/otB0LPqMrUwAmiwxGR2Ra692PFMY1lFEqTjfz5RAU50SIG8D
 xmiQGo+9OVLBswG+iD05AtJTyIG+c7MwK1B/aqlQzng5u8kS9bH1KGD3FbmzwO26hvsVRw
 Z6366wPlbzggFQCN3X45CYElNf1Vlib0mxY05nQMxvEb0OVm5KH6VWOVJJdIoiUGlVgf/S
 gWPWCp/7O4C2pYXn1ThdjQLYHNp9VG2QtFHnXwOv+Audx1AObL3Ja1IdCnV8xekts3LRE2
 5mFup66EdGobShrC+DljQDvO1YCa07ADu3pGZxE9WdI7LPdzTrN6+T59GMonHo1sdWdtmi
 e1QaQr53+V9sVPpliFAtVZxmx8e5UMzy4u+z23MuzrgXG495AW0G0kfAEX6SpzIJK/WegO
 p79F75RnrSkL/R1xR2DKptMJjWbUkFsIbGZPAV+gXEPhsUihC8d3HMZnvNVw
X-ME-Proxy: <xmx:CHR7ap1mtZ7fsiNK7S8H56tA4pjF6-UUd-becIp38EsViE3STmr48A>
 <xmx:CHR7atmhF8aqF6UlhmUWk1KD3dVF8vLBC_LrfVyqNC3Df6hqa_pbqA>
 <xmx:CHR7asjSSpMZdS08nspuWDTHk16cDgGL-ezXdBecNr20nAgLJ18uQg>
 <xmx:CHR7asS8Enihx_FpQd53OepPzLiXmVohCmTEaZrZ28_6AiK9EHfvEg>
 <xmx:CnR7avhSoGd271d7eZKBUXgAZcfC6TSHiHZwVW0GpxRP8ah0ziLNJ8nD>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 15:12:08 -0400 (EDT)
Message-ID: <972c0983cab48890a0b089a5ccc9ba0c2b04bc32.camel@alistair23.me>
Subject: Re: [PATCH v3 0/3] riscv: Add K230 DW 8250-compatible UART
From: Alistair <alistair@alistair23.me>
To: WX Chen <wxchen0913@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?ISO-8859-1?Q?Marc-Andr=E9?=
 Lureau	 <marcandre.lureau@redhat.com>, Chao Liu
 <chao.liu.zevorn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Alistair
 Francis <alistair.francis@wdc.com>, Weiwei Li	 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,  Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, Fabiano Rosas
 <farosas@suse.de>,  Laurent Vivier <lvivier@redhat.com>
Date: Wed, 12 Aug 2026 05:12:07 +1000
In-Reply-To: <20260808-feat-k230-uart-v3-v3-0-d73b31f0034b@gmail.com>
References: <20260808-feat-k230-uart-v3-v3-0-d73b31f0034b@gmail.com>
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

On Sat, 2026-08-08 at 10:32 +0800, WX Chen wrote:
> This series adds a QEMU model for the K230 SoC DesignWare 8250-
> compatible
> UART controller, wires it into the K230 SoC, and adds qtest coverage.
>=20
> The implementation supports the registers and features required by
> the
> Linux 8250_dw driver, providing an interactive shell over the serial
> port.
>=20
> Signed-off-by: WX Chen <wxchen0913@gmail.com>
> ---
> Changes in v3:
> - Removed all hardwired preprocessor #if conditionals from the logic
> - Added a helper for the receiver line status interrupt check
> - Encapsulated CPR and UCV register values in header macros
> - Replaced g_usleep() with qtest_clock_step() in the qtest
> - Link to v2:
> https://lore.kernel.org/qemu-devel/20260725-feat-k230-uart-v2-v2-0-d5fe82=
c47c28@gmail.com
>=20
> ---
> WX Chen (3):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw/char: add K230 DW 8250-compatible UART
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw/riscv: k230: connect DW 8250 UART
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tests/qtest: add K230 UART test

Thanks!

Applied to riscv-to-apply.next

Alistair

>=20
> =C2=A0hw/char/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
> =C2=A0hw/char/k230_uart.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 816
> +++++++++++++++++++++++++++++++++++++++++++
> =C2=A0hw/char/meson.build=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0hw/riscv/k230.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 33 +-
> =C2=A0include/hw/char/k230_uart.h=C2=A0 | 198 +++++++++++
> =C2=A0include/hw/riscv/k230.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
 6 +-
> =C2=A0tests/qtest/k230-uart-test.c | 514 +++++++++++++++++++++++++++
> =C2=A0tests/qtest/meson.build=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
 2 +-
> =C2=A08 files changed, 1559 insertions(+), 14 deletions(-)
> ---
> base-commit: 30e8a06b64aa58a3990ba39cb5d09531e7d265e0
> change-id: 20260808-feat-k230-uart-v3-0ff3651d70ef
>=20
> Best regards,

