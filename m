Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62D7606A337
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hclh+zyr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOX4u-0007rF-35; Wed, 04 Nov 2026 04:14:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1xOX4q-0007qP-Vu
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 04:14:41 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1xOX4m-0007Um-B5
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 04:14:39 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2e60f9af6e6so4769725ad.3
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 01:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793783673; x=1794388473; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6whLUxRJqlDH9WhPQh9uoPXAFq+edUhufsVpkDecFkA=;
 b=hclh+zyr7LO7HBYwNlyBJqWTTKEit+WGZrT34UiBzAXS6n/Tb4GaeyarshhciOj4o8
 97mgaVveFYbw8FhipcyaJMHfAQwrxzPR60bnQlAmcZwXwBC6hj25SCJpBKz3gT/yHD1U
 EbCQ00oWkkFjUezyBzgzOEoIjlAvJEinBX20jua/fi658IoreJIt7gbk+V0sa1Cxgbhr
 kAHKEUjJsQPRgMxm+hbXlAHGEfOMUixvCWJXoKU/zUg44obfWkbuTMNLZETgPvQgdZRE
 NAzAtvVuFz3OrWRTLPVHCQYuPbCCIItH/Ul5lKi6zg8ShXqM3UVz1HT1nJnk76iw12lX
 sh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793783673; x=1794388473;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6whLUxRJqlDH9WhPQh9uoPXAFq+edUhufsVpkDecFkA=;
 b=jgUA4lKykhcwROODcKeOC2R3qdDeA7EvSTsjJWZmza+wDl369zG3qz3apRVrx7bJ03
 X8sxY5HuBboF2xSUzuUzkG4Qu42nlq+m0Cxpd7NSFDAFu1ZtWYsOJLQnGcqa0Ww65yp5
 LhdRZvp3qXCUQbCZBy+iXvouqVgSDQVhWEOWwR2IM2aIFPR6h/5PZQpWHVL/yYeDF/FC
 vGqTUpQK6OxlKs3UsnpvTEeK9KfsyqvP426tR3G4EZ1iHzbgiHgeaD1F1Bb51u2mM1m2
 IohBIH6+zSwgHV6dHqmlbCLCrHejNTNEAt3VZ8SGUy9pPcMjPkD3/uVd/fwwhYz46RyE
 s9KA==
X-Forwarded-Encrypted: i=1;
 AKwUvBytXhY7dPq8XsozGY0OJPMyy4Fw2Cu7t0zKgRDrzbJRPTJ0LWcm3aG8W+uDN6FMHEP0YzP8wEu4OlQU@nongnu.org
X-Gm-Message-State: APuU4Z+6dDLdZxlRwl9ArFBsjazbzCbQTshpcHaqVgLI4cHXg8MMpV+a
 2vtvBEk6CYpzfh5hnnn0GOkHkndHAkNkPgMcXQY++ZVOgffkYojmzMzQ
X-Gm-Gg: AYBFou2ia9C9jbipBhsN6jhwabcmEfp6G1tg0SEB+4nIWYg0FDKQ91+zMS87OKDR3ip
 SHL9jxg/sTwHikF0u8F0UkWUh5WoHXy6nL9K7wQUDiAmMkhzV0Vjxtalj2F3xG3rkTuL2Qph3k1
 PLVvRrd9YgkYpNfizOAA3RWjrfWe8zlNHmKasGsUBd+3fkG0Vxn+RByp4aaIClzhwQdiNJSnWaU
 BkA2LfzExcFz/gy1NN6oFrkcT5uTfo/uoD0xr+vW4X+Hm4z11/rB0qX0Ooik55+IVDfx2gQwW+l
 HhNnql+xHucZofiYcHAX2glYDSjEsIKfMASmkNySWavddtk7u+5/J3XaUgX4ABPYXxJGKU80rbh
 eWvxkWlLUcRQUjniYCw78ghPyEaUjbNO7l8v20Qi7pJ0z2lNZGOZ5zrIAzLtplsogteVVmS2m4U
 7ZPUbMTyDiVWL/J6U6EP8Ekeei1Hre8oaMlUiRM5/ujPovZoWd4sRHVmpyOvTr0WqD4JComE6+h
 Y0ru8B/kJSZWygiYgt0y1hKSdprC+IlrhgZ96NfrRarB1OQDIHG12NcSSFupCNdaKaArL7hh10C
 UIBLTaQ+Ol4XWYExZ24to9xLO6QVGzJuN4tfpZs6MveDluMFznGFeYX+UkEipn0J
