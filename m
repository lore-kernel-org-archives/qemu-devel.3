Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C91C606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 09:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Dji0cnk5;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=iKWWbF8E
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMMbY-0005Ac-1r; Thu, 29 Oct 2026 05:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xMMbV-00057T-SG
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 05:39:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xMMbU-0007Ad-91
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 05:39:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793266763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NP1mCJbsBfz3usRjgejt3jLi18Bxq0SToQ4xn+dDBL8=;
 b=Dji0cnk5bjEyMpyYwUX63h+LtXhdMI0pTL32fNO40arBx5VKKA80F6W9niEJcS6VbGM4/h
 5VYNgpKU+VgA8pGahgPfhVuOozai543WTTjm63ho/HpgjhkI/XpBvb047oS0YgTyizM13U
 DUQzRDAM279X8zTCfUjl01WWoeOVE88=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522--6gUL2FdPYSEJ-zxYvO-2A-1; Thu, 29 Oct 2026 05:39:22 -0400
X-MC-Unique: -6gUL2FdPYSEJ-zxYvO-2A-1
X-Mimecast-MFC-AGG-ID: -6gUL2FdPYSEJ-zxYvO-2A_1793266761
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48dfaaea30cso1266630f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 02:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793266761; x=1793871561; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NP1mCJbsBfz3usRjgejt3jLi18Bxq0SToQ4xn+dDBL8=;
 b=iKWWbF8ErHKR1gbFk/r+jJMjlgC7jqH953V/Iss8oYR6qviWb4hHUJ+KzWkSxTeT4x
 jawAn3eGewD98jqGcDtMmJMJn1kx6997FodnDFkkcfTNqdwvO+GsoHAtHvUVGTRKZeWu
 9xaDF7G8IpFywdDc9E672XaBYNInw5HCnCM/cgqAuJNfHQOS0h9S8BCMvt6IaWA6tLEP
 lm8RIfuLVLCNzFI4JTxnp/3jvUJS/gVV+CljJy1w0k4qRMR0lNKPymeL7J8jJLlKxRgg
 KfPQptljzt1xhYAv6UgNA6DH02xCrXI9/bV4oyWgFgdyZPrAUIkxTuBd4XZ8nrdho/Ai
 smVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793266761; x=1793871561;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NP1mCJbsBfz3usRjgejt3jLi18Bxq0SToQ4xn+dDBL8=;
 b=JBq3j6yDow6aA44ec26LAR1uVsLsWhWuCm3BIoyHVJ4/BXf2iAfQ1TwFR1zYuehUuV
 e7VApH9zX57IWi/dak7iLAiKMJXY5LEPFtWeGEdSLACrzu4zhf0lok2rD1AhvGwr+IDb
 2lCNCLwM6W9KIUaah05h+HEfjWpOb7ns4MnrN5IEzaIJrTfp4bNoYYtfs8y9gkMFw/Wl
 lt0fVlsLDUiTt65f4HeRbIv02O//D3Ew5ublkLsHOtgcqCdsjeGbHPOqlDLSQfc26O47
 ROa3Mo/1cPBX9RErHVRsIDIfKJBGh6uwlN3m3UP7hynJ7Q3AcE9xDSW7mckHeZkoYSol
 xTaQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy0lzGy/NzkiGbPz/W69EYCrEsezYKFElTvztgVDiDLRsDZ3aiN/3Ec7R8gjAjZmzwIZOMaKujPgqGj@nongnu.org
X-Gm-Message-State: AFq9FYKzgtwIl9BqmUTTO5eEmshS8PbIbJx9bN+2SDzvXlo5KVENN3ld
 qtWxZlSJA13af4fEB1qW6qJ+n969f7/RMVDrmUhqvf93n0qFhAOGWXcd+VKwL0A+CKxaGX30ZeV
 GAOtHovSRh5QozP1enJS52TC3r9kNzYM/aqe0IJIWNw+D1XOFlLoiLsfs
X-Gm-Gg: AYBFou11MfsxSo/+2Fy68oO7wuEZWPuABGcN4SW+OwrmkT5Wf53/Dj1T9k4DEs3J9kX
 JabvUQlzx39SHlJJk22dNV8E7zfNCnnPW5dKvdX3FiQMuySiRzbIvEHgjSkrfc4AbVFKiUH0sVa
 bSydA+ysxyQ86lngXNR4xTrwfUSGxzjPkmmak/Ols4ylzT9OlIwanEx4LkG/YB+ayK9SNLbok8h
 p3askU/m8L5ifXbe0wkY2DdQT/J35g4ranbEO1cYaEHiSF6EjVmgREoVrYlw5r+q5FIkVMWCOiR
 tVchHawEDnMipPYEwI/dPmyrshaOUmDYhLxNMn4IvYxerOoHguulw6kekN/erJPKBsYetQMgwOB
 6CMNZyQlrtlTFmNHNlbpfZwI+u+/pm6Tugw==
X-Received: by 2002:a05:600c:8b72:b0:4a6:eca1:7d5c with SMTP id
 5b1f17b1804b1-4a9676d428amr102875605e9.32.1793266761052; 
 Thu, 29 Oct 2026 02:39:21 -0700 (PDT)
