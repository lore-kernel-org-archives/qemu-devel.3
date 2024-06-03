Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A4EBC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 17:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEBAS-0002ac-T6; Mon, 03 Jun 2024 13:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sEBAQ-0002Zq-DO
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 13:08:18 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sEBAN-00029q-8D
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 13:08:18 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VtKn94qRzz6K6nt;
 Tue,  4 Jun 2024 01:03:41 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id E472E140A79;
 Tue,  4 Jun 2024 01:08:11 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 3 Jun
 2024 18:08:11 +0100
Date: Mon, 3 Jun 2024 18:08:10 +0100
To: Nam Cao <namcao@linutronix.de>
CC: Alex Williamson <alex.williamson@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 <qemu-devel@nongnu.org>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>
Subject: Re: [PATCH v2] pci-bridge/xio3130_downstream: fix invalid link
 speed and link width
Message-ID: <20240603180810.0000751b@Huawei.com>
In-Reply-To: <20240531103635.x9vzCtCv@linutronix.de>
References: <20240529201744.15420-1-namcao@linutronix.de>
 <20240531111400.000064f7@Huawei.com>
 <20240531103635.x9vzCtCv@linutronix.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Fri, 31 May 2024 12:36:35 +0200
Nam Cao <namcao@linutronix.de> wrote:

> On Fri, May 31, 2024 at 11:14:00AM +0100, Jonathan Cameron wrote:
> > On Wed, 29 May 2024 22:17:44 +0200
> > Nam Cao <namcao@linutronix.de> wrote:
> >   
> > > Set link width to x1 and link speed to 2.5 Gb/s as specified by the
> > > datasheet. Without this, these fields in the link status register read
> > > zero, which is incorrect.
> > > 
> > > This problem appeared since 3d67447fe7c2 ("pcie: Fill PCIESlot link fields
> > > to support higher speeds and widths"), which allows PCIe slot to set link
> > > width and link speed. However, if PCIe slot does not explicitly set these
> > > properties, they will be zero. Before this commit, the width and speed
> > > default to x1 and 2.5 Gb/s.
> > > 
> > > Fixes: 3d67447fe7c2 ("pcie: Fill PCIESlot link fields to support higher speeds and widths")
> > > Signed-off-by: Nam Cao <namcao@linutronix.de>  
> > Hi Nam,
> > 
> > I'm feeling a bit guilty about this one a known it was there for a while.
> > 
> > I was lazy when fixing the equivalent CXL case a while back on
> > basis no one had noticed and unlike CXL (where migration is broken for a lot
> > of reasons) fixing this may need to take into account migration from broken to
> > fixed versions.  Have you tested that?  
> 

I've run into problems in the past around updating config space registers
because when we migrate from a prepatch QEMU instance to a post patch 1 the
config space registers are compared. I'm not sure if LNKCAP is included
in that.  LNKSTA is explicitly ruled out I think.

For examples see all the machine version checks in
hw/core/machine.c

The one that bit me was fixed with x-pcie-err-unc-mask
when I was fixing a register that didn't match the spec defined values.


> I tested this patch with Linux kernel.
> 
> I noticed this bug when Linux complained that the PCI link was broken.
> Linux determines weather a link is up by checking if these speed/width
> fields have valid value.
> 
> Repro:
> 	qemu-system-x86_64 \
> 	-machine pc-q35-2.10 \
> 	-kernel bzImage \
> 	-drive "file=img,format=raw" \
> 	-m 2048 -smp 1 -enable-kvm \
> 	-append "console=ttyS0 root=/dev/sda debug" \
> 	-nographic \
> 	-device pcie-root-port,bus=pcie.0,slot=1,id=rp1,bus-reserve=253 \
> 	-device x3130-upstream,id=up1,bus=rp1 \
> 	-device xio3130-downstream,id=dp1,bus=up1,chassis=1,slot=1
> 
> Then after Linux has booted:
> 	device_add device_add e1000,bus=dp1,id=eth0
> 
> Then Linux complains that something is wrong with the link:
> pcieport 0000:02:00.0: pciehp: Slot(1-1): Cannot train link: status 0x2000
>  
> This patch gets rid of Linux's complain, and the hot-plug now works fine.
> 
> > I did the CXL fix slightly differently.  Can't remember why though - looking
> > at the fact it uses an instance_post_init, is there an issue with accidentally
> > overwriting the parameters?  Or did I just over engineer the fix?  
> 
> I would say over engineer. I think CXL does not take link speed and link
> width as parameters.

I've implemented control but this still ends up over engineered because
the reason I want to control this is to vary access parameters for calculating
latency and bandwidth.  That is easiest done by controlling the EP status
to degrade the link.  For that I just set the CAP register on the switch DSP
to allow suitably high values and let pcie_sync_bridge() match this to
the status of the EP (which I have properties to contro).
There seems to be only one way 'negotiation' of these parameters so it
needs to be EP driven.

Jonathan
> 
> Best regards,
> Nam


