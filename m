Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF84C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 06:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnXIK-0003ZE-2J; Thu, 27 Feb 2025 01:22:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tnXIG-0003Ym-JY
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 01:22:48 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tnXIA-0007vz-5X
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 01:22:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740637362; x=1772173362;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=iEVKpF7UnIq52/UIR99jPQQ910Ex7ozCZdIK5ktgMJI=;
 b=i6f9Fe963n/IfMKQSzXOf5epGpDf1YsCgsRjjKGh9/KrQzw0yS0tYShB
 VDKanrN+FTxwJj4YUMY4MEZiBFSSVPQA6N1agwMJCU1bCG2O8ln62JW3s
 dfiqN2EA1GDSwSDRx+XJsv7TNd7UmVNKYn7LpLwLQ6nm+JJCM5wRb7MDU
 IV9IPzRLAnoyAsWf5zK7HelEVZ9zMFIRtqVtkf4TOe5X4HIMN96ukajvx
 clhH7q8jtTkM5zpgo1Eq46q8RCUXk3GWxZQ/ny53vU+xOPMkLwprUg+eW
 pXH7h4OYrkDesDj35L93+ui3dHAf/UkW4ZyPX7SsBvhtg48yyFEBbUWW3 g==;
X-CSE-ConnectionGUID: 7hxO2BLtTYeROAtsiA0qcA==
X-CSE-MsgGUID: LQcE4ai8RL2u76wXmLN78w==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41641799"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; d="scan'208";a="41641799"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 22:22:33 -0800
X-CSE-ConnectionGUID: 7UH/6/VcT46BAs492C6b8g==
X-CSE-MsgGUID: EF1cyGRaSSyDgaK2RmYm+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; d="scan'208";a="147753155"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 26 Feb 2025 22:22:30 -0800
Date: Thu, 27 Feb 2025 14:42:35 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: "Moger, Babu" <babu.moger@amd.com>
Cc: John Allen <john.allen@amd.com>, pbonzini@redhat.com,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, davydov-max@yandex-team.ru,
 Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH v5 1/6] target/i386: Update EPYC CPU model for Cache
 property, RAS, SVM feature bits
Message-ID: <Z8AJW9VJKZXPD2d4@intel.com>
References: <cover.1738869208.git.babu.moger@amd.com>
 <c777bf763a636c8922164a174685b4f03864452f.1738869208.git.babu.moger@amd.com>
 <Z7cLFrIPmrUGuqp4@intel.com> <Z733dp+gePxwDsyW@AUSJOHALLEN.amd.com>
 <7822f511-6b64-417f-830f-3ef912e572d7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7822f511-6b64-417f-830f-3ef912e572d7@amd.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Feb 26, 2025 at 02:28:35PM -0600, Moger, Babu wrote:
> Date: Wed, 26 Feb 2025 14:28:35 -0600
> From: "Moger, Babu" <babu.moger@amd.com>
> Subject: Re: [PATCH v5 1/6] target/i386: Update EPYC CPU model for Cache
>  property, RAS, SVM feature bits
> 
> Hi John,
> 
> On 2/25/25 11:01, John Allen wrote:
> > On Thu, Feb 20, 2025 at 06:59:34PM +0800, Zhao Liu wrote:
> >> And one more thing :-) ...
> >>
> >>>  static const CPUCaches epyc_rome_cache_info = {
> >>>      .l1d_cache = &(CPUCacheInfo) {
> >>>          .type = DATA_CACHE,
> >>> @@ -5207,6 +5261,25 @@ static const X86CPUDefinition builtin_x86_defs[] = {
> >>>                  },
> >>>                  .cache_info = &epyc_v4_cache_info
> >>>              },
> >>> +            {
> >>> +                .version = 5,
> >>> +                .props = (PropValue[]) {
> >>> +                    { "overflow-recov", "on" },
> >>> +                    { "succor", "on" },
> >>
> >> When I checks the "overflow-recov" and "succor" enabling, I find these 2
> >> bits are set unconditionally.
> >>
> >> I'm not sure if all AMD platforms support both bits, do you think it's
> >> necessary to check the host support?
> > 
> > Hi Zhao,
> > 
> > IIRC, we intentionally set these unconditionally since there is no
> > specific support needed from the host side for guests to use these bits
> > to handle MCEs. See the original discussion and rationale in this
> > thread:
> > 
> > https://lore.kernel.org/all/20230706194022.2485195-2-john.allen@amd.com/
> > 
> > However, this discussion only applied to the SUCCOR feature and not the
> > OVERFLOW_RECOV feature and now that you bring it up, I'm second guessing
> > whether we can apply the same thinking to OVERFLOW_RECOV. I think we may
> > want to keep setting the SUCCOR bit unconditionally, but we may want to
> > handle OVERFLOW_RECOV normally. I'll have to track down some old
> > hardware to see how this behaves when the hardware doesn't support it.

Yes, thanks!

> Yes. We need to verify it on pre-EPYC hardware. Please let us know how it
> goes.
> 
> But, this series updates only the EPYC based CPU models. It should not be
> a concern here. Right?

Yes, it doesn't block this series. :-)

Thank you both,
Zhao


