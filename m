Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B35F606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 05:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YNinQQsE;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Zw+sunpC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMf6Y-0006hi-3c; Fri, 30 Oct 2026 01:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1xMf6V-0006hC-VI
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 01:24:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1xMf6S-00036r-UG
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 01:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793337874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KBC8M+EXpmsmz+qMXCkQWb3zpWvYgAc5rh/8y524IBk=;
 b=YNinQQsEs3a0CPPdC2e/mH8idURWEaQayJamWDFAr/1t8crtNTewqagnvdGjKTm39iTO/u
 IeniZkrGqPcnUFM9DU3rLcUGdinN1h1SJMYyrrruyhHSxLMlwDhK14HMkI0vMzQ+6LitrD
 zrsDnJV4O/vlWoJyo4ztZNzthJbFRxc=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-l_wpbVP0PRyjTHVLmRckYg-1; Fri, 30 Oct 2026 01:24:32 -0400
X-MC-Unique: l_wpbVP0PRyjTHVLmRckYg-1
X-Mimecast-MFC-AGG-ID: l_wpbVP0PRyjTHVLmRckYg_1793337872
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2e8ba4757baso3574945ad.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 22:24:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793337872; cv=none;
 d=google.com; s=arc-20260327;
 b=Ia8JpNaU5+OAI5o/aVVW339oDg88TcccTgghkLMU6bhdJ6ZDPruscUTd7mA0xIY/Xy
 n2d52J0EQrlcwe8XkBrcM5cB+fYrfA+MvtwL94Aw5PL3jb2THkQkioyTHJScSFuDt9kz
 Kfo9KxI5BTc87RTsoHXXO++fGJOwM8d95ZKOeKXQxPPSK/tjEC5HYX72v0rptFjmLfNJ
 169E/xKAlc+sJRCrlPHhhSrhw0+782rj+qKfX4aXQHNyjIaqP2+QmKUtsp4ZG+OVbP5j
 C6RjvnPum1K6aD2EEJRAMFOb8RewewERRNs36dbmNJ9RHJKSK/zi8NiyghOdOXjdAhQS
 N8UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KBC8M+EXpmsmz+qMXCkQWb3zpWvYgAc5rh/8y524IBk=;
 fh=vIa9z3vCjxWpqlgnde1QKYPQqrgJCuCnJ/mtsNmcHqI=;
 b=kkgTMSvUVb7z0VKmZzG57rgtH7W7AlfoF5UOYJqIJlpQfIUn/v/MC5VNS+aHqrYkVB
 i2eWuaeWPxo32+ioNZptdbShatId1ErcVW8yYDonLnsC9Ztb5k1rJz+htMff5PSIoeE4
 3HBXEcfz/V7ChTlqXFvVtjc87X1loeMQba2roicV6p+krq9nD+CnlBovUqZnY3qlJc1/
 gFXLVJX1ZRal0rDBf7EIHmKB7NKDUg0Sn8H78Mx9ttKwaLag4jkYGBblyl9t6XHARoO4
 JisgXsslupXik2EgN7E1jM/XHp25cK6pAvB4EqUiK/snATB+nUY7ow+8nVKn/QVlzXjG
 1E9w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793337872; x=1793942672; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KBC8M+EXpmsmz+qMXCkQWb3zpWvYgAc5rh/8y524IBk=;
 b=Zw+sunpCQuhy/byVwh4DSMwjAhj2iAy7XGgX3WFVAMDQCGAfXxtboHOtCCmoBDRjxR
 Gx0QH/NyeaTTsWVGDWJyIqIi0jPcOSPL9QUBGWPRrIIyoYa+1oW3D0jS3ZRLuQDot7TR
 R0MEftDY81VPOsk8WqPX35It8W2Fqk9KxvfdaBfpIa8h0xHHMtbKomRLpqI4n74qfHFf
 WI76QACE7ZTOmVdu+RviLwsNiO4ABDcEmz34mmB1QfEjWygen2NHPZp7BbaoPI9NGxy0
 o+6nDnGMoulNMizvTddsUym8ZUcTxIDXdeXU5Ip0EIYFt/i+FN+1X+22D9tASVpjWeJM
 oiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793337872; x=1793942672;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KBC8M+EXpmsmz+qMXCkQWb3zpWvYgAc5rh/8y524IBk=;
 b=IVDK7ftGMHDG/Hv/cj6eU8vCh0YLK/9JQYFglk9+HO+MmKqanWuDUQOVFCYBBx5T0s
 s5XLml2CRYWfcJ9rsChegooLrKbi3+MxchjGgQCqmyyz5GTo6YtHbBXm8GtSdgE8Pm28
 3/HQIHJOikAWY5QKr+tIZSAaZnQetKB6ssTcZvMSKHH5qlcthXUf4lN/8B95rQEphdmw
 PMK0anDUsRfTPIecap5Ugv2BGvL895B1q7dewDkKgci6g8sjnc5GA7JnXIBwoirSpSOe
 UTDD3roapW+oQ7r5dL+BbIA5iL4x728qnSyD1eiUef0uyhgGgcbrhkRyREGBzC97l4mE
 F3bQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwo/R/Wc8hHkvQyp/CJLBTVYTBSfNi/FVdP4w80utdaPO/d0sLs6xnDZlBfczMnfCUXExOi4BZW0kXC@nongnu.org
