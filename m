Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A20AE77188
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 07:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYJv1-0003jL-77; Thu, 16 Jan 2025 02:03:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYJuu-0003hk-Kl
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 02:03:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYJus-0005bk-0v
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 02:03:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737011024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MdwEGYe5hAfLyz6bxzdeyj9JuNqAt84KEKdtrWjPfsw=;
 b=cMK32x272+LRbCZCLl3wamiZ4CS3X3td9lzOYxOUREhCZjQ7m/uTeYD4WU6U+UO98GUquS
 jZXk+LhvqXvOZCkfNwmDx26hI8xDyp7HyRSjpgus1xctyouiMuEU6/42MaQOXcbS8Ukm9T
 BeJph2N5sD92zkvfIcyFipVoE4DeANk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-uPhf9Vt3OaaBb5n39MaaDg-1; Thu, 16 Jan 2025 02:03:43 -0500
X-MC-Unique: uPhf9Vt3OaaBb5n39MaaDg-1
X-Mimecast-MFC-AGG-ID: uPhf9Vt3OaaBb5n39MaaDg
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4361efc9d1fso3509985e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 23:03:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737011022; x=1737615822;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MdwEGYe5hAfLyz6bxzdeyj9JuNqAt84KEKdtrWjPfsw=;
 b=XFctOLwWmZDPiHcQO64eZIP47G5+OXy6j0XJSDebtWohVscV0GHO/L2BRfHoFgRReL
 XijcmMbd30cpM6BZ2FGHm/ZFeJiu6ADZ+wezbpAd6Ns8lJQj72EWdWw8/j7v+uLzVjQe
 cCVTFNzpBkeJpKzz+dYkU/UYefNAdfBUJxc61qxGv5EZ7PScO9eTstArk3Qe916m+d+n
 eK6lj5IDqT/pDYy69Vl6z/K0DEq7yxuZ7lLSoHyvWxzjEBa8ziA7TH6h0Q8tWmobWNBk
 SbF8C6GyEln/ztj01SFdCOIwBsVjTbvDoAZUoogFuyWXss5vHI0URkWz8t0lFXxj9opr
 JK8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNthR795w5zFlLTANHCV/nc3Fipvxa9x/1ctAsf1z8/Cx/+qGTnXYMt7wy9mfsWZl5VJhJkpkHZZOC@nongnu.org
X-Gm-Message-State: AOJu0Ywsq132xXYqXAmrujvDMVbTa4zgCSqTupWZKNz1xThRA0XBdzAc
 1eL7QMP5YjihbtlBgTejZOYeBN7W5pnrrWt1PT7aDdiGi9zRkDm6B8MyUAjiZJk0bLjCbmo8ovX
 RC5En9Kb0mm3xzJV3ldhQJ2Db6uFH215H8wALITxCIOVh8zmQ5SIK
X-Gm-Gg: ASbGncscgYABQAeSd/xShqPnObFKpG3iuMg56QLFOI44FzhER56kKkMYJqIABCoRHWe
 LAsNj3bhjKwJkRNL434JeNJ7fL27WsOj5E4qffzIxHU/Kt0GJ4gMHPbJPMlNr5dMaMk0Hg++Zx2
 wUmHrs8YNL1C7pJB3+CddO55yKybV7FTRBjtuL6FybJmV6ZLCzlRvAXSUV+jU2P2eFO/aA5mpVL
 8GZTi+6v5brWZSwyF8sYmRYDIjH93xHog/rZCfulNoLiZ4WW2t2I4qn+nGxjO4gNH5yYXUJH5/s
 FlToPhnYE2c1
X-Received: by 2002:a05:600c:1d07:b0:434:fa73:a907 with SMTP id
 5b1f17b1804b1-436e269a5f5mr281596565e9.13.1737011021688; 
 Wed, 15 Jan 2025 23:03:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAVCTWNqvWKwPauIwSMpI33oxZGO/okwQTeJwBWpCcvDORog0ereHT/i5lWP5aVx1UgE+56Q==
