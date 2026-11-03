Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18C5606A32C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 01:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=na4IbEky
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO31v-0003UY-0Z; Mon, 02 Nov 2026 20:09:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO31m-0003Rz-4q; Mon, 02 Nov 2026 20:09:30 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO31i-0001Q2-Rm; Mon, 02 Nov 2026 20:09:29 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B832D424B4;
 Tue,  3 Nov 2026 01:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4F11F000C1;
 Tue,  3 Nov 2026 01:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793668164;
 bh=PV5QpBKpOZZNcnr4a0mb/DrLKELegGRMuJzkS7CLRx0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=na4IbEkyyH3VfMBRaaeiGel9wSGaHT8A+oOvBmi5mOmw3PW3eJ/rZcykj27WcodvR
 UN1I+Nk5j3sM+dztRSo6/tNsHwx1/RQUncMgbzXEuA8xdZmxX1AxVUWYPWm/no0j0K
 drYTnUVKWlNt33em0km+Y/EMXpvP2OFxQlrfSh86b9hJsVO4Gqgpi5rUgUl924cf1Q
 ZNzotkMjMLEJBqC0rcSH970NS44qm6Zrrds6/ZfioNXss9M1OVBphc4O9wEbPxtEgr
 KSKti5KcWE6dcbXVVFjz44jR5ZELZWfBkbvidd2mnMpgmlUx8k6NU9Hw5OsLPtXlbd
 JnEFdEWWRHzIA==
Date: Tue, 3 Nov 2026 01:09:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, ruanjinjie@huawei.com
Subject: Re: [PATCH 08/37] hw/arm/mpam: Add mpam-msc-cache MSC subtype
Message-ID: <20261103010920.4e76f408@jic23-hlaptop>
In-Reply-To: <tencent_1A2B9A692313EC887BB7C152CC339DC74808@qq.com>
References: <20261016094733.1898485-1-2118537295@qq.com>
 <tencent_1A2B9A692313EC887BB7C152CC339DC74808@qq.com>
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

On Fri, 16 Oct 2026 17:47:02 +0800
Jinjie Ruan <2118537295@qq.com> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Add the mpam-msc-cache subtype for cache components, with the
> cache-level/cache-type/cpu properties the board uses to place the
> MSC in the cache topology.  Its realize assembles the cache
> identity view of MPAMF_IDR (same as the memory side, plus SP4=0
> for RME) and IIDR/AIDR; the CPOR/CCAP/PRI feature bits arrive
> with their respective partitioning patches.
> 
> Based on an RFC series by Jonathan Cameron.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Very similar comments to previous as you might expect.

> ---
>  hw/arm/mpam.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
> 
> diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
> index 8a85c3b..17ca286 100644
> --- a/hw/arm/mpam.c
> +++ b/hw/arm/mpam.c
> @@ -264,11 +264,22 @@ typedef struct MPAMMSCMemState {
>      MPAMMSCState parent;
>  } MPAMMSCMemState;
>  
> +typedef struct MPAMMSCCacheState {
> +    MPAMMSCState parent;
> +    uint8_t cache_level;
> +    uint8_t cache_type;
> +    uint16_t cpu;
> +
> +} MPAMMSCCacheState;
> +
>  DECLARE_INSTANCE_CHECKER(MPAMMSCState, MPAM_MSC_DEVICE, TYPE_MPAM_MSC);
>  
>  DECLARE_INSTANCE_CHECKER(MPAMMSCMemState, MPAM_MSC_MEM_DEVICE,
>                           TYPE_MPAM_MSC_MEM);
>  
> +DECLARE_INSTANCE_CHECKER(MPAMMSCCacheState, MPAM_MSC_CACHE_DEVICE,
> +                         TYPE_MPAM_MSC_CACHE);
> +
>  static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
>                                    unsigned size)
>  {
> @@ -420,12 +431,72 @@ static void mpam_msc_mem_realize(DeviceState *dev, Error **errp)
>      }
>  }
>  
> +static void mpam_msc_cache_realize(DeviceState *dev, Error **errp)
> +{
> +    MPAMMSCState *s = MPAM_MSC_DEVICE(dev);
> +    int i;
> +
> +    mpam_msc_realize(dev, errp);
> +
> +    for (i = 0; i < s->num_ris; i++) {
    for (int i = 0;...

> +        Mpamf *mpamf = &s->mpamf[i];
> +
> +        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, PART_ID_MAX,
> +                                s->num_partid - 1);
> +        /* No PCMG for now */
> +        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, PMG_MAX, 0);
> +        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, EXT, 1);
> +        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_RIS, s->num_ris > 1);
> +        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, RIS_MAX,
> +                                  s->num_ris > 1 ? s->num_ris - 1 : 0);
> +
> +        /* Optional - test with and without */

Same as before.

> +        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_ESR, 1);
> +        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_EXTD_ESR,
> +                                s->num_ris > 1);
> +
> +        /* We won't implement any implementation specific stuff */
> +        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, NO_IMPL_PART, 1);
> +        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, NO_IMPL_MSMON, 1);
> +
> +        /* Need to implement for RME */
> +        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, SP4, 0);
> +
> +        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_PARTID_NRW,
> +                                s->num_int_partid < s->num_partid);
> +
> +        mpamf->iidr = FIELD_DP32(mpamf->iidr, MPAMF_IIDR, IMPLEMENTER,
> +                                 MPAM_IIDR_IMPLEMENTER);
> +        mpamf->iidr = FIELD_DP32(mpamf->iidr, MPAMF_IIDR, REVISION, 0);
> +        mpamf->iidr = FIELD_DP32(mpamf->iidr, MPAMF_IIDR, VARIANT, 0);
> +        /* FIXME get allocation for this emulation */

Follow through from previous.

> +        mpamf->iidr = FIELD_DP32(mpamf->iidr, MPAMF_IIDR, PRODUCT_ID, 42);
> +
> +        mpamf->aidr = FIELD_DP32(mpamf->aidr, MPAMF_AIDR, ARCH_MINOR_REV, 1);
> +        mpamf->aidr = FIELD_DP32(mpamf->aidr, MPAMF_AIDR, ARCH_MAJOR_REV, 1);
> +
> +        if (s->num_int_partid < s->num_partid) {
> +            mpamf->partid_nrw_idr = FIELD_DP32(mpamf->partid_nrw_idr,
> +                                               MPAMF_PARTID_NRW_IDR,
> +                                               INTPARTID_MAX,
> +                                               s->num_int_partid - 1);
> +        }
> +        /* TODO: Initialize all on as if firmware had done it for us */
> +    }
> +}


