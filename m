Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B80CAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 03:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uz53D-0004HW-Md; Wed, 17 Sep 2025 23:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1uz538-0004DL-Jj; Wed, 17 Sep 2025 23:11:10 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1uz534-0005Ls-QQ; Wed, 17 Sep 2025 23:11:10 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwB3DWFEeMtoyGxXBw--.54455S2;
 Thu, 18 Sep 2025 11:11:00 +0800 (CST)
Received: from localhost (unknown [123.150.8.50])
 by mail (Coremail) with SMTP id AQAAfwAXeuc_eMtoJjUUAA--.17208S2;
 Thu, 18 Sep 2025 11:10:56 +0800 (CST)
Date: Thu, 18 Sep 2025 11:10:38 +0800
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: rad@semihalf.com, peter.maydell@linaro.org,
 leif.lindholm@oss.qualcomm.com, chenbaozi@phytium.com.cn,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 qemu-arm@nongnu.org, ligen@phytium.com.cn
Subject: Re: [RFC QEMU PATCH v7] hw/arm/sbsa-ref: Support CXL Host Bridge &
 CFMW
Message-ID: <aMt4LqSympNcVqnb@phytium.com.cn>
References: <20250807111037.241118-1-wangyuquan1236@phytium.com.cn>
 <20250917173914.0000331e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917173914.0000331e@huawei.com>
X-CM-TRANSID: AQAAfwAXeuc_eMtoJjUUAA--.17208S2
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAQAWjJu34I-gA1s3
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoW7Xr1ktF1fJF4rtw1kGw1ftFb_yoWkWrb_ZF
 s2yr9avw4vkF9FgFsxt3ZIvrWftryDur47XwnrAas8JF9xtas5uF4DKFna9345Gr42qr42
 kr1YvrW3tanrZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
 Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
 UUUU=
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

On Wed, Sep 17, 2025 at 05:39:14PM +0100, Jonathan Cameron wrote:
> On Thu, 7 Aug 2025 19:10:37 +0800
> wangyuquan <wangyuquan1236@phytium.com.cn> wrote:
> 
> > From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> > 
> > This creates a specific CXL host bridge (0001:00) with four cxl
> > root ports on sbsa-ref. And the memory layout provides separate
> > space windows for the cxl host bridge in the sbsa-ref memmap:
> > 
> > - 64K  CXL Host Bridge Component Registers (CHBCR)
> > - 64K  CXL_PIO
> > - 128M CXL_MMIO
> > - 256M CXL_ECAM
> > - 4G   CXL_MMIO_HIGH
> > 
> > To provide CFMWs on sbsa-ref, this extends 1TB space from the
> > hole above RAM Memory [SBSA_MEM] for CXL Fixed Memory Window:
> > 
> > - 1T   CXL_FIXED_WINDOW
> > 
> > Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> This looks pretty standard to me so FWIW as someone who hasn't used
> the SBSA model.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
>

Hi, Leif and SBSA folks

We hope to hear from everyone regarding other suggestions for using the
CXL on the sbsa-ref, as well as any areas where this patch might have
been overlooked.

Yuquan


