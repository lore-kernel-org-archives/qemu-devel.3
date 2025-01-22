Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90FF2C02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 02:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taQCl-00008g-TQ; Tue, 21 Jan 2025 21:10:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taQCj-00008I-U5; Tue, 21 Jan 2025 21:10:53 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taQCg-0002pc-Hq; Tue, 21 Jan 2025 21:10:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737511850; x=1769047850;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=4/AzLGNrxNLRAJkqBpfZhcGqP1V59e8iRbYU5XTvt5M=;
 b=SA43GiTlYqdkPBSMQelr+WuM5MXvnMUXZ1A+RF9mFOdvMMJGCjEOlx3q
 +bbW6H85Ng6mDqEflt9prY8BXjig4+OxrI3J5kwQ1iGh8QjV7SgdNgIEL
 ux83UwI9g1y483VX6R+zAG90zD5S2YEjXoiHnceX2N00Gdc/8VTqiyMUP
 NVgB3IQJrw2pF9ItXRt/PCB5fin0Jm4CNUBHCI6zbo37rogRenX39WYSc
 4VNJ29ImKJ2W7YWOyOLicB0nGm42aikgTnvzOVjd2yaO9S0KeRqmQXFGi
 y3MLMkWkERLUomW5qAT2oZIe4CGkDNaBqWDo2QOX5VIV0uHZw5JPIivAP g==;
X-CSE-ConnectionGUID: eXgM/w3MTuCpyqZx6NVcWg==
X-CSE-MsgGUID: wFCf0BJ5SFSgX1hjisKNDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="49349943"
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; d="scan'208";a="49349943"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 18:10:46 -0800
X-CSE-ConnectionGUID: IRgYKpXcTVGME/y+19uzHQ==
X-CSE-MsgGUID: n9ARKTpFTM6QtNI5iXbx2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; d="scan'208";a="111989650"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 21 Jan 2025 18:10:45 -0800
Date: Wed, 22 Jan 2025 10:30:07 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=C3?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH RESEND 0/2] rust/pl011: miscellaneous cleanups
Message-ID: <Z5BYL9iiw0KS/tp3@intel.com>
References: <20250121140457.84631-1-zhao1.liu@intel.com>
 <9256513c-f42c-4102-b06d-b067d54a3f81@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9256513c-f42c-4102-b06d-b067d54a3f81@redhat.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On Tue, Jan 21, 2025 at 04:58:21PM +0100, Paolo Bonzini wrote:
> Date: Tue, 21 Jan 2025 16:58:21 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH RESEND 0/2] rust/pl011: miscellaneous cleanups
> 
> On 1/21/25 15:04, Zhao Liu wrote:
> > (Resend the series since it was missed on https://lore.kernel.org/qemu-devel/.)
> > 
> > Hi,
> > 
> > This series includes the following cleanups:
> > 
> >   * Patch 1: Make realize() safe to only accept immutable self
> >              reference, which is in prepare to introduce gpio bindings
> >              [1].
> > 
> >   * Patch 2: Clean up `bindings::*` for pl011, which is inspired by
> >              Paolo's comment on HPET [2].
> 
> Yep, me being lazy and not doing what I preach.
>
> Queued---please forgive me for not posting again the series that are on the
> list, just with the "use bindings::foo" conflicts resolved. :)

Thank you! I just happened to see it and clean it up.

> Also, if you have to choose please review only the final qdev/MemoryRegion
> bits; the vmstate is mostly the same and the pl011 one has less impact on
> future code.

No problem, I remember. I'll review all of them soon (I've been catching up
on some debts I owed these days).

Thanks,
Zhao


