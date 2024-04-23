Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700DDC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 07:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzASX-00085t-Mn; Tue, 23 Apr 2024 03:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1rzASV-00085Z-6B
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 03:20:55 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1rzASS-0002xh-Cs
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 03:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713856852; x=1745392852;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=w3En34WY+2+njY+YveqRr+qSXvtdltl4L33gMsnJIY4=;
 b=Kbj5YPwtcMGHCxjqdmLO1n9StBcM3mDlL0heKaI46or4omAofES8lsL2
 /x+6VZQU+DkEqlAGhgi3QfdBj8KaDghVrvWHcd0dOUXZCT/stzKOfDFEq
 6AibPkGMcs14xUt161crfJB+Um7wu0kiEfwkAwgy6obGDtmOGg/3+nlXT
 oNGMTRNJXrgk9R0/H5twQJ7Gy34AjdUuZwiDvl9i9p7DWWvXL/blrfbds
 30WOeymiBS/ObFCC3XSzMu169kTD5j0OQRpJfWqQRHXjOAtgy+1j1huru
 ZFKZsy4vjn/zwg2jlQFC2V9WjYUFf2i8iI3bZUNtyA5Ver0Npfw5MiPk1 Q==;
X-CSE-ConnectionGUID: J01z+7aLQZ2lPYi3rr3+bQ==
X-CSE-MsgGUID: 5sCWdAagTAyaPQ6i5ZGuyg==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="20576355"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; d="scan'208";a="20576355"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2024 00:20:47 -0700
X-CSE-ConnectionGUID: voe/p7UeRG2FQiinM0H2Cw==
X-CSE-MsgGUID: 6xhywNBPSHeMVph5AdiZzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; d="scan'208";a="28926814"
Received: from leiwang7-mobl.ccr.corp.intel.com (HELO [10.124.225.74])
 ([10.124.225.74])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2024 00:20:47 -0700
Message-ID: <23f16462-d461-4555-9043-56147ece42b1@intel.com>
Date: Tue, 23 Apr 2024 15:20:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Missing features in QEMU SapphireRapid definition
To: Manish Mishra <manish.mishra@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "christopher.r.blevins@intel.com" <christopher.r.blevins@intel.com>,
 "robert.hu@linux.intel.com" <robert.hu@linux.intel.com>
References: <PH0PR02MB7384F448F73756EDE574A306F6092@PH0PR02MB7384.namprd02.prod.outlook.com>
 <PH0PR02MB738400F34A65A61D2D843F44F6112@PH0PR02MB7384.namprd02.prod.outlook.com>
From: "Wang, Lei" <lei4.wang@intel.com>
Content-Language: en-US
In-Reply-To: <PH0PR02MB738400F34A65A61D2D843F44F6112@PH0PR02MB7384.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=lei4.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
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

Hi Manish,

Thanks for the information. It seems those 3 features are missing in the SPR CPU
Model definition, we are currently polishing our new SPR CPU Model version, you
can launch the SPR CPU Model using:

	-cpu SapphireRapids,+cldemote,+movdiri,+movdir64b

as a workaround and sorry for the inconvenience:)

Thanks,
Lei

On 4/23/2024 14:57, Manish Mishra wrote:
> Hi Everyone,
> 
> We see few features like movdiri, movdiri64b, cldemote are present on
> SapphireRapid nodes and are also mentioned as supported in intel manual.  But
> these are missing from the QEMU definition of SapphireRapid CPUs
> https://github.com/qemu/qemu/commit/7eb061b06e97af9a8da7f31b839d78997ae737fc
> <https://github.com/qemu/qemu/commit/7eb061b06e97af9a8da7f31b839d78997ae737fc>.
> There may be other features too missing but we were particularly interested in
> these three. So just wanted to understand if there is any reason for this.  Any
> help on this will be really appreciated. 😊
> 
> Thanks
> 
> Manish Mishra
> 
>  
> 

