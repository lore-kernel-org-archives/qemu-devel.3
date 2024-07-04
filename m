Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B21C3065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 07:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPH00-0007XT-5z; Thu, 04 Jul 2024 03:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPGzy-0007WV-MR; Thu, 04 Jul 2024 03:35:22 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPGzw-0006iL-71; Thu, 04 Jul 2024 03:35:22 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6f8d0a1e500so305850a34.3; 
 Thu, 04 Jul 2024 00:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720078518; x=1720683318; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eSUB4FINtIAveQe59+mH2SSSNBs1jDk4kMe/1AFCLzQ=;
 b=GDadlWOpn1FN0pzZrKNV5ADdiVjEIJfk5M+7GaECOBuJS3jdorq42n4zCbVRZUV6TR
 I9Oef5HbnoisavGZ6IaS6zrWVq+SSbmPuLkSnrsr668zycIVbWsjBByLHb4OFgFxHPgg
 VFTZQ9EZbnS+jNCvDH8lTBBVQ1yZpmvmiRJzaxShwAOtnVRnns2/CUXQ/VYOanoeibZL
 xoASSlCiFyf+DGBWpo9HYEVdwmofEhRgcOSHh1Gx/4LiFHp+FU4hhkkr8lSBdJUEyR69
 kxEdyrZh7/Szc/GYBy9U1+kZkYFQUUKx/G5DJD/SY2t4mIfwm8PmymgIkepfSKtIN+mO
 G1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720078518; x=1720683318;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eSUB4FINtIAveQe59+mH2SSSNBs1jDk4kMe/1AFCLzQ=;
 b=xPejdlIEJrDIg7rZ9XUGh6Q9j3MbthgNNvEkVZtLRtjABn4FeZtX4B1Kmgi/web7NT
 Rq/gGFrJpTJCP+qk9ur8jz49aFclenXmOJOWGKWGJ3SMvCXy2/KYtoWG5hAu0G84UVRd
 j2iGUSCaUL79ocfXeIZPFRgZP+DoyDN4d5r/w2b7Oc5GuSJFi9GSsR152WAOFMnT+K5X
 3PuFQfvIQ8j58xhtTYQvexNVXv4LTjVSMRV7o2A/7kEWosCO8PFqIsBZlzNn8whMvyg5
 k/bj62wcHJ+nWpf0D2tEz4iK3oRXdDZ6y+80B7xZshu07fOuo+K7n9CJ8ZrFPhhDfK4O
 Hdwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/0cQC0+3XBNS5t4Dx0OtcLmAUC84Ehx1mTMSksfvG4YUX/wXqyem/XVRVLyfXCbf7KMg6kWJk6lxFIX9MtLDO+6gIdFyF6q8PgfNz0a1oo8bgn4POJKOxk0E=
X-Gm-Message-State: AOJu0YwGXfdOlz519Ky1X+ywIEsHaWJrlsLfq2br1DuyRx2JQFxUXzit
 F5ljbGk4egizWxssDCbr9B+ngkNRdPlH8Qpxmo115nJsYW78R2ou
X-Google-Smtp-Source: AGHT+IFWi4CKyHFMj/N8To1c+Ssfmq6DRWouvW/bGT2Ed3TESCQHA9oxL19P6HWUnUtiRaxutKDnIg==
X-Received: by 2002:a05:6358:3211:b0:1a4:e539:26af with SMTP id
 e5c5f4694b2df-1aa98c8198fmr78959155d.27.1720078517896; 
 Thu, 04 Jul 2024 00:35:17 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-72c6a8df09fsm9061713a12.34.2024.07.04.00.35.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 00:35:17 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 17:35:09 +1000
Message-Id: <D2GKXYCPW5KX.4P5GHFKH4YS8@gmail.com>
Cc: "Vaibhav Jain" <vaibhav@linux.ibm.com>, "sbhat@linux.ibm.com"
 <sbhat@linux.ibm.com>, "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org"
 <qemu-ppc@nongnu.org>
Subject: Re: [PATCH V13 1/8] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, "Salil Mehta"
 <salil.mehta@huawei.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "Peter Maydell" <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, "Igor Mammedov" <imammedo@redhat.com>
X-Mailer: aerc 0.17.0
References: <20240607115649.214622-1-salil.mehta@huawei.com>
 <20240607115649.214622-2-salil.mehta@huawei.com>
 <a9fe2b0f-baf2-4684-9e98-86f4df4e4ff5@linux.ibm.com>
 <66be5cd4b44f4ccebb00fd90ad145e48@huawei.com>
 <40196533-103c-42d8-9229-d394154affe6@linux.ibm.com>
 <4512d9d5-a2ee-4d83-9c44-510241d72225@linux.ibm.com>
