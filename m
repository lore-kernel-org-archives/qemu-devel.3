Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14002C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 09:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubFVl-00020b-Sf; Mon, 14 Jul 2025 05:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ubF4Q-0002fV-19
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 05:02:01 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ubF4J-0006MZ-G0
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 05:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752483712; x=1784019712;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=99hMgsn9Zr5FPJ+0ltOVKRkMbioyCxp4W0dXfSeNFGg=;
 b=Io0QUDRo8PPjkl0az0O69dYE5uvYgRg38TYCDZLG744nfmIm9bdzfbB3
 NkPoBAZZ2IYHkWHr8anc1gMzT9FUGe81Bj/NsN//NLBMEvpzHUVPuL5+Q
 /9JHlhtQvi0KPWmoPnTE4szoDba8lzJytQ811LdIIdhfskL+Fe3LBgB7k
 479E+CCnOshBT7CV1jq6mzjDSAIk5hoUdnTkaHNawtYguB/nNxMpwccom
 4KgPovd0KQPAXu/8cyvDHXQwHofmVjEXuIdF5Wz3xiR4un+UBOH8NcIVG
 bYNos99Kdn7RoXE+PrzkqVGkfaXejr2eA8LMzD6YbKgGYkp2kbTFyt9+k w==;
X-CSE-ConnectionGUID: kEd99RLzSoiehXjeoBAzVw==
X-CSE-MsgGUID: cLTILOZSTsafIPRr2SsagA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="58438155"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="58438155"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 02:01:46 -0700
X-CSE-ConnectionGUID: 5h7PTHTuSJaBKuO11dMocA==
X-CSE-MsgGUID: sa+f3xMXSOSQaWROpKxtFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="194083720"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 14 Jul 2025 02:01:44 -0700
Date: Mon, 14 Jul 2025 17:23:13 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Ewan Hai <ewanhai-oc@zhaoxin.com>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 qemu-devel@nongnu.org, Tao Su <tao1.su@linux.intel.com>
Subject: Re: [PATCH v2 2/7] i386/cpu: Mark CPUID 0x80000008 ECX bits[0:7] &
 [12:15] as reserved for Intel/Zhaoxin
Message-ID: <aHTMgdePYYSYzsUJ@intel.com>
References: <20250714080859.1960104-1-zhao1.liu@intel.com>
 <20250714080859.1960104-3-zhao1.liu@intel.com>
 <42817b7d-445f-4940-9070-e3c939a6e90f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42817b7d-445f-4940-9070-e3c939a6e90f@intel.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
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

> >           if (threads_per_pkg > 1) {
> >               /*
> > -             * Bits 15:12 is "The number of bits in the initial
> > -             * Core::X86::Apic::ApicId[ApicId] value that indicate
> > -             * thread ID within a package".
> > -             * Bits 7:0 is "The number of threads in the package is NC+1"
> > +             * Don't emulate Bits [7:0] & Bits [15:12] for Intel/Zhaoxin, since
> > +             * they're using 0x1f leaf.
> >                */
> > -            *ecx = (apicid_pkg_offset(topo_info) << 12) |
> > -                   (threads_per_pkg - 1);
> > +            if (cpu->vendor_cpuid_only_v2 &&
> > +                (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
> > +                    *ecx = 0;
> > +            } else {
> > +                /*
> > +                 * Bits 15:12 is "The number of bits in the initial
> > +                 * Core::X86::Apic::ApicId[ApicId] value that indicate
> > +                 * thread ID within a package".
> > +                 * Bits 7:0 is "The number of threads in the package is NC+1"
> > +                 */
> > +                *ecx = (apicid_pkg_offset(topo_info) << 12) |
> > +                       (threads_per_pkg - 1);
> > +            }
> >           } else {
> >               *ecx = 0;
> >           }
> 
> I prefer below:
> 
> 	if ((cpu->vendor_cpuid_only_v2 &&
> 	    (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) ||
> 	    threads_per_pkg < 2) {
> 		*ecx = 0;
> 	} else {
> 		...
> 	}

Yes, this works, but I would like to keep the vendor-related checks
separate from other logic - to avoid mixing them together.

Then it makes the code logic clearer and makes it easier for future
changes.

Thanks for your review!
Zhao


