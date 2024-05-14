Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B62C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 03:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6iYT-00078Z-DQ; Mon, 13 May 2024 23:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s6iYQ-000780-Kl; Mon, 13 May 2024 23:10:14 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s6iYO-0000NR-2z; Mon, 13 May 2024 23:10:14 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6f0fbfc6f80so504939a34.3; 
 Mon, 13 May 2024 20:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715656199; x=1716260999; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T57KxEGNMVkteuhepSr07XVNN60N73bWIolZbM+7i3s=;
 b=K8YojowVfTgDj2MxGSbLJMRCXE80ljhDn7AXc/yBcCmTUwW3AhLip38L8kuc84Ulzw
 3PLW8J8Y3msvQPSN/B1T1W7kR5Ee7Vqt1ttOF45Koe0U9JweThDIqFrjVRUi4iSpvSOk
 1pZ2w1aYTlC+zUtB7M2M2uYM5ecJNPAKK4L9+v1G0CAvBqQzhkwlE8xG6VVWAqyuH8gA
 fqwxq6G6jKWM49F7BAh1oUAdum081Fw9UCfZbQ5EKr8Fx9fROv98DQ4PqFWlywBsR8oo
 hhUvnDd+CKq4X3wWcArGn/zFwCtU9L6i06MVUTI662wkLsUrArJ/ozqp7UVGs1gKXxG/
 PRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715656199; x=1716260999;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=T57KxEGNMVkteuhepSr07XVNN60N73bWIolZbM+7i3s=;
 b=O7HiRnNOLDOXW6dmca0mmkIKHOFbZVl5TQVYSvg8QvX0yvyW7imOXMXZcP4fvFGLpu
 kKj5R3EAK/v9nYdwYVEmi1E7J1PnWCjGfYyQ0KbwhDEqYJmXPWQVuHRx2TBzWZ5OCCGo
 0sS6k0mdPTxrSYnVjlLnKLBjrc892gTtRZMoFqoABEBqyN35FoqmzyO06f929h/+dvar
 SEc+siqM8W90CcCoNelZElxHlm90dmXTpiEHacXF1yH6eGXViPfoD5cKlb8KeVqoaWro
 YMSNwo7K2crDtN8LFOLSLg0Br/50H9PqhU1DtF8ifW3/xlpLn3aO8FjCL0HbaMHMxFqE
 kiJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdH9XRi0EkB/44BjuoExv086UX5ZJTMlyeP8z9wEEKm6cHXPRhDv6Y4oJn28kVt3Ap4RA2Un9Y2ofQWsiODZxGR7aMW8k0JGeWgTZ3yoyo/tfvv0ZLjvzlnzg=
X-Gm-Message-State: AOJu0Yz0eO6yb33YgWMQxZuETGTpRM8DBMWdN/K1vI1CezKQN4WAUI4o
 /CXuyUT+VzwjI3WyLnpns7bUs4xYKH9VIN2mj+RSHFn62GHiDe12
X-Google-Smtp-Source: AGHT+IF9mQJk8yXvbjmccIbJsXtzI9W8uI7jY0a4YJ6JhM24SI9ILxQmXPwkWVXmfYFT9d1uhgvk4Q==
X-Received: by 2002:a05:6870:c111:b0:23e:7764:779d with SMTP id
 586e51a60fabf-24172c2f9d5mr14087911fac.48.1715656199033; 
 Mon, 13 May 2024 20:09:59 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4f89d7ff5sm3921025b3a.84.2024.05.13.20.09.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 20:09:58 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 May 2024 13:09:53 +1000
Message-Id: <D191D2JFAR7L.2EH4S445M4TGK@gmail.com>
Cc: <danielhb413@gmail.com>, <vaibhav@linux.ibm.com>, <sbhat@linux.ibm.com>
Subject: Re: [PATCH] target/ppc: handle vcpu hotplug failure gracefully
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>,
 <qemu-devel@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240423061058.595674-1-harshpb@linux.ibm.com>
 <a0f9b2fc-4c8a-4c37-bc36-26bbaa627fec@linux.ibm.com>
In-Reply-To: <a0f9b2fc-4c8a-4c37-bc36-26bbaa627fec@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=npiggin@gmail.com; helo=mail-ot1-x331.google.com
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

On Tue Apr 23, 2024 at 4:30 PM AEST, Harsh Prateek Bora wrote:
> + qemu-devel
>
> On 4/23/24 11:40, Harsh Prateek Bora wrote:
> > On ppc64, the PowerVM hypervisor runs with limited memory and a VCPU
> > creation during hotplug may fail during kvm_ioctl for KVM_CREATE_VCPU,
> > leading to termination of guest since errp is set to &error_fatal while
> > calling kvm_init_vcpu. This unexpected behaviour can be avoided by
> > pre-creating vcpu and parking it on success or return error otherwise.
> > This enables graceful error delivery for any vcpu hotplug failures whil=
e
> > the guest can keep running.

So this puts in on the park list so when kvm_init_vcpu() later runs it
will just take it off the park list instead of issuing another
KVM_CREATE_VCPU ioctl.

And kvm_init_vcpu() runs in the vcpu thread function, which does not
have a good way to indicate failure to the caller.

I'm don't know a lot about this part of qemu but it seems like a good
idea to move fail-able initialisation out of the vcpu thread in that
case. So the general idea seems good to me.

> >=20
> > Based on api refactoring to create/park vcpus introduced in 1/8 of patc=
h series:
> > https://lore.kernel.org/qemu-devel/20240312020000.12992-2-salil.mehta@h=
uawei.com/

