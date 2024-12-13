Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A12E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 09:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM1YX-0000as-Rg; Fri, 13 Dec 2024 04:01:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tM1YT-0000ad-IB; Fri, 13 Dec 2024 04:01:49 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tM1YQ-0005to-R5; Fri, 13 Dec 2024 04:01:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734080507; x=1765616507;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=b5TxyzI7IAj9wccNYON1ldI9MUnQxLxP4jydcfUFkiw=;
 b=kIplFa2E60w/IPAd3Jkbr3VNXUZ1KpQLj08XvXY7ssaytKKgBX/pbqOC
 VCEieaWImFxpl/hF76N2uR/ZWU0m9TSfynzd5OuRKE78osmqIcESDJpG6
 mMpZSJOdigki0RX2vjvqVW3yMPvyblr0G2W6cz6TkImOVjGh0bPaT8O75
 Y1/iyHtIU7UIeciasGDlfA7u9wmc6+XYmn6Ay02sNAGJVAalNfm149z/5
 iT2oDlVS5O1RbCANF4fUu55PgSBrQClIuC2d2z7Z9aMwLpOA0uzCZ96u5
 P3PiOu+tSawAz7OCoY5iERe7m3iPbwNgmMhqql/17PEArLip5/CIvdF36 g==;
X-CSE-ConnectionGUID: umKSAjIpRtGVesOTfj1f5A==
X-CSE-MsgGUID: Do1vMALoTx23CEstUXhIww==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34431514"
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; d="scan'208";a="34431514"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Dec 2024 01:01:35 -0800
X-CSE-ConnectionGUID: Lbv2BEqnSjOBhBsYJ+93lQ==
X-CSE-MsgGUID: +wAUjzlhQO+oQ05R1GRvtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="96919239"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 13 Dec 2024 01:01:34 -0800
Date: Fri, 13 Dec 2024 17:19:50 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH 19/26] rust: rename qemu-api modules to follow C code a
 bit more
Message-ID: <Z1v8NhJb/xBp/K2D@intel.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-20-pbonzini@redhat.com>
 <Z1qyeThRA8yJMMoM@intel.com>
 <a0bdbf2a-8430-480e-bc56-e8a4875dd577@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0bdbf2a-8430-480e-bc56-e8a4875dd577@redhat.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
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

> > In this commit, this comment is a bit ahead, but I think it's okay.
> > 
> > qom and qdev are both good names. In addition, we can rename the files
> > of PL011 as well. Perhaps device_class.rs could be merged into device.rs
> > (and eventually renamed to pl011.rs). I guess you might be planning to
> > keep it until the cleanup of vmstate and property is done.
> 
> Yeah, I don't have any specific plans but memory_ops will certainly go away.

This depends on MemoryRegionOps binding. I will see how much HPET can do,
and I'm sorry for not being able to review the remaining patches yet in
this week, especially the last two. I will continue next week (my machine
will be powered down until next Monday :( ).

> device_class doesn't do much, but keeping it separate is a reminder for
> things that are still there to be cleaned up.
> 
> As to VMState, there are two parts.  One is the vmstate_description macro,
> probably it has to be replaced with something else to incorporate the
> trampolines for pre_save/post_load/...  I haven't looked at it but it should
> not be a lot of work.
> 
> The second is VMStateFields, 

I found vmstate_array_of_pointer_to_struct missed a `info` field, and I
could submit a patch to fix this nit next week (along with other cleanup
you and other miantainers suggested for HPET).

I'd also like to try apply zeroable to VMStateField to avoid missing any
items...

> for which my idea is to implement a trait on
> types to retrieve a basic VMStateField (for example something like
> vmstate_uint32 would become an implementation of the VMState trait on u32).

This makes sense.

> Then you'd write something like "vmstate_of!(Type,
> field).with_version_id(2)" (i.e. vmstate_of retrieves the basic field and
> fills in the offset, then you apply more changes on top).  But that may take
> a while, and I think it cannot be done without the const_refs_to_static
> feature, which is only stable in 1.83.0.

I also like this idea!

Thanks,
Zhao



