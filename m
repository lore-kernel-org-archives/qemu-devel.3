Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FCCCD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 15:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPLyl-0005x1-3V; Tue, 19 May 2026 11:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1wPLyj-0005wj-Ew
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:03:29 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1wPLyi-000396-2O
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:03:29 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1CB8460121;
 Tue, 19 May 2026 15:03:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C36BC2BCB3;
 Tue, 19 May 2026 15:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779203006;
 bh=QpFFRAEmgJSwq4mHaasEexckCHQ/SH+TpXJyOShu0ec=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=EKbhN3Mkw4cGHmWwOhS0G7Uu5ceAdPg8M3pFp01WWLsWcCTE+/nSks99VxjTt1+CC
 Wzf6JNkfBU2+nvPh+PnHXnMpk5acKuwwPuvMNFrWQTl8Ij/wphC/fmL38GDRMlvVti
 1/X7TrO1EVmvZD9gdyGypQJ3BQvXQ/CZCScVZTLo5GSSj1Ank/Ci25sZ2gX8RRwN84
 IJrCFWSF3KMidWNPJR9xddxUU+Y/Dh2jyat58xXD7H7E+5U/MF3s1I9cFHmPbGZOd0
 /M+NBLgykya9ZUN9DMFiEgjKGhmY7qgHn4nFMnPWL4uXRPjQLBppVX1KzBLqthn0RK
 qcK5OLwfVLHTQ==
Date: Tue, 19 May 2026 16:03:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Lant <joshualant@gmail.com>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 Jonathan.Cameron@huawei.com, arpit1.kumar@samsung.com
Subject: Re: [RFC QEMU PATCH 04/10] cxl_downstream: enable power controller
 present capability.
Message-ID: <20260519160318.24091832@jic23-huawei>
In-Reply-To: <20260429135717.3048713-5-joshualant@gmail.com>
References: <20260429135717.3048713-1-joshualant@gmail.com>
 <20260429135717.3048713-5-joshualant@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=jic23@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 29 Apr 2026 14:48:38 +0100
Joshua Lant <joshualant@gmail.com> wrote:

> PCI_EXP_SLTCAP_PCP (Power Controller Present) must be set in the DSP's
> slot capabilities for PCIe managed hot-remove to complete. Without this
> notification from the guest of removal cannot be sent back to the
> device, so device listeners for unrealizing will not fire.
> 
> Signed-off-by: Joshua Lant <joshualant@gmail.com>
Another fix by the sound of it?  Please send separately (Well with the other
one perhaps) with a suitable Fixes tag.


> ---
>  hw/pci-bridge/cxl_downstream.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
> index 91c5e6a605..5322c46900 100644
> --- a/hw/pci-bridge/cxl_downstream.c
> +++ b/hw/pci-bridge/cxl_downstream.c
> @@ -228,6 +228,8 @@ static const Property cxl_dsp_props[] = {
>      DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
>                                  width, PCIE_LINK_WIDTH_16),
>      DEFINE_PROP_BOOL("x-256b-flit", PCIESlot, flitmode, true),
> +    DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
> +                    QEMU_PCIE_SLTCAP_PCP_BITNR, true),
>  };
>  
>  static void cxl_dsp_class_init(ObjectClass *oc, const void *data)


