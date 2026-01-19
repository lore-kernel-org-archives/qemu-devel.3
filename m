Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D73D4A5EB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 05:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhhYq-0001Kd-IG; Mon, 19 Jan 2026 00:12:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vhhY9-0001IB-Vb
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 00:11:37 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vhhY7-0000u2-K8
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 00:11:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768799495; x=1800335495;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=F3ZmE+K8iQIwTrl0flL1UXcjJ1vcmWXrTI1rsoIx2JY=;
 b=Th/uvV1kZDj4Ise+FWSbmfJRC6vvCnaVV7r1qWPUav/btPb7bc/sXItw
 zpVvE1PGAkLcw9yNlGVF0MCYuCuSz8nSKFYHNpCzPbci9jl5vLoK8fflj
 4jcGK2BCm+cDzBojbebv0KMTQW3GrczIIKwUiE83ohmlhw6QG6wocZ8jG
 6IHORlTVD2lepvbNDIJ+oFwZbxXhXFStMFJefnbcmbSb4JxtgUdSkXyWy
 wENZkVg0gXLss432ZWsd1THr2CNH+59LhMW+6wpg2A4BtVOTQtBWnJaw1
 0mESWNdr88aRYe29g/GYEEJY2Govj9NcvGQoRkatajPg44fekBSGZb7pR g==;
X-CSE-ConnectionGUID: YbFaYyO8Ri+Lv4f49qGMeA==
X-CSE-MsgGUID: udNarimUTYKhB2PDv03QdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="69918423"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; d="scan'208";a="69918423"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2026 21:11:32 -0800
X-CSE-ConnectionGUID: fy0Ge2oNQBOdXuJXDNq82w==
X-CSE-MsgGUID: zUBkyUFTSBSIUa5xhSSrDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; d="scan'208";a="243340665"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 18 Jan 2026 21:11:31 -0800
Date: Mon, 19 Jan 2026 13:37:01 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v2 1/8] target/i386: Include missing 'svm.h' header in
 'sev.h'
Message-ID: <aW3C/eLwSoqsvOtt@intel.com>
References: <20260117162926.74225-1-philmd@linaro.org>
 <20260117162926.74225-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260117162926.74225-2-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, Jan 17, 2026 at 05:29:19PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Sat, 17 Jan 2026 17:29:19 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v2 1/8] target/i386: Include missing 'svm.h' header in
>  'sev.h'
> X-Mailer: git-send-email 2.52.0
> 
> otarget/i386/cpu.h:2820:#include "svm.h"
> target/i386/sev.h:17:#include "target/i386/svm.h"
> 
> "target/i386/sev.h" uses the vmcb_seg structure type, which
> is defined in "target/i386/svm.h". Current builds succeed
> because the files including "target/i386/sev.h" also include
> "monitor/hmp-target.h", itself including "cpu.h" and finally
> "target/i386/svm.h".
> 
> Include the latter, otherwise removing "cpu.h" from
> "monitor/hmp-target.h" triggers:
> 
>   ../target/i386/sev.h:62:21: error: field has incomplete type 'struct vmcb_seg'
>      62 |     struct vmcb_seg es;
>         |                     ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/i386/sev.h | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


