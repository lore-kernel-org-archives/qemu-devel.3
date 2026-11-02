Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DC8606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 23:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jgbsJ7b+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO1st-0004jp-Jt; Mon, 02 Nov 2026 18:56:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO1sr-0004jN-KD; Mon, 02 Nov 2026 18:56:13 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO1sp-0003Fq-Q5; Mon, 02 Nov 2026 18:56:13 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EEBF140992;
 Mon,  2 Nov 2026 23:56:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DC81F00A16;
 Mon,  2 Nov 2026 23:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793663769;
 bh=UlnVSIGekdugrjNuiAUGJ9xAdqIfm3aJhEcFny3hnsk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=jgbsJ7b+LykHhq6HXNpqeD97GcvJbashnA2JJ4BelJAOTXR7lxE9BeFX0Hrgb6JZH
 BTZMz3ebq7vK1oYdTIR2L5plgqa5sWhH7DsD88lu1vlh9KNitBc5vVd6b9SeXHBvUZ
 WJOXjv8mJVBro3wgnn+0akTQ1cadSPv7pcMXSGBsMY4ymq+z4aHm34siBD49RyjGaM
 j3bMu9MDrKLu4EgFunpUyQ0oTKvfWm+Qzn1Rq7Nz700qvJZIzoaqe3PMFk4ldntvS/
 ZoBxsBKx7QbWl4ah2EbLtCJRcyUKQdnH2pWmN+wqDMAJptDWc/y/kKZjLt4YhnbvH+
 MQ6PoXv5ZOtDw==
Date: Mon, 2 Nov 2026 23:56:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, ruanjinjie@huawei.com
Subject: Re: [PATCH 02/37] target/arm: Add MPAM2_EL2 and MPAMHCR_EL2 registers
Message-ID: <20261102235603.09d7f535@jic23-hlaptop>
In-Reply-To: <tencent_44485284331CC7902B6C69F413CC882EB708@qq.com>
References: <20261016094733.1898485-1-2118537295@qq.com>
 <tencent_44485284331CC7902B6C69F413CC882EB708@qq.com>
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
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 16 Oct 2026 17:46:56 +0800
Jinjie Ruan <2118537295@qq.com> wrote:

> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> FEAT_MPAM's EL2 registers were missing, so a guest kernel that owns
> or drops out of EL2 takes an UNDEFINED exception the first time it
> runs its MPAM capability enable callback, which unconditionally
> clears MPAM2_EL2 (and MPAMHCR_EL2 when HAS_HCR is present).
> 
> Register both as normal EL2 read/write registers backed by CPU state.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  target/arm/cpu.h    |  2 ++
>  target/arm/helper.c | 10 ++++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 51a36fa..218923a 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -759,6 +759,8 @@ typedef struct CPUArchState {
>  
>      uint64_t mpam0_el1;
>      uint64_t mpam1_el1;
> +    uint64_t mpam2_el2;
> +    uint64_t mpamhcr_el2;
>      /* Optional fault info across tlb lookup. */
>      ARMMMUFaultInfo *tlb_fi;
>  
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 896ac0e..d5d96d5 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6924,6 +6924,16 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>                .accessfn = access_tid3,
>                .fieldoffset = offsetof(CPUARMState, mpam1_el1),
>              },
> +            { .name = "MPAM2_EL2", .state = ARM_CP_STATE_AA64,
> +              .opc0 = 3, .opc1 = 4, .crn = 0xa, .crm = 5, .opc2 = 0,
> +              .access = PL2_RW, .type = ARM_CP_ALIAS,

I've most forgotten how this stuff works (if I ever really knew!)
Why ARM_CP_ALIAS?  Probably just wants that dropped and provide
resetvalue = 0. 

Also, given emulation isn't yet supporting MPAM v2, there are a load
of res0 bits in here so we probably need a write mask.  There
are more complex things around what MPAM3_EL3 has in it but given
I don't think that is emulated yet, can probably just assume here
it is in it's most permissive state.

> +              .fieldoffset = offsetof(CPUARMState, mpam2_el2),
> +            },
> +            { .name = "MPAMHCR_EL2", .state = ARM_CP_STATE_AA64,
> +              .opc0 = 3, .opc1 = 4, .crn = 0xa, .crm = 4, .opc2 = 0,
> +              .access = PL2_RW, .type = ARM_CP_ALIAS,
> +              .fieldoffset = offsetof(CPUARMState, mpamhcr_el2),
> +            },
Similar for this one.

>              { .name = "MVFR1_EL1", .state = ARM_CP_STATE_AA64,
>                .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 1,
>                .access = PL1_R, .type = ARM_CP_CONST,


