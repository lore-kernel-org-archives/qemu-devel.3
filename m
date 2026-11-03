Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA99606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 03:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BizRR2dX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO50n-0007Ac-B7; Mon, 02 Nov 2026 22:16:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO50k-00078i-Mv; Mon, 02 Nov 2026 22:16:34 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO50i-0004ow-VX; Mon, 02 Nov 2026 22:16:34 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5EA2C41830;
 Tue,  3 Nov 2026 03:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4A41F000C1;
 Tue,  3 Nov 2026 03:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793675791;
 bh=T+dY+qfFVzdYBgsUin6DDW6lMyWbrt2plzjL3SSW+4A=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=BizRR2dXfLS4Dya5RSFel4ot3Ekrabx5TVvqUKvo9kgSutiUbB8ilnRUA1l+3SapC
 V3fR0FaE/vgEIXZMd4KfKTXid/wdDIWf6dgCJR09Ox9zQqbu3vTni5UzW/g4yii3X6
 VwXnmrdYsNE+2go3T/BjpUawZOS4h02ryI2jg8lidNyrnHTzJEnFv8cOh9Yr3SXA+K
 QrJQDUpc8rz1yI6+TYbmUBOKF+UG67FMe+tggIv08z7siHfS/pn+7eI1K/PxdOZYEQ
 kstefqMr6FMPZ1g+AC/1qPnyu1WtyTHbcJLTiGr1alXQ+U4Q7rJTycXBgSAeoI+ynC
 s450qG5LmV/Kg==
Date: Tue, 3 Nov 2026 03:16:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, ruanjinjie@huawei.com
Subject: Re: [PATCH 27/37] hw/arm/mpam: Advertise PRI on memory-side MSCs
Message-ID: <20261103031622.787ae7c0@jic23-hlaptop>
In-Reply-To: <tencent_E465298E19C263CF95CFB481097FC4B25B07@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
 <tencent_E465298E19C263CF95CFB481097FC4B25B07@qq.com>
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

On Fri, 16 Oct 2026 18:10:47 +0800
Jinjie Ruan <2118537295@qq.com> wrote:

> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> The arm_mpam driver picks the MBA-backing class for the MBPRI
> pseudo-resource, which requires the memory-side MSC to advertise
> HAS_PRI_PART -- without it the driver never exposes MBPRI even
> though the register is handled.  Assemble the same PRI_IDR view
> (INTPRI, 2 bits, 0 = low) as the cache subtype.

Don't talk about driver in the qemu code except perhaps to say
it was tested with that driver.  In theory any random software
is expected to work on top of the qemu.

Otherwise feels like this could be pushed back to an earlier
patch that implemented the register support (and forgot
to set up the discovery bits?)

> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  hw/arm/mpam.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
> index 1bd76ba..50c8a8e 100644
> --- a/hw/arm/mpam.c
> +++ b/hw/arm/mpam.c
> @@ -991,6 +991,18 @@ static void mpam_msc_mem_realize(DeviceState *dev, Error **errp)
>          mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_MSMON, 1);
>          /* Memory specific bit */
>          mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_MBW_PART, 1);
> +        /*
> +         * Priority partitioning on the memory side too: the driver exposes
> +         * the MBPRI pseudo-resource from the class backing MBA, which
> +         * requires the memory-side MSC to advertise HAS_PRI_PART.
> +         */
> +        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_PRI_PART, 1);
> +        mpamf->pri_idr = FIELD_DP32(mpamf->pri_idr, MPAMF_PRI_IDR,
> +                                    HAS_INTPRI, 1);
> +        mpamf->pri_idr = FIELD_DP32(mpamf->pri_idr, MPAMF_PRI_IDR,
> +                                    INTPRI_0_IS_LOW, 1);
> +        mpamf->pri_idr = FIELD_DP32(mpamf->pri_idr, MPAMF_PRI_IDR,
> +                                    INTPRI_WD, 2);
>  
>          mpamf->msmon_idr = FIELD_DP32(mpamf->msmon_idr,
>                                        MPAMF_MSMON_IDR, MSMON_MBWU, 1);


