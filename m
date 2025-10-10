Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711EDCCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 20:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7JeX-0004oy-Jj; Fri, 10 Oct 2025 16:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1v7JeU-0004on-Tj
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 16:23:46 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1v7JeQ-0003kK-PJ
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 16:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=jgrPXXSakzwF4Ek8sVc79WwY8yDdUoH/VDRRleSJMsk=; b=boCkEBG/RjxsO8Lx
 8hhVWblBm7C48oiupp3XrNSbvllRX4IlZNWqokfNPyjyhWbHw6Nbk/Jy60i+6sh005Rw4Zo00YO0C
 yNmRZhqS+l/f//UASBTuAisN6eb5kPi8l1NUVkSdwh0KVuENOwaP81xcngSFDf2yKXgTR/dS3kjF5
 YD3NTlrKBLx3+dXQVtgiFogpRwrh/DYZa6QUS6gB+tRNBRdwiYmho27vlJFlJKUb+PEREkZyedqCb
 tQyD1SUWputZ5TMVfCsDjNw91l/TMHwBxd29M61QqbDENhlfBN20hZp4mzI0sG5fe1rMCiF7ZyJJE
 cAg1N/M2+YY44e8zVA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1v7JeG-00FmRd-1V;
 Fri, 10 Oct 2025 20:23:32 +0000
Date: Fri, 10 Oct 2025 20:23:32 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v3] hw/uefi: add "info firmware-log" +
 "query-firmware-log" monitor commands
Message-ID: <aOlrRNIUijmj1V4Q@gallifrey>
References: <20251010071008.2555267-1-kraxel@redhat.com>
 <87ecrbj85s.fsf@pond.sub.org> <874is6fyl7.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <874is6fyl7.fsf@pond.sub.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 20:20:56 up 166 days,  4:34,  1 user,  load average: 0.00, 0.00, 0.00
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

