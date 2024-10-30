Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81FC9D2AB2C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 08:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t64W3-00029z-TB; Wed, 30 Oct 2024 04:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t64W1-00029k-63
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 04:57:21 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t64Vy-0003MJ-WB
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 04:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730278639; x=1761814639;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=gnQAA5U0KTcw0z2+r+5S6MD0e6ySVmg4Mc0bTHzLNAU=;
 b=md3tAB32KVOzBEDi4VZnT1Kp3FlZJFIMllTavmedY00LONCzUqR/fsEf
 iiVuVp3OoL9nxJKJnoKSU1XSuBsxhdaI5/SSnvGoIinDAyRNaKp9QShbp
 wUIIkJFDKd0AU0IPhWQWjzemnTi+j5/haCYvHzQVAKfafKReQAoIYtjsp
 hCSMCnriLZtDEVODipuhx9pakC/SveLfxdCZm7c/K29l424wjmtcT2b64
 rNsz6evGeC7JnUC3MhJYICaP2BwEz6MP5dZO5fHo0h6P0wILYVOubp1Om
 I+pBNGDalEj+kXSBHyv+AfJpw21NzW1ogsJUcbZwBh3owF6gKmJxPePXL g==;
X-CSE-ConnectionGUID: 4vXqnbW7Tmux/hc1diJoFQ==
X-CSE-MsgGUID: wR16qGZwT8erNfm8BlDo7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="33894873"
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; d="scan'208";a="33894873"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2024 01:57:14 -0700
X-CSE-ConnectionGUID: Bl8qx19qQcKBTRTNLZ4APA==
X-CSE-MsgGUID: x9+jm6q8QeKMUYEVpHXRcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; d="scan'208";a="119718797"
Received: from linux.bj.intel.com ([10.238.157.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2024 01:57:13 -0700
Date: Wed, 30 Oct 2024 16:52:07 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Zhao Liu <zhao1.liu@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH v2 0/8] Add AVX10.1 CPUID support and GraniteRapids-v2
 model
Message-ID: <ZyHzt9Cig4egc2OL@linux.bj.intel.com>
References: <20241029151858.550269-1-pbonzini@redhat.com>
 <ZyGlhjFULPac5hpi@linux.bj.intel.com>
 <CABgObfbrKz1=bqdRYfZB7t5e8_Azr8Y0j_Jr1Sw__7-EA-OzMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfbrKz1=bqdRYfZB7t5e8_Azr8Y0j_Jr1Sw__7-EA-OzMQ@mail.gmail.com>
Received-SPF: none client-ip=192.198.163.12;
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

On Wed, Oct 30, 2024 at 09:35:43AM +0100, Paolo Bonzini wrote:
> Il mer 30 ott 2024, 04:23 Tao Su <tao1.su@linux.intel.com> ha scritto:
> 
> > > I don't have a Granite Rapids machine, so please test! :)
> >
> > I test it on Granite Rapids and all meet expection with my minor changes on
> > patch4 :)
> >
> 
> Thanks, can you send v3?

Sure, I will.

