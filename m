Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33545D78770
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 17:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWefT-0007RI-Rp; Fri, 19 Dec 2025 12:53:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vWefR-0007R6-R0
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 12:53:29 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vWefP-0007Ti-Fl
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 12:53:29 -0500
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dXw9Q111dzHnGd2;
 Sat, 20 Dec 2025 01:52:42 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id AB9B440571;
 Sat, 20 Dec 2025 01:53:11 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 19 Dec
 2025 17:53:11 +0000
Date: Fri, 19 Dec 2025 17:53:09 +0000
To: Markus Armbruster <armbru@redhat.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, <ira.weiny@intel.com>,
 <alucerop@amd.com>, <a.manzanares@samsung.com>, <dongjoo.seo1@samsung.com>,
 <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <linux-cxl@vger.kernel.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH 3/5] hw/cxl: Allow BI by default in Window restrictions
Message-ID: <20251219175309.000009b1@huawei.com>
In-Reply-To: <873457aii2.fsf@pond.sub.org>
References: <20251103195209.1319917-1-dave@stgolabs.net>
 <20251103195209.1319917-4-dave@stgolabs.net>
 <87wm2ki1wm.fsf@pond.sub.org> <20251218154832.00000159@huawei.com>
 <873457aii2.fsf@pond.sub.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 18 Dec 2025 16:59:17 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> Jonathan Cameron <jonathan.cameron@huawei.com> writes:
> 
> > On Thu, 18 Dec 2025 10:18:17 +0100
> > Markus Armbruster <armbru@redhat.com> wrote:
> >  
> >> Davidlohr Bueso <dave@stgolabs.net> writes:
> >>   
> >> > Update the CFMW restrictions to also permit Back-Invalidate
> >> > flows by default, which is aligned with the no-restrictions
> >> > policy.
> >> >
> >> > While at it, document the 'restrictions=' option.    
> >> 
> >> I'd split the patch.  Up to you.  
> > Hi Markus,
> >
> > As you note below the interface hasn't been in any release anyway and
> > is part of the long backlog I'm carrying and slowly getting
> > upstream. Bringing this in from the start with that restrictions
> > control should be fine.
> >
> > However, backwards compatibility does need addressing
> > as this changes the default for things we do create today (with
> > no restrictions).
> >
> > In this particular case, I don't think we care because there are no
> > BI capable devices before this series - so there can't be anything
> > using this feature for the host memory range it describes.
> >
> > As such, the only result is the ACPI table says we have an extra
> > flag set which no one will care about.  Will need to update
> > the ACPI table tests though. I'll check.
> >
> > Migration of CXL topologies is horribly broken currently anyway
> > so that's not a problem here. Given current usecases are strictly
> > software stack verification fixing that isn't a priority (yet).  
> 
> Good to know.  Work into commit message(s)?
> 
Will do.

I'll shuffle things around a bit whilst adding this to my staging
tree and first of all update the default (before the configuration
interface patch) to include this.  That patch will have some info
on backwards compatibility etc + ACPI tables updates (usual 3 patch
sequence to do that).

'll squash this patch into the generic restrictions configuration
interface patch.  That can then run separately wrt to
getting things upstreamed. It's a somewhat ugly interface at the
moment so that might needs some more involved discussion than
the BI support itself.

Jonathan


