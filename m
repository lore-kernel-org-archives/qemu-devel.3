Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97077C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 21:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmKtQ-00067Y-35; Mon, 18 Mar 2024 17:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmKtM-00066w-Vf
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 17:51:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmKtL-0007Gv-0p
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 17:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710798693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EwvzMwn40ok36UVOHy8vaGBDGFmTMXxPuDEm/KtaXoA=;
 b=ZJwR407zKy1k7bYEl4fsamdb9aP/yT/reaYyKo+guqBT1ExkUtmLmRjsBsmXAZu7U+hwYJ
 n2xoVc0+aeW7CZlR91z7z9XaBTalzv2ke9disBZ/LYY+W/tbHFQaiZ5QSWw8A4JNx8rnp2
 lQJr2jfccXo5hOUHMXZ3uxqzNOzuFZQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-2eBeWUaJPXGa9XZ5DCr-iA-1; Mon, 18 Mar 2024 17:51:31 -0400
X-MC-Unique: 2eBeWUaJPXGa9XZ5DCr-iA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33ed26afd99so1755690f8f.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 14:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710798690; x=1711403490;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EwvzMwn40ok36UVOHy8vaGBDGFmTMXxPuDEm/KtaXoA=;
 b=lRWN/avmv3wdVNV1KScns8jWLnKfg+2XT0HIrXzFtetd1Ff9j4hlOXwtZwPy/FSpq9
 chpIu/B6wcefe+pRRBtDy7QAjHoingXFEToQRODtR3Z/+pQMphQoeCvDTqYUs6FJ6LvZ
 j8Mz09numk12LOeBDRXbl+4tF06aKgLValWTCFQV3NMTl2zIJDyQto3wTgbSElUJ9xAy
 uVilJzUxfAVeSJmA5BrwLrR9Qs0aj9Kf/O/pq22pUE+g8+ELwmFYJrclhLMl4usjELsM
 nj5AkLm1BBepQ+rRsSNGNOBp7m6cOy+iHDB4JHHLtV6ccCIIxPPSmcrRiHsuQMLL44N1
 2D1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxyRBgrREEQK1wpdNXfMt4y8TbpLAucXthIJtkferGfViRn0qceeFQvg2INfZUiAy60O6sX2nuaAR4LQRF6pDgMcZtDY0=
X-Gm-Message-State: AOJu0YxK8vhwBT1npEQMRHR46Rl3T4wFqswkZYVwaMXFsPiiz6QqVpj4
 dtX6tpoYYcr56yhVLLEHpb2ab/mxVoTHbYIRBr3nQLpAznsU9jimm4ecRUp/jaZCfBssBag0r64
 UXfKkg7uh+485EThT6B23yaXwzMNgL9Z0zpULsWgJADpKz23yh8AYBzglmZOuh2iKoyaGylPbjH
 zYABYPI5+9+12oXCa56comEGXhu08=
X-Received: by 2002:a5d:670e:0:b0:33e:b6a9:a7ec with SMTP id
 o14-20020a5d670e000000b0033eb6a9a7ecmr6430101wru.71.1710798690393; 
 Mon, 18 Mar 2024 14:51:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkIqys4sXIJou8ZjQzAIquGibXEgPoxteSolMkoTsmyjZBO3QG7rQQAabPKV+fVCmu1YjVaSTEbTlfmew3LMQ=
X-Received: by 2002:a5d:670e:0:b0:33e:b6a9:a7ec with SMTP id
 o14-20020a5d670e000000b0033eb6a9a7ecmr6430082wru.71.1710798690032; Mon, 18
 Mar 2024 14:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240229060038.606591-1-xiaoyao.li@intel.com>
 <20240229060038.606591-3-xiaoyao.li@intel.com>
