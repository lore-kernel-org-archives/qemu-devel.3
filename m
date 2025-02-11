Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3926C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 09:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thmY6-0005Ne-D6; Tue, 11 Feb 2025 04:27:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1thmY3-0005Gr-A4
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 04:27:19 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1thmXw-0003qs-Ad
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 04:27:18 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ysbf13vhdz6K9Js;
 Tue, 11 Feb 2025 17:25:45 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id EBAF3140442;
 Tue, 11 Feb 2025 17:26:57 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 11 Feb
 2025 10:26:57 +0100
Date: Tue, 11 Feb 2025 09:26:55 +0000
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <fan.ni@samsung.com>, <qemu-devel@nongnu.org>, <chenbaozi@phytium.com.cn>, 
 <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/1] mem/cxl-type3: Add a default value of sn
Message-ID: <20250211092655.00004310@huawei.com>
In-Reply-To: <20250211022413.80842-2-wangyuquan1236@phytium.com.cn>
References: <20250211022413.80842-1-wangyuquan1236@phytium.com.cn>
 <20250211022413.80842-2-wangyuquan1236@phytium.com.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
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

On Tue, 11 Feb 2025 10:24:13 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> The previous default value of sn is UI64_NULL which would cause the
> cookie of nd_interleave_set be '0' and the "invalid interleave-set
> -cookie" failure in label validation.
Hi Yuquan,

Maybe we should harden the nd_interleave_set code to fail
to set the cookie in the event of no serial number. That is a
device not compliant with the spec, but none the less it is not
implausible with test devices etc.

> 
> As many users maybe not know how to set a unique sn for cxl-type3
> device and perhaps be confuesd by the failure of label validation,
> so this defines '1' as the default value of serial number to fix the
> problem.

That magic value is specifically chosen to be 'undefined' to trigger
clean handling of the failure and not provide the serial number
capability. 

If you have multiple devices and provide a 'valid' default then
there are circumstances in which the device will be seen as a multiheaded
single device attached to two places in the PCI topology.

So I'm not keen to change this.  Ideally we'd have made this a required
parameter from the start, but we didn't and doing so now would result
in a backwards compatibility problem.

So I think this is kind of a 'won't fix' situation on the qemu side.

Jonathan

> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> ---
>  hw/mem/cxl_type3.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 0ae1704a34..a6b5a9f74e 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -310,12 +310,6 @@ static void ct3d_config_write(PCIDevice *pci_dev, uint32_t addr, uint32_t val,
>      pcie_aer_write_config(pci_dev, addr, val, size);
>  }
>  
> -/*
> - * Null value of all Fs suggested by IEEE RA guidelines for use of
> - * EU, OUI and CID
> - */
> -#define UI64_NULL ~(0ULL)
> -
>  static void build_dvsecs(CXLType3Dev *ct3d)
>  {
>      CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
> @@ -856,12 +850,9 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>      pci_config_set_prog_interface(pci_conf, 0x10);
>  
>      pcie_endpoint_cap_init(pci_dev, 0x80);
> -    if (ct3d->sn != UI64_NULL) {
> -        pcie_dev_ser_num_init(pci_dev, 0x100, ct3d->sn);
> -        cxl_cstate->dvsec_offset = 0x100 + 0x0c;
> -    } else {
> -        cxl_cstate->dvsec_offset = 0x100;
> -    }
> +
> +    pcie_dev_ser_num_init(pci_dev, 0x100, ct3d->sn);
> +    cxl_cstate->dvsec_offset = 0x100 + 0x0c;
>  
>      ct3d->cxl_cstate.pdev = pci_dev;
>      build_dvsecs(ct3d);
> @@ -1225,7 +1216,7 @@ static const Property ct3_props[] = {
>                       TYPE_MEMORY_BACKEND, HostMemoryBackend *),
>      DEFINE_PROP_LINK("lsa", CXLType3Dev, lsa, TYPE_MEMORY_BACKEND,
>                       HostMemoryBackend *),
> -    DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
> +    DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, 0x1),
>      DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
>      DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
>      DEFINE_PROP_LINK("volatile-dc-memdev", CXLType3Dev, dc.host_dc,


