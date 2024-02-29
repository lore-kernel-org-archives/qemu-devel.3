Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2A7C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 15:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfiTc-0000xO-R9; Thu, 29 Feb 2024 10:37:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfiTH-0000de-TZ; Thu, 29 Feb 2024 10:37:21 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfiTB-00087d-Vi; Thu, 29 Feb 2024 10:37:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709221034; x=1740757034;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=7oQtxLmsGiklD3zWK+W5/gyldmkxcfqBdD2zMRlr9xg=;
 b=LkF84l41n2mB2J3mdbuNFmWJP6sG1QLIPPE3rCCbHagJZemLnPIIQUUu
 0f1fn8cOXWWJeTHri5RJrVkkf87LgL2/Lh9cWiJ6k+4pYMAYrM6UmOrXy
 9kzp0Lb3sUD+Mme6CN8TFzJIe5ESdJevatlEFxWf2lbSMFbIK0pbZwTRV
 IxgKYF03j+IcZ/ZfmPuc8ky03idva/Ey/zBuaJtEb8/cpZCBouEhhyh48
 LzeqJY7cts/tSPkCHdCPcsJKUjy1VoBs5BXOX4mQuunsUdc4fzg0XOIOP
 06Gp61/1ymJqQC6BlvlVUBQGUniscnHYbtx7LSxGh6nuw/8C/e+yVDSlt A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3577466"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3577466"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Feb 2024 07:37:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7809877"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 29 Feb 2024 07:37:09 -0800
Date: Thu, 29 Feb 2024 23:50:52 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Michael Roth <michael.roth@amd.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 01/16] error: Add error_vprepend() in comment of
 ERRP_GUARD() rules
Message-ID: <ZeCn3Lb96Llcx0nU@intel.com>
References: <20240228163723.1775791-1-zhao1.liu@linux.intel.com>
 <20240228163723.1775791-2-zhao1.liu@linux.intel.com>
 <87jzmnuybm.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzmnuybm.fsf@pond.sub.org>
Received-SPF: none client-ip=198.175.65.20;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H2=-0.001,
 SORTED_RECIPS=2.499, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

> >   * Without ERRP_GUARD(), use of the @errp parameter is restricted:
> >   * - It must not be dereferenced, because it may be null.
> > - * - It should not be passed to error_prepend() or
> > + * - It should not be passed to error_prepend(), error_vprepend() or
> >   *   error_append_hint(), because that doesn't work with &error_fatal.
> >   * ERRP_GUARD() lifts these restrictions.
> >   *
> 
> Good catch!
> 
> I'd like a comma after error_vprepend().
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks! I'll.

Regards,
Zhao


