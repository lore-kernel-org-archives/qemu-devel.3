Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09831606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=rev.ng header.i=@rev.ng header.a=rsa-sha256 header.s=dkim header.b=K8zl647y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJB8Z-000293-ID; Tue, 20 Oct 2026 10:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1xJB8X-00028q-V0
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 10:48:22 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1xJB8W-0002eV-1W
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 10:48:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=3ByVhQz8YUk7QLt/OFRd5pcYj9qlNBllW10pH/mKOqw=; b=K8zl647y6NAiEJt
 7LhJJ1Uh+JZxeXRlMXh0HjaGwa/gQjQKx1Wgph610dV9XV0np33rk7i9Fsr6IkJoT5zIa1AkZuLMt
 pWiHs+BWMVVQhz7NMKDCOn5PTUKQCHvjacBYxZqDTEewbjYgfvE/2b0PhZ1pM+7ErLYWc9crLpn6x
 As=;
Date: Tue, 20 Oct 2026 16:53:49 +0200
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, 
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH 12/14] hw/hexagon: add subsystem-base property
Message-ID: <atdwwL2ohpFU2Gpr@hive.localdomain>
References: <20261019055245.1457795-1-brian.cain@oss.qualcomm.com>
 <20261019055245.1457795-13-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261019055245.1457795-13-brian.cain@oss.qualcomm.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 19/10/26, Brian Cain wrote:
