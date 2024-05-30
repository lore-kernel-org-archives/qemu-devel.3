Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45957C25B78
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 08:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCbJ8-0004Z6-GY; Thu, 30 May 2024 04:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sCbJ6-0004Yo-7L; Thu, 30 May 2024 04:38:44 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sCbIz-00050n-D6; Thu, 30 May 2024 04:38:43 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1f44b45d6abso4347985ad.0; 
 Thu, 30 May 2024 01:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717058315; x=1717663115; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wXIYh8x3mlcEGbjanNWC1tisdQtXJ4B5PX6wKmCZIbI=;
 b=DtroYvQ3aEB1zLRhAJDZbc1g8QILxqaGDq/Z0ICzfpa/gGCwh/rNjz/qKK/U3sAnQj
 I9Ek8pl0XVOqJ/9DDekq9KFe5Bid1WEElD8WhcBo5V5Gbrm3Mhet9TaM9w9VGI501P0Z
 GLefCyA4kj4pQD/5N1O/COPToAeKTAEbzsaQGLCuIhxN+P1uyPmo2RWhPrRXn7FQz4wz
 EDmoz9jtnNZs5AZwg+qhQT5L8S/Rp4Fu58+2bj2ScXthtQHxdg+w9rasW181eeP91JoP
 K5YRX1A14HsAne/cG2GXBDH7IpzK9EOG3VFFN2hvOgHohFvr4Gu+zqNxMWyb2W1PahEi
 qzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717058315; x=1717663115;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wXIYh8x3mlcEGbjanNWC1tisdQtXJ4B5PX6wKmCZIbI=;
 b=ZPHD3qJwoL/NMR7A+a6iI3hhS/kYAh0Ny4BcVJA/dLpa5TX6qn2f/2T8Xum+pBq2QP
 nrM0XdphqHPxzaDnGcEDv+559P6xZjEOc71jwrb1ncakrBsej/gxphA4eVa4URfyPcWj
 ZpvGaRUkG2Wf7IDqfkS46HDuH5r60Z61avZCt0Qt/9Bw/3n7URnSUbRS2EtY9R23+mKJ
 u2vhgHetOXcsi8tqevJR8VViwSss/IvnW0nTPJFl7hEAWU2KOUIBS4WiQuYlxkSKKqVG
 /xk53Eo1JBmN6juqcPqDqja5PoQjeyOte/KtB0l1UMy6AiBy42l9XBlBkJk2ZPwNMopH
 pg5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjhlC89M95jGTusy9r+Aw99Ax3n0Mx+6eX27amxTjAG6ShzldPukvIiP5/kFluNhvPqqL7OT/O1E51pBEqHE8zXcr94/7GxenWABSaxSLevoXeeJ3Gi9IIcac=
X-Gm-Message-State: AOJu0YzEt+GSeCzVQtfaBQPbkQcGshmQO2DLIXuq1/2pFwDg6YEL3POp
 HHvAsXIo2Ns03SO2WXuxNZFH9QJ+3c7v8hmoZpINoo7QJbPQJKD7Ovhegw==
X-Google-Smtp-Source: AGHT+IGcma0eWxO/mLD2wtR7+L+R6jbQVAOn++4dy6YQmwCfXqsXTuwuoUCgUIBTt99xH94f3FFT7g==
X-Received: by 2002:a17:902:e74a:b0:1f4:5f8f:7c28 with SMTP id
 d9443c01a7336-1f619b27eddmr14600015ad.56.1717058315469; 
 Thu, 30 May 2024 01:38:35 -0700 (PDT)
