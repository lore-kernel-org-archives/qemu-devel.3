Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F5AC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 13:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4hXl-0002Hr-TR; Wed, 08 May 2024 09:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s4hXX-0002D1-Is
 for qemu-devel@nongnu.org; Wed, 08 May 2024 09:41:00 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s4hXU-0001BL-JZ
 for qemu-devel@nongnu.org; Wed, 08 May 2024 09:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715175657; x=1746711657;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=rVzZdj9ZQx0qh0xiVqcJCSv3IOEe/Kg9juF+2C/ILqE=;
 b=DpgJjyY/xByJ+0RzHm7dqKkqguCoDbj5b4Zp8MZ2i4X+RH2aBqagWt5K
 CFLK+uDBRCKowCKwoek1XW7fwbMSXMmn8ydoFcLgVzXYIpf6mtgmCPyPl
 PLr+C+jSN1HQomQdXeIuDa4QVNTY9Ef8IAMCfO+wzhew6OyL9wAI1DH5Z
 /569KZ7wNnjUKVdeo8Gl4BRdksSxr6vnEBiPxPSumE7q619QSzeHpNTqf
 1YJ0tRo3lHBc8fsn4TgYSnX2ouH4a4N/eMrP4pfrxdAIC1sVrPCiRptOS
 TUpFabLQAu1a4zXRk6xYSzP4jbxkPMqm3urh4YJxEf2X6q8tN363jfpIr g==;
X-CSE-ConnectionGUID: J1pUcTMIQa+UOuYx4WW1cg==
X-CSE-MsgGUID: 8Z+m3ARnQ0qePWTeQmacow==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="10905128"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; d="scan'208";a="10905128"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2024 06:40:53 -0700
X-CSE-ConnectionGUID: hGju0X4oT86rjm1xXz/yoA==
X-CSE-MsgGUID: HWno5KErRJm4KpWaEanFTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; d="scan'208";a="28853757"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 08 May 2024 06:40:51 -0700
Date: Wed, 8 May 2024 21:55:04 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Mads Ynddal <mads@ynddal.dk>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] scripts/simpletrace: Mark output with unstable timestamp
 as WARN
Message-ID: <ZjuEOPPbGaZgY6gG@intel.com>
References: <20240508043229.3433128-1-zhao1.liu@intel.com>
 <210757c3-c949-4dd1-bd7d-c33db3aa390e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <210757c3-c949-4dd1-bd7d-c33db3aa390e@linaro.org>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.582,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hi Philippe,

On Wed, May 08, 2024 at 03:09:39PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Wed, 8 May 2024 15:09:39 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: Re: [PATCH] scripts/simpletrace: Mark output with unstable
>  timestamp as WARN
> 
> On 8/5/24 06:32, Zhao Liu wrote:
> > In some trace log, there're unstable timestamp breaking temporal
> > ordering of trace records. For example:
> > 
> > kvm_run_exit -0.015 pid=3289596 cpu_index=0x0 reason=0x6
> > kvm_vm_ioctl -0.020 pid=3289596 type=0xffffffffc008ae67 arg=0x7ffeefb5aa60
> > kvm_vm_ioctl -0.021 pid=3289596 type=0xffffffffc008ae67 arg=0x7ffeefb5aa60
> > 
> > Negative delta intervals tend to get drowned in the massive trace logs,
> > and an unstable timestamp can corrupt the calculation of intervals
> > between two events adjacent to it.
> > 
> > Therefore, mark the outputs with unstable timestamps as WARN like:
> > 
> > WARN: skip unstable timestamp: kvm_run_exit cur(8497404907761146)-pre(8497404907761161) pid=3289596 cpu_index=0x0 reason=0x6
> > WARN: skip unstable timestamp: kvm_vm_ioctl cur(8497404908603653)-pre(8497404908603673) pid=3289596 type=0xffffffffc008ae67 arg=0x7ffeefb5aa60
> > WARN: skip unstable timestamp: kvm_vm_ioctl cur(8497404908625787)-pre(8497404908625808) pid=3289596 type=0xffffffffc008ae67 arg=0x7ffeefb5aa60
> > 
> > This would help to identify unusual events.
> > 
> > And skip them without updating Formatter2.last_timestamp_ns to avoid
> > time back.
> 
> Can't we reorder them instead?

I think so...IIUC, when the current event with "wrong" timestamp is
detected, its previous events records have already been output and
cannot be reordered.

Regards,
Zhao



