Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD46D6E2AC
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 15:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWGFQ-0002g3-Cg; Thu, 18 Dec 2025 10:49:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vWGFK-0002fP-I1
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 10:48:54 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vWGFE-0005ki-TU
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 10:48:52 -0500
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dXFS356h0zJ467G;
 Thu, 18 Dec 2025 23:48:03 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id DFB084056B;
 Thu, 18 Dec 2025 23:48:34 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 18 Dec
 2025 15:48:34 +0000
Date: Thu, 18 Dec 2025 15:48:32 +0000
To: Markus Armbruster <armbru@redhat.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, <ira.weiny@intel.com>,
 <alucerop@amd.com>, <a.manzanares@samsung.com>, <dongjoo.seo1@samsung.com>,
 <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <linux-cxl@vger.kernel.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH 3/5] hw/cxl: Allow BI by default in Window restrictions
Message-ID: <20251218154832.00000159@huawei.com>
In-Reply-To: <87wm2ki1wm.fsf@pond.sub.org>
References: <20251103195209.1319917-1-dave@stgolabs.net>
 <20251103195209.1319917-4-dave@stgolabs.net>
 <87wm2ki1wm.fsf@pond.sub.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
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

On Thu, 18 Dec 2025 10:18:17 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> Davidlohr Bueso <dave@stgolabs.net> writes:
> 
> > Update the CFMW restrictions to also permit Back-Invalidate
> > flows by default, which is aligned with the no-restrictions
> > policy.
> >
> > While at it, document the 'restrictions=' option.  
> 
> I'd split the patch.  Up to you.
Hi Markus,

As you note below the interface hasn't been in any release anyway and
is part of the long backlog I'm carrying and slowly getting
upstream. Bringing this in from the start with that restrictions
control should be fine.

However, backwards compatibility does need addressing
as this changes the default for things we do create today (with
no restrictions).

In this particular case, I don't think we care because there are no
BI capable devices before this series - so there can't be anything
using this feature for the host memory range it describes.

As such, the only result is the ACPI table says we have an extra
flag set which no one will care about.  Will need to update
the ACPI table tests though. I'll check.

Migration of CXL topologies is horribly broken currently anyway
so that's not a problem here. Given current usecases are strictly
software stack verification fixing that isn't a priority (yet).

Jonathan

> 
> > Tested-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
> > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> > ---
> >  hw/cxl/cxl-host.c | 2 +-
> >  qapi/machine.json | 3 ++-
> >  qemu-options.hx   | 4 +++-
> >  3 files changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> > index e420b25176a6..ed0c76a31980 100644
> > --- a/hw/cxl/cxl-host.c
> > +++ b/hw/cxl/cxl-host.c
> > @@ -64,7 +64,7 @@ static void cxl_fixed_memory_window_config(CXLFixedMemoryWindowOptions *object,
> >      if (object->has_restrictions) {
> >          fw->restrictions = object->restrictions;
> >      } else {
> > -        fw->restrictions = 0xf; /* No restrictions */
> > +        fw->restrictions = 0x2f; /* No restrictions */
> >      }
> >  
> >      fw->targets = g_malloc0_n(fw->num_targets, sizeof(*fw->targets));
> > diff --git a/qapi/machine.json b/qapi/machine.json
> > index 225690d2986a..85e31432b038 100644
> > --- a/qapi/machine.json
> > +++ b/qapi/machine.json
> > @@ -555,7 +555,8 @@
> >  #     BIT(2) - Volatile
> >  #     BIT(3) - Persistent
> >  #     BIT(4) - Fixed Device Config
> > -#     Default is 0xF
> > +#     BIT(5) - BI
> > +#     Default is 0x2F
> >  #
> >  # @targets: Target root bridge IDs from -device ...,id=<ID> for each
> >  #     root bridge.  
> 
> This changes the default of @restrictions.  No problem since
> @restrictions has not been in any release.  If it was, we'd have to
> consider backward compatibility.
> 
> [...]
> 
> 


