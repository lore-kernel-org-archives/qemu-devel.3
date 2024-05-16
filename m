Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAE7C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 14:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7bxE-0003cl-3z; Thu, 16 May 2024 10:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1s7bxB-0003cD-6Z
 for qemu-devel@nongnu.org; Thu, 16 May 2024 10:19:29 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1s7bwy-0003P0-KI
 for qemu-devel@nongnu.org; Thu, 16 May 2024 10:19:28 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a5a4bc9578cso297028566b.2
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 07:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1715869154; x=1716473954; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fFaK/7Ba96/UkjzxpXmMYzRYtaGwy1MtM9HVmALwU4E=;
 b=Utlq4kc0Wt+yAiFjCafCCzJPsKDEiwGS3UmDf6rGbIldafvig+dJ8OkZ6h5ALCozsi
 W7ixzdsnMX5b61wUsHie3cXgsgFXeBvecvlSrVOiycx+J+xKI192NdthL0jmTc+5Dmnp
 hWB092I0qUptxnlhFJbZZWWRwU9cdumPtWlhu+DS65mg5GHbVSqNNwEGbDP+HxJCJL8h
 917QSoqHgQizjSXzrPEVCRrqmLmuSwMX5HSEbdS1KMVysmBHSoWlHzpwWVkTl/+tJPug
 zzI5zcFabENseBY5FsEval9hBIs7HCaeDBQ0k7qMKhoz/aJtXUdXFaPNDqQcuGFZwyys
 HMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715869154; x=1716473954;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fFaK/7Ba96/UkjzxpXmMYzRYtaGwy1MtM9HVmALwU4E=;
 b=bTsC9Lp16xgYlNFNJQaPtZwixZTfjIV5kwR5TUIZLHH8mnoa9TJ/WeDsaSYx0BilAL
 VZRmYwd+utVIhsi/bNDZjEx/bdRBNXk55u7MH1P293uFpIGk1nwJ3/A5j5jttvNfztVu
 o7hFzU3QYvydQ96Jmq2tnytVDXJPcMiOEbg8i5ADSfX5OSm9Qiz/hySKqrTM6PzgYt0m
 j5q0XHshOrxrVHZ2rWCj6Okdw/bKC0fe2yQfxMn4wfZY831PwlC9TU6f5rLih5FsJjz4
 lHplp8bf6/83kbbeRfN5MjiLGzZFmOLDWv3cijLICZawaQepHvEKtdIioP7q3MWsJPPH
 IveA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXekppFCmfx/YGjAQvn6/8X+JAEtz8qBj49kp0Pf9zKyxEKYt7FIXrVn5zmITJn+AooWqY4rXThWwViUc4TYm1rYM9BuMo=
X-Gm-Message-State: AOJu0Yykw2vnWLg/eOqkEJ+gxPcPQGX1qIxBQh0YOu86dYhkAbx+waxw
 r/pyPyDM2eEWENXnzbjpkcMKWscXrM+e4EBpPMEbKbV5f4ee8vnTMKJAtpzi/EQGwmbvUh2qKeG
 Qio45Ha1hCFyCX1D7QkG7/X72PILejoJPCJzWCA==
X-Google-Smtp-Source: AGHT+IE6hx5PCLB8j1G9PZJC4RxmECOWnMhWXVLX7PwBdBKQLmJ5GvjEEAOgjSrgW9EuMLaaNvig7xZibraprbybu7g=
X-Received: by 2002:a17:906:7f09:b0:a59:ccbb:595b with SMTP id
 a640c23a62f3a-a5a2d572b33mr1699292166b.25.1715869154445; Thu, 16 May 2024
 07:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240516053211.145504-1-harshpb@linux.ibm.com>
 <20240516053211.145504-2-harshpb@linux.ibm.com>
 <fc08e87c979a4916aaff649724df9c6b@huawei.com>
 <bfb5888c-c66c-4000-ba12-5af202b0fe17@linux.ibm.com>
 <2e290791a92949d79fe0fdfcb972a029@huawei.com>
 <49f4d0cb-260e-45fb-a678-2dec45c9fab8@linux.ibm.com>
 <7a5608c768254869a4a6b68d719c24f1@huawei.com>
 <5bd52d8f5aaa49d6bc0ae419bb16c27c@huawei.com>
In-Reply-To: <5bd52d8f5aaa49d6bc0ae419bb16c27c@huawei.com>
From: Salil Mehta <salil.mehta@opnsrc.net>
Date: Thu, 16 May 2024 14:19:02 +0000
Message-ID: <CAJ7pxebKithkOudgJUW1KT9mi1fs2g9b0rUaY8OkZoW4StuFuw@mail.gmail.com>
Subject: [PATCH v2 1/4] accel/kvm: Extract common KVM vCPU {creation,
 parking} code
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Salil Mehta <salil.mehta@huawei.com>,
 "npiggin@gmail.com" <npiggin@gmail.com>, 
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "danielhb413@gmail.com" <danielhb413@gmail.com>,
 "vaibhav@linux.ibm.com" <vaibhav@linux.ibm.com>, 
 "sbhat@linux.ibm.com" <sbhat@linux.ibm.com>
Content-Type: multipart/alternative; boundary="0000000000006eaf5f061892eb0a"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000006eaf5f061892eb0a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[+] Adding this email address to the conversation.

(sorry for the noise)

