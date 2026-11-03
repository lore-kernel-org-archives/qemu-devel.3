Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0184606A32F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 10:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QiTNc/ry;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=GN/Hae9t
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOC66-0000f1-1I; Tue, 03 Nov 2026 05:50:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOC60-0000cw-VA
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 05:50:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOC5w-0002r9-Nu
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 05:50:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793703020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S1P/TNuQuERpEWgykrKJgkkLFK4NaeGks/VarCvkYtc=;
 b=QiTNc/ryXo2b2/z8xL+NfGc33WEMvBj/kfgBBUGOICalx4Q9TJqAAPPHqJT9u3H7kUyVpm
 lp26tRIl/GT9ozWHae+qHcOB7bUJeT03azDRigjiy+cZwGV5D3Nu7V+Q5RPhf+rFr3yP53
 vsVJ8rtmomO3gufvjgAXBM0ny4tb5c0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-OJVVhOlnORyxn2QxCiX0VA-1; Tue, 03 Nov 2026 05:50:18 -0500
X-MC-Unique: OJVVhOlnORyxn2QxCiX0VA-1
X-Mimecast-MFC-AGG-ID: OJVVhOlnORyxn2QxCiX0VA_1793703017
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48e0389d6f9so2080602f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 02:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793703017; x=1794307817; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=S1P/TNuQuERpEWgykrKJgkkLFK4NaeGks/VarCvkYtc=;
 b=GN/Hae9t0YRe585jnw8hcnMMK2/sTDlVllPxZbrBNFIfTQ9KHQTNXAlll41e1eZSwq
 li7yI4iINgUok1hH0S7h0CzZ0myVPWRgCljt42JsVThaMijQVkKhuadvNJnfCuhPp7kK
 d3ba/H1KCoQnKvH16vE1BG4kEW477DgVXXWgSrVJIW4+hpPak078cf4eE8QF1pz+I5MK
 iGp/mSuX6YUIv9nzVw+OG57AzV0VX499uoP9482wG3l/mc6VLzxOhpYT+pIbM3Nm+pPY
 Y/hbvjaIEndHC8j+0PaTI71xwXWMFN4eb9EObPYSZayOc3WeT/h6mNWycQD7osRp+0bs
 ausg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793703017; x=1794307817;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S1P/TNuQuERpEWgykrKJgkkLFK4NaeGks/VarCvkYtc=;
 b=nW0V4n9yekfofV6E99zK8IFrxLQXpzavVrMFocU3t1YjXF9AE1gZiYYJ3+7cCyyMnG
 EDT1OiyCfVo8qdwbZztIZEEvd9HyeCJJDJzSurri309l6X7Zo5xjl4NAy184di0RKQ+H
 iHZT8WvZlRzhtKOubdesFlZOC2nUDR5Gai3+o1jMiZlQl2KBp6qa6hLfpXgMJKMmuHGu
 k3UtIFENB/nYKXN9LDBfYEl88y0nJ8oldYtxlMx7AUvHqMEIVs0chNAxvZ7G6paMyIK2
 QW6bxCD6J6V1hxAAQWdxz6ZImWEk5fFtA6ZnrtpNvHaaJtjQIu3Q7seL4Ek+iU5yqUgm
 RXWA==
X-Gm-Message-State: APuU4Z9MCVVCqaeueZsoO55kujwuAh84MAs4kCPoOxdygJKWILIquE6Z
 gLPKpwsd0CVXt747Tc0ZAG8K02ZFn9ErTmbIIAxwlkCpM829Gh7ZGhlwgtM3ncBd9W0zLlAuHbl
 1sPumYJ+yaakc6FRYzIDlzKI+l6gfhjRIkdRJdIx+jCaExQpVtXUUG3oO
