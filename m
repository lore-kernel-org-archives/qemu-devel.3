Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D509C3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 15:12:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFDm4-0004xA-HP; Wed, 14 May 2025 11:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uFDlQ-0004cG-8P; Wed, 14 May 2025 11:11:23 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uFDlO-0005TK-5g; Wed, 14 May 2025 11:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747235478; x=1778771478;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=I05W1ZE/nTXXVz0FkdMGTQwfWPAC+nw8zX0NsWAisEE=;
 b=HrrcVeckwxn6N9iTM6FACKKWfvTrZsJBa/aFWIDyc8dUvqIIBlR6R6jV
 inWS9n0y0KllYrrCRd6XulFFQOuOFhj/Ml/UwKGahVRW2kfbGk+pLYEu6
 m0oyON06gGcUKUqYpnSL+uvoYAlX7cUh50O8rsAYkUPzMdzgqY3AXgaFH
 ZCZ4Ao6s2Is1MCLM2AVgq29bGXdx8g8FF/KRO82LIZ9cOP+J+wVv6uYLM
 ErUchESfIhYwixLQ0doI5GbJFjWnwTlGerOL/53qrLOHS2TETcDaGwwwz
 /cZFFZDf1RTujCO+NNvkTNTV10/L+UlBQ0Ar2IyWJ3nS5TPsf0LSyiSqy w==;
X-CSE-ConnectionGUID: jyGdaJroRo2pznFJ96Z/nA==
X-CSE-MsgGUID: D/UQxs3tTLG5At9lboZlyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49072301"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; d="scan'208";a="49072301"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 08:11:15 -0700
X-CSE-ConnectionGUID: 3nHdIm/bQIyPsS6sFXziTA==
X-CSE-MsgGUID: Y7XjlgItRX+BbUMEoXSOoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; d="scan'208";a="142938283"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 14 May 2025 08:11:13 -0700
Date: Wed, 14 May 2025 23:32:17 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5n77+9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH 1/9] qom/object: Improve the doc of macros related with
 simple type
Message-ID: <aCS3gS3+qdxZof75@intel.com>
References: <20250514084957.2221975-1-zhao1.liu@intel.com>
 <20250514084957.2221975-2-zhao1.liu@intel.com>
 <e213c4bf-1b26-f1c3-c3ed-10c2adff4a5d@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e213c4bf-1b26-f1c3-c3ed-10c2adff4a5d@eik.bme.hu>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
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

Hi BALATON,

On Wed, May 14, 2025 at 02:02:48PM +0200, BALATON Zoltan wrote:
> Date: Wed, 14 May 2025 14:02:48 +0200
> From: BALATON Zoltan <balaton@eik.bme.hu>
> Subject: Re: [PATCH 1/9] qom/object: Improve the doc of macros related with
>  simple type
> 
> On Wed, 14 May 2025, Zhao Liu wrote:
> > There're 2 changes:
> > - For OBJECT_DECLARE_SIMPLE_TYPE:
> > 
> >   Since a clase may not only has virtual method, but also field, thus
> 
> class may not only have virtual methods but also fields, clarify when class
> is not needed

Thanks for the polish! It sounds better.

> >   mention when class is not needed for either, then there is no need
> >   to have the class.
> > 
> > - For OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES:
> > 
> >   And the words like OBJECT_DEFINE_SIMPLE_TYPE about when the type is
> >   declared by OBJECT_DECLARE_SIMPLE_TYPE, then user should consider
> >   to define the type via OBJECT_DEFINE_SIMPLE_TYPE or
> >   OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES.
> > 
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: "Daniel P. Berrang?" <berrange@redhat.com>
> > Cc: Eduardo Habkost <eduardo@habkost.net>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> > include/qom/object.h | 5 +++--
> > 1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/qom/object.h b/include/qom/object.h
> > index 1d5b03372429..14f84ae454d3 100644
> > --- a/include/qom/object.h
> > +++ b/include/qom/object.h
> > @@ -249,7 +249,7 @@ struct Object
> >  * declared.
> >  *
> >  * This macro should be used unless the class struct needs to have
> > - * virtual methods declared.
> > + * virtual methods or fields declared.
> >  */
> > #define OBJECT_DECLARE_SIMPLE_TYPE(InstanceType, MODULE_OBJ_NAME) \
> >     typedef struct InstanceType InstanceType; \
> > @@ -402,7 +402,8 @@ struct Object
> >  *
> >  * This is a variant of OBJECT_DEFINE_TYPE_EXTENDED, which is suitable for
> >  * the case of a non-abstract type, with interfaces, and with no requirement
> > - * for a class struct.
> > + * for a class struct. If you declared your type with OBJECT_DECLARE_SIMPLE_TYPE
> > + * then this is probably the right choice for defining it.
> 
> Is "probably" correct here? Is it a must or can still use other defining
> macros?

Yes, because there's another choice: OBJECT_DEFINE_SIMPLE_TYPE.

> If correct maybe saying "this might be the right choice" is simpler.

:-) I copied this sentence from the documentation of
OBJECT_DEFINE_SIMPLE_TYPE. The difference between these 2 macros is
OBJECT_DEFINE_SIMPLE_TYPE doesn't support interface.

So I'd like to keep this sentence, consistent with the description of
OBJECT_DEFINE_SIMPLE_TYPE.

Thanks,
Zhao


