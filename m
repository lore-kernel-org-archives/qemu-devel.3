Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15316CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 17:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL2oO-0006pO-Cl; Thu, 07 May 2026 13:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wL2ny-0006no-JY
 for qemu-devel@nongnu.org; Thu, 07 May 2026 13:46:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wL2nt-0000Io-Rn
 for qemu-devel@nongnu.org; Thu, 07 May 2026 13:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778175988;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dfJnsjebBg1BZSbDgvQmLgtyPOTjP2vW5b+Dxub9Rzc=;
 b=OjwZC7NC+eTEtTgVcV8TeYmvxtcS/RXkYUN+nQl+UOpL4dNqFYwzkH+I+DRMNWqHvjsZLK
 IkkLvmwLb9mlC2p1TZm48hw8DehUbO6bPSoPJPepznCo7TVWxCItyJmM8ihSXsst1pyKIC
 PvrFqg7+cpv+G3p9r2IWyq7eqIQkjC8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-6KxpQduMNViceJ4OGGSYTw-1; Thu, 07 May 2026 13:46:26 -0400
X-MC-Unique: 6KxpQduMNViceJ4OGGSYTw-1
X-Mimecast-MFC-AGG-ID: 6KxpQduMNViceJ4OGGSYTw_1778175985
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43d789cebcfso1580887f8f.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 10:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778175985; x=1778780785;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dfJnsjebBg1BZSbDgvQmLgtyPOTjP2vW5b+Dxub9Rzc=;
 b=rAIos+sB2pV9gUghXV5nyHIRwFTCaY+PmjKuD7CGisV+Mxvs+L/hrbiumtL/g4Ncq7
 adg5T4w4iz0ctCpcsbxVlmHttspsvPOKBbMoIVre7g/IIeEOKNuDqAAKT55wz1M0N+me
 QywJ/QB+djIZP14/6qOpqE3c9waysWWGay+V5Cu+0N9ajaPz80SzYxwVOEZaJoWhYJU9
 aICTiDwk9alXwIqcWdFewmTZNlSb7uQFe5D1BRdeUH6A4NFIHDYE8Q4NeufMysEb6XeH
 R3umWHzb4Qg//cCJfnLv3VRdyMxCEssuQ4fG0bjXtbJSYMKNhLxf2YxvfIW0tW8UYJvR
 mWXQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+O5sYKNtCLJksHtqE7oTQ8WCa/pMOId/t9zsAd1YSnvBftDY2vIyLH8u74qBkQ2sl4r2gfL3lCXs09@nongnu.org
X-Gm-Message-State: AOJu0YzqO4OL27eQI/75iyysMLt2FrNZpgtDTUCvbGHoyzEl1fucljuG
 CsyTk8zhWXX74UURochCjdL/yp9H1QbE16puRyW6FVtsCLEe6IQV1ptfi9JsXSCFHxUVPYnrYuN
 laV2jw/dcKQJeuXhkRUCUuVPm/LTEtdBLKrWfRt1yNXBkPbCjvc+pY3T9
X-Gm-Gg: AeBDieunE4oxnVqSYn89ctn/uCp4aCR/JW6j/dDq2KYf94tnMlJg0Xh1yH0cH9F5XHP
 eHaqUb9Gpj5849xYFiTwQNDWITCqUG/nyZ2VB4tZ/LMKGiQZm1+Z2SQIqnlDMrDC/wlwZTs1Mug
 cPe733ptI98dmlihev9SCsc2749VREIbITcBjwZtRN1KUkwuP0qzO90tUxXchNyevX1olC6cw2v
 nlDrkQPDNqgvVZfdcsqKlG4ztY+3Q4aZqVbgSQWB82GQQb26flNg+wVd67IFPTSFpaz0EbI8O0V
 9txDbrARIq6aMneUEMHx3mqypIVwvb02wmiYXNICp0c9/8IkoCCsgdPO3kfAVH1ZnvBLSfbDjSQ
 gYiJ48zqZEi33H6u/3huYuGgIH2ZcDDb4NVMf6QpqAyUQuGajG7hCdxAs1ZzDHCZQ0SA+Tw==
X-Received: by 2002:a05:600c:3e86:b0:48a:5339:a46 with SMTP id
 5b1f17b1804b1-48e5dffabcamr57745295e9.9.1778175984668; 
 Thu, 07 May 2026 10:46:24 -0700 (PDT)
X-Received: by 2002:a05:600c:3e86:b0:48a:5339:a46 with SMTP id
 5b1f17b1804b1-48e5dffabcamr57744935e9.9.1778175984219; 
 Thu, 07 May 2026 10:46:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538fad5fsm152650415e9.10.2026.05.07.10.46.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 10:46:23 -0700 (PDT)
Message-ID: <1aff7150-f514-45b0-93ca-24838cabbb34@redhat.com>
Date: Thu, 7 May 2026 19:46:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] hw/arm/smmuv3-accel: Add helper for resolving auto
 parameters
Content-Language: en-US
To: Nathan Chen <nathanc@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20260422204335.23116-1-nathanc@nvidia.com>
 <20260422204335.23116-2-nathanc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260422204335.23116-2-nathanc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

