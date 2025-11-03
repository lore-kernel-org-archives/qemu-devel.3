Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562F1CCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 14:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFvrJ-0002Rn-S2; Mon, 03 Nov 2025 09:48:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vFvrD-0002NV-Us
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 09:48:33 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vFvr5-00060E-3Y
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 09:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762181303; x=1793717303;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=QQMVc92iReV2dOXLtirTzEnlYOeG5l3KqV8HdzHGiMQ=;
 b=WR4ndEpR9aygBeHerv5cyAAaM82aIGHhVWRA9yvKXC2YKXc+P1Ky4mBG
 gS9a62WtCenD2Lee8uMHsXF9fWIozYoTIT0A/qfbqPXeKjshvoiXT/BVk
 p/JJBJF4audAUHhMSgJVF/TsxV4OzasdlIDcMnKumcpcSToa/knWYTeDC
 GHRo/WE/ZPEPNUg+7WO3SQC8b27Y+cympwzhGYBQoXey8ByZOt7fbRct2
 arS4YQurr7sWA6UH7n2O2socGqKVVutts68e24/yBnXznTAKfSB2A/Q9q
 fAvH6VfXBzLDBCG9ox1caovPsfN0CxWGj2EIl+tbDa9DKnLy2I+r8/P7a g==;
X-CSE-ConnectionGUID: 6CW5Q5LxSRCQucr3mEfI6g==
X-CSE-MsgGUID: TxznXJ71QlefSrrK+QzNYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="68116821"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; d="scan'208";a="68116821"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2025 06:48:16 -0800
X-CSE-ConnectionGUID: JLbePTC/RmK7A7WDatPemA==
X-CSE-MsgGUID: Je5oTFAxQX+NlILCwHDtQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; d="scan'208";a="217521822"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 03 Nov 2025 06:48:15 -0800
Date: Mon, 3 Nov 2025 23:10:28 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v5] hw/i386/pc: Remove PCMachineClass::legacy_cpu_hotplug
 field
Message-ID: <aQjF5PdR0s/WrA3+@intel.com>
References: <20250508133550.81391-3-philmd@linaro.org>
 <20251031142825.179239-1-imammedo@redhat.com>
 <4b92d159-1bcd-5672-977f-6741a9d26c8f@eik.bme.hu>
 <20251103104231.05121741@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103104231.05121741@fedora>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Nov 03, 2025 at 10:42:31AM +0100, Igor Mammedov wrote:
> Date: Mon, 3 Nov 2025 10:42:31 +0100
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: Re: [PATCH v5] hw/i386/pc: Remove
>  PCMachineClass::legacy_cpu_hotplug field
> X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
> 
> On Sat, 1 Nov 2025 00:27:36 +0100 (CET)
> BALATON Zoltan <balaton@eik.bme.hu> wrote:
> 
> [...]
> > > diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> > > index dfb8523c8b..7191854857 100644
> > > --- a/tests/qtest/bios-tables-test-allowed-diff.h
> > > +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> > > @@ -1 +1,43 @@  
> > 
> > Does this belong here?
> thanks for spotting it, it should be a separate preceding patch,

Thanks! I think I see :-) - I should follow the gudience in
tests/qtest/bios-tables-test.c, to split this patch.

> and then expected blobs update patch after this patch,
> that would cleanup bios-tables-test-allowed-diff.h along with new blobs.
> /i.e. as per process described in bios-tables-test.c /

Regards,
Zhao


