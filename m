Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9338FE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 08:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ0UD-0000RA-0q; Tue, 24 Dec 2024 03:41:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1tQ0UA-0000QN-M8; Tue, 24 Dec 2024 03:41:50 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1tQ0U8-0002qu-6S; Tue, 24 Dec 2024 03:41:50 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHSyD3S3Zz67YpK;
 Tue, 24 Dec 2024 16:40:20 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
 by mail.maildlp.com (Postfix) with ESMTPS id 8977C1402DA;
 Tue, 24 Dec 2024 16:41:33 +0800 (CST)
Received: from localhost (10.195.35.193) by frapeml500003.china.huawei.com
 (7.182.85.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 09:41:32 +0100
Date: Tue, 24 Dec 2024 08:41:27 +0000
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: <linuxarm@huawei.com>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>,
 <zhao1.liu@intel.com>, <zhenyu.z.wang@intel.com>,
 <dapeng1.mi@linux.intel.com>, <yongwei.ma@intel.com>, <armbru@redhat.com>,
 <farman@linux.ibm.com>, <peter.maydell@linaro.org>, <mst@redhat.com>,
 <anisinha@redhat.com>, <shannon.zhaosl@gmail.com>, <imammedo@redhat.com>,
 <mtosatti@redhat.com>, <berrange@redhat.com>, <richard.henderson@linaro.org>, 
 <shameerali.kolothum.thodi@huawei.com>, <jiangkunkun@huawei.com>,
 <yangyicong@hisilicon.com>, <sarsanaee@gmail.com>
Subject: Re: [PATCH v4 1/7] i386/cpu: add IsDefined flag to smp-cache property
Message-ID: <20241224084127.00004d43@huawei.com>
In-Reply-To: <20241223174818.000025c7@huawei.com>
References: <20241216175414.1953-1-alireza.sanaee@huawei.com>
 <20241216175414.1953-2-alireza.sanaee@huawei.com>
 <20241223174818.000025c7@huawei.com>
Organization: Huawei
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.35.193]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500003.china.huawei.com (7.182.85.28)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 23 Dec 2024 17:48:18 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Mon, 16 Dec 2024 17:54:08 +0000
> Alireza Sanaee <alireza.sanaee@huawei.com> wrote:
> 
> > This commit adds IsDefined flag to the object and this helps in
> > avoiding extra checks for every single layer of caches in both x86
> > and ARM.
> > 
> > There is already a discussion on mailing list to have this flag. A
> > patch that enables this flag will follow later.
> > 
> > Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>  
> Makes sense.  Zhao Liu, is this something you plan to use in the x86
> code?

Hi Jonathan,

Yes this one comes from Zhao Liu's new patch-set, thanks to him. I will
have to send another version given that.
> 
> Either way
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > ---
> >  hw/core/machine-smp.c | 2 ++
> >  include/hw/boards.h   | 1 +
> >  2 files changed, 3 insertions(+)
> > 
> > diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
> > index 9a28194676..5a02bbf584 100644
> > --- a/hw/core/machine-smp.c
> > +++ b/hw/core/machine-smp.c
> > @@ -371,6 +371,8 @@ bool machine_parse_smp_cache(MachineState *ms,
> >          return false;
> >      }
> >  
> > +    ms->smp_cache.IsDefined = true;
> > +
> >      return true;
> >  }
> >  
> > diff --git a/include/hw/boards.h b/include/hw/boards.h
> > index db2aa2b706..2883a57084 100644
> > --- a/include/hw/boards.h
> > +++ b/include/hw/boards.h
> > @@ -373,6 +373,7 @@ typedef struct CpuTopology {
> >  
> >  typedef struct SmpCache {
> >      SmpCacheProperties props[CACHE_LEVEL_AND_TYPE__MAX];
> > +    bool IsDefined;
> >  } SmpCache;
> >  
> >  /**  
> 


