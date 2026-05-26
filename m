Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901F2CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 09:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRoCG-00039U-Tx; Tue, 26 May 2026 05:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wRoCF-00039D-Ja
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:35:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wRoCE-0005ez-1N
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779788133;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CX6stQxWTq4DSc9tz0ICUvcs2EXqQQ/sJ+r7aB/Xf1I=;
 b=Dib2DPQjxKzg70vWh7hSlL3LI1RgUY2S8W0p3clNC+mtZA7QNAIivHGLorV8M/MxHh6slr
 OF5tCYlSm9Q9BPRPwIiQKGbfZQZZi/irgpRl+vUL9vQOdfA2At1LOPCWWYSidYuaeaSWDE
 UaW/OI7s0sIMxF+p3Lp8ZdbiwETtPXA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-wQ9wcsZvMuOXQKsyMB3syw-1; Tue, 26 May 2026 05:35:31 -0400
X-MC-Unique: wQ9wcsZvMuOXQKsyMB3syw-1
X-Mimecast-MFC-AGG-ID: wQ9wcsZvMuOXQKsyMB3syw_1779788131
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-44f65835b77so7574771f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 02:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779788130; x=1780392930;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CX6stQxWTq4DSc9tz0ICUvcs2EXqQQ/sJ+r7aB/Xf1I=;
 b=nYEJB7IrGRoV2qsqScce4zPbwqaTYmoI+WOAqXFAc/tChpoi2MUQA3jp57MsMAaef3
 6geOJ+RFYlEao3JalLS5M9BFjL5wsEue3VVDqv1u3uLX+N0NuYc/HO/kMu/D1sETngSz
 Pgv/NpPty4XWrrZNFba8EB7B6K0IYkr0bF65BZuy+yYrwT42rk9fP0bhsvn0khxNpkFn
 Gz5eT+4p4roKjBSu1iKxJ8QHklSqfuNrjxYnHShI5j4a4Kb3C+pWouF+apw0wWzrfd1c
 Pz2nN6bGAcYe+gK2XE/Q8HhXgs7YY8otwsULn7w4+LwfDc7CI47nbNb58VrM5uFOFGR5
 yERQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9dkiy9W+beXU0Iuc2Cv6y9a7mIB8cBcNOpAuB8uIA508aaRfcj/5DRZvZi5PlnRcG1UeYrJ6rw94wu@nongnu.org
X-Gm-Message-State: AOJu0YzNzmeO/NUIg47nI88vWt/ol6MCeXmOE6sHts8JFRZyZ1o6jzFb
 Bss/7UUfYeEiorRQwlHE15hZIXmClVMEP7CKoh3GOHTvvtcqC7gZry1hoGYjENMwZUxet+DpSrw
 S2hrCEZJntWe4hHSJb+S42SeFS+nynS4s7X/3pOMDaNlSE84HQsOLIEs+
X-Gm-Gg: Acq92OGYEJaVD+GaYs+OLIVPs+o/5ON7CeZHobcYUrgTvxdvcHQkgFKuudosd5rbJEh
 ytmPXi5sgeQpKnPKcOIvEeBTdDuB4Q3bbWPZo6H7hKuVpyK0b0aqYvp1NNtPljyva5dFWaHBhBP
 hF8jBX4HdT8DgdmsC8HuvgW3QBcreUG48Elf1p+pNzFr7A6RF+xbQj2T1Cg8zo5Wk3JkcWonEZy
 VEAz2r46VB2Wa9D5pFCu2DaxmwcgRzxt4HVmWciO8eT1ZOJ4ULYCwB6HxogESgHL3eX6CfR7LKR
 CT+sX1Sr5EhX3Cvycck6zz/mvrlKeT6gI/4NTDN4B6HfKH6mZjcbOQgvP4sBKRLtwRC8QQ5L2st
 bYqhZTlHkUqsDsOOwJXYnGR6SmXm8RB6ZxC3m4pOYF4BQPEhxLkL17GxzW7EeZWhJczJgKA==
