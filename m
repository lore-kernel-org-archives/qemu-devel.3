Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4ADC25B74
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 01:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ajl-0004to-Cd; Tue, 21 May 2024 21:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9ajj-0004tR-PF; Tue, 21 May 2024 21:25:47 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9ajh-0004ib-L2; Tue, 21 May 2024 21:25:47 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1ec4dc64c6cso5826645ad.0; 
 Tue, 21 May 2024 18:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716341143; x=1716945943; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ltm/dB7mT9iy0/H8EB+KojAvCEl96dUFqCQ9MUa5z8Y=;
 b=Tf0Bs/vb18E11EzIncTezum4Ft/+J6jOvUFKQZz7E3kOSgVIxCmiPFPtBSKNIPfXX3
 RhSlMwJDXvGuHvXvr8FHd8WgTYMo2QktxRUaRZ+enz4XapaZU9mUvBuXrX4hv+6eDwtB
 T4lo11G8zX/z8WpJ3ntA5pzNFnTc/vJqYD9bfzr7E616l++46aCao0b0J6yeSdLZvnY/
 PFFvwtVK+1/IqOhSR1CMIotIA2eTfI3Yna1koJb1CevhIIQggXBkjvKbtjLhD57DunBe
 w4XGATxwf5hISlG4w9/OxrIVdd4IoQHQTQt7T+P3DyW0GsaqiJtDDNcWUYxZ1oG5f8ct
 iHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716341143; x=1716945943;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ltm/dB7mT9iy0/H8EB+KojAvCEl96dUFqCQ9MUa5z8Y=;
 b=VGggdFsLt2qyrvUf081WrGf7mRA/7k0HuUTt7Bhh7y+LmbUkd6YKosVKuSSa07KYi4
 MmediDMhu+vWgGpZ5riN+G6KaL5/vVHoz/oncXkkAVwnsfnfm264JF9ubpAFYHYMdSQl
 XcLTg71KiD/PZD7zTKq+zD6FZFZE839urw+kEiI4aL1C72xvAMwdxCAAqLBdmbBYBc6N
 pT7gVAz0y+rtdEOnSvTYnw7EFspUiNV2EV52xuMZ9tq6c/Eqfo1TPADL9eF8Y/IePpLO
 fLV+yjcF7NojIgBnLe5QGiyDbU7xaaF0hmT7bzffk1nkNTiqmY6iqmUdC7d77y7kFy2i
 oj7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYqXGc8vdDVryqkDQGDf2ORrEw1iFaLtZnqW0wxa0EKHx3TSnERVl/ljjsrXlxj0zqpxSCbs3hCql3ujB9W83CVhkAoiVVeRpJJIce56BBtxrZKg/3U2mNOa8=
X-Gm-Message-State: AOJu0Yzm5QWgLdCzDwqAKl9W1dS7rJW/5OQ6Bgc6Yw/5SPTs1kVohIG6
 zBUigqemlvwvY6YxSB4o1S1UyR98iGfmnxc1fzMZIzR68+aGRh99
X-Google-Smtp-Source: AGHT+IE0MIuhnG7RRL+a8VNF3LnFnh5OA7dJtlXYZVoYB34aI521QjMGz/5l8sbWplrMv0HuDI8oNw==
X-Received: by 2002:a17:902:ecc4:b0:1f2:f7c6:754e with SMTP id
 d9443c01a7336-1f31c9f0579mr7418975ad.51.1716341142993; 
 Tue, 21 May 2024 18:25:42 -0700 (PDT)