So from this series AFAIKS you're just using kvm_create / kvm_park
routines? You could easily pull that patch 1 out ahead of that larger
series if progress is slow on it, it's a decent cleanup by itself by
the looks.

> >=20
> > Tested OK by repeatedly doing a hotplug/unplug of vcpus as below:
> >=20
> >   #virsh setvcpus hotplug 40
> >   #virsh setvcpus hotplug 70
> > error: internal error: unable to execute QEMU command 'device_add':
> > kvmppc_cpu_realize: vcpu hotplug failed with -12
> >=20
> > Reported-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
> > Suggested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> > Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> > Signed-off by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> > ---
> > ---
> >   target/ppc/kvm.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 42 insertions(+)
> >=20
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index 8231feb2d4..c887f6dfa0 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -48,6 +48,8 @@
> >   #include "qemu/mmap-alloc.h"
> >   #include "elf.h"
> >   #include "sysemu/kvm_int.h"
> > +#include "sysemu/kvm.h"
> > +#include "hw/core/accel-cpu.h"
> >  =20
> >   #define PROC_DEVTREE_CPU      "/proc/device-tree/cpus/"
> >  =20
> > @@ -2339,6 +2341,43 @@ static void alter_insns(uint64_t *word, uint64_t=
 flags, bool on)
> >       }
> >   }
> >  =20
> > +static int max_cpu_index =3D 0;
> > +
> > +static bool kvmppc_cpu_realize(CPUState *cs, Error **errp)
> > +{
> > +    int ret;
> > +
> > +    cs->cpu_index =3D max_cpu_index++;
> > +
> > +    POWERPC_CPU(cs)->vcpu_id =3D cs->cpu_index;

So you're overriding the cpu_get_free_index() allocator here.
And you need to because vcpu_id needs to be assigned before
the KVM create, I guess.

I guess it works. I would add a comment like s390x has.

> > +
> > +    if (cs->parent_obj.hotplugged) {

Can _all_ kvm cpu creation go via this path? Why just limit it to
hotplugged?

> > +        /* create and park to fail gracefully in case vcpu hotplug fai=
ls */
> > +        ret =3D kvm_create_vcpu(cs);
> > +        if (!ret) {
> > +            kvm_park_vcpu(cs);

Seems like a small thing, but I would add a new core kvm function
that creates and parks the vcpu, so the target code doesn't have
to know about the parking internals, just that it needs to be
called.

Unless I'm missing something, we could get all targets to move their kvm
create to here and remove it removed from kvm_init_vcpu(), that would
just expect it to be on the parked list. But that could be done
incrementally.

> > +        } else {
> > +            max_cpu_index--;
> > +            error_setg(errp, "%s: vcpu hotplug failed with %d",
> > +                             __func__, ret);
> > +            return false;
> > +        }
> > +    }
> > +    return true;
> > +}
> > +
> > +static void kvmppc_cpu_unrealize(CPUState *cpu)
> > +{
> > +    if (POWERPC_CPU(cpu)->vcpu_id =3D=3D (max_cpu_index - 1)) {
> > +    /* only reclaim vcpuid if its the last one assigned
> > +     * as reclaiming random vcpuid for parked vcpus may lead
> > +     * to unexpected behaviour due to an existing kernel bug
> > +     * when drc_index doesnt get reclaimed as expected.
> > +     */
> > +        max_cpu_index--;
> > +    }

This looks like a fairly lossy allocator. Using cpu_get_free_index()
would be the way to go I think. I would export that and call it here,
and then you don't need this. Just have to take care of the assert,
something like this:

diff --git a/cpu-common.c b/cpu-common.c
index ce78273af5..9f90c8ec9b 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -57,14 +57,11 @@ void cpu_list_unlock(void)
     qemu_mutex_unlock(&qemu_cpu_list_lock);
 }
=20
-static bool cpu_index_auto_assigned;
-
-static int cpu_get_free_index(void)
+int cpu_get_free_index(void)
 {
     CPUState *some_cpu;
     int max_cpu_index =3D 0;
=20
-    cpu_index_auto_assigned =3D true;
     CPU_FOREACH(some_cpu) {
         if (some_cpu->cpu_index >=3D max_cpu_index) {
             max_cpu_index =3D some_cpu->cpu_index + 1;
@@ -83,8 +80,11 @@ unsigned int cpu_list_generation_id_get(void)
=20
 void cpu_list_add(CPUState *cpu)
 {
+    static bool cpu_index_auto_assigned;
+
     QEMU_LOCK_GUARD(&qemu_cpu_list_lock);
     if (cpu->cpu_index =3D=3D UNASSIGNED_CPU_INDEX) {
+        cpu_index_auto_assigned =3D true;
         cpu->cpu_index =3D cpu_get_free_index();
         assert(cpu->cpu_index !=3D UNASSIGNED_CPU_INDEX);
     } else {


> > +}
> > +
> >   static void kvmppc_host_cpu_class_init(ObjectClass *oc, void *data)
> >   {
> >       PowerPCCPUClass *pcc =3D POWERPC_CPU_CLASS(oc);
> > @@ -2963,4 +3002,7 @@ bool kvm_arch_cpu_check_are_resettable(void)
> >  =20
> >   void kvm_arch_accel_class_init(ObjectClass *oc)
> >   {
> > +    AccelClass *ac =3D ACCEL_CLASS(oc);
> > +    ac->cpu_common_realize =3D kvmppc_cpu_realize;
> > +    ac->cpu_common_unrealize =3D kvmppc_cpu_unrealize;
> >   }

Thanks,
Nick

