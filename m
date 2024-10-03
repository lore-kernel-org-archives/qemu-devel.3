Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB2FCF855A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 07:10:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swFxw-000153-Sh; Thu, 03 Oct 2024 03:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1swFxu-00014I-Ni
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 03:09:34 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1swFxp-0006Xl-Cg
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 03:09:34 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2e18aa9f06dso472790a91.0
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 00:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1727939368; x=1728544168;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CWOB7nehceDwwKSylWoYlEc1+z/XqFvL41QKwM0ivjQ=;
 b=mlaWxNTAUsbZBR5cnp5khYSEBs13/SP0z3gRJJYMXZ/pU8Doq0rJ5vkiUfvYnkcZkZ
 4tFy47L6JFKE/iwMjJqPyAmtGsZjCol5edjmx1qsr/MvznklrnNz0MzWqekYsxpDCYv+
 /xXFRvT80vL+s4ApzEa5pYe/Wi9hd4qhcAexbLpCWEIL2pdivUYbcTT9dwHkUpESi7X0
 ocIcEfh9D5ndtR36hn++tkLBR+ZcL3v5jLXWSHmGNxUDHNGPgNrirGmDxp676Hvvuj0f
 xhfqUHlhwnE5toLs6SuvunfE+awUZsdLw1pcsnlDuoH6eSRoFn2/4s06IEIaODg+RC98
 oC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727939368; x=1728544168;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CWOB7nehceDwwKSylWoYlEc1+z/XqFvL41QKwM0ivjQ=;
 b=qOMeHDHOjuyUjQdSaFc2HzRO6M42mTLroyOlSWSQqZzFUk7NZi08AIyqaT6U1wuYAV
 lMWtzJZxbpykWdTALfRUAO6mAGJxXP95zfSltDpipfb+SsjVvSLtr3d5RZotRWX5cxWT
 6ZbTc1FZaQMr755vLfT+Q7aXUUwGIkzqfeBXq6n9OW8c6ckvEZE+J68gALvEWCdUfTuh
 LiepC3SaMk/U1N3CrG+OCreSFLyfJPhfWp787tdXvWD6796ahHrwd5oE+HonUqJLd1Wb
 qzH5TYcWm2DF4WAzwyhzWT/5CBSh/UCWgFwecBsTqcUjS2Xz62PnIluYOOmXVI7CGcnn
 QhYQ==
X-Gm-Message-State: AOJu0YxVWTRaOvsg9YnFlOY83NYR7oUqAoyIyIV5e7kFjkgWawM5munL
 ldkA9jVYQ4H/T3uwBtBGgoyUKNiLNRGbA5E0/kplav00Nb0bAaEvPBbpWDIhUZU=
X-Google-Smtp-Source: AGHT+IGynqgfLUgXIRpfwU25M7JsNY9iqx0CkHnJ9JBYPJcsqYjEnBYNO1PumWcK1F/Gl3yV9szjzA==
X-Received: by 2002:a17:90b:3709:b0:2e0:7b03:1908 with SMTP id
 98e67ed59e1d1-2e1b38c7582mr3292658a91.10.1727939367733; 
 Thu, 03 Oct 2024 00:09:27 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e18f79717fsm2913504a91.24.2024.10.03.00.09.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 00:09:27 -0700 (PDT)
Message-ID: <ae0f5ef7-c714-40e1-be5a-1aa12df518c8@daynix.com>
Date: Thu, 3 Oct 2024 16:09:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/14] hw/display/apple-gfx: Introduce
 ParavirtualizedGraphics.Framework support
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org,
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 marcin.juszkiewicz@linaro.org, stefanha@redhat.com, mst@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 Alexander Graf <graf@amazon.com>
References: <20240928085727.56883-1-phil@philjordan.eu>
 <20240928085727.56883-2-phil@philjordan.eu>
 <7f3a1a60-a2f3-433c-8f2e-a2dfe0afdcb5@daynix.com>
 <CAAibmn1+Z0zcB-vQ3ZbrY0o7wtev+YtV1EOCH-4s=PfQg_Pd8A@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAAibmn1+Z0zcB-vQ3ZbrY0o7wtev+YtV1EOCH-4s=PfQg_Pd8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/10/02 22:33, Phil Dennis-Jordan wrote:
> Hi,
> 
> Thanks for taking a close look at this.
> 
> There are some further comments, explanations, and also a few questions 
> inline below. Where I've not commented, I'll just go ahead and make the 
> suggested change for v4.
> 
> On Tue, 1 Oct 2024 at 11:40, Akihiko Odaki <akihiko.odaki@daynix.com 
> <mailto:akihiko.odaki@daynix.com>> wrote:
> 
> 
>      > This patch implements a QEMU device that drives PVG for the VMApple
>      > variant of it.
> 
>     I think it is better to name it MMIO variant instead of VMApple. There
>     is nothing specific to VMApple in: hw/display/apple-gfx-vmapple.m
> 
> 
> I mean, I don't see it being useful for anything whatsoever outside the 
> vmapple machine type… But I guess there's little harm in renaming it.

I don't know but perhaps we may get vmapple2 or something in the future.

> 
> 
>      > +#include "apple-gfx.h"
>      > +#include "monitor/monitor.h"
>      > +#include "hw/sysbus.h"
>      > +#include "hw/irq.h"
>      > +#include "trace.h"
>      > +#import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
>      > +
>      > +_Static_assert(__aarch64__, "");
> 
>     I don't think this assertion is worthwhile. This assertion will trigger
>     if you accidentally remove depends on AARCH64 from Kconfig, but I don't
>     think such code change happens by accident, and there is no reason to
>     believe that this assertion won't be removed in such a case.
> 
> 
> As far as I'm aware the Kconfig AARCH64 dependency is for the /target/ 
> architecture, not the /host/ architecture? The static assert checks for 
> the latter. The PGIOSurfaceHostDeviceDescriptor type isn't available at 
> all on non-aarch64 macOS hosts. I've not had any luck with using this 
> variant of the device on x86-64 hosts simply by disabling any surface 
> mapper code.
> 
> Incidentally, if you know of a way to depend on a specific /host/ 
> architecture in the Kconfig, that would be even better. I couldn't spot 
> a way of doing that though.

