Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C3CC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 10:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxPNP-0003be-Mz; Thu, 18 Apr 2024 06:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rxPNO-0003bV-JK
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 06:52:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rxPNL-0003fv-Un
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 06:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713437538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z5yQQ9+HqOdnSSMoMMxll3hRjVFCuVvYEA7XZVkaoLE=;
 b=DIIQaibk+URlzVZ4oGIAtwFa6n6bezdJjqxx5+Martuqwo4JtTJOFaFaaKylXbz7HXRGOd
 2rjnYIGAxjvvjhT+AIHMoOzmLIZMLHrexIXtqnG7DHmqzKrwaHwTNVRXOdlKYgIl7mSsWP
 /FIbHabmVY+F8KJvCrXiYF8VK/WBLcQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-KwHbZNIIMfCGdTUlht5erg-1; Thu, 18 Apr 2024 06:52:17 -0400
X-MC-Unique: KwHbZNIIMfCGdTUlht5erg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-416e58bdc0eso3882345e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 03:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713437536; x=1714042336;
 h=in-reply-to:references:user-agent:to:from:subject:cc:message-id
 :date:content-transfer-encoding:mime-version:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z5yQQ9+HqOdnSSMoMMxll3hRjVFCuVvYEA7XZVkaoLE=;
 b=eNeqZBQFroWiT0ENaWbB3Fqn6t6104D3xuqWzCrFBtirawXjbk2FwuPWgHeCJXDDZi
 sagGGqe7aH05pR6XAslOMpQl8/NFRW8aGrBvVz/wvWg3Na6dycCUKXlV++dI0ukkMNn1
 vgUwdabS0lIG1aloptlTXe424hCLDtonCxmBrhFNOHhTcUbZ6rJ9rFJInDpZF0Wp7Zt2
 AQdNpStLaQYlvBkOsylVqKtdBMws0JmQbWBab0QocLC6k0bzauA6OGTbXoeihNSvDz5c
 4CDfcUVPbxAHFixmdvH+qcsa50plozDGFXcUL/bj3Wvf9qS+2gbBNm+Sb/DbOOqvrNhK
 1bBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSZ2Iw5kDDy2buPsgeCBNzcybmqSqduuz2LBPcG/qNSk3Tnuyy+jKP785dAM/RZuPg72ROSrI2MqwAlm14ZNpk8EQpHdI=
X-Gm-Message-State: AOJu0YzED/Z3JisoYespkQe4Fm9mGapofbQdWh9RlgQiOhovsAr6/1SO
 ztTVPsFL9GBr9SpvGmOT/z3yA6nDq0ra7UU2jDYDbKw3s6Var/ykKzvOEnkibd9w8ID/Eju5ZFp
 8reH+iLC7WcaoejJ2Y2np7aInNxDgwL8auFZyUFkzCp8h4aWDF4w4
X-Received: by 2002:a05:600c:ccf:b0:418:ced:647a with SMTP id
 fk15-20020a05600c0ccf00b004180ced647amr1813544wmb.21.1713437536400; 
 Thu, 18 Apr 2024 03:52:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZvt7tECDAfC1w/+NhTu46OOeJWPCUC840sPxoVE9yYKgygw3TGcb+prvsiUn4g9tfVGeDKQ==
X-Received: by 2002:a05:600c:ccf:b0:418:ced:647a with SMTP id
 fk15-20020a05600c0ccf00b004180ced647amr1813529wmb.21.1713437535978; 
 Thu, 18 Apr 2024 03:52:15 -0700 (PDT)
Received: from localhost ([2a01:e0a:a9a:c460:2827:8723:3c60:c84a])
 by smtp.gmail.com with ESMTPSA id
 p25-20020a05600c1d9900b00418e70ff73csm1641929wms.7.2024.04.18.03.52.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 03:52:15 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Apr 2024 12:52:14 +0200
Message-Id: <D0N6WWRR5VKO.29E6AQDHW1X6A@fedora>
Cc: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <berrange@redhat.com>,
 <qemu-devel@nongnu.org>, <vchundur@redhat.com>, <rjarry@redhat.com>
