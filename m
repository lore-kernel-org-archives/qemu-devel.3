Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671BCC3ABBC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 02:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCUIq-0007lc-Gg; Tue, 06 May 2025 22:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCUIn-0007lD-2M; Tue, 06 May 2025 22:14:29 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCUIj-0006s2-1k; Tue, 06 May 2025 22:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746584065; x=1778120065;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=KvQAfyDWczDPXRU/jtSl/imb1MrYRCR86FacqOMd4UY=;
 b=Hx4by5mRD9FZRdZU6x/9Orwxb3/fwo7gf0BvxxDtmpkN+scfKm84lTm+
 P47SgDksK8KPPpUPlFLqhbys3oouRTPaDKVkEUM2JKgQk9q29vdHigmP1
 iItoll2+twCGMPsg9TCTgldsM8S4FayLpPE5RoyvNIxW/ZHK4IFMP2sxy
 xjLGhcpaqrbi8ZdYgM4cFRwHuY0CZGBqSJjEJKm36Uaal9W/3VcoIMsmd
 pTgvG6szHJaxwG1POycZeP20AZzwg5Y9KLQ/C8U6iaHJ8SCiDykMKMXKZ
 +xqdjIfcDzVJR6XtcMbCjSZ8p1ClCYEy7tsW9AVtTDNjM8vTPpqtWuBCy g==;
X-CSE-ConnectionGUID: q0y5cQJ8RkmK1399Ytiwkw==
X-CSE-MsgGUID: h+IhIq++ROaZ8HSOf0g/hQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="70796114"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="70796114"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 19:14:22 -0700
X-CSE-ConnectionGUID: NLRAJY2uSgWgA+bTt6T9FA==
X-CSE-MsgGUID: hGwya+/VToOqB0nhA6Wo4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="140916954"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 06 May 2025 19:14:18 -0700
Date: Wed, 7 May 2025 10:35:19 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, John Snow <jsnow@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 04/19] target/i386/cpu: Remove X86CPU::check_cpuid field
Message-ID: <aBrG55lWMv6HoaN0@intel.com>
References: <20250506143905.4961-1-philmd@linaro.org>
 <20250506143905.4961-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250506143905.4961-5-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Tue, May 06, 2025 at 04:38:50PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Tue,  6 May 2025 16:38:50 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v3 04/19] target/i386/cpu: Remove X86CPU::check_cpuid field
> X-Mailer: git-send-email 2.47.1
> 
> The X86CPU::check_cpuid boolean was only set in the
> pc_compat_2_4[] array, via the 'check=off' property.
> We removed all machines using that array, lets remove
> that CPU property and simplify x86_cpu_realizefn().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  target/i386/cpu.h | 1 -
>  target/i386/cpu.c | 3 +--
>  2 files changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


