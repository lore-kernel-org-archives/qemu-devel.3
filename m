Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC6FC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 13:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQoTp-00010P-HQ; Mon, 08 Jul 2024 09:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sQoTi-0000yY-Cn
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 09:32:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sQoTf-0005iq-Rx
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 09:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720445542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CCgiakP/tarYnUD/h9zQxEYyvbavQe5Ott9VDqgWp+o=;
 b=INPe5rC4hjnBpmaZnBp0opUiCW05+x5LqrH+qJ4MShyRKK+Y60z5SZGkhmerNRV6x05LS1
 hk50E1ogDt4sfZVUpk0rBh9LcAn7Jd88dDbUxutk+MWMFj7tJldvHREmlDpba9mjCvtQIk
 Sjt8N53gRrcKGGxj9QkYfRXw8VR2Vas=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-nXx3NPm1NP2s4F-_bu5Gww-1; Mon, 08 Jul 2024 09:32:20 -0400
X-MC-Unique: nXx3NPm1NP2s4F-_bu5Gww-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a77b2edfe06so323317366b.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 06:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720445539; x=1721050339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CCgiakP/tarYnUD/h9zQxEYyvbavQe5Ott9VDqgWp+o=;
 b=VWFHiUvZdUw7sCafrZ7jiquCUAgtHVac/21i1wuQ7e6lOgdxMlp9HPyUMdGVkv98nO
 bhtxS2Pa2t70+NyBhJ04F8qc7cvhZ1zXBIzsXXzWES0UqURyIbbMEgbt332vqUw026c4
 T2CtRL9M+T0Ju5MSK2XgWZFPwXSqf/jr2G0r/zYs9IANBG4UQma3FFR07p33dMEjTP1R
 5hpliw1q1ZKDsFrI32rCwyDXUkdX9eXvvl2wbb5MxBOs+PlhF1E9ud+eFRalktRFvUTy
 MX5FktRdt1vN6e0YrvfOWd96Qmo4n7PpQFnkefPZhCC7PZiLZjlFyu3jwFN3LLo/RAI7
 br5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpN+ef93NZdxACP9GDBhuwgDz5zrQhWeYJvaNyS+/NrNDYQiVSs2pSN8uNl7VjUsdujfw12NATvChnFnoOBDCCoGbR25M=
X-Gm-Message-State: AOJu0YzJYpx289PmWI2ifEpoRxV8WZFzKelH46oPG3CarjAaF3vKMDhK
 8FGpZNb0vq3cvoHWq5lR+YS4LpoWgj0UN2c1ZLtjyA8j0h9kKogcSLqb5wcz+K07YTriO86NLQa
 azMmQHFjFWsB9kdPfMUgQlHdTX6ya8R02TxUssVFB0UTk6GS9sYYV
X-Received: by 2002:a05:6402:3506:b0:58d:d3f6:58d2 with SMTP id
 4fb4d7f45d1cf-58e59265d8cmr8164223a12.3.1720445539418; 
 Mon, 08 Jul 2024 06:32:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKwjCnxC3Oz59PwCMUNxPLVQahmFRz5P6u1Lme5VNAHi/RtTySxbbpKPz6+55yjsdpDNmtNg==
X-Received: by 2002:a05:6402:3506:b0:58d:d3f6:58d2 with SMTP id
 4fb4d7f45d1cf-58e59265d8cmr8164170a12.3.1720445538888; 
 Mon, 08 Jul 2024 06:32:18 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5903c7ac61csm3496577a12.4.2024.07.08.06.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 06:32:18 -0700 (PDT)
Date: Mon, 8 Jul 2024 15:32:16 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@opnsrc.net>
Cc: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, maz@kernel.org, jean-philippe@linaro.org,
 jonathan.cameron@huawei.com, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 andrew.jones@linux.dev, david@redhat.com, philmd@linaro.org,
 eric.auger@redhat.com, oliver.upton@linux.dev, pbonzini@redhat.com,
 mst@redhat.com, will@kernel.org, gshan@redhat.com, rafael@kernel.org,
 alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, zhukeqian1@huawei.com, wangxiongfeng2@huawei.com,
 wangyanan55@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, npiggin@gmail.com, harshpb@linux.ibm.com,
 linuxarm@huawei.com, Shaoqin Huang <shahuang@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH V13 1/8] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
