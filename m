Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3F9606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 22:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D7Ojgpl7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJIKp-0003Zt-OJ; Tue, 20 Oct 2026 18:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xJIKo-0003Zg-C2; Tue, 20 Oct 2026 18:29:30 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xJIKm-0001cU-5o; Tue, 20 Oct 2026 18:29:29 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D1A9560236;
 Tue, 20 Oct 2026 22:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555A41F000CB;
 Tue, 20 Oct 2026 22:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792535362;
 bh=pAKCc7SYALcN6QEo+yj1bOUHrInh7beiZ6Cvyg7TwsM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=D7Ojgpl7ZsdL8SXUnkmBlTgEJmyOdI2iENRF/R5JLYkFExof62eMzRGAPs6KkJzJq
 6/WI+1xW273pjJ6/aVA/+ECBmRbdvs2yC2AcCEDuSPj6w7v+y7B55SqrIkJuj2gmDg
 q8gKcLfHkmJfQtekLmO8ezXjC5Q+wk33QMqWwZT02EvxtQ9VT8Vxp2l5tb1WOsxk2d
 WIi1Q8aCV0TyECJkn/odnXYB9Z3hEySw7Mzyo1RdDUUNxy9Iz2sZYOyZkErPfsh5AD
 3L6H6oNblMh8G0groCPBvGARZupATRNrC4OgwRWhOlAVdZ3Yp9l5UuO6ZRfvjBgI4z
 i7TlMBXWg23yw==
Date: Tue, 20 Oct 2026 15:29:21 -0700
From: Drew Fustini <fustini@kernel.org>
To: Sunil V L <sunilvl@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Anup Patel <anup.patel@oss.qualcomm.com>,
 Prajwal N <prajwal.n@oss.qualcomm.com>,
 Shankar C <shankar.c@oss.qualcomm.com>,
 Jinjie Ruan <2118537295@qq.com>, ruanjinjie@huawei.com
Subject: Re: [PATCH v2 0/4] RISC-V: ACPI: Add PPTT support
Message-ID: <atfrQY1w-er0onXV@thelio>
References: <20261015064957.4076464-1-sunilvl@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015064957.4076464-1-sunilvl@oss.qualcomm.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=fustini@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 15, 2026 at 12:19:53PM +0530, Sunil V L wrote:
> Hi all,
> 
> This series adds ACPI Processor Properties Topology Table (PPTT) support to
> the RISC-V virt machine. PPTT allows the guest to discover the processor and
> cache topology exposed by the machine, which is useful for making better
> scheduling and cache-management decisions.

Thanks for picking up PPTT support. I can now rebase the RQSC support
[1] on this series.

However, RQSC actually needs PPTT revision 3, because it adds cache IDs
to the PPTT. The RQSC table references a capacity controller's cache by
the PPTT cache ID. In Linux, find_acpi_cache_level_from_id() and
acpi_pptt_get_cpumask_from_cache_id() return -ENOENT if PPTT rev < 3.

There is a new MPAM series by Jinjie Ruan which contains the patch
"[PATCH 04/37] hw/acpi: Build PPTT rev 3 with cache IDs for MPAM
cross-references" [2]. It bumps build_pptt() to revision 3 and gives
every cache node an ID.

I could just base the RQSC series on this PPTT series and that patch
03/37. But maybe there is a better way to coordinate adding PPTT v3?

Thanks,
Drew

[1] https://lore.kernel.org/all/20260202-riscv-rqsc-v1-0-dcf448a3ed73@kernel.org/
[2] https://lore.kernel.org/all/tencent_F9C68A515AC6C40BE2C32DB314E14CCB7106@qq.com/

