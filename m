Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFF3606A326
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 02:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAzo1IlW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO3q7-00019H-DB; Mon, 02 Nov 2026 21:01:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO3pI-00011O-Rf; Mon, 02 Nov 2026 21:00:41 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO3pG-0006eZ-UH; Mon, 02 Nov 2026 21:00:40 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E384E406EE;
 Tue,  3 Nov 2026 02:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D011F000C1;
 Tue,  3 Nov 2026 02:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793671236;
 bh=pekGp4yPszY+zVOUWOWjsMcffWX1H5o3fKQjzEevEmk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=aAzo1IlWlvil5hH9vKXbZhY19HoaAGD21bfnWnYu9uyCDZyJcTcBIMlmn3MckPBrA
 jtsSzW6IyS8npSauzlg1JYfy0SRjFlqI3EyLnZZWObfzNx3X//JYPIbQ7xwZjuWSAt
 HKgtbtcLJQ93InOFyQGcQuecXU1cOfx35l1tCejc96ptFhhaKMU1QHmX+OgosPbyFi
 A9LiS8B4RiUNJzFMYystRP+7vHhF607p9X/vYNu/hE50iPfvE6rb/A1J2U2MeVVfkN
 nQxh5Hk4mjWBHL3LCq12pdc0cC9vcXzXIn49RkTjN0L8GocJ3DHN+YgkJHI8aLItQr
 kEIWF55wlBzAQ==
Date: Tue, 3 Nov 2026 02:00:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, ruanjinjie@huawei.com
Subject: Re: [PATCH 20/37] hw/arm/virt: Create memory-side MPAM MSCs
Message-ID: <20261103020027.395d2fac@jic23-hlaptop>
In-Reply-To: <tencent_C40E52C43367C7292B3F69BC13A88845B708@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
 <tencent_C40E52C43367C7292B3F69BC13A88845B708@qq.com>
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

On Fri, 16 Oct 2026 18:10:40 +0800
Jinjie Ruan <2118537295@qq.com> wrote:

> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> With mpam=on, create one mpam-msc-mem per NUMA node with memory
> (256 request PARTIDs narrowed to 32 internal PARTIDs), or with
> mpam-min-msc=on a single shared MSC with one RIS per memory node
> and extreme narrowing (2 internal PARTIDs).  MSC creation requires
> NUMA nodes to be specified.  Cache MSC creation arrives with the
> next patch.
> 
> Based on an RFC series by Jonathan Cameron, adapted to the current
> cache topology API (machine_get_cache_topo_level).
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

A couple of formatting suggestions.  Otherwise LGTM
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  hw/arm/virt.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 3ad7de8..77942e7 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2144,6 +2144,63 @@ static void create_virtio_iommu_dt_bindings(VirtMachineState *vms)
>  #define MPAM_VIRT_NUM_PARTID     256
>  #define MPAM_VIRT_NUM_INTPARTID  32
>  
> +static void create_mpam_msc(VirtMachineState *vms, Error **errp)
> +{
> +    MachineState *ms = MACHINE(vms);
> +    DeviceState *dev;
> +    int i, count = 0;
> +    hwaddr base = vms->memmap[VIRT_MPAM_MSC].base;
> +
> +    if (ms->numa_state->num_nodes == 0) {
> +        error_setg(errp,
> +                   "MPAM support requires NUMA nodes to be specified");
> +        return;
> +    }
> +    if (!vms->mpam_min_msc) {
> +        for (i = 0; i < ms->numa_state->num_nodes; i++) {

Perhaps pull the declaration of i into each loop just to be
clear that it is locally scoped.

> +            /* at most 16 mem MSCs (4-bit selector space, SPI budget) */
> +            if (ms->numa_state->nodes[i].node_mem > 0 && count < 16) {
Maybe flip logic to reduce indent.
	    if (count >= 16)
                break;

            if (ms->numa_state->nodes[i].node_mem <= 0)
                continue;

            dev = ...

> +                dev = qdev_new(TYPE_MPAM_MSC_MEM);
> +
> +                object_property_set_uint(OBJECT(dev), "node", i,
> +                                         &error_fatal);

Perhaps with slightly lower indent and going a touch over 80 these might fit
on fewer lines.

> +                object_property_set_uint(OBJECT(dev), "num-ris", 1,
> +                                         &error_fatal);
> +                object_property_set_uint(OBJECT(dev), "num-partid",
> +                                         MPAM_VIRT_NUM_PARTID,
> +                                         &error_fatal);
> +                object_property_set_uint(OBJECT(dev), "num-int-partid",
> +                                         MPAM_VIRT_NUM_INTPARTID,
> +                                         &error_fatal);
> +                sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +                sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
> +                base += MPAM_SIZE;
> +                count++;
> +            }
> +        }
> +    } else {
> +        int count_with_mem = 0;
> +
> +        for (i = 0; i < ms->numa_state->num_nodes; i++) {
> +            if (ms->numa_state->nodes[i].node_mem) {
> +                count_with_mem++;
> +            }
> +        }
> +        dev = qdev_new(TYPE_MPAM_MSC_MEM);
> +        object_property_set_uint(OBJECT(dev), "num-ris", count_with_mem,
> +                                 &error_fatal);
> +        object_property_set_uint(OBJECT(dev), "num-partid",
> +                                 MPAM_VIRT_NUM_PARTID, &error_fatal);
> +        object_property_set_uint(OBJECT(dev), "num-int-partid",
> +                                 2, /* extreme narrowing */
> +                                 &error_fatal);
> +
> +        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
> +        base += MPAM_SIZE;
> +    }
> +}



