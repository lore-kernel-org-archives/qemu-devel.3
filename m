Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617A0CD342D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 12:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slT5F-0003Q5-Lc; Tue, 03 Sep 2024 08:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1slT5E-0003NU-W7
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 08:56:33 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1slT5B-0000hv-SH
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 08:56:32 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20551e2f1f8so23655855ad.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 05:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1725368188; x=1725972988; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jwd2HftIZT5ob7rXqU4vt/7mt3l0RsQVpLBLed1ONFI=;
 b=Z6Fr9ZwO2kHMNtViSjICgEetlOQbzzZ7TCuHzyQvOXlbThI/EbiMjCUmOTNGoyUvFw
 To9VQqvyJYOJpxqb7WkB1Zv27Allj6/ZBgWmIQ8S2vrvNnXNrZms/JA+NnaMhAJzFh0A
 +eLqCySX+Fx6a24mhzm6cIbOTbfqwtWigv7tYX35EdrUQ9KR/Rtn3BQJX/K4hquDCP5J
 b4daJnkGaTfLQ1n8MJLSLwL0hkOTiiriAA48EAyY3wRckTeH1CskDDtFLcEuYrqHhBuJ
 GIrQit6JIAZjT8DZI+/THJLLw4KdyPf232v3YEtwaypUUKYtZNrYHha7yIj2aidhNYQw
 eN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725368188; x=1725972988;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jwd2HftIZT5ob7rXqU4vt/7mt3l0RsQVpLBLed1ONFI=;
 b=RTXrhlS0fR6OCKgbQsuk2ro76r469+Xzqt82n/YY2nAYg8FD9Kz9vL+t0J3qRtYvS8
 bpxbmRfvH5bNpJKVkxs2cQfepoDnDTdfu0nWMDDgBeD8jx6K2VMYodxDoATTBgE/vaU4
 r4DF7XPxAFzogk3SuQCY1YVp8Gvn9VJhvGunRrtP8MWtQP3gcRzQ5UMp4b4Sc2yhwT5L
 Zz3NpM6jTtCWGlC/DaJ52ArsAu9huH+FjJstuKxF+OREsSrcWNx0jwzBhkGdIJ75k6Ix
 Ag9iqoBw4o4opc08ot9GlfSm9D076Pehmtg1gyrgLLZThhH+xm2PvCcAmUF5FUDn4b9o
 0kWQ==
X-Gm-Message-State: AOJu0YyvULRjIFmFpmfhPScQBuisooiV0dEc6ZPOiJeqVc+eTwgZpnxA
 +wzKUF+USarDre1j3xxrDfzwyE6TrvO5x8mHQa8csA0RBe9ZZ0DlPRNJr45fxYm0qdi2ei+plkU
 S
X-Google-Smtp-Source: AGHT+IEJA9ryYqHsdzxyIkRx30/XxHy26j+lzwh0zvWcfCMHxrwo4bq3A7WhD9yzMAPCGdM+OG74fw==
X-Received: by 2002:a17:903:984:b0:1fb:62e8:ae98 with SMTP id
 d9443c01a7336-2058417b104mr68803105ad.3.1725368187842; 
 Tue, 03 Sep 2024 05:56:27 -0700 (PDT)
Received: from [192.168.68.110] ([177.170.227.130])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-205489c6b58sm50473395ad.284.2024.09.03.05.56.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 05:56:27 -0700 (PDT)
Message-ID: <4dd65d5c-de31-48a7-a083-bbf6e1b591bf@ventanamicro.com>
Date: Tue, 3 Sep 2024 09:56:23 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 v6 12/12] docs/specs: add riscv-iommu
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 jason.chien@sifive.com, frank.chang@sifive.com, ajones@ventanamicro.com
References: <20240801154334.1009852-1-dbarboza@ventanamicro.com>
 <20240801154334.1009852-13-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240801154334.1009852-13-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 8/1/24 12:43 PM, Daniel Henrique Barboza wrote:
