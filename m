Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4636FCA1002
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 10:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu7Fk-0006Df-Iv; Thu, 04 Sep 2025 06:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uu7Fd-0006C6-VK; Thu, 04 Sep 2025 06:31:35 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uu7Fb-0002Bz-2K; Thu, 04 Sep 2025 06:31:33 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cHbN35hTsz67D3k;
 Thu,  4 Sep 2025 18:30:27 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 7031C140133;
 Thu,  4 Sep 2025 18:31:23 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 4 Sep
 2025 12:31:22 +0200
Date: Thu, 4 Sep 2025 11:31:21 +0100
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
CC: Alistair Francis <alistair.francis@wdc.com>, Keith Busch
 <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, Jesper Devantier
 <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng
 <fam@euphon.net>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, <qemu-devel@nongnu.org>,
 <qemu-block@nongnu.org>, <dlemoal@kernel.org>, Wilfred Mallawa
 <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v4 5/5] hw/nvme: connect SPDM over NVMe Security Send/Recv
Message-ID: <20250904113121.00004f05@huawei.com>
In-Reply-To: <20250904031058.367667-7-wilfred.opensource@gmail.com>
References: <20250904031058.367667-2-wilfred.opensource@gmail.com>
 <20250904031058.367667-7-wilfred.opensource@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
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

On Thu,  4 Sep 2025 13:10:59 +1000
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

Question on lack of default inline.

Jonathan

> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> ---
>  docs/specs/spdm.rst         | 10 +++++++--
>  hw/nvme/ctrl.c              | 45 ++++++++++++++++++++++++++++---------
>  include/hw/pci/pci_device.h |  2 ++
>  3 files changed, 44 insertions(+), 13 deletions(-)
> 
> diff --git a/docs/specs/spdm.rst b/docs/specs/spdm.rst
> index f7de080ff0..dd6cfbbd68 100644
> --- a/docs/specs/spdm.rst
> +++ b/docs/specs/spdm.rst
> @@ -98,7 +98,7 @@ Then you can add this to your QEMU command line:
>  .. code-block:: shell
>  
>      -drive file=blknvme,if=none,id=mynvme,format=raw \
> -        -device nvme,drive=mynvme,serial=deadbeef,spdm_port=2323
> +        -device nvme,drive=mynvme,serial=deadbeef,spdm_port=2323,spdm_trans=doe
>  
>  At which point QEMU will try to connect to the SPDM server.
>  
> @@ -113,7 +113,13 @@ of the default. So the entire QEMU command might look like this
>          -append "root=/dev/vda console=ttyS0" \
>          -net none -nographic \
>          -drive file=blknvme,if=none,id=mynvme,format=raw \
> -        -device nvme,drive=mynvme,serial=deadbeef,spdm_port=2323
> +        -device nvme,drive=mynvme,serial=deadbeef,spdm_port=2323,spdm_trans=doe

I wonder if, for command line backwards compatibility we should have a default
of doe if no spdm_trans parameter is provided?

> +
> +The `spdm_trans` argument defines the underlying transport type that is emulated
> +by QEMU. For an PCIe NVMe controller, both "doe" and "nvme" are supported. Where,
> +"doe" does SPDM transport over the PCIe extended capability Data Object Exchange
> +(DOE), and "nvme" uses the NVMe Admin Security Send/Receive commands to
> +implement the SPDM transport.
>  
>  .. _DMTF:
>     https://www.dmtf.org/standards/SPDM
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index df72599bcc..e485e0584e 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c

> @@ -9308,6 +9326,7 @@ static const Property nvme_props[] = {
>                       false),
>      DEFINE_PROP_UINT16("mqes", NvmeCtrl, params.mqes, 0x7ff),
>      DEFINE_PROP_UINT16("spdm_port", PCIDevice, spdm_port, 0),
> +    DEFINE_PROP_SPDM_TRANS_NODEFAULT("spdm_trans", PCIDevice, spdm_trans),

As above. I think a default is appropriate here.

>      DEFINE_PROP_BOOL("ctratt.mem", NvmeCtrl, params.ctratt.mem, false),
>      DEFINE_PROP_BOOL("atomic.dn", NvmeCtrl, params.atomic_dn, 0),
>      DEFINE_PROP_UINT16("atomic.awun", NvmeCtrl, params.atomic_awun, 0),


