Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A8DC3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 11:42:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPhJw-0004Os-45; Fri, 05 Jul 2024 07:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sPhJU-0003xe-UG
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 07:41:22 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sPhJO-0007tK-Tb
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 07:41:16 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFs5L1wLXz6JBW1;
 Fri,  5 Jul 2024 19:40:22 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 66FD5140B55;
 Fri,  5 Jul 2024 19:41:06 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 5 Jul
 2024 12:41:06 +0100
Date: Fri, 5 Jul 2024 12:41:04 +0100
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, <qemu-devel@nongnu.org>, Li Zhijian
 <lizhijian@fujitsu.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH qemu 0/3] hw/cxl: Misc minor improvements
Message-ID: <20240705123930.000064e8@huawei.com>
In-Reply-To: <20240702143425.717452-1-Jonathan.Cameron@huawei.com>
References: <20240702143425.717452-1-Jonathan.Cameron@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.174.77]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 2 Jul 2024 15:34:22 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Before pushing on to more significant features a few unrelated patches
> doing tidying up + one to avoid people setting the memory backend both
> for a CXL type 3 device and as normal RAM in an attempt to get SRAT to
> cover it correctly.  We've had multiple 'bug' reports from this and if
> nothing else I'd like to stop getting those!
> 
> Based on master + the two DCD series Michael Tsirkin has queued.
> 
> Based-on: [PATCH v8 00/14] Enabling DCD emulation support in Qemu
> Based-on: https://lore.kernel.org/qemu-devel/20240523174651.1089554-1-nifan.cxl@gmail.com/
> Based-on: [PATCH qemu 0/2] hw/cxl: DCD tweaks and improvements.
> Based-on: https://lore.kernel.org/qemu-devel/20240625170805.359278-1-Jonathan.Cameron@huawei.com/

I'll send a v2 that replaces the unused cfmw_list with the fix
that makes us of it to avoid a crash.


> 
> Fan Ni (1):
>   hw/cxl/cxl-mailbox-utils: remove unneeded mailbox output payload space
>     zeroing
> 
> Jonathan Cameron (1):
>   hw/cxl: Check for multiple mappings of memory backends.
> 
> Li Zhijian (1):
>   hw/cxl: Get rid of unused cfmw_list
> 
>  include/hw/cxl/cxl.h       |  1 -
>  hw/cxl/cxl-host.c          |  1 -
>  hw/cxl/cxl-mailbox-utils.c |  7 -------
>  hw/mem/cxl_type3.c         | 15 +++++++++++++++
>  4 files changed, 15 insertions(+), 9 deletions(-)
> 


