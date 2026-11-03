Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07894606A326
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 01:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h2dK9LiV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO2xt-00026Y-Nc; Mon, 02 Nov 2026 20:05:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO2xm-00025I-Ms; Mon, 02 Nov 2026 20:05:24 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO2xi-00012H-RV; Mon, 02 Nov 2026 20:05:21 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F066B6020A;
 Tue,  3 Nov 2026 01:05:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0921F000C1;
 Tue,  3 Nov 2026 01:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793667916;
 bh=nId63MjpjoN6RdXfGKmGO6QkKsRTmSWc8SQ2wT3PBds=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=h2dK9LiVVN+SB2ht0KfTA3py2z/wpPfdvTK2sSHl/zRXLCnPQG6fS9JxgiHPLOHSB
 iX7vR6CpHt50VO6VpXy53pcYD9GioGGjBdcy48xRcErQdKPb3Qd7XPi8aza8R8XCXC
 CLk4rTbwkZP6F3v5wW5FW8AUUpqaFpEXLaKE0hg3vSw8MXWZN1u+3Jz9l/PrIiKvAb
 sYpolW4JUo2eZSfFIEPvVlpYMTiKlyRf0FugbNXSgUnm14SMEm/yIvc7hiS4g8zQDj
 vuaisNgI6VvpDqNXjCLc+PJzRrJwhLOSrUAoaBMtGl9uOEfFoW2krcOwinDDC6Sw3g
 BPjgr8rnlAY7A==
Date: Tue, 3 Nov 2026 01:05:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, ruanjinjie@huawei.com
Subject: Re: [PATCH 07/37] hw/arm/mpam: Add mpam-msc-mem memory-side MSC
 subtype
Message-ID: <20261103010508.4e123573@jic23-hlaptop>
In-Reply-To: <tencent_2A6A4523CD66C21191EC56406A7866E2B805@qq.com>
References: <20261016094733.1898485-1-2118537295@qq.com>
 <tencent_2A6A4523CD66C21191EC56406A7866E2B805@qq.com>
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
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 16 Oct 2026 17:47:01 +0800
Jinjie Ruan <2118537295@qq.com> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Add the mpam-msc-mem subtype for memory-side components.  Its
> realize assembles the identity view of MPAMF_IDR (PARTID space,
> optional RIS support, HAS_ESR/HAS_EXTD_ESR, HAS_PARTID_NRW when
> the internal PARTID space is smaller) plus IIDR/AIDR, and
> advertises no partitioning features yet: the bandwidth controls
> come with the MBW patch.
> 
> Based on an RFC series by Jonathan Cameron.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Just some minor comments, mostly about comments I left lying around
that I now don't see any purpose in keeping.


> ---
>  hw/arm/mpam.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
> index b1d6472..8a85c3b 100644
> --- a/hw/arm/mpam.c
> +++ b/hw/arm/mpam.c
> @@ -260,8 +260,15 @@ typedef struct MPAMMSCState {
>  
>  } MPAMMSCState;
>  
> +typedef struct MPAMMSCMemState {
> +    MPAMMSCState parent;
> +} MPAMMSCMemState;
> +
>  DECLARE_INSTANCE_CHECKER(MPAMMSCState, MPAM_MSC_DEVICE, TYPE_MPAM_MSC);
>  
> +DECLARE_INSTANCE_CHECKER(MPAMMSCMemState, MPAM_MSC_MEM_DEVICE,
> +                         TYPE_MPAM_MSC_MEM);
> +
>  static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
>                                    unsigned size)
>  {
> @@ -367,6 +374,52 @@ static void mpam_msc_realize(DeviceState *dev, Error **errp)
>      sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);
>  }
>  
> +static void mpam_msc_mem_realize(DeviceState *dev, Error **errp)
> +{    MPAMMSCState *s = MPAM_MSC_DEVICE(dev);
> +    int i;
> +
> +    mpam_msc_realize(dev, errp);
> +
> +    for (i = 0; i < s->num_ris; i++) {
    for (int i = 0; ..

> +        Mpamf *mpamf = &s->mpamf[i];
> +
> +        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, PART_ID_MAX,
> +                                s->num_partid - 1);
> +        /* No PCMG for now */
> +        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, PMG_MAX, 0);
> +        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, EXT, 1);

I guess if being flexible this would emulate with and without
EXT, but meh, not sure it adds much value.

> +        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_RIS, s->num_ris > 1);
> +        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, RIS_MAX,
> +                                  s->num_ris > 1 ? s->num_ris - 1 : 0);
> +         /* Optional - test with and without */

Should drop that comment, or add the ability to test with and without
- honestly I'm not sure which field that was even referring too as
kind of applies to all the HAS_ ones.


> +        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_ESR, 1);
> +        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_EXTD_ESR, 1);
> +        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_PARTID_NRW,
> +                                s->num_int_partid < s->num_partid);
> +
> +        /* We won't implement any implementation specific stuff */
> +        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, NO_IMPL_PART, 1);
> +        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, NO_IMPL_MSMON, 1);
> +
> +        mpamf->iidr = FIELD_DP64(mpamf->iidr, MPAMF_IIDR, IMPLEMENTER,
> +                                 MPAM_IIDR_IMPLEMENTER);
> +        mpamf->iidr = FIELD_DP64(mpamf->iidr, MPAMF_IIDR, REVISION, 0);
> +        mpamf->iidr = FIELD_DP64(mpamf->iidr, MPAMF_IIDR, VARIANT, 0);
> +        /* FIXME get allocation for this emulation */

That still needs fixing before this can be merged. If sticking to Hisilicon
implementer, need to get one set aside so it is never real hardware - just
in case we run into problems.

Or... Use implementer 0 which is reserved for software use on CPUs and
hence I assume is fine here?  Maybe then set the product ID to 'Q' like
the gicv2m emulation does?


> +        mpamf->iidr = FIELD_DP64(mpamf->iidr, MPAMF_IIDR, PRODUCT_ID, 42);

:)  I was clearly having one of those sorts of days.

> +
> +        mpamf->aidr = FIELD_DP64(mpamf->aidr, MPAMF_AIDR, ARCH_MINOR_REV, 1);
> +        mpamf->aidr = FIELD_DP64(mpamf->aidr, MPAMF_AIDR, ARCH_MAJOR_REV, 1);
> +
> +        if (s->num_int_partid < s->num_partid) {
> +            mpamf->partid_nrw_idr = FIELD_DP32(mpamf->partid_nrw_idr,
> +                                               MPAMF_PARTID_NRW_IDR,
> +                                               INTPARTID_MAX,
> +                                               s->num_int_partid - 1);
> +        }
> +    }
> +}


