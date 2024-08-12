Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2CFC52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 09:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdRjx-0006Ob-9O; Mon, 12 Aug 2024 05:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sdRju-0006JZ-N2
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 05:53:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sdRjs-0006vX-HI
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 05:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723456399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DaNd/0SeJ2+vXikjwkP3r5pLGCe1rmKQoREGvBy59qk=;
 b=EVBwVeJjlQMAmrwa6/Cjyj/wql7FcmTZ5Q+TH43fu9rEea2v1plBSFk1nKMNh55o6AAOHs
 HnVW+96/6Dl+nYZQH8T7XUlMU/X//wCTu7xyq/Fc8ZKdBFoFcF7AXVBu1hHTrvq8IjquL3
 CT+8YDGm1KyHEQ9wgoS5rG1s3j3QN3k=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-SNy2P2yLOgeWNJqefVhcMg-1; Mon, 12 Aug 2024 05:53:17 -0400
X-MC-Unique: SNy2P2yLOgeWNJqefVhcMg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a7df415590cso674796166b.1
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 02:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723456396; x=1724061196;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DaNd/0SeJ2+vXikjwkP3r5pLGCe1rmKQoREGvBy59qk=;
 b=XJxFPVUgUFDYZwoO2nT44eejYS9Y7KZirM+pNLEGN7Ywx2eoOg/M8szDcfAbWFP2G3
 c2eZSDkPepa+ids/rVVZrrfANeJdkhU+Yy3KHo7i+f9kVuQosNpc508Cm7/1Ftz3UtlA
 I+7nSgrsIeq8HeAtx1ayNa6TZawSuLp4x4f1OXdO0q7/KvlyDOVhOwW6y/94irhCs0zH
 1IowlB5haqQtj/No7G69hpWapAQlvaPzxjK7ELp64nj+eq9nzAWWx/NkJEGJ6JrRpgoE
 /7fiuw06T5fIT/BurjJj6pt/dR83XQNP++KD9vZfNCdNvfnZVsC8TA/d6yLksOW9z0ye
 HCDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOLFncH2KV4AcxegAMjaleuTgZLOLbZuxghKmz6CNJfWcp+lTxzzDMEDiLsp6NwaJYdK8Dlr10pqTNOnNbLuvmC1sy07Q=
X-Gm-Message-State: AOJu0YyodaF6hpAAC8KN0sIZEq8NI3tbfTAxu/GaN1XgrB7vwf+F2nJs
 asPUVTpRfZY2AslDbPF6XYrA9do5/eD+hX3LbDQVvXhqIegsCslt+Z0cGf9/DasgRigAyDVZt3C
 FRzc3ZtA2vOseYyCjowfIIaitUxe6HTLttr7NRcU7tyacv0inSdQtyhxRphdm9dNhRdDdYU/rWq
 ZVM6ewhU4xJegwyeTjtSXBMupPkug=
X-Received: by 2002:a17:907:dac:b0:a7a:bcbc:f7f4 with SMTP id
 a640c23a62f3a-a80ab795802mr667106566b.14.1723456396349; 
 Mon, 12 Aug 2024 02:53:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTpvWhvzJKJINItgkEHZvMCgHN2cqJ5ObqV2x/QDvdU+IVRKhPZr+44cYlBD1rk5d7utrzPNmjj/9yTQ7l2g8=
X-Received: by 2002:a17:907:dac:b0:a7a:bcbc:f7f4 with SMTP id
 a640c23a62f3a-a80ab795802mr667105066b.14.1723456395764; Mon, 12 Aug 2024
 02:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240809064940.1788169-1-anisinha@redhat.com>
 <8913b8c7-4103-4f69-8567-afdc29f8d0d3@linaro.org>
In-Reply-To: <8913b8c7-4103-4f69-8567-afdc29f8d0d3@linaro.org>
From: Ani Sinha <anisinha@redhat.com>
Date: Mon, 12 Aug 2024 15:23:04 +0530
Message-ID: <CAK3XEhM+SR39vYxG_ygQ=hCj_bmDE3dOH6EPFQZbLYrE-Yj-ow@mail.gmail.com>
Subject: Re: [PATCH v3] kvm: replace fprintf with error_report/printf() in
 kvm_init()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org,
 zhao1.liu@intel.com, kvm@vger.kernel.org, qemu-devel@nongnu.org, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, Aug 9, 2024 at 2:06=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> Hi Ani,
