Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD0EC3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 09:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUk1A-0001pW-5A; Fri, 19 Jul 2024 05:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUk18-0001oV-SS; Fri, 19 Jul 2024 05:35:10 -0400
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUk15-0003LI-U3; Fri, 19 Jul 2024 05:35:10 -0400
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-48fe73d4f6cso541093137.2; 
 Fri, 19 Jul 2024 02:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721381706; x=1721986506; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B2fZBlLJUXYAs7C8u9TuVqjmV5zo1YOGp6Dk6cUGaUk=;
 b=E7UIi6c2wD8ePGZeQvKhkT4J3ftb34UY9j6HLIlHTqaCc17LgmreIGnfsTNj3c/ffJ
 pjBbZCBmGgk2sDOHBjURQichenj2FsTiVj0jY/3ybaGqc6ixxsqVp+dA5XU37CO7CWjW
 2+qylWF+fWwBFyMZ0sVLz5Knj1eeirB5aB40v1uxBPyyrsctBnVJn2ErrjH1RZ64jz/P
 +w17KAm1oCqdB0ILrgVPP6CkdUWn8mhT9jyOpXb8uA0Kf8dzb2YXw2UEB/9whGgeEZSV
 KsfOc4GW1ZJiXUDdBUbQ+WagGkbOQsoEY8A6oWPI58UkOdJX9dLir+WTXdshbStfTlzs
 1K6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721381706; x=1721986506;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B2fZBlLJUXYAs7C8u9TuVqjmV5zo1YOGp6Dk6cUGaUk=;
 b=GMQSXz7kSkkzq5b3rbHHvpUYbh12lzNTWy39/iPuFwbR3SQiK53gnyGqj1ZkpWj4J8
 g3S1K+99GZ7B7Nv99s7O9jzAr/S8mBeTtpOCmGV6q5QunuWPFKKCUJ049rK2MVNAvRdx
 q3b298Fo4qgxeny600S4Sjy7UQZMJrXAd+YXzou51BlPPkvlcM1SugWgK0qxFy+gAo7w
 gIKN4mdQfWwUBSuKUaEDKpq0szyt/65+JMBL6b5li/LCaUbYNJg9nYnHWzAAseSsqYuG
 oWPsh9YCFbDfFVn6bH1HxIhLexLypJ/N2Cn4Y5PCj8edFk0gDZ+P/Ue0c9wpL9dy8pT4
 pCvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZHwgYQEs8utqH89umwCmvL+CYE85/zx+6MvDpJzLScRnkv3E2JYPvoeRt7orePopYx237QA3xEjeha0UlnV7OIEP/7W8=
X-Gm-Message-State: AOJu0YwKEnyr6QwQvzYi4SASn3znrgQ4lps3+S1lga8BaRoYcqIPriEG
 ON1Lgt2ANxxWuekWM0mNMcSzrbtS5DMjUcn80dLMTleq25JWlqVL/YC6F61o2lmId7250QuW8kV
 CZJqLneD6UxINdKuSG031fGT3M7I=
X-Google-Smtp-Source: AGHT+IGAOslIKfCeYoYR90IlDgOj2WlN8i0EWIv36T8ZomtKEe20oDCNnOVV4xXWw6PaXKbLMxyauU9lbWZEZ6cxC5Y=
X-Received: by 2002:a05:6102:8021:b0:48f:de68:aaf2 with SMTP id
 ada2fe7eead31-4915984a674mr10303147137.2.1721381706407; Fri, 19 Jul 2024
 02:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240708173501.426225-1-dbarboza@ventanamicro.com>
 <20240708173501.426225-14-dbarboza@ventanamicro.com>
In-Reply-To: <20240708173501.426225-14-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 19 Jul 2024 19:34:40 +1000
Message-ID: <CAKmqyKOA8VHg=BDBfhZcf0eU=3ts0=PoLEdzdd0rhNOz000=Xg@mail.gmail.com>
Subject: Re: [PATCH v5 13/13] docs/specs: add riscv-iommu
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, frank.chang@sifive.com, tjeznach@rivosinc.com, 
 jason.chien@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2d;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2d.google.com
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