In-Reply-To: <20240229060038.606591-3-xiaoyao.li@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 18 Mar 2024 22:51:18 +0100
Message-ID: <CABgObfbJn01k0WM0o6MfuvQctm0U2uX-D4DQKzStj4N9KwLZTw@mail.gmail.com>
Subject: Re: [PATCH 2/4] i386/sev: Switch to use confidential_guest_kvm_init()
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 29, 2024 at 7:01=E2=80=AFAM Xiaoyao Li <xiaoyao.li@intel.com> w=
rote:
>
> Use confidential_guest_kvm_init() instead of calling SEV specific
> sev_kvm_init(). As a bouns, it fits to future TDX when TDX implements
> its own confidential_guest_support and .kvm_init().
>
> Move the "TypeInfo sev_guest_info" definition and related functions to
> the end of the file, to avoid declaring the sev_kvm_init() ahead.
>
> Delete the sve-stub.c since it's not needed anymore.
>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> Changes from rfc v1:
> - check ms->cgs not NULL before calling confidential_guest_kvm_init();
> - delete the sev-stub.c;

Queued, with just one small simplification that can be done on top:

diff --git a/target/i386/sev.c b/target/i386/sev.c
index e89d64fa52..b8f79d34d1 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -851,18 +851,13 @@ sev_vm_state_change(void *opaque, bool running,
RunState state)

 static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
-    SevGuestState *sev
-        =3D (SevGuestState *)object_dynamic_cast(OBJECT(cgs), TYPE_SEV_GUE=
ST);
+    SevGuestState *sev =3D SEV_GUEST(cgs);
     char *devname;
     int ret, fw_error, cmd;
     uint32_t ebx;
     uint32_t host_cbitpos;
     struct sev_user_data_status status =3D {};

