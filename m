Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D67C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOIjT-0006vC-KT; Mon, 01 Jul 2024 11:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sOIjR-0006uv-V7; Mon, 01 Jul 2024 11:14:17 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sOIjP-0006K2-3r; Mon, 01 Jul 2024 11:14:17 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WCV151Mp6z6JB0t;
 Mon,  1 Jul 2024 23:13:29 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 50574140D1A;
 Mon,  1 Jul 2024 23:14:02 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 1 Jul
 2024 16:14:01 +0100
Date: Mon, 1 Jul 2024 16:14:01 +0100
To: Hyeongtak Ji <hyeongtak.ji@gmail.com>
CC: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: Re: [PATCH v2] docs/cxl: fix some typos
Message-ID: <20240701161401.00000861@Huawei.com>
In-Reply-To: <20240626043458.1446926-1-hyeongtak.ji@gmail.com>
References: <20240626043458.1446926-1-hyeongtak.ji@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.174.77]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
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

On Wed, 26 Jun 2024 13:34:58 +0900
Hyeongtak Ji <hyeongtak.ji@gmail.com> wrote:

> This patch corrects minor typographical errors to ensure the ASCII art
> aligns with the explanations provided.  Specifically, it fixes an
> incorrect root port reference and removes redundant words.
> 
> Signed-off-by: Hyeongtak Ji <hyeongtak.ji@gmail.com>
LGTM.  If this can go via trivial. If not I'll queue it up in a
few days.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  docs/system/devices/cxl.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
> index cf0a5143cfe8..a551d95455bc 100644
> --- a/docs/system/devices/cxl.rst
> +++ b/docs/system/devices/cxl.rst
> @@ -218,17 +218,17 @@ Notes:
>      A complex configuration here, might be to use the following HDM
>      decoders in HB0. HDM0 routes CFMW0 requests to RP0 and hence
>      part of CXL Type3 0. HDM1 routes CFMW0 requests from a
> -    different region of the CFMW0 PA range to RP2 and hence part
> +    different region of the CFMW0 PA range to RP1 and hence part
>      of CXL Type 3 1.  HDM2 routes yet another PA range from within
>      CFMW0 to be interleaved across RP0 and RP1, providing 2 way
>      interleave of part of the memory provided by CXL Type3 0 and
>      CXL Type 3 1. HDM3 routes those interleaved accesses from
>      CFMW1 that target HB0 to RP 0 and another part of the memory of
>      CXL Type 3 0 (as part of a 2 way interleave at the system level
> -    across for example CXL Type3 0 and CXL Type3 2.
> +    across for example CXL Type3 0 and CXL Type3 2).
>      HDM4 is used to enable system wide 4 way interleave across all
>      the present CXL type3 devices, by interleaving those (interleaved)
> -    requests that HB0 receives from from CFMW1 across RP 0 and
> +    requests that HB0 receives from CFMW1 across RP 0 and
>      RP 1 and hence to yet more regions of the memory of the
>      attached Type3 devices.  Note this is a representative subset
>      of the full range of possible HDM decoder configurations in this


