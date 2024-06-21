Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36C6C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 16:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKgr6-0001on-JI; Fri, 21 Jun 2024 12:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sKgqx-0001mj-8T; Fri, 21 Jun 2024 12:11:08 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sKgqu-0001Aj-2f; Fri, 21 Jun 2024 12:11:06 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W5Mll2NBRz6GCty;
 Sat, 22 Jun 2024 00:10:43 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 796D314038F;
 Sat, 22 Jun 2024 00:10:48 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 21 Jun
 2024 17:10:48 +0100
Date: Fri, 21 Jun 2024 17:10:47 +0100
To: Hyeongtak Ji <hyeongtak.ji@gmail.com>
CC: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: Re: [PATCH] docs/cxl: fix some typos
Message-ID: <20240621171047.000075fc@Huawei.com>
In-Reply-To: <20240619045459.305997-1-hyeongtak.ji@gmail.com>
References: <20240619045459.305997-1-hyeongtak.ji@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.174.77]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 19 Jun 2024 13:54:59 +0900
Hyeongtak Ji <hyeongtak.ji@gmail.com> wrote:

Hi, some description would be good of how you caught these
(I'm guessing a close read).

Whilst checking this I did notice there are some errors in
the example bus numbering but that's a separate issue.

Jonathan


> Signed-off-by: Hyeongtak Ji <hyeongtak.ji@gmail.com>
> ---
>  docs/system/devices/cxl.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
> index 10a0e9bc9ff4..e2497e6a098b 100644
> --- a/docs/system/devices/cxl.rst
> +++ b/docs/system/devices/cxl.rst
> @@ -218,17 +218,17 @@ Notes:
>      A complex configuration here, might be to use the following HDM
>      decoders in HB0. HDM0 routes CFMW0 requests to RP0 and hence
>      part of CXL Type3 0. HDM1 routes CFMW0 requests from a
> -    different region of the CFMW0 PA range to RP2 and hence part
> +    different region of the CFMW0 PA range to RP1 and hence part

Good catch.

>      of CXL Type 3 1.  HDM2 routes yet another PA range from within
>      CFMW0 to be interleaved across RP0 and RP1, providing 2 way
>      interleave of part of the memory provided by CXL Type3 0 and
>      CXL Type 3 1. HDM3 routes those interleaved accesses from
>      CFMW1 that target HB0 to RP 0 and another part of the memory of
>      CXL Type 3 0 (as part of a 2 way interleave at the system level
> -    across for example CXL Type3 0 and CXL Type3 2.
> +    across for example CXL Type3 0 and CXL Type3 1).
This one is wrong.  CFMW1 interleaves across both host bridges so we need
a device below HB0 and one below HB1, so CXL type3 2 is a possible choice
(could be CXL type3 3 as well, but that doesn't matter.)

>      HDM4 is used to enable system wide 4 way interleave across all
>      the present CXL type3 devices, by interleaving those (interleaved)
> -    requests that HB0 receives from from CFMW1 across RP 0 and
> +    requests that HB0 receives from CFMW1 across RP 0 and
Good.

>      RP 1 and hence to yet more regions of the memory of the
>      attached Type3 devices.  Note this is a representative subset
>      of the full range of possible HDM decoder configurations in this