Received: from localhost (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f2fd47df1bsm47391375ad.207.2024.05.21.18.25.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 18:25:42 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 May 2024 11:25:26 +1000
Message-Id: <D1FS5GOOFWWK.2PNRIVL0V6DBL@gmail.com>
Cc: <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <eric.auger@redhat.com>, <oliver.upton@linux.dev>,
 <pbonzini@redhat.com>, <mst@redhat.com>, <will@kernel.org>,
 <gshan@redhat.com>, <rafael@kernel.org>, <alex.bennee@linaro.org>,
 <linux@armlinux.org.uk>, <darren@os.amperecomputing.com>,
 <ilkka@os.amperecomputing.com>, <vishnu@os.amperecomputing.com>,
 <karl.heubaum@oracle.com>, <miguel.luis@oracle.com>,
 <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>,
 <harshpb@linux.ibm.com>, <linuxarm@huawei.com>, "Jonathan Cameron"
 <Jonathan.Cameron@huawei.com>, "Shaoqin Huang" <shahuang@redhat.com>
Subject: Re: [PATCH V10 1/8] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Salil Mehta" <salil.mehta@huawei.com>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240520233241.229675-1-salil.mehta@huawei.com>
 <20240520233241.229675-2-salil.mehta@huawei.com>
In-Reply-To: <20240520233241.229675-2-salil.mehta@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
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

On Tue May 21, 2024 at 9:32 AM AEST, Salil Mehta wrote:
> KVM vCPU creation is done once during the vCPU realization when Qemu vCPU=
 thread
> is spawned. This is common to all the architectures as of now.
>
> Hot-unplug of vCPU results in destruction of the vCPU object in QOM but t=
he
> corresponding KVM vCPU object in the Host KVM is not destroyed as KVM doe=
sn't
> support vCPU removal. Therefore, its representative KVM vCPU object/conte=
xt in
> Qemu is parked.
>
> Refactor architecture common logic so that some APIs could be reused by v=
CPU
> Hotplug code of some architectures likes ARM, Loongson etc. Update new/ol=
d APIs
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
> ---
>  accel/kvm/kvm-all.c    | 97 ++++++++++++++++++++++++++++--------------
>  accel/kvm/kvm-cpus.h   | 23 ++++++++++
>  accel/kvm/trace-events |  5 ++-
>  3 files changed, 92 insertions(+), 33 deletions(-)
>
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index c0be9f5eed..a8f93078dc 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -340,14 +340,73 @@ err:
>      return ret;
>  }
> =20
> +void kvm_park_vcpu(CPUState *cpu)
> +{
> +    struct KVMParkedVcpu *vcpu;
> +
> +    trace_kvm_park_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
> +
> +    vcpu =3D g_malloc0(sizeof(*vcpu));
> +    vcpu->vcpu_id =3D kvm_arch_vcpu_id(cpu);
> +    vcpu->kvm_fd =3D cpu->kvm_fd;
> +    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
> +}
> +
> +int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id)
> +{
> +    struct KVMParkedVcpu *cpu;
> +
> +    QLIST_FOREACH(cpu, &s->kvm_parked_vcpus, node) {
> +        if (cpu->vcpu_id =3D=3D vcpu_id) {
> +            int kvm_fd;
> +
> +            trace_kvm_unpark_vcpu(vcpu_id);

Just an aside, but unfortunately tracing is not entirely consistent.
Often a function-level trace point is done at the beginning of the
function regardless of the result. But I actually like this style
of tracing at the end and providing result too. OTOH you don't see
the -ENOENT case.

In any case it's nice to have something here.

Other unforunate thing is some confusion between attaching a KVM
context for QEMU vCPU, and actually making the KVM_CREATE_VCPU
ioctl call, and kvm_create_vcpu is not the counterpart of
kvm_destroy_vcpu, etc.. It is not your fault the existing naming
makes this a bit confusing. Fortunately it's pretty well contained
to small amount of code.

I hate to nitpick it but since the functions are being exported,
would it be a better name somthing like kvm_attach_vcpu()?

Just a thought, but no big deal. Either way,

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> +
> +            QLIST_REMOVE(cpu, node);
> +            kvm_fd =3D cpu->kvm_fd;
> +            g_free(cpu);
> +            return kvm_fd;
> +        }
> +    }
> +
> +    return -ENOENT;
> +}
> +
> +int kvm_create_vcpu(CPUState *cpu)
> +{
> +    unsigned long vcpu_id =3D kvm_arch_vcpu_id(cpu);
> +    KVMState *s =3D kvm_state;
> +    int kvm_fd;
> +
> +    /* check if the KVM vCPU already exist but is parked */
> +    kvm_fd =3D kvm_unpark_vcpu(s, vcpu_id);
> +    if (kvm_fd < 0) {
> +        /* vCPU not parked: create a new KVM vCPU */
> +        kvm_fd =3D kvm_vm_ioctl(s, KVM_CREATE_VCPU, vcpu_id);
> +        if (kvm_fd < 0) {
> +            error_report("KVM_CREATE_VCPU IOCTL failed for vCPU %lu", vc=
pu_id);
> +            return kvm_fd;
> +        }
> +    }
> +
> +    trace_kvm_create_vcpu(cpu->cpu_index, vcpu_id, kvm_fd);
> +
> +    cpu->kvm_fd =3D kvm_fd;
> +    cpu->kvm_state =3D s;
> +    cpu->vcpu_dirty =3D true;
> +    cpu->dirty_pages =3D 0;
> +    cpu->throttle_us_per_full =3D 0;
> +
> +    return 0;
> +}
> +
>  static int do_kvm_destroy_vcpu(CPUState *cpu)
>  {
>      KVMState *s =3D kvm_state;
>      long mmap_size;
> -    struct KVMParkedVcpu *vcpu =3D NULL;
>      int ret =3D 0;
> =20
> -    trace_kvm_destroy_vcpu();
> +    trace_kvm_destroy_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
> =20
>      ret =3D kvm_arch_destroy_vcpu(cpu);
>      if (ret < 0) {
> @@ -373,10 +432,7 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
>          }
>      }
> =20
> -    vcpu =3D g_malloc0(sizeof(*vcpu));
> -    vcpu->vcpu_id =3D kvm_arch_vcpu_id(cpu);
> -    vcpu->kvm_fd =3D cpu->kvm_fd;
> -    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
> +    kvm_park_vcpu(cpu);
>  err:
>      return ret;
>  }
> @@ -389,24 +445,6 @@ void kvm_destroy_vcpu(CPUState *cpu)
>      }
>  }
> =20
> -static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id)
> -{
> -    struct KVMParkedVcpu *cpu;
> -
> -    QLIST_FOREACH(cpu, &s->kvm_parked_vcpus, node) {
> -        if (cpu->vcpu_id =3D=3D vcpu_id) {
> -            int kvm_fd;
> -
> -            QLIST_REMOVE(cpu, node);
> -            kvm_fd =3D cpu->kvm_fd;
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
>      KVMState *s =3D kvm_state;
> @@ -415,19 +453,14 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
> =20
>      trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
> =20
> -    ret =3D kvm_get_vcpu(s, kvm_arch_vcpu_id(cpu));
> +    ret =3D kvm_create_vcpu(cpu);
>      if (ret < 0) {
> -        error_setg_errno(errp, -ret, "kvm_init_vcpu: kvm_get_vcpu failed=
 (%lu)",
> +        error_setg_errno(errp, -ret,
> +                         "kvm_init_vcpu: kvm_create_vcpu failed (%lu)",
>                           kvm_arch_vcpu_id(cpu));
>          goto err;
>      }
> =20
> -    cpu->kvm_fd =3D ret;
> -    cpu->kvm_state =3D s;
> -    cpu->vcpu_dirty =3D true;
> -    cpu->dirty_pages =3D 0;
> -    cpu->throttle_us_per_full =3D 0;
> -
>      mmap_size =3D kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);
>      if (mmap_size < 0) {
>          ret =3D mmap_size;
> diff --git a/accel/kvm/kvm-cpus.h b/accel/kvm/kvm-cpus.h
> index ca40add32c..2e6bb38b5d 100644
> --- a/accel/kvm/kvm-cpus.h
> +++ b/accel/kvm/kvm-cpus.h
> @@ -22,5 +22,28 @@ bool kvm_supports_guest_debug(void);
>  int kvm_insert_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len=
);
>  int kvm_remove_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len=
);
>  void kvm_remove_all_breakpoints(CPUState *cpu);
> +/**
> + * kvm_create_vcpu - Gets a parked KVM vCPU or creates a KVM vCPU
> + * @cpu: QOM CPUState object for which KVM vCPU has to be fetched/create=
d.
> + *
> + * @returns: 0 when success, errno (<0) when failed.
> + */
> +int kvm_create_vcpu(CPUState *cpu);
> =20
> +/**
> + * kvm_park_vcpu - Park QEMU KVM vCPU context
> + * @cpu: QOM CPUState object for which QEMU KVM vCPU context has to be p=
arked.
> + *
> + * @returns: none
> + */
> +void kvm_park_vcpu(CPUState *cpu);
> +
> +/**
> + * kvm_unpark_vcpu - unpark QEMU KVM vCPU context
> + * @s: KVM State
> + * @cpu: Architecture vCPU ID of the parked vCPU
> + *
> + * @returns: KVM fd
> + */
> +int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id);
>  #endif /* KVM_CPUS_H */
> diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
> index 681ccb667d..bd43a0ef26 100644
> --- a/accel/kvm/trace-events
> +++ b/accel/kvm/trace-events
> @@ -9,6 +9,10 @@ kvm_device_ioctl(int fd, int type, void *arg) "dev fd %d=
, type 0x%x, arg %p"
>  kvm_failed_reg_get(uint64_t id, const char *msg) "Warning: Unable to ret=
rieve ONEREG %" PRIu64 " from KVM: %s"
>  kvm_failed_reg_set(uint64_t id, const char *msg) "Warning: Unable to set=
 ONEREG %" PRIu64 " to KVM: %s"
>  kvm_init_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id: %=
lu"
> +kvm_create_vcpu(int cpu_index, unsigned long arch_cpu_id, int kvm_fd) "i=
ndex: %d, id: %lu, kvm fd: %d"
> +kvm_destroy_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id=
: %lu"
> +kvm_park_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id: %=
lu"
> +kvm_unpark_vcpu(unsigned long arch_cpu_id) "id: %lu"
>  kvm_irqchip_commit_routes(void) ""
>  kvm_irqchip_add_msi_route(char *name, int vector, int virq) "dev %s vect=
or %d virq %d"
>  kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=3D%d"
> @@ -25,7 +29,6 @@ kvm_dirty_ring_reaper(const char *s) "%s"
>  kvm_dirty_ring_reap(uint64_t count, int64_t t) "reaped %"PRIu64" pages (=
took %"PRIi64" us)"
>  kvm_dirty_ring_reaper_kick(const char *reason) "%s"
>  kvm_dirty_ring_flush(int finished) "%d"
> -kvm_destroy_vcpu(void) ""
>  kvm_failed_get_vcpu_mmap_size(void) ""
>  kvm_cpu_exec(void) ""
>  kvm_interrupt_exit_request(void) ""


