Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6626E606A32F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 05:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D0YaDHks;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=FwtCrMSS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMf8K-0007JB-Pp; Fri, 30 Oct 2026 01:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1xMf8H-0007IN-IT
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 01:26:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1xMf8F-0003MZ-4s
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 01:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793337986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TnBvos9RVeKePGwIM6MDBb1D9bojitbnrupJwU4Zieg=;
 b=D0YaDHks4NqCopmJoUQFh6LFuEURnzQ3MY+BLq3URgmEPgu/uyNqzmLq3pFPc9ghJYWW1G
 cGvCoecAmFjMavNQ27lB7T/Ks8YNe22LzsZtXG9OAhwZlacfedIlgjlvR0p9nCW5rneolx
 T3NuNHehjttPmgheyA5WwZ4sqovWtqk=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-DJwicfwMMQSrT5FKbNxJ9A-1; Fri, 30 Oct 2026 01:26:19 -0400
X-MC-Unique: DJwicfwMMQSrT5FKbNxJ9A-1
X-Mimecast-MFC-AGG-ID: DJwicfwMMQSrT5FKbNxJ9A_1793337979
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cd5fd34fee0so218250a12.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 22:26:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793337979; cv=none;
 d=google.com; s=arc-20260327;
 b=TIAhIRGzEJp2K/4OK9/Mx57wphoZNDBgH19o1E2DY/IUrRzy3IXOP/NDLpp9p8hKtD
 BE8Ak2r94J5HF3dM9OzCGB4VkBiqat8remYa5lBjo02dpUUn+9U4lGjprzo/q39qigSd
 VCmo3kA21L+9qb9+r3gMjUc/EI43mv4rL3CqCSOUP4PuThqTJ7kVafdAAZBJOon2yJAv
 KareB2kQfqdkp/CrJllm0dzl17Ccl+M37vsHbTUfgDAcMzR1nN7dnLkPSxCsUs/3hqKc
 fPcp6XwtCmfA5Mz+iyZ30NhtTyoh0yM5FepH7tG7c7sI1Q2BRNF1+2BhUmD9knY2RZD5
 kMhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TnBvos9RVeKePGwIM6MDBb1D9bojitbnrupJwU4Zieg=;
 fh=oN6QfdJVBmszYXT7Os1pwNdmCBDJEZCrahLN2/rpfgU=;
 b=fI0D5s/NUaIt8C4C4DDXFDnRRMbYKOB7eNODirfO3ddbOcwQaI+4aptRc/D1xpPBmr
 sxjvKgfydt/1qk9DqpkL+TGs6Z0IUVtJxGkCjdmzQCX5wUlXYU1foKzzODg5Hl2i1ujB
 dgEsV/DvB73oD4mUloyTbKTYGPir7S11e/Usu89nK/2Te1hIUcaZVakb90w/otW/gEML
 uR9esvHs5/3iUK5SQ4zYSsjwsQfY3O3ygy8Hm9dkmGljVb4i8h6f68QLId4Au+dkFots
 4kGH7vnxJ6LHqUB8jK54xOLm3laUiBTZb/1TorWlLv0r9JroxaIi+MYYC3i4tLOfQ+9/
 zpBA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793337979; x=1793942779; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TnBvos9RVeKePGwIM6MDBb1D9bojitbnrupJwU4Zieg=;
 b=FwtCrMSSBQAgGOjsZ9sBrsi//iAD7GRIoy2nxJu7T0J5KywRS7lFvFrs73Nfjvxu1N
 /CSHNIJVIiFcqa7qp2YXIk2CxuiMaWUfiAwT+/xQx67dvZcJKGX7DXt9IdOsXUXHlVuY
 qPnyik16KHcJOyHUCQxRYZ6WfVCxJGCqIk2w4MURWMs1JrYcybhlV8sRgaP8jVDcyWGx
 7U+3RJHb0PqQZSOyexE4rRfgL5ix1SwlsyIni15eqsujBeTBiGZn4X3m9cuniT+QTmrG
 tuwejExrcX++2hHd+LEscINH5HBS9pjbaYSQW2X4aW/sluNbl6T2kwRP4q/eIuD4LwWm
 J3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793337979; x=1793942779;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TnBvos9RVeKePGwIM6MDBb1D9bojitbnrupJwU4Zieg=;
 b=ZMNRP1NujVSkqYM6xKqRmKwEvLmGR4Nb5Igv5GKoZ7YEVyNMBzusDMgRBlLb2EcOTO
 mtB1fhGGib1B1rlJqVoO3eIxXXXZiRKHjWbIFoMTyurakCTNsuQdx03qB+NAMnSdYivm
 5AfmFSweG/TxnUpjiXO/NXZC++6mEWH3zYEmLULuaBi3Gnw/pNWkfBTugHnFl7+faila
 IX2NMSswLE//aSd4p1ChxvAY8c3rqs9RJyWkrsCv2wBMjThJMpo9ICE766gbXqR6dfUm
 C7tVbjqnAmuSLd+yzCWnTCdHPts/NMURjhnNHM/jaM2mOzMjW8PnOppWklYL+0bjC3Wz
 Tpdg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzOz/V4eyQ5/9I9qJwabt5vsPOGJHOUVEV3Xle5ZndaOwkPtpPsILiJR2lFfUS9qM9Hx2hKU7ZqWjQQ@nongnu.org
