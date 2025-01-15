Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B703C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 13:49:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY3lE-0004sk-L7; Wed, 15 Jan 2025 08:48:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tY3l8-0004rQ-3A
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 08:48:38 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tY3l5-0007YF-Am
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 08:48:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736948916; x=1768484916;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=AFrabdmpmcSy7/EM8FjAcZaFFEVWeqDV0byUNFgvGi0=;
 b=PylmOahDABp8n25iMx+7MKZ9qGe8PFt2y4hGO3en97Pvr9ULkgK0SXoT
 pA5cCNoyHKf6xjRFFkf+ZsKs68swzRzRByO2H8zf+m8sfhLP+WvRVV9p8
 hROdjnlj04iJPu86GoYXi2AgRknaBJUMBANK1wlhOB+mcsQKKmFFycIJZ
 kzNhZMB7KSl8orjwabLb/YiSwdJe9Dx4rriqQAO8A+4NYjvvwWqkym/EA
 ClObTRX63Z//6H6fT1bu35jTtc0dkAQlpxYnBXl11Ar2EFFDKjT+TPf8n
 voKcRjOsedYjnlLKtrI0EVng8nWxUfAYnINX7XHEwkrvwsyoEuU+dL3Vs w==;
X-CSE-ConnectionGUID: Pev8/sUBQZ+otpTIXkAR3Q==
X-CSE-MsgGUID: dggnEU0ZSOOD8NWWS25Sfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="48286909"
X-IronPort-AV: E=Sophos;i="6.13,206,1732608000"; d="scan'208";a="48286909"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2025 05:48:33 -0800
X-CSE-ConnectionGUID: sc7LgFwaQyyj6qHSi2tdLQ==
X-CSE-MsgGUID: aWcPhB69TJmclWv0wI/8qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="105620309"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 15 Jan 2025 05:48:30 -0800
Date: Wed, 15 Jan 2025 22:07:22 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PULL 04/49] hw: Add QOM parentship relation with CPUs
Message-ID: <Z4fBGl1YxFuhNQFi@intel.com>
References: <20250112221726.30206-1-philmd@linaro.org>
 <20250112221726.30206-5-philmd@linaro.org>
 <20250113132832.049f651a@imammedo.users.ipa.redhat.com>
 <6f9225ad-edc6-4fe0-b0e6-8a93e7f50102@linaro.org>
 <20250114111829.2f577596@imammedo.users.ipa.redhat.com>
 <Z4Z25p0YvBEtV2/Z@intel.com>
 <20250115141333.005ab3eb@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115141333.005ab3eb@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

> > I remember that this was your idea all along, and I'm not sure if you're
> > also referring to my previous patches about hybrid topology :-), which I'll
> 
> I'm sorry, I've should've reviewed it long time ago.
> But it got lost in from my review queue, can you give me a pointer
> to the latest you've posted, please? 

You are very kind, no need sorry :-). I have also been inspired by many
of your previous ideas (although my work may not fully meet your
expectations yet). Here are the links:

[1]: qom-topo series, which tries to abstract every topology levels as
     devices and build a topology tree:
     https://lore.kernel.org/qemu-devel/20240919015533.766754-1-zhao1.liu@intel.com/
[2]: hybird-topo series, based on [1], which allows i386 to customize
     topology tree:
     https://lore.kernel.org/qemu-devel/20240919061128.769139-1-zhao1.liu@intel.com/

Thanks,
Zhao


