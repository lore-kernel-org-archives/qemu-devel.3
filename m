Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB947C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 04:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7oln-000294-W1; Fri, 17 May 2024 00:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s7olg-00028I-Rv; Fri, 17 May 2024 00:00:28 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s7olc-0004zx-Hl; Fri, 17 May 2024 00:00:28 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5b283d2b1b4so593920eaf.0; 
 Thu, 16 May 2024 21:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715918421; x=1716523221; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=imrQh8ZZh+pNozzLNFmVTowD4hi/vLPNB4mvyTD1AZM=;
 b=M/OrxDTggOt/3ll6lqofqeXwaVQHIhEzywSemdfjnqLAUEdm+5oNYSgggpNuGPfRHF
 0sqJAMs5aNmkp+8QFOlJy60SaopJ1prmkkg7ltxFZZPgiEeEwCB9ZcZI0DOxD7Vo1eyE
 JYf0vrwN0LbntON9gPzw7mA9em60Uai5Aj8QA5p23YvmWZz92Q8oC3znaXu1cUiPTqzx
 jAkjKsTBiEgbdc2PVCCrtn9Zyh6zuFKHVCK2QQM7xg5OqIsEjUWktXrQv+NhFqMqcHmX
 Dec0FPfRvLv41JSw2r2wKUplvOJiN1jRp3CjNvRjrOrjQUIsdB1mK+Tfx9m823LmHXJy
 ig2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715918421; x=1716523221;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=imrQh8ZZh+pNozzLNFmVTowD4hi/vLPNB4mvyTD1AZM=;
 b=joD0p8+JfKYXnRwjXtjYwVDvzn0xn/3V92ouZeprcjLe/e1DJKLvds3V2kMbRgFcOh
 A70WTkg3i4SnJ+TL720gACaYXCTHM9jRL017mpB8QMeZWsrc1/efRBno2TEaqUDiPYrp
 X6dAhzKkxx20DNXs7zxg09A6tTSlc6ZymyPd9lRi+Jk2zLQWCe5ppe31j3jUezpi34/+
 OljhhIzcbc/6mPebyiKwJ53HcA+kKtwVeel2UNEoX4xig8ZFTxCcmmyr43CZNZtadTCF
 G9NxFLx/dhdzKU4BGMgYvrYpe4lJ1A4m0yX3gePr+XmWr6dumhPCCKpu7bMxzVRGgBa3
 FcNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1IlgtcImehQEx9o1P1aLQwF9naTOqZYPGlO8YcVPMDbJSMrsJzoRDjN5zEpnpGT7smoDwHlNr7TsYX59XflzcFAYYWKx3aZihP2Q/xQ8OWMLLmWq7G2rX0Vw=
X-Gm-Message-State: AOJu0Yy+fuSs/4Zn6SLUCfBbDrpJ8sEKOIpbJnlo295KsL/0gF3IG9ij
 Lh8XXipVpr1DhVK0+r6Xm0ZqyArmdFdu+dwca5A0iJJ0lcY8nSF2
X-Google-Smtp-Source: AGHT+IFOuaKSM388YPu/MIEf2Df8WSoiaewGxlWM9W3Xc+sO1CX0uv/EoPz714vV102lbm/fqeZi1g==
X-Received: by 2002:a05:6358:27a6:b0:191:96d4:b14d with SMTP id
 e5c5f4694b2df-193bcff520bmr2565577055d.30.1715918421290; 
 Thu, 16 May 2024 21:00:21 -0700 (PDT)
