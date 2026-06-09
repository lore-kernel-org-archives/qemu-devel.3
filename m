Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8A0CD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWy7H-0003Rb-Cs; Tue, 09 Jun 2026 11:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1wWy7F-0003R9-Oz
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:11:45 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1wWy7D-0003Nd-N7
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:11:45 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C297E40351;
 Tue,  9 Jun 2026 15:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50CA1F00893;
 Tue,  9 Jun 2026 15:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781017901;
 bh=1sZXlp8Gi6WChPLNyAEhS87z81+kdWGyl+V7rw7CMQE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=ivtq1JsFPqdfxMvHLyClFk0jWXPyKm7TamouYESRpz/7RUiZ/YDo+mLzBXsN6LdeW
 ZuvgJvEKbfW1xIPnI/H3In3uHri/ocKn+wGFIHFBW/zBKUtrnFxpOqrvbF1oITdWko
 r9Xe9klCqgE3TlJRCW7twDcKsJsKnNMiEbl1knp7mqszfyk3y53tJUuPJDZI0/QPRI
 QJuhJsE4oGDsPQjUbehY4wsY4XrAh7IZErVQgC9WhpgMcVgLcTnQtrSNKXgH6yjnDd
 WCMsui7+GNcPQINkG6IJdEyXgk1KrZA1C/Ozf9PSfYpK2nsIefXiu0kBynfe+KRLVK
 udTg8kUx8nMxg==
Date: Tue, 9 Jun 2026 16:11:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Junjie Cao <junjie.cao@intel.com>
Cc: jonathan.cameron@huawei.com, fan.ni@samsung.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] hw/cxl: trace event log activity and CFMWS address
 decoding
Message-ID: <20260609161134.30d5e1cf@jic23-huawei>
In-Reply-To: <20260603013420.904749-4-junjie.cao@intel.com>
References: <20260603013420.904749-1-junjie.cao@intel.com>
 <20260603013420.904749-4-junjie.cao@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=jic23@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed,  3 Jun 2026 09:34:20 +0800
Junjie Cao <junjie.cao@intel.com> wrote:

> Two more debug-prone paths benefit from trace coverage. Event log
> insertion and clearing are exercised on every error injection or
> dynamic capacity event, but their interaction with the per-log
> overflow counter is currently opaque. CFMWS address decoding
> translates a host physical address through up to two HDM decoder
> lookups (host bridge and optional switch USP).

Again, two largely unrelated things - two patches please.

> 
> Add five trace points:
> 
>   * cxl_event_insert            - successful enqueue, log type and
>                                   resulting depth
>   * cxl_event_overflow          - the artificial overflow threshold
>                                   was hit; an event was dropped
>   * cxl_event_clear             - bulk clear, log type and request size
> 
>   * cxl_cfmws_lookup            - entry to address decoding, with
>                                   the resolved fixed-window index
>   * cxl_cfmws_target_resolved   - HDM decoder produced a target index
>                                   (fires for both the host-bridge and
>                                   switch USP lookups)
> 
> In non-passthrough topologies, a cxl_cfmws_lookup without a following
> cxl_cfmws_target_resolved indicates the host-bridge HDM decode
> failed. In passthrough mode the lookup resolves via
> pcie_find_port_first() without an HDM target step, so no
> target_resolved event is expected.

Ah. Good to see you have noted these don't apply to pass through case.
I think for that we should probably have an event that makes it
clear it is enabled and we won't see these.  (Need's Ali's patches
to go upstream first though).