>  From: Salil Mehta
>  Sent: Thursday, May 16, 2024 2:36 PM
>
>  >  From: Harsh Prateek Bora <harshpb@linux.ibm.com>
>  >  Sent: Thursday, May 16, 2024 2:07 PM
>  >
>  >  Hi Salil,
>  >
>  >  On 5/16/24 17:42, Salil Mehta wrote:
>  >  > Hi Harsh,
>  >  >
>  >  >>   From: Harsh Prateek Bora <harshpb@linux.ibm.com>
>  >  >>   Sent: Thursday, May 16, 2024 11:15 AM
>  >  >>
>  >  >>   Hi Salil,
>  >  >>
>  >  >>   Thanks for your email.
>  >  >>   Your patch 1/8 is included here based on review comments on my
previous
>  >  >>   patch from one of the maintainers in the community and therefore
I had
>  >  >>   kept you in CC to be aware of the desire of having this
independent patch to
>  >  >>   get merged earlier even if your other patches in the series may
go through
>  >  >>   further reviews.
>  >  >
>  >  > I really don=E2=80=99t know which discussion you are pointing at? P=
lease
>  > > understand you are fixing a bug and we are pushing a feature which
has got large series.
>  >  > It will break the patch-set  which is about to be merged.
>  >  >
>  >  > There will be significant overhead of testing on us for the work we
>  > > have been carrying forward for large time. This will be disruptive.
Please dont!
>  >  >
>  >
>  >  I was referring to the review discussion on my prev patch here:
>  >
>  >
https://lore.kernel.org/qemu-devel/D191D2JFAR7L.2EH4S445M4TGK@gmail.com/
>
>
>  Ok, I'm, not sure what this means.
>
>
>  >  Although your patch was included with this series only to facilitate
>  > review of  the additional patches depending on just one of your patch.
>
>
>  Generally you rebase your patch-set over the other and clearly state on
the
>  cover letter that this patch-set is dependent upon such and such
patch-set.
>  Just imagine if everyone starts to unilaterally pick up patches from eac=
h
>  other's patch-set it will create a chaos not only for the feature owners
but
>  also for the maintainers.
>
>
>  >
>  >  I am not sure what is appearing disruptive here. It is a common
>  > practive in  the community that maintainer(s) can pick individual
>  > patches from the  series if it has been vetted by siginificant number
of reviewers.
>
>
>  Don=E2=80=99t you think this patch-set is asking for acceptance for a pa=
tch
already
>  part of another patch-set which is about to be accepted and is a bigger
>  feature? Will it cause maintenance overhead at the last moment? Yes, of
course!
>
>
>  >  However, in this case, since you have mentioned to post next version
soon,
>  >  you need not worry about it as that would be the preferred version
for both
>  >  of the series.
>
>
>  Yes, but please understand we are working for the benefit of overall
>  community. Please cooperate here.
>
>  >
>  >  >
>  >  >>
>  >  >>   I am hoping to see your v9 soon and thereafter maintainer(s) may
choose to
>  >  >>   pick the latest independent patch if needs to be merged earlier.
>  >  >
>  >  >
>  >  > I don=E2=80=99t think you are understanding what problem it is caus=
ing. For
>  >  > your small bug fix you are causing significant delays at our end.
>  >  >
>  >
>  >  I hope I clarfied above that including your patch here doesnt delay
anything.
>  >  Hoping to see your v9 soon!
>  >
>  >  Thanks
>  >  Harsh
>  >  >
>  >  > Thanks
>  >  > Salil.
>  >  >>
>  >  >>   Thanks for your work and let's be hopeful it gets merged soon.
>  >  >>
>  >  >>   regards,
>  >  >>   Harsh
>  >  >>
>  >  >>   On 5/16/24 14:00, Salil Mehta wrote:
>  >  >>   > Hi Harsh,
>  >  >>   >
>  >  >>   > Thanks for your interest in the patch-set but taking away
patches like
>  >  >>   > this from other series without any discussion can disrupt
others work
>  >  >>   > and its acceptance on time. This is because we will have to
put lot of
>  >  >>   > effort in rebasing bigger series and then testing overhead
comes along
>  >  >>   > with it.
>  >  >>   >
>  >  >>   > The patch-set (from where this  patch has been taken) is part
of even
>  >  >>   > bigger series and there have been many people and companies
toiling to
>  >  >>   > fix the bugs collectively in that series and for years.
>  >  >>   >
>  >  >>   > I'm about float the V9 version of the Arch agnostic series
which this
>  >  >>   > patch is part of and you can rebase your patch-set from there.
I'm
>  >  >>   > hopeful that it will get accepted in this cycle.
>  >  >>   >
>  >  >>   >
>  >  >>   > Many thanks
>  >  >>   > Salil.
>  >  >>   >
>  >  >>   >>   From: Harsh Prateek Bora <harshpb@linux.ibm.com>
>  >  >>   >>   Sent: Thursday, May 16, 2024 6:32 AM
>  >  >>   >>
>  >  >>   >>   From: Salil Mehta <salil.mehta@huawei.com>
>  >  >>   >>
>  >  >>   >>   KVM vCPU creation is done once during the vCPU realization
when Qemu
>  >  >>   >>   vCPU thread is spawned. This is common to all the
architectures as of now.
>  >  >>   >>
>  >  >>   >>   Hot-unplug of vCPU results in destruction of the vCPU
object in QOM but
>  >  >>   >>   the corresponding KVM vCPU object in the Host KVM is not
destroyed as
>  >  >>   >>   KVM doesn't support vCPU removal. Therefore, its
representative KVM
>  >  >>   >>   vCPU object/context in Qemu is parked.
>  >  >>   >>
>  >  >>   >>   Refactor architecture common logic so that some APIs could
be reused by
>  >  >>   >>   vCPU Hotplug code of some architectures likes ARM, Loongson
etc. Update
>  >  >>   >>   new/old APIs with trace events instead of DPRINTF. No
functional change is
>  >  >>   >>   intended here.
>  >  >>   >>
>  >  >>   >>   Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>  >  >>   >>   Reviewed-by: Gavin Shan <gshan@redhat.com>
>  >  >>   >>   Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
>  >  >>   >>   Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>  >  >>   >>   Tested-by: Xianglai Li <lixianglai@loongson.cn>
>  >  >>   >>   Tested-by: Miguel Luis <miguel.luis@oracle.com>
>  >  >>   >>   Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
>  >  >>   >>   [harshpb: fixed rebase failures in include/sysemu/kvm.h]
>  >  >>   >>   Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>  >  >>   >>   ---
>  >  >>   >>    include/sysemu/kvm.h   | 15 ++++++++++
>  >  >>   >>    accel/kvm/kvm-all.c    | 64
>  >  ++++++++++++++++++++++++++++++++---
>  >  >>   -----
>  >  >>   >>   --
>  >  >>   >>    accel/kvm/trace-events |  5 +++-
>  >  >>   >>    3 files changed, 68 insertions(+), 16 deletions(-)
>  >  >>   >>
>  >  >>   >>   diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
>  index
>  >  >>   >>   eaf801bc93..fa3ec74442 100644
>  >  >>   >>   --- a/include/sysemu/kvm.h
>  >  >>   >>   +++ b/include/sysemu/kvm.h
>  >  >>   >>   @@ -434,6 +434,21 @@ void kvm_set_sigmask_len(KVMState *s,
>  >  >>   unsigned
>  >  >>   >>   int sigmask_len);
>  >  >>   >>
>  >  >>   >>    int kvm_physical_memory_addr_from_host(KVMState *s, void
>  >  >>   >>   *ram_addr,
>  >  >>   >>                                           hwaddr *phys_addr);
>  >  >>   >>   +/**
>  >  >>   >>   + * kvm_create_vcpu - Gets a parked KVM vCPU or creates a
KVM
>  >  >>   vCPU
>  >  >>   >>   + * @cpu: QOM CPUState object for which KVM vCPU has to be
>  >  >>   >>   fetched/created.
>  >  >>   >>   + *
>  >  >>   >>   + * @returns: 0 when success, errno (<0) when failed.
>  >  >>   >>   + */
>  >  >>   >>   +int kvm_create_vcpu(CPUState *cpu);
>  >  >>   >>   +
>  >  >>   >>   +/**
>  >  >>   >>   + * kvm_park_vcpu - Park QEMU KVM vCPU context
>  >  >>   >>   + * @cpu: QOM CPUState object for which QEMU KVM vCPU
context has to
>  >  >>   >>   be parked.
>  >  >>   >>   + *
>  >  >>   >>   + * @returns: none
>  >  >>   >>   + */
>  >  >>   >>   +void kvm_park_vcpu(CPUState *cpu);
>  >  >>   >>
>  >  >>   >>    #endif /* COMPILING_PER_TARGET */
>  >  >>   >>
>  >  >>   >>   diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c inde=
x
>  >  >>   >>   d7281b93f3..30d42847de 100644
>  >  >>   >>   --- a/accel/kvm/kvm-all.c
>  >  >>   >>   +++ b/accel/kvm/kvm-all.c
>  >  >>   >>   @@ -128,6 +128,7 @@ static QemuMutex kml_slots_lock;
>  #define
>  >  >>   >>   kvm_slots_unlock()  qemu_mutex_unlock(&kml_slots_lock)
>  >  >>   >>
>  >  >>   >>    static void kvm_slot_init_dirty_bitmap(KVMSlot *mem);
>  >  >>   >>   +static int kvm_get_vcpu(KVMState *s, unsigned long
vcpu_id);
>  >  >>   >>
>  >  >>   >>    static inline void kvm_resample_fd_remove(int gsi)  { @@ -
>  340,14
>  >  >>   +341,53
>  >  >>   >>   @@ err:
>  >  >>   >>        return ret;
>  >  >>   >>    }
>  >  >>   >>
>  >  >>   >>   +void kvm_park_vcpu(CPUState *cpu)
>  >  >>   >>   +{
>  >  >>   >>   +    struct KVMParkedVcpu *vcpu;
>  >  >>   >>   +
>  >  >>   >>   +    trace_kvm_park_vcpu(cpu->cpu_index,
kvm_arch_vcpu_id(cpu));
>  >  >>   >>   +
>  >  >>   >>   +    vcpu =3D g_malloc0(sizeof(*vcpu));
>  >  >>   >>   +    vcpu->vcpu_id =3D kvm_arch_vcpu_id(cpu);
>  >  >>   >>   +    vcpu->kvm_fd =3D cpu->kvm_fd;
>  >  >>   >>   +    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu,
node); }
>  >  >>   >>   +
>  >  >>   >>   +int kvm_create_vcpu(CPUState *cpu)
>  >  >>   >>   +{
>  >  >>   >>   +    unsigned long vcpu_id =3D kvm_arch_vcpu_id(cpu);
>  >  >>   >>   +    KVMState *s =3D kvm_state;
>  >  >>   >>   +    int kvm_fd;
>  >  >>   >>   +
>  >  >>   >>   +    trace_kvm_create_vcpu(cpu->cpu_index,
kvm_arch_vcpu_id(cpu));
>  >  >>   >>   +
>  >  >>   >>   +    /* check if the KVM vCPU already exist but is parked *=
/
>  >  >>   >>   +    kvm_fd =3D kvm_get_vcpu(s, vcpu_id);
>  >  >>   >>   +    if (kvm_fd < 0) {
>  >  >>   >>   +        /* vCPU not parked: create a new KVM vCPU */
>  >  >>   >>   +        kvm_fd =3D kvm_vm_ioctl(s, KVM_CREATE_VCPU, vcpu_i=
d);
>  >  >>   >>   +        if (kvm_fd < 0) {
>  >  >>   >>   +            error_report("KVM_CREATE_VCPU IOCTL failed for
vCPU %lu", vcpu_id);
>  >  >>   >>   +            return kvm_fd;
>  >  >>   >>   +        }
>  >  >>   >>   +    }
>  >  >>   >>   +
>  >  >>   >>   +    cpu->kvm_fd =3D kvm_fd;
>  >  >>   >>   +    cpu->kvm_state =3D s;
>  >  >>   >>   +    cpu->vcpu_dirty =3D true;
>  >  >>   >>   +    cpu->dirty_pages =3D 0;
>  >  >>   >>   +    cpu->throttle_us_per_full =3D 0;
>  >  >>   >>   +
>  >  >>   >>   +    return 0;
>  >  >>   >>   +}
>  >  >>   >>   +
>  >  >>   >>    static int do_kvm_destroy_vcpu(CPUState *cpu)  {
>  >  >>   >>        KVMState *s =3D kvm_state;
>  >  >>   >>        long mmap_size;
>  >  >>   >>   -    struct KVMParkedVcpu *vcpu =3D NULL;
>  >  >>   >>        int ret =3D 0;
>  >  >>   >>
>  >  >>   >>   -    trace_kvm_destroy_vcpu();
>  >  >>   >>   +    trace_kvm_destroy_vcpu(cpu->cpu_index,
>  >  >>   kvm_arch_vcpu_id(cpu));
>  >  >>   >>
>  >  >>   >>        ret =3D kvm_arch_destroy_vcpu(cpu);
>  >  >>   >>        if (ret < 0) {
>  >  >>   >>   @@ -373,10 +413,7 @@ static int
do_kvm_destroy_vcpu(CPUState *cpu)
>  >  >>   >>            }
>  >  >>   >>        }
>  >  >>   >>
>  >  >>   >>   -    vcpu =3D g_malloc0(sizeof(*vcpu));
>  >  >>   >>   -    vcpu->vcpu_id =3D kvm_arch_vcpu_id(cpu);
>  >  >>   >>   -    vcpu->kvm_fd =3D cpu->kvm_fd;
>  >  >>   >>   -    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu,
>  >  >>   node);
>  >  >>   >>   +    kvm_park_vcpu(cpu);
>  >  >>   >>    err:
>  >  >>   >>        return ret;
>  >  >>   >>    }
>  >  >>   >>   @@ -397,6 +434,8 @@ static int kvm_get_vcpu(KVMState *s,
>  >  unsigned
>  >  >>   long
>  >  >>   >>   vcpu_id)
>  >  >>   >>            if (cpu->vcpu_id =3D=3D vcpu_id) {
>  >  >>   >>                int kvm_fd;
>  >  >>   >>
>  >  >>   >>   +            trace_kvm_get_vcpu(vcpu_id);
>  >  >>   >>   +
>  >  >>   >>                QLIST_REMOVE(cpu, node);
>  >  >>   >>                kvm_fd =3D cpu->kvm_fd;
>  >  >>   >>                g_free(cpu);
>  >  >>   >>   @@ -404,7 +443,7 @@ static int kvm_get_vcpu(KVMState *s,
>  >  unsigned
>  >  >>   long
>  >  >>   >>   vcpu_id)
>  >  >>   >>            }
>  >  >>   >>        }
>  >  >>   >>
>  >  >>   >>   -    return kvm_vm_ioctl(s, KVM_CREATE_VCPU, (void
>  *)vcpu_id);
>  >  >>   >>   +    return -ENOENT;
>  >  >>   >>    }
>  >  >>   >>
>  >  >>   >>    int kvm_init_vcpu(CPUState *cpu, Error **errp) @@ -415,19
>  >  +454,14
>  >  >>   @@
>  >  >>   >>   int kvm_init_vcpu(CPUState *cpu, Error **errp)
>  >  >>   >>
>  >  >>   >>        trace_kvm_init_vcpu(cpu->cpu_index,
>  kvm_arch_vcpu_id(cpu));
>  >  >>   >>
>  >  >>   >>   -    ret =3D kvm_get_vcpu(s, kvm_arch_vcpu_id(cpu));
>  >  >>   >>   +    ret =3D kvm_create_vcpu(cpu);
>  >  >>   >>        if (ret < 0) {
>  >  >>   >>   -        error_setg_errno(errp, -ret, "kvm_init_vcpu:
kvm_get_vcpu
>  >  failed
>  >  >>   >>   (%lu)",
>  >  >>   >>   +        error_setg_errno(errp, -ret,
>  >  >>   >>   +                         "kvm_init_vcpu: kvm_create_vcpu
failed (%lu)",
>  >  >>   >>                             kvm_arch_vcpu_id(cpu));
>  >  >>   >>            goto err;
>  >  >>   >>        }
>  >  >>   >>
>  >  >>   >>   -    cpu->kvm_fd =3D ret;
>  >  >>   >>   -    cpu->kvm_state =3D s;
>  >  >>   >>   -    cpu->vcpu_dirty =3D true;
>  >  >>   >>   -    cpu->dirty_pages =3D 0;
>  >  >>   >>   -    cpu->throttle_us_per_full =3D 0;
>  >  >>   >>   -
>  >  >>   >>        mmap_size =3D kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);
>  >  >>   >>        if (mmap_size < 0) {
>  >  >>   >>            ret =3D mmap_size;
>  >  >>   >>   diff --git a/accel/kvm/trace-events b/accel/kvm/trace-event=
s
>  index
>  >  >>   >>   681ccb667d..75c1724e78 100644
>  >  >>   >>   --- a/accel/kvm/trace-events
>  >  >>   >>   +++ b/accel/kvm/trace-events
>  >  >>   >>   @@ -9,6 +9,10 @@ kvm_device_ioctl(int fd, int type, void
*arg)
>  >  "dev fd
>  >  >>   %d,
>  >  >>   >>   type 0x%x, arg %p"
>  >  >>   >>    kvm_failed_reg_get(uint64_t id, const char *msg) "Warning:
>  >  Unable to
>  >  >>   >>   retrieve ONEREG %" PRIu64 " from KVM: %s"
>  >  >>   >>    kvm_failed_reg_set(uint64_t id, const char *msg) "Warning:
>  >  Unable to
>  >  >>   set
>  >  >>   >>   ONEREG %" PRIu64 " to KVM: %s"
>  >  >>   >>    kvm_init_vcpu(int cpu_index, unsigned long arch_cpu_id)
>  "index:
>  >  %d
>  >  >>   id:
>  >  >>   >>   %lu"
>  >  >>   >>   +kvm_create_vcpu(int cpu_index, unsigned long arch_cpu_id)
>  >  "index:
>  >  >>   %d
>  >  >>   >>   id: %lu"
>  >  >>   >>   +kvm_get_vcpu(unsigned long arch_cpu_id) "id: %lu"
>  >  >>   >>   +kvm_destroy_vcpu(int cpu_index, unsigned long arch_cpu_id)
>  >  "index:
>  >  >>   %d
>  >  >>   >>   id: %lu"
>  >  >>   >>   +kvm_park_vcpu(int cpu_index, unsigned long arch_cpu_id)
>  >  "index: %d
>  >  >>   id:
>  >  >>   >>   %lu"
>  >  >>   >>    kvm_irqchip_commit_routes(void) ""
>  >  >>   >>    kvm_irqchip_add_msi_route(char *name, int vector, int
virq) "dev
>  >  %s
>  >  >>   >>   vector %d virq %d"
>  >  >>   >>    kvm_irqchip_update_msi_route(int virq) "Updating MSI route
>  >  >>   virq=3D%d"
>  >  >>   >>   @@ -25,7 +29,6 @@ kvm_dirty_ring_reaper(const char *s) "%s"
>  >  >>   >>    kvm_dirty_ring_reap(uint64_t count, int64_t t)
"reaped %"PRIu64"
>  >  >>   pages
>  >  >>   >>   (took %"PRIi64" us)"
>  >  >>   >>    kvm_dirty_ring_reaper_kick(const char *reason) "%s"
>  >  >>   >>    kvm_dirty_ring_flush(int finished) "%d"
>  >  >>   >>   -kvm_destroy_vcpu(void) ""
>  >  >>   >>    kvm_failed_get_vcpu_mmap_size(void) ""
>  >  >>   >>    kvm_cpu_exec(void) ""
>  >  >>   >>    kvm_interrupt_exit_request(void) ""
>  >  >>   >>   --
>  >  >>   >>   2.39.3
>  >  >>   >

--0000000000006eaf5f061892eb0a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">[+] Adding this email address to the conv=
ersation.=C2=A0<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gma=
il_attr"><br></div><div dir=3D"ltr" class=3D"gmail_attr">(sorry for the noi=
se)<br></div><div dir=3D"ltr" class=3D"gmail_attr"><br></div>
&gt;=C2=A0 From: Salil Mehta<br>
&gt;=C2=A0 Sent: Thursday, May 16, 2024 2:36 PM<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 &gt;=C2=A0 From: Harsh Prateek Bora &lt;<a href=3D"mailto:harshp=
b@linux.ibm.com" target=3D"_blank">harshpb@linux.ibm.com</a>&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 Sent: Thursday, May 16, 2024 2:07 PM<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 Hi Salil,<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 On 5/16/24 17:42, Salil Mehta wrote:<br>
&gt;=C2=A0 &gt;=C2=A0 &gt; Hi Harsh,<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0From: Harsh Prateek Bora &lt;<a =
href=3D"mailto:harshpb@linux.ibm.com" target=3D"_blank">harshpb@linux.ibm.c=
om</a>&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0Sent: Thursday, May 16, 2024 11:=
15 AM<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0Hi Salil,<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0Thanks for your email.<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0Your patch 1/8 is included here =
based on review comments on my previous<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0patch from one of the maintainer=
s in the community and therefore I had<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0kept you in CC to be aware of th=
e desire of having this independent patch to<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0get merged earlier even if your =
other patches in the series may go through<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0further reviews.<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt; I really don=E2=80=99t know which discussion you=
 are pointing at? Please<br>