X-Received: by 2002:a17:902:cf04:b0:2e9:665f:3442 with SMTP id
 d9443c01a7336-2eb364ac702mr155621055ad.25.1793783673212; 
 Wed, 04 Nov 2026 01:14:33 -0800 (PST)
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp. [133.11.54.183])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed08fe5256sm5069495ad.13.2026.11.04.01.14.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 01:14:32 -0800 (PST)
Message-ID: <9e3e28ee-c94b-4055-aca9-07c6f8a68ac5@gmail.com>
Date: Wed, 4 Nov 2026 18:14:29 +0900
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] hw/misc: Add CnuasGPU virtual accelerator
To: Weqaar Janjua <weqaar.janjua@packetfive.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, peter.maydell@linaro.org, mst@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, jasowangio@gmail.com,
 pbonzini@redhat.com, farosas@suse.de, lvivier@redhat.com
References: <20260929202358.725310-1-weqaar.janjua@packetfive.com>
 <20260929202358.725310-6-weqaar.janjua@packetfive.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <20260929202358.725310-6-weqaar.janjua@packetfive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pl1-x62e.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026/09/30 5:23, Weqaar Janjua wrote:
> Add device memory, interrupt state, and link transport.
> 
> Signed-off-by: Weqaar Janjua <weqaar.janjua@packetfive.com>
> ---
>   MAINTAINERS             |   2 +
>   docs/specs/cnuasgpu.rst |  91 +++++++
>   docs/specs/index.rst    |   1 +
>   docs/specs/pci-ids.rst  |   2 +-
>   hw/misc/Kconfig         |   5 +
>   hw/misc/cnuasgpu.c      | 557 ++++++++++++++++++++++++++++++++++++++++
>   hw/misc/meson.build     |   1 +
>   7 files changed, 658 insertions(+), 1 deletion(-)
>   create mode 100644 docs/specs/cnuasgpu.rst
>   create mode 100644 hw/misc/cnuasgpu.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7be5622f23..7b2173d832 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2777,6 +2777,8 @@ Cnuas virtual devices
>   M: Weqaar Janjua <weqaar.janjua@packetfive.com>
>   S: Maintained
>   F: docs/specs/cnuas-vnic.rst
> +F: docs/specs/cnuasgpu.rst
> +F: hw/misc/cnuasgpu.c
>   F: hw/net/cnuas_vnic.c
>   F: tests/qtest/cnuas-vnic-test.c
>   
> diff --git a/docs/specs/cnuasgpu.rst b/docs/specs/cnuasgpu.rst
> new file mode 100644
> index 0000000000..b364f6b04d
> --- /dev/null
> +++ b/docs/specs/cnuasgpu.rst
> @@ -0,0 +1,91 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +============================
> +CnuasGPU virtual accelerator
> +============================
> +
> +``cnuasgpu`` is the PCIe device model for the Cnuas virtual AI/ML
> +accelerator. It emulates the guest-visible control, device-memory, interrupt,
> +and peer-fabric interfaces. Compute kernels are executed by Cnuas runtime
> +backends rather than by a cycle-accurate GPU pipeline inside QEMU. Its
> +optional ``SOCK_SEQPACKET`` transport currently requires a Linux host.
> +
> +PCI interface
> +-------------
> +
> +===================== ==================
> +Vendor ID             1b36
> +Device ID             0018
> +Revision              1
> +Class                 0b40, co-processor
> +===================== ==================
> +
> +======  ======================================================
> +BAR     Contents
> +======  ======================================================
> +0       64 KiB MMIO register region
> +1       64-bit prefetchable device memory, 256 MiB by default
> +======  ======================================================
> +
> +The device supports one MSI vector and INTx.
> +
> +Properties
> +----------
> +
> +``gpu_id``
> +  Guest-visible accelerator identifier.
> +
> +``sm_count``, ``lanes_per_sm``, ``tensor_size``
> +  Guest-visible geometry values. They do not control a compute engine.
> +
> +``devmem_size``
> +  BAR 1 size. It must be a power of two from 16 MiB through 1 TiB.
> +
> +``cnuaslink_socket``
> +  Optional ``AF_UNIX`` ``SOCK_SEQPACKET`` endpoint for CnuasLink frames.
> +
> +``x-speed``, ``x-width``
> +  PCIe link speed and width reported through PCIe configuration space.
> +
> +Register map
> +------------
> +
> +All registers require 32-bit little-endian accesses.
> +
> +======  ==================  =========================================
> +Offset  Name                Meaning
> +======  ==================  =========================================
> +0x000   VENDOR_ID           0x1b36, read only
> +0x004   DEVICE_ID           0x0018, read only
> +0x008   REVISION            0x01, read only
> +0x00c   FW_VERSION          0x00010000, read only
> +0x010   GPU_ID              ``gpu_id`` property, read only
> +0x014   SM_COUNT            ``sm_count`` property, read only
> +0x018   LANES_PER_SM        ``lanes_per_sm`` property, read only
> +0x01c   TENSOR_SIZE         ``tensor_size`` property, read only
> +0x020   DEVMEM_SIZE_LO      BAR 1 size, low 32 bits, read only
> +0x024   DEVMEM_SIZE_HI      BAR 1 size, high 32 bits, read only
> +0x100   IRQ_STATUS          Interrupt status; write one bits to clear
> +0x104   IRQ_MASK            Interrupt enable mask
> +0x200   LINK_STATUS         Bit 0 link up, bit 1 receive ready
> +0x204   TX_OFFSET_LO        BAR 1 transmit offset, low 32 bits
> +0x208   TX_OFFSET_HI        BAR 1 transmit offset, high 32 bits
> +0x20c   TX_LEN              Transmit length from 1 through 65536 bytes
> +0x210   TX_DOORBELL         Write nonzero to transmit
> +0x214   RX_OFFSET_LO        BAR 1 receive offset, low 32 bits
> +0x218   RX_OFFSET_HI        BAR 1 receive offset, high 32 bits
> +0x21c   RX_BUF_SIZE         Maximum accepted receive length
> +0x220   RX_LEN              Last receive length, read only
> +0x224   RX_CONSUME          Write nonzero to release the receive buffer
> +======  ==================  =========================================
> +
> +Interrupt bit 0 reports transmit completion and bit 1 reports an available
> +receive frame.
> +
> +CnuasLink
> +---------
> +
> +The optional socket transports one frame per message. A transmit reads from
> +BAR 1. A receive writes to BAR 1 and pauses socket monitoring until the guest
> +writes ``RX_CONSUME``. Offsets and lengths are checked against BAR 1 before
> +the model accesses device memory.
> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
> index 0fd5da2aa8..e674d76da6 100644
> --- a/docs/specs/index.rst
> +++ b/docs/specs/index.rst
> @@ -27,6 +27,7 @@ guest hardware that is specific to QEMU.
>      fsi
>      vmw_pvscsi-spec
>      cnuas-vnic
> +   cnuasgpu
>      edu
>      ivshmem-spec
>      pvpanic
> diff --git a/docs/specs/pci-ids.rst b/docs/specs/pci-ids.rst
> index 74a35b8f09..bacd005862 100644
> --- a/docs/specs/pci-ids.rst
> +++ b/docs/specs/pci-ids.rst
> @@ -103,7 +103,7 @@ PCI devices (other than virtio):
>   1b36:0017
>     Cnuas virtual RDMA network adapter (:doc:`cnuas-vnic`)
>   1b36:0018
> -  CnuasGPU virtual accelerator
> +  CnuasGPU virtual accelerator (:doc:`cnuasgpu`)
>   
>   All these devices are documented in :doc:`index`.
>   
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 46e3c03cc8..39d52674e0 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -35,6 +35,11 @@ config EDU
>       default y if TEST_DEVICES
>       depends on PCI && MSI_NONBROKEN
>   
> +config CNUAS_GPU
> +    bool
> +    default y if PCI_DEVICES || PCIE_DEVICES
> +    depends on LINUX && PCI_EXPRESS && MSI_NONBROKEN
> +
>   config I2C_ECHO
>       bool
>       default y if TEST_DEVICES
> diff --git a/hw/misc/cnuasgpu.c b/hw/misc/cnuasgpu.c
> new file mode 100644
> index 0000000000..38ac1bdb42
> --- /dev/null
> +++ b/hw/misc/cnuasgpu.c
> @@ -0,0 +1,557 @@
> +/*
> + * CnuasGPU virtual accelerator
> + *
> + * Copyright (c) 2026 PacketFive
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qemu/main-loop.h"
> +#include "qemu/module.h"
> +#include "qemu/units.h"
> +#include "hw/core/qdev-properties.h"
> +#include "hw/core/qdev-properties-system.h"
> +#include "hw/pci/msi.h"
> +#include "hw/pci/pci.h"
> +#include "hw/pci/pcie.h"
> +#include "migration/vmstate.h"
> +#include "qapi/error.h"
> +#include "qom/object.h"
> +
> +#include <fcntl.h>
> +#include <sys/socket.h>
> +#include <sys/un.h>
> +
> +#define TYPE_CNUAS_GPU "cnuasgpu"
> +OBJECT_DECLARE_SIMPLE_TYPE(CnuasGpuState, CNUAS_GPU)
> +
> +#define CNUAS_GPU_BAR0_SIZE          (64 * KiB)
> +#define CNUAS_GPU_DEVMEM_DEFAULT     (256 * MiB)
> +#define CNUAS_GPU_DEVMEM_MIN         (16 * MiB)
> +#define CNUAS_GPU_DEVMEM_MAX         (1024ULL * GiB)
> +#define CNUAS_GPU_LINK_MAX_FRAME     (64 * KiB)
> +
> +#define CNUAS_GPU_REG_VENDOR_ID      0x000
> +#define CNUAS_GPU_REG_DEVICE_ID      0x004
> +#define CNUAS_GPU_REG_REVISION       0x008
> +#define CNUAS_GPU_REG_FW_VERSION     0x00c
> +#define CNUAS_GPU_REG_GPU_ID         0x010
> +#define CNUAS_GPU_REG_SM_COUNT       0x014
> +#define CNUAS_GPU_REG_LANES_PER_SM   0x018
> +#define CNUAS_GPU_REG_TENSOR_SIZE    0x01c
> +#define CNUAS_GPU_REG_DEVMEM_SIZE_LO 0x020
> +#define CNUAS_GPU_REG_DEVMEM_SIZE_HI 0x024
> +#define CNUAS_GPU_REG_IRQ_STATUS     0x100
> +#define CNUAS_GPU_REG_IRQ_MASK       0x104
> +#define CNUAS_GPU_REG_LINK_STATUS    0x200
> +#define CNUAS_GPU_REG_TX_OFFSET_LO   0x204
> +#define CNUAS_GPU_REG_TX_OFFSET_HI   0x208
> +#define CNUAS_GPU_REG_TX_LEN         0x20c
> +#define CNUAS_GPU_REG_TX_DOORBELL    0x210
> +#define CNUAS_GPU_REG_RX_OFFSET_LO   0x214
> +#define CNUAS_GPU_REG_RX_OFFSET_HI   0x218
> +#define CNUAS_GPU_REG_RX_BUF_SIZE    0x21c
> +#define CNUAS_GPU_REG_RX_LEN         0x220
> +#define CNUAS_GPU_REG_RX_CONSUME     0x224
> +
> +#define CNUAS_GPU_FW_VERSION         0x00010000
> +#define CNUAS_GPU_REVISION           1
> +
> +#define CNUAS_GPU_IRQ_TX_DONE        BIT(0)
> +#define CNUAS_GPU_IRQ_RX_AVAILABLE   BIT(1)
> +
> +#define CNUAS_GPU_LINK_UP            BIT(0)
> +#define CNUAS_GPU_LINK_RX_READY      BIT(1)
> +
> +struct CnuasGpuState {
> +    PCIDevice parent_obj;
> +    MemoryRegion bar0;
> +    MemoryRegion bar1;
> +
> +    uint32_t gpu_id;
> +    uint32_t sm_count;
> +    uint32_t lanes_per_sm;
> +    uint32_t tensor_size;
> +    uint64_t devmem_size;
> +    PCIExpLinkSpeed pcie_speed;
> +    PCIExpLinkWidth pcie_width;
> +
> +    uint32_t irq_status;
> +    uint32_t irq_mask;
> +
> +    char *link_socket;
> +    int socket_fd;
> +    bool link_up;
> +    uint32_t tx_offset_lo;
> +    uint32_t tx_offset_hi;
> +    uint32_t tx_len;
> +    uint32_t rx_offset_lo;
> +    uint32_t rx_offset_hi;
> +    uint32_t rx_buf_size;
> +    uint32_t rx_len;
> +    bool rx_ready;
> +};
> +
> +static void cnuas_gpu_update_irq(CnuasGpuState *s)
> +{
> +    bool pending = s->irq_status & s->irq_mask;
> +
> +    if (msi_enabled(&s->parent_obj)) {
> +        if (pending) {
> +            msi_notify(&s->parent_obj, 0);
> +        }
> +    } else {
> +        pci_set_irq(&s->parent_obj, pending);
> +    }
> +}
> +
> +static void *cnuas_gpu_devmem_ptr(CnuasGpuState *s, uint64_t offset,
> +                                  size_t length)
> +{
> +    if (offset > s->devmem_size || length > s->devmem_size - offset) {
> +        return NULL;
> +    }
> +
> +    return memory_region_get_ram_ptr(&s->bar1) + offset;
> +}
> +
> +static void cnuas_gpu_disconnect(CnuasGpuState *s)
> +{
> +    if (s->socket_fd >= 0) {
> +        qemu_set_fd_handler(s->socket_fd, NULL, NULL, NULL);
> +        close(s->socket_fd);
> +        s->socket_fd = -1;
> +    }
> +    s->link_up = false;
> +    s->rx_ready = false;
> +    s->rx_len = 0;
> +}
> +
> +static void cnuas_gpu_receive_ready(void *opaque)
> +{
> +    CnuasGpuState *s = opaque;
> +    uint8_t frame[CNUAS_GPU_LINK_MAX_FRAME];
> +    uint64_t offset;
> +    void *destination;
> +    ssize_t length;
> +
> +    if (s->rx_ready) {
> +        qemu_set_fd_handler(s->socket_fd, NULL, NULL, NULL);
> +        return;
> +    }
> +
> +    length = recv(s->socket_fd, frame, sizeof(frame), MSG_DONTWAIT);
> +    if (length == 0) {
> +        cnuas_gpu_disconnect(s);
> +        return;
> +    }
> +    if (length < 0) {
> +        if (errno != EAGAIN && errno != EWOULDBLOCK && errno != EINTR) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "cnuasgpu: link receive failed: %s\n",
> +                          strerror(errno));
> +            cnuas_gpu_disconnect(s);
> +        }
> +        return;
> +    }
> +
> +    if (!s->rx_buf_size || length > s->rx_buf_size) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "cnuasgpu: RX frame does not fit guest buffer\n");
> +        return;
> +    }
> +
> +    offset = ((uint64_t)s->rx_offset_hi << 32) | s->rx_offset_lo;
> +    destination = cnuas_gpu_devmem_ptr(s, offset, length);
> +    if (!destination) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "cnuasgpu: RX range exceeds device memory\n");
> +        return;
> +    }
> +
> +    memcpy(destination, frame, length);

Received device-memory writes are lost during migration since the direct 
memcpy() into BAR1 never marks the modified range dirty.

Regards,
Akihiko Odaki

> +    s->rx_len = length;
> +    s->rx_ready = true;
> +    s->irq_status |= CNUAS_GPU_IRQ_RX_AVAILABLE;
> +    cnuas_gpu_update_irq(s);
> +    qemu_set_fd_handler(s->socket_fd, NULL, NULL, NULL);
> +}
> +
> +static void cnuas_gpu_connect(CnuasGpuState *s)
> +{
> +    struct sockaddr_un address = { .sun_family = AF_UNIX };
> +    int flags;
> +    int fd;
> +
> +    if (!s->link_socket || !s->link_socket[0]) {
> +        return;
> +    }
> +    if (strlen(s->link_socket) >= sizeof(address.sun_path)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "cnuasgpu: link socket path is too long\n");
> +        return;
> +    }
> +
> +    fd = socket(AF_UNIX, SOCK_SEQPACKET, 0);
> +    if (fd < 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "cnuasgpu: link socket creation failed: %s\n",
> +                      strerror(errno));
> +        return;
> +    }
> +
> +    g_strlcpy(address.sun_path, s->link_socket, sizeof(address.sun_path));
> +    if (connect(fd, (struct sockaddr *)&address, sizeof(address)) < 0) {
> +        qemu_log_mask(LOG_UNIMP,
> +                      "cnuasgpu: cannot connect to %s: %s\n",
> +                      s->link_socket, strerror(errno));
> +        close(fd);
> +        return;
> +    }
> +
> +    flags = fcntl(fd, F_GETFL);
> +    if (flags < 0 || fcntl(fd, F_SETFL, flags | O_NONBLOCK) < 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "cnuasgpu: cannot make socket nonblocking: %s\n",
> +                      strerror(errno));
> +        close(fd);
> +        return;
> +    }
> +
> +    s->socket_fd = fd;
> +    s->link_up = true;
> +    qemu_set_fd_handler(fd, cnuas_gpu_receive_ready, NULL, s);
> +}
> +
> +static void cnuas_gpu_transmit(CnuasGpuState *s)
> +{
> +    uint64_t offset;
> +    void *source;
> +    ssize_t sent;
> +
> +    if (!s->link_up || s->socket_fd < 0) {
> +        return;
> +    }
> +    if (!s->tx_len || s->tx_len > CNUAS_GPU_LINK_MAX_FRAME) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "cnuasgpu: invalid TX length %u\n", s->tx_len);
> +        return;
> +    }
> +
> +    offset = ((uint64_t)s->tx_offset_hi << 32) | s->tx_offset_lo;
> +    source = cnuas_gpu_devmem_ptr(s, offset, s->tx_len);
> +    if (!source) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "cnuasgpu: TX range exceeds device memory\n");
> +        return;
> +    }
> +
> +    sent = send(s->socket_fd, source, s->tx_len, MSG_NOSIGNAL);
> +    if (sent < 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "cnuasgpu: link transmit failed: %s\n",
> +                      strerror(errno));
> +        if (errno != EAGAIN && errno != EWOULDBLOCK) {
> +            cnuas_gpu_disconnect(s);
> +        }
> +        return;
> +    }
> +    if (sent != s->tx_len) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "cnuasgpu: short TX (%zd of %u bytes)\n",
> +                      sent, s->tx_len);
> +        return;
> +    }
> +
> +    s->irq_status |= CNUAS_GPU_IRQ_TX_DONE;
> +    cnuas_gpu_update_irq(s);
> +}
> +
> +static uint64_t cnuas_gpu_bar0_read(void *opaque, hwaddr addr,
> +                                    unsigned size)
> +{
> +    CnuasGpuState *s = opaque;
> +
> +    switch (addr) {
> +    case CNUAS_GPU_REG_VENDOR_ID:
> +        return PCI_VENDOR_ID_REDHAT;
> +    case CNUAS_GPU_REG_DEVICE_ID:
> +        return PCI_DEVICE_ID_REDHAT_CNUASGPU;
> +    case CNUAS_GPU_REG_REVISION:
> +        return CNUAS_GPU_REVISION;
> +    case CNUAS_GPU_REG_FW_VERSION:
> +        return CNUAS_GPU_FW_VERSION;
> +    case CNUAS_GPU_REG_GPU_ID:
> +        return s->gpu_id;
> +    case CNUAS_GPU_REG_SM_COUNT:
> +        return s->sm_count;
> +    case CNUAS_GPU_REG_LANES_PER_SM:
> +        return s->lanes_per_sm;
> +    case CNUAS_GPU_REG_TENSOR_SIZE:
> +        return s->tensor_size;
> +    case CNUAS_GPU_REG_DEVMEM_SIZE_LO:
> +        return s->devmem_size;
> +    case CNUAS_GPU_REG_DEVMEM_SIZE_HI:
> +        return s->devmem_size >> 32;
> +    case CNUAS_GPU_REG_IRQ_STATUS:
> +        return s->irq_status;
> +    case CNUAS_GPU_REG_IRQ_MASK:
> +        return s->irq_mask;
> +    case CNUAS_GPU_REG_LINK_STATUS:
> +        return (s->link_up ? CNUAS_GPU_LINK_UP : 0) |
> +               (s->rx_ready ? CNUAS_GPU_LINK_RX_READY : 0);
> +    case CNUAS_GPU_REG_TX_OFFSET_LO:
> +        return s->tx_offset_lo;
> +    case CNUAS_GPU_REG_TX_OFFSET_HI:
> +        return s->tx_offset_hi;
> +    case CNUAS_GPU_REG_TX_LEN:
> +        return s->tx_len;
> +    case CNUAS_GPU_REG_RX_OFFSET_LO:
> +        return s->rx_offset_lo;
> +    case CNUAS_GPU_REG_RX_OFFSET_HI:
> +        return s->rx_offset_hi;
> +    case CNUAS_GPU_REG_RX_BUF_SIZE:
> +        return s->rx_buf_size;
> +    case CNUAS_GPU_REG_RX_LEN:
> +        return s->rx_len;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "cnuasgpu: read from unknown register 0x%"
> +                      HWADDR_PRIx "\n", addr);
> +        return 0;
> +    }
> +}
> +
> +static void cnuas_gpu_bar0_write(void *opaque, hwaddr addr,
> +                                 uint64_t value, unsigned size)
> +{
> +    CnuasGpuState *s = opaque;
> +
> +    switch (addr) {
> +    case CNUAS_GPU_REG_IRQ_STATUS:
> +        s->irq_status &= ~value;
> +        cnuas_gpu_update_irq(s);
> +        break;
> +    case CNUAS_GPU_REG_IRQ_MASK:
> +        s->irq_mask = value;
> +        cnuas_gpu_update_irq(s);
> +        break;
> +    case CNUAS_GPU_REG_TX_OFFSET_LO:
> +        s->tx_offset_lo = value;
> +        break;
> +    case CNUAS_GPU_REG_TX_OFFSET_HI:
> +        s->tx_offset_hi = value;
> +        break;
> +    case CNUAS_GPU_REG_TX_LEN:
> +        s->tx_len = value;
> +        break;
> +    case CNUAS_GPU_REG_TX_DOORBELL:
> +        if (value) {
> +            cnuas_gpu_transmit(s);
> +        }
> +        break;
> +    case CNUAS_GPU_REG_RX_OFFSET_LO:
> +        s->rx_offset_lo = value;
> +        break;
> +    case CNUAS_GPU_REG_RX_OFFSET_HI:
> +        s->rx_offset_hi = value;
> +        break;
> +    case CNUAS_GPU_REG_RX_BUF_SIZE:
> +        s->rx_buf_size = value;
> +        break;
> +    case CNUAS_GPU_REG_RX_CONSUME:
> +        if (value && s->rx_ready) {
> +            s->rx_ready = false;
> +            s->rx_len = 0;
> +            if (s->socket_fd >= 0) {
> +                qemu_set_fd_handler(s->socket_fd,
> +                                    cnuas_gpu_receive_ready, NULL, s);
> +            }
> +        }
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "cnuasgpu: write to unknown register 0x%"
> +                      HWADDR_PRIx "\n", addr);
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps cnuas_gpu_bar0_ops = {
> +    .read = cnuas_gpu_bar0_read,
> +    .write = cnuas_gpu_bar0_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +    .impl = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static void cnuas_gpu_reset_hold(Object *obj, ResetType type)
> +{
> +    CnuasGpuState *s = CNUAS_GPU(obj);
> +
> +    s->irq_status = 0;
> +    s->irq_mask = 0;
> +    s->tx_offset_lo = 0;
> +    s->tx_offset_hi = 0;
> +    s->tx_len = 0;
> +    s->rx_offset_lo = 0;
> +    s->rx_offset_hi = 0;
> +    s->rx_buf_size = 0;
> +    s->rx_len = 0;
> +    s->rx_ready = false;
> +    pci_set_irq(&s->parent_obj, 0);
> +
> +    if (s->socket_fd >= 0) {
> +        qemu_set_fd_handler(s->socket_fd, cnuas_gpu_receive_ready, NULL, s);
> +    }
> +}
> +
> +static int cnuas_gpu_post_load(void *opaque, int version_id)
> +{
> +    CnuasGpuState *s = opaque;
> +
> +    if (s->socket_fd >= 0) {
> +        qemu_set_fd_handler(s->socket_fd,
> +                            s->rx_ready ? NULL : cnuas_gpu_receive_ready,
> +                            NULL, s);
> +    }
> +    cnuas_gpu_update_irq(s);
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_cnuas_gpu = {
> +    .name = TYPE_CNUAS_GPU,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .post_load = cnuas_gpu_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_PCI_DEVICE(parent_obj, CnuasGpuState),
> +        VMSTATE_UINT32(irq_status, CnuasGpuState),
> +        VMSTATE_UINT32(irq_mask, CnuasGpuState),
> +        VMSTATE_UINT32(tx_offset_lo, CnuasGpuState),
> +        VMSTATE_UINT32(tx_offset_hi, CnuasGpuState),
> +        VMSTATE_UINT32(tx_len, CnuasGpuState),
> +        VMSTATE_UINT32(rx_offset_lo, CnuasGpuState),
> +        VMSTATE_UINT32(rx_offset_hi, CnuasGpuState),
> +        VMSTATE_UINT32(rx_buf_size, CnuasGpuState),
> +        VMSTATE_UINT32(rx_len, CnuasGpuState),
> +        VMSTATE_BOOL(rx_ready, CnuasGpuState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void cnuas_gpu_realize(PCIDevice *pdev, Error **errp)
> +{
> +    CnuasGpuState *s = CNUAS_GPU(pdev);
> +
> +    if (s->devmem_size < CNUAS_GPU_DEVMEM_MIN ||
> +        s->devmem_size > CNUAS_GPU_DEVMEM_MAX ||
> +        !is_power_of_2(s->devmem_size)) {
> +        error_setg(errp,
> +                   "cnuasgpu: devmem_size must be a power of two from "
> +                   "%llu to %llu bytes",
> +                   (unsigned long long)CNUAS_GPU_DEVMEM_MIN,
> +                   (unsigned long long)CNUAS_GPU_DEVMEM_MAX);
> +        return;
> +    }
> +
> +    pci_config_set_interrupt_pin(pdev->config, 1);
> +    if (msi_init(pdev, 0, 1, true, false, errp)) {
> +        return;
> +    }
> +    if (pcie_endpoint_cap_init(pdev, 0x80) < 0) {
> +        error_setg(errp, "cnuasgpu: cannot initialize PCIe capability");
> +        msi_uninit(pdev);
> +        return;
> +    }
> +    pcie_cap_fill_link_ep_usp(pdev, s->pcie_width, s->pcie_speed, false);
> +
> +    memory_region_init_io(&s->bar0, OBJECT(s), &cnuas_gpu_bar0_ops, s,
> +                          "cnuasgpu-bar0", CNUAS_GPU_BAR0_SIZE);
> +    pci_register_bar(pdev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->bar0);
> +
> +    memory_region_init_ram(&s->bar1, OBJECT(s), "cnuasgpu-devmem",
> +                           s->devmem_size, errp);
> +    if (*errp) {
> +        pcie_cap_exit(pdev);
> +        msi_uninit(pdev);
> +        return;
> +    }
> +    pci_register_bar(pdev, 1,
> +                     PCI_BASE_ADDRESS_SPACE_MEMORY |
> +                     PCI_BASE_ADDRESS_MEM_PREFETCH |
> +                     PCI_BASE_ADDRESS_MEM_TYPE_64,
> +                     &s->bar1);
> +
> +    s->socket_fd = -1;
> +    cnuas_gpu_connect(s);
> +}
> +
> +static void cnuas_gpu_exit(PCIDevice *pdev)
> +{
> +    CnuasGpuState *s = CNUAS_GPU(pdev);
> +
> +    cnuas_gpu_disconnect(s);
> +    pcie_cap_exit(pdev);
> +    msi_uninit(pdev);
> +}
> +
> +static const Property cnuas_gpu_properties[] = {
> +    DEFINE_PROP_UINT32("gpu_id", CnuasGpuState, gpu_id, 0),
> +    DEFINE_PROP_UINT32("sm_count", CnuasGpuState, sm_count, 16),
> +    DEFINE_PROP_UINT32("lanes_per_sm", CnuasGpuState, lanes_per_sm, 32),
> +    DEFINE_PROP_UINT32("tensor_size", CnuasGpuState, tensor_size, 16),
> +    DEFINE_PROP_SIZE("devmem_size", CnuasGpuState, devmem_size,
> +                     CNUAS_GPU_DEVMEM_DEFAULT),
> +    DEFINE_PROP_STRING("cnuaslink_socket", CnuasGpuState, link_socket),
> +    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", CnuasGpuState, pcie_speed,
> +                                PCIE_LINK_SPEED_32),
> +    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CnuasGpuState, pcie_width,
> +                                PCIE_LINK_WIDTH_16),
> +};
> +
> +static void cnuas_gpu_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +
> +    pc->realize = cnuas_gpu_realize;
> +    pc->exit = cnuas_gpu_exit;
> +    pc->vendor_id = PCI_VENDOR_ID_REDHAT;
> +    pc->device_id = PCI_DEVICE_ID_REDHAT_CNUASGPU;
> +    pc->class_id = PCI_CLASS_PROCESSOR_CO;
> +    pc->revision = CNUAS_GPU_REVISION;
> +
> +    rc->phases.hold = cnuas_gpu_reset_hold;
> +    dc->desc = "CnuasGPU virtual accelerator";
> +    dc->vmsd = &vmstate_cnuas_gpu;
> +    device_class_set_props(dc, cnuas_gpu_properties);
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +}
> +
> +static const TypeInfo cnuas_gpu_info = {
> +    .name = TYPE_CNUAS_GPU,
> +    .parent = TYPE_PCI_DEVICE,
> +    .instance_size = sizeof(CnuasGpuState),
> +    .class_init = cnuas_gpu_class_init,
> +    .interfaces = (const InterfaceInfo[]) {
> +        { INTERFACE_PCIE_DEVICE },
> +        { },
> +    },
> +};
> +
> +static void cnuas_gpu_register_types(void)
> +{
> +    type_register_static(&cnuas_gpu_info);
> +}
> +
> +type_init(cnuas_gpu_register_types)
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 9790afa104..beb3a678a5 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -1,6 +1,7 @@
>   system_ss.add(when: 'CONFIG_APPLESMC', if_true: files('applesmc.c'))
>   
>   system_ss.add(when: 'CONFIG_EDU', if_true: files('edu.c'))
> +system_ss.add(when: 'CONFIG_CNUAS_GPU', if_true: files('cnuasgpu.c'))
>   system_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('vmcoreinfo.c'))
>   system_ss.add(when: 'CONFIG_ISA_DEBUG', if_true: files('debugexit.c'))
>   system_ss.add(when: 'CONFIG_ISA_TESTDEV', if_true: files('pc-testdev.c'))


