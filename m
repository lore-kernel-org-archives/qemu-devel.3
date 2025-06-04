Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF96C5B552
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 09:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMk4g-0004XR-Ii; Wed, 04 Jun 2025 05:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1uMk4T-0004Sj-CJ
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 05:06:08 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1uMk4P-0003zT-D8
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 05:06:04 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bC1rh3Pn9z6M4cL;
 Wed,  4 Jun 2025 17:05:40 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
 by mail.maildlp.com (Postfix) with ESMTPS id 4E13C1400D9;
 Wed,  4 Jun 2025 17:05:53 +0800 (CST)
Received: from localhost (10.203.177.99) by frapeml500003.china.huawei.com
 (7.182.85.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 4 Jun
 2025 11:05:52 +0200
Date: Wed, 4 Jun 2025 10:05:47 +0100
To: Bibo Mao <maobibo@loongson.cn>
CC: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>
Subject: Re: [PATCH 0/2] hw/loongarch/virt: Small enhancement about big
 endian host
Message-ID: <20250604100547.00000739.alireza.sanaee@huawei.com>
In-Reply-To: <20250604065502.1114098-1-maobibo@loongson.cn>
References: <20250604065502.1114098-1-maobibo@loongson.cn>
Organization: Huawei
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.99]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500003.china.huawei.com (7.182.85.28)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 4 Jun 2025 14:55:00 +0800
Bibo Mao <maobibo@loongson.cn> wrote:

> On big endian host machine such as S390, bios-table-test fails to run.
> And also linux kernel fails to boot.
> 
> This patches solves these two issues.
> 
> Bibo Mao (2):
>   hw/loongarch/virt: Fix big endian support with MCFG table
>   hw/intc/loongarch_pch: Convert to little endian with ID register
> 
>  hw/intc/loongarch_pch_pic.c    | 2 +-
>  hw/loongarch/virt-acpi-build.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> 
> base-commit: 6322b753f798337835e205b6d805356bea582c86

Hi Bao,

Thanks for the fix.

In that case, I will put a DEPEND-ON tag and resend my patchset.

Alireza

