Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07046CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 13:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3wvg-0001a9-AT; Wed, 01 Oct 2025 09:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1v3wvM-0001Nd-7N; Wed, 01 Oct 2025 09:31:25 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1v3wv4-0008Qn-6p; Wed, 01 Oct 2025 09:31:12 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ccG5H3xR7z6K5sM;
 Wed,  1 Oct 2025 21:30:27 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id D3ECB1402FD;
 Wed,  1 Oct 2025 21:30:44 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 1 Oct
 2025 14:30:43 +0100
Date: Wed, 1 Oct 2025 14:30:42 +0100
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: Re: [PATCH v4 18/27] hw/arm/virt-acpi-build: Add IORT RMR regions
 to handle MSI nested binding
Message-ID: <20251001143042.0000435b@huawei.com>
In-Reply-To: <20250929133643.38961-19-skolothumtho@nvidia.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-19-skolothumtho@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 29 Sep 2025 14:36:34 +0100
Shameer Kolothum <skolothumtho@nvidia.com> wrote:

> From: Eric Auger <eric.auger@redhat.com>
> 
> To handle SMMUv3 nested stage support it is practical to expose the guest
> with reserved memory regions (RMRs) covering the IOVAs used by the host
> kernel to map physical MSI doorbells.
> 
> Those IOVAs belong to [0x8000000, 0x8100000] matching MSI_IOVA_BASE and
> MSI_IOVA_LENGTH definitions in kernel arm-smmu-v3 driver. This is the
> window used to allocate IOVAs matching physical MSI doorbells.
> 
> With those RMRs, the guest is forced to use a flat mapping for this range.
> Hence the assigned device is programmed with one IOVA from this range.
> Stage 1, owned by the guest has a flat mapping for this IOVA. Stage2,
> owned by the VMM then enforces a mapping from this IOVA to the physical
> MSI doorbell.
> 
> The creation of those RMR nodes is only relevant if nested stage SMMU is
> in use, along with VFIO. As VFIO devices can be hotplugged, all RMRs need
> to be created in advance.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Various comments inline on references and making the code a little more resilient
and obvious wrt to the things that there happen to be 1 of but which the spec
allows for multiples of.

> ---
>  hw/arm/virt-acpi-build.c | 75 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 68 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index fd03b7f6a9..d0c1e10019 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c


> @@ -447,6 +450,56 @@ static void create_rc_its_idmaps(GArray *its_idmaps, GArray *smmuv3_devs)
>      }
>  }
>  
> +static void
> +build_iort_rmr_nodes(GArray *table_data, GArray *smmuv3_devices, uint32_t *id)
> +{
> +    AcpiIortSMMUv3Dev *sdev;
> +    AcpiIortIdMapping *idmap;
> +    int i;
> +
> +    for (i = 0; i < smmuv3_devices->len; i++) {
> +        sdev = &g_array_index(smmuv3_devices, AcpiIortSMMUv3Dev, i);
> +        idmap = &g_array_index(sdev->rc_smmu_idmaps, AcpiIortIdMapping, 0);
> +        int bdf = idmap->input_base;
> +
> +        if (!sdev->accel) {
> +            continue;
> +        }
> +
> +        /* Table 18 Reserved Memory Range Node */

Reference a spec version somewhere.  Table numbers tend to change over time.
Table 18 in E.g version of spec is Root Complex Node for example. This is now
table 19.


> +        build_append_int_noprefix(table_data, 6 /* RMR */, 1); /* Type */
> +        /* Length */
> +        build_append_int_noprefix(table_data, 28 + ID_MAPPING_ENTRY_SIZE + 20,

Add something to justify that + 20 (which I think is size of the Memory Range descriptors?)
The +28 is to start of bit after RMR specific data so that is kind of fine. As below
I'd add a constant for the number of ID mapping entries.


> +                                  2);
> +        build_append_int_noprefix(table_data, 3, 1); /* Revision */
> +        build_append_int_noprefix(table_data, *id, 4); /* Identifier */
> +        /* Number of ID mappings */
> +        build_append_int_noprefix(table_data, 1, 4);

I'd define a constant for the number of these and use it to help build the size.
Sure it is 1, but even so that would make the logic of placement simpler I think.

> +        /* Reference to ID Array */
> +        build_append_int_noprefix(table_data, 28, 4);
> +
> +        /* RMR specific data */
> +
> +        /* Flags */
> +        build_append_int_noprefix(table_data, 0 /* Disallow remapping */, 4);

Whilst we are disallowing remapping as this says, we are also saying a few
other things as there are more things in this flags field. Such as that it's
nGnRnE

> +        /* Number of Memory Range Descriptors */
> +        build_append_int_noprefix(table_data, 1 , 4);

I'd use a constant for this as well so that can use it in the size generation
and here.

> +        /* Reference to Memory Range Descriptors */
> +        build_append_int_noprefix(table_data, 28 + ID_MAPPING_ENTRY_SIZE, 4);
> +        build_iort_id_mapping(table_data, bdf, idmap->id_count, sdev->offset,
> +                              1);
> +
> +        /* Table 19 Memory Range Descriptor */

As above numbers changed, so specific spec version in the references.
It's 20 in the spec I downloaded today.


> +
> +        /* Physical Range offset */
> +        build_append_int_noprefix(table_data, 0x8000000, 8);

Can we get these from any defines?  Feels like make these values match in a number
of places is necessary so we shouldn't really hard code them here.

> +        /* Physical Range length */
> +        build_append_int_noprefix(table_data, 0x100000, 8);
> +        build_append_int_noprefix(table_data, 0, 4); /* Reserved */
> +        *id += 1;

Trivial but why not 
	   *id++;
better yet, do it where it's used rather than leaving it down here.
That way if in future multiple IDs are added for some reason then the increments
will go with them calls to add them.


> +    }
> +}
> +
>  /*
>   * Input Output Remapping Table (IORT)
>   * Conforms to "IO Remapping Table System Software on ARM Platforms",
> @@ -464,7 +517,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      GArray *smmuv3_devs = g_array_new(false, true, sizeof(AcpiIortSMMUv3Dev));
>      GArray *rc_its_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
>  
> -    AcpiTable table = { .sig = "IORT", .rev = 3, .oem_id = vms->oem_id,
> +    AcpiTable table = { .sig = "IORT", .rev = 5, .oem_id = vms->oem_id,
>                          .oem_table_id = vms->oem_table_id };

Seem to be missing the bios table test updates that will break with that version uptick.
Probably add a doc reference here so we can keep aligned.  The spec E.g has reached revision 7
whilst this work has been ongoing.


Jonathan


