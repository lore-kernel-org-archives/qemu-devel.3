Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362D1C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 23:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj3sq-0008JJ-EN; Sun, 12 Jul 2026 19:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wj3sp-0008J7-3V; Sun, 12 Jul 2026 19:46:51 -0400
Received: from fout-b2-smtp.messagingengine.com ([202.12.124.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wj3sn-000627-4Z; Sun, 12 Jul 2026 19:46:50 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 3AFCB1D00069;
 Sun, 12 Jul 2026 19:46:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Sun, 12 Jul 2026 19:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1783900005; x=1783986405; bh=SRAtrCakcqo7/XMmGEUMB0yu0A7/gzIJ
 5q/0d3TSsxM=; b=WbkbTRjjjjBwK2MQW2NlX/gJM28P87WuPjv7zcoyIolTBPoh
 AVw29NXIL0IzukaeGOPLzQZnjquEaR94EK3wVbAFF2vrrjvmB8OgFqWaru0WL6pc
 YYG2KO25zygXQnVa0VGvi8GdqElVHtZxYRDzeeuYkKMHiQEEvETeb2KP06lj0wD+
 X9+xLEKuubc/lbGjJCLrpW/YfrGg2rSZ7s8icBSzkpTGFMv1GlJWfqkzH7RMryBz
 ngjiYMgwXnsHPFcNXXplXIJZW9Mov9BxHQnyQNLI5ArScFxt6P84db22P5/qaIKC
 MVTMb/I2BPnI0mZXvVdH8n4zzdAcH7A5yXzZBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783900005; x=
 1783986405; bh=SRAtrCakcqo7/XMmGEUMB0yu0A7/gzIJ5q/0d3TSsxM=; b=W
 LONF7JLgkDOzU8wDQN3Jbwmqw5DYeWh+2e1HInISkGSWfenJhfOfyt0SycWUfes1
 EHGBAPopvVfQEIMCNlQCJ+le6mxkEOFEyYBfnOrBEQTr18Lx1WI9mDFH5aqfbYMs
 jF6kwbmHtd0rfRZF/9OkWrCg9dftR/vvoMJlGF5PnXkumD8Mv79W2fFyiT/DGo+M
 ZzakPZW995vmn5voUSTDi3RvUuw7ON2FEN1CbIjTK1GrS+FO8FkYeGvgQhFJs7oW
 BiolRJmMfI4ICtfJ6dRHrD6nFyW5XdFWowo4Fha/0NhgtK4T08MkKqP1rYhiDtLj
 LwYae+fdKjI49z6SYe3xw==
X-ME-Sender: <xms:ZCdUatk2Sncu00QWLpAElf-fQagbHLkeS9FeTktBH-NoO4lDQYAc4g>
 <xme:ZCdUak1OpBYq_-Dbrkh9mT54ugmEd8eH1PPspunBsghiiv-6afmUPlSK2WTxzoB65
 8JCaS2g2pAiACNu6izrLAAQOeILro0Wao9D6diSDI5C3BfgGwX9ZKrg>
X-ME-Received: <xmr:ZCdUal3VDbpQ8ClH5lyXDi-4lL4ZP3ZelDyuiTccThbep-LEe4NOo35lY3dVvt9EdgCsKUovlBOitS-FsQTZtlCYjMU>
X-ME-Proxy-Cause: dmFkZTEzPjkHUBPedLGHdEtadZHHynQQMyvytMPKexs1lJU4KUcsozmsCTdm6N1t74pq0i
 4ZKZSZr6RalImGVmo2KQE+imAIp4dP5HlhnDaAHbajN7teG942vr7TYsyC7qtZxcQ1FGc8
 USOAR1Or/NaQy942BnQuTxxwp4i/n/uRNFw059patH/7lYuiYd7evA7zVeGox2jTTpmQLq
 Ksy6dRe7GrYwRSF2d+Tuw8mA/jVj/tQfMBf7JFOHSLbTmGPKbsIpR9IFT4+VxTjggfZVb+
 cqGpcFU/AL+m8RFQ4rW5Y3HsqlijX6MzKcSZRx6JbknQHBum2AWUgMXQTjlWwn3O5B/BBS
 NgmxclshVmDS6HhXnGfQrcjmoUdJXjugLqP7B5y/LnxsZ3L7B99C90FqlWSlgrMXn4lMG4
 4TzcEu/tuRj/BbmYNfgBygNj/cEICbZ5zXb19Hu7XdgZtYsmOxrPJewleDQX/k963ia5jn
 sf3tzNJ7Yiid3w5c3j5K5xuP9qIW5otv+gIx9FMHxnAqK94/7d28e1rsHwOps0HWN8fveK
 H9rKne26OAIqge/QUR1q7/Jo2OeF07mJ7YYQX6ZucXe8shZyLcrHNc72JTuKlgxML6UK0c
 9sx1QU9TY/nLVzX69ULkEntSZGDXTpNZc/f9isitNy5dUvP+yXcn4CUckUPQ
X-ME-Proxy: <xmx:ZCdUaupGBTBPmmfX8tUKuC3wLvyXdGioFNtfG8ytFh0Dy1M5MiRP4A>
 <xmx:ZCdUaphCywKUuVBjRYVXLmV9PWNjAC3R7WCrigb9qCxc6L_WpXERuQ>
 <xmx:ZCdUai-gDBDb9ryTKPkyxrcX2FM-_aHjosgh7zq0_vElIBxidwmsbA>
 <xmx:ZCdUatWdHhwIDa4zesxAMg7tMgdFHVOcHeMHvIGXX2PZJA2xzgcD3Q>
 <xmx:ZSdUaiLhDJBQvERm-UpIyettg9MlSOR_d8lLclb-Z3TU4kB3W-zq0E3W>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Jul 2026 19:46:42 -0400 (EDT)
Message-ID: <14e03e0ad01262333268b51efc512ae8d97d95f2.camel@alistair23.me>
Subject: Re: [PATCH 1/2] MAINTAINERS: Mark "Microchip PolarFire SoC Icicle
 Kit" orphaned
From: Alistair <alistair@alistair23.me>
To: Conor Dooley <conor@kernel.org>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, qemu-riscv@nongnu.org, 
 bin.meng@processmission.com, mzamazal@redhat.com, mst@redhat.com, 
 sgarzare@redhat.com
Date: Mon, 13 Jul 2026 09:46:39 +1000
In-Reply-To: <20260712-divided-cork-204b87d9651a@spud>
References: <20260710114305.2961898-1-armbru@redhat.com>
 <20260710114305.2961898-2-armbru@redhat.com>
 <20260712-divided-cork-204b87d9651a@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.145;
 envelope-from=alistair@alistair23.me; helo=fout-b2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

On Sun, 2026-07-12 at 22:47 +0100, Conor Dooley wrote:
> On Fri, Jul 10, 2026 at 01:43:04PM +0200, Markus Armbruster wrote:
> > Commit 4a16a1a7ad (MAINTAINERS: Remove Bin Meng from RISC-V
> > maintainers, 2025-01-28) removed the only M:, but left S:
> > Supported.
> > This makes no sense.=C2=A0 Downgrade to S: Orphan.
> >=20
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > ---
> > =C2=A0MAINTAINERS | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 576ef6fff5..aa2df9cbe3 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1761,7 +1761,7 @@ F: tests/tcg/riscv64/test-crc32.S
> > =C2=A0
> > =C2=A0Microchip PolarFire SoC Icicle Kit
> > =C2=A0L: qemu-riscv@nongnu.org
> > -S: Supported
> > +S: Orphan
>=20
> This should have been updated in:
> https://lore.kernel.org/qemu-devel/20260513023859.518484-1-alistair.franc=
is@wdc.com/
>=20
> Alistair said he applied that patch, so I'm guessing whatever tree
> you've
> based on doesn't include it yet?

Yeah, I thought I applied it. But somehow it seems to have
disappeared....


I think this patch should be dropped and I'll actually apply:
https://lore.kernel.org/qemu-devel/20260513023859.518484-1-alistair.francis=
@wdc.com/

Then Bin can update this in the future if you want to.

Sorry about the confusion here

Alistair

>=20
> Cheers,
> Conor.
>=20
> > =C2=A0F: docs/system/riscv/microchip-icicle-kit.rst
> > =C2=A0F: hw/riscv/microchip_pfsoc.c
> > =C2=A0F: hw/char/mchp_pfsoc_mmuart.c
> > --=20
> > 2.54.0
> >=20
> >=20

