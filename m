Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9240BC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 15:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trewE-0000jd-W0; Mon, 10 Mar 2025 11:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1trevv-0000Jz-AC
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:20:49 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1trevs-0000nV-19
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:20:46 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZBL7s0zjzz67j7Z;
 Mon, 10 Mar 2025 23:16:09 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
 by mail.maildlp.com (Postfix) with ESMTPS id A0E36140CB1;
 Mon, 10 Mar 2025 23:20:31 +0800 (CST)
Received: from localhost (10.47.68.114) by frapeml500003.china.huawei.com
 (7.182.85.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 10 Mar
 2025 16:20:30 +0100
Date: Mon, 10 Mar 2025 15:20:25 +0000
To: Alireza Sanaee via <qemu-devel@nongnu.org>
CC: Alireza Sanaee <alireza.sanaee@huawei.com>, <mst@redhat.com>,
 <imammedo@redhat.com>, <peter.maydell@linaro.org>, <wangyanan55@huawei.com>,
 <anisinha@redhat.com>, <jonathan.cameron@huawei.com>,
 <shameerali.kolothum.thodi@huawei.com>, <prime.zeng@hisilicon.com>,
 <yangyicong@hisilicon.com>
Subject: Re: [PATCH v2 0/5] Building PPTT with root node and identical
 implementation flag
Message-ID: <20250310151842.00003c7c.alireza.sanaee@huawei.com>
In-Reply-To: <20250306023342.508-1-alireza.sanaee@huawei.com>
References: <20250306023342.508-1-alireza.sanaee@huawei.com>
Organization: Huawei
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.68.114]
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500003.china.huawei.com (7.182.85.28)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 6 Mar 2025 02:33:37 +0000
Alireza Sanaee via <qemu-devel@nongnu.org> wrote:

Hi everyone,

v1 -> v2: I just rebased this patchset which initially was posted in
Sep 2024.

Thanks,
Alireza

> OS like Linux is using PPTT processor node's identical implementation
> flag [1] to infer whether the whole system or a certain CPU cluster is
> homogeneous or not [2]. QEMU currently only support building
> homogeneous system, set the flag to indicate the fact. Build a root
> node in PPTT for indicates the identical implementation which is
> needed for a multi-socket system. Update the related PPTT tables as
> well.
> 
> Since we'll update the test PPTT table data, upgrade the revision of
> PPTT we build to revision 3 by handy.
> 
> [1] ACPI 6.5 Table 5.158: Processor Structure Flags
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/acpi/pptt.c?h=v6.11-rc1#n810
> 
> Yicong Yang (5):
>   tests: virt: Allow changes to PPTT test table
>   hw/acpi/aml-build: Set identical implementation flag for PPTT
>     processor nodes
>   hw/acpi/aml-build: Build a root node in the PPTT table
>   hw/acpi/aml-build: Update the revision of PPTT table
>   tests: virt: Update expected ACPI tables for virt test
> 
>  hw/acpi/aml-build.c                           |  26
> ++++++++++++++---- tests/data/acpi/aarch64/virt/PPTT             |
> Bin 76 -> 96 bytes .../data/acpi/aarch64/virt/PPTT.acpihmatvirt  |
> Bin 156 -> 176 bytes tests/data/acpi/aarch64/virt/PPTT.topology    |
> Bin 336 -> 356 bytes 4 files changed, 21 insertions(+), 5 deletions(-)
> 