> Add a simple guideline to use the existing RISC-V IOMMU support we just
> added.
> 
> This doc will be updated once we add the riscv-iommu-sys device.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   docs/specs/index.rst       |  1 +
>   docs/specs/riscv-iommu.rst | 80 ++++++++++++++++++++++++++++++++++++++
>   docs/system/riscv/virt.rst | 13 +++++++
>   3 files changed, 94 insertions(+)
>   create mode 100644 docs/specs/riscv-iommu.rst
> 
> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
> index 1484e3e760..c68cd9ae6c 100644
> --- a/docs/specs/index.rst
> +++ b/docs/specs/index.rst
> @@ -33,3 +33,4 @@ guest hardware that is specific to QEMU.
>      virt-ctlr
>      vmcoreinfo
>      vmgenid
> +   riscv-iommu
> diff --git a/docs/specs/riscv-iommu.rst b/docs/specs/riscv-iommu.rst
> new file mode 100644
> index 0000000000..e3b8f7208e
> --- /dev/null
> +++ b/docs/specs/riscv-iommu.rst
> @@ -0,0 +1,80 @@
> +.. _riscv-iommu:
> +
> +RISC-V IOMMU support for RISC-V machines
> +========================================
> +
> +QEMU implements a RISC-V IOMMU emulation based on the RISC-V IOMMU spec
> +version 1.0 `iommu1.0`_.
> +
> +The emulation includes a PCI reference device, riscv-iommu-pci, that QEMU
> +RISC-V boards can use.  The 'virt' RISC-V machine is compatible with this
> +device.
> +
> +riscv-iommu-pci reference device
> +--------------------------------
> +
> +This device implements the RISC-V IOMMU emulation as recommended by the section
> +"Integrating an IOMMU as a PCIe device" of `iommu1.0`_: a PCI device with base
> +class 08h, sub-class 06h and programming interface 00h.
> +
> +As a reference device it doesn't implement anything outside of the specification,
> +so it uses a generic default PCI ID given by QEMU: 1b36:0014.
> +
> +To include the device in the 'virt' machine:
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-riscv64 -M virt -device riscv-iommu-pci,[optional_pci_opts] (...)
> +
> +This will add a RISC-V IOMMU PCI device in the board following any additional
> +PCI parameters (like PCI bus address).  The behavior of the RISC-V IOMMU is
> +defined by the spec but its operation is OS dependent.  As of this writing the
> +existing Linux kernel support `linux-v8`_, not yet merged, will configure the IOMMU
> +to create IOMMU groups with any eligible cards available in the system,
> +regardless of factors such as the order in which the devices are added in the
> +command line.

I'm receiving emails from users about the kernel being cited here not being able to
do a VFIO passthrough.

They are correct. The explanation is that the current kernel patches does not have all
the support needed for VFIO passthrough and other features like irqbypass. For my
testing I've been using a kernel that has this additional support that is made available
in the Ventana Micro github mirror:

https://github.com/ventanamicro/linux/tree/dev-upstream


Until the kernel support is feature complete, feel free to use this kernel that Ventana
is maintaining updated with the latest IOMMU kernel version + other goodies.


I'll update v7 with this additional info in the docs. Thanks,


Daniel


> +
> +This means that these command lines are equivalent as far as the current
> +IOMMU kernel driver behaves:
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-riscv64 \
> +        -M virt,aia=aplic-imsic,aia-guests=5 \
> +        -device riscv-iommu-pci,addr=1.0,vendor-id=0x1efd,device-id=0xedf1 \
> +        -device e1000e,netdev=net1 -netdev user,id=net1,net=192.168.0.0/24 \
> +        -device e1000e,netdev=net2 -netdev user,id=net2,net=192.168.200.0/24 \
> +        (...)
> +
> +  $ qemu-system-riscv64 \
> +        -M virt,aia=aplic-imsic,aia-guests=5 \
> +        -device e1000e,netdev=net1 -netdev user,id=net1,net=192.168.0.0/24 \
> +        -device e1000e,netdev=net2 -netdev user,id=net2,net=192.168.200.0/24 \
> +        -device riscv-iommu-pci,addr=1.0,vendor-id=0x1efd,device-id=0xedf1 \
> +        (...)
> +
> +Both will create iommu groups for the two e1000e cards.
> +
> +Another thing to notice on `linux-v8`_ is that the kernel driver considers an IOMMU
> +identified as a Rivos device, i.e. it uses Rivos vendor ID.  To use the riscv-iommu-pci
> +device with the existing kernel support we need to emulate a Rivos PCI IOMMU by
> +setting 'vendor-id' and 'device-id':
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-riscv64 -M virt	\
> +     -device riscv-iommu-pci,vendor-id=0x1efd,device-id=0xedf1 (...)
> +
> +Several options are available to control the capabilities of the device, namely:
> +
> +- "bus": the bus that the IOMMU device uses
> +- "ioatc-limit": size of the Address Translation Cache (default to 2Mb)
> +- "intremap": enable/disable MSI support
> +- "ats": enable ATS support
> +- "off" (Out-of-reset translation mode: 'on' for DMA disabled, 'off' for 'BARE' (passthrough))
> +- "s-stage": enable s-stage support
> +- "g-stage": enable g-stage support
> +
> +.. _iommu1.0: https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/riscv-iommu.pdf
> +
> +.. _linux-v8: https://lore.kernel.org/linux-riscv/cover.1718388908.git.tjeznach@rivosinc.com/
> diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
> index c3f94f63da..dd884ea919 100644
> --- a/docs/system/riscv/virt.rst
> +++ b/docs/system/riscv/virt.rst
> @@ -84,6 +84,19 @@ none``, as in
>   
>   Firmware images used for pflash must be exactly 32 MiB in size.
>   
> +riscv-iommu support
> +-------------------
> +
> +The board has support for the riscv-iommu-pci device by using the following
> +command line:
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-riscv64 -M virt -device riscv-iommu-pci (...)
> +
> +Refer to :ref:`riscv-iommu` for more information on how the RISC-V IOMMU support
> +works.
> +
>   Machine-specific options
>   ------------------------
>   

