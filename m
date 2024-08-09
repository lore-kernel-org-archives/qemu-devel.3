Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A99C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 05:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scHn7-00051j-0i; Fri, 09 Aug 2024 01:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1scHmw-00050d-4H
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 01:03:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1scHmu-0001pp-Kl
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 01:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723179819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nFm7hX11ewPim1wI/XILslO8UkfCpMWJ2klA+0ZXIsQ=;
 b=N+f3tcMFREGFdHipvcJDOcb2w8kujWRzHqBjV0tpvX6lE6EjiYMRtnshJYx+V/aORWwxNR
 6zjyssAH+z5bWZNT4a6Zn7uobPKdzzVI0n2hi+GjxwYSyNx8gY+BEANhYwS/42ga7g39ZB
 8hijDoBXlhUhgqPIFdPi319SMcReodw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-ExD1gcChPs270HJf_93krA-1; Fri, 09 Aug 2024 01:03:36 -0400
X-MC-Unique: ExD1gcChPs270HJf_93krA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5a2d4fb1e73so1516067a12.2
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 22:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723179815; x=1723784615;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nFm7hX11ewPim1wI/XILslO8UkfCpMWJ2klA+0ZXIsQ=;
 b=YM5M0Nxdb5+GKMqSJlCPih2Nsm9WOacrKJxGkFCcgEBfpRbfyKMySUe4hv9sonRVpH
 /z/M7bOgIle6yxSHwg2BKIPCsd9481cyZq6hF/yCT8ddVFI+M4V7NiCXAftpg0IW/7Nv
 DGB7ABvmDpN+gg0t0/ds4l3GiySeFjGE7sNkvVmGnAYZrlpx5uI+HwDXavXxEP93hw6R
 x0tfo3D1fYQ51Yf0GKdqeMiiUZ9T6Wi+Zx8rQeT7l3Tz7/hNspMVuZV+zjyXyABiA7mj
 ewh5gIlaX4LFh46brM/5kCGdZyt9zDH0ELNa4wfd9u5cjxC87WfAivJ8rjXl9lcG/nZR
 8FhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD2rB85dqONskYqJWNtDFVQhjMdLUwECDAWuWyMdWL47YLmbJ7ccZdfokqV9HAzImjSK7KiVtoMPLZ7EBs0cyP0jBqAf4=
X-Gm-Message-State: AOJu0YwrS/DPyNp8RMPy9LaV3FJljGPSYgA+cFCn4p0NQyZRMYXYxsRC
 x3YaYnIUGHeZ/MMRzZCC5/Y/YSt2byusz+pnVpFuQyqpCqPdvJPasD9oCN5SuRwSOEvQvqrSim8
 vm3ljoQL/NyFDwGk1S6bCaYoLHql7A5uCVvYvhfOQn4PA6NN1EJN0Ewh0T28VIFMc98ygYH9/JY
 JO0Nj4EucrVLKblgrQDx6xKWLOjK0=
X-Received: by 2002:a17:907:2d1e:b0:a7a:b561:3575 with SMTP id
 a640c23a62f3a-a80aa67d153mr25370166b.56.1723179815452; 
 Thu, 08 Aug 2024 22:03:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQzk5UK4neT2CvDN53fBwu1GDTnIFuo3jXYxP/4UJ3b+bRNkgXGG1aJOPCxVX/HvKR/9QRXjpY1BRXq/ttqJ8=
X-Received: by 2002:a17:907:2d1e:b0:a7a:b561:3575 with SMTP id
 a640c23a62f3a-a80aa67d153mr25368966b.56.1723179814864; Thu, 08 Aug 2024
 22:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240809045153.1744397-1-anisinha@redhat.com>
 <20240809045153.1744397-2-anisinha@redhat.com>
In-Reply-To: <20240809045153.1744397-2-anisinha@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Fri, 9 Aug 2024 10:33:23 +0530
Message-ID: <CAK3XEhNvbtJL68cD9pi9i+rMc6a68jpBgyivsj8ZKEaar+trcg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kvm: replace fprintf with error_report() in
 kvm_init() for error conditions
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-trivial@nongnu.org, zhao1.liu@intel.com, kvm@vger.kernel.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

