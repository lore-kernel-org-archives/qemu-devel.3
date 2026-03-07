Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D602FC9EC3
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 03:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyi2Q-00047s-5Z; Fri, 06 Mar 2026 22:09:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vyi2O-000474-8R; Fri, 06 Mar 2026 22:09:08 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vyi2M-0000Go-1w; Fri, 06 Mar 2026 22:09:08 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62738ci1031541
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 7 Mar 2026 12:08:45 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=yFdzswCkWVALbgjV+av34rpJGNid+9YoK/8SPaihKDk=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1772852925; v=1;
 b=ItBHq47ze80K/WhCYXwqiE3JnnMS9cHqbqYjLdEMGz/Hoxk/gOF/yoW/WnBKJNxt
 qfx7O3Hl5rTNk2Hy/SGVxWaDbMhdsMYGO5LYCumu8YJAtd5X8HgElfiw+PfFlA7U
 F2rB3+DPXgc0G6vj2d36YzrtweCV+ygkrZRdrxouOpwz4aJjAFYThzzFiZa7r8Y6
 RLN4xbP8XI8PDXCpA9KwhbWhi5RovMWh2bpgzc/c+iUDyAUrEV1oqUF/7XJdznsv
 p7kNr8yjCUVRBGhORXxvNERabHKrbE52uhVY0quUVpOzxUDV68KVg0wKCrp99Qzu
 Jmf55G2pXuTUd51XjLrTNA==
Message-ID: <8908689a-f5c1-490e-925d-7a664093963f@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 7 Mar 2026 12:08:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] vmapple: apple-gfx: make it work on the latest
 macOS release
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>
References: <20260306145246.10274-1-mohamed@unpredictable.fr>
 <20260306145246.10274-2-mohamed@unpredictable.fr>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260306145246.10274-2-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/03/06 23:52, Mohamed Mediouni wrote:
> Follow changes in memory management introduced on macOS 15.4.
> 
> The legacy memory management API has been removed for the IOSurface mapper on that macOS version.
> 
> Also enable process isolation for a sandboxed GPU process when on a new OS.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   hw/display/apple-gfx-mmio.m | 62 ++++++++++++++++++++++++++++---------
>   hw/display/apple-gfx.h      | 18 +++++++++++
>   hw/display/apple-gfx.m      | 43 ++++++++++++++++++++++++-
>   3 files changed, 107 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/display/apple-gfx-mmio.m b/hw/display/apple-gfx-mmio.m
> index 58beaadd1f..323dcfe8cd 100644
> --- a/hw/display/apple-gfx-mmio.m
> +++ b/hw/display/apple-gfx-mmio.m
> @@ -19,6 +19,7 @@
>   #include "hw/core/irq.h"
>   #include "apple-gfx.h"
>   #include "trace.h"
> +#include "system/address-spaces.h"
>   
>   #import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
>   
> @@ -36,12 +37,19 @@ typedef bool(^IOSFCMapMemory)(uint64_t phys, uint64_t len, bool ro, void **va,
>   
>   @interface PGDeviceDescriptor (IOSurfaceMapper)
>   @property (readwrite, nonatomic) bool usingIOSurfaceMapper;
> +@property (readwrite, nonatomic) bool enableArgumentBuffers;
> +@property (readwrite, nonatomic) bool enableProcessIsolation;
> +@property (readwrite, nonatomic) bool enableProtectedContent;
> +
> +@property (readwrite, nonatomic, copy, nullable) PGMemoryMapDescriptor* memoryMapDescriptor;
>   @end
>   
>   @interface PGIOSurfaceHostDeviceDescriptor : NSObject
>   -(PGIOSurfaceHostDeviceDescriptor *)init;
>   @property (readwrite, nonatomic, copy, nullable) IOSFCMapMemory mapMemory;
>   @property (readwrite, nonatomic, copy, nullable) IOSFCUnmapMemory unmapMemory;
> +@property (readwrite, nonatomic, copy, nullable) PGMemoryMapDescriptor* memoryMapDescriptor;
> +@property (readwrite, nonatomic) unsigned long long mmioLength;
>   @property (readwrite, nonatomic, copy, nullable) IOSFCRaiseInterrupt raiseInterrupt;
>   @end
>   
> @@ -182,20 +190,34 @@ static bool apple_gfx_mmio_unmap_surface_memory(void *ptr)
>       PGIOSurfaceHostDeviceDescriptor *iosfc_desc =
>           [PGIOSurfaceHostDeviceDescriptor new];
>       PGIOSurfaceHostDevice *iosfc_host_dev;
> -
> -    iosfc_desc.mapMemory =
> -        ^bool(uint64_t phys, uint64_t len, bool ro, void **va, void *e, void *f) {
> -            *va = apple_gfx_mmio_map_surface_memory(phys, len, ro);
> -
> -            trace_apple_gfx_iosfc_map_memory(phys, len, ro, va, e, f, *va);
> -
> -            return *va != NULL;
> -        };
> -
> -    iosfc_desc.unmapMemory =
> -        ^bool(void *va, void *b, void *c, void *d, void *e, void *f) {
> -            return apple_gfx_mmio_unmap_surface_memory(va);
> -        };
> +    PGMemoryMapDescriptor* memory_map_descriptor;

This should be:
PGMemoryMapDescriptor *memory_map_descriptor

scripts/checkpatch.pl enforces this, but sadly this script does not 
support Objective-C.

Also, docs/devel/style.rst says "Mixed declarations (interleaving 
statements and declarations within blocks) are generally not allowed; 
declarations should be at the beginning of blocks." Moving this to the 
if block below will fix it.

