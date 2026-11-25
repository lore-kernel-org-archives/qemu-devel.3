Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36CF606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iF0cREcs;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ZX9f61E6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWGon-0001zp-9a; Wed, 25 Nov 2026 12:30:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1xWGog-0001y4-W0
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 12:30:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1xWGoe-0005ms-OI
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 12:29:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795627793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YJ8R+dYZDQ9KyTkPEremEmFEW4vzpcNZM9DVH1mOkXU=;
 b=iF0cREcsXl50pzH64ghm7b9W7ovD4f9nlNzOcvwYgWsPL6tr8B1pspfClWyhcB+gI2dnA9
 g9IXdYPmYrEvVBxSSHgAb28Gs1FrqMk/65ZpRlm0L1ack1V4tdqL8IdEzeQyQibF6plqL/
 twUwBtOZLaDgbGGSz4jl6MF/N9rFB0Q=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-yvcqoelbMqyzKoA5rZT07Q-1; Wed, 25 Nov 2026 17:29:50 +0000
X-MC-Unique: yvcqoelbMqyzKoA5rZT07Q-1
X-Mimecast-MFC-AGG-ID: yvcqoelbMqyzKoA5rZT07Q_1795627790
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c50547b4992so424777766b.3
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 09:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795627790; x=1796232590; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YJ8R+dYZDQ9KyTkPEremEmFEW4vzpcNZM9DVH1mOkXU=;
 b=ZX9f61E6Bf4KlMsAz6cVvKCjUB0TkoN2++tpsRXe6+NeANpPcPYK+xqkKOkFgiMIgU
 EsEl67iSDUejps+Sy3P49Bi9tpZccdoxzmJvkxRPPMczzdz+/Z6Y9vhVArCizj33mD7r
 K1jKnwqsrtGmYvEGh4uaN4eKNTiaPEfyzPaFwWFA4zRD9MJXld/GjpO3EgJ4ZJIQaJS1
 6j1WF6vIfYM9yKZoSL3ZiJodpPP/lEQ+1+DtisbK6P9Hb0lr+3CSZ/v431jQcGsDjchm
 tazoSH+0765JZb/6eFsZTL8/O+BQuU8jNbf50IqgC7v6sC3NENxAALgks07KvVHwdfSx
 ievA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795627790; x=1796232590;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YJ8R+dYZDQ9KyTkPEremEmFEW4vzpcNZM9DVH1mOkXU=;
 b=i6x/m+bRhZNIa3jajP6HvjXEqAvr81Dlqe5TmPRmG1D+kp1VRx1MQ4csRJqviFYGvW
 q9516GKhX0qI0Bc0N+CV665bz2Z6riteBdPLzhh20f9YZPxMzF3FPt79ml2++CQt52JL
 imZN1HgV8cu6JGi3N6Z+wceuWzekVWr58VJY6bKajS/CyIgxWOIXZ+QKzQ/AvKJ5L4Ev
 cqTOBNZdLk/uV37+fsWSfujAswms6T9FEEYNGz/b4idoMsyW0AOKXuw4X8TiH+R47B+z
 pq/CHMIUFlVDDq4OI+yK78J8nOCq4maXLdsitY4Mx8xmUbbwmQcY/el5bpXgZESXXRjy
 +mZw==
X-Forwarded-Encrypted: i=1;
 AL+hErGcGmo72zzsu+g+ehIXEfebVuU7KFOhjRxtfW7cl2NjVTU6Uu4vt2OTQf/7419cZFzkLr8EM60RqkIf@nongnu.org
X-Gm-Message-State: APuU4Z9lgqIqm8t/gMeC0rD/hdd+Dh0K5cVs2CaxvPpA/Du3GOnlKg7y
 311dF3drVRm3u9Nl2Qa3BSNLJwfd1WSfXwO04lNfUNhH5enh9zF5YyQZH8DDKxl2RcSRKBoO52P
 qTKvL7thHJZMN144RfScxz5hY46dxL/pSGXyz6QeBpqPm5BSLnbgjFUAl