On Fri, Aug 9, 2024 at 10:23=E2=80=AFAM Ani Sinha <anisinha@redhat.com> wro=
te:
>
> error_report() is more appropriate for error situations. Replace fprintf =
with
> error_report. Cosmetic. No functional change.
>
> CC: qemu-trivial@nongnu.org
> CC: zhao1.liu@intel.com
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  accel/kvm/kvm-all.c | 42 +++++++++++++++++++-----------------------
>  1 file changed, 19 insertions(+), 23 deletions(-)
>
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 75d11a07b2..899b5264e3 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2427,7 +2427,7 @@ static int kvm_init(MachineState *ms)
>      QLIST_INIT(&s->kvm_parked_vcpus);
>      s->fd =3D qemu_open_old(s->device ?: "/dev/kvm", O_RDWR);
>      if (s->fd =3D=3D -1) {
> -        fprintf(stderr, "Could not access KVM kernel module: %m\n");
> +        error_report("Could not access KVM kernel module: %m");
>          ret =3D -errno;
>          goto err;
>      }
> @@ -2437,13 +2437,13 @@ static int kvm_init(MachineState *ms)
>          if (ret >=3D 0) {
>              ret =3D -EINVAL;
>          }
> -        fprintf(stderr, "kvm version too old\n");
> +        error_report("kvm version too old");
>          goto err;
>      }
>
>      if (ret > KVM_API_VERSION) {
>          ret =3D -EINVAL;
> -        fprintf(stderr, "kvm version not supported\n");
> +        error_report("kvm version not supported");
>          goto err;
>      }
>
> @@ -2488,30 +2488,26 @@ static int kvm_init(MachineState *ms)
>      } while (ret =3D=3D -EINTR);
>
>      if (ret < 0) {
> -        fprintf(stderr, "ioctl(KVM_CREATE_VM) failed: %d %s\n", -ret,
> -                strerror(-ret));
> +        error_report("ioctl(KVM_CREATE_VM) failed: %d %s", -ret,
> +                    strerror(-ret));
>
>  #ifdef TARGET_S390X
>          if (ret =3D=3D -EINVAL) {
> -            fprintf(stderr,
> -                    "Host kernel setup problem detected. Please verify:\=
n");
> -            fprintf(stderr, "- for kernels supporting the switch_amode o=
r"
> -                    " user_mode parameters, whether\n");
> -            fprintf(stderr,
> -                    "  user space is running in primary address space\n"=
);
> -            fprintf(stderr,
> -                    "- for kernels supporting the vm.allocate_pgste sysc=
tl, "
> -                    "whether it is enabled\n");
> +            error_report("Host kernel setup problem detected. Please ver=
ify:");
> +            error_report("- for kernels supporting the switch_amode or"
> +                        " user_mode parameters, whether");
> +            error_report("  user space is running in primary address spa=
ce");
> +            error_report("- for kernels supporting the vm.allocate_pgste=
 "
> +                        "sysctl, whether it is enabled");
>          }
>  #elif defined(TARGET_PPC)
>          if (ret =3D=3D -EINVAL) {
> -            fprintf(stderr,
> -                    "PPC KVM module is not loaded. Try modprobe kvm_%s.\=
n",
> -                    (type =3D=3D 2) ? "pr" : "hv");
> +            error_report("PPC KVM module is not loaded. Try modprobe kvm=
_%s.",
> +                        (type =3D=3D 2) ? "pr" : "hv");
>          }
>  #endif
> -        goto err;
>      }
> +        goto err;

Sorry, this is a bug. I will resend.

>
>      s->vmfd =3D ret;
>
> @@ -2526,9 +2522,9 @@ static int kvm_init(MachineState *ms)
>                          nc->name, nc->num, soft_vcpus_limit);
>
>              if (nc->num > hard_vcpus_limit) {
> -                fprintf(stderr, "Number of %s cpus requested (%d) exceed=
s "
> -                        "the maximum cpus supported by KVM (%d)\n",
> -                        nc->name, nc->num, hard_vcpus_limit);
> +                error_report("Number of %s cpus requested (%d) exceeds "
> +                             "the maximum cpus supported by KVM (%d)",
> +                             nc->name, nc->num, hard_vcpus_limit);
>                  exit(1);
>              }
>          }
> @@ -2542,8 +2538,8 @@ static int kvm_init(MachineState *ms)
>      }
>      if (missing_cap) {
>          ret =3D -EINVAL;
> -        fprintf(stderr, "kvm does not support %s\n%s",
> -                missing_cap->name, upgrade_note);
> +        error_report("kvm does not support %s", missing_cap->name);
> +        error_report("%s", upgrade_note);
>          goto err;
>      }
>
> --
> 2.45.2
>


