Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813CDF3C24E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzaoA-00009l-AM; Mon, 09 Mar 2026 09:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzao0-00007x-Su
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:37:59 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzanz-0004l3-Gr
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773063476; x=1804599476;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=UsIMdqGIlBsI0z1OQrsALFC8NM5aOfvaED+B+3JTQ8U=;
 b=bwwOyJIOC5YC63r8goG/bE/rIAFEkh8n83dxKlG9zmFZefTquc7SaGE+
 ykkxM5RYv7aQEx8SvYIkoXI4oFiHHxep1GncqcAJR/EZ+CPuZsKYV6NVX
 ERjp7OkC/1Q9S7tXHHkOqm+bR4N7NSTkzxq8/zMM8MG0fmK9YmhwvH9CB
 kL/smLr3i/PE2JcbYok+SzGOu+RmDmv2au1FKqdD9vE0zDrUrvsZz+3S9
 w8K35osVfHGf6zV4lNFCaOhu4yZogM6uqrW9nk58rn09ycmf5/MIGieSK
 T8mgcgBM5SbH1buLUym/0gCgGbmgPnb+X+lJiNGuGLlQogeZ9z+8B3Sn7 A==;
X-CSE-ConnectionGUID: qaQmLB5JSvqmyZK66RUTYQ==
X-CSE-MsgGUID: yVb+UhraTgWI2w+BsNkIXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="77964846"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="77964846"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 06:37:53 -0700
X-CSE-ConnectionGUID: 0iWDL1uDS7aVwrhwoLW5Cg==
X-CSE-MsgGUID: lc5Zjt8hTLGlHxUH/oOhIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="222421966"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 09 Mar 2026 06:37:51 -0700
Date: Mon, 9 Mar 2026 22:04:00 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH 4/4] hw/core/machine: Remove the hw_compat_3_0[] array
Message-ID: <aa7TUIW8IsxMzg9y@intel.com>
References: <20260307150042.78030-1-philmd@linaro.org>
 <20260307150042.78030-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260307150042.78030-5-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

On Sat, Mar 07, 2026 at 04:00:42PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Sat,  7 Mar 2026 16:00:42 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH 4/4] hw/core/machine: Remove the hw_compat_3_0[] array
> X-Mailer: git-send-email 2.52.0
> 
> The hw_compat_3_0[] array was only used by the pc-q35-3.0
> and pc-i440fx-3.0 machines, which got removed. Remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/hw/core/boards.h | 3 ---
>  hw/core/machine.c        | 3 ---
>  2 files changed, 6 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


