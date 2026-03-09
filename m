Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99ECBF3C24E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzakd-0007W2-VC; Mon, 09 Mar 2026 09:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzakW-0007V9-Bl
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:34:20 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzakU-0003po-KT
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773063259; x=1804599259;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=fHnOd4ptp2n2SS6b+dj489eQCBKnaY40Oa6fwRIO9gE=;
 b=UVpFyMCGXdb7XJRv0leIyBBtpbzaX5Mx1kY0SCN0n1vz1goH31B1Mntr
 8X7Ngdh2bAvNNDwYbg0ReOwELB95SmbQZF6fq9qWrZhXdSSFMF3MEAVjM
 28HIIZ1lcnRiAFpvtAi/Na/VOoT8UVodV9Up2Qil6bqnHb1h/dQCz+Pux
 5ZAEeg6tpG18tJhF770uLh4F89z/+jvFn7fBNR/qfH2y7sIqGP517pJCi
 vfPhtFXOLuIni6eMVxDbK7qPDmZxQOyafd65rCMmGmZCt2GY7fEgXRQOt
 PxbMizYujxQMGdTkR0OB/LehylJAETRebXjRAad3/QR9un/TVgmZTonIg Q==;
X-CSE-ConnectionGUID: p+mwHLk+SG6ayoivkaI/6A==
X-CSE-MsgGUID: PbPqKVDOStib28BX/EnyUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="73784769"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="73784769"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 06:34:17 -0700
X-CSE-ConnectionGUID: bFYIW+L0Q/CWDlm/mDSbvA==
X-CSE-MsgGUID: 1GnliaQqQPOXpUFB1pz+Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="219887558"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 09 Mar 2026 06:34:14 -0700
Date: Mon, 9 Mar 2026 22:00:24 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH 2/4] hw/i386/pc: Remove pc_compat_3_0[] array
Message-ID: <aa7SeHGv7y4E6cd8@intel.com>
References: <20260307150042.78030-1-philmd@linaro.org>
 <20260307150042.78030-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260307150042.78030-3-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
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

On Sat, Mar 07, 2026 at 04:00:40PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Sat,  7 Mar 2026 16:00:40 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH 2/4] hw/i386/pc: Remove pc_compat_3_0[] array
> X-Mailer: git-send-email 2.52.0
> 
> The pc_compat_3_0[] array was only used by the pc-q35-3.0
> and pc-i440fx-3.0 machines, which got removed. Remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/hw/i386/pc.h | 3 ---
>  hw/i386/pc.c         | 7 -------
>  2 files changed, 10 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