X-Received: by 2002:a05:600c:8b72:b0:4a6:eca1:7d5c with SMTP id
 5b1f17b1804b1-4a9676d428amr102875155e9.32.1793266760710; 
 Thu, 29 Oct 2026 02:39:20 -0700 (PDT)
Received: from x1 ([151.41.153.165]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80286fc6sm60137785e9.15.2026.10.29.02.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 02:39:20 -0700 (PDT)
Date: Thu, 29 Oct 2026 10:39:16 +0100
From: Gustavo Romero <gromero@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 peter.maydell@linaro.org, shaju.abraham@nutanix.com, khushit.shah@nutanix.com, 
 richard.henderson@linaro.org, pbonzini@redhat.com, skolothumtho@nvidia.com, 
 philmd@oss.qualcomm.com, 7746591750@163.com, maobibo@loongson.cn,
 harshpb@linux.ibm.com, 
 amachhiw@linux.ibm.com, daniel.barboza@oss.qualcomm.com, milesg@linux.ibm.com, 
 farman@linux.ibm.com, cohuck@redhat.com, armbru@redhat.com, mbawa@redhat.com
Subject: Re: [PATCH for-11.2 6/9] target/arm/kvm: Pass an error handle to
 kvm_arm_init_cpreg_list
Message-ID: <7olgxurssdwq4g2r3tfmshmjerynxk5in7j6uwusepsfz5y467@myddnvnmhl2b>
References: <20261029092307.281287-1-eric.auger@redhat.com>
 <20261029092307.281287-7-eric.auger@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029092307.281287-7-eric.auger@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gromero@redhat.com;
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

Hi Eric,

On Thu, Oct 29, 2026 at 10:20:18AM +0100, Eric Auger wrote:
> Pass an error handle to kvm_arm_init_cpreg_list(). A Subsequent patch
> will do the same with kvm_arch_init_vcpu().
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  target/arm/kvm.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 28f199c03f..d454346037 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -872,6 +872,7 @@ static bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx)
>  /**
>   * kvm_arm_init_cpreg_list:
>   * @cpu: ARMCPU
> + * @errp: Error handle
>   *
>   * Initialize the ARMCPU cpreg list according to the kernel's
>   * definition of what CPU registers it knows about (and throw away
> @@ -879,7 +880,7 @@ static bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx)
>   *
>   * Returns: 0 if success, else < 0 error code
>   */
> -static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
> +static int kvm_arm_init_cpreg_list(ARMCPU *cpu, Error **errp)
>  {
>      struct kvm_reg_list rl;
>      struct kvm_reg_list *rlp;
> @@ -889,12 +890,17 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
>      rl.n = 0;
>      ret = kvm_vcpu_ioctl(cs, KVM_GET_REG_LIST, &rl);
>      if (ret != -E2BIG) {
> +        if (ret < 0) {
> +            error_setg_errno(errp, -ret,
> +                             "failed to get KVM register list size");
> +        }
>          return ret;
>      }
>      rlp = g_malloc(sizeof(struct kvm_reg_list) + rl.n * sizeof(uint64_t));
>      rlp->n = rl.n;
>      ret = kvm_vcpu_ioctl(cs, KVM_GET_REG_LIST, rlp);
>      if (ret) {
> +        error_setg_errno(errp, -ret, "failed to get KVM register list");
>          goto out;
>      }
>      /* Sort the list we get back from the kernel, since cpreg_tuples
> @@ -911,7 +917,7 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
>          case KVM_REG_SIZE_U64:
>              break;
>          default:
> -            fprintf(stderr, "Can't handle size of register in kernel list\n");
> +            error_setg(errp, "Can't handle size of register in kernel list");
>              ret = -EINVAL;
>              goto out;
>          }
> @@ -937,7 +943,7 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
>          /* Shouldn't happen unless kernel is inconsistent about
>           * what registers exist.
>           */
> -        fprintf(stderr, "Initial read of kernel register state failed\n");
> +        error_setg(errp, "Initial read of kernel register state failed");
>          ret = -EINVAL;
>          goto out;
>      }
> @@ -2015,6 +2021,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      uint64_t mpidr;
>      ARMCPU *cpu = ARM_CPU(cs);
>      CPUARMState *env = &cpu->env;
> +    Error *local_err = NULL;
>      uint64_t psciver;
>  
>      if (cpu->kvm_target == QEMU_KVM_ARM_TARGET_NONE) {
> @@ -2113,7 +2120,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      SET_IDREG(&cpu->isar, MPIDR, mpidr);
>      cpu->mp_affinity = mpidr & ARM64_AFFINITY_MASK;
>  
> -    return kvm_arm_init_cpreg_list(cpu);
> +    ret = kvm_arm_init_cpreg_list(cpu, &local_err);
> +    if (ret < 0) {
> +        error_report_err(local_err);
> +    }
> +    return ret;
>  }
>  
>  int kvm_arch_destroy_vcpu(CPUState *cs)
> -- 
> 2.53.0
> 
> 

Reviewed-by: Gustavo Romero <gromero@redhat.com>


Cheers,
Gustavo


