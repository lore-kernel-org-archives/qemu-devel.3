Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DCCC0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 11:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdpZX-0004y5-Q5; Fri, 31 Jan 2025 06:52:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tdpZV-0004xi-IY
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 06:52:29 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tdpZT-0003Jl-33
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 06:52:29 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YkvPV01Mbz6K5ny;
 Fri, 31 Jan 2025 19:51:42 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 7BE32140155;
 Fri, 31 Jan 2025 19:52:23 +0800 (CST)
Received: from localhost (10.195.244.178) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 31 Jan
 2025 12:52:22 +0100
Date: Fri, 31 Jan 2025 11:52:20 +0000
To: Zhi Wang <zhiw@nvidia.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "dave.jiang@intel.com"
 <dave.jiang@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "fan.ni@samsung.com" <fan.ni@samsung.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "alucerop@amd.com" <alucerop@amd.com>,
 "clg@redhat.com" <clg@redhat.com>, Andy Currid <ACurrid@nvidia.com>, Neo Jia
 <cjia@nvidia.com>, Surath Mitra <smitra@nvidia.com>, Ankit Agrawal
 <ankita@nvidia.com>, Aniket Agashe <aniketa@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
 "zhiwang@kernel.org" <zhiwang@kernel.org>
Subject: Re: [PATCH 3/3] hw/cxl: introduce CXL type-2 device emulation
Message-ID: <20250131115220.0000625c@huawei.com>
In-Reply-To: <8d08ab33-d989-4209-b137-a6991c7af415@nvidia.com>
References: <20241212130422.69380-1-zhiw@nvidia.com>
 <20241212130422.69380-4-zhiw@nvidia.com>
 <20250121161610.000025af@huawei.com>
 <8d08ab33-d989-4209-b137-a6991c7af415@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.244.178]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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


> >> +static void cxl_accel_class_init(ObjectClass *oc, void *data)
> >> +{
> >> +    DeviceClass *dc = DEVICE_CLASS(oc);
> >> +    PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
> >> +
> >> +    pc->realize = cxl_accel_realize;
> >> +    pc->exit = cxl_accel_exit;
> >> +
> >> +    pc->class_id = PCI_CLASS_CXL_QEMU_ACCEL;
> >> +    pc->vendor_id = PCI_VENDOR_ID_INTEL;
> >> +    pc->device_id = 0xd94;  
> >  
> 
> The IDs are mostly from Ira's original T2 emulated device patches.
> I will take a look to see if there is a better option for this.

I pinged Ira and you on the CXL discord.  May be fine to use this
and save you figuring out who in holds the magic list at NVidia
and persuading them to let you have one ;)

> 
> > If you are posting these I hope you have those IDs reserved
> > (which seems unlikely ;)
> > We need to be absolutely sure we never hit an existing ID which generally
> > means you need to find whoever controls those allocations in your company
> > and get them to give you an ID for this.
> >  
> >> +    pc->revision = 1;
> >> +
> >> +    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> >> +    dc->desc = "CXL Accelerator Device (Type 2)";
> >> +    device_class_set_legacy_reset(dc, cxl_accel_reset);
> >> +    device_class_set_props(dc, cxl_accel_props);
> >> +}  
> >  
> >>   void cxl_event_init(CXLDeviceState *cxlds, int start_msg_num);
> >> diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
> >> index f1a53fea8d..08bc469316 100644
> >> --- a/include/hw/pci/pci_ids.h
> >> +++ b/include/hw/pci/pci_ids.h
> >> @@ -55,6 +55,7 @@
> >>   #define PCI_CLASS_MEMORY_RAM             0x0500
> >>   #define PCI_CLASS_MEMORY_FLASH           0x0501
> >>   #define PCI_CLASS_MEMORY_CXL             0x0502
> >> +#define PCI_CLASS_CXL_QEMU_ACCEL         0x0503  
> >
> > Either this is a real device class (which seems unlikely given the name)
> > or you need to choose something else.  PCI maintains a big list of
> > class codes and currently 0x0502 is the highest one define in baseclass 05h
> > (memory controllers)
> >
> > https://members.pcisig.com/wg/PCI-SIG/document/20113
> > (behind a pcisig login)
> >  
> >>   #define PCI_CLASS_MEMORY_OTHER           0x0580
> >>
> >>   #define PCI_BASE_CLASS_BRIDGE            0x06  
> >  
> 