On Tue, Jul 9, 2024 at 3:37=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Add a simple guideline to use the existing RISC-V IOMMU support we just
> added.
>
> This doc will be updated once we add the riscv-iommu-sys device.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  docs/specs/index.rst       |  1 +
>  docs/specs/riscv-iommu.rst | 55 ++++++++++++++++++++++++++++++++++++++
>  docs/system/riscv/virt.rst | 13 +++++++++
>  3 files changed, 69 insertions(+)
>  create mode 100644 docs/specs/riscv-iommu.rst
>
> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
> index 1484e3e760..c68cd9ae6c 100644
> --- a/docs/specs/index.rst
> +++ b/docs/specs/index.rst
> @@ -33,3 +33,4 @@ guest hardware that is specific to QEMU.
>     virt-ctlr
>     vmcoreinfo
>     vmgenid
> +   riscv-iommu
> diff --git a/docs/specs/riscv-iommu.rst b/docs/specs/riscv-iommu.rst
> new file mode 100644
> index 0000000000..fa38ff7667
> --- /dev/null
> +++ b/docs/specs/riscv-iommu.rst
> @@ -0,0 +1,55 @@
> +.. _riscv-iommu:
> +
> +RISC-V IOMMU support for RISC-V machines
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +QEMU implements a RISC-V IOMMU emulation based on the RISC-V IOMMU spec
> +version 1.0 [1].
> +
> +The emulation includes a PCI reference device, riscv-iommu-pci, that QEM=
U
> +RISC-V boards can use.  The 'virt' RISC-V machine is compatible with thi=
s
> +device.
> +
> +A platform device that implements the RISC-V IOMMU will be added in the
> +future.
> +
> +
> +riscv-iommu-pci reference device
> +--------------------------------
> +
> +This device implements the RISC-V IOMMU emulation as recommended by the =
section
> +"Integrating an IOMMU as a PCIe device" of [1]: a PCI device with base c=
lass 08h,
> +sub-class 06h and programming interface 00h.
> +
> +As a reference device it doesn't implement anything outside of the speci=
fication,
> +so it uses a generic default PCI ID given by QEMU: 1b36:0014.
> +
> +To include the device in the 'virt' machine:
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-riscv64 -M virt -device riscv-iommu-pci (...)

We should add a sentence saying what this does. As in what should a
user expect after they have done this

Alistair

> +
> +As of this writing the existing Linux kernel support [2], not yet merged=
, is being
> +created as a Rivos device, i.e. it uses Rivos vendor ID.  To use the ris=
cv-iommu-pci
> +device with the existing kernel support we need to emulate a Rivos PCI I=
OMMU by
> +setting 'vendor-id' and 'device-id':
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-riscv64 -M virt        \
> +     -device riscv-iommu-pci,vendor-id=3D0x1efd,device-id=3D0xedf1 (...)
> +
> +Several options are available to control the capabilities of the device,=
 namely:
> +
> +- "bus"
> +- "ioatc-limit"
> +- "intremap"
> +- "ats"
> +- "off" (Out-of-reset translation mode: 'on' for DMA disabled, 'off' for=
 'BARE' (passthrough))
> +- "s-stage"
> +- "g-stage"
> +
> +
> +[1] https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/=
riscv-iommu.pdf
> +[2] https://lore.kernel.org/linux-riscv/cover.1718388908.git.tjeznach@ri=
vosinc.com/
> diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
> index 9a06f95a34..8e9a2e4dda 100644
> --- a/docs/system/riscv/virt.rst
> +++ b/docs/system/riscv/virt.rst
> @@ -84,6 +84,19 @@ none``, as in
>
>  Firmware images used for pflash must be exactly 32 MiB in size.
>
> +riscv-iommu support
> +-------------------
> +
> +The board has support for the riscv-iommu-pci device by using the follow=
ing
> +command line:
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-riscv64 -M virt -device riscv-iommu-pci (...)
> +
> +Refer to :ref:`riscv-iommu` for more information on how the RISC-V IOMMU=
 support
> +works.
> +
>  Machine-specific options
>  ------------------------
>
> --
> 2.45.2
>
>

