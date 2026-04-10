Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87FFE99049
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 07:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB6GM-0004Bi-EK; Fri, 10 Apr 2026 03:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wB6GK-0004Au-N0
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 03:26:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wB6GI-0006iM-Ne
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 03:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775806000;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SzWLDKBnyzNA1T5YceMswjeh4MEVICXjSAPV2kBjGzE=;
 b=ZqJ2AvY6gpYZ1C9Y+U5oc59yhP0Wa2TIGiFEOj9/1cuInq8DiX+v2jW/g/NuLzT/zHQ9yl
 RwqRrS5kwRQHLPujFkaJpfvUSE5LqlfZyAvh0q+AVx2wq9sxBqVYuKNKdokkSWvB0yep85
 v3Lu7Aw00OothJHlDAdpV0TKuQQ1NF4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-bGIyEV3EMHexmb2J6OoaJQ-1; Fri, 10 Apr 2026 03:26:39 -0400
X-MC-Unique: bGIyEV3EMHexmb2J6OoaJQ-1
X-Mimecast-MFC-AGG-ID: bGIyEV3EMHexmb2J6OoaJQ_1775805998
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-488bd1ee9e7so10844765e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 00:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775805998; x=1776410798;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SzWLDKBnyzNA1T5YceMswjeh4MEVICXjSAPV2kBjGzE=;
 b=BdoDpHc6GWxPOr+NXLThG652YLujdpbf/NCHZxVXqSOpAccYCn7ILTncyf8DM7bpmH
 rPVOzk5B1OJO+AyboTF1phnO/TqSxLDzYEEzSEzDyaX2CkPIEhVFtSj/3hT8WrQz6B93
 B/Q+2Df8KN/d0jkJENW3LPavPRHoSGTrLzQJ5LTWGJ7EUb4xDWBLrP3VKgn64NY62/5v
 SMFsXsLfY0X4vXluSoieJDPSzmva/nQuyIY84IEtcnaU8NwtsXUBYOy6oaYficR53ioz
 +2rcPHCLpvrL+VUoEC7RGMiMg5vHA/eigqaMDKJzLpN/MxW1nWQMzofinUgMlalNSslv
 MNqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnRn+fP6H3qLUtvOMwh2mkdOT35elbdfAO/yrIhLg/PyWR14vUUd7iZk5GI7z3N7dTigHlOuvDExBe@nongnu.org
X-Gm-Message-State: AOJu0YybVH2I4S+Ahyuei5x1heHvDnxhSFPXmof6TXXc1ck4QpSe7Xij
 JFp8LQySHb2lU6aYRnH3h1nAaaIUB+KonLyQYrHUkXZADrk2m+l2oTJmJkOALND7PlwhgRS8ylM
 3jrinBwSYhyKTCvXEIVRCqrALZnnJGdgVSsDNjiyAl0kpYWrX/1mHzyvi
X-Gm-Gg: AeBDies/OJfrFCnHCCQTa0rkJInBJTMsT5KiSgoyawm0EcuvkC862HdgV3UHcQ3RXb9
 rzGaekGf0gnJl9c6zpcCoCnanvun0IokflrhgkbDvSUh92zI1Ju9p7pj4C2NFbVUaGt79+7NLML
 PI/NEWmDjCXKfCAz298qyCjpRAJr6x64vAR0tdwaxit8QG9H7aNq/y3/S4Ltlw/LbZV9N/cmTo+
 ebQJUvlQ4Vt0yFkvSnE6JKOj/SMA6wu5rVUsQScOmPwDAWrtiIz0sHecCyqyJf1i/DpVYgGGPS+
 6Qo/4RRMyE1Wt4UlySn8UBLlJzNxzGs3a4BbdkvYRF7KXEjR/bUYOW5CllumO5MR5XL0tWUE6Yn
 38lKM2cJQmN7btYyeghgBnZZSGzgJUoBGxYfb43APCbBvyVCpmpKnqTb+KYNLHhdbN69ArA==
