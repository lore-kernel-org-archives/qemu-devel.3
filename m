Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A52CC47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 11:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTKcN-0002oQ-64; Fri, 26 Jan 2024 06:43:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rTKcK-0002oG-Of
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 06:43:28 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rTKcI-0004Gx-MA
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 06:43:28 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TLwjx0xpXz689rg;
 Fri, 26 Jan 2024 19:40:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 73AA4140CF4;
 Fri, 26 Jan 2024 19:43:17 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Jan
 2024 11:43:17 +0000
Date: Fri, 26 Jan 2024 11:43:16 +0000
To: fan <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Fan Ni
 <fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>, Davidlohr Bueso
 <dave@stgolabs.net>, <linuxarm@huawei.com>, Philippe =?ISO-8859-1?Q?Mathieu?=
 =?ISO-8859-1?Q?-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 5/5] hw/cxl: Standardize all references on CXL r3.1 and
 minor updates
Message-ID: <20240126114316.00006b9a@Huawei.com>
In-Reply-To: <ZbF56-RHbxY9yAUv@debian>
References: <20240124134814.8717-1-Jonathan.Cameron@huawei.com>
 <20240124134814.8717-6-Jonathan.Cameron@huawei.com>
 <ZbF56-RHbxY9yAUv@debian>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Wed, 24 Jan 2024 12:58:19 -0800
fan <nifan.cxl@gmail.com> wrote:

> On Wed, Jan 24, 2024 at 01:48:14PM +0000, Jonathan Cameron wrote:
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
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---  
> 
> There are several references to the spec is incorrect, other than that
> LGTM.
> 
> Search "Identify Memory Device (Opcode 4000h)" for inline comments.
Thanks for ploughing through all this!


> >      /* Store off everything to local variables so we can wipe out the payload */
> > @@ -760,7 +757,7 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
> >      return CXL_MBOX_SUCCESS;
> >  }
> >  
> > -/* 8.2.9.5.1.1 */
> > +/* CXL r3.1 Section 8.2.9.8.1.1: Identify Memory Device (Opcode 4000h) */  
> 
> Should be 8.2.9.9.1.1

Oops. I think I had the 3.0 spec open by accident when doing some of these.
Good catch - I'll fix these all up and send a v2.