Received: from localhost ([1.146.118.37]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-65962f0d4e7sm2377036a12.18.2024.05.16.21.00.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 May 2024 21:00:20 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 May 2024 14:00:15 +1000
Message-Id: <D1BMB9HRF50E.2UC36WJ1ZHAFU@gmail.com>
Subject: Re: [PATCH] target/ppc: handle vcpu hotplug failure gracefully
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>,
 <qemu-devel@nongnu.org>
Cc: <danielhb413@gmail.com>, <vaibhav@linux.ibm.com>, <sbhat@linux.ibm.com>
X-Mailer: aerc 0.17.0
References: <20240423061058.595674-1-harshpb@linux.ibm.com>
 <a0f9b2fc-4c8a-4c37-bc36-26bbaa627fec@linux.ibm.com>
 <D191D2JFAR7L.2EH4S445M4TGK@gmail.com>
 <170efe52-97c4-48dd-b4ce-097655a76d9f@linux.ibm.com>
In-Reply-To: <170efe52-97c4-48dd-b4ce-097655a76d9f@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=npiggin@gmail.com; helo=mail-oo1-xc35.google.com
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

On Thu May 16, 2024 at 2:31 PM AEST, Harsh Prateek Bora wrote:
> Hi Nick,
>
> On 5/14/24 08:39, Nicholas Piggin wrote:
> > On Tue Apr 23, 2024 at 4:30 PM AEST, Harsh Prateek Bora wrote:
> >> + qemu-devel
> >>
> >> On 4/23/24 11:40, Harsh Prateek Bora wrote:
> >>> On ppc64, the PowerVM hypervisor runs with limited memory and a VCPU
> >>> creation during hotplug may fail during kvm_ioctl for KVM_CREATE_VCPU=
,
> >>> leading to termination of guest since errp is set to &error_fatal whi=
le
> >>> calling kvm_init_vcpu. This unexpected behaviour can be avoided by
> >>> pre-creating vcpu and parking it on success or return error otherwise=
.
> >>> This enables graceful error delivery for any vcpu hotplug failures wh=
ile
> >>> the guest can keep running.
> >=20
> > So this puts in on the park list so when kvm_init_vcpu() later runs it
> > will just take it off the park list instead of issuing another
> > KVM_CREATE_VCPU ioctl.
> >=20
> > And kvm_init_vcpu() runs in the vcpu thread function, which does not
> > have a good way to indicate failure to the caller.
> >=20
> > I'm don't know a lot about this part of qemu but it seems like a good
> > idea to move fail-able initialisation out of the vcpu thread in that
> > case. So the general idea seems good to me.
> >=20
>
> Yeh ..
>
> >>>
> >>> Based on api refactoring to create/park vcpus introduced in 1/8 of pa=
tch series:
> >>> https://lore.kernel.org/qemu-devel/20240312020000.12992-2-salil.mehta=
@huawei.com/
> >=20
> > So from this series AFAIKS you're just using kvm_create / kvm_park
> > routines? You could easily pull that patch 1 out ahead of that larger
> > series if progress is slow on it, it's a decent cleanup by itself by
> > the looks.
> >=20
>
> Yeh, patch 1 of that series is only we need but the author mentioned on=
=20
> the list that he is about to post next version soon.
>
> >>>
> >>> Tested OK by repeatedly doing a hotplug/unplug of vcpus as below:
> >>>
> >>>    #virsh setvcpus hotplug 40
> >>>    #virsh setvcpus hotplug 70
> >>> error: internal error: unable to execute QEMU command 'device_add':
> >>> kvmppc_cpu_realize: vcpu hotplug failed with -12
> >>>
> >>> Reported-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
> >>> Suggested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> >>> Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> >>> Signed-off by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> >>> ---
> >>> ---
> >>>    target/ppc/kvm.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> >>>    1 file changed, 42 insertions(+)
> >>>
> >>> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> >>> index 8231feb2d4..c887f6dfa0 100644
> >>> --- a/target/ppc/kvm.c
> >>> +++ b/target/ppc/kvm.c
> >>> @@ -48,6 +48,8 @@
> >>>    #include "qemu/mmap-alloc.h"
> >>>    #include "elf.h"
> >>>    #include "sysemu/kvm_int.h"
> >>> +#include "sysemu/kvm.h"
> >>> +#include "hw/core/accel-cpu.h"
> >>>   =20
> >>>    #define PROC_DEVTREE_CPU      "/proc/device-tree/cpus/"
> >>>   =20
> >>> @@ -2339,6 +2341,43 @@ static void alter_insns(uint64_t *word, uint64=
_t flags, bool on)
> >>>        }
> >>>    }
> >>>   =20
> >>> +static int max_cpu_index =3D 0;
> >>> +
> >>> +static bool kvmppc_cpu_realize(CPUState *cs, Error **errp)
> >>> +{
> >>> +    int ret;
> >>> +
> >>> +    cs->cpu_index =3D max_cpu_index++;
> >>> +
> >>> +    POWERPC_CPU(cs)->vcpu_id =3D cs->cpu_index;
> >=20
> > So you're overriding the cpu_get_free_index() allocator here.
> > And you need to because vcpu_id needs to be assigned before
> > the KVM create, I guess.
> >=20
>
> Yes ..
>
> > I guess it works. I would add a comment like s390x has.
> >=20
> Not sure which comment you were referring to but with exporting
> cpu_get_free_index as suggested later, not sure if we still need any
> comment.

Yeah that's true.

> >>> +
> >>> +    if (cs->parent_obj.hotplugged) {
> >=20
> > Can _all_ kvm cpu creation go via this path? Why just limit it to
> > hotplugged?
>
> For the initial bootup, we actually want to abort if the requested vCPUs
> cant be allocated so that user can retry until the requested vCPUs are
> allocated. For hotplug failure, bringing down entire guest isn't fair,
> hence the fix.

But you could make the error handling depend on hotplugged, no?
Perhaps put that error handling decision in common code so policy
is the same for all targets and back ends.

[...]

> >>> +}
> >>> +
> >>>    static void kvmppc_host_cpu_class_init(ObjectClass *oc, void *data=
)
> >>>    {
> >>>        PowerPCCPUClass *pcc =3D POWERPC_CPU_CLASS(oc);
> >>> @@ -2963,4 +3002,7 @@ bool kvm_arch_cpu_check_are_resettable(void)
> >>>   =20
> >>>    void kvm_arch_accel_class_init(ObjectClass *oc)
> >>>    {
> >>> +    AccelClass *ac =3D ACCEL_CLASS(oc);
> >>> +    ac->cpu_common_realize =3D kvmppc_cpu_realize;
> >>> +    ac->cpu_common_unrealize =3D kvmppc_cpu_unrealize;
> >>>    }

One other thing I noticed -- cpu_common_realize seems to be for
core code and cpu_target_realize for targets. Should we be
using the latter here? If not, a comment would be warranted and
probably also a comment in accel_cpu_common_realize().

Thanks,
Nick