X-Gm-Message-State: AFq9FYIwwMLXpjiFV9c4ED4COi38DvRuXKRb0OQt2YcOa//3g3X/myeX
 OvIDGnu6QvacYbIUOgkkrcbVDZ4vtcmpvtXp0gCPArwuJcbcAOaOfE8IsbGQeOrWyWdOIYalA2A
 WICN7qlqcxqxLpq2rk6sJDJrWf7RDdHBKD4o2A7tAI4p2BG83//aIEOIqrma7ahTFt/H2ALIhl6
 cN3xmyO1U+MkEeTMSANB9YJVNSxdRJ9pw=
X-Gm-Gg: AYBFou14yrjR5dsrqXLZuS0PzTpw4bf/uULRlMiLNIiY782IQgspWkA311WIibFAQs5
 bZ5/KhXfK5KDV0v/rmp7KP0fENhtyULiQ3ssYfsJBS+HQchWhvQ6M3yhudkDGHFOHdULoSp/GPw
 U6GC6zE/aD308aFc3rCjG1RM7+k//KYWiqrn+NDjdQedJYoUUAWFgxxg3vkz2N9oqjWwYUsIVeZ
 wWWxXYKUuTzQ3vV
X-Received: by 2002:a17:903:37cf:b0:2e9:6352:6c61 with SMTP id
 d9443c01a7336-2eb3648b9b7mr15027095ad.19.1793337871518; 
 Thu, 29 Oct 2026 22:24:31 -0700 (PDT)
X-Received: by 2002:a17:903:37cf:b0:2e9:6352:6c61 with SMTP id
 d9443c01a7336-2eb3648b9b7mr15026775ad.19.1793337870798; Thu, 29 Oct 2026
 22:24:30 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029143742.294275-1-eric.auger@redhat.com>
 <20261029143742.294275-8-eric.auger@redhat.com>
