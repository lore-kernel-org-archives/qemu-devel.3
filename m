Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942FDC02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 04:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taSQP-0003LJ-3I; Tue, 21 Jan 2025 23:33:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pawan.kumar.gupta@linux.intel.com>)
 id 1taSQN-0003L7-Gw
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 23:33:07 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pawan.kumar.gupta@linux.intel.com>)
 id 1taSQL-000775-6d
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 23:33:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737520385; x=1769056385;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=/yxkAvJRbypz92v/vB2rv4ucDx08n8mSWSZXugsEP6g=;
 b=m6NDc/AB0ZQ/f1nULFReMyyIA7Mb7mhpt82eUicYQ4/5x7+wTlqksBcL
 32fQIZMQFmD+0NnitoINMFEO+l6w4O/SAPphmLc4rcZQnveUZRV59mfdz
 ptrYkd3fJ2FX5iiEZmMwKxDoRKEO+yOBb7hYA9uefTWbUfW73BfB7xEsH
 VDgOO/1IRcQon+6XForAE+Dkwx3jQEtOTzbMeAF7+HSCxQ2odAr6HlLy1
 xljsLNwRkp5R8Nl6GIbst88tsVWM4SgILDmFAK+WGfhEfuWdjkOkFDKPc
 zaPL5dfAfp5DUphu7HDzu9BQZHsOgvQsOCviPr4TlF699or9abo2S6/be Q==;
X-CSE-ConnectionGUID: 5QY+yBPdTQupHkuR+PsQEQ==
X-CSE-MsgGUID: zZtd2bJxQmuV1yIK8JTatg==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="25566461"
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; d="scan'208";a="25566461"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 20:33:00 -0800
X-CSE-ConnectionGUID: WptrvI7jT/2PvZtAn2n85w==
X-CSE-MsgGUID: IniWmpuKQ2uEPxkd+6FD5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="137892969"
Received: from mnoman-mobl1.amr.corp.intel.com (HELO desk) ([10.125.145.99])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 20:33:00 -0800
Date: Tue, 21 Jan 2025 20:32:48 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Tao Su <tao1.su@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, imammedo@redhat.com,
 xiaoyao.li@intel.com, zhao1.liu@linux.intel.com, xuelian.guo@intel.com
Subject: Re: [PATCH 1/4] target/i386: Introduce SierraForest-v2 model
Message-ID: <20250122043248.7dsnczy4rojyhdeg@desk>
References: <20250121020650.1899618-1-tao1.su@linux.intel.com>
 <20250121020650.1899618-2-tao1.su@linux.intel.com>
 <20250121173458.udetzrvr7mq6pjce@desk>
 <Z5BG9aEO3zSg6Fkg@linux.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5BG9aEO3zSg6Fkg@linux.bj.intel.com>
Received-SPF: none client-ip=192.198.163.16;
 envelope-from=pawan.kumar.gupta@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On Wed, Jan 22, 2025 at 09:16:37AM +0800, Tao Su wrote:
> On Tue, Jan 21, 2025 at 09:34:58AM -0800, Pawan Gupta wrote:
> > On Tue, Jan 21, 2025 at 10:06:47AM +0800, Tao Su wrote:
> > > Update SierraForest CPU model to add LAM, 4 bits indicating certain bits
> > > of IA32_SPEC_CTR are supported(intel-psfd, ipred-ctrl, rrsba-ctrl,
> > > bhi-ctrl) and the missing features(ss, tsc-adjust, cldemote, movdiri,
> > > movdir64b)
> > > 
> > > Also add GDS-NO and RFDS-NO to indicate the related vulnerabilities are
> > > mitigated in stepping 3.
> > 
> > Does this only apply to stepping 3? I don't think Sierra Forest was ever
> > vulnerable to GDS and RFDS [1].
> > 
> 
> On the real machine, stepping 0 does not set GDS_NO and RFDS_NO, but
> stepping 3 does.

Ah, I see. Thanks for clarifying.

> 
> > There are many other vulnerabilities that Sierra Forest is not vulnerable to,
> > is it really necessary to add the *_NO bits to CPU definitions?
> > 
> > [1] https://www.intel.com/content/www/us/en/developer/topic-technology/software-security-guidance/processors-affected-consolidated-product-cpu-model.html
> 
> *_NO bits indicate processor is not affected by *, so adding these to the
> CPU model will prevent the guest OS (using the CPU model) from trying to
> use related software mitigation, which I think is reasonable.

Ok, thanks. I got it mixed up with "-cpu host" option.

