Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14253606A31F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hdZjjHG2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLdWX-0004Zh-FS; Tue, 27 Oct 2026 05:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xLdWU-0004ZE-Sd
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 05:31:14 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xLdWT-00087R-1N
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 05:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793093473; x=1824629473;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=odCGTFm37YaysNY3z3IY2ouIgAawn4q1QTQmWgOTedE=;
 b=hdZjjHG2ow9+pHwRzupAKh6PGQWjflGiAdH9hD9KVulCuwpreAyesxYN
 ZlcOrjoMaLe7OCP33bMVTGrXgKIQk0hJxCOZ0JLWgoW1PnWgn9O5blT2z
 r4dO5OXs/Mf8Duz568YtY9Bv0vUsiLK9hu41+HH7nX5Vt4jRUpuWafuCq
 X16YWwOKPVsl+acWq9sNU7KeYx2PFESIMcJdPt2lWZqLRvi+aLdCOCBM1
 WI7Nnx67gxtlQPgPqpgnVgXk1W+kMOerUOy8ir6XJLVqp5O8b5KW3D3HR
 STgo3yUg0wM5NC+ElmqCvoUIXTsV8x2mUyRLUDRAEdiR1/eiYsd09EKZp g==;
X-CSE-ConnectionGUID: jIRI/Tq9QcWmoHx1JeIZeg==
X-CSE-MsgGUID: yeJGj0UkRBiKiBgymEfAjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1810788"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1810788"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 02:31:09 -0700
X-CSE-ConnectionGUID: 8W6eF6PkT5SqJ1AO2AVGig==
X-CSE-MsgGUID: A4Q+AukNQQ+jy9Rl5nff3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4406105"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.112.226.173])
 by orviesa007.jf.intel.com with ESMTP; 27 Oct 2026 02:31:07 -0700
Date: Tue, 27 Oct 2026 17:31:06 +0800
From: "zhao1.liu" <zhao1.liu@intel.com>
To: Hao Xiang <hao.xiang@linux.alibaba.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, pbonzini <pbonzini@redhat.com>,
 mst <mst@redhat.com>, farosas <farosas@suse.de>,
 lvivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] i386/cpu: Rename AVX10_VNNI_INT to AVX10_V1_AUX
Message-ID: <auBvWpwtCZm8vxwb@intel.com>
References: <11491981-b61f-453b-9c12-96ec85063c4a.hao.xiang@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11491981-b61f-453b-9c12-96ec85063c4a.hao.xiang@linux.alibaba.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Xiang,

On Tue, Oct 27, 2026 at 04:30:27PM +0800, Hao Xiang wrote:
> Date: Tue, 27 Oct 2026 16:30:27 +0800
> From: Hao Xiang <hao.xiang@linux.alibaba.com>
> Subject: [PATCH] i386/cpu: Rename AVX10_VNNI_INT to AVX10_V1_AUX
> X-Mailer: [Alimail-Mailagent revision 74][W4_0.2.3][v5ForWebDing][Chrome]
> 
> Rename AVX10_VNNI_INT is to AVX10_V1_AUX to match the most recent version
> of the AVX10.2 spec (revision 7.0) [*].  Intel renamed the CPUID flag to
> apply to a variety of "convert" instructions as well as VNNI instructions.
> 
> The recent KVM patch has renamed AVX10_VNNI_INT to AVX10_V1_AUX. QEMU needs
> to update the CPUID macro, feature property, AVX10.2 feature model and
> Diamond Rapids CPU definition. Keep the CPUID location and bit unchanged.
> 
> [*] Intel® Advanced Vector Extensions 10.2 Architecture Specification 
> (rev 7.0)
> 
> Signed-off-by: Hao Xiang <hao.xiang@linux.alibaba.com>
> ---
>   target/i386/cpu.c | 6 +++---
>   target/i386/cpu.h | 4 ++--
>   2 files changed, 5 insertions(+), 5 deletions(-)

Thanks for this patch! I posted something similar before :)

https://lore.kernel.org/qemu-devel/20260930045237.784060-1-zhao1.liu@intel.com/

(There is one additional change: I add an alias for the vnni-int bit to avoid
 potential API compatibility issues.)

Regards,
Zhao