Message-ID: <20240708153216.0d6d1ad1@imammedo.users.ipa.redhat.com>
In-Reply-To: <CAJ7pxeZV6qmDR8aXE5LaDZdjvGCJhnE4RZeL4823XqaiDApe1Q@mail.gmail.com>
References: <20240607115649.214622-1-salil.mehta@huawei.com>
 <20240607115649.214622-2-salil.mehta@huawei.com>
 <20240706151154.7c430b0a@imammedo.users.ipa.redhat.com>
 <CAJ7pxeZV6qmDR8aXE5LaDZdjvGCJhnE4RZeL4823XqaiDApe1Q@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On Sat, 6 Jul 2024 15:43:01 +0000
Salil Mehta <salil.mehta@opnsrc.net> wrote:

> Hi Igor,
> Thanks for taking out time to review.
>=20
> On Sat, Jul 6, 2024 at 1:12=E2=80=AFPM Igor Mammedov <imammedo@redhat.com=
> wrote:
>=20
> > On Fri, 7 Jun 2024 12:56:42 +0100
> > Salil Mehta <salil.mehta@huawei.com> wrote:
> > =20
> > > KVM vCPU creation is done once during the vCPU realization when Qemu =
=20
> > vCPU thread =20
> > > is spawned. This is common to all the architectures as of now.
> > >
> > > Hot-unplug of vCPU results in destruction of the vCPU object in QOM b=
ut =20
> > the =20
> > > corresponding KVM vCPU object in the Host KVM is not destroyed as KVM=
 =20
