Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C42CCD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWxlo-0001yc-64; Tue, 09 Jun 2026 10:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1wWxlm-0001yK-SM
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:49:34 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1wWxll-0003ny-1R
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:49:34 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D2B6060210;
 Tue,  9 Jun 2026 14:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D121F00893;
 Tue,  9 Jun 2026 14:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781016571;
 bh=Te0LevBJiQ9OTccx8kpXW1nl87SDEU/4kM239jNL6Rs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=S4vqZWwBGwH3oEQDRWdmC1GfgIlfMD/GVZyICvKOZ1oSpO6X5oOwUpUwx/8d05PYw
 1JiPIPWYrcpL4Iw/5IwhMxsUR6TqpNz0+bAiJ7M0LpCEPKL7rE8LmZdVOMLRoQDSJs
 rc15tSCPXDPOL3KQ7V5N6d53Qtu3IAeljGpaCNBFsWPcMuPilv7vvl2uv+X+JTDIyJ
 PA9OLbVlI0PR31KZbHHJIaiQU/sSSnEgz4HbTIVHAy7m6x8Weyt/fp6/Zoc/01Qo86
 EVg3IyAyY7mCwadhVFXtvrUGw3Icsi6mCyiawXkF98IVHzxZv84nDWH5ZTQKfvUGVx
 diL3AkLOdakkg==
Date: Tue, 9 Jun 2026 15:49:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Junjie Cao <junjie.cao@intel.com>
Cc: jonathan.cameron@huawei.com, fan.ni@samsung.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/3] hw/cxl: add trace-events for mailbox dispatch
Message-ID: <20260609154925.61d81da1@jic23-huawei>
In-Reply-To: <20260603013420.904749-2-junjie.cao@intel.com>
References: <20260603013420.904749-1-junjie.cao@intel.com>
 <20260603013420.904749-2-junjie.cao@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=jic23@kernel.org;
 helo=tor.source.kernel.org
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

On Wed,  3 Jun 2026 09:34:18 +0800
Junjie Cao <junjie.cao@intel.com> wrote:

> The CXL subsystem currently has no trace coverage. Debugging mailbox
> command flow requires either printf or qemu_log_mask, neither of which
> is well suited for following the dispatch path that is exercised by
> every guest driver probe.
> 
> Introduce a dedicated trace-events file under hw/cxl/ and wire it into
> the build via the trace_events_subdirs list in the top-level
> meson.build. Add three trace points covering command entry, payload
> validation, and handler completion in cxl_process_cci_message():
> 
>   * cxl_mailbox_command          - command entry (opcode, len_in)
>   * cxl_mailbox_invalid_payload  - payload length check rejection
>   * cxl_mailbox_handler_return   - handler completion with return code
>                                    and len_out
> 
> The early-exit paths for unimplemented commands, in-progress background
> operations, and disabled media skip handler dispatch and are therefore
> not paired with cxl_mailbox_handler_return; an absent return event for
> a given cxl_mailbox_command identifies these cases in the trace stream.
> 
> Trace points use the cxl_ prefix so future patches in this subsystem
> share a single namespace, allowing -trace 'cxl_*' to match all of them.
> 
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Seems likely to be a useful addition.  My main request is to make sure
all possible places we might exit due to a given condition are covered
rather than just the simplest one (for length checks that is!)

Jonathan

> ---
>  hw/cxl/cxl-mailbox-utils.c | 5 +++++
>  hw/cxl/trace-events        | 8 ++++++++
>  hw/cxl/trace.h             | 4 ++++
>  meson.build                | 1 +
>  4 files changed, 18 insertions(+)
>  create mode 100644 hw/cxl/trace-events
>  create mode 100644 hw/cxl/trace.h
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index d8ba7e8625..521b8c6334 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -27,6 +27,7 @@
>  #include "system/hostmem.h"
>  #include "qemu/range.h"
>  #include "qapi/qapi-types-cxl.h"
> +#include "trace.h"
>  
>  #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
>  #define CXL_DC_EVENT_LOG_SIZE 8
> @@ -4580,6 +4581,7 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
>      CXLDeviceState *cxl_dstate;
>  
>      *len_out = 0;
> +    trace_cxl_mailbox_command((set << 8) | cmd, len_in);

Given the opcode is always made up of those two smaller fields, it might be nicer
to just pass them as separate parameters?  Potentially combine them into
the single print in the tracepoint, or do it as set:cmd  e.g 0x01:03
or something like that?


>      cxl_cmd = &cci->cxl_cmd_set[set][cmd];
>      h = cxl_cmd->handler;
>      if (!h) {
> @@ -4589,6 +4591,8 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
>      }
>  
>      if (len_in != cxl_cmd->in && cxl_cmd->in != ~0) {
> +        trace_cxl_mailbox_invalid_payload((set << 8) | cmd, len_in,
> +                                          cxl_cmd->in);
>          return CXL_MBOX_INVALID_PAYLOAD_LENGTH;

This is one of a lot of places that we fail with that error code - because
many commands have variable lengths. I'd want to see this on all of the
places where we end up bailing out with that error code.

>  
> @@ -4642,6 +4646,7 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
>          timer_mod(cci->bg.timer, now + CXL_MBOX_BG_UPDATE_FREQ);
>      }
>  
> +    trace_cxl_mailbox_handler_return((set << 8) | cmd, ret, *len_out);
>      return ret;
>  }
>  
> diff --git a/hw/cxl/trace-events b/hw/cxl/trace-events
> new file mode 100644
> index 0000000000..abca116ed3
> --- /dev/null
> +++ b/hw/cxl/trace-events
> @@ -0,0 +1,8 @@
> +# See docs/devel/tracing.rst for syntax documentation.
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +# cxl-mailbox-utils.c
> +cxl_mailbox_command(uint16_t opcode, size_t len_in) "opcode=0x%04x len_in=%zu"
> +cxl_mailbox_invalid_payload(uint16_t opcode, size_t len_in, size_t expected) "opcode=0x%04x len_in=%zu expected=%zu"
> +cxl_mailbox_handler_return(uint16_t opcode, int ret, size_t len_out) "opcode=0x%04x ret=%d len_out=%zu"
> diff --git a/hw/cxl/trace.h b/hw/cxl/trace.h
> new file mode 100644
> index 0000000000..84e79d50c0
> --- /dev/null
> +++ b/hw/cxl/trace.h
> @@ -0,0 +1,4 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include "trace/trace-hw_cxl.h"
> diff --git a/meson.build b/meson.build
> index 19e123423b..c229199d5d 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3596,6 +3596,7 @@ if have_system
>      'hw/audio',
>      'hw/block',
>      'hw/char',
> +    'hw/cxl',
>      'hw/display',
>      'hw/dma',
>      'hw/fsi',


