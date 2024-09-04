Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF9CCD4853
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 16:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slsSh-0002S3-6c; Wed, 04 Sep 2024 12:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1slsRx-0001CS-LI
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 12:01:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1slsRt-0007ZF-Iv
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 12:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725465694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4YMsrOHwdbwj1vJyLbDTSGRJoKcvxAjUZz1QB5PoqZg=;
 b=buRxeCabrG4IT/n8XMd9QlR1NE59p1ooZU0lR9agWP1+Laln/hs+cYhCYuafX/Gz/tQRnv
 xsLvMxMJoaP75sFhrQihhkMLOi+DmCXmSLUwkMPCB/1+WjyB4gyEYCmyTSjqfF2W0c9LuX
 it6Xj1O0LwGyMD+1IsUqWfs87sNsvpU=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-AxGO1XvsP_qzPAJxna2otg-1; Wed, 04 Sep 2024 12:01:31 -0400
X-MC-Unique: AxGO1XvsP_qzPAJxna2otg-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-6818fa37eecso6914874a12.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 09:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725465689; x=1726070489;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4YMsrOHwdbwj1vJyLbDTSGRJoKcvxAjUZz1QB5PoqZg=;
 b=lP96PKZvPBa6X0139jpuG4CzEDZTl2peO6wrHedkFbSQQvN2arBfwsWVRzAD0Q9BlZ
 ZZdGG4xSiDcUiFKVdpPJhakQD2vKGBDbsprS8CEUx0eOhGpEICwuPYCPH+XvqdFNArvx
 RPvaXBy2n7TkVq81E4fP8Sx0uQbBxWdQfH5xn4tUNSModMAKAD9kaeOh8TonLLMN2Oaz
 ss5jz+MjihPN4yIAupmkiz7pd/dgVZRF05ZLxGl9m76LwUDthfLZpUl+8tRPh0Gbnbu7
 0aUYwy5kPlMgw/hLCDOzzAHHzOuiPCMnJPEybzzdhu+6o6aUek8w6YdWoaCP8n2WmoAB
 CPow==
X-Gm-Message-State: AOJu0YzYNvsxt00mTLBXuL03YeJ0Hn2VRC5qqsWAtqjUD0jLU5FuCKeB
 3P+LYib0bWNs/IfhNCexK9tBF6UR3KlXdcZXXEniO/fJ0hgvX9OGdIfLQ6q4exrMjf7XCrgGrmM
 a6xgKq8ZYSfnPzT0ONCAzYZt/PbMVI2zzEwW+OPULGxsg1y4h5ILCaBdORrAq7tY=
X-Received: by 2002:a17:90a:788e:b0:2da:8e9b:f37b with SMTP id
 98e67ed59e1d1-2da8e9bf63amr2827390a91.24.1725465689120; 
 Wed, 04 Sep 2024 09:01:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcRbhfB+lTkwbiKaObF/fWzamXZOgzAZayQTqPYVDZw+xrEKYnDlR0CVkZ74hiyBOKbhqEDQ==
X-Received: by 2002:a17:90a:788e:b0:2da:8e9b:f37b with SMTP id
 98e67ed59e1d1-2da8e9bf63amr2827344a91.24.1725465688624; 
 Wed, 04 Sep 2024 09:01:28 -0700 (PDT)
