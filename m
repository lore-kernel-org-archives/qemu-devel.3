Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5ABC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 11:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqVUu-0004bH-72; Fri, 07 Mar 2025 06:04:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tqVUn-0004YB-PN
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 06:04:02 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tqVUl-00007w-4H
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 06:04:01 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tqVUh-00000000RND-2ZNg; Fri, 07 Mar 2025 12:03:55 +0100
Message-ID: <93aa0f81-06c6-4b6b-9d8b-fcae0c17f488@maciej.szmigiero.name>
Date: Fri, 7 Mar 2025 12:03:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] hw/hyperv/vmbus: common compilation unit
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: kvm@vger.kernel.org, philmd@linaro.org, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, manos.pitsidianakis@linaro.org,
 richard.henderson@linaro.org, Marcelo Tosatti <mtosatti@redhat.com>,
 alex.bennee@linaro.org
References: <20250306064118.3879213-1-pierrick.bouvier@linaro.org>
 <20250306064118.3879213-4-pierrick.bouvier@linaro.org>
 <adadeb12-9eb7-4338-828e-62e77034b1dd@maciej.szmigiero.name>
 <9ee1b0aa-27e3-47f9-8276-1158bfa5ad06@linaro.org>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <9ee1b0aa-27e3-47f9-8276-1158bfa5ad06@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Hi Pierrick,

On 6.03.2025 23:59, Pierrick Bouvier wrote:
> Hi Maciej,
> 
> we are currently working toward building a single QEMU binary able to emulate all architectures, and one prerequisite is to remove duplication of compilation units (some are duplicated per target now, because of compile time defines).
> 
> So the work here is to replace those compile time defines with runtime functions instead, so the same code can be used for various architectures.

But this is x86-only where AFAIK page size is always 4k
so is TARGET_PAGE_SIZE going away eventually or is the
QEMU policy to get rid of it at the first opportunity?
  
> Is it more clear for you?

Thanks,
Maciej

