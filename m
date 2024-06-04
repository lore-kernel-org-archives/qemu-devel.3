Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D581C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 08:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEPgr-0000VA-KZ; Tue, 04 Jun 2024 04:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sEPgp-0000Uj-4j
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 04:38:43 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sEPgm-00046c-8t
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 04:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717490320; x=1749026320;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=cshJNHRbggpVlGxOm4+cbtf8Va1SHJ3RU0FY+PwbdHA=;
 b=bkagXa1YfIXUqWgJ2+J6Co7lXbxcUioI8BiCBkrNPgJPh17bHzO5nRdc
 toTeUUucKqJXmaQftQAO0SPbgov9M3n5eP8qTTXjUfxizAz07XCbJNJt4
 cU8gCsRLZPdb4V5gzDsyA+XhiFJAsZQeTB1UfllwgNITKmQ5/t9BWU5j5
 YI4g270P8FDse4T2tR1mHv+UEyQQZ+LkYaqx1WgvFYq9Vt5IT9PJ9+jsR
 WNc9zkDCvt6D0bqpGp8sqO2WezY4l8sd6MFb3fVSAVl2cF29KiGgZ93jq
 xpzm4N/PT8AMmqet3fwccYKTxRNy2XFf/+qvb911VkrT6PjYNhrYGEXQx Q==;
X-CSE-ConnectionGUID: OVa54I4MSN+BdjtumHEEtw==
X-CSE-MsgGUID: B2kJko77T8auXPlcnCMU4w==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="14176356"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="14176356"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2024 01:38:37 -0700
X-CSE-ConnectionGUID: VLoP7539Rpu8Ux85abTBbA==
X-CSE-MsgGUID: H3ITjqWrSDmhN4OzeAXtQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="68336179"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 04 Jun 2024 01:38:34 -0700
Date: Tue, 4 Jun 2024 16:54:00 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH-for-9.0?] docs: i386: pc: Update maximum CPU numbers for
 PC Q35
Message-ID: <Zl7WKKN9wGmlVwnX@intel.com>
References: <20240412085358.731560-1-zhao1.liu@linux.intel.com>
 <305d659b-d4d6-4681-bdad-cd869e552333@linaro.org>
 <20240602092857-mutt-send-email-mst@kernel.org>
 <77840065-1ad4-42bc-a19c-181ac7d63cf1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77840065-1ad4-42bc-a19c-181ac7d63cf1@linaro.org>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
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

On Mon, Jun 03, 2024 at 07:31:47PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Mon, 3 Jun 2024 19:31:47 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: Re: [PATCH-for-9.0?] docs: i386: pc: Update maximum CPU numbers
>  for PC Q35
> 
> Hi Michael,
> 
> On 2/6/24 15:30, Michael S. Tsirkin wrote:
> > On Fri, Apr 12, 2024 at 11:57:35AM +0200, Philippe Mathieu-Daudé wrote:
> > > Hi Zhao,
> > > 
> > > On 12/4/24 10:53, Zhao Liu wrote:
> > > > From: Zhao Liu <zhao1.liu@intel.com>
> > > > 
> > > > Commit e4e98c7eebfa ("pc: q35: Bump max_cpus to 4096 vcpus") increases
> > > > the supported CPUs for PC Q35 machine.
> > > > 
> > > > Update maximum CPU numbers for PC Q35 in the document.
> > > > 
> > > > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > > > ---
> > > >    docs/system/target-i386-desc.rst.inc | 2 +-
> > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/docs/system/target-i386-desc.rst.inc b/docs/system/target-i386-desc.rst.inc
> > > > index 5ebbcda9db4c..319e540573d3 100644
> > > > --- a/docs/system/target-i386-desc.rst.inc
> > > > +++ b/docs/system/target-i386-desc.rst.inc
> > > > @@ -36,7 +36,7 @@ The QEMU PC System emulator simulates the following peripherals:
> > > >    -  PCI UHCI, OHCI, EHCI or XHCI USB controller and a virtual USB-1.1
> > > >       hub.
> > > > -SMP is supported with up to 255 CPUs.
> > > > +SMP is supported with up to 255 CPUs (and 4096 CPUs for PC Q35 machine).
> > > 
> > > This comment is not accurate since a while, IIUC:
> > > 
> > > Up to q35-2.7: 255
> > > q35-2.8: 288
> > > q35-8.0+: 1024
> > > q35-9.0: 4096
> > 
> > 
> > What are you saying here, Philippe? I don't think compat
> > machine types matter enough to bother with more detail.
> 
> My point is I find this description confusing w.r.t. how QEMU behaves:
> 
> $ qemu-system-i386 -M pc-q35-2.8 -smp 666
> qemu-system-i386: Invalid SMP CPUs 666. The max CPUs supported by machine
> 'pc-q35-2.8' is 288
> 
> $ qemu-system-i386 -M pc-q35-8.0 -smp 666
> qemu-system-i386: Invalid SMP CPUs 666. The max CPUs supported by machine
> 'pc-q35-8.0' is 288
> 
> $ qemu-system-i386 -M pc-q35-9.0 -smp 666
> Unexpected error in apic_common_set_id() at ../hw/intc/apic_common.c:447:
> qemu-system-i386: APIC ID 255 requires x2APIC feature in CPU
> Abort trap: 6

For tcg, it needs to set x2apic=on in -cpu.