>
> On 9/8/24 08:49, Ani Sinha wrote:
> > error_report() is more appropriate for error situations. Replace fprint=
f with
> > error_report. Cosmetic. No functional change.
> >
> > CC: qemu-trivial@nongnu.org
> > CC: zhao1.liu@intel.com
>
> (Pointless to carry Cc line when patch is already reviewed next line)
>
> > Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > ---
> >   accel/kvm/kvm-all.c | 40 ++++++++++++++++++----------------------
> >   1 file changed, 18 insertions(+), 22 deletions(-)
> >
> > changelog:
> > v2: fix a bug.
> > v3: replace one instance of error_report() with error_printf(). added t=
ags.
> >
> > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > index 75d11a07b2..5bc9d35b61 100644
> > --- a/accel/kvm/kvm-all.c
> > +++ b/accel/kvm/kvm-all.c
> > @@ -2427,7 +2427,7 @@ static int kvm_init(MachineState *ms)
> >       QLIST_INIT(&s->kvm_parked_vcpus);
> >       s->fd =3D qemu_open_old(s->device ?: "/dev/kvm", O_RDWR);
> >       if (s->fd =3D=3D -1) {
> > -        fprintf(stderr, "Could not access KVM kernel module: %m\n");
> > +        error_report("Could not access KVM kernel module: %m");
> >           ret =3D -errno;
> >           goto err;
> >       }
> > @@ -2437,13 +2437,13 @@ static int kvm_init(MachineState *ms)
> >           if (ret >=3D 0) {
> >               ret =3D -EINVAL;
> >           }
> > -        fprintf(stderr, "kvm version too old\n");
> > +        error_report("kvm version too old");
> >           goto err;
> >       }
> >
> >       if (ret > KVM_API_VERSION) {
> >           ret =3D -EINVAL;
> > -        fprintf(stderr, "kvm version not supported\n");
> > +        error_report("kvm version not supported");
> >           goto err;
> >       }
> >
> > @@ -2488,26 +2488,22 @@ static int kvm_init(MachineState *ms)
> >       } while (ret =3D=3D -EINTR);
> >
> >       if (ret < 0) {
> > -        fprintf(stderr, "ioctl(KVM_CREATE_VM) failed: %d %s\n", -ret,
> > -                strerror(-ret));
> > +        error_report("ioctl(KVM_CREATE_VM) failed: %d %s", -ret,
> > +                    strerror(-ret));
> >
> >   #ifdef TARGET_S390X
> >           if (ret =3D=3D -EINVAL) {
> > -            fprintf(stderr,
> > -                    "Host kernel setup problem detected. Please verify=
:\n");
> > -            fprintf(stderr, "- for kernels supporting the switch_amode=
 or"
> > -                    " user_mode parameters, whether\n");
> > -            fprintf(stderr,
> > -                    "  user space is running in primary address space\=
n");
> > -            fprintf(stderr,
> > -                    "- for kernels supporting the vm.allocate_pgste sy=
sctl, "
> > -                    "whether it is enabled\n");
> > +            error_report("Host kernel setup problem detected.
>
> \n"
>
> Should we use error_printf_unless_qmp() for the following?

Do you believe that qemu_init() -> configure_accelerators() ->
do_configure_accelerator,() -> accel_init_machine() -> kvm_init()  can
be called from QMP context?

>
> " Please verify:");
> > +            error_report("- for kernels supporting the switch_amode or=
"
> > +                        " user_mode parameters, whether");
> > +            error_report("  user space is running in primary address s=
pace");
> > +            error_report("- for kernels supporting the vm.allocate_pgs=
te "
> > +                        "sysctl, whether it is enabled");
> >           }
> >   #elif defined(TARGET_PPC)
> >           if (ret =3D=3D -EINVAL) {
> > -            fprintf(stderr,
> > -                    "PPC KVM module is not loaded.
>
> \n"
>
> Ditto.
>
> " Try modprobe kvm_%s.\n",
> > -                    (type =3D=3D 2) ? "pr" : "hv");
> > +            error_report("PPC KVM module is not loaded. Try modprobe k=
vm_%s.",
> > +                        (type =3D=3D 2) ? "pr" : "hv");
> >           }
> >   #endif
> >           goto err;
> > @@ -2526,9 +2522,9 @@ static int kvm_init(MachineState *ms)
> >                           nc->name, nc->num, soft_vcpus_limit);
> >
> >               if (nc->num > hard_vcpus_limit) {
> > -                fprintf(stderr, "Number of %s cpus requested (%d) exce=
eds "
> > -                        "the maximum cpus supported by KVM (%d)\n",
> > -                        nc->name, nc->num, hard_vcpus_limit);
> > +                error_report("Number of %s cpus requested (%d) exceeds=
 "
> > +                             "the maximum cpus supported by KVM (%d)",
> > +                             nc->name, nc->num, hard_vcpus_limit);
> >                   exit(1);
> >               }
> >           }
> > @@ -2542,8 +2538,8 @@ static int kvm_init(MachineState *ms)
> >       }
> >       if (missing_cap) {
> >           ret =3D -EINVAL;
> > -        fprintf(stderr, "kvm does not support %s\n%s",
> > -                missing_cap->name, upgrade_note);
> > +        error_printf("kvm does not support %s\n%s",
> > +                     missing_cap->name, upgrade_note);
>
> Similarly, should we print upgrade_note using error_printf_unless_qmp?
>
> >           goto err;
> >       }
> >
>


