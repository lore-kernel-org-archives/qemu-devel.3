Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1454E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 16:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLlcP-0002Av-6b; Thu, 12 Dec 2024 11:00:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tLlcO-0002Ai-7i
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 11:00:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tLlcM-0000tv-B9
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 11:00:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734019244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L1xUt3njQqKB3GxrQmc7u8qp2nc5B6UvBhDcKxZw3dI=;
 b=NnYGtAKVFQS+YT0HenpYG+B63JxDX3WmZc2E+XbZr9Lvf5nLgeqObrYguS1JhReLK+W5ZZ
 bj7Lu3jA361tIZ668SZ9fNeyBtCRhZLo9cRbwofZtnvQHn1Oi2JFPq4wSqXWXVF57/6Lwe
 k/IoWwGEBPFT8UdqvSj5zmhgZEs1Y38=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-Px-ABInfNiCo47gJ5DbALA-1; Thu, 12 Dec 2024 11:00:42 -0500
X-MC-Unique: Px-ABInfNiCo47gJ5DbALA-1
X-Mimecast-MFC-AGG-ID: Px-ABInfNiCo47gJ5DbALA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-436289a570eso2300115e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 08:00:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734019241; x=1734624041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L1xUt3njQqKB3GxrQmc7u8qp2nc5B6UvBhDcKxZw3dI=;
 b=fnXjv9HfDKZ4Lz6xJVeMzMHbChgqjRG+L0bbVxDEwymaC1o/hmWm/E1eTVY3C5rL+6
 itdsBCjhzIgg1lMnEcOkBxNbC6qPk/pjsnhCt3Pvp29ETRtwel3QWM12LJwklYZjoD+X
 7BVyUM51M/A+i+/Aw1J4Yx5F2gWPXhZt+IorV6RrTisgworMiwduZgJEipPgZ1l9ernF
 EWxzogpnQAzC6j97eLr3Zvw5TcFfQgu6iukoOrBaD+ZQv35Hh42jLfUdgDU8aXYOF+0F
 6X6WJRk/lIH2k3r//rjpqOPjJWocHSGm9mk9EKx3C1Hc/8W3RLTYXG5z+4Hq79CraqtL
 VsHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRW4DvMJ6gEptbmmtvQ2XoeUV0BoiTy+oNft/7j+1jc0vXOMUkQ7lkzCntxCY1oiRh4Txc22ht3mwu@nongnu.org
X-Gm-Message-State: AOJu0YzzuuJkdtFYtDTQvZV6+QpHbuZTCobIaeWSYh48Aunzdb7IoVPx
 Lf1fNmYmkbJ4I2x6aMMAcOoOa/67sjKviO5hpnaYALUCog1wyTtl/s5OCXUPhHJfLkMGFED/O2v
 0S60MzBVZp69b/cdL6J5O9G+RsK4DKAavY5+tNkDQAwT4HrNyf78Q
X-Gm-Gg: ASbGncsKRcSxSJizCSB4hjGMlo2QiA0kpgBpjhaKO2j4S+cwuGvUGAW/KenkQAFzlLD
 OYD2dQQJy7ohcHFh2zzkK2+17uaB3BfO7aXlD2ErJoffdoL6jOXIogx57ePHfd8H5K9KzDjqK1o
 apUeTk2LbUBQfuf55ClypYBH6nSY56FmWPtFrThOSKx6cQFX8zv/8uAJr2Km8/RYBFkpGiwXbHe
 6Ho9N4cjRxqLqt3VhIpVbS4R0mnXcU2Fl8lNbM1I7LAgPCdPVWzlH89JzqtcW/P73INY0KsQPy3
 7mg0tZvq/Rzk46rg6Vzx3m/TLysz
X-Received: by 2002:a05:600c:35c9:b0:434:a734:d279 with SMTP id
 5b1f17b1804b1-4361c3c6fbfmr77209495e9.16.1734019240470; 
 Thu, 12 Dec 2024 08:00:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7u0oYx1r7VH0iNnzyx8lXhphV11Pdrlgtw2BV0y+oru5OMlvI5mJMkYXy9VHum2h0WgePHA==
X-Received: by 2002:a05:600c:35c9:b0:434:a734:d279 with SMTP id
 5b1f17b1804b1-4361c3c6fbfmr77207515e9.16.1734019239178; 
 Thu, 12 Dec 2024 08:00:39 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4362559ec46sm20705235e9.20.2024.12.12.08.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 08:00:37 -0800 (PST)
Date: Thu, 12 Dec 2024 17:00:34 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] target/i386: Reset TSCs of parked vCPUs too on VM reset
Message-ID: <20241212170034.081aa98f@imammedo.users.ipa.redhat.com>
In-Reply-To: <5a605a88e9a231386dc803c60f5fed9b48108139.1734014926.git.maciej.szmigiero@oracle.com>
References: <5a605a88e9a231386dc803c60f5fed9b48108139.1734014926.git.maciej.szmigiero@oracle.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, 12 Dec 2024 15:51:15 +0100
"Maciej S. Szmigiero" <mail@maciej.szmigiero.name> wrote:

> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Since commit 5286c3662294 ("target/i386: properly reset TSC on reset")
> QEMU writes the special value of "1" to each online vCPU TSC on VM reset
> to reset it.
> 
> However parked vCPUs don't get that handling and due to that their TSCs
> get desynchronized when the VM gets reset.
> This in turn causes KVM to turn off PVCLOCK_TSC_STABLE_BIT in its exported
> PV clock.
> Note that KVM has no understanding of vCPU being currently parked.
> 
> Without PVCLOCK_TSC_STABLE_BIT the sched clock is marked unstable in
> the guest's kvm_sched_clock_init().
> This causes a performance regressions to show in some tests.
> 
> Fix this issue by writing the special value of "1" also to TSCs of parked
> vCPUs on VM reset.

