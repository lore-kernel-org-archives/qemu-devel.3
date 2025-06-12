Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84DEC61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 16:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPksb-0004AD-Rz; Thu, 12 Jun 2025 12:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uPksV-00048z-NH; Thu, 12 Jun 2025 12:34:11 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uPksR-0008EU-LI; Thu, 12 Jun 2025 12:34:11 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bJ7Pn1zlTz6M52S;
 Fri, 13 Jun 2025 00:33:33 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 4B09414038F;
 Fri, 13 Jun 2025 00:33:59 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 12 Jun
 2025 18:33:58 +0200
Date: Thu, 12 Jun 2025 17:33:57 +0100
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, <mst@redhat.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Itaru Kitayama
 <itaru.kitayama@linux.dev>, <linuxarm@huawei.com>,
 <linux-cxl@vger.kernel.org>, <qemu-arm@nongnu.org>, Yuquan Wang
 <wangyuquan1236@phytium.com.cn>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Alireza Sanaee <alireza.sanaee@huawei.com>, Alex
 =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v15 0/4] arm/virt: CXL support via pxb_cxl
Message-ID: <20250612173357.00002f31@huawei.com>
In-Reply-To: <CAFEAcA9CuQWL2b63+XCe+vZCGR7hRSx8SkTR0LDa+Ra1Z5ur7w@mail.gmail.com>
References: <20250612134338.1871023-1-Jonathan.Cameron@huawei.com>
 <CAFEAcA9CuQWL2b63+XCe+vZCGR7hRSx8SkTR0LDa+Ra1Z5ur7w@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 12 Jun 2025 17:04:32 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Thu, 12 Jun 2025 at 14:43, Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > v15:
> >   - Split the address map calculations and mmio setup into separate
> >     functions in patch 2, allowing v14 patch 3 to be dropped as not
> >     x86 and arm make the same calls.  Note I felt this was a sufficient
> >     change to trigger dropping tags. (Zhijian Li)
> >   - A few other minor tweaks.
> >   - TLB issue mentioned in v14 now fixed upstream so dropped reference
> >     in this cover letter.
> >
> > Thanks to Itaru Kitayama and Zhijian Li for testing + reviews.  
> 
> Hi Jonathan -- I forget where we are on this. Do you think this
> series is OK to go upstream at this point, or is there still
> stuff you're iterating on here ?  (Put another way, should I
> review it and consider queueing it?)

Hi Peter,

Please do review + consider queuing it.  The recent changes have
just been tidying up based on reviews and before that it was just
the switch over to sysbus devices for the CXL Fixed Memory Windows.
That was mainly because I need that for other stuff and I think
you suggested it a few years back so I thought it might make you
happier with this :)

Thanks,

Jonathan

> 
> thanks
> -- PMM


