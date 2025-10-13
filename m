Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10340CCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 13:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8IML-0000fe-5X; Mon, 13 Oct 2025 09:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1v8IMJ-0000fM-HC
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 09:13:03 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1v8IME-0003T0-Og
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 09:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=5ET/aQ+U63FDYHaqXr04OCKmMMIQFmqjemevykk5m4Y=; b=Z1g2fAg/jj8sshRO
 KEK64j9b2fo0Xma/wpgW2URpRNb5ujle4ds4WP+gKaEUDb9OAGsj9J6ogeNVEosArRS4CPyKCh1jO
 7ND1J8UkR3bTKqoO1AdbIwFn5+dUnWvuE6yjcZT7y+npUos2qUfM1/csaGk4y6CzDh6VXtXl3xpIB
 +Eg8NgLuaTUIDsrLSpoZKb1zCHhXKHH7a3IQeRJT71rnqMrki4TJ4JsvdHx1g6S3K7dT1lVgdzD9K
 jizGpy1Li5wm/2sw3h4IrBH6EtKFHwDo0WxXeI8jfP+hXNe7S4GrVJLSO84U0Ln70KusmvYPIadPq
 fs+pnjHmtKsvW6EX3A==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1v8IM4-00G4nm-0j;
 Mon, 13 Oct 2025 13:12:48 +0000
Date: Mon, 13 Oct 2025 13:12:48 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v3] hw/uefi: add "info firmware-log" +
 "query-firmware-log" monitor commands
Message-ID: <aOz60EZlbViTKhqr@gallifrey>
References: <20251010071008.2555267-1-kraxel@redhat.com>
 <aOluUdjaqw2XBzjr@gallifrey>
 <wz4s6ty4jsmi57i7i6th4f2gdpbamiz67cfhyrbhdiusbis4ov@qcdqmui3a52r>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <wz4s6ty4jsmi57i7i6th4f2gdpbamiz67cfhyrbhdiusbis4ov@qcdqmui3a52r>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 13:05:34 up 168 days, 21:19,  1 user,  load average: 0.00, 0.01, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

* Gerd Hoffmann (kraxel@redhat.com) wrote:
>   Hi,

Hi Gerd,

> > > +typedef struct {
> > > +    uint64_t             Magic1;
> > > +    uint64_t             Magic2;
> > > +} MEM_DEBUG_LOG_MAGIC;
> > > +
> > > +/* find log buffer in guest memory by searching for the magic cookie */
> > > +static dma_addr_t find_ovmf_log_range(dma_addr_t start, dma_addr_t end)
> > > +{
> > > +    static const MEM_DEBUG_LOG_MAGIC magic = {
> > > +        .Magic1 = MEM_DEBUG_LOG_MAGIC1,
> > > +        .Magic2 = MEM_DEBUG_LOG_MAGIC2,
> > > +    };
> > > +    MEM_DEBUG_LOG_MAGIC check;
> > > +    dma_addr_t step = 4 * KiB;
> > > +    dma_addr_t offset;
> > > +
> > > +    for (offset = start; offset < end; offset += step) {
> > > +        if (dma_memory_read(&address_space_memory, offset,
> > > +                            &check, sizeof(check),
> > > +                            MEMTXATTRS_UNSPECIFIED)) {
> > > +            /* dma error -> stop searching */
> > > +            break;
> > > +        }
> > > +        if (memcmp(&magic, &check, sizeof(check)) == 0) {
> > > +            return offset;
> > > +        }
> > > +    }
> > 
> > This feels like a genericy function for searching memory
> > that could go in util/ - if we haven't already got one
> > (and then passing the magic in).
> 
> Quick grep doesn't look like we already have one.
> Are there more possible users?

It just felt a bit more generic.

> > Also, why is this dma_addr_t - is that for IO addressing?
> 
> dma_memory_read takes dma_addr_t (and I want use that so I get errors
> back when trying to read address space not backed by ram.

OK, I did wonder if there was a risk of hitting IO.

> > > +    if (target_arch() == SYS_EMU_TARGET_X86_64 &&
> > > +        object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE)) {
> > > +        X86MachineState *x86ms = X86_MACHINE(ms);
> > > +
> > > +        /* early log buffer, static allocation in memfd, sec + early pei */
> > > +        offset = find_ovmf_log_range(0x800000, 0x900000);
> > > +        if (offset != -1) {
> > > +            return offset;
> > > +        }
> > > +
> > > +        /*
> > > +         * normal log buffer, dynamically allocated close to end of low memory,
> > > +         * late pei + dxe phase
> > > +         */
> > > +        end = x86ms->below_4g_mem_size;
> > > +        start = end - MIN(end, 128 * MiB);
> > > +        offset = find_ovmf_log_range(start, end);
> > > +        return offset;
> > > +    }
> > > +
> > > +    if (target_arch() == SYS_EMU_TARGET_AARCH64 &&
> > > +        object_dynamic_cast(OBJECT(ms), TYPE_VIRT_MACHINE)) {
> > > +        /* edk2 ArmVirt firmware allocations are in the first 128 MB */
> > > +        VirtMachineState *vms = VIRT_MACHINE(ms);
> > > +        start = vms->memmap[VIRT_MEM].base;
> > > +        end = start + 128 * MiB;
> > > +        offset = find_ovmf_log_range(start, end);
> > > +        return offset;
> > > +    }
> > 
> > Have you considered punting this to the machine type definition
> > somehow; like making it set a list of {start, end} (and maybe
> > a flag to say it's ovmf if it knows) ?
> 
> Advantage being?
> 
> The memory areas searched are quite specific to the firmware log, I
> don't see other use cases being able to reuse that ...

I was guessing the list will grow over time; I'm assuming you'll want
to add RISC V, and you might gain some none-virt machines and then you'd
end up having to deal with a growing list, where as you could leave
that to the architecture maintainers to deal with.

Again, just suggestion.

Dave

> take care,
>   Gerd
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