Subject: Re: [PATCH v5 3/3] Add support for RAPL MSRs in KVM/Qemu
From: "Anthony Harivel" <aharivel@redhat.com>
To: "Zhao Liu" <zhao1.liu@intel.com>
User-Agent: aerc/0.15.2-111-g39195000e213
References: <20240411121434.253353-1-aharivel@redhat.com>
 <20240411121434.253353-4-aharivel@redhat.com> <Zh+fRliUJ8sPcOpD@intel.com>
In-Reply-To: <Zh+fRliUJ8sPcOpD@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.719,
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


Hi Zhao,

Zhao Liu, Apr 17, 2024 at 12:07:
> Hi Anthony,
>
> May I ask what your usage scenario is? Is it to measure Guest's energy
> consumption and to charged per watt consumed? ;-)

See previous email from Daniel.

> On Thu, Apr 11, 2024 at 02:14:34PM +0200, Anthony Harivel wrote:
> > Date: Thu, 11 Apr 2024 14:14:34 +0200
> > From: Anthony Harivel <aharivel@redhat.com>
> > Subject: [PATCH v5 3/3] Add support for RAPL MSRs in KVM/Qemu
> >=20
> > Starting with the "Sandy Bridge" generation, Intel CPUs provide a RAPL
> > interface (Running Average Power Limit) for advertising the accumulated
> > energy consumption of various power domains (e.g. CPU packages, DRAM,
> > etc.).
> >
> > The consumption is reported via MSRs (model specific registers) like
> > MSR_PKG_ENERGY_STATUS for the CPU package power domain. These MSRs are
> > 64 bits registers that represent the accumulated energy consumption in
> > micro Joules. They are updated by microcode every ~1ms.
>
> What is your current target platform?
>
> On future Xeon platforms (EMR and beyond) RAPL will support TPMI (an MMIO
> interface) and the TPMI based RAPL will be preferred in the future as
> well:
> * TPMI doc: https://github.com/intel/tpmi_power_management
> * TPMI based RAPL driver: drivers/powercap/intel_rapl_tpmi.c
>
> So do you have the plan to support RAPL-TPMI?

Yes, I guess this would be inevitable in the future. But right now the=20
lack of HW with this TPMI make hard to integrate it on day 1.

> > For now, KVM always returns 0 when the guest requests the value of
> > these MSRs. Use the KVM MSR filtering mechanism to allow QEMU handle
> > these MSRs dynamically in userspace.
> >=20
> > To limit the amount of system calls for every MSR call, create a new
> > thread in QEMU that updates the "virtual" MSR values asynchronously.
> >=20
> > Each vCPU has its own vMSR to reflect the independence of vCPUs. The
> > thread updates the vMSR values with the ratio of energy consumed of
> > the whole physical CPU package the vCPU thread runs on and the
> > thread's utime and stime values.
> >=20
> > All other non-vCPU threads are also taken into account. Their energy
> > consumption is evenly distributed among all vCPUs threads running on
> > the same physical CPU package.
>
> The package energy consumption includes core part and uncore part, where
> uncore part consumption may not be able to be scaled based on vCPU
> runtime ratio.
>
> When the uncore part consumption is small, the error in this part is
> small, but if it is large, then the error generated by scaling by vCPU
> runtime will be large.
>

So far we can only work with what Intel is giving us i.e Package power=20
plane and DRAM power plane on server, which is the main target of=20
this feature. Maybe in the future, Intel will expand the core power=20
plane and the uncore power plane to server class CPU ?

> May I ask what your usage scenario is? Is there significant uncore
> consumption (e.g. GPU)?
>

Same answer as above: uncore/graphics power plane is only available on=20
client class CPU.=20

> Also, I think of a generic question is whether the error in this
> calculation is measurable? Like comparing the RAPL status of the same
> workload on Guest and bare metal to check the error.
>
> IIUC, this calculation is highly affected by native/sibling Guests,
> especially in cloud scenarios where there are multiple Guests, the
> accuracy of this algorithm needs to be checked.
>

Indeed, depending on where your vCPUs are running within the package (on=20
the native or sibling CPU), you might observe different power=20
consumption levels. However, I don't consider this to be a problem, as=20
the ratio calculation takes into account the vCPU's location.