In-Reply-To: <4512d9d5-a2ee-4d83-9c44-510241d72225@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=npiggin@gmail.com; helo=mail-ot1-x335.google.com
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

Looks like there is a bit of noise around this recently. Do we
think the hotplug patches can get over the line this time?

If not, perhaps we work with Salil to get this patch 1 upstream
at least.

Thanks,
Nick

On Tue Jun 25, 2024 at 3:08 PM AEST, Harsh Prateek Bora wrote:
> +qemu-devel, qemu-ppc
>
> Ping!
>
> On 6/17/24 15:18, Harsh Prateek Bora wrote:
> >=20
> > + MST, Igor - to help with early review/merge. TIA.
> >=20
> > On 6/14/24 16:06, Salil Mehta wrote:
> >> Hello
> >>
> >>> =C2=A0 From: Harsh Prateek Bora <harshpb@linux.ibm.com>
> >>> =C2=A0 Sent: Friday, June 14, 2024 6:24 AM
> >>> =C2=A0 Hi Paolo, Nick,
> >>> =C2=A0 Can this patch 1/8 be merged earlier provided we have got=20
> >>> sufficient R-bys
> >>> =C2=A0 for it and the review of entire series may take a longer time?
> >>> =C2=A0 We have some ppc64 patches based on it, hence the ask.
> >>> =C2=A0 Hi Salil,
> >>> =C2=A0 I am hoping we are not expecting anymore changes to this patch=
, please
> >>> =C2=A0 confirm.
> >>
> >>
> >> I do not expect any change. I had requested Michael to merge the compl=
ete
> >> series as it is stranding other users. He then requested Igor to take=
=20
> >> a final look but
> >> he has not reverted yet. I'll remind Michael again. BTW, can you reply=
=20
> >> to below
> >> patch explicitly indicating your interest in the series so that MST=20
> >> knows who else
> >> are the stake holders here
> >>
> >> https://lore.kernel.org/qemu-devel/20240605160327.3c71f4ab@imammedo.us=
ers.ipa.redhat.com/
> >>
> >>
> >> Hi Paolo,
> >>
> >> A request, would it be possible to skim through this series from KVM=
=20
> >> perspective?
> >> (although nothing has changed which will affect the KVM and this is=20
> >> architecture
> >> agnostic patch-set)
> >>
> >> Many thanks!
> >>
> >> Best
> >> Salil.
> >>
> >>
> >>> =C2=A0 regards,
> >>> =C2=A0 Harsh
> >>> =C2=A0 On 6/7/24 17:26, Salil Mehta wrote:
> >>> =C2=A0 > KVM vCPU creation is done once during the vCPU realization w=
hen Qemu
> >>> =C2=A0 > vCPU thread is spawned. This is common to all the architectu=
res=20
> >>> as of now.
> >>> =C2=A0 >
> >>> =C2=A0 > Hot-unplug of vCPU results in destruction of the vCPU object=
 in QOM