X-Gm-Gg: AYBFou3xpCTVM5qOhS+peyHtyMviucx6iTuN58CzRTk7ldzf/EDOcVN7QnUYoZciIus
 VJ3O6XFgHcbL8dMjZIrOx/9E9hRZ6UT9T9/Y92+EBsHlKku8RjvRJLalBYGWImp63bxhOF/xHqQ
 YGpIJkoWJM90fYSkN0yUC6WGva2vcCiT/ZhtL0IxpjerQVlNQw4nTMUQe41/lJiRSrW5S4RuVFT
 GeEQSSnYs1k4tRBIGlSJrG4NUL20sAd8As1fdQGxte6dONd54U43i5iEDDLEpqikJdcf8b2/L9m
 NyuAZmL2+YWcjUm0P9W7XHW6sgXY6YDckCf6jQnRom/FlwiXU+CBug4kfc0MpDAN2TL+lQ5vYST
 mag8qVUtiLzkd4RzNNjIk4eXZIx/jmS5bebyIat2vlQ==
X-Received: by 2002:a05:6000:2610:b0:48e:3647:c35d with SMTP id
 ffacd0b85a97d-48e6e2fcdfcmr29960978f8f.21.1793703016567; 
 Tue, 03 Nov 2026 02:50:16 -0800 (PST)
X-Received: by 2002:a05:6000:2610:b0:48e:3647:c35d with SMTP id
 ffacd0b85a97d-48e6e2fcdfcmr29960901f8f.21.1793703015821; 
 Tue, 03 Nov 2026 02:50:15 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71bab1a8sm24016704f8f.57.2026.11.03.02.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 02:50:14 -0800 (PST)
Date: Tue, 3 Nov 2026 05:50:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shmuel Fomberg <shmuelfomberg@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, zhao1.liu@intel.com,
 mtosatti@redhat.com, pierrick.bouvier@oss.qualcomm.com, kvm@vger.kernel.org
Subject: Re: [PATCH] Adding support for hyper-v enlightments hv-extcalls and
 hv-memory-hint
Message-ID: <20261103044347-mutt-send-email-mst@kernel.org>
References: <20261102155804.39426-1-shmuelfomberg@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102155804.39426-1-shmuelfomberg@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks for the patch! yet something to improve:

On Mon, Nov 02, 2026 at 05:58:04PM +0200, Shmuel Fomberg wrote:
> hv-memory-hint (hypercall HvExtCallMemoryHeatHint) allow a guest to
> notify host which memory pages will be needed in the near future.
> This is not a replacement for the balloon functionality, but can
> help the kernel

given this is supposed to be an optimization, I expect to see
some performance numbers showing it actually helps, and some
documentation explaining when it does and when it doesn't.

e.g. does it work with vhost-user (shmem)? hugetlb?

pls document which configs were tested, with linux and windows guests.

> make better decisions when memory is scare.

scarse?

> 
> Signed-off-by: Shmuel Fomberg <shmuelfomberg@gmail.com>
> ---
>  docs/system/i386/hyperv.rst      |  14 +++
>  hw/hyperv/hyperv.c               | 158 +++++++++++++++++++++++++++++++
>  include/hw/hyperv/hyperv-proto.h |  25 +++++
>  include/hw/hyperv/hyperv.h       |  13 +++
>  include/qemu/madvise.h           |   7 ++
>  target/i386/cpu.c                |   3 +
>  target/i386/cpu.h                |   2 +
>  target/i386/kvm/hyperv-proto.h   |   1 +
>  target/i386/kvm/hyperv.c         |  24 +++++
>  target/i386/kvm/kvm.c            |   7 ++
>  10 files changed, 254 insertions(+)
> 
> diff --git a/docs/system/i386/hyperv.rst b/docs/system/i386/hyperv.rst
> index e1babffb0f..1e164f1863 100644
> --- a/docs/system/i386/hyperv.rst
> +++ b/docs/system/i386/hyperv.rst
> @@ -259,6 +259,15 @@ Existing enlightenments
>  
>    Recommended: ``hv-evmcs`` (Intel)
>  
> +``hv-extcalls``
> +  Advertises extended Hyper-V hypercalls (call codes 0x8000 and above) to
> +  the guest.
> +
> +``hv-memory-hint``
> +  Enables guest memory heat hints (HvExtCallMemoryHeatHint).
> +
> +  Requires: ``hv-extcalls``
> +
>  Supplementary features
>  ----------------------
>  
> @@ -276,6 +285,11 @@ Supplementary features
>    Windows guests from booting when used without proper configuration. If needed,
>    ``hv-syndbg`` can be enabled additionally.
>  
> +  Note: ``hv-passthrough`` enables ``hv-extcalls`` when the host KVM advertises
> +  it. It does not enable ``hv-memory-hint``, which is implemented in QEMU and
> +  has no KVM CPUID bit. Enable ``hv-memory-hint`` explicitly when guest heat
> +  hints should reach the host.
> +

