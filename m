Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1C4C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 15:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufK9s-0007rP-Fv; Fri, 25 Jul 2025 11:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ufK9n-0007bx-8K
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:16:25 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ufK9l-0003pg-H5
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:16:22 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bpWct5J7Fz6L5G3;
 Fri, 25 Jul 2025 23:14:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 93AF01400C8;
 Fri, 25 Jul 2025 23:16:18 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 25 Jul
 2025 17:16:18 +0200
Date: Fri, 25 Jul 2025 16:16:16 +0100
To: wangyuquan <wangyuquan1236@phytium.com.cn>
CC: <fan.ni@samsung.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH v3 1/2] hw/pxb-cxl: Rename the pxb cxl host bridge
Message-ID: <20250725161616.00007f09@huawei.com>
In-Reply-To: <20250617040649.81303-2-wangyuquan1236@phytium.com.cn>
References: <20250617040649.81303-1-wangyuquan1236@phytium.com.cn>
 <20250617040649.81303-2-wangyuquan1236@phytium.com.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
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

On Tue, 17 Jun 2025 12:06:48 +0800
wangyuquan <wangyuquan1236@phytium.com.cn> wrote:

> This renames some descriptions and definitions of pxb cxl host
> bridge, since the original names can be confusing.
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Fair enough.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  hw/pci-bridge/pci_expander_bridge.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> index 3a29dfefc2..bd637786d0 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -201,7 +201,7 @@ static void pxb_cxl_realize(DeviceState *dev, Error **errp)
>  }
>  
>  /*
> - * Host bridge realization has no means of knowning state associated
> + * PXB Host bridge realization has no means of knowning state associated
>   * with a particular machine. As such, it is nececssary to delay
>   * final setup of the host bridge register space until later in the
>   * machine bring up.
> @@ -240,7 +240,7 @@ static void pxb_cxl_host_class_init(ObjectClass *class, const void *data)
>   * This is a device to handle the MMIO for a CXL host bridge. It does nothing
>   * else.
>   */
> -static const TypeInfo cxl_host_info = {
> +static const TypeInfo pxb_cxl_host_info = {
>      .name          = TYPE_PXB_CXL_HOST,
>      .parent        = TYPE_PCI_HOST_BRIDGE,
>      .instance_size = sizeof(CXLHost),
> @@ -522,7 +522,7 @@ static void pxb_cxl_dev_class_init(ObjectClass *klass, const void *data)
>       * vendor, device, class, etc. ids are intentionally left out.
>       */
>  
> -    dc->desc = "CXL Host Bridge";
> +    dc->desc = "PXB CXL Host Bridge";
>      device_class_set_props(dc, pxb_cxl_dev_properties);
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>  
> @@ -549,7 +549,7 @@ static void pxb_register_types(void)
>      type_register_static(&pxb_pcie_bus_info);
>      type_register_static(&pxb_cxl_bus_info);
>      type_register_static(&pxb_host_info);
> -    type_register_static(&cxl_host_info);
> +    type_register_static(&pxb_cxl_host_info);
>      type_register_static(&pxb_dev_info);
>      type_register_static(&pxb_pcie_dev_info);
>      type_register_static(&pxb_cxl_dev_info);