X-Gm-Message-State: AFq9FYKOlmpw8c03oHVnxJ3mxh8tNshDdiif000KZMxRfx8OhaOdDfkq
 cIc+Np/3jMDY2SXFTEDc37pBefsYnfeAjLCbx23JtvnY1FaPYSAd9fUpYP137lBN0bsfaNBHnsl
 629C7DUvwqEk7DdG5PqAQM9s7G/sWyZGl4eW/zmfl+7p2bPUmZjH2Co5zW0+AYTKaLkLzNd0YSY
 G2nDuuL2Rfd6xbFgPRZulH8TTPG7w14a4=
X-Gm-Gg: AYBFou2TDkiCdPZ/+wXRiiNKuoTsIGDBAcDzYqlCayJ+OoMbZeMPsUwgmGuszv9+mff
 7WmVPi65+cPRLBhSrj5jyT9EnP3Frs5mCash+SZQ7ihx354N/Book9CLWr4VyUPCncVLeKpIvWC
 aFtE8rZvw0pkWNCGhtdyO9Yzr3jl12Pz0IL6MPLutH3CBkLfSNg/i1dgdQ2VCMw8AbytV+C2KZl
 ePfz5BVZ0UrKf/s
X-Received: by 2002:a17:90b:4c11:b0:3ac:8897:7b88 with SMTP id
 98e67ed59e1d1-3ae8985cb53mr996732a91.58.1793337978582; 
 Thu, 29 Oct 2026 22:26:18 -0700 (PDT)
X-Received: by 2002:a17:90b:4c11:b0:3ac:8897:7b88 with SMTP id
 98e67ed59e1d1-3ae8985cb53mr996710a91.58.1793337978119; Thu, 29 Oct 2026
 22:26:18 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029143742.294275-1-eric.auger@redhat.com>
 <20261029143742.294275-9-eric.auger@redhat.com>
In-Reply-To: <20261029143742.294275-9-eric.auger@redhat.com>
From: Mohammadfaiz Bawa <mbawa@redhat.com>
Date: Fri, 30 Oct 2026 10:56:01 +0530
X-Gm-Features: AclHuK_R-VEXVGZs9Wp4-jXBd10GMHKMhNuEBJ026QFIXmMT1wUrLKrjVdjKvn8
Message-ID: <CAJg9KkytEHptR1g4t8PFnaSTKF+uDv_-a1tX7CXvqrHnLPvrpA@mail.gmail.com>
Subject: Re: [PATCH v2 for-11.2 8/9] target/arm/kvm: Introduce
 kvm_arm_vcpu_prepare_init_features helper
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 peter.maydell@linaro.org, shaju.abraham@nutanix.com, khushit.shah@nutanix.com, 
 richard.henderson@linaro.org, pbonzini@redhat.com, skolothumtho@nvidia.com, 
 philmd@oss.qualcomm.com, 7746591750@163.com, maobibo@loongson.cn, 
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, 
 daniel.barboza@oss.qualcomm.com, milesg@linux.ibm.com, farman@linux.ibm.com, 
 cohuck@redhat.com, alireza.sanaee@huawei.com, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mbawa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 8:08=E2=80=AFPM Eric Auger <eric.auger@redhat.com> =
