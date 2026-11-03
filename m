Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC19C606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 01:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CzZBimwY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO3W7-0003bb-6A; Mon, 02 Nov 2026 20:40:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO3W4-0003au-Nv; Mon, 02 Nov 2026 20:40:48 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO3W3-0004Yq-7K; Mon, 02 Nov 2026 20:40:48 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2389D6021A;
 Tue,  3 Nov 2026 01:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612E81F0093A;
 Tue,  3 Nov 2026 01:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793670045;
 bh=lbdx40UfQhFd2JeRhdVyDgI/Odu4bhkdAcvKvgdxTQo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=CzZBimwYOyj03n+/Hzc16s4NjF+8kr7l+V+eh9/o1qHsERRFig5b+8Jy16JoYqb5K
 Q2cdH6PQ92rtOHcw2QppMKzoxkUFI4JwRLPGxe0wNLgNb1NY0xKzfZeq1XIgkZdb5u
 xAr+yIrFGwZ5DdAHQiSwTJKWzj7bBdyyoenItA/wgoy6tHlcr+4Rw3ZgaxS1v6OFnk
 GZcx0FdxGGa2ZWDWQaioKjmPozyIpZHOkfeDhO0ujctB6Y8N3uNtmL4r/cIZHPT2wo
 NzdtoZMT+h7E/wqLhsmdOyrmpBh6l1xIFomu0f9iCXYNUD7Ux/Zgk8huecbaMSB8rE
 uDFICIRLviz8Q==
Date: Tue, 3 Nov 2026 01:40:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, ruanjinjie@huawei.com
Subject: Re: [PATCH 14/37] hw/arm/mpam: Implement CCAP capacity partitioning
Message-ID: <20261103014039.39879da4@jic23-hlaptop>
In-Reply-To: <tencent_BD96274E101F6E25A4DA661A8FB55764D209@qq.com>
References: <20261016094733.1898485-1-2118537295@qq.com>
 <tencent_BD96274E101F6E25A4DA661A8FB55764D209@qq.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=jic23@kernel.org;
 helo=tor.source.kernel.org
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

On Fri, 16 Oct 2026 17:47:08 +0800
Jinjie Ruan <2118537295@qq.com> wrote:

> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Add the cache-capacity controls: MPAMF_CCAP_IDR (4-bit CMAX/CASSOC
> band widths, HAS_CMIN/HAS_CASSOC advertised ahead of their storage,

bandwidths 

> CMAX soft-limit support) with HAS_CCAP_PART on the cache subtype,
> and read/write handling for MPAMCFG_CMAX per selected internal
> PARTID, guarded on CCAP support.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
One trivial inline otherwise fine
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  hw/arm/mpam.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)

> @@ -701,6 +724,20 @@ static void mpam_msc_cache_realize(DeviceState *dev, Error **errp)
>          mpamf->pri_idr = FIELD_DP32(mpamf->pri_idr, MPAMF_PRI_IDR,
>                                      INTPRI_WD, 2);
>  
> +        /* Capacity Partitioning */
> +        mpamf->ccap_idr = FIELD_DP32(mpamf->ccap_idr, MPAMF_CCAP_IDR,
> +                                     HAS_CMAX_SOFTLIM, 1);
> +        mpamf->ccap_idr = FIELD_DP32(mpamf->ccap_idr, MPAMF_CCAP_IDR,
> +                                     NO_CMAX, 0);
> +        mpamf->ccap_idr = FIELD_DP32(mpamf->ccap_idr, MPAMF_CCAP_IDR,
> +                                     HAS_CMIN, 1);
> +        mpamf->ccap_idr = FIELD_DP32(mpamf->ccap_idr, MPAMF_CCAP_IDR,
> +                                     HAS_CASSOC, 1);
> +        mpamf->ccap_idr = FIELD_DP32(mpamf->ccap_idr, MPAMF_CCAP_IDR,
> +                                     CASSOC_WD, 4); /* Not much flex on this */

Any idea what I meant by that comment? I've no idea.  Probably drop it
- it might just have been me musing about the MPAM spec.

> +        mpamf->ccap_idr = FIELD_DP32(mpamf->ccap_idr, MPAMF_CCAP_IDR,
> +                                     CMAX_WD, 4);
> +
>          if (s->num_int_partid < s->num_partid) {
>              mpamf->partid_nrw_idr = FIELD_DP32(mpamf->partid_nrw_idr,
>                                                 MPAMF_PARTID_NRW_IDR,