In-Reply-To: <20261029143742.294275-8-eric.auger@redhat.com>
From: Mohammadfaiz Bawa <mbawa@redhat.com>
Date: Fri, 30 Oct 2026 10:54:14 +0530
X-Gm-Features: AclHuK9rJaQ3QkOa5-YySB_0J9sgSoCkfqLhWQ2TUlI9RHxhRlvSLvLPaXig2Uw
Message-ID: <CAJg9KkwT1k4_XRsLfKy=Oheo9SMrgdd5Yp3XsGQQPNXM+81FXQ@mail.gmail.com>
Subject: Re: [PATCH v2 for-11.2 7/9] target/kvm: Pass an Error handle to
 kvm_arch_init_vcpu
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
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mbawa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 8:08=E2=80=AFPM Eric Auger <eric.auger@redhat.com> =
wrote:
>
> The 2 callers of kvm_arch_init_vcpu(), namely kvm_rebind_vcpus()
> and kvm_init_vcpu() are passed an Error handle. So it is a pity
> not using it in kvm_arch_init_vcpu(). Also, in the future, the
> error handle could be passed to other functions called inside.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Gustavo Romero <gromero@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Sebastian Ott <sebott@redhat.com>
>
> ---
>
> v1 -> v2:
> - fixed comma in target/ppc/kvm.c
> ---
>  include/system/kvm.h       |  2 +-
>  accel/kvm/kvm-all.c        | 15 +++++++--------
>  target/arm/kvm.c           | 26 +++++++++++++-------------
>  target/i386/kvm/kvm.c      | 22 ++++++++++++----------
>  target/loongarch/kvm/kvm.c | 27 +++++++++------------------
>  target/ppc/kvm.c           | 10 +++++++---
>  target/riscv/kvm/kvm-cpu.c |  6 +++++-
>  target/s390x/kvm/kvm.c     |  2 +-
>  8 files changed, 55 insertions(+), 55 deletions(-)
>
> diff --git a/include/system/kvm.h b/include/system/kvm.h
> index d29624034c..26d55cc699 100644
> --- a/include/system/kvm.h
> +++ b/include/system/kvm.h
> @@ -358,7 +358,7 @@ int kvm_arch_get_default_type(MachineState *ms);
>  int kvm_arch_init(MachineState *ms, KVMState *s);
>
>  int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp);
> -int kvm_arch_init_vcpu(CPUState *cpu);
> +int kvm_arch_init_vcpu(CPUState *cpu, Error **errp);
>  int kvm_arch_destroy_vcpu(CPUState *cpu);
>
>  #ifdef TARGET_KVM_HAVE_RESET_PARKED_VCPU
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index db8fba53f3..ddc82f9775 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -504,11 +504,11 @@ static int kvm_rebind_vcpus(Error **errp)
>              }
>          }
>
> -        ret =3D kvm_arch_init_vcpu(cpu);
> +        ret =3D kvm_arch_init_vcpu(cpu, errp);
>          if (ret < 0) {
> -            error_setg_errno(errp, -ret,
> -                             "kvm_init_vcpu: kvm_arch_init_vcpu failed (=
%lu)",
> -                             vcpu_id);
> +            error_prepend(errp,
> +                          "kvm_init_vcpu: kvm_arch_init_vcpu failed (%lu=
)",
> +                          vcpu_id);
>          }
>
>          close(cpu->kvm_vcpu_stats_fd);
> @@ -751,11 +751,10 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
>          }
>      }
>
> -    ret =3D kvm_arch_init_vcpu(cpu);
> +    ret =3D kvm_arch_init_vcpu(cpu, errp);
>      if (ret < 0) {
> -        error_setg_errno(errp, -ret,
> -                         "kvm_init_vcpu: kvm_arch_init_vcpu failed (%lu)=
",
> -                         kvm_arch_vcpu_id(cpu));
> +        error_prepend(errp, "kvm_init_vcpu: kvm_arch_init_vcpu failed (%=
lu)",
> +                      kvm_arch_vcpu_id(cpu));
>      }
>      cpu->kvm_vcpu_stats_fd =3D kvm_vcpu_ioctl(cpu, KVM_GET_STATS_FD, NUL=
L);
>
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index d454346037..2d37c2bfb4 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -2015,17 +2015,16 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error=
 **errp)