> > doesn't =20
> > > support vCPU removal. Therefore, its representative KVM vCPU =20
> > object/context in =20
> > > Qemu is parked.
> > >
> > > Refactor architecture common logic so that some APIs could be reused =
by =20
> > vCPU =20
> > > Hotplug code of some architectures likes ARM, Loongson etc. Update =20
> > new/old APIs =20
> > > with trace events. No functional change is intended here.
> > >
> > > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> > > Reviewed-by: Gavin Shan <gshan@redhat.com>
> > > Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Tested-by: Xianglai Li <lixianglai@loongson.cn>
> > > Tested-by: Miguel Luis <miguel.luis@oracle.com>
> > > Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> > > Reviewed-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> > > Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> > > Tested-by: Zhao Liu <zhao1.liu@intel.com>
> > > Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> > > Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> > > ---
> > >  accel/kvm/kvm-all.c    | 95 ++++++++++++++++++++++++++++------------=
--
> > >  accel/kvm/kvm-cpus.h   |  1 -
> > >  accel/kvm/trace-events |  5 ++-
> > >  include/sysemu/kvm.h   | 25 +++++++++++
> > >  4 files changed, 92 insertions(+), 34 deletions(-)
> > >
> > > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > > index c0be9f5eed..8f9128bb92 100644
> > > --- a/accel/kvm/kvm-all.c
> > > +++ b/accel/kvm/kvm-all.c
> > > @@ -340,14 +340,71 @@ err:
> > >      return ret;
> > >  }
> > >
> > > +void kvm_park_vcpu(CPUState *cpu)
> > > +{
> > > +    struct KVMParkedVcpu *vcpu;
> > > +
> > > +    trace_kvm_park_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
> > > +
> > > +    vcpu =3D g_malloc0(sizeof(*vcpu));
> > > +    vcpu->vcpu_id =3D kvm_arch_vcpu_id(cpu);
> > > +    vcpu->kvm_fd =3D cpu->kvm_fd;
> > > +    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
> > > +}
> > > +
> > > +int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id)
> > > +{
> > > +    struct KVMParkedVcpu *cpu;
> > > +    int kvm_fd =3D -ENOENT;
> > > +
> > > +    QLIST_FOREACH(cpu, &s->kvm_parked_vcpus, node) {
> > > +        if (cpu->vcpu_id =3D=3D vcpu_id) {
> > > +            QLIST_REMOVE(cpu, node);
> > > +            kvm_fd =3D cpu->kvm_fd;
> > > +            g_free(cpu);
> > > +        }
> > > +    }
> > > +
> > > +    trace_kvm_unpark_vcpu(vcpu_id, kvm_fd > 0 ? "unparked" : "not fo=
und =20
> > parked"); =20
> > > +
> > > +    return kvm_fd;
> > > +}
> > > +
> > > +int kvm_create_vcpu(CPUState *cpu)
> > > +{
> > > +    unsigned long vcpu_id =3D kvm_arch_vcpu_id(cpu);
> > > +    KVMState *s =3D kvm_state;
> > > +    int kvm_fd;
> > > +
> > > +    /* check if the KVM vCPU already exist but is parked */
> > > +    kvm_fd =3D kvm_unpark_vcpu(s, vcpu_id);
> > > +    if (kvm_fd < 0) {
> > > +        /* vCPU not parked: create a new KVM vCPU */
> > > +        kvm_fd =3D kvm_vm_ioctl(s, KVM_CREATE_VCPU, vcpu_id);
> > > +        if (kvm_fd < 0) {
> > > +            error_report("KVM_CREATE_VCPU IOCTL failed for vCPU %lu"=
, =20
> > vcpu_id); =20
> > > +            return kvm_fd;
> > > +        }
> > > +    }
> > > +
> > > +    cpu->kvm_fd =3D kvm_fd;
> > > +    cpu->kvm_state =3D s;
> > > +    cpu->vcpu_dirty =3D true;
> > > +    cpu->dirty_pages =3D 0;
> > > +    cpu->throttle_us_per_full =3D 0;
> > > +
> > > +    trace_kvm_create_vcpu(cpu->cpu_index, vcpu_id, kvm_fd);
> > > +
> > > +    return 0;
> > > +} =20
> >
> > Is there any reason why you are embedding/hiding kvm_state in new API
> > instead of passing it as argument (all callers have it defined, so why =
not
> > reuse that)?
> > =20
>=20
> It is a global variable and I don't think it is a usual practice to speci=
fy
> the global variable
> as an input parameter.

Ideally, global would be accessed once at API boundary entry
and the passed as an argument to functions it calls.
It makes it easier to follow as opposed to mixed access we have now,
which is harder to review since one has to check both
flavors (argument passed or directly accessed).

in this patch  kvm_init_vcpu() calls new kvm_create_vcpu()
and the former caches these global into 's' local variable,
so I'd reuse that local variable like kvm_get_vcpu() you are removing here =
did.

>=20
>=20
>=20
> >
> > otherwise patch lgtm =20
>=20
>=20
> May I request your Reviewed-by for this patch?
>=20
> Thanks
> Salil.
>=20
>=20
> >
> > =20
> > > +
> > >  static int do_kvm_destroy_vcpu(CPUState *cpu)
> > >  {
> > >      KVMState *s =3D kvm_state;
> > >      long mmap_size;
> > > -    struct KVMParkedVcpu *vcpu =3D NULL;
> > >      int ret =3D 0;
> > >
> > > -    trace_kvm_destroy_vcpu();
> > > +    trace_kvm_destroy_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
> > >
> > >      ret =3D kvm_arch_destroy_vcpu(cpu);
> > >      if (ret < 0) {
> > > @@ -373,10 +430,7 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
> > >          }
> > >      }
> > >
> > > -    vcpu =3D g_malloc0(sizeof(*vcpu));
> > > -    vcpu->vcpu_id =3D kvm_arch_vcpu_id(cpu);
> > > -    vcpu->kvm_fd =3D cpu->kvm_fd;
> > > -    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
> > > +    kvm_park_vcpu(cpu);
> > >  err:
> > >      return ret;
> > >  }
> > > @@ -389,24 +443,6 @@ void kvm_destroy_vcpu(CPUState *cpu)
> > >      }
> > >  }
> > >
> > > -static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id)
> > > -{
> > > -    struct KVMParkedVcpu *cpu;
> > > -
> > > -    QLIST_FOREACH(cpu, &s->kvm_parked_vcpus, node) {
> > > -        if (cpu->vcpu_id =3D=3D vcpu_id) {
> > > -            int kvm_fd;
> > > -
> > > -            QLIST_REMOVE(cpu, node);
> > > -            kvm_fd =3D cpu->kvm_fd;
> > > -            g_free(cpu);
> > > -            return kvm_fd;
> > > -        }
> > > -    }
> > > -
> > > -    return kvm_vm_ioctl(s, KVM_CREATE_VCPU, (void *)vcpu_id);
> > > -}
> > > -
> > >  int kvm_init_vcpu(CPUState *cpu, Error **errp)
> > >  {
> > >      KVMState *s =3D kvm_state;
> > > @@ -415,19 +451,14 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
> > >
> > >      trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
> > >
> > > -    ret =3D kvm_get_vcpu(s, kvm_arch_vcpu_id(cpu));
> > > +    ret =3D kvm_create_vcpu(cpu);
> > >      if (ret < 0) {
> > > -        error_setg_errno(errp, -ret, "kvm_init_vcpu: kvm_get_vcpu =20
> > failed (%lu)", =20
> > > +        error_setg_errno(errp, -ret,
> > > +                         "kvm_init_vcpu: kvm_create_vcpu failed (%lu=
)",
> > >                           kvm_arch_vcpu_id(cpu));
> > >          goto err;
> > >      }
> > >
> > > -    cpu->kvm_fd =3D ret;
> > > -    cpu->kvm_state =3D s;
> > > -    cpu->vcpu_dirty =3D true;
> > > -    cpu->dirty_pages =3D 0;
> > > -    cpu->throttle_us_per_full =3D 0;
> > > -
> > >      mmap_size =3D kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);
> > >      if (mmap_size < 0) {
> > >          ret =3D mmap_size;
> > > diff --git a/accel/kvm/kvm-cpus.h b/accel/kvm/kvm-cpus.h
> > > index ca40add32c..171b22fd29 100644
> > > --- a/accel/kvm/kvm-cpus.h
> > > +++ b/accel/kvm/kvm-cpus.h
> > > @@ -22,5 +22,4 @@ bool kvm_supports_guest_debug(void);
> > >  int kvm_insert_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr=
 =20
> > len); =20
> > >  int kvm_remove_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr=
 =20