* Markus Armbruster (armbru@redhat.com) wrote:
> One more thing...  or rather two.
> 
> Markus Armbruster <armbru@redhat.com> writes:
> 
> > Gerd Hoffmann <kraxel@redhat.com> writes:
> >
> >> Starting with the edk2-stable202508 tag OVMF (and ArmVirt too) have
> >> optional support for logging to a memory buffer.  There is guest side
> >> support -- for example in linux kernels v6.17+ -- to read that buffer.
> >> But that might not helpful if your guest stops booting early enough that
> >> guest tooling can not be used yet.  So host side support to read that
> >> log buffer is a useful thing to have.
> >>
> >> This patch implements both qmp and hmp monitor commands to read the
> >> firmware log.
> >
> > So this is just for EDK2, at least for now.
> >
> >> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> >> ---
> >>  include/monitor/hmp.h      |   1 +
> >>  hw/uefi/ovmf-log.c         | 265 +++++++++++++++++++++++++++++++++++++
> >>  tests/qtest/qmp-cmd-test.c |   2 +
> >>  hmp-commands-info.hx       |  14 ++
> >>  hw/uefi/meson.build        |   2 +-
> >>  qapi/machine.json          |  23 ++++
> >>  6 files changed, 306 insertions(+), 1 deletion(-)
> >>  create mode 100644 hw/uefi/ovmf-log.c
> >>
> >> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> >> index ae116d9804a3..885c0ecd2aed 100644
> >> --- a/include/monitor/hmp.h
> >> +++ b/include/monitor/hmp.h
> >> @@ -178,5 +178,6 @@ void hmp_boot_set(Monitor *mon, const QDict *qdict);
> >>  void hmp_info_mtree(Monitor *mon, const QDict *qdict);
> >>  void hmp_info_cryptodev(Monitor *mon, const QDict *qdict);
> >>  void hmp_dumpdtb(Monitor *mon, const QDict *qdict);
> >> +void hmp_info_firmware_log(Monitor *mon, const QDict *qdict);
> >>  
> >>  #endif
> >> diff --git a/hw/uefi/ovmf-log.c b/hw/uefi/ovmf-log.c
> >> new file mode 100644
> >> index 000000000000..89e27d916531
> >> --- /dev/null
> >> +++ b/hw/uefi/ovmf-log.c
> >> @@ -0,0 +1,265 @@
> >> +/*
> >> + * SPDX-License-Identifier: GPL-2.0-or-later
> >> + *
> >> + * print ovmf debug log
> >> + *
> >> + * see OvmfPkg/Library/MemDebugLogLib/ in edk2
> >> + */
> >> +
> >> +#include "qemu/osdep.h"
> >> +#include "qemu/units.h"
> >> +#include "qemu/base64.h"
> >> +#include "qemu/target-info-qapi.h"
> >> +#include "hw/boards.h"
> >> +#include "hw/i386/x86.h"
> >> +#include "hw/arm/virt.h"
> >> +#include "system/dma.h"
> >> +#include "monitor/hmp.h"
> >> +#include "monitor/monitor.h"
> >> +#include "qapi/error.h"
> >> +#include "qapi/type-helpers.h"
> >> +#include "qapi/qapi-commands-machine.h"
> >> +
> >> +
> >> +/* ----------------------------------------------------------------------- */
> >> +/* copy from edk2                                                          */
> >> +
> >> +#define MEM_DEBUG_LOG_MAGIC1  0x3167646d666d766f  /* "ovmfmdg1" */
> >> +#define MEM_DEBUG_LOG_MAGIC2  0x3267646d666d766f  /* "ovmfmdg2" */
> >> +
> >> +/*
> >> + * Mem Debug Log buffer header.
> >> + * The Log buffer is circular. Only the most
> >> + * recent messages are retained. Older messages
> >> + * will be discarded if the buffer overflows.
> >> + * The Debug Log starts just after the header.
> >> + */
> >> +typedef struct {
> >> +    /*
> >> +     * Magic values
> >> +     * These fields are used by tools to locate the buffer in
> >> +     * memory. These MUST be the first two fields of the structure.
> >> +     * Use a 128 bit Magic to vastly reduce the possibility of
> >> +     * a collision with random data in memory.
> >> +     */
> >> +    uint64_t             Magic1;
> >> +    uint64_t             Magic2;
> >> +    /*
> >> +     * Header Size
> >> +     * This MUST be the third field of the structure
> >> +     */
> >> +    uint64_t             HeaderSize;
> >> +    /*
> >> +     * Debug log size (minus header)
> >> +     */
> >> +    uint64_t             DebugLogSize;
> >> +    /*
> >> +     * edk2 uses this for locking access.
> >> +     */
> >> +    uint64_t             MemDebugLogLock;
> >> +    /*
> >> +     * Debug log head offset
> >> +     */
> >> +    uint64_t             DebugLogHeadOffset;
> >> +    /*
> >> +     *  Debug log tail offset
> >> +     */
> >> +    uint64_t             DebugLogTailOffset;
> >> +    /*
> >> +     * Flag to indicate if the buffer wrapped and was thus truncated.
> >> +     */
> >> +    uint64_t             Truncated;
> >> +    /*
> >> +     * Firmware Build Version (PcdFirmwareVersionString)
> >> +     */
> >> +    char                 FirmwareVersion[128];
> >> +} MEM_DEBUG_LOG_HDR;
> >
> > I understand this is a (close to) literal copy from EDK2, and adjusting
> > it to QEMU style would be a bad idea.
> >
> >> +
> >> +
> >> +/* ----------------------------------------------------------------------- */
> >> +/* qemu monitor command                                                    */
> >> +
> >> +typedef struct {
> >> +    uint64_t             Magic1;
> >> +    uint64_t             Magic2;
> >> +} MEM_DEBUG_LOG_MAGIC;
> >
> > Unusual capitalization for a typedef name.  Why?  To emphasize the
> > relation to MEM_DEBUG_LOG_HDR?
> >
> >> +
> >> +/* find log buffer in guest memory by searching for the magic cookie */
> >> +static dma_addr_t find_ovmf_log_range(dma_addr_t start, dma_addr_t end)
> >> +{
> >> +    static const MEM_DEBUG_LOG_MAGIC magic = {
> >> +        .Magic1 = MEM_DEBUG_LOG_MAGIC1,
> >> +        .Magic2 = MEM_DEBUG_LOG_MAGIC2,
> >> +    };
> >> +    MEM_DEBUG_LOG_MAGIC check;
> >> +    dma_addr_t step = 4 * KiB;
> >> +    dma_addr_t offset;
> >> +
> >> +    for (offset = start; offset < end; offset += step) {
> >> +        if (dma_memory_read(&address_space_memory, offset,
> >> +                            &check, sizeof(check),
> >> +                            MEMTXATTRS_UNSPECIFIED)) {
> >> +            /* dma error -> stop searching */
> >> +            break;
> >> +        }
> >> +        if (memcmp(&magic, &check, sizeof(check)) == 0) {
> >> +            return offset;
> >> +        }
> >> +    }
> >> +    return -1;
> >
> > Cast this to dma_addr_t?  dma_addr_t is unsigned...
> >
> >> +}
> >> +
> >> +static dma_addr_t find_ovmf_log(void)
> >> +{
> >> +    MachineState *ms = MACHINE(qdev_get_machine());
> >> +    dma_addr_t start, end, offset;
> >> +
> >> +    if (target_arch() == SYS_EMU_TARGET_X86_64 &&
> >> +        object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE)) {
> >> +        X86MachineState *x86ms = X86_MACHINE(ms);
> >> +
> >> +        /* early log buffer, static allocation in memfd, sec + early pei */
> >> +        offset = find_ovmf_log_range(0x800000, 0x900000);
> >> +        if (offset != -1) {
> >> +            return offset;
> >> +        }
> >> +
> >> +        /*
> >> +         * normal log buffer, dynamically allocated close to end of low memory,
> >> +         * late pei + dxe phase
> >> +         */
> >> +        end = x86ms->below_4g_mem_size;
> >> +        start = end - MIN(end, 128 * MiB);
> >> +        offset = find_ovmf_log_range(start, end);
> >> +        return offset;
> >
> > Collapse these two statements to
> >
> >            return find_ovmf_log_range(start, end);
> >
> >> +    }
> >> +
> >> +    if (target_arch() == SYS_EMU_TARGET_AARCH64 &&
> >> +        object_dynamic_cast(OBJECT(ms), TYPE_VIRT_MACHINE)) {
> >> +        /* edk2 ArmVirt firmware allocations are in the first 128 MB */
> >> +        VirtMachineState *vms = VIRT_MACHINE(ms);
> >
> > Suggest blank line between declarations and statements.
> >
> >> +        start = vms->memmap[VIRT_MEM].base;
> >> +        end = start + 128 * MiB;
> >> +        offset = find_ovmf_log_range(start, end);
> >> +        return offset;
> >
> > Collapse these two statements to
> >
> >            return find_ovmf_log_range(start, end);
> >
> >> +    }
> >> +
> >> +    return -1;
> >
> > Cast this to dma_addr_t?
> >
> >> +}
> >> +
> >> +static void handle_ovmf_log_range(GString *out,
> >> +                                  dma_addr_t start,
> >> +                                  dma_addr_t end,
> >> +                                  Error **errp)
> >> +{
> >> +    g_autofree char *buf = NULL;
> >> +
> >> +    if (start > end) {
> >> +        return;
> >> +    }
> >> +
> >> +    buf = g_malloc(end - start + 1);
> >
> > How big can this buffer become?  See [*] below.
> >
> >> +    if (dma_memory_read(&address_space_memory, start,
> >> +                        buf, end - start,
> >> +                        MEMTXATTRS_UNSPECIFIED)) {
> >> +        error_setg(errp, "firmware log: buffer read error");
> >> +        return;
> >> +    }
> >> +
> >> +    buf[end - start] = 0;
> >> +    g_string_append_printf(out, "%s", buf);
> >
> > This falls apart when the log contains '\0'.  Suggest something like
> >
> >        g_string_append_len(out, buf, end - start);
> >
> > or even better, the direct read Daniel suggested.
> >
> >> +}
> >> +
> >> +FirmwareLog *qmp_query_firmware_log(Error **errp)
> >> +{
> >> +    MEM_DEBUG_LOG_HDR header;
> >> +    dma_addr_t offset, base;
> >> +    FirmwareLog *ret;
> >> +    g_autoptr(GString) log = g_string_new("");
> >> +
> >> +    offset = find_ovmf_log();
> >> +    if (offset == -1) {
> >> +        error_setg(errp, "firmware log: not found");
> >> +        return NULL;
> >> +    }
> >> +
> >> +    if (dma_memory_read(&address_space_memory, offset,
> >> +                        &header, sizeof(header),
> >> +                        MEMTXATTRS_UNSPECIFIED)) {
> >> +        error_setg(errp, "firmware log: header read error");
> >> +        return NULL;
> >> +    }
> >> +
> >> +    if (header.DebugLogSize > MiB) {
> >> +        /* default size is 128k (32 pages), allow up to 1M */
> >> +        error_setg(errp, "firmware log: log buffer is too big");
> >
> > [*] We limit the buffer to 1MiB.  No objection to the size.
> >
> > What do you mean by "default" in "default size"?  Is the size
> > configurable in EDK2?
> >
> > Should we try to cope more gracefully with oversized log buffers?  It's
> > a ring buffer.  What about silently reading the latest 1MiB then?
> > Behaves just as if the ring buffer was 1MiB.
> >
> >> +        return NULL;
> >> +    }
> >> +
> >> +    if (header.DebugLogHeadOffset > header.DebugLogSize ||
> >> +        header.DebugLogTailOffset > header.DebugLogSize) {
> >> +        error_setg(errp, "firmware log: invalid header");
> >> +        return NULL;
> >> +    }
> >> +
> >> +    base = offset + header.HeaderSize;
> >> +    if (header.DebugLogHeadOffset > header.DebugLogTailOffset) {
> >> +        /* wrap around */
> >> +        handle_ovmf_log_range(log,
> >> +                              base + header.DebugLogHeadOffset,
> >> +                              base + header.DebugLogSize,
> >> +                              errp);
> >> +        if (*errp) {
> >> +            return NULL;
> >> +        }
> >> +        handle_ovmf_log_range(log,
> >> +                              base + 0,
> >> +                              base + header.DebugLogTailOffset,
> >> +                              errp);
> >> +        if (*errp) {
> >> +            return NULL;
> >> +        }
> >> +    } else {
> >> +        handle_ovmf_log_range(log,
> >> +                              base + header.DebugLogHeadOffset,
> >> +                              base + header.DebugLogTailOffset,
> >> +                              errp);
> >> +        if (*errp) {
> >> +            return NULL;
> >> +        }
> >> +    }
> >> +
> >> +    ret = g_new0(FirmwareLog, 1);
> >> +    ret->version = g_strdup(header.FirmwareVersion);
> >> +    ret->log = g_base64_encode((const guchar *)log->str, log->len);
> >> +    return ret;
> >
> > Note for later [**]: both ->version and ->log are non-null on success.
> >
> >> +}
> >> +
> >> +void hmp_info_firmware_log(Monitor *mon, const QDict *qdict)
> >> +{
> >> +    Error *errp = NULL;
> >> +    FirmwareLog *log;
> >> +
> >> +    log = qmp_query_firmware_log(&errp);
> >> +    if (errp)  {
> >> +        monitor_printf(mon, "ERROR: %s\n", error_get_pretty(errp));
> >
> > Let's not shout "ERROR" :)
> >
> > Recommend
> >
> >            hmp_handle_error(mon, errp);
> >
> >> +        return;
> >> +    }
> >> +
> >> +    g_assert(log != NULL);
> >> +
> >> +    if (log->version) {
> >> +        monitor_printf(mon, "[ firmware version: %s ]\n", log->version);
> 
> What if log->version contains control characters?  See discussion below.
> 
> >> +    }
> >> +
> >> +    if (log->log) {
> >> +        size_t outlen;
> >> +        uint8_t *out = qbase64_decode(log->log, -1, &outlen, &errp);
> >
> > We first encode to base64, then back.  Tolerable.  To avoid it, factor
> > everything but the encode out of qmp_query_firmware_log() into a helper.
> 
> With handle_ovmf_log_range() fixed, this can put null bytes into @out,
> and ...
> 
> >> +        if (errp)  {
> >> +            monitor_printf(mon, "ERROR: %s\n", error_get_pretty(errp));
> >
> > hmp_handle_error()
> >
> >> +            return;
> >> +        }
> >> +        monitor_printf(mon, "%s\n", out);
> 
> ... this will print the log truncated.
> 
> Moreover, it happily prints control characters even without
> handle_ovmf_log_range() fixed.
> 
> If the log is ASCII (see below), you could use g_strescape().  Copies
> the string on the heap yet again.  Meh.

That's probably the wrong thing for hmp; you want cr,lf and maybe tabs
to pass straight through - you want a log to be correctly line formatted;
you just want to stop nasties getting through.

Dave

> 
> If it's UTF-8, we need to talk :)
> 
> >> +        g_free(out);
> >> +    }
> >> +}
> >> diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
> >> index cf718761861d..ffdb7e979e0f 100644
> >> --- a/tests/qtest/qmp-cmd-test.c
> >> +++ b/tests/qtest/qmp-cmd-test.c
> >> @@ -52,6 +52,8 @@ static int query_error_class(const char *cmd)
> >>          /* Only valid with accel=tcg */
> >>          { "x-query-jit", ERROR_CLASS_GENERIC_ERROR },
> >>          { "xen-event-list", ERROR_CLASS_GENERIC_ERROR },
> >> +        /* requires firmware with memory buffer logging support */
> >> +        { "query-ovmf-log", ERROR_CLASS_GENERIC_ERROR },
> >>          { NULL, -1 }
> >>      };
> >>      int i;
> >> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> >> index 6142f60e7b16..257015f0b403 100644
> >> --- a/hmp-commands-info.hx
> >> +++ b/hmp-commands-info.hx
> >> @@ -977,3 +977,17 @@ SRST
> >>    ``info cryptodev``
> >>      Show the crypto devices.
> >>  ERST
> >> +
> >> +    {
> >> +        .name       = "firmware-log",
> >> +        .args_type  = "",
> >> +        .params     = "",
> >> +        .help       = "show the firmware (ovmf) debug log",
> >> +        .cmd        = hmp_info_firmware_log,
> >> +        .flags      = "p",
> >> +    },
> >> +
> >> +SRST
> >> +  ``info firmware-log``
> >> +    Show the firmware (ovmf) debug log.
> >> +ERST
> >> diff --git a/hw/uefi/meson.build b/hw/uefi/meson.build
> >> index 91eb95f89e6d..c8f38dfae247 100644
> >> --- a/hw/uefi/meson.build
> >> +++ b/hw/uefi/meson.build
> >> @@ -1,4 +1,4 @@
> >> -system_ss.add(files('hardware-info.c'))
> >> +system_ss.add(files('hardware-info.c', 'ovmf-log.c'))
> >>  
> >>  uefi_vars_ss = ss.source_set()
> >>  if (config_all_devices.has_key('CONFIG_UEFI_VARS'))
> >> diff --git a/qapi/machine.json b/qapi/machine.json
> >> index 038eab281c78..c96e582afdd6 100644
> >> --- a/qapi/machine.json
> >> +++ b/qapi/machine.json
> >> @@ -1839,6 +1839,29 @@
> >>    'returns': 'HumanReadableText',
> >>    'features': [ 'unstable' ]}
> >>  
> >> +##
> >> +# @FirmwareLog:
> >> +#
> >> +# @version: Firmware version.
> >> +#
> >> +# @log: Firmware debug log, in base64 encoding.
> >
> > Can this have a partial line at the beginning and/or the end?
> >
> >> +#
> >> +# Since: 10.2
> >> +##
> >> +{ 'struct': 'FirmwareLog',
> >> +  'data': { '*version': 'str',
> >> +            '*log': 'str' } }
> >
> > These aren't actually optional with the current code.  See [**] above.
> > I guess you make them optional just in case some other firmware can
> > provide only one of them.
> 
> Are @log and @version ASCII, UTF-8, or something else?
> 
> >> +
> >> +##
> >> +# @query-firmware-log:
> >> +#
> >> +# Find firmware memory log buffer in guest memory, return content.
> >
> > Should we mention this is implemented only for EDK2 at this time?
> >
> > Have you considered an optional size argument to retrieve the tail of
> > the log?
> >
> >> +#
> >> +# Since: 10.2
> >> +##
> >> +{ 'command': 'query-firmware-log',
> >> +  'returns': 'FirmwareLog' }
> >> +
> >>  ##
> >>  # @dump-skeys:
> >>  #
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

