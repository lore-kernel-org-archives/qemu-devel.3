Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3EF6C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 03:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta4ri-00011a-CJ; Mon, 20 Jan 2025 22:23:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1ta4rg-00011S-V3
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 22:23:45 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1ta4rd-0001Bu-IQ
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 22:23:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737429821; x=1768965821;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=gH3UQlpCAQSgAMfsyQ1B2t7Q1MY+XsBmzCXbIUxHqpU=;
 b=gwxFLDWRg4+AajMwOU1ixdiS1SdKPpr5LlSrKrzL0IJjnT3OOuzgNFJe
 pW1ldZfFGv3na/PRXCkEcmpXtpNtFt7APVU/4p4YsayF/fx97P0dJDIgJ
 qMKc9p9PGcoIUf5gHPzYqipBfc/8Q6L9oBLBX9ikRJurRepGJkBmMFe++
 zAlcebOty03TsAOFVU6hLXQKtlUlVvG6u6JqaImlQATJnfoiZ70Cfrfrt
 pWuT32EKUqEbCsrmMMlOLnMTIT80pNcqTF09z2cDll1YMEVpInAHMGKR1
 oC4VccgXrjocv1g6gqcI633v0NqNazvSAzrOpS1ZwXuZZuOoFzeXztJt3 A==;
X-CSE-ConnectionGUID: UDifqTmcRjCc6Qb7Q1bPoQ==
X-CSE-MsgGUID: LoD1eOROTV+LTMaUjyfvQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="49244415"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="49244415"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2025 19:23:38 -0800
X-CSE-ConnectionGUID: xjarB+vmSQSG84og4uv4Mg==
X-CSE-MsgGUID: VHa4Mc4eQry+KyhBUbs46A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="110721590"
Received: from linux.bj.intel.com ([10.238.157.71])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2025 19:23:36 -0800
Date: Tue, 21 Jan 2025 11:18:38 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, imammedo@redhat.com,
 xiaoyao.li@intel.com, zhao1.liu@linux.intel.com, xuelian.guo@intel.com
Subject: Re: [PATCH 4/4] docs: Add GNR, SRF and CWF CPU models
Message-ID: <Z48SDoe8tDgX+/B1@linux.bj.intel.com>
References: <20250121020650.1899618-1-tao1.su@linux.intel.com>
 <20250121020650.1899618-5-tao1.su@linux.intel.com>
 <a945e893-8d27-b1a3-3f3e-d9b04080c70d@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a945e893-8d27-b1a3-3f3e-d9b04080c70d@eik.bme.hu>
Received-SPF: none client-ip=192.198.163.10;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Jan 21, 2025 at 04:12:48AM +0100, BALATON Zoltan wrote:
> On Tue, 21 Jan 2025, Tao Su wrote:
> > Update GraniteRapids, SierraForest and ClearwaterForest CPU models in
> > section "Preferred CPU models for Intel x86 hosts".
> > 
> > Also introduce bhi-no, gds-no and rfds-no in doc.
> > 
> > Suggested-by: Zhao Liu <zhao1.liu@intel.com>
> > Signed-off-by: Tao Su <tao1.su@linux.intel.com>
> > ---
> > docs/system/cpu-models-x86.rst.inc | 42 ++++++++++++++++++++++++++++++
> > 1 file changed, 42 insertions(+)
> > 
> > diff --git a/docs/system/cpu-models-x86.rst.inc b/docs/system/cpu-models-x86.rst.inc
> > index ba27b5683f..f0b5189d91 100644
> > --- a/docs/system/cpu-models-x86.rst.inc
> > +++ b/docs/system/cpu-models-x86.rst.inc
> > @@ -71,6 +71,16 @@ mixture of host CPU models between machines, if live migration
> > compatibility is required, use the newest CPU model that is compatible
> > across all desired hosts.
> > 
> > +``ClearwaterForest``
> > +    Intel Xeon Processor (ClearwaterForest, 2025)
> > +
> > +``SierraForest``, ``SierraForest-v2``
> > +    Intel Xeon Processor (SierraForest, 2024), SierraForest-v2 matigates
> 
> Typo, do you mean "mitigates"?

Yes, thanks for pointing out.


