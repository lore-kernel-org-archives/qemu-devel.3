Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDB9606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 00:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DvXyImnK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMaKI-0000bv-3e; Thu, 29 Oct 2026 20:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xMaKA-0000bb-KW; Thu, 29 Oct 2026 20:18:26 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xMaK8-0001nO-RU; Thu, 29 Oct 2026 20:18:26 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6A42A600C8;
 Fri, 30 Oct 2026 00:18:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5461F000C1;
 Fri, 30 Oct 2026 00:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793319503;
 bh=WuGHYVzDuxwauqa9MbwOEzi/k1QnT3+qqkE6pGCP28E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=DvXyImnKu8K0Jn8fHARur07InJ9NehRsrD0h9C6CiuFm4bmqehuKV8OPW65m4rQTy
 l/rnXLbBDrO1qky3INL6RkWeRBdv/0OaGdre13WS5NWBggG3B5DXlAqXVZ9+u9U5ul
 lYFu2T0C7lSAt8PbS94IEl20kUeXKee3hLUczzh0+RgwGqzNyjZbbPMSZlPuFQ0/IH
 t7+Mi6XKGbNNQjbsGbsjH/3MjJlPxs3JQT8FgboUZiGFAQgX12Z7JLhSJVKR6mVS7r
 obGGI8ohOs5Avk6hxZ6lSvLakerWDMdyvZL9SaYZheg6N4/ci3q9K6mCeQ0qcjQfrf
 Yz1s9Vm3307Eg==
Date: Thu, 29 Oct 2026 17:18:21 -0700
From: Drew Fustini <fustini@kernel.org>
To: Prajwal N <prajwal.n@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Sunil V L <sunilvl@oss.qualcomm.com>,
 Anup Patel <anup.patel@oss.qualcomm.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicolas Pitre <npitre@baylibre.com>,
 Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
 Atish Patra <atish.patra@linux.dev>,
 Radim =?utf-8?B?S3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>,
 yunhui cui <cuiyunhui@bytedance.com>,
 Chen Pei <cp0613@linux.alibaba.com>, guo.wenjia23@zte.com.cn,
 liu.qingtao2@zte.com.cn, prajwal.n.oss@gmail.com
Subject: Re: [PATCH v6 6/6] hw/riscv: add CBQRI controllers to virt machine
Message-ID: <auPiTQKsB1syQLIl@thelio>
References: <20261026-riscv-ssqosid-cbqri-v6-0-1a367a35cd0e@kernel.org>
 <20261026-riscv-ssqosid-cbqri-v6-6-1a367a35cd0e@kernel.org>
 <af95947c-62aa-46ad-82e9-1720be6fefde@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af95947c-62aa-46ad-82e9-1720be6fefde@oss.qualcomm.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 07:26:33PM +0530, Prajwal N wrote:
> Hi Drew,
> 
> On 26-10-2026 23:17, Drew Fustini wrote:
> > From: Nicolas Pitre <npitre@baylibre.com>
> > 
> > Add CBQRI controllers to the RISC-V virt machine. The device properties
> > can be fully configured from the command line:
[..]
> > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > index d4b501802f60..dbc0f8cfc8d7 100644
> > --- a/hw/riscv/virt.c
> > +++ b/hw/riscv/virt.c
> > @@ -57,6 +57,7 @@
> >  #include "hw/pci-host/gpex.h"
> >  #include "hw/display/ramfb.h"
> >  #include "hw/acpi/aml-build.h"
> > +#include "hw/riscv/cbqri.h"
> >  #include "qapi/qapi-visit-common.h"
> >  #include "hw/virtio/virtio-iommu.h"
> >  #include "hw/uefi/var-service-api.h"
> > @@ -1157,6 +1158,8 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
> >  #ifdef CONFIG_TPM
> >      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
> >  #endif
> > +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RISCV_CBQRI_BC);
> > +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RISCV_CBQRI_CC);
> 
> When the controller device is created dynamically through the QEMU command line, the
> corresponding device tree node must also be created. As I do not see the implementation
> to add the DT node in this series, Could you please clarify how it is created.?

I have been using a static dtb for the purposes of testing the CBQRI
support in Linux against QEMU. The Linux RFC [1] carried a
"not for upstream" patch containing a dts for the virt machine with
the controller nodes added.

I would prefer to keep this series limited to the current scope, and I
had planned to implement device tree generation in a follow-up series,
as well as send an updated version of the ACPI RQSC series [2]. I'll add
a note about this to the cover letter in the next rev.

Thanks,
Drew

[1] https://lore.kernel.org/all/20260119-ssqosid-cbqri-v1-18-aa2a75153832@kernel.org/
[2] https://lore.kernel.org/all/20260202-riscv-rqsc-v1-0-dcf448a3ed73@kernel.org/