X-Received: by 2002:a05:600c:1391:b0:486:fe23:1707 with SMTP id
 5b1f17b1804b1-488d687116amr24238625e9.20.1775805997684; 
 Fri, 10 Apr 2026 00:26:37 -0700 (PDT)
X-Received: by 2002:a05:600c:1391:b0:486:fe23:1707 with SMTP id
 5b1f17b1804b1-488d687116amr24238045e9.20.1775805997126; 
 Fri, 10 Apr 2026 00:26:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d53807d7sm92539365e9.10.2026.04.10.00.26.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2026 00:26:36 -0700 (PDT)
Message-ID: <10540f3f-28b6-4cbb-9736-d6e8a01bdd76@redhat.com>
Date: Fri, 10 Apr 2026 09:26:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] hw/arm/smmuv3-accel: Add helper for resolving auto
 parameters
Content-Language: en-US
To: Nathan Chen <nathanc@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Shameer Kolothum <skolothumtho@nvidia.com>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
References: <20260401010231.4166776-1-nathanc@nvidia.com>
 <20260401010231.4166776-2-nathanc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260401010231.4166776-2-nathanc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 4/1/26 3:02 AM, Nathan Chen wrote:
> From: Nathan Chen <nathanc@nvidia.com>
>
> Introduce smmuv3_accel_auto_finalise() to resolve properties that are
> set to 'auto' for accelerated SMMUv3. This helper function allows
> properties such as ats, ril, ssidsize, and oas support to be resolved
> from host IOMMU capabilities via IOMMU_GET_HW_INFO.
>
> Auto mode requires at least one cold-plugged device to retrieve and
> finalise these properties. Register a machine_init_done notifier to
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
> ---
>  hw/arm/smmuv3-accel.c   | 14 ++++++++++++++
>  hw/arm/smmuv3-accel.h   |  2 ++
>  hw/arm/smmuv3.c         | 20 ++++++++++++++++++++
>  include/hw/arm/smmuv3.h |  2 ++
>  4 files changed, 38 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 65c2f44880..a0146c8d31 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -35,11 +35,25 @@ static int smmuv3_oas_bits(uint32_t oas)
>      return map[oas];
>  }
>  
> +static void smmuv3_accel_auto_finalise(SMMUv3State *s,
> +                                       struct iommu_hw_info_arm_smmuv3 *info) {
> +    SMMUv3AccelState *accel = s->s_accel;
> +
> +    /* Return if no auto for any or finalised already */
> +    if (!accel->auto_mode || accel->auto_finalised) {
I think you need to explain the commit message when auto_mode is going
to be set (I guess at least once an accel  prop is set to auto mode).

Also can you detail this case where smmuv3_accel_auto_finalise() would
be called several times. Here we return directly without looking again
at the prop values. Would it be meaningful to continue and check the
collected info matches the ones already collected? Can it happen?

An alternative would have been to fall back to default values in case no
cold plugged host dev could be found. Can you motivate that choice in
the commit msg?
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
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 7fead1c3cf..09ea08eb18 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -37,6 +37,7 @@
>  #include "smmuv3-accel.h"
>  #include "smmuv3-internal.h"
>  #include "smmu-internal.h"
> +#include "system/system.h"
>  
>  #define PTW_RECORD_FAULT(ptw_info, cfg) (((ptw_info).stage == SMMU_STAGE_1 && \
>                                          (cfg)->record_faults) || \
> @@ -2020,6 +2021,22 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>      return true;
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
>  static void smmu_realize(DeviceState *d, Error **errp)
>  {
>      SMMUState *sys = ARM_SMMU(d);
> @@ -2058,6 +2075,9 @@ static void smmu_realize(DeviceState *d, Error **errp)
>  
>      smmu_init_irq(s, dev);
>      smmuv3_init_id_regs(s);
> +
> +    s->machine_done.notify = smmuv3_machine_done;
> +    qemu_add_machine_init_done_notifier(&s->machine_done);
can't you move smmuv3_machine_done in smmuv3-accel.c and also call 

qemu_add_machine_init_done_notifier from smmuv3_accel_init()?

Eric

>  }
>  
>  static const VMStateDescription vmstate_smmuv3_queue = {
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