We also need to approach the measurement differently. Due to the=20
complexity of factors influencing power consumption, we must compare=20
what is comparable. If you require precise power consumption data,=20
use a power meter on the PSU of the server.It will provide the=20
ultimate judgment. However, if you need an estimation to optimize=20
software workloads in a guest, then this feature could be useful. All my=20
tests have consistently shown reproducible output in terms of power=20
consumption, which has convinced me that we can effectively work with=20
it.

> > To overcome the problem that reading the RAPL MSR requires priviliged
> > access, a socket communication between QEMU and the qemu-vmsr-helper is
> > mandatory. You can specified the socket path in the parameter.
> >=20
> > This feature is activated with -accel kvm,rapl=3Dtrue,path=3D/path/sock=
.sock
>
> Based on the above comment, I suggest to rename this option as "rapl-msr"
> to distinguish it from rapl-tpmi.

Fair enough, I can rename this like that.

>
> In addition, RAPL is basically a CPU feature, I think it would be more
> appropriate to make it as a x86 CPU's property.
>
> Your RAPL support actually provides a framework for assisting KVM
> emulation in userspace, so this informs other feature support (maybe mode=
l
> specific, or architectural) in the future. Enabling/disabling CPU feature=
s
> via -cpu looks more natural.

This is totally dependant of KVM because it used the KVM MSR Filtering=20
to access userspace when a specific MSR is required.

I can try to find a way to use -cpu for this feature and check if KVM is=20
activated or not.=20

>
> [snip]
>
> > +High level implementation
> > +-------------------------
> > +
> > +In order to update the value of the virtual MSR, a QEMU thread is crea=
ted.
> > +The thread is basically just an infinity loop that does:
> > +
> > +1. Snapshot of the time metrics of all QEMU threads (Time spent schedu=
led in
> > +   Userspace and System)
> >
> > +2. Snapshot of the actual MSR_PKG_ENERGY_STATUS counter of all package=
s where
> > +   the QEMU threads are running on.
> > +
> > +3. Sleep for 1 second - During this pause the vcpu and other non-vcpu =
threads
> > +   will do what they have to do and so the energy counter will increas=
e.
> > +
> > +4. Repeat 2. and 3. and calculate the delta of every metrics represent=
ing the
> > +   time spent scheduled for each QEMU thread *and* the energy spent by=
 the
> > +   packages during the pause.
> > +
> > +5. Filter the vcpu threads and the non-vcpu threads.
> > +
> > +6. Retrieve the topology of the Virtual Machine. This helps identify w=
hich
> > +   vCPU is running on which virtual package.
> > +
> > +7. The total energy spent by the non-vcpu threads is divided by the nu=
mber
> > +   of vcpu threads so that each vcpu thread will get an equal part of =
the
> > +   energy spent by the QEMU workers.
> > +
> > +8. Calculate the ratio of energy spent per vcpu threads.
> > +
> > +9. Calculate the energy for each virtual package.
> > +
> > +10. The virtual MSRs are updated for each virtual package. Each vCPU t=
hat
> > +    belongs to the same package will return the same value when access=
ing the
> > +    the MSR.
> > +
> > +11. Loop back to 1.
> > +
> > +Ratio calculation
> > +-----------------
> > +
> > +In Linux, a process has an execution time associated with it. The sche=
duler is
> > +dividing the time in clock ticks. The number of clock ticks per second=
 can be
