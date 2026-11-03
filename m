Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620F7606A329
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 00:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cSdcJx1C
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO1zo-0006YB-Nf; Mon, 02 Nov 2026 19:03:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO1zm-0006XF-7K; Mon, 02 Nov 2026 19:03:22 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO1zk-0003tQ-Cg; Mon, 02 Nov 2026 19:03:21 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9B32A43740;
 Tue,  3 Nov 2026 00:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46DB11F0093A;
 Tue,  3 Nov 2026 00:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793664198;
 bh=j/39leR5+InevILLUMiPfZbnWUUtFFojtqKlc5h+44o=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=cSdcJx1Cd4eWqkrHGNlNeQ9SJxql/m+Y4ZwC8AhcUHk0x4gKiTpnT7CAY8a/f07yJ
 4jEkZQAatCKtwKbKopI2YKrbjpv5oJ0EljHSYQkbVtOWbyrW4cJB2kS6NhdKLEdYts
 3zj/BQRzouCeuvL7hpjAxE108b/kprpHTd+z76Vij11PgUYMKyE7K6bYTXhEhNPC++
 HFT/F4LbKJHGLKNvI6sMGBFd6JR7hx6hIM6xq/vhSLxTEhdSru5SdePHb9VI8SOJqF
 7Um9ztaDYe44ZPm8xoxAMMOazVmlY1fCwjI5xj/u3cYTOYe06yc5+hzhuXClTtZWbE
 NI9ARQPj14vSQ==
Date: Tue, 3 Nov 2026 00:03:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, ruanjinjie@huawei.com
Subject: Re: [PATCH 01/37] target/arm: Add support for MPAM CPU registers
Message-ID: <20261103000316.150d658d@jic23-hlaptop>
In-Reply-To: <tencent_0D8D61C20611EC56598A6F86E7B869052E05@qq.com>
References: <20261016094733.1898485-1-2118537295@qq.com>
 <tencent_0D8D61C20611EC56598A6F86E7B869052E05@qq.com>
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

On Fri, 16 Oct 2026 17:46:55 +0800
Jinjie Ruan <2118537295@qq.com> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Add the MPAM system registers for TCG: MPAMIDR_EL1 (RO) reporting 64
> PARTIDs and 4 PMGs, and MPAM0_EL1/MPAM1_EL1 (RW, of which only
> MPAM1_EL1.MPAMEN is architecturally reset). Advertise FEAT_MPAM via
> ID_AA64PFR0.MPAM for TCG CPUs.
> 
> It is common to support MPAM on CPU cores, but not in the rest of the
> system, so there is little disadvantage in always enabling these.
> 
> Based on an RFC series by Jonathan Cameron, adapted to the current
> idregs[] storage and access_tid3() naming.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Definitely wouldn't trust this guy :)  He took a few naughty short cuts.

> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index ff0b766..896ac0e 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6907,6 +6907,23 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>                .access = PL1_R, .type = ARM_CP_CONST,
>                .accessfn = access_tid3,
>                .resetvalue = cpu->isar.mvfr0 },
> +            { .name = "MPAMIDR_EL1", .state = ARM_CP_STATE_AA64,
> +              .opc0 = 3, .opc1 = 0, .crn = 0xa, .crm = 4, .opc2 = 4,
> +              .access = PL1_R, .type = ARM_CP_CONST,
> +              .accessfn = access_tid3,
> +              .resetvalue = cpu->isar.mpamidr_el1 },
> +            { .name = "MPAM0_EL1", .state = ARM_CP_STATE_AA64,
> +              .opc0 = 3, .opc1 = 0, .crn = 0xa, .crm = 5, .opc2 = 1,
> +              .access = PL1_RW, .type = ARM_CP_ALIAS,

Similar to patch 2 (I reviewed them backwards) not sure why 
I ever set this to ARM_CP_ALIAS.

> +              .accessfn = access_tid3,

Never trust code I bodged years ago :( Wrong trap. Now you
have the appropriate EL2 registers in next patch should use a trap
on the relevant bits being set there.  Will want to swap the patches
around for that to work I think.  Also possibly needs the EL3 trap
register defined.


> +              .fieldoffset = offsetof(CPUARMState, mpam0_el1),
> +            },
> +            { .name = "MPAM1_EL1", .state = ARM_CP_STATE_AA64,
> +              .opc0 = 3, .opc1 = 0, .crn = 0xa, .crm = 5, .opc2 = 0,
> +              .access = PL1_RW, .type = ARM_CP_ALIAS,
> +              .accessfn = access_tid3,
> +              .fieldoffset = offsetof(CPUARMState, mpam1_el1),
> +            },
>              { .name = "MVFR1_EL1", .state = ARM_CP_STATE_AA64,
>                .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 1,
>                .access = PL1_R, .type = ARM_CP_CONST,