X-Gm-Gg: AZFdTZeYL6R6zlAE69INjvfCneaEawSl61a6IXxZiN943+1jGOjPWKnxuQzupWlrWWE
 8LbmKcM5FXnFnixU9XZAZaqvRJb+Ldffy3jDiT803T9Q92RzlGxfAJbj5tdU410wO+y1m5mTfAy
 ymOKsJFZoQ814295pCez69sVgbqZN6eeUNzgOfxHkr8Yi9XZE0Wzl1lNIfDpgRLuAQG5CRxSzkN
 nZtuQdhR/snYMvLMpFqdHcmNupK++pKOaAuScWI43xRkzOAlPNSJT8HtwmeuwcbtVtnlDmkAO/t
 YKqKDJG8oiBugjvnfpnH36IwMxP0IUeCjYQyI6Xg5rSU53G+94/BSkx7o7Oz6bDp3pDUgLeKqFV
 /6uCegKORzRR8SyLokzNTtoDa3brD35X/8QAOE6BjmOYZzXNzO9w9osy7AqdAAPlIM97IS5UYKF
 Ts4PIa25nhekJFMaoW
X-Received: by 2002:a17:907:ea90:b0:c50:5e90:5ea7 with SMTP id
 a640c23a62f3a-c513ac9dac3mr1535855966b.49.1795627789654; 
 Wed, 25 Nov 2026 09:29:49 -0800 (PST)
