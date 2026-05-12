Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C2ECD484E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 00:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMabB-0000dg-Aq; Mon, 11 May 2026 20:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1wMab9-0000dH-5S; Mon, 11 May 2026 20:03:43 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1wMab6-0005T1-Ra; Mon, 11 May 2026 20:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=MYxGCgPVawpwIS7htQV5qIYPtz9t3zNydcYz6OiWEhU=; b=nAYRWb0V4ewmQKnz
 qmEqlDNr+1b5A+fY5ZKiu5wZj+JYwV+B1zg44WdGguIOqIVFQoI5lZJTGZq4morzzYlozt3vz4yHg
 Fj0j2xGV08EXVbzN7NyW5JHLxAPf1wLj3DV1S+9S+wp5zJp3s6Nrnclo7w0X6ayyv+vxm8TcNDWjP
 r3d5DCqkL9XiXFx24kmOuc4cwzgUmtpN9oE0JNtzvQhUoKJdnqHXlRwCGq7U+EviB5JHVcIyVQGuV
 WrpJ2PBwK5xGVmm6qTji5qaBjN4pxp4FuIv/+UtJ6R4xWeCPz6Kt757P+FQbcHsX2khsohFLioD7v
 5BhXe7gLs0jJft45fw==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wMab0-00000002P12-3G3n;
 Tue, 12 May 2026 00:03:34 +0000
Date: Tue, 12 May 2026 00:03:34 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Mateusz Nowicki <mateusz.nowicki@posteo.net>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Eric Blake <eblake@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 1/2] hw/nvme: add 'info nvme' HMP command
Message-ID: <agJuVpu7EwtRNcMU@gallifrey>
References: <cover.1778409416.git.mateusz.nowicki@posteo.net>
 <f419a9cf97e79b5148c10cd0a3c138dccb5d36a0.1778409416.git.mateusz.nowicki@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <f419a9cf97e79b5148c10cd0a3c138dccb5d36a0.1778409416.git.mateusz.nowicki@posteo.net>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.85+deb13-amd64 (x86_64)
X-Uptime: 00:02:13 up 11 days,  3:48,  3 users,  load average: 0.07, 0.06, 0.02
User-Agent: Mutt/2.2.13 (2024-03-09)
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

* Mateusz Nowicki (mateusz.nowicki@posteo.net) wrote:
> Add an 'info nvme' HMP command for inspecting emulated NVMe
> controllers from the QEMU monitor.
> 
> For each NVMe controller in the QOM tree the command prints:
> 
>   - PCI BDF, vendor/device ID and BAR0 base address;
>   - Identify Controller fields visible to the host driver: SN, MN, FR
>     and CNTLID;
>   - the CC, CSTS and AQA registers (raw 32-bit values);
>   - the number of admin and active I/O submission/completion queues.
> 
> Useful when debugging the Linux NVMe driver against the QEMU emulation
> without attaching gdb to the QEMU process.
> 
> Example:
> 
>   (qemu) info nvme
>   /machine/peripheral-anon/device[0]
>     PCI:    BDF 00:04.0  VID=8086 DID=5845  BAR0=0x00000000feb50000
>     ID:     SN=NVME0001  MN=QEMU NVMe Ctrl  FR=...  CNTLID=0x0000
>     CC:     0x00460001
>     CSTS:   0x00000001
>     AQA:    0x001f001f
>     Queues: 1 admin + 4 IO SQ / 4 IO CQ

I won't claim to know what those NVMe magic numbers mean, but I'll
trust you they're useful.

> Signed-off-by: Mateusz Nowicki <mateusz.nowicki@posteo.net>
> ---
>  hmp-commands-info.hx | 13 ++++++++
>  hw/nvme/meson.build  |  2 +-
>  hw/nvme/monitor.c    | 76 ++++++++++++++++++++++++++++++++++++++++++++
>  qapi/machine.json    | 17 ++++++++++

So that lot looks OK from an HMP point of view, I wonder if
qapi/machine.json is the right place for it.  Markus?

Acked-by: Dr. David Alan Gilbert <dave@treblig.org>