&gt;=C2=A0 &gt; &gt; understand you are fixing a bug and we are pushing a f=
eature which has got large series.<br>
&gt;=C2=A0 &gt;=C2=A0 &gt; It will break the patch-set=C2=A0 which is about=
 to be merged.<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt; There will be significant overhead of testing on=
 us for the work we<br>
&gt;=C2=A0 &gt; &gt; have been carrying forward for large time. This will b=
e disruptive. Please dont!<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 I was referring to the review discussion on my prev p=
atch here:<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; <a href=3D"https://lore.kernel.org/qemu-devel/D191D2JFAR7L.=
2EH4S445M4TGK@gmail.com/" rel=3D"noreferrer" target=3D"_blank">https://lore=
.kernel.org/qemu-devel/D191D2JFAR7L.2EH4S445M4TGK@gmail.com/</a><br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt;=C2=A0 Ok, I&#39;m, not sure what this means.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt;=C2=A0 &gt;=C2=A0 Although your patch was included with this series onl=
y to facilitate<br>
&gt;=C2=A0 &gt; review of=C2=A0 the additional patches depending on just on=
e of your patch.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt;=C2=A0 Generally you rebase your patch-set over the other and clearly s=
tate on the<br>
&gt;=C2=A0 cover letter that this patch-set is dependent upon such and such=
 patch-set.<br>
