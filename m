Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 600E0CAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 09:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5hHl-0007Mg-RP; Mon, 06 Oct 2025 05:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1v5hHj-0007MV-MX
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 05:13:35 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1v5hHg-0006nj-KW
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 05:13:35 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cgD7Q1g93z6L52J;
 Mon,  6 Oct 2025 17:12:34 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id BD3B51402EB;
 Mon,  6 Oct 2025 17:13:06 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 6 Oct
 2025 10:13:05 +0100
Date: Mon, 6 Oct 2025 10:13:04 +0100
To: Jonathan Cameron via <qemu-devel@nongnu.org>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Michael Tsirkin
 <mst@redhat.com>, <shiju.jose@huawei.com>, Davidlohr Bueso
 <dave@stgolabs.net>, <armbru@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, Ravi Shankar
 <venkataravis@micron.com>
Subject: Re: [PATCH qemu for 10.2 0/3] cxl: Additional RAS features support.
Message-ID: <20251006101304.000055f8@huawei.com>
In-Reply-To: <20250917143330.294698-1-Jonathan.Cameron@huawei.com>
References: <20250917143330.294698-1-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 17 Sep 2025 15:33:27 +0100
Jonathan Cameron via <qemu-devel@nongnu.org> wrote:

> These two features have been used in testing the related EDAC RAS
> features drivers in Linux which are now upstream. Only minor tweaks
> from the second part of:
> https://lore.kernel.org/qemu-devel/20250811085530.2263-1-shiju.jose@huawei.com/
> [PATCH v6 0/8] hw/cxl: Update CXL events to rev3.2 and add maintenance support for memory repair features
> 
> I've split that series up as the two parts were only slightly connected.
> However there is some churn if this is applied without the other part of Shiju's posted
> series. That was sent a few minutes ago as:
> https://lore.kernel.org/qemu-devel/20250917141355.293217-1-Jonathan.Cameron@huawei.com/
> 
> Based on: [PATCH qemu for 10.2 0/5] cxl: r3.2 specification events updates.
> Based on: 20250917141355.293217-1-Jonathan.Cameron@huawei.com
> 
> Davidlohr Bueso (1):
>   hw/cxl: Add support for Maintenance command and Post Package Repair
>     (PPR)
> 
Hi Michael,

I see you have queued some stuff up on your gitlab tree.
Just wanted to make sure these are on the radar for possible inclusion.
No huge rush, but I'll queue some more series up on top of these
shortly.

Thanks

Jonathan

> Shiju Jose (2):
>   hw/cxl/cxl-mailbox-utils: Move declaration of scrub and ECS feature
>     attributes in cmd_features_set_feature()
>   hw/cxl: Add emulation for memory sparing control feature
> 
>  include/hw/cxl/cxl_device.h | 145 +++++++++
>  include/hw/cxl/cxl_events.h |  47 +++
>  hw/cxl/cxl-mailbox-utils.c  | 566 +++++++++++++++++++++++++++++++++++-
>  hw/mem/cxl_type3.c          | 169 +++++++++++
>  4 files changed, 915 insertions(+), 12 deletions(-)
> 


