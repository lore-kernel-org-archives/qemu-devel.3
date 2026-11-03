Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7203606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 02:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nRGsPq5m
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO4O7-0002QK-9M; Mon, 02 Nov 2026 21:36:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO4O0-0002O8-CA; Mon, 02 Nov 2026 21:36:32 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO4Ny-0000za-Da; Mon, 02 Nov 2026 21:36:32 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A11DB41FF2;
 Tue,  3 Nov 2026 02:36:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979FA1F0093A;
 Tue,  3 Nov 2026 02:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793673388;
 bh=ytsjIFTmUSbAN7iclB/jKZkLlJxce0iZAo1rczlHxUA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=nRGsPq5m12uc3zOinl6G+HtFJQ9N4jhvLAz3CV1pUbgycs+5TemMQDIRFeQ/QtjQf
 PWZtWIRMWbk+LCydMUpw8DW5bPHy3bc4CAR0e32QdjexXpdEvGCXoFw64Esz1DJBl6
 VY7dvgOVUF3sbBk12SU4+w9uzCkqdZO0lp86yQ0AYup+vAF33edesEsr6ywqcOVp4g
 XicRGA/IkEaDv4/OCMbmcI3QmfS4rqcSmEG2se0yQGPEM6XwlCUqQlIzrJX8sKGiBo
 twwpjevFDUPThdnhRe9EkuxWTKF2FTuRcLIGzPCCUm4F6lfQ6ygJq6f4qMnwjCskoz
 gMQc+TNkihnAA==
Date: Tue, 3 Nov 2026 02:36:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, ruanjinjie@huawei.com
Subject: Re: [PATCH 22/37] hw/acpi: Add MPAM table MSC node builders
Message-ID: <20261103023621.3993e3d7@jic23-hlaptop>
In-Reply-To: <tencent_9B35CD72A206F1E676456A66E6F898612505@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
 <tencent_9B35CD72A206F1E676456A66E6F898612505@qq.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=jic23@kernel.org;
 helo=sea.source.kernel.org
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

On Fri, 16 Oct 2026 18:10:42 +0800
Jinjie Ruan <2118537295@qq.com> wrote:

> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Add the DEN0065 MSC node builders for the MPAM table: the
> interrupt entry (flags 0 = wired, level per Table 5; GSIV 0 means
> not present) and the memory-controller and cache-controller node
> layouts (fixed 72-byte header plus one 24-byte resource node per
> RIS, MAX_NRDY_USEC 100) with the matching locators (proximity
> domain for memory, PPTT cache id for caches).
> 
> Static helpers; wired into the generated table by the next patch.

Is it worth having them separate?  I'd combine the two patches.
Not large enough to be worth keeping separate.


> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Trivial stuff only.
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  hw/arm/virt-acpi-build.c | 130 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 130 insertions(+)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index d368913..871ee45 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c

> +/*
> + * DEN0065 4.0: an MSC node is a 72-byte fixed header plus one 24-byte
> + * resource node per RIS.  MAX_NRDY_USEC 100 is the default ready-time.
> + */
> +#define MPAM_MSC_NODE_HDR_LEN   72
> +#define MPAM_MSC_RIS_ENTRY_LEN   24
> +#define MPAM_MSC_MAX_NRDY_USEC  100
Intents of numbers don't seem to be very consistent. 

> +
> +static void build_msc_memory_controller(GArray *table_data, int identifier,
> +                                        hwaddr base_addr, uint32_t mpam_id,
> +                                        int num_ris, uint64_t *nodes,
> +                                        uint32_t oflow_gsiv,
> +                                        uint32_t err_gsiv)
> +{
> +    int length = MPAM_MSC_NODE_HDR_LEN + MPAM_MSC_RIS_ENTRY_LEN * num_ris;
> +    int i;
> +
> +    build_append_int_noprefix(table_data, length, 2);
> +    /* Interface Type */
> +    build_append_int_noprefix(table_data, 0 /* MMIO */, 1);
> +    /* Reserved */
> +    build_append_int_noprefix(table_data, 0, 1);
> +    build_append_int_noprefix(table_data, identifier, 4);
> +    build_append_int_noprefix(table_data, base_addr, 8);
> +    build_append_int_noprefix(table_data, MPAM_SIZE, 4);
> +    /* Overflow interrupt */
> +    build_msc_interrupt(table_data, oflow_gsiv);
> +    /* Reserved */
> +    build_append_int_noprefix(table_data, 0, 4);
> +    /* Overflow Int Affinity */
> +    build_append_int_noprefix(table_data, 0, 4);
> +    /* Error interrupt */
> +    build_msc_interrupt(table_data, err_gsiv);
> +    /* More reserved */
> +    build_append_int_noprefix(table_data, 0, 4);
> +    /* Error Int Affinity */
> +    build_append_int_noprefix(table_data, 0, 4);

I guess if we want to try more fun corners of the mpam
spec at some point we'll want to enable controlling the
interrupt affinities. 



> +    /* MAX_NRDY_USEC */
> +    build_append_int_noprefix(table_data, MPAM_MSC_MAX_NRDY_USEC, 4);
> +    /* Linked Device - none for now */

Maybe document this is the _HID if there is a linked device
and zero otherwise.

> +    build_append_int_noprefix(table_data, 0, 8);
> +    /* _UID of linked device */
> +    build_append_int_noprefix(table_data, 0, 4);
> +    build_append_int_noprefix(table_data, num_ris, 4);
> +    /* Build a memory controller resource */
> +    for (i = 0; i < num_ris; i++) {

      for (int i = 0; ...

> +        build_append_int_noprefix(table_data, mpam_id, 4);
> +        build_append_int_noprefix(table_data, i, 1);
> +        /* Reserved1 */
> +        build_append_int_noprefix(table_data, 0, 2);
> +        /* Locator type - 1 = Memory */
> +        build_append_int_noprefix(table_data, 1, 1);
> +        /* Locator part 1 Node */
> +        build_append_int_noprefix(table_data, nodes[i], 8);
> +        /* Locator part 2 reserved */
> +        build_append_int_noprefix(table_data, 0, 4);
> +        /* Num functional dependencies */
> +        build_append_int_noprefix(table_data, 0, 4);
> +    }
> +}


