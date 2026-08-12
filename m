Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5D0C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuBJL-0006x9-AR; Wed, 12 Aug 2026 11:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuBJJ-0006wb-7J; Wed, 12 Aug 2026 11:56:09 -0400
Received: from fout-a3-smtp.messagingengine.com ([103.168.172.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuBJH-0005Af-IM; Wed, 12 Aug 2026 11:56:08 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id B9083EC0198;
 Wed, 12 Aug 2026 11:56:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Wed, 12 Aug 2026 11:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786550166; x=1786636566; bh=mDGFJsVNuZqnX9kBKpl+7TnV3h+qEUkA
 ZTsxYqC/MwQ=; b=YCyRxxiMIgsIqRB/aXkzpNp36npPZLw52GfVQpJhwXWieXFN
 2Y1rMgrNxVMZf3CingeKjtQVFsJD3GCmuiabLToVbTGHZPwi9CZsjA6TJAGG2bH+
 w8IwFtmealdAo2yoY0/OTVU20fbfFlarcPlSR6tAa1ZQIn4ntxjnYs5QxD2tY4kF
 5h2QlwS9reqMHCTTDcF4oa9YaK5Jw80FlN5dvyYrEpIr472SBtGTbzZe3rihDBW5
 TJZVFkXJ9+6WYe0lb7EWAkV3fg1L2cQhlYYAKvUFXY3AXXLxEnrIgiJxM8SGQAx9
 YtHnE+cF1DxooPZl+FTkGfB357u5B+1O2qR8/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786550166; x=
 1786636566; bh=mDGFJsVNuZqnX9kBKpl+7TnV3h+qEUkAZTsxYqC/MwQ=; b=Z
 cDnkHIiPk2pM+y3M1i+FYNYkE3haYIRNQW//lYfkL44ILvACJ1TvCcBTPT7fT9Gt
 znkxLpljgSNLYJAIm4csY9YVpegFJFwcJ6VHpOBWsPfaFUyQcMCjOyyACQzFEVQj
 GNK5bo8vqeivt7LrwtU9YSmI/Oo4MJtNqQBRimS3HOSD6+Z8jLUH2JCOkkm/O/Gp
 6Ra37C0OPk55QACoqa3Y9QiSVP2Xg1nIeAit7mUSUveoq2r1vdBLOI+RQl+STFzA
 Nt9y1SuE9kkBAPOFQclGjBXLcdFMNL5oJzdm3c59PTVFzSCU45l2EBqi1mYCZ3/3
 VLeI3vPtbCblh3fX0AXHw==
X-ME-Sender: <xms:lpd8akGg4zyGRwXk27x67J45w9O0eEZj4wf9cjrcuSnmWdzigyNwsw>
 <xme:lpd8aozvZ9ezV1bypwNyGyVg90hukkB2na8938Rq4cyXgaKajPBh36Kws1Dr-9IQK
 ki_mVSbHKOEnMsGZCmFjK8A3gYJLs0GxskKIFb1iWIvLh-A_wCTKSpl>
X-ME-Received: <xmr:lpd8ahrac9332Je-y64SJlAiVtNLLGHFTeGnaB30HreZIHyx-KJ2DMwj0Y5lIytGy5sYXw>
X-ME-Proxy-Cause: dmFkZTEL/KN2e3ycVIdu2lWpapyPAwT6cvktLzShViDcucPdV8vnuDZeNiJZ/LGYU5hjTV
 SdPpYmjVCqH8wGbPjp4NotLb18HueuCqZISl+pYZeS3hrbGcz8GHw5x+5lieajXxsZEBtg
 jC1An/bFmxJ6ve/i2eBipwBiH9+tjleKsX6gmUIH8ZuMiiSxmIbJHNa3BAni0rJjQdQd75
 doqSgU8z8paBzGQxykUYTPq4VDJfKJ6FmqPtkxULfn+oTjfWZT0oMN5iuoEMWS7Nbrp9Ug
 iFP1uKZtLYUXt+bxikchx92nRZ2vghjJ6xe6n8nT2mTYumyJk1DoxBARXvEKp4IelfNMsT
 etdYy1v1ZAapKugpNmKjTMyZWtsXV5M/UmBZYKZ2ls3MrxFdBe/nIbIfOa9JBBuY1mB4IH
 Ou+rbeh3+GxiKHlReP2MUgrSikdDuu5SX52jQzs4/xiIOj/NrCRa62ToAnmX1tFVcBF38U
 acxC7RqVV3jm4TYaiY8BmK8aNDLRgBirU58iE/dvrkEnINX4UYjGKi/hpxuykmHzQijC8V
 g49WeNhmDJ6k1CWJNgAkQWpuVVbP29XoTm+HUzmOYuQOjm0++vEv4v7L4bAo/B+IHRJ2h9
 MPcNijT2hj1gMlcEJbykPvNN/bNZSbhsqEWnaoyrW9VtfCoLk3GFCFNMq2dg
X-ME-Proxy: <xmx:lpd8aqgfbBc6GRywihHJYPoWhSshw1iSRHNaKpTxhuYyTK8ZP6_fTw>
 <xmx:lpd8amj9bJ_H_18BD0uu5YGTiZsDLxVDCOvtyFK4gMuomgbm321C9A>
 <xmx:lpd8aoh_lB6XFYZ2Hrb51Z_wQHgNFeuCFJFfFMid5nGBFJsXDmyKpQ>
 <xmx:lpd8auI5RCYYEtQoMObCN8vujiw58LM3iXx9xfmNeXjGYCH1ZcE-UQ>
 <xmx:lpd8ahJTVFEV-LLkCwDMGHZXCFq31rc5hGMbDf4u5hPGNnLjClTzEb7W>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 11:56:05 -0400 (EDT)
Message-ID: <0b76c40dbc9271199c470f3fcf23d827c8962dd5.camel@alistair23.me>
Subject: Re: [PATCH 14/26] hw/sd: cadence: Advertise 64-bit system bus support
From: Alistair <alistair@alistair23.me>
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Date: Thu, 13 Aug 2026 01:56:04 +1000
In-Reply-To: <20260723151853.2143177-15-bin.meng@processmission.com>
References: <20260723151853.2143177-1-bin.meng@processmission.com>
 <20260723151853.2143177-15-bin.meng@processmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.146;
 envelope-from=alistair@alistair23.me; helo=fout-a3-smtp.messagingengine.com
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

On Thu, 2026-07-23 at 23:18 +0800, Bin Meng wrote:
> PolarFire SoC software selects 64-bit ADMA descriptors for the
> Cadence
> SDHCI controller. Advertise 64-bit system bus support so the existing
> generic descriptor engine can execute those transfers.
>=20
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
>=20
> =C2=A0hw/sd/cadence_sdhci.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/hw/sd/cadence_sdhci.c b/hw/sd/cadence_sdhci.c
> index 8476baf67f..39c6e5d101 100644
> --- a/hw/sd/cadence_sdhci.c
> +++ b/hw/sd/cadence_sdhci.c
> @@ -54,6 +54,9 @@ static void cadence_sdhci_instance_init(Object
> *obj)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 object_initialize_child(OBJECT(s), "generic-sdhc=
i",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 &s->sdhci, TYPE_SYSBUS_SDHCI);
> +=C2=A0=C2=A0=C2=A0 object_property_set_uint(OBJECT(&s->sdhci), "capareg"=
,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 SDHC_CAPAB_REG_DEFAULT |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 R_SDHC_CAPAB_BUS64BIT_MASK,
> &error_abort);

Won't this break others?

Alistair

> =C2=A0}
> =C2=A0
> =C2=A0static void cadence_sdhci_reset(DeviceState *dev)

