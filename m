Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D352606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 00:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gJqb0dgf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO2lM-0007Id-Ap; Mon, 02 Nov 2026 19:52:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO2lK-0007Hk-Cw; Mon, 02 Nov 2026 19:52:30 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO2lI-0008P6-Gp; Mon, 02 Nov 2026 19:52:30 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6B277438B3;
 Tue,  3 Nov 2026 00:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BB31F000C1;
 Tue,  3 Nov 2026 00:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793667146;
 bh=ZD+w7OB/pRfaKOn/8xKvLuFK63LtCoSfptrngXhMfpU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=gJqb0dgfOnCxHp3jY767ULpfx8AFoCQX2tZ+RfWGIqIeCmMX3ObHCxdZfT41aEvl6
 O9EvKHOsRe5RPreQFe75Cw6ibMLMaKmyyPxZlVQ+WGRmnpSMiaN4JWM+oI4kCLehcW
 EdosrAPpZ2kELA7ss4Wog12ISgSCkEczG4EyHOrXF3dBGc08uhWI2JoVTjx7fUM1tm
 3JGOPVpbuBHF9qovc5GUcU5VDrNpsa9pKb8yUZtY0PsbTQfZBGocqlYCctrzy8mrMw
 qYUy0T8wGEFXqaTZm71Px3fB36f/dKkIcGeB0cYbmpUzNQEmzz4G+igHBva7eb5U0Y
 /aFA6ODXL/b+Q==
Date: Tue, 3 Nov 2026 00:52:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, ruanjinjie@huawei.com
Subject: Re: [PATCH 06/37] hw/arm/mpam: Add MPAM MSC base device
Message-ID: <20261103005218.7d0a4a06@jic23-hlaptop>
In-Reply-To: <tencent_8C2C6D66A20C91FD7641EA7206ED18672505@qq.com>
References: <20261016094733.1898485-1-2118537295@qq.com>
 <tencent_8C2C6D66A20C91FD7641EA7206ED18672505@qq.com>
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

On Fri, 16 Oct 2026 17:47:00 +0800
Jinjie Ruan <2118537295@qq.com> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Add the mpam-msc sysbus device core:
> - Per-RIS register storage(Mpamf)
> - The device state (selector state, num-ris/num-partid/
>   num-int-partid properties), realize with the per-RIS allocation
>   and the MMIO region (MPAM_SIZE window).
> - The MMIO handlers covering the identification registers (MPAMF_IDR
>   with its 64-bit EXT view IIDR, AIDR, IMPL_IDR, PARTID_NRW_IDR
>   and the MSMON IDRs that read as zero until monitoring is implemented).
> 
> The base type registers no features; the mpam-msc-mem and
> mpam-msc-cache subtypes assemble their feature IDR fields.
> 
> Based on an RFC series by Jonathan Cameron.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

A few trivial things inline.