I'm not sure what all this means.
"KVM CPUID" is also obscure.

Can you pls rewrite? Maybe along the lines of:

if .... and .... then ... results in ...
if .... and .... then ... is ignored




>    Note: ``hv-passthrough`` effectively prevents migration as the list of enabled
>    enlightenments may differ between target and destination hosts.
>  
> diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
> index 900ff80213..b3fce7b563 100644
> --- a/hw/hyperv/hyperv.c
> +++ b/hw/hyperv/hyperv.c
> @@ -20,7 +20,9 @@
>  #include "system/physmem.h"
>  #include "qemu/bitops.h"
>  #include "qemu/error-report.h"
> +#include "qemu/int128.h"
>  #include "qemu/lockable.h"
> +#include "qemu/madvise.h"
>  #include "qemu/queue.h"
>  #include "qemu/rcu.h"
>  #include "qemu/rcu_queue.h"
> @@ -646,6 +648,162 @@ unmap:
>      return ret;
>  }
>  
> +uint16_t hyperv_hcall_ext_capabilities(uint64_t outgpa, bool fast,
> +                                       bool memory_hint)
> +{
> +    uint16_t ret;
> +    hwaddr len;
> +    uint64_t *caps = NULL;
> +
> +    if (fast) {
> +        return HV_STATUS_INVALID_HYPERCALL_CODE;
> +    }
> +    if (outgpa & (__alignof__(*caps) - 1)) {
> +        return HV_STATUS_INVALID_ALIGNMENT;
> +    }
> +
> +    len = sizeof(*caps);
> +    caps = physical_memory_map(outgpa, &len, 1);
> +    if (!caps || len < sizeof(*caps)) {
> +        ret = HV_STATUS_INSUFFICIENT_MEMORY;
> +        goto unmap;
> +    }
> +
> +    *caps = 0;
> +    if (memory_hint) {
> +        *caps = HV_EXT_CAP_MEMORY_HEAT_HINT;
> +        if (QEMU_MADV_COLD != QEMU_MADV_INVALID) {
> +            *caps |= HV_EXT_CAP_MEMORY_HEAT_HINT_COLD;
> +        }
> +    }
> +    ret = HV_STATUS_SUCCESS;
> +
> +unmap:
> +    if (caps) {
> +        physical_memory_unmap(caps, len, 1, ret == HV_STATUS_SUCCESS ? len : 0);
> +    }
> +    return ret;
> +}
> +
> +static bool hv_decode_gpa_page_range(uint64_t raw, hwaddr *gpa, hwaddr *len)
> +{
> +    uint64_t pages = (raw & HV_GPA_PAGE_RANGE_ADDITIONAL_MASK) + 1;

shouldn't we check alignment and error out rather than force it?


> +
> +    if (raw & HV_GPA_PAGE_RANGE_LARGEPAGE) {
> +        if (raw & HV_GPA_PAGE_RANGE_PAGE_SIZE_1GB) {
> +            *gpa = raw & HV_GPA_PAGE_RANGE_1G_GPA_MASK;
> +            *len = pages << 30;
> +        } else {
> +            *gpa = raw & HV_GPA_PAGE_RANGE_2M_GPA_MASK;
> +            *len = pages << 21;
> +        }
> +    } else {
> +        *gpa = raw & HV_GPA_PAGE_RANGE_4K_GPA_MASK;
> +        *len = pages << 12;
> +    }
> +
> +    return *len != 0;

how can len be 0?




> +}
> +
> +static void hv_madvise_gpa_range(hwaddr gpa, hwaddr len, int advice)
> +{
> +    while (len) {
> +        MemoryRegionSection section;
> +        hwaddr chunk, start, skip;
> +        void *host;
> +
> +        section = memory_region_find(get_system_memory(), gpa, len);
> +        if (!section.mr) {
> +            break;

why break? we could have an unmapped hole followed by a mapped one.

> +        }
> +
> +        start = section.offset_within_address_space;
> +        chunk = int128_get64(section.size);
> +
> +        if (!chunk || start < gpa) {


is this dead code? we got the mr from find can start be before?

> +            memory_region_unref(section.mr);
> +            break;
> +        }
> +
> +        skip = start - gpa;
> +        if (skip >= len || chunk > len - skip) {

can this trigger? or more dead code?

> +            memory_region_unref(section.mr);
> +            break;
> +        }
> +
> +        gpa = start + chunk;
> +        len -= skip + chunk;
> +
> +        if (memory_region_is_ram(section.mr) &&
> +            !memory_region_is_rom(section.mr) &&
> +            !memory_region_is_romd(section.mr)) {
> +            host = memory_region_get_ram_ptr(section.mr) +
> +                   section.offset_within_region;
> +            qemu_madvise(host, chunk, advice);
> +        }
> +        memory_region_unref(section.mr);
> +    }
> +}
> +
> +uint16_t hyperv_hcall_memory_hint(uint64_t in_gpa, uint16_t rep_count,
> +                                  bool fast)
> +{
> +    uint16_t ret = HV_STATUS_SUCCESS;
> +    hwaddr in_len, needed;
> +    struct hyperv_memory_heat_hint *in = NULL;
> +    unsigned int i;
> +    uint64_t heat_type;
> +    int advice;
> +
> +    if (fast) {
> +        return HV_STATUS_INVALID_HYPERCALL_CODE;
> +    }
> +    if (rep_count < 1 || rep_count > HV_EXT_MEMORY_HEAT_HINT_MAX_RANGES) {
> +        return HV_STATUS_INVALID_HYPERCALL_INPUT;
> +    }
> +    if (in_gpa & (__alignof__(*in) - 1)) {
> +        return HV_STATUS_INVALID_ALIGNMENT;
> +    }
> +
> +    needed = sizeof(in->heat_type) + sizeof(in->ranges[0]) * rep_count;
> +    in_len = TARGET_PAGE_SIZE;
> +    in = physical_memory_map(in_gpa, &in_len, 0);
> +    if (!in || in_len < needed) {
> +        ret = HV_STATUS_INSUFFICIENT_MEMORY;
> +        goto unmap;

needed can be 4096 with rep_count 511, can it not? if the input
is not page aligned or end of page is not ram, will this not fail?
why not just map needed bytes?

> +    }
> +
> +    heat_type = in->heat_type & 3;

I would add
	#define HV_EXTMEM_HEAT_HINT_MASK      3
or
	(HV_EXTMEM_HEAT_HINT_HOT|HV_EXTMEM_HEAT_HINT_COLD|HV_EXTMEM_HEAT_HINT_COLD_DISCARD)

also are you really supposed to just ignore rest of bits?
add a code comment explaining why.


> +    switch (heat_type) {
> +    case HV_EXTMEM_HEAT_HINT_HOT:
> +        advice = QEMU_MADV_WILLNEED;
> +        break;
> +    case HV_EXTMEM_HEAT_HINT_COLD:
> +    case HV_EXTMEM_HEAT_HINT_COLD_DISCARD:
> +        advice = QEMU_MADV_COLD;
> +        break;
> +    default:
> +        ret = HV_STATUS_INVALID_PARAMETER;
> +        goto unmap;
> +    }

Pls document what are these things supposed to do, with code comments.

For example "discard" sounds like MADV_DONTNEED, MADV_REMOVE or
MADV_FREE or a combination of these to me?

"COLD" sounds kinda like MADV_COLD but there's also MADV_PAGEOUT
which is same but more aggressive.



> +
> +    for (i = 0; i < rep_count; i++) {
> +        hwaddr gpa, len;
> +        uint64_t raw = in->ranges[i];
> +
> +        if (!hv_decode_gpa_page_range(raw, &gpa, &len)) {
> +            continue;

what's the point of this? does it ever trigger?

> +        }
> +        hv_madvise_gpa_range(gpa, len, advice);
> +    }
> +
> +unmap:
> +    if (in) {
> +        physical_memory_unmap(in, in_len, 0, 0);
> +    }
> +    return ret;
> +}
> +
>  static int set_event_flag_handler(uint32_t conn_id, EventNotifier *notifier)
>  {
>      int ret;
> diff --git a/include/hw/hyperv/hyperv-proto.h b/include/hw/hyperv/hyperv-proto.h
> index fffc5ce342..67e6f72a90 100644
> --- a/include/hw/hyperv/hyperv-proto.h
> +++ b/include/hw/hyperv/hyperv-proto.h
> @@ -35,7 +35,32 @@
>  #define HV_POST_DEBUG_DATA                    0x0069
>  #define HV_RETRIEVE_DEBUG_DATA                0x006a
>  #define HV_RESET_DEBUG_SESSION                0x006b
> +#define HV_EXT_CALL_QUERY_CAPABILITIES        0x8001
> +#define HV_EXT_CALL_MEMORY_HEAT_HINT          0x8003
>  #define HV_HYPERCALL_FAST                     (1u << 16)
> +#define HV_HYPERCALL_REP_COMP_OFFSET          32
> +#define HV_HYPERCALL_REP_COMP_MASK            0xfff
> +
> +#define HV_EXT_CAP_MEMORY_HEAT_HINT           (1ull << 1)
> +#define HV_EXT_CAP_MEMORY_HEAT_HINT_COLD      (1ull << 2)

Here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/include/hyperv/hvgdk_ext.h


I see:
#define HV_EXT_CAPABILITY_MEMORY_COLD_DISCARD_HINT BIT(8)



> +#define HV_EXT_MEMORY_HEAT_HINT_MAX_RANGES    511
> +
> +#define HV_EXTMEM_HEAT_HINT_COLD              0
> +#define HV_EXTMEM_HEAT_HINT_HOT               1
> +#define HV_EXTMEM_HEAT_HINT_COLD_DISCARD      2
> +
> +struct hyperv_memory_heat_hint {
> +    uint64_t heat_type;
> +    uint64_t ranges[HV_EXT_MEMORY_HEAT_HINT_MAX_RANGES];
> +};
> +
> +/* HV_GPA_PAGE_RANGE in each heat-hint range qword */
> +#define HV_GPA_PAGE_RANGE_ADDITIONAL_MASK     0x7ffull
> +#define HV_GPA_PAGE_RANGE_LARGEPAGE           (1ull << 11)
> +#define HV_GPA_PAGE_RANGE_PAGE_SIZE_1GB       (1ull << 12)
> +#define HV_GPA_PAGE_RANGE_4K_GPA_MASK         (~0xfffull)
> +#define HV_GPA_PAGE_RANGE_2M_GPA_MASK         (~0x1fffffull)
> +#define HV_GPA_PAGE_RANGE_1G_GPA_MASK         (~0x3fffffffull)
>  

Can you try to move the linux bits out to a uapi file and import from there,
instead of duplicating?

>  /*
>   * Message size
> diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
> index 23091301d0..8cccbb91ba 100644
> --- a/include/hw/hyperv/hyperv.h
> +++ b/include/hw/hyperv/hyperv.h
> @@ -70,6 +70,19 @@ uint16_t hyperv_hcall_post_message(uint64_t param, bool fast);
>   * the connection as specified in @param.
>   */
>  uint16_t hyperv_hcall_signal_event(uint64_t param, bool fast);
> +/*
> + * Process HV_EXT_CALL_QUERY_CAPABILITIES hypercall: list supported ext hcall
> + * fill the capabilities bit array in @outgpa.
> + */
> +uint16_t hyperv_hcall_ext_capabilities(uint64_t outgpa, bool fast,
> +                                       bool memory_hint);
> +/*
> + * Process HV_EXT_CALL_MEMORY_HEAT_HINT hypercall: receive a list of hot/cold
> + * pages and call madvice on them.


madvise

> + */
> +uint16_t hyperv_hcall_memory_hint(uint64_t in_gpa, uint16_t rep_count,
> +                                  bool fast);
> +
>  
>  static inline uint32_t hyperv_vp_index(CPUState *cs)
>  {
> diff --git a/include/qemu/madvise.h b/include/qemu/madvise.h
> index e155f59a0d..fd638c2254 100644
> --- a/include/qemu/madvise.h
> +++ b/include/qemu/madvise.h
> @@ -59,6 +59,11 @@
>  #else
>  #define QEMU_MADV_POPULATE_WRITE QEMU_MADV_INVALID
>  #endif
> +#ifdef MADV_COLD
> +#define QEMU_MADV_COLD MADV_COLD
> +#else
> +#define QEMU_MADV_COLD QEMU_MADV_INVALID
> +#endif
>  
>  #elif defined(CONFIG_POSIX_MADVISE)
>  
> @@ -73,6 +78,7 @@
>  #define QEMU_MADV_NOHUGEPAGE  QEMU_MADV_INVALID
>  #define QEMU_MADV_REMOVE QEMU_MADV_DONTNEED
>  #define QEMU_MADV_POPULATE_WRITE QEMU_MADV_INVALID
> +#define QEMU_MADV_COLD QEMU_MADV_INVALID
>  
>  #else /* no-op */
>  
> @@ -87,6 +93,7 @@
>  #define QEMU_MADV_NOHUGEPAGE  QEMU_MADV_INVALID
>  #define QEMU_MADV_REMOVE QEMU_MADV_INVALID
>  #define QEMU_MADV_POPULATE_WRITE QEMU_MADV_INVALID
> +#define QEMU_MADV_COLD QEMU_MADV_INVALID
>  
>  #endif
>  
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index e65eca0459..263523d052 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -10824,6 +10824,9 @@ static const Property x86_cpu_properties[] = {
>                        HYPERV_FEAT_TLBFLUSH_EXT, 0),
>      DEFINE_PROP_BIT64("hv-tlbflush-direct", X86CPU, hyperv_features,
>                        HYPERV_FEAT_TLBFLUSH_DIRECT, 0),
> +    DEFINE_PROP_BIT64("hv-extcalls", X86CPU, hyperv_features,
> +                      HYPERV_FEAT_EXT_HYPERCALLS, 0),
> +    DEFINE_PROP_BOOL("hv-memory-hint", X86CPU, hyperv_memory_hint, false),
>      DEFINE_PROP_ON_OFF_AUTO("hv-no-nonarch-coresharing", X86CPU,
>                              hyperv_no_nonarch_cs, ON_OFF_AUTO_OFF),
>  #ifdef CONFIG_SYNDBG
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 3945e90371..3c9da61e17 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1489,6 +1489,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
>  #define HYPERV_FEAT_XMM_INPUT           18
>  #define HYPERV_FEAT_TLBFLUSH_EXT        19
>  #define HYPERV_FEAT_TLBFLUSH_DIRECT     20
> +#define HYPERV_FEAT_EXT_HYPERCALLS      21
>  
>  #ifndef HYPERV_SPINLOCK_NEVER_NOTIFY
>  #define HYPERV_SPINLOCK_NEVER_NOTIFY             0xFFFFFFFF
> @@ -2374,6 +2375,7 @@ struct ArchCPU {
>      uint32_t hyperv_spinlock_attempts;
>      char *hyperv_vendor;
>      uint64_t hyperv_features;
> +    bool hyperv_memory_hint;
>      bool hyperv_passthrough;
>      OnOffAuto hyperv_no_nonarch_cs;
>      uint32_t hyperv_vendor_id[3];
> diff --git a/target/i386/kvm/hyperv-proto.h b/target/i386/kvm/hyperv-proto.h
> index a9f056f2f3..e88913fd37 100644
> --- a/target/i386/kvm/hyperv-proto.h
> +++ b/target/i386/kvm/hyperv-proto.h
> @@ -66,6 +66,7 @@
>   * HV_CPUID_FEATURES.EBX bits
>   */
>  #define HV_PARTITION_DEBUGGING_ALLOWED          (1u << 12)
> +#define HV_ENABLE_EXTENDED_HYPERCALLS           (1u << 20)
>  
>  /*
>   * HV_CPUID_ENLIGHTMENT_INFO.EAX bits
> diff --git a/target/i386/kvm/hyperv.c b/target/i386/kvm/hyperv.c
> index 420c76b5ff..9d97f5cb4e 100644
> --- a/target/i386/kvm/hyperv.c
> +++ b/target/i386/kvm/hyperv.c
> @@ -97,6 +97,13 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
>          bool fast = exit->u.hcall.input & HV_HYPERCALL_FAST;
>          uint64_t in_param = exit->u.hcall.params[0];
>          uint64_t out_param = exit->u.hcall.params[1];
> +        uint64_t rep_count = (exit->u.hcall.input >> 32) & 0xFFF;
> +
> +        if ((code & 0x8000) &&
> +            !hyperv_feat_enabled(cpu, HYPERV_FEAT_EXT_HYPERCALLS)) {
> +            exit->u.hcall.result = HV_STATUS_INVALID_HYPERCALL_CODE;
> +            return 0;
> +        }
>  
>          switch (code) {
>          case HV_POST_MESSAGE:
> @@ -117,6 +124,23 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
>              exit->u.hcall.result =
>                  hyperv_hcall_reset_dbg_session(out_param);
>              break;
> +        case HV_EXT_CALL_QUERY_CAPABILITIES:
> +            exit->u.hcall.result = hyperv_hcall_ext_capabilities(
> +                out_param, fast, cpu->hyperv_memory_hint);
> +            break;
> +        case HV_EXT_CALL_MEMORY_HEAT_HINT:
> +            if (!cpu->hyperv_memory_hint) {
> +                exit->u.hcall.result = HV_STATUS_INVALID_HYPERCALL_CODE;
> +                break;
> +            }
> +            exit->u.hcall.result =
> +                hyperv_hcall_memory_hint(in_param, rep_count, fast);
> +            if (exit->u.hcall.result == HV_STATUS_SUCCESS) {
> +                exit->u.hcall.result |=
> +                    (rep_count & HV_HYPERCALL_REP_COMP_MASK) <<
> +                    HV_HYPERCALL_REP_COMP_OFFSET;
> +            }
> +            break;
>          default:
>              exit->u.hcall.result = HV_STATUS_INVALID_HYPERCALL_CODE;
>          }
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 072da8b9f1..46c983f963 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -1137,6 +1137,13 @@ static struct {
>          },
>          .dependencies = BIT(HYPERV_FEAT_VAPIC)
>      },
> +    [HYPERV_FEAT_EXT_HYPERCALLS] = {
> +        .desc = "enable extended hypercalls (hv-extcalls)",
> +        .flags = {
> +            {.func = HV_CPUID_FEATURES, .reg = R_EBX,
> +             .bits = HV_ENABLE_EXTENDED_HYPERCALLS}
> +        }
> +    },
>  };
>  
>  static struct kvm_cpuid2 *try_get_hv_cpuid(CPUState *cs, int max,
> -- 
> 2.54.0 (Apple Git-157)
> 
> 