&gt;=C2=A0 Just imagine if everyone starts to unilaterally pick up patches =
from each<br>
&gt;=C2=A0 other&#39;s patch-set it will create a chaos not only for the fe=
ature owners but<br>
&gt;=C2=A0 also for the maintainers.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 I am not sure what is appearing disruptive here. It i=
s a common<br>
&gt;=C2=A0 &gt; practive in=C2=A0 the community that maintainer(s) can pick=
 individual<br>
&gt;=C2=A0 &gt; patches from the=C2=A0 series if it has been vetted by sigi=
nificant number of reviewers.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt;=C2=A0 Don=E2=80=99t you think this patch-set is asking for acceptance =
for a patch already<br>
&gt;=C2=A0 part of another patch-set which is about to be accepted and is a=
 bigger<br>
&gt;=C2=A0 feature?=C2=A0Will it cause maintenance overhead at the last mom=
ent? Yes, of course!<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt;=C2=A0 &gt;=C2=A0 However, in this case, since you have mentioned to po=
st next version soon,<br>
&gt;=C2=A0 &gt;=C2=A0 you need not worry about it as that would be the pref=
erred version for both<br>
&gt;=C2=A0 &gt;=C2=A0 of the series.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt;=C2=A0 Yes, but please understand we are working for the benefit of ove=
rall<br>
&gt;=C2=A0 community. Please cooperate here.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0I am hoping to see your v9 soon =
and thereafter maintainer(s) may choose to<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0pick the latest independent patc=
h if needs to be merged earlier.<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt; I don=E2=80=99t think you are understanding what=
 problem it is causing. For<br>