> ---
>  hw/arm/mpam.c | 171 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 171 insertions(+)
> 
> diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
> index 772a120..b1d6472 100644
> --- a/hw/arm/mpam.c
> +++ b/hw/arm/mpam.c
> @@ -221,3 +221,174 @@ REG32(MPAMF_MPAMCFG_MBW_PBM0, 0x2000)
>  #define MPAM_CACHE_PART 32
>  /* MPAMF_IIDR.IMPLEMENTER: ARM JEP106 code for Huawei (0x736). */
>  #define MPAM_IIDR_IMPLEMENTER 0x736
> +
> +typedef struct Mpamf {
> +    uint64_t idr;
> +    uint32_t iidr;
> +    uint32_t aidr;
> +    uint32_t impl_idr;
> +    uint32_t cpor_idr;
> +    uint32_t ccap_idr;
> +    uint32_t mbw_idr;
> +    uint32_t pri_idr;
> +    uint32_t partid_nrw_idr;
> +    uint32_t msmon_idr;
> +    uint32_t csumon_idr;
> +    uint32_t mbwumon_idr;
> +    uint32_t err_msi_mpam;
> +    uint32_t err_msi_addr_l;
> +    uint32_t err_msi_addr_h;
> +    uint32_t err_msi_data;
> +    uint32_t err_msi_attr;
> +    uint32_t ecr;
> +    uint32_t esr;
> +    uint32_t cfg_part_sel;
> +} Mpamf;
> +
> +typedef struct MPAMMSCState {
> +    SysBusDevice parent_obj;
> +
> +    Mpamf *mpamf;
> +
> +    uint8_t ris;
> +    uint16_t part_sel; /* Technically per ris, but in same reg */
> +    bool internal_part_sel;
> +    struct MemoryRegion mr;
> +    uint32_t num_partid;
> +    uint32_t num_int_partid;
> +    uint8_t num_ris;
> +

Blank line seems pointless. Probably belongs in some later patch.

> +} MPAMMSCState;
> +
> +DECLARE_INSTANCE_CHECKER(MPAMMSCState, MPAM_MSC_DEVICE, TYPE_MPAM_MSC);
> +
> +static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
> +                                  unsigned size)
> +{
> +    MPAMMSCState *s = MPAM_MSC_DEVICE(opaque);
> +    Mpamf *mpamf = &s->mpamf[s->ris];
> +
> +    switch (offset) {
> +    case A_MPAMF_IDR:
> +        switch (size) {
> +        case 4:
> +            return mpamf->idr & 0xffffffff;

Maybe use MAKE_64BIT_MASK(0, 32) from qemu/bitops.h


> +        case 8:
> +            return mpamf->idr;
> +        default:
> +            qemu_log_mask(LOG_UNIMP, "MPAM: Unexpected read size\n");
> +            return 0;
> +        }
> +    case A_MPAMF_IDR + 0x04:
> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, EXT)) {
> +            qemu_log_mask(LOG_UNIMP, "MPAM: Unexpected read of top of IDR\n");
> +            return 0;
> +        }
> +        switch (size) {
> +        case 4:
> +            return mpamf->idr >> 32;
> +        default:
> +            qemu_log_mask(LOG_UNIMP, "MPAM: Unexpected read size\n");
> +            return 0;
> +        }
> +    case A_MPAMF_IIDR:

Not sure why I allowed 1 byte reads. Probably want to check each of
the read widths for 4 or 8 though as appropriate.

> +        return mpamf->iidr;
> +    case A_MPAMF_AIDR:
> +        return mpamf->aidr;
> +    case A_MPAMF_IMPL_IDR:
> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_IMPL_IDR)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                "MPAM: Accessing IMPL_IDR which isn't suported\n");
> +            return 0;
> +        }
> +        return mpamf->impl_idr;
> +    case A_MPAMF_PARTID_NRW_IDR: {
> +        return mpamf->partid_nrw_idr;
> +    }
> +    case A_MPAMF_MSMON_IDR:
> +        return mpamf->msmon_idr;
> +    case A_MPAMF_CSUMON_IDR:
> +        return mpamf->csumon_idr;
> +    case A_MPAMF_MBWUMON_IDR:
> +        return mpamf->mbwumon_idr;
> +    default:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "MPAM: Unexpected read of %lx\n", offset);
> +        return 0x0;
> +    }
> +}

> +
> +static void mpam_msc_realize(DeviceState *dev, Error **errp)
> +{
> +    MPAMMSCState *s = MPAM_MSC_DEVICE(dev);
> +
> +    /* IHI 0099: MPAMF_CFG_PART_SEL.RIS is 4 bits, so at most 16 RIS. */

Hmm. I wonder if this changed name.  The spec now has MPAMCFG_PART_SEL.
Should match that naming I suppose.


> +    if (s->num_ris > 16) {
> +        error_setg(errp, "num-ris must be <= 16");
> +        return;
> +    }
> +    if (s->num_partid == 0) {
> +        error_setg(errp, "num-ris must be <= 16");
> +        return;
> +    }
> +    if (s->num_int_partid == 0) {
> +        s->num_int_partid = s->num_partid;
> +    }
> +
> +    s->mpamf = g_new0(Mpamf, s->num_ris);
> +    memory_region_init_io(&s->mr, OBJECT(s), &mpam_msc_ops, s, "mpam_msc",
> +                          MPAM_SIZE);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);
> +}



