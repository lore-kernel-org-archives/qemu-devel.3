Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A12109B47F
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 14:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7aR5-0005WN-Ee; Tue, 31 Mar 2026 10:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1w7aQx-0005VN-9U
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 10:51:13 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1w7aQu-0000uC-3z
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 10:51:11 -0400
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4flWJ76QhRzJ4681;
 Tue, 31 Mar 2026 22:50:31 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 7C61440575;
 Tue, 31 Mar 2026 22:50:50 +0800 (CST)
Received: from localhost (10.203.177.99) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 31 Mar
 2026 15:50:49 +0100
Date: Tue, 31 Mar 2026 15:50:44 +0100
To: Markus Armbruster <armbru@redhat.com>
CC: <qemu-devel@nongnu.org>, <anisa.su@samsung.com>, <berrange@redhat.com>,
 <eblake@redhat.com>, <jonathan.cameron@huawei.com>,
 <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, <lizhijian@fujitsu.com>,
 <mst@redhat.com>, <pbonzini@redhat.com>, <gourry@gourry.net>,
 <nifan.cxl@gmail.com>, <me@linux.beauty>, <ira.weiny@intel.com>
Subject: Re: [PATCH 9/9] hw/cxl: Add QMP status query for dynamic-capacity
 extent release
Message-ID: <20260331155044.0000603d.alireza.sanaee@huawei.com>
In-Reply-To: <87zf3s1ohc.fsf@pond.sub.org>
References: <20260325184259.366-1-alireza.sanaee@huawei.com>
 <20260325184259.366-10-alireza.sanaee@huawei.com>
 <87mrzuei5f.fsf@pond.sub.org>
 <20260327151811.00005564.alireza.sanaee@huawei.com>
 <87zf3s1ohc.fsf@pond.sub.org>
Organization: Huawei
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.99]
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, 28 Mar 2026 07:01:51 +0100
Markus Armbruster <armbru@redhat.com> wrote:

+CC Ira

Hi Markus,

Please look inline. I believe Ira might be able to help and we can see what he thinks.

> Alireza Sanaee <alireza.sanaee@huawei.com> writes:
> 
> > On Thu, 26 Mar 2026 16:15:40 +0100
> > Markus Armbruster <armbru@redhat.com> wrote:
> >
> > Hi Markus,
> >
> > This commit adds a test command to check whether an extent (a piece of memory region) has been released or not by the guest.
> > The process of removal is highly asynchronous, that's why I needed to add a new command to check it.
> >
> > I would be happy to drop this patch, as this is extra.  
> 
> So your motivation for adding the command is "just" testing.  Correct?

I wrote tests to make sure extents were released, and I used this QMP command to check.

Now there is background about extents where DCD was developed in Linux by @Ira, CCed [1].

In the DCD extent tracking section of the CXL spec, I see some commands 
related to getting the extent list, maybe Ira can comment here. To be fair, knowing if an extent
was released or not is a useful information in general from orchestrator perspective.

[1] https://patchew.org/linux/20250413-dcd-type2-upstream-v9-0-1d4911a0b365@intel.com/

> 
> Can you think of other uses?
> 
> In particular, would a management application need this query to monitor
> removal?

I think management will get a signal on the removal given the schema in Ira's Linux kernel 
patchset. I do not think this is implemented in QEMU at least (I might be missing something).

> 
> The description of feature @unstable may need to be adjusted for the
> answers we work out here.

Absolutely.

> 
> >
> > Thanks,
> > Ali  
> 
> 


