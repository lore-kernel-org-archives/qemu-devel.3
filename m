Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82638C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEWXE-0004m7-QB; Tue, 04 Jun 2024 11:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sEWXD-0004lp-Vi
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:57:16 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sEWXC-0001Zu-By
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717516635; x=1749052635;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=v4OVAHmz4f7xzoZy7YaZ2I7xYcDQ/1vwbEbefxdOg/U=;
 b=EiGg/y+n82AIJBTya1aUyKquSJ0zbw/TD+T9oEZdGodWrpR6+QrqIGjd
 pVMQ7g4MwFmn5ARNHLA2d4QBucoOcI4tfJSHkk3EpNmXxOsU63ytYUzzh
 +Ph0SbZxpGaQotAuFklcrZ+8Zx9BDd0S0iW7vHjy6Tvc9AqiHnzz9IqVz
 iaeFixr6t/vmDMn0vSYjAhYr2AiIhKU66Q1jMalmar3m3XnbzPwdbcNgR
 tDg5jS7Ig04NcW1SmyjT2eYF797g65jrtgUyw0++3bxHKd4l+FUL7caAI
 cML+P2YHidaFJcWDCmJchocDDtaZXqGGufKwRmXQfK63k/qRWrEivtPVe A==;
X-CSE-ConnectionGUID: aHDK8BWjSzqw7xqwBiv8gg==
X-CSE-MsgGUID: NyUUNKXrRJGXYst7r24mWQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14206514"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; d="scan'208";a="14206514"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2024 08:57:13 -0700
X-CSE-ConnectionGUID: sREKLE+PTLiQTSJlhODKYQ==
X-CSE-MsgGUID: 1kmQkQUDR4+A8uQANqZOUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; d="scan'208";a="37359832"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 04 Jun 2024 08:57:10 -0700
Date: Wed, 5 Jun 2024 00:12:36 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH-for-9.0?] docs: i386: pc: Update maximum CPU numbers for
 PC Q35
Message-ID: <Zl889PSvVp0t87mv@intel.com>
References: <20240412085358.731560-1-zhao1.liu@linux.intel.com>
 <305d659b-d4d6-4681-bdad-cd869e552333@linaro.org>
 <20240602092857-mutt-send-email-mst@kernel.org>
 <77840065-1ad4-42bc-a19c-181ac7d63cf1@linaro.org>
 <Zl7WKKN9wGmlVwnX@intel.com>
 <b3567da2-78c7-49b4-a149-075484d0c004@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3567da2-78c7-49b4-a149-075484d0c004@linaro.org>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
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

[snip]

> > > $ qemu-system-i386 -M pc-q35-9.0 -smp 666
> > > Unexpected error in apic_common_set_id() at ../hw/intc/apic_common.c:447:
> > > qemu-system-i386: APIC ID 255 requires x2APIC feature in CPU
> > > Abort trap: 6
> > 
> > For tcg, it needs to set x2apic=on in -cpu.
> 
> Thanks for clarifying. Using error_append_hint() is certainly
> better than aborting or asking on the mailing list (from user
> perspective) ;)

Good idea! Will improve this. ;-)


