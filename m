Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01792E81BAF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 12:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpQYM-0006xn-7a; Mon, 09 Feb 2026 07:39:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vpQYL-0006xc-1w
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 07:39:45 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vpQYI-0002GE-Ln
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 07:39:44 -0500
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f8kkn4xSGzJ46Zr;
 Mon,  9 Feb 2026 20:38:25 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id E0FC040539;
 Mon,  9 Feb 2026 20:39:22 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Feb
 2026 12:39:21 +0000
Date: Mon, 9 Feb 2026 12:39:19 +0000
To: Gregory Price <gourry@gourry.net>, <linuxarm@huawei.com>
CC: Alireza Sanaee <alireza.sanaee@huawei.com>, <qemu-devel@nongnu.org>,
 <jonathan.cameron@huawei.com>, <nifan.cxl@gmail.com>,
 <anisa.su887@gmail.com>, <mst@redhat.com>, <armbru@redhat.com>,
 <lizhijian@fujitsu.com>, <ppbonzini@redhat.com>, <peterx@redhat.com>,
 <philmd@linaro.org>, <david@kernel.org>, <imammedo@redhat.com>,
 <xiaoguangrong.eric@gmail.com>, <venkataravis@micron.com>
Subject: Re: [PATCH v2 0/2] Performant CXL type 3 non-interleaved regions
Message-ID: <20260209123904.00006237@huawei.com>
In-Reply-To: <aYlR2loIsnf8Q6YR@gourry-fedora-PF4VCD3F>
References: <20260204150002.669-1-alireza.sanaee@huawei.com>
 <aYlR2loIsnf8Q6YR@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, 8 Feb 2026 22:17:46 -0500
Gregory Price <gourry@gourry.net> wrote:

> On Wed, Feb 04, 2026 at 02:59:59PM +0000, Alireza Sanaee wrote:
> > The CXL address to device decoding logic is complex because of the need
> > to correctly decode fine grained interleave. The current implementation
> > prevents use with KVM where executed instructions may reside in that
> > memory and gives very slow performance even in TCG.
> > 
> > In many real cases non interleaved memory configurations are useful and
> > for those we can use a more conventional memory region alias allowing
> > similar performance to other memory in the system.
> > 
> > Whether this fast path is applicable can be established once the full
> > set of HDM decoders has been committed (in whatever order the guest
> > decides to commit them). As such a check is performed on each commit /
> > uncommit of HDM decoder to establish if the alias should be added or
> > removed.
> >   
> 
> Tested this on top of Jonathan's most recent draft branch, works nicely
> (with obvious fixups mentioned here). Has been working nicely.
> 
> Tested-by: Gregory Price <gourry@gourry.net>
> 
> 
> ----
> 
> Jonathan the HACK patch was giving me issues with registers getting
> plopped in the middle of a CFMW, not sure if this is the right fix or not
> 
> Fixes: 9a1b11bc03 hw/i386/pc: Add Aspeed i2c controller + MCTP with ACPI table

I'm kind of planning to drop the I2C / MCTP stuff anyway very soon as the
USB route is much less hacky and avoids need for hiding these registers somewhere.

I'll push a new draft branch soon (probably later this week) - Ideally that'll have
the DCD equivalent of this fast path as well.

The code definitely looks wrong.  If I keep the I2C stuff in my tree I'll
try and figure out what it should be doing...

Note if anyone sees this and really wants the I2C stuff then shout.
If not I'll drop it and see if anyone shouts ;)

Thanks!

Jonathan


> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f9d0bb3b41..9c244d40a7 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -957,8 +957,8 @@ void pc_memory_init(PCMachineState *pcms,
>          memory_region_init(mr, OBJECT(machine), "cxl_host_reg", cxl_size);
>          memory_region_add_subregion(system_memory, cxl_base, mr);
>          cxl_base = ROUND_UP(cxl_base + cxl_size, 256 * MiB);
> -        pcms->i2c_base = cxl_base + cxl_size - 0x4000;

At first glance I thing this is misplaced and should be before the line
above that updates the cxl_base.  It's still a horrible hack as it
will be grabbing a bit of the host reg space and relying on their
not being so many host bridges that we run out of space and get an overlap
for that.

>          cxl_resv_end = cxl_fmws_set_memmap(cxl_base, maxphysaddr);
> +        pcms->i2c_base = cxl_resv_end + 0x1000;
>          cxl_fmws_update_mmio();
>      }
> 


