Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20802C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 13:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVAH1-0005sJ-Mu; Wed, 31 Jan 2024 08:05:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1rVAGx-0005pG-1W
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 08:04:59 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1rVAGt-0002Vz-3C
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 08:04:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706706294; x=1738242294;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=cDyS2Uz3gr0xtzndvP1kzwH1HdNB+UWPOpj/77gNgm4=;
 b=Pt7yXfpIjrBVqhzObByTOrOG/IrhvIIA3eBP38/62Bxws6rrBwv8L+AE
 onpJcFM/Z+1uNnUAU36x2YplcYw5bNoX7oIyU2NAa9wdWZdyqyoMSL5JC
 KCddpXMLYgeUHfhAYiSL9xrKc4SxrhnvjnldkenHtwKjW+uvwuEV2RP/p
 NA04JwDPrO5oMYyasd7bPWy9EflhLeHs4cVLU+m/e+IGn3y4zEGTiKe2S
 DYPIjbBlTgtaTiEYSZd3feAbW35fz9KUflGK1IlwB4elmu9a3LQZdTkZH
 U+SXWu3HCXm2WB8rDyBb2mmKIpJ8JwLljgfkshmioFGBUvCdyvo10fh+8 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="402444541"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; d="scan'208";a="402444541"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 05:04:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="4030984"
Received: from linux.bj.intel.com ([10.238.157.71])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 05:04:39 -0800
Date: Wed, 31 Jan 2024 21:01:38 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, xiaoyao.li@intel.com,
 lei4.wang@intel.com, qian.wen@intel.com
Subject: Re: [PATCH v2 6/6] target/i386: Add new CPU model GraniteRapids
Message-ID: <ZbpEsu88L/Q/GMWw@linux.bj.intel.com>
References: <20230706054949.66556-1-tao1.su@linux.intel.com>
 <20230706054949.66556-7-tao1.su@linux.intel.com>
 <20240130111459.5718f484@imammedo.users.ipa.redhat.com>
 <Zbj67L0dbtJSF3xm@linux.bj.intel.com>
 <20240131133431.11e3c3f8@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240131133431.11e3c3f8@imammedo.users.ipa.redhat.com>
Received-SPF: none client-ip=192.55.52.120;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On Wed, Jan 31, 2024 at 01:34:31PM +0100, Igor Mammedov wrote:
> On Tue, 30 Jan 2024 21:34:36 +0800
> Tao Su <tao1.su@linux.intel.com> wrote:
> 
> > On Tue, Jan 30, 2024 at 11:14:59AM +0100, Igor Mammedov wrote:
> > > On Thu,  6 Jul 2023 13:49:49 +0800
> > > Tao Su <tao1.su@linux.intel.com> wrote:
> > >   
> > > > The GraniteRapids CPU model mainly adds the following new features
> > > > based on SapphireRapids:
> > > > - PREFETCHITI CPUID.(EAX=7,ECX=1):EDX[bit 14]
> > > > - AMX-FP16 CPUID.(EAX=7,ECX=1):EAX[bit 21]  
> > > 
> > > it seems the list/definition is not complete, see
> > > https://lore.kernel.org/kvm/20221125125845.1182922-1-jiaxi.chen@linux.intel.com/
> > > and those feature bits were merged into QEMU earlier (a9ce107fd0f..d1a11115143)
> > > 
> > > were they omited intentionaly?
> > >   
> > 
> > No, Jiaxi’s patch series includes new feature bits of both Granite Rapids(GNR)
> > and Sierra Forest(SRF).
> > 
> > GNR contains:
> > 	PREFETCHITI CPUID.(EAX=7,ECX=1):EDX[bit 14]
> > 	AMX-FP16 CPUID.(EAX=7,ECX=1):EAX[bit 21]
> > 
> > SRF contains:
> > 	CMPccXADD CPUID.(EAX=7,ECX=1):EAX[bit 7]
> > 	AVX-IFMA CPUID.(EAX=7,ECX=1):EAX[bit 23]
> > 	AVX-VNNI-INT8 CPUID.(EAX=7,ECX=1):EDX[bit 4]
> > 	AVX-NE-CONVERT CPUID.(EAX=7,ECX=1):EDX[bit 5]
> 
> > What new platforms support the new features can be found in Table 1-2 of ISE[1].
> > And the SRF CPU model we submitted[2] contains the four feature bits supported above.
> Thanks,
> 
> for future patches: 
> this kind of info should be part of commit message incl.
> spec/doc title/revision it's coming from with a specific
> chapter/table also mentioned. This way whoever reads it
> later won't have to ask or spend time for searching where
> it comes from.
> 
> And maybe also have a comment close to new code,
> aka like we do for ACPI patches.

Got it, thanks for the suggestion! This is really useful, I will do.

Thanks,
Tao

>  
> > [1] https://cdrdv2.intel.com/v1/dl/getContent/671368
> > [2] https://lore.kernel.org/all/20231206131923.1192066-1-tao1.su@linux.intel.com/
> > 
> > Thanks,
> > Tao
> > 
> 

