Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420D5C71136
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 17:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ82N-0005iv-B3; Fri, 13 Jun 2025 13:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uQ82F-0005co-1C; Fri, 13 Jun 2025 13:17:47 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uQ82C-0002b0-7e; Fri, 13 Jun 2025 13:17:46 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bJmKf5XBnz6M4sr;
 Sat, 14 Jun 2025 01:17:10 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 439BC140277;
 Sat, 14 Jun 2025 01:17:38 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 13 Jun
 2025 19:17:37 +0200
Date: Fri, 13 Jun 2025 18:17:36 +0100
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, <mst@redhat.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Itaru Kitayama
 <itaru.kitayama@linux.dev>, <linuxarm@huawei.com>,
 <linux-cxl@vger.kernel.org>, <qemu-arm@nongnu.org>, Yuquan Wang
 <wangyuquan1236@phytium.com.cn>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Alireza Sanaee <alireza.sanaee@huawei.com>, Alex
 =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v15 2/4] hw/cxl: Make the CXL fixed memory windows devices.
Message-ID: <20250613181736.000063e5@huawei.com>
In-Reply-To: <CAFEAcA_ZbAnUS4Ufa+jsOgj6aeRS5JHJP=scw6d0qXd3NNtqdA@mail.gmail.com>
References: <20250612134338.1871023-1-Jonathan.Cameron@huawei.com>
 <20250612134338.1871023-3-Jonathan.Cameron@huawei.com>
 <CAFEAcA8eC9TpGyrMARRUWs4q1o7LACD03zLAwPnTRU+m98LrWQ@mail.gmail.com>
 <20250613140954.000013f5@huawei.com>
 <CAFEAcA_ZbAnUS4Ufa+jsOgj6aeRS5JHJP=scw6d0qXd3NNtqdA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
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

On Fri, 13 Jun 2025 17:08:28 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Fri, 13 Jun 2025 at 14:10, Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> > For these specific devices (the fixed memory windows) there isn't
> > any state as they are representing fixed configuration of the system.
> > The state is all in the host bridges and beyond. I'll add
> > a comment as you suggest.
> >
> > Currently CXL emulation is completely broken wrt to migration and
> > there are some known issues for reset as well. Both are on the list
> > of things to fix. Migration is less important as the only current use
> > for this stuff is running software stack test cases and for that
> > migration isn't currently of interest - that will change for some
> > of the virtualization related work that is just getting started.  
> 
> That's OK as long as something somewhere is registering a
> migration-blocker so there's a useful error message if the
> user ever tries it.
:(

Michael asked for us to fix that a while back and I forgot.

Will sort that out shortly.

J
> 
> -- PMM