X-Received: by 2002:a17:907:ea90:b0:c50:5e90:5ea7 with SMTP id
 a640c23a62f3a-c513ac9dac3mr1535854166b.49.1795627789196; 
 Wed, 25 Nov 2026 09:29:49 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:af16:8320:54ea:4bc9?
 ([2a01:e0a:f0e:9070:af16:8320:54ea:4bc9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513acfe25asm670749766b.11.2026.11.25.09.29.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 09:29:48 -0800 (PST)
Message-ID: <63fcaf35-5d3f-42fb-868f-9fcd644bf494@redhat.com>
Date: Wed, 25 Nov 2026 18:29:47 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/3] arm/kvm: select an nVHE-only EL2 with
 SYSREG_ID_AA64MMFR1_EL1_VH
To: Haseeb Ashraf <haseebashraf091@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Cc: Haseeb Ashraf <haseeb.ashraf@siemens.com>,
 Eric Auger <eric.auger@redhat.com>, Marc Zyngier <maz@kernel.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Khushit Shah <khushit.shah@nutanix.com>
References: <20261121095636.289814-1-haseebashraf091@gmail.com>
 <20261121204601.741616-1-haseebashraf091@gmail.com>
Content-Language: en-US
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20261121204601.741616-1-haseebashraf091@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Haseeb,

On 11/21/26 9:45 PM, Haseeb Ashraf wrote:
> From: Haseeb Ashraf <haseeb.ashraf@siemens.com>
> 
> Hi,
> 
> KVM presents a VHE-only EL2 (HCR_EL2.E2H RES1) to a nested guest unless
> KVM_ARM_VCPU_HAS_EL2_E2H0 is requested at vCPU initialization.  Guest
> hypervisors which only support nVHE, such as Xen, cannot run in that
> mode.  This series lets the user select an nVHE-only EL2 with:
> 
>   -M virt,virtualization=on -accel kvm \
>       -cpu host,SYSREG_ID_AA64MMFR1_EL1_VH=0
> 
> Following Marc's feedback on v1, this is built on Eric Auger's
> SYSREG_<REG>_<FIELD> framework instead of a new machine or CPU
> property.  It is an RFC because that framework is not merged yet.
> 
> Dependencies
> ------------
> 
> The series applies on top of the remaining patches of Eric's v11 [1],
> which are on his arm-cpu-model-v11-rc branch [2], rebased on current
> master.  On current master those patches need two mechanical build
> fixes: object_property_add() now takes &uint64_type_info, and
> kvm_feature_idx_to_idregs_idx() must sit after kvm_arm_sve_get_vls()
> instead of inside it.  The fixes belong to Eric's series and are not
> part of these three patches.
> 
> Questions
> ---------
> 
>  - KVM does not let userspace write ID_AA64MMFR1_EL1.VH, so the generic
>    "writable fields only" rule would not create the property.  Patch 2
>    treats VH as selected through a vCPU init feature and exposes it as
>    an exception.  Is that acceptable, or would you prefer a generic
>    representation of such fields in the framework?

Well I am a bit embarrassed to answer at that point since the series is not fully reviewed and this addition blurs some lines.

We have a way to introspect which fields that are let writable by KVM. We don't have any way to understand which bit can be set at VCPU INIT. So hardcoding the exception is the only way I see. If this tends to reproduce we can effectively have a table for such fields but I am not sure this would be needed at that point.

Overall it complexifies the logic & description of those properties because we said they apply at the end of the init chain and now we start to have a mix. We said SYSREG props were not supposed to replace legacy composite options. Now I guess it paves the way to have SYSREG props that do stuff at vcpu init and latter which is less obvious.   >  - Only VH is updated in QEMU's copy of the ID registers.  Other fields
>    which KVM derives from E2H0, for example ID_AA64MMFR4_EL1, are not
>    refreshed.  Is that acceptable, or should QEMU re-read the ID
what do you mean by other derived IDREG fields are not refreshed. Isn't it done automatically by KVM when you apply the VCPU init to reflect the above changes?

Adding Khushit in the loop.

Eric  >    registers after vCPU initialization?
> 
> Scope
> -----
> 
> TCG and HVF are unchanged by design.  The property is available for the
> host (and max) CPU model with KVM, when the host kernel advertises
> KVM_CAP_ARM_EL2_E2H0.  Xen and QNX already boot with TCG, where
> HCR_EL2.E2H is under the control of the guest.
> 
> Changes since v1 [3]:
> 
>   - Removed the dedicated virt machine and ARM CPU "vhe" properties.
>   - Switched to Eric's SYSREG ID-register framework and use
>     SYSREG_ID_AA64MMFR1_EL1_VH to select an nVHE-only EL2.
>   - Exposed the property only when KVM advertises
>     KVM_CAP_ARM_EL2_E2H0.
>   - Derived KVM_ARM_VCPU_HAS_EL2_E2H0 from VH and rejected VH=0 when
>     virtualization is disabled.
>   - Added documentation and a KVM functional selftest which verifies
>     that the guest hypervisor initializes in nVHE mode.
> 
> Testing
> -------
> 
> Validation was performed on an AmpereOne A192-32X (Ampere-1a) running
> host kernel 6.18.29+3-arm64:
> 
>   - TCG-only, KVM-only and aarch64-linux-user builds succeeded.
>   - TCG rejects SYSREG_ID_AA64MMFR1_EL1_VH because the property does not
>     exist for that accelerator.
>   - The existing AArch64 KVM nVHE and VHE selftests pass under TCG.
>   - The arm-cpu-features qtest passes.
>   - Linux 6.12.67 initialized KVM in nVHE mode with VH=0 and in VHE mode
>     with VH=1; both boots reached login.
>   - QNX Hypervisor 8.0.5 reached login with both values and reported the
>     corresponding ID register state.
>   - Xen dom0 reached login with VH=0.  With VH=1, Xen did not boot.
>   - The complete AArch64 KVM functional suite passed, including the new
>     nVHE-only selftest.
> 
> Not tested: live migration, and hosts other than AmpereOne.
> 
> [1] https://patchew.org/QEMU/20261030131406.461599-1-eric.auger@redhat.com/
> [2] https://github.com/eauger/qemu/commits/arm-cpu-model-v11-rc
> [3] https://patchew.org/QEMU/20261121095636.289814-1-haseebashraf091@gmail.com/
> 
> Thanks,
> Haseeb
> 
> Haseeb Ashraf (3):
>   target/arm/kvm: Add kvm_arm_el2_e2h0_supported()
>   target/arm/kvm: Let SYSREG_ID_AA64MMFR1_EL1_VH select an nVHE EL2
>   tests/functional: Add a KVM selftest for an nVHE-only EL2
> 
>  docs/system/arm/cpu-features.rst     | 22 ++++++++++++
>  target/arm/cpu-idregs.h              | 31 +++++++++++++++++
>  target/arm/cpu64.c                   | 51 ++++++++++++++++++++++------
>  target/arm/kvm-stub.c                |  5 +++
>  target/arm/kvm.c                     | 29 ++++++++++++++--
>  target/arm/kvm_arm.h                 | 13 +++++++
>  tests/functional/aarch64/test_kvm.py | 22 ++++++++++--
>  7 files changed, 157 insertions(+), 16 deletions(-)


