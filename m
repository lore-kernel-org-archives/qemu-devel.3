Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3EDED24464
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 01:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz4rY-0007sG-CO; Thu, 10 Oct 2024 21:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sz4rW-0007rw-PQ; Thu, 10 Oct 2024 21:54:38 -0400
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sz4rU-00031p-R6; Thu, 10 Oct 2024 21:54:38 -0400
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-84f1ac129c7so482826241.1; 
 Thu, 10 Oct 2024 18:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728611674; x=1729216474; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g87ddPKGAXbCRjT/g3YW8kI9eQwbupVXYSX4NIVVHtE=;
 b=fy6t3hnad8Fq7s8nxf8FV4Xw/Zn1P+Ezf0CxM/0/tvscPo3in+8fll0EHR3z80TK/f
 t/bQ8kt1r0yh6vymq/NNKVM7XKMBXulqXFcX2ft2Ou9J7Yu3i0YXl3IlLYw/uNWO8ZA0
 39KpnAEpJjc3pl9fn28GJIpVsxeIo4unwhYHghKcP47SYvaRyEAsMlgY4KRk+1apJ4lz
 bDHTcjMDWeJfEZtwoXyzHIwnoC3/bHaqOZmy1HN/r4j8aT/D3b0we/3Q6LC7jgvcSoG9
 dAxE0Ld+qnGshQc3Ux/g3mQ6t4JTRxcZvwlW01OrwKamZXjqD44I8uTkNO4ix9JUg4lt
 9pRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728611674; x=1729216474;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g87ddPKGAXbCRjT/g3YW8kI9eQwbupVXYSX4NIVVHtE=;
 b=AFDeHy5LDV4i059T4PfIdXhD8ax3KKzyjTUPMok5+E9T/FNBCBZKlw53Yt6oBuMEMo
 z8RE0CAt5YGLTXE6WJYGvrABrhRsNxjKqgyRY+MCobS9seqTMH44hjA5hS1pUaP/MI8G
 EuZVLz/XLqdsEtRIIMaeIjwhbQHWb/0nqmBogf5bSj7BEMrvupSypeAhGDo2xHmKLgks
 n+Q8Tm1ACRw1QN9+bWMeqqgO2JsQCvhzGqqodPsr5lcp4yyFrp91bkfF6uHTa7iwRWm7
 eAZFl7Z9VysHSz7+6CFcVHFKIz0huOG2k8/+Cy23JFsAOUjQ8z7IRIf22UtN5w/1a2YX
 dYyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyHTNF69rTAKdKjd+CyRROabpjcuvKeoFA8ED4//LGvXizFHcxxxI4k7Pwllp09u9QMtAYQumcVcox@nongnu.org
X-Gm-Message-State: AOJu0YzQ7NVPsehGPb6/oO6hBKZroC/LncBo/Vq7vmmPqsRfITuJisPO
 J0v9XVROPckKLh4Jo2xu8kzB3r+lwS11Ll3wHODS3CKW366tQbRelAngD3Dq1U3cbpI4/nSNr5b
 lemsouncP4xeYV4qdZKRaXXm7IjDSEwxX
X-Google-Smtp-Source: AGHT+IFQi4hb5GKfMAnRTBfBYRxEYQwsTLBd8cUw7L4l7/JALTnpbo8XJUop1+7v2eFDkY37YqQOYuOZ75fOLElvkIA=
X-Received: by 2002:a05:6102:5125:b0:49b:d12f:40b0 with SMTP id
 ada2fe7eead31-4a46595e8a9mr1271390137.1.1728611674192; Thu, 10 Oct 2024
 18:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240924124407.766495-1-dbarboza@ventanamicro.com>
 <20240924124407.766495-3-dbarboza@ventanamicro.com>
In-Reply-To: <20240924124407.766495-3-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 11 Oct 2024 11:54:08 +1000
Message-ID: <CAKmqyKPPun+5QNhLQ-R1p80q6BU4ZmKf=C_UdxwSEs3emi-54Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] target/riscv/kvm: clarify how 'riscv-aia' default
 works
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Sep 24, 2024 at 10:46=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> We do not have control in the default 'riscv-aia' default value. We can
> try to set it to a specific value, in this case 'auto', but there's no
> guarantee that the host will accept it.
>
> Couple with this we're always doing a 'qemu_log' to inform whether we're
> ended up using the host default or if we managed to set the AIA mode to
> the QEMU default we wanted to set.
>
> Change the 'riscv-aia' description to better reflect how the option
> works, and remove the two informative 'qemu_log' that are now unneeded:
> if no message shows, riscv-aia was set to the default or uset-set value.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 970a7ab2f1..32f3dd6a43 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1676,9 +1676,9 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
>      object_class_property_add_str(oc, "riscv-aia", riscv_get_kvm_aia,
>                                    riscv_set_kvm_aia);
>      object_class_property_set_description(oc, "riscv-aia",
> -                                          "Set KVM AIA mode. Valid value=
s are "
> -                                          "emul, hwaccel, and auto. Defa=
ult "
> -                                          "is auto.");
> +        "Set KVM AIA mode. Valid values are 'emul', 'hwaccel' and 'auto'=
. "
> +        "Changing KVM AIA modes relies on host support. Defaults to 'aut=
o' "
> +        "if the host supports it");
>      object_property_set_default_str(object_class_property_find(oc, "risc=
v-aia"),
>                                      "auto");
>  }
> @@ -1712,10 +1712,7 @@ void kvm_riscv_aia_create(MachineState *machine, u=
int64_t group_shift,
>          exit(1);
>      }
>
> -    if (default_aia_mode =3D=3D aia_mode) {
> -        qemu_log("KVM AIA: using default host mode '%s'\n",
> -                  kvm_aia_mode_str(default_aia_mode));
> -    } else {
> +    if (default_aia_mode !=3D aia_mode) {
>          ret =3D kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
>                                  KVM_DEV_RISCV_AIA_CONFIG_MODE,
>                                  &aia_mode, true, NULL);
> @@ -1727,9 +1724,6 @@ void kvm_riscv_aia_create(MachineState *machine, ui=
nt64_t group_shift,
>
>              /* failed to change AIA mode, use default */
>              aia_mode =3D default_aia_mode;
> -        } else {
> -            qemu_log("KVM AIA: setting current mode to %s\n",
> -                     kvm_aia_mode_str(aia_mode));
>          }
>      }
>
> --
> 2.45.2
>
>

