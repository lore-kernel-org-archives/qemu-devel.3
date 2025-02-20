Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26996C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl96w-0005x6-Ef; Thu, 20 Feb 2025 11:09:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tl96u-0005wc-49
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:09:12 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tl96r-0006oe-7v
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:09:11 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YzJ533zGPz6GBln;
 Fri, 21 Feb 2025 00:05:27 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 9753C1400D9;
 Fri, 21 Feb 2025 00:08:53 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 20 Feb
 2025 17:08:53 +0100
Date: Thu, 20 Feb 2025 16:08:50 +0000
To: Arpit Kumar <arpit1.kumar@samsung.com>
CC: <qemu-devel@nongnu.org>, <gost.dev@samsung.com>,
 <linux-cxl@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
 <vishak.g@samsung.com>, <krish.reddy@samsung.com>,
 <a.manzanares@samsung.com>, <alok.rathore@samsung.com>
Subject: Re: [PATCH v2 0/3] CXL CCI Log Commands implementation
Message-ID: <20250220160850.00003016@huawei.com>
In-Reply-To: <20250218085731.550029-1-arpit1.kumar@samsung.com>
References: <CGME20250218085809epcas5p3ee3d79ffec77b13bb097c6d15bb24710@epcas5p3.samsung.com>
 <20250218085731.550029-1-arpit1.kumar@samsung.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, 18 Feb 2025 14:27:28 +0530
Arpit Kumar <arpit1.kumar@samsung.com> wrote:

> CXL CCI log commands implmented as per CXL Specification 3.2 8.2.10.5
> 1) get_log_capabilities (Opcode 0402h)
> 2) clear_log (Opcode 0403h)
> 3) populate_log (Opcode 0404h)
> 
> This v2 patch addresses the feedback from the v1 patch and include some new changes.

I'll apply these to my staging tree, but it is a little odd
to have the last two commands without any logs that they actually apply to.

Maybe we should make up a component state dump?
I think that currently the populate only really applies to that
one (or the vendor defined one).

We can also look at wiring up the ECS logs and some suitable error
injection as clear log would apply to those.  I like the idea
of having media test longer term as well as the use cases for that in
kernel are interesting to explore.

Jonathan
> 
> Changes in from v1 to v2:
> - Added descriptive text for each patches
> - Added reference from CXL spec 3.2
> - Updated naming for better comprehension
> - Modified find_log_index() to return supported log
> - Handled array of log capabilities as static const pointers
> - Replaced bit fields for param_flags with defines for individual bits
> - Disabled support of clear & populate log command for command effect log
> 
> The patches are generated against the Johnathan's tree
> https://gitlab.com/jic23/qemu.git and branch cxl-2024-11-27.
> 
> Arpit Kumar (3):
>   hw/cxl/cxl-mailbox-utils.c: Added support for Get Log Capabilities
>     (Opcode 0402h)
>   hw/cxl/cxl-mailbox-utils.c: Added support for Clear Log (Opcode 0403h)
>   hw/cxl/cxl-mailbox-utils.c: Added support for Populate Log (Opcode
>     0404h)
> 
>  hw/cxl/cxl-mailbox-utils.c   | 100 +++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_device.h  |  20 +++++++
>  include/hw/cxl/cxl_mailbox.h |   5 ++
>  3 files changed, 125 insertions(+)
> 


