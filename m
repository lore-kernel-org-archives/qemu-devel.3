Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840DBC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 15:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMTkg-0005tg-K8; Tue, 03 Jun 2025 11:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1uMTkd-0005tJ-L4
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 11:40:31 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1uMTka-0001DA-CE
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 11:40:31 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bBZcd5msNz6K90T;
 Tue,  3 Jun 2025 23:38:41 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
 by mail.maildlp.com (Postfix) with ESMTPS id 44F9C1402F7;
 Tue,  3 Jun 2025 23:40:12 +0800 (CST)
Received: from localhost (10.45.150.137) by frapeml500003.china.huawei.com
 (7.182.85.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 3 Jun
 2025 17:40:11 +0200
Date: Tue, 3 Jun 2025 16:40:05 +0100
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <qemu-devel@nongnu.org>, <anisinha@redhat.com>, <imammedo@redhat.com>,
 <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>,
 <peter.maydell@linaro.org>, <prime.zeng@hisilicon.com>,
 <shameerali.kolothum.thodi@huawei.com>, <wangyanan55@huawei.com>,
 <yangyicong@hisilicon.com>, Bibo Mao <maobibo@loongson.cn>
Subject: Re: [PATCH v5 0/4] Building PPTT with root node and identical
 implementation flag
Message-ID: <20250603164005.00003d56.alireza.sanaee@huawei.com>
In-Reply-To: <20250601082826-mutt-send-email-mst@kernel.org>
References: <20250523102654.1719-1-alireza.sanaee@huawei.com>
 <20250601082826-mutt-send-email-mst@kernel.org>
Organization: Huawei
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.150.137]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500003.china.huawei.com (7.182.85.28)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, 1 Jun 2025 08:32:52 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, May 23, 2025 at 11:26:50AM +0100, Alireza Sanaee wrote:
> > OS like Linux is using PPTT processor node's identical
> > implementation flag [1] to infer whether the whole system or a
> > certain CPU cluster is homogeneous or not [2]. QEMU currently only
> > support building homogeneous system, set the flag to indicate the
> > fact. Build a root node in PPTT for indicates the identical
> > implementation which is needed for a multi-socket system. Update
> > the related PPTT tables as well.
> > 
> > [1] ACPI 6.5 Table 5.158: Processor Structure Flags
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/acpi/pptt.c?h=v6.11-rc1#n810
> > 
> > History:
> >     * v4->v5: fixed a typo
> > 
> >     * v3->v4: PPTT rev to 2
> > 
> >     * v2->v3: rebase to 10
> > 
> > Alireza Sanaee (2):
> >   hw/acpi/aml-build: Build a root node in the PPTT table
> >   tests: virt: Update expected ACPI tables for virt test
> > 
> > Yicong Yang (2):
> >   tests: virt: Allow changes to PPTT test table
> >   hw/acpi/aml-build: Set identical implementation flag for PPTT
> >     processor nodes
> > 
> >  hw/acpi/aml-build.c                           |  24
> > +++++++++++++++--- tests/data/acpi/aarch64/virt/PPTT             |
> > Bin 76 -> 96 bytes .../data/acpi/aarch64/virt/PPTT.acpihmatvirt  |
> > Bin 156 -> 176 bytes tests/data/acpi/aarch64/virt/PPTT.topology
> > | Bin 336 -> 356 bytes 4 files changed, 20 insertions(+), 4
> > deletions(-)  
> 
> 
> This interacts weirdly with loongarch. I tried applying patches
> on top of that, and on loongarch, I see:
> 
> -[0F0h 0240 004h]       Flags (decoded below) : 00000000
> +[0F0h 0240 004h]       Flags (decoded below) : 0000000E
>                              Physical package : 0
> -                     ACPI Processor ID valid : 0
> -                       Processor is a thread : 0
> -                              Node is a leaf : 0
> +                     ACPI Processor ID valid : 1
> +                       Processor is a thread : 1
> +                              Node is a leaf : 1
>                      Identical Implementation : 0
> 
> 
> I'm sending a pull request later today. Once merged, pls
> rebase on top of that, updating loongarch as appropriate
> and repost copying relevant people.
> 
> Cc Bibo Mao for more insight.
Hi Micheal,

I am trying to reproduce this issue. I have applied the
patchset on the master branch now, and then run:
make check-qtest-loongarch64 V=2 -j, but I don't seem to get any diffs
on the binaries, and all tests passed.

May I know if that's how you noticed the problem?

Thanks,
Alireza
> 
> 
> > -- 
> > 2.34.1  
> 
> 