> >>> =C2=A0 > but the corresponding KVM vCPU object in the Host KVM is not=
=20
> >>> destroyed
> >>> =C2=A0 > as KVM doesn't support vCPU removal. Therefore, its=20
> >>> representative KVM
> >>> =C2=A0 > vCPU object/context in Qemu is parked.
> >>> =C2=A0 >
> >>> =C2=A0 > Refactor architecture common logic so that some APIs could b=
e reused
> >>> =C2=A0 > by vCPU Hotplug code of some architectures likes ARM, Loongs=
on etc.
> >>> =C2=A0 > Update new/old APIs with trace events. No functional change =
is=20
> >>> intended
> >>> =C2=A0 here.
> >>> =C2=A0 >
> >>> =C2=A0 > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> >>> =C2=A0 > Reviewed-by: Gavin Shan <gshan@redhat.com>
> >>> =C2=A0 > Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> >>> =C2=A0 > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>> =C2=A0 > Tested-by: Xianglai Li <lixianglai@loongson.cn>
> >>> =C2=A0 > Tested-by: Miguel Luis <miguel.luis@oracle.com>
> >>> =C2=A0 > Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> >>> =C2=A0 > Reviewed-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> >>> =C2=A0 > Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> >>> =C2=A0 > Tested-by: Zhao Liu <zhao1.liu@intel.com>
> >>> =C2=A0 > Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> >>> =C2=A0 > Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> >>> =C2=A0 > ---
> >>> =C2=A0 >=C2=A0=C2=A0 accel/kvm/kvm-all.c=C2=A0=C2=A0=C2=A0 | 95=20
> >>> ++++++++++++++++++++++++++++------------
> >>> =C2=A0 --
> >>> =C2=A0 >=C2=A0=C2=A0 accel/kvm/kvm-cpus.h=C2=A0=C2=A0 |=C2=A0 1 -
> >>> =C2=A0 >=C2=A0=C2=A0 accel/kvm/trace-events |=C2=A0 5 ++-
> >>> =C2=A0 >=C2=A0=C2=A0 include/sysemu/kvm.h=C2=A0=C2=A0 | 25 ++++++++++=
+
> >>> =C2=A0 >=C2=A0=C2=A0 4 files changed, 92 insertions(+), 34 deletions(=
-)
> >>> =C2=A0 >
> >>> =C2=A0 > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c index
> >>> =C2=A0 > c0be9f5eed..8f9128bb92 100644
> >>> =C2=A0 > --- a/accel/kvm/kvm-all.c
> >>> =C2=A0 > +++ b/accel/kvm/kvm-all.c
> >>> =C2=A0 > @@ -340,14 +340,71 @@ err:
> >>> =C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> >>> =C2=A0 >=C2=A0=C2=A0 }
> >>> =C2=A0 >
> >>> =C2=A0 > +void kvm_park_vcpu(CPUState *cpu)
> >>> =C2=A0 > +{
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0 struct KVMParkedVcpu *vcpu;
> >>> =C2=A0 > +
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0 trace_kvm_park_vcpu(cpu->cpu_index, kvm_=
arch_vcpu_id(cpu));
> >>> =C2=A0 > +
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0 vcpu =3D g_malloc0(sizeof(*vcpu));
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0 vcpu->vcpu_id =3D kvm_arch_vcpu_id(cpu);
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0 vcpu->kvm_fd =3D cpu->kvm_fd;
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0 QLIST_INSERT_HEAD(&kvm_state->kvm_parked=
_vcpus, vcpu, node); }
> >>> =C2=A0 > +
> >>> =C2=A0 > +int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id) {
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0 struct KVMParkedVcpu *cpu;
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0 int kvm_fd =3D -ENOENT;
> >>> =C2=A0 > +
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0 QLIST_FOREACH(cpu, &s->kvm_parked_vcpus,=
 node) {
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cpu->vcpu_id=
 =3D=3D vcpu_id) {
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 QLIST_REMOVE(cpu, node);
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 kvm_fd =3D cpu->kvm_fd;
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 g_free(cpu);
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0 }
> >>> =C2=A0 > +
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0 trace_kvm_unpark_vcpu(vcpu_id, kvm_fd > =
0 ? "unparked" : "not
> >>> =C2=A0 > + found parked");
> >>> =C2=A0 > +
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0 return kvm_fd;
> >>> =C2=A0 > +}
> >>> =C2=A0 > +
> >>> =C2=A0 > +int kvm_create_vcpu(CPUState *cpu)
> >>> =C2=A0 > +{
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0 unsigned long vcpu_id =3D kvm_arch_vcpu_=
id(cpu);
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0 KVMState *s =3D kvm_state;
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0 int kvm_fd;
> >>> =C2=A0 > +
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0 /* check if the KVM vCPU already exist b=
ut is parked */
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0 kvm_fd =3D kvm_unpark_vcpu(s, vcpu_id);
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0 if (kvm_fd < 0) {
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* vCPU not park=
ed: create a new KVM vCPU */
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_fd =3D kvm_v=
m_ioctl(s, KVM_CREATE_VCPU, vcpu_id);
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (kvm_fd < 0) =
{
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 error_report("KVM_CREATE_VCPU IOCTL failed for vCPU=20
> >>> %lu",
> >>> =C2=A0 vcpu_id);
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return kvm_fd;
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0 }
> >>> =C2=A0 > +
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0 cpu->kvm_fd =3D kvm_fd;
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0 cpu->kvm_state =3D s;
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0 cpu->vcpu_dirty =3D true;
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0 cpu->dirty_pages =3D 0;
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0 cpu->throttle_us_per_full =3D 0;
> >>> =C2=A0 > +
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0 trace_kvm_create_vcpu(cpu->cpu_index, vc=
pu_id, kvm_fd);
> >>> =C2=A0 > +
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0 return 0;
> >>> =C2=A0 > +}
> >>> =C2=A0 > +
> >>> =C2=A0 >=C2=A0=C2=A0 static int do_kvm_destroy_vcpu(CPUState *cpu)
> >>> =C2=A0 >=C2=A0=C2=A0 {
> >>> =C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KVMState *s =3D kvm_stat=
e;
> >>> =C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 long mmap_size;
> >>> =C2=A0 > -=C2=A0=C2=A0=C2=A0 struct KVMParkedVcpu *vcpu =3D NULL;
> >>> =C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D 0;
> >>> =C2=A0 >
> >>> =C2=A0 > -=C2=A0=C2=A0=C2=A0 trace_kvm_destroy_vcpu();
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0 trace_kvm_destroy_vcpu(cpu->cpu_index, k=
vm_arch_vcpu_id(cpu));
> >>> =C2=A0 >
> >>> =C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D kvm_arch_destroy=
_vcpu(cpu);
> >>> =C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
> >>> =C2=A0 > @@ -373,10 +430,7 @@ static int do_kvm_destroy_vcpu(CPUState=
 *cpu)
> >>> =C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
}
> >>> =C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>> =C2=A0 >
> >>> =C2=A0 > -=C2=A0=C2=A0=C2=A0 vcpu =3D g_malloc0(sizeof(*vcpu));
> >>> =C2=A0 > -=C2=A0=C2=A0=C2=A0 vcpu->vcpu_id =3D kvm_arch_vcpu_id(cpu);
> >>> =C2=A0 > -=C2=A0=C2=A0=C2=A0 vcpu->kvm_fd =3D cpu->kvm_fd;
> >>> =C2=A0 > -=C2=A0=C2=A0=C2=A0 QLIST_INSERT_HEAD(&kvm_state->kvm_parked=
_vcpus, vcpu, node);
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0 kvm_park_vcpu(cpu);
> >>> =C2=A0 >=C2=A0=C2=A0 err:
> >>> =C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> >>> =C2=A0 >=C2=A0=C2=A0 }
> >>> =C2=A0 > @@ -389,24 +443,6 @@ void kvm_destroy_vcpu(CPUState *cpu)
> >>> =C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>> =C2=A0 >=C2=A0=C2=A0 }
> >>> =C2=A0 >
> >>> =C2=A0 > -static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id)=
 -{
> >>> =C2=A0 > -=C2=A0=C2=A0=C2=A0 struct KVMParkedVcpu *cpu;
> >>> =C2=A0 > -
> >>> =C2=A0 > -=C2=A0=C2=A0=C2=A0 QLIST_FOREACH(cpu, &s->kvm_parked_vcpus,=
 node) {
> >>> =C2=A0 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cpu->vcpu_id=
 =3D=3D vcpu_id) {
> >>> =C2=A0 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 int kvm_fd;
> >>> =C2=A0 > -
> >>> =C2=A0 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 QLIST_REMOVE(cpu, node);
> >>> =C2=A0 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 kvm_fd =3D cpu->kvm_fd;
> >>> =C2=A0 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 g_free(cpu);
> >>> =C2=A0 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return kvm_fd;
> >>> =C2=A0 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>> =C2=A0 > -=C2=A0=C2=A0=C2=A0 }
> >>> =C2=A0 > -
> >>> =C2=A0 > -=C2=A0=C2=A0=C2=A0 return kvm_vm_ioctl(s, KVM_CREATE_VCPU, =
(void *)vcpu_id);
> >>> =C2=A0 > -}
> >>> =C2=A0 > -
> >>> =C2=A0 >=C2=A0=C2=A0 int kvm_init_vcpu(CPUState *cpu, Error **errp)
> >>> =C2=A0 >=C2=A0=C2=A0 {
> >>> =C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KVMState *s =3D kvm_stat=
e;
> >>> =C2=A0 > @@ -415,19 +451,14 @@ int kvm_init_vcpu(CPUState *cpu, Error=
 **errp)
> >>> =C2=A0 >
> >>> =C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_kvm_init_vcpu(cpu-=
>cpu_index, kvm_arch_vcpu_id(cpu));
> >>> =C2=A0 >
> >>> =C2=A0 > -=C2=A0=C2=A0=C2=A0 ret =3D kvm_get_vcpu(s, kvm_arch_vcpu_id=
(cpu));
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0 ret =3D kvm_create_vcpu(cpu);
> >>> =C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
> >>> =C2=A0 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg_errno=
(errp, -ret, "kvm_init_vcpu:=20
> >>> kvm_get_vcpu failed
> >>> =C2=A0 (%lu)",
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg_errno=
(errp, -ret,
> >>> =C2=A0 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 "kvm_init_vcpu: kvm_create_vcpu failed
> >>> =C2=A0 > + (%lu)",
> >>> =C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_arch_vcpu_id(cpu));
> >>> =C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
goto err;
> >>> =C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>> =C2=A0 >
> >>> =C2=A0 > -=C2=A0=C2=A0=C2=A0 cpu->kvm_fd =3D ret;
> >>> =C2=A0 > -=C2=A0=C2=A0=C2=A0 cpu->kvm_state =3D s;
> >>> =C2=A0 > -=C2=A0=C2=A0=C2=A0 cpu->vcpu_dirty =3D true;
> >>> =C2=A0 > -=C2=A0=C2=A0=C2=A0 cpu->dirty_pages =3D 0;
> >>> =C2=A0 > -=C2=A0=C2=A0=C2=A0 cpu->throttle_us_per_full =3D 0;
> >>> =C2=A0 > -
> >>> =C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mmap_size =3D kvm_ioctl(=
s, KVM_GET_VCPU_MMAP_SIZE, 0);
> >>> =C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mmap_size < 0) {
> >>> =C2=A0 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
ret =3D mmap_size;
> >>> =C2=A0 > diff --git a/accel/kvm/kvm-cpus.h b/accel/kvm/kvm-cpus.h ind=
ex
> >>> =C2=A0 > ca40add32c..171b22fd29 100644
> >>> =C2=A0 > --- a/accel/kvm/kvm-cpus.h
> >>> =C2=A0 > +++ b/accel/kvm/kvm-cpus.h
> >>> =C2=A0 > @@ -22,5 +22,4 @@ bool kvm_supports_guest_debug(void);
> >>> =C2=A0 >=C2=A0=C2=A0 int kvm_insert_breakpoint(CPUState *cpu, int typ=
e, vaddr addr,=20
> >>> vaddr
> >>> =C2=A0 len);
> >>> =C2=A0 >=C2=A0=C2=A0 int kvm_remove_breakpoint(CPUState *cpu, int typ=
e, vaddr addr,=20
> >>> vaddr
> >>> =C2=A0 len);
> >>> =C2=A0 >=C2=A0=C2=A0 void kvm_remove_all_breakpoints(CPUState *cpu);
> >>> =C2=A0 > -
> >>> =C2=A0 >=C2=A0=C2=A0 #endif /* KVM_CPUS_H */
> >>> =C2=A0 > diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events=
 index
> >>> =C2=A0 > 681ccb667d..37626c1ac5 100644
> >>> =C2=A0 > --- a/accel/kvm/trace-events
> >>> =C2=A0 > +++ b/accel/kvm/trace-events
> >>> =C2=A0 > @@ -9,6 +9,10 @@ kvm_device_ioctl(int fd, int type, void *ar=
g)=20
> >>> "dev fd
> >>> =C2=A0 %d, type 0x%x, arg %p"
> >>> =C2=A0 >=C2=A0=C2=A0 kvm_failed_reg_get(uint64_t id, const char *msg)=
 "Warning:=20
> >>> Unable to
> >>> =C2=A0 retrieve ONEREG %" PRIu64 " from KVM: %s"
> >>> =C2=A0 >=C2=A0=C2=A0 kvm_failed_reg_set(uint64_t id, const char *msg)=
 "Warning:=20
> >>> Unable to
> >>> =C2=A0 set ONEREG %" PRIu64 " to KVM: %s"
> >>> =C2=A0 >=C2=A0=C2=A0 kvm_init_vcpu(int cpu_index, unsigned long arch_=
cpu_id) "index:=20
> >>> %d id:
> >>> =C2=A0 %lu"
> >>> =C2=A0 > +kvm_create_vcpu(int cpu_index, unsigned long arch_cpu_id, i=
nt
> >>> =C2=A0 kvm_fd) "index: %d, id: %lu, kvm fd: %d"
> >>> =C2=A0 > +kvm_destroy_vcpu(int cpu_index, unsigned long arch_cpu_id) =
"index:
> >>> =C2=A0 %d id: %lu"
> >>> =C2=A0 > +kvm_park_vcpu(int cpu_index, unsigned long arch_cpu_id) "in=
dex: %d
> >>> =C2=A0 id: %lu"
> >>> =C2=A0 > +kvm_unpark_vcpu(unsigned long arch_cpu_id, const char *msg)=
 "id:=20
> >>> %lu
> >>> =C2=A0 %s"
> >>> =C2=A0 >=C2=A0=C2=A0 kvm_irqchip_commit_routes(void) ""
> >>> =C2=A0 >=C2=A0=C2=A0 kvm_irqchip_add_msi_route(char *name, int vector=
, int virq)=20
> >>> "dev %s
> >>> =C2=A0 vector %d virq %d"
> >>> =C2=A0 >=C2=A0=C2=A0 kvm_irqchip_update_msi_route(int virq) "Updating=
 MSI route=20
> >>> virq=3D%d"
> >>> =C2=A0 > @@ -25,7 +29,6 @@ kvm_dirty_ring_reaper(const char *s) "%s"
> >>> =C2=A0 >=C2=A0=C2=A0 kvm_dirty_ring_reap(uint64_t count, int64_t t) "=
reaped=20
> >>> %"PRIu64" pages
> >>> =C2=A0 (took %"PRIi64" us)"
> >>> =C2=A0 >=C2=A0=C2=A0 kvm_dirty_ring_reaper_kick(const char *reason) "=
%s"
> >>> =C2=A0 >=C2=A0=C2=A0 kvm_dirty_ring_flush(int finished) "%d"
> >>> =C2=A0 > -kvm_destroy_vcpu(void) ""
> >>> =C2=A0 >=C2=A0=C2=A0 kvm_failed_get_vcpu_mmap_size(void) ""
> >>> =C2=A0 >=C2=A0=C2=A0 kvm_cpu_exec(void) ""
> >>> =C2=A0 >=C2=A0=C2=A0 kvm_interrupt_exit_request(void) ""
> >>> =C2=A0 > diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h ind=
ex
> >>> =C2=A0 > c31d9c7356..c4a914b3d8 100644
> >>> =C2=A0 > --- a/include/sysemu/kvm.h
> >>> =C2=A0 > +++ b/include/sysemu/kvm.h
> >>> =C2=A0 > @@ -313,6 +313,31 @@ int kvm_create_device(KVMState *s, uint=
64_t
> >>> =C2=A0 type, bool test);
> >>> =C2=A0 >=C2=A0=C2=A0=C2=A0 */
> >>> =C2=A0 >=C2=A0=C2=A0 bool kvm_device_supported(int vmfd, uint64_t typ=
e);
> >>> =C2=A0 >
> >>> =C2=A0 > +/**
> >>> =C2=A0 > + * kvm_create_vcpu - Gets a parked KVM vCPU or creates a KV=
M vCPU
> >>> =C2=A0 > + * @cpu: QOM CPUState object for which KVM vCPU has to be
> >>> =C2=A0 fetched/created.
> >>> =C2=A0 > + *
> >>> =C2=A0 > + * @returns: 0 when success, errno (<0) when failed.
> >>> =C2=A0 > + */
> >>> =C2=A0 > +int kvm_create_vcpu(CPUState *cpu);
> >>> =C2=A0 > +
> >>> =C2=A0 > +/**
> >>> =C2=A0 > + * kvm_park_vcpu - Park QEMU KVM vCPU context
> >>> =C2=A0 > + * @cpu: QOM CPUState object for which QEMU KVM vCPU contex=
t has
> >>> =C2=A0 to be parked.
> >>> =C2=A0 > + *
> >>> =C2=A0 > + * @returns: none
> >>> =C2=A0 > + */
> >>> =C2=A0 > +void kvm_park_vcpu(CPUState *cpu);
> >>> =C2=A0 > +
> >>> =C2=A0 > +/**
> >>> =C2=A0 > + * kvm_unpark_vcpu - unpark QEMU KVM vCPU context
> >>> =C2=A0 > + * @s: KVM State
> >>> =C2=A0 > + * @vcpu_id: Architecture vCPU ID of the parked vCPU
> >>> =C2=A0 > + *
> >>> =C2=A0 > + * @returns: KVM fd
> >>> =C2=A0 > + */
> >>> =C2=A0 > +int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id);
> >>> =C2=A0 > +
> >>> =C2=A0 >=C2=A0=C2=A0 /* Arch specific hooks */
> >>> =C2=A0 >
> >>> =C2=A0 >=C2=A0=C2=A0 extern const KVMCapabilityInfo kvm_arch_required=
_capabilities[];


