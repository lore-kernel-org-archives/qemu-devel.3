Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004191067020
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 14:00:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0ga8-0000kP-W7; Thu, 12 Mar 2026 10:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1w0ga5-0000jH-LK; Thu, 12 Mar 2026 10:00:05 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1w0ga1-0006WL-5u; Thu, 12 Mar 2026 10:00:05 -0400
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fWq4K4ZRGzHnH7Z;
 Thu, 12 Mar 2026 21:59:45 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 67D1C4056B;
 Thu, 12 Mar 2026 21:59:55 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 12 Mar
 2026 13:59:54 +0000
Date: Thu, 12 Mar 2026 13:59:53 +0000
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 59/65] hw/arm/virt: Split GICv2 and GICv3/4 creation
Message-ID: <20260312135953.00007383@huawei.com>
In-Reply-To: <20260223170212.441276-60-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
 <20260223170212.441276-60-peter.maydell@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 23 Feb 2026 17:02:06 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> Currently create_gic() handles GICv2 and GICv3/4 in a single
> function, with large sections that are conditional on the
> vms->gic_version.  GICv5 will be different to both.
> 
> Refactor into create_gicv2() and create_gicv3().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
One trivial comment inline.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  hw/arm/virt.c | 137 ++++++++++++++++++++++++++++++--------------------
>  1 file changed, 82 insertions(+), 55 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index ec6e49099a..3d19eb0fee 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -863,26 +863,58 @@ static void gic_connect_ppis(VirtMachineState *vms)
>      }
>  }

> +static void create_gicv3(VirtMachineState *vms, MemoryRegion *mem)
>  {
>      MachineState *ms = MACHINE(vms);
>      /* We create a standalone GIC */
>      SysBusDevice *gicbusdev;
> -    const char *gictype;
>      unsigned int smp_cpus = ms->smp.cpus;
>      uint32_t nb_redist_regions = 0;
I think this now always set before use so can drop the initialization.

>      int revision;
> -
> -    if (vms->gic_version == VIRT_GIC_VERSION_2) {
> -        gictype = gic_class_name();
> -    } else {
> -        gictype = gicv3_class_name();
> -    }
> +    QList *redist_region_count;
> +    uint32_t redist0_capacity = virt_redist_capacity(vms, VIRT_GIC_REDIST);
> +    uint32_t redist0_count = MIN(smp_cpus, redist0_capacity);
>  
>      switch (vms->gic_version) {
> -    case VIRT_GIC_VERSION_2:
> -        revision = 2;
> -        break;
>      case VIRT_GIC_VERSION_3:
>          revision = 3;
>          break;
> @@ -899,10 +931,11 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
>          exit(1);
>      }
>  
> -    vms->gic = qdev_new(gictype);
> +    vms->gic = qdev_new(gicv3_class_name());
>      qdev_prop_set_uint32(vms->gic, "revision", revision);
>      qdev_prop_set_uint32(vms->gic, "num-cpu", smp_cpus);
> -    /* Note that the num-irq property counts both internal and external
> +    /*
> +     * Note that the num-irq property counts both internal and external
>       * interrupts; there are always 32 of the former (mandated by GIC spec).
>       */
>      qdev_prop_set_uint32(vms->gic, "num-irq", NUM_IRQS + 32);
> @@ -910,40 +943,28 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
>          qdev_prop_set_bit(vms->gic, "has-security-extensions", vms->secure);
>      }
>  
> -    if (vms->gic_version != VIRT_GIC_VERSION_2) {
> -        QList *redist_region_count;
> -        uint32_t redist0_capacity = virt_redist_capacity(vms, VIRT_GIC_REDIST);
> -        uint32_t redist0_count = MIN(smp_cpus, redist0_capacity);
> +    nb_redist_regions = virt_gicv3_redist_region_count(vms);

...



