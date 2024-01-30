Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94788C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 13:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUoJD-0008Qm-S6; Tue, 30 Jan 2024 08:37:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1rUoJ5-0008Gf-Of
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 08:37:45 -0500
Received: from mgamail.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1rUoJ3-0007Af-Ks
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 08:37:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706621861; x=1738157861;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ohn+FQl6tK/bQGAiwlv3FqL+/7S/2UDDjw0qgOmhXt8=;
 b=fYXKkL7/0G0w4l1vU7xP4rzV2+KCKGKYBaJUkiJL34eaA5ZFj/JoAYVp
 6mHh8YELO0rkLRptJusqmYAvbahIRFVBD72S0axI4vB0YD8fiQtEELPRm
 U23aQvactHVLkfmmNtInApGKzVrBi2/RuzkwiCATZAcjk/DkH2EImFZR8
 aqt/iTx+kvK/SYmNJXtJ1VTS0zZSWYLstkBCrU3uvTmXJOqqkn7+qAwNt
 SrV6iZPbgeBPk802U2y8rF4DnqHxtPTbiS2po5CBOZtq1nAXGJqCVKS3U
 v4bIBcF5DVcrMXRmfitbePd6WjMaZzMnaFDHGWCpsP8Nk2AynxrvPfrJC Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="434447339"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; d="scan'208";a="434447339"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2024 05:37:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; d="scan'208";a="30158929"
Received: from linux.bj.intel.com ([10.238.157.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2024 05:37:36 -0800
Date: Tue, 30 Jan 2024 21:34:36 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, xiaoyao.li@intel.com,
 lei4.wang@intel.com, qian.wen@intel.com
Subject: Re: [PATCH v2 6/6] target/i386: Add new CPU model GraniteRapids
Message-ID: <Zbj67L0dbtJSF3xm@linux.bj.intel.com>
References: <20230706054949.66556-1-tao1.su@linux.intel.com>
 <20230706054949.66556-7-tao1.su@linux.intel.com>
 <20240130111459.5718f484@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240130111459.5718f484@imammedo.users.ipa.redhat.com>
Received-SPF: none client-ip=192.55.52.88;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jan 30, 2024 at 11:14:59AM +0100, Igor Mammedov wrote:
> On Thu,  6 Jul 2023 13:49:49 +0800
> Tao Su <tao1.su@linux.intel.com> wrote:
> 
> > The GraniteRapids CPU model mainly adds the following new features
> > based on SapphireRapids:
> > - PREFETCHITI CPUID.(EAX=7,ECX=1):EDX[bit 14]
> > - AMX-FP16 CPUID.(EAX=7,ECX=1):EAX[bit 21]
> 
> it seems the list/definition is not complete, see
> https://lore.kernel.org/kvm/20221125125845.1182922-1-jiaxi.chen@linux.intel.com/
> and those feature bits were merged into QEMU earlier (a9ce107fd0f..d1a11115143)
> 
> were they omited intentionaly?
> 

No, Jiaxi’s patch series includes new feature bits of both Granite Rapids(GNR)
and Sierra Forest(SRF).

GNR contains:
	PREFETCHITI CPUID.(EAX=7,ECX=1):EDX[bit 14]
	AMX-FP16 CPUID.(EAX=7,ECX=1):EAX[bit 21]

SRF contains:
	CMPccXADD CPUID.(EAX=7,ECX=1):EAX[bit 7]
	AVX-IFMA CPUID.(EAX=7,ECX=1):EAX[bit 23]
	AVX-VNNI-INT8 CPUID.(EAX=7,ECX=1):EDX[bit 4]
	AVX-NE-CONVERT CPUID.(EAX=7,ECX=1):EDX[bit 5]

What new platforms support the new features can be found in Table 1-2 of ISE[1].
And the SRF CPU model we submitted[2] contains the four feature bits supported above.

[1] https://cdrdv2.intel.com/v1/dl/getContent/671368
[2] https://lore.kernel.org/all/20231206131923.1192066-1-tao1.su@linux.intel.com/

Thanks,
Tao

