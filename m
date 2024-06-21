Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D2DC2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 13:01:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKdtX-0005OG-Tv; Fri, 21 Jun 2024 09:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKdtO-0005Cr-0F
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 09:01:26 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKdtL-0001o3-NR
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 09:01:25 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-57d26a4ee65so1698548a12.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 06:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718974881; x=1719579681; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nAm0w/vBnIFnVOlRKiX2SvcAx5FlPkkpDJkrLOaHGbo=;
 b=fwMn55vGIW21YVJJD79Zsb9vs7vdAlV+LB1ea086xVe+XVFCst3r9be2p5UQRhGoVV
 DgOdP/wdxeRrOkwtw0gYrx3S4BJQDd8mD4Pt6VdQdjtWCJqLBpYM9zkUomxXEmiVV/jd
 QeXPUjNWEkRCswsH/afWzBska5+sdsF1juYh5YuuyPADG5hzwXvUp3k764Zrvn+9A/TG
 XgCkhXG0QmEMKkixZDBR/U3z5AykRe8zo1g8J709Fp5x6Kvx2LGGrweMhSc6Mg6uaNLL
 bCVoraLiMqOv/yPO7+YPraFhkfNE04aTbayk1IxW7EX/jJ9ErIwWwDCTHPwEZYGvtMRx
 MUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718974881; x=1719579681;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nAm0w/vBnIFnVOlRKiX2SvcAx5FlPkkpDJkrLOaHGbo=;
 b=C1kRCNz1tRIaOpBQgfhCVMXLkOHXj0rd7toL9lHxYhDEmveozujyLy0oy7HoQVX5sg
 B0Q7bE8QkXludBZb+ktrXawVkRNmZbA3hmRZHtEWLgVoF9yghQmw0QGGKjYrWbMilSkK
 Ubzq0XwkJAmZh4lDqpwKNuHk/m7rBZ0Q42mXtfSpJN76/+STo2X5j78G1HCDxDQlbzJM
 CtIyMpgailjdoKfBtS+3ymHqJTbA3sSVIbBj+t0ojDDPgw+iwnXUolB8H6zNW8JOg8xx
 W8QRJjuJwD8CbgJJy5XLXz/AugJpBnO/A24wPAhbg/LqRz1+WZWyMTEwz5rpdxLBuahM
 Lvbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUybOZdMm5JbS3nrtrqCwxZce3uIAxsah7NldfaH5KnqNTkeyP5qBy9J1FTbSdTi/VYmi43R94twioPdVN4rDHo7gaTvfI=
X-Gm-Message-State: AOJu0YwwSnDhbU499zLll5N4oC30K46kxP0lyl8VAjG9XJ95rcAdfByh
 wVMaIji0TLXix2Hh7TJBl1otooE9GuShPyNZmU511vrsjDrcfL5Jap/EhN0DUQdUzvz6mWPWUyM
 DuhI0bMHGJM36HKu49xo4P7bOLefJCTrKb2Me4Q==
X-Google-Smtp-Source: AGHT+IF4xdrQF5EbjtblEUTG1hPz77miWWMEd82515t2+gQM51/nmLVdgxc6tC9PHYDR50VN5U1P6DE8Rxa+0qJkiqo=
X-Received: by 2002:a50:96cf:0:b0:579:cf9d:d6a with SMTP id
 4fb4d7f45d1cf-57d07e858e2mr5061879a12.20.1718974880894; Fri, 21 Jun 2024
 06:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240612020506.307793-1-zhenyzha@redhat.com>
In-Reply-To: <20240612020506.307793-1-zhenyzha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jun 2024 14:01:10 +0100
Message-ID: <CAFEAcA-1Hm63Ry02aEma_k3GO8RjjGfcuaPuBROUpGXAT07VSw@mail.gmail.com>
Subject: Re: [PATCH v3] hw/arm/virt: Avoid unexpected warning from Linux guest
 on host with Fujitsu CPUs
To: Zhenyu Zhang <zhenyzha@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, robin.murphy@arm.com, 
 Jonathan.Cameron@huawei.com, gshan@redhat.com, eauger@redhat.com, 
 sebott@redhat.com, cohuck@redhat.com, ddutile@redhat.com, shahuang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 12 Jun 2024 at 03:05, Zhenyu Zhang <zhenyzha@redhat.com> wrote:
