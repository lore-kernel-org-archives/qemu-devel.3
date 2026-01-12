Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2816CF45A8
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 17:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfLTv-0004f6-Lf; Mon, 12 Jan 2026 12:13:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>)
 id 1vfLRn-0002vI-KB; Mon, 12 Jan 2026 12:11:38 -0500
Received: from fhigh-b6-smtp.messagingengine.com ([202.12.124.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>)
 id 1vfLRk-0007dD-Ne; Mon, 12 Jan 2026 12:11:19 -0500
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 6D2D37A00BE;
 Mon, 12 Jan 2026 12:11:13 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Mon, 12 Jan 2026 12:11:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1768237873;
 x=1768324273; bh=YYIiKadWRcxnSfN37hYQPJVSJvHsQec4Z1vBC/0Ewlw=; b=
 i0MpOEeui/DzJBH9nqrTgXLnKhUt6f2E0LLhgdMMxkOIJAJSH3bi8liHxWgGjM7k
 IzH4PCRdF3KYzFHY/nHLJnukMjexijFMAS/Z/QSiECth2PaLI3WFWgAKRS9uhqwY
 uPqlpIMiRziLBkn3L6xpVAj0OVCEBks4gBGlmzKCiQaKKYKLVjk39nJ8NDY0e8Ot
 hOi/GnFaSOGSGRMqh2dUrBsYRgSss+f1U7wI5ZU5Ntx0RYYHX0xducxdOslsgveL
 8Uk68bd6qwif5p3t9V8uiUL91duqZuPEmMP5Stm9FicEw4Qi2pCc4WbWFgEho4Dd
 tzgMvCH6VdwLNoBsVCo4Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768237873; x=
 1768324273; bh=YYIiKadWRcxnSfN37hYQPJVSJvHsQec4Z1vBC/0Ewlw=; b=T
 Kh9g7ypkJRDDSWiwh1jnY6q74wBsuiIXug7hqNH4bK6TsAM2JYaabZPD5JHaCc4R
 dB+TAnMHm7fTPsWYX5PfpDJWFPIeAfhqF0sYrVUg9bBVdrrIS7W6MlNdxYYsSOHN
 ssIw/UnWbxfTexRVkQv8xSPE4TykL87FheLN8WRsh9AfztRETKY0EXfNySU1hETC
 aHkUfn0j1pV9OhmkVAoAt875TN9nybG/xxXSKYTGBa7h3tnb0Pr+LCa6VrSlSCmv
 wdFawjWAGoRWaS5/yKe48/d+KpFYnD5a3btDAlxYS7WIpsC9gYpegl2qrouYov3Y
 PYjEwXbfo7EKwzY/W6nug==
X-ME-Sender: <xms:MCtlaeU4O_cSr_iUiJbxugMieisVHrvQaXBlkG2-aXjvJ7IIoHfw2g>
 <xme:MCtlaat4Ao06t4eaWOON14iLLuggY8BlLXVwzo2KACAL78Jov_AHGM1zNlk_DMc_q
 ZzlZN-HOELtW3MB7ndsJpjpX2DrSORBSc45pQ46PgEw25ITtptA>
X-ME-Received: <xmr:MCtlaaUM7jcXP_0IzMKvdhm7qGdS6pKySPOKnaO6nU8YaeuUgtaKxCylaeE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudektddvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
 hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
 htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
 veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepgedpmhhouggvpehs
 mhhtphhouhhtpdhrtghpthhtohepvhhitghtohhrrdiihhgrohesrghmugdrtghomhdprh
 gtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohep
 tghlghesrhgvughhrghtrdgtohhmpdhrtghpthhtohepqhgvmhhuqdhsthgrsghlvgesnh
 honhhgnhhurdhorhhg
X-ME-Proxy: <xmx:MCtladlgAtHgglg8oXApyn4AxK_NQfqAHwG4EOrEn8PE1tfQvU-mow>
 <xmx:MStlaTZA_ASWspTwbh_kkk9WbmChUNhE2b_SkyWDGVY3uBIQfb2FbQ>
 <xmx:MStlaQPp_5-nvGGq_kwFpDASVGE_73vCiCrAbDqKdMmixiXXiukQCQ>
 <xmx:MStlaQYeVCGDhpekkpPeVq9aB1qrx5YJy2D7LJRNmX2-1G3WA6lJtQ>
 <xmx:MStlaQMygLFrxlGEVwKdi4EYqoo2sq1GsZ9jIz_A8jtwbnwiaxaqphqT>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 12:11:12 -0500 (EST)
Date: Mon, 12 Jan 2026 10:11:11 -0700
From: Alex Williamson <alex@shazbot.org>
To: Victor Zhao <Victor.Zhao@amd.com>
Cc: <qemu-devel@nongnu.org>, <clg@redhat.com>, <qemu-stable@nongnu.org>
Subject: Re: [PATCH] vfio/pci: Do not clear PCI_COMMAND_INTX_DISABLE in
 pre_reset
Message-ID: <20260112101111.0857f69b@shazbot.org>
In-Reply-To: <20251219092634.3176885-1-Victor.Zhao@amd.com>
References: <20251219092634.3176885-1-Victor.Zhao@amd.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=202.12.124.157; envelope-from=alex@shazbot.org;
 helo=fhigh-b6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Fri, 19 Dec 2025 17:26:34 +0800
Victor Zhao <Victor.Zhao@amd.com> wrote:

> When vfio_pci_pre_reset() disables MSI/MSI-X, the device may fall back
> to INTx mode. The code then clears PCI_COMMAND_INTX_DISABLE, allowing
> the device to assert INTx. Since interrupt handlers have already been
> removed, this causes unhandled interrupts and kernel "nobody cared"
> warnings.

Is there a bug report to go along with this?

> Fix by not clearing PCI_COMMAND_INTX_DISABLE. The device reset will
> restore it to default state.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
> ---
>  hw/vfio/pci.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index b46b1305a7..1681134cf2 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2616,13 +2616,9 @@ void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
>  
>      vfio_disable_interrupts(vdev);
>  
> -    /*
> -     * Stop any ongoing DMA by disconnecting I/O, MMIO, and bus master.
> -     * Also put INTx Disable in known state.
> -     */
> +    /* Stop any ongoing DMA by disconnecting I/O, MMIO, and bus master. */
>      cmd = vfio_pci_read_config(pdev, PCI_COMMAND, 2);
> -    cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
> -             PCI_COMMAND_INTX_DISABLE);
> +    cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
>      vfio_pci_write_config(pdev, PCI_COMMAND, cmd, 2);
>  
>      /* Make sure the device is in D0 */


I think the key here was the "known state", where the PCI spec defines
that INTX_DISABLE should be clear after reset.  If we don't touch it,
the set bit will be saved and restored around reset.  However, the first
thing we do in post-reset is to configure INTx, and I think this
results in INTX_DISABLE being cleared such that the post-reset state
seen by the VM is consistent to the spec.  Do you confirm?  It might be
worthwhile to expand the comment in that regard.  Thanks,

Alex

