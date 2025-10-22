Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C93ACCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 08:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBUcL-0005SV-4E; Wed, 22 Oct 2025 04:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vBUcF-0005Rx-Om
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 04:54:44 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vBUc8-0007bN-Ae
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 04:54:42 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cs2xL5Pfsz6K6WV;
 Wed, 22 Oct 2025 16:52:54 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id 9A1891402F5;
 Wed, 22 Oct 2025 16:54:18 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 22 Oct
 2025 09:54:17 +0100
Date: Wed, 22 Oct 2025 09:54:16 +0100
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-devel@nongnu.org>, <mst@redhat.com>, <imammedo@redhat.com>,
 <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <nicolinc@nvidia.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <zhangfei.gao@linaro.org>
Subject: Re: [PATCH 0/3] hw/pci-host/gpex-acpi: Fix _DSM function 0 support
 and update BIOS table tests
Message-ID: <20251022095416.00003545@huawei.com>
In-Reply-To: <20251022080639.243965-1-skolothumtho@nvidia.com>
References: <20251022080639.243965-1-skolothumtho@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, 22 Oct 2025 09:06:36 +0100
Shameer Kolothum <skolothumtho@nvidia.com> wrote:

> Hi,
> 
> This small series fixes a compliance issue in the _DSM (Device Specific
> Method) implementation for the GPEX host bridge ACPI tables and updates
> the corresponding BIOS-table test refrence blobs.
> 
> This patch was originally part of the "Add support for user-creatable
> accelerated SMMUv3" series [0]. Based on feedback received and as it is a
> common standalone fix, it is now being sent as a separate series.
> 
> Please take a look.
> 
> Thanks,
> Shameer
> [0] https://lore.kernel.org/qemu-devel/20250929133643.38961-16-skolothumtho@nvidia.com/

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
(mostly in the earlier thread - but that didn't have the test tables updates which
are now here).

> 
> Eric Auger (1):
>   hw/pci-host/gpex-acpi: Fix _DSM function 0 support return value
> 
> Shameer Kolothum (2):
>   tests/qtest/bios-tables-test: Prepare for _DSM change in the DSDT
>     table
>   tests/qtest/bios-tables-test: Update DSDT blobs after GPEX _DSM change
> 
>  hw/pci-host/gpex-acpi.c                       |   2 +-
>  tests/data/acpi/aarch64/virt/DSDT             | Bin 5337 -> 5337 bytes
>  .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5423 -> 5423 bytes
>  tests/data/acpi/aarch64/virt/DSDT.acpipcihp   | Bin 6246 -> 6246 bytes
>  .../acpi/aarch64/virt/DSDT.hpoffacpiindex     | Bin 5391 -> 5391 bytes
>  tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6698 -> 6698 bytes
>  tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7812 -> 7812 bytes
>  tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev  | Bin 10274 -> 10274 bytes
>  .../data/acpi/aarch64/virt/DSDT.smmuv3-legacy | Bin 10274 -> 10274 bytes
>  tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5539 -> 5539 bytes
>  tests/data/acpi/aarch64/virt/DSDT.viot        | Bin 5354 -> 5354 bytes
>  tests/data/acpi/loongarch64/virt/DSDT         | Bin 4603 -> 4603 bytes
>  tests/data/acpi/loongarch64/virt/DSDT.memhp   | Bin 5824 -> 5824 bytes
>  tests/data/acpi/loongarch64/virt/DSDT.numamem | Bin 4609 -> 4609 bytes
>  .../data/acpi/loongarch64/virt/DSDT.topology  | Bin 4905 -> 4905 bytes
>  tests/data/acpi/riscv64/virt/DSDT             | Bin 3538 -> 3538 bytes
>  tests/data/acpi/x86/microvm/DSDT.pcie         | Bin 2985 -> 2985 bytes
>  17 files changed, 1 insertion(+), 1 deletion(-)
> 


