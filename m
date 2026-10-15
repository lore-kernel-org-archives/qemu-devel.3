Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2676ACC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:01:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHL5b-0005yC-OH; Thu, 15 Oct 2026 09:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xHL5Y-0005vd-7D
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 09:01:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xHL5W-0002bM-Bd
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 09:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792069296;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YktKNEMcPDogZ6g30J7csBDy/fG8Te7xH2b46prd+6M=;
 b=F4lYJfFcXpISsssaEgQDJZRUNqHVqRJj94MHxKUo2oEbo7+JGLIYRRs6qwwnQiSs9RGtJX
 dIkObKxEJbiW2UDM9vLfMDzPp/yjnK73nrBQugznFJj8B4NYzb1U+udozk221+RA7Zblf5
 FyZl85ZkKCedQdBGwXxj0BzJ1kWy7f4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-aiy-qfloMbOnWBFAj3uBQw-1; Thu, 15 Oct 2026 13:01:34 +0000
X-MC-Unique: aiy-qfloMbOnWBFAj3uBQw-1
X-Mimecast-MFC-AGG-ID: aiy-qfloMbOnWBFAj3uBQw_1792069293
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-486f9d150c3so3322552f8f.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 06:01:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792069293; x=1792674093;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YktKNEMcPDogZ6g30J7csBDy/fG8Te7xH2b46prd+6M=;
 b=N3m7bNE1JWT/bmltVrNs7sXnb7odhZrMndxhvaGstl+BAP3vS8lAY359QsWdXDLPvR
 d0d6JuGKIN+0z0zfHSuxtvAEnpLXUQAtEmtgUj/kxFNuS5x5HaVoQ0zrdIg59smmJpUF
 PihMBttn8tCOvwts0b0pd2TDBe6oVOwS40aoRkB/OpUo5b8K3sss8+37f3bmmkGhMKUo
 Gfk248l2bzxjXFgVK+DyaS6hazmW2jensbG49+ApQNDhyv2e3iYbe/lP5+nBqW46NJvy
 n1oCMTHeTPVW+l9vtsTT1FWynTw3JtnCaCxPhO6UPSs1pT84fchnYGGOCMKUG7hWU5AQ
 D5/g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxjcqg8Zixp/3OeDrPzYy+f18GoEgDjoIKYK1Q25FCPrqEsOQcEcbHbDg+8ytIOU3+2ux02M3YPL0sY@nongnu.org
X-Gm-Message-State: AFq9FYLGfmV3zhR+onpbx76yr4l6OjEv/70WktUKecuTz1HB3e7ks+We
 fMzFtRWiFlKlm8lw3JAQX9+UfNaU/MlYn2Adns3iRruo3LbDurvJ02p14u1VT9+YUT+zmO95Y4c
 82UYLNUi6USd/LAp3dIWfJV1Kn5UtLfw1bbR+ESk4SLLEIbfs6fQyRavc
X-Gm-Gg: AYBFou3hkLoo4FjLvpTHXizGd131kit9dlx8VKOm5m6ecc6FHcc9utpJVVRsgzoXr0b
 5i5rTyseChXqwjjvECMcRsFOmPa6DL633MpOqoo63QBhxzTq9dpwXjXACEIpRR9sjWWRn8oz3wv
 rjSReAqEHhuMoSfeqXKJvsNTB/fi7s/jHVNnuB7y2Qjhii4WjydWcuw3Nc9VDHU/N+/ZiMA1arl
 KasrTBHEQ+i9pJxERxKqCeJ0Dv69m1L1OHjNLbO5cVHh2ooIKblevlny8TAPyhKTMYWz4GPNyRg
 xePUe19d4PWrMQFDzR0adtRhS8aTxVxklE2kIzOTjH+AglRge5yjGcZpfN9vx6h70vmzHI2M+Yf
 Cssd7XXG6Mu+u5e9AatbWUrfTN9SmO+gMu4Wtm22zBaOjwgdB
X-Received: by 2002:a05:600c:6384:b0:4a1:7741:ec43 with SMTP id
 5b1f17b1804b1-4a18e4b8966mr356115295e9.26.1792069292174; 
 Thu, 15 Oct 2026 06:01:32 -0700 (PDT)
