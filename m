Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AEFDE9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 09:40:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt0Vi-0008Tf-Fy; Thu, 19 Feb 2026 04:39:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1vt0Vg-0008TM-Tt
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 04:39:49 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1vt0Vf-0005q2-8q
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 04:39:48 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4833115090dso7121035e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 01:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771493985; x=1772098785; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0Qwt8Tz8tB4Obh3dtJ6HDehOvnoNxAwIhhD+tN8oggA=;
 b=iG0gNZbHtwKR9Mpr6f/7dRp7667uuAURkW1VRQ7c2cMYuXNlwu2e8eSCeOrkP/vKaS
 9ZM2ORK/QKjy8hgZyG0MM43wO8CkgWQptEy2LBUHL+HVi70w6j+h34W3+MPtnrbk/5bM
 kWMAlBmf4ABr2s56MhLseulLLAK0G/0ixyrR3sVrxCEFDD+dNc+ndPxfWv+L3WX7pZTM
 SJC6froTyMyern88KYLpzji7ZtbfVy0hloSdKXI/wFeND4PHVL+MRMNerdA6SE537bg9
 0FFY7HS+hBOcJ7rlSDz6wD05XTFPoBBUfJlIbwBwkDnZ4f4SvQg1C194GsfibMAmLb1j
 eMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771493985; x=1772098785;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0Qwt8Tz8tB4Obh3dtJ6HDehOvnoNxAwIhhD+tN8oggA=;
 b=ZChhGiDmdcCRRZ5PiqmCQKRJqIrYDRr/VZtGz/hqx78OsGZtiCPHmDXne+j/LTKUyn
 jwjcKHZLPWxVlDerH6To8uwR344jkWC97vl9RTlou8X6jxEtW8+LZwcxpE9uyYH35jSP
 qfVUCAr47RQN77GVbja/uinCDB0Kibo1jmHIoVPrMD8jyGlxkLD5jmRQdeFu8Q7zJ7U2
 JBq0VNBYcO24YWlroEKVtO1dWnzh03yWzeg852h8SEI3N4UaFZKnkn63vBC7Tq8vHIAG
 dtSshq+qzcqxHexfM3/SZvNHoaqjtucGBogtHwXRLckpQ11VGbqdKPKz33I+P2Eh8hl4
 6OGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPVs7q1iUffPWW3Nnv5KqV6p835DW99y3E9YmpN/Je2Ho8sTNTginiVVOlVwzoKmjilO2+0xucCJwS@nongnu.org
X-Gm-Message-State: AOJu0YzNe8o73MndDrPP/K+firaWfJoifI+0EY3N0jlwoHi72phb5BD9
 dWGXVUrI2xRklUuCeKr6n1NGWaugWAKNOnUlTrPhlowBxSAe6naz557o
X-Gm-Gg: AZuq6aL2fp9qCv/t8SNCBJHa+hkwnm3QdZ+xP5YT9hclEdn8kcAQSfa9X+2sxmpDrc8
 ToLBjmtpM148U9LHj69mTuABI0VefW227mngPymK8cA9Akl4Caerbf0QDltoCOE7UIRu5cUlZ73
 Orz7RCp0jwWxJ+kP548jHiuQyCwz27nf9ZHxp0BoLN+NiVNpl19fRwos1bChHZC3IGeLJwEGtSf
 KG2BaOmqkKVCHI29DS9hlCeMt5kzXwTeEhdnocAoYBztFxLyU0+w4FMdwLa4pCFZ+0T2kmEA9bJ
 kiaBoQEGEElV0B5u0ThSL1Bwxyz47+hZEA+mGAwqiR6nMYnlIJAOIrr/tDJETm9bCH9bceQfbsH
 jzxqNjaDWLGaeZ1M9R+STiI2y3Masm7rp+qUdYsebW3OEJi0gZXKlF+vPbEDeT0KI1FuSExW0rH
 GWVHYHbFeKZdQpUkYkwXvu45dYAtusWw==
X-Received: by 2002:a05:600c:3e14:b0:47a:935f:61a0 with SMTP id
 5b1f17b1804b1-483989ca52emr75382465e9.0.1771493984819; 
 Thu, 19 Feb 2026 01:39:44 -0800 (PST)
