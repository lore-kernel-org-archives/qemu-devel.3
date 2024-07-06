Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4AECC2BD09
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 13:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQ5D2-0000wu-KB; Sat, 06 Jul 2024 09:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sQ5Cw-0000vp-QB
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 09:12:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sQ5Cu-0004gg-Id
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 09:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720271521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8LSu3tTiEecAPECmoeXbRlHI/G9nJ80MJdc3JJ88kQY=;
 b=VSnRMEEEGEgjVg97lsEL3uXujxdkxFAg/QYo4h6SqBluSznTl4qi7WomuTu4RLGpEsSM6y
 LZ2Gzq0hiA+fBpVoQUGi/2SPyrHEAY6bqH/RZG6EGwNp8neohCgxDnZNrjKYhUcg+peFQa
 rV1fGMLhmCHGg+lUVjaXeuO6BCaxDDo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-CSNeCAOeM76sHHbKIcJCuw-1; Sat, 06 Jul 2024 09:11:59 -0400
X-MC-Unique: CSNeCAOeM76sHHbKIcJCuw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-36792df120fso1840081f8f.1
 for <qemu-devel@nongnu.org>; Sat, 06 Jul 2024 06:11:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720271518; x=1720876318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8LSu3tTiEecAPECmoeXbRlHI/G9nJ80MJdc3JJ88kQY=;
 b=bUlvBcFXnmYA9oiZ7uu0xEr2dyOPwttWsVC4JTjHZgDS/WFNzF4Mo1dsizL2dCWYFB
 gdAdWyc1vPJK7nwepqU7IGy/Kc5LBYBGt4/ILfY/PyUNVWxy75UCcezXTpVuU5U5XCPG
 c5c7AOI/8wYDhZ4BK61jvHIbATSff8FKkkoZGLOgaQJaIbeazkPNSgq8fMS4dLEeU3oU
 G414LfAkn6llWFwftIIk9dHNWlSwDPKi8nLssdqGFhjHnJjUl4g78Nkym6at/SO6VVaA
 Qyxhf4jS6DLPtit7aRPjuLuuvjf7knKVAPhCMjEnGOxmalVqxJzTsgTLwOC8/g4SmL+z
 HbIw==
X-Gm-Message-State: AOJu0YzMaKMbZ8ccaqRrvt8urGTgR0iuFXGW7TfJUhswiFakiMHsL2vG
 KahtHpD7KPhcyyNC1aJE55C8VPMVTDR1+tim68IcwYKsQCZpHhuYZqcH1kEFEDrumxigHUz5Xmx
 iyMEYKrnMe3i2o7Mo7uZNKqDQt4HbnDqyENtEDX53fsn0Wh2xFrZp
X-Received: by 2002:adf:f5cb:0:b0:367:96a8:d94b with SMTP id
 ffacd0b85a97d-3679dd715ddmr4476590f8f.57.1720271518095; 
 Sat, 06 Jul 2024 06:11:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA0zhecJUgeKK6PqiylLwlpEWpW6Sl73joZpTvhWXEWikfvf85fkrHSJaMIuqkXXAs2ajC6Q==
X-Received: by 2002:adf:f5cb:0:b0:367:96a8:d94b with SMTP id
 ffacd0b85a97d-3679dd715ddmr4476568f8f.57.1720271517619; 
 Sat, 06 Jul 2024 06:11:57 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36789a02631sm11590075f8f.1.2024.07.06.06.11.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jul 2024 06:11:56 -0700 (PDT)
Date: Sat, 6 Jul 2024 15:11:54 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <maz@kernel.org>,
 <jean-philippe@linaro.org>, <jonathan.cameron@huawei.com>,
 <lpieralisi@kernel.org>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <andrew.jones@linux.dev>,
 <david@redhat.com>, <philmd@linaro.org>, <eric.auger@redhat.com>,
 <oliver.upton@linux.dev>, <pbonzini@redhat.com>, <mst@redhat.com>,
 <will@kernel.org>, <gshan@redhat.com>, <rafael@kernel.org>,
 <alex.bennee@linaro.org>, <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>, <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>, <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>, <salil.mehta@opnsrc.net>,
 <zhukeqian1@huawei.com>, <wangxiongfeng2@huawei.com>,
 <wangyanan55@huawei.com>, <jiakernel2@gmail.com>, <maobibo@loongson.cn>,
 <lixianglai@loongson.cn>, <npiggin@gmail.com>, <harshpb@linux.ibm.com>,
 <linuxarm@huawei.com>, Shaoqin Huang <shahuang@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH V13 1/8] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
Message-ID: <20240706151154.7c430b0a@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240607115649.214622-2-salil.mehta@huawei.com>
References: <20240607115649.214622-1-salil.mehta@huawei.com>
 <20240607115649.214622-2-salil.mehta@huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, 7 Jun 2024 12:56:42 +0100
Salil Mehta <salil.mehta@huawei.com> wrote:

