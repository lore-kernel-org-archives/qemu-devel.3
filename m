Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6640BC369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 13:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5PUU-0001Qc-OJ; Thu, 17 Apr 2025 09:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u5PUE-0001PQ-J3
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 09:41:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u5PUA-0003mc-Tt
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 09:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744897254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zC8VbZnGuVEzVq4Xi854uaPUuCPjulEdYtul03mIthc=;
 b=gkm4/ci2kBa7HQZAyFkCMulH+B+1YvZ/llRbU9RjtapAbt2onzvN5sjmSLxB00WqXvlHPd
 rzYxmhkdPhXqlgE1EtIgc4Gxqc74WbaRPixfWBjANYLpVgx4F0Cp2p7vAEweNU8Xp1+j9D
 eV/8UuOk6x4lIDl/cG2oIfduqgxURNM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-jEGkfSKgNfCVYpw-Tc6_sQ-1; Thu, 17 Apr 2025 09:40:47 -0400
X-MC-Unique: jEGkfSKgNfCVYpw-Tc6_sQ-1
X-Mimecast-MFC-AGG-ID: jEGkfSKgNfCVYpw-Tc6_sQ_1744897247
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-391315098b2so303955f8f.2
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 06:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744897246; x=1745502046;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zC8VbZnGuVEzVq4Xi854uaPUuCPjulEdYtul03mIthc=;
 b=fHanz9uC2gpfcue9J4bDwTq6/V5mFpesxxDlPm6UEPHHrwqv6hfEyRIOOiEnfupg6q
 lLGXOGN7Ho5tMladgOkUjFS7gX088DtxF/vDQ2rdsw9uf1LAVkU6cBq+ZB9CXXolLyyF
 bo+bqa/5VTW5P3Q5ycfN9uRb4uyQ/kpWBgxh6aFI+bUONkKgcgOEgQLgR7u0VOUw08G/
 D6/mU58xdqDXI6/JYJlhd5Ogqtdhc+H3gQlOC0w2iAH5bSc/fx0TXdlQZ8EhBNq0UhMA
 slg1mQq2nrfreYBhb3ob2WwTsl4ugez9qC/Q6hwhbwHOFJRx9dRIbUcJARetF7DwiQq/
 NFMA==
X-Gm-Message-State: AOJu0Yzo18A0Z9/0xgBEfGy8wYhZZPABKeK9ftG5s22iRIIpRImkmDrp
 uLhin+0zUg5gwt4t2mrEHbmbCm66LKH+I4iDVtzG/gzjbsFkr6KN5raqEH7QY2IYNIOqkPS+XIL
 EL0muyy2TQe9Czi50/r7+mTti/G0mevK68fpNb/RXKKvwzIw/q8+t0nsElIYuIope/rJpukPNy/
 Lk8c70vruJDiXBOGy/ywbvZAvnsqy1+THnuqQ=
X-Gm-Gg: ASbGncvMByIMws//01dcvY3Wsv3lyHoCPYUiynNYtCvNrgy6ZxDx7C49SpAIaMNs93X
 w3+l2xEqozOZlQVRt58wz+GlOQmg64d3TBh5Eh1RFKbfJuded7U1w/14U7RhjuFGridN8XQ==
X-Received: by 2002:a05:6000:2582:b0:391:4ca:490 with SMTP id
 ffacd0b85a97d-39ee5b3243amr4113624f8f.29.1744897246124; 
 Thu, 17 Apr 2025 06:40:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8SjgcoYXjXk6IITgQcp4K77HHROnkICnXOdQfwb0d24nkVg1jLIVcFrI3uTjgjmG2HiJoEDXAn2UxRbnyRjE=
X-Received: by 2002:a05:6000:2582:b0:391:4ca:490 with SMTP id
 ffacd0b85a97d-39ee5b3243amr4113604f8f.29.1744897245807; Thu, 17 Apr 2025
 06:40:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250228102747.867770-1-pbonzini@redhat.com>
In-Reply-To: <20250228102747.867770-1-pbonzini@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 17 Apr 2025 15:40:35 +0200
X-Gm-Features: ATxdqUFL1XTR3n1rRSZzH95ucIgEYcU8IB4sBZ8xpBBe9q5NZW4_LkhlUBvZgEg
Message-ID: <CABgObfYRp-TFLTw5K+Y7US4DM4U+dWagCTAWHXJYkbvkAaapHg@mail.gmail.com>
Subject: Re: [PATCH v2 00/22] target/riscv: declarative CPU definitions
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair.francis@wdc.com>
Content-Type: multipart/alternative; boundary="00000000000081a5f40632f98cdd"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--00000000000081a5f40632f98cdd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alistair,

sorry for the stupid question=E2=80=94I am not sure whether you are going t=
o give
reviewed-by to the remaining patches, and also whether you would like me to
submit the PR for this or not.

Thanks in advance

