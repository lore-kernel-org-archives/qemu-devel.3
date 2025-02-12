Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC608C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 17:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiGKi-0003QC-Le; Wed, 12 Feb 2025 12:15:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tiGKX-0003PV-Ct
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:15:25 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tiGKV-000176-2L
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:15:21 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YtPxd2Dkmz6L55p;
 Thu, 13 Feb 2025 01:12:05 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 05D6B140441;
 Thu, 13 Feb 2025 01:15:06 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Feb
 2025 18:15:05 +0100
Date: Wed, 12 Feb 2025 17:15:04 +0000
To: Arpit Kumar <arpit1.kumar@samsung.com>
CC: <qemu-devel@nongnu.org>, <gost.dev@samsung.com>,
 <linux-cxl@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
 <vishak.g@samsung.com>, <krish.reddy@samsung.com>,
 <a.manzanares@samsung.com>, <alok.rathore@samsung.com>
Subject: Re: [PATCH 1/3] hw/cxl/cxl-mailbox-utils.c: Added support for Get
 Log Capabilities (Opcode 0402h)
Message-ID: <20250212171504.000051b7@huawei.com>
In-Reply-To: <20250212113012.datt6a7sddkbli25@test-PowerEdge-R740xd>
References: <20250203055950.2126627-1-arpit1.kumar@samsung.com>
 <CGME20250203060051epcas5p350b7b24d3b5fcff25bc30e1acccd8121@epcas5p3.samsung.com>
 <20250203055950.2126627-2-arpit1.kumar@samsung.com>
 <20250204102820.000047fb@huawei.com>
 <20250212113012.datt6a7sddkbli25@test-PowerEdge-R740xd>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
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

> >>
> >> +static const struct CXLLogCapabilities cxl_get_log_cap[MAX_LOG_TYPE] = {
> >> +    [CEL] = {.param_flags.pflags = CXL_LOG_CAP_CLEAR | CXL_LOG_CAP_POPULATE,
> >> +             .uuid = cel_uuid},
> >> +};
> >> +
> >> +static void cxl_init_get_log(CXLCCI *cci)
> >> +{
> >> +    for (int set = CEL; set < MAX_LOG_TYPE; set++) {
> >> +        cci->supported_log_cap[set] = cxl_get_log_cap[set];  
> >
> >As below. Can we just use a static const pointer in cci?  
> 
> static const pointer in cci gives compilation error as it used below
> to assign value:
>      cci->supported_log_cap[set] = cxl_get_log_cap[set];

True. That is what I am suggesting changing.

cci->supported_log_cap = cxl_get_log_cap;

This is currently iterating over a list and copying everything. Why
bother, just set a pointer to the source list.  If there
are choices for that, pick between them but keep all those lists const.



> 

> >> +typedef struct CXLLogCapabilities {
> >> +    CXLParamFlags param_flags;
> >> +    QemuUUID uuid;
> >> +} CXLLogCapabilities;
> >> +
> >>  typedef struct CXLCCI {
> >>      struct cxl_cmd cxl_cmd_set[256][256];
> >>      struct cel_log {
> >> @@ -202,6 +230,9 @@ typedef struct CXLCCI {
> >>      } cel_log[1 << 16];
> >>      size_t cel_size;
> >>
> >> +    /* get log capabilities */
> >> +    CXLLogCapabilities supported_log_cap[MAX_LOG_TYPE];  
> >Perhaps a const pointer is appropriate?  
> 
> const pointer here gives compilation error as it is used below 
> to assign value:
>      cci->supported_log_cap[set] = cxl_get_log_cap[set];
As above.  This set is the thing I'm suggesting changing.

One general review process thing is it is much more productive
to just crop anything you agree with and just have the discussion
focused on questions etc that are outstanding.

Jonathan

