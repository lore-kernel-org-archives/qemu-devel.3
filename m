Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D8FC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 08:44:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEPmR-0002kE-3I; Tue, 04 Jun 2024 04:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sEPmP-0002k3-OS
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 04:44:29 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sEPmO-0005Mw-35
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 04:44:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717490668; x=1749026668;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=cnxSJ8ziyTSI8m54PMa/4pI6Kz5sXTiDeaTZk0G1aDg=;
 b=nK+nWRLQJHLsxkt9+y+E1lL+G6SFmIpvrzCHEjzKufLhIprL0QV7MeXX
 xcETSuV+1upNfjs/70W6iYeJySNDmUijWiMgT85pzaQ5lHoEaduhcPTmj
 Zfk26c3OPQXYXd08GMB8/wJwDjN1wAjZ/dJj1xrZOOFIxtalMbHwCIkl6
 1S0chkier15oi2Dro3ewKwy1ar2hoiVYT7OQclpMRe3VlU5bi+2zAFOs1
 RjdY97bufGWbRhRTZWc90l5neMHoTFrvIn1GWzPmXPOFgWRxcPP82cLHH
 t/Fhx+0Qq9vushL2txSDrD6dtP1WsMlvx86hJt7d6BLR1+36AL3GC/kSZ Q==;
X-CSE-ConnectionGUID: dg+wACMjQNC1E8iXXn+7xg==
X-CSE-MsgGUID: 0zvqzdKCR+qkcKFaoGUzfQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="13970929"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="13970929"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2024 01:44:26 -0700
X-CSE-ConnectionGUID: z8JNVk9cSHS5hLlVWaPyvw==
X-CSE-MsgGUID: MlW2zfMtSY6ATSqvFrEc2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="42268122"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 04 Jun 2024 01:44:23 -0700
Date: Tue, 4 Jun 2024 16:59:49 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH-for-9.0?] docs: i386: pc: Update maximum CPU numbers for
 PC Q35
Message-ID: <Zl7XhRvpxQNy+vna@intel.com>
References: <20240412085358.731560-1-zhao1.liu@linux.intel.com>
 <305d659b-d4d6-4681-bdad-cd869e552333@linaro.org>
 <20240602092857-mutt-send-email-mst@kernel.org>
 <77840065-1ad4-42bc-a19c-181ac7d63cf1@linaro.org>
 <Zl3_x-HIuzcTwXlw@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zl3_x-HIuzcTwXlw@redhat.com>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
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

Hi Michael, Daniel, and Philippe,

On Mon, Jun 03, 2024 at 06:39:19PM +0100, Daniel P. Berrangé wrote:
> Date: Mon, 3 Jun 2024 18:39:19 +0100
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: Re: [PATCH-for-9.0?] docs: i386: pc: Update maximum CPU numbers
>  for PC Q35
> 
> On Mon, Jun 03, 2024 at 07:31:47PM +0200, Philippe Mathieu-Daudé wrote:
> > Hi Michael,
> > 
> > On 2/6/24 15:30, Michael S. Tsirkin wrote:
> > > On Fri, Apr 12, 2024 at 11:57:35AM +0200, Philippe Mathieu-Daudé wrote:
> > > > Hi Zhao,
> > > > 
> > > > On 12/4/24 10:53, Zhao Liu wrote:
> > > > > From: Zhao Liu <zhao1.liu@intel.com>
> > > > > 
> > > > > Commit e4e98c7eebfa ("pc: q35: Bump max_cpus to 4096 vcpus") increases
> > > > > the supported CPUs for PC Q35 machine.
> > > > > 
> > > > > Update maximum CPU numbers for PC Q35 in the document.
> > > > > 
> > > > > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > > > > ---
> > > > >    docs/system/target-i386-desc.rst.inc | 2 +-
> > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/docs/system/target-i386-desc.rst.inc b/docs/system/target-i386-desc.rst.inc
> > > > > index 5ebbcda9db4c..319e540573d3 100644
> > > > > --- a/docs/system/target-i386-desc.rst.inc
> > > > > +++ b/docs/system/target-i386-desc.rst.inc
> > > > > @@ -36,7 +36,7 @@ The QEMU PC System emulator simulates the following peripherals:
> > > > >    -  PCI UHCI, OHCI, EHCI or XHCI USB controller and a virtual USB-1.1
> > > > >       hub.
> > > > > -SMP is supported with up to 255 CPUs.
> > > > > +SMP is supported with up to 255 CPUs (and 4096 CPUs for PC Q35 machine).
> > > > 
> > > > This comment is not accurate since a while, IIUC:
> > > > 
> > > > Up to q35-2.7: 255
> > > > q35-2.8: 288
> > > > q35-8.0+: 1024
> > > > q35-9.0: 4096
> > > 
> > > 
> > > What are you saying here, Philippe? I don't think compat
> > > machine types matter enough to bother with more detail.
> > 
> > My point is I find this description confusing w.r.t. how QEMU behaves:
> 
>   snip
> 
> I think the docs should simply avoid mentioning any limit at all. ie
> 
>    -SMP is supported with up to 255 CPUs.
>    +SMP is supported with a large number of virtual CPUs (upper limit is
>     configuration dependent)

I agree, the limit may also be different for different scenarios, and it
is not appropriate to describe it in detail.

Sorry I forgot that this patch has been merged in by Thomas for me
(838f82468a12), and I can modify it with a new patch based on Daniel's
suggestion.

Thanks,
Zhao


