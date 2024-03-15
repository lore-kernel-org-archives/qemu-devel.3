Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D19AC54E69
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 10:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl4ls-0003P6-Ak; Fri, 15 Mar 2024 06:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rl4lo-0003KG-JU
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 06:26:37 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rl4lh-0006T1-0y
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 06:26:35 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tx0kz3F8vz6D8gl;
 Fri, 15 Mar 2024 18:25:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id E67BC141D79;
 Fri, 15 Mar 2024 18:26:13 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 15 Mar
 2024 10:24:15 +0000
Date: Fri, 15 Mar 2024 10:24:15 +0000
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <dave.jiang@intel.com>, <fan.ni@samsung.com>, <ira.weiny@intel.com>,
 <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v9 0/7]  QEMU CXL Provide mock CXL events and irq support
Message-ID: <20240315102415.00004476@Huawei.com>
In-Reply-To: <20240315015228.307512-1-wangyuquan1236@phytium.com.cn>
References: <20230530133603.16934-1-Jonathan.Cameron@huawei.com>
 <20240315015228.307512-1-wangyuquan1236@phytium.com.cn>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Fri, 15 Mar 2024 09:52:28 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> Hello, Jonathan
> 
> When during the test of qmps of CXL events like "cxl-inject-general-media-event", 
> I am confuesd about the argument "flags". According to "qapi/cxl.json" in qemu, 
> this argument represents "Event Record Flags" in Common Event Record Format.
> However, it seems like the specific 'Event Record Severity' in this field can be
> different from the value of 'Event Status' in "Event Status Register". 
> 
> For instance (take an injection example in the coverlatter):
> 
> { "execute": "cxl-inject-general-media-event",
>     "arguments": {
>         "path": "/machine/peripheral/cxl-mem0",
>         "log": "informational",
>         "flags": 1,
>         "dpa": 1000,
>         "descriptor": 3,
>         "type": 3,
>         "transaction-type": 192,
>         "channel": 3,
>         "device": 5,
>         "component-id": "iras mem"
>     }}
> 
> In my understanding, the 'Event Status' is informational and the 
> 'Event Record Severity' is Warning event, which means these two arguments are
> independent of each other. Is my understanding correct?

The event status registers dictates the notification path (which log).
So I think that's "informational" here.

Whereas flags is about the specific error. One case where they might be
different is where the Related Event Record Handle is set.
An error might be reported as
1) Several things that were non fatal (each with their own record)
2) In combination they result in a fatal situation (also has it's own record).

The QEMU injection shouldn't restrict these combinations more than the spec
does (which is not at all!).

This same disconnect in error severity is seen in UEFI CPER records for example
where there is a containing record with one severity field, but more specific
parts of record can have lower (or in theory higher) severity.

Jonathan


> 
> Many thanks
> Yuquan
> 


