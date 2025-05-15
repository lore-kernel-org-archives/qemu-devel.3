Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1C3C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 13:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFYsC-0006sh-Pv; Thu, 15 May 2025 09:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uFYsA-0006sJ-JR; Thu, 15 May 2025 09:43:42 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uFYs7-0006Bf-T3; Thu, 15 May 2025 09:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747316620; x=1778852620;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=vo8dXV13XWPnvGDJsJGGv/48U5eWE6FGfZ9So83la7s=;
 b=OSPRTdJrMuaIcMiPoAFzEM0nIYxjHG1Y/yvzVQ45Nl24K7rsr6n6MJlO
 HG3sHNxHECPGYYCwjPlxTjEuHernTzRQLANP9SaOj5siJP15hHS0EiK+Z
 oHeswUR0gTkTqY5ut1/HTLE3dTSzf89oGc2Je8YWToxs3Uay20wCgZOhv
 EWdlN+BsXBevv609gaITDRvCCW25oGPKW4NsNDG7ws3gZAjx9HW+vTPYi
 RP/l7YwTFseZ/aPSaEKWe/6yWvORicb7sG1y5pd5/QBdmrFOuzxEc2Cod
 +rW7orCkzicufxvMVXLC7jgginsw8MCxXVoo1zOq5WSvvrXmwafSfTNsf g==;
X-CSE-ConnectionGUID: 24pRkiJTS6m5ohdf16sdQQ==
X-CSE-MsgGUID: zCqpHDKwQt63Xc6XXc1Trg==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="48938980"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="48938980"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 06:43:17 -0700
X-CSE-ConnectionGUID: XG2nW+kYS/2H2M6o98BD3g==
X-CSE-MsgGUID: jFWGAzGtRXqRvQUqNX39Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="138254307"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 15 May 2025 06:43:16 -0700
Date: Thu, 15 May 2025 22:04:20 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5n77+9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH 2/9] docs/devel/qom: Fix the doc about
 OBJECT_DECLARE_SIMPLE_TYPE
Message-ID: <aCX0ZF6G6sbRvKg6@intel.com>
References: <20250514084957.2221975-1-zhao1.liu@intel.com>
 <20250514084957.2221975-3-zhao1.liu@intel.com>
 <c179270c-d636-e20a-2043-38c09b81b4c6@eik.bme.hu>
 <aCS6pLuiFaeEmeEu@intel.com>
 <abd48771-90ba-fd25-e59f-3c6f90d5c0e5@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abd48771-90ba-fd25-e59f-3c6f90d5c0e5@eik.bme.hu>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Wed, May 14, 2025 at 06:16:31PM +0200, BALATON Zoltan wrote:
> Date: Wed, 14 May 2025 18:16:31 +0200
> From: BALATON Zoltan <balaton@eik.bme.hu>
> Subject: Re: [PATCH 2/9] docs/devel/qom: Fix the doc about
>  OBJECT_DECLARE_SIMPLE_TYPE
> 
> On Wed, 14 May 2025, Zhao Liu wrote:
> > On Wed, May 14, 2025 at 02:06:14PM +0200, BALATON Zoltan wrote:
> > > Date: Wed, 14 May 2025 14:06:14 +0200
> > > From: BALATON Zoltan <balaton@eik.bme.hu>
> > > Subject: Re: [PATCH 2/9] docs/devel/qom: Fix the doc about
> > >  OBJECT_DECLARE_SIMPLE_TYPE
> > > 
> > > On Wed, 14 May 2025, Zhao Liu wrote:
> > > > Currently, the expansion example of OBJECT_DECLARE_SIMPLE_TYPE "roughly"
> > > > reflects what OBJECT_DECLARE_TYPE is doing.
> > > > 
> > > > Why "roughly"? Because this line -
> > > > 
> > > > >    G_DEFINE_AUTOPTR_CLEANUP_FUNC(MyDeviceClass, object_unref)
> > > > 
> > > > - is also wrong for OBJECT_DECLARE_TYPE.
> > > > 
> > > > Fix the expansion example of OBJECT_DECLARE_SIMPLE_TYPE, especially
> > > > drop that definition of MyDeviceClass.
> > > > 
> > > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > > Cc: "Daniel P. Berrang?" <berrange@redhat.com>
> > > > Cc: Eduardo Habkost <eduardo@habkost.net>
> > > > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > > > ---
> > > > docs/devel/qom.rst | 11 +----------
> > > > 1 file changed, 1 insertion(+), 10 deletions(-)
> > > > 
> > > > diff --git a/docs/devel/qom.rst b/docs/devel/qom.rst
> > > > index 5870745ba27b..185f4c2f5921 100644
> > > > --- a/docs/devel/qom.rst
> > > > +++ b/docs/devel/qom.rst
> > > > @@ -326,21 +326,12 @@ This is equivalent to the following:
> > > >    :caption: Expansion from declaring a simple type
> > > > 
> > > >    typedef struct MyDevice MyDevice;
> > > > -   typedef struct MyDeviceClass MyDeviceClass;
> > > > 
> > > > -   G_DEFINE_AUTOPTR_CLEANUP_FUNC(MyDeviceClass, object_unref)
> > > > +   G_DEFINE_AUTOPTR_CLEANUP_FUNC(MyDevice, object_unref)
> > > > 
> > > > -   #define MY_DEVICE_GET_CLASS(void *obj) \
> > > > -           OBJECT_GET_CLASS(MyDeviceClass, obj, TYPE_MY_DEVICE)
> > > > -   #define MY_DEVICE_CLASS(void *klass) \
> > > > -           OBJECT_CLASS_CHECK(MyDeviceClass, klass, TYPE_MY_DEVICE)
> > > >    #define MY_DEVICE(void *obj)
> > > >            OBJECT_CHECK(MyDevice, obj, TYPE_MY_DEVICE)
> > > > 
> > > > -   struct MyDeviceClass {
> > > > -       DeviceClass parent_class;
> > > > -   };
> > > > -
> > > > The 'struct MyDevice' needs to be declared separately.
> > > > If the type requires virtual functions to be declared in the class
> > > > struct, then the alternative OBJECT_DECLARE_TYPE() macro can be
> > > 
> > > Maybe you need to adjust the text here about OBJECT_DECLARE_TYPE here and
> > > show how to define Class sturct?
> > 
> > Then it's not easy to organize the structure in this document, since
> > most of the content is now make "OBJECT_DECLARE_SIMPLE_TYPE" as well as
> > "OBJECT_DEFINE_SIMPLE_TYPE" as examples... I'm a bit unsure, and we can
> > wait and see what others would say.
> > 
> > BTW, I found I missed this sentence:
> > 
> > "(OBJECT_DECLARE_TYPE) This does the same as OBJECT_DECLARE_SIMPLE_TYPE(),
> > but without the 'struct MyDeviceClass' definition."
> > 
> > It should be: This does the same as OBJECT_DECLARE_SIMPLE_TYPE(),
> > but with the class type.
> 
> Yes that's what I meant. If you remove the class example then how will
> readers know how to define that so a new example for that may be needed but
> you can wait for others' opinion too.

The new example deserves another separate patch. I'll think about how to
describe it.

Thanks,
Zhao