>      return 0;
>  }
>
> -int kvm_arch_init_vcpu(CPUState *cs)
> +int kvm_arch_init_vcpu(CPUState *cs, Error **errp)
>  {
>      int ret;
>      uint64_t mpidr;
>      ARMCPU *cpu =3D ARM_CPU(cs);
>      CPUARMState *env =3D &cpu->env;
> -    Error *local_err =3D NULL;
>      uint64_t psciver;
>
>      if (cpu->kvm_target =3D=3D QEMU_KVM_ARM_TARGET_NONE) {
> -        error_report("KVM is not supported for this guest CPU type");
> +        error_setg(errp, "KVM is not supported for this guest CPU type")=
;
>          return -EINVAL;
>      }
>
> @@ -2071,16 +2070,19 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      /* Do KVM_ARM_VCPU_INIT ioctl */
>      ret =3D kvm_arm_vcpu_init(cpu);
>      if (ret) {
> +        error_setg_errno(errp, -ret, "failed kvm_arm_vcpu_init");
>          return ret;
>      }
>
>      if (cpu_isar_feature(aa64_sve, cpu)) {
>          ret =3D kvm_arm_sve_set_vls(cpu);
>          if (ret) {
> +            error_setg_errno(errp, -ret, "failed kvm_arm_sve_set_vls");
>              return ret;
>          }
>          ret =3D kvm_arm_vcpu_finalize(cpu, KVM_ARM_VCPU_SVE);
>          if (ret) {
> +            error_setg_errno(errp, -ret, "failed kvm_arm_vcpu_finalize")=
;
>              return ret;
>          }
>      }
> @@ -2089,11 +2091,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          psciver =3D cpu->psci_version;
>          ret =3D kvm_set_one_reg(cs, KVM_REG_ARM_PSCI_VERSION, &psciver);
>          if (ret) {
> -            error_report("KVM in this kernel does not support PSCI versi=
on %d.%d",
> -                         (int) PSCI_VERSION_MAJOR(psciver),
> -                         (int) PSCI_VERSION_MINOR(psciver));
> -            error_printf("Consider setting the kvm-psci-version property=
 on the "
> -                         "migration source.\n");
> +            error_setg_errno(errp, -ret,
> +                             "KVM in this kernel does not support PSCI v=
ersion %d.%d",
> +                             (int) PSCI_VERSION_MAJOR(psciver),
> +                             (int) PSCI_VERSION_MINOR(psciver));
> +            error_append_hint(errp, "Consider setting the kvm-psci-versi=
on property "
> +                              "on the migration source.\n");
>              return ret;
>          }
>      }
> @@ -2115,16 +2118,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
>       */
>      ret =3D kvm_get_one_reg(cs, ARM64_SYS_REG(ARM_CPU_ID_MPIDR), &mpidr)=
;
>      if (ret) {
> +        error_setg_errno(errp, -ret, "failed retrieving MPIDR value");
>          return ret;
>      }
>      SET_IDREG(&cpu->isar, MPIDR, mpidr);
>      cpu->mp_affinity =3D mpidr & ARM64_AFFINITY_MASK;
>
> -    ret =3D kvm_arm_init_cpreg_list(cpu, &local_err);
> -    if (ret < 0) {
> -        error_report_err(local_err);
> -    }
> -    return ret;
> +    return kvm_arm_init_cpreg_list(cpu, errp);
>  }
>
>  int kvm_arch_destroy_vcpu(CPUState *cs)
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index da922f72d7..474322b073 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -2218,7 +2218,7 @@ static void kvm_init_pmu_info(struct kvm_cpuid2 *cp=
uid, X86CPU *cpu)
>      }
>  }
>
> -int kvm_arch_init_vcpu(CPUState *cs)
> +int kvm_arch_init_vcpu(CPUState *cs, Error **errp)
>  {
>      struct {
>          struct kvm_cpuid2 cpuid;
> @@ -2240,12 +2240,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      int kvm_base =3D KVM_CPUID_SIGNATURE;
>      int max_nested_state_len;
>      int r;
> -    Error *local_err =3D NULL;
>
>      if (current_machine->cgs) {
>          r =3D x86_confidential_guest_check_features(
>                  X86_CONFIDENTIAL_GUEST(current_machine->cgs), cs);
>          if (r < 0) {
> +            error_setg(errp, "failed x86_confidential_guest_check_featur=
es (%d)", r);
>              return r;
>          }
>      }
> @@ -2258,6 +2258,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>
>      r =3D kvm_arch_set_tsc_khz(cs);
>      if (r < 0) {
> +        error_setg(errp, "failed setting tsc_khz (%d)", r);
>          return r;
>      }
>
> @@ -2285,14 +2286,14 @@ int kvm_arch_init_vcpu(CPUState *cs)
>       * can still proceed and check/expand Hyper-V enlightenments here so=
 legacy
>       * behavior is preserved.
>       */
> -    if (!kvm_hyperv_expand_features(cpu, &local_err)) {
> -        error_report_err(local_err);
> +    if (!kvm_hyperv_expand_features(cpu, errp)) {
>          return -ENOSYS;
>      }
>
>      if (hyperv_enabled(cpu)) {
>          r =3D hyperv_init_vcpu(cpu);
>          if (r) {
> +            error_setg_errno(errp, -r, "failed hyperv_init_vcpu");
>              return r;
>          }
>
> @@ -2371,6 +2372,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>
>          r =3D kvm_xen_init_vcpu(cs);
>          if (r) {
> +            error_setg_errno(errp, -r, "failed kvm_xen_init_vcpu");
>              return r;
>          }
>
> @@ -2419,12 +2421,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
>
>          ret =3D kvm_get_mce_cap_supported(cs->kvm_state, &mcg_cap, &bank=
s);
>          if (ret < 0) {
> -            fprintf(stderr, "kvm_get_mce_cap_supported: %s", strerror(-r=
et));
> +            error_setg_errno(errp, -ret, "failed kvm_get_mce_cap_support=
ed");
>              return ret;
>          }
>
>          if (banks < (env->mcg_cap & MCG_CAP_BANKS_MASK)) {
> -            error_report("kvm: Unsupported MCE bank count (QEMU =3D %d, =
KVM =3D %d)",
> +            error_setg(errp, "kvm: Unsupported MCE bank count (QEMU =3D =
%d, KVM =3D %d)",
>                           (int)(env->mcg_cap & MCG_CAP_BANKS_MASK), banks=
);
>              return -ENOTSUP;
>          }
> @@ -2432,7 +2434,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          unsupported_caps =3D env->mcg_cap & ~(mcg_cap | MCG_CAP_BANKS_MA=
SK);
>          if (unsupported_caps) {
>              if (unsupported_caps & MCG_LMCE_P) {
> -                error_report("kvm: LMCE not supported");
> +                error_setg(errp, "kvm: LMCE not supported");
>                  return -ENOTSUP;
>              }
>              warn_report("Unsupported MCG_CAP bits: 0x%" PRIx64,
> @@ -2442,7 +2444,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          env->mcg_cap &=3D mcg_cap | MCG_CAP_BANKS_MASK;
>          ret =3D kvm_vcpu_ioctl(cs, KVM_X86_SETUP_MCE, &env->mcg_cap);
>          if (ret < 0) {
> -            fprintf(stderr, "KVM_X86_SETUP_MCE: %s", strerror(-ret));
> +            error_setg_errno(errp, -ret, "failed KVM_X86_SETUP_MCE");
>              return ret;
>          }
>      }
> @@ -2470,9 +2472,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
>              error_setg(&invtsc_mig_blocker,
>                         "State blocked by non-migratable CPU device"
>                         " (invtsc flag)");
> -            r =3D migrate_add_blocker(&invtsc_mig_blocker, &local_err);
> +            r =3D migrate_add_blocker(&invtsc_mig_blocker, errp);
>              if (r < 0) {
> -                error_report_err(local_err);
>                  return r;
>              }
>          }
> @@ -2501,6 +2502,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      cpuid_data.cpuid.padding =3D 0;
>      r =3D kvm_vcpu_ioctl(cs, KVM_SET_CPUID2, &cpuid_data);
>      if (r) {
> +        error_setg_errno(errp, -r, "failed KVM_SET_CPUID2");
>          goto fail;
>      }
>      kvm_init_xsave(env);
> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
> index 7ca95181a1..db39267375 100644
> --- a/target/loongarch/kvm/kvm.c
> +++ b/target/loongarch/kvm/kvm.c
> @@ -1320,11 +1320,10 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error=
 **errp)
>      return 0;
>  }
>
> -int kvm_arch_init_vcpu(CPUState *cs)
> +int kvm_arch_init_vcpu(CPUState *cs, Error **errp)
>  {
>      uint64_t val;
>      int ret;
> -    Error *local_err =3D NULL;
>      LoongArchCPU *cpu =3D LOONGARCH_CPU(cs);
>
>      cpu->vmsentry =3D qemu_add_vm_change_state_handler(
> @@ -1334,51 +1333,43 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          brk_insn =3D val;
>      }
>
> -    ret =3D kvm_cpu_check_lsx(cs, &local_err);
> +    ret =3D kvm_cpu_check_lsx(cs, errp);
>      if (ret < 0) {
> -        error_report_err(local_err);
>          return ret;
>      }
>
> -    ret =3D kvm_cpu_check_lasx(cs, &local_err);
> +    ret =3D kvm_cpu_check_lasx(cs, errp);
>      if (ret < 0) {
> -        error_report_err(local_err);
>          return ret;
>      }
>
> -    ret =3D kvm_cpu_check_lbt(cs, &local_err);
> +    ret =3D kvm_cpu_check_lbt(cs, errp);
>      if (ret < 0) {
> -        error_report_err(local_err);
>          return ret;
>      }
>
> -    ret =3D kvm_cpu_check_pmu(cs, &local_err);
> +    ret =3D kvm_cpu_check_pmu(cs, errp);
>      if (ret < 0) {
> -        error_report_err(local_err);
>          return ret;
>      }
>
> -    ret =3D kvm_cpu_check_pv_features(cs, &local_err);
> +    ret =3D kvm_cpu_check_pv_features(cs, errp);
>      if (ret < 0) {
> -        error_report_err(local_err);
>          return ret;
>      }
>
> -    ret =3D kvm_cpu_check_ptw(cs, &local_err);
> +    ret =3D kvm_cpu_check_ptw(cs, errp);
>      if (ret < 0) {
> -        error_report_err(local_err);
>          return ret;
>      }
>
> -    ret =3D kvm_cpu_check_msgint(cs, &local_err);
> +    ret =3D kvm_cpu_check_msgint(cs, errp);
>      if (ret < 0) {
> -        error_report_err(local_err);
>          return ret;
>      }
>
> -    ret =3D kvm_cpu_check_misc_v1_1(cs, &local_err);
> +    ret =3D kvm_cpu_check_misc_v1_1(cs, errp);
>      if (ret < 0) {
> -        error_report_err(local_err);
>          return ret;
>      }
>
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 8e89a6c665..cd19f7a6fd 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -484,7 +484,7 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **e=
rrp)
>      return 0;
>  }
>
> -int kvm_arch_init_vcpu(CPUState *cs)
> +int kvm_arch_init_vcpu(CPUState *cs, Error **errp)
>  {
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>      CPUPPCState *cenv =3D &cpu->env;
> @@ -493,9 +493,10 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      /* Synchronize sregs with kvm */
>      ret =3D kvm_arch_sync_sregs(cpu);
>      if (ret) {
> +        error_setg_errno(errp, -ret, "Register sync failed");
>          if (ret =3D=3D -EINVAL) {
> -            error_report("Register sync failed... If you're using kvm-hv=
.ko,"
> -                         " only \"-cpu host\" is possible");
> +            error_append_hint(errp, "If you're using kvm-hv.ko,"
> +                              " only \"-cpu host\" is possible\n");
>          }
>          return ret;
>      }
> @@ -504,6 +505,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      case POWERPC_MMU_BOOKE206:
>          /* This target supports access to KVM's guest TLB */
>          ret =3D kvm_booke206_tlb_init(cpu);
> +        if (ret < 0) {
> +            error_setg_errno(errp, -ret, "failed kvm_booke206_tlb_init")=
;
> +        }
>          break;
>      case POWERPC_MMU_2_07:
>          if (!cap_htm && !kvmppc_is_pr(cs->kvm_state)) {
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 5a82a63b82..523b515f2a 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1605,7 +1605,7 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error *=
*errp)
>      return 0;
>  }
>
> -int kvm_arch_init_vcpu(CPUState *cs)
> +int kvm_arch_init_vcpu(CPUState *cs, Error **errp)
>  {
>      int ret =3D 0;
>      RISCVCPU *cpu =3D RISCV_CPU(cs);
> @@ -1615,6 +1615,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      if (!object_dynamic_cast(OBJECT(cpu), TYPE_RISCV_CPU_HOST)) {
>          ret =3D kvm_vcpu_set_machine_ids(cpu, cs);
>          if (ret !=3D 0) {
> +            error_setg_errno(errp, -ret, "failed setting machine id");
>              return ret;
>          }
>      }
> @@ -1623,6 +1624,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      kvm_riscv_update_cpu_cfg_isa_ext(cpu, cs);
>
>      ret =3D kvm_vcpu_enable_sbi_dbcn(cpu, cs);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "failed kvm_vcpu_enable_sbi_dbcn");
> +    }
>
>      return ret;
>  }
> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> index dc67e84886..76dd1e67c0 100644
> --- a/target/s390x/kvm/kvm.c
> +++ b/target/s390x/kvm/kvm.c
> @@ -403,7 +403,7 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **e=
rrp)
>      return 0;
>  }
>
> -int kvm_arch_init_vcpu(CPUState *cs)
> +int kvm_arch_init_vcpu(CPUState *cs, Error **errp)
>  {
>      unsigned int max_cpus =3D MACHINE(qdev_get_machine())->smp.max_cpus;
>      S390CPU *cpu =3D S390_CPU(cs);
> --
> 2.53.0
>

Reviewed-by: Mohammadfaiz Bawa <mbawa@redhat.com>


