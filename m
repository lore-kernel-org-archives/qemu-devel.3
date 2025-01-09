Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E702E7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 10:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVqE0-0000ip-GB; Thu, 09 Jan 2025 05:57:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tVqDy-0000hv-1f
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 05:57:14 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tVqDv-00008r-4W
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 05:57:13 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5d982de9547so1310623a12.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 02:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1736420228; x=1737025028; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QZizyE+sqVqNzd/4+/3++039N742rp8OayC2oGAAPnk=;
 b=K9TF3CswzFn28cESMU64Ycq7JnPREaoAGT0FBP0bH0U1vmSCAuPdZ92Z3UtqeiDUyc
 uJ38OMnWnGgyIpjxNFZgp2SlZP87GZOknHvcBnUldnG1gz6+3E1RzEhi+VfP6m5OeU7Z
 j4n5fY8hqW+e/nLakZfrVYM60R9yk7xJ6u/zE4znhDkbGbUApGgSdUJhX+A1k2gx83sT
 ofJz+KxNDrNPXP/o0sR/0bPCegRbvdIwDSiarV4lwey4/itmCUmB5z7LqpKgl9TMdG37
 YlB351KAxNpWFZw1l4nfOjJgprSRLJ3lkprIAETJYJL/ynW9A8bSaFFHrovrGLuzsIU6
 WUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736420228; x=1737025028;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QZizyE+sqVqNzd/4+/3++039N742rp8OayC2oGAAPnk=;
 b=LiUkiDQTYN58+vKA2I2jTCzn1eF393x6pwWiCywP+czzU/Lh75NIVbBfVjXIieUFzJ
 jJUAxrpjvlU9KPtQM505TMX1exkM8wJQIbKTKytFEGlK1hmnXxzHjuDXf2P0UmVM+oC5
 JAKAM4VkidM0RowObnsm9m8u2FXC/7BkUG8dlJ0XWPpaNehoHgWtRc/YDFeTc2Psx7X3
 Y8XL+OyghkLbohgwzIgBF8S5kX7fXv5ipSmNxvETSH2DZoH2IkYvRw4An8RDpdMlRjoZ
 IjJ+9hPXiyAQ1ZAJKZKl131Kt42ZP7f05zHwbcVjm9Dz9RdpiCkHln0L5GMRUbvJsw6R
 ZNog==
X-Gm-Message-State: AOJu0YwWNIhKF6Ito/Ato06Ceb7/I5HqRV87BnqEEQOGz0lw4TUS5zyN
 J5CHXkUv4EBIkVsKcOG8t92F4P4BMjtF//krc5Y1wrIx0XxTOdzTPE8R7fQpZh9VkxAh/DEpjOm
 RundalDywr7SXp+vsJYGpY7aSB46Ai8ooZb0dhRXJ13U/jUQK
X-Gm-Gg: ASbGncs8cVAPSX9mltDDySduJv9q6SKro0ffJGsCisd7vT9K2mdLYmEMFn9W7K5/x6w
 agWMN1aQalqSE/vmlyzvt3vA2Rv9loXbER8iP9sCf
X-Google-Smtp-Source: AGHT+IG7A1vWPzerGDGp5qybFTkUqfSIrPuGxpjc17kfgbDZ6lFrUY/D/HohdGgpzN20lQlgwucntd+OrIS+aQZgdHY=
X-Received: by 2002:a05:6402:4415:b0:5d1:1f1:a283 with SMTP id
 4fb4d7f45d1cf-5d972df6fecmr5421704a12.4.1736420228620; Thu, 09 Jan 2025
 02:57:08 -0800 (PST)
MIME-Version: 1.0
References: <20241216004857.9367-1-jason.chien@sifive.com>
In-Reply-To: <20241216004857.9367-1-jason.chien@sifive.com>
From: Jason Chien <jason.chien@sifive.com>
Date: Thu, 9 Jan 2025 18:56:57 +0800
X-Gm-Features: AbW1kvYz0C0jE49uTCElGy3vKnqKd2DkiKC61hXIFIqabUQVa4biuyRfrxbeJz8
Message-ID: <CADr__8pzZ2+H1g0SZWqjYqRLf_gaeNYQ+ATNyYZLBtaqQDkhTA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Avoid contention for PCIIOMMUOps between IOMMU
 and PCIe host
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:MCIMX7D SABRE / i..." <qemu-arm@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000e88b3a062b43d600"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=jason.chien@sifive.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000e88b3a062b43d600
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping.