> 
> In cxl_event_insert(), cxl_event_count() is hoisted into a local
> variable so its O(n) queue walk is performed once per insert rather
> than twice (once for the trace point, once for the existing return-
> value comparison).
> 
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> ---
>  hw/cxl/cxl-events.c | 8 +++++++-
>  hw/cxl/cxl-host.c   | 4 ++++
>  hw/cxl/trace-events | 9 +++++++++
>  3 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
> index 5356dfb5b3..f4aa419953 100644
> --- a/hw/cxl/cxl-events.c
> +++ b/hw/cxl/cxl-events.c
> @@ -13,6 +13,7 @@
>  #include "hw/pci/msix.h"
>  #include "hw/cxl/cxl.h"
>  #include "hw/cxl/cxl_events.h"
> +#include "trace.h"
>  
>  /* Artificial limit on the number of events a log can hold */
>  #define CXL_TEST_EVENT_OVERFLOW 8
> @@ -98,6 +99,7 @@ bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
>      uint64_t time;
>      CXLEventLog *log;
>      CXLEvent *entry;
> +    int depth;
>  
>      if (log_type >= CXL_EVENT_TYPE_MAX) {
>          return false;
> @@ -115,6 +117,7 @@ bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
>          }
>          log->overflow_err_count++;
>          log->last_overflow_timestamp = time;
> +        trace_cxl_event_overflow(log_type, log->overflow_err_count);
>          return false;
>      }
>  
> @@ -133,8 +136,10 @@ bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
>      QSIMPLEQ_INSERT_TAIL(&log->events, entry, node);
>      cxl_event_set_status(cxlds, log_type, true);
>  
> +    depth = cxl_event_count(log);

Hmm. I wonder if we can name this more clearly. It is kind of
queue depth, but I've not really seen that used with and people might
think that's the maximum space.   Maybe occupancy is better?
(Assisted by claude ;)

> +    trace_cxl_event_insert(log_type, depth);
>      /* Count went from 0 to 1 */
> -    return cxl_event_count(log) == 1;
> +    return depth == 1;
>  }
>  
>  void cxl_discard_all_event_records(CXLDeviceState *cxlds)
> @@ -234,6 +239,7 @@ CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds,
>          entry = cxl_event_get_head(log);
>      }
>  
> +    trace_cxl_event_clear(log_type, pl->nr_recs);
>      return CXL_MBOX_SUCCESS;
>  }
>  
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index a94b893e99..4157377a95 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -21,6 +21,7 @@
>  #include "hw/pci/pci_host.h"
>  #include "hw/pci/pcie_port.h"
>  #include "hw/pci-bridge/pci_expander_bridge.h"
> +#include "trace.h"
>  
>  static void cxl_fixed_memory_window_config(CXLFixedMemoryWindowOptions *object,
>                                             int index, Error **errp)
> @@ -168,6 +169,7 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
>      bool target_found;
>      PCIDevice *rp, *d;
>  
> +    trace_cxl_cfmws_lookup(addr, fw->index);
>      rb_index = (addr / cxl_decode_ig(fw->enc_int_gran)) % fw->num_targets;
>      hb = PCI_HOST_BRIDGE(fw->target_hbs[rb_index]->cxl_host_bridge);
>      if (!hb || !hb->bus || !pci_bus_is_cxl(hb->bus)) {
> @@ -191,6 +193,7 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
>          if (!target_found) {
>              return NULL;
>          }
> +        trace_cxl_cfmws_target_resolved(addr, target);
>  
>          rp = pcie_find_port_by_pn(hb->bus, target);
>          if (!rp) {
> @@ -227,6 +230,7 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
>      if (!target_found) {
>          return NULL;
>      }
> +    trace_cxl_cfmws_target_resolved(addr, target);
>  
>      d = pcie_find_port_by_pn(&PCI_BRIDGE(d)->sec_bus, target);
>      if (!d) {
> diff --git a/hw/cxl/trace-events b/hw/cxl/trace-events
> index 15977dce6e..e5f196787d 100644
> --- a/hw/cxl/trace-events
> +++ b/hw/cxl/trace-events
> @@ -10,3 +10,12 @@ cxl_mailbox_handler_return(uint16_t opcode, int ret, size_t len_out) "opcode=0x%
>  # cxl-cdat.c
>  cxl_cdat_init(const char *source) "source=%s"
>  cxl_cdat_loaded(const char *filename, size_t length, int num_entries) "filename=%s length=%zu entries=%d"
> +
> +# cxl-events.c
> +cxl_event_insert(int log_type, int depth) "log_type=%d depth=%d"
> +cxl_event_overflow(int log_type, uint16_t overflow_err_count) "log_type=%d overflow_err_count=%u"
> +cxl_event_clear(int log_type, int nr_recs) "log_type=%d nr_recs=%d"
> +
> +# cxl-host.c
> +cxl_cfmws_lookup(uint64_t addr, int fw_index) "addr=0x%"PRIx64" fw=%d"
> +cxl_cfmws_target_resolved(uint64_t addr, uint8_t target) "addr=0x%"PRIx64" target=0x%02x"


