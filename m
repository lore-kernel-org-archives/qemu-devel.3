Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8230C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 17:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taIA0-0003Ai-NQ; Tue, 21 Jan 2025 12:35:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pawan.kumar.gupta@linux.intel.com>)
 id 1taI9w-00039A-S3
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 12:35:29 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pawan.kumar.gupta@linux.intel.com>)
 id 1taI9t-0002cf-S0
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 12:35:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737480926; x=1769016926;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=cmXTNmLdDoo5EVsyK037wf7Xn3eU1eS96X+6E8bH0is=;
 b=jnUdWbTDVLYKlC5Gn2iRrjr8pXhWMuUc5ZHXrb1l4ZDLCX4aOGYJL36Z
 M63zxvzt1EjnH7z5xzZRjvnrerV1mUwgy0mPRn8hLhpHj7kIA5UCD08e1
 b10DxyqHy7gqBpbKMSwHutHfSm3zvr6ZKad0t3d1yO1i3TMp58QYMmenC
 ZM1PrTh+QOtdDdpdVM+UsHAvEvfMTeIkWOMDxZqWE3ayFhas2w+jRQzqM
 eavrreApkdf8X/19QLs9ZhA6H09kh1Pm7bi7IIwMARbFBLXyRoWJKWXAo
 66xupZfCYpcXkDdb8YH2dg0bEdrqYrZg44eM8R2ICPtre97ynLkz/YRS5 A==;
X-CSE-ConnectionGUID: lIuPjZwMQvuI+cBpdSkZ5w==
X-CSE-MsgGUID: +l1pZHhaSm+0grGCIbm1og==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="60378205"
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; d="scan'208";a="60378205"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 09:35:21 -0800
X-CSE-ConnectionGUID: xgSqmICtT7+FM2w0QiMMAg==
X-CSE-MsgGUID: d3hDoduvRaOY0FohWtAO2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; d="scan'208";a="106791720"
Received: from mnoman-mobl1.amr.corp.intel.com (HELO desk) ([10.125.145.99])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 09:35:21 -0800
Date: Tue, 21 Jan 2025 09:34:58 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Tao Su <tao1.su@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, imammedo@redhat.com,
 xiaoyao.li@intel.com, zhao1.liu@linux.intel.com, xuelian.guo@intel.com
Subject: Re: [PATCH 1/4] target/i386: Introduce SierraForest-v2 model
Message-ID: <20250121173458.udetzrvr7mq6pjce@desk>
References: <20250121020650.1899618-1-tao1.su@linux.intel.com>
 <20250121020650.1899618-2-tao1.su@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121020650.1899618-2-tao1.su@linux.intel.com>
Received-SPF: none client-ip=198.175.65.9;
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

On Tue, Jan 21, 2025 at 10:06:47AM +0800, Tao Su wrote:
> Update SierraForest CPU model to add LAM, 4 bits indicating certain bits
> of IA32_SPEC_CTR are supported(intel-psfd, ipred-ctrl, rrsba-ctrl,
> bhi-ctrl) and the missing features(ss, tsc-adjust, cldemote, movdiri,
> movdir64b)
> 
> Also add GDS-NO and RFDS-NO to indicate the related vulnerabilities are
> mitigated in stepping 3.

Does this only apply to stepping 3? I don't think Sierra Forest was ever
vulnerable to GDS and RFDS [1].

There are many other vulnerabilities that Sierra Forest is not vulnerable to,
is it really necessary to add the *_NO bits to CPU definitions?

[1] https://www.intel.com/content/www/us/en/developer/topic-technology/software-security-guidance/processors-affected-consolidated-product-cpu-model.html

