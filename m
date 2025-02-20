Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEE1C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9A8-0007d8-7e; Thu, 20 Feb 2025 11:12:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tl99y-0007Xc-Hj
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:12:24 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tl99v-0007D3-NZ
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:12:21 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YzJC04748z6GD9D;
 Fri, 21 Feb 2025 00:10:36 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 97418140B55;
 Fri, 21 Feb 2025 00:12:15 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 20 Feb
 2025 17:12:15 +0100
Date: Thu, 20 Feb 2025 16:12:13 +0000
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <fan.ni@samsung.com>, <qemu-devel@nongnu.org>, <chenbaozi@phytium.com.cn>, 
 <mst@redhat.com>
Subject: Re: [PATCH] docs/cxl: Add serial number for persistent-memdev
Message-ID: <20250220161213.000049a9@huawei.com>
In-Reply-To: <20250217112039.138650-1-wangyuquan1236@phytium.com.cn>
References: <20250217112039.138650-1-wangyuquan1236@phytium.com.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, 17 Feb 2025 19:20:39 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> Add serial number parameter in the cxl persistent examples.
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Looks good.  I've queued it up on my gitlab staging tree, but
Michael if you want to pick this one directly that's fine as well.

I should be pushing out my gitlab tree shortly (bit of networking
fun to deal with).

> ---
>  docs/system/devices/cxl.rst | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
> index 882b036f5e..e307caf3f8 100644
> --- a/docs/system/devices/cxl.rst
> +++ b/docs/system/devices/cxl.rst
> @@ -308,7 +308,7 @@ A very simple setup with just one directly attached CXL Type 3 Persistent Memory
>    -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/lsa.raw,size=256M \
>    -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
>    -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> -  -device cxl-type3,bus=root_port13,persistent-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
> +  -device cxl-type3,bus=root_port13,persistent-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0,sn=0x1 \
>    -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
>  
>  A very simple setup with just one directly attached CXL Type 3 Volatile Memory device::
> @@ -349,13 +349,13 @@ the CXL Type3 device directly attached (no switches).::
>    -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
>    -device pxb-cxl,bus_nr=222,bus=pcie.0,id=cxl.2 \
>    -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> -  -device cxl-type3,bus=root_port13,persistent-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
> +  -device cxl-type3,bus=root_port13,persistent-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0,sn=0x1 \
>    -device cxl-rp,port=1,bus=cxl.1,id=root_port14,chassis=0,slot=3 \
> -  -device cxl-type3,bus=root_port14,persistent-memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem1 \
> +  -device cxl-type3,bus=root_port14,persistent-memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem1,sn=0x2 \
>    -device cxl-rp,port=0,bus=cxl.2,id=root_port15,chassis=0,slot=5 \
> -  -device cxl-type3,bus=root_port15,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem2 \
> +  -device cxl-type3,bus=root_port15,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem2,sn=0x3 \
>    -device cxl-rp,port=1,bus=cxl.2,id=root_port16,chassis=0,slot=6 \
> -  -device cxl-type3,bus=root_port16,persistent-memdev=cxl-mem4,lsa=cxl-lsa4,id=cxl-pmem3 \
> +  -device cxl-type3,bus=root_port16,persistent-memdev=cxl-mem4,lsa=cxl-lsa4,id=cxl-pmem3,sn=0x4 \
>    -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.targets.1=cxl.2,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=8k
>  
>  An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
> @@ -375,13 +375,13 @@ An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
>    -device cxl-rp,port=1,bus=cxl.1,id=root_port1,chassis=0,slot=1 \
>    -device cxl-upstream,bus=root_port0,id=us0 \
>    -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
> -  -device cxl-type3,bus=swport0,persistent-memdev=cxl-mem0,lsa=cxl-lsa0,id=cxl-pmem0 \
> +  -device cxl-type3,bus=swport0,persistent-memdev=cxl-mem0,lsa=cxl-lsa0,id=cxl-pmem0,sn=0x1 \
>    -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
> -  -device cxl-type3,bus=swport1,persistent-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem1 \
> +  -device cxl-type3,bus=swport1,persistent-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem1,sn=0x2 \
>    -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
> -  -device cxl-type3,bus=swport2,persistent-memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem2 \
> +  -device cxl-type3,bus=swport2,persistent-memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem2,sn=0x3 \
>    -device cxl-downstream,port=3,bus=us0,id=swport3,chassis=0,slot=7 \
> -  -device cxl-type3,bus=swport3,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3 \
> +  -device cxl-type3,bus=swport3,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3,sn=0x4 \
>    -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
>  
>  Deprecations


