Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA7CC25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 05:00:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5IM3-0004cN-TH; Fri, 10 May 2024 00:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s5ILt-0004bu-2Q
 for qemu-devel@nongnu.org; Fri, 10 May 2024 00:59:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s5ILp-0008Dp-N6
 for qemu-devel@nongnu.org; Fri, 10 May 2024 00:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715317158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hJ1TBXh7f+m6U2S5c89NUjlUpknx9Ozp41FoK5h5lxg=;
 b=CsSGTKNqUnXbnlA5ognxQLSUz3cz0qkU6jzgeE2JVufXS+K86vz0rY/s6OxtRSrocNlpCY
 wemSduYJ5QHJ15tdoSfDBjr5xOIh1BMUD8YJuxOzSm7/VUbn1llBiYmFjtCeIetPazyiFH
 JYbPk/BYJAmN5omy4sNHKj651D0DwLE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-6qnImKalOoa9GVzi5UpA_Q-1; Fri, 10 May 2024 00:59:16 -0400
X-MC-Unique: 6qnImKalOoa9GVzi5UpA_Q-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a59c3cf5f83so94915066b.2
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 21:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715317155; x=1715921955;
 h=content-transfer-encoding:in-reply-to:autocrypt:cc:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hJ1TBXh7f+m6U2S5c89NUjlUpknx9Ozp41FoK5h5lxg=;
 b=iZHi0PYiLj9OlZC3UhsZ9WWK+km+f11OnslUEslHEgraVnKuM6vdgIqP4GPAm00yho
 RqDkDMwGHAiG1mJwlfu8jR/R7nIPkojijdX1rbrRPyxOSCh8+ooZbcXZLlr98+1PT2P3
 4MGyMTp/N1+TDMEzT4NI7kj2r3hZbX7FXNamNbIOvFr0X35+xTPKFFIUUYQ5sw6SfiMn
 YLu0iBRTLzi4MOLeHiFBg+CQd/R77mxa2nz01yyRHsrCqKbFZCpHsISWcU/Y1+BJnyzQ
 yx1FrfSGZPmys6TiY8oqu2Wn7E8yDJQaQGLHXo7eJndhwT8HRl2/NjD8ljmvaXcgJrsb
 P7SA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtLv6GfWPVYLPJU5f315y7sLrgqtdXM51lXLkR7uI3+IXzUFuom1LjOuoQ2NnnxmAODYY+nqF910uiFe3KhmsqM1jFGyo=
X-Gm-Message-State: AOJu0Yz1O2AR5dkpEYQYDSCuRbrcrv+rGGEMlQxwMesMvbA18hM82bRf
 ONpLV/KKzhDLozyFTK9o4Toy/Y+ZPqbWT5B5CCUrEsEa9l3EAZkGMIWwWIpOL8h97NknUIzEGB0
 lYslOhii/ohLHfcIu+X4NGgbKEFZ/GHoPZorUKqESs1t0gH4NeLsL
X-Received: by 2002:a17:906:590a:b0:a59:a2c0:3252 with SMTP id
 a640c23a62f3a-a5a2d681287mr86348166b.76.1715317155336; 
 Thu, 09 May 2024 21:59:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYXnp8uSpOKy2ORU46ABEIjMKJvJZbJQo8e9yVlbGZDG/iuRxFLKOxKOIuCC06H1lDIjR5wA==
X-Received: by 2002:a17:906:590a:b0:a59:a2c0:3252 with SMTP id
 a640c23a62f3a-a5a2d681287mr86347266b.76.1715317155006; 
 Thu, 09 May 2024 21:59:15 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-40-241-109.web.vodafone.de.
 [109.40.241.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a179c7fc4sm144043266b.135.2024.05.09.21.59.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 May 2024 21:59:14 -0700 (PDT)
Message-ID: <993a7077-9038-434d-ae22-c6d836534f24@redhat.com>
Date: Fri, 10 May 2024 06:59:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] s390x: move s390_cpu_addr2state to
 target/s390x/sigp.c
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240509170044.190795-1-pbonzini@redhat.com>
 <20240509170044.190795-2-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Cc: qemu-s390x <qemu-s390x@nongnu.org>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240509170044.190795-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 09/05/2024 19.00, Paolo Bonzini wrote:
> This function has no dependency on the virtio-ccw machine type, though it
> assumes that the CPU address corresponds to the core_id and the index.
> 
> If there is any need of something different or more fancy (unlikely)
> S390 can include a MachineClass subclass and implement it there.  For
> now, move it to sigp.c for simplicity.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/s390x/s390-virtio-ccw.c | 16 ----------------
>   target/s390x/sigp.c        | 17 +++++++++++++++++
>   2 files changed, 17 insertions(+), 16 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>



> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 4dcc2138200..feabc173eb3 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -50,22 +50,6 @@
>   
>   static Error *pv_mig_blocker;
>   
> -S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
> -{
> -    static MachineState *ms;
> -
> -    if (!ms) {
> -        ms = MACHINE(qdev_get_machine());
> -        g_assert(ms->possible_cpus);
> -    }
> -
> -    /* CPU address corresponds to the core_id and the index */
> -    if (cpu_addr >= ms->possible_cpus->len) {
> -        return NULL;
> -    }
> -    return S390_CPU(ms->possible_cpus->cpus[cpu_addr].cpu);
> -}
> -
>   static S390CPU *s390x_new_cpu(const char *typename, uint32_t core_id,
>                                 Error **errp)
>   {
> diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
> index 9dd977349ab..ad0ad61177d 100644
> --- a/target/s390x/sigp.c
> +++ b/target/s390x/sigp.c
> @@ -11,6 +11,7 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "s390x-internal.h"
> +#include "hw/boards.h"
>   #include "sysemu/hw_accel.h"
>   #include "sysemu/runstate.h"
>   #include "exec/address-spaces.h"
> @@ -435,6 +436,22 @@ static int sigp_set_architecture(S390CPU *cpu, uint32_t param,
>       return SIGP_CC_STATUS_STORED;
>   }
>   
> +S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
> +{
> +    static MachineState *ms;
> +
> +    if (!ms) {
> +        ms = MACHINE(qdev_get_machine());
> +        g_assert(ms->possible_cpus);
> +    }
> +
> +    /* CPU address corresponds to the core_id and the index */
> +    if (cpu_addr >= ms->possible_cpus->len) {
> +        return NULL;
> +    }
> +    return S390_CPU(ms->possible_cpus->cpus[cpu_addr].cpu);
> +}
> +
>   int handle_sigp(CPUS390XState *env, uint8_t order, uint64_t r1, uint64_t r3)
>   {
>       uint64_t *status_reg = &env->regs[r1];