> On 3/6/25 12:29, Maciej S. Szmigiero wrote:
>> On 6.03.2025 07:41, Pierrick Bouvier wrote:
>>> Replace TARGET_PAGE.* by runtime calls.
>>
>> Seems like this patch subject/title is not aligned
>> well with its content, or a least incomplete.
>>
>> Also, could you provide more detailed information
>> why TARGET_PAGE_SIZE is getting replaced by
>> qemu_target_page_size() please?
>>
>> I don't see such information in the cover letter either.
>>
>> Thanks,
>> Maciej
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    hw/hyperv/vmbus.c     | 50 +++++++++++++++++++++----------------------
>>>    hw/hyperv/meson.build |  2 +-
>>>    2 files changed, 26 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
>>> index 12a7dc43128..109ac319caf 100644
>>> --- a/hw/hyperv/vmbus.c
>>> +++ b/hw/hyperv/vmbus.c
>>> @@ -18,7 +18,7 @@
>>>    #include "hw/hyperv/vmbus.h"
>>>    #include "hw/hyperv/vmbus-bridge.h"
>>>    #include "hw/sysbus.h"
>>> -#include "cpu.h"
>>> +#include "exec/target_page.h"
>>>    #include "trace.h"
>>>    enum {
>>> @@ -309,7 +309,7 @@ void vmbus_put_gpadl(VMBusGpadl *gpadl)
>>>    uint32_t vmbus_gpadl_len(VMBusGpadl *gpadl)
>>>    {
>>> -    return gpadl->num_gfns * TARGET_PAGE_SIZE;
>>> +    return gpadl->num_gfns * qemu_target_page_size();
>>>    }
>>>    static void gpadl_iter_init(GpadlIter *iter, VMBusGpadl *gpadl,
>>> @@ -323,14 +323,14 @@ static void gpadl_iter_init(GpadlIter *iter, VMBusGpadl *gpadl,
>>>    static inline void gpadl_iter_cache_unmap(GpadlIter *iter)
>>>    {
>>> -    uint32_t map_start_in_page = (uintptr_t)iter->map & ~TARGET_PAGE_MASK;
>>> -    uint32_t io_end_in_page = ((iter->last_off - 1) & ~TARGET_PAGE_MASK) + 1;
>>> +    uint32_t map_start_in_page = (uintptr_t)iter->map & ~qemu_target_page_mask();
>>> +    uint32_t io_end_in_page = ((iter->last_off - 1) & ~qemu_target_page_mask()) + 1;
>>>        /* mapping is only done to do non-zero amount of i/o */
>>>        assert(iter->last_off > 0);
>>>        assert(map_start_in_page < io_end_in_page);
>>> -    dma_memory_unmap(iter->as, iter->map, TARGET_PAGE_SIZE - map_start_in_page,
>>> +    dma_memory_unmap(iter->as, iter->map, qemu_target_page_size() - map_start_in_page,
>>>                         iter->dir, io_end_in_page - map_start_in_page);
>>>    }
>>> @@ -348,17 +348,17 @@ static ssize_t gpadl_iter_io(GpadlIter *iter, void *buf, uint32_t len)
>>>        assert(iter->active);
>>>        while (len) {
>>> -        uint32_t off_in_page = iter->off & ~TARGET_PAGE_MASK;
>>> -        uint32_t pgleft = TARGET_PAGE_SIZE - off_in_page;
>>> +        uint32_t off_in_page = iter->off & ~qemu_target_page_mask();
>>> +        uint32_t pgleft = qemu_target_page_size() - off_in_page;
>>>            uint32_t cplen = MIN(pgleft, len);
>>>            void *p;
>>>            /* try to reuse the cached mapping */
>>>            if (iter->map) {
>>>                uint32_t map_start_in_page =
>>> -                (uintptr_t)iter->map & ~TARGET_PAGE_MASK;
>>> -            uint32_t off_base = iter->off & ~TARGET_PAGE_MASK;
>>> -            uint32_t mapped_base = (iter->last_off - 1) & ~TARGET_PAGE_MASK;
>>> +                (uintptr_t)iter->map & ~qemu_target_page_mask();
>>> +            uint32_t off_base = iter->off & ~qemu_target_page_mask();
>>> +            uint32_t mapped_base = (iter->last_off - 1) & ~qemu_target_page_mask();
>>>                if (off_base != mapped_base || off_in_page < map_start_in_page) {
>>>                    gpadl_iter_cache_unmap(iter);
>>>                    iter->map = NULL;
>>> @@ -368,10 +368,10 @@ static ssize_t gpadl_iter_io(GpadlIter *iter, void *buf, uint32_t len)
>>>            if (!iter->map) {
>>>                dma_addr_t maddr;
>>>                dma_addr_t mlen = pgleft;
>>> -            uint32_t idx = iter->off >> TARGET_PAGE_BITS;
>>> +            uint32_t idx = iter->off >> qemu_target_page_bits();
>>>                assert(idx < iter->gpadl->num_gfns);
>>> -            maddr = (iter->gpadl->gfns[idx] << TARGET_PAGE_BITS) | off_in_page;
>>> +            maddr = (iter->gpadl->gfns[idx] << qemu_target_page_bits()) | off_in_page;
>>>                iter->map = dma_memory_map(iter->as, maddr, &mlen, iter->dir,
>>>                                           MEMTXATTRS_UNSPECIFIED);
>>> @@ -382,7 +382,7 @@ static ssize_t gpadl_iter_io(GpadlIter *iter, void *buf, uint32_t len)
>>>                }
>>>            }
>>> -        p = (void *)(uintptr_t)(((uintptr_t)iter->map & TARGET_PAGE_MASK) |
>>> +        p = (void *)(uintptr_t)(((uintptr_t)iter->map & qemu_target_page_mask()) |
>>>                    off_in_page);
>>>            if (iter->dir == DMA_DIRECTION_FROM_DEVICE) {
>>>                memcpy(p, buf, cplen);
>>> @@ -591,9 +591,9 @@ static void ringbuf_init_common(VMBusRingBufCommon *ringbuf, VMBusGpadl *gpadl,
>>>                                    uint32_t begin, uint32_t end)
>>>    {
>>>        ringbuf->as = as;
>>> -    ringbuf->rb_addr = gpadl->gfns[begin] << TARGET_PAGE_BITS;
>>> -    ringbuf->base = (begin + 1) << TARGET_PAGE_BITS;
>>> -    ringbuf->len = (end - begin - 1) << TARGET_PAGE_BITS;
>>> +    ringbuf->rb_addr = gpadl->gfns[begin] << qemu_target_page_bits();
>>> +    ringbuf->base = (begin + 1) << qemu_target_page_bits();
>>> +    ringbuf->len = (end - begin - 1) << qemu_target_page_bits();
>>>        gpadl_iter_init(&ringbuf->iter, gpadl, as, dir);
>>>    }
>>> @@ -734,7 +734,7 @@ static int vmbus_channel_notify_guest(VMBusChannel *chan)
>>>        unsigned long *int_map, mask;
>>>        unsigned idx;
>>>        hwaddr addr = chan->vmbus->int_page_gpa;
>>> -    hwaddr len = TARGET_PAGE_SIZE / 2, dirty = 0;
>>> +    hwaddr len = qemu_target_page_size() / 2, dirty = 0;
>>>        trace_vmbus_channel_notify_guest(chan->id);
>>> @@ -743,7 +743,7 @@ static int vmbus_channel_notify_guest(VMBusChannel *chan)
>>>        }
>>>        int_map = cpu_physical_memory_map(addr, &len, 1);
>>> -    if (len != TARGET_PAGE_SIZE / 2) {
>>> +    if (len != qemu_target_page_size() / 2) {
>>>            res = -ENXIO;
>>>            goto unmap;
>>>        }
>>> @@ -1038,14 +1038,14 @@ static int sgl_from_gpa_ranges(QEMUSGList *sgl, VMBusDevice *dev,
>>>            }
>>>            len -= sizeof(range);
>>> -        if (range.byte_offset & TARGET_PAGE_MASK) {
>>> +        if (range.byte_offset & qemu_target_page_mask()) {
>>>                goto eio;
>>>            }
>>>            for (; range.byte_count; range.byte_offset = 0) {
>>>                uint64_t paddr;
>>>                uint32_t plen = MIN(range.byte_count,
>>> -                                TARGET_PAGE_SIZE - range.byte_offset);
>>> +                                qemu_target_page_size() - range.byte_offset);
>>>                if (len < sizeof(uint64_t)) {
>>>                    goto eio;
>>> @@ -1055,7 +1055,7 @@ static int sgl_from_gpa_ranges(QEMUSGList *sgl, VMBusDevice *dev,
>>>                    goto err;
>>>                }
>>>                len -= sizeof(uint64_t);
>>> -            paddr <<= TARGET_PAGE_BITS;
>>> +            paddr <<= qemu_target_page_bits();
>>>                paddr |= range.byte_offset;
>>>                range.byte_count -= plen;
>>> @@ -1804,7 +1804,7 @@ static void handle_gpadl_header(VMBus *vmbus, vmbus_message_gpadl_header *msg,
>>>         * anything else and simplify things greatly.
>>>         */
>>>        if (msg->rangecount != 1 || msg->range[0].byte_offset ||
>>> -        (msg->range[0].byte_count != (num_gfns << TARGET_PAGE_BITS))) {
>>> +        (msg->range[0].byte_count != (num_gfns << qemu_target_page_bits()))) {
>>>            return;
>>>        }
>>> @@ -2240,10 +2240,10 @@ static void vmbus_signal_event(EventNotifier *e)
>>>            return;
>>>        }
>>> -    addr = vmbus->int_page_gpa + TARGET_PAGE_SIZE / 2;
>>> -    len = TARGET_PAGE_SIZE / 2;
>>> +    addr = vmbus->int_page_gpa + qemu_target_page_size() / 2;
>>> +    len = qemu_target_page_size() / 2;
>>>        int_map = cpu_physical_memory_map(addr, &len, 1);
>>> -    if (len != TARGET_PAGE_SIZE / 2) {
>>> +    if (len != qemu_target_page_size() / 2) {
>>>            goto unmap;
>>>        }
>>> diff --git a/hw/hyperv/meson.build b/hw/hyperv/meson.build
>>> index f4aa0a5ada9..c855fdcf04c 100644
>>> --- a/hw/hyperv/meson.build
>>> +++ b/hw/hyperv/meson.build
>>> @@ -1,6 +1,6 @@
>>>    specific_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
>>>    specific_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
>>> -specific_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
>>> +system_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
>>>    specific_ss.add(when: 'CONFIG_SYNDBG', if_true: files('syndbg.c'))
>>>    specific_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'))
>>>    system_ss.add(when: 'CONFIG_HV_BALLOON', if_false: files('hv-balloon-stub.c'))
>>
> 


