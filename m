Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463D8CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 16:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyvEE-0000Hs-G1; Wed, 17 Sep 2025 12:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uyvBj-0004f1-Ec; Wed, 17 Sep 2025 12:39:30 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uyvBf-0005GH-JD; Wed, 17 Sep 2025 12:39:22 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cRkvp2gpdz6GDNk;
 Thu, 18 Sep 2025 00:37:42 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id B25AD14020A;
 Thu, 18 Sep 2025 00:39:15 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 17 Sep
 2025 18:39:15 +0200
Date: Wed, 17 Sep 2025 17:39:14 +0100
To: wangyuquan <wangyuquan1236@phytium.com.cn>
CC: <rad@semihalf.com>, <peter.maydell@linaro.org>,
 <leif.lindholm@oss.qualcomm.com>, <chenbaozi@phytium.com.cn>,
 <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <qemu-arm@nongnu.org>
Subject: Re: [RFC QEMU PATCH v7] hw/arm/sbsa-ref: Support CXL Host Bridge &
 CFMW
Message-ID: <20250917173914.0000331e@huawei.com>
In-Reply-To: <20250807111037.241118-1-wangyuquan1236@phytium.com.cn>
References: <20250807111037.241118-1-wangyuquan1236@phytium.com.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 7 Aug 2025 19:10:37 +0800
wangyuquan <wangyuquan1236@phytium.com.cn> wrote:

> From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> 
> This creates a specific CXL host bridge (0001:00) with four cxl
> root ports on sbsa-ref. And the memory layout provides separate
> space windows for the cxl host bridge in the sbsa-ref memmap:
> 
> - 64K  CXL Host Bridge Component Registers (CHBCR)
> - 64K  CXL_PIO
> - 128M CXL_MMIO
> - 256M CXL_ECAM
> - 4G   CXL_MMIO_HIGH
> 
> To provide CFMWs on sbsa-ref, this extends 1TB space from the
> hole above RAM Memory [SBSA_MEM] for CXL Fixed Memory Window:
> 
> - 1T   CXL_FIXED_WINDOW
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
This looks pretty standard to me so FWIW as someone who hasn't used
the SBSA model.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>