Paolo

Il ven 28 feb 2025, 11:27 Paolo Bonzini <pbonzini@redhat.com> ha scritto:

> As in v1, what I really wanted to achieve was removing RISC-V's
> use of .instance_post_init; that's because RISC-V operate with an
> opposite conception of .instance_post_init compared to everyone
> else: RISC-V wants to register properties there, whereas x86 and
> hw/pci-bridge/pcie_root_port.c want to set them.  While it's possible
> to move RISC-V's code to instance_init, the others have to run after
> global properties have been set by device_post_init().
>
> The way to get there is to make CPU definitions entirely declarative.
> Previously, multiple instance_init functions each override the properties
> that were set by the superclass, and the code used a mix of subclassing
> and direct invocation of other functions.  Now, instead, after .class_ini=
t
> all the settings for each model are available in a RISCVCPUDef struct,
> and the result is copied into the RISCVCPU at .instance_init time.
> This is done with a single function that starts from the parent's
> RISCVCPUDef and applies the delta stored in the CPU's class_data.
>
> Apart from the small reduction in line count, one advantage is that
> more validation of the models can be done unconditionally at startup,
> instead of happening dynamically if a CPU model is chosen.
>
> Based-on: <20250218165757.554178-1-pbonzini@redhat.com>
>
> Paolo
>
> v1->v2:
> - merged "remove target/riscv: remove unused macro DEFINE_CPU"
> - max SATP mode refactoring moved to its own series
> - included a couple of Philippe's patches from his "const class_data"
> series
> - RISCVCPUDef initializers all declared as const
>
> Paolo Bonzini (20):
>   target/riscv: introduce RISCVCPUDef
>   target/riscv: store RISCVCPUDef struct directly in the class
>   target/riscv: merge riscv_cpu_class_init with the class_base function
>   target/riscv: move RISCVCPUConfig fields to a header file
>   target/riscv: add more RISCVCPUDef fields
>   target/riscv: convert abstract CPU classes to RISCVCPUDef
>   target/riscv: do not make RISCVCPUConfig fields conditional
>   target/riscv: convert profile CPU models to RISCVCPUDef
>   target/riscv: convert bare CPU models to RISCVCPUDef
>   target/riscv: convert dynamic CPU models to RISCVCPUDef
>   target/riscv: convert SiFive E CPU models to RISCVCPUDef
>   target/riscv: convert ibex CPU models to RISCVCPUDef
>   target/riscv: convert SiFive U models to RISCVCPUDef
>   target/riscv: th: make CSR insertion test a bit more intuitive
>   target/riscv: generalize custom CSR functionality
>   target/riscv: convert TT C906 to RISCVCPUDef
>   target/riscv: convert TT Ascalon to RISCVCPUDef
>   target/riscv: convert Ventana V1 to RISCVCPUDef
>   target/riscv: convert Xiangshan Nanhu to RISCVCPUDef
>   target/riscv: remove .instance_post_init
>
> Philippe Mathieu-Daud=C3=A9 (2):
>   target/riscv: Declare RISCVCPUClass::misa_mxl_max as RISCVMXL
>   target/riscv: Convert misa_mxl_max using GLib macros
>
>  target/riscv/cpu-qom.h            |   2 +
>  target/riscv/cpu.h                |  27 +-
>  target/riscv/cpu_cfg.h            | 160 +-----
>  target/riscv/cpu_cfg_fields.h.inc | 165 ++++++
>  hw/riscv/boot.c                   |   2 +-
>  target/riscv/cpu.c                | 909 ++++++++++++++----------------
>  target/riscv/csr.c                |   2 +-
>  target/riscv/gdbstub.c            |   6 +-
>  target/riscv/kvm/kvm-cpu.c        |  23 +-
>  target/riscv/machine.c            |   6 +-
>  target/riscv/tcg/tcg-cpu.c        |  10 +-
>  target/riscv/th_csr.c             |  30 +-
>  target/riscv/translate.c          |   2 +-
>  13 files changed, 632 insertions(+), 712 deletions(-)
>  create mode 100644 target/riscv/cpu_cfg_fields.h.inc
>
> --
> 2.48.1
>