Jason Chien <jason.chien@sifive.com> =E6=96=BC 2024=E5=B9=B412=E6=9C=8816=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=888:49=E5=AF=AB=E9=81=93=EF=BC=
=9A

> When PCIIOMMUOps.get_address_space() is already registered by the pci hos=
t,
> e.g. TYPE_DESIGNWARE_PCIE_HOST, IOMMU cannot overwrite this hook without
> breaking the PCIe translation rule, which means that IOMMU and the pci ho=
st
> cannot coexist.
>
> This RFC introduces a new callback, PCIIOMMUOps.set_memory_region(), and
> an API, pci_setup_iommu_downstream_mem, to avoid the contention for
> PCIIOMMUOps.get_address_space().
>
> Jason Chien (6):
>   include/hw/pci: Add a callback to set the downstream memory region of
>     a pci bus
>   hw/pci: Add an API to set the downstream memory region of a PCI bus
>   hw/pci-host: Enable DW PCIe host to send memory transactions over
>     specific mr
>   hw/riscv/riscv-iommu: Allow PCI hosts with iommu_ops registered
>     connecting to the IOMMU
>   hw/riscv/riscv-iommu: Acquire device IDs dynamically
>   include/hw/pci: Send PCI dma requests with memory attributes
>     containing BDF
>
>  hw/pci-host/designware.c         | 18 +++++++++++++++---
>  hw/pci/pci.c                     |  6 ++++++
>  hw/riscv/riscv-iommu.c           | 21 +++++++++++++++++++--
>  include/hw/pci-host/designware.h |  2 ++
>  include/hw/pci/pci.h             | 20 ++++++++++++++++++++
>  include/hw/pci/pci_device.h      | 15 ++++++++++++---
>  6 files changed, 74 insertions(+), 8 deletions(-)
>
> --
> 2.43.2
>
>

--000000000000e88b3a062b43d600
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ping.</div><br><div class=3D"gmail_quote gmail_quote_conta=
iner"><div dir=3D"ltr" class=3D"gmail_attr">Jason Chien &lt;<a href=3D"mail=
to:jason.chien@sifive.com">jason.chien@sifive.com</a>&gt; =E6=96=BC 2024=E5=
=B9=B412=E6=9C=8816=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=888:49=E5=
=AF=AB=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">When PCIIOMMUOps.get_address_space() is already registered by th=
e pci host,<br>
e.g. TYPE_DESIGNWARE_PCIE_HOST, IOMMU cannot overwrite this hook without<br=
>
breaking the PCIe translation rule, which means that IOMMU and the pci host=
<br>
cannot coexist.<br>
<br>
This RFC introduces a new callback, PCIIOMMUOps.set_memory_region(), and<br=
>
an API, pci_setup_iommu_downstream_mem, to avoid the contention for<br>
PCIIOMMUOps.get_address_space().<br>
<br>
Jason Chien (6):<br>
=C2=A0 include/hw/pci: Add a callback to set the downstream memory region o=
f<br>
=C2=A0 =C2=A0 a pci bus<br>
=C2=A0 hw/pci: Add an API to set the downstream memory region of a PCI bus<=
br>
=C2=A0 hw/pci-host: Enable DW PCIe host to send memory transactions over<br=
>
=C2=A0 =C2=A0 specific mr<br>
=C2=A0 hw/riscv/riscv-iommu: Allow PCI hosts with iommu_ops registered<br>
=C2=A0 =C2=A0 connecting to the IOMMU<br>
=C2=A0 hw/riscv/riscv-iommu: Acquire device IDs dynamically<br>
=C2=A0 include/hw/pci: Send PCI dma requests with memory attributes<br>
=C2=A0 =C2=A0 containing BDF<br>
<br>
=C2=A0hw/pci-host/designware.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 18 ++++++=
+++++++++---<br>
=C2=A0hw/pci/pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 6 ++++++<br>
=C2=A0hw/riscv/riscv-iommu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 21 +=
++++++++++++++++++--<br>
=C2=A0include/hw/pci-host/designware.h |=C2=A0 2 ++<br>
=C2=A0include/hw/pci/pci.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 20 ++++++++++++++++++++<br>
=C2=A0include/hw/pci/pci_device.h=C2=A0 =C2=A0 =C2=A0 | 15 ++++++++++++---<=
br>
=C2=A06 files changed, 74 insertions(+), 8 deletions(-)<br>
<br>
-- <br>
2.43.2<br>
<br>
</blockquote></div>

--000000000000e88b3a062b43d600--