> > len); =20
> > >  void kvm_remove_all_breakpoints(CPUState *cpu);
> > > -
> > >  #endif /* KVM_CPUS_H */
> > > diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
> > > index 681ccb667d..37626c1ac5 100644
> > > --- a/accel/kvm/trace-events
> > > +++ b/accel/kvm/trace-events
> > > @@ -9,6 +9,10 @@ kvm_device_ioctl(int fd, int type, void *arg) "dev f=
d =20
> > %d, type 0x%x, arg %p" =20
> > >  kvm_failed_reg_get(uint64_t id, const char *msg) "Warning: Unable to=
 =20
> > retrieve ONEREG %" PRIu64 " from KVM: %s" =20
> > >  kvm_failed_reg_set(uint64_t id, const char *msg) "Warning: Unable to=
 =20
> > set ONEREG %" PRIu64 " to KVM: %s" =20
> > >  kvm_init_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d i=
d: =20
> > %lu" =20
> > > +kvm_create_vcpu(int cpu_index, unsigned long arch_cpu_id, int kvm_fd=
) =20
> > "index: %d, id: %lu, kvm fd: %d" =20
> > > +kvm_destroy_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %=
d =20
> > id: %lu" =20
> > > +kvm_park_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d i=
d: =20
> > %lu" =20
> > > +kvm_unpark_vcpu(unsigned long arch_cpu_id, const char *msg) "id: %lu=
 %s"
> > >  kvm_irqchip_commit_routes(void) ""
> > >  kvm_irqchip_add_msi_route(char *name, int vector, int virq) "dev %s =
=20
> > vector %d virq %d" =20
> > >  kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=3D%d"
> > > @@ -25,7 +29,6 @@ kvm_dirty_ring_reaper(const char *s) "%s"
> > >  kvm_dirty_ring_reap(uint64_t count, int64_t t) "reaped %"PRIu64" pag=
es =20
> > (took %"PRIi64" us)" =20
> > >  kvm_dirty_ring_reaper_kick(const char *reason) "%s"
> > >  kvm_dirty_ring_flush(int finished) "%d"
> > > -kvm_destroy_vcpu(void) ""
> > >  kvm_failed_get_vcpu_mmap_size(void) ""
> > >  kvm_cpu_exec(void) ""
> > >  kvm_interrupt_exit_request(void) ""
> > > diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> > > index c31d9c7356..c4a914b3d8 100644
> > > --- a/include/sysemu/kvm.h
> > > +++ b/include/sysemu/kvm.h
> > > @@ -313,6 +313,31 @@ int kvm_create_device(KVMState *s, uint64_t type=
, =20
> > bool test); =20
> > >   */
> > >  bool kvm_device_supported(int vmfd, uint64_t type);
> > >
> > > +/**
> > > + * kvm_create_vcpu - Gets a parked KVM vCPU or creates a KVM vCPU
> > > + * @cpu: QOM CPUState object for which KVM vCPU has to be =20
> > fetched/created. =20
> > > + *
> > > + * @returns: 0 when success, errno (<0) when failed.
> > > + */
> > > +int kvm_create_vcpu(CPUState *cpu);
> > > +
> > > +/**
> > > + * kvm_park_vcpu - Park QEMU KVM vCPU context
> > > + * @cpu: QOM CPUState object for which QEMU KVM vCPU context has to =
be =20
> > parked. =20
> > > + *
> > > + * @returns: none
> > > + */
> > > +void kvm_park_vcpu(CPUState *cpu);
> > > +
> > > +/**
> > > + * kvm_unpark_vcpu - unpark QEMU KVM vCPU context
> > > + * @s: KVM State
> > > + * @vcpu_id: Architecture vCPU ID of the parked vCPU
> > > + *
> > > + * @returns: KVM fd
> > > + */
> > > +int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id);
> > > +
> > >  /* Arch specific hooks */
> > >
> > >  extern const KVMCapabilityInfo kvm_arch_required_capabilities[]; =20
> >
> > =20


