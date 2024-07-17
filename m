Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95152C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 15:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU6lo-00012d-2L; Wed, 17 Jul 2024 11:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sU6lm-000122-6N
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 11:40:42 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sU6lk-00014L-Db
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 11:40:41 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WPKqP1Jtlz6D8XN;
 Wed, 17 Jul 2024 23:39:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id DD731140B30;
 Wed, 17 Jul 2024 23:40:31 +0800 (CST)
Received: from localhost (10.122.19.247) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 17 Jul
 2024 16:40:31 +0100
Date: Wed, 17 Jul 2024 16:40:30 +0100
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Igor Mammedov <imammedo@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>,
 <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, "Dave Jiang" <dave.jiang@intel.com>, Huang
 Ying <ying.huang@intel.com>, "Paolo Bonzini" <pbonzini@redhat.com>,
 <eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>, Ani Sinha
 <anisinha@redhat.com>
Subject: Re: [PATCH v5 10/13] hw/acpi: Generic Port Affinity Structure support
Message-ID: <20240717164030.000013fe@huawei.com>
In-Reply-To: <20240717110827-mutt-send-email-mst@kernel.org>
References: <20240712110837.1439736-1-Jonathan.Cameron@huawei.com>
 <20240712110837.1439736-11-Jonathan.Cameron@huawei.com>
 <20240715164841.1979fdea@imammedo.users.ipa.redhat.com>
 <20240717160258.00006893@huawei.com>
 <20240717110827-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 17 Jul 2024 11:11:06 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Jul 17, 2024 at 04:02:58PM +0100, Jonathan Cameron wrote:
> > On Mon, 15 Jul 2024 16:48:41 +0200
> > Igor Mammedov <imammedo@redhat.com> wrote:
> >   
> > > On Fri, 12 Jul 2024 12:08:14 +0100
> > > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > >   
> > > > These are very similar to the recently added Generic Initiators
> > > > but instead of representing an initiator of memory traffic they
> > > > represent an edge point beyond which may lie either targets or
> > > > initiators.  Here we add these ports such that they may
> > > > be targets of hmat_lb records to describe the latency and
> > > > bandwidth from host side initiators to the port.  A discoverable
> > > > mechanism such as UEFI CDAT read from CXL devices and switches
> > > > is used to discover the remainder of the path, and the OS can build
> > > > up full latency and bandwidth numbers as need for work and data
> > > > placement decisions.
> > > > 
> > > > Acked-by: Markus Armbruster <armbru@redhat.com>
> > > > Tested-by: "Huang, Ying" <ying.huang@intel.com>
> > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>    
> > > 
> > > ACPI tables generation LGTM
> > > As for the rest my review is perfunctory mostly.  
> > 
> > The node type points and missing descriptor applying equally to generic
> > initiators. I'll add a couple of patches cleaning that up as well as 
> > fixing them up for generic ports.
> > 
> > For the exit(1) that was copying other similar locations. I don't
> > mind changing it though if something else is preferred.
> > 
> > Given tight timescales (and I was away for a few days which didn't
> > help), I'll send out a v6 with changes as below.
> > 
> > Jonathan
> >   
> 
> I'm working on a pull and going offline for a week guys, what's not in
> will be in the next release.  Sorry.

No problem. Thanks for letting us know!

In that case I'll sit on v6 for a while and hopefully we can get it
lined up early next cycle without too much bios-tables test churn pain.

Jonathan