>  4 files changed, 107 insertions(+), 1 deletion(-)
>  create mode 100644 hw/nvme/monitor.c
> 
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 82134eb6c2..b984691c3c 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -340,6 +340,19 @@ SRST
>      Show guest USB devices.
>  ERST
>  
> +    {
> +        .name       = "nvme",
> +        .args_type  = "",
> +        .params     = "",
> +        .help       = "show emulated NVMe controllers",
> +        .cmd_info_hrt = qmp_x_query_nvme,
> +    },
> +
> +SRST
> +  ``info nvme``
> +    Show emulated NVMe controllers.
> +ERST
> +
>      {
>          .name       = "usbhost",
>          .args_type  = "",
> diff --git a/hw/nvme/meson.build b/hw/nvme/meson.build
> index 7d5caa53c2..3017f058f9 100644
> --- a/hw/nvme/meson.build
> +++ b/hw/nvme/meson.build
> @@ -1 +1 @@
> -system_ss.add(when: 'CONFIG_NVME_PCI', if_true: files('ctrl.c', 'dif.c', 'ns.c', 'subsys.c', 'nguid.c'))
> \ No newline at end of file
> +system_ss.add(when: 'CONFIG_NVME_PCI', if_true: files('ctrl.c', 'dif.c', 'ns.c', 'subsys.c', 'nguid.c', 'monitor.c'))
> \ No newline at end of file
> diff --git a/hw/nvme/monitor.c b/hw/nvme/monitor.c
> new file mode 100644
> index 0000000000..95a6754437
> --- /dev/null
> +++ b/hw/nvme/monitor.c
> @@ -0,0 +1,76 @@
> +/*
> + * QEMU NVMe Controller monitor commands
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-commands-machine.h"
> +#include "qapi/type-helpers.h"
> +#include "hw/pci/pci.h"
> +
> +#include "nvme.h"
> +
> +static int collect_one(Object *obj, void *opaque)
> +{
> +    GString *buf = opaque;
> +    NvmeCtrl *n;
> +    PCIDevice *pci;
> +    pcibus_t bar0;
> +    unsigned io_sq = 0, io_cq = 0;
> +
> +    if (!object_dynamic_cast(obj, TYPE_NVME)) {
> +        return 0;
> +    }
> +    n = NVME(obj);
> +    pci = PCI_DEVICE(n);
> +    bar0 = pci_get_bar_addr(pci, 0);
> +
> +    for (unsigned i = 1; i <= n->params.max_ioqpairs; i++) {
> +        if (n->sq && n->sq[i]) {
> +            io_sq++;
> +        }
> +        if (n->cq && n->cq[i]) {
> +            io_cq++;
> +        }
> +    }
> +
> +    g_string_append_printf(buf, "%s\n", object_get_canonical_path(obj));
> +    g_string_append_printf(buf,
> +        "  PCI:    BDF %02x:%02x.%x  VID=%04x DID=%04x  ",
> +        pci_dev_bus_num(pci), PCI_SLOT(pci->devfn), PCI_FUNC(pci->devfn),
> +        pci_get_word(pci->config + PCI_VENDOR_ID),
> +        pci_get_word(pci->config + PCI_DEVICE_ID));
> +    if (bar0 == PCI_BAR_UNMAPPED) {
> +        g_string_append(buf, "BAR0=unmapped\n");
> +    } else {
> +        g_string_append_printf(buf, "BAR0=0x%016" PRIx64 "\n",
> +                               (uint64_t)bar0);
> +    }
> +    g_string_append_printf(buf,
> +        "  ID:     SN=%.20s  MN=%.40s  FR=%.8s  CNTLID=0x%04x\n",
> +        n->id_ctrl.sn, n->id_ctrl.mn, n->id_ctrl.fr, n->cntlid);
> +    g_string_append_printf(buf, "  CC:     0x%08x\n",
> +                           ldl_le_p(&n->bar.cc));
> +    g_string_append_printf(buf, "  CSTS:   0x%08x\n",
> +                           ldl_le_p(&n->bar.csts));
> +    g_string_append_printf(buf, "  AQA:    0x%08x\n",
> +                           ldl_le_p(&n->bar.aqa));
> +    g_string_append_printf(buf,
> +        "  Queues: 1 admin + %u IO SQ / %u IO CQ\n", io_sq, io_cq);
> +    return 0;
> +}
> +
> +HumanReadableText *qmp_x_query_nvme(Error **errp)
> +{
> +    g_autoptr(GString) buf = g_string_new("");
> +
> +    object_child_foreach_recursive(object_get_root(), collect_one, buf);
> +
> +    if (buf->len == 0) {
> +        g_string_append(buf, "no NVMe controllers\n");
> +    }
> +
> +    return human_readable_text_from_str(buf);
> +}
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 685e4e29b8..d4a589e768 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1772,6 +1772,23 @@
>    'returns': 'HumanReadableText',
>    'features': [ 'unstable' ] }
>  
> +##
> +# @x-query-nvme:
> +#
> +# Query state of emulated NVMe controllers.
> +#
> +# Features:
> +#
> +# @unstable: This command is meant for debugging.
> +#
> +# Returns: NVMe controller state as human-readable text
> +#
> +# Since: 11.1
> +##
> +{ 'command': 'x-query-nvme',
> +  'returns': 'HumanReadableText',
> +  'features': [ 'unstable' ] }
> +
>  ##
>  # @SmbiosEntryPointType:
>  #
> -- 
> 2.53.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