Hi Nathan,

On 4/22/26 10:43 PM, Nathan Chen wrote:
> Introduce smmuv3_accel_auto_finalise() to resolve properties that are
> set to 'auto' for accelerated SMMUv3. This helper function allows
> properties such as ats, ril, ssidsize, and oas support to be resolved
> from host IOMMU capabilities via IOMMU_GET_HW_INFO.
>
> The later commits in this series set the auto_mode flag to true when
> an accel SMMUv3 property value is explicitly set to 'auto', or if the
> property value is not set and defaults to auto mode.
>
> Setting these property values to 'auto' requires at least one
> cold-plugged device to retrieve and finalise these properties. If the
> auto_mode flag is true, register a machine_init_done notifier to
> verify this requirement and fail boot if it is not met.
>
> Hot-plugged devices into an accel SMMUv3-associated bus will re-use
> the resolved host values from the initial cold-plug.
>
> Subsequent patches will make use of this helper to resolve 'auto' to
> what is reported by host IOMMU capabilities.
>
> Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/smmuv3-accel.c   | 43 +++++++++++++++++++++++++++++++++++++++++
>  hw/arm/smmuv3-accel.h   |  2 ++
>  include/hw/arm/smmuv3.h |  2 ++
>  3 files changed, 47 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 65c2f44880..8b3bbf3ef6 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -18,6 +18,7 @@
>  
>  #include "smmuv3-internal.h"
>  #include "smmuv3-accel.h"
> +#include "system/system.h"
>  
>  /*
>   * The root region aliases the global system memory, and shared_as_sysmem
> @@ -35,11 +36,32 @@ static int smmuv3_oas_bits(uint32_t oas)
>      return map[oas];
>  }
>  
> +static void smmuv3_accel_auto_finalise(SMMUv3State *s,
> +                                       struct iommu_hw_info_arm_smmuv3 *info) {
> +    SMMUv3AccelState *accel = s->s_accel;
> +
> +    /*
> +     * Return if 'auto' was not set for any accel SMMUv3 property, or
> +     * if property values were already resolved from a previous call
> +     * to this function (e.g. if this function was called again after
> +     * VM boot during device hot plug). We do not accept new property
> +     * values in this case where auto_finalised == true, and we re-use
> +     * the values determined from the initial cold plug.
> +     */
> +    if (!accel->auto_mode || accel->auto_finalised) {
> +        return;
> +    }
> +
> +    accel->auto_finalised = true;
> +}
> +
>  static bool
>  smmuv3_accel_check_hw_compatible(SMMUv3State *s,
>                                   struct iommu_hw_info_arm_smmuv3 *info,
>                                   Error **errp)
>  {
> +    smmuv3_accel_auto_finalise(s, info);
> +
>      /* QEMU SMMUv3 supports both linear and 2-level stream tables */
>      if (FIELD_EX32(info->idr[0], IDR0, STLEVEL) !=
>                  FIELD_EX32(s->idr[0], IDR0, STLEVEL)) {
> @@ -917,6 +939,22 @@ static void smmuv3_accel_as_init(SMMUv3State *s)
>      address_space_init(shared_as_sysmem, &root, "smmuv3-accel-as-sysmem");
>  }
>  
> +static void smmuv3_machine_done(Notifier *notifier, void *data)
> +{
> +    SMMUv3State *s = container_of(notifier, SMMUv3State, machine_done);
> +    SMMUv3AccelState *accel = s->s_accel;
> +
> +    if (!s->accel) {
> +        return;
> +    }
> +
> +    if (accel->auto_mode && !accel->auto_finalised) {
> +        error_report("arm-smmuv3 accel=on with 'auto' properties requires "
> +                     "at least one cold-plugged VFIO device");
> +        exit(1);
> +    }
> +}
> +
>  void smmuv3_accel_init(SMMUv3State *s)
>  {
>      SMMUState *bs = ARM_SMMU(s);
> @@ -924,4 +962,9 @@ void smmuv3_accel_init(SMMUv3State *s)
>      s->s_accel = g_new0(SMMUv3AccelState, 1);
>      bs->iommu_ops = &smmuv3_accel_ops;
>      smmuv3_accel_as_init(s);
> +
> +    if (s->s_accel->auto_mode) {
> +        s->machine_done.notify = smmuv3_machine_done;
> +        qemu_add_machine_init_done_notifier(&s->machine_done);
> +    }
>  }
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index dba6c71de5..3c1cd55714 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -26,6 +26,8 @@ typedef struct SMMUv3AccelState {
>      uint32_t bypass_hwpt_id;
>      uint32_t abort_hwpt_id;
>      QLIST_HEAD(, SMMUv3AccelDevice) device_list;
> +    bool auto_mode;
> +    bool auto_finalised;
>  } SMMUv3AccelState;
>  
>  typedef struct SMMUS1Hwpt {
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index 82f18eb090..fe0493c1aa 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -74,6 +74,8 @@ struct SMMUv3State {
>      OnOffAuto ats;
>      OasMode oas;
>      SsidSizeMode ssidsize;
> +
> +    Notifier machine_done;
>  };
>  
>  typedef enum {