> KVM vCPU creation is done once during the vCPU realization when Qemu vCPU thread
> is spawned. This is common to all the architectures as of now.
> 
> Hot-unplug of vCPU results in destruction of the vCPU object in QOM but the
> corresponding KVM vCPU object in the Host KVM is not destroyed as KVM doesn't
> support vCPU removal. Therefore, its representative KVM vCPU object/context in
> Qemu is parked.
> 
> Refactor architecture common logic so that some APIs could be reused by vCPU
> Hotplug code of some architectures likes ARM, Loongson etc. Update new/old APIs
> with trace events. No functional change is intended here.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Tested-by: Xianglai Li <lixianglai@loongson.cn>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> Reviewed-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> Tested-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  accel/kvm/kvm-all.c    | 95 ++++++++++++++++++++++++++++--------------
>  accel/kvm/kvm-cpus.h   |  1 -
>  accel/kvm/trace-events |  5 ++-
>  include/sysemu/kvm.h   | 25 +++++++++++
>  4 files changed, 92 insertions(+), 34 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index c0be9f5eed..8f9128bb92 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -340,14 +340,71 @@ err:
>      return ret;
>  }
>  
> +void kvm_park_vcpu(CPUState *cpu)
> +{
> +    struct KVMParkedVcpu *vcpu;
> +
> +    trace_kvm_park_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
> +
> +    vcpu = g_malloc0(sizeof(*vcpu));
> +    vcpu->vcpu_id = kvm_arch_vcpu_id(cpu);
> +    vcpu->kvm_fd = cpu->kvm_fd;
> +    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
> +}
> +
> +int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id)
> +{
> +    struct KVMParkedVcpu *cpu;
> +    int kvm_fd = -ENOENT;
> +
> +    QLIST_FOREACH(cpu, &s->kvm_parked_vcpus, node) {
> +        if (cpu->vcpu_id == vcpu_id) {
> +            QLIST_REMOVE(cpu, node);
> +            kvm_fd = cpu->kvm_fd;
> +            g_free(cpu);
> +        }
> +    }
> +
> +    trace_kvm_unpark_vcpu(vcpu_id, kvm_fd > 0 ? "unparked" : "not found parked");
> +
> +    return kvm_fd;
> +}
> +
> +int kvm_create_vcpu(CPUState *cpu)
> +{
> +    unsigned long vcpu_id = kvm_arch_vcpu_id(cpu);
> +    KVMState *s = kvm_state;
> +    int kvm_fd;
> +
> +    /* check if the KVM vCPU already exist but is parked */
> +    kvm_fd = kvm_unpark_vcpu(s, vcpu_id);
> +    if (kvm_fd < 0) {
> +        /* vCPU not parked: create a new KVM vCPU */
> +        kvm_fd = kvm_vm_ioctl(s, KVM_CREATE_VCPU, vcpu_id);
> +        if (kvm_fd < 0) {
> +            error_report("KVM_CREATE_VCPU IOCTL failed for vCPU %lu", vcpu_id);
> +            return kvm_fd;
> +        }
> +    }
> +
> +    cpu->kvm_fd = kvm_fd;
> +    cpu->kvm_state = s;
> +    cpu->vcpu_dirty = true;
> +    cpu->dirty_pages = 0;
> +    cpu->throttle_us_per_full = 0;
> +
> +    trace_kvm_create_vcpu(cpu->cpu_index, vcpu_id, kvm_fd);
> +
> +    return 0;
> +}

Is there any reason why you are embedding/hiding kvm_state in new API
instead of passing it as argument (all callers have it defined, so why not reuse that)?

otherwise patch lgtm 