&gt;=C2=A0 &gt;=C2=A0 &gt; your small bug fix you are causing significant d=
elays at our end.<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 I hope I clarfied above that including your patch her=
e doesnt delay anything.<br>
&gt;=C2=A0 &gt;=C2=A0 Hoping to see your v9 soon!<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 Thanks<br>
&gt;=C2=A0 &gt;=C2=A0 Harsh<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt; Thanks<br>
&gt;=C2=A0 &gt;=C2=A0 &gt; Salil.<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0Thanks for your work and let&#39=
;s be hopeful it gets merged soon.<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0regards,<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0Harsh<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0On 5/16/24 14:00, Salil Mehta wr=
ote:<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt; Hi Harsh,<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt; Thanks for your interest in=
 the patch-set but taking away patches like<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt; this from other series with=
out any discussion can disrupt others work<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt; and its acceptance on time.=
 This is because we will have to put lot of<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt; effort in rebasing bigger s=
eries and then testing overhead comes along<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt; with it.<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt; The patch-set (from where t=
his=C2=A0 patch has been taken) is part of even<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt; bigger series and there hav=
e been many people and companies toiling to<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt; fix the bugs collectively i=
n that series and for years.<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt; I&#39;m about float the V9 =
version of the Arch agnostic series which this<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt; patch is part of and you ca=
n rebase your patch-set from there. I&#39;m<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt; hopeful that it will get ac=
cepted in this cycle.<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt; Many thanks<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt; Salil.<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0From: Harsh=
 Prateek Bora &lt;<a href=3D"mailto:harshpb@linux.ibm.com" target=3D"_blank=
