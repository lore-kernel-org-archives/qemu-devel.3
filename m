Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C3D3C5B549
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 13:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKzbo-0008WG-TH; Fri, 30 May 2025 09:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uKzbl-0008Vz-Uv
 for qemu-devel@nongnu.org; Fri, 30 May 2025 09:17:13 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uKzbj-0005E4-8L
 for qemu-devel@nongnu.org; Fri, 30 May 2025 09:17:13 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b83fw4PB4z6M4hH;
 Fri, 30 May 2025 21:16:56 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 3BF0214027A;
 Fri, 30 May 2025 21:17:02 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 May
 2025 15:17:01 +0200
Date: Fri, 30 May 2025 14:17:00 +0100
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>, "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>, "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH qemu] hw/cxl: Fix register block locator size
Message-ID: <20250530141700.00005619@huawei.com>
In-Reply-To: <e7050a05-3349-46c6-9ac5-60b621f54a0b@fujitsu.com>
References: <20250529134828.403049-1-Jonathan.Cameron@huawei.com>
 <e7050a05-3349-46c6-9ac5-60b621f54a0b@fujitsu.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
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

On Fri, 30 May 2025 02:59:40 +0000
"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> wrote:

> On 29/05/2025 21:48, Jonathan Cameron via wrote:
> > This has been wrong from day 1.  For now we only have
> > two entries (component and device registers).  
> 
> Wow, I finally understood this.
> 
> 
> > 
> > The wrong size could lead to arbitrary data off the stack being presented
> > in PCIe config space.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >   include/hw/cxl/cxl_pci.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/hw/cxl/cxl_pci.h b/include/hw/cxl/cxl_pci.h
> > index d0855ed78b..3bb882ce89 100644
> > --- a/include/hw/cxl/cxl_pci.h
> > +++ b/include/hw/cxl/cxl_pci.h
> > @@ -31,7 +31,7 @@
> >   #define PCIE_CXL3_FLEXBUS_PORT_DVSEC_LENGTH 0x20
> >   #define PCIE_CXL3_FLEXBUS_PORT_DVSEC_REVID  2
> >   
> > -#define REG_LOC_DVSEC_LENGTH 0x24
> > +#define REG_LOC_DVSEC_LENGTH 0x1C  
> 
> IMHO, REG_LOC_DVSEC_LENGTH is device specific, that mean we shouldn't put it in
> a general header with a general name
> 
> try:
> $ git grep REG_LOC_DVSEC_LENGTH
> 
> we got another REG_LOC_DVSEC_LENGTH, shouldn't its value (0x1C - 0x8)?
> 
> 
>   51     regloc_dvsec = &(CXLDVSECRegisterLocator) {
>   52         .rsvd         = 0,
>   53         .reg0_base_lo = RBI_CXL_DEVICE_REG | 0,
>   54         .reg0_base_hi = 0,
>   55     };
>   56     cxl_component_create_dvsec(cxl_cstate, CXL3_SWITCH_MAILBOX_CCI,
>   57                                REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
>   58                                REG_LOC_DVSEC_REVID, (uint8_t *)regloc_dvsec);
> 
Ah.  This isn't a bug at all.  I clearly needed more caffeine.

We are fine because at least in 3.2 the register block identifier of 0 is reserved and
I misread the code completely.  It is odd to have empty entries but not a bug.

Jonathan

> 
> Thanks
> Zhijian
> 
> 
> 
> >   #define REG_LOC_DVSEC_REVID  0
> >   
> >   enum   


