Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4449CA9ED5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 05:18:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG8QM-0002PS-Uz; Mon, 12 Oct 2026 01:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xG8QL-0002PK-TF
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 01:18:09 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xG8QK-0007UX-0F
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 01:18:09 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so711163a91.2
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 22:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791782285; x=1792387085; darn=nongnu.org;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:content-type:mime-version:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lwgjeRydJST696IHSeHuaYzCpV5/DSxHH6p9N6Ffcm4=;
 b=F+gVWavIyCiOl5v8eHUfS3M9Mu2fMq1b+3yayk49Po96z0X8XAiWbrkKQI1PuT3I4T
 xppxX1BSefZV3fW4D0GROOO2pxrb8M7+elMkjHfgw2cEpl6+vF5ifc+0/U9E/cQMRveY
 l3daPBJBWrBccK40jAz7jI9bXxtpAeHODfCup+IiF9Dnr3DXGPJau6rqU7ICUEl3yBO0
 rAS0VfeQHTHJM/YqHVtdxBAS60eEOoy8dK7lc04LvsxfkoFYp43AV8tNDfYD+P0QHw6P
 DjguN1s+W8MDzXexFpm9xsNJT4vq04FZEi98JNNBsNgPWak9lguBEJgWTjm9tABJe6ml
 Wolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791782285; x=1792387085;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:content-type:mime-version:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lwgjeRydJST696IHSeHuaYzCpV5/DSxHH6p9N6Ffcm4=;
 b=HXM/0swWezLNttKE+i6nr6nmG3OzOdKFrt/7kDRuOgNTYd34cux00aEnysnmdSW54E
 HE8vo4xeCZHCGWKb5suOMHaqcdkWcoiW7PcJ3f9uIEz5pOqJgrnoPrpvbDGlvONd7znJ
 zB6l4CqBEdsuMCsPKxzlBuegRN0o59gpcNhtpoFxYPRtCMAti/U9ZXTm6Z9aFdMCF+W8
 Jd1M6JtoKPopeaS8CKeJLehabktyVNAJwpaHQKCb9YIEAN5o3EayWv2v5qXyfSPv03lM
 ahFrl1XaShqvW/6k/OOUNnU63Jf5iKJFHb3bF3gaCckw7+OzHvHh97cWNVBe8i+YaT94
 nehw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzcjoQ9QMEe8daPnceTbiKfjOtlbY9ac8dQNO4LZ0UweqXuzCwQEVqIOWtKN+ReIPTe3O8Bw64iYTz0@nongnu.org
X-Gm-Message-State: AFq9FYLNiWVprwjVGzu3fW8/ZDXmbJFhCri5CdZRNxXdhissyWzExrua
 MkoG90rlTatUJ/gWOKZX37skaLsCvHiwu/MO3LToGKzJsbbbWmNLcbS3HNIIhw==
X-Gm-Gg: AYBFou07q7yg/VwefERYA5NVmaegOF68sXUwfEzhfe/Spujs3saMG8JKJgY39EN6wzd
 SsEZ8dB3TM4xZ1kYZF+UvIZeZHNUGGJr7l8Rher2JOPHLu9pql6Pzi0fVt24Mt7YhT9rOMuKdt6
 feRJxjDHtu9Si8qlh9IAlTLDUGE48dEsm6YFoHT5o+/b2kzdAJkSt7KyTLIIAvogZCfyzOnhva/
 dM/9xD82sdPxR5lgkSLjnhzax03JFt4tIOfY/4gyIhradgjD40wBK8b/R/4ysYvH2JgKEtiRMp9
 XwY6+EREh+y33mhCOVWfFAD2lgMQ7xoLUYHyH09BRkn2t0vqgCrk/R25clItelu5P8M1koyaRgQ
 eZK16jqNIArNvEczuXfAbuktYmu/VU1TltW+jiO2mWWv9FR4YHhR1tYzqgPySTSHQqEtzZDXO9K
 kF4D1ZtirK0k5BWs2UloE8WMgyKQsd7D/UcGioECxE+ckUA5FP5IRrQyUmWpNFs10et7vRx2D7j
 g==
X-Received: by 2002:a17:90b:2784:b0:3ab:9cb:b5a5 with SMTP id
 98e67ed59e1d1-3ab3a74739dmr7000642a91.18.1791782284926; 
 Sun, 11 Oct 2026 22:18:04 -0700 (PDT)
Received: from [127.0.1.1] ([211.226.54.223]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab37139b59sm14924328a91.13.2026.10.11.22.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 22:18:04 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] docs/system: Add UFS emulation page
To: Jeuk Kim <jeuk20.kim@samsung.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, stanleyjhu@google.com
Cc: Bart Van Assche <bvanassche@acm.org>, qemu-devel@nongnu.org, 
 qemu-block@nongnu.org, jeuk20.kim@gmail.com, j-young.choi@samsung.com
