Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96127C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 11:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teuiL-000428-Bx; Mon, 03 Feb 2025 06:34:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1teuiI-00041n-9x
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 06:34:02 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1teuiG-0006jJ-5j
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 06:34:02 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ymkrg1J2Zz6K9C0;
 Mon,  3 Feb 2025 19:33:07 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id BDE39140B73;
 Mon,  3 Feb 2025 19:33:56 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 3 Feb
 2025 12:33:56 +0100
Date: Mon, 3 Feb 2025 11:33:54 +0000
To: Adam Manzanares <a.manzanares@samsung.com>
CC: Vinayak Holikatti <vinayak.kh@samsung.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "krish.reddy@samsung.com" <krish.reddy@samsung.com>, 
 "vishak.g@samsung.com" <vishak.g@samsung.com>, "alok.rathore@samsung.com"
 <alok.rathore@samsung.com>, "s5.kumari@samsung.com" <s5.kumari@samsung.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/2] hw/cxl/cxl-mailbox-utils: Add support for Media
 operations Sanitize and Write Zeros commands (8.2.9.9.5.3)
Message-ID: <20250203113354.00007cd7@huawei.com>
In-Reply-To: <Z503EpvqMczHIZqF@sjvm-adma01.eng.stellus.in>
References: <20250123050903.92336-1-vinayak.kh@samsung.com>
 <CGME20250123050913epcas5p45fb9a638e62f436076da283e86e54ea2@epcas5p4.samsung.com>
 <20250123050903.92336-3-vinayak.kh@samsung.com>
 <20250124151946.0000134f@huawei.com>
 <Z503EpvqMczHIZqF@sjvm-adma01.eng.stellus.in>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
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


> >   
> > > +    int dpa_range_count = san_info->dpa_range_count;
> > > +    int rc = 0;
> > > +
> > > +    for (int i = 0; i < dpa_range_count; i++) {
> > > +        rc = sanitize_range(ct3d, san_info->dpa_range_list[i].starting_dpa,
> > > +                san_info->dpa_range_list[i].length, san_info->fill_value);
> > > +        if (rc) {
> > > +            goto exit;
> > > +        }
> > > +    }
> > > +    cxl_discard_all_event_records(&ct3d->cxl_dstate);  
> > 
> > Add a comment on why we are deleting event records when sanitizing a small
> > part of memory?
> >   
> 
> See response below for disabling the media state. Same section referenced
> below, 8.2.10.9.5.1 states all event logs should be deleted. Outcome
> depends on how we interpret "follow the method described in 8.2.10.9.5.1".
> 

This also sounds like reading too much into that comment.

> > > +    }
> > > +
> > > +start_bg:
> > > +    /* EBUSY other bg cmds as of now */
> > > +    cci->bg.runtime = secs * 1000UL;
> > > +    *len_out = 0;
> > > +    /* sanitize when done */
> > > +    cxl_dev_disable_media(&ct3d->cxl_dstate);  
> > Why?  This is santizing part of the device. As I undestand it the
> > main aim is to offload cleanup when the device is in use. Definitely
> > don't want to disable media.  If I'm missing a reason please give
> > a spec reference.  
> 
> Table 8-164, sanitize description mentions to follow method
> in 8.2.10.9.5.1, which does call out placing device in disabled
> state, but I'm not sure if method refers to all text in 8.2.10.9.5.1
> or the method devices uses to sanitize internally.

I think it is meant to just be the method of sanitizing. 

> 
> I would imagine since sanitize is destructive we would not want to return 
> any data from device ranges impacted by sanitize. I believe a simple
> way to achieve this is to disable entire device. 

Hmm.  That rather destroys the main use case I'm aware of for this
(unlike the general santize commands from earlier CXL versions)/
Superficially sounds like we need a spec clarification as
clearly not super clear!

> 

Jonathan