I got your intention now. The correct way to do that is to check for cpu 
== 'aarch64'. Having assertion will break qemu-system-aarch64 on Intel Macs.

> 
>      > +
>      > +/*
>      > + * ParavirtualizedGraphics.Framework only ships header files for
>     the PCI
>      > + * variant which does not include IOSFC descriptors and host
>     devices. We add
>      > + * their definitions here so that we can also work with the ARM
>     version.
>      > + */
>      > +typedef bool(^IOSFCRaiseInterrupt)(uint32_t vector);
>      > +typedef bool(^IOSFCUnmapMemory)(
>      > +    void *a, void *b, void *c, void *d, void *e, void *f);
> 
>     Omit dummy parameter names.
> 
> 
>      > +@end
>      > +
>      > +typedef struct AppleGFXVmappleState {
>      > +    SysBusDevice parent_obj;
>      > +
>      > +    AppleGFXState common;
>      > +
>      > +    qemu_irq irq_gfx;
>      > +    qemu_irq irq_iosfc;
>      > +    MemoryRegion iomem_iosfc;
>      > +    PGIOSurfaceHostDevice *pgiosfc;
>      > +} AppleGFXVmappleState;
>      > +
>      > +OBJECT_DECLARE_SIMPLE_TYPE(AppleGFXVmappleState, APPLE_GFX_VMAPPLE)
>      > +
>      > +
>      > +static uint64_t apple_iosfc_read(void *opaque, hwaddr offset,
>     unsigned size)
>      > +{
>      > +    AppleGFXVmappleState *s = opaque;
>      > +    uint64_t res = 0;
>      > +
>      > +    bql_unlock();
> 
>     It is dangerous to unlock BQL at an arbitrary place. Instead of
>     unlocking, I suggest:
>     - running [s->pgiosfc mmioReadAtOffset:offset] on another thread
>     - using a bottom half to request operations that require BQL from the
>     thread running [s->pgiosfc mmioReadAtOffset:offset]
>     - calling AIO_WAIT_WHILE() to process the bottom half and to wait for
>     the completion of [s->pgiosfc mmioReadAtOffset:offset]
> 
> 
> OK, I think I see what you mean, I'll try to rework things around that 
> pattern. Any preference on how I kick off the job on the other thread? 
> As we necessarily need to use libdispatch in a bunch of places in this 
> code anyway, I guess dispatch_async() would probably be the simplest?

Perhaps so. The QEMU way is to use a bottom half with AioContext, but 
you can't simultaneously run a dispatch queue and AioContext in one 
thread so you have to use the dispatch queue if you need one.

> 
>      > +    res = [s->pgiosfc mmioReadAtOffset:offset];
>      > +    bql_lock();
>      > +
>      > +    trace_apple_iosfc_read(offset, res);
>      > +
>      > +    return res;
>      > +}
>      > +
>      > +static void apple_iosfc_write(
>      > +    void *opaque, hwaddr offset, uint64_t val, unsigned size)
>      > +{
>      > +    AppleGFXVmappleState *s = opaque;
>      > +
>      > +    trace_apple_iosfc_write(offset, val);
>      > +
>      > +    [s->pgiosfc mmioWriteAtOffset:offset value:val];
>      > +}
>      > +
>      > +static const MemoryRegionOps apple_iosfc_ops = {
>      > +    .read = apple_iosfc_read,
>      > +    .write = apple_iosfc_write,
>      > +    .endianness = DEVICE_LITTLE_ENDIAN,
>      > +    .valid = {
>      > +        .min_access_size = 4,
>      > +        .max_access_size = 8,
>      > +    },
>      > +    .impl = {
>      > +        .min_access_size = 4,
>      > +        .max_access_size = 8,
>      > +    },
>      > +};
>      > +
>      > +static PGIOSurfaceHostDevice
>     *apple_gfx_prepare_iosurface_host_device(
>      > +    AppleGFXVmappleState *s)
>      > +{
>      > +    PGIOSurfaceHostDeviceDescriptor *iosfc_desc =
>      > +        [PGIOSurfaceHostDeviceDescriptor new];
>      > +    PGIOSurfaceHostDevice *iosfc_host_dev = nil;
>      > +
>      > +    iosfc_desc.mapMemory =
>      > +        ^(uint64_t phys, uint64_t len, bool ro, void **va, void
>     *e, void *f) {
>      > +            trace_apple_iosfc_map_memory(phys, len, ro, va, e, f);
>      > +            MemoryRegion *tmp_mr;
>      > +            *va = gpa2hva(&tmp_mr, phys, len, NULL);
> 
>     Use: dma_memory_map()
> 
> 
> That doesn't seem to be a precisely equivalent operation. It also says 
> in its headerdoc,
> 
>     Use only for reads OR writes - not for read-modify-write operations.
> 
> which I don't think we can guarantee here at all.
> 
> I guess I can call it twice, once for writing and once for reading, but 
> given that the dma_memory_unmap operation marks the area dirty, I'm not 
> it's intended for what I understand the use case here to be: As far as I 
> can tell, the PV graphics device uses (some) of this memory to exchange 
> data in a cache-coherent way between host and guest, e.g. as a lock-free 
> ring buffer, using atomic operations as necessary. (This works because 
> it's a PV device: it "knows" the other end just another CPU core (or 
> even the same one) executing in a different hypervisor context.) This 
> doesn't really match "traditional" DMA patterns where there's either a 
> read or a write happening.

I think the story is a bit different for this VMApple variant. Probably 
the CPU and GPU in Apple Silicon is cache-coherent so you can map normal 
memory for GPU without any kind of cache maintenance.

Cache conherency of CPU and GPU in Apple Silicon is implied with Apple's 
documentation; it says you don't need to synchronize resources for 
MTLStorageModeShared, which is the default for Apple Silicon.
https://developer.apple.com/documentation/metal/resource_fundamentals/synchronizing_a_managed_resource_in_macos

The name "IOSurface" also implies it is used not only for e.g., ring 
buffer but also for real data.

> 
> Hunting around some more for alternative APIs, there's also 
> memory_region_get_ram_ptr(), but I'm not sure its restrictions apply 
> here either.

I think you can call memory_access_is_direct() to check if the 
requirement is satisfied.

It will still break dirty page tracking implemented by 
dma_memory_unmap() and others, but it's broken for hvf, which does not 
implement dirty page tracking either.

> 
>      > +            return (bool)true;
> 
>     Why cast?
> 
> 
> Good question. Not originally my code, so I've fixed all the instances I 
> could find now.
> 
>      > +        };
>      > +
>      > +    iosfc_desc.unmapMemory =
>      > +        ^(void *a, void *b, void *c, void *d, void *e, void *f) {
>      > +            trace_apple_iosfc_unmap_memory(a, b, c, d, e, f);
>      > +            return (bool)true;
>      > +        };
>      > +
>      > +    iosfc_desc.raiseInterrupt = ^(uint32_t vector) {
>      > +        trace_apple_iosfc_raise_irq(vector);
>      > +        bool locked = bql_locked();
>      > +        if (!locked) {
>      > +            bql_lock();
>      > +        }
>       > +        qemu_irq_pulse(s->irq_iosfc);> +        if (!locked) {
>      > +            bql_unlock();
>      > +        }
>      > +        return (bool)true;
>      > +    };
>      > +
>      > +    iosfc_host_dev =
>      > +        [[PGIOSurfaceHostDevice alloc]
>     initWithDescriptor:iosfc_desc];
>      > +    [iosfc_desc release];
>      > +    return iosfc_host_dev;
>      > +}
>      > +
>      > +static void apple_gfx_vmapple_realize(DeviceState *dev, Error
>     **errp)
>      > +{
>      > +    @autoreleasepool {
> 
>     This autoreleasepool is not used.
> 
> 
> It is definitely used inside the apple_gfx_common_realize() call. It's 
> also impossible to say whether [PGDeviceDescriptor new] uses autorelease 
> semantics internally, so it seemed safer to wrap the whole thing in an 
> outer pool.

Theoretically, It should be safe to assume the callee creates 
autoreleasepool by themselves as needed in general. We have bunch of 
code to call Objective-C APIs without creating autoreleasepool in the 
caller. Practically, [PGDeviceDescriptor new] is likely to be 
implemented with ARC, which wraps methods in autoreleasepool as necessary.

Functions that uses a method that returns autorelease resources should 
be wrapped with autoreleasepool instead of assuming the caller creates 
autoreleasepool for them.

> 
>      > +        AppleGFXVmappleState *s = APPLE_GFX_VMAPPLE(dev);
>      > +
>      > +        PGDeviceDescriptor *desc = [PGDeviceDescriptor new];
>      > +        desc.usingIOSurfaceMapper = true;
>      > +        desc.raiseInterrupt = ^(uint32_t vector) {
>      > +            bool locked;
>      > +
>      > +            trace_apple_gfx_raise_irq(vector);
>      > +            locked = bql_locked();
>      > +            if (!locked) {
>      > +                bql_lock();
>      > +            }
>      > +            qemu_irq_pulse(s->irq_gfx);
>      > +            if (!locked) {
>      > +                bql_unlock();
>      > +            }
>      > +        };
>      > +
>      > +        s->pgiosfc = apple_gfx_prepare_iosurface_host_device(s);
>      > +
>      > +        apple_gfx_common_realize(&s->common, desc);
>      > +        [desc release];
>      > +        desc = nil;
>      > +    }
>      > +}
>      > +
> 
>      > +++ b/hw/display/apple-gfx.h
>      > @@ -0,0 +1,57 @@
>      > +#ifndef QEMU_APPLE_GFX_H
>      > +#define QEMU_APPLE_GFX_H
>      > +
>      > +#define TYPE_APPLE_GFX_VMAPPLE      "apple-gfx-vmapple"
>      > +#define TYPE_APPLE_GFX_PCI          "apple-gfx-pci"
>      > +
>      > +#include "qemu/typedefs.h"
>      > +
>      > +typedef struct AppleGFXState AppleGFXState;
>      > +
>      > +void apple_gfx_common_init(Object *obj, AppleGFXState *s, const
>     char* obj_name);
>      > +
>      > +#ifdef __OBJC__
> 
>     This ifdef is unnecessary.
> 
> Ah indeed; at one point, vmapple.c was #including this file, but that's 
> no longer necessary.
> 
> 
>      > diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
>      > new file mode 100644
>      > index 00000000000..837300f9cd4
>      > --- /dev/null
>      > +++ b/hw/display/apple-gfx.m
>      > @@ -0,0 +1,536 @@
>      > +/*
>      > + * QEMU Apple ParavirtualizedGraphics.framework device
>      > + *
>      > + * Copyright © 2023 Amazon.com, Inc. or its affiliates. All
>     Rights Reserved.
>      > + *
>      > + * This work is licensed under the terms of the GNU GPL, version
>     2 or later.
>      > + * See the COPYING file in the top-level directory.
>      > + *
>      > + * ParavirtualizedGraphics.framework is a set of libraries that
>     macOS provides
>      > + * which implements 3d graphics passthrough to the host as well as a
>      > + * proprietary guest communication channel to drive it. This
>     device model
>      > + * implements support to drive that library from within QEMU.
>      > + */
>      > +
>      > +#include "apple-gfx.h"
>      > +#include "trace.h"
>      > +#include "qemu/main-loop.h"
>      > +#include "ui/console.h"
>      > +#include "monitor/monitor.h"
>      > +#include "qapi/error.h"
>      > +#include "migration/blocker.h"
>      > +#include <mach/mach_vm.h>
>      > +#import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
>      > +
>      > +static const PGDisplayCoord_t apple_gfx_modes[] = {
>      > +    { .x = 1440, .y = 1080 },
>      > +    { .x = 1280, .y = 1024 },
>      > +};
>      > +
>      > +typedef struct PGTask_s { // Name matches forward declaration in
>     PG header
> 
>     Let's name it AppleGFXTask. It is a common practice to have the same
>     tag
>     name and typedef in QEMU.
> 
> 
> This is defining a forward-declared type from framework headers which is 
> opaque from the framework's point of view. We do not get to choose its 
> struct name. The alternative is having casts wherever these objects are 
> being passed between our code and the framework. (See the original v1/v2 
> vmapple patch series for how messy this is.)

I got the idea. Let's not avoid the typedef then to clarify the naming 
is not under our control.

> 
>      > +static void apple_gfx_render_new_frame(AppleGFXState *s)
>      > +{
>      > +    BOOL r;
>      > +    void *vram = s->vram;
>      > +    uint32_t width = surface_width(s->surface);
>      > +    uint32_t height = surface_height(s->surface);
>      > +    MTLRegion region = MTLRegionMake2D(0, 0, width, height);
>      > +    id<MTLCommandBuffer> command_buffer = [s->mtl_queue
>     commandBuffer];
>      > +    id<MTLTexture> texture = s->texture;
>      > +    r = [s->pgdisp encodeCurrentFrameToCommandBuffer:command_buffer
>      > +                                             texture:texture
>      > +                                              region:region];
>      > +    if (!r) {
>      > +        return;
>      > +    }
>      > +    [texture retain];
>      > +    if (s->using_managed_texture_storage) {
>      > +        /* "Managed" textures exist in both VRAM and RAM and
>     must be synced. */
>      > +        id<MTLBlitCommandEncoder> blit = [command_buffer
>     blitCommandEncoder];
>      > +        [blit synchronizeResource:texture];
>      > +        [blit endEncoding];
>      > +    }
>      > +    [command_buffer retain];
> 
>     I don't think this call of retain is necessary. The completion handler
>     gets the command buffer via parameter, which implies the command buffer
>     is automatically retained until the completion handler finishes.
> 
> 
> I couldn't find any hard guarantees for this documented anywhere, hence 
> erring on the side of caution. I think the harm of an additional retain/ 
> release pair here is quite minor.

Apple's sample code doesn't retain for such a case so we can certainly 
omit it:
https://developer.apple.com/documentation/metal/indirect_command_encoding/encoding_indirect_command_buffers_on_the_cpu

It's better to avoid additional resource management when the underlying 
API automatically does things correct. There is a hazard of forgetting 
release anytime adding one call of retain.

> 
> 
>      > +static void apple_gfx_render_frame_completed(AppleGFXState *s,
>     void *vram,
>      > +                                             id<MTLTexture> texture)
>      > +{
>      > +    --s->pending_frames;
>      > +    assert(s->pending_frames >= 0);
>      > +
>      > +    if (vram != s->vram) {
>      > +        /* Display mode has changed, drop this old frame. */
>      > +        assert(texture != s->texture);
>      > +        g_free(vram);
> 
>     This management of buffers looks a bit convoluted. I suggest
>     remembering
>     the width and height instead of pointers and comparing them. This way
>     you can free resources in set_mode().
> 
> 
> Yeah, I suppose that works, I can change that around.
> 
>      > +    } else {
>      > +        copy_mtl_texture_to_surface_mem(texture, vram);
> 
>     Writing vram outside BQL may result in tearing.
> 
> 
> As far as I can tell(*), QXL does the same. I couldn't find any examples 
> of double-buffering in any of the existing display devices, which would 
> be the only way to do async updates efficiently and without tearing. In 
> any case, this solution is still vastly better than a regular VGA 
> device, which suffers from very visible tearing with macOS on the guest 
> side anyway. And in an ideal world, we'd pass through the rendered 
> texture directly to the Cocoa UI code rather than copying out only for 
> the CPU to draw it back into a window surface which is then passed to 
> the GPU for host side rendering. But I felt this patch is already very, 
> very large, and if anyone cares, we can fix imperfections in subsequent 
> updates.
> 
> (*)The rendering code in that device is also fairly complex, so I may be 
> misreading it.

QXL always modifies the surface with BQL. The surface is modified with 
qxl_blit(), which is called by qxl_render_update_area_unlocked(). 
qxl_render_update_area_unlocked() is called by either of 
qxl_render_update() and qxl_render_update_area_bh(). Both of them are 
called with BQL. The name includes "unlocked", but it means it is called 
without holding QXL-internal lock.

Most devices works entirely with BQL so they don't perform double 
buffering. apple-gfx can do the same.

> 
>      > +        if (s->gfx_update_requested) {
>      > +            s->gfx_update_requested = false;
>      > +            dpy_gfx_update_full(s->con);
>      > +            graphic_hw_update_done(s->con);
>       > +            s->new_frame_ready = false;
> 
>     This assignment is unnecessary as s->new_frame_ready is always false
>     when s->gfx_update_requested. If you want to make sure
>     s->gfx_update_requested and s->new_frame_ready are mutually exclusive,
>     use one enum value instead of having two bools.
> 
> 
> I'll need to refresh my memory and get back to you on this one, it's 
> been so many months since I actively worked on this code.
> 
>      > +        } else {
>      > +            s->new_frame_ready = true;
>      > +        }
>      > +    }
>      > +    if (s->pending_frames > 0) {
>      > +        apple_gfx_render_new_frame(s);
>      > +    }
>      > +}
>      > +
>      > +static void apple_gfx_fb_update_display(void *opaque)
>      > +{
>      > +    AppleGFXState *s = opaque;
>      > +
>      > +    dispatch_async(s->render_queue, ^{
>      > +        if (s->pending_frames > 0) {
> 
>     It should check for s->new_frame_ready as
>     apple_gfx_render_frame_completed() doesn't check if
>     s->pending_frames > 0 before calling graphic_hw_update_done(), which is
>     inconsistent.
> 
> 
> pending_frames is about guest-side frames that are queued to be rendered 
> by the host GPU.
> new_frame_ready being true indicates that the contents of the Qemu 
> console surface has been updated with new frame data since the last 
> gfx_update.
> gfx_update_requested indicates that gfx_update is currently awaiting an 
> async completion (graphic_hw_update_done) but the surface has not 
> received a new frame content, but the GPU is stily busy drawing one.
> 
> apple_gfx_render_frame_completed is scheduled exactly once per pending 
> frame, so pending_frames > 0 is an invariant there. (Hence the assert.)> > I don't think there is any inconsistency here, but I'll double check.
> It's possible that there's an easier way to express the state machine, 
> and I'll take a look at that.

I meant that apple_gfx_render_frame_completed() does not check if the 
frame is the last one currently pending. apple_gfx_fb_update_display() 
ignores a new ready frame when there is a more pending frame, but 
apple_gfx_render_frame_completed() unconditionally fires 
graphic_hw_update_done() even if there is a more pending frame. And I 
think apple_gfx_render_frame_completed() is right and 
apple_gfx_fb_update_display() is wrong in such a situation.

> 
>     Checking if s->pending_frames > 0 both in apple_gfx_fb_update_display()
>     and apple_gfx_render_frame_completed() is also problematic as that can
>     defer graphic_hw_update_done() indefinitely if we are getting new
>     frames
>     too fast.
> 
> 
> I see what you mean about this part. I'll have to test it, but I guess 
> we should reverse the priority, like this:
> 
>          if (s->new_frame_ready) {
>              dpy_gfx_update_full(s->con);
>              s->new_frame_ready = false;
>              graphic_hw_update_done(s->con);
>          } else if (s->pending_frames > 0) {
>              s->gfx_update_requested = true;
>          } else {
>              graphic_hw_update_done(s->con);
>          }
> 
> 1. If we already have a frame, ready to be displayed, return it immediately.
> 2. If the guest has reported that it's completed a frame and the GPU is 
> currently busy rendering it, defer graphic_hw_update_done until it's done.
> 3. If the guest reports no changes to its display, indicate this back to 
> Qemu as a no-op display update graphic_hw_update_done() with no 
> dpy_gfx_update* call.

Yes, that looks correct.

> 
>      > +            s->gfx_update_requested = true;
>      > +        } else {
>      > +            if (s->new_frame_ready) {
>      > +                dpy_gfx_update_full(s->con);
>      > +                s->new_frame_ready = false;
>      > +            }
>      > +            graphic_hw_update_done(s->con);
>       > +        }> +    });
>      > +}
>      > +
>      > +static const GraphicHwOps apple_gfx_fb_ops = {
>      > +    .gfx_update = apple_gfx_fb_update_display,
>      > +    .gfx_update_async = true,
>      > +};
>      > +
>      > +static void update_cursor(AppleGFXState *s)
>      > +{
>      > +    dpy_mouse_set(s->con, s->pgdisp.cursorPosition.x,
>      > +                  s->pgdisp.cursorPosition.y, s->cursor_show);
>      > +}
>      > +
>      > +static void set_mode(AppleGFXState *s, uint32_t width, uint32_t
>     height)
>      > +{
>      > +    void *vram = NULL;
>      > +    DisplaySurface *surface;
>      > +    MTLTextureDescriptor *textureDescriptor;
>      > +    id<MTLTexture> texture = nil;
>      > +    __block bool no_change = false;
>      > +
>      > +    dispatch_sync(s->render_queue,
> 
>     Calling dispatch_sync() while holding BQL may result in deadlock.
> 
> Only if any code executed on the same dispatch queue acquires the lock 
> either directly or transitively. I believe I have ensure this is not 
> done on the reqnder_queue, have you found anywhere this is the case?

The documentation is not clear what threads a dispatch queue runs on. We 
can have a deadlock if they lock the BQL.

> 
>      > +        ^{
>      > +            if (s->surface &&
>      > +                width == surface_width(s->surface) &&
>      > +                height == surface_height(s->surface)) {
>      > +                no_change = true;
>      > +            }
>      > +        });
>      > +
>      > +    if (no_change) {
>      > +        return;
>      > +    }
>      > +
>      > +    vram = g_malloc0(width * height * 4);
>      > +    surface = qemu_create_displaysurface_from(width, height,
>     PIXMAN_LE_a8r8g8b8,
>      > +                                              width * 4, vram);
>      > +
>      > +    @autoreleasepool {
>      > +        textureDescriptor =
>      > +            [MTLTextureDescriptor
>      > +               
>     texture2DDescriptorWithPixelFormat:MTLPixelFormatBGRA8Unorm
>      > +                                             width:width
>      > +                                            height:height
>      > +                                         mipmapped:NO];
>      > +        textureDescriptor.usage = s->pgdisp.minimumTextureUsage;
>      > +        texture = [s->mtl
>     newTextureWithDescriptor:textureDescriptor];
>      > +    }
>      > +
>      > +    s->using_managed_texture_storage =
>      > +        (texture.storageMode == MTLStorageModeManaged);
>      > +
>      > +    dispatch_sync(s->render_queue,
>      > +        ^{
>      > +            id<MTLTexture> old_texture = nil;
>      > +            void *old_vram = s->vram;
>      > +            s->vram = vram;
>      > +            s->surface = surface;
>      > +
>      > +            dpy_gfx_replace_surface(s->con, surface);
>      > +
>      > +            old_texture = s->texture;
>      > +            s->texture = texture;
>      > +            [old_texture release];
> 
>     You can just do:
>     [s->texture release];
>     s->texture = texture;
> 
>     This will make s->texture dangling between the two statements, but that
>     don't matter since s->texture is not an atomic variable that can be
>     safely observed from another thread anyway.
> 
>      > +
>      > +            if (s->pending_frames == 0) {
>      > +                g_free(old_vram);
>      > +            }
>      > +        });
>      > +}
>      > +
>      > +static void create_fb(AppleGFXState *s)
>      > +{
>      > +    s->con = graphic_console_init(NULL, 0, &apple_gfx_fb_ops, s);
>      > +    set_mode(s, 1440, 1080);
>      > +
>      > +    s->cursor_show = true;
>      > +}
>      > +
>      > +static size_t apple_gfx_get_default_mmio_range_size(void)
>      > +{
>      > +    size_t mmio_range_size;
>      > +    @autoreleasepool {
>      > +        PGDeviceDescriptor *desc = [PGDeviceDescriptor new];
>      > +        mmio_range_size = desc.mmioLength;
>      > +        [desc release];
>      > +    }
>      > +    return mmio_range_size;
>      > +}
>      > +
>      > +void apple_gfx_common_init(Object *obj, AppleGFXState *s, const
>     char* obj_name)
> 
>     This function can be merged into apple_gfx_common_realize().
> 
> 
> Probably. I'll try it.
> 
>      > +{
>      > +    Error *local_err = NULL;
>      > +    int r;
>      > +    size_t mmio_range_size =
>     apple_gfx_get_default_mmio_range_size();
>      > +
>      > +    trace_apple_gfx_common_init(obj_name, mmio_range_size);
>      > +    memory_region_init_io(&s->iomem_gfx, obj, &apple_gfx_ops, s,
>     obj_name,
>      > +                          mmio_range_size);
>      > +    s->iomem_gfx.disable_reentrancy_guard = true;
> 
>     Why do you disable reentrancy guard?
> 
> 
> Perhaps with the proposed AIO_WAIT_WHILE based I/O scheme, this won't be 
> an issue anymore, but the guard would otherwise keep dropping MMIOs 
> which immediately caused the PV graphics device to stop making progress. 
> The MMIO APIs in the PVG framework are thread- and reentrancy-safe, so 
> we certainly don't need to serialise them on our side.

It's better to understand why such reentrancy happens. Reentrancy itself 
is often a sign of bug.

> 
>      > +
>      > +    /* TODO: PVG framework supports serialising device state:
>     integrate it! */
>      > +    if (apple_gfx_mig_blocker == NULL) {
>      > +        error_setg(&apple_gfx_mig_blocker,
>      > +                  "Migration state blocked by apple-gfx display
>     device");
>      > +        r = migrate_add_blocker(&apple_gfx_mig_blocker, &local_err);
>      > +        if (r < 0) {
>      > +            error_report_err(local_err);
> 
>     Please report the error to the caller of apple_gfx_common_realize()
>     instead.
> 
>      > +        }
>      > +    }
>       > +}> +
>      > +static void
>     apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
>      > +                                                   
>       PGDeviceDescriptor *desc)
>      > +{
>      > +    desc.createTask = ^(uint64_t vmSize, void * _Nullable *
>     _Nonnull baseAddress) {
>      > +        AppleGFXTask *task = apple_gfx_new_task(s, vmSize);
>      > +        *baseAddress = (void*)task->address;
> 
>     nit: please write as (void *) instead of (void*).
> 
>      > +        trace_apple_gfx_create_task(vmSize, *baseAddress);
>      > +        return task;
>      > +    };
>      > +
> 
>      > +{
>      > +    PGDisplayDescriptor *disp_desc = [PGDisplayDescriptor new];
>      > +
>      > + disp_desc.name <http://disp_desc.name> = @"QEMU display";
>      > +    disp_desc.sizeInMillimeters = NSMakeSize(400., 300.); /* A
>     20" display */
>      > +    disp_desc.queue = dispatch_get_main_queue();
>      > +    disp_desc.newFrameEventHandler = ^(void) {
>      > +        trace_apple_gfx_new_frame();
>      > +        dispatch_async(s->render_queue, ^{
>      > +            /* Drop frames if we get too far ahead. */
>      > +            if (s->pending_frames >= 2)
>      > +                return;
>      > +            ++s->pending_frames;
>      > +            if (s->pending_frames > 1) {
>      > +                return;
>      > +            }
>      > +            @autoreleasepool {
>      > +                apple_gfx_render_new_frame(s);
>      > +            }
>      > +        });
>      > +    };
>      > +    disp_desc.modeChangeHandler = ^(PGDisplayCoord_t sizeInPixels,
>      > +                                    OSType pixelFormat) {
>      > +        trace_apple_gfx_mode_change(sizeInPixels.x, sizeInPixels.y);
>      > +        set_mode(s, sizeInPixels.x, sizeInPixels.y);
>      > +    };
>      > +    disp_desc.cursorGlyphHandler = ^(NSBitmapImageRep *glyph,
>      > +                                     PGDisplayCoord_t hotSpot) {
>      > +        uint32_t bpp = glyph.bitsPerPixel;
>      > +        size_t width = glyph.pixelsWide;
>      > +        size_t height = glyph.pixelsHigh;
>      > +        size_t padding_bytes_per_row = glyph.bytesPerRow - width
>     * 4;
>      > +        const uint8_t* px_data = glyph.bitmapData;
>      > +
>      > +        trace_apple_gfx_cursor_set(bpp, width, height);
>      > +
>      > +        if (s->cursor) {
>      > +            cursor_unref(s->cursor);
>      > +            s->cursor = NULL;
>      > +        }
>      > +
>      > +        if (bpp == 32) { /* Shouldn't be anything else, but just
>     to be safe...*/
>      > +            s->cursor = cursor_alloc(width, height);
>      > +            s->cursor->hot_x = hotSpot.x;
>      > +            s->cursor->hot_y = hotSpot.y;
>      > +
>      > +            uint32_t *dest_px = s->cursor->data;
>      > +
>      > +            for (size_t y = 0; y < height; ++y) {
>      > +                for (size_t x = 0; x < width; ++x) {
>      > +                    /* NSBitmapImageRep's red & blue channels
>     are swapped
>      > +                     * compared to QEMUCursor's. */
>      > +                    *dest_px =
>      > +                        (px_data[0] << 16u) |
>      > +                        (px_data[1] <<  8u) |
>      > +                        (px_data[2] <<  0u) |
>      > +                        (px_data[3] << 24u);
>      > +                    ++dest_px;
>      > +                    px_data += 4;
>      > +                }
>      > +                px_data += padding_bytes_per_row;
>      > +            }
>      > +            dpy_cursor_define(s->con, s->cursor);
>      > +            update_cursor(s);
>      > +        }
>      > +    };
>      > +    disp_desc.cursorShowHandler = ^(BOOL show) {
>      > +        trace_apple_gfx_cursor_show(show);
>      > +        s->cursor_show = show;
>      > +        update_cursor(s);
>      > +    };
>      > +    disp_desc.cursorMoveHandler = ^(void) {
>      > +        trace_apple_gfx_cursor_move();
>      > +        update_cursor(s);
>      > +    };
>      > +
>      > +    return disp_desc;
>      > +}
>      > +
>      > +static NSArray<PGDisplayMode*>*
>     apple_gfx_prepare_display_mode_array(void)
>      > +{
>      > +    PGDisplayMode *modes[ARRAY_SIZE(apple_gfx_modes)];
>      > +    NSArray<PGDisplayMode*>* mode_array = nil;
>      > +    int i;
>      > +
>      > +    for (i = 0; i < ARRAY_SIZE(apple_gfx_modes); i++) {
>      > +        modes[i] =
>      > +            [[PGDisplayMode alloc]
>     initWithSizeInPixels:apple_gfx_modes[i] refreshRateInHz:60.];
>      > +    }
>      > +
>      > +    mode_array = [NSArray arrayWithObjects:modes
>     count:ARRAY_SIZE(apple_gfx_modes)];
>      > +
>      > +    for (i = 0; i < ARRAY_SIZE(apple_gfx_modes); i++) {
>      > +        [modes[i] release];
>      > +        modes[i] = nil;
>      > +    }
>      > +
>      > +    return mode_array;
>      > +}
>      > +
>      > +static id<MTLDevice> copy_suitable_metal_device(void)
>      > +{
>      > +    id<MTLDevice> dev = nil;
>      > +    NSArray<id<MTLDevice>> *devs = MTLCopyAllDevices();
>      > +
>      > +    /* Prefer a unified memory GPU. Failing that, pick a non-
>     removable GPU. */
>      > +    for (size_t i = 0; i < devs.count; ++i) {
>      > +        if (devs[i].hasUnifiedMemory) {
>      > +            dev = devs[i];
>      > +            break;
>      > +        }
>      > +        if (!devs[i].removable) {
>      > +            dev = devs[i];
>      > +        }
>      > +    }
>      > +
>      > +    if (dev != nil) {
>      > +        [dev retain];
>      > +    } else {
>      > +        dev = MTLCreateSystemDefaultDevice();
>      > +    }
>      > +    [devs release];
>      > +
>      > +    return dev;
>      > +}
>      > +
>      > +void apple_gfx_common_realize(AppleGFXState *s,
>     PGDeviceDescriptor *desc)
>      > +{
>      > +    PGDisplayDescriptor *disp_desc = nil;
>      > +
>      > +    QTAILQ_INIT(&s->tasks);
>      > +    s->render_queue = dispatch_queue_create("apple-gfx.render",
>      > +                                            DISPATCH_QUEUE_SERIAL);
>      > +    s->mtl = copy_suitable_metal_device();
>      > +    s->mtl_queue = [s->mtl newCommandQueue];
>      > +
>      > +    desc.device = s->mtl;
>      > +
>      > +    apple_gfx_register_task_mapping_handlers(s, desc);
>      > +
>      > +    s->pgdev = PGNewDeviceWithDescriptor(desc);
>      > +
>      > +    disp_desc = apple_gfx_prepare_display_handlers(s);
>      > +    s->pgdisp = [s->pgdev newDisplayWithDescriptor:disp_desc
>      > +                                              port:0
>     serialNum:1234];
>      > +    [disp_desc release];
>      > +    s->pgdisp.modeList = apple_gfx_prepare_display_mode_array();
>      > +
>      > +    create_fb(s);
>      > +}
>      > diff --git a/hw/display/meson.build b/hw/display/meson.build
>      > index 7db05eace97..70d855749c0 100644
>      > --- a/hw/display/meson.build
>      > +++ b/hw/display/meson.build
>      > @@ -65,6 +65,8 @@ system_ss.add(when: 'CONFIG_ARTIST', if_true:
>     files('artist.c'))
>      >
>      >   system_ss.add(when: 'CONFIG_ATI_VGA', if_true: [files('ati.c',
>     'ati_2d.c', 'ati_dbg.c'), pixman])
>      >
>      > +system_ss.add(when: 'CONFIG_MAC_PVG',         if_true:
>     [files('apple-gfx.m'), pvg, metal])
>      > +system_ss.add(when: 'CONFIG_MAC_PVG_VMAPPLE', if_true:
>     [files('apple-gfx-vmapple.m'), pvg, metal])
>      >
>      >   if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
>      >     virtio_gpu_ss = ss.source_set()
>      > diff --git a/hw/display/trace-events b/hw/display/trace-events
>      > index 781f8a33203..1809a358e36 100644
>      > --- a/hw/display/trace-events
>      > +++ b/hw/display/trace-events
>      > @@ -191,3 +191,29 @@ dm163_bits_ppi(unsigned dest_width)
>     "dest_width : %u"
>      >   dm163_leds(int led, uint32_t value) "led %d: 0x%x"
>      >   dm163_channels(int channel, uint8_t value) "channel %d: 0x%x"
>      >   dm163_refresh_rate(uint32_t rr) "refresh rate %d"
>      > +
>      > +# apple-gfx.m
>      > +apple_gfx_read(uint64_t offset, uint64_t res)
>     "offset=0x%"PRIx64" res=0x%"PRIx64
>      > +apple_gfx_write(uint64_t offset, uint64_t val)
>     "offset=0x%"PRIx64" val=0x%"PRIx64
>      > +apple_gfx_create_task(uint32_t vm_size, void *va) "vm_size=0x%x
>     base_addr=%p"
>      > +apple_gfx_destroy_task(void *task) "task=%p"
>      > +apple_gfx_map_memory(void *task, uint32_t range_count, uint64_t
>     virtual_offset, uint32_t read_only) "task=%p range_count=0x%x
>     virtual_offset=0x%"PRIx64" read_only=%d"
>      > +apple_gfx_map_memory_range(uint32_t i, uint64_t phys_addr,
>     uint64_t phys_len) "[%d] phys_addr=0x%"PRIx64" phys_len=0x%"PRIx64
>      > +apple_gfx_remap(uint64_t retval, uint64_t source, uint64_t
>     target) "retval=%"PRId64" source=0x%"PRIx64" target=0x%"PRIx64
>      > +apple_gfx_unmap_memory(void *task, uint64_t virtual_offset,
>     uint64_t length) "task=%p virtual_offset=0x%"PRIx64" length=0x%"PRIx64
>      > +apple_gfx_read_memory(uint64_t phys_address, uint64_t length,
>     void *dst) "phys_addr=0x%"PRIx64" length=0x%"PRIx64" dest=%p"
>      > +apple_gfx_raise_irq(uint32_t vector) "vector=0x%x"
>      > +apple_gfx_new_frame(void) ""
>      > +apple_gfx_mode_change(uint64_t x, uint64_t y) "x=%"PRId64"
>     y=%"PRId64
>      > +apple_gfx_cursor_set(uint32_t bpp, uint64_t width, uint64_t
>     height) "bpp=%d width=%"PRId64" height=0x%"PRId64
>      > +apple_gfx_cursor_show(uint32_t show) "show=%d"
>      > +apple_gfx_cursor_move(void) ""
>      > +apple_gfx_common_init(const char *device_name, size_t mmio_size)
>     "device: %s; MMIO size: %zu bytes"
>      > +
>      > +# apple-gfx-vmapple.m
>      > +apple_iosfc_read(uint64_t offset, uint64_t res)
>     "offset=0x%"PRIx64" res=0x%"PRIx64
>      > +apple_iosfc_write(uint64_t offset, uint64_t val)
>     "offset=0x%"PRIx64" val=0x%"PRIx64
>      > +apple_iosfc_map_memory(uint64_t phys, uint64_t len, uint32_t ro,
>     void *va, void *e, void *f) "phys=0x%"PRIx64" len=0x%"PRIx64" ro=%d
>     va=%p e=%p f=%p"
>      > +apple_iosfc_unmap_memory(void *a, void *b, void *c, void *d,
>     void *e, void *f) "a=%p b=%p c=%p d=%p e=%p f=%p"
>      > +apple_iosfc_raise_irq(uint32_t vector) "vector=0x%x"
>      > +
>      > diff --git a/meson.build b/meson.build
>      > index 10464466ff3..f09df3f09d5 100644
>      > --- a/meson.build
>      > +++ b/meson.build
>      > @@ -741,6 +741,8 @@ socket = []
>      >   version_res = []
>      >   coref = []
>      >   iokit = []
>      > +pvg = []
>      > +metal = []
>      >   emulator_link_args = []
>      >   midl = not_found
>      >   widl = not_found
>      > @@ -762,6 +764,8 @@ elif host_os == 'darwin'
>      >     coref = dependency('appleframeworks', modules: 'CoreFoundation')
>      >     iokit = dependency('appleframeworks', modules: 'IOKit',
>     required: false)
>      >     host_dsosuf = '.dylib'
>      > +  pvg = dependency('appleframeworks', modules:
>     'ParavirtualizedGraphics')
>      > +  metal = dependency('appleframeworks', modules: 'Metal')
>      >   elif host_os == 'sunos'
>      >     socket = [cc.find_library('socket'),
>      >               cc.find_library('nsl'),
> 


