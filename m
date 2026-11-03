Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D12606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 03:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UDnA6OHh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO5Gr-0007ho-Ub; Mon, 02 Nov 2026 22:33:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO5GX-0007W3-Hh; Mon, 02 Nov 2026 22:32:55 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO5GV-0006aw-Rs; Mon, 02 Nov 2026 22:32:53 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B6E5360142;
 Tue,  3 Nov 2026 03:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433091F000C1;
 Tue,  3 Nov 2026 03:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793676768;
 bh=OaNcmbyxHqZ6V7mbNUN9xauu2wGevjZf5b/uKIAxoyc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=UDnA6OHhuR9zluYb5GqF0osIDlYCCf/uzgVALaA4WMR6F0e7k11+4FTqf1r9jchYK
 +E3+7MGsrJ8U/YZNC0nrheKJrqnEd4ni6oTcaKI8V1HARpqpUaX11/Q+xmGS2lRE4Z
 GblTF2wMbiYz/H/dFO7h1rtOo9/eLq45IpzVmFYWj5ueRlEslMOiXNYjFjFza3A5wK
 AmRuvxW2qnasBPGgHrLmXdF1r91YBZaBaS6UlXaU0Z5GbojzNmfZrlBwbuW2HN0c6M
 DXIyQ405P2OSwNSb0AW7V9uD2hhX1QeNPOyAxM1o09piNmBcSyGcR3CO4aR0/8icwz
 olKcIBzwpAN3Q==
Date: Tue, 3 Nov 2026 03:32:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, ruanjinjie@huawei.com
Subject: Re: [PATCH 35/37] hw/arm/virt: Default to implicit node 0 for MPAM
 without -numa
Message-ID: <20261103033240.39b521e1@jic23-hlaptop>
In-Reply-To: <tencent_EA6765326D6BC209B1EEF6434A6E46E93805@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
 <tencent_EA6765326D6BC209B1EEF6434A6E46E93805@qq.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=jic23@kernel.org;
 helo=tor.source.kernel.org
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

On Fri, 16 Oct 2026 18:10:55 +0800
Jinjie Ruan <2118537295@qq.com> wrote:

> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Instead of failing with 'MPAM support requires NUMA nodes to be
> specified', -M virt,mpam=on with no -numa now treats all RAM as one
> implicit node 0 and creates a single memory MSC for it (node 0, one
> RIS, same partitioning configuration as a per-node instance).  The
> ACPI MPAM locator keeps proximity domain 0, which the mainline
> arm_mpam driver resolves to node 0 via its pxm_to_node()
> NUMA_NO_NODE fallback; no SRAT is fabricated and the guest stays
> non-NUMA-aware.  Cache MSC creation is unaffected, and explicit
> -numa / mpam-min-msc paths are unchanged.

I'd push this back to where that check was introduced in the earlier
patch.

> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  hw/arm/virt.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 4ef7aed..ee4308e 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2244,11 +2244,31 @@ static void create_mpam_msc(VirtMachineState *vms, Error **errp)
>      hwaddr base = vms->memmap[VIRT_MPAM_MSC].base;
>  
>      if (ms->numa_state->num_nodes == 0) {
> -        error_setg(errp,
> -                   "MPAM support requires NUMA nodes to be specified");
> -        return;
> -    }
> -    if (!vms->mpam_min_msc) {
> +        /*
> +         * No -numa: treat all RAM as one implicit node 0 -- a single
> +         * memory MSC with one RIS.  The ACPI locator keeps proximity
> +         * domain 0, which the arm_mpam driver resolves to node 0 via its
> +         * pxm_to_node() NUMA_NO_NODE fallback; no SRAT is fabricated and
> +         * the guest stays non-NUMA-aware.
> +         */
I lost track, but doesn't this just correspond to 1 node 1 ris?  Why can't
we use either of the existing paths below having tweaked the number of nodes?

> +        int err_spi, oflow_spi;
> +
> +        dev = qdev_new(TYPE_MPAM_MSC_MEM);
> +        object_property_set_uint(OBJECT(dev), "node", 0, &error_fatal);
> +        object_property_set_uint(OBJECT(dev), "num-ris", 1, &error_fatal);
> +        object_property_set_uint(OBJECT(dev), "num-partid",
> +                                 MPAM_VIRT_NUM_PARTID, &error_fatal);
> +        object_property_set_uint(OBJECT(dev), "num-int-partid",
> +                                 MPAM_VIRT_NUM_INTPARTID, &error_fatal);
> +        mpam_msc_assign_irqs(dev, &err_spi, &oflow_spi, &next_spi);
> +        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
> +                           qdev_get_gpio_in(vms->gic, err_spi));
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 1,
> +                           qdev_get_gpio_in(vms->gic, oflow_spi));
> +        base += MPAM_SIZE;
> +    } else if (!vms->mpam_min_msc) {
>          for (i = 0; i < ms->numa_state->num_nodes; i++) {
>              /* at most 16 mem MSCs (4-bit selector space, SPI budget) */
>              if (ms->numa_state->nodes[i].node_mem > 0 && count < 16) {