X-Received: by 2002:a05:600c:1d07:b0:434:fa73:a907 with SMTP id
 5b1f17b1804b1-436e269a5f5mr281596275e9.13.1737011021331; 
 Wed, 15 Jan 2025 23:03:41 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-119.web.vodafone.de.
 [109.42.51.119]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74c6799sm48910115e9.24.2025.01.15.23.03.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 23:03:40 -0800 (PST)
Message-ID: <da2fe302-dae9-4f6c-8ea8-94fcc332e167@redhat.com>
Date: Thu, 16 Jan 2025 08:03:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] hw/arm/virt: Remove
 VirtMachineClass::disallow_affinity_adjustment
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>, qemu-arm@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
References: <20250115171009.19302-1-philmd@linaro.org>
 <20250115171009.19302-4-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250115171009.19302-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 15/01/2025 18.09, Philippe Mathieu-Daudé wrote:
> The VirtMachineClass::disallow_affinity_adjustment
> field was only used by virt-2.6 machine, which got
> removed. Remove it along with the GIC*_TARGETLIST_BITS
> definitions, and simplify virt_cpu_mp_affinity().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/arm/virt.h              |  1 -
>   include/hw/intc/arm_gic.h          |  1 -
>   include/hw/intc/arm_gicv3_common.h |  3 ---
>   hw/arm/virt.c                      | 16 ----------------
>   4 files changed, 21 deletions(-)
> 
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 27c5bb585cb..5d3b25509ff 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -117,7 +117,6 @@ typedef enum VirtGICType {
>   
>   struct VirtMachineClass {
>       MachineClass parent;
> -    bool disallow_affinity_adjustment;
>       bool no_its;
>       bool no_tcg_its;
>       bool claim_edge_triggered_timers;
> diff --git a/include/hw/intc/arm_gic.h b/include/hw/intc/arm_gic.h
> index 48f6a51a70a..f5e6e5e70b4 100644
> --- a/include/hw/intc/arm_gic.h
> +++ b/include/hw/intc/arm_gic.h
> @@ -68,7 +68,6 @@
>   #include "qom/object.h"
>   
>   /* Number of SGI target-list bits */
> -#define GIC_TARGETLIST_BITS 8
>   #define GIC_MAX_PRIORITY_BITS 8
>   #define GIC_MIN_PRIORITY_BITS 4
>   
> diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
> index a3d6a0e5077..fff5e55a97d 100644
> --- a/include/hw/intc/arm_gicv3_common.h
> +++ b/include/hw/intc/arm_gicv3_common.h
> @@ -45,9 +45,6 @@
>   #define GICV3_REDIST_SIZE 0x20000
>   #define GICV4_REDIST_SIZE 0x40000
>   
> -/* Number of SGI target-list bits */
> -#define GICV3_TARGETLIST_BITS 16
> -
>   /* Maximum number of list registers (architectural limit) */
>   #define GICV3_LR_MAX 16
>   
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 0080577e1a9..2a2a0bd9154 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1760,23 +1760,7 @@ void virt_machine_done(Notifier *notifier, void *data)
>   static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
>   {
>       uint8_t clustersz = ARM_DEFAULT_CPUS_PER_CLUSTER;
> -    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
>   
> -    if (!vmc->disallow_affinity_adjustment) {

I think this change is wrong - disallow_affinity_adjustment is false for 
newer machines, so you removed code here that is still in use on newer machines?

  Thomas

> -        /* Adjust MPIDR like 64-bit KVM hosts, which incorporate the
> -         * GIC's target-list limitations. 32-bit KVM hosts currently
> -         * always create clusters of 4 CPUs, but that is expected to
> -         * change when they gain support for gicv3. When KVM is enabled
> -         * it will override the changes we make here, therefore our
> -         * purposes are to make TCG consistent (with 64-bit KVM hosts)
> -         * and to improve SGI efficiency.
> -         */
> -        if (vms->gic_version == VIRT_GIC_VERSION_2) {
> -            clustersz = GIC_TARGETLIST_BITS;
> -        } else {
> -            clustersz = GICV3_TARGETLIST_BITS;
> -        }
> -    }
>       return arm_build_mp_affinity(idx, clustersz);
>   }
>   