> > +found by the sysconf system call. A typical value of clock ticks per s=
econd is
> > +100. So a core can run a process at the maximum of 100 ticks per secon=
d. If a
> > +package has 4 cores, 400 ticks maximum can be scheduled on all the cor=
es
> > +of the package for a period of 1 second.
> > +
> > +The /proc/[pid]/stat [#b]_ is a sysfs file that can give the executed =
time of a
> > +process with the [pid] as the process ID. It gives the amount of ticks=
 the
> > +process has been scheduled in userspace (utime) and kernel space (stim=
e).
> > +
>
> I understand tick would ignore frequency changes, e.g., HWP's auto-pilot
> or turbo boost. All these CPU frequency change would impact on core energ=
y
> consumption.
>
> I think the better way would be to use APERF counter, but unfortunately i=
t
> lacks virtualization support (for Intel).
>
> Due to such considerations, it may be more worthwhile to evaluate the
> accuracy of this tick-based algorithm.
>

I've evaluated such things with another tool called Kepler [1]. This=20
tool calculate the power ratio with metrics from RAPL and uses either=20
eBPF or the tick based systems for time metrics. The eBPF part [2] is=20
triggered on each 'finish_task_switch' of Thread and calculate the delta=20
of cpu cycle, cache miss, cpu time, etc. Very complex. My tests showed=20
that the difference between using eBPF and tick based ratio is really=20
not that important. Maybe on some special cases, using eBPF would show=20
a way better accuracy but I'm not aware of that.


[1]: https://github.com/sustainable-computing-io/kepler
[2]: https://github.com/sustainable-computing-io/kepler/blob/main/bpfassets=
/libbpf/src/kepler.bpf.c

> [snip]
>
> > diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> > index e68cbe929302..3de69caa229e 100644
> > --- a/target/i386/kvm/kvm.c
> > +++ b/target/i386/kvm/kvm.c
>
> [snip]
>
> > +static void *kvm_msr_energy_thread(void *data)
> > +{
> > +    KVMState *s =3D data;
> > +    struct KVMMsrEnergy *vmsr =3D &s->msr_energy;
> > +
> > +    g_autofree package_energy_stat *pkg_stat =3D NULL;
> > +    g_autofree thread_stat *thd_stat =3D NULL;
> > +    g_autofree pid_t *thread_ids =3D NULL;
> > +    g_autofree CPUState *cpu =3D NULL;
> > +    g_autofree unsigned int *vpkgs_energy_stat =3D NULL;
> > +    unsigned int num_threads =3D 0;
> > +    unsigned int tmp_num_threads =3D 0;
>
> [snip]
>
> > +        /* Sleep a short period while the other threads are working */
> > +        usleep(MSR_ENERGY_THREAD_SLEEP_US);
>
> Is it possible to passively read the energy status? i.e. access the Host
> MSR and calculate the energy consumption for the Guest when the Guest
> triggers the relevant exit.
>

Yes it could be possible. But what I wanted to avoid with my approach is=20
the overhead it could take when accessing a RAPL MSR in the Guest.
The value is always available and return very quickly.=20
I'm not sure about the overhead if we have to have to access the MSR,=20
then do the calculation and so on.

> I think this might make the error larger, but not sure the error would
> be so large as to be unacceptable.
>

I'm a bit concerned about the potential overflow in calculation if the=20
time in between is too big.=20

> [snip]
>
> > +        /* Retrieve the virtual package number of each vCPU */
> > +        for (int i =3D 0; i < vmsr->x86_cpu_list->len; i++) {
> > +            for (int j =3D 0; j < num_threads; j++) {
> > +                if ((thd_stat[j].acpi_id =3D=3D vmsr->x86_cpu_list->cp=
us[i].arch_id)
> > +                    && (thd_stat[j].is_vcpu =3D=3D true)) {
> > +                    x86_topo_ids_from_apicid(thd_stat[j].acpi_id,
> > +                        &vmsr->topo_info, &topo_ids);
> > +                    thd_stat[j].vpkg_id =3D topo_ids.pkg_id;
> > +                }
> > +            }
> > +        }
>
> We lack package instances as well as MSR topology, so we have to deal
> with this pain...
>
> Similarly, my attempt at other package/die level MSRs [1] is to only
> allow Guest to set a package/die.
>
> But I think that in the future with QOM-topo [2] (i.e. creating package/
> die instances), MSR topology can have an easier implementation, though,
> looks there's a long way to go!
>
> [1]: https://lore.kernel.org/qemu-devel/20240203093054.412135-4-zhao1.liu=
@linux.intel.com/
> [2]: https://lore.kernel.org/qemu-devel/20231130144203.2307629-1-zhao1.li=
u@linux.intel.com/
>

Oh, great! Good to know!=20
Topology is indeed a nightmare so good luck with that!!=20


> > +        /* Calculate the total energy of all non-vCPU thread */
> > +        for (int i =3D 0; i < num_threads; i++) {
> > +            double temp;
> > +            if ((thd_stat[i].is_vcpu !=3D true) &&
> > +                (thd_stat[i].delta_ticks > 0)) {
> > +                temp =3D vmsr_get_ratio(pkg_stat[thd_stat[i].pkg_id].e=
_delta,
> > +                    thd_stat[i].delta_ticks,
> > +                    vmsr->host_topo.maxticks[thd_stat[i].pkg_id]);
> > +                pkg_stat[thd_stat[i].pkg_id].e_ratio
> > +                    +=3D (uint64_t)lround(temp);
> > +            }
> > +        }
> > +
>
> [snip]
>
> > +static int kvm_msr_energy_thread_init(KVMState *s, MachineState *ms)
> > +{
> > +    struct KVMMsrEnergy *r =3D &s->msr_energy;
> > +    int ret =3D 0;
> > +
>
> [snip]
>
> > +    /* Retrieve the number of virtual sockets */
> > +    r->vsockets =3D ms->smp.sockets;
>
> RAPL's package domain is special:
>  * When there's no die, it's package-scope.
>  * When there's die level, it's die-scope.
>
> In SDM vol.3, char 15.10 PLATFORM SPECIFIC POWER MANAGEMENT SUPPORT, it
> said: Package domain is the processor die.
>
> So if a Guest has die level, thers MSRs should be shared in a die. Thus
> I guess the energy consumption status should also be distributed based on
> the die number.
>

Right, I've missed that totally. Thanks for let me know.
I'm going to have a deeper look at this.


> > +    /* Allocate register memory (MSR_PKG_STATUS) for each vcpu */
> > +    r->msr_value =3D g_new0(uint64_t, r->vcpus);
> > +
> > +    /* Retrieve the CPUArchIDlist */
> > +    r->x86_cpu_list =3D x86_possible_cpu_arch_ids(ms);
> > +
>
> [snip]
>
> > +int is_rapl_enabled(void)
> > +{
> > +    const char *path =3D "/sys/class/powercap/intel-rapl/enabled";
>
> This field does not ensure the existence of RAPL MSRs since TPMI would
> also enable this field. (See powercap_register_control_type() in
> drivers/powercap/intel_rapl_{msr,tpmi}.c)
>

But this is exactly what it is intended to do. Wether it is MSR of TPMI,=20
checking this, tell me that RAPL is activated or not. If it is=20
activated...

> We can read RAPL MSRs directly. If we get 0 or failure, then there's no
> RAPL MSRs on Host.
>

... then it is safe to access the RAPL MSR. I would not like to access=20
this on a XYZ cpu without knowing I can !

> > +    FILE *file =3D fopen(path, "r");
> > +    int value =3D 0;
> > +
> > +    if (file !=3D NULL) {
> > +        if (fscanf(file, "%d", &value) !=3D 1) {
> > +            error_report("INTEL RAPL not enabled");
> > +        }
> > +        fclose(file);
> > +    } else {
> > +        error_report("Error opening %s", path);
> > +    }
> > +
> > +    return value;
> > +}
>
> [snip]
>
> > +/* Get the physical package id from a given cpu id */
> > +int vmsr_get_physical_package_id(int cpu_id)
> > +{
> > +    g_autofree char *file_contents =3D NULL;
> > +    g_autofree char *file_path =3D NULL;
> > +    int package_id =3D -1;
> > +    gsize length;
> > +
> > +    file_path =3D g_strdup_printf("/sys/devices/system/cpu/cpu%d\
> > +        /topology/physical_package_id", cpu_id);
>
> Similarly, based on the topological properties of RAPL, it is more
> accurate to also consider the die_id.
>
> Currently, only CLX-AP has multiple dies. So, we either have to put a
> limit on the Host's CPU model or consider the topology of the die here
> as well. I think the latter is a more general approach.
>

Alright. I take not on that and I will check the die approach.

> > +
> > +    if (!g_file_get_contents(file_path, &file_contents, &length, NULL)=
) {
> > +        goto out;
> > +    }
> > +
> > +    package_id =3D atoi(file_contents);
> > +
> > +out:
> > +    return package_id;
> > +}
> > +
>
> Regards,
> Zhao

Thanks a lot for all your feedback Zhao !

Regards,
Anthony




