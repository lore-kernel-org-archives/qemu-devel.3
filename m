Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA25CA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 11:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqrkb-0006Cu-KL; Tue, 26 Aug 2025 07:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uqrkU-0006Aa-BM; Tue, 26 Aug 2025 07:21:58 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uqrkL-0007kW-9O; Tue, 26 Aug 2025 07:21:57 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cB4tT4Plgz6LD7K;
 Tue, 26 Aug 2025 19:19:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 7DC2414038F;
 Tue, 26 Aug 2025 19:21:29 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 26 Aug
 2025 13:21:28 +0200
Date: Tue, 26 Aug 2025 12:21:27 +0100
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
CC: Alistair Francis <alistair.francis@wdc.com>, Keith Busch
 <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, Jesper Devantier
 <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng
 <fam@euphon.net>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, <qemu-devel@nongnu.org>,
 <qemu-block@nongnu.org>, Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH 4/4] hw/nvme: connect SPDM over NVMe Security Send/Recv
Message-ID: <20250826122127.000061fc@huawei.com>
In-Reply-To: <20250826054630.222052-5-wilfred.opensource@gmail.com>
References: <20250826054630.222052-1-wilfred.opensource@gmail.com>
 <20250826054630.222052-5-wilfred.opensource@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 26 Aug 2025 15:46:30 +1000
Wilfred Mallawa <wilfred.opensource@gmail.com> wrote:

> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> This patch extends the existing support we have for NVMe with only DoE
> to also add support to SPDM over the NVMe Security Send/Recv commands.
> 
> With the new definition of the `spdm-trans` argument, users can specify
> `spdm_trans=nvme` or `spdm_trans=doe`. This allows us to select the SPDM
> transport respectively. SPDM over the NVMe Security Send/Recv commands
> are defined in the DMTF DSP0286.
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>

A few comments inline.

Jonathan

> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 442144642d..61feb9b35a 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -8849,6 +8849,23 @@ static DOEProtocol doe_spdm_prot[] = {
>      { }
>  };
>  
> +static inline uint32_t nvme_get_spdm_trans_type(PCIDevice *pci_dev)
> +{
> +    if (!pci_dev) {
> +        return false;

It's a uin32_t, false doesn't make sense as a return value.

> +    }
> +
> +    if (!strcmp(pci_dev->spdm_trans, "nvme")) {
> +        return SPDM_SOCKET_TRANSPORT_TYPE_NVME;
> +    }
> +
> +    if (!strcmp(pci_dev->spdm_trans, "doe")) {
> +        return SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE;
> +    }
> +
> +    return 0;
> +}
> +

> @@ -9297,6 +9332,7 @@ static const Property nvme_props[] = {
>                       false),
>      DEFINE_PROP_UINT16("mqes", NvmeCtrl, params.mqes, 0x7ff),
>      DEFINE_PROP_UINT16("spdm_port", PCIDevice, spdm_port, 0),
> +    DEFINE_PROP_STRING("spdm_trans", PCIDevice, spdm_trans),

There is enum support, (look for qdev_propinfo_get_enum() usage)
but seems not that much used and there are examples of strings
used for things that are enums underneath.

>      DEFINE_PROP_BOOL("ctratt.mem", NvmeCtrl, params.ctratt.mem, false),


