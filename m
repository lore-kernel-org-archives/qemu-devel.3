Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D826D606A333
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 19:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PSCf1u4R
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVZZr-0000mY-Uu; Mon, 23 Nov 2026 14:19:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xVZZk-0000lS-Ur; Mon, 23 Nov 2026 14:19:41 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xVZZi-0006Oy-Q8; Mon, 23 Nov 2026 14:19:40 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9A6CB41398;
 Mon, 23 Nov 2026 19:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A1E1F000EB;
 Mon, 23 Nov 2026 19:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795461576;
 bh=CGC7yVQLVDvNpMPVZ/Uo1pixnvVv0k954KwZmg9TrVg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=PSCf1u4RQo66p4AxW2s9rKw3UIiOojrW919uIBhnXqfrEauQq5IkB5N2bvCBpacGF
 FiK8D/C5CQZ3hG4G8lj6fq7KVW2ub1e8iW9LQQ7QAdd20b0UGfdaOa+tucKXbHlf+U
 Q9SFJ8Jvz+k1kkUcLFdQsU7lEOII00JVqelMvkD+YAZVjBBhxGwTj2VG9ZXvv4MPIL
 Okq7E4UEyJkw/m1ADQFNGZH0QWNIbUFj79spPMsa7mNjLcsI0WCLWi5Pp5ZDaA3J+j
 ZkpFQacRDdSCcnhvrsJu8++SqUBdeo4/TF3Ot8Hz39Yj8kItaMyG3CK5bDoINH1p36
 pymuZ5UphXL3w==
Date: Mon, 23 Nov 2026 11:19:34 -0800
From: Drew Fustini <fustini@kernel.org>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Sunil V L <sunilvl@oss.qualcomm.com>,
 Anup Patel <anup.patel@oss.qualcomm.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicolas Pitre <npitre@baylibre.com>,
 Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
 Atish Patra <atish.patra@linux.dev>,
 Radim =?utf-8?B?S3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>,
 yunhui cui <cuiyunhui@bytedance.com>,
 Chen Pei <cp0613@linux.alibaba.com>, guo.wenjia23@zte.com.cn,
 liu.qingtao2@zte.com.cn, Jinjie Ruan <ruanjinjie@huawei.com>,
 Jinjie Ruan <2118537295@qq.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Vasudevan Srinivasan <vasu@rivosinc.com>
Subject: Re: [PATCH v2 1/2] hw/riscv: add cache_level and node properties to
 CBQRI controllers
Message-ID: <awSRxt903KEHUHYQ@thelio>
References: <20261113-riscv-rqsc-v2-0-34d47fa4141e@kernel.org>
 <20261113-riscv-rqsc-v2-1-34d47fa4141e@kernel.org>
 <51e50192-328b-4780-aea1-06dbd89be222@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51e50192-328b-4780-aea1-06dbd89be222@oss.qualcomm.com>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=fustini@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 11:03:15AM -0300, Daniel Henrique Barboza wrote:
> 
> 
> On 11/13/2026 8:12 PM, Drew Fustini wrote:
> > The ACPI RQSC table specifies which cache a capacity controller backs
> > and which proximity domain a bandwidth controller serves.
> > 
> > Add a cache_level property to the capacity controller. It accepts 2 or
> > 3, the unified cache levels that the smp-cache option can place and the
> > PPTT can describe, and defaults to 2. Add a node property to the
> > bandwidth controller. It defaults to 0 and rejects a node the machine
> > does not have.
> > 
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
> > ---
> >   hw/riscv/cbqri_bandwidth.c | 13 +++++++++++++
> >   hw/riscv/cbqri_capacity.c  |  8 ++++++++
> >   2 files changed, 21 insertions(+)
> > 
> > diff --git a/hw/riscv/cbqri_bandwidth.c b/hw/riscv/cbqri_bandwidth.c
> > index bd8cf2b50e4c..6c33d1738d27 100644
> > --- a/hw/riscv/cbqri_bandwidth.c
> > +++ b/hw/riscv/cbqri_bandwidth.c
> > @@ -17,7 +17,9 @@
> >   #include "hw/core/sysbus.h"
> >   #include "migration/vmstate.h"
> >   #include "target/riscv/cpu.h"
> > +#include "hw/core/boards.h"
> >   #include "hw/riscv/cbqri.h"
> > +#include "system/numa.h"
> >   /* Property defaults, shared with riscv_cbqri_bc_caps_init() */
> >   #define BC_DEFAULT_MAX_MCIDS    256
> > @@ -139,6 +141,7 @@ typedef struct RiscvCbqriBandwidthState {
> >       uint16_t nbwblks;
> >       uint16_t mrbwb;
> > +    uint32_t node;
> >       bool supports_at_code;
> > @@ -542,12 +545,21 @@ static const MemoryRegionOps riscv_cbqri_bc_ops = {
> >   static void riscv_cbqri_bc_realize(DeviceState *dev, Error **errp)
> >   {
> >       RiscvCbqriBandwidthState *bc = RISCV_CBQRI_BC(dev);
> > +    MachineState *ms = MACHINE(qdev_get_machine());
> > +    unsigned int nb_nodes = ms->numa_state ? ms->numa_state->num_nodes : 0;
> >       if (!bc->mmio_base) {
> >           error_setg(errp, "mmio_base property not set");
> >           return;
> >       }
> > +    /* Without -numa there is a single implicit node 0. */
> > +    if (bc->node >= MAX(nb_nodes, 1)) {
> > +        error_setg(errp, "node %u out of range, %u NUMA node(s)",
> > +                   bc->node, MAX(nb_nodes, 1));
> > +        return;
> > +    }
> > +
> >       if (bc->nb_rcids == 0) {
> >           error_setg(errp, "max_rcids must be at least 1");
> >           return;
> > @@ -638,6 +650,7 @@ static const Property riscv_cbqri_bc_properties[] = {
> >                          BC_DEFAULT_NBWBLKS),
> >       DEFINE_PROP_UINT16("mrbwb", RiscvCbqriBandwidthState, mrbwb,
> >                          BC_DEFAULT_MRBWB),
> > +    DEFINE_PROP_UINT32("node", RiscvCbqriBandwidthState, node, 0),
> >       DEFINE_PROP_BOOL("at_code", RiscvCbqriBandwidthState,
> >                        supports_at_code, true),
> > diff --git a/hw/riscv/cbqri_capacity.c b/hw/riscv/cbqri_capacity.c
> > index 0c572aa8b02f..1585cad1d073 100644
> > --- a/hw/riscv/cbqri_capacity.c
> > +++ b/hw/riscv/cbqri_capacity.c
> > @@ -127,6 +127,7 @@ typedef struct RiscvCbqriCapacityState {
> >       uint16_t nb_rcids;
> >       uint16_t ncblks;
> > +    uint8_t cache_level;
> >       bool supports_at_code;
> > @@ -591,6 +592,11 @@ static void riscv_cbqri_cc_realize(DeviceState *dev, Error **errp)
> >           return;
> >       }
> > +    if (cc->cache_level != 2 && cc->cache_level != 3) {
> > +        error_setg(errp, "cache_level must be 2 or 3");
> > +        return;
> > +    }
> > +
> 
> For this kind of property that has a very specific and restrictive value range (i.e.
> we'll abort if we don't get what we want), I suggest not using DEFINE_PROP_UINT8()
> to declare the prop in the array.
> 
> What we do in target/riscv/cpu.c in for 'num-pmp-regions':
> 
> 
> static void prop_num_pmp_regions_set(Object *obj, Visitor *v, const char *name,
>                                      void *opaque, Error **errp)
> {
>     RISCVCPU *cpu = RISCV_CPU(obj);
>     uint8_t value;
> 
>     visit_type_uint8(v, name, &value, errp);
> 
>     (... a bunch of checks ....)
> }
> 
> static void prop_num_pmp_regions_get(Object *obj, Visitor *v, const char *name,
>                                      void *opaque, Error **errp)
> {
>     uint8_t value = RISCV_CPU(obj)->cfg.pmp_regions;
> 
>     visit_type_uint8(v, name, &value, errp);
> }
> 
> static const PropertyInfo prop_num_pmp_regions = {
>     .type = "uint8",
>     .qapi_type = &uint8_type_info,
>     .description = "num-pmp-regions",
>     .get = prop_num_pmp_regions_get,
>     .set = prop_num_pmp_regions_set,
> };
> 
> 
> And this is added in a property array like this:
> 
> {.name = "num-pmp-regions", .info = &prop_num_pmp_regions},
> 
> 
> This is more verbose but it will make realize() easier since the property
> is guaranteed to be valid. 'cache_level' seems like a good candidate for
> this kind of pattern.

That makes sense. I'll change cache_level to a custom PropertyInfo and
remove the check from realize.

Drew