wrote:
>
> Factorize the code that initializes the kvm init features from the
> cpu settings in a helper. Use it in kvm_arch_init_vcpu(). Soon it will
> be used by another function.
>
> The only change in the code relates to the check of kvm_state. The
> future caller won't have the VM created when calling the helper and
> for this caller it is OK ignoring PSCI version setting.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Gustavo Romero <gromero@redhat.com>
> Reviewed-by: Sebastian Ott <sebott@redhat.com>
> ---
>  target/arm/kvm.c | 50 ++++++++++++++++++++++++++++--------------------
>  1 file changed, 29 insertions(+), 21 deletions(-)
>
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 2d37c2bfb4..1c5be9ecf4 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -2015,34 +2015,18 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error=
 **errp)
>      return 0;
>  }
>
> -int kvm_arch_init_vcpu(CPUState *cs, Error **errp)
> +/* Determine init features for this CPU */
> +static void kvm_arm_vcpu_prepare_init_features(ARMCPU *cpu)
>  {
> -    int ret;
> -    uint64_t mpidr;
> -    ARMCPU *cpu =3D ARM_CPU(cs);
> +    CPUState *cs =3D CPU(cpu);
>      CPUARMState *env =3D &cpu->env;
> -    uint64_t psciver;
>
> -    if (cpu->kvm_target =3D=3D QEMU_KVM_ARM_TARGET_NONE) {
> -        error_setg(errp, "KVM is not supported for this guest CPU type")=
;
> -        return -EINVAL;
> -    }
> -
> -    if (cpu->kvm_target =3D=3D QEMU_KVM_ARM_TARGET_CORTEX_A53 ||
> -        cpu->kvm_target =3D=3D QEMU_KVM_ARM_TARGET_CORTEX_A57) {
> -        warn_report_once("Using the cortex-a53 and cortex-a57 CPU types =
"
> -                         "with KVM is deprecated. Use the max or host CP=
U "
> -                         "types instead.");
> -    }
> -
> -    qemu_add_vm_change_state_handler(kvm_arm_vm_state_change, cpu);
> -
> -    /* Determine init features for this CPU */
>      memset(cpu->kvm_init_features, 0, sizeof(cpu->kvm_init_features));
> +
>      if (cs->start_powered_off) {
>          cpu->kvm_init_features[0] |=3D 1 << KVM_ARM_VCPU_POWER_OFF;
>      }
> -    if (cpu->psci_version !=3D QEMU_PSCI_VERSION_0_1 &&
> +    if (cpu->psci_version !=3D QEMU_PSCI_VERSION_0_1 && cs->kvm_state &&
>          kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PSCI_0_2)) {
>          /*
>           * Versions >=3D v0.2 are backward compatible with v0.2
> @@ -2066,6 +2050,30 @@ int kvm_arch_init_vcpu(CPUState *cs, Error **errp)
>      if (cpu->has_el2 && kvm_arm_el2_supported()) {
>          cpu->kvm_init_features[0] |=3D 1 << KVM_ARM_VCPU_HAS_EL2;
>      }
> +}
> +
> +int kvm_arch_init_vcpu(CPUState *cs, Error **errp)
> +{
> +    int ret;
> +    uint64_t mpidr;
> +    ARMCPU *cpu =3D ARM_CPU(cs);
> +    uint64_t psciver;
> +
> +    if (cpu->kvm_target =3D=3D QEMU_KVM_ARM_TARGET_NONE) {
> +        error_setg(errp, "KVM is not supported for this guest CPU type")=
;
> +        return -EINVAL;
> +    }
> +
> +    if (cpu->kvm_target =3D=3D QEMU_KVM_ARM_TARGET_CORTEX_A53 ||
> +        cpu->kvm_target =3D=3D QEMU_KVM_ARM_TARGET_CORTEX_A57) {
> +        warn_report_once("Using the cortex-a53 and cortex-a57 CPU types =
"
> +                         "with KVM is deprecated. Use the max or host CP=
U "
> +                         "types instead.");
> +    }
> +
> +    qemu_add_vm_change_state_handler(kvm_arm_vm_state_change, cpu);
> +
> +    kvm_arm_vcpu_prepare_init_features(cpu);
>
>      /* Do KVM_ARM_VCPU_INIT ioctl */
>      ret =3D kvm_arm_vcpu_init(cpu);
> --
> 2.53.0
>

Reviewed-by: Mohammadfaiz Bawa <mbawa@redhat.com>


