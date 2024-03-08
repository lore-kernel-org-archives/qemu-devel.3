Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CFEC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 14:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ribIv-0001aS-Ve; Fri, 08 Mar 2024 09:34:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ribIt-0001aJ-PY
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:34:32 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ribIq-0007bn-Gz
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:34:31 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TrpZv4zybz67fBs;
 Fri,  8 Mar 2024 22:34:15 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id ADEAB140136;
 Fri,  8 Mar 2024 22:34:21 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 8 Mar
 2024 14:34:21 +0000
Date: Fri, 8 Mar 2024 14:34:20 +0000
To: Peter Maydell <peter.maydell@linaro.org>
CC: "Michael S. Tsirkin" <mst@redhat.com>, <qemu-devel@nongnu.org>, Fan Ni
 <fan.ni@samsung.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PULL 53/60] hw/cxl: Standardize all references on CXL r3.1 and
 minor updates
Message-ID: <20240308143420.0000536e@Huawei.com>
In-Reply-To: <CAFEAcA_W8BxG6rpcao2hCYntfU9aQfAzHQiy6RJQ-v3ZB4sNZg@mail.gmail.com>
References: <cover.1707909001.git.mst@redhat.com>
 <8700ee15de465a55e5c7281f87618ca4b4827441.1707909001.git.mst@redhat.com>
 <CAFEAcA_W8BxG6rpcao2hCYntfU9aQfAzHQiy6RJQ-v3ZB4sNZg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 8 Mar 2024 13:47:47 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Wed, 14 Feb 2024 at 11:16, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Previously not all references mentioned any spec version at all.
> > Given r3.1 is the current specification available for evaluation at
> > www.computeexpresslink.org update references to refer to that.
> > Hopefully this won't become a never ending job.
> >
> > A few structure definitions have been updated to add new fields.
> > Defaults of 0 and read only are valid choices for these new DVSEC
> > registers so go with that for now.
> >
> > There are additional error codes and some of the 'questions' in
> > the comments are resolved now.
> >
> > Update documentation reference to point to the CXL r3.1 specification
> > with naming closer to what is on the cover.
> >
> > For cases where there are structure version numbers, add defines
> > so they can be found next to the register definitions.  
> 
> Hi; Coverity points out that this change has introduced a
> buffer overrun (CID 1534905). In hw/mem/cxl_type3.c:build_dvsecs()
> we create a local struct of type CXLDVSecDevice, and then we
> pass it to cxl_component_create_dvsec() as the body parameter,
> passing it a length argument PCIE_CXL_DEVICE_DVSEC_LENGTH.
> 
> Before this change, both sizeof(CXLDVSecDevice) and
> PCIE_CXL_DEVICE_DVSEC_LENGTH were 0x38, so this was fine.
> But now...
> 
> > diff --git a/include/hw/cxl/cxl_pci.h b/include/hw/cxl/cxl_pci.h
> > index ddf01a543b..265db6c407 100644
> > --- a/include/hw/cxl/cxl_pci.h
> > +++ b/include/hw/cxl/cxl_pci.h
> > @@ -16,9 +16,8 @@
> >  #define PCIE_DVSEC_HEADER1_OFFSET 0x4 /* Offset from start of extend cap */
> >  #define PCIE_DVSEC_ID_OFFSET 0x8
> >
> > -#define PCIE_CXL_DEVICE_DVSEC_LENGTH 0x38
> > -#define PCIE_CXL1_DEVICE_DVSEC_REVID 0
> > -#define PCIE_CXL2_DEVICE_DVSEC_REVID 1
> > +#define PCIE_CXL_DEVICE_DVSEC_LENGTH 0x3C
> > +#define PCIE_CXL31_DEVICE_DVSEC_REVID 3
> >
> >  #define EXTENSIONS_PORT_DVSEC_LENGTH 0x28
> >  #define EXTENSIONS_PORT_DVSEC_REVID 0  
> 
> ...PCIE_CXL_DEVICE_DVSEC_LENGTH is 0x3C...
Gah.  Evil spec change - they defined only one extra
u16 worth of data but added padding after it and I missed
that in the structure definition.