">harshpb@linux.ibm.com</a>&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0Sent: Thurs=
day, May 16, 2024 6:32 AM<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0From: Salil=
 Mehta &lt;<a href=3D"mailto:salil.mehta@huawei.com" target=3D"_blank">sali=
l.mehta@huawei.com</a>&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0KVM vCPU cr=
eation is done once during the vCPU realization when=C2=A0Qemu<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0vCPU thread=
 is spawned. This is common to all the architectures as of=C2=A0now.<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0Hot-unplug =
of vCPU results in destruction of the vCPU object in QOM=C2=A0but<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0the corresp=
onding KVM vCPU object in the Host KVM is not destroyed=C2=A0as<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0KVM doesn&#=
39;t support vCPU removal. Therefore, its representative KVM<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0vCPU object=
/context in Qemu is parked.<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0Refactor ar=
chitecture common logic so that some APIs could be reused by<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0vCPU Hotplu=
g code of some architectures likes ARM, Loongson etc. Update<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0new/old API=
s with trace events instead of DPRINTF. No functional change is<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0intended he=
re.<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0Signed-off-=
by: Salil Mehta &lt;<a href=3D"mailto:salil.mehta@huawei.com" target=3D"_bl=
ank">salil.mehta@huawei.com</a>&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0Reviewed-by=
: Gavin Shan &lt;<a href=3D"mailto:gshan@redhat.com" target=3D"_blank">gsha=
n@redhat.com</a>&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0Tested-by: =
Vishnu Pajjuri &lt;<a href=3D"mailto:vishnu@os.amperecomputing.com" target=
=3D"_blank">vishnu@os.amperecomputing.com</a>&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0Reviewed-by=
: Jonathan Cameron &lt;<a href=3D"mailto:Jonathan.Cameron@huawei.com" targe=
t=3D"_blank">Jonathan.Cameron@huawei.com</a>&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0Tested-by: =
Xianglai Li &lt;<a href=3D"mailto:lixianglai@loongson.cn" target=3D"_blank"=
>lixianglai@loongson.cn</a>&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0Tested-by: =
Miguel Luis &lt;<a href=3D"mailto:miguel.luis@oracle.com" target=3D"_blank"=
>miguel.luis@oracle.com</a>&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0Reviewed-by=
: Shaoqin Huang &lt;<a href=3D"mailto:shahuang@redhat.com" target=3D"_blank=
">shahuang@redhat.com</a>&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0[harshpb: f=
ixed rebase failures in include/sysemu/kvm.h]<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0Signed-off-=
by: Harsh Prateek Bora &lt;<a href=3D"mailto:harshpb@linux.ibm.com" target=
=3D"_blank">harshpb@linux.ibm.com</a>&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0---<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 include/sy=
semu/kvm.h=C2=A0 =C2=A0| 15 ++++++++++<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 accel/kvm/=
kvm-all.c=C2=A0 =C2=A0 | 64<br>
&gt;=C2=A0 &gt;=C2=A0 ++++++++++++++++++++++++++++++++---<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0-----<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0--<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 accel/kvm/=
trace-events |=C2=A0 5 +++-<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 3 files ch=
anged, 68 insertions(+), 16 deletions(-)<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0diff --git =
a/include/sysemu/kvm.h b/include/sysemu/kvm.h<br>
&gt;=C2=A0 index<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0eaf801bc93.=
.fa3ec74442 100644<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0--- a/inclu=
de/sysemu/kvm.h<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+++ b/inclu=
de/sysemu/kvm.h<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0@@ -434,6 +=
434,21 @@ void kvm_set_sigmask_len(KVMState *s,<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0unsigned<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0int sigmask=
_len);<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 int kvm_ph=
ysical_memory_addr_from_host(KVMState *s, void<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0*ram_addr,<=
br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hwaddr *phys_addr);<=
br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+/**<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+ * kvm_cre=
ate_vcpu - Gets a parked KVM vCPU or creates a KVM<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0vCPU<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+ * @cpu: Q=
OM CPUState object for which KVM vCPU has to be<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0fetched/cre=
ated.<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+ *<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+ * @return=
s: 0 when success, errno (&lt;0) when failed.<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+ */<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+int kvm_cr=
eate_vcpu(CPUState *cpu);<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+/**<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+ * kvm_par=
k_vcpu - Park QEMU KVM vCPU context<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+ * @cpu: Q=
OM CPUState object for which QEMU KVM vCPU context has to<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0be parked.<=
br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+ *<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+ * @return=
s: none<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+ */<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+void kvm_p=
ark_vcpu(CPUState *cpu);<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 #endif /* =
COMPILING_PER_TARGET */<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0diff --git =
a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c index<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0d7281b93f3.=
.30d42847de 100644<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0--- a/accel=
/kvm/kvm-all.c<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+++ b/accel=
/kvm/kvm-all.c<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0@@ -128,6 +=
128,7 @@ static QemuMutex kml_slots_lock; <br>
&gt;=C2=A0 #define<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0kvm_slots_u=
nlock()=C2=A0 qemu_mutex_unlock(&amp;kml_slots_lock)<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 static voi=
d kvm_slot_init_dirty_bitmap(KVMSlot *mem);<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+static int=
 kvm_get_vcpu(KVMState *s, unsigned long vcpu_id);<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 static inl=
