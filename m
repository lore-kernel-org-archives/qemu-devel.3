Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF5FC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 15:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzdDA-0001GP-BP; Tue, 01 Apr 2025 11:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tzdD7-0001EF-JJ
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 11:07:30 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tzdD5-0003aY-3c
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 11:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743520047; x=1775056047;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=fnxSm2rjINX8p7vfLwjq9x+kwyj3BOORuHqRgi0hp8c=;
 b=di8Saithh/zSQOwiSTB8WOB1Zcz3zq+NErxCbrbFENnXh88EroSmzCXv
 qVm5BP1PTBN3drQme/8mUme5tB+dq6Mj40SNA/WEWDLTxRvi+P55srPqA
 FQuuGpbpfzMa86YOSjqKvBiEfnkPgsIQcwUqUoqBUht5XeR3YqKT/9HGo
 29ReLYTJvok2hMULmMp+LNZCnKxBa4TDaPOEfKeL2BC8r3JbW1WtpjCA6
 urxlTxw9Bjb17KXqI6mTWu7EfFJNGiH/02OSXClfwGXXEW5UtsGHXuzdN
 9A9letSCnOsN1ZoKkFmQggqSqLl9CJCqbDqqsoF5SxjVvAe2ChL/KbaMl Q==;
X-CSE-ConnectionGUID: eV9QBHgRSl2aB2hxglKpdQ==
X-CSE-MsgGUID: 1KRHTcw/RW2sHdUBDpnIYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="44759042"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="44759042"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2025 08:07:24 -0700
X-CSE-ConnectionGUID: 2rgC88DFRlijT5Py2Zdq3Q==
X-CSE-MsgGUID: +TbYT693SDat9cwitpKYIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="131137322"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 01 Apr 2025 08:07:22 -0700
Date: Tue, 1 Apr 2025 23:27:42 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ewan Hai <ewanhai-oc@zhaoxin.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] target/i386: Fix model number of Zhaoxin YongFeng vCPU
 template
Message-ID: <Z+wF7patYaAgaF4V@intel.com>
References: <20250331080356.1596655-1-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331080356.1596655-1-ewanhai-oc@zhaoxin.com>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, Mar 31, 2025 at 04:03:56AM -0400, Ewan Hai wrote:
> Date: Mon, 31 Mar 2025 04:03:56 -0400
> From: Ewan Hai <ewanhai-oc@zhaoxin.com>
> Subject: [PATCH] target/i386: Fix model number of Zhaoxin YongFeng vCPU
>  template
> X-Mailer: git-send-email 2.34.1
> 
> The model number was mistakenly set to 0x0b (11) in commit ff04bc1ac4.
> The correct value is 0x5b. This mistake occurred because the extended
> model bits in cpuid[eax=0x1].eax were overlooked, and only the base
> model was used.
> 
> This patch corrects the model field.

It's better to add:

Fixes: ff04bc1ac4 ("target/i386: Introduce Zhaoxin Yongfeng CPU model")

> Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
> ---
>  target/i386/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