> +
>  static int do_kvm_destroy_vcpu(CPUState *cpu)
>  {
>      KVMState *s = kvm_state;
>      long mmap_size;
> -    struct KVMParkedVcpu *vcpu = NULL;
>      int ret = 0;
>  
> -    trace_kvm_destroy_vcpu();
> +    trace_kvm_destroy_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>  
>      ret = kvm_arch_destroy_vcpu(cpu);
>      if (ret < 0) {
> @@ -373,10 +430,7 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
>          }
>      }
>  
> -    vcpu = g_malloc0(sizeof(*vcpu));
> -    vcpu->vcpu_id = kvm_arch_vcpu_id(cpu);
> -    vcpu->kvm_fd = cpu->kvm_fd;
> -    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
> +    kvm_park_vcpu(cpu);
>  err:
>      return ret;
>  }
> @@ -389,24 +443,6 @@ void kvm_destroy_vcpu(CPUState *cpu)
>      }
>  }
>  
> -static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id)
> -{
> -    struct KVMParkedVcpu *cpu;
> -
> -    QLIST_FOREACH(cpu, &s->kvm_parked_vcpus, node) {
> -        if (cpu->vcpu_id == vcpu_id) {
> -            int kvm_fd;
> -
> -            QLIST_REMOVE(cpu, node);
> -            kvm_fd = cpu->kvm_fd;
> -            g_free(cpu);
> -            return kvm_fd;
> -        }
> -    }
> -
> -    return kvm_vm_ioctl(s, KVM_CREATE_VCPU, (void *)vcpu_id);
> -}
> -
>  int kvm_init_vcpu(CPUState *cpu, Error **errp)
>  {
>      KVMState *s = kvm_state;
> @@ -415,19 +451,14 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
>  
>      trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>  
> -    ret = kvm_get_vcpu(s, kvm_arch_vcpu_id(cpu));
> +    ret = kvm_create_vcpu(cpu);
>      if (ret < 0) {
> -        error_setg_errno(errp, -ret, "kvm_init_vcpu: kvm_get_vcpu failed (%lu)",
> +        error_setg_errno(errp, -ret,
> +                         "kvm_init_vcpu: kvm_create_vcpu failed (%lu)",
>                           kvm_arch_vcpu_id(cpu));
>          goto err;
>      }
>  
> -    cpu->kvm_fd = ret;
> -    cpu->kvm_state = s;
> -    cpu->vcpu_dirty = true;
> -    cpu->dirty_pages = 0;
> -    cpu->throttle_us_per_full = 0;
> -
>      mmap_size = kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);
>      if (mmap_size < 0) {
>          ret = mmap_size;
> diff --git a/accel/kvm/kvm-cpus.h b/accel/kvm/kvm-cpus.h
> index ca40add32c..171b22fd29 100644
> --- a/accel/kvm/kvm-cpus.h
> +++ b/accel/kvm/kvm-cpus.h
> @@ -22,5 +22,4 @@ bool kvm_supports_guest_debug(void);
>  int kvm_insert_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len);
>  int kvm_remove_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len);
>  void kvm_remove_all_breakpoints(CPUState *cpu);
> -
>  #endif /* KVM_CPUS_H */
> diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
> index 681ccb667d..37626c1ac5 100644
> --- a/accel/kvm/trace-events
> +++ b/accel/kvm/trace-events
> @@ -9,6 +9,10 @@ kvm_device_ioctl(int fd, int type, void *arg) "dev fd %d, type 0x%x, arg %p"
>  kvm_failed_reg_get(uint64_t id, const char *msg) "Warning: Unable to retrieve ONEREG %" PRIu64 " from KVM: %s"
>  kvm_failed_reg_set(uint64_t id, const char *msg) "Warning: Unable to set ONEREG %" PRIu64 " to KVM: %s"
>  kvm_init_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id: %lu"
> +kvm_create_vcpu(int cpu_index, unsigned long arch_cpu_id, int kvm_fd) "index: %d, id: %lu, kvm fd: %d"
> +kvm_destroy_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id: %lu"
> +kvm_park_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id: %lu"
> +kvm_unpark_vcpu(unsigned long arch_cpu_id, const char *msg) "id: %lu %s"
>  kvm_irqchip_commit_routes(void) ""
>  kvm_irqchip_add_msi_route(char *name, int vector, int virq) "dev %s vector %d virq %d"
>  kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=%d"
> @@ -25,7 +29,6 @@ kvm_dirty_ring_reaper(const char *s) "%s"
>  kvm_dirty_ring_reap(uint64_t count, int64_t t) "reaped %"PRIu64" pages (took %"PRIi64" us)"
>  kvm_dirty_ring_reaper_kick(const char *reason) "%s"
>  kvm_dirty_ring_flush(int finished) "%d"
> -kvm_destroy_vcpu(void) ""
>  kvm_failed_get_vcpu_mmap_size(void) ""
>  kvm_cpu_exec(void) ""
>  kvm_interrupt_exit_request(void) ""
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index c31d9c7356..c4a914b3d8 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -313,6 +313,31 @@ int kvm_create_device(KVMState *s, uint64_t type, bool test);
>   */
>  bool kvm_device_supported(int vmfd, uint64_t type);
>  
> +/**
> + * kvm_create_vcpu - Gets a parked KVM vCPU or creates a KVM vCPU
> + * @cpu: QOM CPUState object for which KVM vCPU has to be fetched/created.
> + *
> + * @returns: 0 when success, errno (<0) when failed.
> + */
> +int kvm_create_vcpu(CPUState *cpu);
> +
> +/**
> + * kvm_park_vcpu - Park QEMU KVM vCPU context
> + * @cpu: QOM CPUState object for which QEMU KVM vCPU context has to be parked.
> + *
> + * @returns: none
> + */
> +void kvm_park_vcpu(CPUState *cpu);
> +
> +/**
> + * kvm_unpark_vcpu - unpark QEMU KVM vCPU context
> + * @s: KVM State
> + * @vcpu_id: Architecture vCPU ID of the parked vCPU
> + *
> + * @returns: KVM fd
> + */
> +int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id);
> +
>  /* Arch specific hooks */
>  
>  extern const KVMCapabilityInfo kvm_arch_required_capabilities[];