X-Received: by 2002:a05:600c:6384:b0:4a1:7741:ec43 with SMTP id
 5b1f17b1804b1-4a18e4b8966mr356114555e9.26.1792069291618; 
 Thu, 15 Oct 2026 06:01:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd640be0sm53714835e9.1.2026.10.15.06.01.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 06:01:29 -0700 (PDT)
Message-ID: <4ea14973-ac46-497c-80f6-499487f733cc@redhat.com>
Date: Thu, 15 Oct 2026 15:01:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 10/25] target/arm: fix SVE and PAuth finalize for
 named CPU models
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev
Cc: cohuck@redhat.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 gshan@redhat.com, skolothumtho@nvidia.com, sebott@redhat.com,
 armbru@redhat.com, philmd@linaro.org, yangjinqian1@huawei.com,
 shaju.abraham@nutanix.com, mark.caveayland@nutanix.com,
 ping@khushitshah.com, sandesh.patel@nutanix.com
References: <20260921123249.1708067-1-khushit.shah@nutanix.com>
 <20260921123249.1708067-11-khushit.shah@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260921123249.1708067-11-khushit.shah@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Khushit,

On 9/21/26 2:32 PM, Khushit Shah wrote:
> As named CPU models define their feature set explicitly, their SVE
> vector lengths and PAuth fields must not be derived from the host.
>
> When SVE is enabled without an sve<N> setting, require the named model
> to specify its supported vector lengths rather than inheriting them from
> the host.
>
> Named models set PAuth ID register fields directly through SYSREG_
> properties. Preserve these values in PAuth finalization.
>
> Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
> ---
>  target/arm/cpu64.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 7487b48cc9..a0114b0fa2 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -38,6 +38,7 @@
>  #include "internals.h"
>  #include "cpu-features.h"
>  #include "cpu-idregs.h"
> +#include "cpu-models.h"
>  #include "trace.h"
>  
>  /* convert between <register>_IDX and SYS_<register> */
> @@ -134,6 +135,21 @@ void aarch64_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
>              return;
>          }
>  
> +#ifndef CONFIG_USER_ONLY
I don't get why do you need that #ifndef? 
> +        /*
> +         * If SVE is enabled but no vector lengths are specified, we must not
> +         * default to the host's supported lengths for named CPU models.
> +         */
> +        {
> +            ARMCPUClass *acc = ARM_CPU_GET_CLASS(cpu);
> +            if (acc->info && arm_find_model(acc->info->name)) {
> +                error_setg(errp,
> +                           "Named CPU models with SVE must set vector lengths");
> +                return;
> +            }
> +        }
> +#endif
> +
>          if (kvm_enabled()) {
>              /* Disabling a supported length disables all larger lengths. */
>              tmp = vq_init & vq_supported;
> @@ -556,6 +572,23 @@ void aarch64_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
>      ARMISARegisters *isar = &cpu->isar;
>      uint64_t isar1, isar2;
>  
> +#ifndef CONFIG_USER_ONLY
> +    /*
> +     * For named CPU models the model props write the authoritative
> +     * APA/API/APA3/GPA/GPI/GPA3 values directly into cpu->isar through
all those fields ar not KVM writable currently.

> +     * SYSREG_ properties, so do not override them here. Since other code
> +     * relies on cpu->prop_pauth, mirror the resulting pauth state into
> +     * cpu->prop_pauth.
> +     */
> +    {
> +        ARMCPUClass *acc = ARM_CPU_GET_CLASS(cpu);
> +        if (acc->info && arm_find_model(acc->info->name)) {
> +            cpu->prop_pauth = cpu_isar_feature(aa64_pauth, cpu);
> +            return;
> +        }
> +    }
> +#endif
If I understand correctly all the isar1/isar2 manipulations afterwards
only affect TCG. 
In KVM mode, although isar1/isar2 fields are reset afterwards this does
not impact the guest view so most probably the isa1/2 reset + finale
update could be moved to the !hw_accel block and you put that addition
in the hwaccel_enabled() block, or am i wrong?

Thanks

Eric
> +
>      /*
>       * These properties enable or disable Pauth as a whole, or change
>       * the pauth algorithm, but do not change the set of features that


