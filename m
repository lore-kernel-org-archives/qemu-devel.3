Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401F7606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 00:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UB10tJ0c
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO22M-0007LH-Mm; Mon, 02 Nov 2026 19:06:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO22J-0007KC-Rv; Mon, 02 Nov 2026 19:05:59 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO22I-0004Em-8X; Mon, 02 Nov 2026 19:05:59 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 51CF8415DD;
 Tue,  3 Nov 2026 00:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C5D1F000C1;
 Tue,  3 Nov 2026 00:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793664356;
 bh=8sjoZ5vfNPomUpJFjkSYx+iGYzjlVrZr6Y++397FUcs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=UB10tJ0cE1Q4BWnLy0UqiAMYEvInDmteS8/Gn1Zdtck+QXH5QNhf6fE6gm6D8A2ms
 wpLdxwdgMdgNQypdYWf90bRM42JVDpVB/u9CiLS8E333cCE2XFOuvhXT6eDyuW/OyE
 zkyWmiSSkMFS31RMykwTYVg7DU3NpOS0NEaXf4ecjDH+J7Vw+OGwfO3Qp0cbICfIpV
 189ICWniJrFaO6D373CZpUTFe0p9mVf/vuYe5eKkn/xADmFPzUUIje2bZIWd1ZtAVH
 GFTctemZXQjyfVjfesJIuE4mfWGcJA9yvbLctIR4d4N5mQau5crmxQk4ISu2QBxnXH
 vh/hZVBsAEwwA==
Date: Tue, 3 Nov 2026 00:05:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, ruanjinjie@huawei.com
Subject: Re: [PATCH 03/37] target/arm: Add MPAMSM_EL1 register
Message-ID: <20261103000550.1c2ae1f0@jic23-hlaptop>
In-Reply-To: <tencent_83B7D852163320C7882BE1690E1334883308@qq.com>
References: <20261016094733.1898485-1-2118537295@qq.com>
 <tencent_83B7D852163320C7882BE1690E1334883308@qq.com>
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

On Fri, 16 Oct 2026 17:46:57 +0800
Jinjie Ruan <2118537295@qq.com> wrote:

> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> FEAT_MPAM_SMS's MPAMSM_EL1 (S3_0_C10_C5_3) was missing, so a v7.x
> guest with SME enabled took an UNDEFINED instruction in
> cpu_enable_mpam(), which writes the register unconditionally when
> ARM64_SME is present. Register it backed by CPU state like the other
> MPAM registers, letting linux v7.x boot with -cpu max unmodified.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  target/arm/cpu.h    | 1 +
>  target/arm/helper.c | 6 ++++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 218923a..c60ec62 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -761,6 +761,7 @@ typedef struct CPUArchState {
>      uint64_t mpam1_el1;
>      uint64_t mpam2_el2;
>      uint64_t mpamhcr_el2;
> +    uint64_t mpamsm_el1;
>      /* Optional fault info across tlb lookup. */
>      ARMMMUFaultInfo *tlb_fi;
>  
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index d5d96d5..a9b1521 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6912,6 +6912,12 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>                .access = PL1_R, .type = ARM_CP_CONST,
>                .accessfn = access_tid3,
>                .resetvalue = cpu->isar.mpamidr_el1 },
> +            { .name = "MPAMSM_EL1", .state = ARM_CP_STATE_AA64,
> +              .opc0 = 3, .opc1 = 0, .crn = 0xa, .crm = 5, .opc2 = 3,
> +              .access = PL1_RW, .type = ARM_CP_ALIAS,
> +              .accessfn = access_tid3,
Same as previous.  Wrong trap. Also depends on SME being present, otherwise
this register needs hiding.  

FWIW claude at least is really good at giving at poking holes in these entries.
Other LLMs might be too.  Bunch of RES0 in this one as well.


> +              .fieldoffset = offsetof(CPUARMState, mpamsm_el1),
> +            },
>              { .name = "MPAM0_EL1", .state = ARM_CP_STATE_AA64,
>                .opc0 = 3, .opc1 = 0, .crn = 0xa, .crm = 5, .opc2 = 1,
>                .access = PL1_RW, .type = ARM_CP_ALIAS,