In-Reply-To: <20261011122053.1250706-1-stanleyjhu@google.com>
References: <20261011122053.1250706-1-stanleyjhu@google.com>
Date: Mon, 12 Oct 2026 14:17:44 +0900
Message-Id: <179178226448.110507.9534627472462542283.b4-review@b4>
X-Mailer: b4 0.16.1-dev
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> The UFS host controller and logical unit devices have no user
> documentation. Their properties and the way the two devices fit
> together can only be found by reading hw/ufs/.
> 
> Add docs/system/devices/ufs.rst with an example command line, the
> device properties, and current limitations, and list it under the UFS
> entry in MAINTAINERS.
> 
> Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
> ---
>  MAINTAINERS                      |  1 +
>  docs/system/device-emulation.rst |  1 +
>  docs/system/devices/ufs.rst      | 88 ++++++++++++++++++++++++++++++++
>  3 files changed, 90 insertions(+)
>  create mode 100644 docs/system/devices/ufs.rst
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1312bbd1bd..c7f65a5a77 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2758,6 +2758,7 @@ S: Supported
>  F: hw/ufs/*
>  F: include/block/ufs.h
>  F: tests/qtest/ufs-test.c
> +F: docs/system/devices/ufs.rst
>  
>  megasas
>  L: qemu-block@nongnu.org
> diff --git a/docs/system/device-emulation.rst b/docs/system/device-emulation.rst
> index 40054bb7df..a7d247a270 100644
> --- a/docs/system/device-emulation.rst
> +++ b/docs/system/device-emulation.rst
> @@ -96,6 +96,7 @@ Emulated Devices
>     devices/net.rst
>     devices/nvme.rst
>     devices/scsi/index.rst
> +   devices/ufs.rst
>     devices/usb-u2f.rst
>     devices/usb.rst
>     devices/vfio-user.rst
> diff --git a/docs/system/devices/ufs.rst b/docs/system/devices/ufs.rst
> new file mode 100644
> index 0000000000..d3482e9299
> --- /dev/null
> +++ b/docs/system/devices/ufs.rst
> @@ -0,0 +1,88 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +=============
> +UFS Emulation
> +=============
> +
> +QEMU emulates a Universal Flash Storage (UFS) host controller and the
> +logical units behind it. The host controller follows the UFSHCI
> +register interface and reports UFS version 4.1 to the guest.
> +
> +Two devices are involved:
> +
> +``ufs``
> +  The host controller on the PCI bus. A ``sysbus-ufs`` variant exists
> +  for boards that place the controller on the system bus; it cannot be
> +  created with ``-device``.
> +
> +``ufs-lu``
> +  A logical unit attached to a host controller through ``bus=``. Each
> +  logical unit is backed by a block device.
> +
> +The well-known logical units (REPORT LUNS, UFS Device, Boot and RPMB)
> +are created by the host controller and need no configuration.
> +
> +Adding a UFS Device
> +===================
> +
> +The following adds a host controller with MCQ enabled and one logical
> +unit backed by ``ufs.img``:
> +
> +.. code-block:: console
> +
> +    -drive file=ufs.img,if=none,id=lu0,format=raw \
> +    -device ufs,id=ufs0,serial=0001,mcq=on \
> +    -device ufs-lu,drive=lu0,bus=ufs0,lun=0
> +
> +Add more ``ufs-lu`` devices with different ``lun`` values to create
> +more logical units. On top of the architecture defconfig, a Linux
> +guest needs ``CONFIG_SCSI_UFSHCD``, ``CONFIG_SCSI_UFSHCD_PCI`` and
> +``CONFIG_BLK_DEV_SD``; each logical unit then appears as a SCSI disk.
> +
> +Host Controller Properties
> +==========================
> +
> +``serial``
> +  Serial number string. It is accepted but not reported to the guest
> +  yet; the serial number string descriptor reads back empty.
> +
> +``nutrs`` (default 32, maximum 32)
> +  Number of UTP transfer request slots.
> +
> +``nutmrs`` (default 8, maximum 8)
> +  Number of UTP task management request slots advertised to the guest.
> +  Task management requests are not processed yet (see Limitations).
> +
> +``mcq`` (default off)
> +  Advertise Multi-Circular Queue (MCQ) support. When off, the guest
> +  uses the single doorbell transfer request list.
> +
> +``mcq-maxq`` (default 2, maximum 31)
> +  Number of MCQ submission and completion queue pairs.
> +
> +``wb-max-size``, ``wb-min-size`` (default 0x400 and 0x100)
> +  Maximum and minimum WriteBooster buffer size, in allocation units.
> +  ``wb-min-size`` must not exceed ``wb-max-size``.
> +
> +Logical Unit Properties
> +=======================
> +
> +``drive``
> +  Backing block device.
> +
> +``lun`` (default 0)
> +  Logical unit number, 0 to 31. A host controller accepts up to 32
> +  logical units.
> +
> +Limitations
> +===========
> +
> +* UniPro and M-PHY are not modelled. Only the UIC commands needed for
> +  link startup, DME attribute access and hibernation are handled; DME
> +  reads return fixed values, and DME writes, power mode changes and
> +  hibernation do not change any link state.
> +* UTP task management requests are not processed, so a guest that
> +  tries to abort a command or reset a logical unit gets no completion.
> +* The Boot and RPMB well-known logical units only answer basic SCSI
> +  commands such as INQUIRY; boot and RPMB data access are not emulated.
> +* The device cannot be migrated.

Thank you for writing this UFS guide.

Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>

-- 
Jeuk Kim <jeuk20.kim@samsung.com>

