Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8260DC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 14:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFDvu-0004Qd-VW; Thu, 06 Jun 2024 10:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sFDvt-0004PP-8b
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 10:17:37 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sFDvq-0006KS-JM
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 10:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717683455; x=1749219455;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=iFYqS6FaaMagxj2aVkDePpIWRl7AOlMweYXWzmtE8Vo=;
 b=LisLjuwJCSAY7S16WbpQ64FzFdLYUDsWCY8rZvWn8DApp7AY/yvuAh9g
 XKC5juAd6Veb+teHDy3pqjB8YDT+j7ironYHAEN9wWICnMBLQjzkRNu5+
 SNeui2AcoNxxv1AXPsdMTXbfsSxO+AZH13VTMb22lwQ5uLwYkLfEW3z/T
 XMRj/ukfi7ob3PdEs4Ce2gPY4xyBjdM6vPbwUe6uydRQMv9rCUAmb387e
 5zW2dJXFeAfJ8si9Mhxb+ZelyefeXudEJvbMSZdyAUDby974+yOTAp18g
 VVDxnCKX6r2mhkxkHc/O+ngpprRoOqZ3UF2X+NFuZJcVCp9nZgSH7xvyO A==;
X-CSE-ConnectionGUID: h0BEKffZTJaty5+vIBREbg==
X-CSE-MsgGUID: rpUALWxUQrmYYWT/TGZmeQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="24925091"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; d="scan'208";a="24925091"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2024 07:17:32 -0700
X-CSE-ConnectionGUID: YCED9OpgS72Mgpnrc4GWrA==
X-CSE-MsgGUID: ngpK5DE/QnKiBFVsIvqp2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; d="scan'208";a="37838414"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 06 Jun 2024 07:17:29 -0700
Date: Thu, 6 Jun 2024 22:32:56 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH] tracetool: Remove unused vcpu.py script
Message-ID: <ZmHImNd5HIcvrHJd@intel.com>
References: <20240606102631.78152-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240606102631.78152-1-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Jun 06, 2024 at 12:26:31PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu,  6 Jun 2024 12:26:31 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH] tracetool: Remove unused vcpu.py script
> X-Mailer: git-send-email 2.41.0
> 
> vcpu.py is pointless since commit 89aafcf2a7 ("trace:
> remove code that depends on setting vcpu"), remote it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  meson.build                   |  1 -
>  scripts/tracetool/__init__.py |  8 +----
>  scripts/tracetool/vcpu.py     | 59 -----------------------------------
>  3 files changed, 1 insertion(+), 67 deletions(-)
>  delete mode 100644 scripts/tracetool/vcpu.py

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


