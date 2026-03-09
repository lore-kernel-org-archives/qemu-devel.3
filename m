Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57A2F3C260
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzajN-0006t5-Mm; Mon, 09 Mar 2026 09:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzajM-0006sA-8h
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:33:08 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzajK-0003cf-C5
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773063186; x=1804599186;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=TwOPo2xU+wo6JHkAxZR3ET/P45lbHyonSTKmFVyud18=;
 b=RyxHpq/ZNf3ErRMWsy+mvqSimaJr2sr8SiDlzkSWr0vBktXrtbJmUtnP
 I6rkEqIh5zPK4jFLghkrYVZUiiueoPsipVgYqVk6jSR5Fqn/jK5bypkA+
 UUzznab5gs53A4P+s/EGH6dwqNxlmV3/EHl56UbgCZZQtDJ86H3HCJYDV
 G9DeK3FIOIVkGs7nl1B8y9OripMUmboSVI+XmfUcJ2vvGC8oLRkgAOokG
 knGDolPdm3anSSeg/i7XPR1JVJs3UsI48i5ON2h/9vmdkKq23kug5w+vE
 bn8O8mb/Hu0vSaWR8d9WF6y30ZtlGJpHBxR2fZJa6FKzDh2QYmUB7veEk A==;
X-CSE-ConnectionGUID: SPkaKZuaR96IOLbj9yjEvw==
X-CSE-MsgGUID: EMasAXnrQzKHD52/YIZxMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="74196027"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="74196027"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 06:33:05 -0700
X-CSE-ConnectionGUID: 4uhL1T7OR5esRq4lEOdNFQ==
X-CSE-MsgGUID: B2v0VP5uSJqAD49PJLkiag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="223856843"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 09 Mar 2026 06:33:03 -0700
Date: Mon, 9 Mar 2026 21:59:12 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH 1/4] hw/i386/pc: Remove deprecated pc-q35-3.0 and
 pc-i440fx-3.0 machines
Message-ID: <aa7SMJu4AkZaryZC@intel.com>
References: <20260307150042.78030-1-philmd@linaro.org>
 <20260307150042.78030-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260307150042.78030-2-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
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

On Sat, Mar 07, 2026 at 04:00:39PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Sat,  7 Mar 2026 16:00:39 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH 1/4] hw/i386/pc: Remove deprecated pc-q35-3.0 and
>  pc-i440fx-3.0 machines
> X-Mailer: git-send-email 2.52.0
> 
> These machines has been supported for a period of more than 6 years.
> According to our versioned machine support policy (see commit
> ce80c4fa6ff "docs: document special exception for machine type
> deprecation & removal") they can now be removed.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/i386/pc_piix.c | 9 ---------
>  hw/i386/pc_q35.c  | 9 ---------
>  2 files changed, 18 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


