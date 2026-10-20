Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E488606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 22:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=boWLS/uP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJIYZ-0006FG-IQ; Tue, 20 Oct 2026 18:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xJIYY-0006Ex-Ax; Tue, 20 Oct 2026 18:43:42 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xJIYW-000367-Ba; Tue, 20 Oct 2026 18:43:42 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4FB48406FE;
 Tue, 20 Oct 2026 22:43:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052CB1F000C9;
 Tue, 20 Oct 2026 22:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792536218;
 bh=crPROvubel4QoAsqVEhegpU8cuJEIRlmAgKqA9FKN/c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=boWLS/uPzNvO7xrvkdxZxHN9bNkZXC5g6arv07/nWiV20HsPFNInuN0MF/I4LZzh2
 ysuc5aXDBJbNQb5qtP1F+c5ipuHSY3fBA50wrUKs0pO1bAMthe+vBY8PBxd+B8GPdo
 srrsmeSvn9maHQ7mRNKTR4uRE1C2Titn2FL6sLH28b4Iu0BdhmjHXYMqwwbXv8f06T
 T890xnLkhYyoCaZRvErrJQKXEthZrFAZ4fX4f7H2zRq3f7UnWzZtPW2Y9SLbk7NK1V
 hMmOB6wHzKTQLksA6JCiskT0SOaEYd6Jkkg45ciuOnZSp0uPDkMh0fnqTtl9tWfPLe
 fYk+9+A5K5UGA==
Date: Tue, 20 Oct 2026 15:43:36 -0700
From: Drew Fustini <fustini@kernel.org>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, ruanjinjie@huawei.com,
 daniel.barboza@oss.qualcomm.com, alistair.francis@wdc.com,
 anup.patel@oss.qualcomm.com, sunilvl@oss.qualcomm.com
Subject: Re: [PATCH 00/37] Add Arm MPAM emulation
Message-ID: <atfumL9Rnt4OBE7y@x1gen8.tail89d63.ts.net>
References: <tencent_22E95650AA60C6E59860452C0D61A21F1105@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_22E95650AA60C6E59860452C0D61A21F1105@qq.com>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=fustini@kernel.org;
 helo=sea.source.kernel.org
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

On Fri, Oct 16, 2026 at 05:46:54PM +0800, Jinjie Ruan wrote:
> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> MPAM (Memory System Resource Partitioning and Monitoring) is Arm's
> architecture for partitioning and monitoring system memory resources
> - Cache portions
> - Capacity limits
> - Memory bandwidth and priority
> 
> And MPAM is the Arm counterpart of x86 RDT, which Linux exposes to user
> space via resctrl.
> 
> QEMU so far has no MPAM support at all: the CPU-side system registers
> are missing (a guest kernel that probes FEAT_MPAM takes an UNDEFINED
> exception), and there are no Memory System Components (MSCs), so a virt
> guest cannot exercise resctrl on Arm.
> 
> This series adds MPAM 1.1 emulation for the virt machine,
> and the structure is as below:
> 
> * target/arm (patches 1-3): the CPU registers:
>     - MPAMIDR_EL1 and MPAM0_EL1/MPAM1_EL1
>     - MPAM2_EL2/MPAMHCR_EL2
>     - MPAMSM_EL1 for FEAT_MPAM_SMS
> 
> * hw/acpi (patch 4): PPTT revision 3 with Cache IDs, which the kernel
>   needs to resolve the MPAM table's cache references to PPTT cache
>   node.
On Fri, Oct 16, 2026 at 05:46:54PM +0800, Jinjie Ruan wrote:
> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> MPAM (Memory System Resource Partitioning and Monitoring) is Arm's
> architecture for partitioning and monitoring system memory resources
> - Cache portions
> - Capacity limits
> - Memory bandwidth and priority
> 
> And MPAM is the Arm counterpart of x86 RDT, which Linux exposes to user
> space via resctrl.
> 
> QEMU so far has no MPAM support at all: the CPU-side system registers
> are missing (a guest kernel that probes FEAT_MPAM takes an UNDEFINED
> exception), and there are no Memory System Components (MSCs), so a virt
> guest cannot exercise resctrl on Arm.
> 
> This series adds MPAM 1.1 emulation for the virt machine,
> and the structure is as below:
> 
> * target/arm (patches 1-3): the CPU registers:
>     - MPAMIDR_EL1 and MPAM0_EL1/MPAM1_EL1
>     - MPAM2_EL2/MPAMHCR_EL2
>     - MPAMSM_EL1 for FEAT_MPAM_SMS
> 
> * hw/acpi (patch 4): PPTT revision 3 with Cache IDs, which the kernel
>   needs to resolve the MPAM table's cache references to PPTT cache
>   node.

Thanks for posting as this patch would also be useful for RISC-V. The
QoS equivalent to MPAM is CBQRI [1], and I've been working on the Qemu
implementation and Linux resctrl integration. The ACPI RQSC table [2]
needs to reference PPTT cache IDs, too. Sunil recently posted a PPTT
series [3] but this patch 04/37 would also be needed.

Thanks,
Drew

[1] https://lore.kernel.org/qemu-devel/20260201-riscv-ssqosid-cbqri-v5-0-273ea4a21703@kernel.org/
[2] https://lore.kernel.org/qemu-devel/20260202-riscv-rqsc-v1-0-dcf448a3ed73@kernel.org/
[3] https://lore.kernel.org/qemu-devel/20261015064957.4076464-1-sunilvl@oss.qualcomm.com/