ine void kvm_resample_fd_remove(int gsi)=C2=A0 { @@ -<br>
&gt;=C2=A0 340,14<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0+341,53<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0@@ err:<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return ret;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+void kvm_p=
ark_vcpu(CPUState *cpu)<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+{<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+=C2=A0 =C2=
=A0 struct KVMParkedVcpu *vcpu;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+=C2=A0 =C2=
=A0 trace_kvm_park_vcpu(cpu-&gt;cpu_index, kvm_arch_vcpu_id(cpu));<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+=C2=A0 =C2=
=A0 vcpu =3D g_malloc0(sizeof(*vcpu));<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+=C2=A0 =C2=
=A0 vcpu-&gt;vcpu_id =3D kvm_arch_vcpu_id(cpu);<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+=C2=A0 =C2=
=A0 vcpu-&gt;kvm_fd =3D cpu-&gt;kvm_fd;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+=C2=A0 =C2=
=A0 QLIST_INSERT_HEAD(&amp;kvm_state-&gt;kvm_parked_vcpus, vcpu, node); }<b=
r>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+int kvm_cr=
eate_vcpu(CPUState *cpu)<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+{<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+=C2=A0 =C2=
=A0 unsigned long vcpu_id =3D kvm_arch_vcpu_id(cpu);<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+=C2=A0 =C2=
=A0 KVMState *s =3D kvm_state;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+=C2=A0 =C2=
=A0 int kvm_fd;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+=C2=A0 =C2=
=A0 trace_kvm_create_vcpu(cpu-&gt;cpu_index, kvm_arch_vcpu_id(cpu));<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+=C2=A0 =C2=
=A0 /* check if the KVM vCPU already exist but is parked */<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+=C2=A0 =C2=
=A0 kvm_fd =3D kvm_get_vcpu(s, vcpu_id);<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+=C2=A0 =C2=
=A0 if (kvm_fd &lt; 0) {<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 /* vCPU not parked: create a new KVM vCPU */<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 kvm_fd =3D kvm_vm_ioctl(s, KVM_CREATE_VCPU, vcpu_id);<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 if (kvm_fd &lt; 0) {<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;KVM_CREATE_VCPU IOCTL fa=
iled for vCPU %lu&quot;, vcpu_id);<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return kvm_fd;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+=C2=A0 =C2=
=A0 }<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+=C2=A0 =C2=
=A0 cpu-&gt;kvm_fd =3D kvm_fd;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+=C2=A0 =C2=
=A0 cpu-&gt;kvm_state =3D s;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+=C2=A0 =C2=
=A0 cpu-&gt;vcpu_dirty =3D true;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+=C2=A0 =C2=
=A0 cpu-&gt;dirty_pages =3D 0;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+=C2=A0 =C2=
=A0 cpu-&gt;throttle_us_per_full =3D 0;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+=C2=A0 =C2=
=A0 return 0;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+}<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 static int=
 do_kvm_destroy_vcpu(CPUState *cpu)=C2=A0 {<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 KVMState *s =3D kvm_state;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 long mmap_size;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0-=C2=A0 =C2=
=A0 struct KVMParkedVcpu *vcpu =3D NULL;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 int ret =3D 0;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0-=C2=A0 =C2=
=A0 trace_kvm_destroy_vcpu();<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+=C2=A0 =C2=
=A0 trace_kvm_destroy_vcpu(cpu-&gt;cpu_index,<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0kvm_arch_vcpu_id(cpu));<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ret =3D kvm_arch_destroy_vcpu(cpu);<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (ret &lt; 0) {<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0@@ -373,10 =
+413,7 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0-=C2=A0 =C2=
=A0 vcpu =3D g_malloc0(sizeof(*vcpu));<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0-=C2=A0 =C2=
=A0 vcpu-&gt;vcpu_id =3D kvm_arch_vcpu_id(cpu);<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0-=C2=A0 =C2=
=A0 vcpu-&gt;kvm_fd =3D cpu-&gt;kvm_fd;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0-=C2=A0 =C2=
=A0 QLIST_INSERT_HEAD(&amp;kvm_state-&gt;kvm_parked_vcpus, vcpu,<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0node);<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+=C2=A0 =C2=
=A0 kvm_park_vcpu(cpu);<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 err:<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return ret;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0@@ -397,6 +=
434,8 @@ static int kvm_get_vcpu(KVMState *s,<br>
&gt;=C2=A0 &gt;=C2=A0 unsigned<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0long<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0vcpu_id)<br=
>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 if (cpu-&gt;vcpu_id =3D=3D vcpu_id) {<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int kvm_fd;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_kvm_get_vcpu(vcpu_id);<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QLIST_REMOVE(cpu, node);<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kvm_fd =3D cpu-&gt;kvm_fd;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(cpu);<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0@@ -404,7 +=
443,7 @@ static int kvm_get_vcpu(KVMState *s,<br>
&gt;=C2=A0 &gt;=C2=A0 unsigned<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0long<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0vcpu_id)<br=
>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0-=C2=A0 =C2=
=A0 return kvm_vm_ioctl(s, KVM_CREATE_VCPU, (void<br>
&gt;=C2=A0 *)vcpu_id);<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+=C2=A0 =C2=
=A0 return -ENOENT;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 int kvm_in=
it_vcpu(CPUState *cpu, Error **errp) @@ -415,19<br>
&gt;=C2=A0 &gt;=C2=A0 +454,14<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0@@<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0int kvm_ini=
t_vcpu(CPUState *cpu, Error **errp)<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 trace_kvm_init_vcpu(cpu-&gt;cpu_index,<br>
&gt;=C2=A0 kvm_arch_vcpu_id(cpu));<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0-=C2=A0 =C2=
=A0 ret =3D kvm_get_vcpu(s, kvm_arch_vcpu_id(cpu));<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+=C2=A0 =C2=
=A0 ret =3D kvm_create_vcpu(cpu);<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (ret &lt; 0) {<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0-=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 error_setg_errno(errp, -ret, &quot;kvm_init_vcpu: kvm_get=
_vcpu<br>
&gt;=C2=A0 &gt;=C2=A0 failed<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0(%lu)&quot;=
,<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 error_setg_errno(errp, -ret,<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&quot;kvm_init_vcpu: kvm_create_vcpu failed (%lu)&quot;,<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0kvm_arch_vcpu_id(cpu));<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 goto err;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0-=C2=A0 =C2=
=A0 cpu-&gt;kvm_fd =3D ret;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0-=C2=A0 =C2=
=A0 cpu-&gt;kvm_state =3D s;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0-=C2=A0 =C2=
=A0 cpu-&gt;vcpu_dirty =3D true;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0-=C2=A0 =C2=
=A0 cpu-&gt;dirty_pages =3D 0;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0-=C2=A0 =C2=
=A0 cpu-&gt;throttle_us_per_full =3D 0;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0-<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mmap_size =3D kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (mmap_size &lt; 0) {<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ret =3D mmap_size;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0diff --git =
a/accel/kvm/trace-events b/accel/kvm/trace-events<br>
&gt;=C2=A0 index<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0681ccb667d.=
.75c1724e78 100644<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0--- a/accel=
/kvm/trace-events<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+++ b/accel=
/kvm/trace-events<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0@@ -9,6 +9,=
10 @@ kvm_device_ioctl(int fd, int type, void *arg)<br>
&gt;=C2=A0 &gt;=C2=A0 &quot;dev fd<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0%d,<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0type 0x%x, =
arg %p&quot;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 kvm_failed=
_reg_get(uint64_t id, const char *msg) &quot;Warning:<br>
&gt;=C2=A0 &gt;=C2=A0 Unable to<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0retrieve ON=
EREG %&quot; PRIu64 &quot; from KVM: %s&quot;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 kvm_failed=
_reg_set(uint64_t id, const char *msg) &quot;Warning:<br>
&gt;=C2=A0 &gt;=C2=A0 Unable to<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0set<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0ONEREG %&qu=
ot; PRIu64 &quot; to KVM: %s&quot;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 kvm_init_v=
cpu(int cpu_index, unsigned long arch_cpu_id)<br>
&gt;=C2=A0 &quot;index:<br>
&gt;=C2=A0 &gt;=C2=A0 %d<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0id:<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0%lu&quot;<b=
r>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+kvm_create=
_vcpu(int cpu_index, unsigned long arch_cpu_id)<br>
&gt;=C2=A0 &gt;=C2=A0 &quot;index:<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0%d<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0id: %lu&quo=
t;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+kvm_get_vc=
pu(unsigned long arch_cpu_id) &quot;id: %lu&quot;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+kvm_destro=
y_vcpu(int cpu_index, unsigned long arch_cpu_id)<br>
&gt;=C2=A0 &gt;=C2=A0 &quot;index:<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0%d<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0id: %lu&quo=
t;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0+kvm_park_v=
cpu(int cpu_index, unsigned long arch_cpu_id)<br>
&gt;=C2=A0 &gt;=C2=A0 &quot;index: %d<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0id:<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0%lu&quot;<b=
r>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 kvm_irqchi=
p_commit_routes(void) &quot;&quot;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 kvm_irqchi=
p_add_msi_route(char *name, int vector, int virq)=C2=A0&quot;dev<br>
&gt;=C2=A0 &gt;=C2=A0 %s<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0vector %d v=
irq %d&quot;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 kvm_irqchi=
p_update_msi_route(int virq) &quot;Updating MSI route<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0virq=3D%d&quot;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0@@ -25,7 +2=
9,6 @@ kvm_dirty_ring_reaper(const char *s) &quot;%s&quot;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 kvm_dirty_=
ring_reap(uint64_t count, int64_t t) &quot;reaped=C2=A0%&quot;PRIu64&quot;<=
br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0pages<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0(took %&quo=
t;PRIi64&quot; us)&quot;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 kvm_dirty_=
ring_reaper_kick(const char *reason) &quot;%s&quot;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 kvm_dirty_=
ring_flush(int finished) &quot;%d&quot;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0-kvm_destro=
y_vcpu(void) &quot;&quot;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 kvm_failed=
_get_vcpu_mmap_size(void) &quot;&quot;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 kvm_cpu_ex=
ec(void) &quot;&quot;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 kvm_interr=
upt_exit_request(void) &quot;&quot;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0--<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A02.39.3<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;&gt;=C2=A0 =C2=A0&gt;<br>
</div></div></div>

--0000000000006eaf5f061892eb0a--