Received: from [10.24.66.212] ([15.248.2.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4837a5d562esm336851535e9.15.2026.02.19.01.39.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 01:39:44 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <3b4b7b7b-7fcd-46ce-bdcb-cd1a30cf5276@xen.org>
Date: Thu, 19 Feb 2026 09:39:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 27/34] kvm/xen-emu: re-initialize capabilities during
 confidential guest reset
To: Ani Sinha <anisinha@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: kraxel@redhat.com, kvm@vger.kernel.org, qemu-devel@nongnu.org
References: <20260218114233.266178-1-anisinha@redhat.com>
 <20260218114233.266178-28-anisinha@redhat.com>
Content-Language: en-US
In-Reply-To: <20260218114233.266178-28-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 18/02/2026 11:42, Ani Sinha wrote:
> On confidential guests KVM virtual machine file descriptor changes as a
> part of the guest reset process. Xen capabilities needs to be re-initialized in
> KVM against the new file descriptor.
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>   target/i386/kvm/xen-emu.c | 50 +++++++++++++++++++++++++++++++++++++--
>   1 file changed, 48 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/kvm/xen-emu.c b/target/i386/kvm/xen-emu.c
> index 52de019834..69527145eb 100644
> --- a/target/i386/kvm/xen-emu.c
> +++ b/target/i386/kvm/xen-emu.c
> @@ -44,9 +44,12 @@
>   
>   #include "xen-compat.h"
>   
> +NotifierWithReturn xen_vmfd_change_notifier;
> +static bool hyperv_enabled;
>   static void xen_vcpu_singleshot_timer_event(void *opaque);
>   static void xen_vcpu_periodic_timer_event(void *opaque);
>   static int vcpuop_stop_singleshot_timer(CPUState *cs);
> +static int do_initialize_xen_caps(KVMState *s, uint32_t hypercall_msr);
>   
>   #ifdef TARGET_X86_64
>   #define hypercall_compat32(longmode) (!(longmode))
> @@ -54,6 +57,30 @@ static int vcpuop_stop_singleshot_timer(CPUState *cs);
>   #define hypercall_compat32(longmode) (false)
>   #endif
>   
> +static int xen_handle_vmfd_change(NotifierWithReturn *n,
> +                                  void *data, Error** errp)
> +{
> +    int ret;
> +
> +    /* we are not interested in pre vmfd change notification */
> +    if (((VmfdChangeNotifier *)data)->pre) {
> +        return 0;
> +    }
> +
> +    ret = do_initialize_xen_caps(kvm_state, XEN_HYPERCALL_MSR);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    if (hyperv_enabled) {
> +        ret = do_initialize_xen_caps(kvm_state, XEN_HYPERCALL_MSR_HYPERV);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +    }
> +    return 0;

This seems odd. Why use the hyperv_enabled boolean, rather than simply 
the msr value, since when hyperv_enabled is set you will be calling 
do_initialize_xen_caps() twice.

> +}
> +
>   static bool kvm_gva_to_gpa(CPUState *cs, uint64_t gva, uint64_t *gpa,
>                              size_t *len, bool is_write)
>   {
> @@ -111,15 +138,16 @@ static inline int kvm_copy_to_gva(CPUState *cs, uint64_t gva, void *buf,
>       return kvm_gva_rw(cs, gva, buf, sz, true);
>   }
>   
> -int kvm_xen_init(KVMState *s, uint32_t hypercall_msr)
> +static int do_initialize_xen_caps(KVMState *s, uint32_t hypercall_msr)
>   {
> +    int xen_caps, ret;
>       const int required_caps = KVM_XEN_HVM_CONFIG_HYPERCALL_MSR |
>           KVM_XEN_HVM_CONFIG_INTERCEPT_HCALL | KVM_XEN_HVM_CONFIG_SHARED_INFO;
> +

Gratuitous whitespace change.

>       struct kvm_xen_hvm_config cfg = {
>           .msr = hypercall_msr,
>           .flags = KVM_XEN_HVM_CONFIG_INTERCEPT_HCALL,
>       };
> -    int xen_caps, ret;
>   
>       xen_caps = kvm_check_extension(s, KVM_CAP_XEN_HVM);
>       if (required_caps & ~xen_caps) {
> @@ -143,6 +171,21 @@ int kvm_xen_init(KVMState *s, uint32_t hypercall_msr)
>                        strerror(-ret));
>           return ret;
>       }
> +    return xen_caps;
> +}
> +
> +int kvm_xen_init(KVMState *s, uint32_t hypercall_msr)
> +{
> +    int xen_caps;
> +
> +    xen_caps = do_initialize_xen_caps(s, hypercall_msr);
> +    if (xen_caps < 0) {
> +        return xen_caps;
> +    }
> +

Clearly here the code would be simpler here if you just saved the value 
of hypercall_msr which you have used in the call above.

> +    if (!hyperv_enabled && (hypercall_msr == XEN_HYPERCALL_MSR_HYPERV)) {
> +        hyperv_enabled = true;
> +    }
>   
>       /* If called a second time, don't repeat the rest of the setup. */
>       if (s->xen_caps) {
> @@ -185,6 +228,9 @@ int kvm_xen_init(KVMState *s, uint32_t hypercall_msr)
>       xen_primary_console_reset();
>       xen_xenstore_reset();
>   
> +    xen_vmfd_change_notifier.notify = xen_handle_vmfd_change;
> +    kvm_vmfd_add_change_notifier(&xen_vmfd_change_notifier);
> +
>       return 0;
>   }
>   


