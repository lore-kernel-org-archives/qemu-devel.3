Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D75C44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 07:26:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vip4j-0003EV-46; Thu, 22 Jan 2026 02:25:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vip4h-0003Dr-08; Thu, 22 Jan 2026 02:25:51 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vip4d-0002xO-Gm; Thu, 22 Jan 2026 02:25:50 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60M7NtCH014366
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 22 Jan 2026 16:24:56 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=AMVCP6Qyra7KmdhLzni7Dyg+ZI1Su7U83NuYTR0I1/c=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1769066696; v=1;
 b=gEf9tMcBGZKmnylZU3/PKUQiUtlqz0r/E0LrfDJk9AMOXwgwKIu0ZabICtGPD+Hd
 BgtPl7k677YZadZ6Y0uHl+8dWEi/Q4gaQj3WC3Yhe9sYXUC60GXd4qJHZS+S6TzW
 tf+//j0GSjKSYJdR0iJ+d+/l68NrKH+wEPzSt1Ew2k6w+UB2F1tDgq6JpZXiuB+E
 tZougHeF9R1bZsIY3IDFbxiIoZu8eN8ASYEnA1UjmFYamEICPswbN3UvDHpKBsX9
 Cq6cwWfyTeTVna8RMAY+aGAu9pxtdT+zlMauM1CogfngcYAgT31kqxI8Ys/HSBKp
 bMPCZU9QpgPEnb4sc5DKEA==
Message-ID: <d39a4f51-5c78-45c5-bbb7-0b5af796c968@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 22 Jan 2026 16:23:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] vmapple: apple-gfx: make it work on the latest
 macOS release
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Cameron Esfahani <dirty@apple.com>
References: <20260114152220.89640-1-mohamed@unpredictable.fr>
 <20260114152220.89640-2-mohamed@unpredictable.fr>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260114152220.89640-2-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2026/01/15 0:22, Mohamed Mediouni wrote:
> Follow changes in memory management introduced on macOS 15.4.
> 
> The legacy memory management API has been removed for the IOSurface mapper on that macOS version.
> 
> Also enable process isolation for a sandboxed GPU process when on a new OS.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   hw/display/apple-gfx-mmio.m | 65 ++++++++++++++++++++++++++++---------
>   hw/display/apple-gfx.h      | 13 ++++++++
>   hw/display/apple-gfx.m      | 47 ++++++++++++++++++++++++++-
>   3 files changed, 109 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/display/apple-gfx-mmio.m b/hw/display/apple-gfx-mmio.m
> index 58beaadd1f..2031baceda 100644
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
> @@ -34,14 +35,25 @@
>   typedef bool(^IOSFCMapMemory)(uint64_t phys, uint64_t len, bool ro, void **va,
>                                 void *, void *);
>   
> +@interface PGMemoryMapDescriptor : NSObject
> +-(void)addRange:(struct PGGuestPhysicalRange_s) range;

Let's put the definition of PGGuestPhysicalRange_t before this and use it.

Also, the definitions of this interface nad that typedef are better 
moved to hw/display/apple-gfx.h to share them with:
hw/display/apple-gfx.m

> +@end
> +
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
> @@ -182,20 +194,33 @@ static bool apple_gfx_mmio_unmap_surface_memory(void *ptr)
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
> +    PGMemoryMapDescriptor* memoryMapDescriptor = [PGMemoryMapDescriptor new];

docs/devel/style.rst says "Variables are lower_case_with_underscores".

[PGMemoryMapDescriptor new] shouldn't be evaluated for old macOS.

> +
> +    /*
> +     * The legacy memory management API is no longer present
> +     * for the IOSurface mapper as of macOS 15.4.
> +     */
> +    if (@available(macOS 15.4, *)) {
> +        FlatView* fv = address_space_to_flatview(&address_space_memory);
> +        flatview_for_each_range(fv, apple_gfx_register_memory_cb, memoryMapDescriptor);
> +        /* Single-page MMIO region: 16KB */

I don't think this explains why it needs to be 0x10000. The reason, in 
my understanding, is that it is because the memory map configured in 
apple_gfx_mmio_init() requires it to have that size.

> +        iosfc_desc.mmioLength = 0x10000;
> +        iosfc_desc.memoryMapDescriptor = memoryMapDescriptor;
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
> @@ -223,13 +248,23 @@ static void apple_gfx_mmio_realize(DeviceState *dev, Error **errp)
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
> index 3197bd853d..1b94a55a7d 100644
> --- a/hw/display/apple-gfx.h
> +++ b/hw/display/apple-gfx.h
> @@ -23,6 +23,13 @@
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
>   typedef QTAILQ_HEAD(, PGTask_s) PGTaskList;
>   
>   typedef struct AppleGFXDisplayMode {
> @@ -68,6 +75,12 @@ void *apple_gfx_host_ptr_for_gpa_range(uint64_t guest_physical,
>                                          uint64_t length, bool read_only,
>                                          MemoryRegion **mapping_in_region);
>   
> +bool apple_gfx_register_memory_cb(Int128 start,
> +                            Int128 len,
> +                            const MemoryRegion *mr,
> +                            hwaddr offset_in_region,
> +                            void *opaque);

The indents are misaligned.

> +
>   extern const PropertyInfo qdev_prop_apple_gfx_display_mode;
>   
>   #endif
> diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
> index e0a765fcb1..68ca8e93b6 100644
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
> @@ -596,6 +597,41 @@ void apple_gfx_common_init(Object *obj, AppleGFXState *s, const char* obj_name)
>       /* TODO: PVG framework supports serialising device state: integrate it! */
>   }
>   
> +@interface PGMemoryMapDescriptor : NSObject
> +-(void)addRange:(struct PGGuestPhysicalRange_s) range;
> +@end
> +
> +@interface PGDeviceDescriptor (IOSurfaceMapper)
> +@property (readwrite, nonatomic, copy, nullable) PGMemoryMapDescriptor* memoryMapDescriptor;
> +@end
> +
> +bool apple_gfx_register_memory_cb(Int128 start,
> +                            Int128 len,
> +                            const MemoryRegion *mr,
> +                            hwaddr offset_in_region,
> +                            void *opaque) {
> +    PGGuestPhysicalRange_t range;
> +    PGMemoryMapDescriptor* memoryMapDescriptor = opaque;
> +    if (mr->ram) {

memory_access_is_direct() should be used instead to reject all 
incompatible memory regions.

> +        range.physicalAddress = start;
> +        range.physicalLength = len;
> +        range.hostAddress = memory_region_get_ram_ptr(mr);

This should call memory_region_ref() as apple_gfx_task_map_memory() does.

Regards,
Akihiko Odaki

> +        [memoryMapDescriptor addRange:range];
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
> @@ -763,7 +799,16 @@ bool apple_gfx_common_realize(AppleGFXState *s, DeviceState *dev,
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


