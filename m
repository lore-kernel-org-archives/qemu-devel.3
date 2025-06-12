Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF188C61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 18:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPn1h-0004IT-9G; Thu, 12 Jun 2025 14:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>)
 id 1uPn1e-0004Hn-Vh; Thu, 12 Jun 2025 14:51:47 -0400
Received: from fhigh-b8-smtp.messagingengine.com ([202.12.124.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>)
 id 1uPn1b-0001zA-Ef; Thu, 12 Jun 2025 14:51:46 -0400
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 73BB625401C1;
 Thu, 12 Jun 2025 14:51:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Thu, 12 Jun 2025 14:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749754299;
 x=1749840699; bh=sUT8WXlVYovFOolMo/NzUFm8C5jXwrypIzscuvAHRtY=; b=
 FsnnKEXOgnx553KkAkbZYef4s2U14SnBZ19qU6E3TfCXCwoSxf0CgN9rbUJH4cST
 avWRWsbrXDuOrV4rVMnmbHqzoaAP9nEespJPB0eN73yOYGxKX+NJPmUU277gtaCs
 cezDjAhIJpxT2ch9kGt0OHtqiQCwP2FBTCd4vIeIS8Wr2bl0zQFVFGGWc4uQ4dR3
 lkH0O31suCaIS+BJRGL+BHK/wNjTczSlI7+2lQr6wxC4yyAuRXB0QRUc4Av5spw9
 grM8Z8f8rDDJNPmpBwD2Du8/qopkIh3EQl0qAdjNLDh2vkOfgckmVPxQ2+8218rO
 i/ppg5+E2eGtXL/JomI4Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749754299; x=
 1749840699; bh=sUT8WXlVYovFOolMo/NzUFm8C5jXwrypIzscuvAHRtY=; b=U
 CrEqQhH7RyGhfTz4SZY8lrmMshyLjwmJxhQUCOgGVC42bkBKaYof7p65mM41+5Ee
 BWFw9JSnqx+pywCWz4gDlIR0uBCjb2sGPy3Q6K+69to1V0ixwems/VnhV4UglvQz
 T0lDhP8jEDAko4dXRwFiBp2Em2OVNgVJKkKIExGaNJ2l8OqQb5417XKabIUtlgum
 zEZZXopKAkm1mO5qMQRVTIezlLHmWOUTB1LPYglkj+5e/fvQqYC8qx1/Pcih7lmA
 WV5EfclfjNQH/k+AP/bPlNfQQd0IoAElz+s1ZckZeAsyJMWycfRODWqNN/411HO5
 q8jIzajX0Q1tDtE6R306Q==
X-ME-Sender: <xms:uSFLaEMtZrzOgAKkuXudiTW3K7ZjDAF45svW63oeKLu5CMkxknXo0g>
 <xme:uSFLaK-T5R8Obc0tf-t1UoNu78k0Hnwf-DJgp9Psw_8u-Hv8ThwrbweCu3Fnprv8m
 aUP_Y5vA5_e7Woy-hU>
X-ME-Received: <xmr:uSFLaLRzI7byXPHwidASFzlOig4GQMpNsOkKfKA7HQoalHprBVZL-F9PL1WSRyLqB6grTgB2I7cDz2JCI7CQQCAtEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduheekfecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredt
 jeenucfhrhhomhepfdflvghsphgvrhcuffgvvhgrnhhtihgvrhdfuceofhhoshhsseguvg
 hfmhgrtghrohdrihhtqeenucggtffrrghtthgvrhhnpeevveelveeikeffgeehleevleff
 hedvgfegvddvleehieeludeiveehleelhefhhfenucffohhmrghinhepghhithhlrggsrd
 gtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
 fhhoshhsseguvghfmhgrtghrohdrihhtpdhnsggprhgtphhtthhopeeipdhmohguvgepsh
 hmthhpohhuthdprhgtphhtthhopehithhssehirhhrvghlvghvrghnthdrughkpdhrtghp
 thhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehksg
 hushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepqhgvmhhuqdgslhhotghksehn
 ohhnghhnuhdrohhrghdprhgtphhtthhopehkrdhjvghnshgvnhesshgrmhhsuhhnghdrtg
 homhdprhgtphhtthhopehqvghmuhdquggvvhgvlhdqsghouhhntggvshdoqhgvmhhuqdgu
 vghvvghlpegrrhgthhhivhgvrhdrkhgvrhhnvghlrdhorhhgsehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:uSFLaMtn3223WRZfmXDEcuzz_8D-ICno4r2MvKLrQVr7mRnEaqy5TA>
 <xmx:uSFLaMdXx3Q_YL5j5YKEfLuKpyNWIRn989JanPzngg2PyaDoTgM7JQ>
 <xmx:uSFLaA3GF9COW9buzwL2uVolfAu9EVTWBH3TSTRf79exD8IZKAyIJA>
 <xmx:uSFLaA-TqEIFZbbGPBnK1F_OE4FQ63pbm95wvAev7cTLNfwNbkRM0w>
 <xmx:uyFLaGhNo9mo7NDRMEnw358fryHJXvRsBzSRrJ_A8jgcKcsKKGjMpW8o>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Jun 2025 14:51:36 -0400 (EDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Jun 2025 20:51:34 +0200
Message-Id: <DAKS4PRUWUVT.3QI3A3ALLLEEU@defmacro.it>
Cc: "Klaus Jensen" <k.jensen@samsung.com>,
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Subject: Re: [PATCH 1/2] hw/nvme: fix namespace attachment
From: "Jesper Devantier" <foss@defmacro.it>
To: "Klaus Jensen" <its@irrelevant.dk>, <qemu-devel@nongnu.org>, "Keith
 Busch" <kbusch@kernel.org>, <qemu-block@nongnu.org>
X-Mailer: aerc 0.20.1
References: <20250603-nvme-fixes-v1-0-01d67258ffca@samsung.com>
 <20250603-nvme-fixes-v1-1-01d67258ffca@samsung.com>
In-Reply-To: <20250603-nvme-fixes-v1-1-01d67258ffca@samsung.com>
Received-SPF: pass client-ip=202.12.124.159; envelope-from=foss@defmacro.it;
 helo=fhigh-b8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue Jun 3, 2025 at 2:59 PM CEST, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>
> Commit 6ccca4b6bb9f ("hw/nvme: rework csi handling") introduced a bug in
> Namespace Attachment, causing it to
>
>   a) not allow a controller to attach namespaces to other controllers
>   b) assert if a valid non-attached namespace is detached
>
> This fixes both issues.
>
> Fixes: 6ccca4b6bb9f ("hw/nvme: rework csi handling")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2976
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/nvme/ctrl.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index fd935507bc0280c1f49822f9e3cb035df596ae47..8de900ef8aca9b510b072892f=
9f82c01acee4f7d 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -6816,7 +6816,7 @@ static uint16_t nvme_ns_attachment(NvmeCtrl *n, Nvm=
eRequest *req)
> =20
>          switch (sel) {
>          case NVME_NS_ATTACHMENT_ATTACH:
> -            if (nvme_ns(n, nsid)) {
> +            if (nvme_ns(ctrl, nsid)) {
>                  return NVME_NS_ALREADY_ATTACHED | NVME_DNR;
>              }
> =20
> @@ -6824,7 +6824,7 @@ static uint16_t nvme_ns_attachment(NvmeCtrl *n, Nvm=
eRequest *req)
>                  return NVME_NS_PRIVATE | NVME_DNR;
>              }
> =20
> -            if (!nvme_csi_supported(n, ns->csi)) {
> +            if (!nvme_csi_supported(ctrl, ns->csi)) {
>                  return NVME_IOCS_NOT_SUPPORTED | NVME_DNR;
>              }
> =20
> @@ -6834,6 +6834,10 @@ static uint16_t nvme_ns_attachment(NvmeCtrl *n, Nv=
meRequest *req)
>              break;
> =20
>          case NVME_NS_ATTACHMENT_DETACH:
> +            if (!nvme_ns(ctrl, nsid)) {
> +                return NVME_NS_NOT_ATTACHED | NVME_DNR;
> +            }
> +
>              nvme_detach_ns(ctrl, ns);
>              nvme_update_dsm_limits(ctrl, NULL);
> =20

Applied, built, read, and it seems in line with the specification :)

Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>

