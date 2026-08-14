Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41793C5CFCF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuuFV-0005OE-0S; Fri, 14 Aug 2026 11:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuuFT-0005Nj-3G; Fri, 14 Aug 2026 11:55:11 -0400
Received: from fhigh-a3-smtp.messagingengine.com ([103.168.172.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuuFQ-0006wo-TW; Fri, 14 Aug 2026 11:55:10 -0400
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfhigh.phl.internal (Postfix) with ESMTP id CD4B514000DF;
 Fri, 14 Aug 2026 11:55:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Fri, 14 Aug 2026 11:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786722907; x=1786809307; bh=LYMCRHCR/TVtwqk8ASWWOfc/lIIYbTXY
 u13BL96nu5U=; b=XOqJKZ5gEFm5AdNu26iCX2rHNSZ8nE6Tfs2SS6lPqCcJdZAp
 6WFvcC9AtCs8UexZV3CPwj9y/OtSL6ASMUjypM2xc1b4/rfULgKrxZ7Qabny4fb6
 CXvKMppKhNflgpFqZugIHvcdX0hqfTSaOrCSUmQkThObJ8ofp7uQ99+9L49YZF2X
 z9x74xpYdqFQkJXDu11O/Vv9A15/WYinx/bpIV73Af7ZglAaOYZOIQXCuAf8iBhx
 Dz4kiyK4ksRycuDi69WNJxfmpEAzYiuEkyEtBlpD5bV9Gcl5QfAZfXzzeR47QxTD
 WG6kOEdvlm2idBaClW84CPzVmUUltDBRAnaPwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786722907; x=
 1786809307; bh=LYMCRHCR/TVtwqk8ASWWOfc/lIIYbTXYu13BL96nu5U=; b=T
 kCjl9X624H/Ljzg7uG/4NcWsqN3yJbRFHwNuNhnduqkh95KG/DD/FOFravxa+xzL
 P8F8kYdahXFeqSB+qWIE5/zqEv8cFlPT3xcx5BXtkMZkSwxGFz2HuYRIdHpAZBIJ
 NO0cjPuZo95BrXEcdg2djiiAZqBHxgwYWfwRAglRFpvgTYjOdemZkmYRBWSqWiqa
 Oiw7s5pJsnVXqxaxmIpNHQDGrgEyTe30uLvzsqCKw2Tg6iVM32GRsmqo1Ue3ou/v
 wq+PdUmgd9HgImpyK46D37IErNPmozDWwmpns1J8Qysm8kT6/0oH+OJkqlzX11Mc
 anCC274xt0hduFBepUrgw==
X-ME-Sender: <xms:Wzp_ajMiiDrBSArYcv0Vl_7h6rnWrgLo2Ty1PGa1gK5AMPzcs0AjlA>
 <xme:Wzp_auYXVg2VGvG8qP2Sw5cGo0TW6U1LAXIum87Z11s1E_6TF9bI1HCh4T6xfUhzY
 yRO_19owoAltpAdinjD84c0oTb57McfEE9kTCWS1t_rSYSYS4sRNSEU>
X-ME-Received: <xmr:Wzp_ai_NL0y2KYs6wa0TLsCBO53KPLhjPcOEnnEhwgY7sIfFvWs8WXk81zuUR59CvedYJA>
X-ME-Proxy-Cause: dmFkZTE8sq/refdYtfPKew1n+tZHLN8XYZ1MajCz9XqNqCIK1nQur3TaXTR4ogzD9kknic
 K8jBVJ72VAgvzUg/mMKy0ir5j0956p8ykrhVcVY0mF8MYx4yi/zmHsQUMUQv4i64Wj5jQQ
 5o8BWo4UyhxCKl0mV3+EIhEDJvcaxjkWqTzFnPeCpu89cKg8yKazLUBMd1eS8FebETmNiX
 KXNP3NSKA2B7y52MtIETBtey9ym2oJnnDEd0kxDyOOdKRgizXxi3ZxsSpzBE9HtRaYFtXs
 nJM6wDYJKv6CELyFU/lNW6rz1FputVgEoExOlcJ0BbjKN5gcla5e/EDZYFFaJoYp/HDqAz
 M/U84b42cpTzcd4n8OOFI+9s3uvI3yvV24le0EtzeOL59mAermZKW69Y0lqkJ7AQohaHjO
 wPB73MNeMPzY4ekHMSuO1029Y4QfYvRindntG+kEYCkwaX0rI/UHAvNu2+X1EaOvGvA5Zz
 YnffRBWTU1kROXGjRu1pSaTa9jD22k+GEMSdVej+BDmRRRBgt5jWMfCZsAUTobhw9FsIjc
 gMCenkwGBGaKdfkLzwmSryogq1Wrb1vjhYy1ReWo0aHKJmfGZiulr9bL12VFYaQoaSYGXC
 tazbKW8HZfD2IYjxAn1FpwQ/9ctIys36go/HUJpfdY0CGRG1JGJ5EkO9q3Zg
X-ME-Proxy: <xmx:Wzp_avR90sP4PWTDMPvk0Ryack10MBsUdoO43aAE305RTXmTlV5LYA>
 <xmx:Wzp_ascRX6b-acNky8Bvqb5UN1ycZ2v8WYshCDOEJ6m2TGKb_ZFkeQ>
 <xmx:Wzp_ahRdXGaXlOV1nu2AxSN07JBa3s5RobKww3z8pFvswnO9rg3xew>
 <xmx:Wzp_aoJxgRPIrlmDNzTPuWHaeO9Pm6XlR1Cmo3FcSJuqu-re-39Hiw>
 <xmx:Wzp_aokyskVUbyhO8q7SS59spd45zY6zZbwZLwbwX0vEK2xasDub-0H3>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 11:55:06 -0400 (EDT)
Message-ID: <07416f0310021dc234fbe187dcd57fca3e853f9f.camel@alistair23.me>
Subject: Re: [PATCH] target/riscv: Restore register dump zero padding
From: Alistair <alistair@alistair23.me>
To: Joel Stanley <joel@jms.id.au>, Alistair Francis
 <alistair.francis@wdc.com>,  Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>,  Chao Liu <chao.liu@processmission.com>,
 Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org, 	qemu-devel@nongnu.org
Date: Sat, 15 Aug 2026 01:55:06 +1000
In-Reply-To: <20260813032421.54438-1-joel@jms.id.au>
References: <20260813032421.54438-1-joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.154;
 envelope-from=alistair@alistair23.me; helo=fhigh-a3-smtp.messagingengine.com
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

On Thu, 2026-08-13 at 12:54 +0930, Joel Stanley wrote:
> The register values lost their leading zeroes when the underlying
> type
> was changed, resulting in mismatched padding and harder to read
> output.
>=20
> Print with a runtime field width based on MXL, so values are 16 hex
> digits on rv64 and 8 on rv32, matching the csr and fp dump. This
> avoids
> adding target_ulong back into the dump.
>=20
> Fixes: c4e6bc63853c ("target/riscv: Fix size of gpr and gprh")
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> before:
>=20
> =C2=A0mvendorid=C2=A0=C2=A0=C2=A0=C2=A0 0000000000000000
> =C2=A0marchid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000000000000002a
> =C2=A0mimpid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0000000000000000
> =C2=A0mhartid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0000000000000000
> =C2=A0mconfigptr=C2=A0=C2=A0=C2=A0 0000000000000000
> =C2=A0x0/zero=C2=A0 0 x1/ra=C2=A0=C2=A0=C2=A0 ffffffff803f10f6 x2/sp=C2=
=A0=C2=A0=C2=A0 ff2000000000bc70
> x3/gp=C2=A0=C2=A0=C2=A0 ffffffff805c94c0
> =C2=A0x4/tp=C2=A0=C2=A0=C2=A0 ff60000000c78000 x5/t0=C2=A0=C2=A0=C2=A0 ff=
ffffff803f132c x6/t1=C2=A0=C2=A0=C2=A0 0
> x7/t2=C2=A0=C2=A0=C2=A0 20646e65205b2d2d
> =C2=A0x8/s0=C2=A0=C2=A0=C2=A0 ff2000000000bc80 x9/s1=C2=A0=C2=A0=C2=A0 70=
8 x10/a0=C2=A0=C2=A0 270f x11/a1=C2=A0=C2=A0 8
> =C2=A0x12/a2=C2=A0=C2=A0 0 x13/a3=C2=A0=C2=A0 120 x14/a4=C2=A0=C2=A0 1499=
2a1 x15/a5=C2=A0=C2=A0 ffffffffffffffff
> =C2=A0x16/a6=C2=A0=C2=A0 fffff079 x17/a7=C2=A0=C2=A0 79 x18/s2=C2=A0=C2=
=A0 0 x19/s3=C2=A0=C2=A0 7d0
> =C2=A0x20/s4=C2=A0=C2=A0 ffffffff805ca228 x21/s5=C2=A0=C2=A0 31 x22/s6=C2=
=A0=C2=A0 ff60000000e15000
> x23/s7=C2=A0=C2=A0 ffffffff804228c8
> =C2=A0x24/s8=C2=A0=C2=A0 0 x25/s9=C2=A0=C2=A0 ffffffff804e3e90 x26/s10=C2=
=A0 0 x27/s11=C2=A0 0
> =C2=A0x28/t3=C2=A0=C2=A0 ff60000000c60f00 x29/t4=C2=A0=C2=A0 ff60000000c6=
0f00 x30/t5=C2=A0=C2=A0
> ff60000000c60000 x31/t6=C2=A0=C2=A0 ff2000000000bc28
> =C2=A0fflags=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0000000000000000
> =C2=A0frm=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000=
0000000000000
> =C2=A0fcsr=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000=
00000000
> =C2=A0f0/ft0=C2=A0=C2=A0 ffffffff00000000 f1/ft1=C2=A0=C2=A0 ffffffff0000=
0000 f2/ft2=C2=A0=C2=A0
> ffffffff00000000 f3/ft3=C2=A0=C2=A0 ffffffff00000000
> =C2=A0f4/ft4=C2=A0=C2=A0 ffffffff00000000 f5/ft5=C2=A0=C2=A0 ffffffff0000=
0000 f6/ft6=C2=A0=C2=A0
> ffffffff00000000 f7/ft7=C2=A0=C2=A0 ffffffff00000000
> =C2=A0f8/fs0=C2=A0=C2=A0 ffffffff00000000 f9/fs1=C2=A0=C2=A0 ffffffff0000=
0000 f10/fa0=C2=A0
> ffffffff00000000 f11/fa1=C2=A0 ffffffff00000000
> =C2=A0f12/fa2=C2=A0 ffffffff00000000 f13/fa3=C2=A0 ffffffff00000000 f14/f=
a4=C2=A0
> ffffffff00000000 f15/fa5=C2=A0 ffffffff00000000
> =C2=A0f16/fa6=C2=A0 ffffffff00000000 f17/fa7=C2=A0 ffffffff00000000 f18/f=
s2=C2=A0
> ffffffff00000000 f19/fs3=C2=A0 ffffffff00000000
> =C2=A0f20/fs4=C2=A0 ffffffff00000000 f21/fs5=C2=A0 ffffffff00000000 f22/f=
s6=C2=A0
> ffffffff00000000 f23/fs7=C2=A0 ffffffff00000000
> =C2=A0f24/fs8=C2=A0 ffffffff00000000 f25/fs9=C2=A0 ffffffff00000000 f26/f=
s10
> ffffffff00000000 f27/fs11 ffffffff00000000
> =C2=A0f28/ft8=C2=A0 ffffffff00000000 f29/ft9=C2=A0 ffffffff00000000 f30/f=
t10
> ffffffff00000000 f31/ft11 ffffffff00000000
>=20
> after:
>=20
> =C2=A0mvendorid=C2=A0=C2=A0=C2=A0=C2=A0 0000000000000000
> =C2=A0marchid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000000000000002a
> =C2=A0mimpid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0000000000000000
> =C2=A0mhartid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0000000000000000
> =C2=A0mconfigptr=C2=A0=C2=A0=C2=A0 0000000000000000
> =C2=A0x0/zero=C2=A0 0000000000000000 x1/ra=C2=A0=C2=A0=C2=A0 ffffffff803f=
10f6 x2/sp=C2=A0=C2=A0=C2=A0
> ff2000000000bc70 x3/gp=C2=A0=C2=A0=C2=A0 ffffffff805c94c0
> =C2=A0x4/tp=C2=A0=C2=A0=C2=A0 ff60000000c78000 x5/t0=C2=A0=C2=A0=C2=A0 ff=
ffffff803f132c x6/t1=C2=A0=C2=A0=C2=A0
> 0000000000000000 x7/t2=C2=A0=C2=A0=C2=A0 20646e65205b2d2d
> =C2=A0x8/s0=C2=A0=C2=A0=C2=A0 ff2000000000bc80 x9/s1=C2=A0=C2=A0=C2=A0 00=
00000000000e10 x10/a0=C2=A0=C2=A0
> 000000000000270f x11/a1=C2=A0=C2=A0 0000000000000008
> =C2=A0x12/a2=C2=A0=C2=A0 0000000000000000 x13/a3=C2=A0=C2=A0 000000000000=
0120 x14/a4=C2=A0=C2=A0
> 0000000002575fd6 x15/a5=C2=A0=C2=A0 ffffffffffffffff
> =C2=A0x16/a6=C2=A0=C2=A0 00000000fffff079 x17/a7=C2=A0=C2=A0 000000000000=
0079 x18/s2=C2=A0=C2=A0
> 0000000000000001 x19/s3=C2=A0=C2=A0 0000000000000ed8
> =C2=A0x20/s4=C2=A0=C2=A0 ffffffff805ca228 x21/s5=C2=A0=C2=A0 000000000000=
0060 x22/s6=C2=A0=C2=A0
> ff60000000e15000 x23/s7=C2=A0=C2=A0 ffffffff804228c8
> =C2=A0x24/s8=C2=A0=C2=A0 0000000000000000 x25/s9=C2=A0=C2=A0 ffffffff804e=
3e90 x26/s10=C2=A0
> 0000000000000000 x27/s11=C2=A0 0000000000000000
> =C2=A0x28/t3=C2=A0=C2=A0 ff60000000c60f00 x29/t4=C2=A0=C2=A0 ff60000000c6=
0f00 x30/t5=C2=A0=C2=A0
> ff60000000c60000 x31/t6=C2=A0=C2=A0 ff2000000000bc28
> =C2=A0fflags=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0000000000000000
> =C2=A0frm=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000=
0000000000000
> =C2=A0fcsr=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000=
00000000
> =C2=A0f0/ft0=C2=A0=C2=A0 ffffffff00000000 f1/ft1=C2=A0=C2=A0 ffffffff0000=
0000 f2/ft2=C2=A0=C2=A0
> ffffffff00000000 f3/ft3=C2=A0=C2=A0 ffffffff00000000
> =C2=A0f4/ft4=C2=A0=C2=A0 ffffffff00000000 f5/ft5=C2=A0=C2=A0 ffffffff0000=
0000 f6/ft6=C2=A0=C2=A0
> ffffffff00000000 f7/ft7=C2=A0=C2=A0 ffffffff00000000
> =C2=A0f8/fs0=C2=A0=C2=A0 ffffffff00000000 f9/fs1=C2=A0=C2=A0 ffffffff0000=
0000 f10/fa0=C2=A0
> ffffffff00000000 f11/fa1=C2=A0 ffffffff00000000
> =C2=A0f12/fa2=C2=A0 ffffffff00000000 f13/fa3=C2=A0 ffffffff00000000 f14/f=
a4=C2=A0
> ffffffff00000000 f15/fa5=C2=A0 ffffffff00000000
> =C2=A0f16/fa6=C2=A0 ffffffff00000000 f17/fa7=C2=A0 ffffffff00000000 f18/f=
s2=C2=A0
> ffffffff00000000 f19/fs3=C2=A0 ffffffff00000000
> =C2=A0f20/fs4=C2=A0 ffffffff00000000 f21/fs5=C2=A0 ffffffff00000000 f22/f=
s6=C2=A0
> ffffffff00000000 f23/fs7=C2=A0 ffffffff00000000
> =C2=A0f24/fs8=C2=A0 ffffffff00000000 f25/fs9=C2=A0 ffffffff00000000 f26/f=
s10
> ffffffff00000000 f27/fs11 ffffffff00000000
> =C2=A0f28/ft8=C2=A0 ffffffff00000000 f29/ft9=C2=A0 ffffffff00000000 f30/f=
t10
> ffffffff00000000 f31/ft11 ffffffff00000000
>=20
> I also wrote a patch to align the first column of register values,
> but
> that creates the dilemma between aligning the numbers vs keeping the
> spacing between the registers and their value within a row. Aside
> from
> avoiding bikeshedding, it wastes more columns for an already wide
> output, so opted not to 'fix' that.
>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> =C2=A0target/riscv/cpu.c | 9 ++++++---
> =C2=A01 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 19b93f9c9794..c50dd5ee8771 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -650,6 +650,9 @@ static void riscv_cpu_dump_state(CPUState *cs,
> FILE *f, int flags)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 RISCVCPU *cpu =3D RISCV_CPU(cs);
> =C2=A0=C2=A0=C2=A0=C2=A0 CPURISCVState *env =3D &cpu->env;
> +=C2=A0=C2=A0=C2=A0 bool rv32 =3D riscv_cpu_is_32bit(cpu);
> +=C2=A0=C2=A0=C2=A0 int width =3D rv32 ? 8 : 16;
> +=C2=A0=C2=A0=C2=A0 uint64_t mask =3D rv32 ? UINT32_MAX : UINT64_MAX;
> =C2=A0=C2=A0=C2=A0=C2=A0 int i, j;
> =C2=A0=C2=A0=C2=A0=C2=A0 uint8_t *p;
> =C2=A0
> @@ -664,7 +667,7 @@ static void riscv_cpu_dump_state(CPUState *cs,
> FILE *f, int flags)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_fprintf(f, " %-13s =
%d\n", "elp", env->elp);
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0#endif
> -=C2=A0=C2=A0=C2=A0 qemu_fprintf(f, " %-13s %" PRIx64 "\n", "pc", env->pc=
);
> +=C2=A0=C2=A0=C2=A0 qemu_fprintf(f, " %-13s %0*" PRIx64 "\n", "pc", width=
, env->pc &
> mask);
> =C2=A0#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
> =C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < ARRAY_SIZE(csr_ops); i++) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int csrno =3D i;
> @@ -691,8 +694,8 @@ static void riscv_cpu_dump_state(CPUState *cs,
> FILE *f, int flags)
> =C2=A0#endif
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < 32; i++) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_fprintf(f, " %-8s %" PRI=
x64,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 riscv_int_regnames[i], env=
->gpr[i]);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_fprintf(f, " %-8s %0*" P=
RIx64,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 riscv_int_regnames[i], wid=
th, env->gpr[i] &
> mask);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((i & 3) =3D=3D 3) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
qemu_fprintf(f, "\n");
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }

