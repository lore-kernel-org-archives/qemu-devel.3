Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56757C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 11:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJA6D-0000as-70; Mon, 17 Jun 2024 07:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sJA6B-0000ad-KM
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 07:00:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sJA69-0006Ii-Ra
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 07:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718622028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2pE+Stt1xQgd88NbIXw/aQeWNV1WtLq9Yl4DKq3wlRw=;
 b=QF9M5RN3rORCRs1gyKWGwqooTkVwoE6HM3OfJaXthmhH9vsNbDpPNZ5hrv+OkEdcxo3C8D
 69uXIt6bBWkzAZeNfmy9zQfLVOJDKdPzof0ZdAx/ZtsRzHO01k34ngwtR6PYhTsS2j0ODP
 TNX2ChwX7cq60ip2EYEZZJgQBv8zYgY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-Byj926r5NIGhgT5LD8XQaA-1; Mon, 17 Jun 2024 07:00:27 -0400
X-MC-Unique: Byj926r5NIGhgT5LD8XQaA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-52c978dbd31so3001698e87.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 04:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718622025; x=1719226825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2pE+Stt1xQgd88NbIXw/aQeWNV1WtLq9Yl4DKq3wlRw=;
 b=eoi2Stv0NpmyKCG7E6Paj7ypAdCvz6JF81pTJdVzZOnDJEDSpm3wSC6RUsZB8VR0CZ
 xdRWKyv1L2YTWy/UIASBWKUi1KAvUjRZ2WN33XHVILG6bNYFTJvV8qIW039KhoBRToCx
 0xyVC5aEGpkANuPYDyIvnfFj9M3SlGfc+4NfXIvWzjxjeSm1TsspNq7xYe8VkBiZjXJs
 j5H9fwhb+f1gvjK6SE52U3sLdrztAnGoCXFYGMgqy5XGVFgjt7epvRYU6bjsduV9paVH
 zpl2BdjPpCgp/2Ib+2Cd0GO3+eWSuXJ8NMwZ5rCey/umlQzgmCo9n2sEy6U3dU2IahAW
 JqUA==
X-Gm-Message-State: AOJu0YwGv+OgKVfUazCf7vUuEv6STroaG2dvRvpiLiW7Qtq++N6epTC/
 tOrcf7rca6dJz5zHt6APGsrq1hMBd+u2hYvSXzUwhv+ScmrqlHP817YE3d4RI2cWU7nw7EcnWxY
 Vnit+3/ZULC7G9zF/BtSenQLxPQWKWIN+ur/B5bCFZVKzgf9NRzsC
X-Received: by 2002:a19:ae1a:0:b0:52c:8f54:b3a with SMTP id
 2adb3069b0e04-52ca6e6702emr6446337e87.28.1718622025696; 
 Mon, 17 Jun 2024 04:00:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELT8cFyJ3MKFfdnyraH2OFDI9fI8wfUGEhjWJromCFk1ttwD1tYede0UP5pkBOkSH+8iyC9w==
X-Received: by 2002:a19:ae1a:0:b0:52c:8f54:b3a with SMTP id
 2adb3069b0e04-52ca6e6702emr6446315e87.28.1718622025277; 
 Mon, 17 Jun 2024 04:00:25 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422d0be1424sm161740195e9.12.2024.06.17.04.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 04:00:24 -0700 (PDT)
Date: Mon, 17 Jun 2024 13:00:23 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, Thomas Huth
 <thuth@redhat.com>
Subject: Re: [PATCH v6 22/23] target/i386: Remove
 X86CPU::kvm_no_smi_migration field
Message-ID: <20240617130023.20605d43@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240617071118.60464-23-philmd@linaro.org>
References: <20240617071118.60464-1-philmd@linaro.org>
 <20240617071118.60464-23-philmd@linaro.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, 17 Jun 2024 09:11:17 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> X86CPU::kvm_no_smi_migration was only used by the
> pc-i440fx-2.3 machine, which got removed. Remove it
> and simplify kvm_put_vcpu_events().
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  target/i386/cpu.h     | 3 ---
>  target/i386/cpu.c     | 2 --
>  target/i386/kvm/kvm.c | 7 +------
>  3 files changed, 1 insertion(+), 11 deletions(-)
>=20
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 8fe28b67e0..bba1d73aed 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2107,9 +2107,6 @@ struct ArchCPU {
>      /* if set, limit maximum value for phys_bits when host_phys_bits is =
true */
>      uint8_t host_phys_bits_limit;
> =20
> -    /* Stop SMI delivery for migration compatibility with old machines */
> -    bool kvm_no_smi_migration;
> -
>      /* Forcefully disable KVM PV features not exposed in guest CPUIDs */
>      bool kvm_pv_enforce_cpuid;
> =20
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 7466217d5e..a5af56405b 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -8283,8 +8283,6 @@ static Property x86_cpu_properties[] =3D {
>      DEFINE_PROP_BOOL("x-vendor-cpuid-only", X86CPU, vendor_cpuid_only, t=
rue),
>      DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
>      DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
> -    DEFINE_PROP_BOOL("kvm-no-smi-migration", X86CPU, kvm_no_smi_migratio=
n,
> -                     false),
>      DEFINE_PROP_BOOL("kvm-pv-enforce-cpuid", X86CPU, kvm_pv_enforce_cpui=
d,
>                       false),
>      DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, tru=
e),
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 912f5d5a6b..7ad8072748 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -4474,6 +4474,7 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int lev=
el)
>      events.sipi_vector =3D env->sipi_vector;
> =20
>      if (has_msr_smbase) {
> +        events.flags |=3D KVM_VCPUEVENT_VALID_SMM;
>          events.smi.smm =3D !!(env->hflags & HF_SMM_MASK);
>          events.smi.smm_inside_nmi =3D !!(env->hflags2 & HF2_SMM_INSIDE_N=
MI_MASK);
>          if (kvm_irqchip_in_kernel()) {
> @@ -4488,12 +4489,6 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int le=
vel)
>              events.smi.pending =3D 0;
>              events.smi.latched_init =3D 0;
>          }
> -        /* Stop SMI delivery on old machine types to avoid a reboot
> -         * on an inward migration of an old VM.
> -         */
> -        if (!cpu->kvm_no_smi_migration) {
> -            events.flags |=3D KVM_VCPUEVENT_VALID_SMM;
> -        }
>      }
> =20
>      if (level >=3D KVM_PUT_RESET_STATE) {


