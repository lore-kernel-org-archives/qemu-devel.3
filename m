Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C56D74971
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 09:39:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWWwh-0003Yl-9N; Fri, 19 Dec 2025 04:38:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vWWwf-0003YH-FU; Fri, 19 Dec 2025 04:38:45 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vWWwd-0002Xp-7o; Fri, 19 Dec 2025 04:38:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766137123; x=1797673123;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=KVFQ0A6mbzNkl+wieuvJgQdu1PktaJ9dx70U0/Upqm4=;
 b=fHeyzLRfat5B2JLv8pqQ4LK44Nu8zewX0VtsEwY3gul+Ou+a1BoQDoWZ
 KWR4J6VWlcuWZz4zwTshadbh4ztxbATkdsC1bLBVHs1dJNzS/sB1aUV4D
 bhqb6AZ5mllWUKPdSxdVGyDdM9n6kCTL2b/7N0ZJfpBTfr/h4Q9HIMNw0
 OdGVBlNME0YiqGCtrsfbM4AFeD/fzuS5udmNfwpGQE7f9HF5hetJMJ3yV
 DtAy+iBYW7nTZGmvJQyvRGw2RLdpBnPBnfP7il6abE9vwPIJjvnb8Blqq
 YUJH09MhpSZMMWKDOwJx4JKq099g3WP6audkh1SReMkp9GCSbmrf7eFl8 A==;
X-CSE-ConnectionGUID: OZXetpTDRJq15fLJuRCfkA==
X-CSE-MsgGUID: G/lWIUSNRHq2aapsWahV6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="79217975"
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; d="scan'208";a="79217975"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2025 01:38:40 -0800
X-CSE-ConnectionGUID: I7xDcwuhSgOyqV8oCyor1Q==
X-CSE-MsgGUID: YS2rNL8qTZOYyK5coe2Xuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; d="scan'208";a="198832686"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 19 Dec 2025 01:38:37 -0800
Date: Fri, 19 Dec 2025 18:03:27 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>
Subject: Re: [PATCH-for-11.0 v6 08/13] hw/sparc64/sun4u: Use
 fw_cfg_init_io_nodma()
Message-ID: <aUUi7zLIrFnaZY5h@intel.com>
References: <20251203060942.57851-1-philmd@linaro.org>
 <20251203060942.57851-9-philmd@linaro.org>
 <aTBccn2LIv7puGzR@intel.com>
 <05f92a77-7587-4441-a252-01e4705a6892@linaro.org>
 <c03820b8-7745-4b8e-8e69-a37c872257f8@ilande.co.uk>
 <aUPAysAYqTPAfgzD@intel.com>
 <83c9ed5a-8b1b-4b80-91f3-8690b2c64019@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83c9ed5a-8b1b-4b80-91f3-8690b2c64019@ilande.co.uk>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
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

> > > The reason that the fw_cfg device lives under ebus on sun4u is because the
> > > ebus device is effectively a PCI-ISA bridge, and the fw_cfg port is mapped
> > > into I/O address space along with other ISA devices. I'm not sure that
> > > setting the parent to the machine is the right thing to do here.
> > 
> > Thanks Philippe and Mark, IIUC, ebus doesn't have the hotplug use case,
> > so it lives long enough like the sun4u/v machine, therefore replacing
> > the parent object "ebus" with machine is safe.
> 
> It's safe, but it still doesn't make sense for sun4u/v because there is no
> machine-level I/O address space as per x86. It really does exist as a
> separate legacy bus under a PCI bridge.

I tend to agree with Philippe's perspective - since it's per-Guest,
setting the parent as machine seems appropriate.

> That's correct, ebus does not support hotplug.
> 
> > Adding a "parent" argument to the generic interface fw_cfg_init_io_nodma()
> > doesn't seem necessary at the moment, since using the default machine as
> > parent seems enough to meet all current needs in QEMU.
> > 
> > What do you think?
> 
> My preference would be add to add the parent argument as it's easy to do,
> and doesn't attempt to enforce x86-type constraints on other architectures.

I think it's not a x86-specific issue. The parent parameter's role is
lifecycle management - if we allowed custom parents, we'd have to
account for various complications that could result from early parent
destruction, so it's not much easy IMO.

Thanks,
Zhao


