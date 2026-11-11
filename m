Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0D5606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 03:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=alistair23.me header.i=@alistair23.me header.a=rsa-sha256 header.s=fm3 header.b=eV/3QByR;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=y3QpY6Yl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQz7a-00015C-2z; Tue, 10 Nov 2026 22:35:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xQz7S-00014c-Pd
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 22:35:32 -0500
Received: from fhigh-b1-smtp.messagingengine.com ([202.12.124.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xQz7R-0003f8-8b
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 22:35:30 -0500
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 97AB77A02B8
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 22:35:28 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 10 Nov 2026 22:35:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1794368128; x=1794454528; bh=aFS6jmdpa6vBSGJswLioCpUc7U+G1tMF
 saEB9r32tlc=; b=eV/3QByRcaxAbvfLbAlYOWBQL5rr+s3ZdbESUNoNLMe7V/R0
 fWuoKqDavSy+YsV3l6qbXhd5dFSQui/DqbXC2id8t9Cz0Y96dwVQkU5AXwmQE27p
 k7x35o1i20e4ZSj1OvaPjJni1XzsJluo4MvNNRIEK/BkOZXgs6LZWmFZkYffOSMY
 FvogKLozN01LYDCh7zNdc6bHd+4Czy/J093lKVDWBZpDEFhDgpUa16YPRR+awcWY
 2o0uAg0rwriBQ/iEE2/ZoXW8uwLluTFmdT2QLSUaj1f5dfYyZS8rm2YbJ0OYUclw
 y/HB3xwJXhbB9Gp3E1+DBotBeKXTbjlZ76vvhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794368128; x=
 1794454528; bh=aFS6jmdpa6vBSGJswLioCpUc7U+G1tMFsaEB9r32tlc=; b=y
 3QpY6Yl7tC4ikoSeEMwvZlUT8MQRFjz/Ms5jCwJLkNErZRP9Xp1YIJ4cxEKr/e8L
 gy9bCi0Kllbj3oZYB8Objv1tYtuUUAvdk+pgpYGbpFi9sj3IJzi5ZHPZfENZymN0
 9ZTIpamLxmwoxghQjL46O1UJCKgNguD+coLkt79q8VxaE0dOLxjvgPSmcgcAd8uE
 IdzQQcnhSG964LebWOH2brxRxCJpnIx3cnR5x1pFk69RNZU4NlouNvDBQ2PTNwrG
 1r7uW2FzQGYlNNyqD3xo0kZHVQq1/1sI68Tmz6geqI21itmztEo9y2A4u6RthpjY
 GnJvwmaNVl5f3JsMNwfoA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794368128; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:fwfix+MFG+wQ3OKSofSD/6meqF42SrZiELV5t6IaAwCyFc0
 HS0z3YoPYDhb3YBVWUpGnZHFGG675P4uddlRhO/AOZX1U12/MVeKHwAyEnTYtXrQ
 /218lXD3hEp3/dtkhiJFQJxookbv+3OjVWcsantuEPgBLhcgjCExlz6SsgryeTpE
 H5628GO3sDeLcGrilU6ZBUWk9EiNAG4m//fTfdAuMfNkGeWDx+APZlMEeiBX48tp
 x0IXd5kPoC1wy2iIVVi1DIEUyRum3fqPELV5g+PrFpm1bxcTGc09/Zg+L39yrKh9
 ZAGQtAfO08rmeWmtp4TVOwzsMjr9uRN9VQqHExw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:0SvOW8Wftrg6k8aEUOmFY3qZmd+lg/ei63K7dljDzug=:aFS6jmdpa6vBSGJswLioCpUc7U+G1tMFsaEB9r32tlc=;
X-ME-Sender: <xms:gOLzap08FxI0YZALq7SMlDge3Xl6oROQL_HEnVKm3ePx8eeSqC8aCg>
 <xme:gOLzapA2Ep9XzAzr3o2icTYBlyF_PjI1o__CjxhC2HomDJSyMLC8JHgJJqct0Yo22
 zlRxHaQakjVAy4vbqOymKsp3VLWv6qomfHRsl-IDSIGvAeP1BSS9lpB>
X-ME-Received: <xmr:gOLzalfjv5rPNZ4-cP5uEBqwQSENTxax3vBbtdZykv9O4PNRmeviJ7I81qCnCe7SHlH3EfPbJ9g07KxhXuevXrQi6EE>
X-ME-Proxy-Cause: dmFkZTF17eT1FPjhc4YVjLkE3ud/PTvhKMELVKZSUqmXJcpXG3Q+uM+1+zzI3BvjdlcdlA
 K3IUbWBOH8kZ06YlnxnE/572rL1cb05uUTZB/kTPYejowZAmECJSODp7+gfXeKXdIDGMYQ
 UxHKyPxS6vQrmal2S42mtJpdI+z7ZLqcKC65eB9+/rJo/JQLqenZJk18+k4VDvOr18FQvM
 lyI7EM5syfXvbezjk4KZU8tWA+j8IhBg1WwUt/Bb7JlVwa9TbgwZFvKHN+3WR2bKbdd6uq
 DRnJHsMCmzz98l2F8pZjW82EdgbXFaHx73SMosw2Y3uxkm4UOElkg2uowJCefHan84gThK
 QiPdscXxg18hodknl9WLW4PQDNqIMgq3L2IrJYMVFhk29zidlyZyubY3FbY7PkMLlkR+2i
 dTDt+sX+ObWFkudvTlOL/e1InBTCmK8KVsdbT00qX2NFkATfH0++Gc7HPWL+YNbLotb1AR
 XpLO90HvNQcsS+AV1ktBg/wOM+b8/XS36Mb5DvWhg+C930PuS+qJ5bEYKQc38+YHWyDLuo
 hpOzxwuUUHid4uaJ9hEuhRmDk6BzUzQGyG4nfE1c1K24x6tdRK2tu/gpizK8yJcl04K3ba
 TNjuD/bUVhXk6sf/1jjonlOGTb2ObdGAEsZ8nh0wHnv1ABmUUv+Y9G90UCYg
X-ME-Proxy: <xmx:gOLzam43mUfCVDZOkLTeZ272UGZ-SqlxcT58lb8CpGnU_kbCMgjDFg>
 <xmx:gOLzaoXINOqYjBPAxMjN55cBJNLiW7MgB3H_IlKW6ypOceep21yugQ>
 <xmx:gOLzal5OKjlFutnlzN-UPidHJmBwb25a4A77dYVL6ELv78s39r3YMw>
 <xmx:gOLzajqhiYLQBq6kQw2qOMV8ranOCyeRPgcbo2CmjtBTV2SZNHvKVg>
 <xmx:gOLzagGhDcbO0_mx62M0uz3EDfPgTPBdUheb5KutqM0vkaMS9zxPzCj2>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 22:35:25 -0500 (EST)
Message-ID: <99b74bba27001175a03d746fecff447e3d527030.camel@alistair23.me>
Subject: Re: [PATCH 0/6] hw/dma,net: Fix Xilinx AXI DMA and Ethernet
From: Alistair <alistair@alistair23.me>
To: Jay Chang <jay.chang@sifive.com>, qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, "open
 list:Xilinx Zynq" <qemu-arm@nongnu.org>
Date: Wed, 11 Nov 2026 13:35:24 +1000
In-Reply-To: <20261015033733.35116-1-jay.chang@sifive.com>
References: <20261015033733.35116-1-jay.chang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 (by Flathub.org) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.152;
 envelope-from=alistair@alistair23.me; helo=fhigh-b1-smtp.messagingengine.com
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

On Thu, 2026-10-15 at 11:37 +0800, Jay Chang wrote:
> The Xilinx AXI DMA controller supports 64-bit descriptor addresses,
> but the QEMU model only handled the low 32 bits during stream
> processing.=C2=A0 This causes descriptor accesses to use incorrect
> addresses when descriptors are located above 4 GiB.
>=20
> This series updates the descriptor and MMIO handling and fixes
> related
> AXI DMA and AXI Ethernet behavior.
>=20
> The series:
>=20
> - Add 64-bit descriptor address handling to stream processing.
> - Add separate 32-bit and 64-bit MMIO access helpers.
> - Fix DMASR W1C and DMACR start processing behavior.
> - Reset both DMA channels when DMACR_RESET is written.
> - Do not start a transfer when TAILDESC is written while the channel
> =C2=A0 is halted.
> - Fix AXI Ethernet RX packet double-buffering.
>=20
> Testing:
> - Tested Xilinx AXI Ethernet networking with U-Boot.
> - Tested DHCP and ping.

Thanks!

Applied to riscv-to-apply.next

Alistair

>=20
> Jay Chang (6):
> =C2=A0 hw/dma/xilinx_axidma: Support 64-bit descriptor addressing in
> stream
> =C2=A0=C2=A0=C2=A0 processing
> =C2=A0 hw/dma/xilinx_axidma: Add 64-bit MMIO access support
> =C2=A0 hw/dma/xilinx_axidma: Fix DMASR register handling
> =C2=A0 hw/dma/xilinx_axidma: Reset both channels on DMACR_RESET
> =C2=A0 hw/dma/xilinx_axidma: Don't start transfer on TAILDESC write when
> =C2=A0=C2=A0=C2=A0 halted
> =C2=A0 hw/net/xilinx_axienet: Fix packet double-buffering issue
>=20
> =C2=A0hw/dma/xilinx_axidma.c=C2=A0 | 249 +++++++++++++++++++++++++++++---=
------
> --
> =C2=A0hw/net/xilinx_axienet.c |=C2=A0 12 ++
> =C2=A02 files changed, 193 insertions(+), 68 deletions(-)

