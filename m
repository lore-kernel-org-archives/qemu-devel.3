Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1A0C3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 15:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFE3u-0001ek-LW; Wed, 14 May 2025 11:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uFDyR-00006E-9C; Wed, 14 May 2025 11:24:51 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uFDyM-0008B8-IJ; Wed, 14 May 2025 11:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747236282; x=1778772282;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=8hlLEz0kqpHVicvAXJe3vwAsfoWGV3WwpwkMfltOaRI=;
 b=f2geVkBKe/+nxCrjizqaIMBclv4Vw6TU+vtLcRTjR+1Tu6RVM7Axlg+n
 3qZweRXMHEtkJ0ylN5xH7KMrdnc11Dc9qJezkiS0V0ovHl2I7mX5ijv5W
 lREr0cdk1UIuEYedfhadPrLwH2bws7MIZewidgcIAYEwc/cEojMhVFS5/
 BXAZWdE6aXHkK+ZH5urSCvAsNC1ckBMR3A2zu6JAZaAdxtpJXkDQO5DtY
 TbZYpmkcAD6T2/ufChAxWvkh/zZmeVFE6Z2xKepf/2KQKuXCguk/Ok4BO
 jRfnRbLFtTA+HmnAmhY+Ww+5iZuiGB9JboFjqNccFooBdOGt719IcYn4k Q==;
X-CSE-ConnectionGUID: 1DryphlkRpmPtnYKNEZPyg==
X-CSE-MsgGUID: V3a8yt3jTJ2hmZSGI/XESw==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49214148"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; d="scan'208";a="49214148"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 08:24:38 -0700
X-CSE-ConnectionGUID: PiOpA8BtQcyp/ftDLTm7qg==
X-CSE-MsgGUID: 6tCcbs4GTDGJ2bGVVaiZHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; d="scan'208";a="161363041"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 14 May 2025 08:24:36 -0700
Date: Wed, 14 May 2025 23:45:40 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5n77+9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH 2/9] docs/devel/qom: Fix the doc about
 OBJECT_DECLARE_SIMPLE_TYPE
Message-ID: <aCS6pLuiFaeEmeEu@intel.com>
References: <20250514084957.2221975-1-zhao1.liu@intel.com>
 <20250514084957.2221975-3-zhao1.liu@intel.com>
 <c179270c-d636-e20a-2043-38c09b81b4c6@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c179270c-d636-e20a-2043-38c09b81b4c6@eik.bme.hu>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
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

On Wed, May 14, 2025 at 02:06:14PM +0200, BALATON Zoltan wrote:
> Date: Wed, 14 May 2025 14:06:14 +0200
> From: BALATON Zoltan <balaton@eik.bme.hu>
> Subject: Re: [PATCH 2/9] docs/devel/qom: Fix the doc about
>  OBJECT_DECLARE_SIMPLE_TYPE
> 
> On Wed, 14 May 2025, Zhao Liu wrote:
> > Currently, the expansion example of OBJECT_DECLARE_SIMPLE_TYPE "roughly"
> > reflects what OBJECT_DECLARE_TYPE is doing.
> > 
> > Why "roughly"? Because this line -
> > 
> > >    G_DEFINE_AUTOPTR_CLEANUP_FUNC(MyDeviceClass, object_unref)
> > 
> > - is also wrong for OBJECT_DECLARE_TYPE.
> > 
> > Fix the expansion example of OBJECT_DECLARE_SIMPLE_TYPE, especially
> > drop that definition of MyDeviceClass.
> > 
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: "Daniel P. Berrangé" <berrange@redhat.com>
> > Cc: Eduardo Habkost <eduardo@habkost.net>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> > docs/devel/qom.rst | 11 +----------
> > 1 file changed, 1 insertion(+), 10 deletions(-)
> > 
> > diff --git a/docs/devel/qom.rst b/docs/devel/qom.rst
> > index 5870745ba27b..185f4c2f5921 100644
> > --- a/docs/devel/qom.rst
> > +++ b/docs/devel/qom.rst
> > @@ -326,21 +326,12 @@ This is equivalent to the following:
> >    :caption: Expansion from declaring a simple type
> > 
> >    typedef struct MyDevice MyDevice;
> > -   typedef struct MyDeviceClass MyDeviceClass;
> > 
> > -   G_DEFINE_AUTOPTR_CLEANUP_FUNC(MyDeviceClass, object_unref)
> > +   G_DEFINE_AUTOPTR_CLEANUP_FUNC(MyDevice, object_unref)
> > 
> > -   #define MY_DEVICE_GET_CLASS(void *obj) \
> > -           OBJECT_GET_CLASS(MyDeviceClass, obj, TYPE_MY_DEVICE)
> > -   #define MY_DEVICE_CLASS(void *klass) \
> > -           OBJECT_CLASS_CHECK(MyDeviceClass, klass, TYPE_MY_DEVICE)
> >    #define MY_DEVICE(void *obj)
> >            OBJECT_CHECK(MyDevice, obj, TYPE_MY_DEVICE)
> > 
> > -   struct MyDeviceClass {
> > -       DeviceClass parent_class;
> > -   };
> > -
> > The 'struct MyDevice' needs to be declared separately.
> > If the type requires virtual functions to be declared in the class
> > struct, then the alternative OBJECT_DECLARE_TYPE() macro can be
> 
> Maybe you need to adjust the text here about OBJECT_DECLARE_TYPE here and
> show how to define Class sturct?

Then it's not easy to organize the structure in this document, since
most of the content is now make "OBJECT_DECLARE_SIMPLE_TYPE" as well as
"OBJECT_DEFINE_SIMPLE_TYPE" as examples... I'm a bit unsure, and we can
wait and see what others would say.

BTW, I found I missed this sentence:

"(OBJECT_DECLARE_TYPE) This does the same as OBJECT_DECLARE_SIMPLE_TYPE(),
but without the 'struct MyDeviceClass' definition."

It should be: This does the same as OBJECT_DECLARE_SIMPLE_TYPE(),
but with the class type.

Thanks,
Zhao