X-Received: by 2002:a05:600c:314e:b0:490:4ee0:82f9 with SMTP id
 5b1f17b1804b1-4904ee08766mr249598775e9.7.1779788130437; 
 Tue, 26 May 2026 02:35:30 -0700 (PDT)
X-Received: by 2002:a05:600c:314e:b0:490:4ee0:82f9 with SMTP id
 5b1f17b1804b1-4904ee08766mr249598125e9.7.1779788129919; 
 Tue, 26 May 2026 02:35:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454a0cd5sm380605195e9.10.2026.05.26.02.35.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 02:35:29 -0700 (PDT)
Message-ID: <12bc6dd2-2ef0-453d-bd49-2776dbda63be@redhat.com>
Date: Tue, 26 May 2026 11:35:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 27/32] hw/arm/tegra241-cmdqv: Limit queue size based on
 backend page size
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, zhenzhong.duan@intel.com, kjaju@nvidia.com,
 phrdina@redhat.com
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
 <20260519103727.899332-28-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260519103727.899332-28-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shameer,

On 5/19/26 12:37 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> CMDQV HW reads guest queue memory by its host physical address set
> up via IOMMUFD. This requires the guest queue to be contiguous in
> both guest PA and host PA space. With Tegra241 CMDQV enabled, we
> must only advertise a command queue size (CMDQS) that the host can
> safely back with physically contiguous memory. Allowing a queue size
> larger than the host page size could cause the hardware to DMA across
> page boundaries, leading to faults.
>
> Use qemu_ram_backend_pagesize_min() to find the smallest memory-
> backend page size in use, then cap IDR1.CMDQS so the guest cannot
> configure a command queue that exceeds that contiguous backing.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/tegra241-cmdqv.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> index ad64f06260..7f617bcc97 100644
> --- a/hw/arm/tegra241-cmdqv.c
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -16,6 +16,8 @@
>  #include "hw/arm/smmuv3-common.h"
>  #include "hw/core/irq.h"
>  #include "smmuv3-accel.h"
> +#include "smmuv3-internal.h"
> +#include "system/ramblock.h"
>  #include "tegra241-cmdqv.h"
>  #include "trace.h"
>  
> @@ -856,6 +858,8 @@ free_viommu:
>  static void tegra241_cmdqv_init_regs(SMMUv3State *s, Tegra241CMDQV *cmdqv)
>  {
>      int i;
> +    size_t pgsize;
> +    uint32_t val;
>  
>      cmdqv->config = V_CONFIG_RESET;
>      cmdqv->param = FIELD_DP32(0, PARAM, CMDQV_VER, CMDQV_VER);
> @@ -887,6 +891,19 @@ static void tegra241_cmdqv_init_regs(SMMUv3State *s, Tegra241CMDQV *cmdqv)
>          cmdqv->vcmdq_base[i] = 0;
>          cmdqv->vcmdq_cons_indx_base[i] = 0;
>      }
> +
> +    /*
> +     * CMDQ must not cross a physical RAM backend page. Adjust CMDQS so the
> +     * queue fits entirely within the smallest backend page size, ensuring
> +     * the command queue is physically contiguous in host memory.
> +     *
> +     *   IDR1.CMDQS = log2(max_qsz) - entry_shift
> +     *
> +     * where entry_shift = 4 (each CMDQ entry is 16 bytes = 2^4).
> +     */
> +    pgsize = qemu_ram_backend_pagesize_min();
OK I see this is done at init size before we know the GPA. But I meant
you may end up with a page size that is suboptimal, no?

Could you elaborate on the actual requirements with regards to huge page
usage in this patch and in the cover letter?

Thanks

Eric


> +    val = FIELD_EX32(s->idr[1], IDR1, CMDQS);
> +    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, CMDQS, MIN(ctz64(pgsize) - 4, val));
>  }
>  
>  static void tegra241_cmdqv_reset(SMMUv3State *s)