> 
> > -/* CXL 2.0 - 8.1.3 (ID 0001) */
> > +/*
> > + * CXL r3.1 Section 8.1.3: PCIe DVSEC for Devices
> > + * DVSEC ID: 0, Revision: 3
> > + */
> >  typedef struct CXLDVSECDevice {
> >      DVSECHeader hdr;
> >      uint16_t cap;
> > @@ -82,10 +91,14 @@ typedef struct CXLDVSECDevice {
> >      uint32_t range2_size_lo;
> >      uint32_t range2_base_hi;
> >      uint32_t range2_base_lo;
> > -} CXLDVSECDevice;
> > -QEMU_BUILD_BUG_ON(sizeof(CXLDVSECDevice) != 0x38);
> > +    uint16_t cap3;
> > +} QEMU_PACKED CXLDVSECDevice;
> > +QEMU_BUILD_BUG_ON(sizeof(CXLDVSECDevice) != 0x3A);  
(this is the assert I mention below)
> 
> ...and CXLDVSECDevice is only size 0x3A, so we try to read off the
> end of the struct.
> 
> What was supposed to happen here?
needs an extra uint16_t resv; at the end.

> 
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -319,7 +319,7 @@ static void build_dvsecs(CXLType3Dev *ct3d)
> >      cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
> >                                 PCIE_CXL_DEVICE_DVSEC_LENGTH,
> >                                 PCIE_CXL_DEVICE_DVSEC,
> > -                               PCIE_CXL2_DEVICE_DVSEC_REVID, dvsec);
> > +                               PCIE_CXL31_DEVICE_DVSEC_REVID, dvsec);
> >
> >      dvsec = (uint8_t *)&(CXLDVSECRegisterLocator){
> >          .rsvd         = 0,  
> 
> Perhaps this call to cxl_component_create_dvsec() was
> supposed to have the length argument changed, as seems
> to have been done with this other call:
> 
> > @@ -346,9 +346,9 @@ static void build_dvsecs(CXLType3Dev *ct3d)
> >          .rcvd_mod_ts_data_phase1 = 0xef, /* WTF? */
> >      };
> >      cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
> > -                               PCIE_FLEXBUS_PORT_DVSEC_LENGTH_2_0,
> > +                               PCIE_CXL3_FLEXBUS_PORT_DVSEC_LENGTH,
> >                                 PCIE_FLEXBUS_PORT_DVSEC,
> > -                               PCIE_FLEXBUS_PORT_DVSEC_REVID_2_0, dvsec);
> > +                               PCIE_CXL3_FLEXBUS_PORT_DVSEC_REVID, dvsec);
> >  }  
> 
>  static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
> 
> 
> and with similar other calls in the commit ?
> 
> Is there a way we could write this that would catch this error?
> I'm thinking maybe something like
> 
> #define CXL_CREATE_DVSEC(CXL, DEVTYPE, TYPE, DATA) do { \
>      assert(sizeof(*DATA) == TYPE##_LENGTH); \
>      cxl_component_create_dvsec(CXL, DEVTYPE, TYPE##_LENGTH, \
>                                 TYPE, TYPE##_REVID, (uint8_t*)DATA); \
>      } while (0)

We should be able to use the length definitions in the original assert.
I'm not sure why that wasn't done before.  I think there were some cases
where we supported multiple versions and so the length can be shorter
than the structure defintion but that doesn't matter on this one.

So I think minimal fix is u16 of padding and update the assert.
Can circle back to tidy up the multiple places the value is defined.
Any mismatch in which the wrong length define is used should be easy
enough to spot so not sure we need the macro you suggest.

I'll send a patch shortly.

Thanks,

Jonathan

> 
> thanks
> -- PMM