--00000000000081a5f40632f98cdd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Alistair,<div dir=3D"auto"><br></div><div dir=3D"auto"=
>sorry for the stupid question=E2=80=94I am not sure whether you are going =
to give reviewed-by to the remaining patches, and also whether you would li=
ke me to submit the PR for this or not.</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Thanks in advance=C2=A0</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Paolo</div></div><br><div class=3D"gmail_quote gmail_quote_=
container"><div dir=3D"ltr" class=3D"gmail_attr">Il ven 28 feb 2025, 11:27 =
Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.co=
m</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">As in v1, what I really wanted to achieve was removing RISC-V&#39;s<b=
r>
use of .instance_post_init; that&#39;s because RISC-V operate with an<br>
opposite conception of .instance_post_init compared to everyone<br>
else: RISC-V wants to register properties there, whereas x86 and<br>
hw/pci-bridge/pcie_root_port.c want to set them.=C2=A0 While it&#39;s possi=
ble<br>
to move RISC-V&#39;s code to instance_init, the others have to run after<br=
>
global properties have been set by device_post_init().<br>
<br>
The way to get there is to make CPU definitions entirely declarative.<br>
Previously, multiple instance_init functions each override the properties<b=
r>
that were set by the superclass, and the code used a mix of subclassing<br>
and direct invocation of other functions.=C2=A0 Now, instead, after .class_=
init<br>
all the settings for each model are available in a RISCVCPUDef struct,<br>
and the result is copied into the RISCVCPU at .instance_init time.<br>
This is done with a single function that starts from the parent&#39;s<br>
RISCVCPUDef and applies the delta stored in the CPU&#39;s class_data.<br>
<br>
Apart from the small reduction in line count, one advantage is that<br>
more validation of the models can be done unconditionally at startup,<br>
instead of happening dynamically if a CPU model is chosen.<br>
<br>
Based-on: &lt;<a href=3D"mailto:20250218165757.554178-1-pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">20250218165757.554178-1-pbonzini@red=
hat.com</a>&gt;<br>
<br>
Paolo<br>
<br>
v1-&gt;v2:<br>
- merged &quot;remove target/riscv: remove unused macro DEFINE_CPU&quot;<br=
>
- max SATP mode refactoring moved to its own series<br>
- included a couple of Philippe&#39;s patches from his &quot;const class_da=
ta&quot; series<br>
- RISCVCPUDef initializers all declared as const<br>
<br>
Paolo Bonzini (20):<br>
=C2=A0 target/riscv: introduce RISCVCPUDef<br>
=C2=A0 target/riscv: store RISCVCPUDef struct directly in the class<br>
=C2=A0 target/riscv: merge riscv_cpu_class_init with the class_base functio=
n<br>
=C2=A0 target/riscv: move RISCVCPUConfig fields to a header file<br>
=C2=A0 target/riscv: add more RISCVCPUDef fields<br>
=C2=A0 target/riscv: convert abstract CPU classes to RISCVCPUDef<br>
=C2=A0 target/riscv: do not make RISCVCPUConfig fields conditional<br>
=C2=A0 target/riscv: convert profile CPU models to RISCVCPUDef<br>
=C2=A0 target/riscv: convert bare CPU models to RISCVCPUDef<br>
=C2=A0 target/riscv: convert dynamic CPU models to RISCVCPUDef<br>
=C2=A0 target/riscv: convert SiFive E CPU models to RISCVCPUDef<br>
=C2=A0 target/riscv: convert ibex CPU models to RISCVCPUDef<br>
=C2=A0 target/riscv: convert SiFive U models to RISCVCPUDef<br>
=C2=A0 target/riscv: th: make CSR insertion test a bit more intuitive<br>
=C2=A0 target/riscv: generalize custom CSR functionality<br>
=C2=A0 target/riscv: convert TT C906 to RISCVCPUDef<br>
=C2=A0 target/riscv: convert TT Ascalon to RISCVCPUDef<br>
=C2=A0 target/riscv: convert Ventana V1 to RISCVCPUDef<br>
=C2=A0 target/riscv: convert Xiangshan Nanhu to RISCVCPUDef<br>
=C2=A0 target/riscv: remove .instance_post_init<br>
<br>
Philippe Mathieu-Daud=C3=A9 (2):<br>
=C2=A0 target/riscv: Declare RISCVCPUClass::misa_mxl_max as RISCVMXL<br>
=C2=A0 target/riscv: Convert misa_mxl_max using GLib macros<br>
<br>
=C2=A0target/riscv/cpu-qom.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A02 +<br>
=C2=A0target/riscv/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 27 +-<br>
=C2=A0target/riscv/cpu_cfg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 160=
 +-----<br>
=C2=A0target/riscv/cpu_cfg_fields.h.inc | 165 ++++++<br>
=C2=A0hw/riscv/boot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 909 ++++++++++++++----------------<br>
=C2=A0target/riscv/csr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0target/riscv/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A06 +-<br>
=C2=A0target/riscv/kvm/kvm-cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 23 +-<b=
r>
=C2=A0target/riscv/machine.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A06 +-<br>
=C2=A0target/riscv/tcg/tcg-cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 10 +-<b=
r>
=C2=A0target/riscv/th_csr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 30 +-<br>
=C2=A0target/riscv/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A02 +-<br>
=C2=A013 files changed, 632 insertions(+), 712 deletions(-)<br>
=C2=A0create mode 100644 target/riscv/cpu_cfg_fields.h.inc<br>
<br>
-- <br>
2.48.1<br>
</blockquote></div>

--00000000000081a5f40632f98cdd--


