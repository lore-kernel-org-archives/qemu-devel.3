Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E0CC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 13:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riZpL-0002t5-Jj; Fri, 08 Mar 2024 07:59:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1riZpJ-0002sw-Rj
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 07:59:53 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1riZpH-0003MM-Rr
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 07:59:53 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TrmTp4HS7z6JB4K;
 Fri,  8 Mar 2024 20:59:42 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 6C900141105;
 Fri,  8 Mar 2024 20:59:48 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 8 Mar
 2024 12:59:34 +0000
Date: Fri, 8 Mar 2024 12:59:33 +0000
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <Terry.Bowman@amd.com>, <linux-cxl@vger.kernel.org>,
 <qemu-devel@nongnu.org>
Subject: Re: Enabling internal errors for VH CXL devices: [was: Re:
 Questions about CXL RAS injection test in qemu]
Message-ID: <20240308125933.000053f8@Huawei.com>
In-Reply-To: <20240308020134.3146734-1-wangyuquan1236@phytium.com.cn>
References: <20240308020134.3146734-1-wangyuquan1236@phytium.com.cn>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
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

On Fri, 8 Mar 2024 10:01:34 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> On 2024-03-07 20:10,  jonathan.cameron wrote:
> 
> > Hack is fine the relevant device with lspci -tv and then use
> > setpci -s 0d:00.0 0x208.l=0
> > to clear all the mask bits for uncorrectable errors.  
> 
> Thanks! The suggestions from you and Terry did work!
> 
> BTW, is my understanding below about CXL RAS correct?
> 
> >> 2) The error injected by "pcie_aer_inject_error" is "protocol & link errors" of cxl.io?
> >>    The error injected by "cxl-inject-uncorrectable-errors" or "cxl-inject-correctable-error" is "protocol & link errors" of cxl.cachemem  
> 
> Many thanks
> Yuuqan
> 
Yes.  Note the two CXL errors are actually communicated via AER uncorrectable / correctable internal
error combined with data that is available on the EP in the CXL specific registers.

Jonathan

