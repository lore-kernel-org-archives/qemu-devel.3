Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31C2C2D0CD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 03:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFlL8-0005aM-HX; Thu, 15 May 2025 23:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uFlL7-0005Zm-4g; Thu, 15 May 2025 23:02:25 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uFlL5-0002PJ-9S; Thu, 15 May 2025 23:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747364543; x=1778900543;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=T6a4JpmpVPPBxMlEtCwTWcpYCmTHuhKCQK3n2fiJ2oo=;
 b=f5qMqGLBIPuHdaJR0A1SWJJ1XyKKjNrp+BzI4SI5zTh0WmjagW4Kb8yO
 C2irwzanIrfXeUHq0mr9e2JaE4smQ+02Q2vmm2v7tAUc9gDUPa43jkIF8
 sObNbmNiDwZHlP9PxccwYs8voy1pSXn6ueERZiPISHpE8LPU97HAtb3bf
 5f4kq+HoGg6Et+dXnqCDLeSBXLwQhzLoNRKxJWyz5l8bi/ebzIqVs0qO6
 +ynR0kj63ngrCcnUxXwvcZKkg+NwnT3wJytjEU58ndeGStbbobajMwHkH
 6TRcRGttvuiee9XEZkgD41sFHlsX2hpgUhRz2AYe8bSVTbxq7GM3CG+iJ g==;
X-CSE-ConnectionGUID: xqrHJTeQR8ytyqDciodGAg==
X-CSE-MsgGUID: 63gXb6OERTW+EEyAlPczVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="48579999"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; d="scan'208";a="48579999"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 20:02:20 -0700
X-CSE-ConnectionGUID: BJug3vzhSF6XIdgWu2AGog==
X-CSE-MsgGUID: B76+3srHRlS5nypoDzUhdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; d="scan'208";a="143329249"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 15 May 2025 20:02:16 -0700
Date: Fri, 16 May 2025 11:23:21 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org
Subject: Re: [PATCH 8/9] target/s390x/kvm/pv: Consolidate
 OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
Message-ID: <aCavqdZ/PI461DDe@intel.com>
References: <20250514084957.2221975-1-zhao1.liu@intel.com>
 <20250514084957.2221975-9-zhao1.liu@intel.com>
 <e0146386-ccf4-44ba-b58f-0bb4d3317f89@redhat.com>
 <aCS8aHsF+VAuj01D@intel.com>
 <7dec9c8e-93d6-81f0-b075-e29b8ede44a2@eik.bme.hu>
 <aCXxHEVZb8+ZCW/m@intel.com>
 <c2466a27-8f8a-780d-ff78-491921bb41e5@eik.bme.hu>
 <aCYSTHiXtBsjw510@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aCYSTHiXtBsjw510@redhat.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
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

On Thu, May 15, 2025 at 05:11:56PM +0100, Daniel P. Berrangé wrote:
> Date: Thu, 15 May 2025 17:11:56 +0100
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: Re: [PATCH 8/9] target/s390x/kvm/pv: Consolidate
>  OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
> 
> On Thu, May 15, 2025 at 05:41:40PM +0200, BALATON Zoltan wrote:
> > On Thu, 15 May 2025, Zhao Liu wrote:
> > > On Wed, May 14, 2025 at 06:24:03PM +0200, BALATON Zoltan wrote:
> > > > Date: Wed, 14 May 2025 18:24:03 +0200
> > > > From: BALATON Zoltan <balaton@eik.bme.hu>
> > > > Subject: Re: [PATCH 8/9] target/s390x/kvm/pv: Consolidate
> > > >  OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
> > > > 
> > > > On Wed, 14 May 2025, Zhao Liu wrote:
> > > > > > > +OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(S390PVGuest,
> > > > > > > +                                          s390_pv_guest,
> > > > > > > +                                          S390_PV_GUEST,
> > > > > > > +                                          CONFIDENTIAL_GUEST_SUPPORT,
> > > > > > > +                                          { TYPE_USER_CREATABLE },
> > > > > > > +                                          { NULL })
> > > > > > 
> > > > > > I'll note that existing callers of OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
> > > > > > happily ignore the line limit and put it into a single line.
> > > > > > 
> > > > > > (which ends up looking better IMHO)
> > > > > 
> > > > > Ok, I'll onor the existing conventions (which I'll apply to other
> > > > > patches as well).
> > > > 
> > > > There are two line limits. If something is clearer on one line you could
> > > > exceed the normal 80 chars and put up to 90 chars on one line for which
> > > > checkpatch will issue a warning that can be ignored for these cases. Over 90
> > > > lines checkpatch will give an error and I think you should not ignore that.
> > > 
> > > Thank you. This makes sense!
> > > 
> > > > Maybe try to put as much on one line as possible instead of new line after
> > > > each argument but without exceeding the 80 chars or if the whole line fits
> > > > in 90 chars then use that. Or maybe do not indent second line under ( but
> > > > with 4 spaces then you can fit it in two lines but lines over 90 chars are
> > > > undesirable.
> > > 
> > > HMM, I understand you mean:
> > > 
> > > OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(S390PVGuest, s390_pv_guest,
> > >    S390_PV_GUEST, CONFIDENTIAL_GUEST_SUPPORT, { TYPE_USER_CREATABLE }, { NULL })
> > > 
> > > The second line is 82 chars and now I think this version is better.
> > 
> > Yes and maybe can even fit in 80 chars if using { } instead of { NULL }.
> 
> Personally, once you have to break the line, I would be inclined
> to have *nothing* after the '(' on the first line, and then break
> at the list of interfaces. ie
> 
>  OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(
>     S390PVGuest, s390_pv_guest, S390_PV_GUEST, CONFIDENTIAL_GUEST_SUPPORT,
>     { TYPE_USER_CREATABLE }, { NULL })
>  

This version looks better! Thank you all for your patience.

(How to elegantly break lines is indeed a matter of taste, and I've
improved in this area now with your help :-).)

Regards,
Zhao



