Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCE5FF60CF
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 06:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7SqE-0004Uv-A4; Tue, 31 Mar 2026 02:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1w7SqC-0004UV-RJ
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 02:44:44 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1w7Sq9-0007mD-SZ
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 02:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774939482; x=1806475482;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=NIZmITwPrx3yfBkgUoA2ioNPe27dBnTRIYPL2hRxjrk=;
 b=Xam4EwORt3ZsQ17yLETzc4RsMN7aESEzroXpMOh+n0VWhYOAYkX5unCV
 4na3FFTfu96hWkbzzP8oUQpSed4nnYh9G3u/sjDCJEOIjwh4jn9cgKpBU
 IZkYN+XeWvrkenH8XP3ixnNXSGE/TVd+D2F+DZesXpEVJ8S0qhKg5epxS
 hDTmwsCDrR7nAxcPBwVlMwWcv5PsYnapT2a95UyFXljqgc/MQnyxMgkY4
 7k2xji/FYTJSr4nKKcXGBrFla2WHmc8BrI4yJCYqWjoATxOWbLUOGRLgn
 NN4WbvMdO1hAp13gVc9/epeKVjP+B59xgIslz4vFCMowzMsQLK2DEKbIJ Q==;
X-CSE-ConnectionGUID: x3VZmSy4S9aPYnZ62wRyYg==
X-CSE-MsgGUID: a6pF4CCnTqaCwFGZarKJ0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="78534284"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="78534284"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 23:44:38 -0700
X-CSE-ConnectionGUID: c32xTi+rSduhGzSGilEe4A==
X-CSE-MsgGUID: 3Z+iHuIoSXShJDZ1j6C7VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="231089432"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 30 Mar 2026 23:44:36 -0700
Date: Tue, 31 Mar 2026 15:10:55 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] target/i386/cpu.c: Correct minor grammar error in warning
Message-ID: <actzf9auXgB/4cha@intel.com>
References: <20260330151309.1786787-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260330151309.1786787-1-peter.maydell@linaro.org>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
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

On Mon, Mar 30, 2026 at 04:13:09PM +0100, Peter Maydell wrote:
> Date: Mon, 30 Mar 2026 16:13:09 +0100
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: [PATCH] target/i386/cpu.c: Correct minor grammar error in warning
> X-Mailer: git-send-email 2.43.0
> 
> Fix a minor error in the grammar of the warning messages
> produced if both MPX and APX are enabled:
> 
> $ ./build/x86/qemu-system-x86_64   -cpu max -accel qtest -S
> qemu-system-x86_64: warning: this feature conflicts with APX: CPUID[eax=07h,ecx=00h].EBX.mpx [bit 14]
> qemu-system-x86_64: warning: this feature conflicts with MPX: CPUID[eax=07h,ecx=01h].EDX.apxf [bit 21]
> 
> Fixes: 91bc4d81078a ("i386/cpu: Add APX EGPRs into xsave area")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Thanks!

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> ---
> As a side note, it seems a bit harsh to turn off *both*
> the conflicting features if they're both set, rather than
> removing only the older one.

Yes, it's a bit harsh. For hardware-accelerated hypervisors, APXF and
MPX are not to coexist (since hardware that supports APXF has already
abandoned MPX).

This check and its handling actually targeted to TCG (preparing for TCG
APXF support).

Well, as I understand it, if both are treated as purely simulated
features, it’s hard to say which one has higher priority. Moreover, in
the cases where both are enabled, at least one of the features is
explicitly specified by the user, but determining exactly which one—or
whether both—was specified by the user is too complicated... So, for
simplicity, I dropped both of them.

Regards,
Zhao


