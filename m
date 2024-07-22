Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7339C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 13:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVshp-0001Au-9L; Mon, 22 Jul 2024 09:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sVshh-0000cE-0j
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 09:03:54 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sVshb-0004Yv-MV
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 09:03:47 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WSL4v010cz6D99x;
 Mon, 22 Jul 2024 21:01:19 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 9E50E14065B;
 Mon, 22 Jul 2024 21:03:40 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 22 Jul
 2024 14:03:40 +0100
Date: Mon, 22 Jul 2024 14:03:39 +0100
To: luzhixing12345 <luzhixing12345@gmail.com>
CC: <qemu-devel@nongnu.org>
Subject: Re: [PATCH] docs: add more information about CXL2.0 device type
Message-ID: <20240722140339.00004067@Huawei.com>
In-Reply-To: <20240719045733.26021-1-luzhixing12345@gmail.com>
References: <20240719045733.26021-1-luzhixing12345@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.174.77]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
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

On Fri, 19 Jul 2024 12:57:33 +0800
luzhixing12345 <luzhixing12345@gmail.com> wrote:

> Add more information with CXL type1 and type2 devices.
> 
> Original doc says "May also have device private memory accessible 
> via means such as PCI memory reads and writes to BARs.", but actually
> CXL type1 devices doesn't have device memory.

Hi Luzhixing,

That's a missunderstanding. It contains no memory accesible via CXL.mem (so
host managed device memory) butit may contain memory accessible via CXL.IO etc.
Such memory is out of the scope of the CXL specification but the
intent of the text written here is to make it clear that
such memory can exist.

> 
> Signed-off-by: luzhixing12345 <luzhixing12345@gmail.com>
The name part of the SoB should be your name which I'm guessing
doesn't include numbers.

There seem to be additional changes in the text below.
I'm not sure what the purpose was?

> ---
>  docs/system/devices/cxl.rst | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
> index 882b036f5e..ee50a3c18d 100644
> --- a/docs/system/devices/cxl.rst
> +++ b/docs/system/devices/cxl.rst
> @@ -46,20 +46,14 @@ CXL 2.0 Device Types
>  --------------------
>  CXL 2.0 End Points are often categorized into three types.
>  
> -**Type 1:** These support coherent caching of host memory.  Example might
> -be a crypto accelerators.  May also have device private memory accessible
> -via means such as PCI memory reads and writes to BARs.
> +**Type 1: Accelerators without device memory**. These support coherent caching of host memory. Example might be a crypto accelerators or smart NICs that use coherency semantics along with PCIe-style DMA transfers. Type1 devices implement a fully coherent cache but no host-managed device memory.

Needs to be wrapped.

>  
> -**Type 2:** These support coherent caching of host memory and host
> -managed device memory (HDM) for which the coherency protocol is managed
> -by the host. This is a complex topic, so for more information on CXL
> -coherency see the CXL 2.0 specification.
> +**Type 2: Accelerators with device memory**. These support coherent caching of host memory and host managed device memory (HDM) for which the coherency protocol is managed by the host. Type 2 devices are accelerators such as GP-GPUs and FPGAs with device memory that can be mapped in part to the cacheable system memory. These devices also cache system memory for processing.
>  
> -**Type 3 Memory devices:**  These devices act as a means of attaching
> -additional memory (HDM) to a CXL host including both volatile and
> -persistent memory. The CXL topology may support interleaving across a
> -number of Type 3 memory devices using HDM Decoders in the host, host
> -bridge, switch upstream port and endpoints.
> +**Type 3: Memory devices**. These devices act as a means of attaching
> +additional memory (HDM) to a CXL host with different memory types,
Why make this change? What memory do you have that is neither persistent nor volatile?

> + including supporting multiple memory tiers attached to the device with both volatile and persistent memory. The CXL topology may support interleaving across a number of Type 3 memory devices using HDM Decoders in the host, host bridge, switch upstream port and endpoints.
> +
> +See more information about CXL.io CXL.cache CXL.mem in the `CXL 2.0 specification <https://computeexpresslink.org/past-cxl-specifications-landing-page/>`_.
>  
>  Scope of CXL emulation in QEMU
>  ------------------------------