> +
> +    /*
> +     * The legacy memory management API is no longer present
> +     * for the IOSurface mapper as of macOS 15.4.
> +     */
> +    if (@available(macOS 15.4, *)) {
> +        memory_map_descriptor = [PGMemoryMapDescriptor new];
> +        FlatView* fv = address_space_to_flatview(&address_space_memory);> +        flatview_for_each_range(fv, apple_gfx_register_memory_cb, 
memory_map_descriptor);
> +        /* the device model defines this as a single-page MMIO region, hence 16KB */
> +        iosfc_desc.mmioLength = 0x10000;
> +        iosfc_desc.memoryMapDescriptor = memory_map_descriptor;
> +    } else {
> +        iosfc_desc.mapMemory =
> +            ^bool(uint64_t phys, uint64_t len, bool ro, void **va, void *e, void *f) {
> +                *va = apple_gfx_mmio_map_surface_memory(phys, len, ro);
> +
> +                trace_apple_gfx_iosfc_map_memory(phys, len, ro, va, e, f, *va);
> +
> +                return *va != NULL;
> +            };
> +
> +        iosfc_desc.unmapMemory =
> +            ^bool(void *va, void *b, void *c, void *d, void *e, void *f) {
> +                return apple_gfx_mmio_unmap_surface_memory(va);
> +            };
> +    }
>   
>       iosfc_desc.raiseInterrupt = ^bool(uint32_t vector) {
>           trace_apple_gfx_iosfc_raise_irq(vector);
> @@ -223,13 +245,23 @@ static void apple_gfx_mmio_realize(DeviceState *dev, Error **errp)
>           };
>   
>           desc.usingIOSurfaceMapper = true;
> -        s->pgiosfc = apple_gfx_prepare_iosurface_host_device(s);
> +        desc.enableArgumentBuffers = true;
> +        /*
> +         * Process isolation needs PGMemoryMapDescriptor instead of
> +         * the legacy memory management interface present in releases
> +         * older than macOS 15.4.
> +         */
> +        if (@available(macOS 15.4, *)) {
> +            desc.enableProcessIsolation = true;
> +        }
>   
>           if (!apple_gfx_common_realize(&s->common, dev, desc, errp)) {
>               [s->pgiosfc release];
>               s->pgiosfc = nil;
>           }
>   
> +        s->pgiosfc = apple_gfx_prepare_iosurface_host_device(s);
> +
>           [desc release];
>           desc = nil;
>       }
> diff --git a/hw/display/apple-gfx.h b/hw/display/apple-gfx.h
> index 3197bd853d..72b360454e 100644
> --- a/hw/display/apple-gfx.h
> +++ b/hw/display/apple-gfx.h
> @@ -12,6 +12,7 @@
>   #include "system/memory.h"
>   #include "hw/core/qdev-properties.h"
>   #include "ui/surface.h"
> +#include "objc/NSObject.h"
>   
>   #define TYPE_APPLE_GFX_MMIO         "apple-gfx-mmio"
>   #define TYPE_APPLE_GFX_PCI          "apple-gfx-pci"
> @@ -23,6 +24,17 @@
>   @protocol MTLTexture;
>   @protocol MTLCommandQueue;
>   
> +typedef struct PGGuestPhysicalRange_s
> +{
> +    uint64_t physicalAddress;
> +    uint64_t physicalLength;
> +    void *hostAddress;
> +} PGGuestPhysicalRange_t;
> +
> +@interface PGMemoryMapDescriptor : NSObject
> +-(void)addRange:(PGGuestPhysicalRange_t) range;
> +@end
> +
>   typedef QTAILQ_HEAD(, PGTask_s) PGTaskList;
>   
>   typedef struct AppleGFXDisplayMode {
> @@ -68,6 +80,12 @@ void *apple_gfx_host_ptr_for_gpa_range(uint64_t guest_physical,
>                                          uint64_t length, bool read_only,
>                                          MemoryRegion **mapping_in_region);
>   
> +bool apple_gfx_register_memory_cb(Int128 start,
> +                            Int128 len,
> +                            const MemoryRegion *mr,
> +                            hwaddr offset_in_region,
> +                            void *opaque);
> +
>   extern const PropertyInfo qdev_prop_apple_gfx_display_mode;
>   
>   #endif
> diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
> index e0a765fcb1..92404d20bf 100644
> --- a/hw/display/apple-gfx.m
> +++ b/hw/display/apple-gfx.m
> @@ -21,6 +21,7 @@
>   #include "system/address-spaces.h"
>   #include "system/dma.h"
>   #include "migration/blocker.h"
> +#include "system/memory.h"
>   #include "ui/console.h"
>   #include "apple-gfx.h"
>   #include "trace.h"
> @@ -596,6 +597,37 @@ void apple_gfx_common_init(Object *obj, AppleGFXState *s, const char* obj_name)
>       /* TODO: PVG framework supports serialising device state: integrate it! */
>   }
>   
> +@interface PGDeviceDescriptor (IOSurfaceMapper)
> +@property (readwrite, nonatomic, copy, nullable) PGMemoryMapDescriptor* memoryMapDescriptor;
> +@end
> +
> +bool apple_gfx_register_memory_cb(Int128 start, Int128 len,
> +                                  const MemoryRegion *mr_const,
> +                                  hwaddr offset_in_region, void *opaque) {
> +    MemoryRegion *mr = (MemoryRegion *)mr_const;

flatview_for_each_range() should be changed to pass non-const pointers 
instead.

Regards,
Akihiko Odaki

> +    PGGuestPhysicalRange_t range;
> +    PGMemoryMapDescriptor *memory_map_descriptor = opaque;
> +    if (memory_access_is_direct(mr, true, MEMTXATTRS_UNSPECIFIED)) {
> +        range.physicalAddress = start;
> +        range.physicalLength = len;
> +        range.hostAddress = memory_region_get_ram_ptr(mr);
> +        [memory_map_descriptor addRange:range];
> +        memory_region_ref(mr);
> +    }
> +    return false;
> +}
> +
> +static void apple_gfx_register_memory(AppleGFXState *s,
> +                                                     PGDeviceDescriptor *desc)
> +{
> +    PGMemoryMapDescriptor* memoryMapDescriptor = [PGMemoryMapDescriptor new];
> +
> +    FlatView* fv = address_space_to_flatview(&address_space_memory);
> +    flatview_for_each_range(fv, apple_gfx_register_memory_cb, memoryMapDescriptor);
> +
> +    desc.memoryMapDescriptor = memoryMapDescriptor;
> +}
> +
>   static void apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
>                                                        PGDeviceDescriptor *desc)
>   {
> @@ -763,7 +795,16 @@ bool apple_gfx_common_realize(AppleGFXState *s, DeviceState *dev,
>   
>       desc.device = s->mtl;
>   
> -    apple_gfx_register_task_mapping_handlers(s, desc);
> +    /*
> +     * The legacy memory management interface doesn't allow for
> +     * vGPU sandboxing. As such, always use the new interface
> +     * on macOS 15.4 onwards.
> +     */
> +    if (@available(macOS 15.4, *)) {
> +        apple_gfx_register_memory(s, desc);
> +    } else {
> +        apple_gfx_register_task_mapping_handlers(s, desc);
> +    }
>   
>       s->cursor_show = true;
>   