> Let the hexagon-sim-style machines their QDSP6 subsystem, and with it the
> l2vic and QTimer.
> 
> The config table's subsystem base is updated to align with the chosen
> address.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  MAINTAINERS                       |  1 +
>  include/hw/hexagon/hexagon.h      |  4 ++
>  hw/hexagon/hexagon_dsp.c          | 62 +++++++++++++++++++++++-
>  tests/qtest/hexagon-config-test.c | 78 +++++++++++++++++++++++++++++++
>  tests/qtest/meson.build           |  3 +-
>  5 files changed, 146 insertions(+), 2 deletions(-)
>  create mode 100644 tests/qtest/hexagon-config-test.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 04df9db77dc..f1fbc971fed 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1386,6 +1386,7 @@ F: include/hw/misc/qcom-qdsp6ss-clk.h
>  F: configs/devices/hexagon-softmmu/default.mak
>  F: docs/system/hexagon/
>  F: tests/functional/hexagon/
> +F: tests/qtest/hexagon-config-test.c
>  F: tests/qtest/qcom-dsp-test.c
>  F: docs/devel/hexagon-sys.rst
>  
> diff --git a/include/hw/hexagon/hexagon.h b/include/hw/hexagon/hexagon.h
> index 7d15a9e1eb0..32acc2aa26b 100644
> --- a/include/hw/hexagon/hexagon.h
> +++ b/include/hw/hexagon/hexagon.h
> @@ -44,6 +44,10 @@ typedef enum {
>  
>  #define HEXAGON_CFGSPACE_ENTRIES (128)
>  
> +/* Offsets of q6ss cfg peripherals from the subsystem base. */
> +#define HEXAGON_L2VIC_OFFSET  0x10000
> +#define HEXAGON_QTIMER_OFFSET 0x21000
> +
>  union hexagon_config_table {
>      struct {
>          /* Base address of L2TCM space */
> diff --git a/hw/hexagon/hexagon_dsp.c b/hw/hexagon/hexagon_dsp.c
> index 9f6f34ef9be..1f92a8adccf 100644
> --- a/hw/hexagon/hexagon_dsp.c
> +++ b/hw/hexagon/hexagon_dsp.c
> @@ -17,6 +17,7 @@
>  #include "hw/hexagon/hex-subsys.h"
>  #include "hw/core/loader.h"
>  #include "qapi/error.h"
> +#include "qapi/visitor.h"
>  #include "qemu/error-report.h"
>  #include "qemu/log.h"
>  #include "elf.h"
> @@ -35,6 +36,7 @@
>  #include "machine_cfg_v81qa_1.h.inc"
>  
>  #define TYPE_HEXAGON_DSP_MACHINE "hexagon-dsp-machine"
> +#define HEXAGON_DSP_SUBSYSTEM_BASE 0xfc900000
>  OBJECT_DECLARE_SIMPLE_TYPE(HexagonDspMachineState, HEXAGON_DSP_MACHINE)
>  
>  struct HexagonDspMachineState {
> @@ -42,6 +44,8 @@ struct HexagonDspMachineState {
>  
>      hwaddr isdb_secure_flag;
>      hwaddr isdb_trusted_flag;
> +    uint32_t subsystem_base;
> +    struct hexagon_machine_config config;
>  };
>  
>  static HexagonDspMachineState *current_dms;
> @@ -107,6 +111,50 @@ static void do_cpu_reset(void *opaque)
>      cpu_reset(cs);
>  }
>  
> +static void hexagon_sim_get_subsystem_base(Object *obj, Visitor *v,
> +                                           const char *name, void *opaque,
> +                                           Error **errp)
> +{
> +    HexagonDspMachineState *dms = HEXAGON_DSP_MACHINE(obj);
> +    uint32_t value = dms->subsystem_base;
> +
> +    visit_type_uint32(v, name, &value, errp);
> +}
> +
> +static void hexagon_sim_set_subsystem_base(Object *obj, Visitor *v,
> +                                           const char *name, void *opaque,
> +                                           Error **errp)
> +{
> +    HexagonDspMachineState *dms = HEXAGON_DSP_MACHINE(obj);
> +    uint32_t value;
> +
> +    if (!visit_type_uint32(v, name, &value, errp)) {
> +        return;
> +    }
> +    if (!value || !QEMU_IS_ALIGNED(value, 64 * KiB)) {
> +        error_setg(errp, "subsystem-base must be nonzero and 64 KiB aligned");
> +        return;
> +    }
> +
> +    dms->subsystem_base = value;
> +}
> +
> +static void add_dsp_properties(ObjectClass *oc)
> +{
> +    object_class_property_add(oc, "subsystem-base", "uint32",
> +                              hexagon_sim_get_subsystem_base,
> +                              hexagon_sim_set_subsystem_base, NULL, NULL);
> +    object_class_property_set_description(oc, "subsystem-base",
> +                                          "Simulator subsystem base address");
> +}
> +
> +static void hexagon_dsp_init(Object *obj)
> +{
> +    HexagonDspMachineState *dms = HEXAGON_DSP_MACHINE(obj);
> +
> +    dms->subsystem_base = HEXAGON_DSP_SUBSYSTEM_BASE;
> +}
> +
>  static void hexagon_common_init(MachineState *machine, Rev_t rev,
>                                  const struct hexagon_machine_config *m_cfg)
>  {
> @@ -121,7 +169,13 @@ static void hexagon_common_init(MachineState *machine, Rev_t rev,
>  
>      machine->enable_graphics = 0;
>  
> -    hex_subsys_create(hms, m_cfg, rev);
> +    dms->config = *m_cfg;
> +    dms->config.csr_base = dms->subsystem_base;
> +    dms->config.l2vic_base = dms->subsystem_base + HEXAGON_L2VIC_OFFSET;
> +    dms->config.qtmr_region = dms->subsystem_base + HEXAGON_QTIMER_OFFSET;

Since the only requirement on `subsystem_base` is that it's non-zero and
64 KiB aligned, this addition can overflow with e.g.
`subsystem-base=0xffff0000`, adding an upper-bounds check to the set
function could be nice to avoid any footguns in the future.


> +    dms->config.cfgtable.subsystem_base = dms->subsystem_base >> 16;
> +
> +    hex_subsys_create(hms, &dms->config, rev);
>  
>      g_autofree HexagonCPU **cpus = g_new(HexagonCPU *, machine->smp.cpus);
>  
> @@ -183,6 +237,7 @@ static void v66g_1024_init(ObjectClass *oc, const void *data)
>      mc->is_default = true;
>      mc->default_cpu_type = TYPE_HEXAGON_CPU_V66;
>      mc->default_cpus = 4;
> +    add_dsp_properties(oc);
>  }

-- 
Anton Johansson
rev.ng Labs Srl.