does TSC still ticks when vCPU is parked or it is paused at some value?

> 
> 
> Reproducing the issue:
> 1) Boot a VM with "-smp 2,maxcpus=3" or similar
> 
> 2) device_add host-x86_64-cpu,id=vcpu,node-id=0,socket-id=0,core-id=2,thread-id=0
> 
> 3) Wait a few seconds
> 
> 4) device_del vcpu
> 
> 5) Inside the VM run:
> # echo "t" >/proc/sysrq-trigger; dmesg | grep sched_clock_stable
> Observe the sched_clock_stable() value is 1.
> 
> 6) Reboot the VM
> 
> 7) Once the VM boots once again run inside it:
> # echo "t" >/proc/sysrq-trigger; dmesg | grep sched_clock_stable
> Observe the sched_clock_stable() value is now 0.
> 
> 
> Fixes: 5286c3662294 ("target/i386: properly reset TSC on reset")
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>  accel/kvm/kvm-all.c                | 11 +++++++++++
>  configs/targets/i386-softmmu.mak   |  1 +
>  configs/targets/x86_64-softmmu.mak |  1 +
>  include/sysemu/kvm.h               |  8 ++++++++
>  target/i386/kvm/kvm.c              | 15 +++++++++++++++
>  5 files changed, 36 insertions(+)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 801cff16a5a2..dec1d1c16a0d 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -437,6 +437,16 @@ int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id)
>      return kvm_fd;
>  }
>  
> +static void kvm_reset_parked_vcpus(void *param)
> +{
> +    KVMState *s = param;
> +    struct KVMParkedVcpu *cpu;
> +
> +    QLIST_FOREACH(cpu, &s->kvm_parked_vcpus, node) {
> +        kvm_arch_reset_parked_vcpu(cpu->vcpu_id, cpu->kvm_fd);
> +    }
> +}
> +
>  int kvm_create_vcpu(CPUState *cpu)
>  {
>      unsigned long vcpu_id = kvm_arch_vcpu_id(cpu);
> @@ -2728,6 +2738,7 @@ static int kvm_init(MachineState *ms)
>      }
>  
>      qemu_register_reset(kvm_unpoison_all, NULL);
> +    qemu_register_reset(kvm_reset_parked_vcpus, s);
>  
>      if (s->kernel_irqchip_allowed) {
>          kvm_irqchip_create(s);
> diff --git a/configs/targets/i386-softmmu.mak b/configs/targets/i386-softmmu.mak
> index 2ac69d5ba370..2eb0e8625005 100644
> --- a/configs/targets/i386-softmmu.mak
> +++ b/configs/targets/i386-softmmu.mak
> @@ -1,4 +1,5 @@
>  TARGET_ARCH=i386
>  TARGET_SUPPORTS_MTTCG=y
>  TARGET_KVM_HAVE_GUEST_DEBUG=y
> +TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
>  TARGET_XML_FILES= gdb-xml/i386-32bit.xml
> diff --git a/configs/targets/x86_64-softmmu.mak b/configs/targets/x86_64-softmmu.mak
> index e12ac3dc59bf..920e9a42006f 100644
> --- a/configs/targets/x86_64-softmmu.mak
> +++ b/configs/targets/x86_64-softmmu.mak
> @@ -2,4 +2,5 @@ TARGET_ARCH=x86_64
>  TARGET_BASE_ARCH=i386
>  TARGET_SUPPORTS_MTTCG=y
>  TARGET_KVM_HAVE_GUEST_DEBUG=y
> +TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
>  TARGET_XML_FILES= gdb-xml/i386-64bit.xml
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index c3a60b28909a..ab17c09a551f 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -377,6 +377,14 @@ int kvm_arch_init(MachineState *ms, KVMState *s);
>  int kvm_arch_init_vcpu(CPUState *cpu);
>  int kvm_arch_destroy_vcpu(CPUState *cpu);
>  
> +#ifdef TARGET_KVM_HAVE_RESET_PARKED_VCPU
> +void kvm_arch_reset_parked_vcpu(unsigned long vcpu_id, int kvm_fd);
> +#else
> +static inline void kvm_arch_reset_parked_vcpu(unsigned long vcpu_id, int kvm_fd)
> +{
> +}
> +#endif
> +
>  bool kvm_vcpu_id_is_valid(int vcpu_id);
>  
>  /* Returns VCPU ID to be used on KVM_CREATE_VCPU ioctl() */
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 8e17942c3ba1..2ff618fbf138 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -2415,6 +2415,21 @@ void kvm_arch_after_reset_vcpu(X86CPU *cpu)
>      }
>  }
>  
> +void kvm_arch_reset_parked_vcpu(unsigned long vcpu_id, int kvm_fd)
> +{
> +    g_autofree struct kvm_msrs *msrs = NULL;
> +
> +    msrs = g_malloc0(sizeof(*msrs) + sizeof(msrs->entries[0]));
> +    msrs->entries[0].index = MSR_IA32_TSC;
> +    msrs->entries[0].data = 1; /* match the value in x86_cpu_reset() */
> +    msrs->nmsrs++;
> +
> +    if (ioctl(kvm_fd, KVM_SET_MSRS, msrs) != 1) {
> +        warn_report("parked vCPU %lu TSC reset failed: %d",
> +                    vcpu_id, errno);
> +    }
> +}
> +
>  void kvm_arch_do_init_vcpu(X86CPU *cpu)
>  {
>      CPUX86State *env = &cpu->env;
> 


