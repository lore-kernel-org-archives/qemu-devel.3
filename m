Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273B4C30653
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 02:00:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPYEk-0002UW-9L; Thu, 04 Jul 2024 21:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sPYEg-0002TK-F2
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 21:59:43 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sPYEe-0002Vj-0c
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 21:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720144780; x=1751680780;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=H5aKULNt4WSucCpS33VBoTqFB2U+MngO5Rz+nQDfDew=;
 b=Eij/3Mogp6p7eTspowIBlbShKA+/utwvOEU30RFOcBhd1+LDiSLHNfbw
 lh6WmAWTf49utV17y05gQi/EykvTdtN6pPTS2IOL+NgAleFBrSd7KW9qT
 bNtVJhNex2Sk6Gn9+tleLieIVJwmIRBQDmBuXZj7Kv/YU4PwKWWWzPalT
 kuOVmeMR/Noo5Z8w9hRRrU4Nj3EIL1UKetbymUOhpduaduWpXo99BQI03
 BHQTYo+alAkbZZiE6I6nafUxgiyvLbu1IDWbn2OEXs4DfrtQiPxtbvEWa
 PdcnXb5VWmcfeJILVbDVzQeb7s8cTVlIudRFwdtbsxKvl1+TeTwXvFgty A==;
X-CSE-ConnectionGUID: eH43dk/XR/KgK/ZOLRo9zQ==
X-CSE-MsgGUID: IXPcUyGNQ/uYtgec879YpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="28820686"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="28820686"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 18:59:37 -0700
X-CSE-ConnectionGUID: v/fgd0WsTXKYXpSlhOVeNA==
X-CSE-MsgGUID: 73xskWlKTLid94cGL7iGvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="51695204"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa005.jf.intel.com with ESMTP; 04 Jul 2024 18:59:34 -0700
Date: Fri, 5 Jul 2024 10:15:12 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "linuxarm@huawei.com" <linuxarm@huawei.com>,
 Zhao Liu <zhao1.liu@linux.intel.com>
Subject: Re: [PATCH 1/3] hw/cxl: Get rid of unused cfmw_list
Message-ID: <ZodXMPef9bIROG5u@intel.com>
References: <20240702143425.717452-1-Jonathan.Cameron@huawei.com>
 <20240702143425.717452-2-Jonathan.Cameron@huawei.com>
 <5ffea576-0b87-46c1-b4dc-e09bd253805e@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ffea576-0b87-46c1-b4dc-e09bd253805e@fujitsu.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jul 05, 2024 at 01:04:51AM +0000, Zhijian Li (Fujitsu) wrote:
> Date: Fri, 5 Jul 2024 01:04:51 +0000
> From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
> Subject: Re: [PATCH 1/3] hw/cxl: Get rid of unused cfmw_list
> 
> Jonathan,
> 
> 
> There is a new user for cfmw_list now
> https://lore.kernel.org/qemu-devel/20240704093404.1848132-1-zhao1.liu@linux.intel.com/
> 
> So I think we should drop this patch.

Hi Zhijian,

I'm not a "real" user and that bug was originally found by code reading.

So that fix won't block your drop. :-)

And I think the fix is worth being laned before cfmw_list gets dropped,
for being able to port backwards to stable QEMU.
 
> On 02/07/2024 22:34, Jonathan Cameron wrote:
> > From: Li Zhijian <lizhijian@fujitsu.com>
> > 
> > There is no user for this member. All '-M cxl-fmw.N' options have
> > been parsed and saved to CXLState.fixed_windows.
> > 
> > Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >   include/hw/cxl/cxl.h | 1 -
> >   hw/cxl/cxl-host.c    | 1 -
> >   2 files changed, 2 deletions(-)
> > 
> > diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
> > index 75e47b6864..e3ecbef038 100644
> > --- a/include/hw/cxl/cxl.h
> > +++ b/include/hw/cxl/cxl.h
> > @@ -43,7 +43,6 @@ typedef struct CXLState {
> >       MemoryRegion host_mr;
> >       unsigned int next_mr_idx;
> >       GList *fixed_windows;
> > -    CXLFixedMemoryWindowOptionsList *cfmw_list;
> >   } CXLState;
> >   
> >   struct CXLHost {
> > diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> > index c5f5fcfd64..926d3d3da7 100644
> > --- a/hw/cxl/cxl-host.c
> > +++ b/hw/cxl/cxl-host.c
> > @@ -335,7 +335,6 @@ static void machine_set_cfmw(Object *obj, Visitor *v, const char *name,
> >       for (it = cfmw_list; it; it = it->next) {
> >           cxl_fixed_memory_window_config(state, it->value, errp);
> >       }
> > -    state->cfmw_list = cfmw_list;
> >   }
> >   
> >   void cxl_machine_init(Object *obj, CXLState *state)