-    if (!sev) {
-        return 0;
-    }
-
     ret =3D ram_block_discard_disable(true);
     if (ret) {
         error_report("%s: cannot disable RAM discard", __func__);

Thanks!

Paolo

> ---
>  target/i386/kvm/kvm.c       |  10 +--
>  target/i386/kvm/meson.build |   2 -
>  target/i386/kvm/sev-stub.c  |  21 -------
>  target/i386/sev.c           | 120 +++++++++++++++++++-----------------
>  target/i386/sev.h           |   2 -
>  5 files changed, 68 insertions(+), 87 deletions(-)
>  delete mode 100644 target/i386/kvm/sev-stub.c
>
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 42970ab046fa..ca4e1fb72dd9 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -2531,10 +2531,12 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>       * mechanisms are supported in future (e.g. TDX), they'll need
>       * their own initialization either here or elsewhere.
>       */
> -    ret =3D sev_kvm_init(ms->cgs, &local_err);
> -    if (ret < 0) {
> -        error_report_err(local_err);
> -        return ret;
> +    if (ms->cgs) {
> +        ret =3D confidential_guest_kvm_init(ms->cgs, &local_err);
> +        if (ret < 0) {
> +            error_report_err(local_err);
> +            return ret;
> +        }
>      }
>
>      has_xcrs =3D kvm_check_extension(s, KVM_CAP_XCRS);
> diff --git a/target/i386/kvm/meson.build b/target/i386/kvm/meson.build
> index 84d9143e6029..e7850981e62d 100644
> --- a/target/i386/kvm/meson.build
> +++ b/target/i386/kvm/meson.build
> @@ -7,8 +7,6 @@ i386_kvm_ss.add(files(
>
>  i386_kvm_ss.add(when: 'CONFIG_XEN_EMU', if_true: files('xen-emu.c'))
>
> -i386_kvm_ss.add(when: 'CONFIG_SEV', if_false: files('sev-stub.c'))
> -
>  i386_system_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'), if=
_false: files('hyperv-stub.c'))
>
>  i386_system_ss.add_all(when: 'CONFIG_KVM', if_true: i386_kvm_ss)
> diff --git a/target/i386/kvm/sev-stub.c b/target/i386/kvm/sev-stub.c
> deleted file mode 100644
> index 1be5341e8a6a..000000000000
> --- a/target/i386/kvm/sev-stub.c
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -/*
> - * QEMU SEV stub
> - *
> - * Copyright Advanced Micro Devices 2018
> - *
> - * Authors:
> - *      Brijesh Singh <brijesh.singh@amd.com>
> - *
> - * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> - * See the COPYING file in the top-level directory.
> - *
> - */
> -
> -#include "qemu/osdep.h"
> -#include "sev.h"
> -
> -int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
> -{
> -    /* If we get here, cgs must be some non-SEV thing */
> -    return 0;
> -}
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 173de91afe7d..19e79d3631d0 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -353,63 +353,6 @@ static void sev_guest_set_kernel_hashes(Object *obj,=
 bool value, Error **errp)
>      sev->kernel_hashes =3D value;
>  }
>
> -static void
> -sev_guest_class_init(ObjectClass *oc, void *data)
> -{
> -    object_class_property_add_str(oc, "sev-device",
> -                                  sev_guest_get_sev_device,
> -                                  sev_guest_set_sev_device);
> -    object_class_property_set_description(oc, "sev-device",
> -            "SEV device to use");
> -    object_class_property_add_str(oc, "dh-cert-file",
> -                                  sev_guest_get_dh_cert_file,
> -                                  sev_guest_set_dh_cert_file);
> -    object_class_property_set_description(oc, "dh-cert-file",
> -            "guest owners DH certificate (encoded with base64)");
> -    object_class_property_add_str(oc, "session-file",
> -                                  sev_guest_get_session_file,
> -                                  sev_guest_set_session_file);
> -    object_class_property_set_description(oc, "session-file",
> -            "guest owners session parameters (encoded with base64)");
> -    object_class_property_add_bool(oc, "kernel-hashes",
> -                                   sev_guest_get_kernel_hashes,
> -                                   sev_guest_set_kernel_hashes);
> -    object_class_property_set_description(oc, "kernel-hashes",
> -            "add kernel hashes to guest firmware for measured Linux boot=
");
> -}
> -
> -static void
> -sev_guest_instance_init(Object *obj)
> -{
> -    SevGuestState *sev =3D SEV_GUEST(obj);
> -
> -    sev->sev_device =3D g_strdup(DEFAULT_SEV_DEVICE);
> -    sev->policy =3D DEFAULT_GUEST_POLICY;
> -    object_property_add_uint32_ptr(obj, "policy", &sev->policy,
> -                                   OBJ_PROP_FLAG_READWRITE);
> -    object_property_add_uint32_ptr(obj, "handle", &sev->handle,
> -                                   OBJ_PROP_FLAG_READWRITE);
> -    object_property_add_uint32_ptr(obj, "cbitpos", &sev->cbitpos,
> -                                   OBJ_PROP_FLAG_READWRITE);
> -    object_property_add_uint32_ptr(obj, "reduced-phys-bits",
> -                                   &sev->reduced_phys_bits,
> -                                   OBJ_PROP_FLAG_READWRITE);
> -}
> -
> -/* sev guest info */
> -static const TypeInfo sev_guest_info =3D {
> -    .parent =3D TYPE_CONFIDENTIAL_GUEST_SUPPORT,
> -    .name =3D TYPE_SEV_GUEST,
> -    .instance_size =3D sizeof(SevGuestState),
> -    .instance_finalize =3D sev_guest_finalize,
> -    .class_init =3D sev_guest_class_init,
> -    .instance_init =3D sev_guest_instance_init,
> -    .interfaces =3D (InterfaceInfo[]) {
> -        { TYPE_USER_CREATABLE },
> -        { }
> -    }
> -};
> -
>  bool
>  sev_enabled(void)
>  {
> @@ -906,7 +849,7 @@ sev_vm_state_change(void *opaque, bool running, RunSt=
ate state)
>      }
>  }
>
> -int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
> +static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>  {
>      SevGuestState *sev
>          =3D (SevGuestState *)object_dynamic_cast(OBJECT(cgs), TYPE_SEV_G=
UEST);
> @@ -1383,6 +1326,67 @@ bool sev_add_kernel_loader_hashes(SevKernelLoaderC=
ontext *ctx, Error **errp)
>      return ret;
>  }
>
> +static void
> +sev_guest_class_init(ObjectClass *oc, void *data)
> +{
> +    ConfidentialGuestSupportClass *klass =3D CONFIDENTIAL_GUEST_SUPPORT_=
CLASS(oc);
> +
> +    klass->kvm_init =3D sev_kvm_init;
> +
> +    object_class_property_add_str(oc, "sev-device",
> +                                  sev_guest_get_sev_device,
> +                                  sev_guest_set_sev_device);
> +    object_class_property_set_description(oc, "sev-device",
> +            "SEV device to use");
> +    object_class_property_add_str(oc, "dh-cert-file",
> +                                  sev_guest_get_dh_cert_file,
> +                                  sev_guest_set_dh_cert_file);
> +    object_class_property_set_description(oc, "dh-cert-file",
> +            "guest owners DH certificate (encoded with base64)");
> +    object_class_property_add_str(oc, "session-file",
> +                                  sev_guest_get_session_file,
> +                                  sev_guest_set_session_file);
> +    object_class_property_set_description(oc, "session-file",
> +            "guest owners session parameters (encoded with base64)");
> +    object_class_property_add_bool(oc, "kernel-hashes",
> +                                   sev_guest_get_kernel_hashes,
> +                                   sev_guest_set_kernel_hashes);
> +    object_class_property_set_description(oc, "kernel-hashes",
> +            "add kernel hashes to guest firmware for measured Linux boot=
");
> +}
> +
> +static void
> +sev_guest_instance_init(Object *obj)
> +{
> +    SevGuestState *sev =3D SEV_GUEST(obj);
> +
> +    sev->sev_device =3D g_strdup(DEFAULT_SEV_DEVICE);
> +    sev->policy =3D DEFAULT_GUEST_POLICY;
> +    object_property_add_uint32_ptr(obj, "policy", &sev->policy,
> +                                   OBJ_PROP_FLAG_READWRITE);
> +    object_property_add_uint32_ptr(obj, "handle", &sev->handle,
> +                                   OBJ_PROP_FLAG_READWRITE);
> +    object_property_add_uint32_ptr(obj, "cbitpos", &sev->cbitpos,
> +                                   OBJ_PROP_FLAG_READWRITE);
> +    object_property_add_uint32_ptr(obj, "reduced-phys-bits",
> +                                   &sev->reduced_phys_bits,
> +                                   OBJ_PROP_FLAG_READWRITE);
> +}
> +
> +/* sev guest info */
> +static const TypeInfo sev_guest_info =3D {
> +    .parent =3D TYPE_CONFIDENTIAL_GUEST_SUPPORT,
> +    .name =3D TYPE_SEV_GUEST,
> +    .instance_size =3D sizeof(SevGuestState),
> +    .instance_finalize =3D sev_guest_finalize,
> +    .class_init =3D sev_guest_class_init,
> +    .instance_init =3D sev_guest_instance_init,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { TYPE_USER_CREATABLE },
> +        { }
> +    }
> +};
> +
>  static void
>  sev_register_types(void)
>  {
> diff --git a/target/i386/sev.h b/target/i386/sev.h
> index e7499c95b1e8..9e10d09539a7 100644
> --- a/target/i386/sev.h
> +++ b/target/i386/sev.h
> @@ -57,6 +57,4 @@ int sev_inject_launch_secret(const char *hdr, const cha=
r *secret,
>  int sev_es_save_reset_vector(void *flash_ptr, uint64_t flash_size);
>  void sev_es_set_reset_vector(CPUState *cpu);
>
> -int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp);
> -
>  #endif
> --
> 2.34.1
>


