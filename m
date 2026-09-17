Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C69FC982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 21:50:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Jzg-0000hh-0X; Thu, 17 Sep 2026 17:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x7JzU-0000ei-QD
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:50:02 -0400
Received: from mr-2005g-snip6-11.eps.apple.com ([2a01:b747:3000:206::47]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x7JzQ-0002Jv-OV
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:50:00 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-1 (Postfix) with ESMTPS id
 7DBD618006D9; Thu, 17 Sep 2026 21:49:44 +0000 (UTC)
X-ICL-RepId: 01a0b158-d94d-76db-ac52-327822598e42
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0ISRMFUgddTVYNRw9YHlwUFxVBQ14IXh9MHB0OWAYSAE0KDjYGWQVeCVYDQwU2EhRdRUYDRxlXFFAbRwxVB1deXwoTAF4PD0wKOXVbcl5wQhRACyxyRgZGDjkeLw8oAV0IPApVDl8KMwpBB1l3HlwASx1XBFQfUxJVHR0LRVUSBEAIVlBUHkEEVhVsCVgGUxlX
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1789681789; x=1792273789;
 bh=oPH8yRf3jpydID1c16PByp+TNtZdO9q4+xEJwb7ts7w=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=M4+MLML3Z/12Y+P20yWc8kI0cJwfRZbEhuPSuUp4b8q93mLdLitcOdrMk47t7N5SFzU5dfQbrW2+sPR3TC+DLYKy7AsIJ3w9zNBICnE1C45vuk69s5FpOs/jUsGQAKG5FA4SEQQZZ9YUovEbscHXffkrCm7P/mx6uwhZdGx00NpfFyiyVoG09q1Pd0NjIXxf9mmaamCk5isugChB5vksyFAk8SvcppzmsXKY4egJR8hDKu89p1o+T5UFPA4Phm5LoNKxxJStTYgorXXhpbU4eNBNgmWqqTDaDQLXI8iUKE809Y81VRuOa9G+NJKxnLgY7gECrPnXtBsKuAeFzcQHZQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-1 (Postfix) with ESMTPSA id
 6DCA818003FA; Thu, 17 Sep 2026 21:49:42 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [RFC PATCH v8 05/10] vmapple: apple-gfx: make it work on the
 latest macOS release
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <47a7ca78-0dca-4469-9366-3a95e48e61a5@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 17 Sep 2026 23:49:30 +0200
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3AF6E5B2-88AE-467A-B8C3-1D98948C3944@unpredictable.fr>
References: <20260916100021.73825-1-mohamed@unpredictable.fr>
 <20260916100021.73825-6-mohamed@unpredictable.fr>
 <47a7ca78-0dca-4469-9366-3a95e48e61a5@rsg.ci.i.u-tokyo.ac.jp>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: Apple Mail (2.3901.100.1.1.11)
X-Authority-Info-Out: v=2.4 cv=UaRciaSN c=1 sm=1 tr=0 ts=6aac607b
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=XaNHVGzJZ3ayr3Wv:21 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=fVG3-rO_fp0PoH49RWEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDMxNCBTYWx0ZWRfXxSq2g4ozohrz
 nk3cuj0LenfZsX//fYtc6NSRERt5SS2YelXYcyxFmZbTOaJnO940FXZTiZu6tjoU6Wx9vO/x0mK
 /GS714t+VVZJduDSaK46Geyj7hIOMbOpbxO5tBpx8ugIykSI8RilQsWd+XoPmpVtjCoW5j77jTb
 H43ytFxCo8/rtyVwXjp6YjwFbQ86oOL6coOQ1HF7Sm/4ubVGT9cYemhDP/3D3K1AzyhQHFnI2kq
 HcUzoZe+6+tpfpNJMoiW5HEqCHI0Fbdf0J6c15pH5qjifEOQgj1trQhN3LNkj4pHJWVIZzvx5l/
 tHaot3iu9An9qygtxDhHfxXADtE4iiDWtVHgI7ICzqjT8Y3wKYp0tmqf6syTM8=
X-Proofpoint-GUID: Uh5aIShp06_t2EhsyOvyt8-_Ri6ffqpZ
X-Proofpoint-ORIG-GUID: Uh5aIShp06_t2EhsyOvyt8-_Ri6ffqpZ
X-JNJ: AAAAAAABg3k16Thz4yDLN0v3oBW73+k81sq13vY1bVHUgY7eYYnve9hoUcckFpDOo77jmbeNC3tFdhpp4vuEtWg/CikJcoiU8ZcJmLHrrRN9SiioH2NXdKcdMHbUlt/2AnB0vkLOPh3rMPwRjYIY5aD/hhugMEuS3a5cpqDmfnhsgnKURPyGUUI0DRpxqCGKmQNqBPvgdORhSSxyUNfijMWFZK8teyybZAN6pa0dNukzZ1jV0Yesw1VFJz2k7AMg8VfkCY6346L+aK+pUu/yDNQnpBGvWFopJoDikTVBdSeQNmO27ZWDwoZYYlTfaCVzLVl0mxvuX9oEhGbAGu0ut2hlY/addFl0ns7eP1zj96mpM5crM1jmYGID3yJpuxk0w4WWbvsNh/QVtAAH4k7RX50Y+WNNrQE+8sWzope3CysTicknY31EM4lzYfd1MjDhr/oGCY346S8ABTJLUm4hGcIUPe2wAEZVztzkl/G8LkiYg3e4iXYtEB/OW0Fv5mYTWLPnblsYmpJFhpp72tgz/eQgg+pifFAtXM2ZVsk9W1whrDz7CPpicPJXl558FkTfAZl2BKRzi/rEk5lUSVdPqsDoByWr69x3opyaVdytHvqyAiZIDJjKWuIpz9dXcz3jsJRM9IMCkFDF9Yt/BlMo/buN9dAtoFFylTVKSoLyTTqbJ5rfPihRgHuq+GyqHq3j64Id2sustHQjUobIauTqD0klcGsXqUrDHJzhvZRwpwGJ/yRgK+4tdDjjBGSFpnBAewPb9/h7Y/suvkPeRG5D1bRVshyoiKDSOnKMOdlRroytQd4KMrJc4gJH69FQB9DAhe1CkiKtWOfRfS1/wc/nIBaLST9V3C7zIamHpQpFbaIVUdqyGrhg+djWJNkeiv7Gp8RpyUxajtSNeQv7k5N8UG3r0OHlJ4UW8tBICpbWmwPDOfWcBP1mUOWIUzzrjqfm9DV3S8fzgCnSX+hyBtxKEmRuxpOJfuk
 TEcRisdVasOGBZbkCEnme3xKm99PCAqP+bPw6U6NhESTVGJDkdJiIGPRFVwiGe8zkMfbiSRMLdHYy0vggVJrMQ26jGINID+tgv9qqjv6KSVfqFG0YBWjktk+7nIbiaiXSEvcxXu3KM31HM8uKIYWErhJfXc6Q0MPPiAuTyqKj9YfBGDDbyISv2hG5u/6bNMZvhYow98zJZns26cGP6tgR0zC9QajIfybpBhOIybLhGJnYxhxeajkgVRo3PmzhNOCQUQmkWi6KhSLs7FMypUB/AMDSP+V8bCxpaSUzQXfnmK1+KWmwLhgG+Kyh7hruK5rPY7ULdMKDm9uQMtYPH02xb6oinLBorVNH4BX5bLMMfrmS3gamh0ovpxKepOEYpnne0A4+D5ahXVn9Ajz3l99NqAS+pj0XmouFOj5pMoizd4y+OJsmLYh3xQAaRELbm0U+ywuJgJxdXvsVi1sRMdyTf8IOFhtnZns1Wddv1Wf4EpCUFkodGTDpCKge/0TOE2HKwRFMQUNva5ecobfp1QcUmy0zwNZ+HottSQ==
Received-SPF: pass client-ip=2a01:b747:3000:206::47;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



> On 17. Sep 2026, at 22:37, Akihiko Odaki =
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>=20
> On 2026/09/16 19:00, Mohamed Mediouni wrote:
>> Follow changes in memory management introduced on macOS 15.4.
>> The legacy memory management API has been removed for the IOSurface =
mapper on that macOS version.
>> Also enable process isolation for a sandboxed GPU process when on a =
new OS.
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>>  hw/display/apple-gfx-mmio.m | 58 ++++++++++++++++++------
>>  hw/display/apple-gfx.h      | 16 +++++++
>>  hw/display/apple-gfx.m      | 90 =
++++++++++++++++++++++++++++++++-----
>>  3 files changed, 138 insertions(+), 26 deletions(-)
>> diff --git a/hw/display/apple-gfx-mmio.m =
b/hw/display/apple-gfx-mmio.m
>> index 58beaadd1f..19e2d38a1e 100644
>> --- a/hw/display/apple-gfx-mmio.m
>> +++ b/hw/display/apple-gfx-mmio.m
>> @@ -19,6 +19,7 @@
>>  #include "hw/core/irq.h"
>>  #include "apple-gfx.h"
>>  #include "trace.h"
>> +#include "system/address-spaces.h"
>>    #import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
>>  @@ -36,12 +37,19 @@ typedef bool(^IOSFCMapMemory)(uint64_t phys, =
uint64_t len, bool ro, void **va,
>>    @interface PGDeviceDescriptor (IOSurfaceMapper)
>>  @property (readwrite, nonatomic) bool usingIOSurfaceMapper;
>> +@property (readwrite, nonatomic) bool enableArgumentBuffers;
>> +@property (readwrite, nonatomic) bool enableProcessIsolation;
>> +@property (readwrite, nonatomic) bool enableProtectedContent;
>> +
>> +@property (readwrite, nonatomic, copy, nullable) =
PGMemoryMapDescriptor* memoryMapDescriptor;
>>  @end
>>    @interface PGIOSurfaceHostDeviceDescriptor : NSObject
>>  -(PGIOSurfaceHostDeviceDescriptor *)init;
>>  @property (readwrite, nonatomic, copy, nullable) IOSFCMapMemory =
mapMemory;
>>  @property (readwrite, nonatomic, copy, nullable) IOSFCUnmapMemory =
unmapMemory;
>> +@property (readwrite, nonatomic, copy, nullable) =
PGMemoryMapDescriptor* memoryMapDescriptor;
>> +@property (readwrite, nonatomic) unsigned long long mmioLength;
>>  @property (readwrite, nonatomic, copy, nullable) IOSFCRaiseInterrupt =
raiseInterrupt;
>>  @end
>>  @@ -183,19 +191,32 @@ static bool =
apple_gfx_mmio_unmap_surface_memory(void *ptr)
>>          [PGIOSurfaceHostDeviceDescriptor new];
>>      PGIOSurfaceHostDevice *iosfc_host_dev;
>>  -    iosfc_desc.mapMemory =3D
>> -        ^bool(uint64_t phys, uint64_t len, bool ro, void **va, void =
*e, void *f) {
>> -            *va =3D apple_gfx_mmio_map_surface_memory(phys, len, =
ro);
>> -
>> -            trace_apple_gfx_iosfc_map_memory(phys, len, ro, va, e, =
f, *va);
>> -
>> -            return *va !=3D NULL;
>> -        };
>> -
>> -    iosfc_desc.unmapMemory =3D
>> -        ^bool(void *va, void *b, void *c, void *d, void *e, void *f) =
{
>> -            return apple_gfx_mmio_unmap_surface_memory(va);
>> -        };
>> +    /*
>> +     * The legacy memory management API is no longer present
>> +     * for the IOSurface mapper as of macOS 15.4.
>> +     */
>> +    if (@available(macOS 15.4, *)) {
>> +        PGMemoryMapDescriptor *memory_map_descriptor =3D =
[PGMemoryMapDescriptor new];
>> +        FlatView* fv =3D =
address_space_to_flatview(&address_space_memory);
>> +        flatview_for_each_range(fv, apple_gfx_register_memory_cb, =
memory_map_descriptor);
>> +        /* the device model defines this as a single-page MMIO =
region, hence 16KB */
>> +        iosfc_desc.mmioLength =3D 0x10000;
>> +        iosfc_desc.memoryMapDescriptor =3D memory_map_descriptor;
>> +    } else {
>> +        iosfc_desc.mapMemory =3D
>> +            ^bool(uint64_t phys, uint64_t len, bool ro, void **va, =
void *e, void *f) {
>> +                *va =3D apple_gfx_mmio_map_surface_memory(phys, len, =
ro);
>> +
>> +                trace_apple_gfx_iosfc_map_memory(phys, len, ro, va, =
e, f, *va);
>> +
>> +                return *va !=3D NULL;
>> +            };
>> +
>> +        iosfc_desc.unmapMemory =3D
>> +            ^bool(void *va, void *b, void *c, void *d, void *e, void =
*f) {
>> +                return apple_gfx_mmio_unmap_surface_memory(va);
>> +            };
>> +    }
>>        iosfc_desc.raiseInterrupt =3D ^bool(uint32_t vector) {
>>          trace_apple_gfx_iosfc_raise_irq(vector);
>> @@ -223,13 +244,22 @@ static void apple_gfx_mmio_realize(DeviceState =
*dev, Error **errp)
>>          };
>>            desc.usingIOSurfaceMapper =3D true;
>> -        s->pgiosfc =3D apple_gfx_prepare_iosurface_host_device(s);
>> +        /*
>> +         * Process isolation needs PGMemoryMapDescriptor instead of
>> +         * the legacy memory management interface present in =
releases
>> +         * older than macOS 15.4.
>> +         */
>> +        if (@available(macOS 15.4, *)) {
>> +            desc.enableProcessIsolation =3D true;
>> +        }
>>            if (!apple_gfx_common_realize(&s->common, dev, desc, =
errp)) {
>>              [s->pgiosfc release];
>>              s->pgiosfc =3D nil;
>>          }
>>  +        s->pgiosfc =3D apple_gfx_prepare_iosurface_host_device(s);
>> +
>>          [desc release];
>>          desc =3D nil;
>>      }
>> diff --git a/hw/display/apple-gfx.h b/hw/display/apple-gfx.h
>> index 3197bd853d..384aee0c5f 100644
>> --- a/hw/display/apple-gfx.h
>> +++ b/hw/display/apple-gfx.h
>> @@ -12,6 +12,7 @@
>>  #include "system/memory.h"
>>  #include "hw/core/qdev-properties.h"
>>  #include "ui/surface.h"
>> +#include "objc/NSObject.h"
>>    #define TYPE_APPLE_GFX_MMIO         "apple-gfx-mmio"
>>  #define TYPE_APPLE_GFX_PCI          "apple-gfx-pci"
>> @@ -23,6 +24,17 @@
>>  @protocol MTLTexture;
>>  @protocol MTLCommandQueue;
>>  +typedef struct PGGuestPhysicalRange_s
>> +{
>> +    uint64_t physicalAddress;
>> +    uint64_t physicalLength;
>> +    void *hostAddress;
>> +} PGGuestPhysicalRange_t;
>> +
>> +@interface PGMemoryMapDescriptor : NSObject
>> +-(void)addRange:(PGGuestPhysicalRange_t) range;
>> +@end
>> +
>>  typedef QTAILQ_HEAD(, PGTask_s) PGTaskList;
>>    typedef struct AppleGFXDisplayMode {
>> @@ -68,6 +80,10 @@ void *apple_gfx_host_ptr_for_gpa_range(uint64_t =
guest_physical,
>>                                         uint64_t length, bool =
read_only,
>>                                         MemoryRegion =
**mapping_in_region);
>>  +bool apple_gfx_register_memory_cb(Int128 start, Int128 len,
>> +                                  const MemoryRegion *mr,
>> +                                  hwaddr offset_in_region, void =
*opaque);
>> +
>>  extern const PropertyInfo qdev_prop_apple_gfx_display_mode;
>>    #endif
>> diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
>> index be0061b9db..4ef8f6dbf3 100644
>> --- a/hw/display/apple-gfx.m
>> +++ b/hw/display/apple-gfx.m
>> @@ -21,6 +21,7 @@
>>  #include "system/address-spaces.h"
>>  #include "system/dma.h"
>>  #include "migration/blocker.h"
>> +#include "system/memory.h"
>>  #include "ui/console.h"
>>  #include "apple-gfx.h"
>>  #include "trace.h"
>> @@ -79,6 +80,7 @@ static dispatch_queue_t get_background_queue(void)
>>      GPtrArray *mapped_regions;
>>  };
>>  +API_OBSOLETED("Legacy ParavirtualizedGraphics", macos(11.0, 27.0, =
27.0))
>=20
> git am detected trailing whitespaces:
>=20
> $ b4 shazam 20260916100021.73825-1-mohamed@unpredictable.fr
> Looking up 20260916100021.73825-1-mohamed@unpredictable.fr
> Checking for newer revisions
> Grabbing search results from lore.kernel.org
> Analyzing 15 messages in the thread
> Looking for additional code-review trailers on lore.kernel.org
> Analyzing 94 code-review messages
> Checking attestation on all messages, may take a moment...
> ---
>  =E2=9C=93 [PATCH RFC v8 1/10] target/arm/emulate: add ISV=3D0 =
emulation library with load/store immediate
>  =E2=9C=93 [PATCH RFC v8 2/10] target/arm/emulate: add load/store =
register offset
>  =E2=9C=93 [PATCH RFC v8 3/10] target/arm/emulate: add load/store pair
>  =E2=9C=93 [PATCH RFC v8 4/10] target/arm/hvf, whpx: wire ISV=3D0 =
emulation for data aborts
>  =E2=9C=93 [PATCH RFC v8 5/10] vmapple: apple-gfx: make it work on the =
latest macOS release
>  =E2=9C=93 [PATCH RFC v8 6/10] hw/vmapple: aes: convert MAX_LEN to a =
#define
>  =E2=9C=93 [PATCH RFC v8 7/10] Revert "hw/arm: Do not build VMapple =
machine by default"
>  =E2=9C=93 [PATCH RFC v8 8/10] vmapple: add gicv2m
>  =E2=9C=93 [PATCH RFC v8 9/10] vmapple, gicv2m: add macOS compat quirk
>  =E2=9C=93 [PATCH RFC v8 10/10] hw/vmapple: virtio-blk: allow =
FileVault off
>  ---
>  =E2=9C=93 Signed: DKIM/unpredictable.fr
> ---
> Total patches: 10
> ---
> Applying: target/arm/emulate: add ISV=3D0 emulation library with =
load/store immediate
> Applying: target/arm/emulate: add load/store register offset
> Applying: target/arm/emulate: add load/store pair
> Applying: target/arm/hvf, whpx: wire ISV=3D0 emulation for data aborts
> Applying: vmapple: apple-gfx: make it work on the latest macOS release
> Applying: hw/vmapple: aes: convert MAX_LEN to a #define
> Applying: Revert "hw/arm: Do not build VMapple machine by default"
> Applying: vmapple: add gicv2m
> Applying: vmapple, gicv2m: add macOS compat quirk
> Applying: hw/vmapple: virtio-blk: allow FileVault off
> /home/me/q/var/qemu/.git/rebase-apply/patch:90: trailing whitespace.
>        /*
> /home/me/q/var/qemu/.git/rebase-apply/patch:166: trailing whitespace.
> API_OBSOLETED("Legacy ParavirtualizedGraphics", macos(11.0, 27.0, =
27.0))
> /home/me/q/var/qemu/.git/rebase-apply/patch:272: trailing whitespace.
>    /*
> /home/me/q/var/qemu/.git/rebase-apply/patch:275: trailing whitespace.
>     * on macOS 15.4 onwards.
> warning: 4 lines add whitespace errors.
>=20
>>  static PGTask_t *apple_gfx_new_task(AppleGFXState *s, uint64_t len)
>>  {
>>      mach_vm_address_t task_mem;
>> @@ -102,6 +104,7 @@ static dispatch_queue_t =
get_background_queue(void)
>>      return task;
>>  }
>>  +API_OBSOLETED("Legacy ParavirtualizedGraphics", macos(11.0, 27.0, =
27.0))
>>  static void apple_gfx_destroy_task(AppleGFXState *s, PGTask_t *task)
>>  {
>>      GPtrArray *regions =3D task->mapped_regions;
>> @@ -151,6 +154,7 @@ static void apple_gfx_destroy_task(AppleGFXState =
*s, PGTask_t *task)
>>      return host_ptr;
>>  }
>>  +API_OBSOLETED("Legacy ParavirtualizedGraphics", macos(11.0, 27.0, =
27.0))
>>  static bool apple_gfx_task_map_memory(AppleGFXState *s, PGTask_t =
*task,
>>                                        uint64_t virtual_offset,
>>                                        PGPhysicalMemoryRange_t =
*ranges,
>> @@ -207,6 +211,7 @@ static bool =
apple_gfx_task_map_memory(AppleGFXState *s, PGTask_t *task,
>>      return success;
>>  }
>>  +API_OBSOLETED("Legacy ParavirtualizedGraphics", macos(11.0, 27.0, =
27.0))
>>  static void apple_gfx_task_unmap_memory(AppleGFXState *s, PGTask_t =
*task,
>>                                          uint64_t virtual_offset, =
uint64_t length)
>>  {
>> @@ -596,6 +601,36 @@ void apple_gfx_common_init(Object *obj, =
AppleGFXState *s, const char* obj_name)
>>      /* TODO: PVG framework supports serialising device state: =
integrate it! */
>>  }
>>  +@interface PGDeviceDescriptor (IOSurfaceMapper)
>> +@property (readwrite, nonatomic, copy, nullable) =
PGMemoryMapDescriptor* memoryMapDescriptor;
>> +@end
>> +
>> +bool apple_gfx_register_memory_cb(Int128 start, Int128 len,
>> +                                  const MemoryRegion *mr,
>> +                                  hwaddr offset_in_region, void =
*opaque) {
>> +    PGGuestPhysicalRange_t range;
>> +    PGMemoryMapDescriptor *memory_map_descriptor =3D opaque;
>> +    if (memory_access_is_direct(mr, true, MEMTXATTRS_UNSPECIFIED)) {
>> +        range.physicalAddress =3D start;
>=20
> Please convert Int128 through its helpers. This assigns Int128 =
directly into the two uint64_t fields. With CONFIG_TCG_INTERPRETER, QEMU =
deliberately represents Int128 as a structure, even on hosts supporting =
native __int128. Both assignments fail compilation. A focused Clang =
check using the actual QEMU headers reproduced the incompatible-type =
errors; int128_get64() provides the intended checked conversion.
>=20
>> +        range.physicalLength =3D len;
>> +        range.hostAddress =3D memory_region_get_ram_ptr(mr);
>=20
> The FlatView slice offset, offset_in_region, needs to be honored when =
registering RAM.
>=20
> For apple-gfx-pci, ordinary PC RAM above 4 GiB aliases machine->ram =
starting at below_4g_mem_size; GPU accesses to that range now alias low =
RAM instead. Other clipped FlatView ranges have the same problem. The =
previous mapping path adds the translated offset correctly.
>=20
>> +        [memory_map_descriptor addRange:range];
>> +    }
>> +    return false;
>> +}
>> +
>> +static void apple_gfx_register_memory(AppleGFXState *s,
>> +                                                     =
PGDeviceDescriptor *desc)
>> +{
>> +    PGMemoryMapDescriptor* memoryMapDescriptor =3D =
[PGMemoryMapDescriptor new];
>> +
>> +    FlatView* fv =3D =
address_space_to_flatview(&address_space_memory);
>> +    flatview_for_each_range(fv, apple_gfx_register_memory_cb, =
memoryMapDescriptor);
>> +
>> +    desc.memoryMapDescriptor =3D memoryMapDescriptor;
>> +}
>> +
>> +API_OBSOLETED("Legacy ParavirtualizedGraphics", macos(11.0, 27.0, =
27.0))
>>  static void apple_gfx_register_task_mapping_handlers(AppleGFXState =
*s,
>>                                                       =
PGDeviceDescriptor *desc)
>>  {
>> @@ -667,16 +702,25 @@ static void new_frame_handler_bh(void *opaque)
>>          BQL_LOCK_GUARD();
>>          set_mode(s, sizeInPixels.x, sizeInPixels.y);
>>      };
>> -    disp_desc.cursorGlyphHandler =3D ^(NSBitmapImageRep *glyph,
>> -                                     PGDisplayCoord_t hotspot) {
>> -        AppleGFXSetCursorGlyphJob *job =3D g_malloc0(sizeof(*job));
>> -        job->s =3D s;
>> -        job->glyph =3D glyph;
>> -        job->hotspot =3D hotspot;
>> -        [glyph retain];
>> -        aio_bh_schedule_oneshot(qemu_get_aio_context(),
>> -                                set_cursor_glyph, job);
>> -    };
>> +
>> +    if (@available(macOS 27.0, *)) {
>> +
>> +    } else {
>> +#ifndef __MAC_27_0
>> +        disp_desc.cursorGlyphHandler =3D ^(NSBitmapImageRep *glyph,
>> +                                         PGDisplayCoord_t hotspot) {
>> +            AppleGFXSetCursorGlyphJob *job =3D =
g_malloc0(sizeof(*job));
>> +            job->s =3D s;
>> +            job->glyph =3D glyph;
>> +            job->hotspot =3D hotspot;
>> +            [glyph retain];
>> +            aio_bh_schedule_oneshot(qemu_get_aio_context(),
>> +                                    set_cursor_glyph, job);
>> +        };
>> +#else
>> +        abort();
>> +#endif
>=20
> I wonder what is this #ifdefs for. It tests SDK macro __MAC_27_0, =
whereas the surrounding @available tests the runtime OS. A binary built =
with that SDK aborts during display realization on every pre-27 host, =
including macOS 26. Older hosts also encounter explicit aborts in the =
memory/device fallback paths. Turning supported runtime fallback paths =
into unconditional process termination depending when SDK is available =
does not look correct.

Hi,

Obsoleted APIs aren=E2=80=99t accessible from a newer SDK even for =
targeting older OS versions.
The compiler blocks it even when I use an if (@available) for the newer =
version before=E2=80=A6

If you have an idea on how to work around that it=E2=80=99d be great.

>=20
> Regards,
> Akihiko Odaki
>=20
>> +    }
>>      disp_desc.cursorShowHandler =3D ^(BOOL show) {
>>          trace_apple_gfx_cursor_show(show);
>>          qatomic_set(&s->cursor_show, show);
>> @@ -763,11 +807,33 @@ bool apple_gfx_common_realize(AppleGFXState *s, =
DeviceState *dev,
>>        desc.device =3D s->mtl;
>>  -    apple_gfx_register_task_mapping_handlers(s, desc);
>> +    /*
>> +     * The legacy memory management interface doesn't allow for
>> +     * vGPU sandboxing. As such, always use the new interface
>> +     * on macOS 15.4 onwards.
>> +     */
>> +    if (@available(macOS 15.4, *)) {
>> +        apple_gfx_register_memory(s, desc);
>> +    } else {
>> +#ifndef __MAC_27_0
>> +        apple_gfx_register_task_mapping_handlers(s, desc);
>> +#else
>> +        abort();
>> +#endif
>> +    }
>>        s->cursor_show =3D true;
>>  -    s->pgdev =3D PGNewDeviceWithDescriptor(desc);
>> +    if (@available(macOS 15.2, *)) {
>> +        s->pgdev =3D PGCreateDeviceWithDescriptor(desc);
>> +    }
>> +    else {
>> +#ifndef __MAC_27_0
>> +        s->pgdev =3D PGNewDeviceWithDescriptor(desc);
>> +#else
>> +        abort();
>> +#endif
>> +    }
>>        disp_desc =3D apple_gfx_prepare_display_descriptor(s);
>>      /*



