Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D33C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 17:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVxNu-0001li-JH; Fri, 02 Feb 2024 12:31:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rVxNT-0001kg-66; Fri, 02 Feb 2024 12:31:01 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rVxNQ-0007p6-Ig; Fri, 02 Feb 2024 12:30:58 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TRN5F4lDlz6K647;
 Sat,  3 Feb 2024 01:27:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id BC1471400D4;
 Sat,  3 Feb 2024 01:30:48 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 2 Feb
 2024 17:30:48 +0000
Date: Fri, 2 Feb 2024 17:30:47 +0000
To: Peter Maydell <peter.maydell@linaro.org>
CC: Sia Jee Heng <jeeheng.sia@starfivetech.com>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>, <qemu-riscv@nongnu.org>, <mst@redhat.com>,
 <imammedo@redhat.com>, <anisinha@redhat.com>, <shannon.zhaosl@gmail.com>,
 <sunilvl@ventanamicro.com>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>, 
 <bin.meng@windriver.com>, <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>, 
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [RFC v1 3/3] hw/arm/virt-acpi-build.c: Enable CPU cache topology
Message-ID: <20240202173047.000053e9@Huawei.com>
In-Reply-To: <CAFEAcA80VjwM=uKEXfwtg9SVzX947of1Go2c0ph-r0DeyKbpMA@mail.gmail.com>
References: <20240129081423.116615-1-jeeheng.sia@starfivetech.com>
 <20240129081423.116615-4-jeeheng.sia@starfivetech.com>
 <20240129110823.000076df@Huawei.com>
 <CAFEAcA80VjwM=uKEXfwtg9SVzX947of1Go2c0ph-r0DeyKbpMA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 1 Feb 2024 16:06:55 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Mon, 29 Jan 2024 at 11:08, Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Mon, 29 Jan 2024 00:14:23 -0800
> > Sia Jee Heng <jeeheng.sia@starfivetech.com> wrote:
> >  
> > > Introduced a 3-layer cache for the ARM virtual machine.
> > >
> > > Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>  
> >
> > There are a bunch of CPU registers that also need updating to reflect the
> > described cache.
> > https://lore.kernel.org/qemu-devel/20230808115713.2613-3-Jonathan.Cameron@huawei.com/
> > It's called HACK for a reason ;)
> > But there is some discussion about this issue in the thread.
> >
> > The l1 etc also needs to reflect the CPU model.  This stuff needs to match.
> > Wrong information being passed to a VM is probably worse than no information.  
> 
> Yes. The ACPI table information, if we provide it, should be
> being generated from the CPU cache ID registers.

That + some additional information I think.

> 
> But I'm a bit confused about why the ACPI table has the cache
> topology in it -- can't the guest read the cache ID registers
> and figure it out for itself?

That's a philosophy question for the ARM architects :)

The registers focus on correctness (so what you need to flush etc,
where the point of coherence is and other fun)
not all the info needed for performance tuning. There is some stuff
on the cache type that I guess is more perf tuning related (sets etc)


They probably could have expanded the CPU registers to provide a lot
more information (which is what x86 effectively does). IIRC what is
there today for ARM is pretty much useless for anything placement
decision related (scheduling etc)  You can't tell what shares a cache
(or more fun cluster topology structures). 

It is hard in registers to define a nice flexible graph where
all sorts of fun topology of the system can be described.
PPTT provides that opportunity for a richer description.
Sure you could squirt out the equivalent table via registers,
but what's the point given we have firmware tables for this
sort of thing..

Jonathan


 

> 
> thanks
> -- PMM


