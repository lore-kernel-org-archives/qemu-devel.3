Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC88C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 09:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZp6q-0005Vj-40; Tue, 13 Feb 2024 04:29:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rZp6o-0005VY-OF
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:29:46 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rZp6n-0006Or-BR
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:29:46 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TYwt24f3xz6J9vB;
 Tue, 13 Feb 2024 17:25:46 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id EA8F714163D;
 Tue, 13 Feb 2024 17:29:42 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 09:29:42 +0000
Date: Tue, 13 Feb 2024 09:29:41 +0000
To: fan <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <ira.weiny@intel.com>, <dan.j.williams@intel.com>,
 <a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>, 
 <nifan@outlook.com>, <jim.harris@samsung.com>, "Fan Ni" <fan.ni@samsung.com>
Subject: Re: [PATCH v3 8/9] hw/cxl/events: Add qmp interfaces to add/release
 dynamic capacity extents
Message-ID: <20240213092941.00000ad3@Huawei.com>
In-Reply-To: <ZcUotSCiFYEceShP@debian>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
 <20231107180907.553451-9-nifan.cxl@gmail.com>
 <20240124165004.00003228@Huawei.com> <ZcUotSCiFYEceShP@debian>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


> > >  #endif
> > > diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> > > index d778487b7e..4f8cb3215d 100644
> > > --- a/include/hw/cxl/cxl_events.h
> > > +++ b/include/hw/cxl/cxl_events.h
> > > @@ -166,4 +166,19 @@ typedef struct CXLEventMemoryModule {
> > >      uint8_t reserved[0x3d];
> > >  } QEMU_PACKED CXLEventMemoryModule;
> > >  
> > > +/*
> > > + * CXL r3.0 section Table 8-47: Dynamic Capacity Event Record
> > > + * All fields little endian.
> > > + */
> > > +typedef struct CXLEventDynamicCapacity {
> > > +    CXLEventRecordHdr hdr;
> > > +    uint8_t type;
> > > +    uint8_t reserved1;
> > > +    uint16_t host_id;
> > > +    uint8_t updated_region_id;
> > > +    uint8_t reserved2[3];
> > > +    uint8_t dynamic_capacity_extent[0x28]; /* defined in cxl_device.h */  
> > 
> > Can't we use that definition here?  
> 
> REPLY: 
> 
> I leave it as it is to avoid include cxl_device.h to cxl_extent.h.
> 
> Do you think we need to include the file and use the definition here?

I don't feel strongly either way.

Jonathan

> 
> Fan