>
> Multiple warning messages and corresponding backtraces are observed when Linux
> guest is booted on the host with Fujitsu CPUs. One of them is shown as below.
>
> [    0.032443] ------------[ cut here ]------------
> [    0.032446] uart-pl011 9000000.pl011: ARCH_DMA_MINALIGN smaller than
> CTR_EL0.CWG (128 < 256)
> [    0.032454] WARNING: CPU: 0 PID: 1 at arch/arm64/mm/dma-mapping.c:54
> arch_setup_dma_ops+0xbc/0xcc
> [    0.032470] Modules linked in:
> [    0.032475] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.14.0-452.el9.aarch64
> [    0.032481] Hardware name: linux,dummy-virt (DT)
> [    0.032484] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    0.032490] pc : arch_setup_dma_ops+0xbc/0xcc
> [    0.032496] lr : arch_setup_dma_ops+0xbc/0xcc
> [    0.032501] sp : ffff80008003b860
> [    0.032503] x29: ffff80008003b860 x28: 0000000000000000 x27: ffffaae4b949049c
> [    0.032510] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
> [    0.032517] x23: 0000000000000100 x22: 0000000000000000 x21: 0000000000000000
> [    0.032523] x20: 0000000100000000 x19: ffff2f06c02ea400 x18: ffffffffffffffff
> [    0.032529] x17: 00000000208a5f76 x16: 000000006589dbcb x15: ffffaae4ba071c89
> [    0.032535] x14: 0000000000000000 x13: ffffaae4ba071c84 x12: 455f525443206e61
> [    0.032541] x11: 68742072656c6c61 x10: 0000000000000029 x9 : ffffaae4b7d21da4
> [    0.032547] x8 : 0000000000000029 x7 : 4c414e494d5f414d x6 : 0000000000000029
> [    0.032553] x5 : 000000000000000f x4 : ffffaae4b9617a00 x3 : 0000000000000001
> [    0.032558] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff2f06c029be40
> [    0.032564] Call trace:
> [    0.032566]  arch_setup_dma_ops+0xbc/0xcc
> [    0.032572]  of_dma_configure_id+0x138/0x300
> [    0.032591]  amba_dma_configure+0x34/0xc0
> [    0.032600]  really_probe+0x78/0x3dc
> [    0.032614]  __driver_probe_device+0x108/0x160
> [    0.032619]  driver_probe_device+0x44/0x114
> [    0.032624]  __device_attach_driver+0xb8/0x14c
> [    0.032629]  bus_for_each_drv+0x88/0xe4
> [    0.032634]  __device_attach+0xb0/0x1e0
> [    0.032638]  device_initial_probe+0x18/0x20
> [    0.032643]  bus_probe_device+0xa8/0xb0
> [    0.032648]  device_add+0x4b4/0x6c0
> [    0.032652]  amba_device_try_add.part.0+0x48/0x360
> [    0.032657]  amba_device_add+0x104/0x144
> [    0.032662]  of_amba_device_create.isra.0+0x100/0x1c4
> [    0.032666]  of_platform_bus_create+0x294/0x35c
> [    0.032669]  of_platform_populate+0x5c/0x150
> [    0.032672]  of_platform_default_populate_init+0xd0/0xec
> [    0.032697]  do_one_initcall+0x4c/0x2e0
> [    0.032701]  do_initcalls+0x100/0x13c
> [    0.032707]  kernel_init_freeable+0x1c8/0x21c
> [    0.032712]  kernel_init+0x28/0x140
> [    0.032731]  ret_from_fork+0x10/0x20
> [    0.032735] ---[ end trace 0000000000000000 ]---
>
> In Linux, a check is applied to every device which is exposed through
> device-tree node. The warning message is raised when the device isn't
> DMA coherent and the cache line size is larger than ARCH_DMA_MINALIGN
> (128 bytes). The cache line is sorted from CTR_EL0[CWG], which corresponds
> to 256 bytes on the guest CPUs. The DMA coherent capability is claimed
> through 'dma-coherent' in their device-tree nodes or parent nodes.
>
> Fix the issue by adding 'dma-coherent' property to the device-tree root
> node, meaning all devices are capable of DMA coherent by default.
>
> Signed-off-by: Zhenyu Zhang <zhenyzha@redhat.com>



Applied to target-arm.next, thanks.

-- PMM