Received: from localhost ([1.146.118.54]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c9dae6asm112469975ad.296.2024.05.30.01.38.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 May 2024 01:38:35 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 May 2024 18:38:29 +1000
Message-Id: <D1MUDDOQG427.85I9M653MS7A@gmail.com>
Cc: <danielhb413@gmail.com>, <vaibhav@linux.ibm.com>, <sbhat@linux.ibm.com>
Subject: Re: [PATCH v3 3/3] target/ppc: handle vcpu hotplug failure gracefully
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>,
 <qemu-devel@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240523072614.256172-1-harshpb@linux.ibm.com>
 <20240523072614.256172-4-harshpb@linux.ibm.com>
In-Reply-To: <20240523072614.256172-4-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu May 23, 2024 at 5:26 PM AEST, Harsh Prateek Bora wrote:
> On ppc64, the PowerVM hypervisor runs with limited memory and a VCPU
> creation during hotplug may fail during kvm_ioctl for KVM_CREATE_VCPU,
> leading to termination of guest since errp is set to &error_fatal while
> calling kvm_init_vcpu. This unexpected behaviour can be avoided by
> pre-creating and parking vcpu on success or return error otherwise.
> This enables graceful error delivery for any vcpu hotplug failures while
> the guest can keep running.
>
> Also introducing KVM AccelCPUClass to init cpu_target_realize for kvm.
>
> Tested OK by repeatedly doing a hotplug/unplug of vcpus as below:
>
>  #virsh setvcpus hotplug 40
>  #virsh setvcpus hotplug 70
> error: internal error: unable to execute QEMU command 'device_add':
> kvmppc_cpu_realize: vcpu hotplug failed with -12
>
> Reported-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
> Suggested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Signed-off by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Tested-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
> ---
>  target/ppc/kvm.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 63930d4a77..8e5a7c3d2d 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -48,6 +48,8 @@
>  #include "qemu/mmap-alloc.h"
>  #include "elf.h"
>  #include "sysemu/kvm_int.h"
> +#include "accel/kvm/kvm-cpus.h"
> +#include "hw/core/accel-cpu.h"
> =20
>  #define PROC_DEVTREE_CPU      "/proc/device-tree/cpus/"
> =20
> @@ -2339,6 +2341,25 @@ static void alter_insns(uint64_t *word, uint64_t f=
lags, bool on)
>      }
>  }
> =20
> +static bool kvmppc_cpu_realize(CPUState *cs, Error **errp)
> +{
> +    int ret;
> +    const char *vcpu_str =3D (cs->parent_obj.hotplugged =3D=3D true) ?
> +                           "hotplug" : "create";
> +    cs->cpu_index =3D cpu_get_free_index();
> +
> +    POWERPC_CPU(cs)->vcpu_id =3D cs->cpu_index;
> +
> +    /* create and park to fail gracefully in case vcpu hotplug fails */

The only thing that wasn't immediately clear to me is that in the
machine init path, this results in qemu termination, and in the
hotplug path it results in graceful hotplug failure. That is the
behaviour we want, maybe just expand the comment slightly to be
more explicit about it. E.g.,

> +    ret =3D kvm_create_and_park_vcpu(cs);
> +    if (ret) {
           /*
	    * This causes QEMU to terminate if initial CPU creation
	    * fails, and CPU hotplug failure if the error happens
	    * there.
	    */
> +        error_setg(errp, "%s: vcpu %s failed with %d",
> +                         __func__, vcpu_str, ret);
> +        return false;
> +    }
> +    return true;
> +}
> +

Otherwise looks good.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>  static void kvmppc_host_cpu_class_init(ObjectClass *oc, void *data)
>  {
>      PowerPCCPUClass *pcc =3D POWERPC_CPU_CLASS(oc);
> @@ -2959,3 +2980,23 @@ void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int=
64_t tb_offset)
>  void kvm_arch_accel_class_init(ObjectClass *oc)
>  {
>  }
> +
> +static void kvm_cpu_accel_class_init(ObjectClass *oc, void *data)
> +{
> +    AccelCPUClass *acc =3D ACCEL_CPU_CLASS(oc);
> +
> +    acc->cpu_target_realize =3D kvmppc_cpu_realize;
> +}
> +
> +static const TypeInfo kvm_cpu_accel_type_info =3D {
> +    .name =3D ACCEL_CPU_NAME("kvm"),
> +
> +    .parent =3D TYPE_ACCEL_CPU,
> +    .class_init =3D kvm_cpu_accel_class_init,
> +    .abstract =3D true,
> +};
> +static void kvm_cpu_accel_register_types(void)
> +{
> +    type_register_static(&kvm_cpu_accel_type_info);
> +}
> +type_init(kvm_cpu_accel_register_types);


