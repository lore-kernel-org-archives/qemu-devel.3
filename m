Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8598AC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 13:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFYpG-0004RL-5o; Thu, 15 May 2025 09:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uFYpE-0004Qt-6G; Thu, 15 May 2025 09:40:40 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uFYp9-00060F-A7; Thu, 15 May 2025 09:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747316435; x=1778852435;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=t/dBJRztTq4O8xEEobmmrrFdz5C0wJIG2Qexj3Seeto=;
 b=Lo12hO7LtbzvJj0fTTjXDk1YrZ6Qh6Xpq6IMnGjS+sf4z4L0FlRJatea
 maUoPxfUyfRAPysu043vX+fykEHHH85rZkCImOnB77PkJ10BY0EaBs6+h
 upCgcuDVg8THUzoKnMQpS+hyaKVdF2BNWGnH69ebCpBT2zNOea9lLmSVZ
 xlyjj9cH0Tbt7zogYggPkDTPQ55h/2pRJ2RmFCFSHZfRLKWLn/uzX4f4X
 i8hdQMIFBs/QHtbwMV17A3s1umHx1iYAXrwpP+akIDy5L2l58jqldbWF8
 e7jb3fTQnfX11UUJRY+mS+ufEQ9hCVbcFesZra+qGtEsNKFYEq72/Tzzu Q==;
X-CSE-ConnectionGUID: jujWPTz9TI6Ygo9gHl18vw==
X-CSE-MsgGUID: WRYjJYACRpayTnMIzp53Fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="48370717"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="48370717"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 06:40:31 -0700
X-CSE-ConnectionGUID: +gU1JbZYQd6M8WXm8bGWsQ==
X-CSE-MsgGUID: DaNzT0bDTauGgbxs3/bZxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="169309570"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 15 May 2025 06:40:29 -0700
Date: Thu, 15 May 2025 22:01:34 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5n77+9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH 1/9] qom/object: Improve the doc of macros related with
 simple type
Message-ID: <aCXzvi3C0PRwWiF6@intel.com>
References: <20250514084957.2221975-1-zhao1.liu@intel.com>
 <20250514084957.2221975-2-zhao1.liu@intel.com>
 <e213c4bf-1b26-f1c3-c3ed-10c2adff4a5d@eik.bme.hu>
 <aCS3gS3+qdxZof75@intel.com>
 <e034853a-beaf-f5d8-4eb3-069538b012c6@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e034853a-beaf-f5d8-4eb3-069538b012c6@eik.bme.hu>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
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

On Wed, May 14, 2025 at 06:13:33PM +0200, BALATON Zoltan wrote:
> Date: Wed, 14 May 2025 18:13:33 +0200
> From: BALATON Zoltan <balaton@eik.bme.hu>
> Subject: Re: [PATCH 1/9] qom/object: Improve the doc of macros related with
>  simple type
> 
> On Wed, 14 May 2025, Zhao Liu wrote:
> > Hi BALATON,
> 
> In case you did not know:
> https://en.wikipedia.org/wiki/Name_order#Hungary
> 
> > On Wed, May 14, 2025 at 02:02:48PM +0200, BALATON Zoltan wrote:
> > > Date: Wed, 14 May 2025 14:02:48 +0200
> > > From: BALATON Zoltan <balaton@eik.bme.hu>
> > > Subject: Re: [PATCH 1/9] qom/object: Improve the doc of macros related with
> > >  simple type
> > > 
> > > On Wed, 14 May 2025, Zhao Liu wrote:
> > > > There're 2 changes:
> > > > - For OBJECT_DECLARE_SIMPLE_TYPE:
> > > > 
> > > >   Since a clase may not only has virtual method, but also field, thus
> > > 
> > > class may not only have virtual methods but also fields, clarify when class
> > > is not needed
> > 
> > Thanks for the polish! It sounds better.
> 
> It's also grammatically more correct. But I'm not a native English speaker
> so may still be wrong.

Neither am I. But I like this advice.

> > > >   mention when class is not needed for either, then there is no need
> > > >   to have the class.
> > > > 
> > > > - For OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES:
> > > > 
> > > >   And the words like OBJECT_DEFINE_SIMPLE_TYPE about when the type is
> > > >   declared by OBJECT_DECLARE_SIMPLE_TYPE, then user should consider
> > > >   to define the type via OBJECT_DEFINE_SIMPLE_TYPE or
> > > >   OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES.
> > > > 
> > > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > > Cc: "Daniel P. Berrang?" <berrange@redhat.com>
> > > > Cc: Eduardo Habkost <eduardo@habkost.net>
> > > > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > > > ---
> > > > include/qom/object.h | 5 +++--
> > > > 1 file changed, 3 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/include/qom/object.h b/include/qom/object.h
> > > > index 1d5b03372429..14f84ae454d3 100644
> > > > --- a/include/qom/object.h
> > > > +++ b/include/qom/object.h
> > > > @@ -249,7 +249,7 @@ struct Object
> > > >  * declared.
> > > >  *
> > > >  * This macro should be used unless the class struct needs to have
> > > > - * virtual methods declared.
> > > > + * virtual methods or fields declared.
> > > >  */
> > > > #define OBJECT_DECLARE_SIMPLE_TYPE(InstanceType, MODULE_OBJ_NAME) \
> > > >     typedef struct InstanceType InstanceType; \
> > > > @@ -402,7 +402,8 @@ struct Object
> > > >  *
> > > >  * This is a variant of OBJECT_DEFINE_TYPE_EXTENDED, which is suitable for
> > > >  * the case of a non-abstract type, with interfaces, and with no requirement
> > > > - * for a class struct.
> > > > + * for a class struct. If you declared your type with OBJECT_DECLARE_SIMPLE_TYPE
> > > > + * then this is probably the right choice for defining it.
> > > 
> > > Is "probably" correct here? Is it a must or can still use other defining
> > > macros?
> > 
> > Yes, because there's another choice: OBJECT_DEFINE_SIMPLE_TYPE.
> > 
> > > If correct maybe saying "this might be the right choice" is simpler.
> > 
> > :-) I copied this sentence from the documentation of
> > OBJECT_DEFINE_SIMPLE_TYPE. The difference between these 2 macros is
> > OBJECT_DEFINE_SIMPLE_TYPE doesn't support interface.
> > 
> > So I'd like to keep this sentence, consistent with the description of
> > OBJECT_DEFINE_SIMPLE_TYPE.
> 
> OK in that case no problem to keep consistency. It still sounds a bit
> unspecific for documentation to me because it leaves the question open of
> what is it when it's not the right choice but if this is already there then
> that's another unrelated question.

I get your point.

Before this sentance, the doc said "This is a variant of
OBJECT_DEFINE_TYPE_EXTENDED, which is suitable for the common case of a
non-abstract type, without any interfaces, and with no requirement for a
class struct."

IMO it's the pretty accurate description about in which case this macro
is used. This description could clarify your question :-).

Thanks,
Zhao


