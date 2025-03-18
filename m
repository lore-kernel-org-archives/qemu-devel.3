Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E32C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 02:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuMa1-0002Y2-Jl; Mon, 17 Mar 2025 22:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuMZw-0002XQ-F4; Mon, 17 Mar 2025 22:21:16 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuMZu-0003VA-5y; Mon, 17 Mar 2025 22:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742264474; x=1773800474;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=8lY3VflEeQ3vkSLfLaF4mdXmPsUnhwLmjtVsXtyGlus=;
 b=W4w4uF8x2yZRkSos0wOJ8my/BtoqA4V1crDjII+BrYXu7NPETBrrIKm8
 k45OiKbZUerQPX/RTKLoqhy72QKyMwNKOPI6Mjf9Y351fA6U1WJtzPzj8
 Tm9Ayaaajz+jtkYWtypGmNrJcffDCldCHs1JuxaT+kszesY2CJBu6q0Qj
 PwqIbmsPGUKt2KB62sC406+eFQVIC0YnlArWZ4Kg/OsttUgGfXONldVWT
 btMDPsPXEU1gmz6qPdUNgTblcjigVbBYCAWOuzX21ymnzCbFRvfFZStMh
 /QIZkc1yQsoQ36RNQYh8wPF1dIfeuaEkWCu+LGyZPCsSXH5JMWzcKYfET A==;
X-CSE-ConnectionGUID: cfl1JxfCTtiw+bs5StnctQ==
X-CSE-MsgGUID: hAImenXMQ2aODgPT6x2bwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43487402"
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; d="scan'208";a="43487402"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2025 19:21:10 -0700
X-CSE-ConnectionGUID: O3cjkuOVQbWqlyzpjBt8sg==
X-CSE-MsgGUID: 6D6rCznNQq6kp1gj8Soswg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; d="scan'208";a="145290354"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 17 Mar 2025 19:21:09 -0700
Date: Tue, 18 Mar 2025 10:41:22 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 03/17] rust/vmstate: Add a prefix separator ", " for the
 array field in vmstate macros
Message-ID: <Z9jdUuqlWsv0CLfj@intel.com>
References: <20250317151236.536673-1-zhao1.liu@intel.com>
 <20250317151236.536673-4-zhao1.liu@intel.com>
 <CABgObfYrdpkTGFfDKFGK7zkHJVW5Tn2q=tXw6d97m4P_3ZNdrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfYrdpkTGFfDKFGK7zkHJVW5Tn2q=tXw6d97m4P_3ZNdrA@mail.gmail.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
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

On Mon, Mar 17, 2025 at 05:37:06PM +0100, Paolo Bonzini wrote:
> Date: Mon, 17 Mar 2025 17:37:06 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH 03/17] rust/vmstate: Add a prefix separator ", " for
>  the array field in vmstate macros
> 
> On Mon, Mar 17, 2025 at 3:52 PM Zhao Liu <zhao1.liu@intel.com> wrote:
> >
> > The fields are separated by ",", so it's necessary to add ", " in array
> > field to avoid matching failure.
> 
> This is not a field though, the only (intended) fields are name and
> field. It's meant to mimic the slice since &a[0..n].
> 

Oops, I misunderstood the format...yes, something like

vmstate_struct!(HPETState, timers[0 .. num_timers], VMSTATE_HPET_TIMER, BqlRefCell<HPETTimer>)

can work!

I'll drop this patch and refresh the unit test in v2.

Thanks,
Zhao


