Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFD0C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 11:51:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx3o5-0007Ld-Se; Wed, 17 Apr 2024 07:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rx3o2-0007L7-5d
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 07:50:26 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rx3ny-0003N7-Hz
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 07:50:25 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VKJxT1r16z6K9WL;
 Wed, 17 Apr 2024 19:45:17 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id C73A3140A08;
 Wed, 17 Apr 2024 19:50:14 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 17 Apr
 2024 12:50:14 +0100
Date: Wed, 17 Apr 2024 12:50:13 +0100
To: fan <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <gregory.price@memverge.com>, <ira.weiny@intel.com>,
 <dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
 <nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
 <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v6 09/12] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <20240417125013.00000a74@Huawei.com>
In-Reply-To: <Zh6swM5SbnXkB76H@debian>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
 <20240325190339.696686-10-nifan.cxl@gmail.com>
 <20240405131856.000025e7@Huawei.com> <ZhWym2yHoh6YIaXj@debian>
 <20240410204911.0000590b@Huawei.com> <Zh2IrA8TQDJn1ft_@debian>
 <20240416155822.00004fce@Huawei.com> <Zh6swM5SbnXkB76H@debian>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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


> > >  
> > >      ret = cxl_detect_malformed_extent_list(ct3d, in);
> > >      if (ret != CXL_MBOX_SUCCESS) {
> > > +        cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);  
> > 
> > If it's a bad message from the host, I don't think the device is supposed to
> > do anything with pending extents.  
> 
> It is not clear to me here. 
> 
> In the spec r3.1 8.2.9.9.9.3, Add Dynamic Capacity Response (Opcode 4802h),
> there is text like "After this command is received, the device is free to
> reclaim capacity that the host does not utilize.", that seems to imply
> as long as the response is received, we need to update the pending list
> so the capacity unused can be reclaimed. But of course, we can say if
> there is error, we cannot tell whether the host accepts the extents or
> not so not update the pending list.

Can try and get a clarification as I agree 'is received' is unclear,
but in general any command that gets an error response should have no
affect on device state. If it does, then what affect it has must be stated
in the specification.

> >   
> > > +
> > > +#define REMOVAL_POLICY_MASK 0xf
> > > +#define FORCED_REMOVAL_BIT BIT(4)
> > > +
> > > +void qmp_cxl_release_dynamic_capacity(const char *path, uint16_t hid,
> > > +                                      uint8_t flags, uint8_t region_id,
> > > +                                      const char *tag,
> > > +                                      CXLDCExtentRecordList  *records,
> > > +                                      Error **errp)
> > > +{
> > > +    CXLDCEventType type = DC_EVENT_RELEASE_CAPACITY;
> > > +
> > > +    if (flags & FORCED_REMOVAL_BIT) {
> > > +        /* TODO: enable forced removal in the future */
> > > +        type = DC_EVENT_FORCED_RELEASE_CAPACITY;
> > > +        error_setg(errp, "Forced removal not supported yet");
> > > +        return;
> > > +    }
> > > +
> > > +    switch (flags & REMOVAL_POLICY_MASK) {
> > > +    case 1:  
> > Probably benefit form a suitable define.
> >   
> > > +        qmp_cxl_process_dynamic_capacity_prescriptive(path, hid, type,
> > > +                                                      region_id, records, errp);
> > > +        break;  
> > 
> > I'd not noticed before but might as well return from these case blocks.  
> 
> Sorry. I do not follow here. What do you mean by "return from these case
> blocks", are you referring the check above about the forced removal case?

No, what I meant was much simpler - just a code refactoring thing.
        case 1:
            qmp_cxl_process_dynamic_capacity_prescriptive(path, hid, type,
                                                          region_id, records, errp);

            //break;
            return;
> 
> Fan
> 
> >   
> > > +    default:
> > > +        error_setg(errp, "Removal policy not supported");
> > > +        break;
               return;
> > > +    }
> > > +}  


