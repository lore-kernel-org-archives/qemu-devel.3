Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECD9C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 13:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE85x-0005sa-87; Mon, 03 Jun 2024 09:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sE85u-0005rw-JC
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 09:51:26 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sE85r-0005oz-Vh
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 09:51:26 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VtFTp6WtNz6K9dL;
 Mon,  3 Jun 2024 21:50:06 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 03BB2140CB9;
 Mon,  3 Jun 2024 21:51:15 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 3 Jun
 2024 14:51:14 +0100
Date: Mon, 3 Jun 2024 14:51:13 +0100
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <gregory.price@memverge.com>, <ira.weiny@intel.com>,
 <dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
 <nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
 <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, <armbru@redhat.com>,
 <mst@redhat.com>
Subject: Re: [PATCH v8 00/14] Enabling DCD emulation support in Qemu
Message-ID: <20240603145113.000054bc@Huawei.com>
In-Reply-To: <20240523174651.1089554-1-nifan.cxl@gmail.com>
References: <20240523174651.1089554-1-nifan.cxl@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
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

On Thu, 23 May 2024 10:44:40 -0700
nifan.cxl@gmail.com wrote:

> From: Fan Ni <nifan.cxl@gmail.com>
> 

Hi Fan,

Apologies for slow response to this update - been a busy few weeks and
I knew I was basically happy with this now so it feel down the todo list.

I've taken one last look this morning and looks good to me.
I'll rebase my tree on top of this so that I can start posting the various
other dependent series in the next few days.

For the remaining patches which don't already have my tag,

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks for your hard work on this fiddly series!

I notice Michael has this in his gitlab tree already which is great.
Hopefully that will go smoothly. No problem if I'm too late with
the above tag.

Looks like there are some build issues with format strings though.
https://gitlab.com/mstredhat/qemu/-/jobs/6998408862
I've called that out in the relevant patch.

Jonathan


> A git tree of this series can be found here (with one extra commit on top
> for printing out accepted/pending extent list for testing): 
> https://github.com/moking/qemu/tree/dcd-v8-qapi
> 
> v7->v8:
> 
> This version carries over the following two patches from Gregory.
> 1. hw/cxl/mailbox: change CCI cmd set structure to be a member, not a reference
> https://gitlab.com/jic23/qemu/-/commit/f44ebc5a455ccdd6535879b0c5824e0d76b04da5
> 2. hw/cxl/mailbox: interface to add CCI commands to an existing CCI
> https://gitlab.com/jic23/qemu/-/commit/00a4dd8b388add03c588298f665ee918626296a5
> 
> Note, the above two patches are not directly related to DCD emulation.
> 
> All the following patches in this series are built on top of mainstream QEMU
> and the above two patches.
> 
> The most significant changes of v8 is in Patch 11 (Patch 9 in v7). Based on
> feedback from Markus and Jonathan, the QMP interfaces for adding and releasing
> DC extents have been redesigned and now they look like below,
> 
> # add a 128MB extent at offset 0 to region 0
> 	{ "execute": "cxl-add-dynamic-capacity",
> 	  "arguments": {
> 		  "path": "/machine/peripheral/cxl-memdev0",
>           "host-id":0,
>           "selection-policy": 'prescriptive',
> 		  "region": 0,
>           "tag": "",
> 		  "extents": [
> 		  {
> 			  "offset": 0,
> 			  "len": 134217728
> 		  }
> 		  ]
> 	  }
> 	}
> 
> Note: tag is optional.
> 
> # Release a 128MB extent at offset 0 from region 0
>  { "execute": "cxl-release-dynamic-capacity",
> 	  "arguments": {
> 		  "path": "/machine/peripheral/cxl-memdev0",
>           "host-id":0,
>           "removal-policy":"prescriptive",
>           "forced-removal": false,
>           "sanitize-on-release": false,
>           "region": 0,
>           "tag": "",
> 		  "extents": [
> 		  {
> 			  "offset": 0,
> 			  "len": 134217728
> 		  }
> 		  ]
> 	  }
> 	}
>     
> Note: removal-policy, sanitize-on-release and tag are optional.
>     
> Other changes include,
> 1. Applied tags to patches. 
> 2. Replaced error_setq with error_append_hint for cxl_create_dc_region error
>    case in Patch 6 (Patch 4 in v7); (Zhijian Li)
> 3. Updated the error message to include region size information in
>     cxl_create_dc_region.
> 4. set range1_size_hi to 0 for DCD in build_dvsec. (Jonathan)
> 5. Several minor format fixes.
> 
> Thanks Markus, Jonathan, Gregory, and Zhijian for reviewing v7 and
> svetly Todorov for testing v7.
> 
> This series pass the same tests as v7 check the cover letter of v7 for
> more details. Additionally, we tested the QAPI interface for
> adding/releasing DC extents with optional input parameters.
>   
> 
> v7: https://lore.kernel.org/linux-cxl/5856b7a4-4082-465f-9f61-b1ec6c35ef0f@fujitsu.com/T/#mec4c85022ce28c80b241aaf2d5431cadaa45f097
> 
> 
> Fan Ni (12):
>   hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
>     payload of identify memory device command
>   hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
>     and mailbox command support
>   include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for
>     type3 memory devices
>   hw/mem/cxl_type3: Add support to create DC regions to type3 memory
>     devices
>   hw/mem/cxl-type3: Refactor ct3_build_cdat_entries_for_mr to take mr
>     size instead of mr as argument
>   hw/mem/cxl_type3: Add host backend and address space handling for DC
>     regions
>   hw/mem/cxl_type3: Add DC extent list representative and get DC extent
>     list mailbox support
>   hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release
>     dynamic capacity response
>   hw/cxl/events: Add qmp interfaces to add/release dynamic capacity
>     extents
>   hw/mem/cxl_type3: Add DPA range validation for accesses to DC regions
>   hw/cxl/cxl-mailbox-utils: Add superset extent release mailbox support
>   hw/mem/cxl_type3: Allow to release extent superset in QMP interface
> 
> Gregory Price (2):
>   hw/cxl/mailbox: change CCI cmd set structure to be a member, not a
>     reference
>   hw/cxl/mailbox: interface to add CCI commands to an existing CCI
> 
>  hw/cxl/cxl-mailbox-utils.c  | 658 +++++++++++++++++++++++++++++++++++-
>  hw/mem/cxl_type3.c          | 634 ++++++++++++++++++++++++++++++++--
>  hw/mem/cxl_type3_stubs.c    |  25 ++
>  include/hw/cxl/cxl_device.h |  85 ++++-
>  include/hw/cxl/cxl_events.h |  18 +
>  qapi/cxl.json               | 143 ++++++++
>  6 files changed, 1511 insertions(+), 52 deletions(-)
> 


