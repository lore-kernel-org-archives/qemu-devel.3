Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC57C606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 19:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a9r872ea
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVZIM-0005X3-Q0; Mon, 23 Nov 2026 14:01:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xVZIF-0005Wh-Hn; Mon, 23 Nov 2026 14:01:36 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xVZIC-0004Ih-PI; Mon, 23 Nov 2026 14:01:35 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C466960E78;
 Mon, 23 Nov 2026 19:01:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E941F000D8;
 Mon, 23 Nov 2026 19:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795460490;
 bh=yF8s4I128h0jma8G2CoWLB2tN4B9FIRzKu1SAUPL7no=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=a9r872eavBWHy/CKqK89vXMiVZnKDoHd7HFT4LurLzYLpmCinK81c02qD3t5yQOmt
 rAq0jQ6sOIVxMsz2cEun4yto4ghl8DtIePdQylR/RqpxhIfRBN0DDe300jpQFNnhxU
 8mCRPXNsrnFuDk3htZElSiz6chwiNQXOFD4x1UvP8bPRyykmTvAUYM97JrDW6ik4Xy
 AVmdccZwfCG8ecYTG6NPAIA++o29GJ+gWy8gCZuv0hxFDv16fW09bOjQOFtVhuet52
 YpW0VlrBzetM/d9ZTgansSinkZbooZT28aEEfoK8Qve6nzmo+/lItrnnOVh/25V8Jm
 tIjbGlzP9GJxg==
Date: Mon, 23 Nov 2026 11:01:28 -0800
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
Subject: Re: [PATCH v2 2/2] hw/riscv: add support for ACPI RQSC table
Message-ID: <awSNiOvvKuSM807q@thelio>
References: <20261113-riscv-rqsc-v2-0-34d47fa4141e@kernel.org>
 <20261113-riscv-rqsc-v2-2-34d47fa4141e@kernel.org>
 <bd116e02-a7b2-4b90-bbee-b855111d2411@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd116e02-a7b2-4b90-bbee-b855111d2411@oss.qualcomm.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=fustini@kernel.org; helo=tor.source.kernel.org
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 11:15:38AM -0300, Daniel Henrique Barboza wrote:
> On 11/13/2026 8:12 PM, Drew Fustini wrote:
> > Build the ACPI RISC-V Quality of Service Controllers (RQSC) table for
> > the virt machine when CBQRI controllers are present. A capacity
> > controller is described by the PPTT Cache ID of the cache it backs and
> > a bandwidth controller by the SRAT proximity domain of its NUMA node.
> > 
> > Make RISCV_VIRT select RISCV_CBQRI as the table code calls into the
> > CBQRI devices.
> > 
> > Link: https://github.com/riscv-non-isa/riscv-rqsc/releases/tag/v1.0.0
> > Co-developed-by: Vasudevan Srinivasan <vasu@rivosinc.com>
> > Signed-off-by: Vasudevan Srinivasan <vasu@rivosinc.com>
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
> > ---
> >   hw/riscv/Kconfig           |   2 +-
> >   hw/riscv/cbqri_bandwidth.c |  13 ++
> >   hw/riscv/cbqri_capacity.c  |  13 ++
> >   hw/riscv/virt-acpi-build.c | 298 ++++++++++++++++++++++++++++++++++++++++++++-
> >   include/hw/riscv/cbqri.h   |  20 +++
> >   5 files changed, 344 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> > index 98bdebb4b814..47dda3e52d20 100644
> > --- a/hw/riscv/Kconfig
> > +++ b/hw/riscv/Kconfig
> > @@ -71,7 +71,7 @@ config RISCV_VIRT
> >       select PLATFORM_BUS
> >       select ACPI
> >       select ACPI_PCI
> > -    imply RISCV_CBQRI
> > +    select RISCV_CBQRI
> >   config RISCV_SERVER_PLATFORM_REF
> >       bool
> > diff --git a/hw/riscv/cbqri_bandwidth.c b/hw/riscv/cbqri_bandwidth.c
> > index 6c33d1738d27..c55709d662f2 100644
> > --- a/hw/riscv/cbqri_bandwidth.c
> > +++ b/hw/riscv/cbqri_bandwidth.c
> > @@ -760,4 +760,17 @@ DeviceState *riscv_cbqri_bc_create(hwaddr addr,
> >       return dev;
> >   }
> > +void riscv_cbqri_bc_get_details(DeviceState *ds, const char *type,
> > +                                RqscController *rqsc)
> > +{
> > +    if (strcmp(type, TYPE_RISCV_CBQRI_BC) == 0) {
> 
> The only existing caller for riscv_cbqri_bc_get_details() is already doing this
> check:
> 
> 
> > +        bool is_bc = !strcmp(type, TYPE_RISCV_CBQRI_BC);
> 
> (...)
> 
> > +        if (is_bc) {
> > +            riscv_cbqri_bc_get_details(kid->child, type, &rqsc[count]);
> > +        }
> 
> 
> Unless there are plans to add new callers that will unsafely call the function
> without guaranteeing that the device type is correct, I suggest removing the
> redundant strcmp().
> 
> Same thing with riscv_cbqri_cc_get_details() below.

Good point, I'll remove the redundant checks.

> Otherwise LGTM.  Thanks,
> Daniel

Thanks for reviewing!

Drew