Received: from smtpclient.apple ([115.96.124.26])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d8de63cf21sm6657254a91.56.2024.09.04.09.01.26
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 04 Sep 2024 09:01:28 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH] kvm/i386: replace identity_base variable with a constant
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20240904123238.283627-1-pbonzini@redhat.com>
Date: Wed, 4 Sep 2024 21:31:13 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <90FC8A16-85B6-4B59-BC49-E8CBD0C6DBD1@redhat.com>
References: <20240904123238.283627-1-pbonzini@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3776.700.51)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 4 Sep 2024, at 6:02=E2=80=AFPM, Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>=20
> identity_base variable is first initialzied to address 0xfffbc000 and =
then
> kvm_vm_set_identity_map_addr() overrides this value to address =
0xfeffc000.
> The initial address to which the variable was initialized was never =
used. Clean
> everything up, placing 0xfeffc000 in a preprocessor constant.
>=20
> Reported-by: Ani Sinha <anisinha@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> target/i386/kvm/kvm.c | 36 ++++++++++++++++++------------------
> 1 file changed, 18 insertions(+), 18 deletions(-)
>=20
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 599faf0ac6e..5422fd7fa7d 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -81,6 +81,16 @@
>     do { } while (0)
> #endif
>=20
> +/*
> + * On older Intel CPUs, KVM uses vm86 mode to emulate 16-bit code =
directly.
> + * In order to use vm86 mode, an EPT identity map and a TSS  are =
needed.
> + * Since these must be part of guest physical memory, we need to =
allocate
> + * them, both by setting their start addresses in the kernel and by
> + * creating a corresponding e820 entry. We need 4 pages before the =
BIOS,
> + * so this value allows up to 16M BIOSes.
> + */
> +#define KVM_IDENTITY_BASE 0xfeffc000
> +
> /* =46rom arch/x86/kvm/lapic.h */
> #define KVM_APIC_BUS_CYCLE_NS       1
> #define KVM_APIC_BUS_FREQUENCY      (1000000000ULL / =
KVM_APIC_BUS_CYCLE_NS)
> @@ -3036,18 +3046,9 @@ static int =
kvm_vm_enable_triple_fault_event(KVMState *s)
>     return ret;
> }
>=20
> -static int kvm_vm_set_identity_map_addr(KVMState *s, uint64_t =
*identity_base)
> +static int kvm_vm_set_identity_map_addr(KVMState *s, uint64_t =
identity_base)
> {
> -    /*
> -     * On older Intel CPUs, KVM uses vm86 mode to emulate 16-bit code =
directly.
> -     * In order to use vm86 mode, an EPT identity map and a TSS  are =
needed.
> -     * Since these must be part of guest physical memory, we need to =
allocate
> -     * them, both by setting their start addresses in the kernel and =
by
> -     * creating a corresponding e820 entry. We need 4 pages before =
the BIOS,
> -     * so this value allows up to 16M BIOSes.
> -     */
> -    *identity_base =3D 0xfeffc000;
> -    return kvm_vm_ioctl(s, KVM_SET_IDENTITY_MAP_ADDR, identity_base);
> +    return kvm_vm_ioctl(s, KVM_SET_IDENTITY_MAP_ADDR, =
&identity_base);
> }
>=20
> static int kvm_vm_set_nr_mmu_pages(KVMState *s)
> @@ -3064,10 +3065,9 @@ static int kvm_vm_set_nr_mmu_pages(KVMState *s)
>     return ret;
> }
>=20
> -static int kvm_vm_set_tss_addr(KVMState *s, uint64_t identity_base)
> +static int kvm_vm_set_tss_addr(KVMState *s, uint64_t tss_base)
> {
> -    /* Set TSS base one page after EPT identity map. */
> -    return kvm_vm_ioctl(s, KVM_SET_TSS_ADDR, identity_base);
> +    return kvm_vm_ioctl(s, KVM_SET_TSS_ADDR, tss_base);
> }
>=20
> static int kvm_vm_enable_disable_exits(KVMState *s)
> @@ -3195,7 +3195,6 @@ static void kvm_vm_enable_energy_msrs(KVMState =
*s)
>=20
> int kvm_arch_init(MachineState *ms, KVMState *s)
> {
> -    uint64_t identity_base =3D 0xfffbc000;
>     int ret;
>     struct utsname utsname;
>     Error *local_err =3D NULL;
> @@ -3263,18 +3262,19 @@ int kvm_arch_init(MachineState *ms, KVMState =
*s)
>     uname(&utsname);
>     lm_capable_kernel =3D strcmp(utsname.machine, "x86_64") =3D=3D 0;
>=20
> -    ret =3D kvm_vm_set_identity_map_addr(s, &identity_base);
> +    ret =3D kvm_vm_set_identity_map_addr(s, KVM_IDENTITY_BASE);
>     if (ret < 0) {
>         return ret;
>     }
>=20
> -    ret =3D kvm_vm_set_tss_addr(s, identity_base + 0x1000);
> +    /* Set TSS base one page after EPT identity map. */
> +    ret =3D kvm_vm_set_tss_addr(s, KVM_IDENTITY_BASE + 0x1000);
>     if (ret < 0) {
>         return ret;
>     }
>=20
>     /* Tell fw_cfg to notify the BIOS to reserve the range. */
> -    e820_add_entry(identity_base, 0x4000, E820_RESERVED);
> +    e820_add_entry(KVM_IDENTITY_BASE, 0x4000, E820_RESERVED);
>=20
>     ret =3D kvm_vm_set_nr_mmu_pages(s);
>     if (ret < 0) {
> --=20
> 2.46.0
>=20


