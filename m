Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE26C9833F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB93j-0007WU-6s; Mon, 28 Sep 2026 06:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xB93e-0007W8-Ih
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:58:06 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xB93c-0006Gq-ML
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:58:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790593085; x=1822129085;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=SLH5z/W/iQ5qIRpWJuQt7ICZhXvLyxdDaSzz8YWjLKA=;
 b=nEJErb04F8b9lcWqoCry6eN7UbMK1zhUJ2t5+QNuaKbUtVlGjcZnt8Xq
 P3OaZoHJQf3GJ+sBePz3dsm5BhVQOOY2DwJ6vTz2nsmlJDGmPe7TSKb8F
 s7bm6MWhfg0lTRVQlaIuEc04HdvE33FAUgeABrqCpksrjj2gkpTkVVZDE
 ilxVcxBsSxS5Y6O7bESiSotGB1VAJofI0JaIqXkctBoHYJ0k9QlyMjfvD
 XqJutbn0Qei3AYlLKWNERA1tXI87RCk6tobBnn9ER/GTxD0cGpf0rGn43
 SIQ7xPwRUvUegaEVfqUpbwsjAsl5vO6up0iGCmoPcEvhXh29sgeoPAZSi w==;
X-CSE-ConnectionGUID: 7f1tlCXyQJml5gMovkUMTg==
X-CSE-MsgGUID: uB42wFRlRemCQHPgJgHPZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="100621573"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="100621573"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 03:58:01 -0700
X-CSE-ConnectionGUID: 5QaO3YktTbShZJNnq7jA5A==
X-CSE-MsgGUID: hpLh3X5pRJiU6WPp/grIdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="302972150"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.112.226.173])
 by fmviesa001.fm.intel.com with ESMTP; 28 Sep 2026 03:57:59 -0700
Date: Mon, 28 Sep 2026 18:57:58 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, chang.seok.bae@intel.com,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 00/17] target/i386/tcg: implement APX
Message-ID: <arpINtziWCbjENeo@intel.com>
References: <20260923173021.317809-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260923173021.317809-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Sep 23, 2026 at 07:30:04PM +0200, Paolo Bonzini wrote:
> Date: Wed, 23 Sep 2026 19:30:04 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH v2 00/17] target/i386/tcg: implement APX
> X-Mailer: git-send-email 2.55.0
> 
> This series implements APX support; the main reason to do this is actually
> to have some initial infrastructure for EVEX, without requiring all the
> complexity of AVX512 but introducing the required changes in the
> emulator.  It also forces some changes that (hopefully) make
> QEMU's decoder align a bit more with what Intel processors actually do.
> 
> This series was tested with Zhao Liu's https://github.com/trueptolemy/apx-test.

About the APX testing, I'd also like to acknowledge Chang¡¯s help :-).
He discussed many things of the APX TCG and offered a lot of insightful
advice.

> The failures were analyzed by AI but the fixes had to be redone anyway.
> Other than for a couple typos, the LLM tended to fix the symptom rather
> than be general, which is exactly the opposite of what I wanted.  For
> example, for the MUL/IMUL/DIV/IDIV assertion failure it wanted to modify
> the decoding tables instead of weakening
> 
>   assert(e->s0 == e->s1);
> 
> to this:
> 
>   assert(e->op1 == X86_TYPE_None || e->s0 == e->s1);
> 
> Changing the decoding tables probably is a more common failure mode, indeed,
> but not the right approach in the context of this series.  Other than that,
> the AGENTS.md from the AI policy discussion worked fine and the LLM was very
> keen on helping me not stray from the righteous path.

Maybe off-topic, for AI usage, I have a qemu prompt for AI use of my
own:

https://github.com/trueptolemy/review-prompts/tree/qemu-v0.1-06-08-2026/qemu

(Such prompts and skills also respect the policies in AGENTS.md.)

From my personal experience, at least it is effective to catch annoying
compatibility issues. I'm also considering "upstreaming" it (which I
think would require some refinement) - i.e., contributing it to the
masoncl/review-prompts project, which should be helpful for any future
qemu-sashiko work.

> The issues detected by apx-test and fixed here are as follows:
> 
> - MUL/IMUL/DIV/IDIV caused an assertion failure
> 
> - INC/DEC did not allow 0x66 as a prefix
> 
> - CMOV/CFCMOV's implicit zero-upper behavior was missing
> 
> - IMUL's use of sextT0 conflicted with the zero-upper modifier (see also
>   patches 1-3)
> 
> - MOVBE's register-to-register implementation was missing (see also
>   patch 4)
> 
> - REX2 incorrectly allowed a 0x0F byte following the prefix (patch 8)
> 
> On top of this, the fix between APX and MPX was not correctly resolved,
> which is now fixed, and PUSH2/POP2 use a single MO_128 access.
> 
> I also included a couple recommendations from Chang Seok Bae.  Thanks!

Tested-by: Zhao Liu <zhao1.liu@intel.com>

Thanks,
Zhao


