Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6681ED74954
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 01:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5xaT-0005Dy-Sy; Tue, 29 Oct 2024 21:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t5xaR-0005Dq-Qw
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 21:33:27 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t5xaP-0000Ok-4V
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 21:33:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730252005; x=1761788005;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=z2P0U/8mUkG39DfQ491blLTMEkVTyrhIBMZJ2F9krM4=;
 b=Uzi5UNgXvEXts6vO1DYZF47tKaQs5TQkjvxwlfUPcTvsqUz2FscED9/q
 KWUczK/W0vgFBFXNT4d4o1UnyeemJOQ5Ac214/fcs2mN3KOI1AAMII8LE
 oEqEpM7E5gEnEQS5ALAsEvnvITzyWrwScWupocxNDd8cFSe3cqLiqu2Qp
 mWyOdHjR652LxTDN/SwGMwLMhHq3RxpQlUa3Gtmry8GnYQokRNa+N956G
 6D2FnLjPnHJIlmDtu1pQoIZcuNSC+PZlgqmfjSaPxhGDNL4g7MiReMbzv
 e6udw9u5eTislomq4uk2pPmt6AofYaE/7vx+2wSTYO0kSDGP/LTKH6Wws w==;
X-CSE-ConnectionGUID: GwaSdyJxQv6k3gvds/dbRA==
X-CSE-MsgGUID: S9z+pP/lRbCc1Ne11q/6+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="33732060"
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; d="scan'208";a="33732060"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2024 18:33:23 -0700
X-CSE-ConnectionGUID: NLrlIXE5S+qE6bvw0hrvhQ==
X-CSE-MsgGUID: FjN4udZRRqimcEsEfQb1qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; d="scan'208";a="112951107"
Received: from linux.bj.intel.com ([10.238.157.71])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2024 18:33:21 -0700
Date: Wed, 30 Oct 2024 09:28:14 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 xiaoyao.li@intel.com, xuelian.guo@intel.com
Subject: Re: [PATCH 6/6] target/i386: Introduce GraniteRapids-v2 model
Message-ID: <ZyGLrphgAQd6ubKL@linux.bj.intel.com>
References: <20241028024512.156724-1-tao1.su@linux.intel.com>
 <20241028024512.156724-7-tao1.su@linux.intel.com>
 <ZyD4HyATnm1CfZZN@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyD4HyATnm1CfZZN@intel.com>
Received-SPF: none client-ip=198.175.65.14;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Oct 29, 2024 at 10:58:39PM +0800, Zhao Liu wrote:
> On Mon, Oct 28, 2024 at 10:45:12AM +0800, Tao Su wrote:
> > Date: Mon, 28 Oct 2024 10:45:12 +0800
> > From: Tao Su <tao1.su@linux.intel.com>
> > Subject: [PATCH 6/6] target/i386: Introduce GraniteRapids-v2 model
> > X-Mailer: git-send-email 2.34.1
> > 
> > Update GraniteRapids CPU model to add AVX10 and the missing features(ss,
> > tsc-adjust, cldemote, movdiri, movdir64b).
> 
> Do you have datasheet link? It's better to add the link in the commit
> message for easy comparison checking.
> 

Sorry, I think we can get new CPUIDs in ISE[*], but as far as I know,
there is no datasheet which lists all CPUIDs.

[*] https://cdrdv2.intel.com/v1/dl/getContent/671368

> > Tested-by: Xuelian Guo <xuelian.guo@intel.com>
> > Signed-off-by: Tao Su <tao1.su@linux.intel.com>
> > ---
> >  target/i386/cpu.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index adde98fd26..8d72c08b66 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -4375,6 +4375,23 @@ static const X86CPUDefinition builtin_x86_defs[] = {
> >          .model_id = "Intel Xeon Processor (GraniteRapids)",
> >          .versions = (X86CPUVersionDefinition[]) {
> >              { .version = 1 },
> > +            {
> > +                .version = 2,
> > +                .props = (PropValue[]) {
> > +                    { "ss", "on" },
> > +                    { "tsc-adjust", "on" },
> > +                    { "cldemote", "on" },
> > +                    { "movdiri", "on" },
> > +                    { "movdir64b", "on" },
> > +                    { "avx10", "on" },
> > +                    { "avx10-128", "on" },
> > +                    { "avx10-256", "on" },
> > +                    { "avx10-512", "on" },
> > +                    { "avx10-version", "1" },
> > +                    { "stepping", "1" },
> > +                    { /* end of list */ }
> > +                }
> > +            },
> >              { /* end of list */ },
> >          },
> >      },
> > -- 
> > 2.34.1
> > 
> 
> LGTM,
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> 
> BTW, Could you please update the CPU model you added in
> docs/system/cpu-models-x86.rst.inc (section "Preferred CPU models for
> Intel x86 hosts") as well? Although this document has been inactive for
> some time, it hasn't been deprecated, and we can pick it up again to
> continue updating it, helping QEMU users understand QEMU's support for
> x86 CPU/features.

Yes, thanks for this suggestion! I think I can update the doc when I
introduce new CPU models (e.g. upcoming Clearwater Forest).

