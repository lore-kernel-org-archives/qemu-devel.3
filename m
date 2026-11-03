Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A75606A32F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 01:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L5idywwz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO3jI-0007GN-V3; Mon, 02 Nov 2026 20:54:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO3jF-0007Fd-3w; Mon, 02 Nov 2026 20:54:25 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO3jD-0005b3-JJ; Mon, 02 Nov 2026 20:54:24 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2311241E77;
 Tue,  3 Nov 2026 01:54:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A267C1F000C1;
 Tue,  3 Nov 2026 01:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793670861;
 bh=/kVm6Vn6Hnt2sNzwTEXd1Dmnx1Id2gboV3E/wCHxBcI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=L5idywwzWlvCJZuUrqN4E24W7lsbwEv+vkX19+OfYmy1H7tF3iZf2HBcnwctmjwQI
 Q4SNs/D/McTcrlIJkvVWMY4uoTj30oB5jXNdtZhe+U1aE0ytrwpk6640t3Z884MyEZ
 M1S3eTrcDWRc0cV4CZtBZyxSy895IpysaqJIQcWNiWzATbRVhOnXdWmho/dpaOlYBe
 IFs3C3jS5J2joDF85cMusfWAuFhAG+4GL+Q4zkRwnGiZYxkjgGX5l1HRf88JZnHv5S
 Yax//vS8wnzgS+sWQFX/pnYl5VueEGuoFi9QbahpbWgqU5Ef5WRV4+5FpELoLdGpKt
 1EInS+oItmbCA==
Date: Tue, 3 Nov 2026 01:54:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, ruanjinjie@huawei.com
Subject: Re: [PATCH 18/37] hw/arm/virt: Reserve the MPAM MSC MMIO window
Message-ID: <20261103015412.2c8e299c@jic23-hlaptop>
In-Reply-To: <tencent_1CD3EC276A11AB6E43A57A66C08F31561809@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
 <tencent_1CD3EC276A11AB6E43A57A66C08F31561809@qq.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=jic23@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 16 Oct 2026 18:10:36 +0800
Jinjie Ruan <2118537295@qq.com> wrote:

> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Reserve a 1 MiB MMIO window at 0x0b006000 for the MPAM MSCs
> (MPAM_SIZE * 256 slots, right above the virtio MMIO transports)
> and add the VIRT_MPAM_MSC memmap entry the creation code uses.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Not sure this needs a separate patch given how trivial it is.
Maybe it is worth having to be able to talk separate about where
it is in the memory map.
Seems like a safe enough hole to use.
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  hw/arm/virt.c         | 3 +++
>  include/hw/arm/virt.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index aaadff6..3ad7de8 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -90,6 +90,7 @@
>  #include "hw/virtio/virtio-md-pci.h"
>  #include "hw/virtio/virtio-iommu.h"
>  #include "hw/char/pl011.h"
> +#include "hw/arm/mpam.h"
>  #include "hw/core/cpu.h"
>  #include "hw/cxl/cxl.h"
>  #include "hw/cxl/cxl_host.h"
> @@ -211,6 +212,8 @@ static const MemMapEntry base_memmap[] = {
>      [VIRT_SECURE_GPIO] =        { 0x090b0000, 0x00001000 },
>      [VIRT_ACPI_PCIHP] =         { 0x090c0000, ACPI_PCIHP_SIZE },
>      [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
> +    /* MPAM MSC MMIO windows: MPAM_SIZE (16 KiB) each, 256 slots (1 MiB). */
> +    [VIRT_MPAM_MSC] =           { 0x0b006000, MPAM_SIZE * 256 },
>      /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
>      [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
>      [VIRT_SECURE_MEM] =         { 0x0e000000, 0x01000000 },
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index c847136..56bee15 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -81,6 +81,7 @@ enum {
>      VIRT_SMMU,
>      VIRT_UART0,
>      VIRT_MMIO,
> +    VIRT_MPAM_MSC,
>      VIRT_RTC,
>      VIRT_FW_CFG,
>      VIRT_PCIE,


