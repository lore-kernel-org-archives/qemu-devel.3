Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103B0C2A075
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 08:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcg9O-0003hf-T5; Mon, 05 Jan 2026 03:41:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vcg9M-0003gx-0i
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 03:41:16 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vcg9J-0006K6-CN
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 03:41:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767602473; x=1799138473;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=zzCFUre12J5S1n5MXly8Cz/XMaLl0lsc+PyKLeJKgQo=;
 b=U873SNfdTOPrQ5lZ1qBJ5WAywUdHgyr9k1+1XC6UmLVtkUOnMrW9Q4r2
 vUbLn8WJbyWm4Ii1E80P43YlbtJGe7deJk42/qTO+f1lxSthn3k1m4eoR
 TloBFBJZ8UuprnJLQVkJUfYkXzKwi8zvRJnK9crijG+4QJbWAPYM0bvFi
 1roXF1KAuomWfMLPcPLJb/11iUZGL+LQRMTWdl6hEPVXEzzelqR0frLoR
 5IDbRgrZHmexxczQNfctzF2jNCJISQ/PoSYSNf2LztryNwSi8dUxRGNan
 nFSAtSBD6nTO+FYl12HN/jJ2jnw34c/cb4aaeW/WSlCZRJ5LJyGg8c/2+ A==;
X-CSE-ConnectionGUID: FVU2IqlYQXKX02DONRVjYw==
X-CSE-MsgGUID: Ix6oWurtRNKN7fqlGPKLmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11661"; a="68706649"
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; d="scan'208";a="68706649"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 00:41:10 -0800
X-CSE-ConnectionGUID: 3fGi00+RQSGV1gt+rZCixQ==
X-CSE-MsgGUID: R+Y6nJxgRQOxiSqIKv4iBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; d="scan'208";a="206894046"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 05 Jan 2026 00:41:07 -0800
Date: Mon, 5 Jan 2026 17:06:31 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 devel@lists.libvirt.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [RFC 02/10] qom: Add basic object property deprecation hint
 support
Message-ID: <aVt/F6qjR+UMfXrO@intel.com>
References: <20251202170502.3228625-1-zhao1.liu@intel.com>
 <20251202170502.3228625-3-zhao1.liu@intel.com>
 <20260102130601.0697deeb@imammedo-mac>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260102130601.0697deeb@imammedo-mac>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jan 02, 2026 at 01:06:01PM +0100, Igor Mammedov wrote:
> Date: Fri, 2 Jan 2026 13:06:01 +0100
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: Re: [RFC 02/10] qom: Add basic object property deprecation hint
>  support
> X-Mailer: Claws Mail 3.11.1-67-g0d58c6-dirty (GTK+ 2.24.21;
>  x86_64-apple-darwin14.0.0)
> 
> On Wed,  3 Dec 2025 01:04:54 +0800
> Zhao Liu <zhao1.liu@intel.com> wrote:
> 
> > Now the common (but a bit fragmented) way to mark a property deprecated
> > is to add the warning in its accssors.
> > 
> > But this is pretty inconvenient for such qdev properties, which are
> > defined via DEFINE_PROP_* macros in the Property array. For qdev
> > properties, their accessors are provided by pre-defined PropertyInfo, so
> > that it's possible to modify PropertyInfo for a single "deprecated"
> > property.
> > 
> > Then it's necessary to introduce property flags to mark some properties
> > as deprecated, and to check the property flags when set the property,
> > thereby to print a deprecation warning.
> > 
> > This not only benefits traditional qdev properties but also helps the
> > deprecation of generic objects.
> > 
> > Note, internal attempt (except the compat case) should not trigger the
> > deprecation warning but external user should see the deprecation
> > information. Whether to perform deprecation checks based on property
> > flags is controlled by the newly added "check" argument in
> > object_property_try_add_full().
> 
> I'd split deprecation warning out for this patch,
> i.e. make this one "add per object instance flags",
> and take care of deprecation stuff on top,

Yeah, will do.

> Also, API likely would need set/get/clear calls to operate on object flags.

I see, for dynamic flags ("user set" - you mentioned), these APIs are
necessary. Will add something like object_property_[set|get|clear]_flags.

> > In subsequent work, the "check" option will be enabled for specific
> > external property setting paths.
> > 
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >  include/qom/object.h | 72 ++++++++++++++++++++++++++++++++++++++++++++
> >  qom/object.c         | 72 +++++++++++++++++++++++++++++++++++---------
> >  2 files changed, 130 insertions(+), 14 deletions(-)
> > 
> > diff --git a/include/qom/object.h b/include/qom/object.h
> > index 3f807a03f5aa..8f4c2f44d835 100644
> > --- a/include/qom/object.h
> > +++ b/include/qom/object.h
> > @@ -86,6 +86,12 @@ typedef void (ObjectPropertyRelease)(Object *obj,
> >   */
> >  typedef void (ObjectPropertyInit)(Object *obj, ObjectProperty *prop);
> >  
> > +typedef enum ObjectPropertyFlags {
> > +    OBJECT_PROPERTY_NO_FLAGS     =                             0,
> > +    OBJECT_PROPERTY_DEPRECATED   =                        1 << 0,
> 
> maybe use BIT() instead of manual shift?

Sure, will do.

> addidtionally given you are going to distinguish external vs internal,
> perhaps add flags 'default' and 'user set',
> I think the both could be used to cleanup cpu flags handling where we rely on
> setting/checking  magic numbers to figure out where value comes from.

Good idea.

I think a "user set" flag is enough. Considerring a property may be set
multiple timers. In object_property_set_full(), we could add the "user
set" flag for external setting and clear that flag for internal setting,
then property's set accessor could know whether the value is from user
or not.

> > +    OBJECT_PROPERTY_FULL_FLAGS   =    OBJECT_PROPERTY_DEPRECATED,
> > +} ObjectPropertyFlags;
> > +
> >  struct ObjectProperty
> >  {
> >      char *name;
> > @@ -98,6 +104,7 @@ struct ObjectProperty
> >      ObjectPropertyInit *init;
> >      void *opaque;
> >      QObject *defval;
> > +    uint8_t flags;
> >  };
> >  
> >  /**
> > @@ -1090,6 +1097,41 @@ ObjectProperty *object_property_try_add(Object *obj, const char *name,
> >                                          ObjectPropertyRelease *release,
> >                                          void *opaque, Error **errp);
> >  
> > +/**
> > + * object_property_try_add_full:
> 
> what's the reason for adding _full flavour over just modifying existing API?

I was previously concerned about making too many changes to other parts,
but after re-checking, directly extending the current object_property_try_add()
is better — there's not too many changes. Thanks for the reminder.

Regards,
Zhao


