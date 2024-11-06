Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B98D44D54
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 13:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8flX-00017J-N1; Wed, 06 Nov 2024 08:08:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t8flW-00015a-HZ
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 08:08:06 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t8flU-00013W-0l
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 08:08:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730898484; x=1762434484;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=qFTE++e9agk+cKjARQTRQjxugCHIpPXaNmBezkd59U0=;
 b=H++P+DmSbRolkjEcm1Mk+jB64X4Kn9vtfzVLlzyzCrilHPrFWvBOnpbe
 4Xx5DI60S+OaTt85EOjsuULhXoEcstzBP35Z/h32Kd6cYCGmzW1YmEr32
 qsE161K7xxpbXysNWXn6HxC8s//YmJww7sUYjTGyo6av+iRXTpir8H5vY
 FbUr93PCx/F+RcEAEi5IsyDZ265DVHftZ0Xs4/YQtU/FKoXerTZKHuXLs
 o4oP6ZJMg/p7B0z9eWIINnuIOcDYfshTofxLi2bulZY8VMbaZCqHF+wAT
 tSi4iVHCuY0bQBoF5kWUBYaH1f6Zh/KWaoypKSuuk/k2eeZQPpDD6FhkI Q==;
X-CSE-ConnectionGUID: 7mMQExyqT8eciOehpmH02w==
X-CSE-MsgGUID: f1iz1L4YQZWvC+drIvbAtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41242361"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="41242361"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2024 05:08:01 -0800
X-CSE-ConnectionGUID: AHt2/mQkTXKN5GufM52T7Q==
X-CSE-MsgGUID: OuvcqgsvRKmbAaUVy40PCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; d="scan'208";a="84634521"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa008.fm.intel.com with ESMTP; 06 Nov 2024 05:08:00 -0800
Date: Wed, 6 Nov 2024 21:25:51 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Steve Sistare <steven.sistare@oracle.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Why the wait for reviews / advice from armbru?
Message-ID: <ZytuX2ANWK5jZ02w@intel.com>
References: <87v7x0o75w.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v7x0o75w.fsf@pond.sub.org>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

On Wed, Nov 06, 2024 at 01:53:15PM +0100, Markus Armbruster wrote:
> Date: Wed, 06 Nov 2024 13:53:15 +0100
> From: Markus Armbruster <armbru@redhat.com>
> Subject: Why the wait for reviews / advice from armbru?
> 
> I've been dealing with a health emergency in the family.  I've had
> serious difficulties focusing, patch review in particular.  I apologize
> for letting you all down.
> 
> I tried to cc: the people who I believe are affected, but the list is
> almost certainly incomplete.
> 
> While this situation persists, maintainers should feel free to merge
> without an ACK from me when I'm too slow to provide it.

Markus, thank you for your mail! I appreciate your review and help.
Don't worry about it and take care. Hope everything gets better soon.

Best Regards,
Zhao


