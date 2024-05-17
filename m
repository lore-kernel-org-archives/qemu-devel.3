Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94B0C25B78
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 10:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7uVH-00053P-8l; Fri, 17 May 2024 06:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1s7uV9-000538-77
 for qemu-devel@nongnu.org; Fri, 17 May 2024 06:07:47 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>) id 1s7uV5-00015K-6a
 for qemu-devel@nongnu.org; Fri, 17 May 2024 06:07:46 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwA3jGBkLEdm4XHMAA--.3577S2;
 Fri, 17 May 2024 18:07:32 +0800 (CST)
Received: from localhost (unknown [123.150.8.50])
 by mail (Coremail) with SMTP id AQAAfwDnVNFRLEdm53MAAA--.953S2;
 Fri, 17 May 2024 18:07:24 +0800 (CST)
Date: Fri, 17 May 2024 18:07:07 +0800
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: CXL numa error on arm64 qemu virt machine
Message-ID: <ZkcsS0we4XHPgBIP@phytium.com.cn>
References: <20240508080051.3756934-1-wangyuquan1236@phytium.com.cn>
 <20240508130252.00006367@Huawei.com>
 <ZjyK1tI0TtbAKhmh@phytium.com.cn>
 <20240510181646.000019a1@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510181646.000019a1@Huawei.com>
X-CM-TRANSID: AQAAfwDnVNFRLEdm53MAAA--.953S2
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAIAWZGX+QD1wABsG
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Ar4xXryruFykGw1kKFWxJFb_yoW8Ar1rpa
 yfKrs8Krs7JFs7XFyxAr1UuFnxAws8Jr4fur1ktryDCwn3Ary2vF1Fgw1j9F48KrZ2grn0
 vw4UZ3Z7G3Z8GaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, May 10, 2024 at 06:16:46PM +0100, Jonathan Cameron wrote:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/cxl-staging.git/log/?h=arm-numa-fixes
> 
Thank you :)
> I've run out of time to sort out cover letters and things + just before the merge
> window is never a good time get anyone to pay attention to potentially controversial
> patches.  So for now I've thrown up a branch on kernel.org with Robert's
> series of fixes of related code (that's queued in the ACPI tree for the merge window)
> and Dan Williams (from several years ago) + my additions that 'work' (lightly tested)
> on qemu/arm64 with the generic port patches etc. 
> 
> I'll send out an RFC in a couple of weeks.  In meantime let me know if you
> run into any problems or have suggestions to improve them.
> 
> Jonathan
>
With the latest commit(d077bf9) in the 'arm-numa-fixes', the qemu virt
could create a cxl region with a new numa node (node 2) just like x86.
At this stage(the first time to create cxl region), everything works
fine.

However, if I use below commands to delete the created cxl region:

`daxctl offline-memory dax0.0`
`cxl disable-region region0`
`cxl destroy-region region0`

and then recreate it by `cxl create-region -d decoder0.0 -t ram`, the
kernel could not create the numa node2 again, and the kernel will print:

[  589.458971] Fallback order for Node 0: 0 1
[  589.459136] Fallback order for Node 1: 1 0
[  589.459175] Fallback order for Node 2: 0 1
[  589.459213] Built 2 zonelists, mobility grouping on.  Total pages: 1009890
[  589.459284] Policy zone: Normal

Meanwhile, the qemu reports that: 

"qemu-system-aarch64: virtio: bogus descriptor or out of resources"

Many thanks
Yuquan


