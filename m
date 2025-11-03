Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54218CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 14:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFvwo-0005fE-Ah; Mon, 03 Nov 2025 09:54:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vFvwj-0005eF-ME; Mon, 03 Nov 2025 09:54:14 -0500
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vFvwa-0007FK-Eu; Mon, 03 Nov 2025 09:54:13 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d0ZNK39lWzHnGfG;
 Mon,  3 Nov 2025 22:53:53 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id 0A45E1402F1;
 Mon,  3 Nov 2025 22:53:55 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 3 Nov
 2025 14:53:53 +0000
Date: Mon, 3 Nov 2025 14:53:52 +0000
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v5 23/32] hw/arm/virt-acpi-build: Add IORT RMR regions
 to handle MSI nested binding
Message-ID: <20251103145352.00005c24@huawei.com>
In-Reply-To: <20251031105005.24618-24-skolothumtho@nvidia.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-24-skolothumtho@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 31 Oct 2025 10:49:56 +0000
Shameer Kolothum <skolothumtho@nvidia.com> wrote:

> From: Eric Auger <eric.auger@redhat.com>
> 
> To handle SMMUv3 accel=on mode(which configures the host SMMUv3 in nested
> mode), it is practical to expose the guest with reserved memory regions
> (RMRs) covering the IOVAs used by the host kernel to map physical MSI
> doorbells.
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
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

One small question inline on the id increment.

With that tidied up.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> @@ -447,10 +475,70 @@ static void create_rc_its_idmaps(GArray *its_idmaps, GArray *smmuv3_devs)
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
> +        uint16_t rmr_len;
> +        int bdf;
> +
> +        sdev = &g_array_index(smmuv3_devices, AcpiIortSMMUv3Dev, i);
> +        if (!sdev->accel) {
> +            continue;
> +        }
> +
> +        /*
> +         * Spec reference:Arm IO Remapping Table(IORT), ARM DEN 0049E.d,
> +         * Section 3.1.1.5 "Reserved Memory Range node"
> +         */
> +        idmap = &g_array_index(sdev->rc_smmu_idmaps, AcpiIortIdMapping, 0);
> +        bdf = idmap->input_base;
> +        rmr_len = IORT_RMR_COMMON_HEADER_SIZE
> +                 + (IORT_RMR_NUM_ID_MAPPINGS * ID_MAPPING_ENTRY_SIZE)
> +                 + (IORT_RMR_NUM_MEM_RANGE_DESC * IORT_RMR_MEM_RANGE_DESC_SIZE);
> +
> +        /* Table 18 Reserved Memory Range Node */
> +        build_append_int_noprefix(table_data, 6 /* RMR */, 1); /* Type */
> +        /* Length */
> +        build_append_int_noprefix(table_data, rmr_len, 2);
> +        build_append_int_noprefix(table_data, 3, 1); /* Revision */
> +        build_append_int_noprefix(table_data, (*id)++, 4); /* Identifier */
So *id is incremented here and...
> +        /* Number of ID mappings */
> +        build_append_int_noprefix(table_data, IORT_RMR_NUM_ID_MAPPINGS, 4);
> +        /* Reference to ID Array */
> +        build_append_int_noprefix(table_data, IORT_RMR_COMMON_HEADER_SIZE, 4);
> +
> +        /* RMR specific data */
> +
> +        /* Flags */
> +        build_append_int_noprefix(table_data, IORT_RMR_FLAGS, 4);
> +        /* Number of Memory Range Descriptors */
> +        build_append_int_noprefix(table_data, IORT_RMR_NUM_MEM_RANGE_DESC, 4);
> +        /* Reference to Memory Range Descriptors */
> +        build_append_int_noprefix(table_data, IORT_RMR_COMMON_HEADER_SIZE +
> +                        (IORT_RMR_NUM_ID_MAPPINGS * ID_MAPPING_ENTRY_SIZE), 4);
> +        build_iort_id_mapping(table_data, bdf, idmap->id_count, sdev->offset,
> +                              1);
> +
> +        /* Table 19 Memory Range Descriptor */
> +
> +        /* Physical Range offset */
> +        build_append_int_noprefix(table_data, MSI_IOVA_BASE, 8);
> +        /* Physical Range length */
> +        build_append_int_noprefix(table_data, MSI_IOVA_LENGTH, 8);
> +        build_append_int_noprefix(table_data, 0, 4); /* Reserved */
> +        *id += 1;
here. Why this second one? Perhaps a comment if this is intended.

> +    }
> +}

