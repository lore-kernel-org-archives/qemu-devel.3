Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EEB2CAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 03:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uz4sd-0001Sz-Nx; Wed, 17 Sep 2025 23:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1uz4sY-0001Rb-1A
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 23:00:14 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>) id 1uz4sS-0003W4-EK
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 23:00:13 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwAnLDyodcto8jbgCA--.7S2;
 Thu, 18 Sep 2025 10:59:52 +0800 (CST)
Received: from localhost (unknown [123.150.8.50])
 by mail (Coremail) with SMTP id AQAAfwAXe+ijdctoeTQUAA--.17109S2;
 Thu, 18 Sep 2025 10:59:48 +0800 (CST)
Date: Thu, 18 Sep 2025 10:59:29 +0800
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: fan.ni@samsung.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 rad@semihalf.com, peter.maydell@linaro.org,
 leif.lindholm@oss.qualcomm.com, graf@amazon.com,
 claudio.fontana@huawei.com, philmd@linaro.org,
 richard.henderson@linaro.org, chenbaozi@phytium.com.cn,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, ligen@phytium.com.cn
Subject: Re: [RFC QEMU PATCH v4 2/2] pci-host/cxl: Support creation of a new
 CXL Host Bridge
Message-ID: <aMt1kZH+Nlqjb+mh@phytium.com.cn>
References: <20250807105910.240070-1-wangyuquan1236@phytium.com.cn>
 <20250807105910.240070-3-wangyuquan1236@phytium.com.cn>
 <20250917173742.000078cc@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917173742.000078cc@huawei.com>
X-CM-TRANSID: AQAAfwAXe+ijdctoeTQUAA--.17109S2
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAQAWjJu34I-gAwsy
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Cry7Kw4DKry8tFy3GF45KFg_yoW8Gry3pF
 yIgF15CFWkJrW7G3y8ZwsxZ3WrCrZ5JF45Jry5KF98Z3Z8A3sIgrsrKa1a9a4DXr18Xw1v
 ya17Z3s5uan8ZrDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Wed, Sep 17, 2025 at 05:37:42PM +0100, Jonathan Cameron wrote:
> On Thu, 7 Aug 2025 18:59:10 +0800
> wangyuquan <wangyuquan1236@phytium.com.cn> wrote:
> 
> > From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> > 
> > Define a new CXL host bridge type (TYPE_CXL_HOST). This is an
> > independent CXL host bridge which combined GPEX features (ECAM, MMIO
> > windows and irq) and CXL Host Bridge Component Registers (CHBCR).
> > 
> > The root bus path of CXL_HOST is "0001:00", that would not affect the
> > original PCIe host topology on some platforms. In the previous, the
> > pxb-cxl-host with any CXL root ports and CXL endpoint devices would
> > share the resources (like BDF, MMIO space) of the original pcie
> > domain, but it would cause some platforms like sbsa-ref are unable to
> > support the original number of PCIe devices. The new type provides a
> > solution to resolve the problem.
> > 
> > Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> 
> Likewise, this looks fine to me.  If the SBSA maintainers
> are happy with the approach and PCI folk think the more generic parts
> look fine then would be good to move this forwards.
> 
> Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>

Thanks for reviewing! I am very much looking forward to the maintainer of
PCI continuing to review this patch and providing relevant comments.

Yuquan


